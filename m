Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268799AbUIQPO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268799AbUIQPO4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 11:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268734AbUIQPOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 11:14:55 -0400
Received: from mail.convergence.de ([212.227.36.84]:32161 "EHLO
	email.convergence2.de") by vger.kernel.org with ESMTP
	id S268799AbUIQOhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 10:37:09 -0400
Message-ID: <414AF65F.2010200@linuxtv.org>
Date: Fri, 17 Sep 2004 16:36:15 +0200
From: Michael Hunold <hunold@linuxtv.org>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][2.6][10/14] add new frontend drivers 2/2
References: <414AF2CA.3000502@linuxtv.org> <414AF31B.1090103@linuxtv.org> <414AF399.3030708@linuxtv.org> <414AF41A.6060009@linuxtv.org> <414AF461.4050707@linuxtv.org> <414AF4CE.7000000@linuxtv.org> <414AF51D.4060308@linuxtv.org> <414AF569.2020803@linuxtv.org> <414AF5BF.4020401@linuxtv.org> <414AF605.5040605@linuxtv.org>
In-Reply-To: <414AF605.5040605@linuxtv.org>
Content-Type: multipart/mixed;
 boundary="------------030306050904050801070009"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030306050904050801070009
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------030306050904050801070009
Content-Type: text/plain;
 name="10-DVB-add-frontend-2-2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="10-DVB-add-frontend-2-2.diff"

- [DVB] add new driver for mobile DVB-T demodulator DiBcom 3000-MB
- [DVB] add new drivers to Makefile

Signed-off-by: Michael Hunold <hunold@linuxtv.org>

