Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266593AbUAWQ6d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 11:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266594AbUAWQ6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 11:58:33 -0500
Received: from ida.rowland.org ([192.131.102.52]:8708 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S266593AbUAWQ63 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 11:58:29 -0500
Date: Fri, 23 Jan 2004 11:58:28 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Greg KH <greg@kroah.com>, Patrick Mochel <mochel@osdl.org>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: PATCH: (as177)  Add class_device_unregister_wait() and
 platform_device_unregister_wait() to the driver model core
Message-ID: <Pine.LNX.4.44L0.0401231135400.856-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since I haven't seen any progress towards implementing the 
class_device_unregister_wait() and platform_device_unregister_wait() 
functions, here is my attempt.  This also fixes an unnecessary WARN_ON 
about devices with no release() function if the completion pointer is set.

Alan Stern


===== device.h 1.89 vs edited =====
--- 1.89/include/linux/device.h	Tue Jan 20 11:58:44 2004
+++ edited/include/linux/device.h	Fri Jan 23 11:00:34 2004
@@ -186,6 +186,7 @@
 struct class_device {
 	struct list_head	node;
 
+	struct completion	* complete;	/* Notification for freeing. */
 	struct kobject		kobj;
 	struct class		* class;	/* required */
 	struct device		* dev;		/* not necessary, but nice to have */
@@ -209,6 +210,7 @@
 
 extern int class_device_register(struct class_device *);
 extern void class_device_unregister(struct class_device *);
+extern void class_device_unregister_wait(struct class_device *);
 extern void class_device_initialize(struct class_device *);
 extern int class_device_add(struct class_device *);
 extern void class_device_del(struct class_device *);
@@ -380,6 +382,7 @@
 
 extern int platform_device_register(struct platform_device *);
 extern void platform_device_unregister(struct platform_device *);
+extern void platform_device_unregister_wait(struct platform_device *);
 
 extern struct bus_type platform_bus_type;
 extern struct device platform_bus;
===== class.c 1.45 vs edited =====
--- 1.45/drivers/base/class.c	Tue Jan 20 17:07:57 2004
+++ edited/drivers/base/class.c	Fri Jan 23 11:05:57 2004
@@ -205,17 +205,20 @@
 {
 	struct class_device *cd = to_class_dev(kobj);
 	struct class * cls = cd->class;
+	struct completion * c = cd->complete;
 
 	pr_debug("device class '%s': release.\n",cd->class_id);
 
 	if (cls->release)
 		cls->release(cd);
-	else {
+	else if (!c) {
 		printk(KERN_ERR "Device class '%s' does not have a release() function, "
 			"it is broken and must be fixed.\n",
 			cd->class_id);
 		WARN_ON(1);
 	}
+	if (c)
+		complete(c);
 }
 
 static struct kobj_type ktype_class_device = {
@@ -363,6 +366,16 @@
 	class_device_put(class_dev);
 }
 
+void class_device_unregister_wait(struct class_device *class_dev)
+{
+	struct completion c;
+
+	init_completion(&c);
+	class_dev->complete = &c;
+	class_device_unregister(class_dev);
+	wait_for_completion(&c);
+}
+
 int class_device_rename(struct class_device *class_dev, char *new_name)
 {
 	class_dev = class_device_get(class_dev);
@@ -470,6 +483,7 @@
 
 EXPORT_SYMBOL(class_device_register);
 EXPORT_SYMBOL(class_device_unregister);
+EXPORT_SYMBOL(class_device_unregister_wait);
 EXPORT_SYMBOL(class_device_initialize);
 EXPORT_SYMBOL(class_device_add);
 EXPORT_SYMBOL(class_device_del);
===== core.c 1.73 vs edited =====
--- 1.73/drivers/base/core.c	Tue Jan 20 17:07:57 2004
+++ edited/drivers/base/core.c	Wed Jan 21 11:43:24 2004
@@ -83,7 +83,7 @@
 
 	if (dev->release)
 		dev->release(dev);
-	else {
+	else if (!c) {
 		printk(KERN_ERR "Device '%s' does not have a release() function, "
 			"it is broken and must be fixed.\n",
 			dev->bus_id);
===== platform.c 1.11 vs edited =====
--- 1.11/drivers/base/platform.c	Tue Dec 30 13:25:09 2003
+++ edited/drivers/base/platform.c	Fri Jan 23 11:06:44 2004
@@ -46,6 +46,12 @@
 		device_unregister(&pdev->dev);
 }
 
+void platform_device_unregister_wait(struct platform_device * pdev)
+{
+	if (pdev)
+		device_unregister_wait(&pdev->dev);
+}
+
 
 /**
  *	platform_match - bind platform device to platform driver.
@@ -113,3 +119,4 @@
 EXPORT_SYMBOL(platform_bus_type);
 EXPORT_SYMBOL(platform_device_register);
 EXPORT_SYMBOL(platform_device_unregister);
+EXPORT_SYMBOL(platform_device_unregister_wait);

