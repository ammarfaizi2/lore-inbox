Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965156AbVJ1Gn4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965156AbVJ1Gn4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 02:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965121AbVJ1GbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 02:31:10 -0400
Received: from mail.kroah.org ([69.55.234.183]:22250 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965110AbVJ1GbF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 02:31:05 -0400
Cc: dtor_core@ameritech.net
Subject: [PATCH] I2O: remove i2o_device_class
In-Reply-To: <1130481023423@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 27 Oct 2005 23:30:23 -0700
Message-Id: <11304810231493@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2O: remove i2o_device_class

I2O: cleanup - remove i2o_device_class

I2O devices reside on their own bus so there should be no reason
to also have i2c_device class that mirros i2o bus.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit b02f028de21efe6ba60d1896462a219f1356ea34
tree b1ea0338d95ff9cdf7861d58b3fb26d4d79cc4a3
parent 3d7eba1bed51352c3bd68b4e507c021ad7db928a
author Dmitry Torokhov <dtor_core@ameritech.net> Thu, 29 Sep 2005 00:40:07 -0500
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 27 Oct 2005 22:48:00 -0700

 drivers/message/i2o/core.h   |    3 --
 drivers/message/i2o/device.c |   71 ++++++++----------------------------------
 drivers/message/i2o/driver.c |    3 ++
 drivers/message/i2o/iop.c    |   10 +-----
 include/linux/i2o.h          |    2 -
 5 files changed, 17 insertions(+), 72 deletions(-)

diff --git a/drivers/message/i2o/core.h b/drivers/message/i2o/core.h
index c5bcfd7..9eefedb 100644
--- a/drivers/message/i2o/core.h
+++ b/drivers/message/i2o/core.h
@@ -36,9 +36,6 @@ extern void __exit i2o_pci_exit(void);
 extern void i2o_device_remove(struct i2o_device *);
 extern int i2o_device_parse_lct(struct i2o_controller *);
 
-extern int i2o_device_init(void);
-extern void i2o_device_exit(void);
-
 /* IOP */
 extern struct i2o_controller *i2o_iop_alloc(void);
 extern void i2o_iop_free(struct i2o_controller *);
diff --git a/drivers/message/i2o/device.c b/drivers/message/i2o/device.c
index 551d582..d987996 100644
--- a/drivers/message/i2o/device.c
+++ b/drivers/message/i2o/device.c
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
diff --git a/drivers/message/i2o/driver.c b/drivers/message/i2o/driver.c
index 739bfde..0079a4b 100644
--- a/drivers/message/i2o/driver.c
+++ b/drivers/message/i2o/driver.c
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
diff --git a/drivers/message/i2o/iop.c b/drivers/message/i2o/iop.c
index 15deb45..176fb57 100644
--- a/drivers/message/i2o/iop.c
+++ b/drivers/message/i2o/iop.c
@@ -1243,14 +1243,10 @@ static int __init i2o_iop_init(void)
 
 	printk(KERN_INFO OSM_DESCRIPTION " v" OSM_VERSION "\n");
 
-	rc = i2o_device_init();
-	if (rc)
-		goto exit;
-
 	i2o_controller_class = class_create(THIS_MODULE, "i2o_controller");
 	if (IS_ERR(i2o_controller_class)) {
 		osm_err("can't register class i2o_controller\n");
-		goto device_exit;
+		goto exit;
 	}
 
 	if ((rc = i2o_driver_init()))
@@ -1273,9 +1269,6 @@ static int __init i2o_iop_init(void)
       class_exit:
 	class_destroy(i2o_controller_class);
 
-      device_exit:
-	i2o_device_exit();
-
       exit:
 	return rc;
 }
@@ -1291,7 +1284,6 @@ static void __exit i2o_iop_exit(void)
 	i2o_exec_exit();
 	i2o_driver_exit();
 	class_destroy(i2o_controller_class);
-	i2o_device_exit();
 };
 
 module_init(i2o_iop_init);
diff --git a/include/linux/i2o.h b/include/linux/i2o.h
index 694ea29..84db8f6 100644
--- a/include/linux/i2o.h
+++ b/include/linux/i2o.h
@@ -66,8 +66,6 @@ struct i2o_device {
 	struct device device;
 
 	struct semaphore lock;	/* device lock */
-
-	struct class_device classdev;	/* i2o device class */
 };
 
 /*

