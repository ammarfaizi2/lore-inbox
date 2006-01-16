Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932256AbWAPJVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbWAPJVz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 04:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbWAPJVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 04:21:55 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:18155 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932256AbWAPJVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 04:21:53 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org, Michael Krufky <mkrufky@m1k.net>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 07/25] Redesign tuners struct for maximum flexibility
Date: Mon, 16 Jan 2006 07:11:20 -0200
Message-id: <20060116091120.PS68988300007@infradead.org>
In-Reply-To: <20060116091105.PS83611600000@infradead.org>
References: <20060116091105.PS83611600000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Michael Krufky <mkrufky@m1k.net>

- Tunertype struct redefined to allow one or more tuner_params structs
  per tuner definition, one for each video standard.
- Each tuner_params struct has an element containing an arbitrary
  amount of tuner_ranges.
  (this is needed for dvb tuners - to be handled later)
- A tuner_range may be referenced by multiple tuner_params structs.
  There are many duplicates in here. Reusing tuner_range structs,
  rather than defining new ones for each tuner, will cut down on
  memory usage, and is preferred when possible.
- tunertype struct contains an element, has_tda988x.
  We must set this for all tunertypes that contain a tda988x
  chip, and then we can remove this setting from the various
  card structs.
- Improves tuners array memory usage efficiency.
- Right now, all tuners are using the first tuner_params[] array element
  for analog mode. In the future, we will be merging similar tuner
  definitions together, such that each tuner definition will have a
  tuner_params struct for each available video standard. At that point,
  the tuner_params[] array element will be chosen based on the video
  standard in use.

Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/Makefile       |    3 
 drivers/media/video/tuner-simple.c |  750 +-------------------
 drivers/media/video/tuner-types.c  | 1376 ++++++++++++++++++++++++++++++++++++
 include/media/tuner-types.h        |   41 +
 include/media/tuner.h              |    1 
 5 files changed, 1444 insertions(+), 727 deletions(-)

diff --git a/drivers/media/video/Makefile b/drivers/media/video/Makefile
index dd24896..faf7283 100644
--- a/drivers/media/video/Makefile
+++ b/drivers/media/video/Makefile
@@ -8,7 +8,8 @@ bttv-objs	:=	bttv-driver.o bttv-cards.o 
 zoran-objs      :=	zr36120.o zr36120_i2c.o zr36120_mem.o
 zr36067-objs	:=	zoran_procfs.o zoran_device.o \
 			zoran_driver.o zoran_card.o
-tuner-objs	:=	tuner-core.o tuner-simple.o mt20xx.o tda8290.o tea5767.o
+tuner-objs	:=	tuner-core.o tuner-types.o tuner-simple.o \
+			mt20xx.o tda8290.o tea5767.o
 
 msp3400-objs	:=	msp3400-driver.o msp3400-kthreads.o
 
