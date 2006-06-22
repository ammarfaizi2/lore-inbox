Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030354AbWFVSbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030354AbWFVSbG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 14:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030358AbWFVSbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 14:31:06 -0400
Received: from mail.suse.de ([195.135.220.2]:4234 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030354AbWFVSaz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 14:30:55 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 9/14] [PATCH] W1: cleanups
Reply-To: Greg KH <greg@kroah.com>
Date: Thu, 22 Jun 2006 11:27:13 -0700
Message-Id: <11510008691087-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11510008662311-git-send-email-greg@kroah.com>
References: <20060622182645.GB5668@kroah.com> <11510008381000-git-send-email-greg@kroah.com> <11510008413045-git-send-email-greg@kroah.com> <11510008461301-git-send-email-greg@kroah.com> <11510008522327-git-send-email-greg@kroah.com> <11510008553417-git-send-email-greg@kroah.com> <11510008583492-git-send-email-greg@kroah.com> <11510008623474-git-send-email-greg@kroah.com> <11510008662311-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>

Nice cleanup spotted by Adrian Bunk, which was lost due to moving to the
completely new functionality.

Shame-shame-shame on me.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/w1/w1.c     |    6 ++++--
 drivers/w1/w1.h     |   10 ++++++++++
 drivers/w1/w1_int.c |   12 +-----------
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index 420be14..b41366a 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -214,11 +214,12 @@ struct device w1_master_device = {
 	.release = &w1_master_release
 };
 
-struct device_driver w1_slave_driver = {
+static struct device_driver w1_slave_driver = {
 	.name = "w1_slave_driver",
 	.bus = &w1_bus_type,
 };
 
+#if 0
 struct device w1_slave_device = {
 	.parent = NULL,
 	.bus = &w1_bus_type,
@@ -226,6 +227,7 @@ struct device w1_slave_device = {
 	.driver = &w1_slave_driver,
 	.release = &w1_slave_release
 };
+#endif  /*  0  */
 
 static ssize_t w1_master_attribute_show_name(struct device *dev, struct device_attribute *attr, char *buf)
 {
@@ -383,7 +385,7 @@ int w1_create_master_attributes(struct w
 	return sysfs_create_group(&master->dev.kobj, &w1_master_defattr_group);
 }
 
-void w1_destroy_master_attributes(struct w1_master *master)
+static void w1_destroy_master_attributes(struct w1_master *master)
 {
 	sysfs_remove_group(&master->dev.kobj, &w1_master_defattr_group);
 }
diff --git a/drivers/w1/w1.h b/drivers/w1/w1.h
index 6caccfc..3828f39 100644
--- a/drivers/w1/w1.h
+++ b/drivers/w1/w1.h
@@ -213,6 +213,16 @@ static inline struct w1_master* dev_to_w
 	return container_of(dev, struct w1_master, dev);
 }
 
+extern struct device_driver w1_master_driver;
+extern struct bus_type w1_bus_type;
+extern struct device w1_master_device;
+extern int w1_max_slave_count;
+extern int w1_max_slave_ttl;
+extern struct list_head w1_masters;
+extern struct mutex w1_mlock;
+
+extern int w1_process(void *);
+
 #endif /* __KERNEL__ */
 
 #endif /* __W1_H */
diff --git a/drivers/w1/w1_int.c b/drivers/w1/w1_int.c
index 24e7c10..475996c 100644
--- a/drivers/w1/w1_int.c
+++ b/drivers/w1/w1_int.c
@@ -30,16 +30,6 @@ #include "w1_netlink.h"
 
 static u32 w1_ids = 1;
 
-extern struct device_driver w1_master_driver;
-extern struct bus_type w1_bus_type;
-extern struct device w1_master_device;
-extern int w1_max_slave_count;
-extern int w1_max_slave_ttl;
-extern struct list_head w1_masters;
-extern struct mutex w1_mlock;
-
-extern int w1_process(void *);
-
 static struct w1_master * w1_alloc_dev(u32 id, int slave_count, int slave_ttl,
 				       struct device_driver *driver,
 				       struct device *device)
@@ -96,7 +86,7 @@ static struct w1_master * w1_alloc_dev(u
 	return dev;
 }
 
-void w1_free_dev(struct w1_master *dev)
+static void w1_free_dev(struct w1_master *dev)
 {
 	device_unregister(&dev->dev);
 }
-- 
1.4.0

