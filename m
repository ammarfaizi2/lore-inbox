Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030267AbVHJU4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030267AbVHJU4N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 16:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030268AbVHJU4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 16:56:13 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:30593 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1030266AbVHJU4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 16:56:11 -0400
Date: Wed, 10 Aug 2005 16:56:08 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Greg KH <greg@kroah.com>
cc: Patrick Mochel <mochel@digitalimplant.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Don't use a klist for drivers' set-of-devices
Message-ID: <Pine.LNX.4.44L0.0508101637360.4467-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg and Pat:

This patch (as536) simplifies the driver-model core by replacing the klist 
used to store the set of devices bound to a driver with a regular list 
protected by a mutex.  It turns out that even with a klist, there are too 
many opportunities for races for the list to be used safely by more than 
one thread at a time.  And given that only one thread uses the list at any 
moment, there's no need to add all the extra overhead of making it a 
klist.

This version of the patch addresses the concerns raised earlier by Pat:  
the list and mutex have been given more succinct names, and the obscure
special-case code in device_attach has been replaced with a FIXME comment.  
Note that the new iterators in driver.c could easily be changed to use
list_for_each_entry_safe and list_for_each_entry, if the functions didn't
offer the feature of starting in the middle of the list.  If no callers
use that feature, it should be removed.

I still think the APIs for device_bind_driver and device_release_driver
need to be changed, because they each rely on dev->drv not changing at a
time when no protecting locks are held.  They will have to be fixed up in
a later patch.

Alan Stern



Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

Index: usb-2.6/drivers/base/dd.c
===================================================================
--- usb-2.6.orig/drivers/base/dd.c
+++ usb-2.6/drivers/base/dd.c
@@ -24,28 +24,37 @@
 #define to_drv(node) container_of(node, struct device_driver, kobj.entry)
 
 
+/*
+ *	The caller must hold both @dev->drv->devlist_mutex and
+ *	@dev->sem (acquired in that order).
+ */
+static void __device_bind_driver(struct device * dev)
+{
+	pr_debug("bound device '%s' to driver '%s'\n",
+		 dev->bus_id, dev->driver->name);
+	list_add_tail(&dev->node_driver, &dev->driver->devlist);
+	sysfs_create_link(&dev->driver->kobj, &dev->kobj,
+			  kobject_name(&dev->kobj));
+	sysfs_create_link(&dev->kobj, &dev->driver->kobj, "driver");
+}
+
 /**
  *	device_bind_driver - bind a driver to one device.
  *	@dev:	device.
  *
  *	Allow manual attachment of a driver to a device.
  *	Caller must have already set @dev->driver.
- *
- *	Note that this does not modify the bus reference count
- *	nor take the bus's rwsem. Please verify those are accounted
- *	for before calling this. (It is ok to call with no other effort
- *	from a driver's probe() method.)
- *
- *	This function must be called with @dev->sem held.
  */
 void device_bind_driver(struct device * dev)
 {
-	pr_debug("bound device '%s' to driver '%s'\n",
-		 dev->bus_id, dev->driver->name);
-	klist_add_tail(&dev->driver->klist_devices, &dev->knode_driver);
-	sysfs_create_link(&dev->driver->kobj, &dev->kobj,
-			  kobject_name(&dev->kobj));
-	sysfs_create_link(&dev->kobj, &dev->driver->kobj, "driver");
+	struct device_driver *drv = dev->driver;
+
+	down(&drv->devlist_mutex);
+	down(&dev->sem);
+	if (dev->driver == drv)
+		__device_bind_driver(dev);
+	up(&dev->sem);
+	up(&drv->devlist_mutex);
 }
 
 /**
@@ -59,16 +68,21 @@ void device_bind_driver(struct device * 
  *	because we don't know the format of the ID structures, nor what
  *	is to be considered a match and what is not.
  *
- *
  *	This function returns 1 if a match is found, an error if one
  *	occurs (that is not -ENODEV or -ENXIO), and 0 otherwise.
  *
- *	This function must be called with @dev->sem held.
+ *	The caller must hold @drv->devlist_mutex.
  */
 int driver_probe_device(struct device_driver * drv, struct device * dev)
 {
 	int ret = 0;
 
+	down(&dev->sem);
+	if (dev->driver) {
+		ret = -EBUSY;
+		goto Done;
+	}
+
 	if (drv->bus->match && !drv->bus->match(dev, drv))
 		goto Done;
 
@@ -82,7 +96,7 @@ int driver_probe_device(struct device_dr
 			goto ProbeFailed;
 		}
 	}
-	device_bind_driver(dev);
+	__device_bind_driver(dev);
 	ret = 1;
 	pr_debug("%s: Bound Device %s to Driver %s\n",
 		 drv->bus->name, dev->bus_id, drv->name);
@@ -102,13 +116,20 @@ int driver_probe_device(struct device_dr
 		       drv->name, dev->bus_id, ret);
 	}
  Done:
