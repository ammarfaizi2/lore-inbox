Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262089AbVF0OCW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262089AbVF0OCW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 10:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbVF0N7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 09:59:47 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:32997 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262090AbVF0MRD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 08:17:03 -0400
Message-Id: <20050627121411.150741000@abc>
References: <20050627120600.739151000@abc>
Date: Mon, 27 Jun 2005 14:06:08 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       Hartmut Hackmann <hartmut.hackmann@t-online.de>
Content-Disposition: inline; filename=dvb-frontends-tda1004x-update.patch
X-SA-Exim-Connect-IP: 84.189.248.249
Subject: [DVB patch 08/51] frontend: tda1004x update
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hartmut Hackmann <hartmut.hackmann@t-online.de>

o added config options for IF frequency and AGC
o support DSP boot from on board eeprom
o added pll sleep call

Signed-off-by: Hartmut Hackmann <hartmut.hackmann@t-online.de>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/frontends/tda1004x.c |  189 ++++++++++++++++-----------------
 drivers/media/dvb/frontends/tda1004x.h |   27 ++++
 drivers/media/dvb/ttpci/budget-av.c    |    4 
 drivers/media/dvb/ttpci/budget-ci.c    |    4 
 4 files changed, 128 insertions(+), 96 deletions(-)

Index: linux-2.6.12-git8/drivers/media/dvb/frontends/tda1004x.c
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/frontends/tda1004x.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/frontends/tda1004x.c	2005-06-27 13:23:02.000000000 +0200
@@ -49,10 +49,8 @@ struct tda1004x_state {
 	/* private demod data */
 	u8 initialised;
 	enum tda1004x_demod demod_type;
-	u8 fw_version;
 };
 
-
 static int debug;
 #define dprintk(args...) \
 	do { \
@@ -315,20 +313,35 @@ static int tda1004x_do_upload(struct tda
 		memcpy(buf + 1, mem + pos, tx_size);
 		fw_msg.len = tx_size + 1;
 		if (i2c_transfer(state->i2c, &fw_msg, 1) != 1) {
-			printk("tda1004x: Error during firmware upload\n");
+			printk(KERN_ERR "tda1004x: Error during firmware upload\n");
 			return -EIO;
 		}
 		pos += tx_size;
 
 		dprintk("%s: fw_pos=0x%x\n", __FUNCTION__, pos);
 	}
+	// give the DSP a chance to settle 03/10/05 Hac
+	msleep(100);
 
 	return 0;
 }
 
