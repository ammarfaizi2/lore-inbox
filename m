Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312991AbSDJMgT>; Wed, 10 Apr 2002 08:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312883AbSDJMfl>; Wed, 10 Apr 2002 08:35:41 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:2316 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S312991AbSDJMfR>; Wed, 10 Apr 2002 08:35:17 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Wed, 10 Apr 2002 13:04:28 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@transmeta.com>,
        Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] 2.5.8-pre video driver fixes
Message-ID: <20020410130428.C26389@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch adapts the v4l video drivers to the -pre1 videodev fix and
makes them compile again.

  Gerd

==============================[ cut here ]==============================
# ChangeSet
#   1.586 02/04/08 10:05:09 kraxel@bytesex.org +8 -0
#   adapt v4l video drivers to 2.5.8-pre1 videodev fixes.
# 
#   drivers/media/video/w9966.c
#     1.5 02/03/19 18:24:12 kraxel@bytesex.org +10 -5
#     adapt v4l video drivers to 2.5.8-pre1 videodev fixes.
# 
#   drivers/media/video/saa5249.c
#     1.8 02/03/19 18:24:12 kraxel@bytesex.org +7 -6
#     adapt v4l video drivers to 2.5.8-pre1 videodev fixes.
# 
#   drivers/media/video/pms.c
#     1.8 02/03/19 18:24:12 kraxel@bytesex.org +9 -4
#     adapt v4l video drivers to 2.5.8-pre1 videodev fixes.
# 
#   drivers/media/video/cpia.c
#     1.15 02/03/19 18:24:12 kraxel@bytesex.org +9 -4
#     adapt v4l video drivers to 2.5.8-pre1 videodev fixes.
# 
#   drivers/media/video/c-qcam.c
#     1.8 02/03/19 18:24:12 kraxel@bytesex.org +9 -4
#     adapt v4l video drivers to 2.5.8-pre1 videodev fixes.
# 
#   drivers/media/video/bw-qcam.c
#     1.8 02/03/19 18:24:12 kraxel@bytesex.org +9 -4
#     adapt v4l video drivers to 2.5.8-pre1 videodev fixes.
# 
#   drivers/media/video/bttv-vbi.c
#     1.2 02/03/19 18:24:12 kraxel@bytesex.org +9 -4
#     adapt v4l video drivers to 2.5.8-pre1 videodev fixes.
# 
#   drivers/media/video/bttv-driver.c
#     1.17 02/03/19 18:24:12 kraxel@bytesex.org +18 -8
#     adapt v4l video drivers to 2.5.8-pre1 videodev fixes.
# 
======================================================================
diff -Nru a/drivers/media/video/bttv-driver.c b/drivers/media/video/bttv-driver.c
--- a/drivers/media/video/bttv-driver.c	Mon Apr  8 10:18:25 2002
+++ b/drivers/media/video/bttv-driver.c	Mon Apr  8 10:18:25 2002
@@ -1650,8 +1650,8 @@
 	bttv_dma_free(fh->btv,buf);
 }
 
-static int bttv_ioctl(struct inode *inode, struct file *file,
-		      unsigned int cmd, void *arg)
+static int bttv_do_ioctl(struct inode *inode, struct file *file,
+			 unsigned int cmd, void *arg)
 {
 	struct bttv_fh *fh  = file->private_data;
 	struct bttv    *btv = fh->btv;
@@ -2432,6 +2432,12 @@
 	return retval;
 }
 
+static int bttv_ioctl(struct inode *inode, struct file *file,
+		      unsigned int cmd, unsigned long arg)
+{
+	return video_usercopy(inode, file, cmd, arg, bttv_do_ioctl);
+}
+
 /* start capture to a kernel bounce buffer */
 static int bttv_read_capture(struct bttv_fh *fh)
 {
@@ -2647,7 +2653,7 @@
 	owner:	  THIS_MODULE,
 	open:	  bttv_open,
 	release:  bttv_release,
-	ioctl:	  video_generic_ioctl,
+	ioctl:	  bttv_ioctl,
 	llseek:	  no_llseek,
 	read:	  bttv_read,
 	mmap:	  bttv_mmap,
@@ -2661,7 +2667,6 @@
 	          VID_TYPE_CLIPPING|VID_TYPE_SCALES,
 	hardware: VID_HARDWARE_BT848,
 	fops:     &bttv_fops,
-	kernel_ioctl: bttv_ioctl,
 	minor:    -1,
 };
 
@@ -2712,8 +2717,8 @@
 	return 0;
 }
 
-static int radio_ioctl(struct inode *inode, struct file *file,
-		       unsigned int cmd, void *arg)
+static int radio_do_ioctl(struct inode *inode, struct file *file,
+			  unsigned int cmd, void *arg)
 {
 	struct bttv    *btv = file->private_data;
 
@@ -2763,12 +2768,18 @@
 	return 0;
 }
 
