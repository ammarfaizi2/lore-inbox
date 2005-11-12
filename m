Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932416AbVKLQz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416AbVKLQz4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 11:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbVKLQz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 11:55:56 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:51983 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932416AbVKLQz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 11:55:56 -0500
Date: Sat, 12 Nov 2005 16:55:48 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: 2.6.15-rc1: IDE: fix potential data corruption with SL82C105 interfaces
Message-ID: <20051112165548.GB28987@flint.arm.linux.org.uk>
Mail-Followup-To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We must _never_ _ever_ on pain of death enable IDE DMA on SL82C105
chipsets where the southbridge revision is <= 5, otherwise data
corruption will occur.

Strangely this used to work, but something has changed in the upper
echelons of the IDE layer to break the hosts decision to deny DMA.
Let's make it crystal clear to the IDE layer that we know best.

Note: due to the urgency of this fix, I will be applying this to the
ARM tree.  Any comments/criticisms can be dealt with further patches.


diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej -x .git linus/drivers/ide/pci/sl82c105.c linux/drivers/ide/pci/sl82c105.c
--- linus/drivers/ide/pci/sl82c105.c	Sun Nov  6 22:16:04 2005
+++ linux/drivers/ide/pci/sl82c105.c	Sat Nov 12 16:50:20 2005
@@ -399,34 +399,6 @@ static unsigned int __devinit init_chips
 	return dev->irq;
 }
 
-static void __devinit init_dma_sl82c105(ide_hwif_t *hwif, unsigned long dma_base)
-{
-	unsigned int rev;
-	u8 dma_state;
-
-	DBG(("init_dma_sl82c105(hwif: ide%d, dma_base: 0x%08x)\n", hwif->index, dma_base));
-
-	hwif->autodma = 0;
-
-	if (!dma_base)
-		return;
-
-	dma_state = hwif->INB(dma_base + 2);
-	rev = sl82c105_bridge_revision(hwif->pci_dev);
-	if (rev <= 5) {
-		printk("    %s: Winbond 553 bridge revision %d, BM-DMA disabled\n",
-		       hwif->name, rev);
-		dma_state &= ~0x60;
-	} else {
-		dma_state |= 0x60;
-		if (!noautodma)
-			hwif->autodma = 1;
-	}
-	hwif->OUTB(dma_state, dma_base + 2);
-
-	ide_setup_dma(hwif, dma_base, 8);
-}
-
 /*
  * Initialise the chip
  */
@@ -434,6 +406,8 @@ static void __devinit init_dma_sl82c105(
 static void __devinit init_hwif_sl82c105(ide_hwif_t *hwif)
 {
 	struct pci_dev *dev = hwif->pci_dev;
+	unsigned int rev;
+	u8 dma_state;
 	u32 val;
 	
 	DBG(("init_hwif_sl82c105(hwif: ide%d)\n", hwif->index));
@@ -455,33 +429,51 @@ static void __devinit init_hwif_sl82c105
 	pci_read_config_dword(dev, 0x40, &val);
 	*((u32 *)&hwif->hwif_data) = val;
 	
+	hwif->atapi_dma = 0;
+	hwif->mwdma_mask = 0;
+	hwif->swdma_mask = 0;
+	hwif->autodma = 0;
+
 	if (!hwif->dma_base)
 		return;
 
-	hwif->atapi_dma = 1;
-	hwif->mwdma_mask = 0x07;
-	hwif->swdma_mask = 0x07;
-
+	dma_state = hwif->INB(hwif->dma_base + 2) & ~0x60;
+	rev = sl82c105_bridge_revision(hwif->pci_dev);
+	if (rev <= 5) {
+		/*
+		 * Never ever EVER under any circumstances enable
+		 * DMA when the bridge is this old.
+		 */
+		printk("    %s: Winbond 553 bridge revision %d, BM-DMA disabled\n",
+		       hwif->name, rev);
+	} else {
 #ifdef CONFIG_BLK_DEV_IDEDMA
-	hwif->ide_dma_check = &sl82c105_check_drive;
-	hwif->ide_dma_on = &sl82c105_ide_dma_on;
-	hwif->ide_dma_off_quietly = &sl82c105_ide_dma_off_quietly;
-	hwif->ide_dma_lostirq = &sl82c105_ide_dma_lost_irq;
-	hwif->dma_start = &sl82c105_ide_dma_start;
-	hwif->ide_dma_timeout = &sl82c105_ide_dma_timeout;
-
-	if (!noautodma)
-		hwif->autodma = 1;
-	hwif->drives[0].autodma = hwif->autodma;
-	hwif->drives[1].autodma = hwif->autodma;
+		dma_state |= 0x60;
+
+		hwif->atapi_dma = 1;
+		hwif->mwdma_mask = 0x07;
+		hwif->swdma_mask = 0x07;
+
+		hwif->ide_dma_check = &sl82c105_check_drive;
+		hwif->ide_dma_on = &sl82c105_ide_dma_on;
+		hwif->ide_dma_off_quietly = &sl82c105_ide_dma_off_quietly;
+		hwif->ide_dma_lostirq = &sl82c105_ide_dma_lost_irq;
+		hwif->dma_start = &sl82c105_ide_dma_start;
+		hwif->ide_dma_timeout = &sl82c105_ide_dma_timeout;
+
+		if (!noautodma)
+			hwif->autodma = 1;
+		hwif->drives[0].autodma = hwif->autodma;
+		hwif->drives[1].autodma = hwif->autodma;
 #endif /* CONFIG_BLK_DEV_IDEDMA */
+	}
+	hwif->OUTB(dma_state, hwif->dma_base + 2);
 }
 
 static ide_pci_device_t sl82c105_chipset __devinitdata = {
 	.name		= "W82C105",
 	.init_chipset	= init_chipset_sl82c105,
 	.init_hwif	= init_hwif_sl82c105,
-	.init_dma	= init_dma_sl82c105,
 	.channels	= 2,
 	.autodma	= NOAUTODMA,
 	.enablebits	= {{0x40,0x01,0x01}, {0x40,0x10,0x10}},


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
