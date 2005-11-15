Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751406AbVKOJbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbVKOJbV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 04:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbVKOJbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 04:31:21 -0500
Received: from s0003.shadowconnect.net ([213.239.201.226]:63695 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S1751406AbVKOJbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 04:31:20 -0500
Message-ID: <4379AAE5.2010508@shadowconnect.com>
Date: Tue, 15 Nov 2005 10:31:17 +0100
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/5] I2O: Remove wrong I2O device class
Content-Type: multipart/mixed;
 boundary="------------000806010703020904080209"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000806010703020904080209
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Changes:
--------
- Removed wrong I2O device class, which was only needed to add sysfs
   attributes.

Signed-off-by: Markus Lidel <Markus.Lidel@shadowconnect.com>

--------------000806010703020904080209
Content-Type: text/x-patch;
 name="i2o-class-remove.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2o-class-remove.patch"

Index: linux-2.6.14/drivers/message/i2o/core.h
===================================================================
--- linux-2.6.14.orig/drivers/message/i2o/core.h	2005-11-15 10:24:33.418854067 +0100
+++ linux-2.6.14/drivers/message/i2o/core.h	2005-11-15 10:24:38.059100401 +0100
@@ -36,9 +36,6 @@
 extern void i2o_device_remove(struct i2o_device *);
 extern int i2o_device_parse_lct(struct i2o_controller *);
 
-extern int i2o_device_init(void);
-extern void i2o_device_exit(void);
-
 /* IOP */
 extern struct i2o_controller *i2o_iop_alloc(void);
 extern void i2o_iop_free(struct i2o_controller *);
Index: linux-2.6.14/drivers/message/i2o/device.c
===================================================================
--- linux-2.6.14.orig/drivers/message/i2o/device.c	2005-11-15 10:24:37.343062390 +0100
+++ linux-2.6.14/drivers/message/i2o/device.c	2005-11-15 10:24:38.063100614 +0100
@@ -138,37 +138,43 @@
 };
 
 /**
- *	i2o_device_class_release - Remove I2O device attributes
- *	@cd: I2O class device which is added to the I2O device class
+ *	i2o_device_show_class_id - Displays class id of I2O device
+ *	@dev: device of which the class id should be displayed
+ *	@attr: pointer to device attribute
+ *	@buf: buffer into which the class id should be printed
  *
- *	Removes attributes from the I2O device again. Also search each device
- *	on the controller for I2O devices which refert to this device as parent
- *	or user and remove this links also.
+ *	Returns the number of bytes which are printed into the buffer.
  */
