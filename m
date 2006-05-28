Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965207AbWE1C4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965207AbWE1C4j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 22:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965216AbWE1C4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 22:56:39 -0400
Received: from rtsoft2.corbina.net ([85.21.88.2]:39817 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S965206AbWE1C4h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 22:56:37 -0400
Message-ID: <4479112D.8070501@ru.mvista.com>
Date: Sun, 28 May 2006 06:55:41 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] HPT3xx: cache channel's MCR address
References: <444B3BDE.1030106@ru.mvista.com> <4457DC97.3010807@ru.mvista.com> <445A5A1B.60903@ru.mvista.com> <446A55D6.90507@ru.mvista.com> <446ED8A3.6030702@ru.mvista.com> <4478CD3D.6010409@ru.mvista.com> <4478E104.7040200@ru.mvista.com>
In-Reply-To: <4478E104.7040200@ru.mvista.com>
Content-Type: multipart/mixed;
 boundary="------------090902050600020407080707"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090902050600020407080707
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Begin the real driver redesign. For the starters:

- cache the offset of the IDE channel's MISC. control registers which are used
   throughout the driver in hwif->select_data;

- only touch the relevant MCR when detecting the cable type on HPT374's
   function 1;

- make HPT36x's speedproc handler look the same way as HPT37x ones; fix the
   PIO timing register mask for HPT37x.

- rename all the HPT3xx register related variables consistently; clean up the
   whitespace.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>


--------------090902050600020407080707
Content-Type: text/plain;
 name="HPT3xx-cache-MCR-address.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="HPT3xx-cache-MCR-address.patch"

Index: linus/drivers/ide/pci/hpt366.c
===================================================================
--- linus.orig/drivers/ide/pci/hpt366.c
+++ linus/drivers/ide/pci/hpt366.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/hpt366.c		Version 0.45	May 27, 2006
+ * linux/drivers/ide/pci/hpt366.c		Version 0.50	May 28, 2006
  *
  * Copyright (C) 1999-2003		Andre Hedrick <andre@linux-ide.org>
  * Portions Copyright (C) 2001	        Sun Microsystems, Inc.
@@ -80,6 +80,11 @@
  * - claim the extra 240 bytes of I/O space for all chips
  * - optimize the rate masking/filtering and the drive list lookup code
  * - use pci_get_slot() to get to the function 1 of HPT36x/374
+ * - cache the channel's MCRs' offset; only touch the relevant MCR when detecting
+ *   the cable type on HPT374's function 1
+ * - rename all the register related variables consistently
+ * - make HPT36x's speedproc handler look the same way as HPT37x ones; fix the
+ *   PIO timing register mask for HPT37x
  *		<source@mvista.com>
  *
  */
