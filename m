Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266044AbUAQNTl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 08:19:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266053AbUAQNTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 08:19:37 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:9610 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266044AbUAQNSM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 08:18:12 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Witold Krecicki <adasi@kernel.pl>
Subject: [PATCH] fix/improve modular IDE (Re: [PATCH] modular IDE for 2.6.1 ugly but working fix)
Date: Sat, 17 Jan 2004 14:22:06 +0100
User-Agent: KMail/1.5.3
References: <200401171313.52545.adasi@kernel.pl>
In-Reply-To: <200401171313.52545.adasi@kernel.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401171422.06211.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On Saturday 17 of January 2004 13:13, Witold Krecicki wrote:
> Here it goes - modular 2.6 IDE - I know it's ugly (and I don't know whether
> it will work with cmd640 chipset) but it's working for me and several other
> people.

It will probably work for cmd640 but won't for all other drivers which can't
be build as modules.  What about this patch instead?  I've been working on
it from some time and I think all cornercases are covered.

Cheers,
--bart


- IDE can be used as module again (compiles and works)
- separate module for probing is no longer required
- generic/default host driver is available as ide_generic module

 linux-2.6.1-root/drivers/block/ll_rw_blk.c   |    2 +
 linux-2.6.1-root/drivers/ide/Kconfig         |    6 +++
 linux-2.6.1-root/drivers/ide/Makefile        |   39 ++++++++++++++++------
 linux-2.6.1-root/drivers/ide/ide-generic.c   |   37 +++++++++++++++++++++
 linux-2.6.1-root/drivers/ide/ide-probe.c     |   23 -------------
 linux-2.6.1-root/drivers/ide/ide.c           |   46 +++------------------------
 linux-2.6.1-root/drivers/ide/legacy/Makefile |    8 ----
 linux-2.6.1-root/drivers/ide/pci/Makefile    |    1 
 linux-2.6.1-root/include/linux/ide.h         |    1 
 linux-2.6.1/drivers/ide/ppc/Makefile         |    6 ---
 10 files changed, 80 insertions(+), 89 deletions(-)

diff -puN drivers/block/ll_rw_blk.c~modular-ide-fix drivers/block/ll_rw_blk.c
--- linux-2.6.1/drivers/block/ll_rw_blk.c~modular-ide-fix	2004-01-17 13:51:23.000000000 +0100
+++ linux-2.6.1-root/drivers/block/ll_rw_blk.c	2004-01-17 13:51:45.000000000 +0100
@@ -145,6 +145,8 @@ void blk_queue_activity_fn(request_queue
 	q->activity_data = data;
 }
 
