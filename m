Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757564AbWK0Je3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757564AbWK0Je3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 04:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757565AbWK0Je3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 04:34:29 -0500
Received: from mtagate5.de.ibm.com ([195.212.29.154]:45521 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1757564AbWK0Je2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 04:34:28 -0500
Date: Mon, 27 Nov 2006 10:35:05 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Greg K-H <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Patch 1/7] driver core fixes: make_class_name() retval checks
Message-ID: <20061127103505.220cc792@gondolin.boeblingen.de.ibm.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Make make_class_name() return NULL on error and fixup callers in the
driver core.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

---

 drivers/base/class.c |   21 ++++++++++++++-------
 drivers/base/core.c  |   17 +++++++++++------
 2 files changed, 25 insertions(+), 13 deletions(-)

--- linux-2.6-CH.orig/drivers/base/class.c
+++ linux-2.6-CH/drivers/base/class.c
@@ -362,7 +362,7 @@ char *make_class_name(const char *name, 
 
 	class_name = kmalloc(size, GFP_KERNEL);
 	if (!class_name)
-		return ERR_PTR(-ENOMEM);
+		return NULL;
 
 	strcpy(class_name, name);
 	strcat(class_name, ":");
@@ -409,8 +409,11 @@ static int make_deprecated_class_device_
 		return 0;
 
 	class_name = make_class_name(class_dev->class->name, &class_dev->kobj);
-	error = sysfs_create_link(&class_dev->dev->kobj, &class_dev->kobj,
-				  class_name);
+	if (class_name)
+		error = sysfs_create_link(&class_dev->dev->kobj,
+					  &class_dev->kobj, class_name);
+	else
+		error = -ENOMEM;
 	kfree(class_name);
 	return error;
 }
@@ -423,7 +426,8 @@ static void remove_deprecated_class_devi
 		return;
 
 	class_name = make_class_name(class_dev->class->name, &class_dev->kobj);
-	sysfs_remove_link(&class_dev->dev->kobj, class_name);
+	if (class_name)
+		sysfs_remove_link(&class_dev->dev->kobj, class_name);
 	kfree(class_name);
 }
 #else
@@ -861,9 +865,12 @@ int class_device_rename(struct class_dev
 	if (class_dev->dev) {
 		new_class_name = make_class_name(class_dev->class->name,
 						 &class_dev->kobj);
-		sysfs_create_link(&class_dev->dev->kobj, &class_dev->kobj,
-				  new_class_name);
-		sysfs_remove_link(&class_dev->dev->kobj, old_class_name);
+		if (new_class_name)
+			sysfs_create_link(&class_dev->dev->kobj,
+					  &class_dev->kobj, new_class_name);
+		if (old_class_name)
+			sysfs_remove_link(&class_dev->dev->kobj,
+						old_class_name);
 	}
 #endif
 	class_device_put(class_dev);
--- linux-2.6-CH.orig/drivers/base/core.c
+++ linux-2.6-CH/drivers/base/core.c
@@ -520,9 +520,13 @@ int device_add(struct device *dev)
 					  &dev->kobj, dev->bus_id);
 #ifdef CONFIG_SYSFS_DEPRECATED
 		if (parent) {
-			sysfs_create_link(&dev->kobj, &dev->parent->kobj, "device");
-			class_name = make_class_name(dev->class->name, &dev->kobj);
-			sysfs_create_link(&dev->parent->kobj, &dev->kobj, class_name);
+			sysfs_create_link(&dev->kobj, &dev->parent->kobj,
+							"device");
+			class_name = make_class_name(dev->class->name,
+							&dev->kobj);
+			if (class_name)
+				sysfs_create_link(&dev->parent->kobj,
+						  &dev->kobj, class_name);
 		}
 #endif
 	}
@@ -666,7 +670,9 @@ void device_del(struct device * dev)
 		if (parent) {
 			char *class_name = make_class_name(dev->class->name,
 							   &dev->kobj);
-			sysfs_remove_link(&dev->parent->kobj, class_name);
+			if (class_name)
+				sysfs_remove_link(&dev->parent->kobj,
+						  class_name);
 			kfree(class_name);
 			sysfs_remove_link(&dev->kobj, "device");
 		}
@@ -970,8 +976,7 @@ static int device_move_class_links(struc
 
 	class_name = make_class_name(dev->class->name, &dev->kobj);
 	if (!class_name) {
-		error = PTR_ERR(class_name);
-		class_name = NULL;
+		error = -ENOMEM;
 		goto out;
 	}
 	if (old_parent) {
