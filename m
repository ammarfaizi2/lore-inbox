Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261913AbUDELkq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 07:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbUDELkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 07:40:46 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:12447 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261913AbUDELkn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 07:40:43 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 5 Apr 2004 13:45:15 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l: v4l1-compat fix
Message-ID: <20040405114514.GA29287@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

Minor tweak in the v4l1 compatibility layer:  Make sure that capture
actually is active before going to wait for a frame so we don't block
forever.

  Gerd

diff -up linux-2.6.5/drivers/media/video/v4l1-compat.c linux/drivers/media/video/v4l1-compat.c
--- linux-2.6.5/drivers/media/video/v4l1-compat.c	2004-04-05 10:41:12.965282978 +0200
+++ linux/drivers/media/video/v4l1-compat.c	2004-04-05 10:49:56.946463339 +0200
@@ -289,6 +289,7 @@ v4l_compat_translate_ioctl(struct inode 
 {
 	struct v4l2_capability  *cap2 = NULL;
 	struct v4l2_format	*fmt2 = NULL;
+	enum v4l2_buf_type      captype = V4L2_BUF_TYPE_VIDEO_CAPTURE;
 
 	struct v4l2_framebuffer fbuf2;
 	struct v4l2_input	input2;
@@ -465,6 +466,7 @@ v4l_compat_translate_ioctl(struct inode 
 		fmt2 = kmalloc(sizeof(*fmt2),GFP_KERNEL);
 		memset(fmt2,0,sizeof(*fmt2));
 		fmt2->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
+		drv(inode, file, VIDIOC_STREAMOFF, &fmt2->type);
 		err1 = drv(inode, file, VIDIOC_G_FMT, fmt2);
 		if (err1 < 0)
 			dprintk("VIDIOCSWIN / VIDIOC_G_FMT: %d\n",err);
@@ -503,11 +505,10 @@ v4l_compat_translate_ioctl(struct inode 
 		int *on = arg;
 
 		if (0 == *on) {
-			enum v4l2_buf_type type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
 			/* dirty hack time.  But v4l1 has no STREAMOFF
 			 * equivalent in the API, and this one at
 			 * least comes close ... */
-			drv(inode, file, VIDIOC_STREAMOFF, &type);
+			drv(inode, file, VIDIOC_STREAMOFF, &captype);
 		}
 		err = drv(inode, file, VIDIOC_OVERLAY, arg);
 		if (err < 0)
@@ -858,7 +859,6 @@ v4l_compat_translate_ioctl(struct inode 
 	case VIDIOCMCAPTURE: /*  capture a frame  */
 	{
 		struct video_mmap	*mm = arg;
-		enum v4l2_buf_type	type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
 
 		fmt2 = kmalloc(sizeof(*fmt2),GFP_KERNEL);
 		memset(&buf2,0,sizeof(buf2));
@@ -899,7 +899,7 @@ v4l_compat_translate_ioctl(struct inode 
 			dprintk("VIDIOCMCAPTURE / VIDIOC_QBUF: %d\n",err);
 			break;
 		}
-		err = drv(inode, file, VIDIOC_STREAMON, &type);
+		err = drv(inode, file, VIDIOC_STREAMON, &captype);
 		if (err < 0)
 			dprintk("VIDIOCMCAPTURE / VIDIOC_STREAMON: %d\n",err);
 		break;
@@ -922,6 +922,13 @@ v4l_compat_translate_ioctl(struct inode 
 			break;
 		}
 
+		/* make sure capture actually runs so we don't block forever */
+		err = drv(inode, file, VIDIOC_STREAMON, &captype);
+		if (err < 0) {
+			dprintk("VIDIOCSYNC / VIDIOC_STREAMON: %d\n",err);
+			break;
+		}
+		
 		/*  Loop as long as the buffer is queued, but not done  */
 		while ((buf2.flags &
 			(V4L2_BUF_FLAG_QUEUED | V4L2_BUF_FLAG_DONE))
diff -up linux-2.6.5/include/linux/videodev.h linux/include/linux/videodev.h
--- linux-2.6.5/include/linux/videodev.h	2004-04-05 10:43:54.751759090 +0200
+++ linux/include/linux/videodev.h	2004-04-05 10:49:56.951462397 +0200
@@ -430,6 +430,7 @@ struct video_code
 #define VID_HARDWARE_VICAM      34
 #define VID_HARDWARE_SF16FMR2	35
 #define VID_HARDWARE_W9968CF    36
+#define VID_HARDWARE_SAA7114H   37
 #endif /* __LINUX_VIDEODEV_H */
 
 /*
