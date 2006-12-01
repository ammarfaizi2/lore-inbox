Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162235AbWLAXWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162235AbWLAXWW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 18:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162237AbWLAXWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 18:22:22 -0500
Received: from ns1.suse.de ([195.135.220.2]:9357 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1162235AbWLAXWV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 18:22:21 -0500
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Kay Sievers <kay.sievers@novell.com>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 2/36] Driver core: fix "driver" symlink timing
Date: Fri,  1 Dec 2006 15:21:32 -0800
Message-Id: <11650153293531-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.4.1
In-Reply-To: <11650153262399-git-send-email-greg@kroah.com>
References: <20061201231620.GA7560@kroah.com> <11650153262399-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kay Sievers <kay.sievers@novell.com>

Create the "driver" link before the child device may be created by
the probing logic. This makes it possible for userspace (udev), to
determine the driver property of the parent device, at the time the
child device is created.

Signed-off-by: Kay Sievers <kay.sievers@novell.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/dd.c |   82 +++++++++++++++++++++++++++++++++-------------------
 1 files changed, 52 insertions(+), 30 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 9c88b1e..510e788 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -26,28 +26,12 @@
 #define to_drv(node) container_of(node, struct device_driver, kobj.entry)
 
 
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
- *
- *	This function must be called with @dev->sem held.
- */
-int device_bind_driver(struct device *dev)
+static void driver_bound(struct device *dev)
 {
-	int ret;
-
 	if (klist_node_attached(&dev->knode_driver)) {
 		printk(KERN_WARNING "%s: device %s already bound\n",
 			__FUNCTION__, kobject_name(&dev->kobj));
-		return 0;
+		return;
 	}
 
 	pr_debug("bound device '%s' to driver '%s'\n",
@@ -58,6 +42,12 @@ int device_bind_driver(struct device *de
 					     BUS_NOTIFY_BOUND_DRIVER, dev);
 
 	klist_add_tail(&dev->knode_driver, &dev->driver->klist_devices);
+}
+
+static int driver_sysfs_add(struct device *dev)
+{
+	int ret;
+
 	ret = sysfs_create_link(&dev->driver->kobj, &dev->kobj,
 			  kobject_name(&dev->kobj));
 	if (ret == 0) {
@@ -70,6 +60,36 @@ int device_bind_driver(struct device *de
 	return ret;
 }
 
+static void driver_sysfs_remove(struct device *dev)
+{
+	struct device_driver *drv = dev->driver;
+
+	if (drv) {
+		sysfs_remove_link(&drv->kobj, kobject_name(&dev->kobj));
+		sysfs_remove_link(&dev->kobj, "driver");
+	}
+}
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
+ *
+ *	This function must be called with @dev->sem held.
+ */
+int device_bind_driver(struct device *dev)
+{
+	driver_bound(dev);
+	return driver_sysfs_add(dev);
+}
+
 struct stupid_thread_structure {
 	struct device_driver *drv;
 	struct device *dev;
@@ -90,30 +110,32 @@ static int really_probe(void *void_data)
 		 drv->bus->name, drv->name, dev->bus_id);
 
 	dev->driver = drv;
+	if (driver_sysfs_add(dev)) {
+		printk(KERN_ERR "%s: driver_sysfs_add(%s) failed\n",
+			__FUNCTION__, dev->bus_id);
+		goto probe_failed;
+	}
+
 	if (dev->bus->probe) {
 		ret = dev->bus->probe(dev);
-		if (ret) {
-			dev->driver = NULL;
+		if (ret)
 			goto probe_failed;
-		}
 	} else if (drv->probe) {
 		ret = drv->probe(dev);
-		if (ret) {
-			dev->driver = NULL;
+		if (ret)
 			goto probe_failed;
-		}
-	}
-	if (device_bind_driver(dev)) {
-		printk(KERN_ERR "%s: device_bind_driver(%s) failed\n",
-			__FUNCTION__, dev->bus_id);
-		/* How does undo a ->probe?  We're screwed. */
 	}
+
+	driver_bound(dev);
 	ret = 1;
 	pr_debug("%s: Bound Device %s to Driver %s\n",
 		 drv->bus->name, dev->bus_id, drv->name);
 	goto done;
 
 probe_failed:
+	driver_sysfs_remove(dev);
+	dev->driver = NULL;
+
 	if (ret == -ENODEV || ret == -ENXIO) {
 		/* Driver matched, but didn't support device
 		 * or device not found.
@@ -289,7 +311,7 @@ static void __device_release_driver(stru
 	drv = dev->driver;
 	if (drv) {
 		get_driver(drv);
-		sysfs_remove_link(&drv->kobj, kobject_name(&dev->kobj));
+		driver_sysfs_remove(dev);
 		sysfs_remove_link(&dev->kobj, "driver");
 		klist_remove(&dev->knode_driver);
 
-- 
1.4.4.1

