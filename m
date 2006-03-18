Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751648AbWCRAEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648AbWCRAEk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 19:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751757AbWCRAEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 19:04:40 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:42463 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751648AbWCRAEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 19:04:39 -0500
Subject: Re: [v4l-dvb-maintainer] Re: [PATCH 05/21] Added no_overlay option
	and quirks to saa7134
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060317232457.GB9717@stusta.de>
References: <20060317205359.PS65198900000@infradead.org>
	 <20060317205433.PS91497800005@infradead.org>
	 <20060317232457.GB9717@stusta.de>
Content-Type: multipart/mixed; boundary="=-UfNMlCx7W9ueVQ2Nc6O/"
Date: Fri, 17 Mar 2006 21:04:22 -0300
Message-Id: <1142640262.4630.20.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-UfNMlCx7W9ueVQ2Nc6O/
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Adrian,

Argh! I just forgot to add the important part of the patch! I'm
enclosing it. Please, test. I'll add to both devel and master branch of
v4l-dvb.git tree.

Cheers,
Mauro.

Em Sáb, 2006-03-18 às 00:24 +0100, Adrian Bunk escreveu:
> On Fri, Mar 17, 2006 at 05:54:34PM -0300, mchehab@infradead.org wrote:
> > 
> > From: Mauro Carvalho Chehab <mchehab@infradead.org>
> > Date: 1142020010 \-0300
> > 
> > Some chipsets have several problems when pci to pci transfers are activated
> > on overlay mode. the option no_overlay allows disabling such feature of
> > the driver, in favor of keeping the system stable.
> > The default is to use pcipci_fail flag defined on drivers/pci/quirks.c.
> > It also allows the user to override it by forcing disable overlay or forcing
> > enable. Forcing enable may generate PCI transfer corruption, including disk
> > mass corruption, so should be used with care.
> > Added a text description to this option and make messages looks the same at
> > both bttv and saa7134 drivers.
> >...
> 
> As far as I can see, the the no_overlay option in the saa7134 driver 
> doesn't change anything (except for a printk).
> 
> cu
> Adrian
> 
Cheers, 
Mauro.

--=-UfNMlCx7W9ueVQ2Nc6O/
Content-Disposition: attachment; filename=no_overlay_fix.patch
Content-Type: text/x-patch; name=no_overlay_fix.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff-tree fc33159b01f433f26a72c871ce76d85a45ec9c16 (from 59002b58a7773888479ad6704a96c2a645b83dc6)
Author: Mauro Carvalho Chehab <mchehab@infradead.org>
Date:   Fri Mar 17 20:54:32 2006 -0300

    V4L/DVB (3545): Fixed no_overlay option and quirks on saa7134 driver
    
    Some chipsets have several problems when pci to pci transfers are activated
    on overlay mode. the option no_overlay allows disabling such feature of
    the driver, in favor of keeping the system stable.
    The default is to use pcipci_fail flag defined on drivers/pci/quirks.c.
    It also allows the user to override it by forcing disable overlay or forcing
    enable. Forcing enable may generate PCI transfer corruption, including disk
    mass corruption, so should be used with care.
    Added a text description to this option and make messages looks the same at
    both bttv and saa7134 drivers.
    
    Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>

diff --git a/drivers/media/video/saa7134/saa7134-core.c b/drivers/media/video/saa7134/saa7134-core.c
index 3203a80..15405d1 100644
--- a/drivers/media/video/saa7134/saa7134-core.c
+++ b/drivers/media/video/saa7134/saa7134-core.c
@@ -66,8 +66,8 @@ static unsigned int latency = UNSET;
 module_param(latency, int, 0444);
 MODULE_PARM_DESC(latency,"pci latency timer");
 
-static int no_overlay=-1;
-module_param(no_overlay, int, 0444);
+int saa7134_no_overlay=-1;
+module_param_named(no_overlay, saa7134_no_overlay, int, 0444);
 MODULE_PARM_DESC(no_overlay,"allow override overlay default (0 disables, 1 enables)"
 		" [some VIA/SIS chipsets are known to have problem with overlay]");
 
