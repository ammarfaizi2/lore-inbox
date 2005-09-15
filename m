Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030439AbVIOHJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030439AbVIOHJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 03:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030436AbVIOHJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 03:09:46 -0400
Received: from smtp106.sbc.mail.re2.yahoo.com ([68.142.229.99]:54129 "HELO
	smtp106.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030438AbVIOHEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 03:04:04 -0400
Message-Id: <20050915070302.068231000.dtor_core@ameritech.net>
References: <20050915070131.813650000.dtor_core@ameritech.net>
Date: Thu, 15 Sep 2005 02:01:33 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>,
       Kay Sievers <kay.sievers@vrfy.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Hannes Reinecke <hare@suse.de>
Subject: [patch 02/28] I2O: remove i2o_device_class
Content-Disposition: inline; filename=i2o-remove-class.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I2O: cleanup - remove i2o_device_class

I2O devices reside on their own bus so there should be no reason
to also have i2c_device class that mirros i2o bus.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/message/i2o/core.h   |    3 -
 drivers/message/i2o/device.c |   71 +++++++------------------------------------
 drivers/message/i2o/driver.c |    3 +
 drivers/message/i2o/iop.c    |   10 ------
 include/linux/i2o.h          |    2 -
 5 files changed, 17 insertions(+), 72 deletions(-)

Index: work/drivers/message/i2o/device.c
===================================================================
--- work.orig/drivers/message/i2o/device.c
+++ work/drivers/message/i2o/device.c
@@ -138,17 +138,6 @@ static void i2o_device_release(struct de
 	kfree(i2o_dev);
 }
 
-/**
- *	i2o_device_class_release - I2O class device release function
- *	@cd: I2O class device which is added to the I2O device class
- *
- *	The function is just a stub - memory will be freed when
- *	associated I2O device is released.
- */
-static void i2o_device_class_release(struct class_device *cd)
-{
-	/* empty */
-}
 
 /**
  *	i2o_device_class_show_class_id - Displays class id of I2O device
@@ -157,12 +146,13 @@ static void i2o_device_class_release(str
  *
  *	Returns the number of bytes which are printed into the buffer.
  */
-static ssize_t i2o_device_class_show_class_id(struct class_device *cd,
-					      char *buf)
+static ssize_t i2o_device_show_class_id(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
 {
-	struct i2o_device *dev = to_i2o_device(cd->dev);
+	struct i2o_device *i2o_dev = to_i2o_device(dev);
 
-	sprintf(buf, "0x%03x\n", dev->lct_data.class_id);
+	sprintf(buf, "0x%03x\n", i2o_dev->lct_data.class_id);
 	return strlen(buf) + 1;
 }
 
@@ -173,27 +163,22 @@ static ssize_t i2o_device_class_show_cla
  *
  *	Returns the number of bytes which are printed into the buffer.
  */
-static ssize_t i2o_device_class_show_tid(struct class_device *cd, char *buf)
+static ssize_t i2o_device_show_tid(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buf)
 {
-	struct i2o_device *dev = to_i2o_device(cd->dev);
+	struct i2o_device *i2o_dev = to_i2o_device(dev);
 
-	sprintf(buf, "0x%03x\n", dev->lct_data.tid);
+	sprintf(buf, "0x%03x\n", i2o_dev->lct_data.tid);
 	return strlen(buf) + 1;
 }
 
-static struct class_device_attribute i2o_device_class_attrs[] = {
-	__ATTR(class_id, S_IRUGO, i2o_device_class_show_class_id, NULL),
-	__ATTR(tid, S_IRUGO, i2o_device_class_show_tid, NULL),
+struct device_attribute i2o_device_attrs[] = {
+	__ATTR(class_id, S_IRUGO, i2o_device_show_class_id, NULL),
+	__ATTR(tid, S_IRUGO, i2o_device_show_tid, NULL),
 	__ATTR_NULL
 };
 
-/* I2O device class */
-static struct class i2o_device_class = {
-	.name			= "i2o_device",
-	.release		= i2o_device_class_release,
-	.class_dev_attrs	= i2o_device_class_attrs,
-};
-
 /**
  *	i2o_device_alloc - Allocate a I2O device and initialize it
  *
@@ -217,8 +202,6 @@ static struct i2o_device *i2o_device_all
 
 	dev->device.bus = &i2o_bus_type;
 	dev->device.release = &i2o_device_release;
-	dev->classdev.class = &i2o_device_class;
-	dev->classdev.dev = &dev->device;
 
 	return dev;
 }
@@ -311,17 +294,12 @@ static struct i2o_device *i2o_device_add
 	snprintf(dev->device.bus_id, BUS_ID_SIZE, "%d:%03x", c->unit,
 		 dev->lct_data.tid);
 
-	snprintf(dev->classdev.class_id, BUS_ID_SIZE, "%d:%03x", c->unit,
-		 dev->lct_data.tid);
-
 	dev->device.parent = &c->device;
 
 	device_register(&dev->device);
 
 	list_add_tail(&dev->list, &c->devices);
 
-	class_device_register(&dev->classdev);
-
 	i2o_setup_sysfs_links(dev);
 
 	i2o_driver_notify_device_add_all(dev);
@@ -343,7 +321,6 @@ void i2o_device_remove(struct i2o_device
 {
 	i2o_driver_notify_device_remove_all(i2o_dev);
 	i2o_remove_sysfs_links(i2o_dev);
-	class_device_unregister(&i2o_dev->classdev);
 	list_del(&i2o_dev->list);
 	device_unregister(&i2o_dev->device);
 }
@@ -598,28 +575,6 @@ int i2o_parm_table_get(struct i2o_device
 	return size;
 }
 
-/**
- *	i2o_device_init - Initialize I2O devices
- *
- *	Registers the I2O device class.
- *
- *	Returns 0 on success or negative error code on failure.
- */
-int i2o_device_init(void)
-{
-	return class_register(&i2o_device_class);
-}
-
-/**
- *	i2o_device_exit - I2O devices exit function
- *
- *	Unregisters the I2O device class.
- */
-void i2o_device_exit(void)
-{
-	class_unregister(&i2o_device_class);
-}
-
 EXPORT_SYMBOL(i2o_device_claim);
 EXPORT_SYMBOL(i2o_device_claim_release);
 EXPORT_SYMBOL(i2o_parm_field_get);
Index: work/drivers/message/i2o/driver.c
===================================================================
--- work.orig/drivers/message/i2o/driver.c
+++ work/drivers/message/i2o/driver.c
@@ -58,9 +58,12 @@ static int i2o_bus_match(struct device *
 };
 
 /* I2O bus type */
+extern struct device_attribute i2o_device_attrs[];
+
 struct bus_type i2o_bus_type = {
 	.name = "i2o",
 	.match = i2o_bus_match,
+	.dev_attrs = i2o_device_attrs,
 };
 
 /**
Index: work/include/linux/i2o.h
===================================================================
--- work.orig/include/linux/i2o.h
+++ work/include/linux/i2o.h
@@ -66,8 +66,6 @@ struct i2o_device {
 	struct device device;
 
 	struct semaphore lock;	/* device lock */
-
-	struct class_device classdev;	/* i2o device class */
 };
 
 /*
Index: work/drivers/message/i2o/core.h
===================================================================
--- work.orig/drivers/message/i2o/core.h
+++ work/drivers/message/i2o/core.h
@@ -36,9 +36,6 @@ extern void __exit i2o_pci_exit(void);
 extern void i2o_device_remove(struct i2o_device *);
 extern int i2o_device_parse_lct(struct i2o_controller *);
 
-extern int i2o_device_init(void);
-extern void i2o_device_exit(void);
-
 /* IOP */
 extern struct i2o_controller *i2o_iop_alloc(void);
 extern void i2o_iop_free(struct i2o_controller *);
Index: work/drivers/message/i2o/iop.c
===================================================================
--- work.orig/drivers/message/i2o/iop.c
+++ work/drivers/message/i2o/iop.c
@@ -1246,13 +1246,9 @@ static int __init i2o_iop_init(void)
 
 	printk(KERN_INFO OSM_DESCRIPTION " v" OSM_VERSION "\n");
 
-	rc = i2o_device_init();
-	if (rc)
-		goto exit;
-
 	if ((rc = class_register(&i2o_controller_class))) {
 		osm_err("can't register class i2o_controller\n");
-		goto device_exit;
+		goto exit;
 	}
 
 	if ((rc = i2o_driver_init()))
@@ -1275,9 +1271,6 @@ static int __init i2o_iop_init(void)
       class_exit:
 	class_unregister(&i2o_controller_class);
 
-      device_exit:
-	i2o_device_exit();
-
       exit:
 	return rc;
 }
@@ -1293,7 +1286,6 @@ static void __exit i2o_iop_exit(void)
 	i2o_exec_exit();
 	i2o_driver_exit();
 	class_unregister(&i2o_controller_class);
-	i2o_device_exit();
 };
 
 module_init(i2o_iop_init);

