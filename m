Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261910AbVCUVBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261910AbVCUVBe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 16:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbVCUU77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 15:59:59 -0500
Received: from digitalimplant.org ([64.62.235.95]:15244 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S261888AbVCUUsm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 15:48:42 -0500
Date: Mon, 21 Mar 2005 12:48:36 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: linux-kernel@vger.kernel.org
cc: greg@kroah.com
Subject: [2/9] [RFC] Steps to fixing the driver model locking
Message-ID: <Pine.LNX.4.50.0503211243430.20647-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet@1.2231, 2005-03-21 10:52:54-08:00, mochel@digitalimplant.org
  [driver core] Move device/driver code to drivers/base/dd.c

  This relocates the driver binding/unbinding code to drivers/base/dd.c. This is done
  for two reasons: One, it's not code related to the bus_type itself; it uses some from
  that, some from devices, and some from drivers. And Two, it will make it easier to do
  some of the upcoming lock removal on that code..



  Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>

diff -Nru a/drivers/base/Makefile b/drivers/base/Makefile
--- a/drivers/base/Makefile	2005-03-21 12:30:47 -08:00
+++ b/drivers/base/Makefile	2005-03-21 12:30:47 -08:00
@@ -1,6 +1,6 @@
 # Makefile for the Linux device tree

-obj-y			:= core.o sys.o interface.o bus.o \
+obj-y			:= core.o sys.o interface.o bus.o dd.o \
 			   driver.o class.o class_simple.o platform.o \
 			   cpu.o firmware.o init.o map.o dmapool.o \
 			   attribute_container.o transport_class.o
diff -Nru a/drivers/base/base.h b/drivers/base/base.h
--- a/drivers/base/base.h	2005-03-21 12:30:47 -08:00
+++ b/drivers/base/base.h	2005-03-21 12:30:47 -08:00
@@ -4,6 +4,8 @@
 extern int bus_add_driver(struct device_driver *);
 extern void bus_remove_driver(struct device_driver *);

+extern void driver_detach(struct device_driver * drv);
+
 static inline struct class_device *to_class_dev(struct kobject *obj)
 {
 	return container_of(obj, struct class_device, kobj);
diff -Nru a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c	2005-03-21 12:30:47 -08:00
+++ b/drivers/base/bus.c	2005-03-21 12:30:47 -08:00
@@ -18,7 +18,6 @@
 #include "power/power.h"

 #define to_dev(node) container_of(node, struct device, bus_list)
-#define to_drv(node) container_of(node, struct device_driver, kobj.entry)

 #define to_bus_attr(_attr) container_of(_attr, struct bus_attribute, attr)
 #define to_bus(obj) container_of(obj, struct bus_type, subsys.kset.kobj)
@@ -243,182 +242,6 @@
 	return ret;
 }

-/**
- *	device_bind_driver - bind a driver to one device.
- *	@dev:	device.
- *
- *	Allow manual attachment of a driver to a device.
- *	Caller must have already set @dev->driver.
- *
- *	Note that this does not modify the bus reference count
- *	nor take the bus's rwsem. Please verify those are accounted
- *	for before calling this. (It is ok to call with no other effort
- *	from a driver's probe() method.)
- */
-
-void device_bind_driver(struct device * dev)
-{
-	pr_debug("bound device '%s' to driver '%s'\n",
-		 dev->bus_id, dev->driver->name);
-	list_add_tail(&dev->driver_list, &dev->driver->devices);
-	sysfs_create_link(&dev->driver->kobj, &dev->kobj,
-			  kobject_name(&dev->kobj));
-	sysfs_create_link(&dev->kobj, &dev->driver->kobj, "driver");
-}
-
-
-/**
- *	driver_probe_device - attempt to bind device & driver.
- *	@drv:	driver.
- *	@dev:	device.
- *
- *	First, we call the bus's match function, if one present, which
- *	should compare the device IDs the driver supports with the
- *	device IDs of the device. Note we don't do this ourselves
- *	because we don't know the format of the ID structures, nor what
- *	is to be considered a match and what is not.
- *
- *	If we find a match, we call @drv->probe(@dev) if it exists, and
- *	call device_bind_driver() above.
- */
-int driver_probe_device(struct device_driver * drv, struct device * dev)
-{
-	int error = 0;
-
-	if (drv->bus->match && !drv->bus->match(dev, drv))
-		return -ENODEV;
-
-	down(&dev->sem);
-	dev->driver = drv;
-	if (drv->probe) {
-		error = drv->probe(dev);
-		if (error) {
-			dev->driver = NULL;
-			up(&dev->sem);
-			return error;
-		}
-	}
-	up(&dev->sem);
-	device_bind_driver(dev);
-	return 0;
-}
-
-
-/**
- *	device_attach - try to attach device to a driver.
- *	@dev:	device.
- *
- *	Walk the list of drivers that the bus has and call
- *	driver_probe_device() for each pair. If a compatible
- *	pair is found, break out and return.
- */
-int device_attach(struct device * dev)
-{
- 	struct bus_type * bus = dev->bus;
-	struct list_head * entry;
-	int error;
-
-	if (dev->driver) {
-		device_bind_driver(dev);
-		return 1;
-	}
-
-	if (bus->match) {
-		list_for_each(entry, &bus->drivers.list) {
-			struct device_driver * drv = to_drv(entry);
-			error = driver_probe_device(drv, dev);
-			if (!error)
-				/* success, driver matched */
-				return 1;
-			if (error != -ENODEV && error != -ENXIO)
-				/* driver matched but the probe failed */
-				printk(KERN_WARNING
-				    "%s: probe of %s failed with error %d\n",
-				    drv->name, dev->bus_id, error);
-		}
-	}
-
-	return 0;
-}
-
-
-/**
- *	driver_attach - try to bind driver to devices.
- *	@drv:	driver.
- *
- *	Walk the list of devices that the bus has on it and try to
- *	match the driver with each one.  If driver_probe_device()
- *	returns 0 and the @dev->driver is set, we've found a
- *	compatible pair.
- *
- *	Note that we ignore the -ENODEV error from driver_probe_device(),
- *	since it's perfectly valid for a driver not to bind to any devices.
- */
-void driver_attach(struct device_driver * drv)
-{
-	struct bus_type * bus = drv->bus;
-	struct list_head * entry;
-	int error;
-
-	if (!bus->match)
-		return;
-
-	list_for_each(entry, &bus->devices.list) {
-		struct device * dev = container_of(entry, struct device, bus_list);
-		if (!dev->driver) {
-			error = driver_probe_device(drv, dev);
-			if (error && (error != -ENODEV))
-				/* driver matched but the probe failed */
-				printk(KERN_WARNING
-				    "%s: probe of %s failed with error %d\n",
-				    drv->name, dev->bus_id, error);
-		}
-	}
-}
-
-
-/**
- *	device_release_driver - manually detach device from driver.
- *	@dev:	device.
- *
- *	Manually detach device from driver.
- *	Note that this is called without incrementing the bus
- *	reference count nor taking the bus's rwsem. Be sure that
- *	those are accounted for before calling this function.
- */
-
-void device_release_driver(struct device * dev)
-{
-	struct device_driver * drv;
-
-	down(&dev->sem);
-	drv = dev->driver;
-	if (drv) {
-		sysfs_remove_link(&drv->kobj, kobject_name(&dev->kobj));
-		sysfs_remove_link(&dev->kobj, "driver");
-		list_del_init(&dev->driver_list);
-		device_detach_shutdown(dev);
-		if (drv->remove)
-			drv->remove(dev);
-		dev->driver = NULL;
-	}
-	up(&dev->sem);
-}
-
-
-/**
- *	driver_detach - detach driver from all devices it controls.
- *	@drv:	driver.
- */
-
-static void driver_detach(struct device_driver * drv)
-{
-	struct list_head * entry, * next;
-	list_for_each_safe(entry, next, &drv->devices) {
-		struct device * dev = container_of(entry, struct device, driver_list);
-		device_release_driver(dev);
-	}
-}

 static int device_add_attrs(struct bus_type * bus, struct device * dev)
 {
@@ -758,12 +581,6 @@

 EXPORT_SYMBOL_GPL(bus_for_each_dev);
 EXPORT_SYMBOL_GPL(bus_for_each_drv);
-
-EXPORT_SYMBOL_GPL(driver_probe_device);
-EXPORT_SYMBOL_GPL(device_bind_driver);
-EXPORT_SYMBOL_GPL(device_release_driver);
-EXPORT_SYMBOL_GPL(device_attach);
-EXPORT_SYMBOL_GPL(driver_attach);

 EXPORT_SYMBOL_GPL(bus_add_device);
 EXPORT_SYMBOL_GPL(bus_remove_device);
diff -Nru a/drivers/base/dd.c b/drivers/base/dd.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/base/dd.c	2005-03-21 12:30:47 -08:00
@@ -0,0 +1,209 @@
+/*
+ *	drivers/base/dd.c - The core device/driver interactions.
+ *
+ * 	This file contains the (sometimes tricky) code that controls the
+ *	interactions between devices and drivers, which primarily includes
+ *	driver binding and unbinding.
+ *
+ *	All of this code used to exist in drivers/base/bus.c, but was
+ *	relocated to here in the name of compartmentalization (since it wasn't
+ *	strictly code just for the 'struct bus_type'.
+ *
+ *	Copyright (c) 2002-5 Patrick Mochel
+ *	Copyright (c) 2002-3 Open Source Development Labs
+ *
+ *	This file is released under the GPLv2
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+
+#include "base.h"
+#include "power/power.h"
+
+#define to_drv(node) container_of(node, struct device_driver, kobj.entry)
+
+
+/**
+ *	device_bind_driver - bind a driver to one device.
+ *	@dev:	device.
+ *
+ *	Allow manual attachment of a driver to a device.
+ *	Caller must have already set @dev->driver.
+ *
+ *	Note that this does not modify the bus reference count
+ *	nor take the bus's rwsem. Please verify those are accounted
+ *	for before calling this. (It is ok to call with no other effort
+ *	from a driver's probe() method.)
+ */
+
+void device_bind_driver(struct device * dev)
+{
+	pr_debug("bound device '%s' to driver '%s'\n",
+		 dev->bus_id, dev->driver->name);
+	list_add_tail(&dev->driver_list, &dev->driver->devices);
+	sysfs_create_link(&dev->driver->kobj, &dev->kobj,
+			  kobject_name(&dev->kobj));
+	sysfs_create_link(&dev->kobj, &dev->driver->kobj, "driver");
+}
+
+
+/**
+ *	driver_probe_device - attempt to bind device & driver.
+ *	@drv:	driver.
+ *	@dev:	device.
+ *
+ *	First, we call the bus's match function, if one present, which
+ *	should compare the device IDs the driver supports with the
+ *	device IDs of the device. Note we don't do this ourselves
+ *	because we don't know the format of the ID structures, nor what
+ *	is to be considered a match and what is not.
+ *
+ *	If we find a match, we call @drv->probe(@dev) if it exists, and
+ *	call device_bind_driver() above.
+ */
+int driver_probe_device(struct device_driver * drv, struct device * dev)
+{
+	int error = 0;
+
+	if (drv->bus->match && !drv->bus->match(dev, drv))
+		return -ENODEV;
+
+	down(&dev->sem);
+	dev->driver = drv;
+	if (drv->probe) {
+		error = drv->probe(dev);
+		if (error) {
+			dev->driver = NULL;
+			up(&dev->sem);
+			return error;
+		}
+	}
+	up(&dev->sem);
+	device_bind_driver(dev);
+	return 0;
+}
+
+
+/**
+ *	device_attach - try to attach device to a driver.
+ *	@dev:	device.
+ *
+ *	Walk the list of drivers that the bus has and call
+ *	driver_probe_device() for each pair. If a compatible
+ *	pair is found, break out and return.
+ */
+int device_attach(struct device * dev)
+{
+ 	struct bus_type * bus = dev->bus;
+	struct list_head * entry;
+	int error;
+
+	if (dev->driver) {
+		device_bind_driver(dev);
+		return 1;
+	}
+
+	if (bus->match) {
+		list_for_each(entry, &bus->drivers.list) {
+			struct device_driver * drv = to_drv(entry);
+			error = driver_probe_device(drv, dev);
+			if (!error)
+				/* success, driver matched */
+				return 1;
+			if (error != -ENODEV && error != -ENXIO)
+				/* driver matched but the probe failed */
+				printk(KERN_WARNING
+				    "%s: probe of %s failed with error %d\n",
+				    drv->name, dev->bus_id, error);
+		}
+	}
+
+	return 0;
+}
+
+
+/**
+ *	driver_attach - try to bind driver to devices.
+ *	@drv:	driver.
+ *
+ *	Walk the list of devices that the bus has on it and try to
+ *	match the driver with each one.  If driver_probe_device()
+ *	returns 0 and the @dev->driver is set, we've found a
+ *	compatible pair.
+ *
+ *	Note that we ignore the -ENODEV error from driver_probe_device(),
+ *	since it's perfectly valid for a driver not to bind to any devices.
+ */
+void driver_attach(struct device_driver * drv)
+{
+	struct bus_type * bus = drv->bus;
+	struct list_head * entry;
+	int error;
+
+	if (!bus->match)
+		return;
+
+	list_for_each(entry, &bus->devices.list) {
+		struct device * dev = container_of(entry, struct device, bus_list);
+		if (!dev->driver) {
+			error = driver_probe_device(drv, dev);
+			if (error && (error != -ENODEV))
+				/* driver matched but the probe failed */
+				printk(KERN_WARNING
+				    "%s: probe of %s failed with error %d\n",
+				    drv->name, dev->bus_id, error);
+		}
+	}
+}
+
+
+/**
+ *	device_release_driver - manually detach device from driver.
+ *	@dev:	device.
+ *
+ *	Manually detach device from driver.
+ *	Note that this is called without incrementing the bus
+ *	reference count nor taking the bus's rwsem. Be sure that
+ *	those are accounted for before calling this function.
+ */
+
+void device_release_driver(struct device * dev)
+{
+	struct device_driver * drv;
+
+	down(&dev->sem);
+	drv = dev->driver;
+	if (drv) {
+		sysfs_remove_link(&drv->kobj, kobject_name(&dev->kobj));
+		sysfs_remove_link(&dev->kobj, "driver");
+		list_del_init(&dev->driver_list);
+		device_detach_shutdown(dev);
+		if (drv->remove)
+			drv->remove(dev);
+		dev->driver = NULL;
+	}
+	up(&dev->sem);
+}
+
+
+/**
+ *	driver_detach - detach driver from all devices it controls.
+ *	@drv:	driver.
+ */
+
+void driver_detach(struct device_driver * drv)
+{
+	struct list_head * entry, * next;
+	list_for_each_safe(entry, next, &drv->devices) {
+		struct device * dev = container_of(entry, struct device, driver_list);
+		device_release_driver(dev);
+	}
+}
+
+EXPORT_SYMBOL_GPL(driver_probe_device);
+EXPORT_SYMBOL_GPL(device_bind_driver);
+EXPORT_SYMBOL_GPL(device_release_driver);
+EXPORT_SYMBOL_GPL(device_attach);
+EXPORT_SYMBOL_GPL(driver_attach);
+
