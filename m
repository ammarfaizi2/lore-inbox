Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262170AbVF0Mwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbVF0Mwi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 08:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262117AbVF0Mtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 08:49:51 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:5605 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262044AbVF0MQS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 08:16:18 -0400
Message-Id: <20050627121413.908833000@abc>
References: <20050627120600.739151000@abc>
Date: Mon, 27 Jun 2005 14:06:22 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andrew de Quincey <adq_dvb@lidskialf.net>
Content-Disposition: inline; filename=dvb-ttpci-hauppauge-dvb-s-se.patch
X-SA-Exim-Connect-IP: 84.189.248.249
Subject: [DVB patch 22/51] ttpci: add support for Technotrend/Hauppauge DVB-S SE
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew de Quincey <adq_dvb@lidskialf.net>

Add support for s5h1420 frontend (new Technotrend/Hauppauge DVB-S SE).

Signed-off-by: Andrew de Quincey <adq_dvb@lidskialf.net>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/frontends/Kconfig   |    6 
 drivers/media/dvb/frontends/Makefile  |    1 
 drivers/media/dvb/frontends/s5h1420.c |  800 ++++++++++++++++++++++++++++++++++
 drivers/media/dvb/frontends/s5h1420.h |   41 +
 drivers/media/dvb/ttpci/Kconfig       |    9 
 drivers/media/dvb/ttpci/budget.c      |   99 ++++
 6 files changed, 952 insertions(+), 4 deletions(-)

Index: linux-2.6.12-git8/drivers/media/dvb/frontends/Kconfig
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/frontends/Kconfig	2005-06-27 13:18:22.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/frontends/Kconfig	2005-06-27 13:24:15.000000000 +0200
@@ -40,6 +40,12 @@ config DVB_VES1X93
 	help
 	  A DVB-S tuner module. Say Y when you want to support this frontend.
 
+config DVB_S5H1420
+	tristate "Samsung S5H1420 based"
+	depends on DVB_CORE
+	help
+	  A DVB-S tuner module. Say Y when you want to support this frontend.
+
 comment "DVB-T (terrestrial) frontends"
 	depends on DVB_CORE
 
Index: linux-2.6.12-git8/drivers/media/dvb/frontends/Makefile
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/frontends/Makefile	2005-06-27 13:18:22.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/frontends/Makefile	2005-06-27 13:24:15.000000000 +0200
@@ -29,3 +29,4 @@ obj-$(CONFIG_DVB_NXT2002) += nxt2002.o
 obj-$(CONFIG_DVB_OR51211) += or51211.o
 obj-$(CONFIG_DVB_OR51132) += or51132.o
 obj-$(CONFIG_DVB_BCM3510) += bcm3510.o
