Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263564AbTKXAvP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 19:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263571AbTKXAvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 19:51:15 -0500
Received: from smtp.sys.beep.pl ([195.245.198.13]:40203 "EHLO maja.beep.pl")
	by vger.kernel.org with ESMTP id S263564AbTKXAvH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 19:51:07 -0500
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: modular IDE in 2.4.23
Date: Mon, 24 Nov 2003 01:50:36 +0100
User-Agent: KMail/1.5.93
Cc: Alan Cox <alan@redhat.com>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0311232221080.1292-100000@logos.cnet>
In-Reply-To: <Pine.LNX.4.44.0311232221080.1292-100000@logos.cnet>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200311240150.37065.arekm@pld-linux.org>
X-Authenticated-Id: arekm 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 24 of November 2003 01:22, Marcelo Tosatti wrote:
> Hum I think the saner approach is to remove the hotplugging indeed.
>
> Mind writting me a patch Bart? :)
Hm, maybe for 2.4.23 it is sane but then reapply it again + merge ide-core and ide-detect
since solution with ide-probe-mini works well.

Right now I've cleaned up a bit my old patch and it is attached bellow. I'm currently
compiling kernel with it (so all my tests were done with old (uglier, #include "ide-probe.c" )
version of this patch).

Also probably most of #includes from ide-probe-mini.c could be removed, too.

ps. is there some magic way to avoid need of extern int ideprobe_init_module(void); etc
in ide-probe-mini.c?

diff -urN linux-2.4.22.org/drivers/ide/ide-probe.c linux-2.4.22/drivers/ide/ide-probe.c
--- linux-2.4.22.org/drivers/ide/ide-probe.c	2003-11-23 23:01:39.000000000 +0100
+++ linux-2.4.22/drivers/ide/ide-probe.c	2003-11-23 23:05:18.000000000 +0100
@@ -1416,22 +1416,30 @@
 #ifdef MODULE
 extern int (*ide_xlate_1024_hook)(kdev_t, int, int, const char *);
 
-int init_module (void)
+static int ideprobe_done = 0;
+
+int ideprobe_init_module (void)
 {
 	unsigned int index;
+
+	if (ideprobe_done)
+    		return -EBUSY;
 	
 	for (index = 0; index < MAX_HWIFS; ++index)
 		ide_unregister(index);
 	ideprobe_init();
 	create_proc_ide_interfaces();
 	ide_xlate_1024_hook = ide_xlate_1024;
+	ideprobe_done++;
 	return 0;
 }
 
-void cleanup_module (void)
+void ideprobe_cleanup_module (void)
 {
 	ide_probe = NULL;
 	ide_xlate_1024_hook = 0;
 }
+EXPORT_SYMBOL(ideprobe_init_module);
+EXPORT_SYMBOL(ideprobe_cleanup_module);
 MODULE_LICENSE("GPL");
 #endif /* MODULE */
diff -urN linux-2.4.22.org/drivers/ide/ide-probe-mini.c linux-2.4.22/drivers/ide/ide-probe-mini.c
--- linux-2.4.22.org/drivers/ide/ide-probe-mini.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.4.22/drivers/ide/ide-probe-mini.c	2003-11-23 23:08:21.000000000 +0100
@@ -0,0 +1,29 @@
+/*
+ *  linux/drivers/ide/ide-probe-mini.c	Version 1
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
diff -urN linux-2.4.22.org/drivers/ide/Makefile linux-2.4.22/drivers/ide/Makefile
--- linux-2.4.22.org/drivers/ide/Makefile	2003-11-23 23:01:39.000000000 +0100
+++ linux-2.4.22/drivers/ide/Makefile	2003-11-23 23:02:29.000000000 +0100
@@ -9,7 +9,7 @@
 #
 
 
-export-objs := ide-iops.o ide-taskfile.o ide-proc.o ide.o ide-probe.o ide-dma.o ide-lib.o setup-pci.o ide-io.o ide-disk.o
+export-objs := ide-iops.o ide-taskfile.o ide-proc.o ide.o ide-probe.o ide-probe-mini.o ide-dma.o ide-lib.o setup-pci.o ide-io.o ide-disk.o
 
 all-subdirs	:= arm legacy pci ppc raid
 mod-subdirs	:= arm legacy pci ppc raid
@@ -28,9 +28,8 @@
 
 # Core IDE code - must come before legacy
 
-ide-core-objs	:= ide-iops.o ide-taskfile.o ide.o ide-lib.o ide-io.o ide-default.o ide-proc.o
-ide-detect-objs	:= ide-probe.o ide-geometry.o
-
+ide-core-objs	:= ide-iops.o ide-taskfile.o ide.o ide-lib.o ide-io.o ide-default.o ide-proc.o ide-probe.o ide-geometry.o
+ide-detect-objs	:= ide-probe-mini.o
 
 ifeq ($(CONFIG_BLK_DEV_IDEPCI),y)
 ide-core-objs += setup-pci.o


-- 
Arkadiusz Mi¶kiewicz    CS at FoE, Wroclaw University of Technology
arekm.pld-linux.org AM2-6BONE, 1024/3DB19BBD, arekm(at)ircnet, PLD/Linux
