Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266879AbUHSRz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266879AbUHSRz3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 13:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266890AbUHSRz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 13:55:29 -0400
Received: from c3-1d224.neo.rr.com ([24.93.233.224]:62686 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S266879AbUHSRqk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 13:46:40 -0400
Date: Thu, 19 Aug 2004 13:35:51 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org, greg@kroah.com, rml@ximian.com,
       mochel@digitalimplant.org, len.brown@intel.com
Subject: [RFC] Bus Resource Management
Message-ID: <20040819133550.GH3824@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org, greg@kroah.com, rml@ximian.com,
	mochel@digitalimplant.org, len.brown@intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I would appreciate any comments.

Thanks,
Adam


Linux Bus Resource Managment
by Adam Belay <ambx1@neo.rr.com>
last updated: August 19, 2004
-------------------------------------------------------------------------------

context:
This document describes my Linux Resource Management Rewrite.  Although It is
written with the specific challanges of the x86 architecture in mind, most
material will apply to every architecture.


Background Information
======================
Bus resources are channels used by drivers to communicate with physical
hardware.  In most modern systems, it is possible to dynamically assign and
reassign resources to devices.  This process is known as "Resource Management".

There are three types of resources common to most architectures:

1.) I/O ports  2.) I/O memory  3.) interrupts

In addition, x86, arm and others have DMA channels.

A device that is decoding its resources is said to be "enabled".  Conversely,
a device that ignores resources is said to be "disabled".  Just like devices,
resources have parents and children.  They can be nested and form a tree-like
topology.  A resource's parent is known as a "producer".  A resource's child is
a "consumer".  Every resource belongs to a physical device.  A device may
decode several resources.

There have been many attempts to improve resource management for the x86
architecture.  As a result there are several firmware interfaces designed to
support this feature.  In addition, most buses implement their own resource
management capabilities.

Resource management interfaces include:

legacy:
isapnp, pnpbios, eisa, mca, pcmcia (pcmcia is still widely used)

modern:
pci, pccard, pci-X, pci express, acpi, open firmware, others?

Older technologies, such as ISA are not capable of supporting resource
management, and require special measures to operate correctly.


The Problem
===========

The Resource Management Challange

Although allowing the operating system to configure resources is a significant
advantage, it also introduces complex problems.  Every device has different
resource requirements.  The method of determining these requirements is bus
specific.  Some devices are configured by the BIOS before the operating
system is loaded.  Others must always be configured by software.  Still, others
may be configured by the BIOS if cold plugged, but require operating system
configuration if hot plugged.  To make matters worse, both resource producers,
such as pci bridges, and resource consumers, such as network adapters, could
potentially be hot plugged.

In a perfect world there would be a virtually unlimited amount of resources
available.  Every device would be granted its requirements, without the risk
of an allocation failure.  Unfortunantly, many (not all) systems have very
limited resource availability.  Although this is not a problem for the
operating system when the BIOS preconfigures devices, any hot pluggable device
requires configuration by the kernel.  Also, in some systems, the BIOS will
only allocate resources to devices required for boot.  Finally, resource
configuration must be restored after a suspend to ram.

Legacy compatibility makes the situation even more complex.  For example, many
ISA devices will only decode the first 10 bits of a 16 bit I/O address.  As a
result, ghosts will appear at each address with a matching first 10 bits.
This very quickly consumes available I/O space, and creates a greater
potential for resource conflicts.  Even modern systems still exhibit this
problem with vga controllers.  Another example would be that many interrupts
are unavailable because the are reserved for legacy hardware.  Interrupt 13 is
saved for a math coprocessor, whether or not it physically is wired to
hardware.

Although new specifications generally have improved the resource management
situation, they also present new challenges.  For example, pci express will
allow for multipe bridges even on small desktop boxes.  Also, as hotplugable
devices become more prevalent, the need for dynamic resource allocation and
even "rebalancing" (the moving of a device to a different resource vector)
increases.


Linux Specific Problems

The Linux Kernel currently has an API for managing some types of resources.
Resources are generally reserved by drivers at the time they are required.
PCI is an exception in that it requests I/O and Memory before the driver is
loaded.  Resources are assigned at the time of detection in some cases, and
during driver probing in others.  Every bus driver has its own method of
assigning resources, and these implementations vary greatly between buses.
Furthermore, most buses are unaware of the resources assigned by other buses
if they have not been requested by the existing resource API at the time of
allocation.  Assignment is not protected by semaphores in all cases, and there
are several race conditions.

The kernel is unaware of resource based device dependencies.  The net effect
is that that the kernel cannot always determine who is producing a resource,
and lifetime rules for devices are often incorrect.

Despite its many flaws, the existing implementation is able to handle common
cases quite well.  As a result, code repetition, limited user interface, and
lack of driver model integration are equally important problems.


Proposed Solution
=================

In order to improve the functionality of Linux Resource Management, I propose
the following changes:

1.) Driver Model integration of resource management
- resource information is stored in "struct device".
- "struct bus_type" has hooks for common resource management operations.
- device dependency and producer/consumer relationships are considered.
- an API is exported that will allow for any device to be enabled or disabled
  in a uniform way.
- resources utilize kobject.

2.) Sysfs user interface
- userspace applications can determine resource usage and dependencies.
- userspace applications can disable and enable devices
- userspace applications can assign resources to a device
- userspace applications can pause the operation of a device, and rebalance
  its resources

3.) Smarter Allocation
- a central API controls allocation
- functions are available to determine special case conflicts such as 10 bit
  decode
- all devices are detected before allocation begins
- special provisions are taken for legacy hardware

4.) Support for all resource types
- currently only I/O and Mem are available for pre-driver reservations
- add support for interrupts and dma
- also pci bus numbers could be a resource type

5.) Report resource availability acurately
- acpi enumerates devices in the driver model tree and reports resource usage
- all other buses also utilize the new resource management API
- allow for buses to specify their own rules for determining if a resource is
  vaild

It is likely that even more needs to be changed. (open for discussion)


The Implementation
==================

The new implementation attempts to maintain compatibility with the existing
API.  I encourage everyone to look at the proof-of-concept code attached at
the end of this email.  The majority of it compiles, but it still needs to be
debugged.  I'm sharing it at this alpha stage because I think it could benefit
from comments and suggestions.

Here is a _very_ brief summary...


::: Core resource management

This is the foundation of the resource management API

struct resource {
	struct kobject kobj;
	const char *name;
	unsigned long start;
	unsigned long stop;
	unsigned long flags;
	struct resource *parent;
	struct resource *child;
	struct resource *sibling;
	struct res_type *type;
	struct device *dev;
};

int resource_register(struct resource *res) 
- reserves the resource and shows its new status in sysfs

int resource_unregister(struct resource *res)
- frees the resource


::: Resource types

A resource type is defined for each type of resource (ex. io, mem, irq etc)

struct res_type {
const char 		*name;
struct subsystem        subsys;
struct rw_semaphore     rwsem;
struct resource         *root;
int                     ranged;
};


int res_type_register(struct res_type *type)
- registers a resource type and inits it for use

void res_type_unregister(struct res_type *type)
- unregisters a resource type


::: Other functions

int resource_assign(struct resource *res, int ordered, unsigned long *next)
- attempts to allocate a resource at the location specified in res->start
- if it fails, next points to the next available location

int res_assign_range(struct resource *res, unsigned long min, unsigned long
		     max, unsigned long length, unsigned long align);

int device_enable(struct device *dev)
int device_disable(struct device *dev)

also the following has been added to struct bus_type:

(*enable)(struct device *dev)
(*disable)(struct device *dev)
(*assign)(struct device *dev)
(*verify)(struct resource *res)

More information is available in the code/comments.


Conclusion
==========

In conclusion, resource management can be difficult, but I believe Linux, with
improvement, could handle it well.  Because this issue is extremely complex, I
think it is important that we publicly discuss it, and work out a final API.  I
hope that the code I have contributed will be useful, but I'm open to making
any changes necessary for it to be accepted into the kernel.  Implementing
this properly will be a long and difficult process, and I'd like to get as
many people involved as possible so we can potentially speed things up.

