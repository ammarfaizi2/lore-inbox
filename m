Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261464AbUL3AWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbUL3AWQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 19:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261459AbUL3AWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 19:22:16 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:3206 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261468AbUL3ANE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 19:13:04 -0500
Date: Thu, 30 Dec 2004 01:09:30 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch 2.6.10-bk1 5/5] pci-ide: make device drivers code aware of the changes made to ide_setup_pci_device{s}
Message-ID: <20041230000930.GD2217@electric-eye.fr.zoreil.com>
References: <1104158258.20952.44.camel@localhost.localdomain> <20041228205553.GA18525@electric-eye.fr.zoreil.com> <58cb370e04122813152759d94f@mail.gmail.com> <20041230000302.GA4267@electric-eye.fr.zoreil.com> <20041230000455.GA2217@electric-eye.fr.zoreil.com> <20041230000622.GB2217@electric-eye.fr.zoreil.com> <20041230000752.GC2217@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041230000752.GC2217@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- nothing clever here: the most noticeable change is the change of
  returned value for (*init_setup) in struct ide_pci_device_s which
  goes from void to int. Anything else is editing and checking for
  errors in the output of the compiler;
- pci_disable_device() added for the error path in pci_init_sgiioc4();
- BUG() removed in amd74xx_probe(): good old printk() is enough.

Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>

diff -puN drivers/ide/pci/aec62xx.c~ata-040 drivers/ide/pci/aec62xx.c
--- linux-2.6.10-bk1/drivers/ide/pci/aec62xx.c~ata-040	2004-12-29 23:58:31.915940151 +0100
+++ linux-2.6.10-bk1-fr/drivers/ide/pci/aec62xx.c	2004-12-29 23:58:32.012924318 +0100
@@ -321,12 +321,12 @@ static void __devinit init_dma_aec62xx(i
 	ide_setup_dma(hwif, dmabase, 8);
 }
 
-static void __devinit init_setup_aec62xx(struct pci_dev *dev, ide_pci_device_t *d)
+static int __devinit init_setup_aec62xx(struct pci_dev *dev, ide_pci_device_t *d)
 {
-	ide_setup_pci_device(dev, d);
+	return ide_setup_pci_device(dev, d);
 }
 
-static void __devinit init_setup_aec6x80(struct pci_dev *dev, ide_pci_device_t *d)
+static int __devinit init_setup_aec6x80(struct pci_dev *dev, ide_pci_device_t *d)
 {
 	unsigned long bar4reg = pci_resource_start(dev, 4);
 
@@ -340,7 +340,7 @@ static void __devinit init_setup_aec6x80
 			strcpy(d->name, "AEC6280R");
 	}
 
-	ide_setup_pci_device(dev, d);
+	return ide_setup_pci_device(dev, d);
 }
 
 /**
@@ -356,8 +356,7 @@ static int __devinit aec62xx_init_one(st
 {
 	ide_pci_device_t *d = &aec62xx_chipsets[id->driver_data];
 
-	d->init_setup(dev, d);
-	return 0;
+	return d->init_setup(dev, d);
 }
 
 static struct pci_device_id aec62xx_pci_tbl[] = {
diff -puN drivers/ide/pci/alim15x3.c~ata-040 drivers/ide/pci/alim15x3.c
--- linux-2.6.10-bk1/drivers/ide/pci/alim15x3.c~ata-040	2004-12-29 23:58:31.918939662 +0100
+++ linux-2.6.10-bk1-fr/drivers/ide/pci/alim15x3.c	2004-12-29 23:58:32.013924155 +0100
@@ -884,8 +884,7 @@ static int __devinit alim15x3_init_one(s
 #if defined(CONFIG_SPARC64)
 	d->init_hwif = init_hwif_common_ali15x3;
 #endif /* CONFIG_SPARC64 */
-	ide_setup_pci_device(dev, d);
-	return 0;
+	return ide_setup_pci_device(dev, d);
 }
 
 
