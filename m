Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965228AbWCTPSf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965228AbWCTPSf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966582AbWCTPSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:18:35 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:60824 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966569AbWCTPS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:18:27 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 023/141] V4L/DVB (3422): Implemented VIDIOC_G_FMT/S_FMT for
	sliced VBI
Date: Mon, 20 Mar 2006 12:08:40 -0300
Message-id: <20060320150840.PS860338000023@infradead.org>
In-Reply-To: <20060320150819.PS760228000000@infradead.org>
References: <20060320150819.PS760228000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab@infradead.org>
Date: 1138043468 -0200

- Implemented VIDIOC_G_FMT/S_FMT for sliced VBI
- VIDIOC_S_FMT now calls a function

Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/em28xx/em28xx-video.c b/drivers/media/video/em28xx/em28xx-video.c
diff --git a/drivers/media/video/em28xx/em28xx-video.c b/drivers/media/video/em28xx/em28xx-video.c
index e4e82ae..d8d02c4 100644
--- a/drivers/media/video/em28xx/em28xx-video.c
+++ b/drivers/media/video/em28xx/em28xx-video.c
@@ -897,7 +897,6 @@ static int em28xx_set_norm(struct em28xx
 	return 0;
 }
 
-
 static int em28xx_get_fmt(struct em28xx *dev, struct v4l2_format *format)
 {
 	em28xx_videodbg("VIDIOC_G_FMT: type=%s\n",
@@ -909,7 +908,9 @@ static int em28xx_get_fmt(struct em28xx 
 		"V4L2_BUF_TYPE_SLICED_VBI_CAPTURE " :
 		"not supported");
 
-	if (format->type == V4L2_BUF_TYPE_VIDEO_CAPTURE) {
+	switch (format->type) {
+	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
+	{
 		format->fmt.pix.width = dev->width;
 		format->fmt.pix.height = dev->height;
 		format->fmt.pix.pixelformat = V4L2_PIX_FMT_YUYV;
@@ -920,12 +921,161 @@ static int em28xx_get_fmt(struct em28xx 
 
 		em28xx_videodbg("VIDIOC_G_FMT: %dx%d\n", dev->width,
 			dev->height);
-		return 0;
+		break;
 	}
 
-	return -EINVAL;
+	case V4L2_BUF_TYPE_SLICED_VBI_CAPTURE:
+	{
+		format->fmt.sliced.service_set=0;
+
+		em28xx_i2c_call_clients(dev,VIDIOC_G_FMT,format);
+
+		if (format->fmt.sliced.service_set==0)
+			return -EINVAL;
+
+		break;
+	}
+
+	default:
+		return -EINVAL;
+	}
+	return (0);
 }
 
+static int em28xx_set_fmt(struct em28xx *dev, unsigned int cmd, struct v4l2_format *format)
+{
+	u32 i;
+	int ret = 0;
+	int width = format->fmt.pix.width;
+	int height = format->fmt.pix.height;
+	unsigned int hscale, vscale;
+	unsigned int maxh, maxw;
+
+	maxw = norm_maxw(dev);
+	maxh = norm_maxh(dev);
+
+	em28xx_videodbg("%s: type=%s\n",
+			cmd == VIDIOC_TRY_FMT ?
+			"VIDIOC_TRY_FMT" : "VIDIOC_S_FMT",
+			format->type == V4L2_BUF_TYPE_VIDEO_CAPTURE ?
+			"V4L2_BUF_TYPE_VIDEO_CAPTURE" :
+			format->type == V4L2_BUF_TYPE_VBI_CAPTURE ?
+			"V4L2_BUF_TYPE_VBI_CAPTURE " :
+			"not supported");
+
+	if (format->type == V4L2_BUF_TYPE_SLICED_VBI_CAPTURE) {
+		em28xx_i2c_call_clients(dev,VIDIOC_G_FMT,format);
+
+		if (format->fmt.sliced.service_set==0)
+			return -EINVAL;
+
+		return 0;
+	}
+
+
+	if (format->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
+		return -EINVAL;
+
+	em28xx_videodbg("%s: requested %dx%d\n",
+		cmd == VIDIOC_TRY_FMT ?
+		"VIDIOC_TRY_FMT" : "VIDIOC_S_FMT",
+		format->fmt.pix.width, format->fmt.pix.height);
+
+	/* FIXME: Move some code away from here */
+	/* width must even because of the YUYV format */
+	/* height must be even because of interlacing */
+	height &= 0xfffe;
+	width &= 0xfffe;
+
+	if (height < 32)
+		height = 32;
+	if (height > maxh)
+		height = maxh;
+	if (width < 48)
+		width = 48;
+	if (width > maxw)
+		width = maxw;
+
+	if(dev->is_em2800){
+		/* the em2800 can only scale down to 50% */
+		if(height % (maxh / 2))
+			height=maxh;
+		if(width % (maxw / 2))
+			width=maxw;
+		/* according to empiatech support */
+		/* the MaxPacketSize is to small to support */
+		/* framesizes larger than 640x480 @ 30 fps */
+		/* or 640x576 @ 25 fps. As this would cut */
+		/* of a part of the image we prefer */
+		/* 360x576 or 360x480 for now */
+		if(width == maxw && height == maxh)
+			width /= 2;
+	}
+
+	if ((hscale =
+	(((unsigned long)maxw) << 12) / width - 4096L) >=
+	0x4000)
+		hscale = 0x3fff;
+	width =
+	(((unsigned long)maxw) << 12) / (hscale + 4096L);
+
+	if ((vscale =
+	(((unsigned long)maxh) << 12) / height - 4096L) >=
+	0x4000)
+		vscale = 0x3fff;
+	height =
+	(((unsigned long)maxh) << 12) / (vscale + 4096L);
+
+	format->fmt.pix.width = width;
+	format->fmt.pix.height = height;
+	format->fmt.pix.pixelformat = V4L2_PIX_FMT_YUYV;
+	format->fmt.pix.bytesperline = width * 2;
+	format->fmt.pix.sizeimage = width * 2 * height;
+	format->fmt.pix.colorspace = V4L2_COLORSPACE_SMPTE170M;
+	format->fmt.pix.field = V4L2_FIELD_INTERLACED;
+
+	em28xx_videodbg("%s: returned %dx%d (%d, %d)\n",
+		cmd ==
+		VIDIOC_TRY_FMT ? "VIDIOC_TRY_FMT" :
+		"VIDIOC_S_FMT", format->fmt.pix.width,
+		format->fmt.pix.height, hscale, vscale);
+
+	if (cmd == VIDIOC_TRY_FMT)
+		return 0;
+
+	for (i = 0; i < dev->num_frames; i++)
+		if (dev->frame[i].vma_use_count) {
+			em28xx_videodbg("VIDIOC_S_FMT failed. "
+				"Unmap the buffers first.\n");
+			return -EINVAL;
+		}
+
+	/* stop io in case it is already in progress */
+	if (dev->stream == STREAM_ON) {
+		em28xx_videodbg("VIDIOC_SET_FMT: interupting stream\n");
+		if ((ret = em28xx_stream_interrupt(dev)))
+			return ret;
+	}
+
+	em28xx_release_buffers(dev);
+	dev->io = IO_NONE;
+
+	/* set new image size */
+	dev->width = width;
+	dev->height = height;
+	dev->frame_size = dev->width * dev->height * 2;
+	dev->field_size = dev->frame_size >> 1;	/*both_fileds ? dev->frame_size>>1 : dev->frame_size; */
+	dev->bytesperline = dev->width * 2;
+	dev->hscale = hscale;
+	dev->vscale = vscale;
+	em28xx_uninit_isoc(dev);
+	em28xx_set_alternate(dev);
+	em28xx_capture_start(dev, 1);
+	em28xx_resolution_set(dev);
+	em28xx_init_isoc(dev);
+
+	return 0;
+}
 
 /*
  * em28xx_v4l2_do_ioctl()
@@ -983,24 +1133,6 @@ static int em28xx_do_ioctl(struct inode 
 
 			em28xx_set_norm(dev, dev->width, dev->height);
 
-/*
-		dev->width=norm_maxw(dev);
-		dev->height=norm_maxh(dev);
-		dev->frame_size=dev->width*dev->height*2;
-		dev->field_size=dev->frame_size>>1;
-		dev->bytesperline=dev->width*2;
-		dev->hscale=0;
-		dev->vscale=0;
-
-		em28xx_resolution_set(dev);
-*/
-/*
-		em28xx_uninit_isoc(dev);
-		em28xx_set_alternate(dev);
-		em28xx_capture_start(dev, 1);
-		em28xx_resolution_set(dev);
-		em28xx_init_isoc(dev);
-*/
 			em28xx_i2c_call_clients(dev, DECODER_SET_NORM,
 						&tvnorms[i].mode);
 			em28xx_i2c_call_clients(dev, VIDIOC_S_STD,
@@ -1396,138 +1528,8 @@ static int em28xx_video_do_ioctl(struct 
 
 	case VIDIOC_TRY_FMT:
 	case VIDIOC_S_FMT:
-		{
-			struct v4l2_format *format = arg;
-			u32 i;
-			int ret = 0;
-			int width = format->fmt.pix.width;
-			int height = format->fmt.pix.height;
-			unsigned int hscale, vscale;
-			unsigned int maxh, maxw;
-
-			maxw = norm_maxw(dev);
-			maxh = norm_maxh(dev);
-
-/*		int both_fields; */
-
-			em28xx_videodbg("%s: type=%s\n",
-				 cmd ==
-				 VIDIOC_TRY_FMT ? "VIDIOC_TRY_FMT" :
-				 "VIDIOC_S_FMT",
-				 format->type ==
-				 V4L2_BUF_TYPE_VIDEO_CAPTURE ?
-				 "V4L2_BUF_TYPE_VIDEO_CAPTURE" : format->type ==
-				 V4L2_BUF_TYPE_VBI_CAPTURE ?
-				 "V4L2_BUF_TYPE_VBI_CAPTURE " :
-				 "not supported");
-
-			if (format->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
-				return -EINVAL;
-
-			em28xx_videodbg("%s: requested %dx%d\n",
-				 cmd ==
-				 VIDIOC_TRY_FMT ? "VIDIOC_TRY_FMT" :
-				 "VIDIOC_S_FMT", format->fmt.pix.width,
-				 format->fmt.pix.height);
-
-			/* FIXME: Move some code away from here */
-			/* width must even because of the YUYV format */
-			/* height must be even because of interlacing */
-			height &= 0xfffe;
-			width &= 0xfffe;
-
-			if (height < 32)
-				height = 32;
-			if (height > maxh)
-				height = maxh;
-			if (width < 48)
-				width = 48;
-			if (width > maxw)
-				width = maxw;
-
-			if(dev->is_em2800){
-				/* the em2800 can only scale down to 50% */
-				if(height % (maxh / 2))
-					height=maxh;
-				if(width % (maxw / 2))
-					width=maxw;
-				/* according to empiatech support */
-				/* the MaxPacketSize is to small to support */
-				/* framesizes larger than 640x480 @ 30 fps */
-				/* or 640x576 @ 25 fps. As this would cut */
-				/* of a part of the image we prefer */
-				/* 360x576 or 360x480 for now */
-				if(width == maxw && height == maxh)
-					width /= 2;
-			}
-
-			if ((hscale =
-			     (((unsigned long)maxw) << 12) / width - 4096L) >=
-			    0x4000)
-				hscale = 0x3fff;
-			width =
-			    (((unsigned long)maxw) << 12) / (hscale + 4096L);
-
-			if ((vscale =
-			     (((unsigned long)maxh) << 12) / height - 4096L) >=
-			    0x4000)
-				vscale = 0x3fff;
-			height =
-			    (((unsigned long)maxh) << 12) / (vscale + 4096L);
-
-			format->fmt.pix.width = width;
-			format->fmt.pix.height = height;
-			format->fmt.pix.pixelformat = V4L2_PIX_FMT_YUYV;
-			format->fmt.pix.bytesperline = width * 2;
-			format->fmt.pix.sizeimage = width * 2 * height;
-			format->fmt.pix.colorspace = V4L2_COLORSPACE_SMPTE170M;
-			format->fmt.pix.field = V4L2_FIELD_INTERLACED;
-
-			em28xx_videodbg("%s: returned %dx%d (%d, %d)\n",
-				 cmd ==
-				 VIDIOC_TRY_FMT ? "VIDIOC_TRY_FMT" :
-				 "VIDIOC_S_FMT", format->fmt.pix.width,
-				 format->fmt.pix.height, hscale, vscale);
-
-			if (cmd == VIDIOC_TRY_FMT)
-				return 0;
-
-			for (i = 0; i < dev->num_frames; i++)
-				if (dev->frame[i].vma_use_count) {
-					em28xx_videodbg("VIDIOC_S_FMT failed. "
-						"Unmap the buffers first.\n");
-					return -EINVAL;
-				}
-
-			/* stop io in case it is already in progress */
-			if (dev->stream == STREAM_ON) {
-				em28xx_videodbg("VIDIOC_SET_FMT: interupting stream\n");
-				if ((ret = em28xx_stream_interrupt(dev)))
-					return ret;
-			}
-
-			em28xx_release_buffers(dev);
-			dev->io = IO_NONE;
-
-			/* set new image size */
-			dev->width = width;
-			dev->height = height;
-			dev->frame_size = dev->width * dev->height * 2;
-			dev->field_size = dev->frame_size >> 1;	/*both_fileds ? dev->frame_size>>1 : dev->frame_size; */
-			dev->bytesperline = dev->width * 2;
-			dev->hscale = hscale;
-			dev->vscale = vscale;
-/*			dev->both_fileds = both_fileds; */
-			em28xx_uninit_isoc(dev);
-			em28xx_set_alternate(dev);
-			em28xx_capture_start(dev, 1);
-			em28xx_resolution_set(dev);
-			em28xx_init_isoc(dev);
-
-			return 0;
-		}
+		return em28xx_set_fmt(dev, cmd, (struct v4l2_format *)arg);
 
-		/* --- streaming capture ------------------------------------- */
 	case VIDIOC_REQBUFS:
 		{
 			struct v4l2_requestbuffers *rb = arg;

