Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964971AbVHOVVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964971AbVHOVVZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 17:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964973AbVHOVVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 17:21:25 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:23444 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S964971AbVHOVVY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 17:21:24 -0400
Date: Mon, 15 Aug 2005 17:21:19 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: dtor_core@ameritech.net
cc: Patrick Mochel <mochel@digitalimplant.org>, Greg KH <greg@kroah.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Don't use a klist for drivers' set-of-devices
In-Reply-To: <d120d50005081113294dbb4961@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.0508151654210.19345-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry, Pat, Greg, and everyone else:

This is a revised version of the patch I sent in last week -- not yet a
submission, more of an RFC.  It turns out that removing the driver's list
of bound devices isn't practical, because there are times when a device
not yet on the bus's overall klist will be bound (this happens whenever a
new device is registered, for instance).

Anyway, in this new version the locking is greatly simplified and the
requirements are made much more explicit in the comments.  This code will
not be subject to deadlock when a driver's probe routine registers a child
device that uses the same driver, or when a remove routine unregisters
a child device from the same driver.  I think this version is okay, but
please look it over and see if anything looks amiss.

The next step will be to clean up the races inherent in device_bind_driver 
and device_release_driver.  There are two obvious approaches:

	Pass the driver as an argument rather than trusting the value
	stored in dev->driver.

	Require the caller to lock dev->sem.

On the face of it, neither is particularly more attractive than the other.  
However, reading through the various places that call these routines (for
example, drivers/input/serio/serio.c or drivers/pnp/card.c) revealed a
pattern.  In most cases, the callers of device_bind_driver _really_ want
something that functions more like driver_probe_device but without the
matching step.  The callers are invoking the probe methods by hand rather
than relying on the driver core to do so.  There's maybe only one place
where a caller actually does want the device bound to the driver without
doing a probe.

This suggests it might be a good idea to split driver_probe_device into 
two pieces, one for matching and one for probing & binding.  The second 
piece could then be used instead of device_bind_driver.

Another thing became apparent as well.  All of the places that use these
routines currently rely on the bus subsystem's rwsem for synchronization.  
Obviously this is bad, because that rwsem is on its way out.  I don't know
enough about all those different drivers to be able to tell whether they
lock the rwsem merely because the old API required it or because they
really do need some mutual exclusion.  Still, this suggests that it might
be best to require the callers to lock dev->sem -- i.e., use dev->sem sort
of as a replacement for the bus rwsem.

Comments?

Alan Stern



Index: usb-2.6/drivers/base/dd.c
===================================================================
--- usb-2.6.orig/drivers/base/dd.c
+++ usb-2.6/drivers/base/dd.c
@@ -21,31 +21,61 @@
 #include "base.h"
 #include "power/power.h"
 
-#define to_drv(node) container_of(node, struct device_driver, kobj.entry)
 
