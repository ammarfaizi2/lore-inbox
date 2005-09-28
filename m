Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751141AbVI1WdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbVI1WdV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 18:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbVI1WdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 18:33:20 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:60177 "EHLO
	mta08-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751141AbVI1WdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 18:33:19 -0400
Message-ID: <433B179A.8010600@gentoo.org>
Date: Wed, 28 Sep 2005 23:22:18 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050820)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
CC: jgarzik@pobox.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       posting@blx4.net, vsu@altlinux.ru
Subject: Re: [PATCH] via82cxxx IDE: Support multiple controllers (v2)
References: <43146CC3.4010005@gentoo.org>	 <58cb370e05083008121f2eb783@mail.gmail.com>	 <43179CC9.8090608@gentoo.org> <58cb370e050927062049be32f8@mail.gmail.com>
In-Reply-To: <58cb370e050927062049be32f8@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------080906080107090106070807"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080906080107090106070807
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Support multiple controllers in the via82cxxx IDE driver, revised patch. Cable 
detection and ISA bridge finding have been moved into their own functions.

Unfortunately I won't have access to a via82cxxx machine until December now, 
this patch is only compile-tested.

Signed-off-by: Daniel Drake <dsd@gentoo.org>


--------------080906080107090106070807
Content-Type: text/x-patch;
 name="via82cxxx-multi-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="via82cxxx-multi-2.patch"

--- linux-2.6.14-rc1/drivers/ide/pci/via82cxxx.c.orig	2005-09-28 22:31:22.000000000 +0100
+++ linux-2.6.14-rc1/drivers/ide/pci/via82cxxx.c	2005-09-28 23:06:50.000000000 +0100
@@ -100,11 +100,15 @@ static struct via_isa_bridge {
 	{ NULL }
 };
 
-static struct via_isa_bridge *via_config;
-static unsigned int via_80w;
 static unsigned int via_clock;
 static char *via_dma[] = { "MWDMA16", "UDMA33", "UDMA66", "UDMA100", "UDMA133" };
 
+struct via82cxxx_dev
+{
+	struct via_isa_bridge *via_config;
+	unsigned int via_80w;
+};
+
 /**
  *	via_set_speed			-	write timing registers
  *	@dev: PCI device
@@ -114,11 +118,13 @@ static char *via_dma[] = { "MWDMA16", "U
  *	via_set_speed writes timing values to the chipset registers
  */
 
