Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbUCBKAQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 05:00:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbUCBKAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 05:00:16 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:38037 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261580AbUCBKAK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 05:00:10 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 2 Mar 2004 10:53:25 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l1 compatibility module fix.
Message-ID: <20040302095325.GA24177@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch fixes a bug in the v4l1-compat module and makes it pass the
correct buffer type to the v4l2 driver on VIDIOC_STREAM(ON|OFF) ioctls.

Please apply,

  Gerd

diff -up linux-2.6.3/drivers/media/video/v4l1-compat.c linux/drivers/media/video/v4l1-compat.c
--- linux-2.6.3/drivers/media/video/v4l1-compat.c	2004-02-24 11:09:00.598290782 +0100
+++ linux/drivers/media/video/v4l1-compat.c	2004-02-24 11:35:08.977166565 +0100
@@ -503,10 +503,11 @@ v4l_compat_translate_ioctl(struct inode 
 		int *on = arg;
 
 		if (0 == *on) {
+			enum v4l2_buf_type type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
 			/* dirty hack time.  But v4l1 has no STREAMOFF
 			 * equivalent in the API, and this one at
 			 * least comes close ... */
-			drv(inode, file, VIDIOC_STREAMOFF, NULL);
+			drv(inode, file, VIDIOC_STREAMOFF, &type);
 		}
 		err = drv(inode, file, VIDIOC_OVERLAY, arg);
 		if (err < 0)
@@ -857,6 +858,7 @@ v4l_compat_translate_ioctl(struct inode 
 	case VIDIOCMCAPTURE: /*  capture a frame  */
 	{
 		struct video_mmap	*mm = arg;
+		enum v4l2_buf_type	type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
 
 		fmt2 = kmalloc(sizeof(*fmt2),GFP_KERNEL);
 		memset(&buf2,0,sizeof(buf2));
@@ -897,7 +899,7 @@ v4l_compat_translate_ioctl(struct inode 
 			dprintk("VIDIOCMCAPTURE / VIDIOC_QBUF: %d\n",err);
 			break;
 		}
-		err = drv(inode, file, VIDIOC_STREAMON, NULL);
+		err = drv(inode, file, VIDIOC_STREAMON, &type);
 		if (err < 0)
 			dprintk("VIDIOCMCAPTURE / VIDIOC_STREAMON: %d\n",err);
 		break;
