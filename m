Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262789AbTLSMy3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 07:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263497AbTLSMy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 07:54:29 -0500
Received: from mail.convergence.de ([212.84.236.4]:28090 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S262789AbTLSM2m convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 07:28:42 -0500
Subject: [PATCH 2/12] Update saa7146 capture core
In-Reply-To: <10718369193344@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Fri, 19 Dec 2003 13:28:39 +0100
Message-Id: <10718369194031@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Michael Hunold <hunold@linuxtv.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

V4L: - fix a bunch of race conditions and locking bugs in video and vbi capture code on device closure
V4L: - use vmalloc_32() instead of vmalloc() in saa7146_vmalloc_build_pgtable(). this makes sure that the pagetable is in lowmem kernel memory
V4L: - i2c timeout fix by Gerd Knorr 
V4L: - SAA7146_I2C_SHORT_DELAY flag to speed up I2C access by Oliver Endriss
V4L: - move saa7146_set_gpio() from saa7146_vv to saa7146_core, it's needed by DVB budget drivers
V4L: - add "new" saa7146_wait_for_debi_done() function, remove other versions from av7110 and budget.ci
V4L: - make budget-ci use this gpio function and the new wait_...() function,
V4L: - make saa7146_pgtable_build_single() deliver a return code, make sanity checks of the arguments
V4L: - sanitize enabling of video input pins and i2c pins, use some default values, so the hardware is always in a sane state
V4L: - remove SAA7146_EXT_SWAP_ODD_EVEN flag + handling, fix the hardware initialization instead
V4L: - change minimal picture size to 48x32 just like other drivers
V4L: - set up arbitrition control for video dma3 correctly
V4L: - remove unnecessary code for capture to framebuffer memory, it's handled in the generic code
diff -uNrwB --new-file linux-2.6.0/drivers/media/common/saa7146_core.c linux-2.6.0-p/drivers/media/common/saa7146_core.c
--- linux-2.6.0/drivers/media/common/saa7146_core.c	2003-12-18 03:59:06.000000000 +0100
+++ linux-2.6.0-p/drivers/media/common/saa7146_core.c	2003-12-17 14:00:22.000000000 +0100
@@ -45,10 +45,65 @@
 #endif
 
 /****************************************************************************
+ * gpio and debi helper functions
+ ****************************************************************************/
+
+/* write "data" to the gpio-pin "pin" */
+void saa7146_set_gpio(struct saa7146_dev *dev, u8 pin, u8 data)
+{
+	u32 value = 0;
+
+	/* sanity check */
+	if(pin > 3)
+		return;
+
+	/* read old register contents */
+	value = saa7146_read(dev, GPIO_CTRL );
+	
+	value &= ~(0xff << (8*pin));
+	value |= (data << (8*pin));
+
+	saa7146_write(dev, GPIO_CTRL, value);
+}
+
+/* This DEBI code is based on the saa7146 Stradis driver by Nathan Laredo */
+int saa7146_wait_for_debi_done(struct saa7146_dev *dev)
+{
+	int start;
+
+	/* wait for registers to be programmed */
+	start = jiffies;
+	while (1) {
+                if (saa7146_read(dev, MC2) & 2)
+                        break;
+		if (jiffies-start > HZ/20) {
+			DEB_S(("timed out while waiting for registers getting programmed\n"));
+			return -ETIMEDOUT;
+		}
+	}
+
+	/* wait for transfer to complete */
+	start = jiffies;
+	while (1) {
+		if (!(saa7146_read(dev, PSR) & SPCI_DEBI_S))
+			break;
+		saa7146_read(dev, MC2);
+		if (jiffies-start > HZ/4) {
+			DEB_S(("timed out while waiting for transfer completion\n"));
+			return -ETIMEDOUT;
+		}
+	}
+
+	return 0;
+}
+
+/****************************************************************************
  * general helper functions
  ****************************************************************************/
 
-/* this is videobuf_vmalloc_to_sg() from video-buf.c */
+/* this is videobuf_vmalloc_to_sg() from video-buf.c 
+   make sure virt has been allocated with vmalloc_32(), otherwise the BUG()
+   may be triggered on highmem machines */
 static struct scatterlist* vmalloc_to_sg(unsigned char *virt, int nr_pages)
 {
 	struct scatterlist *sglist;
@@ -84,7 +139,7 @@
 {
 	struct scatterlist *slist = NULL;
 	int pages = (length+PAGE_SIZE-1)/PAGE_SIZE;
-	char *mem = vmalloc(length);
+	char *mem = vmalloc_32(length);
 	int slen = 0;
 
 	if (NULL == mem) {
@@ -103,7 +158,9 @@
 	}
 	
 	slen = pci_map_sg(pci,slist,pages,PCI_DMA_FROMDEVICE);
-	saa7146_pgtable_build_single(pci, pt, slist, slen);
+	if (0 != saa7146_pgtable_build_single(pci, pt, slist, slen)) {
+		return NULL;
+	}
 
 	/* fixme: here's a memory leak: slist never gets freed by any other
 	   function ...*/
@@ -139,7 +196,7 @@
 	return 0;
 }
 
-void saa7146_pgtable_build_single(struct pci_dev *pci, struct saa7146_pgtable *pt,
+int saa7146_pgtable_build_single(struct pci_dev *pci, struct saa7146_pgtable *pt,
 	struct scatterlist *list, int sglen  )
 {
 	u32   *ptr, fill;
@@ -148,6 +205,11 @@
 
 	BUG_ON( 0 == sglen);
 
+	if (list->offset > PAGE_SIZE) {
+		DEB_D(("offset > PAGE_SIZE. this should not happen."));
+		return -EINVAL;
+	}
+	
 	/* if we have a user buffer, the first page may not be
 	   aligned to a page boundary. */
 	pt->offset = list->offset;
@@ -177,6 +239,7 @@
 		printk("ptr1 %d: 0x%08x\n",i,ptr[i]);
 	}
 */
+	return 0;
 }
 
 /********************************************************************************/
@@ -322,7 +384,7 @@
 	saa7146_write(dev, MC1, MASK_31);
 */
 
-	/* disable alle irqs */
+	/* disable all irqs */
 	saa7146_write(dev, IER, 0);
 
 	/* shut down all dma transfers */
@@ -381,8 +443,8 @@
 	dev->module = THIS_MODULE;
 	init_waitqueue_head(&dev->i2c_wq);
 
-	/* set some default values */
-	saa7146_write(dev, BCS_CTRL, 0x80400040);
+	/* set some sane pci arbitrition values */
+	saa7146_write(dev, PCI_BT_V1, 0x1c00101f); 
 
 	if( 0 != ext->probe) {
 		if( 0 != ext->probe(dev) ) {
@@ -508,6 +570,7 @@
 EXPORT_SYMBOL_GPL(saa7146_pgtable_free);
 EXPORT_SYMBOL_GPL(saa7146_pgtable_build_single);
 EXPORT_SYMBOL_GPL(saa7146_vmalloc_build_pgtable);
+EXPORT_SYMBOL_GPL(saa7146_wait_for_debi_done);
 
 EXPORT_SYMBOL_GPL(saa7146_setgpio);
 
diff -uNrwB --new-file linux-2.6.0/drivers/media/common/saa7146_fops.c linux-2.6.0-p/drivers/media/common/saa7146_fops.c
--- linux-2.6.0/drivers/media/common/saa7146_fops.c	2003-12-18 03:58:49.000000000 +0100
+++ linux-2.6.0-p/drivers/media/common/saa7146_fops.c	2003-12-18 12:18:53.000000000 +0100
@@ -86,7 +86,7 @@
 		return;
 	}
 
-	DEB_EE(("dev:%p, dmaq:%p, vbi:%d\n", dev, q, vbi));
+	DEB_INT(("dev:%p, dmaq:%p, vbi:%d\n", dev, q, vbi));
 
 #if DEBUG_SPINLOCKS
 	BUG_ON(!spin_is_locked(&dev->slock));
@@ -98,10 +98,10 @@
 		if (!list_empty(&q->queue))
 			next = list_entry(q->queue.next,struct saa7146_buf, vb.queue);
 		q->curr = buf;
-		DEB_D(("next buffer: buf:%p, prev:%p, next:%p\n", buf, q->queue.prev,q->queue.next));
+		DEB_INT(("next buffer: buf:%p, prev:%p, next:%p\n", buf, q->queue.prev,q->queue.next));
 		buf->activate(dev,buf,next);
 	} else {
-		DEB_D(("no next buffer. stopping.\n"));
+		DEB_INT(("no next buffer. stopping.\n"));
 		if( 0 != vbi ) {
 			/* turn off video-dma3 */
 			saa7146_write(dev,MC1, MASK_20);
@@ -229,10 +229,10 @@
 
 	if( fh->type == V4L2_BUF_TYPE_VBI_CAPTURE) {
 		DEB_S(("initializing vbi...\n"));
-		saa7146_vbi_uops.open(dev,fh);
+		saa7146_vbi_uops.open(dev,file);
 	} else {
 		DEB_S(("initializing video...\n"));
-		saa7146_video_uops.open(dev,fh);
+		saa7146_video_uops.open(dev,file);
 	}
 
 	result = 0;
@@ -255,9 +255,9 @@
 		return -ERESTARTSYS;
 
 	if( fh->type == V4L2_BUF_TYPE_VBI_CAPTURE) {
-		saa7146_vbi_uops.release(dev,fh,file);
+		saa7146_vbi_uops.release(dev,file);
 	} else {
-		saa7146_video_uops.release(dev,fh,file);
+		saa7146_video_uops.release(dev,file);
 	}
 
 	module_put(dev->ext->module);
@@ -372,7 +372,7 @@
 {
 	u32 isr = status;
 	
-	DEB_EE(("dev:%p, isr:0x%08x\n",dev,(u32)status));
+	DEB_INT(("dev:%p, isr:0x%08x\n",dev,(u32)status));
 
 	if (0 != (isr & (MASK_27))) {
 		DEB_INT(("irq: RPS0 (0x%08x).\n",isr));
@@ -410,6 +410,12 @@
 
 	DEB_EE(("dev:%p\n",dev));
 	
+	/* set default values for video parts of the saa7146 */
+	saa7146_write(dev, BCS_CTRL, 0x80400040);
+
+	/* enable video-port pins */
+	saa7146_write(dev, MC1, (MASK_10 | MASK_26));
+
 	/* save per-device extension data (one extension can
 	   handle different devices that might need different
 	   configuration data) */
diff -uNrwB --new-file linux-2.6.0/drivers/media/common/saa7146_hlp.c linux-2.6.0-p/drivers/media/common/saa7146_hlp.c
--- linux-2.6.0/drivers/media/common/saa7146_hlp.c	2003-12-18 03:58:58.000000000 +0100
+++ linux-2.6.0-p/drivers/media/common/saa7146_hlp.c	2003-11-20 11:01:06.000000000 +0100
@@ -660,24 +660,6 @@
 	vv->current_hps_sync = sync;
 } 
 
-/* write "data" to the gpio-pin "pin" */
-void saa7146_set_gpio(struct saa7146_dev *dev, u8 pin, u8 data)
-{
-	u32 value = 0;
-
-	/* sanity check */
-	if(pin > 3)
-		return;
-
-	/* read old register contents */
-	value = saa7146_read(dev, GPIO_CTRL );
-	
-	value &= ~(0xff << (8*pin));
-	value |= (data << (8*pin));
-
-	saa7146_write(dev, GPIO_CTRL, value);
-}
-
 /* reprogram hps, enable(1) / disable(0) video */
 void saa7146_set_overlay(struct saa7146_dev *dev, struct saa7146_fh *fh, int v)
 {
@@ -710,13 +692,15 @@
 	/* calculate starting address */
 	where  = (which-1)*0x18;
 
+/*
 	if( 0 != (dev->ext_vv_data->flags & SAA7146_EXT_SWAP_ODD_EVEN)) {
 		saa7146_write(dev, where, 	vdma->base_even);
 		saa7146_write(dev, where+0x04, 	vdma->base_odd);
 	} else {
+*/
 		saa7146_write(dev, where, 	vdma->base_odd);
 		saa7146_write(dev, where+0x04, 	vdma->base_even);
-	}
+//	}
 	saa7146_write(dev, where+0x08, 	vdma->prot_addr);
 	saa7146_write(dev, where+0x0c, 	vdma->pitch);
 	saa7146_write(dev, where+0x10, 	vdma->base_page);
@@ -971,12 +955,13 @@
 	unsigned long e_wait = vv->current_hps_sync == SAA7146_HPS_SYNC_PORT_A ? CMD_E_FID_A : CMD_E_FID_B;
 	unsigned long o_wait = vv->current_hps_sync == SAA7146_HPS_SYNC_PORT_A ? CMD_O_FID_A : CMD_O_FID_B;
 
+/*
 	if( 0 != (dev->ext_vv_data->flags & SAA7146_EXT_SWAP_ODD_EVEN)) {
 		unsigned long tmp = e_wait;
 		e_wait = o_wait;
 		o_wait = tmp;
 	}
-
+*/
 	/* wait for o_fid_a/b / e_fid_a/b toggle only if rps register 0 is not set*/
 	WRITE_RPS0(CMD_PAUSE | CMD_OAN | CMD_SIG0 | o_wait);
 	WRITE_RPS0(CMD_PAUSE | CMD_OAN | CMD_SIG0 | e_wait);
diff -uNrwB --new-file linux-2.6.0/drivers/media/common/saa7146_i2c.c linux-2.6.0-p/drivers/media/common/saa7146_i2c.c
--- linux-2.6.0/drivers/media/common/saa7146_i2c.c	2003-12-18 03:59:44.000000000 +0100
+++ linux-2.6.0-p/drivers/media/common/saa7146_i2c.c	2003-12-10 14:06:57.000000000 +0100
@@ -186,7 +186,7 @@
 {
 	u32 status = 0, mc2 = 0;
 	int trial = 0;
-	int timeout;
+	unsigned long timeout;
 
 	/* write out i2c-command */
 	DEB_I2C(("before: 0x%08x (status: 0x%08x), %d\n",*dword,saa7146_read(dev, I2C_STATUS), dev->i2c_op));
@@ -218,7 +218,7 @@
 			if( 0 != mc2 ) {
 				break;
 			}
-			if (jiffies > timeout) {
+			if (time_after(jiffies,timeout)) {
 				printk(KERN_WARNING "saa7146_i2c_writeout: timed out waiting for MC2\n");
 				return -EIO;
 			}
@@ -233,7 +233,7 @@
 			status = saa7146_i2c_status(dev);
 			if ((status & 0x3) != 1)
 				break;
-			if (jiffies > timeout) {
+			if (time_after(jiffies,timeout)) {
 				/* this is normal when probing the bus
 				 * (no answer from nonexisistant device...)
 				 */
@@ -301,7 +301,8 @@
 		goto out;
 	}
 
-        if (count > 3) short_delay = 1;
+	if ( count > 3 || 0 != (SAA7146_I2C_SHORT_DELAY & dev->ext->flags) )
+		short_delay = 1;
   
 	do {
 		/* reset the i2c-device if necessary */
@@ -403,19 +404,29 @@
 {
 	DEB_EE(("bitrate: 0x%08x\n",bitrate));
 	
+	/* enable i2c-port pins */
+	saa7146_write(dev, MC1, (MASK_08 | MASK_24));
+
 	dev->i2c_bitrate = bitrate;
 	saa7146_i2c_reset(dev);
 
 	if( NULL != i2c_adapter ) {
 		memset(i2c_adapter,0,sizeof(struct i2c_adapter));
 		strcpy(i2c_adapter->name, dev->name);	
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0))
+		i2c_adapter->data = dev;
+#else
 		i2c_set_adapdata(i2c_adapter,dev);
-		i2c_adapter->class	   = I2C_ADAP_CLASS_TV_ANALOG;
+#endif
 		i2c_adapter->algo	   = &saa7146_algo;
 		i2c_adapter->algo_data     = NULL;
 		i2c_adapter->id 	   = I2C_ALGO_SAA7146;
 		i2c_adapter->timeout = SAA7146_I2C_TIMEOUT;
 		i2c_adapter->retries = SAA7146_I2C_RETRIES;
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0))
+#else
+		i2c_adapter->class = I2C_ADAP_CLASS_TV_ANALOG;
+#endif
 	}
 	
 	return 0;
diff -uNrwB --new-file linux-2.6.0/drivers/media/common/saa7146_vbi.c linux-2.6.0-p/drivers/media/common/saa7146_vbi.c
--- linux-2.6.0/drivers/media/common/saa7146_vbi.c	2003-12-18 03:57:59.000000000 +0100
+++ linux-2.6.0-p/drivers/media/common/saa7146_vbi.c	2003-12-15 21:51:01.000000000 +0100
@@ -41,7 +41,11 @@
 	/* wait for vbi_a or vbi_b*/
 	if ( 0 != (SAA7146_USE_PORT_B_FOR_VBI & dev->ext_vv_data->flags)) {
 		DEB_D(("...using port b\n"));
+		WRITE_RPS1(CMD_PAUSE | CMD_OAN | CMD_SIG1 | CMD_E_FID_B);
+		WRITE_RPS1(CMD_PAUSE | CMD_OAN | CMD_SIG1 | CMD_O_FID_B);
+/*
 		WRITE_RPS1(CMD_PAUSE | MASK_09);
+*/
 	} else {
 		DEB_D(("...using port a\n"));
 		WRITE_RPS1(CMD_PAUSE | MASK_10);
@@ -137,10 +141,10 @@
 	unsigned long o_wait = vv->current_hps_sync == SAA7146_HPS_SYNC_PORT_A ? CMD_O_FID_A : CMD_O_FID_B;
 
 /*
-	vdma3.base_even	= (u32)dev->ov_fb.base+2048*70;
-	vdma3.base_odd	= (u32)dev->ov_fb.base;
-	vdma3.prot_addr	= (u32)dev->ov_fb.base+2048*164;
-	vdma3.pitch	= 2048;
+	vdma3.base_even	= 0xc8000000+2560*70;
+	vdma3.base_odd	= 0xc8000000;
+	vdma3.prot_addr	= 0xc8000000+2560*164;
+	vdma3.pitch	= 2560;
 	vdma3.base_page	= 0;
 	vdma3.num_line_byte = (64<<16)|((vbi_pixel_to_capture)<<0); // set above!
 */
@@ -244,7 +249,9 @@
 		err = videobuf_iolock(dev->pci,&buf->vb,NULL);
 		if (err)
 			goto oops;
-		saa7146_pgtable_build_single(dev->pci, &buf->pt[2], buf->vb.dma.sglist, buf->vb.dma.sglen);
+		err = saa7146_pgtable_build_single(dev->pci, &buf->pt[2], buf->vb.dma.sglist, buf->vb.dma.sglen);
+		if (0 != err)
+			return err;
 	}
 	buf->vb.state = STATE_PREPARED;
 	buf->activate = buffer_activate;
@@ -303,7 +310,7 @@
 
 /* ------------------------------------------------------------------ */
 
-static void vbi_stop(struct saa7146_fh *fh)
+static void vbi_stop(struct saa7146_fh *fh, struct file *file)
 {
 	struct saa7146_dev *dev = fh->dev;
 	struct saa7146_vv *vv = dev->vv_data;
@@ -321,23 +328,29 @@
 	/* shut down dma 3 transfers */
 	saa7146_write(dev, MC1, MASK_20);
 
+	if (vv->vbi_q.curr) {
+		saa7146_buffer_finish(dev,&vv->vbi_q,STATE_DONE);
+	}
+
+	videobuf_queue_cancel(file,&fh->vbi_q);
+
 	vv->vbi_streaming = NULL;
 
 	del_timer(&vv->vbi_q.timeout);
 	del_timer(&fh->vbi_read_timeout);
 
-	DEB_VBI(("out\n"));
 	spin_unlock_irqrestore(&dev->slock, flags);
 }
 
 static void vbi_read_timeout(unsigned long data)
 {
-	struct saa7146_fh *fh = (struct saa7146_fh *)data;
+	struct file *file = (struct file*)data;
+	struct saa7146_fh *fh = file->private_data;
 	struct saa7146_dev *dev = fh->dev;
 	
 	DEB_VBI(("dev:%p, fh:%p\n",dev, fh));
 
-	vbi_stop(fh);
+	vbi_stop(fh, file);
 }
 
 static void vbi_init(struct saa7146_dev *dev, struct saa7146_vv *vv)
@@ -354,10 +367,21 @@
 	init_waitqueue_head(&vv->vbi_wq);
 }
 
-static void vbi_open(struct saa7146_dev *dev, struct saa7146_fh *fh)
+static void vbi_open(struct saa7146_dev *dev, struct file *file)
 {
+	struct saa7146_fh *fh = (struct saa7146_fh *)file->private_data;
+	
+	u32 arbtr_ctrl	= saa7146_read(dev, PCI_BT_V1);
+	int ret = 0;
+	
 	DEB_VBI(("dev:%p, fh:%p\n",dev,fh));
 
+	/* adjust arbitrition control for video dma 3 */
+	arbtr_ctrl &= ~0x1f0000;
+	arbtr_ctrl |=  0x1d0000;
+	saa7146_write(dev, PCI_BT_V1, arbtr_ctrl);
+	saa7146_write(dev, MC2, (MASK_04|MASK_20));		
+	
 	memset(&fh->vbi_fmt,0,sizeof(fh->vbi_fmt));
 
 	fh->vbi_fmt.sampling_rate	= 27000000;
@@ -380,21 +404,32 @@
 
 	init_timer(&fh->vbi_read_timeout);
 	fh->vbi_read_timeout.function = vbi_read_timeout;
-	fh->vbi_read_timeout.data = (unsigned long)fh;
+	fh->vbi_read_timeout.data = (unsigned long)file;
 
-	/* fixme: enable this again, if the dvb-c w/ analog module work properly */
-/*
-	vbi_workaround(dev);
-*/
+	/* initialize the brs */
+	if ( 0 != (SAA7146_USE_PORT_B_FOR_VBI & dev->ext_vv_data->flags)) {
+		saa7146_write(dev, BRS_CTRL, MASK_30|MASK_29 | (7 << 19));
+	} else {
+		saa7146_write(dev, BRS_CTRL, 0x00000001);
+
+		if (0 != (ret = vbi_workaround(dev))) {
+			DEB_VBI(("vbi workaround failed!\n"));
+			/* return ret;*/
+		}
+	}
+
+	/* upload brs register */
+	saa7146_write(dev, MC2, (MASK_08|MASK_24));		
 }
 
-static void vbi_close(struct saa7146_dev *dev, struct saa7146_fh *fh, struct file *file)
+static void vbi_close(struct saa7146_dev *dev, struct file *file)
 {
+	struct saa7146_fh *fh = (struct saa7146_fh *)file->private_data;
 	struct saa7146_vv *vv = dev->vv_data;
 	DEB_VBI(("dev:%p, fh:%p\n",dev,fh));
 
 	if( fh == vv->vbi_streaming ) {
-		vbi_stop(fh);
+		vbi_stop(fh, file);
 	}
 }
 
diff -uNrwB --new-file linux-2.6.0/drivers/media/common/saa7146_video.c linux-2.6.0-p/drivers/media/common/saa7146_video.c
--- linux-2.6.0/drivers/media/common/saa7146_video.c	2003-12-18 03:59:05.000000000 +0100
+++ linux-2.6.0-p/drivers/media/common/saa7146_video.c	2003-12-17 14:00:22.000000000 +0100
@@ -116,7 +116,7 @@
 		DEB_D(("no fb fmt set.\n"));
 		return -EINVAL;
 	}
-	if (win->w.width < 64 || win->w.height <  64) {
+	if (win->w.width < 48 || win->w.height <  32) {
 		DEB_D(("min width/height. (%d,%d)\n",win->w.width,win->w.height));
 		return -EINVAL;
 	}
@@ -661,7 +661,7 @@
 */				
 	} else {
 		struct saa7146_pgtable *pt = &buf->pt[0];
-		saa7146_pgtable_build_single(pci, pt, list, length);
+		return saa7146_pgtable_build_single(pci, pt, list, length);
 	}
 
 	return 0;
@@ -704,7 +704,7 @@
 	return 0;
 }
 
-static int video_end(struct saa7146_fh *fh)
+static int video_end(struct saa7146_fh *fh, struct file *file)
 {
 	struct saa7146_dev *dev = fh->dev;
 	struct saa7146_vv *vv = dev->vv_data;
@@ -735,82 +735,11 @@
 	saa7146_write(dev, MC1, 0x00700000);
 
 	vv->streaming = NULL;
-	spin_unlock_irqrestore(&dev->slock, flags);
-	
-	return 0;
-}
-
-/* capturing to framebuffer */
-
-int overlay_reqbufs(struct saa7146_dev *dev, struct v4l2_requestbuffers *req)
-{
-/*	struct saa7146_fh *fh = file->private_data;
 
-	if (req->count > VIDEO_MAX_FRAME)
-		req->count = VIDEO_MAX_FRAME;
-
-	*size = fh->video_fmt.sizeimage;
-
-*/
-	return 0;
-}
-int overlay_querybuf(struct saa7146_dev *dev, struct v4l2_buffer *buf)
-{
-	return 0;
-}
-int overlay_qbuf(struct saa7146_dev *dev, struct v4l2_buffer *b)
-{
-/*	if (b->index < 0 || b->index >= VIDEO_MAX_FRAME) {
-		DEB_D(("index %d out of bounds.\n",b->index));
-		goto -EINVAL;
-	}
-	
-	buf = q->bufs[b->index];
-	if (NULL == buf) {
-		printk("videobuf_qbuf: NULL == buf\n");
-		goto done;
-	}
-	if (0 == buf->baddr) {
-		printk("videobuf_qbuf: 0 == buf->baddr\n");
-		goto done;
-	}
-	if (buf->state == STATE_QUEUED ||
-	    buf->state == STATE_ACTIVE) {
-		printk("videobuf_qbuf: already queued or activated.\n");
-		goto done;
-	}
-
-	field = videobuf_next_field(q);
-	retval = q->ops->buf_prepare(file,buf,field);
-	if (0 != retval) {
-		printk("videobuf_qbuf: buf_prepare() failed.\n");
-		goto done;
-	}
+	videobuf_queue_cancel(file,&fh->video_q);
 	
-	list_add_tail(&buf->stream,&q->stream);
-	if (q->streaming) {
-		spin_lock_irqsave(q->irqlock,flags);
-		q->ops->buf_queue(file,buf);
-		spin_unlock_irqrestore(q->irqlock,flags);
-	}
-	retval = 0;
+	spin_unlock_irqrestore(&dev->slock, flags);
 	
- done:
-	up(&q->lock);
-	return retval;
-*/
-	return 0;
-}
-int overlay_dqbuf(struct saa7146_dev *dev, struct v4l2_buffer *buf)
-{
-	return 0;
-}
-int overlay_streamon(struct saa7146_dev *dev)
-{
-	return 0;
-}
-int overlay_streamoff(struct saa7146_dev *dev)
-{
 	return 0;
 }
 
@@ -818,7 +746,7 @@
 /*
  * This function is _not_ called directly, but from
  * video_generic_ioctl (and maybe others).  userspace
- * copying is done already, arg is a kernel fhinter.
+ * copying is done already, arg is a kernel pointer.
  */
 
 int saa7146_video_do_ioctl(struct inode *inode, struct file *file, unsigned int cmd, void *arg)
@@ -1141,38 +1069,24 @@
 	case VIDIOC_REQBUFS: {
 		struct v4l2_requestbuffers *req = arg;
 		DEB_D(("VIDIOC_REQBUFS, type:%d\n",req->type));
-/*
-		if( req->type == V4L2_BUF_TYPE_VIDEO_OVERLAY ) {
-			return overlay_reqbufs(dev,req);
-		} 
-*/
 		return videobuf_reqbufs(file,q,req);
 	}
 	case VIDIOC_QUERYBUF: {
 		struct v4l2_buffer *buf = arg;
 		DEB_D(("VIDIOC_QUERYBUF, type:%d, offset:%d\n",buf->type,buf->m.offset));
-/* 		if( buf->type == V4L2_BUF_TYPE_VIDEO_OVERLAY ) {
-			return overlay_querybuf(dev,buf);
-		} 
- */		return videobuf_querybuf(q,buf);
+		return videobuf_querybuf(q,buf);
 	}
 	case VIDIOC_QBUF: {
 		struct v4l2_buffer *buf = arg;
 		int ret = 0;
-/* 		if( buf->type == V4L2_BUF_TYPE_VIDEO_OVERLAY ) {
-			return overlay_qbuf(dev,buf);
-		} 
- */		ret = videobuf_qbuf(file,q,buf);
+		ret = videobuf_qbuf(file,q,buf);
 		DEB_D(("VIDIOC_QBUF: ret:%d, index:%d\n",ret,buf->index));
 		return ret;
 	}
 	case VIDIOC_DQBUF: {
 		struct v4l2_buffer *buf = arg;
 		int ret = 0;
-/* 		if( buf->type == V4L2_BUF_TYPE_VIDEO_OVERLAY ) {
-			return overlay_dqbuf(dev,buf);
-		} 
- */		ret = videobuf_dqbuf(file,q,buf);
+		ret = videobuf_dqbuf(file,q,buf);
 		DEB_D(("VIDIOC_DQBUF: ret:%d, index:%d\n",ret,buf->index));
 		return ret;
 	}
@@ -1180,29 +1094,18 @@
 		int *type = arg;
 		DEB_D(("VIDIOC_STREAMON, type:%d\n",*type));
 
-		if( 0 != ops->capture_begin ) {
-			if( 0 != (err = ops->capture_begin(fh))) {
+		if( 0 != (err = video_begin(fh))) {
 				return err;
 			}
-		}
-/* 		if( *type == V4L2_BUF_TYPE_VIDEO_OVERLAY ) {
-			err = overlay_streamon(dev);
-		} else { */
 		err = videobuf_streamon(file,q);
-/* 		} */
 		return err;
 	}
 	case VIDIOC_STREAMOFF: {
 		int *type = arg;
 
 		DEB_D(("VIDIOC_STREAMOFF, type:%d\n",*type));
-		if( 0 != ops->capture_end ) {
-			ops->capture_end(fh);
-		}
-/* 		if( *type == V4L2_BUF_TYPE_VIDEO_OVERLAY ) {
-			return overlay_streamoff(dev);
-		} 
- */		err = videobuf_streamoff(file,q);
+		video_end(fh, file);
+		err = videobuf_streamoff(file,q);
 		return err;
 	}
 	case VIDIOCGMBUF:
@@ -1267,8 +1170,8 @@
 	DEB_CAP(("vbuf:%p\n",vb));
 
 	/* sanity checks */
-	if (fh->video_fmt.width  < 64 ||
-	    fh->video_fmt.height < 64 ||
+	if (fh->video_fmt.width  < 48 ||
+	    fh->video_fmt.height < 32 ||
 	    fh->video_fmt.width  > vv->standard->h_max_out ||
 	    fh->video_fmt.height > vv->standard->v_max_out) {
 		DEB_D(("w (%d) / h (%d) out of bounds.\n",fh->video_fmt.width,fh->video_fmt.height));
@@ -1407,8 +1310,9 @@
 }
 
 
-static void video_open(struct saa7146_dev *dev, struct saa7146_fh *fh)
+static void video_open(struct saa7146_dev *dev, struct file *file)
 {
+	struct saa7146_fh *fh = (struct saa7146_fh *)file->private_data;
 	struct saa7146_format *sfmt;
 
 	fh->video_fmt.width = 384;
@@ -1429,8 +1333,9 @@
 }
 
 
-static void video_close(struct saa7146_dev *dev, struct saa7146_fh *fh, struct file *file)
+static void video_close(struct saa7146_dev *dev, struct file *file)
 {
+	struct saa7146_fh *fh = (struct saa7146_fh *)file->private_data;
 	struct saa7146_vv *vv = dev->vv_data;
 	unsigned long flags;
 	
@@ -1443,10 +1348,8 @@
 	}
 	
 	if( fh == vv->streaming ) {
-		video_end(fh);		
+		video_end(fh, file);		
 	}
-
-	videobuf_queue_cancel(file,&fh->video_q);
 }
 
 
@@ -1489,7 +1392,7 @@
 		return -EAGAIN;
 	}
 	ret = videobuf_read_one(file,&fh->video_q , data, count, ppos);
-	video_end(fh);
+	video_end(fh, file);
 
 	/* restart overlay if it was active before */
 	if( 0 != restart_overlay ) {
@@ -1505,6 +1408,4 @@
 	.release = video_close,
 	.irq_done = video_irq_done,
 	.read = video_read,
-	.capture_begin = video_begin,
-	.capture_end = video_end,
 };
diff -uNrwB --new-file linux-2.6.0/include/media/saa7146.h linux-2.6.0-p/include/media/saa7146.h
--- linux-2.6.0/include/media/saa7146.h	2003-12-18 03:58:04.000000000 +0100
+++ linux-2.6.0-p/include/media/saa7146.h	2003-12-08 16:19:01.000000000 +0100
@@ -87,6 +87,7 @@
 {
 	char	name[32];		/* name of the device */
 #define SAA7146_USE_I2C_IRQ	0x1
+#define SAA7146_I2C_SHORT_DELAY	0x2
 	int	flags;
 	
 	/* pairs of subvendor and subdevice ids for
@@ -162,9 +163,10 @@
 struct saa7146_format* format_by_fourcc(struct saa7146_dev *dev, int fourcc);
 int saa7146_pgtable_alloc(struct pci_dev *pci, struct saa7146_pgtable *pt);
 void saa7146_pgtable_free(struct pci_dev *pci, struct saa7146_pgtable *pt);
-void saa7146_pgtable_build_single(struct pci_dev *pci, struct saa7146_pgtable *pt, struct scatterlist *list, int length );
+int saa7146_pgtable_build_single(struct pci_dev *pci, struct saa7146_pgtable *pt, struct scatterlist *list, int length );
 char *saa7146_vmalloc_build_pgtable(struct pci_dev *pci, long length, struct saa7146_pgtable *pt);
 void saa7146_setgpio(struct saa7146_dev *dev, int port, u32 data);
+int saa7146_wait_for_debi_done(struct saa7146_dev *dev);
 
 /* some memory sizes */
 #define SAA7146_I2C_MEM		( 1*PAGE_SIZE)
@@ -187,6 +189,9 @@
 #define SAA7146_GPIO_OUTLO 0x40
 #define SAA7146_GPIO_OUTHI 0x50
 
+/* debi defines */
+#define DEBINOSWAP 0x000e0000
+
 /* define for the register programming sequencer (rps) */
 #define CMD_NOP		0x00000000  /* No operation */
 #define CMD_CLR_EVENT	0x00000000  /* Clear event */
diff -uNrwB --new-file linux-2.6.0/include/media/saa7146_vv.h linux-2.6.0-p/include/media/saa7146_vv.h
--- linux-2.6.0/include/media/saa7146_vv.h	2003-12-18 03:58:08.000000000 +0100
+++ linux-2.6.0-p/include/media/saa7146_vv.h	2003-12-17 14:00:22.000000000 +0100
@@ -149,7 +149,7 @@
 };
 
 /* flags */
-#define SAA7146_EXT_SWAP_ODD_EVEN       0x1     /* needs odd/even fields swapped */
+// #define SAA7146_EXT_SWAP_ODD_EVEN	0x1     /* needs odd/even fields swapped */
 #define SAA7146_USE_PORT_B_FOR_VBI	0x2     /* use input port b for vbi hardware bug workaround */
 
 struct saa7146_ext_vv
@@ -171,12 +171,10 @@
 
 struct saa7146_use_ops  {
         void (*init)(struct saa7146_dev *, struct saa7146_vv *);
-        void(*open)(struct saa7146_dev *, struct saa7146_fh *);
-        void (*release)(struct saa7146_dev *, struct saa7146_fh *,struct file *);
+        void(*open)(struct saa7146_dev *, struct file *);
+        void (*release)(struct saa7146_dev *, struct file *);
         void (*irq_done)(struct saa7146_dev *, unsigned long status);
 	ssize_t (*read)(struct file *, char *, size_t, loff_t *);
-        int (*capture_begin)(struct saa7146_fh *);
-        int (*capture_end)(struct saa7146_fh *);
 };
 
 /* from saa7146_fops.c */
diff -ura linux-2.6.0.p/drivers/media/common/saa7146_video.c linux-2.6.0.p2/drivers/media/common/saa7146_video.c
--- linux-2.6.0.p/drivers/media/common/saa7146_video.c	2003-12-19 10:38:46.000000000 +0100
+++ linux-2.6.0.p2/drivers/media/common/saa7146_video.c	2003-12-19 10:40:43.000000000 +0100
@@ -736,8 +736,6 @@
 
 	vv->streaming = NULL;
 
-	videobuf_queue_cancel(file,&fh->video_q);
-	
 	spin_unlock_irqrestore(&dev->slock, flags);
 	
 	return 0;
@@ -1105,8 +1103,8 @@
 		int *type = arg;
 
 		DEB_D(("VIDIOC_STREAMOFF, type:%d\n",*type));
-		video_end(fh, file);
 		err = videobuf_streamoff(file,q);
+		video_end(fh, file);
 		return err;
 	}
 	case VIDIOCGMBUF:

