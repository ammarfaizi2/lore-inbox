Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262293AbVCVCX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262293AbVCVCX1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 21:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262374AbVCVCWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 21:22:41 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:44682 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262293AbVCVBe0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:34:26 -0500
Message-Id: <20050322013454.561009000@abc>
References: <20050322013427.919515000@abc>
Date: Tue, 22 Mar 2005 02:23:35 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-frontend-dib3000x.patch
X-SA-Exim-Connect-IP: 217.231.55.169
Subject: [DVB patch 02/48] dibcom: frontend fixes
X-SA-Exim-Version: 4.2 (built Tue, 25 Jan 2005 19:36:50 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

o corrected the name in driver_desc
o removed debug messages and some comments (see dib3000-watch)
(Patrick Boettcher)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 dib3000mb.c |   68 +++++++-----------------------------------------------------
 dib3000mc.c |    2 -
 2 files changed, 9 insertions(+), 61 deletions(-)

Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/dib3000mb.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/frontends/dib3000mb.c	2005-03-21 23:27:59.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/dib3000mb.c	2005-03-22 00:14:30.000000000 +0100
@@ -35,7 +35,7 @@
 
 /* Version information */
 #define DRIVER_VERSION "0.1"
-#define DRIVER_DESC "DiBcom 3000-MB DVB-T demodulator driver"
+#define DRIVER_DESC "DiBcom 3000M-B DVB-T demodulator driver"
 #define DRIVER_AUTHOR "Patrick Boettcher, patrick.boettcher@desy.de"
 
 #ifdef CONFIG_DVB_DIBCOM_DEBUG
@@ -297,7 +297,7 @@ static int dib3000mb_set_frontend(struct
 					rd(DIB3000MB_REG_LOCK2_VALUE))) < 0 && as_count++ < 100)
 			msleep(1);
 
