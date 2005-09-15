Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030383AbVIOGxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030383AbVIOGxp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 02:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030371AbVIOGvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 02:51:43 -0400
Received: from smtp109.sbc.mail.re2.yahoo.com ([68.142.229.96]:60538 "HELO
	smtp109.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S965196AbVIOGvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 02:51:39 -0400
Message-Id: <20050915064942.887401000.dtor_core@ameritech.net>
References: <20050915064552.836273000.dtor_core@ameritech.net>
Date: Thu, 15 Sep 2005 01:45:53 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@suse.de>,
Kay Sievers <kay.sievers@vrfy.org>,
Vojtech Pavlik <vojtech@suse.cz>,
Hannes Reinecke <hare@suse.de>
Subject: [patch 01/28] I2O: remove class interface
Content-Disposition: inline; filename=i2o-remove-class-interface.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

I2O: remove i2o_device_class_interface misuse

The intent of class interfaces was to provide different
'views' at the same object, not just run some code every
time a new class device is registered. Kill interface
structure, make class core register default attributes
and set up sysfs links right when registering class
devices.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/message/i2o/device.c |  255 ++++++++++++++++++++-----------------------
 1 files changed, 122 insertions(+), 133 deletions(-)

Index: work/drivers/message/i2o/device.c
===================================================================
--- work.orig/drivers/message/i2o/device.c
+++ work/drivers/message/i2o/device.c
@@ -45,10 +45,10 @@ static inline int i2o_device_issue_claim
 	writel(type, &msg->body[0]);
 
 	return i2o_msg_post_wait(dev->iop, m, 60);
-};
+}
 
 /**
- * 	i2o_device_claim - claim a device for use by an OSM
+ *	i2o_device_claim - claim a device for use by an OSM
  *	@dev: I2O device to claim
  *	@drv: I2O driver which wants to claim the device
  *
@@ -73,7 +73,7 @@ int i2o_device_claim(struct i2o_device *
 	up(&dev->lock);
 
 	return rc;
-};
+}
 
 /**
  *	i2o_device_claim_release - release a device that the OSM is using
@@ -119,7 +119,8 @@ int i2o_device_claim_release(struct i2o_
 	up(&dev->lock);
 
 	return rc;
-};
+}
+
 
 /**
  *	i2o_device_release - release the memory for a I2O device
@@ -135,39 +136,62 @@ static void i2o_device_release(struct de
 	pr_debug("i2o: device %s released\n", dev->bus_id);
 
 	kfree(i2o_dev);
-};
+}
 
 /**
- *	i2o_device_class_release - Remove I2O device attributes
+ *	i2o_device_class_release - I2O class device release function
  *	@cd: I2O class device which is added to the I2O device class
  *
- *	Removes attributes from the I2O device again. Also search each device
- *	on the controller for I2O devices which refert to this device as parent
- *	or user and remove this links also.
+ *	The function is just a stub - memory will be freed when
+ *	associated I2O device is released.
  */
 static void i2o_device_class_release(struct class_device *cd)
 {
-	struct i2o_device *i2o_dev, *tmp;
-	struct i2o_controller *c;
+	/* empty */
+}
 
-	i2o_dev = to_i2o_device(cd->dev);
-	c = i2o_dev->iop;
+/**
+ *	i2o_device_class_show_class_id - Displays class id of I2O device
+ *	@cd: class device of which the class id should be displayed
+ *	@buf: buffer into which the class id should be printed
+ *
+ *	Returns the number of bytes which are printed into the buffer.
+ */
+static ssize_t i2o_device_class_show_class_id(struct class_device *cd,
+					      char *buf)
+{
+	struct i2o_device *dev = to_i2o_device(cd->dev);
 
-	sysfs_remove_link(&i2o_dev->device.kobj, "parent");
-	sysfs_remove_link(&i2o_dev->device.kobj, "user");
+	sprintf(buf, "0x%03x\n", dev->lct_data.class_id);
+	return strlen(buf) + 1;
+}
 
