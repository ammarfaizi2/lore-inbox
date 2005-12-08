Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751211AbVLHUxY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbVLHUxY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 15:53:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbVLHUxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 15:53:24 -0500
Received: from mail.macqel.be ([194.78.208.39]:4359 "EHLO mail.macqel.be")
	by vger.kernel.org with ESMTP id S1751211AbVLHUxX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 15:53:23 -0500
Message-Id: <200512082051.jB8Kp7e12536@mail.macqel.be>
Subject: [PATCH 2.6.15-rc5] v4l2/compat_ioctl : merge fixes
In-Reply-To: <1133970454.7047.22.camel@localhost> from Mauro Carvalho Chehab
 at "Dec 7, 2005 01:47:34 pm"
To: Mauro Carvalho Chehab <mchehab@infradead.org>
Date: Thu, 8 Dec 2005 21:51:07 +0100 (CET)
CC: linux-kernel@vger.kernel.org
From: "Philippe De Muyter" <phdm@macqel.be>
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes merge and typo problems in v4l2/compat, and fixes
VIDIOC_STREAMON, VIDIOC_STREAMOFF & VIDIOC_S_FBUF.

Signed-off-by: Philippe De Muyter <phdm@macqel.be>

---

Mauro Carvalho Chehab wrote :
> Em Ter, 2005-12-06 às 19:30 +0100, Philippe De Muyter escreveu:
> > This patch add 32-bit compatibility for v4l2 framegrabber ioctls.
> > 
> > Signed-off-by: Philippe De Muyter <phdm@macqel.be>
> 	Thanks for you patch. It was added at V4L tree, available at
> http://linuxtv.org/downloads/quilt
> 
> 	Please notice that in v4l tree, compat32 functions were moved to
> drivers/media/video/compat_ioctl32.c, and will be sent to kernel after
> more tests.
> 
> 	Please test all compat32 patches to check it if works properly. They
> are at the beginning of patches/series files (against -rc5 or -git):
> 

Well, there were some problems.  Hence my patch :

