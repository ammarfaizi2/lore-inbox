Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286521AbSABBUB>; Tue, 1 Jan 2002 20:20:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286519AbSABBTw>; Tue, 1 Jan 2002 20:19:52 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10002 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S286502AbSABBTj>;
	Tue, 1 Jan 2002 20:19:39 -0500
Message-ID: <3C326028.6A2C84AF@mandrakesoft.com>
Date: Tue, 01 Jan 2002 20:19:36 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: PATCH 2.5.2.6: fix sound, videodev subsystem builds
Content-Type: multipart/mixed;
 boundary="------------79E02337D66C3D73044898C6"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------79E02337D66C3D73044898C6
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

just the core objects, not individual drivers...
-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno
--------------79E02337D66C3D73044898C6
Content-Type: text/plain; charset=us-ascii;
 name="media-2.5.2.6.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="media-2.5.2.6.patch"

Index: drivers/media/video/videodev.c
===================================================================
RCS file: /cvsroot/gkernel/linux_2_5/drivers/media/video/videodev.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 videodev.c
--- drivers/media/video/videodev.c	2001/10/11 16:14:32	1.1.1.1
+++ drivers/media/video/videodev.c	2002/01/02 01:15:54
@@ -70,7 +70,7 @@
 static ssize_t video_read(struct file *file,
 	char *buf, size_t count, loff_t *ppos)
 {
-	struct video_device *vfl=video_device[MINOR(file->f_dentry->d_inode->i_rdev)];
+	struct video_device *vfl=video_device[minor(file->f_dentry->d_inode->i_rdev)];
 	if(vfl->read)
 		return vfl->read(vfl, buf, count, file->f_flags&O_NONBLOCK);
 	else
@@ -86,7 +86,7 @@
 static ssize_t video_write(struct file *file, const char *buf, 
 	size_t count, loff_t *ppos)
 {
-	struct video_device *vfl=video_device[MINOR(file->f_dentry->d_inode->i_rdev)];
+	struct video_device *vfl=video_device[minor(file->f_dentry->d_inode->i_rdev)];
 	if(vfl->write)
 		return vfl->write(vfl, buf, count, file->f_flags&O_NONBLOCK);
 	else
@@ -100,7 +100,7 @@
 
 static unsigned int video_poll(struct file *file, poll_table * wait)
 {
-	struct video_device *vfl=video_device[MINOR(file->f_dentry->d_inode->i_rdev)];
+	struct video_device *vfl=video_device[minor(file->f_dentry->d_inode->i_rdev)];
 	if(vfl->poll)
 		return vfl->poll(vfl, file, wait);
 	else
@@ -114,7 +114,7 @@
 
 static int video_open(struct inode *inode, struct file *file)
 {
-	unsigned int minor = MINOR(inode->i_rdev);
+	unsigned int minor = minor(inode->i_rdev);
 	int err, retval = 0;
 	struct video_device *vfl;
 	
@@ -170,7 +170,7 @@
 {
 	struct video_device *vfl;
 	lock_kernel();
-	vfl=video_device[MINOR(inode->i_rdev)];
+	vfl=video_device[minor(inode->i_rdev)];
 	if(vfl->close)
 		vfl->close(vfl);
 	vfl->busy=0;
@@ -183,7 +183,7 @@
 static int video_ioctl(struct inode *inode, struct file *file,
 	unsigned int cmd, unsigned long arg)
 {
-	struct video_device *vfl=video_device[MINOR(inode->i_rdev)];
+	struct video_device *vfl=video_device[minor(inode->i_rdev)];
 	int err=vfl->ioctl(vfl, cmd, (void *)arg);
 
 	if(err!=-ENOIOCTLCMD)
@@ -203,7 +203,7 @@
 int video_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	int ret = -EINVAL;
-	struct video_device *vfl=video_device[MINOR(file->f_dentry->d_inode->i_rdev)];
+	struct video_device *vfl=video_device[minor(file->f_dentry->d_inode->i_rdev)];
 	if(vfl->mmap) {
 		lock_kernel();
 		ret = vfl->mmap(vfl, (char *)vma->vm_start, 
Index: drivers/sound/soundcard.c
===================================================================
RCS file: /cvsroot/gkernel/linux_2_5/drivers/sound/soundcard.c,v
retrieving revision 1.2
diff -u -r1.2 soundcard.c
--- drivers/sound/soundcard.c	2001/12/30 22:23:03	1.2
+++ drivers/sound/soundcard.c	2002/01/02 01:15:54
@@ -144,7 +144,7 @@
 
 static ssize_t sound_read(struct file *file, char *buf, size_t count, loff_t *ppos)
 {
-	int dev = MINOR(file->f_dentry->d_inode->i_rdev);
+	int dev = minor(file->f_dentry->d_inode->i_rdev);
 	int ret = -EINVAL;
 
 	/*
@@ -177,7 +177,7 @@
 
 static ssize_t sound_write(struct file *file, const char *buf, size_t count, loff_t *ppos)
 {
-	int dev = MINOR(file->f_dentry->d_inode->i_rdev);
+	int dev = minor(file->f_dentry->d_inode->i_rdev);
 	int ret = -EINVAL;
 	
 	lock_kernel();
@@ -204,7 +204,7 @@
 
 static int sound_open(struct inode *inode, struct file *file)
 {
-	int dev = MINOR(inode->i_rdev);
+	int dev = minor(inode->i_rdev);
 	int retval;
 
 	DEB(printk("sound_open(dev=%d)\n", dev));
@@ -255,7 +255,7 @@
 
 static int sound_release(struct inode *inode, struct file *file)
 {
-	int dev = MINOR(inode->i_rdev);
+	int dev = minor(inode->i_rdev);
 
 	lock_kernel();
 	DEB(printk("sound_release(dev=%d)\n", dev));
@@ -341,7 +341,7 @@
 		       unsigned int cmd, unsigned long arg)
 {
 	int err, len = 0, dtype;
-	int dev = MINOR(inode->i_rdev);
+	int dev = minor(inode->i_rdev);
 
 	if (_SIOC_DIR(cmd) != _SIOC_NONE && _SIOC_DIR(cmd) != 0) {
 		/*
@@ -404,7 +404,7 @@
 static unsigned int sound_poll(struct file *file, poll_table * wait)
 {
 	struct inode *inode = file->f_dentry->d_inode;
-	int dev = MINOR(inode->i_rdev);
+	int dev = minor(inode->i_rdev);
 
 	DEB(printk("sound_poll(dev=%d)\n", dev));
 	switch (dev & 0x0f) {
@@ -428,7 +428,7 @@
 	int dev_class;
 	unsigned long size;
 	struct dma_buffparms *dmap = NULL;
-	int dev = MINOR(file->f_dentry->d_inode->i_rdev);
+	int dev = minor(file->f_dentry->d_inode->i_rdev);
 
 	dev_class = dev & 0x0f;
 	dev >>= 4;

--------------79E02337D66C3D73044898C6--