@@ -493,109 +498,106 @@ static u32 pci_bus_clock_list(u8 speed, 
 
 static int hpt36x_tune_chipset(ide_drive_t *drive, u8 xferspeed)
 {
-	ide_hwif_t *hwif	= drive->hwif;
-	struct pci_dev *dev	= hwif->pci_dev;
-	struct hpt_info	*info	= ide_get_hwifdata(hwif);
-	u8 speed		= hpt3xx_ratefilter(drive, xferspeed);
-	u8 regtime		= (drive->select.b.unit & 0x01) ? 0x44 : 0x40;
-	u8 regfast		= (hwif->channel) ? 0x55 : 0x51;
-	u8 drive_fast		= 0;
-	u32 reg1 = 0, reg2	= 0;
+	ide_hwif_t *hwif	= HWIF(drive);
+	struct pci_dev  *dev	= hwif->pci_dev;
+	struct hpt_info	*info	= ide_get_hwifdata (hwif);
+	u8  speed		= hpt3xx_ratefilter(drive, xferspeed);
+	u8  itr_addr		= drive->dn ? 0x44 : 0x40;
+	u8  mcr_addr		= hwif->select_data + 1;
+	u8  mcr			= 0;
+	u32 new_itr, old_itr	= 0;
+	u32 itr_mask		= (speed < XFER_MW_DMA_0) ? 0x30070000 : 0xc0000000;
 
 	/*
 	 * Disable the "fast interrupt" prediction.
 	 */
-	pci_read_config_byte(dev, regfast, &drive_fast);
-	if (drive_fast & 0x80)
-		pci_write_config_byte(dev, regfast, drive_fast & ~0x80);
+	pci_read_config_byte(dev, mcr_addr, &mcr);
+	if (mcr & 0x80)
+		pci_write_config_byte(dev, mcr_addr, mcr & ~0x80);
 
-	reg2 = pci_bus_clock_list(speed, info->speed);
+	new_itr = pci_bus_clock_list(speed, info->speed);
 
 	/*
-	 * Disable on-chip PIO FIFO/buffer
-	 *  (to avoid problems handling I/O errors later)
+	 * Disable on-chip PIO FIFO/buffer (and PIO MST mode as well)
+	 * to avoid problems handling I/O errors later
 	 */
-	pci_read_config_dword(dev, regtime, &reg1);
-	if (speed >= XFER_MW_DMA_0) {
-		reg2 = (reg2 & ~0xc0000000) | (reg1 & 0xc0000000);
-	} else {
-		reg2 = (reg2 & ~0x30070000) | (reg1 & 0x30070000);
-	}	
-	reg2 &= ~0x80000000;
+	pci_read_config_dword(dev, itr_addr, &old_itr);
+	new_itr  = (new_itr & ~itr_mask) | (old_itr & itr_mask);
+	new_itr &= ~0xc0000000;
 
-	pci_write_config_dword(dev, regtime, reg2);
+	pci_write_config_dword(dev, itr_addr, new_itr);
 
 	return ide_config_drive_speed(drive, speed);
 }
 
 static int hpt370_tune_chipset(ide_drive_t *drive, u8 xferspeed)
 {
-	ide_hwif_t *hwif	= drive->hwif;
-	struct pci_dev *dev = hwif->pci_dev;
-	struct hpt_info	*info	= ide_get_hwifdata(hwif);
-	u8 speed	= hpt3xx_ratefilter(drive, xferspeed);
-	u8 regfast	= (drive->hwif->channel) ? 0x55 : 0x51;
-	u8 drive_pci	= 0x40 + (drive->dn * 4);
-	u8 new_fast	= 0, drive_fast = 0;
-	u32 list_conf	= 0, drive_conf = 0;
-	u32 conf_mask	= (speed >= XFER_MW_DMA_0) ? 0xc0000000 : 0x30070000;
+	ide_hwif_t *hwif	= HWIF(drive);
+	struct pci_dev  *dev	= hwif->pci_dev;
+	struct hpt_info	*info	= ide_get_hwifdata (hwif);
+	u8  speed		= hpt3xx_ratefilter(drive, xferspeed);
+	u8  mcr_addr		= hwif->select_data + 1;
+	u8  itr_addr		= 0x40 + (drive->dn * 4);
+	u8  new_mcr		= 0, old_mcr = 0;
+	u32 new_itr, old_itr	= 0;
+	u32 itr_mask		= (speed < XFER_MW_DMA_0) ? 0x303c0000 : 0xc0000000;
 
 	/*
 	 * Disable the "fast interrupt" prediction.
 	 * don't holdoff on interrupts. (== 0x01 despite what the docs say) 
 	 */
-	pci_read_config_byte(dev, regfast, &drive_fast);
-	new_fast = drive_fast;
-	if (new_fast & 0x02)
-		new_fast &= ~0x02;
+	pci_read_config_byte(dev, mcr_addr, &old_mcr);
+	new_mcr = old_mcr;
+	if (new_mcr & 0x02)
+		new_mcr &= ~0x02;
 
 #ifdef HPT_DELAY_INTERRUPT
-	if (new_fast & 0x01)
-		new_fast &= ~0x01;
+	if (new_mcr & 0x01)
+		new_mcr &= ~0x01;
 #else
-	if ((new_fast & 0x01) == 0)
-		new_fast |= 0x01;
+	if ((new_mcr & 0x01) == 0)
+		new_mcr |= 0x01;
 #endif
-	if (new_fast != drive_fast)
-		pci_write_config_byte(dev, regfast, new_fast);
+	if (new_mcr != old_mcr)
+		pci_write_config_byte(dev, mcr_addr, new_mcr);
 
-	list_conf = pci_bus_clock_list(speed, info->speed);
+	new_itr = pci_bus_clock_list(speed, info->speed);
 
-	pci_read_config_dword(dev, drive_pci, &drive_conf);
-	list_conf = (list_conf & ~conf_mask) | (drive_conf & conf_mask);
+	pci_read_config_dword(dev, itr_addr, &old_itr);
+	new_itr = (new_itr & ~itr_mask) | (old_itr & itr_mask);
 	
 	if (speed < XFER_MW_DMA_0)
-		list_conf &= ~0x80000000; /* Disable on-chip PIO FIFO/buffer */
-	pci_write_config_dword(dev, drive_pci, list_conf);
+		new_itr &= ~0x80000000; /* Disable on-chip PIO FIFO/buffer */
+	pci_write_config_dword(dev, itr_addr, new_itr);
 
 	return ide_config_drive_speed(drive, speed);
 }
 
 static int hpt372_tune_chipset(ide_drive_t *drive, u8 xferspeed)
 {
-	ide_hwif_t *hwif	= drive->hwif;
-	struct pci_dev *dev	= hwif->pci_dev;
-	struct hpt_info	*info	= ide_get_hwifdata(hwif);
-	u8 speed	= hpt3xx_ratefilter(drive, xferspeed);
-	u8 regfast	= (drive->hwif->channel) ? 0x55 : 0x51;
-	u8 drive_fast	= 0, drive_pci = 0x40 + (drive->dn * 4);
-	u32 list_conf	= 0, drive_conf = 0;
-	u32 conf_mask	= (speed >= XFER_MW_DMA_0) ? 0xc0000000 : 0x30070000;
+	ide_hwif_t *hwif	= HWIF(drive);
+	struct pci_dev  *dev	= hwif->pci_dev;
+	struct hpt_info	*info	= ide_get_hwifdata (hwif);
+	u8  speed		= hpt3xx_ratefilter(drive, xferspeed);
+	u8  mcr_addr		= hwif->select_data + 1;
+	u8  itr_addr		= 0x40 + (drive->dn * 4);
+	u8  mcr			= 0;
+	u32 new_itr, old_itr	= 0;
+	u32 itr_mask		= (speed < XFER_MW_DMA_0) ? 0x303c0000 : 0xc0000000;
 
 	/*
 	 * Disable the "fast interrupt" prediction.
 	 * don't holdoff on interrupts. (== 0x01 despite what the docs say)
 	 */
-	pci_read_config_byte(dev, regfast, &drive_fast);
-	drive_fast &= ~0x07;
-	pci_write_config_byte(dev, regfast, drive_fast);
-
-	list_conf = pci_bus_clock_list(speed, info->speed);
-	pci_read_config_dword(dev, drive_pci, &drive_conf);
-	list_conf = (list_conf & ~conf_mask) | (drive_conf & conf_mask);
+	pci_read_config_byte (dev, mcr_addr, &mcr);
+	pci_write_config_byte(dev, mcr_addr, (mcr & ~0x07));
+
+	new_itr = pci_bus_clock_list(speed, info->speed);
+	pci_read_config_dword(dev, itr_addr, &old_itr);
+	new_itr = (new_itr & ~itr_mask) | (old_itr & itr_mask);
 	if (speed < XFER_MW_DMA_0)
-		list_conf &= ~0x80000000; /* Disable on-chip PIO FIFO/buffer */
-	pci_write_config_dword(dev, drive_pci, list_conf);
+		new_itr &= ~0x80000000; /* Disable on-chip PIO FIFO/buffer */
+	pci_write_config_dword(dev, itr_addr, new_itr);
 
 	return ide_config_drive_speed(drive, speed);
 }
@@ -662,39 +664,41 @@ static int hpt3xx_quirkproc(ide_drive_t 
 
 static void hpt3xx_intrproc (ide_drive_t *drive)
 {
-	ide_hwif_t *hwif = drive->hwif;
+	ide_hwif_t *hwif = HWIF(drive);
 
 	if (drive->quirk_list)
 		return;
 	/* drives in the quirk_list may not like intr setups/cleanups */
-	hwif->OUTB(drive->ctl|2, IDE_CONTROL_REG);
+	hwif->OUTB(drive->ctl | 2, IDE_CONTROL_REG);
 }
 
 static void hpt3xx_maskproc (ide_drive_t *drive, int mask)
 {
-	ide_hwif_t *hwif = drive->hwif;
-	struct hpt_info *info = ide_get_hwifdata(hwif);
-	struct pci_dev *dev = hwif->pci_dev;
+	ide_hwif_t *hwif	= HWIF(drive);
+	struct pci_dev	*dev	= hwif->pci_dev;
+	struct hpt_info *info	= ide_get_hwifdata(hwif);
 
 	if (drive->quirk_list) {
 		if (info->revision >= 3) {
-			u8 reg5a = 0;
-			pci_read_config_byte(dev, 0x5a, &reg5a);
-			if (((reg5a & 0x10) >> 4) != mask)
-				pci_write_config_byte(dev, 0x5a, mask ? (reg5a | 0x10) : (reg5a & ~0x10));
+			u8 scr1 = 0;
+
+			pci_read_config_byte(dev, 0x5a, &scr1);
+			if (((scr1 & 0x10) >> 4) != mask) {
+				if (mask)
+					scr1 |=  0x10;
+				else
+					scr1 &= ~0x10;
+				pci_write_config_byte(dev, 0x5a, scr1);
+			}
 		} else {
-			if (mask) {
+			if (mask)
 				disable_irq(hwif->irq);
-			} else {
-				enable_irq(hwif->irq);
-			}
+			else
+				enable_irq (hwif->irq);
 		}
-	} else {
-		if (IDE_CONTROL_REG)
-			hwif->OUTB(mask ? (drive->ctl | 2) :
-						 (drive->ctl & ~2),
-						 IDE_CONTROL_REG);
-	}
+	} else
+		hwif->OUTB(mask ? (drive->ctl | 2) : (drive->ctl & ~2),
+			   IDE_CONTROL_REG);
 }
 
 static int hpt366_config_drive_xfer_rate (ide_drive_t *drive)
@@ -723,28 +727,29 @@ fast_ata_pio:
 }
 
 /*
- * This is specific to the HPT366 UDMA bios chipset
+ * This is specific to the HPT366 UDMA chipset
  * by HighPoint|Triones Technologies, Inc.
  */