diff --git a/drivers/media/video/tuner-simple.c b/drivers/media/video/tuner-simple.c
index e5fb743..3879262 100644
--- a/drivers/media/video/tuner-simple.c
+++ b/drivers/media/video/tuner-simple.c
@@ -79,722 +79,16 @@ MODULE_PARM_DESC(offset,"Allows to speci
 #define TUNER_PLL_LOCKED   0x40
 #define TUNER_STEREO_MK3   0x04
 
-#define TUNER_MAX_RANGES   3
-
-/* ---------------------------------------------------------------------- */
-
-struct tunertype
-{
-	char *name;
-
-	int count;
-	struct {
-		unsigned short thresh;
-		unsigned char cb;
-	} ranges[TUNER_MAX_RANGES];
-	unsigned char config;
-};
-
-/*
- *	The floats in the tuner struct are computed at compile time
- *	by gcc and cast back to integers. Thus we don't violate the
- *	"no float in kernel" rule.
+#define TUNER_PARAM_ANALOG 0  /* to be removed */
+/* FIXME:
+ * Right now, all tuners are using the first tuner_params[] array element
+ * for analog mode. In the future, we will be merging similar tuner
+ * definitions together, such that each tuner definition will have a
+ * tuner_params struct for each available video standard. At that point,
+ * TUNER_PARAM_ANALOG will be removed, and the tuner_params[] array
+ * element will be chosen based on the video standard in use.
+ *
  */
-static struct tunertype tuners[] = {
-	/* 0-9 */
-	[TUNER_TEMIC_PAL] = { /* TEMIC PAL */
-		.name   = "Temic PAL (4002 FH5)",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 140.25 /*MHz*/, 0x02, },
-			{ 16 * 463.25 /*MHz*/, 0x04, },
-			{ 16 * 999.99        , 0x01, },
-		},
-		.config = 0x8e,
-	},
-	[TUNER_PHILIPS_PAL_I] = { /* Philips PAL_I */
-		.name   = "Philips PAL_I (FI1246 and compatibles)",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 140.25 /*MHz*/, 0xa0, },
-			{ 16 * 463.25 /*MHz*/, 0x90, },
-			{ 16 * 999.99        , 0x30, },
-		},
-		.config = 0x8e,
-	},
-	[TUNER_PHILIPS_NTSC] = { /* Philips NTSC */
-		.name   = "Philips NTSC (FI1236,FM1236 and compatibles)",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 157.25 /*MHz*/, 0xa0, },
-			{ 16 * 451.25 /*MHz*/, 0x90, },
-			{ 16 * 999.99        , 0x30, },
-		},
-		.config = 0x8e,
-	},
-	[TUNER_PHILIPS_SECAM] = { /* Philips SECAM */
-		.name   = "Philips (SECAM+PAL_BG) (FI1216MF, FM1216MF, FR1216MF)",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 168.25 /*MHz*/, 0xa7, },
-			{ 16 * 447.25 /*MHz*/, 0x97, },
-			{ 16 * 999.99        , 0x37, },
-		},
-		.config = 0x8e,
-	},
-	[TUNER_ABSENT] = { /* Tuner Absent */
-		.name   = "NoTuner",
-		.count  = 1,
-		.ranges = {
-			{ 0, 0x00, },
-		},
-		.config = 0x00,
-	},
-	[TUNER_PHILIPS_PAL] = { /* Philips PAL */
-		.name   = "Philips PAL_BG (FI1216 and compatibles)",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 168.25 /*MHz*/, 0xa0, },
-			{ 16 * 447.25 /*MHz*/, 0x90, },
-			{ 16 * 999.99        , 0x30, },
-		},
-		.config = 0x8e,
-	},
-	[TUNER_TEMIC_NTSC] = { /* TEMIC NTSC */
-		.name   = "Temic NTSC (4032 FY5)",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 157.25 /*MHz*/, 0x02, },
-			{ 16 * 463.25 /*MHz*/, 0x04, },
-			{ 16 * 999.99        , 0x01, },
-		},
-		.config = 0x8e,
-	},
-	[TUNER_TEMIC_PAL_I] = { /* TEMIC PAL_I */
-		.name   = "Temic PAL_I (4062 FY5)",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 170.00 /*MHz*/, 0x02, },
-			{ 16 * 450.00 /*MHz*/, 0x04, },
-			{ 16 * 999.99        , 0x01, },
-		},
-		.config = 0x8e,
-	},
-	[TUNER_TEMIC_4036FY5_NTSC] = { /* TEMIC NTSC */
-		.name   = "Temic NTSC (4036 FY5)",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 157.25 /*MHz*/, 0xa0, },
-			{ 16 * 463.25 /*MHz*/, 0x90, },
-			{ 16 * 999.99        , 0x30, },
-		},
-		.config = 0x8e,
-	},
-	[TUNER_ALPS_TSBH1_NTSC] = { /* TEMIC NTSC */
-		.name   = "Alps HSBH1",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 137.25 /*MHz*/, 0x01, },
-			{ 16 * 385.25 /*MHz*/, 0x02, },
-			{ 16 * 999.99        , 0x08, },
-		},
-		.config = 0x8e,
-	},
-
-	/* 10-19 */
-	[TUNER_ALPS_TSBE1_PAL] = { /* TEMIC PAL */
-		.name   = "Alps TSBE1",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 137.25 /*MHz*/, 0x01, },
-			{ 16 * 385.25 /*MHz*/, 0x02, },
-			{ 16 * 999.99        , 0x08, },
-		},
-		.config = 0x8e,
-	},
-	[TUNER_ALPS_TSBB5_PAL_I] = { /* Alps PAL_I */
-		.name   = "Alps TSBB5",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 133.25 /*MHz*/, 0x01, },
-			{ 16 * 351.25 /*MHz*/, 0x02, },
-			{ 16 * 999.99        , 0x08, },
-		},
-		.config = 0x8e,
-	},
-	[TUNER_ALPS_TSBE5_PAL] = { /* Alps PAL */
-		.name   = "Alps TSBE5",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 133.25 /*MHz*/, 0x01, },
-			{ 16 * 351.25 /*MHz*/, 0x02, },
-			{ 16 * 999.99        , 0x08, },
-		},
-		.config = 0x8e,
-	},
-	[TUNER_ALPS_TSBC5_PAL] = { /* Alps PAL */
-		.name   = "Alps TSBC5",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 133.25 /*MHz*/, 0x01, },
-			{ 16 * 351.25 /*MHz*/, 0x02, },
-			{ 16 * 999.99        , 0x08, },
-		},
-		.config = 0x8e,
-	},
-	[TUNER_TEMIC_4006FH5_PAL] = { /* TEMIC PAL */
-		.name   = "Temic PAL_BG (4006FH5)",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 170.00 /*MHz*/, 0xa0, },
-			{ 16 * 450.00 /*MHz*/, 0x90, },
-			{ 16 * 999.99        , 0x30, },
-		},
-		.config = 0x8e,
-	},
-	[TUNER_ALPS_TSHC6_NTSC] = { /* Alps NTSC */
-		.name   = "Alps TSCH6",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 137.25 /*MHz*/, 0x14, },
-			{ 16 * 385.25 /*MHz*/, 0x12, },
-			{ 16 * 999.99        , 0x11, },
-		},
-		.config = 0x8e,
-	},
-	[TUNER_TEMIC_PAL_DK] = { /* TEMIC PAL */
-		.name   = "Temic PAL_DK (4016 FY5)",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 168.25 /*MHz*/, 0xa0, },
-			{ 16 * 456.25 /*MHz*/, 0x90, },
-			{ 16 * 999.99        , 0x30, },
-		},
-		.config = 0x8e,
-	},
-	[TUNER_PHILIPS_NTSC_M] = { /* Philips NTSC */
-		.name   = "Philips NTSC_M (MK2)",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 160.00 /*MHz*/, 0xa0, },
-			{ 16 * 454.00 /*MHz*/, 0x90, },
-			{ 16 * 999.99        , 0x30, },
-		},
-		.config = 0x8e,
-	},
-	[TUNER_TEMIC_4066FY5_PAL_I] = { /* TEMIC PAL_I */
-		.name   = "Temic PAL_I (4066 FY5)",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 169.00 /*MHz*/, 0xa0, },
-			{ 16 * 454.00 /*MHz*/, 0x90, },
-			{ 16 * 999.99        , 0x30, },
-		},
-		.config = 0x8e,
-	},
-	[TUNER_TEMIC_4006FN5_MULTI_PAL] = { /* TEMIC PAL */
-		.name   = "Temic PAL* auto (4006 FN5)",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 169.00 /*MHz*/, 0xa0, },
-			{ 16 * 454.00 /*MHz*/, 0x90, },
-			{ 16 * 999.99        , 0x30, },
-		},
-		.config = 0x8e,
-	},
-
-	/* 20-29 */
-	[TUNER_TEMIC_4009FR5_PAL] = { /* TEMIC PAL */
-		.name   = "Temic PAL_BG (4009 FR5) or PAL_I (4069 FR5)",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 141.00 /*MHz*/, 0xa0, },
-			{ 16 * 464.00 /*MHz*/, 0x90, },
-			{ 16 * 999.99        , 0x30, },
-		},
-		.config = 0x8e,
-	},
-	[TUNER_TEMIC_4039FR5_NTSC] = { /* TEMIC NTSC */
-		.name   = "Temic NTSC (4039 FR5)",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 158.00 /*MHz*/, 0xa0, },
-			{ 16 * 453.00 /*MHz*/, 0x90, },
-			{ 16 * 999.99        , 0x30, },
-		},
-		.config = 0x8e,
-	},
-	[TUNER_TEMIC_4046FM5] = { /* TEMIC PAL */
-		.name   = "Temic PAL/SECAM multi (4046 FM5)",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 169.00 /*MHz*/, 0xa0, },
-			{ 16 * 454.00 /*MHz*/, 0x90, },
-			{ 16 * 999.99        , 0x30, },
-		},
-		.config = 0x8e,
-	},
-	[TUNER_PHILIPS_PAL_DK] = { /* Philips PAL */
-		.name   = "Philips PAL_DK (FI1256 and compatibles)",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 170.00 /*MHz*/, 0xa0, },
-			{ 16 * 450.00 /*MHz*/, 0x90, },
-			{ 16 * 999.99        , 0x30, },
-		},
-		.config = 0x8e,
-	},
-	[TUNER_PHILIPS_FQ1216ME] = { /* Philips PAL */
-		.name   = "Philips PAL/SECAM multi (FQ1216ME)",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 170.00 /*MHz*/, 0xa0, },
-			{ 16 * 450.00 /*MHz*/, 0x90, },
-			{ 16 * 999.99        , 0x30, },
-		},
-		.config = 0x8e,
-	},
-	[TUNER_LG_PAL_I_FM] = { /* LGINNOTEK PAL_I */
-		.name   = "LG PAL_I+FM (TAPC-I001D)",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 170.00 /*MHz*/, 0xa0, },
-			{ 16 * 450.00 /*MHz*/, 0x90, },
-			{ 16 * 999.99        , 0x30, },
-		},
-		.config = 0x8e,
-	},
-	[TUNER_LG_PAL_I] = { /* LGINNOTEK PAL_I */
-		.name   = "LG PAL_I (TAPC-I701D)",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 170.00 /*MHz*/, 0xa0, },
-			{ 16 * 450.00 /*MHz*/, 0x90, },
-			{ 16 * 999.99        , 0x30, },
-		},
-		.config = 0x8e,
-	},
-	[TUNER_LG_NTSC_FM] = { /* LGINNOTEK NTSC */
-		.name   = "LG NTSC+FM (TPI8NSR01F)",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 210.00 /*MHz*/, 0xa0, },
-			{ 16 * 497.00 /*MHz*/, 0x90, },
-			{ 16 * 999.99        , 0x30, },
-		},
-		.config = 0x8e,
-	},
-	[TUNER_LG_PAL_FM] = { /* LGINNOTEK PAL */
-		.name   = "LG PAL_BG+FM (TPI8PSB01D)",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 170.00 /*MHz*/, 0xa0, },
-			{ 16 * 450.00 /*MHz*/, 0x90, },
-			{ 16 * 999.99        , 0x30, },
-		},
-		.config = 0x8e,
-	},
-	[TUNER_LG_PAL] = { /* LGINNOTEK PAL */
-		.name   = "LG PAL_BG (TPI8PSB11D)",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 170.00 /*MHz*/, 0xa0, },
-			{ 16 * 450.00 /*MHz*/, 0x90, },
-			{ 16 * 999.99        , 0x30, },
-		},
-		.config = 0x8e,
-	},
-
-	/* 30-39 */
-	[TUNER_TEMIC_4009FN5_MULTI_PAL_FM] = { /* TEMIC PAL */
-		.name   = "Temic PAL* auto + FM (4009 FN5)",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 141.00 /*MHz*/, 0xa0, },
-			{ 16 * 464.00 /*MHz*/, 0x90, },
-			{ 16 * 999.99        , 0x30, },
-		},
-		.config = 0x8e,
-	},
-	[TUNER_SHARP_2U5JF5540_NTSC] = { /* SHARP NTSC */
-		.name   = "SHARP NTSC_JP (2U5JF5540)",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 137.25 /*MHz*/, 0x01, },
-			{ 16 * 317.25 /*MHz*/, 0x02, },
-			{ 16 * 999.99        , 0x08, },
-		},
-		.config = 0x8e,
-	},
-	[TUNER_Samsung_PAL_TCPM9091PD27] = { /* Samsung PAL */
-		.name   = "Samsung PAL TCPM9091PD27",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 169 /*MHz*/, 0xa0, },
-			{ 16 * 464 /*MHz*/, 0x90, },
-			{ 16 * 999.99     , 0x30, },
-		},
-		.config = 0x8e,
-	},
-	[TUNER_MT2032] = { /* Microtune PAL|NTSC */
-		.name   = "MT20xx universal",
-	  /* see mt20xx.c for details */ },
-	[TUNER_TEMIC_4106FH5] = { /* TEMIC PAL */
-		.name   = "Temic PAL_BG (4106 FH5)",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 141.00 /*MHz*/, 0xa0, },
-			{ 16 * 464.00 /*MHz*/, 0x90, },
-			{ 16 * 999.99        , 0x30, },
-		},
-		.config = 0x8e,
-	},
-	[TUNER_TEMIC_4012FY5] = { /* TEMIC PAL */
-		.name   = "Temic PAL_DK/SECAM_L (4012 FY5)",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 140.25 /*MHz*/, 0x02, },
-			{ 16 * 463.25 /*MHz*/, 0x04, },
-			{ 16 * 999.99        , 0x01, },
-		},
-		.config = 0x8e,
-	},
-	[TUNER_TEMIC_4136FY5] = { /* TEMIC NTSC */
-		.name   = "Temic NTSC (4136 FY5)",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 158.00 /*MHz*/, 0xa0, },
-			{ 16 * 453.00 /*MHz*/, 0x90, },
-			{ 16 * 999.99        , 0x30, },
-		},
-		.config = 0x8e,
-	},
-	[TUNER_LG_PAL_NEW_TAPC] = { /* LGINNOTEK PAL */
-		.name   = "LG PAL (newer TAPC series)",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 170.00 /*MHz*/, 0x01, },
-			{ 16 * 450.00 /*MHz*/, 0x02, },
-			{ 16 * 999.99        , 0x08, },
-		},
-		.config = 0x8e,
-	},
-	[TUNER_PHILIPS_FM1216ME_MK3] = { /* Philips PAL */
-		.name   = "Philips PAL/SECAM multi (FM1216ME MK3)",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 158.00 /*MHz*/, 0x01, },
-			{ 16 * 442.00 /*MHz*/, 0x02, },
-			{ 16 * 999.99        , 0x04, },
-		},
-		.config = 0x8e,
-	},
-	[TUNER_LG_NTSC_NEW_TAPC] = { /* LGINNOTEK NTSC */
-		.name   = "LG NTSC (newer TAPC series)",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 170.00 /*MHz*/, 0x01, },
-			{ 16 * 450.00 /*MHz*/, 0x02, },
-			{ 16 * 999.99        , 0x08, },
-		},
-		.config = 0x8e,
-	},
-
-	/* 40-49 */
-	[TUNER_HITACHI_NTSC] = { /* HITACHI NTSC */
-		.name   = "HITACHI V7-J180AT",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 170.00 /*MHz*/, 0x01, },
-			{ 16 * 450.00 /*MHz*/, 0x02, },
-			{ 16 * 999.99        , 0x08, },
-		},
-		.config = 0x8e,
-	},
-	[TUNER_PHILIPS_PAL_MK] = { /* Philips PAL */
-		.name   = "Philips PAL_MK (FI1216 MK)",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 140.25 /*MHz*/, 0x01, },
-			{ 16 * 463.25 /*MHz*/, 0xc2, },
-			{ 16 * 999.99        , 0xcf, },
-		},
-		.config = 0x8e,
-	},
-	[TUNER_PHILIPS_ATSC] = { /* Philips ATSC */
-		.name   = "Philips 1236D ATSC/NTSC dual in",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 157.25 /*MHz*/, 0xa0, },
-			{ 16 * 454.00 /*MHz*/, 0x90, },
-			{ 16 * 999.99        , 0x30, },
-		},
-		.config = 0x8e,
-	},
-	[TUNER_PHILIPS_FM1236_MK3] = { /* Philips NTSC */
-		.name   = "Philips NTSC MK3 (FM1236MK3 or FM1236/F)",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 160.00 /*MHz*/, 0x01, },
-			{ 16 * 442.00 /*MHz*/, 0x02, },
-			{ 16 * 999.99        , 0x04, },
-		},
-		.config = 0x8e,
-	},
-	[TUNER_PHILIPS_4IN1] = { /* Philips NTSC */
-		.name   = "Philips 4 in 1 (ATI TV Wonder Pro/Conexant)",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 160.00 /*MHz*/, 0x01, },
-			{ 16 * 442.00 /*MHz*/, 0x02, },
-			{ 16 * 999.99        , 0x04, },
-		},
-		.config = 0x8e,
-	},
-	[TUNER_MICROTUNE_4049FM5] = { /* Microtune PAL */
-		.name   = "Microtune 4049 FM5",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 141.00 /*MHz*/, 0xa0, },
-			{ 16 * 464.00 /*MHz*/, 0x90, },
-			{ 16 * 999.99        , 0x30, },
-		},
-		.config = 0x8e,
-	},
-	[TUNER_PANASONIC_VP27] = { /* Panasonic NTSC */
-		.name   = "Panasonic VP27s/ENGE4324D",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 160.00 /*MHz*/, 0x01, },
-			{ 16 * 454.00 /*MHz*/, 0x02, },
-			{ 16 * 999.99        , 0x08, },
-		},
-		.config = 0xce,
-	},
-	[TUNER_LG_NTSC_TAPE] = { /* LGINNOTEK NTSC */
-		.name   = "LG NTSC (TAPE series)",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 160.00 /*MHz*/, 0x01, },
-			{ 16 * 442.00 /*MHz*/, 0x02, },
-			{ 16 * 999.99        , 0x04, },
-		},
-		.config = 0x8e,
-	},
-	[TUNER_TNF_8831BGFF] = { /* Philips PAL */
-		.name   = "Tenna TNF 8831 BGFF)",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 161.25 /*MHz*/, 0xa0, },
-			{ 16 * 463.25 /*MHz*/, 0x90, },
-			{ 16 * 999.99        , 0x30, },
-		},
-		.config = 0x8e,
-	},
-	[TUNER_MICROTUNE_4042FI5] = { /* Microtune NTSC */
-		.name   = "Microtune 4042 FI5 ATSC/NTSC dual in",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 162.00 /*MHz*/, 0xa2, },
-			{ 16 * 457.00 /*MHz*/, 0x94, },
-			{ 16 * 999.99        , 0x31, },
-		},
-		.config = 0x8e,
-	},
-
-	/* 50-59 */
-	[TUNER_TCL_2002N] = { /* TCL NTSC */
-		.name   = "TCL 2002N",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 172.00 /*MHz*/, 0x01, },
-			{ 16 * 448.00 /*MHz*/, 0x02, },
-			{ 16 * 999.99        , 0x08, },
-		},
-		.config = 0x8e,
-	},
-	[TUNER_PHILIPS_FM1256_IH3] = { /* Philips PAL */
-		.name   = "Philips PAL/SECAM_D (FM 1256 I-H3)",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 160.00 /*MHz*/, 0x01, },
-			{ 16 * 442.00 /*MHz*/, 0x02, },
-			{ 16 * 999.99        , 0x04, },
-		},
-		.config = 0x8e,
-	},
-	[TUNER_THOMSON_DTT7610] = { /* THOMSON ATSC */
-		.name   = "Thomson DTT 7610 (ATSC/NTSC)",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 157.25 /*MHz*/, 0x39, },
-			{ 16 * 454.00 /*MHz*/, 0x3a, },
-			{ 16 * 999.99        , 0x3c, },
-		},
-		.config = 0x8e,
-	},
-	[TUNER_PHILIPS_FQ1286] = { /* Philips NTSC */
-		.name   = "Philips FQ1286",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 160.00 /*MHz*/, 0x41, },
-			{ 16 * 454.00 /*MHz*/, 0x42, },
-			{ 16 * 999.99        , 0x04, },
-		},
-		.config = 0x8e,
-	},
-	[TUNER_PHILIPS_TDA8290] = { /* Philips PAL|NTSC */
-		.name   = "tda8290+75",
-	  /* see tda8290.c for details */ },
-	[TUNER_TCL_2002MB] = { /* TCL PAL */
-		.name   = "TCL 2002MB",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 170.00 /*MHz*/, 0x01, },
-			{ 16 * 450.00 /*MHz*/, 0x02, },
-			{ 16 * 999.99        , 0x08, },
-		},
-		.config = 0xce,
-	},
-	[TUNER_PHILIPS_FQ1216AME_MK4] = { /* Philips PAL */
-		.name   = "Philips PAL/SECAM multi (FQ1216AME MK4)",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 160.00 /*MHz*/, 0x01, },
-			{ 16 * 442.00 /*MHz*/, 0x02, },
-			{ 16 * 999.99        , 0x04, },
-		},
-		.config = 0xce,
-	},
-	[TUNER_PHILIPS_FQ1236A_MK4] = { /* Philips NTSC */
-		.name   = "Philips FQ1236A MK4",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 160.00 /*MHz*/, 0x01, },
-			{ 16 * 442.00 /*MHz*/, 0x02, },
-			{ 16 * 999.99        , 0x04, },
-		},
-		.config = 0x8e,
-	},
-	[TUNER_YMEC_TVF_8531MF] = { /* Philips NTSC */
-		.name   = "Ymec TVision TVF-8531MF/8831MF/8731MF",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 160.00 /*MHz*/, 0xa0, },
-			{ 16 * 454.00 /*MHz*/, 0x90, },
-			{ 16 * 999.99        , 0x30, },
-		},
-		.config = 0x8e,
-	},
-	[TUNER_YMEC_TVF_5533MF] = { /* Philips NTSC */
-		.name   = "Ymec TVision TVF-5533MF",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 160.00 /*MHz*/, 0x01, },
-			{ 16 * 454.00 /*MHz*/, 0x02, },
-			{ 16 * 999.99        , 0x04, },
-		},
-		.config = 0x8e,
-	},
-
-	/* 60-69 */
-	[TUNER_THOMSON_DTT761X] = { /* THOMSON ATSC */
-		/* DTT 7611 7611A 7612 7613 7613A 7614 7615 7615A */
-		.name   = "Thomson DTT 761X (ATSC/NTSC)",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 145.25 /*MHz*/, 0x39, },
-			{ 16 * 415.25 /*MHz*/, 0x3a, },
-			{ 16 * 999.99        , 0x3c, },
-		},
-		.config = 0x8e,
-	},
-	[TUNER_TENA_9533_DI] = { /* Philips PAL */
-		.name   = "Tena TNF9533-D/IF/TNF9533-B/DF",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 160.25 /*MHz*/, 0x01, },
-			{ 16 * 464.25 /*MHz*/, 0x02, },
-			{ 16 * 999.99        , 0x04, },
-		},
-		.config = 0x8e,
-	},
-	[TUNER_TEA5767] = { /* Philips RADIO */
-		.name   = "Philips TEA5767HN FM Radio",
-	  /* see tea5767.c for details */},
-	[TUNER_PHILIPS_FMD1216ME_MK3] = { /* Philips PAL */
-		.name   = "Philips FMD1216ME MK3 Hybrid Tuner",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 160.00 /*MHz*/, 0x51, },
-			{ 16 * 442.00 /*MHz*/, 0x52, },
-			{ 16 * 999.99        , 0x54, },
-		},
-		.config = 0x86,
-	},
-	[TUNER_LG_TDVS_H062F] = { /* LGINNOTEK ATSC */
-		.name   = "LG TDVS-H062F/TUA6034",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 160.00 /*MHz*/, 0x01 },
-			{ 16 * 455.00 /*MHz*/, 0x02 },
-			{ 16 * 999.99        , 0x04 },
-		},
-		.config = 0x8e,
-	},
-	[TUNER_YMEC_TVF66T5_B_DFF] = { /* Philips PAL */
-		.name   = "Ymec TVF66T5-B/DFF",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 160.25 /*MHz*/, 0x01, },
-			{ 16 * 464.25 /*MHz*/, 0x02, },
-			{ 16 * 999.99        , 0x08, },
-		},
-		.config = 0x8e,
-	},
-	[TUNER_LG_NTSC_TALN_MINI] = { /* LGINNOTEK NTSC */
-		.name   = "LG NTSC (TALN mini series)",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 137.25 /*MHz*/, 0x01, },
-			{ 16 * 373.25 /*MHz*/, 0x02, },
-			{ 16 * 999.99        , 0x08, },
-		},
-		.config = 0x8e,
-	},
-	[TUNER_PHILIPS_TD1316] = { /* Philips PAL */
-		.name   = "Philips TD1316 Hybrid Tuner",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 160.00 /*MHz*/, 0xa1, },
-			{ 16 * 442.00 /*MHz*/, 0xa2, },
-			{ 16 * 999.99        , 0xa4, },
-		},
-		.config = 0xc8,
-	},
-	[TUNER_PHILIPS_TUV1236D] = { /* Philips ATSC */
-		.name   = "Philips TUV1236D ATSC/NTSC dual in",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 157.25 /*MHz*/, 0x01, },
-			{ 16 * 454.00 /*MHz*/, 0x02, },
-			{ 16 * 999.99        , 0x04, },
-		},
-		.config = 0xce,
-	},
-	[TUNER_TNF_5335MF] = { /* Philips NTSC */
-		.name   = "Tena TNF 5335 MF",
-		.count  = 3,
-		.ranges = {
-			{ 16 * 157.25 /*MHz*/, 0x01, },
-			{ 16 * 454.00 /*MHz*/, 0x02, },
-			{ 16 * 999.99        , 0x04, },
-		},
-		.config = 0x8e,
-	},
-};
-
-unsigned const int tuner_count = ARRAY_SIZE(tuners);
 
 /* ---------------------------------------------------------------------- */
 
