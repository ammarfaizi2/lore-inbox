Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316640AbSEaTQA>; Fri, 31 May 2002 15:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316657AbSEaTP7>; Fri, 31 May 2002 15:15:59 -0400
Received: from [195.63.194.11] ([195.63.194.11]:59658 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316640AbSEaTPp>; Fri, 31 May 2002 15:15:45 -0400
Message-ID: <3CF7BE30.8060109@evision-ventures.com>
Date: Fri, 31 May 2002 20:17:20 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.19 IDE 77
In-Reply-To: <Pine.LNX.4.33.0205291146510.1344-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------040501080305030102060402"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040501080305030102060402
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Fri May 31 13:45:52 CEST 2002 ide-clean-77

- Get rid of SELECT_DRIVE macro. Start to move all direct hardware access
   functions in to one place.

- Get rid of SELECT_MASK macro. Realize that the mask is always equal 0.
   Simplify the maskproc therefore.

- Get rid of GET_STAT and OK_STAT macros as well.

- hpt366 cleanups by Andrej Panin.

- Artop driver update by Franz Sirl.


--------------040501080305030102060402
Content-Type: text/plain;
 name="ide-clean-77.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-77.diff"

diff -urN linux-2.5.19/arch/cris/drivers/ide.c linux/arch/cris/drivers/ide.c
--- linux-2.5.19/arch/cris/drivers/ide.c	2002-05-29 20:42:49.000000000 +0200
+++ linux/arch/cris/drivers/ide.c	2002-05-31 19:03:57.000000000 +0200
@@ -688,17 +688,16 @@
 /*
  * etrax_dma_intr() is the handler for disk read/write DMA interrupts
  */
-static ide_startstop_t etrax_dma_intr (struct ata_device *drive, struct request *rq)
+static ide_startstop_t etrax_dma_intr(struct ata_device *drive, struct request *rq)
 {
 	int i, dma_stat;
-	byte stat;
 
 	LED_DISK_READ(0);
 	LED_DISK_WRITE(0);
 
 	dma_stat = drive->channel->udma(ide_dma_end, drive, rq);
-	stat = GET_STAT();			/* get drive status */
-	if (OK_STAT(stat,DRIVE_READY,drive->bad_wstat|DRQ_STAT)) {
+	/* get drive status */
+	if (ata_status(drive, DRIVE_READY, drive->bad_wstat | DRQ_STAT)) {
 		if (!dma_stat) {
 			for (i = rq->nr_sectors; i > 0;) {
 				i -= rq->current_nr_sectors;
@@ -708,7 +707,7 @@
 		}
 		printk("%s: bad DMA status\n", drive->name);
 	}
-	return ide_error(drive, "dma_intr", stat);
+	return ide_error(drive, "dma_intr", drive->status);
 }
 
 /*
diff -urN linux-2.5.19/drivers/ide/aec62xx.c linux/drivers/ide/aec62xx.c
--- linux-2.5.19/drivers/ide/aec62xx.c	2002-05-29 20:42:52.000000000 +0200
+++ linux/drivers/ide/aec62xx.c	2002-05-31 21:04:44.000000000 +0200
@@ -54,6 +54,12 @@
 #define AEC_IDE_ENABLE		0x4a
 #define AEC_UDMA_OLD		0x54
 
+#define AEC_BM_STAT_PCH		0x02
+#define AEC_BM_STAT_SCH		0x0a
+
+#define AEC_PLLCLK_ATA133	0x10
+#define AEC_CABLEPINS_INPUT	0x10
+
 static unsigned char aec_cyc2udma[17] = { 0, 0, 7, 6, 5, 4, 4, 3, 3, 2, 2, 2, 2, 1, 1, 1, 1 };
 
 /*
@@ -146,6 +152,7 @@
 #ifdef CONFIG_BLK_DEV_IDEDMA
 static int aec62xx_dmaproc(struct ata_device *drive)
 {
+	u32 bmide = pci_resource_start(drive->channel->pci_dev, 4);
 	short speed;
 	int map;
 
@@ -155,7 +162,9 @@
 		switch (drive->channel->pci_dev->device) {
 			case PCI_DEVICE_ID_ARTOP_ATP865R:
 			case PCI_DEVICE_ID_ARTOP_ATP865:
-				map |= XFER_UDMA_100 | XFER_UDMA_133;
+				/* Can't use these modes simultaneously,
+				   based on which PLL clock was chosen. */
+				map |= inb (bmide + AEC_BM_STAT_PCH) & AEC_PLLCLK_ATA133 ? XFER_UDMA_133 : XFER_UDMA_100;
 			case PCI_DEVICE_ID_ARTOP_ATP860R:
 			case PCI_DEVICE_ID_ARTOP_ATP860:
 				map |= XFER_UDMA_66;
@@ -172,10 +181,12 @@
 /*
  * The initialization callback. Here we determine the IDE chip type
  * and initialize its drive independent registers.
+ * We return the IRQ assigned to the chip.
  */
 
 static unsigned int __init aec62xx_init_chipset(struct pci_dev *dev)
 {
+	u32 bmide = pci_resource_start(dev, 4);
 	unsigned char t;
 
 /*
@@ -202,8 +213,9 @@
 			/* Enable burst mode. */
 			pci_read_config_byte(dev, AEC_IDE_ENABLE, &t);
 			pci_write_config_byte(dev, AEC_IDE_ENABLE, t | 0x80);
-
 #endif
+			/* switch cable detection pins to input-only. */
+			outb (inb (bmide + AEC_BM_STAT_SCH) | AEC_CABLEPINS_INPUT, bmide + AEC_BM_STAT_SCH);
 	}
 
 /*
@@ -214,7 +226,7 @@
 	printk(KERN_INFO "AEC_IDE: %s (rev %02x) controller on pci%s\n",
 		dev->name, t, dev->slot_name);
 
-	return 0;
+	return dev->irq;
 }
 
 static unsigned int __init aec62xx_ata66_check(struct ata_channel *ch)
diff -urN linux-2.5.19/drivers/ide/device.c linux/drivers/ide/device.c
--- linux-2.5.19/drivers/ide/device.c	1970-01-01 01:00:00.000000000 +0100
+++ linux/drivers/ide/device.c	2002-05-31 16:53:15.000000000 +0200
@@ -0,0 +1,95 @@
+/**** vi:set ts=8 sts=8 sw=8:************************************************
+ *
+ * Copyright (C) 2002 Marcin Dalecki <martin@dalecki.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+/*
+ * Common low leved device access code. This is the lowest layer of hardware
+ * access.
+ */
+
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/string.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/ioport.h>
+#include <linux/blkdev.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/cdrom.h>
+#include <linux/hdreg.h>
+#include <linux/ide.h>
+
+#include <asm/byteorder.h>
+#include <asm/io.h>
+#include <asm/bitops.h>
+#include <asm/uaccess.h>
+
+/*
+ * Select a device for operation with possible busy waiting for the operation
+ * to complete.
+ */
+void ata_select(struct ata_device *drive, unsigned long delay)
+{
+	struct ata_channel *ch = drive->channel;
+
+	if (!ch)
+		return;
+
+	if (ch->selectproc)
+		ch->selectproc(drive);
+	OUT_BYTE(drive->select.all, ch->io_ports[IDE_SELECT_OFFSET]);
+
+	/* The delays during probing for drives can be georgeous.  Deal with
+	 * it.
+	 */
+	if (delay) {
+		if (delay >= 1000)
+			mdelay(delay / 1000);
+		else
+			udelay(delay);
+	}
+}
+
+EXPORT_SYMBOL(ata_select);
+
+/*
+ * Handle quirky routing of interrupts.
+ */
+void ata_mask(struct ata_device *drive)
+{
+	struct ata_channel *ch = drive->channel;
+
+	if (!ch)
+		return;
+
+	if (ch->maskproc)
+		ch->maskproc(drive);
+}
+
+/*
+ * Check the state of the status register.
+ */
+int ata_status(struct ata_device *drive, u8 good, u8 bad)
+{
+	struct ata_channel *ch = drive->channel;
+
+	drive->status = IN_BYTE(ch->io_ports[IDE_STATUS_OFFSET]);
+
+	return (drive->status & (good | bad)) == good;
+}
+
+EXPORT_SYMBOL(ata_status);
+
+MODULE_LICENSE("GPL");
diff -urN linux-2.5.19/drivers/ide/hpt366.c linux/drivers/ide/hpt366.c
--- linux-2.5.19/drivers/ide/hpt366.c	2002-05-31 19:30:47.000000000 +0200
+++ linux/drivers/ide/hpt366.c	2002-05-31 15:51:58.000000000 +0200
@@ -500,7 +500,7 @@
 
 static unsigned int hpt_revision(struct pci_dev *dev)
 {
-	unsigned int class_rev;
+	u32 class_rev;
 	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
 	class_rev &= 0xff;
 
@@ -556,7 +556,7 @@
 }
 
 
-static unsigned int pci_bus_clock_list(byte speed, struct chipset_bus_clock_list_entry * chipset_table)
+static unsigned int pci_bus_clock_list(u8 speed, struct chipset_bus_clock_list_entry * chipset_table)
 {
 	for ( ; chipset_table->xfer_speed ; chipset_table++)
 		if (chipset_table->xfer_speed == speed) {
@@ -565,18 +565,17 @@
 	return chipset_table->chipset_settings;
 }
 
-static void hpt366_tune_chipset(struct ata_device *drive, byte speed)
+static void hpt366_tune_chipset(struct ata_device *drive, u8 speed)
 {
 	struct pci_dev *dev	= drive->channel->pci_dev;
-	byte regtime		= (drive->select.b.unit & 0x01) ? 0x44 : 0x40;
-	byte regfast		= (drive->channel->unit) ? 0x55 : 0x51;
+	u8 regtime = (drive->select.b.unit & 0x01) ? 0x44 : 0x40;
+	u8 regfast = (drive->channel->unit) ? 0x55 : 0x51;
 			/*
 			 * since the channel is always 0 it does not matter.
 			 */
 
-	unsigned int reg1	= 0;
-	unsigned int reg2	= 0;
-	byte drive_fast		= 0;
+	u32 reg1, reg2;
+	u8 drive_fast;
 
 	/*
 	 * Disable the "fast interrupt" prediction.
@@ -601,19 +600,18 @@
 	pci_write_config_dword(dev, regtime, reg2);
 }
 
-static void hpt368_tune_chipset(struct ata_device *drive, byte speed)
+static void hpt368_tune_chipset(struct ata_device *drive, u8 speed)
 {
 	hpt366_tune_chipset(drive, speed);
 }
 
-static void hpt370_tune_chipset(struct ata_device *drive, byte speed)
+static void hpt370_tune_chipset(struct ata_device *drive, u8 speed)
 {
-	byte regfast		= (drive->channel->unit) ? 0x55 : 0x51;
-	unsigned int list_conf	= 0;
-	unsigned int drive_conf = 0;
-	unsigned int conf_mask	= (speed >= XFER_MW_DMA_0) ? 0xc0000000 : 0x30070000;
-	byte drive_pci		= 0x40 + (drive->dn * 4);
-	byte new_fast, drive_fast		= 0;
+	u8 regfast = (drive->channel->unit) ? 0x55 : 0x51;
+	u32 list_conf, drive_conf;
+	u32 conf_mask = (speed >= XFER_MW_DMA_0) ? 0xc0000000 : 0x30070000;
+	u8 drive_pci = 0x40 + (drive->dn * 4);
+	u8 new_fast, drive_fast;
 	struct pci_dev *dev	= drive->channel->pci_dev;
 
 	/*
@@ -649,14 +647,13 @@
 	pci_write_config_dword(dev, drive_pci, list_conf);
 }
 
-static void hpt372_tune_chipset(struct ata_device *drive, byte speed)
+static void hpt372_tune_chipset(struct ata_device *drive, u8 speed)
 {
-	byte regfast		= (drive->channel->unit) ? 0x55 : 0x51;
-	unsigned int list_conf	= 0;
-	unsigned int drive_conf	= 0;
-	unsigned int conf_mask	= (speed >= XFER_MW_DMA_0) ? 0xc0000000 : 0x30070000;
-	byte drive_pci		= 0x40 + (drive->dn * 4);
-	byte drive_fast		= 0;
+	u8 regfast = (drive->channel->unit) ? 0x55 : 0x51;
+	u32 list_conf, drive_conf;
+	u32 conf_mask = (speed >= XFER_MW_DMA_0) ? 0xc0000000 : 0x30070000;
+	u8 drive_pci = 0x40 + (drive->dn * 4);
+	u8 drive_fast;
 	struct pci_dev *dev	= drive->channel->pci_dev;
 
 	/*
@@ -677,12 +674,12 @@
 	pci_write_config_dword(dev, drive_pci, list_conf);
 }
 
-static void hpt374_tune_chipset(struct ata_device *drive, byte speed)
+static void hpt374_tune_chipset(struct ata_device *drive, u8 speed)
 {
 	hpt372_tune_chipset(drive, speed);
 }
 
-static int hpt3xx_tune_chipset(struct ata_device *drive, byte speed)
+static int hpt3xx_tune_chipset(struct ata_device *drive, u8 speed)
 {
 	struct pci_dev *dev = drive->channel->pci_dev;
 
@@ -706,9 +703,9 @@
 
 static void config_chipset_for_pio(struct ata_device *drive)
 {
-	unsigned short eide_pio_timing[6] = {960, 480, 240, 180, 120, 90};
+	static unsigned short eide_pio_timing[6] = {960, 480, 240, 180, 120, 90};
 	unsigned short xfer_pio = drive->id->eide_pio_modes;
-	byte	timing, speed, pio;
+	u8 timing, speed, pio;
 
 	pio = ata_timing_mode(drive, XFER_PIO | XFER_EPIO) - XFER_PIO_0;
 
@@ -739,12 +736,12 @@
 			speed = (!drive->id->tPIO) ? XFER_PIO_0 : XFER_PIO_SLOW;
 			break;
 	}
-	(void) hpt3xx_tune_chipset(drive, speed);
+	hpt3xx_tune_chipset(drive, speed);
 }
 
-static void hpt3xx_tune_drive(struct ata_device *drive, byte pio)
+static void hpt3xx_tune_drive(struct ata_device *drive, u8 pio)
 {
-	byte speed;
+	u8 speed;
 	switch(pio) {
 		case 4:		speed = XFER_PIO_4;break;
 		case 3:		speed = XFER_PIO_3;break;
@@ -760,7 +757,7 @@
 {
 	struct pci_dev *dev = drive->channel->pci_dev;
 	int map;
-	byte mode;
+	u8 mode;
 
 	if (drive->type != ATA_DISK)
 		return 0;
@@ -820,13 +817,14 @@
 	}
 }
 
-static void hpt3xx_maskproc(struct ata_device *drive, int mask)
+static void hpt3xx_maskproc(struct ata_device *drive)
 {
 	struct pci_dev *dev = drive->channel->pci_dev;
+	const int mask = 0;
 
 	if (drive->quirk_list) {
 		if (hpt_min_rev(dev, 3)) {
-			byte reg5a = 0;
+			u8 reg5a;
 			pci_read_config_byte(dev, 0x5a, &reg5a);
 			if (((reg5a & 0x10) >> 4) != mask)
 				pci_write_config_byte(dev, 0x5a, mask ? (reg5a | 0x10) : (reg5a & ~0x10));
@@ -899,7 +897,7 @@
 
 static void hpt366_udma_irq_lost(struct ata_device *drive)
 {
-	u8 reg50h = 0, reg52h = 0, reg5ah = 0;
+	u8 reg50h, reg52h, reg5ah;
 
 	pci_read_config_byte(drive->channel->pci_dev, 0x50, &reg50h);
 	pci_read_config_byte(drive->channel->pci_dev, 0x52, &reg52h);
@@ -1042,8 +1040,8 @@
 {
 #if 0
 	unsigned long high_16	= pci_resource_start(drive->channel->pci_dev, 4);
-	byte reset		= (drive->channel->unit) ? 0x80 : 0x40;
-	byte reg59h		= 0;
+	u8 reset		= (drive->channel->unit) ? 0x80 : 0x40;
+	u8 reg59h;
 
 	pci_read_config_byte(drive->channel->pci_dev, 0x59, &reg59h);
 	pci_write_config_byte(drive->channel->pci_dev, 0x59, reg59h|reset);
@@ -1056,10 +1054,9 @@
 {
 	struct ata_channel *ch	= drive->channel;
 	struct pci_dev *dev	= ch->pci_dev;
-	byte reset		= (ch->unit) ? 0x80 : 0x40;
-	byte state_reg		= (ch->unit) ? 0x57 : 0x53;
-	byte reg59h		= 0;
-	byte regXXh		= 0;
+	u8 reset = (ch->unit) ? 0x80 : 0x40;
+	u8 state_reg = (ch->unit) ? 0x57 : 0x53;
+	u8 reg59h, regXXh;
 
 	if (!ch)
 		return -EINVAL;
@@ -1268,8 +1265,8 @@
 
 static void __init hpt366_init(struct pci_dev *dev)
 {
-	unsigned int reg1	= 0;
-	u8 drive_fast		= 0;
+	u32 reg1;
+	u8 drive_fast;
 
 	/*
 	 * Disable the "fast interrupt" prediction.
@@ -1296,7 +1293,7 @@
 
 static unsigned int __init hpt366_init_chipset(struct pci_dev *dev)
 {
-	u8 test = 0;
+	u8 test;
 
 	if (dev->resource[PCI_ROM_RESOURCE].start)
 		pci_write_config_byte(dev, PCI_ROM_ADDRESS, dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
@@ -1327,8 +1324,8 @@
 
 static unsigned int __init hpt366_ata66_check(struct ata_channel *ch)
 {
-	u8 ata66	= 0;
-	u8 regmask	= (ch->unit) ? 0x01 : 0x02;
+	u8 ata66;
+	u8 regmask = (ch->unit) ? 0x01 : 0x02;
 
 	pci_read_config_byte(ch->pci_dev, 0x5a, &ata66);
 #ifdef DEBUG
@@ -1358,7 +1355,7 @@
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	if (ch->dma_base) {
 		if (hpt_min_rev(dev, 3)) {
-			byte reg5ah = 0;
+			u8 reg5ah;
 			pci_read_config_byte(dev, 0x5a, &reg5ah);
 			if (reg5ah & 0x10)	/* interrupt force enable */
 				pci_write_config_byte(dev, 0x5a, reg5ah & ~0x10);
@@ -1413,14 +1410,12 @@
 
 static void __init hpt366_init_dma(struct ata_channel *ch, unsigned long dmabase)
 {
-	u8 masterdma = 0;
-	u8 slavedma = 0;
-	u8 dma_new = 0;
-	u8 dma_old = inb(dmabase+2);
-	u8 primary	= ch->unit ? 0x4b : 0x43;
-	u8 secondary	= ch->unit ? 0x4f : 0x47;
+	u8 masterdma, slavedma;
+	u8 dma_old = inb(dmabase + 2);
+	u8 dma_new = dma_old;
+	u8 primary = ch->unit ? 0x4b : 0x43;
+	u8 secondary = primary + 4;
 
-	dma_new = dma_old;
 	pci_read_config_byte(ch->pci_dev, primary, &masterdma);
 	pci_read_config_byte(ch->pci_dev, secondary, &slavedma);
 
@@ -1480,5 +1475,5 @@
 		ata_register_chipset(&chipsets[i]);
 	}
 
-    return 0;
+	return 0;
 }
diff -urN linux-2.5.19/drivers/ide/icside.c linux/drivers/ide/icside.c
--- linux-2.5.19/drivers/ide/icside.c	2002-05-29 20:42:46.000000000 +0200
+++ linux/drivers/ide/icside.c	2002-05-31 18:38:54.000000000 +0200
@@ -232,8 +232,9 @@
  * Handle routing of interrupts.  This is called before
  * we write the command to the drive.
  */
-static void icside_maskproc(struct ata_device *drive, int mask)
+static void icside_maskproc(struct ata_device *drive)
 {
+	const int mask = 0;
 	struct ata_channel *ch = drive->channel;
 	struct icside_state *state = ch->hw.priv;
 	unsigned long flags;
@@ -465,12 +466,9 @@
 static ide_startstop_t icside_dmaintr(struct ata_device *drive, struct request *rq)
 {
 	int dma_stat;
-	byte stat;
 
 	dma_stat = icside_dma_stop(drive);
-
-	stat = GET_STAT();			/* get drive status */
-	if (OK_STAT(stat,DRIVE_READY,drive->bad_wstat|DRQ_STAT)) {
+	if (ata_status(drive, DRIVE_READY, drive->bad_wstat | DRQ_STAT)) {
 		if (!dma_stat) {
 			__ide_end_request(drive, rq, 1, rq->nr_sectors);
 			return ide_stopped;
@@ -478,7 +476,7 @@
 		printk("%s: dma_intr: bad DMA status (dma_stat=%x)\n",
 		       drive->name, dma_stat);
 	}
-	return ide_error(drive, rq, "dma_intr", stat);
+	return ide_error(drive, rq, "dma_intr", drive->status);
 }
 
 static int
@@ -587,7 +585,8 @@
 static void icside_dma_timeout(struct ata_device *drive)
 {
 	printk(KERN_ERR "ATA: %s: UDMA timeout occured:", drive->name);
-	ide_dump_status(drive, NULL, "UDMA timeout", GET_STAT());
+	ata_status(drive, 0, 0);
+	ide_dump_status(drive, NULL, "UDMA timeout", drive->status);
 }
 
 static void icside_irq_lost(struct ata_device *drive)
diff -urN linux-2.5.19/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.19/drivers/ide/ide.c	2002-05-29 20:42:54.000000000 +0200
+++ linux/drivers/ide/ide.c	2002-05-31 19:49:06.000000000 +0200
@@ -258,21 +258,21 @@
 static ide_startstop_t atapi_reset_pollfunc(struct ata_device *drive, struct request *__rq)
 {
 	struct ata_channel *ch = drive->channel;
-	u8 stat;
 
-	SELECT_DRIVE(ch,drive);
-	udelay (10);
+	ata_select(drive, 10);
 
-	if (OK_STAT(stat=GET_STAT(), 0, BUSY_STAT)) {
+	if (ata_status(drive, 0, BUSY_STAT))
 		printk("%s: ATAPI reset complete\n", drive->name);
-	} else {
+	else {
 		if (time_before(jiffies, ch->poll_timeout)) {
 			ide_set_handler (drive, atapi_reset_pollfunc, HZ/20, NULL);
+
 			return ide_started;	/* continue polling */
 		}
 		ch->poll_timeout = 0;	/* end of polling */
-		printk("%s: ATAPI reset timed out, status=0x%02x\n", drive->name, stat);
-		return do_reset1 (drive, 1);	/* do it the old fashioned way */
+		printk("%s: ATAPI reset timed out, status=0x%02x\n", drive->name, drive->status);
+
+		return do_reset1(drive, 1);	/* do it the old fashioned way */
 	}
 	ch->poll_timeout = 0;	/* done polling */
 
@@ -287,16 +287,18 @@
 static ide_startstop_t reset_pollfunc(struct ata_device *drive, struct request *__rq)
 {
 	struct ata_channel *ch = drive->channel;
-	u8 stat;
 
-	if (!OK_STAT(stat=GET_STAT(), 0, BUSY_STAT)) {
+	if (!ata_status(drive, 0, BUSY_STAT)) {
 		if (time_before(jiffies, ch->poll_timeout)) {
 			ide_set_handler(drive, reset_pollfunc, HZ/20, NULL);
+
 			return ide_started;	/* continue polling */
 		}
-		printk("%s: reset timed out, status=0x%02x\n", ch->name, stat);
+		printk("%s: reset timed out, status=0x%02x\n", ch->name, drive->status);
 		drive->failures++;
 	} else  {
+		u8 stat;
+
 		printk("%s: reset: ", ch->name);
 		if ((stat = GET_ERR()) == 1) {
 			printk("success\n");
@@ -360,8 +362,7 @@
 	/* For an ATAPI device, first try an ATAPI SRST. */
 	if (drive->type != ATA_DISK && !do_not_try_atapi) {
 		check_crc_errors(drive);
-		SELECT_DRIVE(ch, drive);
-		udelay (20);
+		ata_select(drive, 20);
 		OUT_BYTE(WIN_SRST, IDE_COMMAND_REG);
 		ch->poll_timeout = jiffies + WAIT_WORSTCASE;
 		ide_set_handler(drive, atapi_reset_pollfunc, HZ/20, NULL);
@@ -430,20 +431,20 @@
  *
  * Should be called under lock held.
  */
-void ide_end_drive_cmd(struct ata_device *drive, struct request *rq, u8 stat, u8 err)
+void ide_end_drive_cmd(struct ata_device *drive, struct request *rq, u8 err)
 {
 	if (rq->flags & REQ_DRIVE_CMD) {
 		u8 *args = rq->buffer;
-		rq->errors = !OK_STAT(stat, READY_STAT, BAD_STAT);
+		rq->errors = !ata_status(drive, READY_STAT, BAD_STAT);
 		if (args) {
-			args[0] = stat;
+			args[0] = drive->status;
 			args[1] = err;
 			args[2] = IN_BYTE(IDE_NSECTOR_REG);
 		}
 	} else if (rq->flags & REQ_DRIVE_ACB) {
 		struct ata_taskfile *args = rq->special;
 
-		rq->errors = !OK_STAT(stat, READY_STAT, BAD_STAT);
+		rq->errors = !ata_status(drive, READY_STAT, BAD_STAT);
 		if (args) {
 			args->taskfile.feature = err;
 			args->taskfile.sector_count = IN_BYTE(IDE_NSECTOR_REG);
@@ -451,7 +452,7 @@
 			args->taskfile.low_cylinder = IN_BYTE(IDE_LCYL_REG);
 			args->taskfile.high_cylinder = IN_BYTE(IDE_HCYL_REG);
 			args->taskfile.device_head = IN_BYTE(IDE_SELECT_REG);
-			args->taskfile.command = stat;
+			args->taskfile.command = drive->status;
 			if ((drive->id->command_set_2 & 0x0400) &&
 			    (drive->id->cfs_enable_2 & 0x0400) &&
 			    (drive->addressing == 1)) {
@@ -641,7 +642,7 @@
 	/* retry only "normal" I/O: */
 	if (!(rq->flags & REQ_CMD)) {
 		rq->errors = 1;
-		ide_end_drive_cmd(drive, rq, stat, err);
+		ide_end_drive_cmd(drive, rq, err);
 		return ide_stopped;
 	}
 
@@ -664,8 +665,8 @@
 		if ((stat & DRQ_STAT) && rq_data_dir(rq) == READ)
 			try_to_flush_leftover_data(drive);
 	}
-	if (GET_STAT() & (BUSY_STAT|DRQ_STAT))
-		OUT_BYTE(WIN_IDLEIMMEDIATE,IDE_COMMAND_REG);	/* force an abort */
+	if (!ata_status(drive, 0, BUSY_STAT|DRQ_STAT))
+		OUT_BYTE(WIN_IDLEIMMEDIATE, IDE_COMMAND_REG);	/* force an abort */
 
 	if (rq->errors >= ERROR_MAX) {
 		if (ata_ops(drive) && ata_ops(drive)->end_request)
@@ -688,20 +689,19 @@
 static ide_startstop_t drive_cmd_intr(struct ata_device *drive, struct request *rq)
 {
 	u8 *args = rq->buffer;
-	u8 stat = GET_STAT();
 	int retries = 10;
 
 	ide__sti();	/* local CPU only */
-	if ((stat & DRQ_STAT) && args && args[3]) {
+	if (!ata_status(drive, 0, DRQ_STAT) && args && args[3]) {
 		ata_read(drive, &args[4], args[3] * SECTOR_WORDS);
 
-		while (((stat = GET_STAT()) & BUSY_STAT) && retries--)
+		while (!ata_status(drive, 0, BUSY_STAT) && retries--)
 			udelay(100);
 	}
 
-	if (!OK_STAT(stat, READY_STAT, BAD_STAT))
-		return ide_error(drive, rq, "drive_cmd", stat); /* already calls ide_end_drive_cmd */
-	ide_end_drive_cmd(drive, rq, stat, GET_ERR());
+	if (!ata_status(drive, READY_STAT, BAD_STAT))
+		return ide_error(drive, rq, "drive_cmd", drive->status); /* already calls ide_end_drive_cmd */
+	ide_end_drive_cmd(drive, rq, GET_ERR());
 
 	return ide_stopped;
 }
@@ -714,7 +714,7 @@
 	ide_set_handler(drive, drive_cmd_intr, WAIT_CMD, NULL);
 	if (IDE_CONTROL_REG)
 		OUT_BYTE(drive->ctl, IDE_CONTROL_REG);	/* clear nIEN */
-	SELECT_MASK(drive->channel, drive, 0);
+	ata_mask(drive);
 	OUT_BYTE(nsect, IDE_NSECTOR_REG);
 	OUT_BYTE(cmd, IDE_COMMAND_REG);
 }
@@ -735,21 +735,21 @@
 		struct ata_device *drive, struct request *rq,
 		byte good, byte bad, unsigned long timeout)
 {
-	u8 stat;
 	int i;
 
 	/* bail early if we've exceeded max_failures */
 	if (drive->max_failures && (drive->failures > drive->max_failures)) {
 		*startstop = ide_stopped;
+
 		return 1;
 	}
 
 	udelay(1);	/* spec allows drive 400ns to assert "BUSY" */
-	if ((stat = GET_STAT()) & BUSY_STAT) {
+	if (!ata_status(drive, 0, BUSY_STAT)) {
 		timeout += jiffies;
-		while ((stat = GET_STAT()) & BUSY_STAT) {
+		while (!ata_status(drive, 0, BUSY_STAT)) {
 			if (time_after(jiffies, timeout)) {
-				*startstop = ide_error(drive, rq, "status timeout", stat);
+				*startstop = ide_error(drive, rq, "status timeout", drive->status);
 				return 1;
 			}
 		}
@@ -763,10 +763,10 @@
 	 */
 	for (i = 0; i < 10; i++) {
 		udelay(1);
-		if (OK_STAT((stat = GET_STAT()), good, bad))
+		if (ata_status(drive, good, bad))
 			return 0;
 	}
-	*startstop = ide_error(drive, rq, "status error", stat);
+	*startstop = ide_error(drive, rq, "status error", drive->status);
 
 	return 1;
 }
@@ -813,7 +813,7 @@
 	{
 		ide_startstop_t res;
 
-		SELECT_DRIVE(ch, drive);
+		ata_select(drive, 0);
 		if (ide_wait_stat(&res, drive, rq, drive->ready_stat,
 					BUSY_STAT|DRQ_STAT, WAIT_READY)) {
 			printk(KERN_WARNING "%s: drive not ready for command\n", drive->name);
@@ -905,7 +905,7 @@
 #ifdef DEBUG
 	printk("%s: DRIVE_CMD (null)\n", drive->name);
 #endif
-	ide_end_drive_cmd(drive, rq, GET_STAT(), GET_ERR());
+	ide_end_drive_cmd(drive, rq, GET_ERR());
 
 	return ide_stopped;
 }
@@ -1279,7 +1279,7 @@
 					startstop = ide_stopped;
 					dma_timeout_retry(drive, drive->rq);
 				} else
-					startstop = ide_error(drive, drive->rq, "irq timeout", GET_STAT());
+					startstop = ide_error(drive, drive->rq, "irq timeout", drive->status);
 			}
 			enable_irq(ch->irq);
 
@@ -1323,8 +1323,8 @@
 	int i;
 
 	for (i = 0; i < MAX_HWIFS; ++i) {
-		u8 stat;
 		struct ata_channel *ch = &ide_hwifs[i];
+		struct ata_device *drive;
 
 		if (!ch->present)
 			continue;
@@ -1332,8 +1332,10 @@
 		if (ch->irq != irq)
 			continue;
 
-		stat = IN_BYTE(ch->io_ports[IDE_STATUS_OFFSET]);
-		if (!OK_STAT(stat, READY_STAT, BAD_STAT)) {
+		/* FIXME: this is a bit weak */
+		drive = &ch->drives[0];
+
+		if (!ata_status(drive, READY_STAT, BAD_STAT)) {
 			/* Try to not flood the console with msgs */
 			static unsigned long last_msgtime;
 			static int count;
@@ -1342,7 +1344,7 @@
 			if (time_after(jiffies, last_msgtime + HZ)) {
 				last_msgtime = jiffies;
 				printk("%s: unexpected interrupt, status=0x%02x, count=%d\n",
-						ch->name, stat, count);
+						ch->name, drive->status, count);
 			}
 		}
 	}
diff -urN linux-2.5.19/drivers/ide/ide-cd.c linux/drivers/ide/ide-cd.c
--- linux-2.5.19/drivers/ide/ide-cd.c	2002-05-29 20:42:53.000000000 +0200
+++ linux/drivers/ide/ide-cd.c	2002-05-31 18:41:18.000000000 +0200
@@ -565,14 +565,14 @@
 static int cdrom_decode_status(ide_startstop_t *startstop, struct ata_device *drive, struct request *rq,
 				int good_stat, int *stat_ret)
 {
-	int stat, err, sense_key;
+	int err, sense_key;
 	struct packet_command *pc;
+	int ok;
 
 	/* Check for errors. */
-	stat = GET_STAT();
-	*stat_ret = stat;
-
-	if (OK_STAT (stat, good_stat, BAD_R_STAT))
+	ok = ata_status(drive, good_stat, BAD_R_STAT);
+	*stat_ret = drive->status;
+	if (ok)
 		return 0;
 
 	/* Get the IDE error register. */
@@ -594,7 +594,7 @@
 		pc = (struct packet_command *) rq->special;
 		pc->stat = 1;
 		cdrom_end_request(drive, rq, 1);
-		*startstop = ide_error (drive, rq, "request sense failure", stat);
+		*startstop = ide_error(drive, rq, "request sense failure", drive->status);
 
 		return 1;
 	} else if (rq->flags & (REQ_PC | REQ_BLOCK_PC)) {
@@ -614,7 +614,7 @@
 			return 0;
 		} else if (!pc->quiet) {
 			/* Otherwise, print an error. */
-			ide_dump_status(drive, rq, "packet command error", stat);
+			ide_dump_status(drive, rq, "packet command error", drive->status);
 		}
 
 		/* Set the error flag and complete the request.
@@ -625,7 +625,7 @@
 		   the semaphore from the packet command request to the request
 		   sense request. */
 
-		if ((stat & ERR_STAT) != 0) {
+		if (drive->status & ERR_STAT) {
 			wait = rq->waiting;
 			rq->waiting = NULL;
 		}
@@ -637,7 +637,7 @@
 		 * Think hard about how to get rid of it...
 		 */
 
-		if ((stat & ERR_STAT) != 0)
+		if (drive->status & ERR_STAT)
 			cdrom_queue_request_sense(drive, wait, pc->sense, pc);
 	} else if (rq->flags & REQ_CMD) {
 		/* Handle errors from READ and WRITE requests. */
@@ -662,18 +662,18 @@
 			   sense_key == DATA_PROTECT) {
 			/* No point in retrying after an illegal
 			   request or data protect error.*/
-			ide_dump_status(drive, rq, "command error", stat);
+			ide_dump_status(drive, rq, "command error", drive->status);
 			cdrom_end_request(drive, rq,  0);
 		} else if (sense_key == MEDIUM_ERROR) {
 			/* No point in re-trying a zillion times on a bad
 			 * sector.  The error is not correctable at all.
 			 */
-			ide_dump_status(drive, rq, "media error (bad sector)", stat);
+			ide_dump_status(drive, rq, "media error (bad sector)", drive->status);
 			cdrom_end_request(drive, rq, 0);
 		} else if ((err & ~ABRT_ERR) != 0) {
 			/* Go to the default handler
 			   for other errors. */
-			*startstop = ide_error(drive, rq, __FUNCTION__, stat);
+			*startstop = ide_error(drive, rq, __FUNCTION__, drive->status);
 			return 1;
 		} else if ((++rq->errors > ERROR_MAX)) {
 			/* We've racked up too many retries.  Abort. */
@@ -682,7 +682,7 @@
 
 		/* If we got a CHECK_CONDITION status,
 		   queue a request sense command. */
-		if ((stat & ERR_STAT) != 0)
+		if (drive->status & ERR_STAT)
 			cdrom_queue_request_sense(drive, NULL, NULL, NULL);
 	} else
 		blk_dump_rq_flags(rq, "ide-cd bad flags");
@@ -880,7 +880,7 @@
 		/* Some drives (ASUS) seem to tell us that status
 		 * info is available. just get it and ignore.
 		 */
-		GET_STAT();
+		ata_status(drive, 0, 0);
 		return 0;
 	} else {
 		/* Drive wants a command packet, or invalid ireason... */
@@ -1619,9 +1619,8 @@
 	if (rq->flags & REQ_CMD) {
 		if (CDROM_CONFIG_FLAGS(drive)->seeking) {
 			unsigned long elpased = jiffies - info->start_seek;
-			int stat = GET_STAT();
 
-			if ((stat & SEEK_STAT) != SEEK_STAT) {
+			if (!ata_status(drive, SEEK_STAT, 0)) {
 				if (elpased < IDECD_SEEK_TIMEOUT) {
 					ide_stall_queue(drive, IDECD_SEEK_TIMER);
 					return ide_stopped;
diff -urN linux-2.5.19/drivers/ide/ide-floppy.c linux/drivers/ide/ide-floppy.c
--- linux-2.5.19/drivers/ide/ide-floppy.c	2002-05-31 19:30:47.000000000 +0200
+++ linux/drivers/ide/ide-floppy.c	2002-05-31 18:52:48.000000000 +0200
@@ -637,7 +637,7 @@
 		return 0;
 	}
 	rq->errors = error;
-	ide_end_drive_cmd (drive, rq, 0, 0);
+	ide_end_drive_cmd (drive, rq, 0);
 
 	return 0;
 }
@@ -844,7 +844,8 @@
 	}
 #endif
 
-	status.all = GET_STAT();					/* Clear the interrupt */
+	ata_status(drive, 0, 0);
+	status.all = drive->status;					/* Clear the interrupt */
 
 	if (!status.b.drq) {						/* No more interrupts */
 #if IDEFLOPPY_DEBUG_LOG
@@ -1588,7 +1589,8 @@
 
 		__save_flags(flags);
 		__cli();
-		status.all=GET_STAT();
+		ata_status(drive, 0, 0);
+		status.all = drive->status;
 		__restore_flags(flags);
 
 		progress_indication= !status.b.dsc ? 0:0x10000;
diff -urN linux-2.5.19/drivers/ide/ide-pmac.c linux/drivers/ide/ide-pmac.c
--- linux-2.5.19/drivers/ide/ide-pmac.c	2002-05-29 20:42:57.000000000 +0200
+++ linux/drivers/ide/ide-pmac.c	2002-05-31 19:53:24.000000000 +0200
@@ -395,21 +395,21 @@
 {
 	/* Timeout bumped for some powerbooks */
 	int timeout = 2000;
-	byte stat;
 
-	while(--timeout) {
-		stat = GET_STAT();
-		if(!(stat & BUSY_STAT)) {
+	while (--timeout) {
+		if(ata_status(drive, 0, BUSY_STAT)) {
 			if (drive->ready_stat == 0)
 				break;
-			else if((stat & drive->ready_stat) || (stat & ERR_STAT))
+			else if((drive->status & drive->ready_stat)
+				|| (drive->status & ERR_STAT))
 				break;
 		}
 		mdelay(1);
 	}
-	if((stat & ERR_STAT) || timeout <= 0) {
-		if (stat & ERR_STAT) {
-			printk(KERN_ERR "ide_pmac: wait_for_ready, error status: %x\n", stat);
+	if((drive->status & ERR_STAT) || timeout <= 0) {
+		if (drive->status & ERR_STAT) {
+			printk(KERN_ERR "ide_pmac: wait_for_ready, error status: %x\n",
+				drive->status);
 		}
 		return 1;
 	}
@@ -417,7 +417,7 @@
 }
 
 static int __pmac
-pmac_ide_do_setfeature(struct ata_device *drive, byte command)
+pmac_ide_do_setfeature(struct ata_device *drive, u8 command)
 {
 	int result = 1;
 	unsigned long flags;
@@ -425,11 +425,11 @@
 
 	disable_irq(hwif->irq);	/* disable_irq_nosync ?? */
 	udelay(1);
-	SELECT_DRIVE(drive->channel, drive);
-	SELECT_MASK(drive->channel, drive, 0);
+	ata_select(drive, 0);
+	ata_mask(drive);
 	udelay(1);
-	(void)GET_STAT(); /* Get rid of pending error state */
-	if(wait_for_ready(drive)) {
+	ata_status(drive, 0, 0); /* Get rid of pending error state */
+	if (wait_for_ready(drive)) {
 		printk(KERN_ERR "pmac_ide_do_setfeature disk not ready before SET_FEATURE!\n");
 		goto out;
 	}
@@ -447,7 +447,7 @@
 	if (result)
 		printk(KERN_ERR "pmac_ide_do_setfeature disk not ready after SET_FEATURE !\n");
 out:
-	SELECT_MASK(drive->channel, drive, 0);
+	ata_mask(drive);
 	if (result == 0) {
 		drive->id->dma_ultra &= ~0xFF00;
 		drive->id->dma_mword &= ~0x0F00;
diff -urN linux-2.5.19/drivers/ide/ide-tape.c linux/drivers/ide/ide-tape.c
--- linux-2.5.19/drivers/ide/ide-tape.c	2002-05-31 19:30:47.000000000 +0200
+++ linux/drivers/ide/ide-tape.c	2002-05-31 18:55:07.000000000 +0200
@@ -1864,7 +1864,7 @@
 				idetape_increase_max_pipeline_stages (drive);
 		}
 	}
-	ide_end_drive_cmd(drive, rq, 0, 0);
+	ide_end_drive_cmd(drive, rq, 0);
 	if (remove_stage)
 		idetape_remove_stage_head (drive);
 	if (tape->active_data_request == NULL)
@@ -1991,7 +1991,8 @@
 		printk (KERN_INFO "ide-tape: Reached idetape_pc_intr interrupt handler\n");
 #endif
 
-	status.all = GET_STAT();					/* Clear the interrupt */
+	ata_status(drive, 0, 0);
+	status.all = drive->status;					/* Clear the interrupt */
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	if (test_bit (PC_DMA_IN_PROGRESS, &pc->flags)) {
@@ -2415,7 +2416,8 @@
 
 	if (tape->onstream)
 		printk(KERN_INFO "ide-tape: bug: onstream, media_access_finished\n");
-	status.all = GET_STAT();
+	ata_status(drive, 0, 0);
+	status.all = drive->status;
 	if (status.b.dsc) {
 		if (status.b.check) {					/* Error detected */
 			printk (KERN_ERR "ide-tape: %s: I/O error, ",tape->name);
@@ -2603,10 +2605,11 @@
 	tape->postponed_rq = NULL;
 
 	/*
-	 *	If the tape is still busy, postpone our request and service
-	 *	the other device meanwhile.
+	 * If the tape is still busy, postpone our request and service
+	 * the other device meanwhile.
 	 */
-	status.all = GET_STAT();
+	ata_status(drive, 0, 0);
+	status.all = drive->status;
 
 	/*
 	 * The OnStream tape drive doesn't support DSC. Assume
diff -urN linux-2.5.19/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- linux-2.5.19/drivers/ide/ide-taskfile.c	2002-05-29 20:42:55.000000000 +0200
+++ linux/drivers/ide/ide-taskfile.c	2002-05-31 18:51:26.000000000 +0200
@@ -1,4 +1,5 @@
-/*
+/**** vi:set ts=8 sts=8 sw=8:************************************************
+ *
  *  Copyright (C) 2002		Marcin Dalecki <martin@dalecki.de>
  *  Copyright (C) 2000		Michael Cornwell <cornwell@acm.org>
  *  Copyright (C) 2000		Andre Hedrick <andre@linux-ide.org>
@@ -165,14 +166,15 @@
  */
 int drive_is_ready(struct ata_device *drive)
 {
-	byte stat = 0;
 	if (drive->waiting_for_dma)
 		return udma_irq_status(drive);
+
 #if 0
 	/* need to guarantee 400ns since last command was issued */
 	udelay(1);
 #endif
 
+	/* FIXME: promote this to the general status read method perhaps */
 #ifdef CONFIG_IDEPCI_SHARE_IRQ
 	/*
 	 * We do a passive status test under shared PCI interrupts on
@@ -181,12 +183,12 @@
 	 * about possible isa-pnp and pci-pnp issues yet.
 	 */
 	if (IDE_CONTROL_REG)
-		stat = GET_ALTSTAT();
+		drive->status = GET_ALTSTAT();
 	else
 #endif
-	stat = GET_STAT();	/* Note: this may clear a pending IRQ!! */
+	ata_status(drive, 0, 0);	/* Note: this may clear a pending IRQ!! */
 
-	if (stat & BUSY_STAT)
+	if (drive->status & BUSY_STAT)
 		return 0;	/* drive busy:  definitely not interrupting */
 
 	return 1;		/* drive ready: *might* be interrupting */
@@ -228,34 +230,36 @@
 
 static ide_startstop_t task_mulout_intr(struct ata_device *drive, struct request *rq)
 {
-	u8 stat = GET_STAT();
+	int ok;
 	int mcount = drive->mult_count;
 	ide_startstop_t startstop;
 
+
 	/*
+	 * FIXME: the drive->status checks here seem to be messy.
+	 *
 	 * (ks/hs): Handle last IRQ on multi-sector transfer,
 	 * occurs after all data was sent in this chunk
 	 */
-	if (!rq->nr_sectors) {
-		if (stat & (ERR_STAT|DRQ_STAT)) {
-			startstop = ide_error(drive, rq, "task_mulout_intr", stat);
+
+	ok = ata_status(drive, DATA_READY, BAD_R_STAT);
+
+	if (!ok || !rq->nr_sectors) {
+		if (drive->status & (ERR_STAT | DRQ_STAT)) {
+			startstop = ide_error(drive, rq, __FUNCTION__, drive->status);
 
 			return startstop;
 		}
+	}
 
+	if (!rq->nr_sectors) {
 		__ide_end_request(drive, rq, 1, rq->hard_nr_sectors);
 		rq->bio = NULL;
 
 		return ide_stopped;
 	}
 
-	if (!OK_STAT(stat, DATA_READY, BAD_R_STAT)) {
-		if (stat & (ERR_STAT | DRQ_STAT)) {
-			startstop = ide_error(drive, rq, "task_mulout_intr", stat);
-
-			return startstop;
-		}
-
+	if (!ok) {
 		/* no data yet, so wait for another interrupt */
 		if (!drive->channel->handler)
 			ide_set_handler(drive, task_mulout_intr, WAIT_CMD, NULL);
@@ -330,7 +334,7 @@
 	if (args->handler != task_mulout_intr) {
 		if (IDE_CONTROL_REG)
 			OUT_BYTE(drive->ctl, IDE_CONTROL_REG);	/* clear nIEN */
-		SELECT_MASK(drive->channel, drive, 0);
+		ata_mask(drive);
 	}
 
 	if ((id->command_set_2 & 0x0400) &&
@@ -407,10 +411,9 @@
  */
 ide_startstop_t recal_intr(struct ata_device *drive, struct request *rq)
 {
-	u8 stat;
+	if (!ata_status(drive, READY_STAT, BAD_STAT))
+		return ide_error(drive, rq, "recal_intr", drive->status);
 
-	if (!OK_STAT(stat = GET_STAT(),READY_STAT,BAD_STAT))
-		return ide_error(drive, rq, "recal_intr", stat);
 	return ide_stopped;
 }
 
@@ -419,19 +422,18 @@
  */
 ide_startstop_t task_no_data_intr(struct ata_device *drive, struct request *rq)
 {
-	u8 stat;
 	struct ata_taskfile *args = rq->special;
 
 	ide__sti();	/* local CPU only */
 
-	if (!OK_STAT(stat = GET_STAT(), READY_STAT, BAD_STAT)) {
+	if (!ata_status(drive, READY_STAT, BAD_STAT)) {
 		/* Keep quiet for NOP because it is expected to fail. */
 		if (args && args->taskfile.command != WIN_NOP)
-			return ide_error(drive, rq, "task_no_data_intr", stat);
+			return ide_error(drive, rq, "task_no_data_intr", drive->status);
 	}
 
 	if (args)
-		ide_end_drive_cmd(drive, rq, stat, GET_ERR());
+		ide_end_drive_cmd(drive, rq, GET_ERR());
 
 	return ide_stopped;
 }
@@ -441,42 +443,41 @@
  */
 static ide_startstop_t task_in_intr(struct ata_device *drive, struct request *rq)
 {
-	u8 stat	= GET_STAT();
 	char *pBuf = NULL;
 	unsigned long flags;
 
-	if (!OK_STAT(stat,DATA_READY,BAD_R_STAT)) {
-		if (stat & (ERR_STAT|DRQ_STAT)) {
-			return ide_error(drive, rq, "task_in_intr", stat);
-		}
-		if (!(stat & BUSY_STAT)) {
+	if (!ata_status(drive, DATA_READY, BAD_R_STAT)) {
+		if (drive->status & (ERR_STAT|DRQ_STAT))
+			return ide_error(drive, rq, __FUNCTION__, drive->status);
+
+		if (!(drive->status & BUSY_STAT)) {
 			DTF("task_in_intr to Soon wait for next interrupt\n");
 			ide_set_handler(drive, task_in_intr, WAIT_CMD, NULL);
+
 			return ide_started;
 		}
 	}
-	DTF("stat: %02x\n", stat);
+	DTF("stat: %02x\n", drive->status);
 	pBuf = ide_map_rq(rq, &flags);
 	DTF("Read: %p, rq->current_nr_sectors: %d\n", pBuf, (int) rq->current_nr_sectors);
 
 	ata_read(drive, pBuf, SECTOR_WORDS);
 	ide_unmap_rq(rq, pBuf, &flags);
 
-	/*
-	 * first segment of the request is complete. note that this does not
-	 * necessarily mean that the entire request is done!! this is only
-	 * true if ide_end_request() returns 0.
+	/* First segment of the request is complete. note that this does not
+	 * necessarily mean that the entire request is done!! this is only true
+	 * if ide_end_request() returns 0.
 	 */
+
 	if (--rq->current_nr_sectors <= 0) {
-		DTF("Request Ended stat: %02x\n", GET_STAT());
+		DTF("Request Ended stat: %02x\n", drive->status);
 		if (!ide_end_request(drive, rq, 1))
 			return ide_stopped;
 	}
 
-	/*
-	 * still data left to transfer
-	 */
+	/* still data left to transfer */
 	ide_set_handler(drive, task_in_intr,  WAIT_CMD, NULL);
+
 	return ide_started;
 }
 
@@ -511,18 +512,17 @@
  */
 static ide_startstop_t task_out_intr(struct ata_device *drive, struct request *rq)
 {
-	u8 stat = GET_STAT();
 	char *pBuf = NULL;
 	unsigned long flags;
 
-	if (!OK_STAT(stat,DRIVE_READY,drive->bad_wstat))
-		return ide_error(drive, rq, "task_out_intr", stat);
+	if (!ata_status(drive, DRIVE_READY, drive->bad_wstat))
+		return ide_error(drive, rq, __FUNCTION__, drive->status);
 
 	if (!rq->current_nr_sectors)
 		if (!ide_end_request(drive, rq, 1))
 			return ide_stopped;
 
-	if ((rq->nr_sectors == 1) != (stat & DRQ_STAT)) {
+	if ((rq->nr_sectors == 1) != (drive->status & DRQ_STAT)) {
 		pBuf = ide_map_rq(rq, &flags);
 		DTF("write: %p, rq->current_nr_sectors: %d\n", pBuf, (int) rq->current_nr_sectors);
 
@@ -533,6 +533,7 @@
 	}
 
 	ide_set_handler(drive, task_out_intr, WAIT_CMD, NULL);
+
 	return ide_started;
 }
 
@@ -541,14 +542,13 @@
  */
 static ide_startstop_t task_mulin_intr(struct ata_device *drive, struct request *rq)
 {
-	u8 stat;
 	char *pBuf = NULL;
 	unsigned int msect, nsect;
 	unsigned long flags;
 
-	if (!OK_STAT(stat = GET_STAT(),DATA_READY,BAD_R_STAT)) {
-		if (stat & (ERR_STAT|DRQ_STAT)) {
-			return ide_error(drive, rq, "task_mulin_intr", stat);
+	if (!ata_status(drive, DATA_READY, BAD_R_STAT)) {
+		if (drive->status & (ERR_STAT|DRQ_STAT)) {
+			return ide_error(drive, rq, __FUNCTION__, drive->status);
 		}
 		/* no data yet, so wait for another interrupt */
 		ide_set_handler(drive, task_mulin_intr, WAIT_CMD, NULL);
diff -urN linux-2.5.19/drivers/ide/main.c linux/drivers/ide/main.c
--- linux-2.5.19/drivers/ide/main.c	2002-05-29 20:42:43.000000000 +0200
+++ linux/drivers/ide/main.c	2002-05-31 21:04:44.000000000 +0200
@@ -1293,6 +1293,7 @@
 	printk(KERN_INFO "ATA/ATAPI device driver v" VERSION "\n");
 
 	ide_devfs_handle = devfs_mk_dir(NULL, "ata", NULL);
+	devfs_mk_symlink(NULL, "ide", DEVFS_FL_DEFAULT, "ata", NULL, NULL);
 
 	/*
 	 * Because most of the ATA adapters represent the timings in unit of
diff -urN linux-2.5.19/drivers/ide/Makefile linux/drivers/ide/Makefile
--- linux-2.5.19/drivers/ide/Makefile	2002-05-29 20:42:56.000000000 +0200
+++ linux/drivers/ide/Makefile	2002-05-31 13:51:23.000000000 +0200
@@ -8,7 +8,7 @@
 # In the future, some of these should be built conditionally.
 #
 
-export-objs	:= ide-taskfile.o main.o ide.o probe.o quirks.o pcidma.o tcq.o \
+export-objs	:= device.o ide-taskfile.o main.o ide.o probe.o quirks.o pcidma.o tcq.o \
 		   atapi.o ataraid.o
 
 obj-$(CONFIG_BLK_DEV_HD)	+= hd.o
@@ -68,7 +68,7 @@
 obj-$(CONFIG_BLK_DEV_ATARAID_PDC)	+= pdcraid.o
 obj-$(CONFIG_BLK_DEV_ATARAID_HPT)	+= hptraid.o
 
-ide-mod-objs	:= ide-taskfile.o main.o ide.o probe.o \
+ide-mod-objs	:= device.o ide-taskfile.o main.o ide.o probe.o \
 		   ioctl.o atapi.o ata-timing.o $(ide-obj-y)
 
 include $(TOPDIR)/Rules.make
diff -urN linux-2.5.19/drivers/ide/ns87415.c linux/drivers/ide/ns87415.c
--- linux-2.5.19/drivers/ide/ns87415.c	2002-05-29 20:42:52.000000000 +0200
+++ linux/drivers/ide/ns87415.c	2002-05-31 14:20:47.000000000 +0200
@@ -195,7 +195,7 @@
 #ifdef __sparc_v9__
 		/*
 		 * XXX: Reset the device, if we don't it will not respond
-		 *      to SELECT_DRIVE() properly during first probe_hwif().
+		 *      to select properly during first probe.
 		 */
 		timeout = 10000;
 		outb(12, hwif->io_ports[IDE_CONTROL_OFFSET]);
diff -urN linux-2.5.19/drivers/ide/pcidma.c linux/drivers/ide/pcidma.c
--- linux-2.5.19/drivers/ide/pcidma.c	2002-05-29 20:42:48.000000000 +0200
+++ linux/drivers/ide/pcidma.c	2002-05-31 18:45:20.000000000 +0200
@@ -39,10 +39,9 @@
  */
 ide_startstop_t ide_dma_intr(struct ata_device *drive, struct request *rq)
 {
-	u8 stat, dma_stat;
-
+	u8 dma_stat;
 	dma_stat = udma_stop(drive);
-	if (OK_STAT(stat = GET_STAT(),DRIVE_READY,drive->bad_wstat|DRQ_STAT)) {
+	if (ata_status(drive, DRIVE_READY, drive->bad_wstat | DRQ_STAT)) {
 		if (!dma_stat) {
 			__ide_end_request(drive, rq, 1, rq->nr_sectors);
 			return ide_stopped;
@@ -50,7 +49,7 @@
 		printk(KERN_ERR "%s: dma_intr: bad DMA status (dma_stat=%x)\n",
 		       drive->name, dma_stat);
 	}
-	return ide_error(drive, rq, "dma_intr", stat);
+	return ide_error(drive, rq, "dma_intr", drive->status);
 }
 
 /*
@@ -130,8 +129,8 @@
 #endif
 
 	if (dma_stat & 2) {	/* ERROR */
-		u8 stat = GET_STAT();
-		return ide_error(drive, rq, "dma_timer_expiry", stat);
+		ata_status(drive, 0, 0);
+		return ide_error(drive, rq, "dma_timer_expiry", drive->status);
 	}
 	if (dma_stat & 1)	/* DMAing */
 		return WAIT_CMD;
diff -urN linux-2.5.19/drivers/ide/pdc4030.c linux/drivers/ide/pdc4030.c
--- linux-2.5.19/drivers/ide/pdc4030.c	2002-05-29 20:42:49.000000000 +0200
+++ linux/drivers/ide/pdc4030.c	2002-05-31 19:55:22.000000000 +0200
@@ -373,15 +373,13 @@
  */
 static ide_startstop_t promise_read_intr(struct ata_device *drive, struct request *rq)
 {
-	u8 stat;
 	int total_remaining;
 	unsigned int sectors_left, sectors_avail, nsect;
 	unsigned long flags;
 	char *to;
 
-	if (!OK_STAT(stat=GET_STAT(),DATA_READY,BAD_R_STAT)) {
-		return ide_error(drive, rq, "promise_read_intr", stat);
-	}
+	if (!ata_status(drive, DATA_READY, BAD_R_STAT))
+		return ide_error(drive, rq, "promise_read_intr", drive->status);
 
 read_again:
 	do {
@@ -427,10 +425,10 @@
 	if (total_remaining > 0) {
 		if (sectors_avail)
 			goto read_next;
-		stat = GET_STAT();
-		if (stat & DRQ_STAT)
+		ata_status(drive, 0, 0);
+		if (drive->status & DRQ_STAT)
 			goto read_again;
-		if (stat & BUSY_STAT) {
+		if (drive->status & BUSY_STAT) {
 			ide_set_handler(drive, promise_read_intr, WAIT_CMD, NULL);
 #ifdef DEBUG_READ
 			printk(KERN_DEBUG "%s: promise_read: waiting for"
@@ -440,7 +438,7 @@
 		}
 		printk(KERN_ERR "%s: Eeek! promise_read_intr: sectors left "
 		       "!DRQ !BUSY\n", drive->name);
-		return ide_error(drive, rq, "promise read intr", stat);
+		return ide_error(drive, rq, "promise read intr", drive->status);
 	}
 	return ide_stopped;
 }
@@ -457,7 +455,7 @@
 {
 	struct ata_channel *ch = drive->channel;
 
-	if (GET_STAT() & BUSY_STAT) {
+	if (!ata_status(drive, 0, BUSY_STAT)) {
 		if (time_before(jiffies, ch->poll_timeout)) {
 			ide_set_handler(drive, promise_complete_pollfunc, HZ/100, NULL);
 			return ide_started; /* continue polling... */
@@ -465,7 +463,7 @@
 		ch->poll_timeout = 0;
 		printk(KERN_ERR "%s: completion timeout - still busy!\n",
 		       drive->name);
-		return ide_error(drive, rq, "busy timeout", GET_STAT());
+		return ide_error(drive, rq, "busy timeout", drive->status);
 	}
 
 	ch->poll_timeout = 0;
@@ -543,7 +541,8 @@
 		}
 		ch->poll_timeout = 0;
 		printk(KERN_ERR "%s: write timed out!\n",drive->name);
-		return ide_error(drive, rq, "write timeout", GET_STAT());
+		ata_status(drive, 0, 0);
+		return ide_error(drive, rq, "write timeout", drive->status);
 	}
 
 	/*
@@ -554,7 +553,7 @@
 	ide_set_handler(drive, promise_complete_pollfunc, HZ/100, NULL);
 #ifdef DEBUG_WRITE
 	printk(KERN_DEBUG "%s: Done last 4 sectors - status = %02x\n",
-		drive->name, GET_STAT());
+		drive->name, drive->status);
 #endif
 	return ide_started;
 }
@@ -597,7 +596,7 @@
 		ide_set_handler(drive, promise_complete_pollfunc, HZ/100, NULL);
 #ifdef DEBUG_WRITE
 		printk(KERN_DEBUG "%s: promise_write: <= 4 sectors, "
-			"status = %02x\n", drive->name, GET_STAT());
+			"status = %02x\n", drive->name, drive->status);
 #endif
 		return ide_started;
 	}
@@ -612,7 +611,6 @@
 {
 	struct hd_drive_task_hdr *taskfile = &(args->taskfile);
 	unsigned long timeout;
-	byte stat;
 
 	/* Check that it's a regular command. If not, bomb out early. */
 	if (!(rq->flags & REQ_CMD)) {
@@ -623,7 +621,7 @@
 
 	if (IDE_CONTROL_REG)
 		outb(drive->ctl, IDE_CONTROL_REG);  /* clear nIEN */
-	SELECT_MASK(drive->channel, drive, 0);
+	ata_mask(drive);
 
 	outb(taskfile->feature, IDE_FEATURE_REG);
 	outb(taskfile->sector_count, IDE_NSECTOR_REG);
@@ -649,8 +647,7 @@
  */
 		timeout = jiffies + HZ/20; /* 50ms wait */
 		do {
-			stat=GET_STAT();
-			if (stat & DRQ_STAT) {
+			if (!ata_status(drive, 0, DRQ_STAT)) {
 				udelay(1);
 				return promise_read_intr(drive, rq);
 			}
diff -urN linux-2.5.19/drivers/ide/probe.c linux/drivers/ide/probe.c
--- linux-2.5.19/drivers/ide/probe.c	2002-05-31 19:30:47.000000000 +0200
+++ linux/drivers/ide/probe.c	2002-05-31 20:56:53.000000000 +0200
@@ -295,11 +295,10 @@
 	struct ata_channel *hwif = drive->channel;
 	int i;
 	int error = 1;
-	u8 stat;
 
 #if defined(CONFIG_BLK_DEV_IDEDMA) && !defined(__CRIS__)
 	u8 unit = (drive->select.b.unit & 0x01);
-	outb(inb(hwif->dma_base+2) & ~(1<<(5+unit)), hwif->dma_base+2);
+	outb(inb(hwif->dma_base + 2) & ~(1 << (5 + unit)), hwif->dma_base + 2);
 #endif
 
 	/*
@@ -312,8 +311,8 @@
          */
 	disable_irq(hwif->irq);	/* disable_irq_nosync ?? */
 	udelay(1);
-	SELECT_DRIVE(drive->channel, drive);
-	SELECT_MASK(drive->channel, drive, 0);
+	ata_select(drive, 0);
+	ata_mask(drive);
 	udelay(1);
 	if (IDE_CONTROL_REG)
 		OUT_BYTE(drive->ctl | 2, IDE_CONTROL_REG);
@@ -327,12 +326,12 @@
 	/*
 	 * Wait for drive to become non-BUSY
 	 */
-	if ((stat = GET_STAT()) & BUSY_STAT) {
+	if (!ata_status(drive, 0, BUSY_STAT)) {
 		unsigned long flags, timeout;
 		__save_flags(flags);	/* local CPU only */
 		ide__sti();		/* local CPU only -- for jiffies */
 		timeout = jiffies + WAIT_CMD;
-		while ((stat = GET_STAT()) & BUSY_STAT) {
+		while (!ata_status(drive, 0, BUSY_STAT)) {
 			if (time_after(jiffies, timeout))
 				break;
 		}
@@ -348,18 +347,18 @@
 	 */
 	for (i = 0; i < 10; i++) {
 		udelay(1);
-		if (OK_STAT((stat = GET_STAT()), DRIVE_READY, BUSY_STAT|DRQ_STAT|ERR_STAT)) {
+		if (ata_status(drive, DRIVE_READY, BUSY_STAT | DRQ_STAT | ERR_STAT)) {
 			error = 0;
 			break;
 		}
 	}
 
-	SELECT_MASK(drive->channel, drive, 0);
+	ata_mask(drive);
 
 	enable_irq(hwif->irq);
 
 	if (error) {
-		ide_dump_status(drive, NULL, "set_drive_speed_status", stat);
+		ide_dump_status(drive, NULL, "set_drive_speed_status", drive->status);
 		return error;
 	}
 
@@ -623,22 +622,23 @@
 
 	mdelay(50);		/* wait for IRQ and DRQ_STAT */
 
-	if (OK_STAT(GET_STAT(),DRQ_STAT,BAD_R_STAT)) {
+	if (ata_status(drive, DRQ_STAT, BAD_R_STAT)) {
 		unsigned long flags;
-		__save_flags(flags);	/* local CPU only */
-		__cli();		/* local CPU only; some systems need this */
-		do_identify(drive, cmd); /* drive returned ID */
-		rc = 0;			/* drive responded with ID */
-		(void) GET_STAT();	/* clear drive IRQ */
-		__restore_flags(flags);	/* local CPU only */
+		__save_flags(flags);		/* local CPU only */
+		__cli();			/* local CPU only; some systems need this */
+		do_identify(drive, cmd);	/* drive returned ID */
+		rc = 0;				/* drive responded with ID */
+		ata_status(drive, 0, 0);	/* clear drive IRQ */
+		__restore_flags(flags);		/* local CPU only */
 	} else
 		rc = 2;			/* drive refused ID */
 
 out:
 	if (autoprobe) {
 		int irq;
+
 		OUT_BYTE(drive->ctl | 0x02, IDE_CONTROL_REG);	/* mask device irq */
-		GET_STAT();			/* clear drive IRQ */
+		ata_status(drive, 0, 0);			/* clear drive IRQ */
 		udelay(5);
 		irq = probe_irq_off(cookie);
 		if (!drive->channel->irq) {
@@ -684,43 +684,41 @@
 		(cmd == WIN_IDENTIFY) ? "ATA" : "ATAPI");
 #endif
 	mdelay(50);	/* needed for some systems (e.g. crw9624 as drive0 with disk as slave) */
-	SELECT_DRIVE(ch, drive);
-	mdelay(50);
+	ata_select(drive, 50000);
 	select = IN_BYTE(IDE_SELECT_REG);
 	if (select != drive->select.all && !drive->present) {
 		if (drive->select.b.unit != 0) {
-			SELECT_DRIVE(ch, &ch->drives[0]);	/* exit with drive0 selected */
-			mdelay(50);		/* allow BUSY_STAT to assert & clear */
+			ata_select(&ch->drives[0], 50000);	/* exit with drive0 selected */
 		}
 		return 3;    /* no i/f present: mmm.. this should be a 4 -ml */
 	}
 
-	if (OK_STAT(GET_STAT(), READY_STAT, BUSY_STAT) || drive->present || cmd == WIN_PIDENTIFY)
-	{
+	if (ata_status(drive, READY_STAT, BUSY_STAT) || drive->present || cmd == WIN_PIDENTIFY)	{
 		if ((rc = identify(drive,cmd)))   /* send cmd and wait */
 			rc = identify(drive,cmd); /* failed: try again */
 		if (rc == 1 && cmd == WIN_PIDENTIFY && drive->autotune != 2) {
 			unsigned long timeout;
-			printk("%s: no response (status = 0x%02x), resetting drive\n", drive->name, GET_STAT());
+			printk("%s: no response (status = 0x%02x), resetting drive\n",
+					drive->name, drive->status);
 			mdelay(50);
-			OUT_BYTE (drive->select.all, IDE_SELECT_REG);
+			OUT_BYTE(drive->select.all, IDE_SELECT_REG);
 			mdelay(50);
 			OUT_BYTE(WIN_SRST, IDE_COMMAND_REG);
 			timeout = jiffies;
-			while ((GET_STAT() & BUSY_STAT) && time_before(jiffies, timeout + WAIT_WORSTCASE))
+			while (!ata_status(drive, 0, BUSY_STAT) && time_before(jiffies, timeout + WAIT_WORSTCASE))
 				mdelay(50);
 			rc = identify(drive, cmd);
 		}
 		if (rc == 1)
-			printk("%s: no response (status = 0x%02x)\n", drive->name, GET_STAT());
-		GET_STAT();		/* ensure drive irq is clear */
+			printk("%s: no response (status = 0x%02x)\n",
+					drive->name, drive->status);
+		ata_status(drive, 0, 0);	/* ensure drive irq is clear */
 	} else
 		rc = 3;				/* not present or maybe ATAPI */
 
 	if (drive->select.b.unit != 0) {
-		SELECT_DRIVE(ch, &ch->drives[0]);	/* exit with drive0 selected */
-		mdelay(50);
-		GET_STAT();		/* ensure drive irq is clear */
+		ata_select(&ch->drives[0], 50000);	/* exit with drive0 selected */
+		ata_status(drive, 0, 0);		/* ensure drive irq is clear */
 	}
 
 	return rc;
@@ -764,8 +762,7 @@
 			unsigned long timeout;
 
 			printk("%s: enabling %s -- ", drive->channel->name, drive->id->model);
-			SELECT_DRIVE(drive->channel, drive);
-			mdelay(50);
+			ata_select(drive, 50000);
 			OUT_BYTE(EXABYTE_ENABLE_NEST, IDE_COMMAND_REG);
 			timeout = jiffies + WAIT_WORSTCASE;
 			do {
@@ -774,10 +771,10 @@
 					return;
 				}
 				mdelay(50);
-			} while (GET_STAT() & BUSY_STAT);
+			} while (!ata_status(drive, 0, BUSY_STAT));
 			mdelay(50);
-			if (!OK_STAT(GET_STAT(), 0, BAD_STAT))
-				printk("failed (status = 0x%02x)\n", GET_STAT());
+			if (!ata_status(drive, 0, BAD_STAT))
+				printk("failed (status = 0x%02x)\n", drive->status);
 			else
 				printk("success\n");
 
diff -urN linux-2.5.19/drivers/ide/tcq.c linux/drivers/ide/tcq.c
--- linux-2.5.19/drivers/ide/tcq.c	2002-05-29 20:42:57.000000000 +0200
+++ linux/drivers/ide/tcq.c	2002-05-31 20:02:21.000000000 +0200
@@ -71,8 +71,9 @@
 	struct ata_taskfile *args = rq->special;
 
 	ide__sti();
-	ide_end_drive_cmd(drive, rq, GET_STAT(), GET_ERR());
+	ide_end_drive_cmd(drive, rq, GET_ERR());
 	kfree(args);
+
 	return ide_stopped;
 }
 
@@ -169,7 +170,7 @@
 	/*
 	 * if pending commands, try service before giving up
 	 */
-	if (ata_pending_commands(drive) && (GET_STAT() & SERVICE_STAT))
+	if (ata_pending_commands(drive) && !ata_status(drive, 0, SERVICE_STAT))
 		if (service(drive, drive->rq) == ide_started)
 			return;
 
@@ -246,10 +247,8 @@
 	/*
 	 * need to select the right drive first...
 	 */
-	if (drive != drive->channel->drive) {
-		SELECT_DRIVE(drive->channel, drive);
-		udelay(10);
-	}
+	if (drive != drive->channel->drive)
+		ata_select(drive, 10);
 
 	drive_ctl_nien(drive, 1);
 
@@ -309,14 +308,12 @@
 
 static ide_startstop_t check_service(struct ata_device *drive, struct request *rq)
 {
-	u8 stat;
-
 	TCQ_PRINTK("%s: %s\n", drive->name, __FUNCTION__);
 
 	if (!ata_pending_commands(drive))
 		return ide_stopped;
 
-	if ((stat = GET_STAT()) & SERVICE_STAT)
+	if (!ata_status(drive, 0, SERVICE_STAT))
 		return service(drive, rq);
 
 	/*
@@ -327,7 +324,7 @@
 	return ide_started;
 }
 
-ide_startstop_t ide_dmaq_complete(struct ata_device *drive, struct request *rq, u8 stat)
+static ide_startstop_t dmaq_complete(struct ata_device *drive, struct request *rq)
 {
 	u8 dma_stat;
 
@@ -339,9 +336,9 @@
 	/*
 	 * must be end of I/O, check status and complete as necessary
 	 */
-	if (unlikely(!OK_STAT(stat, READY_STAT, drive->bad_wstat | DRQ_STAT))) {
-		printk(KERN_ERR "%s: %s: error status %x\n", __FUNCTION__, drive->name,stat);
-		ide_dump_status(drive, rq, __FUNCTION__, stat);
+	if (!ata_status(drive, READY_STAT, drive->bad_wstat | DRQ_STAT)) {
+		printk(KERN_ERR "%s: %s: error status %x\n", __FUNCTION__, drive->name, drive->status);
+		ide_dump_status(drive, rq, __FUNCTION__, drive->status);
 		tcq_invalidate_queue(drive);
 
 		return ide_stopped;
@@ -360,7 +357,7 @@
 }
 
 /*
- * intr handler for queued dma operations. this can be entered for two
+ * Interrupt handler for queued dma operations. this can be entered for two
  * reasons:
  *
  * 1) device has completed dma transfer
@@ -371,26 +368,28 @@
  */
 static ide_startstop_t ide_dmaq_intr(struct ata_device *drive, struct request *rq)
 {
-	u8 stat = GET_STAT();
+	int ok;
 
-	TCQ_PRINTK("%s: stat=%x\n", __FUNCTION__, stat);
+	ok = !ata_status(drive, 0, SERVICE_STAT);
+	TCQ_PRINTK("%s: stat=%x\n", __FUNCTION__, drive->status);
 
 	/*
-	 * if a command completion interrupt is pending, do that first and
-	 * check service afterwards
+	 * If a command completion interrupt is pending, do that first and
+	 * check service afterwards.
 	 */
 	if (rq)
-		return ide_dmaq_complete(drive, rq, stat);
+		return dmaq_complete(drive, rq);
 
 	/*
 	 * service interrupt
 	 */
-	if (stat & SERVICE_STAT) {
-		TCQ_PRINTK("%s: SERV (stat=%x)\n", __FUNCTION__, stat);
+	if (ok) {
+		TCQ_PRINTK("%s: SERV (stat=%x)\n", __FUNCTION__, drive->status);
 		return service(drive, rq);
 	}
 
-	printk("%s: stat=%x, not expected\n", __FUNCTION__, stat);
+	printk("%s: stat=%x, not expected\n", __FUNCTION__, drive->status);
+
 	return check_service(drive, rq);
 }
 
@@ -494,19 +493,19 @@
 
 static int tcq_wait_dataphase(struct ata_device *drive)
 {
-	u8 stat;
 	int i;
 
-	while ((stat = GET_STAT()) & BUSY_STAT)
+	while (!ata_status(drive, 0, BUSY_STAT))
 		udelay(10);
 
-	if (OK_STAT(stat, READY_STAT | DRQ_STAT, drive->bad_wstat))
+	if (ata_status(drive, READY_STAT | DRQ_STAT, drive->bad_wstat))
 		return 0;
 
 	i = 0;
 	udelay(1);
-	while (!OK_STAT(GET_STAT(), READY_STAT | DRQ_STAT, drive->bad_wstat)) {
-		if (unlikely(i++ > IDE_TCQ_WAIT))
+	while (!ata_status(drive, READY_STAT | DRQ_STAT, drive->bad_wstat)) {
+		++i;
+		if (i > IDE_TCQ_WAIT)
 			return 1;
 
 		udelay(10);
@@ -588,7 +587,7 @@
 
 		TCQ_PRINTK("REL in queued_start\n");
 
-		if ((stat = GET_STAT()) & SERVICE_STAT)
+		if (!ata_status(drive, 0, SERVICE_STAT))
 			return service(drive, rq);
 
 		return ide_released;
diff -urN linux-2.5.19/drivers/scsi/ide-scsi.c linux/drivers/scsi/ide-scsi.c
--- linux-2.5.19/drivers/scsi/ide-scsi.c	2002-05-31 19:30:47.000000000 +0200
+++ linux/drivers/scsi/ide-scsi.c	2002-05-31 20:03:34.000000000 +0200
@@ -242,7 +242,7 @@
 		ide_end_request(drive, rq, uptodate);
 		return 0;
 	}
-	ide_end_drive_cmd(drive, rq, 0, 0);
+	ide_end_drive_cmd(drive, rq, 0);
 	if (rq->errors >= ERROR_MAX) {
 		pc->s.scsi_cmd->result = DID_ERROR << 16;
 		if (log)
@@ -286,7 +286,7 @@
 {
 	struct Scsi_Host *host = drive->driver_data;
 	idescsi_scsi_t *scsi = (idescsi_scsi_t *) host->hostdata[0];
-	byte status, ireason;
+	u8 ireason;
 	int bcount;
 	struct atapi_packet_command *pc=scsi->pc;
 	unsigned int temp;
@@ -303,13 +303,12 @@
 		udma_stop(drive);
 	}
 
-	status = GET_STAT();						/* Clear the interrupt */
-
-	if ((status & DRQ_STAT) == 0) {					/* No more interrupts */
+	/* Clear the interrupt */
+	if (ata_status(drive, 0, DRQ_STAT)) {	/* No more interrupts */
 		if (test_bit(IDESCSI_LOG_CMD, &scsi->log))
 			printk (KERN_INFO "Packet command completed, %d bytes transferred\n", pc->actually_transferred);
 		ide__sti();
-		if (status & ERR_STAT)
+		if (drive->status & ERR_STAT)
 			rq->errors++;
 		idescsi_end_request(drive, rq, 1);
 		return ide_stopped;
@@ -411,7 +410,7 @@
 			dma_ok = !udma_read(drive, rq);
 	}
 
-	SELECT_DRIVE(drive->channel, drive);
+	ata_select(drive, 10);
 	if (IDE_CONTROL_REG)
 		OUT_BYTE (drive->ctl,IDE_CONTROL_REG);
 	OUT_BYTE (dma_ok,IDE_FEATURE_REG);
diff -urN linux-2.5.19/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.19/include/linux/ide.h	2002-05-29 20:42:48.000000000 +0200
+++ linux/include/linux/ide.h	2002-05-31 19:17:19.000000000 +0200
@@ -112,8 +112,6 @@
 #define GET_ALTSTAT()		IN_BYTE(IDE_CONTROL_REG)
 #define GET_FEAT()		IN_BYTE(IDE_NSECTOR_REG)
 
-#define OK_STAT(stat,good,bad)	(((stat)&((good)|(bad)))==(good))
-
 #define BAD_R_STAT		(BUSY_STAT   | ERR_STAT)
 #define BAD_W_STAT		(BAD_R_STAT  | WRERR_STAT)
 #define BAD_STAT		(BAD_R_STAT  | DRQ_STAT)
@@ -157,19 +155,6 @@
 #define WAIT_CMD	(10*HZ)		/* 10sec  - maximum wait for an IRQ to happen */
 #define WAIT_MIN_SLEEP	(2*HZ/100)	/* 20msec - minimum sleep time */
 
-#define SELECT_DRIVE(channel, drive)				\
-{								\
-	if (channel->selectproc)				\
-		channel->selectproc(drive);			\
-	OUT_BYTE((drive)->select.all, channel->io_ports[IDE_SELECT_OFFSET]); \
-}
-
-#define SELECT_MASK(channel, drive, mask)			\
-{								\
-	if (channel->maskproc)					\
-		channel->maskproc(drive,mask);			\
-}
-
 /*
  * Check for an interrupt and acknowledge the interrupt status
  */
@@ -359,8 +344,12 @@
 	unsigned ata_flash	: 1;	/* 1=present, 0=default */
 	unsigned	addressing;	/* : 2; 0=28-bit, 1=48-bit, 2=64-bit */
 	byte		scsi;		/* 0=default, 1=skip current ide-subdriver for ide-scsi emulation */
+
 	select_t	select;		/* basic drive/head select reg value */
-	byte		ctl;		/* "normal" value for IDE_CONTROL_REG */
+
+	u8		ctl;		/* "normal" value for IDE_CONTROL_REG */
+	u8		status;		/* last retrived status value for device */
+
 	byte		ready_stat;	/* min status value for drive ready */
 	byte		mult_count;	/* current multiple sector setting */
 	byte		bad_wstat;	/* used for ignoring WRERR_STAT */
@@ -485,7 +474,7 @@
 	void (*intrproc) (struct ata_device *);
 
 	/* special host masking for drive selection */
-	void (*maskproc) (struct ata_device *, int);
+	void (*maskproc) (struct ata_device *);
 
 	/* check host's drive quirk list */
 	int (*quirkproc) (struct ata_device *);
@@ -730,7 +719,7 @@
 /*
  * Clean up after success/failure of an explicit drive cmd.
  */
-extern void ide_end_drive_cmd(struct ata_device *, struct request *, u8, u8);
+extern void ide_end_drive_cmd(struct ata_device *, struct request *, u8);
 
 struct ata_taskfile {
 	struct hd_drive_task_hdr taskfile;
@@ -902,4 +891,10 @@
 
 extern int drive_is_ready(struct ata_device *drive);
 
+/* Low level device access functions. */
+
+extern void ata_select(struct ata_device *, unsigned long);
+extern void ata_mask(struct ata_device *);
+extern int ata_status(struct ata_device *, u8, u8);
+
 #endif

--------------040501080305030102060402--

