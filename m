Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbWGCUou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbWGCUou (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 16:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWGCUot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 16:44:49 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:64945 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751162AbWGCUos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 16:44:48 -0400
Message-ID: <44A98210.2060208@oracle.com>
Date: Mon, 03 Jul 2006 13:46:08 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: rmk+mmc@arm.linux.org.uk, lkml <linux-kernel@vger.kernel.org>
CC: akpm <akpm@osdl.org>
Subject: [Ubuntu PATCH] Build mmc_block into mmc_core directly
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Build mmc_block into mmc_core directly.

Bug Reference:
https://launchpad.net/distros/ubuntu/+source/linux-source-2.6.15/+bug/30335

Patch location:
http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-dapper.git;a=commitdiff;h=b0bf1e46d11576130fdc68d6ede8a986ce4334a1

---
 drivers/mmc/Kconfig     |   10 ----------
 drivers/mmc/Makefile    |    8 +-------
 drivers/mmc/mmc_block.c |   10 ++--------
 drivers/mmc/mmc_sysfs.c |   26 +++++++++++++++++++++-----
 4 files changed, 24 insertions(+), 30 deletions(-)

--- linux-2617-g21.orig/drivers/mmc/Kconfig
+++ linux-2617-g21/drivers/mmc/Kconfig
@@ -19,16 +19,6 @@ config MMC_DEBUG
 	  This is an option for use by developers; most people should
 	  say N here.  This enables MMC core and driver debugging.
 
-config MMC_BLOCK
-	tristate "MMC block device driver"
-	depends on MMC
-	default y
-	help
-	  Say Y here to enable the MMC block device driver support.
-	  This provides a block device driver, which you can use to
-	  mount the filesystem. Almost everyone wishing MMC support
-	  should say Y or M here.
-
 config MMC_ARMMMCI
 	tristate "ARM AMBA Multimedia Card Interface support"
 	depends on ARM_AMBA && MMC
--- linux-2617-g21.orig/drivers/mmc/Makefile
+++ linux-2617-g21/drivers/mmc/Makefile
@@ -7,12 +7,6 @@
 #
 obj-$(CONFIG_MMC)		+= mmc_core.o
 
-#
-# Media drivers
-#
-obj-$(CONFIG_MMC_BLOCK)		+= mmc_block.o
-
-#
 # Host drivers
 #
 obj-$(CONFIG_MMC_ARMMMCI)	+= mmci.o
@@ -24,7 +18,7 @@ obj-$(CONFIG_MMC_AU1X)		+= au1xmmc.o
 obj-$(CONFIG_MMC_OMAP)		+= omap.o
 obj-$(CONFIG_MMC_AT91RM9200)	+= at91_mci.o
 
-mmc_core-y := mmc.o mmc_queue.o mmc_sysfs.o
+mmc_core-y := mmc.o mmc_queue.o mmc_sysfs.o mmc_block.o
 
 ifeq ($(CONFIG_MMC_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
--- linux-2617-g21.orig/drivers/mmc/mmc_block.c
+++ linux-2617-g21/drivers/mmc/mmc_block.c
@@ -540,7 +540,7 @@ static struct mmc_driver mmc_driver = {
 	.resume		= mmc_blk_resume,
 };
 
-static int __init mmc_blk_init(void)
+int __init mmc_blk_init(void)
 {
 	int res = -ENOMEM;
 
@@ -559,17 +559,11 @@ static int __init mmc_blk_init(void)
 	return res;
 }
 
-static void __exit mmc_blk_exit(void)
+void __exit mmc_blk_exit(void)
 {
 	mmc_unregister_driver(&mmc_driver);
 	unregister_blkdev(major, "mmc");
 }
 
-module_init(mmc_blk_init);
-module_exit(mmc_blk_exit);
-
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("Multimedia Card (MMC) block device driver");
-
 module_param(major, int, 0444);
 MODULE_PARM_DESC(major, "specify the major device number for MMC block driver");
--- linux-2617-g21.orig/drivers/mmc/mmc_sysfs.c
+++ linux-2617-g21/drivers/mmc/mmc_sysfs.c
@@ -317,20 +317,36 @@ void mmc_free_host_sysfs(struct mmc_host
 	class_device_put(&host->class_dev);
 }
 
+extern int mmc_blk_init(void);
+extern void mmc_blk_exit(void);
 
 static int __init mmc_init(void)
 {
 	int ret = bus_register(&mmc_bus_type);
-	if (ret == 0) {
-		ret = class_register(&mmc_host_class);
-		if (ret)
-			bus_unregister(&mmc_bus_type);
-	}
+
+	if (ret != 0)
+		return ret;
+
+	ret = class_register(&mmc_host_class);
+	if (ret)
+		goto class_fail;
+
+	ret = mmc_blk_init();
+	if (ret)
+		goto blk_fail;
+
+	return 0;
+
+blk_fail:
+	class_unregister(&mmc_host_class);
+class_fail:
+	bus_unregister(&mmc_bus_type);
 	return ret;
 }
 
 static void __exit mmc_exit(void)
 {
+	mmc_blk_exit();
 	class_unregister(&mmc_host_class);
 	bus_unregister(&mmc_bus_type);
 }

