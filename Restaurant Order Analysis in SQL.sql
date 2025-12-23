CREATE DATABASE restaurant;

USE restaurant;

SELECT * FROM menu_items;
SELECT * FROM order_details;
SELECT * FROM restaurant_db_data_dictionary;

ALTER TABLE menu_items RENAME COLUMN ï»¿menu_item_id TO menu_item_id;

DROP TABLE order_details;

CREATE TABLE order_details (
  order_details_id INT NOT NULL,
  order_id INT NOT NULL,
  order_date DATE,
  order_time TIME,
  item_id INT,
  PRIMARY KEY (order_details_id)
);
TRUNCATE order_details;

-- 1. View the menu_items table

SELECT * FROM menu_items; 

-- 2. Find the number of items on the menu

SELECT COUNT(*) FROM menu_items;

-- 3. What are the least and most expensive items on the menu

SELECT * FROM menu_items
ORDER BY price;

SELECT * FROM menu_items
ORDER BY price DESC;

-- 4. How many Italian dishes are on the menu?

SELECT COUNT(*) FROM menu_items
WHERE category='Italian';

-- 5. What are the least and most expensive Italian dishes on the menu?

SELECT * FROM menu_items
WHERE category='Italian'
ORDER BY price;

SELECT * FROM menu_items
WHERE category='Italian'
ORDER BY price DESC;

-- 6. How many dishes are in each category?

SELECT category, COUNT(category) AS num_dishes
FROM menu_items
GROUP BY category;

-- 7. What is the average dish price within each category?

SELECT category, ROUND(AVG(price),2) AS avg_price
FROM menu_items
GROUP BY category;


-- OBJECTIVE 2 

-- 1. View the order_details table. 

SELECT * FROM order_details;

-- 2. What is the date range of the table?

SELECT MIN(order_date), MAX(order_date) FROM order_details;

-- 3. How many orders were made within this date range? 

SELECT COUNT( DISTINCT order_id) FROM order_details;

-- 4. How many items were ordered within this date range?

SELECT COUNT(item_id) FROM order_details;

-- 5. Which orders had the most number of items?

SELECT order_id, COUNT(item_id) as num_items
FROM order_details
GROUP BY order_id
ORDER BY num_items DESC;

-- 6. How many orders had more than 12 items?
SELECT COUNT(*) FROM 
(SELECT order_id, COUNT(item_id) as num_items
FROM order_details
GROUP BY order_id
HAVING num_items > 12) AS num_orders;


-- OBJECTIVE 3

SELECT * FROM order_details;
SELECT * FROM menu_items; 
-- 1. Combine the menu_items and order_details tables into a single table.

SELECT * 
FROM order_details od LEFT JOIN menu_items mi
ON od.item_id = mi.menu_item_id;

-- 2. What were the least and most ordered items? What categories were they in?

SELECT item_name, category, COUNT(order_details_id) as num_items 
FROM order_details od LEFT JOIN menu_items mi
ON od.item_id = mi.menu_item_id
GROUP BY item_name, category
ORDER BY num_items;

-- 3. What were the top 5 orders that spent the most money?

SELECT order_id, ROUND(SUM(price),2) as total_spends
FROM order_details od LEFT JOIN menu_items mi
ON od.item_id = mi.menu_item_id
GROUP BY order_id
ORDER BY total_spends DESC
LIMIT 5;

-- 4. View the details of the highest spend order. What insights can you gather from the results?

SELECT category, COUNT(item_id) as num_items
FROM order_details od LEFT JOIN menu_items mi
ON od.item_id = mi.menu_item_id
WHERE order_id = 440
GROUP BY category;

-- 5. View the details of the top 5 highest spend orders. What insights can you gather from the results?
-- ref Q.3
SELECT order_id, category, COUNT(item_id) as num_items
FROM order_details od LEFT JOIN menu_items mi
ON od.item_id = mi.menu_item_id
WHERE order_id IN (440, 2075, 1957, 330, 2675)
GROUP BY order_id, category;


