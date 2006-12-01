Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162268AbWLAXXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162268AbWLAXXd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 18:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162245AbWLAXW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 18:22:59 -0500
Received: from mx1.suse.de ([195.135.220.2]:10893 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1162238AbWLAXWb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 18:22:31 -0500
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 5/36] Driver core: make old versions of udev work properly
Date: Fri,  1 Dec 2006 15:21:35 -0800
Message-Id: <11650153392022-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.4.1
In-Reply-To: <11650153362310-git-send-email-greg@kroah.com>
References: <20061201231620.GA7560@kroah.com> <11650153262399-git-send-email-greg@kroah.com> <11650153293531-git-send-email-greg@kroah.com> <1165015333344-git-send-email-greg@kroah.com> <11650153362310-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

If CONFIG_SYSFS_DEPRECATED is enabled, old versions of udev will work
properly with devices that are associated with a class.

Cc: Kay Sievers <kay.sievers@vrfy.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/core.c |   59 ++++++++++++++++++++++++++++++++++++++------------
 1 files changed, 45 insertions(+), 14 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index dbcd40b..8f8347b 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -384,6 +384,19 @@ void device_initialize(struct device *de
 	device_init_wakeup(dev, 0);
 }
 
+#ifdef CONFIG_SYSFS_DEPRECATED
+int setup_parent(struct device *dev, struct device *parent)
+{
+	/* Set the parent to the class, not the parent device */
+	/* this keeps sysfs from having a symlink to make old udevs happy */
+	if (dev->class)
+		dev->kobj.parent = &dev->class->subsys.kset.kobj;
+	else if (parent)
+		dev->kobj.parent = &parent->kobj;
+
+	return 0;
+}
+#else
 static int virtual_device_parent(struct device *dev)
 {
 	if (!dev->class)
@@ -401,6 +414,22 @@ static int virtual_device_parent(struct
 	return 0;
 }
 
+int setup_parent(struct device *dev, struct device *parent)
+{
+	int error;
+
+	/* if this is a class device, and has no parent, create one */
+	if ((dev->class) && (parent == NULL)) {
+		error = virtual_device_parent(dev);
+		if (error)
+			return error;
+	} else if (parent)
+		dev->kobj.parent = &parent->kobj;
+
+	return 0;
+}
+#endif
+
 /**
  *	device_add - add device to device hierarchy.
  *	@dev:	device.
@@ -423,23 +452,18 @@ int device_add(struct device *dev)
 	if (!dev || !strlen(dev->bus_id))
 		goto Error;
 
-	/* if this is a class device, and has no parent, create one */
-	if ((dev->class) && (dev->parent == NULL)) {
-		error = virtual_device_parent(dev);
-		if (error)
-			goto Error;
-	}
+	pr_debug("DEV: registering device: ID = '%s'\n", dev->bus_id);
 
 	parent = get_device(dev->parent);
 
-	pr_debug("DEV: registering device: ID = '%s'\n", dev->bus_id);
+	error = setup_parent(dev, parent);
+	if (error)
+		goto Error;
 
 	/* first, register with generic layer. */
 	kobject_set_name(&dev->kobj, "%s", dev->bus_id);
-	if (parent)
-		dev->kobj.parent = &parent->kobj;
-
-	if ((error = kobject_add(&dev->kobj)))
+	error = kobject_add(&dev->kobj);
+	if (error)
 		goto Error;
 
 	/* notify platform of device entry */
@@ -484,8 +508,11 @@ int device_add(struct device *dev)
 	if (dev->class) {
 		sysfs_create_link(&dev->kobj, &dev->class->subsys.kset.kobj,
 				  "subsystem");
-		sysfs_create_link(&dev->class->subsys.kset.kobj, &dev->kobj,
-				  dev->bus_id);
+		/* If this is not a "fake" compatible device, then create the
+		 * symlink from the class to the device. */
+		if (dev->kobj.parent != &dev->class->subsys.kset.kobj)
+			sysfs_create_link(&dev->class->subsys.kset.kobj,
+					  &dev->kobj, dev->bus_id);
 		if (parent) {
 			sysfs_create_link(&dev->kobj, &dev->parent->kobj, "device");
 			class_name = make_class_name(dev->class->name, &dev->kobj);
@@ -623,7 +650,11 @@ void device_del(struct device * dev)
 	}
 	if (dev->class) {
 		sysfs_remove_link(&dev->kobj, "subsystem");
-		sysfs_remove_link(&dev->class->subsys.kset.kobj, dev->bus_id);
+		/* If this is not a "fake" compatible device, remove the
+		 * symlink from the class to the device. */
+		if (dev->kobj.parent != &dev->class->subsys.kset.kobj)
+			sysfs_remove_link(&dev->class->subsys.kset.kobj,
+					  dev->bus_id);
 		class_name = make_class_name(dev->class->name, &dev->kobj);
 		if (parent) {
 			sysfs_remove_link(&dev->kobj, "device");
-- 
1.4.4.1

