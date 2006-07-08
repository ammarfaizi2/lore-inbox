Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964917AbWGHR1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964917AbWGHR1S (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 13:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbWGHR1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 13:27:18 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:24238 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S964914AbWGHR1S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 13:27:18 -0400
Subject: Re: Implement class_device_update_dev() function
From: Marcel Holtmann <marcel@holtmann.org>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1152365301.29506.9.camel@localhost>
References: <1152226792.29643.8.camel@localhost>
	 <20060706235745.GA13548@kroah.com>  <1152258152.3693.8.camel@localhost>
	 <1152318397.3266.130.camel@pim.off.vrfy.org>
	 <1152350840.29506.2.camel@localhost>
	 <1152363634.3408.3.camel@pim.off.vrfy.org>
	 <1152365301.29506.9.camel@localhost>
Content-Type: multipart/mixed; boundary="=-WWDKFNUyeWGd7AsEtHeX"
Date: Sat, 08 Jul 2006 19:27:26 +0200
Message-Id: <1152379646.29506.28.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WWDKFNUyeWGd7AsEtHeX
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Kay,

> > > > > > But userspace should also find out about this change, and this patch
> > > > > > prevents that from happening.  What about just tearing down the class
> > > > > > device and creating a new one?  That way userspace knows about the new
> > > > > > linkage properly, and any device naming and permission issues can be
> > > > > > handled anew?
> > > > > 
> > > > > This won't work for Bluetooth. We create the TTY and its class device
> > > > > with tty_register_device() and then the device node is present. Then at
> > > > > some point later we open that device and the Bluetooth connection gets
> > > > > established. Only when the connection has been established we know the
> > > > > device that represents it. So tearing down the class device and creating
> > > > > a new one will screw up the application that is using this device node.
> > > > > 
> > > > > Would reissuing the uevent of the class device help here?
> > > > 
> > > > How about KOBJ_ONLINE/OFFLINE?
> > > 
> > > I am not that familiar with the internals of kobject. Can you give me an
> > > example on how to do that?
> > 
> > Just send another event (but not add or remove), for the already created
> > object. CPU hotplug uses ONLINE/OFFLINE, and we also use it to get
> > notified when the device mapper table is set up (not upstream). Udev is
> > able to update symlinks, or run actions on "online" events if asked
> > for. 
> 
> the attached patch sends ONLINE when a device has been attached to a
> class device and OFFLINE when it has been removed.

the order of ADD and ONLINE was wrong in some situations and also uevent
forgot to send out the extra ONLINE when a device is attached. The
attached patch fixes all this stuff. Any comments?

Regards

Marcel


--=-WWDKFNUyeWGd7AsEtHeX
Content-Disposition: attachment; filename=patch-class-device-update-dev
Content-Type: text/plain; name=patch-class-device-update-dev; charset=utf-8
Content-Transfer-Encoding: 7bit

[PATCH] Allow dynamically changing the device of a class device

This patch implements the class_device_update_dev() function which
allows to change the device of a class device after its creation.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>

---
commit efdb7efa5ffbbc6096ce776b909b235f70b23802
tree db15b1182a0ba7620335f474d31398c950947130
parent 120bda20c6f64b32e8bfbdd7b34feafaa5f5332e
author Marcel Holtmann <marcel@holtmann.org> Sat, 08 Jul 2006 18:59:55 +0200
committer Marcel Holtmann <marcel@holtmann.org> Sat, 08 Jul 2006 18:59:55 +0200

 drivers/base/class.c   |  111 ++++++++++++++++++++++++++++++++++++------------
 include/linux/device.h |    1 
 2 files changed, 84 insertions(+), 28 deletions(-)

diff --git a/drivers/base/class.c b/drivers/base/class.c
index de89083..866f91b 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -485,6 +485,43 @@ static void class_device_remove_groups(s
 	}
 }
 
