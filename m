Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264729AbTFAUy5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 16:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264730AbTFAUy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 16:54:57 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:49104 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264729AbTFAUyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 16:54:51 -0400
Date: Sun, 1 Jun 2003 23:08:08 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.4.21rc6-ac1: More IDE Makefile fixes
Message-ID: <20030601210808.GF29425@fs.tum.de>
References: <200305311153.h4VBrNi21640@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305311153.h4VBrNi21640@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below does the following:

drivers/Makefile:
- always add ide to subdir-y, currently CONFIG_IDE=m doesn't work as 
  expected since even in this case drivers under ide might be compiled
  statically into the kernel...

drivers/ide/Makefile:
- always go through the subdirs (currently CONFIG_BLK_DEV_IDE=m doesn't 
  work, since drivers in the subdirectories might be compiled statically 
  into the kernel)
- let ide-proc.o depend on CONFIG_PROC_FS

I've tested the compilation with both an IDE that is as much as possible 
modular and a completely statically IDE.

I haven't tested CONFIG_IDE=n.

I'm not sure whether my patch is 100% correct but the items explained 
above seem to be problems that need to be resolved.

cu
Adrian

--- linux-2.4.21-rc6-ac1-modular/drivers/Makefile.old	2003-06-01 16:11:02.000000000 +0200
+++ linux-2.4.21-rc6-ac1-modular/drivers/Makefile	2003-06-01 16:11:29.000000000 +0200
@@ -10,7 +10,7 @@
 		message/i2o message/fusion scsi md ieee1394 pnp isdn atm \
 		fc4 net/hamradio i2c acpi bluetooth
 
-subdir-y :=	parport char block net sound misc media cdrom hotplug
+subdir-y :=	parport char block net sound misc media cdrom hotplug ide
 subdir-m :=	$(subdir-y)
 
 
@@ -31,7 +31,6 @@
 subdir-$(CONFIG_INPUT)		+= input
 subdir-$(CONFIG_PHONE)		+= telephony
 subdir-$(CONFIG_SGI)		+= sgi
-subdir-$(CONFIG_IDE)		+= ide
 subdir-$(CONFIG_SCSI)		+= scsi
 subdir-$(CONFIG_I2O)		+= message/i2o
 subdir-$(CONFIG_FUSION)		+= message/fusion
--- linux-2.4.21-rc6-ac1-modular/drivers/ide/Makefile.old	2003-06-01 16:45:53.000000000 +0200
+++ linux-2.4.21-rc6-ac1-modular/drivers/ide/Makefile	2003-06-01 16:53:28.000000000 +0200
@@ -11,24 +11,25 @@
 
 export-objs := ide-iops.o ide-taskfile.o ide-proc.o ide.o ide-probe.o ide-dma.o ide-lib.o setup-pci.o ide-io.o ide-disk.o
 
-all-subdirs	:= arm legacy pci ppc raid
-mod-subdirs	:= arm legacy pci ppc raid
+subdir-y	:= arm legacy pci ppc raid
+subdir-m	:= arm legacy pci ppc raid
 
 obj-y		:=
 obj-m		:=
 ide-obj-y	:=
 
-subdir-$(CONFIG_BLK_DEV_IDE) += legacy ppc arm raid pci
-
 # First come modules that register themselves with the core
 
-ifeq ($(CONFIG_BLK_DEV_IDE),y)
-  obj-y		+= pci/idedriver-pci.o
-endif
+obj-y		+= pci/idedriver-pci.o
 
 # Core IDE code - must come before legacy
 
-ide-core-objs	:= ide-iops.o ide-taskfile.o ide.o ide-lib.o ide-io.o ide-default.o ide-proc.o
+ide-core-objs	:= ide-iops.o ide-taskfile.o ide.o ide-lib.o ide-io.o ide-default.o
+
+ifeq ($(CONFIG_PROC_FS),y)
+  ide-core-objs	+= ide-proc.o
+endif
+
 ide-detect-objs	:= ide-probe.o ide-geometry.o
 
 
@@ -48,15 +49,9 @@
 
 obj-$(CONFIG_BLK_DEV_IDE)		+= ide-core.o
 
-ifeq ($(CONFIG_BLK_DEV_IDE),y)
-  obj-y		+= legacy/idedriver-legacy.o
-  obj-y		+= ppc/idedriver-ppc.o
-  obj-y		+= arm/idedriver-arm.o
-else
-  ifeq ($(CONFIG_BLK_DEV_HD_ONLY),y)
-	obj-y	+= legacy/idedriver-legacy.o
-  endif
-endif
+obj-y		+= legacy/idedriver-legacy.o
+obj-y		+= ppc/idedriver-ppc.o
+obj-y		+= arm/idedriver-arm.o
 
 obj-$(CONFIG_BLK_DEV_ISAPNP) 		+= ide-pnp.o
 
@@ -67,10 +62,8 @@
 
 obj-$(CONFIG_BLK_DEV_IDE) += ide-detect.o
 
-ifeq ($(CONFIG_BLK_DEV_IDE),y)
 # RAID must be last of all
-  obj-y		+= raid/idedriver-raid.o
-endif
+obj-y		+= raid/idedriver-raid.o
 
 list-multi	:= ide-core.o ide-detect.o
 O_TARGET := idedriver.o
