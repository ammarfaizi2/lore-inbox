Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275201AbTHQGS0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 02:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275639AbTHQGQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 02:16:57 -0400
Received: from codepoet.org ([166.70.99.138]:61583 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S275279AbTHQGOI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 02:14:08 -0400
Date: Sun, 17 Aug 2003 00:14:10 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andries Brouwer <aebr@win.tue.nl>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 8/8 Backport recent 2.6 IDE updates to 2.4.x
Message-ID: <20030817061410.GI17621@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Andries Brouwer <aebr@win.tue.nl>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch limits drive capacity to 137GB if host doesn't support
LBA48.  This fixes some serious problems (see the recent thread on
"uncorrectable ext2 errors").

This also kills the probe_lba_addressing() wrapper, and renames
"hwif->addressing" to "hwif->no_lba48".  This is because
"hwif->addressing" is way too similar to "drive->addressing"
which has a totally different meaning.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--

--- orig/drivers/ide/ide-disk.c	2003-08-16 21:37:43.000000000 -0600
+++ linux-2.4.21/drivers/ide/ide-disk.c	2003-08-16 21:37:43.000000000 -0600
@@ -1545,11 +1545,17 @@
 	return 0;
 }
 
-static int probe_lba_addressing (ide_drive_t *drive, int arg)
+/*
+ * drive->addressing:
+ *	0: 28-bit
+ *	1: 48-bit
+ *	2: 48-bit capable doing 28-bit
+ */
+static int set_lba_addressing(ide_drive_t *drive, int arg)
 {
 	drive->addressing =  0;
 
-	if (HWIF(drive)->addressing)
+	if (HWIF(drive)->no_lba48)
 		return 0;
 
 	if (!idedisk_supports_lba48(drive->id))
@@ -1558,11 +1564,6 @@
 	return 0;
 }
 
-static int set_lba_addressing (ide_drive_t *drive, int arg)
-{
-	return (probe_lba_addressing(drive, arg));
-}
-
 static void idedisk_add_settings(ide_drive_t *drive)
 {
 	struct hd_driveid *id = drive->id;
@@ -1638,13 +1639,7 @@
 		break;
 	}
 
