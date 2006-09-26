Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751445AbWIZFpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbWIZFpN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 01:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbWIZFkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 01:40:07 -0400
Received: from ns.suse.de ([195.135.220.2]:60897 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751415AbWIZFjj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 01:39:39 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 30/47] Driver core: create devices/virtual/ tree
Date: Mon, 25 Sep 2006 22:37:50 -0700
Message-Id: <11592491803904-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.1
In-Reply-To: <1159249177618-git-send-email-greg@kroah.com>
References: <20060926053728.GA8970@kroah.com> <1159249087369-git-send-email-greg@kroah.com> <11592490903867-git-send-email-greg@kroah.com> <11592490933346-git-send-email-greg@kroah.com> <1159249096460-git-send-email-greg@kroah.com> <11592490993970-git-send-email-greg@kroah.com> <11592491023995-git-send-email-greg@kroah.com> <1159249104512-git-send-email-greg@kroah.com> <11592491082990-git-send-email-greg@kroah.com> <1159249111668-git-send-email-greg@kroah.com> <11592491152668-git-send-email-greg@kroah.com> <115924911859-git-send-email-greg@kroah.com> <11592491211162-git-send-email-greg@kroah.com> <1159249124371-git-send-email-greg@kroah.com> <11592491274168-git-send-email-greg@kroah.com> <11592491303012-git-send-email-greg@kroah.com> <11592491342421-git-send-email-greg@kroah.com> <11592491371254-git-send-email-greg@kroah.com> <1159249140339-git-send-email-greg@kroah.com> <11592491451786-git-send-email-greg@kroah.com> <11592491482560-git-send-email-greg@kroah.com> <11592491512
 235-git-send-email-greg@kroah.com> <11592491551919-git-send-email-greg@kroah.com> <11592491581007-git-send-email-greg@kroah.com> <11592491611339-git-send-email-greg@kroah.com> <11592491643725-git-send-email-greg@kroah.com> <11592491672052-git-send-email-greg@kroah.com> <11592491704137-git-send-email-greg@kroah.com> <11592491744040-git-send-email-greg@kroah.com> <1159249177618-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

This change creates a devices/virtual/CLASS_NAME tree for struct devices
that belong to a class, yet do not have a "real" struct device for a
parent.  It automatically creates the directories on the fly as needed.


Cc: Kay Sievers <kay.sievers@vrfy.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/class.c   |   17 +++++++++++++++++
 drivers/base/core.c    |    7 +++++++
 include/linux/device.h |    5 ++++-
 3 files changed, 28 insertions(+), 1 deletions(-)

diff --git a/drivers/base/class.c b/drivers/base/class.c
index e078bc2..cbdf47c 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -19,6 +19,8 @@ #include <linux/err.h>
 #include <linux/slab.h>
 #include "base.h"
 
+extern struct subsystem devices_subsys;
+
 #define to_class_attr(_attr) container_of(_attr, struct class_attribute, attr)
 #define to_class(obj) container_of(obj, struct class, subsys.kset.kobj)
 
@@ -878,7 +880,22 @@ void class_interface_unregister(struct c
 	class_put(parent);
 }
 
+int virtual_device_parent(struct device *dev)
+{
+	if (!dev->class)
+		return -ENODEV;
+
+	if (!dev->class->virtual_dir) {
+		static struct kobject *virtual_dir = NULL;
 
+		if (!virtual_dir)
+			virtual_dir = kobject_add_dir(&devices_subsys.kset.kobj, "virtual");
+		dev->class->virtual_dir = kobject_add_dir(virtual_dir, dev->class->name);
+	}
+
+	dev->kobj.parent = dev->class->virtual_dir;
+	return 0;
+}
 
 int __init classes_init(void)
 {
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 0db4756..e21a65f 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -378,6 +378,13 @@ int device_add(struct device *dev)
 	if (!dev || !strlen(dev->bus_id))
 		goto Error;
 
+	/* if this is a class device, and has no parent, create one */
+	if ((dev->class) && (dev->parent == NULL)) {
+		error = virtual_device_parent(dev);
+		if (error)
+			goto Error;
+	}
+
 	parent = get_device(dev->parent);
 
 	pr_debug("DEV: registering device: ID = '%s'\n", dev->bus_id);
diff --git a/include/linux/device.h b/include/linux/device.h
index 3400e09..bbb0d6b 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -149,6 +149,8 @@ struct class {
 	struct list_head	interfaces;
 	struct semaphore	sem;	/* locks both the children and interfaces lists */
 
+	struct kobject		*virtual_dir;
+
 	struct class_attribute		* class_attrs;
 	struct class_device_attribute	* class_dev_attrs;
 	struct device_attribute		* dev_attrs;
@@ -291,7 +293,6 @@ extern struct class_device *class_device
 					__attribute__((format(printf,5,6)));
 extern void class_device_destroy(struct class *cls, dev_t devt);
 
-
 /* interface for exporting device attributes */
 struct device_attribute {
 	struct attribute	attr;
@@ -400,6 +401,8 @@ extern struct device *device_create(stru
 				    __attribute__((format(printf,4,5)));
 extern void device_destroy(struct class *cls, dev_t devt);
 
+extern int virtual_device_parent(struct device *dev);
+
 /*
  * Platform "fixup" functions - allow the platform to have their say
  * about devices and actions that the general device layer doesn't
-- 
1.4.2.1

