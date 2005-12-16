Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751216AbVLPAaS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbVLPAaS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 19:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbVLPAaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 19:30:18 -0500
Received: from s0003.shadowconnect.net ([213.239.201.226]:708 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S1751216AbVLPAaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 19:30:16 -0500
Message-ID: <43A20A94.4060708@shadowconnect.com>
Date: Fri, 16 Dec 2005 01:30:12 +0100
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Thunderbird 1.5 (Windows/20051025)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/7] I2O: Remove wrong I2O device class
Content-Type: multipart/mixed;
 boundary="------------000004080706030108040408"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000004080706030108040408
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Changes:
--------
- Removed wrong I2O device class, which was only needed to add sysfs
   attributes.

Signed-off-by: Markus Lidel <Markus.Lidel@shadowconnect.com>

--------------000004080706030108040408
Content-Type: text/x-patch;
 name="i2o-class-remove.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2o-class-remove.patch"

Index: linux-2.6/drivers/message/i2o/device.c
===================================================================
--- linux-2.6.orig/drivers/message/i2o/device.c
+++ linux-2.6/drivers/message/i2o/device.c
@@ -142,8 +142,9 @@ static void i2o_device_release(struct de
 
 
 /**
- *	i2o_device_class_show_class_id - Displays class id of I2O device
- *	@cd: class device of which the class id should be displayed
+ *	i2o_device_show_class_id - Displays class id of I2O device
+ *	@dev: device of which the class id should be displayed
+ *	@attr: pointer to device attribute
  *	@buf: buffer into which the class id should be printed
  *
  *	Returns the number of bytes which are printed into the buffer.
@@ -159,15 +160,15 @@ static ssize_t i2o_device_show_class_id(
 }
 
 /**
- *	i2o_device_class_show_tid - Displays TID of I2O device
- *	@cd: class device of which the TID should be displayed
- *	@buf: buffer into which the class id should be printed
+ *	i2o_device_show_tid - Displays TID of I2O device
+ *	@dev: device of which the TID should be displayed
+ *	@attr: pointer to device attribute
+ *	@buf: buffer into which the TID should be printed
  *
  *	Returns the number of bytes which are printed into the buffer.
  */
 static ssize_t i2o_device_show_tid(struct device *dev,
-				   struct device_attribute *attr,
-				   char *buf)
+				   struct device_attribute *attr, char *buf)
 {
 	struct i2o_device *i2o_dev = to_i2o_device(dev);
 
@@ -209,66 +210,6 @@ static struct i2o_device *i2o_device_all
 }
 
 /**
- *	i2o_setup_sysfs_links - Adds attributes to the I2O device
- *	@cd: I2O class device which is added to the I2O device class
- *
- *	This function get called when a I2O device is added to the class. It
- *	creates the attributes for each device and creates user/parent symlink
- *	if necessary.
- *
- *	Returns 0 on success or negative error code on failure.
- */
-static void i2o_setup_sysfs_links(struct i2o_device *i2o_dev)
-{
-	struct i2o_controller *c = i2o_dev->iop;
-	struct i2o_device *tmp;
-
-	/* create user entries for this device */
-	tmp = i2o_iop_find_device(i2o_dev->iop, i2o_dev->lct_data.user_tid);
-	if (tmp && tmp != i2o_dev)
-		sysfs_create_link(&i2o_dev->device.kobj,
-				  &tmp->device.kobj, "user");
-
-	/* create user entries refering to this device */
-	list_for_each_entry(tmp, &c->devices, list)
-		if (tmp->lct_data.user_tid == i2o_dev->lct_data.tid &&
-		    tmp != i2o_dev)
-			sysfs_create_link(&tmp->device.kobj,
-					  &i2o_dev->device.kobj, "user");
-
-	/* create parent entries for this device */
-	tmp = i2o_iop_find_device(i2o_dev->iop, i2o_dev->lct_data.parent_tid);
-	if (tmp && tmp != i2o_dev)
-		sysfs_create_link(&i2o_dev->device.kobj,
-				  &tmp->device.kobj, "parent");
-
-	/* create parent entries refering to this device */
-	list_for_each_entry(tmp, &c->devices, list)
-		if (tmp->lct_data.parent_tid == i2o_dev->lct_data.tid &&
-		    tmp != i2o_dev)
-		sysfs_create_link(&tmp->device.kobj,
-				  &i2o_dev->device.kobj, "parent");
-}
-
-static void i2o_remove_sysfs_links(struct i2o_device *i2o_dev)
-{
-	struct i2o_controller *c = i2o_dev->iop;
-	struct i2o_device *tmp;
-
-	sysfs_remove_link(&i2o_dev->device.kobj, "parent");
-	sysfs_remove_link(&i2o_dev->device.kobj, "user");
-
-	list_for_each_entry(tmp, &c->devices, list) {
-		if (tmp->lct_data.parent_tid == i2o_dev->lct_data.tid)
-			sysfs_remove_link(&tmp->device.kobj, "parent");
-		if (tmp->lct_data.user_tid == i2o_dev->lct_data.tid)
-			sysfs_remove_link(&tmp->device.kobj, "user");
-	}
-}
-
-
-
-/**
  *	i2o_device_add - allocate a new I2O device and add it to the IOP
  *	@iop: I2O controller where the device is on
  *	@entry: LCT entry of the I2O device
@@ -282,33 +223,57 @@ static void i2o_remove_sysfs_links(struc
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
-	dev->iop = c;
+	i2o_dev->lct_data = *entry;
 
-	snprintf(dev->device.bus_id, BUS_ID_SIZE, "%d:%03x", c->unit,
-		 dev->lct_data.tid);
+	snprintf(i2o_dev->device.bus_id, BUS_ID_SIZE, "%d:%03x", c->unit,
+		 i2o_dev->lct_data.tid);
 
-	dev->device.parent = &c->device;
+	i2o_dev->iop = c;
+	i2o_dev->device.parent = &c->device;
 
-	device_register(&dev->device);
+	device_register(&i2o_dev->device);
 
-	list_add_tail(&dev->list, &c->devices);
+	list_add_tail(&i2o_dev->list, &c->devices);
 
-	i2o_setup_sysfs_links(dev);
+	/* create user entries for this device */
+	tmp = i2o_iop_find_device(i2o_dev->iop, i2o_dev->lct_data.user_tid);
+	if (tmp && (tmp != i2o_dev))
+		sysfs_create_link(&i2o_dev->device.kobj, &tmp->device.kobj,
+				  "user");
 
