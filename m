Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751405AbWIZFor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbWIZFor (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 01:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbWIZFkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 01:40:10 -0400
Received: from ns2.suse.de ([195.135.220.15]:42709 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751418AbWIZFjg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 01:39:36 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 29/47] Driver core: add device_rename function
Date: Mon, 25 Sep 2006 22:37:49 -0700
Message-Id: <1159249177618-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.1
In-Reply-To: <11592491744040-git-send-email-greg@kroah.com>
References: <20060926053728.GA8970@kroah.com> <1159249087369-git-send-email-greg@kroah.com> <11592490903867-git-send-email-greg@kroah.com> <11592490933346-git-send-email-greg@kroah.com> <1159249096460-git-send-email-greg@kroah.com> <11592490993970-git-send-email-greg@kroah.com> <11592491023995-git-send-email-greg@kroah.com> <1159249104512-git-send-email-greg@kroah.com> <11592491082990-git-send-email-greg@kroah.com> <1159249111668-git-send-email-greg@kroah.com> <11592491152668-git-send-email-greg@kroah.com> <115924911859-git-send-email-greg@kroah.com> <11592491211162-git-send-email-greg@kroah.com> <1159249124371-git-send-email-greg@kroah.com> <11592491274168-git-send-email-greg@kroah.com> <11592491303012-git-send-email-greg@kroah.com> <11592491342421-git-send-email-greg@kroah.com> <11592491371254-git-send-email-greg@kroah.com> <1159249140339-git-send-email-greg@kroah.com> <11592491451786-git-send-email-greg@kroah.com> <11592491482560-git-send-email-greg@kroah.com> <11592491512
 235-git-send-email-greg@kroah.com> <11592491551919-git-send-email-greg@kroah.com> <11592491581007-git-send-email-greg@kroah.com> <11592491611339-git-send-email-greg@kroah.com> <11592491643725-git-send-email-greg@kroah.com> <11592491672052-git-send-email-greg@kroah.com> <11592491704137-git-send-email-greg@kroah.com> <11592491744040-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

The network layer needs this to convert to using struct device instead
of a struct class_device.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/core.c    |   55 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/device.h |    1 +
 2 files changed, 56 insertions(+), 0 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index f1228f2..0db4756 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -736,3 +736,58 @@ void device_destroy(struct class *class,
 		device_unregister(dev);
 }
 EXPORT_SYMBOL_GPL(device_destroy);
+
+/**
+ * device_rename - renames a device
+ * @dev: the pointer to the struct device to be renamed
+ * @new_name: the new name of the device
+ */
+int device_rename(struct device *dev, char *new_name)
+{
+	char *old_class_name = NULL;
+	char *new_class_name = NULL;
+	char *old_symlink_name = NULL;
+	int error;
+
+	dev = get_device(dev);
+	if (!dev)
+		return -EINVAL;
+
+	pr_debug("DEVICE: renaming '%s' to '%s'\n", dev->bus_id, new_name);
+
+	if ((dev->class) && (dev->parent))
+		old_class_name = make_class_name(dev->class->name, &dev->kobj);
+
+	if (dev->class) {
+		old_symlink_name = kmalloc(BUS_ID_SIZE, GFP_KERNEL);
+		if (!old_symlink_name)
+			return -ENOMEM;
+		strlcpy(old_symlink_name, dev->bus_id, BUS_ID_SIZE);
+	}
+
+	strlcpy(dev->bus_id, new_name, BUS_ID_SIZE);
+
+	error = kobject_rename(&dev->kobj, new_name);
+
+	if (old_class_name) {
+		new_class_name = make_class_name(dev->class->name, &dev->kobj);
+		if (new_class_name) {
+			sysfs_create_link(&dev->parent->kobj, &dev->kobj,
+					  new_class_name);
+			sysfs_remove_link(&dev->parent->kobj, old_class_name);
+		}
+	}
+	if (dev->class) {
+		sysfs_remove_link(&dev->class->subsys.kset.kobj,
+				  old_symlink_name);
+		sysfs_create_link(&dev->class->subsys.kset.kobj, &dev->kobj,
+				  dev->bus_id);
+	}
+	put_device(dev);
+
+	kfree(old_class_name);
+	kfree(new_class_name);
+	kfree(old_symlink_name);
+
+	return error;
+}
diff --git a/include/linux/device.h b/include/linux/device.h
index 3122bd2..3400e09 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -380,6 +380,7 @@ extern int device_add(struct device * de
 extern void device_del(struct device * dev);
 extern int device_for_each_child(struct device *, void *,
 		     int (*fn)(struct device *, void *));
+extern int device_rename(struct device *dev, char *new_name);
 
 /*
  * Manual binding of a device to driver. See drivers/base/bus.c
-- 
1.4.2.1