-static void i2o_device_class_release(struct class_device *cd)
+static ssize_t i2o_device_show_class_id(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
 {
-	struct i2o_device *i2o_dev, *tmp;
-	struct i2o_controller *c;
+	struct i2o_device *i2o_dev = to_i2o_device(dev);
 
-	i2o_dev = to_i2o_device(cd->dev);
-	c = i2o_dev->iop;
+	sprintf(buf, "0x%03x\n", i2o_dev->lct_data.class_id);
+	return strlen(buf) + 1;
+};
 
-	sysfs_remove_link(&i2o_dev->device.kobj, "parent");
-	sysfs_remove_link(&i2o_dev->device.kobj, "user");
+/**
+ *	i2o_device_show_tid - Displays TID of I2O device
+ *	@dev: device of which the TID should be displayed
+ *	@attr: pointer to device attribute
+ *	@buf: buffer into which the TID should be printed
+ *
+ *	Returns the number of bytes which are printed into the buffer.
+ */
+static ssize_t i2o_device_show_tid(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct i2o_device *i2o_dev = to_i2o_device(dev);
 
-	list_for_each_entry(tmp, &c->devices, list) {
-		if (tmp->lct_data.parent_tid == i2o_dev->lct_data.tid)
-			sysfs_remove_link(&tmp->device.kobj, "parent");
-		if (tmp->lct_data.user_tid == i2o_dev->lct_data.tid)
-			sysfs_remove_link(&tmp->device.kobj, "user");
-	}
+	sprintf(buf, "0x%03x\n", i2o_dev->lct_data.tid);
+	return strlen(buf) + 1;
 };
 
-/* I2O device class */
-static struct class i2o_device_class = {
-	.name = "i2o_device",
-	.release = i2o_device_class_release
-};
+/* I2O device class attributes */
+static DEVICE_ATTR(class_id, S_IRUGO, i2o_device_show_class_id, NULL);
+static DEVICE_ATTR(tid, S_IRUGO, i2o_device_show_tid, NULL);
 
 /**
  *	i2o_device_alloc - Allocate a I2O device and initialize it
@@ -193,8 +199,6 @@
 
 	dev->device.bus = &i2o_bus_type;
 	dev->device.release = &i2o_device_release;
-	dev->classdev.class = &i2o_device_class;
-	dev->classdev.dev = &dev->device;
 
 	return dev;
 };
@@ -213,36 +217,63 @@
 static struct i2o_device *i2o_device_add(struct i2o_controller *c,
 					 i2o_lct_entry * entry)
 {
-	struct i2o_device *dev;
+	struct i2o_device *i2o_dev, *tmp;
 
-	dev = i2o_device_alloc();
-	if (IS_ERR(dev)) {
+	i2o_dev = i2o_device_alloc();
+	if (IS_ERR(i2o_dev)) {
 		printk(KERN_ERR "i2o: unable to allocate i2o device\n");
-		return dev;
+		return i2o_dev;
 	}
 
-	dev->lct_data = *entry;
+	i2o_dev->lct_data = *entry;
 
-	snprintf(dev->device.bus_id, BUS_ID_SIZE, "%d:%03x", c->unit,
-		 dev->lct_data.tid);
+	snprintf(i2o_dev->device.bus_id, BUS_ID_SIZE, "%d:%03x", c->unit,
+		 i2o_dev->lct_data.tid);
 
-	snprintf(dev->classdev.class_id, BUS_ID_SIZE, "%d:%03x", c->unit,
-		 dev->lct_data.tid);
+	snprintf(i2o_dev->classdev.class_id, BUS_ID_SIZE, "%d:%03x", c->unit,
+		 i2o_dev->lct_data.tid);
 
-	dev->iop = c;
-	dev->device.parent = &c->device;
+	i2o_dev->iop = c;
+	i2o_dev->device.parent = &c->device;
 
-	device_register(&dev->device);
+	device_register(&i2o_dev->device);
 
-	list_add_tail(&dev->list, &c->devices);
+	list_add_tail(&i2o_dev->list, &c->devices);
 
-	class_device_register(&dev->classdev);
+	device_create_file(&i2o_dev->device, &dev_attr_class_id);
+	device_create_file(&i2o_dev->device, &dev_attr_tid);
 
-	i2o_driver_notify_device_add_all(dev);
+	/* create user entries for this device */
+	tmp = i2o_iop_find_device(i2o_dev->iop, i2o_dev->lct_data.user_tid);
+	if (tmp && (tmp != i2o_dev))
+		sysfs_create_link(&i2o_dev->device.kobj, &tmp->device.kobj,
+				  "user");
 
-	pr_debug("i2o: device %s added\n", dev->device.bus_id);
+	/* create user entries refering to this device */
+	list_for_each_entry(tmp, &c->devices, list)
+	    if ((tmp->lct_data.user_tid == i2o_dev->lct_data.tid)
+		&& (tmp != i2o_dev))
+		sysfs_create_link(&tmp->device.kobj,
+				  &i2o_dev->device.kobj, "user");
 
-	return dev;
+	/* create parent entries for this device */
+	tmp = i2o_iop_find_device(i2o_dev->iop, i2o_dev->lct_data.parent_tid);
+	if (tmp && (tmp != i2o_dev))
+		sysfs_create_link(&i2o_dev->device.kobj, &tmp->device.kobj,
+				  "parent");
+
+	/* create parent entries refering to this device */
+	list_for_each_entry(tmp, &c->devices, list)
+	    if ((tmp->lct_data.parent_tid == i2o_dev->lct_data.tid)
+		&& (tmp != i2o_dev))
+		sysfs_create_link(&tmp->device.kobj,
+				  &i2o_dev->device.kobj, "parent");
+
+	i2o_driver_notify_device_add_all(i2o_dev);
+
+	pr_debug("i2o: device %s added\n", i2o_dev->device.bus_id);
+
+	return i2o_dev;
 };
 
 /**
@@ -255,9 +286,22 @@
  */
 void i2o_device_remove(struct i2o_device *i2o_dev)
 {
+	struct i2o_device *tmp;
+	struct i2o_controller *c = i2o_dev->iop;
+
 	i2o_driver_notify_device_remove_all(i2o_dev);
-	class_device_unregister(&i2o_dev->classdev);
+
+	sysfs_remove_link(&i2o_dev->device.kobj, "parent");
+	sysfs_remove_link(&i2o_dev->device.kobj, "user");
+
+	list_for_each_entry(tmp, &c->devices, list) {
+		if (tmp->lct_data.parent_tid == i2o_dev->lct_data.tid)
+			sysfs_remove_link(&tmp->device.kobj, "parent");
+		if (tmp->lct_data.user_tid == i2o_dev->lct_data.tid)
+			sysfs_remove_link(&tmp->device.kobj, "user");
+	}
 	list_del(&i2o_dev->list);
+
 	device_unregister(&i2o_dev->device);
 };
 
