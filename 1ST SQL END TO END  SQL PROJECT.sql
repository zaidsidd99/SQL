CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);



CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);



CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);


SELECT * FROM BOOKS;
SELECT * FROM CUSTOMERS;
SELECT * FROM ORDERS;



-- 1) Retrieve all books in the "Fiction" genre:
select * from books
where genre='Fiction';



-- 2) Find books published after the year 2015:
SELECT * FROM BOOKS 
WHERE PUBLISHED_YEAR > 2015;

-- 3) List all customers from the Canada:
SELECT * FROM CUSTOMERS 
WHERE country = 'Canada';


-- 4) Show orders placed in November 2023:
SELECT * FROM orders
WHERE order_date BETWEEN '2023-09-01' AND '2023-09-30';



-- 5) Retrieve the total stock of books available:
SELECT SUM(STOCK)AS TOTAL_STOCK
FROM BOOKS;


-- 6) Find the details of the most expensive book:
SELECT * FROM BOOKS
ORDER BY PRICE DESC
LIMIT 1;


-- 7) Show all customers who order more than 1 quantity of a book:
SELECT * FROM ORDERS
WHERE QUANTITY>1;


-- 8) Retrieve all orders where the total amount exceeds 20:
SELECT * FROM ORDERS
WHERE TOTAL_AMOUNT>20;


-- 9) List all genres available in the Books table:
SELECT DISTINCT GENRE FROM BOOKS;


-- 10) Find the book with the lowest stock:
SELECT STOCK FROM BOOKS
ORDER BY STOCK ASC
LIMIT 1;


-- 11) Calculate the total revenue generated from all orders:
SELECT SUM (TOTAL_AMOUNT) AS TOTAL_REVENUE FROM ORDERS;




-- Advance Questions : 


-- 1) Retrieve the total number of books sold for each genre:
SELECT B.GENRE,SUM(O.QUANTITY) AS TOTAL_BOOKS_SOLD
FROM ORDERS O
JOIN BOOKS B ON O.BOOK_ID=B.BOOK_ID
GROUP BY B.GENRE;


-- 2) Find the average price of books in the "Fantasy" genre:
SELECT AVG(PRICE) AS AVERAGE_PRICE
FROM BOOKS
WHERE GENRE='Fantasy';


-- 3) List customers who have placed at least 2 orders:
SELECT o.customer_id,c.name, COUNT(o.Order_id) AS ORDER_COUNT
FROM orders o
JOIN customers c ON o.customer_id= c.customer_id
GROUP BY o.customer_id, c.name
HAVING COUNT(Order_id) >= 2;


-- 4) Find the most frequently ordered book:
SELECT O.BOOK_ID ,B.TITLE ,COUNT (O.ORDER_ID) AS ORDER_COUNT
FROM ORDERS O
JOIN BOOKS B ON O.BOOK_ID=B.BOOK_ID
GROUP BY O.BOOK_ID,B.TITLE
ORDER BY ORDER_COUNT DESC
LIMIT 1;


-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
SELECT* FROM BOOKS
WHERE GENRE='Fantasy'
ORDER BY price DESC
LIMIT 3;


-- 6) Retrieve the total quantity of books sold by each author:
SELECT b.author,sum(o.quantity) AS total_books_sold
FROM orders o
JOIN books b ON b.book_id=o.book_id
GROUP BY b.author;


-- 7) List the cities where customers who spent over 30 are located:
SELECT DISTINCT c.city, total_amount
FROM orders o
JOIN customers c ON c.customer_id=o.customer_id
WHERE o.total_amount > 30;


-- 8) Find the customer who spent the most on orders:
SELECT c.customer_id,c.name,SUM(o.total_amount)AS total_spent
FROM orders o
JOIN customers c ON c.customer_id=o.customer_id
GROUP BY c.customer_id,c.name
ORDER BY total_spent DESC;


--9) Calculate the stock remaining after fulfilling all orders:
SELECT b.book_id,b.title,b.stock,COALESCE(SUM(quantity),0) as order_quantity
FROM books b
LEFT JOIN orders o ON b.book_id=o.book_id
GROUP BY b.book_id;


