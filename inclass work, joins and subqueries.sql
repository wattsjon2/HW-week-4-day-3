-- my stuff

SELECT title, first_name, last_name, release_year, name as category
FROM film
INNER JOIN film_actor
ON film.film_id = film_actor.film_id
INNER JOIN actor
ON film_actor.actor_id = actor.actor_id
INNER JOIN film_category
ON film.film_id = film_category.film_id
INNER JOIN category
ON film_category.category_id = category.category_id;

SELECT actor.actor_id, first_name, last_name, name as category, COUNT(name) as category_count
FROM film
INNER JOIN film_actor
ON film.film_id = film_actor.film_id
INNER JOIN actor
ON film_actor.actor_id = actor.actor_id
INNER JOIN film_category
ON film.film_id = film_category.film_id
INNER JOIN category
ON film_category.category_id = category.category_id
GROUP BY name, first_name, last_name, actor.actor_id
ORDER BY COUNT(name) DESC;

SELECT first_name, last_name, name as category, COUNT(name) as category_count
FROM film
INNER JOIN film_actor
ON film.film_id = film_actor.film_id
INNER JOIN actor
ON film_actor.actor_id = actor.actor_id
INNER JOIN film_category
ON film.film_id = film_category.film_id
INNER JOIN category
ON film_category.category_id = category.category_id
GROUP BY name, first_name, last_name
ORDER BY COUNT(name) DESC;

select *
from film_actor;

-- inner join on the actor and film_actor table
SELECT actor.actor_id, first_name, last_name, film_id
FROM film_actor
INNER JOIN actor
ON actor.actor_id = film_actor.actor_id;

-- left join on the actor table and film_actor table
SELECT actor.actor_id, first_name, last_name, film_id
FROM film_actor
LEFT JOIN actor
ON actor.actor_id = film_actor.actor_id
WHERE first_name IS NULL AND last_name IS NULL;

-- JOIN that will produce info about customers from the country of Angola

SELECT customer.first_name, customer.last_name, customer.email, country
FROM customer
FULL JOIN address
ON customer.address_id = address.address_id
FULL JOIN city
ON address.city_id = city.city_id
FULL JOIN country
ON city.country_id = country.country_id
WHERE country = 'Angola';

-- right join to find ou the amouint of staff member
SELECT COUNT(staff_id), store.store_id
FROM staff
RIGHT JOIN store
ON staff. store_id = store.store_id
GROUP BY store.store_id;

-- SubQuery Section

-- Two seperate queries that we can put together

-- find a customer_id that has an amount greater than 175 in total payments
SELECT customer_id
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 175
ORDER BY SUM(amount) DESC;

-- second query
--find all customer data
SELECT *
FROM customer;

-- SubQuery to find the 6 customers that have a total amount paid greater than 175
SELECT *
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
	ORDER BY SUM(amount) DESC
);

-- BASIC SUBQUERY EXAMPLE 2
-- Find all films with the language 'English'

SELECT *
FROM film
WHERE language_id IN (
	SELECT language_id
	FROM language
	WHERE name = 'English'
);

-- what film has the most actors

SELECT COUNT(film_actor.film_id) AS total_actors, title
FROM film_actor
INNER JOIN film
ON film_actor.film_id = film.film_id
GROUP BY title
ORDER BY COUNT(film_actor.film_id) DESC;

SELECT title, film_id
FROM film
WHERE film_id in (
	SELECT film_id
	FROM film_actor
	GROUP BY film_id
	ORDER BY COUNT(film_id) DESC
	limit 1
	);


