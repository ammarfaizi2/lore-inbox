Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbUCBUwT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 15:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbUCBUwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 15:52:10 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:7573 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261763AbUCBUud
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 15:50:33 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
Subject: [PATCH] update for pdc202xx_new driver
Date: Tue, 2 Mar 2004 21:57:38 +0100
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403022157.38433.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Many thanks to Promise for their support.
Expect more updates/fixes for Promise PATA soon.

Bartlomiej

[IDE] update for pdc202xx_new driver

- fix PIO (auto-)tuning - use pdcnew_new_tune_chipset()
  and always tune PIO mode even if (U)DMA is used
- cleanup cable verification code a bit
- remove leftovers from driver split-up
- remove duplicate DISPLAY_PDC202XX_TIMINGS define

 linux-2.6.4-rc1-root/drivers/ide/pci/pdc202xx_new.c |  165 --------------------
 linux-2.6.4-rc1-root/drivers/ide/pci/pdc202xx_new.h |  119 --------------
 2 files changed, 7 insertions(+), 277 deletions(-)

diff -puN drivers/ide/pci/pdc202xx_new.c~pdc27x_update drivers/ide/pci/pdc202xx_new.c
--- linux-2.6.4-rc1/drivers/ide/pci/pdc202xx_new.c~pdc27x_update	2004-03-02 21:14:04.000000000 +0100
+++ linux-2.6.4-rc1-root/drivers/ide/pci/pdc202xx_new.c	2004-03-02 21:14:04.000000000 +0100
@@ -140,108 +140,6 @@ static int check_in_drive_lists (ide_dri
 	return 0;
 }
 
-static int pdcnew_tune_chipset (ide_drive_t *drive, u8 xferspeed)
-{
-	ide_hwif_t *hwif	= HWIF(drive);
-	struct pci_dev *dev	= hwif->pci_dev;
-	u8 drive_pci		= 0x60 + (drive->dn << 2);
-	u8 speed	= ide_rate_filter(pdcnew_ratemask(drive), xferspeed);
-
-	u32			drive_conf;
-	u8			AP, BP, CP, DP;
-	u8			TA = 0, TB = 0, TC = 0;
-
-	if ((drive->media != ide_disk) && (speed < XFER_SW_DMA_0))
-		return -1;
-
-	pci_read_config_dword(dev, drive_pci, &drive_conf);
-	pci_read_config_byte(dev, (drive_pci), &AP);
-	pci_read_config_byte(dev, (drive_pci)|0x01, &BP);
-	pci_read_config_byte(dev, (drive_pci)|0x02, &CP);
-	pci_read_config_byte(dev, (drive_pci)|0x03, &DP);
-
-	if (speed < XFER_SW_DMA_0) {
-		if ((AP & 0x0F) || (BP & 0x07)) {
-			/* clear PIO modes of lower 8421 bits of A Register */
-			pci_write_config_byte(dev, (drive_pci), AP &~0x0F);
-			pci_read_config_byte(dev, (drive_pci), &AP);
-
-			/* clear PIO modes of lower 421 bits of B Register */
-			pci_write_config_byte(dev, (drive_pci)|0x01, BP &~0x07);
-			pci_read_config_byte(dev, (drive_pci)|0x01, &BP);
-
-			pci_read_config_byte(dev, (drive_pci), &AP);
-			pci_read_config_byte(dev, (drive_pci)|0x01, &BP);
-		}
-	} else {
-		if ((BP & 0xF0) && (CP & 0x0F)) {
-			/* clear DMA modes of upper 842 bits of B Register */
-			/* clear PIO forced mode upper 1 bit of B Register */
-			pci_write_config_byte(dev, (drive_pci)|0x01, BP &~0xF0);
-			pci_read_config_byte(dev, (drive_pci)|0x01, &BP);
-
-			/* clear DMA modes of lower 8421 bits of C Register */
-			pci_write_config_byte(dev, (drive_pci)|0x02, CP &~0x0F);
-			pci_read_config_byte(dev, (drive_pci)|0x02, &CP);
-		}
-	}
-
-	pci_read_config_byte(dev, (drive_pci), &AP);
-	pci_read_config_byte(dev, (drive_pci)|0x01, &BP);
-	pci_read_config_byte(dev, (drive_pci)|0x02, &CP);
-
-	switch(speed) {
-		case XFER_UDMA_6:	speed = XFER_UDMA_5;
-		case XFER_UDMA_5:
-		case XFER_UDMA_4:	TB = 0x20; TC = 0x01; break;
-		case XFER_UDMA_2:	TB = 0x20; TC = 0x01; break;
-		case XFER_UDMA_3:
-		case XFER_UDMA_1:	TB = 0x40; TC = 0x02; break;
-		case XFER_UDMA_0:
-		case XFER_MW_DMA_2:	TB = 0x60; TC = 0x03; break;
-		case XFER_MW_DMA_1:	TB = 0x60; TC = 0x04; break;
-		case XFER_MW_DMA_0:
-		case XFER_SW_DMA_2:	TB = 0x60; TC = 0x05; break;
-		case XFER_SW_DMA_1:	TB = 0x80; TC = 0x06; break;
-		case XFER_SW_DMA_0:	TB = 0xC0; TC = 0x0B; break;
-		case XFER_PIO_4:	TA = 0x01; TB = 0x04; break;
-		case XFER_PIO_3:	TA = 0x02; TB = 0x06; break;
-		case XFER_PIO_2:	TA = 0x03; TB = 0x08; break;
-		case XFER_PIO_1:	TA = 0x05; TB = 0x0C; break;
-		case XFER_PIO_0:
-		default:		TA = 0x09; TB = 0x13; break;
-	}
-
-	if (speed < XFER_SW_DMA_0) {
-		pci_write_config_byte(dev, (drive_pci), AP|TA);
-		pci_write_config_byte(dev, (drive_pci)|0x01, BP|TB);
-	} else {
-		pci_write_config_byte(dev, (drive_pci)|0x01, BP|TB);
-		pci_write_config_byte(dev, (drive_pci)|0x02, CP|TC);
-	}
-
-#if PDC202XX_DECODE_REGISTER_INFO
-	pci_read_config_byte(dev, (drive_pci), &AP);
-	pci_read_config_byte(dev, (drive_pci)|0x01, &BP);
-	pci_read_config_byte(dev, (drive_pci)|0x02, &CP);
-	pci_read_config_byte(dev, (drive_pci)|0x03, &DP);
-
-	decode_registers(REG_A, AP);
-	decode_registers(REG_B, BP);
-	decode_registers(REG_C, CP);
-	decode_registers(REG_D, DP);
-#endif /* PDC202XX_DECODE_REGISTER_INFO */
-#if PDC202XX_DEBUG_DRIVE_INFO
-	printk(KERN_DEBUG "%s: %s drive%d 0x%08x ",
-		drive->name, ide_xfer_verbose(speed),
-		drive->dn, drive_conf);
-		pci_read_config_dword(dev, drive_pci, &drive_conf);
-	printk("0x%08x\n", drive_conf);
-#endif /* PDC202XX_DEBUG_DRIVE_INFO */
-
-	return (ide_config_drive_speed(drive, speed));
-}
-
 static int pdcnew_new_tune_chipset (ide_drive_t *drive, u8 xferspeed)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
