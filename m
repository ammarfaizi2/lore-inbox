Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261672AbVFUD4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbVFUD4s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 23:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbVFUCyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 22:54:16 -0400
Received: from mail.kroah.org ([69.55.234.183]:14564 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261672AbVFTW7j convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:39 -0400
Cc: gregkh@suse.de
Subject: [PATCH] class: remove class_simple code, as no one in the tree is using it anymore.
In-Reply-To: <11193083633953@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:23 -0700
Message-Id: <11193083631784@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] class: remove class_simple code, as no one in the tree is using it anymore.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit cd987d38cc59053e0bab8150ffaca33b109067f3
tree 68cf99616bd548bff80ca12f37912d9cc4b31edd
parent 2fc68447df5c76cf254037047b4b02551bd5d760
author gregkh@suse.de <gregkh@suse.de> Wed, 23 Mar 2005 11:12:38 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:11 -0700

 drivers/base/Makefile       |    2 
 drivers/base/class_simple.c |  199 -------------------------------------------
 include/linux/device.h      |   10 --
 3 files changed, 1 insertions(+), 210 deletions(-)

diff --git a/drivers/base/Makefile b/drivers/base/Makefile
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -1,7 +1,7 @@
 # Makefile for the Linux device tree
 
 obj-y			:= core.o sys.o bus.o \
-			   driver.o class.o class_simple.o platform.o \
+			   driver.o class.o platform.o \
 			   cpu.o firmware.o init.o map.o dmapool.o \
 			   attribute_container.o transport_class.o
 obj-y			+= power/