+obj-$(CONFIG_DVB_S5H1420) += s5h1420.o
Index: linux-2.6.12-git8/drivers/media/dvb/frontends/s5h1420.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.12-git8/drivers/media/dvb/frontends/s5h1420.c	2005-06-27 13:24:15.000000000 +0200
@@ -0,0 +1,800 @@
+/*
+Driver for Samsung S5H1420 QPSK Demodulator
+
+Copyright (C) 2005 Andrew de Quincey <adq_dvb@lidskialf.net>
+
+This program is free software; you can redistribute it and/or modify
+it under the terms of the GNU General Public License as published by
+the Free Software Foundation; either version 2 of the License, or
+(at your option) any later version.
+
+This program is distributed in the hope that it will be useful,
+but WITHOUT ANY WARRANTY; without even the implied warranty of
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+
+GNU General Public License for more details.
+
+You should have received a copy of the GNU General Public License
+along with this program; if not, write to the Free Software
+Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+
+*/
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+
+#include "dvb_frontend.h"
+#include "s5h1420.h"
+
+
+
+#define TONE_FREQ 22000
+
+struct s5h1420_state {
+	struct i2c_adapter* i2c;
+	struct dvb_frontend_ops ops;
+	const struct s5h1420_config* config;
+	struct dvb_frontend frontend;
+
+	u8 postlocked:1;
+	u32 fclk;
+	u32 tunedfreq;
+	fe_code_rate_t fec_inner;
+	u32 symbol_rate;
+};
+
+static u32 s5h1420_getsymbolrate(struct s5h1420_state* state);
+static int s5h1420_get_tune_settings(struct dvb_frontend* fe, struct dvb_frontend_tune_settings* fesettings);
+
+
+static int debug = 0;
+#define dprintk if (debug) printk
+
+static int s5h1420_writereg (struct s5h1420_state* state, u8 reg, u8 data)
+{
+	u8 buf [] = { reg, data };
+	struct i2c_msg msg = { .addr = state->config->demod_address, .flags = 0, .buf = buf, .len = 2 };
+	int err;
+
+	if ((err = i2c_transfer (state->i2c, &msg, 1)) != 1) {
+		dprintk ("%s: writereg error (err == %i, reg == 0x%02x, data == 0x%02x)\n", __FUNCTION__, err, reg, data);
+		return -EREMOTEIO;
+	}
+
+	return 0;
+}
+
+static u8 s5h1420_readreg (struct s5h1420_state* state, u8 reg)
+{
+	int ret;
+	u8 b0 [] = { reg };
+	u8 b1 [] = { 0 };
+	struct i2c_msg msg1 = { .addr = state->config->demod_address, .flags = 0, .buf = b0, .len = 1 };
+	struct i2c_msg msg2 = { .addr = state->config->demod_address, .flags = I2C_M_RD, .buf = b1, .len = 1 };
+
+	if ((ret = i2c_transfer (state->i2c, &msg1, 1)) != 1)
+		return ret;
+
+	if ((ret = i2c_transfer (state->i2c, &msg2, 1)) != 1)
+		return ret;
+
+	return b1[0];
+}
+
+static int s5h1420_set_voltage (struct dvb_frontend* fe, fe_sec_voltage_t voltage)
+{
+	struct s5h1420_state* state = fe->demodulator_priv;
+
+	switch(voltage) {
+	case SEC_VOLTAGE_13:
+		s5h1420_writereg(state, 0x3c, (s5h1420_readreg(state, 0x3c) & 0xfe) | 0x02);
+		break;
+
+	case SEC_VOLTAGE_18:
+		s5h1420_writereg(state, 0x3c, s5h1420_readreg(state, 0x3c) | 0x03);
+		break;
+
+	case SEC_VOLTAGE_OFF:
+		s5h1420_writereg(state, 0x3c, s5h1420_readreg(state, 0x3c) & 0xfd);
+		break;
+	}
+
+	return 0;
+}
+
+static int s5h1420_set_tone (struct dvb_frontend* fe, fe_sec_tone_mode_t tone)
+{
+	struct s5h1420_state* state = fe->demodulator_priv;
+
+	switch(tone) {
+	case SEC_TONE_ON:
+		s5h1420_writereg(state, 0x3b, (s5h1420_readreg(state, 0x3b) & 0x74) | 0x08);
+		break;
+
+	case SEC_TONE_OFF:
+		s5h1420_writereg(state, 0x3b, (s5h1420_readreg(state, 0x3b) & 0x74) | 0x01);
+		break;
+	}
+
+	return 0;
+}
+
+static int s5h1420_send_master_cmd (struct dvb_frontend* fe, struct dvb_diseqc_master_cmd* cmd)
+{
+	struct s5h1420_state* state = fe->demodulator_priv;
+	u8 val;
+	int i;
+	unsigned long timeout;
+	int result = 0;
+
+	/* setup for DISEQC */
+	val = s5h1420_readreg(state, 0x3b);
+	s5h1420_writereg(state, 0x3b, 0x02);
+	msleep(15);
+
+	/* write the DISEQC command bytes */
+	for(i=0; i< cmd->msg_len; i++) {
+		s5h1420_writereg(state, 0x3c + i, cmd->msg[i]);
+	}
+
+	/* kick off transmission */
+	s5h1420_writereg(state, 0x3b, s5h1420_readreg(state, 0x3b) | ((cmd->msg_len-1) << 4) | 0x08);
+
+	/* wait for transmission to complete */
+	timeout = jiffies + ((100*HZ) / 1000);
+	while(time_before(jiffies, timeout)) {
+		if (s5h1420_readreg(state, 0x3b) & 0x08)
+			break;
+
+		msleep(5);
+	}
+	if (time_after(jiffies, timeout))
+		result = -ETIMEDOUT;
+
+	/* restore original settings */
+	s5h1420_writereg(state, 0x3b, val);
+	msleep(15);
+	return result;
+}
+
+static int s5h1420_recv_slave_reply (struct dvb_frontend* fe, struct dvb_diseqc_slave_reply* reply)
+{
+	struct s5h1420_state* state = fe->demodulator_priv;
+	u8 val;
+	int i;
+	int length;
+	unsigned long timeout;
+	int result = 0;
+
+	/* setup for DISEQC recieve */
+	val = s5h1420_readreg(state, 0x3b);
+	s5h1420_writereg(state, 0x3b, 0x82); /* FIXME: guess - do we need to set DIS_RDY(0x08) in receive mode? */
+	msleep(15);
+
+	/* wait for reception to complete */
+	timeout = jiffies + ((reply->timeout*HZ) / 1000);
+	while(time_before(jiffies, timeout)) {
+		if (!(s5h1420_readreg(state, 0x3b) & 0x80)) /* FIXME: do we test DIS_RDY(0x08) or RCV_EN(0x80)? */
+			break;
+
+		msleep(5);
+	}
+	if (time_after(jiffies, timeout)) {
+		result = -ETIMEDOUT;
+		goto exit;
+	}
+
+	/* check error flag - FIXME: not sure what this does - docs do not describe
+	 * beyond "error flag for diseqc receive data :( */
+	if (s5h1420_readreg(state, 0x49)) {
+		result = -EIO;
+		goto exit;
+	}
+
+	/* check length */
+	length = (s5h1420_readreg(state, 0x3b) & 0x70) >> 4;
+	if (length > sizeof(reply->msg)) {
+		result = -EOVERFLOW;
+		goto exit;
+	}
+	reply->msg_len = length;
+
+	/* extract data */
+	for(i=0; i< length; i++) {
+		reply->msg[i] = s5h1420_readreg(state, 0x3c + i);
+	}
+
+exit:
+	/* restore original settings */
+	s5h1420_writereg(state, 0x3b, val);
+	msleep(15);
+	return result;
+}
+
+static int s5h1420_send_burst (struct dvb_frontend* fe, fe_sec_mini_cmd_t minicmd)
+{
+	struct s5h1420_state* state = fe->demodulator_priv;
+	u8 val;
+	int result = 0;
+	unsigned long timeout;
+
+	/* setup for tone burst */
+	val = s5h1420_readreg(state, 0x3b);
+	s5h1420_writereg(state, 0x3b, (s5h1420_readreg(state, 0x3b) & 0x70) | 0x01);
+
+	/* set value for B position if requested */
+	if (minicmd == SEC_MINI_B) {
+		s5h1420_writereg(state, 0x3b, s5h1420_readreg(state, 0x3b) | 0x04);
+	}
+	msleep(15);
+
+	/* start transmission */
+	s5h1420_writereg(state, 0x3b, s5h1420_readreg(state, 0x3b) | 0x08);
+
+	/* wait for transmission to complete */
+	timeout = jiffies + ((20*HZ) / 1000);
+	while(time_before(jiffies, timeout)) {
+		if (!(s5h1420_readreg(state, 0x3b) & 0x08))
+			break;
+
+		msleep(5);
+	}
+	if (time_after(jiffies, timeout))
+		result = -ETIMEDOUT;
+
+	/* restore original settings */
+	s5h1420_writereg(state, 0x3b, val);
+	msleep(15);
+	return result;
+}
+
+static fe_status_t s5h1420_get_status_bits(struct s5h1420_state* state)
+{
+	u8 val;
+	fe_status_t status = 0;
+
+	val = s5h1420_readreg(state, 0x14);
+	if (val & 0x02)
+		status |=  FE_HAS_SIGNAL; // FIXME: not sure if this is right
+	if (val & 0x01)
+		status |=  FE_HAS_CARRIER; // FIXME: not sure if this is right
+	val = s5h1420_readreg(state, 0x36);
+	if (val & 0x01)
+		status |=  FE_HAS_VITERBI;
+	if (val & 0x20)
+		status |=  FE_HAS_SYNC;
+	if (status == (FE_HAS_SIGNAL|FE_HAS_CARRIER|FE_HAS_VITERBI|FE_HAS_SYNC))
+		status |=  FE_HAS_LOCK;
+
+	return status;
+}
+
+static int s5h1420_read_status(struct dvb_frontend* fe, fe_status_t* status)
+{
+	struct s5h1420_state* state = fe->demodulator_priv;
+	u8 val;
+
+	if (status == NULL)
+		return -EINVAL;
+
+	/* determine lock state */
+	*status = s5h1420_get_status_bits(state);
+
+	/* fix for FEC 5/6 inversion issue - if it doesn't quite lock, invert the inversion,
+	wait a bit and check again */
+	if (*status == (FE_HAS_SIGNAL|FE_HAS_CARRIER|FE_HAS_VITERBI)) {
+		val = s5h1420_readreg(state, 0x32);
+		if ((val & 0x07) == 0x03) {
+			if (val & 0x08)
+				s5h1420_writereg(state, 0x31, 0x13);
+			else
+				s5h1420_writereg(state, 0x31, 0x1b);
+
+			/* wait a bit then update lock status */
+			mdelay(200);
+			*status = s5h1420_get_status_bits(state);
+		}
+	}
+
+	/* perform post lock setup */
+	if ((*status & FE_HAS_LOCK) && (!state->postlocked)) {
+
+		/* calculate the data rate */
+		u32 tmp = s5h1420_getsymbolrate(state);
+		switch(s5h1420_readreg(state, 0x32) & 0x07) {
+		case 0:
+			tmp = (tmp * 2 * 1) / 2;
+			break;
+
+		case 1:
+			tmp = (tmp * 2 * 2) / 3;
+			break;
+
+		case 2:
+			tmp = (tmp * 2 * 3) / 4;
+			break;
+
+		case 3:
+			tmp = (tmp * 2 * 5) / 6;
+			break;
+
+		case 4:
+			tmp = (tmp * 2 * 6) / 7;
+			break;
+
+		case 5:
+			tmp = (tmp * 2 * 7) / 8;
+			break;
+		}
+		tmp = state->fclk / tmp;
+
+		/* set the MPEG_CLK_INTL for the calculated data rate */
+		if (tmp < 4)
+			val = 0x00;
+		else if (tmp < 8)
+			val = 0x01;
+		else if (tmp < 12)
+			val = 0x02;
+		else if (tmp < 16)
+			val = 0x03;
+		else if (tmp < 24)
+			val = 0x04;
+		else if (tmp < 32)
+			val = 0x05;
+		else
+			val = 0x06;
+		s5h1420_writereg(state, 0x22, val);
+
+		/* DC freeze */
+		s5h1420_writereg(state, 0x1f, s5h1420_readreg(state, 0x1f) | 0x01);
+
+		/* kicker disable + remove DC offset */
+		s5h1420_writereg(state, 0x05, s5h1420_readreg(state, 0x05) & 0x6f);
+
+		/* post-lock processing has been done! */
+		state->postlocked = 1;
+	}
+
+	return 0;
+}
+
+static int s5h1420_read_ber(struct dvb_frontend* fe, u32* ber)
+{
+	struct s5h1420_state* state = fe->demodulator_priv;
+
+	s5h1420_writereg(state, 0x46, 0x1d);
+	mdelay(25);
+	return (s5h1420_readreg(state, 0x48) << 8) | s5h1420_readreg(state, 0x47);
+}
+
+static int s5h1420_read_signal_strength(struct dvb_frontend* fe, u16* strength)
+{
+	struct s5h1420_state* state = fe->demodulator_priv;
+
+	u8 val = 0xff - s5h1420_readreg(state, 0x15);
+
+	return (int) ((val << 8) | val);
+}
+
+static int s5h1420_read_ucblocks(struct dvb_frontend* fe, u32* ucblocks)
+{
+	struct s5h1420_state* state = fe->demodulator_priv;
+
+	s5h1420_writereg(state, 0x46, 0x1f);
+	mdelay(25);
+	return (s5h1420_readreg(state, 0x48) << 8) | s5h1420_readreg(state, 0x47);
+}
+
+static void s5h1420_reset(struct s5h1420_state* state)
+{
+	s5h1420_writereg (state, 0x01, 0x08);
+	s5h1420_writereg (state, 0x01, 0x00);
+	udelay(10);
+}
+
+static void s5h1420_setsymbolrate(struct s5h1420_state* state, struct dvb_frontend_parameters *p)
+{
+	u64 val;
+
+	val = (p->u.qpsk.symbol_rate / 1000) * (1<<24);
+	if (p->u.qpsk.symbol_rate <= 21000000) {
+		val *= 2;
+	}
+	do_div(val, (state->fclk / 1000));
+
+	s5h1420_writereg(state, 0x09, s5h1420_readreg(state, 0x09) & 0x7f);
+	s5h1420_writereg(state, 0x11, val >> 16);
+	s5h1420_writereg(state, 0x12, val >> 8);
+	s5h1420_writereg(state, 0x13, val & 0xff);
+	s5h1420_writereg(state, 0x09, s5h1420_readreg(state, 0x09) | 0x80);
+}
+
+static u32 s5h1420_getsymbolrate(struct s5h1420_state* state)
+{
+	u64 val;
+	int sampling = 2;
+
+	if (s5h1420_readreg(state, 0x05) & 0x2)
+		sampling = 1;
+
+	s5h1420_writereg(state, 0x06, s5h1420_readreg(state, 0x06) | 0x08);
+	val  = s5h1420_readreg(state, 0x11) << 16;
+	val |= s5h1420_readreg(state, 0x12) << 8;
+	val |= s5h1420_readreg(state, 0x13);
+	s5h1420_writereg(state, 0x06, s5h1420_readreg(state, 0x06) & 0xf7);
+
+	val *= (state->fclk / 1000);
+	do_div(val, ((1<<24) * sampling));
+
+	return (u32) (val * 1000);
+}
+
+static void s5h1420_setfreqoffset(struct s5h1420_state* state, int freqoffset)
+{
+	int val;
+
+	/* remember freqoffset is in kHz, but the chip wants the offset in Hz, so
+	 * divide fclk by 1000000 to get the correct value. */
+	val = -(int) ((freqoffset * (1<<24)) / (state->fclk / 1000000));
+
+	s5h1420_writereg(state, 0x09, s5h1420_readreg(state, 0x09) & 0xbf);
+	s5h1420_writereg(state, 0x0e, val >> 16);
+	s5h1420_writereg(state, 0x0f, val >> 8);
+	s5h1420_writereg(state, 0x10, val & 0xff);
+	s5h1420_writereg(state, 0x09, s5h1420_readreg(state, 0x09) | 0x40);
+}
+
+static int s5h1420_getfreqoffset(struct s5h1420_state* state)
+{
+	int val;
+
+	s5h1420_writereg(state, 0x06, s5h1420_readreg(state, 0x06) | 0x08);
+	val  = s5h1420_readreg(state, 0x0e) << 16;
+	val |= s5h1420_readreg(state, 0x0f) << 8;
+	val |= s5h1420_readreg(state, 0x10);
+	s5h1420_writereg(state, 0x06, s5h1420_readreg(state, 0x06) & 0xf7);
+
+	if (val & 0x800000)
+		val |= 0xff000000;
+
+	/* remember freqoffset is in kHz, but the chip wants the offset in Hz, so
+	 * divide fclk by 1000000 to get the correct value. */
+	val = - ((val * (state->fclk/1000000)) / (1<<24));
+
+	return val;
+}
+
+static void s5h1420_setfec(struct s5h1420_state* state, struct dvb_frontend_parameters *p)
+{
+	if ((p->u.qpsk.fec_inner == FEC_AUTO) || (p->inversion == INVERSION_AUTO)) {
+		s5h1420_writereg(state, 0x31, 0x00);
+		s5h1420_writereg(state, 0x30, 0x3f);
+	} else {
+		switch(p->u.qpsk.fec_inner) {
+		case FEC_1_2:
+			s5h1420_writereg(state, 0x31, 0x10);
+			s5h1420_writereg(state, 0x30, 0x01);
+			break;
+
+		case FEC_2_3:
+			s5h1420_writereg(state, 0x31, 0x11);
+			s5h1420_writereg(state, 0x30, 0x02);
+			break;
+
+		case FEC_3_4:
+			s5h1420_writereg(state, 0x31, 0x12);
+			s5h1420_writereg(state, 0x30, 0x04);
+			break;
+
+		case FEC_5_6:
+			s5h1420_writereg(state, 0x31, 0x13);
+			s5h1420_writereg(state, 0x30, 0x08);
+			break;
+
+		case FEC_6_7:
+			s5h1420_writereg(state, 0x31, 0x14);
+			s5h1420_writereg(state, 0x30, 0x10);
+			break;
+
+		case FEC_7_8:
+			s5h1420_writereg(state, 0x31, 0x15);
+			s5h1420_writereg(state, 0x30, 0x20);
+			break;
+
+		default:
+			return;
+		}
+	}
+}
+
+static fe_code_rate_t s5h1420_getfec(struct s5h1420_state* state)
+{
+	switch(s5h1420_readreg(state, 0x32) & 0x07) {
+	case 0:
+		return FEC_1_2;
+
+	case 1:
+		return FEC_2_3;
+
+	case 2:
+		return FEC_3_4;
+
+	case 3:
+		return FEC_5_6;
+
+	case 4:
+		return FEC_6_7;
+
+	case 5:
+		return FEC_7_8;
+	}
+
+	return FEC_NONE;
+}
+
+static void s5h1420_setinversion(struct s5h1420_state* state, struct dvb_frontend_parameters *p)
+{
+	if ((p->u.qpsk.fec_inner == FEC_AUTO) || (p->inversion == INVERSION_AUTO)) {
+		s5h1420_writereg(state, 0x31, 0x00);
+		s5h1420_writereg(state, 0x30, 0x3f);
+	} else {
+		u8 tmp = s5h1420_readreg(state, 0x31) & 0xf7;
+			tmp |= 0x10;
+
+		if (p->inversion == INVERSION_ON)
+			tmp |= 0x80;
+
+		s5h1420_writereg(state, 0x31, tmp);
+	}
+}
+
+static fe_spectral_inversion_t s5h1420_getinversion(struct s5h1420_state* state)
+{
+	if (s5h1420_readreg(state, 0x32) & 0x08)
+		return INVERSION_ON;
+
+	return INVERSION_OFF;
+}
+
+static int s5h1420_set_frontend(struct dvb_frontend* fe, struct dvb_frontend_parameters *p)
+{
+	struct s5h1420_state* state = fe->demodulator_priv;
+	u32 frequency_delta;
+	struct dvb_frontend_tune_settings fesettings;
+
+	/* check if we should do a fast-tune */
+	memcpy(&fesettings.parameters, p, sizeof(struct dvb_frontend_parameters));
+	s5h1420_get_tune_settings(fe, &fesettings);
+	frequency_delta = p->frequency - state->tunedfreq;
+	if ((frequency_delta > -fesettings.max_drift) && (frequency_delta < fesettings.max_drift) &&
+	    (frequency_delta != 0) &&
+	    (state->fec_inner == p->u.qpsk.fec_inner) &&
+	    (state->symbol_rate == p->u.qpsk.symbol_rate)) {
+
+		s5h1420_setfreqoffset(state, frequency_delta);
+		return 0;
+	}
+
+	/* first of all, software reset */
+	s5h1420_reset(state);
+
+	/* set tuner PLL */
+	if (state->config->pll_set) {
+		s5h1420_writereg (state, 0x02, s5h1420_readreg(state,0x02) | 1);
+		state->config->pll_set(fe, p, &state->tunedfreq);
+		s5h1420_writereg (state, 0x02, s5h1420_readreg(state,0x02) & 0xfe);
+	}
+
+	/* set s5h1420 fclk PLL according to desired symbol rate */
+	if (p->u.qpsk.symbol_rate > 28000000) {
+		state->fclk = 88000000;
+		s5h1420_writereg(state, 0x03, 0x50);
+		s5h1420_writereg(state, 0x04, 0x40);
+		s5h1420_writereg(state, 0x05, 0xae);
+	} else if (p->u.qpsk.symbol_rate > 21000000) {
+		state->fclk = 59000000;
+		s5h1420_writereg(state, 0x03, 0x33);
+		s5h1420_writereg(state, 0x04, 0x40);
+		s5h1420_writereg(state, 0x05, 0xae);
+	} else {
+		state->fclk = 88000000;
+		s5h1420_writereg(state, 0x03, 0x50);
+		s5h1420_writereg(state, 0x04, 0x40);
+		s5h1420_writereg(state, 0x05, 0xac);
+	}
+
+	/* set misc registers */
+	s5h1420_writereg(state, 0x02, 0x00);
+	s5h1420_writereg(state, 0x07, 0xb0);
+	s5h1420_writereg(state, 0x0a, 0x67);
+	s5h1420_writereg(state, 0x0b, 0x78);
+	s5h1420_writereg(state, 0x0c, 0x48);
+	s5h1420_writereg(state, 0x0d, 0x6b);
+	s5h1420_writereg(state, 0x2e, 0x8e);
+	s5h1420_writereg(state, 0x35, 0x33);
+	s5h1420_writereg(state, 0x38, 0x01);
+	s5h1420_writereg(state, 0x39, 0x7d);
+	s5h1420_writereg(state, 0x3a, (state->fclk + (TONE_FREQ * 32) - 1) / (TONE_FREQ * 32));
+	s5h1420_writereg(state, 0x3c, 0x00);
+	s5h1420_writereg(state, 0x45, 0x61);
+	s5h1420_writereg(state, 0x46, 0x1d);
+
+	/* start QPSK */
+	s5h1420_writereg(state, 0x05, s5h1420_readreg(state, 0x05) | 1);
+
+	/* set the frequency offset to adjust for PLL inaccuracy */
+	s5h1420_setfreqoffset(state, p->frequency - state->tunedfreq);
+
+	/* set the reset of the parameters */
+	s5h1420_setsymbolrate(state, p);
+	s5h1420_setinversion(state, p);
+	s5h1420_setfec(state, p);
+
+	state->fec_inner = p->u.qpsk.fec_inner;
+	state->symbol_rate = p->u.qpsk.symbol_rate;
+	state->postlocked = 0;
+	return 0;
+}
+
+static int s5h1420_get_frontend(struct dvb_frontend* fe, struct dvb_frontend_parameters *p)
+{
+	struct s5h1420_state* state = fe->demodulator_priv;
+
+	p->frequency = state->tunedfreq + s5h1420_getfreqoffset(state);
+	p->inversion = s5h1420_getinversion(state);
+	p->u.qpsk.symbol_rate = s5h1420_getsymbolrate(state);
+	p->u.qpsk.fec_inner = s5h1420_getfec(state);
+
+	return 0;
+}
+
+static int s5h1420_get_tune_settings(struct dvb_frontend* fe, struct dvb_frontend_tune_settings* fesettings)
+{
+	if (fesettings->parameters.u.qpsk.symbol_rate > 20000000) {
+		fesettings->min_delay_ms = 50;
+		fesettings->step_size = 2000;
+		fesettings->max_drift = 8000;
+	} else if (fesettings->parameters.u.qpsk.symbol_rate > 12000000) {
+		fesettings->min_delay_ms = 100;
+		fesettings->step_size = 1500;
+		fesettings->max_drift = 9000;
+	} else if (fesettings->parameters.u.qpsk.symbol_rate > 8000000) {
+		fesettings->min_delay_ms = 100;
+		fesettings->step_size = 1000;
+		fesettings->max_drift = 8000;
+	} else if (fesettings->parameters.u.qpsk.symbol_rate > 4000000) {
+		fesettings->min_delay_ms = 100;
+		fesettings->step_size = 500;
+		fesettings->max_drift = 7000;
+	} else if (fesettings->parameters.u.qpsk.symbol_rate > 2000000) {
+		fesettings->min_delay_ms = 200;
+		fesettings->step_size = (fesettings->parameters.u.qpsk.symbol_rate / 8000);
+		fesettings->max_drift = 14 * fesettings->step_size;
+	} else {
+		fesettings->min_delay_ms = 200;
+		fesettings->step_size = (fesettings->parameters.u.qpsk.symbol_rate / 8000);
+		fesettings->max_drift = 18 * fesettings->step_size;
+	}
+
+	return 0;
+}
+
+static int s5h1420_init (struct dvb_frontend* fe)
+{
+	struct s5h1420_state* state = fe->demodulator_priv;
+
+	/* disable power down and do reset */
+	s5h1420_writereg(state, 0x02, 0x10);
+	msleep(10);
+	s5h1420_reset(state);
+
+	/* init PLL */
+	if (state->config->pll_init) {
+		s5h1420_writereg (state, 0x02, s5h1420_readreg(state,0x02) | 1);
+		state->config->pll_init(fe);
+		s5h1420_writereg (state, 0x02, s5h1420_readreg(state,0x02) & 0xfe);
+	}
+
+	return 0;
+}
+
+static int s5h1420_sleep(struct dvb_frontend* fe)
+{
+	struct s5h1420_state* state = fe->demodulator_priv;
+
+	return s5h1420_writereg(state, 0x02, 0x12);
+}
+
+static void s5h1420_release(struct dvb_frontend* fe)
+{
+	struct s5h1420_state* state = fe->demodulator_priv;
+	kfree(state);
+}
+
+static struct dvb_frontend_ops s5h1420_ops;
+
+struct dvb_frontend* s5h1420_attach(const struct s5h1420_config* config, struct i2c_adapter* i2c)
+{
+	struct s5h1420_state* state = NULL;
+	u8 identity;
+
+	/* allocate memory for the internal state */
+	state = kmalloc(sizeof(struct s5h1420_state), GFP_KERNEL);
+	if (state == NULL)
+		goto error;
+
+	/* setup the state */
+	state->config = config;
+	state->i2c = i2c;
+	memcpy(&state->ops, &s5h1420_ops, sizeof(struct dvb_frontend_ops));
+	state->postlocked = 0;
+	state->fclk = 88000000;
+	state->tunedfreq = 0;
+	state->fec_inner = FEC_NONE;
+	state->symbol_rate = 0;
+
+	/* check if the demod is there + identify it */
+	identity = s5h1420_readreg(state, 0x00);
+	if (identity != 0x03)
+		goto error;
+
+	/* create dvb_frontend */
+	state->frontend.ops = &state->ops;
+	state->frontend.demodulator_priv = state;
+	return &state->frontend;
+
+error:
+	kfree(state);
+	return NULL;
+}
+
+static struct dvb_frontend_ops s5h1420_ops = {
+
+	.info = {
+		.name     = "Samsung S5H1420 DVB-S",
+		.type     = FE_QPSK,
+		.frequency_min    = 950000,
+		.frequency_max    = 2150000,
+		.frequency_stepsize = 125,     /* kHz for QPSK frontends */
+		.frequency_tolerance  = 29500,
+		.symbol_rate_min  = 1000000,
+		.symbol_rate_max  = 45000000,
+		/*  .symbol_rate_tolerance  = ???,*/
+		.caps = FE_CAN_INVERSION_AUTO |
+		FE_CAN_FEC_1_2 | FE_CAN_FEC_2_3 | FE_CAN_FEC_3_4 |
+		FE_CAN_FEC_5_6 | FE_CAN_FEC_6_7 | FE_CAN_FEC_7_8 | FE_CAN_FEC_AUTO |
+		FE_CAN_QPSK
+	},
+
+	.release = s5h1420_release,
+
+	.init = s5h1420_init,
+	.sleep = s5h1420_sleep,
+
+	.set_frontend = s5h1420_set_frontend,
+	.get_frontend = s5h1420_get_frontend,
+	.get_tune_settings = s5h1420_get_tune_settings,
+
+	.read_status = s5h1420_read_status,
+	.read_ber = s5h1420_read_ber,
+	.read_signal_strength = s5h1420_read_signal_strength,
+	.read_ucblocks = s5h1420_read_ucblocks,
+
+	.diseqc_send_master_cmd = s5h1420_send_master_cmd,
+	.diseqc_recv_slave_reply = s5h1420_recv_slave_reply,
+	.diseqc_send_burst = s5h1420_send_burst,
+	.set_tone = s5h1420_set_tone,
+	.set_voltage = s5h1420_set_voltage,
+};
+
+module_param(debug, int, 0644);
+
+MODULE_DESCRIPTION("Samsung S5H1420 DVB-S Demodulator driver");
+MODULE_AUTHOR("Andrew de Quincey");
+MODULE_LICENSE("GPL");
+
+EXPORT_SYMBOL(s5h1420_attach);
Index: linux-2.6.12-git8/drivers/media/dvb/frontends/s5h1420.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.12-git8/drivers/media/dvb/frontends/s5h1420.h	2005-06-27 13:24:15.000000000 +0200
@@ -0,0 +1,41 @@
+/*
+    Driver for S5H1420 QPSK Demodulators
+
+    Copyright (C) 2005 Andrew de Quincey <adq_dvb@lidskialf.net>
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
+#ifndef S5H1420_H
+#define S5H1420_H
+
+#include <linux/dvb/frontend.h>
+
+struct s5h1420_config
+{
+	/* the demodulator's i2c address */
+	u8 demod_address;
+
+	/* PLL maintenance */
+	int (*pll_init)(struct dvb_frontend* fe);
+	int (*pll_set)(struct dvb_frontend* fe, struct dvb_frontend_parameters* params, u32* freqout);
+};
+
+extern struct dvb_frontend* s5h1420_attach(const struct s5h1420_config* config,
+             struct i2c_adapter* i2c);
+
+#endif // S5H1420_H
Index: linux-2.6.12-git8/drivers/media/dvb/ttpci/Kconfig
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/ttpci/Kconfig	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/ttpci/Kconfig	2005-06-27 13:24:15.000000000 +0200
@@ -12,7 +12,7 @@ config DVB_AV7110
 	select DVB_STV0297
 	select DVB_L64781
 	help
