Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292800AbSCRKuY>; Mon, 18 Mar 2002 05:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292599AbSCRKuP>; Mon, 18 Mar 2002 05:50:15 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:64774 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S292530AbSCRKuF>; Mon, 18 Mar 2002 05:50:05 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 18 Mar 2002 11:03:53 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Kernel List <linux-kernel@vger.kernel.org>,
        video4linux list <video4linux-list@redhat.com>
Subject: [patch] videodev fixups / generic usercopy helper
Message-ID: <20020318110353.A14904@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

I've just noticed that a hole left in the recent changes which should
allow the usb v4l drivers to unregister with open file handles.  The
drivers itself handle it just fine, but video_generic_ioctl() will barf
when called on unregistered devices.  Oops.

One way to fix this is to expect drivers call the helper function and
pass a pointer for the function doing the actual work, i.e. handle it
this way:

driver_ioctl(inode,file,cmd,userptr)
	-> video_usercopy(inode,file,cmd,userptr,func)
		copy_from_user(...)
		-> func(inode,file,cmd,kernelptr);
		copy_to_user(...)

Patch against 2.5.7-pre2 below. It updates videodev.[ch] and adapts
usbvideo.c to show how the driver changes will look like.

Note that this change makes the usercopy helper function a very generic
one, it probably could be used for other drivers to (as long as the API
has sane magic numbers based on _IO*(...) defines) as there is no
video4linux-related stuff in there any more.  So we might think of
renaming it an moving it to some more central place (fs/ioctl.c maybe).

Comments?

  Gerd

==============================[ cut here ]==============================
===== drivers/media/video/videodev.c 1.11 vs edited =====
--- 1.11/drivers/media/video/videodev.c	Fri Mar  8 13:42:38 2002
+++ edited/drivers/media/video/videodev.c	Mon Mar 18 09:55:26 2002
@@ -107,20 +107,18 @@
 }
 
 /*
- * ioctl helper function -- handles userspace copying
+ * helper function -- handles userspace copying for ioctl arguments
  */
 int
-video_generic_ioctl(struct inode *inode, struct file *file,
-		    unsigned int cmd, unsigned long arg)
+video_usercopy(struct inode *inode, struct file *file,
+	       unsigned int cmd, unsigned long arg,
+	       int (*func)(struct inode *inode, struct file *file,
+			   unsigned int cmd, void *arg))
 {
-	struct  video_device *vfl = video_devdata(file);
 	char	sbuf[128];
 	void    *mbuf = NULL;
 	void	*parg = NULL;
 	int	err  = -EINVAL;
-	
-	if (vfl->kernel_ioctl == NULL)
-		return -EINVAL;
 
 	/*  Copy arguments into temp kernel buffer  */
 	switch (_IOC_DIR(cmd)) {
@@ -147,7 +145,7 @@
 	}
 
 	/* call driver */
-	err = vfl->kernel_ioctl(inode, file, cmd, parg);
+	err = func(inode, file, cmd, parg);
 	if (err == -ENOIOCTLCMD)
 		err = -EINVAL;
 	if (err < 0)
@@ -512,7 +510,7 @@
 EXPORT_SYMBOL(video_register_device);
 EXPORT_SYMBOL(video_unregister_device);
 EXPORT_SYMBOL(video_devdata);
-EXPORT_SYMBOL(video_generic_ioctl);
+EXPORT_SYMBOL(video_usercopy);
 EXPORT_SYMBOL(video_exclusive_open);
 EXPORT_SYMBOL(video_exclusive_release);
 
===== drivers/usb/usbvideo.c 1.13 vs edited =====
--- 1.13/drivers/usb/usbvideo.c	Fri Mar  8 13:42:42 2002
+++ edited/drivers/usb/usbvideo.c	Mon Mar 18 09:53:46 2002
@@ -1020,7 +1020,7 @@
 	release:  usbvideo_v4l_close,
 	read:     usbvideo_v4l_read,
 	mmap:     usbvideo_v4l_mmap,
-	ioctl:    video_generic_ioctl,
+	ioctl:    usbvideo_v4l_ioctl,
 	llseek:   no_llseek,
 };
 static struct video_device usbvideo_template = {
@@ -1028,7 +1028,6 @@
 	type:         VID_TYPE_CAPTURE,
 	hardware:     VID_HARDWARE_CPIA,
 	fops:         &usbvideo_fops,
-	kernel_ioctl: usbvideo_v4l_ioctl,
 };
 
 uvd_t *usbvideo_AllocateDevice(usbvideo_t *cams)
@@ -1349,8 +1348,8 @@
  * History:
  * 22-Jan-2000 Corrected VIDIOCSPICT to reject unsupported settings.
  */
-int usbvideo_v4l_ioctl(struct inode *inode, struct file *file,
-		       unsigned int cmd, void *arg)
+static int usbvideo_v4l_do_ioctl(struct inode *inode, struct file *file,
+				 unsigned int cmd, void *arg)
 {
 	uvd_t *uvd = file->private_data;
 
@@ -1553,6 +1552,12 @@
 			return -ENOIOCTLCMD;
 	}
 	return 0;
+}
+
+int usbvideo_v4l_ioctl(struct inode *inode, struct file *file,
+		       unsigned int cmd, unsigned long arg)
+{
+	return video_usercopy(inode, file, cmd, arg, usbvideo_v4l_do_ioctl);
 }
 
 /*
===== drivers/usb/usbvideo.h 1.8 vs edited =====
--- 1.8/drivers/usb/usbvideo.h	Fri Mar  8 13:59:09 2002
+++ edited/drivers/usb/usbvideo.h	Mon Mar 18 09:57:14 2002
@@ -350,7 +350,7 @@
 int usbvideo_v4l_close(struct inode *inode, struct file *file);
 int usbvideo_v4l_initialize(struct video_device *dev);
 int usbvideo_v4l_ioctl(struct inode *inode, struct file *file,
-		       unsigned int ioctlnr, void *arg);
+		       unsigned int cmd, unsigned long arg);
 int usbvideo_v4l_mmap(struct file *file, struct vm_area_struct *vma);
 int usbvideo_v4l_open(struct inode *inode, struct file *file);
 int usbvideo_v4l_read(struct file *file, char *buf,
===== include/linux/videodev.h 1.12 vs edited =====
--- 1.12/include/linux/videodev.h	Fri Mar  8 13:42:38 2002
+++ edited/include/linux/videodev.h	Mon Mar 18 09:55:52 2002
@@ -37,8 +37,6 @@
  	 * video_generic_ioctl() does the userspace copying of the
  	 * ioctl arguments */
  	struct file_operations *fops;
- 	int (*kernel_ioctl)(struct inode *inode, struct file *file,
- 			    unsigned int cmd, void *arg);
 	void *priv;		/* Used to be 'private' but that upsets C++ */
 
 	/* for videodev.c intenal usage -- don't touch */
@@ -60,8 +58,10 @@
 
 extern int video_exclusive_open(struct inode *inode, struct file *file);
 extern int video_exclusive_release(struct inode *inode, struct file *file);
-extern int video_generic_ioctl(struct inode *inode, struct file *file,
-			       unsigned int cmd, unsigned long arg);
+extern int video_usercopy(struct inode *inode, struct file *file,
+			  unsigned int cmd, unsigned long arg,
+			  int (*func)(struct inode *inode, struct file *file,
+				      unsigned int cmd, void *arg));
 #endif /* __KERNEL__ */
 
 #define VID_TYPE_CAPTURE	1	/* Can capture */
