Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030259AbWFUTuw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030259AbWFUTuw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030235AbWFUTuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:50:21 -0400
Received: from ns1.suse.de ([195.135.220.2]:16817 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030243AbWFUTtb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:49:31 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Stephen Hemminger <shemminger@osdl.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 7/22] [PATCH] Driver core: class_device_add needs error checks
Reply-To: Greg KH <greg@kroah.com>
Date: Wed, 21 Jun 2006 12:45:50 -0700
Message-Id: <115091918546-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11509191812079-git-send-email-greg@kroah.com>
References: <20060621194511.GA23982@kroah.com> <11509191652021-git-send-email-greg@kroah.com> <11509191682051-git-send-email-greg@kroah.com> <11509191721672-git-send-email-greg@kroah.com> <1150919175882-git-send-email-greg@kroah.com> <11509191781796-git-send-email-greg@kroah.com> <11509191812079-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Hemminger <shemminger@osdl.org>

class_device_add needs to check the return value of all the setup it
does. It doesn't handle out of memory well. This is not complete, probably
more needs to be done.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/class.c |   72 ++++++++++++++++++++++++++++++++++++++------------
 1 files changed, 54 insertions(+), 18 deletions(-)

diff --git a/drivers/base/class.c b/drivers/base/class.c
index b1ea4df..48ad5df 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -535,18 +535,22 @@ int class_device_add(struct class_device
 		return -EINVAL;
 
 	if (!strlen(class_dev->class_id))
-		goto register_done;
+		goto out1;
 
 	parent_class = class_get(class_dev->class);
 	if (!parent_class)
-		goto register_done;
+		goto out1;
+
 	parent_class_dev = class_device_get(class_dev->parent);
 
 	pr_debug("CLASS: registering class device: ID = '%s'\n",
 		 class_dev->class_id);
 
 	/* first, register with generic layer. */
-	kobject_set_name(&class_dev->kobj, "%s", class_dev->class_id);
+	error = kobject_set_name(&class_dev->kobj, "%s", class_dev->class_id);
+	if (error)
+		goto out2;
+
 	if (parent_class_dev)
 		class_dev->kobj.parent = &parent_class_dev->kobj;
 	else
@@ -554,41 +558,56 @@ int class_device_add(struct class_device
 
 	error = kobject_add(&class_dev->kobj);
 	if (error)
-		goto register_done;
+		goto out2;
 
 	/* add the needed attributes to this device */
 	class_dev->uevent_attr.attr.name = "uevent";
 	class_dev->uevent_attr.attr.mode = S_IWUSR;
 	class_dev->uevent_attr.attr.owner = parent_class->owner;
 	class_dev->uevent_attr.store = store_uevent;
-	class_device_create_file(class_dev, &class_dev->uevent_attr);
+	error = class_device_create_file(class_dev, &class_dev->uevent_attr);
+	if (error)
+		goto out3;
 
 	if (MAJOR(class_dev->devt)) {
 		struct class_device_attribute *attr;
 		attr = kzalloc(sizeof(*attr), GFP_KERNEL);
 		if (!attr) {
 			error = -ENOMEM;
-			kobject_del(&class_dev->kobj);
-			goto register_done;
+			goto out4;
 		}
 		attr->attr.name = "dev";
 		attr->attr.mode = S_IRUGO;
 		attr->attr.owner = parent_class->owner;
 		attr->show = show_dev;
-		class_device_create_file(class_dev, attr);
+		error = class_device_create_file(class_dev, attr);
+		if (error) {
+			kfree(attr);
+			goto out4;
+		}
+
 		class_dev->devt_attr = attr;
 	}
 
-	class_device_add_attrs(class_dev);
+	error = class_device_add_attrs(class_dev);
+	if (error)
+		goto out5;
+
 	if (class_dev->dev) {
 		class_name = make_class_name(class_dev);
-		sysfs_create_link(&class_dev->kobj,
-				  &class_dev->dev->kobj, "device");
-		sysfs_create_link(&class_dev->dev->kobj, &class_dev->kobj,
-				  class_name);
+		error = sysfs_create_link(&class_dev->kobj,
+					  &class_dev->dev->kobj, "device");
+		if (error)
+			goto out6;
+		error = sysfs_create_link(&class_dev->dev->kobj, &class_dev->kobj,
+					  class_name);
+		if (error)
+			goto out7;
 	}
 
-	class_device_add_groups(class_dev);
+	error = class_device_add_groups(class_dev);
+	if (error)
+		goto out8;
 
 	kobject_uevent(&class_dev->kobj, KOBJ_ADD);
 
@@ -601,11 +620,28 @@ int class_device_add(struct class_device
 	}
 	up(&parent_class->sem);
 
- register_done:
-	if (error) {
-		class_put(parent_class);
+	goto out1;
+
+ out8:
+	if (class_dev->dev)
+		sysfs_remove_link(&class_dev->kobj, class_name);
+ out7:
+	if (class_dev->dev)
+		sysfs_remove_link(&class_dev->kobj, "device");
+ out6:
+	class_device_remove_attrs(class_dev);
+ out5:
+	if (class_dev->devt_attr)
+		class_device_remove_file(class_dev, class_dev->devt_attr);
+ out4:
+	class_device_remove_file(class_dev, &class_dev->uevent_attr);
+ out3:
+	kobject_del(&class_dev->kobj);
+ out2:
+	if(parent_class_dev)
 		class_device_put(parent_class_dev);
-	}
+	class_put(parent_class);
+ out1:
 	class_device_put(class_dev);
 	kfree(class_name);
 	return error;
-- 
1.4.0

