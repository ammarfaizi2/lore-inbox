Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261897AbVCUUwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbVCUUwO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 15:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbVCUUwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 15:52:14 -0500
Received: from digitalimplant.org ([64.62.235.95]:31628 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S261897AbVCUUtH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 15:49:07 -0500
Date: Mon, 21 Mar 2005 12:49:01 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: linux-kernel@vger.kernel.org
cc: greg@kroah.com
Subject: [9/9] [RFC] Steps to fixing the driver model locking
Message-ID: <Pine.LNX.4.50.0503211247050.20647-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet@1.2238, 2005-03-21 12:25:36-08:00, mochel@digitalimplant.org
  [driver core] Add a klist to struct device_driver for the devices bound to it.

  - Use it in driver_for_each_device() instead of the regular list_head and stop using
    the bus's rwsem for protection.
  - Use driver_for_each_device() in driver_detach() so we don't deadlock on the
    bus's rwsem.
  - Remove ->devices.
  - Move klist access and sysfs link access out from under device's semaphore, since
    they're synchronized through other means.



  Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>

diff -Nru a/drivers/base/core.c b/drivers/base/core.c
--- a/drivers/base/core.c	2005-03-21 12:30:23 -08:00
+++ b/drivers/base/core.c	2005-03-21 12:30:23 -08:00
@@ -212,8 +212,8 @@
 	kobject_init(&dev->kobj);
 	INIT_LIST_HEAD(&dev->node);
 	INIT_LIST_HEAD(&dev->children);
-	INIT_LIST_HEAD(&dev->driver_list);
 	INIT_LIST_HEAD(&dev->bus_list);
+	INIT_LIST_HEAD(&dev->driver_list);
 	INIT_LIST_HEAD(&dev->dma_pools);
 	init_MUTEX(&dev->sem);
 }
diff -Nru a/drivers/base/dd.c b/drivers/base/dd.c
--- a/drivers/base/dd.c	2005-03-21 12:30:23 -08:00
+++ b/drivers/base/dd.c	2005-03-21 12:30:23 -08:00
@@ -41,7 +41,7 @@
 {
 	pr_debug("bound device '%s' to driver '%s'\n",
 		 dev->bus_id, dev->driver->name);
-	list_add_tail(&dev->driver_list, &dev->driver->devices);
+	klist_add_tail(&dev->driver->klist_devices, &dev->knode_driver);
 	sysfs_create_link(&dev->driver->kobj, &dev->kobj,
 			  kobject_name(&dev->kobj));
 	sysfs_create_link(&dev->kobj, &dev->driver->kobj, "driver");
@@ -170,23 +170,30 @@

 void device_release_driver(struct device * dev)
 {
-	struct device_driver * drv;
+	struct device_driver * drv = dev->driver;
+
+	if (!drv)
+		return;
+
+	sysfs_remove_link(&drv->kobj, kobject_name(&dev->kobj));
+	sysfs_remove_link(&dev->kobj, "driver");
+	klist_remove(&dev->knode_driver);

 	down(&dev->sem);
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
+	device_detach_shutdown(dev);
+	if (drv->remove)
+		drv->remove(dev);
+	dev->driver = NULL;
 	up(&dev->sem);
 }


+static int __remove_driver(struct device * dev, void * unused)
+{
+	device_release_driver(dev);
+	return 0;
+}
+
 /**
  *	driver_detach - detach driver from all devices it controls.
  *	@drv:	driver.
@@ -194,11 +201,7 @@

 void driver_detach(struct device_driver * drv)
 {
-	struct list_head * entry, * next;
-	list_for_each_safe(entry, next, &drv->devices) {
-		struct device * dev = container_of(entry, struct device, driver_list);
-		device_release_driver(dev);
-	}
+	driver_for_each_device(drv, NULL, NULL, __remove_driver);
 }

 EXPORT_SYMBOL_GPL(driver_probe_device);
diff -Nru a/drivers/base/driver.c b/drivers/base/driver.c
--- a/drivers/base/driver.c	2005-03-21 12:30:23 -08:00
+++ b/drivers/base/driver.c	2005-03-21 12:30:23 -08:00
@@ -19,6 +19,12 @@
 #define to_drv(obj) container_of(obj, struct device_driver, kobj)


+static struct device * next_device(struct klist_iter * i)
+{
+	struct klist_node * n = klist_next(i);
+	return n ? container_of(n, struct device, knode_driver) : NULL;
+}
+
 /**
  *	driver_for_each_device - Iterator for devices bound to a driver.
  *	@drv:	Driver we're iterating.
@@ -32,21 +38,18 @@
 int driver_for_each_device(struct device_driver * drv, struct device * start,
 			   void * data, int (*fn)(struct device *, void *))
 {
-	struct list_head * head;
+	struct klist_iter i;
 	struct device * dev;
 	int error = 0;

-	down_read(&drv->bus->subsys.rwsem);
-	head = &drv->devices;
-	dev = list_prepare_entry(start, head, driver_list);
-	list_for_each_entry_continue(dev, head, driver_list) {
-		get_device(dev);
+	if (!drv)
+		return -EINVAL;
+
+	klist_iter_init_node(&drv->klist_devices, &i,
+			     start ? &start->knode_driver : NULL);
+	while ((dev = next_device(&i)) && !error)
 		error = fn(dev, data);
-		put_device(dev);
-		if (error)
-			break;
-	}
-	up_read(&drv->bus->subsys.rwsem);
+	klist_iter_exit(&i);
 	return error;
 }

@@ -120,7 +123,7 @@
  */
 int driver_register(struct device_driver * drv)
 {
-	INIT_LIST_HEAD(&drv->devices);
+	klist_init(&drv->klist_devices);
 	init_completion(&drv->unloaded);
 	return bus_add_driver(drv);
 }
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	2005-03-21 12:30:23 -08:00
+++ b/include/linux/device.h	2005-03-21 12:30:23 -08:00
@@ -106,7 +106,7 @@

 	struct completion	unloaded;
 	struct kobject		kobj;
-	struct list_head	devices;
+	struct klist		klist_devices;
 	struct klist_node	knode_bus;

 	struct module 		* owner;
@@ -267,6 +267,7 @@
 	struct list_head bus_list;	/* node in bus's list */
 	struct list_head driver_list;
 	struct list_head children;
+	struct klist_node	knode_driver;
 	struct klist_node	knode_bus;
 	struct device 	* parent;

