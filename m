Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262765AbUATBSi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 20:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264934AbUATBQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 20:16:50 -0500
Received: from mail.kroah.org ([65.200.24.183]:24521 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265328AbUATBMf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 20:12:35 -0500
Subject: Re: [PATCH] Driver Core update and fixes for 2.6.1
In-Reply-To: <1074561159715@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 19 Jan 2004 17:12:39 -0800
Message-Id: <10745611592235@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1497, 2004/01/19 16:33:14-08:00, greg@kroah.com

[PATCH] Driver Core: add class_simple support

This patch adds a struct class_simple which can be used to create
"simple" class support for subsystems.

It also adds a class_release() callback for struct class, as it is
needed to properly handle the reference counting logic.


 drivers/base/Makefile       |    2 
 drivers/base/class.c        |   14 +++
 drivers/base/class_simple.c |  201 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/device.h      |    9 +
 4 files changed, 225 insertions(+), 1 deletion(-)


diff -Nru a/drivers/base/Makefile b/drivers/base/Makefile
--- a/drivers/base/Makefile	Mon Jan 19 17:05:14 2004
+++ b/drivers/base/Makefile	Mon Jan 19 17:05:14 2004
@@ -1,7 +1,7 @@
 # Makefile for the Linux device tree
 
 obj-y			:= core.o sys.o interface.o bus.o \
-			   driver.o class.o platform.o \
+			   driver.o class.o class_simple.o platform.o \
 			   cpu.o firmware.o init.o map.o
 obj-y			+= power/
 obj-$(CONFIG_FW_LOADER)	+= firmware_class.o
diff -Nru a/drivers/base/class.c b/drivers/base/class.c
--- a/drivers/base/class.c	Mon Jan 19 17:05:14 2004
+++ b/drivers/base/class.c	Mon Jan 19 17:05:14 2004
@@ -46,6 +46,19 @@
 	return ret;
 }
 
