Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316542AbSFEXYp>; Wed, 5 Jun 2002 19:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316568AbSFEXYo>; Wed, 5 Jun 2002 19:24:44 -0400
Received: from air-2.osdl.org ([65.201.151.6]:139 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S316542AbSFEXYl>;
	Wed, 5 Jun 2002 19:24:41 -0400
Date: Wed, 5 Jun 2002 16:20:39 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@geena.pdx.osdl.net>
To: <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: device model update 2/2
Message-ID: <Pine.LNX.4.33.0206051617560.654-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is an attempt to better locking for both device and driver removal. 
Comments gladly welcomed.

Pull from bk://ldm.bkbits.net/linux-2.5

	-pat

ChangeSet@1.456, 2002-06-05 15:59:32-07:00, mochel@osdl.org
  Attempt to better locking in device model core: 
  
  - remove device from driver's list on device_detach 
  - set device's driver to NULL
  - decrement reference count on driver on device_detach
  - remove devices from driver's list in driver_detach
  - use a write_lock instead of read_lock
  - don't lock around initialization of device fields
  
  - assume we have a bus in __remove_driver (we enforce this in driver_register)
  - do put_bus last in __remove_driver
  - lock bus around atomic_set in remove_driver and atomic_dec_and_test in put_driver
  - remove from bus's list while we have it locked

 drivers/base/bus.c    |    5 +++--
 drivers/base/core.c   |   30 +++++++++++++++++++++---------
 drivers/base/driver.c |   29 +++++++++++++----------------
 3 files changed, 37 insertions, 27 deletions



diff -Nru a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c	Wed Jun  5 16:02:11 2002
+++ b/drivers/base/bus.c	Wed Jun  5 16:02:11 2002
@@ -167,12 +167,13 @@
 
 int bus_register(struct bus_type * bus)
 {
-	spin_lock(&device_lock);
 	rwlock_init(&bus->lock);
 	INIT_LIST_HEAD(&bus->devices);
 	INIT_LIST_HEAD(&bus->drivers);
-	list_add_tail(&bus->node,&bus_driver_list);
 	atomic_set(&bus->refcount,2);
+
+	spin_lock(&device_lock);
+	list_add_tail(&bus->node,&bus_driver_list);
 	spin_unlock(&device_lock);
 
 	pr_debug("bus type '%s' registered\n",bus->name);
diff -Nru a/drivers/base/core.c b/drivers/base/core.c
--- a/drivers/base/core.c	Wed Jun  5 16:02:11 2002
+++ b/drivers/base/core.c	Wed Jun  5 16:02:11 2002
@@ -98,9 +98,20 @@
 
 static void device_detach(struct device * dev)
 {
-	/* detach from driver */
-	if (dev->driver && dev->driver->remove)
-		dev->driver->remove(dev);
+	if (dev->driver) {
+		write_lock(&dev->driver->lock);
+		list_del_init(&dev->driver_list);
+		write_unlock(&dev->driver->lock);
+
+		lock_device(dev);
+		dev->driver = NULL;
+		unlock_device(dev);
+
+		/* detach from driver */
+		if (dev->driver->remove)
+			dev->driver->remove(dev);
+		put_driver(dev->driver);
+	}
 }
 
 static int do_driver_attach(struct device * dev, void * data)
@@ -140,12 +151,13 @@
 	struct list_head * node;
 	int error = 0;
 
-	read_lock(&drv->lock);
+	write_lock(&drv->lock);
 	node = drv->devices.next;
 	while (node != &drv->devices) {
 		next = list_entry(node,struct device,driver_list);
 		get_device(next);
-		read_unlock(&drv->lock);
+		list_del_init(&next->driver_list);
+		write_unlock(&drv->lock);
 
 		if (dev)
 			put_device(dev);
@@ -154,10 +166,10 @@
 			put_device(dev);
 			break;
 		}
-		read_lock(&drv->lock);
-		node = dev->driver_list.next;
+		write_lock(&drv->lock);
+		node = drv->devices.next;
 	}
-	read_unlock(&drv->lock);
+	write_unlock(&drv->lock);
 	if (dev)
 		put_device(dev);
 }
@@ -181,13 +193,13 @@
 	if (!dev || !strlen(dev->bus_id))
 		return -EINVAL;
 
-	spin_lock(&device_lock);
 	INIT_LIST_HEAD(&dev->node);
 	INIT_LIST_HEAD(&dev->children);
 	INIT_LIST_HEAD(&dev->g_list);
 	spin_lock_init(&dev->lock);
 	atomic_set(&dev->refcount,2);
 
+	spin_lock(&device_lock);
 	if (dev != &device_root) {
 		if (!dev->parent)
 			dev->parent = &device_root;
diff -Nru a/drivers/base/driver.c b/drivers/base/driver.c
--- a/drivers/base/driver.c	Wed Jun  5 16:02:11 2002
+++ b/drivers/base/driver.c	Wed Jun  5 16:02:11 2002
@@ -81,26 +81,20 @@
 
 static void __remove_driver(struct device_driver * drv)
 {
-	if (drv->bus) {
-		pr_debug("Unregistering driver '%s' from bus '%s'\n",drv->name,drv->bus->name);
-
-		driver_detach(drv);
-		write_lock(&drv->bus->lock);
-		list_del_init(&drv->bus_list);
-		write_unlock(&drv->bus->lock);
-
-		driverfs_remove_dir(&drv->dir);
-		put_bus(drv->bus);
-	}
+	pr_debug("Unregistering driver '%s' from bus '%s'\n",drv->name,drv->bus->name);
+	driver_detach(drv);
+	driverfs_remove_dir(&drv->dir);
 	if (drv->release)
 		drv->release(drv);
+	put_bus(drv->bus);
 }
 
 void remove_driver(struct device_driver * drv)
 {
-	spin_lock(&device_lock);
+	write_lock(&drv->bus->lock);
 	atomic_set(&drv->refcount,0);
-	spin_unlock(&device_lock);
+	list_del_init(&drv->bus_list);
+	write_unlock(&drv->bus->lock);
 	__remove_driver(drv);
 }
 
@@ -110,10 +104,13 @@
  */
 void put_driver(struct device_driver * drv)
 {
-	if (!atomic_dec_and_lock(&drv->refcount,&device_lock))
+	write_lock(&drv->bus->lock);
+	if (!atomic_dec_and_test(&drv->refcount)) {
+		write_unlock(&drv->bus->lock);
 		return;
-	spin_unlock(&device_lock);
-
+	}
+	list_del_init(&drv->bus_list);
+	write_unlock(&drv->bus->lock);
 	__remove_driver(drv);
 }
 