-static int hpt366_ide_dma_lostirq (ide_drive_t *drive)
+static int hpt366_ide_dma_lostirq(ide_drive_t *drive)
 {
-	struct pci_dev *dev	= HWIF(drive)->pci_dev;
-	u8 reg50h = 0, reg52h = 0, reg5ah = 0;
+	struct pci_dev *dev = HWIF(drive)->pci_dev;
+	u8 mcr1 = 0, mcr3 = 0, scr1 = 0;
 
-	pci_read_config_byte(dev, 0x50, &reg50h);
-	pci_read_config_byte(dev, 0x52, &reg52h);
-	pci_read_config_byte(dev, 0x5a, &reg5ah);
-	printk("%s: (%s)  reg50h=0x%02x, reg52h=0x%02x, reg5ah=0x%02x\n",
-		drive->name, __FUNCTION__, reg50h, reg52h, reg5ah);
-	if (reg5ah & 0x10)
-		pci_write_config_byte(dev, 0x5a, reg5ah & ~0x10);
+	pci_read_config_byte(dev, 0x50, &mcr1);
+	pci_read_config_byte(dev, 0x52, &mcr3);
+	pci_read_config_byte(dev, 0x5a, &scr1);
+	printk("%s: (%s)  mcr1=0x%02x, mcr3=0x%02x, scr1=0x%02x\n",
+		drive->name, __FUNCTION__, mcr1, mcr3, scr1);
+	if (scr1 & 0x10)
+		pci_write_config_byte(dev, 0x5a, scr1 & ~0x10);
 	return __ide_dma_lostirq(drive);
 }
 
 static void hpt370_clear_engine (ide_drive_t *drive)
 {
-	u8 regstate = HWIF(drive)->channel ? 0x54 : 0x50;
-	pci_write_config_byte(HWIF(drive)->pci_dev, regstate, 0x37);
+	ide_hwif_t *hwif = HWIF(drive);
+
+	pci_write_config_byte(hwif->pci_dev, hwif->select_data, 0x37);
 	udelay(10);
 }
 
