Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262637AbSI0UJF>; Fri, 27 Sep 2002 16:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262638AbSI0UJF>; Fri, 27 Sep 2002 16:09:05 -0400
Received: from [216.40.201.6] ([216.40.201.6]:30985 "EHLO
	www.businesssite.com.br") by vger.kernel.org with ESMTP
	id <S262637AbSI0UJD>; Fri, 27 Sep 2002 16:09:03 -0400
Date: Fri, 27 Sep 2002 17:09:00 -0300
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: laredo@gnu.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] stradis fixes
Message-ID: <20020927200900.GD416@cathedrallabs.org>
References: <20020927172230.GQ20649@cathedrallabs.org> <1033149332.16726.3.camel@irongate.swansea.linux.org.uk> <20020927183341.GA416@cathedrallabs.org> <1033154224.16726.19.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="/WwmFnJnmDyWGHa4"
Content-Disposition: inline
In-Reply-To: <1033154224.16726.19.camel@irongate.swansea.linux.org.uk>
From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> Maybe you should ask why they are integers and what else is wrong ?
ok, I guess I found it (?)

-- 
aris

--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="stradis.patch"

--- linux-2.5.38-vanilla/drivers/media/video/stradis.c	2002-09-27 16:46:04.000000000 -0300
+++ linux-2.5.38/drivers/media/video/stradis.c	2002-09-27 16:59:57.000000000 -0300
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
+static int saa_do_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
+							void *arg)
 {
-	struct saa7146 *saa = (struct saa7146 *) dev;
+	struct saa7146 *saa = (struct saa7146 *) file->private_data;
 	switch (cmd) {
 	case VIDIOCGCAP:
 		{
@@ -1579,7 +1574,7 @@
 			vu.radio = VIDEO_NO_UNIT;
 			vu.audio = VIDEO_NO_UNIT;
 			vu.teletext = VIDEO_NO_UNIT;
-			if (copy_to_user((void *) arg, (void *) &vu, sizeof(vu)))
+			if (copy_to_user(arg, (void *) &vu, sizeof(vu)))
 				return -EFAULT;
 			return 0;
 		}
@@ -1806,24 +1801,22 @@
 	return 0;
 }
 
-static int saa_mmap(struct video_device *dev, const char *adr,
-		    unsigned long size)
+static int saa_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
+							unsigned long arg)
 {
-	struct saa7146 *saa = (struct saa7146 *) dev;
-	printk(KERN_DEBUG "stradis%d: saa_mmap called\n", saa->nr);
-	return -EINVAL;
+	return video_usercopy(inode, file, cmd, arg, saa_do_ioctl);
 }
 
-static long saa_read(struct video_device *dev, char *buf,
-		     unsigned long count, int nonblock)
+static int saa_mmap(struct file *file, struct vm_area_struct *vm_area)
 {
+	struct saa7146 *saa = (struct saa7146 *) file->private_data;
+	printk(KERN_DEBUG "stradis%d: saa_mmap called\n", saa->nr);
 	return -EINVAL;
 }
 
-static long saa_write(struct video_device *dev, const char *buf,
-		      unsigned long count, int nonblock)
+static ssize_t saa_write(struct file *file, const char *buf, size_t count, loff_t *offset)
 {
-	struct saa7146 *saa = (struct saa7146 *) dev;
+	struct saa7146 *saa = (struct saa7146 *) file->private_data;
 	unsigned long todo = count;
 	int blocksize, split;
 	unsigned long flags;
@@ -1942,11 +1935,10 @@
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
@@ -1954,16 +1946,25 @@
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
@@ -1971,12 +1972,7 @@
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

--/WwmFnJnmDyWGHa4--
