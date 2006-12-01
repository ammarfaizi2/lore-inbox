Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162256AbWLAXXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162256AbWLAXXb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 18:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162238AbWLAXXB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 18:23:01 -0500
Received: from cantor2.suse.de ([195.135.220.15]:18925 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1162237AbWLAXWY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 18:22:24 -0500
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 3/36] Driver Core: Move virtual_device_parent() to core.c
Date: Fri,  1 Dec 2006 15:21:33 -0800
Message-Id: <1165015333344-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.4.1
In-Reply-To: <11650153293531-git-send-email-greg@kroah.com>
References: <20061201231620.GA7560@kroah.com> <11650153262399-git-send-email-greg@kroah.com> <11650153293531-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

It doesn't need to be global or in device.h


Cc: Kay Sievers <kay.sievers@vrfy.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/class.c   |   17 -----------------
 drivers/base/core.c    |   17 +++++++++++++++++
 include/linux/device.h |    2 --
 3 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/base/class.c b/drivers/base/class.c
index 0ff267a..2e705f6 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -893,23 +893,6 @@ void class_interface_unregister(struct c
 	class_put(parent);
 }
 
-int virtual_device_parent(struct device *dev)
-{
-	if (!dev->class)
-		return -ENODEV;
-
-	if (!dev->class->virtual_dir) {
-		static struct kobject *virtual_dir = NULL;
-
-		if (!virtual_dir)
-			virtual_dir = kobject_add_dir(&devices_subsys.kset.kobj, "virtual");
-		dev->class->virtual_dir = kobject_add_dir(virtual_dir, dev->class->name);
-	}
-
-	dev->kobj.parent = dev->class->virtual_dir;
-	return 0;
-}
-
 int __init classes_init(void)
 {
 	int retval;
diff --git a/drivers/base/core.c b/drivers/base/core.c
index d4f35d8..dbcd40b 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -384,6 +384,23 @@ void device_initialize(struct device *de
 	device_init_wakeup(dev, 0);
 }
 
+static int virtual_device_parent(struct device *dev)
+{
+	if (!dev->class)
+		return -ENODEV;
+
+	if (!dev->class->virtual_dir) {
+		static struct kobject *virtual_dir = NULL;
+
+		if (!virtual_dir)
+			virtual_dir = kobject_add_dir(&devices_subsys.kset.kobj, "virtual");
+		dev->class->virtual_dir = kobject_add_dir(virtual_dir, dev->class->name);
+	}
+
+	dev->kobj.parent = dev->class->virtual_dir;
+	return 0;
+}
+
 /**
  *	device_add - add device to device hierarchy.
  *	@dev:	device.
diff --git a/include/linux/device.h b/include/linux/device.h
index b00e027..00b29e0 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -440,8 +440,6 @@ extern struct device *device_create(stru
 				    __attribute__((format(printf,4,5)));
 extern void device_destroy(struct class *cls, dev_t devt);
 
-extern int virtual_device_parent(struct device *dev);
-
 /*
  * Platform "fixup" functions - allow the platform to have their say
  * about devices and actions that the general device layer doesn't
-- 
1.4.4.1

