Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbVCUVBc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbVCUVBc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 16:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261912AbVCUU5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 15:57:38 -0500
Received: from digitalimplant.org ([64.62.235.95]:18060 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S261889AbVCUUsu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 15:48:50 -0500
Date: Mon, 21 Mar 2005 12:48:39 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: linux-kernel@vger.kernel.org
cc: greg@kroah.com
Subject: [3/9] [RFC] Steps to fixing the driver model locking
Message-ID: <Pine.LNX.4.50.0503211244040.20647-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet@1.2232, 2005-03-21 10:59:56-08:00, mochel@digitalimplant.org
  [driver core] Add driver_for_each_device().

  Now there's an iterator for accessing each device bound to a driver.


  Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>

diff -Nru a/drivers/base/driver.c b/drivers/base/driver.c
--- a/drivers/base/driver.c	2005-03-21 12:30:44 -08:00
+++ b/drivers/base/driver.c	2005-03-21 12:30:44 -08:00
@@ -18,6 +18,41 @@
 #define to_dev(node) container_of(node, struct device, driver_list)
 #define to_drv(obj) container_of(obj, struct device_driver, kobj)

+
+/**
+ *	driver_for_each_device - Iterator for devices bound to a driver.
+ *	@drv:	Driver we're iterating.
+ *	@data:	Data to pass to the callback.
+ *	@fn:	Function to call for each device.
+ *
+ *	Take the bus's rwsem and iterate over the @drv's list of devices,
+ *	calling @fn for each one.
+ */
+
+int driver_for_each_device(struct device_driver * drv, struct device * start,
+			   void * data, int (*fn)(struct device *, void *))
+{
+	struct list_head * head;
+	struct device * dev;
+	int error = 0;
+
+	down_read(&drv->bus->subsys.rwsem);
+	head = &drv->devices;
+	dev = list_prepare_entry(start, head, driver_list);
+	list_for_each_entry_continue(dev, head, driver_list) {
+		get_device(dev);
+		error = fn(dev, data);
+		put_device(dev);
+		if (error)
+			break;
+	}
+	up_read(&drv->bus->subsys.rwsem);
+	return error;
+}
+
+EXPORT_SYMBOL(driver_for_each_device);
+
+
 /**
  *	driver_create_file - create sysfs file for driver.
  *	@drv:	driver.
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	2005-03-21 12:30:44 -08:00
+++ b/include/linux/device.h	2005-03-21 12:30:44 -08:00
@@ -137,6 +137,9 @@
 extern int driver_create_file(struct device_driver *, struct driver_attribute *);
 extern void driver_remove_file(struct device_driver *, struct driver_attribute *);

+extern int driver_for_each_device(struct device_driver * drv, struct device * start,
+				  void * data, int (*fn)(struct device *, void *));
+

 /*
  * device classes
