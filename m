Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289138AbSA1IHu>; Mon, 28 Jan 2002 03:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289140AbSA1IHo>; Mon, 28 Jan 2002 03:07:44 -0500
Received: from [195.66.192.167] ([195.66.192.167]:35852 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S289138AbSA1IHf>; Mon, 28 Jan 2002 03:07:35 -0500
Message-Id: <200201280806.g0S861E21827@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: linux-kernel@vger.kernel.org
Subject: [PATCH] KERN_DIFF for IDE. Needs review.
Date: Mon, 28 Jan 2002 10:06:03 -0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Primary purpose of this patch is to make KERN_WARNING and
KERN_INFO log levels closer to their original meaning.
Today they are quite far from what was intended.
Just look what kernel writes at the WARNING level
each time you boot your box!

Diff for ide messages.
Some messages was changed to improve "greppability":
"%s: ATAPI" -> "ide-cd: %s: ATAPI".

ide-dma: had to replace single printk with pair of those
due to different loglevels.

Small fix:
strncmp(s,"hd",2) && s[2] == '='
is the same as
strncmp(s,"hd=",3) == 0
--
vda

diff --recursive -u linux-2.4.13-orig/drivers/ide/ide-cd.c linux-2.4.13-new/drivers/ide/ide-cd.c
--- linux-2.4.13-orig/drivers/ide/ide-cd.c	Thu Oct 18 18:18:22 2001
+++ linux-2.4.13-new/drivers/ide/ide-cd.c	Thu Nov  8 23:42:11 2001
@@ -2673,7 +2673,7 @@
 
 	/* don't print speed if the drive reported 0.
 	 */
-	printk("%s: ATAPI", drive->name);
+	printk(KERN_INFO "ide-cd: %s: ATAPI", drive->name);
 	if (CDROM_CONFIG_FLAGS(drive)->max_speed)
 		printk(" %dX", CDROM_CONFIG_FLAGS(drive)->max_speed);
 	printk(" %s", CDROM_CONFIG_FLAGS(drive)->dvd ? "DVD-ROM" : "CD-ROM");
@@ -2849,7 +2849,7 @@
 		set_device_ro(MKDEV(HWIF(drive)->major, minor), 0);
 
 	if (ide_cdrom_register (drive, nslots)) {
-		printk ("%s: ide_cdrom_setup failed to register device with the cdrom driver.\n", drive->name);
+		printk ("%s: ide_cdrom_setup failed to register device with the cdrom driver\n", drive->name);
 		info->devinfo.handle = NULL;
 		return 1;
 	}
@@ -2950,7 +2950,7 @@
 	if (info->changer_info != NULL)
 		kfree(info->changer_info);
 	if (devinfo->handle == drive && unregister_cdrom (devinfo))
-		printk ("%s: ide_cdrom_cleanup failed to unregister device from the cdrom driver.\n", drive->name);
+		printk ("%s: ide_cdrom_cleanup failed to unregister device from the cdrom driver\n", drive->name);
 	kfree(info);
 	drive->driver_data = NULL;
 	return 0;
@@ -3027,16 +3027,16 @@
 			}
 		}
 		if (drive->scsi) {
-			printk("ide-cd: passing drive %s to ide-scsi emulation.\n", drive->name);
+			printk("ide-cd: passing drive %s to ide-scsi emulation\n", drive->name);
 			continue;
 		}
 		info = (struct cdrom_info *) kmalloc (sizeof (struct cdrom_info), GFP_KERNEL);
 		if (info == NULL) {
-			printk ("%s: Can't allocate a cdrom structure\n", drive->name);
+			printk ("%s: can't allocate a cdrom structure\n", drive->name);
 			continue;
 		}
 		if (ide_register_subdriver (drive, &ide_cdrom_driver, IDE_SUBDRIVER_VERSION)) {
-			printk ("%s: Failed to register the driver with ide.c\n", drive->name);
+			printk ("%s: failed to register the driver with ide.c\n", drive->name);
 			kfree (info);
 			continue;
 		}
diff --recursive -u linux-2.4.13-orig/drivers/ide/ide-dma.c linux-2.4.13-new/drivers/ide/ide-dma.c
--- linux-2.4.13-orig/drivers/ide/ide-dma.c	Sun Sep  9 15:43:02 2001
+++ linux-2.4.13-new/drivers/ide/ide-dma.c	Thu Nov  8 23:42:11 2001
@@ -688,9 +688,10 @@
  
 void ide_setup_dma (ide_hwif_t *hwif, unsigned long dma_base, unsigned int num_ports)
 {
-	printk("    %s: BM-DMA at 0x%04lx-0x%04lx", hwif->name, dma_base, dma_base + num_ports - 1);
 	if (check_region(dma_base, num_ports)) {
-		printk(" -- ERROR, PORT ADDRESSES ALREADY IN USE\n");
+		printk(KERN_WARNING "    %s: BM-DMA at 0x%04lx-0x%04lx"
+			" -- ERROR, PORT ADDRESSES ALREADY IN USE\n",
+			hwif->name, dma_base, dma_base + num_ports - 1);
 		return;
 	}
 	request_region(dma_base, num_ports, hwif->name);
@@ -709,8 +710,9 @@
 		goto dma_alloc_failure;
 	}
 
+	printk(KERN_INFO "    %s: BM-DMA at 0x%04lx-0x%04lx",
+		hwif->name, dma_base, dma_base + num_ports - 1);
 	hwif->dmaproc = &ide_dmaproc;
-
 	if (hwif->chipset != ide_trm290) {
 		byte dma_stat = inb(dma_base+2);
 		printk(", BIOS settings: %s:%s, %s:%s",
@@ -721,7 +723,9 @@
 	return;
 
 dma_alloc_failure:
-	printk(" -- ERROR, UNABLE TO ALLOCATE DMA TABLES\n");
+	printk(KERN_WARNING "    %s: BM-DMA at 0x%04lx-0x%04lx"
+		" -- ERROR, UNABLE TO ALLOCATE DMA TABLES\n",
+		hwif->name, dma_base, dma_base + num_ports - 1);
 }
 
 /*
diff --recursive -u linux-2.4.13-orig/drivers/ide/ide-pci.c linux-2.4.13-new/drivers/ide/ide-pci.c
--- linux-2.4.13-orig/drivers/ide/ide-pci.c	Sun Sep 30 17:26:05 2001
+++ linux-2.4.13-new/drivers/ide/ide-pci.c	Thu Nov  8 23:42:11 2001
@@ -496,7 +496,8 @@
 		if (hwif->io_ports[IDE_DATA_OFFSET] == io_base) {
 			if (hwif->chipset == ide_unknown)
 				return hwif; /* match */
-			printk("%s: port 0x%04lx already claimed by %s\n", name, io_base, hwif->name);
+			printk(KERN_WARNING "%s: port 0x%04lx already claimed by %s\n",
+				name, io_base, hwif->name);
 			return NULL;	/* already claimed */
 		}
 	}
@@ -528,7 +529,8 @@
 		if (hwif->chipset == ide_unknown)
 			return hwif;	/* pick an unused entry */
 	}
-	printk("%s: too many IDE interfaces, no room in table\n", name);
+	printk(KERN_WARNING "%s: too many IDE interfaces, no room in table\n",
+		name);
 	return NULL;
 }
 
@@ -541,13 +543,15 @@
 	 */
 	if (pci_read_config_byte(dev, PCI_CLASS_PROG, &progif) || (progif & 5) != 5) {
 		if ((progif & 0xa) != 0xa) {
-			printk("%s: device not capable of full native PCI mode\n", name);
+			printk(KERN_INFO "%s: device not capable"
+				" of full native PCI mode\n", name);
 			return 1;
 		}
-		printk("%s: placing both ports into native PCI mode\n", name);
+		printk(KERN_INFO "%s: placing both ports into native PCI mode\n", name);
 		(void) pci_write_config_byte(dev, PCI_CLASS_PROG, progif|5);
 		if (pci_read_config_byte(dev, PCI_CLASS_PROG, &progif) || (progif & 5) != 5) {
-			printk("%s: rewrite of PROGIF failed, wanted 0x%04x, got 0x%04x\n", name, progif|5, progif);
+			printk(KERN_WARNING "%s: rewrite of PROGIF failed,"
+				" wanted 0x%04x, got 0x%04x\n", name, progif|5, progif);
 			return 1;
 		}
 	}
