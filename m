Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265091AbUFVR5V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265091AbUFVR5V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 13:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265094AbUFVRx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 13:53:59 -0400
Received: from mail.kroah.org ([65.200.24.183]:52661 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265090AbUFVRnm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 13:43:42 -0400
X-Donotread: and you are reading this why?
Subject: [PATCH] Driver Core patches for 2.6.7
In-Reply-To: <20040622171949.GA1394@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 22 Jun 2004 10:41:48 -0700
Message-Id: <10879261083581@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1722.85.1, 2004/06/02 17:10:52-07:00, mochel@digitalimplant.org

[Driver Model] Consolidate attribute definition macros

- Create __ATTR(), __ATTR_RO(), and __ATTR_NULL macros to help define 
  attributes in a neat, short-hand form. 

- Apply these macros to the attribute definition in include/linux/device.h

- Note: These can be used to more cleanly define attributes in your own
  code. e.g: 

	static struct device_attribute attrs[] = {
		__ATTR_RO(foo),
		__ATTR_RO(bar),
		__ATTR(baz,0666,baz_show,baz_store),
		__ATTR_NULL,
	};

  ...etc. 

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 include/linux/device.h |   31 ++++++-------------------------
 include/linux/sysfs.h  |   21 +++++++++++++++++++++
 2 files changed, 27 insertions(+), 25 deletions(-)


diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	Tue Jun 22 09:49:19 2004
+++ b/include/linux/device.h	Tue Jun 22 09:49:19 2004
@@ -90,11 +90,7 @@
 };
 
 #define BUS_ATTR(_name,_mode,_show,_store)	\
-struct bus_attribute bus_attr_##_name = { 		\
-	.attr = {.name = __stringify(_name), .mode = _mode, .owner = THIS_MODULE },	\
-	.show	= _show,				\
-	.store	= _store,				\
-};
+struct bus_attribute bus_attr_##_name = __ATTR(_name,_mode,_show,_store)
 
 extern int bus_create_file(struct bus_type *, struct bus_attribute *);
 extern void bus_remove_file(struct bus_type *, struct bus_attribute *);
@@ -131,11 +127,7 @@
 };
 
 #define DRIVER_ATTR(_name,_mode,_show,_store)	\
-struct driver_attribute driver_attr_##_name = { 		\
-	.attr = {.name = __stringify(_name), .mode = _mode, .owner = THIS_MODULE },	\
-	.show	= _show,				\
-	.store	= _store,				\
-};
+struct driver_attribute driver_attr_##_name = __ATTR(_name,_mode,_show,_store)
 
 extern int driver_create_file(struct device_driver *, struct driver_attribute *);
 extern void driver_remove_file(struct device_driver *, struct driver_attribute *);
@@ -172,11 +164,7 @@
 };
 
 #define CLASS_ATTR(_name,_mode,_show,_store)			\
-struct class_attribute class_attr_##_name = { 			\
-	.attr = {.name = __stringify(_name), .mode = _mode, .owner = THIS_MODULE },	\
-	.show	= _show,					\
-	.store	= _store,					\
-};
+struct class_attribute class_attr_##_name = __ATTR(_name,_mode,_show,_store) 
 
 extern int class_create_file(struct class *, const struct class_attribute *);
 extern void class_remove_file(struct class *, const struct class_attribute *);
@@ -224,11 +212,8 @@
 };
 
 #define CLASS_DEVICE_ATTR(_name,_mode,_show,_store)		\
-struct class_device_attribute class_device_attr_##_name = { 	\
-	.attr = {.name = __stringify(_name), .mode = _mode, .owner = THIS_MODULE },	\
-	.show	= _show,					\
-	.store	= _store,					\
-};
+struct class_device_attribute class_device_attr_##_name = 	\
+	__ATTR(_name,_mode,_show,_store)
 
 extern int class_device_create_file(struct class_device *, 
 				    const struct class_device_attribute *);
@@ -342,11 +327,7 @@
 };
 
 #define DEVICE_ATTR(_name,_mode,_show,_store) \
-struct device_attribute dev_attr_##_name = { 		\
-	.attr = {.name = __stringify(_name), .mode = _mode, .owner = THIS_MODULE },	\
-	.show	= _show,				\
-	.store	= _store,				\
-};
+struct device_attribute dev_attr_##_name = __ATTR(_name,_mode,_show,_store)
 
 
 extern int device_create_file(struct device *device, struct device_attribute * entry);
diff -Nru a/include/linux/sysfs.h b/include/linux/sysfs.h
--- a/include/linux/sysfs.h	Tue Jun 22 09:49:19 2004
+++ b/include/linux/sysfs.h	Tue Jun 22 09:49:19 2004
@@ -24,6 +24,27 @@
 };
 
 
+
+/**
+ * Use these macros to make defining attributes easier. See include/linux/device.h
+ * for examples..
+ */
+
+#define __ATTR(_name,_mode,_show,_store) { \
+	.attr = {.name = __stringify(_name), .mode = _mode, .owner = THIS_MODULE },	\
+	.show	= _show,					\
+	.store	= _store,					\
+}
+
+#define __ATTR_RO(_name) { \
+	.attr	= { .name = __stringify(_name), .mode = 0444, .owner = THIS_MODULE },	\
+	.show	= _name##_show,	\
+}
+
+#define __ATTR_NULL { .attr = { .name = NULL } }
+
+
+
 struct bin_attribute {
 	struct attribute	attr;
 	size_t			size;

