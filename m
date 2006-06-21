Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030243AbWFUTv3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030243AbWFUTv3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030238AbWFUTu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:50:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:20890 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030233AbWFUTuO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:50:14 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 20/22] [PATCH] Driver core: add proper symlinks for devices
Reply-To: Greg KH <greg@kroah.com>
Date: Wed, 21 Jun 2006 12:46:03 -0700
Message-Id: <1150919228328-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11509192252062-git-send-email-greg@kroah.com>
References: <20060621194511.GA23982@kroah.com> <11509191652021-git-send-email-greg@kroah.com> <11509191682051-git-send-email-greg@kroah.com> <11509191721672-git-send-email-greg@kroah.com> <1150919175882-git-send-email-greg@kroah.com> <11509191781796-git-send-email-greg@kroah.com> <11509191812079-git-send-email-greg@kroah.com> <115091918546-git-send-email-greg@kroah.com> <11509191893358-git-send-email-greg@kroah.com> <1150919192294-git-send-email-greg@kroah.com> <11509191951525-git-send-email-greg@kroah.com> <11509191982588-git-send-email-greg@kroah.com> <11509192022315-git-send-email-greg@kroah.com> <11509192043044-git-send-email-greg@kroah.com> <11509192081167-git-send-email-greg@kroah.com> <11509192111668-git-send-email-greg@kroah.com> <1150919214366-git-send-email-greg@kroah.com> <1150919218895-git-send-email-greg@kroah.com> <1150919221158-git-send-email-greg@kroah.com> <11509192252062-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

We need to create the "compatible" symlinks that class_devices used to
create when they were in the class directories so that userspace does
not know anything changed at all.

Yeah, we have a lot of symlinks now, but we should be able to get rid of
them in a year or two... (wishful thinking...)

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/core.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index cc8bb97..a979bc3 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -273,6 +273,7 @@ void device_initialize(struct device *de
 int device_add(struct device *dev)
 {
 	struct device *parent = NULL;
+	char *class_name = NULL;
 	int error = -EINVAL;
 
 	dev = get_device(dev);
@@ -324,6 +325,10 @@ int device_add(struct device *dev)
 				  "subsystem");
 		sysfs_create_link(&dev->class->subsys.kset.kobj, &dev->kobj,
 				  dev->bus_id);
+
+		sysfs_create_link(&dev->kobj, &dev->parent->kobj, "device");
+		class_name = make_class_name(dev->class->name, &dev->kobj);
+		sysfs_create_link(&dev->parent->kobj, &dev->kobj, class_name);
 	}
 
 	if ((error = device_pm_add(dev)))
@@ -339,6 +344,7 @@ int device_add(struct device *dev)
 	if (platform_notify)
 		platform_notify(dev);
  Done:
+ 	kfree(class_name);
 	put_device(dev);
 	return error;
  BusError:
@@ -420,6 +426,7 @@ void put_device(struct device * dev)
 void device_del(struct device * dev)
 {
 	struct device * parent = dev->parent;
+	char *class_name = NULL;
 
 	if (parent)
 		klist_del(&dev->knode_parent);
@@ -428,6 +435,10 @@ void device_del(struct device * dev)
 	if (dev->class) {
 		sysfs_remove_link(&dev->kobj, "subsystem");
 		sysfs_remove_link(&dev->class->subsys.kset.kobj, dev->bus_id);
+		class_name = make_class_name(dev->class->name, &dev->kobj);
+		sysfs_remove_link(&dev->kobj, "device");
+		sysfs_remove_link(&dev->parent->kobj, class_name);
+		kfree(class_name);
 	}
 	device_remove_file(dev, &dev->uevent_attr);
 
-- 
1.4.0

