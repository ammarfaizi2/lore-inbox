Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268816AbUIQPKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268816AbUIQPKX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 11:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268824AbUIQPKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 11:10:23 -0400
Received: from mail.convergence.de ([212.227.36.84]:13217 "EHLO
	email.convergence2.de") by vger.kernel.org with ESMTP
	id S268816AbUIQOfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 10:35:36 -0400
Message-ID: <414AF605.5040605@linuxtv.org>
Date: Fri, 17 Sep 2004 16:34:45 +0200
From: Michael Hunold <hunold@linuxtv.org>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][2.6][9/14] add new frontend drivers 1/2
References: <414AF2CA.3000502@linuxtv.org> <414AF31B.1090103@linuxtv.org> <414AF399.3030708@linuxtv.org> <414AF41A.6060009@linuxtv.org> <414AF461.4050707@linuxtv.org> <414AF4CE.7000000@linuxtv.org> <414AF51D.4060308@linuxtv.org> <414AF569.2020803@linuxtv.org> <414AF5BF.4020401@linuxtv.org>
In-Reply-To: <414AF5BF.4020401@linuxtv.org>
Content-Type: multipart/mixed;
 boundary="------------010603070403060403060007"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010603070403060403060007
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------010603070403060403060007
Content-Type: text/plain;
 name="09-DVB-add-frontend-1-2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="09-DVB-add-frontend-1-2.diff"

- [DVB] add new driver for Zarlink DVB-T MT352 frontend
- [DVB] add new driver for Conexant 22702 DVB OFDM frontend 

Signed-off-by: Michael Hunold <hunold@linuxtv.org>

diff -uraNwB xx-linux-2.6.8.1/drivers/media/dvb/frontends/Makefile linux-2.6.8.1-patched/drivers/media/dvb/frontends/Makefile
--- xx-linux-2.6.8.1/drivers/media/dvb/frontends/Makefile	2004-07-19 19:40:04.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/frontends/Makefile	2004-03-05 17:43:49.000000000 +0100
@@ -18,3 +18,5 @@
 obj-$(CONFIG_DVB_TDA1004X) += tda1004x.o
 obj-$(CONFIG_DVB_SP887X) += sp887x.o
 obj-$(CONFIG_DVB_NXT6000) += nxt6000.o