-	  Support for SAA7146 and AV7110 based DVB cards as produced 
+	  Support for SAA7146 and AV7110 based DVB cards as produced
 	  by Fujitsu-Siemens, Technotrend, Hauppauge and others.
 
 	  This driver only supports the fullfeatured cards with
@@ -33,7 +33,7 @@ config DVB_AV7110_FIRMWARE
 	  If you want to compile the firmware into the driver you need to say
 	  Y here and provide the correct path of the firmware. You need this
 	  option if you want to compile the whole driver statically into the
-	  kernel. 
+	  kernel.
 
 	  All other people say N.
 
@@ -66,6 +66,7 @@ config DVB_BUDGET
 	select DVB_L64781
 	select DVB_TDA8083
 	select DVB_TDA10021
+	select DVB_S5H1420
 	help
 	  Support for simple SAA7146 based DVB cards
 	  (so called Budget- or Nova-PCI cards) without onboard
@@ -119,9 +120,9 @@ config DVB_BUDGET_PATCH
 	select DVB_VES1X93
 	select DVB_TDA8083
 	help
-	  Support for Budget Patch (full TS) modification on 
+	  Support for Budget Patch (full TS) modification on
 	  SAA7146+AV7110 based cards (DVB-S cards). This
-	  driver doesn't use onboard MPEG2 decoder. The 
+	  driver doesn't use onboard MPEG2 decoder. The
 	  card is driven in Budget-only mode. Card is
 	  required to have loaded firmware to tune properly.
 	  Firmware can be loaded by insertion and removal of
