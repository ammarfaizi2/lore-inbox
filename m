Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313184AbSEEQ5s>; Sun, 5 May 2002 12:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313189AbSEEQ5r>; Sun, 5 May 2002 12:57:47 -0400
Received: from [195.63.194.11] ([195.63.194.11]:19726 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313184AbSEEQ51>; Sun, 5 May 2002 12:57:27 -0400
Message-ID: <3CD555BD.2010505@evision-ventures.com>
Date: Sun, 05 May 2002 17:54:37 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.13 IDE 52
In-Reply-To: <1019549894.1450.41.camel@turbulence.megapathdsl.net> <3CC7E358.8050905@evision-ventures.com> <20020425172508.GK3542@suse.de> <20020425173439.GM3542@suse.de> <aa9qtb$d8a$1@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------080905080306040000010406"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080905080306040000010406
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit

Fri May  3 17:50:22 CEST 2002 ide-clean-52

Adapted from patch Bar³omiej ¯o³nierkiewicz:

- make straight8 a flag in ata_channel instead of byte

- don't store tables as code in drive_is_flashcard()
   and ide_xfer_verbose()

- fix init_gendisk() (due to 2.5.13 blksize_size[] change)

- compress region requesting/releasing
   in channel_probe() and ide_unregister()

- clean a bit ide_setup_ports()

Start of DMA handling tratment.

- Fix the parameters to ide_build_dmatable() to be channel and request.
   Rename it to udma_new_table(). udma will mark arch specific functions
   later.

- Let ide_start_dma() take the request directly as an arguemnt. Rename it to
   ata_start_dma(). After realizing that the usage of the func argument of it
   was bogous and that nobody is using rwproc we where able to remove both of
   them.

- Fix ide_destroy_dmatable() to take the channel as argument and rename it to
   udma_destroy_table(). This function should have possible architecture
   specific implementation as well at some point in time.

- Split up the TCQ UDMA handling stuff in to proper functions. Jens must has
   been dreaming as he introduced them ;-).


--------------080905080306040000010406
Content-Type: text/plain;
 name="ide-clean-52.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-52.diff"

diff -urN linux-2.5.13/arch/cris/drivers/ide.c linux/arch/cris/drivers/ide.c
--- linux-2.5.13/arch/cris/drivers/ide.c	2002-05-03 02:22:45.000000000 +0200
+++ linux/arch/cris/drivers/ide.c	2002-05-04 04:01:08.000000000 +0200
@@ -191,7 +191,7 @@
 #define ATA_PIO0_STROBE 19
 #define ATA_PIO0_HOLD    4
 
-static int e100_dmaproc (ide_dma_action_t func, ide_drive_t *drive);
+static int e100_dmaproc(ide_dma_action_t func, struct ata_device *drive, struct request *rq);
 static void e100_ideproc (ide_ide_action_t func, ide_drive_t *drive,
 			  void *buffer, unsigned int length);
 
@@ -278,7 +278,7 @@
 
 		hwif->chipset = ide_etrax100;
 		hwif->tuneproc = &tune_e100_ide;
-		hwif->dmaproc = &e100_dmaproc;
+		hwif->udma = &e100_dmaproc;
 		hwif->ata_read = e100_ide_input_data;
 		hwif->ata_write = e100_ide_output_data;
 		hwif->atapi_read = e100_atapi_read;
@@ -564,13 +564,14 @@
 static etrax_dma_descr ata_descrs[MAX_DMA_DESCRS];
 static unsigned int ata_tot_size;
 
+
 /*
- * e100_ide_build_dmatable() prepares a dma request.
- * Returns 0 if all went okay, returns 1 otherwise.
+ * This prepares a dma request.  Returns 0 if all went okay, returns 1
+ * otherwise.
  */
-static int e100_ide_build_dmatable (ide_drive_t *drive)
+
+static int e100_udma_new_table(struct ata_channel *ch, struct request *rq)
 {
-	struct request *rq = HWGROUP(drive)->rq;
 	struct buffer_head *bh = rq->bh;
 	unsigned long size, addr;
 	unsigned int count = 0;
@@ -602,7 +603,7 @@
 		/* did we run out of descriptors? */
 
 		if(count >= MAX_DMA_DESCRS) {
-			printk("%s: too few DMA descriptors\n", drive->name);
+			printk("%s: too few DMA descriptors\n", ch->name);
 			return 1;
 		}
 
@@ -623,7 +624,7 @@
                    size > 131072 only one split is necessary */
 
 		if(size > 65536) {
- 		        /* ok we want to do IO at addr, size bytes. set up a new descriptor entry */
+		        /* ok we want to do IO at addr, size bytes. set up a new descriptor entry */
                         ata_descrs[count].sw_len = 0;  /* 0 means 65536, this is a 16-bit field */
                         ata_descrs[count].ctrl = 0;
                         ata_descrs[count].buf = addr;
@@ -656,7 +657,7 @@
 		return 0;
 	}
 
-	printk("%s: empty DMA table?\n", drive->name);
+	printk("%s: empty DMA table?\n", ch->name);
 	return 1;	/* let the PIO routines handle this weirdness */
 }
 
@@ -695,7 +696,7 @@
 	LED_DISK_READ(0);
 	LED_DISK_WRITE(0);
 
