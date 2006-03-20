Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965278AbWCTPYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965278AbWCTPYT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964875AbWCTPYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:24:10 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:12984 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965278AbWCTPXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:23:53 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 042/141] V4L/DVB (3268): Move video std detection to top of
	set_tv_freq function
Date: Mon, 20 Mar 2006 12:08:44 -0300
Message-id: <20060320150844.PS003832000042@infradead.org>
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
Date: 1139300733 -0200

- move video std detection to top of set_tv_freq function
- we must detect video std first, so that we can choose the correct
  tuner_params

Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/tuner-simple.c b/drivers/media/video/tuner-simple.c
diff --git a/drivers/media/video/tuner-simple.c b/drivers/media/video/tuner-simple.c
index 6f0d376..907ea8c 100644
--- a/drivers/media/video/tuner-simple.c
+++ b/drivers/media/video/tuner-simple.c
@@ -142,6 +142,29 @@ static void default_set_tv_freq(struct i
 	tun = &tuners[t->type];
 	j = TUNER_PARAM_ANALOG;
 
+	/* IFPCoff = Video Intermediate Frequency - Vif:
+		940  =16*58.75  NTSC/J (Japan)
+		732  =16*45.75  M/N STD
+		704  =16*44     ATSC (at DVB code)
+		632  =16*39.50  I U.K.
+		622.4=16*38.90  B/G D/K I, L STD
+		592  =16*37.00  D China
+		590  =16.36.875 B Australia
+		543.2=16*33.95  L' STD
+		171.2=16*10.70  FM Radio (at set_radio_freq)
+	*/
+
+	if (t->std == V4L2_STD_NTSC_M_JP) {
+		IFPCoff = 940;
+	} else if ((t->std & V4L2_STD_MN) &&
+		  !(t->std & ~V4L2_STD_MN)) {
+		IFPCoff = 732;
+	} else if (t->std == V4L2_STD_SECAM_LC) {
+		IFPCoff = 543;
+	} else {
+		IFPCoff = 623;
+	}
+
 	for (i = 0; i < tun->params[j].count; i++) {
 		if (freq > tun->params[j].ranges[i].limit)
 			continue;
@@ -154,11 +177,19 @@ static void default_set_tv_freq(struct i
 	}
 	config = tun->params[j].ranges[i].config;
 	cb     = tun->params[j].ranges[i].cb;
-	/*  i == 0 -> VHF_LO  */
-	/*  i == 1 -> VHF_HI  */
-	/*  i == 2 -> UHF     */
+	/*  i == 0 -> VHF_LO
+	 *  i == 1 -> VHF_HI
+	 *  i == 2 -> UHF     */
 	tuner_dbg("tv: range %d\n",i);
 
+	div=freq + IFPCoff + offset;
+
+	tuner_dbg("Freq= %d.%02d MHz, V_IF=%d.%02d MHz, Offset=%d.%02d MHz, div=%0d\n",
+					freq / 16, freq % 16 * 100 / 16,
+					IFPCoff / 16, IFPCoff % 16 * 100 / 16,
+					offset / 16, offset % 16 * 100 / 16,
+					div);
+
 	/* tv norm specific stuff for multi-norm tuners */
 	switch (t->type) {
 	case TUNER_PHILIPS_SECAM: // FI1216MF
@@ -245,37 +276,6 @@ static void default_set_tv_freq(struct i
 		break;
 	}
 
-	/* IFPCoff = Video Intermediate Frequency - Vif:
-		940  =16*58.75  NTSC/J (Japan)
-		732  =16*45.75  M/N STD
-		704  =16*44     ATSC (at DVB code)
-		632  =16*39.50  I U.K.
-		622.4=16*38.90  B/G D/K I, L STD
-		592  =16*37.00  D China
-		590  =16.36.875 B Australia
-		543.2=16*33.95  L' STD
-		171.2=16*10.70  FM Radio (at set_radio_freq)
-	*/
-
-	if (t->std == V4L2_STD_NTSC_M_JP) {
-		IFPCoff = 940;
-	} else if ((t->std & V4L2_STD_MN) &&
-		  !(t->std & ~V4L2_STD_MN)) {
-		IFPCoff = 732;
-	} else if (t->std == V4L2_STD_SECAM_LC) {
-		IFPCoff = 543;
-	} else {
-		IFPCoff = 623;
-	}
-
-	div=freq + IFPCoff + offset;
-
-	tuner_dbg("Freq= %d.%02d MHz, V_IF=%d.%02d MHz, Offset=%d.%02d MHz, div=%0d\n",
-					freq / 16, freq % 16 * 100 / 16,
-					IFPCoff / 16, IFPCoff % 16 * 100 / 16,
-					offset / 16, offset % 16 * 100 / 16,
-					div);
-
 	if (tuners[t->type].params->cb_first_if_lower_freq && div < t->last_div) {
 		buffer[0] = config;
 		buffer[1] = cb;

