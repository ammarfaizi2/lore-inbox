Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261825AbVFUCMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbVFUCMI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 22:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbVFUCKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 22:10:09 -0400
Received: from mail.kroah.org ([69.55.234.183]:39652 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261755AbVFTW7w convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:52 -0400
Cc: mochel@digitalimplant.org
Subject: [PATCH] Add a klist to struct device_driver for the devices bound to it.
In-Reply-To: <1119308365601@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:25 -0700
Message-Id: <11193083653772@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Add a klist to struct device_driver for the devices bound to it.

- Use it in driver_for_each_device() instead of the regular list_head and stop using
  the bus's rwsem for protection.
- Use driver_for_each_device() in driver_detach() so we don't deadlock on the
  bus's rwsem.
- Remove ->devices.
- Move klist access and sysfs link access out from under device's semaphore, since
  they're synchronized through other means.

Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 94e7b1c5ff2055571703e38b059afffe17658432
tree 469dbd920087ec62acd88b4985437a78c6786c0e
parent 38fdac3cdce276554b4484a41f8ec2daf81cb2ff
author mochel@digitalimplant.org <mochel@digitalimplant.org> Mon, 21 Mar 2005 12:25:36 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:16 -0700

 drivers/base/core.c    |    2 +-
 drivers/base/dd.c      |   34 +++++++++++++++++++---------------
 drivers/base/driver.c  |   27 +++++++++++++++------------
 include/linux/device.h |    3 ++-
 4 files changed, 37 insertions(+), 29 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -209,8 +209,8 @@ void device_initialize(struct device *de
 	kobject_init(&dev->kobj);
 	INIT_LIST_HEAD(&dev->node);
 	INIT_LIST_HEAD(&dev->children);
-	INIT_LIST_HEAD(&dev->driver_list);
 	INIT_LIST_HEAD(&dev->bus_list);
+	INIT_LIST_HEAD(&dev->driver_list);
 	INIT_LIST_HEAD(&dev->dma_pools);
 	init_MUTEX(&dev->sem);
 }
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -40,7 +40,7 @@ void device_bind_driver(struct device * 
 {
 	pr_debug("bound device '%s' to driver '%s'\n",
 		 dev->bus_id, dev->driver->name);
-	list_add_tail(&dev->driver_list, &dev->driver->devices);
+	klist_add_tail(&dev->driver->klist_devices, &dev->knode_driver);
 	sysfs_create_link(&dev->driver->kobj, &dev->kobj,
 			  kobject_name(&dev->kobj));
 	sysfs_create_link(&dev->kobj, &dev->driver->kobj, "driver");
@@ -164,31 +164,35 @@ void driver_attach(struct device_driver 
  */
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
-		if (drv->remove)
-			drv->remove(dev);
-		dev->driver = NULL;
-	}
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
  * driver_detach - detach driver from all devices it controls.
  * @drv: driver.
  */
 void driver_detach(struct device_driver * drv)
 {
-	while (!list_empty(&drv->devices)) {
-		struct device * dev = container_of(drv->devices.next, struct device, driver_list);
-		device_release_driver(dev);
-	}
+	driver_for_each_device(drv, NULL, NULL, __remove_driver);
 }
 
 
diff --git a/drivers/base/driver.c b/drivers/base/driver.c
--- a/drivers/base/driver.c
+++ b/drivers/base/driver.c
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
 
@@ -120,7 +123,7 @@ void put_driver(struct device_driver * d
  */
 int driver_register(struct device_driver * drv)
 {
-	INIT_LIST_HEAD(&drv->devices);
+	klist_init(&drv->klist_devices);
 	init_completion(&drv->unloaded);
 	return bus_add_driver(drv);
 }
diff --git a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -105,7 +105,7 @@ struct device_driver {
 
 	struct completion	unloaded;
 	struct kobject		kobj;
-	struct list_head	devices;
+	struct klist		klist_devices;
 	struct klist_node	knode_bus;
 
 	struct module		* owner;
@@ -266,6 +266,7 @@ struct device {
 	struct list_head bus_list;	/* node in bus's list */
 	struct list_head driver_list;
 	struct list_head children;
+	struct klist_node	knode_driver;
 	struct klist_node	knode_bus;
 	struct device 	* parent;
 

