Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266608AbUAOLg0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 06:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266599AbUAOLgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 06:36:12 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:47026 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S266564AbUAOLfH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 06:35:07 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 15 Jan 2004 12:48:44 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l-01 videodev update
Message-ID: <20040115114844.GA16020@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch fixes some v4l2 ioctl #defines which have wrong
_IO* macros.  It also adds a function which maps the old
numbers to to new ones to maintain binary backward
compatibility.

please apply,

  Gerd

diff -u linux-2.6.1/drivers/media/video/videodev.c linux/drivers/media/video/videodev.c
--- linux-2.6.1/drivers/media/video/videodev.c	2004-01-14 15:05:01.000000000 +0100
+++ linux/drivers/media/video/videodev.c	2004-01-14 15:09:35.000000000 +0100
@@ -140,6 +140,30 @@
 /*
  * helper function -- handles userspace copying for ioctl arguments
  */
+
+static unsigned int
+video_fix_command(unsigned int cmd)
+{
+	switch (cmd) {
+	case VIDIOC_OVERLAY_OLD:
+		cmd = VIDIOC_OVERLAY;
+		break;
+	case VIDIOC_S_PARM_OLD:
+		cmd = VIDIOC_S_PARM;
+		break;
+	case VIDIOC_S_CTRL_OLD:
+		cmd = VIDIOC_S_CTRL;
+		break;
+	case VIDIOC_G_AUDIO_OLD:
+		cmd = VIDIOC_G_AUDIO;
+		break;
+	case VIDIOC_G_AUDOUT_OLD:
+		cmd = VIDIOC_G_AUDOUT;
+		break;
+	}
+	return cmd;
+}
+
 int
 video_usercopy(struct inode *inode, struct file *file,
 	       unsigned int cmd, unsigned long arg,
@@ -151,12 +175,14 @@
 	void	*parg = NULL;
 	int	err  = -EINVAL;
 
+	cmd = video_fix_command(cmd);
+
 	/*  Copy arguments into temp kernel buffer  */
 	switch (_IOC_DIR(cmd)) {
 	case _IOC_NONE:
 		parg = (void *)arg;
 		break;
-	case _IOC_READ: /* some v4l ioctls are marked wrong ... */
+	case _IOC_READ:
 	case _IOC_WRITE:
 	case (_IOC_WRITE | _IOC_READ):
 		if (_IOC_SIZE(cmd) <= sizeof(sbuf)) {
@@ -170,8 +196,9 @@
 		}
 		
 		err = -EFAULT;
-		if (copy_from_user(parg, (void *)arg, _IOC_SIZE(cmd)))
-			goto out;
+		if (_IOC_DIR(cmd) & _IOC_WRITE)
+			if (copy_from_user(parg, (void *)arg, _IOC_SIZE(cmd)))
+				goto out;
 		break;
 	}
 
diff -u linux-2.6.1/include/linux/videodev2.h linux/include/linux/videodev2.h
--- linux-2.6.1/include/linux/videodev2.h	2004-01-14 15:06:09.000000000 +0100
+++ linux/include/linux/videodev2.h	2004-01-14 15:09:35.000000000 +0100
@@ -783,22 +783,22 @@
 #define VIDIOC_QUERYBUF		_IOWR ('V',  9, struct v4l2_buffer)
 #define VIDIOC_G_FBUF		_IOR  ('V', 10, struct v4l2_framebuffer)
 #define VIDIOC_S_FBUF		_IOW  ('V', 11, struct v4l2_framebuffer)
-#define VIDIOC_OVERLAY		_IOWR ('V', 14, int)
+#define VIDIOC_OVERLAY		_IOW  ('V', 14, int)
 #define VIDIOC_QBUF		_IOWR ('V', 15, struct v4l2_buffer)
 #define VIDIOC_DQBUF		_IOWR ('V', 17, struct v4l2_buffer)
 #define VIDIOC_STREAMON		_IOW  ('V', 18, int)
 #define VIDIOC_STREAMOFF	_IOW  ('V', 19, int)
 #define VIDIOC_G_PARM		_IOWR ('V', 21, struct v4l2_streamparm)
-#define VIDIOC_S_PARM		_IOW  ('V', 22, struct v4l2_streamparm)
+#define VIDIOC_S_PARM		_IOWR ('V', 22, struct v4l2_streamparm)
 #define VIDIOC_G_STD		_IOR  ('V', 23, v4l2_std_id)
 #define VIDIOC_S_STD		_IOW  ('V', 24, v4l2_std_id)
 #define VIDIOC_ENUMSTD		_IOWR ('V', 25, struct v4l2_standard)
 #define VIDIOC_ENUMINPUT	_IOWR ('V', 26, struct v4l2_input)
 #define VIDIOC_G_CTRL		_IOWR ('V', 27, struct v4l2_control)
-#define VIDIOC_S_CTRL		_IOW  ('V', 28, struct v4l2_control)
+#define VIDIOC_S_CTRL		_IOWR ('V', 28, struct v4l2_control)
 #define VIDIOC_G_TUNER		_IOWR ('V', 29, struct v4l2_tuner)
 #define VIDIOC_S_TUNER		_IOW  ('V', 30, struct v4l2_tuner)
-#define VIDIOC_G_AUDIO		_IOWR ('V', 33, struct v4l2_audio)
+#define VIDIOC_G_AUDIO		_IOR  ('V', 33, struct v4l2_audio)
 #define VIDIOC_S_AUDIO		_IOW  ('V', 34, struct v4l2_audio)
 #define VIDIOC_QUERYCTRL	_IOWR ('V', 36, struct v4l2_queryctrl)
 #define VIDIOC_QUERYMENU	_IOWR ('V', 37, struct v4l2_querymenu)
@@ -807,7 +807,7 @@
 #define VIDIOC_G_OUTPUT		_IOR  ('V', 46, int)
 #define VIDIOC_S_OUTPUT		_IOWR ('V', 47, int)
 #define VIDIOC_ENUMOUTPUT	_IOWR ('V', 48, struct v4l2_output)
-#define VIDIOC_G_AUDOUT		_IOWR ('V', 49, struct v4l2_audioout)
+#define VIDIOC_G_AUDOUT		_IOR  ('V', 49, struct v4l2_audioout)
 #define VIDIOC_S_AUDOUT		_IOW  ('V', 50, struct v4l2_audioout)
 #define VIDIOC_G_MODULATOR	_IOWR ('V', 54, struct v4l2_modulator)
 #define VIDIOC_S_MODULATOR	_IOW  ('V', 55, struct v4l2_modulator)
@@ -820,6 +820,15 @@
 #define VIDIOC_S_JPEGCOMP	_IOW  ('V', 62, struct v4l2_jpegcompression)
 #define VIDIOC_QUERYSTD      	_IOR  ('V', 63, v4l2_std_id)
 #define VIDIOC_TRY_FMT      	_IOWR ('V', 64, struct v4l2_format)
+#define VIDIOC_ENUMAUDIO	_IOWR ('V', 65, struct v4l2_audio)
+#define VIDIOC_ENUMAUDOUT	_IOWR ('V', 66, struct v4l2_audioout)
+
+/* for compatibility, will go away some day */
+#define VIDIOC_OVERLAY_OLD     	_IOWR ('V', 14, int)
+#define VIDIOC_S_PARM_OLD      	_IOW  ('V', 22, struct v4l2_streamparm)
+#define VIDIOC_S_CTRL_OLD      	_IOW  ('V', 28, struct v4l2_control)
+#define VIDIOC_G_AUDIO_OLD     	_IOWR ('V', 33, struct v4l2_audio)
+#define VIDIOC_G_AUDOUT_OLD    	_IOWR ('V', 49, struct v4l2_audioout)
 
 #define BASE_VIDIOC_PRIVATE	192		/* 192-255 are private */
 

-- 
You have a new virus in /var/mail/kraxel