@@ -367,98 +411,6 @@
 	return 0;
 };
 
-/**
- *	i2o_device_class_show_class_id - Displays class id of I2O device
- *	@cd: class device of which the class id should be displayed
- *	@buf: buffer into which the class id should be printed
- *
- *	Returns the number of bytes which are printed into the buffer.
- */
-static ssize_t i2o_device_class_show_class_id(struct class_device *cd,
-					      char *buf)
-{
-	struct i2o_device *dev = to_i2o_device(cd->dev);
-
-	sprintf(buf, "0x%03x\n", dev->lct_data.class_id);
-	return strlen(buf) + 1;
-};
-
-/**
- *	i2o_device_class_show_tid - Displays TID of I2O device
- *	@cd: class device of which the TID should be displayed
- *	@buf: buffer into which the class id should be printed
- *
- *	Returns the number of bytes which are printed into the buffer.
- */
-static ssize_t i2o_device_class_show_tid(struct class_device *cd, char *buf)
-{
-	struct i2o_device *dev = to_i2o_device(cd->dev);
-
-	sprintf(buf, "0x%03x\n", dev->lct_data.tid);
-	return strlen(buf) + 1;
-};
-
-/* I2O device class attributes */
-static CLASS_DEVICE_ATTR(class_id, S_IRUGO, i2o_device_class_show_class_id,
-			 NULL);
-static CLASS_DEVICE_ATTR(tid, S_IRUGO, i2o_device_class_show_tid, NULL);
-
-/**
- *	i2o_device_class_add - Adds attributes to the I2O device
- *	@cd: I2O class device which is added to the I2O device class
- *
- *	This function get called when a I2O device is added to the class. It
- *	creates the attributes for each device and creates user/parent symlink
- *	if necessary.
- *
- *	Returns 0 on success or negative error code on failure.
- */
-static int i2o_device_class_add(struct class_device *cd)
-{
-	struct i2o_device *i2o_dev, *tmp;
-	struct i2o_controller *c;
-
-	i2o_dev = to_i2o_device(cd->dev);
-	c = i2o_dev->iop;
-
-	class_device_create_file(cd, &class_device_attr_class_id);
-	class_device_create_file(cd, &class_device_attr_tid);
-
-	/* create user entries for this device */
-	tmp = i2o_iop_find_device(i2o_dev->iop, i2o_dev->lct_data.user_tid);
-	if (tmp && (tmp != i2o_dev))
-		sysfs_create_link(&i2o_dev->device.kobj, &tmp->device.kobj,
-				  "user");
-
-	/* create user entries refering to this device */
-	list_for_each_entry(tmp, &c->devices, list)
-	    if ((tmp->lct_data.user_tid == i2o_dev->lct_data.tid)
-		&& (tmp != i2o_dev))
-		sysfs_create_link(&tmp->device.kobj,
-				  &i2o_dev->device.kobj, "user");
-
-	/* create parent entries for this device */
-	tmp = i2o_iop_find_device(i2o_dev->iop, i2o_dev->lct_data.parent_tid);
-	if (tmp && (tmp != i2o_dev))
-		sysfs_create_link(&i2o_dev->device.kobj, &tmp->device.kobj,
-				  "parent");
-
-	/* create parent entries refering to this device */
-	list_for_each_entry(tmp, &c->devices, list)
-	    if ((tmp->lct_data.parent_tid == i2o_dev->lct_data.tid)
-		&& (tmp != i2o_dev))
-		sysfs_create_link(&tmp->device.kobj,
-				  &i2o_dev->device.kobj, "parent");
-
-	return 0;
-};
-
-/* I2O device class interface */
-static struct class_interface i2o_device_class_interface = {
-	.class = &i2o_device_class,
-	.add = i2o_device_class_add
-};
-
 /*
  *	Run time support routines
  */
@@ -595,35 +547,6 @@
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
-	int rc;
-
-	rc = class_register(&i2o_device_class);
-	if (rc)
-		return rc;
-
-	return class_interface_register(&i2o_device_class_interface);
-};
-
-/**
- *	i2o_device_exit - I2O devices exit function
- *
- *	Unregisters the I2O device class.
- */
-void i2o_device_exit(void)
-{
-	class_interface_register(&i2o_device_class_interface);
-	class_unregister(&i2o_device_class);
-};
-
 EXPORT_SYMBOL(i2o_device_claim);
 EXPORT_SYMBOL(i2o_device_claim_release);
 EXPORT_SYMBOL(i2o_parm_field_get);
