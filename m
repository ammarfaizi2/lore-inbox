Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267376AbTAHMAF>; Wed, 8 Jan 2003 07:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267254AbTAHMAF>; Wed, 8 Jan 2003 07:00:05 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:59285 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S267376AbTAHL7Z>; Wed, 8 Jan 2003 06:59:25 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Wed, 8 Jan 2003 13:15:08 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] saa7134 driver update
Message-ID: <20030108121508.GA17551@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch updates the saa7134 driver.  It adds support for a few more
cards and includes adaptions to the video-buf.c changes sent earlier.

Please apply,

  Gerd

--- linux-2.5.54/drivers/media/video/saa7134/saa7134-cards.c	2003-01-08 10:34:58.000000000 +0100
+++ linux/drivers/media/video/saa7134/saa7134-cards.c	2003-01-08 10:59:59.000000000 +0100
@@ -288,6 +288,81 @@
 			.amux = LINE2,
 		},
 	},
+	[SAA7134_BOARD_KWORLD] = {
+                .name           = "Kworld/KuroutoShikou SAA7130-TVPCI",
+		.audio_clock    = 0x00187de7,
+		.tuner_type     = TUNER_PHILIPS_NTSC_M,
+                .inputs         = {{
+                        .name = name_svideo,
+                        .vmux = 8,
+                        .amux = LINE1,
+                },{
+                        .name = name_comp1,
+                        .vmux = 3,
+                        .amux = LINE1,
+                },{
+                        .name = name_tv,
+                        .vmux = 1,
+                        .amux = TV,
+                        .tv   = 1,
+                }},
+        },
+	[SAA7134_BOARD_CINERGY600] = {
+                .name           = "Terratec Cinergy 600 TV",
+                .audio_clock    = 0x00200000,
+                .tuner_type     = TUNER_PHILIPS_PAL,
+                .inputs         = {{
+                        .name = name_tv,
+                        .vmux = 1,
+                        .amux = TV,
+                        .tv   = 1,
+                },{
+                        .name = name_comp1,
+                        .vmux = 4,
+                        .amux = LINE1,
+                },{
+                        .name = name_svideo,
+                        .vmux = 8,
+                        .amux = LINE1,
+                },{
+                        .name = name_comp2, // CVideo over SVideo Connector
+                        .vmux = 0,
+                        .amux = LINE1,
+                }},
+		.radio = {
+			.name = name_radio,
+			.amux = LINE2,
+               },
+
+        },
+	[SAA7134_BOARD_MD7134] = {
+		.name           = "Medion 7134",
+		.audio_clock    = 0x00200000,
+		.tuner_type     = TUNER_PHILIPS_FM1216ME_MK3,
+		.need_tda9887   = 1,
+		.inputs = {{
+			.name   = name_tv,
+			.vmux   = 1,
+			.amux   = LINE2,
+			.tv     =   1,
+		},{
+			.name   = name_comp1,
+			.vmux   = 0,
+			.amux   = LINE2,
+		},{
+			.name   = name_comp2,
+			.vmux   = 3,
+			.amux   = LINE2,
+		},{
+			.name   = name_svideo,
+			.vmux   = 8,
+			.amux   = LINE2,
+		}},
+		.radio = {
+			.name   = name_radio,
+			.amux   = LINE2,
+		},
+      },
 };
 const int saa7134_bcount = (sizeof(saa7134_boards)/sizeof(struct saa7134_board));
 
