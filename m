Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbUFQSfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbUFQSfi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 14:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbUFQSfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 14:35:37 -0400
Received: from mail.homelink.ru ([81.9.33.123]:28381 "EHLO eltel.net")
	by vger.kernel.org with ESMTP id S261610AbUFQSfR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 14:35:17 -0400
Date: Thu, 17 Jun 2004 22:35:14 +0400
From: Andrew Zabolotny <zap@homelink.ru>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Backlight and LCD module patches [1]
Message-Id: <20040617223514.2e129ce9.zap@homelink.ru>
Organization: home
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: #%`a@cSvZ:n@M%n/to$C^!{JE%'%7_0xb("Hr%7Z0LDKO7?w=m~CU#d@-.2yO<l^giDz{>9
 epB|2@pe{%4[Q3pw""FeqiT6rOc>+8|ED/6=Eh/4l3Ru>qRC]ef%ojRz;GQb=uqI<yb'yaIIzq^NlL
 rf<gnIz)JE/7:KmSsR[wN`b\l8:z%^[gNq#d1\QSuya1(
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I've tried to fulfill all the requirements that various people presented to
the previous version of this patch; this and the following letter contains
the fixed version of the patch that is proposed to be included into the
mainstream kernel.

--
Greetings,
   Andrew

This patch adds the class_device_find() function, which can be used
to find a class_device by its name. The function was originally
written by Greg Kroah-Hartman.

Also it fixes the class_rename() function to accept 'const char *'
argument as the new class device name.

Signed-off-by: Andrew Zabolotny <zap@homelink.ru>

--- linux-2.6.7-rc3/drivers/base/class.c	2004-06-11 02:39:19.000000000 +0400
+++ linux/drivers/base/class.c	2004-06-17 21:51:11.000000000 +0400
@@ -359,7 +359,7 @@
 	class_device_put(class_dev);
 }
 
-int class_device_rename(struct class_device *class_dev, char *new_name)
+int class_device_rename(struct class_device *class_dev, const char *new_name)
 {
 	int error = 0;
 
@@ -379,6 +379,33 @@
 	return error;
 }
 
+/**
+ * class_device_find - find a struct class_device in a specific class
+ * @class: the class to search
+ * @class_id: the class_id to search for
+ *
+ * Iterates through the list of all class devices registered to a class. If
+ * the class_id is found, its reference count is incremented and returned to
+ * the caller. If the class_id does not match any existing struct class_device
+ * registered to this struct class, then NULL is returned.
+ */
+struct class_device * class_device_find(struct class *class, const char *class_id)
+{
+	struct class_device *class_dev;
+	struct class_device *found = NULL;
+
+	down_read(&class->subsys.rwsem);
+	list_for_each_entry(class_dev, &class->children, node) {
+		if (strcmp(class_dev->class_id, class_id) == 0) {
+			found = class_device_get(class_dev);
+			break;
+		}
+	}
+	up_read(&class->subsys.rwsem);
+
+	return found;
+}
+
 struct class_device * class_device_get(struct class_device *class_dev)
 {
 	if (class_dev)
@@ -391,7 +418,6 @@
 	kobject_put(&class_dev->kobj);
 }
 
-
 int class_interface_register(struct class_interface *class_intf)
 {
 	struct class * parent;
@@ -470,6 +496,8 @@
 EXPORT_SYMBOL(class_device_put);
 EXPORT_SYMBOL(class_device_create_file);
 EXPORT_SYMBOL(class_device_remove_file);
+EXPORT_SYMBOL(class_device_rename);
+EXPORT_SYMBOL(class_device_find);
 
 EXPORT_SYMBOL(class_interface_register);
 EXPORT_SYMBOL(class_interface_unregister);
--- linux-2.6.7-rc3/include/linux/device.h	2004-06-11 02:39:37.000000000 +0400
+++ linux/include/linux/device.h	2004-06-17 21:52:32.000000000 +0400
@@ -212,8 +212,9 @@
 extern int class_device_add(struct class_device *);
 extern void class_device_del(struct class_device *);
 
-extern int class_device_rename(struct class_device *, char *);
+extern int class_device_rename(struct class_device *, const char *);
 
+extern struct class_device * class_device_find(struct class *class, const char *class_id);
 extern struct class_device * class_device_get(struct class_device *);
 extern void class_device_put(struct class_device *);
 
