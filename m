Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261440AbUL2WwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbUL2WwA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 17:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbUL2WvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 17:51:21 -0500
Received: from smtp16.wxs.nl ([195.121.6.39]:6792 "EHLO smtp16.wxs.nl")
	by vger.kernel.org with ESMTP id S261439AbUL2WtZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 17:49:25 -0500
Date: Wed, 29 Dec 2004 23:49:16 +0100
From: "Ronald S. Bultje" <rbultje@ronald.bitfreak.net>
Subject: [PATCH 3/3] 2.6.10 zr36067 driver - reduce stack size usage
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, mjpeg-developer@lists.sf.net,
       "Randy.Dunlap" <rddunlap@osdl.org>
Message-id: <1104360446.25472.87.camel@tux.lan>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2)
Content-type: multipart/mixed; boundary="Boundary_(ID_ylp2WPx9RRuAedxM0UNQfQ)"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary_(ID_ylp2WPx9RRuAedxM0UNQfQ)
Content-type: text/plain
Content-transfer-encoding: 7BIT

Hi Andrew/Linus,

>From original message (by Randy Dunlap):

"Reduce local variable (large struct) stack usage in zoran_do_ioctl()
from 1028 bytes to 324 bytes (on x86-32) by declaring & using only 1
"struct zoran_jpg_settings" instead of 5 instances of it. Reduced from 5
* 180 bytes to 1 * 180 bytes, plus other locals in each case."

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>
Signed-off-by: Ronald S. Bultje <rbultje@ronald.bitfreak.net>

Regards,

Ronald
-- 
Ronald S. Bultje <rbultje@ronald.bitfreak.net>

--Boundary_(ID_ylp2WPx9RRuAedxM0UNQfQ)
Content-type: text/x-patch; name=zoran-stacksize.diff; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=zoran-stacksize.diff

Index: linux-2.6.10/drivers/media/video/zoran_driver.c
===================================================================
--- linux-2.6.10.orig/drivers/media/video/zoran_driver.c	2004-12-29 21:56:27.714436423 +0100
+++ linux-2.6.10/drivers/media/video/zoran_driver.c	2004-12-29 21:57:20.784771392 +0100
@@ -2014,6 +2014,8 @@
 {
 	struct zoran_fh *fh = file->private_data;
 	struct zoran *zr = fh->zr;
+	/* CAREFUL: used in multiple places here */
+	struct zoran_jpg_settings settings;
 
 	/* we might have older buffers lying around... We don't want
 	 * to wait, but we do want to try cleaning them up ASAP. So
@@ -2462,7 +2464,6 @@
 	case BUZIOC_S_PARAMS:
 	{
 		struct zoran_params *bparams = arg;
-		struct zoran_jpg_settings settings;
 		int res = 0;
 
 		dprintk(3, KERN_DEBUG "%s: BUZIOC_S_PARAMS\n", ZR_DEVNAME(zr));
@@ -2919,8 +2920,6 @@
 			}
 
 			if (fmt->fmt.pix.pixelformat == V4L2_PIX_FMT_MJPEG) {
-				struct zoran_jpg_settings settings;
-
 				down(&zr->resource_lock);
 
 				settings = fh->jpg_settings;
@@ -3983,7 +3982,8 @@
 	{
 		struct v4l2_crop *crop = arg;
 		int res = 0;
-		struct zoran_jpg_settings settings = fh->jpg_settings;
+
+		settings = fh->jpg_settings;
 
 		dprintk(3,
 			KERN_ERR
@@ -4065,9 +4065,10 @@
 	case VIDIOC_S_JPEGCOMP:
 	{
 		struct v4l2_jpegcompression *params = arg;
-		struct zoran_jpg_settings settings = fh->jpg_settings;
 		int res = 0;
 
+		settings = fh->jpg_settings;
+
 		dprintk(3,
 			KERN_DEBUG
 			"%s: VIDIOC_S_JPEGCOMP - quality=%d, APPN=%d, APP_len=%d, COM_len=%d\n",
@@ -4151,8 +4152,7 @@
 			down(&zr->resource_lock);
 
 			if (fmt->fmt.pix.pixelformat == V4L2_PIX_FMT_MJPEG) {
-				struct zoran_jpg_settings settings =
-				    fh->jpg_settings;
+				settings = fh->jpg_settings;
 
 				/* we actually need to set 'real' parameters now */
 				if ((fmt->fmt.pix.height * 2) >

--Boundary_(ID_ylp2WPx9RRuAedxM0UNQfQ)--
