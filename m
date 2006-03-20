Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965207AbWCTPRF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965207AbWCTPRF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966477AbWCTPRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:17:04 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:46488 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965207AbWCTPQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:16:59 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Michael Krufky <mkrufky@m1k.net>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 034/141] V4L/DVB (3436): move config byte from tuner_params
	to tuner_range struct.
Date: Mon, 20 Mar 2006 12:08:42 -0300
Message-id: <20060320150842.PS675883000034@infradead.org>
In-Reply-To: <20060320150819.PS760228000000@infradead.org>
References: <20060320150819.PS760228000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Krufky <mkrufky@m1k.net>
Date: 1138043471 -0200

- Move config byte from tuner_params to tuner_range struct.
- dvb tuners must be able to set different config byte for each range.

Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/tuner-simple.c b/drivers/media/video/tuner-simple.c
diff --git a/drivers/media/video/tuner-simple.c b/drivers/media/video/tuner-simple.c
index 2c6410c..6f0d376 100644
--- a/drivers/media/video/tuner-simple.c
+++ b/drivers/media/video/tuner-simple.c
@@ -133,7 +133,7 @@ static int tuner_stereo(struct i2c_clien
 static void default_set_tv_freq(struct i2c_client *c, unsigned int freq)
 {
 	struct tuner *t = i2c_get_clientdata(c);
-	u8 cb, tuneraddr;
+	u8 config, cb, tuneraddr;
 	u16 div;
 	struct tunertype *tun;
 	u8 buffer[4];
@@ -152,6 +152,7 @@ static void default_set_tv_freq(struct i
 				freq, tun->params[j].ranges[i - 1].limit);
 		freq = tun->params[j].ranges[--i].limit;
 	}
+	config = tun->params[j].ranges[i].config;
 	cb     = tun->params[j].ranges[i].cb;
 	/*  i == 0 -> VHF_LO  */
 	/*  i == 1 -> VHF_HI  */
@@ -215,7 +216,7 @@ static void default_set_tv_freq(struct i
 
 	case TUNER_MICROTUNE_4042FI5:
 		/* Set the charge pump for fast tuning */
-		tun->params[j].config |= TUNER_CHARGE_PUMP;
+		config |= TUNER_CHARGE_PUMP;
 		break;
 
 	case TUNER_PHILIPS_TUV1236D:
@@ -276,14 +277,14 @@ static void default_set_tv_freq(struct i
 					div);
 
 	if (tuners[t->type].params->cb_first_if_lower_freq && div < t->last_div) {
-		buffer[0] = tun->params[j].config;
+		buffer[0] = config;
 		buffer[1] = cb;
 		buffer[2] = (div>>8) & 0x7f;
 		buffer[3] = div      & 0xff;
 	} else {
 		buffer[0] = (div>>8) & 0x7f;
 		buffer[1] = div      & 0xff;
-		buffer[2] = tun->params[j].config;
+		buffer[2] = config;
 		buffer[3] = cb;
 	}
 	t->last_div = div;
@@ -312,10 +313,10 @@ static void default_set_tv_freq(struct i
 		}
 
 		/* Set the charge pump for optimized phase noise figure */
-		tun->params[j].config &= ~TUNER_CHARGE_PUMP;
+		config &= ~TUNER_CHARGE_PUMP;
 		buffer[0] = (div>>8) & 0x7f;
 		buffer[1] = div      & 0xff;
-		buffer[2] = tun->params[j].config;
+		buffer[2] = config;
 		buffer[3] = cb;
 		tuner_dbg("tv 0x%02x 0x%02x 0x%02x 0x%02x\n",
 		       buffer[0],buffer[1],buffer[2],buffer[3]);
@@ -337,7 +338,7 @@ static void default_set_radio_freq(struc
 	j = TUNER_PARAM_ANALOG;
 
 	div = (20 * freq / 16000) + (int)(20*10.7); /* IF 10.7 MHz */
-	buffer[2] = (tun->params[j].config & ~TUNER_RATIO_MASK) | TUNER_RATIO_SELECT_50; /* 50 kHz step */
+	buffer[2] = (tun->params[j].ranges[0].config & ~TUNER_RATIO_MASK) | TUNER_RATIO_SELECT_50; /* 50 kHz step */
 
 	switch (t->type) {
 	case TUNER_TENA_9533_DI:
diff --git a/drivers/media/video/tuner-types.c b/drivers/media/video/tuner-types.c
diff --git a/drivers/media/video/tuner-types.c b/drivers/media/video/tuner-types.c
index 6fe7817..d37f833 100644
--- a/drivers/media/video/tuner-types.c
+++ b/drivers/media/video/tuner-types.c
@@ -36,9 +36,9 @@
 /* ------------ TUNER_TEMIC_PAL - TEMIC PAL ------------ */
 
 static struct tuner_range tuner_temic_pal_ranges[] = {
-	{ 16 * 140.25 /*MHz*/, 0x02, },
-	{ 16 * 463.25 /*MHz*/, 0x04, },
-	{ 16 * 999.99        , 0x01, },
+	{ 16 * 140.25 /*MHz*/, 0x8e, 0x02, },
+	{ 16 * 463.25 /*MHz*/, 0x8e, 0x04, },
+	{ 16 * 999.99        , 0x8e, 0x01, },
 };
 
 static struct tuner_params tuner_temic_pal_params[] = {
@@ -46,16 +46,15 @@ static struct tuner_params tuner_temic_p
 		.type   = TUNER_PARAM_TYPE_PAL,
 		.ranges = tuner_temic_pal_ranges,
 		.count  = ARRAY_SIZE(tuner_temic_pal_ranges),
-		.config = 0x8e,
 	},
 };
 
 /* ------------ TUNER_PHILIPS_PAL_I - Philips PAL_I ------------ */
 
 static struct tuner_range tuner_philips_pal_i_ranges[] = {
-	{ 16 * 140.25 /*MHz*/, 0xa0, },
-	{ 16 * 463.25 /*MHz*/, 0x90, },
-	{ 16 * 999.99        , 0x30, },
+	{ 16 * 140.25 /*MHz*/, 0x8e, 0xa0, },
+	{ 16 * 463.25 /*MHz*/, 0x8e, 0x90, },
+	{ 16 * 999.99        , 0x8e, 0x30, },
 };
 
 static struct tuner_params tuner_philips_pal_i_params[] = {
@@ -63,16 +62,15 @@ static struct tuner_params tuner_philips
 		.type   = TUNER_PARAM_TYPE_PAL,
 		.ranges = tuner_philips_pal_i_ranges,
 		.count  = ARRAY_SIZE(tuner_philips_pal_i_ranges),
-		.config = 0x8e,
 	},
 };
 
 /* ------------ TUNER_PHILIPS_NTSC - Philips NTSC ------------ */
 
 static struct tuner_range tuner_philips_ntsc_ranges[] = {
-	{ 16 * 157.25 /*MHz*/, 0xa0, },
-	{ 16 * 451.25 /*MHz*/, 0x90, },
-	{ 16 * 999.99        , 0x30, },
+	{ 16 * 157.25 /*MHz*/, 0x8e, 0xa0, },
+	{ 16 * 451.25 /*MHz*/, 0x8e, 0x90, },
+	{ 16 * 999.99        , 0x8e, 0x30, },
 };
 
 static struct tuner_params tuner_philips_ntsc_params[] = {
@@ -80,7 +78,6 @@ static struct tuner_params tuner_philips
 		.type   = TUNER_PARAM_TYPE_NTSC,
 		.ranges = tuner_philips_ntsc_ranges,
 		.count  = ARRAY_SIZE(tuner_philips_ntsc_ranges),
-		.config = 0x8e,
 		.cb_first_if_lower_freq = 1,
 	},
 };
@@ -88,9 +85,9 @@ static struct tuner_params tuner_philips
 /* ------------ TUNER_PHILIPS_SECAM - Philips SECAM ------------ */
 
 static struct tuner_range tuner_philips_secam_ranges[] = {
-	{ 16 * 168.25 /*MHz*/, 0xa7, },
-	{ 16 * 447.25 /*MHz*/, 0x97, },
-	{ 16 * 999.99        , 0x37, },
+	{ 16 * 168.25 /*MHz*/, 0x8e, 0xa7, },
+	{ 16 * 447.25 /*MHz*/, 0x8e, 0x97, },
+	{ 16 * 999.99        , 0x8e, 0x37, },
 };
 
 static struct tuner_params tuner_philips_secam_params[] = {
@@ -98,7 +95,6 @@ static struct tuner_params tuner_philips
 		.type   = TUNER_PARAM_TYPE_SECAM,
 		.ranges = tuner_philips_secam_ranges,
 		.count  = ARRAY_SIZE(tuner_philips_secam_ranges),
-		.config = 0x8e,
 		.cb_first_if_lower_freq = 1,
 	},
 };
