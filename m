Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265568AbSKTKgT>; Wed, 20 Nov 2002 05:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265675AbSKTKgT>; Wed, 20 Nov 2002 05:36:19 -0500
Received: from zmamail04.zma.compaq.com ([161.114.64.104]:19464 "EHLO
	zmamail04.zma.compaq.com") by vger.kernel.org with ESMTP
	id <S265568AbSKTKgK>; Wed, 20 Nov 2002 05:36:10 -0500
Date: Wed, 20 Nov 2002 11:43:13 +0100
From: Torben Mathiasen <torben.mathiasen@hp.com>
To: alan@xorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH-2.5.47-ac6] Updates to BIOS IDE timings code
Message-ID: <20021120104313.GA1855@tmathiasen>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-OS: Linux 2.4.20-pre11 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Alan,

Attached is a patch that addresses some of the issues we discussed previously.
The patch does the following:

	# Moves BIOS timings IDE detection into chipset drivers (by providing a
	  library function).
	# Provide the above library function that sets default values for tune
	  parameters. It also handles the special case where user has requested
	  to use BIOS IDE timings. Caller is assumed to support DMA
	  on/off probe using the dma_status register unless a dma_check funtion
	  is provided (note, the tekram driver is somewhat different from all
	  the others, and haven't been updated yet).
	# Makes BIOS IDE timings work for both IDE0 and IDE1 at the same time.

What hasn't been addresses yet, but that I'm working on is proper simplex
detection when 'biostimings' are used. However, to me it seems like the simplex
code is in the middle of being updated, right? On some chipsets we make just
dma_base isn't set on both interfaces if device claims to be simplex. On others
we force dma on both channels if simplex mode, why?

Tested with via82cxxx, serverworks and piix. 'biostimings' is only supported on
PCI chips.

More generic IDE cleanups are needed here and there, so thats probaly next.

Cheers,
Torben

--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ide_bios-2.5.47-ac6.diff"

--- linux-2.5.47-ac6/include/linux/ide.h	2002-11-20 10:56:26.000000000 +0100
+++ linux-2.5.47-ac6-ide/include/linux/ide.h	2002-11-20 10:58:29.000000000 +0100
@@ -1723,6 +1723,7 @@
 extern void export_ide_init_queue(ide_drive_t *);
 extern u8 export_probe_for_drive(ide_drive_t *);
 extern int probe_hwif_init(ide_hwif_t *);
+extern int ide_setup_tune(ide_hwif_t *, int (dma_check)(ide_hwif_t *, int));
 
 static inline void *ide_get_hwifdata (ide_hwif_t * hwif)
 {
diff -ur linux-2.5.47-ac6/drivers/ide/ide-dma.c linux-2.5.47-ac6-ide/drivers/ide/ide-dma.c
--- linux-2.5.47-ac6/drivers/ide/ide-dma.c	2002-11-20 10:56:24.000000000 +0100
+++ linux-2.5.47-ac6-ide/drivers/ide/ide-dma.c	2002-11-20 10:51:43.000000000 +0100
@@ -1190,18 +1190,10 @@
 
 	if (hwif->chipset != ide_trm290) {
 		u8 dma_stat = hwif->INB(hwif->dma_status);
-		printk(", BIOS settings: %s:%s%s, %s:%s%s",
+		printk(", BIOS settings: %s:%s, %s:%s",
 		       hwif->drives[0].name, (dma_stat & 0x20) ? "DMA" : "pio",
-		       hwif->drives[0].autotune == IDE_TUNE_BIOS ? 
-		       		" (used)" : "",
-		       hwif->drives[1].name, (dma_stat & 0x40) ? "DMA" : "pio",
-		       hwif->drives[1].autotune == IDE_TUNE_BIOS ? 
-		       		" (used)" : "");
-
-		if (hwif->drives[0].autotune == IDE_TUNE_BIOS)
-			hwif->drives[0].using_dma = (dma_stat & 0x20);
-		if (hwif->drives[1].autotune == IDE_TUNE_BIOS)
-			hwif->drives[1].using_dma = (dma_stat & 0x40);
+		       hwif->drives[1].name, (dma_stat & 0x40) ? "DMA" : "pio");
+
 	}
 	printk("\n");
 
@@ -1209,4 +1201,94 @@
 		BUG();
 }
 
+/**
+ *	ide_get_dma_from_chip	-	Read DMA on/off from chip
+ *	@hwif: interface
+ *	@drive: drive number
+ *	
+ *	Reads DMA on/off using the DMA status register. Note, not supported by
+ *	all chipsets.
+ *	
+ * 	Returns DMA status (0 == off, 1 == on)
+ */
+
+int ide_get_dma_from_chip(ide_hwif_t *hwif, int drive)
+{
+	u8 dma_stat = hwif->INB(hwif->dma_status);
+
+	switch(drive) {
+		case(0):
+			return (dma_stat & 0x20);
+		case(1): 
+			return (dma_stat & 0x40);
+		default:
+			BUG();
+	}
+
+	return 0;
+}
+
+/**
+ *	ide_setup_tune	-	Set default tune values
+ *	@hwif: interface
+ *	@dma_check: Function to determine whether DMA is on/off.
+ *	
+ *	Set tune values according to environment. Handle case where BIOS IDE
+ *	timings have been requested.
+ *	If chipset doesn't support using the DMA status register DMA query,
+ *	caller is assumed to provide a appropriate mechanism using the
+ *	dma_check argument.
+ *
+ *	Returns 0 on success. 
+ *	Returns 1 if DMA is not available.
+ */
+
+int ide_setup_tune(ide_hwif_t *hwif, int (dma_check)(ide_hwif_t *hwif, int drive))
+{
+	int drive0_dma, drive1_dma, drive0_tune, drive1_tune;
+
+	BUG_ON(!hwif);
+	
+	drive0_tune = hwif->drives[0].autotune;
+	drive1_tune = hwif->drives[1].autotune;
+	
+	if (!hwif->dma_base) {	/* No DMA available */
+		if (drive0_tune != IDE_TUNE_BIOS)
+			hwif->drives[0].autotune = IDE_TUNE_AUTO;
+		if (drive1_tune != IDE_TUNE_BIOS)
+			hwif->drives[1].autotune = IDE_TUNE_AUTO;
+		return 1;
+	}
+	
+	/* Check whether we want to use BIOS timings, and set DMA on/off
+	 * accordingly
+	 */
+	if (drive0_tune == IDE_TUNE_BIOS) {
+		if (!dma_check) 
+			drive0_dma = ide_get_dma_from_chip(hwif, 0);
+		else 
+			drive0_dma = dma_check(hwif, 0);
+
+		hwif->drives[0].using_dma = drive0_dma;
+		printk(KERN_DEBUG "%s: Using BIOS timings, DMA: %s\n",
+			hwif->drives[0].name, drive0_dma ? "On" : "Off");
+
+	} 
+
+	if (drive1_tune == IDE_TUNE_BIOS) {
+		if (!dma_check)
+			drive1_dma = ide_get_dma_from_chip(hwif, 1);
+		else
+			drive1_dma = dma_check(hwif, 1);
+
+		hwif->drives[1].using_dma = drive1_dma;
+		printk(KERN_DEBUG "%s: Using BIOS timings, DMA: %s\n",
+			hwif->drives[1].name, drive1_dma ? "On" : "Off");
+
+	} 
+
+	return 0;
+}
+
 EXPORT_SYMBOL_GPL(ide_setup_dma);
+EXPORT_SYMBOL_GPL(ide_setup_tune);
diff -ur linux-2.5.47-ac6/drivers/ide/ide.c linux-2.5.47-ac6-ide/drivers/ide/ide.c
--- linux-2.5.47-ac6/drivers/ide/ide.c	2002-11-20 10:56:24.000000000 +0100
+++ linux-2.5.47-ac6-ide/drivers/ide/ide.c	2002-11-20 10:51:43.000000000 +0100
@@ -1849,9 +1849,9 @@
 		 */
 		const char *ide_words[] = {
 			"noprobe", "serialize", "autotune", "noautotune", 
-			"reset", "dma", "ata66", "minus8", "minus9", "minus10",
+			"reset", "dma", "ata66", "biostimings", "minus9", "minus10",
 			"four", "qd65xx", "ht6560b", "cmd640_vlb", "dtc2278", 
-			"umc8672", "ali14xx", "dc4030", "biostimings", NULL };
+			"umc8672", "ali14xx", "dc4030", NULL };
 		hw = s[3] - '0';
 		hwif = &ide_hwifs[hw];
 		i = match_parm(&s[4], ide_words, vals, 3);