-		deb_info("search_state after autosearch %d after %d checks\n",search_state,as_count);
+		deb_setf("search_state after autosearch %d after %d checks\n",search_state,as_count);
 
 		if (search_state == 1) {
 			struct dvb_frontend_parameters feps;
@@ -319,6 +319,7 @@ static int dib3000mb_fe_init(struct dvb_
 {
 	struct dib3000_state* state = (struct dib3000_state*) fe->demodulator_priv;
 
+	deb_info("dib3000mb is getting up.\n");
 	wr(DIB3000MB_REG_POWER_CONTROL, DIB3000MB_POWER_UP);
 
 	wr(DIB3000MB_REG_RESTART, DIB3000MB_RESTART_AGC);
@@ -574,16 +575,9 @@ static int dib3000mb_read_status(struct 
 	if (rd(DIB3000MB_REG_TS_SYNC_LOCK))
 		*stat |= (FE_HAS_SYNC | FE_HAS_LOCK);
 
-	deb_info("actual status is %2x\n",*stat);
+	deb_getf("actual status is %2x\n",*stat);
 
-	deb_getf("tps %x %x %x %x %x\n",
-			rd(DIB3000MB_REG_TPS_1),
-			rd(DIB3000MB_REG_TPS_2),
-			rd(DIB3000MB_REG_TPS_3),
-			rd(DIB3000MB_REG_TPS_4),
-			rd(DIB3000MB_REG_TPS_5));
-
-	deb_info("autoval: tps: %d, qam: %d, hrch: %d, alpha: %d, hp: %d, lp: %d, guard: %d, fft: %d cell: %d\n",
+	deb_getf("autoval: tps: %d, qam: %d, hrch: %d, alpha: %d, hp: %d, lp: %d, guard: %d, fft: %d cell: %d\n",
 			rd(DIB3000MB_REG_TPS_LOCK),
 			rd(DIB3000MB_REG_TPS_QAM),
 			rd(DIB3000MB_REG_TPS_HRCH),
@@ -605,68 +599,22 @@ static int dib3000mb_read_ber(struct dvb
 	*ber = ((rd(DIB3000MB_REG_BER_MSB) << 16) | rd(DIB3000MB_REG_BER_LSB));
 	return 0;
 }
-/*
- * Amaury:
- * signal strength is measured with dBm (power compared to mW)
- * the standard range is -90dBm(low power) to -10 dBm (strong power),
- * but the calibration is done for -100 dBm to 0dBm
- */
-
-#define DIB3000MB_AGC_REF_dBm		-14
-#define DIB3000MB_GAIN_SLOPE_dBm	100
-#define DIB3000MB_GAIN_DELTA_dBm	-2
+
+/* see dib3000-watch dvb-apps for exact calcuations of signal_strength and snr */
 static int dib3000mb_read_signal_strength(struct dvb_frontend* fe, u16 *strength)
 {
 	struct dib3000_state* state = (struct dib3000_state*) fe->demodulator_priv;
 
-/* TODO log10
-	u16 sigpow = rd(DIB3000MB_REG_SIGNAL_POWER),
-		n_agc_power = rd(DIB3000MB_REG_AGC_POWER),
-		rf_power = rd(DIB3000MB_REG_RF_POWER);
-	double rf_power_dBm, ad_power_dBm, minar_power_dBm;
-
-	if (n_agc_power == 0 )
-		n_agc_power = 1 ;
-
-	ad_power_dBm    = 10 * log10 ( (float)n_agc_power / (float)(1<<16) );
-	minor_power_dBm = ad_power_dBm - DIB3000MB_AGC_REF_dBm;
-	rf_power_dBm = (-DIB3000MB_GAIN_SLOPE_dBm * (float)rf_power / (float)(1<<16) +
-			DIB3000MB_GAIN_DELTA_dBm) + minor_power_dBm;
-	// relative rf_power
-	*strength = (u16) ((rf_power_dBm + 100) / 100 * 0xffff);
-*/
 	*strength = rd(DIB3000MB_REG_SIGNAL_POWER) * 0xffff / 0x170;
 	return 0;
 }
 
-/*
- * Amaury:
- * snr is the signal quality measured in dB.
- * snr = 10*log10(signal power / noise power)
- * the best quality is near 35dB (cable transmission & good modulator)
- * the minimum without errors depend of transmission parameters
- * some indicative values are given in en300744 Annex A
- * ex : 16QAM 2/3 (Gaussian)  = 11.1 dB
- *
- * If SNR is above 20dB, BER should be always 0.
- * choose 0dB as the minimum
- */
 static int dib3000mb_read_snr(struct dvb_frontend* fe, u16 *snr)
 {
 	struct dib3000_state* state = (struct dib3000_state*) fe->demodulator_priv;
 	short sigpow = rd(DIB3000MB_REG_SIGNAL_POWER);
 	int icipow = ((rd(DIB3000MB_REG_NOISE_POWER_MSB) & 0xff) << 16) |
 		rd(DIB3000MB_REG_NOISE_POWER_LSB);
-/*
-	float snr_dBm=0;
-
-	if (sigpow > 0 && icipow > 0)
-		snr_dBm = 10.0 * log10( (float) (sigpow<<8) / (float)icipow )  ;
-	else if (sigpow > 0)
-		snr_dBm = 35;
-
-	*snr = (u16) ((snr_dBm / 35) * 0xffff);
-*/
 	*snr = (sigpow << 8) / ((icipow > 0) ? icipow : 1);
 	return 0;
 }
@@ -682,7 +630,7 @@ static int dib3000mb_read_unc_blocks(str
 static int dib3000mb_sleep(struct dvb_frontend* fe)
 {
 	struct dib3000_state* state = (struct dib3000_state*) fe->demodulator_priv;
-
+	deb_info("dib3000mb is going to bed.\n");
 	wr(DIB3000MB_REG_POWER_CONTROL, DIB3000MB_POWER_DOWN);
 	return 0;
 }
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/dib3000mc.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/frontends/dib3000mc.c	2005-03-21 23:27:59.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/dib3000mc.c	2005-03-22 00:14:30.000000000 +0100
@@ -34,7 +34,7 @@
 
 /* Version information */
 #define DRIVER_VERSION "0.1"
-#define DRIVER_DESC "DiBcom 3000-MC DVB-T demodulator driver"
+#define DRIVER_DESC "DiBcom 3000M-C DVB-T demodulator driver"
 #define DRIVER_AUTHOR "Patrick Boettcher, patrick.boettcher@desy.de"
 
 #ifdef CONFIG_DVB_DIBCOM_DEBUG

--

