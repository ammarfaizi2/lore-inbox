Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262899AbUBZRhX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 12:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262900AbUBZRhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 12:37:23 -0500
Received: from mail.med.cornell.edu ([140.251.3.3]:59015 "EHLO
	mail.med.cornell.edu") by vger.kernel.org with ESMTP
	id S262899AbUBZRhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 12:37:08 -0500
Subject: [PATCH] zr36067 driver update
From: "Ronald S. Bultje" <rbultje@ronald.bitfreak.net>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-NZhtgcseAj1nLycrSzaO"
Message-Id: <1077795470.28777.24.camel@shrek.bitfreak.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 26 Feb 2004 12:37:50 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-NZhtgcseAj1nLycrSzaO
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Andrew,

Attached patch fixes the zoran driver (zr36067) for the fact that we did
not handle bitrate-conversion at all in the zr36050 MJPEG codec (on DC30
cards), with the result being that at high-resolution, we'd overload the
PCI bus and drop half of our video capture data into /dev/null'ishness.

Also, could you please change my email address in MAINTAINERS? The old
one is no longer valid (it bounces).

Patch (both together) attached.

Thanks,
Ronald

-- 
Ronald Bultje <rbultje@ronald.bitfreak.net>
Linux Video/Multimedia developer

--=-NZhtgcseAj1nLycrSzaO
Content-Disposition: attachment; filename=zr36067-36050bitrate.diff
Content-Type: text/plain; name=zr36067-36050bitrate.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.3/drivers/media/video/zr36050-old.c	2004-02-24 02:57:26.000000000 -0500
+++ linux-2.6.3/drivers/media/video/zr36050.c	2004-02-24 03:12:37.000000000 -0500
@@ -24,7 +24,7 @@
  * ------------------------------------------------------------------------
  */
 
-#define ZR050_VERSION "v0.7"
+#define ZR050_VERSION "v0.7.1"
 
 #include <linux/version.h>
 #include <linux/module.h>
@@ -479,7 +479,7 @@
 		zr36050_write(ptr, ZR050_INT_REQ_1, 3);	// low 2 bits always 1
 
 		/* volume control settings */
-		zr36050_write(ptr, ZR050_MBCV, ptr->max_block_vol >> 1);
+		/*zr36050_write(ptr, ZR050_MBCV, ptr->max_block_vol);*/
 		zr36050_write(ptr, ZR050_SF_HI, ptr->scalefact >> 8);
 		zr36050_write(ptr, ZR050_SF_LO, ptr->scalefact & 0xff);
 
@@ -521,13 +521,13 @@
 		/* setup misc. data for compression (target code sizes) */
 
 		/* size of compressed code to reach without header data */
-		sum = ptr->total_code_vol - sum;
+		sum = ptr->real_code_vol - sum;
 		bitcnt = sum << 3;	/* need the size in bits */
 
 		tmp = bitcnt >> 16;
 		dprintk(3,
 			"%s: code: csize=%d, tot=%d, bit=%ld, highbits=%ld\n",
-			ptr->name, sum, ptr->total_code_vol, bitcnt, tmp);
+			ptr->name, sum, ptr->real_code_vol, bitcnt, tmp);
 		zr36050_write(ptr, ZR050_TCV_NET_HI, tmp >> 8);
 		zr36050_write(ptr, ZR050_TCV_NET_MH, tmp & 0xff);
 		tmp = bitcnt & 0xffff;
@@ -629,17 +629,37 @@
 		   struct vfe_polarity *pol)
 {
 	struct zr36050 *ptr = (struct zr36050 *) codec->data;
+	int size;
 
-	dprintk(2, "%s: set_video %d.%d, %d/%d-%dx%d (0x%x) call\n",
+	dprintk(2, "%s: set_video %d.%d, %d/%d-%dx%d (0x%x) q%d call\n",
 		ptr->name, norm->HStart, norm->VStart,
 		cap->x, cap->y, cap->width, cap->height,
-		cap->decimation);
+		cap->decimation, cap->quality);
 	/* if () return -EINVAL;
 	 * trust the master driver that it knows what it does - so
 	 * we allow invalid startx/y and norm for now ... */
 	ptr->width = cap->width / (cap->decimation & 0xff);
 	ptr->height = cap->height / ((cap->decimation >> 8) & 0xff);
 
+	/* (KM) JPEG quality */
+	size = ptr->width * ptr->height;
+	size *= 16; /* size in bits */
+	/* apply quality setting */
+	size = size * cap->quality / 200;
+
+	/* Minimum: 1kb */
+	if (size < 8192)
+		size = 8192;
+	/* Maximum: 7/8 of code buffer */
+	if (size > ptr->total_code_vol * 7)
+		size = ptr->total_code_vol * 7;
+
+	ptr->real_code_vol = size >> 3; /* in bytes */        
+        
+	/* Set max_block_vol here (previously in zr36050_init, moved
+	 * here for consistency with zr36060 code */
+	zr36050_write(ptr, ZR050_MBCV, ptr->max_block_vol);
+
 	return 0;
 }
 
@@ -697,6 +717,9 @@
 		if (size != sizeof(int))
 			return -EFAULT;
 		ptr->total_code_vol = *ival;
+		/* (Kieran Morrissey)
+		 * code copied from zr36060.c to ensure proper bitrate */
+		ptr->real_code_vol = (ptr->total_code_vol * 6) >> 3;
 		break;
 
 	case CODEC_G_JPEG_SCALE:	/* get scaling factor */
--- linux-2.6.3/drivers/media/video/zr36050-old.h	2004-02-24 02:57:30.000000000 -0500
+++ linux-2.6.3/drivers/media/video/zr36050.h	2004-02-24 03:09:21.000000000 -0500
@@ -44,6 +44,7 @@
 	__u16 bitrate_ctrl;
 
 	__u32 total_code_vol;
+	__u32 real_code_vol;
 	__u16 max_block_vol;
 
 	__u8 h_samp_ratio[8];
--- linux-2.6.3/MAINTAINERS-old	2004-02-24 02:56:49.000000000 -0500
+++ linux-2.6.3/MAINTAINERS	2004-02-24 02:57:02.000000000 -0500
@@ -2395,7 +2395,7 @@
 
 ZR36067 VIDEO FOR LINUX DRIVER
 P:	Ronald Bultje
-M:	R.S.Bultje@pharm.uu.nl
+M:	rbultje@ronald.bitfreak.net
 L:	mjpeg-users@lists.sourceforge.net
 W:	http://mjpeg.sourceforge.net/driver-zoran/
 S:	Maintained

--=-NZhtgcseAj1nLycrSzaO--

