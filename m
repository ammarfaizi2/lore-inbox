Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263290AbUARSig (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 13:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263205AbUARShv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 13:37:51 -0500
Received: from mail.convergence.de ([212.84.236.4]:45548 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S262888AbUARSfi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 13:35:38 -0500
To: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       hunold@linuxtv.org
From: Michael Hunold <hunold@linuxtv.org>
Subject: [PATCH 2/5] Update saa7146 driver
In-Reply-To: <10744509221553@convergence.de>
Message-Id: <1074450922352@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring_mihu_extended
Date: Sun, 18 Jan 2004 13:35:38 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- [DVB] fix memory leak in page table handling
- [DVB] minor coding style changes
- [DVB] add simple resource management for video dmas (borrowed from saa7134)
- [DVB] use resource management to lock video and vbi access which sometimes share the same video dmas
- [DVB] honour return codes of extension functions in various places, when resources could not be locked
- [DVB] remove remains of dead code which were commented out anyway 
- [DVB] add new flag FORMAT_IS_PLANAR to indicate planar capture formats, needed for resource allocation
diff -uraNbBw xx-linux-2.6.1-mm4/include/media/saa7146.h linux-2.6.1-mm4.patched/include/media/saa7146.h
--- xx-linux-2.6.1-mm4/include/media/saa7146.h	2004-01-16 19:49:14.000000000 +0100
+++ linux-2.6.1-mm4.patched/include/media/saa7146.h	2004-01-03 23:30:38.000000000 +0100
@@ -67,6 +67,8 @@
 	dma_addr_t	dma;
 	/* used for offsets for u,v planes for planar capture modes */
 	unsigned long	offset;
+	/* used for custom pagetables (used for example by budget dvb cards) */
+	struct scatterlist *slist;
 };
 
 struct saa7146_pci_extension_data {
diff -uraNbBw xx-linux-2.6.1-mm4/drivers/media/common/saa7146_core.c linux-2.6.1-mm4.patched/drivers/media/common/saa7146_core.c
--- xx-linux-2.6.1-mm4/drivers/media/common/saa7146_core.c	2004-01-16 19:48:22.000000000 +0100
+++ linux-2.6.1-mm4.patched/drivers/media/common/saa7146_core.c	2004-01-09 20:27:26.000000000 +0100
@@ -137,7 +137,6 @@
 
 char *saa7146_vmalloc_build_pgtable(struct pci_dev *pci, long length, struct saa7146_pgtable *pt)
 {
-	struct scatterlist *slist = NULL;
 	int pages = (length+PAGE_SIZE-1)/PAGE_SIZE;
 	char *mem = vmalloc_32(length);
 	int slen = 0;
@@ -146,35 +145,36 @@
 		return NULL;
 	}
 
-	if (!(slist = vmalloc_to_sg(mem, pages))) {
+	if (!(pt->slist = vmalloc_to_sg(mem, pages))) {
 		vfree(mem);
 		return NULL;
 	}
 
 	if (saa7146_pgtable_alloc(pci, pt)) {
-		kfree(slist);
+		kfree(pt->slist);
+		pt->slist = NULL;
 		vfree(mem);
 		return NULL;
 	}
 	
-	slen = pci_map_sg(pci,slist,pages,PCI_DMA_FROMDEVICE);
-	if (0 != saa7146_pgtable_build_single(pci, pt, slist, slen)) {
+	slen = pci_map_sg(pci,pt->slist,pages,PCI_DMA_FROMDEVICE);
+	if (0 != saa7146_pgtable_build_single(pci, pt, pt->slist, slen)) {
 		return NULL;
 	}
 
-	/* fixme: here's a memory leak: slist never gets freed by any other
-	   function ...*/
 	return mem;
 }
 
 void saa7146_pgtable_free(struct pci_dev *pci, struct saa7146_pgtable *pt)
 {
-//fm	DEB_EE(("pci:%p, pt:%p\n",pci,pt));
-
 	if (NULL == pt->cpu)
 		return;
 	pci_free_consistent(pci, pt->size, pt->cpu, pt->dma);
 	pt->cpu = NULL;
+	if (NULL != pt->slist) {
+		kfree(pt->slist);
+		pt->slist = NULL;
+	}
 }
 
 int saa7146_pgtable_alloc(struct pci_dev *pci, struct saa7146_pgtable *pt)
@@ -182,11 +182,8 @@
         u32          *cpu;
         dma_addr_t   dma_addr;
 
-//fm	DEB_EE(("pci:%p, pt:%p\n",pci,pt));
-
 	cpu = pci_alloc_consistent(pci, SAA7146_PGTABLE_SIZE, &dma_addr);
 	if (NULL == cpu) {
-//fm		ERR(("pci_alloc_consistent() failed."));
 		return -ENOMEM;
 	}
 	pt->size = SAA7146_PGTABLE_SIZE;
diff -uraNbBw xx-linux-2.6.1-mm4/drivers/media/common/saa7146_fops.c linux-2.6.1-mm4.patched/drivers/media/common/saa7146_fops.c
--- xx-linux-2.6.1-mm4/drivers/media/common/saa7146_fops.c	2004-01-16 19:48:22.000000000 +0100
+++ linux-2.6.1-mm4.patched/drivers/media/common/saa7146_fops.c	2004-01-03 22:59:11.000000000 +0100
@@ -2,6 +2,65 @@
 
 #define BOARD_CAN_DO_VBI(dev)   (dev->revision != 0 && dev->vv_data->vbi_minor != -1) 
 
+/****************************************************************************/
+/* resource management functions, shamelessly stolen from saa7134 driver */
+
+int saa7146_res_get(struct saa7146_fh *fh, unsigned int bit)
+{
+	struct saa7146_dev *dev = fh->dev;
+	struct saa7146_vv *vv = dev->vv_data;
+	
+	if (fh->resources & bit)
+		/* have it already allocated */
+		return 1;
+
+	/* is it free? */
+	DEB_D(("getting lock...\n"));
+	down(&dev->lock);
+	DEB_D(("got lock\n"));
+	if (vv->resources & bit) {
+		DEB_D(("locked! vv->resources:0x%02x, we want:0x%02x\n",vv->resources,bit));
+		/* no, someone else uses it */
+		up(&dev->lock);
+		return 0;
+	}
+	/* it's free, grab it */
+	fh->resources  |= bit;
+	vv->resources |= bit;
+	DEB_D(("res: get %d\n",bit));
+	up(&dev->lock);
+	return 1;
+}
+
+int saa7146_res_check(struct saa7146_fh *fh, unsigned int bit)
+{
+	return (fh->resources & bit);
+}
+
+int saa7146_res_locked(struct saa7146_dev *dev, unsigned int bit)
+{
+	struct saa7146_vv *vv = dev->vv_data;
+	return (vv->resources & bit);
+}
+
+void saa7146_res_free(struct saa7146_fh *fh, unsigned int bits)
+{
+	struct saa7146_dev *dev = fh->dev;
+	struct saa7146_vv *vv = dev->vv_data;
+
+	if ((fh->resources & bits) != bits)
+		BUG();
+
+	DEB_D(("getting lock...\n"));
+	down(&dev->lock);
+	DEB_D(("got lock\n"));
+	fh->resources  &= ~bits;
+	vv->resources &= ~bits;
+	DEB_D(("res: put %d\n",bits));
+	up(&dev->lock);
+}
+
+
 /********************************************************************************/
 /* common dma functions */
 
@@ -216,29 +275,32 @@
 	}
 	memset(fh,0,sizeof(*fh));
 	
-	// FIXME: do we need to increase *our* usage count?
-
-	if( 0 == try_module_get(dev->ext->module)) {
-		result = -EINVAL;
-		goto out;
-	}
-
 	file->private_data = fh;
 	fh->dev = dev;
 	fh->type = type;
 
 	if( fh->type == V4L2_BUF_TYPE_VBI_CAPTURE) {
 		DEB_S(("initializing vbi...\n"));
-		saa7146_vbi_uops.open(dev,file);
+		result = saa7146_vbi_uops.open(dev,file);
 	} else {
 		DEB_S(("initializing video...\n"));
-		saa7146_video_uops.open(dev,file);
+		result = saa7146_video_uops.open(dev,file);
+	}
+	
+	if (0 != result) {
+		goto out;
+	}
+
+	if( 0 == try_module_get(dev->ext->module)) {
+		result = -EINVAL;
+		goto out;
 	}
 
 	result = 0;
 out:
 	if( fh != 0 && result != 0 ) {
 		kfree(fh);
+		file->private_data = NULL;
 	}
 	up(&saa7146_devices_lock);
         return result;
diff -uraNbBw xx-linux-2.6.1-mm4/drivers/media/common/saa7146_hlp.c linux-2.6.1-mm4.patched/drivers/media/common/saa7146_hlp.c
--- xx-linux-2.6.1-mm4/drivers/media/common/saa7146_hlp.c	2004-01-16 19:48:22.000000000 +0100
+++ linux-2.6.1-mm4.patched/drivers/media/common/saa7146_hlp.c	2004-01-04 17:20:31.000000000 +0100
@@ -152,8 +152,7 @@
 	if( 1 == xpsc ) {
 		xacm = 1;
 		dcgx = 0;
-	}
-	else {
+	} else {
 		xacm = 0;
 		/* get best match in the table of attenuations
 		   for horizontal scaling */
@@ -268,8 +267,7 @@
 		ype = ysci / 16;
 		ypo = ype + (ysci / 64);
 		
-	}
-	else {
+	} else {
 		yacm = 1;	
 
 		/* calculate scaling increment */
@@ -285,8 +283,7 @@
 						... */
 		if ( ysci < 512) {
 			yacl = 0;
-		}
-		else {
+		} else {
 			yacl = ( ysci / (1024 - ysci) );
 		}
 
@@ -488,33 +485,31 @@
  	saa7146_write(dev, MC2, (MASK_05 | MASK_21));
  
  	/* disable video dma2 */
-	saa7146_write(dev, MC1, (MASK_21));
+	saa7146_write(dev, MC1, MASK_21);
 }
 
-static void saa7146_set_clipping_rect(struct saa7146_dev *dev, struct saa7146_fh *fh)
+static void saa7146_set_clipping_rect(struct saa7146_fh *fh)
 {
+	struct saa7146_dev *dev = fh->dev;
 	enum v4l2_field field = fh->ov.win.field;
-	int clipcount = fh->ov.nclips;
-	
 	struct	saa7146_video_dma vdma2;
-
-	u32 clip_format	= saa7146_read(dev, CLIP_FORMAT_CTRL);
-	u32 arbtr_ctrl	= saa7146_read(dev, PCI_BT_V1);
-
-	// fixme: is this used at all? SAA7146_CLIPPING_RECT_INVERTED;
-	u32 type = SAA7146_CLIPPING_RECT;
+	u32 clip_format;
+	u32 arbtr_ctrl;
 
 	/* check clipcount, disable clipping if clipcount == 0*/
-	if( clipcount == 0 ) {
+	if( fh->ov.nclips == 0 ) {
 		saa7146_disable_clipping(dev);
 		return;
 	}
 
+	clip_format = saa7146_read(dev, CLIP_FORMAT_CTRL);
+	arbtr_ctrl = saa7146_read(dev, PCI_BT_V1);
+
 	calculate_clipping_registers_rect(dev, fh, &vdma2, &clip_format, &arbtr_ctrl, field);
 
 	/* set clipping format */
 	clip_format &= 0xffff0008;
-	clip_format |= (type << 4);
+	clip_format |= (SAA7146_CLIPPING_RECT << 4);
 
 	/* prepare video dma2 */
 	saa7146_write(dev, BASE_EVEN2,		vdma2.base_even);
@@ -660,25 +655,28 @@
 	vv->current_hps_sync = sync;
 } 
 
-/* reprogram hps, enable(1) / disable(0) video */
-void saa7146_set_overlay(struct saa7146_dev *dev, struct saa7146_fh *fh, int v)
+int saa7146_enable_overlay(struct saa7146_fh *fh)
 {
+	struct saa7146_dev *dev = fh->dev;
 	struct saa7146_vv *vv = dev->vv_data;
 
-	/* enable ? */
-	if( 0 == v) {
-		/* disable video dma1 */
-      		saa7146_write(dev, MC1, MASK_22);
-		return;
-	}
-
 	saa7146_set_window(dev, fh->ov.win.w.width, fh->ov.win.w.height, fh->ov.win.field);
 	saa7146_set_position(dev, fh->ov.win.w.left, fh->ov.win.w.top, fh->ov.win.w.height, fh->ov.win.field);
 	saa7146_set_output_format(dev, vv->ov_fmt->trans);
-	saa7146_set_clipping_rect(dev, fh);
+	saa7146_set_clipping_rect(fh);
 
 	/* enable video dma1 */
 	saa7146_write(dev, MC1, (MASK_06 | MASK_22));
+	return 0;
+}		
+
+void saa7146_disable_overlay(struct saa7146_fh *fh)
+{
+	struct saa7146_dev *dev = fh->dev;
+
+	/* disable clipping + video dma1 */
+ 	saa7146_disable_clipping(dev);
+	saa7146_write(dev, MC1, MASK_22);
 }		
 
 void saa7146_write_out_dma(struct saa7146_dev* dev, int which, struct saa7146_video_dma* vdma) 
@@ -692,15 +690,8 @@
 	/* calculate starting address */
 	where  = (which-1)*0x18;
 
-/*
-	if( 0 != (dev->ext_vv_data->flags & SAA7146_EXT_SWAP_ODD_EVEN)) {
-		saa7146_write(dev, where, 	vdma->base_even);
-		saa7146_write(dev, where+0x04, 	vdma->base_odd);
-	} else {
-*/
 		saa7146_write(dev, where, 	vdma->base_odd);
 		saa7146_write(dev, where+0x04, 	vdma->base_even);
-//	}
 	saa7146_write(dev, where+0x08, 	vdma->prot_addr);
 	saa7146_write(dev, where+0x0c, 	vdma->pitch);
 	saa7146_write(dev, where+0x10, 	vdma->base_page);
@@ -937,7 +928,7 @@
 	}	
 
 	saa7146_write_out_dma(dev, 1, &vdma1);
-	if( sfmt->swap != 0 ) {
+	if( (sfmt->flags & FORMAT_BYTE_SWAP) != 0 ) {
 		saa7146_write_out_dma(dev, 3, &vdma2);
 		saa7146_write_out_dma(dev, 2, &vdma3);
 	} else {
@@ -955,13 +946,6 @@
 	unsigned long e_wait = vv->current_hps_sync == SAA7146_HPS_SYNC_PORT_A ? CMD_E_FID_A : CMD_E_FID_B;
 	unsigned long o_wait = vv->current_hps_sync == SAA7146_HPS_SYNC_PORT_A ? CMD_O_FID_A : CMD_O_FID_B;
 
-/*
-	if( 0 != (dev->ext_vv_data->flags & SAA7146_EXT_SWAP_ODD_EVEN)) {
-		unsigned long tmp = e_wait;
-		e_wait = o_wait;
-		o_wait = tmp;
-	}
-*/
 	/* wait for o_fid_a/b / e_fid_a/b toggle only if rps register 0 is not set*/
 	WRITE_RPS0(CMD_PAUSE | CMD_OAN | CMD_SIG0 | o_wait);
 	WRITE_RPS0(CMD_PAUSE | CMD_OAN | CMD_SIG0 | e_wait);
@@ -1038,7 +1022,6 @@
 
 	saa7146_set_window(dev, buf->fmt->width, buf->fmt->height, buf->fmt->field);
 	saa7146_set_output_format(dev, sfmt->trans);
-	saa7146_disable_clipping(dev);
 
 	if ( vv->last_field == V4L2_FIELD_INTERLACED ) {
 	} else if ( vv->last_field == V4L2_FIELD_TOP ) {
diff -uraNbBw xx-linux-2.6.1-mm4/drivers/media/common/saa7146_vbi.c linux-2.6.1-mm4.patched/drivers/media/common/saa7146_vbi.c
--- xx-linux-2.6.1-mm4/drivers/media/common/saa7146_vbi.c	2004-01-16 19:48:22.000000000 +0100
+++ linux-2.6.1-mm4.patched/drivers/media/common/saa7146_vbi.c	2004-01-03 22:15:07.000000000 +0100
@@ -366,7 +367,7 @@
 	init_waitqueue_head(&vv->vbi_wq);
 }
 
-static void vbi_open(struct saa7146_dev *dev, struct file *file)
+static int vbi_open(struct saa7146_dev *dev, struct file *file)
 {
 	struct saa7146_fh *fh = (struct saa7146_fh *)file->private_data;
 	
@@ -375,6 +376,12 @@
 	
 	DEB_VBI(("dev:%p, fh:%p\n",dev,fh));
 
+	ret = saa7146_res_get(fh, RESOURCE_DMA3_BRS);
+	if (0 == ret) {
+		DEB_S(("cannot get vbi RESOURCE_DMA3_BRS resource\n"));
+		return -EBUSY;
+	}
+
 	/* adjust arbitrition control for video dma 3 */
 	arbtr_ctrl &= ~0x1f0000;
 	arbtr_ctrl |=  0x1d0000;
@@ -419,6 +426,7 @@
 
 	/* upload brs register */
 	saa7146_write(dev, MC2, (MASK_08|MASK_24));		
+	return 0;		
 }
 
 static void vbi_close(struct saa7146_dev *dev, struct file *file)
@@ -430,6 +438,7 @@
 	if( fh == vv->vbi_streaming ) {
 		vbi_stop(fh, file);
 	}
+	saa7146_res_free(fh, RESOURCE_DMA3_BRS);
 }
 
 static void vbi_irq_done(struct saa7146_dev *dev, unsigned long status)
diff -uraNbBw xx-linux-2.6.1-mm4/drivers/media/common/saa7146_video.c linux-2.6.1-mm4.patched/drivers/media/common/saa7146_video.c
--- xx-linux-2.6.1-mm4/drivers/media/common/saa7146_video.c	2004-01-16 19:48:22.000000000 +0100
+++ linux-2.6.1-mm4.patched/drivers/media/common/saa7146_video.c	2004-01-16 18:21:55.000000000 +0100
@@ -12,48 +12,55 @@
 		.pixelformat	= V4L2_PIX_FMT_RGB332,
 		.trans 		= RGB08_COMPOSED,
 		.depth		= 8,
+		.flags		= 0,
 	}, {
-		.name 		= "RGB-16 (5/B-6/G-5/R)", 	/* really? */
+		.name 		= "RGB-16 (5/B-6/G-5/R)",
 		.pixelformat	= V4L2_PIX_FMT_RGB565,
 		.trans 		= RGB16_COMPOSED,
 		.depth		= 16,
+		.flags		= 0,
 	}, {
 		.name 		= "RGB-24 (B-G-R)",
 		.pixelformat	= V4L2_PIX_FMT_BGR24,
 		.trans 		= RGB24_COMPOSED,
 		.depth		= 24,
+		.flags		= 0,
 	}, {
 		.name 		= "RGB-32 (B-G-R)",
 		.pixelformat	= V4L2_PIX_FMT_BGR32,
 		.trans 		= RGB32_COMPOSED,
 		.depth		= 32,
+		.flags		= 0,
 	}, {
 		.name 		= "Greyscale-8",
 		.pixelformat	= V4L2_PIX_FMT_GREY,
 		.trans 		= Y8,
 		.depth		= 8,
+		.flags		= 0,
 	}, {
 		.name 		= "YUV 4:2:2 planar (Y-Cb-Cr)",
 		.pixelformat	= V4L2_PIX_FMT_YUV422P,
 		.trans 		= YUV422_DECOMPOSED,
 		.depth		= 16,
-		.swap		= 1,
+		.flags		= FORMAT_BYTE_SWAP|FORMAT_IS_PLANAR,
 	}, {
 		.name 		= "YVU 4:2:0 planar (Y-Cb-Cr)",
 		.pixelformat	= V4L2_PIX_FMT_YVU420,
 		.trans 		= YUV420_DECOMPOSED,
 		.depth		= 12,
-		.swap		= 1,
+		.flags		= FORMAT_BYTE_SWAP|FORMAT_IS_PLANAR,
 	}, {
 		.name 		= "YUV 4:2:0 planar (Y-Cb-Cr)",
 		.pixelformat	= V4L2_PIX_FMT_YUV420,
 		.trans 		= YUV420_DECOMPOSED,
 		.depth		= 12,
+		.flags		= FORMAT_IS_PLANAR,
 	}, {
 		.name 		= "YUV 4:2:2 (U-Y-V-Y)",
 		.pixelformat	= V4L2_PIX_FMT_UYVY,
 		.trans 		= YUV422_COMPOSED,
 		.depth		= 16,
+		.flags		= 0,
 	}
 };
 
@@ -243,13 +250,13 @@
 {
 	struct saa7146_dev *dev = fh->dev;
 	struct saa7146_vv *vv = dev->vv_data;
-	int err = 0;
+	int ret = 0, err = 0;
 
 	DEB_EE(("dev:%p, fh:%p\n",dev,fh));
 
 	/* check if we have overlay informations */
 	if( NULL == fh->ov.fh ) {
-		DEB_D(("not overlay data available. try S_FMT first.\n"));
+		DEB_D(("no overlay data available. try S_FMT first.\n"));
 		return -EAGAIN;
 	}
 
@@ -280,7 +287,11 @@
 		fh->ov.win.w.left,fh->ov.win.w.top,
 		vv->ov_fmt->name,v4l2_field_names[fh->ov.win.field]));
 	
