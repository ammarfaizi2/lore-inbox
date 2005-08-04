Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261789AbVHDDh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261789AbVHDDh7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 23:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261765AbVHDDhb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 23:37:31 -0400
Received: from smtp4.brturbo.com.br ([200.199.201.180]:23786 "EHLO
	smtp4.brturbo.com.br") by vger.kernel.org with ESMTP
	id S261759AbVHDDfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 23:35:04 -0400
Subject: [PATCH for 2.6.13-rc5]  V4L: OOPS fix for BTTV on bad behaviored
	PCI chipsets
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
To: Andrew Morton <akpm@osdl.org>
Cc: "greg@kroah.com" <greg@kroah.com>, Bodo Eggbert <7eggert@gmx.de>,
       Linux and Kernel Video <video4linux-list@redhat.com>,
       LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-Nj/1EYZZ5pa+ND+nGjmn"
Date: Thu, 04 Aug 2005 00:34:53 -0300
Message-Id: <1123126493.8274.51.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3-5mdk 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Nj/1EYZZ5pa+ND+nGjmn
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-Nj/1EYZZ5pa+ND+nGjmn
Content-Disposition: attachment; filename=v4l_bttv_no_overlay_linus.patch
Content-Type: text/x-patch; name=v4l_bttv_no_overlay_linus.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

no_overlay bttv parameter implemented to fix OOPS on some PCI chipsets 
(like some VIA) with these behaviors:

1) If pci_quicks does identify the chip as having troubles to 
   handle PCI2PCI transfers, no_overlay defaults to 1. The user may force 
   it to 0, to reenable (not recommended).
2) For newer chipsets not blacklisted, no_overlay=1 is provided as a 
   workaround until PCI chipset included on /drivers/pci/quirks.c

Thanks to  Bodo Eggert <7eggert@gmx.de>

Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

 linux/Documentation/video4linux/bttv/Insmod-options |    3 +
 linux/drivers/media/video/bttv-cards.c              |   10 ++--
 linux/drivers/media/video/bttv-driver.c             |   28 ++++++++++--
 3 files changed, 33 insertions(+), 8 deletions(-)

diff -u linux-2.6.13/drivers/media/video/bttv-driver.c linux/drivers/media/video/bttv-driver.c
--- linux-2.6.13/drivers/media/video/bttv-driver.c	2005-08-03 18:25:55.000000000 -0300
+++ linux/drivers/media/video/bttv-driver.c	2005-08-03 22:19:44.000000000 -0300
@@ -1,5 +1,5 @@
 /*
-    $Id: bttv-driver.c,v 1.45 2005/07/20 19:43:24 mkrufky Exp $
+    $Id: bttv-driver.c,v 1.52 2005/08/04 00:55:16 mchehab Exp $
 
     bttv - Bt848 frame grabber driver
 
@@ -80,6 +80,7 @@
 static unsigned int uv_ratio    = 50;
 static unsigned int full_luma_range = 0;
 static unsigned int coring      = 0;
+extern int no_overlay;
 
 /* API features (turn on/off stuff for testing) */
 static unsigned int v4l2        = 1;
@@ -2151,6 +2152,10 @@
 		return 0;
 	}
 	case V4L2_BUF_TYPE_VIDEO_OVERLAY:
+		if (no_overlay > 0) {
+			printk ("V4L2_BUF_TYPE_VIDEO_OVERLAY: no_overlay\n");
+			return -EINVAL;
+		}
 		return setup_window(fh, btv, &f->fmt.win, 1);
 	case V4L2_BUF_TYPE_VBI_CAPTURE:
 		retval = bttv_switch_type(fh,f->type);
@@ -2224,9 +2229,11 @@
 			/* others */
 			cap->type = VID_TYPE_CAPTURE|
 				VID_TYPE_TUNER|
-				VID_TYPE_OVERLAY|
 				VID_TYPE_CLIPPING|
 				VID_TYPE_SCALES;
+			if (no_overlay <= 0)
+				cap->type |= VID_TYPE_OVERLAY;
+
 			cap->maxwidth  = bttv_tvnorms[btv->tvnorm].swidth;
 			cap->maxheight = bttv_tvnorms[btv->tvnorm].sheight;
 			cap->minwidth  = 48;
@@ -2302,6 +2309,11 @@
 		struct video_window *win = arg;
 		struct v4l2_window w2;
 