+static int radio_ioctl(struct inode *inode, struct file *file,
+		       unsigned int cmd, unsigned long arg)
+{
+	return video_usercopy(inode, file, cmd, arg, radio_do_ioctl);
+}
+
 static struct file_operations radio_fops =
 {
 	owner:	  THIS_MODULE,
 	open:	  radio_open,
 	release:  radio_release,
-	ioctl:	  video_generic_ioctl,
+	ioctl:	  radio_ioctl,
 	llseek:	  no_llseek,
 };
 
@@ -2778,7 +2789,6 @@
 	type:     VID_TYPE_TUNER|VID_TYPE_TELETEXT,
 	hardware: VID_HARDWARE_BT848,
 	fops:     &radio_fops,
-	kernel_ioctl: radio_ioctl,
 	minor:    -1,
 };
 
diff -Nru a/drivers/media/video/bttv-vbi.c b/drivers/media/video/bttv-vbi.c
--- a/drivers/media/video/bttv-vbi.c	Mon Apr  8 10:18:25 2002
+++ b/drivers/media/video/bttv-vbi.c	Mon Apr  8 10:18:25 2002
@@ -276,8 +276,8 @@
 	return 0;
 }
 
-static int vbi_ioctl(struct inode *inode, struct file *file,
-		     unsigned int cmd, void *arg)
+static int vbi_do_ioctl(struct inode *inode, struct file *file,
+			unsigned int cmd, void *arg)
 {
 	struct bttv *btv = file->private_data;
 #ifdef HAVE_V4L2
@@ -507,6 +507,12 @@
 #endif
 }
 
+static int vbi_ioctl(struct inode *inode, struct file *file,
+		     unsigned int cmd, unsigned long arg)
+{
+	return video_usercopy(inode, file, cmd, arg, vbi_do_ioctl);
+}
+
 static ssize_t vbi_read(struct file *file, char *data,
 			size_t count, loff_t *ppos)
 {
@@ -634,7 +640,7 @@
 	owner:	  THIS_MODULE,
 	open:	  vbi_open,
 	release:  vbi_release,
-	ioctl:	  video_generic_ioctl,
+	ioctl:	  vbi_ioctl,
 	llseek:	  no_llseek,
 	read:	  vbi_read,
 	poll:	  vbi_poll,
@@ -647,7 +653,6 @@
 	type:     VID_TYPE_TUNER|VID_TYPE_TELETEXT,
 	hardware: VID_HARDWARE_BT848,
 	fops:     &vbi_fops,
-	kernel_ioctl: vbi_ioctl,
 	minor:    -1,
 };
 
diff -Nru a/drivers/media/video/bw-qcam.c b/drivers/media/video/bw-qcam.c
--- a/drivers/media/video/bw-qcam.c	Mon Apr  8 10:18:25 2002
+++ b/drivers/media/video/bw-qcam.c	Mon Apr  8 10:18:25 2002
@@ -694,8 +694,8 @@
  *	Video4linux interfacing
  */
 
-static int qcam_ioctl(struct inode *inode, struct file *file,
-		      unsigned int cmd, void *arg)
+static int qcam_do_ioctl(struct inode *inode, struct file *file,
+			 unsigned int cmd, void *arg)
 {
 	struct video_device *dev = video_devdata(file);
 	struct qcam_device *qcam=(struct qcam_device *)dev;
@@ -854,6 +854,12 @@
 	return 0;
 }
 
+static int qcam_ioctl(struct inode *inode, struct file *file,
+		     unsigned int cmd, unsigned long arg)
+{
+	return video_usercopy(inode, file, cmd, arg, qcam_do_ioctl);
+}
+
 static int qcam_read(struct file *file, char *buf,
 		     size_t count, loff_t *ppos)
 {
@@ -882,7 +888,7 @@
 	owner:		THIS_MODULE,
 	open:           video_exclusive_open,
 	release:        video_exclusive_release,
-	ioctl:          video_generic_ioctl,
+	ioctl:          qcam_ioctl,
 	read:		qcam_read,
 	llseek:         no_llseek,
 };
@@ -893,7 +899,6 @@
 	type:		VID_TYPE_CAPTURE,
 	hardware:	VID_HARDWARE_QCAM_BW,
 	fops:           &qcam_fops,
-	kernel_ioctl:	qcam_ioctl,
 };
 
 #define MAX_CAMS 4
diff -Nru a/drivers/media/video/c-qcam.c b/drivers/media/video/c-qcam.c
--- a/drivers/media/video/c-qcam.c	Mon Apr  8 10:18:25 2002
+++ b/drivers/media/video/c-qcam.c	Mon Apr  8 10:18:25 2002
@@ -496,8 +496,8 @@
  *	Video4linux interfacing
  */
 
