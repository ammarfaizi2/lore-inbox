Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932262AbWEPWpu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbWEPWpu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 18:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbWEPWpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 18:45:50 -0400
Received: from rtsoft2.corbina.net ([85.21.88.2]:40886 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S932261AbWEPWps
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 18:45:48 -0400
Message-ID: <446A55D6.90507@ru.mvista.com>
Date: Wed, 17 May 2006 02:44:38 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] HPT3xx: rework rate filtering
References: <444B3BDE.1030106@ru.mvista.com> <4457DC97.3010807@ru.mvista.com> <445A5A1B.60903@ru.mvista.com>
In-Reply-To: <445A5A1B.60903@ru.mvista.com>
Content-Type: multipart/mixed;
 boundary="------------030309020200050106050304"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030309020200050106050304
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

    Rework hpt3xx_ratemask() and hpt3xx_ratefilter() so that the former
returns the max. mode computed at the load time and doesn't have to do bad
Ultra33 drive list lookups anymore; remove the duplicate code from the latter
function. Move the quirky drive list lookup into hpt3xx_quirkproc() where it
should have been from the start...
    Disable UltraATA/100 for HPT370 by default as the 33 MHz ATA clock being 
used does not allow for it, and this *greatly* increases the transfer speed.
    Save some space by using byte-wide fields in struct hpt_info; switch to
reading the 8-bit PCI revision ID reg. only, not the whole 32-bit reg.
    Start incrementing the driver version number with each patch (should have
been done from the first one posted).

MBR, Sergei

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>


--------------030309020200050106050304
Content-Type: text/plain;
 name="HPT3xx-rework-rate-filtering.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="HPT3xx-rework-rate-filtering.patch"

Index: linus/drivers/ide/pci/hpt366.c
===================================================================
--- linus.orig/drivers/ide/pci/hpt366.c
+++ linus/drivers/ide/pci/hpt366.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/hpt366.c		Version 0.36	April 25, 2003
+ * linux/drivers/ide/pci/hpt366.c		Version 0.43	May 17, 2006
  *
  * Copyright (C) 1999-2003		Andre Hedrick <andre@linux-ide.org>
  * Portions Copyright (C) 2001	        Sun Microsystems, Inc.
@@ -62,8 +62,8 @@
  *   be done on 66 MHz PCI bus
  * - avoid calibrating PLL twice as the second time results in a wrong PCI
  *   frequency and thus in the wrong timings for the secondary channel
