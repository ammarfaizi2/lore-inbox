Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129141AbRBKCym>; Sat, 10 Feb 2001 21:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131686AbRBKCyd>; Sat, 10 Feb 2001 21:54:33 -0500
Received: from [194.73.73.176] ([194.73.73.176]:27342 "EHLO protactinium")
	by vger.kernel.org with ESMTP id <S129141AbRBKCyT>;
	Sat, 10 Feb 2001 21:54:19 -0500
Date: Sun, 11 Feb 2001 02:52:31 +0000 (GMT)
From: <davej@suse.de>
X-X-Sender: <davej@athlon.local>
To: Alan Cox <alan@redhat.com>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, <zab@zabbo.net>,
        <sailer@ife.ee.ethz.ch>, <zaitcev@metabyte.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Sound drivers pci_enable_device clean_up
Message-ID: <Pine.LNX.4.31.0102110247030.4383-100000@athlon.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi guys,
 Here's a small fixup to your respective drivers to make
pci_enable_device() calls happen before reading irq/resources.

regards,

Davej.


-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs


diff -urN --exclude-from=/home/davej/.exclude linux/drivers/sound/es1370.c linux-dj/drivers/sound/es1370.c
--- linux/drivers/sound/es1370.c	Sat Feb 10 02:49:52 2001
+++ linux-dj/drivers/sound/es1370.c	Sat Feb 10 03:05:52 2001
@@ -117,6 +117,7 @@
  *                       Tim Janik's BSE (Bedevilled Sound Engine) found this
  *    07.02.2000   0.33  Use pci_alloc_consistent and pci_register_driver
  *    21.11.2000   0.34  Initialize dma buffers in poll, otherwise poll may return a bogus mask
+ *    09.02.2001   0.35  pci_enable_device before reading irq/resources <davej@suse.de>
  *
  * some important things missing in Ensoniq documentation:
  *
@@ -2544,14 +2545,21 @@
 	spin_lock_init(&s->lock);
 	s->magic = ES1370_MAGIC;
 	s->dev = pcidev;
+
+	i = pci_enable_device(pcidev);
+	if (i) {
+		kfree(s);
+		return i;
+	}
+
 	s->io = pci_resource_start(pcidev, 0);
 	s->irq = pcidev->irq;
+
 	if (!request_region(s->io, ES1370_EXTENT, "es1370")) {
 		printk(KERN_ERR "es1370: io ports %#lx-%#lx in use\n", s->io, s->io+ES1370_EXTENT-1);
 		goto err_region;
 	}
-	if (pci_enable_device(pcidev))
-		goto err_irq;
+
 	if (request_irq(s->irq, es1370_interrupt, SA_SHIRQ, "es1370", s)) {
 		printk(KERN_ERR "es1370: irq %u in use\n", s->irq);
 		goto err_irq;
@@ -2671,7 +2679,7 @@
 {
 	if (!pci_present())   /* No PCI bus in this machine! */
 		return -ENODEV;
-	printk(KERN_INFO "es1370: version v0.34 time " __TIME__ " " __DATE__ "\n");
+	printk(KERN_INFO "es1370: version v0.35 time " __TIME__ " " __DATE__ "\n");
 	return pci_module_init(&es1370_driver);
 }

diff -urN --exclude-from=/home/davej/.exclude linux/drivers/sound/es1371.c linux-dj/drivers/sound/es1371.c
--- linux/drivers/sound/es1371.c	Sat Feb 10 02:49:52 2001
+++ linux-dj/drivers/sound/es1371.c	Sat Feb 10 03:05:52 2001
@@ -102,6 +102,7 @@
  *    01.03.2000   0.26  SPDIF patch by Mikael Bouillot <mikael.bouillot@bigfoot.com>
  *                       Use pci_module_init
  *    21.11.2000   0.27  Initialize dma buffers in poll, otherwise poll may return a bogus mask
+ *    09.02.2001   0.28  pci_enable_device before reading irq/resources <davej@suse.de>
  */

 /*****************************************************************************/
@@ -2756,6 +2757,13 @@
 	spin_lock_init(&s->lock);
 	s->magic = ES1371_MAGIC;
 	s->dev = pcidev;
+
+	i = pci_enable_device(pcidev);
+	if (i) {
+		kfree(s);
+		return i;
+	}
+
 	s->io = pci_resource_start(pcidev, 0);
 	s->irq = pcidev->irq;
 	s->vendor = pcidev->vendor;
@@ -2771,8 +2779,6 @@
 		printk(KERN_ERR PFX "io ports %#lx-%#lx in use\n", s->io, s->io+ES1371_EXTENT-1);
 		goto err_region;
 	}
