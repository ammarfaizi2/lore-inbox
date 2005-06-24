Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263129AbVFXFSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263129AbVFXFSO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 01:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263128AbVFXFQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 01:16:59 -0400
Received: from mail.kroah.org ([69.55.234.183]:3257 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263123AbVFXFP7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 01:15:59 -0400
Date: Thu, 23 Jun 2005 22:15:49 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Patrick Mochel <mochel@digitalimplant.org>
Subject: [PATCH] driver core: Add the ability to bind drivers to devices from userspace
Message-ID: <20050624051549.GC24621@kroah.com>
References: <20050624051229.GA24621@kroah.com> <20050624051442.GB24621@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050624051442.GB24621@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a single file, "bind", to the sysfs directory of every driver
registered with the driver core.  To bind a device to a driver, write
the bus id of the device you wish to bind to that specific driver to the
"bind" file (remember to not add a trailing \n).  If that bus id matches
a device on that bus, and it does not currently have a driver bound to
it, the probe sequence will be initiated with that driver and device.

Note, this requires that the driver itself be willing and able to accept
that device (usually through a device id type table).  This patch does
not make it possible to override the driver's id table.


Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/base/base.h |    1 +
 drivers/base/bus.c  |   36 ++++++++++++++++++++++++++++++++++++
 drivers/base/dd.c   |    2 +-
 3 files changed, 38 insertions(+), 1 deletion(-)

--- gregkh-2.6.orig/drivers/base/bus.c	2005-06-22 23:21:11.000000000 -0700
+++ gregkh-2.6/drivers/base/bus.c	2005-06-22 23:23:19.000000000 -0700
@@ -133,6 +133,40 @@
 decl_subsys(bus, &ktype_bus, NULL);
 
 
+/*
+ * Manually attach a device to a driver.
+ * Note: the driver must want to bind to the device,
+ * it is not possible to override the driver's id table.
+ */
+static int driver_bind_helper(struct device *dev, void *data)
+{
+	const char *name = data;
+
+	if ((dev->driver == NULL) &&
+	    (strcmp(name, dev->bus_id) == 0))
+		return 1;
+	return 0;
+}
+
+static ssize_t driver_bind(struct device_driver *drv,
+			   const char *buf, size_t count)
+{
+	struct bus_type *bus = get_bus(drv->bus);
+	struct device *dev;
+	int err = -ENODEV;
+
+	dev = bus_find_device(bus, NULL, (void *)buf, driver_bind_helper);
+	if (dev) {
+		down(&dev->sem);
+		err = driver_probe_device(drv, dev);
+		up(&dev->sem);
+		put_device(dev);
+	}
+	return err;
+}
+static DRIVER_ATTR(bind, S_IWUSR, NULL, driver_bind);
+
+
 static struct device * next_device(struct klist_iter * i)
 {
 	struct klist_node * n = klist_next(i);
@@ -396,6 +430,7 @@
 		module_add_driver(drv->owner, drv);
 
 		driver_add_attrs(bus, drv);
+		driver_create_file(drv, &driver_attr_bind);
 	}
 	return error;
 }
@@ -413,6 +448,7 @@
 void bus_remove_driver(struct device_driver * drv)
 {
 	if (drv->bus) {
+		driver_remove_file(drv, &driver_attr_bind);
 		driver_remove_attrs(drv->bus, drv);
 		klist_remove(&drv->knode_bus);
 		pr_debug("bus %s: remove driver %s\n", drv->bus->name, drv->name);
--- gregkh-2.6.orig/drivers/base/base.h	2005-06-22 23:20:58.000000000 -0700
+++ gregkh-2.6/drivers/base/base.h	2005-06-22 23:21:14.000000000 -0700
@@ -5,6 +5,7 @@
 extern void bus_remove_driver(struct device_driver *);
 
 extern void driver_detach(struct device_driver * drv);
+extern int driver_probe_device(struct device_driver *, struct device *);
 
 static inline struct class_device *to_class_dev(struct kobject *obj)
 {
--- gregkh-2.6.orig/drivers/base/dd.c	2005-06-22 23:21:13.000000000 -0700
+++ gregkh-2.6/drivers/base/dd.c	2005-06-22 23:21:14.000000000 -0700
@@ -75,7 +75,7 @@
  *
  *	This function must be called with @dev->sem held.
  */
-static int driver_probe_device(struct device_driver * drv, struct device * dev)
+int driver_probe_device(struct device_driver * drv, struct device * dev)
 {
 	int ret = 0;
 