-	saa7146_set_overlay(dev, fh, 1);
+	if (0 != (ret = saa7146_enable_overlay(fh))) {
+		vv->ov_data = NULL;
+		DEB_D(("enabling overlay failed: %d\n",ret));
+		return ret;
+	}
 
 	return 0;
 }
@@ -290,7 +301,7 @@
 	struct saa7146_dev *dev = fh->dev;
 	struct saa7146_vv *vv = dev->vv_data;
 
-	DEB_EE(("saa7146.o: saa7146_stop_preview()\n"));
+	DEB_EE(("dev:%p, fh:%p\n",dev,fh));
 
 	/* check if overlay is running */
 	if( 0 == vv->ov_data ) {
@@ -300,11 +311,11 @@
 
 	if( fh != vv->ov_data->fh ) {
 		DEB_D(("overlay is active, but for another open.\n"));
-		return -EBUSY;
+		return 0;
 	}
 
-	saa7146_set_overlay(dev, fh, 0);
 	vv->ov_data = NULL;
+	saa7146_disable_overlay(fh);
 	
 	return 0;
 }
@@ -675,21 +686,37 @@
 {
 	struct saa7146_dev *dev = fh->dev;
 	struct saa7146_vv *vv = dev->vv_data;
+	struct saa7146_format *fmt = NULL;
 	unsigned long flags;
+	unsigned int resource;
+	int ret = 0;
 
 	DEB_EE(("dev:%p, fh:%p\n",dev,fh));
 
 	if( fh == vv->streaming ) {
 		DEB_S(("already capturing.\n"));
-		return 0;
+		return -EBUSY;
 	}
 	if( vv->streaming != 0 ) {
 		DEB_S(("already capturing, but in another open.\n"));
 		return -EBUSY;
 	}
 
-	/* fixme: check for planar formats here, if we will interfere with
-	   vbi capture for example */	
+	fmt = format_by_fourcc(dev,fh->video_fmt.pixelformat);
+	/* we need to have a valid format set here */
+	BUG_ON(NULL == fmt);
+
+	if (0 != (fmt->flags & FORMAT_IS_PLANAR)) {
+		resource = RESOURCE_DMA1_HPS|RESOURCE_DMA2_CLP|RESOURCE_DMA3_BRS;
+	} else {
+		resource = RESOURCE_DMA1_HPS;
+	}
+
+	ret = saa7146_res_get(fh, resource);
+	if (0 == ret) {
+		DEB_S(("cannot get capture resource %d\n",resource));
+		return -EBUSY;
+	}
 
 	spin_lock_irqsave(&dev->slock,flags);
 
@@ -708,8 +735,10 @@
 {
 	struct saa7146_dev *dev = fh->dev;
 	struct saa7146_vv *vv = dev->vv_data;
+	struct saa7146_format *fmt = NULL;
 	unsigned long flags;
-	
+	unsigned int resource;
+	u32 dmas = 0;
 	DEB_EE(("dev:%p, fh:%p\n",dev,fh));
 
 	if( vv->streaming != fh ) {
@@ -717,6 +746,19 @@
 		return -EINVAL;
 	}
 
+	fmt = format_by_fourcc(dev,fh->video_fmt.pixelformat);
+	/* we need to have a valid format set here */
+	BUG_ON(NULL == fmt);
+
+	if (0 != (fmt->flags & FORMAT_IS_PLANAR)) {
+		resource = RESOURCE_DMA1_HPS|RESOURCE_DMA2_CLP|RESOURCE_DMA3_BRS;
+		dmas = MASK_22 | MASK_21 | MASK_20;
+	} else {
+		resource = RESOURCE_DMA1_HPS;
+		dmas = MASK_20;
+	}
+	saa7146_res_free(fh, resource);
+
 	spin_lock_irqsave(&dev->slock,flags);
 
 	/* disable rps0  */
@@ -725,14 +767,8 @@
 	/* disable rps0 irqs */
 	IER_DISABLE(dev, MASK_27);
 
-	// fixme: only used formats here!
-	/* fixme: look at planar formats here, especially at the
-	   shutdown of planar formats! */
-
 	/* shut down all used video dma transfers */
-	/* fixme: what about the budget-dvb cards? they use
-	   video-dma3, but video_end should not get called anyway ...*/
-	saa7146_write(dev, MC1, 0x00700000);
+	saa7146_write(dev, MC1, dmas);
 
 	vv->streaming = NULL;
 
@@ -849,8 +883,12 @@
 			return -EINVAL;
 		}
 		
-		down(&dev->lock);
+		/* planar formats are not allowed for overlay video, clipping and video dma would clash */
+		if (0 != (fmt->flags & FORMAT_IS_PLANAR)) {
+			DEB_S(("planar pixelformat '%4.4s' not allowed for overlay\n",(char *)&fmt->pixelformat));
+		}
 
+		down(&dev->lock);
 		if( vv->ov_data != NULL ) {
 			ov_fh = vv->ov_data->fh;
 			saa7146_stop_preview(ov_fh);
@@ -1002,7 +1044,9 @@
 			return -EBUSY;
 		}
 
+		DEB_D(("before getting lock...\n"));
 		down(&dev->lock);
+		DEB_D(("got lock\n"));
 
 		if( vv->ov_data != NULL ) {
 			ov_fh = vv->ov_data->fh;
@@ -1047,22 +1095,33 @@
 		if( 0 != on ) {
 			if( vv->ov_data != NULL ) {
 				if( fh != vv->ov_data->fh) {
+					DEB_D(("overlay already active in another open\n"));
 					return -EAGAIN;
 				}
 			}
+
+			if (0 == saa7146_res_get(fh, RESOURCE_DMA1_HPS|RESOURCE_DMA2_CLP)) {
+				DEB_D(("cannot get overlay resources\n"));
+				return -EBUSY;
+			}
+
 			spin_lock_irqsave(&dev->slock,flags);
 			err = saa7146_start_preview(fh);
 			spin_unlock_irqrestore(&dev->slock,flags);
-		} else {
+			return err;
+		}
+		
 			if( vv->ov_data != NULL ) {
 				if( fh != vv->ov_data->fh) {
+				DEB_D(("overlay is active, but in another open\n"));
 					return -EAGAIN;
 				}
 			}
 			spin_lock_irqsave(&dev->slock,flags);
 			err = saa7146_stop_preview(fh);
 			spin_unlock_irqrestore(&dev->slock,flags);
-		}
+		/* free resources */
+		saa7146_res_free(fh, RESOURCE_DMA1_HPS|RESOURCE_DMA2_CLP);
 		return err;
 	}
 	case VIDIOC_REQBUFS: {
@@ -1093,7 +1152,13 @@
 		int *type = arg;
 		DEB_D(("VIDIOC_STREAMON, type:%d\n",*type));
 
-		if( 0 != (err = video_begin(fh))) {
+		if( fh == vv->streaming ) {
+			DEB_D(("already capturing.\n"));
+			return 0;
+		}
+
+		err = video_begin(fh);
+		if( 0 != err) {
 				return err;
 			}
 		err = videobuf_streamon(file,q);
@@ -1103,6 +1168,12 @@
 		int *type = arg;
 
 		DEB_D(("VIDIOC_STREAMOFF, type:%d\n",*type));
+
+		if( fh != vv->streaming ) {
+			DEB_D(("this open is not capturing.\n"));
+			return -EINVAL;
+		}
+
 		err = videobuf_streamoff(file,q);
 		video_end(fh, file);
 		return err;
@@ -1309,7 +1380,7 @@
 }
 
 
-static void video_open(struct saa7146_dev *dev, struct file *file)
+static int video_open(struct saa7146_dev *dev, struct file *file)
 {
 	struct saa7146_fh *fh = (struct saa7146_fh *)file->private_data;
 	struct saa7146_format *sfmt;
@@ -1329,6 +1400,8 @@
 			    sizeof(struct saa7146_buf));
 
 	init_MUTEX(&fh->video_q.lock);
+
+	return 0;
 }
 
 