@@ -559,7 +563,7 @@
 		if ((res->flags & IORESOURCE_IO) == 0)
 			continue;
 		if (!res->start) {
-			printk("%s: Missing I/O address #%d\n", name, reg);
+			printk(KERN_WARNING "%s: Missing I/O address #%d\n", name, reg);
 			return 1;
 		}
 	}
@@ -594,7 +598,7 @@
 
 check_if_enabled:
 	if (pci_read_config_word(dev, PCI_COMMAND, &pcicmd)) {
-		printk("%s: error accessing PCI regs\n", d->name);
+		printk(KERN_WARNING "%s: error accessing PCI regs\n", d->name);
 		return;
 	}
 	if (!(pcicmd & PCI_COMMAND_IO)) {	/* is device disabled? */
@@ -608,14 +612,14 @@
 		if (tried_config++
 		 || ide_setup_pci_baseregs(dev, d->name)
 		 || pci_write_config_word(dev, PCI_COMMAND, pcicmd | PCI_COMMAND_IO)) {
-			printk("%s: device disabled (BIOS)\n", d->name);
+			printk(KERN_INFO "%s: device disabled (BIOS)\n", d->name);
 			return;
 		}
 		autodma = 0;	/* default DMA off if we had to configure it here */
 		goto check_if_enabled;
 	}
 	if (tried_config)
-		printk("%s: device enabled (Linux)\n", d->name);
+		printk(KERN_INFO "%s: device enabled (Linux)\n", d->name);
 
 	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
 	class_rev &= 0xff;
@@ -627,7 +631,7 @@
 		d->bootable = (pcicmd & PCI_COMMAND_MEMORY) ? OFF_BOARD : NEVER_BOARD;
 	}
 
-	printk("%s: chipset revision %d\n", d->name, class_rev);
+	printk(KERN_INFO "%s: chipset revision %d\n", d->name, class_rev);
 
 	/*
 	 * Can we trust the reported IRQ?
@@ -642,11 +646,12 @@
 		   to skip */
 		if (IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20265))
 		{
-			printk(KERN_INFO "ide: Found promise 20265 in RAID mode.\n");
+			printk(KERN_INFO "ide: found Promise 20265 in RAID mode\n");
 			if(dev->bus->self && dev->bus->self->vendor == PCI_VENDOR_ID_INTEL &&
 				dev->bus->self->device == PCI_DEVICE_ID_INTEL_I960)
 			{
-				printk(KERN_INFO "ide: Skipping Promise PDC20265 attached to I2O RAID controller.\n");
+				printk(KERN_INFO "ide: skipping Promise PDC20265"
+					" attached to I2O RAID controller\n");
 				return;
 			}
 		}
@@ -654,28 +659,32 @@
 		   Suspect a fastrak and fall through */
 	}
 	if ((dev->class & ~(0xfa)) != ((PCI_CLASS_STORAGE_IDE << 8) | 5)) {
-		printk("%s: not 100%% native mode: will probe irqs later\n", d->name);
+		printk(KERN_INFO "%s: not 100%% native mode:"
+			" will probe irqs later\n", d->name);
 		/*
 		 * This allows offboard ide-pci cards the enable a BIOS,
 		 * verify interrupt settings of split-mirror pci-config
 		 * space, place chipset into init-mode, and/or preserve
 		 * an interrupt if the card is not native ide support.
 		 */
-		pciirq = (d->init_chipset) ? d->init_chipset(dev, d->name) : ide_special_settings(dev, d->name);
+		pciirq = (d->init_chipset) ? d->init_chipset(dev, d->name)
+			: ide_special_settings(dev, d->name);
 	} else if (tried_config) {
-		printk("%s: will probe irqs later\n", d->name);
+		printk(KERN_INFO "%s: will probe irqs later\n", d->name);
 		pciirq = 0;
 	} else if (!pciirq) {
-		printk("%s: bad irq (%d): will probe later\n", d->name, pciirq);
+		printk(KERN_WARNING "%s: bad irq (%d): will probe later\n",
+			d->name, pciirq);
 		pciirq = 0;
 	} else {
 		if (d->init_chipset)
 			(void) d->init_chipset(dev, d->name);
 #ifdef __sparc__
-		printk("%s: 100%% native mode on irq %s\n",
-		       d->name, __irq_itoa(pciirq));
+		printk(KERN_INFO "%s: 100%% native mode on irq %s\n",
+			d->name, __irq_itoa(pciirq));
 #else
-		printk("%s: 100%% native mode on irq %d\n", d->name, pciirq);
+		printk(KERN_INFO "%s: 100%% native mode on irq %d\n",
+			d->name, pciirq);
 #endif
 	}
 