-	if (pci_enable_device(pcidev))
-		goto err_irq;
 	if (request_irq(s->irq, es1371_interrupt, SA_SHIRQ, "es1371", s)) {
 		printk(KERN_ERR PFX "irq %u in use\n", s->irq);
 		goto err_irq;
@@ -2942,7 +2948,7 @@
 {
 	if (!pci_present())   /* No PCI bus in this machine! */
 		return -ENODEV;
-	printk(KERN_INFO PFX "version v0.27 time " __TIME__ " " __DATE__ "\n");
+	printk(KERN_INFO PFX "version v0.28 time " __TIME__ " " __DATE__ "\n");
 	return pci_module_init(&es1371_driver);
 }

diff -urN --exclude-from=/home/davej/.exclude linux/drivers/sound/esssolo1.c linux-dj/drivers/sound/esssolo1.c
--- linux/drivers/sound/esssolo1.c	Sat Feb 10 02:49:52 2001
+++ linux-dj/drivers/sound/esssolo1.c	Sat Feb 10 03:05:52 2001
@@ -70,6 +70,7 @@
  *    19.02.2000   0.14  Use pci_dma_supported to determine if recording should be disabled
  *    13.03.2000   0.15  Reintroduce initialization of a couple of PCI config space registers
  *    21.11.2000   0.16  Initialize dma buffers in poll, otherwise poll may return a bogus mask
+ *    09.02.2001   0.17  pci_enable_device before reading irq/resources <davej@suse.de>
  */

 /*****************************************************************************/
@@ -2275,6 +2276,11 @@
 	spin_lock_init(&s->lock);
 	s->magic = SOLO1_MAGIC;
 	s->dev = pcidev;
+ 	i = pci_enable_device(pcidev);
+	if (i) {
+		kfree (s);
+		return i;
+	}
 	s->iobase = pci_resource_start(pcidev, 0);
 	s->sbbase = pci_resource_start(pcidev, 1);
 	s->vcbase = pci_resource_start(pcidev, 2);
@@ -2302,8 +2308,6 @@
 		printk(KERN_ERR "solo1: irq %u in use\n", s->irq);
 		goto err_irq;
 	}
- 	if (pci_enable_device(pcidev))
-		goto err_irq;
 	printk(KERN_INFO "solo1: joystick port at %#lx\n", s->gpbase+1);
 	/* register devices */
 	if ((s->dev_audio = register_sound_dsp(&solo1_audio_fops, -1)) < 0)