-#if 1
-	(void) probe_lba_addressing(drive, 1);
-#else
-	/* if using 48-bit addressing bump the request size up */
-	if (probe_lba_addressing(drive, 1))
-		blk_queue_max_sectors(&drive->queue, 2048);
-#endif
+	(void)set_lba_addressing(drive, 1);
 
 	/* Extract geometry if we did not already have one for the drive */
 	if (!drive->cyl || !drive->head || !drive->sect) {
@@ -1671,6 +1666,15 @@
 	/* calculate drive capacity, and select LBA if possible */
 	init_idedisk_capacity (drive);
 
+	/* limit drive capacity to 137GB if LBA48 cannot be used */
+	if (drive->addressing == 0 && drive->capacity64 > 1ULL << 28) {
+		printk("%s: cannot use LBA48 - full capacity "
+		       "%llu sectors (%llu MB)\n",
+		       drive->name,
+		       drive->capacity64, sectors_to_MB(drive->capacity64));
+		drive->capacity64 = 1ULL << 28;
+	}
+
 	/*
 	 * if possible, give fdisk access to more of the drive,
 	 * by correcting bios_cyls:
--- orig/drivers/ide/ide-probe.c	2003-08-16 21:37:43.000000000 -0600
+++ linux-2.4.21/drivers/ide/ide-probe.c	2003-08-16 21:37:43.000000000 -0600
@@ -1196,6 +1196,8 @@
 		*bs++ = BLOCK_SIZE;
 		/*
 		 * IDE can do up to 128K per request == 256
+		 * TODO: should this change depending on the value
+		 * of hwif->no_lba48?
 		 */
 		*max_sect++ = ((hwif->rqsize) ? hwif->rqsize : 128);
 		*max_ra++ = vm_max_readahead;
--- orig/drivers/ide/ide.c	2003-08-16 21:37:43.000000000 -0600
+++ linux-2.4.21/drivers/ide/ide.c	2003-08-16 21:37:43.000000000 -0600
@@ -872,7 +872,7 @@
 
 	hwif->mmio			= old_hwif.mmio;
 	hwif->rqsize			= old_hwif.rqsize;
-	hwif->addressing		= old_hwif.addressing;
+	hwif->no_lba48			= old_hwif.no_lba48;
 #ifndef CONFIG_BLK_DEV_IDECS
 	hwif->irq			= old_hwif.irq;
 #endif /* CONFIG_BLK_DEV_IDECS */
--- orig/drivers/ide/legacy/pdc4030.c	2003-08-16 21:37:43.000000000 -0600
+++ linux-2.4.21/drivers/ide/legacy/pdc4030.c	2003-08-16 21:37:43.000000000 -0600
@@ -225,7 +225,7 @@
 	hwif2->mate	= hwif;
 	hwif2->channel	= 1;
 	hwif->rqsize	= hwif2->rqsize = 127;
-	hwif->addressing = hwif2->addressing = 1;
+	hwif->no_lba48 = hwif2->no_lba48 = 1;
 	hwif->selectproc = hwif2->selectproc = &promise_selectproc;
 	hwif->serialized = hwif2->serialized = 1;
 	/* DC4030 hosted drives need their own identify... */
--- orig/drivers/ide/pci/alim15x3.c	2003-08-16 21:37:43.000000000 -0600
+++ linux-2.4.21/drivers/ide/pci/alim15x3.c	2003-08-16 21:37:43.000000000 -0600
@@ -760,7 +760,7 @@
 	hwif->speedproc = &ali15x3_tune_chipset;
 
 	/* Don't use LBA48 on ALi devices before rev 0xC5 */
-	hwif->addressing = (m5229_revision <= 0xC4) ? 1 : 0;
+	hwif->no_lba48 = (m5229_revision <= 0xC4) ? 1 : 0;
 
 	if (!hwif->dma_base) {
 		hwif->drives[0].autotune = 1;
--- orig/drivers/ide/pci/pdc202xx_old.c	2003-08-16 21:37:43.000000000 -0600
+++ linux-2.4.21/drivers/ide/pci/pdc202xx_old.c	2003-08-16 21:37:43.000000000 -0600
@@ -698,7 +698,7 @@
 	hwif->quirkproc = &pdc202xx_quirkproc;
 
 	if (hwif->pci_dev->device == PCI_DEVICE_ID_PROMISE_20265)
-		hwif->addressing = (hwif->channel) ? 0 : 1;
+		hwif->no_lba48 = (hwif->channel) ? 0 : 1;
 
 	if (hwif->pci_dev->device != PCI_DEVICE_ID_PROMISE_20246) {
 		hwif->busproc   = &pdc202xx_tristate;
--- orig/drivers/ide/pci/siimage.c	2003-08-16 21:37:43.000000000 -0600
+++ linux-2.4.21/drivers/ide/pci/siimage.c	2003-08-16 21:37:43.000000000 -0600
@@ -992,7 +992,7 @@
 	 *	use LBA48 mode.
 	 */	
 //	base += 0x10;
-//      hwif->addressing = 1;
+//	hwif->no_lba48 = 1;
 
 	hw.io_ports[IDE_DATA_OFFSET]	= base;
 	hw.io_ports[IDE_ERROR_OFFSET]	= base + 1;
--- orig/drivers/ide/pci/trm290.c	2003-08-16 21:37:43.000000000 -0600
+++ linux-2.4.21/drivers/ide/pci/trm290.c	2003-08-16 21:37:43.000000000 -0600
@@ -309,7 +309,7 @@
 	u8 reg = 0;
 	struct pci_dev *dev = hwif->pci_dev;
 
-	hwif->addressing = 1;
+	hwif->no_lba48 = 1;
 	hwif->chipset = ide_trm290;
 	cfgbase = pci_resource_start(dev, 4);
 	if ((dev->class & 5) && cfgbase) {
--- orig/include/linux/ide.h	2003-08-16 21:37:43.000000000 -0600
+++ linux-2.4.21/include/linux/ide.h	2003-08-16 21:37:43.000000000 -0600
@@ -971,7 +971,6 @@
 
 	int		mmio;		/* hosts iomio (0), mmio (1) or custom (2) select */
 	int		rqsize;		/* max sectors per request */
-	int		addressing;	/* hosts addressing */
 	int		irq;		/* our irq number */
 	int		initializing;	/* set while initializing self */
 
@@ -1000,6 +999,7 @@
 	unsigned	reset      : 1;	/* reset after probe */
 	unsigned	autodma    : 1;	/* auto-attempt using DMA at boot */
 	unsigned	udma_four  : 1;	/* 1=ATA-66 capable, 0=default */
+	unsigned	no_lba48   : 1; /* 1 = cannot do LBA48 */
 	unsigned	highmem    : 1;	/* can do full 32-bit dma */
 	unsigned	no_dsc     : 1;	/* 0 default, 1 dsc_overlap disabled */
 
