Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965109AbVJ1GmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965109AbVJ1GmJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 02:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965137AbVJ1GiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 02:38:23 -0400
Received: from mail.kroah.org ([69.55.234.183]:38634 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965135AbVJ1GbU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 02:31:20 -0400
Cc: gregkh@suse.de
Subject: [PATCH] Driver Core: add the ability for class_device structures to be nested
In-Reply-To: <11304810233187@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 27 Oct 2005 23:30:23 -0700
Message-Id: <11304810232592@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Driver Core: add the ability for class_device structures to be nested

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

---
commit a82c307b63c2e516090c702ed409cb89ef633a1c
tree 51f0bd8fd7cb2204d2d0826f50fc8672b2fe9169
parent d54bc6daa47cc8821fee219877916b32119ab919
author Greg Kroah-Hartman <gregkh@suse.de> Thu, 27 Oct 2005 22:25:43 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 27 Oct 2005 22:48:01 -0700

 drivers/base/class.c   |  125 +++++++++++++++++++++++++++++++-----------------
 include/linux/device.h |   13 ++++-
 2 files changed, 91 insertions(+), 47 deletions(-)

diff --git a/drivers/base/class.c b/drivers/base/class.c
index 3cf6eb3..c3e5697 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -99,7 +99,8 @@ struct class * class_get(struct class * 
 
 void class_put(struct class * cls)
 {
-	subsys_put(&cls->subsys);
+	if (cls)
+		subsys_put(&cls->subsys);
 }
 
 
@@ -165,14 +166,25 @@ void class_unregister(struct class * cls
 
 static void class_create_release(struct class *cls)
 {
+	pr_debug("%s called for %s\n", __FUNCTION__, cls->name);
 	kfree(cls);
 }
 
 static void class_device_create_release(struct class_device *class_dev)
 {
+	pr_debug("%s called for %s\n", __FUNCTION__, class_dev->class_id);
 	kfree(class_dev);
 }
 
+/* needed to allow these devices to have parent class devices */
+static int class_device_create_hotplug(struct class_device *class_dev,
+				       char **envp, int num_envp,
+				       char *buffer, int buffer_size)
+{
+	pr_debug("%s called for %s\n", __FUNCTION__, class_dev->class_id);
+	return 0;
+}
+
 /**
  * class_create - create a struct class structure
  * @owner: pointer to the module that is to "own" this struct class
@@ -301,10 +313,12 @@ static void class_dev_release(struct kob
 	kfree(cd->devt_attr);
 	cd->devt_attr = NULL;
 
-	if (cls->release)
+	if (cd->release)
+		cd->release(cd);
+	else if (cls->release)
 		cls->release(cd);
 	else {
-		printk(KERN_ERR "Device class '%s' does not have a release() function, "
+		printk(KERN_ERR "Class Device '%s' does not have a release() function, "
 			"it is broken and must be fixed.\n",
 			cd->class_id);
 		WARN_ON(1);
@@ -382,14 +396,18 @@ static int class_hotplug(struct kset *ks
 	buffer = &buffer[length];
 	buffer_size -= length;
 
-	if (class_dev->class->hotplug) {
-		/* have the bus specific function add its stuff */
-		retval = class_dev->class->hotplug (class_dev, envp, num_envp,
-						    buffer, buffer_size);
-			if (retval) {
-			pr_debug ("%s - hotplug() returned %d\n",
-				  __FUNCTION__, retval);
-		}
+	if (class_dev->hotplug) {
+		/* have the class device specific function add its stuff */
+		retval = class_dev->hotplug(class_dev, envp, num_envp,
+					    buffer, buffer_size);
+		if (retval)
+			pr_debug("class_dev->hotplug() returned %d\n", retval);
+	} else if (class_dev->class->hotplug) {
+		/* have the class specific function add its stuff */
+		retval = class_dev->class->hotplug(class_dev, envp, num_envp,
+						   buffer, buffer_size);
+		if (retval)
+			pr_debug("class->hotplug() returned %d\n", retval);
 	}
 
 	return retval;
@@ -476,37 +494,42 @@ static char *make_class_name(struct clas
 
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
 	class_dev->uevent_attr.attr.name = "uevent";
 	class_dev->uevent_attr.attr.mode = S_IWUSR;
-	class_dev->uevent_attr.attr.owner = parent->owner;
+	class_dev->uevent_attr.attr.owner = parent_class->owner;
 	class_dev->uevent_attr.store = store_uevent;
 	class_device_create_file(class_dev, &class_dev->uevent_attr);
 
@@ -520,7 +543,7 @@ int class_device_add(struct class_device
 		}
 		attr->attr.name = "dev";
 		attr->attr.mode = S_IRUGO;
-		attr->attr.owner = parent->owner;
+		attr->attr.owner = parent_class->owner;
 		attr->show = show_dev;
 		class_device_create_file(class_dev, attr);
 		class_dev->devt_attr = attr;
@@ -538,18 +561,20 @@ int class_device_add(struct class_device
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
@@ -564,21 +589,28 @@ int class_device_register(struct class_d
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
@@ -597,6 +629,9 @@ struct class_device *class_device_create
 	class_dev->devt = devt;
 	class_dev->dev = device;
 	class_dev->class = cls;
+	class_dev->parent = parent;
+	class_dev->release = class_device_create_release;
+	class_dev->hotplug = class_device_create_hotplug;
 
 	va_start(args, fmt);
 	vsnprintf(class_dev->class_id, BUS_ID_SIZE, fmt, args);
@@ -614,17 +649,18 @@ error:
 
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
@@ -640,8 +676,8 @@ void class_device_del(struct class_devic
 	kobject_hotplug(&class_dev->kobj, KOBJ_REMOVE);
 	kobject_del(&class_dev->kobj);
 
-	if (parent)
-		class_put(parent);
+	class_device_put(parent_device);
+	class_put(parent_class);
 	kfree(class_name);
 }
 
@@ -721,7 +757,8 @@ struct class_device * class_device_get(s
 
 void class_device_put(struct class_device *class_dev)
 {
-	kobject_put(&class_dev->kobj);
+	if (class_dev)
+		kobject_put(&class_dev->kobj);
 }
 
 
diff --git a/include/linux/device.h b/include/linux/device.h
index e86a580..226e550 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -213,7 +213,11 @@ struct class_device {
 	struct class_device_attribute uevent_attr;
 	struct device		* dev;		/* not necessary, but nice to have */
 	void			* class_data;	/* class-specific data */
+	struct class_device	*parent;	/* parent of this child device, if there is one */
 
+	void	(*release)(struct class_device *dev);
+	int	(*hotplug)(struct class_device *dev, char **envp,
+			   int num_envp, char *buffer, int buffer_size);
 	char	class_id[BUS_ID_SIZE];	/* unique to this class */
 };
 
@@ -261,9 +265,12 @@ extern void class_interface_unregister(s
 
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
 
 

