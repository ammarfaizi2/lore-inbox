Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315171AbSFDQaY>; Tue, 4 Jun 2002 12:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315182AbSFDQ3u>; Tue, 4 Jun 2002 12:29:50 -0400
Received: from air-2.osdl.org ([65.201.151.6]:32390 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S315162AbSFDQ3L>;
	Tue, 4 Jun 2002 12:29:11 -0400
Date: Tue, 4 Jun 2002 09:25:14 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@geena.pdx.osdl.net>
To: <linux-kernel@vger.kernel.org>
Subject: device model documentation 1/3
Message-ID: <Pine.LNX.4.33.0206040904430.654-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As everyone who is using 2.5 noticed, there were some changes to the 
device model core last week that broke the kernel for nearly everyone. The 
intent was definitely not to do that, nor to leave it that way over the 
weeekend, nor to delay the release of the docs until now. However, time 
ran short, and I got the first bug report literally an hour before I left 
town. 

Here is some documentation on the structures and interfaces. These were
written ~1 week ago, and should be mostly, if not completely, accurate. If
anything is inaccurate, or fails to make any sense, please call me on it.
These will eventually (soon) be submitted to Linus and will live in
Documentation/device-model/.

There will be more to come in the near future. I will also be at the 
kernel summit and OLS to discuss these topics (my talk will also be based 
on this stuff).


The three documents are: 

- bus.txt:	struct bus_type and its uses
- driver.txt:	struct device_driver
- binding.txt:	how drivers are bound to devices in the device model core


Thanks,

	-pat


Bus Types 

struct bus_type {
	char		* name;
	list_t		node;
	struct driver_dir_entry	dir;
	struct driver_dir_entry	device_dir;
	struct driver_dir_entry	driver_dir;

	atomic_t	refcount;
	rwlock_t	lock;
	list_t		devices;
	list_t		drivers;

	int	(*bind)		(struct device * dev, struct device_driver * drv);
};

int bus_register(struct bus_type * bus);


Each bus type in the kernel (PCI, USB, etc) should declare one static
object of this type. They must initialize the name field, and may
optionally initialize the bind and release fields. 

struct bus_type my_bus_type = {
       name:	"mybus",
       bind:	my_bus_bind,
       release:	my_bus_release,
};

The structure should be exported to drivers in a header file:

extern struct bus_type my_bus_type; 

.bind is used to determine if a particular driver supports a
particular device. When a driver is registered with the bus, the bus's
list of devices is iterated over, and .bind is called for each device
that does not have a driver associated with it. (Drivers typically
have a list of bus-specific device IDs that they support. The format
and semantics for binding devices and drivers is nearly impossible to
do generically; hence the callback.)


When a bus driver is initialized, it calls bus_register. This
initializes the rest of the fields in the bus object and inserts it
into a global list of bus types. Once the bus object is registered, 
the fields in it (e.g. the rwlock_t) are usable by the bus driver. 

The lists of devices and drivers are intended to replace the local
lists that many buses keep. They are lists of struct devices and
struct device_drivers, respectively. Bus drivers are free to use the
lists as they please, but conversion to the bus-specific type may be
necessary. 

The LDM core provides helper functions for iterating over each list.

int bus_for_each_dev(struct bus_type * bus, void * data, 
		     int (*callback)(struct device * dev, void * data));
int bus_for_each_drv(struct bus_type * bus, void * data,
		     int (*callback)(struct device_driver * drv, void * data));

These helpers iterate over the respective list, and call the callback
for each device or driver in the list. All list accesses are
synchronized by taking the bus's lock (read currently). The reference
count on each object in the list is incremented before the callback is
called; it is decremented after the next object has been obtained. The
lock is not held when calling the callback. 


The LDM core creates a top level 'bus' directory on initialization. When 
a bus driver registers itself, a subdirectory is created in the 'bus'
directory for it. In this directory, the bus driver can expose an
interface to usespace. For example, this interface could be used to
set the debugging level in the bus driver. Since there is one
directory per bus type, this interface would affect the entire bus
driver. 

int bus_create_file(struct bus_type * bus, struct driver_file_entry * entry);

A bus driver creates a file in the same way a device does: it
statically allocates a struct driver_file_entry, with the name, mode,
show and store fields initialized (the last two of course being
optional). It then calls bus_create_file to add the file to the
directory.

There are two subdirectories created in the bus's directory by
default: 'devices' and 'drivers'. For each device that is registered
with the LDM core, a symlink is created in the 'devices' directory of
the bus it belongs to. This symlink points back to the device's
directory in the physical hierarchical tree.

Each driver that is registered gets a directory in the 'drivers'
directory of the bus it belongs to. More about this is discussed in
the 'Drivers' section.

An example directory structure for a bus looks like this: 

/devices/bus/pci/
/devices/bus/pci/drivers
/devices/bus/pci/drivers/eepro100
/devices/bus/pci/drivers/serial
/devices/bus/pci/drivers/parport_pc
/devices/bus/pci/devices
/devices/bus/pci/devices/01:08.0
/devices/bus/pci/devices/01:04.0
/devices/bus/pci/devices/00:1f.4
/devices/bus/pci/devices/00:1f.3
/devices/bus/pci/devices/00:1f.2
/devices/bus/pci/devices/00:1f.1
/devices/bus/pci/devices/00:1f.0
/devices/bus/pci/devices/00:1e.0
/devices/bus/pci/devices/00:02.0
/devices/bus/pci/devices/00:00.0


Bus reference counting uses similar primitives as device reference
counting. 

struct bus_type * get_bus(struct bus_type * bus);
void put_bus(struct bus_type * bus);

get_bus increments the reference count and returns a pointer to the
object passed in. put_bus decrements the reference count. If the
reference count reaches 0, the bus's directories are removed. No other
garbage collection is currently done. The reference count is
incremented each time a device or driver is registered with the bus,
and decremented when they are unregistered. 




