Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751263AbWETIw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbWETIw4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 04:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWETIwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 04:52:55 -0400
Received: from rtsoft2.corbina.net ([85.21.88.2]:61384 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1751263AbWETIwz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 04:52:55 -0400
Message-ID: <446ED8A3.6030702@ru.mvista.com>
Date: Sat, 20 May 2006 12:51:47 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] HPT3xx: print the real chip name at startup
References: <444B3BDE.1030106@ru.mvista.com> <4457DC97.3010807@ru.mvista.com> <445A5A1B.60903@ru.mvista.com> <446A55D6.90507@ru.mvista.com>
In-Reply-To: <446A55D6.90507@ru.mvista.com>
Content-Type: multipart/mixed;
 boundary="------------080506020608090408020603"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080506020608090408020603
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

- Rework the driver setup code so that it prefixes the driver startup messages
     with the real chip name.

- Print the measured f_CNT value and the DPLL setting for non-HPT3xx chips
     as well.

- Claim the extra 240 bytes of I/O space for all chips, not only for those
     having PCI device ID of 0x0004.

MBR, Sergei

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>


--------------080506020608090408020603
Content-Type: text/plain;
 name="HPT3xx-print-real-chip-name.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="HPT3xx-print-real-chip-name.patch"

Index: linus/drivers/ide/pci/hpt366.c
===================================================================
--- linus.orig/drivers/ide/pci/hpt366.c
+++ linus/drivers/ide/pci/hpt366.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/hpt366.c		Version 0.43	May 17, 2006
+ * linux/drivers/ide/pci/hpt366.c		Version 0.44	May 20, 2006
  *
  * Copyright (C) 1999-2003		Andre Hedrick <andre@linux-ide.org>
  * Portions Copyright (C) 2001	        Sun Microsystems, Inc.
@@ -76,6 +76,8 @@
  *   and for HPT36x the obsolete HDIO_TRISTATE_HWIF handler was called instead
  * - pass to init_chipset() handlers a copy of the IDE PCI device structure as
  *   they tamper with its fields
+ * - prefix the driver startup messages with the real chip name
+ * - claim the extra 240 bytes of I/O space for all chips
  * - optimize the rate masking/filtering and the drive list lookup code
  *		<source@mvista.com>
  *
