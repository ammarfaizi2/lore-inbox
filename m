Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268831AbUIQO1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268831AbUIQO1E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 10:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268824AbUIQO0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 10:26:51 -0400
Received: from mail.convergence.de ([212.227.36.84]:31134 "EHLO
	email.convergence2.de") by vger.kernel.org with ESMTP
	id S268800AbUIQOXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 10:23:14 -0400
Message-ID: <414AF31B.1090103@linuxtv.org>
Date: Fri, 17 Sep 2004 16:22:19 +0200
From: Michael Hunold <hunold@linuxtv.org>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Hunold <hunold@linuxtv.org>
CC: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH][2.6][1/14] update saa7146 driver
References: <414AF2CA.3000502@linuxtv.org>
In-Reply-To: <414AF2CA.3000502@linuxtv.org>
Content-Type: multipart/mixed;
 boundary="------------040208010507090000030707"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040208010507090000030707
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------040208010507090000030707
Content-Type: text/plain;
 name="01-DVB-update-saa7146.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="01-DVB-update-saa7146.diff"

- [DVB] uses msleep() instead of my_wait(), thanks to Kernel Janitors/Nishanth Aravamudan <nacc@us.ibm.com>
- [DVB] fix videodev has no release callback
- [DVB] use PAGE_SIZE for pagetables, not home-brewn SAA7146_PGTABLE_SIZE
- [DVB] use cpu_to_le32() at various places for endianess independency
- [DVB] turn some error checks into BUG()s
- [DVB] make saa7146_i2c_adapter_prepare() support an adapter class
- [DVB] add support for V4L2_PIX_FMT_RGB32 pixelformat
- [DVB] replace generic saa7146 i2c name by card specific name, suggested by Uli Luckas <luckas@musoft.de>

Signed-off-by: Michael Hunold <hunold@linuxtv.org>

diff -uraNwB xx-linux-2.6.8.1/drivers/media/common/saa7146_core.c linux-2.6.8.1-patched/drivers/media/common/saa7146_core.c
--- xx-linux-2.6.8.1/drivers/media/common/saa7146_core.c	2004-07-19 19:40:04.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/common/saa7146_core.c	2004-04-28 18:31:39.000000000 +0200
@@ -133,8 +133,6 @@
 /********************************************************************************/
 /* common page table functions */
 
-#define SAA7146_PGTABLE_SIZE 4096
-
 char *saa7146_vmalloc_build_pgtable(struct pci_dev *pci, long length, struct saa7146_pgtable *pt)
 {
 	int pages = (length+PAGE_SIZE-1)/PAGE_SIZE;
@@ -182,11 +180,11 @@
         u32          *cpu;
         dma_addr_t   dma_addr;
 
-	cpu = pci_alloc_consistent(pci, SAA7146_PGTABLE_SIZE, &dma_addr);
+	cpu = pci_alloc_consistent(pci, PAGE_SIZE, &dma_addr);
 	if (NULL == cpu) {
 		return -ENOMEM;
 	}
-	pt->size = SAA7146_PGTABLE_SIZE;
+	pt->size = PAGE_SIZE;
 	pt->cpu  = cpu;
 	pt->dma  = dma_addr;
 
@@ -201,11 +199,7 @@
 	int   i,p;
 
 	BUG_ON( 0 == sglen);
-
-	if (list->offset > PAGE_SIZE) {
-		DEB_D(("offset > PAGE_SIZE. this should not happen."));
-		return -EINVAL;
-	}
+	BUG_ON(list->offset > PAGE_SIZE);
 	
 	/* if we have a user buffer, the first page may not be
 	   aligned to a page boundary. */
@@ -217,7 +211,7 @@
 		printk("i:%d, adr:0x%08x, len:%d, offset:%d\n", i,sg_dma_address(list), sg_dma_len(list), list->offset);
 */
 		for (p = 0; p * 4096 < list->length; p++, ptr++) {
-			*ptr = sg_dma_address(list) + p * 4096;
+			*ptr = cpu_to_le32(sg_dma_address(list) + p * 4096);
 			nr_pages++;
 		}
 	}
