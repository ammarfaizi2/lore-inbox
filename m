Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266380AbTGEQDk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 12:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266385AbTGEQDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 12:03:40 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:9347
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S266380AbTGEQDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 12:03:22 -0400
Date: Sat, 5 Jul 2003 17:16:38 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307051616.h65GGcv7002815@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: PATCH: (new) Turn on the IDE modular stuff in the Makefile
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This isnt perfect but it is a start

diff --exclude-from /usr/src/exclude -u --recursive linux.22-bk2/drivers/ide/Makefile linux.22-pre2-ac1/drivers/ide/Makefile
--- linux.22-bk2/drivers/ide/Makefile	2003-07-05 16:58:51.000000000 +0100
+++ linux.22-pre2-ac1/drivers/ide/Makefile	2003-06-29 16:10:17.000000000 +0100
@@ -8,7 +8,6 @@
 # In the future, some of these should be built conditionally.
 #
 
-O_TARGET := idedriver.o
 
 export-objs := ide-iops.o ide-taskfile.o ide-proc.o ide.o ide-probe.o ide-dma.o ide-lib.o setup-pci.o ide-io.o ide-disk.o
 
@@ -29,24 +28,25 @@
 
 # Core IDE code - must come before legacy
 
-obj-$(CONFIG_BLK_DEV_IDE)		+= ide-probe.o ide-geometry.o ide-iops.o ide-taskfile.o ide.o ide-lib.o ide-io.o ide-default.o
-obj-$(CONFIG_BLK_DEV_IDEDISK)		+= ide-disk.o
-obj-$(CONFIG_BLK_DEV_IDECD)		+= ide-cd.o
-obj-$(CONFIG_BLK_DEV_IDETAPE)		+= ide-tape.o
-obj-$(CONFIG_BLK_DEV_IDEFLOPPY)		+= ide-floppy.o
+ide-core-objs	:= ide-iops.o ide-taskfile.o ide.o ide-lib.o ide-io.o ide-default.o ide-proc.o
+ide-detect-objs	:= ide-probe.o ide-geometry.o
+
 
 ifeq ($(CONFIG_BLK_DEV_IDEPCI),y)
-obj-$(CONFIG_BLK_DEV_IDE)		+= setup-pci.o
+ide-core-objs += setup-pci.o
 endif
 ifeq ($(CONFIG_BLK_DEV_IDEDMA_PCI),y)
-obj-$(CONFIG_BLK_DEV_IDE)		+= ide-dma.o
+ide-core-objs += ide-dma.o
 endif
-obj-$(CONFIG_BLK_DEV_ISAPNP)		+= ide-pnp.o
 
+# Initialisation order:
+#	Core sets up
+#	Legacy drivers may register a callback
+#	Drivers are pre initialised
+#	Probe inits the drivers and driver callbacks
+#	Raid scans the devices
 
-ifeq ($(CONFIG_BLK_DEV_IDE),y)
-obj-$(CONFIG_PROC_FS)			+= ide-proc.o
-endif
+obj-$(CONFIG_BLK_DEV_IDE)		+= ide-core.o
 
 ifeq ($(CONFIG_BLK_DEV_IDE),y)
   obj-y		+= legacy/idedriver-legacy.o
@@ -58,10 +58,28 @@
   endif
 endif
 
+obj-$(CONFIG_BLK_DEV_ISAPNP) 		+= ide-pnp.o
+
+obj-$(CONFIG_BLK_DEV_IDEDISK)		+= ide-disk.o
+obj-$(CONFIG_BLK_DEV_IDECD)		+= ide-cd.o
+obj-$(CONFIG_BLK_DEV_IDETAPE)		+= ide-tape.o
+obj-$(CONFIG_BLK_DEV_IDEFLOPPY)		+= ide-floppy.o
+
+obj-$(CONFIG_BLK_DEV_IDE) += ide-detect.o
 
 ifeq ($(CONFIG_BLK_DEV_IDE),y)
 # RAID must be last of all
   obj-y		+= raid/idedriver-raid.o
 endif
 
+list-multi	:= ide-core.o ide-detect.o
+O_TARGET := idedriver.o
+
 include $(TOPDIR)/Rules.make
+
+ide-core.o:	$(ide-core-objs)
+	$(LD) -r -o $@ $(ide-core-objs)
+
+ide-detect.o:	$(ide-detect-objs)
+	$(LD) -r -o $@ $(ide-detect-objs)
+
