Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbTJHNii (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 09:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbTJHNiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 09:38:03 -0400
Received: from mail.convergence.de ([212.84.236.4]:6625 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S261522AbTJHN2z convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 09:28:55 -0400
Subject: [PATCH 4/14] video capture updates for saa7146 core
In-Reply-To: <1065619728592@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Wed, 8 Oct 2003 15:28:53 +0200
Message-Id: <1065619733417@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Michael Hunold (LinuxTV.org CVS maintainer) <hunold@linuxtv.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- [DVB] some Kconfig simplifications
- [DVB] FIELD_ALTERNATE capture was broken, add a "wait for vbi" command before actually waiting for the field change
- [DVB] improvements regarding streaming capture to gfx card memory.
- [DVB] captured frames could only be page aligned. fixed.
- [DVB] fix pgtable_build_single, it should work for all kinds of buffers now (system memory (kernel/user) and gfx-memory)
- [DVB] Fix bytesperline-calculation for V4L2_FIELD_ALTERNATE vs. V4L2_FIELD_INTERLACED capture
diff -uNrwB --new-file xx-linux-2.6.0-test5/drivers/media/common/Kconfig linux-2.6.0-test5/drivers/media/common/Kconfig
--- xx-linux-2.6.0-test5/drivers/media/common/Kconfig	2003-09-10 11:28:54.000000000 +0200
+++ linux-2.6.0-test5/drivers/media/common/Kconfig	2003-07-29 12:01:11.000000000 +0200
@@ -1,11 +1,8 @@
 config VIDEO_SAA7146
-        tristate
-        default y if DVB_AV7110=y || DVB_BUDGET=y || DVB_BUDGET_AV=y || VIDEO_MXB=y || VIDEO_DPC=y || VIDEO_HEXIUM_ORION=y || VIDEO_HEXIUM_GEMINI=y
-        default m if DVB_AV7110=m || DVB_BUDGET=m || DVB_BUDGET_AV=m || VIDEO_MXB=m || VIDEO_DPC=m || VIDEO_HEXIUM_ORION=m || VIDEO_HEXIUM_GEMINI=m
+	def_tristate DVB_AV7110 || DVB_BUDGET || DVB_BUDGET_AV || \
+		     VIDEO_MXB || VIDEO_DPC || VIDEO_HEXIUM_ORION || \
+		     VIDEO_HEXIUM_GEMINI
         depends on VIDEO_DEV && PCI && I2C
-
 config VIDEO_VIDEOBUF
-        tristate
-        default y if VIDEO_SAA7134=y || VIDEO_BT848=y || VIDEO_SAA7146=y
-        default m if VIDEO_SAA7134=m || VIDEO_BT848=m || VIDEO_SAA7146=m
+	def_tristate VIDEO_SAA7134 || VIDEO_BT848 || VIDEO_SAA7146
         depends on VIDEO_DEV
diff -uNrwB --new-file xx-linux-2.6.0-test5/drivers/media/common/saa7146_core.c linux-2.6.0-test5/drivers/media/common/saa7146_core.c
--- xx-linux-2.6.0-test5/drivers/media/common/saa7146_core.c	2003-09-10 11:28:41.000000000 +0200
+++ linux-2.6.0-test5/drivers/media/common/saa7146_core.c	2003-08-21 15:13:41.000000000 +0200
@@ -139,34 +139,42 @@
 	return 0;
 }
 
-void saa7146_pgtable_build_single(struct pci_dev *pci, struct saa7146_pgtable *pt, struct scatterlist *list, int length )
+void saa7146_pgtable_build_single(struct pci_dev *pci, struct saa7146_pgtable *pt,
+	struct scatterlist *list, int sglen  )
 {
 	u32   *ptr, fill;
+	int nr_pages = 0;
 	int   i,p;
 
-//fm	DEB_EE(("pci:%p, pt:%p, sl:%p, len:%d\n",pci,pt,list,length));
+	BUG_ON( 0 == sglen);
 
 	/* if we have a user buffer, the first page may not be
 	   aligned to a page boundary. */
 	pt->offset = list->offset;
 
 	ptr = pt->cpu;
-	for (i = 0; i < length; i++, list++) {
+	for (i = 0; i < sglen; i++, list++) {
+/*
+		printk("i:%d, adr:0x%08x, len:%d, offset:%d\n", i,sg_dma_address(list), sg_dma_len(list), list->offset);
+*/
 		for (p = 0; p * 4096 < list->length; p++, ptr++) {
-			*ptr = sg_dma_address(list) - list->offset;
+			*ptr = sg_dma_address(list) + p * 4096;
+			nr_pages++;
 		}
 	}
 
 
 	/* safety; fill the page table up with the last valid page */
 	fill = *(ptr-1);
-	for(;i<1024;i++) {
+	for(i=nr_pages;i<1024;i++) {
 		*ptr++ = fill;
 	}
+
 /*
 	ptr = pt->cpu;
-	for(j=0;j<60;j++) {
-		printk("ptr1 %d: 0x%08x\n",j,ptr[j]);
+	printk("offset: %d\n",pt->offset);
+	for(i=0;i<5;i++) {
+		printk("ptr1 %d: 0x%08x\n",i,ptr[i]);
 	}
 */
 }
diff -uNrwB --new-file xx-linux-2.6.0-test5/drivers/media/common/saa7146_fops.c linux-2.6.0-test5/drivers/media/common/saa7146_fops.c
--- xx-linux-2.6.0-test5/drivers/media/common/saa7146_fops.c	2003-09-10 11:29:20.000000000 +0200
+++ linux-2.6.0-test5/drivers/media/common/saa7146_fops.c	2003-07-31 14:25:06.000000000 +0200
@@ -304,6 +304,7 @@
 			return videobuf_poll_stream(file, &fh->vbi_q, wait);
 		q = &fh->vbi_q;
 	} else {
+		DEB_D(("using video queue.\n"));
 		q = &fh->video_q;
 	}
 
@@ -311,14 +312,17 @@
 		buf = list_entry(q->stream.next, struct videobuf_buffer, stream);
 
 	if (!buf) {
+		DEB_D(("buf == NULL!\n"));
 		return POLLERR;
 	}
 
 	poll_wait(file, &buf->done, wait);
 	if (buf->state == STATE_DONE || buf->state == STATE_ERROR) {
+		DEB_D(("poll succeeded!\n"));
 		return POLLIN|POLLRDNORM;
 	}
 
+	DEB_D(("nothing to poll for, buf->state:%d\n",buf->state));
 	return 0;
 }
 
diff -uNrwB --new-file xx-linux-2.6.0-test5/drivers/media/common/saa7146_hlp.c linux-2.6.0-test5/drivers/media/common/saa7146_hlp.c
--- xx-linux-2.6.0-test5/drivers/media/common/saa7146_hlp.c	2003-09-10 11:28:41.000000000 +0200
+++ linux-2.6.0-test5/drivers/media/common/saa7146_hlp.c	2003-08-11 13:13:10.000000000 +0200
@@ -742,6 +742,7 @@
 
 	int width = buf->fmt->width;
 	int height = buf->fmt->height;
+	int bytesperline = buf->fmt->bytesperline;
 	enum v4l2_field field = buf->fmt->field;
 
 	int depth = sfmt->depth;
@@ -749,7 +750,11 @@
 	DEB_CAP(("[size=%dx%d,fields=%s]\n",
 		width,height,v4l2_field_names[field]));
 
+	if( bytesperline != 0) {
+		vdma1.pitch = bytesperline*2;
+	} else {
 	vdma1.pitch		= (width*depth*2)/8;
+	}
 	vdma1.num_line_byte	= ((vv->standard->v_field<<16) + vv->standard->h_pixels);
 	vdma1.base_page		= buf->pt[0].dma | ME1;
 	
@@ -799,6 +804,8 @@
 	vdma2->pitch	= width;
 	vdma3->pitch	= width;
 
+	/* fixme: look at bytesperline! */
+
 	if( 0 != vv->vflip ) {
 		vdma2->prot_addr	= buf->pt[1].offset;
 		vdma2->base_even	= ((vdma2->pitch/2)*height)+buf->pt[1].offset;
@@ -871,6 +878,8 @@
 	DEB_CAP(("[size=%dx%d,fields=%s]\n",
 		width,height,v4l2_field_names[field]));
 
+	/* fixme: look at bytesperline! */
+
 	/* fixme: what happens for user space buffers here?. The offsets are
 	   most likely wrong, this version here only works for page-aligned
 	   buffers, modifications to the pagetable-functions are necessary...*/
@@ -997,8 +1006,10 @@
 		WRITE_RPS0(CMD_PAUSE | o_wait);
 	WRITE_RPS0(CMD_PAUSE | e_wait);
 	} else if ( vv->last_field == V4L2_FIELD_TOP ) {
+		WRITE_RPS0(CMD_PAUSE | (vv->current_hps_sync == SAA7146_HPS_SYNC_PORT_A ? MASK_10 : MASK_09));
 	WRITE_RPS0(CMD_PAUSE | o_wait);
 	} else if ( vv->last_field == V4L2_FIELD_BOTTOM ) {
+		WRITE_RPS0(CMD_PAUSE | (vv->current_hps_sync == SAA7146_HPS_SYNC_PORT_A ? MASK_10 : MASK_09));
 		WRITE_RPS0(CMD_PAUSE | e_wait);
 	}
 
@@ -1033,16 +1044,6 @@
 
 	DEB_CAP(("buf:%p, next:%p\n",buf,next));
 
-/*
-	printk("vdma%d.base_even:     0x%08x\n", 1,saa7146_read(dev,BASE_EVEN1));
-	printk("vdma%d.base_odd:      0x%08x\n", 1,saa7146_read(dev,BASE_ODD1));
-	printk("vdma%d.prot_addr:     0x%08x\n", 1,saa7146_read(dev,PROT_ADDR1));
-	printk("vdma%d.base_page:     0x%08x\n", 1,saa7146_read(dev,BASE_PAGE1));
-	printk("vdma%d.pitch:         0x%08x\n", 1,saa7146_read(dev,PITCH1));
-	printk("vdma%d.num_line_byte: 0x%08x\n", 1,saa7146_read(dev,NUM_LINE_BYTE1));
-	printk("vdma%d => vptr      : 0x%08x\n", 1,saa7146_read(dev,PCI_VDP1));
-*/
-
 	vdma1_prot_addr = saa7146_read(dev, PROT_ADDR1);
 	if( 0 == vdma1_prot_addr ) {
 		/* clear out beginning of streaming bit (rps register 0)*/
@@ -1069,6 +1070,16 @@
 		program_capture_engine(dev,0);
 	}
 
+/*
+	printk("vdma%d.base_even:     0x%08x\n", 1,saa7146_read(dev,BASE_EVEN1));
+	printk("vdma%d.base_odd:      0x%08x\n", 1,saa7146_read(dev,BASE_ODD1));
+	printk("vdma%d.prot_addr:     0x%08x\n", 1,saa7146_read(dev,PROT_ADDR1));
+	printk("vdma%d.base_page:     0x%08x\n", 1,saa7146_read(dev,BASE_PAGE1));
+	printk("vdma%d.pitch:         0x%08x\n", 1,saa7146_read(dev,PITCH1));
+	printk("vdma%d.num_line_byte: 0x%08x\n", 1,saa7146_read(dev,NUM_LINE_BYTE1));
+	printk("vdma%d => vptr      : 0x%08x\n", 1,saa7146_read(dev,PCI_VDP1));
+*/
+
 	/* write the address of the rps-program */
 	saa7146_write(dev, RPS_ADDR0, dev->d_rps0.dma_handle);
 
diff -uNrwB --new-file xx-linux-2.6.0-test5/drivers/media/common/saa7146_video.c linux-2.6.0-test5/drivers/media/common/saa7146_video.c
--- xx-linux-2.6.0-test5/drivers/media/common/saa7146_video.c	2003-09-10 11:29:20.000000000 +0200
+++ linux-2.6.0-test5/drivers/media/common/saa7146_video.c	2003-08-26 22:30:46.000000000 +0200
@@ -169,6 +169,7 @@
 		struct saa7146_format *fmt;
 		enum v4l2_field field;
 		int maxw, maxh;
+		int calc_bpl;
 
 		DEB_EE(("V4L2_BUF_TYPE_VIDEO_CAPTURE: dev:%p, fh:%p\n",dev,fh));
 
@@ -211,8 +212,18 @@
 			f->fmt.pix.width = maxw;
 		if (f->fmt.pix.height > maxh)
 			f->fmt.pix.height = maxh;
-		f->fmt.pix.sizeimage =
-			(f->fmt.pix.width * f->fmt.pix.height * fmt->depth)/8;
+
+		calc_bpl = (f->fmt.pix.width * fmt->depth)/8;
+
+		if (f->fmt.pix.bytesperline < calc_bpl)
+			f->fmt.pix.bytesperline = calc_bpl;
+			
+		if (f->fmt.pix.bytesperline > (2*PAGE_SIZE * fmt->depth)/8) /* arbitrary constraint */
+			f->fmt.pix.bytesperline = calc_bpl;
+			
+		f->fmt.pix.sizeimage = f->fmt.pix.bytesperline * f->fmt.pix.height;
+		DEB_D(("w:%d, h:%d, bytesperline:%d, sizeimage:%d\n",f->fmt.pix.width,f->fmt.pix.height,f->fmt.pix.bytesperline,f->fmt.pix.sizeimage));
+
 		return 0;
 	}
 	case V4L2_BUF_TYPE_VIDEO_OVERLAY:
