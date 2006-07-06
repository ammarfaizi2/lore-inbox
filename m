Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751009AbWGFW7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbWGFW7u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 18:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751007AbWGFW7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 18:59:50 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:6565 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1751008AbWGFW7t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 18:59:49 -0400
Subject: Implement class_device_update_dev() function
From: Marcel Holtmann <marcel@holtmann.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-SM68Z+rnIur7/G1qd+uE"
Date: Fri, 07 Jul 2006 00:59:52 +0200
Message-Id: <1152226792.29643.8.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-SM68Z+rnIur7/G1qd+uE
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Greg,

for the Bluetooth subsystem integration into the driver model it is
required that we can update the device of a class device at any time.

For the RFCOMM TTY device for example we create the TTY device and only
when it got opened we create the Bluetooth connection. Once this new
connection has been created we have a device to attach to the class
device of the TTY.

I came up with the attached patch and it worked fine with the Bluetooth
RFCOMM layer.

Regards

Marcel


--=-SM68Z+rnIur7/G1qd+uE
Content-Disposition: attachment; filename=patch-class-device-update-dev
Content-Type: text/plain; name=patch-class-device-update-dev; charset=UTF-8
Content-Transfer-Encoding: 7bit

[PATCH] Allow dynamically changing the device of a class device

This patch implements the class_device_update_dev() function which
allows to change the device of a class device after its creation.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>

---
commit 0a887bfed61fe16e47a57f11144ef830eef86c5f
tree 0c520a89cdef0260d2dd5ed9aa60debac3e3cee9
parent 120bda20c6f64b32e8bfbdd7b34feafaa5f5332e
author Marcel Holtmann <marcel@holtmann.org> Fri, 07 Jul 2006 00:44:41 +0200
committer Marcel Holtmann <marcel@holtmann.org> Fri, 07 Jul 2006 00:44:41 +0200

 drivers/base/class.c   |   93 ++++++++++++++++++++++++++++++++++--------------
 include/linux/device.h |    1 +
 2 files changed, 66 insertions(+), 28 deletions(-)

diff --git a/drivers/base/class.c b/drivers/base/class.c
index de89083..33956ae 100644
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
@@ -526,7 +563,6 @@ int class_device_add(struct class_device
 	struct class *parent_class = NULL;
 	struct class_device *parent_class_dev = NULL;
 	struct class_interface *class_intf;
-	char *class_name = NULL;
 	int error = -EINVAL;
 
 	class_dev = class_device_get(class_dev);
@@ -593,22 +629,13 @@ int class_device_add(struct class_device
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
 
@@ -623,12 +650,8 @@ int class_device_add(struct class_device
 
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
@@ -644,7 +667,6 @@ int class_device_add(struct class_device
 	class_put(parent_class);
  out1:
 	class_device_put(class_dev);
-	kfree(class_name);
 	return error;
 }
 
@@ -720,7 +742,6 @@ void class_device_del(struct class_devic
 	struct class *parent_class = class_dev->class;
 	struct class_device *parent_device = class_dev->parent;
 	struct class_interface *class_intf;
-	char *class_name = NULL;
 
 	if (parent_class) {
 		down(&parent_class->sem);
@@ -731,12 +752,7 @@ void class_device_del(struct class_devic
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
@@ -749,7 +765,6 @@ void class_device_del(struct class_devic
 
 	class_device_put(parent_device);
 	class_put(parent_class);
-	kfree(class_name);
 }
 
 void class_device_unregister(struct class_device *class_dev)
@@ -821,6 +836,27 @@ int class_device_rename(struct class_dev
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
+		class_device_remove_dev(class_dev);
+
+		class_dev->dev = dev;
+
+		error = class_device_add_dev(class_dev);
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
@@ -911,6 +947,7 @@ EXPORT_SYMBOL_GPL(class_device_get);
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

--=-SM68Z+rnIur7/G1qd+uE--

