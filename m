Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130552AbRDRQaK>; Wed, 18 Apr 2001 12:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132633AbRDRQaB>; Wed, 18 Apr 2001 12:30:01 -0400
Received: from ns.caldera.de ([212.34.180.1]:23049 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S130552AbRDRQ3v>;
	Wed, 18 Apr 2001 12:29:51 -0400
Date: Wed, 18 Apr 2001 18:29:45 +0200
From: Marcus Meissner <Marcus.Meissner@caldera.de>
To: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] misplaced pci_enable_device()s in drivers/sound/
Message-ID: <20010418182944.A25024@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Several pci_enable_device()s in drivers/sound happen _after_ accessing 
PCI resources. I have moved them before the relevant first accesses.

(Untested, but should work.)

Against 2.4.3-ac9.

Ciao, Marcus

Index: es1370.c
===================================================================
RCS file: /build/mm/work/repository/linux-mm/drivers/sound/es1370.c,v
retrieving revision 1.13
diff -u -r1.13 es1370.c
--- es1370.c	2001/04/17 17:26:05	1.13
+++ es1370.c	2001/04/18 16:24:05
@@ -2569,6 +2569,9 @@
 	mm_segment_t fs;
 	int i, val;
 
+	if (pci_enable_device(pcidev))
+		return -1;
+
 	if (!RSRCISIOREGION(pcidev, 0))
 		return -1;
 	if (pcidev->irq == 0) 
@@ -2599,8 +2602,6 @@
 		printk(KERN_ERR "es1370: io ports %#lx-%#lx in use\n", s->io, s->io+ES1370_EXTENT-1);
 		goto err_region;
 	}
-	if (pci_enable_device(pcidev))
-		goto err_irq;
 	if (request_irq(s->irq, es1370_interrupt, SA_SHIRQ, "es1370", s)) {
 		printk(KERN_ERR "es1370: irq %u in use\n", s->irq);
 		goto err_irq;
Index: es1371.c
===================================================================
RCS file: /build/mm/work/repository/linux-mm/drivers/sound/es1371.c,v
retrieving revision 1.7
diff -u -r1.7 es1371.c
--- es1371.c	2001/04/17 17:26:05	1.7
+++ es1371.c	2001/04/18 16:24:20
@@ -2783,6 +2783,9 @@
 	signed long tmo2;
 	unsigned int cssr;
 
+	if (pci_enable_device(pcidev))
+		return -1;
+
 	if (!RSRCISIOREGION(pcidev, 0))
 		return -1;
 	if (pcidev->irq == 0) 
@@ -2822,8 +2825,6 @@
 		printk(KERN_ERR PFX "io ports %#lx-%#lx in use\n", s->io, s->io+ES1371_EXTENT-1);
 		goto err_region;
 	}
-	if (pci_enable_device(pcidev))
-		goto err_irq;
 	if (request_irq(s->irq, es1371_interrupt, SA_SHIRQ, "es1371", s)) {
 		printk(KERN_ERR PFX "irq %u in use\n", s->irq);
 		goto err_irq;
Index: esssolo1.c
===================================================================
RCS file: /build/mm/work/repository/linux-mm/drivers/sound/esssolo1.c,v
retrieving revision 1.7
diff -u -r1.7 esssolo1.c
--- esssolo1.c	2001/04/17 17:26:05	1.7
+++ esssolo1.c	2001/04/18 16:24:35
@@ -2297,6 +2297,8 @@
 	struct solo1_state *s;
 	struct pm_dev *pmdev;
 
+ 	if (pci_enable_device(pcidev))
+		return -1;
 	if (!RSRCISIOREGION(pcidev, 0) ||
 	    !RSRCISIOREGION(pcidev, 1) ||
 	    !RSRCISIOREGION(pcidev, 2) ||
@@ -2362,8 +2364,6 @@
 		printk(KERN_ERR "solo1: irq %u in use\n", s->irq);
 		goto err_irq;
 	}
- 	if (pci_enable_device(pcidev))
-		goto err_irq;
 	printk(KERN_INFO "solo1: joystick port at %#x\n", s->gameport.io+1);
 	/* register devices */
 	if ((s->dev_audio = register_sound_dsp(&solo1_audio_fops, -1)) < 0)
Index: maestro.c
===================================================================
RCS file: /build/mm/work/repository/linux-mm/drivers/sound/maestro.c,v
retrieving revision 1.4
diff -u -r1.4 maestro.c
--- maestro.c	2001/04/17 15:49:10	1.4
+++ maestro.c	2001/04/18 16:25:21
@@ -3321,6 +3321,9 @@
 	/* don't pick up weird modem maestros */
 	if(((pcidev->class >> 8) & 0xffff) != PCI_CLASS_MULTIMEDIA_AUDIO)
 		return 0;
+
+	if (pci_enable_device(pcidev))
+		return 0;
 			
 	iobase = SILLY_PCI_BASE_ADDRESS(pcidev); 
 
@@ -3406,19 +3409,6 @@
 	}
 	
 	ess = &card->channels[0];
