Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263447AbUJ2SDR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263447AbUJ2SDR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 14:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263455AbUJ2SCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 14:02:55 -0400
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:32684 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S263460AbUJ2R6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 13:58:30 -0400
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: Linus Torvalds <torvalds@osdl.org>
Subject: [BK PATCHES] ide-2.6 update
Date: Fri, 29 Oct 2004 20:00:31 +0200
User-Agent: KMail/1.6.2
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200410292000.32085.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please do a

	bk pull bk://bart.bkbits.net/ide-2.6

This will update the following files:

 drivers/ide/pci/hpt34x.h   |   29 -----------------------
 Documentation/ide.txt      |    7 -----
 drivers/ide/Kconfig        |   13 ----------
 drivers/ide/ide-disk.c     |    3 --
 drivers/ide/ide-proc.c     |   25 ++++++++++----------
 drivers/ide/ide-taskfile.c |   10 ++++++--
 drivers/ide/ide.c          |    9 +------
 drivers/ide/pci/cs5520.c   |    2 -
 drivers/ide/pci/cs5530.c   |    1 
 drivers/ide/pci/hpt34x.c   |   17 +++++++++++--
 drivers/ide/ppc/pmac.c     |    7 -----
 drivers/ide/setup-pci.c    |   56 +++++++++------------------------------------
 include/linux/ide.h        |   10 +++-----
 13 files changed, 55 insertions(+), 134 deletions(-)

through these ChangeSets:

<bzolnier@trik.(none)> (04/10/29 1.2341)
   [ide] ide-disk: enable stroke by default
   
   From: Jens Axboe <axboe@suse.de>
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/10/29 1.2340)
   [ide] make destroy_proc_ide_interfaces static
   
   destroy_proc_ide_interfaces is only used inside ide-proc.c;
   so lets make it static.
   
   Signed-off-by: Arjan van de Ven <arjan@infradead.org>
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/10/29 1.2339)
   [ide] kill IDEPCI_FLAG_FORCE_MASTER
   
   cs5530 overrides hwif->autodma anyway.
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/10/29 1.2338)
   [ide] setup-pci: simplify autodma logic
   
   Do not set hwif->autodma in ide_pci_setup_ports().
   All DMA capable PCI host drivers override it.
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/10/29 1.2337)
   [ide] setup-pci: small ide_get_or_set_dma_base() cleanup
   
   * hwif->dma_base is set in ->init_iops() for MMIO
   * if !dma_base then dma_base is really equal to zero
   * remove dead code from simplex check
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/10/29 1.2336)
   [ide] pmac: kill CONFIG_BLK_DEV_IDEDMA_PMAC_AUTO
   
   DMA is always used by default (->autodma is never checked).
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/10/29 1.2335)
   [ide] hpt34x: kill hpt34x.h
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/10/29 1.2334)
   [ide] remove hwif from /proc/ide/ as part of ide_unregister_hwif()
   
   Original patch from Mark Lord <lkml@rtr.ca>.
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/10/29 1.2333)
   [ide] PIO bugfix
   
   We need to k[un]map_atomic() the current page not the first page
   of the scatterlist segment.  Fixes OOPS when using HIGHMEM.
   
   Big thanks to Randy Dunlap for a lot of debugging/testing.
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

diff -Nru a/Documentation/ide.txt b/Documentation/ide.txt
--- a/Documentation/ide.txt	2004-10-29 19:39:17 +02:00
+++ b/Documentation/ide.txt	2004-10-29 19:39:17 +02:00
@@ -248,13 +248,6 @@
  			  allowing ide-floppy, ide-tape, and ide-cdrom|writers
  			  to use ide-scsi emulation on a device specific option.
 
- "hdx=stroke"		: Should you have a system w/ an AWARD Bios and your
-			  drives are larger than 32GB and it will not boot,
-			  one is required to perform a few OEM operations first.
-			  The option is called "stroke" because it allows one
-			  to "soft clip" the drive to work around a barrier
-			  limit.
-
  "idebus=xx"		: inform IDE driver of VESA/PCI bus speed in MHz,
 			  where "xx" is between 20 and 66 inclusive,
 			  used when tuning chipset PIO modes.