@@ -1381,15 +1454,25 @@
 
 	DEB_EE(("called.\n"));
 
+	/* fixme: should we allow read() captures while streaming capture? */
+	if( 0 != vv->streaming ) {
+		DEB_S(("already capturing.\n"));
+		return -EBUSY;
+	}
+
+	/* stop any active overlay */
 	if( vv->ov_data != NULL ) {
 		ov_fh = vv->ov_data->fh;
 		saa7146_stop_preview(ov_fh);
+		saa7146_res_free(ov_fh, RESOURCE_DMA1_HPS|RESOURCE_DMA2_CLP);
 		restart_overlay = 1;
 	}
 
-	if( 0 != video_begin(fh)) {
-		return -EAGAIN;
+	ret = video_begin(fh);
+	if( 0 != ret) {
+		goto out;
 	}
+
 	ret = videobuf_read_one(file,&fh->video_q , data, count, ppos);
 	video_end(fh, file);
 
@@ -1393,8 +1476,13 @@
 	ret = videobuf_read_one(file,&fh->video_q , data, count, ppos);
 	video_end(fh, file);
 
+out:
 	/* restart overlay if it was active before */
 	if( 0 != restart_overlay ) {
+		if (0 == saa7146_res_get(ov_fh, RESOURCE_DMA1_HPS|RESOURCE_DMA2_CLP)) {
+			DEB_D(("cannot get overlay resources again!\n"));
+			BUG();
+		}
 		saa7146_start_preview(ov_fh);
 	}
 	
diff -uraNbBw xx-linux-2.6.1-mm4/include/media/saa7146_vv.h linux-2.6.1-mm4.patched/include/media/saa7146_vv.h
--- xx-linux-2.6.1-mm4/include/media/saa7146_vv.h	2004-01-16 19:49:14.000000000 +0100
+++ linux-2.6.1-mm4.patched/include/media/saa7146_vv.h	2004-01-09 20:27:29.000000000 +0100
@@ -26,12 +26,15 @@
 	u32 num_line_byte;
 };
 