--- linux/drivers/media/video/compat_ioctl32.c-linuxtv	2005-12-08 10:30:27.000000000 +0100
+++ linux/drivers/media/video/compat_ioctl32.c	2005-12-08 21:13:32.000000000 +0100
@@ -106,11 +106,11 @@ static int native_ioctl(struct file *fil
 {
 	int ret = -ENOIOCTLCMD;
 
-	if (file->f_ops->unlocked_ioctl)
-		ret = file->f_ops->unlocked_ioctl(file, cmd, arg);
-	else if (file->f_ops->ioctl) {
+	if (file->f_op->unlocked_ioctl)
+		ret = file->f_op->unlocked_ioctl(file, cmd, arg);
+	else if (file->f_op->ioctl) {
 		lock_kernel();
-		ret = file->f_ops->ioctl(file->f_dentry->d_inode, file, cmd, arg);
+		ret = file->f_op->ioctl(file->f_dentry->d_inode, file, cmd, arg);
 		unlock_kernel();
 	}
 
@@ -367,6 +367,19 @@ struct v4l2_framebuffer32
 	struct v4l2_pix_format	fmt;
 };
 
+static int get_v4l2_framebuffer32(struct v4l2_framebuffer *kp, struct v4l2_framebuffer32 __user *up)
+{
+	u32 tmp;
+
+	if (get_user(tmp, &up->base))
+		return -EFAULT;
+	kp->base = compat_ptr(tmp);
+	__get_user(kp->capability, &up->capability);
+	__get_user(kp->flags, &up->flags);
+	get_v4l2_pix_format(&kp->fmt, &up->fmt);
+	return 0;
+}
+
 static int put_v4l2_framebuffer32(struct v4l2_framebuffer *kp, struct v4l2_framebuffer32 __user *up)
 {
 	u32 tmp = (u32)((unsigned long)kp->base);
@@ -404,6 +417,7 @@ struct v4l2_input32 	/* identical layout
 #define VIDIOC_S_FMT32		_IOWR ('V',  5, struct v4l2_format32)
 #define VIDIOC_QUERYBUF32	_IOWR ('V',  9, struct v4l2_buffer32)
 #define VIDIOC_G_FBUF32		_IOR  ('V', 10, struct v4l2_framebuffer32)
+#define VIDIOC_S_FBUF32		_IOW  ('V', 11, struct v4l2_framebuffer32)
 /* VIDIOC_OVERLAY is now _IOW, but was _IOWR */
 #define VIDIOC_OVERLAY32	_IOWR ('V', 14, compat_int_t)
 #define VIDIOC_QBUF32		_IOWR ('V', 15, struct v4l2_buffer32)
@@ -511,6 +525,7 @@ static int do_video_ioctl(struct file *f
 	case VIDIOC_STREAMON32: cmd = VIDIOC_STREAMON; break;
 	case VIDIOC_STREAMOFF32: cmd = VIDIOC_STREAMOFF; break;
 	case VIDIOC_G_FBUF32: cmd = VIDIOC_G_FBUF; break;
+	case VIDIOC_S_FBUF32: cmd = VIDIOC_S_FBUF; break;
 	case VIDIOC_OVERLAY32: cmd = VIDIOC_OVERLAY; break;
 	case VIDIOC_ENUMSTD32: cmd = VIDIOC_ENUMSTD; break;
 	case VIDIOC_ENUMINPUT32: cmd = VIDIOC_ENUMINPUT; break;
@@ -536,10 +551,16 @@ static int do_video_ioctl(struct file *f
 	case VIDIOCSFREQ:
 	case VIDIOC_S_INPUT:
 	case VIDIOC_OVERLAY:
+	case VIDIOC_STREAMON:
+	case VIDIOC_STREAMOFF:
 		err = get_user(karg.vx, (u32 __user *)up);
 		compatible_arg = 0;
 		break;
-	};
+
+	case VIDIOC_S_FBUF:
+		err = get_v4l2_framebuffer32(&karg.v2fb, up);
+		compatible_arg = 0;
+		break;
 
 	case VIDIOC_G_FMT:
 	case VIDIOC_S_FMT:
@@ -566,17 +587,18 @@ static int do_video_ioctl(struct file *f
 	case VIDIOC_G_FBUF:
 	case VIDIOC_G_INPUT:
 		compatible_arg = 0;
+	};
 
 	if(err)
 		goto out;
 
 	if(compatible_arg)
-		err = sys_ioctl(fd, cmd, (unsigned long)up);
+		err = native_ioctl(file, cmd, (unsigned long)up);
 	else {
 		mm_segment_t old_fs = get_fs();
 
 		set_fs(KERNEL_DS);
-		err = sys_ioctl(fd, cmd, (unsigned long)&karg);
+		err = native_ioctl(file, cmd, (unsigned long)&karg);
 		set_fs(old_fs);
 	}
 	if(err == 0) {
@@ -627,7 +649,7 @@ long v4l_compat_ioctl32(struct file *fil
 {
 	int ret = -ENOIOCTLCMD;
 
-	if (!file->f_ops->ioctl)
+	if (!file->f_op->ioctl)
 		return ret;
 
 	switch (cmd) {
@@ -641,6 +663,30 @@ long v4l_compat_ioctl32(struct file *fil
 	case VIDIOCSFBUF32:
 	case VIDIOCGFREQ32:
 	case VIDIOCSFREQ32:
+	case VIDIOC_QUERYCAP:
+	case VIDIOC_ENUM_FMT:
+	case VIDIOC_G_FMT32:
+	case VIDIOC_S_FMT32:
+	case VIDIOC_REQBUFS:
+	case VIDIOC_QUERYBUF32:
+	case VIDIOC_G_FBUF32:
+	case VIDIOC_S_FBUF32:
+	case VIDIOC_OVERLAY32:
+	case VIDIOC_QBUF32:
+	case VIDIOC_DQBUF32:
+	case VIDIOC_STREAMON32:
+	case VIDIOC_STREAMOFF32:
+	case VIDIOC_G_PARM:
+	case VIDIOC_G_STD:
+	case VIDIOC_S_STD:
+	case VIDIOC_ENUMSTD32:
+	case VIDIOC_ENUMINPUT32:
+	case VIDIOC_G_CTRL:
+	case VIDIOC_S_CTRL32:
+	case VIDIOC_QUERYCTRL:
+	case VIDIOC_G_INPUT32:
+	case VIDIOC_S_INPUT32:
+	case VIDIOC_TRY_FMT32:
 		ret = do_video_ioctl(file, cmd, arg);
 		break;
 
