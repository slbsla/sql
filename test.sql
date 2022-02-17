-- https://sqliteonline.com/

 drop table guar;
 drop table perf; 
 
create table guar
 ( 
  guar_id varchar(10) primary key,
  name varchar(10)
 );
 
 create table perf
 ( 
  perf_id varchar(10) primary key,
  guar_id varchar(10),
  name varchar(10),
  exp_date number,
  fil_date number
 );
 ---
 select * from guar
 select * from perf
 --
 insert into guar values ('1','g1');
 insert into guar values ('2','g1'); 
 insert into guar values ('3','g2'); 
 --- c1
 insert into perf values ('1','1', 'p1', 10, 20);
 insert into perf values ('2','1', 'p2', 11, 21);
 insert into perf values ('3','1', 'p3', 12, 20); --*
 --
-- 1  g1 1 p3 12 20 
 
 select g.guar_id, g.name, p.perf_id, p.name, p.exp_date, p.fil_date 
 from  guar g, perf p
 where g.guar_id = p.guar_id 
 and p.exp_date = (
					select max(exp_date) 
					from perf p1
					where g.guar_id = p1.guar_id
				  ); 
 
 --- c2
 insert into perf values ('1','1', 'p1', 12, 22); --*
 insert into perf values ('2','1', 'p2', 12, 21);
 insert into perf values ('3','1', 'p3', 10, 20);
 insert into perf values ('4','2', 'p4', 17, 23);

-- 1  g1 1 p1 12 22 
 