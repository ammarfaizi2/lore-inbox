Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131158AbREBHp2>; Wed, 2 May 2001 03:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131205AbREBHpT>; Wed, 2 May 2001 03:45:19 -0400
Received: from ns.caldera.de ([212.34.180.1]:49338 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S131158AbREBHpI>;
	Wed, 2 May 2001 03:45:08 -0400
Date: Wed, 2 May 2001 09:44:21 +0200
From: Marcus Meissner <Marcus.Meissner@caldera.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: PATCH: es1370 move pci_enable_device
Message-ID: <20010502094421.A24479@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This moves pci_enable_device to the correct position in es1370 and
cleans up the return values in es1370_probe.

Ciao, Marcus

Index: drivers/sound/es1370.c
===================================================================
RCS file: /build/mm/work/repository/linux-mm/drivers/sound/es1370.c,v
retrieving revision 1.13
diff -u -r1.13 es1370.c
--- drivers/sound/es1370.c	2001/04/17 17:26:05	1.13
+++ drivers/sound/es1370.c	2001/05/02 06:51:05
@@ -2560,19 +2560,21 @@
 	{ SOUND_MIXER_WRITE_OGAIN, 0x4040 }
 };
 
-#define RSRCISIOREGION(dev,num) (pci_resource_start((dev), (num)) != 0 && \
-				 pci_resource_flags((dev), (num)) & IORESOURCE_IO)
-
 static int __devinit es1370_probe(struct pci_dev *pcidev, const struct pci_device_id *pciid)
 {
 	struct es1370_state *s;
 	mm_segment_t fs;
-	int i, val;
+	int i, val, ret;
+
+	if ((ret=pci_enable_device(pcidev)))
+		return ret;
 
-	if (!RSRCISIOREGION(pcidev, 0))
-		return -1;
+	if ((!pci_resource_flags(pcidev, 0) & IORESOURCE_IO) ||
+	     !pci_resource_start(pcidev, 0)
+	)
+		return -ENODEV;
 	if (pcidev->irq == 0) 
-		return -1;
+		return -ENODEV;
 	i = pci_set_dma_mask(pcidev, 0xffffffff);
 	if (i) {
 		printk(KERN_WARNING "es1370: architecture does not support 32bit PCI busmaster DMA\n");
@@ -2580,7 +2582,7 @@
 	}
 	if (!(s = kmalloc(sizeof(struct es1370_state), GFP_KERNEL))) {
 		printk(KERN_WARNING "es1370: out of memory\n");
-		return -1;
+		return -ENOMEM;
 	}
 	memset(s, 0, sizeof(struct es1370_state));
 	init_waitqueue_head(&s->dma_adc.wait);
@@ -2597,14 +2599,14 @@
 	s->irq = pcidev->irq;
 	if (!request_region(s->io, ES1370_EXTENT, "es1370")) {
 		printk(KERN_ERR "es1370: io ports %#lx-%#lx in use\n", s->io, s->io+ES1370_EXTENT-1);
+		ret = -EBUSY;
 		goto err_region;
 	}
-	if (pci_enable_device(pcidev))
-		goto err_irq;
-	if (request_irq(s->irq, es1370_interrupt, SA_SHIRQ, "es1370", s)) {
+	if ((ret=request_irq(s->irq, es1370_interrupt, SA_SHIRQ, "es1370",s))) {
 		printk(KERN_ERR "es1370: irq %u in use\n", s->irq);
 		goto err_irq;
 	}
+
 	/* initialize codec registers */
 	/* note: setting CTRL_SERR_DIS is reported to break
 	 * mic bias setting (by Kim.Berts@fisub.mail.abb.com) */
@@ -2631,14 +2633,22 @@
 	       (s->ctrl & CTRL_XCTL0) ? "out" : "in",
 		       (s->ctrl & CTRL_XCTL1) ? "1" : "0");
 	/* register devices */
-	if ((s->dev_audio = register_sound_dsp(&es1370_audio_fops, -1)) < 0)
+	if ((s->dev_audio = register_sound_dsp(&es1370_audio_fops, -1)) < 0) {
+		ret = s->dev_audio;
 		goto err_dev1;
-	if ((s->dev_mixer = register_sound_mixer(&es1370_mixer_fops, -1)) < 0)
+	}
+	if ((s->dev_mixer = register_sound_mixer(&es1370_mixer_fops, -1)) < 0) {
+		ret = s->dev_mixer;
 		goto err_dev2;
-	if ((s->dev_dac = register_sound_dsp(&es1370_dac_fops, -1)) < 0)
+	}
+	if ((s->dev_dac = register_sound_dsp(&es1370_dac_fops, -1)) < 0) {
+		ret = s->dev_dac;
 		goto err_dev3;
-	if ((s->dev_midi = register_sound_midi(&es1370_midi_fops, -1)) < 0)
+	}
+	if ((s->dev_midi = register_sound_midi(&es1370_midi_fops, -1)) < 0) {
+		ret = s->dev_midi;
 		goto err_dev4;
+	}
 	/* initialize the chips */
 	outl(s->ctrl, s->io+ES1370_REG_CONTROL);
 	outl(s->sctrl, s->io+ES1370_REG_SERIAL_CONTROL);
@@ -2688,7 +2698,7 @@
 	release_region(s->io, ES1370_EXTENT);
  err_region:
 	kfree(s);
-	return -1;
+	return ret;
 }
 
 static void __devinit es1370_remove(struct pci_dev *dev)