@@ -1870,10 +1870,6 @@
 		}
 
 		switch (i) {
-			case -19: /* "biostimings" */
-				hwif->drives[0].autotune = IDE_TUNE_BIOS;
-				hwif->drives[1].autotune = IDE_TUNE_BIOS;
-				goto done;
 #ifdef CONFIG_BLK_DEV_PDC4030
 			case -18: /* "dc4030" */
 			{
@@ -1944,8 +1940,10 @@
 #endif /* CONFIG_BLK_DEV_4DRIVES */
 			case -10: /* minus10 */
 			case -9: /* minus9 */
-			case -8: /* minus8 */
-				goto bad_option;
+			case -8: /* "biostimings" */
+				hwif->drives[0].autotune = IDE_TUNE_BIOS;
+				hwif->drives[1].autotune = IDE_TUNE_BIOS;
+				goto done;
 			case -7: /* ata66 */
 #ifdef CONFIG_BLK_DEV_IDEPCI
 				hwif->udma_four = 1;
diff -ur linux-2.5.47-ac6/drivers/ide/pci/aec62xx.c linux-2.5.47-ac6-ide/drivers/ide/pci/aec62xx.c
--- linux-2.5.47-ac6/drivers/ide/pci/aec62xx.c	2002-11-20 10:56:24.000000000 +0100
+++ linux-2.5.47-ac6-ide/drivers/ide/pci/aec62xx.c	2002-11-20 11:03:58.000000000 +0100
@@ -442,12 +442,9 @@
 
 	if (hwif->mate)
 		hwif->mate->serialized = hwif->serialized;
-
-	if (!hwif->dma_base) {
-		hwif->drives[0].autotune = 1;
-		hwif->drives[1].autotune = 1;
+	
+	if (ide_setup_tune(hwif, NULL))
 		return;
-	}
 
 	hwif->ultra_mask = 0x7f;
 	hwif->mwdma_mask = 0x07;
@@ -480,7 +477,7 @@
 	        if (!(hwif->udma_four))
 			hwif->udma_four = (ata66&(hwif->channel?0x02:0x01))?0:1;
 	}
-
+		
 	ide_setup_dma(hwif, dmabase, 8);
 }
 
