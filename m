Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266865AbSLUKfp>; Sat, 21 Dec 2002 05:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266868AbSLUKfp>; Sat, 21 Dec 2002 05:35:45 -0500
Received: from h-64-105-34-78.SNVACAID.covad.net ([64.105.34.78]:34521 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S266865AbSLUKfl>; Sat, 21 Dec 2002 05:35:41 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sat, 21 Dec 2002 02:43:06 -0800
Message-Id: <200212211043.CAA00607@baldur.yggdrasil.com>
To: mochel@osdl.org
Subject: Re: RFC: bus_type and device_class merge (or partial merge)
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Dec 2002 22:29:39 -0600 (CST), Patrick Mochel wrote:
>> 	A philosophical musing is not substitute for identifying real
>> technical advantages or disadvantages, but thanks for the response.

>Ouch. 

	Sorry for the harsh tone.  For what it's worth, I advocate the
generic device model.  For example, I recently posted a proposed port
of pa-risc devices to it (although it looks like it will not be
integrated because the developers do not like struct kobject and
subsystem being so big).


>> 	If my proposed changes shrink kernel memory footprint, improve
>> code maintainability, allow multiple drivers per device (e.g., scsi
>> generic and scsi disk), users will be better off with those advantages
>> than being lost in a doctrine for which they've lost track of the benefits.

>You're trying to pinch pennies with the footprint you're talking about. 
>The extra structure definition costs nothing, and the code to interface 
>those objects with the other driver model objects is trivial.

	True, but drivers/base is mandatory for everything including
wristwatch implementations, and these things add up to the point where
they can tip the balance in favor of VxWorks et al, so I think these
little optimizations are often worthwhile, even if we're only talking
about 2kB (text+data size of class.o).  In general, if you want small
code, you need to have the discipline to go after lots of little
bloats.


>Plus, you'd be overloading the object to behave differently depending on
>how it was referenced, causing more code.  That certainly wouldn't improve
>code maintainability.

	Huh?  I'd like to understand what you mean in that first
sentence.  Can you walk through a hypothetical example?  I expect the
changes that I have in mind to decrease overall code size (even if
only slightly).

	More importantly, I expect the changes that I have in mind
to reduce the total amount of code that needs to be maintained and
to make it easier to write other facilities that use the generic
device layer (see below for examples).


>A device belongs to exactly one bus type and exactly one class type.

	I have a Radeon All-In-Wonder 7500 card in my livingroom.
It appears as a single PCI device in lspci, but has the functionality
of three different device_classes (imagine these things ported to the
driver model):
			- frambuffer_devclass
			- video4linux_devclass
			- audio_devclass

	From this example, it seems to me that that one device does
not necessarily belong to exactly one devclass, but I think that can
be made true of each struct intf_data under your scheme (under my
approach struct intf_data would be replaced by struct device for
another bus_type, such as netdevice_bus_type or gendisk_bus_type).



>This 
>is easy to express. If you combine the objects, you either reference each 
>instance explicitly, kinda like they are now,

	I don't understand this clause.

>or you represent it in some 
>list, which will complicate the existing code immensely.

>What problem would that solve?

	Reducing the complexity of scsi-generic, scsi-debug, usbdevfs,
etc. by allowing them to use the rendezvous code of drivers/base, as
measured, say, in line count of these individual facilities and total
kernel line count.  I believe I know how to do this without changing
the source code of regular "exclusive" drivers.


>How would that allow you to bind multiple drivers to a device?

	I imagine combining device_driver and device_interface in a
way that more resembles device_interface.

	Something like this (maybe convert to kobject/subsystem for
sysfs support):

struct device_driver {
	...
	int	share_dev : 1;
};

/* Note that a driver could register multiple nexi for the
   same <device,driver> pair but different interfaces (e.g., scsi_disk,
   scsi_generic). */
struct dev_drv_nexus {	/* Replaces intf_data */
	struct device_driver	* driver;
	struct device		* dev;
	void			* driver_data;
	struct list_head	same_dev, same_driver;
};

sturct device {
	/* Delete device.driver, device.driver_data. */

	/* A maximum of one driver with share_dev==0 can be bound to a
	   device, and it must always be the first device on the list
	   (share_dev==1 drivers are added at the tail of the list;
	   share_dev==0 drivers are added at the front of the list). */
	struct subsystem	nexi;
};

extern struct dev_drv_nexus *dev_unshared_nexus(struct device *dev)


static inline struct nexus *dev_unshared_nexus(struct device *dev)
{
	struct dev_drv_nexus *nexus;
	BUG_ON(list_empty(&dev->nexi));
	nexus = list_entry(dev->nexi->next, struct nexus, same_dev);
	BUG_ON(nexus->driver->share_dev);
	return nexus;
}

/* Only for use by drivers that have share_dev==0 */
static inline void *dev_get_drvdata(struct device *dev)
{
	return dev_unshared_nexus(dev)->driver_data;
}

/* Only for use by drivers that have share_dev==0 */
static inline void dev_get_drvdata(struct device *dev, void *driver_data)
{
	dev_unshared_nexus(dev)->driver_data->driver_data = driver_data;
}




>Why would you want to do that anyway? 

>To support scsi-generic?

	That's one example, yes.

>I've talked with SCSI people before about this. 
>It's bad to treat it as a driver, because it causes the core to special 
>case these wacky instances where you have an extension of the bus driver 
>apply to each device registered with it. I've gotten verbal confirmation 
>that scsi-generic will change in this regard, and I've offered to provide 
>hooks to make this easier to express.

	From this message by Mike Anderson on November 7, I think what
you only heard a reflection of what you said because what you said
wasn't really understood:

	http://marc.theaimsgroup.com/?l=linux-scsi&m=103669541704163&w=2


>For the record, both USB and PCI do similar things. USB creates procfs
>entries, and can create device nodes.

	Yes, these are other, similar examples.  I would like to be
able to load and unload usbdevfs through the generic driver API.


>IIRC, USB makes an explicit call to
>the function that does this. PCI makes an explicit call to create procfs 
>entries for each PCI device. They could all be implemented as 'drivers' 
>but it doesn't make sense to overload the objects to do it this way.

	I don't understand what you mean by "doesn't make sense."  If
you could express your point in terms of underlying advantages
(source code size, speed, memory footprint, etc.) it will save you
iterations of email.


>> >They're not the same, though. They may be similar, but they are 
>> >fundamentally different. 
>> 
>> 	There are also differences between USB and PCI, but that
>> doesn't mean that the part that is handled by drivers/base has to be
>> different.  The question is whether having separate implementations
>> for a set of differences make the code smaller, faster, more
>> functional, or delivers other real benefits that tip the trade-off.

>Why? Why try to micro-optimize the core now?

	Because it can be done in less programmer time now before more
code is ported to it, and, more importantly, it would enable or simplify
a number of facilities that I want to add.


>You'll gain much more by 
>converting bus and class drivers to use the driver model objects, and 
>reducing the replication in the dusty corners of the kernel. 

>> 	Perhaps it would help you to understand the impetus that made
>> me think about this.  I want to have a mechanism for race-free module
>> unloading without a new lowest level locking primitive (i.e., just by
>> using rw_semaphore).  To make its use transparent for most cases, I
>> want add a field to struct device_driver and add a couple of lines to
>> {,un}register_driver, and I see that if I have to duplicate this
>> effort if I want the same thing for, say, converting filesystems to
>> use the generic driver interface.  I don't see that duplication buying
>> any real improvement in speed, kernel footprint, source code size,
>> etc.  In other words, having two separate interfaces makes it harder
>> to write other facilities that are potentially generic to
>> driver/target rendezvous.

>Fine. That would be nice. You definitely have good intentions, but there 
>is much more work to be done, that is far less glamorous, that I am 
>concerned with. 

	If you see a long time horizon on one what I want to do, it's
only from maintainer inertia.  I'm not predicating my plans on any
maintainer doing more than integrating patches, or any other deveoper
doing more than occasionally reporting their experiences.  I have
posted some pseudo-code for this and several other facilities that
would rely on the genericness of drivers/base code:

Pseudo-code for raceless module unloading without a new locking primitive
(would have to duplicate for device_driver and device_interface):
	http://marc.theaimsgroup.com/?l=linux-kernel&m=103773401411324&w=2

Patch for preallocating dev->driver_private for many devices, mostly to
conslidate untested error legs (would have to duplicate for
device_driver and device_interface):
	http://marc.theaimsgroup.com/?l=linux-kernel&m=103626558708431&w=2

Likewise for the static DMA consistent memory area (might duplicate for
device_driver and device_interface or do without for device_interface):
	 http://marc.theaimsgroup.com/?l=linux-kernel&m=103636338527053&w=2

Pseudo-code for string-based generic device ID matching (would have
to duplicate for device_driver nd device_interface if things like
filesystems use device_interface rather than device_driver):
	http://marc.theaimsgroup.com/?l=linux-kernel&m=103828651528556&w=2


	Duplicating these facilities for struct device_driver and
struct device_interface adds unnecessarily to source and object size.
Also, if any similar facility is developed that wants to use multiple
operands that could be bus_type/device_classs or
device_driver/device_interface, then the size of its API may have
to grow exponentially.

	This is just stuff that I want to do imminently.  What other
people want to do or might want to do in the near future is probably
larger.  I think the only reason that we don't yet see many new
abstractions that use the generic driver code is because it's new.


>> >Consolidation is possible, but I would not recommend doing it by merging
>> >the structures. Look for other ways to create common objects that the two
>> >can share.
>> 
>> 	I'm thinking about this.  I just wonder if there would be any
>> remaining fields that would not be common. 

>Even if there are not, they have different purposes, and different 
>semantics for dealing with them. Please do not play God on them, they are 
>there for specific purposes.

	"Purpose" just refers to someone's state of mind at some point
in the past.  The optimal technical trade-offs are generally not
determined by that, and making those trade-offs is not "playing God",
even when it involves editing code that you wrote.  So far, you have
not identified any real benefit that this duplication delivers, much
less enough to tip the balance.

[...]
>I may not know the low-level details about many things, but
>I've spent enough of the last two years comparing and analyzing the
>behavior of drivers to mean it when I say I will not consider patches of 
>that type. :)

	Sophomore. :)

	Seriously, though, if embed a common structure in device_class
and bus_type and consolidate the code that way, that may suffice, at
least if I can add the equivalent of struct intf_data for device
drivers so that certain carefully written drivers to be allowed to
attach to devices that already have another device (and perhaps the
equivalent of intf_data might facilitate support for things like my
ATI All-In-Wonder conglomeration).

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