Index: linux-2.6.14/drivers/message/i2o/iop.c
===================================================================
--- linux-2.6.14.orig/drivers/message/i2o/iop.c	2005-11-15 10:24:36.166999957 +0100
+++ linux-2.6.14/drivers/message/i2o/iop.c	2005-11-15 10:24:38.063100614 +0100
@@ -1051,11 +1051,6 @@
 	i2o_iop_free(c);
 };
 
-/* I2O controller class */
-static struct class i2o_controller_class = {
-	.name = "i2o_controller",
-};
-
 /**
  *	i2o_iop_alloc - Allocate and initialize a i2o_controller struct
  *
@@ -1095,14 +1090,10 @@
 	init_MUTEX(&c->lct_lock);
 
 	device_initialize(&c->device);
-	class_device_initialize(&c->classdev);
 
 	c->device.release = &i2o_iop_release;
-	c->classdev.class = &i2o_controller_class;
-	c->classdev.dev = &c->device;
 
 	snprintf(c->device.bus_id, BUS_ID_SIZE, "iop%d", c->unit);
-	snprintf(c->classdev.class_id, BUS_ID_SIZE, "iop%d", c->unit);
 
 #if BITS_PER_LONG == 64
 	spin_lock_init(&c->context_list_lock);
@@ -1131,34 +1122,29 @@
 		goto iop_reset;
 	}
 
-	if ((rc = class_device_add(&c->classdev))) {
-		osm_err("%s: could not add controller class\n", c->name);
-		goto device_del;
-	}
-
 	osm_info("%s: Activating I2O controller...\n", c->name);
 	osm_info("%s: This may take a few minutes if there are many devices\n",
 		 c->name);
 
 	if ((rc = i2o_iop_activate(c))) {
 		osm_err("%s: could not activate controller\n", c->name);
-		goto class_del;
+		goto device_del;
 	}
 
 	osm_debug("%s: building sys table...\n", c->name);
 
 	if ((rc = i2o_systab_build()))
-		goto class_del;
+		goto device_del;
 
 	osm_debug("%s: online controller...\n", c->name);
 
 	if ((rc = i2o_iop_online(c)))
-		goto class_del;
+		goto device_del;
 
 	osm_debug("%s: getting LCT...\n", c->name);
 
 	if ((rc = i2o_exec_lct_get(c)))
-		goto class_del;
+		goto device_del;
 
 	list_add(&c->list, &i2o_controllers);
 
@@ -1168,9 +1154,6 @@
 
 	return 0;
 
-      class_del:
-	class_device_del(&c->classdev);
-
       device_del:
 	device_del(&c->device);
 
@@ -1230,17 +1213,8 @@
 
 	printk(KERN_INFO OSM_DESCRIPTION " v" OSM_VERSION "\n");
 
-	rc = i2o_device_init();
-	if (rc)
-		goto exit;
-
-	if ((rc = class_register(&i2o_controller_class))) {
-		osm_err("can't register class i2o_controller\n");
-		goto device_exit;
-	}
-
 	if ((rc = i2o_driver_init()))
-		goto class_exit;
+		goto exit;
 
 	if ((rc = i2o_exec_init()))
 		goto driver_exit;
@@ -1256,12 +1230,6 @@
       driver_exit:
 	i2o_driver_exit();
 
-      class_exit:
-	class_unregister(&i2o_controller_class);
-
-      device_exit:
-	i2o_device_exit();
-
       exit:
 	return rc;
 }
@@ -1276,8 +1244,6 @@
 	i2o_pci_exit();
 	i2o_exec_exit();
 	i2o_driver_exit();
-	class_unregister(&i2o_controller_class);
-	i2o_device_exit();
 };
 
 module_init(i2o_iop_init);
Index: linux-2.6.14/include/linux/i2o.h
===================================================================
--- linux-2.6.14.orig/include/linux/i2o.h	2005-11-15 10:24:36.175000381 +0100
+++ linux-2.6.14/include/linux/i2o.h	2005-11-15 10:24:38.067100826 +0100
@@ -559,7 +559,6 @@
 	struct resource mem_resource;	/* Mem resource allocated to the IOP */
 
 	struct device device;
-	struct class_device classdev;	/* I2O controller class */
 	struct i2o_device *exec;	/* Executive */
 #if BITS_PER_LONG == 64
 	spinlock_t context_list_lock;	/* lock for context_list */

--------------000806010703020904080209--