+/*
+ *	@dev must be guaranteed not to be unregistered, in the process
+ *	of registration, or else pinned by its knode_bus.
+ *	The caller must hold @dev->sem.
+ */
+static int __device_bind_driver(struct device * dev)
+{
+	struct device_driver * drv = dev->driver;
+	int ret;
+
+	down(&drv->devlist_mutex);
+
+	/* Make sure that drv is registered */
+	if (klist_node_attached(&drv->knode_bus)) {
+		pr_debug("bound device '%s' to driver '%s'\n",
+			 dev->bus_id, dev->driver->name);
+		list_add_tail(&dev->node_driver, &dev->driver->devlist);
+		sysfs_create_link(&dev->driver->kobj, &dev->kobj,
+				  kobject_name(&dev->kobj));
+		sysfs_create_link(&dev->kobj, &dev->driver->kobj, "driver");
+		ret = 0;
+	} else
+		ret = -EIDRM;
+
+	up(&drv->devlist_mutex);
+	return ret;
+}
 
 /**
  *	device_bind_driver - bind a driver to one device.
  *	@dev:	device.
  *
  *	Allow manual attachment of a driver to a device.
- *	Caller must have already set @dev->driver.
  *
- *	Note that this does not modify the bus reference count
- *	nor take the bus's rwsem. Please verify those are accounted
- *	for before calling this. (It is ok to call with no other effort
- *	from a driver's probe() method.)
- *
- *	This function must be called with @dev->sem held.
- */
-void device_bind_driver(struct device * dev)
-{
-	pr_debug("bound device '%s' to driver '%s'\n",
-		 dev->bus_id, dev->driver->name);
-	klist_add_tail(&dev->driver->klist_devices, &dev->knode_driver);
-	sysfs_create_link(&dev->driver->kobj, &dev->kobj,
-			  kobject_name(&dev->kobj));
-	sysfs_create_link(&dev->kobj, &dev->driver->kobj, "driver");
+ *	Caller must have already set @dev->driver.
+ *	@dev must be guaranteed not to be unregistered, in the process
+ *	of registration, or else pinned by its knode_bus.
+ */
+int device_bind_driver(struct device * dev)
+{
+	struct device_driver *drv = dev->driver;
+	int ret;
+
+	/* Make sure dev hasn't been unregistered or bound to
+	 * a different driver */
+	down(&dev->sem);
+	if (!klist_node_attached(&dev->knode_bus))
+		ret = -ENODEV;
+	else if (dev->driver != drv)
+		ret = -EBUSY;
+	else
+		ret = __device_bind_driver(dev);
+	up(&dev->sem);
+	return ret;
 }
 
 /**
@@ -59,16 +89,22 @@ void device_bind_driver(struct device * 
  *	because we don't know the format of the ID structures, nor what
  *	is to be considered a match and what is not.
  *
- *
  *	This function returns 1 if a match is found, an error if one
  *	occurs (that is not -ENODEV or -ENXIO), and 0 otherwise.
  *
- *	This function must be called with @dev->sem held.
+ *	@dev must be guaranteed not to be unregistered, in the process
+ *	of registration, or else pinned by its knode_bus.
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
 
@@ -79,35 +115,42 @@ int driver_probe_device(struct device_dr
 		ret = drv->probe(dev);
 		if (ret) {
 			dev->driver = NULL;
-			goto ProbeFailed;
+			if (ret == -ENODEV || ret == -ENXIO) {
+				/* Driver matched, but didn't support device
+				 * or device not found.
+				 * Not an error; keep going.
+				 */
+				ret = 0;
+			} else {
+				/* driver matched but the probe failed */
+				printk(KERN_WARNING "%s: probe of %s failed "
+					"with error %d\n",
+					drv->name, dev->bus_id, ret);
+			}
+			goto Done;
 		}
 	}
-	device_bind_driver(dev);
+
+	if (__device_bind_driver(dev) != 0) {
+		/* Driver was unregistered; keep going */
+		if (drv->remove)
+			drv->remove(dev);
+		dev->driver = NULL;
+		goto Done;
+	}
 	ret = 1;
 	pr_debug("%s: Bound Device %s to Driver %s\n",
 		 drv->bus->name, dev->bus_id, drv->name);
-	goto Done;
 
- ProbeFailed:
-	if (ret == -ENODEV || ret == -ENXIO) {
-		/* Driver matched, but didn't support device
-		 * or device not found.
-		 * Not an error; keep going.
-		 */
-		ret = 0;
-	} else {
-		/* driver matched but the probe failed */
-		printk(KERN_WARNING
-		       "%s: probe of %s failed with error %d\n",
-		       drv->name, dev->bus_id, ret);
-	}
  Done:
+	up(&dev->sem);
 	return ret;
 }
 
 static int __device_attach(struct device_driver * drv, void * data)
 {
 	struct device * dev = data;
+
 	return driver_probe_device(drv, dev);
 }
 
