Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263628AbTIBISg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 04:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263634AbTIBISg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 04:18:36 -0400
Received: from dp.samba.org ([66.70.73.150]:5526 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263628AbTIBIS3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 04:18:29 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: akpm@zip.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] MODULE_ALIAS() in block devices
Date: Tue, 02 Sep 2003 18:17:02 +1000
Message-Id: <20030902081829.1826B2C14F@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Name: MODULE_ALIAS inside modules: block devices
Author: Rusty Russell
Status: Booted on 2.6.0-test4-bk3

D: Previously, default aliases were hardwired into modutils.  Now they
D: should be inside the modules, using MODULE_ALIAS() (they will be overridden
D: by any user alias).

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.0-test2/include/linux/blkdev.h working-2.6.0-test2-aliases/include/linux/blkdev.h
--- linux-2.6.0-test2/include/linux/blkdev.h	2003-07-30 09:39:10.000000000 +1000
+++ working-2.6.0-test2-aliases/include/linux/blkdev.h	2003-07-28 04:35:30.000000000 +1000
@@ -12,6 +12,8 @@
 #include <linux/wait.h>
 #include <linux/mempool.h>
 #include <linux/bio.h>
+#include <linux/module.h>
+#include <linux/stringify.h>
 
 #include <asm/scatterlist.h>
 
@@ -667,6 +665,11 @@ void kblockd_flush(void);
 } \
 )
 #endif 
+
+#define MODULE_ALIAS_BLOCKDEV(major,minor) \
+	MODULE_ALIAS("block-major-" __stringify(major) "-" __stringify(minor))
+#define MODULE_ALIAS_BLOCKDEV_MAJOR(major) \
+	MODULE_ALIAS("block-major-" __stringify(major) "-*")
+
- 
 
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.0-test2/drivers/block/floppy.c working-2.6.0-test2-aliases/drivers/block/floppy.c
--- linux-2.6.0-test2/drivers/block/floppy.c	2003-07-30 09:39:02.000000000 +1000
+++ working-2.6.0-test2-aliases/drivers/block/floppy.c	2003-07-28 04:35:20.000000000 +1000
@@ -4599,3 +4599,5 @@ MODULE_PARM(FLOPPY_DMA,"i");
 __setup ("floppy=", floppy_setup);
 module_init(floppy_init)
 #endif
+
+MODULE_ALIAS_BLOCKDEV_MAJOR(FLOPPY_MAJOR);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.0-test2/drivers/block/xd.c working-2.6.0-test2-aliases/drivers/block/xd.c
--- linux-2.6.0-test2/drivers/block/xd.c	2003-07-30 09:40:05.000000000 +1000
+++ working-2.6.0-test2-aliases/drivers/block/xd.c	2003-07-28 04:35:20.000000000 +1000
@@ -1098,5 +1098,5 @@ __setup ("xd_geo=", xd_manual_geo_init);
 
 #endif /* MODULE */
 
+module_init(xd_init);
+MODULE_ALIAS_BLOCKDEV_MAJOR(XT_DISK_MAJOR);
-module_init(xd_init)
-
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.0-test2/drivers/cdrom/aztcd.c working-2.6.0-test2-aliases/drivers/cdrom/aztcd.c
--- linux-2.6.0-test2/drivers/cdrom/aztcd.c	2003-07-30 09:54:38.000000000 +1000
+++ working-2.6.0-test2-aliases/drivers/cdrom/aztcd.c	2003-07-28 04:35:20.000000000 +1000
@@ -2492,3 +2492,4 @@ static int azt_bcd2bin(unsigned char bcd
 }
 
 MODULE_LICENSE("GPL");
+MODULE_ALIAS_BLOCKDEV_MAJOR(AZTECH_CDROM_MAJOR);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.0-test2/drivers/cdrom/cdu31a.c working-2.6.0-test2-aliases/drivers/cdrom/cdu31a.c
--- linux-2.6.0-test2/drivers/cdrom/cdu31a.c	2003-07-30 09:42:23.000000000 +1000
+++ working-2.6.0-test2-aliases/drivers/cdrom/cdu31a.c	2003-07-28 04:35:20.000000000 +1000
@@ -3495,3 +3495,4 @@ module_init(cdu31a_init);
 module_exit(cdu31a_exit);
 
 MODULE_LICENSE("GPL");
+MODULE_ALIAS_BLOCKDEV_MAJOR(CDU31A_CDROM_MAJOR);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.0-test2/drivers/cdrom/cm206.c working-2.6.0-test2-aliases/drivers/cdrom/cm206.c
--- linux-2.6.0-test2/drivers/cdrom/cm206.c	2003-07-30 09:55:04.000000000 +1000
+++ working-2.6.0-test2-aliases/drivers/cdrom/cm206.c	2003-07-28 04:35:20.000000000 +1000
@@ -1611,7 +1611,7 @@ static int __init cm206_setup(char *s)
 __setup("cm206=", cm206_setup);
 
 #endif				/* !MODULE */