-	list_for_each_entry(tmp, &c->devices, list) {
-		if (tmp->lct_data.parent_tid == i2o_dev->lct_data.tid)
-			sysfs_remove_link(&tmp->device.kobj, "parent");
-		if (tmp->lct_data.user_tid == i2o_dev->lct_data.tid)
-			sysfs_remove_link(&tmp->device.kobj, "user");
-	}
+/**
+ *	i2o_device_class_show_tid - Displays TID of I2O device
+ *	@cd: class device of which the TID should be displayed
+ *	@buf: buffer into which the class id should be printed
+ *
+ *	Returns the number of bytes which are printed into the buffer.
+ */
+static ssize_t i2o_device_class_show_tid(struct class_device *cd, char *buf)
+{
+	struct i2o_device *dev = to_i2o_device(cd->dev);
+
+	sprintf(buf, "0x%03x\n", dev->lct_data.tid);
+	return strlen(buf) + 1;
+}
+
+static struct class_device_attribute i2o_device_class_attrs[] = {
+	__ATTR(class_id, S_IRUGO, i2o_device_class_show_class_id, NULL),
+	__ATTR(tid, S_IRUGO, i2o_device_class_show_tid, NULL),
+	__ATTR_NULL
 };
 
 /* I2O device class */
 static struct class i2o_device_class = {
-	.name = "i2o_device",
-	.release = i2o_device_class_release
+	.name			= "i2o_device",
+	.release		= i2o_device_class_release,
+	.class_dev_attrs	= i2o_device_class_attrs,
 };
 
 /**
@@ -197,7 +221,67 @@ static struct i2o_device *i2o_device_all
 	dev->classdev.dev = &dev->device;
 
 	return dev;
-};
+}
+
+/**
+ *	i2o_setup_sysfs_links - Adds attributes to the I2O device
+ *	@cd: I2O class device which is added to the I2O device class
+ *
+ *	This function get called when a I2O device is added to the class. It
+ *	creates the attributes for each device and creates user/parent symlink
+ *	if necessary.
+ *
+ *	Returns 0 on success or negative error code on failure.
+ */
+static void i2o_setup_sysfs_links(struct i2o_device *i2o_dev)
+{
+	struct i2o_controller *c = i2o_dev->iop;
+	struct i2o_device *tmp;
+
+	/* create user entries for this device */
+	tmp = i2o_iop_find_device(i2o_dev->iop, i2o_dev->lct_data.user_tid);
+	if (tmp && tmp != i2o_dev)
+		sysfs_create_link(&i2o_dev->device.kobj,
+				  &tmp->device.kobj, "user");
+
+	/* create user entries refering to this device */
+	list_for_each_entry(tmp, &c->devices, list)
+		if (tmp->lct_data.user_tid == i2o_dev->lct_data.tid &&
+		    tmp != i2o_dev)
+			sysfs_create_link(&tmp->device.kobj,
+					  &i2o_dev->device.kobj, "user");
+
+	/* create parent entries for this device */
+	tmp = i2o_iop_find_device(i2o_dev->iop, i2o_dev->lct_data.parent_tid);
+	if (tmp && tmp != i2o_dev)
+		sysfs_create_link(&i2o_dev->device.kobj,
+				  &tmp->device.kobj, "parent");
+
+	/* create parent entries refering to this device */
+	list_for_each_entry(tmp, &c->devices, list)
+		if (tmp->lct_data.parent_tid == i2o_dev->lct_data.tid &&
+		    tmp != i2o_dev)
+		sysfs_create_link(&tmp->device.kobj,
+				  &i2o_dev->device.kobj, "parent");
+}
+
+static void i2o_remove_sysfs_links(struct i2o_device *i2o_dev)
+{
+	struct i2o_controller *c = i2o_dev->iop;
+	struct i2o_device *tmp;
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
+}
+
+
 
 /**
  *	i2o_device_add - allocate a new I2O device and add it to the IOP
@@ -222,6 +306,7 @@ static struct i2o_device *i2o_device_add
 	}
 
 	dev->lct_data = *entry;
+	dev->iop = c;
 
 	snprintf(dev->device.bus_id, BUS_ID_SIZE, "%d:%03x", c->unit,
 		 dev->lct_data.tid);
@@ -229,7 +314,6 @@ static struct i2o_device *i2o_device_add
 	snprintf(dev->classdev.class_id, BUS_ID_SIZE, "%d:%03x", c->unit,
 		 dev->lct_data.tid);
 
-	dev->iop = c;
 	dev->device.parent = &c->device;
 
 	device_register(&dev->device);
@@ -238,12 +322,14 @@ static struct i2o_device *i2o_device_add
 
 	class_device_register(&dev->classdev);
 
+	i2o_setup_sysfs_links(dev);
+
 	i2o_driver_notify_device_add_all(dev);
 
 	pr_debug("i2o: device %s added\n", dev->device.bus_id);
 
 	return dev;
-};
+}
 
 /**
  *	i2o_device_remove - remove an I2O device from the I2O core
@@ -256,10 +342,11 @@ static struct i2o_device *i2o_device_add
 void i2o_device_remove(struct i2o_device *i2o_dev)
 {
 	i2o_driver_notify_device_remove_all(i2o_dev);
+	i2o_remove_sysfs_links(i2o_dev);
 	class_device_unregister(&i2o_dev->classdev);
 	list_del(&i2o_dev->list);
 	device_unregister(&i2o_dev->device);
-};
+}
 
 /**
  *	i2o_device_parse_lct - Parse a previously fetched LCT and create devices
@@ -337,99 +424,8 @@ int i2o_device_parse_lct(struct i2o_cont
 	up(&c->lct_lock);
 
 	return 0;
-};
-
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
+}
 
-/* I2O device class interface */
-static struct class_interface i2o_device_class_interface = {
-	.class = &i2o_device_class,
-	.add = i2o_device_class_add
-};
 
 /*
  *	Run time support routines
@@ -553,11 +549,11 @@ int i2o_parm_field_get(struct i2o_device
 }
 
 /*
- * 	if oper == I2O_PARAMS_TABLE_GET, get from all rows
- * 		if fieldcount == -1 return all fields
+ *	if oper == I2O_PARAMS_TABLE_GET, get from all rows
+ *		if fieldcount == -1 return all fields
  *			ibuf and ibuflen are unused (use NULL, 0)
- * 		else return specific fields
- *  			ibuf contains fieldindexes
+ *		else return specific fields
+ *			ibuf contains fieldindexes
  *
  * 	if oper == I2O_PARAMS_LIST_GET, get from specific rows
  * 		if fieldcount == -1 return all fields
@@ -611,14 +607,8 @@ int i2o_parm_table_get(struct i2o_device
  */
 int i2o_device_init(void)
 {
-	int rc;
-
-	rc = class_register(&i2o_device_class);
-	if (rc)
-		return rc;
-
-	return class_interface_register(&i2o_device_class_interface);
-};
+	return class_register(&i2o_device_class);
+}
 
 /**
  *	i2o_device_exit - I2O devices exit function
@@ -627,9 +617,8 @@ int i2o_device_init(void)
  */
 void i2o_device_exit(void)
 {
-	class_interface_register(&i2o_device_class_interface);
 	class_unregister(&i2o_device_class);
-};
+}
 
 EXPORT_SYMBOL(i2o_device_claim);
 EXPORT_SYMBOL(i2o_device_claim_release);