diff -uraNwB xx-linux-2.6.8.1/drivers/media/common/saa7146_fops.c linux-2.6.8.1-patched/drivers/media/common/saa7146_fops.c
--- xx-linux-2.6.8.1/drivers/media/common/saa7146_fops.c	2004-08-23 09:34:58.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/common/saa7146_fops.c	2004-07-31 02:05:45.000000000 +0200
@@ -88,10 +88,7 @@
 #endif
 	DEB_EE(("dev:%p, dmaq:%p, buf:%p\n", dev, q, buf));
 
-	if( NULL == q ) {
-		ERR(("internal error: fatal NULL pointer for q.\n"));
-		return 0;
-	}
+	BUG_ON(!q);
 
 	if (NULL == q->curr) {
 		q->curr = buf;
@@ -112,14 +109,11 @@
 #ifdef DEBUG_SPINLOCKS
 	BUG_ON(!spin_is_locked(&dev->slock));
 #endif
-	if( NULL == q->curr ) {
-		ERR(("internal error: fatal NULL pointer for q->curr.\n"));
-		return;
-	}
-
 	DEB_EE(("dev:%p, dmaq:%p, state:%d\n", dev, q, state));
 	DEB_EE(("q->curr:%p\n",q->curr));
 
+	BUG_ON(!q->curr);
+
 	/* finish current buffer */
 	if (NULL == q->curr) {
 		DEB_D(("aiii. no current buffer\n"));
@@ -138,10 +132,7 @@
 {
 	struct saa7146_buf *buf,*next = NULL;
 
-	if( NULL == q ) {
-		ERR(("internal error: fatal NULL pointer for q.\n"));
-		return;
-	}
+	BUG_ON(!q);
 
 	DEB_INT(("dev:%p, dmaq:%p, vbi:%d\n", dev, q, vbi));
 
@@ -515,45 +506,58 @@
 	return 0;
 }
 
-int saa7146_register_device(struct video_device *vid, struct saa7146_dev* dev, char *name, int type)
+int saa7146_register_device(struct video_device **vid, struct saa7146_dev* dev,
+			    char *name, int type)
 {
 	struct saa7146_vv *vv = dev->vv_data;
+	struct video_device *vfd;
 
 	DEB_EE(("dev:%p, name:'%s', type:%d\n",dev,name,type));
  
- 	*vid = device_template;
-	strlcpy(vid->name, name, sizeof(vid->name));
-	vid->priv = dev;
+	// released by vfd->release
+ 	vfd = video_device_alloc();
+	if (vfd == NULL)
+		return -ENOMEM;
+
+	memcpy(vfd, &device_template, sizeof(struct video_device));
+	strlcpy(vfd->name, name, sizeof(vfd->name));
+	vfd->release = video_device_release;
+	vfd->priv = dev;
 
 	// fixme: -1 should be an insmod parameter *for the extension* (like "video_nr");
-	if (video_register_device(vid,type,-1) < 0) {
+	if (video_register_device(vfd, type, -1) < 0) {
 		ERR(("cannot register v4l2 device. skipping.\n"));
 		return -1;
 	}
 
 	if( VFL_TYPE_GRABBER == type ) {
-		vv->video_minor = vid->minor;
-		INFO(("%s: registered device video%d [v4l2]\n", dev->name,vid->minor & 0x1f));
+		vv->video_minor = vfd->minor;
+		INFO(("%s: registered device video%d [v4l2]\n",
+			dev->name, vfd->minor & 0x1f));
 	} else {
-		vv->vbi_minor = vid->minor;
-		INFO(("%s: registered device vbi%d [v4l2]\n", dev->name,vid->minor & 0x1f));
+		vv->vbi_minor = vfd->minor;
+		INFO(("%s: registered device vbi%d [v4l2]\n",
+			dev->name, vfd->minor & 0x1f));
 	}
 
+	*vid = vfd;
 	return 0;
 }
 
-int saa7146_unregister_device(struct video_device *vid, struct saa7146_dev* dev)
+int saa7146_unregister_device(struct video_device **vid, struct saa7146_dev* dev)
 {
 	struct saa7146_vv *vv = dev->vv_data;
 	
 	DEB_EE(("dev:%p\n",dev));
 
-	if( VFL_TYPE_GRABBER == vid->type ) {
+	if( VFL_TYPE_GRABBER == (*vid)->type ) {
 		vv->video_minor = -1;
 	} else {
 		vv->vbi_minor = -1;
 	}
-	video_unregister_device(vid);
+
+	video_unregister_device(*vid);
+	*vid = NULL;
 
 	return 0;
 }
diff -uraNwB xx-linux-2.6.8.1/drivers/media/common/saa7146_hlp.c linux-2.6.8.1-patched/drivers/media/common/saa7146_hlp.c
--- xx-linux-2.6.8.1/drivers/media/common/saa7146_hlp.c	2004-07-19 19:40:04.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/common/saa7146_hlp.c	2004-04-28 18:31:39.000000000 +0200
@@ -413,10 +413,10 @@
 
 	/* fill up cliptable */
 	for(i = 0; i < cnt_pixel; i++) {
-		clipping[2*i] |= (pixel_list[i] << 16);
+		clipping[2*i] |= cpu_to_le32(pixel_list[i] << 16);
 	}
 	for(i = 0; i < cnt_line; i++) {
-		clipping[(2*i)+1] |= (line_list[i] << 16);
+		clipping[(2*i)+1] |= cpu_to_le32(line_list[i] << 16);
 	}
 
 	/* fill up cliptable with the display infos */
@@ -430,7 +430,7 @@
 			if( pixel_list[i] < (x[j] + w[j])) {
 			
 				if ( pixel_list[i] >= x[j] ) {
-					clipping[2*i] |= (1 << j);			
+					clipping[2*i] |= cpu_to_le32(1 << j);			
 				}
 			}
 		}
@@ -442,7 +442,7 @@
 			if( line_list[i] < (y[j] + h[j]) ) {
 
 				if( line_list[i] >= y[j] ) {
-					clipping[(2*i)+1] |= (1 << j);			
+					clipping[(2*i)+1] |= cpu_to_le32(1 << j);			
 				}
 			}
 		}
@@ -560,9 +560,10 @@
 }
 
 /* calculate the new memory offsets for a desired position */
-static void saa7146_set_position(struct saa7146_dev *dev, int w_x, int w_y, int w_height, enum v4l2_field field)
+static void saa7146_set_position(struct saa7146_dev *dev, int w_x, int w_y, int w_height, enum v4l2_field field, u32 pixelformat)
 {	
 	struct saa7146_vv *vv = dev->vv_data;
+	struct saa7146_format *sfmt = format_by_fourcc(dev, pixelformat);
 
 	int b_depth = vv->ov_fmt->depth;
 	int b_bpl = vv->ov_fb.fmt.bytesperline;
@@ -601,7 +602,7 @@
 		vdma1.pitch *= -1;
 	}
 		
-	vdma1.base_page = 0;
+	vdma1.base_page = sfmt->swap;
 	vdma1.num_line_byte = (vv->standard->v_field<<16)+vv->standard->h_pixels;
 
 	saa7146_write_out_dma(dev, 1, &vdma1);
@@ -657,7 +658,7 @@
 	struct saa7146_vv *vv = dev->vv_data;
 
 	saa7146_set_window(dev, fh->ov.win.w.width, fh->ov.win.w.height, fh->ov.win.field);
-	saa7146_set_position(dev, fh->ov.win.w.left, fh->ov.win.w.top, fh->ov.win.w.height, fh->ov.win.field);
+	saa7146_set_position(dev, fh->ov.win.w.left, fh->ov.win.w.top, fh->ov.win.w.height, fh->ov.win.field, vv->ov_fmt->pixelformat);
 	saa7146_set_output_format(dev, vv->ov_fmt->trans);
 	saa7146_set_clipping_rect(fh);
 
@@ -727,7 +729,7 @@
 	vdma1.pitch		= (width*depth*2)/8;
 	}
 	vdma1.num_line_byte	= ((vv->standard->v_field<<16) + vv->standard->h_pixels);