-
-	if (pci_enable_device(pcidev)) {
-		printk (KERN_ERR "maestro: pci_enable_device() failed\n");
-		for (i = 0; i < NR_DSPS; i++) {
-			struct ess_state *s = &card->channels[i];
-			if (s->dev_audio != -1)
-				unregister_sound_dsp(s->dev_audio);
-		}
-		release_region(card->iobase, 256);
-		unregister_reboot_notifier(&maestro_nb);
-		kfree(card);
-		return 0;
-	}
 
 	/*
 	 *	Ok card ready. Begin setup proper
Index: sonicvibes.c
===================================================================
RCS file: /build/mm/work/repository/linux-mm/drivers/sound/sonicvibes.c,v
retrieving revision 1.7
diff -u -r1.7 sonicvibes.c
--- sonicvibes.c	2001/04/17 17:26:05	1.7
+++ sonicvibes.c	2001/04/18 16:26:01
@@ -2508,6 +2508,8 @@
 	char *ddmaname;
 	unsigned ddmanamelen;
 
+	if (pci_enable_device(pcidev))
+		return -1;
 	if (!RSRCISIOREGION(pcidev, RESOURCE_SB) ||
 	    !RSRCISIOREGION(pcidev, RESOURCE_ENH) ||
 	    !RSRCISIOREGION(pcidev, RESOURCE_SYNTH) ||
@@ -2594,8 +2596,6 @@
 		printk(KERN_ERR "sv: gameport io ports in use\n");
 		s->gameport.io = s->gameport.size = 0;
 	}
-	if (pci_enable_device(pcidev))
-		goto err_irq;
 	/* initialize codec registers */
 	outb(0x80, s->ioenh + SV_CODEC_CONTROL); /* assert reset */
 	udelay(50);
Index: trident.c
===================================================================
RCS file: /build/mm/work/repository/linux-mm/drivers/sound/trident.c,v
retrieving revision 1.11
diff -u -r1.11 trident.c
--- trident.c	2001/04/17 17:26:05	1.11
+++ trident.c	2001/04/18 16:26:18
@@ -3309,6 +3309,9 @@
 	struct trident_card *card;
 	u8 revision;
 
+	if (pci_enable_device(pci_dev))
+	    return -ENODEV;
+
 	if (pci_set_dma_mask(pci_dev, TRIDENT_DMA_MASK)) {
 		printk(KERN_ERR "trident: architecture does not support"
 		       " 30bit PCI busmaster DMA\n");
@@ -3322,9 +3325,6 @@
 		       iobase);
 		return -ENODEV;
 	}
-
-	if (pci_enable_device(pci_dev))
-	    return -ENODEV;
 
 	if ((card = kmalloc(sizeof(struct trident_card), GFP_KERNEL)) == NULL) {
 		printk(KERN_ERR "trident: out of memory\n");
Index: via82cxxx_audio.c
===================================================================
RCS file: /build/mm/work/repository/linux-mm/drivers/sound/via82cxxx_audio.c,v
retrieving revision 1.6
diff -u -r1.6 via82cxxx_audio.c
--- via82cxxx_audio.c	2001/04/17 16:38:46	1.6
+++ via82cxxx_audio.c	2001/04/18 16:26:29
@@ -3020,17 +3020,17 @@
 	if (printed_version++ == 0)
 		printk (KERN_INFO "Via 686a audio driver " VIA_VERSION "\n");
 
+	if (pci_enable_device (pdev)) {
+		rc = -EIO;
+		goto err_out_none;
+	}
+
 	if (!request_region (pci_resource_start (pdev, 0),
 	    		     pci_resource_len (pdev, 0),
 			     VIA_MODULE_NAME)) {
 		printk (KERN_ERR PFX "unable to obtain I/O resources, aborting\n");
 		rc = -EBUSY;
 		goto err_out;
-	}
-
-	if (pci_enable_device (pdev)) {
-		rc = -EIO;
-		goto err_out_none;
 	}
 
 	card = kmalloc (sizeof (*card), GFP_KERNEL);
Index: emu10k1/main.c
===================================================================
RCS file: /build/mm/work/repository/linux-mm/drivers/sound/emu10k1/main.c,v
retrieving revision 1.3
diff -u -r1.3 main.c
--- emu10k1/main.c	2001/04/17 16:55:42	1.3
+++ emu10k1/main.c	2001/04/18 16:27:07
@@ -613,6 +613,9 @@
 	struct emu10k1_card *card;
 	u32 subsysvid;
 
+	if (pci_enable_device(pci_dev))
+		return -ENODEV;
+
 	if ((card = kmalloc(sizeof(struct emu10k1_card), GFP_KERNEL)) == NULL) {
 		printk(KERN_ERR "emu10k1: out of memory\n");
 		return -ENOMEM;
@@ -621,11 +624,6 @@
 
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
