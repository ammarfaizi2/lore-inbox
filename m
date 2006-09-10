Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932319AbWIJRJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbWIJRJf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 13:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbWIJRJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 13:09:30 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:49126 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932312AbWIJRJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 13:09:06 -0400
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 4/6] V4L/DVB (4605): Fixes an issue with V4L1 and make
	headers-install
Date: Sun, 10 Sep 2006 14:06:45 -0300
Message-id: <20060910170645.PS6958300004@infradead.org>
In-Reply-To: <20060910170419.PS3030230000@infradead.org>
References: <20060910170419.PS3030230000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.92-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Mauro Carvalho Chehab <mchehab@infradead.org>

V4L1 support should be disabled when no CONFIG_VIDEO_V4L1_COMPAT is defined,
to allow checking for broken V4L2 ports. This is very important during the
migration phase for V4L2 API.
However, userspace apps should be capable of using both APIs, since they need
to test at runtime, via VIDIOCGCAP ioctl, if V4L1 is supported. So, when
__KERNEL__ is not defined, those ioctls and corresponding structs should be
visible.
This patch also removes the obsolete defines HAVE_V4L1 and HAVE_V4L2, that
where causing some confusion, and were replaced by CONFIG_VIDEO_V4L1_COMPAT
and CONFIG_VIDEO_V4L2.

Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/Kconfig              |    2 +-
 drivers/media/video/zoran.h        |    2 +-
 drivers/media/video/zoran_driver.c |   22 +++++++++++-----------
 include/linux/videodev.h           |    3 +--
 include/linux/videodev2.h          |    2 --
 include/media/v4l2-dev.h           |    7 ++++---
 6 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/media/Kconfig b/drivers/media/Kconfig
index ef52e6d..ed4aa4e 100644
--- a/drivers/media/Kconfig
+++ b/drivers/media/Kconfig
@@ -53,7 +53,7 @@ config VIDEO_V4L1_COMPAT
 	  If you are unsure as to whether this is required, answer Y.
 
 config VIDEO_V4L2
-	tristate
+	bool
 	default y
 
 source "drivers/media/video/Kconfig"
diff --git a/drivers/media/video/zoran.h b/drivers/media/video/zoran.h
index ffcda95..8fb4a34 100644
--- a/drivers/media/video/zoran.h
+++ b/drivers/media/video/zoran.h
@@ -267,7 +267,7 @@ struct zoran_v4l_settings {
 };
 
 /* whoops, this one is undeclared if !v4l2 */