@@ -106,9 +102,9 @@ static struct tuner_params tuner_philips
 /* ------------ TUNER_PHILIPS_PAL - Philips PAL ------------ */
 
 static struct tuner_range tuner_philips_pal_ranges[] = {
-	{ 16 * 168.25 /*MHz*/, 0xa0, },
-	{ 16 * 447.25 /*MHz*/, 0x90, },
-	{ 16 * 999.99        , 0x30, },
+	{ 16 * 168.25 /*MHz*/, 0x8e, 0xa0, },
+	{ 16 * 447.25 /*MHz*/, 0x8e, 0x90, },
+	{ 16 * 999.99        , 0x8e, 0x30, },
 };
 
 static struct tuner_params tuner_philips_pal_params[] = {
@@ -116,7 +112,6 @@ static struct tuner_params tuner_philips
 		.type   = TUNER_PARAM_TYPE_PAL,
 		.ranges = tuner_philips_pal_ranges,
 		.count  = ARRAY_SIZE(tuner_philips_pal_ranges),
-		.config = 0x8e,
 		.cb_first_if_lower_freq = 1,
 	},
 };
@@ -124,9 +119,9 @@ static struct tuner_params tuner_philips
 /* ------------ TUNER_TEMIC_NTSC - TEMIC NTSC ------------ */
 
 static struct tuner_range tuner_temic_ntsc_ranges[] = {
-	{ 16 * 157.25 /*MHz*/, 0x02, },
-	{ 16 * 463.25 /*MHz*/, 0x04, },
-	{ 16 * 999.99        , 0x01, },
+	{ 16 * 157.25 /*MHz*/, 0x8e, 0x02, },
+	{ 16 * 463.25 /*MHz*/, 0x8e, 0x04, },
+	{ 16 * 999.99        , 0x8e, 0x01, },
 };
 
 static struct tuner_params tuner_temic_ntsc_params[] = {
@@ -134,16 +129,15 @@ static struct tuner_params tuner_temic_n
 		.type   = TUNER_PARAM_TYPE_NTSC,
 		.ranges = tuner_temic_ntsc_ranges,
 		.count  = ARRAY_SIZE(tuner_temic_ntsc_ranges),
-		.config = 0x8e,
 	},
 };
 
 /* ------------ TUNER_TEMIC_PAL_I - TEMIC PAL_I ------------ */
 
 static struct tuner_range tuner_temic_pal_i_ranges[] = {
-	{ 16 * 170.00 /*MHz*/, 0x02, },
-	{ 16 * 450.00 /*MHz*/, 0x04, },
-	{ 16 * 999.99        , 0x01, },
+	{ 16 * 170.00 /*MHz*/, 0x8e, 0x02, },
+	{ 16 * 450.00 /*MHz*/, 0x8e, 0x04, },
+	{ 16 * 999.99        , 0x8e, 0x01, },
 };
 
 static struct tuner_params tuner_temic_pal_i_params[] = {
@@ -151,16 +145,15 @@ static struct tuner_params tuner_temic_p
 		.type   = TUNER_PARAM_TYPE_PAL,
 		.ranges = tuner_temic_pal_i_ranges,
 		.count  = ARRAY_SIZE(tuner_temic_pal_i_ranges),
-		.config = 0x8e,
 	},
 };
 
 /* ------------ TUNER_TEMIC_4036FY5_NTSC - TEMIC NTSC ------------ */
 
 static struct tuner_range tuner_temic_4036fy5_ntsc_ranges[] = {
-	{ 16 * 157.25 /*MHz*/, 0xa0, },
-	{ 16 * 463.25 /*MHz*/, 0x90, },
-	{ 16 * 999.99        , 0x30, },
+	{ 16 * 157.25 /*MHz*/, 0x8e, 0xa0, },
+	{ 16 * 463.25 /*MHz*/, 0x8e, 0x90, },
+	{ 16 * 999.99        , 0x8e, 0x30, },
 };
 
 static struct tuner_params tuner_temic_4036fy5_ntsc_params[] = {
@@ -168,16 +161,15 @@ static struct tuner_params tuner_temic_4
 		.type   = TUNER_PARAM_TYPE_NTSC,
 		.ranges = tuner_temic_4036fy5_ntsc_ranges,
 		.count  = ARRAY_SIZE(tuner_temic_4036fy5_ntsc_ranges),
-		.config = 0x8e,
 	},
 };
 
 /* ------------ TUNER_ALPS_TSBH1_NTSC - TEMIC NTSC ------------ */
 
 static struct tuner_range tuner_alps_tsb_1_ranges[] = {
-	{ 16 * 137.25 /*MHz*/, 0x01, },
-	{ 16 * 385.25 /*MHz*/, 0x02, },
-	{ 16 * 999.99        , 0x08, },
+	{ 16 * 137.25 /*MHz*/, 0x8e, 0x01, },
+	{ 16 * 385.25 /*MHz*/, 0x8e, 0x02, },
+	{ 16 * 999.99        , 0x8e, 0x08, },
 };
 
 static struct tuner_params tuner_alps_tsbh1_ntsc_params[] = {
@@ -185,7 +177,6 @@ static struct tuner_params tuner_alps_ts
 		.type   = TUNER_PARAM_TYPE_NTSC,
 		.ranges = tuner_alps_tsb_1_ranges,
 		.count  = ARRAY_SIZE(tuner_alps_tsb_1_ranges),
-		.config = 0x8e,
 	},
 };
 
@@ -197,16 +188,15 @@ static struct tuner_params tuner_alps_ts
 		.type   = TUNER_PARAM_TYPE_PAL,
 		.ranges = tuner_alps_tsb_1_ranges,
 		.count  = ARRAY_SIZE(tuner_alps_tsb_1_ranges),
-		.config = 0x8e,
 	},
 };
 
 /* ------------ TUNER_ALPS_TSBB5_PAL_I - Alps PAL_I ------------ */
 
 static struct tuner_range tuner_alps_tsb_5_pal_ranges[] = {
-	{ 16 * 133.25 /*MHz*/, 0x01, },
-	{ 16 * 351.25 /*MHz*/, 0x02, },
-	{ 16 * 999.99        , 0x08, },
+	{ 16 * 133.25 /*MHz*/, 0x8e, 0x01, },
+	{ 16 * 351.25 /*MHz*/, 0x8e, 0x02, },
+	{ 16 * 999.99        , 0x8e, 0x08, },
 };
 
 static struct tuner_params tuner_alps_tsbb5_params[] = {
@@ -214,7 +204,6 @@ static struct tuner_params tuner_alps_ts
 		.type   = TUNER_PARAM_TYPE_PAL,
 		.ranges = tuner_alps_tsb_5_pal_ranges,
 		.count  = ARRAY_SIZE(tuner_alps_tsb_5_pal_ranges),
-		.config = 0x8e,
 	},
 };
 
@@ -225,7 +214,6 @@ static struct tuner_params tuner_alps_ts
 		.type   = TUNER_PARAM_TYPE_PAL,
 		.ranges = tuner_alps_tsb_5_pal_ranges,
 		.count  = ARRAY_SIZE(tuner_alps_tsb_5_pal_ranges),
-		.config = 0x8e,
 	},
 };
 
@@ -236,16 +224,15 @@ static struct tuner_params tuner_alps_ts
 		.type   = TUNER_PARAM_TYPE_PAL,
 		.ranges = tuner_alps_tsb_5_pal_ranges,
 		.count  = ARRAY_SIZE(tuner_alps_tsb_5_pal_ranges),
