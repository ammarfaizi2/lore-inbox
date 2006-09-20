Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbWITBbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWITBbN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 21:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbWITBbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 21:31:12 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:4019 "EHLO
	asav08.insightbb.com") by vger.kernel.org with ESMTP
	id S1750710AbWITBbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 21:31:11 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aa4HAHY2EEWBToocLA
From: Dmitry Torokhov <dtor@insightbb.com>
To: Greg KH <greg@kroah.com>
Subject: Re: 2.6.18-rc7-mm1: networking breakage on HPC nx6325 + SUSE 10.1
Date: Tue, 19 Sep 2006 21:31:00 -0400
User-Agent: KMail/1.9.3
Cc: David Miller <davem@davemloft.net>, rjw@sisk.pl, akpm@osdl.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20060919133606.f0c92e66.akpm@osdl.org> <20060919.150629.109607267.davem@davemloft.net> <20060919223015.GA23088@kroah.com>
In-Reply-To: <20060919223015.GA23088@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609192131.01609.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 September 2006 18:30, Greg KH wrote:
> On Tue, Sep 19, 2006 at 03:06:29PM -0700, David Miller wrote:
> > From: "Rafael J. Wysocki" <rjw@sisk.pl>
> > Date: Wed, 20 Sep 2006 00:06:52 +0200
> > 
> > > I _guess_ the problem is caused by
> > > gregkh-driver-network-class_device-to-device.patch, but I can't verify this,
> > > because the kernel (obviously) doesn't compile if I revert it.
> > 
> > Indeed.
> > 
> > I thought we threw this patch out because we knew it would cause
> > problems for existing systems?  I do remember Greg making an argument
> > as to why we needed the change, but that doesn't make breaking people's
> > systems legitimate in any way.
> 
> It's now thrown out, and I think Andrew already had a patch in his tree
> that reverted this.
> 
> I'll be bringing it back eventually, but first we are going to work out
> all the kinks by probably putting these changes in the next few SuSE
> alpha releases to see what shakes out in userspace that we need to go
> fix.
> 

Greg,

Could you please comment on the patch below which is I believe achieves
the desired result - produces unified sysfs representation of kernel
device tree - without major reshuffle of every kernel subsystem.

-- 
Dmitry


Driver core: move class_device to /sys/device/... part of the tree

Move sysfs representation of class_device structure from /sys/class/...
to /sys/device/... to provide unified device tree; create symlinks
in /sys/class pointing to /sys/device/... to preserve existing
classification of devices.

Create /sys/device/virtual device which is parent for all class_devices
that do not have real parent device.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/base/class.c |  154 ++++++++++++++++++++++++---------------------------
 1 files changed, 73 insertions(+), 81 deletions(-)

Index: work/drivers/base/class.c
===================================================================
--- work.orig/drivers/base/class.c
+++ work/drivers/base/class.c
@@ -521,60 +521,73 @@ char *make_class_name(const char *name, 
 	return class_name;
 }
 