+static int class_device_add_dev(struct class_device *class_dev)
+{
+	char *class_name = NULL;
+	int error = 0;
+
+	if (class_dev->dev) {
+		class_name = make_class_name(class_dev->class->name,
+					     &class_dev->kobj);
+		error = sysfs_create_link(&class_dev->kobj,
+					  &class_dev->dev->kobj, "device");
+		if (error)
+			goto out;
+
+		error = sysfs_create_link(&class_dev->dev->kobj,
+					  &class_dev->kobj, class_name);
+		if (error)
+			sysfs_remove_link(&class_dev->kobj, "device");
+	}
+
+ out:
+	kfree(class_name);
+	return error;
+}
+
+static void class_device_remove_dev(struct class_device *class_dev)
+{
+	char *class_name;
+
+	if (class_dev->dev) {
+		class_name = make_class_name(class_dev->class->name,
+					     &class_dev->kobj);
+		sysfs_remove_link(&class_dev->kobj, "device");
+		sysfs_remove_link(&class_dev->dev->kobj, class_name);
+		kfree(class_name);
+	}
+}
+
 static ssize_t show_dev(struct class_device *class_dev, char *buf)
 {
 	return print_dev_t(buf, class_dev->devt);
@@ -494,6 +531,10 @@ static ssize_t store_uevent(struct class
 			    const char *buf, size_t count)
 {
 	kobject_uevent(&class_dev->kobj, KOBJ_ADD);
+
+	if (class_dev->dev)
+		kobject_uevent(&class_dev->kobj, KOBJ_ONLINE);
+
 	return count;
 }
 
@@ -526,7 +567,6 @@ int class_device_add(struct class_device
 	struct class *parent_class = NULL;
 	struct class_device *parent_class_dev = NULL;
 	struct class_interface *class_intf;
-	char *class_name = NULL;
 	int error = -EINVAL;
 
 	class_dev = class_device_get(class_dev);
@@ -593,25 +633,19 @@ int class_device_add(struct class_device
 	if (error)
 		goto out5;
 
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
+	error = class_device_add_dev(class_dev);
+	if (error)
+		goto out6;
 
 	error = class_device_add_groups(class_dev);
 	if (error)
-		goto out8;
+		goto out7;
 
 	kobject_uevent(&class_dev->kobj, KOBJ_ADD);
 
+	if (class_dev->dev)
+		kobject_uevent(&class_dev->kobj, KOBJ_ONLINE);
+
 	/* notify any interfaces this device is now here */
 	down(&parent_class->sem);
 	list_add_tail(&class_dev->node, &parent_class->children);
@@ -623,12 +657,8 @@ int class_device_add(struct class_device
 
 	goto out1;
 
- out8:
-	if (class_dev->dev)
-		sysfs_remove_link(&class_dev->kobj, class_name);
  out7:
-	if (class_dev->dev)
-		sysfs_remove_link(&class_dev->kobj, "device");
+	class_device_remove_dev(class_dev);
  out6:
 	class_device_remove_attrs(class_dev);
  out5:
@@ -644,7 +674,6 @@ int class_device_add(struct class_device
 	class_put(parent_class);
  out1:
 	class_device_put(class_dev);
-	kfree(class_name);
 	return error;
 }
 
@@ -720,7 +749,6 @@ void class_device_del(struct class_devic
 	struct class *parent_class = class_dev->class;
 	struct class_device *parent_device = class_dev->parent;
 	struct class_interface *class_intf;
-	char *class_name = NULL;
 
 	if (parent_class) {
 		down(&parent_class->sem);
@@ -731,12 +759,7 @@ void class_device_del(struct class_devic
 		up(&parent_class->sem);
 	}
 
-	if (class_dev->dev) {
-		class_name = make_class_name(class_dev->class->name,
-					     &class_dev->kobj);
-		sysfs_remove_link(&class_dev->kobj, "device");
-		sysfs_remove_link(&class_dev->dev->kobj, class_name);
-	}
+	class_device_remove_dev(class_dev);
 	sysfs_remove_link(&class_dev->kobj, "subsystem");
 	class_device_remove_file(class_dev, &class_dev->uevent_attr);
 	if (class_dev->devt_attr)
@@ -744,12 +767,14 @@ void class_device_del(struct class_devic
 	class_device_remove_attrs(class_dev);
 	class_device_remove_groups(class_dev);
 
+	if (class_dev->dev)
+		kobject_uevent(&class_dev->kobj, KOBJ_OFFLINE);
+
 	kobject_uevent(&class_dev->kobj, KOBJ_REMOVE);
 	kobject_del(&class_dev->kobj);
 
 	class_device_put(parent_device);
 	class_put(parent_class);
-	kfree(class_name);
 }
 
 void class_device_unregister(struct class_device *class_dev)
@@ -821,6 +846,35 @@ int class_device_rename(struct class_dev
 	return error;
 }
 
+int class_device_update_dev(struct class_device *class_dev, struct device *dev)
+{
+	int error = 0;
+
+	class_dev = class_device_get(class_dev);
+	if (!class_dev)
+		return -EINVAL;
+
+	if (class_dev->dev != dev) {
+		if (class_dev->dev)
+			kobject_uevent(&class_dev->kobj, KOBJ_OFFLINE);
+
+		class_device_remove_dev(class_dev);
+
+		class_dev->dev = dev;
+
+		error = class_device_add_dev(class_dev);
+		if (error)
+			class_dev->dev = NULL;
+
+		if (class_dev->dev)
+			kobject_uevent(&class_dev->kobj, KOBJ_ONLINE);
+	}
+
+	class_device_put(class_dev);
+
+	return error;
+}
+
 struct class_device * class_device_get(struct class_device *class_dev)
 {
 	if (class_dev)
@@ -911,6 +965,7 @@ EXPORT_SYMBOL_GPL(class_device_get);
 EXPORT_SYMBOL_GPL(class_device_put);
 EXPORT_SYMBOL_GPL(class_device_create);
 EXPORT_SYMBOL_GPL(class_device_destroy);
+EXPORT_SYMBOL_GPL(class_device_update_dev);
 EXPORT_SYMBOL_GPL(class_device_create_file);
 EXPORT_SYMBOL_GPL(class_device_remove_file);
 EXPORT_SYMBOL_GPL(class_device_create_bin_file);
diff --git a/include/linux/device.h b/include/linux/device.h
index 1e5f30d..d76072b 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -249,6 +249,7 @@ extern int class_device_add(struct class
 extern void class_device_del(struct class_device *);
 
 extern int class_device_rename(struct class_device *, char *);
+extern int class_device_update_dev(struct class_device *, struct device *);
 
 extern struct class_device * class_device_get(struct class_device *);
 extern void class_device_put(struct class_device *);

--=-WWDKFNUyeWGd7AsEtHeX--

