Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266195AbUFJGzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266195AbUFJGzM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 02:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266182AbUFJGzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 02:55:11 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:27052 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266195AbUFJGq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 02:46:59 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Greg KH <greg@kroah.com>
Subject: [PATCH 4/3] Allow registering device without taking bus lock
Date: Thu, 10 Jun 2004 01:46:23 -0500
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200406090221.24739.dtor_core@ameritech.net> <200406100143.53381.dtor_core@ameritech.net> <200406100145.01599.dtor_core@ameritech.net>
In-Reply-To: <200406100145.01599.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406100146.25471.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1769, 2004-06-10 00:10:02-05:00, dtor_core@ameritech.net
  sysfs: provide means for adding and removing devices to a bus without
         taking bus' semaphore so devices can be added/removed from
         driver's probe() and remove() methods.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 drivers/base/base.h    |    4 ++--
 drivers/base/bus.c     |   48 +++++++++++++++++++++++++++++++++++++++++-------
 drivers/base/core.c    |   46 ++++++++++++++++++++++++++++++++--------------
 include/linux/device.h |   31 ++++++++++++++++++++++++++-----
 4 files changed, 101 insertions(+), 28 deletions(-)


===================================================================



diff -Nru a/drivers/base/base.h b/drivers/base/base.h
--- a/drivers/base/base.h	2004-06-10 01:34:48 -05:00
+++ b/drivers/base/base.h	2004-06-10 01:34:48 -05:00
@@ -1,5 +1,5 @@
-extern int bus_add_device(struct device * dev);
-extern void bus_remove_device(struct device * dev);
+extern int bus_add_device(struct device * dev, int lock);
+extern void bus_remove_device(struct device * dev, int lock);
 
 extern int bus_add_driver(struct device_driver *);
 extern void bus_remove_driver(struct device_driver *);
diff -Nru a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c	2004-06-10 01:34:48 -05:00
+++ b/drivers/base/bus.c	2004-06-10 01:34:48 -05:00
@@ -394,22 +394,39 @@
 /**
  *	bus_add_device - add device to bus
  *	@dev:	device being added
+ *	@lock:	flag instructing the function to acquire bus' semaphore
  *
  *	- Add the device to its bus's list of devices.
  *	- Try to attach to driver.
  *	- Create link to device's physical location.
+ *
+ *	Note that only time when bus semaphore should not be taken is
+ *	when bus_add_device is called from driver's probe function
+ *	when it needs to add a child device sitting on the same bus
+ *	with the parent.
  */