+static struct device virtual_device = {
+	.bus_id = "virtual",
+};
+
 int class_device_add(struct class_device *class_dev)
 {
-	struct class *parent_class = NULL;
+	struct class *parent_class;
 	struct class_device *parent_class_dev = NULL;
+	struct device *parent_dev = NULL;
 	struct class_interface *class_intf;
-	char *class_name = NULL;
 	int error = -EINVAL;
 
-	class_dev = class_device_get(class_dev);
-	if (!class_dev)
-		return -EINVAL;
-
 	if (!strlen(class_dev->class_id))
-		goto out1;
+		return -EINVAL;
 
 	parent_class = class_get(class_dev->class);
 	if (!parent_class)
-		goto out1;
-
-	parent_class_dev = class_device_get(class_dev->parent);
+		return -EINVAL;
 
 	pr_debug("CLASS: registering class device: ID = '%s'\n",
 		 class_dev->class_id);
 
+	parent_class_dev = class_device_get(class_dev->parent);
+
+	if (!class_dev->dev)
+		class_dev->dev = &virtual_device;
+	parent_dev = get_device(class_dev->dev);
+
 	/* first, register with generic layer. */
 	error = kobject_set_name(&class_dev->kobj, "%s", class_dev->class_id);
 	if (error)
-		goto out2;
+		goto err_put_parents;
 
-	if (parent_class_dev)
-		class_dev->kobj.parent = &parent_class_dev->kobj;
-	else
-		class_dev->kobj.parent = &parent_class->subsys.kset.kobj;
+	class_dev->kobj.parent = parent_class_dev ?
+			&parent_class_dev->kobj : &parent_dev->kobj;
 
 	error = kobject_add(&class_dev->kobj);
 	if (error)
-		goto out2;
+		goto err_put_parents;
 
 	/* add the needed attributes to this device */
-	sysfs_create_link(&class_dev->kobj, &parent_class->subsys.kset.kobj, "subsystem");
+	error = sysfs_create_link(&class_dev->kobj,
+				  &parent_class->subsys.kset.kobj,
+				  "subsystem");
+	if (error)
+		goto err_del_kobject;
+
+	error = sysfs_create_link(&parent_class->subsys.kset.kobj,
+				  &class_dev->kobj,
+				  class_dev->class_id);
+	if (error)
+		goto err_del_subsys_link;
+
 	class_dev->uevent_attr.attr.name = "uevent";
 	class_dev->uevent_attr.attr.mode = S_IWUSR;
 	class_dev->uevent_attr.attr.owner = parent_class->owner;
 	class_dev->uevent_attr.store = store_uevent;
 	error = class_device_create_file(class_dev, &class_dev->uevent_attr);
 	if (error)
-		goto out3;
+		goto err_del_class_link;
 
 	if (MAJOR(class_dev->devt)) {
 		struct class_device_attribute *attr;
 		attr = kzalloc(sizeof(*attr), GFP_KERNEL);
 		if (!attr) {
 			error = -ENOMEM;
-			goto out4;
+			goto err_del_uevent_attr;
 		}
 		attr->attr.name = "dev";
 		attr->attr.mode = S_IRUGO;
@@ -583,7 +596,7 @@ int class_device_add(struct class_device
 		error = class_device_create_file(class_dev, attr);
 		if (error) {
 			kfree(attr);
-			goto out4;
+			goto err_del_uevent_attr;
 		}
 
 		class_dev->devt_attr = attr;
@@ -591,24 +604,11 @@ int class_device_add(struct class_device
 
 	error = class_device_add_attrs(class_dev);
 	if (error)
-		goto out5;
-
-	if (class_dev->dev) {
-		class_name = make_class_name(class_dev->class->name,
-					     &class_dev->kobj);
-		error = sysfs_create_link(&class_dev->kobj,
-					  &class_dev->dev->kobj, "device");
-		if (error)
-			goto out6;
-		error = sysfs_create_link(&class_dev->dev->kobj, &class_dev->kobj,
-					  class_name);
-		if (error)
-			goto out7;
-	}
+		goto err_del_devt_attr;
 
 	error = class_device_add_groups(class_dev);
 	if (error)
-		goto out8;
+		goto err_del_attrs;
 
 	kobject_uevent(&class_dev->kobj, KOBJ_ADD);
 
@@ -621,30 +621,26 @@ int class_device_add(struct class_device
 	}
 	up(&parent_class->sem);
 
-	goto out1;
+	return 0;
 
- out8:
-	if (class_dev->dev)
-		sysfs_remove_link(&class_dev->kobj, class_name);
- out7:
-	if (class_dev->dev)
-		sysfs_remove_link(&class_dev->kobj, "device");
- out6:
+ err_del_attrs:
 	class_device_remove_attrs(class_dev);
- out5:
+ err_del_devt_attr:
 	if (class_dev->devt_attr)
 		class_device_remove_file(class_dev, class_dev->devt_attr);
- out4:
+ err_del_uevent_attr:
 	class_device_remove_file(class_dev, &class_dev->uevent_attr);
- out3:
+ err_del_class_link:
+	sysfs_remove_link(&parent_class->subsys.kset.kobj, class_dev->class_id);
+ err_del_subsys_link:
+	sysfs_remove_link(&class_dev->kobj, "subsystem");
+ err_del_kobject:
 	kobject_del(&class_dev->kobj);
- out2:
-	if(parent_class_dev)
-		class_device_put(parent_class_dev);
+ err_put_parents:
+	class_device_put(parent_class_dev);
+	put_device(parent_dev);
 	class_put(parent_class);
- out1:
-	class_device_put(class_dev);
-	kfree(class_name);
+
 	return error;
 }
 
@@ -718,7 +714,8 @@ error:
 void class_device_del(struct class_device *class_dev)
 {
 	struct class *parent_class = class_dev->class;
-	struct class_device *parent_device = class_dev->parent;
+	struct class_device *parent_class_device = class_dev->parent;
+	struct device *parent_device = class_dev->dev;
 	struct class_interface *class_intf;
 	char *class_name = NULL;
 
@@ -731,12 +728,8 @@ void class_device_del(struct class_devic
 		up(&parent_class->sem);
 	}
 
-	if (class_dev->dev) {
-		class_name = make_class_name(class_dev->class->name,
-					     &class_dev->kobj);
-		sysfs_remove_link(&class_dev->kobj, "device");
-		sysfs_remove_link(&class_dev->dev->kobj, class_name);
-	}
+	sysfs_remove_link(&parent_class->subsys.kset.kobj,
+			  class_dev->class_id);
 	sysfs_remove_link(&class_dev->kobj, "subsystem");
 	class_device_remove_file(class_dev, &class_dev->uevent_attr);
 	if (class_dev->devt_attr)
@@ -747,7 +740,8 @@ void class_device_del(struct class_devic
 	kobject_uevent(&class_dev->kobj, KOBJ_REMOVE);
 	kobject_del(&class_dev->kobj);
 
-	class_device_put(parent_device);
+	put_device(parent_device);
+	class_device_put(parent_class_device);
 	class_put(parent_class);
 	kfree(class_name);
 }
@@ -788,36 +782,30 @@ void class_device_destroy(struct class *
 
 int class_device_rename(struct class_device *class_dev, char *new_name)
 {
-	int error = 0;
-	char *old_class_name = NULL, *new_class_name = NULL;
-
-	class_dev = class_device_get(class_dev);
-	if (!class_dev)
-		return -EINVAL;
+	int error;
+	char *old_name;
 
 	pr_debug("CLASS: renaming '%s' to '%s'\n", class_dev->class_id,
 		 new_name);
 
-	if (class_dev->dev)
-		old_class_name = make_class_name(class_dev->class->name,
-						 &class_dev->kobj);
+	old_name = kstrdup(class_dev->class_id, GFP_KERNEL);
+	if (!old_name)
+		return -ENOMEM;
 
 	strlcpy(class_dev->class_id, new_name, KOBJ_NAME_LEN);
 
 	error = kobject_rename(&class_dev->kobj, new_name);
-
-	if (class_dev->dev) {
-		new_class_name = make_class_name(class_dev->class->name,
-						 &class_dev->kobj);
-		sysfs_create_link(&class_dev->dev->kobj, &class_dev->kobj,
-				  new_class_name);
-		sysfs_remove_link(&class_dev->dev->kobj, old_class_name);
+	if (error) {
+		strlcpy(class_dev->class_id, old_name, KOBJ_NAME_LEN);
+		goto out;
 	}
-	class_device_put(class_dev);
 
-	kfree(old_class_name);
-	kfree(new_class_name);
+	sysfs_create_link(&class_dev->class->subsys.kset.kobj,
+			  &class_dev->kobj, new_name);
+	sysfs_remove_link(&class_dev->class->subsys.kset.kobj, old_name);
 
+ out:
+	kfree(old_name);
 	return error;
 }
 
@@ -877,8 +865,6 @@ void class_interface_unregister(struct c
 	class_put(parent);
 }
 
-
-
 int __init classes_init(void)
 {
 	int retval;
@@ -892,6 +878,12 @@ int __init classes_init(void)
 	subsystem_init(&class_obj_subsys);
 	if (!class_obj_subsys.kset.subsys)
 			class_obj_subsys.kset.subsys = &class_obj_subsys;
+
+	retval = device_register(&virtual_device);
+	if (retval)
+		printk(KERN_ERR "Failed to register virtual device, err: %d\n",
+			retval);
+
 	return 0;
 }
 
