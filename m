Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130970AbRCMPHR>; Tue, 13 Mar 2001 10:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131012AbRCMPHI>; Tue, 13 Mar 2001 10:07:08 -0500
Received: from ns.caldera.de ([212.34.180.1]:61189 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S130970AbRCMPGx>;
	Tue, 13 Mar 2001 10:06:53 -0500
Date: Tue, 13 Mar 2001 16:05:29 +0100
From: Marcus Meissner <Marcus.Meissner@caldera.de>
To: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: PATCH: pci_enable_device fixes for sound/* and block/cpqarray and block/cciss
Message-ID: <20010313160529.A8342@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan, linux-kernel,

This moves all pci_enable_device()s before any resource usage in 
sound/*.c,sound/*/*.c and block/cciss.c, block/cpqarray.c.

I have NOT tested them except the es1370, but they should be correct as
is.

Note that it was missing in nm256_audio.c.

Ciao, Marcus

--- linux/drivers/block/cciss.c.marcus	Tue Mar 13 14:23:52 2001
+++ linux/drivers/block/cciss.c	Tue Mar 13 14:23:55 2001
@@ -1438,9 +1438,13 @@
 	int cfg_offset;
 	int cfg_base_addr;
 	int cfg_base_addr_index;
-	int i;
+	int i, err;
 
 	pdev = pci_find_slot(bus, device_fn);
+
+	if ((err=pci_enable_device(pdev)))
+		return err;
+	
 	vendor_id = pdev->vendor;
 	device_id = pdev->device;
 	irq = pdev->irq;
@@ -1448,9 +1452,6 @@
 	for(i=0; i<6; i++)
 		addr[i] = pdev->resource[i].start;
 
-	if (pci_enable_device(pdev))
-		return( -1);
-	
 	(void) pci_read_config_word(pdev, PCI_COMMAND,&command);
 	(void) pci_read_config_byte(pdev, PCI_CLASS_REVISION, &revision);
 	(void) pci_read_config_byte(pdev, PCI_CACHE_LINE_SIZE,
--- linux/drivers/block/cpqarray.c.marcus	Tue Feb 13 23:13:43 2001
+++ linux/drivers/block/cpqarray.c	Tue Mar 13 14:23:55 2001
@@ -635,10 +635,13 @@
 	unchar irq, revision;
 	unsigned long addr[6];
 	__u32 board_id;
-
-	int i;
+	int i, err;
 
 	c->pci_dev = pdev;
+
+	if ((err=pci_enable_device(pdev)))
+		return err;
+
 	vendor_id = pdev->vendor;
 	device_id = pdev->device;
 	irq = pdev->irq;
@@ -646,9 +649,6 @@
 	for(i=0; i<6; i++)
 		addr[i] = pci_resource_start(pdev, i);
 
-	if (pci_enable_device(pdev))
-		return -1;
-
 	pci_read_config_word(pdev, PCI_COMMAND, &command);
 	pci_read_config_byte(pdev, PCI_CLASS_REVISION, &revision);
 	pci_read_config_byte(pdev, PCI_CACHE_LINE_SIZE, &cache_line_size);
--- linux/drivers/sound/emu10k1/main.c.marcus	Fri Feb  9 20:30:23 2001
+++ linux/drivers/sound/emu10k1/main.c	Tue Mar 13 14:23:55 2001
@@ -612,6 +612,10 @@
 {
 	struct emu10k1_card *card;
 	u32 subsysvid;
+	int err;
+
+	if ((err=pci_enable_device(pci_dev)))
+		return err;
 
 	if ((card = kmalloc(sizeof(struct emu10k1_card), GFP_KERNEL)) == NULL) {
 		printk(KERN_ERR "emu10k1: out of memory\n");
@@ -624,11 +628,6 @@
 		kfree(card);
 		return -ENODEV;
 	}
-
-	if (pci_enable_device(pci_dev)) {
-		kfree(card);
-		return -ENODEV;
-	}
 
 	pci_set_master(pci_dev);
 
--- linux/drivers/sound/cs46xx.c.marcus	Tue Mar 13 14:23:54 2001
+++ linux/drivers/sound/cs46xx.c	Tue Mar 13 14:25:33 2001
@@ -4054,7 +4054,10 @@
 	struct pm_dev *pmdev;
 #endif
 	u16 ss_card, ss_vendor;
+	int err;
 	
+	if ((err=pci_enable_device(pci_dev)))
+		return err;
 	
 	pci_read_config_word(pci_dev, PCI_SUBSYSTEM_VENDOR_ID, &ss_vendor);
 	pci_read_config_word(pci_dev, PCI_SUBSYSTEM_ID, &ss_card);
--- linux/drivers/sound/es1370.c.marcus	Tue Mar 13 14:23:54 2001
+++ linux/drivers/sound/es1370.c	Tue Mar 13 14:23:55 2001
@@ -2519,7 +2519,10 @@
 {
 	struct es1370_state *s;
 	mm_segment_t fs;
-	int i, val;
+	int i, val, err;
+
+	if ((err=pci_enable_device(pcidev)))
+		return err;
 
 	if (!RSRCISIOREGION(pcidev, 0))
 		return -1;
@@ -2550,8 +2553,6 @@
 		printk(KERN_ERR "es1370: io ports %#lx-%#lx in use\n", s->io, s->io+ES1370_EXTENT-1);
 		goto err_region;
 	}
-	if (pci_enable_device(pcidev))
-		goto err_irq;
 	if (request_irq(s->irq, es1370_interrupt, SA_SHIRQ, "es1370", s)) {
 		printk(KERN_ERR "es1370: irq %u in use\n", s->irq);
 		goto err_irq;
--- linux/drivers/sound/es1371.c.marcus	Fri Feb  9 20:30:23 2001
+++ linux/drivers/sound/es1371.c	Tue Mar 13 14:23:55 2001
@@ -2728,11 +2728,13 @@
 {
 	struct es1371_state *s;
 	mm_segment_t fs;
-	int i, val;
+	int i, val, err;
 	unsigned long tmo;
 	signed long tmo2;
 	unsigned int cssr;
 
+	if ((err=pci_enable_device(pcidev)))
+		return err;
 	if (!RSRCISIOREGION(pcidev, 0))
 		return -1;
 	if (pcidev->irq == 0) 
@@ -2771,8 +2773,6 @@
 		printk(KERN_ERR PFX "io ports %#lx-%#lx in use\n", s->io, s->io+ES1371_EXTENT-1);
 		goto err_region;
 	}
-	if (pci_enable_device(pcidev))
-		goto err_irq;
 	if (request_irq(s->irq, es1371_interrupt, SA_SHIRQ, "es1371", s)) {
 		printk(KERN_ERR PFX "irq %u in use\n", s->irq);
 		goto err_irq;
--- linux/drivers/sound/esssolo1.c.marcus	Fri Feb  9 20:30:23 2001
+++ linux/drivers/sound/esssolo1.c	Tue Mar 13 14:23:55 2001
@@ -2245,7 +2245,10 @@
 	struct solo1_state *s;
 	struct pm_dev *pmdev;
 	dma_addr_t dma_mask;
+	int err;
 
+ 	if ((err=pci_enable_device(pcidev)))
+		return err;
 	if (!RSRCISIOREGION(pcidev, 0) ||
 	    !RSRCISIOREGION(pcidev, 1) ||
 	    !RSRCISIOREGION(pcidev, 2) ||
@@ -2302,8 +2305,6 @@
 		printk(KERN_ERR "solo1: irq %u in use\n", s->irq);
 		goto err_irq;
 	}
- 	if (pci_enable_device(pcidev))
-		goto err_irq;
 	printk(KERN_INFO "solo1: joystick port at %#lx\n", s->gpbase+1);
 	/* register devices */
 	if ((s->dev_audio = register_sound_dsp(&solo1_audio_fops, -1)) < 0)
--- linux/drivers/sound/i810_audio.c.marcus	Tue Mar 13 14:23:54 2001
+++ linux/drivers/sound/i810_audio.c	Tue Mar 13 14:23:55 2001
@@ -2074,6 +2074,10 @@
 static int __init i810_probe(struct pci_dev *pci_dev, const struct pci_device_id *pci_id)
 {
 	struct i810_card *card;
+	int err;
+
+	if ((err=pci_enable_device(pci_dev)))
+		return err;
 
 	if (!pci_dma_supported(pci_dev, I810_DMA_MASK)) {
 		printk(KERN_ERR "intel810: architecture does not support"
@@ -2081,8 +2085,6 @@
 		return -ENODEV;
 	}
 
-	if (pci_enable_device(pci_dev))
-		return -EIO;
 	if ((card = kmalloc(sizeof(struct i810_card), GFP_KERNEL)) == NULL) {
 		printk(KERN_ERR "i810_audio: out of memory\n");
 		return -ENOMEM;
--- linux/drivers/sound/maestro.c.marcus	Tue Mar 13 14:23:54 2001
+++ linux/drivers/sound/maestro.c	Tue Mar 13 14:23:55 2001
@@ -3322,6 +3322,9 @@
 	if(((pcidev->class >> 8) & 0xffff) != PCI_CLASS_MULTIMEDIA_AUDIO)
 		return 0;
 			
+	if (pci_enable_device(pcidev))
+		return 0;
+
 	iobase = SILLY_PCI_BASE_ADDRESS(pcidev); 
 
 	/* stake our claim on the iospace */
@@ -3407,19 +3410,6 @@
 	
 	ess = &card->channels[0];
 
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
-
 	/*
 	 *	Ok card ready. Begin setup proper
 	 */
--- linux/drivers/sound/maestro3.c.marcus	Tue Mar 13 14:23:54 2001
+++ linux/drivers/sound/maestro3.c	Tue Mar 13 14:23:55 2001
@@ -2590,19 +2590,19 @@
     u32 n;
     int i;
     struct m3_card *card = NULL;
-    int ret = 0;
+    int ret = 0, err;
     int card_type = pci_id->driver_data;
 
     DPRINTK(DPMOD, "in maestro_install\n");
 
+    if ((err=pci_enable_device(pci_dev)))
+        return err;
+
     if (!pci_dma_supported(pci_dev, M3_PCI_DMA_MASK)) {
         printk(KERN_ERR PFX "architecture does not support limiting to 28bit PCI bus addresses\n");
         return -ENODEV;
     }
         
-    if (pci_enable_device(pci_dev))
-        return -EIO;
-
     pci_set_master(pci_dev);
 
     pci_dev->dma_mask = M3_PCI_DMA_MASK;
--- linux/drivers/sound/nm256_audio.c.marcus	Sun Nov 12 03:33:14 2000
+++ linux/drivers/sound/nm256_audio.c	Tue Mar 13 14:23:55 2001
@@ -1040,7 +1040,10 @@
 {
     struct nm256_info *card;
     struct pm_dev *pmdev;
-    int x;
+    int x, err;
+
+    if ((err=pci_enable_device(pcidev)))
+	return err;
 
     card = kmalloc (sizeof (struct nm256_info), GFP_KERNEL);
     if (card == NULL) {
--- linux/drivers/sound/sonicvibes.c.marcus	Fri Feb  9 20:30:23 2001
+++ linux/drivers/sound/sonicvibes.c	Tue Mar 13 14:23:55 2001
@@ -2466,10 +2466,13 @@
 	static const char __initdata sv_ddma_name[] = "S3 Inc. SonicVibes DDMA Controller";
        	struct sv_state *s;
 	mm_segment_t fs;
-	int i, val;
+	int i, val, err;
 	char *ddmaname;
 	unsigned ddmanamelen;
 
+	if ((err=pci_enable_device(pcidev)))
+		return err;
+
 	if (!RSRCISIOREGION(pcidev, RESOURCE_SB) ||
 	    !RSRCISIOREGION(pcidev, RESOURCE_ENH) ||
 	    !RSRCISIOREGION(pcidev, RESOURCE_SYNTH) ||
@@ -2549,8 +2552,6 @@
 		printk(KERN_ERR "sv: io ports %#lx-%#lx in use\n", s->iosynth, s->iosynth+SV_EXTENT_SYNTH-1);
 		goto err_region1;
 	}
-	if (pci_enable_device(pcidev))
-		goto err_irq;
 	/* initialize codec registers */
 	outb(0x80, s->ioenh + SV_CODEC_CONTROL); /* assert reset */
 	udelay(50);
--- linux/drivers/sound/trident.c.marcus	Tue Mar 13 14:23:54 2001
+++ linux/drivers/sound/trident.c	Tue Mar 13 14:23:55 2001
@@ -3308,6 +3308,10 @@
 	unsigned long iobase;
 	struct trident_card *card;
 	u8 revision;
+	int err;
+
+	if ((err=pci_enable_device(pci_dev)))
+	    return err;
 
 	if (!pci_dma_supported(pci_dev, TRIDENT_DMA_MASK)) {
 		printk(KERN_ERR "trident: architecture does not support"
@@ -3323,9 +3327,6 @@
 		return -ENODEV;
 	}
 
-	if (pci_enable_device(pci_dev))
-	    return -ENODEV;
-
 	if ((card = kmalloc(sizeof(struct trident_card), GFP_KERNEL)) == NULL) {
 		printk(KERN_ERR "trident: out of memory\n");
 		return -ENOMEM;
--- linux/drivers/sound/via82cxxx_audio.c.marcus	Tue Mar 13 14:23:54 2001
+++ linux/drivers/sound/via82cxxx_audio.c	Tue Mar 13 14:23:55 2001
@@ -3010,7 +3010,7 @@
 
 static int __init via_init_one (struct pci_dev *pdev, const struct pci_device_id *id)
 {
-	int rc;
+	int rc, err;
 	struct via_info *card;
 	u8 tmp;
 	static int printed_version = 0;
@@ -3020,6 +3020,9 @@
 	if (printed_version++ == 0)
 		printk (KERN_INFO "Via 686a audio driver " VIA_VERSION "\n");
 
+	if ((err=pci_enable_device (pdev)))
+		return err;
+
 	if (!request_region (pci_resource_start (pdev, 0),
 	    		     pci_resource_len (pdev, 0),
 			     VIA_MODULE_NAME)) {
@@ -3028,10 +3031,6 @@
 		goto err_out;
 	}
 
-	if (pci_enable_device (pdev)) {
-		rc = -EIO;
-		goto err_out_none;
-	}
 
 	card = kmalloc (sizeof (*card), GFP_KERNEL);
 	if (!card) {
