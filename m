Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261816AbUKHJE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261816AbUKHJE3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 04:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261811AbUKHJEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 04:04:16 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:17630 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261790AbUKHJAN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 04:00:13 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 8 Nov 2004 09:52:05 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch 3/6] v4l: bttv update
Message-ID: <20041108085205.GA19228@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an update for the bttv driver, changes:

  * adapt to video-buf changes.
  * convert to new-style insmod options.
  * drop some obsolete junk.

Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
---
 drivers/media/video/btcx-risc.c   |    4 
 drivers/media/video/bttv-cards.c  |   95 ++++------------------
 drivers/media/video/bttv-driver.c |  128 +++++++++++++-----------------
 drivers/media/video/bttv-gpio.c   |    2 
 drivers/media/video/bttv-i2c.c    |   25 +----
 drivers/media/video/bttv-vbi.c    |   29 +++---
 drivers/media/video/bttvp.h       |    2 
 7 files changed, 102 insertions(+), 183 deletions(-)

Index: linux-2004-11-05/drivers/media/video/bttvp.h
===================================================================
--- linux-2004-11-05.orig/drivers/media/video/bttvp.h	2004-11-07 12:22:22.000000000 +0100
+++ linux-2004-11-05/drivers/media/video/bttvp.h	2004-11-07 15:48:56.346415509 +0100
@@ -1,5 +1,5 @@
 /*
-    $Id: bttvp.h,v 1.11 2004/10/13 10:39:00 kraxel Exp $
+    $Id: bttvp.h,v 1.12 2004/10/25 11:26:36 kraxel Exp $
 
     bttv - Bt848 frame grabber driver
 
Index: linux-2004-11-05/drivers/media/video/bttv-driver.c
===================================================================
--- linux-2004-11-05.orig/drivers/media/video/bttv-driver.c	2004-11-07 12:23:40.335424510 +0100
+++ linux-2004-11-05/drivers/media/video/bttv-driver.c	2004-11-07 15:49:20.830810017 +0100
@@ -1,6 +1,5 @@
-
 /*
-    $Id: bttv-driver.c,v 1.23 2004/10/13 10:39:00 kraxel Exp $
+    $Id: bttv-driver.c,v 1.27 2004/11/07 14:44:59 kraxel Exp $
 
     bttv - Bt848 frame grabber driver
 
@@ -78,53 +77,52 @@ static unsigned int vcr_hack    = 0;
 static unsigned int irq_iswitch = 0;
 
 /* API features (turn on/off stuff for testing) */
-static unsigned int v4l2       = 1;
+static unsigned int v4l2        = 1;
 
 
 /* insmod args */
-MODULE_PARM(radio,"1-" __stringify(BTTV_MAX) "i");
+module_param(bttv_verbose,      int, 0644);
+module_param(bttv_gpio,         int, 0644);
+module_param(bttv_debug,        int, 0644);
+module_param(irq_debug,         int, 0644);
+module_param(debug_latency,     int, 0644);
+
+module_param(fdsr,              int, 0444);
+module_param(video_nr,          int, 0444);
+module_param(radio_nr,          int, 0444);
+module_param(vbi_nr,            int, 0444);
+module_param(gbuffers,          int, 0444);
+module_param(gbufsize,          int, 0444);
+
+module_param(v4l2,              int, 0644);
+module_param(bigendian,         int, 0644);
+module_param(irq_iswitch,       int, 0644);
+module_param(combfilter,        int, 0444);
+module_param(lumafilter,        int, 0444);
+module_param(automute,          int, 0444);
+module_param(chroma_agc,        int, 0444);
+module_param(adc_crush,         int, 0444);
+module_param(whitecrush_upper,  int, 0444);
+module_param(whitecrush_lower,  int, 0444);
+module_param(vcr_hack,          int, 0444);
+module_param_array(radio, int, NULL, 0444);
+
 MODULE_PARM_DESC(radio,"The TV card supports radio, default is 0 (no)");
-MODULE_PARM(bigendian,"i");
 MODULE_PARM_DESC(bigendian,"byte order of the framebuffer, default is native endian");
-MODULE_PARM(bttv_verbose,"i");
 MODULE_PARM_DESC(bttv_verbose,"verbose startup messages, default is 1 (yes)");
-MODULE_PARM(bttv_gpio,"i");
 MODULE_PARM_DESC(bttv_gpio,"log gpio changes, default is 0 (no)");