+	up(&dev->sem);
 	return ret;
 }
 
 static int __device_attach(struct device_driver * drv, void * data)
 {
 	struct device * dev = data;
-	return driver_probe_device(drv, dev);
+	int ret;
+
+	down(&drv->devlist_mutex);
+	ret = driver_probe_device(drv, dev);
+	up(&drv->devlist_mutex);
+
+	return ret;
 }
 
 /**
@@ -124,15 +145,21 @@ static int __device_attach(struct device
  */
 int device_attach(struct device * dev)
 {
-	int ret = 0;
+	int ret = 1;
+	struct device_driver * drv;
 
-	down(&dev->sem);
-	if (dev->driver) {
-		device_bind_driver(dev);
-		ret = 1;
+	drv = dev->driver;
+	if (drv) {
+
+		/* FIXME: What if drv is rmmod'ed right now? */
+
+		down(&drv->devlist_mutex);
+		down(&dev->sem);
+		__device_bind_driver(dev);
+		up(&dev->sem);
+		up(&drv->devlist_mutex);
 	} else
 		ret = bus_for_each_drv(dev->bus, NULL, dev, __device_attach);
-	up(&dev->sem);
 	return ret;
 }
 
@@ -141,7 +168,7 @@ static int __driver_attach(struct device
 	struct device_driver * drv = data;
 
 	/*
-	 * Lock device and try to bind to it. We drop the error
+	 * Try to bind drv to dev. We drop the error
 	 * here and always return 0, because we need to keep trying
 	 * to bind to devices and some drivers will return an error
 	 * simply if it didn't support the device.
@@ -150,11 +177,8 @@ static int __driver_attach(struct device
 	 * is an error.
 	 */
 
-	down(&dev->sem);
 	if (!dev->driver)
 		driver_probe_device(drv, dev);
-	up(&dev->sem);
-
 
 	return 0;
 }
@@ -170,46 +194,55 @@ static int __driver_attach(struct device
  */
 void driver_attach(struct device_driver * drv)
 {
+	down(&drv->devlist_mutex);
 	bus_for_each_dev(drv->bus, NULL, drv, __driver_attach);
+	up(&drv->devlist_mutex);
 }
 
-/**
- *	device_release_driver - manually detach device from driver.
- *	@dev:	device.
- *
- *	Manually detach device from driver.
- *
- *	__device_release_driver() must be called with @dev->sem held.
- */
 
-static void __device_release_driver(struct device * dev)
+/*
+ *	The caller must hold @driver->devlist_mutex.
+ */
+static int __device_release_driver(struct device * dev, void * driver)
 {
-	struct device_driver * drv;
+	struct device_driver * drv = driver;
 
-	drv = dev->driver;
-	if (drv) {
-		get_driver(drv);
+	down(&dev->sem);
+	if (dev->driver == drv) {
 		sysfs_remove_link(&drv->kobj, kobject_name(&dev->kobj));
 		sysfs_remove_link(&dev->kobj, "driver");
-		klist_remove(&dev->knode_driver);
+		list_del(&dev->node_driver);
 
 		if (drv->remove)
 			drv->remove(dev);
 		dev->driver = NULL;
-		put_driver(drv);
 	}
+	up(&dev->sem);
+	return 0;
 }
 
+/**
+ *	device_release_driver - manually detach device from driver.
+ *	@dev:	device.
+ *
+ *	Manually detach device from driver.
+ */
 void device_release_driver(struct device * dev)
 {
+	struct device_driver * drv;
+
+	drv = dev->driver;
+	if (!drv)
+		return;
+
 	/*
 	 * If anyone calls device_release_driver() recursively from
 	 * within their ->remove callback for the same device, they
 	 * will deadlock right here.
 	 */
-	down(&dev->sem);
-	__device_release_driver(dev);
-	up(&dev->sem);
+	down(&drv->devlist_mutex);
+	__device_release_driver(dev, drv);
+	up(&drv->devlist_mutex);
 }
 
 
@@ -219,25 +252,7 @@ void device_release_driver(struct device
  */
 void driver_detach(struct device_driver * drv)
 {
-	struct device * dev;
-
-	for (;;) {
-		spin_lock_irq(&drv->klist_devices.k_lock);
-		if (list_empty(&drv->klist_devices.k_list)) {
-			spin_unlock_irq(&drv->klist_devices.k_lock);
-			break;
-		}
-		dev = list_entry(drv->klist_devices.k_list.prev,
-				struct device, knode_driver.n_node);
-		get_device(dev);
-		spin_unlock_irq(&drv->klist_devices.k_lock);
-
-		down(&dev->sem);
-		if (dev->driver == drv)
-			__device_release_driver(dev);
-		up(&dev->sem);
-		put_device(dev);
-	}
+	driver_for_each_device(drv, NULL, drv, __device_release_driver);
 }
 
 
Index: usb-2.6/drivers/base/driver.c
===================================================================
--- usb-2.6.orig/drivers/base/driver.c
+++ usb-2.6/drivers/base/driver.c
@@ -15,16 +15,10 @@
 #include <linux/string.h>
 #include "base.h"
 
-#define to_dev(node) container_of(node, struct device, driver_list)
+#define to_dev(node) container_of(node, struct device, node_driver)
 #define to_drv(obj) container_of(obj, struct device_driver, kobj)
 
 
-static struct device * next_device(struct klist_iter * i)
-{
-	struct klist_node * n = klist_next(i);
-	return n ? container_of(n, struct device, knode_driver) : NULL;
-}
-
 /**
  *	driver_for_each_device - Iterator for devices bound to a driver.
  *	@drv:	Driver we're iterating.
@@ -37,18 +31,22 @@ static struct device * next_device(struc
 int driver_for_each_device(struct device_driver * drv, struct device * start, 
 			   void * data, int (*fn)(struct device *, void *))
 {
-	struct klist_iter i;
-	struct device * dev;
+	struct list_head * ptr, * tmp;
 	int error = 0;
 
 	if (!drv)
 		return -EINVAL;
 
-	klist_iter_init_node(&drv->klist_devices, &i,
-			     start ? &start->knode_driver : NULL);
-	while ((dev = next_device(&i)) && !error)
-		error = fn(dev, data);
-	klist_iter_exit(&i);
+	down(&drv->devlist_mutex);
+	ptr = (start ? &start->node_driver : drv->devlist.next);
+	while (ptr != &drv->devlist) {
+		tmp = ptr->next;
+		error = fn(to_dev(ptr), data);
+		if (error)
+			break;
+		ptr = tmp;
+	}
+	up(&drv->devlist_mutex);
 	return error;
 }
 
@@ -74,18 +72,22 @@ struct device * driver_find_device(struc
 				   struct device * start, void * data,
 				   int (*match)(struct device *, void *))
 {
-	struct klist_iter i;
-	struct device *dev;
+	struct list_head * ptr;
+	struct device *dev = NULL;
 
 	if (!drv)
 		return NULL;
 
-	klist_iter_init_node(&drv->klist_devices, &i,
-			     (start ? &start->knode_driver : NULL));
-	while ((dev = next_device(&i)))
+	down(&drv->devlist_mutex);
+	ptr = (start ? &start->node_driver : drv->devlist.next);
+	for (; ptr != &drv->devlist; ptr = ptr->next) {
+		dev = to_dev(ptr);
 		if (match(dev, data) && get_device(dev))
 			break;
-	klist_iter_exit(&i);
+	}
+	if (ptr == &drv->devlist)
+		dev = NULL;
+	up(&drv->devlist_mutex);
 	return dev;
 }
 EXPORT_SYMBOL_GPL(driver_find_device);
@@ -157,7 +159,8 @@ void put_driver(struct device_driver * d
  */
 int driver_register(struct device_driver * drv)
 {
-	klist_init(&drv->klist_devices);
+	INIT_LIST_HEAD(&drv->devlist);
+	init_MUTEX(&drv->devlist_mutex);
 	init_completion(&drv->unloaded);
 	return bus_add_driver(drv);
 }
Index: usb-2.6/include/linux/device.h
===================================================================
--- usb-2.6.orig/include/linux/device.h
+++ usb-2.6/include/linux/device.h
@@ -107,7 +107,8 @@ struct device_driver {
 
 	struct completion	unloaded;
 	struct kobject		kobj;
-	struct klist		klist_devices;
+	struct list_head	devlist;
+	struct semaphore	devlist_mutex;
 	struct klist_node	knode_bus;
 
 	struct module		* owner;
@@ -270,7 +271,7 @@ extern void class_device_destroy(struct 
 struct device {
 	struct klist		klist_children;
 	struct klist_node	knode_parent;		/* node in sibling list */
-	struct klist_node	knode_driver;
+	struct list_head	node_driver;
 	struct klist_node	knode_bus;
 	struct device 	* parent;
 
Index: usb-2.6/drivers/base/bus.c
===================================================================
--- usb-2.6.orig/drivers/base/bus.c
+++ usb-2.6/drivers/base/bus.c
@@ -133,7 +133,7 @@ static struct kobj_type ktype_bus = {
 decl_subsys(bus, &ktype_bus, NULL);
 
 
-/* Manually detach a device from it's associated driver. */
+/* Manually detach a device from its associated driver. */
 static int driver_helper(struct device *dev, void *data)
 {
 	const char *name = data;
@@ -175,9 +175,9 @@ static ssize_t driver_bind(struct device
 	dev = bus_find_device(bus, NULL, (void *)buf, driver_helper);
 	if ((dev) &&
 	    (dev->driver == NULL)) {
-		down(&dev->sem);
+		down(&drv->devlist_mutex);
 		err = driver_probe_device(drv, dev);
-		up(&dev->sem);
+		up(&drv->devlist_mutex);
 		put_device(dev);
 	}
 	return err;