diff --git a/drivers/base/class_simple.c b/drivers/base/class_simple.c
deleted file mode 100644
--- a/drivers/base/class_simple.c
+++ /dev/null
@@ -1,199 +0,0 @@
-/*
- * class_simple.c - a "simple" interface for classes for simple char devices.
- *
- * Copyright (c) 2003-2004 Greg Kroah-Hartman <greg@kroah.com>
- * Copyright (c) 2003-2004 IBM Corp.
- *
- * This file is released under the GPLv2
- *
- */
-
-#include <linux/config.h>
-#include <linux/device.h>
-#include <linux/err.h>
-
-struct class_simple {
-	struct class class;
-};
-#define to_class_simple(d) container_of(d, struct class_simple, class)
-
-struct simple_dev {
-	struct list_head node;
-	struct class_device class_dev;
-};
-#define to_simple_dev(d) container_of(d, struct simple_dev, class_dev)
-
-static LIST_HEAD(simple_dev_list);
-static DEFINE_SPINLOCK(simple_dev_list_lock);
-
-static void release_simple_dev(struct class_device *class_dev)
-{
-	struct simple_dev *s_dev = to_simple_dev(class_dev);
-	kfree(s_dev);
-}
-
-static void class_simple_release(struct class *class)
-{
-	struct class_simple *cs = to_class_simple(class);
-	kfree(cs);
-}
-
-/**
- * class_simple_create - create a struct class_simple structure
- * @owner: pointer to the module that is to "own" this struct class_simple
- * @name: pointer to a string for the name of this class.
- *
- * This is used to create a struct class_simple pointer that can then be used
- * in calls to class_simple_device_add().  This is used when you do not wish to
- * create a full blown class support for a type of char devices.
- *
- * Note, the pointer created here is to be destroyed when finished by making a
- * call to class_simple_destroy().
- */
-struct class_simple *class_simple_create(struct module *owner, char *name)
-{
-	struct class_simple *cs;
-	int retval;
-
-	cs = kmalloc(sizeof(*cs), GFP_KERNEL);
-	if (!cs) {
-		retval = -ENOMEM;
-		goto error;
-	}
-	memset(cs, 0x00, sizeof(*cs));
-
-	cs->class.name = name;
-	cs->class.class_release = class_simple_release;
-	cs->class.release = release_simple_dev;
-
-	retval = class_register(&cs->class);
-	if (retval)
-		goto error;
-
-	return cs;
-
-error:
-	kfree(cs);
-	return ERR_PTR(retval);
-}
-EXPORT_SYMBOL(class_simple_create);
-
-/**
- * class_simple_destroy - destroys a struct class_simple structure
- * @cs: pointer to the struct class_simple that is to be destroyed
- *
- * Note, the pointer to be destroyed must have been created with a call to
- * class_simple_create().
- */
-void class_simple_destroy(struct class_simple *cs)
-{
-	if ((cs == NULL) || (IS_ERR(cs)))
-		return;
-
-	class_unregister(&cs->class);
-}
-EXPORT_SYMBOL(class_simple_destroy);
-
-/**
- * class_simple_device_add - adds a class device to sysfs for a character driver
- * @cs: pointer to the struct class_simple that this device should be registered to.
- * @dev: the dev_t for the device to be added.
- * @device: a pointer to a struct device that is assiociated with this class device.
- * @fmt: string for the class device's name
- *
- * This function can be used by simple char device classes that do not
- * implement their own class device registration.  A struct class_device will
- * be created in sysfs, registered to the specified class.  A "dev" file will
- * be created, showing the dev_t for the device.  The pointer to the struct
- * class_device will be returned from the call.  Any further sysfs files that
- * might be required can be created using this pointer.
- * Note: the struct class_simple passed to this function must have previously been
- * created with a call to class_simple_create().
- */
-struct class_device *class_simple_device_add(struct class_simple *cs, dev_t dev, struct device *device, const char *fmt, ...)
-{
-	va_list args;
-	struct simple_dev *s_dev = NULL;
-	int retval;
-
-	if ((cs == NULL) || (IS_ERR(cs))) {
-		retval = -ENODEV;
-		goto error;
-	}
-
-	s_dev = kmalloc(sizeof(*s_dev), GFP_KERNEL);
-	if (!s_dev) {
-		retval = -ENOMEM;
-		goto error;
-	}
-	memset(s_dev, 0x00, sizeof(*s_dev));
-
-	s_dev->class_dev.devt = dev;
-	s_dev->class_dev.dev = device;
-	s_dev->class_dev.class = &cs->class;
-
-	va_start(args, fmt);
-	vsnprintf(s_dev->class_dev.class_id, BUS_ID_SIZE, fmt, args);
-	va_end(args);
-	retval = class_device_register(&s_dev->class_dev);
-	if (retval)
-		goto error;
-
-	spin_lock(&simple_dev_list_lock);
-	list_add(&s_dev->node, &simple_dev_list);
-	spin_unlock(&simple_dev_list_lock);
-
-	return &s_dev->class_dev;
-
-error:
-	kfree(s_dev);
-	return ERR_PTR(retval);
-}
-EXPORT_SYMBOL(class_simple_device_add);
-
-/**
- * class_simple_set_hotplug - set the hotplug callback in the embedded struct class
- * @cs: pointer to the struct class_simple to hold the pointer
- * @hotplug: function pointer to the hotplug function
- *
- * Implement and set a hotplug function to add environment variables specific to this
- * class on the hotplug event.
- */
-int class_simple_set_hotplug(struct class_simple *cs,
-	int (*hotplug)(struct class_device *dev, char **envp, int num_envp, char *buffer, int buffer_size))
-{
-	if ((cs == NULL) || (IS_ERR(cs)))
-		return -ENODEV;
-	cs->class.hotplug = hotplug;
-	return 0;
-}
-EXPORT_SYMBOL(class_simple_set_hotplug);
-
-/**
- * class_simple_device_remove - removes a class device that was created with class_simple_device_add()
- * @dev: the dev_t of the device that was previously registered.
- *
- * This call unregisters and cleans up a class device that was created with a
- * call to class_device_simple_add()
- */
-void class_simple_device_remove(dev_t dev)
-{
-	struct simple_dev *s_dev = NULL;
-	int found = 0;
-
-	spin_lock(&simple_dev_list_lock);
-	list_for_each_entry(s_dev, &simple_dev_list, node) {
-		if (s_dev->class_dev.devt == dev) {
-			found = 1;
-			break;
-		}
-	}
-	if (found) {
-		list_del(&s_dev->node);
-		spin_unlock(&simple_dev_list_lock);
-		class_device_unregister(&s_dev->class_dev);
-	} else {
-		spin_unlock(&simple_dev_list_lock);
-	}
-}
-EXPORT_SYMBOL(class_simple_device_remove);
diff --git a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -44,7 +44,6 @@ struct device;
 struct device_driver;
 struct class;
 struct class_device;
-struct class_simple;
 
 struct bus_type {
 	const char		* name;
@@ -254,15 +253,6 @@ extern struct class_device *class_device
 					__attribute__((format(printf,4,5)));
 extern void class_device_destroy(struct class *cls, dev_t devt);
 
-/* interface for class simple stuff */
-extern struct class_simple *class_simple_create(struct module *owner, char *name);
-extern void class_simple_destroy(struct class_simple *cs);
-extern struct class_device *class_simple_device_add(struct class_simple *cs, dev_t dev, struct device *device, const char *fmt, ...)
-	__attribute__((format(printf,4,5)));
-extern int class_simple_set_hotplug(struct class_simple *, 
-	int (*hotplug)(struct class_device *dev, char **envp, int num_envp, char *buffer, int buffer_size));
-extern void class_simple_device_remove(dev_t dev);
-
 
 struct device {
 	struct list_head node;		/* node in sibling list */