-	i2o_driver_notify_device_add_all(dev);
+	/* create user entries refering to this device */
+	list_for_each_entry(tmp, &c->devices, list)
+		if ((tmp->lct_data.user_tid == i2o_dev->lct_data.tid)
+		    && (tmp != i2o_dev))
+		    sysfs_create_link(&tmp->device.kobj,
+				      &i2o_dev->device.kobj, "user");
 
-	pr_debug("i2o: device %s added\n", dev->device.bus_id);
+	/* create parent entries for this device */
+	tmp = i2o_iop_find_device(i2o_dev->iop, i2o_dev->lct_data.parent_tid);
+	if (tmp && (tmp != i2o_dev))
+		sysfs_create_link(&i2o_dev->device.kobj, &tmp->device.kobj,
+				  "parent");
 
-	return dev;
+	/* create parent entries refering to this device */
+	list_for_each_entry(tmp, &c->devices, list)
+		if ((tmp->lct_data.parent_tid == i2o_dev->lct_data.tid)
+		    && (tmp != i2o_dev))
+			sysfs_create_link(&tmp->device.kobj,
+					  &i2o_dev->device.kobj, "parent");
+
+	i2o_driver_notify_device_add_all(i2o_dev);
+
+	pr_debug("i2o: device %s added\n", i2o_dev->device.bus_id);
+
+	return i2o_dev;
 }
 
 /**
@@ -321,9 +286,22 @@ static struct i2o_device *i2o_device_add
  */
 void i2o_device_remove(struct i2o_device *i2o_dev)
 {
+	struct i2o_device *tmp;
+	struct i2o_controller *c = i2o_dev->iop;
+
 	i2o_driver_notify_device_remove_all(i2o_dev);
-	i2o_remove_sysfs_links(i2o_dev);
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
 }
 