+#define FORMAT_BYTE_SWAP	0x1
+#define FORMAT_IS_PLANAR	0x2
+
 struct saa7146_format {
 	char	*name;
-	int   	pixelformat;
+	u32   	pixelformat;
 	u32	trans;
 	u8	depth;
-	int	swap;
+	u8	flags;
 };
 
 struct saa7146_standard
@@ -97,6 +100,8 @@
 	struct videobuf_queue	vbi_q;
 	struct v4l2_vbi_format	vbi_fmt;
 	struct timer_list	vbi_read_timeout;
+
+	unsigned int resources;	/* resource management for device open */
 };
 
 struct saa7146_vv
@@ -136,6 +141,8 @@
 	int 	current_hps_sync;
 
 	struct saa7146_dma	d_clipping;	/* pointer to clipping memory */
+
+	unsigned int resources;	/* resource management for device */
 };
 
 #define SAA7146_EXCLUSIVE	0x1
@@ -149,7 +156,6 @@
 };
 
 /* flags */
-// #define SAA7146_EXT_SWAP_ODD_EVEN	0x1     /* needs odd/even fields swapped */
 #define SAA7146_USE_PORT_B_FOR_VBI	0x2     /* use input port b for vbi hardware bug workaround */
 
 struct saa7146_ext_vv