-	dma_stat = drive->channel->dmaproc(ide_dma_end, drive);
+	dma_stat = drive->channel->udma(ide_dma_end, drive, rq);
 	stat = GET_STAT();			/* get drive status */
 	if (OK_STAT(stat,DRIVE_READY,drive->bad_wstat|DRQ_STAT)) {
 		if (!dma_stat) {
@@ -726,7 +727,7 @@
  * the caller should revert to PIO for the current request.
  */
 
-static int e100_dmaproc (ide_dma_action_t func, ide_drive_t *drive)
+static int e100_dmaproc(ide_dma_action_t func, struct ata_device *drive, struct request *rq)
 {
         static unsigned int reading; /* static to support ide_dma_begin semantics */
 	int atapi = 0;
@@ -786,24 +787,21 @@
 
 		/* set up the Etrax DMA descriptors */
 
-		if(e100_ide_build_dmatable (drive))
+		if(e100_udma_new_table(drive->channel, rq))
 			return 1;
 
 		if(!atapi) {
 			/* set the irq handler which will finish the request when DMA is done */
-		
 			ide_set_handler(drive, &etrax_dma_intr, WAIT_CMD, NULL);
-			
+
 			/* issue cmd to drive */
-			
 			OUT_BYTE(WIN_READDMA, IDE_COMMAND_REG);
 		}
 
 		/* begin DMA */
-	      
 		*R_DMA_CH3_FIRST = virt_to_phys(ata_descrs);
 		*R_DMA_CH3_CMD   = IO_STATE(R_DMA_CH3_CMD, cmd, start);
-		
+
 		/* initiate a multi word dma read using DMA handshaking */
 		
 		*R_ATA_TRANSFER_CNT =
@@ -820,7 +818,7 @@
 		LED_DISK_READ(1);
 
 		D(printk("dma read of %d bytes.\n", ata_tot_size));
- 
+
 	} else {
 		/* writing */
 
@@ -829,29 +827,25 @@
 
 		/* set up the Etrax DMA descriptors */
 
-		if(e100_ide_build_dmatable (drive))
+		if(e100_udma_new_table(drive->channel, rq))
 			return 1;
 
 		if(!atapi) {
 			/* set the irq handler which will finish the request when DMA is done */
-				
 			ide_set_handler(drive, &etrax_dma_intr, WAIT_CMD, NULL);
-			
+
 			/* issue cmd to drive */
-			
 			OUT_BYTE(WIN_WRITEDMA, IDE_COMMAND_REG);
 		}
 
 		/* begin DMA */
-		
 		*R_DMA_CH2_FIRST = virt_to_phys(ata_descrs);
 		*R_DMA_CH2_CMD   = IO_STATE(R_DMA_CH2_CMD, cmd, start);
-		
+
 		/* initiate a multi word dma write using DMA handshaking */
-		
 		*R_ATA_TRANSFER_CNT =
 			IO_FIELD(R_ATA_TRANSFER_CNT, count, ata_tot_size >> 1);
-		
+
 		*R_ATA_CTRL_DATA =
 			IO_FIELD(R_ATA_CTRL_DATA, data,     IDE_DATA_REG) |
 			IO_STATE(R_ATA_CTRL_DATA, rw,       write) |
@@ -878,7 +872,7 @@
  * --- Marcin Dalecki
  */
 
-void ide_release_dma(struct ata_channel *hwif)
+void ide_release_dma(struct ata_channel *ch)
 {
 	/* empty */
 }
diff -urN linux-2.5.13/drivers/ide/ata-timing.h linux/drivers/ide/ata-timing.h
--- linux-2.5.13/drivers/ide/ata-timing.h	2002-05-03 02:22:55.000000000 +0200
+++ linux/drivers/ide/ata-timing.h	2002-05-04 05:43:45.000000000 +0200
@@ -74,12 +74,12 @@
  * It's a bit elaborate due to the legacy we have to bear.
  */
 
-extern short ata_timing_mode(ide_drive_t *drive, int map);
+extern short ata_timing_mode(struct ata_device *drive, int map);
 extern void ata_timing_quantize(struct ata_timing *t, struct ata_timing *q,
 		int T, int UT);
 extern void ata_timing_merge(struct ata_timing *a, struct ata_timing *b,
 		struct ata_timing *m, unsigned int what);
 extern struct ata_timing* ata_timing_data(short speed);
-extern int ata_timing_compute(ide_drive_t *drive,
+extern int ata_timing_compute(struct ata_device *drive,
 		short speed, struct ata_timing *t, int T, int UT);
 #endif
diff -urN linux-2.5.13/drivers/ide/cmd64x.c linux/drivers/ide/cmd64x.c
--- linux-2.5.13/drivers/ide/cmd64x.c	2002-05-03 02:22:49.000000000 +0200
+++ linux/drivers/ide/cmd64x.c	2002-05-04 03:59:44.000000000 +0200
@@ -208,10 +208,10 @@
  * This routine writes the prepared setup/active/recovery counts
  * for a drive into the cmd646 chipset registers to active them.
  */
-static void program_drive_counts (ide_drive_t *drive, int setup_count, int active_count, int recovery_count)
+static void program_drive_counts(struct ata_device *drive, int setup_count, int active_count, int recovery_count)
 {
 	unsigned long flags;
-	ide_drive_t *drives = drive->channel->drives;
+	struct ata_device *drives = drive->channel->drives;
 	byte temp_b;
 	static const byte setup_counts[] = {0x40, 0x40, 0x40, 0x80, 0, 0xc0};
 	static const byte recovery_counts[] =
@@ -277,7 +277,7 @@
  * 8: prefetch off, 9: prefetch on, 255: auto-select best mode.
  * Called with 255 at boot time.
  */
-static void cmd64x_tuneproc (ide_drive_t *drive, byte mode_wanted)
+static void cmd64x_tuneproc(struct ata_device *drive, byte mode_wanted)
 {
 	int recovery_time, clock_time;
 	byte recovery_count2, cycle_count;
@@ -351,7 +351,7 @@
 	}
 }
 
-static void cmd680_tuneproc (ide_drive_t *drive, byte mode_wanted)
+static void cmd680_tuneproc(struct ata_device *drive, byte mode_wanted)
 {
 	struct ata_channel *hwif = drive->channel;
 	struct pci_dev *dev	= hwif->pci_dev;
@@ -381,7 +381,7 @@
 	pci_write_config_word(dev, drive_pci, speedt);
 }
 
-static void config_cmd64x_chipset_for_pio (ide_drive_t *drive, byte set_speed)
+static void config_cmd64x_chipset_for_pio(struct ata_device *drive, byte set_speed)
 {
 	byte speed	= 0x00;
 	byte set_pio	= ata_timing_mode(drive, XFER_PIO | XFER_EPIO) - XFER_PIO_0;
@@ -392,7 +392,7 @@
 		(void) ide_config_drive_speed(drive, speed);
 }
 
-static void config_cmd680_chipset_for_pio (ide_drive_t *drive, byte set_speed)
+static void config_cmd680_chipset_for_pio(struct ata_device *drive, byte set_speed)
 {
 	struct ata_channel *hwif = drive->channel;
 	struct pci_dev *dev	= hwif->pci_dev;
@@ -418,7 +418,7 @@
 	}
 }
 
-static void config_chipset_for_pio (ide_drive_t *drive, byte set_speed)
+static void config_chipset_for_pio(struct ata_device *drive, byte set_speed)
 {
         if (drive->channel->pci_dev->device == PCI_DEVICE_ID_CMD_680) {
 		config_cmd680_chipset_for_pio(drive, set_speed);
@@ -427,7 +427,7 @@
 	}
 }
 
-static int cmd64x_tune_chipset (ide_drive_t *drive, byte speed)
+static int cmd64x_tune_chipset(struct ata_device *drive, byte speed)
 {
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	struct ata_channel *hwif = drive->channel;
@@ -496,7 +496,7 @@
 	return err;
 }
 
-static int cmd680_tune_chipset (ide_drive_t *drive, byte speed)
+static int cmd680_tune_chipset(struct ata_device *drive, byte speed)
 {
 	struct ata_channel *hwif = drive->channel;
 	struct pci_dev *dev	= hwif->pci_dev;
@@ -612,7 +612,7 @@
 }
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
-static int config_cmd64x_chipset_for_dma (ide_drive_t *drive, unsigned int rev, byte ultra_66)
+static int config_cmd64x_chipset_for_dma(struct ata_device *drive, unsigned int rev, byte ultra_66)
 {
 	struct hd_driveid *id	= drive->id;
 	struct ata_channel *hwif = drive->channel;
@@ -697,7 +697,7 @@
 	return rval;
 }
 
-static int config_cmd680_chipset_for_dma (ide_drive_t *drive)
+static int config_cmd680_chipset_for_dma(struct ata_device *drive)
 {
 	struct hd_driveid *id	= drive->id;
 	byte udma_66		= eighty_ninty_three(drive);
@@ -739,14 +739,14 @@
 	return rval;
 }
 
-static int config_chipset_for_dma (ide_drive_t *drive, unsigned int rev, byte ultra_66)
+static int config_chipset_for_dma(struct ata_device *drive, unsigned int rev, byte ultra_66)
 {
 	if (drive->channel->pci_dev->device == PCI_DEVICE_ID_CMD_680)
 		return (config_cmd680_chipset_for_dma(drive));
 	return (config_cmd64x_chipset_for_dma(drive, rev, ultra_66));
 }
 
-static int cmd64x_config_drive_for_dma (ide_drive_t *drive)
+static int cmd64x_config_drive_for_dma(struct ata_device *drive)
 {
 	struct hd_driveid *id	= drive->id;
 	struct ata_channel *hwif = drive->channel;
@@ -839,11 +839,12 @@
 
 static int cmd64x_dmaproc(ide_dma_action_t func, struct ata_device *drive, struct request *rq)
 {
-	byte dma_stat		= 0;
-	byte dma_alt_stat	= 0;
-	byte mask		= (drive->channel->unit) ? MRDMODE_INTR_CH1 : MRDMODE_INTR_CH0;
-	unsigned long dma_base	= drive->channel->dma_base;
-	struct pci_dev *dev	= drive->channel->pci_dev;
+	struct ata_channel *ch = drive->channel;
+	u8 dma_stat = 0;
+	u8 dma_alt_stat	= 0;
+	u8 mask	= (ch->unit) ? MRDMODE_INTR_CH1 : MRDMODE_INTR_CH0;
+	unsigned long dma_base	= ch->dma_base;
+	struct pci_dev *dev	= ch->pci_dev;
 	byte jack_slap		= ((dev->device == PCI_DEVICE_ID_CMD_648) || (dev->device == PCI_DEVICE_ID_CMD_649)) ? 1 : 0;
 
 	switch (func) {
@@ -855,9 +856,9 @@
 			dma_stat = inb(dma_base+2);		/* get DMA status */
 			outb(dma_stat|6, dma_base+2);		/* clear the INTR & ERROR bits */
 			if (jack_slap) {
-				byte dma_intr	= 0;
-				byte dma_mask	= (drive->channel->unit) ? ARTTIM23_INTR_CH1 : CFR_INTR_CH0;
-				byte dma_reg	= (drive->channel->unit) ? ARTTIM2 : CFR;
+				byte dma_intr = 0;
+				byte dma_mask = (ch->unit) ? ARTTIM23_INTR_CH1 : CFR_INTR_CH0;
+				byte dma_reg = (ch->unit) ? ARTTIM2 : CFR;
 				(void) pci_read_config_byte(dev, dma_reg, &dma_intr);
 				/*
 				 * DAMN BMIDE is not connected to PCI space!
@@ -866,7 +867,7 @@
 				 */
 				(void) pci_write_config_byte(dev, dma_reg, dma_intr|dma_mask);	/* clear the INTR bit */
 			}
-			ide_destroy_dmatable(drive);		/* purge DMA mappings */
+			udma_destroy_table(ch);	/* purge DMA mappings */
 			return (dma_stat & 7) != 4;		/* verify good DMA status */
 		case ide_dma_test_irq:	/* returns 1 if dma irq issued, 0 otherwise */
 			dma_stat = inb(dma_base+2);
@@ -891,8 +892,8 @@
  */
 static int cmd646_1_dmaproc(ide_dma_action_t func, struct ata_device *drive, struct request *rq)
 {
-	struct ata_channel *hwif = drive->channel;
-	unsigned long dma_base = hwif->dma_base;
+	struct ata_channel *ch = drive->channel;
+	unsigned long dma_base = ch->dma_base;
 	byte dma_stat;
 
 	switch (func) {
@@ -903,7 +904,7 @@
 			dma_stat = inb(dma_base+2);		/* get DMA status */
 			outb(inb(dma_base)&~1, dma_base);	/* stop DMA */
 			outb(dma_stat|6, dma_base+2);		/* clear the INTR & ERROR bits */
-			ide_destroy_dmatable(drive);		/* and free any DMA resources */
+			udma_destroy_table(ch);			/* and free any DMA resources */
 			return (dma_stat & 7) != 4;		/* verify good DMA status */
 		default:
 			break;
@@ -914,48 +915,48 @@
 }
 #endif /* CONFIG_BLK_DEV_IDEDMA */
 
-static int cmd680_busproc (ide_drive_t * drive, int state)
+static int cmd680_busproc(struct ata_device * drive, int state)
 {
 #if 0
-	struct ata_channel *hwif	= drive->channel;
-	u8 addr_mask		= (hwif->unit) ? 0xB0 : 0xA0;
+	struct ata_channel *ch	= drive->channel;
+	u8 addr_mask		= (ch->unit) ? 0xB0 : 0xA0;
 	u32 stat_config		= 0;
 
-        pci_read_config_dword(hwif->pci_dev, addr_mask, &stat_config);
+        pci_read_config_dword(ch->pci_dev, addr_mask, &stat_config);
 
-	if (!hwif)
+	if (!ch)
 		return -EINVAL;
 
 	switch (state) {
 		case BUSSTATE_ON:
-			hwif->drives[0].failures = 0;
-			hwif->drives[1].failures = 0;
+			ch->drives[0].failures = 0;
+			ch->drives[1].failures = 0;
 			break;
 		case BUSSTATE_OFF:
-			hwif->drives[0].failures = hwif->drives[0].max_failures + 1;
-			hwif->drives[1].failures = hwif->drives[1].max_failures + 1;
+			ch->drives[0].failures = ch->drives[0].max_failures + 1;
+			ch->drives[1].failures = ch->drives[1].max_failures + 1;
 			break;
 		case BUSSTATE_TRISTATE:
-			hwif->drives[0].failures = hwif->drives[0].max_failures + 1;
-			hwif->drives[1].failures = hwif->drives[1].max_failures + 1;
+			ch->drives[0].failures = ch->drives[0].max_failures + 1;
+			ch->drives[1].failures = ch->drives[1].max_failures + 1;
 			break;
 		default:
 			return 0;
 	}
-	hwif->bus_state = state;
+	ch->bus_state = state;
 #endif
 	return 0;
 }
 
-static void cmd680_reset (ide_drive_t *drive)
+static void cmd680_reset(struct ata_device *drive)
 {
 #if 0
-	struct ata_channel *hwif = drive->channel;
-	u8 addr_mask		= (hwif->unit) ? 0xB0 : 0xA0;
-	byte reset		= 0;
+	struct ata_channel *ch = drive->channel;
+	u8 addr_mask = (ch->unit) ? 0xB0 : 0xA0;
+	u8 reset = 0;
 
-	pci_read_config_byte(hwif->pci_dev, addr_mask, &reset);
-	pci_write_config_byte(hwif->pci_dev, addr_mask, reset|0x03);
+	pci_read_config_byte(ch->pci_dev, addr_mask, &reset);
+	pci_write_config_byte(ch->pci_dev, addr_mask, reset|0x03);
 #endif
 }
 
diff -urN linux-2.5.13/drivers/ide/hpt34x.c linux/drivers/ide/hpt34x.c
--- linux-2.5.13/drivers/ide/hpt34x.c	2002-05-04 06:07:13.000000000 +0200
+++ linux/drivers/ide/hpt34x.c	2002-05-04 03:53:29.000000000 +0200
@@ -312,10 +312,10 @@
  * by HighPoint|Triones Technologies, Inc.
  */
 
-int hpt34x_dmaproc (ide_dma_action_t func, struct ata_device *drive, struct request *rq)
+int hpt34x_dmaproc(ide_dma_action_t func, struct ata_device *drive, struct request *rq)
 {
-	struct ata_channel *hwif = drive->channel;
-	unsigned long dma_base = hwif->dma_base;
+	struct ata_channel *ch = drive->channel;
+	unsigned long dma_base = ch->dma_base;
 	unsigned int count, reading = 0;
 	byte dma_stat;
 
@@ -325,9 +325,9 @@
 		case ide_dma_read:
 			reading = 1 << 3;
 		case ide_dma_write:
-			if (!(count = ide_build_dmatable(drive, func)))
+			if (!(count = udma_new_table(ch, rq)))
 				return 1;	/* try PIO instead of DMA */
-			outl(hwif->dmatable_dma, dma_base + 4); /* PRD table */
+			outl(ch->dmatable_dma, dma_base + 4); /* PRD table */
 			reading |= 0x01;
 			outb(reading, dma_base);		/* specify r/w */
 			outb(inb(dma_base+2)|6, dma_base+2);	/* clear INTR & ERROR flags */
@@ -342,7 +342,7 @@
 			outb(inb(dma_base)&~1, dma_base);	/* stop DMA */
 			dma_stat = inb(dma_base+2);		/* get DMA status */
 			outb(dma_stat|6, dma_base+2);		/* clear the INTR & ERROR bits */
-			ide_destroy_dmatable(drive);		/* purge DMA mappings */
+			udma_destroy_table(ch);			/* purge DMA mappings */
 			return (dma_stat & 7) != 4;		/* verify good DMA status */
 		default:
 			break;
diff -urN linux-2.5.13/drivers/ide/icside.c linux/drivers/ide/icside.c
--- linux-2.5.13/drivers/ide/icside.c	2002-05-03 02:22:41.000000000 +0200
+++ linux/drivers/ide/icside.c	2002-05-04 05:33:38.000000000 +0200
@@ -242,9 +242,9 @@
 }
 
 static int
-icside_build_dmatable(ide_drive_t *drive, int reading)
+icside_udma_new_table(struct ata_channel *ch, struct request *rq)
 {
-	return drive->channel->sg_nents = ide_build_sglist(drive->channel, HWGROUP(drive)->rq);
+	return ch->sg_nents = ide_build_sglist(ch, rq);
 }
 
 /* Teardown mappings after DMA has completed.  */
@@ -332,7 +332,7 @@
 	int i;
 	byte stat, dma_stat;
 
-	dma_stat = drive->channel->dmaproc(ide_dma_end, drive);
+	dma_stat = drive->channel->udma(ide_dma_end, drive, rq);
 	stat = GET_STAT();			/* get drive status */
 	if (OK_STAT(stat,DRIVE_READY,drive->bad_wstat|DRQ_STAT)) {
 		if (!dma_stat) {
@@ -350,7 +350,7 @@
 
 
 static int
-icside_dma_check(ide_drive_t *drive)
+icside_dma_check(struct ata_device *drive, struct request *rq)
 {
 	struct hd_driveid *id = drive->id;
 	struct ata_channel *hwif = drive->channel;
@@ -381,14 +381,7 @@
 out:
 	func = icside_config_if(drive, xfer_mode);
 
-	return hwif->dmaproc(func, drive);
-}
-
-static int
-icside_dma_verbose(ide_drive_t *drive)
-{
-	printk(", DMA");
-	return 1;
+	return hwif->udma(func, drive, rq);
 }
 
 static int
@@ -413,12 +406,12 @@
 		return 0;
 
 	case ide_dma_check:
-		return icside_dma_check(drive);
+		return icside_dma_check(drive, rq);
 
 	case ide_dma_read:
 		reading = 1;
 	case ide_dma_write:
-		count = icside_build_dmatable(drive, reading);
+		count = icside_udma_new_table(hwif, rq);
 		if (!count)
 			return 1;
 		disable_dma(hwif->hw.dma);
@@ -458,9 +451,6 @@
 	case ide_dma_test_irq:
 		return inb((unsigned long)hwif->hw.priv) & 1;
 
-	case ide_dma_verbose:
-		return icside_dma_verbose(drive);
-
 	case ide_dma_timeout:
 	default:
 		printk("icside_dmaproc: unsupported function: %d\n", func);
diff -urN linux-2.5.13/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.13/drivers/ide/ide.c	2002-05-04 06:07:15.000000000 +0200
+++ linux/drivers/ide/ide.c	2002-05-04 05:31:42.000000000 +0200
@@ -226,7 +226,7 @@
  * of the kernel (such as memory allocation) to be functioning yet.
  *
  * This is too bad, as otherwise we could dynamically allocate the
- * ide_drive_t structs as needed, rather than always consuming memory
+ * ata_device structs as needed, rather than always consuming memory
  * for the max possible number (MAX_HWIFS * MAX_DRIVES) of them.
  */
 #define MAGIC_COOKIE 0x12345678
@@ -263,24 +263,29 @@
  * At that time, we might also consider parameterizing the timeouts and retries,
  * since these are MUCH faster than mechanical drives.	-M.Lord
  */
-int drive_is_flashcard (ide_drive_t *drive)
+int drive_is_flashcard(struct ata_device *drive)
 {
 	struct hd_driveid *id = drive->id;
+	int i;
+
+	char *flashcards[] = {
+		"KODAK ATA_FLASH",
+		"Hitachi CV",
+		"SunDisk SDCFB",
+		"HAGIWARA HPC",
+		"LEXAR ATA_FLASH",
+		"ATA_FLASH"		/* Simple Tech */
+	};
 
 	if (drive->removable && id != NULL) {
 		if (id->config == 0x848a)
 			return 1;	/* CompactFlash */
-		if (!strncmp(id->model, "KODAK ATA_FLASH", 15)	/* Kodak */
-		 || !strncmp(id->model, "Hitachi CV", 10)	/* Hitachi */
-		 || !strncmp(id->model, "SunDisk SDCFB", 13)	/* SunDisk */
-		 || !strncmp(id->model, "HAGIWARA HPC", 12)	/* Hagiwara */
-		 || !strncmp(id->model, "LEXAR ATA_FLASH", 15)	/* Lexar */
-		 || !strncmp(id->model, "ATA_FLASH", 9))	/* Simple Tech */
-		{
-			return 1;	/* yes, it is a flash memory card */
-		}
+		for (i = 0; i < ARRAY_SIZE(flashcards); i++)
+			if (!strncmp(id->model, flashcards[i],
+				     strlen(flashcards[i])))
+				return 1;
 	}
-	return 0;	/* no, it is not a flash memory card */
+	return 0;
 }
 
 int __ide_end_request(struct ata_device *drive, struct request *rq, int uptodate, int nr_secs)
@@ -446,7 +451,7 @@
 	}
 }
 
-static ide_startstop_t do_reset1(ide_drive_t *, int);		/* needed below */
+static ide_startstop_t do_reset1(struct ata_device *, int); /* needed below */
 
 /*
  * Poll the interface for completion every 50ms during an ATAPI drive reset
@@ -546,7 +551,7 @@
  * for it, we set a timer to poll at 50ms intervals.
  */
 
-static ide_startstop_t do_reset1 (ide_drive_t *drive, int do_not_try_atapi)
+static ide_startstop_t do_reset1(struct ata_device *drive, int do_not_try_atapi)
 {
 	unsigned int unit;
 	unsigned long flags;
@@ -614,7 +619,7 @@
 	return ide_started;
 }
 
-static inline u32 read_24 (ide_drive_t *drive)
+static inline u32 read_24(struct ata_device *drive)
 {
 	return  (IN_BYTE(IDE_HCYL_REG)<<16) |
 		(IN_BYTE(IDE_LCYL_REG)<<8) |
@@ -678,7 +683,7 @@
 /*
  * Error reporting, in human readable form (luxurious, but a memory hog).
  */
-byte ide_dump_status (ide_drive_t *drive, const char *msg, byte stat)
+byte ide_dump_status(struct ata_device *drive, const char *msg, byte stat)
 {
 	unsigned long flags;
 	byte err = 0;
@@ -770,7 +775,7 @@
  * condition by reading a sector's worth of data from the drive.  Of course,
  * this may not help if the drive is *waiting* for data from *us*.
  */
-static void try_to_flush_leftover_data (ide_drive_t *drive)
+static void try_to_flush_leftover_data(struct ata_device *drive)
 {
 	int i;
 
@@ -787,7 +792,7 @@
 /*
  * Take action based on the error returned by the drive.
  */
-ide_startstop_t ide_error(ide_drive_t *drive, const char *msg, byte stat)
+ide_startstop_t ide_error(struct ata_device *drive, const char *msg, byte stat)
 {
 	struct request *rq;
 	byte err;
@@ -844,7 +849,7 @@
 /*
  * Issue a simple drive command.  The drive must be selected beforehand.
  */
-void ide_cmd(ide_drive_t *drive, byte cmd, byte nsect, ata_handler_t handler)
+void ide_cmd(struct ata_device *drive, byte cmd, byte nsect, ata_handler_t handler)
 {
 	ide_set_handler (drive, handler, WAIT_CMD, NULL);
 	if (IDE_CONTROL_REG)
@@ -889,7 +894,7 @@
  * setting a timer to wake up at half second intervals thereafter, until
  * timeout is achieved, before timing out.
  */
-int ide_wait_stat(ide_startstop_t *startstop, ide_drive_t *drive, byte good, byte bad, unsigned long timeout) {
+int ide_wait_stat(ide_startstop_t *startstop, struct ata_device *drive, byte good, byte bad, unsigned long timeout) {
 	byte stat;
 	int i;
 	unsigned long flags;
@@ -933,7 +938,7 @@
 /*
  * This initiates handling of a new I/O request.
  */
-static ide_startstop_t start_request(ide_drive_t *drive, struct request *rq)
+static ide_startstop_t start_request(struct ata_device *drive, struct request *rq)
 {
 	sector_t block;
 	unsigned int minor = minor(rq->rq_dev);
@@ -1081,7 +1086,7 @@
 	return ide_stopped;
 }
 
-ide_startstop_t restart_request(ide_drive_t *drive)
+ide_startstop_t restart_request(struct ata_device *drive)
 {
 	ide_hwgroup_t *hwgroup = HWGROUP(drive);
 	unsigned long flags;
@@ -1100,7 +1105,7 @@
  * This is used by a drive to give excess bandwidth back to the hwgroup by
  * sleeping for timeout jiffies.
  */
-void ide_stall_queue(ide_drive_t *drive, unsigned long timeout)
+void ide_stall_queue(struct ata_device *drive, unsigned long timeout)
 {
 	if (timeout > WAIT_WORSTCASE)
 		timeout = WAIT_WORSTCASE;
@@ -1681,10 +1686,10 @@
 }
 
 /*
- * get_info_ptr() returns the (ide_drive_t *) for a given device number.
+ * get_info_ptr() returns the (struct ata_device *) for a given device number.
  * It returns NULL if the given device number does not match any present drives.
  */
-ide_drive_t *get_info_ptr(kdev_t i_rdev)
+struct ata_device *get_info_ptr(kdev_t i_rdev)
 {
 	unsigned int major = major(i_rdev);
 	int h;
@@ -2012,25 +2017,13 @@
 	if (ch->straight8) {
 		release_region(ch->io_ports[IDE_DATA_OFFSET], 8);
 	} else {
-		if (ch->io_ports[IDE_DATA_OFFSET])
-			release_region(ch->io_ports[IDE_DATA_OFFSET], 1);
-		if (ch->io_ports[IDE_ERROR_OFFSET])
-			release_region(ch->io_ports[IDE_ERROR_OFFSET], 1);
-		if (ch->io_ports[IDE_NSECTOR_OFFSET])
-			release_region(ch->io_ports[IDE_NSECTOR_OFFSET], 1);
-		if (ch->io_ports[IDE_SECTOR_OFFSET])
-			release_region(ch->io_ports[IDE_SECTOR_OFFSET], 1);
-		if (ch->io_ports[IDE_LCYL_OFFSET])
-			release_region(ch->io_ports[IDE_LCYL_OFFSET], 1);
-		if (ch->io_ports[IDE_HCYL_OFFSET])
-			release_region(ch->io_ports[IDE_HCYL_OFFSET], 1);
-		if (ch->io_ports[IDE_SELECT_OFFSET])
-			release_region(ch->io_ports[IDE_SELECT_OFFSET], 1);
-		if (ch->io_ports[IDE_STATUS_OFFSET])
-			release_region(ch->io_ports[IDE_STATUS_OFFSET], 1);
+		for (i = 0; i < 8; i++)
+			if (ch->io_ports[i])
+				release_region(ch->io_ports[i], 1);
 	}
 	if (ch->io_ports[IDE_CONTROL_OFFSET])
 		release_region(ch->io_ports[IDE_CONTROL_OFFSET], 1);
+/* FIXME: check if we can remove this ifdef */
 #if defined(CONFIG_AMIGA) || defined(CONFIG_MAC)
 	if (ch->io_ports[IDE_IRQ_OFFSET])
 		release_region(ch->io_ports[IDE_IRQ_OFFSET], 1);
@@ -2129,7 +2122,6 @@
 	ch->intrproc = old.intrproc;
 	ch->maskproc = old.maskproc;
 	ch->quirkproc = old.quirkproc;
-	ch->rwproc	= old.rwproc;
 	ch->ata_read = old.ata_read;
 	ch->ata_write = old.ata_write;
 	ch->atapi_read = old.atapi_read;
@@ -2172,24 +2164,18 @@
 	int i;
 
 	for (i = 0; i < IDE_NR_PORTS; i++) {
-		if (offsets[i] == -1) {
-			switch(i) {
-				case IDE_CONTROL_OFFSET:
-					hw->io_ports[i] = ctrl;
-					break;
-#if defined(CONFIG_AMIGA) || defined(CONFIG_MAC)
-				case IDE_IRQ_OFFSET:
-					hw->io_ports[i] = intr;
-					break;
-#endif
-				default:
-					hw->io_ports[i] = 0;
-					break;
-			}
-		} else {
+		if (offsets[i] != -1)
 			hw->io_ports[i] = base + offsets[i];
-		}
+		else
+			hw->io_ports[i] = 0;
 	}
+	if (offsets[IDE_CONTROL_OFFSET] == -1)
+		hw->io_ports[IDE_CONTROL_OFFSET] = ctrl;
+/* FIMXE: check if we can remove this ifdef */
+#if defined(CONFIG_AMIGA) || defined(CONFIG_MAC)
+	if (offsets[IDE_IRQ_OFFSET] == -1)
+		hw->io_ports[IDE_IRQ_OFFSET] = intr;
+#endif
 	hw->irq = irq;
 	hw->dma = NO_DMA;
 	hw->ack_intr = ack_intr;
@@ -2261,7 +2247,7 @@
 	return ide_register_hw(&hw, NULL);
 }
 
-void ide_add_setting(ide_drive_t *drive, const char *name, int rw, int read_ioctl, int write_ioctl, int data_type, int min, int max, int mul_factor, int div_factor, void *data, ide_procset_t *set)
+void ide_add_setting(struct ata_device *drive, const char *name, int rw, int read_ioctl, int write_ioctl, int data_type, int min, int max, int mul_factor, int div_factor, void *data, ide_procset_t *set)
 {
 	ide_settings_t **p = &drive->settings;
 	ide_settings_t *setting = NULL;
@@ -2288,7 +2274,7 @@
 		kfree(setting);
 }
 
-void ide_remove_setting (ide_drive_t *drive, char *name)
+void ide_remove_setting(struct ata_device *drive, char *name)
 {
 	ide_settings_t **p = &drive->settings, *setting;
 
@@ -2301,7 +2287,7 @@
 	kfree(setting);
 }
 
-static void auto_remove_settings (ide_drive_t *drive)
+static void auto_remove_settings(struct ata_device *drive)
 {
 	ide_settings_t *setting;
 repeat:
@@ -2315,10 +2301,10 @@
 	}
 }
 
-int ide_read_setting (ide_drive_t *drive, ide_settings_t *setting)
+int ide_read_setting(struct ata_device *drive, ide_settings_t *setting)
 {
-	int		val = -EINVAL;
-	unsigned long	flags;
+	int val = -EINVAL;
+	unsigned long flags;
 
 	if ((setting->rw & SETTING_READ)) {
 		spin_lock_irqsave(&ide_lock, flags);
@@ -2339,7 +2325,7 @@
 	return val;
 }
 
-int ide_spin_wait_hwgroup (ide_drive_t *drive)
+int ide_spin_wait_hwgroup(struct ata_device *drive)
 {
 	ide_hwgroup_t *hwgroup = HWGROUP(drive);
 	unsigned long timeout = jiffies + (3 * HZ);
@@ -2367,7 +2353,7 @@
  * to the driver to change settings, and then wait on a semaphore for completion.
  * The current scheme of polling is kludgey, though safe enough.
  */
-int ide_write_setting (ide_drive_t *drive, ide_settings_t *setting, int val)
+int ide_write_setting(struct ata_device *drive, ide_settings_t *setting, int val)
 {
 	int i;
 	u32 *p;
@@ -2412,7 +2398,7 @@
 	return 0;
 }
 
-static int set_using_dma(ide_drive_t *drive, int arg)
+static int set_using_dma(struct ata_device *drive, int arg)
 {
 	if (!drive->driver)
 		return -EPERM;
@@ -2423,7 +2409,7 @@
 	return 0;
 }
 
-static int set_pio_mode(ide_drive_t *drive, int arg)
+static int set_pio_mode(struct ata_device *drive, int arg)
 {
 	struct request rq;
 
@@ -2441,7 +2427,7 @@
 	return 0;
 }
 
-void ide_add_generic_settings (ide_drive_t *drive)
+void ide_add_generic_settings(struct ata_device *drive)
 {
 /*			drive	setting name		read/write access				read ioctl		write ioctl		data type	min	max				mul_factor	div_factor	data pointer			set function */
 	ide_add_setting(drive,	"io_32bit",		drive->channel->no_io_32bit ? SETTING_READ : SETTING_RW,	HDIO_GET_32BIT,		HDIO_SET_32BIT,		TYPE_BYTE,	0,	1 + (SUPPORT_VLB_SYNC << 1),	1,		1,		&drive->channel->io_32bit,		set_io_32bit);
@@ -2476,7 +2462,7 @@
 static int ide_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
 {
 	int err = 0, major, minor;
-	ide_drive_t *drive;
+	struct ata_device *drive;
 	struct request rq;
 	kdev_t dev;
 	ide_settings_t *setting;
@@ -2630,7 +2616,7 @@
 
 static int ide_check_media_change (kdev_t i_rdev)
 {
-	ide_drive_t *drive;
+	struct ata_device *drive;
 	int res = 0; /* not changed */
 
 	drive = get_info_ptr(i_rdev);
@@ -2828,7 +2814,7 @@
 {
 	int i, vals[3];
 	struct ata_channel *hwif;
-	ide_drive_t *drive;
+	struct ata_device *drive;
 	unsigned int hw, unit;
 	const char max_drive = 'a' + ((MAX_HWIFS * MAX_DRIVES) - 1);
 	const char max_hwif  = '0' + (MAX_HWIFS - 1);
@@ -3144,7 +3130,7 @@
 /*
  * Lookup ATA devices, which requested a particular driver.
  */
-ide_drive_t *ide_scan_devices(byte type, const char *name, struct ata_operations *driver, int n)
+struct ata_device *ide_scan_devices(byte type, const char *name, struct ata_operations *driver, int n)
 {
 	unsigned int unit, index, i;
 
@@ -3171,7 +3157,7 @@
 /*
  * This is in fact registering a drive not a driver.
  */
-int ide_register_subdriver(ide_drive_t *drive, struct ata_operations *driver)
+int ide_register_subdriver(struct ata_device *drive, struct ata_operations *driver)
 {
 	unsigned long flags;
 
@@ -3204,7 +3190,7 @@
 			drive->channel->udma(ide_dma_off_quietly, drive, NULL);
 			drive->channel->udma(ide_dma_check, drive, NULL);
 #ifdef CONFIG_BLK_DEV_IDE_TCQ_DEFAULT
-			drive->channel->udma(ide_dma_queued_on, drive, NULL);
+			udma_tcq_enable(drive, 1);
 #endif
 		}
 
@@ -3238,7 +3224,7 @@
  *
  * FIXME: Check whatever we maybe don't call it twice!.
  */
-int ide_unregister_subdriver(ide_drive_t *drive)
+int ide_unregister_subdriver(struct ata_device *drive)
 {
 	unsigned long flags;
 
diff -urN linux-2.5.13/drivers/ide/ide-cd.c linux/drivers/ide/ide-cd.c
--- linux-2.5.13/drivers/ide/ide-cd.c	2002-05-03 02:22:51.000000000 +0200
+++ linux/drivers/ide/ide-cd.c	2002-05-04 04:27:35.000000000 +0200
@@ -2652,7 +2652,7 @@
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	if (drive->using_dma)
-		(void) drive->channel->udma(ide_dma_verbose, drive, NULL);
+		udma_print(drive);
 #endif
 	printk("\n");
 
diff -urN linux-2.5.13/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
--- linux-2.5.13/drivers/ide/ide-disk.c	2002-05-04 06:07:15.000000000 +0200
+++ linux/drivers/ide/ide-disk.c	2002-05-04 05:54:14.000000000 +0200
@@ -89,7 +89,7 @@
 	return 0;	/* lba_capacity value may be bad */
 }
 
-static u8 get_command(ide_drive_t *drive, int cmd)
+static u8 get_command(struct ata_device *drive, int cmd)
 {
 	int lba48bit = (drive->id->cfs_enable_2 & 0x0400) ? 1 : 0;
 
@@ -345,7 +345,7 @@
 	return chs_do_request(drive, rq, block);
 }
 
-static int idedisk_open (struct inode *inode, struct file *filp, ide_drive_t *drive)
+static int idedisk_open (struct inode *inode, struct file *filp, struct ata_device *drive)
 {
 	MOD_INC_USE_COUNT;
 	if (drive->removable && drive->usage == 1) {
@@ -370,7 +370,7 @@
 	return 0;
 }
 
-static int idedisk_flushcache(ide_drive_t *drive)
+static int idedisk_flushcache(struct ata_device *drive)
 {
 	struct ata_taskfile args;
 
@@ -386,7 +386,7 @@
 	return ide_raw_taskfile(drive, &args, NULL);
 }
 
-static void idedisk_release (struct inode *inode, struct file *filp, ide_drive_t *drive)
+static void idedisk_release (struct inode *inode, struct file *filp, struct ata_device *drive)
 {
 	if (drive->removable && !drive->usage) {
 		struct ata_taskfile args;
@@ -408,7 +408,7 @@
 	MOD_DEC_USE_COUNT;
 }
 
-static int idedisk_check_media_change (ide_drive_t *drive)
+static int idedisk_check_media_change(struct ata_device *drive)
 {
 	/* if removable, always assume it was changed */
 	return drive->removable;
@@ -474,7 +474,7 @@
 	return IS_PDC4030_DRIVE ? ide_stopped : ide_started;
 }
 
-static void idedisk_pre_reset (ide_drive_t *drive)
+static void idedisk_pre_reset(struct ata_device *drive)
 {
 	int legacy = (drive->id->cfs_enable_2 & 0x0400) ? 0 : 1;
 
@@ -490,7 +490,7 @@
 
 #ifdef CONFIG_PROC_FS
 
-static int smart_enable(ide_drive_t *drive)
+static int smart_enable(struct ata_device *drive)
 {
 	struct ata_taskfile args;
 
@@ -504,7 +504,7 @@
 	return ide_raw_taskfile(drive, &args, NULL);
 }
 
-static int get_smart_values(ide_drive_t *drive, u8 *buf)
+static int get_smart_values(struct ata_device *drive, u8 *buf)
 {
 	struct ata_taskfile args;
 
@@ -521,7 +521,7 @@
 	return ide_raw_taskfile(drive, &args, buf);
 }
 
-static int get_smart_thresholds(ide_drive_t *drive, u8 *buf)
+static int get_smart_thresholds(struct ata_device *drive, u8 *buf)
 {
 	struct ata_taskfile args;
 
@@ -541,7 +541,7 @@
 static int proc_idedisk_read_cache
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
-	ide_drive_t	*drive = (ide_drive_t *) data;
+	struct ata_device *drive = (struct ata_device *) data;
 	char		*out = page;
 	int		len;
 
@@ -555,7 +555,7 @@
 static int proc_idedisk_read_smart_thresholds
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
-	ide_drive_t	*drive = (ide_drive_t *)data;
+	struct ata_device *drive = (struct ata_device *)data;
 	int		len = 0, i = 0;
 
 	if (!get_smart_thresholds(drive, page)) {
@@ -574,8 +574,8 @@
 static int proc_idedisk_read_smart_values
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
-	ide_drive_t	*drive = (ide_drive_t *)data;
-	int		len = 0, i = 0;
+	struct ata_device *drive = (struct ata_device *)data;
+	int len = 0, i = 0;
 
 	if (!get_smart_values(drive, page)) {
 		unsigned short *val = (unsigned short *) page;
@@ -594,7 +594,7 @@
 static int proc_idedisk_read_tcq
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
-	ide_drive_t	*drive = (ide_drive_t *) data;
+	struct ata_device *drive = (struct ata_device *) data;
 	char		*out = page;
 	int		len, cmds, i;
 	unsigned long	flags;
@@ -658,7 +658,7 @@
  * This is tightly woven into the driver->special can not touch.
  * DON'T do it again until a total personality rewrite is committed.
  */
-static int set_multcount(ide_drive_t *drive, int arg)
+static int set_multcount(struct ata_device *drive, int arg)
 {
 	struct request rq;
 
@@ -670,12 +670,12 @@
 	drive->mult_req = arg;
 	drive->special_cmd |= ATA_SPECIAL_MMODE;
 
-	ide_do_drive_cmd (drive, &rq, ide_wait);
+	ide_do_drive_cmd(drive, &rq, ide_wait);
 
 	return (drive->mult_count == arg) ? 0 : -EIO;
 }
 
-static int set_nowerr(ide_drive_t *drive, int arg)
+static int set_nowerr(struct ata_device *drive, int arg)
 {
 	if (ide_spin_wait_hwgroup(drive))
 		return -EBUSY;
@@ -686,7 +686,7 @@
 	return 0;
 }
 
-static int write_cache(ide_drive_t *drive, int arg)
+static int write_cache(struct ata_device *drive, int arg)
 {
 	struct ata_taskfile args;
 
@@ -704,7 +704,7 @@
 	return 0;
 }
 
-static int idedisk_standby(ide_drive_t *drive)
+static int idedisk_standby(struct ata_device *drive)
 {
 	struct ata_taskfile args;
 
@@ -715,7 +715,7 @@
 	return ide_raw_taskfile(drive, &args, NULL);
 }
 
-static int set_acoustic(ide_drive_t *drive, int arg)
+static int set_acoustic(struct ata_device *drive, int arg)
 {
 	struct ata_taskfile args;
 
@@ -732,7 +732,7 @@
 }
 
 #ifdef CONFIG_BLK_DEV_IDE_TCQ
-static int set_using_tcq(ide_drive_t *drive, int arg)
+static int set_using_tcq(struct ata_device *drive, int arg)
 {
 	if (!drive->driver)
 		return -EPERM;
@@ -750,14 +750,14 @@
 			drive->queue_depth = drive->id->queue_depth + 1;
 	}
 
-	if (drive->channel->udma(arg ? ide_dma_queued_on : ide_dma_queued_off, drive, NULL))
+	if (udma_tcq_enable(drive, arg))
 		return -EIO;
 
 	return 0;
 }
 #endif
 
-static int probe_lba_addressing (ide_drive_t *drive, int arg)
+static int probe_lba_addressing(struct ata_device *drive, int arg)
 {
 	drive->addressing =  0;
 
@@ -768,12 +768,12 @@
 	return 0;
 }
 
-static int set_lba_addressing (ide_drive_t *drive, int arg)
+static int set_lba_addressing(struct ata_device *drive, int arg)
 {
 	return (probe_lba_addressing(drive, arg));
 }
 
-static void idedisk_add_settings(ide_drive_t *drive)
+static void idedisk_add_settings(struct ata_device *drive)
 {
 	struct hd_driveid *id = drive->id;
 
@@ -795,7 +795,7 @@
 
 static int idedisk_suspend(struct device *dev, u32 state, u32 level)
 {
-	ide_drive_t *drive = dev->driver_data;
+	struct ata_device *drive = dev->driver_data;
 
 	/* I hope that every freeze operations from the upper levels have
 	 * already been done...
@@ -822,7 +822,7 @@
 
 static int idedisk_resume(struct device *dev, u32 level)
 {
-	ide_drive_t *drive = dev->driver_data;
+	struct ata_device *drive = dev->driver_data;
 
 	if (level != RESUME_RESTORE_STATE)
 		return 0;
@@ -916,7 +916,7 @@
  * Sets maximum virtual LBA address of the drive.
  * Returns new maximum virtual LBA address (> 0) or 0 on failure.
  */
-static sector_t set_max_address(ide_drive_t *drive, sector_t addr_req)
+static sector_t set_max_address(struct ata_device *drive, sector_t addr_req)
 {
 	struct ata_taskfile args;
 	sector_t addr_set = 0;
@@ -945,7 +945,7 @@
 	return addr_set;
 }
 
-static u64 set_max_address_ext(ide_drive_t *drive, u64 addr_req)
+static u64 set_max_address_ext(struct ata_device *drive, u64 addr_req)
 {
 	struct ata_taskfile args;
 	u64 addr_set = 0;
@@ -1177,7 +1177,7 @@
 	       drive->bios_cyl, drive->bios_head, drive->bios_sect);
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	if (drive->using_dma)
-		(void) drive->channel->udma(ide_dma_verbose, drive, NULL);
+		udma_print(drive);
 #endif
 	printk("\n");
 
@@ -1213,7 +1213,7 @@
 	probe_lba_addressing(drive, 1);
 }
 
-static int idedisk_cleanup(ide_drive_t *drive)
+static int idedisk_cleanup(struct ata_device *drive)
 {
 	if (!drive)
 	    return 0;
@@ -1250,7 +1250,7 @@
 
 static void __exit idedisk_exit (void)
 {
-	ide_drive_t *drive;
+	struct ata_device *drive;
 	int failed = 0;
 
 	while ((drive = ide_scan_devices(ATA_DISK, "ide-disk", &idedisk_driver, failed)) != NULL) {
@@ -1267,9 +1267,9 @@
 	}
 }
 
-int idedisk_init (void)
+int idedisk_init(void)
 {
-	ide_drive_t *drive;
+	struct ata_device *drive;
 	int failed = 0;
 
 	MOD_INC_USE_COUNT;
diff -urN linux-2.5.13/drivers/ide/ide-dma.c linux/drivers/ide/ide-dma.c
--- linux-2.5.13/drivers/ide/ide-dma.c	2002-05-04 06:07:15.000000000 +0200
+++ linux/drivers/ide/ide-dma.c	2002-05-04 06:00:00.000000000 +0200
@@ -1,4 +1,5 @@
-/*
+/**** vi:set ts=8 sts=8 sw=8:************************************************
+ *
  *  Copyright (c) 1999-2000  Andre Hedrick <andre@linux-ide.org>
  *  Copyright (c) 1995-1998  Mark Lord
  *
@@ -63,12 +64,12 @@
  *
  * And, yes, Intel Zappa boards really *do* use both PIIX IDE ports.
  *
- * check_drive_lists(ide_drive_t *drive, int good_bad)
- *
  * ATA-66/100 and recovery functions, I forgot the rest......
  */
 
 #include <linux/config.h>
+#define __NO_VERSION__
+#include <linux/module.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/timer.h>
@@ -192,11 +193,11 @@
 #endif
 
 /*
- * dma_intr() is the handler for disk read/write DMA interrupts
+ * This is the handler for disk read/write DMA interrupts.
  */
 ide_startstop_t ide_dma_intr(struct ata_device *drive, struct request *rq)
 {
-	byte stat, dma_stat;
+	u8 stat, dma_stat;
 
 	dma_stat = drive->channel->udma(ide_dma_end, drive, rq);
 	if (OK_STAT(stat = GET_STAT(),DRIVE_READY,drive->bad_wstat|DRQ_STAT)) {
@@ -204,7 +205,7 @@
 			__ide_end_request(drive, rq, 1, rq->nr_sectors);
 			return ide_stopped;
 		}
-		printk("%s: dma_intr: bad DMA status (dma_stat=%x)\n",
+		printk(KERN_ERR "%s: dma_intr: bad DMA status (dma_stat=%x)\n",
 		       drive->name, dma_stat);
 	}
 	return ide_error(drive, "dma_intr", stat);
@@ -270,106 +271,11 @@
 }
 
 /*
- * This prepares a dma request.  Returns 0 if all went okay, returns 1
- * otherwise.  May also be invoked from trm290.c
- */
-int ide_build_dmatable(struct ata_device *drive, ide_dma_action_t func)
-{
-	struct ata_channel *ch = drive->channel;
-	unsigned int *table = ch->dmatable_cpu;
-#ifdef CONFIG_BLK_DEV_TRM290
-	unsigned int is_trm290_chipset = (ch->chipset == ide_trm290);
-#else
-	const int is_trm290_chipset = 0;
-#endif
-	unsigned int count = 0;
-	int i;
-	struct scatterlist *sg;
-
-	ch->sg_nents = i = build_sglist(ch, HWGROUP(drive)->rq);
-	if (!i)
-		return 0;
-
-	sg = ch->sg_table;
-	while (i) {
-		u32 cur_addr;
-		u32 cur_len;
-
-		cur_addr = sg_dma_address(sg);
-		cur_len = sg_dma_len(sg);
-
-		/*
-		 * Fill in the dma table, without crossing any 64kB boundaries.
-		 * Most hardware requires 16-bit alignment of all blocks,
-		 * but the trm290 requires 32-bit alignment.
-		 */
-
-		while (cur_len) {
-			u32 xcount, bcount = 0x10000 - (cur_addr & 0xffff);
-
-			if (count++ >= PRD_ENTRIES) {
-				printk("ide-dma: count %d, sg_nents %d, cur_len %d, cur_addr %u\n",
-						count, ch->sg_nents, cur_len, cur_addr);
-				BUG();
-			}
-
-			if (bcount > cur_len)
-				bcount = cur_len;
-			*table++ = cpu_to_le32(cur_addr);
-			xcount = bcount & 0xffff;
-			if (is_trm290_chipset)
-				xcount = ((xcount >> 2) - 1) << 16;
-			if (xcount == 0x0000) {
-		        /*
-			 * Most chipsets correctly interpret a length of
-			 * 0x0000 as 64KB, but at least one (e.g. CS5530)
-			 * misinterprets it as zero (!). So here we break
-			 * the 64KB entry into two 32KB entries instead.
-			 */
-				if (count++ >= PRD_ENTRIES) {
-					pci_unmap_sg(ch->pci_dev, sg,
-						     ch->sg_nents,
-						     ch->sg_dma_direction);
-					return 0;
-				}
-
-				*table++ = cpu_to_le32(0x8000);
-				*table++ = cpu_to_le32(cur_addr + 0x8000);
-				xcount = 0x8000;
-			}
-			*table++ = cpu_to_le32(xcount);
-			cur_addr += bcount;
-			cur_len -= bcount;
-		}
-
-		sg++;
-		i--;
-	}
-
-	if (!count)
-		printk("%s: empty DMA table?\n", drive->name);
-	else if (!is_trm290_chipset)
-		*--table |= cpu_to_le32(0x80000000);
-
-	return count;
-}
-
-/* Teardown mappings after DMA has completed.  */
-void ide_destroy_dmatable (ide_drive_t *drive)
-{
-	struct pci_dev *dev = drive->channel->pci_dev;
-	struct scatterlist *sg = drive->channel->sg_table;
-	int nents = drive->channel->sg_nents;
-
-	pci_unmap_sg(dev, sg, nents, drive->channel->sg_dma_direction);
-}
-
-/*
  *  For both Blacklisted and Whitelisted drives.
  *  This is setup to be called as an extern for future support
  *  to other special driver code.
  */
-int check_drive_lists (ide_drive_t *drive, int good_bad)
+int check_drive_lists(struct ata_device *drive, int good_bad)
 {
 	struct hd_driveid *id = drive->id;
 
@@ -407,80 +313,43 @@
 	return 0;
 }
 
-int report_drive_dmaing (ide_drive_t *drive)
-{
-	struct hd_driveid *id = drive->id;
-
-	if ((id->field_valid & 4) && (eighty_ninty_three(drive)) &&
-	    (id->dma_ultra & (id->dma_ultra >> 14) & 3)) {
-		if ((id->dma_ultra >> 15) & 1) {
-			printk(", UDMA(mode 7)");	/* UDMA BIOS-enabled! */
-		} else {
-			printk(", UDMA(133)");	/* UDMA BIOS-enabled! */
-		}
-	} else if ((id->field_valid & 4) && (eighty_ninty_three(drive)) &&
-	  	  (id->dma_ultra & (id->dma_ultra >> 11) & 7)) {
-		if ((id->dma_ultra >> 13) & 1) {
-			printk(", UDMA(100)");	/* UDMA BIOS-enabled! */
-		} else if ((id->dma_ultra >> 12) & 1) {
-			printk(", UDMA(66)");	/* UDMA BIOS-enabled! */
-		} else {
-			printk(", UDMA(44)");	/* UDMA BIOS-enabled! */
-		}
-	} else if ((id->field_valid & 4) &&
-		   (id->dma_ultra & (id->dma_ultra >> 8) & 7)) {
-		if ((id->dma_ultra >> 10) & 1) {
-			printk(", UDMA(33)");	/* UDMA BIOS-enabled! */
-		} else if ((id->dma_ultra >> 9) & 1) {
-			printk(", UDMA(25)");	/* UDMA BIOS-enabled! */
-		} else {
-			printk(", UDMA(16)");	/* UDMA BIOS-enabled! */
-		}
-	} else if (id->field_valid & 4) {
-		printk(", (U)DMA");	/* Can be BIOS-enabled! */
-	} else {
-		printk(", DMA");
-	}
-	return 1;
-}
-
-static int config_drive_for_dma (ide_drive_t *drive)
+static int config_drive_for_dma(struct ata_device *drive)
 {
 	int config_allows_dma = 1;
 	struct hd_driveid *id = drive->id;
-	struct ata_channel *hwif = drive->channel;
+	struct ata_channel *ch = drive->channel;
 
 #ifdef CONFIG_IDEDMA_ONLYDISK
 	if (drive->type != ATA_DISK)
 		config_allows_dma = 0;
 #endif
 
-	if (id && (id->capability & 1) && hwif->autodma && config_allows_dma) {
+	if (id && (id->capability & 1) && ch->autodma && config_allows_dma) {
 		/* Consult the list of known "bad" drives */
 		if (ide_dmaproc(ide_dma_bad_drive, drive, NULL))
-			return hwif->udma(ide_dma_off, drive, NULL);
+			return ch->udma(ide_dma_off, drive, NULL);
 
 		/* Enable DMA on any drive that has UltraDMA (mode 6/7/?) enabled */
 		if ((id->field_valid & 4) && (eighty_ninty_three(drive)))
 			if ((id->dma_ultra & (id->dma_ultra >> 14) & 2))
-				return hwif->udma(ide_dma_on, drive, NULL);
+				return ch->udma(ide_dma_on, drive, NULL);
 		/* Enable DMA on any drive that has UltraDMA (mode 3/4/5) enabled */
 		if ((id->field_valid & 4) && (eighty_ninty_three(drive)))
 			if ((id->dma_ultra & (id->dma_ultra >> 11) & 7))
-				return hwif->udma(ide_dma_on, drive, NULL);
+				return ch->udma(ide_dma_on, drive, NULL);
 		/* Enable DMA on any drive that has UltraDMA (mode 0/1/2) enabled */
 		if (id->field_valid & 4)	/* UltraDMA */
 			if ((id->dma_ultra & (id->dma_ultra >> 8) & 7))
-				return hwif->udma(ide_dma_on, drive, NULL);
+				return ch->udma(ide_dma_on, drive, NULL);
 		/* Enable DMA on any drive that has mode2 DMA (multi or single) enabled */
 		if (id->field_valid & 2)	/* regular DMA */
 			if ((id->dma_mword & 0x404) == 0x404 || (id->dma_1word & 0x404) == 0x404)
-				return hwif->udma(ide_dma_on, drive, NULL);
+				return ch->udma(ide_dma_on, drive, NULL);
 		/* Consult the list of known "good" drives */
 		if (ide_dmaproc(ide_dma_good_drive, drive, NULL))
-			return hwif->udma(ide_dma_on, drive, NULL);
+			return ch->udma(ide_dma_on, drive, NULL);
 	}
-	return hwif->udma(ide_dma_off_quietly, drive, NULL);
+	return ch->udma(ide_dma_off_quietly, drive, NULL);
 }
 
 /*
@@ -508,7 +377,7 @@
 	return 0;
 }
 
-static void ide_toggle_bounce(ide_drive_t *drive, int on)
+static void ide_toggle_bounce(struct ata_device *drive, int on)
 {
 	u64 addr = BLK_BOUNCE_HIGH;
 
@@ -522,26 +391,20 @@
 	blk_queue_bounce_limit(&drive->queue, addr);
 }
 
-int ide_start_dma(ide_dma_action_t func, struct ata_device *drive)
+int ata_start_dma(struct ata_device *drive, struct request *rq)
 {
-	struct ata_channel *hwif = drive->channel;
-	unsigned long dma_base = hwif->dma_base;
+	struct ata_channel *ch = drive->channel;
+	unsigned long dma_base = ch->dma_base;
 	unsigned int reading = 0;
 
-	if (rq_data_dir(HWGROUP(drive)->rq) == READ)
+	if (rq_data_dir(rq) == READ)
 		reading = 1 << 3;
 
-	/* active tuning based on IO direction */
-	if (hwif->rwproc)
-		hwif->rwproc(drive, func);
-
-	/*
-	 * try PIO instead of DMA
-	 */
-	if (!ide_build_dmatable(drive, func))
+	/* try PIO instead of DMA */
+	if (!udma_new_table(ch, rq))
 		return 1;
 
-	outl(hwif->dmatable_dma, dma_base + 4); /* PRD table */
+	outl(ch->dmatable_dma, dma_base + 4); /* PRD table */
 	outb(reading, dma_base);		/* specify r/w */
 	outb(inb(dma_base+2)|6, dma_base+2);	/* clear INTR & ERROR flags */
 	drive->waiting_for_dma = 1;
@@ -566,11 +429,11 @@
  */
 int ide_dmaproc(ide_dma_action_t func, struct ata_device *drive, struct request *rq)
 {
-	struct ata_channel *hwif = drive->channel;
-	unsigned long dma_base = hwif->dma_base;
-	byte unit = (drive->select.b.unit & 0x01);
+	struct ata_channel *ch = drive->channel;
+	unsigned long dma_base = ch->dma_base;
+	u8 unit = (drive->select.b.unit & 0x01);
 	unsigned int reading = 0, set_high = 1;
-	byte dma_stat;
+	u8 dma_stat;
 
 	switch (func) {
 		case ide_dma_off:
@@ -579,7 +442,7 @@
 			set_high = 0;
 			outb(inb(dma_base+2) & ~(1<<(5+unit)), dma_base+2);
 #ifdef CONFIG_BLK_DEV_IDE_TCQ
-			hwif->udma(ide_dma_queued_off, drive, rq);
+			udma_tcq_enable(drive, 0);
 #endif
 		case ide_dma_on:
 			ide_toggle_bounce(drive, set_high);
@@ -587,7 +450,7 @@
 			if (drive->using_dma) {
 				outb(inb(dma_base+2)|(1<<(5+unit)), dma_base+2);
 #ifdef CONFIG_BLK_DEV_IDE_TCQ_DEFAULT
-				hwif->udma(ide_dma_queued_on, drive, rq);
+				udma_tcq_enable(drive, 1);
 #endif
 			}
 			return 0;
@@ -596,7 +459,7 @@
 		case ide_dma_read:
 			reading = 1 << 3;
 		case ide_dma_write:
-			if (ide_start_dma(func, drive))
+			if (ata_start_dma(drive, rq))
 				return 1;
 
 			if (drive->type != ATA_DISK)
@@ -613,14 +476,6 @@
 				OUT_BYTE(reading ? WIN_READDMA : WIN_WRITEDMA, IDE_COMMAND_REG);
 			}
 			return drive->channel->udma(ide_dma_begin, drive, NULL);
-#ifdef CONFIG_BLK_DEV_IDE_TCQ
-		case ide_dma_queued_on:
-		case ide_dma_queued_off:
-		case ide_dma_read_queued:
-		case ide_dma_write_queued:
-		case ide_dma_queued_start:
-			return ide_tcq_dmaproc(func, drive, rq);
-#endif
 		case ide_dma_begin:
 			/* Note that this is done *after* the cmd has
 			 * been issued to the drive, as per the BM-IDE spec.
@@ -634,13 +489,13 @@
 			outb(inb(dma_base)&~1, dma_base);	/* stop DMA */
 			dma_stat = inb(dma_base+2);		/* get DMA status */
 			outb(dma_stat|6, dma_base+2);	/* clear the INTR & ERROR bits */
-			ide_destroy_dmatable(drive);	/* purge DMA mappings */
+			udma_destroy_table(ch);	/* purge DMA mappings */
 			return (dma_stat & 7) != 4 ? (0x10 | dma_stat) : 0;	/* verify good DMA status */
 		case ide_dma_test_irq: /* returns 1 if dma irq issued, 0 otherwise */
 			dma_stat = inb(dma_base+2);
 #if 0  /* do not set unless you know what you are doing */
 			if (dma_stat & 4) {
-				byte stat = GET_STAT();
+				u8 stat = GET_STAT();
 				outb(dma_base+2, dma_stat & 0xE4);
 			}
 #endif
@@ -648,8 +503,6 @@
 		case ide_dma_bad_drive:
 		case ide_dma_good_drive:
 			return check_drive_lists(drive, (func == ide_dma_good_drive));
-		case ide_dma_verbose:
-			return report_drive_dmaing(drive);
 		case ide_dma_timeout:
 			printk(KERN_ERR "%s: DMA timeout occured!\n", __FUNCTION__);
 			return 1;
@@ -666,61 +519,61 @@
 /*
  * Needed for allowing full modular support of ide-driver
  */
-void ide_release_dma(struct ata_channel *hwif)
+void ide_release_dma(struct ata_channel *ch)
 {
-	if (!hwif->dma_base)
+	if (!ch->dma_base)
 		return;
 
-	if (hwif->dmatable_cpu) {
-		pci_free_consistent(hwif->pci_dev,
+	if (ch->dmatable_cpu) {
+		pci_free_consistent(ch->pci_dev,
 				    PRD_ENTRIES * PRD_BYTES,
-				    hwif->dmatable_cpu,
-				    hwif->dmatable_dma);
-		hwif->dmatable_cpu = NULL;
-	}
-	if (hwif->sg_table) {
-		kfree(hwif->sg_table);
-		hwif->sg_table = NULL;
-	}
-	if ((hwif->dma_extra) && (hwif->unit == 0))
-		release_region((hwif->dma_base + 16), hwif->dma_extra);
-	release_region(hwif->dma_base, 8);
-	hwif->dma_base = 0;
+				    ch->dmatable_cpu,
+				    ch->dmatable_dma);
+		ch->dmatable_cpu = NULL;
+	}
+	if (ch->sg_table) {
+		kfree(ch->sg_table);
+		ch->sg_table = NULL;
+	}
+	if ((ch->dma_extra) && (ch->unit == 0))
+		release_region((ch->dma_base + 16), ch->dma_extra);
+	release_region(ch->dma_base, 8);
+	ch->dma_base = 0;
 }
 
 /*
  * This can be called for a dynamically installed interface. Don't __init it
  */
-void ide_setup_dma(struct ata_channel *hwif, unsigned long dma_base, unsigned int num_ports)
+void ide_setup_dma(struct ata_channel *ch, unsigned long dma_base, unsigned int num_ports)
 {
-	printk("    %s: BM-DMA at 0x%04lx-0x%04lx", hwif->name, dma_base, dma_base + num_ports - 1);
+	printk("    %s: BM-DMA at 0x%04lx-0x%04lx", ch->name, dma_base, dma_base + num_ports - 1);
 	if (check_region(dma_base, num_ports)) {
 		printk(" -- ERROR, PORT ADDRESSES ALREADY IN USE\n");
 		return;
 	}
-	request_region(dma_base, num_ports, hwif->name);
-	hwif->dma_base = dma_base;
-	hwif->dmatable_cpu = pci_alloc_consistent(hwif->pci_dev,
+	request_region(dma_base, num_ports, ch->name);
+	ch->dma_base = dma_base;
+	ch->dmatable_cpu = pci_alloc_consistent(ch->pci_dev,
 						  PRD_ENTRIES * PRD_BYTES,
-						  &hwif->dmatable_dma);
-	if (hwif->dmatable_cpu == NULL)
+						  &ch->dmatable_dma);
+	if (ch->dmatable_cpu == NULL)
 		goto dma_alloc_failure;
 
-	hwif->sg_table = kmalloc(sizeof(struct scatterlist) * PRD_ENTRIES,
+	ch->sg_table = kmalloc(sizeof(struct scatterlist) * PRD_ENTRIES,
 				 GFP_KERNEL);
-	if (hwif->sg_table == NULL) {
-		pci_free_consistent(hwif->pci_dev, PRD_ENTRIES * PRD_BYTES,
-				    hwif->dmatable_cpu, hwif->dmatable_dma);
+	if (ch->sg_table == NULL) {
+		pci_free_consistent(ch->pci_dev, PRD_ENTRIES * PRD_BYTES,
+				    ch->dmatable_cpu, ch->dmatable_dma);
 		goto dma_alloc_failure;
 	}
 
-	hwif->udma = ide_dmaproc;
+	ch->udma = ide_dmaproc;
 
-	if (hwif->chipset != ide_trm290) {
-		byte dma_stat = inb(dma_base+2);
+	if (ch->chipset != ide_trm290) {
+		u8 dma_stat = inb(dma_base+2);
 		printk(", BIOS settings: %s:%s, %s:%s",
-		       hwif->drives[0].name, (dma_stat & 0x20) ? "DMA" : "pio",
-		       hwif->drives[1].name, (dma_stat & 0x40) ? "DMA" : "pio");
+		       ch->drives[0].name, (dma_stat & 0x20) ? "DMA" : "pio",
+		       ch->drives[1].name, (dma_stat & 0x40) ? "DMA" : "pio");
 	}
 	printk("\n");
 	return;
@@ -728,3 +581,141 @@
 dma_alloc_failure:
 	printk(" -- ERROR, UNABLE TO ALLOCATE DMA TABLES\n");
 }
+
+/****************************************************************************
+ * UDMA function which should have architecture specific counterparts where
+ * neccessary.
+ */
+
+/*
+ * This prepares a dma request.  Returns 0 if all went okay, returns 1
+ * otherwise.  May also be invoked from trm290.c
+ */
+int udma_new_table(struct ata_channel *ch, struct request *rq)
+{
+	unsigned int *table = ch->dmatable_cpu;
+#ifdef CONFIG_BLK_DEV_TRM290
+	unsigned int is_trm290_chipset = (ch->chipset == ide_trm290);
+#else
+	const int is_trm290_chipset = 0;
+#endif
+	unsigned int count = 0;
+	int i;
+	struct scatterlist *sg;
+
+	ch->sg_nents = i = build_sglist(ch, rq);
+	if (!i)
+		return 0;
+
+	sg = ch->sg_table;
+	while (i) {
+		u32 cur_addr;
+		u32 cur_len;
+
+		cur_addr = sg_dma_address(sg);
+		cur_len = sg_dma_len(sg);
+
+		/*
+		 * Fill in the dma table, without crossing any 64kB boundaries.
+		 * Most hardware requires 16-bit alignment of all blocks,
+		 * but the trm290 requires 32-bit alignment.
+		 */
+
+		while (cur_len) {
+			u32 xcount, bcount = 0x10000 - (cur_addr & 0xffff);
+
+			if (count++ >= PRD_ENTRIES) {
+				printk("ide-dma: count %d, sg_nents %d, cur_len %d, cur_addr %u\n",
+						count, ch->sg_nents, cur_len, cur_addr);
+				BUG();
+			}
+
+			if (bcount > cur_len)
+				bcount = cur_len;
+			*table++ = cpu_to_le32(cur_addr);
+			xcount = bcount & 0xffff;
+			if (is_trm290_chipset)
+				xcount = ((xcount >> 2) - 1) << 16;
+			if (xcount == 0x0000) {
+		        /*
+			 * Most chipsets correctly interpret a length of
+			 * 0x0000 as 64KB, but at least one (e.g. CS5530)
+			 * misinterprets it as zero (!). So here we break
+			 * the 64KB entry into two 32KB entries instead.
+			 */
+				if (count++ >= PRD_ENTRIES) {
+					pci_unmap_sg(ch->pci_dev, sg,
+						     ch->sg_nents,
+						     ch->sg_dma_direction);
+					return 0;
+				}
+
+				*table++ = cpu_to_le32(0x8000);
+				*table++ = cpu_to_le32(cur_addr + 0x8000);
+				xcount = 0x8000;
+			}
+			*table++ = cpu_to_le32(xcount);
+			cur_addr += bcount;
+			cur_len -= bcount;
+		}
+
+		sg++;
+		i--;
+	}
+
+	if (!count)
+		printk(KERN_ERR "%s: empty DMA table?\n", ch->name);
+	else if (!is_trm290_chipset)
+		*--table |= cpu_to_le32(0x80000000);
+
+	return count;
+}
+
+/* Teardown mappings after DMA has completed.  */
+void udma_destroy_table(struct ata_channel *ch)
+{
+	pci_unmap_sg(ch->pci_dev, ch->sg_table, ch->sg_nents, ch->sg_dma_direction);
+}
+
+void udma_print(struct ata_device *drive)
+{
+#ifdef CONFIG_ARCH_ACORN
+	printk(", DMA");
+#else
+	struct hd_driveid *id = drive->id;
+	char *str = NULL;
+
+	if ((id->field_valid & 4) && (eighty_ninty_three(drive)) &&
+	    (id->dma_ultra & (id->dma_ultra >> 14) & 3)) {
+		if ((id->dma_ultra >> 15) & 1)
+			str = ", UDMA(mode 7)";	/* UDMA BIOS-enabled! */
+		else
+			str = ", UDMA(133)";	/* UDMA BIOS-enabled! */
+	} else if ((id->field_valid & 4) && (eighty_ninty_three(drive)) &&
+		  (id->dma_ultra & (id->dma_ultra >> 11) & 7)) {
+		if ((id->dma_ultra >> 13) & 1) {
+			str = ", UDMA(100)";	/* UDMA BIOS-enabled! */
+		} else if ((id->dma_ultra >> 12) & 1) {
+			str = ", UDMA(66)";	/* UDMA BIOS-enabled! */
+		} else {
+			str = ", UDMA(44)";	/* UDMA BIOS-enabled! */
+		}
+	} else if ((id->field_valid & 4) &&
+		   (id->dma_ultra & (id->dma_ultra >> 8) & 7)) {
+		if ((id->dma_ultra >> 10) & 1) {
+			str = ", UDMA(33)";	/* UDMA BIOS-enabled! */
+		} else if ((id->dma_ultra >> 9) & 1) {
+			str = ", UDMA(25)";	/* UDMA BIOS-enabled! */
+		} else {
+			str = ", UDMA(16)";	/* UDMA BIOS-enabled! */
+		}
+	} else if (id->field_valid & 4)
+		str = ", (U)DMA";	/* Can be BIOS-enabled! */
+	else
+		str = ", DMA";
+
+	printk(str);
+#endif
+}
+
+EXPORT_SYMBOL(udma_print);
diff -urN linux-2.5.13/drivers/ide/ide-features.c linux/drivers/ide/ide-features.c
--- linux-2.5.13/drivers/ide/ide-features.c	2002-05-03 02:22:55.000000000 +0200
+++ linux/drivers/ide/ide-features.c	2002-05-03 18:03:00.000000000 +0200
@@ -44,29 +44,38 @@
  */
 char *ide_xfer_verbose (byte xfer_rate)
 {
-	switch(xfer_rate) {
-		case XFER_UDMA_7:	return("UDMA 7");
-		case XFER_UDMA_6:	return("UDMA 6");
-		case XFER_UDMA_5:	return("UDMA 5");
-		case XFER_UDMA_4:	return("UDMA 4");
-		case XFER_UDMA_3:	return("UDMA 3");
-		case XFER_UDMA_2:	return("UDMA 2");
-		case XFER_UDMA_1:	return("UDMA 1");
-		case XFER_UDMA_0:	return("UDMA 0");
-		case XFER_MW_DMA_2:	return("MW DMA 2");
-		case XFER_MW_DMA_1:	return("MW DMA 1");
-		case XFER_MW_DMA_0:	return("MW DMA 0");
-		case XFER_SW_DMA_2:	return("SW DMA 2");
-		case XFER_SW_DMA_1:	return("SW DMA 1");
-		case XFER_SW_DMA_0:	return("SW DMA 0");
-		case XFER_PIO_4:	return("PIO 4");
-		case XFER_PIO_3:	return("PIO 3");
-		case XFER_PIO_2:	return("PIO 2");
-		case XFER_PIO_1:	return("PIO 1");
-		case XFER_PIO_0:	return("PIO 0");
-		case XFER_PIO_SLOW:	return("PIO SLOW");
-		default:		return("XFER ERROR");
-	}
+	static struct ide_xfer_par {
+		byte rate;
+		char *name;
+	} xfer_verbose[] = {
+		{ XFER_UDMA_7,		"UDMA 7" },
+		{ XFER_UDMA_6,		"UDMA 6" },
+		{ XFER_UDMA_5,		"UDMA 5" },
+		{ XFER_UDMA_4,		"UDMA 4" },
+		{ XFER_UDMA_3,		"UDMA 3" },
+		{ XFER_UDMA_2,		"UDMA 2" },
+		{ XFER_UDMA_1,		"UDMA 1" },
+		{ XFER_UDMA_0,		"UDMA 0" },
+		{ XFER_MW_DMA_2,	"MW DMA 2" },
+		{ XFER_MW_DMA_1,	"MW DMA 1" },
+		{ XFER_MW_DMA_0,	"MW DMA 0" },
+		{ XFER_SW_DMA_2,	"SW DMA 2" },
+		{ XFER_SW_DMA_1,	"SW DMA 1" },
+		{ XFER_SW_DMA_0,	"SW DMA 0" },
+		{ XFER_PIO_4,		"PIO 4" },
+		{ XFER_PIO_3,		"PIO 3" },
+		{ XFER_PIO_2,		"PIO 2" },
+		{ XFER_PIO_1,		"PIO 1" },
+		{ XFER_PIO_0,		"PIO 0" },
+		{ XFER_PIO_SLOW,	"PIO SLOW" },
+	};
+
+	int i = 0;
+
+	for (; i < ARRAY_SIZE(xfer_verbose); i++)
+		if (xfer_verbose[i].rate == xfer_rate)
+			return xfer_verbose[i].name;
+	return "XFER ERROR";
 }
 
 byte ide_auto_reduce_xfer (ide_drive_t *drive)
diff -urN linux-2.5.13/drivers/ide/ide-pmac.c linux/drivers/ide/ide-pmac.c
--- linux-2.5.13/drivers/ide/ide-pmac.c	2002-05-03 02:22:55.000000000 +0200
+++ linux/drivers/ide/ide-pmac.c	2002-05-04 04:59:34.000000000 +0200
@@ -1164,9 +1164,9 @@
 
 /* Teardown mappings after DMA has completed.  */
 static void
-pmac_ide_destroy_dmatable (ide_drive_t *drive, int ix)
+pmac_ide_destroy_dmatable(struct ata_channel *ch, int ix)
 {
-	struct pci_dev *dev = drive->channel->pci_dev;
+	struct pci_dev *dev = ch->pci_dev;
 	struct scatterlist *sg = pmac_ide[ix].sg_table;
 	int nents = pmac_ide[ix].sg_nents;
 
@@ -1367,10 +1367,6 @@
 		break;
 	case ide_dma_read:
 	case ide_dma_write:
-		/* this almost certainly isn't needed since we don't
-		   appear to have a rwproc */
-		if (drive->channel->rwproc)
-			drive->channel->rwproc(drive, func);
 		reading = (func == ide_dma_read);
 		if (!pmac_ide_build_dmatable(drive, rq, ix, !reading))
 			return 1;
@@ -1404,7 +1400,7 @@
 		drive->waiting_for_dma = 0;
 		dstat = in_le32(&dma->status);
 		out_le32(&dma->control, ((RUN|WAKE|DEAD) << 16));
-		pmac_ide_destroy_dmatable(drive, ix);
+		pmac_ide_destroy_dmatable(drive->channel, ix);
 		/* verify good dma status */
 		return (dstat & (RUN|DEAD|ACTIVE)) != RUN;
 	case ide_dma_test_irq: /* returns 1 if dma irq issued, 0 otherwise */
@@ -1453,8 +1449,6 @@
 	case ide_dma_bad_drive:
 	case ide_dma_good_drive:
 		return check_drive_lists(drive, (func == ide_dma_good_drive));
-	case ide_dma_verbose:
-		return report_drive_dmaing(drive);
 	case ide_dma_retune:
 	case ide_dma_lostirq:
 	case ide_dma_timeout:
diff -urN linux-2.5.13/drivers/ide/ide-probe.c linux/drivers/ide/ide-probe.c
--- linux-2.5.13/drivers/ide/ide-probe.c	2002-05-04 06:07:15.000000000 +0200
+++ linux/drivers/ide/ide-probe.c	2002-05-03 18:03:00.000000000 +0200
@@ -448,7 +448,7 @@
  */
 static void channel_probe(struct ata_channel *ch)
 {
-	unsigned int unit;
+	unsigned int i;
 	unsigned long flags;
 	int error;
 
@@ -463,8 +463,8 @@
 	/*
 	 * Check for the presence of a channel by probing for drives on it.
 	 */
-	for (unit = 0; unit < MAX_DRIVES; ++unit) {
-		struct ata_device *drive = &ch->drives[unit];
+	for (i = 0; i < MAX_DRIVES; ++i) {
+		struct ata_device *drive = &ch->drives[i];
 
 		probe_for_drive(drive);
 
@@ -483,23 +483,8 @@
 		error += !request_region(ch->io_ports[IDE_DATA_OFFSET], 8, ch->name);
 		ch->straight8 = 1;
 	} else {
-		if (ch->io_ports[IDE_DATA_OFFSET])
-			error += !request_region(ch->io_ports[IDE_DATA_OFFSET], 1, ch->name);
-		if (ch->io_ports[IDE_ERROR_OFFSET])
-			error += !request_region(ch->io_ports[IDE_ERROR_OFFSET], 1, ch->name);
-		if (ch->io_ports[IDE_NSECTOR_OFFSET])
-			error += !request_region(ch->io_ports[IDE_NSECTOR_OFFSET], 1, ch->name);
-		if (ch->io_ports[IDE_SECTOR_OFFSET])
-			error += !request_region(ch->io_ports[IDE_SECTOR_OFFSET], 1, ch->name);
-		if (ch->io_ports[IDE_LCYL_OFFSET])
-			error += !request_region(ch->io_ports[IDE_LCYL_OFFSET], 1, ch->name);
-		if (ch->io_ports[IDE_HCYL_OFFSET])
-			error += !request_region(ch->io_ports[IDE_HCYL_OFFSET], 1, ch->name);
-		if (ch->io_ports[IDE_SELECT_OFFSET])
-			error += !request_region(ch->io_ports[IDE_SELECT_OFFSET], 1, ch->name);
-		if (ch->io_ports[IDE_STATUS_OFFSET])
-			error += !request_region(ch->io_ports[IDE_STATUS_OFFSET], 1, ch->name);
-
+		for (i = 0; i < 8; i++)
+			error += !request_region(ch->io_ports[i], 1, ch->name);
 	}
 	if (ch->io_ports[IDE_CONTROL_OFFSET])
 		error += !request_region(ch->io_ports[IDE_CONTROL_OFFSET], 1, ch->name);
@@ -561,8 +546,8 @@
 	/*
 	 * Now setup the PIO transfer modes of the drives on this channel.
 	 */
-	for (unit = 0; unit < MAX_DRIVES; ++unit) {
-		struct ata_device *drive = &ch->drives[unit];
+	for (i = 0; i < MAX_DRIVES; ++i) {
+		struct ata_device *drive = &ch->drives[i];
 
 		if (drive->present && (drive->autotune == 1)) {
 			if (drive->channel->tuneproc)
@@ -819,6 +804,16 @@
 		goto err_kmalloc_gd_part;
 	memset(gd->part, 0, ATA_MINORS * sizeof(struct hd_struct));
 
+	gd->de_arr = kmalloc (sizeof(*gd->de_arr) * MAX_DRIVES, GFP_KERNEL);
+	if (!gd->de_arr)
+		goto err_kmalloc_gd_de_arr;
+	memset(gd->de_arr, 0, sizeof(*gd->de_arr) * MAX_DRIVES);
+
+	gd->flags = kmalloc (sizeof(*gd->flags) * MAX_DRIVES, GFP_KERNEL);
+	if (!gd->flags)
+		goto err_kmalloc_gd_flags;
+	memset(gd->flags, 0, sizeof(*gd->flags) * MAX_DRIVES);
+
 	for (unit = 0; unit < MAX_DRIVES; ++unit)
 		ch->drives[unit].part = &gd->part[unit << PARTN_BITS];
 
diff -urN linux-2.5.13/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- linux-2.5.13/drivers/ide/ide-taskfile.c	2002-05-04 06:07:15.000000000 +0200
+++ linux/drivers/ide/ide-taskfile.c	2002-05-04 05:59:57.000000000 +0200
@@ -130,12 +130,12 @@
 }
 #endif
 
-static void ata_read_16(ide_drive_t *drive, void *buffer, unsigned int wcount)
+static void ata_read_16(struct ata_device *drive, void *buffer, unsigned int wcount)
 {
 	insw(IDE_DATA_REG, buffer, wcount<<1);
 }
 
-static void ata_write_16(ide_drive_t *drive, void *buffer, unsigned int wcount)
+static void ata_write_16(struct ata_device *drive, void *buffer, unsigned int wcount)
 {
 	outsw(IDE_DATA_REG, buffer, wcount<<1);
 }
@@ -143,7 +143,7 @@
 /*
  * This is used for most PIO data transfers *from* the device.
  */
-void ata_read(ide_drive_t *drive, void *buffer, unsigned int wcount)
+void ata_read(struct ata_device *drive, void *buffer, unsigned int wcount)
 {
 	int io_32bit;
 
@@ -178,7 +178,7 @@
 /*
  * This is used for most PIO data transfers *to* the device interface.
  */
-void ata_write(ide_drive_t *drive, void *buffer, unsigned int wcount)
+void ata_write(struct ata_device *drive, void *buffer, unsigned int wcount)
 {
 	int io_32bit;
 
@@ -213,7 +213,7 @@
  * so if an odd bytecount is specified, be sure that there's at least one
  * extra byte allocated for the buffer.
  */
-void atapi_read(ide_drive_t *drive, void *buffer, unsigned int bytecount)
+void atapi_read(struct ata_device *drive, void *buffer, unsigned int bytecount)
 {
 	if (drive->channel->atapi_read) {
 		drive->channel->atapi_read(drive, buffer, bytecount);
@@ -233,7 +233,7 @@
 		insw(IDE_DATA_REG, ((byte *)buffer) + (bytecount & ~0x03), 1);
 }
 
-void atapi_write(ide_drive_t *drive, void *buffer, unsigned int bytecount)
+void atapi_write(struct ata_device *drive, void *buffer, unsigned int bytecount)
 {
 	if (drive->channel->atapi_write) {
 		drive->channel->atapi_write(drive, buffer, bytecount);
@@ -256,7 +256,7 @@
 /*
  * Needed for PCI irq sharing
  */
-int drive_is_ready(ide_drive_t *drive)
+int drive_is_ready(struct ata_device *drive)
 {
 	byte stat = 0;
 	if (drive->waiting_for_dma)
@@ -290,7 +290,7 @@
  * Stuff the first sector(s) by implicitly calling the handler driectly
  * therafter.
  */
-void ata_poll_drive_ready(ide_drive_t *drive)
+void ata_poll_drive_ready(struct ata_device *drive)
 {
 	int i;
 
@@ -399,7 +399,7 @@
 	return ide_started;
 }
 
-ide_startstop_t ata_taskfile(ide_drive_t *drive,
+ide_startstop_t ata_taskfile(struct ata_device *drive,
 		struct ata_taskfile *args, struct request *rq)
 {
 	struct hd_driveid *id = drive->id;
@@ -456,39 +456,38 @@
 		if (args->prehandler != NULL)
 			return args->prehandler(drive, rq);
 	} else {
+		/*
+		 * FIXME: this is a gross hack, need to unify tcq dma proc and
+		 * regular dma proc -- basically split stuff that needs to act
+		 * on a request from things like ide_dma_check etc.
+		 */
 		ide_dma_action_t dma_act;
-		int tcq = 0;
 
 		if (!drive->using_dma)
 			return ide_started;
 
 		/* for dma commands we don't set the handler */
-		if (args->taskfile.command == WIN_WRITEDMA || args->taskfile.command == WIN_WRITEDMA_EXT)
+		if (args->taskfile.command == WIN_WRITEDMA
+		 || args->taskfile.command == WIN_WRITEDMA_EXT)
 			dma_act = ide_dma_write;
-		else if (args->taskfile.command == WIN_READDMA || args->taskfile.command == WIN_READDMA_EXT)
+		else if (args->taskfile.command == WIN_READDMA
+		      || args->taskfile.command == WIN_READDMA_EXT)
 			dma_act = ide_dma_read;
-		else if (args->taskfile.command == WIN_WRITEDMA_QUEUED || args->taskfile.command == WIN_WRITEDMA_QUEUED_EXT) {
-			tcq = 1;
-			dma_act = ide_dma_write_queued;
-		} else if (args->taskfile.command == WIN_READDMA_QUEUED || args->taskfile.command == WIN_READDMA_QUEUED_EXT) {
-			tcq = 1;
-			dma_act = ide_dma_read_queued;
-		} else {
+#ifdef CONFIG_BLK_DEV_IDE_TCQ
+		else if (args->taskfile.command == WIN_WRITEDMA_QUEUED
+		      || args->taskfile.command == WIN_WRITEDMA_QUEUED_EXT
+		      || args->taskfile.command == WIN_READDMA_QUEUED
+		      || args->taskfile.command == WIN_READDMA_QUEUED_EXT)
+			return udma_tcq_taskfile(drive, rq);
+#endif
+		else {
 			printk("ata_taskfile: unknown command %x\n", args->taskfile.command);
 			return ide_stopped;
 		}
 
-		/*
-		 * FIXME: this is a gross hack, need to unify tcq dma proc and
-		 * regular dma proc -- basically split stuff that needs to act
-		 * on a request from things like ide_dma_check etc.
-		 */
-		if (tcq)
-			return drive->channel->udma(dma_act, drive, rq);
-		else {
-			if (drive->channel->udma(dma_act, drive, rq))
-				return ide_stopped;
-		}
+
+		if (drive->channel->udma(dma_act, drive, rq))
+			return ide_stopped;
 	}
 
 	return ide_started;
@@ -900,7 +899,7 @@
 	}
 }
 
-int ide_raw_taskfile(ide_drive_t *drive, struct ata_taskfile *args, byte *buf)
+int ide_raw_taskfile(struct ata_device *drive, struct ata_taskfile *args, byte *buf)
 {
 	struct request rq;
 
@@ -926,7 +925,7 @@
  * interface.
  */
 
-int ide_cmd_ioctl(ide_drive_t *drive, unsigned long arg)
+int ide_cmd_ioctl(struct ata_device *drive, unsigned long arg)
 {
 	int err = 0;
 	u8 vals[4];
diff -urN linux-2.5.13/drivers/ide/Makefile linux/drivers/ide/Makefile
--- linux-2.5.13/drivers/ide/Makefile	2002-05-04 06:07:15.000000000 +0200
+++ linux/drivers/ide/Makefile	2002-05-04 06:02:26.000000000 +0200
@@ -10,7 +10,7 @@
 
 O_TARGET := idedriver.o
 
-export-objs		:= ide-taskfile.o ide.o ide-features.o ide-probe.o ataraid.o
+export-objs	:= ide-taskfile.o ide.o ide-features.o ide-probe.o ide-dma.o ataraid.o
 
 obj-y		:=
 obj-m		:=
diff -urN linux-2.5.13/drivers/ide/ns87415.c linux/drivers/ide/ns87415.c
--- linux-2.5.13/drivers/ide/ns87415.c	2002-05-03 02:22:48.000000000 +0200
+++ linux/drivers/ide/ns87415.c	2002-05-04 03:51:59.000000000 +0200
@@ -93,7 +93,7 @@
 			dma_stat = inb(hwif->dma_base+2);
 			outb(inb(hwif->dma_base)&~1, hwif->dma_base);	/* stop DMA */
 			outb(inb(hwif->dma_base)|6, hwif->dma_base);	/* from ERRATA: clear the INTR & ERROR bits */
-			ide_destroy_dmatable(drive);			/* and free any DMA resources */
+			udma_destroy_table(hwif);			/* and free any DMA resources */
 			return (dma_stat & 7) != 4;		/* verify good DMA status */
 		case ide_dma_write:
 		case ide_dma_read:
diff -urN linux-2.5.13/drivers/ide/tcq.c linux/drivers/ide/tcq.c
--- linux-2.5.13/drivers/ide/tcq.c	2002-05-04 06:07:15.000000000 +0200
+++ linux/drivers/ide/tcq.c	2002-05-04 05:25:59.000000000 +0200
@@ -215,6 +215,8 @@
 	return 0;
 }
 
+static ide_startstop_t udma_tcq_start(struct ata_device *drive, struct request *rq);
+
 /*
  * issue SERVICE command to drive -- drive must have been selected first,
  * and it must have reported a need for service (status has SERVICE_STAT set)
@@ -296,7 +298,7 @@
 	 * interrupt to indicate end of transfer, release is not allowed
 	 */
 	TCQ_PRINTK("%s: starting command %x\n", __FUNCTION__, stat);
-	return drive->channel->udma(ide_dma_queued_start, drive, rq);
+	return udma_tcq_start(drive, rq);
 }
 
 static ide_startstop_t check_service(struct ata_device *drive)
@@ -483,11 +485,119 @@
 	return 0;
 }
 
+static int tcq_wait_dataphase(struct ata_device *drive)
+{
+	u8 stat;
+	int i;
+
+	while ((stat = GET_STAT()) & BUSY_STAT)
+		udelay(10);
+
+	if (OK_STAT(stat, READY_STAT | DRQ_STAT, drive->bad_wstat))
+		return 0;
+
+	i = 0;
+	udelay(1);
+	while (!OK_STAT(GET_STAT(), READY_STAT | DRQ_STAT, drive->bad_wstat)) {
+		if (unlikely(i++ > IDE_TCQ_WAIT))
+			return 1;
+
+		udelay(10);
+	}
+
+	return 0;
+}
+
+/****************************************************************************
+ * UDMA transfer handling functions.
+ */
+
+/*
+ * Invoked from a SERVICE interrupt, command etc already known.  Just need to
+ * start the dma engine for this tag.
+ */
+static ide_startstop_t udma_tcq_start(struct ata_device *drive, struct request *rq)
+{
+	struct ata_channel *ch = drive->channel;
+
+	TCQ_PRINTK("%s: setting up queued %d\n", __FUNCTION__, rq->tag);
+	if (!test_bit(IDE_BUSY, &ch->hwgroup->flags))
+		printk("queued_rw: IDE_BUSY not set\n");
+
+	if (tcq_wait_dataphase(drive))
+		return ide_stopped;
+
+	if (ata_start_dma(drive, rq))
+		return ide_stopped;
+
+	set_irq(drive, ide_dmaq_intr);
+	if (!ch->udma(ide_dma_begin, drive, rq))
+		return ide_started;
+
+	return ide_stopped;
+}
+
 /*
- * for now assume that command list is always as big as we need and don't
- * attempt to shrink it on tcq disable
+ * Start a queued command from scratch.
  */
-static int enable_queued(struct ata_device *drive, int on)
+ide_startstop_t udma_tcq_taskfile(struct ata_device *drive, struct request *rq)
+{
+	u8 stat;
+	u8 feat;
+
+	struct ata_taskfile *args = rq->special;
+
+	TCQ_PRINTK("%s: start tag %d\n", drive->name, rq->tag);
+
+	/*
+	 * set nIEN, tag start operation will enable again when
+	 * it is safe
+	 */
+	drive_ctl_nien(drive, 1);
+
+	OUT_BYTE(args->taskfile.command, IDE_COMMAND_REG);
+
+	if (wait_altstat(drive, &stat, BUSY_STAT)) {
+		ide_dump_status(drive, "queued start", stat);
+		tcq_invalidate_queue(drive);
+		return ide_stopped;
+	}
+
+	drive_ctl_nien(drive, 0);
+
+	if (stat & ERR_STAT) {
+		ide_dump_status(drive, "tcq_start", stat);
+		return ide_stopped;
+	}
+
+	/*
+	 * drive released the bus, clear active tag and
+	 * check for service
+	 */
+	if ((feat = GET_FEAT()) & NSEC_REL) {
+		drive->immed_rel++;
+		HWGROUP(drive)->rq = NULL;
+		set_irq(drive, ide_dmaq_intr);
+
+		TCQ_PRINTK("REL in queued_start\n");
+
+		if ((stat = GET_STAT()) & SERVICE_STAT)
+			return service(drive);
+
+		return ide_released;
+	}
+
+	TCQ_PRINTK("IMMED in queued_start\n");
+	drive->immed_comp++;
+
+	return udma_tcq_start(drive, rq);
+}
+
+/*
+ * For now assume that command list is always as big as we need and don't
+ * attempt to shrink it on tcq disable.
+ */
+int udma_tcq_enable(struct ata_device *drive, int on)
 {
 	int depth = drive->using_tcq ? drive->queue_depth : 0;
 
@@ -523,120 +633,3 @@
 	drive->using_tcq = 1;
 	return 0;
 }
-
-static int tcq_wait_dataphase(struct ata_device *drive)
-{
-	u8 stat;
-	int i;
-
-	while ((stat = GET_STAT()) & BUSY_STAT)
-		udelay(10);
-
-	if (OK_STAT(stat, READY_STAT | DRQ_STAT, drive->bad_wstat))
-		return 0;
-
-	i = 0;
-	udelay(1);
-	while (!OK_STAT(GET_STAT(), READY_STAT | DRQ_STAT, drive->bad_wstat)) {
-		if (unlikely(i++ > IDE_TCQ_WAIT))
-			return 1;
-
-		udelay(10);
-	}
-
-	return 0;
-}
-
-ide_startstop_t ide_tcq_dmaproc(ide_dma_action_t func, struct ata_device *drive, struct request *rq)
-{
-	struct ata_channel *hwif = drive->channel;
-	unsigned int enable_tcq = 1;
-	u8 stat;
-	u8 feat;
-
-	switch (func) {
-		/*
-		 * invoked from a SERVICE interrupt, command etc already known.
-		 * just need to start the dma engine for this tag
-		 */
-		case ide_dma_queued_start:
-			TCQ_PRINTK("ide_dma: setting up queued %d\n", rq->tag);
-			if (!test_bit(IDE_BUSY, &HWGROUP(drive)->flags))
-				printk("queued_rw: IDE_BUSY not set\n");
-
-			if (tcq_wait_dataphase(drive))
-				return ide_stopped;
-
-			if (ide_start_dma(func, drive))
-				return ide_stopped;
-
-			set_irq(drive, ide_dmaq_intr);
-			if (!hwif->udma(ide_dma_begin, drive, rq))
-				return ide_started;
-
-			return ide_stopped;
-
-			/*
-			 * start a queued command from scratch
-			 */
-		case ide_dma_read_queued:
-		case ide_dma_write_queued: {
-			struct ata_taskfile *args = rq->special;
-
-			TCQ_PRINTK("%s: start tag %d\n", drive->name, rq->tag);
-
-			/*
-			 * set nIEN, tag start operation will enable again when
-			 * it is safe
-			 */
-			drive_ctl_nien(drive, 1);
-
-			OUT_BYTE(args->taskfile.command, IDE_COMMAND_REG);
-
-			if (wait_altstat(drive, &stat, BUSY_STAT)) {
-				ide_dump_status(drive, "queued start", stat);
-				tcq_invalidate_queue(drive);
-				return ide_stopped;
-			}
-
-			drive_ctl_nien(drive, 0);
-
-			if (stat & ERR_STAT) {
-				ide_dump_status(drive, "tcq_start", stat);
-				return ide_stopped;
-			}
-
-			/*
-			 * drive released the bus, clear active tag and
-			 * check for service
-			 */
-			if ((feat = GET_FEAT()) & NSEC_REL) {
-				drive->immed_rel++;
-				HWGROUP(drive)->rq = NULL;
-				set_irq(drive, ide_dmaq_intr);
-
-				TCQ_PRINTK("REL in queued_start\n");
-
-				if ((stat = GET_STAT()) & SERVICE_STAT)
-					return service(drive);
-
-				return ide_released;
-			}
-
-			TCQ_PRINTK("IMMED in queued_start\n");
-			drive->immed_comp++;
-			return hwif->udma(ide_dma_queued_start, drive, rq);
-			}
-
-		case ide_dma_queued_off:
-			enable_tcq = 0;
-		case ide_dma_queued_on:
-			if (enable_tcq && !drive->using_dma)
-				return 1;
-			return enable_queued(drive, enable_tcq);
-		default:
-			break;
-	}
-
-	return 1;
-}
diff -urN linux-2.5.13/drivers/ide/trm290.c linux/drivers/ide/trm290.c
--- linux-2.5.13/drivers/ide/trm290.c	2002-05-03 02:22:44.000000000 +0200
+++ linux/drivers/ide/trm290.c	2002-05-04 03:52:43.000000000 +0200
@@ -175,7 +175,7 @@
 #ifdef CONFIG_BLK_DEV_IDEDMA
 static int trm290_dmaproc (ide_dma_action_t func, struct ata_device *drive, struct request *rq)
 {
-	struct ata_channel *hwif = drive->channel;
+	struct ata_channel *ch = drive->channel;
 	unsigned int count, reading = 2, writing = 0;
 
 	switch (func) {
@@ -186,12 +186,12 @@
 			break;	/* always use PIO for writes */
 #endif
 		case ide_dma_read:
-			if (!(count = ide_build_dmatable(drive, func)))
+			if (!(count = udma_new_table(ch, rq)))
 				break;		/* try PIO instead of DMA */
 			trm290_prepare_drive(drive, 1);	/* select DMA xfer */
-			outl(hwif->dmatable_dma|reading|writing, hwif->dma_base);
+			outl(ch->dmatable_dma|reading|writing, ch->dma_base);
 			drive->waiting_for_dma = 1;
-			outw((count * 2) - 1, hwif->dma_base+2); /* start DMA */
+			outw((count * 2) - 1, ch->dma_base+2); /* start DMA */
 			if (drive->type != ATA_DISK)
 				return 0;
 			ide_set_handler(drive, &ide_dma_intr, WAIT_CMD, NULL);
@@ -201,10 +201,10 @@
 			return 0;
 		case ide_dma_end:
 			drive->waiting_for_dma = 0;
-			ide_destroy_dmatable(drive);		/* purge DMA mappings */
-			return (inw(hwif->dma_base+2) != 0x00ff);
+			udma_destroy_table(ch);	/* purge DMA mappings */
+			return (inw(ch->dma_base + 2) != 0x00ff);
 		case ide_dma_test_irq:
-			return (inw(hwif->dma_base+2) == 0x00ff);
+			return (inw(ch->dma_base + 2) == 0x00ff);
 		default:
 			return ide_dmaproc(func, drive, rq);
 	}
diff -urN linux-2.5.13/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.13/include/linux/ide.h	2002-05-04 06:07:15.000000000 +0200
+++ linux/include/linux/ide.h	2002-05-04 05:41:33.000000000 +0200
@@ -368,32 +368,24 @@
 	/*
 	 * tcq statistics
 	 */
-	unsigned long	immed_rel;	
+	unsigned long	immed_rel;
 	unsigned long	immed_comp;
 	int		max_last_depth;
 	int		max_depth;
 } ide_drive_t;
 
-/*
- * This initiates/aborts DMA read/write operations on a drive.
- *
- * The caller is assumed to have selected the drive and programmed the drive's
- * sector address using CHS or LBA.  All that remains is to prepare for DMA
- * and then issue the actual read/write DMA/PIO command to the drive.
- *
- * Returns 0 if all went well.
- * Returns 1 if DMA read/write could not be started, in which case the caller
- * should either try again later, or revert to PIO for the current request.
- */
-typedef enum {	ide_dma_read,	ide_dma_write,		ide_dma_begin,
-		ide_dma_end,	ide_dma_check,		ide_dma_on,
-		ide_dma_off,	ide_dma_off_quietly,	ide_dma_test_irq,
-		ide_dma_bad_drive,			ide_dma_good_drive,
-		ide_dma_verbose,			ide_dma_retune,
-		ide_dma_lostirq,			ide_dma_timeout,
-		ide_dma_read_queued,			ide_dma_write_queued,
-		ide_dma_queued_start,			ide_dma_queued_on,
-		ide_dma_queued_off,
+typedef enum {
+	ide_dma_read,	ide_dma_write,
+	ide_dma_begin,	ide_dma_end,
+	ide_dma_check,
+	ide_dma_on, ide_dma_off,
+	ide_dma_off_quietly,
+	ide_dma_test_irq,
+	ide_dma_bad_drive,
+	ide_dma_good_drive,
+	ide_dma_retune,
+	ide_dma_lostirq,
+	ide_dma_timeout
 } ide_dma_action_t;
 
 enum {
@@ -436,9 +428,6 @@
 	/* special host masking for drive selection */
 	void (*maskproc) (struct ata_device *, int);
 
-	/* adjust timing based upon rq->cmd direction */
-	void (*rwproc) (struct ata_device *, ide_dma_action_t);
-
 	/* check host's drive quirk list */
 	int (*quirkproc) (struct ata_device *);
 
@@ -472,6 +461,7 @@
 	unsigned autodma	: 1;	/* automatically try to enable DMA at boot */
 	unsigned udma_four	: 1;	/* 1=ATA-66 capable, 0=default */
 	unsigned highmem	: 1;	/* can do full 32-bit dma */
+	unsigned straight8	: 1;	/* Alan's straight 8 check */
 	unsigned no_io_32bit	: 1;	/* disallow enabling 32bit I/O */
 	unsigned no_unmask	: 1;	/* disallow setting unmask bit */
 	unsigned auto_poll	: 1;	/* supports nop auto-poll */
@@ -482,8 +472,8 @@
 #if (DISK_RECOVERY_TIME > 0)
 	unsigned long	last_time;	/* time when previous rq was done */
 #endif
-	byte		straight8;	/* Alan's straight 8 check */
-	int (*busproc)(struct ata_device *, int);	/* driver soft-power interface */
+	/* driver soft-power interface */
+	int (*busproc)(struct ata_device *, int);
 	byte		bus_state;	/* power state of the IDE bus */
 };
 
@@ -562,7 +552,7 @@
 #define SETTING_WRITE	(1 << 1)
 #define SETTING_RW	(SETTING_READ | SETTING_WRITE)
 
-typedef int (ide_procset_t)(ide_drive_t *, int);
+typedef int (ide_procset_t)(struct ata_device *, int);
 typedef struct ide_settings_s {
 	char			*name;
 	int			rw;
@@ -579,11 +569,11 @@
 	struct ide_settings_s	*next;
 } ide_settings_t;
 
-void ide_add_setting(ide_drive_t *drive, const char *name, int rw, int read_ioctl, int write_ioctl, int data_type, int min, int max, int mul_factor, int div_factor, void *data, ide_procset_t *set);
-void ide_remove_setting(ide_drive_t *drive, char *name);
-int ide_read_setting(ide_drive_t *t, ide_settings_t *setting);
-int ide_write_setting(ide_drive_t *drive, ide_settings_t *setting, int val);
-void ide_add_generic_settings(ide_drive_t *drive);
+extern void ide_add_setting(struct ata_device *, const char *, int, int, int, int, int, int, int, int, void *, ide_procset_t *);
+extern void ide_remove_setting(struct ata_device *, char *);
+extern int ide_read_setting(struct ata_device *, ide_settings_t *);
+extern int ide_write_setting(struct ata_device *, ide_settings_t *, int);
+extern void ide_add_generic_settings(struct ata_device *);
 
 /*
  * /proc/ide interface
@@ -696,19 +686,19 @@
 /*
  * Error reporting, in human readable form (luxurious, but a memory hog).
  */
-byte ide_dump_status (ide_drive_t *drive, const char *msg, byte stat);
+extern byte ide_dump_status(struct ata_device *, const char *, byte);
 
 /*
  * ide_error() takes action based on the error returned by the controller.
  * The caller should return immediately after invoking this.
  */
-ide_startstop_t ide_error (ide_drive_t *drive, const char *msg, byte stat);
+extern ide_startstop_t ide_error(struct ata_device *, const char *, byte);
 
 /*
  * Issue a simple drive command
  * The drive must be selected beforehand.
  */
-void ide_cmd(ide_drive_t *drive, byte cmd, byte nsect, ata_handler_t handler);
+void ide_cmd(struct ata_device *, byte, byte, ata_handler_t);
 
 /*
  * ide_fixstring() cleans up and (optionally) byte-swaps a text string,
@@ -726,9 +716,9 @@
  * caller should return the updated value of "startstop" in this case.
  * "startstop" is unchanged when the function returns 0;
  */
-int ide_wait_stat(ide_startstop_t *startstop, ide_drive_t *drive, byte good, byte bad, unsigned long timeout);
+extern int ide_wait_stat(ide_startstop_t *, struct ata_device *, byte, byte, unsigned long);
 
-int ide_wait_noerr(ide_drive_t *drive, byte good, byte bad, unsigned long timeout);
+extern int ide_wait_noerr(struct ata_device *, byte, byte, unsigned long);
 
 /*
  * This routine is called from the partition-table code in genhd.c
@@ -737,15 +727,15 @@
 int ide_xlate_1024(kdev_t, int, int, const char *);
 
 /*
- * Convert kdev_t structure into ide_drive_t * one.
+ * Convert kdev_t structure into struct ata_device * one.
  */
-ide_drive_t *get_info_ptr(kdev_t i_rdev);
+struct ata_device *get_info_ptr(kdev_t i_rdev);
 
 /*
  * Re-Start an operation for an IDE interface.
  * The caller should return immediately after invoking this.
  */
-ide_startstop_t restart_request(ide_drive_t *);
+ide_startstop_t restart_request(struct ata_device *);
 
 /*
  * This function is intended to be used prior to invoking ide_do_drive_cmd().
@@ -767,12 +757,12 @@
  */
 #define ide_rq_offset(rq) (((rq)->hard_cur_sectors - (rq)->current_nr_sectors) << 9)
 
-extern int ide_do_drive_cmd(ide_drive_t *drive, struct request *rq, ide_action_t action);
+extern int ide_do_drive_cmd(struct ata_device *, struct request *, ide_action_t);
 
 /*
  * Clean up after success/failure of an explicit drive cmd.
  */
-void ide_end_drive_cmd (ide_drive_t *drive, byte stat, byte err);
+extern void ide_end_drive_cmd(struct ata_device *, byte, byte);
 
 struct ata_taskfile {
 	struct hd_drive_task_hdr taskfile;
@@ -809,31 +799,20 @@
 
 void ide_delay_50ms(void);
 
-byte ide_auto_reduce_xfer (ide_drive_t *drive);
-int ide_driveid_update (ide_drive_t *drive);
-int ide_ata66_check (ide_drive_t *drive, struct ata_taskfile *args);
-int ide_config_drive_speed (ide_drive_t *drive, byte speed);
-byte eighty_ninty_three (ide_drive_t *drive);
-int set_transfer (ide_drive_t *drive, struct ata_taskfile *args);
+extern byte ide_auto_reduce_xfer(struct ata_device *);
+extern int ide_driveid_update(struct ata_device *);
+extern int ide_ata66_check(struct ata_device *, struct ata_taskfile *);
+extern int ide_config_drive_speed(struct ata_device *, byte);
+extern byte eighty_ninty_three(struct ata_device *);
+extern int set_transfer(struct ata_device *, struct ata_taskfile *);
 
 extern int system_bus_speed;
 
 /*
- * idedisk_input_data() is a wrapper around ide_input_data() which copes
- * with byte-swapping the input data if required.
- */
-extern void idedisk_input_data(ide_drive_t *drive, void *buffer, unsigned int wcount);
-
-/*
  * ide_stall_queue() can be used by a drive to give excess bandwidth back
  * to the hwgroup by sleeping for timeout jiffies.
  */
-void ide_stall_queue (ide_drive_t *drive, unsigned long timeout);
-
-/*
- * ide_get_queue() returns the queue which corresponds to a given device.
- */
-request_queue_t *ide_get_queue(kdev_t dev);
+void ide_stall_queue(struct ata_device *, unsigned long);
 
 /*
  * CompactFlash cards and their brethern pretend to be removable hard disks,
@@ -842,9 +821,9 @@
  * config bits.
  */
 
-extern int drive_is_flashcard(ide_drive_t *drive);
+extern int drive_is_flashcard(struct ata_device *);
 
-int ide_spin_wait_hwgroup (ide_drive_t *drive);
+int ide_spin_wait_hwgroup(struct ata_device *);
 void ide_timer_expiry (unsigned long data);
 extern void ata_irq_request(int irq, void *data, struct pt_regs *regs);
 void do_ide_request (request_queue_t * q);
@@ -890,15 +869,21 @@
 void __init ide_scan_pcibus(int scan_direction);
 #endif
 #ifdef CONFIG_BLK_DEV_IDEDMA
-extern int ide_build_dmatable(struct ata_device *, ide_dma_action_t);
-extern void ide_destroy_dmatable(struct ata_device *);
+
+extern int udma_new_table(struct ata_channel *, struct request *);
+extern void udma_destroy_table(struct ata_channel *);
+extern void udma_print(struct ata_device *);
+
+extern ide_startstop_t udma_tcq_taskfile(struct ata_device *, struct request *);
+extern int udma_tcq_enable(struct ata_device *, int);
+
 extern ide_startstop_t ide_dma_intr(struct ata_device *, struct request *);
 extern int check_drive_lists(struct ata_device *, int good_bad);
 extern int ide_dmaproc(ide_dma_action_t func, struct ata_device *, struct request *);
 extern ide_startstop_t ide_tcq_dmaproc(ide_dma_action_t, struct ata_device *, struct request *);
 extern void ide_release_dma(struct ata_channel *);
 extern void ide_setup_dma(struct ata_channel *,	unsigned long, unsigned int) __init;
-extern int ide_start_dma(ide_dma_action_t, struct ata_device *);
+extern int ata_start_dma(struct ata_device *, struct request *rq);
 #endif
 
 extern spinlock_t ide_lock;

--------------080905080306040000010406--