diff -ur linux-2.5.47-ac6/drivers/ide/pci/alim15x3.c linux-2.5.47-ac6-ide/drivers/ide/pci/alim15x3.c
--- linux-2.5.47-ac6/drivers/ide/pci/alim15x3.c	2002-11-20 10:56:24.000000000 +0100
+++ linux-2.5.47-ac6-ide/drivers/ide/pci/alim15x3.c	2002-11-20 10:51:43.000000000 +0100
@@ -740,12 +740,9 @@
 
 	/* Don't use LBA48 on ALi devices before rev 0xC5 */
 	hwif->addressing = (m5229_revision <= 0xC4) ? 1 : 0;
-
-	if (!hwif->dma_base) {
-		hwif->drives[0].autotune = 1;
-		hwif->drives[1].autotune = 1;
+	
+	if (ide_setup_tune(hwif, NULL))
 		return;
-	}
 
 	if (m5229_revision > 0x20)
 		hwif->ultra_mask = 0x3f;
diff -ur linux-2.5.47-ac6/drivers/ide/pci/amd74xx.c linux-2.5.47-ac6-ide/drivers/ide/pci/amd74xx.c
--- linux-2.5.47-ac6/drivers/ide/pci/amd74xx.c	2002-11-20 10:56:24.000000000 +0100
+++ linux-2.5.47-ac6-ide/drivers/ide/pci/amd74xx.c	2002-11-20 11:24:15.000000000 +0100
@@ -349,11 +349,8 @@
 	hwif->tuneproc = &amd74xx_tune_drive;
 	hwif->speedproc = &amd74xx_tune_chipset;
 
-	if (!hwif->dma_base) {
-		hwif->drives[0].autotune = 1;
-		hwif->drives[1].autotune = 1;
+	if (ide_setup_tune(hwif, NULL))
 		return;
-	}
 
 	hwif->atapi_dma = 1;
 	hwif->ultra_mask = 0x3f;