-MODULE_PARM(bttv_debug,"i");
 MODULE_PARM_DESC(bttv_debug,"debug messages, default is 0 (no)");
-MODULE_PARM(irq_debug,"i");
 MODULE_PARM_DESC(irq_debug,"irq handler debug messages, default is 0 (no)");
-MODULE_PARM(gbuffers,"i");
 MODULE_PARM_DESC(gbuffers,"number of capture buffers. range 2-32, default 8");
-MODULE_PARM(gbufsize,"i");
 MODULE_PARM_DESC(gbufsize,"size of the capture buffers, default is 0x208000");
-
-MODULE_PARM(video_nr,"i");
-MODULE_PARM(radio_nr,"i");
-MODULE_PARM(vbi_nr,"i");
-MODULE_PARM(debug_latency,"i");
-
-MODULE_PARM(fdsr,"i");
-
-MODULE_PARM(combfilter,"i");
-MODULE_PARM(lumafilter,"i");
-MODULE_PARM(automute,"i");
 MODULE_PARM_DESC(automute,"mute audio on bad/missing video signal, default is 1 (yes)");
-MODULE_PARM(chroma_agc,"i");
 MODULE_PARM_DESC(chroma_agc,"enables the AGC of chroma signal, default is 0 (no)");
-MODULE_PARM(adc_crush,"i");
 MODULE_PARM_DESC(adc_crush,"enables the luminance ADC crush, default is 1 (yes)");
-MODULE_PARM(whitecrush_upper,"i");
 MODULE_PARM_DESC(whitecrush_upper,"sets the white crush upper value, default is 207");
-MODULE_PARM(whitecrush_lower,"i");
 MODULE_PARM_DESC(whitecrush_lower,"sets the white crush lower value, default is 127");
-MODULE_PARM(vcr_hack,"i");
 MODULE_PARM_DESC(vcr_hack,"enables the VCR hack (improves synch on poor VCR tapes), default is 0 (no)");
-MODULE_PARM(irq_iswitch,"i");
 MODULE_PARM_DESC(irq_iswitch,"switch inputs in irq handler");
 
-MODULE_PARM(v4l2,"i");
-
 MODULE_DESCRIPTION("bttv - v4l/v4l2 driver module for bt848/878 based cards");
 MODULE_AUTHOR("Ralph Metzler & Marcus Metzler & Gerd Knorr");
 MODULE_LICENSE("GPL");
@@ -1414,9 +1412,9 @@ static int bttv_prepare_buffer(struct bt
 }
 
 static int
