Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262364AbUJ0KSz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262364AbUJ0KSz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 06:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262367AbUJ0KSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 06:18:55 -0400
Received: from mail.convergence.de ([212.227.36.84]:60831 "EHLO
	email.convergence2.de") by vger.kernel.org with ESMTP
	id S262364AbUJ0J4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 05:56:34 -0400
Message-ID: <417F70A8.8000800@linuxtv.org>
Date: Wed, 27 Oct 2004 11:55:52 +0200
From: Michael Hunold <hunold@linuxtv.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH][5/5] DVB: misc. updates to frontend drivers
References: <417F6EB2.2070807@linuxtv.org> <417F6F0D.9020109@linuxtv.org> <417F6F87.5090703@linuxtv.org> <417F6FD3.3090003@linuxtv.org> <417F702B.9050909@linuxtv.org>
In-Reply-To: <417F702B.9050909@linuxtv.org>
Content-Type: multipart/mixed;
 boundary="------------000108050201020905020105"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000108050201020905020105
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------000108050201020905020105
Content-Type: text/plain;
 name="05-dvb-frontend-update.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="05-dvb-frontend-update.diff"

- [DVB] add legacy DishNetwork support to dvb core and stv0299, thanks to Jeremy Hall
- [DVB] mt352: major cleanup, support DVICO FusionHDTV DVB-T, thanks to Christopher Pascoe

Signed-off-by: Michael Hunold <hunold@linuxtv.org>

diff -uraNwB linux-2.6.10-rc1/include/linux/dvb/frontend.h linux-2.6.10-rc1-patched/include/linux/dvb/frontend.h
--- linux-2.6.10-rc1/include/linux/dvb/frontend.h	2004-10-25 14:03:20.000000000 +0200
+++ linux-2.6.10-rc1-patched/include/linux/dvb/frontend.h	2004-10-25 14:14:44.000000000 +0200
@@ -258,6 +258,8 @@
 #define FE_GET_FRONTEND            _IOR('o', 77, struct dvb_frontend_parameters)
 #define FE_GET_EVENT               _IOR('o', 78, struct dvb_frontend_event)
 
+#define FE_DISHNETWORK_SEND_LEGACY_CMD _IO('o', 80) /* unsigned int */
+
 
 #endif /*_DVBFRONTEND_H_*/
 diff -uraNwB linux-2.6.10-rc1/drivers/media/dvb/frontends/stv0299.c linux-2.6.10-rc1-patched/drivers/media/dvb/frontends/stv0299.c
--- linux-2.6.10-rc1/drivers/media/dvb/frontends/stv0299.c	2004-10-25 14:07:56.000000000 +0200
+++ linux-2.6.10-rc1-patched/drivers/media/dvb/frontends/stv0299.c	2004-10-25 14:14:43.000000000 +0200
@@ -885,6 +885,43 @@
 }
 
 
