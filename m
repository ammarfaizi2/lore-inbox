Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267770AbTGOMRq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 08:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267614AbTGOMRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 08:17:00 -0400
Received: from mail.convergence.de ([212.84.236.4]:36256 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S267323AbTGOMGJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 08:06:09 -0400
Subject: [PATCH 9/17] More saa7146 driver core updates
In-Reply-To: <1058271656760@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Tue, 15 Jul 2003 14:20:56 +0200
Message-Id: <10582716562915@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Michael Hunold (LinuxTV.org CVS maintainer) 
	<hunold@convergence.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[V4L] - separate all EXPORT_SYMBOL stuff to saa7146_ksyms.c
[V4L] - properly stop capturing when no more buffers are available (missing register upload)
[V4L] - make extension data a per-device member, not a per-extension member, so that every device
        can have it's own private data (necessary for DVB drivers which handle more than one device)
[V4L] - implement field based capturing, ie. capturing fields to different capture buffers
[V4L] - change default old of capture fields for ALTERNATE mode (comply with bttv)
[V4L] - follow these changes in various analog saa7146 based cards drivers (mxb.c and dpc7146.c)
[DVB] - follow these changes in various saa7146 based budget card drivers

diff -uNrwB --new-file linux-2.6.0-test1.work/drivers/media/common/Makefile linux-2.6.0-test1.patch/drivers/media/common/Makefile
--- linux-2.6.0-test1.work/drivers/media/common/Makefile	2003-07-15 09:42:37.000000000 +0200
+++ linux-2.6.0-test1.patch/drivers/media/common/Makefile	2003-07-01 13:34:48.000000000 +0200
@@ -1,5 +1,5 @@
 saa7146-objs    := saa7146_i2c.o saa7146_core.o 
-saa7146_vv-objs := saa7146_fops.o saa7146_video.o saa7146_hlp.o saa7146_vbi.o  
+saa7146_vv-objs := saa7146_vv_ksyms.o saa7146_fops.o saa7146_video.o saa7146_hlp.o saa7146_vbi.o  
 
 obj-$(CONFIG_VIDEO_SAA7146) += saa7146.o saa7146_vv.o
 
diff -uNrwB --new-file linux-2.6.0-test1.work/drivers/media/common/saa7146_core.c linux-2.6.0-test1.patch/drivers/media/common/saa7146_core.c
--- linux-2.6.0-test1.work/drivers/media/common/saa7146_core.c	2003-07-15 09:42:37.000000000 +0200
+++ linux-2.6.0-test1.patch/drivers/media/common/saa7146_core.c	2003-07-07 13:28:54.000000000 +0200
@@ -373,6 +372,9 @@
 	dev->module = THIS_MODULE;
 	init_waitqueue_head(&dev->i2c_wq);
 
+	/* set some default values */
+	saa7146_write(dev, BCS_CTRL, 0x80400040);
+
 	if( 0 != ext->probe) {
 		if( 0 != ext->probe(dev) ) {
 			DEB_D(("ext->probe() failed for %p. skipping device.\n",dev));
@@ -391,9 +393,6 @@
 	list_add_tail(&dev->item,&saa7146_devices);
 	saa7146_num++;
 
-	/* set some default values */
-	saa7146_write(dev, BCS_CTRL, 0x80400040);
-
 	err = 0;
 	goto out;
 attach_error:
diff -uNrwB --new-file linux-2.6.0-test1.work/drivers/media/common/saa7146_fops.c linux-2.6.0-test1.patch/drivers/media/common/saa7146_fops.c
--- linux-2.6.0-test1.work/drivers/media/common/saa7146_fops.c	2003-07-15 09:42:37.000000000 +0200
+++ linux-2.6.0-test1.patch/drivers/media/common/saa7146_fops.c	2003-07-07 13:28:54.000000000 +0200
@@ -106,10 +106,21 @@
 			// fixme: fix this for vflip != 0
 
 			saa7146_write(dev, PROT_ADDR1, 0);
+			saa7146_write(dev, MC2, (MASK_02|MASK_18));		
+
 			/* write the address of the rps-program */
 			saa7146_write(dev, RPS_ADDR0, dev->d_rps0.dma_handle);
 			/* turn on rps */
 			saa7146_write(dev, MC1, (MASK_12 | MASK_28));
+				
+/*
+			printk("vdma%d.base_even:     0x%08x\n", 1,saa7146_read(dev,BASE_EVEN1));
+			printk("vdma%d.base_odd:      0x%08x\n", 1,saa7146_read(dev,BASE_ODD1));
+			printk("vdma%d.prot_addr:     0x%08x\n", 1,saa7146_read(dev,PROT_ADDR1));
+			printk("vdma%d.base_page:     0x%08x\n", 1,saa7146_read(dev,BASE_PAGE1));
+			printk("vdma%d.pitch:         0x%08x\n", 1,saa7146_read(dev,PITCH1));
+			printk("vdma%d.num_line_byte: 0x%08x\n", 1,saa7146_read(dev,NUM_LINE_BYTE1));
+*/
 		}
 		del_timer(&q->timeout);
 	}
@@ -374,7 +385,7 @@
 	.minor		= -1,
 };
 