-	vdma1.base_page		= buf->pt[0].dma | ME1;
+	vdma1.base_page		= buf->pt[0].dma | ME1 | sfmt->swap;
 	
 	if( 0 != vv->vflip ) {
 		vdma1.prot_addr	= buf->pt[0].offset;
diff -uraNwB xx-linux-2.6.8.1/drivers/media/common/saa7146_i2c.c linux-2.6.8.1-patched/drivers/media/common/saa7146_i2c.c
--- xx-linux-2.6.8.1/drivers/media/common/saa7146_i2c.c	2004-07-19 19:40:04.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/common/saa7146_i2c.c	2004-08-11 11:59:36.000000000 +0200
@@ -1,13 +1,6 @@
 #include <linux/version.h>
 #include <media/saa7146_vv.h>
 
-/* helper function */
-static void my_wait(struct saa7146_dev *dev, long ms)
-{
-	set_current_state(TASK_INTERRUPTIBLE);
-	schedule_timeout((((ms+10)/10)*HZ)/1000);
-}
-
 u32 saa7146_i2c_func(struct i2c_adapter *adapter)
 {
 //fm	DEB_I2C(("'%s'.\n", adapter->name));
@@ -136,12 +129,12 @@
 		/* set "ABORT-OPERATION"-bit (bit 7)*/
 		saa7146_write(dev, I2C_STATUS, (dev->i2c_bitrate | MASK_07));
 		saa7146_write(dev, MC2, (MASK_00 | MASK_16));
-		my_wait(dev,SAA7146_I2C_DELAY);
+		msleep(SAA7146_I2C_DELAY);
 
 		/* clear all error-bits pending; this is needed because p.123, note 1 */
 		saa7146_write(dev, I2C_STATUS, dev->i2c_bitrate);
 		saa7146_write(dev, MC2, (MASK_00 | MASK_16));
-		my_wait(dev,SAA7146_I2C_DELAY);
+		msleep(SAA7146_I2C_DELAY);
  	}
 
 	/* check if any error is (still) present. (this can be necessary because p.123, note 1) */
@@ -155,18 +148,18 @@
 		   after serious protocol errors caused by e.g. the SAA7740 */
 		saa7146_write(dev, I2C_STATUS, (dev->i2c_bitrate | MASK_07));
 		saa7146_write(dev, MC2, (MASK_00 | MASK_16));
-		my_wait(dev,SAA7146_I2C_DELAY);
+		msleep(SAA7146_I2C_DELAY);
 
 		/* clear all error-bits pending */
 		saa7146_write(dev, I2C_STATUS, dev->i2c_bitrate);
 		saa7146_write(dev, MC2, (MASK_00 | MASK_16));
-		my_wait(dev,SAA7146_I2C_DELAY);
+		msleep(SAA7146_I2C_DELAY);
 
 		/* the data sheet says it might be necessary to clear the status
 		   twice after an abort */
 		saa7146_write(dev, I2C_STATUS, dev->i2c_bitrate);
 		saa7146_write(dev, MC2, (MASK_00 | MASK_16));
-		my_wait(dev,SAA7146_I2C_DELAY);
+		msleep(SAA7146_I2C_DELAY);
      	}
 
 	/* if any error is still present, a fatal error has occured ... */