Cheers,
Adam



diff -urN a/drivers/base/Makefile b/drivers/base/Makefile
--- a/drivers/base/Makefile	2004-07-26 10:39:02.000000000 +0000
+++ b/drivers/base/Makefile	2004-08-17 21:50:52.000000000 +0000
@@ -3,7 +3,7 @@
 obj-y			:= core.o sys.o interface.o bus.o \
 			   driver.o class.o class_simple.o platform.o \
 			   cpu.o firmware.o init.o map.o dmapool.o
-obj-y			+= power/
+obj-y			+= power/ resource/
 obj-$(CONFIG_FW_LOADER)	+= firmware_class.o
 obj-$(CONFIG_NUMA)	+= node.o
 
diff -urN a/drivers/base/core.c b/drivers/base/core.c
--- a/drivers/base/core.c	2004-08-05 13:05:11.000000000 +0000
+++ b/drivers/base/core.c	2004-08-17 21:46:17.000000000 +0000
@@ -20,6 +20,7 @@
 
 #include "base.h"
 #include "power/power.h"
+#include "resource/resource.h"
 
 int (*platform_notify)(struct device * dev) = NULL;
 int (*platform_notify_remove)(struct device * dev) = NULL;
@@ -229,6 +230,8 @@
 		goto Error;
 	if ((error = device_pm_add(dev)))
 		goto PMError;
+	if ((error = device_res_add(dev)))
+		goto RESError;
 	if ((error = bus_add_device(dev)))
 		goto BusError;
 	down_write(&devices_subsys.rwsem);
@@ -244,6 +247,8 @@
 	return error;
  BusError:
 	device_pm_remove(dev);
+ RESError:
+	device_res_remove(dev);
  PMError:
 	kobject_del(&dev->kobj);
  Error:
diff -urN a/drivers/base/init.c b/drivers/base/init.c
--- a/drivers/base/init.c	2004-08-05 13:05:11.000000000 +0000
+++ b/drivers/base/init.c	2004-08-05 13:02:44.000000000 +0000
@@ -13,6 +13,7 @@
 extern int devices_init(void);
 extern int buses_init(void);
 extern int classes_init(void);
+extern int resource_init(void);
 extern int firmware_init(void);
 extern int platform_bus_init(void);
 extern int system_bus_init(void);
@@ -31,6 +32,7 @@
 	devices_init();
 	buses_init();
 	classes_init();
