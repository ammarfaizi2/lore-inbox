Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267068AbSLKIdm>; Wed, 11 Dec 2002 03:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267070AbSLKIdm>; Wed, 11 Dec 2002 03:33:42 -0500
Received: from h-64-105-35-2.SNVACAID.covad.net ([64.105.35.2]:12454 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S267068AbSLKIdj>; Wed, 11 Dec 2002 03:33:39 -0500
Date: Wed, 11 Dec 2002 00:41:04 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: Jeff Chua <jchua@fedex.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.51 ide module problem
Message-ID: <20021211004104.A362@baldur.yggdrasil.com>
References: <200212110650.WAA13780@adam.yggdrasil.com> <Pine.LNX.4.50.0212111501310.30173-100000@boston.corp.fedex.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.50.0212111501310.30173-100000@boston.corp.fedex.com>; from jchua@fedex.com on Wed, Dec 11, 2002 at 03:07:33PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 11, 2002 at 03:07:33PM +0800, Jeff Chua wrote:
> On Tue, 10 Dec 2002, Adam J. Richter wrote:
> > 	I use IDE as a module, but I had to change the Makefile to
> > build a big ide-mod.o from most of the core objects rather than
> > allowing each one to be its own module.  I believe I posted IDE
> > modularization patches at least once a couple of months ago, but it
> > seems to have fallen between the cracks.  I could repost it if need
> > be
> 
> Yes, please, send me your patch. I hope this patch works for
> module-init-tools-0.9.3

Here is a quick diff of my drivers/ide subdirectory versus stock 2.5.51.

-- 
Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=diffs

diff -u -r linux-2.5.51/drivers/ide/Kconfig linux/drivers/ide/Kconfig
--- linux-2.5.51/drivers/ide/Kconfig	2002-12-09 18:45:56.000000000 -0800
+++ linux/drivers/ide/Kconfig	2002-11-27 18:23:46.000000000 -0800
@@ -199,7 +199,7 @@
 	depends on BLK_DEV_IDE
 
 config BLK_DEV_CMD640
-	bool "CMD640 chipset bugfix/support"
+	tristate "CMD640 chipset bugfix/support"
 	depends on BLK_DEV_IDE && X86
 	---help---
 	  The CMD-Technologies CMD640 IDE chip is used on many common 486 and
@@ -247,7 +247,7 @@
 	default BLK_DEV_IDEDMA_PMAC if ALL_PPC && BLK_DEV_IDEDMA_PMAC
 
 config BLK_DEV_GENERIC
-	bool "Generic PCI IDE Chipset Support"
+	tristate "Generic PCI IDE Chipset Support"
 	depends on PCI && BLK_DEV_IDEPCI
 
 config IDEPCI_SHARE_IRQ
diff -u -r linux-2.5.51/drivers/ide/Makefile linux/drivers/ide/Makefile
--- linux-2.5.51/drivers/ide/Makefile	2002-12-09 18:45:59.000000000 -0800
+++ linux/drivers/ide/Makefile	2002-11-29 12:01:33.000000000 -0800
@@ -14,20 +14,21 @@
 
 # Core IDE code - must come before legacy
 
-obj-$(CONFIG_BLK_DEV_IDE)		+= ide-io.o ide-probe.o ide-geometry.o ide-iops.o ide-taskfile.o ide.o ide-lib.o
+obj-$(CONFIG_BLK_DEV_IDE)		+= ide-mod.o
+ide-mod-objs				+= ide-io.o ide-probe.o ide-geometry.o ide-iops.o ide-taskfile.o ide.o ide-lib.o
 obj-$(CONFIG_BLK_DEV_IDEDISK)		+= ide-disk.o
 obj-$(CONFIG_BLK_DEV_IDECD)		+= ide-cd.o
 obj-$(CONFIG_BLK_DEV_IDETAPE)		+= ide-tape.o
 obj-$(CONFIG_BLK_DEV_IDEFLOPPY)		+= ide-floppy.o
 
-obj-$(CONFIG_BLK_DEV_IDEPCI)		+= setup-pci.o
-obj-$(CONFIG_BLK_DEV_IDEDMA_PCI)	+= ide-dma.o
-obj-$(CONFIG_BLK_DEV_IDE_TCQ)		+= ide-tcq.o
-obj-$(CONFIG_BLK_DEV_ISAPNP)		+= ide-pnp.o
-
-ifeq ($(CONFIG_BLK_DEV_IDE),y)
-obj-$(CONFIG_PROC_FS)			+= ide-proc.o
-endif
+obj-ide-$(CONFIG_BLK_DEV_IDEPCI)	+= setup-pci.o
+obj-ide-$(CONFIG_BLK_DEV_IDEDMA_PCI)	+= ide-dma.o
+obj-ide-$(CONFIG_BLK_DEV_IDE_TCQ)	+= ide-tcq.o
+obj-ide-$(CONFIG_BLK_DEV_ISAPNP)	+= ide-pnp.o
+obj-ide-$(CONFIG_PROC_FS)		+= ide-proc.o
+
+ide-mod-objs				+= $(obj-ide-y)
+obj-m					+= $(obj-ide-m)
 
 obj-$(CONFIG_BLK_DEV_IDE)		+= legacy/ ppc/ arm/
 
diff -u -r linux-2.5.51/drivers/ide/ide-pnp.c linux/drivers/ide/ide-pnp.c
--- linux-2.5.51/drivers/ide/ide-pnp.c	2002-12-09 18:46:11.000000000 -0800
+++ linux/drivers/ide/ide-pnp.c	2002-10-13 04:55:11.000000000 -0700
@@ -19,6 +19,7 @@
 #include <linux/ide.h>
 #include <linux/init.h>
 
+#include <linux/module.h>
 #include <linux/isapnp.h>
 
 #define DEV_IO(dev, index) (dev->resource[index].start)
@@ -88,6 +89,18 @@
 	{	0 }
 };
 