-static int qcam_ioctl(struct inode *inode, struct file *file,
-		      unsigned int cmd, void *arg)
+static int qcam_do_ioctl(struct inode *inode, struct file *file,
+			 unsigned int cmd, void *arg)
 {
 	struct video_device *dev = video_devdata(file);
 	struct qcam_device *qcam=(struct qcam_device *)dev;
@@ -662,6 +662,12 @@
 	return 0;
 }
 
+static int qcam_ioctl(struct inode *inode, struct file *file,
+		     unsigned int cmd, unsigned long arg)
+{
+	return video_usercopy(inode, file, cmd, arg, qcam_do_ioctl);
+}
+
 static int qcam_read(struct file *file, char *buf,
 		     size_t count, loff_t *ppos)
 {
@@ -683,7 +689,7 @@
 	owner:		THIS_MODULE,
 	open:           video_exclusive_open,
 	release:        video_exclusive_release,
-	ioctl:          video_generic_ioctl,
+	ioctl:          qcam_ioctl,
 	read:		qcam_read,
 	llseek:         no_llseek,
 };
@@ -695,7 +701,6 @@
 	type:		VID_TYPE_CAPTURE,
 	hardware:	VID_HARDWARE_QCAM_C,
 	fops:           &qcam_fops,
-	kernel_ioctl:	qcam_ioctl,
 };
 
 /* Initialize the QuickCam driver control structure. */
diff -Nru a/drivers/media/video/cpia.c b/drivers/media/video/cpia.c
--- a/drivers/media/video/cpia.c	Mon Apr  8 10:18:25 2002
+++ b/drivers/media/video/cpia.c	Mon Apr  8 10:18:25 2002
@@ -2572,8 +2572,8 @@
 	return cam->decompressed_frame.count;
 }
 
-static int cpia_ioctl(struct inode *inode, struct file *file,
-		      unsigned int ioctlnr, void *arg)
+static int cpia_do_ioctl(struct inode *inode, struct file *file,
+			 unsigned int ioctlnr, void *arg)
 {
 	struct video_device *dev = file->private_data;
 	struct cam_data *cam = dev->priv;
@@ -2874,6 +2874,12 @@
 	return retval;
 } 
 
+static int cpia_ioctl(struct inode *inode, struct file *file,
+		     unsigned int cmd, unsigned long arg)
+{
+	return video_usercopy(inode, file, cmd, arg, cpia_do_ioctl);
+}
+
 /* FIXME */
 static int cpia_mmap(struct file *file, struct vm_area_struct *vma)
 {
@@ -2933,7 +2939,7 @@
 	release:       	cpia_close,
 	read:		cpia_read,
 	mmap:		cpia_mmap,
-	ioctl:          video_generic_ioctl,
+	ioctl:          cpia_ioctl,
 	llseek:         no_llseek,
 };
 
@@ -2943,7 +2949,6 @@
 	type:		VID_TYPE_CAPTURE,
 	hardware:	VID_HARDWARE_CPIA,      /* FIXME */
 	fops:           &cpia_fops,
-	kernel_ioctl:	cpia_ioctl,
 };
 
 /* initialise cam_data structure  */
diff -Nru a/drivers/media/video/pms.c b/drivers/media/video/pms.c
--- a/drivers/media/video/pms.c	Mon Apr  8 10:18:25 2002
+++ b/drivers/media/video/pms.c	Mon Apr  8 10:18:25 2002
@@ -672,8 +672,8 @@
  *	Video4linux interfacing
  */
 
-static int pms_ioctl(struct inode *inode, struct file *file,
-		     unsigned int cmd, void *arg)
+static int pms_do_ioctl(struct inode *inode, struct file *file,
+			unsigned int cmd, void *arg)
 {
 	struct video_device *dev = video_devdata(file);
 	struct pms_device *pd=(struct pms_device *)dev;
@@ -855,6 +855,12 @@
 	return 0;
 }
 
+static int pms_ioctl(struct inode *inode, struct file *file,
+		     unsigned int cmd, unsigned long arg)
+{
+	return video_usercopy(inode, file, cmd, arg, pms_do_ioctl);
+}
+
 static int pms_read(struct file *file, char *buf,
 		    size_t count, loff_t *ppos)
 {
@@ -872,7 +878,7 @@
 	owner:		THIS_MODULE,
 	open:           video_exclusive_open,
 	release:        video_exclusive_release,
-	ioctl:          video_generic_ioctl,
+	ioctl:          pms_ioctl,
 	read:           pms_read,
 	llseek:         no_llseek,
 };
