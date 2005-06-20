Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261675AbVFUCuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbVFUCuQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 22:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261912AbVFUCtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 22:49:40 -0400
Received: from mail.kroah.org ([69.55.234.183]:17380 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261675AbVFTW7k convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:40 -0400
Cc: mochel@digitalimplant.org
Subject: [PATCH] Add driver_for_each_device().
In-Reply-To: <11193083642637@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:24 -0700
Message-Id: <11193083643493@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Add driver_for_each_device().

Now there's an iterator for accessing each device bound to a driver.

Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

Index: linux-2.6.12-rc2/drivers/base/driver.c
===================================================================

---
commit fae3cd00255e3e51ffd59fedb1bdb91ec96be395
tree 59e56a65f4b01f496436bd9b0720737ce1937db4
parent 07e4a3e27fe414980ddc85a358e5a56abc48b363
author mochel@digitalimplant.org <mochel@digitalimplant.org> Mon, 21 Mar 2005 10:59:56 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:13 -0700

 drivers/base/driver.c  |   35 +++++++++++++++++++++++++++++++++++
 include/linux/device.h |    3 +++
 2 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/drivers/base/driver.c b/drivers/base/driver.c
--- a/drivers/base/driver.c
+++ b/drivers/base/driver.c
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
diff --git a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -136,6 +136,9 @@ struct driver_attribute driver_attr_##_n
 extern int driver_create_file(struct device_driver *, struct driver_attribute *);
 extern void driver_remove_file(struct device_driver *, struct driver_attribute *);
 
+extern int driver_for_each_device(struct device_driver * drv, struct device * start,
+				  void * data, int (*fn)(struct device *, void *));
+
 
 /*
  * device classes