-#ifndef HAVE_V4L2
+#ifndef CONFIG_VIDEO_V4L2
 struct v4l2_jpegcompression {
 	int quality;
 	int APPn;
diff --git a/drivers/media/video/zoran_driver.c b/drivers/media/video/zoran_driver.c
index d9a5876..5f90db2 100644
--- a/drivers/media/video/zoran_driver.c
+++ b/drivers/media/video/zoran_driver.c
@@ -86,7 +86,7 @@ #include "zoran.h"
 #include "zoran_device.h"
 #include "zoran_card.h"
 
-#ifdef HAVE_V4L2
+#ifdef CONFIG_VIDEO_V4L2
 	/* we declare some card type definitions here, they mean
 	 * the same as the v4l1 ZORAN_VID_TYPE above, except it's v4l2 */
 #define ZORAN_V4L2_VID_FLAGS ( \
@@ -103,7 +103,7 @@ const struct zoran_format zoran_formats[
 	{
 		.name = "15-bit RGB",
 		.palette = VIDEO_PALETTE_RGB555,
-#ifdef HAVE_V4L2
+#ifdef CONFIG_VIDEO_V4L2
 #ifdef __LITTLE_ENDIAN
 		.fourcc = V4L2_PIX_FMT_RGB555,
 #else
@@ -117,7 +117,7 @@ #endif
 	}, {
 		.name = "16-bit RGB",
 		.palette = VIDEO_PALETTE_RGB565,
-#ifdef HAVE_V4L2
+#ifdef CONFIG_VIDEO_V4L2
 #ifdef __LITTLE_ENDIAN
 		.fourcc = V4L2_PIX_FMT_RGB565,
 #else
@@ -131,7 +131,7 @@ #endif
 	}, {
 		.name = "24-bit RGB",
 		.palette = VIDEO_PALETTE_RGB24,
-#ifdef HAVE_V4L2
+#ifdef CONFIG_VIDEO_V4L2
 #ifdef __LITTLE_ENDIAN
 		.fourcc = V4L2_PIX_FMT_BGR24,
 #else
@@ -145,7 +145,7 @@ #endif
 	}, {
 		.name = "32-bit RGB",
 		.palette = VIDEO_PALETTE_RGB32,
-#ifdef HAVE_V4L2
+#ifdef CONFIG_VIDEO_V4L2
 #ifdef __LITTLE_ENDIAN
 		.fourcc = V4L2_PIX_FMT_BGR32,
 #else
@@ -159,7 +159,7 @@ #endif
 	}, {
 		.name = "4:2:2, packed, YUYV",
 		.palette = VIDEO_PALETTE_YUV422,
-#ifdef HAVE_V4L2
+#ifdef CONFIG_VIDEO_V4L2
 		.fourcc = V4L2_PIX_FMT_YUYV,
 		.colorspace = V4L2_COLORSPACE_SMPTE170M,
 #endif
@@ -169,7 +169,7 @@ #endif
 	}, {
 		.name = "Hardware-encoded Motion-JPEG",
 		.palette = -1,
-#ifdef HAVE_V4L2
+#ifdef CONFIG_VIDEO_V4L2
 		.fourcc = V4L2_PIX_FMT_MJPEG,
 		.colorspace = V4L2_COLORSPACE_SMPTE170M,
 #endif
@@ -210,7 +210,7 @@ static int lock_norm = 0;	/* 1=Don't cha
 module_param(lock_norm, int, 0);
 MODULE_PARM_DESC(lock_norm, "Users can't change norm");
 
-#ifdef HAVE_V4L2
+#ifdef CONFIG_VIDEO_V4L2
 	/* small helper function for calculating buffersizes for v4l2
 	 * we calculate the nearest higher power-of-two, which
 	 * will be the recommended buffersize */
@@ -1761,7 +1761,7 @@ setup_overlay (struct file *file,
 	return wait_grab_pending(zr);
 }
 
-#ifdef HAVE_V4L2
+#ifdef CONFIG_VIDEO_V4L2
 	/* get the status of a buffer in the clients buffer queue */
 static int
 zoran_v4l2_buffer_status (struct file        *file,
@@ -2676,7 +2676,7 @@ zoran_do_ioctl (struct inode *inode,
 	}
 		break;
 
-#ifdef HAVE_V4L2
+#ifdef CONFIG_VIDEO_V4L2
 
 		/* The new video4linux2 capture interface - much nicer than video4linux1, since
 		 * it allows for integrating the JPEG capturing calls inside standard v4l2
@@ -4689,7 +4689,7 @@ static struct file_operations zoran_fops
 struct video_device zoran_template __devinitdata = {
 	.name = ZORAN_NAME,
 	.type = ZORAN_VID_TYPE,
-#ifdef HAVE_V4L2
+#ifdef CONFIG_VIDEO_V4L2
 	.type2 = ZORAN_V4L2_VID_FLAGS,
 #endif
 	.hardware = ZORAN_HARDWARE,
diff --git a/include/linux/videodev.h b/include/linux/videodev.h
index 518c7a3..8dba97a 100644
--- a/include/linux/videodev.h
+++ b/include/linux/videodev.h
@@ -14,8 +14,7 @@ #define __LINUX_VIDEODEV_H
 
 #include <linux/videodev2.h>
 
-#ifdef CONFIG_VIDEO_V4L1_COMPAT
-#define HAVE_V4L1 1
+#if defined(CONFIG_VIDEO_V4L1_COMPAT) || !defined (__KERNEL__)
 
 struct video_capability
 {
diff --git a/include/linux/videodev2.h b/include/linux/videodev2.h
index b714695..e3715d7 100644
--- a/include/linux/videodev2.h
+++ b/include/linux/videodev2.h
@@ -22,8 +22,6 @@ #define __user
 #endif
 #include <linux/types.h>
 
-#define HAVE_V4L2 1
-
 /*
  * Common stuff for both V4L1 and V4L2
  * Moved from videodev.h
diff --git a/include/media/v4l2-dev.h b/include/media/v4l2-dev.h
index 600d61d..810462f 100644
--- a/include/media/v4l2-dev.h
+++ b/include/media/v4l2-dev.h
@@ -194,7 +194,7 @@ struct video_device
 
 
 	int (*vidioc_overlay) (struct file *file, void *fh, unsigned int i);
-#ifdef HAVE_V4L1
+#ifdef CONFIG_VIDEO_V4L1_COMPAT
 			/* buffer type is struct vidio_mbuf * */
 	int (*vidiocgmbuf)  (struct file *file, void *fh, struct video_mbuf *p);
 #endif
@@ -335,7 +335,7 @@ extern int video_usercopy(struct inode *
 				      unsigned int cmd, void *arg));
 
 
-#ifdef HAVE_V4L1
+#ifdef CONFIG_VIDEO_V4L1_COMPAT
 #include <linux/mm.h>
 
 extern struct video_device* video_devdata(struct file*);
@@ -357,6 +357,8 @@ video_device_remove_file(struct video_de
 	class_device_remove_file(&vfd->class_dev, attr);
 }
 
+#endif /* CONFIG_VIDEO_V4L1_COMPAT */
+
 #ifdef OBSOLETE_OWNER /* to be removed soon */
 /* helper functions to access driver private data. */
 static inline void *video_get_drvdata(struct video_device *dev)
@@ -372,6 +374,5 @@ #endif
 
 extern int video_exclusive_open(struct inode *inode, struct file *file);
 extern int video_exclusive_release(struct inode *inode, struct file *file);
-#endif /* HAVE_V4L1 */
 
 #endif /* _V4L2_DEV_H */

