Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262154AbUDEMW4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 08:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbUDEMWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 08:22:55 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:38306 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262154AbUDEMUc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 08:20:32 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 5 Apr 2004 14:28:03 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] 33_saa7134-2.6.5.diff.gz
Message-ID: <20040405122803.GA30060@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This is a update for the saa7134 driver.  Changes:

  * add cropping support.
  * fix Makefile to build the saa6752hs module.
  * fix locking bug in oss dsp driver.
  * infrared remote keytable update.
  * some card-specific fixes.

please apply,

  Gerd

diff -up linux-2.6.5/drivers/media/video/saa7134/Makefile linux/drivers/media/video/saa7134/Makefile
--- linux-2.6.5/drivers/media/video/saa7134/Makefile	2004-04-05 10:43:50.417576751 +0200
+++ linux/drivers/media/video/saa7134/Makefile	2004-04-05 10:49:58.680136616 +0200
@@ -3,6 +3,6 @@ saa7134-objs :=	saa7134-cards.o saa7134-
 		saa7134-oss.o saa7134-ts.o saa7134-tvaudio.o	\
 		saa7134-vbi.o saa7134-video.o saa7134-input.o
 
-obj-$(CONFIG_VIDEO_SAA7134) += saa7134.o
+obj-$(CONFIG_VIDEO_SAA7134) += saa7134.o saa6752hs.o
 
 EXTRA_CFLAGS = -I$(src)/..
diff -up linux-2.6.5/drivers/media/video/saa7134/saa7134-cards.c linux/drivers/media/video/saa7134/saa7134-cards.c
--- linux-2.6.5/drivers/media/video/saa7134/saa7134-cards.c	2004-04-05 10:42:44.024102551 +0200
+++ linux/drivers/media/video/saa7134/saa7134-cards.c	2004-04-05 10:49:58.684135862 +0200
@@ -2,7 +2,7 @@
  * device driver for philips saa7134 based TV cards
  * card-specific stuff.
  *