@@ -843,15 +137,17 @@ static void default_set_tv_freq(struct i
 	u16 div;
 	struct tunertype *tun;
 	unsigned char buffer[4];
-	int rc, IFPCoff, i;
+	int rc, IFPCoff, i, j;
 
 	tun = &tuners[t->type];
-	for (i = 0; i < tun->count; i++) {
-		if (freq > tun->ranges[i].thresh)
+	j = TUNER_PARAM_ANALOG;
+
+	for (i = 0; i < tun->params[j].count; i++) {
+		if (freq > tun->params[j].ranges[i].limit)
 			continue;
 		break;
 	}
-	config = tun->ranges[i].cb;
+	config = tun->params[j].ranges[i].cb;
 	/*  i == 0 -> VHF_LO  */
 	/*  i == 1 -> VHF_HI  */
 	/*  i == 2 -> UHF     */
@@ -914,7 +210,7 @@ static void default_set_tv_freq(struct i
 
 	case TUNER_MICROTUNE_4042FI5:
 		/* Set the charge pump for fast tuning */
-		tun->config |= TUNER_CHARGE_PUMP;
+		tun->params[j].config |= TUNER_CHARGE_PUMP;
 		break;
 
 	case TUNER_PHILIPS_TUV1236D:
@@ -989,14 +285,14 @@ static void default_set_tv_freq(struct i
 					div);
 
 	if (t->type == TUNER_PHILIPS_SECAM && freq < t->freq) {
-		buffer[0] = tun->config;
+		buffer[0] = tun->params[j].config;
 		buffer[1] = config;
 		buffer[2] = (div>>8) & 0x7f;
 		buffer[3] = div      & 0xff;
 	} else {
 		buffer[0] = (div>>8) & 0x7f;
 		buffer[1] = div      & 0xff;
-		buffer[2] = tun->config;
+		buffer[2] = tun->params[j].config;
 		buffer[3] = config;
 	}
 	tuner_dbg("tv 0x%02x 0x%02x 0x%02x 0x%02x\n",
@@ -1024,10 +320,10 @@ static void default_set_tv_freq(struct i
 		}
 
 		/* Set the charge pump for optimized phase noise figure */
-		tun->config &= ~TUNER_CHARGE_PUMP;
+		tun->params[j].config &= ~TUNER_CHARGE_PUMP;
 		buffer[0] = (div>>8) & 0x7f;
 		buffer[1] = div      & 0xff;
-		buffer[2] = tun->config;
+		buffer[2] = tun->params[j].config;
 		buffer[3] = config;
 		tuner_dbg("tv 0x%02x 0x%02x 0x%02x 0x%02x\n",
 		       buffer[0],buffer[1],buffer[2],buffer[3]);
@@ -1043,11 +339,13 @@ static void default_set_radio_freq(struc
 	struct tuner *t = i2c_get_clientdata(c);
 	unsigned char buffer[4];
 	unsigned div;
-	int rc;
+	int rc, j;
 
 	tun = &tuners[t->type];
+	j = TUNER_PARAM_ANALOG;
+
 	div = (20 * freq / 16000) + (int)(20*10.7); /* IF 10.7 MHz */
-	buffer[2] = (tun->config & ~TUNER_RATIO_MASK) | TUNER_RATIO_SELECT_50; /* 50 kHz step */
+	buffer[2] = (tun->params[j].config & ~TUNER_RATIO_MASK) | TUNER_RATIO_SELECT_50; /* 50 kHz step */
 
 	switch (t->type) {
 	case TUNER_TENA_9533_DI:
diff --git a/drivers/media/video/tuner-types.c b/drivers/media/video/tuner-types.c
new file mode 100644
index 0000000..de9d492
--- /dev/null
+++ b/drivers/media/video/tuner-types.c
@@ -0,0 +1,1376 @@
+/*
+ *
+ * i2c tv tuner chip device type database.
+ *
+ */
+
+#include <linux/i2c.h>
+#include <media/tuner.h>
+#include <media/tuner-types.h>
+
+/* ---------------------------------------------------------------------- */
+
+/*
+ *	The floats in the tuner struct are computed at compile time
+ *	by gcc and cast back to integers. Thus we don't violate the
+ *	"no float in kernel" rule.
+ *
+ *	A tuner_range may be referenced by multiple tuner_params structs.
+ *	There are many duplicates in here. Reusing tuner_range structs,
+ *	rather than defining new ones for each tuner, will cut down on
+ *	memory usage, and is preferred when possible.
+ *
+ *	Each tuner_params array may contain one or more elements, one
+ *	for each video standard.
+ *
+ *	FIXME: Some tuner_range definitions are duplicated, and
+ *	should be eliminated.
+ *
+ *	FIXME: tunertype struct contains an element, has_tda988x.
+ *	We must set this for all tunertypes that contain a tda988x
+ *	chip, and then we can remove this setting from the various
+ *	card structs.
+ */
+
+/* 0-9 */
+/* ------------ TUNER_TEMIC_PAL - TEMIC PAL ------------ */
+
+static struct tuner_range tuner_temic_pal_ranges[] = {
+	{ 16 * 140.25 /*MHz*/, 0x02, },
+	{ 16 * 463.25 /*MHz*/, 0x04, },
+	{ 16 * 999.99        , 0x01, },
+};
+
+static struct tuner_params tuner_temic_pal_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_PAL,
+		.ranges = tuner_temic_pal_ranges,
+		.count  = ARRAY_SIZE(tuner_temic_pal_ranges),
+		.config = 0x8e,
+	},
+};
+
+/* ------------ TUNER_PHILIPS_PAL_I - Philips PAL_I ------------ */
+
+static struct tuner_range tuner_philips_pal_i_ranges[] = {
+	{ 16 * 140.25 /*MHz*/, 0xa0, },
+	{ 16 * 463.25 /*MHz*/, 0x90, },
+	{ 16 * 999.99        , 0x30, },
+};
+
+static struct tuner_params tuner_philips_pal_i_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_PAL,
+		.ranges = tuner_philips_pal_i_ranges,
+		.count  = ARRAY_SIZE(tuner_philips_pal_i_ranges),
+		.config = 0x8e,
+	},
+};
+
+/* ------------ TUNER_PHILIPS_NTSC - Philips NTSC ------------ */
+
+static struct tuner_range tuner_philips_ntsc_ranges[] = {
+	{ 16 * 157.25 /*MHz*/, 0xa0, },
+	{ 16 * 451.25 /*MHz*/, 0x90, },
+	{ 16 * 999.99        , 0x30, },
+};
+
+static struct tuner_params tuner_philips_ntsc_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_NTSC,
+		.ranges = tuner_philips_ntsc_ranges,
+		.count  = ARRAY_SIZE(tuner_philips_ntsc_ranges),
+		.config = 0x8e,
+	},
+};
+
+/* ------------ TUNER_PHILIPS_SECAM - Philips SECAM ------------ */
+
+static struct tuner_range tuner_philips_secam_ranges[] = {
+	{ 16 * 168.25 /*MHz*/, 0xa7, },
+	{ 16 * 447.25 /*MHz*/, 0x97, },
+	{ 16 * 999.99        , 0x37, },
+};
+
+static struct tuner_params tuner_philips_secam_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_SECAM,
+		.ranges = tuner_philips_secam_ranges,
+		.count  = ARRAY_SIZE(tuner_philips_secam_ranges),
+		.config = 0x8e,
+	},
+};
+
+/* ------------ TUNER_PHILIPS_PAL - Philips PAL ------------ */
+
+static struct tuner_range tuner_philips_pal_ranges[] = {
+	{ 16 * 168.25 /*MHz*/, 0xa0, },
+	{ 16 * 447.25 /*MHz*/, 0x90, },
+	{ 16 * 999.99        , 0x30, },
+};
+
+static struct tuner_params tuner_philips_pal_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_PAL,
+		.ranges = tuner_philips_pal_ranges,
+		.count  = ARRAY_SIZE(tuner_philips_pal_ranges),
+		.config = 0x8e,
+	},
+};
+
+/* ------------ TUNER_TEMIC_NTSC - TEMIC NTSC ------------ */
+
+static struct tuner_range tuner_temic_ntsc_ranges[] = {
+	{ 16 * 157.25 /*MHz*/, 0x02, },
+	{ 16 * 463.25 /*MHz*/, 0x04, },
+	{ 16 * 999.99        , 0x01, },
+};
+
+static struct tuner_params tuner_temic_ntsc_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_NTSC,
+		.ranges = tuner_temic_ntsc_ranges,
+		.count  = ARRAY_SIZE(tuner_temic_ntsc_ranges),
+		.config = 0x8e,
+	},
+};
+
+/* ------------ TUNER_TEMIC_PAL_I - TEMIC PAL_I ------------ */
+
+static struct tuner_range tuner_temic_pal_i_ranges[] = {
+	{ 16 * 170.00 /*MHz*/, 0x02, },
+	{ 16 * 450.00 /*MHz*/, 0x04, },
+	{ 16 * 999.99        , 0x01, },
+};
+
+static struct tuner_params tuner_temic_pal_i_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_PAL,
+		.ranges = tuner_temic_pal_i_ranges,
+		.count  = ARRAY_SIZE(tuner_temic_pal_i_ranges),
+		.config = 0x8e,
+	},
+};
+
+/* ------------ TUNER_TEMIC_4036FY5_NTSC - TEMIC NTSC ------------ */
+
+static struct tuner_range tuner_temic_4036fy5_ntsc_ranges[] = {
+	{ 16 * 157.25 /*MHz*/, 0xa0, },
+	{ 16 * 463.25 /*MHz*/, 0x90, },
+	{ 16 * 999.99        , 0x30, },
+};
+
+static struct tuner_params tuner_temic_4036fy5_ntsc_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_NTSC,
+		.ranges = tuner_temic_4036fy5_ntsc_ranges,
+		.count  = ARRAY_SIZE(tuner_temic_4036fy5_ntsc_ranges),
+		.config = 0x8e,
+	},
+};
+
+/* ------------ TUNER_ALPS_TSBH1_NTSC - TEMIC NTSC ------------ */
+
+static struct tuner_range tuner_alps_tsb_1_ranges[] = {
+	{ 16 * 137.25 /*MHz*/, 0x01, },
+	{ 16 * 385.25 /*MHz*/, 0x02, },
+	{ 16 * 999.99        , 0x08, },
+};
+
+static struct tuner_params tuner_alps_tsbh1_ntsc_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_NTSC,
+		.ranges = tuner_alps_tsb_1_ranges,
+		.count  = ARRAY_SIZE(tuner_alps_tsb_1_ranges),
+		.config = 0x8e,
+	},
+};
+
+/* 10-19 */
+/* ------------ TUNER_ALPS_TSBE1_PAL - TEMIC PAL ------------ */
+
+static struct tuner_params tuner_alps_tsb_1_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_PAL,
+		.ranges = tuner_alps_tsb_1_ranges,
+		.count  = ARRAY_SIZE(tuner_alps_tsb_1_ranges),
+		.config = 0x8e,
+	},
+};
+
+/* ------------ TUNER_ALPS_TSBB5_PAL_I - Alps PAL_I ------------ */
+
+static struct tuner_range tuner_alps_tsb_5_pal_ranges[] = {
+	{ 16 * 133.25 /*MHz*/, 0x01, },
+	{ 16 * 351.25 /*MHz*/, 0x02, },
+	{ 16 * 999.99        , 0x08, },
+};
+
+static struct tuner_params tuner_alps_tsbb5_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_PAL,
+		.ranges = tuner_alps_tsb_5_pal_ranges,
+		.count  = ARRAY_SIZE(tuner_alps_tsb_5_pal_ranges),
+		.config = 0x8e,
+	},
+};
+
+/* ------------ TUNER_ALPS_TSBE5_PAL - Alps PAL ------------ */
+
+static struct tuner_params tuner_alps_tsbe5_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_PAL,
+		.ranges = tuner_alps_tsb_5_pal_ranges,
+		.count  = ARRAY_SIZE(tuner_alps_tsb_5_pal_ranges),
+		.config = 0x8e,
+	},
+};
+
+/* ------------ TUNER_ALPS_TSBC5_PAL - Alps PAL ------------ */
+
+static struct tuner_params tuner_alps_tsbc5_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_PAL,
+		.ranges = tuner_alps_tsb_5_pal_ranges,
+		.count  = ARRAY_SIZE(tuner_alps_tsb_5_pal_ranges),
+		.config = 0x8e,
+	},
+};
+
+/* ------------ TUNER_TEMIC_4006FH5_PAL - TEMIC PAL ------------ */
+
+static struct tuner_range tuner_temic_4006fh5_pal_ranges[] = {
+	{ 16 * 170.00 /*MHz*/, 0xa0, },
+	{ 16 * 450.00 /*MHz*/, 0x90, },
+	{ 16 * 999.99        , 0x30, },
+};
+
+static struct tuner_params tuner_temic_4006fh5_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_PAL,
+		.ranges = tuner_temic_4006fh5_pal_ranges,
+		.count  = ARRAY_SIZE(tuner_temic_4006fh5_pal_ranges),
+		.config = 0x8e,
+	},
+};
+
+/* ------------ TUNER_ALPS_TSHC6_NTSC - Alps NTSC ------------ */
+
+static struct tuner_range tuner_alps_tshc6_ntsc_ranges[] = {
+	{ 16 * 137.25 /*MHz*/, 0x14, },
+	{ 16 * 385.25 /*MHz*/, 0x12, },
+	{ 16 * 999.99        , 0x11, },
+};
+
+static struct tuner_params tuner_alps_tshc6_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_NTSC,
+		.ranges = tuner_alps_tshc6_ntsc_ranges,
+		.count  = ARRAY_SIZE(tuner_alps_tshc6_ntsc_ranges),
+		.config = 0x8e,
+	},
+};
+
+/* ------------ TUNER_TEMIC_PAL_DK - TEMIC PAL ------------ */
+
+static struct tuner_range tuner_temic_pal_dk_ranges[] = {
+	{ 16 * 168.25 /*MHz*/, 0xa0, },
+	{ 16 * 456.25 /*MHz*/, 0x90, },
+	{ 16 * 999.99        , 0x30, },
+};
+
+static struct tuner_params tuner_temic_pal_dk_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_PAL,
+		.ranges = tuner_temic_pal_dk_ranges,
+		.count  = ARRAY_SIZE(tuner_temic_pal_dk_ranges),
+		.config = 0x8e,
+	},
+};
+
+/* ------------ TUNER_PHILIPS_NTSC_M - Philips NTSC ------------ */
+
+static struct tuner_range tuner_philips_ntsc_m_ranges[] = {
+	{ 16 * 160.00 /*MHz*/, 0xa0, },
+	{ 16 * 454.00 /*MHz*/, 0x90, },
+	{ 16 * 999.99        , 0x30, },
+};
+
+static struct tuner_params tuner_philips_ntsc_m_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_NTSC,
+		.ranges = tuner_philips_ntsc_m_ranges,
+		.count  = ARRAY_SIZE(tuner_philips_ntsc_m_ranges),
+		.config = 0x8e,
+	},
+};
+
+/* ------------ TUNER_TEMIC_4066FY5_PAL_I - TEMIC PAL_I ------------ */
+
+static struct tuner_range tuner_temic_40x6f_5_pal_ranges[] = {
+	{ 16 * 169.00 /*MHz*/, 0xa0, },
+	{ 16 * 454.00 /*MHz*/, 0x90, },
+	{ 16 * 999.99        , 0x30, },
+};
+
+static struct tuner_params tuner_temic_4066fy5_pal_i_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_PAL,
+		.ranges = tuner_temic_40x6f_5_pal_ranges,
+		.count  = ARRAY_SIZE(tuner_temic_40x6f_5_pal_ranges),
+		.config = 0x8e,
+	},
+};
+
+/* ------------ TUNER_TEMIC_4006FN5_MULTI_PAL - TEMIC PAL ------------ */
+
+static struct tuner_params tuner_temic_4006fn5_multi_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_PAL,
+		.ranges = tuner_temic_40x6f_5_pal_ranges,
+		.count  = ARRAY_SIZE(tuner_temic_40x6f_5_pal_ranges),
+		.config = 0x8e,
+	},
+};
+
+/* 20-29 */
+/* ------------ TUNER_TEMIC_4009FR5_PAL - TEMIC PAL ------------ */
+
+static struct tuner_range tuner_temic_4009f_5_pal_ranges[] = {
+	{ 16 * 141.00 /*MHz*/, 0xa0, },
+	{ 16 * 464.00 /*MHz*/, 0x90, },
+	{ 16 * 999.99        , 0x30, },
+};
+
+static struct tuner_params tuner_temic_4009f_5_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_PAL,
+		.ranges = tuner_temic_4009f_5_pal_ranges,
+		.count  = ARRAY_SIZE(tuner_temic_4009f_5_pal_ranges),
+		.config = 0x8e,
+	},
+};
+
+/* ------------ TUNER_TEMIC_4039FR5_NTSC - TEMIC NTSC ------------ */
+
+static struct tuner_range tuner_temic_4039fr5_ntsc_ranges[] = {
+	{ 16 * 158.00 /*MHz*/, 0xa0, },
+	{ 16 * 453.00 /*MHz*/, 0x90, },
+	{ 16 * 999.99        , 0x30, },
+};
+
+static struct tuner_params tuner_temic_4039fr5_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_NTSC,
+		.ranges = tuner_temic_4039fr5_ntsc_ranges,
+		.count  = ARRAY_SIZE(tuner_temic_4039fr5_ntsc_ranges),
+		.config = 0x8e,
+	},
+};
+
+/* ------------ TUNER_TEMIC_4046FM5 - TEMIC PAL ------------ */
+
+static struct tuner_range tuner_temic_4046fm5_pal_ranges[] = {
+	{ 16 * 169.00 /*MHz*/, 0xa0, },
+	{ 16 * 454.00 /*MHz*/, 0x90, },
+	{ 16 * 999.99        , 0x30, },
+};
+
+static struct tuner_params tuner_temic_4046fm5_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_PAL,
+		.ranges = tuner_temic_4046fm5_pal_ranges,
+		.count  = ARRAY_SIZE(tuner_temic_4046fm5_pal_ranges),
+		.config = 0x8e,
+	},
+};
+
+/* ------------ TUNER_PHILIPS_PAL_DK - Philips PAL ------------ */
+
+static struct tuner_range tuner_lg_pal_ranges[] = {
+	{ 16 * 170.00 /*MHz*/, 0xa0, },
+	{ 16 * 450.00 /*MHz*/, 0x90, },
+	{ 16 * 999.99        , 0x30, },
+};
+
+static struct tuner_params tuner_philips_pal_dk_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_PAL,
+		.ranges = tuner_lg_pal_ranges,
+		.count  = ARRAY_SIZE(tuner_lg_pal_ranges),
+		.config = 0x8e,
+	},
+};
+
+/* ------------ TUNER_PHILIPS_FQ1216ME - Philips PAL ------------ */
+
+static struct tuner_params tuner_philips_fq1216me_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_PAL,
+		.ranges = tuner_lg_pal_ranges,
+		.count  = ARRAY_SIZE(tuner_lg_pal_ranges),
+		.config = 0x8e,
+	},
+};
+
+/* ------------ TUNER_LG_PAL_I_FM - LGINNOTEK PAL_I ------------ */
+
+static struct tuner_params tuner_lg_pal_i_fm_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_PAL,
+		.ranges = tuner_lg_pal_ranges,
+		.count  = ARRAY_SIZE(tuner_lg_pal_ranges),
+		.config = 0x8e,
+	},
+};
+
+/* ------------ TUNER_LG_PAL_I - LGINNOTEK PAL_I ------------ */
+
+static struct tuner_params tuner_lg_pal_i_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_PAL,
+		.ranges = tuner_lg_pal_ranges,
+		.count  = ARRAY_SIZE(tuner_lg_pal_ranges),
+		.config = 0x8e,
+	},
+};
+
+/* ------------ TUNER_LG_NTSC_FM - LGINNOTEK NTSC ------------ */
+
+static struct tuner_range tuner_lg_ntsc_fm_ranges[] = {
+	{ 16 * 210.00 /*MHz*/, 0xa0, },
+	{ 16 * 497.00 /*MHz*/, 0x90, },
+	{ 16 * 999.99        , 0x30, },
+};
+
+static struct tuner_params tuner_lg_ntsc_fm_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_NTSC,
+		.ranges = tuner_lg_ntsc_fm_ranges,
+		.count  = ARRAY_SIZE(tuner_lg_ntsc_fm_ranges),
+		.config = 0x8e,
+	},
+};
+
+/* ------------ TUNER_LG_PAL_FM - LGINNOTEK PAL ------------ */
+
+static struct tuner_params tuner_lg_pal_fm_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_PAL,
+		.ranges = tuner_lg_pal_ranges,
+		.count  = ARRAY_SIZE(tuner_lg_pal_ranges),
+		.config = 0x8e,
+	},
+};
+
+/* ------------ TUNER_LG_PAL - LGINNOTEK PAL ------------ */
+
+static struct tuner_params tuner_lg_pal_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_PAL,
+		.ranges = tuner_lg_pal_ranges,
+		.count  = ARRAY_SIZE(tuner_lg_pal_ranges),
+		.config = 0x8e,
+	},
+};
+
+/* 30-39 */
+/* ------------ TUNER_TEMIC_4009FN5_MULTI_PAL_FM - TEMIC PAL ------------ */
+
+static struct tuner_params tuner_temic_4009_fn5_multi_pal_fm_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_PAL,
+		.ranges = tuner_temic_4009f_5_pal_ranges,
+		.count  = ARRAY_SIZE(tuner_temic_4009f_5_pal_ranges),
+		.config = 0x8e,
+	},
+};
+
+/* ------------ TUNER_SHARP_2U5JF5540_NTSC - SHARP NTSC ------------ */
+
+static struct tuner_range tuner_sharp_2u5jf5540_ntsc_ranges[] = {
+	{ 16 * 137.25 /*MHz*/, 0x01, },
+	{ 16 * 317.25 /*MHz*/, 0x02, },
+	{ 16 * 999.99        , 0x08, },
+};
+
+static struct tuner_params tuner_sharp_2u5jf5540_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_NTSC,
+		.ranges = tuner_sharp_2u5jf5540_ntsc_ranges,
+		.count  = ARRAY_SIZE(tuner_sharp_2u5jf5540_ntsc_ranges),
+		.config = 0x8e,
+	},
+};
+
+/* ------------ TUNER_Samsung_PAL_TCPM9091PD27 - Samsung PAL ------------ */
+
+static struct tuner_range tuner_samsung_pal_tcpm9091pd27_ranges[] = {
+	{ 16 * 169 /*MHz*/, 0xa0, },
+	{ 16 * 464 /*MHz*/, 0x90, },
+	{ 16 * 999.99     , 0x30, },
+};
+
+static struct tuner_params tuner_samsung_pal_tcpm9091pd27_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_PAL,
+		.ranges = tuner_samsung_pal_tcpm9091pd27_ranges,
+		.count  = ARRAY_SIZE(tuner_samsung_pal_tcpm9091pd27_ranges),
+		.config = 0x8e,
+	},
+};
+
+/* ------------ TUNER_TEMIC_4106FH5 - TEMIC PAL ------------ */
+
+static struct tuner_params tuner_temic_4106fh5_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_PAL,
+		.ranges = tuner_temic_4009f_5_pal_ranges,
+		.count  = ARRAY_SIZE(tuner_temic_4009f_5_pal_ranges),
+		.config = 0x8e,
+	},
+};
+
+/* ------------ TUNER_TEMIC_4012FY5 - TEMIC PAL ------------ */
+
+static struct tuner_range tuner_temic_4012fy5_pal_ranges[] = {
+	{ 16 * 140.25 /*MHz*/, 0x02, },
+	{ 16 * 463.25 /*MHz*/, 0x04, },
+	{ 16 * 999.99        , 0x01, },
+};
+
+static struct tuner_params tuner_temic_4012fy5_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_PAL,
+		.ranges = tuner_temic_4012fy5_pal_ranges,
+		.count  = ARRAY_SIZE(tuner_temic_4012fy5_pal_ranges),
+		.config = 0x8e,
+	},
+};
+
+/* ------------ TUNER_TEMIC_4136FY5 - TEMIC NTSC ------------ */
+
+static struct tuner_range tuner_temic_4136_fy5_ntsc_ranges[] = {
+	{ 16 * 158.00 /*MHz*/, 0xa0, },
+	{ 16 * 453.00 /*MHz*/, 0x90, },
+	{ 16 * 999.99        , 0x30, },
+};
+
+static struct tuner_params tuner_temic_4136_fy5_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_NTSC,
+		.ranges = tuner_temic_4136_fy5_ntsc_ranges,
+		.count  = ARRAY_SIZE(tuner_temic_4136_fy5_ntsc_ranges),
+		.config = 0x8e,
+	},
+};
+
+/* ------------ TUNER_LG_PAL_NEW_TAPC - LGINNOTEK PAL ------------ */
+
+static struct tuner_range tuner_lg_new_tapc_ranges[] = {
+	{ 16 * 170.00 /*MHz*/, 0x01, },
+	{ 16 * 450.00 /*MHz*/, 0x02, },
+	{ 16 * 999.99        , 0x08, },
+};
+
+static struct tuner_params tuner_lg_pal_new_tapc_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_PAL,
+		.ranges = tuner_lg_new_tapc_ranges,
+		.count  = ARRAY_SIZE(tuner_lg_new_tapc_ranges),
+		.config = 0x8e,
+	},
+};
+
+/* ------------ TUNER_PHILIPS_FM1216ME_MK3 - Philips PAL ------------ */
+
+static struct tuner_range tuner_fm1216me_mk3_pal_ranges[] = {
+	{ 16 * 158.00 /*MHz*/, 0x01, },
+	{ 16 * 442.00 /*MHz*/, 0x02, },
+	{ 16 * 999.99        , 0x04, },
+};
+
+static struct tuner_params tuner_fm1216me_mk3_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_PAL,
+		.ranges = tuner_fm1216me_mk3_pal_ranges,
+		.count  = ARRAY_SIZE(tuner_fm1216me_mk3_pal_ranges),
+		.config = 0x8e,
+	},
+};
+
+/* ------------ TUNER_LG_NTSC_NEW_TAPC - LGINNOTEK NTSC ------------ */
+
+static struct tuner_params tuner_lg_ntsc_new_tapc_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_NTSC,
+		.ranges = tuner_lg_new_tapc_ranges,
+		.count  = ARRAY_SIZE(tuner_lg_new_tapc_ranges),
+		.config = 0x8e,
+	},
+};
+
+/* 40-49 */
+/* ------------ TUNER_HITACHI_NTSC - HITACHI NTSC ------------ */
+
+static struct tuner_params tuner_hitachi_ntsc_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_NTSC,
+		.ranges = tuner_lg_new_tapc_ranges,
+		.count  = ARRAY_SIZE(tuner_lg_new_tapc_ranges),
+		.config = 0x8e,
+	},
+};
+
+/* ------------ TUNER_PHILIPS_PAL_MK - Philips PAL ------------ */
+
+static struct tuner_range tuner_philips_pal_mk_pal_ranges[] = {
+	{ 16 * 140.25 /*MHz*/, 0x01, },
+	{ 16 * 463.25 /*MHz*/, 0xc2, },
+	{ 16 * 999.99        , 0xcf, },
+};
+
+static struct tuner_params tuner_philips_pal_mk_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_PAL,
+		.ranges = tuner_philips_pal_mk_pal_ranges,
+		.count  = ARRAY_SIZE(tuner_philips_pal_mk_pal_ranges),
+		.config = 0x8e,
+	},
+};
+
+/* ------------ TUNER_PHILIPS_ATSC - Philips ATSC ------------ */
+
+static struct tuner_range tuner_philips_atsc_ranges[] = {
+	{ 16 * 157.25 /*MHz*/, 0xa0, },
+	{ 16 * 454.00 /*MHz*/, 0x90, },
+	{ 16 * 999.99        , 0x30, },
+};
+
+static struct tuner_params tuner_philips_atsc_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_NTSC,
+		.ranges = tuner_philips_atsc_ranges,
+		.count  = ARRAY_SIZE(tuner_philips_atsc_ranges),
+		.config = 0x8e,
+	},
+};
+
+/* ------------ TUNER_PHILIPS_FM1236_MK3 - Philips NTSC ------------ */
+
+static struct tuner_range tuner_fm1236_mk3_ntsc_ranges[] = {
+	{ 16 * 160.00 /*MHz*/, 0x01, },
+	{ 16 * 442.00 /*MHz*/, 0x02, },
+	{ 16 * 999.99        , 0x04, },
+};
+
+static struct tuner_params tuner_fm1236_mk3_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_NTSC,
+		.ranges = tuner_fm1236_mk3_ntsc_ranges,
+		.count  = ARRAY_SIZE(tuner_fm1236_mk3_ntsc_ranges),
+		.config = 0x8e,
+	},
+};
+
+/* ------------ TUNER_PHILIPS_4IN1 - Philips NTSC ------------ */
+
+static struct tuner_range tuner_philips_4in1_ntsc_ranges[] = {
+	{ 16 * 160.00 /*MHz*/, 0x01, },
+	{ 16 * 442.00 /*MHz*/, 0x02, },
+	{ 16 * 999.99        , 0x04, },
+};
+
+static struct tuner_params tuner_philips_4in1_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_NTSC,
+		.ranges = tuner_philips_4in1_ntsc_ranges,
+		.count  = ARRAY_SIZE(tuner_philips_4in1_ntsc_ranges),
+		.config = 0x8e,
+	},
+};
+
+/* ------------ TUNER_MICROTUNE_4049FM5 - Microtune PAL ------------ */
+
+static struct tuner_params tuner_microtune_4049_fm5_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_PAL,
+		.ranges = tuner_temic_4009f_5_pal_ranges,
+		.count  = ARRAY_SIZE(tuner_temic_4009f_5_pal_ranges),
+		.config = 0x8e,
+	},
+};
+
+/* ------------ TUNER_PANASONIC_VP27 - Panasonic NTSC ------------ */
+
+static struct tuner_range tuner_panasonic_vp27_ntsc_ranges[] = {
+	{ 16 * 160.00 /*MHz*/, 0x01, },
+	{ 16 * 454.00 /*MHz*/, 0x02, },
+	{ 16 * 999.99        , 0x08, },
+};
+
+static struct tuner_params tuner_panasonic_vp27_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_NTSC,
+		.ranges = tuner_panasonic_vp27_ntsc_ranges,
+		.count  = ARRAY_SIZE(tuner_panasonic_vp27_ntsc_ranges),
+		.config = 0xce,
+	},
+};
+
+/* ------------ TUNER_LG_NTSC_TAPE - LGINNOTEK NTSC ------------ */
+
+static struct tuner_range tuner_lg_ntsc_tape_ranges[] = {
+	{ 16 * 160.00 /*MHz*/, 0x01, },
+	{ 16 * 442.00 /*MHz*/, 0x02, },
+	{ 16 * 999.99        , 0x04, },
+};
+
+static struct tuner_params tuner_lg_ntsc_tape_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_NTSC,
+		.ranges = tuner_lg_ntsc_tape_ranges,
+		.count  = ARRAY_SIZE(tuner_lg_ntsc_tape_ranges),
+		.config = 0x8e,
+	},
+};
+
+/* ------------ TUNER_TNF_8831BGFF - Philips PAL ------------ */
+
+static struct tuner_range tuner_tnf_8831bgff_pal_ranges[] = {
+	{ 16 * 161.25 /*MHz*/, 0xa0, },
+	{ 16 * 463.25 /*MHz*/, 0x90, },
+	{ 16 * 999.99        , 0x30, },
+};
+
+static struct tuner_params tuner_tnf_8831bgff_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_PAL,
+		.ranges = tuner_tnf_8831bgff_pal_ranges,
+		.count  = ARRAY_SIZE(tuner_tnf_8831bgff_pal_ranges),
+		.config = 0x8e,
+	},
+};
+
+/* ------------ TUNER_MICROTUNE_4042FI5 - Microtune NTSC ------------ */
+
+static struct tuner_range tuner_microtune_4042fi5_ntsc_ranges[] = {
+	{ 16 * 162.00 /*MHz*/, 0xa2, },
+	{ 16 * 457.00 /*MHz*/, 0x94, },
+	{ 16 * 999.99        , 0x31, },
+};
+
+static struct tuner_params tuner_microtune_4042fi5_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_NTSC,
+		.ranges = tuner_microtune_4042fi5_ntsc_ranges,
+		.count  = ARRAY_SIZE(tuner_microtune_4042fi5_ntsc_ranges),
+		.config = 0x8e,
+	},
+};
+
+/* 50-59 */
+/* ------------ TUNER_TCL_2002N - TCL NTSC ------------ */
+
+static struct tuner_range tuner_tcl_2002n_ntsc_ranges[] = {
+	{ 16 * 172.00 /*MHz*/, 0x01, },
+	{ 16 * 448.00 /*MHz*/, 0x02, },
+	{ 16 * 999.99        , 0x08, },
+};
+
+static struct tuner_params tuner_tcl_2002n_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_NTSC,
+		.ranges = tuner_tcl_2002n_ntsc_ranges,
+		.count  = ARRAY_SIZE(tuner_tcl_2002n_ntsc_ranges),
+		.config = 0x8e,
+	},
+};
+
+/* ------------ TUNER_PHILIPS_FM1256_IH3 - Philips PAL ------------ */
+
+static struct tuner_range tuner_philips_fm1256_ih3_pal_ranges[] = {
+	{ 16 * 160.00 /*MHz*/, 0x01, },
+	{ 16 * 442.00 /*MHz*/, 0x02, },
+	{ 16 * 999.99        , 0x04, },
+};
+
+static struct tuner_params tuner_philips_fm1256_ih3_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_PAL,
+		.ranges = tuner_philips_fm1256_ih3_pal_ranges,
+		.count  = ARRAY_SIZE(tuner_philips_fm1256_ih3_pal_ranges),
+		.config = 0x8e,
+	},
+};
+
+/* ------------ TUNER_THOMSON_DTT7610 - THOMSON ATSC ------------ */
+
+static struct tuner_range tuner_thomson_dtt7610_ntsc_ranges[] = {
+	{ 16 * 157.25 /*MHz*/, 0x39, },
+	{ 16 * 454.00 /*MHz*/, 0x3a, },
+	{ 16 * 999.99        , 0x3c, },
+};
+
+static struct tuner_params tuner_thomson_dtt7610_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_NTSC,
+		.ranges = tuner_thomson_dtt7610_ntsc_ranges,
+		.count  = ARRAY_SIZE(tuner_thomson_dtt7610_ntsc_ranges),
+		.config = 0x8e,
+	},
+};
+
+/* ------------ TUNER_PHILIPS_FQ1286 - Philips NTSC ------------ */
+
+static struct tuner_range tuner_philips_fq1286_ntsc_ranges[] = {
+	{ 16 * 160.00 /*MHz*/, 0x41, },
+	{ 16 * 454.00 /*MHz*/, 0x42, },
+	{ 16 * 999.99        , 0x04, },
+};
+
+static struct tuner_params tuner_philips_fq1286_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_NTSC,
+		.ranges = tuner_philips_fq1286_ntsc_ranges,
+		.count  = ARRAY_SIZE(tuner_philips_fq1286_ntsc_ranges),
+		.config = 0x8e,
+	},
+};
+
+/* ------------ TUNER_TCL_2002MB - TCL PAL ------------ */
+
+static struct tuner_range tuner_tcl_2002mb_pal_ranges[] = {
+	{ 16 * 170.00 /*MHz*/, 0x01, },
+	{ 16 * 450.00 /*MHz*/, 0x02, },
+	{ 16 * 999.99        , 0x08, },
+};
+
+static struct tuner_params tuner_tcl_2002mb_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_PAL,
+		.ranges = tuner_tcl_2002mb_pal_ranges,
+		.count  = ARRAY_SIZE(tuner_tcl_2002mb_pal_ranges),
+		.config = 0xce,
+	},
+};
+
+/* ------------ TUNER_PHILIPS_FQ1216AME_MK4 - Philips PAL ------------ */
+
+static struct tuner_range tuner_philips_fq12_6a___mk4_ranges[] = {
+	{ 16 * 160.00 /*MHz*/, 0x01, },
+	{ 16 * 442.00 /*MHz*/, 0x02, },
+	{ 16 * 999.99        , 0x04, },
+};
+
+static struct tuner_params tuner_philips_fq1216ame_mk4_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_PAL,
+		.ranges = tuner_philips_fq12_6a___mk4_ranges,
+		.count  = ARRAY_SIZE(tuner_philips_fq12_6a___mk4_ranges),
+		.config = 0xce,
+	},
+};
+
+/* ------------ TUNER_PHILIPS_FQ1236A_MK4 - Philips NTSC ------------ */
+
+static struct tuner_params tuner_philips_fq1236a_mk4_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_NTSC,
+		.ranges = tuner_philips_fq12_6a___mk4_ranges,
+		.count  = ARRAY_SIZE(tuner_philips_fq12_6a___mk4_ranges),
+		.config = 0x8e,
+	},
+};
+
+/* ------------ TUNER_YMEC_TVF_8531MF - Philips NTSC ------------ */
+
+static struct tuner_range tuner_ymec_tvf_8531mf_ntsc_ranges[] = {
+	{ 16 * 160.00 /*MHz*/, 0xa0, },
+	{ 16 * 454.00 /*MHz*/, 0x90, },
+	{ 16 * 999.99        , 0x30, },
+};
+
+static struct tuner_params tuner_ymec_tvf_8531mf_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_NTSC,
+		.ranges = tuner_ymec_tvf_8531mf_ntsc_ranges,
+		.count  = ARRAY_SIZE(tuner_ymec_tvf_8531mf_ntsc_ranges),
+		.config = 0x8e,
+	},
+};
+
+/* ------------ TUNER_YMEC_TVF_5533MF - Philips NTSC ------------ */
+
+static struct tuner_range tuner_ymec_tvf_5533mf_ntsc_ranges[] = {
+	{ 16 * 160.00 /*MHz*/, 0x01, },
+	{ 16 * 454.00 /*MHz*/, 0x02, },
+	{ 16 * 999.99        , 0x04, },
+};
+
+static struct tuner_params tuner_ymec_tvf_5533mf_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_NTSC,
+		.ranges = tuner_ymec_tvf_5533mf_ntsc_ranges,
+		.count  = ARRAY_SIZE(tuner_ymec_tvf_5533mf_ntsc_ranges),
+		.config = 0x8e,
+	},
+};
+
+/* 60-69 */
+/* ------------ TUNER_THOMSON_DTT761X - THOMSON ATSC ------------ */
+/* DTT 7611 7611A 7612 7613 7613A 7614 7615 7615A */
+
+static struct tuner_range tuner_thomson_dtt761x_ntsc_ranges[] = {
+	{ 16 * 145.25 /*MHz*/, 0x39, },
+	{ 16 * 415.25 /*MHz*/, 0x3a, },
+	{ 16 * 999.99        , 0x3c, },
+};
+
+
+static struct tuner_params tuner_thomson_dtt761x_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_NTSC,
+		.ranges = tuner_thomson_dtt761x_ntsc_ranges,
+		.count  = ARRAY_SIZE(tuner_thomson_dtt761x_ntsc_ranges),
+		.config = 0x8e,
+	},
+};
+
+/* ------------ TUNER_TENA_9533_DI - Philips PAL ------------ */
+
+static struct tuner_range tuner_tuner_tena_9533_di_pal_ranges[] = {
+	{ 16 * 160.25 /*MHz*/, 0x01, },
+	{ 16 * 464.25 /*MHz*/, 0x02, },
+	{ 16 * 999.99        , 0x04, },
+};
+
+static struct tuner_params tuner_tena_9533_di_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_PAL,
+		.ranges = tuner_tuner_tena_9533_di_pal_ranges,
+		.count  = ARRAY_SIZE(tuner_tuner_tena_9533_di_pal_ranges),
+		.config = 0x8e,
+	},
+};
+
+/* ------------ TUNER_PHILIPS_FMD1216ME_MK3 - Philips PAL ------------ */
+
+static struct tuner_range tuner_philips_fmd1216me_mk3_pal_ranges[] = {
+	{ 16 * 160.00 /*MHz*/, 0x51, },
+	{ 16 * 442.00 /*MHz*/, 0x52, },
+	{ 16 * 999.99        , 0x54, },
+};
+
+
+static struct tuner_params tuner_tuner_philips_fmd1216me_mk3_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_PAL,
+		.ranges = tuner_philips_fmd1216me_mk3_pal_ranges,
+		.count  = ARRAY_SIZE(tuner_philips_fmd1216me_mk3_pal_ranges),
+		.config = 0x86,
+	},
+};
+
+
+/* ------------ TUNER_LG_TDVS_H062F - INFINEON ATSC ------------ */
+
+static struct tuner_range tuner_tua6034_ntsc_ranges[] = {
+	{ 16 * 160.00 /*MHz*/, 0x01 },
+	{ 16 * 455.00 /*MHz*/, 0x02 },
+	{ 16 * 999.99        , 0x04 },
+};
+
+
+static struct tuner_params tuner_tua6034_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_NTSC,
+		.ranges = tuner_tua6034_ntsc_ranges,
+		.count  = ARRAY_SIZE(tuner_tua6034_ntsc_ranges),
+		.config = 0x8e,
+	},
+};
+
+/* ------------ TUNER_YMEC_TVF66T5_B_DFF - Philips PAL ------------ */
+
+static struct tuner_range tuner_ymec_tvf66t5_b_dff_pal_ranges[] = {
+	{ 16 * 160.25 /*MHz*/, 0x01, },
+	{ 16 * 464.25 /*MHz*/, 0x02, },
+	{ 16 * 999.99        , 0x08, },
+};
+
+static struct tuner_params tuner_ymec_tvf66t5_b_dff_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_PAL,
+		.ranges = tuner_ymec_tvf66t5_b_dff_pal_ranges,
+		.count  = ARRAY_SIZE(tuner_ymec_tvf66t5_b_dff_pal_ranges),
+		.config = 0x8e,
+	},
+};
+
+/* ------------ TUNER_LG_NTSC_TALN_MINI - LGINNOTEK NTSC ------------ */
+
+static struct tuner_range tuner_lg_taln_mini_ntsc_ranges[] = {
+	{ 16 * 137.25 /*MHz*/, 0x01, },
+	{ 16 * 373.25 /*MHz*/, 0x02, },
+	{ 16 * 999.99        , 0x08, },
+};
+
+static struct tuner_params tuner_lg_taln_mini_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_NTSC,
+		.ranges = tuner_lg_taln_mini_ntsc_ranges,
+		.count  = ARRAY_SIZE(tuner_lg_taln_mini_ntsc_ranges),
+		.config = 0x8e,
+	},
+};
+
+/* ------------ TUNER_PHILIPS_TD1316 - Philips PAL ------------ */
+
+static struct tuner_range tuner_philips_td1316_pal_ranges[] = {
+	{ 16 * 160.00 /*MHz*/, 0xa1, },
+	{ 16 * 442.00 /*MHz*/, 0xa2, },
+	{ 16 * 999.99        , 0xa4, },
+};
+
+static struct tuner_params tuner_philips_td1316_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_PAL,
+		.ranges = tuner_philips_td1316_pal_ranges,
+		.count  = ARRAY_SIZE(tuner_philips_td1316_pal_ranges),
+		.config = 0xc8,
+	},
+};
+
+/* ------------ TUNER_PHILIPS_TUV1236D - Philips ATSC ------------ */
+
+static struct tuner_range tuner_tuv1236d_ntsc_ranges[] = {
+	{ 16 * 157.25 /*MHz*/, 0x01, },
+	{ 16 * 454.00 /*MHz*/, 0x02, },
+	{ 16 * 999.99        , 0x04, },
+};
+
+
+static struct tuner_params tuner_tuner_tuv1236d_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_NTSC,
+		.ranges = tuner_tuv1236d_ntsc_ranges,
+		.count  = ARRAY_SIZE(tuner_tuv1236d_ntsc_ranges),
+		.config = 0xce,
+	},
+};
+
+/* ------------ TUNER_TNF_5335MF - Philips NTSC ------------ */
+
+static struct tuner_range tuner_tnf_5335mf_ntsc_ranges[] = {
+	{ 16 * 157.25 /*MHz*/, 0x01, },
+	{ 16 * 454.00 /*MHz*/, 0x02, },
+	{ 16 * 999.99        , 0x04, },
+};
+
+static struct tuner_params tuner_tnf_5335mf_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_NTSC,
+		.ranges = tuner_tnf_5335mf_ntsc_ranges,
+		.count  = ARRAY_SIZE(tuner_tnf_5335mf_ntsc_ranges),
+		.config = 0x8e,
+	},
+};
+
+/* --------------------------------------------------------------------- */
+
+struct tunertype tuners[] = {
+	/* 0-9 */
+	[TUNER_TEMIC_PAL] = { /* TEMIC PAL */
+		.name   = "Temic PAL (4002 FH5)",
+		.params = tuner_temic_pal_params,
+	},
+	[TUNER_PHILIPS_PAL_I] = { /* Philips PAL_I */
+		.name   = "Philips PAL_I (FI1246 and compatibles)",
+		.params = tuner_philips_pal_i_params,
+	},
+	[TUNER_PHILIPS_NTSC] = { /* Philips NTSC */
+		.name   = "Philips NTSC (FI1236,FM1236 and compatibles)",
+		.params = tuner_philips_ntsc_params,
+	},
+	[TUNER_PHILIPS_SECAM] = { /* Philips SECAM */
+		.name   = "Philips (SECAM+PAL_BG) (FI1216MF, FM1216MF, FR1216MF)",
+		.params = tuner_philips_secam_params,
+	},
+	[TUNER_ABSENT] = { /* Tuner Absent */
+		.name   = "NoTuner",
+	},
+	[TUNER_PHILIPS_PAL] = { /* Philips PAL */
+		.name   = "Philips PAL_BG (FI1216 and compatibles)",
+		.params = tuner_philips_pal_params,
+	},
+	[TUNER_TEMIC_NTSC] = { /* TEMIC NTSC */
+		.name   = "Temic NTSC (4032 FY5)",
+		.params = tuner_temic_ntsc_params,
+	},
+	[TUNER_TEMIC_PAL_I] = { /* TEMIC PAL_I */
+		.name   = "Temic PAL_I (4062 FY5)",
+		.params = tuner_temic_pal_i_params,
+	},
+	[TUNER_TEMIC_4036FY5_NTSC] = { /* TEMIC NTSC */
+		.name   = "Temic NTSC (4036 FY5)",
+		.params = tuner_temic_4036fy5_ntsc_params,
+	},
+	[TUNER_ALPS_TSBH1_NTSC] = { /* TEMIC NTSC */
+		.name   = "Alps HSBH1",
+		.params = tuner_alps_tsbh1_ntsc_params,
+	},
+
+	/* 10-19 */
+	[TUNER_ALPS_TSBE1_PAL] = { /* TEMIC PAL */
+		.name   = "Alps TSBE1",
+		.params = tuner_alps_tsb_1_params,
+	},
+	[TUNER_ALPS_TSBB5_PAL_I] = { /* Alps PAL_I */
+		.name   = "Alps TSBB5",
+		.params = tuner_alps_tsbb5_params,
+	},
+	[TUNER_ALPS_TSBE5_PAL] = { /* Alps PAL */
+		.name   = "Alps TSBE5",
+		.params = tuner_alps_tsbe5_params,
+	},
+	[TUNER_ALPS_TSBC5_PAL] = { /* Alps PAL */
+		.name   = "Alps TSBC5",
+		.params = tuner_alps_tsbc5_params,
+	},
+	[TUNER_TEMIC_4006FH5_PAL] = { /* TEMIC PAL */
+		.name   = "Temic PAL_BG (4006FH5)",
+		.params = tuner_temic_4006fh5_params,
+	},
+	[TUNER_ALPS_TSHC6_NTSC] = { /* Alps NTSC */
+		.name   = "Alps TSCH6",
+		.params = tuner_alps_tshc6_params,
+	},
+	[TUNER_TEMIC_PAL_DK] = { /* TEMIC PAL */
+		.name   = "Temic PAL_DK (4016 FY5)",
+		.params = tuner_temic_pal_dk_params,
+	},
+	[TUNER_PHILIPS_NTSC_M] = { /* Philips NTSC */
+		.name   = "Philips NTSC_M (MK2)",
+		.params = tuner_philips_ntsc_m_params,
+	},
+	[TUNER_TEMIC_4066FY5_PAL_I] = { /* TEMIC PAL_I */
+		.name   = "Temic PAL_I (4066 FY5)",
+		.params = tuner_temic_4066fy5_pal_i_params,
+	},
+	[TUNER_TEMIC_4006FN5_MULTI_PAL] = { /* TEMIC PAL */
+		.name   = "Temic PAL* auto (4006 FN5)",
+		.params = tuner_temic_4006fn5_multi_params,
+	},
+
+	/* 20-29 */
+	[TUNER_TEMIC_4009FR5_PAL] = { /* TEMIC PAL */
+		.name   = "Temic PAL_BG (4009 FR5) or PAL_I (4069 FR5)",
+		.params = tuner_temic_4009f_5_params,
+	},
+	[TUNER_TEMIC_4039FR5_NTSC] = { /* TEMIC NTSC */
+		.name   = "Temic NTSC (4039 FR5)",
+		.params = tuner_temic_4039fr5_params,
+	},
+	[TUNER_TEMIC_4046FM5] = { /* TEMIC PAL */
+		.name   = "Temic PAL/SECAM multi (4046 FM5)",
+		.params = tuner_temic_4046fm5_params,
+	},
+	[TUNER_PHILIPS_PAL_DK] = { /* Philips PAL */
+		.name   = "Philips PAL_DK (FI1256 and compatibles)",
+		.params = tuner_philips_pal_dk_params,
+	},
+	[TUNER_PHILIPS_FQ1216ME] = { /* Philips PAL */
+		.name   = "Philips PAL/SECAM multi (FQ1216ME)",
+		.params = tuner_philips_fq1216me_params,
+	},
+	[TUNER_LG_PAL_I_FM] = { /* LGINNOTEK PAL_I */
+		.name   = "LG PAL_I+FM (TAPC-I001D)",
+		.params = tuner_lg_pal_i_fm_params,
+	},
+	[TUNER_LG_PAL_I] = { /* LGINNOTEK PAL_I */
+		.name   = "LG PAL_I (TAPC-I701D)",
+		.params = tuner_lg_pal_i_params,
+	},
+	[TUNER_LG_NTSC_FM] = { /* LGINNOTEK NTSC */
+		.name   = "LG NTSC+FM (TPI8NSR01F)",
+		.params = tuner_lg_ntsc_fm_params,
+	},
+	[TUNER_LG_PAL_FM] = { /* LGINNOTEK PAL */
+		.name   = "LG PAL_BG+FM (TPI8PSB01D)",
+		.params = tuner_lg_pal_fm_params,
+	},
+	[TUNER_LG_PAL] = { /* LGINNOTEK PAL */
+		.name   = "LG PAL_BG (TPI8PSB11D)",
+		.params = tuner_lg_pal_params,
+	},
+
+	/* 30-39 */
+	[TUNER_TEMIC_4009FN5_MULTI_PAL_FM] = { /* TEMIC PAL */
+		.name   = "Temic PAL* auto + FM (4009 FN5)",
+		.params = tuner_temic_4009_fn5_multi_pal_fm_params,
+	},
+	[TUNER_SHARP_2U5JF5540_NTSC] = { /* SHARP NTSC */
+		.name   = "SHARP NTSC_JP (2U5JF5540)",
+		.params = tuner_sharp_2u5jf5540_params,
+	},
+	[TUNER_Samsung_PAL_TCPM9091PD27] = { /* Samsung PAL */
+		.name   = "Samsung PAL TCPM9091PD27",
+		.params = tuner_samsung_pal_tcpm9091pd27_params,
+	},
+	[TUNER_MT2032] = { /* Microtune PAL|NTSC */
+		.name   = "MT20xx universal",
+		/* see mt20xx.c for details */ },
+	[TUNER_TEMIC_4106FH5] = { /* TEMIC PAL */
+		.name   = "Temic PAL_BG (4106 FH5)",
+		.params = tuner_temic_4106fh5_params,
+	},
+	[TUNER_TEMIC_4012FY5] = { /* TEMIC PAL */
+		.name   = "Temic PAL_DK/SECAM_L (4012 FY5)",
+		.params = tuner_temic_4012fy5_params,
+	},
+	[TUNER_TEMIC_4136FY5] = { /* TEMIC NTSC */
+		.name   = "Temic NTSC (4136 FY5)",
+		.params = tuner_temic_4136_fy5_params,
+	},
+	[TUNER_LG_PAL_NEW_TAPC] = { /* LGINNOTEK PAL */
+		.name   = "LG PAL (newer TAPC series)",
+		.params = tuner_lg_pal_new_tapc_params,
+	},
+	[TUNER_PHILIPS_FM1216ME_MK3] = { /* Philips PAL */
+		.name   = "Philips PAL/SECAM multi (FM1216ME MK3)",
+		.params = tuner_fm1216me_mk3_params,
+	},
+	[TUNER_LG_NTSC_NEW_TAPC] = { /* LGINNOTEK NTSC */
+		.name   = "LG NTSC (newer TAPC series)",
+		.params = tuner_lg_ntsc_new_tapc_params,
+	},
+
+	/* 40-49 */
+	[TUNER_HITACHI_NTSC] = { /* HITACHI NTSC */
+		.name   = "HITACHI V7-J180AT",
+		.params = tuner_hitachi_ntsc_params,
+	},
+	[TUNER_PHILIPS_PAL_MK] = { /* Philips PAL */
+		.name   = "Philips PAL_MK (FI1216 MK)",
+		.params = tuner_philips_pal_mk_params,
+	},
+	[TUNER_PHILIPS_ATSC] = { /* Philips ATSC */
+		.name   = "Philips 1236D ATSC/NTSC dual in",
+		.params = tuner_philips_atsc_params,
+	},
+	[TUNER_PHILIPS_FM1236_MK3] = { /* Philips NTSC */
+		.name   = "Philips NTSC MK3 (FM1236MK3 or FM1236/F)",
+		.params = tuner_fm1236_mk3_params,
+	},
+	[TUNER_PHILIPS_4IN1] = { /* Philips NTSC */
+		.name   = "Philips 4 in 1 (ATI TV Wonder Pro/Conexant)",
+		.params = tuner_philips_4in1_params,
+	},
+	[TUNER_MICROTUNE_4049FM5] = { /* Microtune PAL */
+		.name   = "Microtune 4049 FM5",
+		.params = tuner_microtune_4049_fm5_params,
+	},
+	[TUNER_PANASONIC_VP27] = { /* Panasonic NTSC */
+		.name   = "Panasonic VP27s/ENGE4324D",
+		.params = tuner_panasonic_vp27_params,
+	},
+	[TUNER_LG_NTSC_TAPE] = { /* LGINNOTEK NTSC */
+		.name   = "LG NTSC (TAPE series)",
+		.params = tuner_lg_ntsc_tape_params,
+	},
+	[TUNER_TNF_8831BGFF] = { /* Philips PAL */
+		.name   = "Tenna TNF 8831 BGFF)",
+		.params = tuner_tnf_8831bgff_params,
+	},
+	[TUNER_MICROTUNE_4042FI5] = { /* Microtune NTSC */
+		.name   = "Microtune 4042 FI5 ATSC/NTSC dual in",
+		.params = tuner_microtune_4042fi5_params,
+	},
+
+	/* 50-59 */
+	[TUNER_TCL_2002N] = { /* TCL NTSC */
+		.name   = "TCL 2002N",
+		.params = tuner_tcl_2002n_params,
+	},
+	[TUNER_PHILIPS_FM1256_IH3] = { /* Philips PAL */
+		.name   = "Philips PAL/SECAM_D (FM 1256 I-H3)",
+		.params = tuner_philips_fm1256_ih3_params,
+	},
+	[TUNER_THOMSON_DTT7610] = { /* THOMSON ATSC */
+		.name   = "Thomson DTT 7610 (ATSC/NTSC)",
+		.params = tuner_thomson_dtt7610_params,
+	},
+	[TUNER_PHILIPS_FQ1286] = { /* Philips NTSC */
+		.name   = "Philips FQ1286",
+		.params = tuner_philips_fq1286_params,
+	},
+	[TUNER_PHILIPS_TDA8290] = { /* Philips PAL|NTSC */
+		.name   = "tda8290+75",
+		/* see tda8290.c for details */ },
+	[TUNER_TCL_2002MB] = { /* TCL PAL */
+		.name   = "TCL 2002MB",
+		.params = tuner_tcl_2002mb_params,
+	},
+	[TUNER_PHILIPS_FQ1216AME_MK4] = { /* Philips PAL */
+		.name   = "Philips PAL/SECAM multi (FQ1216AME MK4)",
+		.params = tuner_philips_fq1216ame_mk4_params,
+	},
+	[TUNER_PHILIPS_FQ1236A_MK4] = { /* Philips NTSC */
+		.name   = "Philips FQ1236A MK4",
+		.params = tuner_philips_fq1236a_mk4_params,
+	},
+	[TUNER_YMEC_TVF_8531MF] = { /* Philips NTSC */
+		.name   = "Ymec TVision TVF-8531MF/8831MF/8731MF",
+		.params = tuner_ymec_tvf_8531mf_params,
+	},
+	[TUNER_YMEC_TVF_5533MF] = { /* Philips NTSC */
+		.name   = "Ymec TVision TVF-5533MF",
+		.params = tuner_ymec_tvf_5533mf_params,
+	},
+
+	/* 60-69 */
+	[TUNER_THOMSON_DTT761X] = { /* THOMSON ATSC */
+		/* DTT 7611 7611A 7612 7613 7613A 7614 7615 7615A */
+		.name   = "Thomson DTT 761X (ATSC/NTSC)",
+		.params = tuner_thomson_dtt761x_params,
+	},
+	[TUNER_TENA_9533_DI] = { /* Philips PAL */
+		.name   = "Tena TNF9533-D/IF/TNF9533-B/DF",
+		.params = tuner_tena_9533_di_params,
+	},
+	[TUNER_TEA5767] = { /* Philips RADIO */
+		.name   = "Philips TEA5767HN FM Radio",
+		/* see tea5767.c for details */
+	},
+	[TUNER_PHILIPS_FMD1216ME_MK3] = { /* Philips PAL */
+		.name   = "Philips FMD1216ME MK3 Hybrid Tuner",
+		.params = tuner_tuner_philips_fmd1216me_mk3_params,
+	},
+	[TUNER_LG_TDVS_H062F] = { /* LGINNOTEK ATSC */
+		.name   = "LG TDVS-H062F/TUA6034",
+		.params = tuner_tua6034_params,
+	},
+	[TUNER_YMEC_TVF66T5_B_DFF] = { /* Philips PAL */
+		.name   = "Ymec TVF66T5-B/DFF",
+		.params = tuner_ymec_tvf66t5_b_dff_params,
+	},
+	[TUNER_LG_NTSC_TALN_MINI] = { /* LGINNOTEK NTSC */
+		.name   = "LG NTSC (TALN mini series)",
+		.params = tuner_lg_taln_mini_params,
+	},
+	[TUNER_PHILIPS_TD1316] = { /* Philips PAL */
+		.name   = "Philips TD1316 Hybrid Tuner",
+		.params = tuner_philips_td1316_params,
+	},
+	[TUNER_PHILIPS_TUV1236D] = { /* Philips ATSC */
+		.name   = "Philips TUV1236D ATSC/NTSC dual in",
+		.params = tuner_tuner_tuv1236d_params,
+	},
+	[TUNER_TNF_5335MF] = { /* Philips NTSC */
+		.name   = "Tena TNF 5335 MF",
+		.params = tuner_tnf_5335mf_params,
+	},
+};
+
+unsigned const int tuner_count = ARRAY_SIZE(tuners);
diff --git a/include/media/tuner-types.h b/include/media/tuner-types.h
new file mode 100644
index 0000000..9f6e4a9
--- /dev/null
+++ b/include/media/tuner-types.h
@@ -0,0 +1,41 @@
+/*
+ * descriptions for simple tuners.
+ */
+
+#ifndef __TUNER_TYPES_H__
+#define __TUNER_TYPES_H__
+
+enum param_type {
+	TUNER_PARAM_TYPE_RADIO, \
+	TUNER_PARAM_TYPE_PAL, \
+	TUNER_PARAM_TYPE_SECAM, \
+	TUNER_PARAM_TYPE_NTSC, \
+	TUNER_PARAM_TYPE_ATSC, \
+	TUNER_PARAM_TYPE_DVBT, \
+	TUNER_PARAM_TYPE_DVBS, \
+	TUNER_PARAM_TYPE_DVBC
+};
+
+struct tuner_range {
+	unsigned short limit;
+	unsigned char cb;
+};
+
+struct tuner_params {
+	enum param_type type;
+	unsigned char config; /* to be moved into struct tuner_range for dvb-pll merge */
+
+	unsigned int count;
+	struct tuner_range *ranges;
+};
+
+struct tunertype {
+	char *name;
+	unsigned int has_tda988x:1;
+	struct tuner_params *params;
+};
+
+extern struct tunertype tuners[];
+extern unsigned const int tuner_count;
+
+#endif
diff --git a/include/media/tuner.h b/include/media/tuner.h
index 27cbf08..c88b506 100644
--- a/include/media/tuner.h
+++ b/include/media/tuner.h
@@ -23,6 +23,7 @@
 #define _TUNER_H
 
 #include <linux/videodev2.h>
+#include <media/tuner-types.h>
 
 #define ADDR_UNSET (255)
 

