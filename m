Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261897AbUDZNmq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbUDZNmq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 09:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263843AbUDZNmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 09:42:46 -0400
Received: from mail.convergence.de ([212.84.236.4]:32899 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S261897AbUDZNkn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 09:40:43 -0400
To: hunold@linuxtv.org, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
From: Michael Hunold <hunold@linuxtv.org>
Subject: [PATCH 1/9] V4L: Update the saa7146 driver
In-Reply-To: <10829866543802@convergence.de>
Message-Id: <10829866821854@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring_mihu_extended
Date: Mon, 26 Apr 2004 09:40:43 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- [DVB] saa7146 driver updates:
   - remove bogus v_calc and h_calc parameters, which can be easily retrieved from other values
   - add class parameter to i2c initialization
   - let resource handling provide more useful informations
   - sanitize overlay/capture locking
diff -urawBN xx-linux-2.6.5/drivers/media/common/saa7146_fops.c linux-2.6.5-patched/drivers/media/common/saa7146_fops.c
--- xx-linux-2.6.5/drivers/media/common/saa7146_fops.c	2004-02-22 14:48:47.000000000 +0100
+++ linux-2.6.5-patched/drivers/media/common/saa7146_fops.c	2004-03-11 11:58:36.000000000 +0100
@@ -10,14 +10,14 @@
 	struct saa7146_dev *dev = fh->dev;
 	struct saa7146_vv *vv = dev->vv_data;
 
-	if (fh->resources & bit)
+	if (fh->resources & bit) {
+		DEB_D(("already allocated! want: 0x%02x, cur:0x%02x\n",bit,vv->resources));
 		/* have it already allocated */
 		return 1;
+	}
 
 	/* is it free? */
-	DEB_D(("getting lock...\n"));
 	down(&dev->lock);
-	DEB_D(("got lock\n"));
 	if (vv->resources & bit) {
 		DEB_D(("locked! vv->resources:0x%02x, we want:0x%02x\n",vv->resources,bit));
 		/* no, someone else uses it */
@@ -27,7 +27,7 @@
 	/* it's free, grab it */
 	fh->resources  |= bit;
 	vv->resources |= bit;
-	DEB_D(("res: get %d\n",bit));
+	DEB_D(("res: get 0x%02x, cur:0x%02x\n",bit,vv->resources));
 	up(&dev->lock);
 	return 1;
 }
@@ -51,12 +51,10 @@
 	if ((fh->resources & bits) != bits)
 		BUG();
 
-	DEB_D(("getting lock...\n"));
 	down(&dev->lock);
-	DEB_D(("got lock\n"));
 	fh->resources  &= ~bits;
 	vv->resources &= ~bits;
-	DEB_D(("res: put %d\n",bits));
+	DEB_D(("res: put 0x%02x, cur:0x%02x\n",bits,vv->resources));
 	up(&dev->lock);
 }
 
diff -urawBN xx-linux-2.6.5/drivers/media/common/saa7146_hlp.c linux-2.6.5-patched/drivers/media/common/saa7146_hlp.c
--- xx-linux-2.6.5/drivers/media/common/saa7146_hlp.c	2004-02-22 14:48:47.000000000 +0100
+++ linux-2.6.5-patched/drivers/media/common/saa7146_hlp.c	2004-03-15 20:38:14.000000000 +0100
@@ -536,13 +536,13 @@
 	/* set vertical scale */
 	hps_v_scale = 0; /* all bits get set by the function-call */
 	hps_v_gain  = 0; /* fixme: saa7146_read(dev, HPS_V_GAIN);*/ 
-	calculate_v_scale_registers(dev, field, vv->standard->v_calc, height, &hps_v_scale, &hps_v_gain);
+	calculate_v_scale_registers(dev, field, vv->standard->v_field*2, height, &hps_v_scale, &hps_v_gain);
 
 	/* set horizontal scale */
 	hps_ctrl 	= 0;
 	hps_h_prescale	= 0; /* all bits get set in the function */
 	hps_h_scale	= 0;
