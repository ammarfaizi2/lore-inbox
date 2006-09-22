Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbWIVJg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbWIVJg2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 05:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbWIVJg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 05:36:28 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:34895 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751111AbWIVJg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 05:36:27 -0400
Date: Fri, 22 Sep 2006 11:36:50 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Greg K-H <greg@kroah.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [1/9] driver core fixes: make_class_name() retval check
Message-ID: <20060922113650.612d425b@gondolin.boeblingen.de.ibm.com>
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.8.20; i486-pc-linux-gnu)
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
 drivers/base/class.c |   12 ++++++++----
 drivers/base/core.c  |    7 +++++--
 2 files changed, 13 insertions(+), 6 deletions(-)

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
+	if (!class_name)
+		error = sysfs_create_link(&class_dev->dev->kobj,
+					  &class_dev->kobj, class_name);
+	else
+		error = -ENOMEM;
 	kfree(class_name);
 	return error;
 }
@@ -771,7 +774,8 @@ void class_device_del(struct class_devic
 #ifdef CONFIG_SYSFS_DEPRECATED
 		class_name = make_class_name(class_dev->class->name,
 					     &class_dev->kobj);
-		sysfs_remove_link(&class_dev->dev->kobj, class_name);
+		if (class_name)
+			sysfs_remove_link(&class_dev->dev->kobj, class_name);
 #endif
 		sysfs_remove_link(&class_dev->kobj, "device");
 	}
--- linux-2.6-CH.orig/drivers/base/core.c
+++ linux-2.6-CH/drivers/base/core.c
@@ -469,7 +469,9 @@ int device_add(struct device *dev)
 		if (parent) {
 			sysfs_create_link(&dev->kobj, &dev->parent->kobj, "device");
 			class_name = make_class_name(dev->class->name, &dev->kobj);
-			sysfs_create_link(&dev->parent->kobj, &dev->kobj, class_name);
+			if (class_name)
+				sysfs_create_link(&dev->parent->kobj,
+						  &dev->kobj, class_name);
 		}
 #endif
 	}
@@ -600,7 +602,8 @@ void device_del(struct device * dev)
 			char *class_name = NULL;
 
 			class_name = make_class_name(dev->class->name, &dev->kobj);
-			sysfs_remove_link(&dev->parent->kobj, class_name);
+			if (class_name)
+				sysfs_remove_link(&dev->parent->kobj, class_name);
 			kfree(class_name);
 #endif
 			sysfs_remove_link(&dev->kobj, "device");