-buffer_setup(void *priv, unsigned int *count, unsigned int *size)
+buffer_setup(struct videobuf_queue *q, unsigned int *count, unsigned int *size)
 {
-	struct bttv_fh *fh = priv;
+	struct bttv_fh *fh = q->priv_data;
 
 	*size = fh->fmt->depth*fh->width*fh->height >> 3;
 	if (0 == *count)
@@ -1427,21 +1425,21 @@ buffer_setup(void *priv, unsigned int *c
 }
 
 static int
-buffer_prepare(void *priv, struct videobuf_buffer *vb,
+buffer_prepare(struct videobuf_queue *q, struct videobuf_buffer *vb,
 	       enum v4l2_field field)
 {
-	struct bttv_buffer *buf = (struct bttv_buffer*)vb;
-	struct bttv_fh *fh = priv;
+	struct bttv_buffer *buf = container_of(vb,struct bttv_buffer,vb);
+	struct bttv_fh *fh = q->priv_data;
 
 	return bttv_prepare_buffer(fh->btv, buf, fh->fmt,
 				   fh->width, fh->height, field);
 }
 
 static void
-buffer_queue(void *priv, struct videobuf_buffer *vb)
+buffer_queue(struct videobuf_queue *q, struct videobuf_buffer *vb)
 {
-	struct bttv_buffer *buf = (struct bttv_buffer*)vb;
-	struct bttv_fh *fh = priv;
+	struct bttv_buffer *buf = container_of(vb,struct bttv_buffer,vb);
+	struct bttv_fh *fh = q->priv_data;
 	struct bttv    *btv = fh->btv;
 
 	buf->vb.state = STATE_QUEUED;
@@ -1452,10 +1450,10 @@ buffer_queue(void *priv, struct videobuf
 	}
 }
 
-static void buffer_release(void *priv, struct videobuf_buffer *vb)
+static void buffer_release(struct videobuf_queue *q, struct videobuf_buffer *vb)
 {
-	struct bttv_buffer *buf = (struct bttv_buffer*)vb;
-	struct bttv_fh *fh = priv;
+	struct bttv_buffer *buf = container_of(vb,struct bttv_buffer,vb);
+	struct bttv_fh *fh = q->priv_data;
 
 	bttv_dma_free(fh->btv,buf);
 }
@@ -2154,7 +2152,6 @@ static int bttv_do_ioctl(struct inode *i
 	if (btv->errors)
 		bttv_reinit_bt848(btv);
 
-#ifdef VIDIOC_G_PRIORITY
 	switch (cmd) {
         case VIDIOCSFREQ:
         case VIDIOCSTUNER:
@@ -2168,7 +2165,7 @@ static int bttv_do_ioctl(struct inode *i
 		if (0 != retval)
 			return retval;
 	};
-#endif
+
 	switch (cmd) {
 
 	/* ***  v4l1  *** ************************************************ */
@@ -2386,8 +2383,7 @@ static int bttv_do_ioctl(struct inode *i
 		unsigned int i;
 
 		down(&fh->cap.lock);
-		retval = videobuf_mmap_setup(file->private_data,
-					     &fh->cap,gbuffers,gbufsize,
+		retval = videobuf_mmap_setup(&fh->cap,gbuffers,gbufsize,
 					     V4L2_MEMORY_MMAP);
 		if (retval < 0)
 			goto fh_unlock_and_return;
@@ -2685,16 +2681,16 @@ static int bttv_do_ioctl(struct inode *i
 	}
 
 	case VIDIOC_REQBUFS:
-		return videobuf_reqbufs(file->private_data,bttv_queue(fh),arg);
+		return videobuf_reqbufs(bttv_queue(fh),arg);
 
 	case VIDIOC_QUERYBUF:
 		return videobuf_querybuf(bttv_queue(fh),arg);
 
 	case VIDIOC_QBUF:
-		return videobuf_qbuf(file->private_data,bttv_queue(fh),arg);
+		return videobuf_qbuf(bttv_queue(fh),arg);
 
 	case VIDIOC_DQBUF:
-		return videobuf_dqbuf(file->private_data,bttv_queue(fh),arg,
+		return videobuf_dqbuf(bttv_queue(fh),arg,
 				      file->f_flags & O_NONBLOCK);
 
 	case VIDIOC_STREAMON:
@@ -2703,13 +2699,13 @@ static int bttv_do_ioctl(struct inode *i
 
 		if (!check_alloc_btres(btv,fh,res))
 			return -EBUSY;
-		return videobuf_streamon(file->private_data,bttv_queue(fh));
+		return videobuf_streamon(bttv_queue(fh));
 	}
 	case VIDIOC_STREAMOFF:
 	{
 		int res = bttv_resource(fh);
 
-		retval = videobuf_streamoff(file->private_data,bttv_queue(fh));
+		retval = videobuf_streamoff(bttv_queue(fh));
 		if (retval < 0)
 			return retval;
 		free_btres(btv,fh,res);
@@ -2778,7 +2774,6 @@ static int bttv_do_ioctl(struct inode *i
 		return 0;
 	}
 
-#ifdef VIDIOC_G_PRIORITY
 	case VIDIOC_G_PRIORITY:
 	{
 		enum v4l2_priority *p = arg;
@@ -2792,8 +2787,6 @@ static int bttv_do_ioctl(struct inode *i
 
 		return v4l2_prio_change(&btv->prio, &fh->prio, *prio);
 	}
-#endif
-
 
 	case VIDIOC_ENUMSTD:
 	case VIDIOC_G_STD:
@@ -2846,15 +2839,13 @@ static ssize_t bttv_read(struct file *fi
 	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
 		if (locked_btres(fh->btv,RESOURCE_VIDEO))
 			return -EBUSY;
-		retval = videobuf_read_one(file->private_data,
-					   &fh->cap, data, count, ppos,
+		retval = videobuf_read_one(&fh->cap, data, count, ppos,
 					   file->f_flags & O_NONBLOCK);
 		break;
 	case V4L2_BUF_TYPE_VBI_CAPTURE:
 		if (!check_alloc_btres(fh->btv,fh,RESOURCE_VBI))
 			return -EBUSY;
-		retval = videobuf_read_stream(file->private_data,
-					      &fh->vbi, data, count, ppos, 1,
+		retval = videobuf_read_stream(&fh->vbi, data, count, ppos, 1,
 					      file->f_flags & O_NONBLOCK);
 		break;
 	default:
@@ -2872,8 +2863,7 @@ static unsigned int bttv_poll(struct fil
 	if (V4L2_BUF_TYPE_VBI_CAPTURE == fh->type) {
 		if (!check_alloc_btres(fh->btv,fh,RESOURCE_VBI))
 			return POLLERR;
-		return videobuf_poll_stream(file, file->private_data,
-					    &fh->vbi, wait);
+		return videobuf_poll_stream(file, &fh->vbi, wait);
 	}
 
 	if (check_btres(fh,RESOURCE_VIDEO)) {
@@ -2953,20 +2943,20 @@ static int bttv_open(struct inode *inode
 	*fh = btv->init;
 	fh->type = type;
 	fh->ov.setup_ok = 0;
-#ifdef VIDIOC_G_PRIORITY
 	v4l2_prio_open(&btv->prio,&fh->prio);
-#endif
 
 	videobuf_queue_init(&fh->cap, &bttv_video_qops,
 			    btv->c.pci, &btv->s_lock,
 			    V4L2_BUF_TYPE_VIDEO_CAPTURE,
 			    V4L2_FIELD_INTERLACED,
-			    sizeof(struct bttv_buffer));
+			    sizeof(struct bttv_buffer),
+			    fh);
 	videobuf_queue_init(&fh->vbi, &bttv_vbi_qops,
 			    btv->c.pci, &btv->s_lock,
 			    V4L2_BUF_TYPE_VBI_CAPTURE,
 			    V4L2_FIELD_SEQ_TB,
-			    sizeof(struct bttv_buffer));
+			    sizeof(struct bttv_buffer),
+			    fh);
 	i2c_vidiocschan(btv);
 
 	btv->users++;
@@ -2987,7 +2977,7 @@ static int bttv_release(struct inode *in
 
 	/* stop video capture */
 	if (check_btres(fh, RESOURCE_VIDEO)) {
-		videobuf_streamoff(file->private_data,&fh->cap);
+		videobuf_streamoff(&fh->cap);
 		free_btres(btv,fh,RESOURCE_VIDEO);
 	}
 	if (fh->cap.read_buf) {
@@ -2998,15 +2988,13 @@ static int bttv_release(struct inode *in
 	/* stop vbi capture */
 	if (check_btres(fh, RESOURCE_VBI)) {
 		if (fh->vbi.streaming)
-			videobuf_streamoff(file->private_data,&fh->vbi);
+			videobuf_streamoff(&fh->vbi);
 		if (fh->vbi.reading)
-			videobuf_read_stop(file->private_data,&fh->vbi);
+			videobuf_read_stop(&fh->vbi);
 		free_btres(btv,fh,RESOURCE_VBI);
 	}
 
-#ifdef VIDIOC_G_PRIORITY
 	v4l2_prio_close(&btv->prio,&fh->prio);
-#endif
 	file->private_data = NULL;
 	kfree(fh);
 
@@ -3023,7 +3011,7 @@ bttv_mmap(struct file *file, struct vm_a
 	dprintk("bttv%d: mmap type=%s 0x%lx+%ld\n",
 		fh->btv->c.nr, v4l2_type_names[fh->type],
 		vma->vm_start, vma->vm_end - vma->vm_start);
-	return videobuf_mmap_mapper(vma,bttv_queue(fh));
+	return videobuf_mmap_mapper(bttv_queue(fh),vma);
 }
 
 static struct file_operations bttv_fops =
@@ -3742,9 +3730,7 @@ static int __devinit bttv_probe(struct p
         INIT_LIST_HEAD(&btv->c.subs);
         INIT_LIST_HEAD(&btv->capture);
         INIT_LIST_HEAD(&btv->vcapture);
-#ifdef VIDIOC_G_PRIORITY
 	v4l2_prio_init(&btv->prio);
-#endif
 
 	init_timer(&btv->timeout);
 	btv->timeout.function = bttv_irq_timeout;
Index: linux-2004-11-05/drivers/media/video/bttv-cards.c
===================================================================
--- linux-2004-11-05.orig/drivers/media/video/bttv-cards.c	2004-11-07 12:22:45.000000000 +0100
+++ linux-2004-11-05/drivers/media/video/bttv-cards.c	2004-11-07 15:48:56.350414757 +0100
@@ -1,5 +1,5 @@
 /*
-    $Id: bttv-cards.c,v 1.29 2004/10/13 10:39:00 kraxel Exp $
+    $Id: bttv-cards.c,v 1.32 2004/11/07 13:17:14 kraxel Exp $
 
     bttv-cards.c
 
@@ -106,53 +106,31 @@ static unsigned int audioall = UNSET;
 static unsigned int audiomux[5] = { [ 0 ... 4 ] = UNSET };
 
 /* insmod options */
-MODULE_PARM(triton1,"i");
+module_param(triton1,    int, 0444);
+module_param(vsfx,       int, 0444);
+module_param(no_overlay, int, 0444);
+module_param(latency,    int, 0444);
+module_param(gpiomask,   int, 0444);
+module_param(audioall,   int, 0444);
+module_param(autoload,   int, 0444);
+
+module_param_array(card,     int, NULL, 0444);
+module_param_array(pll,      int, NULL, 0444);
+module_param_array(tuner,    int, NULL, 0444);
+module_param_array(svhs,     int, NULL, 0444);
+module_param_array(remote,   int, NULL, 0444);
+module_param_array(audiomux, int, NULL, 0444);
+
 MODULE_PARM_DESC(triton1,"set ETBF pci config bit "
 		 "[enable bug compatibility for triton1 + others]");
-MODULE_PARM(vsfx,"i");
 MODULE_PARM_DESC(vsfx,"set VSFX pci config bit "
 		 "[yet another chipset flaw workaround]");
-MODULE_PARM(no_overlay,"i");
-MODULE_PARM(latency,"i");
 MODULE_PARM_DESC(latency,"pci latency timer");
-MODULE_PARM(card,"1-" __stringify(BTTV_MAX) "i");
 MODULE_PARM_DESC(card,"specify TV/grabber card model, see CARDLIST file for a list");
-MODULE_PARM(pll,"1-" __stringify(BTTV_MAX) "i");
 MODULE_PARM_DESC(pll,"specify installed crystal (0=none, 28=28 MHz, 35=35 MHz)");
-MODULE_PARM(tuner,"1-" __stringify(BTTV_MAX) "i");
 MODULE_PARM_DESC(tuner,"specify installed tuner type");
-MODULE_PARM(autoload,"i");
 MODULE_PARM_DESC(autoload,"automatically load i2c modules like tuner.o, default is 1 (yes)");
 
-MODULE_PARM(svhs,"1-" __stringify(BTTV_MAX) "i");
-MODULE_PARM(remote,"1-" __stringify(BTTV_MAX) "i");
-
-MODULE_PARM(gpiomask,"i");
-MODULE_PARM(audioall,"i");
-MODULE_PARM(audiomux,"1-6i");
-
-/* kernel args */
-#ifndef MODULE
-static int __init p_card(char *str)  { return bttv_parse(str,BTTV_MAX,card);  }
-static int __init p_pll(char *str)   { return bttv_parse(str,BTTV_MAX,pll);   }
-static int __init p_tuner(char *str) { return bttv_parse(str,BTTV_MAX,tuner); }
-__setup("bttv.card=",  p_card);
-__setup("bttv.pll=",   p_pll);
-__setup("bttv.tuner=", p_tuner);
-
-int __init bttv_parse(char *str, int max, int *vals)
-{
-	int i,number,res = 2;
-
-	for (i = 0; res == 2 && i < max; i++) {
-		res = get_option(&str,&number);
-		if (res)
-			vals[i] = number;
-	}
-	return 1;
-}
-#endif
-
 /* ----------------------------------------------------------------------- */
 /* list of card IDs for bt878+ cards                                       */
 
@@ -184,7 +162,6 @@ static struct CARD {
  	{ 0xd01810fc, BTTV_GVBCTV5PCI,    "I-O Data Co. GV-BCTV5/PCI" },
 
 	{ 0x001211bd, BTTV_PINNACLE,      "Pinnacle PCTV" },
-	{ 0x001c11bd, BTTV_PINNACLESAT,   "Pinnacle PCTV Sat" },
 	// some cards ship with byteswapped IDs ...
 	{ 0x1200bd11, BTTV_PINNACLE,      "Pinnacle PCTV [bswap]" },
 	{ 0xff00bd11, BTTV_PINNACLE,      "Pinnacle PCTV [bswap]" },
@@ -194,6 +171,7 @@ static struct CARD {
 	{ 0x3060121a, BTTV_STB2,	  "3Dfx VoodooTV 100/ STB OEM" },
 
 	{ 0x3000144f, BTTV_MAGICTVIEW063, "(Askey Magic/others) TView99 CPH06x" },
+	{ 0xa005144f, BTTV_MAGICTVIEW063, "CPH06X TView99-Card" },
 	{ 0x3002144f, BTTV_MAGICTVIEW061, "(Askey Magic/others) TView99 CPH05x" },
 	{ 0x3005144f, BTTV_MAGICTVIEW061, "(Askey Magic/others) TView99 CPH061/06L (T1/LC)" },
 	{ 0x5000144f, BTTV_MAGICTVIEW061, "Askey CPH050" },
@@ -306,6 +284,7 @@ static struct CARD {
 	// DVB cards (using pci function .1 for mpeg data xfer)
 	{ 0x01010071, BTTV_NEBULA_DIGITV, "Nebula Electronics DigiTV" },
 	{ 0x07611461, BTTV_AVDVBT_761,    "AverMedia AverTV DVB-T" },
+	{ 0x001c11bd, BTTV_PINNACLESAT,   "Pinnacle PCTV Sat" },
 	{ 0x002611bd, BTTV_TWINHAN_DST,   "Pinnacle PCTV SAT CI" },
 	{ 0x00011822, BTTV_TWINHAN_DST,   "Twinhan VisionPlus DVB-T" },
 	{ 0xfc00270f, BTTV_TWINHAN_DST,   "ChainTech digitop DST-1000 DVB-S" },
@@ -1670,6 +1649,7 @@ struct tvcard bttv_tvcards[] = {
 	.needs_tvaudio  = 0,
 	.pll            = PLL_28,
 	.no_gpioirq     = 1,
+	.has_dvb        = 1,
 },{
         .name           = "Formac ProTV II (bt878)",
         .video_inputs   = 4,
@@ -2084,9 +2064,7 @@ struct tvcard bttv_tvcards[] = {
         .pll            = PLL_28,
         .has_dvb        = 1,
         .no_gpioirq     = 1,
-#if 0 /* untested */
         .has_remote     = 1,
-#endif
 },{
 	/* ---- card 0x7c ---------------------------------- */
 	/* Matt Jesson <dvb@jesson.eclipse.co.uk> */
@@ -2969,40 +2947,6 @@ static int __devinit pvr_altera_load(str
 	return 0;
 }
 
-#if !defined(CONFIG_FW_LOADER) && !defined(CONFIG_FW_LOADER_MODULE)
-/* old 2.4.x way -- via soundcore's mod_firmware_load */
-
-static char *firm_altera = "/usr/lib/video4linux/hcwamc.rbf";
-MODULE_PARM(firm_altera,"s");
-MODULE_PARM_DESC(firm_altera,"WinTV/PVR firmware "
-		 "(driver CD => unzip pvr45xxx.exe => hcwamc.rbf)");
-
-extern int mod_firmware_load(const char *fn, char **fp);
-
-int __devinit pvr_boot(struct bttv *btv)
-{
-	u32 microlen;
-	u8 *micro;
-	int result;
-
-	microlen = mod_firmware_load(firm_altera, (char**) &micro);
-	if (!microlen) {
-		printk(KERN_WARNING "bttv%d: altera firmware not found [%s]\n",
-		       btv->c.nr, firm_altera);
-		return -1;
-	}
-
-	printk(KERN_INFO "bttv%d: uploading altera firmware [%s] ...\n",
-	       btv->c.nr, firm_altera);
-	result = pvr_altera_load(btv, micro, microlen);
-	printk(KERN_INFO "bttv%d: ... upload %s\n",
-	       btv->c.nr, (result < 0) ? "failed" : "ok");
-	vfree(micro);
-	return result;
-}
-#else
-/* new 2.5.x way -- via hotplug firmware loader */
-
 int __devinit pvr_boot(struct bttv *btv)
 {
         const struct firmware *fw_entry;
@@ -3020,7 +2964,6 @@ int __devinit pvr_boot(struct bttv *btv)
         release_firmware(fw_entry);
 	return rc;
 }
-#endif
 
 /* ----------------------------------------------------------------------- */
 /* some osprey specific stuff                                              */
Index: linux-2004-11-05/drivers/media/video/bttv-vbi.c
===================================================================
--- linux-2004-11-05.orig/drivers/media/video/bttv-vbi.c	2004-11-07 12:23:18.025598975 +0100
+++ linux-2004-11-05/drivers/media/video/bttv-vbi.c	2004-11-07 15:48:56.351414569 +0100
@@ -1,5 +1,5 @@
 /*
-    $Id: bttv-vbi.c,v 1.6 2004/10/13 10:39:00 kraxel Exp $
+    $Id: bttv-vbi.c,v 1.7 2004/11/07 13:17:15 kraxel Exp $
 
     bttv - Bt848 frame grabber driver
     vbi interface
@@ -37,9 +37,9 @@
 static unsigned int vbibufs = 4;
 static unsigned int vbi_debug = 0;
 
-MODULE_PARM(vbibufs,"i");
+module_param(vbibufs,   int, 0444);
+module_param(vbi_debug, int, 0644);
 MODULE_PARM_DESC(vbibufs,"number of vbi buffers, range 2-32, default 4");
-MODULE_PARM(vbi_debug,"i");
 MODULE_PARM_DESC(vbi_debug,"vbi code debug messages, default is 0 (no)");
 
 #ifdef dprintk
@@ -63,10 +63,10 @@ vbi_buffer_risc(struct bttv *btv, struct
 	return 0;
 }
 
-static int vbi_buffer_setup(void *priv,
+static int vbi_buffer_setup(struct videobuf_queue *q,
 			    unsigned int *count, unsigned int *size)
 {
-	struct bttv_fh *fh = priv;
+	struct bttv_fh *fh = q->priv_data;
 	struct bttv *btv = fh->btv;
 
 	if (0 == *count)
@@ -76,12 +76,13 @@ static int vbi_buffer_setup(void *priv,
 	return 0;
 }
 
-static int vbi_buffer_prepare(void *priv, struct videobuf_buffer *vb,
+static int vbi_buffer_prepare(struct videobuf_queue *q,
+			      struct videobuf_buffer *vb,
 			      enum v4l2_field field)
 {
-	struct bttv_fh *fh = priv;
+	struct bttv_fh *fh = q->priv_data;
 	struct bttv *btv = fh->btv;
-	struct bttv_buffer *buf = (struct bttv_buffer*)vb;
+	struct bttv_buffer *buf = container_of(vb,struct bttv_buffer,vb);
 	int rc;
 
 	buf->vb.size = fh->lines * 2 * 2048;
@@ -107,11 +108,11 @@ static int vbi_buffer_prepare(void *priv
 }
 
 static void
-vbi_buffer_queue(void *priv, struct videobuf_buffer *vb)
+vbi_buffer_queue(struct videobuf_queue *q, struct videobuf_buffer *vb)
 {
-	struct bttv_fh *fh = priv;
+	struct bttv_fh *fh = q->priv_data;
 	struct bttv *btv = fh->btv;
-	struct bttv_buffer *buf = (struct bttv_buffer*)vb;
+	struct bttv_buffer *buf = container_of(vb,struct bttv_buffer,vb);
 
 	dprintk("queue %p\n",vb);
 	buf->vb.state = STATE_QUEUED;
@@ -122,11 +123,11 @@ vbi_buffer_queue(void *priv, struct vide
 	}
 }
 
-static void vbi_buffer_release(void *priv, struct videobuf_buffer *vb)
+static void vbi_buffer_release(struct videobuf_queue *q, struct videobuf_buffer *vb)
 {
-	struct bttv_fh *fh = priv;
+	struct bttv_fh *fh = q->priv_data;
 	struct bttv *btv = fh->btv;
-	struct bttv_buffer *buf = (struct bttv_buffer*)vb;
+	struct bttv_buffer *buf = container_of(vb,struct bttv_buffer,vb);
 
 	dprintk("free %p\n",vb);
 	bttv_dma_free(fh->btv,buf);
Index: linux-2004-11-05/drivers/media/video/bttv-gpio.c
===================================================================
--- linux-2004-11-05.orig/drivers/media/video/bttv-gpio.c	2004-11-07 12:23:39.623557711 +0100
+++ linux-2004-11-05/drivers/media/video/bttv-gpio.c	2004-11-07 15:48:56.351414569 +0100
@@ -1,5 +1,5 @@
 /*
-    $Id: bttv-gpio.c,v 1.4 2004/10/13 10:39:00 kraxel Exp $
+    $Id: bttv-gpio.c,v 1.6 2004/11/03 09:04:50 kraxel Exp $
 
     bttv-gpio.c  --  gpio sub drivers
 
Index: linux-2004-11-05/drivers/media/video/bttv-i2c.c
===================================================================
--- linux-2004-11-05.orig/drivers/media/video/bttv-i2c.c	2004-11-07 12:21:30.000000000 +0100
+++ linux-2004-11-05/drivers/media/video/bttv-i2c.c	2004-11-07 15:48:56.351414569 +0100
@@ -1,5 +1,5 @@
 /*
-    $Id: bttv-i2c.c,v 1.11 2004/10/13 10:39:00 kraxel Exp $
+    $Id: bttv-i2c.c,v 1.13 2004/11/07 13:17:15 kraxel Exp $
 
     bttv-i2c.c  --  all the i2c code is here
 
@@ -37,19 +37,15 @@ static struct i2c_adapter bttv_i2c_adap_
 static struct i2c_adapter bttv_i2c_adap_hw_template;
 static struct i2c_client bttv_i2c_client_template;
 
-#ifndef I2C_PEC
-static void bttv_inc_use(struct i2c_adapter *adap);
-static void bttv_dec_use(struct i2c_adapter *adap);
-#endif
 static int attach_inform(struct i2c_client *client);
 static int detach_inform(struct i2c_client *client);
 
 static int i2c_debug = 0;
 static int i2c_hw = 0;
 static int i2c_scan = 0;
-MODULE_PARM(i2c_debug,"i");
-MODULE_PARM(i2c_hw,"i");
-MODULE_PARM(i2c_scan,"i");
+module_param(i2c_debug, int, 0644);
+module_param(i2c_hw,    int, 0444);
+module_param(i2c_scan,  int, 0444);
 MODULE_PARM_DESC(i2c_scan,"scan i2c bus at insmod time");
 
 /* ----------------------------------------------------------------------- */
@@ -108,12 +104,7 @@ static struct i2c_algo_bit_data bttv_i2c
 };
 
 static struct i2c_adapter bttv_i2c_adap_sw_template = {
-#ifdef I2C_PEC
 	.owner             = THIS_MODULE,
-#else
-	.inc_use           = bttv_inc_use,
-	.dec_use           = bttv_dec_use,
-#endif
 #ifdef I2C_CLASS_TV_ANALOG
 	.class             = I2C_CLASS_TV_ANALOG,
 #endif
@@ -290,12 +281,7 @@ static struct i2c_algorithm bttv_algo = 
 };
 
 static struct i2c_adapter bttv_i2c_adap_hw_template = {
-#ifdef I2C_PEC
 	.owner         = THIS_MODULE,
-#else
-	.inc_use       = bttv_inc_use,
-	.dec_use       = bttv_dec_use,
-#endif
 #ifdef I2C_CLASS_TV_ANALOG
 	.class         = I2C_CLASS_TV_ANALOG,
 #endif
@@ -306,6 +292,9 @@ static struct i2c_adapter bttv_i2c_adap_
 	.client_unregister = detach_inform,
 };
 
+/* ----------------------------------------------------------------------- */
+/* I2C functions - common stuff                                            */
+
 static int attach_inform(struct i2c_client *client)
 {
         struct bttv *btv = i2c_get_adapdata(client->adapter);
Index: linux-2004-11-05/drivers/media/video/btcx-risc.c
===================================================================
--- linux-2004-11-05.orig/drivers/media/video/btcx-risc.c	2004-11-07 12:21:15.000000000 +0100
+++ linux-2004-11-05/drivers/media/video/btcx-risc.c	2004-11-07 15:48:56.352414381 +0100
@@ -1,5 +1,5 @@
 /*
-    $Id: btcx-risc.c,v 1.3 2004/10/13 10:39:00 kraxel Exp $
+    $Id: btcx-risc.c,v 1.4 2004/11/07 13:17:14 kraxel Exp $
 
     btcx-risc.c
 
@@ -38,7 +38,7 @@ MODULE_AUTHOR("Gerd Knorr");
 MODULE_LICENSE("GPL");
 
 static unsigned int debug = 0;
-MODULE_PARM(debug,"i");
+module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug,"debug messages, default is 0 (no)");
 
 /* ---------------------------------------------------------- */

-- 
#define printk(args...) fprintf(stderr, ## args)
