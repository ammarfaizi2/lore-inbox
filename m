Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287615AbSASWDQ>; Sat, 19 Jan 2002 17:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287337AbSASWAv>; Sat, 19 Jan 2002 17:00:51 -0500
Received: from ool-182d14cd.dyn.optonline.net ([24.45.20.205]:55300 "HELO
	osinvestor.com") by vger.kernel.org with SMTP id <S287532AbSASV7D>;
	Sat, 19 Jan 2002 16:59:03 -0500
Date: Sat, 19 Jan 2002 16:59:00 -0500 (EST)
From: Rob Radez <rob@osinvestor.com>
X-X-Sender: <rob@pita.lan>
To: <linux-kernel@vger.kernel.org>
cc: Andre Hedrick <andre@linux-ide.org>
Subject: [PATCH] Andre's IDE Patch (4/7)
Message-ID: <Pine.LNX.4.33.0201191503340.14950-100000@pita.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the fourth of seven patches against 2.4.18-pre4, beginning the breakup
of Andre Hedrick's IDE patch into smaller chunks.  This patch depends on
patch 3 being applied for the definition of PCI_DEVICE_ID_AMD_VIPER_7441.

Description of patch 4:
This patch touches four files, drivers/ide/piix.c, drivers/ide/slc90e66.c,
drivers/ide/alim15x3.c, and drivers/ide/amd74xx.c.  There do not seem to be
major functional changes in here, and unfortunately, I could only compile
test these.  The PIIX patch simply changes the dma mask, SLC patch changes
some PIO mode settings and a fix for MIPS, ALIM also only changes the dma
mask, and the AMD patch adds support for the Viper 7441 chipset.

Regards,
Rob Radez

diff -ruN linux-2.4.18-pre3/drivers/ide/piix.c linux-2.4.18-pre3-ide-rr/drivers/ide/piix.c
--- linux-2.4.18-pre3/drivers/ide/piix.c	Thu Oct 25 16:53:47 2001
+++ linux-2.4.18-pre3-ide-rr/drivers/ide/piix.c	Mon Jan 14 18:29:06 2002
@@ -425,7 +425,7 @@
 		}
 		dma_func = ide_dma_off_quietly;
 		if (id->field_valid & 4) {
-			if (id->dma_ultra & 0x002F) {
+			if (id->dma_ultra & 0x003F) {
 				/* Force if Capable UltraDMA */
 				dma_func = piix_config_drive_for_dma(drive);
 				if ((id->field_valid & 2) &&
diff -ruN linux-2.4.18-pre3/drivers/ide/slc90e66.c linux-2.4.18-pre3-ide-rr/drivers/ide/slc90e66.c
--- linux-2.4.18-pre3/drivers/ide/slc90e66.c	Sun Jul 15 19:22:23 2001
+++ linux-2.4.18-pre3-ide-rr/drivers/ide/slc90e66.c	Mon Jan 14 18:29:06 2002
@@ -86,8 +86,13 @@
          * at that point bibma+0x2 et bibma+0xa are byte registers
          * to investigate:
          */
+#ifdef __mips__	/* only for mips? */
+	c0 = inb_p(bibma + 0x02);
+	c1 = inb_p(bibma + 0x0a);
+#else
 	c0 = inb_p((unsigned short)bibma + 0x02);
 	c1 = inb_p((unsigned short)bibma + 0x0a);
+#endif

 	p += sprintf(p, "                                SLC90E66 Chipset.\n");
 	p += sprintf(p, "--------------- Primary Channel ---------------- Secondary Channel -------------\n");
@@ -253,7 +258,9 @@
 		case XFER_MW_DMA_2:
 		case XFER_MW_DMA_1:
 		case XFER_SW_DMA_2:	break;
+#if 0	/* allow PIO modes */
 		default:		return -1;
+#endif
 	}

 	if (speed >= XFER_UDMA_0) {
@@ -291,6 +298,13 @@
 	byte speed		= 0;
 	byte udma_66		= eighty_ninty_three(drive);

+#if 1 /* allow PIO modes */
+	if (!HWIF(drive)->autodma) {
+		speed = XFER_PIO_0 + ide_get_best_pio_mode(drive, 255, 5, NULL);
+		(void) slc90e66_tune_chipset(drive, speed);
+		return ((int) ide_dma_off_quietly);
+	}
+#endif
 	if ((id->dma_ultra & 0x0010) && (ultra)) {
 		speed = (udma_66) ? XFER_UDMA_4 : XFER_UDMA_2;
 	} else if ((id->dma_ultra & 0x0008) && (ultra)) {
diff -ruN linux-2.4.18-pre3/drivers/ide/alim15x3.c linux-2.4.18-pre3-ide-rr/drivers/ide/alim15x3.c
--- linux-2.4.18-pre3/drivers/ide/alim15x3.c	Sun Jul 15 19:22:23 2001
+++ linux-2.4.18-pre3-ide-rr/drivers/ide/alim15x3.c	Mon Jan 14 18:29:06 2002
@@ -453,7 +453,7 @@
 		}
 		dma_func = ide_dma_off_quietly;
 		if ((id->field_valid & 4) && (m5229_revision >= 0xC2)) {
-			if (id->dma_ultra & 0x002F) {
+			if (id->dma_ultra & 0x003F) {
 				/* Force if Capable UltraDMA */
 				dma_func = config_chipset_for_dma(drive, can_ultra_dma);
 				if ((id->field_valid & 2) &&
diff -ruN linux-2.4.18-pre3/drivers/ide/amd74xx.c linux-2.4.18-pre3-ide-rr/drivers/ide/amd74xx.c
--- linux-2.4.18-pre3/drivers/ide/amd74xx.c	Mon Aug 13 17:56:19 2001
+++ linux-2.4.18-pre3-ide-rr/drivers/ide/amd74xx.c	Mon Jan 14 19:11:36 2002
@@ -75,7 +75,8 @@
 {
 	unsigned int class_rev;

-	if (dev->device == PCI_DEVICE_ID_AMD_VIPER_7411)
+	if ((dev->device == PCI_DEVICE_ID_AMD_VIPER_7411) ||
+	    (dev->device == PCI_DEVICE_ID_AMD_VIPER_7441))
 		return 0;

 	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
@@ -122,8 +123,8 @@
 	pci_read_config_byte(dev, 0x4c, &pio_timing);

 #ifdef DEBUG
-	printk("%s: UDMA 0x%02x DMAPIO 0x%02x PIO 0x%02x ",
-		drive->name, ultra_timing, dma_pio_timing, pio_timing);
+	printk("%s:%d: Speed 0x%02x UDMA 0x%02x DMAPIO 0x%02x PIO 0x%02x\n",
+		drive->name, drive->dn, speed, ultra_timing, dma_pio_timing, pio_timing);
 #endif

 	ultra_timing	&= ~0xC7;
@@ -131,22 +132,19 @@
 	pio_timing	&= ~(0x03 << drive->dn);

 #ifdef DEBUG
-	printk(":: UDMA 0x%02x DMAPIO 0x%02x PIO 0x%02x ",
-		ultra_timing, dma_pio_timing, pio_timing);
+	printk("%s: UDMA 0x%02x DMAPIO 0x%02x PIO 0x%02x\n",
+		drive->name, ultra_timing, dma_pio_timing, pio_timing);
 #endif

 	switch(speed) {
 #ifdef CONFIG_BLK_DEV_IDEDMA
+		case XFER_UDMA_7:
+		case XFER_UDMA_6:
+			speed = XFER_UDMA_5;
 		case XFER_UDMA_5:
-#undef __CAN_MODE_5
-#ifdef __CAN_MODE_5
 			ultra_timing |= 0x46;
 			dma_pio_timing |= 0x20;
 			break;
-#else
-			printk("%s: setting to mode 4, driver problems in mode 5.\n", drive->name);
-			speed = XFER_UDMA_4;
-#endif /* __CAN_MODE_5 */
 		case XFER_UDMA_4:
 			ultra_timing |= 0x45;
 			dma_pio_timing |= 0x20;
@@ -222,8 +220,8 @@
 	pci_write_config_byte(dev, 0x4c, pio_timing);

 #ifdef DEBUG
-	printk(":: UDMA 0x%02x DMAPIO 0x%02x PIO 0x%02x\n",
-		ultra_timing, dma_pio_timing, pio_timing);
+	printk("%s: UDMA 0x%02x DMAPIO 0x%02x PIO 0x%02x\n",
+		drive->name, ultra_timing, dma_pio_timing, pio_timing);
 #endif

 #ifdef CONFIG_BLK_DEV_IDEDMA
@@ -303,11 +301,15 @@
 	struct pci_dev *dev	= hwif->pci_dev;
 	struct hd_driveid *id	= drive->id;
 	byte udma_66		= eighty_ninty_three(drive);
-	byte udma_100		= (dev->device==PCI_DEVICE_ID_AMD_VIPER_7411) ? 1 : 0;
+	byte udma_100		= ((dev->device==PCI_DEVICE_ID_AMD_VIPER_7411)||
+				   (dev->device==PCI_DEVICE_ID_AMD_VIPER_7441)) ? 1 : 0;
 	byte speed		= 0x00;
 	int  rval;

-	if ((id->dma_ultra & 0x0020) && (udma_66)&& (udma_100)) {
+	if (udma_100)
+		udma_66 = eighty_ninty_three(drive);
+
+	if ((id->dma_ultra & 0x0020) && (udma_66) && (udma_100)) {
 		speed = XFER_UDMA_5;
 	} else if ((id->dma_ultra & 0x0010) && (udma_66)) {
 		speed = XFER_UDMA_4;
@@ -331,7 +333,7 @@

 	(void) amd74xx_tune_chipset(drive, speed);

-	rval = (int)(	((id->dma_ultra >> 11) & 3) ? ide_dma_on :
+	rval = (int)(	((id->dma_ultra >> 11) & 7) ? ide_dma_on :
 			((id->dma_ultra >> 8) & 7) ? ide_dma_on :
 			((id->dma_mword >> 8) & 7) ? ide_dma_on :
 						     ide_dma_off_quietly);
@@ -352,7 +354,7 @@
 		}
 		dma_func = ide_dma_off_quietly;
 		if (id->field_valid & 4) {
-			if (id->dma_ultra & 0x002F) {
+			if (id->dma_ultra & 0x003F) {
 				/* Force if Capable UltraDMA */
 				dma_func = config_chipset_for_dma(drive);
 				if ((id->field_valid & 2) &&
@@ -442,17 +444,43 @@

 unsigned int __init ata66_amd74xx (ide_hwif_t *hwif)
 {
+	struct pci_dev *dev	= hwif->pci_dev;
+	byte cable_80_pin[2]	= { 0, 0 };
+	byte ata66		= 0;
+	byte tmpbyte;
+
+	/*
+	 * Ultra66 cable detection (from Host View)
+	 * 7411, 7441, 0x42, bit0: primary, bit2: secondary 80 pin
+	 */
+	pci_read_config_byte(dev, 0x42, &tmpbyte);
+
+	/*
+	 * 0x42, bit0 is 1 => primary channel
+	 * has 80-pin (from host view)
+	 */
+	if (tmpbyte & 0x01) cable_80_pin[0] = 1;
+
+	/*
+	 * 0x42, bit2 is 1 => secondary channel
+	 * has 80-pin (from host view)
+	 */
+	if (tmpbyte & 0x04) cable_80_pin[1] = 1;
+
+	switch(dev->device) {
+		case PCI_DEVICE_ID_AMD_VIPER_7441:
+		case PCI_DEVICE_ID_AMD_VIPER_7411:
+			ata66 = (hwif->channel) ?
+				cable_80_pin[1] :
+				cable_80_pin[0];
+		default:
+			break;
+	}
 #ifdef CONFIG_AMD74XX_OVERRIDE
-	byte ata66 = 1;
+	return(1);
 #else
-	byte ata66 = 0;
+	return (unsigned int) ata66;
 #endif /* CONFIG_AMD74XX_OVERRIDE */
-
-#if 0
-	pci_read_config_byte(hwif->pci_dev, 0x48, &ata66);
-	return ((ata66 & 0x02) ? 0 : 1);
-#endif
-	return ata66;
 }

 void __init ide_init_amd74xx (ide_hwif_t *hwif)



