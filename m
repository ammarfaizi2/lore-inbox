Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261510AbVCORMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261510AbVCORMM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 12:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261558AbVCORMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 12:12:12 -0500
Received: from mail.kroah.org ([69.55.234.183]:49607 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261510AbVCORL2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 12:11:28 -0500
Date: Tue, 15 Mar 2005 09:09:35 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Cc: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [RFC] Changes to the driver model class code.
Message-ID: <20050315170935.GB25475@kroah.com>
References: <20050315170834.GA25475@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050315170834.GA25475@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

patch 1 of 4

 Subject: CLASS: move a "simple" class logic into the class core.

One step on improving the class api so that it can not be used incorrectly.
This also fixes the module owner issue with the dev files that happened when
the devt logic moved to the class core.

Based on a patch originally written by Kay Sievers <kay.sievers@vrfy.org>

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

diff -Nru a/drivers/base/class.c b/drivers/base/class.c
--- a/drivers/base/class.c	2005-03-15 08:52:00 -08:00
+++ b/drivers/base/class.c	2005-03-15 08:52:00 -08:00
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/string.h>
 #include <linux/kdev_t.h>
+#include <linux/err.h>
 #include "base.h"
 
 #define to_class_attr(_attr) container_of(_attr, struct class_attribute, attr)
@@ -162,6 +163,51 @@
 	subsystem_unregister(&cls->subsys);
 }
 
+static void class_create_release(struct class *cls)
+{
+	kfree(cls);
+}
+
+static void class_device_create_release(struct class_device *class_dev)
+{
+	kfree(class_dev);
+}
+
+struct class *class_create(struct module *owner, char *name)
+{
+	struct class *cls;
+	int retval;
+
+	cls = kmalloc(sizeof(struct class), GFP_KERNEL);
+	if (!cls) {
+		retval = -ENOMEM;
+		goto error;
+	}
+	memset(cls, 0x00, sizeof(struct class));
+
+	cls->name = name;
+	cls->owner = owner;
+	cls->class_release = class_create_release;
+	cls->release = class_device_create_release;
+
+	retval = class_register(cls);
+	if (retval)
+		goto error;
+
+	return cls;
+
+error:
+	kfree(cls);
+	return ERR_PTR(retval);
+}
+
+void class_destroy(struct class *cls)
+{
+	if ((cls == NULL) || (IS_ERR(cls)))
+		return;
+
+	class_unregister(cls);
+}
 
 /* Class Device Stuff */
 
@@ -375,7 +421,6 @@
 {
 	return print_dev_t(buf, class_dev->devt);
 }
-static CLASS_DEVICE_ATTR(dev, S_IRUGO, show_dev, NULL);
 
 void class_device_initialize(struct class_device *class_dev)
 {
@@ -412,7 +457,31 @@
 	if ((error = kobject_add(&class_dev->kobj)))
 		goto register_done;
 
-	/* now take care of our own registration */
+	/* add the needed attributes to this device */
+	if (MAJOR(class_dev->devt)) {
+		struct class_device_attribute *attr;
+		attr = kmalloc(sizeof(*attr), GFP_KERNEL);
+		if (!attr) {
+			error = -ENOMEM;
+			kobject_del(&class_dev->kobj);
+			goto register_done;
+		}
+		memset(attr, sizeof(*attr), 0x00);
+		attr->attr.name = "dev";
+		attr->attr.mode = S_IRUGO;
+		attr->attr.owner = parent->owner;
+		attr->show = show_dev;
+		attr->store = NULL;
+		class_device_create_file(class_dev, attr);
+		class_dev->devt_attr = attr;
+	}
+
+	class_device_add_attrs(class_dev);
+	if (class_dev->dev)
+		sysfs_create_link(&class_dev->kobj,
+				  &class_dev->dev->kobj, "device");
+
+	/* notify any interfaces this device is now here */
 	if (parent) {
 		down(&parent->sem);
 		list_add_tail(&class_dev->node, &parent->children);
@@ -422,14 +491,6 @@
 		up(&parent->sem);
 	}
 
-	if (MAJOR(class_dev->devt))
-		class_device_create_file(class_dev, &class_device_attr_dev);
-
-	class_device_add_attrs(class_dev);
-	if (class_dev->dev)
-		sysfs_create_link(&class_dev->kobj,
-				  &class_dev->dev->kobj, "device");
-
  register_done:
 	if (error && parent)
 		class_put(parent);
@@ -443,6 +504,41 @@
 	return class_device_add(class_dev);
 }
 