-		.config = 0x8e,
 	},
 };
 
 /* ------------ TUNER_TEMIC_4006FH5_PAL - TEMIC PAL ------------ */
 
 static struct tuner_range tuner_temic_4006fh5_pal_ranges[] = {
-	{ 16 * 170.00 /*MHz*/, 0xa0, },
-	{ 16 * 450.00 /*MHz*/, 0x90, },
-	{ 16 * 999.99        , 0x30, },
+	{ 16 * 170.00 /*MHz*/, 0x8e, 0xa0, },
+	{ 16 * 450.00 /*MHz*/, 0x8e, 0x90, },
+	{ 16 * 999.99        , 0x8e, 0x30, },
 };
 
 static struct tuner_params tuner_temic_4006fh5_params[] = {
@@ -253,16 +240,15 @@ static struct tuner_params tuner_temic_4
 		.type   = TUNER_PARAM_TYPE_PAL,
 		.ranges = tuner_temic_4006fh5_pal_ranges,
 		.count  = ARRAY_SIZE(tuner_temic_4006fh5_pal_ranges),
-		.config = 0x8e,
 	},
 };
 
 /* ------------ TUNER_ALPS_TSHC6_NTSC - Alps NTSC ------------ */
 
 static struct tuner_range tuner_alps_tshc6_ntsc_ranges[] = {
-	{ 16 * 137.25 /*MHz*/, 0x14, },
-	{ 16 * 385.25 /*MHz*/, 0x12, },
-	{ 16 * 999.99        , 0x11, },
+	{ 16 * 137.25 /*MHz*/, 0x8e, 0x14, },
+	{ 16 * 385.25 /*MHz*/, 0x8e, 0x12, },
+	{ 16 * 999.99        , 0x8e, 0x11, },
 };
 
 static struct tuner_params tuner_alps_tshc6_params[] = {
@@ -270,16 +256,15 @@ static struct tuner_params tuner_alps_ts
 		.type   = TUNER_PARAM_TYPE_NTSC,
 		.ranges = tuner_alps_tshc6_ntsc_ranges,
 		.count  = ARRAY_SIZE(tuner_alps_tshc6_ntsc_ranges),
-		.config = 0x8e,
 	},
 };
 
 /* ------------ TUNER_TEMIC_PAL_DK - TEMIC PAL ------------ */
 
 static struct tuner_range tuner_temic_pal_dk_ranges[] = {
-	{ 16 * 168.25 /*MHz*/, 0xa0, },
-	{ 16 * 456.25 /*MHz*/, 0x90, },
-	{ 16 * 999.99        , 0x30, },
+	{ 16 * 168.25 /*MHz*/, 0x8e, 0xa0, },
+	{ 16 * 456.25 /*MHz*/, 0x8e, 0x90, },
+	{ 16 * 999.99        , 0x8e, 0x30, },
 };
 
 static struct tuner_params tuner_temic_pal_dk_params[] = {
@@ -287,16 +272,15 @@ static struct tuner_params tuner_temic_p
 		.type   = TUNER_PARAM_TYPE_PAL,
 		.ranges = tuner_temic_pal_dk_ranges,
 		.count  = ARRAY_SIZE(tuner_temic_pal_dk_ranges),
-		.config = 0x8e,
 	},
 };
 
 /* ------------ TUNER_PHILIPS_NTSC_M - Philips NTSC ------------ */
 
 static struct tuner_range tuner_philips_ntsc_m_ranges[] = {
-	{ 16 * 160.00 /*MHz*/, 0xa0, },
-	{ 16 * 454.00 /*MHz*/, 0x90, },
-	{ 16 * 999.99        , 0x30, },
+	{ 16 * 160.00 /*MHz*/, 0x8e, 0xa0, },
+	{ 16 * 454.00 /*MHz*/, 0x8e, 0x90, },
+	{ 16 * 999.99        , 0x8e, 0x30, },
 };
 
 static struct tuner_params tuner_philips_ntsc_m_params[] = {
@@ -304,16 +288,15 @@ static struct tuner_params tuner_philips
 		.type   = TUNER_PARAM_TYPE_NTSC,
 		.ranges = tuner_philips_ntsc_m_ranges,
 		.count  = ARRAY_SIZE(tuner_philips_ntsc_m_ranges),
-		.config = 0x8e,
 	},
 };
 
 /* ------------ TUNER_TEMIC_4066FY5_PAL_I - TEMIC PAL_I ------------ */
 
 static struct tuner_range tuner_temic_40x6f_5_pal_ranges[] = {
-	{ 16 * 169.00 /*MHz*/, 0xa0, },
-	{ 16 * 454.00 /*MHz*/, 0x90, },
-	{ 16 * 999.99        , 0x30, },
+	{ 16 * 169.00 /*MHz*/, 0x8e, 0xa0, },
+	{ 16 * 454.00 /*MHz*/, 0x8e, 0x90, },
+	{ 16 * 999.99        , 0x8e, 0x30, },
 };
 
 static struct tuner_params tuner_temic_4066fy5_pal_i_params[] = {
@@ -321,7 +304,6 @@ static struct tuner_params tuner_temic_4
 		.type   = TUNER_PARAM_TYPE_PAL,
 		.ranges = tuner_temic_40x6f_5_pal_ranges,
 		.count  = ARRAY_SIZE(tuner_temic_40x6f_5_pal_ranges),
-		.config = 0x8e,
 	},
 };
 
@@ -332,7 +314,6 @@ static struct tuner_params tuner_temic_4
 		.type   = TUNER_PARAM_TYPE_PAL,
 		.ranges = tuner_temic_40x6f_5_pal_ranges,
 		.count  = ARRAY_SIZE(tuner_temic_40x6f_5_pal_ranges),
-		.config = 0x8e,
 	},
 };
 
@@ -340,9 +321,9 @@ static struct tuner_params tuner_temic_4
 /* ------------ TUNER_TEMIC_4009FR5_PAL - TEMIC PAL ------------ */
 
 static struct tuner_range tuner_temic_4009f_5_pal_ranges[] = {
-	{ 16 * 141.00 /*MHz*/, 0xa0, },
-	{ 16 * 464.00 /*MHz*/, 0x90, },
-	{ 16 * 999.99        , 0x30, },
+	{ 16 * 141.00 /*MHz*/, 0x8e, 0xa0, },
+	{ 16 * 464.00 /*MHz*/, 0x8e, 0x90, },
+	{ 16 * 999.99        , 0x8e, 0x30, },
 };
 
 static struct tuner_params tuner_temic_4009f_5_params[] = {
@@ -350,16 +331,15 @@ static struct tuner_params tuner_temic_4
 		.type   = TUNER_PARAM_TYPE_PAL,
 		.ranges = tuner_temic_4009f_5_pal_ranges,
 		.count  = ARRAY_SIZE(tuner_temic_4009f_5_pal_ranges),
-		.config = 0x8e,
 	},
 };
 
 /* ------------ TUNER_TEMIC_4039FR5_NTSC - TEMIC NTSC ------------ */
 
 static struct tuner_range tuner_temic_4039fr5_ntsc_ranges[] = {
-	{ 16 * 158.00 /*MHz*/, 0xa0, },
-	{ 16 * 453.00 /*MHz*/, 0x90, },
-	{ 16 * 999.99        , 0x30, },
+	{ 16 * 158.00 /*MHz*/, 0x8e, 0xa0, },
+	{ 16 * 453.00 /*MHz*/, 0x8e, 0x90, },
+	{ 16 * 999.99        , 0x8e, 0x30, },
 };
 
 static struct tuner_params tuner_temic_4039fr5_params[] = {
@@ -367,16 +347,15 @@ static struct tuner_params tuner_temic_4
 		.type   = TUNER_PARAM_TYPE_NTSC,
 		.ranges = tuner_temic_4039fr5_ntsc_ranges,
 		.count  = ARRAY_SIZE(tuner_temic_4039fr5_ntsc_ranges),
-		.config = 0x8e,
 	},
 };
 
 /* ------------ TUNER_TEMIC_4046FM5 - TEMIC PAL ------------ */
 
 static struct tuner_range tuner_temic_4046fm5_pal_ranges[] = {
-	{ 16 * 169.00 /*MHz*/, 0xa0, },
-	{ 16 * 454.00 /*MHz*/, 0x90, },
-	{ 16 * 999.99        , 0x30, },
+	{ 16 * 169.00 /*MHz*/, 0x8e, 0xa0, },
+	{ 16 * 454.00 /*MHz*/, 0x8e, 0x90, },
+	{ 16 * 999.99        , 0x8e, 0x30, },
 };
 
 static struct tuner_params tuner_temic_4046fm5_params[] = {
@@ -384,16 +363,15 @@ static struct tuner_params tuner_temic_4
 		.type   = TUNER_PARAM_TYPE_PAL,
 		.ranges = tuner_temic_4046fm5_pal_ranges,
 		.count  = ARRAY_SIZE(tuner_temic_4046fm5_pal_ranges),
-		.config = 0x8e,
 	},
 };
 
 /* ------------ TUNER_PHILIPS_PAL_DK - Philips PAL ------------ */
 
 static struct tuner_range tuner_lg_pal_ranges[] = {
-	{ 16 * 170.00 /*MHz*/, 0xa0, },
-	{ 16 * 450.00 /*MHz*/, 0x90, },
-	{ 16 * 999.99        , 0x30, },
+	{ 16 * 170.00 /*MHz*/, 0x8e, 0xa0, },
+	{ 16 * 450.00 /*MHz*/, 0x8e, 0x90, },
+	{ 16 * 999.99        , 0x8e, 0x30, },
 };
 
 static struct tuner_params tuner_philips_pal_dk_params[] = {
@@ -401,7 +379,6 @@ static struct tuner_params tuner_philips
 		.type   = TUNER_PARAM_TYPE_PAL,
 		.ranges = tuner_lg_pal_ranges,
 		.count  = ARRAY_SIZE(tuner_lg_pal_ranges),
-		.config = 0x8e,
 	},
 };
 