- * - disable UltraATA/133 for HPT372 by default (50 MHz DPLL clock do not
- *   allow for this speed anyway)
+ * - disable UltraATA/133 for HPT372 and UltraATA/100 for HPT370 by default
+ *   as the ATA clock being used does not allow for this speed anyway
  * - add support for HPT302N and HPT371N clocking (the same as for HPT372N)
  * - HPT371/N are single channel chips, so avoid touching the primary channel
  *   which exists only virtually (there's no pins for it)
@@ -76,6 +76,7 @@
  *   and for HPT36x the obsolete HDIO_TRISTATE_HWIF handler was called instead
  * - pass to init_chipset() handlers a copy of the IDE PCI device structure as
  *   they tamper with its fields
+ * - optimize the rate masking/filtering and the drive list lookup code
  *		<source@mvista.com>
  *
  */
@@ -337,7 +338,7 @@ static u32 sixty_six_base_hpt37x[] = {
 #define HPT371_ALLOW_ATA133_6		0
 #define HPT302_ALLOW_ATA133_6		0
 #define HPT372_ALLOW_ATA133_6		0
-#define HPT370_ALLOW_ATA100_5		1
+#define HPT370_ALLOW_ATA100_5		0
 #define HPT366_ALLOW_ATA66_4		1
 #define HPT366_ALLOW_ATA66_3		1
 #define HPT366_MAX_DEVS			8
@@ -355,8 +356,8 @@ static u32 sixty_six_base_hpt37x[] = {
 struct hpt_info
 {
 	u8 max_mode;		/* Speeds allowed */
-	int revision;		/* Chipset revision */
-	int flags;		/* Chipset properties */
+	u8 revision;		/* Chipset revision */
+	u8 flags;		/* Chipset properties */
 #define PLL_MODE	1
 #define IS_3xxN 	2
 #define PCI_66MHZ	4
@@ -365,61 +366,50 @@ struct hpt_info
 };
 
 /*
- *	This wants fixing so that we do everything not by classrev
+ *	This wants fixing so that we do everything not by revision
  *	(which breaks on the newest chips) but by creating an
  *	enumeration of chip variants and using that
  */
 
-static __devinit u32 hpt_revision (struct pci_dev *dev)
+static __devinit u8 hpt_revision(struct pci_dev *dev)
 {
-	u32 class_rev;
-	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
-	class_rev &= 0xff;
+	u8 rev = 0;
+
+	pci_read_config_byte(dev, PCI_REVISION_ID, &rev);
 
 	switch(dev->device) {
 		/* Remap new 372N onto 372 */
 		case PCI_DEVICE_ID_TTI_HPT372N:
-			class_rev = PCI_DEVICE_ID_TTI_HPT372; break;
+			rev = PCI_DEVICE_ID_TTI_HPT372; break;
 		case PCI_DEVICE_ID_TTI_HPT374:
-			class_rev = PCI_DEVICE_ID_TTI_HPT374; break;
+			rev = PCI_DEVICE_ID_TTI_HPT374; break;
 		case PCI_DEVICE_ID_TTI_HPT371:
-			class_rev = PCI_DEVICE_ID_TTI_HPT371; break;
+			rev = PCI_DEVICE_ID_TTI_HPT371; break;
 		case PCI_DEVICE_ID_TTI_HPT302:
-			class_rev = PCI_DEVICE_ID_TTI_HPT302; break;
+			rev = PCI_DEVICE_ID_TTI_HPT302; break;
 		case PCI_DEVICE_ID_TTI_HPT372:
-			class_rev = PCI_DEVICE_ID_TTI_HPT372; break;
+			rev = PCI_DEVICE_ID_TTI_HPT372; break;
 		default:
 			break;
 	}
-	return class_rev;
+	return rev;
 }
 
-static int check_in_drive_lists(ide_drive_t *drive, const char **list);
-
-static u8 hpt3xx_ratemask (ide_drive_t *drive)
+static int check_in_drive_list(ide_drive_t *drive, const char **list)
 {
-	ide_hwif_t *hwif	= drive->hwif;
-	struct hpt_info *info	= ide_get_hwifdata(hwif);
-	u8 mode			= 0;
+	struct hd_driveid *id = drive->id;
 
-	/* FIXME: TODO - move this to set info->mode once at boot */
+	while (*list)
+		if (!strcmp(*list++,id->model))
+			return 1;
+	return 0;
+}
+
+static u8 hpt3xx_ratemask(ide_drive_t *drive)
+{
+	struct hpt_info *info	= ide_get_hwifdata(HWIF(drive));
+	u8 mode			= info->max_mode;
 
-	if (info->revision >= 8) {		/* HPT374 */
-		mode = (HPT374_ALLOW_ATA133_6) ? 4 : 3;
-	} else if (info->revision >= 7) {	/* HPT371 */
-		mode = (HPT371_ALLOW_ATA133_6) ? 4 : 3;
-	} else if (info->revision >= 6) {	/* HPT302 */
-		mode = (HPT302_ALLOW_ATA133_6) ? 4 : 3;
-	} else if (info->revision >= 5) {	/* HPT372 */
-		mode = (HPT372_ALLOW_ATA133_6) ? 4 : 3;
-	} else if (info->revision >= 4) {	/* HPT370A */
-		mode = (HPT370_ALLOW_ATA100_5) ? 3 : 2;
-	} else if (info->revision >= 3) {	/* HPT370 */
-		mode = (HPT370_ALLOW_ATA100_5) ? 3 : 2;
-		mode = (check_in_drive_lists(drive, bad_ata33)) ? 0 : mode;
-	} else {				/* HPT366 and HPT368 */
-		mode = (check_in_drive_lists(drive, bad_ata33)) ? 0 : 2;
-	}
 	if (!eighty_ninty_three(drive) && mode)
 		mode = min(mode, (u8)1);
 	return mode;
@@ -430,16 +420,15 @@ static u8 hpt3xx_ratemask (ide_drive_t *
  *	either PIO or UDMA modes 0,4,5
  */
  
-static u8 hpt3xx_ratefilter (ide_drive_t *drive, u8 speed)
+static u8 hpt3xx_ratefilter(ide_drive_t *drive, u8 speed)
 {
-	ide_hwif_t *hwif	= drive->hwif;
-	struct hpt_info *info	= ide_get_hwifdata(hwif);
+	struct hpt_info *info	= ide_get_hwifdata(HWIF(drive));
 	u8 mode			= hpt3xx_ratemask(drive);
 
 	if (drive->media != ide_disk)
 		return min(speed, (u8)XFER_PIO_4);
 
-	switch(mode) {
+	switch (mode) {
 		case 0x04:
 			speed = min(speed, (u8)XFER_UDMA_6);
 			break;
@@ -447,33 +436,34 @@ static u8 hpt3xx_ratefilter (ide_drive_t
 			speed = min(speed, (u8)XFER_UDMA_5);
 			if (info->revision >= 5)
 				break;
-			if (check_in_drive_lists(drive, bad_ata100_5))
-				speed = min(speed, (u8)XFER_UDMA_4);
-			break;
+			if (!check_in_drive_list(drive, bad_ata100_5))
+				goto check_bad_ata33;
+			/* fall thru */
 		case 0x02:
 			speed = min(speed, (u8)XFER_UDMA_4);
 	/*
 	 * CHECK ME, Does this need to be set to 5 ??
 	 */
 			if (info->revision >= 3)
-				break;
-			if ((check_in_drive_lists(drive, bad_ata66_4)) ||
-			    (!(HPT366_ALLOW_ATA66_4)))
-				speed = min(speed, (u8)XFER_UDMA_3);
-			if ((check_in_drive_lists(drive, bad_ata66_3)) ||
-			    (!(HPT366_ALLOW_ATA66_3)))
-				speed = min(speed, (u8)XFER_UDMA_2);
-			break;
+				goto check_bad_ata33;
+			if (HPT366_ALLOW_ATA66_4 &&
+			    !check_in_drive_list(drive, bad_ata66_4))
+				goto check_bad_ata33;
+
+			speed = min(speed, (u8)XFER_UDMA_3);
+			if (HPT366_ALLOW_ATA66_3 &&
+			    !check_in_drive_list(drive, bad_ata66_3))
+				goto check_bad_ata33;
+			/* fall thru */
 		case 0x01:
 			speed = min(speed, (u8)XFER_UDMA_2);
-	/*
-	 * CHECK ME, Does this need to be set to 5 ??
-	 */
-			if (info->revision >= 3)
+
+		check_bad_ata33:
+ 			if (info->revision >= 4)
 				break;
-			if (check_in_drive_lists(drive, bad_ata33))
-				speed = min(speed, (u8)XFER_MW_DMA_2);
-			break;
+			if (!check_in_drive_list(drive, bad_ata33))
+				break;
+			/* fall thru */
 		case 0x00:
 		default:
 			speed = min(speed, (u8)XFER_MW_DMA_2);
@@ -482,22 +472,6 @@ static u8 hpt3xx_ratefilter (ide_drive_t
 	return speed;
 }
 
-static int check_in_drive_lists (ide_drive_t *drive, const char **list)
-{
-	struct hd_driveid *id = drive->id;
-
-	if (quirk_drives == list) {
-		while (*list)
-			if (strstr(id->model, *list++))
-				return 1;
-	} else {
-		while (*list)
-			if (!strcmp(*list++,id->model))
-				return 1;
-	}
-	return 0;
-}
-
 static u32 pci_bus_clock_list(u8 speed, u32 *chipset_table)
 {
 	int i;
@@ -672,9 +646,15 @@ static int config_chipset_for_dma (ide_d
 	return ide_dma_enable(drive);
 }
 
-static int hpt3xx_quirkproc (ide_drive_t *drive)
+static int hpt3xx_quirkproc(ide_drive_t *drive)
 {
-	return ((int) check_in_drive_lists(drive, quirk_drives));
+	struct hd_driveid *id	= drive->id;
+	const  char **list	= quirk_drives;
+
+	while (*list)
+		if (strstr(id->model, *list++))
+			return 1;
+	return 0;
 }
 
 static void hpt3xx_intrproc (ide_drive_t *drive)
@@ -1382,7 +1362,7 @@ static void __devinit init_iops_hpt366(i
 	struct hpt_info *info	= kzalloc(sizeof(struct hpt_info), GFP_KERNEL);
 	struct pci_dev  *dev	= hwif->pci_dev;
 	u16 did			= dev->device;
-	u8  rid			= 0;
+	u8 mode, rid		= 0;
 
 	if(info == NULL) {
 		printk(KERN_WARNING "hpt366: out of memory.\n");
@@ -1396,7 +1376,7 @@ static void __devinit init_iops_hpt366(i
 		return;
 	}
 
-	pci_read_config_byte(dev, PCI_CLASS_REVISION, &rid);
+	pci_read_config_byte(dev, PCI_REVISION_ID, &rid);
 
 	if (( did == PCI_DEVICE_ID_TTI_HPT366  && rid == 6) ||
 	    ((did == PCI_DEVICE_ID_TTI_HPT372  ||
@@ -1405,9 +1385,22 @@ static void __devinit init_iops_hpt366(i
 	      did == PCI_DEVICE_ID_TTI_HPT372N)
 		info->flags |= IS_3xxN;
 
-	info->revision = hpt_revision(dev);
+	rid = info->revision = hpt_revision(dev);
+	if (rid >= 8)			/* HPT374 */
+		mode = HPT374_ALLOW_ATA133_6 ? 4 : 3;
+	else if (rid >= 7)		/* HPT371 and HPT371N */
+		mode = HPT371_ALLOW_ATA133_6 ? 4 : 3;
+	else if (rid >= 6)		/* HPT302 and HPT302N */
+		mode = HPT302_ALLOW_ATA133_6 ? 4 : 3;
+	else if (rid >= 5)		/* HPT372, HPT372A, and HPT372N */
+		mode = HPT372_ALLOW_ATA133_6 ? 4 : 3;
+	else if (rid >= 3)		/* HPT370 and HPT370A */
+		mode = HPT370_ALLOW_ATA100_5 ? 3 : 2;
+	else				/* HPT366 and HPT368 */
+		mode = (HPT366_ALLOW_ATA66_4 || HPT366_ALLOW_ATA66_3) ? 2 : 1;
+	info->max_mode = mode;
 
-	if (info->revision >= 3)
+	if (rid >= 3)
 		hpt37x_clocking(hwif);
 	else
 		hpt366_clocking(hwif);
@@ -1462,8 +1455,7 @@ static int __devinit init_setup_hpt371(s
 static int __devinit init_setup_hpt366(struct pci_dev *dev, ide_pci_device_t *d)
 {
 	struct pci_dev *findev = NULL;
-	u8 pin1 = 0, pin2 = 0;
-	unsigned int class_rev;
+	u8 rev = 0, pin1 = 0, pin2 = 0;
 	char *chipset_names[] = {"HPT366", "HPT366",  "HPT368",
 				 "HPT370", "HPT370A", "HPT372",
 				 "HPT372N" };
@@ -1471,16 +1463,15 @@ static int __devinit init_setup_hpt366(s
 	if (PCI_FUNC(dev->devfn) & 1)
 		return -ENODEV;
 
-	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
-	class_rev &= 0xff;
+	pci_read_config_byte(dev, PCI_REVISION_ID, &rev);
 
 	if(dev->device == PCI_DEVICE_ID_TTI_HPT372N)
-		class_rev = 6;
+		rev = 6;
 		
-	if(class_rev <= 6)
-		d->name = chipset_names[class_rev];
+	if(rev <= 6)
+		d->name = chipset_names[rev];
 
-	switch(class_rev) {
+	switch(rev) {
 		case 6:
 		case 5:
 		case 4:



--------------030309020200050106050304--
