Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263434AbTK1TtQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 14:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263435AbTK1TtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 14:49:16 -0500
Received: from smtpq2.home.nl ([213.51.128.197]:7332 "EHLO smtpq2.home.nl")
	by vger.kernel.org with ESMTP id S263434AbTK1TtB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 14:49:01 -0500
From: Gertjan van Wingerde <gwingerde@home.nl>
To: B.Zolnierkiewicz@elka.pw.edu.pl
Subject: [PATCH] 2.6.0-test11 IDE modularisation.
Date: Fri, 28 Nov 2003 20:48:14 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311282048.14784.gwingerde@home.nl>
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart,

Kernel 2.6.0-test11 suffers from the same IDE modularisation issues as the ones that got fixed in 2.4.23.
The patches below fixes this issue in the same manner as 2.4.23 does and work for me. 

	MvG,

		Gertjan.

[ll_rw_blk.c export, necessary for IDE module]

diff -u --recursive linux-2.6.x-original/drivers/block/ll_rw_blk.c linux-2.6.x/drivers/block/ll_rw_blk.c
--- linux-2.6.x-original/drivers/block/ll_rw_blk.c	2003-11-24 21:27:45.000000000 +0100
+++ linux-2.6.x/drivers/block/ll_rw_blk.c	2003-11-24 21:27:06.000000000 +0100
@@ -145,6 +145,8 @@
 	q->activity_data = data;
 }
 
+EXPORT_SYMBOL(blk_queue_activity_fn);
+
 /**
  * blk_queue_prep_rq - set a prepare_request function for queue
  * @q:		queue

[IDE modularisation changes]

diff -u --recursive --new-file linux-2.6.x-original/drivers/ide/Makefile linux-2.6.x/drivers/ide/Makefile
--- linux-2.6.x-original/drivers/ide/Makefile	2003-10-25 20:43:39.000000000 +0200
+++ linux-2.6.x/drivers/ide/Makefile	2003-11-26 00:43:19.000000000 +0100
@@ -12,20 +12,18 @@
 
 # Core IDE code - must come before legacy
 
-obj-$(CONFIG_BLK_DEV_IDE)		+= ide-io.o ide-probe.o ide-iops.o ide-taskfile.o ide.o ide-lib.o ide-default.o
+obj-$(CONFIG_BLK_DEV_IDE)		+= ide-core.o ide-detect.o
 obj-$(CONFIG_BLK_DEV_IDEDISK)		+= ide-disk.o
 obj-$(CONFIG_BLK_DEV_IDECD)		+= ide-cd.o
 obj-$(CONFIG_BLK_DEV_IDETAPE)		+= ide-tape.o
 obj-$(CONFIG_BLK_DEV_IDEFLOPPY)		+= ide-floppy.o
 
-obj-$(CONFIG_BLK_DEV_IDEPCI)		+= setup-pci.o
-obj-$(CONFIG_BLK_DEV_IDEDMA_PCI)	+= ide-dma.o
-obj-$(CONFIG_BLK_DEV_IDE_TCQ)		+= ide-tcq.o
-obj-$(CONFIG_BLK_DEV_IDEPNP)		+= ide-pnp.o
-
-ifeq ($(CONFIG_BLK_DEV_IDE),y)
-obj-$(CONFIG_PROC_FS)			+= ide-proc.o
-endif
+ide-core-y				:= ide-io.o ide-probe.o ide-iops.o ide-taskfile.o ide.o ide-lib.o ide-default.o
+ide-core-$(CONFIG_BLK_DEV_IDEPNP)	+= ide-pnp.o
+ide-core-$(CONFIG_BLK_DEV_IDEPCI)	+= setup-pci.o
+ide-core-$(CONFIG_BLK_DEV_IDEDMA_PCI)	+= ide-dma.o
+ide-core-$(CONFIG_BLK_DEV_IDE_TCQ)	+= ide-tcq.o
+ide-core-$(CONFIG_PROC_FS) 		+= ide-proc.o
 
 obj-$(CONFIG_BLK_DEV_IDE)		+= legacy/ ppc/ arm/
 obj-$(CONFIG_BLK_DEV_HD)		+= legacy/
diff -u --recursive --new-file linux-2.6.x-original/drivers/ide/ide-detect.c linux-2.6.x/drivers/ide/ide-detect.c
--- linux-2.6.x-original/drivers/ide/ide-detect.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.x/drivers/ide/ide-detect.c	2003-11-26 00:49:51.000000000 +0100
@@ -0,0 +1,29 @@
+/*
+ *  linux/drivers/ide/ide-detect.c	Version 1
+ *
+ *  Copyright (C) 1994-1998  Linus Torvalds & authors (see below)
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/string.h>
+#include <linux/kernel.h>
+#include <linux/kmod.h>
+
+#ifdef MODULE
+extern int ideprobe_init_module(void);
+
+int init_module (void)
+{
+    return ideprobe_init_module();
+}
+
+extern void ideprobe_cleanup_module(void);
+
+void cleanup_module (void)
+{
+    ideprobe_cleanup_module();
+}
+MODULE_LICENSE("GPL");
+#endif /* MODULE */
diff -u --recursive --new-file linux-2.6.x-original/drivers/ide/ide-probe.c linux-2.6.x/drivers/ide/ide-probe.c
--- linux-2.6.x-original/drivers/ide/ide-probe.c	2003-10-25 20:43:52.000000000 +0200
+++ linux-2.6.x/drivers/ide/ide-probe.c	2003-11-26 00:54:26.000000000 +0100
@@ -1355,20 +1355,31 @@
 }
 
 #ifdef MODULE
-int init_module (void)
+static int ideprobe_done = 0;
+
+int ideprobe_init_module (void)
 {
 	unsigned int index;
+
+	if (ideprobe_done)
+		return -EBUSY;
 	
 	for (index = 0; index < MAX_HWIFS; ++index)
 		ide_unregister(index);
 	ideprobe_init();
 	create_proc_ide_interfaces();
+	ideprobe_done++;
 	return 0;
 }
 
-void cleanup_module (void)
+EXPORT_SYMBOL(ideprobe_init_module);
+
+void ideprobe_cleanup_module (void)
 {
 	ide_probe = NULL;
 }
+
+EXPORT_SYMBOL(ideprobe_cleanup_module);
+
 MODULE_LICENSE("GPL");
 #endif /* MODULE */

