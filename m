Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315178AbSFDQaZ>; Tue, 4 Jun 2002 12:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315162AbSFDQaB>; Tue, 4 Jun 2002 12:30:01 -0400
Received: from air-2.osdl.org ([65.201.151.6]:32646 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S315171AbSFDQ3O>;
	Tue, 4 Jun 2002 12:29:14 -0400
Date: Tue, 4 Jun 2002 09:25:17 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@geena.pdx.osdl.net>
To: <linux-kernel@vger.kernel.org>
Subject: device model documentation 2/3
Message-ID: <Pine.LNX.4.33.0206040918490.654-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Document 2: driver.txt

This document includes two important points. For one, there is finally the 
much promised description on the intended use of the power management 
callbacks. 

Second, there is a proposed callback: init(). This would break driver 
initialization apart from probe(). This has been discussed in the past, 
and I believe with a positive result. If there are no objections, I will 
implement the callback. Otherwise, I will fix the document. 

	-pat


Device Drivers


struct device_driver {
	const char		* name;
	list_t			bus_list;

	rwlock_t		lock;
	atomic_t		refcount;

	list_t			devices;

	struct bus_type		* bus;
	struct driver_dir_entry	dir;

	int	(*add)		(struct device * dev, char * busid);
	int	(*probe)	(struct device * dev);
	int 	(*remove)	(struct device * dev);

	int	(*suspend)	(struct device * dev, u32 state, u32 level);
	int	(*resume)	(struct device * dev, u32 level);

	void	(*release)	(struct device_driver * drv);
};

int driver_register(struct device_driver * drv);


Each device driver in the kernel should declare a static instance of a
struct device_driver. Each driver structure can support multiple
devices. However, the driver object represents only the driver as a
whole, not a particular device instance.

The driver must initialize at least the name and bus fields. It should
also initalize the devclass field, so it may obtain the proper linkage
internally. It should also initialize as many of the callbacks as
possible, though each is optional.

The driver registers the structure on startup. The means for doing so
is dependent on the requirements of the bus. Many buses will have
extra bus-specific callbacks or data associated with the drivers. In
order to use and initialize these fields, the bus drivers should keep
their own driver structure and define wrapper functions for
registering and unregistering drivers.

struct pci_driver my_driver {
       ...
       struct device_driver	* driver;
};

int pci_driver_register(struct pci_driver * drv);

The semantics should be nearly identical in either case - the driver
statically declares the object, initializes the proper fields, and
registers it. The bus wrapper then calls driver_register to register
the driver with the core. 

By defining wrapper functions, the transition to the new model can be
made easier. Drivers can ignore the generic structure altogether and
let the bus wrapper fill in the fields. For the callbacks, the bus can
define generic callbacks that forward the call to the bus-specific
callbacks of the drivers. 

This solution is intended to be only temporary. In order to get class
information in the driver, the drivers must be modified anyway. Since
converting drivers to the new model should reduce some infrastructural
complexity and code size, it is recommended that they are converted as
class information is added.


Once the object has been registered, it may access the common fields of
the object, like the lock and the list of devices. 

int driver_for_each_dev(struct device_driver * drv, void * data, 
		        int (*callback)(struct device * dev, void * data));

The devices field is a list of all the devices that have been bound to
the driver. The LDM core provides a helper function to operate on all
the devices a driver controls. This helper locks the driver on each
node access, and does proper reference counting on each device as it
accesses it. 


struct device_driver * get_driver(struct device_driver * drv);
void put_driver(struct device_driver * drv);

When a device is bound to a driver, the driver's reference count is
incremented. When a device is removed from the system, its driver's
remove callback is called, and the reference count is decremented for
the driver. When the driver's reference count reaches 0, its release
callback is called to free any resources that it has allocated. The
reference count of a driver can be manually controlled with get_driver
and put_driver, which increment and decrement the reference count.

When a driver module is unloaded, the remove callback is called for
all devices that it supports. The reference count is decremented after
each call.


When a driver is registered, a driverfs directory is created in its
bus's directory. In this directory, the driver can export an interface
to userspace to control operation of the driver on a global basis;
e.g. toggling debugging output in the driver.

A future feature of this directory will be a 'devices' directory. This
directory will contain symlinks to the directories of devices it
supports.



Callbacks

	int	(*add)		(struct device * dev, char * busid);

add is called to add a child device at the location specified by
@busid. Only bridge devices should implement this callback. They
should probe the bus hardware at the address specified to check for a
device. If one exists, it should create a bus structure for it and
register it with the LDM core. 

	int	(*probe)	(struct device * dev);

probe is called to verify the existence of a certain type of
hardware. This is called during the driver binding process, after the
bus has verified that the device ID of a device matches one of the
device IDs supported by the driver. 

This callback only verifies that there actually is supported hardware
present. It may allocate a driver-specific structure, but it should
not do any initialization of the hardware itself. The device-specific
structure may be stored in the device's driver_data field. 

	int	(*init)		(struct device * dev);

init is called during the binding stage. It is called after probe has
successfully returned and the device has been registered with its
class. It is responsible for initializing the hardware.

	int 	(*remove)	(struct device * dev);

remove is called to dissociate a driver with a device. This may be
called if a device is physically removed from the system, if the
driver module is being unloaded, or during a reboot sequence. 

It is up to the driver to determine if the device is present or
not. It should free any resources allocated specifically for the
device; i.e. anything in the device's driver_data field. 

If the device is still present, it should quiesce the device and place
it into a supported low-power state.

	int	(*suspend)	(struct device * dev, u32 state, u32 level);

suspend is called to put the device in a low power state. There are
several stages to sucessfully suspending a device, which is denoted in
the @level parameter. Breaking the suspend transition into several
stages affords the platform flexibility in performing device power
management based on the requirements of the system and the
user-defined policy.

SUSPEND_NOTIFY notifies the device that a suspend transition is about
to happen. This happens on system power state transition to verify
that all devices can sucessfully suspend.

A driver may choose to fail on this call, which should cause the
entire suspend transition to fail. A driver should fail only if it
knows that the device will not be able to be resumed properly when the
system wakes up again. It could also fail if it somehow determines it
is in the middle of an operation too important to stop.

SUSPEND_DISABLE tells the device to stop I/O transactions. When it
stops transactions, or what it should do with unfinished transactions
is a policy of the driver. After this call, the driver should not
accept any other I/O requests.

SUSPEND_SAVE_STATE tells the device to save the context of the
hardware. This includes any bus-specific hardware state and
device-specific hardware state. A pointer to this saved state can be
stored in the device's saved_state field.

SUSPEND_POWER_DOWN tells the driver to place the device in the low
power state requested. 

Whether suspend is called with a given level is a policy of the
platform. Some levels may be omitted; drivers must not assume the
reception of any level. However, all levels must be called in the
order above; i.e. notification will always come before disabling;
disabling the device will come before suspending the device.

All calls are made with interrupts enabled, except for the
SUSPEND_POWER_DOWN level.

	int	(*resume)	(struct device * dev, u32 level);

Resume is used to bring a device back from a low power state. Like the
suspend transition, it happens in several stages. 

RESUME_POWER_ON tells the driver to set the power state to the state
before the suspend call (The device could have already been in a low
power state before the suspend call to put in a lower power state). 

RESUME_RESTORE_STATE tells the driver to restore the state saved by
the SUSPEND_SAVE_STATE suspend call. 

RESUME_ENABLE tells the driver to start accepting I/O transactions
again. Depending on driver policy, the device may already have pending
I/O requests. 

RESUME_POWER_ON is called with interrupts disabled. The other resume
levels are called with interrupts enabled. 

As with the various suspend stages, the driver must not assume that
any other resume calls have been or will be made. Each call should be
self-contained and not dependent on any external state.



