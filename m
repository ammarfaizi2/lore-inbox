Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264799AbSLGVqi>; Sat, 7 Dec 2002 16:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264806AbSLGVqi>; Sat, 7 Dec 2002 16:46:38 -0500
Received: from packet.digeo.com ([12.110.80.53]:31454 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264799AbSLGVq0>;
	Sat, 7 Dec 2002 16:46:26 -0500
Message-ID: <3DF26DF4.F1692AFA@digeo.com>
Date: Sat, 07 Dec 2002 13:53:56 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jorg de jong <jorg@dejong.info>
CC: linux-kernel@vger.kernel.org
Subject: Re: status of HPT374 support in 2.4.20 and 2.5.50
References: <3DF26772.8040502@dejong.info>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Dec 2002 21:53:56.0494 (UTC) FILETIME=[240DD2E0:01C29E3B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jorg de jong wrote:
> 
> Hi,
> 
> I just bought a Highpoint Rocketraid 404 controler. To my suppirce I
> found that
> the kernel I was using does not like it one bit. The kernel entered a
> kernel panic/BUG
> in file hpt666.c:1031. The kernel was a Redhat stock kernel
> 2.4.18-18.8.0smp.
> 
> Not afraid to build my own kernel I tried:
> - 2.4.20; which also stoped with a kernel panic.
> - 2.4.20-ac1; this kernel boots just fine. It even sees the controller
> but does not detect
> the drive.
> - 2.5.46; sees the controler but no drive
> - 2.5.50; sees the controler but no drive
> 

This patch (against 2.4.20) is the one I use when I need to
use the hpt374 in 2.4 kernels.


 drivers/ide/hpt366.c  |  468 ++++++++++++++++++++++++++++++++++++++++----------
 drivers/ide/ide-pci.c |   69 ++++++-
 2 files changed, 446 insertions(+), 91 deletions(-)

--- 24/drivers/ide/hpt366.c~hpt374	Sat Dec  7 13:51:38 2002
+++ 24-akpm/drivers/ide/hpt366.c	Sat Dec  7 13:51:38 2002
@@ -166,9 +166,8 @@ struct chipset_bus_clock_list_entry {
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
@@ -186,8 +185,7 @@ struct chipset_bus_clock_list_entry fort
 	{	0,		0x0120d9d9	}
 };
 
-struct chipset_bus_clock_list_entry thirty_three_base [] = {
-
+struct chipset_bus_clock_list_entry thirty_three_base_hpt366[] = {
 	{	XFER_UDMA_4,	0x90c9a731	},
 	{	XFER_UDMA_3,	0x90cfa731	},
 	{	XFER_UDMA_2,	0x90caa731	},
@@ -206,7 +204,7 @@ struct chipset_bus_clock_list_entry thir
 	{	0,		0x0120a7a7	}
 };
 
-struct chipset_bus_clock_list_entry twenty_five_base [] = {
+struct chipset_bus_clock_list_entry twenty_five_base_hpt366[] = {
 
 	{	XFER_UDMA_4,	0x90c98521	},
 	{	XFER_UDMA_3,	0x90cf8521	},
@@ -331,6 +329,144 @@ struct chipset_bus_clock_list_entry fift
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
@@ -347,6 +483,10 @@ static int n_hpt_devs;
 
 static unsigned int pci_rev_check_hpt3xx(struct pci_dev *dev);
 static unsigned int pci_rev2_check_hpt3xx(struct pci_dev *dev);
+static unsigned int pci_rev3_check_hpt3xx(struct pci_dev *dev);
+static unsigned int pci_rev5_check_hpt3xx(struct pci_dev *dev);
+static unsigned int pci_rev7_check_hpt3xx(struct pci_dev *dev);
+
 byte hpt366_proc = 0;
 byte hpt363_shared_irq;
 byte hpt363_shared_pin;
@@ -360,11 +500,13 @@ extern char *ide_media_verbose(ide_drive
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
 		unsigned long iobase = dev->resource[4].start;
@@ -388,7 +530,7 @@ static int hpt366_get_info (char *buffer
 			(c0 & 0x80) ? "no" : "yes",
 			(c1 & 0x80) ? "no" : "yes");
 
-		if (pci_rev_check_hpt3xx(dev)) {
+		if (pci_rev3_check_hpt3xx(dev)) {
 			u8 cbl;
 			cbl = inb_p(iobase + 0x7b);
 			outb_p(cbl | 1, iobase + 0x7b);
@@ -437,7 +579,19 @@ static int hpt366_get_info (char *buffer
 }
 #endif  /* defined(DISPLAY_HPT366_TIMINGS) && defined(CONFIG_PROC_FS) */
 
-static unsigned int pci_rev_check_hpt3xx (struct pci_dev *dev)
+/*
+ * fixme: it really needs to be a switch.
+ */
+
+static unsigned int pci_rev2_check_hpt3xx (struct pci_dev *dev)
+{
+	unsigned int class_rev;
+	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
+	class_rev &= 0xff;
+	return ((int) (class_rev > 0x01) ? 1 : 0);
+}
+
+static unsigned int pci_rev3_check_hpt3xx (struct pci_dev *dev)
 {
 	unsigned int class_rev;
 	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
@@ -445,12 +599,20 @@ static unsigned int pci_rev_check_hpt3xx
 	return ((int) (class_rev > 0x02) ? 1 : 0);
 }
 
-static unsigned int pci_rev2_check_hpt3xx (struct pci_dev *dev)
+static unsigned int pci_rev5_check_hpt3xx (struct pci_dev *dev)
 {
 	unsigned int class_rev;
 	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
 	class_rev &= 0xff;
-	return ((int) (class_rev > 0x01) ? 1 : 0);
+	return ((int) (class_rev > 0x04) ? 1 : 0);
+}
+
+static unsigned int pci_rev7_check_hpt3xx (struct pci_dev *dev)
+{
+	unsigned int class_rev;
+	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
+	class_rev &= 0xff;
+	return ((int) (class_rev > 0x06) ? 1 : 0);
 }
 
 static int check_in_drive_lists (ide_drive_t *drive, const char **list)
@@ -484,6 +646,7 @@ static unsigned int pci_bus_clock_list (
 
 static void hpt366_tune_chipset (ide_drive_t *drive, byte speed)
 {
+	struct pci_dev *dev	= HWIF(drive)->pci_dev;
 	byte regtime		= (drive->select.b.unit & 0x01) ? 0x44 : 0x40;
 	byte regfast		= (HWIF(drive)->channel) ? 0x55 : 0x51;
 			/*
@@ -497,30 +660,13 @@ static void hpt366_tune_chipset (ide_dri
 	/*
 	 * Disable the "fast interrupt" prediction. 
 	 */
-	pci_read_config_byte(HWIF(drive)->pci_dev, regfast, &drive_fast);
+	pci_read_config_byte(dev, regfast, &drive_fast);
 	if (drive_fast & 0x02)
-		pci_write_config_byte(HWIF(drive)->pci_dev, regfast, drive_fast & ~0x20);
+		pci_write_config_byte(dev, regfast, drive_fast & ~0x20);
 
-	pci_read_config_dword(HWIF(drive)->pci_dev, regtime, &reg1);
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
@@ -531,7 +677,12 @@ static void hpt366_tune_chipset (ide_dri
 	}	
 	reg2 &= ~0x80000000;
 
-	pci_write_config_dword(HWIF(drive)->pci_dev, regtime, reg2);
+	pci_write_config_dword(dev, regtime, reg2);
+}
+
+static void hpt368_tune_chipset (ide_drive_t *drive, byte speed)
+{
+	hpt366_tune_chipset(drive, speed);
 }
 
 static void hpt370_tune_chipset (ide_drive_t *drive, byte speed)
@@ -577,6 +728,39 @@ static void hpt370_tune_chipset (ide_dri
 	pci_write_config_dword(dev, drive_pci, list_conf);
 }
 
+static void hpt372_tune_chipset (ide_drive_t *drive, byte speed)
+{
+	byte regfast		= (HWIF(drive)->channel) ? 0x55 : 0x51;
+	unsigned int list_conf	= 0;
+	unsigned int drive_conf	= 0;
+	unsigned int conf_mask	= (speed >= XFER_MW_DMA_0) ? 0xc0000000 : 0x30070000;
+	byte drive_pci		= 0x40 + (drive->dn * 4);
+	byte drive_fast		= 0;
+	struct pci_dev *dev	= HWIF(drive)->pci_dev;
+
+	/*
+	 * Disable the "fast interrupt" prediction.
+	 * don't holdoff on interrupts. (== 0x01 despite what the docs say)
+	 */
+	pci_read_config_byte(dev, regfast, &drive_fast);
+	drive_fast &= ~0x07;
+	pci_write_config_byte(HWIF(drive)->pci_dev, regfast, drive_fast);
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
 	if ((drive->media != ide_disk) && (speed < XFER_SW_DMA_0))
@@ -585,9 +769,15 @@ static int hpt3xx_tune_chipset (ide_driv
 	if (!drive->init_speed)
 		drive->init_speed = speed;
 
-	if (pci_rev_check_hpt3xx(HWIF(drive)->pci_dev)) {
+	if (pci_rev7_check_hpt3xx(HWIF(drive)->pci_dev)) {
+		hpt374_tune_chipset(drive, speed);
+	} else if (pci_rev5_check_hpt3xx(HWIF(drive)->pci_dev)) {
+		hpt372_tune_chipset(drive, speed);
+	} else if (pci_rev3_check_hpt3xx(HWIF(drive)->pci_dev)) {
 		hpt370_tune_chipset(drive, speed);
-        } else {
+	} else if (pci_rev2_check_hpt3xx(HWIF(drive)->pci_dev)) {
+		hpt368_tune_chipset(drive, speed);
+	} else {
                 hpt366_tune_chipset(drive, speed);
         }
 	drive->current_speed = speed;
@@ -664,13 +854,20 @@ static int config_chipset_for_dma (ide_d
 	byte ultra66		= eighty_ninty_three(drive);
 	int  rval;
 
+	config_chipset_for_pio(drive);
+	drive->init_speed = 0;
+	
 	if ((drive->media != ide_disk) && (speed < XFER_SW_DMA_0))
 		return ((int) ide_dma_off_quietly);
 
-	if ((id->dma_ultra & 0x0020) &&
+	if ((id->dma_ultra & 0x0040) &&
+	    (pci_rev5_check_hpt3xx(HWIF(drive)->pci_dev)) &&
+	    (ultra66)) {
+		speed = XFER_UDMA_6;
+	} else if ((id->dma_ultra & 0x0020) &&
 	    (!check_in_drive_lists(drive, bad_ata100_5)) &&
 	    (HPT370_ALLOW_ATA100_5) &&
-	    (pci_rev_check_hpt3xx(HWIF(drive)->pci_dev)) &&
+	    (pci_rev3_check_hpt3xx(HWIF(drive)->pci_dev)) &&
 	    (ultra66)) {
 		speed = XFER_UDMA_5;
 	} else if ((id->dma_ultra & 0x0010) &&
@@ -703,7 +900,8 @@ static int config_chipset_for_dma (ide_d
 
 	(void) hpt3xx_tune_chipset(drive, speed);
 
-	rval = (int)(	((id->dma_ultra >> 11) & 7) ? ide_dma_on :
+	rval = (int)(	((id->dma_ultra >> 14) & 3) ? ide_dma_on :
+			((id->dma_ultra >> 11) & 7) ? ide_dma_on :
 			((id->dma_ultra >> 8) & 7) ? ide_dma_on :
 			((id->dma_mword >> 8) & 7) ? ide_dma_on :
 						     ide_dma_off_quietly);
@@ -726,12 +924,14 @@ void hpt3xx_intrproc (ide_drive_t *drive
 
 void hpt3xx_maskproc (ide_drive_t *drive, int mask)
 {
+	struct pci_dev *dev = HWIF(drive)->pci_dev;
+
 	if (drive->quirk_list) {
-		if (pci_rev_check_hpt3xx(HWIF(drive)->pci_dev)) {
+		if (pci_rev3_check_hpt3xx(dev)) {
 			byte reg5a = 0;
-			pci_read_config_byte(HWIF(drive)->pci_dev, 0x5a, &reg5a);
+			pci_read_config_byte(dev, 0x5a, &reg5a);
 			if (((reg5a & 0x10) >> 4) != mask)
-				pci_write_config_byte(HWIF(drive)->pci_dev, 0x5a, mask ? (reg5a | 0x10) : (reg5a & ~0x10));
+				pci_write_config_byte(dev, 0x5a, mask ? (reg5a | 0x10) : (reg5a & ~0x10));
 		} else {
 			if (mask) {
 				disable_irq(HWIF(drive)->irq);
@@ -758,7 +958,7 @@ static int config_drive_xfer_rate (ide_d
 		}
 		dma_func = ide_dma_off_quietly;
 		if (id->field_valid & 4) {
-			if (id->dma_ultra & 0x002F) {
+			if (id->dma_ultra & 0x007F) {
 				/* Force if Capable UltraDMA */
 				dma_func = config_chipset_for_dma(drive);
 				if ((id->field_valid & 2) &&
@@ -889,6 +1089,43 @@ int hpt370_dmaproc (ide_dma_action_t fun
 	}
 	return ide_dmaproc(func, drive);	/* use standard DMA stuff */
 }
+
+int hpt374_dmaproc (ide_dma_action_t func, ide_drive_t *drive)
+{
+	struct pci_dev *dev	= HWIF(drive)->pci_dev;
+	ide_hwif_t *hwif	= HWIF(drive);
+	unsigned long dma_base	= hwif->dma_base;
+	byte mscreg		= hwif->channel ? 0x54 : 0x50;
+//	byte reginfo		= hwif->channel ? 0x56 : 0x52;
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
+			byte bwsr_mask = hwif->channel ? 0x02 : 0x01;
+			byte bwsr_stat, msc_stat;
+			pci_read_config_byte(dev, 0x6a, &bwsr_stat);
+			pci_read_config_byte(dev, mscreg, &msc_stat);
+			if ((bwsr_stat & bwsr_mask) == bwsr_mask)
+				pci_write_config_byte(dev, mscreg, msc_stat|0x30);
+		}
+		default:
+			break;
+	}
+	return ide_dmaproc(func, drive);	/* use standard DMA stuff */
+}
 #endif /* CONFIG_BLK_DEV_IDEDMA */
 
 /*
@@ -1006,7 +1243,7 @@ static int hpt370_busproc(ide_drive_t * 
 	return 0;
 }
 
-static void __init init_hpt370(struct pci_dev *dev)
+static void __init init_hpt37x(struct pci_dev *dev)
 {
 	int adjust, i;
 	u16 freq;
@@ -1027,18 +1264,44 @@ static void __init init_hpt370(struct pc
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
@@ -1049,7 +1312,7 @@ static void __init init_hpt370(struct pc
 	 * on PRST/SRST when the HPT state engine gets reset.
 	 */
 	if (dev->sysdata) 
-		goto init_hpt370_done;
+		goto init_hpt37X_done;
 	
 	/*
 	 * adjust PLL based upon PCI clock, enable it, and wait for
@@ -1076,9 +1339,18 @@ static void __init init_hpt370(struct pc
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
@@ -1088,13 +1360,41 @@ pll_recal:
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
 unsigned int __init pci_init_hpt366 (struct pci_dev *dev, const char *name)
 {
 	byte test = 0;
@@ -1118,20 +1418,14 @@ unsigned int __init pci_init_hpt366 (str
 	if (test != 0x08)
 		pci_write_config_byte(dev, PCI_MAX_LAT, 0x08);
 
-	if (pci_rev_check_hpt3xx(dev)) {
-		init_hpt370(dev);
+	if (pci_rev3_check_hpt3xx(dev)) {
+		init_hpt37x(dev);
 		hpt_devs[n_hpt_devs++] = dev;
 	} else {
+		init_hpt366(dev);
 		hpt_devs[n_hpt_devs++] = dev;
 	}
 	
-#if defined(DISPLAY_HPT366_TIMINGS) && defined(CONFIG_PROC_FS)
-	if (!hpt366_proc) {
-		hpt366_proc = 1;
-		hpt366_display_info = &hpt366_get_info;
-	}
-#endif /* DISPLAY_HPT366_TIMINGS && CONFIG_PROC_FS */
-
 	return dev->irq;
 }
 
@@ -1151,8 +1445,6 @@ unsigned int __init ata66_hpt366 (ide_hw
 
 void __init ide_init_hpt366 (ide_hwif_t *hwif)
 {
-	int hpt_rev;
-
 	hwif->tuneproc	= &hpt3xx_tune_drive;
 	hwif->speedproc	= &hpt3xx_tune_chipset;
 	hwif->quirkproc	= &hpt3xx_quirkproc;
@@ -1165,31 +1457,37 @@ void __init ide_init_hpt366 (ide_hwif_t 
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
-			hwif->dmaproc = &hpt370_dmaproc;
+			/*
+			 * set up ioctl for power status.
+			 * note: power affects both
+			 * drives on each channel
+			 */
+			hwif->resetproc	= &hpt3xx_reset;
+			hwif->busproc	= &hpt370_busproc;
+
+			if (pci_rev7_check_hpt3xx(hwif->pci_dev)) {
+				hwif->dmaproc	= &hpt374_dmaproc;
+			} else if (pci_rev5_check_hpt3xx(hwif->pci_dev)) {
+				hwif->dmaproc	= &hpt374_dmaproc;
+			} else if (hwif->pci_dev->device == PCI_DEVICE_ID_TTI_HPT372) {
+				hwif->dmaproc	= &hpt374_dmaproc;
+			} else if (pci_rev3_check_hpt3xx(hwif->pci_dev)) {
+				hwif->dmaproc	= &hpt370_dmaproc;
+			}
+		} else if (pci_rev2_check_hpt3xx(hwif->pci_dev)) {
+//			hwif->resetproc	= &hpt3xx_reset;
+//			hwif->busproc	= &hpt3xx_tristate;
+			hwif->dmaproc	= &hpt366_dmaproc;
 		} else {
+//			hwif->resetproc = &hpt3xx_reset;
+//			hwif->busproc   = &hpt3xx_tristate;
 			hwif->dmaproc = &hpt366_dmaproc;
 		}
 		if (!noautodma)
--- 24/drivers/ide/ide-pci.c~hpt374	Sat Dec  7 13:51:38 2002
+++ 24-akpm/drivers/ide/ide-pci.c	Sat Dec  7 13:51:38 2002
@@ -79,6 +79,8 @@
 #define DEVID_UM8886BF	((ide_pci_devid_t){PCI_VENDOR_ID_UMC,     PCI_DEVICE_ID_UMC_UM8886BF})
 #define DEVID_HPT34X	((ide_pci_devid_t){PCI_VENDOR_ID_TTI,     PCI_DEVICE_ID_TTI_HPT343})
 #define DEVID_HPT366	((ide_pci_devid_t){PCI_VENDOR_ID_TTI,     PCI_DEVICE_ID_TTI_HPT366})
+#define DEVID_HPT372	((ide_pci_devid_t){PCI_VENDOR_ID_TTI,     PCI_DEVICE_ID_TTI_HPT372})
+#define DEVID_HPT374	((ide_pci_devid_t){PCI_VENDOR_ID_TTI,     PCI_DEVICE_ID_TTI_HPT374})
 #define DEVID_ALI15X3	((ide_pci_devid_t){PCI_VENDOR_ID_AL,      PCI_DEVICE_ID_AL_M5229})
 #define DEVID_CY82C693	((ide_pci_devid_t){PCI_VENDOR_ID_CONTAQ,  PCI_DEVICE_ID_CONTAQ_82C693})
 #define DEVID_HINT	((ide_pci_devid_t){0x3388,                0x8013})
@@ -450,6 +452,13 @@ static ide_pci_device_t ide_pci_chipsets
 	{DEVID_UM8886BF,"UM8886BF",	NULL,		NULL,		NULL,		NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}}, 	ON_BOARD,	0 },
 	{DEVID_HPT34X,	"HPT34X",	PCI_HPT34X,	NULL,		INIT_HPT34X,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	NEVER_BOARD,	16 },
 	{DEVID_HPT366,	"HPT366",	PCI_HPT366,	ATA66_HPT366,	INIT_HPT366,	DMA_HPT366,	{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	OFF_BOARD,	240 },
+#if 1
+	{DEVID_HPT372,	"HPT372",	PCI_HPT366,	ATA66_HPT366,	INIT_HPT366,	DMA_HPT366,	{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	OFF_BOARD,	0 },
+	{DEVID_HPT374,	"HPT374",	PCI_HPT366,	ATA66_HPT366,	INIT_HPT366,	DMA_HPT366,	{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	OFF_BOARD,	0 },
+#else
+	{DEVID_HPT372,	"HPT372",	NULL,		NULL,		NULL,		NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	OFF_BOARD,	0 },
+	{DEVID_HPT374,	"HPT374",	NULL,		NULL,		NULL,		NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	OFF_BOARD,	0 },
+#endif
 	{DEVID_ALI15X3,	"ALI15X3",	PCI_ALI15X3,	ATA66_ALI15X3,	INIT_ALI15X3,	DMA_ALI15X3,	{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	ON_BOARD,	0 },
 	{DEVID_CY82C693,"CY82C693",	PCI_CY82C693,	NULL,		INIT_CY82C693,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	ON_BOARD,	0 },
 	{DEVID_HINT,	"HINT_IDE",	NULL,		NULL,		NULL,		NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	ON_BOARD,	0 },
@@ -474,6 +483,7 @@ static unsigned int __init ide_special_s
 {
 	switch(dev->device) {
 		case PCI_DEVICE_ID_TTI_HPT366:
+		case PCI_DEVICE_ID_TTI_HPT374:
 		case PCI_DEVICE_ID_PROMISE_20246:
 		case PCI_DEVICE_ID_PROMISE_20262:
 		case PCI_DEVICE_ID_PROMISE_20265:
@@ -824,6 +834,7 @@ controller_ok:			
 		    IDE_PCI_DEVID_EQ(d->devid, DEVID_AEC6260R) ||
 		    IDE_PCI_DEVID_EQ(d->devid, DEVID_HPT34X) ||
 		    IDE_PCI_DEVID_EQ(d->devid, DEVID_HPT366) ||
+		    IDE_PCI_DEVID_EQ(d->devid, DEVID_HPT374) ||
 		    IDE_PCI_DEVID_EQ(d->devid, DEVID_CS5530) ||
 		    IDE_PCI_DEVID_EQ(d->devid, DEVID_CY82C693) ||
 		    IDE_PCI_DEVID_EQ(d->devid, DEVID_CMD646) ||
@@ -906,6 +917,44 @@ static void __init pdc20270_device_order
 	ide_setup_pci_device(dev2, d2);
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
+	printk("%s: IDE controller on PCI bus %02x dev %02x\n", d->name, dev->bus->number, dev->devfn);
+	ide_setup_pci_device(dev, d);
+	if (!dev2) {
+		return;
+	} else {
+		byte irq = 0, irq2 = 0;
+		pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
+		pci_read_config_byte(dev2, PCI_INTERRUPT_LINE, &irq2);
+		if (irq != irq2) {
+			pci_write_config_byte(dev2, PCI_INTERRUPT_LINE, irq);
+			dev2->irq = dev->irq;
+			printk("%s: pci-config space interrupt fixed.\n", d->name);
+		}
+	}
+	d2 = d;
+	printk("%s: IDE controller on PCI bus %02x dev %02x\n", d2->name, dev2->bus->number, dev2->devfn);
+	ide_setup_pci_device(dev2, d2);
+
+}
+
 static void __init hpt366_device_order_fixup (struct pci_dev *dev, ide_pci_device_t *d)
 {
 	struct pci_dev *dev2 = NULL, *findev;
@@ -919,12 +968,11 @@ static void __init hpt366_device_order_f
 
 	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
 	class_rev &= 0xff;
-	if (class_rev > 5)
-		class_rev = 5;
-	
+
 	strcpy(d->name, chipset_names[class_rev]);
 
 	switch(class_rev) {
+		case 5:
 		case 4:
 		case 3:	printk("%s: IDE controller on PCI bus %02x dev %02x\n", d->name, dev->bus->number, dev->devfn);
 			ide_setup_pci_device(dev, d);
@@ -944,11 +992,18 @@ static void __init hpt366_device_order_f
 			hpt363_shared_irq = (dev->irq == dev2->irq) ? 1 : 0;
 			if (hpt363_shared_pin && hpt363_shared_irq) {
 				d->bootable = ON_BOARD;
-				printk("%s: onboard version of chipset, pin1=%d pin2=%d\n", d->name, pin1, pin2);
+				printk("%s: onboard version of chipset, "
+					"pin1=%d pin2=%d\n", d->name,
+					pin1, pin2);
 #if 0
-				/* I forgot why I did this once, but it fixed something. */
+				/*
+				 * This is the third undocumented detection
+				 * method and is generally required for the
+				 * ABIT-BP6 boards.
+				 */
 				pci_write_config_byte(dev2, PCI_INTERRUPT_PIN, dev->irq);
-				printk("PCI: %s: Fixing interrupt %d pin %d to ZERO \n", d->name, dev2->irq, pin2);
+				printk("PCI: %s: Fixing interrupt %d pin %d "
+					"to ZERO \n", d->name, dev2->irq, pin2);
 				pci_write_config_byte(dev2, PCI_INTERRUPT_LINE, 0);
 #endif
 			}
@@ -988,6 +1043,8 @@ void __init ide_scan_pcidev (struct pci_
 		return;	/* UM8886A/BF pair */
 	else if (IDE_PCI_DEVID_EQ(d->devid, DEVID_HPT366))
 		hpt366_device_order_fixup(dev, d);
+	else if (IDE_PCI_DEVID_EQ(d->devid, DEVID_HPT374))
+		hpt374_device_order_fixup(dev, d);
 	else if (IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20270))
 		pdc20270_device_order_fixup(dev, d);
 	else if (!IDE_PCI_DEVID_EQ(d->devid, IDE_PCI_DEVID_NULL) || (dev->class >> 8) == PCI_CLASS_STORAGE_IDE) {

_