+static int stv0299_send_legacy_dish_cmd(struct i2c_adapter *i2c, u32 cmd, 
+                                        int tuner_type)
+{
+	u8 last = 1;
+	int i;
+
+	/* reset voltage at the end
+	if((0x50 & stv0299_readreg (i2c, 0x0c)) == 0x50)
+		cmd |= 0x80;
+	else
+		cmd &= 0x7F;
+	*/
+
+	cmd = cmd << 1;
+	dprintk("%s switch command: 0x%04x\n",__FUNCTION__, cmd);
+
+	stv0299_set_voltage(i2c,SEC_VOLTAGE_18,tuner_type);
+	msleep(32);
+
+	for (i=0; i<9; i++) {
+		if((cmd & 0x01) != last) {
+			stv0299_set_voltage(i2c,
+					    last ? SEC_VOLTAGE_13 :
+					    	   SEC_VOLTAGE_18,
+					    tuner_type);
+			last = (last) ? 0 : 1;
+		}
+
+		cmd = cmd >> 1;
+
+		if (i != 8)
+			msleep(8);
+	}
+
+	return 0;
+}
+
 static int stv0299_set_symbolrate (struct i2c_adapter *i2c, u32 srate, int tuner_type)
 {
 	u64 big = srate;
@@ -1229,6 +1266,10 @@
 		return stv0299_set_voltage (i2c, (fe_sec_voltage_t) arg,
 					    state->tuner_type);
 
+	case FE_DISHNETWORK_SEND_LEGACY_CMD:
+		return stv0299_send_legacy_dish_cmd (i2c, (u32) arg,
+						     state->tuner_type);
+
 	case FE_GET_TUNE_SETTINGS:
 	{
 		struct dvb_frontend_tune_settings* fesettings = (struct dvb_frontend_tune_settings*) arg;
@@ -1276,12 +1317,12 @@
         u8 stat [] = { 0 };
 	u8 tda6100_buf [] = { 0, 0 };
 	int ret;
-	struct i2c_msg msg1 [] = {{ .addr = 0x68, .buf = rpt,  .len = 2 },
+	struct i2c_msg msg1 [] = {{ .addr = 0x68, .flags = 0, .buf = rpt,  len: 2 },
 			   { .addr = 0x60, .flags = I2C_M_RD, .buf = stat, .len = 1 }};
-	struct i2c_msg msg2 [] = {{ .addr = 0x68, .buf = rpt,  .len = 2 },
+	struct i2c_msg msg2 [] = {{ .addr = 0x68, .flags = 0, .buf = rpt,  len: 2 },
 			   { .addr = 0x61, .flags = I2C_M_RD, .buf = stat, .len = 1 }};
-	struct i2c_msg msg3 [] = {{ .addr = 0x68, .buf = rpt,  .len = 2 },
-			   { .addr = 0x60, .buf = tda6100_buf, .len = 2 }};
+	struct i2c_msg msg3 [] = {{ .addr = 0x68, .flags = 0, .buf = rpt,  len: 2 },
+			   { .addr = 0x60, .flags = 0, .buf = tda6100_buf, .len = 2 }};
 
 	stv0299_writereg (i2c, 0x01, 0x15);
 	stv0299_writereg (i2c, 0x02, 0x30);
diff -uraNwB linux-2.6.10-rc1/drivers/media/dvb/frontends/mt352.c linux-2.6.10-rc1-patched/drivers/media/dvb/frontends/mt352.c
--- linux-2.6.10-rc1/drivers/media/dvb/frontends/mt352.c	2004-10-25 14:07:57.000000000 +0200
+++ linux-2.6.10-rc1-patched/drivers/media/dvb/frontends/mt352.c	2004-10-25 14:14:43.000000000 +0200
@@ -8,10 +8,12 @@
  *       Wolfram Joost <dbox2@frokaschwei.de>
  *
  *  Support for Samsung TDTC9251DH01C(M) tuner
- *
  *  Copyright (C) 2004 Antonio Mancuso <antonio.mancuso@digitaltelevision.it>
  *                     Amauri  Celani  <acelani@essegi.net>
  *
+ *  DVICO FusionHDTV DVB-T1 and DVICO FusionHDTV DVB-T Lite support by
+ *       Christopher Pascoe <c.pascoe@itee.uq.edu.au>
+ *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
  *  the Free Software Foundation; either version 2 of the License, or
@@ -45,22 +47,23 @@
 	} while (0)
 
 static int debug;
-static int force_card = -1;
-static int card_type = -1;
+#define MAX_CARDS	4
+static int force_card[MAX_CARDS] = { -1, -1, -1, -1 };
+static int force_card_count = 0;
 
 module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug, "Turn on/off frontend debugging (default:off).");
-//FIXME: Should be an array.
-module_param(force_card, int, 0444);
-MODULE_PARM_DESC(force_card, "Force card type.\n\t(0 == AVDVBT771, 1 == TUA6034, "
-		 "2 == TDTC9251DH01C).\n\tDefault is that AVDVBT771 is attempted "
-		 "to be autodetected,\n\tif you do not have this card, you must "
-		 "specify the card type here.");
-
+module_param_array(force_card, int, &force_card_count, 0444);
+MODULE_PARM_DESC(force_card, "Forces the type of each attached mt352 frontend.\n\t"
+		 "If your card is not autodetected, then you must specify its type here.\n\t"
+		 "Valid card types are: 0 == AVDVBT771, 1 == TUA6034, 2 == TDTC9251DH01C,\n\t"
+		 "3 == DVICO FusionHDTV DVB-T1, 4 == DVICO FusionHDTV DVB-T Lite.");
 
 struct mt352_state {
 	struct i2c_adapter *i2c;
 	struct dvb_adapter *dvb;
+	struct dvb_frontend_info fe_info;
+	int card_type;
 };
 
 #define mt352_write(ibuf, ilen)						\
@@ -75,60 +78,60 @@
 	}								\
 } while (0)
 
-// FIXME:
 static struct _tuner_info tuner_info [] = {
-	//AVERMEDIA 771 board
 	{
+	  .fe_name = "AverMedia DVB-T 771",
 	  .fe_frequency_min = 174000000,
 	  .fe_frequency_max = 862000000,
-	  .fe_frequency_stepsize = 83333,
-	  .coderate_hp_shift = 7,
-	  .coderate_lp_shift = 4,
-	  .constellation_shift = 13,
-	  .tx_mode_shift = 0,
-	  .guard_interval_shift = 2,
-	  .hierarchy_shift = 10,
-	  .read_reg_flag = I2C_M_NOSTART,
+	  .fe_frequency_stepsize = 166667,
+	  .pll_i2c_addr = 0xc2,
 	  .mt352_init = mt352_init_AVERMEDIA771,
 	  .mt352_charge_pump = mt352_cp_AVERMEDIA771,
 	  .mt352_band_select = mt352_bs_AVERMEDIA771
 	},
-	//TUA6034 tuner
 	{
+	  .fe_name = "Zarlink MT352 + TUA6034 DVB-T",
 	  .fe_frequency_min = 174000000,
 	  .fe_frequency_max = 862000000,
 	  .fe_frequency_stepsize = 166667,
-	  .coderate_hp_shift = 9,
-	  .coderate_lp_shift = 6,
-	  .constellation_shift = 14,
-	  .tx_mode_shift = 1,
-	  .guard_interval_shift = 3,
-	  .hierarchy_shift = 12,
-	  .read_reg_flag = I2C_M_NOSTART,
+	  .pll_i2c_addr = 0xc2,
 	  .mt352_init = mt352_init_TUA6034,
 	  .mt352_charge_pump = mt352_cp_TUA6034,
 	  .mt352_band_select = mt352_bs_TUA6034
 	},
-	//TDTC9251DH01C tuner
 	{
+	  .fe_name = "Zarlink MT352 + Samsung TDTC9251DH01C DVB-T",
 	  .fe_frequency_min = 474000000,
 	  .fe_frequency_max = 858000000,
 	  .fe_frequency_stepsize = 166667,
-	  .coderate_hp_shift = 9,
-	  .coderate_lp_shift = 6,
-	  .constellation_shift = 4,
-	  .tx_mode_shift = 1,
-	  .guard_interval_shift = 3,
-	  .hierarchy_shift = 12,
-	  .read_reg_flag = 0,
+	  .pll_i2c_addr = 0xc2,
 	  .mt352_init = mt352_init_TDTC9251DH01C,
 	  .mt352_charge_pump = mt352_cp_TDTC9251DH01C,
 	  .mt352_band_select = mt352_bs_TDTC9251DH01C
+	},
+	{
+	  .fe_name = "DVICO FusionHDTV DVB-T1",
+	  .fe_frequency_min = 174000000,
+	  .fe_frequency_max = 862000000,
+	  .fe_frequency_stepsize = 166667,
+	  .pll_i2c_addr = 0xc2,
+	  .mt352_init = mt352_init_DVICODVBT1,
+	  .mt352_charge_pump = mt352_cp_DVICODVBT1,
+	  .mt352_band_select = mt352_bs_DVICODVBT1,
+	},
+	{
+	  .fe_name = "DVICO FusionHDTV DVB-T Lite",
+	  .fe_frequency_min = 174000000,
+	  .fe_frequency_max = 862000000,
+	  .fe_frequency_stepsize = 166667,
+	  .pll_i2c_addr = 0xc0,
+	  .mt352_init = mt352_init_DVICODVBTLITE,
+	  .mt352_charge_pump = mt352_cp_DVICODVBTLITE,
+	  .mt352_band_select = mt352_bs_DVICODVBTLITE,
 	}
 };
 
