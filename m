Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261333AbSLMHxB>; Fri, 13 Dec 2002 02:53:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261492AbSLMHxB>; Fri, 13 Dec 2002 02:53:01 -0500
Received: from h-64-105-35-2.SNVACAID.covad.net ([64.105.35.2]:22217 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S261333AbSLMHw6>; Fri, 13 Dec 2002 02:52:58 -0500
Date: Thu, 12 Dec 2002 23:59:34 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: Jeff Chua <jchua@fedex.com>, alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: 2.5.51 ide module problem
Message-ID: <20021212235934.A770@baldur.yggdrasil.com>
References: <200212110650.WAA13780@adam.yggdrasil.com> <Pine.LNX.4.50.0212111501310.30173-100000@boston.corp.fedex.com> <20021211004104.A362@baldur.yggdrasil.com> <Pine.LNX.4.50.0212111711180.4632-200000@boston.corp.fedex.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.50.0212111711180.4632-200000@boston.corp.fedex.com>; from jchua@fedex.com on Wed, Dec 11, 2002 at 05:29:03PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 11, 2002 at 05:29:03PM +0800, Jeff Chua wrote:
> On Wed, 11 Dec 2002, Adam J. Richter wrote:
> > Here is a quick diff of my drivers/ide subdirectory versus stock 2.5.51.
> 
> +++ linux/drivers/ide/pci/cmd640.c      2002-11-27 18:24:00.000000000
> -int cmd640_vlb = 0;
> 
> These lines must "stay" in cmd640.c, else it won't compile.
> 
> "depmod -a" works now, but encounter a new problem when I tried to load
> ide ...
> 
> # modprobe ide-mod
> FATAL: Error inserting ide_mod (/lib/modules/2.5.51/kernel/ide-mod.ko):
> Unknown symbol in module
> ide_mod: Unknown symbol pci_enable_device_bars

	Jeff: Sorry, I forgot to include diffs for include/linux/ide.h
and drivers/pci/pci.c.  Here is a corrected patch.  I am running the
code on that machine on which I'm composing this email, and I have
also verified that cmd640.c compiled without complaint (well,
actually, I've modified the patch slightly to eliminate some unrelated
diffs).

	Alan: If you want, please feel free to merge this change.
Alternatively, if you're stepping away from 2.5 while waiting for
modules to stabilize, I'd appreciate knowing what you'd prefer be done
with incoming IDE patches (submit them to Andre and Jens, just wait,
something else?).  For what it's worth, 2.5.51 +
init-module-tools-0.9.3 is the first kernel-based module loader
configuration which works enough so that I'm able to work on other
things.  For the past few releases, I had been restoring user level
module loading.  There still are a lot of quirks with the kernel based
module loading, but you might find it sufficient to get things done.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ide.diff"

--- linux-2.5.51/include/linux/ide.h	2002-12-09 18:45:54.000000000 -0800
+++ linux/include/linux/ide.h	2002-11-27 18:24:04.000000000 -0800
@@ -1742,8 +1742,12 @@
 extern void ide_toggle_bounce(ide_drive_t *drive, int on);
 extern int ide_set_xfer_rate(ide_drive_t *drive, u8 rate);
 
+/* ide.c */
+extern int ide_probe_init(void);
+extern void ide_probe_cleanup(void);
+extern int cmd640_vlb;
 extern spinlock_t ide_lock;
 
 #define local_irq_set(flags)	do { local_save_flags((flags)); local_irq_enable(); } while (0)
--- linux-2.5.51/drivers/pci/pci.c	2002-12-09 18:45:52.000000000 -0800
+++ linux/drivers/pci/pci.c	2002-12-09 19:03:18.000000000 -0800
@@ -736,6 +736,7 @@
 EXPORT_SYMBOL(isa_bridge);
 #endif
 
+EXPORT_SYMBOL(pci_enable_device_bars);
 EXPORT_SYMBOL(pci_enable_device);
 EXPORT_SYMBOL(pci_disable_device);
 EXPORT_SYMBOL(pci_max_busnr);
diff -r -u linux-2.5.51/drivers/ide/Kconfig linux/drivers/ide/Kconfig
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
diff -r -u linux-2.5.51/drivers/ide/Makefile linux/drivers/ide/Makefile
--- linux-2.5.51/drivers/ide/Makefile	2002-12-09 18:45:59.000000000 -0800
+++ linux/drivers/ide/Makefile	2002-11-29 12:01:33.000000000 -0800
@@ -14,21 +14,22 @@
 
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
 
diff -r -u linux-2.5.51/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.51/drivers/ide/ide.c	2002-12-09 18:45:52.000000000 -0800
+++ linux/drivers/ide/ide.c	2002-12-09 19:03:20.000000000 -0800
@@ -2375,7 +2375,7 @@
 	ide_init_builtin_drivers();
 	initializing = 0;
 
-	return 0;
+	return ide_probe_init();
 }
 
 #ifdef MODULE
diff -r -u linux-2.5.51/drivers/ide/pci/cmd640.c linux/drivers/ide/pci/cmd640.c
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
--- linux-2.5.51/drivers/ide/ide-probe.c	2002-12-09 18:46:10.000000000 -0800
+++ linux/drivers/ide/ide-probe.c	2002-12-12 23:50:58.000000000 -0800
@@ -831,7 +831,8 @@
 	ide_toggle_bounce(drive, 1);
 
 #ifdef CONFIG_BLK_DEV_IDE_TCQ_DEFAULT
-	HWIF(drive)->ide_dma_queued_on(drive);
+	if (HWIF(drive)->ide_dma_queued_on)
+		HWIF(drive)->ide_dma_queued_on(drive);
 #endif
 }
 
@@ -1221,10 +1222,9 @@
 	return 0;
 }
 
-#ifdef MODULE
 extern int (*ide_xlate_1024_hook)(struct block_device *, int, int, const char *);
 
-int init_module (void)
+int ide_probe_init (void)
 {
 	unsigned int index;
 	
@@ -1236,10 +1236,9 @@
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

--ew6BAiZeqk4r7MaW--