@@ -412,7 +389,6 @@ static struct tuner_params tuner_philips
 		.type   = TUNER_PARAM_TYPE_PAL,
 		.ranges = tuner_lg_pal_ranges,
 		.count  = ARRAY_SIZE(tuner_lg_pal_ranges),
-		.config = 0x8e,
 	},
 };
 
@@ -423,7 +399,6 @@ static struct tuner_params tuner_lg_pal_
 		.type   = TUNER_PARAM_TYPE_PAL,
 		.ranges = tuner_lg_pal_ranges,
 		.count  = ARRAY_SIZE(tuner_lg_pal_ranges),
-		.config = 0x8e,
 	},
 };
 
@@ -434,16 +409,15 @@ static struct tuner_params tuner_lg_pal_
 		.type   = TUNER_PARAM_TYPE_PAL,
 		.ranges = tuner_lg_pal_ranges,
 		.count  = ARRAY_SIZE(tuner_lg_pal_ranges),
-		.config = 0x8e,
 	},
 };
 
 /* ------------ TUNER_LG_NTSC_FM - LGINNOTEK NTSC ------------ */
 
 static struct tuner_range tuner_lg_ntsc_fm_ranges[] = {
-	{ 16 * 210.00 /*MHz*/, 0xa0, },
-	{ 16 * 497.00 /*MHz*/, 0x90, },
-	{ 16 * 999.99        , 0x30, },
+	{ 16 * 210.00 /*MHz*/, 0x8e, 0xa0, },
+	{ 16 * 497.00 /*MHz*/, 0x8e, 0x90, },
+	{ 16 * 999.99        , 0x8e, 0x30, },
 };
 
 static struct tuner_params tuner_lg_ntsc_fm_params[] = {
@@ -451,7 +425,6 @@ static struct tuner_params tuner_lg_ntsc
 		.type   = TUNER_PARAM_TYPE_NTSC,
 		.ranges = tuner_lg_ntsc_fm_ranges,
 		.count  = ARRAY_SIZE(tuner_lg_ntsc_fm_ranges),
-		.config = 0x8e,
 	},
 };
 
@@ -462,7 +435,6 @@ static struct tuner_params tuner_lg_pal_
 		.type   = TUNER_PARAM_TYPE_PAL,
 		.ranges = tuner_lg_pal_ranges,
 		.count  = ARRAY_SIZE(tuner_lg_pal_ranges),
-		.config = 0x8e,
 	},
 };
 
@@ -473,7 +445,6 @@ static struct tuner_params tuner_lg_pal_
 		.type   = TUNER_PARAM_TYPE_PAL,
 		.ranges = tuner_lg_pal_ranges,
 		.count  = ARRAY_SIZE(tuner_lg_pal_ranges),
-		.config = 0x8e,
 	},
 };
 
@@ -485,16 +456,15 @@ static struct tuner_params tuner_temic_4
 		.type   = TUNER_PARAM_TYPE_PAL,
 		.ranges = tuner_temic_4009f_5_pal_ranges,
 		.count  = ARRAY_SIZE(tuner_temic_4009f_5_pal_ranges),
-		.config = 0x8e,
 	},
 };
 
 /* ------------ TUNER_SHARP_2U5JF5540_NTSC - SHARP NTSC ------------ */
 
 static struct tuner_range tuner_sharp_2u5jf5540_ntsc_ranges[] = {
-	{ 16 * 137.25 /*MHz*/, 0x01, },
-	{ 16 * 317.25 /*MHz*/, 0x02, },
-	{ 16 * 999.99        , 0x08, },
+	{ 16 * 137.25 /*MHz*/, 0x8e, 0x01, },
+	{ 16 * 317.25 /*MHz*/, 0x8e, 0x02, },
+	{ 16 * 999.99        , 0x8e, 0x08, },
 };
 
 static struct tuner_params tuner_sharp_2u5jf5540_params[] = {
@@ -502,16 +472,15 @@ static struct tuner_params tuner_sharp_2
 		.type   = TUNER_PARAM_TYPE_NTSC,
 		.ranges = tuner_sharp_2u5jf5540_ntsc_ranges,
 		.count  = ARRAY_SIZE(tuner_sharp_2u5jf5540_ntsc_ranges),
-		.config = 0x8e,
 	},
 };
 
 /* ------------ TUNER_Samsung_PAL_TCPM9091PD27 - Samsung PAL ------------ */
 
 static struct tuner_range tuner_samsung_pal_tcpm9091pd27_ranges[] = {
-	{ 16 * 169 /*MHz*/, 0xa0, },
-	{ 16 * 464 /*MHz*/, 0x90, },
-	{ 16 * 999.99     , 0x30, },
+	{ 16 * 169 /*MHz*/, 0x8e, 0xa0, },
+	{ 16 * 464 /*MHz*/, 0x8e, 0x90, },
+	{ 16 * 999.99     , 0x8e, 0x30, },
 };
 
 static struct tuner_params tuner_samsung_pal_tcpm9091pd27_params[] = {
@@ -519,7 +488,6 @@ static struct tuner_params tuner_samsung
 		.type   = TUNER_PARAM_TYPE_PAL,
 		.ranges = tuner_samsung_pal_tcpm9091pd27_ranges,
 		.count  = ARRAY_SIZE(tuner_samsung_pal_tcpm9091pd27_ranges),
-		.config = 0x8e,
 	},
 };
 
@@ -530,16 +498,15 @@ static struct tuner_params tuner_temic_4
 		.type   = TUNER_PARAM_TYPE_PAL,
 		.ranges = tuner_temic_4009f_5_pal_ranges,
 		.count  = ARRAY_SIZE(tuner_temic_4009f_5_pal_ranges),