@@ -359,41 +370,41 @@
 
 static struct v4l2_queryctrl controls[] = {
 	{
-		.id            = V4L2_CID_BRIGHTNESS,
-		.name          = "Brightness",
-		.minimum       = 0,
-		.maximum       = 255,
-		.step          = 1,
-		.default_value = 128,
-		.type          = V4L2_CTRL_TYPE_INTEGER,
+		id:            V4L2_CID_BRIGHTNESS,
+		name:          "Brightness",
+		minimum:       0,
+		maximum:       255,
+		step:          1,
+		default_value: 128,
+		type:          V4L2_CTRL_TYPE_INTEGER,
 	},{
-		.id            = V4L2_CID_CONTRAST,
-		.name          = "Contrast",
-		.minimum       = 0,
-		.maximum       = 127,
-		.step          = 1,
-		.default_value = 64,
-		.type          = V4L2_CTRL_TYPE_INTEGER,
+		id:            V4L2_CID_CONTRAST,
+		name:          "Contrast",
+		minimum:       0,
+		maximum:       127,
+		step:          1,
+		default_value: 64,
+		type:          V4L2_CTRL_TYPE_INTEGER,
 	},{
-		.id            = V4L2_CID_SATURATION,
-		.name          = "Saturation",
-		.minimum       = 0,
-		.maximum       = 127,
-		.step          = 1,
-		.default_value = 64,
-		.type          = V4L2_CTRL_TYPE_INTEGER,
+		id:            V4L2_CID_SATURATION,
+		name:          "Saturation",
+		minimum:       0,
+		maximum:       127,
+		step:          1,
+		default_value: 64,
+		type:          V4L2_CTRL_TYPE_INTEGER,
 	},{
-		.id            = V4L2_CID_VFLIP,
-		.name          = "Vertical flip",
-		.minimum       = 0,
-		.maximum       = 1,
-		.type          = V4L2_CTRL_TYPE_BOOLEAN,
+		id:            V4L2_CID_VFLIP,
+		name:          "Vertical flip",
+		minimum:       0,
+		maximum:       1,
+		type:          V4L2_CTRL_TYPE_BOOLEAN,
 	},{
-		.id            = V4L2_CID_HFLIP,
-		.name          = "Horizontal flip",
-		.minimum       = 0,
-		.maximum       = 1,
-		.type          = V4L2_CTRL_TYPE_BOOLEAN,
+		id:            V4L2_CID_HFLIP,
+		name:          "Horizontal flip",
+		minimum:       0,
+		maximum:       1,
+		type:          V4L2_CTRL_TYPE_BOOLEAN,
 	},
 };
 static int NUM_CONTROLS = sizeof(controls)/sizeof(struct v4l2_queryctrl);
