Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751208AbWIWOoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbWIWOoA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 10:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWIWOoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 10:44:00 -0400
Received: from bay0-omc2-s7.bay0.hotmail.com ([65.54.246.143]:61080 "EHLO
	bay0-omc2-s7.bay0.hotmail.com") by vger.kernel.org with ESMTP
	id S1751208AbWIWOn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 10:43:59 -0400
Message-ID: <BAY105-F11E6F724B96A5A607106EAA3260@phx.gbl>
X-Originating-IP: [82.226.72.184]
X-Originating-Email: [tobiasoed@hotmail.com]
From: "Tobias Oed" <tobiasoed@hotmail.com>
To: linux-kernel@vger.kernel.org
Cc: tobiasoed@hotmail.com, akpm@osdl.org, linux-ide@vger.kernel.org,
       B.Zolnierkiewicz@elka.pw.edu.pl, alan@lxorguk.ukuu.org.uk,
       sshtylyov@ru.mvista.com
Subject: enable-cdrom-dma-access-with-pdc20265_old.patch 
Date: Sat, 23 Sep 2006 10:43:57 -0400
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_NextPart_000_7285_3099_c42"
X-OriginalArrivalTime: 23 Sep 2006 14:43:58.0756 (UTC) FILETIME=[B3F0E640:01C6DF1E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_7285_3099_c42
Content-Type: text/plain; format=flowed

If it makes things easier my patch labeled
enable-cdrom-dma-access-with-pdc20265_old.patch in -mm
could be dropped in favour of what follows (against 2.6.18),
making the feature an EXPERIMENTAL config option.
Tobias
ps: I also attach the patch since I fear mail mangling (anyone care to send
me a gmail invite?)

--- linux-2.6.18-orig/drivers/ide/Kconfig	2006-09-23 16:20:16.000000000 
+0200
+++ linux-2.6.18/drivers/ide/Kconfig	2006-09-23 16:21:29.000000000 +0200
@@ -670,6 +670,15 @@

	  If unsure, say N.

+config PDC202XX_ATAPI
+	bool "UDMA for cdroms (EXPERIMENTAL)"
+	depends on BLK_DEV_PDC202XX_OLD && EXPERIMENTAL
+	help
+	  This option allows UDMA with cdrom drives attached to
+	  a pdc202xx controller
+
+	  If unsure, say N.
+
config BLK_DEV_PDC202XX_NEW
	tristate "PROMISE PDC202{68|69|70|71|75|76|77} support"

--- linux-2.6.18-orig/drivers/ide/pci/pdc202xx_old.c	2006-09-23 
16:17:35.000000000 +0200
+++ linux-2.6.18/drivers/ide/pci/pdc202xx_old.c	2006-09-23 
15:52:56.000000000 +0200
@@ -48,6 +48,12 @@
#define PDC202_DEBUG_CABLE		0
#define PDC202XX_DEBUG_DRIVE_INFO	0

+#ifndef CONFIG_PDC202XX_ATAPI
+#define PDC202XX_CDROM_UDMA(drive) 0
+#else
+#define PDC202XX_CDROM_UDMA(drive) ((drive)->media == ide_cdrom)
+#endif
+
static const char *pdc_quirk_drives[] = {
	"QUANTUM FIREBALLlct08 08",
	"QUANTUM FIREBALLP KA6.4",
@@ -154,7 +160,8 @@
	u8			AP, BP, CP, DP;
	u8			TA = 0, TB = 0, TC = 0;

-	if ((drive->media != ide_disk) && (speed < XFER_SW_DMA_0))
+	if (drive->media != ide_disk && !PDC202XX_CDROM_UDMA(drive) &&
+	    speed < XFER_SW_DMA_0)
		return -1;

	pci_read_config_dword(dev, drive_pci, &drive_conf);
@@ -329,8 +336,7 @@
	}

chipset_is_set:
-
-	if (drive->media == ide_disk) {
+	if (drive->media == ide_disk || PDC202XX_CDROM_UDMA(drive)) {
		pci_read_config_byte(dev, (drive_pci), &AP);
		if (id->capability & 4)	/* IORDY_EN */
			pci_write_config_byte(dev, (drive_pci), AP|IORDY_EN);
@@ -385,7 +391,7 @@
{
	if (drive->current_speed > XFER_UDMA_2)
		pdc_old_enable_66MHz_clock(drive->hwif);
-	if (drive->addressing == 1) {
+	if (drive->addressing == 1 || PDC202XX_CDROM_UDMA(drive)) {
		struct request *rq	= HWGROUP(drive)->rq;
		ide_hwif_t *hwif	= HWIF(drive);
		unsigned long high_16   = hwif->dma_master;
@@ -405,7 +411,7 @@

static int pdc202xx_old_ide_dma_end(ide_drive_t *drive)
{
-	if (drive->addressing == 1) {
+	if (drive->addressing == 1 || PDC202XX_CDROM_UDMA(drive)) {
		ide_hwif_t *hwif	= HWIF(drive);
		unsigned long high_16	= hwif->dma_master;
		unsigned long atapi_reg	= high_16 + (hwif->channel ? 0x24 : 0x20);
@@ -519,6 +525,9 @@
	hwif->ultra_mask = 0x3f;
	hwif->mwdma_mask = 0x07;
	hwif->swdma_mask = 0x07;
+#ifdef CONFIG_PDC202XX_ATAPI
+	hwif->atapi_dma = 1;
+#endif

	hwif->err_stops_fifo = 1;

_________________________________________________________________
Search—Your way, your world, right now!  
http://imagine-windowslive.com/minisites/searchlaunch/?locale=en-us&FORM=WLMTAG

------=_NextPart_000_7285_3099_c42
Content-Type: text/x-patch; name="config_dma.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="config_dma.patch"

--- linux-2.6.18-orig/drivers/ide/Kconfig	2006-09-23 16:20:16.000000000 +0200
+++ linux-2.6.18/drivers/ide/Kconfig	2006-09-23 16:21:29.000000000 +0200
@@ -670,6 +670,15 @@
 
 	  If unsure, say N.
 
+config PDC202XX_ATAPI
+	bool "UDMA for cdroms (EXPERIMENTAL)"
+	depends on BLK_DEV_PDC202XX_OLD && EXPERIMENTAL
+	help
+	  This option allows UDMA with cdrom drives attached to 
+	  a pdc202xx controller
+
+	  If unsure, say N.
+
 config BLK_DEV_PDC202XX_NEW
 	tristate "PROMISE PDC202{68|69|70|71|75|76|77} support"
 
--- linux-2.6.18-orig/drivers/ide/pci/pdc202xx_old.c	2006-09-23 16:17:35.000000000 +0200
+++ linux-2.6.18/drivers/ide/pci/pdc202xx_old.c	2006-09-23 15:52:56.000000000 +0200
@@ -48,6 +48,12 @@
 #define PDC202_DEBUG_CABLE		0
 #define PDC202XX_DEBUG_DRIVE_INFO	0
 
+#ifndef CONFIG_PDC202XX_ATAPI
+#define PDC202XX_CDROM_UDMA(drive) 0
+#else
+#define PDC202XX_CDROM_UDMA(drive) ((drive)->media == ide_cdrom)
+#endif
+
 static const char *pdc_quirk_drives[] = {
 	"QUANTUM FIREBALLlct08 08",
 	"QUANTUM FIREBALLP KA6.4",
@@ -154,7 +160,8 @@
 	u8			AP, BP, CP, DP;
 	u8			TA = 0, TB = 0, TC = 0;
 
-	if ((drive->media != ide_disk) && (speed < XFER_SW_DMA_0))
+	if (drive->media != ide_disk && !PDC202XX_CDROM_UDMA(drive) &&
+	    speed < XFER_SW_DMA_0)
 		return -1;
 
 	pci_read_config_dword(dev, drive_pci, &drive_conf);
@@ -329,8 +336,7 @@
 	}
 
 chipset_is_set:
-
-	if (drive->media == ide_disk) {
+	if (drive->media == ide_disk || PDC202XX_CDROM_UDMA(drive)) {
 		pci_read_config_byte(dev, (drive_pci), &AP);
 		if (id->capability & 4)	/* IORDY_EN */
 			pci_write_config_byte(dev, (drive_pci), AP|IORDY_EN);
@@ -385,7 +391,7 @@
 {
 	if (drive->current_speed > XFER_UDMA_2)
 		pdc_old_enable_66MHz_clock(drive->hwif);
-	if (drive->addressing == 1) {
+	if (drive->addressing == 1 || PDC202XX_CDROM_UDMA(drive)) {
 		struct request *rq	= HWGROUP(drive)->rq;
 		ide_hwif_t *hwif	= HWIF(drive);
 		unsigned long high_16   = hwif->dma_master;
@@ -405,7 +411,7 @@
 
 static int pdc202xx_old_ide_dma_end(ide_drive_t *drive)
 {
-	if (drive->addressing == 1) {
+	if (drive->addressing == 1 || PDC202XX_CDROM_UDMA(drive)) {
 		ide_hwif_t *hwif	= HWIF(drive);
 		unsigned long high_16	= hwif->dma_master;
 		unsigned long atapi_reg	= high_16 + (hwif->channel ? 0x24 : 0x20);
@@ -519,6 +525,9 @@
 	hwif->ultra_mask = 0x3f;
 	hwif->mwdma_mask = 0x07;
 	hwif->swdma_mask = 0x07;
+#ifdef CONFIG_PDC202XX_ATAPI
+	hwif->atapi_dma = 1;
+#endif
 
 	hwif->err_stops_fifo = 1;
 


------=_NextPart_000_7285_3099_c42--