-		.config = 0x8e,
 	},
 };
 
 /* ------------ TUNER_TEMIC_4012FY5 - TEMIC PAL ------------ */
 
 static struct tuner_range tuner_temic_4012fy5_pal_ranges[] = {
-	{ 16 * 140.25 /*MHz*/, 0x02, },
-	{ 16 * 463.25 /*MHz*/, 0x04, },
-	{ 16 * 999.99        , 0x01, },
+	{ 16 * 140.25 /*MHz*/, 0x8e, 0x02, },
+	{ 16 * 463.25 /*MHz*/, 0x8e, 0x04, },
+	{ 16 * 999.99        , 0x8e, 0x01, },
 };
 
 static struct tuner_params tuner_temic_4012fy5_params[] = {
@@ -547,16 +514,15 @@ static struct tuner_params tuner_temic_4
 		.type   = TUNER_PARAM_TYPE_PAL,
 		.ranges = tuner_temic_4012fy5_pal_ranges,
 		.count  = ARRAY_SIZE(tuner_temic_4012fy5_pal_ranges),
-		.config = 0x8e,
 	},
 };
 
 /* ------------ TUNER_TEMIC_4136FY5 - TEMIC NTSC ------------ */
 
 static struct tuner_range tuner_temic_4136_fy5_ntsc_ranges[] = {
-	{ 16 * 158.00 /*MHz*/, 0xa0, },
-	{ 16 * 453.00 /*MHz*/, 0x90, },
-	{ 16 * 999.99        , 0x30, },
+	{ 16 * 158.00 /*MHz*/, 0x8e, 0xa0, },
+	{ 16 * 453.00 /*MHz*/, 0x8e, 0x90, },
+	{ 16 * 999.99        , 0x8e, 0x30, },
 };
 
 static struct tuner_params tuner_temic_4136_fy5_params[] = {
@@ -564,16 +530,15 @@ static struct tuner_params tuner_temic_4
 		.type   = TUNER_PARAM_TYPE_NTSC,
 		.ranges = tuner_temic_4136_fy5_ntsc_ranges,
 		.count  = ARRAY_SIZE(tuner_temic_4136_fy5_ntsc_ranges),
-		.config = 0x8e,
 	},
 };
 
 /* ------------ TUNER_LG_PAL_NEW_TAPC - LGINNOTEK PAL ------------ */
 
 static struct tuner_range tuner_lg_new_tapc_ranges[] = {
-	{ 16 * 170.00 /*MHz*/, 0x01, },
-	{ 16 * 450.00 /*MHz*/, 0x02, },
-	{ 16 * 999.99        , 0x08, },
+	{ 16 * 170.00 /*MHz*/, 0x8e, 0x01, },
+	{ 16 * 450.00 /*MHz*/, 0x8e, 0x02, },
+	{ 16 * 999.99        , 0x8e, 0x08, },
 };
 
 static struct tuner_params tuner_lg_pal_new_tapc_params[] = {
@@ -581,16 +546,15 @@ static struct tuner_params tuner_lg_pal_
 		.type   = TUNER_PARAM_TYPE_PAL,
 		.ranges = tuner_lg_new_tapc_ranges,
 		.count  = ARRAY_SIZE(tuner_lg_new_tapc_ranges),
-		.config = 0x8e,
 	},
 };
 
 /* ------------ TUNER_PHILIPS_FM1216ME_MK3 - Philips PAL ------------ */
 
 static struct tuner_range tuner_fm1216me_mk3_pal_ranges[] = {
-	{ 16 * 158.00 /*MHz*/, 0x01, },
-	{ 16 * 442.00 /*MHz*/, 0x02, },
-	{ 16 * 999.99        , 0x04, },
+	{ 16 * 158.00 /*MHz*/, 0x8e, 0x01, },
+	{ 16 * 442.00 /*MHz*/, 0x8e, 0x02, },
+	{ 16 * 999.99        , 0x8e, 0x04, },
 };
 
 static struct tuner_params tuner_fm1216me_mk3_params[] = {
@@ -598,7 +562,6 @@ static struct tuner_params tuner_fm1216m
 		.type   = TUNER_PARAM_TYPE_PAL,
 		.ranges = tuner_fm1216me_mk3_pal_ranges,
 		.count  = ARRAY_SIZE(tuner_fm1216me_mk3_pal_ranges),
-		.config = 0x8e,
 		.cb_first_if_lower_freq = 1,
 	},
 };
@@ -610,7 +573,6 @@ static struct tuner_params tuner_lg_ntsc
 		.type   = TUNER_PARAM_TYPE_NTSC,
 		.ranges = tuner_lg_new_tapc_ranges,
 		.count  = ARRAY_SIZE(tuner_lg_new_tapc_ranges),
-		.config = 0x8e,
 	},
 };
 
@@ -622,16 +584,15 @@ static struct tuner_params tuner_hitachi
 		.type   = TUNER_PARAM_TYPE_NTSC,
 		.ranges = tuner_lg_new_tapc_ranges,
 		.count  = ARRAY_SIZE(tuner_lg_new_tapc_ranges),
-		.config = 0x8e,
 	},
 };
 
 /* ------------ TUNER_PHILIPS_PAL_MK - Philips PAL ------------ */
 
 static struct tuner_range tuner_philips_pal_mk_pal_ranges[] = {
-	{ 16 * 140.25 /*MHz*/, 0x01, },
-	{ 16 * 463.25 /*MHz*/, 0xc2, },
-	{ 16 * 999.99        , 0xcf, },
+	{ 16 * 140.25 /*MHz*/, 0x8e, 0x01, },
+	{ 16 * 463.25 /*MHz*/, 0x8e, 0xc2, },
+	{ 16 * 999.99        , 0x8e, 0xcf, },
 };
 
 static struct tuner_params tuner_philips_pal_mk_params[] = {
@@ -639,16 +600,15 @@ static struct tuner_params tuner_philips
 		.type   = TUNER_PARAM_TYPE_PAL,
 		.ranges = tuner_philips_pal_mk_pal_ranges,
 		.count  = ARRAY_SIZE(tuner_philips_pal_mk_pal_ranges),
-		.config = 0x8e,
 	},
 };
 
 /* ------------ TUNER_PHILIPS_ATSC - Philips ATSC ------------ */
 
 static struct tuner_range tuner_philips_atsc_ranges[] = {
-	{ 16 * 157.25 /*MHz*/, 0xa0, },
-	{ 16 * 454.00 /*MHz*/, 0x90, },
-	{ 16 * 999.99        , 0x30, },
+	{ 16 * 157.25 /*MHz*/, 0x8e, 0xa0, },
+	{ 16 * 454.00 /*MHz*/, 0x8e, 0x90, },
+	{ 16 * 999.99        , 0x8e, 0x30, },
 };
 
 static struct tuner_params tuner_philips_atsc_params[] = {
@@ -656,16 +616,15 @@ static struct tuner_params tuner_philips
 		.type   = TUNER_PARAM_TYPE_NTSC,
 		.ranges = tuner_philips_atsc_ranges,
 		.count  = ARRAY_SIZE(tuner_philips_atsc_ranges),
-		.config = 0x8e,
 	},
 };
 
 /* ------------ TUNER_PHILIPS_FM1236_MK3 - Philips NTSC ------------ */
 
 static struct tuner_range tuner_fm1236_mk3_ntsc_ranges[] = {
-	{ 16 * 160.00 /*MHz*/, 0x01, },
-	{ 16 * 442.00 /*MHz*/, 0x02, },
-	{ 16 * 999.99        , 0x04, },
+	{ 16 * 160.00 /*MHz*/, 0x8e, 0x01, },
+	{ 16 * 442.00 /*MHz*/, 0x8e, 0x02, },
+	{ 16 * 999.99        , 0x8e, 0x04, },
 };
 
 static struct tuner_params tuner_fm1236_mk3_params[] = {
@@ -673,7 +632,6 @@ static struct tuner_params tuner_fm1236_
 		.type   = TUNER_PARAM_TYPE_NTSC,
 		.ranges = tuner_fm1236_mk3_ntsc_ranges,
 		.count  = ARRAY_SIZE(tuner_fm1236_mk3_ntsc_ranges),
-		.config = 0x8e,
 		.cb_first_if_lower_freq = 1,
 	},
 };
@@ -681,9 +639,9 @@ static struct tuner_params tuner_fm1236_
 /* ------------ TUNER_PHILIPS_4IN1 - Philips NTSC ------------ */
 
 static struct tuner_range tuner_philips_4in1_ntsc_ranges[] = {
-	{ 16 * 160.00 /*MHz*/, 0x01, },
-	{ 16 * 442.00 /*MHz*/, 0x02, },
-	{ 16 * 999.99        , 0x04, },
+	{ 16 * 160.00 /*MHz*/, 0x8e, 0x01, },
+	{ 16 * 442.00 /*MHz*/, 0x8e, 0x02, },
+	{ 16 * 999.99        , 0x8e, 0x04, },
 };
 
 static struct tuner_params tuner_philips_4in1_params[] = {
@@ -691,7 +649,6 @@ static struct tuner_params tuner_philips
 		.type   = TUNER_PARAM_TYPE_NTSC,
 		.ranges = tuner_philips_4in1_ntsc_ranges,
 		.count  = ARRAY_SIZE(tuner_philips_4in1_ntsc_ranges),
-		.config = 0x8e,
 	},
 };
 
@@ -702,16 +659,15 @@ static struct tuner_params tuner_microtu
 		.type   = TUNER_PARAM_TYPE_PAL,
 		.ranges = tuner_temic_4009f_5_pal_ranges,
 		.count  = ARRAY_SIZE(tuner_temic_4009f_5_pal_ranges),