@@ -706,7 +715,8 @@
 			base = dev->resource[2*port].start;
 			if (!(ctl & PCI_BASE_ADDRESS_IO_MASK) ||
 			    !(base & PCI_BASE_ADDRESS_IO_MASK)) {
-				printk("%s: IO baseregs (BIOS) are reported as MEM, report to <andre@linux-ide.org>.\n", d->name);
+				printk(KERN_WARNING "%s: IO baseregs (BIOS) are reported as MEM,"
+				    " report to <andre@linux-ide.org>\n", d->name);
 #if 0
 				/* FIXME! This really should check that it really gets the IO/MEM part right! */
 				continue;
@@ -714,7 +724,8 @@
 			}
 		}
 		if ((ctl && !base) || (base && !ctl)) {
-			printk("%s: inconsistent baseregs (BIOS) for port %d, skipping\n", d->name, port);
+			printk(KERN_WARNING "%s: inconsistent baseregs (BIOS)"
+				" for port %d, skipping\n", d->name, port);
 			continue;
 		}
 		if (!ctl)
@@ -752,7 +763,8 @@
 			goto bypass_piix_dma;
 
 		if (hwif->udma_four) {
-			printk("%s: ATA-66/100 forced bit set (WARNING)!!\n", d->name);
+			printk(KERN_WARNING "%s: ATA-66/100 forced bit set"
+				" (WARNING)!!\n", d->name);
 		} else {
 			hwif->udma_four = (d->ata66_check) ? d->ata66_check(hwif) : 0;
 		}
@@ -794,7 +806,7 @@
 					hwif->autodma = 0;	/* default DMA off if we had to configure it here */
 				(void) pci_write_config_word(dev, PCI_COMMAND, pcicmd | PCI_COMMAND_MASTER);
 				if (pci_read_config_word(dev, PCI_COMMAND, &pcicmd) || !(pcicmd & PCI_COMMAND_MASTER)) {
-					printk("%s: %s error updating PCICMD\n", hwif->name, d->name);
+					printk(KERN_WARNING "%s: %s error updating PCICMD\n", hwif->name, d->name);
 					dma_base = 0;
 				}
 			}
@@ -805,7 +817,7 @@
 					ide_setup_dma(hwif, dma_base, 8);
 				}
 			} else {
-				printk("%s: %s Bus-Master DMA disabled (BIOS)\n", hwif->name, d->name);
+				printk(KERN_INFO "%s: %s Bus-Master DMA disabled (BIOS)\n", hwif->name, d->name);
 			}
 		}
 #endif	/* CONFIG_BLK_DEV_IDEDMA */
@@ -817,7 +829,7 @@
 		at_least_one_hwif_enabled = 1;
 	}
 	if (!at_least_one_hwif_enabled)
-		printk("%s: neither IDE port enabled (BIOS)\n", d->name);
+		printk(KERN_INFO "%s: neither IDE port enabled (BIOS)\n", d->name);
 }
 
 static void __init hpt366_device_order_fixup (struct pci_dev *dev, ide_pci_device_t *d)