diff -puN drivers/ide/pci/amd74xx.c~ata-040 drivers/ide/pci/amd74xx.c
--- linux-2.6.10-bk1/drivers/ide/pci/amd74xx.c~ata-040	2004-12-29 23:58:31.920939335 +0100
+++ linux-2.6.10-bk1-fr/drivers/ide/pci/amd74xx.c	2004-12-29 23:58:32.014923992 +0100
@@ -493,9 +493,12 @@ static int __devinit amd74xx_probe(struc
 {
 	amd_chipset = amd74xx_chipsets + id->driver_data;
 	amd_config = amd_ide_chips + id->driver_data;
-	if (dev->device != amd_config->id) BUG();
-	ide_setup_pci_device(dev, amd_chipset);
-	return 0;
+	if (dev->device != amd_config->id) {
+		printk(KERN_ERR "%s: assertion 0x%02x == 0x%02x failed !\n",
+		       pci_name(dev), dev->device, amd_config->id);
+		return -ENODEV;
+	}
+	return ide_setup_pci_device(dev, amd_chipset);
 }
 
 static struct pci_device_id amd74xx_pci_tbl[] = {
diff -puN drivers/ide/pci/atiixp.c~ata-040 drivers/ide/pci/atiixp.c
--- linux-2.6.10-bk1/drivers/ide/pci/atiixp.c~ata-040	2004-12-29 23:58:31.923938846 +0100
+++ linux-2.6.10-bk1-fr/drivers/ide/pci/atiixp.c	2004-12-29 23:58:32.014923992 +0100
@@ -341,8 +341,7 @@ static ide_pci_device_t atiixp_pci_info[
 
 static int __devinit atiixp_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_setup_pci_device(dev, &atiixp_pci_info[id->driver_data]);
-	return 0;
+	return ide_setup_pci_device(dev, &atiixp_pci_info[id->driver_data]);
 }
 
 static struct pci_device_id atiixp_pci_tbl[] = {
diff -puN drivers/ide/pci/cmd64x.c~ata-040 drivers/ide/pci/cmd64x.c
--- linux-2.6.10-bk1/drivers/ide/pci/cmd64x.c~ata-040	2004-12-29 23:58:31.926938356 +0100
+++ linux-2.6.10-bk1-fr/drivers/ide/pci/cmd64x.c	2004-12-29 23:58:32.015923829 +0100
@@ -709,8 +709,7 @@ static void __devinit init_hwif_cmd64x(i
 
 static int __devinit cmd64x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_setup_pci_device(dev, &cmd64x_chipsets[id->driver_data]);
-	return 0;
+	return ide_setup_pci_device(dev, &cmd64x_chipsets[id->driver_data]);
 }
 
 static struct pci_device_id cmd64x_pci_tbl[] = {
diff -puN drivers/ide/pci/cs5530.c~ata-040 drivers/ide/pci/cs5530.c
--- linux-2.6.10-bk1/drivers/ide/pci/cs5530.c~ata-040	2004-12-29 23:58:31.929937866 +0100
+++ linux-2.6.10-bk1-fr/drivers/ide/pci/cs5530.c	2004-12-29 23:58:32.016923665 +0100
@@ -357,8 +357,7 @@ static ide_pci_device_t cs5530_chipset _
 
 static int __devinit cs5530_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_setup_pci_device(dev, &cs5530_chipset);
-	return 0;
+	return ide_setup_pci_device(dev, &cs5530_chipset);
 }
 
 static struct pci_device_id cs5530_pci_tbl[] = {
diff -puN drivers/ide/pci/cy82c693.c~ata-040 drivers/ide/pci/cy82c693.c
--- linux-2.6.10-bk1/drivers/ide/pci/cy82c693.c~ata-040	2004-12-29 23:58:31.932937377 +0100
+++ linux-2.6.10-bk1-fr/drivers/ide/pci/cy82c693.c	2004-12-29 23:58:32.016923665 +0100
@@ -426,15 +426,16 @@ static int __devinit cy82c693_init_one(s
 {
 	ide_pci_device_t *d = &cy82c693_chipsets[id->driver_data];
 	struct pci_dev *dev2;
+	int ret = -ENODEV;
 
 	/* CY82C693 is more than only a IDE controller.
 	   Function 1 is primary IDE channel, function 2 - secondary. */
         if ((dev->class >> 8) == PCI_CLASS_STORAGE_IDE &&
 	    PCI_FUNC(dev->devfn) == 1) {
 		dev2 = pci_find_slot(dev->bus->number, dev->devfn + 1);
-		ide_setup_pci_devices(dev, dev2, d);
+		ret = ide_setup_pci_devices(dev, dev2, d);
 	}
-	return 0;
+	return ret;
 }
 
 static struct pci_device_id cy82c693_pci_tbl[] = {
diff -puN drivers/ide/pci/generic.c~ata-040 drivers/ide/pci/generic.c
--- linux-2.6.10-bk1/drivers/ide/pci/generic.c~ata-040	2004-12-29 23:58:31.934937050 +0100
+++ linux-2.6.10-bk1-fr/drivers/ide/pci/generic.c	2004-12-29 23:58:32.017923502 +0100
@@ -96,25 +96,27 @@ static int __devinit generic_init_one(st
 {
 	ide_pci_device_t *d = &generic_chipsets[id->driver_data];
 	u16 command;
+	int ret = -ENODEV;
 
 	if (dev->vendor == PCI_VENDOR_ID_UMC &&
 	    dev->device == PCI_DEVICE_ID_UMC_UM8886A &&
 	    (!(PCI_FUNC(dev->devfn) & 1)))
-		return -ENODEV; /* UM8886A/BF pair */
+		goto out; /* UM8886A/BF pair */
 
 	if (dev->vendor == PCI_VENDOR_ID_OPTI &&
 	    dev->device == PCI_DEVICE_ID_OPTI_82C558 &&
 	    (!(PCI_FUNC(dev->devfn) & 1)))
-		return -EAGAIN;
+		goto out;
 
 	pci_read_config_word(dev, PCI_COMMAND, &command);
-	if(!(command & PCI_COMMAND_IO))
-	{
+	if(!(command & PCI_COMMAND_IO)) {
 		printk(KERN_INFO "Skipping disabled %s IDE controller.\n", d->name);
-		return -EAGAIN; 
+		ret = -EAGAIN; 
+		goto out;
 	}
-	ide_setup_pci_device(dev, d);
-	return 0;
+	ret = ide_setup_pci_device(dev, d);
+out:
+	return ret;
 }
 
 static struct pci_device_id generic_pci_tbl[] = {
diff -puN drivers/ide/pci/hpt34x.c~ata-040 drivers/ide/pci/hpt34x.c
--- linux-2.6.10-bk1/drivers/ide/pci/hpt34x.c~ata-040	2004-12-29 23:58:31.937936560 +0100
+++ linux-2.6.10-bk1-fr/drivers/ide/pci/hpt34x.c	2004-12-29 23:58:32.017923502 +0100
@@ -251,8 +251,7 @@ static int __devinit hpt34x_init_one(str
 	d->name = chipset_names[(pcicmd & PCI_COMMAND_MEMORY) ? 1 : 0];
 	d->bootable = (pcicmd & PCI_COMMAND_MEMORY) ? OFF_BOARD : NEVER_BOARD;
 
-	ide_setup_pci_device(dev, d);
-	return 0;
+	return ide_setup_pci_device(dev, d);
 }
 
 static struct pci_device_id hpt34x_pci_tbl[] = {
diff -puN drivers/ide/pci/hpt366.c~ata-040 drivers/ide/pci/hpt366.c
--- linux-2.6.10-bk1/drivers/ide/pci/hpt366.c~ata-040	2004-12-29 23:58:31.940936071 +0100
+++ linux-2.6.10-bk1-fr/drivers/ide/pci/hpt366.c	2004-12-29 23:58:32.019923176 +0100
@@ -1191,12 +1191,12 @@ static void __devinit init_dma_hpt366(id
 	ide_setup_dma(hwif, dmabase, 8);
 }
 
-static void __devinit init_setup_hpt374(struct pci_dev *dev, ide_pci_device_t *d)
+static int __devinit init_setup_hpt374(struct pci_dev *dev, ide_pci_device_t *d)
 {
 	struct pci_dev *findev = NULL;
 
 	if (PCI_FUNC(dev->devfn) & 1)
-		return;
+		return -ENODEV;
 
 	while ((findev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, findev)) != NULL) {
 		if ((findev->vendor == dev->vendor) &&
@@ -1209,19 +1209,18 @@ static void __devinit init_setup_hpt374(
 				printk(KERN_WARNING "%s: pci-config space interrupt "
 					"fixed.\n", d->name);
 			}
-			ide_setup_pci_devices(dev, findev, d);
-			return;
+			return ide_setup_pci_devices(dev, findev, d);
 		}
 	}
-	ide_setup_pci_device(dev, d);
+	return ide_setup_pci_device(dev, d);
 }
 
-static void __devinit init_setup_hpt37x(struct pci_dev *dev, ide_pci_device_t *d)
+static int __devinit init_setup_hpt37x(struct pci_dev *dev, ide_pci_device_t *d)
 {
-	ide_setup_pci_device(dev, d);
+	return ide_setup_pci_device(dev, d);
 }
 
-static void __devinit init_setup_hpt366(struct pci_dev *dev, ide_pci_device_t *d)
+static int __devinit init_setup_hpt366(struct pci_dev *dev, ide_pci_device_t *d)
 {
 	struct pci_dev *findev = NULL;
 	u8 pin1 = 0, pin2 = 0;
@@ -1231,7 +1230,7 @@ static void __devinit init_setup_hpt366(
 				 "HPT372N" };
 
 	if (PCI_FUNC(dev->devfn) & 1)
-		return;
+		return -ENODEV;
 
 	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
 	class_rev &= 0xff;
@@ -1246,9 +1245,10 @@ static void __devinit init_setup_hpt366(
 		case 6:
 		case 5:
 		case 4:
-		case 3: ide_setup_pci_device(dev, d);
-			return;
-		default:	break;
+		case 3:
+			goto init_single;
+		default:
+			break;
 	}
 
 	d->channels = 1;
@@ -1266,11 +1266,11 @@ static void __devinit init_setup_hpt366(
 					"pin1=%d pin2=%d\n", d->name,
 					pin1, pin2);
 			}
-			ide_setup_pci_devices(dev, findev, d);
-			return;
+			return ide_setup_pci_devices(dev, findev, d);
 		}
 	}
-	ide_setup_pci_device(dev, d);
+init_single:
+	return ide_setup_pci_device(dev, d);
 }
 
 
@@ -1287,8 +1287,7 @@ static int __devinit hpt366_init_one(str
 {
 	ide_pci_device_t *d = &hpt366_chipsets[id->driver_data];
 
-	d->init_setup(dev, d);
-	return 0;
+	return d->init_setup(dev, d);
 }
 
 static struct pci_device_id hpt366_pci_tbl[] = {
diff -puN drivers/ide/pci/it8172.c~ata-040 drivers/ide/pci/it8172.c
--- linux-2.6.10-bk1/drivers/ide/pci/it8172.c~ata-040	2004-12-29 23:58:31.943935581 +0100
+++ linux-2.6.10-bk1-fr/drivers/ide/pci/it8172.c	2004-12-29 23:58:32.019923176 +0100
@@ -270,9 +270,8 @@ static int __devinit it8172_init_one(str
 {
         if ((!(PCI_FUNC(dev->devfn) & 1) ||
             (!((dev->class >> 8) == PCI_CLASS_STORAGE_IDE))))
-                return 1; /* IT8172 is more than only a IDE controller */
-	ide_setup_pci_device(dev, &it8172_chipsets[id->driver_data]);
-	return 0;
+                return -ENODEV; /* IT8172 is more than only a IDE controller */
+	return ide_setup_pci_device(dev, &it8172_chipsets[id->driver_data]);
 }
 
 static struct pci_device_id it8172_pci_tbl[] = {
diff -puN drivers/ide/pci/ns87415.c~ata-040 drivers/ide/pci/ns87415.c
--- linux-2.6.10-bk1/drivers/ide/pci/ns87415.c~ata-040	2004-12-29 23:58:31.946935091 +0100
+++ linux-2.6.10-bk1-fr/drivers/ide/pci/ns87415.c	2004-12-29 23:58:32.020923012 +0100
@@ -288,8 +288,7 @@ static ide_pci_device_t ns87415_chipset 
 
 static int __devinit ns87415_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_setup_pci_device(dev, &ns87415_chipset);
-	return 0;
+	return ide_setup_pci_device(dev, &ns87415_chipset);
 }
 
 static struct pci_device_id ns87415_pci_tbl[] = {
diff -puN drivers/ide/pci/opti621.c~ata-040 drivers/ide/pci/opti621.c
--- linux-2.6.10-bk1/drivers/ide/pci/opti621.c~ata-040	2004-12-29 23:58:31.948934765 +0100
+++ linux-2.6.10-bk1-fr/drivers/ide/pci/opti621.c	2004-12-29 23:58:32.020923012 +0100
@@ -348,15 +348,14 @@ static void __init init_hwif_opti621 (id
 	hwif->drives[1].autodma = hwif->autodma;
 }
 
-static void __init init_setup_opti621 (struct pci_dev *dev, ide_pci_device_t *d)
+static int __init init_setup_opti621 (struct pci_dev *dev, ide_pci_device_t *d)
 {
-	ide_setup_pci_device(dev, d);
+	return ide_setup_pci_device(dev, d);
 }
 
 static int __devinit opti621_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_setup_pci_device(dev, &opti621_chipsets[id->driver_data]);
-	return 0;
+	return ide_setup_pci_device(dev, &opti621_chipsets[id->driver_data]);
 }
 
 static struct pci_device_id opti621_pci_tbl[] = {
diff -puN drivers/ide/pci/pdc202xx_new.c~ata-040 drivers/ide/pci/pdc202xx_new.c
--- linux-2.6.10-bk1/drivers/ide/pci/pdc202xx_new.c~ata-040	2004-12-29 23:58:31.951934275 +0100
+++ linux-2.6.10-bk1-fr/drivers/ide/pci/pdc202xx_new.c	2004-12-29 23:58:32.021922849 +0100
@@ -316,21 +316,21 @@ static void __devinit init_hwif_pdc202ne
 #endif /* PDC202_DEBUG_CABLE */
 }
 
-static void __devinit init_setup_pdcnew(struct pci_dev *dev, ide_pci_device_t *d)
+static int __devinit init_setup_pdcnew(struct pci_dev *dev, ide_pci_device_t *d)
 {
-	ide_setup_pci_device(dev, d);
+	return ide_setup_pci_device(dev, d);
 }
 
-static void __devinit init_setup_pdc20270(struct pci_dev *dev, ide_pci_device_t *d)
+static int __devinit init_setup_pdc20270(struct pci_dev *dev,
+					 ide_pci_device_t *d)
 {
 	struct pci_dev *findev = NULL;
 
 	if ((dev->bus->self &&
 	     dev->bus->self->vendor == PCI_VENDOR_ID_DEC) &&
 	    (dev->bus->self->device == PCI_DEVICE_ID_DEC_21150)) {
-		if (PCI_SLOT(dev->devfn) & 2) {
-			return;
-		}
+		if (PCI_SLOT(dev->devfn) & 2)
+			return -ENODEV;
 		d->extra = 0;
 		while ((findev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, findev)) != NULL) {
 			if ((findev->vendor == dev->vendor) &&
@@ -339,15 +339,15 @@ static void __devinit init_setup_pdc2027
 				if (findev->irq != dev->irq) {
 					findev->irq = dev->irq;
 				}
-				ide_setup_pci_devices(dev, findev, d);
-				return;
+				return ide_setup_pci_devices(dev, findev, d);
 			}
 		}
 	}
-	ide_setup_pci_device(dev, d);
+	return ide_setup_pci_device(dev, d);
 }
 
-static void __devinit init_setup_pdc20276(struct pci_dev *dev, ide_pci_device_t *d)
+static int __devinit init_setup_pdc20276(struct pci_dev *dev,
+					 ide_pci_device_t *d)
 {
 	if ((dev->bus->self) &&
 	    (dev->bus->self->vendor == PCI_VENDOR_ID_INTEL) &&
@@ -355,9 +355,9 @@ static void __devinit init_setup_pdc2027
 	     (dev->bus->self->device == PCI_DEVICE_ID_INTEL_I960RM))) {
 		printk(KERN_INFO "ide: Skipping Promise PDC20276 "
 			"attached to I2O RAID controller.\n");
-		return;
+		return -ENODEV;
 	}
-	ide_setup_pci_device(dev, d);
+	return ide_setup_pci_device(dev, d);
 }
 
 /**
@@ -373,8 +373,7 @@ static int __devinit pdc202new_init_one(
 {
 	ide_pci_device_t *d = &pdcnew_chipsets[id->driver_data];
 
-	d->init_setup(dev, d);
-	return 0;
+	return d->init_setup(dev, d);
 }
 
 static struct pci_device_id pdc202new_pci_tbl[] = {
diff -puN drivers/ide/pci/pdc202xx_old.c~ata-040 drivers/ide/pci/pdc202xx_old.c
--- linux-2.6.10-bk1/drivers/ide/pci/pdc202xx_old.c~ata-040	2004-12-29 23:58:31.954933785 +0100
+++ linux-2.6.10-bk1-fr/drivers/ide/pci/pdc202xx_old.c	2004-12-29 23:58:32.022922686 +0100
@@ -658,7 +658,8 @@ static void __devinit init_dma_pdc202xx(
 	ide_setup_dma(hwif, dmabase, 8);
 }
 
-static void __devinit init_setup_pdc202ata4(struct pci_dev *dev, ide_pci_device_t *d)
+static int __devinit init_setup_pdc202ata4(struct pci_dev *dev,
+					   ide_pci_device_t *d)
 {
 	if ((dev->class >> 8) != PCI_CLASS_STORAGE_IDE) {
 		u8 irq = 0, irq2 = 0;
@@ -685,10 +686,11 @@ static void __devinit init_setup_pdc202a
         }
 #endif
 
-	ide_setup_pci_device(dev, d);
+	return ide_setup_pci_device(dev, d);
 }
 
-static void __devinit init_setup_pdc20265(struct pci_dev *dev, ide_pci_device_t *d)
+static int __devinit init_setup_pdc20265(struct pci_dev *dev,
+					 ide_pci_device_t *d)
 {
 	if ((dev->bus->self) &&
 	    (dev->bus->self->vendor == PCI_VENDOR_ID_INTEL) &&
@@ -696,7 +698,7 @@ static void __devinit init_setup_pdc2026
 	     (dev->bus->self->device == PCI_DEVICE_ID_INTEL_I960RM))) {
 		printk(KERN_INFO "ide: Skipping Promise PDC20265 "
 			"attached to I2O RAID controller.\n");
-		return;
+		return -ENODEV;
 	}
 
 #if 0
@@ -714,12 +716,13 @@ static void __devinit init_setup_pdc2026
         }
 #endif
 
-	ide_setup_pci_device(dev, d);
+	return ide_setup_pci_device(dev, d);
 }
 
-static void __devinit init_setup_pdc202xx(struct pci_dev *dev, ide_pci_device_t *d)
+static int __devinit init_setup_pdc202xx(struct pci_dev *dev,
+					 ide_pci_device_t *d)
 {
-	ide_setup_pci_device(dev, d);
+	return ide_setup_pci_device(dev, d);
 }
 
 /**
@@ -735,8 +738,7 @@ static int __devinit pdc202xx_init_one(s
 {
 	ide_pci_device_t *d = &pdc202xx_chipsets[id->driver_data];
 
-	d->init_setup(dev, d);
-	return 0;
+	return d->init_setup(dev, d);
 }
 
 static struct pci_device_id pdc202xx_pci_tbl[] = {
diff -puN drivers/ide/pci/piix.c~ata-040 drivers/ide/pci/piix.c
--- linux-2.6.10-bk1/drivers/ide/pci/piix.c~ata-040	2004-12-29 23:58:31.957933296 +0100
+++ linux-2.6.10-bk1-fr/drivers/ide/pci/piix.c	2004-12-29 23:58:32.023922523 +0100
@@ -535,9 +535,9 @@ static void __devinit init_hwif_piix(ide
  *	a standard ide PCI setup
  */
 
-static void __devinit init_setup_piix(struct pci_dev *dev, ide_pci_device_t *d)
+static int __devinit init_setup_piix(struct pci_dev *dev, ide_pci_device_t *d)
 {
-	ide_setup_pci_device(dev, d);
+	return ide_setup_pci_device(dev, d);
 }
 
 /**
@@ -553,8 +553,7 @@ static int __devinit piix_init_one(struc
 {
 	ide_pci_device_t *d = &piix_pci_info[id->driver_data];
 
-	d->init_setup(dev, d);
-	return 0;
+	return d->init_setup(dev, d);
 }
 
 /**
diff -puN drivers/ide/pci/rz1000.c~ata-040 drivers/ide/pci/rz1000.c
--- linux-2.6.10-bk1/drivers/ide/pci/rz1000.c~ata-040	2004-12-29 23:58:31.959932969 +0100
+++ linux-2.6.10-bk1-fr/drivers/ide/pci/rz1000.c	2004-12-29 23:58:32.023922523 +0100
@@ -62,8 +62,7 @@ static ide_pci_device_t rz1000_chipset _
 
 static int __devinit rz1000_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_setup_pci_device(dev, &rz1000_chipset);
-	return 0;
+	return ide_setup_pci_device(dev, &rz1000_chipset);
 }
 
 static struct pci_device_id rz1000_pci_tbl[] = {
diff -puN drivers/ide/pci/sc1200.c~ata-040 drivers/ide/pci/sc1200.c
--- linux-2.6.10-bk1/drivers/ide/pci/sc1200.c~ata-040	2004-12-29 23:58:31.962932480 +0100
+++ linux-2.6.10-bk1-fr/drivers/ide/pci/sc1200.c	2004-12-29 23:58:32.024922359 +0100
@@ -489,8 +489,7 @@ static ide_pci_device_t sc1200_chipset _
 
 static int __devinit sc1200_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_setup_pci_device(dev, &sc1200_chipset);
-	return 0;
+	return ide_setup_pci_device(dev, &sc1200_chipset);
 }
 
 static struct pci_device_id sc1200_pci_tbl[] = {
diff -puN drivers/ide/pci/serverworks.c~ata-040 drivers/ide/pci/serverworks.c
--- linux-2.6.10-bk1/drivers/ide/pci/serverworks.c~ata-040	2004-12-29 23:58:31.965931990 +0100
+++ linux-2.6.10-bk1-fr/drivers/ide/pci/serverworks.c	2004-12-29 23:58:32.024922359 +0100
@@ -566,12 +566,12 @@ static void __init init_dma_svwks (ide_h
 	ide_setup_dma(hwif, dmabase, 8);
 }
 
-static void __init init_setup_svwks (struct pci_dev *dev, ide_pci_device_t *d)
+static int __init init_setup_svwks (struct pci_dev *dev, ide_pci_device_t *d)
 {
-	ide_setup_pci_device(dev, d);
+	return ide_setup_pci_device(dev, d);
 }
 
-static void __init init_setup_csb6 (struct pci_dev *dev, ide_pci_device_t *d)
+static int __init init_setup_csb6 (struct pci_dev *dev, ide_pci_device_t *d)
 {
 	if (!(PCI_FUNC(dev->devfn) & 1)) {
 		d->bootable = NEVER_BOARD;
@@ -579,7 +579,7 @@ static void __init init_setup_csb6 (stru
 			d->bootable = ON_BOARD;
 	} else {
 		if ((dev->class >> 8) != PCI_CLASS_STORAGE_IDE)
-			return;
+			return -ENODEV;
 	}
 #if 0
 	if ((IDE_PCI_DEVID_EQ(d->devid, DEVID_CSB6) &&
@@ -591,7 +591,7 @@ static void __init init_setup_csb6 (stru
 			dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2) &&
 		       (!(PCI_FUNC(dev->devfn) & 1))) ? 1 : 2;
 
-	ide_setup_pci_device(dev, d);
+	return ide_setup_pci_device(dev, d);
 }
 
 
@@ -608,8 +608,7 @@ static int __devinit svwks_init_one(stru
 {
 	ide_pci_device_t *d = &serverworks_chipsets[id->driver_data];
 
-	d->init_setup(dev, d);
-	return 0;
+	return d->init_setup(dev, d);
 }
 
 static struct pci_device_id svwks_pci_tbl[] = {
diff -puN drivers/ide/pci/sgiioc4.c~ata-040 drivers/ide/pci/sgiioc4.c
--- linux-2.6.10-bk1/drivers/ide/pci/sgiioc4.c~ata-040	2004-12-29 23:58:31.968931500 +0100
+++ linux-2.6.10-bk1-fr/drivers/ide/pci/sgiioc4.c	2004-12-29 23:58:32.025922196 +0100
@@ -681,12 +681,14 @@ static unsigned int __devinit
 pci_init_sgiioc4(struct pci_dev *dev, ide_pci_device_t * d)
 {
 	unsigned int class_rev;
+	int ret;
 
-	if (pci_enable_device(dev)) {
+	ret = pci_enable_device(dev);
+	if (ret < 0) {
 		printk(KERN_ERR
 		       "Failed to enable device %s at slot %s\n",
 		       d->name, dev->slot_name);
-		return -ENODEV;
+		goto out;
 	}
 	pci_set_master(dev);
 
@@ -698,9 +700,18 @@ pci_init_sgiioc4(struct pci_dev *dev, id
 		printk(KERN_ERR "Skipping %s IDE controller in slot %s: "
 			"firmware is obsolete - please upgrade to revision"
 			"46 or higher\n", d->name, dev->slot_name);
-		return -ENODEV;
+		ret = -EAGAIN;
+		goto err_disable;
 	}
-	return sgiioc4_ide_setup_pci_device(dev, d);
+	ret = sgiioc4_ide_setup_pci_device(dev, d);
+	if (ret < 0)
+		goto err_disable;
+out:
+	return ret;
+
+err_disable:
+	pci_disable_device(dev);
+	goto out;
 }
 
 static ide_pci_device_t sgiioc4_chipsets[] __devinitdata = {
diff -puN drivers/ide/pci/siimage.c~ata-040 drivers/ide/pci/siimage.c
--- linux-2.6.10-bk1/drivers/ide/pci/siimage.c~ata-040	2004-12-29 23:58:31.971931011 +0100
+++ linux-2.6.10-bk1-fr/drivers/ide/pci/siimage.c	2004-12-29 23:58:32.026922033 +0100
@@ -1102,8 +1102,7 @@ static ide_pci_device_t siimage_chipsets
  
 static int __devinit siimage_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_setup_pci_device(dev, &siimage_chipsets[id->driver_data]);
-	return 0;
+	return ide_setup_pci_device(dev, &siimage_chipsets[id->driver_data]);
 }
 
 static struct pci_device_id siimage_pci_tbl[] = {
diff -puN drivers/ide/pci/sis5513.c~ata-040 drivers/ide/pci/sis5513.c
--- linux-2.6.10-bk1/drivers/ide/pci/sis5513.c~ata-040	2004-12-29 23:58:31.974930521 +0100
+++ linux-2.6.10-bk1-fr/drivers/ide/pci/sis5513.c	2004-12-29 23:58:32.027921870 +0100
@@ -946,8 +946,7 @@ static ide_pci_device_t sis5513_chipset 
 
 static int __devinit sis5513_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_setup_pci_device(dev, &sis5513_chipset);
-	return 0;
+	return ide_setup_pci_device(dev, &sis5513_chipset);
 }
 
 static struct pci_device_id sis5513_pci_tbl[] = {
diff -puN drivers/ide/pci/sl82c105.c~ata-040 drivers/ide/pci/sl82c105.c
--- linux-2.6.10-bk1/drivers/ide/pci/sl82c105.c~ata-040	2004-12-29 23:58:31.976930194 +0100
+++ linux-2.6.10-bk1-fr/drivers/ide/pci/sl82c105.c	2004-12-29 23:58:32.028921707 +0100
@@ -490,8 +490,7 @@ static ide_pci_device_t sl82c105_chipset
 
 static int __devinit sl82c105_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_setup_pci_device(dev, &sl82c105_chipset);
-	return 0;
+	return ide_setup_pci_device(dev, &sl82c105_chipset);
 }
 
 static struct pci_device_id sl82c105_pci_tbl[] = {
diff -puN drivers/ide/pci/slc90e66.c~ata-040 drivers/ide/pci/slc90e66.c
--- linux-2.6.10-bk1/drivers/ide/pci/slc90e66.c~ata-040	2004-12-29 23:58:31.979929705 +0100
+++ linux-2.6.10-bk1-fr/drivers/ide/pci/slc90e66.c	2004-12-29 23:58:32.028921707 +0100
@@ -246,8 +246,7 @@ static ide_pci_device_t slc90e66_chipset
 
 static int __devinit slc90e66_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_setup_pci_device(dev, &slc90e66_chipset);
-	return 0;
+	return ide_setup_pci_device(dev, &slc90e66_chipset);
 }
 
 static struct pci_device_id slc90e66_pci_tbl[] = {
diff -puN drivers/ide/pci/triflex.c~ata-040 drivers/ide/pci/triflex.c
--- linux-2.6.10-bk1/drivers/ide/pci/triflex.c~ata-040	2004-12-29 23:58:31.982929215 +0100
+++ linux-2.6.10-bk1-fr/drivers/ide/pci/triflex.c	2004-12-29 23:58:32.029921543 +0100
@@ -158,9 +158,7 @@ static ide_pci_device_t triflex_device _
 static int __devinit triflex_init_one(struct pci_dev *dev, 
 		const struct pci_device_id *id)
 {
-	ide_setup_pci_device(dev, &triflex_device);
-
-	return 0;
+	return ide_setup_pci_device(dev, &triflex_device);
 }
 
 static struct pci_device_id triflex_pci_tbl[] = {
diff -puN drivers/ide/pci/trm290.c~ata-040 drivers/ide/pci/trm290.c
--- linux-2.6.10-bk1/drivers/ide/pci/trm290.c~ata-040	2004-12-29 23:58:31.985928725 +0100
+++ linux-2.6.10-bk1-fr/drivers/ide/pci/trm290.c	2004-12-29 23:58:32.029921543 +0100
@@ -342,8 +342,7 @@ static ide_pci_device_t trm290_chipset _
 
 static int __devinit trm290_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_setup_pci_device(dev, &trm290_chipset);
-	return 0;
+	return ide_setup_pci_device(dev, &trm290_chipset);
 }
 
 static struct pci_device_id trm290_pci_tbl[] = {
diff -puN drivers/ide/pci/via82cxxx.c~ata-040 drivers/ide/pci/via82cxxx.c
--- linux-2.6.10-bk1/drivers/ide/pci/via82cxxx.c~ata-040	2004-12-29 23:58:31.987928399 +0100
+++ linux-2.6.10-bk1-fr/drivers/ide/pci/via82cxxx.c	2004-12-29 23:58:32.030921380 +0100
@@ -620,8 +620,7 @@ static ide_pci_device_t via82cxxx_chipse
 
 static int __devinit via_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_setup_pci_device(dev, &via82cxxx_chipset);
-	return 0;
+	return ide_setup_pci_device(dev, &via82cxxx_chipset);
 }
 
 static struct pci_device_id via_pci_tbl[] = {
diff -puN drivers/ide/pci/aec62xx.h~ata-040 drivers/ide/pci/aec62xx.h
--- linux-2.6.10-bk1/drivers/ide/pci/aec62xx.h~ata-040	2004-12-29 23:58:31.990927909 +0100
+++ linux-2.6.10-bk1-fr/drivers/ide/pci/aec62xx.h	2004-12-29 23:58:32.030921380 +0100
@@ -61,8 +61,8 @@ static struct chipset_bus_clock_list_ent
 #define BUSCLOCK(D)	\
 	((struct chipset_bus_clock_list_entry *) pci_get_drvdata((D)))
 
-static void init_setup_aec6x80(struct pci_dev *, ide_pci_device_t *);
-static void init_setup_aec62xx(struct pci_dev *, ide_pci_device_t *);
+static int init_setup_aec6x80(struct pci_dev *, ide_pci_device_t *);
+static int init_setup_aec62xx(struct pci_dev *, ide_pci_device_t *);
 static unsigned int init_chipset_aec62xx(struct pci_dev *, const char *);
 static void init_hwif_aec62xx(ide_hwif_t *);
 static void init_dma_aec62xx(ide_hwif_t *, unsigned long);
diff -puN include/linux/ide.h~ata-040 include/linux/ide.h
--- linux-2.6.10-bk1/include/linux/ide.h~ata-040	2004-12-29 23:58:31.993927420 +0100
+++ linux-2.6.10-bk1-fr/include/linux/ide.h	2004-12-29 23:58:32.032921054 +0100
@@ -1422,7 +1422,7 @@ enum {
 
 typedef struct ide_pci_device_s {
 	char			*name;
-	void			(*init_setup)(struct pci_dev *, struct ide_pci_device_s *);
+	int			(*init_setup)(struct pci_dev *, struct ide_pci_device_s *);
 	void			(*init_setup_dma)(struct pci_dev *, struct ide_pci_device_s *, ide_hwif_t *);
 	unsigned int		(*init_chipset)(struct pci_dev *, const char *);
 	void			(*init_iops)(ide_hwif_t *);
diff -puN drivers/ide/pci/hpt366.h~ata-040 drivers/ide/pci/hpt366.h
--- linux-2.6.10-bk1/drivers/ide/pci/hpt366.h~ata-040	2004-12-29 23:58:31.996926930 +0100
+++ linux-2.6.10-bk1-fr/drivers/ide/pci/hpt366.h	2004-12-29 23:58:32.032921054 +0100
@@ -414,9 +414,9 @@ static struct chipset_bus_clock_list_ent
 #define F_LOW_PCI_50      0x2d
 #define F_LOW_PCI_66      0x42
 
-static void init_setup_hpt366(struct pci_dev *, ide_pci_device_t *);
-static void init_setup_hpt37x(struct pci_dev *, ide_pci_device_t *);
-static void init_setup_hpt374(struct pci_dev *, ide_pci_device_t *);
+static int init_setup_hpt366(struct pci_dev *, ide_pci_device_t *);
+static int init_setup_hpt37x(struct pci_dev *, ide_pci_device_t *);
+static int init_setup_hpt374(struct pci_dev *, ide_pci_device_t *);
 static unsigned int init_chipset_hpt366(struct pci_dev *, const char *);
 static void init_hwif_hpt366(ide_hwif_t *);
 static void init_dma_hpt366(ide_hwif_t *, unsigned long);
diff -puN drivers/ide/pci/opti621.h~ata-040 drivers/ide/pci/opti621.h
--- linux-2.6.10-bk1/drivers/ide/pci/opti621.h~ata-040	2004-12-29 23:58:31.999926440 +0100
+++ linux-2.6.10-bk1-fr/drivers/ide/pci/opti621.h	2004-12-29 23:58:32.033920890 +0100
@@ -5,7 +5,7 @@
 #include <linux/pci.h>
 #include <linux/ide.h>
 
-static void init_setup_opti621(struct pci_dev *, ide_pci_device_t *);
+static int init_setup_opti621(struct pci_dev *, ide_pci_device_t *);
 static void init_hwif_opti621(ide_hwif_t *);
 
 static ide_pci_device_t opti621_chipsets[] __devinitdata = {
diff -puN drivers/ide/pci/pdc202xx_old.h~ata-040 drivers/ide/pci/pdc202xx_old.h
--- linux-2.6.10-bk1/drivers/ide/pci/pdc202xx_old.h~ata-040	2004-12-29 23:58:32.001926114 +0100
+++ linux-2.6.10-bk1-fr/drivers/ide/pci/pdc202xx_old.h	2004-12-29 23:58:32.033920890 +0100
@@ -63,9 +63,9 @@ static const char *pdc_quirk_drives[] = 
 #define	MC1		0x02	/* DMA"C" timing */
 #define	MC0		0x01	/* DMA"C" timing */
 
-static void init_setup_pdc202ata4(struct pci_dev *dev, ide_pci_device_t *d);
-static void init_setup_pdc20265(struct pci_dev *, ide_pci_device_t *);
-static void init_setup_pdc202xx(struct pci_dev *, ide_pci_device_t *);
+static int init_setup_pdc202ata4(struct pci_dev *dev, ide_pci_device_t *d);
+static int init_setup_pdc20265(struct pci_dev *, ide_pci_device_t *);
+static int init_setup_pdc202xx(struct pci_dev *, ide_pci_device_t *);
 static unsigned int init_chipset_pdc202xx(struct pci_dev *, const char *);
 static void init_hwif_pdc202xx(ide_hwif_t *);
 static void init_dma_pdc202xx(ide_hwif_t *, unsigned long);
diff -puN drivers/ide/pci/pdc202xx_new.h~ata-040 drivers/ide/pci/pdc202xx_new.h
--- linux-2.6.10-bk1/drivers/ide/pci/pdc202xx_new.h~ata-040	2004-12-29 23:58:32.004925624 +0100
+++ linux-2.6.10-bk1-fr/drivers/ide/pci/pdc202xx_new.h	2004-12-29 23:58:32.034920727 +0100
@@ -43,9 +43,9 @@ const static char *pdc_quirk_drives[] = 
 		set_2regs(0x13,(c));			\
 	} while(0)
 
-static void init_setup_pdcnew(struct pci_dev *, ide_pci_device_t *);
-static void init_setup_pdc20270(struct pci_dev *, ide_pci_device_t *);
-static void init_setup_pdc20276(struct pci_dev *dev, ide_pci_device_t *d);
+static int init_setup_pdcnew(struct pci_dev *, ide_pci_device_t *);
+static int init_setup_pdc20270(struct pci_dev *, ide_pci_device_t *);
+static int init_setup_pdc20276(struct pci_dev *dev, ide_pci_device_t *d);
 static unsigned int init_chipset_pdcnew(struct pci_dev *, const char *);
 static void init_hwif_pdc202new(ide_hwif_t *);
 
diff -puN drivers/ide/pci/piix.h~ata-040 drivers/ide/pci/piix.h
--- linux-2.6.10-bk1/drivers/ide/pci/piix.h~ata-040	2004-12-29 23:58:32.007925134 +0100
+++ linux-2.6.10-bk1-fr/drivers/ide/pci/piix.h	2004-12-29 23:58:32.034920727 +0100
@@ -5,7 +5,7 @@
 #include <linux/pci.h>
 #include <linux/ide.h>
 
-static void init_setup_piix(struct pci_dev *, ide_pci_device_t *);
+static int init_setup_piix(struct pci_dev *, ide_pci_device_t *);
 static unsigned int __devinit init_chipset_piix(struct pci_dev *, const char *);
 static void init_hwif_piix(ide_hwif_t *);
 
diff -puN drivers/ide/pci/serverworks.h~ata-040 drivers/ide/pci/serverworks.h
--- linux-2.6.10-bk1/drivers/ide/pci/serverworks.h~ata-040	2004-12-29 23:58:32.009924808 +0100
+++ linux-2.6.10-bk1-fr/drivers/ide/pci/serverworks.h	2004-12-29 23:58:32.034920727 +0100
@@ -21,8 +21,8 @@ static const char *svwks_bad_ata100[] = 
 	NULL
 };
 
-static void init_setup_svwks(struct pci_dev *, ide_pci_device_t *);
-static void init_setup_csb6(struct pci_dev *, ide_pci_device_t *);
+static int init_setup_svwks(struct pci_dev *, ide_pci_device_t *);
+static int init_setup_csb6(struct pci_dev *, ide_pci_device_t *);
 static unsigned int init_chipset_svwks(struct pci_dev *, const char *);
 static void init_hwif_svwks(ide_hwif_t *);
 static void init_dma_svwks(ide_hwif_t *, unsigned long);

_
