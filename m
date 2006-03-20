Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965157AbWCTQM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965157AbWCTQM4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 11:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965085AbWCTQMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 11:12:16 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:4067 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965157AbWCTPNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:13:43 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Michael Krufky <mkrufky@m1k.net>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 033/141] V4L/DVB (3435): rename cb variable names in tuner
	structures for global consistency
Date: Mon, 20 Mar 2006 12:08:42 -0300
Message-id: <20060320150842.PS511376000033@infradead.org>
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

- rename cb variable names in tuner structures for global consistency

Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/dvb/frontends/dvb-pll.c b/drivers/media/dvb/frontends/dvb-pll.c
diff --git a/drivers/media/dvb/frontends/dvb-pll.c b/drivers/media/dvb/frontends/dvb-pll.c
index 4dcb605..cd8f282 100644
--- a/drivers/media/dvb/frontends/dvb-pll.c
+++ b/drivers/media/dvb/frontends/dvb-pll.c
@@ -391,8 +391,8 @@ int dvb_pll_configure(struct dvb_pll_des
 	div = (freq + desc->entries[i].offset) / desc->entries[i].stepsize;
 	buf[0] = div >> 8;
 	buf[1] = div & 0xff;
-	buf[2] = desc->entries[i].cb1;
-	buf[3] = desc->entries[i].cb2;
+	buf[2] = desc->entries[i].config;
+	buf[3] = desc->entries[i].cb;
 
 	if (desc->setbw)
 		desc->setbw(buf, freq, bandwidth);
diff --git a/drivers/media/dvb/frontends/dvb-pll.h b/drivers/media/dvb/frontends/dvb-pll.h
diff --git a/drivers/media/dvb/frontends/dvb-pll.h b/drivers/media/dvb/frontends/dvb-pll.h
index bb8d4b4..872e3b4 100644
--- a/drivers/media/dvb/frontends/dvb-pll.h
+++ b/drivers/media/dvb/frontends/dvb-pll.h
@@ -15,8 +15,8 @@ struct dvb_pll_desc {
 		u32 limit;
 		u32 offset;
 		u32 stepsize;
-		u8  cb1;
-		u8  cb2;
+		u8  config;
+		u8  cb;
 	} entries[12];
 };
 