-static int tda1004x_check_upload_ok(struct tda1004x_state *state, u8 dspVersion)
+static int tda1004x_check_upload_ok(struct tda1004x_state *state)
 {
 	u8 data1, data2;
+	unsigned long timeout;
+
+	if (state->demod_type == TDA1004X_DEMOD_TDA10046) {
+		timeout = jiffies + 2 * HZ;
+		while(!(tda1004x_read_byte(state, TDA1004X_STATUS_CD) & 0x20)) {
+			if (time_after(jiffies, timeout)) {
+				printk(KERN_ERR "tda1004x: timeout waiting for DSP ready\n");
+				break;
+			}
+			msleep(1);
+		}
+	} else
+		msleep(100);
 
 	// check upload was OK
 	tda1004x_write_mask(state, TDA1004X_CONFC4, 0x10, 0); // we want to read from the DSP
@@ -336,9 +349,11 @@ static int tda1004x_check_upload_ok(stru
 
 	data1 = tda1004x_read_byte(state, TDA1004X_DSP_DATA1);
 	data2 = tda1004x_read_byte(state, TDA1004X_DSP_DATA2);
-	if ((data1 != 0x67) || (data2 != dspVersion))
+	if (data1 != 0x67 || data2 < 0x20 || data2 > 0x2a) {
+		printk(KERN_INFO "tda1004x: found firmware revision %x -- invalid\n", data2);
 		return -EIO;
-
+	}
+	printk(KERN_INFO "tda1004x: found firmware revision %x -- ok\n", data2);
 	return 0;
 }
 
@@ -349,14 +364,14 @@ static int tda10045_fwupload(struct dvb_
 	const struct firmware *fw;
 
 	/* don't re-upload unless necessary */
-	if (tda1004x_check_upload_ok(state, 0x2c) == 0)
+	if (tda1004x_check_upload_ok(state) == 0)
 		return 0;
 
 	/* request the firmware, this will block until someone uploads it */
-	printk("tda1004x: waiting for firmware upload (%s)...\n", TDA10045_DEFAULT_FIRMWARE);
+	printk(KERN_INFO "tda1004x: waiting for firmware upload (%s)...\n", TDA10045_DEFAULT_FIRMWARE);
 	ret = state->config->request_firmware(fe, &fw, TDA10045_DEFAULT_FIRMWARE);
 	if (ret) {
-		printk("tda1004x: no firmware upload (timeout or file not found?)\n");
+		printk(KERN_ERR "tda1004x: no firmware upload (timeout or file not found?)\n");
 		return ret;
 	}
 
@@ -372,93 +387,81 @@ static int tda10045_fwupload(struct dvb_
 	ret = tda1004x_do_upload(state, fw->data, fw->size, TDA10045H_FWPAGE, TDA10045H_CODE_IN);
 	if (ret)
 		return ret;
-	printk("tda1004x: firmware upload complete\n");
+	printk(KERN_INFO "tda1004x: firmware upload complete\n");
 
 	/* wait for DSP to initialise */
 	/* DSPREADY doesn't seem to work on the TDA10045H */
 	msleep(100);
 
-	return tda1004x_check_upload_ok(state, 0x2c);
+	return tda1004x_check_upload_ok(state);
 }
 
-static int tda10046_get_fw_version(struct tda1004x_state *state,
-				   const struct firmware *fw)
+static void tda10046_init_plls(struct dvb_frontend* fe)
 {
-	const unsigned char pattern[] = { 0x67, 0x00, 0x50, 0x62, 0x5e, 0x18, 0x67 };
-	unsigned int i;
+	struct tda1004x_state* state = fe->demodulator_priv;
 
-	/* area guessed from firmware v20, v21 and v25 */
-	for (i = 0x660; i < 0x700; i++) {
-		if (!memcmp(&fw->data[i], pattern, sizeof(pattern))) {
-			state->fw_version = fw->data[i + sizeof(pattern)];
-			printk(KERN_INFO "tda1004x: using firmware v%02x\n",
-					state->fw_version);
-			return 0;
-		}
+	tda1004x_write_byteI(state, TDA10046H_CONFPLL1, 0xf0);
+	tda1004x_write_byteI(state, TDA10046H_CONFPLL2, 10); // PLL M = 10
+	if (state->config->xtal_freq == TDA10046_XTAL_4M ) {
+		dprintk("%s: setting up PLLs for a 4 MHz Xtal\n", __FUNCTION__);
+		tda1004x_write_byteI(state, TDA10046H_CONFPLL3, 0); // PLL P = N = 0
+	} else {
+		dprintk("%s: setting up PLLs for a 16 MHz Xtal\n", __FUNCTION__);
+		tda1004x_write_byteI(state, TDA10046H_CONFPLL3, 3); // PLL P = 0, N = 3
 	}
-
-	return -EINVAL;
+	tda1004x_write_byteI(state, TDA10046H_FREQ_OFFSET, 99);
+	switch (state->config->if_freq) {
+	case TDA10046_FREQ_3617:
+		tda1004x_write_byteI(state, TDA10046H_FREQ_PHY2_MSB, 0xd4);
+		tda1004x_write_byteI(state, TDA10046H_FREQ_PHY2_LSB, 0x2c);
+		break;
+	case TDA10046_FREQ_3613:
+		tda1004x_write_byteI(state, TDA10046H_FREQ_PHY2_MSB, 0xd4);
+		tda1004x_write_byteI(state, TDA10046H_FREQ_PHY2_LSB, 0x13);
+		break;
+	}
+	tda10046h_set_bandwidth(state, BANDWIDTH_8_MHZ); // default bandwidth 8 MHz
 }
 
 static int tda10046_fwupload(struct dvb_frontend* fe)
 {
 	struct tda1004x_state* state = fe->demodulator_priv;
-	unsigned long timeout;
 	int ret;
 	const struct firmware *fw;
 
 	/* reset + wake up chip */
-	tda1004x_write_mask(state, TDA1004X_CONFC4, 1, 0);
+	tda1004x_write_byteI(state, TDA1004X_CONFC4, 0);
 	tda1004x_write_mask(state, TDA10046H_CONF_TRISTATE1, 1, 0);
-	msleep(100);
+	/* let the clocks recover from sleep */
+	msleep(5);
 
 	/* don't re-upload unless necessary */
-	if (tda1004x_check_upload_ok(state, state->fw_version) == 0)
+	if (tda1004x_check_upload_ok(state) == 0)
 		return 0;
 
-	/* request the firmware, this will block until someone uploads it */
-	printk("tda1004x: waiting for firmware upload (%s)...\n", TDA10046_DEFAULT_FIRMWARE);
-	ret = state->config->request_firmware(fe, &fw, TDA10046_DEFAULT_FIRMWARE);
-	if (ret) {
-		printk("tda1004x: no firmware upload (timeout or file not found?)\n");
-		return ret;
-	}
-
-	if (fw->size < 24478) { /* size of firmware v20, which is the smallest of v20, v21 and v25 */
-		printk("tda1004x: firmware file seems to be too small (%d bytes)\n", fw->size);
-		return -EINVAL;
-	}
-
-	ret = tda10046_get_fw_version(state, fw);
-	if (ret < 0) {
-		printk("tda1004x: unable to find firmware version\n");
-		return ret;
-	}
-
 	/* set parameters */
-	tda1004x_write_byteI(state, TDA10046H_CONFPLL2, 10);
-	tda1004x_write_byteI(state, TDA10046H_CONFPLL3, state->config->n_i2c);
-	tda1004x_write_byteI(state, TDA10046H_FREQ_OFFSET, 99);
-	tda1004x_write_byteI(state, TDA10046H_FREQ_PHY2_MSB, 0xd4);
-	tda1004x_write_byteI(state, TDA10046H_FREQ_PHY2_LSB, 0x2c);
-	tda1004x_write_mask(state, TDA1004X_CONFC4, 8, 8); // going to boot from HOST
-
-	ret = tda1004x_do_upload(state, fw->data, fw->size, TDA10046H_CODE_CPT, TDA10046H_CODE_IN);
-	if (ret)
-		return ret;
-	printk("tda1004x: firmware upload complete\n");
+	tda10046_init_plls(fe);
 
-	/* wait for DSP to initialise */
-	timeout = jiffies + HZ;
-	while (!(tda1004x_read_byte(state, TDA1004X_STATUS_CD) & 0x20)) {
-		if (time_after(jiffies, timeout)) {
-			printk("tda1004x: DSP failed to initialised.\n");
-			return -EIO;
+	if (state->config->request_firmware != NULL) {
+		/* request the firmware, this will block until someone uploads it */
+		printk(KERN_INFO "tda1004x: waiting for firmware upload...\n");
+		ret = state->config->request_firmware(fe, &fw, TDA10046_DEFAULT_FIRMWARE);
+		if (ret) {
+			printk(KERN_ERR "tda1004x: no firmware upload (timeout or file not found?)\n");
+   	   		return ret;
 		}
-		msleep(1);
+		tda1004x_write_mask(state, TDA1004X_CONFC4, 8, 8); // going to boot from HOST
+		ret = tda1004x_do_upload(state, fw->data, fw->size, TDA10046H_CODE_CPT, TDA10046H_CODE_IN);
+		if (ret)
+			return ret;
+	} else {
+		/* boot from firmware eeprom */
+		/* Hac Note: we might need to do some GPIO Magic here */
+		printk(KERN_INFO "tda1004x: booting from eeprom\n");
+		tda1004x_write_mask(state, TDA1004X_CONFC4, 4, 4);
+		msleep(300);
 	}
-
-	return tda1004x_check_upload_ok(state, state->fw_version);
+	return tda1004x_check_upload_ok(state);
 }
 
 static int tda1004x_encode_fec(int fec)
@@ -560,12 +563,10 @@ static int tda10046_init(struct dvb_fron
 
 	if (tda10046_fwupload(fe)) {
 		printk("tda1004x: firmware upload failed\n");
-		return -EIO;
+			return -EIO;
 	}
 
-	tda1004x_write_mask(state, TDA1004X_CONFC4, 1, 0); // wake up the chip
-
-	// Init the PLL
+	// Init the tuner PLL
 	if (state->config->pll_init) {
 		tda1004x_enable_tuner_i2c(state);
 		state->config->pll_init(fe);
@@ -574,32 +575,34 @@ static int tda10046_init(struct dvb_fron
 
 	// tda setup
 	tda1004x_write_mask(state, TDA1004X_CONFC4, 0x20, 0); // disable DSP watchdog timer
-	tda1004x_write_mask(state, TDA1004X_CONFC1, 0x40, 0x40);
-	tda1004x_write_mask(state, TDA1004X_AUTO, 8, 0); // select HP stream
-	tda1004x_write_mask(state, TDA1004X_CONFC1, 0x80, 0); // disable pulse killer
-	tda1004x_write_byteI(state, TDA10046H_CONFPLL2, 10); // PLL M = 10
-	tda1004x_write_byteI(state, TDA10046H_CONFPLL3, state->config->n_i2c); // PLL P = N = 0
-	tda1004x_write_byteI(state, TDA10046H_FREQ_OFFSET, 99); // FREQOFFS = 99
-	tda1004x_write_byteI(state, TDA10046H_FREQ_PHY2_MSB, 0xd4); // } PHY2 = -11221
-	tda1004x_write_byteI(state, TDA10046H_FREQ_PHY2_LSB, 0x2c); // }
-	tda1004x_write_byteI(state, TDA10046H_AGC_CONF, 0); // AGC setup
-	tda1004x_write_mask(state, TDA10046H_CONF_POLARITY, 0x60, 0x60); // set AGC polarities
+	tda1004x_write_byteI(state, TDA1004X_AUTO, 7); // select HP stream
+	tda1004x_write_byteI(state, TDA1004X_CONFC1, 8); // disable pulse killer
+
+	tda10046_init_plls(fe);
+	switch (state->config->agc_config) {
+	case TDA10046_AGC_DEFAULT:
+		tda1004x_write_byteI(state, TDA10046H_AGC_CONF, 0x00); // AGC setup
+		tda1004x_write_byteI(state, TDA10046H_CONF_POLARITY, 0x60); // set AGC polarities
+		break;
+	case TDA10046_AGC_IFO_AUTO_NEG:
+		tda1004x_write_byteI(state, TDA10046H_AGC_CONF, 0x0a); // AGC setup
+		tda1004x_write_byteI(state, TDA10046H_CONF_POLARITY, 0x60); // set AGC polarities
+		break;
+	}
+	tda1004x_write_byteI(state, TDA10046H_CONF_TRISTATE1, 0x61); // Turn both AGC outputs on
 	tda1004x_write_byteI(state, TDA10046H_AGC_TUN_MIN, 0);	  // }
 	tda1004x_write_byteI(state, TDA10046H_AGC_TUN_MAX, 0xff); // } AGC min/max values
 	tda1004x_write_byteI(state, TDA10046H_AGC_IF_MIN, 0);	  // }
 	tda1004x_write_byteI(state, TDA10046H_AGC_IF_MAX, 0xff);  // }
-	tda1004x_write_mask(state, TDA10046H_CVBER_CTRL, 0x30, 0x10); // 10^6 VBER measurement bits
 	tda1004x_write_byteI(state, TDA10046H_AGC_GAINS, 1); // IF gain 2, TUN gain 1
-	tda1004x_write_mask(state, TDA1004X_AUTO, 0x80, 0); // crystal is 50ppm
+	tda1004x_write_byteI(state, TDA10046H_CVBER_CTRL, 0x1a); // 10^6 VBER measurement bits
 	tda1004x_write_byteI(state, TDA1004X_CONF_TS1, 7); // MPEG2 interface config
-	tda1004x_write_mask(state, TDA1004X_CONF_TS2, 0x31, 0); // MPEG2 interface config
-	tda1004x_write_mask(state, TDA10046H_CONF_TRISTATE1, 0x9e, 0); // disable AGC_TUN
+	tda1004x_write_byteI(state, TDA1004X_CONF_TS2, 0xc0); // MPEG2 interface config
+	tda1004x_write_mask(state, 0x3a, 0x80, state->config->invert_oclk << 7);
+
 	tda1004x_write_byteI(state, TDA10046H_CONF_TRISTATE2, 0xe1); // tristate setup
 	tda1004x_write_byteI(state, TDA10046H_GPIO_OUT_SEL, 0xcc); // GPIO output config
-	tda1004x_write_mask(state, TDA10046H_GPIO_SELECT, 8, 8); // GPIO select
-	tda10046h_set_bandwidth(state, BANDWIDTH_8_MHZ); // default bandwidth 8 MHz
-
-	tda1004x_write_mask(state, 0x3a, 0x80, state->config->invert_oclk << 7);
+	tda1004x_write_byteI(state, TDA10046H_GPIO_SELECT, 8); // GPIO select
 
 	state->initialised = 1;
 	return 0;
@@ -629,9 +632,6 @@ static int tda1004x_set_fe(struct dvb_fr
 	state->config->pll_set(fe, fe_params);
 	tda1004x_disable_tuner_i2c(state);
 
-	if (state->demod_type == TDA1004X_DEMOD_TDA10046)
-		tda1004x_write_mask(state, TDA10046H_AGC_CONF, 4, 4);
-
 	// Hardcoded to use auto as much as possible on the TDA10045 as it
 	// is very unreliable if AUTO mode is _not_ used.
 	if (state->demod_type == TDA1004X_DEMOD_TDA10045) {
@@ -1090,6 +1090,8 @@ static int tda1004x_sleep(struct dvb_fro
 
 	case TDA1004X_DEMOD_TDA10046:
 		tda1004x_write_mask(state, TDA1004X_CONFC4, 1, 1);
+		if (state->config->pll_sleep != NULL)
+			state->config->pll_sleep(fe);
 		break;
 	}
 	state->initialised = 0;
@@ -1216,7 +1218,6 @@ struct dvb_frontend* tda10046_attach(con
 	memcpy(&state->ops, &tda10046_ops, sizeof(struct dvb_frontend_ops));
 	state->initialised = 0;
 	state->demod_type = TDA1004X_DEMOD_TDA10046;
-	state->fw_version = 0x20;	/* dummy default value */
 
 	/* check if the demod is there */
 	if (tda1004x_read_byte(state, TDA1004X_CHIPID) != 0x46) {
Index: linux-2.6.12-git8/drivers/media/dvb/frontends/tda1004x.h
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/frontends/tda1004x.h	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/frontends/tda1004x.h	2005-06-27 13:23:02.000000000 +0200
@@ -26,6 +26,21 @@
 #include <linux/dvb/frontend.h>
 #include <linux/firmware.h>
 
+enum tda10046_xtal {
+	TDA10046_XTAL_4M,
+	TDA10046_XTAL_16M,
+};
+
+enum tda10046_agc {
+	TDA10046_AGC_DEFAULT,		/* original configuration */
+	TDA10046_AGC_IFO_AUTO_NEG,	/* IF AGC only, automatic, negtive */
+};
+
+enum tda10046_if {
+	TDA10046_FREQ_3617,		/* original config, 36,166 MHZ */
+	TDA10046_FREQ_3613,		/* 36,13 MHZ */
+};
+
 struct tda1004x_config
 {
 	/* the demodulator's i2c address */
@@ -37,14 +52,22 @@ struct tda1004x_config
 	/* Does the OCLK signal need inverted? */
 	u8 invert_oclk;
 
-	/* value of N_I2C of the CONF_PLL3 register */
-	u8 n_i2c;
+	/* Xtal frequency, 4 or 16MHz*/
+	enum tda10046_xtal xtal_freq;
+
+	/* IF frequency */
+	enum tda10046_if if_freq;
+
+	/* AGC configuration */
+	enum tda10046_agc agc_config;
 
 	/* PLL maintenance */
 	int (*pll_init)(struct dvb_frontend* fe);
+	void (*pll_sleep)(struct dvb_frontend* fe);
 	int (*pll_set)(struct dvb_frontend* fe, struct dvb_frontend_parameters* params);
 
 	/* request firmware for device */
+	/* set this to NULL if the card has a firmware EEPROM */
 	int (*request_firmware)(struct dvb_frontend* fe, const struct firmware **fw, char* name);
 };
 
Index: linux-2.6.12-git8/drivers/media/dvb/ttpci/budget-av.c
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/ttpci/budget-av.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/ttpci/budget-av.c	2005-06-27 13:23:02.000000000 +0200
@@ -695,8 +695,12 @@ static struct tda1004x_config philips_tu
 	.demod_address = 0x8,
 	.invert = 1,
 	.invert_oclk = 1,
+	.xtal_freq = TDA10046_XTAL_4M,
+	.agc_config = TDA10046_AGC_DEFAULT,
+	.if_freq = TDA10046_FREQ_3617,
 	.pll_init = philips_tu1216_pll_init,
 	.pll_set = philips_tu1216_pll_set,
+	.pll_sleep = NULL,
 	.request_firmware = philips_tu1216_request_firmware,
 };
 
Index: linux-2.6.12-git8/drivers/media/dvb/ttpci/budget-ci.c
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/ttpci/budget-ci.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/ttpci/budget-ci.c	2005-06-27 13:23:02.000000000 +0200
@@ -838,8 +838,12 @@ static struct tda1004x_config philips_td
 	.demod_address = 0x8,
 	.invert = 0,
 	.invert_oclk = 0,
+	.xtal_freq = TDA10046_XTAL_4M,
+	.agc_config = TDA10046_AGC_DEFAULT,
+	.if_freq = TDA10046_FREQ_3617,
 	.pll_init = philips_tdm1316l_pll_init,
 	.pll_set = philips_tdm1316l_pll_set,
+	.pll_sleep = NULL,
 	.request_firmware = philips_tdm1316l_request_firmware,
 };
 

--

