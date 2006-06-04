Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932295AbWFDWZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbWFDWZa (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 18:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbWFDWZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 18:25:30 -0400
Received: from rtsoft2.corbina.net ([85.21.88.2]:30350 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S932295AbWFDWZ3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 18:25:29 -0400
Message-ID: <44835D98.3070609@ru.mvista.com>
Date: Mon, 05 Jun 2006 02:24:24 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] HPT3x7: merge speedproc handlers
References: <444B3BDE.1030106@ru.mvista.com> <4457DC97.3010807@ru.mvista.com> <445A5A1B.60903@ru.mvista.com> <446A55D6.90507@ru.mvista.com> <446ED8A3.6030702@ru.mvista.com> <4478CD3D.6010409@ru.mvista.com> <4478E104.7040200@ru.mvista.com> <4479112D.8070501@ru.mvista.com>
In-Reply-To: <4479112D.8070501@ru.mvista.com>
Content-Type: multipart/mixed;
 boundary="------------000100010004040400060705"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000100010004040400060705
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Continue with the driver rewrite:

- move the interrupt twiddling code from the speedproc handlers into the
    init_hwif_hpt366 which allows to merge the two HPT37x speedproc handlers
    into one;

- get rid of in init_hpt366 which solely consists of the duplicate code, then
    fold init_hpt37x() into init_chipset_hpt366();

- fix hpt3xx_tune_drive() to always set the PIO mode requested, not the best
    possible one, change hpt366_config_drive_xfer_rate() accordingly, simplify
    it a bit;

- group all the DMA related code together init_hwif_hpt366(), and generally
    clean up and beautify it.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>


--------------000100010004040400060705
Content-Type: text/plain;
 name="HPT37x-merge-speedproc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="HPT37x-merge-speedproc.patch"

Index: linux-2.6/drivers/ide/pci/hpt366.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/hpt366.c
+++ linux-2.6/drivers/ide/pci/hpt366.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/hpt366.c		Version 0.50	May 28, 2006
+ * linux/drivers/ide/pci/hpt366.c		Version 0.51	Jun 04, 2006
  *
  * Copyright (C) 1999-2003		Andre Hedrick <andre@linux-ide.org>
  * Portions Copyright (C) 2001	        Sun Microsystems, Inc.
@@ -83,13 +83,17 @@
  * - cache the channel's MCRs' offset; only touch the relevant MCR when detecting
  *   the cable type on HPT374's function 1
  * - rename all the register related variables consistently
- * - make HPT36x's speedproc handler look the same way as HPT37x ones; fix the
- *   PIO timing register mask for HPT37x
+ * - move the interrupt twiddling code from the speedproc handlers into the
+ *   init_hwif handler, also grouping all the DMA related code together there;
+ *   simplify  the init_chipset handler
+ * - merge two HPT37x speedproc handlers and fix the PIO timing register mask
+ *   there; make HPT36x speedproc handler look the same way as the HPT37x one
+ * - fix  the tuneproc handler to always set the PIO mode requested,  not the
+ *   best possible one
  *		<source@mvista.com>
  *
  */
 
-
 #include <linux/config.h>
 #include <linux/types.h>
 #include <linux/module.h>
@@ -503,19 +507,9 @@ static int hpt36x_tune_chipset(ide_drive
 	struct hpt_info	*info	= ide_get_hwifdata (hwif);
 	u8  speed		= hpt3xx_ratefilter(drive, xferspeed);
 	u8  itr_addr		= drive->dn ? 0x44 : 0x40;
-	u8  mcr_addr		= hwif->select_data + 1;
-	u8  mcr			= 0;
-	u32 new_itr, old_itr	= 0;
 	u32 itr_mask		= (speed < XFER_MW_DMA_0) ? 0x30070000 : 0xc0000000;
-
-	/*
-	 * Disable the "fast interrupt" prediction.
-	 */
-	pci_read_config_byte(dev, mcr_addr, &mcr);
-	if (mcr & 0x80)
-		pci_write_config_byte(dev, mcr_addr, mcr & ~0x80);
-
-	new_itr = pci_bus_clock_list(speed, info->speed);
+	u32 new_itr		= pci_bus_clock_list(speed, info->speed);
+	u32 old_itr		= 0;
 
 	/*
 	 * Disable on-chip PIO FIFO/buffer (and PIO MST mode as well)
@@ -530,38 +524,16 @@ static int hpt36x_tune_chipset(ide_drive
 	return ide_config_drive_speed(drive, speed);
 }
 
-static int hpt370_tune_chipset(ide_drive_t *drive, u8 xferspeed)
+static int hpt37x_tune_chipset(ide_drive_t *drive, u8 xferspeed)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev  *dev	= hwif->pci_dev;
 	struct hpt_info	*info	= ide_get_hwifdata (hwif);
 	u8  speed		= hpt3xx_ratefilter(drive, xferspeed);
-	u8  mcr_addr		= hwif->select_data + 1;
 	u8  itr_addr		= 0x40 + (drive->dn * 4);
-	u8  new_mcr		= 0, old_mcr = 0;
-	u32 new_itr, old_itr	= 0;
 	u32 itr_mask		= (speed < XFER_MW_DMA_0) ? 0x303c0000 : 0xc0000000;
-
-	/*
-	 * Disable the "fast interrupt" prediction.
-	 * don't holdoff on interrupts. (== 0x01 despite what the docs say) 
-	 */
-	pci_read_config_byte(dev, mcr_addr, &old_mcr);
-	new_mcr = old_mcr;
-	if (new_mcr & 0x02)
-		new_mcr &= ~0x02;
-
-#ifdef HPT_DELAY_INTERRUPT
-	if (new_mcr & 0x01)
-		new_mcr &= ~0x01;
-#else
-	if ((new_mcr & 0x01) == 0)
-		new_mcr |= 0x01;
-#endif
-	if (new_mcr != old_mcr)
-		pci_write_config_byte(dev, mcr_addr, new_mcr);
-
-	new_itr = pci_bus_clock_list(speed, info->speed);
+	u32 new_itr		= pci_bus_clock_list(speed, info->speed);
+	u32 old_itr		= 0;
 
 	pci_read_config_dword(dev, itr_addr, &old_itr);
 	new_itr = (new_itr & ~itr_mask) | (old_itr & itr_mask);
@@ -573,71 +545,34 @@ static int hpt370_tune_chipset(ide_drive
 	return ide_config_drive_speed(drive, speed);
 }
 
-static int hpt372_tune_chipset(ide_drive_t *drive, u8 xferspeed)
+static int hpt3xx_tune_chipset(ide_drive_t *drive, u8 speed)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
-	struct pci_dev  *dev	= hwif->pci_dev;
-	struct hpt_info	*info	= ide_get_hwifdata (hwif);
-	u8  speed		= hpt3xx_ratefilter(drive, xferspeed);
-	u8  mcr_addr		= hwif->select_data + 1;
-	u8  itr_addr		= 0x40 + (drive->dn * 4);
-	u8  mcr			= 0;
-	u32 new_itr, old_itr	= 0;
-	u32 itr_mask		= (speed < XFER_MW_DMA_0) ? 0x303c0000 : 0xc0000000;
-
-	/*
-	 * Disable the "fast interrupt" prediction.
-	 * don't holdoff on interrupts. (== 0x01 despite what the docs say)
-	 */
-	pci_read_config_byte (dev, mcr_addr, &mcr);
-	pci_write_config_byte(dev, mcr_addr, (mcr & ~0x07));
-
-	new_itr = pci_bus_clock_list(speed, info->speed);
-	pci_read_config_dword(dev, itr_addr, &old_itr);
-	new_itr = (new_itr & ~itr_mask) | (old_itr & itr_mask);
-	if (speed < XFER_MW_DMA_0)
-		new_itr &= ~0x80000000; /* Disable on-chip PIO FIFO/buffer */
-	pci_write_config_dword(dev, itr_addr, new_itr);
-
-	return ide_config_drive_speed(drive, speed);
-}
-
-static int hpt3xx_tune_chipset (ide_drive_t *drive, u8 speed)
-{
-	ide_hwif_t *hwif	= drive->hwif;
 	struct hpt_info	*info	= ide_get_hwifdata(hwif);
 
-	if (info->revision >= 8)
-		return hpt372_tune_chipset(drive, speed); /* not a typo */
-	else if (info->revision >= 5)
-		return hpt372_tune_chipset(drive, speed);
-	else if (info->revision >= 3)
-		return hpt370_tune_chipset(drive, speed);
+	if (info->revision >= 3)
+		return hpt37x_tune_chipset(drive, speed);
 	else	/* hpt368: hpt_minimum_revision(dev, 2) */
 		return hpt36x_tune_chipset(drive, speed);
 }
 
-static void hpt3xx_tune_drive (ide_drive_t *drive, u8 pio)
+static void hpt3xx_tune_drive(ide_drive_t *drive, u8 pio)
 {
-	pio = ide_get_best_pio_mode(drive, 255, pio, NULL);
-	(void) hpt3xx_tune_chipset(drive, (XFER_PIO_0 + pio));
+	pio = ide_get_best_pio_mode(drive, pio, 4, NULL);
+	(void) hpt3xx_tune_chipset (drive, XFER_PIO_0 + pio);
 }
 
 /*
  * This allows the configuration of ide_pci chipset registers
  * for cards that learn about the drive's UDMA, DMA, PIO capabilities
- * after the drive is reported by the OS.  Initially for designed for
+ * after the drive is reported by the OS.  Initially designed for
  * HPT366 UDMA chipset by HighPoint|Triones Technologies, Inc.
  *
- * check_in_drive_lists(drive, bad_ata66_4)
- * check_in_drive_lists(drive, bad_ata66_3)
- * check_in_drive_lists(drive, bad_ata33)
- *
  */
-static int config_chipset_for_dma (ide_drive_t *drive)
+static int config_chipset_for_dma(ide_drive_t *drive)
 {
 	u8 speed = ide_dma_speed(drive, hpt3xx_ratemask(drive));
-	ide_hwif_t *hwif = drive->hwif;
+	ide_hwif_t *hwif	= HWIF(drive);
 	struct hpt_info	*info	= ide_get_hwifdata(hwif);
 
 	if (!speed)
@@ -662,7 +597,7 @@ static int hpt3xx_quirkproc(ide_drive_t 
 	return 0;
 }
 
-static void hpt3xx_intrproc (ide_drive_t *drive)
+static void hpt3xx_intrproc(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = HWIF(drive);
 
@@ -672,7 +607,7 @@ static void hpt3xx_intrproc (ide_drive_t
 	hwif->OUTB(drive->ctl | 2, IDE_CONTROL_REG);
 }
 
-static void hpt3xx_maskproc (ide_drive_t *drive, int mask)
+static void hpt3xx_maskproc(ide_drive_t *drive, int mask)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev	*dev	= hwif->pci_dev;
@@ -701,25 +636,22 @@ static void hpt3xx_maskproc (ide_drive_t
 			   IDE_CONTROL_REG);
 }
 
-static int hpt366_config_drive_xfer_rate (ide_drive_t *drive)
+static int hpt366_config_drive_xfer_rate(ide_drive_t *drive)
 {
-	ide_hwif_t *hwif	= drive->hwif;
+	ide_hwif_t *hwif	= HWIF(drive);
 	struct hd_driveid *id	= drive->id;
 
 	drive->init_speed = 0;
 
 	if ((id->capability & 1) && drive->autodma) {
-
-		if (ide_use_dma(drive)) {
-			if (config_chipset_for_dma(drive))
-				return hwif->ide_dma_on(drive);
-		}
+		if (ide_use_dma(drive) && config_chipset_for_dma(drive))
+			return hwif->ide_dma_on(drive);
 
 		goto fast_ata_pio;
 
 	} else if ((id->capability & 8) || (id->field_valid & 2)) {
 fast_ata_pio:
-		hpt3xx_tune_drive(drive, 5);
+		hpt3xx_tune_drive(drive, 255);
 		return hwif->ide_dma_off_quietly(drive);
 	}
 	/* IORDY not supported */
@@ -1150,34 +1082,8 @@ init_hpt37X_done:
 	udelay(100);
 }
 
-static int __devinit init_hpt37x(struct pci_dev *dev)
-{
-	u8 scr1;
-
-	pci_read_config_byte (dev, 0x5a, &scr1);
-	/* interrupt force enable */
-	pci_write_config_byte(dev, 0x5a, (scr1 & ~0x10));
-	return 0;
-}
-
-static int __devinit init_hpt366(struct pci_dev *dev)
-{
-	u8 mcr	= 0;
-
-	/*
-	 * Disable the "fast interrupt" prediction.
-	 */
-	pci_read_config_byte(dev, 0x51, &mcr);
-	if (mcr & 0x80)
-		pci_write_config_byte(dev, 0x51, mcr & ~0x80);
-									
-	return 0;
-}
-
 static unsigned int __devinit init_chipset_hpt366(struct pci_dev *dev, const char *name)
 {
-	int ret = 0;
-
 	/*
 	 * FIXME: Not portable. Also, why do we enable the ROM in the first place?
 	 * We don't seem to be using it.
@@ -1191,23 +1097,25 @@ static unsigned int __devinit init_chips
 	pci_write_config_byte(dev, PCI_MIN_GNT, 0x08);
 	pci_write_config_byte(dev, PCI_MAX_LAT, 0x08);
 
-	if (hpt_revision(dev) >= 3)
-		ret = init_hpt37x(dev);
-	else
-		ret = init_hpt366(dev);
+	if (hpt_revision(dev) >= 3) {
+		u8 scr1 = 0;
 
-	if (ret)
-		return ret;
+		/* Interrupt force enable. */
+		pci_read_config_byte(dev, 0x5a, &scr1);
+		if (scr1 & 0x10)
+			pci_write_config_byte(dev, 0x5a, scr1 & ~0x10);
+	}
 
 	return dev->irq;
 }
 
 static void __devinit init_hwif_hpt366(ide_hwif_t *hwif)
 {
-	struct pci_dev  *dev		= hwif->pci_dev;
+	struct pci_dev	*dev		= hwif->pci_dev;
 	struct hpt_info *info		= ide_get_hwifdata(hwif);
 	int serialize			= HPT_SERIALIZE_IO;
 	u8  scr1 = 0, ata66		= (hwif->channel) ? 0x01 : 0x02;
+	u8  new_mcr, old_mcr 		= 0;
 
 	/* Cache the channel's MISC. control registers' offset */
 	hwif->select_data		= hwif->channel ? 0x54 : 0x50;
@@ -1234,6 +1142,41 @@ static void __devinit init_hwif_hpt366(i
 		hwif->rw_disk = &hpt3xxn_rw_disk;
 	}
 
+	/* Serialize access to this device if needed */
+	if (serialize && hwif->mate)
+		hwif->serialized = hwif->mate->serialized = 1;
+
+	/*
+	 * Disable the "fast interrupt" prediction.  Don't hold off
+	 * on interrupts. (== 0x01 despite what the docs say)
+	 */
+	pci_read_config_byte(dev, hwif->select_data + 1, &old_mcr);
+
+	if (info->revision >= 5)		/* HPT372 and newer   */
+		new_mcr = old_mcr & ~0x07;
+	else if (info->revision >= 3) {		/* HPT370 and HPT370A */
+		new_mcr = old_mcr;
+		new_mcr &= ~0x02;
+
+#ifdef HPT_DELAY_INTERRUPT
+		new_mcr &= ~0x01;
+#else
+		new_mcr |=  0x01;
+#endif
+	} else					/* HPT366 and HPT368  */
+		new_mcr = old_mcr & ~0x80;
+
+	if (new_mcr != old_mcr)
+		pci_write_config_byte(dev, hwif->select_data + 1, new_mcr);
+
+	if (!hwif->dma_base) {
+		hwif->drives[0].autotune = hwif->drives[1].autotune = 1;
+		return;
+	}
+
+	hwif->ultra_mask = 0x7f;
+	hwif->mwdma_mask = 0x07;
+
 	/*
 	 * The HPT37x uses the CBLID pins as outputs for MA15/MA16
 	 * address lines to access an external EEPROM.  To read valid
@@ -1268,54 +1211,30 @@ static void __devinit init_hwif_hpt366(i
 	} else
 		pci_read_config_byte (dev, 0x5a, &scr1);
 
-	/* Serialize access to this device */
-	if (serialize && hwif->mate)
-		hwif->serialized = hwif->mate->serialized = 1;
+	if (!hwif->udma_four)
+		hwif->udma_four = (scr1 & ata66) ? 0 : 1;
 
-	/*
-	 * Set up ioctl for power status.
-	 * NOTE:  power affects both drives on each channel.
-	 */
-	hwif->busproc = &hpt3xx_busproc;
-
-	if (!hwif->dma_base) {
-		hwif->drives[0].autotune = 1;
-		hwif->drives[1].autotune = 1;
-		return;
-	}
+	hwif->ide_dma_check		= &hpt366_config_drive_xfer_rate;
 
-	hwif->ultra_mask = 0x7f;
-	hwif->mwdma_mask = 0x07;
-
-	if (!(hwif->udma_four))
-		hwif->udma_four = ((scr1 & ata66) ? 0 : 1);
-	hwif->ide_dma_check = &hpt366_config_drive_xfer_rate;
-
-	if (info->revision >= 8) {
-		hwif->ide_dma_test_irq = &hpt374_ide_dma_test_irq;
-		hwif->ide_dma_end = &hpt374_ide_dma_end;
-	} else if (info->revision >= 5) {
-		hwif->ide_dma_test_irq = &hpt374_ide_dma_test_irq;
-		hwif->ide_dma_end = &hpt374_ide_dma_end;
+	if (info->revision >= 5) {
+		hwif->ide_dma_test_irq	= &hpt374_ide_dma_test_irq;
+		hwif->ide_dma_end	= &hpt374_ide_dma_end;
 	} else if (info->revision >= 3) {
-		hwif->dma_start = &hpt370_ide_dma_start;
-		hwif->ide_dma_end = &hpt370_ide_dma_end;
-		hwif->ide_dma_timeout = &hpt370_ide_dma_timeout;
-		hwif->ide_dma_lostirq = &hpt370_ide_dma_lostirq;
-	} else if (info->revision >= 2)
-		hwif->ide_dma_lostirq = &hpt366_ide_dma_lostirq;
-	else
-		hwif->ide_dma_lostirq = &hpt366_ide_dma_lostirq;
+		hwif->dma_start 	= &hpt370_ide_dma_start;
+		hwif->ide_dma_end	= &hpt370_ide_dma_end;
+		hwif->ide_dma_timeout	= &hpt370_ide_dma_timeout;
+		hwif->ide_dma_lostirq	= &hpt370_ide_dma_lostirq;
+	} else
+		hwif->ide_dma_lostirq	= &hpt366_ide_dma_lostirq;
 
 	if (!noautodma)
 		hwif->autodma = 1;
-	hwif->drives[0].autodma = hwif->autodma;
-	hwif->drives[1].autodma = hwif->autodma;
+	hwif->drives[0].autodma = hwif->drives[1].autodma = hwif->autodma;
 }
 
 static void __devinit init_dma_hpt366(ide_hwif_t *hwif, unsigned long dmabase)
 {
-	struct pci_dev  *dev		= hwif->pci_dev;
+	struct pci_dev	*dev		= hwif->pci_dev;
 	struct hpt_info	*info		= ide_get_hwifdata(hwif);
 	u8 masterdma	= 0, slavedma	= 0;
 	u8 dma_new	= 0, dma_old	= 0;
@@ -1330,7 +1249,7 @@ static void __devinit init_dma_hpt366(id
 		return;
 	}
 
-	dma_old = hwif->INB(dmabase+2);
+	dma_old = hwif->INB(dmabase + 2);
 
 	local_irq_save(flags);
 


--------------000100010004040400060705--