-		.config = 0x8e,
 	},
 };
 
 /* ------------ TUNER_PANASONIC_VP27 - Panasonic NTSC ------------ */
 
 static struct tuner_range tuner_panasonic_vp27_ntsc_ranges[] = {
-	{ 16 * 160.00 /*MHz*/, 0x01, },
-	{ 16 * 454.00 /*MHz*/, 0x02, },
-	{ 16 * 999.99        , 0x08, },
+	{ 16 * 160.00 /*MHz*/, 0xce, 0x01, },
+	{ 16 * 454.00 /*MHz*/, 0xce, 0x02, },
+	{ 16 * 999.99        , 0xce, 0x08, },
 };
 
 static struct tuner_params tuner_panasonic_vp27_params[] = {
@@ -719,16 +675,15 @@ static struct tuner_params tuner_panason
 		.type   = TUNER_PARAM_TYPE_NTSC,
 		.ranges = tuner_panasonic_vp27_ntsc_ranges,
 		.count  = ARRAY_SIZE(tuner_panasonic_vp27_ntsc_ranges),
-		.config = 0xce,
 	},
 };
 
 /* ------------ TUNER_LG_NTSC_TAPE - LGINNOTEK NTSC ------------ */
 
 static struct tuner_range tuner_lg_ntsc_tape_ranges[] = {
-	{ 16 * 160.00 /*MHz*/, 0x01, },
-	{ 16 * 442.00 /*MHz*/, 0x02, },
-	{ 16 * 999.99        , 0x04, },
+	{ 16 * 160.00 /*MHz*/, 0x8e, 0x01, },
+	{ 16 * 442.00 /*MHz*/, 0x8e, 0x02, },
+	{ 16 * 999.99        , 0x8e, 0x04, },
 };
 
 static struct tuner_params tuner_lg_ntsc_tape_params[] = {
@@ -736,16 +691,15 @@ static struct tuner_params tuner_lg_ntsc
 		.type   = TUNER_PARAM_TYPE_NTSC,
 		.ranges = tuner_lg_ntsc_tape_ranges,
 		.count  = ARRAY_SIZE(tuner_lg_ntsc_tape_ranges),
-		.config = 0x8e,
 	},
 };
 
 /* ------------ TUNER_TNF_8831BGFF - Philips PAL ------------ */
 
 static struct tuner_range tuner_tnf_8831bgff_pal_ranges[] = {
-	{ 16 * 161.25 /*MHz*/, 0xa0, },
-	{ 16 * 463.25 /*MHz*/, 0x90, },
-	{ 16 * 999.99        , 0x30, },
+	{ 16 * 161.25 /*MHz*/, 0x8e, 0xa0, },
+	{ 16 * 463.25 /*MHz*/, 0x8e, 0x90, },
+	{ 16 * 999.99        , 0x8e, 0x30, },
 };
 
 static struct tuner_params tuner_tnf_8831bgff_params[] = {
@@ -753,16 +707,15 @@ static struct tuner_params tuner_tnf_883
 		.type   = TUNER_PARAM_TYPE_PAL,
 		.ranges = tuner_tnf_8831bgff_pal_ranges,
 		.count  = ARRAY_SIZE(tuner_tnf_8831bgff_pal_ranges),
-		.config = 0x8e,
 	},
 };
 
 /* ------------ TUNER_MICROTUNE_4042FI5 - Microtune NTSC ------------ */
 
 static struct tuner_range tuner_microtune_4042fi5_ntsc_ranges[] = {
-	{ 16 * 162.00 /*MHz*/, 0xa2, },
-	{ 16 * 457.00 /*MHz*/, 0x94, },
-	{ 16 * 999.99        , 0x31, },
+	{ 16 * 162.00 /*MHz*/, 0x8e, 0xa2, },
+	{ 16 * 457.00 /*MHz*/, 0x8e, 0x94, },
+	{ 16 * 999.99        , 0x8e, 0x31, },
 };
 
 static struct tuner_params tuner_microtune_4042fi5_params[] = {
@@ -770,7 +723,6 @@ static struct tuner_params tuner_microtu
 		.type   = TUNER_PARAM_TYPE_NTSC,
 		.ranges = tuner_microtune_4042fi5_ntsc_ranges,
 		.count  = ARRAY_SIZE(tuner_microtune_4042fi5_ntsc_ranges),
-		.config = 0x8e,
 	},
 };
 
@@ -778,9 +730,9 @@ static struct tuner_params tuner_microtu
 /* ------------ TUNER_TCL_2002N - TCL NTSC ------------ */
 
 static struct tuner_range tuner_tcl_2002n_ntsc_ranges[] = {
-	{ 16 * 172.00 /*MHz*/, 0x01, },
-	{ 16 * 448.00 /*MHz*/, 0x02, },
-	{ 16 * 999.99        , 0x08, },
+	{ 16 * 172.00 /*MHz*/, 0x8e, 0x01, },
+	{ 16 * 448.00 /*MHz*/, 0x8e, 0x02, },
+	{ 16 * 999.99        , 0x8e, 0x08, },
 };
 
 static struct tuner_params tuner_tcl_2002n_params[] = {
@@ -788,7 +740,6 @@ static struct tuner_params tuner_tcl_200
 		.type   = TUNER_PARAM_TYPE_NTSC,
 		.ranges = tuner_tcl_2002n_ntsc_ranges,
 		.count  = ARRAY_SIZE(tuner_tcl_2002n_ntsc_ranges),
-		.config = 0x8e,
 		.cb_first_if_lower_freq = 1,
 	},
 };
@@ -796,9 +747,9 @@ static struct tuner_params tuner_tcl_200
 /* ------------ TUNER_PHILIPS_FM1256_IH3 - Philips PAL ------------ */
 
 static struct tuner_range tuner_philips_fm1256_ih3_pal_ranges[] = {
-	{ 16 * 160.00 /*MHz*/, 0x01, },
-	{ 16 * 442.00 /*MHz*/, 0x02, },
-	{ 16 * 999.99        , 0x04, },
+	{ 16 * 160.00 /*MHz*/, 0x8e, 0x01, },
+	{ 16 * 442.00 /*MHz*/, 0x8e, 0x02, },
+	{ 16 * 999.99        , 0x8e, 0x04, },
 };
 
 static struct tuner_params tuner_philips_fm1256_ih3_params[] = {
@@ -806,16 +757,15 @@ static struct tuner_params tuner_philips
 		.type   = TUNER_PARAM_TYPE_PAL,
 		.ranges = tuner_philips_fm1256_ih3_pal_ranges,
 		.count  = ARRAY_SIZE(tuner_philips_fm1256_ih3_pal_ranges),
-		.config = 0x8e,
 	},
 };
 
 /* ------------ TUNER_THOMSON_DTT7610 - THOMSON ATSC ------------ */
 
 static struct tuner_range tuner_thomson_dtt7610_ntsc_ranges[] = {
-	{ 16 * 157.25 /*MHz*/, 0x39, },
-	{ 16 * 454.00 /*MHz*/, 0x3a, },
-	{ 16 * 999.99        , 0x3c, },
+	{ 16 * 157.25 /*MHz*/, 0x8e, 0x39, },
+	{ 16 * 454.00 /*MHz*/, 0x8e, 0x3a, },
+	{ 16 * 999.99        , 0x8e, 0x3c, },
 };
 
 static struct tuner_params tuner_thomson_dtt7610_params[] = {
@@ -823,16 +773,15 @@ static struct tuner_params tuner_thomson
 		.type   = TUNER_PARAM_TYPE_NTSC,
 		.ranges = tuner_thomson_dtt7610_ntsc_ranges,
 		.count  = ARRAY_SIZE(tuner_thomson_dtt7610_ntsc_ranges),
-		.config = 0x8e,
 	},
 };
 
 /* ------------ TUNER_PHILIPS_FQ1286 - Philips NTSC ------------ */
 
 static struct tuner_range tuner_philips_fq1286_ntsc_ranges[] = {
-	{ 16 * 160.00 /*MHz*/, 0x41, },
-	{ 16 * 454.00 /*MHz*/, 0x42, },
-	{ 16 * 999.99        , 0x04, },
+	{ 16 * 160.00 /*MHz*/, 0x8e, 0x41, },
+	{ 16 * 454.00 /*MHz*/, 0x8e, 0x42, },
+	{ 16 * 999.99        , 0x8e, 0x04, },
 };
 
 static struct tuner_params tuner_philips_fq1286_params[] = {
@@ -840,16 +789,15 @@ static struct tuner_params tuner_philips
 		.type   = TUNER_PARAM_TYPE_NTSC,
 		.ranges = tuner_philips_fq1286_ntsc_ranges,
 		.count  = ARRAY_SIZE(tuner_philips_fq1286_ntsc_ranges),
-		.config = 0x8e,
 	},
 };
 
 /* ------------ TUNER_TCL_2002MB - TCL PAL ------------ */
 
 static struct tuner_range tuner_tcl_2002mb_pal_ranges[] = {
-	{ 16 * 170.00 /*MHz*/, 0x01, },
-	{ 16 * 450.00 /*MHz*/, 0x02, },
-	{ 16 * 999.99        , 0x08, },
+	{ 16 * 170.00 /*MHz*/, 0xce, 0x01, },
+	{ 16 * 450.00 /*MHz*/, 0xce, 0x02, },
+	{ 16 * 999.99        , 0xce, 0x08, },
 };
 
 static struct tuner_params tuner_tcl_2002mb_params[] = {
@@ -857,44 +805,47 @@ static struct tuner_params tuner_tcl_200
 		.type   = TUNER_PARAM_TYPE_PAL,
 		.ranges = tuner_tcl_2002mb_pal_ranges,
 		.count  = ARRAY_SIZE(tuner_tcl_2002mb_pal_ranges),
-		.config = 0xce,
 	},
 };
 
 /* ------------ TUNER_PHILIPS_FQ1216AME_MK4 - Philips PAL ------------ */
 
