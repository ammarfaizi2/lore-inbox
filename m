Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbTJIKsJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 06:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbTJIKsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 06:48:09 -0400
Received: from mail.convergence.de ([212.84.236.4]:41636 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S261967AbTJIKr4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 06:47:56 -0400
Subject: [PATCH 2/7] Fix vbi handling in saa7146 core driver
In-Reply-To: <10656964741655@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Thu, 9 Oct 2003 12:47:55 +0200
Message-Id: <10656964753877@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Michael Hunold (LinuxTV.org CVS maintainer) <hunold@linuxtv.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- [DVB] add some debug and safety checks for video/vbi capture buffer handling
- [DVB] add new flag SAA7146_USE_PORT_B_FOR_VBI, so we can distinguish on which video port to apply the vbi workaround
- [DVB] add del_timer(...) for vbi capture queue and vbi_read timers, prevents oopses on vbi usage
diff -uNrwB --new-file linux-2.6.0-test7/drivers/media/common/saa7146_fops.c linux-2.6.0-test7-patch/drivers/media/common/saa7146_fops.c
--- linux-2.6.0-test7/drivers/media/common/saa7146_fops.c	2003-10-09 10:40:19.000000000 +0200
+++ linux-2.6.0-test7-patch/drivers/media/common/saa7146_fops.c	2003-10-06 18:36:47.000000000 +0200
@@ -61,8 +61,14 @@
 	}
 
 	DEB_EE(("dev:%p, dmaq:%p, state:%d\n", dev, q, state));
+	DEB_EE(("q->curr:%p\n",q->curr));
 
 	/* finish current buffer */
+	if (NULL == q->curr) {
+		DEB_D(("aiii. no current buffer\n"));
+		return;	
+	}
+			
 	q->curr->vb.state = state;
 	do_gettimeofday(&q->curr->vb.ts);
 	wake_up(&q->curr->vb.done);
@@ -221,9 +227,12 @@
 	fh->dev = dev;
 	fh->type = type;
 