diff -ur linux-2.5.47-ac6/drivers/ide/pci/cmd640.c linux-2.5.47-ac6-ide/drivers/ide/pci/cmd640.c
--- linux-2.5.47-ac6/drivers/ide/pci/cmd640.c	2002-11-20 10:56:24.000000000 +0100
+++ linux-2.5.47-ac6-ide/drivers/ide/pci/cmd640.c	2002-11-20 11:24:48.000000000 +0100
@@ -846,7 +846,8 @@
 	for (index = 0; index < (2 + (second_port_cmd640 << 1)); index++) {
 		ide_drive_t *drive = cmd_drives[index];
 #ifdef CONFIG_BLK_DEV_CMD640_ENHANCED
-		if (drive->autotune || ((index > 1) && second_port_toggled)) {
+		if (drive->autotune == IDE_TUNE_AUTO || 
+				((index > 1) && second_port_toggled)) {
 	 		/*
 	 		 * Reset timing to the slowest speed and turn off prefetch.
 			 * This way, the drive identify code has a better chance.
diff -ur linux-2.5.47-ac6/drivers/ide/pci/cmd64x.c linux-2.5.47-ac6-ide/drivers/ide/pci/cmd64x.c
--- linux-2.5.47-ac6/drivers/ide/pci/cmd64x.c	2002-11-20 10:56:24.000000000 +0100
+++ linux-2.5.47-ac6-ide/drivers/ide/pci/cmd64x.c	2002-11-20 11:24:58.000000000 +0100
@@ -703,11 +703,8 @@
 	hwif->tuneproc  = &cmd64x_tuneproc;
 	hwif->speedproc = &cmd64x_tune_chipset;
 
-	if (!hwif->dma_base) {
-		hwif->drives[0].autotune = 1;
-		hwif->drives[1].autotune = 1;
+	if (ide_setup_tune(hwif, NULL))
 		return;
-	}
 
 	hwif->atapi_dma = 1;
 
diff -ur linux-2.5.47-ac6/drivers/ide/pci/cs5530.c linux-2.5.47-ac6-ide/drivers/ide/pci/cs5530.c
--- linux-2.5.47-ac6/drivers/ide/pci/cs5530.c	2002-11-20 10:56:24.000000000 +0100
+++ linux-2.5.47-ac6-ide/drivers/ide/pci/cs5530.c	2002-11-20 10:51:44.000000000 +0100
@@ -377,17 +377,20 @@
 	if (CS5530_BAD_PIO(d0_timings)) {
 		/* PIO timings not initialized? */
 		hwif->OUTL(cs5530_pio_timings[(d0_timings>>31)&1][0], basereg+0);
-		if (!hwif->drives[0].autotune)
-			hwif->drives[0].autotune = 1;
+		if (hwif->drives[0].autotune == IDE_TUNE_DEFAULT)
+			hwif->drives[0].autotune = IDE_TUNE_AUTO;
 			/* needs autotuning later */
 	}
 	if (CS5530_BAD_PIO(hwif->INL(basereg+8))) {
 	/* PIO timings not initialized? */
 		hwif->OUTL(cs5530_pio_timings[(d0_timings>>31)&1][0], basereg+8);
-		if (!hwif->drives[1].autotune)
-			hwif->drives[1].autotune = 1;
+		if (hwif->drives[1].autotune == IDE_TUNE_DEFAULT)
+			hwif->drives[1].autotune = IDE_TUNE_AUTO;
 			/* needs autotuning later */
 	}
+	
+	if (ide_setup_tune(hwif, NULL))
+		return;
 
 	hwif->atapi_dma = 1;
 	hwif->ultra_mask = 0x07;
diff -ur linux-2.5.47-ac6/drivers/ide/pci/cy82c693.c linux-2.5.47-ac6-ide/drivers/ide/pci/cy82c693.c
--- linux-2.5.47-ac6/drivers/ide/pci/cy82c693.c	2002-11-20 10:56:24.000000000 +0100
+++ linux-2.5.47-ac6-ide/drivers/ide/pci/cy82c693.c	2002-11-20 10:51:44.000000000 +0100
@@ -393,12 +393,9 @@
 
 	hwif->chipset = ide_cy82c693;
 	hwif->tuneproc = &cy82c693_tune_drive;
-
-	if (!hwif->dma_base) {
-		hwif->drives[0].autotune = 1;
-		hwif->drives[1].autotune = 1;
+	
+	if (ide_setup_tune(hwif, NULL))
 		return;
-	}
 
 	hwif->atapi_dma = 1;
 	hwif->mwdma_mask = 0x04;
diff -ur linux-2.5.47-ac6/drivers/ide/pci/generic.c linux-2.5.47-ac6-ide/drivers/ide/pci/generic.c
--- linux-2.5.47-ac6/drivers/ide/pci/generic.c	2002-11-20 10:56:24.000000000 +0100
+++ linux-2.5.47-ac6-ide/drivers/ide/pci/generic.c	2002-11-20 11:21:12.000000000 +0100
@@ -41,8 +41,8 @@
 		default:
 			break;
 	}
-
-	if (!(hwif->dma_base))
+	
+	if (ide_setup_tune(hwif, NULL))
 		return;
 
 	hwif->atapi_dma = 1;
diff -ur linux-2.5.47-ac6/drivers/ide/pci/hpt34x.c linux-2.5.47-ac6-ide/drivers/ide/pci/hpt34x.c
--- linux-2.5.47-ac6/drivers/ide/pci/hpt34x.c	2002-11-20 10:56:24.000000000 +0100
+++ linux-2.5.47-ac6-ide/drivers/ide/pci/hpt34x.c	2002-11-20 10:51:44.000000000 +0100
@@ -293,8 +293,9 @@
 	hwif->tuneproc = &hpt34x_tune_drive;
 	hwif->speedproc = &hpt34x_tune_chipset;
 	hwif->no_dsc = 1;
-	hwif->drives[0].autotune = 1;
-	hwif->drives[1].autotune = 1;
+	
+	if (ide_setup_tune(hwif, NULL))
+		return;
 
 	pci_read_config_word(hwif->pci_dev, PCI_COMMAND, &pcicmd);
 
diff -ur linux-2.5.47-ac6/drivers/ide/pci/hpt366.c linux-2.5.47-ac6-ide/drivers/ide/pci/hpt366.c
--- linux-2.5.47-ac6/drivers/ide/pci/hpt366.c	2002-11-20 10:56:24.000000000 +0100
+++ linux-2.5.47-ac6-ide/drivers/ide/pci/hpt366.c	2002-11-20 11:21:40.000000000 +0100
@@ -1015,11 +1015,8 @@
 		hwif->busproc   = &hpt3xx_tristate;
 	}
 
