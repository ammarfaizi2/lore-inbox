Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261913AbVCUUzt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261913AbVCUUzt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 15:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbVCUUxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 15:53:01 -0500
Received: from digitalimplant.org ([64.62.235.95]:31372 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S261896AbVCUUtH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 15:49:07 -0500
Date: Mon, 21 Mar 2005 12:48:57 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: linux-kernel@vger.kernel.org
cc: greg@kroah.com
Subject: [8/9] [RFC] Steps to fixing the driver model locking
Message-ID: <Pine.LNX.4.50.0503211246410.20647-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet@1.2237, 2005-03-21 12:00:18-08:00, mochel@digitalimplant.org
  [driver core] Add a klist to struct bus_type for its drivers.


  - Use it in bus_for_each_drv().
  - Use the klist spinlock instead of the bus rwsem.



  Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>

diff -Nru a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c	2005-03-21 12:30:27 -08:00
+++ b/drivers/base/bus.c	2005-03-21 12:30:27 -08:00
@@ -135,30 +135,6 @@
 decl_subsys(bus, &ktype_bus, NULL);


-static int __bus_for_each_drv(struct bus_type *bus, struct device_driver *start,
-			      void * data, int (*fn)(struct device_driver *, void *))
-{
-	struct list_head *head;
-	struct device_driver *drv;
-	int error = 0;
-
-	if (!(bus = get_bus(bus)))
-		return -EINVAL;
-
-	head = &bus->drivers.list;
-	drv = list_prepare_entry(start, head, kobj.entry);
-	list_for_each_entry_continue(drv, head, kobj.entry) {
-		get_driver(drv);
-		error = fn(drv, data);
-		put_driver(drv);
-		if (error)
-			break;
-	}
-	put_bus(bus);
-	return error;
-}
-
-
 static struct device * next_device(struct klist_iter * i)
 {
 	struct klist_node * n = klist_next(i);
@@ -203,6 +179,14 @@
 	return error;
 }

+
+
+static struct device_driver * next_driver(struct klist_iter * i)
+{
+	struct klist_node * n = klist_next(i);
+	return n ? container_of(n, struct device_driver, knode_bus) : NULL;
+}
+
 /**
  *	bus_for_each_drv - driver iterator
  *	@bus:	bus we're dealing with.
@@ -226,12 +210,19 @@
 int bus_for_each_drv(struct bus_type * bus, struct device_driver * start,
 		     void * data, int (*fn)(struct device_driver *, void *))
 {
-	int ret;
+	struct klist_iter i;
+	struct device_driver * drv;
+	int error = 0;

-	down_read(&bus->subsys.rwsem);
-	ret = __bus_for_each_drv(bus, start, data, fn);
-	up_read(&bus->subsys.rwsem);
-	return ret;
+	if (!bus)
+		return -EINVAL;
+
+	klist_iter_init_node(&bus->klist_drivers, &i,
+			     start ? &start->knode_bus : NULL);
+	while ((drv = next_driver(&i)) && !error)
+		error = fn(drv, data);
+	klist_iter_exit(&i);
+	return error;
 }


@@ -377,6 +368,7 @@
 		down_write(&bus->subsys.rwsem);
 		driver_attach(drv);
 		up_write(&bus->subsys.rwsem);
+		klist_add_tail(&bus->klist_drivers, &drv->knode_bus);
 		module_add_driver(drv->owner, drv);

 		driver_add_attrs(bus, drv);
@@ -398,6 +390,7 @@
 {
 	if (drv->bus) {
 		driver_remove_attrs(drv->bus, drv);
+		klist_remove(&drv->knode_bus);
 		down_write(&drv->bus->subsys.rwsem);
 		pr_debug("bus %s: remove driver %s\n", drv->bus->name, drv->name);
 		driver_detach(drv);
@@ -537,6 +530,7 @@
 		goto bus_drivers_fail;

 	klist_init(&bus->klist_devices);
+	klist_init(&bus->klist_drivers);
 	bus_add_attrs(bus);

 	pr_debug("bus type '%s' registered\n", bus->name);
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	2005-03-21 12:30:27 -08:00
+++ b/include/linux/device.h	2005-03-21 12:30:27 -08:00
@@ -54,6 +54,7 @@
 	struct kset		drivers;
 	struct kset		devices;
 	struct klist		klist_devices;
+	struct klist		klist_drivers;

 	struct bus_attribute	* bus_attrs;
 	struct device_attribute	* dev_attrs;
@@ -106,6 +107,7 @@
 	struct completion	unloaded;
 	struct kobject		kobj;
 	struct list_head	devices;
+	struct klist_node	knode_bus;

 	struct module 		* owner;

