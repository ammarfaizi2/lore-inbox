Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129259AbQKUIBX>; Tue, 21 Nov 2000 03:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129732AbQKUIBO>; Tue, 21 Nov 2000 03:01:14 -0500
Received: from ife.ee.ethz.ch ([129.132.29.2]:26029 "EHLO ife.ee.ethz.ch")
	by vger.kernel.org with ESMTP id <S129259AbQKUIAz>;
	Tue, 21 Nov 2000 03:00:55 -0500
Date: Tue, 21 Nov 2000 08:30:52 +0100 (MET)
From: Thomas Sailer <sailer@ife.ee.ethz.ch>
Message-Id: <200011210730.eAL7UqW10740@eldrich.ee.ethz.ch>
To: alan@lxorguk.ukuu.org.uk, he@kvintus.dk, linux-kernel@vger.kernel.org
Subject: [PATCH]: 2.2.18pre: sound drivers
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

--- drivers/sound/es1370.c.orig	Tue Nov 21 00:15:35 2000
+++ drivers/sound/es1370.c	Tue Nov 21 00:54:12 2000
@@ -114,6 +114,7 @@
  *    03.09.1999   0.30  change read semantics for MIDI to match
  *                       OSS more closely; remove possible wakeup race
  *    28.10.1999   0.31  More waitqueue races fixed
+ *    21.11.2000   0.32  Initialize dma buffers in poll, otherwise poll may return a bogus mask
  *
  * some important things missing in Ensoniq documentation:
  *
@@ -1298,6 +1299,12 @@
 	unsigned int mask = 0;
 
 	VALIDATE_STATE(s);
+	if (file->f_mode & FMODE_WRITE)
+		if (!s->dma_dac2.ready && prog_dmabuf_dac2(s))
+			return 0;
+	if (file->f_mode & FMODE_READ)
+		if (!s->dma_adc.ready && prog_dmabuf_adc(s))
+			return 0;
 	if (file->f_mode & (FMODE_READ|FMODE_WRITE))
 		poll_wait(file, &s->poll_wait, wait);
 	spin_lock_irqsave(&s->lock, flags);
@@ -1836,6 +1843,8 @@
 	unsigned int mask = 0;
 
 	VALIDATE_STATE(s);
+	if (!s->dma_dac1.ready && prog_dmabuf_dac1(s))
+		return 0;
 	poll_wait(file, &s->dma_dac1.wait, wait);
 	spin_lock_irqsave(&s->lock, flags);
 	es1370_update_ptr(s);
@@ -2463,7 +2472,7 @@
 
 	if (!pci_present())   /* No PCI bus in this machine! */
 		return -ENODEV;