@@ -320,7 +395,25 @@
                 .subdevice    = 0x1142,
                 .driver_data  = SAA7134_BOARD_CINERGY400,
         },{
-
+                .vendor       = PCI_VENDOR_ID_PHILIPS,
+                .device       = PCI_DEVICE_ID_PHILIPS_SAA7134,
+                .subvendor    = 0x153B,
+                .subdevice    = 0x1143,
+                .driver_data  = SAA7134_BOARD_CINERGY600,
+        },{
+		.vendor       = PCI_VENDOR_ID_PHILIPS,
+		.device       = PCI_DEVICE_ID_PHILIPS_SAA7134,
+		.subvendor    = 0x5168,
+		.subdevice    = 0x0138,
+		.driver_data  = SAA7134_BOARD_FLYVIDEO3000,
+        },{
+		.vendor       = PCI_VENDOR_ID_PHILIPS,
+		.device       = PCI_DEVICE_ID_PHILIPS_SAA7134,
+		.subvendor    = 0x16be,
+		.subdevice    = 0x0003,
+		.driver_data  = SAA7134_BOARD_MD7134,
+	},{
+		
 		/* --- boards without eeprom + subsystem ID --- */
                 .vendor       = PCI_VENDOR_ID_PHILIPS,
                 .device       = PCI_DEVICE_ID_PHILIPS_SAA7134,
--- linux-2.5.54/drivers/media/video/saa7134/saa7134-i2c.c	2003-01-08 10:33:59.000000000 +0100
+++ linux/drivers/media/video/saa7134/saa7134-i2c.c	2003-01-08 10:59:59.000000000 +0100
@@ -318,6 +318,7 @@
 	return I2C_FUNC_SMBUS_EMUL;
 }
 