diff -Nru a/drivers/ide/Kconfig b/drivers/ide/Kconfig
--- a/drivers/ide/Kconfig	2004-10-29 19:39:17 +02:00
+++ b/drivers/ide/Kconfig	2004-10-29 19:39:17 +02:00
@@ -772,17 +772,6 @@
 	  This option enables the use of the sleep LED as a hard drive
 	  activity LED.
 
-config BLK_DEV_IDEDMA_PMAC_AUTO
-	bool "Use DMA by default"
-	depends on BLK_DEV_IDEDMA_PMAC
-	help
-	  This option allows the driver for the built-in IDE controller on
-	  Power Macintoshes and PowerBooks to use DMA automatically, without
-	  it having to be explicitly enabled.  This option is provided because
-	  of concerns about a couple of cases where using DMA on buggy PC
-	  hardware may have caused damage.  Saying Y should be safe on all
-	  Apple machines.
-
 config IDE_ARM
 	def_bool ARM && (ARCH_A5K || ARCH_CLPS7500 || ARCH_RPC || ARCH_SHARK)
 
@@ -1037,7 +1026,7 @@
 	  It is normally safe to answer Y; however, the default is N.
 
 config IDEDMA_AUTO
-	def_bool IDEDMA_PCI_AUTO || BLK_DEV_IDEDMA_PMAC_AUTO || IDEDMA_ICS_AUTO
+	def_bool IDEDMA_PCI_AUTO || IDEDMA_ICS_AUTO
 
 endif
 
diff -Nru a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
--- a/drivers/ide/ide-disk.c	2004-10-29 19:39:17 +02:00
+++ b/drivers/ide/ide-disk.c	2004-10-29 19:39:17 +02:00
@@ -643,9 +643,6 @@
 			 capacity, sectors_to_MB(capacity),
 			 set_max, sectors_to_MB(set_max));
 
-	if (!drive->stroke)
-		return;
-
 	if (lba48)
 		set_max = idedisk_set_max_address_ext(drive, set_max);
 	else
diff -Nru a/drivers/ide/ide-proc.c b/drivers/ide/ide-proc.c
--- a/drivers/ide/ide-proc.c	2004-10-29 19:39:17 +02:00
+++ b/drivers/ide/ide-proc.c	2004-10-29 19:39:17 +02:00
@@ -418,7 +418,7 @@
 	}
 }
 
-void destroy_proc_ide_drives(ide_hwif_t *hwif)
+static void destroy_proc_ide_drives(ide_hwif_t *hwif)
 {
 	int	d;
 
@@ -466,28 +466,29 @@
 EXPORT_SYMBOL_GPL(ide_pci_create_host_proc);
 #endif
 
-void destroy_proc_ide_interfaces(void)
+void destroy_proc_ide_interface(ide_hwif_t *hwif)
+{
+	if (hwif->proc) {
+		destroy_proc_ide_drives(hwif);
+		ide_remove_proc_entries(hwif->proc, hwif_entries);
+		remove_proc_entry(hwif->name, proc_ide_root);
+		hwif->proc = NULL;
+	}
+}
+
+static void destroy_proc_ide_interfaces(void)
 {
 	int	h;
 
 	for (h = 0; h < MAX_HWIFS; h++) {
 		ide_hwif_t *hwif = &ide_hwifs[h];
-		int exist = (hwif->proc != NULL);
 #if 0
 		if (!hwif->present)
 			continue;
 #endif
-		if (exist) {
-			destroy_proc_ide_drives(hwif);
-			ide_remove_proc_entries(hwif->proc, hwif_entries);
-			remove_proc_entry(hwif->name, proc_ide_root);
-			hwif->proc = NULL;
-		} else
-			continue;
+		destroy_proc_ide_interface(hwif);
 	}
 }
-
-EXPORT_SYMBOL(destroy_proc_ide_interfaces);
 
 extern struct seq_operations ide_drivers_op;
 static int ide_drivers_open(struct inode *inode, struct file *file)
diff -Nru a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
--- a/drivers/ide/ide-taskfile.c	2004-10-29 19:39:17 +02:00
+++ b/drivers/ide/ide-taskfile.c	2004-10-29 19:39:17 +02:00
@@ -274,14 +274,20 @@
 #ifdef CONFIG_HIGHMEM
 	unsigned long flags;
 #endif
+	unsigned int offset;
 	u8 *buf;
 
 	page = sg[hwif->cursg].page;
+	offset = sg[hwif->cursg].offset + hwif->cursg_ofs * SECTOR_SIZE;
+
+	/* get the current page and offset */
+	page = nth_page(page, (offset >> PAGE_SHIFT));
+	offset %= PAGE_SIZE;
+
 #ifdef CONFIG_HIGHMEM
 	local_irq_save(flags);
 #endif
-	buf = kmap_atomic(page, KM_BIO_SRC_IRQ) +
-	      sg[hwif->cursg].offset + (hwif->cursg_ofs * SECTOR_SIZE);
+	buf = kmap_atomic(page, KM_BIO_SRC_IRQ) + offset;
 
 	hwif->nleft--;
 	hwif->cursg_ofs++;
diff -Nru a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c	2004-10-29 19:39:17 +02:00
+++ b/drivers/ide/ide.c	2004-10-29 19:39:17 +02:00
@@ -796,9 +796,7 @@
 		DRIVER(drive)->cleanup(drive);
 	}
 
