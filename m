Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965592AbWCTPw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965592AbWCTPw7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965560AbWCTPw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:52:58 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:50638 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965046AbWCTPwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:52:47 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Hartmut Hackmann <hartmut.hackmann@t-online.de>,
       Hartmut Hackmann <hartmut.hackmann@t-online.de>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 046/141] V4L/DVB (3275): Allow SAA7134 to fall back to AM
	sound when there is NICAM-L
Date: Mon, 20 Mar 2006 12:08:44 -0300
Message-id: <20060320150844.PS662155000046@infradead.org>
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

From: Hartmut Hackmann <hartmut.hackmann@t-online.de>
Date: 1139300737 -0200

This patch allows to select AM sound even if NICAM is detected.
Proposed by Alain Frappin

Signed-off-by: Hartmut Hackmann <hartmut.hackmann@t-online.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/saa7134/saa7134-tvaudio.c b/drivers/media/video/saa7134/saa7134-tvaudio.c
diff --git a/drivers/media/video/saa7134/saa7134-tvaudio.c b/drivers/media/video/saa7134/saa7134-tvaudio.c
index afa4dcb..3043233 100644
--- a/drivers/media/video/saa7134/saa7134-tvaudio.c
+++ b/drivers/media/video/saa7134/saa7134-tvaudio.c
@@ -140,6 +140,12 @@ static struct saa7134_tvaudio tvaudio[] 
 		.carr2         = 5850,
 		.mode          = TVAUDIO_NICAM_AM,
 	},{
+		.name          = "SECAM-L MONO",
+		.std           = V4L2_STD_SECAM,
+		.carr1         = 6500,
+		.carr2         = -1,
+		.mode          = TVAUDIO_AM_MONO,
+	},{
 		.name          = "SECAM-D/K",
 		.std           = V4L2_STD_SECAM,
 		.carr1         = 6500,
@@ -334,6 +340,12 @@ static void tvaudio_setmode(struct saa71
 		saa_writeb(SAA7134_STEREO_DAC_OUTPUT_SELECT,  0xa1);
 		saa_writeb(SAA7134_NICAM_CONFIG,              0x00);
 		break;
+	case TVAUDIO_AM_MONO:
+		saa_writeb(SAA7134_DEMODULATOR,               0x12);
+		saa_writeb(SAA7134_DCXO_IDENT_CTRL,           0x00);
+		saa_writeb(SAA7134_FM_DEEMPHASIS,             0x44);
+		saa_writeb(SAA7134_STEREO_DAC_OUTPUT_SELECT,  0xa0);
+		break;
 	case TVAUDIO_FM_SAT_STEREO:
 		/* not implemented (yet) */
 		break;
@@ -414,6 +426,7 @@ static int tvaudio_getstereo(struct saa7
 
 	switch (audio->mode) {
 	case TVAUDIO_FM_MONO:
+	case TVAUDIO_AM_MONO:
 		return V4L2_TUNER_SUB_MONO;
 	case TVAUDIO_FM_K_STEREO:
 	case TVAUDIO_FM_BG_STEREO:
@@ -480,6 +493,7 @@ static int tvaudio_setstereo(struct saa7
 
 	switch (audio->mode) {
 	case TVAUDIO_FM_MONO:
+	case TVAUDIO_AM_MONO:
 		/* nothing to do ... */
 		break;
 	case TVAUDIO_FM_K_STEREO:
diff --git a/drivers/media/video/saa7134/saa7134.h b/drivers/media/video/saa7134/saa7134.h
diff --git a/drivers/media/video/saa7134/saa7134.h b/drivers/media/video/saa7134/saa7134.h
index 3b8f466..b638df9 100644
--- a/drivers/media/video/saa7134/saa7134.h
+++ b/drivers/media/video/saa7134/saa7134.h
@@ -60,6 +60,7 @@ enum saa7134_tvaudio_mode {
 	TVAUDIO_FM_K_STEREO   = 4,
 	TVAUDIO_NICAM_AM      = 5,
 	TVAUDIO_NICAM_FM      = 6,
+	TVAUDIO_AM_MONO	      = 7
 };
 
 enum saa7134_audio_in {