-	if (!hwif->dma_base) {
-		hwif->drives[0].autotune = 1;
-		hwif->drives[1].autotune = 1;
+	if (ide_setup_tune(hwif, NULL))
 		return;
-	}
 
 	hwif->ultra_mask = 0x7f;
 	hwif->mwdma_mask = 0x07;
diff -ur linux-2.5.47-ac6/drivers/ide/pci/it8172.c linux-2.5.47-ac6-ide/drivers/ide/pci/it8172.c
--- linux-2.5.47-ac6/drivers/ide/pci/it8172.c	2002-11-20 10:56:24.000000000 +0100
+++ linux-2.5.47-ac6-ide/drivers/ide/pci/it8172.c	2002-11-20 10:51:44.000000000 +0100
@@ -266,12 +266,9 @@
 	ide_init_hwif_ports(&hwif->hw, cmdBase, ctrlBase | 2, NULL);
 	memcpy(hwif->io_ports, hwif->hw.io_ports, sizeof(hwif->io_ports));
 	hwif->noprobe = 0;
-
-	if (!hwif->dma_base) {
-		hwif->drives[0].autotune = 1;
-		hwif->drives[1].autotune = 1;
+	
+	if (ide_setup_tune(hwif, NULL)
 		return;
-	}
 
 	hwif->atapi_dma = 1;
 	hwif->ultra_mask = 0x07;
diff -ur linux-2.5.47-ac6/drivers/ide/pci/ns87415.c linux-2.5.47-ac6-ide/drivers/ide/pci/ns87415.c
--- linux-2.5.47-ac6/drivers/ide/pci/ns87415.c	2002-11-20 10:56:24.000000000 +0100
+++ linux-2.5.47-ac6-ide/drivers/ide/pci/ns87415.c	2002-11-20 10:51:44.000000000 +0100
@@ -204,7 +204,7 @@
 	else if (!hwif->irq && hwif->mate && hwif->mate->irq)
 		hwif->irq = hwif->mate->irq;	/* share IRQ with mate */
 
-	if (!hwif->dma_base)
+	if (ide_setup_tune(hwif, NULL))
 		return;
 
 	hwif->OUTB(0x60, hwif->dma_status);
diff -ur linux-2.5.47-ac6/drivers/ide/pci/nvidia.c linux-2.5.47-ac6-ide/drivers/ide/pci/nvidia.c
--- linux-2.5.47-ac6/drivers/ide/pci/nvidia.c	2002-11-20 10:56:24.000000000 +0100
+++ linux-2.5.47-ac6-ide/drivers/ide/pci/nvidia.c	2002-11-20 11:22:06.000000000 +0100
@@ -301,11 +301,8 @@
 	hwif->speedproc = &nforce_tune_chipset;
 	hwif->autodma = 0;
 
-	if (!hwif->dma_base) {
-		hwif->drives[0].autotune = 1;
-		hwif->drives[1].autotune = 1;
+	if (ide_setup_tune(hwif, NULL))
 		return;
-	}
 
 	hwif->atapi_dma = 1;
 	hwif->ultra_mask = 0x3f;
diff -ur linux-2.5.47-ac6/drivers/ide/pci/opti621.c linux-2.5.47-ac6-ide/drivers/ide/pci/opti621.c
--- linux-2.5.47-ac6/drivers/ide/pci/opti621.c	2002-11-20 10:56:24.000000000 +0100
+++ linux-2.5.47-ac6-ide/drivers/ide/pci/opti621.c	2002-11-20 10:51:44.000000000 +0100
@@ -335,8 +335,8 @@
 	hwif->drives[0].drive_data = PIO_DONT_KNOW;
 	hwif->drives[1].drive_data = PIO_DONT_KNOW;
 	hwif->tuneproc = &opti621_tune_drive;
-
-	if (!(hwif->dma_base))
+	
+	if (ide_setup_tune(hwif, NULL))
 		return;
 
 	hwif->atapi_dma = 1;
diff -ur linux-2.5.47-ac6/drivers/ide/pci/pdc202xx_new.c linux-2.5.47-ac6-ide/drivers/ide/pci/pdc202xx_new.c
--- linux-2.5.47-ac6/drivers/ide/pci/pdc202xx_new.c	2002-11-20 10:56:24.000000000 +0100
+++ linux-2.5.47-ac6-ide/drivers/ide/pci/pdc202xx_new.c	2002-11-20 10:51:44.000000000 +0100
@@ -537,11 +537,9 @@
 	hwif->quirkproc = &pdcnew_quirkproc;
 	hwif->speedproc = &pdcnew_new_tune_chipset;
 	hwif->resetproc = &pdcnew_new_reset;
-
-	if (!hwif->dma_base) {
-		hwif->drives[0].autotune = hwif->drives[1].autotune = 1;
+	
+	if (ide_setup_tune(hwif, NULL))
 		return;
-	}
 
 	hwif->ultra_mask = 0x7f;
 	hwif->mwdma_mask = 0x07;
diff -ur linux-2.5.47-ac6/drivers/ide/pci/pdc202xx_old.c linux-2.5.47-ac6-ide/drivers/ide/pci/pdc202xx_old.c
--- linux-2.5.47-ac6/drivers/ide/pci/pdc202xx_old.c	2002-11-20 10:56:24.000000000 +0100
+++ linux-2.5.47-ac6-ide/drivers/ide/pci/pdc202xx_old.c	2002-11-20 10:51:44.000000000 +0100
@@ -759,11 +759,9 @@
 	}
 
 	hwif->speedproc = &pdc202xx_tune_chipset;
