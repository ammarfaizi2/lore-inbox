Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261789AbVFTXvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261789AbVFTXvN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 19:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbVFTXr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 19:47:27 -0400
Received: from mail.kroah.org ([69.55.234.183]:61412 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261789AbVFTXAF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 19:00:05 -0400
Cc: mochel@digitalimplant.org
Subject: [PATCH] Add a klist to struct bus_type for its devices.
In-Reply-To: <11193083642073@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:24 -0700
Message-Id: <1119308364515@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Add a klist to struct bus_type for its devices.

- Use it for bus_for_each_dev().
- Use the klist spinlock instead of the bus rwsem.

Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 465c7a3a3a5aabcedd2e43612cac5a12f23da19a
tree 392dabbfe84d1de3e84b1eb238bfd09d0ade6c4c
parent 9a19fea43616066561e221359596ce532e631395
author mochel@digitalimplant.org <mochel@digitalimplant.org> Mon, 21 Mar 2005 11:49:14 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:14 -0700

 drivers/base/bus.c     |   54 +++++++++++++++++++++---------------------------
 include/linux/device.h |    3 +++
 2 files changed, 27 insertions(+), 30 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -134,28 +134,6 @@ static struct kobj_type ktype_bus = {
 
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
@@ -180,6 +158,13 @@ static int __bus_for_each_drv(struct bus
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
@@ -203,12 +188,19 @@ static int __bus_for_each_drv(struct bus
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
@@ -293,6 +285,7 @@ int bus_add_device(struct device * dev)
 		list_add_tail(&dev->bus_list, &dev->bus->devices.list);
 		device_attach(dev);
 		up_write(&dev->bus->subsys.rwsem);
+		klist_add_tail(&bus->klist_devices, &dev->knode_bus);
 		device_add_attrs(bus, dev);
 		sysfs_create_link(&bus->devices.kobj, &dev->kobj, dev->bus_id);
 		sysfs_create_link(&dev->kobj, &dev->bus->subsys.kset.kobj, "bus");
@@ -315,6 +308,7 @@ void bus_remove_device(struct device * d
 		sysfs_remove_link(&dev->kobj, "bus");
 		sysfs_remove_link(&dev->bus->devices.kobj, dev->bus_id);
 		device_remove_attrs(dev->bus, dev);
+		klist_remove(&dev->knode_bus);
 		down_write(&dev->bus->subsys.rwsem);
 		pr_debug("bus %s: remove device %s\n", dev->bus->name, dev->bus_id);
 		device_release_driver(dev);
@@ -439,9 +433,7 @@ int bus_rescan_devices(struct bus_type *
 {
 	int count = 0;
 
-	down_write(&bus->subsys.rwsem);
-	__bus_for_each_dev(bus, NULL, &count, bus_rescan_devices_helper);
-	up_write(&bus->subsys.rwsem);
+	bus_for_each_dev(bus, NULL, &count, bus_rescan_devices_helper);
 
 	return count;
 }
@@ -542,6 +534,8 @@ int bus_register(struct bus_type * bus)
 	retval = kset_register(&bus->drivers);
 	if (retval)
 		goto bus_drivers_fail;
+
+	klist_init(&bus->klist_devices);
 	bus_add_attrs(bus);
 
 	pr_debug("bus type '%s' registered\n", bus->name);
diff --git a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -14,6 +14,7 @@
 #include <linux/config.h>
 #include <linux/ioport.h>
 #include <linux/kobject.h>
+#include <linux/klist.h>
 #include <linux/list.h>
 #include <linux/types.h>
 #include <linux/module.h>
@@ -51,6 +52,7 @@ struct bus_type {
 	struct subsystem	subsys;
 	struct kset		drivers;
 	struct kset		devices;
+	struct klist		klist_devices;
 
 	struct bus_attribute	* bus_attrs;
 	struct device_attribute	* dev_attrs;
@@ -262,6 +264,7 @@ struct device {
 	struct list_head bus_list;	/* node in bus's list */
 	struct list_head driver_list;
 	struct list_head children;
+	struct klist_node	knode_bus;
 	struct device 	* parent;
 
 	struct kobject kobj;

