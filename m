Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131407AbRDWQIN>; Mon, 23 Apr 2001 12:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131484AbRDWQH5>; Mon, 23 Apr 2001 12:07:57 -0400
Received: from ns.caldera.de ([212.34.180.1]:54535 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S131407AbRDWQHj>;
	Mon, 23 Apr 2001 12:07:39 -0400
Date: Mon, 23 Apr 2001 18:06:53 +0200
From: Marcus Meissner <Marcus.Meissner@caldera.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Marcus Meissner <Marcus.Meissner@caldera.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] es1371 pci fix/cleanup
Message-ID: <20010423180653.A16759@caldera.de>
In-Reply-To: <20010423175158.A15604@caldera.de> <3AE45121.926C4B51@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <3AE45121.926C4B51@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Mon, Apr 23, 2001 at 11:58:25AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2001 at 11:58:25AM -0400, Jeff Garzik wrote:
> Marcus Meissner wrote:
> > 
> > Hi,
> > 
> > This moves pci_enable_device in the es1371 driver before any resource
> > access and also replaces the RSRCISIOREGION by just pci_resource_flags
> > as suggested by Jeff.
> > 
> > Tested and verified.

> Looks ok except error returns.
> 
> pci_enable_device - obtain its return value, and return that.
> 
> no IORESOURCE_IO or pcidev->irq==0 - I guess -ENODEV would be
> appropriate.  (basically look at errno.h and make a judgement call which
> error best fits the situation)

Hmm, I think I spotted all places in the probe function. I also return
-ENODEV in case we can't request_region() or request_irq().

Some drivers use EBUSY, some ENOMEM, some ENODEV there, is there
any standard return value?

Ciao, Marcus

Index: drivers/sound/es1371.c
===================================================================
RCS file: /build/mm/work/repository/linux-mm/drivers/sound/es1371.c,v
retrieving revision 1.7
diff -u -r1.7 es1371.c
--- drivers/sound/es1371.c	2001/04/17 17:26:05	1.7
+++ drivers/sound/es1371.c	2001/04/23 16:03:34
@@ -2771,22 +2771,22 @@
 	{ SOUND_MIXER_WRITE_IGAIN, 0x4040 }
 };
 
-#define RSRCISIOREGION(dev,num) (pci_resource_start((dev), (num)) != 0 && \
-				 (pci_resource_flags((dev), (num)) & IORESOURCE_IO))
-
 static int __devinit es1371_probe(struct pci_dev *pcidev, const struct pci_device_id *pciid)
 {
 	struct es1371_state *s;
 	mm_segment_t fs;
-	int i, val;
+	int i, val, res = -1;
 	unsigned long tmo;
 	signed long tmo2;
 	unsigned int cssr;
+
+	if ((res=pci_enable_device(pcidev)))
+		return res;
 
-	if (!RSRCISIOREGION(pcidev, 0))
-		return -1;
+	if (!(pci_resource_flags(pcidev, 0) & IORESOURCE_IO))
+		return -ENODEV;
 	if (pcidev->irq == 0) 
-		return -1;
+		return -ENODEV;
 	i = pci_set_dma_mask(pcidev, 0xffffffff);
 	if (i) {
 		printk(KERN_WARNING "es1371: architecture does not support 32bit PCI busmaster DMA\n");
@@ -2794,7 +2794,7 @@
 	}
 	if (!(s = kmalloc(sizeof(struct es1371_state), GFP_KERNEL))) {
 		printk(KERN_WARNING PFX "out of memory\n");
-		return -1;
+		return -ENOMEM;
 	}
 	memset(s, 0, sizeof(struct es1371_state));
 	init_waitqueue_head(&s->dma_adc.wait);
@@ -2822,8 +2822,6 @@
 		printk(KERN_ERR PFX "io ports %#lx-%#lx in use\n", s->io, s->io+ES1371_EXTENT-1);
 		goto err_region;
 	}
-	if (pci_enable_device(pcidev))
-		goto err_irq;
 	if (request_irq(s->irq, es1371_interrupt, SA_SHIRQ, "es1371", s)) {
 		printk(KERN_ERR PFX "irq %u in use\n", s->irq);
 		goto err_irq;
@@ -2964,7 +2962,7 @@
 	release_region(s->io, ES1371_EXTENT);
  err_region:
 	kfree(s);
-	return -1;
+	return -ENODEV;
 }
 
 static void __devinit es1371_remove(struct pci_dev *dev)
