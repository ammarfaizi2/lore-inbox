Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313124AbSC1Jdq>; Thu, 28 Mar 2002 04:33:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313119AbSC1Jdc>; Thu, 28 Mar 2002 04:33:32 -0500
Received: from [195.63.194.11] ([195.63.194.11]:26635 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313118AbSC1Jcx>; Thu, 28 Mar 2002 04:32:53 -0500
Message-ID: <3CA2E2E4.4070603@evision-ventures.com>
Date: Thu, 28 Mar 2002 10:31:16 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.7 IDE 27
In-Reply-To: <Pine.LNX.4.33.0203181243210.10517-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------090106010902000409040406"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090106010902000409040406
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Thu Mar 21 03:17:48 CET 2002 ide-clean-27

- Make for less terse error messages in ide-tape.c.

- Replaced all timecomparisions done by hand with all the proper timer_after()
   commands.

- Remove the drive niec1 mechanisms alltogether. There are several reasons for
   this:

   1. The code implementing it is nonintelliglible and therefore propably
   broken.

   2. If we have to invent somethig about sceduling drive IO, it should be done
   on the BIO level.

   3. We may in fact interleave with the IO sceduling on the upper layers and
   the results of two overlapping signal filters overlapped with each other can
   be disasterous to the overall throughput. (In fact they *are* most of the
   time.)

   4. It was not working if you had intermixed modes on different drives
   DMA versus PIO.

   5. Our goal is to have a driver which is able to share the badwidth
   properly and shouldn't needing this kind of "tuning".

- Remove unused nice2 from disk struct.

- Rename channel member of ata_channel to unit and device to dev to
   just prevent wrong interpretations. This prevents constructs like
   channel->channel...

--------------090106010902000409040406
Content-Type: text/plain;
 name="ide-clean-27.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-27.diff"

diff -urN linux-2.5.7/drivers/ide/aec62xx.c linux/drivers/ide/aec62xx.c
--- linux-2.5.7/drivers/ide/aec62xx.c	Thu Mar 21 23:54:16 2002
+++ linux/drivers/ide/aec62xx.c	Fri Mar 22 02:05:36 2002
@@ -259,7 +259,7 @@
 	struct ata_channel *hwif = drive->channel;
 	struct pci_dev *dev	= hwif->pci_dev;
 	byte unit		= (drive->select.b.unit & 0x01);
-	byte ultra_pci		= hwif->channel ? 0x45 : 0x44;
+	byte ultra_pci		= hwif->unit ? 0x45 : 0x44;
 	int err			= 0;
 	byte drive_conf		= 0x00;
 	byte ultra_conf		= 0x00;
@@ -532,7 +532,7 @@
 
 unsigned int __init ata66_aec62xx(struct ata_channel *hwif)
 {
-	byte mask	= hwif->channel ? 0x02 : 0x01;
+	byte mask	= hwif->unit ? 0x02 : 0x01;
 	byte ata66	= 0;
 
 	pci_read_config_byte(hwif->pci_dev, 0x49, &ata66);
@@ -565,7 +565,7 @@
 	__cli();		/* local CPU only */
 
 	pci_read_config_byte(hwif->pci_dev, 0x54, &reg54h);
-	pci_write_config_byte(hwif->pci_dev, 0x54, reg54h & ~(hwif->channel ? 0xF0 : 0x0F));
+	pci_write_config_byte(hwif->pci_dev, 0x54, reg54h & ~(hwif->unit ? 0xF0 : 0x0F));
 
 	__restore_flags(flags);	/* local CPU only */
 #endif /* CONFIG_AEC62XX_TUNING */
diff -urN linux-2.5.7/drivers/ide/ali14xx.c linux/drivers/ide/ali14xx.c
--- linux-2.5.7/drivers/ide/ali14xx.c	Thu Mar 21 23:54:16 2002
+++ linux/drivers/ide/ali14xx.c	Fri Mar 22 02:06:01 2002
@@ -214,7 +214,7 @@
 	ide_hwifs[1].tuneproc = &ali14xx_tune_drive;
 	ide_hwifs[0].mate = &ide_hwifs[1];
 	ide_hwifs[1].mate = &ide_hwifs[0];
-	ide_hwifs[1].channel = 1;
+	ide_hwifs[1].unit = 1;
 
 	/* initialize controller registers */
 	if (!initRegisters()) {
diff -urN linux-2.5.7/drivers/ide/alim15x3.c linux/drivers/ide/alim15x3.c
--- linux-2.5.7/drivers/ide/alim15x3.c	Thu Mar 21 23:54:16 2002
+++ linux/drivers/ide/alim15x3.c	Fri Mar 22 02:08:58 2002
@@ -247,8 +247,8 @@
 	int s_time, a_time, c_time;
 	byte s_clc, a_clc, r_clc;
 	unsigned long flags;
-	int port = hwif->index ? 0x5c : 0x58;
-	int portFIFO = hwif->channel ? 0x55 : 0x54;
+	int port = hwif->unit ? 0x5c : 0x58;
+	int portFIFO = hwif->unit ? 0x55 : 0x54;
 	byte cd_dma_fifo = 0;
 
 	if (pio == 255)
@@ -309,7 +309,7 @@
 	struct pci_dev *dev	= hwif->pci_dev;
 	byte unit		= (drive->select.b.unit & 0x01);
 	byte tmpbyte		= 0x00;
-	int m5229_udma		= hwif->channel? 0x57 : 0x56;
+	int m5229_udma		= hwif->unit ? 0x57 : 0x56;
 	int err			= 0;
 
 	if (speed < XFER_UDMA_0) {
@@ -597,7 +597,7 @@
 		/*
 		 * Allow ata66 if cable of current channel has 80 pins
 		 */
-		ata66 = (hwif->channel)?cable_80_pin[1]:cable_80_pin[0];
+		ata66 = (hwif->unit)?cable_80_pin[1]:cable_80_pin[0];
 	} else {
 		/*
 		 * revision 0x20 (1543-E, 1543-F)
@@ -639,7 +639,7 @@
 	byte irq_routing_table[] = { -1,  9, 3, 10, 4,  5, 7,  6,
 				      1, 11, 0, 12, 0, 14, 0, 15 };
 
-	hwif->irq = hwif->channel ? 15 : 14;
+	hwif->irq = hwif->unit ? 15 : 14;
 
 	if (isa_dev) {
 		/*
@@ -651,14 +651,14 @@
 		ideic = ideic & 0x03;
 
 		/* get IRQ for IDE Controller */
-		if ((hwif->channel && ideic == 0x03) || (!hwif->channel && !ideic)) {
+		if ((hwif->unit && ideic == 0x03) || (!hwif->unit && !ideic)) {
 			/*
 			 * get SIRQ1 routing table
 			 */
 			pci_read_config_byte(isa_dev, 0x44, &inmir);
 			inmir = inmir & 0x0f;
 			hwif->irq = irq_routing_table[inmir];
-		} else if (hwif->channel && !(ideic & 0x01)) {
+		} else if (hwif->unit && !(ideic & 0x01)) {
 			/*
 			 * get SIRQ2 routing table
 			 */
diff -urN linux-2.5.7/drivers/ide/amd74xx.c linux/drivers/ide/amd74xx.c
--- linux-2.5.7/drivers/ide/amd74xx.c	Thu Mar 21 23:54:16 2002
+++ linux/drivers/ide/amd74xx.c	Fri Mar 22 02:10:04 2002
@@ -263,7 +263,7 @@
 
 static void amd74xx_tune_drive(ide_drive_t *drive, unsigned char pio)
 {
-	if (!((amd_enabled >> drive->channel->channel) & 1))
+	if (!((amd_enabled >> drive->channel->unit) & 1))
 		return;
 
 	if (pio == 255) {
@@ -411,7 +411,7 @@
 
 unsigned int __init ata66_amd74xx(struct ata_channel *hwif)
 {
-	return ((amd_enabled & amd_80w) >> hwif->channel) & 1;
+	return ((amd_enabled & amd_80w) >> hwif->unit) & 1;
 }
 
 void __init ide_init_amd74xx(struct ata_channel *hwif)
@@ -426,7 +426,7 @@
 		hwif->drives[i].io_32bit = 1;
 		hwif->drives[i].unmask = 1;
 		hwif->drives[i].autotune = 1;
-		hwif->drives[i].dn = hwif->channel * 2 + i;
+		hwif->drives[i].dn = hwif->unit * 2 + i;
 	}
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
@@ -447,6 +447,6 @@
 
 void __init ide_dmacapable_amd74xx(struct ata_channel *hwif, unsigned long dmabase)
 {
-	if ((amd_enabled >> hwif->channel) & 1)
+	if ((amd_enabled >> hwif->unit) & 1)
 		ide_setup_dma(hwif, dmabase, 8);
 }
diff -urN linux-2.5.7/drivers/ide/cmd640.c linux/drivers/ide/cmd640.c
--- linux-2.5.7/drivers/ide/cmd640.c	Thu Mar 21 23:54:17 2002
+++ linux/drivers/ide/cmd640.c	Fri Mar 22 02:10:32 2002
@@ -795,7 +795,7 @@
 		cmd_hwif1->chipset = ide_cmd640;
 		cmd_hwif0->mate = cmd_hwif1;
 		cmd_hwif1->mate = cmd_hwif0;
-		cmd_hwif1->channel = 1;
+		cmd_hwif1->unit = 1;
 #ifdef CONFIG_BLK_DEV_CMD640_ENHANCED
 		cmd_hwif1->tuneproc = &cmd640_tune_drive;
 #endif /* CONFIG_BLK_DEV_CMD640_ENHANCED */
diff -urN linux-2.5.7/drivers/ide/cmd64x.c linux/drivers/ide/cmd64x.c
--- linux-2.5.7/drivers/ide/cmd64x.c	Thu Mar 21 23:54:17 2002
+++ linux/drivers/ide/cmd64x.c	Fri Mar 22 02:35:41 2002
@@ -224,7 +224,7 @@
 			{ DRWTIM0, DRWTIM1 },
 			{ DRWTIM2, DRWTIM3 }
 		};
-	int channel = (int) drive->channel->channel;
+	int channel = drive->channel->unit;
 	int slave = (drives != drive);  /* Is this really the best way to determine this?? */
 
 	cmdprintk("program_drive_count parameters = s(%d),a(%d),r(%d),p(%d)\n", setup_count,
@@ -336,7 +336,7 @@
 static byte cmd680_taskfile_timing(struct ata_channel *hwif)
 {
 	struct pci_dev *dev	= hwif->pci_dev;
-	byte addr_mask		= (hwif->channel) ? 0xB2 : 0xA2;
+	byte addr_mask		= (hwif->unit) ? 0xB2 : 0xA2;
 	unsigned short		timing;
 
 	pci_read_config_word(dev, addr_mask, &timing);
@@ -397,7 +397,7 @@
 	struct ata_channel *hwif = drive->channel;
 	struct pci_dev *dev	= hwif->pci_dev;
 	u8 unit			= (drive->select.b.unit & 0x01);
-	u8 addr_mask		= (hwif->channel) ? 0x84 : 0x80;
+	u8 addr_mask		= (hwif->unit) ? 0x84 : 0x80;
 	u8 speed		= 0x00;
 	u8 mode_pci		= 0x00;
 	u8 channel_timings	= cmd680_taskfile_timing(hwif);
@@ -435,8 +435,8 @@
 	int err			= 0;
 
 	u8 unit			= (drive->select.b.unit & 0x01);
-	u8 pciU			= (hwif->channel) ? UDIDETCR1 : UDIDETCR0;
-	u8 pciD			= (hwif->channel) ? BMIDESR1 : BMIDESR0;
+	u8 pciU			= (hwif->unit) ? UDIDETCR1 : UDIDETCR0;
+	u8 pciD			= (hwif->unit) ? BMIDESR1 : BMIDESR0;
 	u8 regU			= 0;
 	u8 regD			= 0;
 
@@ -500,7 +500,7 @@
 {
 	struct ata_channel *hwif = drive->channel;
 	struct pci_dev *dev	= hwif->pci_dev;
-	u8 addr_mask		= (hwif->channel) ? 0x84 : 0x80;
+	u8 addr_mask		= (hwif->unit) ? 0x84 : 0x80;
 	u8 unit			= (drive->select.b.unit & 0x01);
 	u8 dma_pci		= 0;
 	u8 udma_pci		= 0;
@@ -841,7 +841,7 @@
 {
 	byte dma_stat		= 0;
 	byte dma_alt_stat	= 0;
-	byte mask		= (drive->channel->channel) ? MRDMODE_INTR_CH1 : MRDMODE_INTR_CH0;
+	byte mask		= (drive->channel->unit) ? MRDMODE_INTR_CH1 : MRDMODE_INTR_CH0;
 	unsigned long dma_base	= drive->channel->dma_base;
 	struct pci_dev *dev	= drive->channel->pci_dev;
 	byte jack_slap		= ((dev->device == PCI_DEVICE_ID_CMD_648) || (dev->device == PCI_DEVICE_ID_CMD_649)) ? 1 : 0;
@@ -856,8 +856,8 @@
 			outb(dma_stat|6, dma_base+2);		/* clear the INTR & ERROR bits */
 			if (jack_slap) {
 				byte dma_intr	= 0;
-				byte dma_mask	= (drive->channel->channel) ? ARTTIM23_INTR_CH1 : CFR_INTR_CH0;
-				byte dma_reg	= (drive->channel->channel) ? ARTTIM2 : CFR;
+				byte dma_mask	= (drive->channel->unit) ? ARTTIM23_INTR_CH1 : CFR_INTR_CH0;
+				byte dma_reg	= (drive->channel->unit) ? ARTTIM2 : CFR;
 				(void) pci_read_config_byte(dev, dma_reg, &dma_intr);
 				/*
 				 * DAMN BMIDE is not connected to PCI space!
@@ -918,7 +918,7 @@
 {
 #if 0
 	struct ata_channel *hwif	= drive->channel;
-	u8 addr_mask		= (hwif->channel) ? 0xB0 : 0xA0;
+	u8 addr_mask		= (hwif->unit) ? 0xB0 : 0xA0;
 	u32 stat_config		= 0;
 
         pci_read_config_dword(hwif->pci_dev, addr_mask, &stat_config);
@@ -951,7 +951,7 @@
 {
 #if 0
 	struct ata_channel *hwif = drive->channel;
-	u8 addr_mask		= (hwif->channel) ? 0xB0 : 0xA0;
+	u8 addr_mask		= (hwif->unit) ? 0xB0 : 0xA0;
 	byte reset		= 0;
 
 	pci_read_config_byte(hwif->pci_dev, addr_mask, &reset);
@@ -1084,7 +1084,7 @@
 unsigned int cmd680_ata66(struct ata_channel *hwif)
 {
 	byte ata66	= 0;
-	byte addr_mask	= (hwif->channel) ? 0xB0 : 0xA0;
+	byte addr_mask	= (hwif->unit) ? 0xB0 : 0xA0;
 
 	pci_read_config_byte(hwif->pci_dev, addr_mask, &ata66);
 	return (ata66 & 0x01) ? 1 : 0;
@@ -1093,7 +1093,7 @@
 unsigned int cmd64x_ata66(struct ata_channel *hwif)
 {
 	byte ata66 = 0;
-	byte mask = (hwif->channel) ? 0x02 : 0x01;
+	byte mask = (hwif->unit) ? 0x02 : 0x01;
 
 	pci_read_config_byte(hwif->pci_dev, BMIDECSR, &ata66);
 	return (ata66 & mask) ? 1 : 0;
diff -urN linux-2.5.7/drivers/ide/cs5530.c linux/drivers/ide/cs5530.c
--- linux-2.5.7/drivers/ide/cs5530.c	Thu Mar 21 23:54:17 2002
+++ linux/drivers/ide/cs5530.c	Fri Mar 22 02:14:34 2002
@@ -101,7 +101,7 @@
  * After chip reset, the PIO timings are set to 0x0000e132, which is not valid.
  */
 #define CS5530_BAD_PIO(timings) (((timings)&~0x80000000)==0x0000e132)
-#define CS5530_BASEREG(hwif)	(((hwif)->dma_base & ~0xf) + ((hwif)->channel ? 0x30 : 0x20))
+#define CS5530_BASEREG(hwif)	(((hwif)->dma_base & ~0xf) + ((hwif)->unit ? 0x30 : 0x20))
 
 /*
  * cs5530_tuneproc() handles selection/setting of PIO modes
diff -urN linux-2.5.7/drivers/ide/cy82c693.c linux/drivers/ide/cy82c693.c
--- linux-2.5.7/drivers/ide/cy82c693.c	Thu Mar 21 23:54:17 2002
+++ linux/drivers/ide/cy82c693.c	Fri Mar 22 02:41:03 2002
@@ -192,7 +192,7 @@
 	if (mode > drive->id->tDMA)  /* to be absolutly sure we have a valid mode */
 		mode = drive->id->tDMA;
 	
-        index = (drive->channel->channel==0) ? CY82_INDEX_CHANNEL0 : CY82_INDEX_CHANNEL1;
+        index = (drive->channel->unit == 0) ? CY82_INDEX_CHANNEL0 : CY82_INDEX_CHANNEL1;
 
 #if CY82C693_DEBUG_LOGS
        	/* for debug let's show the previous values */
@@ -200,7 +200,7 @@
 	OUT_BYTE(index, CY82_INDEX_PORT);
 	data = IN_BYTE(CY82_DATA_PORT);
 
-	printk (KERN_INFO "%s (ch=%d, dev=%d): DMA mode is %d (single=%d)\n", drive->name, drive->channel->channel, drive->select.b.unit, (data&0x3), ((data>>2)&1));
+	printk (KERN_INFO "%s (ch=%d, dev=%d): DMA mode is %d (single=%d)\n", drive->name, drive->channel->unit, drive->select.b.unit, (data&0x3), ((data>>2)&1));
 #endif /* CY82C693_DEBUG_LOGS */
 
 	data = (byte)mode|(byte)(single<<2);
@@ -209,7 +209,7 @@
 	OUT_BYTE(data, CY82_DATA_PORT);
 
 #if CY82C693_DEBUG_INFO
-	printk (KERN_INFO "%s (ch=%d, dev=%d): set DMA mode to %d (single=%d)\n", drive->name, drive->channel->channel, drive->select.b.unit, mode, single);
+	printk (KERN_INFO "%s (ch=%d, dev=%d): set DMA mode to %d (single=%d)\n", drive->name, drive->channel->unit, drive->select.b.unit, mode, single);
 #endif /* CY82C693_DEBUG_INFO */
 
 	/* 
@@ -318,7 +318,7 @@
 		pci_read_config_byte(dev, CY82_IDE_SLAVE_8BIT, &pclk.time_8);
 	}
 
-	printk (KERN_INFO "%s (ch=%d, dev=%d): PIO timing is (addr=0x%X, ior=0x%X, iow=0x%X, 8bit=0x%X)\n", drive->name, hwif->channel, drive->select.b.unit, addrCtrl, pclk.time_16r, pclk.time_16w, pclk.time_8);
+	printk (KERN_INFO "%s (ch=%d, dev=%d): PIO timing is (addr=0x%X, ior=0x%X, iow=0x%X, 8bit=0x%X)\n", drive->name, hwif->unit, drive->select.b.unit, addrCtrl, pclk.time_16r, pclk.time_16w, pclk.time_8);
 #endif /* CY82C693_DEBUG_LOGS */
 
         /* first let's calc the pio modes */
@@ -371,7 +371,7 @@
 	}	
 
 #if CY82C693_DEBUG_INFO
-	printk (KERN_INFO "%s (ch=%d, dev=%d): set PIO timing to (addr=0x%X, ior=0x%X, iow=0x%X, 8bit=0x%X)\n", drive->name, hwif->channel, drive->select.b.unit, addrCtrl, pclk.time_16r, pclk.time_16w, pclk.time_8);
+	printk (KERN_INFO "%s (ch=%d, dev=%d): set PIO timing to (addr=0x%X, ior=0x%X, iow=0x%X, 8bit=0x%X)\n", drive->name, hwif->unit, drive->select.b.unit, addrCtrl, pclk.time_16r, pclk.time_16w, pclk.time_8);
 #endif /* CY82C693_DEBUG_INFO */
 }
 
diff -urN linux-2.5.7/drivers/ide/dtc2278.c linux/drivers/ide/dtc2278.c
--- linux-2.5.7/drivers/ide/dtc2278.c	Thu Mar 21 23:54:17 2002
+++ linux/drivers/ide/dtc2278.c	Fri Mar 22 02:16:14 2002
@@ -126,5 +126,5 @@
 	ide_hwifs[1].drives[1].no_unmask = 1;
 	ide_hwifs[0].mate = &ide_hwifs[1];
 	ide_hwifs[1].mate = &ide_hwifs[0];
-	ide_hwifs[1].channel = 1;
+	ide_hwifs[1].unit = 1;
 }
diff -urN linux-2.5.7/drivers/ide/hpt366.c linux/drivers/ide/hpt366.c
--- linux-2.5.7/drivers/ide/hpt366.c	Thu Mar 21 23:54:17 2002
+++ linux/drivers/ide/hpt366.c	Fri Mar 22 02:40:25 2002
@@ -485,7 +485,7 @@
 static void hpt366_tune_chipset (ide_drive_t *drive, byte speed)
 {
 	byte regtime		= (drive->select.b.unit & 0x01) ? 0x44 : 0x40;
-	byte regfast		= (drive->channel->channel) ? 0x55 : 0x51;
+	byte regfast		= (drive->channel->unit) ? 0x55 : 0x51;
 			/*
 			 * since the channel is always 0 it does not matter.
 			 */
@@ -536,7 +536,7 @@
 
 static void hpt370_tune_chipset (ide_drive_t *drive, byte speed)
 {
-	byte regfast		= (drive->channel->channel) ? 0x55 : 0x51;
+	byte regfast		= (drive->channel->unit) ? 0x55 : 0x51;
 	unsigned int list_conf	= 0;
 	unsigned int drive_conf = 0;
 	unsigned int conf_mask	= (speed >= XFER_MW_DMA_0) ? 0xc0000000 : 0x30070000;
@@ -840,8 +840,8 @@
 {
 	struct ata_channel *hwif = drive->channel;
 	unsigned long dma_base = hwif->dma_base;
-	byte regstate = hwif->channel ? 0x54 : 0x50;
-	byte reginfo = hwif->channel ? 0x56 : 0x52;
+	byte regstate = hwif->unit ? 0x54 : 0x50;
+	byte reginfo = hwif->unit ? 0x56 : 0x52;
 	byte dma_stat;
 
 	switch (func) {
@@ -900,7 +900,7 @@
 {
 #if 0
 	unsigned long high_16	= pci_resource_start(drive->channel->pci_dev, 4);
-	byte reset		= (drive->channel->channel) ? 0x80 : 0x40;
+	byte reset		= (drive->channel->unit) ? 0x80 : 0x40;
 	byte reg59h		= 0;
 
 	pci_read_config_byte(drive->channel->pci_dev, 0x59, &reg59h);
@@ -914,8 +914,8 @@
 {
 	struct ata_channel *hwif	= drive->channel;
 	struct pci_dev *dev	= hwif->pci_dev;
-	byte reset		= (hwif->channel) ? 0x80 : 0x40;
-	byte state_reg		= (hwif->channel) ? 0x57 : 0x53;
+	byte reset		= (hwif->unit) ? 0x80 : 0x40;
+	byte state_reg		= (hwif->unit) ? 0x57 : 0x53;
 	byte reg59h		= 0;
 	byte regXXh		= 0;
 
@@ -960,7 +960,7 @@
 
 	hwif->bus_state = state;
 
-	if (hwif->channel) { 
+	if (hwif->unit) { 
 		/* secondary channel */
 		tristate = 0x56;
 		resetmask = 0x80; 
@@ -1139,7 +1139,7 @@
 unsigned int __init ata66_hpt366(struct ata_channel *hwif)
 {
 	byte ata66	= 0;
-	byte regmask	= (hwif->channel) ? 0x01 : 0x02;
+	byte regmask	= (hwif->unit) ? 0x01 : 0x02;
 
 	pci_read_config_byte(hwif->pci_dev, 0x5a, &ata66);
 #ifdef DEBUG
@@ -1214,8 +1214,8 @@
 {
 	byte masterdma = 0, slavedma = 0;
 	byte dma_new = 0, dma_old = inb(dmabase+2);
-	byte primary	= hwif->channel ? 0x4b : 0x43;
-	byte secondary	= hwif->channel ? 0x4f : 0x47;
+	byte primary	= hwif->unit ? 0x4b : 0x43;
+	byte secondary	= hwif->unit ? 0x4f : 0x47;
 	unsigned long flags;
 
 	__save_flags(flags);	/* local CPU only */
diff -urN linux-2.5.7/drivers/ide/ht6560b.c linux/drivers/ide/ht6560b.c
--- linux-2.5.7/drivers/ide/ht6560b.c	Mon Mar 18 21:37:07 2002
+++ linux/drivers/ide/ht6560b.c	Fri Mar 22 02:18:32 2002
@@ -321,7 +321,7 @@
 			ide_hwifs[1].serialized = 1;  /* is this needed? */
 			ide_hwifs[0].mate = &ide_hwifs[1];
 			ide_hwifs[1].mate = &ide_hwifs[0];
-			ide_hwifs[1].channel = 1;
+			ide_hwifs[1].unit = 1;
 			
 			/*
 			 * Setting default configurations for drives
diff -urN linux-2.5.7/drivers/ide/icside.c linux/drivers/ide/icside.c
--- linux-2.5.7/drivers/ide/icside.c	Thu Mar 21 23:54:17 2002
+++ linux/drivers/ide/icside.c	Fri Mar 22 02:39:18 2002
@@ -621,7 +621,7 @@
 			hwif->hw.dma  = ec->dma;
 			hwif->hw.priv = (void *)
 					(port + ICS_ARCIN_V6_INTRSTAT_1);
-			hwif->channel = 0;
+			hwif->unit = 0;
 			icside_setup_dma(hwif, autodma);
 		}
 		if (mate) {
@@ -630,7 +630,7 @@
 			mate->hw.dma  = ec->dma;
 			mate->hw.priv = (void *)
 					(port + ICS_ARCIN_V6_INTRSTAT_2);
-			mate->channel = 1;
+			mate->unit = 1;
 			icside_setup_dma(mate, autodma);
 		}
 	}
diff -urN linux-2.5.7/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
--- linux-2.5.7/drivers/ide/ide-disk.c	Thu Mar 21 23:54:17 2002
+++ linux/drivers/ide/ide-disk.c	Fri Mar 22 02:33:35 2002
@@ -1036,7 +1036,7 @@
 	    sprintf(drive->device.bus_id, "%d", drvid);
 	    sprintf(drive->device.name, "ide-disk");
 	    drive->device.driver = &idedisk_devdrv;
-	    drive->device.parent = &drive->channel->device;
+	    drive->device.parent = &drive->channel->dev;
 	    drive->device.driver_data = drive;
 	    device_register(&drive->device);
 	}
diff -urN linux-2.5.7/drivers/ide/ide-dma.c linux/drivers/ide/ide-dma.c
--- linux-2.5.7/drivers/ide/ide-dma.c	Thu Mar 21 23:54:17 2002
+++ linux/drivers/ide/ide-dma.c	Fri Mar 22 02:18:58 2002
@@ -660,7 +660,7 @@
 		kfree(hwif->sg_table);
 		hwif->sg_table = NULL;
 	}
-	if ((hwif->dma_extra) && (hwif->channel == 0))
+	if ((hwif->dma_extra) && (hwif->unit == 0))
 		release_region((hwif->dma_base + 16), hwif->dma_extra);
 	release_region(hwif->dma_base, 8);
 	hwif->dma_base = 0;
diff -urN linux-2.5.7/drivers/ide/ide-pci.c linux/drivers/ide/ide-pci.c
--- linux-2.5.7/drivers/ide/ide-pci.c	Thu Mar 21 23:54:17 2002
+++ linux/drivers/ide/ide-pci.c	Fri Mar 22 02:21:22 2002
@@ -442,7 +442,7 @@
 	 */
 
 	if (hwif->mate && hwif->mate->dma_base)
-		dma_base = hwif->mate->dma_base - (hwif->channel ? 0 : 8);
+		dma_base = hwif->mate->dma_base - (hwif->unit ? 0 : 8);
 	else
 		dma_base = pci_resource_start(dev, 4);
 
@@ -452,7 +452,7 @@
 	if (extra) /* PDC20246, PDC20262, HPT343, & HPT366 */
 		request_region(dma_base + 16, extra, name);
 
-	dma_base += hwif->channel ? 8 : 0;
+	dma_base += hwif->unit ? 8 : 0;
 	hwif->dma_extra = extra;
 
 	if ((dev->vendor == PCI_VENDOR_ID_AL && dev->device == PCI_DEVICE_ID_AL_M5219) ||
@@ -610,7 +610,7 @@
 
 	hwif->chipset = ide_pci;
 	hwif->pci_dev = dev;
-	hwif->channel = port;
+	hwif->unit = port;
 	if (!hwif->irq)
 		hwif->irq = pciirq;
 
diff -urN linux-2.5.7/drivers/ide/ide-probe.c linux/drivers/ide/ide-probe.c
--- linux-2.5.7/drivers/ide/ide-probe.c	Thu Mar 21 23:54:17 2002
+++ linux/drivers/ide/ide-probe.c	Fri Mar 22 02:04:10 2002
@@ -118,7 +118,7 @@
 		byte type = (id->config >> 8) & 0x1f;
 		printk("ATAPI ");
 #ifdef CONFIG_BLK_DEV_PDC4030
-		if (drive->channel->channel == 1 && drive->channel->chipset == ide_pdc4030) {
+		if (drive->channel->unit == 1 && drive->channel->chipset == ide_pdc4030) {
 			printk(" -- not supported on 2nd Promise port\n");
 			goto err_misc;
 		}
@@ -461,16 +461,16 @@
 {
 	/* Register this hardware interface within the global device tree.
 	 */
-	sprintf(hwif->device.bus_id, "%04x", hwif->io_ports[IDE_DATA_OFFSET]);
-	sprintf(hwif->device.name, "ide");
-	hwif->device.driver_data = hwif;
+	sprintf(hwif->dev.bus_id, "%04x", hwif->io_ports[IDE_DATA_OFFSET]);
+	sprintf(hwif->dev.name, "ide");
+	hwif->dev.driver_data = hwif;
 #ifdef CONFIG_BLK_DEV_IDEPCI
 	if (hwif->pci_dev)
-		hwif->device.parent = &hwif->pci_dev->dev;
+		hwif->dev.parent = &hwif->pci_dev->dev;
 	else
 #endif
-		hwif->device.parent = NULL; /* Would like to do = &device_legacy */
-	device_register(&hwif->device);
+		hwif->dev.parent = NULL; /* Would like to do = &device_legacy */
+	device_register(&hwif->dev);
 
 	if (((unsigned long)hwif->io_ports[IDE_DATA_OFFSET] | 7) ==
 	    ((unsigned long)hwif->io_ports[IDE_STATUS_OFFSET])) {
@@ -517,7 +517,7 @@
 
 	if (
 #if CONFIG_BLK_DEV_PDC4030
-	    (hwif->chipset != ide_pdc4030 || hwif->channel == 0) &&
+	    (hwif->chipset != ide_pdc4030 || hwif->unit == 0) &&
 #endif
 	    hwif_check_regions(hwif)) {
 		int msgout = 0;
@@ -824,11 +824,11 @@
 	for (unit = 0; unit < MAX_DRIVES; ++unit) {
 		char name[80];
 		ide_add_generic_settings(hwif->drives + unit);
-		hwif->drives[unit].dn = ((hwif->channel ? 2 : 0) + unit);
+		hwif->drives[unit].dn = ((hwif->unit ? 2 : 0) + unit);
 		sprintf (name, "host%d/bus%d/target%d/lun%d",
-			(hwif->channel && hwif->mate) ?
+			(hwif->unit && hwif->mate) ?
 			hwif->mate->index : hwif->index,
-			hwif->channel, unit, hwif->drives[unit].lun);
+			hwif->unit, unit, hwif->drives[unit].lun);
 		if (hwif->drives[unit].present)
 			hwif->drives[unit].de = devfs_mk_dir(ide_devfs_handle, name, NULL);
 	}
diff -urN linux-2.5.7/drivers/ide/ide-proc.c linux/drivers/ide/ide-proc.c
--- linux-2.5.7/drivers/ide/ide-proc.c	Thu Mar 21 23:54:17 2002
+++ linux/drivers/ide/ide-proc.c	Fri Mar 22 02:33:06 2002
@@ -183,7 +183,7 @@
 	struct ata_channel *hwif = data;
 	int		len;
 
-	page[0] = hwif->channel ? '1' : '0';
+	page[0] = hwif->unit ? '1' : '0';
 	page[1] = '\n';
 	len = 2;
 	PROC_IDE_READ_RETURN(page,start,off,count,eof,len);
diff -urN linux-2.5.7/drivers/ide/ide-tape.c linux/drivers/ide/ide-tape.c
--- linux-2.5.7/drivers/ide/ide-tape.c	Thu Mar 21 23:54:17 2002
+++ linux/drivers/ide/ide-tape.c	Thu Mar 21 14:06:19 2002
@@ -3103,10 +3103,10 @@
 	idetape_tape_t *tape = drive->driver_data;
 	idetape_read_position_result_t *result;
 	
-//#if IDETAPE_DEBUG_LOG
-//	if (tape->debug_level >= 4)
+#if IDETAPE_DEBUG_LOG
+	if (tape->debug_level >= 4)
 		printk (KERN_INFO "ide-tape: Reached idetape_read_position_callback\n");
-//#endif /* IDETAPE_DEBUG_LOG */
+#endif /* IDETAPE_DEBUG_LOG */
 
 	if (!tape->pc->error) {
 		result = (idetape_read_position_result_t *) tape->pc->buffer;
@@ -3280,10 +3280,10 @@
 	idetape_pc_t pc;
 	int position;
 
-//#if IDETAPE_DEBUG_LOG
-//        if (tape->debug_level >= 4)
-	printk (KERN_INFO "ide-tape: Reached idetape_read_position\n");
-//#endif /* IDETAPE_DEBUG_LOG */
+#if IDETAPE_DEBUG_LOG
+	if (tape->debug_level >= 4)
+	    printk (KERN_INFO "ide-tape: Reached idetape_read_position\n");
+#endif /* IDETAPE_DEBUG_LOG */
 
 #ifdef NO_LONGER_REQUIRED
 	idetape_flush_tape_buffers(drive);
diff -urN linux-2.5.7/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.7/drivers/ide/ide.c	Thu Mar 21 23:54:17 2002
+++ linux/drivers/ide/ide.c	Fri Mar 22 02:00:34 2002
@@ -1213,40 +1213,20 @@
 {
 	ide_drive_t *drive, *best;
 
-repeat:
 	best = NULL;
 	drive = hwgroup->drive;
 	do {
-		if (!list_empty(&drive->queue.queue_head) && (!drive->PADAM_sleep || 0 <= (signed long)(jiffies - drive->PADAM_sleep))) {
+		if (!list_empty(&drive->queue.queue_head)
+		&& (!drive->PADAM_sleep	|| time_after_eq(drive->PADAM_sleep, jiffies))) {
 			if (!best
-			 || (drive->PADAM_sleep && (!best->PADAM_sleep || 0 < (signed long)(best->PADAM_sleep - drive->PADAM_sleep)))
-			 || (!best->PADAM_sleep && 0 < (signed long)((best->PADAM_service_start + 2 * best->PADAM_service_time)
-					 - (drive->PADAM_service_start + 2 * drive->PADAM_service_time))))
+			 || (drive->PADAM_sleep && (!best->PADAM_sleep || time_after(best->PADAM_sleep, drive->PADAM_sleep)))
+			 || (!best->PADAM_sleep && time_after(best->PADAM_service_start + 2 * best->PADAM_service_time, drive->PADAM_service_start + 2 * drive->PADAM_service_time)))
 			{
 				if (!blk_queue_plugged(&drive->queue))
 					best = drive;
 			}
 		}
 	} while ((drive = drive->next) != hwgroup->drive);
-	if (best && best->nice1 && !best->PADAM_sleep && best != hwgroup->drive && best->PADAM_service_time > WAIT_MIN_SLEEP) {
-		long t = (signed long)((best->PADAM_service_start + 2 * best->PADAM_service_time) - jiffies);
-		if (t >= WAIT_MIN_SLEEP) {
-			/*
-			 * We *may* have some time to spare, but first let's see if
-			 * someone can potentially benefit from our nice mood today..
-			 */
-			drive = best->next;
-			do {
-				if (!drive->PADAM_sleep
-				 && 0 < (signed long)((drive->PADAM_service_start + 2 * drive->PADAM_service_time) - (jiffies - best->PADAM_service_time))
-				 && 0 < (signed long)((jiffies + t) - (drive->PADAM_service_start + 2 * drive->PADAM_service_time)))
-				{
-					ide_stall_queue(best, min(t, 10L * WAIT_MIN_SLEEP));
-					goto repeat;
-				}
-			} while ((drive = drive->next) != best);
-		}
-	}
 	return best;
 }
 
@@ -1298,7 +1278,7 @@
 			hwgroup->rq = NULL;
 			drive = hwgroup->drive;
 			do {
-				if (drive->PADAM_sleep && (!sleep || 0 < (signed long)(sleep - drive->PADAM_sleep)))
+				if (drive->PADAM_sleep && (!sleep || time_after(sleep, drive->PADAM_sleep)))
 					sleep = drive->PADAM_sleep;
 			} while ((drive = drive->next) != hwgroup->drive);
 			if (sleep) {
@@ -1968,23 +1948,22 @@
 #endif
 }
 
-void ide_unregister(struct ata_channel *hwif)
+void ide_unregister(struct ata_channel *channel)
 {
 	struct gendisk *gd;
 	ide_drive_t *drive, *d;
-	struct ata_channel *g;
 	ide_hwgroup_t *hwgroup;
-	int irq_count = 0, unit, i;
+	int unit, i;
 	unsigned long flags;
 	unsigned int p, minor;
 	struct ata_channel old_hwif;
 
 	spin_lock_irqsave(&ide_lock, flags);
-	if (!hwif->present)
+	if (!channel->present)
 		goto abort;
-	put_device(&hwif->device);
+	put_device(&channel->dev);
 	for (unit = 0; unit < MAX_DRIVES; ++unit) {
-		drive = &hwif->drives[unit];
+		drive = &channel->drives[unit];
 		if (!drive->present)
 			continue;
 		if (drive->busy || drive->usage)
@@ -1997,43 +1976,47 @@
 				ide_unregister_subdriver(drive);
 		}
 	}
-	hwif->present = 0;
+	channel->present = 0;
 
 	/*
 	 * All clear?  Then blow away the buffer cache
 	 */
 	spin_unlock_irqrestore(&ide_lock, flags);
 	for (unit = 0; unit < MAX_DRIVES; ++unit) {
-		drive = &hwif->drives[unit];
+		drive = &channel->drives[unit];
 		if (!drive->present)
 			continue;
 		minor = drive->select.b.unit << PARTN_BITS;
 		for (p = 0; p < (1<<PARTN_BITS); ++p) {
 			if (drive->part[p].nr_sects > 0) {
-				kdev_t devp = mk_kdev(hwif->major, minor+p);
+				kdev_t devp = mk_kdev(channel->major, minor+p);
 				invalidate_device(devp, 0);
 			}
 		}
 	}
 #ifdef CONFIG_PROC_FS
-	destroy_proc_ide_drives(hwif);
+	destroy_proc_ide_drives(channel);
 #endif
 	spin_lock_irqsave(&ide_lock, flags);
-	hwgroup = hwif->hwgroup;
+	hwgroup = channel->hwgroup;
 
 	/*
 	 * free the irq if we were the only hwif using it
 	 */
-	g = hwgroup->hwif;
-	do {
-		if (g->irq == hwif->irq)
-			++irq_count;
-		g = g->next;
-	} while (g != hwgroup->hwif);
-	if (irq_count == 1)
-		free_irq(hwif->irq, hwgroup);
-
-	hwif_unregister(hwif);
+	{
+		struct ata_channel *g;
+		int irq_count = 0;
+
+		g = hwgroup->hwif;
+		do {
+			if (g->irq == channel->irq)
+				++irq_count;
+			g = g->next;
+		} while (g != hwgroup->hwif);
+		if (irq_count == 1)
+			free_irq(channel->irq, hwgroup);
+	}
+	hwif_unregister(channel);
 
 	/*
 	 * Remove us from the hwgroup, and free
@@ -2041,7 +2024,7 @@
 	 */
 	d = hwgroup->drive;
 	for (i = 0; i < MAX_DRIVES; ++i) {
-		drive = &hwif->drives[i];
+		drive = &channel->drives[i];
 		if (drive->de) {
 			devfs_unregister (drive->de);
 			drive->de = NULL;
@@ -2062,27 +2045,27 @@
 	}
 	if (d->present)
 		hwgroup->drive = d;
-	while (hwgroup->hwif->next != hwif)
+	while (hwgroup->hwif->next != channel)
 		hwgroup->hwif = hwgroup->hwif->next;
-	hwgroup->hwif->next = hwif->next;
-	if (hwgroup->hwif == hwif)
+	hwgroup->hwif->next = channel->next;
+	if (hwgroup->hwif == channel)
 		kfree(hwgroup);
 	else
 		hwgroup->hwif = hwgroup->drive->channel;
 
 #if defined(CONFIG_BLK_DEV_IDEDMA) && !defined(CONFIG_DMA_NONPCI)
-	ide_release_dma(hwif);
+	ide_release_dma(channel);
 #endif
 
 	/*
 	 * Remove us from the kernel's knowledge
 	 */
-	unregister_blkdev(hwif->major, hwif->name);
-	kfree(blksize_size[hwif->major]);
-	blk_dev[hwif->major].data = NULL;
-	blk_dev[hwif->major].queue = NULL;
-	blk_clear(hwif->major);
-	gd = hwif->gd;
+	unregister_blkdev(channel->major, channel->name);
+	kfree(blksize_size[channel->major]);
+	blk_dev[channel->major].data = NULL;
+	blk_dev[channel->major].queue = NULL;
+	blk_clear(channel->major);
+	gd = channel->gd;
 	if (gd) {
 		del_gendisk(gd);
 		kfree(gd->sizes);
@@ -2092,45 +2075,45 @@
 		if (gd->flags)
 			kfree (gd->flags);
 		kfree(gd);
-		hwif->gd = NULL;
+		channel->gd = NULL;
 	}
 
 	/*
-	 * Reinitialize the hwif handler, but preserve any special methods for
+	 * Reinitialize the channel handler, but preserve any special methods for
 	 * it.
 	 */
 
-	old_hwif		= *hwif;
-	init_hwif_data(hwif, hwif->index);
-	hwif->hwgroup		= old_hwif.hwgroup;
-	hwif->tuneproc		= old_hwif.tuneproc;
-	hwif->speedproc		= old_hwif.speedproc;
-	hwif->selectproc	= old_hwif.selectproc;
-	hwif->resetproc		= old_hwif.resetproc;
-	hwif->intrproc		= old_hwif.intrproc;
-	hwif->maskproc		= old_hwif.maskproc;
-	hwif->quirkproc		= old_hwif.quirkproc;
-	hwif->rwproc		= old_hwif.rwproc;
-	hwif->ideproc		= old_hwif.ideproc;
-	hwif->dmaproc		= old_hwif.dmaproc;
-	hwif->busproc		= old_hwif.busproc;
-	hwif->bus_state		= old_hwif.bus_state;
-	hwif->dma_base		= old_hwif.dma_base;
-	hwif->dma_extra		= old_hwif.dma_extra;
-	hwif->config_data	= old_hwif.config_data;
-	hwif->select_data	= old_hwif.select_data;
-	hwif->proc		= old_hwif.proc;
+	old_hwif		= *channel;
+	init_hwif_data(channel, channel->index);
+	channel->hwgroup = old_hwif.hwgroup;
+	channel->tuneproc = old_hwif.tuneproc;
+	channel->speedproc = old_hwif.speedproc;
+	channel->selectproc = old_hwif.selectproc;
+	channel->resetproc = old_hwif.resetproc;
+	channel->intrproc = old_hwif.intrproc;
+	channel->maskproc = old_hwif.maskproc;
+	channel->quirkproc = old_hwif.quirkproc;
+	channel->rwproc	= old_hwif.rwproc;
+	channel->ideproc = old_hwif.ideproc;
+	channel->dmaproc = old_hwif.dmaproc;
+	channel->busproc = old_hwif.busproc;
+	channel->bus_state = old_hwif.bus_state;
+	channel->dma_base = old_hwif.dma_base;
+	channel->dma_extra = old_hwif.dma_extra;
+	channel->config_data = old_hwif.config_data;
+	channel->select_data = old_hwif.select_data;
+	channel->proc = old_hwif.proc;
 #ifndef CONFIG_BLK_DEV_IDECS
-	hwif->irq		= old_hwif.irq;
+	channel->irq = old_hwif.irq;
 #endif
-	hwif->major		= old_hwif.major;
-	hwif->chipset		= old_hwif.chipset;
-	hwif->autodma		= old_hwif.autodma;
-	hwif->udma_four		= old_hwif.udma_four;
+	channel->major = old_hwif.major;
+	channel->chipset = old_hwif.chipset;
+	channel->autodma = old_hwif.autodma;
+	channel->udma_four = old_hwif.udma_four;
 #ifdef CONFIG_BLK_DEV_IDEPCI
-	hwif->pci_dev		= old_hwif.pci_dev;
+	channel->pci_dev = old_hwif.pci_dev;
 #endif
-	hwif->straight8		= old_hwif.straight8;
+	channel->straight8 = old_hwif.straight8;
 abort:
 	spin_unlock_irqrestore(&ide_lock, flags);
 }
@@ -2419,7 +2402,6 @@
  */
 	ide_add_setting(drive,	"io_32bit",		drive->no_io_32bit ? SETTING_READ : SETTING_RW,	HDIO_GET_32BIT,		HDIO_SET_32BIT,		TYPE_BYTE,	0,	1 + (SUPPORT_VLB_SYNC << 1),	1,		1,		&drive->io_32bit,		set_io_32bit);
 	ide_add_setting(drive,	"keepsettings",		SETTING_RW,					HDIO_GET_KEEPSETTINGS,	HDIO_SET_KEEPSETTINGS,	TYPE_BYTE,	0,	1,				1,		1,		&drive->keep_settings,		NULL);
-	ide_add_setting(drive,	"nice1",		SETTING_RW,					-1,			-1,			TYPE_BYTE,	0,	1,				1,		1,		&drive->nice1,			NULL);
 	ide_add_setting(drive,	"pio_mode",		SETTING_WRITE,					-1,			HDIO_SET_PIO_MODE,	TYPE_BYTE,	0,	255,				1,		1,		NULL,				set_pio_mode);
 	ide_add_setting(drive,	"slow",			SETTING_RW,					-1,			-1,			TYPE_BYTE,	0,	1,				1,		1,		&drive->slow,			NULL);
 	ide_add_setting(drive,	"unmaskirq",		drive->no_unmask ? SETTING_READ : SETTING_RW,	HDIO_GET_UNMASKINTR,	HDIO_SET_UNMASKINTR,	TYPE_BYTE,	0,	1,				1,		1,		&drive->unmask,			NULL);
@@ -2545,10 +2527,7 @@
 
 		case HDIO_GET_NICE:
 			return put_user(drive->dsc_overlap	<<	IDE_NICE_DSC_OVERLAP	|
-					drive->atapi_overlap	<<	IDE_NICE_ATAPI_OVERLAP	|
-					drive->nice0		<< 	IDE_NICE_0		|
-					drive->nice1		<<	IDE_NICE_1		|
-					drive->nice2		<<	IDE_NICE_2,
+					drive->atapi_overlap	<<	IDE_NICE_ATAPI_OVERLAP,
 					(long *) arg);
 
 		case HDIO_DRIVE_CMD:
@@ -2563,7 +2542,7 @@
 
 		case HDIO_SET_NICE:
 			if (!capable(CAP_SYS_ADMIN)) return -EACCES;
-			if (arg != (arg & ((1 << IDE_NICE_DSC_OVERLAP) | (1 << IDE_NICE_1))))
+			if (arg != (arg & ((1 << IDE_NICE_DSC_OVERLAP))))
 				return -EPERM;
 			drive->dsc_overlap = (arg >> IDE_NICE_DSC_OVERLAP) & 1;
 			/* Only CD-ROM's and tapes support DSC overlap. */
@@ -2571,7 +2550,6 @@
 				drive->dsc_overlap = 0;
 				return -EPERM;
 			}
-			drive->nice1 = (arg >> IDE_NICE_1) & 1;
 			return 0;
 		case BLKGETSIZE:
 		case BLKGETSIZE64:
@@ -3151,7 +3129,7 @@
 	}
 
 	/* FIXME: This will be pushed to the drivers! Thus allowing us to
-	 * save one parameter here eparate this out.
+	 * save one parameter here separate this out.
 	 */
 
 	drive->driver = driver;
@@ -3175,7 +3153,6 @@
 		/* Only CD-ROMs and tape drives support DSC overlap. */
 		drive->dsc_overlap = (drive->next != drive
 				&& (drive->type == ATA_ROM || drive->type == ATA_TAPE));
-		drive->nice1 = 1;
 	}
 	drive->revalidate = 1;
 	drive->suspend_reset = 0;
diff -urN linux-2.5.7/drivers/ide/ns87415.c linux/drivers/ide/ns87415.c
--- linux-2.5.7/drivers/ide/ns87415.c	Thu Mar 21 23:54:17 2002
+++ linux/drivers/ide/ns87415.c	Fri Mar 22 02:22:40 2002
@@ -43,12 +43,12 @@
 	new = *old;
 
 	/* Adjust IRQ enable bit */
-	bit = 1 << (8 + hwif->channel);
+	bit = 1 << (8 + hwif->unit);
 	new = drive->present ? (new & ~bit) : (new | bit);
 
 	/* Select PIO or DMA, DMA may only be selected for one drive/channel. */
-	bit   = 1 << (20 + drive->select.b.unit       + (hwif->channel << 1));
-	other = 1 << (20 + (1 - drive->select.b.unit) + (hwif->channel << 1));
+	bit   = 1 << (20 + drive->select.b.unit       + (hwif->unit << 1));
+	other = 1 << (20 + (1 - drive->select.b.unit) + (hwif->unit << 1));
 	new = use_dma ? ((new & ~other) | bit) : (new & ~bit);
 
 	if (new != *old) {
@@ -138,9 +138,9 @@
 	(void) pci_read_config_dword(dev, 0x40, &ctrl);
 	(void) pci_read_config_byte(dev, 0x09, &progif);
 	/* is irq in "native" mode? */
-	using_inta = progif & (1 << (hwif->channel << 1));
+	using_inta = progif & (1 << (hwif->unit << 1));
 	if (!using_inta)
-		using_inta = ctrl & (1 << (4 + hwif->channel));
+		using_inta = ctrl & (1 << (4 + hwif->unit));
 	if (hwif->mate) {
 		hwif->select_data = hwif->mate->select_data;
 	} else {
@@ -180,7 +180,7 @@
 		outb(0x60, hwif->dma_base + 2);
 
 	if (!using_inta)
-		hwif->irq = hwif->channel ? 15 : 14;	/* legacy mode */
+		hwif->irq = hwif->unit ? 15 : 14;	/* legacy mode */
 	else if (!hwif->irq && hwif->mate && hwif->mate->irq)
 		hwif->irq = hwif->mate->irq;	/* share IRQ with mate */
 
diff -urN linux-2.5.7/drivers/ide/pdc202xx.c linux/drivers/ide/pdc202xx.c
--- linux-2.5.7/drivers/ide/pdc202xx.c	Thu Mar 21 23:54:17 2002
+++ linux/drivers/ide/pdc202xx.c	Fri Mar 22 02:26:12 2002
@@ -530,7 +530,7 @@
 #else
 	struct pci_dev *dev	= hwif->pci_dev;
 	unsigned long high_16	= pci_resource_start(dev, 4);
-	unsigned long indexreg	= high_16 + (hwif->channel ? 0x09 : 0x01);
+	unsigned long indexreg	= high_16 + (hwif->unit ? 0x09 : 0x01);
 	unsigned long datareg	= (indexreg + 2);
 #endif /* CONFIG_BLK_DEV_IDEDMA */
 	byte thold		= 0x10;
@@ -725,8 +725,8 @@
 	byte udma_66		= ((eighty_ninty_three(drive)) && udma_33) ? 1 : 0;
 	byte udma_100		= 0;
 	byte udma_133		= 0;
-	byte mask		= hwif->channel ? 0x08 : 0x02;
-	unsigned short c_mask	= hwif->channel ? (1<<11) : (1<<10);
+	byte mask		= hwif->unit ? 0x08 : 0x02;
+	unsigned short c_mask	= hwif->unit ? (1<<11) : (1<<10);
 
 	byte ultra_66		= ((id->dma_ultra & 0x0010) ||
 				   (id->dma_ultra & 0x0008)) ? 1 : 0;
@@ -792,14 +792,14 @@
 
 	if (((ultra_66) || (ultra_100) || (ultra_133)) && (cable)) {
 #ifdef DEBUG
-		printk("ULTRA66: %s channel of Ultra 66 requires an 80-pin cable for Ultra66 operation.\n", hwif->channel ? "Secondary" : "Primary");
+		printk("ULTRA66: %s channel of Ultra 66 requires an 80-pin cable for Ultra66 operation.\n", hwif->unit ? "Secondary" : "Primary");
 		printk("         Switching to Ultra33 mode.\n");
 #endif /* DEBUG */
 		/* Primary   : zero out second bit */
 		/* Secondary : zero out fourth bit */
 		if (!jumpbit)
 			OUT_BYTE(CLKSPD & ~mask, (high_16 + 0x11));
-		printk("Warning: %s channel requires an 80-pin cable for operation.\n", hwif->channel ? "Secondary":"Primary");
+		printk("Warning: %s channel requires an 80-pin cable for operation.\n", hwif->unit ? "Secondary":"Primary");
 		printk("%s reduced to Ultra33 mode.\n", drive->name);
 		udma_66 = 0; udma_100 = 0; udma_133 = 0;
 	} else {
@@ -990,7 +990,7 @@
 	struct ata_channel *hwif = drive->channel;
 	struct pci_dev *dev	= hwif->pci_dev;
 	unsigned long high_16	= pci_resource_start(dev, 4);
-	unsigned long atapi_reg	= high_16 + (hwif->channel ? 0x24 : 0x00);
+	unsigned long atapi_reg	= high_16 + (hwif->unit ? 0x24 : 0x00);
 	unsigned long dma_base	= hwif->dma_base;
 
 	switch (dev->device) {
@@ -1023,7 +1023,7 @@
 				struct request *rq = HWGROUP(drive)->rq;
 				unsigned long word_count = 0;
 
-				outb(clock|(hwif->channel ? 0x08 : 0x02), high_16 + 0x11);
+				outb(clock|(hwif->unit ? 0x08 : 0x02), high_16 + 0x11);
 				word_count = (rq->nr_sectors << 8);
 				word_count = (rq_data_dir(rq) == READ) ? word_count | 0x05000000 : word_count | 0x06000000;
 				outl(word_count, atapi_reg);
@@ -1033,7 +1033,7 @@
 			if ((drive->addressing) && (hardware48hack)) {
 				outl(0, atapi_reg);	/* zero out extra */
 				clock = IN_BYTE(high_16 + 0x11);
-				OUT_BYTE(clock & ~(hwif->channel ? 0x08:0x02), high_16 + 0x11);
+				OUT_BYTE(clock & ~(hwif->unit ? 0x08:0x02), high_16 + 0x11);
 			}
 			break;
 		case ide_dma_test_irq:	/* returns 1 if dma irq issued, 0 otherwise */
@@ -1042,7 +1042,7 @@
 				return (dma_stat & 4) == 4;
 
 			sc1d = IN_BYTE(high_16 + 0x001d);
-			if (drive->channel->channel) {
+			if (drive->channel->unit) {
 				if ((sc1d & 0x50) == 0x50) goto somebody_else;
 				else if ((sc1d & 0x40) == 0x40)
 					return (dma_stat & 4) == 4;
@@ -1071,7 +1071,7 @@
 	OUT_BYTE(0x00,IDE_CONTROL_REG);
 	mdelay(1000);
 	printk("PDC202XX: %s channel reset.\n",
-		drive->channel->channel ? "Secondary" : "Primary");
+		drive->channel->unit ? "Secondary" : "Primary");
 }
 
 void pdc202xx_reset (ide_drive_t *drive)
@@ -1084,7 +1084,7 @@
 	OUT_BYTE(udma_speed_flag & ~0x10, high_16 + 0x001f);
 	mdelay(2000);		/* 2 seconds ?! */
 	printk("PDC202XX: %s channel reset.\n",
-		drive->channel->channel ? "Secondary" : "Primary");
+		drive->channel->unit ? "Secondary" : "Primary");
 }
 
 /*
@@ -1218,7 +1218,7 @@
 
 unsigned int __init ata66_pdc202xx(struct ata_channel *hwif)
 {
-	unsigned short mask = (hwif->channel) ? (1<<11) : (1<<10);
+	unsigned short mask = (hwif->unit) ? (1<<11) : (1<<10);
 	unsigned short CIS;
 
         switch(hwif->pci_dev->device) {
diff -urN linux-2.5.7/drivers/ide/pdc4030.c linux/drivers/ide/pdc4030.c
--- linux-2.5.7/drivers/ide/pdc4030.c	Thu Mar 21 23:54:17 2002
+++ linux/drivers/ide/pdc4030.c	Fri Mar 22 02:27:02 2002
@@ -99,7 +99,7 @@
 {
 	unsigned int number;
 
-	number = (drive->channel->channel << 1) + drive->select.b.unit;
+	number = (drive->channel->unit << 1) + drive->select.b.unit;
 	OUT_BYTE(number,IDE_FEATURE_REG);
 }
 
@@ -226,7 +226,7 @@
 	hwif->chipset	= hwif2->chipset = ide_pdc4030;
 	hwif->mate	= hwif2;
 	hwif2->mate	= hwif;
-	hwif2->channel	= 1;
+	hwif2->unit	= 1;
 	hwif->selectproc = hwif2->selectproc = &promise_selectproc;
 	hwif->serialized = hwif2->serialized = 1;
 
diff -urN linux-2.5.7/drivers/ide/piix.c linux/drivers/ide/piix.c
--- linux-2.5.7/drivers/ide/piix.c	Thu Mar 21 23:54:17 2002
+++ linux/drivers/ide/piix.c	Fri Mar 22 02:28:22 2002
@@ -357,7 +357,7 @@
 
 static void piix_tune_drive(ide_drive_t *drive, unsigned char pio)
 {
-	if (!((piix_enabled >> drive->channel->channel) & 1))
+	if (!((piix_enabled >> drive->channel->unit) & 1))
 		return;
 
 	if (pio == 255) {
@@ -535,7 +535,7 @@
 
 unsigned int __init ata66_piix(struct ata_channel *hwif)
 {
-	return ((piix_enabled & piix_80w) >> hwif->channel) & 1;
+	return ((piix_enabled & piix_80w) >> hwif->unit) & 1;
 }
 
 void __init ide_init_piix(struct ata_channel *hwif)
@@ -550,7 +550,7 @@
 		hwif->drives[i].io_32bit = 1;
 		hwif->drives[i].unmask = 1;
 		hwif->drives[i].autotune = 1;
-		hwif->drives[i].dn = hwif->channel * 2 + i;
+		hwif->drives[i].dn = hwif->unit * 2 + i;
 	}
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
@@ -572,7 +572,7 @@
 
 void __init ide_dmacapable_piix(struct ata_channel *hwif, unsigned long dmabase)
 {
-	if (((piix_enabled >> hwif->channel) & 1)
+	if (((piix_enabled >> hwif->unit) & 1)
 		&& !(piix_config->flags & PIIX_NODMA))
 			ide_setup_dma(hwif, dmabase, 8);
 }
diff -urN linux-2.5.7/drivers/ide/qd65xx.c linux/drivers/ide/qd65xx.c
--- linux-2.5.7/drivers/ide/qd65xx.c	Thu Mar 21 23:54:17 2002
+++ linux/drivers/ide/qd65xx.c	Fri Mar 22 02:29:05 2002
@@ -291,7 +291,7 @@
 		printk(KERN_INFO "%s: PIO mode%d\n", drive->name, pio - XFER_PIO_0);
 	}
 
-	if (!drive->channel->channel && drive->type != ATA_DISK) {
+	if (!drive->channel->unit && drive->type != ATA_DISK) {
 		qd_write_reg(0x5f,QD_CONTROL_PORT);
 		printk(KERN_WARNING "%s: ATAPI: disabled read-ahead FIFO and post-write buffer on %s.\n",drive->name, drive->channel->name);
 	}
@@ -420,7 +420,7 @@
 
 				ide_hwifs[i].chipset = ide_qd65xx;
 				ide_hwifs[i].mate = &ide_hwifs[i^1];
-				ide_hwifs[i].channel = i;
+				ide_hwifs[i].unit = i;
 
 				ide_hwifs[i].select_data = base;
 				ide_hwifs[i].config_data = config | (control <<8);
diff -urN linux-2.5.7/drivers/ide/rz1000.c linux/drivers/ide/rz1000.c
--- linux-2.5.7/drivers/ide/rz1000.c	Thu Mar 21 23:54:17 2002
+++ linux/drivers/ide/rz1000.c	Fri Mar 22 02:39:41 2002
@@ -71,7 +71,7 @@
 				hwif->drives[0].no_unmask = 1;
 				hwif->drives[1].no_unmask = 1;
 				if (hwif->io_ports[IDE_DATA_OFFSET] == 0x170)
-					hwif->channel = 1;
+					hwif->unit = 1;
 				printk("%s: serialized, disabled unmasking (buggy %s)\n", hwif->name, name);
 			}
 		}
diff -urN linux-2.5.7/drivers/ide/serverworks.c linux/drivers/ide/serverworks.c
--- linux-2.5.7/drivers/ide/serverworks.c	Thu Mar 21 23:54:17 2002
+++ linux/drivers/ide/serverworks.c	Fri Mar 22 02:23:40 2002
@@ -255,7 +255,7 @@
 
 	byte drive_pci		= 0x00;
 	byte drive_pci2		= 0x00;
-	byte drive_pci3		= hwif->channel ? 0x57 : 0x56;
+	byte drive_pci3		= hwif->unit ? 0x57 : 0x56;
 
 	byte ultra_enable	= 0x00;
 	byte ultra_timing	= 0x00;
@@ -590,7 +590,7 @@
 	if (dev->subsystem_vendor == PCI_VENDOR_ID_DELL &&
 	    dev->vendor	== PCI_VENDOR_ID_SERVERWORKS &&
 	    dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB5IDE)
-		return ((1 << (hwif->channel + 14)) &
+		return ((1 << (hwif->unit + 14)) &
 			dev->subsystem_device) ? 1 : 0;
 	return 0;
 }
@@ -607,7 +607,7 @@
 	if (dev->subsystem_vendor == PCI_VENDOR_ID_SUN &&
 	    dev->vendor	== PCI_VENDOR_ID_SERVERWORKS &&
 	    dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB5IDE)
-		return ((1 << (hwif->channel + 14)) &
+		return ((1 << (hwif->unit + 14)) &
 			dev->subsystem_device) ? 1 : 0;
 	return 0;
 }
@@ -630,7 +630,7 @@
 void __init ide_init_svwks(struct ata_channel *hwif)
 {
 	if (!hwif->irq)
-		hwif->irq = hwif->channel ? 15 : 14;
+		hwif->irq = hwif->unit ? 15 : 14;
 
 	hwif->tuneproc = &svwks_tune_drive;
 	hwif->speedproc = &svwks_tune_chipset;
diff -urN linux-2.5.7/drivers/ide/sis5513.c linux/drivers/ide/sis5513.c
--- linux-2.5.7/drivers/ide/sis5513.c	Thu Mar 21 23:54:17 2002
+++ linux/drivers/ide/sis5513.c	Fri Mar 22 02:29:45 2002
@@ -844,7 +844,7 @@
 unsigned int __init ata66_sis5513(struct ata_channel *hwif)
 {
 	byte reg48h = 0, ata66 = 0;
-	byte mask = hwif->channel ? 0x20 : 0x10;
+	byte mask = hwif->unit ? 0x20 : 0x10;
 	pci_read_config_byte(hwif->pci_dev, 0x48, &reg48h);
 
 	if (dma_capability >= ATA_66) {
@@ -856,7 +856,7 @@
 void __init ide_init_sis5513(struct ata_channel *hwif)
 {
 
-	hwif->irq = hwif->channel ? 15 : 14;
+	hwif->irq = hwif->unit ? 15 : 14;
 
 	hwif->tuneproc = &sis5513_tune_drive;
 	hwif->speedproc = &sis5513_tune_chipset;
diff -urN linux-2.5.7/drivers/ide/sl82c105.c linux/drivers/ide/sl82c105.c
--- linux-2.5.7/drivers/ide/sl82c105.c	Thu Mar 21 23:54:17 2002
+++ linux/drivers/ide/sl82c105.c	Fri Mar 22 02:36:44 2002
@@ -63,7 +63,7 @@
 	unsigned short drv_ctrl = 0x909;
 	unsigned int xfer_mode, reg;
 
-	reg = (hwif->channel ? 0x4c : 0x44) + (drive->select.b.unit ? 4 : 0);
+	reg = (hwif->unit ? 0x4c : 0x44) + (drive->select.b.unit ? 4 : 0);
 
 	if (pio == 255)
 		xfer_mode = ata_timing_mode(drive, XFER_PIO | XFER_EPIO);
@@ -100,7 +100,7 @@
 	unsigned short drv_ctrl = 0x909;
 	unsigned int reg;
 
-	reg = (hwif->channel ? 0x4c : 0x44) + (drive->select.b.unit ? 4 : 0);
+	reg = (hwif->unit ? 0x4c : 0x44) + (drive->select.b.unit ? 4 : 0);
 
 	if (ide_config_drive_speed(drive, XFER_MW_DMA_2) == 0)
 		drv_ctrl = 0x0240;
diff -urN linux-2.5.7/drivers/ide/trm290.c linux/drivers/ide/trm290.c
--- linux-2.5.7/drivers/ide/trm290.c	Thu Mar 21 23:54:17 2002
+++ linux/drivers/ide/trm290.c	Fri Mar 22 02:31:23 2002
@@ -153,14 +153,14 @@
 
 	if (reg != hwif->select_data) {
 		hwif->select_data = reg;
-		outb(0x51|(hwif->channel<<3), hwif->config_data+1);	/* set PIO/DMA */
+		outb(0x51|(hwif->unit<<3), hwif->config_data+1);	/* set PIO/DMA */
 		outw(reg & 0xff, hwif->config_data);
 	}
 
 	/* enable IRQ if not probing */
 	if (drive->present) {
 		reg = inw(hwif->config_data+3) & 0x13;
-		reg &= ~(1 << hwif->channel);
+		reg &= ~(1 << hwif->unit);
 		outw(reg, hwif->config_data+3);
 	}
 
@@ -237,7 +237,7 @@
 	__save_flags(flags);	/* local CPU only */
 	__cli();		/* local CPU only */
 	/* put config reg into first byte of hwif->select_data */
-	outb(0x51|(hwif->channel<<3), hwif->config_data+1);
+	outb(0x51|(hwif->unit<<3), hwif->config_data+1);
 	hwif->select_data = 0x21;			/* select PIO as default */
 	outb(hwif->select_data, hwif->config_data);
 	reg = inb(hwif->config_data+3);			/* get IRQ info */
@@ -246,10 +246,10 @@
 	__restore_flags(flags);	/* local CPU only */
 
 	if ((reg & 0x10))
-		hwif->irq = hwif->channel ? 15 : 14;	/* legacy mode */
+		hwif->irq = hwif->unit ? 15 : 14;	/* legacy mode */
 	else if (!hwif->irq && hwif->mate && hwif->mate->irq)
 		hwif->irq = hwif->mate->irq;		/* sharing IRQ with mate */
-	ide_setup_dma(hwif, (hwif->config_data + 4) ^ (hwif->channel ? 0x0080 : 0x0000), 3);
+	ide_setup_dma(hwif, (hwif->config_data + 4) ^ (hwif->unit ? 0x0080 : 0x0000), 3);
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	hwif->dmaproc = &trm290_dmaproc;
@@ -264,10 +264,10 @@
 		 * for the control basereg, so this kludge ensures that we use only
 		 * values that are known to work.  Ugh.		-ml
 		 */
-		unsigned short old, compat = hwif->channel ? 0x374 : 0x3f4;
+		unsigned short old, compat = hwif->unit ? 0x374 : 0x3f4;
 		static unsigned short next_offset = 0;
 
-		outb(0x54|(hwif->channel<<3), hwif->config_data+1);
+		outb(0x54|(hwif->unit<<3), hwif->config_data+1);
 		old = inw(hwif->config_data) & ~1;
 		if (old != compat && inb(old+2) == 0xff) {
 			compat += (next_offset += 0x400);	/* leave lower 10 bits untouched */
diff -urN linux-2.5.7/drivers/ide/umc8672.c linux/drivers/ide/umc8672.c
--- linux-2.5.7/drivers/ide/umc8672.c	Thu Mar 21 23:54:17 2002
+++ linux/drivers/ide/umc8672.c	Fri Mar 22 02:31:45 2002
@@ -160,5 +160,5 @@
 	ide_hwifs[1].tuneproc = &tune_umc;
 	ide_hwifs[0].mate = &ide_hwifs[1];
 	ide_hwifs[1].mate = &ide_hwifs[0];
-	ide_hwifs[1].channel = 1;
+	ide_hwifs[1].unit = 1;
 }
diff -urN linux-2.5.7/drivers/ide/via82cxxx.c linux/drivers/ide/via82cxxx.c
--- linux-2.5.7/drivers/ide/via82cxxx.c	Thu Mar 21 23:54:17 2002
+++ linux/drivers/ide/via82cxxx.c	Fri Mar 22 02:32:43 2002
@@ -344,7 +344,7 @@
 
 static void via82cxxx_tune_drive(ide_drive_t *drive, unsigned char pio)
 {
-	if (!((via_enabled >> drive->channel->channel) & 1))
+	if (!((via_enabled >> drive->channel->unit) & 1))
 		return;
 
 	if (pio == 255) {
@@ -525,7 +525,7 @@
 
 unsigned int __init ata66_via82cxxx(struct ata_channel *hwif)
 {
-	return ((via_enabled & via_80w) >> hwif->channel) & 1;
+	return ((via_enabled & via_80w) >> hwif->unit) & 1;
 }
 
 void __init ide_init_via82cxxx(struct ata_channel *hwif)
@@ -540,7 +540,7 @@
 		hwif->drives[i].io_32bit = 1;
 		hwif->drives[i].unmask = (via_config->flags & VIA_NO_UNMASK) ? 0 : 1;
 		hwif->drives[i].autotune = 1;
-		hwif->drives[i].dn = hwif->channel * 2 + i;
+		hwif->drives[i].dn = hwif->unit * 2 + i;
 	}
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
@@ -561,6 +561,6 @@
 
 void __init ide_dmacapable_via82cxxx(struct ata_channel *hwif, unsigned long dmabase)
 {
-	if ((via_enabled >> hwif->channel) & 1)
+	if ((via_enabled >> hwif->unit) & 1)
 		ide_setup_dma(hwif, dmabase, 8);
 }
diff -urN linux-2.5.7/include/linux/hdreg.h linux/include/linux/hdreg.h
--- linux-2.5.7/include/linux/hdreg.h	Thu Mar 21 23:26:22 2002
+++ linux/include/linux/hdreg.h	Fri Mar 22 01:36:43 2002
@@ -584,8 +584,5 @@
  */
 #define IDE_NICE_DSC_OVERLAP	(0)	/* per the DSC overlap protocol */
 #define IDE_NICE_ATAPI_OVERLAP	(1)	/* not supported yet */
-#define IDE_NICE_0		(2)	/* when sure that it won't affect us */
-#define IDE_NICE_1		(3)	/* when probably won't affect us much */
-#define IDE_NICE_2		(4)	/* when we know it's on our expense */
 
 #endif	/* _LINUX_HDREG_H */
diff -urN linux-2.5.7/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.7/include/linux/ide.h	Thu Mar 21 23:54:17 2002
+++ linux/include/linux/ide.h	Fri Mar 22 01:48:51 2002
@@ -271,14 +271,14 @@
 typedef struct ide_drive_s {
 	struct ata_channel *channel;	/* parent pointer to the channel we are attached to  */
 
-	unsigned int	usage;		/* current "open()" count for drive */
+	unsigned int usage;		/* current "open()" count for drive */
 	char type; /* distingiush different devices: disk, cdrom, tape, floppy, ... */
 
 	/* NOTE: If we had proper separation between channel and host chip, we
 	 * could move this to the chanell and many sync problems would
 	 * magically just go away.
 	 */
-	request_queue_t		 queue;	/* per device request queue */
+	request_queue_t	queue;	/* per device request queue */
 
 	struct ide_drive_s	*next;	/* circular list of hwgroup drives */
 
@@ -300,7 +300,6 @@
 	byte     slow;			/* flag: slow data port */
 	byte     bswap;			/* flag: byte swap data */
 	byte     dsc_overlap;		/* flag: DSC overlap */
-	byte     nice1;			/* flag: give potential excess bandwidth */
 	unsigned waiting_for_dma: 1;	/* dma currently in progress */
 	unsigned present	: 1;	/* drive is physically present */
 	unsigned noprobe	: 1;	/* from:  hdx=noprobe */
@@ -312,8 +311,6 @@
 	unsigned nobios		: 1;	/* flag: do not probe bios for drive */
 	unsigned revalidate	: 1;	/* request revalidation */
 	unsigned atapi_overlap	: 1;	/* flag: ATAPI overlap (not supported) */
-	unsigned nice0		: 1;	/* flag: give obvious excess bandwidth */
-	unsigned nice2		: 1;	/* flag: give a share in our own bandwidth */
 	unsigned doorlocking	: 1;	/* flag: for removable only: door lock/unlock works */
 	unsigned autotune	: 2;	/* 1=autotune, 2=noautotune, 0=default */
 	unsigned remap_0_to_1	: 2;	/* 0=remap if ezdrive, 1=remap, 2=noremap */
@@ -440,10 +437,17 @@
 typedef int (ide_busproc_t) (ide_drive_t *, int);
 
 struct ata_channel {
+	struct device	dev;		/* device handle */
+	int		unit;		/* channel number */
+
 	struct ata_channel *next;	/* for linked-list in ide_hwgroup_t */
 	struct hwgroup_s *hwgroup;	/* actually (ide_hwgroup_t *) */
+
 	ide_ioreg_t	io_ports[IDE_NR_PORTS];	/* task file registers */
 	hw_regs_t	hw;		/* Hardware info */
+#ifdef CONFIG_BLK_DEV_IDEPCI
+	struct pci_dev	*pci_dev;	/* for pci chipsets */
+#endif
 	ide_drive_t	drives[MAX_DRIVES];	/* drive info */
 	struct gendisk	*gd;		/* gendisk structure */
 	ide_tuneproc_t	*tuneproc;	/* routine to tune PIO mode for drives */
@@ -480,17 +484,12 @@
 	unsigned	autodma    : 1;	/* automatically try to enable DMA at boot */
 	unsigned	udma_four  : 1;	/* 1=ATA-66 capable, 0=default */
 	unsigned	highmem	   : 1; /* can do full 32-bit dma */
-	byte		channel;	/* for dual-port chips: 0=primary, 1=secondary */
-#ifdef CONFIG_BLK_DEV_IDEPCI
-	struct pci_dev	*pci_dev;	/* for pci chipsets */
-#endif
 #if (DISK_RECOVERY_TIME > 0)
 	unsigned long	last_time;	/* time when previous rq was done */
 #endif
 	byte		straight8;	/* Alan's straight 8 check */
 	ide_busproc_t	*busproc;	/* driver soft-power interface */
 	byte		bus_state;	/* power state of the IDE bus */
-	struct device	device;		/* global device tree handle */
 };
 
 /*

--------------090106010902000409040406--

