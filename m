Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135456AbRDWPxE>; Mon, 23 Apr 2001 11:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135471AbRDWPwx>; Mon, 23 Apr 2001 11:52:53 -0400
Received: from ns.caldera.de ([212.34.180.1]:37639 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S135456AbRDWPwn>;
	Mon, 23 Apr 2001 11:52:43 -0400
Date: Mon, 23 Apr 2001 17:51:58 +0200
From: Marcus Meissner <Marcus.Meissner@caldera.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH] es1371 pci fix/cleanup
Message-ID: <20010423175158.A15604@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This moves pci_enable_device in the es1371 driver before any resource
access and also replaces the RSRCISIOREGION by just pci_resource_flags
as suggested by Jeff.

Tested and verified.

Ciao, Marcus

Index: drivers/sound/es1371.c
===================================================================
RCS file: /build/mm/work/repository/linux-mm/drivers/sound/es1371.c,v
retrieving revision 1.7
diff -u -r1.7 es1371.c
--- drivers/sound/es1371.c	2001/04/17 17:26:05	1.7
+++ drivers/sound/es1371.c	2001/04/23 15:49:15
@@ -2771,9 +2771,6 @@
 	{ SOUND_MIXER_WRITE_IGAIN, 0x4040 }
 };
 
-#define RSRCISIOREGION(dev,num) (pci_resource_start((dev), (num)) != 0 && \
-				 (pci_resource_flags((dev), (num)) & IORESOURCE_IO))
-
 static int __devinit es1371_probe(struct pci_dev *pcidev, const struct pci_device_id *pciid)
 {
 	struct es1371_state *s;
@@ -2783,8 +2780,11 @@
 	signed long tmo2;
 	unsigned int cssr;
 
-	if (!RSRCISIOREGION(pcidev, 0))
+	if (pci_enable_device(pcidev))
 		return -1;
+
+	if (!(pci_resource_flags(pcidev, 0) & IORESOURCE_IO))
+		return -1;
 	if (pcidev->irq == 0) 
 		return -1;
 	i = pci_set_dma_mask(pcidev, 0xffffffff);
@@ -2822,8 +2822,6 @@
 		printk(KERN_ERR PFX "io ports %#lx-%#lx in use\n", s->io, s->io+ES1371_EXTENT-1);
 		goto err_region;
 	}
-	if (pci_enable_device(pcidev))
-		goto err_irq;
 	if (request_irq(s->irq, es1371_interrupt, SA_SHIRQ, "es1371", s)) {
 		printk(KERN_ERR PFX "irq %u in use\n", s->irq);
 		goto err_irq;