-
-	if (!hwif->dma_base) {
-		hwif->drives[0].autotune = hwif->drives[1].autotune = 1;
+	
+	if (ide_setup_tune(hwif, NULL))
 		return;
-	}
 
 	hwif->ultra_mask = 0x3f;
 	hwif->mwdma_mask = 0x07;
diff -ur linux-2.5.47-ac6/drivers/ide/pci/piix.c linux-2.5.47-ac6-ide/drivers/ide/pci/piix.c
--- linux-2.5.47-ac6/drivers/ide/pci/piix.c	2002-11-20 10:56:24.000000000 +0100
+++ linux-2.5.47-ac6-ide/drivers/ide/pci/piix.c	2002-11-20 10:51:44.000000000 +0100
@@ -581,10 +581,8 @@
 	hwif->autodma = 0;
 	hwif->tuneproc = &piix_tune_drive;
 	hwif->speedproc = &piix_tune_chipset;
-	hwif->drives[0].autotune = 1;
-	hwif->drives[1].autotune = 1;
-
-	if (!hwif->dma_base)
+	
+	if (ide_setup_tune(hwif, NULL))
 		return;
 
 	hwif->atapi_dma = 1;
diff -ur linux-2.5.47-ac6/drivers/ide/pci/sc1200.c linux-2.5.47-ac6-ide/drivers/ide/pci/sc1200.c
--- linux-2.5.47-ac6/drivers/ide/pci/sc1200.c	2002-11-20 10:56:24.000000000 +0100
+++ linux-2.5.47-ac6-ide/drivers/ide/pci/sc1200.c	2002-11-20 10:51:44.000000000 +0100
@@ -526,14 +526,17 @@
 	if (hwif->mate)
 		hwif->serialized = hwif->mate->serialized = 1;
 	hwif->autodma = 0;
-	if (hwif->dma_base) {
-		hwif->ide_dma_check = &sc1200_config_dma;
-		hwif->ide_dma_end   = &sc1200_ide_dma_end;
-        	if (!noautodma)
-                	hwif->autodma = 1;
-		hwif->tuneproc = &sc1200_tuneproc;
-	}
-        hwif->atapi_dma = 1;
+	hwif->tuneproc = &sc1200_tuneproc;
+
+	if (ide_setup_tune(hwif, NULL))
+		return;
+
+	hwif->ide_dma_check = &sc1200_config_dma;
+	hwif->ide_dma_end   = &sc1200_ide_dma_end;
+        if (!noautodma)
+		hwif->autodma = 1;
+	
+	hwif->atapi_dma = 1;
         hwif->ultra_mask = 0x07;
         hwif->mwdma_mask = 0x07;
 