+	resource_init();
 	firmware_init();
 
 	/* These are also core pieces, but must come after the
diff -urN a/drivers/base/resource/Makefile b/drivers/base/resource/Makefile
--- a/drivers/base/resource/Makefile	1970-01-01 00:00:00.000000000 +0000
+++ b/drivers/base/resource/Makefile	2004-08-17 21:16:10.000000000 +0000
@@ -0,0 +1,11 @@
+#
+# Makefile for Linux Resource Management.
+#
+
+res-proc-$(CONFIG_PROC_FS) = proc.o
+
+obj-y := main.o resource.o types.o assign.o sysfs.o slot.o device.o $(res-proc-y) compat.o
+
+ifeq ($(CONFIG_DEBUG_DRIVER),y)
+EXTRA_CFLAGS += -DDEBUG
+endif
diff -urN a/drivers/base/resource/assign.c b/drivers/base/resource/assign.c
--- a/drivers/base/resource/assign.c	1970-01-01 00:00:00.000000000 +0000
+++ b/drivers/base/resource/assign.c	2004-08-18 13:53:43.000000000 +0000
@@ -0,0 +1,128 @@
+/*
+ * assign.c - functions for assigning resources to devices.
+ *
+ *
+ * This file is released under the GPLv2
+ *
+ * Copyright (c) 2004	Adam Belay
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/ioport.h>
+#include <linux/spinlock.h>
+#include <linux/device.h>
+
+#include "resource.h"
+
+/*
+ * resource_find_next_start - determines the next available start vector based
+ * on a given conflict.
+ *
+ * @res - a pointer to the resource in question
+ * @conflict - a pointer to the conflict of "res"
+ *
+ * - "conflict" must not be the resource's parent.
+ */
+
+static unsigned long
+resource_find_next_start(struct resource *res, struct resource *conflict)
+{
+		if (res->type->ranged)
+			return (conflict->end + 1);
+		else
+			return (res->start + 1);
+}
+
+/*
+ * resource_assign - registers a resource, calls bus specific verification, shows
+ *		     the next available location if registration fails.
+ *
+ * @res - a pointer to the resource for assignment
+ * @ordered - true indicates that resources assignment attempts are tried in
+ *	      order (from low to high)
+ * @next - a place to store the next resource start location
+ *
+ * - type->lock must be held before calling, if registration fails, res->sibling
+ * must be NULL before the lock is released.
+ */
+
+int resource_assign(struct resource *res, int ordered, unsigned long *next)
+{
+	struct resource *conflict = res->sibling;
+	unsigned long n;
+	int ret;
+
+	if (!res->dev)
+		return -EINVAL;
+
+	if ((ret = res->dev->bus->verify(res, &n)))
+		goto busy;
+
+	if ((ret = __resource_register(res, ordered ? conflict : NULL,
+				      &conflict))) {
+		if (!conflict || conflict == res->parent) {
+			n = 0;
+			goto busy;
+		}
+		res->sibling = conflict;
+		n = resource_find_next_start(res, conflict);
+	} else
+		return 0;
+
+busy:
+	if (next)
+		*next = n;
+	return ret;
+}
+
+EXPORT_SYMBOL(resource_assign);
+
+/*
+ * res_assign_range - assigns a ranged resource
+ *
+ * @res - a pointer to the resource for assignment
+ * @min - the minimum start address
+ * @max - the maximum end address
+ * @length - the number of addresses between start and end
+ * @align - the size of the block to which the start address must be aligned
+ */
+
+int res_assign_range(struct resource *res, unsigned long min,
+		     unsigned long max, unsigned long length,
+		     unsigned long align)
+{
+	unsigned long next;
+	int err = 0, first = 1;
+	next = min;
+
+	down_write(&res->type->rwsem);
+	do {
+
+		if (first)
+			first = 0;
+		else if (!next) {
+			err = -EBUSY;
+			break;
+		}
+
+		res->start = (next) & ~(align - 1);
+		if (res->start < next)
+			res->start += align;
+		res->end = res->start + length - 1;
+
+		if (res->end > max) {
+			err = -EBUSY;
+			break;
+		}
+
+	} while (resource_assign(res, 1, &next));
+
+	res->sibling = NULL;
+	up_write(&res->type->rwsem);
+	return err;
+}
+
+EXPORT_SYMBOL(res_assign_range);
diff -urN a/drivers/base/resource/compat.c b/drivers/base/resource/compat.c
--- a/drivers/base/resource/compat.c	1970-01-01 00:00:00.000000000 +0000
+++ b/drivers/base/resource/compat.c	2004-08-19 13:08:38.000000000 +0000
@@ -0,0 +1,287 @@
+/*
+ * compat.c - compatibility layer for the old API
+ *
+ *
+ * This file is released under the GPLv2
+ *
+ * Copyright (C) 1999	Linus Torvalds
+ * Copyright (C) 1999	Martin Mares <mj@ucw.cz>
+ * Copyright (c) 2004	Adam Belay
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/errno.h>
+#include <linux/ioport.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <asm/io.h>
+
+#include "resource.h"
+
+
+static struct res_type * get_resource_type(struct resource *res)
+{
+	int type = (res->flags & (IORESOURCE_IO | IORESOURCE_MEM));
+	if (type == IORESOURCE_IO)
+		return &ioport_res_type;
+	else if (type == IORESOURCE_MEM)
+		return &iomem_res_type;
+	else
+		return NULL;
+
+}
+
+int request_resource(struct resource *root, struct resource *new)
+{
+	new->parent = root;
+	new->type = get_resource_type(new);
+
+	if (!new->type)
+		return -EINVAL;
+
+	return resource_register(new);
+}
+
+EXPORT_SYMBOL(request_resource);
+
+struct resource *____request_resource(struct resource *root, struct resource *new)
+{
+	struct resource *conflict;
+	struct res_type *type = get_resource_type(new);
+
+	new->parent = root;
+	new->type = get_resource_type(new);
+
+	down_write(&type->rwsem);
+	__resource_register(new, NULL, &conflict);
+	up_write(&type->rwsem);
+	return conflict;
+}
+
+EXPORT_SYMBOL(____request_resource);
+
+int release_resource(struct resource *old)
+{
+	return resource_unregister(old);
+}
+
+EXPORT_SYMBOL(release_resource);
+
+/*
+ * Find empty slot in the resource tree given range and alignment.
+ */
+static int find_resource(struct resource *root, struct resource *new,
+			 unsigned long size,
+			 unsigned long min, unsigned long max,
+			 unsigned long align,
+			 void (*alignf)(void *, struct resource *,
+					unsigned long, unsigned long),
+			 void *alignf_data)
+{
+	struct resource *this = root->child;
+
+	new->start = root->start;
+	/*
+	 * Skip past an allocated resource that starts at 0, since the assignment
+	 * of this->start - 1 to new->end below would cause an underflow.
+	 */
+	if (this && this->start == 0) {
+		new->start = this->end + 1;
+		this = this->sibling;
+	}
+	for(;;) {
+		if (this)
+			new->end = this->start - 1;
+		else
+			new->end = root->end;
+		if (new->start < min)
+			new->start = min;
+		if (new->end > max)
+			new->end = max;
+		new->start = (new->start + align - 1) & ~(align - 1);
+		if (alignf)
+			alignf(alignf_data, new, size, align);
+		if (new->start < new->end && new->end - new->start + 1 >= size) {
+			new->end = new->start + size - 1;
+			return 0;
+		}
+		if (!this)
+			break;
+		new->start = this->end + 1;
+		this = this->sibling;
+	}
+	return -EBUSY;
+}
+
+/*
+ * Allocate empty slot in the resource tree given range and alignment.
+ */
+int allocate_resource(struct resource *root, struct resource *new,
+		      unsigned long size,
+		      unsigned long min, unsigned long max,
+		      unsigned long align,
+		      void (*alignf)(void *, struct resource *,
+				     unsigned long, unsigned long),
+		      void *alignf_data)
+{
+	int err;
+	struct res_type *type = get_resource_type(root);
+	if (!type)
+		return -EINVAL;
+
+	new->type = type;
+	new->parent = root;
+
+	down_write(&type->rwsem);
+	err = find_resource(root, new, size, min, max, align, alignf, alignf_data);
+	if (err >= 0 && __resource_register(new, NULL, NULL))
+		err = -EBUSY;
+	up_write(&type->rwsem);
+	return err;
+}
+
+EXPORT_SYMBOL(allocate_resource);
+
+/*
+ * This is compatibility stuff for IO resources.
+ *
+ * Note how this, unlike the above, knows about
+ * the IO flag meanings (busy etc).
+ *
+ * Request-region creates a new busy region.
+ *
+ * Check-region returns non-zero if the area is already busy
+ *
+ * Release-region releases a matching busy region.
+ */
+struct resource * __request_region(struct resource *parent, unsigned long start, unsigned long n, const char *name)
+{
+	struct resource *res = kmalloc(sizeof(*res), GFP_KERNEL);
+	struct res_type *type = get_resource_type(parent);
+	if (!type)
+		return NULL;
+
+	if (res) {
+		memset(res, 0, sizeof(*res));
+		res->name = name;
+		res->start = start;
+		res->end = start + n - 1;
+		res->flags = IORESOURCE_BUSY;
+		res->type = type;
+
+		down_write(&type->rwsem);
+
+		for (;;) {
+			struct resource *conflict;
+
+			conflict = ____request_resource(parent, res);
+			if (!conflict)
+				break;
+			if (conflict != parent) {
+				parent = conflict;
+				if (!(conflict->flags & IORESOURCE_BUSY))
+					continue;
+			}
+
+			/* Uhhuh, that didn't work out.. */
+			kfree(res);
+			res = NULL;
+			break;
+		}
+		up_write(&type->rwsem);
+	}
+	return res;
+}
+
+EXPORT_SYMBOL(__request_region);
+
+int __deprecated __check_region(struct resource *parent, unsigned long start, unsigned long n)
+{
+	struct resource * res;
+
+	res = __request_region(parent, start, n, "check-region");
+	if (!res)
+		return -EBUSY;
+
+	release_resource(res);
+	kfree(res);
+	return 0;
+}
+
+EXPORT_SYMBOL(__check_region);
+
+void __release_region(struct resource *parent, unsigned long start, unsigned long n)
+{
+	struct resource **p;
+	unsigned long end;
+	struct res_type *type = get_resource_type(parent);
+	if (!type)
+		return;
+
+	p = &parent->child;
+	end = start + n - 1;
+
+	down_write(&type->rwsem);
+
+	for (;;) {
+		struct resource *res = *p;
+
+		if (!res)
+			break;
+		if (res->start <= start && res->end >= end) {
+			if (!(res->flags & IORESOURCE_BUSY)) {
+				p = &res->child;
+				continue;
+			}
+			if (res->start != start || res->end != end)
+				break;
+			*p = res->sibling;
+			up_write(&type->rwsem);
+			kfree(res);
+			return;
+		}
+		p = &res->sibling;
+	}
+
+	up_write(&type->rwsem);
+
+	printk(KERN_WARNING "Trying to free nonexistent resource <%08lx-%08lx>\n", start, end);
+}
+
+EXPORT_SYMBOL(__release_region);
+
+/*
+ * Called from init/main.c to reserve IO ports.
+ */
+#define MAXRESERVE 4
+static int __init reserve_setup(char *str)
+{
+	static int reserved;
+	static struct resource reserve[MAXRESERVE];
+
+	for (;;) {
+		int io_start, io_num;
+		int x = reserved;
+
+		if (get_option (&str, &io_start) != 2)
+			break;
+		if (get_option (&str, &io_num)   == 0)
+			break;
+		if (x < MAXRESERVE) {
+			struct resource *res = reserve + x;
+			res->name = "reserved";
+			res->start = io_start;
+			res->end = io_start + io_num - 1;
+			res->flags = IORESOURCE_BUSY;
+			res->child = NULL;
+			if (request_resource(res->start >= 0x10000 ? &iomem_resource : &ioport_resource, res) == 0)
+				reserved = x+1;
+		}
+	}
+	return 1;
+}
+
+__setup("reserve=", reserve_setup);
diff -urN a/drivers/base/resource/device.c b/drivers/base/resource/device.c
--- a/drivers/base/resource/device.c	1970-01-01 00:00:00.000000000 +0000
+++ b/drivers/base/resource/device.c	2004-08-18 10:57:37.000000000 +0000
@@ -0,0 +1,76 @@
+/*
+ * device.c - device specific functions
+ *
+ *
+ * This file is released under the GPLv2
+ *
+ * Copyright (c) 2004	Adam Belay
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/module.h>
+
+static DECLARE_MUTEX(device_state_mutex);
+
+int device_enable(struct device *dev)
+{
+	int ret;
+
+	down(&device_state_mutex);
+
+	ret = dev->bus->assign(dev);
+	if (ret) {
+		printk(KERN_ERR "RES: unable to assign resource for %s:%s\n",
+		 dev->bus ? dev->bus->name : "No Bus", dev->kobj.name);
+		up(&device_state_mutex);
+		return ret;
+	}
+
+	ret = dev->bus->enable(dev);
+	if (!ret)
+		dev->state = DEVICE_ENABLED;
+	up(&device_state_mutex);
+
+	return ret;
+}
+
+EXPORT_SYMBOL(device_enable);
+
+int device_disable(struct device *dev)
+{
+	int ret;
+
+	down(&device_state_mutex);
+	ret = dev->bus->disable(dev);
+	if (!ret)
+		dev->state = DEVICE_DISABLED;
+	up(&device_state_mutex);
+
+	return ret;
+}
+
+EXPORT_SYMBOL(device_disable);
+
+struct resource *
+device_find_resource(struct device *dev, struct res_type *type, int count)
+{
+	int i;
+
+	for (i = 0; i < dev->num_resources; i++) {
+		struct res_slot *slot = &dev->resource[i];
+
+		if (slot->type == type) {
+			if (count-- == 0) {
+				if (slot->res && resource_is_valid(slot->res))
+					return slot->res;
+				else
+					return NULL;
+			}
+		}
+	}
+	return NULL;
+}
+
+EXPORT_SYMBOL(device_find_resource);
diff -urN a/drivers/base/resource/main.c b/drivers/base/resource/main.c
--- a/drivers/base/resource/main.c	1970-01-01 00:00:00.000000000 +0000
+++ b/drivers/base/resource/main.c	2004-08-17 21:51:40.000000000 +0000
@@ -0,0 +1,32 @@
+/*
+ * drivers/base/resource/main.c - links the driver model to resource management
+ *
+ * Copyright (c) 2004 Adam Belay
+ *
+ * This file is released under the GPLv2
+ *
+ * based on drivers/base/power/main.c (c) 2003 Patrick Mochel
+ */
+
+#include <linux/config.h>
+#include <linux/device.h>
+#include <linux/ioport.h>
+#include "resource.h"
+
+
+int device_res_add(struct device * dev)
+{
+	int error;
+
+	pr_debug("RES: Adding info for %s:%s\n",
+		 dev->bus ? dev->bus->name : "No Bus", dev->kobj.name);
+	error = res_sysfs_add(dev);
+	return error;
+}
+
+void device_res_remove(struct device * dev)
+{
+	pr_debug("RES: Removing info for %s:%s\n",
+		 dev->bus ? dev->bus->name : "No Bus", dev->kobj.name);
+	res_sysfs_remove(dev);
+}
diff -urN a/drivers/base/resource/proc.c b/drivers/base/resource/proc.c
--- a/drivers/base/resource/proc.c	1970-01-01 00:00:00.000000000 +0000
+++ b/drivers/base/resource/proc.c	2004-08-18 10:59:20.000000000 +0000
@@ -0,0 +1,128 @@
+/*
+ * proc.c - Procfs interface for Resource Management
+ *
+ * This file is released under the GPLv2
+ *
+ * Copyright (C) 1999	Linus Torvalds
+ * Copyright (C) 1999	Martin Mares <mj@ucw.cz>
+ * Copyright (C) 2004	Adam Belay
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/errno.h>
+#include <linux/ioport.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/fs.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#include <asm/io.h>
+#include <asm/irq.h>
+
+
+enum { MAX_IORES_LEVEL = 5 };
+
+static void *r_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	struct resource *p = v;
+	(*pos)++;
+	if (p->child)
+		return p->child;
+	while (!p->sibling && p->parent)
+		p = p->parent;
+	return p->sibling;
+}
+
+static void *r_start(struct seq_file *m, loff_t *pos)
+{
+	struct res_type *type = m->private;
+	struct resource *p = type->root;
+	loff_t l = 0;
+	down_read(&type->rwsem);
+	for (p = p->child; p && l < *pos; p = r_next(m, p, &l))
+		;
+	return p;
+}
+
+static void r_stop(struct seq_file *m, void *v)
+{
+	struct res_type *type = m->private;
+	up_read(&type->rwsem);
+}
+
+static int r_show(struct seq_file *m, void *v)
+{
+	struct res_type *type = m->private;
+	struct resource *root = type->root;
+	struct resource *r = v, *p;
+	int width = root->end < 0x10000 ? 4 : 8;
+	int depth;
+
+	for (depth = 0, p = r; depth < MAX_IORES_LEVEL; depth++, p = p->parent)
+		if (p->parent == root)
+			break;
+	seq_printf(m, "%*s%0*lx-%0*lx : %s\n",
+			depth * 2, "",
+			width, r->start,
+			width, r->end,
+			r->name ? r->name : "<BAD>");
+	return 0;
+}
+
+struct seq_operations resource_op = {
+	.start	= r_start,
+	.next	= r_next,
+	.stop	= r_stop,
+	.show	= r_show,
+};
+
+static int ioports_open(struct inode *inode, struct file *file)
+{
+	int res = seq_open(file, &resource_op);
+	if (!res) {
+		struct seq_file *m = file->private_data;
+		m->private = &ioport_res_type;
+	}
+	return res;
+}
+
+static int iomem_open(struct inode *inode, struct file *file)
+{
+	int res = seq_open(file, &resource_op);
+	if (!res) {
+		struct seq_file *m = file->private_data;
+		m->private = &iomem_res_type;
+	}
+	return res;
+}
+
+static struct file_operations proc_ioports_operations = {
+	.open		= ioports_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
+static struct file_operations proc_iomem_operations = {
+	.open		= iomem_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
+int __init res_proc_init(void)
+{
+	struct proc_dir_entry *entry;
+
+	entry = create_proc_entry("ioports", 0, NULL);
+	if (entry)
+		entry->proc_fops = &proc_ioports_operations;
+	entry = create_proc_entry("iomem", 0, NULL);
+	if (entry)
+		entry->proc_fops = &proc_iomem_operations;
+	return 0;
+}
diff -urN a/drivers/base/resource/resource.c b/drivers/base/resource/resource.c
--- a/drivers/base/resource/resource.c	1970-01-01 00:00:00.000000000 +0000
+++ b/drivers/base/resource/resource.c	2004-08-18 10:49:58.000000000 +0000
@@ -0,0 +1,252 @@
+/*
+ * resource.c - core resource management infustructure.
+ *
+ *
+ * This file is released under the GPLv2
+ *
+ * Copyright (C) 1999	Linus Torvalds
+ * Copyright (C) 1999	Martin Mares <mj@ucw.cz>
+ * Copyright (c) 2004	Adam Belay
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/ioport.h>
+#include <linux/init.h>
+#include <linux/spinlock.h>
+#include <linux/device.h>
+#include <asm/io.h>
+#include <asm/irq.h>
+
+#include "resource.h"
+
+
+struct resource * get_resource(struct resource *res)
+{
+	return res ? container_of(kobject_get(&res->kobj),
+				  struct resource, kobj) : NULL;
+}
+
+EXPORT_SYMBOL(get_resource);
+
+void put_resource(struct resource *res)
+{
+	kobject_put(&res->kobj);
+}
+
+EXPORT_SYMBOL(put_resource);
+
+/*
+ * resource_checkin - adds a resource to the internal list
+ *
+ * @new - the resource to be checked in
+ * @from - defines a starting point, must be a sibling of "new", can be NULL
+ *
+ * - res->type->lock must be held before calling
+ * - returns the conflicting entry if it fails.
+ */
+
+static struct resource *
+resource_checkin(struct resource *new, struct resource *from)
+{
+	unsigned long start = new->start;
+	unsigned long end = new->end;
+	struct resource *tmp, **p;
+	struct resource *root = new->parent;
+
+	if (start < root->start)
+		return root;
+	if (!from)
+		p = &root->child;
+	else
+		p = &from->sibling;
+
+	if (new->flags & IORESOURCE_SINGLE) {
+		if ((root->flags & IORESOURCE_SINGLE) ?
+		     (new->start != root->start) :
+		     (start > root->end))
+			return root;
+		for (;;) {
+			tmp = *p;
+			if (!tmp || tmp->start > start)
+				goto success;
+			p = &tmp->sibling;
+			if (tmp->start < start)
+				continue;
+			if (new->flags & tmp->flags & IORESOURCE_SHARABLE)
+				goto success;
+			return tmp;
+		}
+	} else {
+		if (end < start)
+			return root;
+		if (end > root->end)
+			return root;
+		for (;;) {
+			tmp = *p;
+			if (!tmp || tmp->start > end)
+				goto success;
+			p = &tmp->sibling;
+			if (tmp->end < start)
+				continue;
+			return tmp;
+		}
+	}
+
+success:
+	new->sibling = tmp;
+	*p = new;
+	new->parent = root;
+	new->flags |= IORESOURCE_REGISTERED;
+	return NULL;
+}
+
+/*
+ * resource_checkout - removes a resource from the internal list
+ *
+ * @old - the resource to be checked out
+ *
+ * - res->type->lock must be held before calling
+ * - will fail if the resource was never checked in
+ */
+
+static int resource_checkout(struct resource *old)
+{
+	struct resource *tmp, **p;
+
+	p = &old->parent->child;
+	for (;;) {
+		tmp = *p;
+		if (!tmp)
+			break;
+		if (tmp == old) {
+			*p = tmp->sibling;
+			old->parent = NULL;
+			old->flags &= ~IORESOURCE_REGISTERED;
+			return 0;
+		}
+		p = &tmp->sibling;
+	}
+	return -EINVAL;
+}
+
+/*
+ * __resource_register - registers a resource with the resource manager
+ *
+ * @res - the resource to be registered
+ * @from - specifies a starting point in the resource tree (speed optimization)
+ * @conflict - an optional place to store the conflicting resource
+ *
+ * - res->type->lock must be held before calling
+ * - "from" should be NULL if not used
+ */
+
+int __resource_register(struct resource *res, struct resource *from,
+			struct resource **conflict)
+{
+	int ret;
+
+	if (!res->type->ranged)
+		res->flags |= IORESOURCE_SINGLE;
+	if (!res->parent)
+		res->parent = res->type->root;
+	if (res->dev && (res->dev->state == DEVICE_ENABLED))
+		res->flags |= IORESOURCE_BIOS_SET;
+
+	if ((res = resource_checkin(res, from))) {
+		if (conflict)
+			*conflict = res;
+		return -EBUSY;
+	}
+	if (conflict)
+		*conflict = NULL;
+
+	if((ret = kobject_set_name(&res->kobj, "0x%016lx", res->start))) {
+		resource_checkout(res);
+		return ret;
+	}
+	res->kobj.kset = &res->type->subsys.kset;
+	res->kobj.parent = &res->parent->kobj;
+	if ((ret = kobject_register(&res->kobj))) {
+		resource_checkout(res);
+		return ret;
+	}
+
+	if (res->dev) {
+		get_device(res->dev);
+		sysfs_create_link(&res->kobj, &res->dev->kobj, "device");
+	}
+
+	return 0;
+}
+
+/*
+ * __resource_unregister - unregisters a resource from the resource manager
+ *
+ * @res - the resource to be registered
+ *
+ * - res->type->lock must be held before calling
+ */
+
+int __resource_unregister(struct resource *res)
+{
+	int ret;
+
+	sysfs_remove_link(&res->kobj, "device");
+	ret = resource_checkout(res);
+	if (ret)
+		return ret;
+	kobject_unregister(&res->kobj);
+	return 0;
+}
+
+/*
+ * resource_register - registers a resource with the resource manager
+ *
+ * @res - the resource to be registered
+ *
+ * - it is assumed that "name", "start", "stop" (if ranged), "flags", "parent",
+ *	"dev", and "type" are set before calling this function
+ * - "dev" is not currently required in order to maintain backward compatibility,
+ *	but any new code is expected to support it.
+ */
+
+int resource_register(struct resource *res)
+{
+	int ret;
+
+	down_write(&res->type->rwsem);
+	if (!(res->flags & IORESOURCE_REGISTERED))
+		ret = __resource_register(res, NULL, NULL);
+	else
+		ret = -EINVAL;
+	up_write(&res->type->rwsem);
+	return ret;
+}
+
+EXPORT_SYMBOL(resource_register);
+
+/*
+ * resource_unregister - unregisters a resource from the resource manager
+ *
+ * @res - the resource to be unregistered
+ */
+
+int resource_unregister(struct resource *res)
+{
+	int ret;
+
+	down_write(&res->type->rwsem);
+	if (res->flags & IORESOURCE_REGISTERED &&
+	   !(res->dev && res->dev->state == DEVICE_ENABLED))
+		ret = __resource_unregister(res);
+	else
+		ret = -EINVAL;
+	up_write(&res->type->rwsem);
+	return ret;
+}
+
+EXPORT_SYMBOL(resource_unregister);
+
diff -urN a/drivers/base/resource/resource.h b/drivers/base/resource/resource.h
--- a/drivers/base/resource/resource.h	1970-01-01 00:00:00.000000000 +0000
+++ b/drivers/base/resource/resource.h	2004-08-17 23:06:48.000000000 +0000
@@ -0,0 +1,34 @@
+/*
+ * resource.h - internal resource management header
+ *
+ *
+ * This file is released under the GPLv2
+ *
+ * Copyright (c) 2004	Adam Belay
+ *
+ */
+
+#include <linux/config.h>
+
+
+struct resource_attribute {
+	struct attribute	attr;
+	ssize_t (*show)(struct resource *res, char *buf);
+	ssize_t (*store)(struct resource *res, const char *buf, size_t count);
+};
+
+extern int __resource_register(struct resource *res, struct resource *from,
+			       struct resource **conflict);
+extern int __resource_unregister(struct resource *res);
+
+#ifdef CONFIG_PROC_FS
+extern int res_proc_init(void);
+#else
+static inline int res_proc_init(void) { return 0; }
+#endif /* CONFIG_PROC_FS */
+
+extern int res_sysfs_add(struct device *dev);
+extern void res_sysfs_remove(struct device *dev);
+
+extern int device_res_add(struct device *);
+extern void device_res_remove(struct device *);
diff -urN a/drivers/base/resource/slot.c b/drivers/base/resource/slot.c
--- a/drivers/base/resource/slot.c	1970-01-01 00:00:00.000000000 +0000
+++ b/drivers/base/resource/slot.c	2004-08-17 23:41:04.000000000 +0000
@@ -0,0 +1,108 @@
+/*
+ * slot.c - functions to assist in storing and releasing resources.
+ *
+ *
+ * This file is released under the GPLv2
+ *
+ * Copyright (c) 2004	Adam Belay
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/ioport.h>
+#include <linux/slab.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+
+#include "resource.h"
+
+static DECLARE_MUTEX(slot_mutex);
+
+static int __res_slot_release(struct res_slot *slot)
+{
+	int err;
+	if (!slot->res)
+		return -EINVAL;
+	if ((err = resource_unregister(slot->res)))
+		return err;
+	slot->res = NULL;
+	return 0;
+}
+
+int res_slot_allocate(struct res_slot *slot)
+{
+	int err;
+
+	down(&slot_mutex);
+	if (slot->res) {
+		if (resource_is_assigned(slot->res)) {
+			if ((err = __res_slot_release(slot))) {
+				up(&slot_mutex);
+				return err;
+			}
+		}
+	} else {
+		slot->res = kmalloc(sizeof(struct resource), GFP_KERNEL);
+		if (!slot->res) {
+			up(&slot_mutex);
+			return -ENOMEM;
+		}
+	}
+
+	memset(slot->res, 0, sizeof(struct resource));
+	slot->res->type = slot->type;
+
+	up(&slot_mutex);
+	return 0;
+}
+
+EXPORT_SYMBOL(res_slot_allocate);
+
+int res_slot_release(struct res_slot *slot)
+{
+	int ret;
+	down(&slot_mutex);
+	ret = __res_slot_release(slot);
+	up(&slot_mutex);
+	return ret;
+}
+
+EXPORT_SYMBOL(res_slot_release);
+
+int device_clear_slots(struct device *dev)
+{
+	int i, ret = 0;
+
+	down(&slot_mutex);
+	for (i = 0; i < dev->num_resources; i++)
+		if ((ret = __res_slot_release(&dev->resource[i])))
+			break;
+	up(&slot_mutex);
+
+	return ret;
+}
+
+EXPORT_SYMBOL(device_clear_slots);
+
+int device_clean_slots(struct device *dev)
+{
+	int i, ret = 0;
+
+	down(&slot_mutex);
+	for (i = 0; i < dev->num_resources; i++) {
+		struct resource *res = dev->resource[i].res;
+		if (!res)
+			continue;
+		if (res->flags & IORESOURCE_MANUALLY_SET)
+			continue;
+		if ((ret = __res_slot_release(&dev->resource[i])))
+			break;
+	}
+	up(&slot_mutex);
+
+	return ret;
+}
+
+EXPORT_SYMBOL(device_clean_slots);
diff -urN a/drivers/base/resource/sysfs.c b/drivers/base/resource/sysfs.c
--- a/drivers/base/resource/sysfs.c	1970-01-01 00:00:00.000000000 +0000
+++ b/drivers/base/resource/sysfs.c	2004-08-17 23:26:06.000000000 +0000
@@ -0,0 +1,198 @@
+/*
+ * sysfs.c - sysfs interface for userspace resource management.
+ *
+ *
+ * This file is released under the GPLv2
+ *
+ * Copyright (c) 2004	Adam Belay
+ *
+ * Based on drivers/base/power/sysfs.c
+ *
+ */
+
+#include <linux/device.h>
+#include <linux/ctype.h>
+
+#include "resource.h"
+
+
+/*
+ * resource tree interface
+ */
+
+#define RESOURCE_ATTR(_name,_show)	\
+struct resource_attribute res_attr_##_name = __ATTR(_name,0444,_show,NULL)
+
+static ssize_t length_show(struct resource *res, char * buf)
+{
+	return sprintf(buf, "0x%lx\n", resource_length(res));
+}
+
+static RESOURCE_ATTR(length, length_show);
+
+static ssize_t sharable_show(struct resource *res, char * buf)
+{
+	int share_disposition = (res->flags & IORESOURCE_SHARABLE) ? 1 : 0;
+	return sprintf(buf, "%u\n", share_disposition);
+}
+
+static RESOURCE_ATTR(sharable, sharable_show);
+
+static ssize_t config_show(struct resource *res, char * buf)
+{
+	char *config;
+	if (res->flags & IORESOURCE_BIOS_SET)
+		config = "bios";
+	else if (res->flags & IORESOURCE_MANUALLY_SET)
+		config = "manual";
+	else
+		config = "auto";
+
+	return sprintf(buf, "%s\n", config);
+}
+
+static RESOURCE_ATTR(config, config_show);
+
+static ssize_t flags_show(struct resource *res, char * buf)
+{
+	return sprintf(buf, "0x%4lx\n", res->flags & IORESOURCE_BITS);
+}
+
+static RESOURCE_ATTR(flags, flags_show);
+
+
+struct attribute * res_ranged_default_attrs[] = {
+	&res_attr_length.attr,
+	&res_attr_config.attr,
+	&res_attr_flags.attr,
+	NULL,
+};
+
+struct attribute * res_single_default_attrs[] = {
+	&res_attr_sharable.attr,
+	&res_attr_config.attr,
+	&res_attr_flags.attr,
+	NULL,
+};
+
+
+/*
+ * device interface
+ */
+
+static ssize_t state_show(struct device * dev, char * buf)
+{
+	char * state = dev->state ? "enabled" : "disabled";
+	return sprintf(buf, "%s\n", state);
+}
+
+static ssize_t state_store(struct device * dev, const char * buf, size_t n)
+{
+	int ret = 0;
+
+	if (!strnicmp(buf,"enable",6)) {
+		ret = device_enable(dev);
+		goto done;
+	}
+
+	if (!strnicmp(buf,"disable",7))
+		ret = device_disable(dev);
+
+done:
+	return ret ? ret : n;
+}
+
+static DEVICE_ATTR(state, 0644, state_show, state_store);
+
+static ssize_t resources_show(struct device * dev, char * buf)
+{
+	char * str = buf;
+	int i;
+
+	for (i = 0; i < dev->num_resources; i++) {
+		struct res_slot *slot = &dev->resource[i];
+		str += sprintf(str, "%u %s ", i+1, slot->type->name);
+		if (!slot->res)
+			str += sprintf(str, "unset\n");
+		else if (slot->res->flags & IORESOURCE_DISABLED)
+			str += sprintf(str, "disabled\n");
+		else {
+			str += sprintf(str, "0x%016lx", slot->res->start);
+			if (!(slot->res->flags & IORESOURCE_SINGLE))
+				str += sprintf(str, "-0x%016lx", slot->res->end);
+			str += sprintf(str, " 0x%4lx\n", slot->res->flags & IORESOURCE_BITS);
+		}
+	}
+
+	return (str - buf);
+}
+
+static ssize_t resources_store(struct device * dev, const char * buf, size_t n)
+{
+	int index;
+	char * rest;
+	int err = 0;
+	struct res_slot *slot;
+
+	if (!strnicmp(buf,"clear",5)) {
+		err = device_clear_slots(dev);
+		goto done;
+	}
+
+	index = simple_strtoul(buf, &rest, 10);
+	if (!index || index > dev->num_resources) {
+		err = -EINVAL;
+		goto done;
+	}
+
+	slot = &dev->resource[index-1];
+	if ((err = res_slot_allocate(slot)))
+		goto done;
+
+	while (isspace(*buf))
+		++buf;
+	slot->res->start = simple_strtoul(rest, &rest, 0);
+
+	while (isspace(*buf))
+		++buf;
+	if(*buf == '-') {
+		buf += 1;
+		while (isspace(*buf))
+			++buf;
+		slot->res->end = simple_strtoul(rest, &rest, 0);
+	}
+
+	while (isspace(*buf))
+		++buf;
+	slot->res->flags = simple_strtoul(rest, &rest, 0);
+
+	if ((err = resource_register(slot->res)))
+		res_slot_release(slot);
+
+done:
+	return err ? err : n;
+}
+
+static DEVICE_ATTR(resources, 0644, resources_show, resources_store);
+
+
+static struct attribute * resource_attrs[] = {
+	&dev_attr_state.attr,
+	&dev_attr_resources.attr,
+	NULL,
+};
+
+static struct attribute_group res_attr_group = {
+	.name	= "resource",
+	.attrs	= resource_attrs,
+};
+
+int res_sysfs_add(struct device * dev)
+{
+	return sysfs_create_group(&dev->kobj, &res_attr_group);
+}
+
+void res_sysfs_remove(struct device * dev)
+{
+	sysfs_remove_group(&dev->kobj, &res_attr_group);
+}
diff -urN a/drivers/base/resource/types.c b/drivers/base/resource/types.c
--- a/drivers/base/resource/types.c	1970-01-01 00:00:00.000000000 +0000
+++ b/drivers/base/resource/types.c	2004-08-18 10:48:29.000000000 +0000
@@ -0,0 +1,246 @@
+/*
+ * types.c - functions for tracking the various types of resources
+ *
+ *
+ * This file is released under the GPLv2
+ *
+ * Copyright (C) 1999	Linus Torvalds
+ * Copyright (C) 1999	Martin Mares <mj@ucw.cz>
+ * Copyright (c) 2004	Adam Belay
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/ioport.h>
+#include <linux/init.h>
+#include <linux/spinlock.h>
+#include <linux/device.h>
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/dma.h>
+
+#include "resource.h"
+
+
+decl_subsys(resource, NULL, NULL);
+
+/*
+ * common resource types
+ */
+
+struct resource ioport_resource = {
+	.name	= "ioport root",
+	.start	= 0x0000,
+	.end	= IO_SPACE_LIMIT,
+	.flags  = IORESOURCE_IO,
+};
+
+EXPORT_SYMBOL(ioport_resource);
+
+struct res_type ioport_res_type = {
+	.name   = "ioport",
+	.root   = &ioport_resource,
+	.ranged = 1,
+};
+
+EXPORT_SYMBOL(ioport_res_type);
+
+struct resource iomem_resource = {
+	.name	= "mem root",
+	.start	= 0UL,
+	.end	= ~0UL,
+	.flags  = IORESOURCE_MEM,
+};
+
+EXPORT_SYMBOL(iomem_resource);
+
+struct res_type iomem_res_type = {
+	.name   = "mem",
+	.root   = &iomem_resource,
+	.ranged = 1,
+};
+
+EXPORT_SYMBOL(iomem_res_type);
+
+struct resource irq_resource = {
+	.name  = "irq root",
+	.start = 0,
+	.end   = NR_IRQS,
+	.flags = IORESOURCE_IRQ,
+};
+
+struct res_type irq_res_type = {
+	.name   = "irq",
+	.root   = &irq_resource,
+	.ranged = 0,
+};
+
+EXPORT_SYMBOL(irq_res_type);
+
+struct resource dma_resource = {
+	.name  = "dma root",
+	.start = 0,
+	.end   = MAX_DMA_CHANNELS,
+	.flags = IORESOURCE_DMA,
+};
+
+struct res_type dma_res_type = {
+	.name   = "dma",
+	.root   = &dma_resource,
+	.ranged = 0,
+};
+
+EXPORT_SYMBOL(dma_res_type);
+
+
+/*
+ * reference counting for types
+ */
+
+struct res_type * get_res_type(struct res_type *type)
+{
+	return type ? container_of(subsys_get(&type->subsys),
+				   struct res_type, subsys) : NULL;
+}
+
+EXPORT_SYMBOL(get_res_type);
+
+void put_res_type(struct res_type *type)
+{
+	subsys_put(&type->subsys);
+}
+
+EXPORT_SYMBOL(put_res_type);
+
+
+/*
+ * sysfs bindings for resources
+ */
+
+#define to_res_attr(_attr) container_of(_attr, struct resource_attribute, attr)
+#define to_resource(obj) container_of(obj, struct resource, kobj)
+
+extern struct attribute * res_ranged_default_attrs[];
+extern struct attribute * res_single_default_attrs[];
+
+static ssize_t
+res_attr_show(struct kobject * kobj, struct attribute * attr, char * buf)
+{
+	struct resource_attribute *res_attr = to_res_attr(attr);
+	struct resource *res = to_resource(kobj);
+	ssize_t ret = 0;
+
+	if (res_attr->show)
+		ret = res_attr->show(res, buf);
+	return ret;
+}
+
+static ssize_t
+res_attr_store(struct kobject * kobj, struct attribute * attr,
+	       const char * buf, size_t count)
+{
+	struct resource_attribute *res_attr = to_res_attr(attr);
+	struct resource *res = to_resource(kobj);
+	ssize_t ret = 0;
+
+	if (res_attr->store)
+		ret = res_attr->store(res, buf, count);
+	return ret;
+}
+
+static struct sysfs_ops resource_sysfs_ops = {
+	.show	= res_attr_show,
+	.store	= res_attr_store,
+};
+
+
+static void resource_release(struct kobject * kobj)
+{
+	struct resource *res = to_resource(kobj);
+	if (res->dev || (res->flags & IORESOURCE_REQUEST_REGION)) {
+		kfree(res);
+	}
+
+	if (res->dev)
+		put_device(res->dev);
+}
+
+static struct kobj_type ktype_res_ranged = {
+	.sysfs_ops	= &resource_sysfs_ops,
+	.release	= resource_release,
+	.default_attrs	= res_ranged_default_attrs,
+};
+
+static struct kobj_type ktype_res_single = {
+	.sysfs_ops	= &resource_sysfs_ops,
+	.release	= resource_release,
+	.default_attrs	= res_single_default_attrs,
+};
+
+
+/*
+ * registration for types
+ */
+
+int res_type_register(struct res_type *type)
+{
+	int ret;
+	init_rwsem(&type->rwsem);
+
+	if ((ret = kobject_set_name(&type->subsys.kset.kobj, type->name)))
+		return ret;
+
+	subsys_set_kset(type, resource_subsys);
+	if (type->ranged)
+		type->subsys.kset.ktype = &ktype_res_ranged;
+	else
+		type->subsys.kset.ktype = &ktype_res_single;
+	if ((ret = subsystem_register(&type->subsys)))
+		return ret;
+
+	type->root->flags |= IORESOURCE_REGISTERED;
+	if((ret = kobject_set_name(&type->root->kobj, "0x%016lx",
+				   type->root->start))) {
+		subsystem_unregister(&type->subsys);
+		return ret;
+	}
+	type->root->kobj.kset = &type->subsys.kset;
+	if ((ret = kobject_register(&type->root->kobj))) {
+		subsystem_unregister(&type->subsys);
+		return ret;
+	}
+
+	return 0;
+}
+
+EXPORT_SYMBOL(res_type_register);
+
+void res_type_unregister(struct res_type *type)
+{
+	resource_unregister(type->root);
+	subsystem_unregister(&type->subsys);
+}
+
+EXPORT_SYMBOL(res_type_unregister);
+
+
+/*
+ * initialization
+ */
+
+int __init resource_init(void)
+{
+	int ret;
+	ret = subsystem_register(&resource_subsys);
+	if (ret)
+		return ret;
+
+	res_type_register(&ioport_res_type);
+	res_type_register(&iomem_res_type);
+	res_type_register(&irq_res_type);
+	res_type_register(&dma_res_type);
+	res_proc_init();
+	return 0;
+}
diff -urN a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	2004-08-05 13:06:25.000000000 +0000
+++ b/include/linux/device.h	2004-08-17 22:30:47.000000000 +0000
@@ -41,6 +41,11 @@
 	RESUME_ENABLE,
 };
 