+EXPORT_SYMBOL(blk_queue_activity_fn);
+
 /**
  * blk_queue_prep_rq - set a prepare_request function for queue
  * @q:		queue
diff -puN drivers/ide/Makefile~modular-ide-fix drivers/ide/Makefile
--- linux-2.6.1/drivers/ide/Makefile~modular-ide-fix	2004-01-17 13:31:34.000000000 +0100
+++ linux-2.6.1-root/drivers/ide/Makefile	2004-01-17 13:41:24.000000000 +0100
@@ -10,22 +10,39 @@
 # First come modules that register themselves with the core
 obj-$(CONFIG_BLK_DEV_IDE)		+= pci/
 
+ide-core-objs += ide.o ide-default.o ide-io.o ide-iops.o ide-lib.o \
+	ide-probe.o ide-taskfile.o
+
+ide-core-$(CONFIG_BLK_DEV_CMD640)	+= pci/cmd640.o
+
 # Core IDE code - must come before legacy
+ide-core-$(CONFIG_BLK_DEV_IDEPCI)	+= setup-pci.o
+ide-core-$(CONFIG_BLK_DEV_IDEDMA_PCI)	+= ide-dma.o
+ide-core-$(CONFIG_BLK_DEV_IDE_TCQ)	+= ide-tcq.o
+ide-core-$(CONFIG_PROC_FS)		+= ide-proc.o
+ide-core-$(CONFIG_BLK_DEV_IDEPNP)	+= ide-pnp.o
+
+# built-in only drivers from legacy/
+ide-core-$(CONFIG_BLK_DEV_IDE_PC9800)	+= pc9800.o
+ide-core-$(CONFIG_BLK_DEV_PDC4030)	+= pdc4030.o
+ide-core-$(CONFIG_BLK_DEV_BUDDHA)	+= buddha.o
+ide-core-$(CONFIG_BLK_DEV_FALCON_IDE)	+= falconide.o
+ide-core-$(CONFIG_BLK_DEV_GAYLE)	+= gayle.o
+ide-core-$(CONFIG_BLK_DEV_MAC_IDE)	+= macide.o
+ide-core-$(CONFIG_BLK_DEV_Q40IDE)	+= q40ide.o
+
+# built-in only drivers from ppc/
+ide-core-$(CONFIG_BLK_DEV_MPC8xx_IDE)	+= mpc8xx.o
+ide-core-$(CONFIG_BLK_DEV_IDE_PMAC)	+= pmac.o
+ide-core-$(CONFIG_BLK_DEV_IDE_SWARM)	+= swarm.o
+
+obj-$(CONFIG_BLK_DEV_IDE)		+= ide-core.o
+obj-$(CONFIG_IDE_GENERIC)		+= ide-generic.o
 
-obj-$(CONFIG_BLK_DEV_IDE)		+= ide-io.o ide-probe.o ide-iops.o ide-taskfile.o ide.o ide-lib.o ide-default.o
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
-
-obj-$(CONFIG_BLK_DEV_IDE)		+= legacy/ ppc/ arm/
+obj-$(CONFIG_BLK_DEV_IDE)		+= legacy/ arm/
 obj-$(CONFIG_BLK_DEV_HD)		+= legacy/
diff -puN drivers/ide/legacy/Makefile~modular-ide-fix drivers/ide/legacy/Makefile
--- linux-2.6.1/drivers/ide/legacy/Makefile~modular-ide-fix	2004-01-17 13:42:11.000000000 +0100
+++ linux-2.6.1-root/drivers/ide/legacy/Makefile	2004-01-17 13:42:27.000000000 +0100
@@ -2,17 +2,9 @@
 obj-$(CONFIG_BLK_DEV_ALI14XX)		+= ali14xx.o
 obj-$(CONFIG_BLK_DEV_DTC2278)		+= dtc2278.o
 obj-$(CONFIG_BLK_DEV_HT6560B)		+= ht6560b.o
-obj-$(CONFIG_BLK_DEV_IDE_PC9800)	+= pc9800.o
-obj-$(CONFIG_BLK_DEV_PDC4030)		+= pdc4030.o
 obj-$(CONFIG_BLK_DEV_QD65XX)		+= qd65xx.o
 obj-$(CONFIG_BLK_DEV_UMC8672)		+= umc8672.o
 
-obj-$(CONFIG_BLK_DEV_BUDDHA)		+= buddha.o
-obj-$(CONFIG_BLK_DEV_FALCON_IDE)	+= falconide.o
-obj-$(CONFIG_BLK_DEV_GAYLE)		+= gayle.o
-obj-$(CONFIG_BLK_DEV_MAC_IDE)		+= macide.o
-obj-$(CONFIG_BLK_DEV_Q40IDE)		+= q40ide.o
-
 obj-$(CONFIG_BLK_DEV_IDECS)		+= ide-cs.o
 
 # Last of all
diff -puN drivers/ide/pci/Makefile~modular-ide-fix drivers/ide/pci/Makefile
--- linux-2.6.1/drivers/ide/pci/Makefile~modular-ide-fix	2004-01-17 13:31:34.000000000 +0100
+++ linux-2.6.1-root/drivers/ide/pci/Makefile	2004-01-17 13:31:34.000000000 +0100
@@ -3,7 +3,6 @@ obj-$(CONFIG_BLK_DEV_ADMA100)		+= adma10
 obj-$(CONFIG_BLK_DEV_AEC62XX)		+= aec62xx.o
 obj-$(CONFIG_BLK_DEV_ALI15X3)		+= alim15x3.o
 obj-$(CONFIG_BLK_DEV_AMD74XX)		+= amd74xx.o
-obj-$(CONFIG_BLK_DEV_CMD640)		+= cmd640.o
 obj-$(CONFIG_BLK_DEV_CMD64X)		+= cmd64x.o
 obj-$(CONFIG_BLK_DEV_CS5520)		+= cs5520.o
 obj-$(CONFIG_BLK_DEV_CS5530)		+= cs5530.o
diff -puN -L drivers/ide/ppc/Makefile drivers/ide/ppc/Makefile~modular-ide-fix /dev/null
--- linux-2.6.1/drivers/ide/ppc/Makefile
+++ /dev/null	2004-01-17 00:25:55.000000000 +0100
@@ -1,6 +0,0 @@
-
-obj-$(CONFIG_BLK_DEV_MPC8xx_IDE)	+= mpc8xx.o
-obj-$(CONFIG_BLK_DEV_IDE_PMAC)		+= pmac.o
-obj-$(CONFIG_BLK_DEV_IDE_SWARM)		+= swarm.o
-
-EXTRA_CFLAGS	:= -Idrivers/ide
diff -puN drivers/ide/Kconfig~modular-ide-fix drivers/ide/Kconfig
--- linux-2.6.1/drivers/ide/Kconfig~modular-ide-fix	2004-01-17 13:31:34.000000000 +0100
+++ linux-2.6.1-root/drivers/ide/Kconfig	2004-01-17 13:31:34.000000000 +0100
@@ -296,6 +296,12 @@ config IDE_TASKFILE_IO
 
 comment "IDE chipset support/bugfixes"
 
+config IDE_GENERIC
+	tristate "generic/default IDE chipset support"
+	default y
+	help
+	  If unsure, say Y.
+
 config BLK_DEV_CMD640
 	bool "CMD640 chipset bugfix/support"
 	depends on X86
diff -puN drivers/ide/ide.c~modular-ide-fix drivers/ide/ide.c
--- linux-2.6.1/drivers/ide/ide.c~modular-ide-fix	2004-01-17 13:31:34.000000000 +0100
+++ linux-2.6.1-root/drivers/ide/ide.c	2004-01-17 13:46:04.000000000 +0100
@@ -153,7 +153,6 @@
 #include <linux/cdrom.h>
 #include <linux/seq_file.h>
 #include <linux/device.h>
-#include <linux/kmod.h>
 
 #include <asm/byteorder.h>
 #include <asm/irq.h>
@@ -443,21 +442,6 @@ u8 ide_dump_status (ide_drive_t *drive, 
 
 EXPORT_SYMBOL(ide_dump_status);
 
-
-
-void ide_probe_module (void)
-{
-	if (!ide_probe) {
-#if defined(CONFIG_KMOD) && defined(CONFIG_BLK_DEV_IDE_MODULE)
-		(void) request_module("ide-probe-mod");
-#endif /* (CONFIG_KMOD) && (CONFIG_BLK_DEV_IDE_MODULE) */
-	} else {
-		(void)ide_probe();
-	}
-}
-
-EXPORT_SYMBOL(ide_probe_module);
-
 static int ide_open (struct inode * inode, struct file * filp)
 {
 	return -ENXIO;
@@ -1033,7 +1017,7 @@ found:
 	hwif->chipset = hw->chipset;
 
 	if (!initializing) {
-		ide_probe_module();
+		probe_hwif_init(hwif);
 #ifdef CONFIG_PROC_FS
 		create_proc_ide_interfaces();
 #endif
@@ -2282,28 +2266,6 @@ static void __init probe_for_hwifs (void
 #endif /* CONFIG_BLK_DEV_IDEPNP */
 }
 
-void __init ide_init_builtin_drivers (void)
-{
-	/*
-	 * Probe for special PCI and other "known" interface chipsets
-	 */
-	probe_for_hwifs ();
-
-#ifdef CONFIG_BLK_DEV_IDE
-	if (ide_hwifs[0].io_ports[IDE_DATA_OFFSET])
-		ide_get_lock(NULL, NULL); /* for atari only */
-
-	(void) ideprobe_init();
-
-	if (ide_hwifs[0].io_ports[IDE_DATA_OFFSET])
-		ide_release_lock();	/* for atari only */
-#endif /* CONFIG_BLK_DEV_IDE */
-
-#ifdef CONFIG_PROC_FS
-	proc_ide_create();
-#endif
-}
-
 /*
  *	Actually unregister the subdriver. Called with the
  *	request lock dropped.
@@ -2607,9 +2569,13 @@ int __init ide_init (void)
 #endif
 
 	initializing = 1;
-	ide_init_builtin_drivers();
+	/* Probe for special PCI and other "known" interface chipsets. */
+	probe_for_hwifs();
 	initializing = 0;
 
+#ifdef CONFIG_PROC_FS
+	proc_ide_create();
+#endif
 	return 0;
 }
 
diff -puN /dev/null drivers/ide/ide-generic.c
--- /dev/null	2004-01-17 00:25:55.000000000 +0100
+++ linux-2.6.1-root/drivers/ide/ide-generic.c	2004-01-17 14:05:13.792216384 +0100
@@ -0,0 +1,37 @@
+
+/*
+ * generic/default IDE host driver
+ *
+ * Copyright (C) 2004 Bartlomiej Zolnierkiewicz
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/ide.h>
+
+static int __init ide_generic_init(void)
+{
+	MOD_INC_USE_COUNT;
+	if (ide_hwifs[0].io_ports[IDE_DATA_OFFSET])
+		ide_get_lock(NULL, NULL); /* for atari only */
+
+	(void)ideprobe_init();
+
+	if (ide_hwifs[0].io_ports[IDE_DATA_OFFSET])
+		ide_release_lock();	/* for atari only */
+
+#ifdef CONFIG_PROC_FS
+	create_proc_ide_interfaces();
+#endif
+	return 0;
+}
+
+static void __exit ide_generic_exit(void)
+{
+}
+
+module_init(ide_generic_init);
+module_exit(ide_generic_exit);
+
+MODULE_LICENSE("GPL");
diff -puN drivers/ide/ide-probe.c~modular-ide-fix drivers/ide/ide-probe.c
--- linux-2.6.1/drivers/ide/ide-probe.c~modular-ide-fix	2004-01-17 13:31:34.000000000 +0100
+++ linux-2.6.1-root/drivers/ide/ide-probe.c	2004-01-17 13:52:16.000000000 +0100
@@ -1323,7 +1323,6 @@ int ideprobe_init (void)
 	unsigned int index;
 	int probe[MAX_HWIFS];
 	
