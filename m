Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129091AbQKUIAn>; Tue, 21 Nov 2000 03:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129259AbQKUIAd>; Tue, 21 Nov 2000 03:00:33 -0500
Received: from ife.ee.ethz.ch ([129.132.29.2]:25005 "EHLO ife.ee.ethz.ch")
	by vger.kernel.org with ESMTP id <S129091AbQKUIAa>;
	Tue, 21 Nov 2000 03:00:30 -0500
Date: Tue, 21 Nov 2000 08:30:24 +0100 (MET)
From: Thomas Sailer <sailer@ife.ee.ethz.ch>
Message-Id: <200011210730.eAL7UOq10736@eldrich.ee.ethz.ch>
To: he@kvintus.dk, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH]: 2.4.0-testx: sound drivers
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In poll, the DMA buffers need to be allocated if not already, otherwise
fragsize, dmasize, count etc. contain bogus values, which lead to bogus
poll mask return. (The alternative would have been to special case
!dmabuf_*.ready and defer DMA buffer allocation, but when the user
does poll, it likely means he will want to also read/write to the
device...)

Testcase provided by Hrafnkell Eiriksson <he@kvintus.dk>

Tom


--- drivers/sound/es1370.c.orig	Tue Nov 21 00:37:47 2000
+++ drivers/sound/es1370.c	Tue Nov 21 00:41:45 2000
@@ -117,6 +117,7 @@
  *    08.01.2000   0.32  Prevent some ioctl's from returning bad count values on underrun/overrun;
  *                       Tim Janik's BSE (Bedevilled Sound Engine) found this
  *    07.02.2000   0.33  Use pci_alloc_consistent and pci_register_driver
+ *    21.11.2000   0.34  Initialize dma buffers in poll, otherwise poll may return a bogus mask
  *
  * some important things missing in Ensoniq documentation:
  *
@@ -1281,10 +1282,16 @@
 	unsigned int mask = 0;
 
 	VALIDATE_STATE(s);