@@ -838,7 +850,7 @@
 
 	switch(class_rev) {
 		case 4:
-		case 3:	printk("%s: IDE controller on PCI bus %02x dev %02x\n", d->name, dev->bus->number, dev->devfn);
+		case 3:	printk(KERN_INFO "%s: IDE controller on PCI bus %02x dev %02x\n", d->name, dev->bus->number, dev->devfn);
 			ide_setup_pci_device(dev, d);
 			return;
 		default:	break;
@@ -856,23 +868,23 @@
 			hpt363_shared_irq = (dev->irq == dev2->irq) ? 1 : 0;
 			if (hpt363_shared_pin && hpt363_shared_irq) {
 				d->bootable = ON_BOARD;
-				printk("%s: onboard version of chipset, pin1=%d pin2=%d\n", d->name, pin1, pin2);
+				printk(KERN_INFO "%s: onboard version of chipset, pin1=%d pin2=%d\n", d->name, pin1, pin2);
 #if 0
 				/* I forgot why I did this once, but it fixed something. */
 				pci_write_config_byte(dev2, PCI_INTERRUPT_PIN, dev->irq);
-				printk("PCI: %s: Fixing interrupt %d pin %d to ZERO \n", d->name, dev2->irq, pin2);
+				printk(KERN_WARNING "PCI: %s: Fixing interrupt %d pin %d to ZERO\n", d->name, dev2->irq, pin2);
 				pci_write_config_byte(dev2, PCI_INTERRUPT_LINE, 0);
 #endif
 			}
 			break;
 		}
 	}
-	printk("%s: IDE controller on PCI bus %02x dev %02x\n", d->name, dev->bus->number, dev->devfn);
+	printk(KERN_INFO "%s: IDE controller on PCI bus %02x dev %02x\n", d->name, dev->bus->number, dev->devfn);
 	ide_setup_pci_device(dev, d);
 	if (!dev2)
 		return;
 	d2 = d;
-	printk("%s: IDE controller on PCI bus %02x dev %02x\n", d2->name, dev2->bus->number, dev2->devfn);
+	printk(KERN_INFO "%s: IDE controller on PCI bus %02x dev %02x\n", d2->name, dev2->bus->number, dev2->devfn);
 	ide_setup_pci_device(dev2, d2);
 }
 
@@ -889,7 +901,7 @@
 	devid.did = dev->device;
 	for (d = ide_pci_chipsets; d->devid.vid && !IDE_PCI_DEVID_EQ(d->devid, devid); ++d);
 	if (d->init_hwif == IDE_IGNORE)
-		printk("%s: ignored by ide_scan_pci_device() (uses own driver)\n", d->name);
+		printk(KERN_INFO "%s: ignored by ide_scan_pci_device() (uses own driver)\n", d->name);
 	else if (IDE_PCI_DEVID_EQ(d->devid, DEVID_OPTI621V) && !(PCI_FUNC(dev->devfn) & 1))
 		return;
 	else if (IDE_PCI_DEVID_EQ(d->devid, DEVID_CY82C693) && (!(PCI_FUNC(dev->devfn) & 1) || !((dev->class >> 8) == PCI_CLASS_STORAGE_IDE)))
@@ -902,10 +914,10 @@
 		hpt366_device_order_fixup(dev, d);
 	else if (!IDE_PCI_DEVID_EQ(d->devid, IDE_PCI_DEVID_NULL) || (dev->class >> 8) == PCI_CLASS_STORAGE_IDE) {
 		if (IDE_PCI_DEVID_EQ(d->devid, IDE_PCI_DEVID_NULL))
-			printk("%s: unknown IDE controller on PCI bus %02x device %02x, VID=%04x, DID=%04x\n",
+			printk(KERN_WARNING "%s: unknown IDE controller on PCI bus %02x device %02x, VID=%04x, DID=%04x\n",
 			       d->name, dev->bus->number, dev->devfn, devid.vid, devid.did);
 		else
-			printk("%s: IDE controller on PCI bus %02x dev %02x\n", d->name, dev->bus->number, dev->devfn);
+			printk(KERN_INFO "%s: IDE controller on PCI bus %02x dev %02x\n", d->name, dev->bus->number, dev->devfn);
 		ide_setup_pci_device(dev, d);
 	}
 }