+		if (no_overlay > 0) {
+			printk ("VIDIOCSWIN: no_overlay\n");
+			return -EINVAL;
+		}
+
 		w2.field = V4L2_FIELD_ANY;
 		w2.w.left    = win->x;
 		w2.w.top     = win->y;
@@ -2577,10 +2589,12 @@
 		cap->version = BTTV_VERSION_CODE;
 		cap->capabilities =
 			V4L2_CAP_VIDEO_CAPTURE |
-			V4L2_CAP_VIDEO_OVERLAY |
 			V4L2_CAP_VBI_CAPTURE |
 			V4L2_CAP_READWRITE |
 			V4L2_CAP_STREAMING;
+		if (no_overlay <= 0)
+			cap->capabilities |= V4L2_CAP_VIDEO_OVERLAY;
+
 		if (bttv_tvcards[btv->c.type].tuner != UNSET &&
 		    bttv_tvcards[btv->c.type].tuner != TUNER_ABSENT)
 			cap->capabilities |= V4L2_CAP_TUNER;
@@ -3076,7 +3090,7 @@
 static struct video_device bttv_video_template =
 {
 	.name     = "UNSET",
-	.type     = VID_TYPE_CAPTURE|VID_TYPE_TUNER|VID_TYPE_OVERLAY|
+	.type     = VID_TYPE_CAPTURE|VID_TYPE_TUNER|
 	            VID_TYPE_CLIPPING|VID_TYPE_SCALES,
 	.hardware = VID_HARDWARE_BT848,
 	.fops     = &bttv_fops,
@@ -3756,6 +3770,12 @@
 /* register video4linux devices */
 static int __devinit bttv_register_video(struct bttv *btv)
 {
+	if (no_overlay <= 0) {
+		bttv_video_template.type |= VID_TYPE_OVERLAY;
+	} else {
+		printk("bttv: Overlay support disabled.\n");
+	}
+
 	/* video */
 	btv->video_dev = vdev_init(btv, &bttv_video_template, "video");
         if (NULL == btv->video_dev)
diff -u linux-2.6.13/drivers/media/video/bttv-cards.c linux/drivers/media/video/bttv-cards.c
--- linux-2.6.13/drivers/media/video/bttv-cards.c	2005-08-03 18:25:55.000000000 -0300
+++ linux/drivers/media/video/bttv-cards.c	2005-08-03 22:19:44.000000000 -0300
@@ -95,7 +95,7 @@
 static unsigned int triton1=0;
 static unsigned int vsfx=0;
 static unsigned int latency = UNSET;
-static unsigned int no_overlay=-1;
+int no_overlay=-1;
 
 static unsigned int card[BTTV_MAX]   = { [ 0 ... (BTTV_MAX-1) ] = UNSET };
 static unsigned int pll[BTTV_MAX]    = { [ 0 ... (BTTV_MAX-1) ] = UNSET };
@@ -4296,9 +4475,11 @@
 		printk(KERN_INFO "bttv: Host bridge needs VSFX enabled.\n");
 	if (pcipci_fail) {
 		printk(KERN_WARNING "bttv: BT848 and your chipset may not work together.\n");
-		if (UNSET == no_overlay) {
-			printk(KERN_WARNING "bttv: going to disable overlay.\n");
+		if (!no_overlay) {
+			printk(KERN_WARNING "bttv: overlay will be disabled.\n");
 			no_overlay = 1;
+		} else {
+			printk(KERN_WARNING "bttv: overlay forced. Use this option at your own risk.\n");
 		}
 	}
 	if (UNSET != latency)

diff -u linux-2.6.13/Documentation/video4linux/bttv/Insmod-options linux/Documentation/video4linux/bttv/Insmod-options
--- linux-2.6.13/Documentation/video4linux/bttv/Insmod-options	2005-06-17 16:48:29.000000000 -0300
+++ linux/Documentation/video4linux/bttv/Insmod-options	2005-08-03 22:26:37.000000000 -0300
@@ -44,6 +44,9 @@
 				push used by bttv.  bttv will disable overlay
 				by default on this hardware to avoid crashes.
 				With this insmod option you can override this.
+		no_overlay=1	Disable overlay. It should be used by broken
+				hardware that doesn't support PCI2PCI direct
+				transfers.
 		automute=0/1	Automatically mutes the sound if there is
 				no TV signal, on by default.  You might try
 				to disable this if you have bad input signal

--=-Nj/1EYZZ5pa+ND+nGjmn--