-static struct tuner_range tuner_philips_fq12_6a___mk4_ranges[] = {
-	{ 16 * 160.00 /*MHz*/, 0x01, },
-	{ 16 * 442.00 /*MHz*/, 0x02, },
-	{ 16 * 999.99        , 0x04, },
+static struct tuner_range tuner_philips_fq12_6a___mk4_pal_ranges[] = {
+	{ 16 * 160.00 /*MHz*/, 0xce, 0x01, },
+	{ 16 * 442.00 /*MHz*/, 0xce, 0x02, },
+	{ 16 * 999.99        , 0xce, 0x04, },
 };
 
 static struct tuner_params tuner_philips_fq1216ame_mk4_params[] = {
 	{
 		.type   = TUNER_PARAM_TYPE_PAL,
-		.ranges = tuner_philips_fq12_6a___mk4_ranges,
-		.count  = ARRAY_SIZE(tuner_philips_fq12_6a___mk4_ranges),
-		.config = 0xce,
+		.ranges = tuner_philips_fq12_6a___mk4_pal_ranges,
+		.count  = ARRAY_SIZE(tuner_philips_fq12_6a___mk4_pal_ranges),
 	},
 };
 
 /* ------------ TUNER_PHILIPS_FQ1236A_MK4 - Philips NTSC ------------ */
 
+static struct tuner_range tuner_philips_fq12_6a___mk4_ntsc_ranges[] = {
+	{ 16 * 160.00 /*MHz*/, 0x8e, 0x01, },
+	{ 16 * 442.00 /*MHz*/, 0x8e, 0x02, },
+	{ 16 * 999.99        , 0x8e, 0x04, },
+};
+
 static struct tuner_params tuner_philips_fq1236a_mk4_params[] = {
 	{
 		.type   = TUNER_PARAM_TYPE_NTSC,
-		.ranges = tuner_philips_fq12_6a___mk4_ranges,
-		.count  = ARRAY_SIZE(tuner_philips_fq12_6a___mk4_ranges),
-		.config = 0x8e,
+		.ranges = tuner_philips_fq12_6a___mk4_ntsc_ranges,
+		.count  = ARRAY_SIZE(tuner_philips_fq12_6a___mk4_ntsc_ranges),
 	},
 };
 
 /* ------------ TUNER_YMEC_TVF_8531MF - Philips NTSC ------------ */
 
 static struct tuner_range tuner_ymec_tvf_8531mf_ntsc_ranges[] = {
-	{ 16 * 160.00 /*MHz*/, 0xa0, },
-	{ 16 * 454.00 /*MHz*/, 0x90, },
-	{ 16 * 999.99        , 0x30, },
+	{ 16 * 160.00 /*MHz*/, 0x8e, 0xa0, },
+	{ 16 * 454.00 /*MHz*/, 0x8e, 0x90, },
+	{ 16 * 999.99        , 0x8e, 0x30, },
 };
 
 static struct tuner_params tuner_ymec_tvf_8531mf_params[] = {
@@ -902,16 +853,15 @@ static struct tuner_params tuner_ymec_tv
 		.type   = TUNER_PARAM_TYPE_NTSC,
 		.ranges = tuner_ymec_tvf_8531mf_ntsc_ranges,
 		.count  = ARRAY_SIZE(tuner_ymec_tvf_8531mf_ntsc_ranges),
-		.config = 0x8e,
 	},
 };
 
 /* ------------ TUNER_YMEC_TVF_5533MF - Philips NTSC ------------ */
 
 static struct tuner_range tuner_ymec_tvf_5533mf_ntsc_ranges[] = {
-	{ 16 * 160.00 /*MHz*/, 0x01, },
-	{ 16 * 454.00 /*MHz*/, 0x02, },
-	{ 16 * 999.99        , 0x04, },
+	{ 16 * 160.00 /*MHz*/, 0x8e, 0x01, },
+	{ 16 * 454.00 /*MHz*/, 0x8e, 0x02, },
+	{ 16 * 999.99        , 0x8e, 0x04, },
 };
 
 static struct tuner_params tuner_ymec_tvf_5533mf_params[] = {
@@ -919,7 +869,6 @@ static struct tuner_params tuner_ymec_tv
 		.type   = TUNER_PARAM_TYPE_NTSC,
 		.ranges = tuner_ymec_tvf_5533mf_ntsc_ranges,
 		.count  = ARRAY_SIZE(tuner_ymec_tvf_5533mf_ntsc_ranges),
-		.config = 0x8e,
 	},
 };
 
@@ -928,9 +877,9 @@ static struct tuner_params tuner_ymec_tv
 /* DTT 7611 7611A 7612 7613 7613A 7614 7615 7615A */
 
 static struct tuner_range tuner_thomson_dtt761x_ntsc_ranges[] = {
-	{ 16 * 145.25 /*MHz*/, 0x39, },
-	{ 16 * 415.25 /*MHz*/, 0x3a, },
-	{ 16 * 999.99        , 0x3c, },
+	{ 16 * 145.25 /*MHz*/, 0x8e, 0x39, },
+	{ 16 * 415.25 /*MHz*/, 0x8e, 0x3a, },
+	{ 16 * 999.99        , 0x8e, 0x3c, },
 };
 
 
@@ -939,16 +888,15 @@ static struct tuner_params tuner_thomson
 		.type   = TUNER_PARAM_TYPE_NTSC,
 		.ranges = tuner_thomson_dtt761x_ntsc_ranges,
 		.count  = ARRAY_SIZE(tuner_thomson_dtt761x_ntsc_ranges),
-		.config = 0x8e,
 	},
 };
 
 /* ------------ TUNER_TENA_9533_DI - Philips PAL ------------ */
 
 static struct tuner_range tuner_tuner_tena_9533_di_pal_ranges[] = {
-	{ 16 * 160.25 /*MHz*/, 0x01, },
-	{ 16 * 464.25 /*MHz*/, 0x02, },
-	{ 16 * 999.99        , 0x04, },
+	{ 16 * 160.25 /*MHz*/, 0x8e, 0x01, },
+	{ 16 * 464.25 /*MHz*/, 0x8e, 0x02, },
+	{ 16 * 999.99        , 0x8e, 0x04, },
 };
 
 static struct tuner_params tuner_tena_9533_di_params[] = {
@@ -956,16 +904,15 @@ static struct tuner_params tuner_tena_95
 		.type   = TUNER_PARAM_TYPE_PAL,
 		.ranges = tuner_tuner_tena_9533_di_pal_ranges,
 		.count  = ARRAY_SIZE(tuner_tuner_tena_9533_di_pal_ranges),
-		.config = 0x8e,
 	},
 };
 
 /* ------------ TUNER_PHILIPS_FMD1216ME_MK3 - Philips PAL ------------ */
 
 static struct tuner_range tuner_philips_fmd1216me_mk3_pal_ranges[] = {
-	{ 16 * 160.00 /*MHz*/, 0x51, },
-	{ 16 * 442.00 /*MHz*/, 0x52, },
-	{ 16 * 999.99        , 0x54, },
+	{ 16 * 160.00 /*MHz*/, 0x86, 0x51, },
+	{ 16 * 442.00 /*MHz*/, 0x86, 0x52, },
+	{ 16 * 999.99        , 0x86, 0x54, },
 };
 
 
@@ -974,7 +921,6 @@ static struct tuner_params tuner_tuner_p
 		.type   = TUNER_PARAM_TYPE_PAL,
 		.ranges = tuner_philips_fmd1216me_mk3_pal_ranges,
 		.count  = ARRAY_SIZE(tuner_philips_fmd1216me_mk3_pal_ranges),