diff --recursive -u linux-2.4.13-orig/drivers/ide/ide-probe.c linux-2.4.13-new/drivers/ide/ide-probe.c
--- linux-2.4.13-orig/drivers/ide/ide-probe.c	Thu Oct 11 14:14:32 2001
+++ linux-2.4.13-new/drivers/ide/ide-probe.c	Thu Nov  8 23:42:11 2001
@@ -63,7 +63,9 @@
 	ide_fix_driveid(id);
 
 	if (id->word156 == 0x4d42) {
-		printk("%s: drive->id->word156 == 0x%04x \n", drive->name, drive->id->word156);
+		printk(KERN_INFO "ide-probe: %s:"
+			" drive->id->word156 == 0x%04x\n",
+			drive->name, drive->id->word156);
 	}
 
 	if (!drive->forced_lun)
@@ -75,7 +77,8 @@
 	 */
 	if ((id->model[0] == 'P' && id->model[1] == 'M')
 	 || (id->model[0] == 'S' && id->model[1] == 'K')) {
-		printk("%s: EATA SCSI HBA %.10s\n", drive->name, id->model);
+		printk(KERN_INFO "ide-probe: %s: EATA SCSI HBA %.10s\n",
+			drive->name, id->model);
 		drive->present = 0;
 		return;
 	}
@@ -99,7 +102,7 @@
 		return;
 
 	id->model[sizeof(id->model)-1] = '\0';	/* we depend on this a lot! */
-	printk("%s: %s, ", drive->name, id->model);
+	printk(KERN_INFO "ide-probe: %s: %s, ", drive->name, id->model);
 	drive->present = 1;
 
 	/*
@@ -311,7 +314,7 @@
 			return 4;
 	}
 #ifdef DEBUG
-	printk("probing for %s: present=%d, media=%d, probetype=%s\n",
+	printk("Probing for %s: present=%d, media=%d, probetype=%s\n",
 		drive->name, drive->present, drive->media,
 		(cmd == WIN_IDENTIFY) ? "ATA" : "ATAPI");
 #endif
@@ -713,23 +716,23 @@
 	if (!hwgroup->hwif) {
 		hwgroup->hwif = HWIF(hwgroup->drive);
 #ifdef DEBUG
-		printk("%s : Adding missed hwif to hwgroup!!\n", hwif->name);
+		printk("%s: adding missed hwif to hwgroup!!\n", hwif->name);
 #endif
 	}
 	restore_flags(flags);	/* all CPUs; safe now that hwif->hwgroup is set up */
 
 #if !defined(__mc68000__) && !defined(CONFIG_APUS) && !defined(__sparc__)
