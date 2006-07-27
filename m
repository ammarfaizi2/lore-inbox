Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751706AbWG0PRO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751706AbWG0PRO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 11:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751687AbWG0PRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 11:17:14 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:63664 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751359AbWG0PRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 11:17:14 -0400
Date: Thu, 27 Jul 2006 17:17:11 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg K-H <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: [Patch] [2.6.18-rc2-mm1] Return code checking for make_class_name()
Message-ID: <20060727171711.6fe210aa@gondolin.boeblingen.de.ibm.com>
X-Mailer: Sylpheed-Claws 2.3.1 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

make_class_name() may return an error pointer. Make sure that all
callers in the driver core check for it.

CC: Greg K-H <greg@kroah.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

 class.c |   25 ++++++++++++++++++++++---
 core.c  |   11 +++++++----
 2 files changed, 29 insertions(+), 7 deletions(-)

diff -Naurp linux-2.6.18-rc2-mm1/drivers/base/class.c linux-2.6.18-rc2-mm1+CH/drivers/base/class.c
--- linux-2.6.18-rc2-mm1/drivers/base/class.c	2006-07-27 16:43:25.000000000 +0200
+++ linux-2.6.18-rc2-mm1+CH/drivers/base/class.c	2006-07-27 16:39:14.000000000 +0200
@@ -602,6 +602,11 @@ int class_device_add(struct class_device
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
@@ -741,7 +746,11 @@ void class_device_del(struct class_devic
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
@@ -804,10 +813,15 @@ int class_device_rename(struct class_dev
 	pr_debug("CLASS: renaming '%s' to '%s'\n", class_dev->class_id,
 		 new_name);
 
-	if (class_dev->dev)
+	if (class_dev->dev) {
 		old_class_name = make_class_name(class_dev->class->name,
 						 &class_dev->kobj);
-
+		if (IS_ERR(old_class_name)) {
+			error = PTR_ERR(old_class_name);
+			old_class_name = NULL;
+			goto out;
+		}
+	}
 	strlcpy(class_dev->class_id, new_name, KOBJ_NAME_LEN);
 
 	error = kobject_rename(&class_dev->kobj, new_name);
@@ -815,6 +829,11 @@ int class_device_rename(struct class_dev
 	if (class_dev->dev) {
 		new_class_name = make_class_name(class_dev->class->name,
 						 &class_dev->kobj);
+		if (IS_ERR(new_class_name)) {
+			error = PTR_ERR(new_class_name);
+			new_class_name = NULL;
+			goto out;
+		}
 		error = sysfs_create_link(&class_dev->dev->kobj,
 					  &class_dev->kobj, new_class_name);
 		if (error)
diff -Naurp linux-2.6.18-rc2-mm1/drivers/base/core.c linux-2.6.18-rc2-mm1+CH/drivers/base/core.c
--- linux-2.6.18-rc2-mm1/drivers/base/core.c	2006-07-27 16:43:25.000000000 +0200
+++ linux-2.6.18-rc2-mm1+CH/drivers/base/core.c	2006-07-27 16:41:03.000000000 +0200
@@ -608,11 +608,14 @@ void device_del(struct device * dev)
 		sysfs_remove_link(&dev->kobj, "subsystem");
 		sysfs_remove_link(&dev->class->subsys.kset.kobj, dev->bus_id);
 		class_name = make_class_name(dev->class->name, &dev->kobj);
-		if (parent) {
-			sysfs_remove_link(&dev->kobj, "device");
-			sysfs_remove_link(&dev->parent->kobj, class_name);
+		if (!IS_ERR(class_name)) {
+			if (parent) {
+				sysfs_remove_link(&dev->kobj, "device");
+				sysfs_remove_link(&dev->parent->kobj,
+						  class_name);
+			}
+			kfree(class_name);
 		}
-		kfree(class_name);
 		down(&dev->class->sem);
 		list_del_init(&dev->node);
 		up(&dev->class->sem);
