Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261893AbVCUVBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbVCUVBe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 16:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbVCUU4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 15:56:03 -0500
Received: from digitalimplant.org ([64.62.235.95]:23692 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S261893AbVCUUs6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 15:48:58 -0500
Date: Mon, 21 Mar 2005 12:48:53 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: linux-kernel@vger.kernel.org
cc: greg@kroah.com
Subject: [7/9] [RFC] Steps to fixing the driver model locking
Message-ID: <Pine.LNX.4.50.0503211246220.20647-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet@1.2236, 2005-03-21 11:49:14-08:00, mochel@digitalimplant.org
  [driver core] Add a klist to struct bus_type for its devices.

  - Use it for bus_for_each_dev().
  - Use the klist spinlock instead of the bus rwsem.


  Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>

diff -Nru a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c	2005-03-21 12:30:30 -08:00
+++ b/drivers/base/bus.c	2005-03-21 12:30:30 -08:00
@@ -134,28 +134,6 @@

 decl_subsys(bus, &ktype_bus, NULL);

-static int __bus_for_each_dev(struct bus_type *bus, struct device *start,
-			      void *data, int (*fn)(struct device *, void *))
-{
-	struct list_head *head;
-	struct device *dev;
-	int error = 0;
-
-	if (!(bus = get_bus(bus)))
-		return -EINVAL;
-
-	head = &bus->devices.list;
-	dev = list_prepare_entry(start, head, bus_list);
-	list_for_each_entry_continue(dev, head, bus_list) {
-		get_device(dev);
-		error = fn(dev, data);
-		put_device(dev);
-		if (error)
-			break;
-	}
-	put_bus(bus);
-	return error;
-}

 static int __bus_for_each_drv(struct bus_type *bus, struct device_driver *start,
 			      void * data, int (*fn)(struct device_driver *, void *))
@@ -180,6 +158,13 @@
 	return error;
 }

+
+static struct device * next_device(struct klist_iter * i)
+{
+	struct klist_node * n = klist_next(i);
+	return n ? container_of(n, struct device, knode_bus) : NULL;
+}
+
 /**
  *	bus_for_each_dev - device iterator.
  *	@bus:	bus type.
@@ -203,12 +188,19 @@
 int bus_for_each_dev(struct bus_type * bus, struct device * start,
 		     void * data, int (*fn)(struct device *, void *))
 {
-	int ret;
+	struct klist_iter i;
+	struct device * dev;
+	int error = 0;

-	down_read(&bus->subsys.rwsem);
-	ret = __bus_for_each_dev(bus, start, data, fn);
-	up_read(&bus->subsys.rwsem);
-	return ret;
+	if (!bus)
+		return -EINVAL;
+
+	klist_iter_init_node(&bus->klist_devices, &i,
+			     (start ? &start->knode_bus : NULL));
+	while ((dev = next_device(&i)) && !error)
+		error = fn(dev, data);
+	klist_iter_exit(&i);
+	return error;
 }

 /**
@@ -294,6 +286,7 @@
 		list_add_tail(&dev->bus_list, &dev->bus->devices.list);
 		device_attach(dev);
 		up_write(&dev->bus->subsys.rwsem);
+		klist_add_tail(&bus->klist_devices, &dev->knode_bus);
 		device_add_attrs(bus, dev);
 		sysfs_create_link(&bus->devices.kobj, &dev->kobj, dev->bus_id);
 		sysfs_create_link(&dev->kobj, &dev->bus->subsys.kset.kobj, "bus");
@@ -316,6 +309,7 @@
 		sysfs_remove_link(&dev->kobj, "bus");
 		sysfs_remove_link(&dev->bus->devices.kobj, dev->bus_id);
 		device_remove_attrs(dev->bus, dev);
+		klist_remove(&dev->knode_bus);
 		down_write(&dev->bus->subsys.rwsem);
 		pr_debug("bus %s: remove device %s\n", dev->bus->name, dev->bus_id);
 		device_release_driver(dev);
@@ -440,9 +434,7 @@
 {
 	int count = 0;

-	down_write(&bus->subsys.rwsem);
-	__bus_for_each_dev(bus, NULL, &count, bus_rescan_devices_helper);
-	up_write(&bus->subsys.rwsem);
+	bus_for_each_dev(bus, NULL, &count, bus_rescan_devices_helper);

 	return count;
 }
@@ -543,6 +535,8 @@
 	retval = kset_register(&bus->drivers);
 	if (retval)
 		goto bus_drivers_fail;
+
+	klist_init(&bus->klist_devices);
 	bus_add_attrs(bus);

 	pr_debug("bus type '%s' registered\n", bus->name);
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	2005-03-21 12:30:30 -08:00
+++ b/include/linux/device.h	2005-03-21 12:30:30 -08:00
@@ -14,6 +14,7 @@
 #include <linux/config.h>
 #include <linux/ioport.h>
 #include <linux/kobject.h>
+#include <linux/klist.h>
 #include <linux/list.h>
 #include <linux/types.h>
 #include <linux/module.h>
@@ -52,6 +53,7 @@
 	struct subsystem	subsys;
 	struct kset		drivers;
 	struct kset		devices;
+	struct klist		klist_devices;

 	struct bus_attribute	* bus_attrs;
 	struct device_attribute	* dev_attrs;
@@ -263,6 +265,7 @@
 	struct list_head bus_list;	/* node in bus's list */
 	struct list_head driver_list;
 	struct list_head children;
+	struct klist_node	knode_bus;
 	struct device 	* parent;

 	struct kobject kobj;
