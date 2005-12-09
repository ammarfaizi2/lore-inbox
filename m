Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932766AbVLIAYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932766AbVLIAYf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 19:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932767AbVLIAYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 19:24:35 -0500
Received: from smtp3.brturbo.com.br ([200.199.201.164]:10198 "EHLO
	smtp3.brturbo.com.br") by vger.kernel.org with ESMTP
	id S932766AbVLIAYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 19:24:33 -0500
Subject: [PATCH 18/56] DVB (2421) Fixed oddities at firmware download
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, mchehab@infradead.org, js@linuxtv.org,
       akpm@osdl.org, linux-dvb-maintainer@linuxtv.org,
       Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Content-Type: text/plain
Date: Thu, 08 Dec 2005 22:24:29 -0200
Message-Id: <1134087869.7047.230.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2-1mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hartmut Hackmann <hartmut.hackmann@t-online.de>

- Fixed oddities at firmware download
- more tolerant vs crystal frequency offset
- lower sampling clock

Signed-off-by: Hartmut Hackmann <hartmut.hackmann@t-online.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

---

--- linux-2.6.15-rc2-git6.orig/drivers/media/dvb/frontends/tda1004x.c
+++ linux-2.6.15-rc2-git6/drivers/media/dvb/frontends/tda1004x.c
@@ -271,32 +271,57 @@
 static int tda10046h_set_bandwidth(struct tda1004x_state *state,
 				   fe_bandwidth_t bandwidth)
 {
-	static u8 bandwidth_6mhz[] = { 0x80, 0x15, 0xfe, 0xab, 0x8e };
-	static u8 bandwidth_7mhz[] = { 0x6e, 0x02, 0x53, 0xc8, 0x25 };
-	static u8 bandwidth_8mhz[] = { 0x60, 0x12, 0xa8, 0xe4, 0xbd };
-
+	static u8 bandwidth_6mhz_53M[] = { 0x7b, 0x2e, 0x11, 0xf0, 0xd2 };
+	static u8 bandwidth_7mhz_53M[] = { 0x6a, 0x02, 0x6a, 0x43, 0x9f };
+	static u8 bandwidth_8mhz_53M[] = { 0x5c, 0x32, 0xc2, 0x96, 0x6d };
+
+	static u8 bandwidth_6mhz_48M[] = { 0x70, 0x02, 0x49, 0x24, 0x92 };
+	static u8 bandwidth_7mhz_48M[] = { 0x60, 0x02, 0xaa, 0xaa, 0xab };
+	static u8 bandwidth_8mhz_48M[] = { 0x54, 0x03, 0x0c, 0x30, 0xc3 };
+	int tda10046_clk53m;
+
+	if ((state->config->if_freq == TDA10046_FREQ_045) ||
+	    (state->config->if_freq == TDA10046_FREQ_052))
+		tda10046_clk53m = 0;
+	else
+		tda10046_clk53m = 1;
 	switch (bandwidth) {
 	case BANDWIDTH_6_MHZ:
-		tda1004x_write_buf(state, TDA10046H_TIME_WREF1, bandwidth_6mhz, sizeof(bandwidth_6mhz));
+		if (tda10046_clk53m)
+			tda1004x_write_buf(state, TDA10046H_TIME_WREF1, bandwidth_6mhz_53M,
+					          sizeof(bandwidth_6mhz_53M));
+		else
+			tda1004x_write_buf(state, TDA10046H_TIME_WREF1, bandwidth_6mhz_48M,
+					          sizeof(bandwidth_6mhz_48M));
 		if (state->config->if_freq == TDA10046_FREQ_045) {
-			tda1004x_write_byteI(state, TDA10046H_FREQ_PHY2_MSB, 0x09);
-			tda1004x_write_byteI(state, TDA10046H_FREQ_PHY2_LSB, 0x4f);
+			tda1004x_write_byteI(state, TDA10046H_FREQ_PHY2_MSB, 0x0a);
+			tda1004x_write_byteI(state, TDA10046H_FREQ_PHY2_LSB, 0xab);
 		}
 		break;
 
 	case BANDWIDTH_7_MHZ:
-		tda1004x_write_buf(state, TDA10046H_TIME_WREF1, bandwidth_7mhz, sizeof(bandwidth_7mhz));
+		if (tda10046_clk53m)
+			tda1004x_write_buf(state, TDA10046H_TIME_WREF1, bandwidth_7mhz_53M,
+					          sizeof(bandwidth_7mhz_53M));
+		else
+			tda1004x_write_buf(state, TDA10046H_TIME_WREF1, bandwidth_7mhz_48M,
+					          sizeof(bandwidth_7mhz_48M));
 		if (state->config->if_freq == TDA10046_FREQ_045) {
-			tda1004x_write_byteI(state, TDA10046H_FREQ_PHY2_MSB, 0x0a);
-			tda1004x_write_byteI(state, TDA10046H_FREQ_PHY2_LSB, 0x79);
+			tda1004x_write_byteI(state, TDA10046H_FREQ_PHY2_MSB, 0x0c);
+			tda1004x_write_byteI(state, TDA10046H_FREQ_PHY2_LSB, 0x00);
 		}
 		break;
 
 	case BANDWIDTH_8_MHZ:
-		tda1004x_write_buf(state, TDA10046H_TIME_WREF1, bandwidth_8mhz, sizeof(bandwidth_8mhz));
+		if (tda10046_clk53m)
+			tda1004x_write_buf(state, TDA10046H_TIME_WREF1, bandwidth_8mhz_53M,
+					          sizeof(bandwidth_8mhz_53M));
+		else
+			tda1004x_write_buf(state, TDA10046H_TIME_WREF1, bandwidth_8mhz_48M,
+					          sizeof(bandwidth_8mhz_48M));
 		if (state->config->if_freq == TDA10046_FREQ_045) {
-			tda1004x_write_byteI(state, TDA10046H_FREQ_PHY2_MSB, 0x0b);
-			tda1004x_write_byteI(state, TDA10046H_FREQ_PHY2_LSB, 0xa3);
+			tda1004x_write_byteI(state, TDA10046H_FREQ_PHY2_MSB, 0x0d);
+			tda1004x_write_byteI(state, TDA10046H_FREQ_PHY2_LSB, 0x55);
 		}
 		break;
 
@@ -418,9 +443,22 @@
 static void tda10046_init_plls(struct dvb_frontend* fe)
 {
 	struct tda1004x_state* state = fe->demodulator_priv;
+	int tda10046_clk53m;
+
+	if ((state->config->if_freq == TDA10046_FREQ_045) ||
+	    (state->config->if_freq == TDA10046_FREQ_052))
+		tda10046_clk53m = 0;
+	else
+		tda10046_clk53m = 1;
 
 	tda1004x_write_byteI(state, TDA10046H_CONFPLL1, 0xf0);
-	tda1004x_write_byteI(state, TDA10046H_CONFPLL2, 0x0a); // PLL M = 10
+	if(tda10046_clk53m) {
+		printk(KERN_INFO "tda1004x: setting up plls for 53MHz sampling clock\n");
+		tda1004x_write_byteI(state, TDA10046H_CONFPLL2, 0x08); // PLL M = 8
+	} else {
+		printk(KERN_INFO "tda1004x: setting up plls for 48MHz sampling clock\n");
+		tda1004x_write_byteI(state, TDA10046H_CONFPLL2, 0x03); // PLL M = 3
+	}
 	if (state->config->xtal_freq == TDA10046_XTAL_4M ) {
 		dprintk("%s: setting up PLLs for a 4 MHz Xtal\n", __FUNCTION__);
 		tda1004x_write_byteI(state, TDA10046H_CONFPLL3, 0); // PLL P = N = 0
@@ -428,26 +466,32 @@
 		dprintk("%s: setting up PLLs for a 16 MHz Xtal\n", __FUNCTION__);
 		tda1004x_write_byteI(state, TDA10046H_CONFPLL3, 3); // PLL P = 0, N = 3
 	}
-	tda1004x_write_byteI(state, TDA10046H_FREQ_OFFSET, 99);
+	if(tda10046_clk53m)
+		tda1004x_write_byteI(state, TDA10046H_FREQ_OFFSET, 0x67);
+	else
+		tda1004x_write_byteI(state, TDA10046H_FREQ_OFFSET, 0x72);
+	/* Note clock frequency is handled implicitly */
 	switch (state->config->if_freq) {
-	case TDA10046_FREQ_3617:
-		tda1004x_write_byteI(state, TDA10046H_FREQ_PHY2_MSB, 0xd4);
-		tda1004x_write_byteI(state, TDA10046H_FREQ_PHY2_LSB, 0x2c);
-		break;
-	case TDA10046_FREQ_3613:
-		tda1004x_write_byteI(state, TDA10046H_FREQ_PHY2_MSB, 0xd4);
-		tda1004x_write_byteI(state, TDA10046H_FREQ_PHY2_LSB, 0x13);
-		break;
 	case TDA10046_FREQ_045:
-		tda1004x_write_byteI(state, TDA10046H_FREQ_PHY2_MSB, 0x0b);
-		tda1004x_write_byteI(state, TDA10046H_FREQ_PHY2_LSB, 0xa3);
+		tda1004x_write_byteI(state, TDA10046H_FREQ_PHY2_MSB, 0x0c);
+		tda1004x_write_byteI(state, TDA10046H_FREQ_PHY2_LSB, 0x00);
 		break;
 	case TDA10046_FREQ_052:
-		tda1004x_write_byteI(state, TDA10046H_FREQ_PHY2_MSB, 0x0c);
-		tda1004x_write_byteI(state, TDA10046H_FREQ_PHY2_LSB, 0x06);
+		tda1004x_write_byteI(state, TDA10046H_FREQ_PHY2_MSB, 0x0d);
+		tda1004x_write_byteI(state, TDA10046H_FREQ_PHY2_LSB, 0xc7);
+		break;
+	case TDA10046_FREQ_3617:
+		tda1004x_write_byteI(state, TDA10046H_FREQ_PHY2_MSB, 0xd7);
+		tda1004x_write_byteI(state, TDA10046H_FREQ_PHY2_LSB, 0x59);
+		break;
+	case TDA10046_FREQ_3613:
+		tda1004x_write_byteI(state, TDA10046H_FREQ_PHY2_MSB, 0xd7);
+		tda1004x_write_byteI(state, TDA10046H_FREQ_PHY2_LSB, 0x3f);
 		break;
 	}
 	tda10046h_set_bandwidth(state, BANDWIDTH_8_MHZ); // default bandwidth 8 MHz
+	/* let the PLLs settle */
+	msleep(120);
 }
 
 static int tda10046_fwupload(struct dvb_frontend* fe)
@@ -462,13 +506,13 @@
 	/* let the clocks recover from sleep */
 	msleep(5);
 
+	/* The PLLs need to be reprogrammed after sleep */
+	tda10046_init_plls(fe);
+
 	/* don't re-upload unless necessary */
 	if (tda1004x_check_upload_ok(state) == 0)
 		return 0;
 
-	/* set parameters */
-	tda10046_init_plls(fe);
-
 	if (state->config->request_firmware != NULL) {
 		/* request the firmware, this will block until someone uploads it */
 		printk(KERN_INFO "tda1004x: waiting for firmware upload...\n");
@@ -484,7 +528,6 @@
 			return ret;
 	} else {
 		/* boot from firmware eeprom */
-		/* Hac Note: we might need to do some GPIO Magic here */
 		printk(KERN_INFO "tda1004x: booting from eeprom\n");
 		tda1004x_write_mask(state, TDA1004X_CONFC4, 4, 4);
 		msleep(300);
@@ -606,10 +649,9 @@
 
 	// tda setup
 	tda1004x_write_mask(state, TDA1004X_CONFC4, 0x20, 0); // disable DSP watchdog timer
-	tda1004x_write_byteI(state, TDA1004X_AUTO, 7); // select HP stream
-	tda1004x_write_byteI(state, TDA1004X_CONFC1, 8); // disable pulse killer
+	tda1004x_write_byteI(state, TDA1004X_AUTO, 0x87);    // 100 ppm crystal, select HP stream
+	tda1004x_write_byteI(state, TDA1004X_CONFC1, 8);      // disable pulse killer
 
-	tda10046_init_plls(fe);
 	switch (state->config->agc_config) {
 	case TDA10046_AGC_DEFAULT:
 		tda1004x_write_byteI(state, TDA10046H_AGC_CONF, 0x00); // AGC setup
@@ -626,25 +668,22 @@
 	case TDA10046_AGC_TDA827X:
 		tda1004x_write_byteI(state, TDA10046H_AGC_CONF, 0x02);   // AGC setup
 		tda1004x_write_byteI(state, TDA10046H_AGC_THR, 0x70);    // AGC Threshold
-		tda1004x_write_byteI(state, TDA10046H_AGC_RENORM, 0x0E); // Gain Renormalize
-		tda1004x_write_byteI(state, TDA10046H_CONF_POLARITY, 0x60); // set AGC polarities
+		tda1004x_write_byteI(state, TDA10046H_AGC_RENORM, 0x08); // Gain Renormalize
+		tda1004x_write_byteI(state, TDA10046H_CONF_POLARITY, 0x6a); // set AGC polarities
 		break;
 	}
+	tda1004x_write_byteI(state, TDA1004X_CONFADC2, 0x38);
 	tda1004x_write_byteI(state, TDA10046H_CONF_TRISTATE1, 0x61); // Turn both AGC outputs on
 	tda1004x_write_byteI(state, TDA10046H_AGC_TUN_MIN, 0);	  // }
 	tda1004x_write_byteI(state, TDA10046H_AGC_TUN_MAX, 0xff); // } AGC min/max values
 	tda1004x_write_byteI(state, TDA10046H_AGC_IF_MIN, 0);	  // }
 	tda1004x_write_byteI(state, TDA10046H_AGC_IF_MAX, 0xff);  // }
-	tda1004x_write_byteI(state, TDA10046H_AGC_GAINS, 1); // IF gain 2, TUN gain 1
+	tda1004x_write_byteI(state, TDA10046H_AGC_GAINS, 0x12); // IF gain 2, TUN gain 1
 	tda1004x_write_byteI(state, TDA10046H_CVBER_CTRL, 0x1a); // 10^6 VBER measurement bits
 	tda1004x_write_byteI(state, TDA1004X_CONF_TS1, 7); // MPEG2 interface config
 	tda1004x_write_byteI(state, TDA1004X_CONF_TS2, 0xc0); // MPEG2 interface config
 	tda1004x_write_mask(state, 0x3a, 0x80, state->config->invert_oclk << 7);
 
-	tda1004x_write_byteI(state, TDA10046H_CONF_TRISTATE2, 0xe1); // tristate setup
-	tda1004x_write_byteI(state, TDA10046H_GPIO_OUT_SEL, 0xcc); // GPIO output config
-	tda1004x_write_byteI(state, TDA10046H_GPIO_SELECT, 8); // GPIO select
-
 	state->initialised = 1;
 	return 0;
 }
@@ -686,9 +725,9 @@
 
 	// Set standard params.. or put them to auto
 	if ((fe_params->u.ofdm.code_rate_HP == FEC_AUTO) ||
-	    (fe_params->u.ofdm.code_rate_LP == FEC_AUTO) ||
-	    (fe_params->u.ofdm.constellation == QAM_AUTO) ||
-	    (fe_params->u.ofdm.hierarchy_information == HIERARCHY_AUTO)) {
+		(fe_params->u.ofdm.code_rate_LP == FEC_AUTO) ||
+		(fe_params->u.ofdm.constellation == QAM_AUTO) ||
+		(fe_params->u.ofdm.hierarchy_information == HIERARCHY_AUTO)) {
 		tda1004x_write_mask(state, TDA1004X_AUTO, 1, 1);	// enable auto
 		tda1004x_write_mask(state, TDA1004X_IN_CONF1, 0x03, 0);	// turn off constellation bits
 		tda1004x_write_mask(state, TDA1004X_IN_CONF1, 0x60, 0);	// turn off hierarchy bits
@@ -851,6 +890,7 @@
 static int tda1004x_get_fe(struct dvb_frontend* fe, struct dvb_frontend_parameters *fe_params)
 {
 	struct tda1004x_state* state = fe->demodulator_priv;
+
 	dprintk("%s\n", __FUNCTION__);
 
 	// inversion status
@@ -875,16 +915,18 @@
 			break;
 		}
 		break;
-
 	case TDA1004X_DEMOD_TDA10046:
 		switch (tda1004x_read_byte(state, TDA10046H_TIME_WREF1)) {
-		case 0x60:
+		case 0x5c:
+		case 0x54:
 			fe_params->u.ofdm.bandwidth = BANDWIDTH_8_MHZ;
 			break;
-		case 0x6e:
+		case 0x6a:
+		case 0x60:
 			fe_params->u.ofdm.bandwidth = BANDWIDTH_7_MHZ;
 			break;
-		case 0x80:
+		case 0x7b:
+		case 0x70:
 			fe_params->u.ofdm.bandwidth = BANDWIDTH_6_MHZ;
 			break;
 		}