Index: linux-2.6.12-git8/drivers/media/dvb/ttpci/budget.c
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/ttpci/budget.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/ttpci/budget.c	2005-06-27 13:24:15.000000000 +0200
@@ -40,6 +40,7 @@
 #include "ves1820.h"
 #include "l64781.h"
 #include "tda8083.h"
+#include "s5h1420.h"
 
 static void Set22K (struct budget *budget, int state)
 {
@@ -177,6 +178,62 @@ static int budget_diseqc_send_burst(stru
 	return 0;
 }
 
+static int lnbp21_set_voltage(struct dvb_frontend* fe, fe_sec_voltage_t voltage)
+{
+	struct budget* budget = (struct budget*) fe->dvb->priv;
+	u8 buf;
+	struct i2c_msg msg = { .addr = 0x08, .flags = I2C_M_RD, .buf = &buf, .len = sizeof(buf) };
+
+	if (i2c_transfer (&budget->i2c_adap, &msg, 1) != 1) return -EIO;
+
+	switch(voltage) {
+	case SEC_VOLTAGE_13:
+		buf = (buf & 0xf7) | 0x04;
+		break;
+
+	case SEC_VOLTAGE_18:
+		buf = (buf & 0xf7) | 0x0c;
+		break;
+
+	case SEC_VOLTAGE_OFF:
+		buf = buf & 0xf0;
+		break;
+	}
+
+	msg.flags = 0;
+	if (i2c_transfer (&budget->i2c_adap, &msg, 1) != 1) return -EIO;
+
+	return 0;
+}
+
+static int lnbp21_enable_high_lnb_voltage(struct dvb_frontend* fe, int arg)
+{
+	struct budget* budget = (struct budget*) fe->dvb->priv;
+	u8 buf;
+	struct i2c_msg msg = { .addr = 0x08, .flags = I2C_M_RD, .buf = &buf, .len = sizeof(buf) };
+
+	if (i2c_transfer (&budget->i2c_adap, &msg, 1) != 1) return -EIO;
+
+	if (arg) {
+		buf = buf | 0x10;
+	} else {
+		buf = buf & 0xef;
+	}
+
+	msg.flags = 0;
+	if (i2c_transfer (&budget->i2c_adap, &msg, 1) != 1) return -EIO;
+
+	return 0;
+}
+
+static void lnbp21_init(struct budget* budget)
+{
+	u8 buf = 0x00;
+	struct i2c_msg msg = { .addr = 0x08, .flags = 0, .buf = &buf, .len = sizeof(buf) };
+
+	i2c_transfer (&budget->i2c_adap, &msg, 1);
+}
+
 static int alps_bsrv2_pll_set(struct dvb_frontend* fe, struct dvb_frontend_parameters* params)
 {
 	struct budget* budget = (struct budget*) fe->dvb->priv;
@@ -395,6 +452,38 @@ static struct tda8083_config grundig_295
 	.pll_set = grundig_29504_451_pll_set,
 };
 
+static int s5h1420_pll_set(struct dvb_frontend* fe, struct dvb_frontend_parameters* params, u32* freqout)
+{
+	struct budget* budget = (struct budget*) fe->dvb->priv;
+	u32 div;
+	u8 data[4];
+	struct i2c_msg msg = { .addr = 0x61, .flags = 0, .buf = data, .len = sizeof(data) };
+
+	div = params->frequency / 1000;
+	data[0] = (div >> 8) & 0x7f;
+	data[1] = div & 0xff;
+	data[2] = 0xc2;
+
+	if (div < 1450)
+		data[3] = 0x00;
+	else if (div < 1850)
+		data[3] = 0x40;
+	else if (div < 2000)
+		data[3] = 0x80;
+	else
+		data[3] = 0xc0;
+
+	if (i2c_transfer (&budget->i2c_adap, &msg, 1) != 1) return -EIO;
+
+	*freqout = div * 1000;
+	return 0;
+}
+
+static struct s5h1420_config s5h1420_config = {
+	.demod_address = 0x53,
+	.pll_set = s5h1420_pll_set,
+};
+
 static u8 read_pwm(struct budget* budget)
 {
 	u8 b = 0xff;
@@ -459,6 +548,15 @@ static void frontend_init(struct budget 
 			break;
 		}
 		break;
+
+	case 0x1016: // Hauppauge/TT Nova-S SE (samsung s5h1420/????(tda8260))
+		budget->dvb_frontend = s5h1420_attach(&s5h1420_config, &budget->i2c_adap);
+		if (budget->dvb_frontend) {
+			budget->dvb_frontend->ops->set_voltage = lnbp21_set_voltage;
+			budget->dvb_frontend->ops->enable_high_lnb_voltage = lnbp21_enable_high_lnb_voltage;
+			lnbp21_init(budget);
+			break;
+		}
 	}
 
 	if (budget->dvb_frontend == NULL) {
@@ -532,6 +630,7 @@ static struct pci_device_id pci_tbl[] = 
 	MAKE_EXTENSION_PCI(ttbc,  0x13c2, 0x1004),
 	MAKE_EXTENSION_PCI(ttbt,  0x13c2, 0x1005),
 	MAKE_EXTENSION_PCI(satel, 0x13c2, 0x1013),
+	MAKE_EXTENSION_PCI(ttbs,  0x13c2, 0x1016),
 	MAKE_EXTENSION_PCI(fsacs1,0x1131, 0x4f60),
 	MAKE_EXTENSION_PCI(fsacs0,0x1131, 0x4f61),
 	{

--

