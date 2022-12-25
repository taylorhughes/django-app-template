SHELL := /bin/sh
DIR := ${CURDIR}

lint_ci :
	black . --exclude "(migrations|venv)" --check
	isort . --check-only
	flake8 --ignore=E203,E128,E231,E302,E402,E501,W503,W605,E722 --exclude=venv
	mypy service tests --pretty

lint :
	black . --exclude "(migrations|venv)"
	isort .
	flake8 --ignore=E203,E128,E231,E302,E402,E501,W503,W605,E722 --exclude=venv
	mypy service tests --pretty

test :
	pytest --cov=service --cov-report html tests/

update_requirements :
	pip freeze > requirements.txt

make_migrations :
	python manage.py makemigrations service

migrate : make_migrations
	python manage.py migrate

run_server :
	python manage.py runserver 127.0.0.1:8080