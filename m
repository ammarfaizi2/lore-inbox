Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315259AbSE2NYc>; Wed, 29 May 2002 09:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315260AbSE2NYb>; Wed, 29 May 2002 09:24:31 -0400
Received: from [195.63.194.11] ([195.63.194.11]:6661 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S315259AbSE2NY1>;
	Wed, 29 May 2002 09:24:27 -0400
Message-ID: <3CF4C7A5.6050804@evision-ventures.com>
Date: Wed, 29 May 2002 14:20:53 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.18 IDE 74
In-Reply-To: <Pine.LNX.4.33.0205241902001.1537-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------090502080907060407020407"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090502080907060407020407
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Wed May 29 04:35:14 CEST 2002 ide-clean-74

- Simplify the ide-pci code further.

--------------090502080907060407020407
Content-Type: text/plain;
 name="ide-clean-74.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-74.diff"

diff -urN linux-2.5.18/drivers/ide/alim15x3.c linux/drivers/ide/alim15x3.c
--- linux-2.5.18/drivers/ide/alim15x3.c	2002-05-25 03:55:28.000000000 +0200
+++ linux/drivers/ide/alim15x3.c	2002-05-29 04:29:02.000000000 +0200
@@ -685,20 +685,35 @@
 
 
 /* module data table */
-static struct ata_pci_device chipset __initdata = {
-	vendor: PCI_VENDOR_ID_AL,
-        device: PCI_DEVICE_ID_AL_M5229,
-	init_chipset: ali15x3_init_chipset,
-	ata66_check: ali15x3_ata66_check,
-	init_channel: ali15x3_init_channel,
-	init_dma: ali15x3_init_dma,
-	enablebits: { {0x00,0x00,0x00}, {0x00,0x00,0x00} },
-	bootable: ON_BOARD
+static struct ata_pci_device chipsets[] __initdata = {
+	{
+		vendor: PCI_VENDOR_ID_AL,
+	        device: PCI_DEVICE_ID_AL_M5219,
+		/* FIXME: Perhaps we should use the same init routines
+		 * as below here. */
+		enablebits: { {0x00,0x00,0x00}, {0x00,0x00,0x00} },
+		bootable: ON_BOARD,
+		flags: ATA_F_SIMPLEX
+	},
+	{
+		vendor: PCI_VENDOR_ID_AL,
+	        device: PCI_DEVICE_ID_AL_M5229,
+		init_chipset: ali15x3_init_chipset,
+		ata66_check: ali15x3_ata66_check,
+		init_channel: ali15x3_init_channel,
+		init_dma: ali15x3_init_dma,
+		enablebits: { {0x00,0x00,0x00}, {0x00,0x00,0x00} },
+		bootable: ON_BOARD
+	}
 };
 
 int __init init_ali15x3(void)
 {
-	ata_register_chipset(&chipset);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(chipsets); ++i) {
+		ata_register_chipset(&chipsets[i]);
+	}
 
         return 0;
 }
diff -urN linux-2.5.18/drivers/ide/amd74xx.c linux/drivers/ide/amd74xx.c
--- linux-2.5.18/drivers/ide/amd74xx.c	2002-05-25 03:55:28.000000000 +0200
+++ linux/drivers/ide/amd74xx.c	2002-05-29 04:16:52.000000000 +0200
@@ -443,7 +443,8 @@
 		init_channel: amd74xx_init_channel,
 		init_dma: amd74xx_init_dma,
 		enablebits: {{0x40,0x01,0x01}, {0x40,0x02,0x02}},
-		bootable: ON_BOARD
+		bootable: ON_BOARD,
+		flags: ATA_F_SIMPLEX
 	},
 	{
 		vendor:	PCI_VENDOR_ID_AMD,
diff -urN linux-2.5.18/drivers/ide/cmd64x.c linux/drivers/ide/cmd64x.c
--- linux-2.5.18/drivers/ide/cmd64x.c	2002-05-25 03:55:24.000000000 +0200
+++ linux/drivers/ide/cmd64x.c	2002-05-29 04:14:03.000000000 +0200
@@ -1099,6 +1099,7 @@
 		init_chipset: cmd64x_init_chipset,
 		init_channel: cmd64x_init_channel,
 		bootable: ON_BOARD,
+		flags: ATA_F_SIMPLEX,
 	},
 	{
 		vendor: PCI_VENDOR_ID_CMD,
diff -urN linux-2.5.18/drivers/ide/cs5530.c linux/drivers/ide/cs5530.c
--- linux-2.5.18/drivers/ide/cs5530.c	2002-05-29 02:34:39.000000000 +0200
+++ linux/drivers/ide/cs5530.c	2002-05-29 04:47:26.000000000 +0200
@@ -374,7 +374,7 @@
 	init_chipset: pci_init_cs5530,
 	init_channel: ide_init_cs5530,
 	bootable: ON_BOARD,
-	flags: ATA_F_DMA
+	flags: ATA_F_DMA | ATA_F_FDMA
 };
 
 int __init init_cs5530(void)
