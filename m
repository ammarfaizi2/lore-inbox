Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261759AbUCBUro (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 15:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261770AbUCBUrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 15:47:43 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:35476 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261759AbUCBUre
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 15:47:34 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
Subject: [PATCH] small update for pdc202xx_old driver
Date: Tue, 2 Mar 2004 20:31:01 +0100
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403022031.01766.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[IDE] small update for pdc202xx_old driver

- fix bug introduced by my recent fixes
  (do not try to disable 66MHz clock on PDC20246)
- cleanup cable verification code a bit
- remove unused macros (leftovers from driver split-up)
  and duplicated define from pdc202xx_old.h

 linux-2.6.4-rc1-root/drivers/ide/pci/pdc202xx_old.c |   35 ++++----------------
 linux-2.6.4-rc1-root/drivers/ide/pci/pdc202xx_old.h |   28 ----------------
 2 files changed, 8 insertions(+), 55 deletions(-)

diff -puN drivers/ide/pci/pdc202xx_old.c~pdc26x_update drivers/ide/pci/pdc202xx_old.c
--- linux-2.6.4-rc1/drivers/ide/pci/pdc202xx_old.c~pdc26x_update	2004-03-02 19:24:50.871024280 +0100
+++ linux-2.6.4-rc1-root/drivers/ide/pci/pdc202xx_old.c	2004-03-02 20:19:25.708173360 +0100
@@ -397,37 +397,18 @@ static int config_chipset_for_dma (ide_d
 	u8 ultra_66		= ((id->dma_ultra & 0x0010) ||
 				   (id->dma_ultra & 0x0008)) ? 1 : 0;
 
-	switch(dev->device) {
-		case PCI_DEVICE_ID_PROMISE_20267:
-		case PCI_DEVICE_ID_PROMISE_20265:
-		case PCI_DEVICE_ID_PROMISE_20263:
-		case PCI_DEVICE_ID_PROMISE_20262:
-			cable = pdc202xx_old_cable_detect(hwif);
-#if PDC202_DEBUG_CABLE
-			printk(KERN_DEBUG "%s: %s-pin cable, %s-pin cable, %d\n",
-				hwif->name, hwif->udma_four ? "80" : "40",
-				cable ? "40" : "80", cable);
-#endif /* PDC202_DEBUG_CABLE */
-			break;
-		case PCI_DEVICE_ID_PROMISE_20246:
-			ultra_66 = 0;
-			break;
-		default:
-			BUG();
-	}
-
-	if ((ultra_66) && (cable)) {
-#ifdef DEBUG
-		printk(KERN_DEBUG "ULTRA 66/100/133: %s channel of Ultra 66/100/133 "
-			"requires an 80-pin cable for Ultra66 operation.\n",
-			hwif->channel ? "Secondary" : "Primary");
-		printk(KERN_DEBUG "         Switching to Ultra33 mode.\n");
-#endif /* DEBUG */
+	if (dev->device != PCI_DEVICE_ID_PROMISE_20246)
+		cable = pdc202xx_old_cable_detect(hwif);
+	else
+		ultra_66 = 0;
+
+	if (ultra_66 && cable) {
 		printk(KERN_WARNING "Warning: %s channel requires an 80-pin cable for operation.\n", hwif->channel ? "Secondary":"Primary");
 		printk(KERN_WARNING "%s reduced to Ultra33 mode.\n", drive->name);
 	}
 
-	pdc_old_disable_66MHz_clock(drive->hwif);
+	if (dev->device != PCI_DEVICE_ID_PROMISE_20246)
+		pdc_old_disable_66MHz_clock(drive->hwif);
 
 	drive_pci = 0x60 + (drive->dn << 2);
 	pci_read_config_dword(dev, drive_pci, &drive_conf);
diff -puN drivers/ide/pci/pdc202xx_old.h~pdc26x_update drivers/ide/pci/pdc202xx_old.h
--- linux-2.6.4-rc1/drivers/ide/pci/pdc202xx_old.h~pdc26x_update	2004-03-02 19:24:52.194823032 +0100
+++ linux-2.6.4-rc1-root/drivers/ide/pci/pdc202xx_old.h	2004-03-02 19:44:34.544078624 +0100
@@ -5,8 +5,6 @@
 #include <linux/pci.h>
 #include <linux/ide.h>
 
-#define DISPLAY_PDC202XX_TIMINGS
-
 #ifndef SPLIT_BYTE
 #define SPLIT_BYTE(B,H,L)	((H)=(B>>4), (L)=(B-((B>>4)<<4)))
 #endif
@@ -171,32 +169,6 @@ static void decode_registers (u8 registe
 
 #endif /* PDC202XX_DECODE_REGISTER_INFO */
 
-#define set_2regs(a, b)					\
-	do {						\
-		hwif->OUTB((a + adj), indexreg);	\
-		hwif->OUTB(b, datareg);			\
-	} while(0)
-
-#define set_ultra(a, b, c)				\
-	do {						\
-		set_2regs(0x10,(a));			\
-		set_2regs(0x11,(b));			\
-		set_2regs(0x12,(c));			\
-	} while(0)
-
-#define set_ata2(a, b)					\
-	do {						\
-		set_2regs(0x0e,(a));			\
-		set_2regs(0x0f,(b));			\
-	} while(0)
-
-#define set_pio(a, b, c)				\
-	do { 						\
-		set_2regs(0x0c,(a));			\
-		set_2regs(0x0d,(b));			\
-		set_2regs(0x13,(c));			\
-	} while(0)
-
 #define DISPLAY_PDC202XX_TIMINGS
 
 static void init_setup_pdc202ata4(struct pci_dev *dev, ide_pci_device_t *d);

_

