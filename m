Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263973AbTEWJYc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 05:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263979AbTEWJYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 05:24:32 -0400
Received: from mail.convergence.de ([212.84.236.4]:3776 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S263973AbTEWJYF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 05:24:05 -0400
Message-ID: <3ECDEBC5.5030608@convergence.de>
Date: Fri, 23 May 2003 11:37:09 +0200
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.3) Gecko/20030408
X-Accept-Language: de-at, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [RFC][2.5] generic_usercopy() function (resend, forgot the patches)
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------000207000702060502050101"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000207000702060502050101
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello all,

especially the Video4Linux-driver rely intensively on the
video_usercopy() function, which handles the copying of userspace
arguments of ioctls with a simply callback mechanism.

Recently the dvb-core has been added which needs the same function.
Because of the fact that the core is independent of Video4Linux, the
code was duplicated to a dvb_usercopy() function.

In order to prevent this code duplication, introducing a
generic_usercopy() function to lib/ is one possibilty.

The appended 4 patches do the following:

01-introduce.diff:
- remove video_usercopy() from videodev.c
- add generic_usercopy() to "lib/usecopy.c" and update the build system

02-video.diff:
- change all users of video_usercopy() to use generic_usercopy() instead

03-radio.diff:
- change all users of video_usercopy() to use generic_usercopy() instead

04-dvb.diff
- remove dvb_usercopy() from the dvb core and fix it to use
generic_usercopy() instead.

The diffs are against 2.5.69.

Comments are very appreciated. 8-)
Is there a possibility to get this into the kernel?

CU
Michael.


--------------000207000702060502050101
Content-Type: text/plain;
 name="01-introduce.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="01-introduce.diff"

diff -uNrwB -x '.*' -x '*.o' -x '*.mod' --new-file linux-2.5.69/drivers/media/video/videodev.c linux-2.5.69.usercopy/drivers/media/video/videodev.c
--- linux-2.5.69/drivers/media/video/videodev.c	2003-05-06 13:16:21.000000000 +0200
+++ linux-2.5.69.usercopy/drivers/media/video/videodev.c	2003-05-23 10:14:27.000000000 +0200
@@ -29,6 +29,7 @@
 #include <linux/kmod.h>
 #include <linux/slab.h>
 #include <linux/devfs_fs_kernel.h>
+#include <linux/usercopy.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
 #include <asm/semaphore.h>
@@ -109,67 +109,6 @@
 }
 
 /*
- * helper function -- handles userspace copying for ioctl arguments
- */
-int
-video_usercopy(struct inode *inode, struct file *file,
-	       unsigned int cmd, unsigned long arg,
-	       int (*func)(struct inode *inode, struct file *file,
-			   unsigned int cmd, void *arg))
-{
-	char	sbuf[128];
-	void    *mbuf = NULL;
-	void	*parg = NULL;
-	int	err  = -EINVAL;
-
-	/*  Copy arguments into temp kernel buffer  */
-	switch (_IOC_DIR(cmd)) {
-	case _IOC_NONE:
-		parg = (void *)arg;
-		break;
-	case _IOC_READ: /* some v4l ioctls are marked wrong ... */
-	case _IOC_WRITE:
-	case (_IOC_WRITE | _IOC_READ):
-		if (_IOC_SIZE(cmd) <= sizeof(sbuf)) {
-			parg = sbuf;
-		} else {
-			/* too big to allocate from stack */
-			mbuf = kmalloc(_IOC_SIZE(cmd),GFP_KERNEL);
-			if (NULL == mbuf)
-				return -ENOMEM;
-			parg = mbuf;
-		}
-		
-		err = -EFAULT;
-		if (copy_from_user(parg, (void *)arg, _IOC_SIZE(cmd)))
-			goto out;
-		break;
-	}
-
-	/* call driver */
-	err = func(inode, file, cmd, parg);
-	if (err == -ENOIOCTLCMD)
-		err = -EINVAL;
-	if (err < 0)
-		goto out;
-
-	/*  Copy results into user buffer  */
-	switch (_IOC_DIR(cmd))
-	{
-	case _IOC_READ:
-	case (_IOC_WRITE | _IOC_READ):
-		if (copy_to_user((void *)arg, parg, _IOC_SIZE(cmd)))
-			err = -EFAULT;
-		break;
-	}
-
-out:
-	if (mbuf)
-		kfree(mbuf);
-	return err;
-}
-
-/*
  * open/release helper functions -- handle exclusive opens
  */
 extern int video_exclusive_open(struct inode *inode, struct file *file)
@@ -506,7 +445,6 @@
 EXPORT_SYMBOL(video_register_device);
 EXPORT_SYMBOL(video_unregister_device);
 EXPORT_SYMBOL(video_devdata);
-EXPORT_SYMBOL(video_usercopy);
 EXPORT_SYMBOL(video_exclusive_open);
 EXPORT_SYMBOL(video_exclusive_release);
 
diff -uNrwB -x '.*' -x '*.o' -x '*.mod' --new-file linux-2.5.69/include/linux/usercopy.h linux-2.5.69.usercopy/include/linux/usercopy.h
--- linux-2.5.69/include/linux/usercopy.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.69.usercopy/include/linux/usercopy.h	2003-05-23 09:55:17.000000000 +0200
@@ -0,0 +1,12 @@
+#ifndef _LINUX_USERCOPY_H
+#define _LINUX_USERCOPY_H
+
+#include <linux/types.h>
+
+int
+generic_usercopy(struct inode *inode, struct file *file,
+		unsigned int cmd, unsigned long arg,
+		int (*func)(struct inode *inode, struct file *file,
+		unsigned int cmd, void *arg));
+
+#endif /* _LINUX_USERCOPY_H */
diff -uNrwB -x '.*' -x '*.o' -x '*.mod' --new-file linux-2.5.69/include/linux/videodev.h linux-2.5.69.usercopy/include/linux/videodev.h
--- linux-2.5.69/include/linux/videodev.h	2003-05-06 13:16:43.000000000 +0200
+++ linux-2.5.69.usercopy/include/linux/videodev.h	2003-05-23 10:15:51.000000000 +0200
@@ -20,6 +20,7 @@
 
 #include <linux/poll.h>
 #include <linux/mm.h>