diff -ur linux-2.5.47-ac6/drivers/ide/pci/serverworks.c linux-2.5.47-ac6-ide/drivers/ide/pci/serverworks.c
--- linux-2.5.47-ac6/drivers/ide/pci/serverworks.c	2002-11-20 10:56:24.000000000 +0100
+++ linux-2.5.47-ac6-ide/drivers/ide/pci/serverworks.c	2002-11-20 10:51:44.000000000 +0100
@@ -704,12 +704,9 @@
 #endif /* CAN_SW_DMA */
 
 	hwif->autodma = 0;
-
-	if (!hwif->dma_base) {
-		hwif->drives[0].autotune = 1;
-		hwif->drives[1].autotune = 1;
+	
+	if (ide_setup_tune(hwif, NULL))
 		return;
-	}
 
 	hwif->ide_dma_check = &svwks_config_drive_xfer_rate;
 	if (hwif->pci_dev->device == PCI_DEVICE_ID_SERVERWORKS_OSB4IDE)
@@ -722,8 +719,8 @@
 	dma_stat = hwif->INB(hwif->dma_status);
 	hwif->drives[0].autodma = (dma_stat & 0x20);
 	hwif->drives[1].autodma = (dma_stat & 0x40);
-	hwif->drives[0].autotune = (!(dma_stat & 0x20));
-	hwif->drives[1].autotune = (!(dma_stat & 0x40));
+//	hwif->drives[0].autotune = (!(dma_stat & 0x20));
+//	hwif->drives[1].autotune = (!(dma_stat & 0x40));
 //	hwif->drives[0].autodma = hwif->autodma;
 //	hwif->drives[1].autodma = hwif->autodma;
 }
diff -ur linux-2.5.47-ac6/drivers/ide/pci/siimage.c linux-2.5.47-ac6-ide/drivers/ide/pci/siimage.c
--- linux-2.5.47-ac6/drivers/ide/pci/siimage.c	2002-11-20 10:56:24.000000000 +0100
+++ linux-2.5.47-ac6-ide/drivers/ide/pci/siimage.c	2002-11-20 11:22:47.000000000 +0100
@@ -794,11 +794,8 @@
 	hwif->reset_poll = &siimage_reset_poll;
 	hwif->pre_reset = &siimage_pre_reset;
 
-	if (!hwif->dma_base) {
-		hwif->drives[0].autotune = 1;
-		hwif->drives[1].autotune = 1;
+	if (ide_setup_tune(hwif, NULL))
 		return;
-	}
 
 	hwif->ultra_mask = 0x7f;
 	hwif->mwdma_mask = 0x07;
diff -ur linux-2.5.47-ac6/drivers/ide/pci/sis5513.c linux-2.5.47-ac6-ide/drivers/ide/pci/sis5513.c
--- linux-2.5.47-ac6/drivers/ide/pci/sis5513.c	2002-11-20 10:56:24.000000000 +0100
+++ linux-2.5.47-ac6-ide/drivers/ide/pci/sis5513.c	2002-11-20 10:51:44.000000000 +0100
@@ -982,12 +982,9 @@
 
 	hwif->tuneproc = &sis5513_tune_drive;
 	hwif->speedproc = &sis5513_tune_chipset;
-
-	if (!(hwif->dma_base)) {
-		hwif->drives[0].autotune = 1;
-		hwif->drives[1].autotune = 1;
+	
+	if (ide_setup_tune(hwif, NULL))
 		return;
-	}
 
 	hwif->atapi_dma = 1;
 	hwif->ultra_mask = 0x7f;