@@ -990,8 +992,9 @@ static void __devinit hpt366_clocking(id
 
 static void __devinit hpt37x_clocking(ide_hwif_t *hwif)
 {
-	struct hpt_info *info = ide_get_hwifdata(hwif);
-	struct pci_dev *dev = hwif->pci_dev;
+	struct hpt_info *info	= ide_get_hwifdata(hwif);
+	struct pci_dev  *dev	= hwif->pci_dev;
+	char *name		= hwif->cds->name;
 	int adjust, i;
 	u16 freq = 0;
 	u32 pll, temp = 0;
@@ -1024,7 +1027,7 @@ static void __devinit hpt37x_clocking(id
 	 */
 	temp = inl(pci_resource_start(dev, 4) + 0x90);
 	if ((temp & 0xFFFFF000) != 0xABCDE000) {
-		printk(KERN_WARNING "HPT37X: no clock data saved by BIOS\n");
+		printk(KERN_WARNING "%s: no clock data saved by BIOS\n", name);
 
 		/* Calculate the average value of f_CNT */
 		for (temp = i = 0; i < 128; i++) {
@@ -1051,10 +1054,7 @@ static void __devinit hpt37x_clocking(id
 		else
 			pll = F_LOW_PCI_66;
 
-		printk(KERN_INFO "HPT3xxN detected, FREQ: %d, PLL: %d\n", freq, pll);
-	}
-	else
-	{
+	} else {
 		if(freq < 0x9C)
 			pll = F_LOW_PCI_33;
 		else if(freq < 0xb0)
@@ -1063,18 +1063,21 @@ static void __devinit hpt37x_clocking(id
 			pll = F_LOW_PCI_50;
 		else
 			pll = F_LOW_PCI_66;
+	}
+	printk(KERN_INFO "%s: FREQ: %d, PLL: %d\n", name, freq, pll);
 	
+	if (!(info->flags & IS_3xxN)) {
 		if (pll == F_LOW_PCI_33) {
 			info->speed = thirty_three_base_hpt37x;
-			printk(KERN_DEBUG "HPT37X: using 33MHz PCI clock\n");
+			printk(KERN_DEBUG "%s: using 33MHz PCI clock\n", name);
 		} else if (pll == F_LOW_PCI_40) {
 			/* Unsupported */
 		} else if (pll == F_LOW_PCI_50) {
 			info->speed = fifty_base_hpt37x;
-			printk(KERN_DEBUG "HPT37X: using 50MHz PCI clock\n");
+			printk(KERN_DEBUG "%s: using 50MHz PCI clock\n", name);
 		} else {
 			info->speed = sixty_six_base_hpt37x;
-			printk(KERN_DEBUG "HPT37X: using 66MHz PCI clock\n");
+			printk(KERN_DEBUG "%s: using 66MHz PCI clock\n", name);
 		}
 	}
 
@@ -1123,7 +1126,7 @@ static void __devinit hpt37x_clocking(id
 				pci_write_config_byte(dev, 0x5b, 0x21);
 
 				info->speed = fifty_base_hpt37x;
-				printk("HPT37X: using 50MHz internal PLL\n");
+				printk("%s: using 50MHz internal PLL\n", name);
 				goto init_hpt37X_done;
 			}
 		}
@@ -1136,8 +1139,8 @@ pll_recal:
 
 init_hpt37X_done:
 	if (!info->speed)
-		printk(KERN_ERR "HPT37x%s: unknown bus timing [%d %d].\n",
-		       (info->flags & IS_3xxN) ? "N" : "", pll, freq);
+		printk(KERN_ERR "%s: unknown bus timing [%d %d].\n",
+		       name, pll, freq);
 	/*
 	 * Reset the state engines.
 	 * NOTE: avoid accidentally enabling the primary channel on HPT371N.
@@ -1330,7 +1333,8 @@ static void __devinit init_dma_hpt366(id
 		return;
 		
 	if(info->speed == NULL) {
-		printk(KERN_WARNING "hpt366: no known IDE timings, disabling DMA.\n");
+		printk(KERN_WARNING "%s: no known IDE timings, disabling DMA.\n",
+		       hwif->cds->name);
 		return;
 	}
 
@@ -1365,7 +1369,7 @@ static void __devinit init_iops_hpt366(i
 	u8 mode, rid		= 0;
 
 	if(info == NULL) {
-		printk(KERN_WARNING "hpt366: out of memory.\n");
+		printk(KERN_WARNING "%s: out of memory.\n", hwif->cds->name);
 		return;
 	}
 	ide_set_hwifdata(hwif, info);
@@ -1430,14 +1434,19 @@ static int __devinit init_setup_hpt374(s
 	return ide_setup_pci_device(dev, d);
 }
 
-static int __devinit init_setup_hpt37x(struct pci_dev *dev, ide_pci_device_t *d)
+static int __devinit init_setup_hpt372n(struct pci_dev *dev, ide_pci_device_t *d)
 {
 	return ide_setup_pci_device(dev, d);
 }
 
 static int __devinit init_setup_hpt371(struct pci_dev *dev, ide_pci_device_t *d)
 {
-	u8 mcr1 = 0;
+	u8 rev = 0, mcr1 = 0;
+
+	pci_read_config_byte(dev, PCI_REVISION_ID, &rev);
+
+	if (rev > 1)
+		d->name = "HPT371N";
 
 	/*
 	 * HPT371 chips physically have only one channel, the secondary one,
@@ -1447,7 +1456,31 @@ static int __devinit init_setup_hpt371(s
 	 */
 	pci_read_config_byte(dev, 0x50, &mcr1);
 	if (mcr1 & 0x04)
-		pci_write_config_byte(dev, 0x50, (mcr1 & ~0x04));
+		pci_write_config_byte(dev, 0x50, mcr1 & ~0x04);
+
+	return ide_setup_pci_device(dev, d);
+}
+
+static int __devinit init_setup_hpt372a(struct pci_dev *dev, ide_pci_device_t *d)
+{
+	u8 rev = 0;
+
+	pci_read_config_byte(dev, PCI_REVISION_ID, &rev);
+
+	if (rev > 1)
+		d->name = "HPT372N";
+
+	return ide_setup_pci_device(dev, d);
+}
+
+static int __devinit init_setup_hpt302(struct pci_dev *dev, ide_pci_device_t *d)
+{
+	u8 rev = 0;
+
+	pci_read_config_byte(dev, PCI_REVISION_ID, &rev);
+
+	if (rev > 1)
+		d->name = "HPT302N";
 
 	return ide_setup_pci_device(dev, d);
 }
@@ -1456,30 +1489,22 @@ static int __devinit init_setup_hpt366(s
 {
 	struct pci_dev *findev = NULL;
 	u8 rev = 0, pin1 = 0, pin2 = 0;
-	char *chipset_names[] = {"HPT366", "HPT366",  "HPT368",
-				 "HPT370", "HPT370A", "HPT372",
-				 "HPT372N" };
+	static char   *chipset_names[] = { "HPT366", "HPT366",  "HPT368",
+					   "HPT370", "HPT370A", "HPT372",
+					   "HPT372N" };
 
 	if (PCI_FUNC(dev->devfn) & 1)
 		return -ENODEV;
 
 	pci_read_config_byte(dev, PCI_REVISION_ID, &rev);
 
-	if(dev->device == PCI_DEVICE_ID_TTI_HPT372N)
+	if (rev > 6)
 		rev = 6;
 		
-	if(rev <= 6)
-		d->name = chipset_names[rev];
+	d->name = chipset_names[rev];
 
-	switch(rev) {
-		case 6:
-		case 5:
-		case 4:
-		case 3:
-			goto init_single;
-		default:
-			break;
-	}
+	if (rev > 2)
+		goto init_single;
 
 	d->channels = 1;
 
@@ -1517,7 +1542,7 @@ static ide_pci_device_t hpt366_chipsets[
 		.extra		= 240
 	},{	/* 1 */
 		.name		= "HPT372A",
-		.init_setup	= init_setup_hpt37x,
+		.init_setup	= init_setup_hpt372a,
 		.init_chipset	= init_chipset_hpt366,
 		.init_iops	= init_iops_hpt366,
 		.init_hwif	= init_hwif_hpt366,
@@ -1525,9 +1550,10 @@ static ide_pci_device_t hpt366_chipsets[
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
+		.extra		= 240
 	},{	/* 2 */
 		.name		= "HPT302",
-		.init_setup	= init_setup_hpt37x,
+		.init_setup	= init_setup_hpt302,
 		.init_chipset	= init_chipset_hpt366,
 		.init_iops	= init_iops_hpt366,
 		.init_hwif	= init_hwif_hpt366,
@@ -1535,6 +1561,7 @@ static ide_pci_device_t hpt366_chipsets[
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
+		.extra		= 240
 	},{	/* 3 */
 		.name		= "HPT371",
 		.init_setup	= init_setup_hpt371,
@@ -1546,6 +1573,7 @@ static ide_pci_device_t hpt366_chipsets[
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x50,0x04,0x04}, {0x54,0x04,0x04}},
 		.bootable	= OFF_BOARD,
+		.extra		= 240
 	},{	/* 4 */
 		.name		= "HPT374",
 		.init_setup	= init_setup_hpt374,
@@ -1556,9 +1584,10 @@ static ide_pci_device_t hpt366_chipsets[
 		.channels	= 2,	/* 4 */
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
+		.extra		= 240
 	},{	/* 5 */
 		.name		= "HPT372N",
-		.init_setup	= init_setup_hpt37x,
+		.init_setup	= init_setup_hpt372n,
 		.init_chipset	= init_chipset_hpt366,
 		.init_iops	= init_iops_hpt366,
 		.init_hwif	= init_hwif_hpt366,
@@ -1566,6 +1595,7 @@ static ide_pci_device_t hpt366_chipsets[
 		.channels	= 2,	/* 4 */
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
+		.extra		= 240
 	}
 };
 



--------------080506020608090408020603--