+static void class_release(struct kobject * kobj)
+{
+	struct class *class = to_class(kobj);
+
+	pr_debug("class '%s': release.\n", class->name);
+
+	if (class->class_release)
+		class->class_release(class);
+	else
+		pr_debug("class '%s' does not have a release() function, "
+			 "be careful\n", class->name);
+}
+
 static struct sysfs_ops class_sysfs_ops = {
 	.show	= class_attr_show,
 	.store	= class_attr_store,
@@ -53,6 +66,7 @@
 
 static struct kobj_type ktype_class = {
 	.sysfs_ops	= &class_sysfs_ops,
+	.release	= class_release,
 };
 
 /* Hotplug events for classes go to the class_obj subsys */
diff -Nru a/drivers/base/class_simple.c b/drivers/base/class_simple.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/base/class_simple.c	Mon Jan 19 17:05:14 2004
@@ -0,0 +1,201 @@
+/*
+ * class_simple.c - a "simple" interface for classes for simple char devices.
+ *
+ * Copyright (c) 2003-2004 Greg Kroah-Hartman <greg@kroah.com>
+ * Copyright (c) 2003-2004 IBM Corp.
+ * 
+ * This file is released under the GPLv2
+ *
+ */
+
+#define DEBUG 1
+
+#include <linux/device.h>
+#include <linux/kdev_t.h>
+#include <linux/err.h>
+
+struct class_simple {
+	struct class_device_attribute attr;
+	struct class class;
+};
+#define to_class_simple(d) container_of(d, struct class_simple, class)
+
+struct simple_dev {
+	struct list_head node;
+	dev_t dev;
+	struct class_device class_dev;
+};
+#define to_simple_dev(d) container_of(d, struct simple_dev, class_dev)
+
+static LIST_HEAD(simple_dev_list);
+static spinlock_t simple_dev_list_lock = SPIN_LOCK_UNLOCKED;
+
+static void release_simple_dev(struct class_device *class_dev)
+{
+	struct simple_dev *s_dev = to_simple_dev(class_dev);
+	kfree(s_dev);
+}
+
+static ssize_t show_dev(struct class_device *class_dev, char *buf)
+{
+	struct simple_dev *s_dev = to_simple_dev(class_dev);
+	return print_dev_t(buf, s_dev->dev);
+}
+
+static void class_simple_release(struct class *class)
+{
+	struct class_simple *cs = to_class_simple(class);
+	kfree(cs);
+}
+
+/**
+ * class_simple_create - create a struct class_simple structure
+ * @owner: pointer to the module that is to "own" this struct class_simple
+ * @name: pointer to a string for the name of this class.
+ *
+ * This is used to create a struct class_simple pointer that can then be used
+ * in calls to class_simple_device_add().  This is used when you do not wish to
+ * create a full blown class support for a type of char devices.
+ *
+ * Note, the pointer created here is to be destroyed when finished by making a
+ * call to class_simple_destroy().
+ */
+struct class_simple *class_simple_create(struct module *owner, char *name)
+{
+	struct class_simple *cs;
+	int retval;
+
+	cs = kmalloc(sizeof(*cs), GFP_KERNEL);
+	if (!cs) {
+		retval = -ENOMEM;
+		goto error;
+	}
+	memset(cs, 0x00, sizeof(*cs));
+
+	cs->class.name = name;
+	cs->class.class_release = class_simple_release;
+	cs->class.release = release_simple_dev;
+
+	cs->attr.attr.name = "dev";
+	cs->attr.attr.mode = S_IRUGO;
+	cs->attr.attr.owner = owner;
+	cs->attr.show = show_dev;
+	cs->attr.store = NULL;
+
+	retval = class_register(&cs->class);
+	if (retval)
+		goto error;
+
+	return cs;
+
+error:
+	kfree(cs);
+	return ERR_PTR(retval);
+}
+EXPORT_SYMBOL(class_simple_create);
+
+/**
+ * class_simple_destroy - destroys a struct class_simple structure
+ * @cs: pointer to the struct class_simple that is to be destroyed
+ *
+ * Note, the pointer to be destroyed must have been created with a call to
+ * class_simple_create().
+ */
+void class_simple_destroy(struct class_simple *cs)
+{
+	if ((cs == NULL) || (IS_ERR(cs)))
+		return;
+
+	class_unregister(&cs->class);
+}
+EXPORT_SYMBOL(class_simple_destroy);
+
+/**
+ * class_simple_device_add - adds a class device to sysfs for a character driver
+ * @cs: pointer to the struct class_simple that this device should be registered to.  
+ * @dev: the dev_t for the device to be added.
+ * @device: a pointer to a struct device that is assiociated with this class device.
+ * @fmt: string for the class device's name
+ *
+ * This function can be used by simple char device classes that do not
+ * implement their own class device registration.  A struct class_device will
+ * be created in sysfs, registered to the specified class.  A "dev" file will
+ * be created, showing the dev_t for the device.  The pointer to the struct
+ * class_device will be returned from the call.  Any further sysfs files that
+ * might be required can be created using this pointer.
+ * Note: the struct class_device passed to this function must have previously been
+ * created with a call to class_simple_create().
+ */
+struct class_device *class_simple_device_add(struct class_simple *cs, dev_t dev, struct device *device, const char *fmt, ...)
+{
+	va_list args;
+	struct simple_dev *s_dev = NULL;
+	int retval;
+
+	if ((cs == NULL) || (IS_ERR(cs))) {
+		retval = -ENODEV;
+		goto error;
+	}
+
+	s_dev = kmalloc(sizeof(*s_dev), GFP_KERNEL);
+	if (!s_dev) {
+		retval = -ENOMEM;
+		goto error;
+	}
+	memset(s_dev, 0x00, sizeof(*s_dev));
+
+	s_dev->dev = dev;
+	s_dev->class_dev.dev = device;
+	s_dev->class_dev.class = &cs->class;
+	
+	va_start(args,fmt);
+	vsnprintf(s_dev->class_dev.class_id, BUS_ID_SIZE, fmt, args);
+	va_end(args);
+	retval = class_device_register(&s_dev->class_dev);
+	if (retval)
+		goto error;
+
+	class_device_create_file(&s_dev->class_dev, &cs->attr);
+
+	spin_lock(&simple_dev_list_lock);
+	list_add(&s_dev->node, &simple_dev_list);
+	spin_unlock(&simple_dev_list_lock);
+
+	return &s_dev->class_dev;
+
+error:
+	kfree(s_dev);
+	return ERR_PTR(retval);
+}
+EXPORT_SYMBOL(class_simple_device_add);
+
+/**
+ * class_simple_device_remove - removes a class device that was created with class_simple_device_add()
+ * @dev: the dev_t of the device that was previously registered.
+ *
+ * This call unregisters and cleans up a class device that was created with a
+ * call to class_device_simple_add()
+ */
+void class_simple_device_remove(dev_t dev)
+{
+	struct simple_dev *s_dev = NULL;
+	struct list_head *tmp;
+	int found = 0;
+
+	spin_lock(&simple_dev_list_lock);
+	list_for_each(tmp, &simple_dev_list) {
+		s_dev = list_entry(tmp, struct simple_dev, node);
+		if (s_dev->dev == dev) {
+			found = 1;
+			break;
+		}
+	}
+	if (found) {
+		list_del(&s_dev->node);
+		spin_unlock(&simple_dev_list_lock);
+		class_device_unregister(&s_dev->class_dev);
+	} else {
+		spin_unlock(&simple_dev_list_lock);
+	}
+}
+EXPORT_SYMBOL(class_simple_device_remove);
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	Mon Jan 19 17:05:14 2004
+++ b/include/linux/device.h	Mon Jan 19 17:05:14 2004
@@ -46,6 +46,7 @@
 struct device_driver;
 struct class;
 struct class_device;
+struct class_simple;
 
 struct bus_type {
 	char			* name;
@@ -155,6 +156,7 @@
 			   int num_envp, char *buffer, int buffer_size);
 
 	void	(*release)(struct class_device *dev);
+	void	(*class_release)(struct class *class);
 };
 
 extern int class_register(struct class *);
@@ -245,6 +247,13 @@
 
 extern int class_interface_register(struct class_interface *);
 extern void class_interface_unregister(struct class_interface *);
+
+/* interface for class simple stuff */
+extern struct class_simple *class_simple_create(struct module *owner, char *name);
+extern void class_simple_destroy(struct class_simple *cs);
+extern struct class_device *class_simple_device_add(struct class_simple *cs, dev_t dev, struct device *device, const char *fmt, ...)
+	__attribute__((format(printf,4,5)));
+extern void class_simple_device_remove(dev_t dev);
 
 
 struct device {

