Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135979AbREBGpe>; Wed, 2 May 2001 02:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135980AbREBGpY>; Wed, 2 May 2001 02:45:24 -0400
Received: from ns.caldera.de ([212.34.180.1]:21690 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S135979AbREBGpP>;
	Wed, 2 May 2001 02:45:15 -0400
Date: Wed, 2 May 2001 08:44:25 +0200
From: Marcus Meissner <Marcus.Meissner@caldera.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: PATCH: emu10k1 moving pci_enable_device
Message-ID: <20010502084425.A19594@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This moves pci_enable_device in emu10k1 driver before any resource
access.

Ciao, Marcus

Index: main.c
===================================================================
RCS file: /build/mm/work/repository/linux-mm/drivers/sound/emu10k1/main.c,v
retrieving revision 1.3
diff -u -r1.3 linux-mm/drivers/sound/emu10k1/main.c
--- linux-vanilla/drivers/sound/emu10k1/main.c	2001/04/17 16:55:42	1.3
+++ linux-mm/drivers/sound/emu10k1/main.c	2001/04/25 11:25:02
@@ -612,7 +612,11 @@
 {
 	struct emu10k1_card *card;
 	u32 subsysvid;
+	int ret;
 
+	if ((ret=pci_enable_device(pci_dev)))
+		return ret;
+
 	if ((card = kmalloc(sizeof(struct emu10k1_card), GFP_KERNEL)) == NULL) {
 		printk(KERN_ERR "emu10k1: out of memory\n");
 		return -ENOMEM;
@@ -621,11 +625,6 @@
 
 	if (pci_set_dma_mask(pci_dev, EMU10K1_DMA_MASK)) {
 		printk(KERN_ERR "emu10k1: architecture does not support 32bit PCI busmaster DMA\n");
-		kfree(card);
-		return -ENODEV;
-	}
-
-	if (pci_enable_device(pci_dev)) {
 		kfree(card);
 		return -ENODEV;
 	}