-	saa7146_video_uops.open(dev,fh);
-	if( 0 != BOARD_CAN_DO_VBI(dev) ) {
+	if( fh->type == V4L2_BUF_TYPE_VBI_CAPTURE) {
+		DEB_S(("initializing vbi...\n"));
 		saa7146_vbi_uops.open(dev,fh);
+	} else {
+		DEB_S(("initializing video...\n"));
+		saa7146_video_uops.open(dev,fh);
 	}
 
 	result = 0;
@@ -245,9 +254,10 @@
 	if (down_interruptible(&saa7146_devices_lock))
 		return -ERESTARTSYS;
 
-	saa7146_video_uops.release(dev,fh,file);
-	if( 0 != BOARD_CAN_DO_VBI(dev) ) {
+	if( fh->type == V4L2_BUF_TYPE_VBI_CAPTURE) {
 		saa7146_vbi_uops.release(dev,fh,file);
+	} else {
+		saa7146_video_uops.release(dev,fh,file);
 	}
 
 	module_put(dev->ext->module);
@@ -332,11 +342,11 @@
 
 	switch (fh->type) {
 	case V4L2_BUF_TYPE_VIDEO_CAPTURE: {
-		DEB_EE(("V4L2_BUF_TYPE_VIDEO_CAPTURE: file:%p, data:%p, count:%lun", file, data, (unsigned long)count));
+//		DEB_EE(("V4L2_BUF_TYPE_VIDEO_CAPTURE: file:%p, data:%p, count:%lun", file, data, (unsigned long)count));
 		return saa7146_video_uops.read(file,data,count,ppos);
 		}
 	case V4L2_BUF_TYPE_VBI_CAPTURE: {
-		DEB_EE(("V4L2_BUF_TYPE_VBI_CAPTURE: file:%p, data:%p, count:%lu\n", file, data, (unsigned long)count));
+//		DEB_EE(("V4L2_BUF_TYPE_VBI_CAPTURE: file:%p, data:%p, count:%lu\n", file, data, (unsigned long)count));
 		return saa7146_vbi_uops.read(file,data,count,ppos);
 		}
 		break;
@@ -443,7 +453,7 @@
 {
 	struct saa7146_vv *vv = dev->vv_data;
 
-	DEB_EE(("dev:%p, name:'%s'\n",dev,name));
+	DEB_EE(("dev:%p, name:'%s', type:%d\n",dev,name,type));
  
  	*vid = device_template;
 	strlcpy(vid->name, name, sizeof(vid->name));
@@ -451,7 +461,7 @@
 
 	// fixme: -1 should be an insmod parameter *for the extension* (like "video_nr");
 	if (video_register_device(vid,type,-1) < 0) {
-		ERR(("cannot register vbi v4l2 device. skipping.\n"));
+		ERR(("cannot register v4l2 device. skipping.\n"));
 		return -1;
 	}
 
diff -uNrwB --new-file linux-2.6.0-test7/drivers/media/common/saa7146_vbi.c linux-2.6.0-test7-patch/drivers/media/common/saa7146_vbi.c
--- linux-2.6.0-test7/drivers/media/common/saa7146_vbi.c	2003-10-09 10:40:19.000000000 +0200
+++ linux-2.6.0-test7-patch/drivers/media/common/saa7146_vbi.c	2003-10-06 18:45:08.000000000 +0200
@@ -38,8 +38,14 @@
 		WRITE_RPS1(CMD_WR_REG | (1 << 8) | (BRS_CTRL/4));
 		/* BXO = 1h, BRS to outbound */
 		WRITE_RPS1(0xc000008c);   
-		/* wait for vbi_a */
+	/* wait for vbi_a or vbi_b*/
+	if ( 0 != (SAA7146_USE_PORT_B_FOR_VBI & dev->ext_vv_data->flags)) {
+		DEB_D(("...using port b\n"));
+		WRITE_RPS1(CMD_PAUSE | MASK_09);
+	} else {
+		DEB_D(("...using port a\n"));
 		WRITE_RPS1(CMD_PAUSE | MASK_10);
+	}
 		/* upload brs */
 		WRITE_RPS1(CMD_UPLOAD | MASK_08);
 		/* load brs-control register */
@@ -106,7 +112,7 @@
 
 		if(signal_pending(current)) {
 		
-			DEB_VBI(("aborted.\n"));
+			DEB_VBI(("aborted (rps:0x%08x).\n",saa7146_read(dev,RPS_ADDR1)));
 
 			/* stop rps1 for sure */
 			saa7146_write(dev, MC1, MASK_29);
@@ -316,6 +322,11 @@
 	saa7146_write(dev, MC1, MASK_20);
 
 	vv->vbi_streaming = NULL;
+
+	del_timer(&vv->vbi_q.timeout);
+	del_timer(&fh->vbi_read_timeout);
+
+	DEB_VBI(("out\n"));
 	spin_unlock_irqrestore(&dev->slock, flags);
 }
 
@@ -371,7 +382,10 @@
 	fh->vbi_read_timeout.function = vbi_read_timeout;
 	fh->vbi_read_timeout.data = (unsigned long)fh;
 
+	/* fixme: enable this again, if the dvb-c w/ analog module work properly */
+/*
 	vbi_workaround(dev);
+*/
 }
 
 static void vbi_close(struct saa7146_dev *dev, struct saa7146_fh *fh, struct file *file)
diff -uNrwB --new-file linux-2.6.0-test7/drivers/media/common/saa7146_video.c linux-2.6.0-test7-patch/drivers/media/common/saa7146_video.c
--- linux-2.6.0-test7/drivers/media/common/saa7146_video.c	2003-10-09 10:40:19.000000000 +0200
+++ linux-2.6.0-test7-patch/drivers/media/common/saa7146_video.c	2003-09-30 19:15:11.000000000 +0200
@@ -1319,7 +1318,7 @@
 			saa7146_pgtable_alloc(dev->pci, &buf->pt[0]);
 		}
 		
-		err = videobuf_iolock(dev->pci,&buf->vb,NULL);
+		err = videobuf_iolock(dev->pci,&buf->vb, &vv->ov_fb);
 		if (err)
 			goto oops;
 		err = saa7146_pgtable_build(dev,buf);
diff -uNrwB --new-file linux-2.6.0-test7/include/media/saa7146_vv.h linux-2.6.0-test7-patch/include/media/saa7146_vv.h
--- linux-2.6.0-test7/include/media/saa7146_vv.h	2003-10-09 10:40:54.000000000 +0200
+++ linux-2.6.0-test7-patch/include/media/saa7146_vv.h	2003-10-06 16:54:55.000000000 +0200
@@ -150,6 +150,7 @@
 
 /* flags */
 #define SAA7146_EXT_SWAP_ODD_EVEN       0x1     /* needs odd/even fields swapped */
+#define SAA7146_USE_PORT_B_FOR_VBI	0x2     /* use input port b for vbi hardware bug workaround */
 
 struct saa7146_ext_vv
 {