+
 static int attach_inform(struct i2c_client *client)
 {
         struct saa7134_dev *dev = client->adapter->algo_data;
--- linux-2.5.54/drivers/media/video/saa7134/saa7134-oss.c	2003-01-08 10:34:28.000000000 +0100
+++ linux/drivers/media/video/saa7134/saa7134-oss.c	2003-01-08 10:59:59.000000000 +0100
@@ -102,11 +102,13 @@
 	/* prepare buffer */
 	if (0 != (err = videobuf_dma_pci_map(dev->pci,&dev->oss.dma)))
 		return err;
+	if (0 != (err = saa7134_pgtable_alloc(dev->pci,&dev->oss.pt)))
+		goto fail1;
 	if (0 != (err = saa7134_pgtable_build(dev->pci,&dev->oss.pt,
 					      dev->oss.dma.sglist,
 					      dev->oss.dma.sglen,
 					      0)))
-		goto fail1;
+		goto fail2;
 
 	/* sample format */
 	switch (dev->oss.afmt) {
--- linux-2.5.54/drivers/media/video/saa7134/saa7134-ts.c	2003-01-08 10:33:53.000000000 +0100
+++ linux/drivers/media/video/saa7134/saa7134-ts.c	2003-01-08 10:59:59.000000000 +0100
@@ -52,21 +52,24 @@
 			   struct saa7134_buf *buf,
 			   struct saa7134_buf *next)
 {
-	unsigned long control,status;
-
+	u32 control;
+	
 	dprintk("buffer_activate [%p]\n",buf);
 	buf->vb.state = STATE_ACTIVE;
 	
-	/* dma: setup channel 5 (= TS) */
-	control = SAA7134_RS_CONTROL_BURST_16 |
-		SAA7134_RS_CONTROL_ME |
-		(buf->pt->dma >> 12);
-
-	status = saa_readl(SAA7134_IRQ_STATUS);
-	if (0 == (status & 0x100000)) {
+        /* dma: setup channel 5 (= TS) */
+        control = SAA7134_RS_CONTROL_BURST_16 |
+                SAA7134_RS_CONTROL_ME |
+                (buf->pt->dma >> 12);
+
+	if (NULL == next)
+		next = buf;
+	if (V4L2_FIELD_TOP == buf->vb.field) {
+		dprintk("[top]     buf=%p next=%p",buf,next);
 		saa_writel(SAA7134_RS_BA1(5),saa7134_buffer_base(buf));
 		saa_writel(SAA7134_RS_BA2(5),saa7134_buffer_base(next));
 	} else {
+		dprintk("[bottom]  buf=%p next=%p",buf,next);
 		saa_writel(SAA7134_RS_BA1(5),saa7134_buffer_base(next));
 		saa_writel(SAA7134_RS_BA2(5),saa7134_buffer_base(buf));
 	}
@@ -80,7 +83,8 @@
 	return 0;
 }
 
-static int buffer_prepare(struct file *file, struct videobuf_buffer *vb)
+static int buffer_prepare(struct file *file, struct videobuf_buffer *vb,
+			  enum v4l2_field field)
 {
 	struct saa7134_dev *dev = file->private_data;
 	struct saa7134_buf *buf = (struct saa7134_buf *)vb;
@@ -116,7 +120,7 @@
 	buf->vb.state = STATE_PREPARED;
 	buf->top_seen = 0;
 	buf->activate = buffer_activate;
-	buf->vb.field = V4L2_FIELD_SEQ_TB;
+	buf->vb.field = field;
 	return 0;
 
  oops:
@@ -408,11 +412,13 @@
 		tsbufs = VIDEO_MAX_FRAME;
 
 	INIT_LIST_HEAD(&dev->ts_q.queue);
+	init_timer(&dev->ts_q.timeout);
 	dev->ts_q.timeout.function = saa7134_buffer_timeout;
 	dev->ts_q.timeout.data     = (unsigned long)(&dev->ts_q);
 	dev->ts_q.dev              = dev;
 	videobuf_queue_init(&dev->ts.ts, &ts_qops, dev->pci, &dev->slock,
 			    V4L2_BUF_TYPE_VIDEO_CAPTURE,
+			    V4L2_FIELD_ALTERNATE,
 			    sizeof(struct saa7134_buf));
 	saa7134_pgtable_alloc(dev->pci,&dev->ts.pt_ts);
 
@@ -437,11 +443,23 @@
 
 void saa7134_irq_ts_done(struct saa7134_dev *dev, unsigned long status)
 {
+	enum v4l2_field field;
+
 	spin_lock(&dev->slock);
 	if (dev->ts_q.curr) {
+		field = dev->video_q.curr->vb.field;
+		if (field == V4L2_FIELD_TOP) {
+			if ((status & 0x100000) != 0x100000)
+				goto done;
+		} else {
+			if ((status & 0x100000) != 0x000000)
+				goto done;
+		}
 		saa7134_buffer_finish(dev,&dev->ts_q,STATE_DONE);
 	}
 	saa7134_buffer_next(dev,&dev->ts_q);
+
+ done:
 	spin_unlock(&dev->slock);
 }
 
--- linux-2.5.54/drivers/media/video/saa7134/saa7134-tvaudio.c	2003-01-08 10:33:52.000000000 +0100
+++ linux/drivers/media/video/saa7134/saa7134-tvaudio.c	2003-01-08 10:59:59.000000000 +0100
@@ -26,6 +26,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
+#include <linux/delay.h>
 #include <linux/smp_lock.h>
 #include <asm/div64.h>
 
@@ -119,6 +120,10 @@
 
 	/* init all audio registers */
 	saa_writeb(SAA7134_AUDIO_PLL_CTRL,   0x00);
+	if (need_resched())
+		schedule();
+	else
+		udelay(10);
 		
 	saa_writeb(SAA7134_AUDIO_CLOCK0,      clock        & 0xff);
 	saa_writeb(SAA7134_AUDIO_CLOCK1,     (clock >>  8) & 0xff);
@@ -357,6 +362,7 @@
 	return value;
 }
 
+#if 0
 static void sifdebug_dump_regs(struct saa7134_dev *dev)
 {
 	print_regb(AUDIO_STATUS);
@@ -372,6 +378,7 @@
 	print_regb(SIF_SAMPLE_FREQ);
 	print_regb(ANALOG_IO_SELECT);
 }
+#endif
 
 static int tvaudio_thread(void *data)
 {
@@ -440,9 +447,8 @@
 		}
 		if (0 == carrier) {
 			/* Oops: autoscan didn't work for some reason :-/ */
-			printk("%s/audio: oops: audio carrier scan failed\n",
-			       dev->name);
-			sifdebug_dump_regs(dev);
+			printk(KERN_WARNING "%s/audio: oops: audio carrier "
+			       "scan failed\n", dev->name);
 		} else {
 			dprintk("found %s main sound carrier @ %d.%03d MHz\n",
 				dev->tvnorm->name,
--- linux-2.5.54/drivers/media/video/saa7134/saa7134-vbi.c	2003-01-08 10:35:03.000000000 +0100
+++ linux/drivers/media/video/saa7134/saa7134-vbi.c	2003-01-08 10:59:59.000000000 +0100
@@ -114,7 +114,8 @@
 	return 0;
 }
 
-static int buffer_prepare(struct file *file, struct videobuf_buffer *vb)
+static int buffer_prepare(struct file *file, struct videobuf_buffer *vb,
+			  enum v4l2_field field)
 {
 	struct saa7134_fh *fh   = file->private_data;
 	struct saa7134_dev *dev = fh->dev;
@@ -158,7 +159,7 @@
 	buf->vb.state = STATE_PREPARED;
 	buf->top_seen = 0;
 	buf->activate = buffer_activate;
-	buf->vb.field = V4L2_FIELD_SEQ_TB;
+	buf->vb.field = field;
 	return 0;
 
  oops:
@@ -218,6 +219,7 @@
 int saa7134_vbi_init(struct saa7134_dev *dev)
 {
 	INIT_LIST_HEAD(&dev->vbi_q.queue);
+	init_timer(&dev->vbi_q.timeout);
 	dev->vbi_q.timeout.function = saa7134_buffer_timeout;
 	dev->vbi_q.timeout.data     = (unsigned long)(&dev->vbi_q);
 	dev->vbi_q.dev              = dev;
--- linux-2.5.54/drivers/media/video/saa7134/saa7134-video.c	2003-01-08 10:33:59.000000000 +0100
+++ linux/drivers/media/video/saa7134/saa7134-video.c	2003-01-08 10:59:59.000000000 +0100
@@ -133,10 +133,9 @@
 };
 #define FORMATS (sizeof(formats)/sizeof(struct saa7134_format))
 
-
 static struct saa7134_tvnorm tvnorms[] = {
 	{
-		.name          = "PAL-BGHI",
+		.name          = "PAL",
 		.id            = V4L2_STD_PAL,
 		.width         = 720,
 		.height        = 576,
@@ -154,7 +153,7 @@
 		.vbi_v_start   = 7-3,  /* FIXME */
 		.vbi_v_stop    = 22-3,
 	},{
-		.name          = "NTSC-M",
+		.name          = "NTSC",
 		.id            = V4L2_STD_NTSC,
 		.width         = 720,
 		.height        = 480,
@@ -189,9 +188,10 @@
 		.video_v_stop  = 311,
 		.vbi_v_start   = 7,
 		.vbi_v_stop    = 22,
+#if 0
 	},{
 		.name          = "AUTO",
-		.id            = -1,
+		.id            = V4L2_STD_PAL|V4L2_STD_NTSC|V4L2_STD_SECAM,
 		.width         = 768,
 		.height        = 576,
 
@@ -207,6 +207,7 @@
 		.video_v_stop  = 311,
 		.vbi_v_start   = 7,
 		.vbi_v_stop    = 22,
+#endif
 	}
 };
 #define TVNORMS (sizeof(tvnorms)/sizeof(struct saa7134_tvnorm))
@@ -825,7 +826,8 @@
 	return 0;
 }
 
-static int buffer_prepare(struct file *file, struct videobuf_buffer *vb)
+static int buffer_prepare(struct file *file, struct videobuf_buffer *vb,
+			  enum v4l2_field field)
 {
 	struct saa7134_fh *fh = file->private_data;
 	struct saa7134_dev *dev = fh->dev;
@@ -845,12 +847,12 @@
 		return -EINVAL;
 
 	dprintk("buffer_prepare [size=%dx%d,bytes=%d,fields=%s,%s]\n",
-		fh->width,fh->height,size,v4l2_field_names[fh->field],
+		fh->width,fh->height,size,v4l2_field_names[field],
 		fh->fmt->name);
 	if (buf->vb.width  != fh->width  ||
 	    buf->vb.height != fh->height ||
 	    buf->vb.size   != size       ||
-	    buf->vb.field  != fh->field  ||
+	    buf->vb.field  != field      ||
 	    buf->fmt       != fh->fmt) {
 		saa7134_dma_free(dev,buf);
 	}
@@ -859,8 +861,8 @@
 		buf->vb.width  = fh->width;
 		buf->vb.height = fh->height;
 		buf->vb.size   = size;
+		buf->vb.field  = field;
 		buf->fmt       = fh->fmt;
-		buf->vb.field  = fh->field;
 		buf->pt        = &fh->pt_cap;
 
 		err = videobuf_iolock(dev->pci,&buf->vb);
@@ -1125,6 +1127,7 @@
 	videobuf_queue_init(&fh->cap, &video_qops,
 			    dev->pci, &dev->slock,
 			    V4L2_BUF_TYPE_VIDEO_CAPTURE,
+			    V4L2_FIELD_INTERLACED,
 			    sizeof(struct saa7134_buf));
 	init_MUTEX(&fh->cap.lock);
 	saa7134_pgtable_alloc(dev->pci,&fh->pt_cap);
@@ -1132,6 +1135,7 @@
 	videobuf_queue_init(&fh->vbi, &saa7134_vbi_qops,
 			    dev->pci, &dev->slock,
 			    V4L2_BUF_TYPE_VBI_CAPTURE,
+			    V4L2_FIELD_SEQ_TB,
 			    sizeof(struct saa7134_buf));
         init_MUTEX(&fh->vbi.lock);
 	saa7134_pgtable_alloc(dev->pci,&fh->pt_vbi);
@@ -1155,9 +1159,13 @@
 
 	switch (fh->type) {
 	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
+		if (res_locked(fh->dev,RESOURCE_VIDEO))
+			return -EBUSY;
 		return videobuf_read_one(file, saa7134_queue(fh),
 					 data, count, ppos);
 	case V4L2_BUF_TYPE_VBI_CAPTURE:
+		if (!res_get(fh->dev,fh,RESOURCE_VBI))
+			return -EBUSY;
 		return videobuf_read_stream(file, saa7134_queue(fh),
 					    data, count, ppos, 1);
 		break;
@@ -1187,7 +1195,7 @@
                                 up(&fh->cap.lock);
                                 return POLLERR;
                         }
-                        if (0 != fh->cap.ops->buf_prepare(file,fh->cap.read_buf)) {
+                        if (0 != fh->cap.ops->buf_prepare(file,fh->cap.read_buf,fh->cap.field)) {
                                 up(&fh->cap.lock);
                                 return POLLERR;
                         }
@@ -1214,12 +1222,15 @@
 	struct saa7134_dev *dev = fh->dev;
 	unsigned long flags;
 
+	/* turn off overlay */
 	if (res_check(fh, RESOURCE_OVERLAY)) {
 		spin_lock_irqsave(&dev->slock,flags);
 		stop_preview(dev,fh);
 		spin_unlock_irqrestore(&dev->slock,flags);
 		res_free(dev,fh,RESOURCE_OVERLAY);
 	}
+
+	/* stop video capture */
 	if (res_check(fh, RESOURCE_VIDEO)) {
 		videobuf_queue_cancel(file,&fh->cap);
 		res_free(dev,fh,RESOURCE_VIDEO);
@@ -1228,10 +1239,15 @@
 		buffer_release(file,fh->cap.read_buf);
 		kfree(fh->cap.read_buf);
 	}
-	if (fh->vbi.streaming)
-		videobuf_streamoff(file,&fh->vbi);
-	if (fh->vbi.reading)
-		videobuf_read_stop(file,&fh->vbi);
+
+	/* stop vbi capture */
+	if (res_check(fh, RESOURCE_VBI)) {
+		if (fh->vbi.streaming)
+			videobuf_streamoff(file,&fh->vbi);
+		if (fh->vbi.reading)
+			videobuf_read_stop(file,&fh->vbi);
+		res_free(dev,fh,RESOURCE_VBI);
+	}
 
 	saa7134_pgtable_free(dev->pci,&fh->pt_cap);
 	saa7134_pgtable_free(dev->pci,&fh->pt_vbi);
@@ -1259,6 +1275,7 @@
 		memset(&f->fmt.pix,0,sizeof(f->fmt.pix));
 		f->fmt.pix.width        = fh->width;
 		f->fmt.pix.height       = fh->height;
+		f->fmt.pix.field        = fh->cap.field;
 		f->fmt.pix.pixelformat  = fh->fmt->fourcc;
 		f->fmt.pix.sizeimage    =
 			(fh->width*fh->height*fh->fmt->depth)/8;
@@ -1354,10 +1371,10 @@
 		if (0 != err)
 			return err;
 			
-		fh->fmt    = format_by_fourcc(f->fmt.pix.pixelformat);
-		fh->width  = f->fmt.pix.width;
-		fh->height = f->fmt.pix.height;
-		fh->field  = f->fmt.pix.field;
+		fh->fmt       = format_by_fourcc(f->fmt.pix.pixelformat);
+		fh->width     = f->fmt.pix.width;
+		fh->height    = f->fmt.pix.height;
+		fh->cap.field = f->fmt.pix.field;
 		return 0;
 	case V4L2_BUF_TYPE_VIDEO_OVERLAY:
 		err = verify_preview(dev,&f->fmt.win);
@@ -1429,11 +1446,14 @@
 	case VIDIOC_ENUMSTD:
 	{
 		struct v4l2_standard *e = arg;
+		int i;
 
-		if (e->index < 0 || e->index >= TVNORMS)
+		i = e->index;
+		if (i < 0 || i >= TVNORMS)
 			return -EINVAL;
 		err = v4l2_video_std_construct(e, tvnorms[e->index].id,
 					       tvnorms[e->index].name);
+		e->index = i;
 		if (err < 0)
 			return err;
 		return 0;
@@ -1473,15 +1493,33 @@
 	case VIDIOC_ENUMINPUT:
 	{
 		struct v4l2_input *i = arg;
-		
-		if (i->index >= SAA7134_INPUT_MAX)
+		int n;
+
+		n = i->index;
+		if (n >= SAA7134_INPUT_MAX)
 			return -EINVAL;
 		if (NULL == card_in(dev,i->index).name)
 			return -EINVAL;
-		i->type = V4L2_INPUT_TYPE_CAMERA;
-		strcpy(i->name,card_in(dev,i->index).name);
-		if (card_in(dev,i->index).tv)
+		memset(i,0,sizeof(*i));
+		i->index = n;
+		i->type  = V4L2_INPUT_TYPE_CAMERA;
+		strcpy(i->name,card_in(dev,n).name);
+		if (card_in(dev,n).tv)
 			i->type = V4L2_INPUT_TYPE_TUNER;
+		i->audioset = 1;
+		if (n == dev->ctl_input) {
+			int v1 = saa_readb(SAA7134_STATUS_VIDEO1);
+			int v2 = saa_readb(SAA7134_STATUS_VIDEO2);
+
+			if (0 != (v1 & 0x40))
+				i->status |= V4L2_IN_ST_NO_H_LOCK;
+			if (0 != (v2 & 0x40))
+				i->status |= V4L2_IN_ST_NO_SYNC;
+			if (0 != (v2 & 0x0e))
+				i->status |= V4L2_IN_ST_MACROVISION;
+		}
+		for (n = 0; n < TVNORMS; n++)
+			i->std |= tvnorms[n].id;
 		return 0;
 	}
 	case VIDIOC_G_INPUT:
@@ -1510,6 +1548,8 @@
 		struct v4l2_tuner *t = arg;
 		int n;
 
+		if (0 != t->index)
+			return -EINVAL;
 		memset(t,0,sizeof(*t));
 		for (n = 0; n < SAA7134_INPUT_MAX; n++)
 			if (card_in(dev,n).tv)
@@ -1521,12 +1561,12 @@
 				V4L2_TUNER_CAP_LANG1 |
 				V4L2_TUNER_CAP_LANG2;
 			t->rangehigh = 0xffffffffUL;
-			if (dev->tvaudio) {
+			t->rxsubchans = -1;
+			if (dev->tvaudio)
 				t->rxsubchans = saa7134_tvaudio_getstereo
 					(dev,dev->tvaudio);
-			} else {
+			if (-1 == t->rxsubchans)
 				t->rxsubchans = V4L2_TUNER_SUB_MONO;
-			}
 #if 1
 			/* fill audmode -- FIXME: allow manual switching */
 			t->audmode = V4L2_TUNER_MODE_MONO;
@@ -1618,12 +1658,14 @@
 	case VIDIOC_ENUM_FMT:
 	{
 		struct v4l2_fmtdesc *f = arg;
+		enum v4l2_buf_type type;
 		int index;
 
-		switch (f->type) {
+		index = f->index;
+		type  = f->type;
+		switch (type) {
 		case V4L2_BUF_TYPE_VIDEO_CAPTURE:
 		case V4L2_BUF_TYPE_VIDEO_OVERLAY:
-			index = f->index;
 			if (index < 0 || index >= FORMATS)
 				return -EINVAL;
 			if (f->type == V4L2_BUF_TYPE_VIDEO_OVERLAY &&
@@ -1631,9 +1673,19 @@
 				return -EINVAL;
 			memset(f,0,sizeof(*f));
 			f->index = index;
+			f->type  = type;
 			strncpy(f->description,formats[index].name,31);
 			f->pixelformat = formats[index].fourcc;
 			break;
+		case V4L2_BUF_TYPE_VBI_CAPTURE:
+			if (0 != index)
+				return -EINVAL;
+			memset(f,0,sizeof(*f));
+			f->index = index;
+			f->type  = type;
+			f->pixelformat = V4L2_PIX_FMT_GREY;
+			strcpy(f->description,"vbi data");
+			break;
 		default:
 			return -EINVAL;	
 		}
@@ -1898,8 +1950,8 @@
 struct video_device saa7134_video_template =
 {
 	.name          = "saa7134-video",
-	type:          VID_TYPE_CAPTURE|VID_TYPE_TUNER|VID_TYPE_OVERLAY|
-	               VID_TYPE_CLIPPING|VID_TYPE_SCALES,
+	.type          = VID_TYPE_CAPTURE|VID_TYPE_TUNER|VID_TYPE_OVERLAY|
+	                 VID_TYPE_CLIPPING|VID_TYPE_SCALES,
 	.hardware      = 0,
 	.fops          = &video_fops,
 	.minor         = -1,
@@ -1944,6 +1996,7 @@
 	dev->automute       = 0;
 
         INIT_LIST_HEAD(&dev->video_q.queue);
+	init_timer(&dev->video_q.timeout);
 	dev->video_q.timeout.function = saa7134_buffer_timeout;
 	dev->video_q.timeout.data     = (unsigned long)(&dev->video_q);
 	dev->video_q.dev              = dev;
@@ -1984,7 +2037,7 @@
 	int norm;
 
 	norm = saa_readb(SAA7134_STATUS_VIDEO1) & 0x03;
-	printk("%s/video: DCSDT: %s\n",dev->name,st[norm]);
+	dprintk("DCSDT: %s\n",st[norm]);
 	
 	if (0 != norm) {
 		/* wake up tvaudio audio carrier scan thread */
--- linux-2.5.54/drivers/media/video/saa7134/saa7134.h	2003-01-08 10:34:52.000000000 +0100
+++ linux/drivers/media/video/saa7134/saa7134.h	2003-01-08 10:59:59.000000000 +0100
@@ -117,6 +117,9 @@
 #define SAA7134_BOARD_TVSTATION_RDS     7
 #define SAA7134_BOARD_CINERGY400	8
 #define SAA7134_BOARD_MD5044		9
+#define SAA7134_BOARD_KWORLD           10
+#define SAA7134_BOARD_CINERGY600       11
+#define SAA7134_BOARD_MD7134           12
 
 #define SAA7134_INPUT_MAX 8
 
@@ -159,7 +162,7 @@
 
 #define RESOURCE_OVERLAY       1
 #define RESOURCE_VIDEO         2
-#define RESOURCE_VBI           3
+#define RESOURCE_VBI           4
 
 #define INTERLACE_AUTO         0
 #define INTERLACE_ON           1
@@ -224,7 +227,6 @@
 	/* video capture */
 	struct saa7134_format      *fmt;
 	int                        width,height;
-	enum v4l2_field            field;
 	struct videobuf_queue      cap;
 	struct saa7134_pgtable     pt_cap;
 

-- 
Weil die späten Diskussionen nicht mal mehr den Rotwein lohnen.
				-- Wacholder in "Melanie"
