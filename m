Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315718AbSECVJd>; Fri, 3 May 2002 17:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315719AbSECVJd>; Fri, 3 May 2002 17:09:33 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56075 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315718AbSECVJ0>;
	Fri, 3 May 2002 17:09:26 -0400
Message-ID: <3CD2FC45.14442FC5@zip.com.au>
Date: Fri, 03 May 2002 14:08:21 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>
CC: Andre Hedrick <andre@linux-ide.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [patch] hpt374 support
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin,

I've been carrying this diff for a month or two,
learning more than I ever wanted to about IDE each time
a new kernel comes out ;)

It is Andre's work, offered for 2.5 with his permission.
It adds HPT374 support to hpt366.c.

It works for me [unlike hptraid..c and ataraid.c :(].

It has a problem with my 80 gigabyte Seagates - in UDMA133
mode, writes are inexplicably slow.  I manually set UDMA100
and it flies.



--- 2.5.13/drivers/ide/hpt366.c~hpt374	Fri May  3 14:05:12 2002
+++ 2.5.13-akpm/drivers/ide/hpt366.c	Fri May  3 14:05:12 2002
@@ -40,6 +40,8 @@
  * Reset the hpt366 on error, reset on dma
  * Fix disabling Fast Interrupt hpt366.
  * 	Mike Waychison <crlf@sun.com>
+ *
+ * 02 May 2002 - HPT374 support (Andre Hedrick <andre@linux-ide.org>)
  */
 
 #include <linux/config.h>
@@ -164,9 +166,8 @@ struct chipset_bus_clock_list_entry {
  *        PIO.
  * 31     FIFO enable.
  */
-struct chipset_bus_clock_list_entry forty_base [] = {
-
-	{	XFER_UDMA_4,    0x900fd943	},
+struct chipset_bus_clock_list_entry forty_base_hpt366[] = {
+	{	XFER_UDMA_4,	0x900fd943	},
 	{	XFER_UDMA_3,	0x900ad943	},
 	{	XFER_UDMA_2,	0x900bd943	},
 	{	XFER_UDMA_1,	0x9008d943	},
@@ -184,8 +185,7 @@ struct chipset_bus_clock_list_entry fort
 	{	0,		0x0120d9d9	}
 };
 
-struct chipset_bus_clock_list_entry thirty_three_base [] = {
-
+struct chipset_bus_clock_list_entry thirty_three_base_hpt366[] = {
 	{	XFER_UDMA_4,	0x90c9a731	},
 	{	XFER_UDMA_3,	0x90cfa731	},
 	{	XFER_UDMA_2,	0x90caa731	},
@@ -204,7 +204,7 @@ struct chipset_bus_clock_list_entry thir
 	{	0,		0x0120a7a7	}
 };
 
-struct chipset_bus_clock_list_entry twenty_five_base [] = {
+struct chipset_bus_clock_list_entry twenty_five_base_hpt366[] = {
 
 	{	XFER_UDMA_4,	0x90c98521	},
 	{	XFER_UDMA_3,	0x90cf8521	},
@@ -329,6 +329,144 @@ struct chipset_bus_clock_list_entry fift
 	{       0,              0x0ac1f48a      }
 };
 
+struct chipset_bus_clock_list_entry thirty_three_base_hpt372[] = {
+	{	XFER_UDMA_6,	0x1c81dc62	},
+	{	XFER_UDMA_5,	0x1c6ddc62	},
+	{	XFER_UDMA_4,	0x1c8ddc62	},
+	{	XFER_UDMA_3,	0x1c8edc62	},	/* checkme */
+	{	XFER_UDMA_2,	0x1c91dc62	},
+	{	XFER_UDMA_1,	0x1c9adc62	},	/* checkme */
+	{	XFER_UDMA_0,	0x1c82dc62	},	/* checkme */
+
+	{	XFER_MW_DMA_2,	0x2c829262	},
+	{	XFER_MW_DMA_1,	0x2c829266	},	/* checkme */
+	{	XFER_MW_DMA_0,	0x2c82922e	},	/* checkme */
+
+	{	XFER_PIO_4,	0x0c829c62	},
+	{	XFER_PIO_3,	0x0c829c84	},
+	{	XFER_PIO_2,	0x0c829ca6	},
+	{	XFER_PIO_1,	0x0d029d26	},
+	{	XFER_PIO_0,	0x0d029d5e	},
+	{	0,		0x0d029d5e	}
+};
+
+struct chipset_bus_clock_list_entry fifty_base_hpt372[] = {
+	{	XFER_UDMA_5,	0x12848242	},
+	{	XFER_UDMA_4,	0x12ac8242	},
+	{	XFER_UDMA_3,	0x128c8242	},
+	{	XFER_UDMA_2,	0x120c8242	},
+	{	XFER_UDMA_1,	0x12148254	},
+	{	XFER_UDMA_0,	0x121882ea	},
+
+	{	XFER_MW_DMA_2,	0x22808242	},
+	{	XFER_MW_DMA_1,	0x22808254	},
+	{	XFER_MW_DMA_0,	0x228082ea	},
+
+	{	XFER_PIO_4,	0x0a81f442	},
+	{	XFER_PIO_3,	0x0a81f443	},
+	{	XFER_PIO_2,	0x0a81f454	},
+	{	XFER_PIO_1,	0x0ac1f465	},
+	{	XFER_PIO_0,	0x0ac1f48a	},
+	{	0,		0x0a81f443	}
+};
+
+struct chipset_bus_clock_list_entry sixty_six_base_hpt372[] = {
+	{	XFER_UDMA_6,	0x1c869c62	},
+	{	XFER_UDMA_5,	0x1cae9c62	},
+	{	XFER_UDMA_4,	0x1c8a9c62	},
+	{	XFER_UDMA_3,	0x1c8e9c62	},
+	{	XFER_UDMA_2,	0x1c929c62	},
+	{	XFER_UDMA_1,	0x1c9a9c62	},
+	{	XFER_UDMA_0,	0x1c829c62	},
+
+	{	XFER_MW_DMA_2,	0x2c829c62	},
+	{	XFER_MW_DMA_1,	0x2c829c66	},
+	{	XFER_MW_DMA_0,	0x2c829d2e	},
+
+	{	XFER_PIO_4,	0x0c829c62	},
+	{	XFER_PIO_3,	0x0c829c84	},
+	{	XFER_PIO_2,	0x0c829ca6	},
+	{	XFER_PIO_1,	0x0d029d26	},
+	{	XFER_PIO_0,	0x0d029d5e	},
+	{	0,		0x0d029d26	}
+};
+
+struct chipset_bus_clock_list_entry thirty_three_base_hpt374[] = {
+	{	XFER_UDMA_6,	0x12808242	},
+	{	XFER_UDMA_5,	0x12848242	},
+	{	XFER_UDMA_4,	0x12ac8242	},
+	{	XFER_UDMA_3,	0x128c8242	},
+	{	XFER_UDMA_2,	0x120c8242	},
+	{	XFER_UDMA_1,	0x12148254	},
+	{	XFER_UDMA_0,	0x121882ea	},
+
+	{	XFER_MW_DMA_2,	0x22808242	},
+	{	XFER_MW_DMA_1,	0x22808254	},
+	{	XFER_MW_DMA_0,	0x228082ea	},
+
+	{	XFER_PIO_4,	0x0a81f442	},
+	{	XFER_PIO_3,	0x0a81f443	},
+	{	XFER_PIO_2,	0x0a81f454	},
+	{	XFER_PIO_1,	0x0ac1f465	},
+	{	XFER_PIO_0,	0x0ac1f48a	},
+	{	0,		0x06814e93	}
+};
+
+#if 0
+struct chipset_bus_clock_list_entry fifty_base_hpt374[] = {
+	{	XFER_UDMA_6,	},
+	{	XFER_UDMA_5,	},
+	{	XFER_UDMA_4,	},
+	{	XFER_UDMA_3,	},
+	{	XFER_UDMA_2,	},
+	{	XFER_UDMA_1,	},
+	{	XFER_UDMA_0,	},
+	{	XFER_MW_DMA_2,	},
+	{	XFER_MW_DMA_1,	},
+	{	XFER_MW_DMA_0,	},
+	{	XFER_PIO_4,	},
+	{	XFER_PIO_3,	},
+	{	XFER_PIO_2,	},
+	{	XFER_PIO_1,	},
+	{	XFER_PIO_0,	},
+	{	0,	}
+};
+#endif
+#if 0
+struct chipset_bus_clock_list_entry sixty_six_base_hpt374[] = {
+	{	XFER_UDMA_6,	0x12406231	},	/* checkme */
+	{	XFER_UDMA_5,	0x12446231	},
+				0x14846231
+	{	XFER_UDMA_4,		0x16814ea7	},
+				0x14886231
+	{	XFER_UDMA_3,		0x16814ea7	},
+				0x148c6231
+	{	XFER_UDMA_2,		0x16814ea7	},
+				0x148c6231
+	{	XFER_UDMA_1,		0x16814ea7	},
+				0x14906231
+	{	XFER_UDMA_0,		0x16814ea7	},
+				0x14986231
+	{	XFER_MW_DMA_2,		0x16814ea7	},
+				0x26514e21
+	{	XFER_MW_DMA_1,		0x16814ea7	},
+				0x26514e97
+	{	XFER_MW_DMA_0,		0x16814ea7	},
+				0x26514e97
+	{	XFER_PIO_4,		0x06814ea7	},
+				0x06514e21
+	{	XFER_PIO_3,		0x06814ea7	},
+				0x06514e22
+	{	XFER_PIO_2,		0x06814ea7	},
+				0x06514e33
+	{	XFER_PIO_1,		0x06814ea7	},
+				0x06914e43
+	{	XFER_PIO_0,		0x06814ea7	},
+				0x06914e57
+	{	0,		0x06814ea7	}
+};
+#endif
+
 #define HPT366_DEBUG_DRIVE_INFO		0
 #define HPT370_ALLOW_ATA100_5		1
 #define HPT366_ALLOW_ATA66_4		1
@@ -345,6 +483,10 @@ static int n_hpt_devs;
 
 static unsigned int pci_rev_check_hpt3xx(struct pci_dev *dev);
 static unsigned int pci_rev2_check_hpt3xx(struct pci_dev *dev);
+static unsigned int pci_rev3_check_hpt3xx(struct pci_dev *dev);
+static unsigned int pci_rev5_check_hpt3xx(struct pci_dev *dev);
+static unsigned int pci_rev7_check_hpt3xx(struct pci_dev *dev);
+
 byte hpt366_proc = 0;
 byte hpt363_shared_irq;
 byte hpt363_shared_pin;
@@ -357,11 +499,13 @@ extern int (*hpt366_display_info)(char *
 static int hpt366_get_info (char *buffer, char **addr, off_t offset, int count)
 {
 	char *p	= buffer;
-	char *chipset_nums[] = {"366", "366", "368", "370", "370A"};
+	char *chipset_nums[] = {"366", "366",  "368",
+				"370", "370A", "372",
+				"??",  "374" };
 	int i;
 
 	p += sprintf(p, "\n                             "
-		"HighPoint HPT366/368/370\n");
+		"HighPoint HPT366/368/370/372/374\n");
 	for (i = 0; i < n_hpt_devs; i++) {
 		struct pci_dev *dev = hpt_devs[i];
 		unsigned short iobase = dev->resource[4].start;
@@ -386,7 +530,7 @@ static int hpt366_get_info (char *buffer
 			(c0 & 0x80) ? "no" : "yes",
 			(c1 & 0x80) ? "no" : "yes");
 
-		if (pci_rev_check_hpt3xx(dev)) {
+		if (pci_rev3_check_hpt3xx(dev)) {
 			u8 cbl;
 			cbl = inb_p(iobase + 0x7b);
 			outb_p(cbl | 1, iobase + 0x7b);
@@ -435,6 +579,10 @@ static int hpt366_get_info (char *buffer
 }
 #endif  /* defined(DISPLAY_HPT366_TIMINGS) && defined(CONFIG_PROC_FS) */
 
+/*
+ * fixme: it really needs to be a switch.
+ */
+
 static unsigned int pci_rev_check_hpt3xx (struct pci_dev *dev)
 {
 	unsigned int class_rev;
@@ -451,6 +599,30 @@ static unsigned int pci_rev2_check_hpt3x
 	return ((int) (class_rev > 0x01) ? 1 : 0);
 }
 
+static unsigned int pci_rev3_check_hpt3xx (struct pci_dev *dev)
+{
+	unsigned int class_rev;
+	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
+	class_rev &= 0xff;
+	return ((int) (class_rev > 0x02) ? 1 : 0);
+}
+
+static unsigned int pci_rev5_check_hpt3xx (struct pci_dev *dev)
+{
+	unsigned int class_rev;
+	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
+	class_rev &= 0xff;
+	return ((int) (class_rev > 0x04) ? 1 : 0);
+}
+
+static unsigned int pci_rev7_check_hpt3xx (struct pci_dev *dev)
+{
+	unsigned int class_rev;
+	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
+	class_rev &= 0xff;
+	return ((int) (class_rev > 0x06) ? 1 : 0);
+}
+
 static int check_in_drive_lists (ide_drive_t *drive, const char **list)
 {
 	struct hd_driveid *id = drive->id;
@@ -482,6 +654,7 @@ static unsigned int pci_bus_clock_list (
 
 static void hpt366_tune_chipset (ide_drive_t *drive, byte speed)
 {
+	struct pci_dev *dev	= drive->channel->pci_dev;
 	byte regtime		= (drive->select.b.unit & 0x01) ? 0x44 : 0x40;
 	byte regfast		= (drive->channel->unit) ? 0x55 : 0x51;
 			/*
@@ -495,30 +668,13 @@ static void hpt366_tune_chipset (ide_dri
 	/*
 	 * Disable the "fast interrupt" prediction. 
 	 */
-	pci_read_config_byte(drive->channel->pci_dev, regfast, &drive_fast);
+	pci_read_config_byte(dev, regfast, &drive_fast);
 	if (drive_fast & 0x02)
-		pci_write_config_byte(drive->channel->pci_dev, regfast, drive_fast & ~0x20);
+		pci_write_config_byte(dev, regfast, drive_fast & ~0x20);
 
-	pci_read_config_dword(drive->channel->pci_dev, regtime, &reg1);
-	/* detect bus speed by looking at control reg timing: */
-	switch((reg1 >> 8) & 7) {
-		case 5:
-			reg2 = pci_bus_clock_list(speed, forty_base);
-			break;
-		case 9:
-			reg2 = pci_bus_clock_list(speed, twenty_five_base);
-			break;
-		default:
-		case 7:
-			reg2 = pci_bus_clock_list(speed, thirty_three_base);
-			break;
-	}
-#if 0
-	/* this is a nice idea ... */
-	list_conf = pci_bus_clock_list(speed,
-				       (struct chipset_bus_clock_list_entry *)
-				       dev->sysdata);
-#endif
+	pci_read_config_dword(dev, regtime, &reg1);
+	reg2 = pci_bus_clock_list(speed,
+		(struct chipset_bus_clock_list_entry *) dev->sysdata);
 	/*
 	 * Disable on-chip PIO FIFO/buffer (to avoid problems handling I/O errors later)
 	 */
@@ -529,7 +685,12 @@ static void hpt366_tune_chipset (ide_dri
 	}	
 	reg2 &= ~0x80000000;
 
-	pci_write_config_dword(drive->channel->pci_dev, regtime, reg2);
+	pci_write_config_dword(dev, regtime, reg2);
+}
+
+static void hpt368_tune_chipset (ide_drive_t *drive, byte speed)
+{
+	hpt366_tune_chipset(drive, speed);
 }
 
 static void hpt370_tune_chipset (ide_drive_t *drive, byte speed)
@@ -575,6 +736,39 @@ static void hpt370_tune_chipset (ide_dri
 	pci_write_config_dword(dev, drive_pci, list_conf);
 }
 
+static void hpt372_tune_chipset (ide_drive_t *drive, byte speed)
+{
+	byte regfast		= (drive->channel->unit) ? 0x55 : 0x51;
+	unsigned int list_conf	= 0;
+	unsigned int drive_conf	= 0;
+	unsigned int conf_mask	= (speed >= XFER_MW_DMA_0) ? 0xc0000000 : 0x30070000;
+	byte drive_pci		= 0x40 + (drive->dn * 4);
+	byte drive_fast		= 0;
+	struct pci_dev *dev	= drive->channel->pci_dev;
+
+	/*
+	 * Disable the "fast interrupt" prediction.
+	 * don't holdoff on interrupts. (== 0x01 despite what the docs say)
+	 */
+	pci_read_config_byte(dev, regfast, &drive_fast);
+	drive_fast &= ~0x07;
+	pci_write_config_byte(drive->channel->pci_dev, regfast, drive_fast);
+					
+	list_conf = pci_bus_clock_list(speed,
+			(struct chipset_bus_clock_list_entry *)
+					dev->sysdata);
+	pci_read_config_dword(dev, drive_pci, &drive_conf);
+	list_conf = (list_conf & ~conf_mask) | (drive_conf & conf_mask);
+	if (speed < XFER_MW_DMA_0)
+		list_conf &= ~0x80000000; /* Disable on-chip PIO FIFO/buffer */
+	pci_write_config_dword(dev, drive_pci, list_conf);
+}
+
+static void hpt374_tune_chipset (ide_drive_t *drive, byte speed)
+{
+	hpt372_tune_chipset(drive, speed);
+}
+
 static int hpt3xx_tune_chipset (ide_drive_t *drive, byte speed)
 {
 	if ((drive->type != ATA_DISK) && (speed < XFER_SW_DMA_0))
@@ -583,9 +777,15 @@ static int hpt3xx_tune_chipset (ide_driv
 	if (!drive->init_speed)
 		drive->init_speed = speed;
 
-	if (pci_rev_check_hpt3xx(drive->channel->pci_dev)) {
+	if (pci_rev7_check_hpt3xx(drive->channel->pci_dev)) {
+		hpt374_tune_chipset(drive, speed);
+	} else if (pci_rev5_check_hpt3xx(drive->channel->pci_dev)) {
+		hpt372_tune_chipset(drive, speed);
+	} else if (pci_rev3_check_hpt3xx(drive->channel->pci_dev)) {
 		hpt370_tune_chipset(drive, speed);
-        } else {
+	} else if (pci_rev2_check_hpt3xx(drive->channel->pci_dev)) {
+		hpt368_tune_chipset(drive, speed);
+	} else {
                 hpt366_tune_chipset(drive, speed);
         }
 	drive->current_speed = speed;
@@ -662,13 +862,21 @@ static int config_chipset_for_dma (ide_d
 	byte ultra66		= eighty_ninty_three(drive);
 	int  rval;
 
+	config_chipset_for_pio(drive);
+	drive->init_speed = 0;
+	
 	if ((drive->type != ATA_DISK) && (speed < XFER_SW_DMA_0))
 		return ((int) ide_dma_off_quietly);
 
-	if ((id->dma_ultra & 0x0020) &&
+	if ((id->dma_ultra & 0x0040) &&
+	    (pci_rev5_check_hpt3xx(drive->channel->pci_dev)) &&
+	    (ultra66)) {
+		speed = XFER_UDMA_6;
+	} else if ((id->dma_ultra & 0x0020) &&
 	    (!check_in_drive_lists(drive, bad_ata100_5)) &&
 	    (HPT370_ALLOW_ATA100_5) &&
 	    (pci_rev_check_hpt3xx(drive->channel->pci_dev)) &&
+	    (pci_rev3_check_hpt3xx(drive->channel->pci_dev)) &&
 	    (ultra66)) {
 		speed = XFER_UDMA_5;
 	} else if ((id->dma_ultra & 0x0010) &&
@@ -701,7 +909,8 @@ static int config_chipset_for_dma (ide_d
 
 	(void) hpt3xx_tune_chipset(drive, speed);
 
-	rval = (int)(	((id->dma_ultra >> 11) & 7) ? ide_dma_on :
+	rval = (int)(	((id->dma_ultra >> 14) & 3) ? ide_dma_on :
+			((id->dma_ultra >> 11) & 7) ? ide_dma_on :
 			((id->dma_ultra >> 8) & 7) ? ide_dma_on :
 			((id->dma_mword >> 8) & 7) ? ide_dma_on :
 						     ide_dma_off_quietly);
@@ -724,12 +933,14 @@ void hpt3xx_intrproc (ide_drive_t *drive
 
 void hpt3xx_maskproc (ide_drive_t *drive, int mask)
 {
+	struct pci_dev *dev = drive->channel->pci_dev;
+
 	if (drive->quirk_list) {
-		if (pci_rev_check_hpt3xx(drive->channel->pci_dev)) {
+		if (pci_rev3_check_hpt3xx(dev)) {
 			byte reg5a = 0;
-			pci_read_config_byte(drive->channel->pci_dev, 0x5a, &reg5a);
+			pci_read_config_byte(dev, 0x5a, &reg5a);
 			if (((reg5a & 0x10) >> 4) != mask)
-				pci_write_config_byte(drive->channel->pci_dev, 0x5a, mask ? (reg5a | 0x10) : (reg5a & ~0x10));
+				pci_write_config_byte(dev, 0x5a, mask ? (reg5a | 0x10) : (reg5a & ~0x10));
 		} else {
 			if (mask) {
 				disable_irq(drive->channel->irq);
@@ -756,7 +967,7 @@ static int config_drive_xfer_rate (ide_d
 		}
 		dma_func = ide_dma_off_quietly;
 		if (id->field_valid & 4) {
-			if (id->dma_ultra & 0x002F) {
+			if (id->dma_ultra & 0x007F) {
 				/* Force if Capable UltraDMA */
 				dma_func = config_chipset_for_dma(drive);
 				if ((id->field_valid & 2) &&
@@ -885,6 +1096,43 @@ int hpt370_dmaproc(ide_dma_action_t func
 	}
 	return ide_dmaproc(func, drive, rq);	/* use standard DMA stuff */
 }
+
+int hpt374_dmaproc (ide_dma_action_t func, ide_drive_t *drive, struct request *rq)
+{
+	struct pci_dev *dev	= drive->channel->pci_dev;
+	struct ata_channel *hwif = drive->channel;
+	unsigned long dma_base	= hwif->dma_base;
+	byte mscreg		= hwif->unit ? 0x54 : 0x50;
+//	byte reginfo		= hwif->unit ? 0x56 : 0x52;
+	byte dma_stat;
+
+	switch (func) {
+		case ide_dma_check:
+			return config_drive_xfer_rate(drive);
+		case ide_dma_test_irq:	/* returns 1 if dma irq issued, 0 otherwise */
+			dma_stat = inb(dma_base+2);
+#if 0  /* do not set unless you know what you are doing */
+			if (dma_stat & 4) {
+				byte stat = GET_STAT();
+				outb(dma_base+2, dma_stat & 0xE4);
+			}
+#endif
+			/* return 1 if INTR asserted */
+			return (dma_stat & 4) == 4;
+		case ide_dma_end:
+		{
+			byte bwsr_mask = hwif->unit ? 0x02 : 0x01;
+			byte bwsr_stat, msc_stat;
+			pci_read_config_byte(dev, 0x6a, &bwsr_stat);
+			pci_read_config_byte(dev, mscreg, &msc_stat);
+			if ((bwsr_stat & bwsr_mask) == bwsr_mask)
+				pci_write_config_byte(dev, mscreg, msc_stat|0x30);
+		}
+		default:
+			break;
+	}
+	return ide_dmaproc(func, drive, rq);	/* use standard DMA stuff */
+}
 #endif /* CONFIG_BLK_DEV_IDEDMA */
 
 /*
@@ -1004,7 +1252,7 @@ static int hpt370_busproc(ide_drive_t * 
 	return 0;
 }
 
-static void __init init_hpt370(struct pci_dev *dev)
+static void __init init_hpt37x(struct pci_dev *dev)
 {
 	int adjust, i;
 	u16 freq;
@@ -1025,18 +1273,44 @@ static void __init init_hpt370(struct pc
 	freq &= 0x1FF;
 	if (freq < 0x9c) {
 		pll = F_LOW_PCI_33;
-		dev->sysdata = (void *) thirty_three_base_hpt370;
-		printk("HPT370: using 33MHz PCI clock\n");
+		if (pci_rev7_check_hpt3xx(dev)) {
+			dev->sysdata = (void *) thirty_three_base_hpt374;
+		} else if (pci_rev5_check_hpt3xx(dev)) {
+			dev->sysdata = (void *) thirty_three_base_hpt372;
+		} else if (dev->device == PCI_DEVICE_ID_TTI_HPT372) {
+			dev->sysdata = (void *) thirty_three_base_hpt372;
+		} else {
+			dev->sysdata = (void *) thirty_three_base_hpt370;
+		}
+		printk("HPT37X: using 33MHz PCI clock\n");
 	} else if (freq < 0xb0) {
 		pll = F_LOW_PCI_40;
 	} else if (freq < 0xc8) {
 		pll = F_LOW_PCI_50;
-		dev->sysdata = (void *) fifty_base_hpt370;
-		printk("HPT370: using 50MHz PCI clock\n");
+		if (pci_rev7_check_hpt3xx(dev)) {
+	//		dev->sysdata = (void *) fifty_base_hpt374;
+			BUG();
+		} else if (pci_rev5_check_hpt3xx(dev)) {
+			dev->sysdata = (void *) fifty_base_hpt372;
+		} else if (dev->device == PCI_DEVICE_ID_TTI_HPT372) {
+			dev->sysdata = (void *) fifty_base_hpt372;
+		} else {
+			dev->sysdata = (void *) fifty_base_hpt370;
+		}
+		printk("HPT37X: using 50MHz PCI clock\n");
 	} else {
 		pll = F_LOW_PCI_66;
-		dev->sysdata = (void *) sixty_six_base_hpt370;
-		printk("HPT370: using 66MHz PCI clock\n");
+		if (pci_rev7_check_hpt3xx(dev)) {
+	//		dev->sysdata = (void *) sixty_six_base_hpt374;
+			BUG();
+		} else if (pci_rev5_check_hpt3xx(dev)) {
+			dev->sysdata = (void *) sixty_six_base_hpt372;
+		} else if (dev->device == PCI_DEVICE_ID_TTI_HPT372) {
+			dev->sysdata = (void *) sixty_six_base_hpt372;
+		} else {
+			dev->sysdata = (void *) sixty_six_base_hpt370;
+		}
+		printk("HPT37X: using 66MHz PCI clock\n");
 	}
 	
 	/*
@@ -1047,7 +1321,7 @@ static void __init init_hpt370(struct pc
 	 * on PRST/SRST when the HPT state engine gets reset.
 	 */
 	if (dev->sysdata) 
-		goto init_hpt370_done;
+		goto init_hpt37X_done;
 	
 	/*
 	 * adjust PLL based upon PCI clock, enable it, and wait for
@@ -1074,9 +1348,18 @@ static void __init init_hpt370(struct pc
 				pci_write_config_dword(dev, 0x5c, 
 						       pll & ~0x100);
 				pci_write_config_byte(dev, 0x5b, 0x21);
-				dev->sysdata = (void *) fifty_base_hpt370;
-				printk("HPT370: using 50MHz internal PLL\n");
-				goto init_hpt370_done;
+				if (pci_rev7_check_hpt3xx(dev)) {
+	//	dev->sysdata = (void *) fifty_base_hpt374;
+					BUG();
+				} else if (pci_rev5_check_hpt3xx(dev)) {
+					dev->sysdata = (void *) fifty_base_hpt372;
+				} else if (dev->device == PCI_DEVICE_ID_TTI_HPT372) {
+					dev->sysdata = (void *) fifty_base_hpt372;
+				} else {
+					dev->sysdata = (void *) fifty_base_hpt370;
+				}
+				printk("HPT37X: using 50MHz internal PLL\n");
+				goto init_hpt37X_done;
 			}
 		}
 pll_recal:
@@ -1086,13 +1369,41 @@ pll_recal:
 			pll += (adjust >> 1);
 	} 
 
-init_hpt370_done:
+init_hpt37X_done:
 	/* reset state engine */
 	pci_write_config_byte(dev, 0x50, 0x37); 
 	pci_write_config_byte(dev, 0x54, 0x37); 
 	udelay(100);
 }
 
+static void __init init_hpt366 (struct pci_dev *dev)
+{
+	unsigned int reg1	= 0;
+	byte drive_fast		= 0;
+
+	/*
+	 * Disable the "fast interrupt" prediction.
+	 */
+	pci_read_config_byte(dev, 0x51, &drive_fast);
+	if (drive_fast & 0x80)
+		pci_write_config_byte(dev, 0x51, drive_fast & ~0x80);
+	pci_read_config_dword(dev, 0x40, &reg1);
+									
+	/* detect bus speed by looking at control reg timing: */
+	switch((reg1 >> 8) & 7) {
+		case 5:
+			dev->sysdata = (void *) forty_base_hpt366;
+			break;
+		case 9:
+			dev->sysdata = (void *) twenty_five_base_hpt366;
+			break;
+		case 7:
+		default:
+			dev->sysdata = (void *) thirty_three_base_hpt366;
+			break;
+	}
+}
+
 unsigned int __init pci_init_hpt366(struct pci_dev *dev)
 {
 	byte test = 0;
@@ -1116,8 +1427,10 @@ unsigned int __init pci_init_hpt366(stru
 	if (test != 0x08)
 		pci_write_config_byte(dev, PCI_MAX_LAT, 0x08);
 
-	if (pci_rev_check_hpt3xx(dev))
-		init_hpt370(dev);
+	if (pci_rev3_check_hpt3xx(dev))
+		init_hpt37x(dev);
+	else
+		init_hpt366(dev);
 
 	if (n_hpt_devs < HPT366_MAX_DEVS)
 		hpt_devs[n_hpt_devs++] = dev;
@@ -1148,8 +1461,6 @@ unsigned int __init ata66_hpt366(struct 
 
 void __init ide_init_hpt366(struct ata_channel *hwif)
 {
-	int hpt_rev;
-
 	hwif->tuneproc	= &hpt3xx_tune_drive;
 	hwif->speedproc	= &hpt3xx_tune_chipset;
 	hwif->quirkproc	= &hpt3xx_quirkproc;
@@ -1162,32 +1473,38 @@ void __init ide_init_hpt366(struct ata_c
 		hwif->serialized = hwif->mate->serialized = 1;
 #endif
 
-	hpt_rev = pci_rev_check_hpt3xx(hwif->pci_dev);
-	if (hpt_rev) {
-		/* set up ioctl for power status. note: power affects both
-		 * drives on each channel */
-		hwif->busproc   = &hpt370_busproc;
-	}
-
-	if (pci_rev2_check_hpt3xx(hwif->pci_dev)) {
-		/* do nothing now but will split device types */
-		hwif->resetproc = &hpt3xx_reset;
-/*
- * don't do until we can parse out the cobalt box argh ...
- *		hwif->busproc   = &hpt3xx_tristate;
- */
-	}
-
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	if (hwif->dma_base) {
-		if (hpt_rev) {
+		if (pci_rev3_check_hpt3xx(hwif->pci_dev)) {
 			byte reg5ah = 0;
 			pci_read_config_byte(hwif->pci_dev, 0x5a, &reg5ah);
 			if (reg5ah & 0x10)	/* interrupt force enable */
 				pci_write_config_byte(hwif->pci_dev, 0x5a, reg5ah & ~0x10);
-			hwif->udma = hpt370_dmaproc;
+			/*
+			 * set up ioctl for power status.
+			 * note: power affects both
+			 * drives on each channel
+			 */
+			hwif->resetproc	= &hpt3xx_reset;
+			hwif->busproc	= &hpt370_busproc;
+
+			if (pci_rev7_check_hpt3xx(hwif->pci_dev)) {
+				hwif->udma	= &hpt374_dmaproc;
+			} else if (pci_rev5_check_hpt3xx(hwif->pci_dev)) {
+				hwif->udma	= &hpt374_dmaproc;
+			} else if (hwif->pci_dev->device == PCI_DEVICE_ID_TTI_HPT372) {
+				hwif->udma	= &hpt374_dmaproc;
+			} else if (pci_rev3_check_hpt3xx(hwif->pci_dev)) {
+				hwif->udma	= &hpt370_dmaproc;
+			}
+		} else if (pci_rev2_check_hpt3xx(hwif->pci_dev)) {
+//			hwif->resetproc	= &hpt3xx_reset;
+//			hwif->busproc	= &hpt3xx_tristate;
+			hwif->udma	= &hpt366_dmaproc;
 		} else {
-			hwif->udma = hpt366_dmaproc;
+//			hwif->resetproc = &hpt3xx_reset;
+//			hwif->busproc   = &hpt3xx_tristate;
+			hwif->udma = &hpt366_dmaproc;
 		}
 		if (!noautodma)
 			hwif->autodma = 1;
--- 2.5.13/include/linux/pci_ids.h~hpt374	Fri May  3 14:05:12 2002
+++ 2.5.13-akpm/include/linux/pci_ids.h	Fri May  3 14:05:12 2002
@@ -932,6 +932,8 @@
 #define PCI_VENDOR_ID_TTI		0x1103
 #define PCI_DEVICE_ID_TTI_HPT343	0x0003
 #define PCI_DEVICE_ID_TTI_HPT366	0x0004
+#define PCI_DEVICE_ID_TTI_HPT372	0x0005
+#define PCI_DEVICE_ID_TTI_HPT374	0x0008
 
 #define PCI_VENDOR_ID_VIA		0x1106
 #define PCI_DEVICE_ID_VIA_8363_0	0x0305 
--- 2.5.13/drivers/ide/ide-pci.c~hpt374	Fri May  3 14:05:12 2002
+++ 2.5.13-akpm/drivers/ide/ide-pci.c	Fri May  3 14:05:12 2002
@@ -270,6 +270,8 @@ static ide_pci_device_t pci_chipsets[] _
 #endif
 #ifdef CONFIG_BLK_DEV_HPT366
 	{PCI_VENDOR_ID_TTI, PCI_DEVICE_ID_TTI_HPT366, pci_init_hpt366, ata66_hpt366, ide_init_hpt366, ide_dmacapable_hpt366, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, OFF_BOARD, 240, ATA_F_IRQ | ATA_F_HPTHACK | ATA_F_DMA },
+	{PCI_VENDOR_ID_TTI, PCI_DEVICE_ID_TTI_HPT372, pci_init_hpt366, ata66_hpt366, ide_init_hpt366, ide_dmacapable_hpt366, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, OFF_BOARD, 0, ATA_F_IRQ | ATA_F_HPTHACK | ATA_F_DMA },
+	{PCI_VENDOR_ID_TTI, PCI_DEVICE_ID_TTI_HPT374, pci_init_hpt366, ata66_hpt366, ide_init_hpt366, ide_dmacapable_hpt366, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, OFF_BOARD, 0, ATA_F_IRQ | ATA_F_HPTHACK | ATA_F_DMA },
 #endif
 #ifdef CONFIG_BLK_DEV_ALI15X3
 	{PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M5229, pci_init_ali15x3, ata66_ali15x3, ide_init_ali15x3, ide_dmacapable_ali15x3, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, ON_BOARD, 0, 0 },
@@ -312,6 +314,8 @@ static ide_pci_device_t pci_chipsets[] _
 	{PCI_VENDOR_ID_UMC, PCI_DEVICE_ID_UMC_UM8886BF, NULL, NULL, NULL, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, ON_BOARD, 0, ATA_F_FIXIRQ },
 	{PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C561, NULL, NULL, NULL, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, ON_BOARD, 0, ATA_F_NOADMA },
 	{PCI_VENDOR_ID_TTI, PCI_DEVICE_ID_TTI_HPT366, NULL, NULL, IDE_NO_DRIVER, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, OFF_BOARD, 240, ATA_F_IRQ | ATA_F_HPTHACK },
+	{PCI_VENDOR_ID_TTI, PCI_DEVICE_ID_TTI_HPT372, NULL, NULL, IDE_NO_DRIVER, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, OFF_BOARD, 0, ATA_F_IRQ | ATA_F_HPTHACK },
+	{PCI_VENDOR_ID_TTI, PCI_DEVICE_ID_TTI_HPT374, NULL, NULL, IDE_NO_DRIVER, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, OFF_BOARD, 0, ATA_F_IRQ | ATA_F_HPTHACK },
 	{0, 0, NULL, NULL, NULL, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, ON_BOARD, 0 }};
 
 /*
@@ -814,6 +818,47 @@ static void __init pdc20270_device_order
 	setup_pci_device(dev2, d2);
 }
 
+static void __init hpt374_device_order_fixup (struct pci_dev *dev, ide_pci_device_t *d)
+{
+	struct pci_dev *dev2 = NULL, *findev;
+	ide_pci_device_t *d2;
+
+	if (PCI_FUNC(dev->devfn) & 1)
+		return;
+
+	pci_for_each_dev(findev) {
+		if ((findev->vendor == dev->vendor) &&
+		    (findev->device == dev->device) &&
+		    ((findev->devfn - dev->devfn) == 1) &&
+		    (PCI_FUNC(findev->devfn) & 1)) {
+			dev2 = findev;
+			break;
+		}
+	}
+
+	printk("%s: IDE controller on PCI bus %02x dev %02x\n",
+		dev->name, dev->bus->number, dev->devfn);
+	setup_pci_device(dev, d);
+	if (!dev2) {
+		return;
+	} else {
+		byte irq = 0, irq2 = 0;
+		pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
+		pci_read_config_byte(dev2, PCI_INTERRUPT_LINE, &irq2);
+		if (irq != irq2) {
+			pci_write_config_byte(dev2, PCI_INTERRUPT_LINE, irq);
+			dev2->irq = dev->irq;
+			printk("%s: pci-config space interrupt fixed.\n",
+				dev2->name);
+		}
+	}
+	d2 = d;
+	printk("%s: IDE controller on PCI bus %02x dev %02x\n",
+		dev2->name, dev2->bus->number, dev2->devfn);
+	setup_pci_device(dev2, d2);
+
+}
+
 static void __init hpt366_device_order_fixup (struct pci_dev *dev, ide_pci_device_t *d)
 {
 	struct pci_dev *dev2 = NULL, *findev;
@@ -828,6 +873,7 @@ static void __init hpt366_device_order_f
 	class_rev &= 0xff;
 
 	switch(class_rev) {
+		case 5:
 		case 4:
 		case 3:	printk("%s: IDE controller on PCI slot %s\n", dev->name, dev->slot_name);
 			setup_pci_device(dev, d);
@@ -890,8 +936,12 @@ static void __init scan_pcidev(struct pc
 		return;	/* IT8172G is also more than only an IDE controller */
 	else if ((d->vendor == PCI_VENDOR_ID_UMC && d->device == PCI_DEVICE_ID_UMC_UM8886A) && !(PCI_FUNC(dev->devfn) & 1))
 		return;	/* UM8886A/BF pair */
-	else if (d->flags & ATA_F_HPTHACK)
-		hpt366_device_order_fixup(dev, d);
+	else if (d->flags & ATA_F_HPTHACK) {
+		if (d->device == PCI_DEVICE_ID_TTI_HPT366)
+			hpt366_device_order_fixup(dev, d);
+		if (d->device == PCI_DEVICE_ID_TTI_HPT374)
+			hpt374_device_order_fixup(dev, d);
+	}
 	else if (d->vendor == PCI_VENDOR_ID_PROMISE && d->device == PCI_DEVICE_ID_PROMISE_20268R)
 		pdc20270_device_order_fixup(dev, d);
 	else if (!(d->vendor == 0 && d->device == 0) || (dev->class >> 8) == PCI_CLASS_STORAGE_IDE) {


-
