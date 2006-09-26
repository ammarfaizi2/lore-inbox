Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751495AbWIZFkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbWIZFkq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 01:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbWIZFkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 01:40:16 -0400
Received: from cantor2.suse.de ([195.135.220.15]:39893 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751294AbWIZFj3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 01:39:29 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 27/47] Driver core: allow devices in classes to have no parent
Date: Mon, 25 Sep 2006 22:37:47 -0700
Message-Id: <11592491704137-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.1
In-Reply-To: <11592491672052-git-send-email-greg@kroah.com>
References: <20060926053728.GA8970@kroah.com> <1159249087369-git-send-email-greg@kroah.com> <11592490903867-git-send-email-greg@kroah.com> <11592490933346-git-send-email-greg@kroah.com> <1159249096460-git-send-email-greg@kroah.com> <11592490993970-git-send-email-greg@kroah.com> <11592491023995-git-send-email-greg@kroah.com> <1159249104512-git-send-email-greg@kroah.com> <11592491082990-git-send-email-greg@kroah.com> <1159249111668-git-send-email-greg@kroah.com> <11592491152668-git-send-email-greg@kroah.com> <115924911859-git-send-email-greg@kroah.com> <11592491211162-git-send-email-greg@kroah.com> <1159249124371-git-send-email-greg@kroah.com> <11592491274168-git-send-email-greg@kroah.com> <11592491303012-git-send-email-greg@kroah.com> <11592491342421-git-send-email-greg@kroah.com> <11592491371254-git-send-email-greg@kroah.com> <1159249140339-git-send-email-greg@kroah.com> <11592491451786-git-send-email-greg@kroah.com> <11592491482560-git-send-email-greg@kroah.com> <11592491512
 235-git-send-email-greg@kroah.com> <11592491551919-git-send-email-greg@kroah.com> <11592491581007-git-send-email-greg@kroah.com> <11592491611339-git-send-email-greg@kroah.com> <11592491643725-git-send-email-greg@kroah.com> <11592491672052-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

This fixes an oops when a device is attached to a class, yet has no
"parent" device.  An example of this would be the "lo" device in the
network core.

We should create a "virtual" subdirectory under /sys/devices/ for these,
but no one seems to agree on a proper name for it yet...

Oh, and update my copyright on the driver core.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/core.c |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 641c0c4..5c91d0d 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3,6 +3,8 @@
  *
  * Copyright (c) 2002-3 Patrick Mochel
  * Copyright (c) 2002-3 Open Source Development Labs
+ * Copyright (c) 2006 Greg Kroah-Hartman <gregkh@suse.de>
+ * Copyright (c) 2006 Novell, Inc.
  *
  * This file is released under the GPLv2
  *
@@ -373,10 +375,11 @@ int device_add(struct device *dev)
 				  "subsystem");
 		sysfs_create_link(&dev->class->subsys.kset.kobj, &dev->kobj,
 				  dev->bus_id);
-
-		sysfs_create_link(&dev->kobj, &dev->parent->kobj, "device");
-		class_name = make_class_name(dev->class->name, &dev->kobj);
-		sysfs_create_link(&dev->parent->kobj, &dev->kobj, class_name);
+		if (parent) {
+			sysfs_create_link(&dev->kobj, &dev->parent->kobj, "device");
+			class_name = make_class_name(dev->class->name, &dev->kobj);
+			sysfs_create_link(&dev->parent->kobj, &dev->kobj, class_name);
+		}
 	}
 
 	if ((error = device_add_groups(dev)))
@@ -495,8 +498,10 @@ void device_del(struct device * dev)
 		sysfs_remove_link(&dev->kobj, "subsystem");
 		sysfs_remove_link(&dev->class->subsys.kset.kobj, dev->bus_id);
 		class_name = make_class_name(dev->class->name, &dev->kobj);
-		sysfs_remove_link(&dev->kobj, "device");
-		sysfs_remove_link(&dev->parent->kobj, class_name);
+		if (parent) {
+			sysfs_remove_link(&dev->kobj, "device");
+			sysfs_remove_link(&dev->parent->kobj, class_name);
+		}
 		kfree(class_name);
 		down(&dev->class->sem);
 		list_del_init(&dev->node);
@@ -625,10 +630,6 @@ struct device *device_create(struct clas
 
 	if (class == NULL || IS_ERR(class))
 		goto error;
-	if (parent == NULL) {
-		printk(KERN_WARNING "%s does not work yet for NULL parents\n", __FUNCTION__);
-		goto error;
-	}
 
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	if (!dev) {
-- 
1.4.2.1