+obj-$(CONFIG_DVB_MT352) += mt352.o
+
diff -uraNwB xx-linux-2.6.8.1/drivers/media/dvb/frontends/mt352.c linux-2.6.8.1-patched/drivers/media/dvb/frontends/mt352.c
--- xx-linux-2.6.8.1/drivers/media/dvb/frontends/mt352.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.8.1-patched/drivers/media/dvb/frontends/mt352.c	2004-08-18 19:52:17.000000000 +0200
@@ -0,0 +1,901 @@
+/*
+ *  Driver for Zarlink DVB-T MT352 demodulator
+ *
+ *  Written by Holger Waechtler <holger@qanu.de>
+ *	 and Daniel Mack <daniel@qanu.de>
+ *
+ *  AVerMedia AVerTV DVB-T 771 support by
+ *       Wolfram Joost <dbox2@frokaschwei.de>
+ *
+ *  Support for Samsung TDTC9251DH01C(M) tuner
+ *
+ *  Copyright (C) 2004 Antonio Mancuso <antonio.mancuso@digitaltelevision.it>
+ *                     Amauri  Celani  <acelani@essegi.net>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.=
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+
+#include "dvb_frontend.h"
+#include "mt352.h"
+
+#define FRONTEND_NAME "dvbfe_mt352"
+
+#define dprintk(args...) \
+	do { \
+		if (debug) printk(KERN_DEBUG FRONTEND_NAME ": " args); \
+	} while (0)
+
+static int debug;
+static int force_card = -1;
+static int card_type = -1;
+
+module_param(debug, int, 0644);
+MODULE_PARM_DESC(debug, "Turn on/off frontend debugging (default:off).");
+//FIXME: Should be an array.
+module_param(force_card, int, 0444);
+MODULE_PARM_DESC(force_card, "Force card type.\n\t(0 == AVDVBT771, 1 == TUA6034, "
+		 "2 == TDTC9251DH01C).\n\tDefault is that AVDVBT771 is attempted "
+		 "to be autodetected,\n\tif you do not have this card, you must "
+		 "specify the card type here.");
+
+
+struct mt352_state {
+	struct i2c_adapter *i2c;
+	struct dvb_adapter *dvb;
+};
+
+#define mt352_write(ibuf, ilen)						\
+do {									\
+	struct i2c_msg msg = { .addr = I2C_MT352_ADDR, .flags = 0,	\
+			       .buf = ibuf, .len = ilen };		\
+	int err = i2c_transfer(i2c, &msg, 1);				\
+	if (err != 1) {							\
+		printk(KERN_WARNING					\
+		       "mt352_write() failed (err = %d)!\n", err);	\
+		return err;						\
+	}								\
+} while (0)
+
+// FIXME:
+static struct _tuner_info tuner_info [] = {
+	//AVERMEDIA 771 board
+	{
+	  .fe_frequency_min = 174000000,
+	  .fe_frequency_max = 862000000,
+	  .fe_frequency_stepsize = 83333,
+	  .coderate_hp_shift = 7,
+	  .coderate_lp_shift = 4,
+	  .constellation_shift = 13,
+	  .tx_mode_shift = 0,
+	  .guard_interval_shift = 2,
+	  .hierarchy_shift = 10,
+	  .read_reg_flag = I2C_M_NOSTART,
+	  .mt352_init = mt352_init_AVERMEDIA771,
+	  .mt352_charge_pump = mt352_cp_AVERMEDIA771,
+	  .mt352_band_select = mt352_bs_AVERMEDIA771
+	},
+	//TUA6034 tuner
+	{
+	  .fe_frequency_min = 174000000,
+	  .fe_frequency_max = 862000000,
+	  .fe_frequency_stepsize = 166667,
+	  .coderate_hp_shift = 9,
+	  .coderate_lp_shift = 6,
+	  .constellation_shift = 14,
+	  .tx_mode_shift = 1,
+	  .guard_interval_shift = 3,
+	  .hierarchy_shift = 12,
+	  .read_reg_flag = I2C_M_NOSTART,
+	  .mt352_init = mt352_init_TUA6034,
+	  .mt352_charge_pump = mt352_cp_TUA6034,
+	  .mt352_band_select = mt352_bs_TUA6034
+	},
+	//TDTC9251DH01C tuner
+	{
+	  .fe_frequency_min = 474000000,
+	  .fe_frequency_max = 858000000,
+	  .fe_frequency_stepsize = 166667,
+	  .coderate_hp_shift = 9,
+	  .coderate_lp_shift = 6,
+	  .constellation_shift = 4,
+	  .tx_mode_shift = 1,
+	  .guard_interval_shift = 3,
+	  .hierarchy_shift = 12,
+	  .read_reg_flag = 0,
+	  .mt352_init = mt352_init_TDTC9251DH01C,
+	  .mt352_charge_pump = mt352_cp_TDTC9251DH01C,
+	  .mt352_band_select = mt352_bs_TDTC9251DH01C
+	}
+};
+
+
+static struct dvb_frontend_info mt352_info = {
+	.name			= "DVB-T Zarlink MT352 demodulator driver",
+	.type			= FE_OFDM,
+/*
+	.frequency_min		= 0,
+	.frequency_max		= 0,
+	.frequency_stepsize	= 0,
+	.frequency_tolerance	= 0,
+	.symbol_rate_min	= 1000000,
+	.symbol_rate_max	= 45000000,
+	.symbol_rate_tolerance	= ???,
+*/
+	.notifier_delay		 = 0,
+	.caps = FE_CAN_INVERSION_AUTO | FE_CAN_FEC_1_2 | FE_CAN_FEC_2_3 |
+		FE_CAN_FEC_3_4 | FE_CAN_FEC_5_6 | FE_CAN_FEC_7_8 |
+		FE_CAN_FEC_AUTO |
+		FE_CAN_QPSK | FE_CAN_QAM_16 | FE_CAN_QAM_64 | FE_CAN_QAM_AUTO |
+		FE_CAN_TRANSMISSION_MODE_AUTO | FE_CAN_GUARD_INTERVAL_AUTO |
+		FE_CAN_HIERARCHY_AUTO | FE_CAN_RECOVER |
+		FE_CAN_MUTE_TS
+};
+
+static int mt352_init_TUA6034(struct i2c_adapter *i2c)
+{
+	static u8 mt352_reset [] = { RESET, 0x80 };
+	static u8 mt352_clock_config [] = { CLOCK_CTL, 0x38, 0x2d };
+	static u8 mt352_adc_ctl_1_cfg [] = { ADC_CTL_1, 0x40 };
+	static u8 mt352_agc_cfg [] = { AGC_TARGET, 0x19, 0xa0 };
+	static u8 mt352_acq_ctl [] = { ACQ_CTL, 0x50 };
+
+	mt352_write(mt352_clock_config, sizeof(mt352_clock_config));
+	udelay(2000);
+	mt352_write(mt352_reset, sizeof(mt352_reset));
+	mt352_write(mt352_adc_ctl_1_cfg, sizeof(mt352_adc_ctl_1_cfg));
+	mt352_write(mt352_acq_ctl, sizeof(mt352_acq_ctl));
+
+	mt352_write(mt352_agc_cfg, sizeof(mt352_agc_cfg));
+
+	return 0;
+}
+
+static int mt352_init_AVERMEDIA771(struct i2c_adapter *i2c)
+{
+	static u8 mt352_reset [] = { RESET, 0x80 };
+	static u8 mt352_clock_config [] = { CLOCK_CTL, 0x38, 0x2d };
+	static u8 mt352_adc_ctl_1_cfg [] = { ADC_CTL_1, 0x40 };
+	static u8 mt352_agc_cfg [] = { AGC_TARGET, 0x10, 0x23, 0x00, 0xFF, 0xFF,
+				       0x00, 0xFF, 0x00, 0x40, 0x40 };
+	static u8 mt352_acq_ctl [] = { ACQ_CTL, 0x50 };
+	static u8 mt352_av771_extra[] = { 0xB5, 0x7A };
+
+	mt352_write(mt352_clock_config, sizeof(mt352_clock_config));
+	udelay(2000);
+	mt352_write(mt352_reset, sizeof(mt352_reset));
+	mt352_write(mt352_adc_ctl_1_cfg, sizeof(mt352_adc_ctl_1_cfg));
+	mt352_write(mt352_acq_ctl, sizeof(mt352_acq_ctl));
+
+	mt352_write(mt352_agc_cfg,sizeof(mt352_agc_cfg));
+	udelay(2000);
+	mt352_write(mt352_av771_extra,sizeof(mt352_av771_extra));
+
+	return 0;
+}
+
+static int mt352_init_TDTC9251DH01C(struct i2c_adapter *i2c)
+{
+	static u8 mt352_reset [] = { RESET, 0x80 };
+	static u8 mt352_clock_config [] = { CLOCK_CTL, 0x10, 0x2d };
+	static u8 mt352_adc_ctl_1_cfg [] = { ADC_CTL_1, 0x40 };
+	static u8 mt352_agc_cfg [] = { AGC_TARGET, 0x28, 0xa1 };
+	static u8 mt352_acq_ctl [] = { ACQ_CTL, 0x50 };
+
+	mt352_write(mt352_clock_config, sizeof(mt352_clock_config));
+	udelay(2000);
+	mt352_write(mt352_reset, sizeof(mt352_reset));
+	mt352_write(mt352_adc_ctl_1_cfg, sizeof(mt352_adc_ctl_1_cfg));
+	mt352_write(mt352_acq_ctl, sizeof(mt352_acq_ctl));
+
+	mt352_write(mt352_agc_cfg, sizeof(mt352_agc_cfg));
+
+	return 0;
+}
+
+static unsigned char mt352_cp_TUA6034(u32 freq)
+{
+	unsigned char cp = 0;
+
+	if (freq < 542)
+		cp = 0xbe;
+	else if (freq < 830)
+		cp = 0xf6;
+	else
+		cp = 0xfe;
+
+	return cp;
+}
+
+static unsigned char mt352_cp_AVERMEDIA771(u32 freq)
+{
+	unsigned char cp = 0;
+
+	if (freq < 150)
+		cp = 0xB4;
+	else if (freq < 173)
+		cp = 0xBC;
+	else if (freq < 250)
+		cp = 0xB4;
+	else if (freq < 400)
+		cp = 0xBC;
+	else if (freq < 420)
+		cp = 0xF4;
+	else if (freq < 470)
+		cp = 0xFC;
+	else if (freq < 600)
+		cp = 0xBC;
+	else if (freq < 730)
+		cp = 0xF4;
+	else
+		cp = 0xFC;
+
+	return cp;
+}
+
+static unsigned char mt352_cp_TDTC9251DH01C(u32 freq)
+{
+	return(0xcc);
+}
+
+static unsigned char mt352_bs_TUA6034(u32 freq)
+{
+	unsigned char bs = 0;
+
+	if (freq < 250)
+		bs = 0x01;
+	else
+		bs = 0x08;
+
+	return bs;
+}
+
+static unsigned char mt352_bs_AVERMEDIA771(u32 freq)
+{
+	unsigned char bs = 0;
+
+	if (freq < 150)
+		bs = 0x01;
+	else if (freq < 173)
+		bs = 0x01;
+	else if (freq < 250)
+		bs = 0x02;
+	else if (freq < 400)
+		bs = 0x02;
+	else if (freq < 420)
+		bs = 0x02;
+	else if (freq < 470)
+		bs = 0x02;
+	else if (freq < 600)
+		bs = 0x08;
+	else if (freq < 730)
+		bs = 0x08;
+	else
+		bs = 0x08;
+
+	return bs;
+}
+
+static unsigned char mt352_bs_TDTC9251DH01C(u32 freq)
+{
+	unsigned char bs = 0;
+
+	if ((freq >= 48) && (freq <= 154))      /* low band */
+		bs = 0x09;
+
+	if ((freq >= 161) && (freq <= 439))     /* medium band */
+		bs = 0x0a;
+
+	if ((freq >= 447) && (freq <= 863))     /* high band */
+		bs = 0x08;
+
+	return bs;
+}
+
+
+static int mt352_detect_avermedia_771(struct i2c_adapter *i2c)
+{
+	int i;
+	u8 reg;
+	u8 id[4];
+	const u8 pciid[4] = { 0x07, 0x71, 0x14, 0x61 };
+	struct i2c_msg msg[2] =
+	{
+		{
+			.addr = 0x50,
+			.flags = I2C_M_NOSTART,
+			.buf = &reg,
+			.len = 1
+		},
+		{
+			.addr = 0x50,
+			.flags = I2C_M_RD,
+			.len = 1
+		}
+	};
+
+	for (i = 0; i < 4; i++)
+	{
+		reg = i + 0xFC;
+		msg[1].buf = id + i;
+		if (i2c_transfer(i2c,msg,2) != 2)
+		{
+			return 0;
+		}
+	}
+
+	return *((u32 *) id) == *((u32 *) pciid);
+}
+
+static int mt352_init(struct i2c_adapter *i2c)
+{
+	/**
+	 *  all register write sequence have the register address of the
+	 *  first register in the first byte, thenafter the value to write
+	 *  into this and the following registers.
+	 *
+	 *
+	 *  We only write non-default settings, all default settings are
+	 *  restored by the full mt352_reset sequence.
+	 *
+	 *
+	 *  The optimal AGC target value and slope might vary from tuner
+	 *  type to tuner type, so check whether you need to adjust this one...
+	 **/
+
+	return(MT352_INIT(i2c));
+}
+
+static int mt352_sleep(struct i2c_adapter *i2c)
+{
+	static u8 mt352_softdown[] = { 0x89, 0x20, 0x08 };
+
+	mt352_write(mt352_softdown, sizeof(mt352_softdown));
+
+	return 0;
+}
+
+static int mt352_set_parameters(struct i2c_adapter *i2c,
+				struct dvb_frontend_parameters *param)
+{
+	unsigned char buf[14];
+	unsigned int tps = 0;
+	struct dvb_ofdm_parameters *op = &param->u.ofdm;
+	u32 freq = param->frequency / 1000000;
+	uint16_t tmp;
+
+	switch (op->code_rate_HP) {
+		case FEC_2_3:
+			tps |= (1 << CODERATE_HP_SHIFT);
+			break;
+		case FEC_3_4:
+			tps |= (2 << CODERATE_HP_SHIFT);
+			break;
+		case FEC_5_6:
+			tps |= (3 << CODERATE_HP_SHIFT);
+			break;
+		case FEC_7_8:
+			tps |= (4 << CODERATE_HP_SHIFT);
+			break;
+		case FEC_1_2:
+		case FEC_AUTO:
+			break;
+		default:
+			return -EINVAL;
+	}
+
+	switch (op->code_rate_LP) {
+		case FEC_2_3:
+			tps |= (1 <<  CODERATE_LP_SHIFT);
+			break;
+		case FEC_3_4:
+			tps |= (2 <<  CODERATE_LP_SHIFT);
+			break;
+		case FEC_5_6:
+			tps |= (3 <<  CODERATE_LP_SHIFT);
+			break;
+		case FEC_7_8:
+			tps |= (4 <<  CODERATE_LP_SHIFT);
+			break;
+		case FEC_1_2:
+		case FEC_AUTO:
+			break;
+		default:
+			return -EINVAL;
+	}
+
+	switch (op->constellation) {
+		case QPSK:
+			break;
+		case QAM_AUTO:
+		case QAM_16:
+			tps |= (1 << CONSTELLATION_SHIFT);
+			break;
+		case QAM_64:
+			tps |= (2 << CONSTELLATION_SHIFT);
+			break;
+		default:
+			return -EINVAL;
+	}
+
+	switch (op->transmission_mode) {
+		case TRANSMISSION_MODE_2K:
+		case TRANSMISSION_MODE_AUTO:
+			break;
+		case TRANSMISSION_MODE_8K:
+			tps |= (1 << TX_MODE_SHIFT);
+			break;
+		default:
+			return -EINVAL;
+	}
+
+	switch (op->guard_interval) {
+		case GUARD_INTERVAL_1_32:
+		case GUARD_INTERVAL_AUTO:
+			break;
+		case GUARD_INTERVAL_1_16:
+			tps |= (1 << GUARD_INTERVAL_SHIFT);
+			break;
+		case GUARD_INTERVAL_1_8:
+			tps |= (2 << GUARD_INTERVAL_SHIFT);
+			break;
+		case GUARD_INTERVAL_1_4:
+			tps |= (3 << GUARD_INTERVAL_SHIFT);
+			break;
+		default:
+			return -EINVAL;
+	}
+
+	switch (op->hierarchy_information) {
+		case HIERARCHY_AUTO:
+		case HIERARCHY_NONE:
+			break;
+		case HIERARCHY_1:
+			tps |= (1 << HIERARCHY_SHIFT);
+			break;
+		case HIERARCHY_2:
+			tps |= (2 << HIERARCHY_SHIFT);
+			break;
+		case HIERARCHY_4:
+			tps |= (3 << HIERARCHY_SHIFT);
+			break;
+		default:
+			return -EINVAL;
+	}
+
+
+	buf[0] = TPS_GIVEN_1; /* TPS_GIVEN_1 and following registers */
+
+	buf[1] = msb(tps);      /* TPS_GIVEN_(1|0) */
+	buf[2] = lsb(tps);
+
+	buf[3] = 0x50;
+
+	/**
+	 *  these settings assume 20.48MHz f_ADC, for other tuners you might
+	 *  need other values. See p. 33 in the MT352 Design Manual.
+	 */
+	if (op->bandwidth == BANDWIDTH_8_MHZ) {
+		buf[4] = 0x72;  /* TRL_NOMINAL_RATE_(1|0) */
+		buf[5] = 0x49;
+	} else if (op->bandwidth == BANDWIDTH_7_MHZ) {
+		buf[4] = 0x64;
+		buf[5] = 0x00;
+	} else {		/* 6MHz */
+		buf[4] = 0x55;
+		buf[5] = 0xb7;
+	}
+
+	buf[6] = 0x31;  /* INPUT_FREQ_(1|0), 20.48MHz clock, 36.166667MHz IF */
+	buf[7] = 0x05;  /* see MT352 Design Manual page 32 for details */
+
+	buf[8] = I2C_TUNER_ADDR;
+
+	/**
+	 *  All the following settings are tuner module dependent,
+	 *  check the datasheet...
+	 */
+
+	/* here we assume 1/6MHz == 166.66kHz stepsize */
+	#define IF_FREQUENCYx6 217    /* 6 * 36.16666666667MHz */
+	tmp = ((param->frequency*3)/500000) + IF_FREQUENCYx6;
+
+	buf[9] = msb(tmp);      /* CHAN_START_(1|0) */
+	buf[10] = lsb(tmp);
+
+	buf[11] = MT352_CHARGE_PUMP(freq);
+	buf[12] = MT352_BAND_SELECT(freq);
+
+	buf[13] = 0x01; /* TUNER_GO!! */
+
+	mt352_write(buf, sizeof(buf));
+
+	return 0;
+}
+
+static u8 mt352_read_register(struct i2c_adapter *i2c, u8 reg)
+{
+	int ret;
+	u8 b0 [] = { reg };
+	u8 b1 [] = { 0 };
+	struct i2c_msg msg [] = { { .addr = I2C_MT352_ADDR,
+				    .flags =  READ_REG_FLAG,
+				    .buf = b0, .len = 1 },
+				  { .addr = I2C_MT352_ADDR,
+				    .flags = I2C_M_RD,
+				    .buf = b1, .len = 1 } };
+
+	ret = i2c_transfer(i2c, msg, 2);
+
+	if (ret != 2)
+		printk(KERN_WARNING
+		       "%s: readreg error (ret == %i)\n", __FUNCTION__, ret);
+
+	return b1[0];
+}
+
+
+static int mt352_get_parameters(struct i2c_adapter *i2c,
+				struct dvb_frontend_parameters *param)
+{
+	u16 tps;
+	u16 div;
+	u8 trl;
+	struct dvb_ofdm_parameters *op = &param->u.ofdm;
+	static const u8 tps_fec_to_api[8] =
+	{
+		FEC_1_2,
+		FEC_2_3,
+		FEC_3_4,
+		FEC_5_6,
+		FEC_7_8,
+		FEC_AUTO,
+		FEC_AUTO,
+		FEC_AUTO
+	};
+
+	if ( (mt352_read_register(i2c,0x00) & 0xC0) != 0xC0 )
+	{
+		return -EINVAL;
+	}
+
+	/* Use TPS_RECEIVED-registers, not the TPS_CURRENT-registers because
+	 * the mt352 sometimes works with the wrong parameters
+	 */
+	tps = (mt352_read_register(i2c,	TPS_RECEIVED_1) << 8) | mt352_read_register(i2c, TPS_RECEIVED_0);
+	div = (mt352_read_register(i2c, CHAN_START_1) << 8) | mt352_read_register(i2c, CHAN_START_0);
+	trl = mt352_read_register(i2c, TRL_NOMINAL_RATE_1);
+
+	op->code_rate_HP = tps_fec_to_api[(tps >> 7) & 7];
+	op->code_rate_LP = tps_fec_to_api[(tps >> 4) & 7];
+
+	switch ( (tps >> 13) & 3)
+	{
+		case 0:
+			op->constellation = QPSK;
+			break;
+		case 1:
+			op->constellation = QAM_16;
+			break;
+		case 2:
+			op->constellation = QAM_64;
+			break;
+		default:
+			op->constellation = QAM_AUTO;
+			break;
+	}
+
+	op->transmission_mode = (tps & 0x01) ? TRANSMISSION_MODE_8K : TRANSMISSION_MODE_2K;
+
+	switch ( (tps >> 2) & 3)
+	{
+		case 0:
+			op->guard_interval = GUARD_INTERVAL_1_32;
+			break;
+		case 1:
+			op->guard_interval = GUARD_INTERVAL_1_16;
+			break;
+		case 2:
+			op->guard_interval = GUARD_INTERVAL_1_8;
+			break;
+		case 3:
+			op->guard_interval = GUARD_INTERVAL_1_4;
+			break;
+		default:
+			op->guard_interval = GUARD_INTERVAL_AUTO;
+			break;
+	}
+
+	switch ( (tps >> 10) & 7)
+	{
+		case 0:
+			op->hierarchy_information = HIERARCHY_NONE;
+			break;
+		case 1:
+			op->hierarchy_information = HIERARCHY_1;
+			break;
+		case 2:
+			op->hierarchy_information = HIERARCHY_2;
+			break;
+		case 3:
+			op->hierarchy_information = HIERARCHY_4;
+			break;
+		default:
+			op->hierarchy_information = HIERARCHY_AUTO;
+			break;
+	}
+
+	param->frequency = ( 500 * (div - IF_FREQUENCYx6) ) / 3 * 1000;
+
+	if (trl == 0x72)
+	{
+		op->bandwidth = BANDWIDTH_8_MHZ;
+	}
+	else if (trl == 0x64)
+	{
+		op->bandwidth = BANDWIDTH_7_MHZ;
+	}
+	else
+	{
+		op->bandwidth = BANDWIDTH_6_MHZ;
+	}
+
+
+	if (mt352_read_register(i2c, STATUS_2) & 0x02)
+		param->inversion = INVERSION_OFF;
+	else
+		param->inversion = INVERSION_ON;
+
+	return 0;
+}
+
+
+static int mt352_ioctl(struct dvb_frontend *fe, unsigned int cmd, void *arg)
+{
+	struct mt352_state *state = fe->data;
+	struct i2c_adapter *i2c = state->i2c;
+	u8 r,snr;
+	fe_status_t *status;
+	u16 signal;
+	struct dvb_frontend_tune_settings *fe_tune_settings;
+
+	switch (cmd) {
+	case FE_GET_INFO:
+		memcpy (arg, &mt352_info, sizeof(struct dvb_frontend_info));
+		break;
+
+	case FE_READ_STATUS:
+		status = arg;
+		*status = 0;
+		r = mt352_read_register (i2c, STATUS_0);
+		if (r & (1 << 4))
+			*status = FE_HAS_CARRIER;
+		if (r & (1 << 1))
+			*status |= FE_HAS_VITERBI;
+		if (r & (1 << 5))
+			*status |= FE_HAS_LOCK;
+
+		r = mt352_read_register (i2c, STATUS_1);
+		if (r & (1 << 1))
+			*status |= FE_HAS_SYNC;
+
+		r = mt352_read_register (i2c, STATUS_3);
+		if (r & (1 << 6))
+			*status |= FE_HAS_SIGNAL;
+
+		break;
+
+	case FE_READ_BER:
+		*((u32 *) arg) = (mt352_read_register (i2c, RS_ERR_CNT_2) << 16) |
+		       (mt352_read_register (i2c, RS_ERR_CNT_1) << 8) |
+		       (mt352_read_register (i2c, RS_ERR_CNT_0));
+		break;
+
+	case FE_READ_SIGNAL_STRENGTH:
+		signal = (mt352_read_register (i2c, AGC_GAIN_3) << 8) |
+			     (mt352_read_register (i2c, AGC_GAIN_2));
+		*((u16*) arg) = ~signal;
+		break;
+
+	case FE_READ_SNR:
+		snr = mt352_read_register (i2c, SNR);
+		*((u16*) arg) = (snr << 8) | snr;
+		break;
+
+	case FE_READ_UNCORRECTED_BLOCKS:
+		*(u32*) arg = (mt352_read_register (i2c,  RS_UBC_1) << 8) |
+			      (mt352_read_register (i2c,  RS_UBC_0));
+		break;
+
+	case FE_SET_FRONTEND:
+		return mt352_set_parameters (i2c,
+				 (struct dvb_frontend_parameters *) arg);
+
+	case FE_GET_FRONTEND:
+		return mt352_get_parameters (i2c,
+				 (struct dvb_frontend_parameters *) arg);
+
+	case FE_GET_TUNE_SETTINGS:
+		fe_tune_settings = (struct dvb_frontend_tune_settings *) arg;
+		fe_tune_settings->min_delay_ms = 800;
+		fe_tune_settings->step_size = 0;
+		fe_tune_settings->max_drift = 0;
+		break;
+
+	case FE_SLEEP:
+		return mt352_sleep(i2c);
+
+	case FE_INIT:
+		return mt352_init(i2c);
+
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static struct i2c_client client_template;
+
+static int mt352_attach_adapter(struct i2c_adapter *i2c)
+{
+	struct mt352_state *state;
+	struct i2c_client *client;
+	static u8 mt352_reset_attach [] = { 0x50, 0xC0 };
+	int ret;
+
+	dprintk("Trying to attach to adapter 0x%x:%s.\n",
+		i2c->id, i2c->name);
+
+	/* set the proper MT352 frequency range */
+	mt352_info.frequency_min =  FE_FREQ_MIN;
+	mt352_info.frequency_max =  FE_FREQ_MAX;
+	mt352_info.frequency_stepsize =  FE_FREQ_STEPSIZE;
+
+	if ( !(state = kmalloc(sizeof(struct mt352_state), GFP_KERNEL)) )
+		return -ENOMEM;
+
+	memset(state, 0, sizeof(struct mt352_state));
+	state->i2c = i2c;
+
+	if (mt352_detect_avermedia_771(i2c)) {
+		card_type = CARD_AVDVBT771;
+	} else if (force_card < 0) {
+		dprintk("Avermedia 771 not detected, maybe you should try the "
+			"'force_card' module parameter?.\n");
+		kfree(state);
+		return -ENODEV;
+	}
+
+	if (force_card > 0) {
+		if (card_type >= 0 && force_card != card_type)
+			printk(KERN_WARNING "dvbfe_mt352: Warning, overriding"
+					    " detected card.\n");
+		card_type = force_card;
+	}
+
+	if (mt352_read_register(i2c, CHIP_ID) != ID_MT352) {
+		kfree(state);
+		return -ENODEV;
+	}
+
+	if (card_type == CARD_AVDVBT771)
+		printk(KERN_INFO FRONTEND_NAME ": Setup for Avermedia 771.\n");
+	else if (card_type == CARD_TUA6034)
+		printk(KERN_INFO FRONTEND_NAME ": Setup for TUA6034.\n");
+	else if (card_type == CARD_TDTC9251DH01C)
+		printk(KERN_INFO FRONTEND_NAME ": Setup for TDTC9251DH01C.\n");
+
+	/* Do a "hard" reset */
+	mt352_write(mt352_reset_attach, sizeof(mt352_reset_attach));
+
+	if ( !(client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL)) ) {
+		kfree(state);
+		return -ENOMEM;
+	}
+
+	memcpy(client, &client_template, sizeof(struct i2c_client));
+	client->adapter = i2c;
+	client->addr = 0; // XXX
+	i2c_set_clientdata(client, state);
+
+	if ((ret = i2c_attach_client(client))) {
+		kfree(client);
+		kfree(state);
+		return ret;
+	}
+
+	BUG_ON(!state->dvb);
+
+	if ((ret = dvb_register_frontend(mt352_ioctl, state->dvb, state,
+					     &mt352_info, THIS_MODULE))) {
+		i2c_detach_client(client);
+		kfree(client);
+		kfree(state);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int mt352_detach_client(struct i2c_client *client)
+{
+	struct mt352_state *state = i2c_get_clientdata(client);
+
+	dvb_unregister_frontend_new (mt352_ioctl, state->dvb);
+	i2c_detach_client(client);
+	BUG_ON(state->dvb);
+	kfree(client);
+	kfree(state);
+	return 0;
+}
+
+static int mt352_command (struct i2c_client *client, unsigned int cmd, void *arg)
+{
+	struct mt352_state *state = i2c_get_clientdata(client);
+
+	switch (cmd) {
+	case FE_REGISTER:
+		state->dvb = arg;
+		break;
+	case FE_UNREGISTER:
+		state->dvb = NULL;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+	return 0;
+}
+
+static struct i2c_driver driver = {
+	.owner 		= THIS_MODULE,
+	.name 		= FRONTEND_NAME,
+	.id 		= I2C_DRIVERID_DVBFE_MT352,
+	.flags 		= I2C_DF_NOTIFY,
+	.attach_adapter = mt352_attach_adapter,
+	.detach_client 	= mt352_detach_client,
+	.command 	= mt352_command,
+};
+
+static struct i2c_client client_template = {
+	.name		= FRONTEND_NAME,
+	.flags 		= I2C_CLIENT_ALLOW_USE,
+	.driver  	= &driver,
+};
+
+static int __init mt352_module_init(void)
+{
+	return i2c_add_driver(&driver);
+}
+
+static void __exit mt352_module_exit(void)
+{
+	if (i2c_del_driver(&driver))
+		printk(KERN_ERR "mt352: driver deregistration failed.\n");
+}
+
+module_init(mt352_module_init);
+module_exit(mt352_module_exit);
+
+MODULE_DESCRIPTION("DVB-T MT352 Zarlink");
+MODULE_AUTHOR("Holger Waechtler, Daniel Mack, Antonio Mancuso");
+MODULE_LICENSE("GPL");
+
diff -uraNwB xx-linux-2.6.8.1/drivers/media/dvb/frontends/mt352.h linux-2.6.8.1-patched/drivers/media/dvb/frontends/mt352.h
--- xx-linux-2.6.8.1/drivers/media/dvb/frontends/mt352.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.8.1-patched/drivers/media/dvb/frontends/mt352.h	2004-07-16 20:20:10.000000000 +0200
@@ -0,0 +1,177 @@
+/*
+ *  Driver for Zarlink DVB-T MT352 demodulator
+ *
+ *  Written by Holger Waechtler <holger@qanu.de>
+ *	 and Daniel Mack <daniel@qanu.de>
+ *
+ *  Support for Samsung TDTC9251DH01C(M) tuner
+ *
+ *  Copyright (C) 2004 Antonio Mancuso <antonio.mancuso@digitaltelevision.it>
+ *                     Amauri  Celani  <acelani@essegi.net>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.=
+ */
+
+#ifndef _MT352_
+#define _MT352_
+
+#define I2C_MT352_ADDR  0x0f
+#define I2C_TUNER_ADDR  0xc2
+#define ID_MT352        0x13
+
+#define CARD_AVDVBT771	    0x00
+#define CARD_TUA6034	    0x01
+#define CARD_TDTC9251DH01C  0x02
+
+#define msb(x) (((x) >> 8) & 0xff)
+#define lsb(x) ((x) & 0xff)
+
+enum mt352_reg_addr {
+	STATUS_0           = 0x00,
+	STATUS_1           = 0x01,
+	STATUS_2           = 0x02,
+	STATUS_3           = 0x03,
+	STATUS_4           = 0x04,
+	INTERRUPT_0        = 0x05,
+	INTERRUPT_1        = 0x06,
+	INTERRUPT_2        = 0x07,
+	INTERRUPT_3        = 0x08,
+	SNR                = 0x09,
+	VIT_ERR_CNT_2      = 0x0A,
+	VIT_ERR_CNT_1      = 0x0B,
+	VIT_ERR_CNT_0      = 0x0C,
+	RS_ERR_CNT_2       = 0x0D,
+	RS_ERR_CNT_1       = 0x0E,
+	RS_ERR_CNT_0       = 0x0F,
+	RS_UBC_1           = 0x10,
+	RS_UBC_0           = 0x11,
+	AGC_GAIN_3         = 0x12,
+	AGC_GAIN_2         = 0x13,
+	AGC_GAIN_1         = 0x14,
+	AGC_GAIN_0         = 0x15,
+	FREQ_OFFSET_2      = 0x17,
+	FREQ_OFFSET_1      = 0x18,
+	FREQ_OFFSET_0      = 0x19,
+	TIMING_OFFSET_1    = 0x1A,
+	TIMING_OFFSET_0    = 0x1B,
+	CHAN_FREQ_1        = 0x1C,
+	CHAN_FREQ_0        = 0x1D,
+	TPS_RECEIVED_1     = 0x1E,
+	TPS_RECEIVED_0     = 0x1F,
+	TPS_CURRENT_1      = 0x20,
+	TPS_CURRENT_0      = 0x21,
+	TPS_CELL_ID_1      = 0x22,
+	TPS_CELL_ID_0      = 0x23,
+	TPS_MISC_DATA_2    = 0x24,
+	TPS_MISC_DATA_1    = 0x25,
+	TPS_MISC_DATA_0    = 0x26,
+	RESET              = 0x50,
+	TPS_GIVEN_1        = 0x51,
+	TPS_GIVEN_0        = 0x52,
+	ACQ_CTL            = 0x53,
+	TRL_NOMINAL_RATE_1 = 0x54,
+	TRL_NOMINAL_RATE_0 = 0x55,
+	INPUT_FREQ_1       = 0x56,
+	INPUT_FREQ_0       = 0x57,
+	TUNER_ADDR         = 0x58,
+	CHAN_START_1       = 0x59,
+	CHAN_START_0       = 0x5A,
+	CONT_1             = 0x5B,
+	CONT_0             = 0x5C,
+	TUNER_GO           = 0x5D,
+	STATUS_EN_0        = 0x5F,
+	STATUS_EN_1        = 0x60,
+	INTERRUPT_EN_0     = 0x61,
+	INTERRUPT_EN_1     = 0x62,
+	INTERRUPT_EN_2     = 0x63,
+	INTERRUPT_EN_3     = 0x64,
+	AGC_TARGET         = 0x67,
+	AGC_CTL            = 0x68,
+	CAPT_RANGE         = 0x75,
+	SNR_SELECT_1       = 0x79,
+	SNR_SELECT_0       = 0x7A,
+	RS_ERR_PER_1       = 0x7C,
+	RS_ERR_PER_0       = 0x7D,
+	CHIP_ID            = 0x7F,
+	CHAN_STOP_1        = 0x80,
+	CHAN_STOP_0        = 0x81,
+	CHAN_STEP_1        = 0x82,
+	CHAN_STEP_0        = 0x83,
+	FEC_LOCK_TIME      = 0x85,
+	OFDM_LOCK_TIME     = 0x86,
+	ACQ_DELAY          = 0x87,
+	SCAN_CTL           = 0x88,
+	CLOCK_CTL          = 0x89,
+	CONFIG             = 0x8A,
+	MCLK_RATIO         = 0x8B,
+	GPP_CTL            = 0x8C,
+	ADC_CTL_1          = 0x8E,
+	ADC_CTL_0          = 0x8F
+};
+
+struct _tuner_info {
+	__u32 fe_frequency_min;
+#define FE_FREQ_MIN tuner_info[card_type].fe_frequency_min
+
+	__u32 fe_frequency_max;
+#define FE_FREQ_MAX tuner_info[card_type].fe_frequency_max
+
+	__u32 fe_frequency_stepsize; //verificare se u32 e' corretto
+#define FE_FREQ_STEPSIZE  tuner_info[card_type].fe_frequency_stepsize
+
+	__u32 coderate_hp_shift; //verificare se u32 giusto
+#define CODERATE_HP_SHIFT tuner_info[card_type].coderate_hp_shift
+
+	__u32 coderate_lp_shift;
+#define CODERATE_LP_SHIFT tuner_info[card_type].coderate_lp_shift
+
+	int constellation_shift;
+#define CONSTELLATION_SHIFT tuner_info[card_type].constellation_shift
+
+	int tx_mode_shift;
+#define TX_MODE_SHIFT tuner_info[card_type].tx_mode_shift
+
+	int guard_interval_shift;
+#define GUARD_INTERVAL_SHIFT tuner_info[card_type].guard_interval_shift
+
+	int hierarchy_shift;
+#define HIERARCHY_SHIFT tuner_info[card_type].hierarchy_shift
+
+	int read_reg_flag;
+#define READ_REG_FLAG tuner_info[card_type].read_reg_flag
+
+	int (* mt352_init) (struct i2c_adapter *i2c);
+#define MT352_INIT tuner_info[card_type].mt352_init
+
+	unsigned char (* mt352_charge_pump) (u32 freq);
+#define MT352_CHARGE_PUMP tuner_info[card_type].mt352_charge_pump
+
+	unsigned char (* mt352_band_select) (u32 freq);
+#define MT352_BAND_SELECT tuner_info[card_type].mt352_band_select
+};
+
+static int mt352_init_TUA6034(struct i2c_adapter *i2c);
+static int mt352_init_AVERMEDIA771(struct i2c_adapter *i2c);
+static int mt352_init_TDTC9251DH01C(struct i2c_adapter *i2c);
+static unsigned char mt352_cp_TUA6034(u32 freq);
+static unsigned char mt352_cp_AVERMEDIA771(u32 freq);
+static unsigned char mt352_cp_TDTC9251DH01C(u32 freq);
+static unsigned char mt352_bs_TUA6034(u32 freq);
+static unsigned char mt352_bs_AVERMEDIA771(u32 freq);
+static unsigned char mt352_bs_TDTC9251DH01C(u32 freq);
+static int mt352_detect_avermedia_771(struct i2c_adapter *i2c);
+
+#endif                          /* _MT352_ */
diff -uraNwB linux-2.6.8.1-dvb1/drivers/media/dvb/frontends/cx22702.c linux-2.6.8.1-patched/drivers/media/dvb/frontends/cx22702.c
--- linux-2.6.8.1-dvb1/drivers/media/dvb/frontends/cx22702.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.8.1-patched/drivers/media/dvb/frontends/cx22702.c	2004-09-17 12:25:15.000000000 +0200
@@ -0,0 +1,900 @@
+/*
+    Conexant 22702 DVB OFDM frontend driver
+
+    based on:
+        Alps TDMB7 DVB OFDM frontend driver
+
+    Copyright (C) 2001-2002 Convergence Integrated Media GmbH
+	  Holger Waechtler <holger@convergence.de>
+
+    Copyright (C) 2004 Steven Toth <steve@toth.demon.co.uk>
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+
+*/    
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+
+#include "dvb_frontend.h"
+
+#define FRONTEND_NAME "dvbfe_cx22702"
+
+#define I2C_EEPROM_SLAVE_ADDR 0x50
+
+#define PLLTYPE_DTT7592 1
+#define PLLTYPE_DTT7595 2
+#define PLLTYPE_DTT7579 3
+
+static int debug = 0;
+
+#define dprintk	if (debug) printk
+
+static struct dvb_frontend_info cx22702_info = {
+	.name			= "CX22702 Demod Thomson 759x/7579 PLL",
+	.type			= FE_OFDM,
+	.frequency_min		= 177000000,
+	.frequency_max		= 858000000,
+	.frequency_stepsize	= 166666,
+	.caps = FE_CAN_FEC_1_2 | FE_CAN_FEC_2_3 | FE_CAN_FEC_3_4 |
+	FE_CAN_FEC_5_6 | FE_CAN_FEC_7_8 | FE_CAN_FEC_AUTO |
+	FE_CAN_QPSK | FE_CAN_QAM_16 | FE_CAN_QAM_64 | FE_CAN_QAM_AUTO |
+	FE_CAN_HIERARCHY_AUTO | FE_CAN_GUARD_INTERVAL_AUTO | 
+	FE_CAN_TRANSMISSION_MODE_AUTO | FE_CAN_RECOVER
+};
+
+struct cx22702_state {
+	struct i2c_adapter *i2c;
+	struct dvb_adapter *dvb;
+	struct dvb_frontend_info cx22702_info;
+   	char pll_type;
+	int pll_addr;
+	int demod_addr;
+	u8 prevUCBlocks;
+};
+
+/* Register values to initialise the demod */
+static u8 init_tab [] = {
+	0x00, 0x00, /* Stop aquisition */
+	0x0B, 0x06,
+	0x09, 0x01,
+	0x0D, 0x41,
+	0x16, 0x32,
+	0x20, 0x0A,
+	0x21, 0x17,
+	0x24, 0x3e,
+	0x26, 0xff,
+	0x27, 0x10,
+	0x28, 0x00,
+	0x29, 0x00,
+	0x2a, 0x10,
+	0x2b, 0x00,
+	0x2c, 0x10,
+	0x2d, 0x00,
+	0x48, 0xd4,
+	0x49, 0x56,
+	0x6b, 0x1e,
+	0xc8, 0x02,
+	0xf8, 0x02,
+	0xf9, 0x00,
+	0xfa, 0x00,
+	0xfb, 0x00,
+	0xfc, 0x00,
+	0xfd, 0x00,
+};
+
+static struct i2c_client client_template;
+
+static int cx22702_writereg (struct i2c_adapter *i2c, int demod_addr, u8 reg, u8 data)
+{
+	int ret;
+	u8 buf [] = { reg, data };
+	struct i2c_msg msg = { .addr = demod_addr, .flags = 0, .buf = buf, .len = 2 };
+
+	ret = i2c_transfer(i2c, &msg, 1);
+
+	if (ret != 1) 
+		printk("%s: writereg error (reg == 0x%02x, val == 0x%02x, ret == %i)\n",
+			__FUNCTION__, reg, data, ret);
+
+	return (ret != 1) ? -1 : 0;
+}
+
+static u8 cx22702_readreg (struct i2c_adapter *i2c, int demod_addr, u8 reg)
+{
+	int ret;
+	u8 b0 [] = { reg };
+	u8 b1 [] = { 0 };
+
+	struct i2c_msg msg [] = {
+		{ .addr = demod_addr, .flags = 0, .buf = b0, .len = 1 },
+		{ .addr = demod_addr, .flags = I2C_M_RD, .buf = b1, .len = 1 } };
+        
+	ret = i2c_transfer(i2c, msg, 2);
+        
+	if (ret != 2) 
+		printk("%s: readreg error (ret == %i)\n", __FUNCTION__, ret);
+
+	return b1[0];
+}
+
+static int pll_readreg(struct i2c_adapter *i2c, int pll_addr, int demod_addr, u8 reg)
+{
+	u8 b0 [] = { reg };
+	u8 b1 [] = { 0 };
+
+	struct i2c_msg msg [] = {
+		{ .addr = pll_addr, .flags = 0,        .buf = b0, .len = 1 },
+		{ .addr = pll_addr, .flags = I2C_M_RD, .buf = b1, .len = 1 }
+	};
+
+	cx22702_writereg (i2c, demod_addr, 0x0D, cx22702_readreg(i2c,demod_addr,0x0D) &0xfe); // Enable PLL bus
+	if (i2c_transfer(i2c, msg, 2) != 2) {
+		printk ("%s i2c pll request failed\n", __FUNCTION__);
+		cx22702_writereg (i2c, demod_addr, 0x0D, cx22702_readreg(i2c,demod_addr,0x0D) | 1); // Disable PLL bus
+		return -ENODEV;
+	}
+	cx22702_writereg (i2c, demod_addr, 0x0D, cx22702_readreg(i2c,demod_addr,0x0D) | 1); // Disable PLL bus
+
+	return b1[0];
+}
+
+static int pll_write (struct i2c_adapter *i2c, int pll_addr, int demod_addr, u8 data [4])
+{
+	int ret=0;
+	struct i2c_msg msg = { .addr = pll_addr, .flags = 0, .buf = data, .len = 4 };
+
+	cx22702_writereg (i2c, demod_addr, 0x0D, cx22702_readreg(i2c,demod_addr,0x0D) &0xfe);  // Enable PLL bus
+	ret = i2c_transfer(i2c, &msg, 1);
+	cx22702_writereg (i2c, demod_addr, 0x0D, cx22702_readreg(i2c,demod_addr,0x0D) | 1); // Disable PLL bus
+
+	if (ret != 1)
+		printk("%s: i/o error (addr == 0x%02x, ret == %i)\n", __FUNCTION__, msg.addr, ret);
+
+	return (ret != 1) ? -1 : 0;
+}
+
+static int pll_dtt759x_set_tv_freq (struct i2c_adapter *i2c, struct cx22702_state *state, u32 freq, int bandwidth)
+{
+	int ret;
+
+	u32 div = (freq + 36166667) / 166666;
+
+	/* dividerhigh, dividerlow, control, bandwidth switch tuner args */
+	unsigned char buf [4] = {
+		(div >> 8) & 0x7f,
+		div & 0xff,
+		0x84,
+		0x00
+	};
+
+	if(freq < 470000000) {
+		buf[3] = 0x02;
+	} else {
+		buf[3] = 0x08;
+	}
+
+	if(bandwidth == BANDWIDTH_7_MHZ) {
+		buf[3] |= 0x10;
+	}
+
+	// Now compensate for the charge pump osc
+	if(freq <= 264000000) {
+		buf[2] = buf[2] | 0x30;
+	} else if (freq <= 735000000) {
+		buf[2] = buf[2] | 0x38;
+	} else if (freq <= 835000000) {
+		buf[2] = buf[2] | 0x70;
+	} else if (freq <= 896000000) {
+		buf[2] = buf[2] | 0x78;
+	}	
+   
+	dprintk ("%s: freq == %i, div == 0x%04x\n", __FUNCTION__, (int) freq, (int) div);
+   
+	ret= pll_write (i2c, state->pll_addr, state->demod_addr, buf);
+	if(ret<0) {
+		dprintk ("%s: first pll_write failed\n",__FUNCTION__);
+		return ret;
+	}
+
+	/* Set the AGC during search */
+	buf[2]=(buf[2] & 0xc7) | 0x18;
+	buf[3]=0xa0;
+	ret=pll_write (i2c, state->pll_addr, state->demod_addr, buf);
+	if(ret<0) {
+		dprintk ("%s: second pll_write failed\n",__FUNCTION__);
+		return ret;
+	}
+
+	/* Tuner needs a small amount of time */
+	msleep(100);
+
+	/* Set the AGC post-search */   
+	buf[3]=0x20;
+	ret=pll_write (i2c, state->pll_addr, state->demod_addr, buf);
+	if(ret<0) {
+		dprintk ("%s: third pll_write failed\n",__FUNCTION__);
+		return ret;
+	}
+
+	return ret;
+
+}
+
+static int pll_dtt7579_set_tv_freq (struct i2c_adapter *i2c, struct cx22702_state *state, u32 freq, int bandwidth)
+{
+	int ret;
+
+	u32 div = (freq + 36166667) / 166666;
+
+	/* dividerhigh, dividerlow */
+	unsigned char buf [4] = {
+		div >> 8,
+		div & 0xff,
+		0x00,
+		0x00
+	};
+
+	// FIXME: bandwidth setting unknown
+   
+	// Now compensate for the charge pump osc
+	if(freq <= 506000000) {
+		buf[2] = 0xb4;
+	   	buf[3] = 0x02;
+	} else if (freq <= 735000000) {
+   		buf[2] = 0xbc;
+	   	buf[3] = 0x08;
+	} else if (freq <= 835000000) {
+      		buf[2] = 0xf4;
+	   	buf[3] = 0x08;
+	} else if (freq <= 896000000) {
+		buf[2] = 0xfc;
+	   	buf[3] = 0x08;
+	}
+
+	dprintk ("%s: freq == %i, div == 0x%04x\n", __FUNCTION__, (int) freq, (int) div);
+
+	ret= pll_write (i2c, state->pll_addr, state->demod_addr, buf);
+	if(ret<0) {
+		dprintk ("%s: first pll_write failed\n",__FUNCTION__);
+		return ret;
+	}
+
+	/* Set the AGC to search */
+	buf[2]=(buf[2] & 0xdc) | 0x9c;
+	buf[3]=0xa0;
+	ret=pll_write (i2c, state->pll_addr, state->demod_addr, buf);
+	if(ret<0) {
+		dprintk ("%s: second pll_write failed\n",__FUNCTION__);
+		return ret;
+	}
+
+	return ret;
+
+}
+
+/* Reset the demod hardware and reset all of the configuration registers
+   to a default state. */
+static int cx22702_init (struct i2c_adapter *i2c, struct cx22702_state *state)
+{
+	int i;
+
+	cx22702_writereg (i2c, state->demod_addr, 0x00, 0x02);
+
+	msleep(10);
+	
+	for (i=0; i<sizeof(init_tab); i+=2)
+		cx22702_writereg (i2c, state->demod_addr, init_tab[i], init_tab[i+1]);
+
+	return 0;	
+}
+
+static int cx22702_set_inversion (struct i2c_adapter *i2c, struct cx22702_state *state, int inversion)
+{
+	u8 val;
+
+	switch (inversion) {
+
+		case INVERSION_AUTO:
+			return -EOPNOTSUPP;
+
+		case INVERSION_ON:
+			val = cx22702_readreg (i2c, state->demod_addr, 0x0C);
+			return cx22702_writereg (i2c, state->demod_addr, 0x0C, val | 0x01);
+
+		case INVERSION_OFF:
+			val = cx22702_readreg (i2c, state->demod_addr, 0x0C);
+			return cx22702_writereg (i2c, state->demod_addr, 0x0C, val & 0xfe);
+
+		default:
+			return -EINVAL;
+
+	}
+
+}
+
+/* Talk to the demod, set the FEC, GUARD, QAM settings etc */
+static int cx22702_set_tps (struct i2c_adapter *i2c, struct cx22702_state *state,
+			    struct dvb_frontend_parameters *p)
+{
+	u8 val;
+
+	/* set PLL */
+	switch(state->pll_type) {
+	case PLLTYPE_DTT7592:
+	case PLLTYPE_DTT7595:
+		pll_dtt759x_set_tv_freq (i2c, state, p->frequency, p->u.ofdm.bandwidth);
+		break;
+
+	case PLLTYPE_DTT7579:
+		pll_dtt7579_set_tv_freq (i2c, state, p->frequency, p->u.ofdm.bandwidth);
+		break;
+	}
+   
+	/* set inversion */
+	cx22702_set_inversion (i2c, state, p->inversion);
+
+	/* set bandwidth */
+	switch(p->u.ofdm.bandwidth) {
+	case BANDWIDTH_6_MHZ:
+		cx22702_writereg(i2c, state->demod_addr, 0x0C, (cx22702_readreg(i2c, state->demod_addr, 0x0C) & 0xcf) | 0x20 );
+		break;
+	case BANDWIDTH_7_MHZ:
+		cx22702_writereg(i2c, state->demod_addr, 0x0C, (cx22702_readreg(i2c, state->demod_addr, 0x0C) & 0xcf) | 0x10 );
+		break;
+	case BANDWIDTH_8_MHZ:
+		cx22702_writereg(i2c, state->demod_addr, 0x0C, cx22702_readreg(i2c, state->demod_addr, 0x0C) &0xcf );
+		break;
+	default:
+		dprintk ("%s: invalid bandwidth\n",__FUNCTION__);
+		return -EINVAL;
+	}
+
+   
+	p->u.ofdm.code_rate_LP = FEC_AUTO; //temp hack as manual not working
+     
+	/* use auto configuration? */
+	if((p->u.ofdm.hierarchy_information==HIERARCHY_AUTO) || 
+	   (p->u.ofdm.constellation==QAM_AUTO) ||
+	   (p->u.ofdm.code_rate_HP==FEC_AUTO) || 
+	   (p->u.ofdm.code_rate_LP==FEC_AUTO) || 
+	   (p->u.ofdm.guard_interval==GUARD_INTERVAL_AUTO) || 
+	   (p->u.ofdm.transmission_mode==TRANSMISSION_MODE_AUTO) ) {
+
+		/* TPS Source - use hardware driven values */
+		cx22702_writereg(i2c, state->demod_addr, 0x06, 0x10);
+		cx22702_writereg(i2c, state->demod_addr, 0x07, 0x9);
+		cx22702_writereg(i2c, state->demod_addr, 0x08, 0xC1);
+		cx22702_writereg(i2c, state->demod_addr, 0x0B, cx22702_readreg(i2c, state->demod_addr, 0x0B) & 0xfc );
+		cx22702_writereg(i2c, state->demod_addr, 0x0C, (cx22702_readreg(i2c, state->demod_addr, 0x0C) & 0xBF) | 0x40 );
+		cx22702_writereg(i2c, state->demod_addr, 0x00, 0x01); /* Begin aquisition */
+		printk("%s: Autodetecting\n",__FUNCTION__);
+		return 0;
+	}
+
+   	/* manually programmed values */
+	val=0;
+	switch(p->u.ofdm.constellation) {
+		case   QPSK: val = (val&0xe7); break;
+		case QAM_16: val = (val&0xe7)|0x08; break;
+		case QAM_64: val = (val&0xe7)|0x10; break;
+		default:
+			dprintk ("%s: invalid constellation\n",__FUNCTION__);
+			return -EINVAL;
+	}
+	switch(p->u.ofdm.hierarchy_information) {
+		case HIERARCHY_NONE: val = (val&0xf8); break;
+		case    HIERARCHY_1: val = (val&0xf8)|1; break;
+		case    HIERARCHY_2: val = (val&0xf8)|2; break;
+		case    HIERARCHY_4: val = (val&0xf8)|3; break;
+		default:
+			dprintk ("%s: invalid hierarchy\n",__FUNCTION__);
+			return -EINVAL;
+	}
+	cx22702_writereg (i2c, state->demod_addr, 0x06, val);
+
+	val=0;
+	switch(p->u.ofdm.code_rate_HP) {
+		case FEC_NONE:
+		case FEC_1_2: val = (val&0xc7); break;
+		case FEC_2_3: val = (val&0xc7)|0x08; break;
+		case FEC_3_4: val = (val&0xc7)|0x10; break;
+		case FEC_5_6: val = (val&0xc7)|0x18; break;
+		case FEC_7_8: val = (val&0xc7)|0x20; break;
+		default:
+			dprintk ("%s: invalid code_rate_HP\n",__FUNCTION__);
+			return -EINVAL;
+	}
+	switch(p->u.ofdm.code_rate_LP) {
+		case FEC_NONE:
+		case FEC_1_2: val = (val&0xf8); break;
+		case FEC_2_3: val = (val&0xf8)|1; break;
+		case FEC_3_4: val = (val&0xf8)|2; break;
+		case FEC_5_6: val = (val&0xf8)|3; break;
+		case FEC_7_8: val = (val&0xf8)|4; break;
+		default:
+			dprintk ("%s: invalid code_rate_LP\n",__FUNCTION__);
+			return -EINVAL;
+	}
+	cx22702_writereg (i2c, state->demod_addr, 0x07, val);
+
+	val=0;
+	switch(p->u.ofdm.guard_interval) {
+		case GUARD_INTERVAL_1_32: val = (val&0xf3); break;
+		case GUARD_INTERVAL_1_16: val = (val&0xf3)|0x04; break;
+		case  GUARD_INTERVAL_1_8: val = (val&0xf3)|0x08; break;
+		case  GUARD_INTERVAL_1_4: val = (val&0xf3)|0x0c; break;
+		default:
+			dprintk ("%s: invalid guard_interval\n",__FUNCTION__);
+			return -EINVAL;
+	}
+	switch(p->u.ofdm.transmission_mode) {
+		case TRANSMISSION_MODE_2K: val = (val&0xfc); break;
+		case TRANSMISSION_MODE_8K: val = (val&0xfc)|1; break;
+		default:
+			dprintk ("%s: invalid transmission_mode\n",__FUNCTION__);
+			return -EINVAL;
+	}
+	cx22702_writereg (i2c, state->demod_addr, 0x08, val);
+	cx22702_writereg(i2c, state->demod_addr, 0x0B, (cx22702_readreg(i2c, state->demod_addr, 0x0B) & 0xfc) | 0x02 );
+	cx22702_writereg(i2c, state->demod_addr, 0x0C, (cx22702_readreg(i2c, state->demod_addr, 0x0C) & 0xBF) | 0x40 );
+
+	/* Begin channel aquisition */
+	cx22702_writereg(i2c, state->demod_addr, 0x00, 0x01);
+
+	return 0;
+}
+
+/* Retrieve the demod settings */
+static int cx22702_get_tps (struct i2c_adapter *i2c, struct cx22702_state *state,
+			    struct dvb_ofdm_parameters *p)
+{
+	u8 val;
+
+	/* Make sure the TPS regs are valid */
+	if (!(cx22702_readreg(i2c, state->demod_addr, 0x0A) & 0x20))
+		return -EAGAIN;
+
+	val = cx22702_readreg (i2c, state->demod_addr, 0x01);
+	switch( (val&0x18)>>3) {
+		case 0: p->constellation =   QPSK; break;
+		case 1: p->constellation = QAM_16; break;
+		case 2: p->constellation = QAM_64; break;
+	}
+	switch( val&0x07 ) {
+		case 0: p->hierarchy_information = HIERARCHY_NONE; break;
+		case 1: p->hierarchy_information =    HIERARCHY_1; break;
+		case 2: p->hierarchy_information =    HIERARCHY_2; break;
+		case 3: p->hierarchy_information =    HIERARCHY_4; break;
+	}
+
+
+	val = cx22702_readreg (i2c, state->demod_addr, 0x02);
+	switch( (val&0x38)>>3 ) {
+		case 0: p->code_rate_HP = FEC_1_2; break;
+		case 1: p->code_rate_HP = FEC_2_3; break;
+		case 2: p->code_rate_HP = FEC_3_4; break;
+		case 3: p->code_rate_HP = FEC_5_6; break;
+		case 4: p->code_rate_HP = FEC_7_8; break;
+	}
+	switch( val&0x07 ) {
+		case 0: p->code_rate_LP = FEC_1_2; break;
+		case 1: p->code_rate_LP = FEC_2_3; break;
+		case 2: p->code_rate_LP = FEC_3_4; break;
+		case 3: p->code_rate_LP = FEC_5_6; break;
+		case 4: p->code_rate_LP = FEC_7_8; break;
+	}
+
+
+	val = cx22702_readreg (i2c, state->demod_addr, 0x03);
+	switch( (val&0x0c)>>2 ) {
+		case 0: p->guard_interval = GUARD_INTERVAL_1_32; break;
+		case 1: p->guard_interval = GUARD_INTERVAL_1_16; break;
+		case 2: p->guard_interval =  GUARD_INTERVAL_1_8; break;
+		case 3: p->guard_interval =  GUARD_INTERVAL_1_4; break;
+	}
+	switch( val&0x03 ) {
+		case 0: p->transmission_mode = TRANSMISSION_MODE_2K; break;
+		case 1: p->transmission_mode = TRANSMISSION_MODE_8K; break;
+	}
+
+	return 0;
+}
+
+static int cx22702_ioctl (struct dvb_frontend *fe, unsigned int cmd, void *arg)
+{
+	struct cx22702_state *state = fe->data;
+	struct i2c_adapter *i2c = state->i2c;
+	u8 reg0A;
+	u8 reg23;
+	u8 ucblocks;
+
+	switch (cmd) {
+		case FE_GET_INFO:
+			memcpy (arg, &state->cx22702_info, sizeof(struct dvb_frontend_info));
+			break;
+
+		case FE_READ_STATUS:
+		{
+			fe_status_t *status = (fe_status_t *) arg;
+
+			*status = 0;
+
+			reg0A = cx22702_readreg (i2c, state->demod_addr, 0x0A);
+			reg23 = cx22702_readreg (i2c, state->demod_addr, 0x23);
+
+			dprintk ("%s: status demod=0x%02x agc=0x%02x\n"
+				,__FUNCTION__,reg0A,reg23);
+
+			if(reg0A & 0x10) {
+				*status |= FE_HAS_LOCK;
+				*status |= FE_HAS_VITERBI;
+				*status |= FE_HAS_SYNC;
+			}
+
+			if(reg0A & 0x20) 
+				*status |= FE_HAS_CARRIER;
+
+			if(reg23 < 0xf0) 
+				*status |= FE_HAS_SIGNAL;
+
+			break;
+
+		}
+
+		case FE_READ_BER:
+			if(cx22702_readreg (i2c, state->demod_addr, 0xE4) & 0x02) {
+				/* Realtime statistics */
+				*((u32*) arg) = (cx22702_readreg (i2c, state->demod_addr, 0xDE) & 0x7F) << 7
+					| (cx22702_readreg (i2c, state->demod_addr, 0xDF)&0x7F);
+			} else {
+				/* Averagtine statistics */
+				*((u32*) arg) = (cx22702_readreg (i2c, state->demod_addr, 0xDE) & 0x7F) << 7
+					| cx22702_readreg (i2c, state->demod_addr, 0xDF);
+			}
+			break;
+
+		case FE_READ_SIGNAL_STRENGTH:
+		{
+			u16 ss = cx22702_readreg (i2c, state->demod_addr, 0x23);
+			*((u16*) arg) = ss;
+			break;
+		}
+
+		/* We don't have an register for this */
+		/* We'll take the inverse of the BER register */
+		case FE_READ_SNR:
+		{
+			u16 rs_ber=0;
+			if(cx22702_readreg (i2c, state->demod_addr, 0xE4) & 0x02) {
+				/* Realtime statistics */
+				rs_ber = (cx22702_readreg (i2c, state->demod_addr, 0xDE) & 0x7F) << 7
+					| (cx22702_readreg (i2c, state->demod_addr, 0xDF)& 0x7F);
+			} else {
+				/* Averagine statistics */
+				rs_ber = (cx22702_readreg (i2c, state->demod_addr, 0xDE) & 0x7F) << 8
+					| cx22702_readreg (i2c, state->demod_addr, 0xDF);
+			}
+			*((u16*) arg) = ~rs_ber;
+			break;
+		}
+
+		case FE_READ_UNCORRECTED_BLOCKS: 
+			/* RS Uncorrectable Packet Count then reset */
+			ucblocks = cx22702_readreg (i2c, state->demod_addr, 0xE3);
+			if (state->prevUCBlocks < ucblocks) *((u32*) arg) = (ucblocks - state->prevUCBlocks);
+			else *((u32*) arg) = state->prevUCBlocks - ucblocks;
+	   		state->prevUCBlocks = ucblocks;
+			break;
+
+		case FE_SET_FRONTEND:
+		{
+			struct dvb_frontend_parameters *p = arg;
+			int ret;
+
+			if((ret=cx22702_set_tps (i2c, state, p))<0) {
+				dprintk ("%s: set_tps failed ret=%d\n",__FUNCTION__,ret);
+				return ret;
+			}
+			break;
+		}
+
+		case FE_GET_FRONTEND:
+		{
+			struct dvb_frontend_parameters *p = arg;
+			u8 reg0C = cx22702_readreg (i2c, state->demod_addr, 0x0C);
+		
+			p->inversion = reg0C & 0x1 ? INVERSION_ON : INVERSION_OFF;
+			return cx22702_get_tps (i2c, state, &p->u.ofdm);
+		}
+
+		case FE_INIT:
+			return cx22702_init (i2c, state);
+
+		default:
+			return -EOPNOTSUPP;
+	};
+
+	return 0;
+}
+
+/* Validate the eeprom contents, make sure content look ok.
+   Get the eeprom data. */
+static int cx22702_validate_eeprom(struct i2c_adapter *i2c, int* minfreq, int* pll_type, int* pll_addr, int* demod_addr)
+{
+	u8 b0 [] = { 0 };
+	u8 b1 [128];
+	u32 model=0;
+	u8 tuner=0;
+	int i,j;
+
+	struct i2c_msg msg [] = {
+		{ .addr = I2C_EEPROM_SLAVE_ADDR, .flags = 0,        .buf = b0, .len = 1 },
+		{ .addr = I2C_EEPROM_SLAVE_ADDR, .flags = I2C_M_RD, .buf = b1, .len = 128 }
+	};
+
+	if (i2c_transfer(i2c, msg, 2) != 2) {
+		printk ("%s i2c eeprom request failed\n", __FUNCTION__);
+		return -ENODEV;
+	}
+
+	if(debug) {
+		dprintk ("i2c eeprom content:\n");
+		j=0;
+		for(i=0;i<128;i++) {
+			dprintk("%02x ",b1[i]);
+			if(j++==16) {
+				dprintk("\n");
+				j=0;
+			}
+		}
+ 		dprintk("\n");
+	}
+
+	if( (b1[8]!=0x84) || (b1[10]!=0x00) ) {
+		printk ("%s eeprom content is not valid\n", __FUNCTION__);
+		return -ENODEV;
+	}
+
+	/* Make sure we support the board model */
+	model = b1[0x1f] << 24 | b1[0x1e] << 16 | b1[0x1d] << 8 | b1[0x1c];
+	switch(model) {
+		case 90002:
+		case 90500:
+		case 90501:
+			dprintk ("%s: Model #%d\n",__FUNCTION__,model);
+			break;	
+		default:
+			printk ("%s: Unknown model #%d not supported\n",__FUNCTION__,model);
+			return -ENODEV;	
+	}
+
+	/* Make sure we support the tuner */
+	tuner = b1[0x2d];
+	switch(tuner) {
+		case 0x4B:
+			dprintk ("%s: Tuner Thomson DTT 7595\n",__FUNCTION__);
+			*minfreq = 177000000;
+			*pll_type = PLLTYPE_DTT7595;
+			break;	
+		case 0x4C:
+			dprintk ("%s: Tuner Thomson DTT 7592\n",__FUNCTION__);
+			*minfreq = 474000000;
+			*pll_type = PLLTYPE_DTT7592;
+			break;	
+		default:
+			printk ("%s: Unknown tuner 0x%02x not supported\n",__FUNCTION__,tuner);
+			return -ENODEV;	
+	}
+	*pll_addr = 0x61;
+	*demod_addr = 0x43;   
+	return 0;
+}
+
+
+/* Validate the demod, make sure we understand the hardware */
+static int cx22702_validate_demod(struct i2c_adapter *i2c, int demod_addr)
+{
+	u8 b0 [] = { 0x1f };
+	u8 b1 [] = { 0 };
+
+	struct i2c_msg msg [] = {
+		{ .addr = demod_addr, .flags = 0,        .buf = b0, .len = 1 },
+		{ .addr = demod_addr, .flags = I2C_M_RD, .buf = b1, .len = 1 }
+	};
+
+	if (i2c_transfer(i2c, msg, 2) != 2) {
+		printk ("%s i2c demod request failed\n", __FUNCTION__);
+		return -ENODEV;
+	}
+
+	if( (b1[0]!=0x3) ) {
+		printk ("%s i2c demod type 0x(%02x) not known\n", __FUNCTION__,b1[0]);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+/* Validate the tuner PLL, make sure we understand the hardware */
+static int cx22702_validate_pll(struct i2c_adapter *i2c, int pll_addr, int demod_addr)
+{
+	int result=0;
+
+	if( (result=pll_readreg(i2c,pll_addr,demod_addr,0xc2)) < 0)
+		return result;
+
+	if( (result >= 0) && (result&0x30) )
+		return 0;
+
+	return result;
+}
+
+/* Check we can see the I2c clients */
+static int cx22702_attach_adapter(struct i2c_adapter *adapter)
+{
+	struct cx22702_state *state;
+	struct i2c_client *client;
+	int ret;
+	int minfreq;
+	int pll_type;
+	int pll_addr;
+	int demod_addr;
+
+	if (0 == (adapter->class & I2C_CLASS_TV_DIGITAL)) {
+		dprintk("Ignoring adapter 0x%x:%s (no digital tv card).\n",
+			adapter->id, adapter->name);
+		return 0;
+	}
+
+	dprintk("Trying to attach to adapter 0x%x:%s.\n",
+		adapter->id, adapter->name);
+
+	if (!strcmp(adapter->name, "Conexant DVB-T reference design")) {
+	   	printk("cx22702: Detected Conexant DVB-T card - PLL Thomson DTT7579\n");
+		pll_type = PLLTYPE_DTT7579;
+		pll_addr = 0x60;
+		demod_addr = 0x43;
+		minfreq = 177000000; // guess
+	} else {
+		// default to Hauppauge Nova-T for the moment
+	   	printk("cx22702: Detected Hauppauge Nova-T DVB-T - PLL Thomson DTT759x\n");
+		ret=cx22702_validate_eeprom(adapter, &minfreq, &pll_type, &pll_addr, &demod_addr);
+		if(ret < 0)
+			return ret;
+	}
+
+	ret=cx22702_validate_demod(adapter, demod_addr);
+	if(ret < 0)
+		return ret;
+
+	ret=cx22702_validate_pll(adapter, pll_addr, demod_addr);
+	if(ret < 0)
+		return ret;
+
+	if ( !(state = kmalloc(sizeof(struct cx22702_state), GFP_KERNEL)) )
+		return -ENOMEM;
+
+	memset(state, 0, sizeof(struct cx22702_state));
+	state->i2c = adapter;
+	memcpy(&state->cx22702_info, &cx22702_info, sizeof(struct dvb_frontend_info));   
+	state->cx22702_info.frequency_min = minfreq;
+	state->pll_type = pll_type;
+	state->pll_addr = pll_addr; 
+	state->demod_addr = demod_addr;
+
+	if ( !(client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL)) ) {
+		kfree(state);
+		return -ENOMEM;
+	}
+
+	memcpy(client, &client_template, sizeof(struct i2c_client));
+	client->adapter = adapter;
+	client->addr = state->demod_addr;
+	i2c_set_clientdata(client, state);
+   
+	if ((ret = i2c_attach_client(client))) {
+		printk("cx22702: attach failed %i\n", ret);
+		kfree(client);
+		kfree(state);
+		return ret;
+	}
+	return 0;	
+}
+
+static int cx22702_detach_client(struct i2c_client *client)
+{
+	struct cx22702_state *state = i2c_get_clientdata(client);
+
+	if (NULL != state->dvb) {
+		dvb_unregister_frontend (cx22702_ioctl, state->dvb);
+		state->dvb = NULL;
+	}
+	i2c_detach_client(client);
+	kfree(client);
+	return 0;
+}
+
+static int command(struct i2c_client *client, unsigned int cmd, void *arg)
+{
+	struct cx22702_state *state = i2c_get_clientdata(client);
+	int rc;
+
+	switch(cmd) {
+	case FE_REGISTER:
+		if (NULL != state->dvb)
+			break;
+		state->dvb = arg;
+		rc = dvb_register_frontend(cx22702_ioctl, state->dvb, state,
+					   &state->cx22702_info, THIS_MODULE);
+		if (0 != rc) {
+			printk("cx22702: dvb_register_frontend failed with rc=%d\n",rc);
+			state->dvb = NULL;
+			return rc;
+		}
+		break;
+	case FE_UNREGISTER:
+		if (NULL == state->dvb)
+			break;
+		dvb_unregister_frontend (cx22702_ioctl, state->dvb);
+		state->dvb = NULL;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static struct i2c_driver driver = {
+	.owner = THIS_MODULE,
+	.name  = FRONTEND_NAME,
+	.id = I2C_DRIVERID_DVBFE_CX22702,
+	.flags = I2C_DF_NOTIFY,
+	.attach_adapter = cx22702_attach_adapter,
+	.detach_client = cx22702_detach_client,
+	.command = command,
+};
+
+static struct i2c_client client_template = {
+	.name = FRONTEND_NAME,
+	.flags = I2C_CLIENT_ALLOW_USE,
+	.driver = &driver,
+};
+
+static int __init init_cx22702 (void)
+{
+	return i2c_add_driver(&driver);
+}
+
+static void __exit exit_cx22702 (void)
+{
+	if (i2c_del_driver(&driver))
+		printk(KERN_ERR "cx22702: driver deregistration failed.\n");
+}
+
+module_init (init_cx22702);
+module_exit (exit_cx22702);
+
+MODULE_PARM(debug,"i");
+MODULE_PARM_DESC(debug, "Enable verbose debug messages");
+MODULE_DESCRIPTION("CX22702 / Thomson DTT 759x / Thomson DTT 7579 PLL DVB Frontend driver");
+MODULE_AUTHOR("Steven Toth");
+MODULE_LICENSE("GPL");
+

--------------010603070403060403060007--