+#include <linux/usercopy.h>
 
 struct video_device
 {
diff -uNrwB -x '.*' -x '*.o' -x '*.mod' --new-file linux-2.5.69/lib/Kconfig linux-2.5.69.usercopy/lib/Kconfig
--- linux-2.5.69/lib/Kconfig	2003-04-07 19:31:46.000000000 +0200
+++ linux-2.5.69.usercopy/lib/Kconfig	2003-05-23 09:58:53.000000000 +0200
@@ -12,6 +12,15 @@
 	  kernel tree does. Such modules that use library CRC32 functions
 	  require M here.
 
+config USERCOPY
+	tristate "Generic usercopy function"
+	help
+	  This option is provided for the case where no in-kernel-tree
+	  modules require the generic usercopy function for copying 
+	  ioctl arguments from user space to kernel space, but a module
+	  built outside the kernel tree does. Such modules that use
+	  this function require M here.
+
 #
 # Do we need the compression support?
 #
diff -uNrwB -x '.*' -x '*.o' -x '*.mod' --new-file linux-2.5.69/lib/Makefile linux-2.5.69.usercopy/lib/Makefile
--- linux-2.5.69/lib/Makefile	2003-05-06 13:15:51.000000000 +0200
+++ linux-2.5.69.usercopy/lib/Makefile	2003-05-23 10:26:37.000000000 +0200
@@ -21,6 +21,7 @@
 endif
 
 obj-$(CONFIG_CRC32)	+= crc32.o
+obj-$(CONFIG_USERCOPY)	+= usercopy.o
 
 obj-$(CONFIG_ZLIB_INFLATE) += zlib_inflate/
 obj-$(CONFIG_ZLIB_DEFLATE) += zlib_deflate/
@@ -29,6 +30,9 @@
 include $(TOPDIR)/drivers/usb/Makefile.lib
 include $(TOPDIR)/fs/Makefile.lib
 include $(TOPDIR)/net/bluetooth/bnep/Makefile.lib
+include $(TOPDIR)/drivers/media/video/Makefile.lib
+include $(TOPDIR)/drivers/media/common/Makefile.lib
+include $(TOPDIR)/drivers/media/dvb/dvb-core/Makefile.lib
 
 host-progs := gen_crc32table
 clean-files := crc32table.h
diff -uNrwB -x '.*' -x '*.o' -x '*.mod' --new-file linux-2.5.69/lib/usercopy.c linux-2.5.69.usercopy/lib/usercopy.c
--- linux-2.5.69/lib/usercopy.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.69.usercopy/lib/usercopy.c	2003-05-23 10:46:43.000000000 +0200
@@ -0,0 +1,71 @@
+#include <linux/types.h>
+#include <linux/version.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <asm/uaccess.h>
+
+#include <linux/usercopy.h>
+
+/*
+ * helper function -- handles userspace copying for ioctl arguments
+ */
+
+int
+generic_usercopy(struct inode *inode, struct file *file,
+		unsigned int cmd, unsigned long arg,
+		int (*func)(struct inode *inode, struct file *file,
+		unsigned int cmd, void *arg))
+{
+	char	sbuf[128];
+	void    *mbuf = NULL;
+	void	*parg = NULL;
+	int	err  = -EINVAL;
+
+	/*  Copy arguments into temp kernel buffer  */
+	switch (_IOC_DIR(cmd)) {
+	case _IOC_NONE:
+		parg = (void *)arg;
+		break;
+	case _IOC_READ: /* some v4l ioctls are marked wrong ... */
+	case _IOC_WRITE:
+	case (_IOC_WRITE | _IOC_READ):
+		if (_IOC_SIZE(cmd) <= sizeof(sbuf)) {
+			parg = sbuf;
+		} else {
+			/* too big to allocate from stack */
+			mbuf = kmalloc(_IOC_SIZE(cmd),GFP_KERNEL);
+			if (NULL == mbuf)
+				return -ENOMEM;
+			parg = mbuf;
+		}
+		
+		err = -EFAULT;
+		if (copy_from_user(parg, (void *)arg, _IOC_SIZE(cmd)))
+			goto out;
+		break;
+	}
+
+	/* call driver */
+	err = func(inode, file, cmd, parg);
+	if (err == -ENOIOCTLCMD)
+		err = -EINVAL;
+	if (err < 0)
+		goto out;
+
+	/*  Copy results into user buffer  */
+	switch (_IOC_DIR(cmd))
+	{
+	case _IOC_READ:
+	case (_IOC_WRITE | _IOC_READ):
+		if (copy_to_user((void *)arg, parg, _IOC_SIZE(cmd)))
+			err = -EFAULT;
+		break;
+	}
+
+out:
+	if (mbuf)
+		kfree(mbuf);
+	return err;
+}
+
+EXPORT_SYMBOL(generic_usercopy);

--------------000207000702060502050101
Content-Type: text/plain;
 name="02-video.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="02-video.diff"

diff -uNrwB -x '.*' -x '*.o' -x '*.mod' --new-file linux-2.5.69/drivers/media/video/Makefile.lib linux-2.5.69.usercopy/drivers/media/video/Makefile.lib
--- linux-2.5.69/drivers/media/video/Makefile.lib	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.69.usercopy/drivers/media/video/Makefile.lib	2003-05-23 10:59:20.000000000 +0200
@@ -0,0 +1,11 @@
+# These drivers all require usercopy.o
+obj-$(CONFIG_VIDEODEV)		+= usercopy.o
+obj-$(CONFIG_VIDEO_SAA7134)	+= usercopy.o
+obj-$(CONFIG_VIDEO_BT848)	+= usercopy.o
+obj-$(CONFIG_VIDEO_PMS)	+= usercopy.o
+obj-$(CONFIG_VIDEO_W9966)	+= usercopy.o
+obj-$(CONFIG_VIDEO_BWQCAM)	+= usercopy.o
+obj-$(CONFIG_VIDEO_CQCAM)	+= usercopy.o
+obj-$(CONFIG_VIDEO_MEYE)	+= usercopy.o
+obj-$(CONFIG_VIDEO_CPIA)	+= usercopy.o
+obj-$(CONFIG_VIDEO_SAA5249)	+= usercopy.o
+
diff -uNrwB -x '.*' -x '*.o' -x '*.mod' --new-file linux-2.5.69/drivers/media/video/bttv-driver.c linux-2.5.69.usercopy/drivers/media/video/bttv-driver.c
--- linux-2.5.69/drivers/media/video/bttv-driver.c	2003-05-06 13:16:20.000000000 +0200
+++ linux-2.5.69.usercopy/drivers/media/video/bttv-driver.c	2003-05-23 10:14:27.000000000 +0200
@@ -2592,7 +2592,7 @@
 		bttv_switch_type(fh,V4L2_BUF_TYPE_VBI_CAPTURE);
 		return fh->lines * 2 * 2048;
 	default:
-		return video_usercopy(inode, file, cmd, arg, bttv_do_ioctl);
+		return generic_usercopy(inode, file, cmd, arg, bttv_do_ioctl);
 	}
 }
 
