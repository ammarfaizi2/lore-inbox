Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262794AbVCPU6o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbVCPU6o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 15:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262795AbVCPU6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 15:58:44 -0500
Received: from ida.rowland.org ([192.131.102.52]:5636 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S262794AbVCPU6g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 15:58:36 -0500
Date: Wed, 16 Mar 2005 15:58:30 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Kernel development list <linux-kernel@vger.kernel.org>
cc: Greg KH <greg@kroah.com>, Patrick Mochel <mochel@digitalimplant.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Locking changes to the driver-model core
Message-ID: <Pine.LNX.4.44L0.0503161422440.639-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH has said that he would like to remove the bus subsystem rwsem from 
the driver model.  Here's a proposal for a way to accomplish that.  The 
proposal is incomplete and requires changing the driver-model API a 
little; I'd like to hear people's reactions and get suggestions on ways to 
improve it.  (There's no patch with example code because it wouldn't be 
functional yet.)


We're concerned with buses together with the drivers and devices they
manage.  The major data elements needing protection against simultaneous
access are these lists:

	The bus's list of all registered devices:
		bus->devices,
		device->bus_list

	The bus's list of all registered drivers:
		bus->drivers,
		driver->kobj.kset

	Each device's list of children:
		device->children,
		device->node

	Each driver's list of devices it's bound to:
		driver->devices,
		device->driver_list

In addition we want to have suitable mutual exclusion for calls to 
drivers' callback functions, to avoid things like suspend() during 
probe().

The proposed solution is to add a new semaphore to struct device:

		device->mutex

and to add a spinlock and (following a suggestion from Dmitry) two version 
numbers to struct bus_type:

		bus->lock,
		bus->devices_version,
		bus->drivers_version

Whenever the core invokes a driver callback function (probe, remove,
shutdown, suspend, resume, and whatever else may be added) it will
acquire device->mutex.  There are complications associated with probe and 
remove, discussed below.

Protecting the lists mentioned above involves holding the bus->lock
spinlock during device_add, device_del, driver_register, and
driver_unregister.  Here's the basic idea:

     1.	When a device is added or deleted, the core holds
	device->parent->mutex while moving device->node onto or off of the
	device->parent->children list.  It holds device->mutex throughout
	the entire operation (see below about locking rules).

     2.	When a device is added or deleted, the core locks bus->lock
	while moving device->bus_list onto or off of the bus->devices
	list.  It also increments bus->devices_version.

     3.	When a driver is added or deleted, the core locks bus->lock
	while moving driver onto or off of the bus->drivers list.
	(This will require adding a new list_head into struct 
	device_driver rather than using the driver->kobj.kset
	mechanism; I don't want to get into that here.)  It also
	increments bus->drivers_version.

     4.	While probing drivers for a newly-registered device, the core
	will hold bus->lock while traversing the list of drivers and
	while calling bus's match routine.  It will drop the lock
	(and acquire device->mutex) will calling the probe() routine.
	If the probe fails, after reacquiring bus->lock it will check
	bus->drivers_version before proceding; if the version has
	changed it will restart the list traversal from the beginning.
	If the probe succeeds, after reacquiring bus->lock it will
	add device->driver_list onto the driver->devices lists.

     5.	Similarly, while probing devices for a newly-registered driver,
	the core will hold bus->lock while traversing the list of devices
	and while calling the match routine.  After a probe failure it
	will check bus->devices_version before proceding; if the
	version has changed it will restart the list traversal from the
	beginning.

     6.	Similar steps are used while unbinding devices from drivers.
	Note that it's necessary to protect against the race between
	unregistering a driver and probing it with a new device.  The
	converse, unregistering a device while it is being probed by
	a new driver, is already handled by device->mutex.

There are a few subtle points I've left out, but this gives the general
idea.  Note in particular that avoiding the use of a subsystem rwsem means
that it's always possible to add or delete devices from within a probe,
remove, or resume callback.


Now for the hard part.  We've added a whole tree of semaphores in the form
of driver->mutex.  The rule for preventing deadlocks is:

	Whenever a parent and a child are both locked, the parent's lock
	must be acquired first.

The trouble comes in step 1 above.  When adding or deleting a device, the 
core needs device->parent->mutex to be locked.  There are two choices: The 
core can acquire the parent's lock or it can demand that the caller 
already own it.

The first choice is simpler and would require no change to most drivers.  
They won't need to do any special locking; they just call device_add or
device_del as they do now.

The second choice is necessary whenever a device is registered or
unregistered during a probe or remove.  This happens all the time for
bridge drivers, where the child lives on a different bus from the parent.  
For example, consider a PCI SCSI adapter driver that registers the SCSI
host device during its probe routine.  It turns out also that having the
second choice available, while perhaps not strictly necessary, makes life
much easier for the USB subsystem.

The best way I can think of to cope with this is to have two separate
entry points for device_add (and likewise for device_del).  device_add
itself is used when the caller does not own device->parent->mutex, and
__device_add is used when the caller does own it.  (This leaves open the
question of whether a caller of __device_add must also own device->mutex;  
for simplicity let's say that it must.)

Implementing this change will require alterations to various bridge
drivers (like the SCSI core) and the USB core.  It shouldn't require
changing very much else.


The proposal has an additional advantage.  There are a few spots outside
the driver-model core where the kernel iterates over the devices owned by
a particular parent or belonging to a particular bus.  (For an interesting
example, see check_dev() and next_dev() in arch/parisc/kernel/drivers.c.)  
I don't know whether these spots are protected against changes to the
device list while they run, but with the new device->mutex locks it would
be easy to add such protection.


No doubt there's a bunch of stuff I haven't considered or am not aware of.  
Not to mention the part I glossed over about making the driver list not 
use driver->kobj.kset.  Comments are welcome.

Alan Stern