@@ -776,10 +781,10 @@ static int hpt370_ide_dma_end (ide_drive
 static void hpt370_lostirq_timeout (ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
-	u8 bfifo = 0, reginfo	= hwif->channel ? 0x56 : 0x52;
+	u8 bfifo = 0;
 	u8 dma_stat = 0, dma_cmd = 0;
 
-	pci_read_config_byte(HWIF(drive)->pci_dev, reginfo, &bfifo);
+	pci_read_config_byte(HWIF(drive)->pci_dev, hwif->select_data + 2, &bfifo);
 	printk(KERN_DEBUG "%s: %d bytes in FIFO\n", drive->name, bfifo);
 	hpt370_clear_engine(drive);
 	/* get dma command mode */
@@ -810,10 +815,9 @@ static int hpt374_ide_dma_test_irq(ide_d
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	u16 bfifo		= 0;
-	u8 reginfo		= hwif->channel ? 0x56 : 0x52;
-	u8 dma_stat;
+	u8  dma_stat;
 
-	pci_read_config_word(hwif->pci_dev, reginfo, &bfifo);
+	pci_read_config_word(hwif->pci_dev, hwif->select_data + 2, &bfifo);
 	if (bfifo & 0x1FF) {
 //		printk("%s: %d bytes in FIFO\n", drive->name, bfifo);
 		return 0;
@@ -821,7 +825,7 @@ static int hpt374_ide_dma_test_irq(ide_d
 
 	dma_stat = hwif->INB(hwif->dma_status);
 	/* return 1 if INTR asserted */
-	if ((dma_stat & 4) == 4)
+	if (dma_stat & 4)
 		return 1;
 
 	if (!drive->waiting_for_dma)
@@ -830,17 +834,17 @@ static int hpt374_ide_dma_test_irq(ide_d
 	return 0;
 }
 
-static int hpt374_ide_dma_end (ide_drive_t *drive)
+static int hpt374_ide_dma_end(ide_drive_t *drive)
 {
-	struct pci_dev *dev	= HWIF(drive)->pci_dev;
 	ide_hwif_t *hwif	= HWIF(drive);
-	u8 msc_stat = 0, mscreg	= hwif->channel ? 0x54 : 0x50;
-	u8 bwsr_stat = 0, bwsr_mask = hwif->channel ? 0x02 : 0x01;
-
-	pci_read_config_byte(dev, 0x6a, &bwsr_stat);
-	pci_read_config_byte(dev, mscreg, &msc_stat);
-	if ((bwsr_stat & bwsr_mask) == bwsr_mask)
-		pci_write_config_byte(dev, mscreg, msc_stat|0x30);
+	struct pci_dev	*dev	= hwif->pci_dev;
+	u8 mcr	= 0, mcr_addr	= hwif->select_data;
+	u8 bwsr = 0, mask	= hwif->channel ? 0x02 : 0x01;
+
+	pci_read_config_byte(dev, 0x6a, &bwsr);
+	pci_read_config_byte(dev, mcr_addr, &mcr);
+	if (bwsr & mask)
+		pci_write_config_byte(dev, mcr_addr, mcr | 0x30);
 	return __ide_dma_end(drive);
 }
 
@@ -906,6 +910,7 @@ static void hpt3xxn_rw_disk(ide_drive_t 
 
 /* 
  * Set/get power state for a drive.
+ * NOTE: affects both drives on each channel.
  *
  * When we turn the power back on, we need to re-initialize things.
  */
@@ -913,26 +918,18 @@ static void hpt3xxn_rw_disk(ide_drive_t 
 
 static int hpt3xx_busproc(ide_drive_t *drive, int state)
 {
-	ide_hwif_t *hwif	= drive->hwif;
+	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= hwif->pci_dev;
-	u8  tristate, resetmask, bus_reg = 0;
-	u16 tri_reg = 0;
+	u8  mcr_addr		= hwif->select_data + 2;
+	u8  resetmask		= hwif->channel ? 0x80 : 0x40;
+	u8  bsr2		= 0;
+	u16 mcr			= 0;
 
 	hwif->bus_state = state;
 
-	if (hwif->channel) { 
-		/* secondary channel */
-		tristate  = 0x56;
-		resetmask = 0x80;
-	} else { 
-		/* primary channel */
-		tristate  = 0x52;
-		resetmask = 0x40;
-	}
-
 	/* Grab the status. */
-	pci_read_config_word(dev, tristate, &tri_reg);
-	pci_read_config_byte(dev, 0x59, &bus_reg);
+	pci_read_config_word(dev, mcr_addr, &mcr);
+	pci_read_config_byte(dev, 0x59, &bsr2);
 
 	/*
 	 * Set the state. We don't set it if we don't need to do so.
@@ -940,22 +937,22 @@ static int hpt3xx_busproc(ide_drive_t *d
 	 */
 	switch (state) {
 	case BUSSTATE_ON:
-		if (!(bus_reg & resetmask))
+		if (!(bsr2 & resetmask))
 			return 0;
 		hwif->drives[0].failures = hwif->drives[1].failures = 0;
 
-		pci_write_config_byte(dev, 0x59, bus_reg & ~resetmask);
-		pci_write_config_word(dev, tristate, tri_reg & ~TRISTATE_BIT);
+		pci_write_config_byte(dev, 0x59, bsr2 & ~resetmask);
+		pci_write_config_word(dev, mcr_addr, mcr & ~TRISTATE_BIT);
 		return 0;
 	case BUSSTATE_OFF:
-		if ((bus_reg & resetmask) && !(tri_reg & TRISTATE_BIT))
+		if ((bsr2 & resetmask) && !(mcr & TRISTATE_BIT))
 			return 0;
-		tri_reg &= ~TRISTATE_BIT;
+		mcr &= ~TRISTATE_BIT;
 		break;
 	case BUSSTATE_TRISTATE:
-		if ((bus_reg & resetmask) &&  (tri_reg & TRISTATE_BIT))
+		if ((bsr2 & resetmask) &&  (mcr & TRISTATE_BIT))
 			return 0;
-		tri_reg |= TRISTATE_BIT;
+		mcr |= TRISTATE_BIT;
 		break;
 	default:
 		return -EINVAL;
@@ -964,20 +961,20 @@ static int hpt3xx_busproc(ide_drive_t *d
 	hwif->drives[0].failures = hwif->drives[0].max_failures + 1;
 	hwif->drives[1].failures = hwif->drives[1].max_failures + 1;
 
-	pci_write_config_word(dev, tristate, tri_reg);
-	pci_write_config_byte(dev, 0x59, bus_reg | resetmask);
+	pci_write_config_word(dev, mcr_addr, mcr);
+	pci_write_config_byte(dev, 0x59, bsr2 | resetmask);
 	return 0;
 }
 
 static void __devinit hpt366_clocking(ide_hwif_t *hwif)
 {
-	u32 reg1	= 0;
+	u32 itr1	= 0;
 	struct hpt_info *info = ide_get_hwifdata(hwif);
 
-	pci_read_config_dword(hwif->pci_dev, 0x40, &reg1);
+	pci_read_config_dword(hwif->pci_dev, 0x40, &itr1);
 
 	/* detect bus speed by looking at control reg timing: */
-	switch((reg1 >> 8) & 7) {
+	switch((itr1 >> 8) & 7) {
 		case 5:
 			info->speed = forty_base_hpt36x;
 			break;
@@ -999,7 +996,7 @@ static void __devinit hpt37x_clocking(id
 	int adjust, i;
 	u16 freq = 0;
 	u32 pll, temp = 0;
-	u8 reg5bh = 0, mcr1 = 0;
+	u8  scr2 = 0, mcr1 = 0;
 	
 	/*
 	 * default to pci clock. make sure MA15/16 are set to output
@@ -1112,13 +1109,13 @@ static void __devinit hpt37x_clocking(id
 
 		/* wait for clock stabilization */
 		for (i = 0; i < 0x50000; i++) {
-			pci_read_config_byte(dev, 0x5b, &reg5bh);
-			if (reg5bh & 0x80) {
+			pci_read_config_byte(dev, 0x5b, &scr2);
+			if (scr2 & 0x80) {
 				/* spin looking for the clock to destabilize */
 				for (i = 0; i < 0x1000; ++i) {
 					pci_read_config_byte(dev, 0x5b, 
-							     &reg5bh);
-					if ((reg5bh & 0x80) == 0)
+							     &scr2);
+					if ((scr2 & 0x80) == 0)
 						goto pll_recal;
 				}
 				pci_read_config_dword(dev, 0x5c, &pll);
@@ -1155,26 +1152,24 @@ init_hpt37X_done:
 
 static int __devinit init_hpt37x(struct pci_dev *dev)
 {
-	u8 reg5ah;
+	u8 scr1;
 
-	pci_read_config_byte(dev, 0x5a, &reg5ah);
+	pci_read_config_byte (dev, 0x5a, &scr1);
 	/* interrupt force enable */
-	pci_write_config_byte(dev, 0x5a, (reg5ah & ~0x10));
+	pci_write_config_byte(dev, 0x5a, (scr1 & ~0x10));
 	return 0;
 }
 
 static int __devinit init_hpt366(struct pci_dev *dev)
 {
-	u32 reg1	= 0;
-	u8 drive_fast	= 0;
+	u8 mcr	= 0;
 
 	/*
 	 * Disable the "fast interrupt" prediction.
 	 */
-	pci_read_config_byte(dev, 0x51, &drive_fast);
-	if (drive_fast & 0x80)
-		pci_write_config_byte(dev, 0x51, drive_fast & ~0x80);
-	pci_read_config_dword(dev, 0x40, &reg1);
+	pci_read_config_byte(dev, 0x51, &mcr);
+	if (mcr & 0x80)
+		pci_write_config_byte(dev, 0x51, mcr & ~0x80);
 									
 	return 0;
 }
@@ -1209,17 +1204,21 @@ static unsigned int __devinit init_chips
 
 static void __devinit init_hwif_hpt366(ide_hwif_t *hwif)
 {
-	struct pci_dev *dev		= hwif->pci_dev;
+	struct pci_dev  *dev		= hwif->pci_dev;
 	struct hpt_info *info		= ide_get_hwifdata(hwif);
-	u8 ata66 = 0, regmask		= (hwif->channel) ? 0x01 : 0x02;
 	int serialize			= HPT_SERIALIZE_IO;
-	
+	u8  scr1 = 0, ata66		= (hwif->channel) ? 0x01 : 0x02;
+
+	/* Cache the channel's MISC. control registers' offset */
+	hwif->select_data		= hwif->channel ? 0x54 : 0x50;
+
 	hwif->tuneproc			= &hpt3xx_tune_drive;
 	hwif->speedproc			= &hpt3xx_tune_chipset;
 	hwif->quirkproc			= &hpt3xx_quirkproc;
 	hwif->intrproc			= &hpt3xx_intrproc;
 	hwif->maskproc			= &hpt3xx_maskproc;
-	
+	hwif->busproc			= &hpt3xx_busproc;
+
 	/*
 	 * HPT3xxN chips have some complications:
 	 *
@@ -1237,7 +1236,7 @@ static void __devinit init_hwif_hpt366(i
 
 	/*
 	 * The HPT37x uses the CBLID pins as outputs for MA15/MA16
-	 * address lines to access an external eeprom.  To read valid
+	 * address lines to access an external EEPROM.  To read valid
 	 * cable detect state the pins must be enabled as inputs.
 	 */
 	if (info->revision >= 8 && (PCI_FUNC(dev->devfn) & 1)) {
@@ -1246,35 +1245,28 @@ static void __devinit init_hwif_hpt366(i
 		 * - set bit 15 of reg 0x52 to enable TCBLID as input
 		 * - set bit 15 of reg 0x56 to enable FCBLID as input
 		 */
-		u16 mcr3, mcr6;
-		pci_read_config_word(dev, 0x52, &mcr3);
-		pci_read_config_word(dev, 0x56, &mcr6);
-		pci_write_config_word(dev, 0x52, mcr3 | 0x8000);
-		pci_write_config_word(dev, 0x56, mcr6 | 0x8000);
+		u8  mcr_addr = hwif->select_data + 2;
+		u16 mcr;
+
+		pci_read_config_word (dev, mcr_addr, &mcr);
+		pci_write_config_word(dev, mcr_addr, (mcr | 0x8000));
 		/* now read cable id register */
-		pci_read_config_byte(dev, 0x5a, &ata66);
-		pci_write_config_word(dev, 0x52, mcr3);
-		pci_write_config_word(dev, 0x56, mcr6);
+		pci_read_config_byte (dev, 0x5a, &scr1);
+		pci_write_config_word(dev, mcr_addr, mcr);
 	} else if (info->revision >= 3) {
 		/*
 		 * HPT370/372 and 374 pcifn 0
-		 * - clear bit 0 of 0x5b to enable P/SCBLID as inputs
+		 * - clear bit 0 of reg 0x5b to enable P/SCBLID as inputs
 		 */
-		u8 scr2;
-		pci_read_config_byte(dev, 0x5b, &scr2);
-		pci_write_config_byte(dev, 0x5b, scr2 & ~1);
-		/* now read cable id register */
-		pci_read_config_byte(dev, 0x5a, &ata66);
-		pci_write_config_byte(dev, 0x5b, scr2);
-	} else {
-		pci_read_config_byte(dev, 0x5a, &ata66);
-	}
+		u8 scr2 = 0;
 
-#ifdef DEBUG
-	printk("HPT366: reg5ah=0x%02x ATA-%s Cable Port%d\n",
-		ata66, (ata66 & regmask) ? "33" : "66",
-		PCI_FUNC(hwif->pci_dev->devfn));
-#endif /* DEBUG */
+		pci_read_config_byte (dev, 0x5b, &scr2);
+		pci_write_config_byte(dev, 0x5b, (scr2 & ~1));
+		/* now read cable id register */
+		pci_read_config_byte (dev, 0x5a, &scr1);
+		pci_write_config_byte(dev, 0x5b,  scr2);
+	} else
+		pci_read_config_byte (dev, 0x5a, &scr1);
 
 	/* Serialize access to this device */
 	if (serialize && hwif->mate)
@@ -1296,7 +1288,7 @@ static void __devinit init_hwif_hpt366(i
 	hwif->mwdma_mask = 0x07;
 
 	if (!(hwif->udma_four))
-		hwif->udma_four = ((ata66 & regmask) ? 0 : 1);
+		hwif->udma_four = ((scr1 & ata66) ? 0 : 1);
 	hwif->ide_dma_check = &hpt366_config_drive_xfer_rate;
 
 	if (info->revision >= 8) {
@@ -1323,11 +1315,10 @@ static void __devinit init_hwif_hpt366(i
 
 static void __devinit init_dma_hpt366(ide_hwif_t *hwif, unsigned long dmabase)
 {
-	struct hpt_info	*info	= ide_get_hwifdata(hwif);
-	u8 masterdma	= 0, slavedma = 0;
-	u8 dma_new	= 0, dma_old = 0;
-	u8 primary	= hwif->channel ? 0x4b : 0x43;
-	u8 secondary	= hwif->channel ? 0x4f : 0x47;
+	struct pci_dev  *dev		= hwif->pci_dev;
+	struct hpt_info	*info		= ide_get_hwifdata(hwif);
+	u8 masterdma	= 0, slavedma	= 0;
+	u8 dma_new	= 0, dma_old	= 0;
 	unsigned long flags;
 
 	if (!dmabase)
@@ -1344,13 +1335,13 @@ static void __devinit init_dma_hpt366(id
 	local_irq_save(flags);
 
 	dma_new = dma_old;
-	pci_read_config_byte(hwif->pci_dev, primary, &masterdma);
-	pci_read_config_byte(hwif->pci_dev, secondary, &slavedma);
+	pci_read_config_byte(dev, hwif->channel ? 0x4b : 0x43, &masterdma);
+	pci_read_config_byte(dev, hwif->channel ? 0x4f : 0x47,  &slavedma);
 
 	if (masterdma & 0x30)	dma_new |= 0x20;
-	if (slavedma & 0x30)	dma_new |= 0x40;
+	if ( slavedma & 0x30)	dma_new |= 0x40;
 	if (dma_new != dma_old)
-		hwif->OUTB(dma_new, dmabase+2);
+		hwif->OUTB(dma_new, dmabase + 2);
 
 	local_irq_restore(flags);
 



--------------090902050600020407080707--