@@ -843,11 +843,11 @@ static int __devinit saa7134_initdev(str
 			printk(KERN_INFO "%s: quirk: this driver and your "
 					"chipset may not work together"
 					" in overlay mode.\n",dev->name);
-			if (!no_overlay) {
+			if (!saa7134_no_overlay) {
 				printk(KERN_INFO "%s: quirk: overlay "
 						"mode will be disabled.\n",
 						dev->name);
-				no_overlay = 1;
+				saa7134_no_overlay = 1;
 			} else {
 				printk(KERN_INFO "%s: quirk: overlay "
 						"mode will be forced. Use this"
@@ -957,6 +957,11 @@ static int __devinit saa7134_initdev(str
 	v4l2_prio_init(&dev->prio);
 
 	/* register v4l devices */
+	if (saa7134_no_overlay <= 0) {
+		saa7134_video_template.type |= VID_TYPE_OVERLAY;
+	} else {
+		printk("bttv: Overlay support disabled.\n");
+	}
 	dev->video_dev = vdev_init(dev,&saa7134_video_template,"video");
 	err = video_register_device(dev->video_dev,VFL_TYPE_GRABBER,
 				    video_nr[dev->nr]);
diff --git a/drivers/media/video/saa7134/saa7134-video.c b/drivers/media/video/saa7134/saa7134-video.c
index 2da382d..aeef80f 100644
--- a/drivers/media/video/saa7134/saa7134-video.c
+++ b/drivers/media/video/saa7134/saa7134-video.c
@@ -1461,6 +1461,10 @@ static int saa7134_g_fmt(struct saa7134_
 			f->fmt.pix.height * f->fmt.pix.bytesperline;
 		return 0;
 	case V4L2_BUF_TYPE_VIDEO_OVERLAY:
+		if (saa7134_no_overlay > 0) {
+			printk ("V4L2_BUF_TYPE_VIDEO_OVERLAY: no_overlay\n");
+			return -EINVAL;
+		}
 		f->fmt.win = fh->win;
 		return 0;
 	case V4L2_BUF_TYPE_VBI_CAPTURE:
@@ -1525,6 +1529,10 @@ static int saa7134_try_fmt(struct saa713
 		return 0;
 	}
 	case V4L2_BUF_TYPE_VIDEO_OVERLAY:
+		if (saa7134_no_overlay > 0) {
+			printk ("V4L2_BUF_TYPE_VIDEO_OVERLAY: no_overlay\n");
+			return -EINVAL;
+		}
 		err = verify_preview(dev,&f->fmt.win);
 		if (0 != err)
 			return err;
@@ -1555,6 +1563,10 @@ static int saa7134_s_fmt(struct saa7134_
 		fh->cap.field = f->fmt.pix.field;
 		return 0;
 	case V4L2_BUF_TYPE_VIDEO_OVERLAY:
+		if (saa7134_no_overlay > 0) {
+			printk ("V4L2_BUF_TYPE_VIDEO_OVERLAY: no_overlay\n");
+			return -EINVAL;
+		}
 		err = verify_preview(dev,&f->fmt.win);
 		if (0 != err)
 			return err;
@@ -1714,11 +1726,13 @@ static int video_do_ioctl(struct inode *
 		cap->version = SAA7134_VERSION_CODE;
 		cap->capabilities =
 			V4L2_CAP_VIDEO_CAPTURE |
-			V4L2_CAP_VIDEO_OVERLAY |
 			V4L2_CAP_VBI_CAPTURE |
 			V4L2_CAP_READWRITE |
 			V4L2_CAP_STREAMING |
 			V4L2_CAP_TUNER;
+		if (saa7134_no_overlay <= 0) {
+			cap->capabilities |= V4L2_CAP_VIDEO_OVERLAY;
+		}
 
 		if ((tuner_type == TUNER_ABSENT) || (tuner_type == UNSET))
 			cap->capabilities &= ~V4L2_CAP_TUNER;
@@ -1969,6 +1983,10 @@ static int video_do_ioctl(struct inode *
 		switch (type) {
 		case V4L2_BUF_TYPE_VIDEO_CAPTURE:
 		case V4L2_BUF_TYPE_VIDEO_OVERLAY:
+			if (saa7134_no_overlay > 0) {
+				printk ("V4L2_BUF_TYPE_VIDEO_OVERLAY: no_overlay\n");
+				return -EINVAL;
+			}
 			if (index >= FORMATS)
 				return -EINVAL;
 			if (f->type == V4L2_BUF_TYPE_VIDEO_OVERLAY &&
@@ -2029,6 +2047,11 @@ static int video_do_ioctl(struct inode *
 		int *on = arg;
 
 		if (*on) {
+			if (saa7134_no_overlay > 0) {
+				printk ("no_overlay\n");
+				return -EINVAL;
+			}
+
 			if (!res_get(dev,fh,RESOURCE_OVERLAY))
 				return -EBUSY;
 			spin_lock_irqsave(&dev->slock,flags);
@@ -2280,7 +2303,7 @@ static struct file_operations radio_fops
 struct video_device saa7134_video_template =
 {
 	.name          = "saa7134-video",
-	.type          = VID_TYPE_CAPTURE|VID_TYPE_TUNER|VID_TYPE_OVERLAY|
+	.type          = VID_TYPE_CAPTURE|VID_TYPE_TUNER|
 			 VID_TYPE_CLIPPING|VID_TYPE_SCALES,
 	.hardware      = 0,
 	.fops          = &video_fops,
diff --git a/drivers/media/video/saa7134/saa7134.h b/drivers/media/video/saa7134/saa7134.h
index c159428..28e6f0a 100644
--- a/drivers/media/video/saa7134/saa7134.h
+++ b/drivers/media/video/saa7134/saa7134.h
@@ -557,6 +557,7 @@ struct saa7134_dev {
 /* saa7134-core.c                                              */
 
 extern struct list_head  saa7134_devlist;
+extern int saa7134_no_overlay;
 
 void saa7134_track_gpio(struct saa7134_dev *dev, char *msg);
 

--=-UfNMlCx7W9ueVQ2Nc6O/--