+struct class_device *class_device_create(struct class *cls, dev_t devt,
+					 struct device *device, char *fmt, ...)
+{
+	va_list args;
+	struct class_device *class_dev = NULL;
+	int retval = -ENODEV;
+
+	if (cls == NULL || IS_ERR(cls))
+		goto error;
+
+	class_dev = kmalloc(sizeof(struct class_device), GFP_KERNEL);
+	if (!class_dev) {
+		retval = -ENOMEM;
+		goto error;
+	}
+	memset(class_dev, 0x00, sizeof(struct class_device));
+
+	class_dev->devt = devt;
+	class_dev->dev = device;
+	class_dev->class = cls;
+
+	va_start(args, fmt);
+	vsnprintf(class_dev->class_id, BUS_ID_SIZE, fmt, args);
+	va_end(args);
+	retval = class_device_register(class_dev);
+	if (retval)
+		goto error;
+
+	return class_dev;
+
+error:
+	kfree(class_dev);
+	return ERR_PTR(retval);
+}
+
 void class_device_del(struct class_device *class_dev)
 {
 	struct class * parent = class_dev->class;
@@ -459,6 +555,11 @@
 
 	if (class_dev->dev)
 		sysfs_remove_link(&class_dev->kobj, "device");
+	if (class_dev->devt_attr) {
+		class_device_remove_file(class_dev, class_dev->devt_attr);
+		kfree(class_dev->devt_attr);
+		class_dev->devt_attr = NULL;
+	}
 	class_device_remove_attrs(class_dev);
 
 	kobject_del(&class_dev->kobj);
@@ -475,6 +576,24 @@
 	class_device_put(class_dev);
 }
 
+void class_device_destroy(struct class *cls, dev_t devt)
+{
+	struct class_device *class_dev = NULL;
+	struct class_device *class_dev_tmp;
+
+	down(&cls->sem);
+	list_for_each_entry(class_dev_tmp, &cls->children, node) {
+		if (class_dev_tmp->devt == devt) {
+			class_dev = class_dev_tmp;
+			break;
+		}
+	}
+	up(&cls->sem);
+
+	if (class_dev)
+		class_device_unregister(class_dev);
+}
+
 int class_device_rename(struct class_device *class_dev, char *new_name)
 {
 	int error = 0;
@@ -574,6 +693,8 @@
 EXPORT_SYMBOL_GPL(class_unregister);
 EXPORT_SYMBOL_GPL(class_get);
 EXPORT_SYMBOL_GPL(class_put);
+EXPORT_SYMBOL_GPL(class_create);
+EXPORT_SYMBOL_GPL(class_destroy);
 
 EXPORT_SYMBOL_GPL(class_device_register);
 EXPORT_SYMBOL_GPL(class_device_unregister);
@@ -582,6 +703,8 @@
 EXPORT_SYMBOL_GPL(class_device_del);
 EXPORT_SYMBOL_GPL(class_device_get);
 EXPORT_SYMBOL_GPL(class_device_put);
+EXPORT_SYMBOL_GPL(class_device_create);
+EXPORT_SYMBOL_GPL(class_device_destroy);
 EXPORT_SYMBOL_GPL(class_device_create_file);
 EXPORT_SYMBOL_GPL(class_device_remove_file);
 EXPORT_SYMBOL_GPL(class_device_create_bin_file);
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	2005-03-15 08:52:00 -08:00
+++ b/include/linux/device.h	2005-03-15 08:52:00 -08:00
@@ -143,6 +143,7 @@
  */
 struct class {
 	char			* name;
+	struct module		* owner;
 
 	struct subsystem	subsys;
 	struct list_head	children;
@@ -185,6 +186,7 @@
 	struct kobject		kobj;
 	struct class		* class;	/* required */
 	dev_t			devt;		/* dev_t, creates the sysfs "dev" */
+	struct class_device_attribute *devt_attr;
 	struct device		* dev;		/* not necessary, but nice to have */
 	void			* class_data;	/* class-specific data */
 
@@ -244,6 +246,12 @@
 
 extern int class_interface_register(struct class_interface *);
 extern void class_interface_unregister(struct class_interface *);
+
+extern struct class *class_create(struct module *owner, char *name);
+extern void class_destroy(struct class *cls);
+extern struct class_device *class_device_create(struct class *cls, dev_t devt,
+						struct device *device, char *fmt, ...);
+extern void class_device_destroy(struct class *cls, dev_t devt);
 
 /* interface for class simple stuff */
 extern struct class_simple *class_simple_create(struct module *owner, char *name);