diff -ur linux-2.5.47-ac6/drivers/ide/pci/sl82c105.c linux-2.5.47-ac6-ide/drivers/ide/pci/sl82c105.c
--- linux-2.5.47-ac6/drivers/ide/pci/sl82c105.c	2002-11-11 04:28:08.000000000 +0100
+++ linux-2.5.47-ac6-ide/drivers/ide/pci/sl82c105.c	2002-11-20 11:20:30.000000000 +0100
@@ -238,8 +238,8 @@
 	dma_state = hwif->INB(dma_base + 2);
 	rev = sl82c105_bridge_revision(hwif->pci_dev);
 	if (rev <= 5) {
-		hwif->drives[0].autotune = 1;
-		hwif->drives[1].autotune = 1;
+		hwif->drives[0].autotune = IDE_TUNE_AUTO;
+		hwif->drives[1].autotune = IDE_TUNE_AUTO;
 		printk("    %s: Winbond 553 bridge revision %d, BM-DMA disabled\n",
 		       hwif->name, rev);
 		dma_state &= ~0x60;
@@ -260,8 +260,8 @@
 static void __init init_hwif_sl82c105(ide_hwif_t *hwif)
 {
 	hwif->tuneproc = tune_sl82c105;
-
-	if (!hwif->dma_base)
+	
+	if (ide_setup_tune(hwif, NULL))
 		return;
 
 	hwif->atapi_dma = 1;
diff -ur linux-2.5.47-ac6/drivers/ide/pci/slc90e66.c linux-2.5.47-ac6-ide/drivers/ide/pci/slc90e66.c
--- linux-2.5.47-ac6/drivers/ide/pci/slc90e66.c	2002-11-11 04:28:28.000000000 +0100
+++ linux-2.5.47-ac6-ide/drivers/ide/pci/slc90e66.c	2002-11-20 10:51:44.000000000 +0100
@@ -333,12 +333,9 @@
 	hwif->tuneproc = &slc90e66_tune_drive;
 
 	pci_read_config_byte(hwif->pci_dev, 0x47, &reg47);
-
-	if (!hwif->dma_base) {
-		hwif->drives[0].autotune = 1;
-		hwif->drives[1].autotune = 1;
+	
+	if (ide_setup_tune(hwif, NULL))
 		return;
-	}
 
 	hwif->atapi_dma = 1;
 	hwif->ultra_mask = 0x1f;
diff -ur linux-2.5.47-ac6/drivers/ide/pci/via82cxxx.c linux-2.5.47-ac6-ide/drivers/ide/pci/via82cxxx.c
--- linux-2.5.47-ac6/drivers/ide/pci/via82cxxx.c	2002-11-20 10:56:24.000000000 +0100
+++ linux-2.5.47-ac6-ide/drivers/ide/pci/via82cxxx.c	2002-11-20 10:51:44.000000000 +0100
@@ -592,11 +592,10 @@
 	for (i = 0; i < 2; i++) {
 		hwif->drives[i].io_32bit = 1;
 		hwif->drives[i].unmask = (via_config->flags & VIA_NO_UNMASK) ? 0 : 1;
-		hwif->drives[i].autotune = 1;
 		hwif->drives[i].dn = hwif->channel * 2 + i;
 	}
-
-	if (!hwif->dma_base)
+	
+	if (ide_setup_tune(hwif, NULL))
 		return;
 
 	hwif->atapi_dma = 1;
diff -ur linux-2.5.47-ac6/drivers/ide/setup-pci.c linux-2.5.47-ac6-ide/drivers/ide/setup-pci.c
--- linux-2.5.47-ac6/drivers/ide/setup-pci.c	2002-11-20 10:56:24.000000000 +0100
+++ linux-2.5.47-ac6-ide/drivers/ide/setup-pci.c	2002-11-20 10:51:18.000000000 +0100
@@ -587,7 +587,6 @@
 	int at_least_one_hwif_enabled = 0;
 	ide_hwif_t *hwif, *mate = NULL;
 	static int secondpdc = 0;
-	int drive0_tune, drive1_tune;
 	u8 tmp;
 
 	index->all = 0xf0f0;
@@ -649,26 +648,12 @@
 			ide_hwif_setup_dma(dev, d, hwif);
 bypass_legacy_dma:
 
-		drive0_tune = hwif->drives[0].autotune;
-		drive1_tune = hwif->drives[1].autotune;
-
 		if (d->init_hwif)
 			/* Call chipset-specific routine
 			 * for each enabled hwif
 			 */
 			d->init_hwif(hwif);
 
-		/*
-		 *	This is in the wrong place. The driver may
-		 *	do set up based on the autotune value and this
-		 *	will then trash it. Torben please move it and
-		 *	propogate the fixes into the drivers
-		 */		
-		if (drive0_tune == IDE_TUNE_BIOS) /* biostimings */
-			hwif->drives[0].autotune = IDE_TUNE_BIOS;
-		if (drive1_tune == IDE_TUNE_BIOS)
-			hwif->drives[1].autotune = IDE_TUNE_BIOS;
-
 		mate = hwif;
 		at_least_one_hwif_enabled = 1;
 	}

--IS0zKkzwUGydFO0o--