-	calculate_h_scale_registers(dev, vv->standard->h_calc, width, vv->hflip, &hps_ctrl, &hps_v_gain, &hps_h_prescale, &hps_h_scale);
+	calculate_h_scale_registers(dev, vv->standard->h_pixels, width, vv->hflip, &hps_ctrl, &hps_v_gain, &hps_h_prescale, &hps_h_scale);
 
 	/* set hyo and hxo */
 	calculate_hxo_and_hyo(vv, &hps_h_scale, &hps_ctrl);
diff -urawBN xx-linux-2.6.5/drivers/media/common/saa7146_i2c.c linux-2.6.5-patched/drivers/media/common/saa7146_i2c.c
--- xx-linux-2.6.5/drivers/media/common/saa7146_i2c.c	2004-01-16 18:25:17.000000000 +0100
+++ linux-2.6.5-patched/drivers/media/common/saa7146_i2c.c	2004-04-06 15:05:23.000000000 +0200
@@ -400,7 +400,7 @@
 	.functionality	= saa7146_i2c_func,
 };
 
-int saa7146_i2c_adapter_prepare(struct saa7146_dev *dev, struct i2c_adapter *i2c_adapter, u32 bitrate)
+int saa7146_i2c_adapter_prepare(struct saa7146_dev *dev, struct i2c_adapter *i2c_adapter, unsigned int class, u32 bitrate)
 {
 	DEB_EE(("bitrate: 0x%08x\n",bitrate));
 	
@@ -417,16 +417,13 @@
 		i2c_adapter->data = dev;
 #else
 		i2c_set_adapdata(i2c_adapter,dev);
+		i2c_adapter->class = class;
 #endif
 		i2c_adapter->algo	   = &saa7146_algo;
 		i2c_adapter->algo_data     = NULL;
 		i2c_adapter->id 	   = I2C_ALGO_SAA7146;
 		i2c_adapter->timeout = SAA7146_I2C_TIMEOUT;
 		i2c_adapter->retries = SAA7146_I2C_RETRIES;
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0))
-#else
-		i2c_adapter->class = I2C_ADAP_CLASS_TV_ANALOG;
-#endif
 	}
 	
 	return 0;
diff -urawBN xx-linux-2.6.5/drivers/media/common/saa7146_video.c linux-2.6.5-patched/drivers/media/common/saa7146_video.c
--- xx-linux-2.6.5/drivers/media/common/saa7146_video.c	2004-03-12 20:31:28.000000000 +0100
+++ linux-2.6.5-patched/drivers/media/common/saa7146_video.c	2004-03-19 15:15:04.000000000 +0100
@@ -5,6 +5,12 @@
 MODULE_PARM(memory,"i");
 MODULE_PARM_DESC(memory, "maximum memory usage for capture buffers (default: 32Mb)");
 