@@ -171,7 +177,7 @@
 
 struct saa7146_use_ops  {
         void (*init)(struct saa7146_dev *, struct saa7146_vv *);
-        void(*open)(struct saa7146_dev *, struct file *);
+        int(*open)(struct saa7146_dev *, struct file *);
         void (*release)(struct saa7146_dev *, struct file *);
         void (*irq_done)(struct saa7146_dev *, unsigned long status);
 	ssize_t (*read)(struct file *, char *, size_t, loff_t *);
@@ -189,9 +195,10 @@
 int saa7146_vv_init(struct saa7146_dev* dev, struct saa7146_ext_vv *ext_vv);
 int saa7146_vv_release(struct saa7146_dev* dev);
 
-
 /* from saa7146_hlp.c */
-void saa7146_set_overlay(struct saa7146_dev *dev, struct saa7146_fh *fh, int v);
+int saa7146_enable_overlay(struct saa7146_fh *fh);
+void saa7146_disable_overlay(struct saa7146_fh *fh);
+
 void saa7146_set_capture(struct saa7146_dev *dev, struct saa7146_buf *buf, struct saa7146_buf *next);
 void saa7146_write_out_dma(struct saa7146_dev* dev, int which, struct saa7146_video_dma* vdma) ;
 void saa7146_set_hps_source_and_sync(struct saa7146_dev *saa, int source, int sync);
@@ -205,6 +212,16 @@
 /* from saa7146_vbi.c */
 extern struct saa7146_use_ops saa7146_vbi_uops;
 
+/* resource management functions */
+int saa7146_res_get(struct saa7146_fh *fh, unsigned int bit);
+int saa7146_res_check(struct saa7146_fh *fh, unsigned int bit);
+int saa7146_res_locked(struct saa7146_dev *dev, unsigned int bit);
+void saa7146_res_free(struct saa7146_fh *fh, unsigned int bits);
+
+#define RESOURCE_DMA1_HPS	0x1
+#define RESOURCE_DMA2_CLP	0x2
+#define RESOURCE_DMA3_BRS	0x4
+
 /* saa7146 source inputs */
 #define SAA7146_HPS_SOURCE_PORT_A	0x00
 #define SAA7146_HPS_SOURCE_PORT_B	0x01


