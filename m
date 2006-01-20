Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751076AbWATQjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbWATQjc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 11:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751077AbWATQjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 11:39:32 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:26501 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751075AbWATQjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 11:39:31 -0500
Date: Fri, 20 Jan 2006 11:39:30 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Greg KH <greg@kroah.com>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: [PATCH] driver core: remove unneeded klist methods
Message-ID: <Pine.LNX.4.44L0.0601201043540.4788-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg:

This patch (as641) removes unneeded klist methods from the driver core and
changes a klist_del call to klist_remove in device_del.

The _get and _put methods have no effect, because the klist nodes are
deleted by calling klist_remove, which waits until they are unreferenced
by any klist iterators.  Furthermore, the _puts cause problems because
they occur while the iterator is holding a spinlock.

Alan Stern



Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

James should check this, since he added these routines in the first place.  
The change to device_for_each_child is unfortunate, but also unavoidable
due to the change in device_del.  There's still a potentially dangerous
call to klist_del in attribute_container.c, but I'm not familiar enough
with that code to change it.

The SCSI core needs work.  The basic problem is that it has to keep a
reference to a SCSI device until the last command for that device
completes, but command completion occurs in an interrupt handler.  That
makes it hard to release the last reference.  I don't know how this should
be fixed; James will have to work on it.

Index: usb-2.6/drivers/base/core.c
===================================================================
--- usb-2.6.orig/drivers/base/core.c
+++ usb-2.6/drivers/base/core.c
@@ -198,20 +198,6 @@ void device_remove_file(struct device * 
 	}
 }
 
-static void klist_children_get(struct klist_node *n)
-{
-	struct device *dev = container_of(n, struct device, knode_parent);
-
-	get_device(dev);
-}
-
-static void klist_children_put(struct klist_node *n)
-{
-	struct device *dev = container_of(n, struct device, knode_parent);
-
-	put_device(dev);
-}
-
 
 /**
  *	device_initialize - init device structure.
@@ -228,8 +214,7 @@ void device_initialize(struct device *de
 {
 	kobj_set_kset_s(dev, devices_subsys);
 	kobject_init(&dev->kobj);
-	klist_init(&dev->klist_children, klist_children_get,
-		   klist_children_put);
+	klist_init(&dev->klist_children, NULL, NULL);
 	INIT_LIST_HEAD(&dev->dma_pools);
 	init_MUTEX(&dev->sem);
 	device_init_wakeup(dev, 0);
@@ -365,7 +350,7 @@ void device_del(struct device * dev)
 	struct device * parent = dev->parent;
 
 	if (parent)
-		klist_del(&dev->knode_parent);
+		klist_remove(&dev->knode_parent);
 	device_remove_file(dev, &dev->uevent_attr);
 
 	/* Notify the platform of the removal, in case they
@@ -417,17 +402,25 @@ static struct device * next_device(struc
  *
  *	We check the return of @fn each time. If it returns anything
  *	other than 0, we break out and return that value.
+ *
+ *	The code is complicated because @fn may want to call device_del().
+ *	Since the iterator holds a reference to the klist_node it is
+ *	using, the call would hang.  We get around the problem by
+ *	keeping the iterator one cycle ahead of @fn.
  */
 int device_for_each_child(struct device * parent, void * data,
 		     int (*fn)(struct device *, void *))
 {
 	struct klist_iter i;
-	struct device * child;
+	struct device * child, * next_child;
 	int error = 0;
 
 	klist_iter_init(&parent->klist_children, &i);
-	while ((child = next_device(&i)) && !error)
+	next_child = next_device(&i);
+	while ((child = next_child) && !error) {
+		next_child = next_device(&i);
 		error = fn(child, data);
+	}
 	klist_iter_exit(&i);
 	return error;
 }
Index: usb-2.6/drivers/base/bus.c
===================================================================
--- usb-2.6.orig/drivers/base/bus.c
+++ usb-2.6/drivers/base/bus.c
@@ -599,36 +599,6 @@ static void bus_remove_attrs(struct bus_
 	}
 }
 
-static void klist_devices_get(struct klist_node *n)
-{
-	struct device *dev = container_of(n, struct device, knode_bus);
-
-	get_device(dev);
-}
-
-static void klist_devices_put(struct klist_node *n)
-{
-	struct device *dev = container_of(n, struct device, knode_bus);
-
-	put_device(dev);
-}
-
-static void klist_drivers_get(struct klist_node *n)
-{
-	struct device_driver *drv = container_of(n, struct device_driver,
-						 knode_bus);
-
-	get_driver(drv);
-}
-
-static void klist_drivers_put(struct klist_node *n)
-{
-	struct device_driver *drv = container_of(n, struct device_driver,
-						 knode_bus);
-
-	put_driver(drv);
-}
-
 /**
  *	bus_register - register a bus with the system.
  *	@bus:	bus.
@@ -663,8 +633,8 @@ int bus_register(struct bus_type * bus)
 	if (retval)
 		goto bus_drivers_fail;
 
-	klist_init(&bus->klist_devices, klist_devices_get, klist_devices_put);
-	klist_init(&bus->klist_drivers, klist_drivers_get, klist_drivers_put);
+	klist_init(&bus->klist_devices, NULL, NULL);
+	klist_init(&bus->klist_drivers, NULL, NULL);
 	bus_add_attrs(bus);
 
 	pr_debug("bus type '%s' registered\n", bus->name);
Index: usb-2.6/drivers/base/driver.c
===================================================================
--- usb-2.6.orig/drivers/base/driver.c
+++ usb-2.6/drivers/base/driver.c
@@ -143,20 +143,6 @@ void put_driver(struct device_driver * d
 	kobject_put(&drv->kobj);
 }
 
-static void klist_devices_get(struct klist_node *n)
-{
-	struct device *dev = container_of(n, struct device, knode_driver);
-
-	get_device(dev);
-}
-
-static void klist_devices_put(struct klist_node *n)
-{
-	struct device *dev = container_of(n, struct device, knode_driver);
-
-	put_device(dev);
-}
-
 /**
  *	driver_register - register driver with bus
  *	@drv:	driver to register
@@ -176,7 +162,7 @@ int driver_register(struct device_driver
 	    (drv->bus->shutdown && drv->shutdown)) {
 		printk(KERN_WARNING "Driver '%s' needs updating - please use bus_type methods\n", drv->name);
 	}
-	klist_init(&drv->klist_devices, klist_devices_get, klist_devices_put);
+	klist_init(&drv->klist_devices, NULL, NULL);
 	init_completion(&drv->unloaded);
 	return bus_add_driver(drv);
 }