-
-static struct dvb_frontend_info mt352_info = {
+static struct dvb_frontend_info mt352_info_template = {
 	.name			= "DVB-T Zarlink MT352 demodulator driver",
 	.type			= FE_OFDM,
 /*
@@ -150,63 +153,95 @@
 		FE_CAN_MUTE_TS
 };
 
+static u8 mt352_reset [] = { RESET, 0x80 };
+static u8 mt352_adc_ctl_1_cfg [] = { ADC_CTL_1, 0x40 };
+static u8 mt352_capt_range_cfg[] = { CAPT_RANGE, 0x32 };
+
 static int mt352_init_TUA6034(struct i2c_adapter *i2c)
 {
-	static u8 mt352_reset [] = { RESET, 0x80 };
 	static u8 mt352_clock_config [] = { CLOCK_CTL, 0x38, 0x2d };
-	static u8 mt352_adc_ctl_1_cfg [] = { ADC_CTL_1, 0x40 };
 	static u8 mt352_agc_cfg [] = { AGC_TARGET, 0x19, 0xa0 };
-	static u8 mt352_acq_ctl [] = { ACQ_CTL, 0x50 };
 
 	mt352_write(mt352_clock_config, sizeof(mt352_clock_config));
 	udelay(2000);
 	mt352_write(mt352_reset, sizeof(mt352_reset));
 	mt352_write(mt352_adc_ctl_1_cfg, sizeof(mt352_adc_ctl_1_cfg));
-	mt352_write(mt352_acq_ctl, sizeof(mt352_acq_ctl));
 
 	mt352_write(mt352_agc_cfg, sizeof(mt352_agc_cfg));
+	mt352_write(mt352_capt_range_cfg, sizeof(mt352_capt_range_cfg));
 
 	return 0;
 }
 
 static int mt352_init_AVERMEDIA771(struct i2c_adapter *i2c)
 {
-	static u8 mt352_reset [] = { RESET, 0x80 };
 	static u8 mt352_clock_config [] = { CLOCK_CTL, 0x38, 0x2d };
-	static u8 mt352_adc_ctl_1_cfg [] = { ADC_CTL_1, 0x40 };
 	static u8 mt352_agc_cfg [] = { AGC_TARGET, 0x10, 0x23, 0x00, 0xFF, 0xFF,
 				       0x00, 0xFF, 0x00, 0x40, 0x40 };
-	static u8 mt352_acq_ctl [] = { ACQ_CTL, 0x50 };
 	static u8 mt352_av771_extra[] = { 0xB5, 0x7A };
+	static u8 mt352_capt_range_cfg[] = { CAPT_RANGE, 0x32 };
 
 	mt352_write(mt352_clock_config, sizeof(mt352_clock_config));
 	udelay(2000);
 	mt352_write(mt352_reset, sizeof(mt352_reset));
 	mt352_write(mt352_adc_ctl_1_cfg, sizeof(mt352_adc_ctl_1_cfg));
-	mt352_write(mt352_acq_ctl, sizeof(mt352_acq_ctl));
 
 	mt352_write(mt352_agc_cfg,sizeof(mt352_agc_cfg));
 	udelay(2000);
 	mt352_write(mt352_av771_extra,sizeof(mt352_av771_extra));
+	mt352_write(mt352_capt_range_cfg, sizeof(mt352_capt_range_cfg));
 
 	return 0;
 }
 
 static int mt352_init_TDTC9251DH01C(struct i2c_adapter *i2c)
 {
-	static u8 mt352_reset [] = { RESET, 0x80 };
 	static u8 mt352_clock_config [] = { CLOCK_CTL, 0x10, 0x2d };
-	static u8 mt352_adc_ctl_1_cfg [] = { ADC_CTL_1, 0x40 };
 	static u8 mt352_agc_cfg [] = { AGC_TARGET, 0x28, 0xa1 };
-	static u8 mt352_acq_ctl [] = { ACQ_CTL, 0x50 };
 
 	mt352_write(mt352_clock_config, sizeof(mt352_clock_config));
 	udelay(2000);
 	mt352_write(mt352_reset, sizeof(mt352_reset));
 	mt352_write(mt352_adc_ctl_1_cfg, sizeof(mt352_adc_ctl_1_cfg));
-	mt352_write(mt352_acq_ctl, sizeof(mt352_acq_ctl));
 
 	mt352_write(mt352_agc_cfg, sizeof(mt352_agc_cfg));
+	mt352_write(mt352_capt_range_cfg, sizeof(mt352_capt_range_cfg));
+
+	return 0;
+}
+
+static int mt352_init_DVICODVBT1(struct i2c_adapter *i2c)
+{
+	static u8 mt352_clock_config [] = { CLOCK_CTL, 0x38, 0x39 };
+	static u8 mt352_agc_cfg [] = { AGC_TARGET, 0x24, 0x20 };
+	static u8 mt352_gpp_ctl_cfg [] = { GPP_CTL, 0x33 };
+
+	mt352_write(mt352_clock_config, sizeof(mt352_clock_config));
+	udelay(200);
+	mt352_write(mt352_reset, sizeof(mt352_reset));
+	mt352_write(mt352_adc_ctl_1_cfg, sizeof(mt352_adc_ctl_1_cfg));
+
+	mt352_write(mt352_agc_cfg, sizeof(mt352_agc_cfg));
+	mt352_write(mt352_gpp_ctl_cfg, sizeof(mt352_gpp_ctl_cfg));
+	mt352_write(mt352_capt_range_cfg, sizeof(mt352_capt_range_cfg));
+
+	return 0;
+}
+
+static int mt352_init_DVICODVBTLITE(struct i2c_adapter *i2c)
+{
+	static u8 mt352_clock_config [] = { CLOCK_CTL, 0x38, 0x38 };
+	static u8 mt352_agc_cfg [] = { AGC_TARGET, 0x28, 0x20 };
+	static u8 mt352_gpp_ctl_cfg [] = { GPP_CTL, 0x33 };
+
+	mt352_write(mt352_clock_config, sizeof(mt352_clock_config));
+	udelay(200);
+	mt352_write(mt352_reset, sizeof(mt352_reset));
+	mt352_write(mt352_adc_ctl_1_cfg, sizeof(mt352_adc_ctl_1_cfg));
+
+	mt352_write(mt352_agc_cfg, sizeof(mt352_agc_cfg));
+	mt352_write(mt352_gpp_ctl_cfg, sizeof(mt352_gpp_ctl_cfg));
+	mt352_write(mt352_capt_range_cfg, sizeof(mt352_capt_range_cfg));
 
 	return 0;
 }
@@ -215,9 +250,9 @@
 {
 	unsigned char cp = 0;
 
-	if (freq < 542)
+	if (freq < 542000000)
 		cp = 0xbe;
-	else if (freq < 830)
+	else if (freq < 830000000)
 		cp = 0xf6;
 	else
 		cp = 0xfe;
@@ -229,21 +264,21 @@
 {
 	unsigned char cp = 0;
 
-	if (freq < 150)
+	if (freq < 150000000)
 		cp = 0xB4;
-	else if (freq < 173)
+	else if (freq < 173000000)
 		cp = 0xBC;
-	else if (freq < 250)
+	else if (freq < 250000000)
 		cp = 0xB4;
-	else if (freq < 400)
+	else if (freq < 400000000)
 		cp = 0xBC;
-	else if (freq < 420)
+	else if (freq < 420000000)
 		cp = 0xF4;
-	else if (freq < 470)
+	else if (freq < 470000000)
 		cp = 0xFC;
-	else if (freq < 600)
+	else if (freq < 600000000)
 		cp = 0xBC;
-	else if (freq < 730)
+	else if (freq < 730000000)
 		cp = 0xF4;
 	else
 		cp = 0xFC;
@@ -256,11 +291,39 @@
 	return(0xcc);
 }
 
+static unsigned char mt352_cp_DVICODVBT1(u32 freq)
+{
+	unsigned char cp = 0;
+
+	if (freq < 542000000)
+		cp = 0xbc;
+	else if (freq < 830000000)
+		cp = 0xf4;
+	else
+		cp = 0xfc;
+
+	return cp;
+}
+
+static unsigned char mt352_cp_DVICODVBTLITE(u32 freq)
+{
+	unsigned char cp = 0;
+
+	if (freq < 542000000)
+		cp = 0xb4;
+	else if (freq < 771000000)
+		cp = 0xbc;
+	else 
+		cp = 0xf4;
+
+	return cp;
+}
+
 static unsigned char mt352_bs_TUA6034(u32 freq)
 {
 	unsigned char bs = 0;
 
-	if (freq < 250)
+	if (freq < 250000000)
 		bs = 0x01;
 	else
 		bs = 0x08;
@@ -272,21 +335,21 @@
 {
 	unsigned char bs = 0;
 
-	if (freq < 150)
+	if (freq < 150000000)
 		bs = 0x01;
-	else if (freq < 173)
+	else if (freq < 173000000)
 		bs = 0x01;
-	else if (freq < 250)
+	else if (freq < 250000000)
 		bs = 0x02;
-	else if (freq < 400)
+	else if (freq < 400000000)
 		bs = 0x02;
-	else if (freq < 420)
+	else if (freq < 420000000)
 		bs = 0x02;
-	else if (freq < 470)
+	else if (freq < 470000000)
 		bs = 0x02;
-	else if (freq < 600)
+	else if (freq < 600000000)
 		bs = 0x08;
-	else if (freq < 730)
+	else if (freq < 730000000)
 		bs = 0x08;
 	else
 		bs = 0x08;
@@ -298,54 +361,79 @@
 {
 	unsigned char bs = 0;
 
-	if ((freq >= 48) && (freq <= 154))      /* low band */
+	if (freq >= 48000000 && freq <= 154000000)      /* low band */
 		bs = 0x09;
 
-	if ((freq >= 161) && (freq <= 439))     /* medium band */
+	if (freq >= 161000000 && freq <= 439000000)     /* medium band */
 		bs = 0x0a;
 
-	if ((freq >= 447) && (freq <= 863))     /* high band */
+	if (freq >= 447000000 && freq <= 863000000)     /* high band */
 		bs = 0x08;
 
 	return bs;
 }
 
+static unsigned char mt352_bs_DVICODVBT1(u32 freq)
+{
+	unsigned char bs = 0;
+
+	if (freq == 0)			/* power down PLL */
+		bs = 0x03;
+	else if (freq < 157500000)	/* low band */
+		bs = 0x01;
+	else if (freq < 443250000)	/* mid band */
+		bs = 0x02;
+	else				/* high band */
+		bs = 0x04;
 
-static int mt352_detect_avermedia_771(struct i2c_adapter *i2c)
+	return bs;
+}
+
+static unsigned char mt352_bs_DVICODVBTLITE(u32 freq)
 {
-	int i;
-	u8 reg;
-	u8 id[4];
-	const u8 pciid[4] = { 0x07, 0x71, 0x14, 0x61 };
-	struct i2c_msg msg[2] =
+	unsigned char bs = 0;
+
+	if (freq == 0)			/* power down PLL */
+		bs = 0x03;
+	else if (freq < 443250000)	/* mid band */
+		bs = 0x02;
+	else				/* high band */
+		bs = 0x08;
+
+	return bs;
+}
+
+static u32 mt352_read_eeprom_dword(struct i2c_adapter *i2c, int dword_base)
 	{
+	int i;
+	u32 dword = 0;
+	u8 reg, val;
+	struct i2c_msg msg[2] = {
 		{
 			.addr = 0x50,
-			.flags = I2C_M_NOSTART,
+			.flags = 0,
 			.buf = &reg,
 			.len = 1
 		},
 		{
 			.addr = 0x50,
 			.flags = I2C_M_RD,
+			.buf = &val,
 			.len = 1
 		}
 	};
 
-	for (i = 0; i < 4; i++)
-	{
-		reg = i + 0xFC;
-		msg[1].buf = id + i;
+	for (i = 0; i < 4; i++) {
+		reg = dword_base + i;
 		if (i2c_transfer(i2c,msg,2) != 2)
-		{
 			return 0;
-		}
+		dword = (dword << 8) | val;
 	}
 
-	return *((u32 *) id) == *((u32 *) pciid);
+	return dword;
 }
 
-static int mt352_init(struct i2c_adapter *i2c)
+static int mt352_init(struct i2c_adapter *i2c, int card_type)
 {
 	/**
 	 *  all register write sequence have the register address of the
@@ -366,7 +454,7 @@
 
 static int mt352_sleep(struct i2c_adapter *i2c)
 {
-	static u8 mt352_softdown[] = { 0x89, 0x20, 0x08 };
+	static u8 mt352_softdown[] = { CLOCK_CTL, 0x20, 0x08 };
 
 	mt352_write(mt352_softdown, sizeof(mt352_softdown));
 
@@ -374,26 +462,27 @@
 }
 
 static int mt352_set_parameters(struct i2c_adapter *i2c,
-				struct dvb_frontend_parameters *param)
+				struct dvb_frontend_parameters *param,
+				int card_type)
 {
 	unsigned char buf[14];
 	unsigned int tps = 0;
 	struct dvb_ofdm_parameters *op = &param->u.ofdm;
-	u32 freq = param->frequency / 1000000;
 	uint16_t tmp;
+	int i;
 
 	switch (op->code_rate_HP) {
 		case FEC_2_3:
-			tps |= (1 << CODERATE_HP_SHIFT);
+			tps |= (1 << 7);
 			break;
 		case FEC_3_4:
-			tps |= (2 << CODERATE_HP_SHIFT);
+			tps |= (2 << 7);
 			break;
 		case FEC_5_6:
-			tps |= (3 << CODERATE_HP_SHIFT);
+			tps |= (3 << 7);
 			break;
 		case FEC_7_8:
-			tps |= (4 << CODERATE_HP_SHIFT);
+			tps |= (4 << 7);
 			break;
 		case FEC_1_2:
 		case FEC_AUTO:
@@ -404,20 +493,24 @@
 
 	switch (op->code_rate_LP) {
 		case FEC_2_3:
-			tps |= (1 <<  CODERATE_LP_SHIFT);
+			tps |= (1 << 4);
 			break;
 		case FEC_3_4:
-			tps |= (2 <<  CODERATE_LP_SHIFT);
+			tps |= (2 << 4);
 			break;
 		case FEC_5_6:
-			tps |= (3 <<  CODERATE_LP_SHIFT);
+			tps |= (3 << 4);
 			break;
 		case FEC_7_8:
-			tps |= (4 <<  CODERATE_LP_SHIFT);
+			tps |= (4 << 4);
 			break;
 		case FEC_1_2:
 		case FEC_AUTO:
 			break;
+		case FEC_NONE:
+			if (op->hierarchy_information == HIERARCHY_AUTO ||
+			    op->hierarchy_information == HIERARCHY_NONE)
+				break;
 		default:
 			return -EINVAL;
 	}
@@ -427,10 +520,10 @@
 			break;
 		case QAM_AUTO:
 		case QAM_16:
-			tps |= (1 << CONSTELLATION_SHIFT);
+			tps |= (1 << 13);
 			break;
 		case QAM_64:
-			tps |= (2 << CONSTELLATION_SHIFT);
+			tps |= (2 << 13);
 			break;
 		default:
 			return -EINVAL;
@@ -441,7 +534,7 @@
 		case TRANSMISSION_MODE_AUTO:
 			break;
 		case TRANSMISSION_MODE_8K:
-			tps |= (1 << TX_MODE_SHIFT);
+			tps |= (1 << 0);
 			break;
 		default:
 			return -EINVAL;
@@ -452,13 +545,13 @@
 		case GUARD_INTERVAL_AUTO:
 			break;
 		case GUARD_INTERVAL_1_16:
-			tps |= (1 << GUARD_INTERVAL_SHIFT);
+			tps |= (1 << 2);
 			break;
 		case GUARD_INTERVAL_1_8:
-			tps |= (2 << GUARD_INTERVAL_SHIFT);
+			tps |= (2 << 2);
 			break;
 		case GUARD_INTERVAL_1_4:
-			tps |= (3 << GUARD_INTERVAL_SHIFT);
+			tps |= (3 << 2);
 			break;
 		default:
 			return -EINVAL;
@@ -469,13 +562,13 @@
 		case HIERARCHY_NONE:
 			break;
 		case HIERARCHY_1:
-			tps |= (1 << HIERARCHY_SHIFT);
+			tps |= (1 << 10);
 			break;
 		case HIERARCHY_2:
-			tps |= (2 << HIERARCHY_SHIFT);
+			tps |= (2 << 10);
 			break;
 		case HIERARCHY_4:
-			tps |= (3 << HIERARCHY_SHIFT);
+			tps |= (3 << 10);
 			break;
 		default:
 			return -EINVAL;
@@ -507,7 +600,7 @@
 	buf[6] = 0x31;  /* INPUT_FREQ_(1|0), 20.48MHz clock, 36.166667MHz IF */
 	buf[7] = 0x05;  /* see MT352 Design Manual page 32 for details */
 
-	buf[8] = I2C_TUNER_ADDR;
+	buf[8] = PLL_I2C_ADDR;
 
 	/**
 	 *  All the following settings are tuner module dependent,
@@ -516,17 +609,24 @@
 
 	/* here we assume 1/6MHz == 166.66kHz stepsize */
 	#define IF_FREQUENCYx6 217    /* 6 * 36.16666666667MHz */
-	tmp = ((param->frequency*3)/500000) + IF_FREQUENCYx6;
+	tmp = (((param->frequency + 83333) * 3) / 500000) + IF_FREQUENCYx6;
 
 	buf[9] = msb(tmp);      /* CHAN_START_(1|0) */
 	buf[10] = lsb(tmp);
 
-	buf[11] = MT352_CHARGE_PUMP(freq);
-	buf[12] = MT352_BAND_SELECT(freq);
+	buf[11] = MT352_CHARGE_PUMP(param->frequency);
+	buf[12] = MT352_BAND_SELECT(param->frequency);
 
 	buf[13] = 0x01; /* TUNER_GO!! */
 
+	/* Only send the tuning request if the tuner doesn't have the requested
+	 * parameters already set.  Enhances tuning time and prevents stream
+	 * breakup when retuning the same transponder. */
+	for (i = 1; i < 13; i++)
+		if (buf[i] != mt352_read_register(i2c, i + 0x50)) {
 	mt352_write(buf, sizeof(buf));
+			break;
+		}
 
 	return 0;
 }
@@ -537,7 +637,7 @@
 	u8 b0 [] = { reg };
 	u8 b1 [] = { 0 };
 	struct i2c_msg msg [] = { { .addr = I2C_MT352_ADDR,
-				    .flags =  READ_REG_FLAG,
+				    .flags = 0,
 				    .buf = b0, .len = 1 },
 				  { .addr = I2C_MT352_ADDR,
 				    .flags = I2C_M_RD,
@@ -672,6 +772,7 @@
 {
 	struct mt352_state *state = fe->data;
 	struct i2c_adapter *i2c = state->i2c;
+	int card_type = state->card_type;
 	u8 r,snr;
 	fe_status_t *status;
 	u16 signal;
@@ -679,7 +780,7 @@
 
 	switch (cmd) {
 	case FE_GET_INFO:
-		memcpy (arg, &mt352_info, sizeof(struct dvb_frontend_info));
+		memcpy(arg, &state->fe_info, sizeof(struct dvb_frontend_info));
 		break;
 
 	case FE_READ_STATUS:
@@ -727,7 +828,8 @@
 
 	case FE_SET_FRONTEND:
 		return mt352_set_parameters (i2c,
-				 (struct dvb_frontend_parameters *) arg);
+				 (struct dvb_frontend_parameters *) arg,
+				 card_type);
 
 	case FE_GET_FRONTEND:
 		return mt352_get_parameters (i2c,
@@ -744,7 +846,13 @@
 		return mt352_sleep(i2c);
 
 	case FE_INIT:
-		return mt352_init(i2c);
+		/* Only send the initialisation command if the demodulator
+		 * isn't already enabled.  Greatly enhances tuning time. */
+		if ((mt352_read_register(i2c, CLOCK_CTL) & 0x10) == 0 ||
+		    (mt352_read_register(i2c, CONFIG) & 0x20) == 0)
+			return mt352_init(i2c, card_type);
+		else
+			return 0;
 
 	default:
 		return -EOPNOTSUPP;
@@ -757,56 +865,83 @@
 
 static int mt352_attach_adapter(struct i2c_adapter *i2c)
 {
+	static int num_cards_probed;
 	struct mt352_state *state;
 	struct i2c_client *client;
-	static u8 mt352_reset_attach [] = { 0x50, 0xC0 };
+	static u8 mt352_reset_attach [] = { RESET, 0xC0 };
 	int ret;
+	int card_type, forced_card = -1;
 
 	dprintk("Trying to attach to adapter 0x%x:%s.\n",
 		i2c->id, i2c->name);
 
-	/* set the proper MT352 frequency range */
-	mt352_info.frequency_min =  FE_FREQ_MIN;
-	mt352_info.frequency_max =  FE_FREQ_MAX;
-	mt352_info.frequency_stepsize =  FE_FREQ_STEPSIZE;
+	if (mt352_read_register(i2c, CHIP_ID) != ID_MT352)
+		return -ENODEV;
 
 	if ( !(state = kmalloc(sizeof(struct mt352_state), GFP_KERNEL)) )
 		return -ENOMEM;
 
 	memset(state, 0, sizeof(struct mt352_state));
 	state->i2c = i2c;
+	state->card_type = -1;
+	memcpy(&state->fe_info, &mt352_info_template, sizeof(struct dvb_frontend_info));
 
-	if (mt352_detect_avermedia_771(i2c)) {
-		card_type = CARD_AVDVBT771;
-	} else if (force_card < 0) {
-		dprintk("Avermedia 771 not detected, maybe you should try the "
-			"'force_card' module parameter?.\n");
-		kfree(state);
-		return -ENODEV;
+	/* Attempt autodetection of card type based on PCI ID information
+	 * stored in any on-board EEPROM. */
+	switch (mt352_read_eeprom_dword(i2c, 0xFC)) {	/* BT878A chipset */
+	case 0x07711461:
+		state->card_type = CARD_AVDVBT771;
+		break;
+	case 0xdb1018ac:
+		state->card_type = CARD_DVICODVBTLITE;
+		break;
+	default:
+		break;
 	}
 
-	if (force_card > 0) {
-		if (card_type >= 0 && force_card != card_type)
-			printk(KERN_WARNING "dvbfe_mt352: Warning, overriding"
-					    " detected card.\n");
-		card_type = force_card;
+	switch (mt352_read_eeprom_dword(i2c, 0x04)) {	/* CX2388x chipset */
+	case 0xac1800db:
+		state->card_type = CARD_DVICODVBT1;
+		break;
+	default:
+		break;
 	}
 
-	if (mt352_read_register(i2c, CHIP_ID) != ID_MT352) {
+	if (num_cards_probed < force_card_count)
+		forced_card = force_card[num_cards_probed++];
+
+	if (state->card_type == -1 && forced_card < 0) {
+		dprintk("Card type not automatically detected.  You "
+			"must use the 'force_card' module parameter.\n");
 		kfree(state);
 		return -ENODEV;
 	}
 
-	if (card_type == CARD_AVDVBT771)
-		printk(KERN_INFO FRONTEND_NAME ": Setup for Avermedia 771.\n");
-	else if (card_type == CARD_TUA6034)
-		printk(KERN_INFO FRONTEND_NAME ": Setup for TUA6034.\n");
-	else if (card_type == CARD_TDTC9251DH01C)
-		printk(KERN_INFO FRONTEND_NAME ": Setup for TDTC9251DH01C.\n");
+	if (forced_card >= 0) {
+		if (state->card_type >= 0 && forced_card != state->card_type)
+			printk(KERN_WARNING FRONTEND_NAME ": Warning, overriding"
+					    " detected card type.\n");
+		state->card_type = forced_card;
+	}
+
+	card_type = state->card_type;
+	printk(KERN_INFO FRONTEND_NAME ": Setup for %s\n", FE_NAME);
+
+	/* set the frontend name and card-specific frequency info */
+	strlcpy(state->fe_info.name, FE_NAME, sizeof(state->fe_info.name));
+	state->fe_info.frequency_min = FE_FREQ_MIN;
+	state->fe_info.frequency_max = FE_FREQ_MAX;
+	state->fe_info.frequency_stepsize = FE_FREQ_STEPSIZE;
 
 	/* Do a "hard" reset */
 	mt352_write(mt352_reset_attach, sizeof(mt352_reset_attach));
 
+	/* Try to intiialise the device */
+	if (mt352_init(i2c, card_type) != 0) {
+		kfree(state);
+		return -ENODEV;
+	}
+
 	if ( !(client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL)) ) {
 		kfree(state);
 		return -ENOMEM;
@@ -823,16 +958,6 @@
 		return ret;
 	}
 
-	BUG_ON(!state->dvb);
-
-	if ((ret = dvb_register_frontend(mt352_ioctl, state->dvb, state,
-					     &mt352_info, THIS_MODULE))) {
-		i2c_detach_client(client);
-		kfree(client);
-		kfree(state);
-		return ret;
-	}
-
 	return 0;
 }
 
@@ -840,9 +965,9 @@
 {
 	struct mt352_state *state = i2c_get_clientdata(client);
 
+	if (state->dvb)
 	dvb_unregister_frontend (mt352_ioctl, state->dvb);
 	i2c_detach_client(client);
-	BUG_ON(state->dvb);
 	kfree(client);
 	kfree(state);
 	return 0;
@@ -851,13 +976,23 @@
 static int mt352_command (struct i2c_client *client, unsigned int cmd, void *arg)
 {
 	struct mt352_state *state = i2c_get_clientdata(client);
+	int ret;
 
 	switch (cmd) {
 	case FE_REGISTER:
+		if (!state->dvb) {
+			if ((ret = dvb_register_frontend(mt352_ioctl, arg,
+							 state, &state->fe_info,
+							 THIS_MODULE)))
+				return ret;
 		state->dvb = arg;
+		}
 		break;
 	case FE_UNREGISTER:
+		if (state->dvb == arg) {
+			dvb_unregister_frontend(mt352_ioctl, state->dvb);
 		state->dvb = NULL;
+		}
 		break;
 	default:
 		return -EOPNOTSUPP;
diff -uraNwB linux-2.6.10-rc1/drivers/media/dvb/frontends/mt352.h linux-2.6.10-rc1-patched/drivers/media/dvb/frontends/mt352.h
--- linux-2.6.10-rc1/drivers/media/dvb/frontends/mt352.h	2004-10-25 14:07:57.000000000 +0200
+++ linux-2.6.10-rc1-patched/drivers/media/dvb/frontends/mt352.h	2004-10-25 14:14:43.000000000 +0200
@@ -4,11 +4,16 @@
  *  Written by Holger Waechtler <holger@qanu.de>
  *	 and Daniel Mack <daniel@qanu.de>
  *
- *  Support for Samsung TDTC9251DH01C(M) tuner
+ *  AVerMedia AVerTV DVB-T 771 support by
+ *       Wolfram Joost <dbox2@frokaschwei.de>
  *
+ *  Support for Samsung TDTC9251DH01C(M) tuner
  *  Copyright (C) 2004 Antonio Mancuso <antonio.mancuso@digitaltelevision.it>
  *                     Amauri  Celani  <acelani@essegi.net>
  *
+ *  DVICO FusionHDTV DVB-T1 and DVICO FusionHDTV DVB-T Lite support by
+ *       Christopher Pascoe <c.pascoe@itee.uq.edu.au>
+ *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
  *  the Free Software Foundation; either version 2 of the License, or
@@ -29,12 +34,13 @@
 #define _MT352_
 
 #define I2C_MT352_ADDR  0x0f
-#define I2C_TUNER_ADDR  0xc2
 #define ID_MT352        0x13
 
 #define CARD_AVDVBT771	    0x00
 #define CARD_TUA6034	    0x01
 #define CARD_TDTC9251DH01C  0x02
+#define CARD_DVICODVBT1	    0x03
+#define CARD_DVICODVBTLITE  0x04
 
 #define msb(x) (((x) >> 8) & 0xff)
 #define lsb(x) ((x) & 0xff)
@@ -123,6 +129,9 @@
 };
 
 struct _tuner_info {
+	char *fe_name;
+#define FE_NAME tuner_info[card_type].fe_name
+
 	__u32 fe_frequency_min;
 #define FE_FREQ_MIN tuner_info[card_type].fe_frequency_min
 
@@ -132,26 +141,8 @@
 	__u32 fe_frequency_stepsize; //verificare se u32 e' corretto
 #define FE_FREQ_STEPSIZE  tuner_info[card_type].fe_frequency_stepsize
 
-	__u32 coderate_hp_shift; //verificare se u32 giusto
-#define CODERATE_HP_SHIFT tuner_info[card_type].coderate_hp_shift
-
-	__u32 coderate_lp_shift;
-#define CODERATE_LP_SHIFT tuner_info[card_type].coderate_lp_shift
-
-	int constellation_shift;
-#define CONSTELLATION_SHIFT tuner_info[card_type].constellation_shift
-
-	int tx_mode_shift;
-#define TX_MODE_SHIFT tuner_info[card_type].tx_mode_shift
-
-	int guard_interval_shift;
-#define GUARD_INTERVAL_SHIFT tuner_info[card_type].guard_interval_shift
-
-	int hierarchy_shift;
-#define HIERARCHY_SHIFT tuner_info[card_type].hierarchy_shift
-
-	int read_reg_flag;
-#define READ_REG_FLAG tuner_info[card_type].read_reg_flag
+	u8 pll_i2c_addr;
+#define PLL_I2C_ADDR tuner_info[card_type].pll_i2c_addr
 
 	int (* mt352_init) (struct i2c_adapter *i2c);
 #define MT352_INIT tuner_info[card_type].mt352_init
@@ -166,12 +157,18 @@
 static int mt352_init_TUA6034(struct i2c_adapter *i2c);
 static int mt352_init_AVERMEDIA771(struct i2c_adapter *i2c);
 static int mt352_init_TDTC9251DH01C(struct i2c_adapter *i2c);
+static int mt352_init_DVICODVBT1(struct i2c_adapter *i2c);
+static int mt352_init_DVICODVBTLITE(struct i2c_adapter *i2c);
 static unsigned char mt352_cp_TUA6034(u32 freq);
 static unsigned char mt352_cp_AVERMEDIA771(u32 freq);
 static unsigned char mt352_cp_TDTC9251DH01C(u32 freq);
+static unsigned char mt352_cp_DVICODVBT1(u32 freq);
+static unsigned char mt352_cp_DVICODVBTLITE(u32 freq);
 static unsigned char mt352_bs_TUA6034(u32 freq);
 static unsigned char mt352_bs_AVERMEDIA771(u32 freq);
 static unsigned char mt352_bs_TDTC9251DH01C(u32 freq);
-static int mt352_detect_avermedia_771(struct i2c_adapter *i2c);
+static unsigned char mt352_bs_DVICODVBT1(u32 freq);
+static unsigned char mt352_bs_DVICODVBTLITE(u32 freq);
+static u8 mt352_read_register(struct i2c_adapter *i2c, u8 reg);
 
 #endif                          /* _MT352_ */

--------------000108050201020905020105--
