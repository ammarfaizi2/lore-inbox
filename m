Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261882AbVFUAgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261882AbVFUAgb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 20:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbVFUAfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 20:35:18 -0400
Received: from mail.kroah.org ([69.55.234.183]:46820 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261770AbVFTW74 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:56 -0400
Cc: mochel@digitalimplant.org
Subject: [PATCH] Move device/driver code to drivers/base/dd.c
In-Reply-To: <1119308364685@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:24 -0700
Message-Id: <1119308364330@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Move device/driver code to drivers/base/dd.c

This relocates the driver binding/unbinding code to drivers/base/dd.c. This is done
for two reasons: One, it's not code related to the bus_type itself; it uses some from
that, some from devices, and some from drivers. And Two, it will make it easier to do
some of the upcoming lock removal on that code..

Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 07e4a3e27fe414980ddc85a358e5a56abc48b363
tree eb32858e7facf8b24a2f0fc2d4e829d6ee715c09
parent af70316af182f4716cc5eec7e0d27fc731d164bd
author mochel@digitalimplant.org <mochel@digitalimplant.org> Mon, 21 Mar 2005 10:52:54 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:13 -0700

 drivers/base/Makefile |    2 
 drivers/base/base.h   |    2 
 drivers/base/bus.c    |  182 ---------------------------------------------
 drivers/base/dd.c     |  200 +++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 203 insertions(+), 183 deletions(-)

diff --git a/drivers/base/Makefile b/drivers/base/Makefile
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -1,6 +1,6 @@
 # Makefile for the Linux device tree
 
-obj-y			:= core.o sys.o bus.o \
+obj-y			:= core.o sys.o bus.o dd.o \
 			   driver.o class.o platform.o \
 			   cpu.o firmware.o init.o map.o dmapool.o \
 			   attribute_container.o transport_class.o
diff --git a/drivers/base/base.h b/drivers/base/base.h
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -4,6 +4,8 @@ extern void bus_remove_device(struct dev
 extern int bus_add_driver(struct device_driver *);
 extern void bus_remove_driver(struct device_driver *);
 
+extern void driver_detach(struct device_driver * drv);
+
 static inline struct class_device *to_class_dev(struct kobject *obj)
 {
 	return container_of(obj, struct class_device, kobj);
diff --git a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -18,7 +18,6 @@
 #include "power/power.h"
 
 #define to_dev(node) container_of(node, struct device, bus_list)
-#define to_drv(node) container_of(node, struct device_driver, kobj.entry)
 
 #define to_bus_attr(_attr) container_of(_attr, struct bus_attribute, attr)
 #define to_bus(obj) container_of(obj, struct bus_type, subsys.kset.kobj)
@@ -243,181 +242,6 @@ int bus_for_each_drv(struct bus_type * b
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
-	while (!list_empty(&drv->devices)) {
-		struct device * dev = container_of(drv->devices.next, struct device, driver_list);
-		device_release_driver(dev);
-	}
-}
-
 static int device_add_attrs(struct bus_type * bus, struct device * dev)
 {
 	int error = 0;
@@ -757,12 +581,6 @@ int __init buses_init(void)
 EXPORT_SYMBOL_GPL(bus_for_each_dev);
 EXPORT_SYMBOL_GPL(bus_for_each_drv);
 
-EXPORT_SYMBOL_GPL(driver_probe_device);
-EXPORT_SYMBOL_GPL(device_bind_driver);
-EXPORT_SYMBOL_GPL(device_release_driver);
-EXPORT_SYMBOL_GPL(device_attach);
-EXPORT_SYMBOL_GPL(driver_attach);
-
 EXPORT_SYMBOL_GPL(bus_add_device);
 EXPORT_SYMBOL_GPL(bus_remove_device);
 EXPORT_SYMBOL_GPL(bus_register);
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
new file mode 100644
--- /dev/null
+++ b/drivers/base/dd.c
@@ -0,0 +1,200 @@
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
+/**
+ *	device_release_driver - manually detach device from driver.
+ *	@dev:	device.
+ *
+ *	Manually detach device from driver.
+ *	Note that this is called without incrementing the bus
+ *	reference count nor taking the bus's rwsem. Be sure that
+ *	those are accounted for before calling this function.
+ */
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
+		if (drv->remove)
+			drv->remove(dev);
+		dev->driver = NULL;
+	}
+	up(&dev->sem);
+}
+
+/**
+ * driver_detach - detach driver from all devices it controls.
+ * @drv: driver.
+ */
+void driver_detach(struct device_driver * drv)
+{
+	while (!list_empty(&drv->devices)) {
+		struct device * dev = container_of(drv->devices.next, struct device, driver_list);
+		device_release_driver(dev);
+	}
+}
+
+
+EXPORT_SYMBOL_GPL(driver_probe_device);
+EXPORT_SYMBOL_GPL(device_bind_driver);
+EXPORT_SYMBOL_GPL(device_release_driver);
+EXPORT_SYMBOL_GPL(device_attach);
+EXPORT_SYMBOL_GPL(driver_attach);
+