-int saa7146_vv_init(struct saa7146_dev* dev)
+int saa7146_vv_init(struct saa7146_dev* dev, struct saa7146_ext_vv *ext_vv)
 {
 	struct saa7146_vv *vv = kmalloc (sizeof(struct saa7146_vv),GFP_KERNEL);
 	if( NULL == vv ) {
@@ -385,6 +396,11 @@
 
 	DEB_EE(("dev:%p\n",dev));
 	
+	/* save per-device extension data (one extension can
+	   handle different devices that might need different
+	   configuration data) */
+	dev->ext_vv_data = ext_vv;
+	
 	vv->video_minor = -1;
 	vv->vbi_minor = -1;
 
@@ -475,13 +491,6 @@
 module_init(saa7146_vv_init_module);
 module_exit(saa7146_vv_cleanup_module);
 
-EXPORT_SYMBOL_GPL(saa7146_set_hps_source_and_sync);
-EXPORT_SYMBOL_GPL(saa7146_register_device);
-EXPORT_SYMBOL_GPL(saa7146_unregister_device);
-
-EXPORT_SYMBOL_GPL(saa7146_vv_init);
-EXPORT_SYMBOL_GPL(saa7146_vv_release);
-
 MODULE_AUTHOR("Michael Hunold <michael@mihu.de>");
 MODULE_DESCRIPTION("video4linux driver for saa7146-based hardware");
 MODULE_LICENSE("GPL");
diff -uNrwB --new-file linux-2.6.0-test1.work/drivers/media/common/saa7146_hlp.c linux-2.6.0-test1.patch/drivers/media/common/saa7146_hlp.c
--- linux-2.6.0-test1.work/drivers/media/common/saa7146_hlp.c	2003-07-15 10:59:26.000000000 +0200
+++ linux-2.6.0-test1.patch/drivers/media/common/saa7146_hlp.c	2003-07-14 11:56:37.000000000 +0200
@@ -242,7 +242,9 @@
 		if( 2*out_y >= in_y) {
 			lpi = 1;
 		}
-	} else if (field == V4L2_FIELD_TOP || field == V4L2_FIELD_BOTTOM) {
+	} else if (field == V4L2_FIELD_TOP
+		|| field == V4L2_FIELD_ALTERNATE
+		|| field == V4L2_FIELD_BOTTOM) {
 		if( 4*out_y >= in_y ) {
 			lpi = 1;
 		}
@@ -468,9 +470,7 @@
 	*clip_format &= 0xfffffff7;
 	if (V4L2_FIELD_HAS_BOTH(field)) {
 		*clip_format |= 0x00000008;
-	} else if (field == V4L2_FIELD_TOP) {
-		*clip_format |= 0x00000000;
-	} else if (field == V4L2_FIELD_BOTTOM) {
+	} else {
 		*clip_format |= 0x00000000;
 	}
 }
@@ -593,6 +593,10 @@
 	}
 	
 	if (V4L2_FIELD_HAS_BOTH(field)) {
+	} else if (field == V4L2_FIELD_ALTERNATE) {
+		/* fixme */
+		vdma1.base_odd = vdma1.prot_addr;
+		vdma1.pitch /= 2;
 	} else if (field == V4L2_FIELD_TOP) {
 		vdma1.base_odd = vdma1.prot_addr;
 		vdma1.pitch /= 2;
@@ -706,7 +710,7 @@
 	/* calculate starting address */
 	where  = (which-1)*0x18;
 
-	if( 0 != (dev->ext->ext_vv_data->flags & SAA7146_EXT_SWAP_ODD_EVEN)) {
+	if( 0 != (dev->ext_vv_data->flags & SAA7146_EXT_SWAP_ODD_EVEN)) {
 		saa7146_write(dev, where, 	vdma->base_even);
 		saa7146_write(dev, where+0x04, 	vdma->base_odd);
 	} else {
@@ -760,6 +764,16 @@
 	}
 
 	if (V4L2_FIELD_HAS_BOTH(field)) {
+	} else if (field == V4L2_FIELD_ALTERNATE) {
+		/* fixme */
+		if ( vv->last_field == V4L2_FIELD_TOP ) {
+			vdma1.base_odd	= vdma1.prot_addr;
+			vdma1.pitch /= 2;
+		} else if ( vv->last_field == V4L2_FIELD_BOTTOM ) {
+			vdma1.base_odd	= vdma1.base_even;
+			vdma1.base_even = vdma1.prot_addr;
+			vdma1.pitch /= 2;
+		}
 	} else if (field == V4L2_FIELD_TOP) {
 		vdma1.base_odd	= vdma1.prot_addr;
 		vdma1.pitch /= 2;
@@ -896,6 +910,14 @@
 	}
 
 	if (V4L2_FIELD_HAS_BOTH(field)) {
+	} else if (field == V4L2_FIELD_ALTERNATE) {
+		/* fixme */
+		vdma1.base_odd	= vdma1.prot_addr;
+		vdma1.pitch /= 2;
+		vdma2.base_odd	= vdma2.prot_addr;
+		vdma2.pitch /= 2;
+		vdma3.base_odd	= vdma3.prot_addr;
+		vdma3.pitch /= 2;
 	} else if (field == V4L2_FIELD_TOP) {
 		vdma1.base_odd	= vdma1.prot_addr;
 		vdma1.pitch /= 2;
@@ -940,17 +962,17 @@
 	unsigned long e_wait = vv->current_hps_sync == SAA7146_HPS_SYNC_PORT_A ? CMD_E_FID_A : CMD_E_FID_B;
 	unsigned long o_wait = vv->current_hps_sync == SAA7146_HPS_SYNC_PORT_A ? CMD_O_FID_A : CMD_O_FID_B;
 
-	if( 0 != (dev->ext->ext_vv_data->flags & SAA7146_EXT_SWAP_ODD_EVEN)) {
+	if( 0 != (dev->ext_vv_data->flags & SAA7146_EXT_SWAP_ODD_EVEN)) {
 		unsigned long tmp = e_wait;
 		e_wait = o_wait;
 		o_wait = tmp;
 	}
 
-	/* wait for o_fid_a/b / e_fid_a/b toggle only if bit 0 is not set*/
-	WRITE_RPS0(CMD_PAUSE | CMD_OAN | CMD_SIG0 | e_wait);
+	/* wait for o_fid_a/b / e_fid_a/b toggle only if rps register 0 is not set*/
 	WRITE_RPS0(CMD_PAUSE | CMD_OAN | CMD_SIG0 | o_wait);
+	WRITE_RPS0(CMD_PAUSE | CMD_OAN | CMD_SIG0 | e_wait);
 
-	/* set bit 0 */
+	/* set rps register 0 */
 	WRITE_RPS0(CMD_WR_REG | (1 << 8) | (MC2/4)); 	
 	WRITE_RPS0(MASK_27 | MASK_11);
 	
@@ -971,8 +993,14 @@
 	}
 	
 	/* wait for o_fid_a/b / e_fid_a/b toggle */
+	if ( vv->last_field == V4L2_FIELD_INTERLACED ) {
+		WRITE_RPS0(CMD_PAUSE | o_wait);
 	WRITE_RPS0(CMD_PAUSE | e_wait);
+	} else if ( vv->last_field == V4L2_FIELD_TOP ) {
 	WRITE_RPS0(CMD_PAUSE | o_wait);
+	} else if ( vv->last_field == V4L2_FIELD_BOTTOM ) {
+		WRITE_RPS0(CMD_PAUSE | e_wait);
+	}
 
 	/* turn off video-dma1 */
 	WRITE_RPS0(CMD_WR_REG_MASK | (MC1/4));
@@ -1000,13 +1028,39 @@
 void saa7146_set_capture(struct saa7146_dev *dev, struct saa7146_buf *buf, struct saa7146_buf *next)
 {
 	struct saa7146_format *sfmt = format_by_fourcc(dev,buf->fmt->pixelformat);
+	struct saa7146_vv *vv = dev->vv_data;
+	u32 vdma1_prot_addr;
 
 	DEB_CAP(("buf:%p, next:%p\n",buf,next));
 
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
+	vdma1_prot_addr = saa7146_read(dev, PROT_ADDR1);
+	if( 0 == vdma1_prot_addr ) {
+		/* clear out beginning of streaming bit (rps register 0)*/
+		DEB_CAP(("forcing sync to new frame\n"));
+		saa7146_write(dev, MC2, MASK_27 );
+	}
+
 	saa7146_set_window(dev, buf->fmt->width, buf->fmt->height, buf->fmt->field);
 	saa7146_set_output_format(dev, sfmt->trans);
 	saa7146_disable_clipping(dev);
 
+	if ( vv->last_field == V4L2_FIELD_INTERLACED ) {
+	} else if ( vv->last_field == V4L2_FIELD_TOP ) {
+		vv->last_field = V4L2_FIELD_BOTTOM;
+	} else if ( vv->last_field == V4L2_FIELD_BOTTOM ) {
+		vv->last_field = V4L2_FIELD_TOP;
+	}
+
 	if( 0 != IS_PLANAR(sfmt->trans)) {
 		calculate_video_dma_grab_planar(dev, buf);
 		program_capture_engine(dev,1);
diff -uNrwB --new-file linux-2.6.0-test1.work/drivers/media/common/saa7146_i2c.c linux-2.6.0-test1.patch/drivers/media/common/saa7146_i2c.c
--- linux-2.6.0-test1.work/drivers/media/common/saa7146_i2c.c	2003-07-15 10:59:26.000000000 +0200
+++ linux-2.6.0-test1.patch/drivers/media/common/saa7146_i2c.c	2003-06-18 14:20:44.000000000 +0200
@@ -407,8 +407,13 @@
 
 	if( NULL != i2c_adapter ) {
 		memset(i2c_adapter,0,sizeof(struct i2c_adapter));
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0))
+		strcpy(i2c_adapter->name, dev->name);	
+		i2c_adapter->data = dev;
+#else
 		strcpy(i2c_adapter->dev.name, dev->name);	
 		i2c_set_adapdata(i2c_adapter,dev);
+#endif
 		i2c_adapter->algo	   = &saa7146_algo;
 		i2c_adapter->algo_data     = NULL;
 		i2c_adapter->id 	   = I2C_ALGO_SAA7146;
diff -uNrwB --new-file linux-2.6.0-test1.work/drivers/media/common/saa7146_vbi.c linux-2.6.0-test1.patch/drivers/media/common/saa7146_vbi.c
--- linux-2.6.0-test1.work/drivers/media/common/saa7146_vbi.c	2003-07-15 10:59:26.000000000 +0200
+++ linux-2.6.0-test1.patch/drivers/media/common/saa7146_vbi.c	2003-07-01 13:34:48.000000000 +0200
@@ -444,5 +444,3 @@
 	.irq_done	= vbi_irq_done,
 	.read 		= vbi_read,
 };
-
-EXPORT_SYMBOL_GPL(saa7146_vbi_uops);
diff -uNrwB --new-file linux-2.6.0-test1.work/drivers/media/common/saa7146_video.c linux-2.6.0-test1.patch/drivers/media/common/saa7146_video.c
--- linux-2.6.0-test1.work/drivers/media/common/saa7146_video.c	2003-07-15 10:59:26.000000000 +0200
+++ linux-2.6.0-test1.patch/drivers/media/common/saa7146_video.c	2003-07-10 11:19:39.000000000 +0200
@@ -137,6 +137,7 @@
         switch (field) {
         case V4L2_FIELD_TOP:
         case V4L2_FIELD_BOTTOM:
+        case V4L2_FIELD_ALTERNATE:
                 maxh = maxh / 2;
                 break;
         case V4L2_FIELD_INTERLACED:
@@ -186,11 +187,18 @@
 				: V4L2_FIELD_BOTTOM;
 		}
 		switch (field) {
+		case V4L2_FIELD_ALTERNATE: {
+			vv->last_field = V4L2_FIELD_TOP;
+			maxh = maxh / 2;
+			break;
+		}
 		case V4L2_FIELD_TOP:
 		case V4L2_FIELD_BOTTOM:
+			vv->last_field = V4L2_FIELD_INTERLACED;
 			maxh = maxh / 2;
 			break;
 		case V4L2_FIELD_INTERLACED:
+			vv->last_field = V4L2_FIELD_INTERLACED;
 			break;
 		default: {
 			DEB_D(("no known field mode '%d'.\n",field));
@@ -561,7 +569,7 @@
 				m3 = ((size+(size/2)+PAGE_SIZE)/PAGE_SIZE)-1;
 				o1 = size%PAGE_SIZE;
 				o2 = (size+(size/4))%PAGE_SIZE;
-				printk("size:%d, m1:%d, m2:%d, m3:%d, o1:%d, o2:%d\n",size,m1,m2,m3,o1,o2);
+				DEB_CAP(("size:%d, m1:%d, m2:%d, m3:%d, o1:%d, o2:%d\n",size,m1,m2,m3,o1,o2));
 				break;
 			}
 			case 16: {
@@ -571,7 +579,7 @@
 				m3 = ((2*size+PAGE_SIZE)/PAGE_SIZE)-1;
 				o1 = size%PAGE_SIZE;
 				o2 = (size+(size/2))%PAGE_SIZE;
-				printk("size:%d, m1:%d, m2:%d, m3:%d, o1:%d, o2:%d\n",size,m1,m2,m3,o1,o2);
+				DEB_CAP(("size:%d, m1:%d, m2:%d, m3:%d, o1:%d, o2:%d\n",size,m1,m2,m3,o1,o2));
 				break;
 			}
 			default: {
@@ -674,7 +682,7 @@
 
 	spin_lock_irqsave(&dev->slock,flags);
 
-	/* clear out beginning of streaming bit */
+	/* clear out beginning of streaming bit (rps register 0)*/
 	saa7146_write(dev, MC2, MASK_27 );
 
 	/* enable rps0 irqs */
@@ -740,19 +748,19 @@
 	struct videobuf_queue *q;
 
 	/* check if extension handles the command */
-	for(ee = 0; dev->ext->ext_vv_data->ioctls[ee].flags != 0; ee++) {
-		if( cmd == dev->ext->ext_vv_data->ioctls[ee].cmd )
+	for(ee = 0; dev->ext_vv_data->ioctls[ee].flags != 0; ee++) {
+		if( cmd == dev->ext_vv_data->ioctls[ee].cmd )
 			break;
 	}
 	
-	if( 0 != (dev->ext->ext_vv_data->ioctls[ee].flags & SAA7146_EXCLUSIVE) ) {
+	if( 0 != (dev->ext_vv_data->ioctls[ee].flags & SAA7146_EXCLUSIVE) ) {
 		DEB_D(("extension handles ioctl exclusive.\n"));
-		result = dev->ext->ext_vv_data->ioctl(fh, cmd, arg);
+		result = dev->ext_vv_data->ioctl(fh, cmd, arg);
 		return result;
 	}
-	if( 0 != (dev->ext->ext_vv_data->ioctls[ee].flags & SAA7146_BEFORE) ) {
+	if( 0 != (dev->ext_vv_data->ioctls[ee].flags & SAA7146_BEFORE) ) {
 		DEB_D(("extension handles ioctl before.\n"));
-		result = dev->ext->ext_vv_data->ioctl(fh, cmd, arg);
+		result = dev->ext_vv_data->ioctl(fh, cmd, arg);
 		if( -EAGAIN != result ) {
 			return result;
 		}
@@ -793,7 +801,7 @@
 			V4L2_CAP_VIDEO_OVERLAY |
 			V4L2_CAP_READWRITE | 
 			V4L2_CAP_STREAMING;
-		cap->capabilities |= dev->ext->ext_vv_data->capabilities;
+		cap->capabilities |= dev->ext_vv_data->capabilities;
 		return 0;
 	}
 	case VIDIOC_G_FBUF:
@@ -942,9 +950,10 @@
 		struct v4l2_standard *e = arg;
 		if (e->index < 0 )
 			return -EINVAL;
-		if( e->index < dev->ext->ext_vv_data->num_stds ) {
+		if( e->index < dev->ext_vv_data->num_stds ) {
 			DEB_EE(("VIDIOC_ENUMSTD: index:%d\n",e->index));
-			return v4l2_video_std_construct(e, dev->ext->ext_vv_data->stds[e->index].id, dev->ext->ext_vv_data->stds[e->index].name);
+			v4l2_video_std_construct(e, dev->ext_vv_data->stds[e->index].id, dev->ext_vv_data->stds[e->index].name);
+			return 0;
 		}
 		return -EINVAL;
 	}
@@ -972,13 +981,13 @@
 			restart_overlay = 1;
 		}
 
-		for(i = 0; i < dev->ext->ext_vv_data->num_stds; i++)
-			if (*id & dev->ext->ext_vv_data->stds[i].id)
+		for(i = 0; i < dev->ext_vv_data->num_stds; i++)
+			if (*id & dev->ext_vv_data->stds[i].id)
 				break;
-		if (i != dev->ext->ext_vv_data->num_stds) {
-			vv->standard = &dev->ext->ext_vv_data->stds[i];
-			if( NULL != dev->ext->ext_vv_data->std_callback )
-				dev->ext->ext_vv_data->std_callback(dev, vv->standard);
+		if (i != dev->ext_vv_data->num_stds) {
+			vv->standard = &dev->ext_vv_data->stds[i];
+			if( NULL != dev->ext_vv_data->std_callback )
+				dev->ext_vv_data->std_callback(dev, vv->standard);
 			found = 1;
 		}
 
@@ -1000,7 +1009,7 @@
 		int on = *(int *)arg;
 		int err = 0;
 
-		if( NULL == vv->ov_fmt ) {
+		if( NULL == vv->ov_fmt && on != 0 ) {
 			DEB_D(("VIDIOC_OVERLAY: no framebuffer informations. call S_FBUF first!\n"));
 			return -EAGAIN;
 		}
@@ -1036,12 +1045,18 @@
 		return videobuf_querybuf(q,arg);
 	}
 	case VIDIOC_QBUF: {
-		DEB_D(("VIDIOC_QBUF \n"));
-		return videobuf_qbuf(file,q,arg);
+		struct v4l2_buffer *b = arg;
+		int ret = 0;
+		ret = videobuf_qbuf(file,q,b);
+		DEB_D(("VIDIOC_QBUF: ret:%d, index:%d\n",ret,b->index));
+		return ret;
 	}
 	case VIDIOC_DQBUF: {
-		DEB_D(("VIDIOC_DQBUF \n"));
-		return videobuf_dqbuf(file,q,arg);
+		struct v4l2_buffer *b = arg;
+		int ret = 0;
+		ret = videobuf_dqbuf(file,q,b);
+		DEB_D(("VIDIOC_DQBUF: ret:%d, index:%d\n",ret,b->index));
+		return ret;
 	}
 	case VIDIOC_STREAMON: {
 		DEB_D(("VIDIOC_STREAMON \n"));
@@ -1075,7 +1090,7 @@
 
 		q = &fh->video_q;
 		down(&q->lock);
-		err = videobuf_mmap_setup(file,q,gbuffers,gbufsize);
+		err = videobuf_mmap_setup(file,q,gbuffers,gbufsize); // ,V4L2_MEMORY_MMAP);
 		if (err < 0) {
 			up(&q->lock);
 			return err;
@@ -1250,7 +1265,7 @@
 	vv->video_q.dev              = dev;
 
 	/* set some default values */
-	vv->standard = &dev->ext->ext_vv_data->stds[0];
+	vv->standard = &dev->ext_vv_data->stds[0];
 
 	/* FIXME: what's this? */
 	vv->current_hps_source = SAA7146_HPS_SOURCE_PORT_A;
@@ -1358,8 +1373,3 @@
 	.capture_begin = video_begin,
 	.capture_end = video_end,
 };
-
-EXPORT_SYMBOL_GPL(saa7146_video_uops);
-
-EXPORT_SYMBOL_GPL(saa7146_start_preview);
-EXPORT_SYMBOL_GPL(saa7146_stop_preview);
diff -uNrwB --new-file linux-2.6.0-test1.work/drivers/media/common/saa7146_vv_ksyms.c linux-2.6.0-test1.patch/drivers/media/common/saa7146_vv_ksyms.c
--- linux-2.6.0-test1.work/drivers/media/common/saa7146_vv_ksyms.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.0-test1.patch/drivers/media/common/saa7146_vv_ksyms.c	2003-07-01 13:34:48.000000000 +0200
@@ -0,0 +1,15 @@
+#include <linux/module.h>
+#include <media/saa7146_vv.h>
+
+EXPORT_SYMBOL_GPL(saa7146_vbi_uops);
+EXPORT_SYMBOL_GPL(saa7146_video_uops);
+
+EXPORT_SYMBOL_GPL(saa7146_start_preview);
+EXPORT_SYMBOL_GPL(saa7146_stop_preview);
+
+EXPORT_SYMBOL_GPL(saa7146_set_hps_source_and_sync);
+EXPORT_SYMBOL_GPL(saa7146_register_device);
+EXPORT_SYMBOL_GPL(saa7146_unregister_device);
+
+EXPORT_SYMBOL_GPL(saa7146_vv_init);
+EXPORT_SYMBOL_GPL(saa7146_vv_release);
diff -uNrwB --new-file linux-2.6.0-test1.work/drivers/media/dvb/ttpci/budget-av.c linux-2.6.0-test1.patch/drivers/media/dvb/ttpci/budget-av.c
--- linux-2.6.0-test1.work/drivers/media/dvb/ttpci/budget-av.c	2003-07-15 10:59:26.000000000 +0200
+++ linux-2.6.0-test1.patch/drivers/media/dvb/ttpci/budget-av.c	2003-07-07 13:28:54.000000000 +0200
@@ -170,6 +170,7 @@
 	return err;
 }
 
+static struct saa7146_ext_vv vv_data;
 
 static int budget_av_attach (struct saa7146_dev* dev,
 		      struct saa7146_pci_extension_data *info)
@@ -207,16 +208,22 @@
 	dvb_delay(500);
 
 	if ((err = saa7113_init (budget_av))) {
-		budget_av_detach(dev);
+		/* fixme: proper cleanup here */
+		ERR(("cannot init saa7113.\n"));
+		return err;
+	}
+
+	if ( 0 != saa7146_vv_init(dev,&vv_data)) {
+		/* fixme: proper cleanup here */
+		ERR(("cannot init vv subsystem.\n"));
 		return err;
 	}
 
-	saa7146_vv_init(dev);
 	if ((err = saa7146_register_device(&budget_av->vd, dev, "knc1",
 					   VFL_TYPE_GRABBER)))
 	{
+		/* fixme: proper cleanup here */
 		ERR(("cannot register capture v4l2 device.\n"));
-		budget_av_detach(dev);
 		return err;
 	}
 
@@ -300,11 +307,19 @@
 }
 
 static struct saa7146_standard standard[] = {
-	{ "PAL",	V4L2_STD_PAL,	SAA7146_PAL_VALUES },
-	{ "NTSC",	V4L2_STD_NTSC,	SAA7146_NTSC_VALUES },
+	{
+		.name	= "PAL", 	.id	= V4L2_STD_PAL,
+		.v_offset	= 0x17,	.v_field 	= 288,	.v_calc		= 576,
+		.h_offset	= 0x14,	.h_pixels 	= 680,	.h_calc		= 680+1,
+		.v_max_out	= 576,	.h_max_out	= 768,
+	}, {
+		.name	= "NTSC", 	.id	= V4L2_STD_NTSC,
+		.v_offset	= 0x16,	.v_field 	= 240,	.v_calc		= 480,
+		.h_offset	= 0x06,	.h_pixels 	= 708,	.h_calc		= 708+1,
+		.v_max_out	= 480,	.h_max_out	= 640,
+	}
 };
 
-
 static struct saa7146_ext_vv vv_data = {
 	.inputs		= 2,
 	.capabilities	= 0, // perhaps later: V4L2_CAP_VBI_CAPTURE, but that need tweaking with the saa7113
@@ -339,8 +354,6 @@
 	.attach		= budget_av_attach,
 	.detach		= budget_av_detach,
 
-	.ext_vv_data	= &vv_data,
-
 	.irq_mask	= MASK_10,
 	.irq_func	= ttpci_budget_irq10_handler,
 };	
diff -uNrwB --new-file linux-2.6.0-test1.work/drivers/media/dvb/ttpci/budget-ci.c linux-2.6.0-test1.patch/drivers/media/dvb/ttpci/budget-ci.c
--- linux-2.6.0-test1.work/drivers/media/dvb/ttpci/budget-ci.c	2003-07-15 09:42:37.000000000 +0200
+++ linux-2.6.0-test1.patch/drivers/media/dvb/ttpci/budget-ci.c	2003-07-07 13:28:54.000000000 +0200
@@ -371,7 +377,6 @@
 static struct saa7146_extension budget_extension = {
 	.name		= "budget_ci dvb\0",
 	.flags	 	= 0,
-	.ext_vv_data	= NULL,
 
 	.module		= THIS_MODULE,
 	.pci_tbl	= &pci_tbl[0],
diff -uNrwB --new-file linux-2.6.0-test1.work/drivers/media/dvb/ttpci/budget-patch.c linux-2.6.0-test1.patch/drivers/media/dvb/ttpci/budget-patch.c
--- linux-2.6.0-test1.work/drivers/media/dvb/ttpci/budget-patch.c	2003-07-15 10:59:26.000000000 +0200
+++ linux-2.6.0-test1.patch/drivers/media/dvb/ttpci/budget-patch.c	2003-07-07 13:28:54.000000000 +0200
@@ -264,7 +264,6 @@
 static struct saa7146_extension budget_extension = {
         .name           = "budget_patch dvb\0",
         .flags          = 0,
-        .ext_vv_data    = NULL,
         
         .module         = THIS_MODULE,
         .pci_tbl        = pci_tbl,
diff -uNrwB --new-file linux-2.6.0-test1.work/drivers/media/dvb/ttpci/budget.c linux-2.6.0-test1.patch/drivers/media/dvb/ttpci/budget.c
--- linux-2.6.0-test1.work/drivers/media/dvb/ttpci/budget.c	2003-07-15 10:59:50.000000000 +0200
+++ linux-2.6.0-test1.patch/drivers/media/dvb/ttpci/budget.c	2003-07-07 13:28:54.000000000 +0200
@@ -215,7 +215,6 @@
 static struct saa7146_extension budget_extension = {
 	.name		= "budget dvb\0",
 	.flags	 	= 0,
-	.ext_vv_data	= NULL,
 	
 	.module		= THIS_MODULE,
 	.pci_tbl	= pci_tbl,
diff -uNrwB --new-file linux-2.6.0-test1.work/drivers/media/video/dpc7146.c linux-2.6.0-test1.patch/drivers/media/video/dpc7146.c
--- linux-2.6.0-test1.work/drivers/media/video/dpc7146.c	2003-07-15 10:59:26.000000000 +0200
+++ linux-2.6.0-test1.patch/drivers/media/video/dpc7146.c	2003-07-15 09:57:59.000000000 +0200
@@ -173,6 +173,8 @@
 	return 0;
 }
 
+static struct saa7146_ext_vv vv_data;
+
 /* this function only gets called when the probing was successful */
 static int dpc_attach(struct saa7146_dev* dev, struct saa7146_pci_extension_data *info)
 {
@@ -183,7 +185,7 @@
 	/* checking for i2c-devices can be omitted here, because we
 	   already did this in "dpc_vl42_probe" */
 
-	saa7146_vv_init(dev);
+	saa7146_vv_init(dev,&vv_data);
 	if( 0 != saa7146_register_device(&dpc->video_dev, dev, "dpc", VFL_TYPE_GRABBER)) {
 		ERR(("cannot register capture v4l2 device. skipping.\n"));
 		return -1;
@@ -308,23 +310,32 @@
 }
 
 static struct saa7146_standard standard[] = {
-	{ "PAL-BG",	V4L2_STD_PAL_BG,	SAA7146_PAL_VALUES },
-	{ "PAL-I",	V4L2_STD_PAL_I,		SAA7146_PAL_VALUES },
-	{ "NTSC",	V4L2_STD_NTSC,		SAA7146_NTSC_VALUES },
-	{ "SECAM", 	V4L2_STD_SECAM,		SAA7146_SECAM_VALUES },
+	{
+		.name	= "PAL", 	.id	= V4L2_STD_PAL,
+		.v_offset	= 0x17,	.v_field 	= 288,	.v_calc		= 576,
+		.h_offset	= 0x14,	.h_pixels 	= 680,	.h_calc		= 680+1,
+		.v_max_out	= 576,	.h_max_out	= 768,
+	}, {
+		.name	= "NTSC", 	.id	= V4L2_STD_NTSC,
+		.v_offset	= 0x16,	.v_field 	= 240,	.v_calc		= 480,
+		.h_offset	= 0x06,	.h_pixels 	= 708,	.h_calc		= 708+1,
+		.v_max_out	= 480,	.h_max_out	= 640,
+	}, {
+		.name	= "SECAM", 	.id	= V4L2_STD_SECAM,
+		.v_offset	= 0x14,	.v_field 	= 288,	.v_calc		= 576,
+		.h_offset	= 0x14,	.h_pixels 	= 720,	.h_calc		= 720+1,
+		.v_max_out	= 576,	.h_max_out	= 768,
+	}
 };
 
-static
-struct saa7146_extension extension;
+static struct saa7146_extension extension;
 
-static
-struct saa7146_pci_extension_data dpc = {
+static struct saa7146_pci_extension_data dpc = {
         .ext_priv = "Multimedia eXtension Board",
         .ext = &extension,
 };
 
-static
-struct pci_device_id pci_tbl[] = {
+static struct pci_device_id pci_tbl[] = {
 	{
 		.vendor    = PCI_VENDOR_ID_PHILIPS,
 		.device	   = PCI_DEVICE_ID_PHILIPS_SAA7146,
@@ -338,8 +349,7 @@
 
 MODULE_DEVICE_TABLE(pci, pci_tbl);
 
-static
-struct saa7146_ext_vv vv_data = {
+static struct saa7146_ext_vv vv_data = {
 	.inputs		= DPC_INPUTS,
 	.capabilities	= V4L2_CAP_VBI_CAPTURE,
 	.stds		= &standard[0],
@@ -349,14 +359,12 @@
 	.ioctl		= dpc_ioctl,
 };
 
-static
-struct saa7146_extension extension = {
+static struct saa7146_extension extension = {
 	.name		= "dpc7146 demonstration board",
 	.flags		= SAA7146_USE_I2C_IRQ,
 	
 	.pci_tbl	= &pci_tbl[0],
 	.module		= THIS_MODULE,
-	.ext_vv_data	= &vv_data,
 
 	.probe		= dpc_probe,
 	.attach		= dpc_attach,
diff -uNrwB --new-file linux-2.6.0-test1.work/drivers/media/video/mxb.c linux-2.6.0-test1.patch/drivers/media/video/mxb.c
--- linux-2.6.0-test1.work/drivers/media/video/mxb.c	2003-07-15 10:59:26.000000000 +0200
+++ linux-2.6.0-test1.patch/drivers/media/video/mxb.c	2003-07-15 09:57:50.000000000 +0200
@@ -81,7 +81,7 @@
 enum { TUNER, AUX1, AUX3, AUX3_YC };
 
 static struct v4l2_input mxb_inputs[MXB_INPUTS] = {
-	{ TUNER,	"Tuner",		V4L2_INPUT_TYPE_TUNER,	1, 1, V4L2_STD_PAL_BG|V4L2_STD_NTSC_M, 0 }, 
+	{ TUNER,	"Tuner",		V4L2_INPUT_TYPE_TUNER,	1, 0, V4L2_STD_PAL_BG|V4L2_STD_NTSC_M, 0 }, 
 	{ AUX1,		"AUX1",			V4L2_INPUT_TYPE_CAMERA,	2, 0, V4L2_STD_PAL_BG|V4L2_STD_NTSC_M, 0 },
 	{ AUX3,		"AUX3 Composite",	V4L2_INPUT_TYPE_CAMERA,	4, 0, V4L2_STD_PAL_BG|V4L2_STD_NTSC_M, 0 },
 	{ AUX3_YC,	"AUX3 S-Video",		V4L2_INPUT_TYPE_CAMERA,	4, 0, V4L2_STD_PAL_BG|V4L2_STD_NTSC_M, 0 },
@@ -101,8 +101,8 @@
 
 /* this array holds the information of the audio source (mxb_audios),
    which has to be switched corresponding to the video source (mxb_channels) */
-static int video_audio_connect[MXB_AUDIOS] =
-	{ 0, 1, 2, 3, 3 };
+static int video_audio_connect[MXB_INPUTS] =
+	{ 0, 1, 3, 3 };
 
 /* these are the necessary input-output-pins for bringing one audio source
 (see above) to the CD-output */
@@ -173,8 +173,7 @@
 	int	cur_mute;	/* current mute status */
 };
 
-static
-struct saa7146_extension extension;
+static struct saa7146_extension extension;
 
 static int mxb_vbi_bypass(struct saa7146_dev* dev)
 {
@@ -431,10 +430,11 @@
 		   polling method ... */
 		extension.flags &= ~SAA7146_USE_I2C_IRQ;
 		for(i = 1;;i++) {
-			msg.len = mxb_saa7740_init[i].length;		
-			if (msg.len == -1U) {
+			if( -1 == mxb_saa7740_init[i].length ) {
 				break;
 			}
+
+			msg.len = mxb_saa7740_init[i].length;		
 			msg.buf = &mxb_saa7740_init[i].data[0];
 			if( 1 != (err = i2c_transfer(&mxb->i2c_adapter, &msg, 1))) {
 				DEB_D(("failed to initialize 'sound arena module'.\n"));
@@ -472,6 +472,8 @@
 }
 */
 
+static struct saa7146_ext_vv vv_data;
+
 /* this function only gets called when the probing was successful */
 static int mxb_attach(struct saa7146_dev* dev, struct saa7146_pci_extension_data *info)
 {
@@ -482,7 +484,7 @@
 	/* checking for i2c-devices can be omitted here, because we
 	   already did this in "mxb_vl42_probe" */
 
-	saa7146_vv_init(dev);
+	saa7146_vv_init(dev,&vv_data);
 	if( 0 != saa7146_register_device(&mxb->video_dev, dev, "mxb", VFL_TYPE_GRABBER)) {
 		ERR(("cannot register capture v4l2 device. skipping.\n"));
 		return -1;
@@ -1003,20 +1005,35 @@
 }
 
 static struct saa7146_standard standard[] = {
-	{ "PAL-BG",	V4L2_STD_PAL_BG,	SAA7146_PAL_VALUES },
-	{ "PAL-I",	V4L2_STD_PAL_I,		SAA7146_PAL_VALUES },
-	{ "NTSC",	V4L2_STD_NTSC,		SAA7146_NTSC_VALUES },
-	{ "SECAM", 	V4L2_STD_SECAM,		SAA7146_SECAM_VALUES },
+	{
+		.name	= "PAL-BG", 	.id	= V4L2_STD_PAL_BG,
+		.v_offset	= 0x17,	.v_field 	= 288,	.v_calc		= 576,
+		.h_offset	= 0x14,	.h_pixels 	= 680,	.h_calc		= 680+1,
+		.v_max_out	= 576,	.h_max_out	= 768,
+	}, {
+		.name	= "PAL-I", 	.id	= V4L2_STD_PAL_I,
+		.v_offset	= 0x17,	.v_field 	= 288,	.v_calc		= 576,
+		.h_offset	= 0x14,	.h_pixels 	= 680,	.h_calc		= 680+1,
+		.v_max_out	= 576,	.h_max_out	= 768,
+	}, {
+		.name	= "NTSC", 	.id	= V4L2_STD_NTSC,
+		.v_offset	= 0x16,	.v_field 	= 240,	.v_calc		= 480,
+		.h_offset	= 0x06,	.h_pixels 	= 708,	.h_calc		= 708+1,
+		.v_max_out	= 480,	.h_max_out	= 640,
+	}, {
+		.name	= "SECAM", 	.id	= V4L2_STD_SECAM,
+		.v_offset	= 0x14,	.v_field 	= 288,	.v_calc		= 576,
+		.h_offset	= 0x14,	.h_pixels 	= 720,	.h_calc		= 720+1,
+		.v_max_out	= 576,	.h_max_out	= 768,
+	}
 };
 
-static
-struct saa7146_pci_extension_data mxb = {
+static struct saa7146_pci_extension_data mxb = {
         .ext_priv = "Multimedia eXtension Board",
         .ext = &extension,
 };
 
-static
-struct pci_device_id pci_tbl[] = {
+static struct pci_device_id pci_tbl[] = {
 	{
 		.vendor    = PCI_VENDOR_ID_PHILIPS,
 		.device	   = PCI_DEVICE_ID_PHILIPS_SAA7146,
@@ -1030,8 +1047,7 @@
 
 MODULE_DEVICE_TABLE(pci, pci_tbl);
 
-static
-struct saa7146_ext_vv vv_data = {
+static struct saa7146_ext_vv vv_data = {
 	.inputs		= MXB_INPUTS,
 	.capabilities	= V4L2_CAP_TUNER | V4L2_CAP_VBI_CAPTURE,
 	.stds		= &standard[0],
@@ -1041,14 +1057,12 @@
 	.ioctl		= mxb_ioctl,
 };
 
-static
-struct saa7146_extension extension = {
+static struct saa7146_extension extension = {
 	.name		= MXB_IDENTIFIER,
 	.flags		= SAA7146_USE_I2C_IRQ,
 	
 	.pci_tbl	= &pci_tbl[0],
 	.module		= THIS_MODULE,
-	.ext_vv_data	= &vv_data,
 
 	.probe		= mxb_probe,
 	.attach		= mxb_attach,
diff -uNrwB --new-file linux-2.6.0-test1.work/include/media/saa7146.h linux-2.6.0-test1.patch/include/media/saa7146.h
--- linux-2.6.0-test1.work/include/media/saa7146.h	2003-07-15 09:43:07.000000000 +0200
+++ linux-2.6.0-test1.patch/include/media/saa7146.h	2003-07-07 13:28:54.000000000 +0200
@@ -89,8 +89,6 @@
 #define SAA7146_USE_I2C_IRQ	0x1
 	int	flags;
 	
-	struct saa7146_ext_vv	*ext_vv_data;
-	
 	/* pairs of subvendor and subdevice ids for
 	   supported devices, last entry 0xffff, 0xfff */
 	struct module *module;
@@ -134,6 +132,7 @@
 	/* extension handling */
 	struct saa7146_extension	*ext;		/* indicates if handled by extension */
 	void				*ext_priv;	/* pointer for extension private use (most likely some private data) */
+	struct saa7146_ext_vv		*ext_vv_data;
 
 	/* per device video/vbi informations (if available) */
 	struct saa7146_vv	*vv_data;
diff -uNrwB --new-file linux-2.6.0-test1.work/include/media/saa7146_vv.h linux-2.6.0-test1.patch/include/media/saa7146_vv.h
--- linux-2.6.0-test1.work/include/media/saa7146_vv.h	2003-07-15 10:59:26.000000000 +0200
+++ linux-2.6.0-test1.patch/include/media/saa7146_vv.h	2003-07-07 13:28:55.000000000 +0200
@@ -39,13 +39,13 @@
 	char          *name;
 	v4l2_std_id   id;
 
-	int v_offset;
-	int v_field;
-	int v_calc;
-	
-	int h_offset;
-	int h_pixels;
-	int h_calc;
+	int v_offset;	/* number of lines of vertical offset before processing */
+	int v_field;	/* number of lines in a field for HPS to process */
+	int v_calc;	/* number of vertical active lines */
+	
+	int h_offset;	/* horizontal offset of processing window */
+	int h_pixels;	/* number of horizontal pixels to process */
+	int h_calc;	/* number of horizontal active pixels */
 	
 	int v_max_out;
 	int h_max_out;
@@ -120,6 +120,7 @@
 	/* video capture */
 	struct saa7146_dmaqueue		video_q;
 	struct saa7146_fh		*streaming;
+	enum v4l2_field			last_field;
 
 	/* common: fixme? shouldn't this be in saa7146_fh?
 	   (this leads to a more complicated question: shall the driver
@@ -186,7 +187,7 @@
 void saa7146_buffer_timeout(unsigned long data);
 void saa7146_dma_free(struct saa7146_dev *dev,struct saa7146_buf *buf);
 
-int saa7146_vv_init(struct saa7146_dev* dev);
+int saa7146_vv_init(struct saa7146_dev* dev, struct saa7146_ext_vv *ext_vv);
 int saa7146_vv_release(struct saa7146_dev* dev);
 
 
@@ -215,35 +216,6 @@
 #define SAA7146_HPS_SYNC_PORT_A		0x00
 #define SAA7146_HPS_SYNC_PORT_B		0x01
 
-/* number of vertical active lines */
-#define V_ACTIVE_LINES_PAL	576
-#define V_ACTIVE_LINES_NTSC	480
-#define V_ACTIVE_LINES_SECAM	576
-
-/* number of lines in a field for HPS to process */
-#define V_FIELD_PAL	288
-#define V_FIELD_NTSC	240
-#define V_FIELD_SECAM	288
-
-/* number of lines of vertical offset before processing */
-#define V_OFFSET_PAL	0x17
-#define V_OFFSET_NTSC	0x16
-#define V_OFFSET_SECAM	0x14
-
-/* number of horizontal pixels to process */
-#define H_PIXELS_PAL	680
-#define H_PIXELS_NTSC	708
-#define H_PIXELS_SECAM	720
-
-/* horizontal offset of processing window */
-#define H_OFFSET_PAL	0x14
-#define H_OFFSET_NTSC	0x06
-#define H_OFFSET_SECAM	0x14
-
-#define SAA7146_PAL_VALUES 	V_OFFSET_PAL, V_FIELD_PAL, V_ACTIVE_LINES_PAL, H_OFFSET_PAL, H_PIXELS_PAL, H_PIXELS_PAL+1, V_ACTIVE_LINES_PAL, 768
-#define SAA7146_NTSC_VALUES	V_OFFSET_NTSC, V_FIELD_NTSC, V_ACTIVE_LINES_NTSC, H_OFFSET_NTSC, H_PIXELS_NTSC, H_PIXELS_NTSC+1, V_ACTIVE_LINES_NTSC, 640
-#define SAA7146_SECAM_VALUES	V_OFFSET_SECAM, V_FIELD_SECAM, V_ACTIVE_LINES_SECAM, H_OFFSET_SECAM, H_PIXELS_SECAM, H_PIXELS_SECAM+1, V_ACTIVE_LINES_SECAM, 768
-
 /* some memory sizes */
 #define SAA7146_CLIPPING_MEM	(14*PAGE_SIZE)
 

