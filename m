Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261762AbVFUQWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261762AbVFUQWk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 12:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262171AbVFUQWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 12:22:40 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:37612 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S261762AbVFUQWN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 12:22:13 -0400
Date: Tue, 21 Jun 2005 18:22:13 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, mochel@digitalimplant.org, gregkh@suse.de,
       cohuck@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 1/16] s390: klist bus_find_device & driver_find_device callback.
Message-ID: <20050621162213.GA6053@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 1/16] s390: klist bus_find_device & driver_find_device callback.

From: Cornelia Huck <cohuck@de.ibm.com>

Add bus_find_device() and driver_find_device() which allow a callback for each
device in the bus's resp. the driver's klist.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/base/bus.c     |   31 +++++++++++++++++++++++++++++++
 drivers/base/driver.c  |   34 ++++++++++++++++++++++++++++++++++
 include/linux/device.h |    7 +++++++
 3 files changed, 72 insertions(+)

diff -urpN linux-2.6/drivers/base/bus.c linux-2.6-patched/drivers/base/bus.c
--- linux-2.6/drivers/base/bus.c	2005-06-21 17:36:38.000000000 +0200
+++ linux-2.6-patched/drivers/base/bus.c	2005-06-21 17:36:45.000000000 +0200
@@ -177,6 +177,37 @@ int bus_for_each_dev(struct bus_type * b
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
+ * returns a pointer to a device that is 'found', as determined
+ * by the @match callback. The callback should return a bool - 0 if
+ * the device doesn't match and 1 if it does.
+ * The function will return if a device is found.
+ */
+
+struct device * bus_find_device(struct bus_type * bus, struct device * start,
+				void * data, int (*match)(struct device *, void *))
+{
+	struct klist_iter i;
+	struct device * dev;
+
+	if (!bus)
+		return NULL;
+
+	klist_iter_init_node(&bus->klist_devices, &i,
+			     (start ? &start->knode_bus : NULL));
+	while ((dev = next_device(&i)))
+		if (match(dev, data))
+			break;
+	klist_iter_exit(&i);
+	return dev;
+}
 
 
 static struct device_driver * next_driver(struct klist_iter * i)
diff -urpN linux-2.6/drivers/base/driver.c linux-2.6-patched/drivers/base/driver.c
--- linux-2.6/drivers/base/driver.c	2005-06-21 17:36:38.000000000 +0200
+++ linux-2.6-patched/drivers/base/driver.c	2005-06-21 17:36:45.000000000 +0200
@@ -56,6 +56,40 @@ EXPORT_SYMBOL_GPL(driver_for_each_device
 
 
 /**
+ * driver_find_device - device iterator for locating a particular device.
+ * @driver: The device's driver
+ * @start: Device to begin with
+ * @data: Data to pass to match function
+ * @match: Callback function to check device
+ *
+ * This is similar to the driver_for_each_device() function above, but it
+ * returns a pointer to a device that is 'found', as determined
+ * by the @match callback. The callback should return a bool - 0 if
+ * the device doesn't match and 1 if it does.
+ * The function will return if a device is found.
+ */
+
+struct device * driver_find_device(struct device_driver *drv,
+				   struct device * start, void * data,
+				   int (*match)(struct device *, void *))
+{
+	struct klist_iter i;
+	struct device * dev;
+
+	if (!drv)
+		return NULL;
+
+	klist_iter_init_node(&drv->klist_devices, &i,
+			     (start ? &start->knode_driver : NULL));
+	while ((dev = next_device(&i)))
+		if (match(dev, data))
+			break;
+	klist_iter_exit(&i);
+	return dev;
+}
+
+
+/**
  *	driver_create_file - create sysfs file for driver.
  *	@drv:	driver.
  *	@attr:	driver attribute descriptor.
diff -urpN linux-2.6/include/linux/device.h linux-2.6-patched/include/linux/device.h
--- linux-2.6/include/linux/device.h	2005-06-21 17:36:39.000000000 +0200
+++ linux-2.6-patched/include/linux/device.h	2005-06-21 17:36:45.000000000 +0200
@@ -81,6 +81,9 @@ extern struct bus_type * find_bus(char *
 int bus_for_each_dev(struct bus_type * bus, struct device * start, void * data,
 		     int (*fn)(struct device *, void *));
 
+struct device *  bus_find_device(struct bus_type * bus, struct device * start,
+				 void * data, int (*match)(struct device *, void *));
+
 int bus_for_each_drv(struct bus_type * bus, struct device_driver * start, 
 		     void * data, int (*fn)(struct device_driver *, void *));
 
@@ -143,6 +146,10 @@ extern void driver_remove_file(struct de
 extern int driver_for_each_device(struct device_driver * drv, struct device * start,
 				  void * data, int (*fn)(struct device *, void *));
 
+struct device *  driver_find_device(struct device_driver * drv,
+				    struct device * start, void * data,
+				    int (*match)(struct device *, void *));
+
 
 /*
  * device classes
