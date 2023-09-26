extends CharacterBody3D

# How fast the player moves in meters per second
@export var speed = 14

# The downward acceleration when in the air, in meters per second square
@export var fall_acceleration = 75

var target_velocity = Vector3.ZERO

func _physics_process(delta):
	# We create a local variable to store the input direction.
	var direction = Vector3.ZERO
	
	# We create a local variable to store the input direction accordingly
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_back"):
		direction.z += 1
	if Input.is_action_pressed("move_foward"):
		direction.z -= 1
	# Notice how we are working with the vector's x and z axes.
	# In 3D, the XZ plane is the ground plane.
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$Pivot.look_at(position + direction, Vector3.UP)
		
	# Ground Velocity
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed
	
	# Vertical Velocity
	if not is_on_floor(): 
	# If in the air, fall towards the floor. Literally gravity
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)
	
	# Moving the Character
	velocity = target_velocity
	move_and_slide()
