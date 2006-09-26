Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751415AbWIZFqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbWIZFqv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 01:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbWIZFj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 01:39:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:45269 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751422AbWIZFjm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 01:39:42 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 31/47] Class: add support for class interfaces for devices
Date: Mon, 25 Sep 2006 22:37:51 -0700
Message-Id: <11592491833450-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.1
In-Reply-To: <11592491803904-git-send-email-greg@kroah.com>
References: <20060926053728.GA8970@kroah.com> <1159249087369-git-send-email-greg@kroah.com> <11592490903867-git-send-email-greg@kroah.com> <11592490933346-git-send-email-greg@kroah.com> <1159249096460-git-send-email-greg@kroah.com> <11592490993970-git-send-email-greg@kroah.com> <11592491023995-git-send-email-greg@kroah.com> <1159249104512-git-send-email-greg@kroah.com> <11592491082990-git-send-email-greg@kroah.com> <1159249111668-git-send-email-greg@kroah.com> <11592491152668-git-send-email-greg@kroah.com> <115924911859-git-send-email-greg@kroah.com> <11592491211162-git-send-email-greg@kroah.com> <1159249124371-git-send-email-greg@kroah.com> <11592491274168-git-send-email-greg@kroah.com> <11592491303012-git-send-email-greg@kroah.com> <11592491342421-git-send-email-greg@kroah.com> <11592491371254-git-send-email-greg@kroah.com> <1159249140339-git-send-email-greg@kroah.com> <11592491451786-git-send-email-greg@kroah.com> <11592491482560-git-send-email-greg@kroah.com> <11592491512
 235-git-send-email-greg@kroah.com> <11592491551919-git-send-email-greg@kroah.com> <11592491581007-git-send-email-greg@kroah.com> <11592491611339-git-send-email-greg@kroah.com> <11592491643725-git-send-email-greg@kroah.com> <11592491672052-git-send-email-greg@kroah.com> <11592491704137-git-send-email-greg@kroah.com> <11592491744040-git-send-email-greg@kroah.com> <1159249177618-git-send-email-greg@kroah.com> <11592491803904-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

When moving class_device usage over to device, we need to handle
class_interfaces properly with devices.  This patch adds that support.


Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/class.c   |   10 ++++++++++
 drivers/base/core.c    |   14 +++++++++++++-
 include/linux/device.h |    2 ++
 3 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/drivers/base/class.c b/drivers/base/class.c
index cbdf47c..b06b0e2 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -842,6 +842,7 @@ int class_interface_register(struct clas
 {
 	struct class *parent;
 	struct class_device *class_dev;
+	struct device *dev;
 
 	if (!class_intf || !class_intf->class)
 		return -ENODEV;
@@ -856,6 +857,10 @@ int class_interface_register(struct clas
 		list_for_each_entry(class_dev, &parent->children, node)
 			class_intf->add(class_dev, class_intf);
 	}
+	if (class_intf->add_dev) {
+		list_for_each_entry(dev, &parent->devices, node)
+			class_intf->add_dev(dev, class_intf);
+	}
 	up(&parent->sem);
 
 	return 0;
@@ -865,6 +870,7 @@ void class_interface_unregister(struct c
 {
 	struct class * parent = class_intf->class;
 	struct class_device *class_dev;
+	struct device *dev;
 
 	if (!parent)
 		return;
@@ -875,6 +881,10 @@ void class_interface_unregister(struct c
 		list_for_each_entry(class_dev, &parent->children, node)
 			class_intf->remove(class_dev, class_intf);
 	}
+	if (class_intf->remove_dev) {
+		list_for_each_entry(dev, &parent->devices, node)
+			class_intf->remove_dev(dev, class_intf);
+	}
 	up(&parent->sem);
 
 	class_put(parent);
diff --git a/drivers/base/core.c b/drivers/base/core.c
index e21a65f..1d3d358 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -372,6 +372,7 @@ int device_add(struct device *dev)
 {
 	struct device *parent = NULL;
 	char *class_name = NULL;
+	struct class_interface *class_intf;
 	int error = -EINVAL;
 
 	dev = get_device(dev);
@@ -451,9 +452,14 @@ int device_add(struct device *dev)
 		klist_add_tail(&dev->knode_parent, &parent->klist_children);
 
 	if (dev->class) {
-		/* tie the class to the device */
 		down(&dev->class->sem);
+		/* tie the class to the device */
 		list_add_tail(&dev->node, &dev->class->devices);
+
+		/* notify any interfaces that the device is here */
+		list_for_each_entry(class_intf, &dev->class->interfaces, node)
+			if (class_intf->add_dev)
+				class_intf->add_dev(dev, class_intf);
 		up(&dev->class->sem);
 	}
 
@@ -548,6 +554,7 @@ void device_del(struct device * dev)
 {
 	struct device * parent = dev->parent;
 	char *class_name = NULL;
+	struct class_interface *class_intf;
 
 	if (parent)
 		klist_del(&dev->knode_parent);
@@ -563,6 +570,11 @@ void device_del(struct device * dev)
 		}
 		kfree(class_name);
 		down(&dev->class->sem);
+		/* notify any interfaces that the device is now gone */
+		list_for_each_entry(class_intf, &dev->class->interfaces, node)
+			if (class_intf->remove_dev)
+				class_intf->remove_dev(dev, class_intf);
+		/* remove the device from the class list */
 		list_del_init(&dev->node);
 		up(&dev->class->sem);
 	}
diff --git a/include/linux/device.h b/include/linux/device.h
index bbb0d6b..e0fae0e 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -278,6 +278,8 @@ struct class_interface {
 
 	int (*add)	(struct class_device *, struct class_interface *);
 	void (*remove)	(struct class_device *, struct class_interface *);
+	int (*add_dev)		(struct device *, struct class_interface *);
+	void (*remove_dev)	(struct device *, struct class_interface *);
 };
 
 extern int class_interface_register(struct class_interface *);
-- 
1.4.2.1

