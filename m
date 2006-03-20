Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965225AbWCTPSY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965225AbWCTPSY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966576AbWCTPSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:18:23 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:59032 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966573AbWCTPSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:18:21 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 043/141] V4L/DVB (3269): Allow multiple tuner params in
	each tuner definition
Date: Mon, 20 Mar 2006 12:08:44 -0300
Message-id: <20060320150844.PS167713000043@infradead.org>
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

From: Michael Krufky <mkrufky@linuxtv.org>
Date: 1139300734 -0200

- allow multiple tuner params in each tuner definition.
- the correct tuner_params element will be chosen based on
  current video standard.

Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/tuner-simple.c b/drivers/media/video/tuner-simple.c
diff --git a/drivers/media/video/tuner-simple.c b/drivers/media/video/tuner-simple.c
index 907ea8c..58fa0d2 100644
--- a/drivers/media/video/tuner-simple.c
+++ b/drivers/media/video/tuner-simple.c
@@ -79,14 +79,13 @@ MODULE_PARM_DESC(offset,"Allows to speci
 #define TUNER_PLL_LOCKED   0x40
 #define TUNER_STEREO_MK3   0x04
 
-#define TUNER_PARAM_ANALOG 0  /* to be removed */
 /* FIXME:
  * Right now, all tuners are using the first tuner_params[] array element
  * for analog mode. In the future, we will be merging similar tuner
  * definitions together, such that each tuner definition will have a
  * tuner_params struct for each available video standard. At that point,
- * TUNER_PARAM_ANALOG will be removed, and the tuner_params[] array
- * element will be chosen based on the video standard in use.
+ * the tuner_params[] array element will be chosen based on the video
+ * standard in use.
  *
  */
 
@@ -138,9 +137,9 @@ static void default_set_tv_freq(struct i
 	struct tunertype *tun;
 	u8 buffer[4];
 	int rc, IFPCoff, i, j;
+	enum param_type desired_type;
 
 	tun = &tuners[t->type];
-	j = TUNER_PARAM_ANALOG;
 
 	/* IFPCoff = Video Intermediate Frequency - Vif:
 		940  =16*58.75  NTSC/J (Japan)
@@ -155,16 +154,25 @@ static void default_set_tv_freq(struct i
 	*/
 
 	if (t->std == V4L2_STD_NTSC_M_JP) {
-		IFPCoff = 940;
+		IFPCoff      = 940;
+		desired_type = TUNER_PARAM_TYPE_NTSC;
 	} else if ((t->std & V4L2_STD_MN) &&
 		  !(t->std & ~V4L2_STD_MN)) {
-		IFPCoff = 732;
+		IFPCoff      = 732;
+		desired_type = TUNER_PARAM_TYPE_NTSC;
 	} else if (t->std == V4L2_STD_SECAM_LC) {
-		IFPCoff = 543;
+		IFPCoff      = 543;
+		desired_type = TUNER_PARAM_TYPE_SECAM;
 	} else {
-		IFPCoff = 623;
+		IFPCoff      = 623;
+		desired_type = TUNER_PARAM_TYPE_PAL;
 	}
 
+	for (j = 0; j < tun->count-1; j++) {
+		if (desired_type != tun->params[j].type)
+			continue;
+		break;
+	}
 	for (i = 0; i < tun->params[j].count; i++) {
 		if (freq > tun->params[j].ranges[i].limit)
 			continue;
@@ -333,9 +341,15 @@ static void default_set_radio_freq(struc
 	u8 buffer[4];
 	u16 div;
 	int rc, j;
+	enum param_type desired_type = TUNER_PARAM_TYPE_RADIO;
 
 	tun = &tuners[t->type];
-	j = TUNER_PARAM_ANALOG;
+
+	for (j = 0; j < tun->count-1; j++) {
+		if (desired_type != tun->params[j].type)
+			continue;
+		break;
+	}
 
 	div = (20 * freq / 16000) + (int)(20*10.7); /* IF 10.7 MHz */
 	buffer[2] = (tun->params[j].ranges[0].config & ~TUNER_RATIO_MASK) | TUNER_RATIO_SELECT_50; /* 50 kHz step */