- * (c) 2001-03 Gerd Knorr <kraxel@bytesex.org> [SuSE Labs]
+ * (c) 2001-04 Gerd Knorr <kraxel@bytesex.org> [SuSE Labs]
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -732,7 +732,9 @@ struct saa7134_board saa7134_boards[] = 
         [SAA7134_BOARD_ASUSTEK_TVFM7133] = {
                 .name           = "ASUS TV-FM 7133",
                 .audio_clock    = 0x00187de7,
-                .tuner_type     = TUNER_PHILIPS_FM1236_MK3,
+		// probably wrong, the 7133 one is the NTSC version ...
+		// .tuner_type     = TUNER_PHILIPS_FM1236_MK3
+                .tuner_type     = TUNER_LG_NTSC_NEW_TAPC,
                 .need_tda9887   = 1,
                 .inputs         = {{
                         .name = name_tv,
diff -up linux-2.6.5/drivers/media/video/saa7134/saa7134-core.c linux/drivers/media/video/saa7134/saa7134-core.c
--- linux-2.6.5/drivers/media/video/saa7134/saa7134-core.c	2004-04-05 10:40:04.759152819 +0200
+++ linux/drivers/media/video/saa7134/saa7134-core.c	2004-04-05 10:49:58.688135108 +0200
@@ -101,7 +101,7 @@ unsigned int      saa7134_devcount;
 /* debug help functions                                               */
 
 static const char *v4l1_ioctls[] = {
-	"0", "CGAP", "GCHAN", "SCHAN", "GTUNER", "STUNER", "GPICT", "SPICT",
+	"0", "GCAP", "GCHAN", "SCHAN", "GTUNER", "STUNER", "GPICT", "SPICT",
 	"CCAPTURE", "GWIN", "SWIN", "GFBUF", "SFBUF", "KEY", "GFREQ",
 	"SFREQ", "GAUDIO", "SAUDIO", "SYNC", "MCAPTURE", "GMBUF", "GUNIT",
 	"GCAPTURE", "SCAPTURE", "SPLAYMODE", "SWRITEMODE", "GPLAYINFO",
@@ -466,7 +466,7 @@ int saa7134_set_dmabits(struct saa7134_d
 	}
 
 	/* audio capture -- dma 3 */
-	if (dev->oss.recording) {
+	if (dev->oss.dma_running) {
 		ctrl |= SAA7134_MAIN_CTRL_TE6;
 		irq  |= SAA7134_IRQ1_INTE_RA3_1 |
 			SAA7134_IRQ1_INTE_RA3_0;
diff -up linux-2.6.5/drivers/media/video/saa7134/saa7134-input.c linux/drivers/media/video/saa7134/saa7134-input.c
--- linux-2.6.5/drivers/media/video/saa7134/saa7134-input.c	2004-04-05 10:42:23.556964030 +0200
+++ linux/drivers/media/video/saa7134/saa7134-input.c	2004-04-05 10:49:58.691134543 +0200
@@ -100,42 +100,42 @@ static IR_KEYTAB_TYPE cinergy_codes[IR_K
 	[ 0x23 ] = KEY_STOP,
 };
 
-/* Alfons Geser <a.geser@cox.net> */
+/* Alfons Geser <a.geser@cox.net>
+ * updates from Job D. R. Borges <jobdrb@ig.com.br> */
 static IR_KEYTAB_TYPE eztv_codes[IR_KEYTAB_SIZE] = {
         [ 18 ] = KEY_POWER,
         [  1 ] = KEY_TV,             // DVR
-        [ 21 ] = KEY_VIDEO,          // DVD
+        [ 21 ] = KEY_DVD,            // DVD
         [ 23 ] = KEY_AUDIO,          // music
-
                                      // DVR mode / DVD mode / music mode
 
         [ 27 ] = KEY_MUTE,           // mute
-        [  2 ] = KEY_RESERVED,       // MTS/SAP / audio /autoseek
-        [ 30 ] = KEY_RESERVED,       // closed captioning / subtitle / seek
+        [  2 ] = KEY_LANGUAGE,       // MTS/SAP / audio / autoseek
+        [ 30 ] = KEY_SUBTITLE,       // closed captioning / subtitle / seek
         [ 22 ] = KEY_ZOOM,           // full screen
-        [ 28 ] = KEY_RESERVED,       // video source / eject /delall
-        [ 29 ] = KEY_RESERVED,       // playback / angle /del
+        [ 28 ] = KEY_VIDEO,          // video source / eject / delall
+        [ 29 ] = KEY_RESTART,        // playback / angle / del
         [ 47 ] = KEY_SEARCH,         // scan / menu / playlist
-        [ 48 ] = KEY_RESERVED,       // CH surfing / bookmark / memo
+        [ 48 ] = KEY_CHANNEL,        // CH surfing / bookmark / memo
 
         [ 49 ] = KEY_HELP,           // help
-        [ 50 ] = KEY_RESERVED,       // num/memo
+        [ 50 ] = KEY_MODE,           // num/memo
         [ 51 ] = KEY_ESC,            // cancel
 
 	[ 12 ] = KEY_UP,             // up
 	[ 16 ] = KEY_DOWN,           // down
 	[  8 ] = KEY_LEFT,           // left
 	[  4 ] = KEY_RIGHT,          // right
-	[  3 ] = KEY_ENTER,          // select
+	[  3 ] = KEY_SELECT,         // select
 
 	[ 31 ] = KEY_REWIND,         // rewind
 	[ 32 ] = KEY_PLAYPAUSE,      // play/pause
 	[ 41 ] = KEY_FORWARD,        // forward
-	[ 20 ] = KEY_RESERVED,       // repeat
+	[ 20 ] = KEY_AGAIN,          // repeat
 	[ 43 ] = KEY_RECORD,         // recording
 	[ 44 ] = KEY_STOP,           // stop
 	[ 45 ] = KEY_PLAY,           // play
-	[ 46 ] = KEY_RESERVED,       // snapshot
+	[ 46 ] = KEY_SHUFFLE,        // snapshot / shuffle
 
         [  0 ] = KEY_KP0,
         [  5 ] = KEY_KP1,
@@ -147,7 +147,7 @@ static IR_KEYTAB_TYPE eztv_codes[IR_KEYT
         [ 13 ] = KEY_KP7,
         [ 14 ] = KEY_KP8,
         [ 15 ] = KEY_KP9,
-
+ 
         [ 42 ] = KEY_VOLUMEUP,
         [ 17 ] = KEY_VOLUMEDOWN,
         [ 24 ] = KEY_CHANNELUP,      // CH.tracking up
diff -up linux-2.6.5/drivers/media/video/saa7134/saa7134-oss.c linux/drivers/media/video/saa7134/saa7134-oss.c
--- linux-2.6.5/drivers/media/video/saa7134/saa7134-oss.c	2004-04-05 10:40:48.405916972 +0200
+++ linux/drivers/media/video/saa7134/saa7134-oss.c	2004-04-05 10:49:58.695133789 +0200
@@ -64,7 +64,7 @@ static int dsp_buffer_conf(struct saa713
 	dev->oss.bufsize = blksize * blocks;
 
 	dprintk("buffer config: %d blocks / %d bytes, %d kB total\n",
-		blocks,blksize,blksize * blocks / 1024);
+ 		blocks,blksize,blksize * blocks / 1024);
 	return 0;
 }
 
@@ -74,6 +74,7 @@ static int dsp_buffer_init(struct saa713
 
 	if (!dev->oss.bufsize)
 		BUG();
+	videobuf_dma_init(&dev->oss.dma);
 	err = videobuf_dma_init_kernel(&dev->oss.dma, PCI_DMA_FROMDEVICE,
 				       dev->oss.bufsize >> PAGE_SHIFT);
 	if (0 != err)
@@ -92,6 +93,20 @@ static int dsp_buffer_free(struct saa713
 	return 0;
 }
 
+static void dsp_dma_start(struct saa7134_dev *dev)
+{
+	dev->oss.dma_blk     = 0;
+	dev->oss.dma_running = 1;
+	saa7134_set_dmabits(dev);
+}
+
+static void dsp_dma_stop(struct saa7134_dev *dev)
+{
+	dev->oss.dma_blk     = -1;
+	dev->oss.dma_running = 0;
+	saa7134_set_dmabits(dev);
+}
+
 static int dsp_rec_start(struct saa7134_dev *dev)
 {
 	int err, bswap, sign;
@@ -178,10 +193,9 @@ static int dsp_rec_start(struct saa7134_
 	saa_writel(SAA7134_RS_CONTROL(6),control);
 	
 	/* start dma */
+	dev->oss.recording_on = 1;
 	spin_lock_irqsave(&dev->slock,flags);
-	dev->oss.recording = 1;
-	dev->oss.dma_blk   = 0;
-	saa7134_set_dmabits(dev);
+	dsp_dma_start(dev);
 	spin_unlock_irqrestore(&dev->slock,flags);
 	return 0;
 
@@ -199,10 +213,9 @@ static int dsp_rec_stop(struct saa7134_d
 	dprintk("rec_stop dma_blk=%d\n",dev->oss.dma_blk);
 
 	/* stop dma */
+	dev->oss.recording_on = 0;
 	spin_lock_irqsave(&dev->slock,flags);
-	dev->oss.dma_blk   = -1;
-	dev->oss.recording = 0;
-	saa7134_set_dmabits(dev);
+	dsp_dma_stop(dev);
 	spin_unlock_irqrestore(&dev->slock,flags);
 
 	/* unlock buffer */
@@ -259,7 +272,7 @@ static int dsp_release(struct inode *ino
 	struct saa7134_dev *dev = file->private_data;
 
 	down(&dev->oss.lock);
-	if (dev->oss.recording)
+	if (dev->oss.recording_on)
 		dsp_rec_stop(dev);
 	dsp_buffer_free(dev);
 	dev->oss.users_dsp--;
@@ -274,6 +287,7 @@ static ssize_t dsp_read(struct file *fil
 	struct saa7134_dev *dev = file->private_data;
 	DECLARE_WAITQUEUE(wait, current);
 	unsigned int bytes;
+	unsigned long flags;
 	int err,ret = 0;
 
 	add_wait_queue(&dev->oss.wq, &wait);
@@ -281,7 +295,7 @@ static ssize_t dsp_read(struct file *fil
 	while (count > 0) {
 		/* wait for data if needed */
 		if (0 == dev->oss.read_count) {
-			if (!dev->oss.recording) {
+			if (!dev->oss.recording_on) {
 				err = dsp_rec_start(dev);
 				if (err < 0) {
 					if (0 == ret)
@@ -289,6 +303,13 @@ static ssize_t dsp_read(struct file *fil
 					break;
 				}
 			}
+			if (dev->oss.recording_on &&
+			    !dev->oss.dma_running) {
+				/* recover from overruns */
+				spin_lock_irqsave(&dev->slock,flags);
+				dsp_dma_start(dev);
+				spin_unlock_irqrestore(&dev->slock,flags);
+			}
 			if (file->f_flags & O_NONBLOCK) {
 				if (0 == ret)
 					ret = -EAGAIN;
@@ -365,7 +386,7 @@ static int dsp_ioctl(struct inode *inode
 			return -EFAULT;
 		down(&dev->oss.lock);
 		dev->oss.channels = val ? 2 : 1;
-		if (dev->oss.recording) {
+		if (dev->oss.recording_on) {
 			dsp_rec_stop(dev);
 			dsp_rec_start(dev);
 		}
@@ -379,7 +400,7 @@ static int dsp_ioctl(struct inode *inode
 			return -EINVAL;
 		down(&dev->oss.lock);
 		dev->oss.channels = val;
-		if (dev->oss.recording) {
+		if (dev->oss.recording_on) {
 			dsp_rec_stop(dev);
 			dsp_rec_start(dev);
 		}
@@ -408,7 +429,7 @@ static int dsp_ioctl(struct inode *inode
 		case AFMT_S16_BE:
 			down(&dev->oss.lock);
 			dev->oss.afmt = val;
-			if (dev->oss.recording) {
+			if (dev->oss.recording_on) {
 				dsp_rec_stop(dev);
 				dsp_rec_start(dev);
 			}
@@ -438,7 +459,7 @@ static int dsp_ioctl(struct inode *inode
 
         case SNDCTL_DSP_RESET:
 		down(&dev->oss.lock);
-		if (dev->oss.recording)
+		if (dev->oss.recording_on)
 			dsp_rec_stop(dev);
 		up(&dev->oss.lock);
 		return 0;
@@ -448,7 +469,7 @@ static int dsp_ioctl(struct inode *inode
         case SNDCTL_DSP_SETFRAGMENT:
 		if (get_user(val, (int*)arg))
 			return -EFAULT;
-		if (dev->oss.recording)
+		if (dev->oss.recording_on)
 			return -EBUSY;
 		dsp_buffer_free(dev);
 		dsp_buffer_conf(dev,1 << (val & 0xffff), (arg >> 16) & 0xffff);
@@ -484,7 +505,7 @@ static unsigned int dsp_poll(struct file
 
 	if (0 == dev->oss.read_count) {
 		down(&dev->oss.lock);
-		if (!dev->oss.recording)
+		if (!dev->oss.recording_on)
 			dsp_rec_start(dev);
 		up(&dev->oss.lock);
 	} else
@@ -800,7 +821,7 @@ void saa7134_irq_oss_done(struct saa7134
 	if (dev->oss.read_count >= dev->oss.blksize * (dev->oss.blocks-2)) {
 		dprintk("irq: overrun [full=%d/%d]\n",dev->oss.read_count,
 			dev->oss.bufsize);
-		dsp_rec_stop(dev);
+		dsp_dma_stop(dev);
 		goto done;
 	}
 
diff -up linux-2.6.5/drivers/media/video/saa7134/saa7134-tvaudio.c linux/drivers/media/video/saa7134/saa7134-tvaudio.c
--- linux-2.6.5/drivers/media/video/saa7134/saa7134-tvaudio.c	2004-04-05 10:38:42.000000000 +0200
+++ linux/drivers/media/video/saa7134/saa7134-tvaudio.c	2004-04-05 10:49:58.699133036 +0200
@@ -60,8 +60,9 @@ MODULE_PARM_DESC(audio_clock_tweak, "Aud
 #define print_regb(reg) printk("%s:   reg 0x%03x [%-16s]: 0x%02x\n", \
 		dev->name,(SAA7134_##reg),(#reg),saa_readb((SAA7134_##reg)))
 
-#define SCAN_INITIAL_DELAY  (HZ)
-#define SCAN_SAMPLE_DELAY   (HZ/5)
+#define SCAN_INITIAL_DELAY     (HZ)
+#define SCAN_SAMPLE_DELAY      (HZ/5)
+#define SCAN_SUBCARRIER_DELAY  (HZ*2)
 
 /* ------------------------------------------------------------------ */
 /* saa7134 code                                                       */
@@ -145,7 +146,7 @@ static void tvaudio_init(struct saa7134_
 
 	if (UNSET != audio_clock_override)
 	        clock = audio_clock_override;
-
+	
 	/* init all audio registers */
 	saa_writeb(SAA7134_AUDIO_PLL_CTRL,   0x00);
 	if (need_resched())
@@ -557,7 +558,7 @@ static int tvaudio_thread(void *data)
 			if (UNSET == audio)
 				audio = i;
 			tvaudio_setmode(dev,&tvaudio[i],"trying");
-			if (tvaudio_sleep(dev,HZ*2))
+			if (tvaudio_sleep(dev,SCAN_SUBCARRIER_DELAY))
 				goto restart;
 			if (-1 != tvaudio_getstereo(dev,&tvaudio[i])) {
 				audio = i;
diff -up linux-2.6.5/drivers/media/video/saa7134/saa7134-video.c linux/drivers/media/video/saa7134/saa7134-video.c
--- linux-2.6.5/drivers/media/video/saa7134/saa7134-video.c	2004-04-05 10:39:25.184620656 +0200
+++ linux/drivers/media/video/saa7134/saa7134-video.c	2004-04-05 10:49:58.705131905 +0200
@@ -30,14 +30,17 @@
 
 /* ------------------------------------------------------------------ */
 
-static unsigned int video_debug  = 0;
-static unsigned int gbuffers     = 8;
-static unsigned int gbufsize     = 768*576*4;
-static unsigned int gbufsize_max = 768*576*4;
+static unsigned int video_debug   = 0;
+static unsigned int gbuffers      = 8;
+static unsigned int noninterlaced = 0;
+static unsigned int gbufsize      = 768*576*4;
+static unsigned int gbufsize_max  = 768*576*4;
 MODULE_PARM(video_debug,"i");
 MODULE_PARM_DESC(video_debug,"enable debug messages [video]");
 MODULE_PARM(gbuffers,"i");
 MODULE_PARM_DESC(gbuffers,"number of capture buffers, range 2-32");
+MODULE_PARM(noninterlaced,"i");
+MODULE_PARM_DESC(noninterlaced,"video input is noninterlaced");
 
 #define dprintk(fmt, arg...)	if (video_debug) \
 	printk(KERN_DEBUG "%s/video: " fmt, dev->name , ## arg)
@@ -149,8 +152,6 @@ static struct saa7134_tvnorm tvnorms[] =
 	{
 		.name          = "PAL",
 		.id            = V4L2_STD_PAL,
-		.width         = 720,
-		.height        = 576,
 
 		.sync_control  = 0x18,
 		.luma_control  = 0x40,
@@ -169,8 +170,6 @@ static struct saa7134_tvnorm tvnorms[] =
 	},{
 		.name          = "NTSC",
 		.id            = V4L2_STD_NTSC,
-		.width         = 720,
-		.height        = 480,
 
 		.sync_control  = 0x59,
 		.luma_control  = 0x40,
@@ -189,8 +188,6 @@ static struct saa7134_tvnorm tvnorms[] =
 	},{
 		.name          = "SECAM",
 		.id            = V4L2_STD_SECAM,
-		.width         = 720,
-		.height        = 576,
 
 		.sync_control  = 0x18, /* old: 0x58, */
 		.luma_control  = 0x1b,
@@ -209,8 +206,6 @@ static struct saa7134_tvnorm tvnorms[] =
 	},{
 		.name          = "PAL-M",
 		.id            = V4L2_STD_PAL_M,
-		.width         = 720,
-		.height        = 480,
 
 		.sync_control  = 0x59,
 		.luma_control  = 0x40,
@@ -229,8 +224,6 @@ static struct saa7134_tvnorm tvnorms[] =
 	},{
 		.name          = "PAL-Nc",
 		.id            = V4L2_STD_PAL_Nc,
-		.width         = 720,
-		.height        = 576,
 
 		.sync_control  = 0x18,
 		.luma_control  = 0x40,
@@ -437,15 +430,33 @@ void res_free(struct saa7134_dev *dev, s
 static void set_tvnorm(struct saa7134_dev *dev, struct saa7134_tvnorm *norm)
 {
 	struct video_channel c;
-	int luma_control,mux;
+	int luma_control,sync_control,mux;
 
 	dprintk("set tv norm = %s\n",norm->name);
 	dev->tvnorm = norm;
 
 	mux = card_in(dev,dev->ctl_input).vmux;
 	luma_control = norm->luma_control;
+	sync_control = norm->sync_control;
+
 	if (mux > 5)
 		luma_control |= 0x80; /* svideo */
+	if (noninterlaced)
+		sync_control |= 0x20;
+
+	/* setup cropping */
+	dev->crop_bounds.left    = norm->h_start;
+	dev->crop_defrect.left   = norm->h_start;
+	dev->crop_bounds.width   = norm->h_stop - norm->h_start +1;
+	dev->crop_defrect.width  = norm->h_stop - norm->h_start +1;
+
+	dev->crop_bounds.top     = (norm->vbi_v_stop+1)*2;
+	dev->crop_defrect.top    = norm->video_v_start*2;
+	dev->crop_bounds.height  = ((norm->id & V4L2_STD_525_60) ? 524 : 624)
+		- dev->crop_bounds.top;
+	dev->crop_defrect.height = (norm->video_v_stop - norm->video_v_start +1)*2;
+
+	dev->crop_current = dev->crop_defrect;
 
 	/* setup video decoder */
 	saa_writeb(SAA7134_INCR_DELAY,            0x08);
@@ -458,7 +469,7 @@ static void set_tvnorm(struct saa7134_de
 	saa_writeb(SAA7134_HSYNC_STOP,            0xe0);
 	saa_writeb(SAA7134_SOURCE_TIMING1,        norm->src_timing);
 	
-	saa_writeb(SAA7134_SYNC_CTRL,             norm->sync_control);
+	saa_writeb(SAA7134_SYNC_CTRL,             sync_control);
 	saa_writeb(SAA7134_LUMA_CTRL,             luma_control);
 	saa_writeb(SAA7134_DEC_LUMA_BRIGHT,       dev->ctl_bright);
 	saa_writeb(SAA7134_DEC_LUMA_CONTRAST,     dev->ctl_contrast);
@@ -563,25 +574,30 @@ static void set_v_scale(struct saa7134_d
 static void set_size(struct saa7134_dev *dev, int task,
 		     int width, int height, int interlace)
 {
-	struct saa7134_tvnorm *norm = dev->tvnorm;
 	int prescale,xscale,yscale,y_even,y_odd;
+	int h_start, h_stop, v_start, v_stop;
 	int div = interlace ? 2 : 1;
 
 	/* setup video scaler */
-	saa_writeb(SAA7134_VIDEO_H_START1(task), norm->h_start       &  0xff);
-	saa_writeb(SAA7134_VIDEO_H_START2(task), norm->h_start       >> 8);
-	saa_writeb(SAA7134_VIDEO_H_STOP1(task),  norm->h_stop        &  0xff);
-	saa_writeb(SAA7134_VIDEO_H_STOP2(task),  norm->h_stop        >> 8);
-	saa_writeb(SAA7134_VIDEO_V_START1(task), norm->video_v_start &  0xff);
-	saa_writeb(SAA7134_VIDEO_V_START2(task), norm->video_v_start >> 8);
-	saa_writeb(SAA7134_VIDEO_V_STOP1(task),  norm->video_v_stop  &  0xff);
-	saa_writeb(SAA7134_VIDEO_V_STOP2(task),  norm->video_v_stop  >> 8);
+	h_start = dev->crop_current.left;
+	v_start = dev->crop_current.top/2;
+	h_stop  = (dev->crop_current.left + dev->crop_current.width -1);
+	v_stop  = (dev->crop_current.top + dev->crop_current.height -1)/2;
+	
+	saa_writeb(SAA7134_VIDEO_H_START1(task), h_start &  0xff);
+	saa_writeb(SAA7134_VIDEO_H_START2(task), h_start >> 8);
+	saa_writeb(SAA7134_VIDEO_H_STOP1(task),  h_stop  &  0xff);
+	saa_writeb(SAA7134_VIDEO_H_STOP2(task),  h_stop  >> 8);
+	saa_writeb(SAA7134_VIDEO_V_START1(task), v_start &  0xff);
+	saa_writeb(SAA7134_VIDEO_V_START2(task), v_start >> 8);
+	saa_writeb(SAA7134_VIDEO_V_STOP1(task),  v_stop  &  0xff);
+	saa_writeb(SAA7134_VIDEO_V_STOP2(task),  v_stop  >> 8);
 
-	prescale = norm->width / width;
+	prescale = dev->crop_defrect.width / width;
 	if (0 == prescale)
 		prescale = 1;
-	xscale = 1024 * norm->width / prescale / width;
-	yscale = 512 * div * norm->height / height;
+	xscale = 1024 * dev->crop_defrect.width / prescale / width;
+	yscale = 512 * div * dev->crop_defrect.height / height;
        	dprintk("prescale=%d xscale=%d yscale=%d\n",prescale,xscale,yscale);
 	set_h_prescale(dev,task,prescale);
 	saa_writeb(SAA7134_H_SCALE_INC1(task),      xscale &  0xff);
@@ -708,8 +724,8 @@ static int verify_preview(struct saa7134
 		return -EINVAL;
 
 	field = win->field;
-	maxw  = dev->tvnorm->width;
-	maxh  = dev->tvnorm->height;
+	maxw  = dev->crop_current.width;
+	maxh  = dev->crop_current.height;
 
 	if (V4L2_FIELD_ANY == field) {
                 field = (win->w.height > maxh/2)
@@ -895,8 +911,8 @@ static int buffer_prepare(struct file *f
 		return -EINVAL;
 	if (fh->width  < 48 ||
 	    fh->height < 32 ||
-	    fh->width  > dev->tvnorm->width ||
-	    fh->height > dev->tvnorm->height)
+	    fh->width  > dev->crop_current.width ||
+	    fh->height > dev->crop_current.height)
 		return -EINVAL;
 	size = (fh->width * fh->height * fh->fmt->depth) >> 3;
 	if (0 != buf->vb.baddr  &&  buf->vb.bsize < size)
@@ -1393,8 +1409,8 @@ int saa7134_try_fmt(struct saa7134_dev *
 			return -EINVAL;
 
 		field = f->fmt.pix.field;
-		maxw  = dev->tvnorm->width;
-		maxh  = dev->tvnorm->height;
+		maxw  = dev->crop_current.width;
+		maxh  = dev->crop_current.height;
 		
 		if (V4L2_FIELD_ANY == field) {
 			field = (f->fmt.pix.height > maxh/2)
@@ -1482,7 +1498,6 @@ int saa7134_s_fmt(struct saa7134_dev *de
 		}
 		up(&dev->lock);
 		return 0;
-		break;
 	case V4L2_BUF_TYPE_VBI_CAPTURE:
 		saa7134_vbi_fmt(dev,f);
 		return 0;
@@ -1674,6 +1689,74 @@ static int video_do_ioctl(struct inode *
 		return 0;
 	}
 
+	case VIDIOC_CROPCAP:
+	{
+		struct v4l2_cropcap *cap = arg;
+
+		if (cap->type != V4L2_BUF_TYPE_VIDEO_CAPTURE &&
+		    cap->type != V4L2_BUF_TYPE_VIDEO_OVERLAY)
+			return -EINVAL;
+		cap->bounds  = dev->crop_bounds;
+		cap->defrect = dev->crop_defrect;
+		cap->pixelaspect.numerator   = 1;
+		cap->pixelaspect.denominator = 1;
+		if (dev->tvnorm->id & V4L2_STD_525_60) {
+			cap->pixelaspect.numerator   = 11;
+			cap->pixelaspect.denominator = 10;
+		}
+		if (dev->tvnorm->id & V4L2_STD_625_50) {
+			cap->pixelaspect.numerator   = 54;
+			cap->pixelaspect.denominator = 59;
+		}
+		return 0;
+	}
+
+	case VIDIOC_G_CROP:
+	{
+		struct v4l2_crop * crop = arg;
+		
+		if (crop->type != V4L2_BUF_TYPE_VIDEO_CAPTURE &&
+		    crop->type != V4L2_BUF_TYPE_VIDEO_OVERLAY)
+			return -EINVAL;
+		crop->c = dev->crop_current;
+		return 0;
+	}
+	case VIDIOC_S_CROP:
+	{
+		struct v4l2_crop *crop = arg;
+		struct v4l2_rect *b = &dev->crop_bounds;
+		
+		if (crop->type != V4L2_BUF_TYPE_VIDEO_CAPTURE &&
+		    crop->type != V4L2_BUF_TYPE_VIDEO_OVERLAY)
+			return -EINVAL;
+		if (crop->c.height < 0)
+			return -EINVAL;
+		if (crop->c.width < 0)
+			return -EINVAL;
+
+		if (res_locked(fh->dev,RESOURCE_OVERLAY))
+			return -EBUSY;
+		if (res_locked(fh->dev,RESOURCE_VIDEO))
+			return -EBUSY;
+
+		if (crop->c.top < b->top)
+			crop->c.top = b->top;
+		if (crop->c.top > b->top + b->height)
+			crop->c.top = b->top + b->height;
+		if (crop->c.height > b->top - crop->c.top + b->height)
+			crop->c.height = b->top - crop->c.top + b->height;
+		
+		if (crop->c.left < b->left)
+			crop->c.top = b->left;
+		if (crop->c.left > b->left + b->width)
+			crop->c.top = b->left + b->width;
+		if (crop->c.width > b->left - crop->c.left + b->width)
+			crop->c.width = b->left - crop->c.left + b->width;
+
+		dev->crop_current = crop->c;
+		return 0;
+	}
+
 	/* --- tuner ioctls ------------------------------------------ */
 	case VIDIOC_G_TUNER:
 	{
diff -up linux-2.6.5/drivers/media/video/saa7134/saa7134.h linux/drivers/media/video/saa7134/saa7134.h
--- linux-2.6.5/drivers/media/video/saa7134/saa7134.h	2004-04-05 10:42:14.417688337 +0200
+++ linux/drivers/media/video/saa7134/saa7134.h	2004-04-05 10:50:14.832092650 +0200
@@ -19,7 +19,7 @@
  */
 
 #include <linux/version.h>
-#define SAA7134_VERSION_CODE KERNEL_VERSION(0,2,9)
+#define SAA7134_VERSION_CODE KERNEL_VERSION(0,2,11)
 
 #include <linux/pci.h>
 #include <linux/i2c.h>
@@ -73,8 +73,6 @@ enum saa7134_video_out {
 struct saa7134_tvnorm {
 	char          *name;
 	v4l2_std_id   id;
-	unsigned int  width;
-	unsigned int  height;
 
 	/* video decoder */
 	unsigned int  sync_control;
@@ -301,7 +299,8 @@ struct saa7134_oss {
 	unsigned int               afmt;
 	unsigned int               rate;
 	unsigned int               channels;
-	unsigned int               recording;
+	unsigned int               recording_on;
+	unsigned int               dma_running;
 	unsigned int               blocks;
 	unsigned int               blksize;
 	unsigned int               bufsize;
@@ -394,7 +393,12 @@ struct saa7134_dev {
 	int                        ctl_mirror;
 	int                        ctl_y_odd;
 	int                        ctl_y_even;
-
+	
+	/* crop */
+	struct v4l2_rect           crop_bounds;
+	struct v4l2_rect           crop_defrect;
+	struct v4l2_rect           crop_current;
+	
 	/* other global state info */
 	unsigned int               automute;
 	struct saa7134_thread      thread;

-- 
http://bigendian.bytesex.org
