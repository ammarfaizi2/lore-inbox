Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262001AbVHCDki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbVHCDki (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 23:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262010AbVHCDkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 23:40:35 -0400
Received: from smtp1.brturbo.com.br ([200.199.201.163]:14823 "EHLO
	smtp1.brturbo.com.br") by vger.kernel.org with ESMTP
	id S262001AbVHCDkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 23:40:33 -0400
Subject: BTTV - experimental no_overlay patch
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
To: Andrew Burgess <aab@cichlid.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>
Content-Type: multipart/mixed; boundary="=-Hr1Honbztvz22+N11JTx"
Date: Wed, 03 Aug 2005 00:40:23 -0300
Message-Id: <1123040424.5607.46.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3-5mdk 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Hr1Honbztvz22+N11JTx
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Bodo/Andrew,

	This small patch will allow no_overlay flag to disable BTTV driver to
report OVERLAY capabilities. It should fix your troubles by enabling
no_overlay=1 when inserting bttv module.

	This patch is against our CVS tree, but should apply with some hunk on
2.6.13-rc4 or 2.6.13-rc5.

	I'll generate a new one at morning, against 2.6.13-rc5 hopefully to
have it applied at 2.6.13, since it fixes an OOPS.

-----

This patch does implement no_overlay=1 insmod option support, so,
computers with PCI2PCI transfer problems should not feel more OOPS when
using bttv cards, by disabling overlay.


Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>


--=-Hr1Honbztvz22+N11JTx
Content-Disposition: attachment; filename=v4l_bttv_no_overlay.diff
Content-Type: text/x-patch; name=v4l_bttv_no_overlay.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: bttv-driver.c
===================================================================
RCS file: /cvs/video4linux/video4linux/bttv-driver.c,v
retrieving revision 1.47
retrieving revision 1.48
diff -u -p -r1.47 -r1.48
--- bttv-driver.c	30 Jul 2005 19:47:02 -0000	1.47
+++ bttv-driver.c	3 Aug 2005 03:23:41 -0000	1.48
@@ -1,5 +1,5 @@
 /*
-    $Id: bttv-driver.c,v 1.47 2005/07/30 19:47:02 mkrufky Exp $
+    $Id: bttv-driver.c,v 1.48 2005/08/03 03:23:41 mchehab Exp $
 
     bttv - Bt848 frame grabber driver
 
@@ -80,6 +80,7 @@ static unsigned int irq_iswitch = 0;
 static unsigned int uv_ratio    = 50;
 static unsigned int full_luma_range = 0;
 static unsigned int coring      = 0;
+extern unsigned int no_overlay;
 
 /* API features (turn on/off stuff for testing) */
 static unsigned int v4l2        = 1;
@@ -2170,6 +2171,9 @@ static int bttv_s_fmt(struct bttv_fh *fh
 		return 0;
 	}
 	case V4L2_BUF_TYPE_VIDEO_OVERLAY:
+		printk ("V4L2_BUF_TYPE_VIDEO_OVERLAY called. no_overlay=%d\n",no_overlay);
+		if (no_overlay)
+			return -EINVAL;
 		return setup_window(fh, btv, &f->fmt.win, 1);
 	case V4L2_BUF_TYPE_VBI_CAPTURE:
 		retval = bttv_switch_type(fh,f->type);
@@ -2243,9 +2247,11 @@ static int bttv_do_ioctl(struct inode *i
 			/* others */
 			cap->type = VID_TYPE_CAPTURE|
 				VID_TYPE_TUNER|
-				VID_TYPE_OVERLAY|
 				VID_TYPE_CLIPPING|
 				VID_TYPE_SCALES;
+			if (!no_overlay)
+				cap->type |= VID_TYPE_OVERLAY;
+
 			cap->maxwidth  = bttv_tvnorms[btv->tvnorm].swidth;
 			cap->maxheight = bttv_tvnorms[btv->tvnorm].sheight;
 			cap->minwidth  = 48;
@@ -2321,6 +2327,10 @@ static int bttv_do_ioctl(struct inode *i
 		struct video_window *win = arg;
 		struct v4l2_window w2;
 
+		printk ("VIDIOCSWIN called. no_overlay=%d\n",no_overlay);
+		if (no_overlay)
+			return -EINVAL;
+
 		w2.field = V4L2_FIELD_ANY;
 		w2.w.left    = win->x;
 		w2.w.top     = win->y;
@@ -2596,10 +2606,12 @@ static int bttv_do_ioctl(struct inode *i
 		cap->version = BTTV_VERSION_CODE;
 		cap->capabilities =
 			V4L2_CAP_VIDEO_CAPTURE |
-			V4L2_CAP_VIDEO_OVERLAY |
 			V4L2_CAP_VBI_CAPTURE |
 			V4L2_CAP_READWRITE |
 			V4L2_CAP_STREAMING;
+		if (!no_overlay)
+			cap->capabilities |= V4L2_CAP_VIDEO_OVERLAY;
+
 		if (bttv_tvcards[btv->c.type].tuner != UNSET &&
 		    bttv_tvcards[btv->c.type].tuner != TUNER_ABSENT)
 			cap->capabilities |= V4L2_CAP_TUNER;
@@ -3095,7 +3107,7 @@ static struct file_operations bttv_fops 
 static struct video_device bttv_video_template =
 {
 	.name     = "UNSET",
-	.type     = VID_TYPE_CAPTURE|VID_TYPE_TUNER|VID_TYPE_OVERLAY|
+	.type     = VID_TYPE_CAPTURE|VID_TYPE_TUNER|
 	            VID_TYPE_CLIPPING|VID_TYPE_SCALES,
 	.hardware = VID_HARDWARE_BT848,
 	.fops     = &bttv_fops,
@@ -3779,6 +3791,9 @@ static void bttv_unregister_video(struct
 /* register video4linux devices */
 static int __devinit bttv_register_video(struct bttv *btv)
 {
+	if (!no_overlay)
+		bttv_video_template.type |= VID_TYPE_OVERLAY;
+
 	/* video */
 	btv->video_dev = vdev_init(btv, &bttv_video_template, "video");
         if (NULL == btv->video_dev)

--=-Hr1Honbztvz22+N11JTx--