+enum {
+	DEVICE_DISABLED,
+	DEVICE_ENABLED,
+};
+
 struct device;
 struct device_driver;
 struct class;
@@ -62,6 +67,12 @@
 	struct device * (*add)	(struct device * parent, char * bus_id);
 	int		(*hotplug) (struct device *dev, char **envp,
 				    int num_envp, char *buffer, int buffer_size);
+
+	int		(*assign)(struct device *dev);
+	int		(*verify)(struct resource *res, unsigned long *next);
+	int		(*enable)(struct device *dev);
+	int		(*disable)(struct device *dev);
+
 	int		(*suspend)(struct device * dev, u32 state);
 	int		(*resume)(struct device * dev);
 };
@@ -276,6 +287,9 @@
 	u32		detach_state;	/* State to enter when device is
 					   detached from its driver. */

+	int		state;		/* resource management state */
+	int		num_resources;
+	struct res_slot	* resource;
 	u64		*dma_mask;	/* dma mask (if dma'able device) */
 	u64		coherent_dma_mask;/* Like dma_mask, but for
 					     alloc_coherent mappings as
diff -urN a/include/linux/ioport.h b/include/linux/ioport.h
--- a/include/linux/ioport.h	2004-07-26 10:35:12.000000000 +0000
+++ b/include/linux/ioport.h	2004-08-18 10:46:43.000000000 +0000
@@ -2,85 +2,192 @@
  * ioport.h	Definitions of routines for detecting, reserving and
  *		allocating system resources.
  *
- * Authors:	Linus Torvalds
+ * Authors:	Linus Torvalds, Adam Belay
  */

 #ifndef _LINUX_IOPORT_H
 #define _LINUX_IOPORT_H

 #include <linux/compiler.h>
