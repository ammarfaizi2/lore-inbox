Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946420AbWJ0LgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946420AbWJ0LgN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 07:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946423AbWJ0LgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 07:36:13 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:33369 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1946420AbWJ0LgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 07:36:11 -0400
Date: Fri, 27 Oct 2006 13:36:49 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Greg K-H <greg@kroah.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [Patch 1/7] driver core fixes: make_class_name() retval checks
Message-ID: <20061027133649.2f80b595@gondolin.boeblingen.de.ibm.com>
X-Mailer: Sylpheed-Claws 2.5.6 (GTK+ 2.8.20; i486-pc-linux-gnu)
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

 drivers/base/class.c |   23 +++++++++++++++--------
 drivers/base/core.c  |   14 ++++++++++----
 2 files changed, 25 insertions(+), 12 deletions(-)

--- linux-2.6.orig/drivers/base/class.c
+++ linux-2.6/drivers/base/class.c
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
@@ -420,10 +423,11 @@ static void remove_deprecated_class_devi
 	char *class_name;
 
 	if (!class_dev->dev)
-		return 0;
+		return;
 
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
--- linux-2.6.orig/drivers/base/core.c
+++ linux-2.6/drivers/base/core.c
@@ -513,9 +513,13 @@ int device_add(struct device *dev)
 				  dev->bus_id);
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
@@ -654,7 +658,9 @@ void device_del(struct device * dev)
 			char *class_name = NULL;
 
 			class_name = make_class_name(dev->class->name, &dev->kobj);
-			sysfs_remove_link(&dev->parent->kobj, class_name);
+			if (class_name)
+				sysfs_remove_link(&dev->parent->kobj,
+						  class_name);
 			kfree(class_name);
 			sysfs_remove_link(&dev->kobj, "device");
 		}