+#define IS_CAPTURE_ACTIVE(fh) \
+	(((vv->video_status & STATUS_CAPTURE) != 0) && (vv->video_fh == fh))
+
+#define IS_OVERLAY_ACTIVE(fh) \
+	(((vv->video_status & STATUS_OVERLAY) != 0) && (vv->video_fh == fh))
+
 /* format descriptions for capture and preview */
 static struct saa7146_format formats[] = {
 	{
@@ -260,24 +266,31 @@
 		return -EAGAIN;
 	}
 
-	/* check if overlay is running */
-	if( 0 != vv->ov_data ) {
-		if( fh != vv->ov_data->fh ) {
-			DEB_D(("overlay is running in another open.\n"));
-			return -EAGAIN;
+	/* check if streaming capture is running */
+	if (IS_CAPTURE_ACTIVE(fh) != 0) {
+		DEB_D(("streaming capture is active.\n"));
+		return -EBUSY;
 		}
+
+	/* check if overlay is running */
+	if (IS_OVERLAY_ACTIVE(fh) != 0) {		
+		if (vv->video_fh == fh) {
 		DEB_D(("overlay is already active.\n"));
 		return 0;
 	}
+		DEB_D(("overlay is already active in another open.\n"));
+		return -EBUSY;
+	}
 	
-	if( 0 != vv->streaming ) {
-		DEB_D(("streaming capture is active.\n"));
+	if (0 == saa7146_res_get(fh, RESOURCE_DMA1_HPS|RESOURCE_DMA2_CLP)) {
+		DEB_D(("cannot get necessary overlay resources\n"));
 		return -EBUSY;
 	}	
 	
 	err = try_win(dev,&fh->ov.win);
 	if (0 != err) {
-		return err;
+		saa7146_res_free(vv->video_fh, RESOURCE_DMA1_HPS|RESOURCE_DMA2_CLP);
+		return -EBUSY;
 	}
 	
 	vv->ov_data = &fh->ov;
@@ -288,11 +301,14 @@
 		vv->ov_fmt->name,v4l2_field_names[fh->ov.win.field]));
 	
 	if (0 != (ret = saa7146_enable_overlay(fh))) {
-		vv->ov_data = NULL;
 		DEB_D(("enabling overlay failed: %d\n",ret));
+		saa7146_res_free(vv->video_fh, RESOURCE_DMA1_HPS|RESOURCE_DMA2_CLP);
 		return ret;
 	}
 
+	vv->video_status = STATUS_OVERLAY;
+	vv->video_fh = fh;
+
 	return 0;
 }
 
@@ -303,20 +319,30 @@
 
 	DEB_EE(("dev:%p, fh:%p\n",dev,fh));
 
-	/* check if overlay is running */
-	if( 0 == vv->ov_data ) {
-		DEB_D(("overlay is not active.\n"));
-		return 0;
+	/* check if streaming capture is running */
+	if (IS_CAPTURE_ACTIVE(fh) != 0) {
+		DEB_D(("streaming capture is active.\n"));
+		return -EBUSY;
 	}
 
-	if( fh != vv->ov_data->fh ) {
-		DEB_D(("overlay is active, but for another open.\n"));
+	/* check if overlay is running at all */
+	if ((vv->video_status & STATUS_OVERLAY) == 0) {		
+		DEB_D(("no active overlay.\n"));
 		return 0;
 	}
 
-	vv->ov_data = NULL;
+	if (vv->video_fh != fh) {
+		DEB_D(("overlay is active, but in another open.\n"));
+		return -EBUSY;
+	}
+
+	vv->video_status = 0;
+	vv->video_fh = NULL;
+
 	saa7146_disable_overlay(fh);
 	
+	saa7146_res_free(fh, RESOURCE_DMA1_HPS|RESOURCE_DMA2_CLP);
+
 	return 0;
 }
 
@@ -325,15 +351,14 @@
 	struct saa7146_dev *dev = fh->dev;
 	struct saa7146_vv *vv = dev->vv_data;
 
-	unsigned long flags;
 	int err;
 	
 	switch (f->type) {
 	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
 		DEB_EE(("V4L2_BUF_TYPE_VIDEO_CAPTURE: dev:%p, fh:%p\n",dev,fh));
-		if( fh == vv->streaming ) {
-			DEB_EE(("streaming capture is active"));
-			return -EAGAIN;
+		if (IS_CAPTURE_ACTIVE(fh) != 0) {
+			DEB_EE(("streaming capture is active\n"));
+			return -EBUSY;
 		}
 		err = try_fmt(fh,f);
 		if (0 != err)
@@ -359,16 +384,13 @@
 		/* fh->ov.fh is used to indicate that we have valid overlay informations, too */
 		fh->ov.fh = fh;
 
-		/* check if we have an active overlay */
-		if( vv->ov_data != NULL ) {
-			if( fh == vv->ov_data->fh) {
-				spin_lock_irqsave(&dev->slock,flags);
+		up(&dev->lock);
+
+		/* check if our current overlay is active */
+		if (IS_OVERLAY_ACTIVE(fh) != 0) {
 				saa7146_stop_preview(fh);
 				saa7146_start_preview(fh);
-				spin_unlock_irqrestore(&dev->slock,flags);
-			}
 		}
-		up(&dev->lock);
 		return 0;
 	default:
 		DEB_D(("unknown format type '%d'\n",f->type));
@@ -480,8 +502,6 @@
 	struct saa7146_vv *vv = dev->vv_data;
 
 	const struct v4l2_queryctrl* ctrl;
-	unsigned long flags;
-	int restart_overlay = 0;
 
 	ctrl = ctrl_by_id(c->id);
 	if (NULL == ctrl) {
@@ -489,6 +509,8 @@
 		return -EINVAL;
 	}
 	
+	down(&dev->lock);
+
 	switch (ctrl->type) {
 	case V4L2_CTRL_TYPE_BOOLEAN:
 	case V4L2_CTRL_TYPE_MENU:
@@ -528,35 +550,31 @@
 		break;
 	}
 	case V4L2_CID_HFLIP:
-		/* fixme: we can supfhrt changing VFLIP and HFLIP here... */
-		if( 0 != vv->streaming ) {
+		/* fixme: we can support changing VFLIP and HFLIP here... */
+		if (IS_CAPTURE_ACTIVE(fh) != 0) {
 			DEB_D(("V4L2_CID_HFLIP while active capture.\n"));
+			up(&dev->lock);
 			return -EINVAL;
 		}
 		vv->hflip = c->value;
-		restart_overlay = 1;
 		break;
 	case V4L2_CID_VFLIP:
-		if( 0 != vv->streaming ) {
+		if (IS_CAPTURE_ACTIVE(fh) != 0) {
 			DEB_D(("V4L2_CID_VFLIP while active capture.\n"));
+			up(&dev->lock);
 			return -EINVAL;
 		}
 		vv->vflip = c->value;
-		restart_overlay = 1;
 		break;
 	default: {
 		return -EINVAL;
 	}
 	}
-	if( 0 != restart_overlay ) {
-		if( 0 != vv->ov_data ) {
-			if( fh == vv->ov_data->fh ) {
-				spin_lock_irqsave(&dev->slock,flags);
+	up(&dev->lock);
+	
+	if (IS_OVERLAY_ACTIVE(fh) != 0) {
 				saa7146_stop_preview(fh);
 				saa7146_start_preview(fh);
-				spin_unlock_irqrestore(&dev->slock,flags);
-			}
-		}
 	}
 	return 0;
 }
@@ -687,21 +705,30 @@
 	struct saa7146_dev *dev = fh->dev;
 	struct saa7146_vv *vv = dev->vv_data;
 	struct saa7146_format *fmt = NULL;
-	unsigned long flags;
 	unsigned int resource;
-	int ret = 0;
+	int ret = 0, err = 0;
 
 	DEB_EE(("dev:%p, fh:%p\n",dev,fh));
 
-	if( fh == vv->streaming ) {
+	if ((vv->video_status & STATUS_CAPTURE) != 0) {
+		if (vv->video_fh == fh) {
 		DEB_S(("already capturing.\n"));
-		return -EBUSY;
+			return 0;
 	}
-	if( vv->streaming != 0 ) {
-		DEB_S(("already capturing, but in another open.\n"));
+		DEB_S(("already capturing in another open.\n"));
 		return -EBUSY;
 	}
 
+	if ((vv->video_status & STATUS_OVERLAY) != 0) {
+		DEB_S(("warning: suspending overlay video for streaming capture.\n"));
+		vv->ov_suspend = vv->video_fh;
+		err = saa7146_stop_preview(vv->video_fh); /* side effect: video_status is now 0, video_fh is NULL */
+		if (0 != err) {
+			DEB_D(("suspending video failed. aborting\n"));
+			return err;
+		}
+	}
+	
 	fmt = format_by_fourcc(dev,fh->video_fmt.pixelformat);
 	/* we need to have a valid format set here */
 	BUG_ON(NULL == fmt);
@@ -715,19 +742,22 @@
 	ret = saa7146_res_get(fh, resource);
 	if (0 == ret) {
 		DEB_S(("cannot get capture resource %d\n",resource));
+		if (vv->ov_suspend != NULL) {
+			saa7146_start_preview(vv->ov_suspend);
+			vv->ov_suspend = NULL;
+		}
 		return -EBUSY;
 	}
 
-	spin_lock_irqsave(&dev->slock,flags);
-
 	/* clear out beginning of streaming bit (rps register 0)*/
 	saa7146_write(dev, MC2, MASK_27 );
 
 	/* enable rps0 irqs */
 	IER_ENABLE(dev, MASK_27);
 
-	vv->streaming = fh;
-	spin_unlock_irqrestore(&dev->slock,flags);
+	vv->video_fh = fh;
+	vv->video_status = STATUS_CAPTURE;
+
 	return 0;
 }
 
@@ -741,9 +771,14 @@
 	u32 dmas = 0;
 	DEB_EE(("dev:%p, fh:%p\n",dev,fh));
 
-	if( vv->streaming != fh ) {
+	if ((vv->video_status & STATUS_CAPTURE) != STATUS_CAPTURE) {
 		DEB_S(("not capturing.\n"));
-		return -EINVAL;
+		return 0;
+	}
+
+	if (vv->video_fh != fh) {
+		DEB_S(("capturing, but in another open.\n"));
+		return -EBUSY;
 	}
 
 	fmt = format_by_fourcc(dev,fh->video_fmt.pixelformat);
@@ -757,8 +792,6 @@
 		resource = RESOURCE_DMA1_HPS;
 		dmas = MASK_22;
 	}
-	saa7146_res_free(fh, resource);
-
 	spin_lock_irqsave(&dev->slock,flags);
 
 	/* disable rps0  */
@@ -770,13 +803,20 @@
 	/* shut down all used video dma transfers */
 	saa7146_write(dev, MC1, dmas);
 
-	vv->streaming = NULL;
-
 	spin_unlock_irqrestore(&dev->slock, flags);
 	
-	return 0;
+	vv->video_fh = NULL;
+	vv->video_status = 0;
+
+	saa7146_res_free(fh, resource);
+
+	if (vv->ov_suspend != NULL) {
+		saa7146_start_preview(vv->ov_suspend);
+		vv->ov_suspend = NULL;
 }
 
+	return 0;
+}
 
 /*
  * This function is _not_ called directly, but from
@@ -790,7 +830,6 @@
 	struct saa7146_dev *dev = fh->dev;
 	struct saa7146_vv *vv = dev->vv_data;
 
-	unsigned long flags;
 	int err = 0, result = 0, ee = 0;
 
 	struct saa7146_use_ops *ops;
@@ -867,17 +906,12 @@
 	{
 		struct v4l2_framebuffer *fb = arg;
 		struct saa7146_format *fmt;
-		struct saa7146_fh *ov_fh = NULL;
-		int restart_overlay = 0;
 
 		DEB_EE(("VIDIOC_S_FBUF\n"));
 
-/*
-		if(!capable(CAP_SYS_ADMIN)) { // && !capable(CAP_SYS_RAWIO)) {
-			DEB_D(("VIDIOC_S_FBUF: not CAP_SYS_ADMIN or CAP_SYS_RAWIO.\n"));
+		if(!capable(CAP_SYS_ADMIN) &&
+		   !capable(CAP_SYS_RAWIO))
 			return -EPERM;
-		}
-*/
 
 		/* check args */
 		fmt = format_by_fourcc(dev,fb->fmt.pixelformat);
@@ -890,12 +924,15 @@
 			DEB_S(("planar pixelformat '%4.4s' not allowed for overlay\n",(char *)&fmt->pixelformat));
 		}
 
-		down(&dev->lock);
-		if( vv->ov_data != NULL ) {
-			ov_fh = vv->ov_data->fh;
-			saa7146_stop_preview(ov_fh);
-			restart_overlay = 1;
+		/* check if overlay is running */
+		if (IS_OVERLAY_ACTIVE(fh) != 0) {		
+			if (vv->video_fh != fh) {
+				DEB_D(("refusing to change framebuffer informations while overlay is active in another open.\n"));
+				return -EBUSY;
 		}
+		}
+
+		down(&dev->lock);
 
 		/* ok, accept it */
 		vv->ov_fb = *fb;
@@ -904,10 +941,6 @@
 			vv->ov_fb.fmt.bytesperline =
 				vv->ov_fb.fmt.width*fmt->depth/8;
 
-		if( 0 != restart_overlay ) {
-			saa7146_start_preview(ov_fh);
-		}
-
 		up(&dev->lock);
 
 		return 0;
@@ -966,11 +999,13 @@
 		return get_control(fh,arg);
 	}
 	case VIDIOC_S_CTRL:
+
+
+
+
 	{
 		DEB_EE(("VIDIOC_S_CTRL\n"));
-		down(&dev->lock);
 		err = set_control(fh,arg);
-		up(&dev->lock);
 		return err;
 	}
         case VIDIOC_G_PARM:
@@ -1029,29 +1064,27 @@
 	case VIDIOC_S_STD:
 	{
 		v4l2_std_id *id = arg;
-		int i;
-		
-		int restart_overlay = 0;
 		int found = 0;
-		
-		struct saa7146_fh *ov_fh = NULL;
+		int i, err;
 						
 		DEB_EE(("VIDIOC_S_STD\n"));
 
-		if( 0 != vv->streaming ) {
+		if ((vv->video_status & STATUS_CAPTURE) == STATUS_CAPTURE) {
+			DEB_D(("cannot change video standard while streaming capture is active\n"));
 			return -EBUSY;
 		}
 
-		DEB_D(("before getting lock...\n"));
-		down(&dev->lock);
-		DEB_D(("got lock\n"));
-
-		if( vv->ov_data != NULL ) {
-			ov_fh = vv->ov_data->fh;
-			saa7146_stop_preview(ov_fh);
-			restart_overlay = 1;
+		if ((vv->video_status & STATUS_OVERLAY) != 0) {
+			vv->ov_suspend = vv->video_fh;
+			err = saa7146_stop_preview(vv->video_fh); /* side effect: video_status is now 0, video_fh is NULL */
+			if (0 != err) {
+				DEB_D(("suspending video failed. aborting\n"));
+				return err;
+			}
 		}
 
+		down(&dev->lock);
+		
 		for(i = 0; i < dev->ext_vv_data->num_stds; i++)
 			if (*id & dev->ext_vv_data->stds[i].id)
 				break;
@@ -1062,11 +1095,13 @@
 			found = 1;
 		}
 
-		if( 0 != restart_overlay ) {
-			saa7146_start_preview(ov_fh);
-		}
 		up(&dev->lock);
 
+		if (vv->ov_suspend != NULL) {
+			saa7146_start_preview(vv->ov_suspend);
+			vv->ov_suspend = NULL;
+		}
+
 		if( 0 == found ) {
 			DEB_EE(("VIDIOC_S_STD: standard not found.\n"));
 			return -EINVAL;
@@ -1076,49 +1111,20 @@
 		return 0;
 	}
 	case VIDIOC_OVERLAY:
+
+
+
+
 	{
 		int on = *(int *)arg;
 		int err = 0;
 
-		if( NULL == vv->ov_fmt && on != 0 ) {
-			DEB_D(("VIDIOC_OVERLAY: no framebuffer informations. call S_FBUF first!\n"));
-			return -EAGAIN;
-		}
-
 		DEB_D(("VIDIOC_OVERLAY on:%d\n",on));
-		if( 0 != on ) {
-			if( vv->ov_data != NULL ) {
-				if( fh != vv->ov_data->fh) {
-					DEB_D(("overlay already active in another open\n"));
-					return -EAGAIN;
-				}
-			}
-
-			if (0 == saa7146_res_get(fh, RESOURCE_DMA1_HPS|RESOURCE_DMA2_CLP)) {
-				DEB_D(("cannot get overlay resources\n"));
-				return -EBUSY;
-			}
-
-			spin_lock_irqsave(&dev->slock,flags);
+		if (on != 0) {
 			err = saa7146_start_preview(fh);
-			spin_unlock_irqrestore(&dev->slock,flags);
-			return err;
-		}
-
-			if( vv->ov_data != NULL ) {
-				if( fh != vv->ov_data->fh) {
-				DEB_D(("overlay is active, but in another open\n"));
-					return -EAGAIN;
-				}
 		} else {
-			DEB_D(("overlay is not active\n"));
-			return 0;		
-			}
-			spin_lock_irqsave(&dev->slock,flags);
 			err = saa7146_stop_preview(fh);
-			spin_unlock_irqrestore(&dev->slock,flags);
-		/* free resources */
-		saa7146_res_free(fh, RESOURCE_DMA1_HPS|RESOURCE_DMA2_CLP);
+		}
 		return err;
 	}
 	case VIDIOC_REQBUFS: {
@@ -1149,11 +1155,6 @@
 		int *type = arg;
 		DEB_D(("VIDIOC_STREAMON, type:%d\n",*type));
 
-		if( fh == vv->streaming ) {
-			DEB_D(("already capturing.\n"));
-			return 0;
-		}
-
 		err = video_begin(fh);
 		if( 0 != err) {
 				return err;
@@ -1166,13 +1167,26 @@
 
 		DEB_D(("VIDIOC_STREAMOFF, type:%d\n",*type));
 
-		if( fh != vv->streaming ) {
-			DEB_D(("this open is not capturing.\n"));
-			return -EINVAL;
+		/* ugly: we need to copy some checks from video_end(),
+		   because videobuf_streamoff() relies on the capture running.
+		   check and fix this */
+		if ((vv->video_status & STATUS_CAPTURE) != STATUS_CAPTURE) {
+			DEB_S(("not capturing.\n"));
+			return 0;
+		}
+
+		if (vv->video_fh != fh) {
+			DEB_S(("capturing, but in another open.\n"));
+			return -EBUSY;
 		}
 
 		err = videobuf_streamoff(file,q);
+		if (0 != err) {
+			DEB_D(("warning: videobuf_streamoff() failed.\n"));
 		video_end(fh, file);
+		} else {
+			err = video_end(fh, file);
+		}
 		return err;
 	}
 	case VIDIOCGMBUF:
@@ -1406,20 +1420,16 @@
 {
 	struct saa7146_fh *fh = (struct saa7146_fh *)file->private_data;
 	struct saa7146_vv *vv = dev->vv_data;
-	unsigned long flags;
+	int err;
 	
-	if( 0 != vv->ov_data ) {
-		if( fh == vv->ov_data->fh ) {
-			spin_lock_irqsave(&dev->slock,flags);
-			saa7146_stop_preview(fh);
-			spin_unlock_irqrestore(&dev->slock,flags);
-			saa7146_res_free(fh, RESOURCE_DMA1_HPS|RESOURCE_DMA2_CLP);
-		}
+	if (IS_CAPTURE_ACTIVE(fh) != 0) {
+		err = video_end(fh, file);		
+	} else if (IS_OVERLAY_ACTIVE(fh) != 0) {
+		err = saa7146_stop_preview(fh);
 	}
 	
-	if( fh == vv->streaming ) {
-		video_end(fh, file);		
-	}
+	/* hmm, why is this function declared void? */
+	/* return err */
 }
 
 
@@ -1447,23 +1457,16 @@
 	struct saa7146_vv *vv = dev->vv_data;
 	ssize_t ret = 0;
 
-	int restart_overlay = 0;
-	struct saa7146_fh *ov_fh = NULL;
-
 	DEB_EE(("called.\n"));
 
+	if ((vv->video_status & STATUS_CAPTURE) != 0) {
 	/* fixme: should we allow read() captures while streaming capture? */
-	if( 0 != vv->streaming ) {
+		if (vv->video_fh == fh) {
 		DEB_S(("already capturing.\n"));
 		return -EBUSY;
 	}
-
-	/* stop any active overlay */
-	if( vv->ov_data != NULL ) {
-		ov_fh = vv->ov_data->fh;
-		saa7146_stop_preview(ov_fh);
-		saa7146_res_free(ov_fh, RESOURCE_DMA1_HPS|RESOURCE_DMA2_CLP);
-		restart_overlay = 1;
+		DEB_S(("already capturing in another open.\n"));
+		return -EBUSY;
 	}
 
 	ret = video_begin(fh);
@@ -1472,16 +1475,16 @@
 	}
 
 	ret = videobuf_read_one(file,&fh->video_q , data, count, ppos);
+	if (ret != 0) {
 	video_end(fh, file);
-
+	} else {
+		ret = video_end(fh, file);
+	}
 out:
 	/* restart overlay if it was active before */
-	if( 0 != restart_overlay ) {
-		if (0 == saa7146_res_get(ov_fh, RESOURCE_DMA1_HPS|RESOURCE_DMA2_CLP)) {
-			DEB_D(("cannot get overlay resources again!\n"));
-			BUG();
-		}
-		saa7146_start_preview(ov_fh);
+	if (vv->ov_suspend != NULL) {
+		saa7146_start_preview(vv->ov_suspend);
+		vv->ov_suspend = NULL;
 	}
 	
 	return ret;
diff -urawBN xx-linux-2.6.5/include/media/saa7146.h linux-2.6.5-patched/include/media/saa7146.h
--- xx-linux-2.6.5/include/media/saa7146.h	2004-02-22 14:49:05.000000000 +0100
+++ linux-2.6.5-patched/include/media/saa7146.h	2004-04-23 22:07:10.000000000 +0200
@@ -154,7 +166,7 @@
 };
 
 /* from saa7146_i2c.c */
-int saa7146_i2c_adapter_prepare(struct saa7146_dev *dev, struct i2c_adapter *i2c_adapter, u32 bitrate);
+int saa7146_i2c_adapter_prepare(struct saa7146_dev *dev, struct i2c_adapter *i2c_adapter, unsigned int class, u32 bitrate);
 int saa7146_i2c_transfer(struct saa7146_dev *saa, const struct i2c_msg msgs[], int num,  int retries);
 
 /* from saa7146_core.c */
diff -urawBN xx-linux-2.6.5/include/media/saa7146_vv.h linux-2.6.5-patched/include/media/saa7146_vv.h
--- xx-linux-2.6.5/include/media/saa7146_vv.h	2004-02-22 14:49:05.000000000 +0100
+++ linux-2.6.5-patched/include/media/saa7146_vv.h	2004-03-15 20:38:16.000000000 +0100
@@ -44,11 +44,9 @@
 
 	int v_offset;	/* number of lines of vertical offset before processing */
 	int v_field;	/* number of lines in a field for HPS to process */
-	int v_calc;	/* number of vertical active lines */
 	
 	int h_offset;	/* horizontal offset of processing window */
 	int h_pixels;	/* number of horizontal pixels to process */
-	int h_calc;	/* number of horizontal active pixels */
 	
 	int v_max_out;
 	int h_max_out;
@@ -104,6 +102,9 @@
 	unsigned int resources;	/* resource management for device open */
 };
 
+#define STATUS_OVERLAY	0x01
+#define STATUS_CAPTURE	0x02
+
 struct saa7146_vv
 {
 	int vbi_minor;
@@ -117,14 +118,17 @@
 
 	int video_minor;
 
+	int				video_status;
+	struct saa7146_fh		*video_fh;
+
 	/* video overlay */
 	struct v4l2_framebuffer		ov_fb;
 	struct saa7146_format		*ov_fmt;
 	struct saa7146_overlay		*ov_data;
+	struct saa7146_fh		*ov_suspend;
 
 	/* video capture */
 	struct saa7146_dmaqueue		video_q;
-	struct saa7146_fh		*streaming;
 	enum v4l2_field			last_field;
 
 	/* common: fixme? shouldn't this be in saa7146_fh?


