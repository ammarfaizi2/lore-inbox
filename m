Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422634AbWATGIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422634AbWATGIG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 01:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422689AbWATGIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 01:08:06 -0500
Received: from mail.kroah.org ([69.55.234.183]:2711 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422634AbWATGIC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 01:08:02 -0500
Cc: bunk@stusta.de
Subject: [PATCH] W1: misc cleanups
In-Reply-To: <11377372362741@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 19 Jan 2006 22:07:16 -0800
Message-Id: <11377372364116@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] W1: misc cleanups

This patch contains the following cleanups:
- make needlessly global code static
- declarations for global code belong into header files
- w1.c: #if 0 the unused struct w1_slave_device

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Acked-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 41e00d8d7535fc78425b8ac2436a7be3d4d2ccdf
tree c9947399f54f028ea739dc4d550bd0d1a1e702c0
parent 165f27bfefd691cb7d854379ea5ba9b4450ee510
author Adrian Bunk <bunk@stusta.de> Tue, 13 Dec 2005 14:04:33 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 19 Jan 2006 21:53:26 -0800

 drivers/w1/w1.c        |    6 ++++--
 drivers/w1/w1.h        |   10 ++++++++++
 drivers/w1/w1_family.c |    2 +-
 drivers/w1/w1_int.c    |   13 ++-----------
 drivers/w1/w1_io.c     |    2 +-
 5 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index f0b47fe..5def7fb 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -164,11 +164,12 @@ struct device w1_master_device = {
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
@@ -176,6 +177,7 @@ struct device w1_slave_device = {
 	.driver = &w1_slave_driver,
 	.release = &w1_slave_release
 };
+#endif  /*  0  */
 
 static ssize_t w1_master_attribute_show_name(struct device *dev, struct device_attribute *attr, char *buf)
 {
@@ -355,7 +357,7 @@ int w1_create_master_attributes(struct w
 	return sysfs_create_group(&master->dev.kobj, &w1_master_defattr_group);
 }
 
-void w1_destroy_master_attributes(struct w1_master *master)
+static void w1_destroy_master_attributes(struct w1_master *master)
 {
 	sysfs_remove_group(&master->dev.kobj, &w1_master_defattr_group);
 }
diff --git a/drivers/w1/w1.h b/drivers/w1/w1.h
index b62e771..5f09213 100644
--- a/drivers/w1/w1.h
+++ b/drivers/w1/w1.h
@@ -203,6 +203,16 @@ static inline struct w1_master* dev_to_w
 	return container_of(dev, struct w1_master, dev);
 }
 
+extern int w1_max_slave_count;
+extern int w1_max_slave_ttl;
+extern spinlock_t w1_mlock;
+extern struct list_head w1_masters;
+extern struct device_driver w1_master_driver;
+extern struct device w1_master_device;
+
+int w1_process(void *data);
+void w1_reconnect_slaves(struct w1_family *f);
+
 #endif /* __KERNEL__ */
 
 #endif /* __W1_H */
diff --git a/drivers/w1/w1_family.c b/drivers/w1/w1_family.c
index 9e293e1..0e32c11 100644
--- a/drivers/w1/w1_family.c
+++ b/drivers/w1/w1_family.c
@@ -25,10 +25,10 @@
 #include <linux/delay.h>
 
 #include "w1_family.h"
+#include "w1.h"
 
 DEFINE_SPINLOCK(w1_flock);
 static LIST_HEAD(w1_families);
-extern void w1_reconnect_slaves(struct w1_family *f);
 
 int w1_register_family(struct w1_family *newf)
 {
diff --git a/drivers/w1/w1_int.c b/drivers/w1/w1_int.c
index c3f67ea..4724693 100644
--- a/drivers/w1/w1_int.c
+++ b/drivers/w1/w1_int.c
@@ -26,19 +26,10 @@
 #include "w1.h"
 #include "w1_log.h"
 #include "w1_netlink.h"
+#include "w1_int.h"
 
 static u32 w1_ids = 1;
 
-extern struct device_driver w1_master_driver;
-extern struct bus_type w1_bus_type;
-extern struct device w1_master_device;
-extern int w1_max_slave_count;
-extern int w1_max_slave_ttl;
-extern struct list_head w1_masters;
-extern spinlock_t w1_mlock;
-
-extern int w1_process(void *);
-
 static struct w1_master * w1_alloc_dev(u32 id, int slave_count, int slave_ttl,
 				       struct device_driver *driver,
 				       struct device *device)
@@ -103,7 +94,7 @@ static struct w1_master * w1_alloc_dev(u
 	return dev;
 }
 
-void w1_free_dev(struct w1_master *dev)
+static void w1_free_dev(struct w1_master *dev)
 {
 	device_unregister(&dev->dev);
 }
diff --git a/drivers/w1/w1_io.c b/drivers/w1/w1_io.c
index e2a0433..f7f7e8b 100644
--- a/drivers/w1/w1_io.c
+++ b/drivers/w1/w1_io.c
@@ -28,7 +28,7 @@
 #include "w1_log.h"
 #include "w1_io.h"
 
-int w1_delay_parm = 1;
+static int w1_delay_parm = 1;
 module_param_named(delay_coef, w1_delay_parm, int, 0);
 
 static u8 w1_crc8_table[] = {