+MODULE_ALIAS_BLOCKDEV_MAJOR(CM206_CDROM_MAJOR);
-
 
 /*
  * Local variables:
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.0-test2/drivers/cdrom/gscd.c working-2.6.0-test2-aliases/drivers/cdrom/gscd.c
--- linux-2.6.0-test2/drivers/cdrom/gscd.c	2003-07-30 09:44:10.000000000 +1000
+++ working-2.6.0-test2-aliases/drivers/cdrom/gscd.c	2003-07-28 04:35:20.000000000 +1000
@@ -1023,3 +1023,4 @@ MODULE_AUTHOR("Oliver Raupach <raupach@n
 MODULE_LICENSE("GPL");
 module_init(gscd_init);
 module_exit(gscd_exit);
+MODULE_ALIAS_BLOCKDEV_MAJOR(GOLDSTAR_CDROM_MAJOR);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.0-test2/drivers/cdrom/mcd.c working-2.6.0-test2-aliases/drivers/cdrom/mcd.c
--- linux-2.6.0-test2/drivers/cdrom/mcd.c	2003-07-30 09:46:43.000000000 +1000
+++ working-2.6.0-test2-aliases/drivers/cdrom/mcd.c	2003-07-28 04:35:20.000000000 +1000
@@ -1556,3 +1556,4 @@ module_exit(mcd_exit);
 
 MODULE_AUTHOR("Martin Harriss");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS_BLOCKDEV_MAJOR(MITSUMI_CDROM_MAJOR);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.0-test2/drivers/cdrom/mcdx.c working-2.6.0-test2-aliases/drivers/cdrom/mcdx.c
--- linux-2.6.0-test2/drivers/cdrom/mcdx.c	2003-07-30 09:46:21.000000000 +1000
+++ working-2.6.0-test2-aliases/drivers/cdrom/mcdx.c	2003-07-28 04:35:20.000000000 +1000
@@ -1962,3 +1962,4 @@ static int mcdx_setattentuator(struct s_
 }
 
 MODULE_LICENSE("GPL");
+MODULE_ALIAS_BLOCKDEV_MAJOR(MITSUMI_X_CDROM_MAJOR);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.0-test2/drivers/cdrom/optcd.c working-2.6.0-test2-aliases/drivers/cdrom/optcd.c
--- linux-2.6.0-test2/drivers/cdrom/optcd.c	2003-07-30 09:45:32.000000000 +1000
+++ working-2.6.0-test2-aliases/drivers/cdrom/optcd.c	2003-07-28 04:35:20.000000000 +1000
@@ -2095,3 +2095,4 @@ module_init(optcd_init);
 module_exit(optcd_exit);
 
 MODULE_LICENSE("GPL");
+MODULE_ALIAS_BLOCKDEV_MAJOR(OPTICS_CDROM_MAJOR);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.0-test2/drivers/cdrom/sbpcd.c working-2.6.0-test2-aliases/drivers/cdrom/sbpcd.c
--- linux-2.6.0-test2/drivers/cdrom/sbpcd.c	2003-07-30 09:54:16.000000000 +1000
+++ working-2.6.0-test2-aliases/drivers/cdrom/sbpcd.c	2003-07-28 04:35:20.000000000 +1000
@@ -5946,6 +5946,9 @@ static int sbpcd_media_changed(struct cd
 }
 
 MODULE_LICENSE("GPL");
+/* FIXME: Old modules.conf claims MATSUSHITA_CDROM2_MAJOR and CDROM3, but
+   AFAICT this doesn't support those majors, so why? --RR 30 Jul 2003 */
+MODULE_ALIAS_BLOCKDEV_MAJOR(MATSUSHITA_CDROM_MAJOR);
 
 /*==========================================================================*/
 /*
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.0-test2/drivers/cdrom/sjcd.c working-2.6.0-test2-aliases/drivers/cdrom/sjcd.c
--- linux-2.6.0-test2/drivers/cdrom/sjcd.c	2003-07-30 09:45:54.000000000 +1000
+++ working-2.6.0-test2-aliases/drivers/cdrom/sjcd.c	2003-07-28 04:35:20.000000000 +1000
@@ -1809,3 +1809,4 @@ module_init(sjcd_init);
 module_exit(sjcd_exit);
 
 MODULE_LICENSE("GPL");
+MODULE_ALIAS_BLOCKDEV_MAJOR(SANYO_CDROM_MAJOR);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.0-test2/drivers/cdrom/sonycd535.c working-2.6.0-test2-aliases/drivers/cdrom/sonycd535.c
--- linux-2.6.0-test2/drivers/cdrom/sonycd535.c	2003-07-30 09:47:01.000000000 +1000
+++ working-2.6.0-test2-aliases/drivers/cdrom/sonycd535.c	2003-07-28 04:35:20.000000000 +1000
@@ -1678,3 +1678,4 @@ module_exit(sony535_exit);
 
 
 MODULE_LICENSE("GPL");
+MODULE_ALIAS_BLOCKDEV_MAJOR(CDU535_CDROM_MAJOR);

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
