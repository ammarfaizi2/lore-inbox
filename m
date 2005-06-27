Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262091AbVF0OCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262091AbVF0OCa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 10:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbVF0OAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 10:00:54 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:34789 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262093AbVF0MRG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 08:17:06 -0400
Message-Id: <20050627121411.722717000@abc>
References: <20050627120600.739151000@abc>
Date: Mon, 27 Jun 2005 14:06:11 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       Hartmut Hackmann <hartmut.hackmann@t-online.de>
Content-Disposition: inline; filename=dvb-frontend-tda1004x-fixes.patch
X-SA-Exim-Connect-IP: 84.189.248.249
Subject: [DVB patch 11/51] frontend: tda1004x: support tda827x tuners
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hartmut Hackmann <hartmut.hackmann@t-online.de>

o added preliminary support for tda827x tuners
o set parameters for drift compensation to 0
  makes no sense for DVB-T but can prevent lock

Signed-off-by: Hartmut Hackmann <hartmut.hackmann@t-online.de>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/frontends/tda1004x.c |   44 ++++++++++++++++++++++++++++++---
 drivers/media/dvb/frontends/tda1004x.h |    4 +++
 2 files changed, 44 insertions(+), 4 deletions(-)

Index: linux-2.6.12-git8/drivers/media/dvb/frontends/tda1004x.c
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/frontends/tda1004x.c	2005-06-27 13:23:04.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/frontends/tda1004x.c	2005-06-27 13:23:05.000000000 +0200
@@ -120,6 +120,8 @@ static int debug;
 #define TDA10046H_GPIO_OUT_SEL	 0x41
 #define TDA10046H_GPIO_SELECT	 0x42
 #define TDA10046H_AGC_CONF	 0x43
+#define TDA10046H_AGC_THR	 0x44
+#define TDA10046H_AGC_RENORM	 0x45
 #define TDA10046H_AGC_GAINS	 0x46
 #define TDA10046H_AGC_TUN_MIN	 0x47
 #define TDA10046H_AGC_TUN_MAX	 0x48
