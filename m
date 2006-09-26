Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751207AbWIZFkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbWIZFkA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 01:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbWIZFjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 01:39:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:46549 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751421AbWIZFjp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 01:39:45 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 32/47] Driver core: add ability for devices to create and remove bin files
Date: Mon, 25 Sep 2006 22:37:52 -0700
Message-Id: <11592491862904-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.1
In-Reply-To: <11592491833450-git-send-email-greg@kroah.com>
References: <20060926053728.GA8970@kroah.com> <1159249087369-git-send-email-greg@kroah.com> <11592490903867-git-send-email-greg@kroah.com> <11592490933346-git-send-email-greg@kroah.com> <1159249096460-git-send-email-greg@kroah.com> <11592490993970-git-send-email-greg@kroah.com> <11592491023995-git-send-email-greg@kroah.com> <1159249104512-git-send-email-greg@kroah.com> <11592491082990-git-send-email-greg@kroah.com> <1159249111668-git-send-email-greg@kroah.com> <11592491152668-git-send-email-greg@kroah.com> <115924911859-git-send-email-greg@kroah.com> <11592491211162-git-send-email-greg@kroah.com> <1159249124371-git-send-email-greg@kroah.com> <11592491274168-git-send-email-greg@kroah.com> <11592491303012-git-send-email-greg@kroah.com> <11592491342421-git-send-email-greg@kroah.com> <11592491371254-git-send-email-greg@kroah.com> <1159249140339-git-send-email-greg@kroah.com> <11592491451786-git-send-email-greg@kroah.com> <11592491482560-git-send-email-greg@kroah.com> <11592491512
 235-git-send-email-greg@kroah.com> <11592491551919-git-send-email-greg@kroah.com> <11592491581007-git-send-email-greg@kroah.com> <11592491611339-git-send-email-greg@kroah.com> <11592491643725-git-send-email-greg@kroah.com> <11592491672052-git-send-email-greg@kroah.com> <11592491704137-git-send-email-greg@kroah.com> <11592491744040-git-send-email-greg@kroah.com> <1159249177618-git-send-email-greg@kroah.com> <11592491803904-git-send-email-greg@kroah.com> <11592491833450-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

Makes it easier for devices to create and remove binary attribute files
so they don't have to call directly into sysfs.  This is needed to help
with the conversion from struct class_device to struct device.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/core.c    |   26 ++++++++++++++++++++++++++
 include/linux/device.h |    4 ++++
 2 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 1d3d358..bc9f35c 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -319,6 +319,32 @@ void device_remove_file(struct device * 
 	}
 }
 
+/**
+ * device_create_bin_file - create sysfs binary attribute file for device.
+ * @dev: device.
+ * @attr: device binary attribute descriptor.
+ */
+int device_create_bin_file(struct device *dev, struct bin_attribute *attr)
+{
+	int error = -EINVAL;
+	if (dev)
+		error = sysfs_create_bin_file(&dev->kobj, attr);
+	return error;
+}
+EXPORT_SYMBOL_GPL(device_create_bin_file);
+
+/**
+ * device_remove_bin_file - remove sysfs binary attribute file
+ * @dev: device.
+ * @attr: device binary attribute descriptor.
+ */
+void device_remove_bin_file(struct device *dev, struct bin_attribute *attr)
+{
+	if (dev)
+		sysfs_remove_bin_file(&dev->kobj, attr);
+}
+EXPORT_SYMBOL_GPL(device_remove_bin_file);
+
 static void klist_children_get(struct klist_node *n)
 {
 	struct device *dev = container_of(n, struct device, knode_parent);
diff --git a/include/linux/device.h b/include/linux/device.h
index e0fae0e..7d447d7 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -309,6 +309,10 @@ struct device_attribute dev_attr_##_name
 
 extern int device_create_file(struct device *device, struct device_attribute * entry);
 extern void device_remove_file(struct device * dev, struct device_attribute * attr);
+extern int __must_check device_create_bin_file(struct device *dev,
+					       struct bin_attribute *attr);
+extern void device_remove_bin_file(struct device *dev,
+				   struct bin_attribute *attr);
 struct device {
 	struct klist		klist_children;
 	struct klist_node	knode_parent;		/* node in sibling list */
-- 
1.4.2.1

