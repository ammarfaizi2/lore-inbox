Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262566AbTLWVdh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 16:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262694AbTLWVcB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 16:32:01 -0500
Received: from mail.kroah.org ([65.200.24.183]:49631 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262598AbTLWVbj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 16:31:39 -0500
Date: Tue, 23 Dec 2003 13:26:20 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Subject: [PATCH] add "simple" class device support  [1/5]
Message-ID: <20031223212620.GB15700@kroah.com>
References: <20031223212459.GA15700@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031223212459.GA15700@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a "simple" class device interface to the kernel for char devices
that don't want to roll their own struct class_device handling logic.


diff -Nru a/drivers/base/Makefile b/drivers/base/Makefile
--- a/drivers/base/Makefile	Tue Dec 23 12:53:40 2003
+++ b/drivers/base/Makefile	Tue Dec 23 12:53:40 2003
@@ -1,7 +1,7 @@
 # Makefile for the Linux device tree
 
 obj-y			:= core.o sys.o interface.o bus.o \
-			   driver.o class.o platform.o \
+			   driver.o class.o class_simple.o platform.o \
 			   cpu.o firmware.o init.o map.o
 obj-y			+= power/
 obj-$(CONFIG_FW_LOADER)	+= firmware_class.o
diff -Nru a/drivers/base/class_simple.c b/drivers/base/class_simple.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/base/class_simple.c	Tue Dec 23 12:53:48 2003
@@ -0,0 +1,123 @@
+/*
+ * class_simple.c - basic char device support
+ *
+ * Copyright (c) 2003 Greg Kroah-Hartman <greg@kroah.com>
+ * Copyright (c) 2003 IBM Corp.
+ * 
+ * This file is released under the GPLv2
+ *
+ */
+
+#undef DEBUG
+
+#include <linux/device.h>
+#include <linux/kdev_t.h>
+#include <linux/err.h>
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
+static CLASS_DEVICE_ATTR(dev, S_IRUGO, show_dev, NULL);
+
+/**
+ * simple_add_class_device - adds a class device to sysfs for a character driver
+ * @class: pointer to the struct class that this device should be registered to.  
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
+ * Note: the struct class passed to this function must have previously been
+ * registered with a call to register_class().
+ */
+struct class_device *simple_add_class_device(struct class *class, dev_t dev, struct device *device, const char *fmt, ...)
+{
+	va_list args;
+	struct simple_dev *s_dev;
+	int retval;
+
+	s_dev = kmalloc(sizeof(*s_dev), GFP_KERNEL);
+	if (!s_dev) {
+		retval = -ENOMEM;
+		goto error;
+	}
+	memset(s_dev, 0x00, sizeof(*s_dev));
+
+	class->release = &release_simple_dev;
+	s_dev->dev = dev;
+	s_dev->class_dev.dev = device;
+	s_dev->class_dev.class = class;
+	
+	va_start(args,fmt);
+	vsnprintf(s_dev->class_dev.class_id, BUS_ID_SIZE, fmt, args);
+	va_end(args);
+	retval = class_device_register(&s_dev->class_dev);
+	if (retval)
+		goto error;
+	class_device_create_file(&s_dev->class_dev, &class_device_attr_dev);
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
+EXPORT_SYMBOL(simple_add_class_device);
+
+/**
+ * simple_remove_class_device - removes a class device that was created with simple_add_class_device()
+ * @dev: the dev_t of the device that was previously registered.
+ *
+ * This call unregisters and cleans up a class device that was created with a
+ * call to simple_add_class_device()
+ */
+void simple_remove_class_device(dev_t dev)
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
+EXPORT_SYMBOL(simple_remove_class_device);
+
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	Tue Dec 23 12:53:36 2003
+++ b/include/linux/device.h	Tue Dec 23 12:53:36 2003
@@ -246,6 +246,11 @@
 extern int class_interface_register(struct class_interface *);
 extern void class_interface_unregister(struct class_interface *);
 
+/* interface for simple class devices */
+extern struct class_device *simple_add_class_device(struct class *class, dev_t dev, struct device *device, const char *fmt, ...)
+	__attribute__((format(printf,4,5)));
+extern void simple_remove_class_device(dev_t dev);
+
 
 struct device {
 	struct list_head node;		/* node in sibling list */
