Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932367AbWFWGBt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbWFWGBt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 02:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbWFWGBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 02:01:49 -0400
Received: from ns.suse.de ([195.135.220.2]:7641 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932363AbWFWGBr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 02:01:47 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: linux-usb-devel@lists.sourceforge.net, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 2/2] [PATCH] Driver core: fix locking issues with the devices that are attached to classes
Reply-To: Greg KH <greg@kroah.com>
Date: Thu, 22 Jun 2006 22:58:35 -0700
Message-Id: <11510423183635-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11510423151128-git-send-email-greg@kroah.com>
References: <20060623055737.GA29631@kroah.com> <11510423151128-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

Doh, that was foolish...

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/core.c |   19 +++++++++++--------
 1 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index d0f84ff..27c2176 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -356,6 +356,13 @@ int device_add(struct device *dev)
 	if (parent)
 		klist_add_tail(&dev->knode_parent, &parent->klist_children);
 
+	if (dev->class) {
+		/* tie the class to the device */
+		down(&dev->class->sem);
+		list_add_tail(&dev->node, &dev->class->devices);
+		up(&dev->class->sem);
+	}
+
 	/* notify platform of device entry */
 	if (platform_notify)
 		platform_notify(dev);
@@ -455,6 +462,9 @@ void device_del(struct device * dev)
 		sysfs_remove_link(&dev->kobj, "device");
 		sysfs_remove_link(&dev->parent->kobj, class_name);
 		kfree(class_name);
+		down(&dev->class->sem);
+		list_del_init(&dev->node);
+		up(&dev->class->sem);
 	}
 	device_remove_file(dev, &dev->uevent_attr);
 
@@ -601,11 +611,6 @@ struct device *device_create(struct clas
 	if (retval)
 		goto error;
 
-	/* tie the class to the device */
-	down(&class->sem);
-	list_add_tail(&dev->node, &class->devices);
-	up(&class->sem);
-
 	return dev;
 
 error:
@@ -636,9 +641,7 @@ void device_destroy(struct class *class,
 	}
 	up(&class->sem);
 
-	if (dev) {
-		list_del_init(&dev->node);
+	if (dev)
 		device_unregister(dev);
-	}
 }
 EXPORT_SYMBOL_GPL(device_destroy);
-- 
1.4.0