-		.config = 0x86,
 	},
 };
 
@@ -982,9 +928,9 @@ static struct tuner_params tuner_tuner_p
 /* ------------ TUNER_LG_TDVS_H062F - INFINEON ATSC ------------ */
 
 static struct tuner_range tuner_tua6034_ntsc_ranges[] = {
-	{ 16 * 160.00 /*MHz*/, 0x01 },
-	{ 16 * 455.00 /*MHz*/, 0x02 },
-	{ 16 * 999.99        , 0x04 },
+	{ 16 * 160.00 /*MHz*/, 0x8e, 0x01 },
+	{ 16 * 455.00 /*MHz*/, 0x8e, 0x02 },
+	{ 16 * 999.99        , 0x8e, 0x04 },
 };
 
 
@@ -993,16 +939,15 @@ static struct tuner_params tuner_tua6034
 		.type   = TUNER_PARAM_TYPE_NTSC,
 		.ranges = tuner_tua6034_ntsc_ranges,
 		.count  = ARRAY_SIZE(tuner_tua6034_ntsc_ranges),
-		.config = 0x8e,
 	},
 };
 
 /* ------------ TUNER_YMEC_TVF66T5_B_DFF - Philips PAL ------------ */
 
 static struct tuner_range tuner_ymec_tvf66t5_b_dff_pal_ranges[] = {
-	{ 16 * 160.25 /*MHz*/, 0x01, },
-	{ 16 * 464.25 /*MHz*/, 0x02, },
-	{ 16 * 999.99        , 0x08, },
+	{ 16 * 160.25 /*MHz*/, 0x8e, 0x01, },
+	{ 16 * 464.25 /*MHz*/, 0x8e, 0x02, },
+	{ 16 * 999.99        , 0x8e, 0x08, },
 };
 
 static struct tuner_params tuner_ymec_tvf66t5_b_dff_params[] = {
@@ -1010,16 +955,15 @@ static struct tuner_params tuner_ymec_tv
 		.type   = TUNER_PARAM_TYPE_PAL,
 		.ranges = tuner_ymec_tvf66t5_b_dff_pal_ranges,
 		.count  = ARRAY_SIZE(tuner_ymec_tvf66t5_b_dff_pal_ranges),
-		.config = 0x8e,
 	},
 };
 
 /* ------------ TUNER_LG_NTSC_TALN_MINI - LGINNOTEK NTSC ------------ */
 
 static struct tuner_range tuner_lg_taln_mini_ntsc_ranges[] = {
-	{ 16 * 137.25 /*MHz*/, 0x01, },
-	{ 16 * 373.25 /*MHz*/, 0x02, },
-	{ 16 * 999.99        , 0x08, },
+	{ 16 * 137.25 /*MHz*/, 0x8e, 0x01, },
+	{ 16 * 373.25 /*MHz*/, 0x8e, 0x02, },
+	{ 16 * 999.99        , 0x8e, 0x08, },
 };
 
 static struct tuner_params tuner_lg_taln_mini_params[] = {
@@ -1027,16 +971,15 @@ static struct tuner_params tuner_lg_taln
 		.type   = TUNER_PARAM_TYPE_NTSC,
 		.ranges = tuner_lg_taln_mini_ntsc_ranges,
 		.count  = ARRAY_SIZE(tuner_lg_taln_mini_ntsc_ranges),
-		.config = 0x8e,
 	},
 };
 
 /* ------------ TUNER_PHILIPS_TD1316 - Philips PAL ------------ */
 
 static struct tuner_range tuner_philips_td1316_pal_ranges[] = {
-	{ 16 * 160.00 /*MHz*/, 0xa1, },
-	{ 16 * 442.00 /*MHz*/, 0xa2, },
-	{ 16 * 999.99        , 0xa4, },
+	{ 16 * 160.00 /*MHz*/, 0xc8, 0xa1, },
+	{ 16 * 442.00 /*MHz*/, 0xc8, 0xa2, },
+	{ 16 * 999.99        , 0xc8, 0xa4, },
 };
 
 static struct tuner_params tuner_philips_td1316_params[] = {
@@ -1044,16 +987,15 @@ static struct tuner_params tuner_philips
 		.type   = TUNER_PARAM_TYPE_PAL,
 		.ranges = tuner_philips_td1316_pal_ranges,
 		.count  = ARRAY_SIZE(tuner_philips_td1316_pal_ranges),
-		.config = 0xc8,
 	},
 };
 
 /* ------------ TUNER_PHILIPS_TUV1236D - Philips ATSC ------------ */
 
 static struct tuner_range tuner_tuv1236d_ntsc_ranges[] = {
-	{ 16 * 157.25 /*MHz*/, 0x01, },
-	{ 16 * 454.00 /*MHz*/, 0x02, },
-	{ 16 * 999.99        , 0x04, },
+	{ 16 * 157.25 /*MHz*/, 0xce, 0x01, },
+	{ 16 * 454.00 /*MHz*/, 0xce, 0x02, },
+	{ 16 * 999.99        , 0xce, 0x04, },
 };
 
 
@@ -1062,16 +1004,15 @@ static struct tuner_params tuner_tuner_t
 		.type   = TUNER_PARAM_TYPE_NTSC,
 		.ranges = tuner_tuv1236d_ntsc_ranges,
 		.count  = ARRAY_SIZE(tuner_tuv1236d_ntsc_ranges),
-		.config = 0xce,
 	},
 };
 
 /* ------------ TUNER_TNF_5335MF - Philips NTSC ------------ */
 
 static struct tuner_range tuner_tnf_5335mf_ntsc_ranges[] = {
-	{ 16 * 157.25 /*MHz*/, 0x01, },
-	{ 16 * 454.00 /*MHz*/, 0x02, },
-	{ 16 * 999.99        , 0x04, },
+	{ 16 * 157.25 /*MHz*/, 0x8e, 0x01, },
+	{ 16 * 454.00 /*MHz*/, 0x8e, 0x02, },
+	{ 16 * 999.99        , 0x8e, 0x04, },
 };
 
 static struct tuner_params tuner_tnf_5335mf_params[] = {
@@ -1079,7 +1020,6 @@ static struct tuner_params tuner_tnf_533
 		.type   = TUNER_PARAM_TYPE_NTSC,
 		.ranges = tuner_tnf_5335mf_ntsc_ranges,
 		.count  = ARRAY_SIZE(tuner_tnf_5335mf_ntsc_ranges),
-		.config = 0x8e,
 	},
 };
 
@@ -1087,9 +1027,9 @@ static struct tuner_params tuner_tnf_533
 /* ------------ TUNER_SAMSUNG_TCPN_2121P30A - Samsung NTSC ------------ */
 
 static struct tuner_range tuner_samsung_tcpn_2121p30a_ntsc_ranges[] = {
-	{ 16 * 175.75 /*MHz*/, 0x01, },
-	{ 16 * 410.25 /*MHz*/, 0x02, },
-	{ 16 * 999.99        , 0x08, },
+	{ 16 * 175.75 /*MHz*/, 0xce, 0x01, },
+	{ 16 * 410.25 /*MHz*/, 0xce, 0x02, },
+	{ 16 * 999.99        , 0xce, 0x08, },
 };
 
 static struct tuner_params tuner_samsung_tcpn_2121p30a_params[] = {
@@ -1097,7 +1037,6 @@ static struct tuner_params tuner_samsung
 		.type   = TUNER_PARAM_TYPE_NTSC,
 		.ranges = tuner_samsung_tcpn_2121p30a_ntsc_ranges,
 		.count  = ARRAY_SIZE(tuner_samsung_tcpn_2121p30a_ntsc_ranges),
-		.config = 0xce,
 	},
 };
 
diff --git a/include/media/tuner-types.h b/include/media/tuner-types.h
diff --git a/include/media/tuner-types.h b/include/media/tuner-types.h
index 15821ab..53ac66e 100644
--- a/include/media/tuner-types.h
+++ b/include/media/tuner-types.h
@@ -14,6 +14,7 @@ enum param_type {
 
 struct tuner_range {
 	unsigned short limit;
+	unsigned char config;
 	unsigned char cb;
 };
 
@@ -38,7 +39,6 @@ struct tuner_params {
 	 * static unless the control byte was sent first.
 	 */
 	unsigned int cb_first_if_lower_freq:1;
-	unsigned char config; /* to be moved into struct tuner_range for dvb-pll merge */
 
 	unsigned int count;
 	struct tuner_range *ranges;

