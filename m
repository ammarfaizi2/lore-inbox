Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751053AbVI2MEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbVI2MEE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 08:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbVI2MEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 08:04:04 -0400
Received: from mail.kroah.org ([69.55.234.183]:703 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751053AbVI2MEB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 08:04:01 -0400
Date: Wed, 28 Sep 2005 16:31:14 -0700
From: Greg KH <gregkh@suse.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       Kay Sievers <kay.sievers@vrfy.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie
Subject: [PATCH] nesting class_device in sysfs to solve world peace
Message-ID: <20050928233114.GA27227@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alright, here's a patch that will add the ability to nest struct
class_device structures in sysfs.  This should give everyone the ability
to model what they need to in the class directory (input, video, etc.).

Dmitry, care to update your input patchset to take advantage of this?
It should work out for what you want to do, and if not, please let me
know.

udev will have to be changed to properly support this, but I think that
Kay already has that taken care of, and is just waiting for some kernel
code to take advantage of this.

Comments?

And yes, I have a follow-on patch that fixes up all callers of the
class_device_create() function, as the api has changed now.  It's in my
patch tree, along with this one, if you want to see it (should show up
in the next -mm).

thanks,

greg k-h

----

From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: Driver Core: add the ability for class_device structures to be nested

This patch allows struct class_device to be nested, so that another
struct class_device can be the parent of a new one, instead of only
having the struct class be the parent.  This will allow us to
(hopefully) fix up the input and video class subsystem mess.

But please people, don't go crazy and start making huge trees of class
devices, you should only need 2 levels deep to get everything to work
(remember to use a class_interface to get notification of a new class
device being added to the system.)

Oh, this also allows us to have the possibility of potentially, someday,
moving /sys/block into /sys/class.  The main hindrance is that pesky
/dev numberspace issue...

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

 drivers/base/class.c   |   84 +++++++++++++++++++++++++++++--------------------
 include/linux/device.h |   10 ++++-
 2 files changed, 58 insertions(+), 36 deletions(-)

--- gregkh-2.6.orig/drivers/base/class.c	2005-09-28 13:56:21.000000000 -0700
+++ gregkh-2.6/drivers/base/class.c	2005-09-28 13:57:10.000000000 -0700
@@ -99,7 +99,8 @@
 
 void class_put(struct class * cls)
 {
-	subsys_put(&cls->subsys);
+	if (cls)
+		subsys_put(&cls->subsys);
 }
 
 
@@ -469,31 +470,36 @@
 
 int class_device_add(struct class_device *class_dev)
 {
-	struct class * parent = NULL;
-	struct class_interface * class_intf;
+	struct class *parent_class = NULL;
+	struct class_device *parent_class_dev = NULL;
+	struct class_interface *class_intf;
 	char *class_name = NULL;
-	int error;
+	int error = -EINVAL;
 
 	class_dev = class_device_get(class_dev);
 	if (!class_dev)
 		return -EINVAL;
 
-	if (!strlen(class_dev->class_id)) {
-		error = -EINVAL;
+	if (!strlen(class_dev->class_id))
 		goto register_done;
-	}
 
-	parent = class_get(class_dev->class);
+	parent_class = class_get(class_dev->class);
+	if (!parent_class)
+		goto register_done;
+	parent_class_dev = class_device_get(class_dev->parent);
 
 	pr_debug("CLASS: registering class device: ID = '%s'\n",
 		 class_dev->class_id);
 
 	/* first, register with generic layer. */
 	kobject_set_name(&class_dev->kobj, "%s", class_dev->class_id);
-	if (parent)
-		class_dev->kobj.parent = &parent->subsys.kset.kobj;
+	if (parent_class_dev)
+		class_dev->kobj.parent = &parent_class_dev->kobj;
+	else
+		class_dev->kobj.parent = &parent_class->subsys.kset.kobj;
 
-	if ((error = kobject_add(&class_dev->kobj)))
+	error = kobject_add(&class_dev->kobj);
+	if (error)
 		goto register_done;
 
 	/* add the needed attributes to this device */
@@ -508,7 +514,7 @@
 
 		attr->attr.name = "dev";
 		attr->attr.mode = S_IRUGO;
-		attr->attr.owner = parent->owner;
+		attr->attr.owner = parent_class->owner;
 		attr->show = show_dev;
 		attr->store = NULL;
 		class_device_create_file(class_dev, attr);
@@ -527,18 +533,20 @@
 	kobject_hotplug(&class_dev->kobj, KOBJ_ADD);
 
 	/* notify any interfaces this device is now here */
-	if (parent) {
-		down(&parent->sem);
-		list_add_tail(&class_dev->node, &parent->children);
-		list_for_each_entry(class_intf, &parent->interfaces, node)
+	if (parent_class) {
+		down(&parent_class->sem);
+		list_add_tail(&class_dev->node, &parent_class->children);
+		list_for_each_entry(class_intf, &parent_class->interfaces, node)
 			if (class_intf->add)
 				class_intf->add(class_dev, class_intf);
-		up(&parent->sem);
+		up(&parent_class->sem);
 	}
 
  register_done:
-	if (error && parent)
-		class_put(parent);
+	if (error) {
+		class_put(parent_class);
+		class_device_put(parent_class_dev);
+	}
 	class_device_put(class_dev);
 	kfree(class_name);
 	return error;
@@ -553,21 +561,28 @@
 /**
  * class_device_create - creates a class device and registers it with sysfs
  * @cs: pointer to the struct class that this device should be registered to.
+ * @parent: pointer to the parent struct class_device of this new device, if any.
  * @dev: the dev_t for the char device to be added.
  * @device: a pointer to a struct device that is assiociated with this class device.
  * @fmt: string for the class device's name
  *
  * This function can be used by char device classes.  A struct
  * class_device will be created in sysfs, registered to the specified
- * class.  A "dev" file will be created, showing the dev_t for the
- * device.  The pointer to the struct class_device will be returned from
- * the call.  Any further sysfs files that might be required can be
- * created using this pointer.
+ * class.
+ * A "dev" file will be created, showing the dev_t for the device, if
+ * the dev_t is not 0,0.
+ * If a pointer to a parent struct class_device is passed in, the newly
+ * created struct class_device will be a child of that device in sysfs.
+ * The pointer to the struct class_device will be returned from the
+ * call.  Any further sysfs files that might be required can be created
+ * using this pointer.
  *
  * Note: the struct class passed to this function must have previously
  * been created with a call to class_create().
  */
-struct class_device *class_device_create(struct class *cls, dev_t devt,
+struct class_device *class_device_create(struct class *cls,
+					 struct class_device *parent,
+					 dev_t devt,
 					 struct device *device, char *fmt, ...)
 {
 	va_list args;
@@ -586,6 +601,7 @@
 	class_dev->devt = devt;
 	class_dev->dev = device;
 	class_dev->class = cls;
+	class_dev->parent = parent;
 
 	va_start(args, fmt);
 	vsnprintf(class_dev->class_id, BUS_ID_SIZE, fmt, args);
@@ -603,17 +619,18 @@
 
 void class_device_del(struct class_device *class_dev)
 {
-	struct class * parent = class_dev->class;
-	struct class_interface * class_intf;
+	struct class *parent_class = class_dev->class;
+	struct class_device *parent_device = class_dev->parent;
+	struct class_interface *class_intf;
 	char *class_name = NULL;
 
-	if (parent) {
-		down(&parent->sem);
+	if (parent_class) {
+		down(&parent_class->sem);
 		list_del_init(&class_dev->node);
-		list_for_each_entry(class_intf, &parent->interfaces, node)
+		list_for_each_entry(class_intf, &parent_class->interfaces, node)
 			if (class_intf->remove)
 				class_intf->remove(class_dev, class_intf);
-		up(&parent->sem);
+		up(&parent_class->sem);
 	}
 
 	if (class_dev->dev) {
@@ -628,8 +645,8 @@
 	kobject_hotplug(&class_dev->kobj, KOBJ_REMOVE);
 	kobject_del(&class_dev->kobj);
 
-	if (parent)
-		class_put(parent);
+	class_device_put(parent_device);
+	class_put(parent_class);
 	kfree(class_name);
 }
 
@@ -709,7 +726,8 @@
 
 void class_device_put(struct class_device *class_dev)
 {
-	kobject_put(&class_dev->kobj);
+	if (class_dev)
+		kobject_put(&class_dev->kobj);
 }
 
 
--- gregkh-2.6.orig/include/linux/device.h	2005-09-28 13:56:21.000000000 -0700
+++ gregkh-2.6/include/linux/device.h	2005-09-28 13:57:10.000000000 -0700
@@ -200,6 +200,7 @@
 	struct class_device_attribute *devt_attr;
 	struct device		* dev;		/* not necessary, but nice to have */
 	void			* class_data;	/* class-specific data */
+	struct class_device	*parent;	/* parent of this child device, if there is one */
 
 	char	class_id[BUS_ID_SIZE];	/* unique to this class */
 };
@@ -260,9 +261,12 @@
 
 extern struct class *class_create(struct module *owner, char *name);
 extern void class_destroy(struct class *cls);
-extern struct class_device *class_device_create(struct class *cls, dev_t devt,
-						struct device *device, char *fmt, ...)
-					__attribute__((format(printf,4,5)));
+extern struct class_device *class_device_create(struct class *cls,
+						struct class_device *parent,
+						dev_t devt,
+						struct device *device,
+						char *fmt, ...)
+					__attribute__((format(printf,5,6)));
 extern void class_device_destroy(struct class *cls, dev_t devt);
 
 
