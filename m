Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030212AbWHHVMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030212AbWHHVMa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 17:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030266AbWHHVM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 17:12:29 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:50634 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030212AbWHHVMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 17:12:15 -0400
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 02/14] V4L/DVB (4371a): Fix V4L1 dependencies on
	compat_ioctl32
Date: Tue, 08 Aug 2006 18:06:52 -0300
Message-id: <20060808210652.PS88614700002@infradead.org>
In-Reply-To: <20060808210151.PS78629800000@infradead.org>
References: <20060808210151.PS78629800000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.2.1-4mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Mauro Carvalho Chehab <mchehab@infradead.org>

Compat32 should be able to handle V4L1 ioctls if the old API support were
selected.

Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/compat_ioctl32.c |   32 ++++++++++++++++++++++++++++----
 1 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/media/video/compat_ioctl32.c b/drivers/media/video/compat_ioctl32.c
index 9dddff4..b69ee11 100644
--- a/drivers/media/video/compat_ioctl32.c
+++ b/drivers/media/video/compat_ioctl32.c
@@ -21,7 +21,7 @@ #include <media/v4l2-common.h>
 
 #ifdef CONFIG_COMPAT
 
-
+#ifdef CONFIG_VIDEO_V4L1_COMPAT
 struct video_tuner32 {
 	compat_int_t tuner;
 	char name[32];
@@ -107,6 +107,7 @@ struct video_window32 {
 	compat_caddr_t clips;
 	compat_int_t clipcount;
 };
+#endif
 
 static int native_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
@@ -124,6 +125,7 @@ static int native_ioctl(struct file *fil
 }
 
 
+#ifdef CONFIG_VIDEO_V4L1_COMPAT
 /* You get back everything except the clips... */
 static int put_video_window32(struct video_window *kp, struct video_window32 __user *up)
 {
@@ -138,6 +140,7 @@ static int put_video_window32(struct vid
 			return -EFAULT;
 	return 0;
 }
+#endif
 
 struct v4l2_clip32
 {
@@ -490,6 +493,7 @@ static inline int put_v4l2_input(struct 
 	return 0;
 }
 
+#ifdef CONFIG_VIDEO_V4L1_COMPAT
 struct video_code32
 {
 	char		loadwhat[16];	/* name or tag of file being passed */
@@ -517,6 +521,8 @@ #define VIDIOCGFREQ32		_IOR('v',14, u32)
 #define VIDIOCSFREQ32		_IOW('v',15, u32)
 #define VIDIOCSMICROCODE32	_IOW('v',27, struct video_code32)
 
+#endif
+
 /* VIDIOC_ENUMINPUT32 is VIDIOC_ENUMINPUT minus 4 bytes of padding alignement */
 #define VIDIOC_ENUMINPUT32	VIDIOC_ENUMINPUT - _IOC(0, 0, 0, 4)
 #define VIDIOC_G_FMT32		_IOWR ('V',  4, struct v4l2_format32)
@@ -537,6 +543,7 @@ #define VIDIOC_G_INPUT32	_IOR  ('V', 38,
 #define VIDIOC_S_INPUT32	_IOWR ('V', 39, compat_int_t)
 #define VIDIOC_TRY_FMT32      	_IOWR ('V', 64, struct v4l2_format32)
 
+#ifdef CONFIG_VIDEO_V4L1_COMPAT
 enum {
 	MaxClips = (~0U-sizeof(struct video_window))/sizeof(struct video_clip)
 };
@@ -601,14 +608,17 @@ static int do_set_window(struct file *fi
 
 	return native_ioctl(file, VIDIOCSWIN, (unsigned long)vw);
 }
+#endif
 
 static int do_video_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	union {
+#ifdef CONFIG_VIDEO_V4L1_COMPAT
 		struct video_tuner vt;
 		struct video_buffer vb;
 		struct video_window vw;
 		struct video_code vc;
+#endif
 		struct v4l2_format v2f;
 		struct v4l2_buffer v2b;
 		struct v4l2_framebuffer v2fb;
@@ -624,6 +634,7 @@ static int do_video_ioctl(struct file *f
 
 	/* First, convert the command. */
 	switch(cmd) {
+#ifdef CONFIG_VIDEO_V4L1_COMPAT
 	case VIDIOCGTUNER32: cmd = VIDIOCGTUNER; break;
 	case VIDIOCSTUNER32: cmd = VIDIOCSTUNER; break;
 	case VIDIOCGWIN32: cmd = VIDIOCGWIN; break;
@@ -631,6 +642,8 @@ static int do_video_ioctl(struct file *f
 	case VIDIOCSFBUF32: cmd = VIDIOCSFBUF; break;
 	case VIDIOCGFREQ32: cmd = VIDIOCGFREQ; break;
 	case VIDIOCSFREQ32: cmd = VIDIOCSFREQ; break;
+	case VIDIOCSMICROCODE32: cmd = VIDIOCSMICROCODE; break;
+#endif
 	case VIDIOC_G_FMT32: cmd = VIDIOC_G_FMT; break;
 	case VIDIOC_S_FMT32: cmd = VIDIOC_S_FMT; break;
 	case VIDIOC_QUERYBUF32: cmd = VIDIOC_QUERYBUF; break;
@@ -647,10 +660,10 @@ static int do_video_ioctl(struct file *f
 	case VIDIOC_G_INPUT32: cmd = VIDIOC_G_INPUT; break;
 	case VIDIOC_S_INPUT32: cmd = VIDIOC_S_INPUT; break;
 	case VIDIOC_TRY_FMT32: cmd = VIDIOC_TRY_FMT; break;
-	case VIDIOCSMICROCODE32: cmd = VIDIOCSMICROCODE; break;
 	};
 
 	switch(cmd) {
+#ifdef CONFIG_VIDEO_V4L1_COMPAT
 	case VIDIOCSTUNER:
 	case VIDIOCGTUNER:
 		err = get_video_tuner32(&karg.vt, up);
@@ -664,6 +677,7 @@ static int do_video_ioctl(struct file *f
 		break;
 
 	case VIDIOCSFREQ:
+#endif
 	case VIDIOC_S_INPUT:
 	case VIDIOC_OVERLAY:
 	case VIDIOC_STREAMON:
@@ -717,18 +731,21 @@ static int do_video_ioctl(struct file *f
 		compatible_arg = 0;
 		break;
 
+#ifdef CONFIG_VIDEO_V4L1_COMPAT
 	case VIDIOCGWIN:
 	case VIDIOCGFBUF:
 	case VIDIOCGFREQ:
+#endif
 	case VIDIOC_G_FBUF:
 	case VIDIOC_G_INPUT:
 		compatible_arg = 0;
+#ifdef CONFIG_VIDEO_V4L1_COMPAT
 	case VIDIOCSMICROCODE:
 		err = microcode32(&karg.vc, up);
 		compatible_arg = 0;
 		break;
+#endif
 	};
-
 	if(err)
 		goto out;
 
@@ -743,6 +760,7 @@ static int do_video_ioctl(struct file *f
 	}
 	if(err == 0) {
 		switch(cmd) {
+#ifdef CONFIG_VIDEO_V4L1_COMPAT
 		case VIDIOCGTUNER:
 			err = put_video_tuner32(&karg.vt, up);
 			break;
@@ -754,7 +772,7 @@ static int do_video_ioctl(struct file *f
 		case VIDIOCGFBUF:
 			err = put_video_buffer32(&karg.vb, up);
 			break;
-
+#endif
 		case VIDIOC_G_FBUF:
 			err = put_v4l2_framebuffer32(&karg.v2fb, up);
 			break;
@@ -792,7 +810,9 @@ static int do_video_ioctl(struct file *f
 			err = put_v4l2_input32(&karg.v2i, up);
 			break;
 
+#ifdef CONFIG_VIDEO_V4L1_COMPAT
 		case VIDIOCGFREQ:
+#endif
 		case VIDIOC_G_INPUT:
 			err = put_user(((u32)karg.vx), (u32 __user *)up);
 			break;
@@ -810,6 +830,7 @@ long v4l_compat_ioctl32(struct file *fil
 		return ret;
 
 	switch (cmd) {
+#ifdef CONFIG_VIDEO_V4L1_COMPAT
 	case VIDIOCSWIN32:
 		ret = do_set_window(file, cmd, arg);
 		break;
@@ -820,6 +841,7 @@ long v4l_compat_ioctl32(struct file *fil
 	case VIDIOCSFBUF32:
 	case VIDIOCGFREQ32:
 	case VIDIOCSFREQ32:
+#endif
 	case VIDIOC_QUERYCAP:
 	case VIDIOC_ENUM_FMT:
 	case VIDIOC_G_FMT32:
@@ -851,6 +873,7 @@ long v4l_compat_ioctl32(struct file *fil
 		ret = do_video_ioctl(file, cmd, arg);
 		break;
 
+#ifdef CONFIG_VIDEO_V4L1_COMPAT
 	/* Little v, the video4linux ioctls (conflict?) */
 	case VIDIOCGCAP:
 	case VIDIOCGCHAN:
@@ -879,6 +902,7 @@ long v4l_compat_ioctl32(struct file *fil
 	case _IOR('v' , BASE_VIDIOCPRIVATE+7, int):
 		ret = native_ioctl(file, cmd, (unsigned long)compat_ptr(arg));
 		break;
+#endif
 	default:
 		v4l_print_ioctl("compat_ioctl32", cmd);
 	}

