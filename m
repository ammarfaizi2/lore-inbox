Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313829AbSDIJIW>; Tue, 9 Apr 2002 05:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313830AbSDIJIW>; Tue, 9 Apr 2002 05:08:22 -0400
Received: from [195.63.194.11] ([195.63.194.11]:23565 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313829AbSDIJIC>; Tue, 9 Apr 2002 05:08:02 -0400
Message-ID: <3CB2A0E1.1050903@evision-ventures.com>
Date: Tue, 09 Apr 2002 10:05:53 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.8-pre2 IDE 29b
In-Reply-To: <Pine.LNX.4.33.0204051657270.16281-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------030202090308080606050708"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030202090308080606050708
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Sun Mar 31 01:13:30 CET 2002 ide-clean-29a

- Synchronize with 2.5.8-pre2.

- Eliminate the mate member of the ata_channel structure. The information
   provided by it is already present. This patch may have undesirable
   effects on the ns87415.c and trm290.c host chip drivers, but it's worth
   for structural reasons to have it.

- Kill unused code, which was "fixing" interrupt routing from ide-pci.c Don't
   pass any "mate" between the functions there.

- Don't define SUPPORT_VLB_SYNC unconditionally in ide-taskfile.c

- Apply Vojtech Pavliks fix for piix host-chip driver crashes.

- Add linux/types.h to ide-pnp.c.

- Apply latest sis5513 host chip driver patch from by Lionel Bouton by hand.

- Apply patch by Jens Axboe for ide_dma_off which makes it to have the desired
   effect. This may result in a small conflict with the current BK tree, but
   can be just ignored.

- Apply patch by Paul Macerras for power-mac.

- Try to make the ns87415 driver a bit more reentrant.

OK patch generation threshold reached.

--------------030202090308080606050708
Content-Type: text/plain;
 name="ide-clean-29b.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-29b.diff"

diff -urN linux-2.5.8-pre2/MAINTAINERS linux/MAINTAINERS
--- linux-2.5.8-pre2/MAINTAINERS	Mon Apr  8 21:12:44 2002
+++ linux/MAINTAINERS	Mon Apr  8 16:29:16 2002
@@ -1386,6 +1386,13 @@
 M:	mingo@redhat.com
 S:	Maintained
 
+SIS 5513 IDE CONTROLLER DRIVER
+P:      Lionel Bouton
+M:      Lionel.Bouton@inet6.fr
+W:      http://inet6.dyn.dhs.org/sponsoring/sis5513/index.html
+W:      http://gyver.homeip.net/sis5513/index.html
+S:      Maintained
+
 SIS 900/7016 FAST ETHERNET DRIVER
 P:	Ollie Lho
 M:	ollie@sis.com.tw
diff -urN linux-2.5.8-pre2/drivers/ide/ali14xx.c linux/drivers/ide/ali14xx.c
--- linux-2.5.8-pre2/drivers/ide/ali14xx.c	Mon Apr  8 21:12:44 2002
+++ linux/drivers/ide/ali14xx.c	Mon Apr  8 16:29:16 2002
@@ -212,9 +212,8 @@
 	ide_hwifs[1].chipset = ide_ali14xx;
 	ide_hwifs[0].tuneproc = &ali14xx_tune_drive;
 	ide_hwifs[1].tuneproc = &ali14xx_tune_drive;
-	ide_hwifs[0].mate = &ide_hwifs[1];
-	ide_hwifs[1].mate = &ide_hwifs[0];
-	ide_hwifs[1].unit = 1;
+	ide_hwifs[0].unit = ATA_PRIMARY;
+	ide_hwifs[1].unit = ATA_SECONDARY;
 
 	/* initialize controller registers */
 	if (!initRegisters()) {
diff -urN linux-2.5.8-pre2/drivers/ide/cmd640.c linux/drivers/ide/cmd640.c
--- linux-2.5.8-pre2/drivers/ide/cmd640.c	Mon Apr  8 21:12:44 2002
+++ linux/drivers/ide/cmd640.c	Mon Apr  8 16:29:16 2002
@@ -689,7 +689,7 @@
 /*
  * Probe for a cmd640 chipset, and initialize it if found.  Called from ide.c
  */
-int __init ide_probe_for_cmd640x (void)
+int __init ide_probe_for_cmd640x(void)
 {
 #ifdef CONFIG_BLK_DEV_CMD640_ENHANCED
 	int second_port_toggled = 0;
@@ -793,9 +793,7 @@
 		cmd_hwif0->serialized = 1;
 		cmd_hwif1->serialized = 1;
 		cmd_hwif1->chipset = ide_cmd640;
-		cmd_hwif0->mate = cmd_hwif1;
-		cmd_hwif1->mate = cmd_hwif0;
-		cmd_hwif1->unit = 1;
+		cmd_hwif1->unit = ATA_SECONDARY;
 #ifdef CONFIG_BLK_DEV_CMD640_ENHANCED
 		cmd_hwif1->tuneproc = &cmd640_tune_drive;
 #endif /* CONFIG_BLK_DEV_CMD640_ENHANCED */
@@ -811,8 +809,8 @@
 		ide_drive_t *drive = cmd_drives[index];
 #ifdef CONFIG_BLK_DEV_CMD640_ENHANCED
 		if (drive->autotune || ((index > 1) && second_port_toggled)) {
-	 		/*
-	 		 * Reset timing to the slowest speed and turn off prefetch.
+			/*
+			 * Reset timing to the slowest speed and turn off prefetch.
 			 * This way, the drive identify code has a better chance.
 			 */
 			setup_counts    [index] = 4;	/* max possible */
diff -urN linux-2.5.8-pre2/drivers/ide/cs5530.c linux/drivers/ide/cs5530.c
--- linux-2.5.8-pre2/drivers/ide/cs5530.c	Mon Apr  8 21:12:44 2002
+++ linux/drivers/ide/cs5530.c	Mon Apr  8 16:29:16 2002
@@ -346,8 +346,7 @@
  */
 void __init ide_init_cs5530(struct ata_channel *hwif)
 {
-	if (hwif->mate)
-		hwif->serialized = hwif->mate->serialized = 1;
+	hwif->serialized = 1;
 	if (!hwif->dma_base) {
 		hwif->autodma = 0;
 	} else {
diff -urN linux-2.5.8-pre2/drivers/ide/dtc2278.c linux/drivers/ide/dtc2278.c
--- linux-2.5.8-pre2/drivers/ide/dtc2278.c	Mon Apr  8 21:12:44 2002
+++ linux/drivers/ide/dtc2278.c	Mon Apr  8 16:29:16 2002
@@ -124,7 +124,6 @@
 	ide_hwifs[0].drives[1].no_unmask = 1;
 	ide_hwifs[1].drives[0].no_unmask = 1;
 	ide_hwifs[1].drives[1].no_unmask = 1;
-	ide_hwifs[0].mate = &ide_hwifs[1];
-	ide_hwifs[1].mate = &ide_hwifs[0];
-	ide_hwifs[1].unit = 1;
+	ide_hwifs[0].unit = ATA_PRIMARY;
+	ide_hwifs[1].unit = ATA_SECONDARY;
 }
diff -urN linux-2.5.8-pre2/drivers/ide/hpt366.c linux/drivers/ide/hpt366.c
--- linux-2.5.8-pre2/drivers/ide/hpt366.c	Mon Apr  8 21:12:44 2002
+++ linux/drivers/ide/hpt366.c	Mon Apr  8 19:07:00 2002
@@ -1125,13 +1125,13 @@
 
 	if (n_hpt_devs < HPT366_MAX_DEVS)
 		hpt_devs[n_hpt_devs++] = dev;
-	
+
 #if defined(DISPLAY_HPT366_TIMINGS) && defined(CONFIG_PROC_FS)
 	if (!hpt366_proc) {
 		hpt366_proc = 1;
 		hpt366_display_info = &hpt366_get_info;
 	}
-#endif /* DISPLAY_HPT366_TIMINGS && CONFIG_PROC_FS */
+#endif
 
 	return dev->irq;
 }
@@ -1146,7 +1146,7 @@
 	printk("HPT366: reg5ah=0x%02x ATA-%s Cable Port%d\n",
 		ata66, (ata66 & regmask) ? "33" : "66",
 		PCI_FUNC(hwif->pci_dev->devfn));
-#endif /* DEBUG */
+#endif
 	return ((ata66 & regmask) ? 0 : 1);
 }
 
diff -urN linux-2.5.8-pre2/drivers/ide/ht6560b.c linux/drivers/ide/ht6560b.c
--- linux-2.5.8-pre2/drivers/ide/ht6560b.c	Mon Apr  8 21:12:44 2002
+++ linux/drivers/ide/ht6560b.c	Mon Apr  8 16:29:16 2002
@@ -319,10 +319,9 @@
 			ide_hwifs[1].tuneproc = &tune_ht6560b;
 			ide_hwifs[0].serialized = 1;  /* is this needed? */
 			ide_hwifs[1].serialized = 1;  /* is this needed? */
-			ide_hwifs[0].mate = &ide_hwifs[1];
-			ide_hwifs[1].mate = &ide_hwifs[0];
-			ide_hwifs[1].unit = 1;
-			
+			ide_hwifs[0].unit = ATA_PRIMARY;
+			ide_hwifs[1].unit = ATA_SECONDARY;
+
 			/*
 			 * Setting default configurations for drives
 			 */
diff -urN linux-2.5.8-pre2/drivers/ide/ide-dma.c linux/drivers/ide/ide-dma.c
--- linux-2.5.8-pre2/drivers/ide/ide-dma.c	Mon Apr  8 21:12:44 2002
+++ linux/drivers/ide/ide-dma.c	Mon Apr  8 18:11:42 2002
@@ -421,7 +421,7 @@
 	return 0;
 }
 
-static int report_drive_dmaing (ide_drive_t *drive)
+int report_drive_dmaing (ide_drive_t *drive)
 {
 	struct hd_driveid *id = drive->id;
 
@@ -562,8 +562,8 @@
 	switch (func) {
 		case ide_dma_off:
 			printk("%s: DMA disabled\n", drive->name);
-			set_high = 0;
 		case ide_dma_off_quietly:
+			set_high = 0;
 			outb(inb(dma_base+2) & ~(1<<(5+unit)), dma_base+2);
 		case ide_dma_on:
 			ide_toggle_bounce(drive, set_high);
diff -urN linux-2.5.8-pre2/drivers/ide/ide-pci.c linux/drivers/ide/ide-pci.c
--- linux-2.5.8-pre2/drivers/ide/ide-pci.c	Mon Apr  8 21:12:44 2002
+++ linux/drivers/ide/ide-pci.c	Mon Apr  8 21:02:52 2002
@@ -182,7 +182,7 @@
 	unsigned short		device;
 	unsigned int		(*init_chipset)(struct pci_dev *dev);
 	unsigned int		(*ata66_check)(struct ata_channel *hwif);
-	void			(*init_hwif)(struct ata_channel *hwif);
+	void			(*init_channel)(struct ata_channel *hwif);
 	void			(*dma_init)(struct ata_channel *hwif, unsigned long dmabase);
 	ide_pci_enablebit_t	enablebits[2];
 	unsigned int		bootable;
@@ -436,24 +436,21 @@
 	unsigned long	dma_base = 0;
 	struct pci_dev	*dev = hwif->pci_dev;
 
-	/*
-	 * If we are on the second channel, the dma base address will be one
-	 * entry away from the primary interface.
-	 */
-
-	if (hwif->mate && hwif->mate->dma_base)
-		dma_base = hwif->mate->dma_base - (hwif->unit ? 0 : 8);
-	else
-		dma_base = pci_resource_start(dev, 4);
-
+	dma_base = pci_resource_start(dev, 4);
 	if (!dma_base)
 		return 0;
 
-	if (extra) /* PDC20246, PDC20262, HPT343, & HPT366 */
+	/* PDC20246, PDC20262, HPT343, & HPT366 */
+	if (extra) {
 		request_region(dma_base + 16, extra, name);
+		hwif->dma_extra = extra;
+	}
 
-	dma_base += hwif->unit ? 8 : 0;
-	hwif->dma_extra = extra;
+	/* If we are on the second channel, the dma base address will be one
+	 * entry away from the primary interface.
+	 */
+	if (hwif->unit == ATA_SECONDARY)
+		dma_base += 8;
 
 	if ((dev->vendor == PCI_VENDOR_ID_AL && dev->device == PCI_DEVICE_ID_AL_M5219) ||
 			(dev->vendor == PCI_VENDOR_ID_AMD && dev->device == PCI_DEVICE_ID_AMD_VIPER_7409) ||
@@ -463,8 +460,7 @@
 			printk(KERN_INFO "%s: simplex device: DMA forced\n", name);
 	} else {
 
-		/*
-		 * If the device claims "simplex" DMA, this means only one of
+		/* If the device claims "simplex" DMA, this means only one of
 		 * the two interfaces can be trusted with DMA at any point in
 		 * time.  So we should enable DMA only on one of the two
 		 * interfaces.
@@ -472,7 +468,7 @@
 
 		if ((inb(dma_base + 2) & 0x80)) {
 			if ((!hwif->drives[0].present && !hwif->drives[1].present) ||
-					(hwif->mate && hwif->mate->dma_base)) {
+				hwif->unit == ATA_SECONDARY) {
 				printk("%s: simplex device:  DMA disabled\n", name);
 				dma_base = 0;
 			}
@@ -489,8 +485,9 @@
 		ide_pci_device_t *d,
 		int port,
 		u8 class_rev,
-		int pciirq, struct ata_channel **mate,
-		int autodma, unsigned short *pcicmd)
+		int pciirq,
+		int autodma,
+		unsigned short *pcicmd)
 {
 	unsigned long dma_base;
 
@@ -503,8 +500,13 @@
 	if (!((d->flags & ATA_F_DMA) || ((dev->class >> 8) == PCI_CLASS_STORAGE_IDE && (dev->class & 0x80))))
 		return;
 
-	dma_base = get_dma_base(hwif, (!*mate && d->extra) ? d->extra : 0, dev->name);
-	if (dma_base && !(*pcicmd & PCI_COMMAND_MASTER)) {
+	dma_base = get_dma_base(hwif, ((port == ATA_PRIMARY) && d->extra) ? d->extra : 0, dev->name);
+	if (!dma_base) {
+		printk("%s: %s Bus-Master DMA was disabled by BIOS\n", hwif->name, dev->name);
+
+		return;
+	}
+	if (!(*pcicmd & PCI_COMMAND_MASTER)) {
 
 		/*
 		 * Set up BM-DMA capability (PnP BIOS should have done this already)
@@ -517,13 +519,10 @@
 			dma_base = 0;
 		}
 	}
-	if (dma_base) {
-		if (d->dma_init)
-			d->dma_init(hwif, dma_base);
-		else
-			ide_setup_dma(hwif, dma_base, 8);
-	} else
-		printk("%s: %s Bus-Master DMA was disabled by BIOS\n", hwif->name, dev->name);
+	if (d->dma_init)
+		d->dma_init(hwif, dma_base);
+	else
+		ide_setup_dma(hwif, dma_base, 8);
 }
 #endif
 
@@ -537,17 +536,16 @@
 		int port,
 		u8 class_rev,
 		int pciirq,
-		struct ata_channel **mate,
 		int autodma,
 		unsigned short *pcicmd)
 {
 	unsigned long base = 0;
 	unsigned long ctl = 0;
 	ide_pci_enablebit_t *e = &(d->enablebits[port]);
-	struct ata_channel *hwif;
+	struct ata_channel *ch;
 
 	u8 tmp;
-	if (port == 1) {
+	if (port == ATA_SECONDARY) {
 
 		/* If this is a Promise FakeRaid controller, the 2nd controller
 		 * will be marked as disabled while it is actually there and
@@ -569,7 +567,7 @@
 
 	/* Nothing to be done for the second port.
 	 */
-	if (port == 1) {
+	if (port == ATA_SECONDARY) {
 		if ((d->flags & ATA_F_HPTHACK) && (class_rev < 0x03))
 			return 0;
 	}
@@ -599,57 +597,50 @@
 	if (!base)
 		base = port ? 0x170 : 0x1f0;
 
-	if ((hwif = lookup_hwif(base, d->bootable, dev->name)) == NULL)
+	if ((ch = lookup_hwif(base, d->bootable, dev->name)) == NULL)
 		return -ENOMEM;	/* no room in ide_hwifs[] */
 
-	if (hwif->io_ports[IDE_DATA_OFFSET] != base) {
-		ide_init_hwif_ports(&hwif->hw, base, (ctl | 2), NULL);
-		memcpy(hwif->io_ports, hwif->hw.io_ports, sizeof(hwif->io_ports));
-		hwif->noprobe = !hwif->io_ports[IDE_DATA_OFFSET];
-	}
-
-	hwif->chipset = ide_pci;
-	hwif->pci_dev = dev;
-	hwif->unit = port;
-	if (!hwif->irq)
-		hwif->irq = pciirq;
-
-	/* Setup the mate interface if we have two channels.
-	 */
-	if (*mate) {
-		hwif->mate = *mate;
-		(*mate)->mate = hwif;
-		if (d->flags & ATA_F_SER) {
-			hwif->serialized = 1;
-			(*mate)->serialized = 1;
-		}
-	}
+	if (ch->io_ports[IDE_DATA_OFFSET] != base) {
+		ide_init_hwif_ports(&ch->hw, base, (ctl | 2), NULL);
+		memcpy(ch->io_ports, ch->hw.io_ports, sizeof(ch->io_ports));
+		ch->noprobe = !ch->io_ports[IDE_DATA_OFFSET];
+	}
+
+	ch->chipset = ide_pci;
+	ch->pci_dev = dev;
+	ch->unit = port;
+	if (!ch->irq)
+		ch->irq = pciirq;
+
+	/* Serialize the interfaces if requested by configuration information.
+	 */
+	if (d->flags & ATA_F_SER)
+	    ch->serialized = 1;
 
 	/* Cross wired IRQ lines on UMC chips and no DMA transfers.*/
 	if (d->flags & ATA_F_FIXIRQ) {
-		hwif->irq = port ? 15 : 14;
+		ch->irq = port ? 15 : 14;
 		goto no_dma;
 	}
 	if (d->flags & ATA_F_NODMA)
 		goto no_dma;
 
 	/* Check whatever this interface is UDMA4 mode capable. */
-	if (hwif->udma_four) {
+	if (ch->udma_four) {
 		printk("%s: warning: ATA-66/100 forced bit set!\n", dev->name);
 	} else {
 		if (d->ata66_check)
-			hwif->udma_four = d->ata66_check(hwif);
+			ch->udma_four = d->ata66_check(ch);
 	}
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
-	setup_channel_dma(hwif, dev, d, port, class_rev, pciirq,  mate, autodma, pcicmd);
+	setup_channel_dma(ch, dev, d, port, class_rev, pciirq, autodma, pcicmd);
 #endif
 
 no_dma:
-	if (d->init_hwif)  /* Call chipset-specific routine for each enabled hwif */
-		d->init_hwif(hwif);
-
-	*mate = hwif;
+	/* Call chipset-specific routine for each enabled channel. */
+	if (d->init_channel)
+		d->init_channel(ch);
 
 	return 0;
 }
@@ -671,7 +662,6 @@
 	int pciirq = 0;
 	unsigned short pcicmd = 0;
 	unsigned short tried_config = 0;
-	struct ata_channel *mate = NULL;
 	unsigned int class_rev;
 
 #ifdef CONFIG_IDEDMA_AUTO
@@ -679,9 +669,9 @@
 		autodma = 1;
 #endif
 
-	if (d->init_hwif == IDE_NO_DRIVER) {
+	if (d->init_channel == IDE_NO_DRIVER) {
 		printk(KERN_WARNING "%s: detected chipset, but driver not compiled in!\n", dev->name);
-		d->init_hwif = NULL;
+		d->init_channel = NULL;
 	}
 
 	if (pci_enable_device(dev)) {
@@ -779,8 +769,8 @@
 	/*
 	 * Set up IDE chanells. First the primary, then the secondary.
 	 */
-	setup_host_channel(dev, d, 0, class_rev, pciirq, &mate, autodma, &pcicmd);
-	setup_host_channel(dev, d, 1, class_rev, pciirq, &mate, autodma, &pcicmd);
+	setup_host_channel(dev, d, ATA_PRIMARY, class_rev, pciirq, autodma, &pcicmd);
+	setup_host_channel(dev, d, ATA_SECONDARY, class_rev, pciirq, autodma, &pcicmd);
 }
 
 static void __init pdc20270_device_order_fixup (struct pci_dev *dev, ide_pci_device_t *d)
@@ -856,12 +846,6 @@
 			if (hpt363_shared_pin && hpt363_shared_irq) {
 				d->bootable = ON_BOARD;
 				printk("%s: onboard version of chipset, pin1=%d pin2=%d\n", dev->name, pin1, pin2);
-#if 0
-				/* I forgot why I did this once, but it fixed something. */
-				pci_write_config_byte(dev2, PCI_INTERRUPT_PIN, dev->irq);
-				printk("PCI: %s: Fixing interrupt %d pin %d to ZERO \n", d->name, dev2->irq, pin2);
-				pci_write_config_byte(dev2, PCI_INTERRUPT_LINE, 0);
-#endif
 			}
 			break;
 		}
@@ -894,7 +878,7 @@
 	while (d->vendor && !(d->vendor == vendor && d->device == device))
 		++d;
 
-	if (d->init_hwif == ATA_PCI_IGNORE)
+	if (d->init_channel == ATA_PCI_IGNORE)
 		printk("%s: has been ignored by PCI bus scan\n", dev->name);
 	else if ((d->vendor == PCI_VENDOR_ID_OPTI && d->device == PCI_DEVICE_ID_OPTI_82C558) && !(PCI_FUNC(dev->devfn) & 1))
 		return;
diff -urN linux-2.5.8-pre2/drivers/ide/ide-pmac.c linux/drivers/ide/ide-pmac.c
--- linux-2.5.8-pre2/drivers/ide/ide-pmac.c	Mon Apr  8 21:12:44 2002
+++ linux/drivers/ide/ide-pmac.c	Mon Apr  8 18:11:42 2002
@@ -15,6 +15,16 @@
  * Some code taken from drivers/ide/ide-dma.c:
  *
  *  Copyright (c) 1995-1998  Mark Lord
+ *  
+ * TODO:
+ * 
+ *  - Find a way to duplicate less code with ide-dma and use the
+ *    dma fileds in the hwif structure instead of our own
+ *  - Fix check_disk_change() call
+ *  - Make module-able (includes setting ppc_md. hooks from within
+ *    this file and not from arch code, and handling module deps with
+ *    mediabay (by having both modules do dynamic lookup of each other
+ *    symbols or by storing hooks at arch level).
  *
  */
 #include <linux/config.h>
@@ -24,26 +34,30 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/ide.h>
+#include <linux/pci.h>
 
 #include <asm/prom.h>
 #include <asm/io.h>
 #include <asm/dbdma.h>
 #include <asm/ide.h>
 #include <asm/mediabay.h>
-#include <asm/feature.h>
+#include <asm/pci-bridge.h>
+#include <asm/machdep.h>
+#include <asm/pmac_feature.h>
+#include <asm/sections.h>
+#include <asm/irq.h>
 #ifdef CONFIG_PMAC_PBOOK
 #include <linux/adb.h>
 #include <linux/pmu.h>
-#include <asm/irq.h>
 #endif
 #include "ata-timing.h"
 
 extern char *ide_dmafunc_verbose(ide_dma_action_t dmafunc);
+extern spinlock_t ide_lock;
 
 #undef IDE_PMAC_DEBUG
 
-#define IDE_SYSCLK_NS		30
-#define IDE_SYSCLK_ULTRA_PS	0x1d4c /* (15 * 1000 / 2)*/
+#define DMA_WAIT_TIMEOUT	500
 
 struct pmac_ide_hwif {
 	ide_ioreg_t			regbase;
@@ -53,11 +67,20 @@
 	struct device_node*		node;
 	u32				timings[2];
 #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC
+	/* Those fields are duplicating what is in hwif. We currently
+	 * can't use the hwif ones because of some assumptions that are
+	 * beeing done by the generic code about the kind of dma controller
+	 * and format of the dma table. This will have to be fixed though.
+	 */
 	volatile struct dbdma_regs*	dma_regs;
-	struct dbdma_cmd*		dma_table;
-#endif
+	struct dbdma_cmd*		dma_table_cpu;
+	dma_addr_t			dma_table_dma;
+	struct scatterlist*		sg_table;
+	int				sg_nents;
+	int				sg_dma_direction;
+#endif /* CONFIG_BLK_DEV_IDEDMA_PMAC */
 	
-} pmac_ide[MAX_HWIFS];
+} pmac_ide[MAX_HWIFS] __pmacdata;
 
 static int pmac_ide_count;
 
@@ -65,36 +88,160 @@
 	controller_ohare,	/* OHare based */
 	controller_heathrow,	/* Heathrow/Paddington */
 	controller_kl_ata3,	/* KeyLargo ATA-3 */
-	controller_kl_ata4	/* KeyLargo ATA-4 */
+	controller_kl_ata4,	/* KeyLargo ATA-4 */
+	controller_kl_ata4_80	/* KeyLargo ATA-4 with 80 conductor cable */
 };
 
+/*
+ * Extra registers, both 32-bit little-endian
+ */
+#define IDE_TIMING_CONFIG	0x200
+#define IDE_INTERRUPT		0x300
+
+/*
+ * Timing configuration register definitions
+ */
+
+/* Number of IDE_SYSCLK_NS ticks, argument is in nanoseconds */
+#define SYSCLK_TICKS(t)		(((t) + IDE_SYSCLK_NS - 1) / IDE_SYSCLK_NS)
+#define SYSCLK_TICKS_66(t)	(((t) + IDE_SYSCLK_66_NS - 1) / IDE_SYSCLK_66_NS)
+#define IDE_SYSCLK_NS		30	/* 33Mhz cell */
+#define IDE_SYSCLK_66_NS	15	/* 66Mhz cell */
+
+/* 66Mhz cell, found in KeyLargo. Can do ultra mode 0 to 2 on
+ * 40 connector cable and to 4 on 80 connector one.
+ * Clock unit is 15ns (66Mhz)
+ * 
+ * 3 Values can be programmed:
+ *  - Write data setup, which appears to match the cycle time. They
+ *    also call it DIOW setup.
+ *  - Ready to pause time (from spec)
+ *  - Address setup. That one is weird. I don't see where exactly
+ *    it fits in UDMA cycles, I got it's name from an obscure piece
+ *    of commented out code in Darwin. They leave it to 0, we do as
+ *    well, despite a comment that would lead to think it has a
+ *    min value of 45ns.
+ * Apple also add 60ns to the write data setup (or cycle time ?) on
+ * reads. I can't explain that, I tried it and it broke everything
+ * here.
+ */
+#define TR_66_UDMA_MASK			0xfff00000
+#define TR_66_UDMA_EN			0x00100000 /* Enable Ultra mode for DMA */
+#define TR_66_UDMA_ADDRSETUP_MASK	0xe0000000 /* Address setup */
+#define TR_66_UDMA_ADDRSETUP_SHIFT	29
+#define TR_66_UDMA_RDY2PAUS_MASK	0x1e000000 /* Ready 2 pause time */
+#define TR_66_UDMA_RDY2PAUS_SHIFT	25
+#define TR_66_UDMA_WRDATASETUP_MASK	0x01e00000 /* Write data setup time */
+#define TR_66_UDMA_WRDATASETUP_SHIFT	21
+#define TR_66_MDMA_MASK			0x000ffc00
+#define TR_66_MDMA_RECOVERY_MASK	0x000f8000
+#define TR_66_MDMA_RECOVERY_SHIFT	15
+#define TR_66_MDMA_ACCESS_MASK		0x00007c00
+#define TR_66_MDMA_ACCESS_SHIFT		10
+#define TR_66_PIO_MASK			0x000003ff
+#define TR_66_PIO_RECOVERY_MASK		0x000003e0
+#define TR_66_PIO_RECOVERY_SHIFT	5
+#define TR_66_PIO_ACCESS_MASK		0x0000001f
+#define TR_66_PIO_ACCESS_SHIFT		0
+
+/* 33Mhz cell, found in OHare, Heathrow (& Paddington) and KeyLargo
+ * Can do pio & mdma modes, clock unit is 30ns (33Mhz)
+ * 
+ * The access time and recovery time can be programmed. Some older
+ * Darwin code base limit OHare to 150ns cycle time. I decided to do
+ * the same here fore safety against broken old hardware ;)
+ * The HalfTick bit, when set, adds half a clock (15ns) to the access
+ * time and removes one from recovery. It's not supported on KeyLargo
+ * implementation afaik. The E bit appears to be set for PIO mode 0 and
+ * is used to reach long timings used in this mode.
+ */
+#define TR_33_MDMA_MASK			0x003ff800
+#define TR_33_MDMA_RECOVERY_MASK	0x001f0000
+#define TR_33_MDMA_RECOVERY_SHIFT	16
+#define TR_33_MDMA_ACCESS_MASK		0x0000f800
+#define TR_33_MDMA_ACCESS_SHIFT		11
+#define TR_33_MDMA_HALFTICK		0x00200000
+#define TR_33_PIO_MASK			0x000007ff
+#define TR_33_PIO_E			0x00000400
+#define TR_33_PIO_RECOVERY_MASK		0x000003e0
+#define TR_33_PIO_RECOVERY_SHIFT	5
+#define TR_33_PIO_ACCESS_MASK		0x0000001f
+#define TR_33_PIO_ACCESS_SHIFT		0
+
+/*
+ * Interrupt register definitions
+ */
+#define IDE_INTR_DMA			0x80000000
+#define IDE_INTR_DEVICE			0x40000000
 
 #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC
 
 # define BAD_DMA_DRIVE		0
 # define GOOD_DMA_DRIVE		1
 
-typedef struct {
+/* Rounded Multiword DMA timings
+ * 
+ * I gave up finding a generic formula for all controller
+ * types and instead, built tables based on timing values
+ * used by Apple in Darwin's implementation.
+ */
+struct mdma_timings_t {
 	int	accessTime;
+	int	recoveryTime;
 	int	cycleTime;
-} pmac_ide_timing;
+};
 
-/* Multiword DMA timings */
-static pmac_ide_timing mdma_timings[] =
+struct mdma_timings_t mdma_timings_33[] __pmacdata =
 {
-    { 215,    480 },	/* Mode 0 */
-    {  80,    150 },	/*      1 */
-    {  70,    120 }	/*      2 */
+    { 240, 240, 480 },
+    { 180, 180, 360 },
+    { 135, 135, 270 },
+    { 120, 120, 240 },
+    { 105, 105, 210 },
+    {  90,  90, 180 },
+    {  75,  75, 150 },
+    {  75,  45, 120 },
+    {   0,   0,   0 }
 };
 
-/* Ultra DMA timings (for use when I know how to calculate them */
-static pmac_ide_timing udma_timings[] =
+struct mdma_timings_t mdma_timings_33k[] __pmacdata =
 {
-    {   0,    114 },	/* Mode 0 */
-    {   0,     75 },	/*      1 */
-    {   0,     55 },	/*      2 */
-    {   100,   45 },	/*      3 */
-    {   100,   25 }	/*      4 */
+    { 240, 240, 480 },
+    { 180, 180, 360 },
+    { 150, 150, 300 },
+    { 120, 120, 240 },
+    {  90, 120, 210 },
+    {  90,  90, 180 },
+    {  90,  60, 150 },
+    {  90,  30, 120 },
+    {   0,   0,   0 }
+};
+
+struct mdma_timings_t mdma_timings_66[] __pmacdata =
+{
+    { 240, 240, 480 },
+    { 180, 180, 360 },
+    { 135, 135, 270 },
+    { 120, 120, 240 },
+    { 105, 105, 210 },
+    {  90,  90, 180 },
+    {  90,  75, 165 },
+    {  75,  45, 120 },
+    {   0,   0,   0 }
+};
+
+/* Ultra DMA timings (rounded) */
+struct {
+	int	addrSetup; /* ??? */
+	int	rdy2pause;
+	int	wrDataSetup;
+} udma_timings[] __pmacdata =
+{
+    {   0, 180,  120 },	/* Mode 0 */
+    {   0, 150,  90 },	/*      1 */
+    {   0, 120,  60 },	/*      2 */
+    {   0, 90,   45 },	/*      3 */
+    {   0, 90,   30 }	/*      4 */
 };
 
 /* allow up to 256 DBDMA commands per xfer */
@@ -124,7 +271,7 @@
 };
 #endif /* CONFIG_PMAC_PBOOK */
 
-static int
+static int __pmac
 pmac_ide_find(ide_drive_t *drive)
 {
 	struct ata_channel *hwif = drive->channel;
@@ -143,7 +290,8 @@
  * N.B. this can't be an initfunc, because the media-bay task can
  * call ide_[un]register at any time.
  */
-void pmac_ide_init_hwif_ports(hw_regs_t *hw,
+void __pmac
+pmac_ide_init_hwif_ports(hw_regs_t *hw,
 			      ide_ioreg_t data_port, ide_ioreg_t ctrl_port,
 			      int *irq)
 {
@@ -174,7 +322,7 @@
 	ide_hwifs[ix].tuneproc = pmac_ide_tuneproc;
 	ide_hwifs[ix].selectproc = pmac_ide_selectproc;
 	ide_hwifs[ix].speedproc = &pmac_ide_tune_chipset;
-	if (pmac_ide[ix].dma_regs && pmac_ide[ix].dma_table) {
+	if (pmac_ide[ix].dma_regs && pmac_ide[ix].dma_table_cpu) {
 		ide_hwifs[ix].dmaproc = &pmac_ide_dmaproc;
 #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC_AUTO
 		if (!noautodma)
@@ -201,24 +349,33 @@
 /* Setup timings for the selected drive (master/slave). I still need to verify if this
  * is enough, I beleive selectproc will be called whenever an IDE command is started,
  * but... */
-static void
+static void __pmac
 pmac_ide_selectproc(ide_drive_t *drive)
 {
 	int i = pmac_ide_find(drive);
 	if (i < 0)
 		return;
-			
-	if (drive->select.all & 0x10)
-		out_le32((unsigned *)(IDE_DATA_REG + 0x200 + _IO_BASE), pmac_ide[i].timings[1]);
+
+	if (drive->select.b.unit & 0x01)
+		out_le32((unsigned *)(IDE_DATA_REG + IDE_TIMING_CONFIG + _IO_BASE),
+			pmac_ide[i].timings[1]);
 	else
-		out_le32((unsigned *)(IDE_DATA_REG + 0x200 + _IO_BASE), pmac_ide[i].timings[0]);
+		out_le32((unsigned *)(IDE_DATA_REG + IDE_TIMING_CONFIG + _IO_BASE),
+			pmac_ide[i].timings[0]);
+	(void)in_le32((unsigned *)(IDE_DATA_REG + IDE_TIMING_CONFIG + _IO_BASE));
 }
 
-/* Number of IDE_SYSCLK_NS ticks, argument is in nanoseconds */
-#define SYSCLK_TICKS(t)		(((t) + IDE_SYSCLK_NS - 1) / IDE_SYSCLK_NS)
-#define SYSCLK_TICKS_UDMA(t)	(((t) + IDE_SYSCLK_ULTRA_PS - 1) / IDE_SYSCLK_ULTRA_PS)
 
-static __inline__ int
+/* Note: We don't use the generic routine here because for some
+ * yet unexplained reasons, it cause some media-bay CD-ROMs to
+ * lockup the bus. Strangely, this new version of the code is
+ * almost identical to the generic one and works, I've not yet
+ * managed to figure out what bit is causing the lockup in the
+ * generic code, possibly a timing issue...
+ * 
+ * --BenH
+ */
+static int __pmac
 wait_for_ready(ide_drive_t *drive)
 {
 	/* Timeout bumped for some powerbooks */
@@ -244,57 +401,80 @@
 	return 0;
 }
 
-/* Note: We don't use the generic routine here because some of Apple's
- * controller seem to be very sensitive about how things are done.
- * We should probably set the NIEN bit, but that's an example of thing
- * that can cause the controller to hang under some circumstances when
- * done on the media-bay CD-ROM during boot. We do get occasional
- * spurrious interrupts because of that.
- * --BenH
- */
-static int
+static int __pmac
 pmac_ide_do_setfeature(ide_drive_t *drive, byte command)
 {
-	unsigned long flags;
 	int result = 1;
-
-	save_flags(flags);
-	cli();
+	unsigned long flags;
+	struct ata_channel *hwif = HWIF(drive);
+	
+	disable_irq(hwif->irq);	/* disable_irq_nosync ?? */
 	udelay(1);
 	SELECT_DRIVE(drive->channel, drive);
 	SELECT_MASK(drive->channel, drive, 0);
 	udelay(1);
+	(void)GET_STAT(); /* Get rid of pending error state */
 	if(wait_for_ready(drive)) {
 		printk(KERN_ERR "pmac_ide_do_setfeature disk not ready before SET_FEATURE!\n");
 		goto out;
 	}
-	OUT_BYTE(SETFEATURES_XFER, IDE_FEATURE_REG);
+	udelay(10);
+	OUT_BYTE(drive->ctl | 2, IDE_CONTROL_REG);
 	OUT_BYTE(command, IDE_NSECTOR_REG);
+	OUT_BYTE(SETFEATURES_XFER, IDE_FEATURE_REG);
 	OUT_BYTE(WIN_SETFEATURES, IDE_COMMAND_REG);
 	udelay(1);
+	__save_flags(flags);	/* local CPU only */
+	ide__sti();		/* local CPU only -- for jiffies */
 	result = wait_for_ready(drive);
+	__restore_flags(flags); /* local CPU only */
+	OUT_BYTE(drive->ctl, IDE_CONTROL_REG);
 	if (result)
 		printk(KERN_ERR "pmac_ide_do_setfeature disk not ready after SET_FEATURE !\n");
 out:
-	restore_flags(flags);
+	SELECT_MASK(HWIF(drive), drive, 0);
+	if (result == 0) {
+		drive->id->dma_ultra &= ~0xFF00;
+		drive->id->dma_mword &= ~0x0F00;
+		drive->id->dma_1word &= ~0x0F00;
+		switch(command) {
+			case XFER_UDMA_7:   drive->id->dma_ultra |= 0x8080; break;
+			case XFER_UDMA_6:   drive->id->dma_ultra |= 0x4040; break;
+			case XFER_UDMA_5:   drive->id->dma_ultra |= 0x2020; break;
+			case XFER_UDMA_4:   drive->id->dma_ultra |= 0x1010; break;
+			case XFER_UDMA_3:   drive->id->dma_ultra |= 0x0808; break;
+			case XFER_UDMA_2:   drive->id->dma_ultra |= 0x0404; break;
+			case XFER_UDMA_1:   drive->id->dma_ultra |= 0x0202; break;
+			case XFER_UDMA_0:   drive->id->dma_ultra |= 0x0101; break;
+			case XFER_MW_DMA_2: drive->id->dma_mword |= 0x0404; break;
+			case XFER_MW_DMA_1: drive->id->dma_mword |= 0x0202; break;
+			case XFER_MW_DMA_0: drive->id->dma_mword |= 0x0101; break;
+			case XFER_SW_DMA_2: drive->id->dma_1word |= 0x0404; break;
+			case XFER_SW_DMA_1: drive->id->dma_1word |= 0x0202; break;
+			case XFER_SW_DMA_0: drive->id->dma_1word |= 0x0101; break;
+			default: break;
+		}
+	}
+	enable_irq(hwif->irq);
 
 	return result;
 }
 
 /* Calculate PIO timings */
-static void
+static void __pmac
 pmac_ide_tuneproc(ide_drive_t *drive, byte pio)
 {
 	struct ata_timing *t;
 	int i;
 	u32 *timings;
-	int accessTicks, recTicks;
+	unsigned accessTicks, recTicks;
+	unsigned accessTime, recTime;
 
 	i = pmac_ide_find(drive);
 	if (i < 0)
 		return;
 
-	if (pio = 255)
+	if (pio == 255)
 		pio = ata_timing_mode(drive, XFER_PIO | XFER_EPIO);
 	else
 		pio = XFER_PIO_0 + min_t(byte, pio, 4);
@@ -302,27 +482,40 @@
 	t = ata_timing_data(pio);
 
 	accessTicks = SYSCLK_TICKS(t->active);
-	if (drive->select.all & 0x10)
-		timings = &pmac_ide[i].timings[1];
-	else
-		timings = &pmac_ide[i].timings[0];
-
-	if (pmac_ide[i].kind == controller_kl_ata4) {
-		/* The "ata-4" IDE controller of Core99 machines */
-		accessTicks = SYSCLK_TICKS_UDMA(t->active * 1000);
-		recTicks = SYSCLK_TICKS_UDMA(t->cycle * 1000) - accessTicks;
+	timings = &pmac_ide[i].timings[drive->select.b.unit & 0x01];
 
-		*timings = ((*timings) & 0x1FFFFFC00) | accessTicks | (recTicks << 5);
+	recTime = t->cycle - t->active - t->setup;
+	recTime = max(recTime, 150U);
+	accessTime = t->active;
+	accessTime = max(accessTime, 150U);
+	if (pmac_ide[i].kind == controller_kl_ata4 ||
+		pmac_ide[i].kind == controller_kl_ata4_80) {
+		/* 66Mhz cell */
+		accessTicks = SYSCLK_TICKS_66(accessTime);
+		accessTicks = min(accessTicks, 0x1fU);
+		recTicks = SYSCLK_TICKS_66(recTime);
+		recTicks = min(recTicks, 0x1fU);
+		*timings = ((*timings) & ~TR_66_PIO_MASK) |
+				(accessTicks << TR_66_PIO_ACCESS_SHIFT) |
+				(recTicks << TR_66_PIO_RECOVERY_SHIFT);
 	} else {
-		/* The old "ata-3" IDE controller */
-		accessTicks = SYSCLK_TICKS(t->active);
-		if (accessTicks < 4)
-			accessTicks = 4;
-		recTicks = SYSCLK_TICKS(t->cycle) - accessTicks - 4;
-		if (recTicks < 1)
-			recTicks = 1;
-	
-		*timings = ((*timings) & 0xFFFFFF800) | accessTicks | (recTicks << 5);
+		/* 33Mhz cell */
+		int ebit = 0;
+		accessTicks = SYSCLK_TICKS(accessTime);
+		accessTicks = min(accessTicks, 0x1fU);
+		accessTicks = max(accessTicks, 4U);
+		recTicks = SYSCLK_TICKS(recTime);
+		recTicks = min(recTicks, 0x1fU);
+		recTicks = max(recTicks, 5U) - 4;
+		if (recTicks > 9) {
+			recTicks--; /* guess, but it's only for PIO0, so... */
+			ebit = 1;
+		}
+		*timings = ((*timings) & ~TR_33_PIO_MASK) |
+				(accessTicks << TR_33_PIO_ACCESS_SHIFT) |
+				(recTicks << TR_33_PIO_RECOVERY_SHIFT);
+		if (ebit)
+			*timings |= TR_33_PIO_E;
 	}
 
 #ifdef IDE_PMAC_DEBUG
@@ -335,70 +528,134 @@
 }
 
 #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC
-static int
-set_timings_udma(int intf, u32 *timings, byte speed)
+static int __pmac
+set_timings_udma(u32 *timings, byte speed)
 {
-	int cycleTime, accessTime;
-	int rdyToPauseTicks, cycleTicks;
-
-	if (pmac_ide[intf].kind != controller_kl_ata4)
-		return 1;
-		
-	cycleTime = udma_timings[speed & 0xf].cycleTime;
-	accessTime = udma_timings[speed & 0xf].accessTime;
+	unsigned rdyToPauseTicks, wrDataSetupTicks, addrTicks;
 
-	rdyToPauseTicks = SYSCLK_TICKS_UDMA(accessTime * 1000);
-	cycleTicks = SYSCLK_TICKS_UDMA(cycleTime * 1000);
-
-	*timings = ((*timings) & 0xe00fffff) |
-			((cycleTicks << 1) | (rdyToPauseTicks << 5) | 1) << 20;
+	rdyToPauseTicks = SYSCLK_TICKS_66(udma_timings[speed & 0xf].rdy2pause);
+	wrDataSetupTicks = SYSCLK_TICKS_66(udma_timings[speed & 0xf].wrDataSetup);
+	addrTicks = SYSCLK_TICKS_66(udma_timings[speed & 0xf].addrSetup);
+
+	*timings = ((*timings) & ~(TR_66_UDMA_MASK | TR_66_MDMA_MASK)) |
+			(wrDataSetupTicks << TR_66_UDMA_WRDATASETUP_SHIFT) | 
+			(rdyToPauseTicks << TR_66_UDMA_RDY2PAUS_SHIFT) |
+			(addrTicks <<TR_66_UDMA_ADDRSETUP_SHIFT) |
+			TR_66_UDMA_EN;
+#ifdef IDE_PMAC_DEBUG
+	printk(KERN_ERR "ide_pmac: Set UDMA timing for mode %d, reg: 0x%08x\n",
+		speed & 0xf,  *timings);
+#endif	
 
 	return 0;
 }
 
-static int
-set_timings_mdma(int intf, u32 *timings, byte speed)
+static int __pmac
+set_timings_mdma(int intf_type, u32 *timings, byte speed, int drive_cycle_time)
 {
-	int cycleTime, accessTime;
-	int accessTicks, recTicks;
+	int cycleTime, accessTime, recTime;
+	unsigned accessTicks, recTicks;
+	struct mdma_timings_t* tm;
+	int i;
 
-	/* Calculate accesstime and cycle time */
-	cycleTime = mdma_timings[speed & 0xf].cycleTime;
-	accessTime = mdma_timings[speed & 0xf].accessTime;
-	if ((pmac_ide[intf].kind == controller_ohare) && (cycleTime < 150))
+	/* Get default cycle time for mode */
+	switch(speed & 0xf) {
+		case 0: cycleTime = 480; break;
+		case 1: cycleTime = 150; break;
+		case 2: cycleTime = 120; break;
+		default:
+			return -1;
+	}
+	/* Adjust for drive */
+	if (drive_cycle_time && drive_cycle_time > cycleTime)
+		cycleTime = drive_cycle_time;
+	/* OHare limits according to some old Apple sources */	
+	if ((intf_type == controller_ohare) && (cycleTime < 150))
 		cycleTime = 150;
+	/* Get the proper timing array for this controller */
+	switch(intf_type) {
+		case controller_kl_ata4:
+		case controller_kl_ata4_80:
+			tm = mdma_timings_66;
+			break;
+		case controller_kl_ata3:
+			tm = mdma_timings_33k;
+			break;
+		default:
+			tm = mdma_timings_33;
+			break;
+	}
+	/* Lookup matching access & recovery times */
+	i = -1;
+	for (;;) {
+		if (tm[i+1].cycleTime < cycleTime)
+			break;
+		i++;
+	}
+	if (i < 0)
+		return -1;
+	cycleTime = tm[i].cycleTime;
+	accessTime = tm[i].accessTime;
+	recTime = tm[i].recoveryTime;
 
-	/* For ata-4 controller */
-	if (pmac_ide[intf].kind == controller_kl_ata4) {
-		accessTicks = SYSCLK_TICKS_UDMA(accessTime * 1000);
-		recTicks = SYSCLK_TICKS_UDMA(cycleTime * 1000) - accessTicks;
-		*timings = ((*timings) & 0xffe003ff) |
-			(accessTicks | (recTicks << 5)) << 10;
+#ifdef IDE_PMAC_DEBUG
+	printk(KERN_ERR "ide_pmac: MDMA, cycleTime: %d, accessTime: %d, recTime: %d\n",
+		cycleTime, accessTime, recTime);
+#endif	
+	if (intf_type == controller_kl_ata4 || intf_type == controller_kl_ata4_80) {
+		/* 66Mhz cell */
+		accessTicks = SYSCLK_TICKS_66(accessTime);
+		accessTicks = min(accessTicks, 0x1fU);
+		accessTicks = max(accessTicks, 0x1U);
+		recTicks = SYSCLK_TICKS_66(recTime);
+		recTicks = min(recTicks, 0x1fU);
+		recTicks = max(recTicks, 0x3U);
+		/* Clear out mdma bits and disable udma */
+		*timings = ((*timings) & ~(TR_66_MDMA_MASK | TR_66_UDMA_MASK)) |
+			(accessTicks << TR_66_MDMA_ACCESS_SHIFT) |
+			(recTicks << TR_66_MDMA_RECOVERY_SHIFT);
+	} else if (intf_type == controller_kl_ata3) {
+		/* 33Mhz cell on KeyLargo */
+		accessTicks = SYSCLK_TICKS(accessTime);
+		accessTicks = max(accessTicks, 1U);
+		accessTicks = min(accessTicks, 0x1fU);
+		accessTime = accessTicks * IDE_SYSCLK_NS;
+		recTicks = SYSCLK_TICKS(recTime);
+		recTicks = max(recTicks, 1U);
+		recTicks = min(recTicks, 0x1fU);
+		*timings = ((*timings) & ~TR_33_MDMA_MASK) |
+				(accessTicks << TR_33_MDMA_ACCESS_SHIFT) |
+				(recTicks << TR_33_MDMA_RECOVERY_SHIFT);
 	} else {
+		/* 33Mhz cell on others */
 		int halfTick = 0;
 		int origAccessTime = accessTime;
-		int origCycleTime = cycleTime;
+		int origRecTime = recTime;
 		
 		accessTicks = SYSCLK_TICKS(accessTime);
-		if (accessTicks < 1)
-			accessTicks = 1;
+		accessTicks = max(accessTicks, 1U);
+		accessTicks = min(accessTicks, 0x1fU);
 		accessTime = accessTicks * IDE_SYSCLK_NS;
-		recTicks = SYSCLK_TICKS(cycleTime - accessTime) - 1;
-		if (recTicks < 1)
-			recTicks = 1;
-		cycleTime = (recTicks + 1 + accessTicks) * IDE_SYSCLK_NS;
-
-		/* KeyLargo ata-3 don't support the half-tick stuff */
-		if ((pmac_ide[intf].kind != controller_kl_ata3) &&
-			(accessTicks > 1) &&
-			((accessTime - IDE_SYSCLK_NS/2) >= origAccessTime) &&
-			((cycleTime - IDE_SYSCLK_NS) >= origCycleTime)) {
-            			halfTick    = 1;
-				accessTicks--;
-		}
-		*timings = ((*timings) & 0x7FF) |
-			(accessTicks | (recTicks << 5) | (halfTick << 10)) << 11;
+		recTicks = SYSCLK_TICKS(recTime);
+		recTicks = max(recTicks, 2U) - 1;
+		recTicks = min(recTicks, 0x1fU);
+		recTime = (recTicks + 1) * IDE_SYSCLK_NS;
+		if ((accessTicks > 1) &&
+		    ((accessTime - IDE_SYSCLK_NS/2) >= origAccessTime) &&
+		    ((recTime - IDE_SYSCLK_NS/2) >= origRecTime)) {
+            		halfTick = 1;
+			accessTicks--;
+		}
+		*timings = ((*timings) & ~TR_33_MDMA_MASK) |
+				(accessTicks << TR_33_MDMA_ACCESS_SHIFT) |
+				(recTicks << TR_33_MDMA_RECOVERY_SHIFT);
+		if (halfTick)
+			*timings |= TR_33_MDMA_HALFTICK;
 	}
+#ifdef IDE_PMAC_DEBUG
+	printk(KERN_ERR "ide_pmac: Set MDMA timing for mode %d, reg: 0x%08x\n",
+		speed & 0xf,  *timings);
+#endif	
 	return 0;
 }
 #endif /* #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC */
@@ -406,11 +663,11 @@
 /* You may notice we don't use this function on normal operation,
  * our, normal mdma function is supposed to be more precise
  */
-static int
+static int __pmac
 pmac_ide_tune_chipset (ide_drive_t *drive, byte speed)
 {
 	int intf		= pmac_ide_find(drive);
-	int unit		= (drive->select.all & 0x10) ? 1:0;
+	int unit		= (drive->select.b.unit & 0x01);
 	int ret			= 0;
 	u32 *timings;
 
@@ -423,19 +680,25 @@
 #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC
 		case XFER_UDMA_4:
 		case XFER_UDMA_3:
+			if (pmac_ide[intf].kind != controller_kl_ata4_80)
+				return 1;		
 		case XFER_UDMA_2:
 		case XFER_UDMA_1:
 		case XFER_UDMA_0:
-			ret = set_timings_udma(intf, timings, speed);
+			if (pmac_ide[intf].kind != controller_kl_ata4 &&
+				pmac_ide[intf].kind != controller_kl_ata4_80)
+				return 1;		
+			ret = set_timings_udma(timings, speed);
 			break;
 		case XFER_MW_DMA_2:
 		case XFER_MW_DMA_1:
 		case XFER_MW_DMA_0:
+			ret = set_timings_mdma(pmac_ide[intf].kind, timings, speed, 0);
+			break;
 		case XFER_SW_DMA_2:
 		case XFER_SW_DMA_1:
 		case XFER_SW_DMA_0:
-			ret = set_timings_mdma(intf, timings, speed);
-			break;
+			return 1;
 #endif /* CONFIG_BLK_DEV_IDEDMA_PMAC */
 		case XFER_PIO_4:
 		case XFER_PIO_3:
@@ -460,13 +723,46 @@
 	return 0;
 }
 
-ide_ioreg_t
+static void __pmac
+sanitize_timings(int i)
+{
+	unsigned value;
+	
+	switch(pmac_ide[i].kind) {
+		case controller_kl_ata4:
+		case controller_kl_ata4_80:
+			value = 0x0008438c;
+			break;
+		case controller_kl_ata3:
+			value = 0x00084526;
+			break;
+		case controller_heathrow:
+		case controller_ohare:
+		default:
+			value = 0x00074526;
+			break;
+	}
+	pmac_ide[i].timings[0] = pmac_ide[i].timings[1] = value;
+}
+
+ide_ioreg_t __pmac
 pmac_ide_get_base(int index)
 {
 	return pmac_ide[index].regbase;
 }
 
-int
+int __pmac
+pmac_ide_check_base(ide_ioreg_t base)
+{
+	int ix;
+	
+ 	for (ix = 0; ix < MAX_HWIFS; ++ix)
+		if (base == pmac_ide[ix].regbase)
+			return ix;
+	return -1;
+}
+
+int __pmac
 pmac_ide_get_irq(ide_ioreg_t base)
 {
 	int ix;
@@ -477,7 +773,7 @@
 	return 0;
 }
 
-static int ide_majors[] = { 3, 22, 33, 34, 56, 57 };
+static int ide_majors[]  __pmacdata = { 3, 22, 33, 34, 56, 57 };
 
 kdev_t __init
 pmac_find_ide_boot(char *bootdevice, int n)
@@ -494,11 +790,11 @@
 		name = pmac_ide[i].node->full_name;
 		if (memcmp(name, bootdevice, n) == 0 && name[n] == 0) {
 			/* XXX should cope with the 2nd drive as well... */
-			return MKDEV(ide_majors[i], 0);
+			return mk_kdev(ide_majors[i], 0);
 		}
 	}
 
-	return 0;
+	return NODEV;
 }
 
 void __init
@@ -541,9 +837,12 @@
 
 	for (i = 0, np = atas; i < MAX_HWIFS && np != NULL; np = np->next) {
 		struct device_node *tp;
+		struct pmac_ide_hwif *pmif;
 		int *bidp;
 		int in_bay = 0;
-
+		u8 pbus, pid;
+		struct pci_dev *pdev = NULL;
+		
 		/*
 		 * If this node is not under a mac-io or dbdma node,
 		 * leave it to the generic PCI driver.
@@ -561,6 +860,15 @@
 			continue;
 		}
 
+		/* We need to find the pci_dev of the mac-io holding the
+		 * IDE interface
+		 */
+		if (pci_device_from_OF_node(tp, &pbus, &pid) == 0)
+			pdev = pci_find_slot(pbus, pid);
+		if (pdev == NULL)
+			printk(KERN_WARNING "ide: no PCI host for device %s, DMA disabled\n",
+			       np->full_name);
+		
 		/*
 		 * If this slot is taken (e.g. by ide-pci.c) try the next one.
 		 */
@@ -569,8 +877,23 @@
 			++i;
 		if (i >= MAX_HWIFS)
 			break;
+		pmif = &pmac_ide[i];
 
-		base = (unsigned long) ioremap(np->addrs[0].address, 0x200) - _IO_BASE;
+		/*
+		 * Some older OFs have bogus sizes, causing request_OF_resource
+		 * to fail. We fix them up here
+		 */
+		if (np->addrs[0].size > 0x1000)
+			np->addrs[0].size = 0x1000;
+		if (np->n_addrs > 1 && np->addrs[1].size > 0x100)
+			np->addrs[1].size = 0x100;
+
+		if (request_OF_resource(np, 0, "  (mac-io IDE IO)") == NULL) {
+			printk(KERN_ERR "ide-pmac(%s): can't request IO resource !\n", np->name);
+			continue;
+		}
+
+		base = (unsigned long) ioremap(np->addrs[0].address, 0x400) - _IO_BASE;
 
 		/* XXX This is bogus. Should be fixed in the registry by checking
 		   the kind of host interrupt controller, a bit like gatwick
@@ -583,21 +906,30 @@
 		} else {
 			irq = np->intrs[0].line;
 		}
-		pmac_ide[i].regbase = base;
-		pmac_ide[i].irq = irq;
-		pmac_ide[i].node = np;
+		pmif->regbase = base;
+		pmif->irq = irq;
+		pmif->node = np;
 		if (device_is_compatible(np, "keylargo-ata")) {
 			if (strcmp(np->name, "ata-4") == 0)
-				pmac_ide[i].kind = controller_kl_ata4;
+				pmif->kind = controller_kl_ata4;
 			else
-				pmac_ide[i].kind = controller_kl_ata3;
+				pmif->kind = controller_kl_ata3;
 		} else if (device_is_compatible(np, "heathrow-ata"))
-			pmac_ide[i].kind = controller_heathrow;
+			pmif->kind = controller_heathrow;
 		else
-			pmac_ide[i].kind = controller_ohare;
+			pmif->kind = controller_ohare;
 
 		bidp = (int *)get_property(np, "AAPL,bus-id", NULL);
-		pmac_ide[i].aapl_bus_id =  bidp ? *bidp : 0;
+		pmif->aapl_bus_id =  bidp ? *bidp : 0;
+
+		if (pmif->kind == controller_kl_ata4) {
+			char* cable = get_property(np, "cable-type", NULL);
+			if (cable && !strncmp(cable, "80-", 3))
+				pmif->kind = controller_kl_ata4_80;
+		}
+
+		/* Make sure we have sane timings */
+		sanitize_timings(i);
 
 		if (np->parent && np->parent->name
 		    && strcasecmp(np->parent->name, "media-bay") == 0) {
@@ -605,39 +937,22 @@
 			media_bay_set_ide_infos(np->parent,base,irq,i);
 #endif /* CONFIG_PMAC_PBOOK */
 			in_bay = 1;
-		} else if (pmac_ide[i].kind == controller_ohare) {
+			if (!bidp)
+				pmif->aapl_bus_id = 1;
+		} else if (pmif->kind == controller_ohare) {
 			/* The code below is having trouble on some ohare machines
 			 * (timing related ?). Until I can put my hand on one of these
 			 * units, I keep the old way
 			 */
-			 feature_set(np, FEATURE_IDE0_enable);
+			ppc_md.feature_call(PMAC_FTR_IDE_ENABLE, np, 0, 1);
 		} else {
  			/* This is necessary to enable IDE when net-booting */
 			printk(KERN_INFO "pmac_ide: enabling IDE bus ID %d\n",
-				pmac_ide[i].aapl_bus_id);
-			switch(pmac_ide[i].aapl_bus_id) {
-			    case 0:
-				feature_set(np, FEATURE_IDE0_reset);
-				mdelay(10);
- 				feature_set(np, FEATURE_IDE0_enable);
-				mdelay(10);
-				feature_clear(np, FEATURE_IDE0_reset);
-				break;
-			    case 1:
-				feature_set(np, FEATURE_IDE1_reset);
-				mdelay(10);
- 				feature_set(np, FEATURE_IDE1_enable);
-				mdelay(10);
-				feature_clear(np, FEATURE_IDE1_reset);
-				break;
-			    case 2:
-			    	/* This one exists only for KL, I don't know
-				   about any enable bit */
-				feature_set(np, FEATURE_IDE2_reset);
-				mdelay(10);
-				feature_clear(np, FEATURE_IDE2_reset);
-				break;
-			}
+				pmif->aapl_bus_id);
+			ppc_md.feature_call(PMAC_FTR_IDE_RESET, np, pmif->aapl_bus_id, 1);
+			ppc_md.feature_call(PMAC_FTR_IDE_ENABLE, np, pmif->aapl_bus_id, 1);
+			mdelay(10);
+			ppc_md.feature_call(PMAC_FTR_IDE_RESET, np, pmif->aapl_bus_id, 0);
 			big_delay = 1;
 		}
 
@@ -646,13 +961,15 @@
 		memcpy(hwif->io_ports, hwif->hw.io_ports, sizeof(hwif->io_ports));
 		hwif->chipset = ide_pmac;
 		hwif->noprobe = !hwif->io_ports[IDE_DATA_OFFSET] || in_bay;
+		hwif->udma_four = (pmif->kind == controller_kl_ata4_80);
+		hwif->pci_dev = pdev;
 #ifdef CONFIG_PMAC_PBOOK
 		if (in_bay && check_media_bay_by_base(base, MB_CD) == 0)
 			hwif->noprobe = 0;
 #endif /* CONFIG_PMAC_PBOOK */
 
 #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC
-		if (np->n_addrs >= 2) {
+		if (pdev && np->n_addrs >= 2) {
 			/* has a DBDMA controller channel */
 			pmac_ide_setup_dma(np, i);
 		}
@@ -674,7 +991,15 @@
 static void __init 
 pmac_ide_setup_dma(struct device_node *np, int ix)
 {
-	pmac_ide[ix].dma_regs =
+	struct pmac_ide_hwif *pmif = &pmac_ide[ix];
+
+	if (request_OF_resource(np, 1, " (mac-io IDE DMA)") == NULL) {
+		printk(KERN_ERR "ide-pmac(%s): can't request DMA resource !\n",
+			np->name);
+		return;
+	}
+
+	pmif->dma_regs =
 		(volatile struct dbdma_regs*)ioremap(np->addrs[1].address, 0x200);
 
 	/*
@@ -682,14 +1007,24 @@
 	 * The +2 is +1 for the stop command and +1 to allow for
 	 * aligning the start address to a multiple of 16 bytes.
 	 */
-	pmac_ide[ix].dma_table = (struct dbdma_cmd*)
-	       kmalloc((MAX_DCMDS + 2) * sizeof(struct dbdma_cmd), GFP_KERNEL);
-	if (pmac_ide[ix].dma_table == 0) {
+	pmif->dma_table_cpu = (struct dbdma_cmd*)pci_alloc_consistent(
+		ide_hwifs[ix].pci_dev,
+		(MAX_DCMDS + 2) * sizeof(struct dbdma_cmd),
+		&pmif->dma_table_dma);
+	if (pmif->dma_table_cpu == NULL) {
 		printk(KERN_ERR "%s: unable to allocate DMA command list\n",
 		       ide_hwifs[ix].name);
 		return;
 	}
 
+	pmif->sg_table = kmalloc(sizeof(struct scatterlist) * MAX_DCMDS,
+				 GFP_KERNEL);
+	if (pmif->sg_table == NULL) {
+		pci_free_consistent(	ide_hwifs[ix].pci_dev,
+					(MAX_DCMDS + 2) * sizeof(struct dbdma_cmd),
+				    	pmif->dma_table_cpu, pmif->dma_table_dma);
+		return;
+	}
 	ide_hwifs[ix].dmaproc = &pmac_ide_dmaproc;
 #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC_AUTO
 	if (!noautodma)
@@ -697,6 +1032,62 @@
 #endif
 }
 
+static int
+pmac_ide_build_sglist (int ix, struct request *rq)
+{
+	struct ata_channel *hwif = &ide_hwifs[ix];
+	struct pmac_ide_hwif *pmif = &pmac_ide[ix];
+	request_queue_t *q = &hwif->drives[DEVICE_NR(rq->rq_dev) & 1].queue;
+	struct scatterlist *sg = pmif->sg_table;
+	int nents;
+
+	nents = blk_rq_map_sg(q, rq, pmif->sg_table);
+
+	if (rq->q && nents > rq->nr_phys_segments)
+		printk("ide-pmac: received %d phys segments, build %d\n", rq->nr_phys_segments, nents);
+
+	if (rq_data_dir(rq) == READ)
+		pmif->sg_dma_direction = PCI_DMA_FROMDEVICE;
+	else
+		pmif->sg_dma_direction = PCI_DMA_TODEVICE;
+
+	return pci_map_sg(hwif->pci_dev, sg, nents, pmif->sg_dma_direction);
+}
+
+static int
+pmac_ide_raw_build_sglist (int ix, struct request *rq)
+{
+	struct ata_channel *hwif = &ide_hwifs[ix];
+	struct pmac_ide_hwif *pmif = &pmac_ide[ix];
+	struct scatterlist *sg = pmif->sg_table;
+	int nents = 0;
+	ide_task_t *args = rq->special;
+	unsigned char *virt_addr = rq->buffer;
+	int sector_count = rq->nr_sectors;
+
+	if (args->command_type == IDE_DRIVE_TASK_RAW_WRITE)
+		pmif->sg_dma_direction = PCI_DMA_TODEVICE;
+	else
+		pmif->sg_dma_direction = PCI_DMA_FROMDEVICE;
+
+	if (sector_count > 128) {
+		memset(&sg[nents], 0, sizeof(*sg));
+		sg[nents].page = virt_to_page(virt_addr);
+		sg[nents].offset = (unsigned long) virt_addr & ~PAGE_MASK;
+		sg[nents].length = 128  * SECTOR_SIZE;
+		nents++;
+		virt_addr = virt_addr + (128 * SECTOR_SIZE);
+		sector_count -= 128;
+	}
+	memset(&sg[nents], 0, sizeof(*sg));
+	sg[nents].page = virt_to_page(virt_addr);
+	sg[nents].offset = (unsigned long) virt_addr & ~PAGE_MASK;
+	sg[nents].length =  sector_count  * SECTOR_SIZE;
+	nents++;
+
+	return pci_map_sg(hwif->pci_dev, sg, nents, pmif->sg_dma_direction);
+}
+
 /*
  * pmac_ide_build_dmatable builds the DBDMA command list
  * for a transfer and sets the DBDMA channel to point to it.
@@ -704,47 +1095,40 @@
 static int
 pmac_ide_build_dmatable(ide_drive_t *drive, int ix, int wr)
 {
-	struct dbdma_cmd *table, *tstart;
-	int count = 0;
+	struct dbdma_cmd *table;
+	int i, count = 0;
 	struct request *rq = HWGROUP(drive)->rq;
-	struct buffer_head *bh = rq->bh;
-	unsigned int size, addr;
 	volatile struct dbdma_regs *dma = pmac_ide[ix].dma_regs;
+	struct scatterlist *sg;
+
+	/* DMA table is already aligned */
+	table = (struct dbdma_cmd *) pmac_ide[ix].dma_table_cpu;
 
-	table = tstart = (struct dbdma_cmd *) DBDMA_ALIGN(pmac_ide[ix].dma_table);
+	/* Make sure DMA controller is stopped (necessary ?) */
 	out_le32(&dma->control, (RUN|PAUSE|FLUSH|WAKE|DEAD) << 16);
 	while (in_le32(&dma->status) & RUN)
 		udelay(1);
 
-	do {
-		/*
-		 * Determine addr and size of next buffer area.  We assume that
-		 * individual virtual buffers are always composed linearly in
-		 * physical memory.  For example, we assume that any 8kB buffer
-		 * is always composed of two adjacent physical 4kB pages rather
-		 * than two possibly non-adjacent physical 4kB pages.
-		 */
-		if (bh == NULL) {  /* paging requests have (rq->bh == NULL) */
-			addr = virt_to_bus(rq->buffer);
-			size = rq->nr_sectors << 9;
-		} else {
-			/* group sequential buffers into one large buffer */
-			addr = virt_to_bus(bh->b_data);
-			size = bh->b_size;
-			while ((bh = bh->b_reqnext) != NULL) {
-				if ((addr + size) != virt_to_bus(bh->b_data))
-					break;
-				size += bh->b_size;
-			}
-		}
+	/* Build sglist */
+	if (rq->flags & REQ_DRIVE_TASKFILE) {
+		pmac_ide[ix].sg_nents = i = pmac_ide_raw_build_sglist(ix, rq);
+	} else {
+		pmac_ide[ix].sg_nents = i = pmac_ide_build_sglist(ix, rq);
+	}
+	if (!i)
+		return 0;
 
-		/*
-		 * Fill in the next DBDMA command block.
-		 * Note that one DBDMA command can transfer
-		 * at most 65535 bytes.
-		 */
-		while (size) {
-			unsigned int tc = (size < 0xfe00)? size: 0xfe00;
+	/* Build DBDMA commands list */
+	sg = pmac_ide[ix].sg_table;
+	while (i) {
+		u32 cur_addr;
+		u32 cur_len;
+
+		cur_addr = sg_dma_address(sg);
+		cur_len = sg_dma_len(sg);
+
+		while (cur_len) {
+			unsigned int tc = (cur_len < 0xfe00)? cur_len: 0xfe00;
 
 			if (++count >= MAX_DCMDS) {
 				printk(KERN_WARNING "%s: DMA table too small\n",
@@ -753,15 +1137,17 @@
 			}
 			st_le16(&table->command, wr? OUTPUT_MORE: INPUT_MORE);
 			st_le16(&table->req_count, tc);
-			st_le32(&table->phy_addr, addr);
+			st_le32(&table->phy_addr, cur_addr);
 			table->cmd_dep = 0;
 			table->xfer_status = 0;
 			table->res_count = 0;
-			addr += tc;
-			size -= tc;
+			cur_addr += tc;
+			cur_len -= tc;
 			++table;
 		}
-	} while (bh != NULL);
+		sg++;
+		i--;
+	}
 
 	/* convert the last command to an input/output last command */
 	if (count)
@@ -773,10 +1159,24 @@
 	memset(table, 0, sizeof(struct dbdma_cmd));
 	out_le16(&table->command, DBDMA_STOP);
 
-	out_le32(&dma->cmdptr, virt_to_bus(tstart));
+	out_le32(&dma->cmdptr, pmac_ide[ix].dma_table_dma);
 	return 1;
 }
 
+/* Teardown mappings after DMA has completed.  */
+static void
+pmac_ide_destroy_dmatable (ide_drive_t *drive, int ix)
+{
+	struct pci_dev *dev = HWIF(drive)->pci_dev;
+	struct scatterlist *sg = pmac_ide[ix].sg_table;
+	int nents = pmac_ide[ix].sg_nents;
+
+	if (nents) {
+		pci_unmap_sg(dev, sg, nents, pmac_ide[ix].sg_dma_direction);
+		pmac_ide[ix].sg_nents = 0;
+	}
+}
+
 
 static __inline__ unsigned char
 dma_bits_to_command(unsigned char bits)
@@ -791,12 +1191,14 @@
 }
 
 static __inline__ unsigned char
-udma_bits_to_command(unsigned char bits)
+udma_bits_to_command(unsigned char bits, int high_speed)
 {
-	if(bits & 0x10)
-		return XFER_UDMA_4;
-	if(bits & 0x08)
-		return XFER_UDMA_3;
+	if (high_speed) {
+		if(bits & 0x10)
+			return XFER_UDMA_4;
+		if(bits & 0x08)
+			return XFER_UDMA_3;
+	}
 	if(bits & 0x04)
 		return XFER_UDMA_2;
 	if(bits & 0x02)
@@ -807,14 +1209,13 @@
 }
 
 /* Calculate MultiWord DMA timings */
-static int
+static int __pmac
 pmac_ide_mdma_enable(ide_drive_t *drive, int idx)
 {
 	byte bits = drive->id->dma_mword & 0x07;
 	byte feature = dma_bits_to_command(bits);
 	u32 *timings;
-	int cycleTime, accessTime;
-	int accessTicks, recTicks;
+	int drive_cycle_time;
 	struct hd_driveid *id = drive->id;
 	int ret;
 
@@ -830,66 +1231,30 @@
 		drive->init_speed = feature;
 	
 	/* which drive is it ? */
-	if (drive->select.all & 0x10)
+	if (drive->select.b.unit & 0x01)
 		timings = &pmac_ide[idx].timings[1];
 	else
 		timings = &pmac_ide[idx].timings[0];
 
-	/* Calculate accesstime and cycle time */
-	cycleTime = mdma_timings[feature & 0xf].cycleTime;
-	accessTime = mdma_timings[feature & 0xf].accessTime;
+	/* Check if drive provide explicit cycle time */
 	if ((id->field_valid & 2) && (id->eide_dma_time))
-		cycleTime = id->eide_dma_time;
-	if ((pmac_ide[idx].kind == controller_ohare) && (cycleTime < 150))
-		cycleTime = 150;
+		drive_cycle_time = id->eide_dma_time;
+	else
+		drive_cycle_time = 0;
+
+	/* Calculate controller timings */
+	set_timings_mdma(pmac_ide[idx].kind, timings, feature, drive_cycle_time);
 
-	/* For ata-4 controller */
-	if (pmac_ide[idx].kind == controller_kl_ata4) {
-		accessTicks = SYSCLK_TICKS_UDMA(accessTime * 1000);
-		recTicks = SYSCLK_TICKS_UDMA(cycleTime * 1000) - accessTicks;
-		*timings = ((*timings) & 0xffe003ff) |
-			(accessTicks | (recTicks << 5)) << 10;
-	} else {
-		int halfTick = 0;
-		int origAccessTime = accessTime;
-		int origCycleTime = cycleTime;
-		
-		accessTicks = SYSCLK_TICKS(accessTime);
-		if (accessTicks < 1)
-			accessTicks = 1;
-		accessTime = accessTicks * IDE_SYSCLK_NS;
-		recTicks = SYSCLK_TICKS(cycleTime - accessTime) - 1;
-		if (recTicks < 1)
-			recTicks = 1;
-		cycleTime = (recTicks + 1 + accessTicks) * IDE_SYSCLK_NS;
-
-		/* KeyLargo ata-3 don't support the half-tick stuff */
-		if ((pmac_ide[idx].kind != controller_kl_ata3) &&
-			(accessTicks > 1) &&
-			((accessTime - IDE_SYSCLK_NS/2) >= origAccessTime) &&
-			((cycleTime - IDE_SYSCLK_NS) >= origCycleTime)) {
-            			halfTick    = 1;
-				accessTicks--;
-		}
-		*timings = ((*timings) & 0x7FF) |
-			(accessTicks | (recTicks << 5) | (halfTick << 10)) << 11;
-	}
-#ifdef IDE_PMAC_DEBUG
-	printk(KERN_INFO "ide_pmac: Set MDMA timing for mode %d, reg: 0x%08x\n",
-		feature & 0xf, *timings);
-#endif
 	drive->current_speed = feature;	
 	return 1;
 }
 
 /* Calculate Ultra DMA timings */
-static int
-pmac_ide_udma_enable(ide_drive_t *drive, int idx)
+static int __pmac
+pmac_ide_udma_enable(ide_drive_t *drive, int idx, int high_speed)
 {
 	byte bits = drive->id->dma_ultra & 0x1f;
-	byte feature = udma_bits_to_command(bits);
-	int cycleTime, accessTime;
-	int rdyToPauseTicks, cycleTicks;
+	byte feature = udma_bits_to_command(bits, high_speed);
 	u32 *timings;
 	int ret;
 
@@ -905,25 +1270,18 @@
 		drive->init_speed = feature;
 
 	/* which drive is it ? */
-	if (drive->select.all & 0x10)
+	if (drive->select.b.unit & 0x01)
 		timings = &pmac_ide[idx].timings[1];
 	else
 		timings = &pmac_ide[idx].timings[0];
 
-	cycleTime = udma_timings[feature & 0xf].cycleTime;
-	accessTime = udma_timings[feature & 0xf].accessTime;
-
-	rdyToPauseTicks = SYSCLK_TICKS_UDMA(accessTime * 1000);
-	cycleTicks = SYSCLK_TICKS_UDMA(cycleTime * 1000);
-
-	*timings = ((*timings) & 0xe00fffff) |
-			((cycleTicks << 1) | (rdyToPauseTicks << 5) | 1) << 20;
+	set_timings_udma(timings, feature);
 
 	drive->current_speed = feature;	
 	return 1;
 }
 
-static int
+static int __pmac
 pmac_ide_check_dma(ide_drive_t *drive)
 {
 	int ata4, udma, idx;
@@ -944,21 +1302,20 @@
 		enable = 0;
 
 	udma = 0;
-	ata4 = (pmac_ide[idx].kind == controller_kl_ata4);
+	ata4 = (pmac_ide[idx].kind == controller_kl_ata4 ||
+		pmac_ide[idx].kind == controller_kl_ata4_80);
 
 	if(enable) {
 		if (ata4 && (drive->type == ATA_DISK) &&
-		    (id->field_valid & 0x0004) && (id->dma_ultra & 0x17)) {
+		    (id->field_valid & 0x0004) && (id->dma_ultra & 0x1f)) {
 			/* UltraDMA modes. */
-			drive->using_dma = pmac_ide_udma_enable(drive, idx);
+			drive->using_dma = pmac_ide_udma_enable(drive, idx,
+				pmac_ide[idx].kind == controller_kl_ata4_80);
 		}
 		if (!drive->using_dma && (id->dma_mword & 0x0007)) {
 			/* Normal MultiWord DMA modes. */
 			drive->using_dma = pmac_ide_mdma_enable(drive, idx);
 		}
-		/* Without this, strange things will happen on Keylargo-based
-		 * machines
-		 */
 		OUT_BYTE(0, IDE_CONTROL_REG);
 		/* Apply settings to controller */
 		pmac_ide_selectproc(drive);
@@ -966,11 +1323,26 @@
 	return 0;
 }
 
+static void ide_toggle_bounce(ide_drive_t *drive, int on)
+{
+	dma64_addr_t addr = BLK_BOUNCE_HIGH;
+
+	if (on && drive->type == ATA_DISK && HWIF(drive)->highmem) {
+		if (!PCI_DMA_BUS_IS_PHYS)
+			addr = BLK_BOUNCE_ANY;
+		else
+			addr = HWIF(drive)->pci_dev->dma_mask;
+	}
+
+	blk_queue_bounce_limit(&drive->queue, addr);
+}
+
 int pmac_ide_dmaproc(ide_dma_action_t func, ide_drive_t *drive)
 {
-	int ix, dstat, i;
+	int ix, dstat, reading, ata4;
 	volatile struct dbdma_regs *dma;
-
+	byte unit = (drive->select.b.unit & 0x01);
+	
 	/* Can we stuff a pointer to our intf structure in config_data
 	 * or select_data in hwif ?
 	 */
@@ -978,59 +1350,106 @@
 	if (ix < 0)
 		return 0;		
 	dma = pmac_ide[ix].dma_regs;
-
+	ata4 = (pmac_ide[ix].kind == controller_kl_ata4 ||
+		pmac_ide[ix].kind == controller_kl_ata4_80);
+	
 	switch (func) {
 	case ide_dma_off:
 		printk(KERN_INFO "%s: DMA disabled\n", drive->name);
 	case ide_dma_off_quietly:
 		drive->using_dma = 0;
+		ide_toggle_bounce(drive, 0);
 		break;
 	case ide_dma_on:
 	case ide_dma_check:
+		/* Change this to better match ide-dma.c */
 		pmac_ide_check_dma(drive);
+		ide_toggle_bounce(drive, drive->using_dma);
 		break;
 	case ide_dma_read:
 	case ide_dma_write:
-		if (!pmac_ide_build_dmatable(drive, ix, func==ide_dma_write))
+		/* this almost certainly isn't needed since we don't
+		   appear to have a rwproc */
+		if (HWIF(drive)->rwproc)
+			HWIF(drive)->rwproc(drive, func);
+		reading = (func == ide_dma_read);
+		if (!pmac_ide_build_dmatable(drive, ix, !reading))
 			return 1;
+		/* Apple adds 60ns to wrDataSetup on reads */
+		if (ata4 && (pmac_ide[ix].timings[unit] & TR_66_UDMA_EN)) {
+			out_le32((unsigned *)(IDE_DATA_REG + IDE_TIMING_CONFIG + _IO_BASE),
+				pmac_ide[ix].timings[unit] + 
+				((func == ide_dma_read) ? 0x00800000UL : 0));
+			(void)in_le32((unsigned *)(IDE_DATA_REG + IDE_TIMING_CONFIG + _IO_BASE));
+		}
 		drive->waiting_for_dma = 1;
 		if (drive->type != ATA_DISK)
 			return 0;
 		BUG_ON(HWGROUP(drive)->handler);
 		ide_set_handler(drive, &ide_dma_intr, WAIT_CMD, NULL);
-		OUT_BYTE(func==ide_dma_write? WIN_WRITEDMA: WIN_READDMA,
-			 IDE_COMMAND_REG);
+		if ((HWGROUP(drive)->rq->flags & REQ_DRIVE_TASKFILE) &&
+		    (drive->addressing == 1)) {
+			ide_task_t *args = HWGROUP(drive)->rq->special;
+			OUT_BYTE(args->taskfile.command, IDE_COMMAND_REG);
+		} else if (drive->addressing) {
+			OUT_BYTE(reading ? WIN_READDMA_EXT : WIN_WRITEDMA_EXT, IDE_COMMAND_REG);
+		} else {
+			OUT_BYTE(reading ? WIN_READDMA : WIN_WRITEDMA, IDE_COMMAND_REG);
+		}
+		/* fall through */
 	case ide_dma_begin:
 		out_le32(&dma->control, (RUN << 16) | RUN);
+		/* Make sure it gets to the controller right now */
+		(void)in_le32(&dma->control);
 		break;
-	case ide_dma_end:
+	case ide_dma_end: /* returns 1 on error, 0 otherwise */
 		drive->waiting_for_dma = 0;
 		dstat = in_le32(&dma->status);
 		out_le32(&dma->control, ((RUN|WAKE|DEAD) << 16));
+		pmac_ide_destroy_dmatable(drive, ix);
 		/* verify good dma status */
 		return (dstat & (RUN|DEAD|ACTIVE)) != RUN;
-	case ide_dma_test_irq:
-		if ((in_le32(&dma->status) & (RUN|ACTIVE)) == RUN)
-			return 1;
-		/* That's a bit ugly and dangerous, but works in our case
-		 * to workaround a problem with the channel status staying
-		 * active if the drive returns an error
+	case ide_dma_test_irq: /* returns 1 if dma irq issued, 0 otherwise */
+		/* We have to things to deal with here:
+		 * 
+		 * - The dbdma won't stop if the command was started
+		 * but completed with an error without transfering all
+		 * datas. This happens when bad blocks are met during
+		 * a multi-block transfer.
+		 * 
+		 * - The dbdma fifo hasn't yet finished flushing to
+		 * to system memory when the disk interrupt occurs.
+		 * 
+		 * The trick here is to increment drive->waiting_for_dma,
+		 * and return as if no interrupt occured. If the counter
+		 * reach a certain timeout value, we then return 1. If
+		 * we really got the interrupt, it will happen right away
+		 * again.
+		 * Apple's solution here may be more elegant. They issue
+		 * a DMA channel interrupt (a separate irq line) via a DBDMA
+		 * NOP command just before the STOP, and wait for both the
+		 * disk and DBDMA interrupts to have completed.
 		 */
-		if (IDE_CONTROL_REG) {
-			byte stat;
-			stat = GET_ALTSTAT();
-			if (stat & ERR_STAT)
-				return 1;
-		}
-		/* In some edge cases, some datas may still be in the dbdma
-		 * engine fifo, we wait a bit for dbdma to complete
+		 
+		/* If ACTIVE is cleared, the STOP command have passed and
+		 * transfer is complete.
 		 */
-		while ((in_le32(&dma->status) & (RUN|ACTIVE)) != RUN) {
-			if (++i > 100)
-				return 0;
-			udelay(1);
+		if (!(in_le32(&dma->status) & ACTIVE))
+			return 1;
+		if (!drive->waiting_for_dma)
+			printk(KERN_WARNING "ide%d, ide_dma_test_irq \
+				called while not waiting\n", ix);
+
+		/* If dbdma didn't execute the STOP command yet, the
+		 * active bit is still set */
+		drive->waiting_for_dma++;
+		if (drive->waiting_for_dma >= DMA_WAIT_TIMEOUT) {
+			printk(KERN_WARNING "ide%d, timeout waiting \
+				for dbdma command stop\n", ix);
+			return 1;
 		}
-		return 1;
+		udelay(1);
+		return 0;
 
 		/* Let's implement tose just in case someone wants them */
 	case ide_dma_bad_drive:
@@ -1051,7 +1470,6 @@
 }
 #endif /* CONFIG_BLK_DEV_IDEDMA_PMAC */
 
-#ifdef CONFIG_PMAC_PBOOK
 static void idepmac_sleep_device(ide_drive_t *drive, int i, unsigned base)
 {
 	int j;
@@ -1062,7 +1480,9 @@
 	switch (drive->type) {
 	case ATA_DISK:
 		/* Spin down the drive */
-		outb(0xa0, base+0x60);
+		outb(drive->select.all, base+0x60);
+		(void)inb(base+0x60);
+		udelay(100);
 		outb(0x0, base+0x30);
 		outb(0x0, base+0x20);
 		outb(0x0, base+0x40);
@@ -1086,19 +1506,21 @@
 	}
 }
 
-static void idepmac_wake_device(ide_drive_t *drive, int used_dma)
- {
+#ifdef CONFIG_PMAC_PBOOK
+static void __pmac
+idepmac_wake_device(ide_drive_t *drive, int used_dma)
+{
 	/* We force the IDE subdriver to check for a media change
 	 * This must be done first or we may lost the condition
 	 *
 	 * Problem: This can schedule. I moved the block device
 	 * wakeup almost late by priority because of that.
 	 */
-	if (DRIVER(drive) && DRIVER(drive)->media_change)
-		DRIVER(drive)->media_change(drive);
+	if (drive->driver != NULL && ata_ops(drive)->check_media_change)
+		ata_ops(drive)->check_media_change(drive);
 
 	/* We kick the VFS too (see fix in ide.c revalidate) */
-	check_disk_change(MKDEV(drive->channel->major, (drive->select.b.unit) << PARTN_BITS));
+	check_disk_change(mk_kdev(drive->channel->major, (drive->select.b.unit) << PARTN_BITS));
 	
 #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC
 	/* We re-enable DMA on the drive if it was active. */
@@ -1108,15 +1530,16 @@
 	 */
 	if (used_dma && !ide_spin_wait_hwgroup(drive)) {
 		/* Lock HW group */
-		HWGROUP(drive)->busy = 1;
+		set_bit(IDE_BUSY, &HWGROUP(drive)->flags);
 		pmac_ide_check_dma(drive);
-		HWGROUP(drive)->busy = 0;
+		clear_bit(IDE_BUSY, &HWGROUP(drive)->flags);
 		spin_unlock_irq(&ide_lock);
 	}
 #endif /* CONFIG_BLK_DEV_IDEDMA_PMAC */
 }
 
-static void idepmac_sleep_interface(int i, unsigned base, int mediabay)
+static void __pmac
+idepmac_sleep_interface(int i, unsigned base, int mediabay)
 {
 	struct device_node* np = pmac_ide[i].node;
 
@@ -1128,73 +1551,81 @@
 	if (mediabay)
 		return;
 	
-	/* Disable and reset the bus */
-	feature_set(np, FEATURE_IDE0_reset);
-	feature_clear(np, FEATURE_IDE0_enable);
-	switch(pmac_ide[i].aapl_bus_id) {
-	    case 0:
-		feature_set(np, FEATURE_IDE0_reset);
-		feature_clear(np, FEATURE_IDE0_enable);
-		break;
-	    case 1:
-		feature_set(np, FEATURE_IDE1_reset);
-		feature_clear(np, FEATURE_IDE1_enable);
-		break;
-	    case 2:
-		feature_set(np, FEATURE_IDE2_reset);
-		break;
-	}
+	/* Disable the bus */
+	ppc_md.feature_call(PMAC_FTR_IDE_ENABLE, np, pmac_ide[i].aapl_bus_id, 0);
 }
 
-static void idepmac_wake_interface(int i, unsigned long base, int mediabay)
+static void __pmac
+idepmac_wake_interface(int i, unsigned long base, int mediabay)
 {
 	struct device_node* np = pmac_ide[i].node;
 
 	if (!mediabay) {
 		/* Revive IDE disk and controller */
-		switch(pmac_ide[i].aapl_bus_id) {
-		    case 0:
-			feature_set(np, FEATURE_IDE0_reset);
-			feature_set(np, FEATURE_IOBUS_enable);
-			mdelay(10);
-	 		feature_set(np, FEATURE_IDE0_enable);
-			mdelay(10);
-			feature_clear(np, FEATURE_IDE0_reset);
-			break;
-		    case 1:
-			feature_set(np, FEATURE_IDE1_reset);
-			feature_set(np, FEATURE_IOBUS_enable);
-			mdelay(10);
-	 		feature_set(np, FEATURE_IDE1_enable);
-			mdelay(10);
-			feature_clear(np, FEATURE_IDE1_reset);
-			break;
-		    case 2:
-		    	/* This one exists only for KL, I don't know
-			   about any enable bit */
-			feature_set(np, FEATURE_IDE2_reset);
-			mdelay(10);
-			feature_clear(np, FEATURE_IDE2_reset);
-			break;
-		}
+		ppc_md.feature_call(PMAC_FTR_IDE_RESET, np, pmac_ide[i].aapl_bus_id, 1);
+		ppc_md.feature_call(PMAC_FTR_IDE_ENABLE, np, pmac_ide[i].aapl_bus_id, 1);
+		mdelay(10);
+		ppc_md.feature_call(PMAC_FTR_IDE_RESET, np, pmac_ide[i].aapl_bus_id, 0);
 	}
+}
+
+static void
+idepmac_sleep_drive(ide_drive_t *drive, int idx, unsigned long base)
+{
+	/* Wait for HW group to complete operations */
+	if (ide_spin_wait_hwgroup(drive))
+		// What can we do here ? Wake drive we had already
+		// put to sleep and return an error ?
+		return;
+	else {
+		/* Lock HW group */
+		set_bit(IDE_BUSY, &HWGROUP(drive)->flags);
+		/* Stop the device */
+		idepmac_sleep_device(drive, idx, base);
+		spin_unlock_irq(&ide_lock);
+	}
+}
+
+static void
+idepmac_wake_drive(ide_drive_t *drive, unsigned long base)
+{
+	int j;
 	
 	/* Reset timings */
-	pmac_ide_selectproc(&ide_hwifs[i].drives[0]);
+	pmac_ide_selectproc(drive);
 	mdelay(10);
+	
+	/* Wait up to 20 seconds for the drive to be ready */
+	for (j = 0; j < 200; j++) {
+		int status;
+		mdelay(100);
+		outb(drive->select.all, base + 0x60);
+		if (inb(base + 0x60) != drive->select.all)
+			continue;
+		status = inb(base + 0x70);
+		if (!(status & BUSY_STAT))
+			break;
+	}
+
+	/* We resume processing on the HW group */
+	spin_lock_irq(&ide_lock);
+	clear_bit(IDE_BUSY, &HWGROUP(drive)->flags);
+	if (!list_empty(&drive->queue.queue_head))
+		do_ide_request(&drive->queue);
+	spin_unlock_irq(&ide_lock);
 }
 
 /* Note: We support only master drives for now. This will have to be
  * improved if we want to handle sleep on the iMacDV where the CD-ROM
  * is a slave
  */
-static int idepmac_notify_sleep(struct pmu_sleep_notifier *self, int when)
+static int __pmac
+idepmac_notify_sleep(struct pmu_sleep_notifier *self, int when)
 {
 	int i, ret;
 	unsigned long base;
-	unsigned long flags;
 	int big_delay;
-
+ 
 	switch (when) {
 	case PBOOK_SLEEP_REQUEST:
 		break;
@@ -1203,34 +1634,19 @@
 	case PBOOK_SLEEP_NOW:
 		for (i = 0; i < pmac_ide_count; ++i) {
 			struct ata_channel *hwif;
-			ide_drive_t *drive;
-			int unlock = 0;
+			int dn;
 
 			if ((base = pmac_ide[i].regbase) == 0)
-				continue;	
+				continue;
 
 			hwif = &ide_hwifs[i];
-			drive = &hwif->drives[0];
-			
-			if (drive->present) {
-				/* Wait for HW group to complete operations */
-				if (ide_spin_wait_hwgroup(drive)) {
-					// What can we do here ? Wake drive we had already
-					// put to sleep and return an error ?
-				} else {
-					unlock = 1;
-					/* Lock HW group */
-					HWGROUP(drive)->busy = 1;
-
-					/* Stop the device */
-					idepmac_sleep_device(drive, i, base);
-				
-				}
+			for (dn=0; dn<MAX_DRIVES; dn++) {
+				if (!hwif->drives[dn].present)
+					continue;
+				idepmac_sleep_drive(&hwif->drives[dn], i, base);
 			}
 			/* Disable irq during sleep */
 			disable_irq(pmac_ide[i].irq);
-			if (unlock)
-				spin_unlock_irq(&ide_lock);
 			
 			/* Check if this is a media bay with an IDE device or not
 			 * a media bay.
@@ -1247,6 +1663,9 @@
 			if ((base = pmac_ide[i].regbase) == 0)
 				continue;
 				
+			/* Make sure we have sane timings */		
+			sanitize_timings(i);
+
 			/* Check if this is a media bay with an IDE device or not
 			 * a media bay
 			 */
@@ -1263,43 +1682,29 @@
 	
 		for (i = 0; i < pmac_ide_count; ++i) {
 			struct ata_channel *hwif;
-			ide_drive_t *drive;
-			int j, used_dma;
+			int used_dma, dn;
+			int irq_on = 0;
 			
 			if ((base = pmac_ide[i].regbase) == 0)
 				continue;
 				
 			hwif = &ide_hwifs[i];
-			drive = &hwif->drives[0];
-
-			/* Wait for the drive to come up and set it's DMA */
-			if (drive->present) {
-				/* Wait up to 20 seconds */
-				for (j = 0; j < 200; j++) {
-					int status;
-					mdelay(100);
-					status = inb(base + 0x70);
-					if (!(status & BUSY_STAT))
-						break;
+			for (dn=0; dn<MAX_DRIVES; dn++) {
+				ide_drive_t *drive = &hwif->drives[dn];
+				if (!drive->present)
+					continue;
+				/* We don't have re-configured DMA yet */
+				used_dma = drive->using_dma;
+				drive->using_dma = 0;
+				idepmac_wake_drive(drive, base);
+				if (!irq_on) {
+					enable_irq(pmac_ide[i].irq);
+					irq_on = 1;
 				}
-			}
-			
-			/* We don't have re-configured DMA yet */
-			used_dma = drive->using_dma;
-			drive->using_dma = 0;
-
-			/* We resume processing on the HW group */
-			spin_lock_irqsave(&ide_lock, flags);
-			enable_irq(pmac_ide[i].irq);
-			if (drive->present)
-				HWGROUP(drive)->busy = 0;
-			spin_unlock_irqrestore(&ide_lock, flags);
-			
-			/* Wake the device
-			 * We could handle the slave here
-			 */
-			if (drive->present)
 				idepmac_wake_device(drive, used_dma);
+			}
+			if (!irq_on)
+				enable_irq(pmac_ide[i].irq);
 		}
 		break;
 	}
diff -urN linux-2.5.8-pre2/drivers/ide/ide-pnp.c linux/drivers/ide/ide-pnp.c
--- linux-2.5.8-pre2/drivers/ide/ide-pnp.c	Mon Apr  8 21:12:44 2002
+++ linux/drivers/ide/ide-pnp.c	Mon Apr  8 16:29:16 2002
@@ -16,6 +16,7 @@
  * Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
+#include <linux/types.h>
 #include <linux/ide.h>
 #include <linux/init.h>
 
diff -urN linux-2.5.8-pre2/drivers/ide/ide-probe.c linux/drivers/ide/ide-probe.c
--- linux-2.5.8-pre2/drivers/ide/ide-probe.c	Mon Apr  8 21:12:44 2002
+++ linux/drivers/ide/ide-probe.c	Mon Apr  8 18:21:28 2002
@@ -140,7 +140,7 @@
 				/* kludge for Apple PowerBook internal zip */
 				if (!strstr(id->model, "CD-ROM") && strstr(id->model, "ZIP")) {
 					printk ("FLOPPY");
-					type = ide_floppy;
+					type = ATA_FLOPPY;
 					break;
 				}
 #endif
@@ -666,13 +666,12 @@
 				hwif->sharing_irq = h->sharing_irq = 1;
 				if (hwif->chipset != ide_pci || h->chipset != ide_pci)
 					save_match(hwif, h, &match);
-			}
-			if (hwif->serialized) {
-				if (hwif->mate && hwif->mate->irq == h->irq)
-					save_match(hwif, h, &match);
-			}
-			if (h->serialized) {
-				if (h->mate && hwif->irq == h->mate->irq)
+
+				/* FIXME: This is still confusing. What would
+				 * happen if we match-ed two times?
+				 */
+
+				if (hwif->serialized || h->serialized)
 					save_match(hwif, h, &match);
 			}
 		}
@@ -823,12 +822,11 @@
 
 	for (unit = 0; unit < MAX_DRIVES; ++unit) {
 		char name[80];
+
 		ide_add_generic_settings(hwif->drives + unit);
 		hwif->drives[unit].dn = ((hwif->unit ? 2 : 0) + unit);
 		sprintf (name, "host%d/bus%d/target%d/lun%d",
-			(hwif->unit && hwif->mate) ?
-			hwif->mate->index : hwif->index,
-			hwif->unit, unit, hwif->drives[unit].lun);
+			hwif->index, hwif->unit, unit, hwif->drives[unit].lun);
 		if (hwif->drives[unit].present)
 			hwif->drives[unit].de = devfs_mk_dir(ide_devfs_handle, name, NULL);
 	}
diff -urN linux-2.5.8-pre2/drivers/ide/ide-proc.c linux/drivers/ide/ide-proc.c
--- linux-2.5.8-pre2/drivers/ide/ide-proc.c	Mon Apr  8 21:12:44 2002
+++ linux/drivers/ide/ide-proc.c	Mon Apr  8 16:29:16 2002
@@ -164,19 +164,6 @@
 	PROC_IDE_READ_RETURN(page,start,off,count,eof,len);
 }
 
-static int proc_ide_read_mate
-	(char *page, char **start, off_t off, int count, int *eof, void *data)
-{
-	struct ata_channel *hwif = data;
-	int		len;
-
-	if (hwif && hwif->mate && hwif->mate->present)
-		len = sprintf(page, "%s\n", hwif->mate->name);
-	else
-		len = sprintf(page, "(none)\n");
-	PROC_IDE_READ_RETURN(page,start,off,count,eof,len);
-}
-
 static int proc_ide_read_channel
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
@@ -493,7 +480,6 @@
 
 static ide_proc_entry_t hwif_entries[] = {
 	{ "channel",	S_IFREG|S_IRUGO,	proc_ide_read_channel,	NULL },
-	{ "mate",	S_IFREG|S_IRUGO,	proc_ide_read_mate,	NULL },
 	{ "model",	S_IFREG|S_IRUGO,	proc_ide_read_imodel,	NULL },
 	{ NULL,	0, NULL, NULL }
 };
diff -urN linux-2.5.8-pre2/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.8-pre2/drivers/ide/ide.c	Mon Apr  8 21:12:44 2002
+++ linux/drivers/ide/ide.c	Mon Apr  8 16:29:16 2002
@@ -2177,7 +2177,7 @@
 		}
 		for (h = 0; h < MAX_HWIFS; ++h) {
 			hwif = &ide_hwifs[h];
-			if ((!hwif->present && !hwif->mate && !initializing) ||
+			if ((!hwif->present && (hwif->unit == ATA_PRIMARY) && !initializing) ||
 			    (!hwif->hw.io_ports[IDE_DATA_OFFSET] && initializing))
 				goto found;
 		}
@@ -3052,9 +3052,13 @@
 				goto done;
 			case -2: /* "serialize" */
 			do_serialize:
-				hwif->mate = &ide_hwifs[hw^1];
-				hwif->mate->mate = hwif;
-				hwif->serialized = hwif->mate->serialized = 1;
+				{
+					struct ata_channel *mate;
+
+					mate = &ide_hwifs[hw ^ 1];
+					hwif->serialized = 1;
+					mate->serialized = 1;
+				}
 				goto done;
 
 			case -1: /* "noprobe" */
diff -urN linux-2.5.8-pre2/drivers/ide/ns87415.c linux/drivers/ide/ns87415.c
--- linux-2.5.8-pre2/drivers/ide/ns87415.c	Mon Apr  8 21:12:44 2002
+++ linux/drivers/ide/ns87415.c	Mon Apr  8 19:01:23 2002
@@ -141,11 +141,21 @@
 	using_inta = progif & (1 << (hwif->unit << 1));
 	if (!using_inta)
 		using_inta = ctrl & (1 << (4 + hwif->unit));
-	if (hwif->mate) {
-		hwif->select_data = hwif->mate->select_data;
+	if (hwif->unit == ATA_SECONDARY) {
+
+		/* FIXME: If we are initializing the secondary channel, let us
+		 * assume that the primary channel got initialized just a tad
+		 * bit before now.  It would be much cleaner if the data in
+		 * ns87415_control just got duplicated.
+		 */
+
+		if (!hwif->select_data)
+		    hwif->select_data = (unsigned long)
+			&ns87415_control[ns87415_count - 1];
 	} else {
-		hwif->select_data = (unsigned long)
-					&ns87415_control[ns87415_count++];
+		if (!hwif->select_data)
+		    hwif->select_data = (unsigned long)
+			&ns87415_control[ns87415_count++];
 		ctrl |= (1 << 8) | (1 << 9);	/* mask both IRQs */
 		if (using_inta)
 			ctrl &= ~(1 << 6);	/* unmask INTA */
@@ -170,9 +180,9 @@
 		do {
 			udelay(50);
 			stat = inb(hwif->io_ports[IDE_STATUS_OFFSET]);
-                	if (stat == 0xff)
-                        	break;
-        	} while ((stat & BUSY_STAT) && --timeout);
+			if (stat == 0xff)
+				break;
+		} while ((stat & BUSY_STAT) && --timeout);
 #endif
 	}
 
@@ -181,13 +191,23 @@
 
 	if (!using_inta)
 		hwif->irq = hwif->unit ? 15 : 14;	/* legacy mode */
-	else if (!hwif->irq && hwif->mate && hwif->mate->irq)
-		hwif->irq = hwif->mate->irq;	/* share IRQ with mate */
+	else {
+		static int primary_irq = 0;
+
+		/* Ugly way to let the primary and secondary channel on the
+		 * chip use the same IRQ line.
+		 */
+
+		if (hwif->unit == ATA_PRIMARY)
+			primary_irq = hwif->irq;
+		else if (!hwif->irq)
+			hwif->irq = primary_irq;
+	}
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	if (hwif->dma_base)
 		hwif->dmaproc = &ns87415_dmaproc;
-#endif /* CONFIG_BLK_DEV_IDEDMA */
+#endif
 
 	hwif->selectproc = &ns87415_selectproc;
 }
diff -urN linux-2.5.8-pre2/drivers/ide/pdc4030.c linux/drivers/ide/pdc4030.c
--- linux-2.5.8-pre2/drivers/ide/pdc4030.c	Mon Apr  8 21:12:44 2002
+++ linux/drivers/ide/pdc4030.c	Mon Apr  8 16:29:16 2002
@@ -162,7 +162,7 @@
 	struct dc_ident ident;
 	int i;
 	ide_startstop_t startstop;
-	
+
 	if (!hwif) return 0;
 
 	drive = &hwif->drives[0];
@@ -224,9 +224,8 @@
 	 */
 
 	hwif->chipset	= hwif2->chipset = ide_pdc4030;
-	hwif->mate	= hwif2;
-	hwif2->mate	= hwif;
-	hwif2->unit	= 1;
+	hwif->unit	= ATA_PRIMARY;
+	hwif2->unit	= ATA_SECONDARY;
 	hwif->selectproc = hwif2->selectproc = &promise_selectproc;
 	hwif->serialized = hwif2->serialized = 1;
 
diff -urN linux-2.5.8-pre2/drivers/ide/piix.c linux/drivers/ide/piix.c
--- linux-2.5.8-pre2/drivers/ide/piix.c	Mon Apr  8 21:12:44 2002
+++ linux/drivers/ide/piix.c	Mon Apr  8 16:29:16 2002
@@ -1,5 +1,5 @@
 /*
- * $Id: piix.c,v 1.2 2002/03/13 22:50:43 vojtech Exp $
+ * $Id: piix.c,v 1.3 2002/03/29 16:06:06 vojtech Exp $
  *
  *  Copyright (c) 2000-2002 Vojtech Pavlik
  *
@@ -128,7 +128,7 @@
 
 	piix_print("----------PIIX BusMastering IDE Configuration---------------");
 
-	piix_print("Driver Version:                     1.2");
+	piix_print("Driver Version:                     1.3");
 	piix_print("South Bridge:                       %s", bmide_dev->name);
 
 	pci_read_config_byte(dev, PCI_REVISION_ID, &t);
@@ -331,7 +331,7 @@
 		umul = 2;
 
 	T = 1000000000 / piix_clock;
-	UT = T / umul;
+	UT = umul ? (T / umul) : 0;
 
 	ata_timing_compute(drive, speed, &t, T, UT);
 
diff -urN linux-2.5.8-pre2/drivers/ide/qd65xx.c linux/drivers/ide/qd65xx.c
--- linux-2.5.8-pre2/drivers/ide/qd65xx.c	Mon Apr  8 21:12:44 2002
+++ linux/drivers/ide/qd65xx.c	Mon Apr  8 16:29:16 2002
@@ -411,22 +411,23 @@
 
 			return 1;
 		} else {
-			int i,j;
+			int i;
+
 			/* secondary enabled */
 			printk(KERN_INFO "%s&%s: qd6580: dual IDE board\n",
 					ide_hwifs[0].name,ide_hwifs[1].name);
 
-			for (i=0;i<2;i++) {
+			for (i = 0; i < 2; i++) {
+				int j;
 
 				ide_hwifs[i].chipset = ide_qd65xx;
-				ide_hwifs[i].mate = &ide_hwifs[i^1];
 				ide_hwifs[i].unit = i;
 
 				ide_hwifs[i].select_data = base;
 				ide_hwifs[i].config_data = config | (control <<8);
 				ide_hwifs[i].tuneproc = &qd6580_tune_drive;
 
-				for (j=0;j<2;j++) {
+				for (j = 0; j < 2; j++) {
 					ide_hwifs[i].drives[j].drive_data =
 					       i?QD6580_DEF_DATA2:QD6580_DEF_DATA;
 					ide_hwifs[i].drives[j].io_32bit = 1;
diff -urN linux-2.5.8-pre2/drivers/ide/sis5513.c linux/drivers/ide/sis5513.c
--- linux-2.5.8-pre2/drivers/ide/sis5513.c	Mon Apr  8 21:12:44 2002
+++ linux/drivers/ide/sis5513.c	Mon Apr  8 16:29:16 2002
@@ -1,17 +1,17 @@
 /*
- * linux/drivers/ide/sis5513.c		Version 0.13	March 4, 2002
+ * linux/drivers/ide/sis5513.c		Version 0.13	March 6, 2002
  *
  * Copyright (C) 1999-2000	Andre Hedrick <andre@linux-ide.org>
  * Copyright (C) 2002		Lionel Bouton <Lionel.Bouton@inet6.fr>, Maintainer
  * May be copied or modified under the terms of the GNU General Public License
  *
-*/
-
-/* Thanks :
- * For direct support and hardware : SiS Taiwan.
- * For ATA100 support advice       : Daniela Engert.
- * For checking code correctness, providing patches :
- * John Fremlin, Manfred Spraul
+ *
+ * Thanks :
+ *
+ * SiS Taiwan		: for direct support and hardware.
+ * Daniela Engert	: for initial ATA100 advices and numerous others.
+ * John Fremlin, Manfred Spraul :
+ *			  for checking code correctness, providing patches.
  */
 
 /*
@@ -52,59 +52,40 @@
 
 #include "ata-timing.h"
 
+/* When DEBUG is defined it outputs initial PCI config register
+   values and changes made to them by the driver */
 // #define DEBUG
-/* if BROKEN_LEVEL is defined it limits the DMA mode
+/* When BROKEN_LEVEL is defined it limits the DMA mode
    at boot time to its value */
 // #define BROKEN_LEVEL XFER_SW_DMA_0
 #define DISPLAY_SIS_TIMINGS
 
 /* Miscellaneaous flags */
 #define SIS5513_LATENCY		0x01
-/* ATA transfer mode capabilities */
+
+/* registers layout and init values are chipset family dependant */
+/* 1/ define families */
 #define ATA_00		0x00
 #define ATA_16		0x01
 #define ATA_33		0x02
 #define ATA_66		0x03
-#define ATA_100a	0x04
+#define ATA_100a	0x04	// SiS730 is ATA100 with ATA66 layout
 #define ATA_100		0x05
 #define ATA_133		0x06
 
-static unsigned char dma_capability = 0x00;
-
+/* 2/ variable holding the controller chipset family value */
+static unsigned char chipset_family;
 
 /*
  * Debug code: following IDE config registers' changes
  */
 #ifdef DEBUG
-/* Copy of IDE Config registers 0x00 -> 0x58
+/* Copy of IDE Config registers 0x00 -> 0x57
    Fewer might be used depending on the actual chipset */
-static unsigned char ide_regs_copy[] = {
-	0x0, 0x0, 0x0, 0x0,
-	0x0, 0x0, 0x0, 0x0,
-	0x0, 0x0, 0x0, 0x0,
-	0x0, 0x0, 0x0, 0x0,
-	0x0, 0x0, 0x0, 0x0,
-	0x0, 0x0, 0x0, 0x0,
-	0x0, 0x0, 0x0, 0x0,
-	0x0, 0x0, 0x0, 0x0,
-	0x0, 0x0, 0x0, 0x0,
-	0x0, 0x0, 0x0, 0x0,
-	0x0, 0x0, 0x0, 0x0,
-	0x0, 0x0, 0x0, 0x0,
-	0x0, 0x0, 0x0, 0x0,
-	0x0, 0x0, 0x0, 0x0,
-	0x0, 0x0, 0x0, 0x0,
-	0x0, 0x0, 0x0, 0x0,
-	0x0, 0x0, 0x0, 0x0,
-	0x0, 0x0, 0x0, 0x0,
-	0x0, 0x0, 0x0, 0x0,
-	0x0, 0x0, 0x0, 0x0,
-	0x0, 0x0, 0x0, 0x0,
-	0x0, 0x0, 0x0, 0x0
-};
+static unsigned char ide_regs_copy[0x58];
 
 static byte sis5513_max_config_register(void) {
-	switch(dma_capability) {
+	switch(chipset_family) {
 		case ATA_00:
 		case ATA_16:	return 0x4f;
 		case ATA_33:	return 0x52;
@@ -185,7 +166,7 @@
 static const struct {
 	const char *name;
 	unsigned short host_id;
-	unsigned char dma_capability;
+	unsigned char chipset_family;
 	unsigned char flags;
 } SiSHostChipInfo[] = {
 	{ "SiS750",	PCI_DEVICE_ID_SI_750,	ATA_100,	SIS5513_LATENCY },
@@ -211,7 +192,7 @@
 
 /* Cycle time bits and values vary accross chip dma capabilities
    These three arrays hold the register layout and the values to set.
-   Indexed by dma_capability and (dma_mode - XFER_UDMA_0) */
+   Indexed by chipset_family and (dma_mode - XFER_UDMA_0) */
 static byte cycle_time_offset[] = {0,0,5,4,4,0,0};
 static byte cycle_time_range[] = {0,0,2,3,3,4,4};
 static byte cycle_time_value[][XFER_UDMA_5 - XFER_UDMA_0 + 1] = {
@@ -293,13 +274,13 @@
 	pci_read_config_byte(bmide_dev, 0x45+2*pos, &reg11);
 
 /* UDMA */
-	if (dma_capability >= ATA_33) {
+	if (chipset_family >= ATA_33) {
 		p += sprintf(p, "                UDMA %s \t \t \t UDMA %s\n",
 			     (reg01 & 0x80)  ? "Enabled" : "Disabled",
 			     (reg11 & 0x80) ? "Enabled" : "Disabled");
 
 		p += sprintf(p, "                UDMA Cycle Time    ");
-		switch(dma_capability) {
+		switch(chipset_family) {
 			case ATA_33:	p += sprintf(p, cycle_time[(reg01 & 0x60) >> 5]); break;
 			case ATA_66:
 			case ATA_100a:	p += sprintf(p, cycle_time[(reg01 & 0x70) >> 4]); break;
@@ -308,7 +289,7 @@
 			default:	p += sprintf(p, "133+ ?"); break;
 		}
 		p += sprintf(p, " \t UDMA Cycle Time    ");
-		switch(dma_capability) {
+		switch(chipset_family) {
 			case ATA_33:	p += sprintf(p, cycle_time[(reg11 & 0x60) >> 5]); break;
 			case ATA_66:
 			case ATA_100a:	p += sprintf(p, cycle_time[(reg11 & 0x70) >> 4]); break;
@@ -321,7 +302,7 @@
 
 /* Data Active */
 	p += sprintf(p, "                Data Active Time   ");
-	switch(dma_capability) {
+	switch(chipset_family) {
 		case ATA_00:
 		case ATA_16: /* confirmed */
 		case ATA_33:
@@ -332,7 +313,7 @@
 		default: p += sprintf(p, "133+ ?"); break;
 	}
 	p += sprintf(p, " \t Data Active Time   ");
-	switch(dma_capability) {
+	switch(chipset_family) {
 		case ATA_00:
 		case ATA_16:
 		case ATA_33:
@@ -370,7 +351,7 @@
 	u16 reg2, reg3;
 
 	p += sprintf(p, "\nSiS 5513 ");
-	switch(dma_capability) {
+	switch(chipset_family) {
 		case ATA_00: p += sprintf(p, "Unknown???"); break;
 		case ATA_16: p += sprintf(p, "DMA 16"); break;
 		case ATA_33: p += sprintf(p, "Ultra 33"); break;
@@ -386,7 +367,7 @@
 /* Status */
 	pci_read_config_byte(bmide_dev, 0x4a, &reg);
 	p += sprintf(p, "Channel Status: ");
-	if (dma_capability < ATA_66) {
+	if (chipset_family < ATA_66) {
 		p += sprintf(p, "%s \t \t \t \t %s\n",
 			     (reg & 0x04) ? "On" : "Off",
 			     (reg & 0x02) ? "On" : "Off");
@@ -403,7 +384,7 @@
 		     (reg & 0x04) ? "Native" : "Compatible");
 
 /* 80-pin cable ? */
-	if (dma_capability > ATA_33) {
+	if (chipset_family > ATA_33) {
 		pci_read_config_byte(bmide_dev, 0x48, &reg);
 		p += sprintf(p, "Cable Type:     %s \t \t \t %s\n",
 			     (reg & 0x10) ? cable_type[1] : cable_type[0],
@@ -507,7 +488,7 @@
 	}
 
 	/* register layout changed with newer ATA100 chips */
-	if (dma_capability < ATA_100) {
+	if (chipset_family < ATA_100) {
 		pci_read_config_byte(dev, drive_pci, &test1);
 		pci_read_config_byte(dev, drive_pci+1, &test2);
 
@@ -587,7 +568,7 @@
 
 	pci_read_config_byte(dev, drive_pci+1, &reg);
 	/* Disable UDMA bit for non UDMA modes on UDMA chips */
-	if ((speed < XFER_UDMA_0) && (dma_capability > ATA_16)) {
+	if ((speed < XFER_UDMA_0) && (chipset_family > ATA_16)) {
 		reg &= 0x7F;
 		pci_write_config_byte(dev, drive_pci+1, reg);
 	}
@@ -604,11 +585,11 @@
 			/* Force the UDMA bit on if we want to use UDMA */
 			reg |= 0x80;
 			/* clean reg cycle time bits */
-			reg &= ~((0xFF >> (8 - cycle_time_range[dma_capability]))
-				 << cycle_time_offset[dma_capability]);
+			reg &= ~((0xFF >> (8 - cycle_time_range[chipset_family]))
+				 << cycle_time_offset[chipset_family]);
 			/* set reg cycle time bits */
-			reg |= cycle_time_value[dma_capability-ATA_00][speed-XFER_UDMA_0]
-				<< cycle_time_offset[dma_capability];
+			reg |= cycle_time_value[chipset_family-ATA_00][speed-XFER_UDMA_0]
+				<< cycle_time_offset[chipset_family];
 			pci_write_config_byte(dev, drive_pci+1, reg);
 			break;
 		case XFER_MW_DMA_2:
@@ -624,7 +605,7 @@
 		case XFER_PIO_2: return((int) config_chipset_for_pio(drive, 2));
 		case XFER_PIO_1: return((int) config_chipset_for_pio(drive, 1));
 		case XFER_PIO_0:
-		default:	 return((int) config_chipset_for_pio(drive, 0));	
+		default:	 return((int) config_chipset_for_pio(drive, 0));
 	}
 	drive->current_speed = speed;
 #ifdef DEBUG
@@ -657,17 +638,17 @@
 	       drive->dn, ultra);
 #endif
 
-	if ((id->dma_ultra & 0x0020) && ultra && udma_66 && (dma_capability >= ATA_100a))
+	if ((id->dma_ultra & 0x0020) && ultra && udma_66 && (chipset_family >= ATA_100a))
 		speed = XFER_UDMA_5;
-	else if ((id->dma_ultra & 0x0010) && ultra && udma_66 && (dma_capability >= ATA_66))
+	else if ((id->dma_ultra & 0x0010) && ultra && udma_66 && (chipset_family >= ATA_66))
 		speed = XFER_UDMA_4;
-	else if ((id->dma_ultra & 0x0008) && ultra && udma_66 && (dma_capability >= ATA_66))
+	else if ((id->dma_ultra & 0x0008) && ultra && udma_66 && (chipset_family >= ATA_66))
 		speed = XFER_UDMA_3;
-	else if ((id->dma_ultra & 0x0004) && ultra && (dma_capability >= ATA_33))
+	else if ((id->dma_ultra & 0x0004) && ultra && (chipset_family >= ATA_33))
 		speed = XFER_UDMA_2;
-	else if ((id->dma_ultra & 0x0002) && ultra && (dma_capability >= ATA_33))
+	else if ((id->dma_ultra & 0x0002) && ultra && (chipset_family >= ATA_33))
 		speed = XFER_UDMA_1;
-	else if ((id->dma_ultra & 0x0001) && ultra && (dma_capability >= ATA_33))
+	else if ((id->dma_ultra & 0x0001) && ultra && (chipset_family >= ATA_33))
 		speed = XFER_UDMA_0;
 	else if (id->dma_mword & 0x0004)
 		speed = XFER_MW_DMA_2;
@@ -700,6 +681,8 @@
 	struct hd_driveid *id		= drive->id;
 	ide_dma_action_t dma_func	= ide_dma_off_quietly;
 
+	config_chipset_for_pio(drive, 5);
+
 	if (id && (id->capability & 1) && drive->channel->autodma) {
 		/* Consult the list of known "bad" drives */
 		if (ide_dmaproc(ide_dma_bad_drive, drive)) {
@@ -764,10 +747,6 @@
 	struct pci_dev *host;
 	int i = 0;
 
-#ifdef DEBUG
-	sis5513_print_registers(dev, "pci_init_sis5513 start");
-#endif
-
 	/* Find the chip */
 	for (i = 0; i < ARRAY_SIZE(SiSHostChipInfo) && !host_dev; i++) {
 		host = pci_find_device (PCI_VENDOR_ID_SI,
@@ -777,12 +756,16 @@
 			continue;
 
 		host_dev = host;
-		dma_capability = SiSHostChipInfo[i].dma_capability;
+		chipset_family = SiSHostChipInfo[i].chipset_family;
 		printk(SiSHostChipInfo[i].name);
 		printk("\n");
 
+#ifdef DEBUG
+		sis5513_print_registers(dev, "pci_init_sis5513 start");
+#endif
+
 		if (SiSHostChipInfo[i].flags & SIS5513_LATENCY) {
-			byte latency = (dma_capability == ATA_100)? 0x80 : 0x10; /* Lacking specs */
+			byte latency = (chipset_family == ATA_100)? 0x80 : 0x10; /* Lacking specs */
 			pci_write_config_byte(dev, PCI_LATENCY_TIMER, latency);
 		}
 	}
@@ -792,7 +775,7 @@
 	   2/ tell old chips to allow per drive IDE timings */
 	if (host_dev) {
 		byte reg;
-		switch(dma_capability) {
+		switch(chipset_family) {
 			case ATA_133:
 			case ATA_100:
 				/* Set compatibility bit */
@@ -847,7 +830,7 @@
 	byte mask = hwif->unit ? 0x20 : 0x10;
 	pci_read_config_byte(hwif->pci_dev, 0x48, &reg48h);
 
-	if (dma_capability >= ATA_66) {
+	if (chipset_family >= ATA_66) {
 		ata66 = (reg48h & mask) ? 0 : 1;
 	}
         return ata66;
@@ -866,7 +849,7 @@
 
 	if (host_dev) {
 #ifdef CONFIG_BLK_DEV_IDEDMA
-		if (dma_capability > ATA_16) {
+		if (chipset_family > ATA_16) {
 			hwif->autodma = noautodma ? 0 : 1;
 			hwif->highmem = 1;
 			hwif->dmaproc = &sis5513_dmaproc;
diff -urN linux-2.5.8-pre2/drivers/ide/trm290.c linux/drivers/ide/trm290.c
--- linux-2.5.8-pre2/drivers/ide/trm290.c	Mon Apr  8 21:12:44 2002
+++ linux/drivers/ide/trm290.c	Mon Apr  8 19:01:19 2002
@@ -248,8 +248,19 @@
 
 	if ((reg & 0x10))
 		hwif->irq = hwif->unit ? 15 : 14;	/* legacy mode */
-	else if (!hwif->irq && hwif->mate && hwif->mate->irq)
-		hwif->irq = hwif->mate->irq;		/* sharing IRQ with mate */
+	else {
+		static int primary_irq = 0;
+
+		/* Ugly way to let the primary and secondary channel on the
+		 * chip use the same IRQ line.
+		 */
+
+		if (hwif->unit == ATA_PRIMARY)
+			primary_irq = hwif->irq;
+		else if (!hwif->irq)
+			hwif->irq = primary_irq;
+	}
+
 	ide_setup_dma(hwif, (hwif->config_data + 4) ^ (hwif->unit ? 0x0080 : 0x0000), 3);
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
diff -urN linux-2.5.8-pre2/drivers/ide/umc8672.c linux/drivers/ide/umc8672.c
--- linux-2.5.8-pre2/drivers/ide/umc8672.c	Mon Apr  8 21:12:44 2002
+++ linux/drivers/ide/umc8672.c	Mon Apr  8 16:29:16 2002
@@ -146,7 +146,7 @@
 	{
 		__restore_flags(flags);	/* local CPU only */
 		printk ("umc8672: not found\n");
-		return;  
+		return;
 	}
 	outb_p (0xa5,0x108); /* disable umc */
 
@@ -158,7 +158,6 @@
 	ide_hwifs[1].chipset = ide_umc8672;
 	ide_hwifs[0].tuneproc = &tune_umc;
 	ide_hwifs[1].tuneproc = &tune_umc;
-	ide_hwifs[0].mate = &ide_hwifs[1];
-	ide_hwifs[1].mate = &ide_hwifs[0];
-	ide_hwifs[1].unit = 1;
+	ide_hwifs[0].unit = ATA_PRIMARY;
+	ide_hwifs[1].unit = ATA_SECONDARY;
 }
diff -urN linux-2.5.8-pre2/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.8-pre2/include/linux/ide.h	Mon Apr  8 21:12:46 2002
+++ linux/include/linux/ide.h	Mon Apr  8 20:01:44 2002
@@ -433,10 +433,10 @@
 typedef void (ide_maskproc_t) (ide_drive_t *, int);
 typedef void (ide_rw_proc_t) (ide_drive_t *, ide_dma_action_t);
 
-/*
- * ide soft-power support
- */
-typedef int (ide_busproc_t) (ide_drive_t *, int);
+enum {
+	ATA_PRIMARY	= 0,
+	ATA_SECONDARY	= 1
+};
 
 struct ata_channel {
 	struct device	dev;		/* device handle */
@@ -467,7 +467,6 @@
 	struct scatterlist *sg_table;	/* Scatter-gather list used to build the above */
 	int sg_nents;			/* Current number of entries in it */
 	int sg_dma_direction;		/* dma transfer direction */
-	struct ata_channel *mate;	/* other hwif from same PCI chip */
 	unsigned long	dma_base;	/* base addr for dma ports */
 	unsigned	dma_extra;	/* extra addr for dma ports */
 	unsigned long	config_data;	/* for use by chipset-specific code */
@@ -480,7 +479,7 @@
 	hwif_chipset_t	chipset;	/* sub-module for tuning.. */
 	unsigned	noprobe    : 1;	/* don't probe for this interface */
 	unsigned	present    : 1;	/* there is a device on this interface */
-	unsigned	serialized : 1;	/* serialized operation with mate hwif */
+	unsigned	serialized : 1;	/* serialized operation between channels */
 	unsigned	sharing_irq: 1;	/* 1 = sharing irq with another hwif */
 	unsigned	reset      : 1;	/* reset after probe */
 	unsigned	autodma    : 1;	/* automatically try to enable DMA at boot */
@@ -490,7 +489,7 @@
 	unsigned long	last_time;	/* time when previous rq was done */
 #endif
 	byte		straight8;	/* Alan's straight 8 check */
-	ide_busproc_t	*busproc;	/* driver soft-power interface */
+	int (*busproc)(ide_drive_t *, int);	/* driver soft-power interface */
 	byte		bus_state;	/* power state of the IDE bus */
 };
 
@@ -513,7 +512,6 @@
  */
 typedef ide_startstop_t (ide_pre_handler_t)(ide_drive_t *, struct request *);
 typedef ide_startstop_t (ide_handler_t)(ide_drive_t *);
-typedef ide_startstop_t (ide_post_handler_t)(ide_drive_t *);
 
 /*
  * when ide_timer_expiry fires, invoke a handler of this type

--------------030202090308080606050708--

