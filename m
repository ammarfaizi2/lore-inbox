Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261497AbVFVPbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbVFVPbP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 11:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVFVP3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 11:29:22 -0400
Received: from smtp3.brturbo.com.br ([200.199.201.164]:55700 "EHLO
	smtp3.brturbo.com.br") by vger.kernel.org with ESMTP
	id S261458AbVFVP1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 11:27:35 -0400
Message-ID: <42B9835C.1010708@brturbo.com.br>
Date: Wed, 22 Jun 2005 12:27:24 -0300
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: pt-br, pt, es, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux and Kernel Video <video4linux-list@redhat.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] v4l bttv new insmod parameters
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------000005070606020408040801"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000005070606020408040801
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

* bttv-driver.c, bttvp.h:

- New bttv module params:

- uv_ratio : allow a ratio of saturation between u and v. If you
        have a ratio of 40 and a saturation of 100, usat will be 80 and
        vstat 120. Useful to correct a bad color balance.
- full_luma_range : provide a better contrast in using the full
        range 0-253 of values instead of 16-253.
- coring : to have a better black level.
- radio range is now defined on tuner-core.c. Cleaning up.

* bttvp.h:

- Fix gcc 4.0 compilation

Signed-off-by: Jorik Jonker <jorik@dnd.utwente.nl>
Signed-off-by: Sylvain Meyer <sylvain.meyer@worldonline.fr>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Signed-off-by: Nickolay V Shmyrev <nshmyrev@yandex.ru>

 linux/drivers/media/video/bttv-driver.c |   73 +++++++++++++++++++++---
 linux/drivers/media/video/bttvp.h       |   15 ++--
 2 files changed, 73 insertions(+), 15 deletions(-)



--------------000005070606020408040801
Content-Type: text/x-patch;
 name="v4l_patch02_bttv_update.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="v4l_patch02_bttv_update.patch"

diff -u linux-2.6.12-mm1/drivers/media/video/bttvp.h linux/drivers/media/video/bttvp.h
--- linux-2.6.12-mm1/drivers/media/video/bttvp.h	2005-06-21 02:52:57.000000000 -0300
+++ linux/drivers/media/video/bttvp.h	2005-06-22 01:04:06.000000000 -0300
@@ -1,5 +1,5 @@
 /*
-    $Id: bttvp.h,v 1.17 2005/02/16 12:14:10 kraxel Exp $
+    $Id: bttvp.h,v 1.19 2005/06/16 21:38:45 nsh Exp $
 
     bttv - Bt848 frame grabber driver
 
@@ -226,11 +226,6 @@
 #define dprintk  if (bttv_debug >= 1) printk
 #define d2printk if (bttv_debug >= 2) printk
 
-/* our devices */
-#define BTTV_MAX 16
-extern unsigned int bttv_num;
-extern struct bttv bttvs[BTTV_MAX];
-
 #define BTTV_MAX_FBUF   0x208000
 #define VBIBUF_SIZE     (2048*VBI_MAXLINES*2)
 #define BTTV_TIMEOUT    (HZ/2) /* 0.5 seconds */
@@ -331,6 +326,9 @@
 	int opt_vcr_hack;
 	int opt_whitecrush_upper;
 	int opt_whitecrush_lower;
+	int opt_uv_ratio;
+	int opt_full_luma_range;
+	int opt_coring;
 
 	/* radio data/state */
 	int has_radio;
@@ -377,6 +375,11 @@
 	struct bttv_fh init;
 };
 
+/* our devices */
+#define BTTV_MAX 16
+extern unsigned int bttv_num;
+extern struct bttv bttvs[BTTV_MAX];
+
 /* private ioctls */
 #define BTTV_VERSION            _IOR('v' , BASE_VIDIOCPRIVATE+6, int)
 #define BTTV_VBISIZE            _IOR('v' , BASE_VIDIOCPRIVATE+8, int)
diff -u linux-2.6.12-mm1/drivers/media/video/bttv-driver.c linux/drivers/media/video/bttv-driver.c
--- linux-2.6.12-mm1/drivers/media/video/bttv-driver.c	2005-06-21 02:52:57.000000000 -0300
+++ linux/drivers/media/video/bttv-driver.c	2005-06-22 01:04:06.000000000 -0300
@@ -1,5 +1,5 @@
 /*
-    $Id: bttv-driver.c,v 1.38 2005/06/10 17:20:24 mchehab Exp $
+    $Id: bttv-driver.c,v 1.40 2005/06/16 21:38:45 nsh Exp $
 
     bttv - Bt848 frame grabber driver
 
@@ -76,6 +76,9 @@
 static unsigned int whitecrush_lower = 0x7F;
 static unsigned int vcr_hack    = 0;
 static unsigned int irq_iswitch = 0;
+static unsigned int uv_ratio    = 50;
+static unsigned int full_luma_range = 0;
+static unsigned int coring      = 0;
 
 /* API features (turn on/off stuff for testing) */
 static unsigned int v4l2        = 1;
@@ -106,6 +109,9 @@
 module_param(whitecrush_upper,  int, 0444);
 module_param(whitecrush_lower,  int, 0444);
 module_param(vcr_hack,          int, 0444);
+module_param(uv_ratio,          int, 0444);
+module_param(full_luma_range,   int, 0444);
+module_param(coring,            int, 0444);
 
 module_param_array(radio, int, NULL, 0444);
 
@@ -124,6 +130,9 @@
 MODULE_PARM_DESC(whitecrush_lower,"sets the white crush lower value, default is 127");
 MODULE_PARM_DESC(vcr_hack,"enables the VCR hack (improves synch on poor VCR tapes), default is 0 (no)");
 MODULE_PARM_DESC(irq_iswitch,"switch inputs in irq handler");