-	MOD_INC_USE_COUNT;
 	memset(probe, 0, MAX_HWIFS * sizeof(int));
 	for (index = 0; index < MAX_HWIFS; ++index)
 		probe[index] = !ide_hwifs[index].present;
@@ -1348,27 +1347,7 @@ int ideprobe_init (void)
 					ata_attach(&hwif->drives[unit]);
 		}
 	}
-	if (!ide_probe)
-		ide_probe = &ideprobe_init;
-	MOD_DEC_USE_COUNT;
 	return 0;
 }
 
-#ifdef MODULE
-int init_module (void)
-{
-	unsigned int index;
-	
-	for (index = 0; index < MAX_HWIFS; ++index)
-		ide_unregister(index);
-	ideprobe_init();
-	create_proc_ide_interfaces();
-	return 0;
-}
-
-void cleanup_module (void)
-{
-	ide_probe = NULL;
-}
-MODULE_LICENSE("GPL");
-#endif /* MODULE */
+EXPORT_SYMBOL_GPL(ideprobe_init);
diff -puN include/linux/ide.h~modular-ide-fix include/linux/ide.h
--- linux-2.6.1/include/linux/ide.h~modular-ide-fix	2004-01-17 13:31:34.000000000 +0100
+++ linux-2.6.1-root/include/linux/ide.h	2004-01-17 13:31:34.000000000 +0100
@@ -1231,7 +1231,6 @@ typedef struct ide_devices_s {
  */
 #ifndef _IDE_C
 extern	ide_hwif_t	ide_hwifs[];		/* master data repository */
-extern int (*ide_probe)(void);
 
 extern ide_devices_t   *idedisk;
 extern ide_devices_t   *idecd;

_