@@ -549,7 +560,7 @@
 	int length = buf->vb.dma.sglen;
 	struct saa7146_format *sfmt = format_by_fourcc(dev,buf->fmt->pixelformat);
 
-	DEB_EE(("dev:%p, buf:%p\n",dev,buf));
+	DEB_EE(("dev:%p, buf:%p, sg_len:%d\n",dev,buf,length));
 
 	if( 0 != IS_PLANAR(sfmt->trans)) {
 		struct saa7146_pgtable *pt1 = &buf->pt[0];
@@ -729,6 +740,81 @@
 	return 0;
 }
 
+/* capturing to framebuffer */
+
+int overlay_reqbufs(struct saa7146_dev *dev, struct v4l2_requestbuffers *req)
+{
+/*	struct saa7146_fh *fh = file->private_data;
+
+	if (req->count > VIDEO_MAX_FRAME)
+		req->count = VIDEO_MAX_FRAME;
+
+	*size = fh->video_fmt.sizeimage;
+
+*/
+	return 0;
+}
+int overlay_querybuf(struct saa7146_dev *dev, struct v4l2_buffer *buf)
+{
+	return 0;
+}
+int overlay_qbuf(struct saa7146_dev *dev, struct v4l2_buffer *b)
+{
+/*	if (b->index < 0 || b->index >= VIDEO_MAX_FRAME) {
+		DEB_D(("index %d out of bounds.\n",b->index));
+		goto -EINVAL;
+	}
+	
+	buf = q->bufs[b->index];
+	if (NULL == buf) {
+		printk("videobuf_qbuf: NULL == buf\n");
+		goto done;
+	}
+	if (0 == buf->baddr) {
+		printk("videobuf_qbuf: 0 == buf->baddr\n");
+		goto done;
+	}
+	if (buf->state == STATE_QUEUED ||
+	    buf->state == STATE_ACTIVE) {
+		printk("videobuf_qbuf: already queued or activated.\n");
+		goto done;
+	}
+
+	field = videobuf_next_field(q);
+	retval = q->ops->buf_prepare(file,buf,field);
+	if (0 != retval) {
+		printk("videobuf_qbuf: buf_prepare() failed.\n");
+		goto done;
+	}
+	
+	list_add_tail(&buf->stream,&q->stream);
+	if (q->streaming) {
+		spin_lock_irqsave(q->irqlock,flags);
+		q->ops->buf_queue(file,buf);
+		spin_unlock_irqrestore(q->irqlock,flags);
+	}
+	retval = 0;
+	
+ done:
+	up(&q->lock);
+	return retval;
+*/
+	return 0;
+}
+int overlay_dqbuf(struct saa7146_dev *dev, struct v4l2_buffer *buf)
+{
+	return 0;
+}
+int overlay_streamon(struct saa7146_dev *dev)
+{
+	return 0;
+}
+int overlay_streamoff(struct saa7146_dev *dev)
+{
+	return 0;
+}
+
+
 /*
  * This function is _not_ called directly, but from
  * video_generic_ioctl (and maybe others).  userspace
@@ -794,7 +880,7 @@
 		
                 strcpy(cap->driver, "saa7146 v4l2");
 		strlcpy(cap->card, dev->ext->name, sizeof(cap->card));
-		sprintf(cap->bus_info,"PCI:%s",pci_name(dev->pci));
+		sprintf(cap->bus_info,"PCI:%s",dev->pci->slot_name);
 		cap->version = SAA7146_VERSION_CODE;
 		cap->capabilities =
 			V4L2_CAP_VIDEO_CAPTURE |
@@ -884,8 +970,11 @@
 			
 		ctrl = ctrl_by_id(c->id);
 		if( NULL == ctrl ) {
+			return -EINVAL;
+/*
 			c->flags = V4L2_CTRL_FLAG_DISABLED;	
 			return 0;
+*/
 		}
 
 		DEB_EE(("VIDIOC_QUERYCTRL: id:%d\n",c->id));