-	if (file->f_mode & FMODE_WRITE)
+	if (file->f_mode & FMODE_WRITE) {
+		if (!s->dma_dac2.ready && prog_dmabuf_dac2(s))
+			return 0;
 		poll_wait(file, &s->dma_dac2.wait, wait);
-	if (file->f_mode & FMODE_READ)
+	}
+	if (file->f_mode & FMODE_READ) {
+		if (!s->dma_adc.ready && prog_dmabuf_adc(s))
+			return 0;
 		poll_wait(file, &s->dma_adc.wait, wait);
+	}
 	spin_lock_irqsave(&s->lock, flags);
 	es1370_update_ptr(s);
 	if (file->f_mode & FMODE_READ) {
@@ -1856,6 +1863,8 @@
 	unsigned int mask = 0;
 
 	VALIDATE_STATE(s);
+	if (!s->dma_dac1.ready && prog_dmabuf_dac1(s))
+		return 0;
 	poll_wait(file, &s->dma_dac1.wait, wait);
 	spin_lock_irqsave(&s->lock, flags);
 	es1370_update_ptr(s);
@@ -2656,7 +2665,7 @@
 {
 	if (!pci_present())   /* No PCI bus in this machine! */
 		return -ENODEV;
-	printk(KERN_INFO "es1370: version v0.33 time " __TIME__ " " __DATE__ "\n");
+	printk(KERN_INFO "es1370: version v0.34 time " __TIME__ " " __DATE__ "\n");
 	return pci_module_init(&es1370_driver);
 }
 
--- drivers/sound/es1371.c.orig	Tue Nov 21 00:37:50 2000
+++ drivers/sound/es1371.c	Tue Nov 21 00:41:05 2000
@@ -102,6 +102,7 @@
  *    07.02.2000   0.25  Use ac97_codec
  *    01.03.2000   0.26  SPDIF patch by Mikael Bouillot <mikael.bouillot@bigfoot.com>
  *                       Use pci_module_init
+ *    21.11.2000   0.27  Initialize dma buffers in poll, otherwise poll may return a bogus mask
  */
 
 /*****************************************************************************/
@@ -1464,10 +1465,16 @@
 	unsigned int mask = 0;
 
 	VALIDATE_STATE(s);
-	if (file->f_mode & FMODE_WRITE)
+	if (file->f_mode & FMODE_WRITE) {
+		if (!s->dma_dac2.ready && prog_dmabuf_dac2(s))
+			return 0;
 		poll_wait(file, &s->dma_dac2.wait, wait);
-	if (file->f_mode & FMODE_READ)
+	}
+	if (file->f_mode & FMODE_READ) {
+		if (!s->dma_adc.ready && prog_dmabuf_adc(s))
+			return 0;
 		poll_wait(file, &s->dma_adc.wait, wait);
+	}
 	spin_lock_irqsave(&s->lock, flags);
 	es1371_update_ptr(s);
 	if (file->f_mode & FMODE_READ) {
@@ -2036,6 +2043,8 @@
 	unsigned int mask = 0;
 
 	VALIDATE_STATE(s);
+	if (!s->dma_dac1.ready && prog_dmabuf_dac1(s))
+		return 0;
 	poll_wait(file, &s->dma_dac1.wait, wait);
 	spin_lock_irqsave(&s->lock, flags);
 	es1371_update_ptr(s);
@@ -2928,7 +2937,7 @@
 {
 	if (!pci_present())   /* No PCI bus in this machine! */
 		return -ENODEV;
-	printk(KERN_INFO PFX "version v0.26 time " __TIME__ " " __DATE__ "\n");
+	printk(KERN_INFO PFX "version v0.27 time " __TIME__ " " __DATE__ "\n");
 	return pci_module_init(&es1371_driver);
 }
 
--- drivers/sound/esssolo1.c.orig	Tue Nov 21 00:37:58 2000
+++ drivers/sound/esssolo1.c	Tue Nov 21 00:42:57 2000
@@ -69,6 +69,7 @@
  *    07.02.2000   0.13  Use pci_alloc_consistent and pci_register_driver
  *    19.02.2000   0.14  Use pci_dma_supported to determine if recording should be disabled
  *    13.03.2000   0.15  Reintroduce initialization of a couple of PCI config space registers
+ *    21.11.2000   0.16  Initialize dma buffers in poll, otherwise poll may return a bogus mask
  */
 
 /*****************************************************************************/
@@ -1168,10 +1169,16 @@
 	unsigned int mask = 0;
 
 	VALIDATE_STATE(s);
-	if (file->f_mode & FMODE_WRITE)
+	if (file->f_mode & FMODE_WRITE) {
+		if (!s->dma_dac.ready && prog_dmabuf_dac(s))
+			return 0;
 		poll_wait(file, &s->dma_dac.wait, wait);
-	if (file->f_mode & FMODE_READ)
+	}
+	if (file->f_mode & FMODE_READ) {
+		if (!s->dma_adc.ready && prog_dmabuf_adc(s))
+			return 0;
 		poll_wait(file, &s->dma_adc.wait, wait);
+	}
 	spin_lock_irqsave(&s->lock, flags);
 	solo1_update_ptr(s);
 	if (file->f_mode & FMODE_READ) {
@@ -2384,7 +2391,7 @@
 {
 	if (!pci_present())   /* No PCI bus in this machine! */
 		return -ENODEV;
-	printk(KERN_INFO "solo1: version v0.15 time " __TIME__ " " __DATE__ "\n");
+	printk(KERN_INFO "solo1: version v0.16 time " __TIME__ " " __DATE__ "\n");
 	if (!pci_register_driver(&solo1_driver)) {
 		pci_unregister_driver(&solo1_driver);
                 return -ENODEV;
--- drivers/sound/sonicvibes.c.orig	Tue Nov 21 00:38:08 2000
+++ drivers/sound/sonicvibes.c	Tue Nov 21 00:46:05 2000
@@ -88,6 +88,7 @@
  *                       Tim Janik's BSE (Bedevilled Sound Engine) found this
  *                       use Martin Mares' pci_assign_resource
  *    07.02.2000   0.26  Use pci_alloc_consistent and pci_register_driver
+ *    21.11.2000   0.27  Initialize dma buffers in poll, otherwise poll may return a bogus mask
  *
  */
 
@@ -1485,10 +1486,16 @@
 	unsigned int mask = 0;
 
 	VALIDATE_STATE(s);
-	if (file->f_mode & FMODE_WRITE)
+	if (file->f_mode & FMODE_WRITE) {
+		if (!s->dma_dac.ready && prog_dmabuf(s, 1))
+			return 0;
 		poll_wait(file, &s->dma_dac.wait, wait);
-	if (file->f_mode & FMODE_READ)
+	}
+	if (file->f_mode & FMODE_READ) {
+		if (!s->dma_adc.ready && prog_dmabuf(s, 0))
+			return 0;
 		poll_wait(file, &s->dma_adc.wait, wait);
+	}
 	spin_lock_irqsave(&s->lock, flags);
 	sv_update_ptr(s);
 	if (file->f_mode & FMODE_READ) {
@@ -2667,7 +2674,7 @@
 {
 	if (!pci_present())   /* No PCI bus in this machine! */
 		return -ENODEV;
-	printk(KERN_INFO "sv: version v0.26 time " __TIME__ " " __DATE__ "\n");
+	printk(KERN_INFO "sv: version v0.27 time " __TIME__ " " __DATE__ "\n");
 #if 0
 	if (!(wavetable_mem = __get_free_pages(GFP_KERNEL, 20-PAGE_SHIFT)))
 		printk(KERN_INFO "sv: cannot allocate 1MB of contiguous nonpageable memory for wavetable data\n");
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
