Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262745AbREOMtH>; Tue, 15 May 2001 08:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262746AbREOMs4>; Tue, 15 May 2001 08:48:56 -0400
Received: from ns.caldera.de ([212.34.180.1]:31433 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S262745AbREOMso>;
	Tue, 15 May 2001 08:48:44 -0400
Date: Tue, 15 May 2001 14:48:01 +0200
From: Marcus Meissner <Marcus.Meissner@caldera.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: PATCH: esssolo pci_enable_device / retcodes
Message-ID: <20010515144801.A20759@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this moves pci_enable_device() before resource access and cleans
up the return values.

Ciao, Marcus

Index: esssolo1.c
===================================================================
RCS file: /build/mm/work/repository/linux-mm/drivers/sound/esssolo1.c,v
retrieving revision 1.11
diff -u -r1.11 esssolo1.c
--- esssolo1.c	2001/05/09 07:08:56	1.11
+++ esssolo1.c	2001/05/15 12:46:25
@@ -77,6 +77,8 @@
  *                       Fix SETTRIGGER non OSS API conformity
  *    10.03.2001         provide abs function, prevent picking up a bogus kernel macro
  *                       for abs. Bug report by Andrew Morton <andrewm@uow.edu.au>
+ *    15.05.2001         pci_enable_device moved, return values in probe cleaned
+ *                       up. Marcus Meissner <mm@caldera.de>
  */
 
 /*****************************************************************************/
@@ -2277,22 +2279,21 @@
 	return 0;
 }
 
-
-#define RSRCISIOREGION(dev,num) (pci_resource_start((dev), (num)) != 0 && \
-				 (pci_resource_flags((dev), (num)) & IORESOURCE_IO))
-
 static int __devinit solo1_probe(struct pci_dev *pcidev, const struct pci_device_id *pciid)
 {
 	struct solo1_state *s;
 	struct pm_dev *pmdev;
+	int ret;
 
-	if (!RSRCISIOREGION(pcidev, 0) ||
-	    !RSRCISIOREGION(pcidev, 1) ||
-	    !RSRCISIOREGION(pcidev, 2) ||
-	    !RSRCISIOREGION(pcidev, 3))
-		return -1;
+ 	if ((ret=pci_enable_device(pcidev)))
+		return ret;
+	if (!(pci_resource_flags(pcidev, 0) & IORESOURCE_IO) ||
+	    !(pci_resource_flags(pcidev, 1) & IORESOURCE_IO) ||
+	    !(pci_resource_flags(pcidev, 2) & IORESOURCE_IO) ||
+	    !(pci_resource_flags(pcidev, 3) & IORESOURCE_IO))
+		return -ENODEV;
 	if (pcidev->irq == 0)
-		return -1;
+		return -ENODEV;
 
 	/* Recording requires 24-bit DMA, so attempt to set dma mask
 	 * to 24 bits first, then 32 bits (playback only) if that fails.
@@ -2300,12 +2301,12 @@
 	if (pci_set_dma_mask(pcidev, 0x00ffffff) &&
 	    pci_set_dma_mask(pcidev, 0xffffffff)) {
 		printk(KERN_WARNING "solo1: architecture does not support 24bit or 32bit PCI busmaster DMA\n");
-		return -1;
+		return -ENODEV;
 	}
 
 	if (!(s = kmalloc(sizeof(struct solo1_state), GFP_KERNEL))) {
 		printk(KERN_WARNING "solo1: out of memory\n");
-		return -1;
+		return -ENOMEM;
 	}
 	memset(s, 0, sizeof(struct solo1_state));
 	init_waitqueue_head(&s->dma_adc.wait);
@@ -2325,6 +2326,7 @@
 	s->gameport.io = pci_resource_start(pcidev, 4);
 	s->gameport.size = pci_resource_len(pcidev,4);
 	s->irq = pcidev->irq;
+	ret = -EBUSY;
 	if (!request_region(s->iobase, IOBASE_EXTENT, "ESS Solo1")) {
 		printk(KERN_ERR "solo1: io ports in use\n");
 		goto err_region1;
@@ -2347,24 +2349,32 @@
 		printk(KERN_ERR "solo1: gameport io ports in use\n");
 		s->gameport.io = s->gameport.size = 0;
 	}
-	if (request_irq(s->irq, solo1_interrupt, SA_SHIRQ, "ESS Solo1", s)) {
+	if ((ret=request_irq(s->irq,solo1_interrupt,SA_SHIRQ,"ESS Solo1",s))) {
 		printk(KERN_ERR "solo1: irq %u in use\n", s->irq);
 		goto err_irq;
 	}
- 	if (pci_enable_device(pcidev))
-		goto err_irq;
 	printk(KERN_INFO "solo1: joystick port at %#x\n", s->gameport.io+1);
 	/* register devices */
-	if ((s->dev_audio = register_sound_dsp(&solo1_audio_fops, -1)) < 0)
+	if ((s->dev_audio = register_sound_dsp(&solo1_audio_fops, -1)) < 0) {
+		ret = s->dev_audio;
 		goto err_dev1;
-	if ((s->dev_mixer = register_sound_mixer(&solo1_mixer_fops, -1)) < 0)
+	}
+	if ((s->dev_mixer = register_sound_mixer(&solo1_mixer_fops, -1)) < 0) {
+		ret = s->dev_mixer;
 		goto err_dev2;
-	if ((s->dev_midi = register_sound_midi(&solo1_midi_fops, -1)) < 0)
+	}
+	if ((s->dev_midi = register_sound_midi(&solo1_midi_fops, -1)) < 0) {
+		ret = s->dev_midi;
 		goto err_dev3;
-	if ((s->dev_dmfm = register_sound_special(&solo1_dmfm_fops, 15 /* ?? */)) < 0)
+	}
+	if ((s->dev_dmfm = register_sound_special(&solo1_dmfm_fops, 15 /* ?? */)) < 0) {
+		ret = s->dev_dmfm;
 		goto err_dev4;
-	if (setup_solo1(s))
+	}
+	if (setup_solo1(s)) {
+		ret = -EIO;
 		goto err;
+	}
 	/* register gameport */
 	gameport_register_port(&s->gameport);
 	/* store it in the driver field */
@@ -2401,7 +2411,7 @@
 	release_region(s->mpubase, MPUBASE_EXTENT);
  err_region1:
 	kfree(s);
-	return -1;
+	return ret;
 }
 
 static void __devinit solo1_remove(struct pci_dev *dev)