-	printk("%s at 0x%03x-0x%03x,0x%03x on irq %d", hwif->name,
+	printk(KERN_INFO "%s at 0x%03x-0x%03x,0x%03x on irq %d", hwif->name,
 		hwif->io_ports[IDE_DATA_OFFSET],
 		hwif->io_ports[IDE_DATA_OFFSET]+7,
 		hwif->io_ports[IDE_CONTROL_OFFSET], hwif->irq);
 #elif defined(__sparc__)
-	printk("%s at 0x%03lx-0x%03lx,0x%03lx on irq %s", hwif->name,
+	printk(KERN_INFO "%s at 0x%03lx-0x%03lx,0x%03lx on irq %s", hwif->name,
 		hwif->io_ports[IDE_DATA_OFFSET],
 		hwif->io_ports[IDE_DATA_OFFSET]+7,
 		hwif->io_ports[IDE_CONTROL_OFFSET], __irq_itoa(hwif->irq));
 #else
-	printk("%s at %p on irq 0x%08x", hwif->name,
+	printk(KERN_INFO "%s at %p on irq 0x%08x", hwif->name,
 		hwif->io_ports[IDE_DATA_OFFSET], hwif->irq);
 #endif /* __mc68000__ && CONFIG_APUS */
 	if (match)
@@ -850,17 +853,17 @@
 		 *	this port and try that.
 		 */
 		if (!(hwif->irq = ide_default_irq(hwif->io_ports[IDE_DATA_OFFSET]))) {
-			printk("%s: Disabled unable to get IRQ %d.\n", hwif->name, i);
+			printk("%s: disabled unable to get IRQ %d\n", hwif->name, i);
 			(void) unregister_blkdev (hwif->major, hwif->name);
 			return (hwif->present = 0);
 		}
 		if (init_irq(hwif)) {
-			printk("%s: probed IRQ %d and default IRQ %d failed.\n",
+			printk("%s: probed IRQ %d and default IRQ %d failed\n",
 				hwif->name, i, hwif->irq);
 			(void) unregister_blkdev (hwif->major, hwif->name);
 			return (hwif->present = 0);
 		}
-		printk("%s: probed IRQ %d failed, using default.\n",
+		printk("%s: probed IRQ %d failed, using default\n",
 			hwif->name, hwif->irq);
 	}
 	
diff --recursive -u linux-2.4.13-orig/drivers/ide/ide.c linux-2.4.13-new/drivers/ide/ide.c
--- linux-2.4.13-orig/drivers/ide/ide.c	Mon Oct 15 18:27:42 2001
+++ linux-2.4.13-new/drivers/ide/ide.c	Thu Nov  8 23:42:11 2001
@@ -356,7 +356,8 @@
 #endif /* CONFIG_PCI */
 		else
 			system_bus_speed = 50;	/* safe default value for VESA and PCI */
-		printk("ide: Assuming %dMHz system bus speed for PIO modes%s\n", system_bus_speed,
+		printk(KERN_INFO "ide: Assuming %dMHz system bus speed"
+			" for PIO modes%s\n", system_bus_speed,
 			idebus_parameter ? "" : "; override with idebus=xx");
 	}
 	return system_bus_speed;
@@ -3006,29 +3007,29 @@
 	const char max_hwif  = '0' + (MAX_HWIFS - 1);
 
 	
-	if (strncmp(s,"hd",2) == 0 && s[2] == '=')	/* hd= is for hd.c   */
-		return 0;				/* driver and not us */
+	if (strncmp(s,"hd=",3) == 0)	/* hd= is for hd.c   */
+		return 0;		/* driver and not us */
 
 	if (strncmp(s,"ide",3) &&
 	    strncmp(s,"idebus",6) &&
 	    strncmp(s,"hd",2))		/* hdx= & hdxlun= */
 		return 0;
 
-	printk("ide_setup: %s", s);
-	init_ide_data ();
+	printk(KERN_INFO "ide_setup: %s", s);
+	init_ide_data();
 
 #ifdef CONFIG_BLK_DEV_IDEDOUBLER
 	if (!strcmp(s, "ide=doubler")) {
 		extern int ide_doubler;
 
-		printk(" : Enabled support for IDE doublers\n");
+		printk(": enabled support for IDE doublers\n");
 		ide_doubler = 1;
 		return 1;
 	}
 #endif /* CONFIG_BLK_DEV_IDEDOUBLER */
 
 	if (!strcmp(s, "ide=nodma")) {
-		printk("IDE: Prevented DMA\n");
+		printk(": prevented DMA\n");
 		noautodma = 1;
 		return 1;
 	}
@@ -3036,7 +3037,7 @@
 #ifdef CONFIG_BLK_DEV_IDEPCI
 	if (!strcmp(s, "ide=reverse")) {
 		ide_scan_direction = 1;
-		printk(" : Enabled support for IDE inverse scan order.\n");
+		printk(": enabled support for IDE inverse scan order\n");
 		return 1;
 	}
 #endif /* CONFIG_BLK_DEV_IDEPCI */
@@ -3305,7 +3306,7 @@
 	printk(" -- BAD OPTION\n");
 	return 1;
 bad_hwif:
-	printk("-- NOT SUPPORTED ON ide%d", hw);
+	printk(" -- NOT SUPPORTED ON ide%d", hw);
 done:
 	printk("\n");
 	return 1;