@@ -884,7 +890,6 @@
 	type:		VID_TYPE_CAPTURE,
 	hardware:	VID_HARDWARE_PMS,
 	fops:           &pms_fops,
-	kernel_ioctl:	pms_ioctl,
 };
 
 struct pms_device pms_device;
diff -Nru a/drivers/media/video/saa5249.c b/drivers/media/video/saa5249.c
--- a/drivers/media/video/saa5249.c	Mon Apr  8 10:18:25 2002
+++ b/drivers/media/video/saa5249.c	Mon Apr  8 10:18:25 2002
@@ -341,9 +341,12 @@
  *	Standard character-device-driver functions
  */
 
-static int do_saa5249_ioctl(struct saa5249_device *t, unsigned int cmd, void *arg) 
+static int do_saa5249_ioctl(struct inode *inode, struct file *file,
+			    unsigned int cmd, void *arg)
 {
 	static int virtual_mode = FALSE;
+	struct video_device *vd = video_devdata(file);
+	struct saa5249_device *t=vd->priv;
 
 	switch(cmd) 
 	{
@@ -591,16 +594,15 @@
  */
  
 static int saa5249_ioctl(struct inode *inode, struct file *file,
-			 unsigned int cmd, void *arg) 
+			 unsigned int cmd, unsigned long arg) 
 {
 	struct video_device *vd = video_devdata(file);
 	struct saa5249_device *t=vd->priv;
 	int err;
 	
 	down(&t->lock);
-	err = do_saa5249_ioctl(t, cmd, arg);
+	err = video_usercopy(inode,file,cmd,arg,do_saa5249_ioctl);
 	up(&t->lock);
-
 	return err;
 }
 
@@ -679,7 +681,7 @@
 	owner:		THIS_MODULE,
 	open:		saa5249_open,
 	release:       	saa5249_release,
-	ioctl:          video_generic_ioctl,
+	ioctl:          saa5249_ioctl,
 	llseek:         no_llseek,
 };
 
@@ -690,7 +692,6 @@
 	type:		VID_TYPE_TELETEXT,	/*| VID_TYPE_TUNER ?? */
 	hardware:	VID_HARDWARE_SAA5249,
 	fops:           &saa_fops,
-	kernel_ioctl:  	saa5249_ioctl,
 };
 
 MODULE_LICENSE("GPL");
diff -Nru a/drivers/media/video/w9966.c b/drivers/media/video/w9966.c
--- a/drivers/media/video/w9966.c	Mon Apr  8 10:18:25 2002
+++ b/drivers/media/video/w9966.c	Mon Apr  8 10:18:25 2002
@@ -174,7 +174,7 @@
 static int w9966_i2c_rbyte(struct w9966_dev* cam);
 
 static int w9966_v4l_ioctl(struct inode *inode, struct file *file,
-			   unsigned int cmd, void *arg);
+			   unsigned int cmd, unsigned long arg);
 static int w9966_v4l_read(struct file *file, char *buf,
 			  size_t count, loff_t *ppos);
 
@@ -182,7 +182,7 @@
 	owner:		THIS_MODULE,
 	open:           video_exclusive_open,
 	release:        video_exclusive_release,
-	ioctl:          video_generic_ioctl,
+	ioctl:          w9966_v4l_ioctl,
 	read:           w9966_v4l_read,
 	llseek:         no_llseek,
 };
@@ -192,7 +192,6 @@
 	type:           VID_TYPE_CAPTURE | VID_TYPE_SCALES,
 	hardware:       VID_HARDWARE_W9966,
 	fops:           &w9966_fops,
-	kernel_ioctl:   w9966_v4l_ioctl,
 };
 
 /*
@@ -700,8 +699,8 @@
  *	Video4linux interfacing
  */
 
-static int w9966_v4l_ioctl(struct inode *inode, struct file *file,
-			   unsigned int cmd, void *arg)
+static int w9966_v4l_do_ioctl(struct inode *inode, struct file *file,
+			      unsigned int cmd, void *arg)
 {
 	struct video_device *vdev = video_devdata(file);
 	struct w9966_dev *cam = (struct w9966_dev*)vdev->priv;
@@ -851,6 +850,12 @@
 		return -ENOIOCTLCMD;
 	}
 	return 0;
+}
+
+static int w9966_v4l_ioctl(struct inode *inode, struct file *file,
+			   unsigned int cmd, unsigned long arg)
+{
+	return video_usercopy(inode, file, cmd, arg, w9966_v4l_do_ioctl);
 }
 
 // Capture data
======================================================================
This BitKeeper patch contains the following changesets:
1.586
## Wrapped with gzip_uu ##


begin 664 bkpatch4871
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
K2-QY#Y>XS`[Q+A(;K7R"Z!I5_U8379OH9G$W&2<H=+`DP;^(/U6IQB,`````
`
end