-#ifdef CONFIG_PROC_FS
-	destroy_proc_ide_drives(hwif);
-#endif
+	destroy_proc_ide_interface(hwif);
 
 	hwgroup = hwif->hwgroup;
 	/*
@@ -1854,7 +1852,7 @@
 	if (s[0] == 'h' && s[1] == 'd' && s[2] >= 'a' && s[2] <= max_drive) {
 		const char *hd_words[] = {
 			"none", "noprobe", "nowerr", "cdrom", "serialize",
-			"autotune", "noautotune", "stroke", "swapdata", "bswap",
+			"autotune", "noautotune", "minus8", "swapdata", "bswap",
 			"minus11", "remap", "remap63", "scsi", NULL };
 		unit = s[2] - 'a';
 		hw   = unit / MAX_DRIVES;
@@ -1887,9 +1885,6 @@
 				goto done;
 			case -7: /* "noautotune" */
 				drive->autotune = IDE_TUNE_NOAUTO;
-				goto done;
-			case -8: /* stroke */
-				drive->stroke = 1;
 				goto done;
 			case -9: /* "swapdata" */
 			case -10: /* "bswap" */
diff -Nru a/drivers/ide/pci/cs5520.c b/drivers/ide/pci/cs5520.c
--- a/drivers/ide/pci/cs5520.c	2004-10-29 19:39:17 +02:00
+++ b/drivers/ide/pci/cs5520.c	2004-10-29 19:39:17 +02:00
@@ -239,7 +239,7 @@
 	 *	do all the device setup for us
 	 */
 
-	ide_pci_setup_ports(dev, d, 1, 14, &index);
+	ide_pci_setup_ports(dev, d, 14, &index);
 
 	printk("Index.b %d %d\n", index.b.low, index.b.high);
 	mdelay(2000);
diff -Nru a/drivers/ide/pci/cs5530.c b/drivers/ide/pci/cs5530.c
--- a/drivers/ide/pci/cs5530.c	2004-10-29 19:39:17 +02:00
+++ b/drivers/ide/pci/cs5530.c	2004-10-29 19:39:17 +02:00
@@ -353,7 +353,6 @@
 	.channels	= 2,
 	.autodma	= AUTODMA,
 	.bootable	= ON_BOARD,
-	.flags		= IDEPCI_FLAG_FORCE_MASTER,
 };
 
 static int __devinit cs5530_init_one(struct pci_dev *dev, const struct pci_device_id *id)