Index: linux-2.6/drivers/message/i2o/iop.c
===================================================================
--- linux-2.6.orig/drivers/message/i2o/iop.c
+++ linux-2.6/drivers/message/i2o/iop.c
@@ -806,7 +806,6 @@ void i2o_iop_remove(struct i2o_controlle
 	list_for_each_entry_safe(dev, tmp, &c->devices, list)
 	    i2o_device_remove(dev);
 
-	class_device_unregister(c->classdev);
 	device_del(&c->device);
 
 	/* Ask the IOP to switch to RESET state */
@@ -1050,9 +1049,6 @@ static void i2o_iop_release(struct devic
 	i2o_iop_free(c);
 };
 
-/* I2O controller class */
-static struct class *i2o_controller_class;
-
 /**
  *	i2o_iop_alloc - Allocate and initialize a i2o_controller struct
  *
@@ -1124,36 +1120,29 @@ int i2o_iop_add(struct i2o_controller *c
 		goto iop_reset;
 	}
 
-	c->classdev = class_device_create(i2o_controller_class, NULL, MKDEV(0,0),
-			&c->device, "iop%d", c->unit);
-	if (IS_ERR(c->classdev)) {
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
 
@@ -1163,9 +1152,6 @@ int i2o_iop_add(struct i2o_controller *c
 
 	return 0;
 
-      class_del:
-	class_device_unregister(c->classdev);
-
       device_del:
 	device_del(&c->device);
 
@@ -1225,14 +1211,8 @@ static int __init i2o_iop_init(void)
 
 	printk(KERN_INFO OSM_DESCRIPTION " v" OSM_VERSION "\n");
 
-	i2o_controller_class = class_create(THIS_MODULE, "i2o_controller");
-	if (IS_ERR(i2o_controller_class)) {
-		osm_err("can't register class i2o_controller\n");
-		goto exit;
-	}
-
 	if ((rc = i2o_driver_init()))
-		goto class_exit;
+		goto exit;
 
 	if ((rc = i2o_exec_init()))
 		goto driver_exit;
@@ -1248,9 +1228,6 @@ static int __init i2o_iop_init(void)
       driver_exit:
 	i2o_driver_exit();
 
-      class_exit:
-	class_destroy(i2o_controller_class);
-
       exit:
 	return rc;
 }
@@ -1265,7 +1242,6 @@ static void __exit i2o_iop_exit(void)
 	i2o_pci_exit();
 	i2o_exec_exit();
 	i2o_driver_exit();
-	class_destroy(i2o_controller_class);
 };
 
 module_init(i2o_iop_init);
Index: linux-2.6/include/linux/i2o.h
===================================================================
--- linux-2.6.orig/include/linux/i2o.h
+++ linux-2.6/include/linux/i2o.h
@@ -561,7 +561,6 @@ struct i2o_controller {
 	struct resource mem_resource;	/* Mem resource allocated to the IOP */
 
 	struct device device;
-	struct class_device *classdev;	/* I2O controller class device */
 	struct i2o_device *exec;	/* Executive */
 #if BITS_PER_LONG == 64
 	spinlock_t context_list_lock;	/* lock for context_list */
Index: linux-2.6/drivers/message/i2o/core.h
===================================================================
--- linux-2.6.orig/drivers/message/i2o/core.h
+++ linux-2.6/drivers/message/i2o/core.h
@@ -33,6 +33,8 @@ extern int __init i2o_pci_init(void);
 extern void __exit i2o_pci_exit(void);
 
 /* device */
+extern struct device_attribute i2o_device_attrs[];
+
 extern void i2o_device_remove(struct i2o_device *);
 extern int i2o_device_parse_lct(struct i2o_controller *);
 
Index: linux-2.6/drivers/message/i2o/driver.c
===================================================================
--- linux-2.6.orig/drivers/message/i2o/driver.c
+++ linux-2.6/drivers/message/i2o/driver.c
@@ -61,8 +61,6 @@ static int i2o_bus_match(struct device *
 };
 
 /* I2O bus type */
-extern struct device_attribute i2o_device_attrs[];
-
 struct bus_type i2o_bus_type = {
 	.name = "i2o",
 	.match = i2o_bus_match,

--------------000004080706030108040408--