-static void via_set_speed(struct pci_dev *dev, u8 dn, struct ide_timing *timing)
+static void via_set_speed(ide_hwif_t *hwif, u8 dn, struct ide_timing *timing)
 {
+	struct pci_dev *dev = hwif->pci_dev;
+	struct via82cxxx_dev *vdev = ide_get_hwifdata(hwif);
 	u8 t;
 
-	if (~via_config->flags & VIA_BAD_AST) {
+	if (~vdev->via_config->flags & VIA_BAD_AST) {
 		pci_read_config_byte(dev, VIA_ADDRESS_SETUP, &t);
 		t = (t & ~(3 << ((3 - dn) << 1))) | ((FIT(timing->setup, 1, 4) - 1) << ((3 - dn) << 1));
 		pci_write_config_byte(dev, VIA_ADDRESS_SETUP, t);
@@ -130,7 +136,7 @@ static void via_set_speed(struct pci_dev
 	pci_write_config_byte(dev, VIA_DRIVE_TIMING + (3 - dn),
 		((FIT(timing->active, 1, 16) - 1) << 4) | (FIT(timing->recover, 1, 16) - 1));
 
-	switch (via_config->flags & VIA_UDMA) {
+	switch (vdev->via_config->flags & VIA_UDMA) {
 		case VIA_UDMA_33:  t = timing->udma ? (0xe0 | (FIT(timing->udma, 2, 5) - 2)) : 0x03; break;
 		case VIA_UDMA_66:  t = timing->udma ? (0xe8 | (FIT(timing->udma, 2, 9) - 2)) : 0x0f; break;
 		case VIA_UDMA_100: t = timing->udma ? (0xe0 | (FIT(timing->udma, 2, 9) - 2)) : 0x07; break;
@@ -154,6 +160,7 @@ static void via_set_speed(struct pci_dev
 static int via_set_drive(ide_drive_t *drive, u8 speed)
 {
 	ide_drive_t *peer = HWIF(drive)->drives + (~drive->dn & 1);
+	struct via82cxxx_dev *vdev = ide_get_hwifdata(drive->hwif);
 	struct ide_timing t, p;
 	unsigned int T, UT;
 
@@ -162,7 +169,7 @@ static int via_set_drive(ide_drive_t *dr
 
 	T = 1000000000 / via_clock;
 
-	switch (via_config->flags & VIA_UDMA) {
+	switch (vdev->via_config->flags & VIA_UDMA) {
 		case VIA_UDMA_33:   UT = T;   break;
 		case VIA_UDMA_66:   UT = T/2; break;
 		case VIA_UDMA_100:  UT = T/3; break;
@@ -177,7 +184,7 @@ static int via_set_drive(ide_drive_t *dr
 		ide_timing_merge(&p, &t, &t, IDE_TIMING_8BIT);
 	}
 
-	via_set_speed(HWIF(drive)->pci_dev, drive->dn, &t);
+	via_set_speed(HWIF(drive), drive->dn, &t);
 
 	if (!drive->init_speed)
 		drive->init_speed = speed;
@@ -215,20 +222,41 @@ static void via82cxxx_tune_drive(ide_dri
  
 static int via82cxxx_ide_dma_check (ide_drive_t *drive)
 {
-	u16 w80 = HWIF(drive)->udma_four;
+	ide_hwif_t *hwif = HWIF(drive);
+	struct via82cxxx_dev *vdev = ide_get_hwifdata(hwif);
+	u16 w80 = hwif->udma_four;
 
 	u16 speed = ide_find_best_mode(drive,
 		XFER_PIO | XFER_EPIO | XFER_SWDMA | XFER_MWDMA |
-		(via_config->flags & VIA_UDMA ? XFER_UDMA : 0) |
-		(w80 && (via_config->flags & VIA_UDMA) >= VIA_UDMA_66 ? XFER_UDMA_66 : 0) |
-		(w80 && (via_config->flags & VIA_UDMA) >= VIA_UDMA_100 ? XFER_UDMA_100 : 0) |
-		(w80 && (via_config->flags & VIA_UDMA) >= VIA_UDMA_133 ? XFER_UDMA_133 : 0));
+		(vdev->via_config->flags & VIA_UDMA ? XFER_UDMA : 0) |
+		(w80 && (vdev->via_config->flags & VIA_UDMA) >= VIA_UDMA_66 ? XFER_UDMA_66 : 0) |
+		(w80 && (vdev->via_config->flags & VIA_UDMA) >= VIA_UDMA_100 ? XFER_UDMA_100 : 0) |
+		(w80 && (vdev->via_config->flags & VIA_UDMA) >= VIA_UDMA_133 ? XFER_UDMA_133 : 0));
 
 	via_set_drive(drive, speed);
 
 	if (drive->autodma && (speed & XFER_MODE) != XFER_PIO)
-		return HWIF(drive)->ide_dma_on(drive);
-	return HWIF(drive)->ide_dma_off_quietly(drive);
+		return hwif->ide_dma_on(drive);
+	return hwif->ide_dma_off_quietly(drive);
+}
+
+static struct via_isa_bridge *via_config_find(struct pci_dev **isa)
+{
+	struct via_isa_bridge *via_config;
+	u8 t;
+
+	for (via_config = via_isa_bridges; via_config->id; via_config++)
+		if ((*isa = pci_find_device(PCI_VENDOR_ID_VIA +
+			!!(via_config->flags & VIA_BAD_ID),
+			via_config->id, NULL))) {
+
+			pci_read_config_byte(*isa, PCI_REVISION_ID, &t);
+			if (t >= via_config->rev_min &&
+			    t <= via_config->rev_max)
+				break;
+		}
+
+	return via_config;
 }
 
 /**
@@ -243,82 +271,28 @@ static int via82cxxx_ide_dma_check (ide_
 static unsigned int __devinit init_chipset_via82cxxx(struct pci_dev *dev, const char *name)
 {
 	struct pci_dev *isa = NULL;
+	struct via_isa_bridge *via_config;
 	u8 t, v;
 	unsigned int u;
-	int i;
 
 	/*
 	 * Find the ISA bridge to see how good the IDE is.
 	 */
-
-	for (via_config = via_isa_bridges; via_config->id; via_config++)
-		if ((isa = pci_find_device(PCI_VENDOR_ID_VIA +
-			!!(via_config->flags & VIA_BAD_ID),
-			via_config->id, NULL))) {
-
-			pci_read_config_byte(isa, PCI_REVISION_ID, &t);
-			if (t >= via_config->rev_min &&
-			    t <= via_config->rev_max)
-				break;
-		}
-
+	via_config = via_config_find(&isa);
 	if (!via_config->id) {
 		printk(KERN_WARNING "VP_IDE: Unknown VIA SouthBridge, disabling DMA.\n");
 		return -ENODEV;
 	}
 
 	/*
-	 * Check 80-wire cable presence and setup Clk66.
+	 * Setup or disable Clk66 if appropriate
 	 */
 
-	switch (via_config->flags & VIA_UDMA) {
-
-		case VIA_UDMA_66:
-			/* Enable Clk66 */
-			pci_read_config_dword(dev, VIA_UDMA_TIMING, &u);
-			pci_write_config_dword(dev, VIA_UDMA_TIMING, u|0x80008);
-			for (i = 24; i >= 0; i -= 8)
-				if (((u >> (i & 16)) & 8) &&
-				    ((u >> i) & 0x20) &&
-				     (((u >> i) & 7) < 2)) {
-					/*
-					 * 2x PCI clock and
-					 * UDMA w/ < 3T/cycle
-					 */
-					via_80w |= (1 << (1 - (i >> 4)));
-				}
-			break;
-
-		case VIA_UDMA_100:
-			pci_read_config_dword(dev, VIA_UDMA_TIMING, &u);
-			for (i = 24; i >= 0; i -= 8)
-				if (((u >> i) & 0x10) ||
-				    (((u >> i) & 0x20) &&
-				     (((u >> i) & 7) < 4))) {
-					/* BIOS 80-wire bit or
-					 * UDMA w/ < 60ns/cycle
-					 */
-					via_80w |= (1 << (1 - (i >> 4)));
-				}
-			break;
-
-		case VIA_UDMA_133:
-			pci_read_config_dword(dev, VIA_UDMA_TIMING, &u);
-			for (i = 24; i >= 0; i -= 8)
-				if (((u >> i) & 0x10) ||
-				    (((u >> i) & 0x20) &&
-				     (((u >> i) & 7) < 6))) {
-					/* BIOS 80-wire bit or
-					 * UDMA w/ < 60ns/cycle
-					 */
-					via_80w |= (1 << (1 - (i >> 4)));
-				}
-			break;
-
-	}
-
-	/* Disable Clk66 */
-	if (via_config->flags & VIA_BAD_CLK66) {
+	if ((via_config->flags & VIA_UDMA) == VIA_UDMA_66) {
+		/* Enable Clk66 */
+		pci_read_config_dword(dev, VIA_UDMA_TIMING, &u);
+		pci_write_config_dword(dev, VIA_UDMA_TIMING, u|0x80008);
+	} else if (via_config->flags & VIA_BAD_CLK66) {
 		/* Would cause trouble on 596a and 686 */
 		pci_read_config_dword(dev, VIA_UDMA_TIMING, &u);
 		pci_write_config_dword(dev, VIA_UDMA_TIMING, u & ~0x80008);
@@ -388,10 +362,75 @@ static unsigned int __devinit init_chips
 	return 0;
 }
 
+/*
+ * Check and handle 80-wire cable presence
+ */
+static void __devinit via_cable_detect(struct pci_dev *dev, struct via82cxxx_dev *vdev)
+{
+	unsigned int u;
+	int i;
+	pci_read_config_dword(dev, VIA_UDMA_TIMING, &u);
+
+	switch (vdev->via_config->flags & VIA_UDMA) {
+
+		case VIA_UDMA_66:
+			for (i = 24; i >= 0; i -= 8)
+				if (((u >> (i & 16)) & 8) &&
+				    ((u >> i) & 0x20) &&
+				     (((u >> i) & 7) < 2)) {
+					/*
+					 * 2x PCI clock and
+					 * UDMA w/ < 3T/cycle
+					 */
+					vdev->via_80w |= (1 << (1 - (i >> 4)));
+				}
+			break;
+
+		case VIA_UDMA_100:
+			for (i = 24; i >= 0; i -= 8)
+				if (((u >> i) & 0x10) ||
+				    (((u >> i) & 0x20) &&
+				     (((u >> i) & 7) < 4))) {
+					/* BIOS 80-wire bit or
+					 * UDMA w/ < 60ns/cycle
+					 */
+					vdev->via_80w |= (1 << (1 - (i >> 4)));
+				}
+			break;
+
+		case VIA_UDMA_133:
+			for (i = 24; i >= 0; i -= 8)
+				if (((u >> i) & 0x10) ||
+				    (((u >> i) & 0x20) &&
+				     (((u >> i) & 7) < 6))) {
+					/* BIOS 80-wire bit or
+					 * UDMA w/ < 60ns/cycle
+					 */
+					vdev->via_80w |= (1 << (1 - (i >> 4)));
+				}
+			break;
+
+	}
+}
+
 static void __devinit init_hwif_via82cxxx(ide_hwif_t *hwif)
 {
+	struct via82cxxx_dev *vdev = kmalloc(sizeof(struct via82cxxx_dev),
+		GFP_KERNEL);
+	struct pci_dev *isa = NULL;
 	int i;
 
+	if (vdev == NULL) {
+		printk(KERN_ERR "VP_IDE: out of memory :(\n");
+		return;
+	}
+
+	memset(vdev, 0, sizeof(struct via82cxxx_dev));
+	ide_set_hwifdata(hwif, vdev);
+
+	vdev->via_config = via_config_find(&isa);
+	via_cable_detect(hwif->pci_dev, vdev);
+
 	hwif->autodma = 0;
 
 	hwif->tuneproc = &via82cxxx_tune_drive;
@@ -406,7 +445,7 @@ static void __devinit init_hwif_via82cxx
 
 	for (i = 0; i < 2; i++) {
 		hwif->drives[i].io_32bit = 1;
-		hwif->drives[i].unmask = (via_config->flags & VIA_NO_UNMASK) ? 0 : 1;
+		hwif->drives[i].unmask = (vdev->via_config->flags & VIA_NO_UNMASK) ? 0 : 1;
 		hwif->drives[i].autotune = 1;
 		hwif->drives[i].dn = hwif->channel * 2 + i;
 	}
@@ -420,7 +459,7 @@ static void __devinit init_hwif_via82cxx
 	hwif->swdma_mask = 0x07;
 
 	if (!hwif->udma_four)
-		hwif->udma_four = (via_80w >> hwif->channel) & 1;
+		hwif->udma_four = (vdev->via_80w >> hwif->channel) & 1;
 	hwif->ide_dma_check = &via82cxxx_ide_dma_check;
 	if (!noautodma)
 		hwif->autodma = 1;

--------------080906080107090106070807--