@@ -2397,7 +2401,7 @@
 {
 	if (!pci_present())   /* No PCI bus in this machine! */
 		return -ENODEV;
-	printk(KERN_INFO "solo1: version v0.16 time " __TIME__ " " __DATE__ "\n");
+	printk(KERN_INFO "solo1: version v0.17 time " __TIME__ " " __DATE__ "\n");
 	if (!pci_register_driver(&solo1_driver)) {
 		pci_unregister_driver(&solo1_driver);
                 return -ENODEV;
diff -urN --exclude-from=/home/davej/.exclude linux/drivers/sound/maestro.c linux-dj/drivers/sound/maestro.c
--- linux/drivers/sound/maestro.c	Sat Feb 10 02:49:52 2001
+++ linux-dj/drivers/sound/maestro.c	Sat Feb 10 03:05:52 2001
@@ -115,6 +115,9 @@
  *	themselves, but we'll see.
  *
  * History
+ *  (0.14 still?) - Dave Jones <davej@suse.de>
+ *  Reworked PCI init code to pci_enable_device before reading
+ *  irq / resources.
  *  (still kind of v0.14) Nov 23 - Alan Cox <alan@redhat.com>
  *	Add clocking= for people with seriously warped hardware
  *  (still v0.14) Nov 10 2000 - Bartlomiej Zolnierkiewicz <bkz@linux-ide.org>
@@ -3322,6 +3325,13 @@
 	if(((pcidev->class >> 8) & 0xffff) != PCI_CLASS_MULTIMEDIA_AUDIO)
 		return 0;

+	if (pci_enable_device(pcidev)) {
+		printk (KERN_ERR "maestro: pci_enable_device() failed\n");
+		return 0;
+	}
+	/* just to be sure */
+	pci_set_master(pcidev);
+
 	iobase = SILLY_PCI_BASE_ADDRESS(pcidev);

 	/* stake our claim on the iospace */
@@ -3336,9 +3346,6 @@
 		printk(KERN_WARNING "maestro: pci subsystem reports irq 0, this might not be correct.\n");
 	}

-	/* just to be sure */
-	pci_set_master(pcidev);
-
 	card = kmalloc(sizeof(struct ess_card), GFP_KERNEL);
 	if(card == NULL)
 	{
@@ -3407,19 +3414,6 @@

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
@@ -3432,7 +3426,7 @@
 	/* turn off power management unless:
 	 *	- the user explicitly asks for it
 	 * 		or
-	 *		- we're not a 2e, lesser chipps seem to have problems.
+	 *		- we're not a 2e, lesser chips seem to have problems.
 	 *		- we're not on our _very_ small whitelist.  some implemenetations
 	 *			really dont' like the pm code, others require it.
 	 *			feel free to expand this as required.
diff -urN --exclude-from=/home/davej/.exclude linux/drivers/sound/maestro3.c linux-dj/drivers/sound/maestro3.c
--- linux/drivers/sound/maestro3.c	Sat Feb 10 02:49:52 2001
+++ linux-dj/drivers/sound/maestro3.c	Sat Feb 10 03:05:53 2001
@@ -28,6 +28,8 @@
  * Shouts go out to Mike "DJ XPCom" Ang.
  *
  * History
+ *  v1.22 - Feb 09 2001 - Dave Jones <davej@suse.de>
+ *   pci_enable_device cleanup
  *  v1.21 - Feb 04 2001 - Zach Brown <zab@zabbo.net>
  *   fix up really dumb notifier -> suspend oops
  *  v1.20 - Jan 30 2001 - Zach Brown <zab@zabbo.net>
@@ -2588,7 +2590,7 @@
     u32 n;
     int i;
     struct m3_card *card = NULL;
-    int ret = 0;
+    int ret;
     int card_type = pci_id->driver_data;

     DPRINTK(DPMOD, "in maestro_install\n");
@@ -2598,8 +2600,8 @@
         return -ENODEV;
     }

-    if (pci_enable_device(pci_dev))
-        return -EIO;
+    ret = pci_enable_device(pci_dev);
+    if (ret) return ret;

     pci_set_master(pci_dev);

diff -urN --exclude-from=/home/davej/.exclude linux/drivers/sound/sonicvibes.c linux-dj/drivers/sound/sonicvibes.c
--- linux/drivers/sound/sonicvibes.c	Sat Feb 10 02:49:53 2001
+++ linux-dj/drivers/sound/sonicvibes.c	Sat Feb 10 03:05:53 2001
@@ -88,6 +88,7 @@
  *                       use Martin Mares' pci_assign_resource
  *    07.02.2000   0.26  Use pci_alloc_consistent and pci_register_driver
  *    21.11.2000   0.27  Initialize dma buffers in poll, otherwise poll may return a bogus mask
+ *    09.02.2001   0.28  pci_enable_device() before reading irq/resources <davej@suse.de>
  *
  */

@@ -2470,6 +2471,9 @@
 	char *ddmaname;
 	unsigned ddmanamelen;

+	i = pci_enable_device(pcidev);
+	if (i) return i;
+
 	if (!RSRCISIOREGION(pcidev, RESOURCE_SB) ||
 	    !RSRCISIOREGION(pcidev, RESOURCE_ENH) ||
 	    !RSRCISIOREGION(pcidev, RESOURCE_SYNTH) ||
@@ -2549,8 +2553,7 @@
 		printk(KERN_ERR "sv: io ports %#lx-%#lx in use\n", s->iosynth, s->iosynth+SV_EXTENT_SYNTH-1);
 		goto err_region1;
 	}
-	if (pci_enable_device(pcidev))
-		goto err_irq;
+
 	/* initialize codec registers */
 	outb(0x80, s->ioenh + SV_CODEC_CONTROL); /* assert reset */
 	udelay(50);
@@ -2679,7 +2682,7 @@
 {
 	if (!pci_present())   /* No PCI bus in this machine! */
 		return -ENODEV;
-	printk(KERN_INFO "sv: version v0.27 time " __TIME__ " " __DATE__ "\n");
+	printk(KERN_INFO "sv: version v0.28 time " __TIME__ " " __DATE__ "\n");
 #if 0
 	if (!(wavetable_mem = __get_free_pages(GFP_KERNEL, 20-PAGE_SHIFT)))
 		printk(KERN_INFO "sv: cannot allocate 1MB of contiguous nonpageable memory for wavetable data\n");
diff -urN --exclude-from=/home/davej/.exclude linux/drivers/sound/trident.c linux-dj/drivers/sound/trident.c
--- linux/drivers/sound/trident.c	Sat Feb 10 02:49:53 2001
+++ linux-dj/drivers/sound/trident.c	Sat Feb 10 03:05:50 2001
@@ -31,6 +31,8 @@
  *
  *  History
  *  v0.14.6
+ *  Feb 9 2001 Dave Jones <davej@suse.de>
+ *  pci_enable_device before reading irq/ioaddr
  *	Nov 1 2000 Ching-Ling Lee
  *	Fix the bug of memory leak when swithing 5.1-channels to 2 channels.
  *	Add lock protection into dynamic changing format of data.
@@ -3106,8 +3108,12 @@
 {
 	unsigned long iobase;
 	struct trident_card *card;
+	int err;
 	u8 revision;

+	err = pci_enable_device(pci_dev);
+	if (err) return err;
+
 	if (!pci_dma_supported(pci_dev, TRIDENT_DMA_MASK)) {
 		printk(KERN_ERR "trident: architecture does not support"
 		       " 30bit PCI busmaster DMA\n");
@@ -3121,9 +3127,6 @@
 		       iobase);
 		return -ENODEV;
 	}
-
-	if (pci_enable_device(pci_dev))
-	    return -ENODEV;

 	if ((card = kmalloc(sizeof(struct trident_card), GFP_KERNEL)) == NULL) {
 		printk(KERN_ERR "trident: out of memory\n");
diff -urN --exclude-from=/home/davej/.exclude linux/drivers/sound/via82cxxx_audio.c linux-dj/drivers/sound/via82cxxx_audio.c
--- linux/drivers/sound/via82cxxx_audio.c	Sat Feb 10 02:49:53 2001
+++ linux-dj/drivers/sound/via82cxxx_audio.c	Sat Feb 10 03:05:53 2001
@@ -3001,17 +3001,15 @@
 	if (printed_version++ == 0)
 		printk (KERN_INFO "Via 686a audio driver " VIA_VERSION "\n");

+	rc = pci_enable_device (pdev);
+	if (rc) return rc;
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
diff -urN --exclude-from=/home/davej/.exclude linux/drivers/sound/ymfpci.c linux-dj/drivers/sound/ymfpci.c
--- linux/drivers/sound/ymfpci.c	Sat Feb 10 02:49:53 2001
+++ linux-dj/drivers/sound/ymfpci.c	Sat Feb 10 03:05:52 2001
@@ -2369,9 +2369,10 @@

 	int err;

-	if (pci_enable_device(pcidev) < 0) {
+	err = pci_enable_device(pcidev);
+	if (err)
 		printk(KERN_ERR "ymfpci: pci_enable_device failed\n");
-		return -ENODEV;
+		return err;
 	}

 	if ((codec = kmalloc(sizeof(ymfpci_t), GFP_KERNEL)) == NULL) {

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