+#include <linux/kobject.h>
+
+
+struct device;
+
 /*
- * Resources are tree-like, allowing
- * nesting etc..
+ * system resource management
  */
+
 struct resource {
+	struct kobject		kobj;
+
 	const char *name;
-	unsigned long start, end;
+	unsigned long		start;
+	unsigned long		end;
 	unsigned long flags;
-	struct resource *parent, *sibling, *child;
+
+	struct resource		*parent;
+	struct resource		*child;
+	struct resource		*sibling;
+
+	struct device		*dev;
+	struct res_type		*type;
 };

-struct resource_list {
-	struct resource_list *next;
+static inline unsigned long resource_length(struct resource *res)
+{
+	return (res->end - res->start + 1);
+}
+
+/* resource type */
+#define IORESOURCE_IO			0x00010000
+#define IORESOURCE_MEM			0x00020000
+#define IORESOURCE_IRQ			0x00040000
+#define IORESOURCE_DMA			0x00080000
+
+static inline int resource_is_type(struct resource *res, struct res_type *type)
+{
+	return (res->type == type);
+}
+
+/* general flags */
+#define IORESOURCE_UNSET		0x00100000
+#define IORESOURCE_DISABLED		0x00200000
+#define IORESOURCE_SHARABLE		0x00400000
+#define IORESOURCE_SINGLE		0x00800000
+#define IORESOURCE_REGISTERED		0x01000000
+#define IORESOURCE_MANUALLY_SET		0x02000000
+#define IORESOURCE_BIOS_SET		0x04000000
+#define IORESOURCE_BUSY			0x08000000
+#define IORESOURCE_REQUEST_REGION	0x10000000
+
+static inline int resource_is_assigned(struct resource *res)
+{
+	return (res->flags & IORESOURCE_REGISTERED);
+}
+
+static inline int resource_is_valid(struct resource *res)
+{
+	return ((res->flags & (IORESOURCE_UNSET | IORESOURCE_DISABLED |
+		IORESOURCE_REGISTERED)) == IORESOURCE_REGISTERED);
+}
+
+/* bus and resource specific flags */
+#define IORESOURCE_BITS			0x0000ffff
+
+#define IORESOURCE_IO_DECODE_10		0x00000001
+#define IORESOURCE_IO_DECODE_12		0x00000002
+
+#define IORESOURCE_MEM_WIDTH_8		0x00000001
+#define IORESOURCE_MEM_WIDTH_16		0x00000002
+#define IORESOURCE_MEM_WIDTH_32		0x00000004
+#define IORESOURCE_MEM_WIDTH_64		0x00000008
+#define IORESOURCE_MEM_PREFETCH		0x00000010
+#define IORESOURCE_MEM_READONLY		0x00000020
+#define IORESOURCE_MEM_CACHEABLE	0x00000040
+
+#define IORESOURCE_IRQ_EDGE_HIGH	0x00000001
+#define IORESOURCE_IRQ_EDGE_LOW		0x00000002
+#define IORESOURCE_IRQ_LEVEL_HIGH	0x00000004
+#define IORESOURCE_IRQ_LEVEL_LOW	0x00000008
+
+#define IORESOURCE_DMA_ISA_COMPAT	0x00000001
+#define IORESOURCE_DMA_TYPEA		0x00000002
+#define IORESOURCE_DMA_TYPEB		0x00000004
+#define IORESOURCE_DMA_TYPEF		0x00000008
+#define IORESOURCE_DMA_TRANS_8		0x00000010
+#define IORESOURCE_DMA_TRANS_8_16	0x00000020
+#define IORESOURCE_DMA_TRANS_16		0x00000040
+#define IORESOURCE_DMA_BUS_MASTER	0x00000080
+
+#define IORESOURCE_PREFETCH		0x00000100	/* No side effects */
+#define IORESOURCE_READONLY		0x00000200
+#define IORESOURCE_CACHEABLE		0x00000400
+#define IORESOURCE_RANGELENGTH		0x00000800
+#define IORESOURCE_SHADOWABLE		0x00001000
+#define IORESOURCE_BUS_HAS_VGA		0x00002000
+
+extern int resource_register(struct resource *res);
+extern int resource_unregister(struct resource *res);
+
+extern struct resource * get_resource(struct resource *res);
+extern void put_resource(struct resource *res);
+
+
+/*
+ * resource types
+ */
+
+struct  res_type {
+	const char		*name;
+
+	struct subsystem	subsys;
+	struct rw_semaphore	rwsem;
+
+	struct resource		*root;
+	int			ranged;
+};
+
+extern struct res_type ioport_res_type;
+extern struct res_type iomem_res_type;
+extern struct res_type irq_res_type;
+extern struct res_type dma_res_type;
+
+extern int res_type_register(struct res_type *type);
+extern void res_type_unregister(struct res_type *type);
+
+extern struct res_type * get_res_type(struct res_type *type);
+extern void put_res_type(struct res_type *type);
+
+
+/*
+ * resource slots
+ */
+
+struct res_slot {
+	struct res_type		*type;
 	struct resource *res;
-	struct pci_dev *dev;
 };

+extern int res_slot_allocate(struct res_slot *slot);
+extern int res_slot_release(struct res_slot *slot);
+
+
+/*
+ * resource assignment
+ */
+
+extern int
+resource_assign(struct resource *res, int ordered, unsigned long *next);
+
+/* assignment helpers */
+extern int res_assign_range(struct resource *res, unsigned long min,
+			    unsigned long max, unsigned long length,
+			    unsigned long align);
+
+
+/*
+ * device resource management
+ */
+
+extern int device_enable(struct device *dev);
+extern int device_disable(struct device *dev);
+extern int device_clear_slots(struct device *dev);
+extern int device_clean_slots(struct device *dev);
+
+extern struct resource *
+device_find_resource(struct device *dev, struct res_type *type, int count);
+
+
 /*
- * IO resources have these defined flags.
+ * Compatibility with previous implementation
  */
-#define IORESOURCE_BITS		0x000000ff	/* Bus-specific bits */
 
-#define IORESOURCE_IO		0x00000100	/* Resource type */
-#define IORESOURCE_MEM		0x00000200
-#define IORESOURCE_IRQ		0x00000400
-#define IORESOURCE_DMA		0x00000800
-
-#define IORESOURCE_PREFETCH	0x00001000	/* No side effects */
-#define IORESOURCE_READONLY	0x00002000
-#define IORESOURCE_CACHEABLE	0x00004000
-#define IORESOURCE_RANGELENGTH	0x00008000
-#define IORESOURCE_SHADOWABLE	0x00010000
-#define IORESOURCE_BUS_HAS_VGA	0x00080000
-
-#define IORESOURCE_DISABLED	0x10000000
-#define IORESOURCE_UNSET	0x20000000
-#define IORESOURCE_AUTO		0x40000000
-#define IORESOURCE_BUSY		0x80000000	/* Driver has marked this resource busy */
-
-/* ISA PnP IRQ specific bits (IORESOURCE_BITS) */
-#define IORESOURCE_IRQ_HIGHEDGE		(1<<0)
-#define IORESOURCE_IRQ_LOWEDGE		(1<<1)
-#define IORESOURCE_IRQ_HIGHLEVEL	(1<<2)
-#define IORESOURCE_IRQ_LOWLEVEL		(1<<3)
-
-/* ISA PnP DMA specific bits (IORESOURCE_BITS) */
-#define IORESOURCE_DMA_TYPE_MASK	(3<<0)
-#define IORESOURCE_DMA_8BIT		(0<<0)
-#define IORESOURCE_DMA_8AND16BIT	(1<<0)
-#define IORESOURCE_DMA_16BIT		(2<<0)
-
-#define IORESOURCE_DMA_MASTER		(1<<2)
-#define IORESOURCE_DMA_BYTE		(1<<3)
-#define IORESOURCE_DMA_WORD		(1<<4)
-
-#define IORESOURCE_DMA_SPEED_MASK	(3<<6)
-#define IORESOURCE_DMA_COMPATIBLE	(0<<6)
-#define IORESOURCE_DMA_TYPEA		(1<<6)
-#define IORESOURCE_DMA_TYPEB		(2<<6)
-#define IORESOURCE_DMA_TYPEF		(3<<6)
-
-/* ISA PnP memory I/O specific bits (IORESOURCE_BITS) */
-#define IORESOURCE_MEM_WRITEABLE	(1<<0)	/* dup: IORESOURCE_READONLY */
-#define IORESOURCE_MEM_CACHEABLE	(1<<1)	/* dup: IORESOURCE_CACHEABLE */
-#define IORESOURCE_MEM_RANGELENGTH	(1<<2)	/* dup: IORESOURCE_RANGELENGTH */
-#define IORESOURCE_MEM_TYPE_MASK	(3<<3)
-#define IORESOURCE_MEM_8BIT		(0<<3)
-#define IORESOURCE_MEM_16BIT		(1<<3)
-#define IORESOURCE_MEM_8AND16BIT	(2<<3)
-#define IORESOURCE_MEM_32BIT		(3<<3)
-#define IORESOURCE_MEM_SHADOWABLE	(1<<5)	/* dup: IORESOURCE_SHADOWABLE */
-#define IORESOURCE_MEM_EXPANSIONROM	(1<<6)
+struct resource_list {
+	struct resource_list *next;
+	struct resource *res;
+	struct pci_dev *dev;
+};
 
 /* PC/ISA/whatever - the normal PC address spaces: IO and memory */
 extern struct resource ioport_resource;
@@ -121,4 +228,5 @@
 {
 	return __check_region(&ioport_resource, s, n);
 }
+
 #endif	/* _LINUX_IOPORT_H */