+#ifdef MODULE
+static struct isapnp_card_id ide_isa_ids[] __initdata = {
+	{
+		card_vendor: ISAPNP_ANY_ID,
+		card_device: ISAPNP_ANY_ID,
+                devs: {	ISAPNP_DEVICE_ID('P', 'N', 'P', 0x0600) },
+	},
+	{ ISAPNP_CARD_END }
+};
+ISAPNP_CARD_TABLE(ide_isa_ids);
+#endif
+
 #define NR_PNP_DEVICES 8
 struct pnp_dev_inst {
 	struct pci_dev *dev;
diff -u -r linux-2.5.51/drivers/ide/ide-probe.c linux/drivers/ide/ide-probe.c
--- linux-2.5.51/drivers/ide/ide-probe.c	2002-12-09 18:46:10.000000000 -0800
+++ linux/drivers/ide/ide-probe.c	2002-12-09 19:03:22.000000000 -0800
@@ -831,7 +831,8 @@
 	ide_toggle_bounce(drive, 1);
 
 #ifdef CONFIG_BLK_DEV_IDE_TCQ_DEFAULT
-	HWIF(drive)->ide_dma_queued_on(drive);
+	if (HWIF(drive)->ide_dma_queued_on)
+		HWIF(drive)->ide_dma_queued_on(drive);
 #endif
 }
 
@@ -1221,10 +1222,10 @@
 	return 0;
 }
 
-#ifdef MODULE
-extern int (*ide_xlate_1024_hook)(struct block_device *, int, int, const char *);
+int (*ide_xlate_1024_hook)(struct block_device *, int, int, const char *);
+EXPORT_SYMBOL(ide_xlate_1024_hook);
 
-int init_module (void)
+int ide_probe_init (void)
 {
 	unsigned int index;
 	
@@ -1236,10 +1237,9 @@
 	return 0;
 }
 
-void cleanup_module (void)
+void ide_probe_cleanup (void)
 {
 	ide_probe = NULL;
 	ide_xlate_1024_hook = 0;
 }
 MODULE_LICENSE("GPL");
-#endif /* MODULE */
diff -u -r linux-2.5.51/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.51/drivers/ide/ide.c	2002-12-09 18:45:52.000000000 -0800
+++ linux/drivers/ide/ide.c	2002-12-09 19:03:20.000000000 -0800
@@ -2375,7 +2375,7 @@
 	ide_init_builtin_drivers();
 	initializing = 0;
 
-	return 0;
+	return ide_probe_init();
 }
 
 #ifdef MODULE
diff -u -r linux-2.5.51/drivers/ide/pci/cmd640.c linux/drivers/ide/pci/cmd640.c
--- linux-2.5.51/drivers/ide/pci/cmd640.c	2002-12-09 18:46:22.000000000 -0800
+++ linux/drivers/ide/pci/cmd640.c	2002-11-27 18:24:00.000000000 -0800
@@ -102,6 +102,7 @@
 #define CMD640_PREFETCH_MASKS 1
 
 #include <linux/config.h>
+#include <linux/module.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/delay.h>
@@ -118,11 +119,6 @@
 #include "ide_modes.h"
 
 /*
- * This flag is set in ide.c by the parameter:  ide0=cmd640_vlb
- */
-int cmd640_vlb = 0;
-
-/*
  * CMD640 specific registers definition.
  */
 
@@ -723,7 +719,7 @@
 /*
  * Probe for a cmd640 chipset, and initialize it if found.  Called from ide.c
  */
-int __init ide_probe_for_cmd640x (void)
+static int ide_probe_for_cmd640x (void)
 {
 #ifdef CONFIG_BLK_DEV_CMD640_ENHANCED
 	int second_port_toggled = 0;
@@ -883,4 +879,4 @@
 #endif
 	return 1;
 }
-
+module_init(ide_probe_for_cmd640x);

--huq684BweRXVnRxX--