diff --git a/drivers/media/video/tuner-simple.c b/drivers/media/video/tuner-simple.c
diff --git a/drivers/media/video/tuner-simple.c b/drivers/media/video/tuner-simple.c
index 37977ff..2c6410c 100644
--- a/drivers/media/video/tuner-simple.c
+++ b/drivers/media/video/tuner-simple.c
@@ -133,7 +133,7 @@ static int tuner_stereo(struct i2c_clien
 static void default_set_tv_freq(struct i2c_client *c, unsigned int freq)
 {
 	struct tuner *t = i2c_get_clientdata(c);
-	u8 config, tuneraddr;
+	u8 cb, tuneraddr;
 	u16 div;
 	struct tunertype *tun;
 	u8 buffer[4];
@@ -152,7 +152,7 @@ static void default_set_tv_freq(struct i
 				freq, tun->params[j].ranges[i - 1].limit);
 		freq = tun->params[j].ranges[--i].limit;
 	}
-	config = tun->params[j].ranges[i].cb;
+	cb     = tun->params[j].ranges[i].cb;
 	/*  i == 0 -> VHF_LO  */
 	/*  i == 1 -> VHF_HI  */
 	/*  i == 2 -> UHF     */
@@ -164,40 +164,40 @@ static void default_set_tv_freq(struct i
 		/* 0x01 -> ??? no change ??? */
 		/* 0x02 -> PAL BDGHI / SECAM L */
 		/* 0x04 -> ??? PAL others / SECAM others ??? */
-		config &= ~0x02;
+		cb &= ~0x02;
 		if (t->std & V4L2_STD_SECAM)
-			config |= 0x02;
+			cb |= 0x02;
 		break;
 
 	case TUNER_TEMIC_4046FM5:
-		config &= ~0x0f;
+		cb &= ~0x0f;
 
 		if (t->std & V4L2_STD_PAL_BG) {
-			config |= TEMIC_SET_PAL_BG;
+			cb |= TEMIC_SET_PAL_BG;
 
 		} else if (t->std & V4L2_STD_PAL_I) {
-			config |= TEMIC_SET_PAL_I;
+			cb |= TEMIC_SET_PAL_I;
 
 		} else if (t->std & V4L2_STD_PAL_DK) {
-			config |= TEMIC_SET_PAL_DK;
+			cb |= TEMIC_SET_PAL_DK;
 
 		} else if (t->std & V4L2_STD_SECAM_L) {
-			config |= TEMIC_SET_PAL_L;
+			cb |= TEMIC_SET_PAL_L;
 
 		}
 		break;
 
 	case TUNER_PHILIPS_FQ1216ME:
-		config &= ~0x0f;
+		cb &= ~0x0f;
 
 		if (t->std & (V4L2_STD_PAL_BG|V4L2_STD_PAL_DK)) {
-			config |= PHILIPS_SET_PAL_BGDK;
+			cb |= PHILIPS_SET_PAL_BGDK;
 
 		} else if (t->std & V4L2_STD_PAL_I) {
-			config |= PHILIPS_SET_PAL_I;
+			cb |= PHILIPS_SET_PAL_I;
 
 		} else if (t->std & V4L2_STD_SECAM_L) {
-			config |= PHILIPS_SET_PAL_L;
+			cb |= PHILIPS_SET_PAL_L;
 
 		}
 		break;
@@ -207,9 +207,9 @@ static void default_set_tv_freq(struct i
 		/* 0x01 -> ATSC antenna input 2 */
 		/* 0x02 -> NTSC antenna input 1 */
 		/* 0x03 -> NTSC antenna input 2 */
-		config &= ~0x03;
+		cb &= ~0x03;
 		if (!(t->std & V4L2_STD_ATSC))
-			config |= 2;
+			cb |= 2;
 		/* FIXME: input */
 		break;
 
@@ -227,9 +227,9 @@ static void default_set_tv_freq(struct i
 		buffer[1] = 0x00;
 		buffer[2] = 0x17;
 		buffer[3] = 0x00;
-		config &= ~0x40;
+		cb &= ~0x40;
 		if (t->std & V4L2_STD_ATSC) {
-			config |= 0x40;
+			cb |= 0x40;
 			buffer[1] = 0x04;
 		}
 		/* set to the correct mode (analog or digital) */
@@ -277,14 +277,14 @@ static void default_set_tv_freq(struct i
 
 	if (tuners[t->type].params->cb_first_if_lower_freq && div < t->last_div) {
 		buffer[0] = tun->params[j].config;
-		buffer[1] = config;
+		buffer[1] = cb;
 		buffer[2] = (div>>8) & 0x7f;
 		buffer[3] = div      & 0xff;
 	} else {
 		buffer[0] = (div>>8) & 0x7f;
 		buffer[1] = div      & 0xff;
 		buffer[2] = tun->params[j].config;
-		buffer[3] = config;
+		buffer[3] = cb;
 	}
 	t->last_div = div;
 	tuner_dbg("tv 0x%02x 0x%02x 0x%02x 0x%02x\n",
@@ -316,7 +316,7 @@ static void default_set_tv_freq(struct i
 		buffer[0] = (div>>8) & 0x7f;
 		buffer[1] = div      & 0xff;
 		buffer[2] = tun->params[j].config;
-		buffer[3] = config;
+		buffer[3] = cb;
 		tuner_dbg("tv 0x%02x 0x%02x 0x%02x 0x%02x\n",
 		       buffer[0],buffer[1],buffer[2],buffer[3]);
 

