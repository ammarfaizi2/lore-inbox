Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162249AbWLAXWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162249AbWLAXWu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 18:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162245AbWLAXWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 18:22:50 -0500
Received: from ns.suse.de ([195.135.220.2]:12941 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1162244AbWLAXWh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 18:22:37 -0500
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Kay Sievers <kay.sievers@vrfy.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 7/36] CONFIG_SYSFS_DEPRECATED - device symlinks
Date: Fri,  1 Dec 2006 15:21:37 -0800
Message-Id: <11650153463092-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.4.1
In-Reply-To: <11650153432284-git-send-email-greg@kroah.com>
References: <20061201231620.GA7560@kroah.com> <11650153262399-git-send-email-greg@kroah.com> <11650153293531-git-send-email-greg@kroah.com> <1165015333344-git-send-email-greg@kroah.com> <11650153362310-git-send-email-greg@kroah.com> <11650153392022-git-send-email-greg@kroah.com> <11650153432284-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kay Sievers <kay.sievers@vrfy.org>

Turn off device symlinks CONFIG_SYSFS_DEPRECATED is enabled.

Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/core.c |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 8f8347b..b565b7e 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -513,11 +513,13 @@ int device_add(struct device *dev)
 		if (dev->kobj.parent != &dev->class->subsys.kset.kobj)
 			sysfs_create_link(&dev->class->subsys.kset.kobj,
 					  &dev->kobj, dev->bus_id);
+#ifdef CONFIG_SYSFS_DEPRECATED
 		if (parent) {
 			sysfs_create_link(&dev->kobj, &dev->parent->kobj, "device");
 			class_name = make_class_name(dev->class->name, &dev->kobj);
 			sysfs_create_link(&dev->parent->kobj, &dev->kobj, class_name);
 		}
+#endif
 	}
 
 	if ((error = device_add_attrs(dev)))
@@ -639,7 +641,6 @@ void put_device(struct device * dev)
 void device_del(struct device * dev)
 {
 	struct device * parent = dev->parent;
-	char *class_name = NULL;
 	struct class_interface *class_intf;
 
 	if (parent)
@@ -655,12 +656,16 @@ void device_del(struct device * dev)
 		if (dev->kobj.parent != &dev->class->subsys.kset.kobj)
 			sysfs_remove_link(&dev->class->subsys.kset.kobj,
 					  dev->bus_id);
-		class_name = make_class_name(dev->class->name, &dev->kobj);
+#ifdef CONFIG_SYSFS_DEPRECATED
 		if (parent) {
-			sysfs_remove_link(&dev->kobj, "device");
+			char *class_name = make_class_name(dev->class->name,
+							   &dev->kobj);
 			sysfs_remove_link(&dev->parent->kobj, class_name);
+			kfree(class_name);
+			sysfs_remove_link(&dev->kobj, "device");
 		}
-		kfree(class_name);
+#endif
+
 		down(&dev->class->sem);
 		/* notify any interfaces that the device is now gone */
 		list_for_each_entry(class_intf, &dev->class->interfaces, node)
@@ -869,8 +874,10 @@ int device_rename(struct device *dev, ch
 
 	pr_debug("DEVICE: renaming '%s' to '%s'\n", dev->bus_id, new_name);
 
+#ifdef CONFIG_SYSFS_DEPRECATED
 	if ((dev->class) && (dev->parent))
 		old_class_name = make_class_name(dev->class->name, &dev->kobj);
+#endif
 
 	if (dev->class) {
 		old_symlink_name = kmalloc(BUS_ID_SIZE, GFP_KERNEL);
@@ -885,6 +892,7 @@ int device_rename(struct device *dev, ch
 
 	error = kobject_rename(&dev->kobj, new_name);
 
+#ifdef CONFIG_SYSFS_DEPRECATED
 	if (old_class_name) {
 		new_class_name = make_class_name(dev->class->name, &dev->kobj);
 		if (new_class_name) {
@@ -893,6 +901,8 @@ int device_rename(struct device *dev, ch
 			sysfs_remove_link(&dev->parent->kobj, old_class_name);
 		}
 	}
+#endif
+
 	if (dev->class) {
 		sysfs_remove_link(&dev->class->subsys.kset.kobj,
 				  old_symlink_name);
-- 
1.4.4.1