-int bus_add_device(struct device * dev)
+int bus_add_device(struct device * dev, int lock)
 {
 	struct bus_type * bus = get_bus(dev->bus);
 	int error = 0;
 
 	if (bus) {
-		down_write(&dev->bus->subsys.rwsem);
+		if (lock)
+			down_write(&bus->subsys.rwsem);
+		else {
+			/*
+			 * Attempt to catch invalid usage - semaphore should
+			 * already be taken and trylock should fail.
+			 * Unfortunately the check will miss scenario where
+			 * semaphore is taken by some other thread
+			 */
+			BUG_ON(down_write_trylock(&bus->subsys.rwsem));
+		}
 		pr_debug("bus %s: add device %s\n", bus->name, dev->bus_id);
-		list_add_tail(&dev->bus_list, &dev->bus->devices.list);
+		list_add_tail(&dev->bus_list, &bus->devices.list);
 		device_attach(dev);
-		up_write(&dev->bus->subsys.rwsem);
+		if (lock)
+			up_write(&bus->subsys.rwsem);
 		sysfs_create_link(&bus->devices.kobj, &dev->kobj, dev->bus_id);
 	}
 	return error;
@@ -418,21 +435,38 @@
 /**
  *	bus_remove_device - remove device from bus
  *	@dev:	device to be removed
+ *	@lock:	flag instructing the function to acquire bus' semaphore
  *
  *	- Remove symlink from bus's directory.
  *	- Delete device from bus's list.
  *	- Detach from its driver.
  *	- Drop reference taken in bus_add_device().
+ *
+ *	Note that only time when bus semaphore should not be taken is
+ *	when bus_remove_device is called from driver's remove function
+ *	when it needs to remove a child device sitting on the same bus
+ *	with the parent.
  */
-void bus_remove_device(struct device * dev)
+void bus_remove_device(struct device * dev, int lock)
 {
 	if (dev->bus) {
 		sysfs_remove_link(&dev->bus->devices.kobj, dev->bus_id);
-		down_write(&dev->bus->subsys.rwsem);
+		if (lock)
+			down_write(&dev->bus->subsys.rwsem);
+		else {
+			/*
+			 * Attempt to catch invalid usage - semaphore should
+			 * already be taken and trylock should fail.
+			 * Unfortunately the check will miss scenario where
+			 * semaphore is taken by some other thread
+			 */
+			BUG_ON(down_write_trylock(&dev->bus->subsys.rwsem));
+		}
 		pr_debug("bus %s: remove device %s\n", dev->bus->name, dev->bus_id);
 		device_release_driver(dev);
 		list_del_init(&dev->bus_list);
-		up_write(&dev->bus->subsys.rwsem);
+		if (lock)
+			up_write(&dev->bus->subsys.rwsem);
 		put_bus(dev->bus);
 	}
 }
diff -Nru a/drivers/base/core.c b/drivers/base/core.c
--- a/drivers/base/core.c	2004-06-10 01:34:48 -05:00
+++ b/drivers/base/core.c	2004-06-10 01:34:48 -05:00
@@ -197,17 +197,19 @@
 }
 
 /**
- *	device_add - add device to device hierarchy.
+ *	__device_add - add device to device hierarchy.
  *	@dev:	device.
+ *	@lock:	flag indicating whether bus_add_device() should acquire
+ *		bus' semaphore or not.
  *
- *	This is part 2 of device_register(), though may be called
+ *	This is part 2 of __device_register(), though may be called
  *	separately _iff_ device_initialize() has been called separately.
  *
  *	This adds it to the kobject hierarchy via kobject_add(), adds it
  *	to the global and sibling lists for the device, then
  *	adds it to the other relevant subsystems of the driver model.
  */
