Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265055AbUFVSHL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265055AbUFVSHL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 14:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265108AbUFVSDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 14:03:52 -0400
Received: from mail.kroah.org ([65.200.24.183]:44213 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265073AbUFVRna convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 13:43:30 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.7
In-Reply-To: <10879261081887@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 22 Jun 2004 10:41:48 -0700
Message-Id: <1087926108744@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1722.85.4, 2004/06/03 10:41:29-07:00, mochel@digitalimplant.org

[Driver Model] Add default attributes for classes class devices.

- add struct class::class_attrs, which is designed to point to an 
  array of class_attributes that are added when the class is registered
  and removed when the class is unregistered. 
  This allows for more consolidated and cleaner definition of and
  management of attributes.

- Add struct class::class_dev_attrs to do something similarly for 
  class devices. Each class device that is registered with the class
  gets that set of attributes added for them, and subsequently removed
  when the device is unregistered.

Each array depends on a terminating attribute with a NULL name. Hint:
use the new __ATTR_NULL macro to terminate it.


 drivers/base/class.c   |   81 +++++++++++++++++++++++++++++++++++++++++++++----
 include/linux/device.h |    3 +
 2 files changed, 78 insertions(+), 6 deletions(-)


diff -Nru a/drivers/base/class.c b/drivers/base/class.c
--- a/drivers/base/class.c	Tue Jun 22 09:49:00 2004
+++ b/drivers/base/class.c	Tue Jun 22 09:49:00 2004
@@ -100,6 +100,37 @@
 	subsys_put(&cls->subsys);
 }
 
+
+static int add_class_attrs(struct class * cls)
+{
+	int i;
+	int error = 0;
+
+	if (cls->class_attrs) {
+		for (i = 0; attr_name(cls->class_attrs[i]); i++) {
+			error = class_create_file(cls,&cls->class_attrs[i]);
+			if (error)
+				goto Err;
+		}
+	}
+ Done:
+	return error;
+ Err:
+	while (--i >= 0)
+		class_remove_file(cls,&cls->class_attrs[i]);
+	goto Done;
+}
+
+static void remove_class_attrs(struct class * cls)
+{
+	int i;
+
+	if (cls->class_attrs) {
+		for (i = 0; attr_name(cls->class_attrs[i]); i++)
+			class_remove_file(cls,&cls->class_attrs[i]);
+	}
+}
+
 int class_register(struct class * cls)
 {
 	int error;
@@ -115,18 +146,21 @@
 	subsys_set_kset(cls,class_subsys);
 
 	error = subsystem_register(&cls->subsys);
-	if (error)
-		return error;
-
-	return 0;
+	if (!error) {
+		error = add_class_attrs(class_get(cls));
+		class_put(cls);
+	}
+	return error;
 }
 
 void class_unregister(struct class * cls)
 {
 	pr_debug("device class '%s': unregistering\n",cls->name);
+	remove_class_attrs(cls);
 	subsystem_unregister(&cls->subsys);
 }
 
+
 /* Class Device Stuff */
 
 int class_device_create_file(struct class_device * class_dev,
@@ -272,6 +306,40 @@
 
 static decl_subsys(class_obj, &ktype_class_device, &class_hotplug_ops);
 
+
+static int class_device_add_attrs(struct class_device * cd)
+{
+	int i;
+	int error = 0;
+	struct class * cls = cd->class;
+
+	if (cls->class_dev_attrs) {
+		for (i = 0; attr_name(cls->class_dev_attrs[i]); i++) {
+			error = class_device_create_file(cd,
+							 &cls->class_dev_attrs[i]);
+			if (error)
+				goto Err;
+		}
+	}
+ Done:
+	return error;
+ Err:
+	while (--i >= 0)
+		class_device_remove_file(cd,&cls->class_dev_attrs[i]);
+	goto Done;
+}
+
+static void class_device_remove_attrs(struct class_device * cd)
+{
+	int i;
+	struct class * cls = cd->class;
+
+	if (cls->class_dev_attrs) {
+		for (i = 0; attr_name(cls->class_dev_attrs[i]); i++)
+			class_device_remove_file(cd,&cls->class_dev_attrs[i]);
+	}
+}
+
 void class_device_initialize(struct class_device *class_dev)
 {
 	kobj_set_kset_s(class_dev, class_obj_subsys);
@@ -311,7 +379,7 @@
 				class_intf->add(class_dev);
 		up_write(&parent->subsys.rwsem);
 	}
-
+	class_device_add_attrs(class_dev);
 	class_device_dev_link(class_dev);
 	class_device_driver_link(class_dev);
 
@@ -344,7 +412,8 @@
 
 	class_device_dev_unlink(class_dev);
 	class_device_driver_unlink(class_dev);
-	
+	class_device_remove_attrs(class_dev);
+
 	kobject_del(&class_dev->kobj);
 
 	if (parent)
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	Tue Jun 22 09:49:00 2004
+++ b/include/linux/device.h	Tue Jun 22 09:49:00 2004
@@ -143,6 +143,9 @@
 	struct list_head	children;
 	struct list_head	interfaces;
 
+	struct class_attribute		* class_attrs;
+	struct class_device_attribute	* class_dev_attrs;
+
 	int	(*hotplug)(struct class_device *dev, char **envp, 
 			   int num_envp, char *buffer, int buffer_size);
 