@@ -243,7 +236,7 @@
 			if ((++trial < 20) && short_delay)
 				udelay(10);
 			else
-			my_wait(dev,1);
+			msleep(1);
 		}
 	}
 
@@ -345,7 +338,7 @@
 		}
 	        
 	        /* delay a bit before retrying */
-	        my_wait(dev, 10);
+	        msleep(10);
 		
 	} while (err != num && retries--);
 
@@ -400,7 +393,7 @@
 	.functionality	= saa7146_i2c_func,
 };
 
-int saa7146_i2c_adapter_prepare(struct saa7146_dev *dev, struct i2c_adapter *i2c_adapter, unsigned int class, u32 bitrate)
+int saa7146_i2c_adapter_prepare(struct saa7146_dev *dev, struct i2c_adapter *i2c_adapter, u32 bitrate)
 {
 	DEB_EE(("bitrate: 0x%08x\n",bitrate));
 	
@@ -411,13 +404,11 @@
 	saa7146_i2c_reset(dev);
 
 	if( NULL != i2c_adapter ) {
-		memset(i2c_adapter,0,sizeof(struct i2c_adapter));
-		strcpy(i2c_adapter->name, dev->name);	
 #if (LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0))
 		i2c_adapter->data = dev;
 #else
+		BUG_ON(!i2c_adapter->class);
 		i2c_set_adapdata(i2c_adapter,dev);
-		i2c_adapter->class = class;
 #endif
 		i2c_adapter->algo	   = &saa7146_algo;
 		i2c_adapter->algo_data     = NULL;
diff -uraNwB xx-linux-2.6.8.1/drivers/media/common/saa7146_video.c linux-2.6.8.1-patched/drivers/media/common/saa7146_video.c
--- xx-linux-2.6.8.1/drivers/media/common/saa7146_video.c	2004-08-23 09:34:58.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/common/saa7146_video.c	2004-07-31 02:05:45.000000000 +0200
@@ -38,6 +38,13 @@
 		.depth		= 32,
 		.flags		= 0,
 	}, {
+		.name 		= "RGB-32 (R-G-B)",
+		.pixelformat	= V4L2_PIX_FMT_RGB32,
+		.trans 		= RGB32_COMPOSED,
+		.depth		= 32,
+		.flags		= 0,
+		.swap		= 0x2,
+	}, {
 		.name 		= "Greyscale-8",
 		.pixelformat	= V4L2_PIX_FMT_GREY,
 		.trans 		= Y8,
@@ -634,7 +641,7 @@
 		/* walk all pages, copy all page addresses to ptr1 */
 		for (i = 0; i < length; i++, list++) {
 			for (p = 0; p * 4096 < list->length; p++, ptr1++) {
-				*ptr1 = sg_dma_address(list) - list->offset;
+				*ptr1 = cpu_to_le32(sg_dma_address(list) - list->offset);
 			}
 		}
 /*
diff -uraNwB xx-linux-2.6.8.1/include/media/saa7146.h linux-2.6.8.1-patched/include/media/saa7146.h
--- xx-linux-2.6.8.1/include/media/saa7146.h	2004-07-19 19:39:40.000000000 +0200
+++ linux-2.6.8.1-patched/include/media/saa7146.h	2004-06-21 18:52:14.000000000 +0200
@@ -154,7 +166,7 @@
 };
 
 /* from saa7146_i2c.c */
-int saa7146_i2c_adapter_prepare(struct saa7146_dev *dev, struct i2c_adapter *i2c_adapter, unsigned int class, u32 bitrate);
+int saa7146_i2c_adapter_prepare(struct saa7146_dev *dev, struct i2c_adapter *i2c_adapter, u32 bitrate);
 int saa7146_i2c_transfer(struct saa7146_dev *saa, const struct i2c_msg msgs[], int num,  int retries);
 
 /* from saa7146_core.c */
diff -uraNwB xx-linux-2.6.8.1/include/media/saa7146_vv.h linux-2.6.8.1-patched/include/media/saa7146_vv.h
--- xx-linux-2.6.8.1/include/media/saa7146_vv.h	2004-08-23 09:35:40.000000000 +0200
+++ linux-2.6.8.1-patched/include/media/saa7146_vv.h	2004-07-31 02:05:47.000000000 +0200
@@ -35,6 +35,7 @@
 	u32	trans;
 	u8	depth;
 	u8	flags;
+	u8	swap;
 };
 
 struct saa7146_standard
@@ -188,8 +189,8 @@
 };
 
 /* from saa7146_fops.c */
-int saa7146_register_device(struct video_device *vid, struct saa7146_dev* dev, char *name, int type);
-int saa7146_unregister_device(struct video_device *vid, struct saa7146_dev* dev);
+int saa7146_register_device(struct video_device **vid, struct saa7146_dev* dev, char *name, int type);
+int saa7146_unregister_device(struct video_device **vid, struct saa7146_dev* dev);
 void saa7146_buffer_finish(struct saa7146_dev *dev, struct saa7146_dmaqueue *q, int state);
 void saa7146_buffer_next(struct saa7146_dev *dev, struct saa7146_dmaqueue *q,int vbi);
 int saa7146_buffer_queue(struct saa7146_dev *dev, struct saa7146_dmaqueue *q, struct saa7146_buf *buf);

--------------040208010507090000030707--
