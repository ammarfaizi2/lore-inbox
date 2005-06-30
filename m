Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262862AbVF3GG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262862AbVF3GG4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 02:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262859AbVF3GGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 02:06:55 -0400
Received: from mail.kroah.org ([69.55.234.183]:31884 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262869AbVF3GE2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 02:04:28 -0400
Cc: cohuck@de.ibm.com
Subject: [PATCH] driver core: add bus_find_device & driver_find_device functions
In-Reply-To: <20050630060206.GA23321@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 29 Jun 2005 23:04:21 -0700
Message-Id: <11201114612875@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] driver core: add bus_find_device & driver_find_device functions

Add bus_find_device() and driver_find_device() which allow searching for a
device in the bus's resp. the driver's klist and obtain a reference on it.

Signed-off-by: Cornelia Huck <cohuck@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 0edb586049e57c56e625536476931117a57671e9
tree 9d92bb9821d134d199d62de1ff3096ff2b73fdc7
parent fd782a4a99d2d3e818b9465c427b10f7f027d7da
author Cornelia Huck <cohuck@de.ibm.com> Wed, 22 Jun 2005 16:59:51 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Wed, 29 Jun 2005 22:48:03 -0700

 drivers/base/bus.c     |   34 ++++++++++++++++++++++++++++++++++
 drivers/base/driver.c  |   35 +++++++++++++++++++++++++++++++++++
 include/linux/device.h |    5 +++++
 3 files changed, 74 insertions(+), 0 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -177,6 +177,39 @@ int bus_for_each_dev(struct bus_type * b
 	return error;
 }
 
+/**
+ * bus_find_device - device iterator for locating a particular device.
+ * @bus: bus type
+ * @start: Device to begin with
+ * @data: Data to pass to match function
+ * @match: Callback function to check device
+ *
+ * This is similar to the bus_for_each_dev() function above, but it
+ * returns a reference to a device that is 'found' for later use, as
+ * determined by the @match callback.
+ *
+ * The callback should return 0 if the device doesn't match and non-zero
+ * if it does.  If the callback returns non-zero, this function will
+ * return to the caller and not iterate over any more devices.
+ */
+struct device * bus_find_device(struct bus_type *bus,
+				struct device *start, void *data,
+				int (*match)(struct device *, void *))
+{
+	struct klist_iter i;
+	struct device *dev;
+
+	if (!bus)
+		return NULL;
+
+	klist_iter_init_node(&bus->klist_devices, &i,
+			     (start ? &start->knode_bus : NULL));
+	while ((dev = next_device(&i)))
+		if (match(dev, data) && get_device(dev))
+			break;
+	klist_iter_exit(&i);
+	return dev;
+}
 
 
 static struct device_driver * next_driver(struct klist_iter * i)
@@ -557,6 +590,7 @@ int __init buses_init(void)
 
 
 EXPORT_SYMBOL_GPL(bus_for_each_dev);
+EXPORT_SYMBOL_GPL(bus_find_device);
 EXPORT_SYMBOL_GPL(bus_for_each_drv);
 
 EXPORT_SYMBOL_GPL(bus_add_device);
diff --git a/drivers/base/driver.c b/drivers/base/driver.c
--- a/drivers/base/driver.c
+++ b/drivers/base/driver.c
@@ -56,6 +56,41 @@ EXPORT_SYMBOL_GPL(driver_for_each_device
 
 
 /**
+ * driver_find_device - device iterator for locating a particular device.
+ * @driver: The device's driver
+ * @start: Device to begin with
+ * @data: Data to pass to match function
+ * @match: Callback function to check device
+ *
+ * This is similar to the driver_for_each_device() function above, but
+ * it returns a reference to a device that is 'found' for later use, as
+ * determined by the @match callback.
+ *
+ * The callback should return 0 if the device doesn't match and non-zero
+ * if it does.  If the callback returns non-zero, this function will
+ * return to the caller and not iterate over any more devices.
+ */
+struct device * driver_find_device(struct device_driver *drv,
+				   struct device * start, void * data,
+				   int (*match)(struct device *, void *))
+{
+	struct klist_iter i;
+	struct device *dev;
+
+	if (!drv)
+		return NULL;
+
+	klist_iter_init_node(&drv->klist_devices, &i,
+			     (start ? &start->knode_driver : NULL));
+	while ((dev = next_device(&i)))
+		if (match(dev, data) && get_device(dev))
+			break;
+	klist_iter_exit(&i);
+	return dev;
+}
+EXPORT_SYMBOL_GPL(driver_find_device);
+
+/**
  *	driver_create_file - create sysfs file for driver.
  *	@drv:	driver.
  *	@attr:	driver attribute descriptor.
diff --git a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -80,6 +80,8 @@ extern struct bus_type * find_bus(char *
 
 int bus_for_each_dev(struct bus_type * bus, struct device * start, void * data,
 		     int (*fn)(struct device *, void *));
+struct device * bus_find_device(struct bus_type *bus, struct device *start,
+				void *data, int (*match)(struct device *, void *));
 
 int bus_for_each_drv(struct bus_type * bus, struct device_driver * start, 
 		     void * data, int (*fn)(struct device_driver *, void *));
@@ -142,6 +144,9 @@ extern void driver_remove_file(struct de
 
 extern int driver_for_each_device(struct device_driver * drv, struct device * start,
 				  void * data, int (*fn)(struct device *, void *));
+struct device * driver_find_device(struct device_driver *drv,
+				   struct device *start, void *data,
+				   int (*match)(struct device *, void *));
 
 
 /*

