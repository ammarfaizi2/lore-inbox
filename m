Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161326AbWF0Vml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161326AbWF0Vml (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 17:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161325AbWF0Vml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 17:42:41 -0400
Received: from homer.mvista.com ([63.81.120.155]:50748 "EHLO
	imap.sh.mvista.com") by vger.kernel.org with ESMTP id S1161323AbWF0Vmi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 17:42:38 -0400
Message-ID: <44A1A609.8060201@ru.mvista.com>
Date: Wed, 28 Jun 2006 01:41:29 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH][RFT] HPT3xx: init code rewrite
References: <444B3BDE.1030106@ru.mvista.com> <4457DC97.3010807@ru.mvista.com> <445A5A1B.60903@ru.mvista.com> <446A55D6.90507@ru.mvista.com> <446ED8A3.6030702@ru.mvista.com> <4478CD3D.6010409@ru.mvista.com> <4478E104.7040200@ru.mvista.com> <4479112D.8070501@ru.mvista.com> <44835D98.3070609@ru.mvista.com> <448C88B7.9070108@ru.mvista.com>
In-Reply-To: <448C88B7.9070108@ru.mvista.com>
Content-Type: multipart/mixed;
 boundary="------------050002040707030900080008"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050002040707030900080008
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

    Finally, rework the driver init. code to correctly handle all the chip
variants HighPoint has created so far. This should cure the rest of the timing
issues in the driver (especially, on 66 MHz PCI) caused by the HighPoint's
habit of switching the base DPLL clock with every new revision of the chips...

  - switch to using the enumeration type to differ between the numerous chip
    variants, matching PCI device/revision ID with the chip type early, at the
    init_setup stage;

  - extend the hpt_info structure to hold the DPLL and PCI clock frequencies,
    stop duplicating it for each channel by storing the pointer in the pci_dev
    structure: first, at the init_setup stage, point it to a static "template"
    with only the chip type and its specific base DPLL frequency, the highest
    supported DMA mode, and the chip settings table pointer filled, then, at
    the init_chipset stage, allocate per-chip instance  and fill it with the
    rest of the necessary information;

  - get rid of the constant thresholds in the HPT37x PCI clock detection code,
    switch  to calculating  PCI clock frequency based on the chip's base DPLL
    frequency;

  - switch to using the DPLL clock and enable UltraATA/133 mode by default on
    anything newer than HPT370/A;

  - fold PCI clock detection and DPLL setup code into init_chipset_hpt366(),
    unify the HPT36x/37x setup code and the speedproc handlers by joining the
    register setting lists into the table indexed by the clock selected;

  - add enablebits for all the chips to avoid touching disabled channels
    (though the HighPoint BIOS seem to only disable the primary one on
    HPT371/N);

  - separate the UltraDMA and MWDMA masks there to avoid changing PIO timings
    when setting an UltraDMA mode in hpt37x_tune_chipset().

    This version has been tested on HPT370/302/371N.
    Thanks to Alan for the inspiration. Hopefully, his libata driver will also
benefit from the work done on this "obsolete" driver...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>


--------------050002040707030900080008
Content-Type: text/plain;
 name="HPT3xx-init-code-rewrite.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="HPT3xx-init-code-rewrite.patch"

Index: linux-2.6/drivers/ide/pci/hpt366.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/hpt366.c
+++ linux-2.6/drivers/ide/pci/hpt366.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/hpt366.c		Version 0.52	Jun 07, 2006
+ * linux/drivers/ide/pci/hpt366.c		Version 1.00	Jun 25, 2006
  *
  * Copyright (C) 1999-2003		Andre Hedrick <andre@linux-ide.org>
  * Portions Copyright (C) 2001	        Sun Microsystems, Inc.
@@ -60,13 +60,10 @@
  *   channel caused the cached register value to get out of sync with the
  *   actual one, the channels weren't serialized, the turnaround shouldn't
  *   be done on 66 MHz PCI bus
- * - avoid calibrating PLL twice as the second time results in a wrong PCI
- *   frequency and thus in the wrong timings for the secondary channel
- * - disable UltraATA/133 for HPT372 and UltraATA/100 for HPT370 by default
- *   as the ATA clock being used does not allow for this speed anyway
- * - add support for HPT302N and HPT371N clocking (the same as for HPT372N)
- * - HPT371/N are single channel chips, so avoid touching the primary channel
- *   which exists only virtually (there's no pins for it)
+ * - disable UltraATA/100 for HPT370 by default as the 33 MHz clock being used
+ *   does not allow for this speed anyway
+ * - avoid touching disabled channels (e.g. HPT371/N are single channel chips,
+ *   their primary channel is kind of virtual, it isn't tied to any pins)
  * - fix/remove bad/unused timing tables and use one set of tables for the whole
  *   HPT37x chip family; save space by introducing the separate transfer mode
  *   table in which the mode lookup is done
@@ -74,24 +71,44 @@
  *   the wrong PCI frequency since DPLL has already been calibrated by BIOS
  * - fix the hotswap code:  it caused RESET- to glitch when tristating the bus,
  *   and for HPT36x the obsolete HDIO_TRISTATE_HWIF handler was called instead
- * - pass to init_chipset() handlers a copy of the IDE PCI device structure as
- *   they tamper with its fields
+ * - pass  to the init_setup handlers a copy of the ide_pci_device_t structure
+ *   since they may tamper with its fields
  * - prefix the driver startup messages with the real chip name
  * - claim the extra 240 bytes of I/O space for all chips
  * - optimize the rate masking/filtering and the drive list lookup code
  * - use pci_get_slot() to get to the function 1 of HPT36x/374
- * - cache the channel's MCRs' offset; only touch the relevant MCR when detecting
- *   the cable type on HPT374's function 1
+ * - cache offset of the channel's misc. control registers (MCRs) being used
+ *   throughout the driver
+ * - only touch the relevant MCR when detecting the cable type on HPT374's
+ *   function 1
  * - rename all the register related variables consistently
- * - move the interrupt twiddling code from the speedproc handlers into the
- *   init_hwif handler, also grouping all the DMA related code together there;
- *   simplify  the init_chipset handler
- * - merge two HPT37x speedproc handlers and fix the PIO timing register mask
- *   there; make HPT36x speedproc handler look the same way as the HPT37x one
- * - fix  the tuneproc handler to always set the PIO mode requested,  not the
- *   best possible one
+ * - move all the interrupt twiddling code from the speedproc handlers into
+ *   init_hwif_hpt366(), also grouping all the DMA related code together there
+ * - merge two HPT37x speedproc handlers, fix the PIO timing register mask and
+ *   separate the UltraDMA and MWDMA masks there to avoid changing PIO timings
+ *   when setting an UltraDMA mode
+ * - fix hpt3xx_tune_drive() to set the PIO mode requested, not always select
+ *   the best possible one
  * - clean up DMA timeout handling for HPT370
- *		<source@mvista.com>
+ * - switch to using the enumeration type to differ between the numerous chip
+ *   variants, matching PCI device/revision ID with the chip type early, at the
+ *   init_setup stage
+ * - extend the hpt_info structure to hold the DPLL and PCI clock frequencies,
+ *   stop duplicating it for each channel by storing the pointer in the pci_dev
+ *   structure: first, at the init_setup stage, point it to a static "template"
+ *   with only the chip type and its specific base DPLL frequency, the highest
+ *   supported DMA mode, and the chip settings table pointer filled, then, at
+ *   the init_chipset stage, allocate per-chip instance  and fill it with the
+ *   rest of the necessary information
+ * - get rid of the constant thresholds in the HPT37x PCI clock detection code,
+ *   switch  to calculating  PCI clock frequency based on the chip's base DPLL
+ *   frequency
+ * - switch to using the  DPLL clock and enable UltraATA/133 mode by default on
+ *   anything  newer than HPT370/A
+ * - fold PCI clock detection and DPLL setup code into init_chipset_hpt366();
+ *   unify HPT36x/37x timing setup code and the speedproc handlers by joining
+ *   the register setting lists into the table indexed by the clock selected
+ *	Sergei Shtylyov, <sshtylyov@ru.mvista.com> or <source@mvista.com>
  *
  */
 
@@ -347,71 +364,143 @@ static u32 sixty_six_base_hpt37x[] = {
 };
 
 #define HPT366_DEBUG_DRIVE_INFO		0
-#define HPT374_ALLOW_ATA133_6		0
-#define HPT371_ALLOW_ATA133_6		0
-#define HPT302_ALLOW_ATA133_6		0
-#define HPT372_ALLOW_ATA133_6		0
+#define HPT374_ALLOW_ATA133_6		1
+#define HPT371_ALLOW_ATA133_6		1
+#define HPT302_ALLOW_ATA133_6		1
+#define HPT372_ALLOW_ATA133_6		1
 #define HPT370_ALLOW_ATA100_5		0
 #define HPT366_ALLOW_ATA66_4		1
 #define HPT366_ALLOW_ATA66_3		1
 #define HPT366_MAX_DEVS			8
 
-#define F_LOW_PCI_33	0x23
-#define F_LOW_PCI_40	0x29
-#define F_LOW_PCI_50	0x2d
-#define F_LOW_PCI_66	0x42
+/* Supported ATA clock frequencies */
+enum ata_clock {
+	ATA_CLOCK_25MHZ,
+	ATA_CLOCK_33MHZ,
+	ATA_CLOCK_40MHZ,
+	ATA_CLOCK_50MHZ,
+	ATA_CLOCK_66MHZ,
+	NUM_ATA_CLOCKS
+};
 
 /*
- *	Hold all the highpoint quirks and revision information in one
- *	place.
+ *	Hold all the HighPoint chip information in one place.
  */
 
-struct hpt_info
-{
+struct hpt_info {
+	u8 chip_type;		/* Chip type */
 	u8 max_mode;		/* Speeds allowed */
-	u8 revision;		/* Chipset revision */
-	u8 flags;		/* Chipset properties */
-#define PLL_MODE	1
-#define IS_3xxN 	2
-#define PCI_66MHZ	4
-				/* Speed table */
-	u32 *speed;
+	u8 dpll_clk;		/* DPLL clock in MHz */
+	u8 pci_clk;		/* PCI  clock in MHz */
+	u32 **settings; 	/* Chipset settings table */
 };
 
-/*
- *	This wants fixing so that we do everything not by revision
- *	(which breaks on the newest chips) but by creating an
- *	enumeration of chip variants and using that
- */
+/* Supported HighPoint chips */
+enum {
+	HPT36x,
+	HPT370,
+	HPT370A,
+	HPT374,
+	HPT372,
+	HPT372A,
+	HPT302,
+	HPT371,
+	HPT372N,
+	HPT302N,
+	HPT371N
+};
 
-static __devinit u8 hpt_revision(struct pci_dev *dev)
-{
-	u8 rev = 0;
+static u32 *hpt36x_settings[NUM_ATA_CLOCKS] = {
+	twenty_five_base_hpt36x,
+	thirty_three_base_hpt36x,
+	forty_base_hpt36x,
+	NULL,
+	NULL
+};
 
-	pci_read_config_byte(dev, PCI_REVISION_ID, &rev);
+static u32 *hpt37x_settings[NUM_ATA_CLOCKS] = {
+	NULL,
+	thirty_three_base_hpt37x,
+	NULL,
+	fifty_base_hpt37x,
+	sixty_six_base_hpt37x
+};
 
-	switch(dev->device) {
-		/* Remap new 372N onto 372 */
-		case PCI_DEVICE_ID_TTI_HPT372N:
-			rev = PCI_DEVICE_ID_TTI_HPT372;
-			break;
-		case PCI_DEVICE_ID_TTI_HPT374:
-			rev = PCI_DEVICE_ID_TTI_HPT374;
-			break;
-		case PCI_DEVICE_ID_TTI_HPT371:
-			rev = PCI_DEVICE_ID_TTI_HPT371;
-			break;
-		case PCI_DEVICE_ID_TTI_HPT302:
-			rev = PCI_DEVICE_ID_TTI_HPT302;
-			break;
-		case PCI_DEVICE_ID_TTI_HPT372:
-			rev = PCI_DEVICE_ID_TTI_HPT372;
-			break;
-		default:
-			break;
-	}
-	return rev;
-}
+static struct hpt_info hpt36x __devinitdata = {
+	.chip_type	= HPT36x,
+	.max_mode	= (HPT366_ALLOW_ATA66_4 || HPT366_ALLOW_ATA66_3) ? 2 : 1,
+	.dpll_clk	= 0,	/* no DPLL */
+	.settings	= hpt36x_settings
+};
+
+static struct hpt_info hpt370 __devinitdata = {
+	.chip_type	= HPT370,
+	.max_mode	= HPT370_ALLOW_ATA100_5 ? 3 : 2,
+	.dpll_clk	= 48,
+	.settings	= hpt37x_settings
+};
+
+static struct hpt_info hpt370a __devinitdata = {
+	.chip_type	= HPT370A,
+	.max_mode	= HPT370_ALLOW_ATA100_5 ? 3 : 2,
+	.dpll_clk	= 48,
+	.settings	= hpt37x_settings
+};
+
+static struct hpt_info hpt374 __devinitdata = {
+	.chip_type	= HPT374,
+	.max_mode	= HPT374_ALLOW_ATA133_6 ? 4 : 3,
+	.dpll_clk	= 48,
+	.settings	= hpt37x_settings
+};
+
+static struct hpt_info hpt372 __devinitdata = {
+	.chip_type	= HPT372,
+	.max_mode	= HPT372_ALLOW_ATA133_6 ? 4 : 3,
+	.dpll_clk	= 55,
+	.settings	= hpt37x_settings
+};
+
+static struct hpt_info hpt372a __devinitdata = {
+	.chip_type	= HPT372A,
+	.max_mode	= HPT372_ALLOW_ATA133_6 ? 4 : 3,
+	.dpll_clk	= 66,
+	.settings	= hpt37x_settings
+};
+
+static struct hpt_info hpt302 __devinitdata = {
+	.chip_type	= HPT302,
+	.max_mode	= HPT302_ALLOW_ATA133_6 ? 4 : 3,
+	.dpll_clk	= 66,
+	.settings	= hpt37x_settings
+};
+
+static struct hpt_info hpt371 __devinitdata = {
+	.chip_type	= HPT371,
+	.max_mode	= HPT371_ALLOW_ATA133_6 ? 4 : 3,
+	.dpll_clk	= 66,
+	.settings	= hpt37x_settings
+};
+
+static struct hpt_info hpt372n __devinitdata = {
+	.chip_type	= HPT372N,
+	.max_mode	= HPT372_ALLOW_ATA133_6 ? 4 : 3,
+	.dpll_clk	= 77,
+	.settings	= hpt37x_settings
+};
+
+static struct hpt_info hpt302n __devinitdata = {
+	.chip_type	= HPT302N,
+	.max_mode	= HPT302_ALLOW_ATA133_6 ? 4 : 3,
+	.dpll_clk	= 77,
+};
+
+static struct hpt_info hpt371n __devinitdata = {
+	.chip_type	= HPT371N,
+	.max_mode	= HPT371_ALLOW_ATA133_6 ? 4 : 3,
+	.dpll_clk	= 77,
+	.settings	= hpt37x_settings
+};
 
 static int check_in_drive_list(ide_drive_t *drive, const char **list)
 {
@@ -425,7 +514,7 @@ static int check_in_drive_list(ide_drive
 
 static u8 hpt3xx_ratemask(ide_drive_t *drive)
 {
-	struct hpt_info *info	= ide_get_hwifdata(HWIF(drive));
+	struct hpt_info *info	= pci_get_drvdata(HWIF(drive)->pci_dev);
 	u8 mode			= info->max_mode;
 
 	if (!eighty_ninty_three(drive) && mode)
@@ -440,7 +529,8 @@ static u8 hpt3xx_ratemask(ide_drive_t *d
  
 static u8 hpt3xx_ratefilter(ide_drive_t *drive, u8 speed)
 {
-	struct hpt_info *info	= ide_get_hwifdata(HWIF(drive));
+	struct hpt_info *info	= pci_get_drvdata(HWIF(drive)->pci_dev);
+	u8 chip_type		= info->chip_type;
 	u8 mode			= hpt3xx_ratemask(drive);
 
 	if (drive->media != ide_disk)
@@ -448,21 +538,22 @@ static u8 hpt3xx_ratefilter(ide_drive_t 
 
 	switch (mode) {
 		case 0x04:
-			speed = min(speed, (u8)XFER_UDMA_6);
+			speed = min_t(u8, speed, XFER_UDMA_6);
 			break;
 		case 0x03:
-			speed = min(speed, (u8)XFER_UDMA_5);
-			if (info->revision >= 5)
+			speed = min_t(u8, speed, XFER_UDMA_5);
+			if (chip_type >= HPT374)
 				break;
 			if (!check_in_drive_list(drive, bad_ata100_5))
 				goto check_bad_ata33;
 			/* fall thru */
 		case 0x02:
 			speed = min_t(u8, speed, XFER_UDMA_4);
-	/*
-	 * CHECK ME, Does this need to be set to 5 ??
-	 */
-			if (info->revision >= 3)
+
+			/*
+			 * CHECK ME, Does this need to be changed to HPT374 ??
+			 */
+			if (chip_type >= HPT370)
 				goto check_bad_ata33;
 			if (HPT366_ALLOW_ATA66_4 &&
 			    !check_in_drive_list(drive, bad_ata66_4))
@@ -477,7 +568,7 @@ static u8 hpt3xx_ratefilter(ide_drive_t 
 			speed = min_t(u8, speed, XFER_UDMA_2);
 
 		check_bad_ata33:
- 			if (info->revision >= 4)
+			if (chip_type >= HPT370A)
 				break;
 			if (!check_in_drive_list(drive, bad_ata33))
 				break;
@@ -490,7 +581,7 @@ static u8 hpt3xx_ratefilter(ide_drive_t 
 	return speed;
 }
 
-static u32 pci_bus_clock_list(u8 speed, u32 *chipset_table)
+static u32 get_speed_setting(u8 speed, struct hpt_info *info)
 {
 	int i;
 
@@ -503,18 +594,23 @@ static u32 pci_bus_clock_list(u8 speed, 
 	for (i = 0; i < ARRAY_SIZE(xfer_speeds) - 1; i++)
 		if (xfer_speeds[i] == speed)
 			break;
-	return chipset_table[i];
+	/*
+	 * NOTE: info->settings only points to the pointer
+	 * to the list of the actual register values
+	 */
+	return (*info->settings)[i];
 }
 
 static int hpt36x_tune_chipset(ide_drive_t *drive, u8 xferspeed)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev  *dev	= hwif->pci_dev;
-	struct hpt_info	*info	= ide_get_hwifdata (hwif);
+	struct hpt_info	*info	= pci_get_drvdata(dev);
 	u8  speed		= hpt3xx_ratefilter(drive, xferspeed);
 	u8  itr_addr		= drive->dn ? 0x44 : 0x40;
-	u32 itr_mask		= (speed < XFER_MW_DMA_0) ? 0x30070000 : 0xc0000000;
-	u32 new_itr		= pci_bus_clock_list(speed, info->speed);
+	u32 itr_mask		= speed < XFER_MW_DMA_0 ? 0x30070000 :
+				 (speed < XFER_UDMA_0   ? 0xc0070000 : 0xc03800ff);
+	u32 new_itr		= get_speed_setting(speed, info);
 	u32 old_itr		= 0;
 
 	/*
@@ -534,11 +630,12 @@ static int hpt37x_tune_chipset(ide_drive
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev  *dev	= hwif->pci_dev;
-	struct hpt_info	*info	= ide_get_hwifdata (hwif);
+	struct hpt_info	*info	= pci_get_drvdata(dev);
 	u8  speed		= hpt3xx_ratefilter(drive, xferspeed);
 	u8  itr_addr		= 0x40 + (drive->dn * 4);
-	u32 itr_mask		= (speed < XFER_MW_DMA_0) ? 0x303c0000 : 0xc0000000;
-	u32 new_itr		= pci_bus_clock_list(speed, info->speed);
+	u32 itr_mask		= speed < XFER_MW_DMA_0 ? 0x303c0000 :
+				 (speed < XFER_UDMA_0   ? 0xc03c0000 : 0xc1c001ff);
+	u32 new_itr		= get_speed_setting(speed, info);
 	u32 old_itr		= 0;
 
 	pci_read_config_dword(dev, itr_addr, &old_itr);
@@ -554,9 +651,9 @@ static int hpt37x_tune_chipset(ide_drive
 static int hpt3xx_tune_chipset(ide_drive_t *drive, u8 speed)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
-	struct hpt_info	*info	= ide_get_hwifdata(hwif);
+	struct hpt_info	*info	= pci_get_drvdata(hwif->pci_dev);
 
-	if (info->revision >= 3)
+	if (info->chip_type >= HPT370)
 		return hpt37x_tune_chipset(drive, speed);
 	else	/* hpt368: hpt_minimum_revision(dev, 2) */
 		return hpt36x_tune_chipset(drive, speed);
@@ -578,16 +675,10 @@ static void hpt3xx_tune_drive(ide_drive_
 static int config_chipset_for_dma(ide_drive_t *drive)
 {
 	u8 speed = ide_dma_speed(drive, hpt3xx_ratemask(drive));
-	ide_hwif_t *hwif	= HWIF(drive);
-	struct hpt_info	*info	= ide_get_hwifdata(hwif);
 
 	if (!speed)
 		return 0;
 
-	/* If we don't have any timings we can't do a lot */
-	if (info->speed == NULL)
-		return 0;
-
 	(void) hpt3xx_tune_chipset(drive, speed);
 	return ide_dma_enable(drive);
 }
@@ -617,10 +708,10 @@ static void hpt3xx_maskproc(ide_drive_t 
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev	*dev	= hwif->pci_dev;
-	struct hpt_info *info	= ide_get_hwifdata(hwif);
+	struct hpt_info *info	= pci_get_drvdata(dev);
 
 	if (drive->quirk_list) {
-		if (info->revision >= 3) {
+		if (info->chip_type >= HPT370) {
 			u8 scr1 = 0;
 
 			pci_read_config_byte(dev, 0x5a, &scr1);
@@ -780,40 +871,37 @@ static int hpt374_ide_dma_end(ide_drive_
  *	@mode: clocking mode (0x21 for write, 0x23 otherwise)
  *
  *	Switch the DPLL clock on the HPT3xxN devices. This is a	right mess.
- *	NOTE: avoid touching the disabled primary channel on HPT371N -- it
- *	doesn't physically exist anyway...
  */
 
 static void hpt3xxn_set_clock(ide_hwif_t *hwif, u8 mode)
 {
-	u8 mcr1, scr2 = hwif->INB(hwif->dma_master + 0x7b);
+	u8 scr2 = hwif->INB(hwif->dma_master + 0x7b);
 
 	if ((scr2 & 0x7f) == mode)
 		return;
 
-	/* MISC. control register 1 has the channel enable bit... */
-	mcr1 = hwif->INB(hwif->dma_master + 0x70);
-
 	/* Tristate the bus */
-	if (mcr1 & 0x04)
-		hwif->OUTB(0x80, hwif->dma_master + 0x73);
+	hwif->OUTB(0x80, hwif->dma_master + 0x73);
 	hwif->OUTB(0x80, hwif->dma_master + 0x77);
 
 	/* Switch clock and reset channels */
 	hwif->OUTB(mode, hwif->dma_master + 0x7b);
 	hwif->OUTB(0xc0, hwif->dma_master + 0x79);
 
-	/* Reset state machines */
-	if (mcr1 & 0x04)
-		hwif->OUTB(0x37, hwif->dma_master + 0x70);
-	hwif->OUTB(0x37, hwif->dma_master + 0x74);
+	/*
+	 * Reset the state machines.
+	 * NOTE: avoid accidentally enabling the disabled channels.
+	 */
+	hwif->OUTB(hwif->INB(hwif->dma_master + 0x70) | 0x32,
+		   hwif->dma_master + 0x70);
+	hwif->OUTB(hwif->INB(hwif->dma_master + 0x74) | 0x32,
+		   hwif->dma_master + 0x74);
 
 	/* Complete reset */
 	hwif->OUTB(0x00, hwif->dma_master + 0x79);
 
 	/* Reconnect channels to bus */
-	if (mcr1 & 0x04)
-		hwif->OUTB(0x00, hwif->dma_master + 0x73);
+	hwif->OUTB(0x00, hwif->dma_master + 0x73);
 	hwif->OUTB(0x00, hwif->dma_master + 0x77);
 }
 
@@ -828,10 +916,7 @@ static void hpt3xxn_set_clock(ide_hwif_t
 
 static void hpt3xxn_rw_disk(ide_drive_t *drive, struct request *rq)
 {
-	ide_hwif_t *hwif	= HWIF(drive);
-	u8 wantclock		= rq_data_dir(rq) ? 0x23 : 0x21;
-
-	hpt3xxn_set_clock(hwif, wantclock);
+	hpt3xxn_set_clock(HWIF(drive), rq_data_dir(rq) ? 0x23 : 0x21);
 }
 
 /* 
@@ -892,223 +977,293 @@ static int hpt3xx_busproc(ide_drive_t *d
 	return 0;
 }
 
-static void __devinit hpt366_clocking(ide_hwif_t *hwif)
+/**
+ *	hpt37x_calibrate_dpll	-	calibrate the DPLL
+ *	@dev: PCI device
+ *
+ *	Perform a calibration cycle on the DPLL.
+ *	Returns 1 if this succeeds
+ */
+static int __devinit hpt37x_calibrate_dpll(struct pci_dev *dev, u16 f_low, u16 f_high)
 {
-	u32 itr1	= 0;
-	struct hpt_info *info = ide_get_hwifdata(hwif);
+	u32 dpll = (f_high << 16) | f_low | 0x100;
+	u8  scr2;
+	int i;
 
-	pci_read_config_dword(hwif->pci_dev, 0x40, &itr1);
+	pci_write_config_dword(dev, 0x5c, dpll);
 
-	/* detect bus speed by looking at control reg timing: */
-	switch((itr1 >> 8) & 7) {
-		case 5:
-			info->speed = forty_base_hpt36x;
-			break;
-		case 9:
-			info->speed = twenty_five_base_hpt36x;
-			break;
-		case 7:
-		default:
-			info->speed = thirty_three_base_hpt36x;
+	/* Wait for oscillator ready */
+	for(i = 0; i < 0x5000; ++i) {
+		udelay(50);
+		pci_read_config_byte(dev, 0x5b, &scr2);
+		if (scr2 & 0x80)
 			break;
 	}
+	/* See if it stays ready (we'll just bail out if it's not yet) */
+	for(i = 0; i < 0x1000; ++i) {
+		pci_read_config_byte(dev, 0x5b, &scr2);
+		/* DPLL destabilized? */
+		if(!(scr2 & 0x80))
+			return 0;
+	}
+	/* Turn off tuning, we have the DPLL set */
+	pci_read_config_dword (dev, 0x5c, &dpll);
+	pci_write_config_dword(dev, 0x5c, (dpll & ~0x100));
+	return 1;
 }
 
-static void __devinit hpt37x_clocking(ide_hwif_t *hwif)
+static unsigned int __devinit init_chipset_hpt366(struct pci_dev *dev, const char *name)
 {
-	struct hpt_info *info	= ide_get_hwifdata(hwif);
-	struct pci_dev  *dev	= hwif->pci_dev;
-	char *name		= hwif->cds->name;
-	int adjust, i;
-	u16 freq = 0;
-	u32 pll, temp = 0;
-	u8  scr2 = 0, mcr1 = 0;
-	
+	struct hpt_info *info	= kmalloc(sizeof(struct hpt_info), GFP_KERNEL);
+	unsigned long io_base	= pci_resource_start(dev, 4);
+	u8 pci_clk,  dpll_clk	= 0;	/* PCI and DPLL clock in MHz */
+	enum ata_clock	clock;
+
+	if (info == NULL) {
+		printk(KERN_ERR "%s: out of memory!\n", name);
+		return -ENOMEM;
+	}
+
 	/*
-	 * default to pci clock. make sure MA15/16 are set to output
-	 * to prevent drives having problems with 40-pin cables. Needed
-	 * for some drives such as IBM-DTLA which will not enter ready
-	 * state on reset when PDIAG is a input.
-	 *
-	 * ToDo: should we set 0x21 when using PLL mode ?
+	 * Copy everything from a static "template" structure
+	 * to just allocated per-chip hpt_info structure.
 	 */
-	pci_write_config_byte(dev, 0x5b, 0x23);
+	*info = *(struct hpt_info *)pci_get_drvdata(dev);
 
 	/*
-	 * We'll have to read f_CNT value in order to determine
-	 * the PCI clock frequency according to the following ratio:
-	 *
-	 * f_CNT = Fpci * 192 / Fdpll
-	 *
-	 * First try reading the register in which the HighPoint BIOS
-	 * saves f_CNT value before  reprogramming the DPLL from its
-	 * default setting (which differs for the various chips).
-	 * NOTE: This register is only accessible via I/O space.
-	 *
-	 * In case the signature check fails, we'll have to resort to
-	 * reading the f_CNT register itself in hopes that nobody has
-	 * touched the DPLL yet...
+	 * FIXME: Not portable. Also, why do we enable the ROM in the first place?
+	 * We don't seem to be using it.
 	 */
-	temp = inl(pci_resource_start(dev, 4) + 0x90);
-	if ((temp & 0xFFFFF000) != 0xABCDE000) {
-		printk(KERN_WARNING "%s: no clock data saved by BIOS\n", name);
-
-		/* Calculate the average value of f_CNT */
-		for (temp = i = 0; i < 128; i++) {
-			pci_read_config_word(dev, 0x78, &freq);
-			temp += freq & 0x1ff;
-			mdelay(1);
-		}
-		freq = temp / 128;
-	} else
-		freq = temp & 0x1ff;
+	if (dev->resource[PCI_ROM_RESOURCE].start)
+		pci_write_config_dword(dev, PCI_ROM_ADDRESS,
+			dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
+
+	pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE, (L1_CACHE_BYTES / 4));
+	pci_write_config_byte(dev, PCI_LATENCY_TIMER, 0x78);
+	pci_write_config_byte(dev, PCI_MIN_GNT, 0x08);
+	pci_write_config_byte(dev, PCI_MAX_LAT, 0x08);
 
 	/*
-	 * HPT3xxN chips use different PCI clock information.
-	 * Currently we always set up the PLL for them.
+	 * First, try to estimate the PCI clock frequency...
 	 */
+	if (info->chip_type >= HPT370) {
+		u8  scr1  = 0;
+		u16 f_cnt = 0;
+		u32 temp  = 0;
+
+		/* Interrupt force enable. */
+		pci_read_config_byte(dev, 0x5a, &scr1);
+		if (scr1 & 0x10)
+			pci_write_config_byte(dev, 0x5a, scr1 & ~0x10);
+
+		/*
+		 * HighPoint does this for HPT372A.
+		 * NOTE: This register is only writeable via I/O space.
+		 */
+		if (info->chip_type == HPT372A)
+			outb(0x0e, io_base + 0x9c);
+
+		/*
+		 * Default to PCI clock. Make sure MA15/16 are set to output
+		 * to prevent drives having problems with 40-pin cables.
+		 */
+		pci_write_config_byte(dev, 0x5b, 0x23);
 
-	if (info->flags & IS_3xxN) {
-		if(freq < 0x55)
-			pll = F_LOW_PCI_33;
-		else if(freq < 0x70)
-			pll = F_LOW_PCI_40;
-		else if(freq < 0x7F)
-			pll = F_LOW_PCI_50;
+		/*
+		 * We'll have to read f_CNT value in order to determine
+		 * the PCI clock frequency according to the following ratio:
+		 *
+		 * f_CNT = Fpci * 192 / Fdpll
+		 *
+		 * First try reading the register in which the HighPoint BIOS
+		 * saves f_CNT value before  reprogramming the DPLL from its
+		 * default setting (which differs for the various chips).
+		 * NOTE: This register is only accessible via I/O space.
+		 *
+		 * In case the signature check fails, we'll have to resort to
+		 * reading the f_CNT register itself in hopes that nobody has
+		 * touched the DPLL yet...
+		 */
+		temp = inl(io_base + 0x90);
+		if ((temp & 0xFFFFF000) != 0xABCDE000) {
+			int i;
+
+			printk(KERN_WARNING "%s: no clock data saved by BIOS\n",
+			       name);
+
+			/* Calculate the average value of f_CNT. */
+			for (temp = i = 0; i < 128; i++) {
+				pci_read_config_word(dev, 0x78, &f_cnt);
+				temp += f_cnt & 0x1ff;
+				mdelay(1);
+			}
+			f_cnt = temp / 128;
+		} else
+			f_cnt = temp & 0x1ff;
+
+		dpll_clk = info->dpll_clk;
+		pci_clk  = (f_cnt * dpll_clk) / 192;
+
+		/* Clamp PCI clock to bands. */
+		if (pci_clk < 40)
+			pci_clk = 33;
+		else if(pci_clk < 45)
+			pci_clk = 40;
+		else if(pci_clk < 55)
+			pci_clk = 50;
 		else
-			pll = F_LOW_PCI_66;
+			pci_clk = 66;
 
+		printk(KERN_INFO "%s: DPLL base: %d MHz, f_CNT: %d, "
+		       "assuming %d MHz PCI\n", name, dpll_clk, f_cnt, pci_clk);
 	} else {
-		if(freq < 0x9C)
-			pll = F_LOW_PCI_33;
-		else if(freq < 0xb0)
-			pll = F_LOW_PCI_40;
-		else if(freq <0xc8)
-			pll = F_LOW_PCI_50;
-		else
-			pll = F_LOW_PCI_66;
-	}
-	printk(KERN_INFO "%s: FREQ: %d, PLL: %d\n", name, freq, pll);
-	
-	if (!(info->flags & IS_3xxN)) {
-		if (pll == F_LOW_PCI_33) {
-			info->speed = thirty_three_base_hpt37x;
-			printk(KERN_DEBUG "%s: using 33MHz PCI clock\n", name);
-		} else if (pll == F_LOW_PCI_40) {
-			/* Unsupported */
-		} else if (pll == F_LOW_PCI_50) {
-			info->speed = fifty_base_hpt37x;
-			printk(KERN_DEBUG "%s: using 50MHz PCI clock\n", name);
-		} else {
-			info->speed = sixty_six_base_hpt37x;
-			printk(KERN_DEBUG "%s: using 66MHz PCI clock\n", name);
+		u32 itr1 = 0;
+
+		pci_read_config_dword(dev, 0x40, &itr1);
+
+		/* Detect PCI clock by looking at cmd_high_time. */
+		switch((itr1 >> 8) & 0x07) {
+			case 0x09:
+				pci_clk = 40;
+			case 0x05:
+				pci_clk = 25;
+			case 0x07:
+			default:
+				pci_clk = 33;
 		}
 	}
 
-	if (pll == F_LOW_PCI_66)
-		info->flags |= PCI_66MHZ;
+	/* Let's assume we'll use PCI clock for the ATA clock... */
+	switch (pci_clk) {
+		case 25:
+			clock = ATA_CLOCK_25MHZ;
+			break;
+		case 33:
+		default:
+			clock = ATA_CLOCK_33MHZ;
+			break;
+		case 40:
+			clock = ATA_CLOCK_40MHZ;
+			break;
+		case 50:
+			clock = ATA_CLOCK_50MHZ;
+			break;
+		case 66:
+			clock = ATA_CLOCK_66MHZ;
+			break;
+	}
 
 	/*
-	 * only try the pll if we don't have a table for the clock
-	 * speed that we're running at. NOTE: the internal PLL will
-	 * result in slow reads when using a 33MHz PCI clock. we also
-	 * don't like to use the PLL because it will cause glitches
-	 * on PRST/SRST when the HPT state engine gets reset.
+	 * Only try the DPLL if we don't have a table for the PCI clock that
+	 * we are running at for HPT370/A, always use it  for anything newer...
 	 *
-	 * ToDo: Use 66MHz PLL when ATA133 devices are present on a
-	 * 372 device so we can get ATA133 support
+	 * NOTE: Using the internal DPLL results in slow reads on 33 MHz PCI.
+	 * We also  don't like using  the DPLL because this causes glitches
+	 * on PRST-/SRST- when the state engine gets reset...
 	 */
-	if (info->speed)
-		goto init_hpt37X_done;
+	if (info->chip_type >= HPT374 || info->settings[clock] == NULL) {
+		u16 f_low, delta = pci_clk < 50 ? 2 : 4;
+		int adjust;
+
+		 /*
+		  * Select 66 MHz DPLL clock only if UltraATA/133 mode is
+		  * supported/enabled, use 50 MHz DPLL clock otherwise...
+		  */
+		if (info->max_mode == 0x04) {
+			dpll_clk = 66;
+			clock = ATA_CLOCK_66MHZ;
+		} else if (dpll_clk) {	/* HPT36x chips don't have DPLL */
+			dpll_clk = 50;
+			clock = ATA_CLOCK_50MHZ;
+		}
 
-	info->flags |= PLL_MODE;
-	
-	/*
-	 * Adjust the PLL based upon the PCI clock, enable it, and
-	 * wait for stabilization...
-	 */
-	adjust = 0;
-	freq = (pll < F_LOW_PCI_50) ? 2 : 4;
-	while (adjust++ < 6) {
-		pci_write_config_dword(dev, 0x5c, (freq + pll) << 16 |
-				       pll | 0x100);
-
-		/* wait for clock stabilization */
-		for (i = 0; i < 0x50000; i++) {
-			pci_read_config_byte(dev, 0x5b, &scr2);
-			if (scr2 & 0x80) {
-				/* spin looking for the clock to destabilize */
-				for (i = 0; i < 0x1000; ++i) {
-					pci_read_config_byte(dev, 0x5b, 
-							     &scr2);
-					if ((scr2 & 0x80) == 0)
-						goto pll_recal;
-				}
-				pci_read_config_dword(dev, 0x5c, &pll);
-				pci_write_config_dword(dev, 0x5c, 
-						       pll & ~0x100);
-				pci_write_config_byte(dev, 0x5b, 0x21);
-
-				info->speed = fifty_base_hpt37x;
-				printk("%s: using 50MHz internal PLL\n", name);
-				goto init_hpt37X_done;
-			}
+		if (info->settings[clock] == NULL) {
+			printk(KERN_ERR "%s: unknown bus timing!\n", name);
+			kfree(info);
+			return -EIO;
 		}
-pll_recal:
-		if (adjust & 1)
-			pll -= (adjust >> 1);
-		else
-			pll += (adjust >> 1);
-	} 
 
-init_hpt37X_done:
-	if (!info->speed)
-		printk(KERN_ERR "%s: unknown bus timing [%d %d].\n",
-		       name, pll, freq);
-	/*
-	 * Reset the state engines.
-	 * NOTE: avoid accidentally enabling the primary channel on HPT371N.
-	 */
-	pci_read_config_byte(dev, 0x50, &mcr1);
-	if (mcr1 & 0x04)
-		pci_write_config_byte(dev, 0x50, 0x37);
-	pci_write_config_byte(dev, 0x54, 0x37);
-	udelay(100);
-}
+		/* Select the DPLL clock. */
+		pci_write_config_byte(dev, 0x5b, 0x21);
+
+		/*
+		 * Adjust the DPLL based upon PCI clock, enable it,
+		 * and wait for stabilization...
+		 */
+		f_low = (pci_clk * 48) / dpll_clk;
+
+		for (adjust = 0; adjust < 8; adjust++) {
+			if(hpt37x_calibrate_dpll(dev, f_low, f_low + delta))
+				break;
+
+			/*
+			 * See if it'll settle at a fractionally different clock
+			 */
+			if (adjust & 1)
+				f_low -= adjust >> 1;
+			else
+				f_low += adjust >> 1;
+		}
+		if (adjust == 8) {
+			printk(KERN_ERR "%s: DPLL did not stabilize!\n", name);
+			kfree(info);
+			return -EIO;
+		}
+
+		printk("%s: using %d MHz DPLL clock\n", name, dpll_clk);
+	} else {
+		/* Mark the fact that we're not using the DPLL. */
+		dpll_clk = 0;
+
+		printk("%s: using %d MHz PCI clock\n", name, pci_clk);
+	}
 
-static unsigned int __devinit init_chipset_hpt366(struct pci_dev *dev, const char *name)
-{
 	/*
-	 * FIXME: Not portable. Also, why do we enable the ROM in the first place?
-	 * We don't seem to be using it.
+	 * Advance the table pointer to a slot which points to the list
+	 * of the register values settings matching the clock being used.
 	 */
-	if (dev->resource[PCI_ROM_RESOURCE].start)
-		pci_write_config_dword(dev, PCI_ROM_ADDRESS,
-			dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
+	info->settings += clock;
 
-	pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE, (L1_CACHE_BYTES / 4));
-	pci_write_config_byte(dev, PCI_LATENCY_TIMER, 0x78);
-	pci_write_config_byte(dev, PCI_MIN_GNT, 0x08);
-	pci_write_config_byte(dev, PCI_MAX_LAT, 0x08);
+	/* Store the clock frequencies. */
+	info->dpll_clk	= dpll_clk;
+	info->pci_clk	= pci_clk;
 
-	if (hpt_revision(dev) >= 3) {
-		u8 scr1 = 0;
+	/* Point to this chip's own instance of the hpt_info structure. */
+	pci_set_drvdata(dev, info);
 
-		/* Interrupt force enable. */
-		pci_read_config_byte(dev, 0x5a, &scr1);
-		if (scr1 & 0x10)
-			pci_write_config_byte(dev, 0x5a, scr1 & ~0x10);
+	if (info->chip_type >= HPT370) {
+		u8  mcr1, mcr4;
+
+		/*
+		 * Reset the state engines.
+		 * NOTE: Avoid accidentally enabling the disabled channels.
+		 */
+		pci_read_config_byte (dev, 0x50, &mcr1);
+		pci_read_config_byte (dev, 0x54, &mcr4);
+		pci_write_config_byte(dev, 0x50, (mcr1 | 0x32));
+		pci_write_config_byte(dev, 0x54, (mcr4 | 0x32));
+		udelay(100);
 	}
 
+	/*
+	 * On  HPT371N, if ATA clock is 66 MHz we must set bit 2 in
+	 * the MISC. register to stretch the UltraDMA Tss timing.
+	 * NOTE: This register is only writeable via I/O space.
+	 */
+	if (info->chip_type == HPT371N && clock == ATA_CLOCK_66MHZ)
+
+		outb(inb(io_base + 0x9c) | 0x04, io_base + 0x9c);
+
 	return dev->irq;
 }
 
 static void __devinit init_hwif_hpt366(ide_hwif_t *hwif)
 {
 	struct pci_dev	*dev		= hwif->pci_dev;
-	struct hpt_info *info		= ide_get_hwifdata(hwif);
+	struct hpt_info *info		= pci_get_drvdata(dev);
 	int serialize			= HPT_SERIALIZE_IO;
 	u8  scr1 = 0, ata66		= (hwif->channel) ? 0x01 : 0x02;
+	u8  chip_type			= info->chip_type;
 	u8  new_mcr, old_mcr 		= 0;
 
 	/* Cache the channel's MISC. control registers' offset */
@@ -1127,7 +1282,7 @@ static void __devinit init_hwif_hpt366(i
 	 * - on 33 MHz PCI we must clock switch
 	 * - on 66 MHz PCI we must NOT use the PCI clock
 	 */
-	if ((info->flags & (IS_3xxN | PCI_66MHZ)) == IS_3xxN) {
+	if (chip_type >= HPT372N && info->dpll_clk && info->pci_clk < 66) {
 		/*
 		 * Clock is shared between the channels,
 		 * so we'll have to serialize them... :-(
@@ -1146,9 +1301,9 @@ static void __devinit init_hwif_hpt366(i
 	 */
 	pci_read_config_byte(dev, hwif->select_data + 1, &old_mcr);
 
-	if (info->revision >= 5)		/* HPT372 and newer   */
+	if (info->chip_type >= HPT374)
 		new_mcr = old_mcr & ~0x07;
-	else if (info->revision >= 3) {		/* HPT370 and HPT370A */
+	else if (info->chip_type >= HPT370) {
 		new_mcr = old_mcr;
 		new_mcr &= ~0x02;
 
@@ -1176,7 +1331,7 @@ static void __devinit init_hwif_hpt366(i
 	 * address lines to access an external EEPROM.  To read valid
 	 * cable detect state the pins must be enabled as inputs.
 	 */
-	if (info->revision >= 8 && (PCI_FUNC(dev->devfn) & 1)) {
+	if (chip_type == HPT374 && (PCI_FUNC(dev->devfn) & 1)) {
 		/*
 		 * HPT374 PCI function 1
 		 * - set bit 15 of reg 0x52 to enable TCBLID as input
@@ -1190,7 +1345,7 @@ static void __devinit init_hwif_hpt366(i
 		/* now read cable id register */
 		pci_read_config_byte (dev, 0x5a, &scr1);
 		pci_write_config_word(dev, mcr_addr, mcr);
-	} else if (info->revision >= 3) {
+	} else if (chip_type >= HPT370) {
 		/*
 		 * HPT370/372 and 374 pcifn 0
 		 * - clear bit 0 of reg 0x5b to enable P/SCBLID as inputs
@@ -1210,10 +1365,10 @@ static void __devinit init_hwif_hpt366(i
 
 	hwif->ide_dma_check		= &hpt366_config_drive_xfer_rate;
 
-	if (info->revision >= 5) {
+	if (chip_type >= HPT374) {
 		hwif->ide_dma_test_irq	= &hpt374_ide_dma_test_irq;
 		hwif->ide_dma_end	= &hpt374_ide_dma_end;
-	} else if (info->revision >= 3) {
+	} else if (chip_type >= HPT370) {
 		hwif->dma_start 	= &hpt370_ide_dma_start;
 		hwif->ide_dma_end	= &hpt370_ide_dma_end;
 		hwif->ide_dma_timeout	= &hpt370_ide_dma_timeout;
@@ -1228,7 +1383,6 @@ static void __devinit init_hwif_hpt366(i
 static void __devinit init_dma_hpt366(ide_hwif_t *hwif, unsigned long dmabase)
 {
 	struct pci_dev	*dev		= hwif->pci_dev;
-	struct hpt_info	*info		= ide_get_hwifdata(hwif);
 	u8 masterdma	= 0, slavedma	= 0;
 	u8 dma_new	= 0, dma_old	= 0;
 	unsigned long flags;
@@ -1236,12 +1390,6 @@ static void __devinit init_dma_hpt366(id
 	if (!dmabase)
 		return;
 		
-	if(info->speed == NULL) {
-		printk(KERN_WARNING "%s: no known IDE timings, disabling DMA.\n",
-		       hwif->cds->name);
-		return;
-	}
-
 	dma_old = hwif->INB(dmabase + 2);
 
 	local_irq_save(flags);
@@ -1260,60 +1408,6 @@ static void __devinit init_dma_hpt366(id
 	ide_setup_dma(hwif, dmabase, 8);
 }
 
-/*
- *	We "borrow" this hook in order to set the data structures
- *	up early enough before dma or init_hwif calls are made.
- */
-
-static void __devinit init_iops_hpt366(ide_hwif_t *hwif)
-{
-	struct hpt_info *info	= kzalloc(sizeof(struct hpt_info), GFP_KERNEL);
-	struct pci_dev  *dev	= hwif->pci_dev;
-	u16 did			= dev->device;
-	u8 mode, rid		= 0;
-
-	if(info == NULL) {
-		printk(KERN_WARNING "%s: out of memory.\n", hwif->cds->name);
-		return;
-	}
-	ide_set_hwifdata(hwif, info);
-
-	/* Avoid doing the same thing twice. */
-	if (hwif->channel && hwif->mate) {
-		memcpy(info, ide_get_hwifdata(hwif->mate), sizeof(struct hpt_info));
-		return;
-	}
-
-	pci_read_config_byte(dev, PCI_REVISION_ID, &rid);
-
-	if (( did == PCI_DEVICE_ID_TTI_HPT366  && rid == 6) ||
-	    ((did == PCI_DEVICE_ID_TTI_HPT372  ||
-	      did == PCI_DEVICE_ID_TTI_HPT302  ||
-	      did == PCI_DEVICE_ID_TTI_HPT371) && rid > 1) ||
-	      did == PCI_DEVICE_ID_TTI_HPT372N)
-		info->flags |= IS_3xxN;
-
-	rid = info->revision = hpt_revision(dev);
-	if (rid >= 8)			/* HPT374 */
-		mode = HPT374_ALLOW_ATA133_6 ? 4 : 3;
-	else if (rid >= 7)		/* HPT371 and HPT371N */
-		mode = HPT371_ALLOW_ATA133_6 ? 4 : 3;
-	else if (rid >= 6)		/* HPT302 and HPT302N */
-		mode = HPT302_ALLOW_ATA133_6 ? 4 : 3;
-	else if (rid >= 5)		/* HPT372, HPT372A, and HPT372N */
-		mode = HPT372_ALLOW_ATA133_6 ? 4 : 3;
-	else if (rid >= 3)		/* HPT370 and HPT370A */
-		mode = HPT370_ALLOW_ATA100_5 ? 3 : 2;
-	else				/* HPT366 and HPT368 */
-		mode = (HPT366_ALLOW_ATA66_4 || HPT366_ALLOW_ATA66_3) ? 2 : 1;
-	info->max_mode = mode;
-
-	if (rid >= 3)
-		hpt37x_clocking(hwif);
-	else
-		hpt366_clocking(hwif);
-}
-
 static int __devinit init_setup_hpt374(struct pci_dev *dev, ide_pci_device_t *d)
 {
 	struct pci_dev *dev2;
@@ -1321,9 +1415,13 @@ static int __devinit init_setup_hpt374(s
 	if (PCI_FUNC(dev->devfn) & 1)
 		return -ENODEV;
 
+	pci_set_drvdata(dev, &hpt374);
+
 	if ((dev2 = pci_get_slot(dev->bus, dev->devfn + 1)) != NULL) {
 		int ret;
 
+		pci_set_drvdata(dev2, &hpt374);
+
 		if (dev2->irq != dev->irq) {
 			/* FIXME: we need a core pci_set_interrupt() */
 			dev2->irq = dev->irq;
@@ -1340,18 +1438,25 @@ static int __devinit init_setup_hpt374(s
 
 static int __devinit init_setup_hpt372n(struct pci_dev *dev, ide_pci_device_t *d)
 {
+	pci_set_drvdata(dev, &hpt372n);
+
 	return ide_setup_pci_device(dev, d);
 }
 
 static int __devinit init_setup_hpt371(struct pci_dev *dev, ide_pci_device_t *d)
 {
+	struct hpt_info *info;
 	u8 rev = 0, mcr1 = 0;
 
 	pci_read_config_byte(dev, PCI_REVISION_ID, &rev);
 
-	if (rev > 1)
+	if (rev > 1) {
 		d->name = "HPT371N";
 
+		info = &hpt371n;
+	} else
+		info = &hpt371;
+
 	/*
 	 * HPT371 chips physically have only one channel, the secondary one,
 	 * but the primary channel registers do exist!  Go figure...
@@ -1362,30 +1467,44 @@ static int __devinit init_setup_hpt371(s
 	if (mcr1 & 0x04)
 		pci_write_config_byte(dev, 0x50, mcr1 & ~0x04);
 
+	pci_set_drvdata(dev, info);
+
 	return ide_setup_pci_device(dev, d);
 }
 
 static int __devinit init_setup_hpt372a(struct pci_dev *dev, ide_pci_device_t *d)
 {
+	struct hpt_info *info;
 	u8 rev = 0;
 
 	pci_read_config_byte(dev, PCI_REVISION_ID, &rev);
 
-	if (rev > 1)
+	if (rev > 1) {
 		d->name = "HPT372N";
 
+		info = &hpt372n;
+	} else
+		info = &hpt372a;
+	pci_set_drvdata(dev, info);
+
 	return ide_setup_pci_device(dev, d);
 }
 
 static int __devinit init_setup_hpt302(struct pci_dev *dev, ide_pci_device_t *d)
 {
+	struct hpt_info *info;
 	u8 rev = 0;
 
 	pci_read_config_byte(dev, PCI_REVISION_ID, &rev);
 
-	if (rev > 1)
+	if (rev > 1) {
 		d->name = "HPT302N";
 
+		info = &hpt302n;
+	} else
+		info = &hpt302;
+	pci_set_drvdata(dev, info);
+
 	return ide_setup_pci_device(dev, d);
 }
 
@@ -1396,6 +1515,9 @@ static int __devinit init_setup_hpt366(s
 	static char   *chipset_names[] = { "HPT366", "HPT366",  "HPT368",
 					   "HPT370", "HPT370A", "HPT372",
 					   "HPT372N" };
+	static struct hpt_info *info[] = { &hpt36x,  &hpt36x,  &hpt36x,
+					   &hpt370,  &hpt370a, &hpt372,
+					   &hpt372n  };
 
 	if (PCI_FUNC(dev->devfn) & 1)
 		return -ENODEV;
@@ -1407,6 +1529,8 @@ static int __devinit init_setup_hpt366(s
 		
 	d->name = chipset_names[rev];
 
+	pci_set_drvdata(dev, info[rev]);
+
 	if (rev > 2)
 		goto init_single;
 
@@ -1416,6 +1540,8 @@ static int __devinit init_setup_hpt366(s
 	  	u8  pin1 = 0, pin2 = 0;
 		int ret;
 
+		pci_set_drvdata(dev2, info[rev]);
+
 		pci_read_config_byte(dev,  PCI_INTERRUPT_PIN, &pin1);
 		pci_read_config_byte(dev2, PCI_INTERRUPT_PIN, &pin2);
 		if (pin1 != pin2 && dev->irq == dev2->irq) {
@@ -1437,40 +1563,39 @@ static ide_pci_device_t hpt366_chipsets[
 		.name		= "HPT366",
 		.init_setup	= init_setup_hpt366,
 		.init_chipset	= init_chipset_hpt366,
-		.init_iops	= init_iops_hpt366,
 		.init_hwif	= init_hwif_hpt366,
 		.init_dma	= init_dma_hpt366,
 		.channels	= 2,
 		.autodma	= AUTODMA,
+		.enablebits	= {{0x50,0x04,0x04}, {0x54,0x04,0x04}},
 		.bootable	= OFF_BOARD,
 		.extra		= 240
 	},{	/* 1 */
 		.name		= "HPT372A",
 		.init_setup	= init_setup_hpt372a,
 		.init_chipset	= init_chipset_hpt366,
-		.init_iops	= init_iops_hpt366,
 		.init_hwif	= init_hwif_hpt366,
 		.init_dma	= init_dma_hpt366,
 		.channels	= 2,
 		.autodma	= AUTODMA,
+		.enablebits	= {{0x50,0x04,0x04}, {0x54,0x04,0x04}},
 		.bootable	= OFF_BOARD,
 		.extra		= 240
 	},{	/* 2 */
 		.name		= "HPT302",
 		.init_setup	= init_setup_hpt302,
 		.init_chipset	= init_chipset_hpt366,
-		.init_iops	= init_iops_hpt366,
 		.init_hwif	= init_hwif_hpt366,
 		.init_dma	= init_dma_hpt366,
 		.channels	= 2,
 		.autodma	= AUTODMA,
+		.enablebits	= {{0x50,0x04,0x04}, {0x54,0x04,0x04}},
 		.bootable	= OFF_BOARD,
 		.extra		= 240
 	},{	/* 3 */
 		.name		= "HPT371",
 		.init_setup	= init_setup_hpt371,
 		.init_chipset	= init_chipset_hpt366,
-		.init_iops	= init_iops_hpt366,
 		.init_hwif	= init_hwif_hpt366,
 		.init_dma	= init_dma_hpt366,
 		.channels	= 2,
@@ -1482,22 +1607,22 @@ static ide_pci_device_t hpt366_chipsets[
 		.name		= "HPT374",
 		.init_setup	= init_setup_hpt374,
 		.init_chipset	= init_chipset_hpt366,
-		.init_iops	= init_iops_hpt366,
 		.init_hwif	= init_hwif_hpt366,
 		.init_dma	= init_dma_hpt366,
 		.channels	= 2,	/* 4 */
 		.autodma	= AUTODMA,
+		.enablebits	= {{0x50,0x04,0x04}, {0x54,0x04,0x04}},
 		.bootable	= OFF_BOARD,
 		.extra		= 240
 	},{	/* 5 */
 		.name		= "HPT372N",
 		.init_setup	= init_setup_hpt372n,
 		.init_chipset	= init_chipset_hpt366,
-		.init_iops	= init_iops_hpt366,
 		.init_hwif	= init_hwif_hpt366,
 		.init_dma	= init_dma_hpt366,
 		.channels	= 2,	/* 4 */
 		.autodma	= AUTODMA,
+		.enablebits	= {{0x50,0x04,0x04}, {0x54,0x04,0x04}},
 		.bootable	= OFF_BOARD,
 		.extra		= 240
 	}

--------------050002040707030900080008--
