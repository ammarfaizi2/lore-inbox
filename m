Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264436AbTFYKdR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 06:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264472AbTFYKcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 06:32:12 -0400
Received: from mail.convergence.de ([212.84.236.4]:16544 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S264450AbTFYKX3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 06:23:29 -0400
Subject: [PATCH 5/7] Add two new dvb frontend drivers
In-Reply-To: <10565374582365@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Wed, 25 Jun 2003 12:37:38 +0200
Message-Id: <10565374581787@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Michael Hunold (LinuxTV.org CVS maintainer) 
	<hunold@convergence.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Zarlink MT312 satellite channel decoder driver contributed by Andreas Oberritter
- tda10045 DVB-T driver contributed by Andrew de Quincy and Robert Schlalach
diff -uNrwB --new-file linux-2.5.73.bk/drivers/media/dvb/frontends/Kconfig linux-2.5.73.work/drivers/media/dvb/frontends/Kconfig
--- linux-2.5.73.bk/drivers/media/dvb/frontends/Kconfig	2003-06-25 09:46:54.000000000 +0200
+++ linux-2.5.73.work/drivers/media/dvb/frontends/Kconfig	2003-06-25 09:50:42.000000000 +0200
@@ -93,6 +93,16 @@
 	  DVB adapter simply enable all supported frontends, the 
 	  right one will get autodetected.
 
+config DVB_MT312
+	tristate "Zarlink MT312 Satellite Channel Decoder (QPSK)"
+	depends on DVB_CORE
+	help
+	  A DVB-S tuner module. Say Y when you want to support this frontend.
+
+	  If you don't know what tuner module is soldered on your 
+	  DVB adapter simply enable all supported frontends, the 
+	  right one will get autodetected.
+
 config DVB_VES1820
 	tristate "Frontends with external VES1820 demodulator (QAM)"
 	depends on DVB_CORE
@@ -105,3 +115,12 @@
 	  DVB adapter simply enable all supported frontends, the 
 	  right one will get autodetected.
 
+config DVB_TDA10045H
+	tristate "Frontends with external TDA10045H demodulator (OFDM)"
+	depends on DVB_CORE
+	help
+	  A DVB-T tuner module. Say Y when you want to support this frontend.
+
+	  If you don't know what tuner module is soldered on your 
+	  DVB adapter simply enable all supported frontends, the 
+	  right one will get autodetected.
diff -uNrwB --new-file linux-2.5.73.bk/drivers/media/dvb/frontends/Makefile linux-2.5.73.work/drivers/media/dvb/frontends/Makefile
--- linux-2.5.73.bk/drivers/media/dvb/frontends/Makefile	2003-06-25 09:46:54.000000000 +0200
+++ linux-2.5.73.work/drivers/media/dvb/frontends/Makefile	2003-06-25 09:50:42.000000000 +0200
@@ -12,4 +12,6 @@
 obj-$(CONFIG_DVB_CX24110) += cx24110.o
 obj-$(CONFIG_DVB_GRUNDIG_29504_491) += grundig_29504-491.o
 obj-$(CONFIG_DVB_GRUNDIG_29504_401) += grundig_29504-401.o
+obj-$(CONFIG_DVB_MT312) += mt312.o
 obj-$(CONFIG_DVB_VES1820) += ves1820.o
+obj-$(CONFIG_DVB_TDA10045H) += tda10045h.o
diff -uNrwB --new-file linux-2.5.73.patch/drivers/media/dvb/frontends/mt312.c linux-2.5.73.work/drivers/media/dvb/frontends/mt312.c
--- linux-2.5.73.patch/drivers/media/dvb/frontends/mt312.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.73.work/drivers/media/dvb/frontends/mt312.c	2003-06-25 10:48:06.000000000 +0200
@@ -0,0 +1,714 @@
+/* 
+    Driver for Zarlink MT312 Satellite Channel Decoder
+
+    Copyright (C) 2003 Andreas Oberritter <obi@saftware.de>
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+
+    References:
+    http://products.zarlink.com/product_profiles/MT312.htm
+    http://products.zarlink.com/product_profiles/SL1935.htm
+*/
+
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+#include "dvb_frontend.h"
+#include "mt312.h"
+
+#define I2C_ADDR_MT312		0x0e
+#define I2C_ADDR_SL1935		0x61
+
+#define MT312_DEBUG		0
+
+#define MT312_SYS_CLK		90000000UL	/* 90 MHz */
+#define MT312_PLL_CLK		10000000UL	/* 10 MHz */
+
+static struct dvb_frontend_info mt312_info = {
+	.name = "Zarlink MT312",
+	.type = FE_QPSK,
+	.frequency_min = 950000,
+	.frequency_max = 2150000,
+	.frequency_stepsize = (MT312_PLL_CLK / 1000) / 128,
+	/*.frequency_tolerance = 29500,         FIXME: binary compatibility waste? */
+	.symbol_rate_min = MT312_SYS_CLK / 128,
+	.symbol_rate_max = MT312_SYS_CLK / 2,
+	/*.symbol_rate_tolerance = 500,         FIXME: binary compatibility waste? 2% */
+	.notifier_delay = 0,
+	.caps =
+	    FE_CAN_INVERSION_AUTO | FE_CAN_FEC_1_2 | FE_CAN_FEC_2_3 |
+	    FE_CAN_FEC_3_4 | FE_CAN_FEC_5_6 | FE_CAN_FEC_7_8 |
+	    FE_CAN_FEC_AUTO | FE_CAN_QPSK | FE_CAN_RECOVER |
+	    FE_CAN_CLEAN_SETUP | FE_CAN_MUTE_TS
+};
+
+static int mt312_read(struct dvb_i2c_bus *i2c,
+		      const enum mt312_reg_addr reg, void *buf,
+		      const size_t count)
+{
+	int ret;
+	struct i2c_msg msg[2];
+	u8 regbuf[1] = { reg };
+
+	msg[0].addr = I2C_ADDR_MT312;
+	msg[0].flags = 0;
+	msg[0].buf = regbuf;
+	msg[0].len = 1;
+	msg[1].addr = I2C_ADDR_MT312;
+	msg[1].flags = I2C_M_RD;
+	msg[1].buf = buf;
+	msg[1].len = count;
+
+	ret = i2c->xfer(i2c, msg, 2);
+
+	if (ret != 2) {
+		printk(KERN_ERR "%s: ret == %d\n", __FUNCTION__, ret);
+		return -EREMOTEIO;
+	}
+#ifdef MT312_DEBUG
+	{
+		int i;
+		printk(KERN_INFO "R(%d):", reg & 0x7f);
+		for (i = 0; i < count; i++)
+			printk(" %02x", ((const u8 *) buf)[i]);
+		printk("\n");
+	}
+#endif
+
+	return 0;
+}
+
+static int mt312_write(struct dvb_i2c_bus *i2c,
+		       const enum mt312_reg_addr reg, const void *src,
+		       const size_t count)
+{
+	int ret;
+	u8 buf[count + 1];
+	struct i2c_msg msg;
+
+#ifdef MT312_DEBUG
+	{
+		int i;
+		printk(KERN_INFO "W(%d):", reg & 0x7f);
+		for (i = 0; i < count; i++)
+			printk(" %02x", ((const u8 *) src)[i]);
+		printk("\n");
+	}
+#endif
+
+	buf[0] = reg;
+	memcpy(&buf[1], src, count);
+
+	msg.addr = I2C_ADDR_MT312;
+	msg.flags = 0;
+	msg.buf = buf;
+	msg.len = count + 1;
+
+	ret = i2c->xfer(i2c, &msg, 1);
+
+	if (ret != 1) {
+		printk(KERN_ERR "%s: ret == %d\n", __FUNCTION__, ret);
+		return -EREMOTEIO;
+	}
+
+	return 0;
+}
+
+static inline int mt312_readreg(struct dvb_i2c_bus *i2c,
+				const enum mt312_reg_addr reg, u8 * val)
+{
+	return mt312_read(i2c, reg, val, 1);
+}
+
+static inline int mt312_writereg(struct dvb_i2c_bus *i2c,
+				 const enum mt312_reg_addr reg, const u8 val)
+{
+	return mt312_write(i2c, reg, &val, 1);
+}
+
+static int mt312_pll_write(struct dvb_i2c_bus *i2c, const u8 addr,
+			   u8 * buf, const u8 len)
+{
+	int ret;
+	struct i2c_msg msg;
+
+	msg.addr = addr;
+	msg.flags = 0;
+	msg.buf = buf;
+	msg.len = len;
+
+	if ((ret = mt312_writereg(i2c, GPP_CTRL, 0x40)) < 0)
+		return ret;
+
+	if ((ret = i2c->xfer(i2c, &msg, 1)) != 1)
+		printk(KERN_ERR "%s: i/o error (ret == %d)\n", __FUNCTION__, ret);
+
+	if ((ret = mt312_writereg(i2c, GPP_CTRL, 0x00)) < 0)
+		return ret;
+
+	return 0;
+}
+
+static inline u32 mt312_div(u32 a, u32 b)
+{
+	return (a + (b / 2)) / b;
+}
+
+static int sl1935_set_tv_freq(struct dvb_i2c_bus *i2c, u32 freq, u32 sr)
+{
+	/* 155 uA, Baseband Path B */
+	u8 buf[4] = { 0x00, 0x00, 0x80, 0x00 };
+
+	u8 exp;
+	u32 ref;
+	u32 div;
+
+	if (sr < 10000000) {	/* 1-10 MSym/s: ratio 2 ^ 3 */
+		exp = 3;
+		buf[2] |= 0x40;	/* 690 uA */
+	} else if (sr < 15000000) {	/* 10-15 MSym/s: ratio 2 ^ 4 */
+		exp = 4;
+		buf[2] |= 0x20;	/* 330 uA */
+	} else {		/* 15-45 MSym/s: ratio 2 ^ 7 */
+		exp = 7;
+		buf[3] |= 0x08;	/* Baseband Path A */
+	}
+
+	div = mt312_div(MT312_PLL_CLK, 1 << exp);
+	ref = mt312_div(freq * 1000, div);
+	mt312_info.frequency_stepsize = mt312_div(div, 1000);
+
+	buf[0] = (ref >> 8) & 0x7f;
+	buf[1] = (ref >> 0) & 0xff;
+	buf[2] |= (exp - 1);
+
+	if (freq < 1550000)
+		buf[3] |= 0x10;
+
+	printk(KERN_INFO "synth dword = %02x%02x%02x%02x\n", buf[0],
+	       buf[1], buf[2], buf[3]);
+
+	return mt312_pll_write(i2c, I2C_ADDR_SL1935, buf, sizeof(buf));
+}
+
+static int mt312_reset(struct dvb_i2c_bus *i2c, const u8 full)
+{
+	return mt312_writereg(i2c, RESET, full ? 0x80 : 0x40);
+}
+
+static int mt312_init(struct dvb_i2c_bus *i2c)
+{
+	int ret;
+	u8 buf[2];
+
+	/* wake up */
+	if ((ret = mt312_writereg(i2c, CONFIG, 0x8c)) < 0)
+		return ret;
+
+	/* wait at least 150 usec */
+	udelay(150);
+
+	/* full reset */
+	if ((ret = mt312_reset(i2c, 1)) < 0)
+		return ret;
+
+	/* SYS_CLK */
+	buf[0] = mt312_div(MT312_SYS_CLK * 2, 1000000);
+
+	/* DISEQC_RATIO */
+	buf[1] = mt312_div(MT312_PLL_CLK, 15000 * 4);
+
+	if ((ret = mt312_write(i2c, SYS_CLK, buf, sizeof(buf))) < 0)
+		return ret;
+
+	if ((ret = mt312_writereg(i2c, SNR_THS_HIGH, 0x32)) < 0)
+		return ret;
+
+	/* TS_SW_LIM */
+	buf[0] = 0x8c;
+	buf[1] = 0x98;
+
+	if ((ret = mt312_write(i2c, TS_SW_LIM_L, buf, sizeof(buf))) < 0)
+		return ret;
+
+	if ((ret = mt312_writereg(i2c, CS_SW_LIM, 0x69)) < 0)
+		return ret;
+
+	return 0;
+}
+
+static int mt312_send_master_cmd(struct dvb_i2c_bus *i2c,
+				 const struct dvb_diseqc_master_cmd *c)
+{
+	int ret;
+	u8 diseqc_mode;
+
+	if ((c->msg_len == 0) || (c->msg_len > sizeof(c->msg)))
+		return -EINVAL;
+
+	if ((ret = mt312_readreg(i2c, DISEQC_MODE, &diseqc_mode)) < 0)
+		return ret;
+
+	if ((ret =
+	     mt312_write(i2c, (0x80 | DISEQC_INSTR), c->msg, c->msg_len)) < 0)
+		return ret;
+
+	if ((ret =
+	     mt312_writereg(i2c, DISEQC_MODE,
+			    (diseqc_mode & 0x40) | ((c->msg_len - 1) << 3)
+			    | 0x04)) < 0)
+		return ret;
+
+	/* set DISEQC_MODE[2:0] to zero if a return message is expected */
+	if (c->msg[0] & 0x02)
+		if ((ret =
+		     mt312_writereg(i2c, DISEQC_MODE, (diseqc_mode & 0x40))) < 0)
+			return ret;
+
+	return 0;
+}
+
+static int mt312_recv_slave_reply(struct dvb_i2c_bus *i2c,
+				  struct dvb_diseqc_slave_reply *r)
+{
+	/* TODO */
+	return -EOPNOTSUPP;
+}
+
+static int mt312_send_burst(struct dvb_i2c_bus *i2c, const fe_sec_mini_cmd_t c)
+{
+	const u8 mini_tab[2] = { 0x02, 0x03 };
+
+	int ret;
+	u8 diseqc_mode;
+
+	if (c > SEC_MINI_B)
+		return -EINVAL;
+
+	if ((ret = mt312_readreg(i2c, DISEQC_MODE, &diseqc_mode)) < 0)
+		return ret;
+
+	if ((ret =
+	     mt312_writereg(i2c, DISEQC_MODE,
+			    (diseqc_mode & 0x40) | mini_tab[c])) < 0)
+		return ret;
+
+	return 0;
+}
+
+static int mt312_set_tone(struct dvb_i2c_bus *i2c, const fe_sec_tone_mode_t t)
+{
+	const u8 tone_tab[2] = { 0x01, 0x00 };
+
+	int ret;
+	u8 diseqc_mode;
+
+	if (t > SEC_TONE_OFF)
+		return -EINVAL;
+
+	if ((ret = mt312_readreg(i2c, DISEQC_MODE, &diseqc_mode)) < 0)
+		return ret;
+
+	if ((ret =
+	     mt312_writereg(i2c, DISEQC_MODE,
+			    (diseqc_mode & 0x40) | tone_tab[t])) < 0)
+		return ret;
+
+	return 0;
+}
+
+static int mt312_set_voltage(struct dvb_i2c_bus *i2c, const fe_sec_voltage_t v)
+{
+	const u8 volt_tab[3] = { 0x00, 0x40, 0x00 };
+
+	if (v > SEC_VOLTAGE_OFF)
+		return -EINVAL;
+
+	return mt312_writereg(i2c, DISEQC_MODE, volt_tab[v]);
+}
+
+static int mt312_read_status(struct dvb_i2c_bus *i2c, fe_status_t * s)
+{
+	int ret;
+	u8 status[3];
+
+	*s = 0;
+
+	if ((ret = mt312_read(i2c, QPSK_STAT_H, status, sizeof(status))) < 0)
+		return ret;
+
+	if (status[0] & 0xc0)
+		*s |= FE_HAS_SIGNAL;	/* signal noise ratio */
+	if (status[0] & 0x04)
+		*s |= FE_HAS_CARRIER;	/* qpsk carrier lock */
+	if (status[2] & 0x02)
+		*s |= FE_HAS_VITERBI;	/* viterbi lock */
+	if (status[2] & 0x04)
+		*s |= FE_HAS_SYNC;	/* byte align lock */
+	if (status[0] & 0x01)
+		*s |= FE_HAS_LOCK;	/* qpsk lock */
+
+	return 0;
+}
+
+static int mt312_read_bercnt(struct dvb_i2c_bus *i2c, u32 * ber)
+{
+	int ret;
+	u8 buf[3];
+
+	if ((ret = mt312_read(i2c, RS_BERCNT_H, buf, 3)) < 0)
+		return ret;
+
+	*ber = ((buf[0] << 16) | (buf[1] << 8) | buf[2]) * 64;
+
+	return 0;
+}
+
+static int mt312_read_agc(struct dvb_i2c_bus *i2c, u16 * signal_strength)
+{
+	int ret;
+	u8 buf[3];
+	u16 agc;
+	s16 err_db;
+
+	if ((ret = mt312_read(i2c, AGC_H, buf, sizeof(buf))) < 0)
+		return ret;
+
+	agc = (buf[0] << 6) | (buf[1] >> 2);
+	err_db = (s16) (((buf[1] & 0x03) << 14) | buf[2] << 6) >> 6;
+
+	*signal_strength = agc;
+
+	printk(KERN_DEBUG "agc=%08x err_db=%hd\n", agc, err_db);
+
+	return 0;
+}
+
+static int mt312_read_snr(struct dvb_i2c_bus *i2c, u16 * snr)
+{
+	int ret;
+	u8 buf[2];
+
+	if ((ret = mt312_read(i2c, M_SNR_H, &buf, sizeof(buf))) < 0)
+		return ret;
+
+	*snr = 0xFFFF - ((((buf[0] & 0x7f) << 8) | buf[1]) << 1);
+
+	return 0;
+}
+
+static int mt312_read_ubc(struct dvb_i2c_bus *i2c, u32 * ubc)
+{
+	int ret;
+	u8 buf[2];
+
+	if ((ret = mt312_read(i2c, RS_UBC_H, &buf, sizeof(buf))) < 0)
+		return ret;
+
+	*ubc = (buf[0] << 8) | buf[1];
+
+	return 0;
+}
+
+static int mt312_set_frontend(struct dvb_i2c_bus *i2c,
+			      const struct dvb_frontend_parameters *p)
+{
+	int ret;
+	u8 buf[5];
+	u16 sr;
+
+	const u8 fec_tab[10] =
+	    { 0x00, 0x01, 0x02, 0x04, 0x3f, 0x08, 0x10, 0x20, 0x3f, 0x3f };
+	const u8 inv_tab[3] = { 0x00, 0x40, 0x80 };
+
+	if ((p->frequency < mt312_info.frequency_min)
+	    || (p->frequency > mt312_info.frequency_max))
+		return -EINVAL;
+
+	if ((p->inversion < INVERSION_OFF)
+	    || (p->inversion > INVERSION_AUTO))
+		return -EINVAL;
+
+	if ((p->u.qpsk.symbol_rate < mt312_info.symbol_rate_min)
+	    || (p->u.qpsk.symbol_rate > mt312_info.symbol_rate_max))
+		return -EINVAL;
+
+	if ((p->u.qpsk.fec_inner < FEC_NONE)
+	    || (p->u.qpsk.fec_inner > FEC_AUTO))
+		return -EINVAL;
+
+	if ((p->u.qpsk.fec_inner == FEC_4_5)
+	    || (p->u.qpsk.fec_inner == FEC_8_9))
+		return -EINVAL;
+
+	if ((ret =
+	     sl1935_set_tv_freq(i2c, p->frequency, p->u.qpsk.symbol_rate)) < 0)
+		return ret;
+
+	/* sr = (u16)(sr * 256.0 / 1000000.0) */
+	sr = mt312_div(p->u.qpsk.symbol_rate * 4, 15625);
+
+	/* SYM_RATE */
+	buf[0] = (sr >> 8) & 0x3f;
+	buf[1] = (sr >> 0) & 0xff;
+
+	/* VIT_MODE */
+	buf[2] = inv_tab[p->inversion] | fec_tab[p->u.qpsk.fec_inner];
+
+	/* QPSK_CTRL */
+	buf[3] = 0x40;		/* swap I and Q before QPSK demodulation */
+
+	if (p->u.qpsk.symbol_rate < 10000000)
+		buf[3] |= 0x04;	/* use afc mode */
+
+	/* GO */
+	buf[4] = 0x01;
+
+	if ((ret = mt312_write(i2c, SYM_RATE_H, buf, sizeof(buf))) < 0)
+		return ret;
+
+	return 0;
+}
+
+static int mt312_get_inversion(struct dvb_i2c_bus *i2c,
+			       fe_spectral_inversion_t * i)
+{
+	int ret;
+	u8 vit_mode;
+
+	if ((ret = mt312_readreg(i2c, VIT_MODE, &vit_mode)) < 0)
+		return ret;
+
+	if (vit_mode & 0x80)	/* auto inversion was used */
+		*i = (vit_mode & 0x40) ? INVERSION_ON : INVERSION_OFF;
+
+	return 0;
+}
+
+static int mt312_get_symbol_rate(struct dvb_i2c_bus *i2c, u32 * sr)
+{
+	int ret;
+	u8 sym_rate_h;
+	u8 dec_ratio;
+	u16 sym_rat_op;
+	u16 monitor;
+	u8 buf[2];
+
+	if ((ret = mt312_readreg(i2c, SYM_RATE_H, &sym_rate_h)) < 0)
+		return ret;
+
+	if (sym_rate_h & 0x80) {	/* symbol rate search was used */
+		if ((ret = mt312_writereg(i2c, MON_CTRL, 0x03)) < 0)
+			return ret;
+
+		if ((ret = mt312_read(i2c, MONITOR_H, buf, sizeof(buf))) < 0)
+			return ret;
+
+		monitor = (buf[0] << 8) | buf[1];
+
+		printk(KERN_DEBUG "sr(auto) = %u\n",
+		       mt312_div(monitor * 15625, 4));
+	} else {
+		if ((ret = mt312_writereg(i2c, MON_CTRL, 0x05)) < 0)
+			return ret;
+
+		if ((ret = mt312_read(i2c, MONITOR_H, buf, sizeof(buf))) < 0)
+			return ret;
+
+		dec_ratio = ((buf[0] >> 5) & 0x07) * 32;
+
+		if ((ret = mt312_read(i2c, SYM_RAT_OP_H, buf, sizeof(buf))) < 0)
+			return ret;
+
+		sym_rat_op = (buf[0] << 8) | buf[1];
+
+		printk(KERN_DEBUG "sym_rat_op=%d dec_ratio=%d\n",
+		       sym_rat_op, dec_ratio);
+		printk(KERN_DEBUG "*sr(manual) = %lu\n",
+		       (((MT312_PLL_CLK * 8192) / (sym_rat_op + 8192)) *
+			2) - dec_ratio);
+	}
+
+	return 0;
+}
+
+static int mt312_get_code_rate(struct dvb_i2c_bus *i2c, fe_code_rate_t * cr)
+{
+	const fe_code_rate_t fec_tab[8] =
+	    { FEC_1_2, FEC_2_3, FEC_3_4, FEC_5_6, FEC_6_7, FEC_7_8,
+		FEC_AUTO,
+		FEC_AUTO
+	};
+
+	int ret;
+	u8 fec_status;
+
+	if ((ret = mt312_readreg(i2c, FEC_STATUS, &fec_status)) < 0)
+		return ret;
+
+	*cr = fec_tab[(fec_status >> 4) & 0x07];
+
+	return 0;
+}
+
+static int mt312_get_frontend(struct dvb_i2c_bus *i2c,
+			      struct dvb_frontend_parameters *p)
+{
+	int ret;
+
+	if ((ret = mt312_get_inversion(i2c, &p->inversion)) < 0)
+		return ret;
+
+	if ((ret = mt312_get_symbol_rate(i2c, &p->u.qpsk.symbol_rate)) < 0)
+		return ret;
+
+	if ((ret = mt312_get_code_rate(i2c, &p->u.qpsk.fec_inner)) < 0)
+		return ret;
+
+	return 0;
+}
+
+static int mt312_sleep(struct dvb_i2c_bus *i2c)
+{
+	int ret;
+	u8 config;
+
+	/* reset all registers to defaults */
+	if ((ret = mt312_reset(i2c, 1)) < 0)
+		return ret;
+
+	if ((ret = mt312_readreg(i2c, CONFIG, &config)) < 0)
+		return ret;
+
+	/* enter standby */
+	if ((ret = mt312_writereg(i2c, CONFIG, config & 0x7f)) < 0)
+		return ret;
+
+	return 0;
+}
+
+static int mt312_ioctl(struct dvb_frontend *fe, unsigned int cmd, void *arg)
+{
+	struct dvb_i2c_bus *i2c = fe->i2c;
+
+	switch (cmd) {
+	case FE_GET_INFO:
+		memcpy(arg, &mt312_info, sizeof(struct dvb_frontend_info));
+		break;
+
+	case FE_DISEQC_RESET_OVERLOAD:
+		return -EOPNOTSUPP;
+
+	case FE_DISEQC_SEND_MASTER_CMD:
+		return mt312_send_master_cmd(i2c, arg);
+
+	case FE_DISEQC_RECV_SLAVE_REPLY:
+		if ((long) fe->data == ID_MT312)
+			return mt312_recv_slave_reply(i2c, arg);
+		else
+			return -EOPNOTSUPP;
+
+	case FE_DISEQC_SEND_BURST:
+		return mt312_send_burst(i2c, (fe_sec_mini_cmd_t) arg);
+
+	case FE_SET_TONE:
+		return mt312_set_tone(i2c, (fe_sec_tone_mode_t) arg);
+
+	case FE_SET_VOLTAGE:
+		return mt312_set_voltage(i2c, (fe_sec_voltage_t) arg);
+
+	case FE_ENABLE_HIGH_LNB_VOLTAGE:
+		return -EOPNOTSUPP;
+
+	case FE_READ_STATUS:
+		return mt312_read_status(i2c, arg);
+
+	case FE_READ_BER:
+		return mt312_read_bercnt(i2c, arg);
+
+	case FE_READ_SIGNAL_STRENGTH:
+		return mt312_read_agc(i2c, arg);
+
+	case FE_READ_SNR:
+		return mt312_read_snr(i2c, arg);
+
+	case FE_READ_UNCORRECTED_BLOCKS:
+		return mt312_read_ubc(i2c, arg);
+
+	case FE_SET_FRONTEND:
+		return mt312_set_frontend(i2c, arg);
+
+	case FE_GET_FRONTEND:
+		return mt312_get_frontend(i2c, arg);
+
+	case FE_GET_EVENT:
+		return -EOPNOTSUPP;
+
+	case FE_SLEEP:
+		return mt312_sleep(i2c);
+
+	case FE_INIT:
+		return mt312_init(i2c);
+
+	case FE_RESET:
+		return mt312_reset(i2c, 0);
+
+	default:
+		return -ENOIOCTLCMD;
+	}
+
+	return 0;
+}
+
+static int mt312_attach(struct dvb_i2c_bus *i2c)
+{
+	int ret;
+	u8 id;
+
+	if ((ret = mt312_readreg(i2c, ID, &id)) < 0)
+		return ret;
+
+	if ((id != ID_VP310) && (id != ID_MT312))
+		return -ENODEV;
+
+	return dvb_register_frontend(mt312_ioctl, i2c, (void *) (long) id,
+				     &mt312_info);
+}
+
+static void mt312_detach(struct dvb_i2c_bus *i2c)
+{
+	dvb_unregister_frontend(mt312_ioctl, i2c);
+}
+
+static int __init mt312_module_init(void)
+{
+	return dvb_register_i2c_device(THIS_MODULE, mt312_attach, mt312_detach);
+}
+
+static void __exit mt312_module_exit(void)
+{
+	dvb_unregister_i2c_device(mt312_attach);
+}
+
+module_init(mt312_module_init);
+module_exit(mt312_module_exit);
+
+MODULE_DESCRIPTION("MT312 Satellite Channel Decoder Driver");
+MODULE_AUTHOR("Andreas Oberritter <obi@saftware.de>");
+MODULE_LICENSE("GPL");
diff -uNrwB --new-file linux-2.5.73.patch/drivers/media/dvb/frontends/mt312.h linux-2.5.73.work/drivers/media/dvb/frontends/mt312.h
--- linux-2.5.73.patch/drivers/media/dvb/frontends/mt312.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.73.work/drivers/media/dvb/frontends/mt312.h	2003-06-25 10:46:35.000000000 +0200
@@ -0,0 +1,162 @@
+/* 
+    Driver for Zarlink MT312 QPSK Frontend
+
+    Copyright (C) 2003 Andreas Oberritter <obi@saftware.de>
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+
+*/
+
+#ifndef _DVB_FRONTENDS_MT312
+#define _DVB_FRONTENDS_MT312
+
+enum mt312_reg_addr {
+	QPSK_INT_H = 0,
+	QPSK_INT_M = 1,
+	QPSK_INT_L = 2,
+	FEC_INT = 3,
+	QPSK_STAT_H = 4,
+	QPSK_STAT_L = 5,
+	FEC_STATUS = 6,
+	LNB_FREQ_H = 7,
+	LNB_FREQ_L = 8,
+	M_SNR_H = 9,
+	M_SNR_L = 10,
+	VIT_ERRCNT_H = 11,
+	VIT_ERRCNT_M = 12,
+	VIT_ERRCNT_L = 13,
+	RS_BERCNT_H = 14,
+	RS_BERCNT_M = 15,
+	RS_BERCNT_L = 16,
+	RS_UBC_H = 17,
+	RS_UBC_L = 18,
+	SIG_LEVEL = 19,
+	GPP_CTRL = 20,
+	RESET = 21,
+	DISEQC_MODE = 22,
+	SYM_RATE_H = 23,
+	SYM_RATE_L = 24,
+	VIT_MODE = 25,
+	QPSK_CTRL = 26,
+	GO = 27,
+	IE_QPSK_H = 28,
+	IE_QPSK_M = 29,
+	IE_QPSK_L = 30,
+	IE_FEC = 31,
+	QPSK_STAT_EN = 32,
+	FEC_STAT_EN = 33,
+	SYS_CLK = 34,
+	DISEQC_RATIO = 35,
+	DISEQC_INSTR = 36,
+	FR_LIM = 37,
+	FR_OFF = 38,
+	AGC_CTRL = 39,
+	AGC_INIT = 40,
+	AGC_REF = 41,
+	AGC_MAX = 42,
+	AGC_MIN = 43,
+	AGC_LK_TH = 44,
+	TS_AGC_LK_TH = 45,
+	AGC_PWR_SET = 46,
+	QPSK_MISC = 47,
+	SNR_THS_LOW = 48,
+	SNR_THS_HIGH = 49,
+	TS_SW_RATE = 50,
+	TS_SW_LIM_L = 51,
+	TS_SW_LIM_H = 52,
+	CS_SW_RATE_1 = 53,
+	CS_SW_RATE_2 = 54,
+	CS_SW_RATE_3 = 55,
+	CS_SW_RATE_4 = 56,
+	CS_SW_LIM = 57,
+	TS_LPK = 58,
+	TS_LPK_M = 59,
+	TS_LPK_L = 60,
+	CS_KPROP_H = 61,
+	CS_KPROP_L = 62,
+	CS_KINT_H = 63,
+	CS_KINT_L = 64,
+	QPSK_SCALE = 65,
+	TLD_OUTCLK_TH = 66,
+	TLD_INCLK_TH = 67,
+	FLD_TH = 68,
+	PLD_OUTLK3 = 69,
+	PLD_OUTLK2 = 70,
+	PLD_OUTLK1 = 71,
+	PLD_OUTLK0 = 72,
+	PLD_INLK3 = 73,
+	PLD_INLK2 = 74,
+	PLD_INLK1 = 75,
+	PLD_INLK0 = 76,
+	PLD_ACC_TIME = 77,
+	SWEEP_PAR = 78,
+	STARTUP_TIME = 79,
+	LOSSLOCK_TH = 80,
+	FEC_LOCK_TM = 81,
+	LOSSLOCK_TM = 82,
+	VIT_ERRPER_H = 83,
+	VIT_ERRPER_M = 84,
+	VIT_ERRPER_L = 85,
+	VIT_SETUP = 86,
+	VIT_REF0 = 87,
+	VIT_REF1 = 88,
+	VIT_REF2 = 89,
+	VIT_REF3 = 90,
+	VIT_REF4 = 91,
+	VIT_REF5 = 92,
+	VIT_REF6 = 93,
+	VIT_MAXERR = 94,
+	BA_SETUPT = 95,
+	OP_CTRL = 96,
+	FEC_SETUP = 97,
+	PROG_SYNC = 98,
+	AFC_SEAR_TH = 99,
+	CSACC_DIF_TH = 100,
+	QPSK_LK_CT = 101,
+	QPSK_ST_CT = 102,
+	MON_CTRL = 103,
+	QPSK_RESET = 104,
+	QPSK_TST_CT = 105,
+	QPSK_TST_ST = 106,
+	TEST_R = 107,
+	AGC_H = 108,
+	AGC_M = 109,
+	AGC_L = 110,
+	FREQ_ERR1_H = 111,
+	FREQ_ERR1_M = 112,
+	FREQ_ERR1_L = 113,
+	FREQ_ERR2_H = 114,
+	FREQ_ERR2_L = 115,
+	SYM_RAT_OP_H = 116,
+	SYM_RAT_OP_L = 117,
+	DESEQC2_INT = 118,
+	DISEQC2_STAT = 119,
+	DISEQC2_FIFO = 120,
+	DISEQC2_CTRL1 = 121,
+	DISEQC2_CTRL2 = 122,
+	MONITOR_H = 123,
+	MONITOR_L = 124,
+	TEST_MODE = 125,
+	ID = 126,
+	CONFIG = 127
+};
+
+enum mt312_model_id {
+	ID_VP310 = 1,
+	ID_MT312 = 3
+};
+
+#endif				/* DVB_FRONTENDS_MT312 */
diff -uNrwB --new-file linux-2.5.73.patch/drivers/media/dvb/frontends/tda10045h.c linux-2.5.73.work/drivers/media/dvb/frontends/tda10045h.c
--- linux-2.5.73.patch/drivers/media/dvb/frontends/tda10045h.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.73.work/drivers/media/dvb/frontends/tda10045h.c	2003-06-25 09:50:42.000000000 +0200
@@ -0,0 +1,1231 @@
+  /*
+     Driver for Philips TDA10045H OFDM Frontend
+
+     This program is free software; you can redistribute it and/or modify
+     it under the terms of the GNU General Public License as published by
+     the Free Software Foundation; either version 2 of the License, or
+     (at your option) any later version.
+
+     This program is distributed in the hope that it will be useful,
+     but WITHOUT ANY WARRANTY; without even the implied warranty of
+     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+
+     GNU General Public License for more details.
+
+     You should have received a copy of the GNU General Public License
+     along with this program; if not, write to the Free Software
+     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+
+   */
+
+/*
+    This driver needs a copy of the DLL "ttlcdacc.dll" from the Haupauge or Technotrend
+    windows driver saved as '/usr/lib/DVB/driver/frontends/tda10045h.mc'.
+    You can also pass the complete file name with the module parameter 'tda10045h_firmware'.
+  
+    Currently the DLL from v2.15a of the technotrend driver is supported. Other versions can
+    be added reasonably painlessly.
+ 
+    Windows driver URL: http://www.technotrend.de/
+ */
+
+
+#define __KERNEL_SYSCALLS__
+#include <linux/kernel.h>
+#include <linux/vmalloc.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include <linux/fs.h>
+#include <linux/unistd.h>
+#include <linux/fcntl.h>
+#include <linux/errno.h>
+#include "dvb_frontend.h"
+#include "dvb_functions.h"
+
+static int tda10045h_debug = 0;
+static char *tda10045h_firmware =
+    "/usr/lib/DVB/driver/frontends/tda10045h.mc";
+
+
+#define TDA10045H_ADDRESS           0x08
+#define TDA10045H_TUNERA_ADDRESS    0x61
+#define TDA10045H_TDM1316L_ADDRESS  0x63
+#define TDA10045H_MC44BC374_ADDRESS 0x65
+
+#define TDA10045H_CHIPID        0x00
+#define TDA10045H_AUTO          0x01
+#define TDA10045H_IN_CONF1      0x02
+#define TDA10045H_IN_CONF2      0x03
+#define TDA10045H_OUT_CONF1     0x04
+#define TDA10045H_OUT_CONF2     0x05
+#define TDA10045H_STATUS_CD     0x06
+#define TDA10045H_CONFC4        0x07
+#define TDA10045H_REG0C         0x0C
+#define TDA10045H_CODE_IN       0x0D
+#define TDA10045H_FWPAGE        0x0E
+#define TDA10045H_SCAN_CPT      0x10
+#define TDA10045H_DSP_CMD       0x11
+#define TDA10045H_DSP_ARG       0x12
+#define TDA10045H_DSP_DATA1     0x13
+#define TDA10045H_DSP_DATA2     0x14
+#define TDA10045H_CONFADC1      0x15
+#define TDA10045H_CONFC1        0x16
+#define TDA10045H_SIGNAL_STRENGTH 0x1a
+#define TDA10045H_SNR           0x1c
+#define TDA10045H_REG1E         0x1e
+#define TDA10045H_REG1F         0x1f
+#define TDA10045H_CBER_MSB      0x21
+#define TDA10045H_CBER_LSB      0x22
+#define TDA10045H_CVBER_LUT     0x23
+#define TDA10045H_VBER_MSB      0x24
+#define TDA10045H_VBER_MID      0x25
+#define TDA10045H_VBER_LSB      0x26
+#define TDA10045H_UNCOR         0x27
+#define TDA10045H_CONFPLL_P     0x2D
+#define TDA10045H_CONFPLL_M_MSB 0x2E
+#define TDA10045H_CONFPLL_M_LSB 0x2F
+#define TDA10045H_CONFPLL_N     0x30
+#define TDA10045H_UNSURW_MSB    0x31
+#define TDA10045H_UNSURW_LSB    0x32
+#define TDA10045H_WREF_MSB      0x33
+#define TDA10045H_WREF_MID      0x34
+#define TDA10045H_WREF_LSB      0x35
+#define TDA10045H_MUXOUT        0x36
+#define TDA10045H_CONFADC2      0x37
+#define TDA10045H_IOFFSET       0x38
+
+
+#define dprintk if (tda10045h_debug) printk
+
+static struct dvb_frontend_info tda10045h_info = {
+	.name = "Philips TDA10045H",
+	.type = FE_OFDM,
+	.frequency_min = 87000000,
+	.frequency_max = 895000000,
+	.frequency_stepsize = 166667,
+	.caps = FE_CAN_INVERSION_AUTO |
+	    FE_CAN_FEC_1_2 | FE_CAN_FEC_2_3 | FE_CAN_FEC_3_4 |
+	    FE_CAN_FEC_5_6 | FE_CAN_FEC_7_8 | FE_CAN_FEC_AUTO |
+	    FE_CAN_QPSK | FE_CAN_QAM_16 | FE_CAN_QAM_64 | FE_CAN_QAM_AUTO |
+	    FE_CAN_TRANSMISSION_MODE_AUTO | FE_CAN_GUARD_INTERVAL_AUTO
+};
+
+#pragma pack(1)
+struct tda10045h_state {
+	u8 tuner_address;
+	u8 initialised;
+};
+#pragma pack()
+
+struct fwinfo {
+	int file_size;
+	int fw_offset;
+	int fw_size;
+};
+static struct fwinfo tda10045h_fwinfo[] = { {.file_size = 286720,.fw_offset = 0x34cc5,.fw_size = 30555},	/* 2.15a */
+};
+static int tda10045h_fwinfo_count =
+    sizeof(tda10045h_fwinfo) / sizeof(struct fwinfo);
+
+
+static u8 disable_mc44BC374c[] = { 0x1d, 0x74, 0xa0, 0x68 };
+static u8 bandwidth_8mhz[] =
+    { 0x02, 0x00, 0x3d, 0x00, 0x48, 0x17, 0x89, 0xc7, 0x14 };
+static u8 bandwidth_7mhz[] =
+    { 0x02, 0x00, 0x37, 0x00, 0x4a, 0x2f, 0x6d, 0x76, 0xdb };
+static u8 bandwidth_6mhz[] =
+    { 0x02, 0x00, 0x3d, 0x00, 0x60, 0x1e, 0xa7, 0x45, 0x4f };
+static u8 tuner_data[] = { 0x0b, 0xf5, 0x88, 0xab, 0x00 };
+static int errno;
+
+static
+int tda10045h_write_byte(struct dvb_i2c_bus *i2c, int reg, int data)
+{
+	int ret;
+	u8 buf[] = { reg, data };
+	struct i2c_msg msg = {.addr = TDA10045H_ADDRESS,.flags = 0,.buf =
+		    buf,.len = 2
+	};
+
+	dprintk("%s: reg=0x%x, data=0x%x\n", __FUNCTION__, reg, data);
+
+	ret = i2c->xfer(i2c, &msg, 1);
+
+	if (ret != 1)
+		dprintk("%s: error reg=0x%x, data=0x%x, ret=%i\n",
+		       __FUNCTION__, reg, data, ret);
+
+	dprintk("%s: success reg=0x%x, data=0x%x, ret=%i\n", __FUNCTION__,
+		reg, data, ret);
+	return (ret != 1) ? -1 : 0;
+}
+
+static
+int tda10045h_read_byte(struct dvb_i2c_bus *i2c, int reg)
+{
+	int ret;
+	u8 b0[] = { reg };
+	u8 b1[] = { 0 };
+	struct i2c_msg msg[] = { {.addr = TDA10045H_ADDRESS,.flags =
+				  0,.buf = b0,.len = 1},
+	{.addr = TDA10045H_ADDRESS,.flags = I2C_M_RD,.buf = b1,.len = 1}
+	};
+
+	dprintk("%s: reg=0x%x\n", __FUNCTION__, reg);
+
+	ret = i2c->xfer(i2c, msg, 2);
+
+	if (ret != 2) {
+		dprintk("%s: error reg=0x%x, ret=%i\n", __FUNCTION__, reg,
+		       ret);
+		return -1;
+	}
+
+	dprintk("%s: success reg=0x%x, data=0x%x, ret=%i\n", __FUNCTION__,
+		reg, b1[0], ret);
+	return b1[0];
+}
+
+static
+int tda10045h_write_mask(struct dvb_i2c_bus *i2c, int reg, int mask,
+			 int data)
+{
+        int val;
+	dprintk("%s: reg=0x%x, mask=0x%x, data=0x%x\n", __FUNCTION__, reg,
+		mask, data);
+
+	// read a byte and check
+	val = tda10045h_read_byte(i2c, reg);
+	if (val < 0)
+		return val;
+
+	// mask if off
+	val = val & ~mask;
+	val |= data & 0xff;
+
+	// write it out again
+	return tda10045h_write_byte(i2c, reg, val);
+}
+
+static
+int tda10045h_write_buf(struct dvb_i2c_bus *i2c, int reg,
+			unsigned char *buf, int len)
+{
+	int i;
+	int result;
+
+	dprintk("%s: reg=0x%x, len=0x%x\n", __FUNCTION__, reg, len);
+
+	result = 0;
+	for (i = 0; i < len; i++) {
+		result = tda10045h_write_byte(i2c, reg + i, buf[i]);
+		if (result != 0)
+			break;
+	}
+
+	return result;
+}
+
+static
+int tda10045h_enable_tuner_i2c(struct dvb_i2c_bus *i2c)
+{
+        int result;
+	dprintk("%s\n", __FUNCTION__);
+
+	result = tda10045h_write_mask(i2c, TDA10045H_CONFC4, 2, 2);
+	dvb_delay(1);
+	return result;
+}
+
+static
+int tda10045h_disable_tuner_i2c(struct dvb_i2c_bus *i2c)
+{
+
+	dprintk("%s\n", __FUNCTION__);
+
+	return tda10045h_write_mask(i2c, TDA10045H_CONFC4, 2, 0);
+}
+
+static
+int tda10045h_dsp_command(struct dvb_i2c_bus *i2c, int cmd, int arg)
+{
+	int counter;
+	int data1;
+	int data2;
+
+	dprintk("%s: cmd=0x%x, arg=0x%x\n", __FUNCTION__, cmd, arg);
+
+	// send command and argument
+	if (tda10045h_write_byte(i2c, TDA10045H_DSP_ARG, arg) < 0)
+		return -1;
+	if (tda10045h_write_byte(i2c, TDA10045H_DSP_CMD, cmd) < 0)
+		return -1;
+
+	// command retry loop
+	counter = 0;
+	while (counter++ < 5) {
+
+		// read in the two data bytes
+		data1 = tda10045h_read_byte(i2c, TDA10045H_DSP_DATA1);
+		data2 = tda10045h_read_byte(i2c, TDA10045H_DSP_DATA2);
+		if ((data1 < 0) || (data2 < 0))
+			return -1;
+
+		// finshed yet?
+		if (data1 == cmd)
+			continue;
+		if (data2 == arg)
+			continue;
+
+		// OK, resend command
+		if (tda10045h_write_byte(i2c, TDA10045H_DSP_CMD, cmd) < 0)
+			return -1;
+	}
+
+	// OK, did it work?
+	if (data1 != cmd)
+		return -1;
+	if (data2 != arg)
+		return -1;
+
+	// success
+	return 0;
+}
+
+
+static
+int tda10045h_init(struct dvb_i2c_bus *i2c)
+{
+	int fw_pos;
+	int tx_size;
+	int counter;
+	u8 fw_buf[65];
+	struct i2c_msg fw_msg = {.addr = TDA10045H_ADDRESS,.flags =
+		    0,.buf = fw_buf,.len = 0
+	};
+	struct i2c_msg tuner_msg = {.addr = 0,.flags = 0,.buf = 0,.len = 0
+	};
+	unsigned char *firmware = NULL;
+	int filesize;
+	int fw_size = 0;
+	int fd;
+	int data1;
+	int fwinfo_idx;
+	mm_segment_t fs = get_fs();
+
+	dprintk("%s\n", __FUNCTION__);
+
+	// Load the firmware
+	set_fs(get_ds());
+	fd = open(tda10045h_firmware, 0, 0);
+	if (fd < 0) {
+		printk("%s: Unable to open firmware %s\n", __FUNCTION__,
+		       tda10045h_firmware);
+		return -EIO;
+	}
+	filesize = lseek(fd, 0L, 2);
+	if (filesize <= 0) {
+		printk("%s: Firmware %s is empty\n", __FUNCTION__,
+		       tda10045h_firmware);
+		sys_close(fd);
+		return -EIO;
+	}
+	// find extraction parameters
+	for (fwinfo_idx = 0; fwinfo_idx < tda10045h_fwinfo_count;
+	     fwinfo_idx++) {
+		if (tda10045h_fwinfo[fwinfo_idx].file_size == filesize)
+			break;
+	}
+	if (fwinfo_idx >= tda10045h_fwinfo_count) {
+		printk("%s: Unsupported firmware %s\n", __FUNCTION__,
+		       tda10045h_firmware);
+		sys_close(fd);
+		return -EIO;
+	}
+	fw_size = tda10045h_fwinfo[fwinfo_idx].fw_size;
+
+	// allocate buffer for it
+	firmware = vmalloc(fw_size);
+	if (firmware == NULL) {
+		printk("%s: Out of memory loading firmware\n",
+		       __FUNCTION__);
+		sys_close(fd);
+		return -EIO;
+	}
+	// read it!
+	lseek(fd, tda10045h_fwinfo[fwinfo_idx].fw_offset, 0);
+	if (read(fd, firmware, fw_size) != fw_size) {
+		printk("%s: Failed to read firmware\n", __FUNCTION__);
+		vfree(firmware);
+		sys_close(fd);
+		return -EIO;
+	}
+	sys_close(fd);
+	set_fs(fs);
+
+	// Disable the MC44BC374C
+	tda10045h_enable_tuner_i2c(i2c);
+	tuner_msg.addr = TDA10045H_MC44BC374_ADDRESS;
+	tuner_msg.buf = disable_mc44BC374c;
+	tuner_msg.len = sizeof(disable_mc44BC374c);
+	if (i2c->xfer(i2c, &tuner_msg, 1) != 1) {
+		i2c->xfer(i2c, &tuner_msg, 1);
+	}
+	tda10045h_disable_tuner_i2c(i2c);
+
+	// setup for firmware upload
+	tda10045h_write_buf(i2c, TDA10045H_CONFPLL_P, bandwidth_8mhz,
+			    sizeof(bandwidth_8mhz));
+	tda10045h_write_byte(i2c, TDA10045H_IOFFSET, 0);
+	dvb_delay(500);
+
+	// do the firmware upload
+	tda10045h_write_byte(i2c, TDA10045H_FWPAGE, 0);
+	fw_pos = 0;
+	while (fw_pos != fw_size) {
+		// work out how much to send this time
+		tx_size = fw_size - fw_pos;
+		if (tx_size > 64) {
+			tx_size = 64;
+		}
+		// send the chunk
+		fw_buf[0] = TDA10045H_CODE_IN;
+		memcpy(fw_buf + 1, firmware + fw_pos, tx_size);
+		fw_msg.len = tx_size + 1;
+		if (i2c->xfer(i2c, &fw_msg, 1) != 1) {
+			vfree(firmware);
+			return -EIO;
+		}
+		fw_pos += tx_size;
+
+		dprintk("%s: fw_pos=0x%x\n", __FUNCTION__, fw_pos);
+	}
+	dvb_delay(100);
+	vfree(firmware);
+
+	// Initialise the DSP and check upload was OK
+	tda10045h_write_mask(i2c, TDA10045H_CONFC4, 0x10, 0);
+	tda10045h_write_byte(i2c, TDA10045H_DSP_CMD, 0x67);
+	if ((tda10045h_read_byte(i2c, TDA10045H_DSP_DATA1) != 0x67) ||
+	    (tda10045h_read_byte(i2c, TDA10045H_DSP_DATA2) != 0x2c)) {
+		printk("%s: firmware upload failed!\n", __FUNCTION__);
+		return -EIO;
+	}
+	// tda setup
+	tda10045h_write_byte(i2c, TDA10045H_CONFADC1, 0x2e);
+	tda10045h_write_mask(i2c, TDA10045H_CONFC1, 0x40, 0);
+	tda10045h_write_mask(i2c, TDA10045H_CONFC4, 0x20, 0);
+	tda10045h_write_mask(i2c, TDA10045H_VBER_MSB, 0xe0, 0xa0);
+	tda10045h_write_byte(i2c, TDA10045H_REG1F, 0);
+	tda10045h_write_byte(i2c, TDA10045H_REG1E, 0);
+	tda10045h_write_mask(i2c, TDA10045H_CONFC1, 0x80, 0x80);
+
+	// DSP init
+	tda10045h_write_mask(i2c, TDA10045H_CONFC4, 0x10, 0);
+	if (tda10045h_write_byte(i2c, TDA10045H_DSP_CMD, 0x61) < 0)
+		return -1;
+
+	// command retry loop
+	counter = 0;
+	while (counter++ < 5) {
+
+		// read in the data byte
+		data1 = tda10045h_read_byte(i2c, TDA10045H_DSP_DATA1);
+		if (data1 < 0)
+			return data1;
+
+		// finshed yet?
+		if (data1 & 1)
+			continue;
+
+		// OK, resend command
+		if (tda10045h_write_byte(i2c, TDA10045H_DSP_CMD, 0x61) < 0)
+			return -1;
+	}
+	tda10045h_write_byte(i2c, TDA10045H_DSP_DATA1, 0x01);
+	tda10045h_write_byte(i2c, TDA10045H_DSP_DATA2, 0x0e);
+	tda10045h_dsp_command(i2c, 0x69, 0);
+	tda10045h_write_byte(i2c, TDA10045H_DSP_DATA2, 0x01);
+	tda10045h_dsp_command(i2c, 0x69, 1);
+	tda10045h_write_byte(i2c, TDA10045H_DSP_DATA2, 0x03);
+	tda10045h_dsp_command(i2c, 0x69, 2);
+
+	// tda setup
+	tda10045h_write_mask(i2c, TDA10045H_CONFADC2, 0x20, 0x20);
+	tda10045h_write_mask(i2c, TDA10045H_CONFADC1, 0x80, 0);
+	tda10045h_write_mask(i2c, TDA10045H_CONFC1, 0x10, 0);
+	tda10045h_write_mask(i2c, TDA10045H_AUTO, 0x10, 0x10);
+	tda10045h_write_mask(i2c, TDA10045H_IN_CONF2, 0xC0, 0x0);
+	tda10045h_write_mask(i2c, TDA10045H_AUTO, 8, 0);
+
+	// done
+	return 0;
+}
+
+static
+int tda10045h_encode_fec(int fec)
+{
+	// convert known FEC values
+	switch (fec) {
+	case FEC_1_2:
+		return 0;
+	case FEC_2_3:
+		return 1;
+	case FEC_3_4:
+		return 2;
+	case FEC_5_6:
+		return 3;
+	case FEC_7_8:
+		return 4;
+	}
+
+	// unsupported
+	return -EINVAL;
+}
+
+static
+int tda10045h_decode_fec(int tdafec)
+{
+	// convert known FEC values
+	switch (tdafec) {
+	case 0:
+		return FEC_1_2;
+	case 1:
+		return FEC_2_3;
+	case 2:
+		return FEC_3_4;
+	case 3:
+		return FEC_5_6;
+	case 4:
+		return FEC_7_8;
+	}
+
+	// unsupported
+	return -1;
+}
+
+static
+int tda10045h_set_frequency(struct dvb_i2c_bus *i2c,
+			    struct tda10045h_state *tda_state,
+			    struct dvb_frontend_parameters *fe_params)
+{
+	int counter, counter2;
+	u8 tuner_buf[5];
+	u8 v1, v2, v3;
+	struct i2c_msg tuner_msg = {.addr = 0,.flags = 0,.buf =
+		    tuner_buf,.len = sizeof(tuner_buf)
+	};
+	int tuner_frequency;
+
+	dprintk("%s\n", __FUNCTION__);
+
+	// setup the frequency buffer
+	switch (tda_state->tuner_address) {
+	case TDA10045H_TUNERA_ADDRESS:
+
+		// setup tuner buffer
+		tuner_frequency =
+		    (((fe_params->frequency / 1000) * 6) + 217502) / 1000;
+		tuner_buf[0] = tuner_frequency >> 8;
+		tuner_buf[1] = tuner_frequency & 0xff;
+		tuner_buf[2] = 0x88;
+		if (fe_params->frequency < 550000000) {
+			tuner_buf[3] = 0xab;
+		} else {
+			tuner_buf[3] = 0xeb;
+		}
+
+		// tune it
+		tda10045h_enable_tuner_i2c(i2c);
+		tuner_msg.addr = tda_state->tuner_address;
+		tuner_msg.len = 4;
+		i2c->xfer(i2c, &tuner_msg, 1);
+
+		// wait for it to finish
+		tuner_msg.len = 1;
+		tuner_msg.flags = I2C_M_RD;
+		counter = 0;
+		counter2 = 0;
+		while (counter++ < 100) {
+			if (i2c->xfer(i2c, &tuner_msg, 1) == 1) {
+				if (tuner_buf[0] & 0x40) {
+					counter2++;
+				} else {
+					counter2 = 0;
+				}
+			}
+
+			if (counter2 > 10) {
+				break;
+			}
+		}
+		tda10045h_disable_tuner_i2c(i2c);
+		break;
+
+	case TDA10045H_TDM1316L_ADDRESS:
+		// determine settings
+		tuner_frequency = fe_params->frequency + 36167000;
+		if (tuner_frequency < 87000000) {
+			return -EINVAL;
+		} else if (tuner_frequency < 130000000) {
+			v1 = 1;
+			v2 = 3;
+		} else if (tuner_frequency < 160000000) {
+			v1 = 1;
+			v2 = 5;
+		} else if (tuner_frequency < 200000000) {
+			v1 = 1;
+			v2 = 6;
+		} else if (tuner_frequency < 290000000) {
+			v1 = 2;
+			v2 = 3;
+		} else if (tuner_frequency < 420000000) {
+			v1 = 2;
+			v2 = 5;
+		} else if (tuner_frequency < 480000000) {
+			v1 = 2;
+			v2 = 6;
+		} else if (tuner_frequency < 620000000) {
+			v1 = 4;
+			v2 = 3;
+		} else if (tuner_frequency < 830000000) {
+			v1 = 4;
+			v2 = 5;
+		} else if (tuner_frequency < 895000000) {
+			v1 = 4;
+			v2 = 7;
+		} else {
+			return -EINVAL;
+		}
+
+		// work out v3
+		switch (fe_params->u.ofdm.bandwidth) {
+		case BANDWIDTH_6_MHZ:	// FIXME: IS THIS CORRECT???????
+			if (fe_params->frequency <= 300000000) {
+				v3 = 0;
+			} else {
+				v3 = 1;
+			}
+			break;
+
+		case BANDWIDTH_7_MHZ:
+			v3 = 0;
+			break;
+
+		case BANDWIDTH_8_MHZ:
+			v3 = 1;
+			break;
+
+		default:
+			return -EINVAL;
+		}
+
+		// calculate tuner parameters
+		tuner_frequency =
+		    (((fe_params->frequency / 1000) * 6) + 217502) / 1000;
+		tuner_buf[0] = tuner_frequency >> 8;
+		tuner_buf[1] = tuner_frequency & 0xff;
+		tuner_buf[2] = 0xca;
+		tuner_buf[3] = (3 << 5) | (v3 << 3) | v1;
+		tuner_buf[4] = 0x85;
+
+		// tune it
+		tda10045h_enable_tuner_i2c(i2c);
+		tuner_msg.addr = tda_state->tuner_address;
+		tuner_msg.len = 5;
+		if (i2c->xfer(i2c, &tuner_msg, 1) != 1) {
+			return -EIO;
+		}
+		dvb_delay(50);
+		tuner_buf[3] = (v2 << 5) | (v3 << 3) | v1;
+		if (i2c->xfer(i2c, &tuner_msg, 1) != 1) {
+			return -EIO;
+		}
+		dvb_delay(1);
+		tda10045h_disable_tuner_i2c(i2c);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	dprintk("%s: success\n", __FUNCTION__);
+
+	// done
+	return 0;
+}
+
+static
+int tda10045h_set_fe(struct dvb_i2c_bus *i2c,
+		     struct tda10045h_state *tda_state,
+		     struct dvb_frontend_parameters *fe_params)
+{
+	int tmp;
+
+	dprintk("%s\n", __FUNCTION__);
+
+	// set frequency
+	tmp = tda10045h_set_frequency(i2c, tda_state, fe_params);
+	if (tmp < 0)
+		return tmp;
+
+        // hardcoded to use auto as much as possible
+        fe_params->u.ofdm.code_rate_HP = FEC_AUTO;
+        fe_params->u.ofdm.guard_interval = GUARD_INTERVAL_AUTO;
+        fe_params->u.ofdm.transmission_mode = TRANSMISSION_MODE_AUTO;
+   
+	// Set standard params.. or put them to auto
+	if ((fe_params->u.ofdm.code_rate_HP == FEC_AUTO) ||
+	    (fe_params->u.ofdm.code_rate_LP == FEC_AUTO) ||
+	    (fe_params->u.ofdm.constellation == QAM_AUTO) ||
+	    (fe_params->u.ofdm.hierarchy_information == HIERARCHY_AUTO)) {
+		tda10045h_write_mask(i2c, TDA10045H_AUTO, 1, 1);	// enable auto
+		tda10045h_write_mask(i2c, TDA10045H_IN_CONF1, 0x03, 0);	// turn off constellation bits
+		tda10045h_write_mask(i2c, TDA10045H_IN_CONF1, 0x60, 0);	// turn off hierarchy bits
+		tda10045h_write_mask(i2c, TDA10045H_IN_CONF2, 0x3f, 0);	// turn off FEC bits
+	} else {
+		tda10045h_write_mask(i2c, TDA10045H_AUTO, 1, 0);	// disable auto
+
+		// set HP FEC
+		tmp = tda10045h_encode_fec(fe_params->u.ofdm.code_rate_HP);
+		if (tmp < 0)
+			return tmp;
+		tda10045h_write_mask(i2c, TDA10045H_IN_CONF2, 7, tmp);
+
+		// set LP FEC
+		if (fe_params->u.ofdm.code_rate_LP != FEC_NONE) {
+			tmp =
+			    tda10045h_encode_fec(fe_params->u.ofdm.
+						 code_rate_LP);
+			if (tmp < 0)
+				return tmp;
+			tda10045h_write_mask(i2c, TDA10045H_IN_CONF2,
+					     0x38, tmp << 3);
+		}
+		// set constellation
+		switch (fe_params->u.ofdm.constellation) {
+		case QPSK:
+			tda10045h_write_mask(i2c, TDA10045H_IN_CONF1,
+					     3, 0);
+			break;
+
+		case QAM_16:
+			tda10045h_write_mask(i2c, TDA10045H_IN_CONF1,
+					     3, 1);
+			break;
+
+		case QAM_64:
+			tda10045h_write_mask(i2c, TDA10045H_IN_CONF1,
+					     3, 2);
+			break;
+
+		default:
+			return -EINVAL;
+		}
+
+		// set hierarchy
+		switch (fe_params->u.ofdm.hierarchy_information) {
+		case HIERARCHY_NONE:
+			tda10045h_write_mask(i2c, TDA10045H_IN_CONF1,
+					     0x60, 0 << 5);
+			break;
+
+		case HIERARCHY_1:
+			tda10045h_write_mask(i2c, TDA10045H_IN_CONF1,
+					     0x60, 1 << 5);
+			break;
+
+		case HIERARCHY_2:
+			tda10045h_write_mask(i2c, TDA10045H_IN_CONF1,
+					     0x60, 2 << 5);
+			break;
+
+		case HIERARCHY_4:
+			tda10045h_write_mask(i2c, TDA10045H_IN_CONF1,
+					     0x60, 3 << 5);
+			break;
+
+		default:
+			return -EINVAL;
+		}
+	}
+
+	// set bandwidth
+	switch (fe_params->u.ofdm.bandwidth) {
+	case BANDWIDTH_6_MHZ:
+		tda10045h_write_byte(i2c, TDA10045H_REG0C, 0x14);
+		tda10045h_write_buf(i2c, TDA10045H_CONFPLL_P,
+				    bandwidth_6mhz,
+				    sizeof(bandwidth_6mhz));
+		break;
+
+	case BANDWIDTH_7_MHZ:
+		tda10045h_write_byte(i2c, TDA10045H_REG0C, 0x80);
+		tda10045h_write_buf(i2c, TDA10045H_CONFPLL_P,
+				    bandwidth_7mhz,
+				    sizeof(bandwidth_7mhz));
+		break;
+
+	case BANDWIDTH_8_MHZ:
+		tda10045h_write_byte(i2c, TDA10045H_REG0C, 0x14);
+		tda10045h_write_buf(i2c, TDA10045H_CONFPLL_P,
+				    bandwidth_8mhz,
+				    sizeof(bandwidth_8mhz));
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	// set inversion
+	switch (fe_params->inversion) {
+	case INVERSION_OFF:
+		tda10045h_write_mask(i2c, TDA10045H_CONFC1, 0x20, 0);
+		break;
+
+	case INVERSION_ON:
+		tda10045h_write_mask(i2c, TDA10045H_CONFC1, 0x20, 0x20);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	// set guard interval
+	switch (fe_params->u.ofdm.guard_interval) {
+	case GUARD_INTERVAL_1_32:
+		tda10045h_write_mask(i2c, TDA10045H_AUTO, 2, 0);
+		tda10045h_write_mask(i2c, TDA10045H_IN_CONF1, 0x0c,
+				     0 << 2);
+		break;
+
+	case GUARD_INTERVAL_1_16:
+		tda10045h_write_mask(i2c, TDA10045H_AUTO, 2, 0);
+		tda10045h_write_mask(i2c, TDA10045H_IN_CONF1, 0x0c,
+				     1 << 2);
+		break;
+
+	case GUARD_INTERVAL_1_8:
+		tda10045h_write_mask(i2c, TDA10045H_AUTO, 2, 0);
+		tda10045h_write_mask(i2c, TDA10045H_IN_CONF1, 0x0c,
+				     2 << 2);
+		break;
+
+	case GUARD_INTERVAL_1_4:
+		tda10045h_write_mask(i2c, TDA10045H_AUTO, 2, 0);
+		tda10045h_write_mask(i2c, TDA10045H_IN_CONF1, 0x0c,
+				     3 << 2);
+		break;
+
+	case GUARD_INTERVAL_AUTO:
+		tda10045h_write_mask(i2c, TDA10045H_AUTO, 2, 2);
+		tda10045h_write_mask(i2c, TDA10045H_IN_CONF1, 0x0c,
+				     0 << 2);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	// set transmission mode
+	switch (fe_params->u.ofdm.transmission_mode) {
+	case TRANSMISSION_MODE_2K:
+		tda10045h_write_mask(i2c, TDA10045H_AUTO, 4, 0);
+		tda10045h_write_mask(i2c, TDA10045H_IN_CONF1, 0x10,
+				     0 << 4);
+		break;
+
+	case TRANSMISSION_MODE_8K:
+		tda10045h_write_mask(i2c, TDA10045H_AUTO, 4, 0);
+		tda10045h_write_mask(i2c, TDA10045H_IN_CONF1, 0x10,
+				     1 << 4);
+		break;
+
+	case TRANSMISSION_MODE_AUTO:
+		tda10045h_write_mask(i2c, TDA10045H_AUTO, 4, 4);
+		tda10045h_write_mask(i2c, TDA10045H_IN_CONF1, 0x10, 0);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	// reset DSP
+	tda10045h_write_mask(i2c, TDA10045H_CONFC4, 8, 8);
+	tda10045h_write_mask(i2c, TDA10045H_CONFC4, 8, 0);
+	dvb_delay(10);
+
+	// done
+	return 0;
+}
+
+
+static
+int tda10045h_get_fe(struct dvb_i2c_bus *i2c,
+		     struct dvb_frontend_parameters *fe_params)
+{
+
+	dprintk("%s\n", __FUNCTION__);
+
+	// inversion status
+	fe_params->inversion = INVERSION_OFF;
+	if (tda10045h_read_byte(i2c, TDA10045H_CONFC1) & 0x20) {
+		fe_params->inversion = INVERSION_ON;
+	}
+	// bandwidth
+	switch (tda10045h_read_byte(i2c, TDA10045H_WREF_LSB)) {
+	case 0x14:
+		fe_params->u.ofdm.bandwidth = BANDWIDTH_8_MHZ;
+		break;
+	case 0xdb:
+		fe_params->u.ofdm.bandwidth = BANDWIDTH_7_MHZ;
+		break;
+	case 0x4f:
+		fe_params->u.ofdm.bandwidth = BANDWIDTH_6_MHZ;
+		break;
+	}
+
+	// FEC
+	fe_params->u.ofdm.code_rate_HP =
+	    tda10045h_decode_fec(tda10045h_read_byte
+				 (i2c, TDA10045H_OUT_CONF2) & 7);
+	fe_params->u.ofdm.code_rate_LP =
+	    tda10045h_decode_fec((tda10045h_read_byte
+				  (i2c, TDA10045H_OUT_CONF2) >> 3) & 7);
+
+	// constellation
+	switch (tda10045h_read_byte(i2c, TDA10045H_OUT_CONF1) & 3) {
+	case 0:
+		fe_params->u.ofdm.constellation = QPSK;
+		break;
+	case 1:
+		fe_params->u.ofdm.constellation = QAM_16;
+		break;
+	case 2:
+		fe_params->u.ofdm.constellation = QAM_64;
+		break;
+	}
+
+	// transmission mode
+	fe_params->u.ofdm.transmission_mode = TRANSMISSION_MODE_2K;
+	if (tda10045h_read_byte(i2c, TDA10045H_OUT_CONF1) & 0x10) {
+		fe_params->u.ofdm.transmission_mode = TRANSMISSION_MODE_8K;
+	}
+	// guard interval
+	switch ((tda10045h_read_byte(i2c, TDA10045H_OUT_CONF1) & 0x0c) >>
+		2) {
+	case 0:
+		fe_params->u.ofdm.guard_interval = GUARD_INTERVAL_1_32;
+		break;
+	case 1:
+		fe_params->u.ofdm.guard_interval = GUARD_INTERVAL_1_16;
+		break;
+	case 2:
+		fe_params->u.ofdm.guard_interval = GUARD_INTERVAL_1_8;
+		break;
+	case 3:
+		fe_params->u.ofdm.guard_interval = GUARD_INTERVAL_1_4;
+		break;
+	}
+
+	// hierarchy
+	switch ((tda10045h_read_byte(i2c, TDA10045H_OUT_CONF1) & 0x60) >>
+		5) {
+	case 0:
+		fe_params->u.ofdm.hierarchy_information = HIERARCHY_NONE;
+		break;
+	case 1:
+		fe_params->u.ofdm.hierarchy_information = HIERARCHY_1;
+		break;
+	case 2:
+		fe_params->u.ofdm.hierarchy_information = HIERARCHY_2;
+		break;
+	case 3:
+		fe_params->u.ofdm.hierarchy_information = HIERARCHY_4;
+		break;
+	}
+
+	// done
+	return 0;
+}
+
+
+static
+int tda10045h_read_status(struct dvb_i2c_bus *i2c, fe_status_t * fe_status)
+{
+	int status;
+
+	dprintk("%s\n", __FUNCTION__);
+
+	// read status
+	status = tda10045h_read_byte(i2c, TDA10045H_STATUS_CD);
+	if (status == -1) {
+		return -EIO;
+	}
+	// decode
+	*fe_status = 0;
+	if (status == 0x2f) {
+		*fe_status =
+		    FE_HAS_SIGNAL | FE_HAS_CARRIER | FE_HAS_VITERBI |
+		    FE_HAS_SYNC | FE_HAS_LOCK;
+	}
+	// FIXME: decode statuses better
+
+	dprintk("%s: ------------------ raw_status=0x%x\n", __FUNCTION__, status);
+
+	// success
+	dprintk("%s: fe_status=0x%x\n", __FUNCTION__, *fe_status);
+	return 0;
+}
+
+static
+int tda10045h_read_signal_strength(struct dvb_i2c_bus *i2c, u16 * signal)
+{
+	int tmp;
+
+	dprintk("%s\n", __FUNCTION__);
+
+	// read it
+	tmp = tda10045h_read_byte(i2c, TDA10045H_SIGNAL_STRENGTH);
+
+	if (tmp < 0)
+		return -EIO;
+
+	// done
+	*signal = (tmp << 8) | tmp;
+	dprintk("%s: signal=0x%x\n", __FUNCTION__, *signal);
+	return 0;
+}
+
+
+static
+int tda10045h_read_snr(struct dvb_i2c_bus *i2c, u16 * snr)
+{
+	int tmp;
+
+	dprintk("%s\n", __FUNCTION__);
+
+	// read it
+	tmp = tda10045h_read_byte(i2c, TDA10045H_SNR);
+	if (tmp < 0)
+		return -EIO;
+        // FIXME: calculate this properly
+
+	// done
+	*snr = ~((tmp << 8) | tmp);
+	dprintk("%s: snr=0x%x\n", __FUNCTION__, *snr);
+	return 0;
+}
+
+static
+int tda10045h_read_ucblocks(struct dvb_i2c_bus *i2c, u32 * ucblocks)
+{
+	int tmp;
+	int tmp2;
+	int counter;
+
+	dprintk("%s\n", __FUNCTION__);
+
+	// read the UCBLOCKS and reset
+	counter = 0;
+	tmp = tda10045h_read_byte(i2c, TDA10045H_UNCOR);
+	if (tmp < 0)
+		return -EIO;
+        tmp &= 0x7f;
+	while (counter++ < 5) {
+		tda10045h_write_mask(i2c, TDA10045H_UNCOR, 0x80, 0);
+		tda10045h_write_mask(i2c, TDA10045H_UNCOR, 0x80, 0);
+		tda10045h_write_mask(i2c, TDA10045H_UNCOR, 0x80, 0);
+
+		tmp2 = tda10045h_read_byte(i2c, TDA10045H_UNCOR);
+		if (tmp2 < 0)
+			return -EIO;
+		tmp2 &= 0x7f;
+		if ((tmp2 < tmp) || (tmp2 == 0))
+			break;
+	}
+        // FIXME: calculate this properly
+
+	// done
+	if (tmp != 0x7f) {
+		*ucblocks = tmp;
+	} else {
+		*ucblocks = 0xffffffff;
+	}
+	dprintk("%s: ucblocks=0x%x\n", __FUNCTION__, *ucblocks);
+	return 0;
+}
+
+static
+int tda10045h_read_vber(struct dvb_i2c_bus *i2c, u32 * vber)
+{
+
+	dprintk("%s\n", __FUNCTION__);
+
+	// read it in
+	*vber = 0;
+	*vber |= tda10045h_read_byte(i2c, TDA10045H_VBER_LSB);
+	*vber |= tda10045h_read_byte(i2c, TDA10045H_VBER_MID) << 8;
+	*vber |=
+	    (tda10045h_read_byte(i2c, TDA10045H_VBER_MSB) & 0x0f) << 16;
+
+	// reset counter
+	tda10045h_read_byte(i2c, TDA10045H_CVBER_LUT);
+        // FIXME: calculate this properly
+	
+	// done
+	dprintk("%s: vber=0x%x\n", __FUNCTION__, *vber);
+	return 0;
+}
+
+static
+int tda10045h_ioctl(struct dvb_frontend *fe, unsigned int cmd, void *arg)
+{
+	int status;
+	struct dvb_i2c_bus *i2c = fe->i2c;
+	struct tda10045h_state *tda_state = (struct tda10045h_state *) &(fe->data);
+
+	dprintk("%s: cmd=0x%x\n", __FUNCTION__, cmd);
+
+	switch (cmd) {
+	case FE_GET_INFO:
+		memcpy(arg, &tda10045h_info,
+		       sizeof(struct dvb_frontend_info));
+		break;
+
+	case FE_READ_STATUS:
+		return tda10045h_read_status(i2c, (fe_status_t *) arg);
+
+	case FE_READ_BER:
+		return tda10045h_read_vber(i2c, (u32 *) arg);
+
+	case FE_READ_SIGNAL_STRENGTH:
+		return tda10045h_read_signal_strength(i2c, (u16 *) arg);
+
+	case FE_READ_SNR:
+		return tda10045h_read_snr(i2c, (u16 *) arg);
+
+	case FE_READ_UNCORRECTED_BLOCKS:
+		return tda10045h_read_ucblocks(i2c, (u32 *) arg);
+
+	case FE_SET_FRONTEND:
+		return tda10045h_set_fe(i2c, tda_state,
+					(struct dvb_frontend_parameters
+					 *) arg);
+
+	case FE_GET_FRONTEND:
+		return tda10045h_get_fe(i2c,
+					(struct dvb_frontend_parameters
+					 *) arg);
+
+	case FE_SLEEP:
+		break;
+
+	case FE_INIT:
+		// don't bother reinitialising
+		if (tda_state->initialised)
+			return 0;
+
+		// OK, perform initialisation
+		status = tda10045h_init(i2c);
+		if (status == 0)
+			tda_state->initialised = 1;
+		return status;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+
+static
+int tda10045h_attach(struct dvb_i2c_bus *i2c)
+{
+	int tuner_address = -1;
+	struct i2c_msg tuner_msg = {.addr = 0,.flags = 0,.buf = 0,.len = 0
+	};
+	struct tda10045h_state tda_state;
+
+	dprintk("%s\n", __FUNCTION__);
+
+	// supported frontend?
+	if (tda10045h_read_byte(i2c, TDA10045H_CHIPID) != 0x25)
+		return -ENODEV;
+
+	// supported tuner?
+	tda10045h_enable_tuner_i2c(i2c);
+	tuner_msg.addr = TDA10045H_TUNERA_ADDRESS;
+	tuner_msg.buf = tuner_data;
+	tuner_msg.len = 4;
+	if (i2c->xfer(i2c, &tuner_msg, 1) == 1) {
+		tuner_address = TDA10045H_TUNERA_ADDRESS;
+		printk("tda10045h: Detected, tuner type A.\n");
+	} else {
+		tuner_msg.addr = TDA10045H_TDM1316L_ADDRESS;
+		tuner_msg.buf = tuner_data;
+		tuner_msg.len = 5;
+		if (i2c->xfer(i2c, &tuner_msg, 1) == 1) {
+			tuner_address = TDA10045H_TDM1316L_ADDRESS;
+			printk
+			    ("tda10045h: Detected Philips TDM1316L tuner.\n");
+		}
+	}
+	tda10045h_disable_tuner_i2c(i2c);
+
+	// did we find a tuner?
+	if (tuner_address == -1) {
+		printk("tda10045h: Detected, but with unknown tuner.\n");
+		return -ENODEV;
+	}
+	// create state
+	tda_state.tuner_address = tuner_address;
+	tda_state.initialised = 0;
+
+	// register
+	dvb_register_frontend(tda10045h_ioctl, i2c, (void *)(*((u32*) &tda_state)),
+			      &tda10045h_info);
+
+	// success
+	return 0;
+}
+
+
+static
+void tda10045h_detach(struct dvb_i2c_bus *i2c)
+{
+	dprintk("%s\n", __FUNCTION__);
+
+	dvb_unregister_frontend(tda10045h_ioctl, i2c);
+}
+
+
+static
+int __init init_tda10045h(void)
+{
+	return dvb_register_i2c_device(THIS_MODULE, tda10045h_attach,
+				       tda10045h_detach);
+}
+
+
+static
+void __exit exit_tda10045h(void)
+{
+	dvb_unregister_i2c_device(tda10045h_attach);
+}
+
+module_init(init_tda10045h);
+module_exit(exit_tda10045h);
+
+MODULE_DESCRIPTION("Philips TDA10045H DVB-T Frontend");
+MODULE_AUTHOR("Andrew de Quincey & Robert Schlabbach");
+MODULE_LICENSE("GPL");
+
+MODULE_PARM(tda10045h_debug, "i");
+MODULE_PARM_DESC(tda10045h_debug, "enable verbose debug messages");
+
+MODULE_PARM(tda10045h_firmware, "s");
+MODULE_PARM_DESC(tda10045h_firmware, "where to find the firmware file");

