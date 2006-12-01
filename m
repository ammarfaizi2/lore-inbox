Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162403AbWLAXfH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162403AbWLAXfH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 18:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162262AbWLAXea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 18:34:30 -0500
Received: from mail.suse.de ([195.135.220.2]:17549 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1162251AbWLAXWy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 18:22:54 -0500
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 12/36] Driver core: change misc class_devices to be real devices
Date: Fri,  1 Dec 2006 15:21:42 -0800
Message-Id: <11650153631070-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.4.1
In-Reply-To: <11650153591876-git-send-email-greg@kroah.com>
References: <20061201231620.GA7560@kroah.com> <11650153262399-git-send-email-greg@kroah.com> <11650153293531-git-send-email-greg@kroah.com> <1165015333344-git-send-email-greg@kroah.com> <11650153362310-git-send-email-greg@kroah.com> <11650153392022-git-send-email-greg@kroah.com> <11650153432284-git-send-email-greg@kroah.com> <11650153463092-git-send-email-greg@kroah.com> <1165015349830-git-send-email-greg@kroah.com> <11650153522862-git-send-email-greg@kroah.com> <116501535622-git-send-email-greg@kroah.com> <11650153591876-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

This also ment that some of the misc drivers had to also be fixed
up as they were assuming the device was a class_device.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/char/hw_random/core.c   |   38 +++++++++++++++++++-------------------
 drivers/char/misc.c             |   13 ++++---------
 drivers/char/tpm/tpm.c          |    2 +-
 drivers/input/serio/serio_raw.c |    2 +-
 include/linux/miscdevice.h      |    5 ++---
 5 files changed, 27 insertions(+), 33 deletions(-)

diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index 154a81d..ebace20 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -162,7 +162,8 @@ static struct miscdevice rng_miscdev = {
 };
 
 