@@ -288,19 +186,14 @@ static int pdcnew_new_tune_chipset (ide_
  * 180, 120,  90,  90,  90,  60,  30
  *  11,   5,   4,   3,   2,   1,   0
  */
-static int config_chipset_for_pio (ide_drive_t *drive, u8 pio)
+static void pdcnew_tune_drive(ide_drive_t *drive, u8 pio)
 {
-	u8 speed = 0;
+	u8 speed;
 
 	if (pio == 5) pio = 4;
 	speed = XFER_PIO_0 + ide_get_best_pio_mode(drive, 255, pio, NULL);
-        
-	return ((int) pdcnew_tune_chipset(drive, speed));
-}
 
-static void pdcnew_tune_drive (ide_drive_t *drive, u8 pio)
-{
-	(void) config_chipset_for_pio(drive, pio);
+	(void)pdcnew_new_tune_chipset(drive, speed);
 }
 
 static u8 pdcnew_new_cable_detect (ide_hwif_t *hwif)
@@ -312,56 +205,15 @@ static int config_chipset_for_dma (ide_d
 {
 	struct hd_driveid *id	= drive->id;
 	ide_hwif_t *hwif	= HWIF(drive);
-	struct pci_dev *dev	= hwif->pci_dev;
 	u8 speed		= -1;
-	u8 cable		= 0;
+	u8 cable;
 
 	u8 ultra_66		= ((id->dma_ultra & 0x0010) ||
 				   (id->dma_ultra & 0x0008)) ? 1 : 0;
 
-	switch(dev->device) {
-		case PCI_DEVICE_ID_PROMISE_20277:
-		case PCI_DEVICE_ID_PROMISE_20276:
-		case PCI_DEVICE_ID_PROMISE_20275:
-		case PCI_DEVICE_ID_PROMISE_20271:
-		case PCI_DEVICE_ID_PROMISE_20269:
-		case PCI_DEVICE_ID_PROMISE_20270:
-		case PCI_DEVICE_ID_PROMISE_20268:
-			cable = pdcnew_new_cable_detect(hwif);
-#if PDC202_DEBUG_CABLE
-			printk(KERN_DEBUG "%s: %s-pin cable, %s-pin cable, %d\n",
-				hwif->name, hwif->udma_four ? "80" : "40",
-				cable ? "40" : "80", cable);
-#endif /* PDC202_DEBUG_CABLE */
-			break;
-		default:
-			/* If it's not one we know we should never
-			   arrive here.. */
-			BUG();
-	}
+	cable = pdcnew_new_cable_detect(hwif);
 
-	/*
-	 * Set the control register to use the 66Mhz system
-	 * clock for UDMA 3/4 mode operation. If one drive on
-	 * a channel is U66 capable but the other isn't we
-	 * fall back to U33 mode. The BIOS INT 13 hooks turn
-	 * the clock on then off for each read/write issued. I don't
-	 * do that here because it would require modifying the
-	 * kernel, separating the fop routines from the kernel or
-	 * somehow hooking the fops calls. It may also be possible to
-	 * leave the 66Mhz clock on and readjust the timing
-	 * parameters.
-	 */
-
-	if ((ultra_66) && (cable)) {
-#ifdef DEBUG
-		printk(KERN_DEBUG "ULTRA 66/100/133: %s channel of Ultra 66/100/133 "
-			"requires an 80-pin cable for Ultra66 operation.\n",
-			hwif->channel ? "Secondary" : "Primary");
-		printk(KERN_DEBUG "         Switching to Ultra33 mode.\n");
-#endif /* DEBUG */
-		/* Primary   : zero out second bit */
-		/* Secondary : zero out fourth bit */
+	if (ultra_66 && cable) {
 		printk(KERN_WARNING "Warning: %s channel requires an 80-pin cable for operation.\n", hwif->channel ? "Secondary":"Primary");
 		printk(KERN_WARNING "%s reduced to Ultra33 mode.\n", drive->name);
 	}
@@ -590,10 +442,7 @@ static void __init init_hwif_pdc202new (
 	hwif->speedproc = &pdcnew_new_tune_chipset;
 	hwif->resetproc = &pdcnew_new_reset;
 
-	if (!hwif->dma_base) {
-		hwif->drives[0].autotune = hwif->drives[1].autotune = 1;
-		return;
-	}
+	hwif->drives[0].autotune = hwif->drives[1].autotune = 1;
 
 	hwif->ultra_mask = 0x7f;
 	hwif->mwdma_mask = 0x07;
diff -puN drivers/ide/pci/pdc202xx_new.h~pdc27x_update drivers/ide/pci/pdc202xx_new.h
--- linux-2.6.4-rc1/drivers/ide/pci/pdc202xx_new.h~pdc27x_update	2004-03-02 21:14:04.000000000 +0100
+++ linux-2.6.4-rc1-root/drivers/ide/pci/pdc202xx_new.h	2004-03-02 21:14:04.000000000 +0100
@@ -5,15 +5,6 @@
 #include <linux/pci.h>
 #include <linux/ide.h>
 
-#define DISPLAY_PDC202XX_TIMINGS
-
-#ifndef SPLIT_BYTE
-#define SPLIT_BYTE(B,H,L)	((H)=(B>>4), (L)=(B-((B>>4)<<4)))
-#endif
-
-#define PDC202XX_DEBUG_DRIVE_INFO		0
-#define PDC202XX_DECODE_REGISTER_INFO		0
-
 const static char *pdc_quirk_drives[] = {
 	"QUANTUM FIREBALLlct08 08",
 	"QUANTUM FIREBALLP KA6.4",
@@ -26,116 +17,6 @@ const static char *pdc_quirk_drives[] = 
 	NULL
 };
 
-/* A Register */
-#define	SYNC_ERRDY_EN	0xC0
-
-#define	SYNC_IN		0x80	/* control bit, different for master vs. slave drives */
-#define	ERRDY_EN	0x40	/* control bit, different for master vs. slave drives */
-#define	IORDY_EN	0x20	/* PIO: IOREADY */
-#define	PREFETCH_EN	0x10	/* PIO: PREFETCH */
-
-#define	PA3		0x08	/* PIO"A" timing */
-#define	PA2		0x04	/* PIO"A" timing */
-#define	PA1		0x02	/* PIO"A" timing */
-#define	PA0		0x01	/* PIO"A" timing */
-
-/* B Register */
-
-#define	MB2		0x80	/* DMA"B" timing */
-#define	MB1		0x40	/* DMA"B" timing */
-#define	MB0		0x20	/* DMA"B" timing */
-
-#define	PB4		0x10	/* PIO_FORCE 1:0 */
-
-#define	PB3		0x08	/* PIO"B" timing */	/* PIO flow Control mode */
-#define	PB2		0x04	/* PIO"B" timing */	/* PIO 4 */
-#define	PB1		0x02	/* PIO"B" timing */	/* PIO 3 half */
-#define	PB0		0x01	/* PIO"B" timing */	/* PIO 3 other half */
-
-/* C Register */
-#define	IORDYp_NO_SPEED	0x4F
-#define	SPEED_DIS	0x0F
-
-#define	DMARQp		0x80
-#define	IORDYp		0x40
-#define	DMAR_EN		0x20
-#define	DMAW_EN		0x10
-
-#define	MC3		0x08	/* DMA"C" timing */
-#define	MC2		0x04	/* DMA"C" timing */
-#define	MC1		0x02	/* DMA"C" timing */
-#define	MC0		0x01	/* DMA"C" timing */
-
-#if PDC202XX_DECODE_REGISTER_INFO
-
-#define REG_A		0x01
-#define REG_B		0x02
-#define REG_C		0x04
-#define REG_D		0x08
-
-static void decode_registers (u8 registers, u8 value)
-{
-	u8	bit = 0, bit1 = 0, bit2 = 0;
-
-	switch(registers) {
-		case REG_A:
-			bit2 = 0;
-			printk("A Register ");
-			if (value & 0x80) printk("SYNC_IN ");
-			if (value & 0x40) printk("ERRDY_EN ");
-			if (value & 0x20) printk("IORDY_EN ");
-			if (value & 0x10) printk("PREFETCH_EN ");
-			if (value & 0x08) { printk("PA3 ");bit2 |= 0x08; }
-			if (value & 0x04) { printk("PA2 ");bit2 |= 0x04; }
-			if (value & 0x02) { printk("PA1 ");bit2 |= 0x02; }
-			if (value & 0x01) { printk("PA0 ");bit2 |= 0x01; }
-			printk("PIO(A) = %d ", bit2);
-			break;
-		case REG_B:
-			bit1 = 0;bit2 = 0;
-			printk("B Register ");
-			if (value & 0x80) { printk("MB2 ");bit1 |= 0x80; }
-			if (value & 0x40) { printk("MB1 ");bit1 |= 0x40; }
-			if (value & 0x20) { printk("MB0 ");bit1 |= 0x20; }
-			printk("DMA(B) = %d ", bit1 >> 5);
-			if (value & 0x10) printk("PIO_FORCED/PB4 ");
-			if (value & 0x08) { printk("PB3 ");bit2 |= 0x08; }
-			if (value & 0x04) { printk("PB2 ");bit2 |= 0x04; }
-			if (value & 0x02) { printk("PB1 ");bit2 |= 0x02; }
-			if (value & 0x01) { printk("PB0 ");bit2 |= 0x01; }
-			printk("PIO(B) = %d ", bit2);
-			break;
-		case REG_C:
-			bit2 = 0;
-			printk("C Register ");
-			if (value & 0x80) printk("DMARQp ");
-			if (value & 0x40) printk("IORDYp ");
-			if (value & 0x20) printk("DMAR_EN ");
-			if (value & 0x10) printk("DMAW_EN ");
-
-			if (value & 0x08) { printk("MC3 ");bit2 |= 0x08; }
-			if (value & 0x04) { printk("MC2 ");bit2 |= 0x04; }
-			if (value & 0x02) { printk("MC1 ");bit2 |= 0x02; }
-			if (value & 0x01) { printk("MC0 ");bit2 |= 0x01; }
-			printk("DMA(C) = %d ", bit2);
-			break;
-		case REG_D:
-			printk("D Register ");
-			break;
-		default:
-			return;
-	}
-	printk("\n        %s ", (registers & REG_D) ? "DP" :
-				(registers & REG_C) ? "CP" :
-				(registers & REG_B) ? "BP" :
-				(registers & REG_A) ? "AP" : "ERROR");
-	for (bit=128;bit>0;bit/=2)
-		printk("%s", (value & bit) ? "1" : "0");
-	printk("\n");
-}
-
-#endif /* PDC202XX_DECODE_REGISTER_INFO */
-
 #define set_2regs(a, b)					\
 	do {						\
 		hwif->OUTB((a + adj), indexreg);	\

_