diff -urN linux-2.5.18/drivers/ide/ide-pci.c linux/drivers/ide/ide-pci.c
--- linux-2.5.18/drivers/ide/ide-pci.c	2002-05-28 18:22:15.000000000 +0200
+++ linux/drivers/ide/ide-pci.c	2002-05-29 04:51:47.000000000 +0200
@@ -62,85 +62,68 @@
 }
 
 /*
- * This allows off board ide-pci cards the enable a BIOS, verify interrupt
- * settings of split-mirror pci-config space, place chipset into init-mode,
- * and/or preserve an interrupt if the card is not native ide support.
- */
-static unsigned int __init trust_pci_irq(struct ata_pci_device *d, struct pci_dev *dev)
-{
-	if (d->flags & ATA_F_IRQ)
-		return dev->irq;
-
-	return 0;
-}
-
-/*
  * Match a PCI IDE port against an entry in ide_hwifs[],
  * based on io_base port if possible.
  */
 static struct ata_channel __init *lookup_channel(unsigned long io_base, int bootable, const char *name)
 {
 	int h;
-	struct ata_channel *hwif;
+	struct ata_channel *ch;
 
 	/*
-	 * Look for a hwif with matching io_base specified using
-	 * parameters to ide_setup().
+	 * Look for a channel with matching io_base default value.  If chipset is
+	 * "ide_unknown", then claim that channel slot.  Otherwise, some other
+	 * chipset has already claimed it..  :(
 	 */
 	for (h = 0; h < MAX_HWIFS; ++h) {
-		hwif = &ide_hwifs[h];
-		if (hwif->io_ports[IDE_DATA_OFFSET] == io_base) {
-			if (hwif->chipset == ide_generic)
-				return hwif; /* a perfect match */
-		}
-	}
-	/*
-	 * Look for a hwif with matching io_base default value.
-	 * If chipset is "ide_unknown", then claim that hwif slot.
-	 * Otherwise, some other chipset has already claimed it..  :(
-	 */
-	for (h = 0; h < MAX_HWIFS; ++h) {
-		hwif = &ide_hwifs[h];
-		if (hwif->io_ports[IDE_DATA_OFFSET] == io_base) {
-			if (hwif->chipset == ide_unknown)
-				return hwif; /* match */
-			printk("%s: port 0x%04lx already claimed by %s\n", name, io_base, hwif->name);
+		ch = &ide_hwifs[h];
+		if (ch->io_ports[IDE_DATA_OFFSET] == io_base) {
+			if (ch->chipset == ide_generic)
+				return ch; /* a perfect match */
+			if (ch->chipset == ide_unknown)
+				return ch; /* match */
+			printk(KERN_INFO "%s: port 0x%04lx already claimed by %s\n",
+					name, io_base, ch->name);
 			return NULL;	/* already claimed */
 		}
 	}
+
 	/*
-	 * Okay, there is no hwif matching our io_base,
-	 * so we'll just claim an unassigned slot.
+	 * Okay, there is no ch matching our io_base, so we'll just claim an
+	 * unassigned slot.
+	 *
 	 * Give preference to claiming other slots before claiming ide0/ide1,
-	 * just in case there's another interface yet-to-be-scanned
-	 * which uses ports 1f0/170 (the ide0/ide1 defaults).
+	 * just in case there's another interface yet-to-be-scanned which uses
+	 * ports 1f0/170 (the ide0/ide1 defaults).
 	 *
-	 * Unless there is a bootable card that does not use the standard
-	 * ports 1f0/170 (the ide0/ide1 defaults). The (bootable) flag.
+	 * Unless there is a bootable card that does not use the standard ports
+	 * 1f0/170 (the ide0/ide1 defaults). The (bootable) flag.
 	 */
+
 	if (bootable == ON_BOARD) {
 		for (h = 0; h < MAX_HWIFS; ++h) {
-			hwif = &ide_hwifs[h];
-			if (hwif->chipset == ide_unknown)
-				return hwif;	/* pick an unused entry */
+			ch = &ide_hwifs[h];
+			if (ch->chipset == ide_unknown)
+				return ch;	/* pick an unused entry */
 		}
 	} else {
 		for (h = 2; h < MAX_HWIFS; ++h) {
-			hwif = ide_hwifs + h;
-			if (hwif->chipset == ide_unknown)
-				return hwif;	/* pick an unused entry */
+			ch = &ide_hwifs[h];
+			if (ch->chipset == ide_unknown)
+				return ch;	/* pick an unused entry */
 		}
 	}
 	for (h = 0; h < 2; ++h) {
-		hwif = ide_hwifs + h;
-		if (hwif->chipset == ide_unknown)
-			return hwif;	/* pick an unused entry */
+		ch = &ide_hwifs[h];
+		if (ch->chipset == ide_unknown)
+			return ch;	/* pick an unused entry */
 	}
-	printk("%s: too many IDE interfaces, no room in table\n", name);
+	printk(KERN_INFO "%s: too many ATA interfaces.\n", name);
+
 	return NULL;
 }
 
-static int __init setup_pci_baseregs (struct pci_dev *dev, const char *name)
+static int __init setup_pci_baseregs(struct pci_dev *dev, const char *name)
 {
 	u8 reg;
 	u8 progif = 0;
@@ -175,110 +158,6 @@
 	return 0;
 }
 
-#ifdef CONFIG_BLK_DEV_IDEDMA
-
-/*
- * Fetch the DMA Bus-Master-I/O-Base-Address (BMIBA) from PCI space:
- */
-static unsigned long __init get_dma_base(struct ata_channel *hwif, int extra, const char *name)
-{
-	unsigned long	dma_base = 0;
-	struct pci_dev	*dev = hwif->pci_dev;
-
-	dma_base = pci_resource_start(dev, 4);
-	if (!dma_base)
-		return 0;
-
-	/* PDC20246, PDC20262, HPT343, & HPT366 */
-	if (extra) {
-		request_region(dma_base + 16, extra, name);
-		hwif->dma_extra = extra;
-	}
-
-	/* If we are on the second channel, the dma base address will be one
-	 * entry away from the primary interface.
-	 */
-	if (hwif->unit == ATA_SECONDARY)
-		dma_base += 8;
-
-	if ((dev->vendor == PCI_VENDOR_ID_AL && dev->device == PCI_DEVICE_ID_AL_M5219) ||
-			(dev->vendor == PCI_VENDOR_ID_AMD && dev->device == PCI_DEVICE_ID_AMD_VIPER_7409) ||
-			(dev->vendor == PCI_VENDOR_ID_CMD && dev->device == PCI_DEVICE_ID_CMD_643) ||
-			(dev->vendor == PCI_VENDOR_ID_SERVERWORKS && dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB5IDE)) {
-		outb(inb(dma_base + 2) & 0x60, dma_base+2);
-		if (inb(dma_base + 2) & 0x80)
-			printk(KERN_INFO "%s: simplex device: DMA forced\n", name);
-	} else {
-
-		/* If the device claims "simplex" DMA, this means only one of
-		 * the two interfaces can be trusted with DMA at any point in
-		 * time.  So we should enable DMA only on one of the two
-		 * interfaces.
-		 */
-
-		if ((inb(dma_base + 2) & 0x80)) {
-			if ((!hwif->drives[0].present && !hwif->drives[1].present) ||
-				hwif->unit == ATA_SECONDARY) {
-				printk("%s: simplex device:  DMA disabled\n", name);
-				dma_base = 0;
-			}
-		}
-	}
-
-	return dma_base;
-}
-
-/*
- * Setup DMA transfers on a channel.
- */
-static void __init setup_channel_dma(struct ata_channel *ch,
-		struct pci_dev *dev,
-		struct ata_pci_device *d,
-		int port,
-		u8 class_rev,
-		int pciirq,
-		int autodma,
-		unsigned short *pcicmd)
-{
-	unsigned long dma_base;
-
-	if (d->flags & ATA_F_NOADMA)
-		autodma = 0;
-
-	if (autodma)
-		ch->autodma = 1;
-
-	if (!((d->flags & ATA_F_DMA) || ((dev->class >> 8) == PCI_CLASS_STORAGE_IDE && (dev->class & 0x80))))
-		return;
-
-	dma_base = get_dma_base(ch, ((port == ATA_PRIMARY) && d->extra) ? d->extra : 0, dev->name);
-	if (!dma_base) {
-		printk("%s: %s Bus-Master DMA was disabled by BIOS\n",
-				ch->name, dev->name);
-
-		return;
-	}
-	if (!(*pcicmd & PCI_COMMAND_MASTER)) {
-
-		/*
-		 * Set up BM-DMA capability (PnP BIOS should have done this already)
-		 */
-		if (!(d->vendor == PCI_VENDOR_ID_CYRIX && d->device == PCI_DEVICE_ID_CYRIX_5530_IDE))
-			ch->autodma = 0;	/* default DMA off if we had to configure it here */
-		pci_write_config_word(dev, PCI_COMMAND, *pcicmd | PCI_COMMAND_MASTER);
-		if (pci_read_config_word(dev, PCI_COMMAND, pcicmd) || !(*pcicmd & PCI_COMMAND_MASTER)) {
-			printk("%s: %s error updating PCICMD\n",
-					ch->name, dev->name);
-			dma_base = 0;
-		}
-	}
-	if (d->init_dma)
-		d->init_dma(ch, dma_base);
-	else
-		ata_init_dma(ch, dma_base);
-}
-#endif
-
 /*
  * Setup a particular port on an ATA host controller.
  *
@@ -293,6 +172,7 @@
 		unsigned short *pcicmd)
 {
 	unsigned long base = 0;
+	unsigned long dma_base;
 	unsigned long ctl = 0;
 	ide_pci_enablebit_t *e = &(d->enablebits[port]);
 	struct ata_channel *ch;
@@ -387,7 +267,79 @@
 	}
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
-	setup_channel_dma(ch, dev, d, port, class_rev, pciirq, autodma, pcicmd);
+	/*
+	 * Setup DMA transfers on the channel.
+	 */
+	if (d->flags & ATA_F_NOADMA)
+		autodma = 0;
+
+	if (autodma)
+		ch->autodma = 1;
+
+	if (!((d->flags & ATA_F_DMA) || ((dev->class >> 8) == PCI_CLASS_STORAGE_IDE && (dev->class & 0x80))))
+		goto no_dma;
+	/*
+	 * Fetch the DMA Bus-Master-I/O-Base-Address (BMIBA) from PCI space:
+	 */
+	dma_base = pci_resource_start(dev, 4);
+	if (dma_base) {
+		/* PDC20246, PDC20262, HPT343, & HPT366 */
+		if ((ch->unit == ATA_PRIMARY) && d->extra) {
+			request_region(dma_base + 16, d->extra, dev->name);
+			ch->dma_extra = d->extra;
+		}
+
+		/* If we are on the second channel, the dma base address will
+		 * be one entry away from the primary interface.
+		 */
+		if (ch->unit == ATA_SECONDARY)
+			dma_base += 8;
+
+		if (d->flags & ATA_F_SIMPLEX) {
+			outb(inb(dma_base + 2) & 0x60, dma_base + 2);
+			if (inb(dma_base + 2) & 0x80)
+				printk(KERN_INFO "%s: simplex device: DMA forced\n", dev->name);
+		} else {
+			/* If the device claims "simplex" DMA, this means only
+			 * one of the two interfaces can be trusted with DMA at
+			 * any point in time.  So we should enable DMA only on
+			 * one of the two interfaces.
+			 */
+			if ((inb(dma_base + 2) & 0x80)) {
+				if ((!ch->drives[0].present && !ch->drives[1].present) ||
+						ch->unit == ATA_SECONDARY) {
+					printk(KERN_INFO "%s: simplex device:  DMA disabled\n", dev->name);
+					dma_base = 0;
+				}
+			}
+		}
+	} else {
+		printk(KERN_INFO "%s: %s Bus-Master DMA was disabled by BIOS\n",
+				ch->name, dev->name);
+
+		goto no_dma;
+	}
+	if (!(*pcicmd & PCI_COMMAND_MASTER)) {
+		/*
+		 * Set up BM-DMA capability (PnP BIOS should have done this
+		 * already).  Default to DMA off on the drive, if we had to
+		 * configure it here.  This should most propably be enabled no
+		 * all chipsets which can be expected to be used on systems
+		 * without a BIOS equivalent.
+		 */
+		if (!(d->flags | ATA_F_FDMA))
+			ch->autodma = 0;
+		pci_write_config_word(dev, PCI_COMMAND, *pcicmd | PCI_COMMAND_MASTER);
+		if (pci_read_config_word(dev, PCI_COMMAND, pcicmd) || !(*pcicmd & PCI_COMMAND_MASTER)) {
+			printk("%s: %s error updating PCICMD\n",
+					ch->name, dev->name);
+			dma_base = 0;
+		}
+	}
+	if (d->init_dma)
+		d->init_dma(ch, dma_base);
+	else
+		ata_init_dma(ch, dma_base);
 #endif
 
 no_dma:
@@ -428,7 +380,7 @@
 
 check_if_enabled:
 	if (pci_read_config_word(dev, PCI_COMMAND, &pcicmd)) {
-		printk("%s: error accessing PCI regs\n", dev->name);
+		printk(KERN_ERR "%s: error accessing PCI regs\n", dev->name);
 		return;
 	}
 	if (!(pcicmd & PCI_COMMAND_IO)) {	/* is device disabled? */
@@ -495,8 +447,12 @@
 		 */
 		if (d->init_chipset)
 			pciirq = d->init_chipset(dev);
-		else
-			pciirq = trust_pci_irq(d, dev);
+		else {
+			if (d->flags & ATA_F_IRQ)
+				pciirq = dev->irq;
+			else
+				pciirq =  0;
+		}
 	} else if (tried_config) {
 		printk(KERN_INFO "ATA: will probe IRQs later\n");
 		pciirq = 0;
@@ -520,6 +476,10 @@
 	setup_host_channel(dev, d, ATA_SECONDARY, class_rev, pciirq, autodma, &pcicmd);
 }
 
+/*
+ * Fix crossover IRQ line setups between primary and secondary channel.  Quite
+ * a common bug apparently.
+ */
 static void __init pdc20270_device_order_fixup (struct pci_dev *dev, struct ata_pci_device *d)
 {
 	struct pci_dev *dev2 = NULL;
diff -urN linux-2.5.18/drivers/ide/pcihost.h linux/drivers/ide/pcihost.h
--- linux-2.5.18/drivers/ide/pcihost.h	2002-05-25 03:55:17.000000000 +0200
+++ linux/drivers/ide/pcihost.h	2002-05-29 14:27:18.000000000 +0200
@@ -102,14 +102,16 @@
 
 /* Flags used to untangle quirk handling.
  */
-#define ATA_F_DMA	0x01
-#define ATA_F_NODMA	0x02	/* no DMA mode supported at all */
-#define ATA_F_NOADMA	0x04	/* DMA has to be enabled explicitely */
-#define ATA_F_FIXIRQ	0x08	/* fixed irq wiring */
-#define ATA_F_SER	0x10	/* serialize on first and second channel interrupts */
-#define ATA_F_IRQ	0x20	/* trust IRQ information from config */
-#define ATA_F_PHACK	0x40	/* apply PROMISE hacks */
-#define ATA_F_HPTHACK	0x80	/* apply HPT366 hacks */
+#define ATA_F_DMA	0x001
+#define ATA_F_NODMA	0x002	/* no DMA mode supported at all */
+#define ATA_F_NOADMA	0x004	/* DMA has to be enabled explicitely */
+#define ATA_F_FDMA	0x008	/* force autodma */
+#define ATA_F_FIXIRQ	0x010	/* fixed irq wiring */
+#define ATA_F_SER	0x020	/* serialize on first and second channel interrupts */
+#define ATA_F_IRQ	0x040	/* trust IRQ information from config */
+#define ATA_F_PHACK	0x080	/* apply PROMISE hacks */
+#define ATA_F_HPTHACK	0x100	/* apply HPT366 hacks */
+#define ATA_F_SIMPLEX	0x200	/* force treatment as simple device */
 
 
 struct ata_pci_device {
diff -urN linux-2.5.18/drivers/ide/serverworks.c linux/drivers/ide/serverworks.c
--- linux-2.5.18/drivers/ide/serverworks.c	2002-05-29 02:34:39.000000000 +0200
+++ linux/drivers/ide/serverworks.c	2002-05-29 04:15:33.000000000 +0200
@@ -679,7 +679,8 @@
 		init_chipset: svwks_init_chipset,
 		ata66_check: svwks_ata66_check,
 		init_channel: ide_init_svwks,
-		bootable: ON_BOARD
+		bootable: ON_BOARD,
+		flags: ATA_F_SIMPLEX
 	},
 };
 

--------------090502080907060407020407--

