Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129272AbRBKN0z>; Sun, 11 Feb 2001 08:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129273AbRBKN0q>; Sun, 11 Feb 2001 08:26:46 -0500
Received: from se1.cogenit.fr ([195.68.53.173]:27653 "EHLO se1.cogenit.fr")
	by vger.kernel.org with ESMTP id <S129272AbRBKN0c>;
	Sun, 11 Feb 2001 08:26:32 -0500
Date: Sun, 11 Feb 2001 14:26:21 +0100
From: Francois Romieu <romieu@cogenit.fr>
To: davej@suse.de
Cc: sailer@ife.ee.ethz.ch, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Sound drivers pci_enable_device clean_up
Message-ID: <20010211142621.A20582@se1.cogenit.fr>
Reply-To: romieu@cogenit.fr
In-Reply-To: <Pine.LNX.4.31.0102110247030.4383-100000@athlon.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <Pine.LNX.4.31.0102110247030.4383-100000@athlon.local>
X-Organisation: Marie's fan club - I
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

davej@suse.de <davej@suse.de> écrit :
[...]
> diff -urN --exclude-from=/home/davej/.exclude linux/drivers/sound/es1370.c linux-dj/drivers/sound/es1370.c
> --- linux/drivers/sound/es1370.c	Sat Feb 10 02:49:52 2001
> +++ linux-dj/drivers/sound/es1370.c	Sat Feb 10 03:05:52 2001
> @@ -117,6 +117,7 @@
>   *                       Tim Janik's BSE (Bedevilled Sound Engine) found this
>   *    07.02.2000   0.33  Use pci_alloc_consistent and pci_register_driver
>   *    21.11.2000   0.34  Initialize dma buffers in poll, otherwise poll may return a bogus mask
> + *    09.02.2001   0.35  pci_enable_device before reading irq/resources <davej@suse.de>
>   *
>   * some important things missing in Ensoniq documentation:
>   *
> @@ -2544,14 +2545,21 @@
>  	spin_lock_init(&s->lock);
>  	s->magic = ES1370_MAGIC;
>  	s->dev = pcidev;
> +
> +	i = pci_enable_device(pcidev);
> +	if (i) {
> +		kfree(s);
> +		return i;
> +	}
> +

Here ac9 says:
[...]
   2526         if (pcidev->irq == 0)
   2527                 return -1;
We will never go through the tests in pcibios_enable_irq. 
[...]
   2631  err_region:
   2632         kfree(s);
   2633         return -1;
No need to add it one more time.

--- linux-2.4.1-ac9.orig/drivers/sound/es1370.c	Sat Feb 10 07:11:28 2001
+++ linux-2.4.1-ac9/drivers/sound/es1370.c	Sun Feb 11 08:58:08 2001
@@ -2521,6 +2521,8 @@
 	mm_segment_t fs;
 	int i, val;
 
+	if (pci_enable_device(pcidev))
+		return -1;
 	if (!RSRCISIOREGION(pcidev, 0))
 		return -1;
 	if (pcidev->irq == 0) 
@@ -2550,8 +2552,6 @@
 		printk(KERN_ERR "es1370: io ports %#lx-%#lx in use\n", s->io, s->io+ES1370_EXTENT-1);
 		goto err_region;
 	}
-	if (pci_enable_device(pcidev))
-		goto err_irq;
 	if (request_irq(s->irq, es1370_interrupt, SA_SHIRQ, "es1370", s)) {
 		printk(KERN_ERR "es1370: irq %u in use\n", s->irq);
 		goto err_irq;
 

> diff -urN --exclude-from=/home/davej/.exclude linux/drivers/sound/es1371.c linux-dj/drivers/sound/es1371.c
> --- linux/drivers/sound/es1371.c	Sat Feb 10 02:49:52 2001
> +++ linux-dj/drivers/sound/es1371.c	Sat Feb 10 03:05:52 2001
[...]

Same remarks.

--- linux-2.4.1-ac9.orig/drivers/sound/es1371.c	Sat Feb 10 07:11:28 2001
+++ linux-2.4.1-ac9/drivers/sound/es1371.c	Sun Feb 11 09:02:59 2001
@@ -2733,6 +2733,8 @@
 	signed long tmo2;
 	unsigned int cssr;
 
+	if (pci_enable_device(pcidev))
+		return -1;
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

> diff -urN --exclude-from=/home/davej/.exclude linux/drivers/sound/esssolo1.c linux-dj/drivers/sound/esssolo1.c
> --- linux/drivers/sound/esssolo1.c	Sat Feb 10 02:49:52 2001
> +++ linux-dj/drivers/sound/esssolo1.c	Sat Feb 10 03:05:52 2001
[...]

Same remarks.

--- linux-2.4.1-ac9.orig/drivers/sound/esssolo1.c	Sat Feb 10 07:11:28 2001
+++ linux-2.4.1-ac9/drivers/sound/esssolo1.c	Sun Feb 11 09:04:58 2001
@@ -2246,6 +2246,8 @@
 	struct pm_dev *pmdev;
 	dma_addr_t dma_mask;
 
+ 	if (pci_enable_device(pcidev))
+		return -1;
 	if (!RSRCISIOREGION(pcidev, 0) ||
 	    !RSRCISIOREGION(pcidev, 1) ||
 	    !RSRCISIOREGION(pcidev, 2) ||
@@ -2302,8 +2304,6 @@
 		printk(KERN_ERR "solo1: irq %u in use\n", s->irq);
 		goto err_irq;
 	}
- 	if (pci_enable_device(pcidev))
-		goto err_irq;
 	printk(KERN_INFO "solo1: joystick port at %#lx\n", s->gpbase+1);
 	/* register devices */
 	if ((s->dev_audio = register_sound_dsp(&solo1_audio_fops, -1)) < 0)


-- 
Ueimor
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
