Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262546AbSI0RU4>; Fri, 27 Sep 2002 13:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262548AbSI0RU4>; Fri, 27 Sep 2002 13:20:56 -0400
Received: from [216.40.201.6] ([216.40.201.6]:57361 "EHLO
	www.businesssite.com.br") by vger.kernel.org with ESMTP
	id <S262546AbSI0RUn>; Fri, 27 Sep 2002 13:20:43 -0400
Date: Fri, 27 Sep 2002 14:22:30 -0300
To: laredo@gnu.org
Cc: linux-kernel@vger.kernel.org
Subject: [patch] stradis fixes
Message-ID: <20020927172230.GQ20649@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="U3BNvdZEnlJXqmh+"
Content-Disposition: inline
From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--U3BNvdZEnlJXqmh+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hi,
	this patch makes stradis driver uses struct file_operations (struct
video_device changed).

-- 
aris

--U3BNvdZEnlJXqmh+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="stradis.patch"

--- linux-2.5.38-vanilla/drivers/media/video/stradis.c	2002-09-22 01:25:18.000000000 -0300
+++ linux-2.5.38/drivers/media/video/stradis.c	2002-09-25 14:27:20.000000000 -0300
@@ -241,12 +241,6 @@
 	}
 }
 
-static void detach_inform(struct saa7146 *saa, int id)
-{
-	int i;
-	i = saa->nr;
-}
-
 static void I2CBusScan(struct saa7146 *saa)
 {
 	int i;
@@ -1323,9 +1317,10 @@
 		clip_draw_rectangle(clipmap, 0, 0, 1024, -(saa->win.y));
 }
 