diff -Nru a/drivers/ide/pci/hpt34x.c b/drivers/ide/pci/hpt34x.c
--- a/drivers/ide/pci/hpt34x.c	2004-10-29 19:39:17 +02:00
+++ b/drivers/ide/pci/hpt34x.c	2004-10-29 19:39:17 +02:00
@@ -42,7 +42,7 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 
-#include "hpt34x.h"
+#define HPT343_DEBUG_DRIVE_INFO		0
 
 static u8 hpt34x_ratemask (ide_drive_t *drive)
 {
@@ -69,7 +69,8 @@
 	u32 reg1= 0, tmp1 = 0, reg2 = 0, tmp2 = 0;
 	u8			hi_speed, lo_speed;
 
-	SPLIT_BYTE(speed, hi_speed, lo_speed);
+	hi_speed = speed >> 4;
+	lo_speed = speed & 0x0f;
 
 	if (hi_speed & 7) {
 		hi_speed = (hi_speed & 4) ? 0x01 : 0x10;
@@ -229,9 +230,19 @@
 	hwif->drives[1].autodma = hwif->autodma;
 }
 
+static ide_pci_device_t hpt34x_chipset __devinitdata = {
+	.name		= "HPT34X",
+	.init_chipset	= init_chipset_hpt34x,
+	.init_hwif	= init_hwif_hpt34x,
+	.channels	= 2,
+	.autodma	= NOAUTODMA,
+	.bootable	= NEVER_BOARD,
+	.extra		= 16
+};
+
 static int __devinit hpt34x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_pci_device_t *d = &hpt34x_chipsets[id->driver_data];
+	ide_pci_device_t *d = &hpt34x_chipset;
 	static char *chipset_names[] = {"HPT343", "HPT345"};
 	u16 pcicmd = 0;
 
diff -Nru a/drivers/ide/pci/hpt34x.h b/drivers/ide/pci/hpt34x.h
--- a/drivers/ide/pci/hpt34x.h	2004-10-29 19:39:17 +02:00
+++ /dev/null	Wed Dec 31 16:00:00 196900
@@ -1,29 +0,0 @@
-#ifndef HPT34X_H
-#define HPT34X_H
-
-#include <linux/config.h>
-#include <linux/pci.h>
-#include <linux/ide.h>
-
-#define HPT343_DEBUG_DRIVE_INFO		0
-
-#ifndef SPLIT_BYTE
-#define SPLIT_BYTE(B,H,L)	((H)=(B>>4), (L)=(B-((B>>4)<<4)))
-#endif
-
-static unsigned int init_chipset_hpt34x(struct pci_dev *, const char *);
-static void init_hwif_hpt34x(ide_hwif_t *);
-
-static ide_pci_device_t hpt34x_chipsets[] __devinitdata = {
-	{	/* 0 */
-		.name		= "HPT34X",
-		.init_chipset	= init_chipset_hpt34x,
-		.init_hwif	= init_hwif_hpt34x,
-		.channels	= 2,
-		.autodma	= NOAUTODMA,
-		.bootable	= NEVER_BOARD,
-		.extra		= 16
-	}
-};
-
-#endif /* HPT34X_H */
diff -Nru a/drivers/ide/ppc/pmac.c b/drivers/ide/ppc/pmac.c
--- a/drivers/ide/ppc/pmac.c	2004-10-29 19:39:17 +02:00
+++ b/drivers/ide/ppc/pmac.c	2004-10-29 19:39:17 +02:00
@@ -2028,13 +2028,6 @@
 	hwif->ide_dma_timeout = &__ide_dma_timeout;
 	hwif->ide_dma_lostirq = &pmac_ide_dma_lostirq;
 
-#ifdef CONFIG_BLK_DEV_IDEDMA_PMAC_AUTO
-	if (!noautodma)
-		hwif->autodma = 1;
-#endif
-	hwif->drives[0].autodma = hwif->autodma;
-	hwif->drives[1].autodma = hwif->autodma;
-
 	hwif->atapi_dma = 1;
 	switch(pmif->kind) {
 		case controller_un_ata6:
diff -Nru a/drivers/ide/setup-pci.c b/drivers/ide/setup-pci.c
--- a/drivers/ide/setup-pci.c	2004-10-29 19:39:17 +02:00
+++ b/drivers/ide/setup-pci.c	2004-10-29 19:39:17 +02:00
@@ -185,19 +185,16 @@
 second_chance_to_dma:
 #endif /* CONFIG_BLK_DEV_IDEDMA_FORCED */
 
-	if ((hwif->mmio) && (hwif->dma_base))
+	if (hwif->mmio)
 		return hwif->dma_base;
 
 	if (hwif->mate && hwif->mate->dma_base) {
 		dma_base = hwif->mate->dma_base - (hwif->channel ? 0 : 8);
 	} else {
-		dma_base = (hwif->mmio) ?
-			((unsigned long) hwif->hwif_data) :
-			(pci_resource_start(dev, 4));
+		dma_base = pci_resource_start(dev, 4);
 		if (!dma_base) {
-			printk(KERN_ERR "%s: dma_base is invalid (0x%04lx)\n",
-				hwif->cds->name, dma_base);
-			dma_base = 0;
+			printk(KERN_ERR "%s: dma_base is invalid\n",
+					hwif->cds->name);
 		}
 	}
 
@@ -251,7 +248,6 @@
 				simplex_stat = hwif->INB(dma_base + 2);
 				if (simplex_stat & 0x80) {
 					/* simplex device? */
-#if 0					
 /*
  *	At this point we haven't probed the drives so we can't make the
  *	appropriate decision. Really we should defer this problem
@@ -259,18 +255,7 @@
  *	to be the DMA end. This has to be become dynamic to handle hot
  *	plug.
  */
-					/* Don't enable DMA on a simplex channel with no drives */
-					if (!hwif->drives[0].present && !hwif->drives[1].present)
-					{
-						printk(KERN_INFO "%s: simplex device with no drives: DMA disabled\n",
-								hwif->cds->name);
-						dma_base = 0;
-					}
-					/* If our other channel has DMA then we cannot */
-					else 
-#endif					
-					if(hwif->mate && hwif->mate->dma_base) 
-					{
+					if (hwif->mate && hwif->mate->dma_base) {
 						printk(KERN_INFO "%s: simplex device: "
 							"DMA disabled\n",
 							hwif->cds->name);
@@ -488,13 +473,8 @@
  			 * Set up BM-DMA capability
 			 * (PnP BIOS should have done this)
  			 */
-			if ((d->flags & IDEPCI_FLAG_FORCE_MASTER) == 0) {
-				/*
-				 * default DMA off if we had to
-				 * configure it here
-				 */
-				hwif->autodma = 0;
-			}
+			/* default DMA off if we had to configure it here */
+			hwif->autodma = 0;
 			pci_set_master(dev);
 			if (pci_read_config_word(dev, PCI_COMMAND, &pcicmd) || !(pcicmd & PCI_COMMAND_MASTER)) {
 				printk(KERN_ERR "%s: %s error updating PCICMD\n",
@@ -530,13 +510,9 @@
  
 static int ide_setup_pci_controller(struct pci_dev *dev, ide_pci_device_t *d, int noisy, int *config)
 {
-	int ret = 0;
 	u32 class_rev;
 	u16 pcicmd;
 
-	if (!noautodma)
-		ret = 1;
-
 	if (noisy)
 		ide_setup_pci_noise(dev, d);
 
@@ -550,8 +526,6 @@
 	if (!(pcicmd & PCI_COMMAND_IO)) {	/* is device disabled? */
 		if (ide_pci_configure(dev, d))
 			return -ENODEV;
-		/* default DMA off if we had to configure it here */
-		ret = 0;
 		*config = 1;
 		printk(KERN_INFO "%s: device enabled (Linux)\n", d->name);
 	}
@@ -560,14 +534,13 @@
 	class_rev &= 0xff;
 	if (noisy)
 		printk(KERN_INFO "%s: chipset revision %d\n", d->name, class_rev);
-	return ret;
+	return 0;
 }
 
 /**
  *	ide_pci_setup_ports	-	configure ports/devices on PCI IDE
  *	@dev: PCI device
  *	@d: IDE pci device info
- *	@autodma: Should we enable DMA
  *	@pciirq: IRQ line
  *	@index: ata index to update
  *
@@ -580,7 +553,7 @@
  *	where the chipset setup is not the default PCI IDE one.
  */
  
-void ide_pci_setup_ports(struct pci_dev *dev, ide_pci_device_t *d, int autodma, int pciirq, ata_index_t *index)
+void ide_pci_setup_ports(struct pci_dev *dev, ide_pci_device_t *d, int pciirq, ata_index_t *index)
 {
 	int port;
 	int at_least_one_hwif_enabled = 0;
@@ -634,11 +607,7 @@
 
 		if (d->autodma == NODMA)
 			goto bypass_legacy_dma;
-		if (d->autodma == NOAUTODMA)
-			autodma = 0;
-		if (autodma)
-			hwif->autodma = 1;
-			
+
 		if(d->init_setup_dma)
 			d->init_setup_dma(dev, d, hwif);
 		else
@@ -671,12 +640,11 @@
  */
 static ata_index_t do_ide_setup_pci_device (struct pci_dev *dev, ide_pci_device_t *d, u8 noisy)
 {
-	int autodma = 0;
 	int pciirq = 0;
 	int tried_config = 0;
 	ata_index_t index = { .b = { .low = 0xff, .high = 0xff } };
 
-	if((autodma = ide_setup_pci_controller(dev, d, noisy, &tried_config)) < 0)
+	if (ide_setup_pci_controller(dev, d, noisy, &tried_config) < 0)
 		return index;
 
 	/*
@@ -724,7 +692,7 @@
 	if(pciirq < 0)		/* Error not an IRQ */
 		return index;
 
-	ide_pci_setup_ports(dev, d, autodma, pciirq, &index);
+	ide_pci_setup_ports(dev, d, pciirq, &index);
 
 	return index;
 }
diff -Nru a/include/linux/ide.h b/include/linux/ide.h
--- a/include/linux/ide.h	2004-10-29 19:39:17 +02:00
+++ b/include/linux/ide.h	2004-10-29 19:39:17 +02:00
@@ -739,7 +739,6 @@
 	unsigned remap_0_to_1	: 1;	/* 0=noremap, 1=remap 0->1 (for EZDrive) */
 	unsigned blocked        : 1;	/* 1=powermanagment told us not to do anything, so sleep nicely */
 	unsigned vdma		: 1;	/* 1=doing PIO over DMA 0=doing normal DMA */
-	unsigned stroke		: 1;	/* from:  hdx=stroke */
 	unsigned addressing;		/*      : 3;
 					 *  0=28-bit
 					 *  1=48-bit
@@ -1045,8 +1044,8 @@
 
 extern void proc_ide_create(void);
 extern void proc_ide_destroy(void);
-extern void destroy_proc_ide_drives(ide_hwif_t *);
 extern void create_proc_ide_interfaces(void);
+void destroy_proc_ide_interface(ide_hwif_t *);
 extern void ide_add_proc_entries(struct proc_dir_entry *, ide_proc_entry_t *, void *);
 extern void ide_remove_proc_entries(struct proc_dir_entry *, ide_proc_entry_t *);
 read_proc_t proc_ide_read_capacity;
@@ -1073,6 +1072,7 @@
 }
 #else
 static inline void create_proc_ide_interfaces(void) { ; }
+static inline void destroy_proc_ide_interface(ide_hwif_t *hwif) { ; }
 #define PROC_IDE_READ_RETURN(page,start,off,count,eof,len) return 0;
 #endif
 
@@ -1417,7 +1417,7 @@
 extern void ide_scan_pcibus(int scan_direction) __init;
 extern int ide_pci_register_driver(struct pci_driver *driver);
 extern void ide_pci_unregister_driver(struct pci_driver *driver);
-extern void ide_pci_setup_ports(struct pci_dev *dev, struct ide_pci_device_s *d, int autodma, int pciirq, ata_index_t *index);
+void ide_pci_setup_ports(struct pci_dev *, struct ide_pci_device_s *, int, ata_index_t *);
 extern void ide_setup_pci_noise (struct pci_dev *dev, struct ide_pci_device_s *d);
 
 extern void default_hwif_iops(ide_hwif_t *);
@@ -1452,9 +1452,7 @@
 enum {
 	/* Uses ISA control ports not PCI ones. */
 	IDEPCI_FLAG_ISA_PORTS		= (1 << 0),
-
-	IDEPCI_FLAG_FORCE_MASTER	= (1 << 1),
-	IDEPCI_FLAG_FORCE_PDC		= (1 << 2),
+	IDEPCI_FLAG_FORCE_PDC		= (1 << 1),
 };
 
 typedef struct ide_pci_device_s {