@@ -2903,7 +2903,7 @@
 static int radio_ioctl(struct inode *inode, struct file *file,
 		       unsigned int cmd, unsigned long arg)
 {
-	return video_usercopy(inode, file, cmd, arg, radio_do_ioctl);
+	return generic_usercopy(inode, file, cmd, arg, radio_do_ioctl);
 }
 
 static struct file_operations radio_fops =
diff -uNrwB -x '.*' -x '*.o' -x '*.mod' --new-file linux-2.5.69/drivers/media/video/bw-qcam.c linux-2.5.69.usercopy/drivers/media/video/bw-qcam.c
--- linux-2.5.69/drivers/media/video/bw-qcam.c	2003-04-07 19:30:57.000000000 +0200
+++ linux-2.5.69.usercopy/drivers/media/video/bw-qcam.c	2003-05-23 10:14:27.000000000 +0200
@@ -855,7 +855,7 @@
 static int qcam_ioctl(struct inode *inode, struct file *file,
 		     unsigned int cmd, unsigned long arg)
 {
-	return video_usercopy(inode, file, cmd, arg, qcam_do_ioctl);
+	return generic_usercopy(inode, file, cmd, arg, qcam_do_ioctl);
 }
 
 static int qcam_read(struct file *file, char *buf,
diff -uNrwB -x '.*' -x '*.o' -x '*.mod' --new-file linux-2.5.69/drivers/media/video/c-qcam.c linux-2.5.69.usercopy/drivers/media/video/c-qcam.c
--- linux-2.5.69/drivers/media/video/c-qcam.c	2003-04-07 19:31:14.000000000 +0200
+++ linux-2.5.69.usercopy/drivers/media/video/c-qcam.c	2003-05-23 10:14:27.000000000 +0200
@@ -665,7 +665,7 @@
 static int qcam_ioctl(struct inode *inode, struct file *file,
 		     unsigned int cmd, unsigned long arg)
 {
-	return video_usercopy(inode, file, cmd, arg, qcam_do_ioctl);
+	return generic_usercopy(inode, file, cmd, arg, qcam_do_ioctl);
 }
 
 static int qcam_read(struct file *file, char *buf,
diff -uNrwB -x '.*' -x '*.o' -x '*.mod' --new-file linux-2.5.69/drivers/media/video/cpia.c linux-2.5.69.usercopy/drivers/media/video/cpia.c
--- linux-2.5.69/drivers/media/video/cpia.c	2003-05-06 13:16:20.000000000 +0200
+++ linux-2.5.69.usercopy/drivers/media/video/cpia.c	2003-05-23 10:14:27.000000000 +0200
@@ -3740,7 +3740,7 @@
 static int cpia_ioctl(struct inode *inode, struct file *file,
 		     unsigned int cmd, unsigned long arg)
 {
-	return video_usercopy(inode, file, cmd, arg, cpia_do_ioctl);
+	return generic_usercopy(inode, file, cmd, arg, cpia_do_ioctl);
 }
 
 
diff -uNrwB -x '.*' -x '*.o' -x '*.mod' --new-file linux-2.5.69/drivers/media/video/meye.c linux-2.5.69.usercopy/drivers/media/video/meye.c
--- linux-2.5.69/drivers/media/video/meye.c	2003-05-06 13:16:20.000000000 +0200
+++ linux-2.5.69.usercopy/drivers/media/video/meye.c	2003-05-23 10:14:27.000000000 +0200
@@ -1169,7 +1169,7 @@
 static int meye_ioctl(struct inode *inode, struct file *file,
 		     unsigned int cmd, unsigned long arg)
 {
-	return video_usercopy(inode, file, cmd, arg, meye_do_ioctl);
+	return generic_usercopy(inode, file, cmd, arg, meye_do_ioctl);
 }
 
 static int meye_mmap(struct file *file, struct vm_area_struct *vma) {
diff -uNrwB -x '.*' -x '*.o' -x '*.mod' --new-file linux-2.5.69/drivers/media/video/pms.c linux-2.5.69.usercopy/drivers/media/video/pms.c
--- linux-2.5.69/drivers/media/video/pms.c	2003-04-07 19:32:26.000000000 +0200
+++ linux-2.5.69.usercopy/drivers/media/video/pms.c	2003-05-23 10:14:27.000000000 +0200
@@ -858,7 +858,7 @@
 static int pms_ioctl(struct inode *inode, struct file *file,
 		     unsigned int cmd, unsigned long arg)
 {
-	return video_usercopy(inode, file, cmd, arg, pms_do_ioctl);
+	return generic_usercopy(inode, file, cmd, arg, pms_do_ioctl);
 }
 
 static int pms_read(struct file *file, char *buf,
diff -uNrwB -x '.*' -x '*.o' -x '*.mod' --new-file linux-2.5.69/drivers/media/video/saa5249.c linux-2.5.69.usercopy/drivers/media/video/saa5249.c
--- linux-2.5.69/drivers/media/video/saa5249.c	2003-05-06 13:16:21.000000000 +0200
+++ linux-2.5.69.usercopy/drivers/media/video/saa5249.c	2003-05-23 10:14:27.000000000 +0200
@@ -602,7 +602,7 @@
 	int err;
 	
 	down(&t->lock);
-	err = video_usercopy(inode,file,cmd,arg,do_saa5249_ioctl);
+	err = generic_usercopy(inode,file,cmd,arg,do_saa5249_ioctl);
 	up(&t->lock);
 	return err;
 }
diff -uNrwB -x '.*' -x '*.o' -x '*.mod' --new-file linux-2.5.69/drivers/media/video/saa7134/saa7134-ts.c linux-2.5.69.usercopy/drivers/media/video/saa7134/saa7134-ts.c
--- linux-2.5.69/drivers/media/video/saa7134/saa7134-ts.c	2003-05-06 13:16:21.000000000 +0200
+++ linux-2.5.69.usercopy/drivers/media/video/saa7134/saa7134-ts.c	2003-05-23 10:14:26.000000000 +0200
@@ -371,7 +371,7 @@
 static int ts_ioctl(struct inode *inode, struct file *file,
 		     unsigned int cmd, unsigned long arg)
 {
-	return video_usercopy(inode, file, cmd, arg, ts_do_ioctl);
+	return generic_usercopy(inode, file, cmd, arg, ts_do_ioctl);
 }
 
 
diff -uNrwB -x '.*' -x '*.o' -x '*.mod' --new-file linux-2.5.69/drivers/media/video/saa7134/saa7134-video.c linux-2.5.69.usercopy/drivers/media/video/saa7134/saa7134-video.c
--- linux-2.5.69/drivers/media/video/saa7134/saa7134-video.c	2003-05-06 13:16:21.000000000 +0200
+++ linux-2.5.69.usercopy/drivers/media/video/saa7134/saa7134-video.c	2003-05-23 10:14:26.000000000 +0200
@@ -1815,7 +1815,7 @@
 static int video_ioctl(struct inode *inode, struct file *file,
 		       unsigned int cmd, unsigned long arg)
 {
-	return video_usercopy(inode, file, cmd, arg, video_do_ioctl);
+	return generic_usercopy(inode, file, cmd, arg, video_do_ioctl);
 }
 
 static int radio_do_ioctl(struct inode *inode, struct file *file,
@@ -1916,7 +1916,7 @@
 static int radio_ioctl(struct inode *inode, struct file *file,
 		       unsigned int cmd, unsigned long arg)
 {
-	return video_usercopy(inode, file, cmd, arg, radio_do_ioctl);
+	return generic_usercopy(inode, file, cmd, arg, radio_do_ioctl);
 }
 
 static struct file_operations video_fops =
diff -uNrwB -x '.*' -x '*.o' -x '*.mod' --new-file linux-2.5.69/drivers/media/video/w9966.c linux-2.5.69.usercopy/drivers/media/video/w9966.c
--- linux-2.5.69/drivers/media/video/w9966.c	2003-05-06 13:16:21.000000000 +0200
+++ linux-2.5.69.usercopy/drivers/media/video/w9966.c	2003-05-23 10:14:27.000000000 +0200
@@ -863,7 +863,7 @@
 static int w9966_v4l_ioctl(struct inode *inode, struct file *file,
 			   unsigned int cmd, unsigned long arg)
 {
-	return video_usercopy(inode, file, cmd, arg, w9966_v4l_do_ioctl);
+	return generic_usercopy(inode, file, cmd, arg, w9966_v4l_do_ioctl);
 }
 
 // Capture data
diff -uNrwB -x '.*' -x '*.o' -x '*.mod' --new-file linux-2.5.69/drivers/media/common/Makefile.lib linux-2.5.69.usercopy/drivers/media/common/Makefile.lib
--- linux-2.5.69/drivers/media/common/Makefile.lib	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.69.usercopy/drivers/media/common/Makefile.lib	2003-05-23 10:32:37.000000000 +0200
@@ -0,0 +1 @@
+obj-$(CONFIG_VIDEO_SAA7146)		+= usercopy.o
diff -uNrwB -x '.*' -x '*.o' -x '*.mod' --new-file linux-2.5.69/drivers/media/common/saa7146_fops.c linux-2.5.69.usercopy/drivers/media/common/saa7146_fops.c
--- linux-2.5.69/drivers/media/common/saa7146_fops.c	2003-05-06 13:15:30.000000000 +0200
+++ linux-2.5.69.usercopy/drivers/media/common/saa7146_fops.c	2003-05-23 10:14:28.000000000 +0200
@@ -259,7 +259,7 @@
 /*
 	DEB_EE(("inode:%p, file:%p, cmd:%d, arg:%li\n",inode, file, cmd, arg));
 */
-	return video_usercopy(inode, file, cmd, arg, saa7146_video_do_ioctl);
+	return generic_usercopy(inode, file, cmd, arg, saa7146_video_do_ioctl);
 }
 
 static int fops_mmap(struct file *file, struct vm_area_struct * vma)

--------------000207000702060502050101
Content-Type: text/plain;
 name="03-radio.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="03-radio.diff"

diff -uNrwB -x '.*' -x '*.o' -x '*.mod' --new-file linux-2.5.69/drivers/media/radio/Makefile.lib linux-2.5.69.usercopy/drivers/media/radio/Makefile.lib
--- linux-2.5.69/drivers/media/radio/Makefile.lib	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.69.usercopy/drivers/media/radio/Makefile.lib	2003-05-23 11:02:26.000000000 +0200
@@ -0,0 +1,15 @@
+# These drivers all require usercopy.o
+obj-$(CONFIG_RADIO_GEMTEK)		+= usercopy.o
+obj-$(CONFIG_RADIO_GEMTEK_PCI)		+= usercopy.o
+obj-$(CONFIG_RADIO_MIROPCM20)		+= usercopy.o
+obj-$(CONFIG_RADIO_RTRACK)		+= usercopy.o
+obj-$(CONFIG_RADIO_RTRACK2)		+= usercopy.o
+obj-$(CONFIG_RADIO_TYPHOON)		+= usercopy.o
+obj-$(CONFIG_RADIO_TERRATEC)		+= usercopy.o
+obj-$(CONFIG_RADIO_CADET)		+= usercopy.o
+obj-$(CONFIG_RADIO_TRUST)		+= usercopy.o
+obj-$(CONFIG_RADIO_MAESTRO)		+= usercopy.o
+obj-$(CONFIG_RADIO_SF16FMI)		+= usercopy.o
+obj-$(CONFIG_RADIO_MAXIRADIO)		+= usercopy.o
+obj-$(CONFIG_RADIO_ZOLTRIX)		+= usercopy.o
+obj-$(CONFIG_RADIO_AZTECH)		+= usercopy.o
diff -uNrwB -x '.*' -x '*.o' -x '*.mod' --new-file linux-2.5.69/drivers/media/radio/miropcm20-radio.c linux-2.5.69.usercopy/drivers/media/radio/miropcm20-radio.c
--- linux-2.5.69/drivers/media/radio/miropcm20-radio.c	2003-04-07 19:30:58.000000000 +0200
+++ linux-2.5.69.usercopy/drivers/media/radio/miropcm20-radio.c	2003-05-23 10:14:27.000000000 +0200
@@ -213,7 +213,7 @@
 static int pcm20_ioctl(struct inode *inode, struct file *file,
 		       unsigned int cmd, unsigned long arg)
 {
-	return video_usercopy(inode, file, cmd, arg, pcm20_do_ioctl);
+	return generic_usercopy(inode, file, cmd, arg, pcm20_do_ioctl);
 }
 
 static struct pcm20_device pcm20_unit = {
diff -uNrwB -x '.*' -x '*.o' -x '*.mod' --new-file linux-2.5.69/drivers/media/radio/radio-aimslab.c linux-2.5.69.usercopy/drivers/media/radio/radio-aimslab.c
--- linux-2.5.69/drivers/media/radio/radio-aimslab.c	2003-04-07 19:30:58.000000000 +0200
+++ linux-2.5.69.usercopy/drivers/media/radio/radio-aimslab.c	2003-05-23 10:14:27.000000000 +0200
@@ -294,7 +294,7 @@
 static int rt_ioctl(struct inode *inode, struct file *file,
 		    unsigned int cmd, unsigned long arg)
 {
-	return video_usercopy(inode, file, cmd, arg, rt_do_ioctl);
+	return generic_usercopy(inode, file, cmd, arg, rt_do_ioctl);
 }
 
 static struct rt_device rtrack_unit;
diff -uNrwB -x '.*' -x '*.o' -x '*.mod' --new-file linux-2.5.69/drivers/media/radio/radio-aztech.c linux-2.5.69.usercopy/drivers/media/radio/radio-aztech.c
--- linux-2.5.69/drivers/media/radio/radio-aztech.c	2003-04-07 19:33:03.000000000 +0200
+++ linux-2.5.69.usercopy/drivers/media/radio/radio-aztech.c	2003-05-23 10:14:27.000000000 +0200
@@ -246,7 +246,7 @@
 static int az_ioctl(struct inode *inode, struct file *file,
 		    unsigned int cmd, unsigned long arg)
 {
-	return video_usercopy(inode, file, cmd, arg, az_do_ioctl);
+	return generic_usercopy(inode, file, cmd, arg, az_do_ioctl);
 }
 
 static struct az_device aztech_unit;
diff -uNrwB -x '.*' -x '*.o' -x '*.mod' --new-file linux-2.5.69/drivers/media/radio/radio-cadet.c linux-2.5.69.usercopy/drivers/media/radio/radio-cadet.c
--- linux-2.5.69/drivers/media/radio/radio-cadet.c	2003-05-06 13:15:33.000000000 +0200
+++ linux-2.5.69.usercopy/drivers/media/radio/radio-cadet.c	2003-05-23 10:14:27.000000000 +0200
@@ -471,7 +471,7 @@
 static int cadet_ioctl(struct inode *inode, struct file *file,
 		       unsigned int cmd, unsigned long arg)
 {
-	return video_usercopy(inode, file, cmd, arg, cadet_do_ioctl);
+	return generic_usercopy(inode, file, cmd, arg, cadet_do_ioctl);
 }
 
 static int cadet_open(struct inode *inode, struct file *file)
diff -uNrwB -x '.*' -x '*.o' -x '*.mod' --new-file linux-2.5.69/drivers/media/radio/radio-gemtek-pci.c linux-2.5.69.usercopy/drivers/media/radio/radio-gemtek-pci.c
--- linux-2.5.69/drivers/media/radio/radio-gemtek-pci.c	2003-04-07 19:30:41.000000000 +0200
+++ linux-2.5.69.usercopy/drivers/media/radio/radio-gemtek-pci.c	2003-05-23 10:14:27.000000000 +0200
@@ -275,7 +275,7 @@
 static int gemtek_pci_ioctl(struct inode *inode, struct file *file,
 			    unsigned int cmd, unsigned long arg)
 {
-	return video_usercopy(inode, file, cmd, arg, gemtek_pci_do_ioctl);
+	return generic_usercopy(inode, file, cmd, arg, gemtek_pci_do_ioctl);
 }
 
 enum {
diff -uNrwB -x '.*' -x '*.o' -x '*.mod' --new-file linux-2.5.69/drivers/media/radio/radio-gemtek.c linux-2.5.69.usercopy/drivers/media/radio/radio-gemtek.c
--- linux-2.5.69/drivers/media/radio/radio-gemtek.c	2003-04-07 19:30:32.000000000 +0200
+++ linux-2.5.69.usercopy/drivers/media/radio/radio-gemtek.c	2003-05-23 10:14:27.000000000 +0200
@@ -223,7 +223,7 @@
 static int gemtek_ioctl(struct inode *inode, struct file *file,
 			unsigned int cmd, unsigned long arg)
 {
-	return video_usercopy(inode, file, cmd, arg, gemtek_do_ioctl);
+	return generic_usercopy(inode, file, cmd, arg, gemtek_do_ioctl);
 }
 
 static struct gemtek_device gemtek_unit;
diff -uNrwB -x '.*' -x '*.o' -x '*.mod' --new-file linux-2.5.69/drivers/media/radio/radio-maestro.c linux-2.5.69.usercopy/drivers/media/radio/radio-maestro.c
--- linux-2.5.69/drivers/media/radio/radio-maestro.c	2003-04-07 19:31:50.000000000 +0200
+++ linux-2.5.69.usercopy/drivers/media/radio/radio-maestro.c	2003-05-23 10:14:27.000000000 +0200
@@ -265,7 +265,7 @@
 	int ret;
 
 	down(&card->lock);
-	ret = video_usercopy(inode, file, cmd, arg, radio_function);
+	ret = generic_usercopy(inode, file, cmd, arg, radio_function);
 	up(&card->lock);
 	return ret;
 }
diff -uNrwB -x '.*' -x '*.o' -x '*.mod' --new-file linux-2.5.69/drivers/media/radio/radio-maxiradio.c linux-2.5.69.usercopy/drivers/media/radio/radio-maxiradio.c
--- linux-2.5.69/drivers/media/radio/radio-maxiradio.c	2003-04-07 19:32:51.000000000 +0200
+++ linux-2.5.69.usercopy/drivers/media/radio/radio-maxiradio.c	2003-05-23 10:14:27.000000000 +0200
@@ -274,7 +274,7 @@
 	int ret;
 	
 	down(&card->lock);
-	ret = video_usercopy(inode, file, cmd, arg, radio_function);
+	ret = generic_usercopy(inode, file, cmd, arg, radio_function);
 	up(&card->lock);
 	return ret;
 }
diff -uNrwB -x '.*' -x '*.o' -x '*.mod' --new-file linux-2.5.69/drivers/media/radio/radio-rtrack2.c linux-2.5.69.usercopy/drivers/media/radio/radio-rtrack2.c
--- linux-2.5.69/drivers/media/radio/radio-rtrack2.c	2003-04-07 19:31:56.000000000 +0200
+++ linux-2.5.69.usercopy/drivers/media/radio/radio-rtrack2.c	2003-05-23 10:14:27.000000000 +0200
@@ -189,7 +189,7 @@
 static int rt_ioctl(struct inode *inode, struct file *file,
 		    unsigned int cmd, unsigned long arg)
 {
-	return video_usercopy(inode, file, cmd, arg, rt_do_ioctl);
+	return generic_usercopy(inode, file, cmd, arg, rt_do_ioctl);
 }
 
 static struct rt_device rtrack2_unit;
diff -uNrwB -x '.*' -x '*.o' -x '*.mod' --new-file linux-2.5.69/drivers/media/radio/radio-sf16fmi.c linux-2.5.69.usercopy/drivers/media/radio/radio-sf16fmi.c
--- linux-2.5.69/drivers/media/radio/radio-sf16fmi.c	2003-04-07 19:32:48.000000000 +0200
+++ linux-2.5.69.usercopy/drivers/media/radio/radio-sf16fmi.c	2003-05-23 10:14:27.000000000 +0200
@@ -217,7 +217,7 @@
 static int fmi_ioctl(struct inode *inode, struct file *file,
 		     unsigned int cmd, unsigned long arg)
 {
-	return video_usercopy(inode, file, cmd, arg, fmi_do_ioctl);
+	return generic_usercopy(inode, file, cmd, arg, fmi_do_ioctl);
 }
 
 static struct fmi_device fmi_unit;
diff -uNrwB -x '.*' -x '*.o' -x '*.mod' --new-file linux-2.5.69/drivers/media/radio/radio-terratec.c linux-2.5.69.usercopy/drivers/media/radio/radio-terratec.c
--- linux-2.5.69/drivers/media/radio/radio-terratec.c	2003-04-07 19:31:10.000000000 +0200
+++ linux-2.5.69.usercopy/drivers/media/radio/radio-terratec.c	2003-05-23 10:14:27.000000000 +0200
@@ -266,7 +266,7 @@
 static int tt_ioctl(struct inode *inode, struct file *file,
 		    unsigned int cmd, unsigned long arg)
 {
-	return video_usercopy(inode, file, cmd, arg, tt_do_ioctl);
+	return generic_usercopy(inode, file, cmd, arg, tt_do_ioctl);
 }
 
 static struct tt_device terratec_unit;
diff -uNrwB -x '.*' -x '*.o' -x '*.mod' --new-file linux-2.5.69/drivers/media/radio/radio-trust.c linux-2.5.69.usercopy/drivers/media/radio/radio-trust.c
--- linux-2.5.69/drivers/media/radio/radio-trust.c	2003-04-07 19:31:18.000000000 +0200
+++ linux-2.5.69.usercopy/drivers/media/radio/radio-trust.c	2003-05-23 10:14:27.000000000 +0200
@@ -247,7 +247,7 @@
 static int tr_ioctl(struct inode *inode, struct file *file,
 		    unsigned int cmd, unsigned long arg)
 {
-	return video_usercopy(inode, file, cmd, arg, tr_do_ioctl);
+	return generic_usercopy(inode, file, cmd, arg, tr_do_ioctl);
 }
 
 static struct file_operations trust_fops = {
diff -uNrwB -x '.*' -x '*.o' -x '*.mod' --new-file linux-2.5.69/drivers/media/radio/radio-typhoon.c linux-2.5.69.usercopy/drivers/media/radio/radio-typhoon.c
--- linux-2.5.69/drivers/media/radio/radio-typhoon.c	2003-04-07 19:31:05.000000000 +0200
+++ linux-2.5.69.usercopy/drivers/media/radio/radio-typhoon.c	2003-05-23 10:14:27.000000000 +0200
@@ -246,7 +246,7 @@
 static int typhoon_ioctl(struct inode *inode, struct file *file,
 			 unsigned int cmd, unsigned long arg)
 {
-	return video_usercopy(inode, file, cmd, arg, typhoon_do_ioctl);
+	return generic_usercopy(inode, file, cmd, arg, typhoon_do_ioctl);
 }
 
 static struct typhoon_device typhoon_unit =
diff -uNrwB -x '.*' -x '*.o' -x '*.mod' --new-file linux-2.5.69/drivers/media/radio/radio-zoltrix.c linux-2.5.69.usercopy/drivers/media/radio/radio-zoltrix.c
--- linux-2.5.69/drivers/media/radio/radio-zoltrix.c	2003-04-07 19:33:02.000000000 +0200
+++ linux-2.5.69.usercopy/drivers/media/radio/radio-zoltrix.c	2003-05-23 10:14:27.000000000 +0200
@@ -313,7 +313,7 @@
 static int zol_ioctl(struct inode *inode, struct file *file,
 		     unsigned int cmd, unsigned long arg)
 {
-	return video_usercopy(inode, file, cmd, arg, zol_do_ioctl);
+	return generic_usercopy(inode, file, cmd, arg, zol_do_ioctl);
 }
 
 static struct zol_device zoltrix_unit;

--------------000207000702060502050101
Content-Type: text/plain;
 name="04-dvb.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="04-dvb.diff"

diff -uNrwB -x '.*' -x '*.o' -x '*.mod' --new-file linux-2.5.69/drivers/media/dvb/dvb-core/Makefile.lib linux-2.5.69.usercopy/drivers/media/dvb/dvb-core/Makefile.lib
--- linux-2.5.69/drivers/media/dvb/dvb-core/Makefile.lib	2003-05-06 13:15:32.000000000 +0200
+++ linux-2.5.69.usercopy/drivers/media/dvb/dvb-core/Makefile.lib	2003-05-23 10:42:12.000000000 +0200
@@ -1 +1 @@
-obj-$(CONFIG_DVB_CORE)		+= crc32.o
+obj-$(CONFIG_DVB_CORE)		+= crc32.o usercopy.o
diff -uNrwB -x '.*' -x '*.o' -x '*.mod' --new-file linux-2.5.69/drivers/media/dvb/dvb-core/dmxdev.c linux-2.5.69.usercopy/drivers/media/dvb/dvb-core/dmxdev.c
--- linux-2.5.69/drivers/media/dvb/dvb-core/dmxdev.c	2003-05-06 13:15:32.000000000 +0200
+++ linux-2.5.69.usercopy/drivers/media/dvb/dvb-core/dmxdev.c	2003-05-23 10:17:57.000000000 +0200
@@ -983,7 +983,7 @@
 static int dvb_demux_ioctl(struct inode *inode, struct file *file,
 			   unsigned int cmd, unsigned long arg)
 {
-	return dvb_usercopy(inode, file, cmd, arg, dvb_demux_do_ioctl);
+	return generic_usercopy(inode, file, cmd, arg, dvb_demux_do_ioctl);
 }
 
 
@@ -1064,7 +1064,7 @@
 static int dvb_dvr_ioctl(struct inode *inode, struct file *file,
 			 unsigned int cmd, unsigned long arg)
 {
-	return dvb_usercopy(inode, file, cmd, arg, dvb_dvr_do_ioctl);
+	return generic_usercopy(inode, file, cmd, arg, dvb_dvr_do_ioctl);
 }
 
 
diff -uNrwB -x '.*' -x '*.o' -x '*.mod' --new-file linux-2.5.69/drivers/media/dvb/dvb-core/dvb_ksyms.c linux-2.5.69.usercopy/drivers/media/dvb/dvb-core/dvb_ksyms.c
--- linux-2.5.69/drivers/media/dvb/dvb-core/dvb_ksyms.c	2003-05-06 13:15:32.000000000 +0200
+++ linux-2.5.69.usercopy/drivers/media/dvb/dvb-core/dvb_ksyms.c	2003-05-23 10:17:57.000000000 +0200
@@ -8,70 +8,6 @@
 #include "dvb_demux.h"
 #include "dvb_net.h"
 
-/* if the miracle happens and "generic_usercopy()" is included into
-   the kernel, then this can vanish. please don't make the mistake and
-   define this as video_usercopy(). this will introduce a dependecy
-   to the v4l "videodev.o" module, which is unnecessary for some
-   cards (ie. the budget dvb-cards don't need the v4l module...) */
-int dvb_usercopy(struct inode *inode, struct file *file,
-	             unsigned int cmd, unsigned long arg,
-		     int (*func)(struct inode *inode, struct file *file,
-		     unsigned int cmd, void *arg))
-{
-        char    sbuf[128];
-        void    *mbuf = NULL;
-        void    *parg = NULL;
-        int     err  = -EINVAL;
-
-        /*  Copy arguments into temp kernel buffer  */
-        switch (_IOC_DIR(cmd)) {
-        case _IOC_NONE:
-                parg = (void *)arg;
-                break;
-        case _IOC_READ: /* some v4l ioctls are marked wrong ... */
-        case _IOC_WRITE:
-        case (_IOC_WRITE | _IOC_READ):
-                if (_IOC_SIZE(cmd) <= sizeof(sbuf)) {
-                        parg = sbuf;
-                } else {
-                        /* too big to allocate from stack */
-                        mbuf = kmalloc(_IOC_SIZE(cmd),GFP_KERNEL);
-                        if (NULL == mbuf)
-                                return -ENOMEM;
-                        parg = mbuf;
-                }
-
-                err = -EFAULT;
-                if (copy_from_user(parg, (void *)arg, _IOC_SIZE(cmd)))
-                        goto out;
-                break;
-        }
-
-        /* call driver */
-        if ((err = func(inode, file, cmd, parg)) == -ENOIOCTLCMD)
-                err = -EINVAL;
-
-        if (err < 0)
-                goto out;
-
-        /*  Copy results into user buffer  */
-        switch (_IOC_DIR(cmd))
-        {
-        case _IOC_READ:
-        case (_IOC_WRITE | _IOC_READ):
-                if (copy_to_user((void *)arg, parg, _IOC_SIZE(cmd)))
-                        err = -EFAULT;
-                break;
-        }
-
-out:
-        if (mbuf)
-                kfree(mbuf);
-
-        return err;
-}
-EXPORT_SYMBOL(dvb_usercopy);
-
 EXPORT_SYMBOL(dvb_dmxdev_init);
 EXPORT_SYMBOL(dvb_dmxdev_release);
 EXPORT_SYMBOL(dvb_dmx_init);
diff -uNrwB -x '.*' -x '*.o' -x '*.mod' --new-file linux-2.5.69/drivers/media/dvb/dvb-core/dvb_net.c linux-2.5.69.usercopy/drivers/media/dvb/dvb-core/dvb_net.c
--- linux-2.5.69/drivers/media/dvb/dvb-core/dvb_net.c	2003-05-06 13:15:32.000000000 +0200
+++ linux-2.5.69.usercopy/drivers/media/dvb/dvb-core/dvb_net.c	2003-05-23 10:17:57.000000000 +0200
@@ -535,7 +535,7 @@
 dvb_net_ioctl(struct inode *inode, struct file *file,
 	      unsigned int cmd, unsigned long arg)
 {
-	return dvb_usercopy(inode, file, cmd, arg, dvb_net_do_ioctl);
+	return generic_usercopy(inode, file, cmd, arg, dvb_net_do_ioctl);
 }
 
 static struct file_operations dvb_net_fops = {
diff -uNrwB -x '.*' -x '*.o' -x '*.mod' --new-file linux-2.5.69/drivers/media/dvb/dvb-core/dvbdev.c linux-2.5.69.usercopy/drivers/media/dvb/dvb-core/dvbdev.c
--- linux-2.5.69/drivers/media/dvb/dvb-core/dvbdev.c	2003-05-06 13:16:20.000000000 +0200
+++ linux-2.5.69.usercopy/drivers/media/dvb/dvb-core/dvbdev.c	2003-05-23 10:20:15.000000000 +0200
@@ -160,7 +160,7 @@
 	if (!dvbdev->kernel_ioctl)
 		return -EINVAL;
 
-	return dvb_usercopy (inode, file, cmd, arg, dvbdev->kernel_ioctl);
+	return generic_usercopy (inode, file, cmd, arg, dvbdev->kernel_ioctl);
 }
 
 
diff -uNrwB -x '.*' -x '*.o' -x '*.mod' --new-file linux-2.5.69/drivers/media/dvb/dvb-core/dvbdev.h linux-2.5.69.usercopy/drivers/media/dvb/dvb-core/dvbdev.h
--- linux-2.5.69/drivers/media/dvb/dvb-core/dvbdev.h	2003-05-06 13:16:20.000000000 +0200
+++ linux-2.5.69.usercopy/drivers/media/dvb/dvb-core/dvbdev.h	2003-05-23 10:20:25.000000000 +0200
@@ -29,6 +29,7 @@
 #include <linux/poll.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/list.h>
+#include <linux/usercopy.h>
 
 #define DVB_MAJOR 250
 
@@ -61,7 +62,7 @@
 	int users;
 	int writers;
 
-        /* don't really need those !? -- FIXME: use video_usercopy  */
+        /* don't really need those !? -- FIXME: use generic_usercopy  */
         int (*kernel_ioctl)(struct inode *inode, struct file *file,
 			    unsigned int cmd, void *arg);
 
@@ -84,9 +85,5 @@
 extern int dvb_generic_release (struct inode *inode, struct file *file);
 extern int dvb_generic_ioctl (struct inode *inode, struct file *file,
 			      unsigned int cmd, unsigned long arg);
-int dvb_usercopy(struct inode *inode, struct file *file,
-                     unsigned int cmd, unsigned long arg,
-                     int (*func)(struct inode *inode, struct file *file,
-                     unsigned int cmd, void *arg));
 #endif /* #ifndef _DVBDEV_H_ */
 

--------------000207000702060502050101--