-int device_add(struct device *dev)
+int __device_add(struct device *dev, int lock)
 {
 	struct device * parent;
 	int error;
@@ -229,7 +231,7 @@
 		goto Error;
 	if ((error = device_pm_add(dev)))
 		goto PMError;
-	if ((error = bus_add_device(dev)))
+	if ((error = bus_add_device(dev, lock)))
 		goto BusError;
 	down_write(&devices_subsys.rwsem);
 	if (parent)
@@ -256,6 +258,8 @@
 /**
  *	device_register - register a device with the system.
  *	@dev:	pointer to the device structure
+ *	@lock:	flag indicating whether bus' semaphore should be taken
+ *		before adding the device to its bus
  *
  *	This happens in two clean steps - initialize the device
  *	and add it to the system. The two steps can be called
@@ -263,12 +267,16 @@
  *	I.e. you should only call the two helpers separately if
  *	have a clearly defined need to use and refcount the device
  *	before it is added to the hierarchy.
+ *
+ *	Note that only time when bus' semaphore should not be taken is
+ *	when __device_register() is called from driver's probe routine.
+ *	Regular users users should just call device_register().
  */
 
-int device_register(struct device *dev)
+int __device_register(struct device *dev, int lock)
 {
 	device_initialize(dev);
-	return device_add(dev);
+	return __device_add(dev, lock);
 }
 
 
@@ -300,6 +308,8 @@
 /**
  *	device_del - delete device from system.
  *	@dev:	device.
+ *	@lock:	flag indicating whether bus' semaphore should be taken
+ *		before removing the device from its bus
  *
  *	This is the first part of the device unregistration
  *	sequence. This removes the device from the lists we control
@@ -309,9 +319,11 @@
  *
  *	NOTE: this should be called manually _iff_ device_add() was
  *	also called manually.
+ *
+ *	Regular users users should just call device_del().
  */
 
-void device_del(struct device * dev)
+void __device_del(struct device * dev, int lock)
 {
 	struct device * parent = dev->parent;
 
@@ -325,7 +337,7 @@
 	 */
 	if (platform_notify_remove)
 		platform_notify_remove(dev);
-	bus_remove_device(dev);
+	bus_remove_device(dev, lock);
 	device_pm_remove(dev);
 	kobject_del(&dev->kobj);
 	if (parent)
@@ -335,6 +347,8 @@
 /**
  *	device_unregister - unregister device from system.
  *	@dev:	device going away.
+ *	@lock:	flag indicating whether bus' semaphore should be taken
+ *		before removing the device from its bus
  *
  *	We do this in two parts, like we do device_register(). First,
  *	we remove it from all the subsystems with device_del(), then
@@ -342,11 +356,15 @@
  *	is the final reference count, the device will be cleaned up
  *	via device_release() above. Otherwise, the structure will
  *	stick around until the final reference to the device is dropped.
+ *
+ *	Note that only time when bus' semaphore should not be taken is
+ *	when __device_unregister() is called from driver's remove routine.
+ *	Regular users users should just call device_unregister().
  */
-void device_unregister(struct device * dev)
+void __device_unregister(struct device * dev, int lock)
 {
 	pr_debug("DEV: Unregistering device. ID = '%s'\n", dev->bus_id);
-	device_del(dev);
+	__device_del(dev, lock);
 	put_device(dev);
 }
 
@@ -394,11 +412,11 @@
 EXPORT_SYMBOL(device_for_each_child);
 
 EXPORT_SYMBOL(device_initialize);
-EXPORT_SYMBOL(device_add);
-EXPORT_SYMBOL(device_register);
+EXPORT_SYMBOL(__device_add);
+EXPORT_SYMBOL(__device_register);
 
-EXPORT_SYMBOL(device_del);
-EXPORT_SYMBOL(device_unregister);
+EXPORT_SYMBOL(__device_del);
+EXPORT_SYMBOL(__device_unregister);
 EXPORT_SYMBOL(get_device);
 EXPORT_SYMBOL(put_device);
 EXPORT_SYMBOL(device_find);
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	2004-06-10 01:34:48 -05:00
+++ b/include/linux/device.h	2004-06-10 01:34:48 -05:00
@@ -316,16 +316,37 @@
 /*
  * High level routines for use by the bus drivers
  */
-extern int device_register(struct device * dev);
-extern void device_unregister(struct device * dev);
+extern int __device_register(struct device * dev, int lock);
+static inline int device_register(struct device * dev)
+{
+	return __device_register(dev, 1);
+}
+
+extern void __device_unregister(struct device * dev, int lock);
+static inline void device_unregister(struct device * dev)
+{
+	__device_unregister(dev, 1);
+}
+
 extern void device_initialize(struct device * dev);
-extern int device_add(struct device * dev);
-extern void device_del(struct device * dev);
+
+extern int __device_add(struct device * dev, int lock);
+static inline int device_add(struct device * dev)
+{
+	return __device_add(dev, 1);
+}
+
+extern void __device_del(struct device * dev, int lock);
+static inline void device_del(struct device * dev)
+{
+	__device_del(dev, 1);
+}
+
 extern int device_for_each_child(struct device *, void *,
 		     int (*fn)(struct device *, void *));
 
 /*
- * Manual binding of a device to driver. See drivers/base/bus.c 
+ * Manual binding of a device to driver. See drivers/base/bus.c
  * for information on use.
  */
 extern void device_bind_driver(struct device * dev);