+MODULE_PARM_DESC(uv_ratio,"ratio between u and v gains, default is 50");
+MODULE_PARM_DESC(full_luma_range,"use the full luma range, default is 0 (no)");
+MODULE_PARM_DESC(coring,"set the luma coring level, default is 0 (no)");
 
 MODULE_DESCRIPTION("bttv - v4l/v4l2 driver module for bt848/878 based cards");
 MODULE_AUTHOR("Ralph Metzler & Marcus Metzler & Gerd Knorr");
@@ -484,7 +493,10 @@
 #define V4L2_CID_PRIVATE_VCR_HACK    (V4L2_CID_PRIVATE_BASE + 5)
 #define V4L2_CID_PRIVATE_WHITECRUSH_UPPER   (V4L2_CID_PRIVATE_BASE + 6)
 #define V4L2_CID_PRIVATE_WHITECRUSH_LOWER   (V4L2_CID_PRIVATE_BASE + 7)
-#define V4L2_CID_PRIVATE_LASTP1      (V4L2_CID_PRIVATE_BASE + 8)
+#define V4L2_CID_PRIVATE_UV_RATIO    (V4L2_CID_PRIVATE_BASE + 8)
+#define V4L2_CID_PRIVATE_FULL_LUMA_RANGE    (V4L2_CID_PRIVATE_BASE + 9)
+#define V4L2_CID_PRIVATE_CORING      (V4L2_CID_PRIVATE_BASE + 10)
+#define V4L2_CID_PRIVATE_LASTP1      (V4L2_CID_PRIVATE_BASE + 11)
 
 static const struct v4l2_queryctrl no_ctl = {
 	.name  = "42",
@@ -618,8 +630,32 @@
 		.step          = 1,
 		.default_value = 0x7F,
 		.type          = V4L2_CTRL_TYPE_INTEGER,
+	},{
+		.id            = V4L2_CID_PRIVATE_UV_RATIO,
+		.name          = "uv ratio",
+		.minimum       = 0,
+		.maximum       = 100,
+		.step          = 1,
+		.default_value = 50,
+		.type          = V4L2_CTRL_TYPE_INTEGER,
+	},{
+		.id            = V4L2_CID_PRIVATE_FULL_LUMA_RANGE,
+		.name          = "full luma range",
+		.minimum       = 0,
+		.maximum       = 1,
+		.type          = V4L2_CTRL_TYPE_BOOLEAN,
+	},{
+		.id            = V4L2_CID_PRIVATE_CORING,
+		.name          = "coring",
+		.minimum       = 0,
+		.maximum       = 3,
+		.step          = 1,
+		.default_value = 0,
+		.type          = V4L2_CTRL_TYPE_INTEGER,
 	}
 
+
+
 };
 static const int BTTV_CTLS = ARRAY_SIZE(bttv_ctls);
 
@@ -833,8 +869,8 @@
 	btv->saturation = color;
 
 	/* 0-511 for the color */
-	val_u   = color >> 7;
-	val_v   = ((color>>7)*180L)/254;
+	val_u   = ((color * btv->opt_uv_ratio) / 50) >> 7;
+	val_v   = (((color * (100 - btv->opt_uv_ratio) / 50) >>7)*180L)/254;
         hibits  = (val_u >> 7) & 2;
 	hibits |= (val_v >> 8) & 1;
         btwrite(val_u & 0xff, BT848_SAT_U_LO);
@@ -1151,6 +1187,15 @@
 	case V4L2_CID_PRIVATE_WHITECRUSH_LOWER:
 		c->value = btv->opt_whitecrush_lower;
 		break;
+	case V4L2_CID_PRIVATE_UV_RATIO:
+		c->value = btv->opt_uv_ratio;
+		break;
+	case V4L2_CID_PRIVATE_FULL_LUMA_RANGE:
+		c->value = btv->opt_full_luma_range;
+		break;
+	case V4L2_CID_PRIVATE_CORING:
+		c->value = btv->opt_coring;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1247,6 +1292,18 @@
 		btv->opt_whitecrush_lower = c->value;
 		btwrite(c->value, BT848_WC_DOWN);
 		break;
+	case V4L2_CID_PRIVATE_UV_RATIO:
+		btv->opt_uv_ratio = c->value;
+		bt848_sat(btv, btv->saturation);
+		break;
+	case V4L2_CID_PRIVATE_FULL_LUMA_RANGE:
+		btv->opt_full_luma_range = c->value;
+		btaor((c->value<<7), ~BT848_OFORM_RANGE, BT848_OFORM);
+		break;
+	case V4L2_CID_PRIVATE_CORING:
+		btv->opt_coring = c->value;
+		btaor((c->value<<5), ~BT848_OFORM_CORE32, BT848_OFORM);
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -3117,11 +3174,6 @@
                         return -EINVAL;
 		memset(v,0,sizeof(*v));
                 strcpy(v->name, "Radio");
-                /* japan:          76.0 MHz -  89.9 MHz
-                   western europe: 87.5 MHz - 108.0 MHz
-                   russia:         65.0 MHz - 108.0 MHz */
-                v->rangelow=(int)(65*16);
-                v->rangehigh=(int)(108*16);
                 bttv_call_i2c_clients(btv,cmd,v);
                 return 0;
         }
@@ -3876,6 +3928,9 @@
 	btv->opt_vcr_hack   = vcr_hack;
 	btv->opt_whitecrush_upper  = whitecrush_upper;
 	btv->opt_whitecrush_lower  = whitecrush_lower;
+	btv->opt_uv_ratio   = uv_ratio;
+	btv->opt_full_luma_range   = full_luma_range;
+	btv->opt_coring     = coring;
 
 	/* fill struct bttv with some useful defaults */
 	btv->init.btv         = btv;

--------------000005070606020408040801--
