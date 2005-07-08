Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262954AbVGHW7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262954AbVGHW7R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 18:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262953AbVGHW5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 18:57:33 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:55321 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S262930AbVGHWyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 18:54:51 -0400
X-IronPort-AV: i="3.94,183,1118034000"; 
   d="scan'208"; a="263888796:sNHT18483276"
Date: Fri, 8 Jul 2005 17:54:48 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 2.6.13-rc1] driver core: subclasses
Message-ID: <20050708225448.GA18193@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

The below patch is a first pass at implementing subclasses, for review
and comment.

As a test, I modified drivers/input/input.c to allocate a new class,
and register it as a subclass.

Before:

/sys/class/input/
/sys/class/input_device/

After:
/sys/class/input/input_device/

In this pass I'm not exporting the subclass_register/unregister
functions, but am expecting callers to use the new
class_subclass_create() call, and older callers to continue using
class_create() which is now static inline.

Callers to class_create() are expected to call class_destroy() on the
subclasses before the parent class.

Feedback appreciated.

Signed-off-by: Matt Domsch <Matt_Domsch@dell.com>

Thanks,
Matt

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

--- linux-2.6/drivers/base/class.c	2005-07-06 14:19:37.000000000 -0400
+++ linux-2.6/drivers/base/class.c	2005-07-08 18:41:19.000000000 -0400
@@ -133,6 +133,26 @@ static void remove_class_attrs(struct cl
 	}
 }
 
+static int class_subclass_register(struct class *subclass)
+{
+	struct class *parent;
+
+	if (!subclass)
+		return -ENODEV;
+
+	parent = class_get(subclass->parent);
+	if (!parent)
+		return -EINVAL;
+
+	subclass->subsys.kset.kobj.parent = &parent->subsys.kset.kobj;
+
+	down(&parent->sem);
+	list_add_tail(&parent->subclasses, &subclass->subclass_node);
+	up(&parent->sem);
+
+	return 0;
+}
+
 int class_register(struct class * cls)
 {
 	int error;
@@ -141,6 +161,8 @@ int class_register(struct class * cls)
 
 	INIT_LIST_HEAD(&cls->children);
 	INIT_LIST_HEAD(&cls->interfaces);
+	INIT_LIST_HEAD(&cls->subclasses);
+	INIT_LIST_HEAD(&cls->subclass_node);
 	init_MUTEX(&cls->sem);
 	error = kobject_set_name(&cls->subsys.kset.kobj, "%s", cls->name);
 	if (error)
@@ -148,6 +170,7 @@ int class_register(struct class * cls)
 
 	subsys_set_kset(cls, class_subsys);
 
+	class_subclass_register(cls);
 	error = subsystem_register(&cls->subsys);
 	if (!error) {
 		error = add_class_attrs(class_get(cls));
@@ -156,10 +179,25 @@ int class_register(struct class * cls)
 	return error;
 }
 
+static void class_subclass_unregister(struct class *subclass)
+{
+	struct class *parent = subclass->parent;
+
+	if (!parent)
+		return;
+
+	down(&parent->sem);
+	list_del_init(&subclass->subclass_node);
+	subclass->parent = NULL;
+	up(&parent->sem);
+	class_put(parent);
+}
+
 void class_unregister(struct class * cls)
 {
 	pr_debug("device class '%s': unregistering\n", cls->name);
 	remove_class_attrs(cls);
+	class_subclass_unregister(cls);
 	subsystem_unregister(&cls->subsys);
 }
 
@@ -184,7 +222,7 @@ static void class_device_create_release(
  * Note, the pointer created here is to be destroyed when finished by
  * making a call to class_destroy().
  */
-struct class *class_create(struct module *owner, char *name)
+struct class *class_subclass_create(struct module *owner, char *name, struct class *parent)
 {
 	struct class *cls;
 	int retval;
@@ -200,6 +238,7 @@ struct class *class_create(struct module
 	cls->owner = owner;
 	cls->class_release = class_create_release;
 	cls->release = class_device_create_release;
+	cls->parent = parent;
 
 	retval = class_register(cls);
 	if (retval)
@@ -738,8 +777,8 @@ EXPORT_SYMBOL_GPL(class_register);
 EXPORT_SYMBOL_GPL(class_unregister);
 EXPORT_SYMBOL_GPL(class_get);
 EXPORT_SYMBOL_GPL(class_put);
-EXPORT_SYMBOL_GPL(class_create);
+EXPORT_SYMBOL_GPL(class_subclass_create);
 EXPORT_SYMBOL_GPL(class_destroy);
 
 EXPORT_SYMBOL_GPL(class_device_register);
--- linux-2.6/include/linux/device.h	2005-07-06 14:21:20.000000000 -0400
+++ linux-2.6-input/include/linux/device.h	2005-07-08 18:39:16.000000000 -0400
@@ -155,11 +155,14 @@ struct device * driver_find_device(struc
 struct class {
 	const char		* name;
 	struct module		* owner;
+	struct class            * parent; /* for subclasses */
 
 	struct subsystem	subsys;
-	struct list_head	children;
+	struct list_head	children; /* for class_devices */
 	struct list_head	interfaces;
-	struct semaphore	sem;	/* locks both the children and interfaces lists */
+	struct list_head	subclasses;
+	struct list_head	subclass_node; /* parent->sem held when accessing */
+	struct semaphore	sem;	/* locks children, subclasses, interfaces lists */
 
 	struct class_attribute		* class_attrs;
 	struct class_device_attribute	* class_dev_attrs;
@@ -258,7 +261,11 @@ struct class_interface {
 extern int class_interface_register(struct class_interface *);
 extern void class_interface_unregister(struct class_interface *);
 
-extern struct class *class_create(struct module *owner, char *name);
+extern struct class *class_subclass_create(struct module *owner, char *name, struct class *parent);
+static inline struct class *class_create(struct module *owner, char *name)
+{
+	return class_subclass_create(owner, name, NULL);
+}
 extern void class_destroy(struct class *cls);
 extern struct class_device *class_device_create(struct class *cls, dev_t devt,
 						struct device *device, char *fmt, ...)
