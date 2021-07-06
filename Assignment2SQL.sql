
--Display product name, customer name and discount amount where discount has been provided (discount_amt > 0) using
Subquery
JOIN
=> JOIN
select 
product_name,first_name,discount_amt 
from 
product 
inner join 
sales on product.product_id = sales.product_id 
inner join 
customer on sales.customer_id = customer.customer_id 
where 
discount_amt>0

=> Subquery 
select 
product_name, first_name, discount_amt 
from 
sales s, product p, customer c 
where 
discount_amt > 0
and 
product_name in (
select 
product_name from product
where 
p.product_id=s.product_id)
and 
user_name in (
select 
user_name from customer
where 
c.customer_id=s.customer_id);

 --Display product wise sum of sales amount ordered with highest sales amount on top.
select 
TOP 1 first_name, last_name,net_bill_amt 
from 
customer 
inner join 
sales on customer.customer_id = sales.customer_id 
where net_bill_amt = (
select MAX(net_bill_amt) 
from 
sales)

--Display brand wise sum of sales amount ordered with highest sales amount on top.
select 
brand,sum(net_bill_amt) 
from 
sales inner join product on product.product_id=sales.product_id 
group by 
brand 
order by sum(net_bill_amt) desc

--Display category, brand and product wise sum of sales amount ordered with category, brand and product in ascending order.
select 
category, brand , product_name , sum(net_bill_amt) 
from product inner join sales on sales.product_id = product.product_id group by
category,brand,product_name order by sum(net_bill_amt) asc

--Display product_id and product name from the list of products which have not been billed yet using
Subquery
Select 
product_id, product_name 
From 
product
where 
product_id
Not In 
(select product_id from sales )

JOIN
select
  p.product_id,
  p.product_name
from 
product p
left join 
sales s
on 
p.product_id = s.product_id
where 
s.bill_no 
IS NULL

EXCEPT along with WHERE ___ IN
select
product_id, product_name 
from 
product
where 
product_id 
Not in (select product_id from sales )

JOIN
Select 
p.product_id, p.product_name 
from 
product p
Left join 
sales s
on
p.product_id = s.product_id
except
select 
p.product_id, p.product_name 
from 
product p
Right join 
sales s
ON 
p.product_id = s.product_id



--6 Display list of brands whose products have not been billed yet.
select 
brand
from 
product
where
product_id
Not in (select product_id from sales )




--7 Display all the products’ sales quantity sorting by sales quantity. If it has no sales, show it as null.
select  p.product_name, s.qty
from product p
full outer join sales s
on p.product_id = s.product_id
order by qty ASC




--8 Display product name and customer name from the list of products which have been purchased by a single customer only.
select p.product_name, cu.customer_name
from sales s
inner join (
           select product_name, count (distinct customer_name) as count from sales
              group by product_name
            having count(distinct customer_name) = 1
           ) 
on p.product_name = p.product_name


--9 Display customer name and the total amount spent of the highest spending customer/s using a combination of JOIN and subquery.
select 
c.first_name, c.last_name ,s.net_bill_amt
from 
customer c 
inner join 
sales s
on 
c.customer_id=s.customer_id
where 
net_bill_amt = (select MAX(net_bill_amt) from sales)



--10 Display customer name, product name whose maximum quantity is sold 
select 
c.first_name, c.last_name, p.product_name, s.qty
from 
customer c 
full 
outer join 
sales s
on 
c.customer_id=s.customer_id
full 
outer join 
product p 
on 
s.product_id = p.product_id
where 
qty = (select MAX(qty) from sales)


EXCEPT along with WHERE ___ IN
select 
product_id, product_name from product
where
product_id Not in 
(select product_id From sales )

JOIN
select 
p.product_id, p.product_name 
from 
product p
left join 
sales s
on 
p.product_id = s.product_id
except
Select 
p.product_id, p.product_name 
from 
product p
RIGHT JOIN 
sales s
ON 
p.product_id = s.product_id

