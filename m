Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030283AbVKWAuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030283AbVKWAuS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 19:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030285AbVKWAuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 19:50:17 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:275 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030283AbVKWAuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 19:50:16 -0500
Date: Wed, 23 Nov 2005 01:50:15 +0100
From: Adrian Bunk <bunk@stusta.de>
To: johnpol@2ka.mipt.ru
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/w1/: misc cleanups
Message-ID: <20051123005015.GG3963@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- make needlessly global code static
- declarations for global code belong into header files
- w1.c: #if 0 the unused struct w1_slave_device


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/w1/w1.c        |    6 ++++--
 drivers/w1/w1.h        |   10 ++++++++++
 drivers/w1/w1_family.c |    2 +-
 drivers/w1/w1_int.c    |   13 ++-----------
 drivers/w1/w1_io.c     |    2 +-
 5 files changed, 18 insertions(+), 15 deletions(-)

--- linux-2.6.15-rc1-mm2-full/drivers/w1/w1.h.old	2005-11-22 22:16:06.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/drivers/w1/w1.h	2005-11-22 22:31:28.000000000 +0100
@@ -203,6 +203,16 @@
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
--- linux-2.6.15-rc1-mm2-full/drivers/w1/w1.c.old	2005-11-22 22:13:54.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/drivers/w1/w1.c	2005-11-22 22:31:54.000000000 +0100
@@ -164,11 +164,12 @@
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
@@ -176,6 +177,7 @@
 	.driver = &w1_slave_driver,
 	.release = &w1_slave_release
 };
+#endif  /*  0  */
 
 static ssize_t w1_master_attribute_show_name(struct device *dev, struct device_attribute *attr, char *buf)
 {
@@ -355,7 +357,7 @@
 	return sysfs_create_group(&master->dev.kobj, &w1_master_defattr_group);
 }
 
-void w1_destroy_master_attributes(struct w1_master *master)
+static void w1_destroy_master_attributes(struct w1_master *master)
 {
 	sysfs_remove_group(&master->dev.kobj, &w1_master_defattr_group);
 }
--- linux-2.6.15-rc1-mm2-full/drivers/w1/w1_family.c.old	2005-11-22 22:19:20.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/drivers/w1/w1_family.c	2005-11-22 22:25:18.000000000 +0100
@@ -25,10 +25,10 @@
 #include <linux/delay.h>
 
 #include "w1_family.h"
+#include "w1.h"
 
 DEFINE_SPINLOCK(w1_flock);
 static LIST_HEAD(w1_families);
-extern void w1_reconnect_slaves(struct w1_family *f);
 
 int w1_register_family(struct w1_family *newf)
 {
--- linux-2.6.15-rc1-mm2-full/drivers/w1/w1_int.c.old	2005-11-22 22:20:46.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/drivers/w1/w1_int.c	2005-11-22 22:33:02.000000000 +0100
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
@@ -103,7 +94,7 @@
 	return dev;
 }
 
-void w1_free_dev(struct w1_master *dev)
+static void w1_free_dev(struct w1_master *dev)
 {
 	device_unregister(&dev->dev);
 }
--- linux-2.6.15-rc1-mm2-full/drivers/w1/w1_io.c.old	2005-11-22 22:29:01.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/drivers/w1/w1_io.c	2005-11-22 22:29:10.000000000 +0100
@@ -28,7 +28,7 @@
 #include "w1_log.h"
 #include "w1_io.h"
 
-int w1_delay_parm = 1;
+static int w1_delay_parm = 1;
 module_param_named(delay_coef, w1_delay_parm, int, 0);
 
 static u8 w1_crc8_table[] = {

