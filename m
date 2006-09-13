Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbWIMQiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbWIMQiQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 12:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbWIMQiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 12:38:15 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:33206 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750721AbWIMQiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 12:38:14 -0400
Date: Wed, 13 Sep 2006 18:38:34 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Greg K-H <greg@kroah.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [01/12] driver core fixes: make_class_name() retval check
Message-ID: <20060913183834.3a71bbbe@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <20060913163007.21cf10a8@gondolin.boeblingen.de.ibm.com>
References: <20060913163007.21cf10a8@gondolin.boeblingen.de.ibm.com>
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

make_class_name() may return an error pointer. Audit the callers in the
driver core.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

 class.c |   11 ++++++++++-
 core.c  |   31 +++++++++++++++++++++++--------
 2 files changed, 33 insertions(+), 9 deletions(-)

diff -Naurp linux-2.6.18-rc6/drivers/base/class.c linux-2.6.18-rc6+CH/drivers/base/class.c
--- linux-2.6.18-rc6/drivers/base/class.c	2006-09-12 14:18:40.000000000 +0200
+++ linux-2.6.18-rc6+CH/drivers/base/class.c	2006-09-12 16:17:02.000000000 +0200
@@ -596,6 +596,11 @@ int class_device_add(struct class_device
 	if (class_dev->dev) {
 		class_name = make_class_name(class_dev->class->name,
 					     &class_dev->kobj);
+		if (IS_ERR(class_name)) {
+			error = PTR_ERR(class_name);
+			class_name = NULL;
+			goto out6;
+		}
 		error = sysfs_create_link(&class_dev->kobj,
 					  &class_dev->dev->kobj, "device");
 		if (error)
@@ -736,7 +741,11 @@ void class_device_del(struct class_devic
 		class_name = make_class_name(class_dev->class->name,
 					     &class_dev->kobj);
 		sysfs_remove_link(&class_dev->kobj, "device");
-		sysfs_remove_link(&class_dev->dev->kobj, class_name);
+		if (!IS_ERR(class_name))
+			sysfs_remove_link(&class_dev->dev->kobj, class_name);
+		else
+			/* Hmm, don't know what else to do */
+			class_name = NULL;
 	}
 	sysfs_remove_link(&class_dev->kobj, "subsystem");
 	class_device_remove_file(class_dev, &class_dev->uevent_attr);
diff -Naurp linux-2.6.18-rc6/drivers/base/core.c linux-2.6.18-rc6+CH/drivers/base/core.c
--- linux-2.6.18-rc6/drivers/base/core.c	2006-09-12 14:18:57.000000000 +0200
+++ linux-2.6.18-rc6+CH/drivers/base/core.c	2006-09-12 16:17:02.000000000 +0200
@@ -437,7 +437,11 @@ int device_add(struct device *dev)
 		if ((parent) && (!device_is_virtual(dev))) {
 			sysfs_create_link(&dev->kobj, &dev->parent->kobj, "device");
 			class_name = make_class_name(dev->class->name, &dev->kobj);
-			sysfs_create_link(&dev->parent->kobj, &dev->kobj, class_name);
+			if (!IS_ERR(class_name))
+				sysfs_create_link(&dev->parent->kobj,
+						  &dev->kobj, class_name);
+			else
+				class_name = NULL;
 		}
 	}
 
@@ -557,12 +561,16 @@ void device_del(struct device * dev)
 	if (dev->class) {
 		sysfs_remove_link(&dev->kobj, "subsystem");
 		sysfs_remove_link(&dev->class->subsys.kset.kobj, dev->bus_id);
-		class_name = make_class_name(dev->class->name, &dev->kobj);
 		if ((parent) && (!device_is_virtual(dev))) {
+			class_name = make_class_name(dev->class->name,
+						     &dev->kobj);
 			sysfs_remove_link(&dev->kobj, "device");
-			sysfs_remove_link(&dev->parent->kobj, class_name);
+			if (!IS_ERR(class_name)) {
+				sysfs_remove_link(&dev->parent->kobj,
+						  class_name);
+				kfree(class_name);
+			}
 		}
-		kfree(class_name);
 		down(&dev->class->sem);
 		list_del_init(&dev->node);
 		up(&dev->class->sem);
@@ -763,9 +771,14 @@ int device_rename(struct device *dev, ch
 
 	pr_debug("DEVICE: renaming '%s' to '%s'\n", dev->bus_id, new_name);
 
-	if ((dev->class) && (dev->parent))
+	if ((dev->class) && (dev->parent)) {
 		old_class_name = make_class_name(dev->class->name, &dev->kobj);
-
+		if (IS_ERR(old_class_name)) {
+			error = PTR_ERR(old_class_name);
+			old_class_name = NULL;
+			goto out;
+		}
+	}
 	if (dev->class) {
 		old_symlink_name = kmalloc(BUS_ID_SIZE, GFP_KERNEL);
 		if (!old_symlink_name)
@@ -779,11 +792,12 @@ int device_rename(struct device *dev, ch
 
 	if (old_class_name) {
 		new_class_name = make_class_name(dev->class->name, &dev->kobj);
-		if (new_class_name) {
+		if (!IS_ERR(new_class_name)) {
 			sysfs_create_link(&dev->parent->kobj, &dev->kobj,
 					  new_class_name);
 			sysfs_remove_link(&dev->parent->kobj, old_class_name);
-		}
+		} else
+			new_class_name = NULL;
 	}
 	if (dev->class) {
 		sysfs_remove_link(&dev->class->subsys.kset.kobj,
@@ -791,6 +805,7 @@ int device_rename(struct device *dev, ch
 		sysfs_create_link(&dev->class->subsys.kset.kobj, &dev->kobj,
 				  dev->bus_id);
 	}
+out:
 	put_device(dev);
 
 	kfree(old_class_name);