-	printk(KERN_INFO "es1370: version v0.31 time " __TIME__ " " __DATE__ "\n");
+	printk(KERN_INFO "es1370: version v0.32 time " __TIME__ " " __DATE__ "\n");
 	while (index < NR_DEVICE && 
 	       (pcidev = pci_find_device(PCI_VENDOR_ID_ENSONIQ, PCI_DEVICE_ID_ENSONIQ_ES1370, pcidev))) {
 		if (pcidev->base_address[0] == 0 || 
--- drivers/sound/es1371.c.orig	Tue Nov 21 00:33:35 2000
+++ drivers/sound/es1371.c	Tue Nov 21 00:54:05 2000
@@ -96,6 +96,7 @@
  *                       detect ES137x chip and derivatives.
  *    05.01.2000   0.22  Should now work with rev7 boards; patch by
  *                       Eric Lemar, elemar@cs.washington.edu
+ *    21.11.2000   0.23  Initialize dma buffers in poll, otherwise poll may return a bogus mask
  */
 
 /*****************************************************************************/
@@ -1881,6 +1882,12 @@
 	unsigned int mask = 0;
 
 	VALIDATE_STATE(s);
+	if (file->f_mode & FMODE_WRITE)
+		if (!s->dma_dac2.ready && prog_dmabuf_dac2(s))
+			return 0;
+	if (file->f_mode & FMODE_READ)
+		if (!s->dma_adc.ready && prog_dmabuf_adc(s))
+			return 0;
 	if (file->f_mode & (FMODE_WRITE|FMODE_READ))
 		poll_wait(file, &s->poll_wait, wait);
 	spin_lock_irqsave(&s->lock, flags);
@@ -2416,6 +2423,8 @@
 	unsigned int mask = 0;
 
 	VALIDATE_STATE(s);
+	if (!s->dma_dac1.ready && prog_dmabuf_dac1(s))
+		return 0;
 	poll_wait(file, &s->dma_dac1.wait, wait);
 	spin_lock_irqsave(&s->lock, flags);
 	es1371_update_ptr(s);
@@ -3261,7 +3270,7 @@
 
 	if (!pci_present())   /* No PCI bus in this machine! */
 		return -ENODEV;
-	printk(KERN_INFO "es1371: version v0.22 time " __TIME__ " " __DATE__ "\n");
+	printk(KERN_INFO "es1371: version v0.23 time " __TIME__ " " __DATE__ "\n");
 	for (pcidev = pci_devices; pcidev && index < NR_DEVICE; pcidev = pcidev->next) {
 		if (pcidev->vendor == PCI_VENDOR_ID_ENSONIQ) {
 			if (pcidev->device != PCI_DEVICE_ID_ENSONIQ_ES1371 &&
--- drivers/sound/esssolo1.c.orig	Tue Nov 21 00:33:49 2000
+++ drivers/sound/esssolo1.c	Tue Nov 21 00:57:17 2000
@@ -63,6 +63,7 @@
  *    28.10.1999   0.10  More waitqueue races fixed
  *    09.12.1999   0.11  Work around stupid Alpha port issue (virt_to_bus(kmalloc(GFP_DMA)) > 16M)
  *                       Disabling recording on Alpha
+ *    21.11.2000   0.12  Initialize dma buffers in poll, otherwise poll may return a bogus mask
  *
  */
 
@@ -180,6 +181,7 @@
 	struct semaphore open_sem;
 	mode_t open_mode;
 	wait_queue_head_t open_wait;
+	wait_queue_head_t poll_wait;
 
 	struct dmabuf {
 		void *rawbuf;
@@ -555,16 +557,20 @@
 		       s->dma_adc.hwptr, s->dma_adc.swptr, s->dma_adc.dmasize, s->dma_adc.count);
 #endif
 		if (s->dma_adc.mapped) {
-			if (s->dma_adc.count >= (signed)s->dma_adc.fragsize)
+			if (s->dma_adc.count >= (signed)s->dma_adc.fragsize) {
 				wake_up(&s->dma_adc.wait);
+				wake_up(&s->poll_wait);
+			}
 		} else {
 			if (s->dma_adc.count > (signed)(s->dma_adc.dmasize - ((3 * s->dma_adc.fragsize) >> 1))) {
 				s->ena &= ~FMODE_READ;
 				write_ctrl(s, 0xb8, 0xe);
 				s->dma_adc.error++;
 			}
-			if (s->dma_adc.count > 0)
+			if (s->dma_adc.count > 0) {
 				wake_up(&s->dma_adc.wait);
+				wake_up(&s->poll_wait);
+			}
 		}
 	}
 	/* update DAC pointer */
@@ -579,8 +585,10 @@
 #endif
 		if (s->dma_dac.mapped) {
 			s->dma_dac.count += diff;
-			if (s->dma_dac.count >= (signed)s->dma_dac.fragsize)
+			if (s->dma_dac.count >= (signed)s->dma_dac.fragsize) {
 				wake_up(&s->dma_dac.wait);
+				wake_up(&s->poll_wait);
+			}
 		} else {
 			s->dma_dac.count -= diff;
 			if (s->dma_dac.count <= 0) {
@@ -592,8 +600,10 @@
 					      s->dma_dac.fragsize, (s->fmt & (AFMT_U8 | AFMT_U16_LE)) ? 0 : 0x80);
 				s->dma_dac.endcleared = 1;
 			}
-			if (s->dma_dac.count < (signed)s->dma_dac.dmasize)
+			if (s->dma_dac.count < (signed)s->dma_dac.dmasize) {
 				wake_up(&s->dma_dac.wait);
+				wake_up(&s->poll_wait);
+			}
 		}
 	}
 }
@@ -1176,9 +1186,13 @@
 
 	VALIDATE_STATE(s);
 	if (file->f_mode & FMODE_WRITE)
-		poll_wait(file, &s->dma_dac.wait, wait);
+		if (!s->dma_dac.ready && prog_dmabuf_dac(s))
+			return 0;
 	if (file->f_mode & FMODE_READ)
-		poll_wait(file, &s->dma_adc.wait, wait);
+		if (!s->dma_adc.ready && prog_dmabuf_adc(s))
+			return 0;
+	if (file->f_mode & (FMODE_READ|FMODE_WRITE))
+		poll_wait(file, &s->poll_wait, wait);
 	spin_lock_irqsave(&s->lock, flags);
 	solo1_update_ptr(s);
 	if (file->f_mode & FMODE_READ) {
@@ -2170,7 +2184,7 @@
 
 	if (!pci_present())   /* No PCI bus in this machine! */
 		return -ENODEV;
-	printk(KERN_INFO "solo1: version v0.11 time " __TIME__ " " __DATE__ "\n");
+	printk(KERN_INFO "solo1: version v0.12 time " __TIME__ " " __DATE__ "\n");
 	while (index < NR_DEVICE && 
 	       (pcidev = pci_find_device(PCI_VENDOR_ID_ESS, PCI_DEVICE_ID_ESS_SOLO1, pcidev))) {
 		if (pcidev->base_address[0] == 0 ||
@@ -2191,6 +2205,7 @@
 		memset(s, 0, sizeof(struct solo1_state));
 		init_waitqueue_head(&s->dma_adc.wait);
 		init_waitqueue_head(&s->dma_dac.wait);
+		init_waitqueue_head(&s->poll_wait);
 		init_waitqueue_head(&s->open_wait);
 		init_waitqueue_head(&s->midi.iwait);
 		init_waitqueue_head(&s->midi.owait);
--- drivers/sound/sonicvibes.c.orig	Tue Nov 21 00:33:41 2000
+++ drivers/sound/sonicvibes.c	Tue Nov 21 00:51:36 2000
@@ -82,6 +82,7 @@
  *    03.09.1999   0.21  change read semantics for MIDI to match
  *                       OSS more closely; remove possible wakeup race
  *    28.10.1999   0.22  More waitqueue races fixed
+ *    21.11.2000   0.23  Initialize dma buffers in poll, otherwise poll may return a bogus mask
  *
  */
 
@@ -1487,6 +1488,12 @@
 	unsigned int mask = 0;
 
 	VALIDATE_STATE(s);
+	if (file->f_mode & FMODE_READ)
+		if (!s->dma_adc.ready && prog_dmabuf(s, 1))
+			return 0;
+	if (file->f_mode & FMODE_WRITE)
+		if (!s->dma_dac.ready && prog_dmabuf(s, 0))
+			return 0;
 	if (file->f_mode & (FMODE_WRITE|FMODE_READ))
 		poll_wait(file, &s->poll_wait, wait);
 	spin_lock_irqsave(&s->lock, flags);
@@ -2432,7 +2439,7 @@
 
 	if (!pci_present())   /* No PCI bus in this machine! */
 		return -ENODEV;
-	printk(KERN_INFO "sv: version v0.22 time " __TIME__ " " __DATE__ "\n");
+	printk(KERN_INFO "sv: version v0.23 time " __TIME__ " " __DATE__ "\n");
 #if 0
 	if (!(wavetable_mem = __get_free_pages(GFP_KERNEL, 20-PAGE_SHIFT)))
 		printk(KERN_INFO "sv: cannot allocate 1MB of contiguous nonpageable memory for wavetable data\n");
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