diff -uraNwB linux-2.6.8.1-dvb1/drivers/media/dvb/frontends/dib3000mb.c linux-2.6.8.1-patched/drivers/media/dvb/frontends/dib3000mb.c
--- linux-2.6.8.1-dvb1/drivers/media/dvb/frontends/dib3000mb.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.8.1-patched/drivers/media/dvb/frontends/dib3000mb.c	2004-09-17 12:25:15.000000000 +0200
@@ -0,0 +1,857 @@
+/*
+ * Frontend driver for mobile DVB-T demodulator DiBcom 3000-MB 
+ * DiBcom (http://www.dibcom.fr/)
+ *
+ * Copyright (C) 2004 Patrick Boettcher (patrick.boettcher@desy.de)
+ * 
+ * based on GPL code from DibCom, which has
+ *
+ * Copyright (C) 2004 Amaury Demol for DiBcom (ademol@dibcom.fr)
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License as
+ *	published by the Free Software Foundation, version 2.
+ *
+ * Acknowledgements
+ * 
+ *  Amaury Demol (ademol@dibcom.fr) from DiBcom for providing specs and driver
+ *  sources, on which this driver (and the dvb-dibusb) are based.
+ *
+ * see Documentation/dvb/README.dibusb for more information
+ * 
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/version.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+
+#include "dvb_frontend.h"
+
+#include "dib3000mb.h"
+
+/* debug */
+
+#ifdef CONFIG_DVB_DIBCOM_DEBUG
+#define dprintk_new(level,args...) \
+	do { if ((debug & level)) { printk(args); } } while (0)
+
+static int debug;
+module_param(debug, int, 0x644);
+MODULE_PARM_DESC(debug, "set debugging level (1=info,2=xfer,4=alotmore (|-able)).");
+#else
+#define dprintk_new(args...)
+#endif
+
+#define deb_info(args...) dprintk_new(0x01,args)
+#define deb_xfer(args...) dprintk_new(0x02,args)
+#define deb_alot(args...) dprintk_new(0x04,args)
+
+/* Version information */
+#define DRIVER_VERSION "0.1"
+#define DRIVER_DESC "DiBcom 3000-MB DVB-T frontend"
+#define DRIVER_AUTHOR "Patrick Boettcher, patrick.boettcher@desy.de"
+
+struct dib3000mb_state {
+	struct i2c_client *i2c;
+	struct dvb_adapter *dvb;
+	u16 manufactor_id;
+	u16 device_id;
+};
+
+static struct dvb_frontend_info dib3000mb_info = {
+	.name			= "DiBcom 3000-MB DVB-T frontend",
+	.type 			= FE_OFDM,
+	.frequency_min 		= 44250000,
+	.frequency_max 		= 867250000,
+	.frequency_stepsize	= 62500,
+	.caps = FE_CAN_INVERSION_AUTO |
+			FE_CAN_FEC_1_2 | FE_CAN_FEC_2_3 | FE_CAN_FEC_3_4 |
+			FE_CAN_FEC_5_6 | FE_CAN_FEC_7_8 | FE_CAN_FEC_AUTO |
+			FE_CAN_QPSK | FE_CAN_QAM_16 | FE_CAN_QAM_64 | FE_CAN_QAM_AUTO |
+			FE_CAN_TRANSMISSION_MODE_AUTO | 
+			FE_CAN_GUARD_INTERVAL_AUTO | 
+			FE_CAN_HIERARCHY_AUTO,
+};
+
+
+#define rd(reg) dib3000mb_read_reg(state->i2c,reg)
+#define wr(reg,val) if (dib3000mb_write_reg(state->i2c,reg,val)) \
+	{ err("while sending 0x%04x to 0x%04x.",val,reg); return -EREMOTEIO; }
+#define wr_foreach(a,v) { int i; \
+	deb_alot("sizeof: %d %d\n",sizeof(a),sizeof(v));\
+	for (i=0; i < sizeof(a)/sizeof(u16); i++) \
+		wr(a[i],v[i]); \
+}
+
+static u16 dib3000mb_read_reg(struct i2c_client *i2c, u16 reg)
+{
+	u8 wb[] = { ((reg >> 8) | 0x80) & 0xff, reg & 0xff };
+	u8 rb[2]; 
+	struct i2c_msg msg[] = {
+		{ .addr = i2c->addr, .flags = 0,        .buf = wb, .len = 2 },
+		{ .addr = i2c->addr, .flags = I2C_M_RD, .buf = rb, .len = 2 },
+	};
+	deb_alot("reading from i2c bus (reg: %d)\n",reg);
+
+	if (i2c_transfer(i2c->adapter,msg,2) != 2)
+		deb_alot("i2c read error\n");
+
+	return (rb[0] << 8) | rb[1];
+}
+
+static int dib3000mb_write_reg(struct i2c_client *i2c,u16 reg, u16 val)
+{
+	u8 b[] = { 
+		(reg >> 8) & 0xff, reg & 0xff, 
+		(val >> 8) & 0xff, val & 0xff,
+	};
+	struct i2c_msg msg[] = { { .addr = i2c->addr, .flags = 0, .buf = b, .len = 4 } };
+	deb_alot("writing to i2c bus (reg: %d, val: %d)\n",reg,val);
+
+	return i2c_transfer(i2c->adapter,msg,1) != 1 ? -EREMOTEIO : 0 ;
+}
+
+static int dib3000mb_tuner_thomson_cable_eu(struct dib3000mb_state *state,
+		u32 freq)
+{
+	u32 tfreq = (freq + 36125000) / 62500;
+	unsigned int addr;
+	int vu,p0,p1,p2;
+	
+	if (freq > 403250000)
+		vu = 1, p2 = 1, p1 = 0, p0 = 1;
+	else if (freq > 115750000)
+		vu = 0, p2 = 1, p1 = 1, p0 = 0;
+	else if (freq > 44250000)
+		vu = 0, p2 = 0, p1 = 1, p0 = 1;
+	else 
+		return -EINVAL;
+	/* TODO better solution for i2c->addr handling */
+	addr = state->i2c->addr;
+	state->i2c->addr = DIB3000MB_TUNER_ADDR_DEFAULT;
+	wr(tfreq & 0x7fff,(0x8e << 8) + ((vu << 7) | (p2 << 2) | (p1 << 1) | p0) );
+	state->i2c->addr = addr;
+	
+	return 0;
+}
+
+static int dib3000mb_get_frontend(struct dib3000mb_state *state, 
+		struct dvb_frontend_parameters *fep)
+{
+	struct dvb_ofdm_parameters *ofdm = &fep->u.ofdm;
+	fe_code_rate_t *cr;
+	u16 tps_val;
+	int inv_test1,inv_test2;
+	u32 dds_val, threshold = 0x800000;
+	
+	if (!rd(DIB3000MB_REG_TPS_LOCK)) 
+		return -EINVAL;
+
+	dds_val = ((rd(DIB3000MB_REG_DDS_VALUE_MSB) & 0xff) << 16) + rd(DIB3000MB_REG_DDS_VALUE_LSB);
+	if (dds_val & threshold)
+		inv_test1 = 0;
+	else if (dds_val == threshold) 
+		inv_test1 = 1;
+	else 
+		inv_test1 = 2;
+
+	dds_val = ((rd(DIB3000MB_REG_DDS_FREQ_MSB) & 0xff) << 16) + rd(DIB3000MB_REG_DDS_FREQ_LSB);
+	if (dds_val & threshold)
+		inv_test2 = 0;
+	else if (dds_val == threshold) 
+		inv_test2 = 1;
+	else 
+		inv_test2 = 2;
+	
+	fep->inversion = 
+		((inv_test2 == 2) && (inv_test1==1 || inv_test1==0))
+					||
+		((inv_test2 == 0) && (inv_test1==1 || inv_test1==2));
+
+	deb_info("inversion %d %d, %d\n",inv_test2,inv_test1, fep->inversion);
+	
+	switch ((tps_val = rd(DIB3000MB_REG_TPS_QAM))) {
+		case DIB3000MB_QAM_QPSK:
+			deb_info("QPSK ");
+			ofdm->constellation = QPSK;
+			break;
+		case DIB3000MB_QAM_QAM16:
+			deb_info("QAM16 ");
+			ofdm->constellation = QAM_16;
+			break;
+		case DIB3000MB_QAM_QAM64:
+			deb_info("QAM64 ");
+			ofdm->constellation = QAM_64;
+			break;
+		default:
+			err("Unexpected constellation returned by TPS (%d)",tps_val);
+			break;
+ 	}
+	deb_info("TPS: %d\n",tps_val);
+
+	if (rd(DIB3000MB_REG_TPS_HRCH)) {
+		deb_info("HRCH ON\n");
+		tps_val = rd(DIB3000MB_REG_TPS_CODE_RATE_LP);
+		cr = &ofdm->code_rate_LP;
+		ofdm->code_rate_HP = FEC_NONE;
+		
+		switch ((tps_val = rd(DIB3000MB_REG_TPS_VIT_ALPHA))) {
+			case DIB3000MB_VIT_ALPHA_OFF:
+				deb_info("HIERARCHY_NONE ");
+				ofdm->hierarchy_information = HIERARCHY_NONE;
+				break;
+			case DIB3000MB_VIT_ALPHA_1:
+				deb_info("HIERARCHY_1 ");
+				ofdm->hierarchy_information = HIERARCHY_1;
+				break;
+			case DIB3000MB_VIT_ALPHA_2:
+				deb_info("HIERARCHY_2 ");
+				ofdm->hierarchy_information = HIERARCHY_2;
+				break;
+			case DIB3000MB_VIT_ALPHA_4:
+				deb_info("HIERARCHY_4 ");
+				ofdm->hierarchy_information = HIERARCHY_4;
+				break;
+			default:
+				err("Unexpected ALPHA value returned by TPS (%d)",tps_val);
+		}	
+		deb_info("TPS: %d\n",tps_val);
+	} else {
+		deb_info("HRCH OFF\n");
+		tps_val = rd(DIB3000MB_REG_TPS_CODE_RATE_HP);
+		cr = &ofdm->code_rate_HP;
+		ofdm->code_rate_LP = FEC_NONE;
+		ofdm->hierarchy_information = HIERARCHY_NONE;
+	}
+
+	switch (tps_val) {
+		case DIB3000MB_FEC_1_2:
+			deb_info("FEC_1_2 ");
+			*cr = FEC_1_2;
+			break;
+		case DIB3000MB_FEC_2_3:
+			deb_info("FEC_2_3 ");
+			*cr = FEC_2_3;
+			break;
+		case DIB3000MB_FEC_3_4:
+			deb_info("FEC_3_4 ");
+			*cr = FEC_3_4;
+			break;
+		case DIB3000MB_FEC_5_6:
+			deb_info("FEC_5_6 ");
+			*cr = FEC_4_5;
+			break;
+		case DIB3000MB_FEC_7_8:
+			deb_info("FEC_7_8 ");
+			*cr = FEC_7_8;
+			break;
+		default:
+			err("Unexpected FEC returned by TPS (%d)",tps_val);
+			break;
+	}
+	deb_info("TPS: %d\n",tps_val);
+	
+	switch ((tps_val = rd(DIB3000MB_REG_TPS_GUARD_TIME))) {
+		case DIB3000MB_GUARD_TIME_1_32:
+			deb_info("GUARD_INTERVAL_1_32 ");
+			ofdm->guard_interval = GUARD_INTERVAL_1_32;
+			break;
+		case DIB3000MB_GUARD_TIME_1_16:
+			deb_info("GUARD_INTERVAL_1_16 ");
+			ofdm->guard_interval = GUARD_INTERVAL_1_16;
+			break;
+		case DIB3000MB_GUARD_TIME_1_8:
+			deb_info("GUARD_INTERVAL_1_8 ");
+			ofdm->guard_interval = GUARD_INTERVAL_1_8;
+			break;
+		case DIB3000MB_GUARD_TIME_1_4:
+			deb_info("GUARD_INTERVAL_1_4 ");
+			ofdm->guard_interval = GUARD_INTERVAL_1_4;
+			break;
+		default:
+			err("Unexpected Guard Time returned by TPS (%d)",tps_val);
+			break;
+	}
+	deb_info("TPS: %d\n",tps_val);
+	
+	switch ((tps_val = rd(DIB3000MB_REG_TPS_FFT))) {
+		case DIB3000MB_FFT_2K:
+			deb_info("TRANSMISSION_MODE_2K ");
+			ofdm->transmission_mode = TRANSMISSION_MODE_2K;
+			break;
+		case DIB3000MB_FFT_8K:
+			deb_info("TRANSMISSION_MODE_8K ");
+			ofdm->transmission_mode = TRANSMISSION_MODE_8K;
+			break;
+		default:
+			err("unexpected transmission mode return by TPS (%d)",tps_val);
+	}
+	deb_info("TPS: %d\n",tps_val);
+	return 0;
+}
+
+static int dib3000mb_set_frontend(struct dib3000mb_state *state,
+		struct dvb_frontend_parameters *fep, int tuner);
+
+static int dib3000mb_fe_read_search_status(struct dib3000mb_state *state) 
+{
+	u16 irq;
+	struct dvb_frontend_parameters fep;
+	
+	irq = rd(DIB3000MB_REG_AS_IRQ_PENDING);
+
+	if (irq & 0x02) {
+		if (rd(DIB3000MB_REG_LOCK2_VALUE) & 0x01) {
+			if (dib3000mb_get_frontend(state,&fep) == 0) {
+				deb_info("reading tuning data from frontend succeeded.\n");
+				return dib3000mb_set_frontend(state,&fep,0) == 0;
+			} else {
+				deb_info("reading tuning data failed -> tuning failed.\n");
+				return 0;
+			}
+		} else {
+			deb_info("AS IRQ was pending, but LOCK2 was not & 0x01.\n");
+			return 0;
+		}
+	} else if (irq & 0x01) {
+		deb_info("Autosearch failed.\n");
+		return 0;
+	}
+
+	return -1;
+}
+
+static int dib3000mb_set_frontend(struct dib3000mb_state *state,
+		struct dvb_frontend_parameters *fep, int tuner)
+{
+	struct dvb_ofdm_parameters *ofdm = &fep->u.ofdm;
+	fe_code_rate_t fe_cr;
+	int search_state,seq;
+	
+	if (tuner) {
+		wr(DIB3000MB_REG_TUNER,
+				DIB3000MB_ACTIVATE_TUNER_XFER( DIB3000MB_TUNER_ADDR_DEFAULT ) );
+		dib3000mb_tuner_thomson_cable_eu(state,fep->frequency);
+		
+		/* wait for tuner */
+		msleep(1);
+		wr(DIB3000MB_REG_TUNER, 
+				DIB3000MB_DEACTIVATE_TUNER_XFER( DIB3000MB_TUNER_ADDR_DEFAULT ) );
+
+		switch (ofdm->bandwidth) {
+			case BANDWIDTH_8_MHZ:
+			case BANDWIDTH_AUTO:
+				wr_foreach(dib3000mb_reg_timing_freq,dib3000mb_timing_freq[2]);
+				wr_foreach(dib3000mb_reg_bandwidth,dib3000mb_bandwidth_8mhz);
+				break;
+			case BANDWIDTH_7_MHZ:
+				wr_foreach(dib3000mb_reg_timing_freq,dib3000mb_timing_freq[1]);
+				wr_foreach(dib3000mb_reg_bandwidth,dib3000mb_bandwidth_7mhz);
+				break;
+			case BANDWIDTH_6_MHZ:
+				wr_foreach(dib3000mb_reg_timing_freq,dib3000mb_timing_freq[0]);
+				wr_foreach(dib3000mb_reg_bandwidth,dib3000mb_bandwidth_6mhz);
+				break;
+			default:
+				err("unkown bandwidth value.");
+				return -EINVAL;
+				break;
+		}
+	}	
+	wr(DIB3000MB_REG_LOCK1_MASK,DIB3000MB_LOCK1_SEARCH_4);
+
+	switch (ofdm->transmission_mode) {
+		case TRANSMISSION_MODE_2K:
+			wr(DIB3000MB_REG_FFT,DIB3000MB_FFT_2K);
+			break;
+		case TRANSMISSION_MODE_8K:
+			wr(DIB3000MB_REG_FFT,DIB3000MB_FFT_8K);
+			break;
+		case TRANSMISSION_MODE_AUTO:
+			wr(DIB3000MB_REG_FFT,DIB3000MB_FFT_AUTO);
+			break;
+		default:
+			return -EINVAL;
+	}
+	
+	switch (ofdm->guard_interval) {
+		case GUARD_INTERVAL_1_32:
+			wr(DIB3000MB_REG_GUARD_TIME,DIB3000MB_GUARD_TIME_1_32);
+			break;
+		case GUARD_INTERVAL_1_16:
+			wr(DIB3000MB_REG_GUARD_TIME,DIB3000MB_GUARD_TIME_1_16);
+			break;
+		case GUARD_INTERVAL_1_8:
+			wr(DIB3000MB_REG_GUARD_TIME,DIB3000MB_GUARD_TIME_1_8);
+			break;
+		case GUARD_INTERVAL_1_4:
+			wr(DIB3000MB_REG_GUARD_TIME,DIB3000MB_GUARD_TIME_1_4);
+			break;
+		case GUARD_INTERVAL_AUTO:
+			wr(DIB3000MB_REG_GUARD_TIME,DIB3000MB_GUARD_TIME_AUTO);
+			break;
+		default:
+			return -EINVAL;
+	}
+
+	switch (fep->inversion) {
+		case INVERSION_OFF:
+			wr(DIB3000MB_REG_DDS_INV,DIB3000MB_DDS_INV_OFF);
+			break;
+		case INVERSION_AUTO:
+		case INVERSION_ON:
+			wr(DIB3000MB_REG_DDS_INV,DIB3000MB_DDS_INV_ON);
+			break;
+		default:
+			return -EINVAL;
+	}
+	
+	switch (ofdm->constellation) {
+		case QPSK:
+			wr(DIB3000MB_REG_QAM,DIB3000MB_QAM_QPSK);
+			break;
+		case QAM_16:
+			wr(DIB3000MB_REG_QAM,DIB3000MB_QAM_QAM16);
+			break;
+		case QAM_64:
+			wr(DIB3000MB_REG_QAM,DIB3000MB_QAM_QAM64);
+			break;
+		case QAM_AUTO:
+			break;
+		default:
+			return -EINVAL;
+	}
+	
+	switch (ofdm->hierarchy_information) {
+		case HIERARCHY_NONE:
+		case HIERARCHY_1:
+			wr(DIB3000MB_REG_VIT_ALPHA,DIB3000MB_VIT_ALPHA_1);
+			break;
+		case HIERARCHY_2:
+			wr(DIB3000MB_REG_VIT_ALPHA,DIB3000MB_VIT_ALPHA_2);
+			break;
+		case HIERARCHY_4:
+			wr(DIB3000MB_REG_VIT_ALPHA,DIB3000MB_VIT_ALPHA_4);
+			break; 
+		case HIERARCHY_AUTO:
+			wr(DIB3000MB_REG_VIT_ALPHA,DIB3000MB_VIT_ALPHA_AUTO);
+			break;
+		default:
+			return -EINVAL;
+	}
+	
+	if (ofdm->hierarchy_information == HIERARCHY_NONE) {
+		wr(DIB3000MB_REG_VIT_HRCH,DIB3000MB_VIT_HRCH_OFF);
+		wr(DIB3000MB_REG_VIT_HP,DIB3000MB_VIT_HP);
+		fe_cr = ofdm->code_rate_HP;
+	} else {
+		wr(DIB3000MB_REG_VIT_HRCH,DIB3000MB_VIT_HRCH_ON);
+		wr(DIB3000MB_REG_VIT_HP,DIB3000MB_VIT_LP);
+		fe_cr = ofdm->code_rate_LP;
+	}
+			
+	switch (fe_cr) {
+		case FEC_1_2:
+			wr(DIB3000MB_REG_VIT_CODE_RATE,DIB3000MB_FEC_1_2);
+			break;
+		case FEC_2_3:
+			wr(DIB3000MB_REG_VIT_CODE_RATE,DIB3000MB_FEC_2_3);
+			break;
+		case FEC_3_4:
+			wr(DIB3000MB_REG_VIT_CODE_RATE,DIB3000MB_FEC_3_4);
+			break;
+		case FEC_5_6:
+			wr(DIB3000MB_REG_VIT_CODE_RATE,DIB3000MB_FEC_5_6);
+			break;
+		case FEC_7_8:
+			wr(DIB3000MB_REG_VIT_CODE_RATE,DIB3000MB_FEC_7_8);
+			break;
+		case FEC_NONE:
+		case FEC_AUTO:
+			break;
+		default:
+			return -EINVAL;
+	}	
+	
+	seq = dib3000mb_seq
+		[ofdm->transmission_mode == TRANSMISSION_MODE_AUTO]
+		[ofdm->guard_interval == GUARD_INTERVAL_AUTO]
+		[fep->inversion == INVERSION_AUTO];
+
+	deb_info("seq? %d\n",seq);
+	
+	wr(DIB3000MB_REG_SEQ,seq);
+	
+	wr(DIB3000MB_REG_ISI,seq ? DIB3000MB_ISI_INHIBIT : DIB3000MB_ISI_ACTIVATE);
+
+	if (ofdm->transmission_mode == TRANSMISSION_MODE_2K) {
+		if (ofdm->guard_interval == GUARD_INTERVAL_1_8) {
+			wr(DIB3000MB_REG_SYNC_IMPROVEMENT,DIB3000MB_SYNC_IMPROVE_2K_1_8);
+		} else {
+			wr(DIB3000MB_REG_SYNC_IMPROVEMENT,DIB3000MB_SYNC_IMPROVE_DEFAULT);
+		}
+		
+		wr(DIB3000MB_REG_UNK_121,DIB3000MB_UNK_121_2K);
+	} else {
+		wr(DIB3000MB_REG_UNK_121,DIB3000MB_UNK_121_DEFAULT);
+	}
+
+	wr(DIB3000MB_REG_MOBILE_ALGO,DIB3000MB_MOBILE_ALGO_OFF);
+	wr(DIB3000MB_REG_MOBILE_MODE_QAM,DIB3000MB_MOBILE_MODE_QAM_OFF);
+	wr(DIB3000MB_REG_MOBILE_MODE,DIB3000MB_MOBILE_MODE_OFF);
+		
+	wr_foreach(dib3000mb_reg_agc_bandwidth,dib3000mb_agc_bandwidth_high);
+	
+	wr(DIB3000MB_REG_ISI,DIB3000MB_ISI_ACTIVATE);
+
+	wr(DIB3000MB_REG_RESTART,DIB3000MB_RESTART_AGC+DIB3000MB_RESTART_CTRL);
+	wr(DIB3000MB_REG_RESTART,DIB3000MB_RESTART_OFF);
+	
+	/* wait for AGC lock */
+	msleep(70);
+
+	wr_foreach(dib3000mb_reg_agc_bandwidth,dib3000mb_agc_bandwidth_low);
+	
+	/* something has to be auto searched */ 
+	if (ofdm->constellation == QAM_AUTO ||
+		ofdm->hierarchy_information == HIERARCHY_AUTO ||
+		fe_cr == FEC_AUTO || 
+		fep->inversion == INVERSION_AUTO) {
+		
+		deb_info("autosearch enabled.\n");	
+		
+		wr(DIB3000MB_REG_ISI,DIB3000MB_ISI_INHIBIT);
+		
+		wr(DIB3000MB_REG_RESTART,DIB3000MB_RESTART_AUTO_SEARCH);
+		wr(DIB3000MB_REG_RESTART,DIB3000MB_RESTART_OFF);
+		
+		while ((search_state = dib3000mb_fe_read_search_status(state)) < 0);
+		
+		return search_state ? 0 : -EINVAL;
+	} else {
+		wr(DIB3000MB_REG_RESTART,DIB3000MB_RESTART_CTRL);
+		wr(DIB3000MB_REG_RESTART,DIB3000MB_RESTART_OFF);
+		msleep(70);
+	}
+	return 0;
+}
+
+
+static int dib3000mb_fe_init(struct dib3000mb_state *state,int mobile_mode)
+{
+	wr(DIB3000MB_REG_POWER_CONTROL,DIB3000MB_POWER_UP);
+	
+	wr(DIB3000MB_REG_RESTART, DIB3000MB_RESTART_AGC);
+	
+	wr(DIB3000MB_REG_RESET_DEVICE,DIB3000MB_RESET_DEVICE);
+	wr(DIB3000MB_REG_RESET_DEVICE,DIB3000MB_RESET_DEVICE_RST);
+	
+	wr(DIB3000MB_REG_CLOCK,DIB3000MB_CLOCK_DEFAULT);
+	
+	wr(DIB3000MB_REG_ELECT_OUT_MODE,DIB3000MB_ELECT_OUT_MODE_ON);
+
+	wr(DIB3000MB_REG_QAM,DIB3000MB_QAM_RESERVED);
+	wr(DIB3000MB_REG_VIT_ALPHA,DIB3000MB_VIT_ALPHA_AUTO);
+	
+	wr(DIB3000MB_REG_DDS_FREQ_MSB,DIB3000MB_DDS_FREQ_MSB);
+	wr(DIB3000MB_REG_DDS_FREQ_LSB,DIB3000MB_DDS_FREQ_LSB);
+
+	wr_foreach(dib3000mb_reg_timing_freq,dib3000mb_timing_freq[2]);
+
+	wr_foreach(dib3000mb_reg_impulse_noise,
+			dib3000mb_impulse_noise_values[DIB3000MB_IMPNOISE_OFF]);
+	
+	wr_foreach(dib3000mb_reg_agc_gain,dib3000mb_default_agc_gain);
+
+	wr(DIB3000MB_REG_PHASE_NOISE,DIB3000MB_PHASE_NOISE_DEFAULT);
+
+	wr_foreach(dib3000mb_reg_phase_noise, dib3000mb_default_noise_phase);
+	
+	wr_foreach(dib3000mb_reg_lock_duration,dib3000mb_default_lock_duration);
+
+	wr_foreach(dib3000mb_reg_agc_bandwidth,dib3000mb_agc_bandwidth_low);
+
+	wr(DIB3000MB_REG_LOCK0_MASK,DIB3000MB_LOCK0_DEFAULT);
+	wr(DIB3000MB_REG_LOCK1_MASK,DIB3000MB_LOCK1_SEARCH_4);
+	wr(DIB3000MB_REG_LOCK2_MASK,DIB3000MB_LOCK2_DEFAULT);
+	wr(DIB3000MB_REG_SEQ,dib3000mb_seq[1][1][1]);
+		
+	wr_foreach(dib3000mb_reg_bandwidth,dib3000mb_bandwidth_8mhz);
+	
+	wr(DIB3000MB_REG_UNK_68,DIB3000MB_UNK_68);
+	wr(DIB3000MB_REG_UNK_69,DIB3000MB_UNK_69);
+	wr(DIB3000MB_REG_UNK_71,DIB3000MB_UNK_71);
+	wr(DIB3000MB_REG_UNK_77,DIB3000MB_UNK_77);
+	wr(DIB3000MB_REG_UNK_78,DIB3000MB_UNK_78);
+	wr(DIB3000MB_REG_ISI,DIB3000MB_ISI_INHIBIT);
+	wr(DIB3000MB_REG_UNK_92,DIB3000MB_UNK_92);
+	wr(DIB3000MB_REG_UNK_96,DIB3000MB_UNK_96);
+	wr(DIB3000MB_REG_UNK_97,DIB3000MB_UNK_97);
+	wr(DIB3000MB_REG_UNK_106,DIB3000MB_UNK_106);
+	wr(DIB3000MB_REG_UNK_107,DIB3000MB_UNK_107);
+	wr(DIB3000MB_REG_UNK_108,DIB3000MB_UNK_108);
+	wr(DIB3000MB_REG_UNK_122,DIB3000MB_UNK_122);
+	wr(DIB3000MB_REG_MOBILE_MODE_QAM,DIB3000MB_MOBILE_MODE_QAM_OFF);
+	wr(DIB3000MB_REG_VIT_CODE_RATE,DIB3000MB_FEC_1_2);
+	wr(DIB3000MB_REG_VIT_HP,DIB3000MB_VIT_HP);
+	wr(DIB3000MB_REG_BERLEN,DIB3000MB_BERLEN_DEFAULT);
+
+	wr_foreach(dib3000mb_reg_filter_coeffs,dib3000mb_filter_coeffs);
+
+	wr(DIB3000MB_REG_MOBILE_ALGO,DIB3000MB_MOBILE_ALGO_ON);
+	wr(DIB3000MB_REG_MULTI_DEMOD_MSB,DIB3000MB_MULTI_DEMOD_MSB);
+	wr(DIB3000MB_REG_MULTI_DEMOD_LSB,DIB3000MB_MULTI_DEMOD_LSB);
+
+	wr(DIB3000MB_REG_OUTPUT_MODE,DIB3000MB_OUTPUT_MODE_SLAVE);
+
+	wr(DIB3000MB_REG_FIFO_142,DIB3000MB_FIFO_142);
+	wr(DIB3000MB_REG_MPEG2_OUT_MODE,DIB3000MB_MPEG2_OUT_MODE_188);
+	wr(DIB3000MB_REG_FIFO_144,DIB3000MB_FIFO_144);
+	wr(DIB3000MB_REG_FIFO,DIB3000MB_FIFO_INHIBIT);
+	wr(DIB3000MB_REG_FIFO_146,DIB3000MB_FIFO_146);
+	wr(DIB3000MB_REG_FIFO_147,DIB3000MB_FIFO_147);
+	
+	wr(DIB3000MB_REG_DATA_IN_DIVERSITY,DIB3000MB_DATA_DIVERSITY_IN_OFF);	
+	return 0;
+}
+
+static int dib3000mb_read_status(struct dib3000mb_state *state,fe_status_t *stat)
+{
+	*stat = 0;
+	*stat |= rd(DIB3000MB_REG_AGC_LOCK) ? FE_HAS_SIGNAL : 0;
+	*stat |= rd(DIB3000MB_REG_CARRIER_LOCK) ? FE_HAS_CARRIER : 0;
+	*stat |= rd(DIB3000MB_REG_VIT_LCK) ? FE_HAS_VITERBI : 0;
+	*stat |= rd(DIB3000MB_REG_TS_SYNC_LOCK) ? FE_HAS_SYNC : 0;
+	*stat |= *stat ? FE_HAS_LOCK : 0;
+
+	deb_info("actual status is %2x\n",*stat);
+	
+	deb_info("autoval: tps: %d, qam: %d, hrch: %d, alpha: %d, hp: %d, lp: %d, guard: %d, fft: %d cell: %d\n",
+			rd(DIB3000MB_REG_TPS_LOCK),
+			rd(DIB3000MB_REG_TPS_QAM), 
+			rd(DIB3000MB_REG_TPS_HRCH),
+			rd(DIB3000MB_REG_TPS_VIT_ALPHA),
+			rd(DIB3000MB_REG_TPS_CODE_RATE_HP),
+			rd(DIB3000MB_REG_TPS_CODE_RATE_LP), 
+			rd(DIB3000MB_REG_TPS_GUARD_TIME),
+			rd(DIB3000MB_REG_TPS_FFT),
+			rd(DIB3000MB_REG_TPS_CELL_ID));
+
+	//*stat = FE_HAS_SIGNAL | FE_HAS_CARRIER | FE_HAS_VITERBI | FE_HAS_SYNC | FE_HAS_LOCK;
+	return 0;
+}
+
+static int dib3000mb_read_ber(struct dib3000mb_state *state,u32 *ber)
+{
+	*ber = 
+		(((rd(DIB3000MB_REG_BER_MSB) << 16) & 0x1f) | rd(DIB3000MB_REG_BER_LSB) ) /
+		 100000000;
+	return 0;
+}
+
+static int dib3000mb_signal_strength(struct dib3000mb_state *state, u16 *strength)
+{
+//	*stength = DIB3000MB_REG_SIGNAL_POWER 
+	return 0;
+}
+
+static int dib3000mb_sleep(struct dib3000mb_state *state)
+{
+	wr(DIB3000MB_REG_POWER_CONTROL,DIB3000MB_POWER_DOWN);
+	return 0;
+}
+
+static int dib3000mb_ioctl (struct dvb_frontend *fe, unsigned int cmd, void *arg)
+{
+	struct dib3000mb_state *state = fe->data;
+	int ret = 0;		
+	switch (cmd) {
+		case FE_GET_INFO:
+			deb_info("FE_GET_INFO\n");
+			memcpy(arg, &dib3000mb_info, sizeof(struct dvb_frontend_info));
+			break;
+
+		case FE_READ_STATUS: 
+			deb_info("FE_READ_STATUS\n");
+			ret = dib3000mb_read_status(state,(fe_status_t *)arg);
+			break;
+
+		case FE_READ_BER:
+			deb_info("FE_READ_BER\n");
+			ret = dib3000mb_read_ber(state,(u32 *)arg);
+			break;
+
+		case FE_READ_SIGNAL_STRENGTH:
+			deb_info("FE_READ_SIG_STRENGTH\n");
+			ret = dib3000mb_signal_strength(state,(u16 *) arg);
+			break;
+
+		case FE_READ_SNR:
+			deb_info("FE_READ_SNR\n");
+			break;
+
+		case FE_READ_UNCORRECTED_BLOCKS: 
+			deb_info("FE_READ_UNCORRECTED_BLOCKS\n");
+			break;
+
+		case FE_SET_FRONTEND:
+			deb_info("FE_SET_FRONTEND\n");
+			ret = dib3000mb_set_frontend(state,(struct dvb_frontend_parameters *) arg,1);
+			break;
+
+		case FE_GET_FRONTEND:
+			deb_info("FE_GET_FRONTEND\n");
+			ret = dib3000mb_get_frontend(state,(struct dvb_frontend_parameters *) arg);
+			break;
+
+		case FE_SLEEP:
+			deb_info("FE_SLEEP\n");
+			ret = dib3000mb_sleep(state);
+			break;
+
+		case FE_INIT:
+			deb_info("FE_INIT\n");
+			ret = dib3000mb_fe_init(state,0);
+			break;
+
+		case FE_SET_TONE:
+		case FE_SET_VOLTAGE:
+		default:
+			ret = -EOPNOTSUPP;
+			break;
+	}
+	return 0;
+} 
+
+static struct i2c_client client_template;
+
+static int dib3000mb_attach_adapter(struct i2c_adapter *adapter)
+{
+	struct i2c_client *client;
+	struct dib3000mb_state *state;
+	int ret = -ENOMEM;
+
+	deb_info("i2c probe with adapter '%s'.\n",adapter->name);
+	
+	if ((state = kmalloc(sizeof(struct dib3000mb_state),GFP_KERNEL)) == NULL)
+		return -ENOMEM;
+	
+
+	if ((client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL)) == NULL)
+		goto i2c_kmalloc_err;
+
+	memcpy(client, &client_template, sizeof(struct i2c_client));
+
+	client->adapter = adapter;
+	client->addr = 0x10; 
+	state->i2c = client;
+	
+	i2c_set_clientdata(client,state);
+
+	state->manufactor_id = dib3000mb_read_reg(client, DIB3000MB_REG_MANUFACTOR_ID);
+	state->device_id = dib3000mb_read_reg(client,DIB3000MB_REG_DEVICE_ID);
+	if (state->manufactor_id == 0x01b3 && state->device_id == 0x3000) 
+		info("found a DiBCom (0x%04x) 3000-MB DVB-T frontend (ver: %x).",
+				state->manufactor_id, state->device_id);
+	else {
+		err("did not found a DiBCom 3000-MB.");
+		ret = -ENODEV;
+		goto probe_err;
+	}
+	
+	if ((ret = i2c_attach_client(client))) 
+		goto i2c_attach_err;
+
+	if (state->dvb == NULL) 
+		goto i2c_attach_err;
+
+	if ((ret = dvb_register_frontend(dib3000mb_ioctl, state->dvb, state,
+					     &dib3000mb_info, THIS_MODULE)))
+		goto dvb_fe_err;
+	
+	
+	goto success;
+dvb_fe_err:
+	i2c_detach_client(client);
+i2c_attach_err:
+probe_err:
+	kfree(client);
+i2c_kmalloc_err:
+	kfree(state);
+	return ret;
+success:
+	return 0;
+}
+
+
+static int dib3000mb_detach_client(struct i2c_client *client)
+{
+	struct dib3000mb_state *state = i2c_get_clientdata(client);
+
+	deb_info("i2c detach\n");
+
+	dvb_unregister_frontend(dib3000mb_ioctl, state->dvb);
+	i2c_detach_client(client);
+	kfree(client);
+	kfree(state);
+
+	return 0;
+}
+
+static int dib3000mb_command(struct i2c_client *client,
+			      unsigned int cmd, void *arg)
+{
+	struct dib3000mb_state *state = i2c_get_clientdata(client);
+	deb_info("i2c command.\n");
+	switch(cmd) {
+		case FE_REGISTER:
+			state->dvb = arg;
+			break;
+		case FE_UNREGISTER:
+			state->dvb = NULL;
+			break;
+		default:
+			return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static struct i2c_driver driver = {
+	.owner		= THIS_MODULE,
+	.name		= "dib3000mb",
+	.id			= I2C_DRIVERID_DVBFE_DIB3000MB,
+	.flags		= I2C_DF_NOTIFY,
+	.attach_adapter	= dib3000mb_attach_adapter,
+	.detach_client	= dib3000mb_detach_client,
+	.command	= dib3000mb_command,
+};
+
+static struct i2c_client client_template = {
+	.name		= "dib3000mb",
+	.flags		= I2C_CLIENT_ALLOW_USE,
+	.driver		= &driver,
+};
+
+/* module stuff */
+static int __init dib3000mb_init(void)
+{
+	deb_info("debugging level: %d\n",debug);
+	return i2c_add_driver(&driver);
+}
+
+static void __exit dib3000mb_exit(void)
+{
+	i2c_del_driver(&driver);
+}
+
+module_init (dib3000mb_init);
+module_exit (dib3000mb_exit);
+
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");
diff -uraNwB linux-2.6.8.1-dvb1/drivers/media/dvb/frontends/dib3000mb.h linux-2.6.8.1-patched/drivers/media/dvb/frontends/dib3000mb.h
--- linux-2.6.8.1-dvb1/drivers/media/dvb/frontends/dib3000mb.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.8.1-patched/drivers/media/dvb/frontends/dib3000mb.h	2004-09-13 09:37:20.000000000 +0200
@@ -0,0 +1,657 @@
+/*
+ * dib3000mb.h
+ * 
+ * Copyright (C) 2004 Patrick Boettcher (patrick.boettcher@desy.de)
+ * 
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License as
+ *	published by the Free Software Foundation, version 2.
+ *
+ * 
+ * for more information see dib3000mb.c .
+ */
+
+#ifndef __DIB3000MB_H_INCLUDED__
+#define __DIB3000MB_H_INCLUDED__
+
+/* info and err, taken from usb.h, if there is anything available like by default,
+ * please change !
+ */
+#define err(format, arg...) printk(KERN_ERR "%s: " format "\n" , __FILE__ , ## arg)
+#define info(format, arg...) printk(KERN_INFO "%s: " format "\n" , __FILE__ , ## arg)
+#define warn(format, arg...) printk(KERN_WARNING "%s: " format "\n" , __FILE__ , ## arg)
+
+/* register addresses and some of their default values */
+
+/* restart subsystems */
+#define DIB3000MB_REG_RESTART			(     0)
+
+#define DIB3000MB_RESTART_OFF			(     0)
+#define DIB3000MB_RESTART_AUTO_SEARCH		(1 << 1)
+#define DIB3000MB_RESTART_CTRL				(1 << 2)
+#define DIB3000MB_RESTART_AGC				(1 << 3)
+
+/* FFT size */
+#define DIB3000MB_REG_FFT				(     1)
+#define DIB3000MB_FFT_2K					(     0)
+#define DIB3000MB_FFT_8K					(     1)
+#define DIB3000MB_FFT_AUTO					(     1)
+
+/* Guard time */
+#define DIB3000MB_REG_GUARD_TIME		(     2)
+#define DIB3000MB_GUARD_TIME_1_32			(     0)
+#define DIB3000MB_GUARD_TIME_1_16			(     1)
+#define DIB3000MB_GUARD_TIME_1_8			(     2)
+#define DIB3000MB_GUARD_TIME_1_4			(     3)
+#define DIB3000MB_GUARD_TIME_AUTO			(     0)
+
+/* QAM */
+#define DIB3000MB_REG_QAM				(     3)
+#define DIB3000MB_QAM_QPSK					(     0)
+#define DIB3000MB_QAM_QAM16					(     1)
+#define DIB3000MB_QAM_QAM64					(     2)
+#define DIB3000MB_QAM_RESERVED				(     3)
+
+/* Alpha coefficient high priority Viterbi algorithm */
+#define DIB3000MB_REG_VIT_ALPHA			(     4)
+#define DIB3000MB_VIT_ALPHA_OFF				(     0)
+#define DIB3000MB_VIT_ALPHA_1				(     1)
+#define DIB3000MB_VIT_ALPHA_2				(     2)
+#define DIB3000MB_VIT_ALPHA_4				(     4)
+#define DIB3000MB_VIT_ALPHA_AUTO			(     7)
+
+/* spectrum inversion */
+#define DIB3000MB_REG_DDS_INV			(     5)
+#define DIB3000MB_DDS_INV_OFF				(     0)
+#define DIB3000MB_DDS_INV_ON				(     1)
+
+/* DDS frequency value (IF position) ad ? values don't match reg_3000mb.txt */ 
+#define DIB3000MB_REG_DDS_FREQ_MSB		(     6)
+#define DIB3000MB_REG_DDS_FREQ_LSB		(     7)
+#define DIB3000MB_DDS_FREQ_MSB				(   178)
+#define DIB3000MB_DDS_FREQ_LSB				(  8990)
+
+/* timing frequency (carrier spacing) */
+#define DIB3000MB_REG_TIMING_FREQ_MSB	(     8)
+#define DIB3000MB_REG_TIMING_FREQ_LSB	(     9)
+
+static u16 dib3000mb_reg_timing_freq[] = {
+	DIB3000MB_REG_TIMING_FREQ_MSB, DIB3000MB_REG_TIMING_FREQ_LSB 
+};
+static u16 dib3000mb_timing_freq[][2] = {
+	{ 126 , 48873 }, /* 6 MHz */
+	{ 147 , 57019 }, /* 7 MHz */ 
+	{ 168 , 65164 }, /* 8 MHz */
+};
+
+/* impulse noise parameter */
+#define DIB3000MB_REG_IMPNOISE_10		(    10)
+#define DIB3000MB_REG_IMPNOISE_11		(    11)
+#define DIB3000MB_REG_IMPNOISE_12		(    12)
+#define DIB3000MB_REG_IMPNOISE_13		(    13)
+#define DIB3000MB_REG_IMPNOISE_14		(    14)
+#define DIB3000MB_REG_IMPNOISE_15		(    15)
+/* 36 ??? */
+#define DIB3000MB_REG_IMPNOISE_36		(    36)
+
+enum dib3000mb_impulse_noise_type {
+	DIB3000MB_IMPNOISE_OFF,
+	DIB3000MB_IMPNOISE_MOBILE,
+	DIB3000MB_IMPNOISE_FIXED,
+	DIB3000MB_IMPNOISE_DEFAULT
+};
+
+static u16 dib3000mb_reg_impulse_noise[] = {
+ DIB3000MB_REG_IMPNOISE_10, DIB3000MB_REG_IMPNOISE_11, 
+ DIB3000MB_REG_IMPNOISE_12, DIB3000MB_REG_IMPNOISE_15,
+ DIB3000MB_REG_IMPNOISE_36
+};
+
+static u16 dib3000mb_impulse_noise_values[][5] = {
+	{ 0x0000, 0x0004, 0x0014, 0x01ff, 0x0399 }, /* off */
+	{ 0x0001, 0x0004, 0x0014, 0x01ff, 0x037b }, /* mobile */
+	{ 0x0001, 0x0004, 0x0020, 0x01bd, 0x0399 }, /* fixed */
+	{ 0x0000, 0x0002, 0x000a, 0x01ff, 0x0399 }, /* default */
+};
+
+/* 
+ * Dual Automatic-Gain-Control 
+ * - gains RF in tuner (AGC1) 
+ * - gains IF after filtering (AGC2)
+ */
+
+/* also from 16 to 18 */
+#define DIB3000MB_REG_AGC_GAIN_19		(    19)
+#define DIB3000MB_REG_AGC_GAIN_20		(    20)
+#define DIB3000MB_REG_AGC_GAIN_21		(    21)
+#define DIB3000MB_REG_AGC_GAIN_22		(    22)
+#define DIB3000MB_REG_AGC_GAIN_23		(    23)
+#define DIB3000MB_REG_AGC_GAIN_24		(    24)
+#define DIB3000MB_REG_AGC_GAIN_25		(    25)
+#define DIB3000MB_REG_AGC_GAIN_26		(    26)
+#define DIB3000MB_REG_AGC_GAIN_27		(    27)
+#define DIB3000MB_REG_AGC_GAIN_28		(    28)
+#define DIB3000MB_REG_AGC_GAIN_29		(    29)
+#define DIB3000MB_REG_AGC_GAIN_30		(    30)
+#define DIB3000MB_REG_AGC_GAIN_31		(    31)
+#define DIB3000MB_REG_AGC_GAIN_32		(    32)
+
+static u16 dib3000mb_reg_agc_gain[] = {
+  DIB3000MB_REG_AGC_GAIN_19, DIB3000MB_REG_AGC_GAIN_20, DIB3000MB_REG_AGC_GAIN_21,
+  DIB3000MB_REG_AGC_GAIN_22, DIB3000MB_REG_AGC_GAIN_23, DIB3000MB_REG_AGC_GAIN_24,
+  DIB3000MB_REG_AGC_GAIN_25, DIB3000MB_REG_AGC_GAIN_26, DIB3000MB_REG_AGC_GAIN_27,
+  DIB3000MB_REG_AGC_GAIN_28, DIB3000MB_REG_AGC_GAIN_29, DIB3000MB_REG_AGC_GAIN_30,
+  DIB3000MB_REG_AGC_GAIN_31, DIB3000MB_REG_AGC_GAIN_32 };
+  
+static u16 dib3000mb_default_agc_gain[] =
+	{ 0x0001, 52429,   623, 128, 166, 195, 61,   /* RF ??? */
+	  0x0001, 53766, 38011,   0,  90,  33, 23 }; /* IF ??? */
+
+/* phase noise */
+#define DIB3000MB_REG_PHASE_NOISE_33		(    33)
+#define DIB3000MB_REG_PHASE_NOISE_34		(    34)
+#define DIB3000MB_REG_PHASE_NOISE_35		(    35)
+#define DIB3000MB_REG_PHASE_NOISE_36		(    36)
+#define DIB3000MB_REG_PHASE_NOISE_37		(    37)
+#define DIB3000MB_REG_PHASE_NOISE_38		(    38)
+
+/* DIB3000MB_REG_PHASE_NOISE_36 is set when setting the impulse noise */
+static u16 dib3000mb_reg_phase_noise[] = {
+	DIB3000MB_REG_PHASE_NOISE_33, DIB3000MB_REG_PHASE_NOISE_34, DIB3000MB_REG_PHASE_NOISE_35,
+	DIB3000MB_REG_PHASE_NOISE_37, DIB3000MB_REG_PHASE_NOISE_38
+};
+
+static u16 dib3000mb_default_noise_phase[] = { 2, 544, 0, 5, 4 };
+
+/* lock duration */
+#define DIB3000MB_REG_LOCK_DURATION_39	(    39)
+#define DIB3000MB_REG_LOCK_DURATION_40	(    40)
+
+static u16 dib3000mb_reg_lock_duration[] = {
+	DIB3000MB_REG_LOCK_DURATION_39, DIB3000MB_REG_LOCK_DURATION_40
+};
+
+static u16 dib3000mb_default_lock_duration[] = { 135, 135 };
+
+/* AGC loop bandwidth */
+
+#define DIB3000MB_REG_AGC_BW_43			(    43)
+#define DIB3000MB_REG_AGC_BW_44			(    44)
+#define DIB3000MB_REG_AGC_BW_45			(    45)
+#define DIB3000MB_REG_AGC_BW_46			(    46)
+#define DIB3000MB_REG_AGC_BW_47			(    47)
+#define DIB3000MB_REG_AGC_BW_48			(    48)
+#define DIB3000MB_REG_AGC_BW_49			(    49)
+#define DIB3000MB_REG_AGC_BW_50			(    50)
+
+static u16 dib3000mb_reg_agc_bandwidth[] = {
+	DIB3000MB_REG_AGC_BW_43, DIB3000MB_REG_AGC_BW_44, DIB3000MB_REG_AGC_BW_45, 
+	DIB3000MB_REG_AGC_BW_46, DIB3000MB_REG_AGC_BW_47, DIB3000MB_REG_AGC_BW_48,
+	DIB3000MB_REG_AGC_BW_49, DIB3000MB_REG_AGC_BW_50
+};
+
+static u16 dib3000mb_agc_bandwidth_low[]  = 
+	{ 2088, 10, 2088, 10, 3448, 5, 3448, 5 };
+static u16 dib3000mb_agc_bandwidth_high[] = 
+	{ 2349,  5, 2349,  5, 2586, 2, 2586, 2 };
+
+/* 
+ * lock0 definition (coff_lock) 
+ */
+#define DIB3000MB_REG_LOCK0_MASK		(    51)
+#define DIB3000MB_LOCK0_DEFAULT				(     4)
+
+/*
+ * lock1 definition (cpil_lock)
+ * for auto search 
+ * which values hide behind the lock masks 
+ */
+#define DIB3000MB_REG_LOCK1_MASK		(    52)
+#define DIB3000MB_LOCK1_SEARCH_4			(0x0004)
+#define DIB3000MB_LOCK1_SEARCH_2048			(0x0800)
+#define DIB3000MB_LOCK1_DEFAULT				(0x0001)
+
+/*
+ * lock2 definition (fec_lock) */
+#define DIB3000MB_REG_LOCK2_MASK		(    53)
+#define DIB3000MB_LOCK2_DEFAULT				(0x0080)
+
+/* 
+ * SEQ ? what was that again ... :) 
+ * changes when, inversion, guard time and fft is
+ * either automatically detected or not
+ */
+#define DIB3000MB_REG_SEQ				(    54)
+
+/* all values have been set manually */
+static u16 dib3000mb_seq[2][2][2] = 	/* fft,gua,   inv   */
+	{ /* fft */ 
+		{ /* gua */ 
+			{ 0, 1 },					/*  0   0   { 0,1 } */
+			{ 3, 9 },					/*  0   1   { 0,1 } */
+		},
+		{ 
+			{ 2, 5 },					/*  1   0   { 0,1 } */
+			{ 6, 11 },					/*  1   1   { 0,1 } */
+		}
+	};
+
+/* bandwidth */
+#define DIB3000MB_REG_BW_55				(    55)
+#define DIB3000MB_REG_BW_56				(    56)
+#define DIB3000MB_REG_BW_57				(    57)
+#define DIB3000MB_REG_BW_58				(    58)
+#define DIB3000MB_REG_BW_59				(    59)
+#define DIB3000MB_REG_BW_60				(    60)
+#define DIB3000MB_REG_BW_61				(    61)
+#define DIB3000MB_REG_BW_62				(    62)
+#define DIB3000MB_REG_BW_63				(    63)
+#define DIB3000MB_REG_BW_64				(    64)
+#define DIB3000MB_REG_BW_65				(    65)
+#define DIB3000MB_REG_BW_66				(    66)
+#define DIB3000MB_REG_BW_67				(    67)
+
+static u16 dib3000mb_reg_bandwidth[] = {
+	DIB3000MB_REG_BW_55, DIB3000MB_REG_BW_56, DIB3000MB_REG_BW_57, 
+	DIB3000MB_REG_BW_58, DIB3000MB_REG_BW_59, DIB3000MB_REG_BW_60,
+	DIB3000MB_REG_BW_61, DIB3000MB_REG_BW_62, DIB3000MB_REG_BW_63,
+	DIB3000MB_REG_BW_64, DIB3000MB_REG_BW_65, DIB3000MB_REG_BW_66, 
+	DIB3000MB_REG_BW_67
+};
+
+static u16 dib3000mb_bandwidth_6mhz[] = 
+	{ 0, 33, 53312, 112, 46635, 563, 36565, 0, 1000, 0, 1010, 1, 45264 };
+
+static u16 dib3000mb_bandwidth_7mhz[] =
+	{ 0, 28, 64421,  96, 39973, 483,  3255, 0, 1000, 0, 1010, 1, 45264 };
+
+static u16 dib3000mb_bandwidth_8mhz[] =
+	{ 0, 25, 23600,  84, 34976, 422, 43808, 0, 1000, 0, 1010, 1, 45264 };
+
+#define DIB3000MB_REG_UNK_68				(    68)
+#define DIB3000MB_UNK_68						(     0)
+
+#define DIB3000MB_REG_UNK_69				(    69)
+#define DIB3000MB_UNK_69						(     0)
+
+#define DIB3000MB_REG_UNK_71				(    71)
+#define DIB3000MB_UNK_71						(     0)
+
+#define DIB3000MB_REG_UNK_77				(    77)
+#define DIB3000MB_UNK_77						(     6)
+
+#define DIB3000MB_REG_UNK_78				(    78)
+#define DIB3000MB_UNK_78						(0x0080)
+
+/* isi */
+#define DIB3000MB_REG_ISI				(    79)
+#define DIB3000MB_ISI_ACTIVATE				(     0)
+#define DIB3000MB_ISI_INHIBIT				(     1)
+
+/* sync impovement */
+#define DIB3000MB_REG_SYNC_IMPROVEMENT	(    84)
+#define DIB3000MB_SYNC_IMPROVE_2K_1_8		(     3)
+#define DIB3000MB_SYNC_IMPROVE_DEFAULT		(     0)
+
+/* phase noise compensation inhibition */
+#define DIB3000MB_REG_PHASE_NOISE		(    87)
+#define DIB3000MB_PHASE_NOISE_DEFAULT	(     0)
+
+#define DIB3000MB_REG_UNK_92				(    92)
+#define DIB3000MB_UNK_92						(0x0080)
+
+#define DIB3000MB_REG_UNK_96				(    96)
+#define DIB3000MB_UNK_96						(0x0010)
+
+#define DIB3000MB_REG_UNK_97				(    97)
+#define DIB3000MB_UNK_97						(0x0009)
+
+/* mobile mode ??? */
+#define DIB3000MB_REG_MOBILE_MODE		(   101)
+#define DIB3000MB_MOBILE_MODE_ON				(     1)
+#define DIB3000MB_MOBILE_MODE_OFF			(     0)
+
+#define DIB3000MB_REG_UNK_106			(   106)
+#define DIB3000MB_UNK_106					(0x0080)
+
+#define DIB3000MB_REG_UNK_107			(   107)
+#define DIB3000MB_UNK_107					(0x0080)
+
+#define DIB3000MB_REG_UNK_108			(   108)
+#define DIB3000MB_UNK_108					(0x0080)
+
+/* fft ??? */
+#define DIB3000MB_REG_UNK_121			(   121)
+#define DIB3000MB_UNK_121_2K				(     7)
+#define DIB3000MB_UNK_121_DEFAULT			(     5)
+
+#define DIB3000MB_REG_UNK_122			(   122)
+#define DIB3000MB_UNK_122					(  2867)
+
+/* QAM for mobile mode */
+#define DIB3000MB_REG_MOBILE_MODE_QAM	(   126)
+#define DIB3000MB_MOBILE_MODE_QAM_64			(     3)
+#define DIB3000MB_MOBILE_MODE_QAM_QPSK_16	(     1)
+#define DIB3000MB_MOBILE_MODE_QAM_OFF		(     0)
+
+/* 
+ * data diversity when having more than one chip on-board
+ * see also DIB3000MB_OUTPUT_MODE_DATA_DIVERSITY
+ */
+#define DIB3000MB_REG_DATA_IN_DIVERSITY		(   127)
+#define DIB3000MB_DATA_DIVERSITY_IN_OFF			(     0)
+#define DIB3000MB_DATA_DIVERSITY_IN_ON			(     2)
+
+/* vit hrch */
+#define DIB3000MB_REG_VIT_HRCH			(   128)
+#define DIB3000MB_VIT_HRCH_ON				(     1)
+#define DIB3000MB_VIT_HRCH_OFF				(     0)
+
+/* vit code rate */
+#define DIB3000MB_REG_VIT_CODE_RATE		(   129)
+
+/* forward error correction code rates */
+#define DIB3000MB_FEC_1_2					(     0)
+#define DIB3000MB_FEC_2_3					(     1)
+#define DIB3000MB_FEC_3_4					(     2)
+#define DIB3000MB_FEC_4_5					(     3)
+#define DIB3000MB_FEC_5_6					(     4)
+#define DIB3000MB_FEC_7_8					(     5)
+
+/* vit select hp */
+#define DIB3000MB_REG_VIT_HP			(   130)
+#define DIB3000MB_VIT_LP					(     0)
+#define DIB3000MB_VIT_HP					(     1)
+
+/* time frame for Bit-Error-Rate calculation */
+#define DIB3000MB_REG_BERLEN			(   135)
+#define DIB3000MB_BERLEN_LONG				(     0)
+#define DIB3000MB_BERLEN_DEFAULT			(     1)
+#define DIB3000MB_BERLEN_MEDIUM				(     2)
+#define DIB3000MB_BERLEN_SHORT				(     3)
+
+/* 142 - 152 FIFO parameters 
+ * which is what ?
+ */
+
+#define DIB3000MB_REG_FIFO_142			(   142)
+#define DIB3000MB_FIFO_142					(     0)
+
+/* MPEG2 TS output mode */
+#define DIB3000MB_REG_MPEG2_OUT_MODE	(   143)
+#define DIB3000MB_MPEG2_OUT_MODE_204		(     0)
+#define DIB3000MB_MPEG2_OUT_MODE_188		(     1)
+
+#define DIB3000MB_REG_FIFO_144			(   144)
+#define DIB3000MB_FIFO_144					(     1)
+
+#define DIB3000MB_REG_FIFO				(   145)
+#define DIB3000MB_FIFO_INHIBIT				(     1)
+#define DIB3000MB_FIFO_ACTIVATE				(     0)
+
+#define DIB3000MB_REG_FIFO_146			(   146)
+#define DIB3000MB_FIFO_146					(     3)
+
+#define DIB3000MB_REG_FIFO_147			(   147)
+#define DIB3000MB_FIFO_147					(0x0100)
+
+/* 
+ * pidfilter 
+ * it is not a hardware pidfilter but a filter which drops all pids
+ * except the ones set. Necessary because of the limited USB1.1 bandwidth.
+ */
+#define DIB3000MB_REG_FILTER_PID_0		(   153)
+#define DIB3000MB_REG_FILTER_PID_1		(   154)
+#define DIB3000MB_REG_FILTER_PID_2		(   155)
+#define DIB3000MB_REG_FILTER_PID_3		(   156)
+#define DIB3000MB_REG_FILTER_PID_4		(   157)
+#define DIB3000MB_REG_FILTER_PID_5		(   158)
+#define DIB3000MB_REG_FILTER_PID_6		(   159)
+#define DIB3000MB_REG_FILTER_PID_7		(   160)
+#define DIB3000MB_REG_FILTER_PID_8		(   161)
+#define DIB3000MB_REG_FILTER_PID_9		(   162)
+#define DIB3000MB_REG_FILTER_PID_10		(   163)
+#define DIB3000MB_REG_FILTER_PID_11		(   164)
+#define DIB3000MB_REG_FILTER_PID_12		(   165)
+#define DIB3000MB_REG_FILTER_PID_13		(   166)
+#define DIB3000MB_REG_FILTER_PID_14		(   167)
+#define DIB3000MB_REG_FILTER_PID_15		(   168)
+
+#define DIB3000MB_ACTIVATE_FILTERING			(0x2000)
+
+/*
+ * output mode
+ * USB devices have to use 'slave'-mode
+ * see also DIB3000MB_REG_ELECT_OUT_MODE
+ */
+#define DIB3000MB_REG_OUTPUT_MODE		(   169)
+#define DIB3000MB_OUTPUT_MODE_GATED_CLK		(     0)
+#define DIB3000MB_OUTPUT_MODE_CONT_CLK		(     1)
+#define DIB3000MB_OUTPUT_MODE_SERIAL		(     2)
+#define DIB3000MB_OUTPUT_MODE_DATA_DIVERSITY	(     5)
+#define DIB3000MB_OUTPUT_MODE_SLAVE			(     6)
+
+/* irq event mask */
+#define DIB3000MB_REG_IRQ_EVENT_MASK		(   170)
+#define DIB3000MB_IRQ_EVENT_MASK				(     0)
+
+/* filter coefficients */
+#define DIB3000MB_REG_FILTER_COEF_171	(   171)
+#define DIB3000MB_REG_FILTER_COEF_172	(   172)
+#define DIB3000MB_REG_FILTER_COEF_173	(   173)
+#define DIB3000MB_REG_FILTER_COEF_174	(   174)
+#define DIB3000MB_REG_FILTER_COEF_175	(   175)
+#define DIB3000MB_REG_FILTER_COEF_176	(   176)
+#define DIB3000MB_REG_FILTER_COEF_177	(   177)
+#define DIB3000MB_REG_FILTER_COEF_178	(   178)
+#define DIB3000MB_REG_FILTER_COEF_179	(   179)
+#define DIB3000MB_REG_FILTER_COEF_180	(   180)
+#define DIB3000MB_REG_FILTER_COEF_181	(   181)
+#define DIB3000MB_REG_FILTER_COEF_182	(   182)
+#define DIB3000MB_REG_FILTER_COEF_183	(   183)
+#define DIB3000MB_REG_FILTER_COEF_184	(   184)
+#define DIB3000MB_REG_FILTER_COEF_185	(   185)
+#define DIB3000MB_REG_FILTER_COEF_186	(   186)
+#define DIB3000MB_REG_FILTER_COEF_187	(   187)
+#define DIB3000MB_REG_FILTER_COEF_188	(   188)
+#define DIB3000MB_REG_FILTER_COEF_189	(   189)
+#define DIB3000MB_REG_FILTER_COEF_190	(   190)
+#define DIB3000MB_REG_FILTER_COEF_191	(   191)
+#define DIB3000MB_REG_FILTER_COEF_192	(   192)
+#define DIB3000MB_REG_FILTER_COEF_193	(   193)
+#define DIB3000MB_REG_FILTER_COEF_194	(   194)
+
+static u16 dib3000mb_reg_filter_coeffs[] = {
+	DIB3000MB_REG_FILTER_COEF_171, DIB3000MB_REG_FILTER_COEF_172, DIB3000MB_REG_FILTER_COEF_173,
+	DIB3000MB_REG_FILTER_COEF_174, DIB3000MB_REG_FILTER_COEF_175, DIB3000MB_REG_FILTER_COEF_176,
+	DIB3000MB_REG_FILTER_COEF_177, DIB3000MB_REG_FILTER_COEF_178, DIB3000MB_REG_FILTER_COEF_179,
+	DIB3000MB_REG_FILTER_COEF_180, DIB3000MB_REG_FILTER_COEF_181, DIB3000MB_REG_FILTER_COEF_182,
+	DIB3000MB_REG_FILTER_COEF_183, DIB3000MB_REG_FILTER_COEF_184, DIB3000MB_REG_FILTER_COEF_185,
+	DIB3000MB_REG_FILTER_COEF_186,                                DIB3000MB_REG_FILTER_COEF_188,
+	DIB3000MB_REG_FILTER_COEF_189, DIB3000MB_REG_FILTER_COEF_190, DIB3000MB_REG_FILTER_COEF_191,
+	DIB3000MB_REG_FILTER_COEF_192,                                DIB3000MB_REG_FILTER_COEF_194
+};
+
+static u16 dib3000mb_filter_coeffs[] = {
+	 226,  160,   29, 
+ 	 979,  998,   19,  
+	  22, 1019, 1006, 
+	1022,   12,    6, 
+	1017, 1017,    3,  
+	   6,       1019,
+	1021,    2,    3,
+	   1,          0,
+};
+
+/* 
+ * mobile algorithm (when you are moving with your device) 
+ * but not faster than 90 km/h
+ */
+#define DIB3000MB_REG_MOBILE_ALGO		(   195)
+#define DIB3000MB_MOBILE_ALGO_ON			(     0)
+#define DIB3000MB_MOBILE_ALGO_OFF			(     1)
+
+/* multiple demodulators algorithm */
+#define DIB3000MB_REG_MULTI_DEMOD_MSB	(   206)
+#define DIB3000MB_REG_MULTI_DEMOD_LSB	(   207)
+
+/* terminator, no more demods */
+#define DIB3000MB_MULTI_DEMOD_MSB			( 32767)
+#define DIB3000MB_MULTI_DEMOD_LSB			(  4095)
+
+/* bring the device into a known  */
+#define DIB3000MB_REG_RESET_DEVICE		(  1024)
+#define DIB3000MB_RESET_DEVICE				(0x812c)
+#define DIB3000MB_RESET_DEVICE_RST			(     0)
+
+/* identification registers, manufactor an the device */
+#define DIB3000MB_REG_MANUFACTOR_ID		(  1025)
+#define DIB3000MB_MANUFACTOR_ID_DIBCOM		(0x01B3)
+
+#define DIB3000MB_REG_DEVICE_ID			(  1026)
+#define DIB3000MB_DEVICE_ID					(0x3000)
+
+/* hardware clock configuration */
+#define DIB3000MB_REG_CLOCK				(  1027)
+#define DIB3000MB_CLOCK_DEFAULT				(0x9000)
+#define DIB3000MB_CLOCK_DIVERSITY			(0x92b0)
+
+/* power down config */
+#define DIB3000MB_REG_POWER_CONTROL		(  1028)
+#define DIB3000MB_POWER_DOWN				(     1)
+#define DIB3000MB_POWER_UP					(     0)
+
+/* electrical output mode */
+#define DIB3000MB_REG_ELECT_OUT_MODE	(  1029)
+#define DIB3000MB_ELECT_OUT_MODE_OFF		(     0)
+#define DIB3000MB_ELECT_OUT_MODE_ON			(     1)
+
+/* set the tuner i2c address */
+#define DIB3000MB_REG_TUNER				(  1089)
+#define DIB3000MB_TUNER_ADDR_DEFAULT		(   194)
+#define DIB3000MB_ACTIVATE_TUNER_XFER(a)	(0xffff & (a << 7))
+#define DIB3000MB_DEACTIVATE_TUNER_XFER(a)	(0xffff & ((a << 7) + 0x80)) 
+
+/* monitoring registers (read only) */
+
+/* agc loop locked (size: 1) */
+#define DIB3000MB_REG_AGC_LOCK			(   324)
+
+/* agc power (size: 16) */
+#define DIB3000MB_REG_AGC_POWER			(   325)
+
+/* agc1 value (16) */
+#define DIB3000MB_REG_AGC1_VALUE		(   326)
+
+/* agc2 value (16) */
+#define DIB3000MB_REG_AGC2_VALUE		(   327)
+
+/* total RF power (16), can be used for signal strength */
+#define DIB3000MB_REG_RF_POWER			(   328)
+
+/* dds_frequency with offset (24) */
+#define DIB3000MB_REG_DDS_VALUE_MSB		(   339)
+#define DIB3000MB_REG_DDS_VALUE_LSB		(   340)
+
+/* timing offset signed (24) */
+#define DIB3000MB_REG_TIMING_OFFSET_MSB	(   341)
+#define DIB3000MB_REG_TIMING_OFFSET_LSB	(   342)
+
+/* fft start position (13) */
+#define DIB3000MB_REG_FFT_WINDOW_POS	(   353)
+
+/* carriers locked (1) */
+#define DIB3000MB_REG_CARRIER_LOCK		(   355)
+
+/* noise power (24) */
+#define DIB3000MB_REG_NOISE_POWER_MSB	(   372)
+#define DIB3000MB_REG_NOISE_POWER_LSB	(   373)
+
+#define DIB3000MB_REG_MOBILE_NOISE_MSB	(   374)
+#define DIB3000MB_REG_MOBILE_NOISE_LSB	(   375)
+
+/* 
+ * signal power (16), this and the above can be 
+ * used to calculate the signal/noise - ratio
+ */
+#define DIB3000MB_REG_SIGNAL_POWER		(   380)
+
+/* mer (24) */
+#define DIB3000MB_REG_MER_MSB			(   381)
+#define DIB3000MB_REG_MER_LSB			(   382)
+
+/*
+ * Transmission Parameter Signalling (TPS) 
+ * the following registers can be used to get TPS-information.
+ * The values are according to the DVB-T standard.
+ */
+
+/* TPS locked (1) */
+#define DIB3000MB_REG_TPS_LOCK			(   394)
+
+/* QAM from TPS (2) (values according to DIB3000MB_REG_QAM) */
+#define DIB3000MB_REG_TPS_QAM			(   398)
+
+/* hierarchy from TPS (1) */
+#define DIB3000MB_REG_TPS_HRCH			(   399)
+
+/* alpha from TPS (3) (values according to DIB3000MB_REG_VIT_ALPHA) */
+#define DIB3000MB_REG_TPS_VIT_ALPHA		(   400)
+
+/* code rate high priority from TPS (3) (values according to DIB3000MB_FEC_*) */
+#define DIB3000MB_REG_TPS_CODE_RATE_HP	(   401)
+
+/* code rate low priority from TPS (3) if DIB3000MB_REG_TPS_VIT_ALPHA */
+#define DIB3000MB_REG_TPS_CODE_RATE_LP	(   402)
+
+/* guard time from TPS (2) (values according to DIB3000MB_REG_GUARD_TIME */
+#define DIB3000MB_REG_TPS_GUARD_TIME	(   403)
+
+/* fft size from TPS (2) (values according to DIB3000MB_REG_FFT) */
+#define DIB3000MB_REG_TPS_FFT			(   404)
+
+/* cell id from TPS (16) */
+#define DIB3000MB_REG_TPS_CELL_ID		(   406)
+
+/* TPS (68) */
+#define DIB3000MB_REG_TPS_1				(   408)
+#define DIB3000MB_REG_TPS_2				(   409)
+#define DIB3000MB_REG_TPS_3				(   410)
+#define DIB3000MB_REG_TPS_4				(   411)
+#define DIB3000MB_REG_TPS_5				(   412)
+
+/* bit error rate (before RS correction) (21) */
+#define DIB3000MB_REG_BER_MSB			(   414)
+#define DIB3000MB_REG_BER_LSB			(   415)
+
+/* packet error rate (uncorrected TS packets) (16) */
+#define DIB3000MB_REG_PACKET_ERROR_RATE	(   417)
+
+/* packet error count (16) */
+#define DIB3000MB_REG_PACKET_ERROR_COUNT	(   420)
+
+/* viterbi locked (1) */
+#define DIB3000MB_REG_VIT_LCK			(   421)
+
+/* viterbi inidcator (16) */
+#define DIB3000MB_REG_VIT_INDICATOR		(   422)
+
+/* transport stream sync lock (1) */
+#define DIB3000MB_REG_TS_SYNC_LOCK		(   423)
+
+/* transport stream RS lock (1) */ 
+#define DIB3000MB_REG_TS_RS_LOCK		(   424)
+
+/* lock mask 0 value (1) */
+#define DIB3000MB_REG_LOCK0_VALUE		(   425)
+
+/* lock mask 1 value (1) */
+#define DIB3000MB_REG_LOCK1_VALUE		(   426)
+
+/* lock mask 2 value (1) */
+#define DIB3000MB_REG_LOCK2_VALUE		(   427)
+
+/* interrupt pending for auto search */
+#define DIB3000MB_REG_AS_IRQ_PENDING	(   434)
+
+#endif
diff -uraNwB linux-2.6.8.1-dvb1/drivers/media/dvb/frontends/Makefile linux-2.6.8.1-patched/drivers/media/dvb/frontends/Makefile
--- linux-2.6.8.1-dvb1/drivers/media/dvb/frontends/Makefile	2004-09-17 12:26:33.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/frontends/Makefile	2004-09-15 10:26:44.000000000 +0200
@@ -12,6 +12,7 @@
 obj-$(CONFIG_DVB_CX24110) += cx24110.o
 obj-$(CONFIG_DVB_GRUNDIG_29504_491) += grundig_29504-491.o
 obj-$(CONFIG_DVB_GRUNDIG_29504_401) += grundig_29504-401.o
+obj-$(CONFIG_DVB_DIB3000MB) += dib3000mb.o
 obj-$(CONFIG_DVB_MT312) += mt312.o
 obj-$(CONFIG_DVB_VES1820) += ves1820.o
 obj-$(CONFIG_DVB_VES1X93) += ves1x93.o
@@ -19,4 +20,5 @@
 obj-$(CONFIG_DVB_SP887X) += sp887x.o
 obj-$(CONFIG_DVB_NXT6000) += nxt6000.o
 obj-$(CONFIG_DVB_MT352) += mt352.o
+obj-$(CONFIG_DVB_CX22702) += cx22702.o
 

--------------030306050904050801070009--
