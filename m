Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbVKTGt3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbVKTGt3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 01:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbVKTGsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 01:48:53 -0500
Received: from smtp113.sbc.mail.re2.yahoo.com ([68.142.229.92]:44425 "HELO
	smtp113.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750762AbVKTGrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 01:47:13 -0500
Message-Id: <20051120064420.617555000.dtor_core@ameritech.net>
References: <20051120063611.269343000.dtor_core@ameritech.net>
Date: Sun, 20 Nov 2005 01:36:22 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [git pull 11/14] Handle failures in input_register_device()
Content-Disposition: inline; filename=input-device-registration-cleanup.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: handle failures in input_register_device()

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/input.c |   63 ++++++++++++++++++++++++++++----------------------
 1 files changed, 36 insertions(+), 27 deletions(-)

Index: work/drivers/input/input.c
===================================================================
--- work.orig/drivers/input/input.c
+++ work/drivers/input/input.c
@@ -536,7 +536,7 @@ static struct attribute *input_dev_attrs
 	NULL
 };
 
-static struct attribute_group input_dev_group = {
+static struct attribute_group input_dev_attr_group = {
 	.attrs	= input_dev_attrs,
 };
 
@@ -717,35 +717,14 @@ struct input_dev *input_allocate_device(
 	return dev;
 }
 
-static void input_register_classdevice(struct input_dev *dev)
-{
-	static atomic_t input_no = ATOMIC_INIT(0);
-	const char *path;
-
-	__module_get(THIS_MODULE);
-
-	dev->dev = dev->cdev.dev;
-
-	snprintf(dev->cdev.class_id, sizeof(dev->cdev.class_id),
-		 "input%ld", (unsigned long) atomic_inc_return(&input_no) - 1);
-
-	path = kobject_get_path(&dev->cdev.class->subsys.kset.kobj, GFP_KERNEL);
-	printk(KERN_INFO "input: %s as %s/%s\n",
-		dev->name ? dev->name : "Unspecified device",
-		path ? path : "", dev->cdev.class_id);
-	kfree(path);
-
-	class_device_add(&dev->cdev);
-	sysfs_create_group(&dev->cdev.kobj, &input_dev_group);
-	sysfs_create_group(&dev->cdev.kobj, &input_dev_id_attr_group);
-	sysfs_create_group(&dev->cdev.kobj, &input_dev_caps_attr_group);
-}
-
 int input_register_device(struct input_dev *dev)
 {
+	static atomic_t input_no = ATOMIC_INIT(0);
 	struct input_handle *handle;
 	struct input_handler *handler;
 	struct input_device_id *id;
+	const char *path;
+	int error;
 
 	if (!dev->dynalloc) {
 		printk(KERN_WARNING "input: device %s is statically allocated, will not register\n"
@@ -773,7 +752,32 @@ int input_register_device(struct input_d
 	INIT_LIST_HEAD(&dev->h_list);
 	list_add_tail(&dev->node, &input_dev_list);
 
-	input_register_classdevice(dev);
+	dev->cdev.class = &input_class;
+	snprintf(dev->cdev.class_id, sizeof(dev->cdev.class_id),
+		 "input%ld", (unsigned long) atomic_inc_return(&input_no) - 1);
+
+	error = class_device_add(&dev->cdev);
+	if (error)
+		return error;
+
+	error = sysfs_create_group(&dev->cdev.kobj, &input_dev_attr_group);
+	if (error)
+		goto fail1;
+
+	error = sysfs_create_group(&dev->cdev.kobj, &input_dev_id_attr_group);
+	if (error)
+		goto fail2;
+
+	error = sysfs_create_group(&dev->cdev.kobj, &input_dev_caps_attr_group);
+	if (error)
+		goto fail3;
+
+	__module_get(THIS_MODULE);
+
+	path = kobject_get_path(&dev->cdev.kobj, GFP_KERNEL);
+	printk(KERN_INFO "input: %s as %s\n",
+		dev->name ? dev->name : "Unspecified device", path ? path : "N/A");
+	kfree(path);
 
 	list_for_each_entry(handler, &input_handler_list, node)
 		if (!handler->blacklist || !input_match_device(handler->blacklist, dev))
@@ -784,6 +788,11 @@ int input_register_device(struct input_d
 	input_wakeup_procfs_readers();
 
 	return 0;
+
+ fail3:	sysfs_remove_group(&dev->cdev.kobj, &input_dev_id_attr_group);
+ fail2:	sysfs_remove_group(&dev->cdev.kobj, &input_dev_attr_group);
+ fail1:	class_device_del(&dev->cdev);
+	return error;
 }
 
 void input_unregister_device(struct input_dev *dev)
@@ -805,7 +814,7 @@ void input_unregister_device(struct inpu
 
 	sysfs_remove_group(&dev->cdev.kobj, &input_dev_caps_attr_group);
 	sysfs_remove_group(&dev->cdev.kobj, &input_dev_id_attr_group);
-	sysfs_remove_group(&dev->cdev.kobj, &input_dev_group);
+	sysfs_remove_group(&dev->cdev.kobj, &input_dev_attr_group);
 	class_device_unregister(&dev->cdev);
 
 	input_wakeup_procfs_readers();

