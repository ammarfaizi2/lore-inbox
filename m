Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262859AbVF3GKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262859AbVF3GKb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 02:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262866AbVF3GJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 02:09:08 -0400
Received: from mail.kroah.org ([69.55.234.183]:28300 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262865AbVF3GE1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 02:04:27 -0400
Cc: gregkh@suse.de
Subject: [PATCH] driver core: Add the ability to bind drivers to devices from userspace
In-Reply-To: <1120111462947@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 29 Jun 2005 23:04:22 -0700
Message-Id: <11201114622095@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] driver core: Add the ability to bind drivers to devices from userspace

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
commit afdce75f1eaebcf358b7594ba7969aade105c3b0
tree 5374a0e85e03c8706a1dd95478b9d0a3312917e0
parent 151ef38f7c0ec1b0420f04438b0316e3a30bf2e4
author Greg Kroah-Hartman <gregkh@suse.de> Wed, 22 Jun 2005 16:09:05 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Wed, 29 Jun 2005 22:48:04 -0700

 drivers/base/base.h |    1 +
 drivers/base/bus.c  |   26 ++++++++++++++++++++++++++
 drivers/base/dd.c   |    2 +-
 3 files changed, 28 insertions(+), 1 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -5,6 +5,7 @@ extern int bus_add_driver(struct device_
 extern void bus_remove_driver(struct device_driver *);
 
 extern void driver_detach(struct device_driver * drv);
+extern int driver_probe_device(struct device_driver *, struct device *);
 
 static inline struct class_device *to_class_dev(struct kobject *obj)
 {
diff --git a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -160,6 +160,30 @@ static ssize_t driver_unbind(struct devi
 }
 static DRIVER_ATTR(unbind, S_IWUSR, NULL, driver_unbind);
 
+/*
+ * Manually attach a device to a driver.
+ * Note: the driver must want to bind to the device,
+ * it is not possible to override the driver's id table.
+ */
+static ssize_t driver_bind(struct device_driver *drv,
+			   const char *buf, size_t count)
+{
+	struct bus_type *bus = get_bus(drv->bus);
+	struct device *dev;
+	int err = -ENODEV;
+
+	dev = bus_find_device(bus, NULL, (void *)buf, driver_helper);
+	if ((dev) &&
+	    (dev->driver == NULL)) {
+		down(&dev->sem);
+		err = driver_probe_device(drv, dev);
+		up(&dev->sem);
+		put_device(dev);
+	}
+	return err;
+}
+static DRIVER_ATTR(bind, S_IWUSR, NULL, driver_bind);
+
 
 static struct device * next_device(struct klist_iter * i)
 {
@@ -425,6 +449,7 @@ int bus_add_driver(struct device_driver 
 
 		driver_add_attrs(bus, drv);
 		driver_create_file(drv, &driver_attr_unbind);
+		driver_create_file(drv, &driver_attr_bind);
 	}
 	return error;
 }
@@ -442,6 +467,7 @@ int bus_add_driver(struct device_driver 
 void bus_remove_driver(struct device_driver * drv)
 {
 	if (drv->bus) {
+		driver_remove_file(drv, &driver_attr_bind);
 		driver_remove_file(drv, &driver_attr_unbind);
 		driver_remove_attrs(drv->bus, drv);
 		klist_remove(&drv->knode_bus);
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -65,7 +65,7 @@ void device_bind_driver(struct device * 
  *
  *	This function must be called with @dev->sem held.
  */
-static int driver_probe_device(struct device_driver * drv, struct device * dev)
+int driver_probe_device(struct device_driver * drv, struct device * dev)
 {
 	int ret = 0;
 