@@ -121,18 +164,28 @@ static int __device_attach(struct device
  *
  *	Returns 1 if the device was bound to a driver;
  *	0 if no matching device was found; error code otherwise.
+ *
+ *	@dev must be guaranteed not to be unregistered, in the process
+ *	of registration, or else pinned by its knode_bus.
  */
 int device_attach(struct device * dev)
 {
-	int ret = 0;
+	int ret = 1;
+	struct device_driver * drv = dev->driver;
 
-	down(&dev->sem);
-	if (dev->driver) {
-		device_bind_driver(dev);
-		ret = 1;
-	} else
+	if (drv) {
+		down(&dev->sem);
+
+		/* Make sure dev hasn't been bound to a different driver */
+		if (dev->driver != drv)
+			ret = -EBUSY;
+		else if (__device_bind_driver(dev) != 0)
+			drv = dev->driver = NULL;
+		up(&dev->sem);
+	}
+
+	if (!drv)
 		ret = bus_for_each_drv(dev->bus, NULL, dev, __device_attach);
-	up(&dev->sem);
 	return ret;
 }
 
@@ -141,7 +194,7 @@ static int __driver_attach(struct device
 	struct device_driver * drv = data;
 
 	/*
-	 * Lock device and try to bind to it. We drop the error
+	 * Try to bind drv to dev. We drop the error
 	 * here and always return 0, because we need to keep trying
 	 * to bind to devices and some drivers will return an error
 	 * simply if it didn't support the device.
@@ -150,12 +203,8 @@ static int __driver_attach(struct device
 	 * is an error.
 	 */
 
-	down(&dev->sem);
 	if (!dev->driver)
 		driver_probe_device(drv, dev);
-	up(&dev->sem);
-
-
 	return 0;
 }
 
@@ -173,43 +222,48 @@ void driver_attach(struct device_driver 
 	bus_for_each_dev(drv->bus, NULL, drv, __driver_attach);
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
+ *	It's okay for @dev or @driver (or both) to be unregistered.
+ */
+static void __device_release_driver(struct device * dev, void * driver)
 {
-	struct device_driver * drv;
+	struct device_driver * drv = driver;
 
-	drv = dev->driver;
-	if (drv) {
-		get_driver(drv);
+	/*
+	 * If anyone calls device_release_driver() recursively from
+	 * within their ->remove callback for the same device, they
+	 * will deadlock right here.
+	 */
+	down(&dev->sem);
+
+	/* Make sure dev hasn't already been unbound from drv */
+	if (dev->driver == drv) {
 		sysfs_remove_link(&drv->kobj, kobject_name(&dev->kobj));
 		sysfs_remove_link(&dev->kobj, "driver");
-		klist_remove(&dev->knode_driver);
+		down(&drv->devlist_mutex);
+		list_del(&dev->node_driver);
+		up(&drv->devlist_mutex);
 
 		if (drv->remove)
 			drv->remove(dev);
 		dev->driver = NULL;
-		put_driver(drv);
 	}
+	up(&dev->sem);
 }
 
+/**
+ *	device_release_driver - manually detach device from driver.
+ *	@dev:	device.
+ *
+ *	Manually detach device from driver.
+ */
 void device_release_driver(struct device * dev)
 {
-	/*
-	 * If anyone calls device_release_driver() recursively from
-	 * within their ->remove callback for the same device, they
-	 * will deadlock right here.
-	 */
-	down(&dev->sem);
-	__device_release_driver(dev);
-	up(&dev->sem);
+	struct device_driver * drv = dev->driver;
+
+	if (drv)
+		__device_release_driver(dev, drv);
 }
 
 
@@ -221,21 +275,22 @@ void driver_detach(struct device_driver 
 {
 	struct device * dev;
 
+	/* Note: we can't use driver_for_each_device here, because clients
+	 * of that routine are forbidden to unbind the device. */
 	for (;;) {
-		spin_lock_irq(&drv->klist_devices.k_lock);
-		if (list_empty(&drv->klist_devices.k_list)) {
-			spin_unlock_irq(&drv->klist_devices.k_lock);
-			break;
+		down(&drv->devlist_mutex);
+		if (list_empty(&drv->devlist))
+			dev = NULL;
+		else {
+			dev = list_entry(drv->devlist.prev,
+					struct device, node_driver);
+			get_device(dev);
 		}
-		dev = list_entry(drv->klist_devices.k_list.prev,
-				struct device, knode_driver.n_node);
-		get_device(dev);
-		spin_unlock_irq(&drv->klist_devices.k_lock);
+		up(&drv->devlist_mutex);
 
-		down(&dev->sem);
-		if (dev->driver == drv)
-			__device_release_driver(dev);
-		up(&dev->sem);
+		if (!dev)
+			break;
+		__device_release_driver(dev, drv);
 		put_device(dev);
 	}
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
@@ -32,23 +26,31 @@ static struct device * next_device(struc
  *	@fn:	Function to call for each device.
  *
  *	Iterate over the @drv's list of devices calling @fn for each one.
+ *
+ *	@fn must not attempt to unbind the device it gets -- the attempt
+ *	would deadlock because we will be holding @drv->devlist_mutex.
+ *	@fn also must not attempt to lock the device; this would deadlock
+ *	if another thread was trying to unbind it.
  */
 
 int driver_for_each_device(struct device_driver * drv, struct device * start, 
 			   void * data, int (*fn)(struct device *, void *))
 {
-	struct klist_iter i;
-	struct device * dev;
+	struct list_head * ptr;
 	int error = 0;
 
 	if (!drv)
 		return -EINVAL;
 
-	klist_iter_init_node(&drv->klist_devices, &i,
-			     start ? &start->knode_driver : NULL);
-	while ((dev = next_device(&i)) && !error)
-		error = fn(dev, data);
-	klist_iter_exit(&i);
+	down(&drv->devlist_mutex);
+	for (ptr = (start ? &start->node_driver : drv->devlist.next);
+			ptr != &drv->devlist;
+			ptr = ptr->next) {
+		error = fn(to_dev(ptr), data);
+		if (error)
+			break;
+	}
+	up(&drv->devlist_mutex);
 	return error;
 }
 
@@ -74,18 +76,23 @@ struct device * driver_find_device(struc
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
+	for (ptr = (start ? &start->node_driver : drv->devlist.next);
+			ptr != &drv->devlist;
+			ptr = ptr->next) {
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
@@ -157,7 +164,8 @@ void put_driver(struct device_driver * d
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
 
@@ -278,8 +279,7 @@ struct device {
 	char	bus_id[BUS_ID_SIZE];	/* position on parent bus */
 
 	struct semaphore	sem;	/* semaphore to synchronize calls to
-					 * its driver.
-					 */
+					 * its driver. */
 
 	struct bus_type	* bus;		/* type of bus device is on */
 	struct device_driver *driver;	/* which driver has allocated this
@@ -333,7 +333,7 @@ extern int device_for_each_child(struct 
  * Manual binding of a device to driver. See drivers/base/bus.c
  * for information on use.
  */
-extern void device_bind_driver(struct device * dev);
+extern int  device_bind_driver(struct device * dev);
 extern void device_release_driver(struct device * dev);
 extern int  device_attach(struct device * dev);
 extern void driver_attach(struct device_driver * drv);
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
@@ -173,11 +173,12 @@ static ssize_t driver_bind(struct device
 	int err = -ENODEV;
 
 	dev = bus_find_device(bus, NULL, (void *)buf, driver_helper);
-	if ((dev) &&
-	    (dev->driver == NULL)) {
-		down(&dev->sem);
-		err = driver_probe_device(drv, dev);
-		up(&dev->sem);
+	if (dev) {
+		/* Make sure dev doesn't get unregistered */
+		if (klist_get(&dev->knode_bus)) {
+			err = driver_probe_device(drv, dev);
+			klist_del(&dev->knode_bus);
+		}
 		put_device(dev);
 	}
 	return err;
@@ -443,8 +444,8 @@ int bus_add_driver(struct device_driver 
 			return error;
 		}
 
-		driver_attach(drv);
 		klist_add_tail(&bus->klist_drivers, &drv->knode_bus);
+		driver_attach(drv);
 		module_add_driver(drv->owner, drv);
 
 		driver_add_attrs(bus, drv);
Index: usb-2.6/lib/klist.c
===================================================================
--- usb-2.6.orig/lib/klist.c
+++ usb-2.6/lib/klist.c
@@ -122,6 +122,31 @@ static int klist_dec_and_del(struct klis
 
 
 /**
+ *	klist_get - Increment the reference count of node
+ *	@n:	node we're pinning.
+ *
+ *	Returns NULL if @n is not on a klist, @n otherwise.
+ */
+
+struct klist_node * klist_get(struct klist_node * n)
+{
+	struct klist * k = n->n_klist;
+
+	if (!k)
+		return NULL;
+	spin_lock(&k->k_lock);
+	if (n->n_klist == k)
+		kref_get(&n->n_ref);
+	else
+		n = NULL;
+	spin_unlock(&k->k_lock);
+	return n;
+}
+
+EXPORT_SYMBOL_GPL(klist_get);
+
+
+/**
  *	klist_del - Decrement the reference count of node and try to remove.
  *	@n:	node we're deleting.
  */
Index: usb-2.6/include/linux/klist.h
===================================================================
--- usb-2.6.orig/include/linux/klist.h
+++ usb-2.6/include/linux/klist.h
@@ -34,6 +34,7 @@ struct klist_node {
 extern void klist_add_tail(struct klist * k, struct klist_node * n);
 extern void klist_add_head(struct klist * k, struct klist_node * n);
 
+extern struct klist_node * klist_get(struct klist_node * n);
 extern void klist_del(struct klist_node * n);
 extern void klist_remove(struct klist_node * n);
 