@@ -1037,44 +1126,71 @@
 		return err;
 	}
 	case VIDIOC_REQBUFS: {
-		DEB_D(("VIDIOC_REQBUFS \n"));
-		return videobuf_reqbufs(file,q,arg);
+		struct v4l2_requestbuffers *req = arg;
+		DEB_D(("VIDIOC_REQBUFS, type:%d\n",req->type));
+/*
+		if( req->type == V4L2_BUF_TYPE_VIDEO_OVERLAY ) {
+			return overlay_reqbufs(dev,req);
+		} 
+*/
+		return videobuf_reqbufs(file,q,req);
 	}
 	case VIDIOC_QUERYBUF: {
-		DEB_D(("VIDIOC_QUERYBUF \n"));
-		return videobuf_querybuf(q,arg);
+		struct v4l2_buffer *buf = arg;
+		DEB_D(("VIDIOC_QUERYBUF, type:%d, offset:%d\n",buf->type,buf->m.offset));
+/* 		if( buf->type == V4L2_BUF_TYPE_VIDEO_OVERLAY ) {
+			return overlay_querybuf(dev,buf);
+		} 
+ */		return videobuf_querybuf(q,buf);
 	}
 	case VIDIOC_QBUF: {
-		struct v4l2_buffer *b = arg;
+		struct v4l2_buffer *buf = arg;
 		int ret = 0;
-		ret = videobuf_qbuf(file,q,b);
-		DEB_D(("VIDIOC_QBUF: ret:%d, index:%d\n",ret,b->index));
+/* 		if( buf->type == V4L2_BUF_TYPE_VIDEO_OVERLAY ) {
+			return overlay_qbuf(dev,buf);
+		} 
+ */		ret = videobuf_qbuf(file,q,buf);
+		DEB_D(("VIDIOC_QBUF: ret:%d, index:%d\n",ret,buf->index));
 		return ret;
 	}
 	case VIDIOC_DQBUF: {
-		struct v4l2_buffer *b = arg;
+		struct v4l2_buffer *buf = arg;
 		int ret = 0;
-		ret = videobuf_dqbuf(file,q,b);
-		DEB_D(("VIDIOC_DQBUF: ret:%d, index:%d\n",ret,b->index));
+/* 		if( buf->type == V4L2_BUF_TYPE_VIDEO_OVERLAY ) {
+			return overlay_dqbuf(dev,buf);
+		} 
+ */		ret = videobuf_dqbuf(file,q,buf);
+		DEB_D(("VIDIOC_DQBUF: ret:%d, index:%d\n",ret,buf->index));
 		return ret;
 	}
 	case VIDIOC_STREAMON: {
-		DEB_D(("VIDIOC_STREAMON \n"));
+		int *type = arg;
+		DEB_D(("VIDIOC_STREAMON, type:%d\n",*type));
+
 		if( 0 != ops->capture_begin ) {
 			if( 0 != (err = ops->capture_begin(fh))) {
 				return err;
 			}
 		}
+/* 		if( *type == V4L2_BUF_TYPE_VIDEO_OVERLAY ) {
+			err = overlay_streamon(dev);
+		} else { */
 		err = videobuf_streamon(file,q);
+/* 		} */
 		return err;
 	}
 	case VIDIOC_STREAMOFF: {
-		DEB_D(("VIDIOC_STREAMOFF \n"));
+		int *type = arg;
+
+		DEB_D(("VIDIOC_STREAMOFF, type:%d\n",*type));
 		if( 0 != ops->capture_end ) {
 			ops->capture_end(fh);
 		}
-		err = videobuf_streamoff(file,q);
-		return 0;
+/* 		if( *type == V4L2_BUF_TYPE_VIDEO_OVERLAY ) {
+			return overlay_streamoff(dev);
+		} 
+ */		err = videobuf_streamoff(file,q);
+		return err;
 	}
 	case VIDIOCGMBUF:
 	{
@@ -1134,6 +1250,8 @@
 	struct saa7146_buf *buf = (struct saa7146_buf *)vb;
 	int size,err = 0;
 
+	DEB_CAP(("vbuf:%p\n",vb));
+
 	/* sanity checks */
 	if (fh->video_fmt.width  < 64 ||
 	    fh->video_fmt.height < 64 ||
@@ -1152,6 +1270,7 @@
 	DEB_CAP(("buffer_prepare [size=%dx%d,bytes=%d,fields=%s]\n",
 		fh->video_fmt.width,fh->video_fmt.height,size,v4l2_field_names[fh->video_fmt.field]));
 	if (buf->vb.width  != fh->video_fmt.width  ||
+	    buf->vb.bytesperline != fh->video_fmt.bytesperline ||
 	    buf->vb.height != fh->video_fmt.height ||
 	    buf->vb.size   != size ||
 	    buf->vb.field  != field      ||
@@ -1163,6 +1282,7 @@
 	if (STATE_NEEDS_INIT == buf->vb.state) {
 		struct saa7146_format *sfmt;
 		
+		buf->vb.bytesperline  = fh->video_fmt.bytesperline;
 		buf->vb.width  = fh->video_fmt.width;
 		buf->vb.height = fh->video_fmt.height;
 		buf->vb.size   = size;
@@ -1280,6 +1400,7 @@
 	fh->video_fmt.width = 384;
 	fh->video_fmt.height = 288;
 	fh->video_fmt.pixelformat = V4L2_PIX_FMT_BGR24;
+	fh->video_fmt.bytesperline = 0;
 	fh->video_fmt.field = V4L2_FIELD_ANY;
 	sfmt = format_by_fourcc(dev,fh->video_fmt.pixelformat);
 	fh->video_fmt.sizeimage = (fh->video_fmt.width * fh->video_fmt.height * sfmt->depth)/8;

