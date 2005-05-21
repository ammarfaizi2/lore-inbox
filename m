Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261379AbVEUCf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261379AbVEUCf5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 22:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261643AbVEUCf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 22:35:57 -0400
Received: from mail.etel.at ([194.152.104.15]:23601 "EHLO relay03.etel.at")
	by vger.kernel.org with ESMTP id S261646AbVEUCfe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 22:35:34 -0400
Subject: [patch] v4l: saa7134 ntsc vbi fix
From: Michael Schimek <mschimek@gmx.at>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 21 May 2005 02:07:00 +0200
Message-Id: <1116634020.4356.29.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes NTSC VBI capturing in the saa7134 driver.

Signed-off-by: Michael H. Schimek <mschimek@gmx.at>
---

diff -1dpruN -X linux-2.6.12-rc4-mm1/Documentation/dontdiff linux-2.6.12-rc4-mm1/drivers/media/video/saa7134/saa7134-vbi.c linux-2.6.12-rc4-mm1-mhs/drivers/media/video/saa7134/saa7134-vbi.c
--- linux-2.6.12-rc4-mm1/drivers/media/video/saa7134/saa7134-vbi.c	Sun May 15 17:26:38 2005
+++ linux-2.6.12-rc4-mm1-mhs/drivers/media/video/saa7134/saa7134-vbi.c	Sun May 15 22:48:40 2005
@@ -62,6 +62,6 @@ static void task_init(struct saa7134_dev
 	saa_writeb(SAA7134_VBI_H_STOP2(task),  norm->h_stop      >> 8);
-	saa_writeb(SAA7134_VBI_V_START1(task), norm->vbi_v_start &  0xff);
-	saa_writeb(SAA7134_VBI_V_START2(task), norm->vbi_v_start >> 8);
-	saa_writeb(SAA7134_VBI_V_STOP1(task),  norm->vbi_v_stop  &  0xff);
-	saa_writeb(SAA7134_VBI_V_STOP2(task),  norm->vbi_v_stop  >> 8);
+	saa_writeb(SAA7134_VBI_V_START1(task), norm->vbi_v_start_0 &  0xff);
+	saa_writeb(SAA7134_VBI_V_START2(task), norm->vbi_v_start_0 >> 8);
+	saa_writeb(SAA7134_VBI_V_STOP1(task),  norm->vbi_v_stop_0  &  0xff);
+	saa_writeb(SAA7134_VBI_V_STOP2(task),  norm->vbi_v_stop_0  >> 8);
 
@@ -129,3 +129,3 @@ static int buffer_prepare(struct videobu
 
-	lines   = norm->vbi_v_stop - norm->vbi_v_start +1;
+	lines   = norm->vbi_v_stop_0 - norm->vbi_v_start_0 +1;
 	if (lines > VBI_LINE_COUNT)
@@ -179,3 +179,3 @@ buffer_setup(struct videobuf_queue *q, u
 
-	lines   = dev->tvnorm->vbi_v_stop - dev->tvnorm->vbi_v_start +1;
+	lines   = dev->tvnorm->vbi_v_stop_0 - dev->tvnorm->vbi_v_start_0 +1;
 #if 1
diff -1dpruN -X linux-2.6.12-rc4-mm1/Documentation/dontdiff linux-2.6.12-rc4-mm1/drivers/media/video/saa7134/saa7134-video.c linux-2.6.12-rc4-mm1-mhs/drivers/media/video/saa7134/saa7134-video.c
--- linux-2.6.12-rc4-mm1/drivers/media/video/saa7134/saa7134-video.c	Sun May 15 17:26:38 2005
+++ linux-2.6.12-rc4-mm1-mhs/drivers/media/video/saa7134/saa7134-video.c	Sun May 15 22:50:53 2005
@@ -160,4 +160,5 @@ static struct saa7134_format formats[] =
 		.video_v_stop  = 311,	\
-		.vbi_v_start   = 7,	\
-		.vbi_v_stop    = 22,	\
+		.vbi_v_start_0 = 7,	\
+		.vbi_v_stop_0  = 22,	\
+		.vbi_v_start_1 = 319,   \
 		.src_timing    = 4
@@ -167,7 +168,8 @@ static struct saa7134_format formats[] =
 		.h_stop        = 703,	\
-		.video_v_start = 22,	\
-		.video_v_stop  = 22+239, \
-		.vbi_v_start   = 10, /* FIXME */ \
-		.vbi_v_stop    = 21, /* FIXME */ \
-		.src_timing    = 1
+		.video_v_start = 23,	\
+		.video_v_stop  = 262,	\
+		.vbi_v_start_0 = 10,	\
+		.vbi_v_stop_0  = 21,	\
+		.vbi_v_start_1 = 273,	\
+		.src_timing    = 7
 
@@ -276,7 +278,8 @@ static struct saa7134_tvnorm tvnorms[] =
 		.h_stop        = 719,
-		.video_v_start = 22,
-		.video_v_stop  = 22+239,
-		.vbi_v_start   = 10, /* FIXME */
-		.vbi_v_stop    = 21, /* FIXME */
-		.src_timing    = 1,
+ 		.video_v_start = 23,
+ 		.video_v_stop  = 262,
+ 		.vbi_v_start_0 = 10,
+ 		.vbi_v_stop_0  = 21,
+ 		.vbi_v_start_1 = 273,
+ 		.src_timing    = 7,
 
@@ -337,4 +340,4 @@ static const struct v4l2_queryctrl video
 	},{
-		.id            = V4L2_CID_VFLIP,
-		.name          = "vertical flip",
+		.id            = V4L2_CID_HFLIP,
+		.name          = "Mirror",
 		.minimum       = 0,
@@ -484,3 +487,3 @@ static void set_tvnorm(struct saa7134_de
 
-	dev->crop_bounds.top     = (norm->vbi_v_stop+1)*2;
+	dev->crop_bounds.top     = (norm->vbi_v_stop_0+1)*2;
 	dev->crop_defrect.top    = norm->video_v_start*2;
@@ -1066,3 +1069,3 @@ static int get_control(struct saa7134_de
 		break;
-	case V4L2_CID_VFLIP:
+	case V4L2_CID_HFLIP:
 		c->value = dev->ctl_mirror;
@@ -1141,3 +1144,3 @@ static int set_control(struct saa7134_de
 		break;
-	case V4L2_CID_VFLIP:
+	case V4L2_CID_HFLIP:
 		dev->ctl_mirror = c->value;
@@ -1409,5 +1412,5 @@ static void saa7134_vbi_fmt(struct saa71
 	f->fmt.vbi.offset = 64 * 4;
-	f->fmt.vbi.start[0] = norm->vbi_v_start;
-	f->fmt.vbi.count[0] = norm->vbi_v_stop - norm->vbi_v_start +1;
-	f->fmt.vbi.start[1] = norm->video_v_stop + norm->vbi_v_start +1;
+	f->fmt.vbi.start[0] = norm->vbi_v_start_0;
+	f->fmt.vbi.count[0] = norm->vbi_v_stop_0 - norm->vbi_v_start_0 +1;
+	f->fmt.vbi.start[1] = norm->vbi_v_start_1;
 	f->fmt.vbi.count[1] = f->fmt.vbi.count[0];
diff -1dpruN -X linux-2.6.12-rc4-mm1/Documentation/dontdiff linux-2.6.12-rc4-mm1/drivers/media/video/saa7134/saa7134.h linux-2.6.12-rc4-mm1-mhs/drivers/media/video/saa7134/saa7134.h
--- linux-2.6.12-rc4-mm1/drivers/media/video/saa7134/saa7134.h	Sun May 15 17:26:38 2005
+++ linux-2.6.12-rc4-mm1-mhs/drivers/media/video/saa7134/saa7134.h	Sun May 15 22:48:40 2005
@@ -23,3 +23,3 @@
 #include <linux/version.h>
-#define SAA7134_VERSION_CODE KERNEL_VERSION(0,2,12)
+#define SAA7134_VERSION_CODE KERNEL_VERSION(0,2,13)
 
@@ -93,5 +93,6 @@ struct saa7134_tvnorm {
 	unsigned int  video_v_stop;
-	unsigned int  vbi_v_start;
-	unsigned int  vbi_v_stop;
+	unsigned int  vbi_v_start_0;
+	unsigned int  vbi_v_stop_0;
 	unsigned int  src_timing;
+	unsigned int  vbi_v_start_1;
 };