-static ssize_t hwrng_attr_current_store(struct class_device *class,
+static ssize_t hwrng_attr_current_store(struct device *dev,
+					struct device_attribute *attr,
 					const char *buf, size_t len)
 {
 	int err;
@@ -192,7 +193,8 @@ static ssize_t hwrng_attr_current_store(
 	return err ? : len;
 }
 
-static ssize_t hwrng_attr_current_show(struct class_device *class,
+static ssize_t hwrng_attr_current_show(struct device *dev,
+				       struct device_attribute *attr,
 				       char *buf)
 {
 	int err;
@@ -210,7 +212,8 @@ static ssize_t hwrng_attr_current_show(s
 	return ret;
 }
 
-static ssize_t hwrng_attr_available_show(struct class_device *class,
+static ssize_t hwrng_attr_available_show(struct device *dev,
+					 struct device_attribute *attr,
 					 char *buf)
 {
 	int err;
@@ -234,20 +237,18 @@ static ssize_t hwrng_attr_available_show
 	return ret;
 }
 
-static CLASS_DEVICE_ATTR(rng_current, S_IRUGO | S_IWUSR,
-			 hwrng_attr_current_show,
-			 hwrng_attr_current_store);
-static CLASS_DEVICE_ATTR(rng_available, S_IRUGO,
-			 hwrng_attr_available_show,
-			 NULL);
+static DEVICE_ATTR(rng_current, S_IRUGO | S_IWUSR,
+		   hwrng_attr_current_show,
+		   hwrng_attr_current_store);
+static DEVICE_ATTR(rng_available, S_IRUGO,
+		   hwrng_attr_available_show,
+		   NULL);
 
 
 static void unregister_miscdev(void)
 {
-	class_device_remove_file(rng_miscdev.class,
-				 &class_device_attr_rng_available);
-	class_device_remove_file(rng_miscdev.class,
-				 &class_device_attr_rng_current);
+	device_remove_file(rng_miscdev.this_device, &dev_attr_rng_available);
+	device_remove_file(rng_miscdev.this_device, &dev_attr_rng_current);
 	misc_deregister(&rng_miscdev);
 }
 
@@ -258,20 +259,19 @@ static int register_miscdev(void)
 	err = misc_register(&rng_miscdev);
 	if (err)
 		goto out;
-	err = class_device_create_file(rng_miscdev.class,
-				       &class_device_attr_rng_current);
+	err = device_create_file(rng_miscdev.this_device,
+				 &dev_attr_rng_current);
 	if (err)
 		goto err_misc_dereg;
-	err = class_device_create_file(rng_miscdev.class,
-				       &class_device_attr_rng_available);
+	err = device_create_file(rng_miscdev.this_device,
+				 &dev_attr_rng_available);
 	if (err)
 		goto err_remove_current;
 out:
 	return err;
 
 err_remove_current:
-	class_device_remove_file(rng_miscdev.class,
-				 &class_device_attr_rng_current);
+	device_remove_file(rng_miscdev.this_device, &dev_attr_rng_current);
 err_misc_dereg:
 	misc_deregister(&rng_miscdev);
 	goto out;
diff --git a/drivers/char/misc.c b/drivers/char/misc.c
index 62ebe09..7a484fc 100644
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -169,11 +169,6 @@ fail:
 	return err;
 }
 
-/* 
- * TODO for 2.7:
- *  - add a struct kref to struct miscdevice and make all usages of
- *    them dynamic.
- */
 static struct class *misc_class;
 
 static const struct file_operations misc_fops = {
@@ -228,10 +223,10 @@ int misc_register(struct miscdevice * mi
 		misc_minors[misc->minor >> 3] |= 1 << (misc->minor & 7);
 	dev = MKDEV(MISC_MAJOR, misc->minor);
 
-	misc->class = class_device_create(misc_class, NULL, dev, misc->dev,
+	misc->this_device = device_create(misc_class, misc->parent, dev,
 					  "%s", misc->name);
-	if (IS_ERR(misc->class)) {
-		err = PTR_ERR(misc->class);
+	if (IS_ERR(misc->this_device)) {
+		err = PTR_ERR(misc->this_device);
 		goto out;
 	}
 
@@ -264,7 +259,7 @@ int misc_deregister(struct miscdevice *
 
 	down(&misc_sem);
 	list_del(&misc->list);
-	class_device_destroy(misc_class, MKDEV(MISC_MAJOR, misc->minor));
+	device_destroy(misc_class, MKDEV(MISC_MAJOR, misc->minor));
 	if (i < DYNAMIC_MINORS && i>0) {
 		misc_minors[i>>3] &= ~(1 << (misc->minor & 7));
 	}
diff --git a/drivers/char/tpm/tpm.c b/drivers/char/tpm/tpm.c
index 6ad2d3b..6e1329d 100644
--- a/drivers/char/tpm/tpm.c
+++ b/drivers/char/tpm/tpm.c
@@ -1130,7 +1130,7 @@ struct tpm_chip *tpm_register_hardware(s
 	scnprintf(devname, DEVNAME_SIZE, "%s%d", "tpm", chip->dev_num);
 	chip->vendor.miscdev.name = devname;
 
-	chip->vendor.miscdev.dev = dev;
+	chip->vendor.miscdev.parent = dev;
 	chip->dev = get_device(dev);
 
 	if (misc_register(&chip->vendor.miscdev)) {
diff --git a/drivers/input/serio/serio_raw.c b/drivers/input/serio/serio_raw.c
index ba2a203..7c8d039 100644
--- a/drivers/input/serio/serio_raw.c
+++ b/drivers/input/serio/serio_raw.c
@@ -297,7 +297,7 @@ static int serio_raw_connect(struct seri
 
 	serio_raw->dev.minor = PSMOUSE_MINOR;
 	serio_raw->dev.name = serio_raw->name;
-	serio_raw->dev.dev = &serio->dev;
+	serio_raw->dev.parent = &serio->dev;
 	serio_raw->dev.fops = &serio_raw_fops;
 
 	err = misc_register(&serio_raw->dev);
diff --git a/include/linux/miscdevice.h b/include/linux/miscdevice.h
index b03cfb9..326da7d 100644
--- a/include/linux/miscdevice.h
+++ b/include/linux/miscdevice.h
@@ -31,15 +31,14 @@
 #define	HPET_MINOR	     228
 
 struct device;
-struct class_device;
 
 struct miscdevice  {
 	int minor;
 	const char *name;
 	const struct file_operations *fops;
 	struct list_head list;
-	struct device *dev;
-	struct class_device *class;
+	struct device *parent;
+	struct device *this_device;
 };
 
 extern int misc_register(struct miscdevice * misc);
-- 
1.4.4.1