@@ -272,14 +274,26 @@ static int tda10046h_set_bandwidth(struc
 	switch (bandwidth) {
 	case BANDWIDTH_6_MHZ:
 		tda1004x_write_buf(state, TDA10046H_TIME_WREF1, bandwidth_6mhz, sizeof(bandwidth_6mhz));
+		if (state->config->if_freq == TDA10046_FREQ_045) {
+			tda1004x_write_byteI(state, TDA10046H_FREQ_PHY2_MSB, 0x09);
+			tda1004x_write_byteI(state, TDA10046H_FREQ_PHY2_LSB, 0x4f);
+		}
 		break;
 
 	case BANDWIDTH_7_MHZ:
 		tda1004x_write_buf(state, TDA10046H_TIME_WREF1, bandwidth_7mhz, sizeof(bandwidth_7mhz));
+		if (state->config->if_freq == TDA10046_FREQ_045) {
+			tda1004x_write_byteI(state, TDA10046H_FREQ_PHY2_MSB, 0x0a);
+			tda1004x_write_byteI(state, TDA10046H_FREQ_PHY2_LSB, 0x79);
+		}
 		break;
 
 	case BANDWIDTH_8_MHZ:
 		tda1004x_write_buf(state, TDA10046H_TIME_WREF1, bandwidth_8mhz, sizeof(bandwidth_8mhz));
+		if (state->config->if_freq == TDA10046_FREQ_045) {
+			tda1004x_write_byteI(state, TDA10046H_FREQ_PHY2_MSB, 0x0b);
+			tda1004x_write_byteI(state, TDA10046H_FREQ_PHY2_LSB, 0xa3);
+		}
 		break;
 
 	default:
@@ -420,6 +434,14 @@ static void tda10046_init_plls(struct dv
 		tda1004x_write_byteI(state, TDA10046H_FREQ_PHY2_MSB, 0xd4);
 		tda1004x_write_byteI(state, TDA10046H_FREQ_PHY2_LSB, 0x13);
 		break;
+	case TDA10046_FREQ_045:
+		tda1004x_write_byteI(state, TDA10046H_FREQ_PHY2_MSB, 0x0b);
+		tda1004x_write_byteI(state, TDA10046H_FREQ_PHY2_LSB, 0xa3);
+		break;
+	case TDA10046_FREQ_052:
+		tda1004x_write_byteI(state, TDA10046H_FREQ_PHY2_MSB, 0x0c);
+		tda1004x_write_byteI(state, TDA10046H_FREQ_PHY2_LSB, 0x06);
+		break;
 	}
 	tda10046h_set_bandwidth(state, BANDWIDTH_8_MHZ); // default bandwidth 8 MHz
 }
@@ -590,6 +612,16 @@ static int tda10046_init(struct dvb_fron
 		tda1004x_write_byteI(state, TDA10046H_AGC_CONF, 0x0a); // AGC setup
 		tda1004x_write_byteI(state, TDA10046H_CONF_POLARITY, 0x60); // set AGC polarities
 		break;
+	case TDA10046_AGC_IFO_AUTO_POS:
+		tda1004x_write_byteI(state, TDA10046H_AGC_CONF, 0x0a); // AGC setup
+		tda1004x_write_byteI(state, TDA10046H_CONF_POLARITY, 0x00); // set AGC polarities
+		break;
+	case TDA10046_AGC_TDA827X:
+		tda1004x_write_byteI(state, TDA10046H_AGC_CONF, 0x02);   // AGC setup
+		tda1004x_write_byteI(state, TDA10046H_AGC_THR, 0x70);    // AGC Threshold
+		tda1004x_write_byteI(state, TDA10046H_AGC_RENORM, 0x0E); // Gain Renormalize
+		tda1004x_write_byteI(state, TDA10046H_CONF_POLARITY, 0x60); // set AGC polarities
+		break;
 	}
 	tda1004x_write_byteI(state, TDA10046H_CONF_TRISTATE1, 0x61); // Turn both AGC outputs on
 	tda1004x_write_byteI(state, TDA10046H_AGC_TUN_MIN, 0);	  // }
@@ -1091,9 +1123,12 @@ static int tda1004x_sleep(struct dvb_fro
 		break;
 
 	case TDA1004X_DEMOD_TDA10046:
-		tda1004x_write_mask(state, TDA1004X_CONFC4, 1, 1);
-		if (state->config->pll_sleep != NULL)
+		if (state->config->pll_sleep != NULL) {
+			tda1004x_enable_tuner_i2c(state);
 			state->config->pll_sleep(fe);
+			tda1004x_disable_tuner_i2c(state);
+		}
+		tda1004x_write_mask(state, TDA1004X_CONFC4, 1, 1);
 		break;
 	}
 	state->initialised = 0;
@@ -1104,8 +1139,9 @@ static int tda1004x_sleep(struct dvb_fro
 static int tda1004x_get_tune_settings(struct dvb_frontend* fe, struct dvb_frontend_tune_settings* fesettings)
 {
 	fesettings->min_delay_ms = 800;
-	fesettings->step_size = 166667;
-	fesettings->max_drift = 166667*2;
+	/* Drift compensation makes no sense for DVB-T */
+	fesettings->step_size = 0;
+	fesettings->max_drift = 0;
 	return 0;
 }
 
Index: linux-2.6.12-git8/drivers/media/dvb/frontends/tda1004x.h
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/frontends/tda1004x.h	2005-06-27 13:23:02.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/frontends/tda1004x.h	2005-06-27 13:23:05.000000000 +0200
@@ -34,11 +34,15 @@ enum tda10046_xtal {
 enum tda10046_agc {
 	TDA10046_AGC_DEFAULT,		/* original configuration */
 	TDA10046_AGC_IFO_AUTO_NEG,	/* IF AGC only, automatic, negtive */
+	TDA10046_AGC_IFO_AUTO_POS,	/* IF AGC only, automatic, positive */
+	TDA10046_AGC_TDA827X,	    /* IF AGC only, special setup for tda827x */
 };
 
 enum tda10046_if {
 	TDA10046_FREQ_3617,		/* original config, 36,166 MHZ */
 	TDA10046_FREQ_3613,		/* 36,13 MHZ */
+	TDA10046_FREQ_045,		/* low IF, 4.0, 4.5, or 5.0 MHZ */
+	TDA10046_FREQ_052,		/* low IF, 5.1667 MHZ for tda9889 */
 };
 
 struct tda1004x_config

--