-static int saa_ioctl(struct video_device *dev, unsigned int cmd, void *arg)
+static int saa_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
+							unsigned long arg)
 {
-	struct saa7146 *saa = (struct saa7146 *) dev;
+	struct saa7146 *saa = (struct saa7146 *) file->private_data;
 	switch (cmd) {
 	case VIDIOCGCAP:
 		{
@@ -1342,7 +1337,7 @@
 			b.maxheight = 576;
 			b.minwidth = 32;
 			b.minheight = 32;
-			if (copy_to_user(arg, &b, sizeof(b)))
+			if (copy_to_user((void *) arg, &b, sizeof(b)))
 				return -EFAULT;
 			return 0;
 		}
@@ -1359,7 +1354,7 @@
 				p.palette = VIDEO_PALETTE_RGB24;
 			if (saa->win.depth == 32)
 				p.palette = VIDEO_PALETTE_RGB32;
-			if (copy_to_user(arg, &p, sizeof(p)))
+			if (copy_to_user((void *) arg, &p, sizeof(p)))
 				return -EFAULT;
 			return 0;
 		}
@@ -1367,7 +1362,7 @@
 		{
 			struct video_picture p;
 			u32 format;
-			if (copy_from_user(&p, arg, sizeof(p)))
+			if (copy_from_user(&p, (void *) arg, sizeof(p)))
 				return -EFAULT;
 			if (p.palette < sizeof(palette2fmt) / sizeof(u32)) {
 				format = palette2fmt[p.palette];
@@ -1390,7 +1385,7 @@
 			struct video_window vw;
 			struct video_clip *vcp = NULL;
 
-			if (copy_from_user(&vw, arg, sizeof(vw)))
+			if (copy_from_user(&vw, (void *) arg, sizeof(vw)))
 				return -EFAULT;
 
 			if (vw.flags || vw.width < 16 || vw.height < 16) {	/* stop capture */
@@ -1460,14 +1455,14 @@
 			vw.height = saa->win.height;
 			vw.chromakey = 0;
 			vw.flags = 0;
-			if (copy_to_user(arg, &vw, sizeof(vw)))
+			if (copy_to_user((void *) arg, &vw, sizeof(vw)))
 				return -EFAULT;
 			return 0;
 		}
 	case VIDIOCCAPTURE:
 		{
 			int v;
-			if (copy_from_user(&v, arg, sizeof(v)))
+			if (copy_from_user(&v, (void *) arg, sizeof(v)))
 				return -EFAULT;
 			if (v == 0) {
 				saa->cap &= ~1;
@@ -1491,7 +1486,7 @@
 			v.width = saa->win.swidth;
 			v.depth = saa->win.depth;
 			v.bytesperline = saa->win.bpl;
-			if (copy_to_user(arg, &v, sizeof(v)))
+			if (copy_to_user((void *) arg, &v, sizeof(v)))
 				return -EFAULT;
 			return 0;
 
@@ -1501,7 +1496,7 @@
 			struct video_buffer v;
 			if (!capable(CAP_SYS_ADMIN))
 				return -EPERM;
-			if (copy_from_user(&v, arg, sizeof(v)))
+			if (copy_from_user(&v, (void *) arg, sizeof(v)))
 				return -EFAULT;
 			if (v.depth != 8 && v.depth != 15 && v.depth != 16 &&
 			v.depth != 24 && v.depth != 32 && v.width > 16 &&
@@ -1534,7 +1529,7 @@
 			v.flags |= VIDEO_AUDIO_MUTABLE | VIDEO_AUDIO_VOLUME;
 			strcpy(v.name, "MPEG");
 			v.mode = VIDEO_SOUND_STEREO;
-			if (copy_to_user(arg, &v, sizeof(v)))
+			if (copy_to_user((void *) arg, &v, sizeof(v)))
 				return -EFAULT;
 			return 0;
 		}
@@ -1542,7 +1537,7 @@
 		{
 			struct video_audio v;
 			int i;
-			if (copy_from_user(&v, arg, sizeof(v)))
+			if (copy_from_user(&v, (void *) arg, sizeof(v)))
 				return -EFAULT;
 			i = (~(v.volume>>8))&0xff;
 			if (!HaveCS4341) {
@@ -1586,7 +1581,7 @@
 	case VIDIOCSPLAYMODE:
 		{
 			struct video_play_mode pmode;
-			if (copy_from_user((void *) &pmode, arg,
+			if (copy_from_user((void *) &pmode, (void *) arg,
 				sizeof(struct video_play_mode)))
 				return -EFAULT;
 			switch (pmode.mode) {
@@ -1736,7 +1731,8 @@
 	case VIDIOCSWRITEMODE:
 		{
 			int mode;
-			if (copy_from_user((void *) &mode, arg, sizeof(int)))
+			if (copy_from_user((void *) &mode, (void *) arg,
+								sizeof(int)))
 				 return -EFAULT;
 			if (mode == VID_WRITE_MPEG_AUD ||
 			    mode == VID_WRITE_MPEG_VID ||
@@ -1753,7 +1749,7 @@
 			struct video_code ucode;
 			__u8 *udata;
 			int i;
-			if (copy_from_user((void *) &ucode, arg,
+			if (copy_from_user((void *) &ucode, (void *) arg,
 			    sizeof(ucode)))
 				return -EFAULT;
 			if (ucode.datasize > 65536 || ucode.datasize < 1024 ||
@@ -1781,21 +1777,21 @@
 	case VIDIOCGCHAN:	/* this makes xawtv happy */
 		{
 			struct video_channel v;
-			if (copy_from_user(&v, arg, sizeof(v)))
+			if (copy_from_user(&v, (void *) arg, sizeof(v)))
 				return -EFAULT;
 			v.flags = VIDEO_VC_AUDIO;
 			v.tuners = 0;
 			v.type = VID_TYPE_MPEG_DECODER;
 			v.norm = CurrentMode;
 			strcpy(v.name, "MPEG2");
-			if (copy_to_user(arg, &v, sizeof(v)))
+			if (copy_to_user((void *) arg, &v, sizeof(v)))
 				return -EFAULT;
 			return 0;
 		}
 	case VIDIOCSCHAN:	/* this makes xawtv happy */
 		{
 			struct video_channel v;
-			if (copy_from_user(&v, arg, sizeof(v)))
+			if (copy_from_user(&v, (void *) arg, sizeof(v)))
 				return -EFAULT;
 			/* do nothing */
 			return 0;
@@ -1806,24 +1802,16 @@
 	return 0;
 }
 
-static int saa_mmap(struct video_device *dev, const char *adr,
-		    unsigned long size)
+static int saa_mmap(struct file *file, struct vm_area_struct *vm_area)
 {
-	struct saa7146 *saa = (struct saa7146 *) dev;
+	struct saa7146 *saa = (struct saa7146 *) file->private_data;
 	printk(KERN_DEBUG "stradis%d: saa_mmap called\n", saa->nr);
 	return -EINVAL;
 }
 
-static long saa_read(struct video_device *dev, char *buf,
-		     unsigned long count, int nonblock)
+static ssize_t saa_write(struct file *file, const char *buf, size_t count, loff_t *offset)
 {
-	return -EINVAL;
-}
-
-static long saa_write(struct video_device *dev, const char *buf,
-		      unsigned long count, int nonblock)
-{
-	struct saa7146 *saa = (struct saa7146 *) dev;
+	struct saa7146 *saa = (struct saa7146 *) file->private_data;
 	unsigned long todo = count;
 	int blocksize, split;
 	unsigned long flags;
@@ -1942,11 +1930,10 @@
 	return count;
 }
 
-static int saa_open(struct video_device *dev, int flags)
+static int saa_open(struct inode *inode, struct file *file)
 {
-	struct saa7146 *saa = (struct saa7146 *) dev;
+	struct saa7146 *saa = (struct saa7146 *) file->private_data;
 
-	saa->video_dev.busy = 0;
 	saa->user++;
 	if (saa->user > 1)
 		return 0;	/* device open already, don't reset */
@@ -1954,16 +1941,25 @@
 	return 0;
 }
 
-static void saa_close(struct video_device *dev)
+static ssize_t saa_close(struct inode *inode, struct file *file)
 {
-	struct saa7146 *saa = (struct saa7146 *) dev;
+	struct saa7146 *saa = (struct saa7146 *) file->private_data;
 	saa->user--;
-	saa->video_dev.busy = 0;
-	if (saa->user > 0)	/* still someone using device */
-		return;
-	saawrite(0x007f0000, SAA7146_MC1);	/* stop all overlay dma */
+	if (saa->user == 0)
+		saawrite(0x007f0000, SAA7146_MC1);	/* stop all overlay dma */
+
+	return 0;
 }
 
+static struct file_operations saa_fops =
+{
+	open:		saa_open,
+	release:	saa_close,
+	write:		saa_write,
+	ioctl:		saa_ioctl,
+	mmap:		saa_mmap,
+};
+
 /* template for video_device-structure */
 static struct video_device saa_template =
 {
@@ -1971,12 +1967,7 @@
 	name:		"SAA7146A",
 	type:		VID_TYPE_CAPTURE | VID_TYPE_OVERLAY,
 	hardware:	VID_HARDWARE_SAA7146,
-	open:		saa_open,
-	close:		saa_close,
-	read:		saa_read,
-	write:		saa_write,
-	ioctl:		saa_ioctl,
-	mmap:		saa_mmap,
+	fops:		&saa_fops,
 };
 
 static int configure_saa7146(struct pci_dev *dev, int num)

--U3BNvdZEnlJXqmh+--
