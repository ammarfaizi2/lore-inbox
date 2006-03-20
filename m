Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966634AbWCTPTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966634AbWCTPTO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966628AbWCTPTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:19:12 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:21986 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966624AbWCTPTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:19:09 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Chris Pascoe <c.pascoe@itee.uq.edu.au>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 135/141] V4L/DVB (3408): DViCO FusionHDTV DVB-T Hybrid and
	ZL10353-based FusionHDTV DVB-T Plus support
Date: Mon, 20 Mar 2006 12:08:59 -0300
Message-id: <20060320150859.PS523273000135@infradead.org>
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

From: Chris Pascoe <c.pascoe@itee.uq.edu.au>
Date: 1141126499 -0300

Add support for the FE6600 tuner used on the DVB-T Hybrid board.
Add support for the Zarlink ZL10353 DVB-T demodulator, which supersedes the
MT352, used on the DViCO FusionHDTV DVB-T Hybrid and later model Plus boards.

Signed-off-by: Chris Pascoe <c.pascoe@itee.uq.edu.au>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/Documentation/video4linux/CARDLIST.cx88 b/Documentation/video4linux/CARDLIST.cx88
diff --git a/Documentation/video4linux/CARDLIST.cx88 b/Documentation/video4linux/CARDLIST.cx88
index d852ad4..3b39a91 100644
--- a/Documentation/video4linux/CARDLIST.cx88
+++ b/Documentation/video4linux/CARDLIST.cx88
@@ -44,3 +44,4 @@
  43 -> KWorld/VStream XPert DVB-T with cx22702             [17de:08a1]
  44 -> DViCO FusionHDTV DVB-T Dual Digital                 [18ac:db50,18ac:db54]
  45 -> KWorld HardwareMpegTV XPert                         [17de:0840]
+ 46 -> DViCO FusionHDTV DVB-T Hybrid                       [18ac:db40,18ac:db44]
diff --git a/Documentation/video4linux/CARDLIST.tuner b/Documentation/video4linux/CARDLIST.tuner
diff --git a/Documentation/video4linux/CARDLIST.tuner b/Documentation/video4linux/CARDLIST.tuner
index de48438..ab344c9 100644
--- a/Documentation/video4linux/CARDLIST.tuner
+++ b/Documentation/video4linux/CARDLIST.tuner
@@ -70,3 +70,4 @@ tuner=68 - Philips TUV1236D ATSC/NTSC du
 tuner=69 - Tena TNF 5335 MF
 tuner=70 - Samsung TCPN 2121P30A
 tuner=71 - Xceive xc3028
+tuner=72 - FE6600
diff --git a/drivers/media/dvb/frontends/Kconfig b/drivers/media/dvb/frontends/Kconfig
diff --git a/drivers/media/dvb/frontends/Kconfig b/drivers/media/dvb/frontends/Kconfig
index c676b1e..a1a894d 100644
--- a/drivers/media/dvb/frontends/Kconfig
+++ b/drivers/media/dvb/frontends/Kconfig
@@ -116,6 +116,12 @@ config DVB_MT352
 	help
 	  A DVB-T tuner module. Say Y when you want to support this frontend.
 
+config DVB_ZL10353
+	tristate "Zarlink ZL10353 based"
+	depends on DVB_CORE
+	help
+	  A DVB-T tuner module. Say Y when you want to support this frontend.
+
 config DVB_DIB3000MB
 	tristate "DiBcom 3000M-B"
 	depends on DVB_CORE
diff --git a/drivers/media/dvb/frontends/Makefile b/drivers/media/dvb/frontends/Makefile
diff --git a/drivers/media/dvb/frontends/Makefile b/drivers/media/dvb/frontends/Makefile
index 1af769c..d09b607 100644
--- a/drivers/media/dvb/frontends/Makefile
+++ b/drivers/media/dvb/frontends/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_DVB_TDA1004X) += tda1004x.o
 obj-$(CONFIG_DVB_SP887X) += sp887x.o
 obj-$(CONFIG_DVB_NXT6000) += nxt6000.o
 obj-$(CONFIG_DVB_MT352) += mt352.o
+obj-$(CONFIG_DVB_ZL10353) += zl10353.o
 obj-$(CONFIG_DVB_CX22702) += cx22702.o
 obj-$(CONFIG_DVB_TDA10021) += tda10021.o
 obj-$(CONFIG_DVB_STV0297) += stv0297.o
diff --git a/drivers/media/dvb/frontends/dvb-pll.c b/drivers/media/dvb/frontends/dvb-pll.c
diff --git a/drivers/media/dvb/frontends/dvb-pll.c b/drivers/media/dvb/frontends/dvb-pll.c
index 4f68253..8a4c904 100644
--- a/drivers/media/dvb/frontends/dvb-pll.c
+++ b/drivers/media/dvb/frontends/dvb-pll.c
@@ -404,6 +404,21 @@ struct dvb_pll_desc dvb_pll_philips_td13
 };
 EXPORT_SYMBOL(dvb_pll_philips_td1316);
 
+/* FE6600 used on DViCO Hybrid */
+struct dvb_pll_desc dvb_pll_unknown_fe6600 = {
+	.name = "FE6600",
+	.min =  44250000,
+	.max = 858000000,
+	.count = 4,
+	.entries = {
+		{ 250000000, 36213333, 166667, 0xb4, 0x12 },
+		{ 455000000, 36213333, 166667, 0xfe, 0x11 },
+		{ 775500000, 36213333, 166667, 0xbc, 0x18 },
+		{ 999999999, 36213333, 166667, 0xf4, 0x18 },
+	}
+};
+EXPORT_SYMBOL(dvb_pll_unknown_fe6600);
+
 /* ----------------------------------------------------------- */
 /* code                                                        */
 
diff --git a/drivers/media/dvb/frontends/dvb-pll.h b/drivers/media/dvb/frontends/dvb-pll.h
diff --git a/drivers/media/dvb/frontends/dvb-pll.h b/drivers/media/dvb/frontends/dvb-pll.h
index 56c3cd7..8a7f0b9 100644
--- a/drivers/media/dvb/frontends/dvb-pll.h
+++ b/drivers/media/dvb/frontends/dvb-pll.h
@@ -42,6 +42,8 @@ extern struct dvb_pll_desc dvb_pll_samsu
 extern struct dvb_pll_desc dvb_pll_philips_sd1878_tda8261;
 extern struct dvb_pll_desc dvb_pll_philips_td1316;
 
+extern struct dvb_pll_desc dvb_pll_unknown_fe6600;
+
 int dvb_pll_configure(struct dvb_pll_desc *desc, u8 *buf,
 		      u32 freq, int bandwidth);
 
diff --git a/drivers/media/dvb/frontends/zl10353.c b/drivers/media/dvb/frontends/zl10353.c
diff --git a/drivers/media/dvb/frontends/zl10353.c b/drivers/media/dvb/frontends/zl10353.c
new file mode 100644
index 0000000..23846c4
--- /dev/null
+++ b/drivers/media/dvb/frontends/zl10353.c
@@ -0,0 +1,311 @@
+/*
+ * Driver for Zarlink DVB-T ZL10353 demodulator
+ *
+ * Copyright (C) 2006 Christopher Pascoe <c.pascoe@itee.uq.edu.au>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.=
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+
+#include "dvb_frontend.h"
+#include "zl10353_priv.h"
+#include "zl10353.h"
+
+struct zl10353_state {
+	struct i2c_adapter *i2c;
+	struct dvb_frontend frontend;
+	struct dvb_frontend_ops ops;
+
+	struct zl10353_config config;
+};
+
+static int debug_regs = 0;
+
+static int zl10353_single_write(struct dvb_frontend *fe, u8 reg, u8 val)
+{
+	struct zl10353_state *state = fe->demodulator_priv;
+	u8 buf[2] = { reg, val };
+	struct i2c_msg msg = { .addr = state->config.demod_address, .flags = 0,
+			       .buf = buf, .len = 2 };
+	int err = i2c_transfer(state->i2c, &msg, 1);
+	if (err != 1) {
+		printk("zl10353: write to reg %x failed (err = %d)!\n", reg, err);
+		return err;
+	}
+	return 0;
+}
+
+int zl10353_write(struct dvb_frontend *fe, u8 *ibuf, int ilen)
+{
+	int err, i;
+	for (i = 0; i < ilen - 1; i++)
+		if ((err = zl10353_single_write(fe, ibuf[0] + i, ibuf[i + 1])))
+			return err;
+
+	return 0;
+}
+
+static int zl10353_read_register(struct zl10353_state *state, u8 reg)
+{
+	int ret;
+	u8 b0[1] = { reg };
+	u8 b1[1] = { 0 };
+	struct i2c_msg msg[2] = { { .addr = state->config.demod_address,
+				    .flags = 0,
+				    .buf = b0, .len = 1 },
+				  { .addr = state->config.demod_address,
+				    .flags = I2C_M_RD,
+				    .buf = b1, .len = 1 } };
+
+	ret = i2c_transfer(state->i2c, msg, 2);
+
+	if (ret != 2) {
+		printk("%s: readreg error (reg=%d, ret==%i)\n",
+		       __FUNCTION__, reg, ret);
+		return ret;
+	}
+
+	return b1[0];
+}
+
+void zl10353_dump_regs(struct dvb_frontend *fe)
+{
+	struct zl10353_state *state = fe->demodulator_priv;
+	char buf[52], buf2[4];
+	int ret;
+	u8 reg;
+
+	/* Dump all registers. */
+	for (reg = 0; ; reg++) {
+		if (reg % 16 == 0) {
+			if (reg)
+				printk(KERN_DEBUG "%s\n", buf);
+			sprintf(buf, "%02x: ", reg);
+		}
+		ret = zl10353_read_register(state, reg);
+		if (ret >= 0)
+			sprintf(buf2, "%02x ", (u8)ret);
+		else
+			strcpy(buf2, "-- ");
+		strcat(buf, buf2);
+		if (reg == 0xff)
+			break;
+	}
+	printk(KERN_DEBUG "%s\n", buf);
+}
+
+static int zl10353_sleep(struct dvb_frontend *fe)
+{
+	static u8 zl10353_softdown[] = { 0x50, 0x0C, 0x44 };
+
+	zl10353_write(fe, zl10353_softdown, sizeof(zl10353_softdown));
+	return 0;
+}
+
+static int zl10353_set_parameters(struct dvb_frontend *fe,
+				  struct dvb_frontend_parameters *param)
+{
+	struct zl10353_state *state = fe->demodulator_priv;
+	u8 pllbuf[6] = { 0x67 };
+
+	/* These settings set "auto-everything" and start the FSM. */
+	zl10353_single_write(fe, 0x55, 0x80);
+	udelay(200);
+	zl10353_single_write(fe, 0xEA, 0x01);
+	udelay(200);
+	zl10353_single_write(fe, 0xEA, 0x00);
+
+	zl10353_single_write(fe, 0x56, 0x28);
+	zl10353_single_write(fe, 0x89, 0x20);
+	zl10353_single_write(fe, 0x5E, 0x00);
+	zl10353_single_write(fe, 0x65, 0x5A);
+	zl10353_single_write(fe, 0x66, 0xE9);
+	zl10353_single_write(fe, 0x62, 0x0A);
+
+	state->config.pll_set(fe, param, pllbuf + 1);
+	zl10353_write(fe, pllbuf, sizeof(pllbuf));
+
+	zl10353_single_write(fe, 0x70, 0x01);
+	udelay(250);
+	zl10353_single_write(fe, 0xE4, 0x00);
+	zl10353_single_write(fe, 0xE5, 0x2A);
+	zl10353_single_write(fe, 0xE9, 0x02);
+	zl10353_single_write(fe, 0xE7, 0x40);
+	zl10353_single_write(fe, 0xE8, 0x10);
+
+	return 0;
+}
+
+static int zl10353_read_status(struct dvb_frontend *fe, fe_status_t *status)
+{
+	struct zl10353_state *state = fe->demodulator_priv;
+	int s6, s7, s8;
+
+	if ((s6 = zl10353_read_register(state, STATUS_6)) < 0)
+		return -EREMOTEIO;
+	if ((s7 = zl10353_read_register(state, STATUS_7)) < 0)
+		return -EREMOTEIO;
+	if ((s8 = zl10353_read_register(state, STATUS_8)) < 0)
+		return -EREMOTEIO;
+
+	*status = 0;
+	if (s6 & (1 << 2))
+		*status |= FE_HAS_CARRIER;
+	if (s6 & (1 << 1))
+		*status |= FE_HAS_VITERBI;
+	if (s6 & (1 << 5))
+		*status |= FE_HAS_LOCK;
+	if (s7 & (1 << 4))
+		*status |= FE_HAS_SYNC;
+	if (s8 & (1 << 6))
+		*status |= FE_HAS_SIGNAL;
+
+	if ((*status & (FE_HAS_CARRIER | FE_HAS_VITERBI | FE_HAS_SYNC)) !=
+	    (FE_HAS_CARRIER | FE_HAS_VITERBI | FE_HAS_SYNC))
+		*status &= ~FE_HAS_LOCK;
+
+	return 0;
+}
+
+static int zl10353_read_snr(struct dvb_frontend *fe, u16 *snr)
+{
+	struct zl10353_state *state = fe->demodulator_priv;
+	u8 _snr;
+
+	if (debug_regs)
+		zl10353_dump_regs(fe);
+
+	_snr = zl10353_read_register(state, SNR);
+	*snr = (_snr << 8) | _snr;
+
+	return 0;
+}
+
+static int zl10353_get_tune_settings(struct dvb_frontend *fe,
+				     struct dvb_frontend_tune_settings
+					 *fe_tune_settings)
+{
+	fe_tune_settings->min_delay_ms = 1000;
+	fe_tune_settings->step_size = 0;
+	fe_tune_settings->max_drift = 0;
+
+	return 0;
+}
+
+static int zl10353_init(struct dvb_frontend *fe)
+{
+	struct zl10353_state *state = fe->demodulator_priv;
+	u8 zl10353_reset_attach[6] = { 0x50, 0x03, 0x64, 0x46, 0x15, 0x0F };
+	int rc = 0;
+
+	if (debug_regs)
+		zl10353_dump_regs(fe);
+
+	/* Do a "hard" reset if not already done */
+	if (zl10353_read_register(state, 0x50) != 0x03) {
+		rc = zl10353_write(fe, zl10353_reset_attach,
+				   sizeof(zl10353_reset_attach));
+		if (debug_regs)
+			zl10353_dump_regs(fe);
+	}
+
+	return 0;
+}
+
+static void zl10353_release(struct dvb_frontend *fe)
+{
+	struct zl10353_state *state = fe->demodulator_priv;
+
+	kfree(state);
+}
+
+static struct dvb_frontend_ops zl10353_ops;
+
+struct dvb_frontend *zl10353_attach(const struct zl10353_config *config,
+				    struct i2c_adapter *i2c)
+{
+	struct zl10353_state *state = NULL;
+
+	/* allocate memory for the internal state */
+	state = kzalloc(sizeof(struct zl10353_state), GFP_KERNEL);
+	if (state == NULL)
+		goto error;
+
+	/* setup the state */
+	state->i2c = i2c;
+	memcpy(&state->config, config, sizeof(struct zl10353_config));
+	memcpy(&state->ops, &zl10353_ops, sizeof(struct dvb_frontend_ops));
+
+	/* check if the demod is there */
+	if (zl10353_read_register(state, CHIP_ID) != ID_ZL10353)
+		goto error;
+
+	/* create dvb_frontend */
+	state->frontend.ops = &state->ops;
+	state->frontend.demodulator_priv = state;
+
+	return &state->frontend;
+error:
+	kfree(state);
+	return NULL;
+}
+
+static struct dvb_frontend_ops zl10353_ops = {
+
+	.info = {
+		.name			= "Zarlink ZL10353 DVB-T",
+		.type			= FE_OFDM,
+		.frequency_min		= 174000000,
+		.frequency_max		= 862000000,
+		.frequency_stepsize	= 166667,
+		.frequency_tolerance	= 0,
+		.caps = FE_CAN_FEC_1_2 | FE_CAN_FEC_2_3 |
+			FE_CAN_FEC_3_4 | FE_CAN_FEC_5_6 | FE_CAN_FEC_7_8 |
+			FE_CAN_FEC_AUTO |
+			FE_CAN_QPSK | FE_CAN_QAM_16 | FE_CAN_QAM_64 | FE_CAN_QAM_AUTO |
+			FE_CAN_TRANSMISSION_MODE_AUTO | FE_CAN_GUARD_INTERVAL_AUTO |
+			FE_CAN_HIERARCHY_AUTO | FE_CAN_RECOVER |
+			FE_CAN_MUTE_TS
+	},
+
+	.release = zl10353_release,
+
+	.init = zl10353_init,
+	.sleep = zl10353_sleep,
+
+	.set_frontend = zl10353_set_parameters,
+	.get_tune_settings = zl10353_get_tune_settings,
+
+	.read_status = zl10353_read_status,
+	.read_snr = zl10353_read_snr,
+};
+
+module_param(debug_regs, int, 0644);
+MODULE_PARM_DESC(debug_regs, "Turn on/off frontend register dumps (default:off).");
+
+MODULE_DESCRIPTION("Zarlink ZL10353 DVB-T demodulator driver");
+MODULE_AUTHOR("Chris Pascoe");
+MODULE_LICENSE("GPL");
+
+EXPORT_SYMBOL(zl10353_attach);
+EXPORT_SYMBOL(zl10353_write);
diff --git a/drivers/media/dvb/frontends/zl10353.h b/drivers/media/dvb/frontends/zl10353.h
diff --git a/drivers/media/dvb/frontends/zl10353.h b/drivers/media/dvb/frontends/zl10353.h
new file mode 100644
index 0000000..5cc4ae7
--- /dev/null
+++ b/drivers/media/dvb/frontends/zl10353.h
@@ -0,0 +1,43 @@
+/*
+ *  Driver for Zarlink DVB-T ZL10353 demodulator
+ *
+ *  Copyright (C) 2006 Christopher Pascoe <c.pascoe@itee.uq.edu.au>
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
+#ifndef ZL10353_H
+#define ZL10353_H
+
+#include <linux/dvb/frontend.h>
+
+struct zl10353_config
+{
+	/* demodulator's I2C address */
+	u8 demod_address;
+
+	/* function which configures the PLL buffer (for secondary I2C
+	 * connected tuner) or tunes the PLL (for direct connected tuner) */
+	int (*pll_set)(struct dvb_frontend *fe,
+		       struct dvb_frontend_parameters *params, u8 *pllbuf);
+};
+
+extern struct dvb_frontend* zl10353_attach(const struct zl10353_config *config,
+					   struct i2c_adapter *i2c);
+
+extern int zl10353_write(struct dvb_frontend *fe, u8 *ibuf, int ilen);
+
+#endif /* ZL10353_H */
diff --git a/drivers/media/dvb/frontends/zl10353_priv.h b/drivers/media/dvb/frontends/zl10353_priv.h
diff --git a/drivers/media/dvb/frontends/zl10353_priv.h b/drivers/media/dvb/frontends/zl10353_priv.h
new file mode 100644
index 0000000..b72224b
--- /dev/null
+++ b/drivers/media/dvb/frontends/zl10353_priv.h
@@ -0,0 +1,42 @@
+/*
+ *  Driver for Zarlink DVB-T ZL10353 demodulator
+ *
+ *  Copyright (C) 2006 Christopher Pascoe <c.pascoe@itee.uq.edu.au>
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
+#ifndef _ZL10353_PRIV_
+#define _ZL10353_PRIV_
+
+#define ID_ZL10353	0x14
+
+enum zl10353_reg_addr {
+	INTERRUPT_0	= 0x00,
+	INTERRUPT_1	= 0x01,
+	INTERRUPT_2	= 0x02,
+	INTERRUPT_3	= 0x03,
+	INTERRUPT_4	= 0x04,
+	INTERRUPT_5	= 0x05,
+	STATUS_6	= 0x06,
+	STATUS_7	= 0x07,
+	STATUS_8	= 0x08,
+	STATUS_9	= 0x09,
+	SNR		= 0x10,
+	CHIP_ID		= 0x7F,
+};
+
+#endif                          /* _ZL10353_PRIV_ */
diff --git a/drivers/media/video/cx88/Makefile b/drivers/media/video/cx88/Makefile
diff --git a/drivers/media/video/cx88/Makefile b/drivers/media/video/cx88/Makefile
index 2b90278..6482b9a 100644
--- a/drivers/media/video/cx88/Makefile
+++ b/drivers/media/video/cx88/Makefile
@@ -17,6 +17,7 @@ extra-cflags-$(CONFIG_DVB_CX22702)   += 
 extra-cflags-$(CONFIG_DVB_OR51132)   += -DHAVE_OR51132=1
 extra-cflags-$(CONFIG_DVB_LGDT330X)  += -DHAVE_LGDT330X=1
 extra-cflags-$(CONFIG_DVB_MT352)     += -DHAVE_MT352=1
+extra-cflags-$(CONFIG_DVB_ZL10353)   += -DHAVE_ZL10353=1
 extra-cflags-$(CONFIG_DVB_NXT200X)   += -DHAVE_NXT200X=1
 extra-cflags-$(CONFIG_DVB_CX24123)   += -DHAVE_CX24123=1
 extra-cflags-$(CONFIG_VIDEO_CX88_VP3054)+= -DHAVE_VP3054_I2C=1
diff --git a/drivers/media/video/cx88/cx88-cards.c b/drivers/media/video/cx88/cx88-cards.c
diff --git a/drivers/media/video/cx88/cx88-cards.c b/drivers/media/video/cx88/cx88-cards.c
index 44e27dc..d91e5b3 100644
--- a/drivers/media/video/cx88/cx88-cards.c
+++ b/drivers/media/video/cx88/cx88-cards.c
@@ -1071,6 +1071,27 @@ struct cx88_board cx88_boards[] = {
 			.gpio2  = 0x00ff,
 		},
 	},
+	[CX88_BOARD_DVICO_FUSIONHDTV_DVB_T_HYBRID] = {
+		.name           = "DViCO FusionHDTV DVB-T Hybrid",
+		.tuner_type     = TUNER_FE6600,
+		.radio_type     = UNSET,
+		.tuner_addr	= ADDR_UNSET,
+		.radio_addr	= ADDR_UNSET,
+		.input          = {{
+			.type   = CX88_VMUX_TELEVISION,
+			.vmux   = 0,
+			.gpio0  = 0x0000a75f,
+		},{
+			.type   = CX88_VMUX_COMPOSITE1,
+			.vmux   = 1,
+			.gpio0  = 0x0000a75b,
+		},{
+			.type   = CX88_VMUX_SVIDEO,
+			.vmux   = 2,
+			.gpio0  = 0x0000a75b,
+		}},
+		.dvb            = 1,
+	},
 
 };
 const unsigned int cx88_bcount = ARRAY_SIZE(cx88_boards);
@@ -1281,6 +1302,14 @@ struct cx88_subid cx88_subids[] = {
 		.subvendor = 0x17de,
 		.subdevice = 0x0840,
 		.card      = CX88_BOARD_KWORLD_HARDWARE_MPEG_TV_XPERT,
+	},{
+		.subvendor = 0x18ac,
+		.subdevice = 0xdb40,
+		.card      = CX88_BOARD_DVICO_FUSIONHDTV_DVB_T_HYBRID,
+	},{
+		.subvendor = 0x18ac,
+		.subdevice = 0xdb44,
+		.card      = CX88_BOARD_DVICO_FUSIONHDTV_DVB_T_HYBRID,
 	},
 };
 const unsigned int cx88_idcount = ARRAY_SIZE(cx88_subids);
@@ -1400,6 +1429,40 @@ static void gdi_eeprom(struct cx88_core 
 }
 
 /* ----------------------------------------------------------------------- */
+/* some DViCO specific stuff                                               */
+
+static void dvico_fusionhdtv_hybrid_init(struct cx88_core *core)
+{
+	struct i2c_msg msg = { .addr = 0x45, .flags = 0 };
+	int i, err;
+	u8 init_bufs[13][5] = {
+		{ 0x10, 0x00, 0x20, 0x01, 0x03 },
+		{ 0x10, 0x10, 0x01, 0x00, 0x21 },
+		{ 0x10, 0x10, 0x10, 0x00, 0xCA },
+		{ 0x10, 0x10, 0x12, 0x00, 0x08 },
+		{ 0x10, 0x10, 0x13, 0x00, 0x0A },
+		{ 0x10, 0x10, 0x16, 0x01, 0xC0 },
+		{ 0x10, 0x10, 0x22, 0x01, 0x3D },
+		{ 0x10, 0x10, 0x73, 0x01, 0x2E },
+		{ 0x10, 0x10, 0x72, 0x00, 0xC5 },
+		{ 0x10, 0x10, 0x71, 0x01, 0x97 },
+		{ 0x10, 0x10, 0x70, 0x00, 0x0F },
+		{ 0x10, 0x10, 0xB0, 0x00, 0x01 },
+		{ 0x03, 0x0C },
+	};
+
+	for (i = 0; i < 13; i++) {
+		msg.buf = init_bufs[i];
+		msg.len = (i != 12 ? 5 : 2);
+		err = i2c_transfer(&core->i2c_adap, &msg, 1);
+		if (err != 1) {
+			printk("dvico_fusionhdtv_hybrid_init buf %d failed (err = %d)!\n", i, err);
+			return;
+		}
+	}
+}
+
+/* ----------------------------------------------------------------------- */
 
 void cx88_card_list(struct cx88_core *core, struct pci_dev *pci)
 {
@@ -1465,11 +1528,15 @@ void cx88_card_setup(struct cx88_core *c
 	case CX88_BOARD_DVICO_FUSIONHDTV_DVB_T1:
 	case CX88_BOARD_DVICO_FUSIONHDTV_DVB_T_PLUS:
 	case CX88_BOARD_DVICO_FUSIONHDTV_DVB_T_DUAL:
+	case CX88_BOARD_DVICO_FUSIONHDTV_DVB_T_HYBRID:
 		/* GPIO0:0 is hooked to mt352 reset pin */
 		cx_set(MO_GP0_IO, 0x00000101);
 		cx_clear(MO_GP0_IO, 0x00000001);
 		msleep(1);
 		cx_set(MO_GP0_IO, 0x00000101);
+		if (0 == core->i2c_rc &&
+		    core->board == CX88_BOARD_DVICO_FUSIONHDTV_DVB_T_HYBRID)
+			dvico_fusionhdtv_hybrid_init(core);
 		break;
 	case CX88_BOARD_KWORLD_DVB_T:
 	case CX88_BOARD_DNTV_LIVE_DVB_T:
diff --git a/drivers/media/video/cx88/cx88-dvb.c b/drivers/media/video/cx88/cx88-dvb.c
diff --git a/drivers/media/video/cx88/cx88-dvb.c b/drivers/media/video/cx88/cx88-dvb.c
index e48aa3f..2c97d3f 100644
--- a/drivers/media/video/cx88/cx88-dvb.c
+++ b/drivers/media/video/cx88/cx88-dvb.c
@@ -40,6 +40,9 @@
 #  include "cx88-vp3054-i2c.h"
 # endif
 #endif
+#ifdef HAVE_ZL10353
+# include "zl10353.h"
+#endif
 #ifdef HAVE_CX22702
 # include "cx22702.h"
 #endif
@@ -111,6 +114,21 @@ static struct videobuf_queue_ops dvb_qop
 
 /* ------------------------------------------------------------------ */
 
+#if defined(HAVE_MT352) || defined(HAVE_ZL10353)
+static int zarlink_pll_set(struct dvb_frontend *fe,
+			      struct dvb_frontend_parameters *params,
+			      u8 *pllbuf)
+{
+	struct cx8802_dev *dev = fe->dvb->priv;
+
+	pllbuf[0] = dev->core->pll_addr << 1;
+	dvb_pll_configure(dev->core->pll_desc, pllbuf + 1,
+			  params->frequency,
+			  params->u.ofdm.bandwidth);
+	return 0;
+}
+#endif
+
 #ifdef HAVE_MT352
 static int dvico_fusionhdtv_demod_init(struct dvb_frontend* fe)
 {
@@ -176,35 +194,22 @@ static int dntv_live_dvbt_demod_init(str
 	return 0;
 }
 
-static int mt352_pll_set(struct dvb_frontend* fe,
-			 struct dvb_frontend_parameters* params,
-			 u8* pllbuf)
-{
-	struct cx8802_dev *dev= fe->dvb->priv;
-
-	pllbuf[0] = dev->core->pll_addr << 1;
-	dvb_pll_configure(dev->core->pll_desc, pllbuf+1,
-			  params->frequency,
-			  params->u.ofdm.bandwidth);
-	return 0;
-}
-
 static struct mt352_config dvico_fusionhdtv = {
 	.demod_address = 0x0F,
 	.demod_init    = dvico_fusionhdtv_demod_init,
-	.pll_set       = mt352_pll_set,
+	.pll_set       = zarlink_pll_set,
 };
 
 static struct mt352_config dntv_live_dvbt_config = {
 	.demod_address = 0x0f,
 	.demod_init    = dntv_live_dvbt_demod_init,
-	.pll_set       = mt352_pll_set,
+	.pll_set       = zarlink_pll_set,
 };
 
 static struct mt352_config dvico_fusionhdtv_dual = {
 	.demod_address = 0x0F,
 	.demod_init    = dvico_dual_demod_init,
-	.pll_set       = mt352_pll_set,
+	.pll_set       = zarlink_pll_set,
 };
 
 #ifdef HAVE_VP3054_I2C
@@ -294,6 +299,46 @@ static struct mt352_config dntv_live_dvb
 #endif
 #endif
 
+#ifdef HAVE_ZL10353
+static int dvico_hybrid_tune_pll(struct dvb_frontend *fe,
+				 struct dvb_frontend_parameters *params,
+				 u8 *pllbuf)
+{
+	struct cx8802_dev *dev= fe->dvb->priv;
+	struct i2c_msg msg =
+		{ .addr = dev->core->pll_addr, .flags = 0,
+		  .buf = pllbuf + 1, .len = 4 };
+	int err;
+
+	pllbuf[0] = dev->core->pll_addr << 1;
+	dvb_pll_configure(dev->core->pll_desc, pllbuf + 1,
+			  params->frequency,
+			  params->u.ofdm.bandwidth);
+
+	if ((err = i2c_transfer(&dev->core->i2c_adap, &msg, 1)) != 1) {
+		printk(KERN_WARNING "cx88-dvb: %s error "
+			   "(addr %02x <- %02x, err = %i)\n",
+			   __FUNCTION__, pllbuf[0], pllbuf[1], err);
+		if (err < 0)
+			return err;
+		else
+			return -EREMOTEIO;
+	}
+
+	return 0;
+}
+
+static struct zl10353_config dvico_fusionhdtv_hybrid = {
+	.demod_address = 0x0F,
+	.pll_set       = dvico_hybrid_tune_pll,
+};
+
+static struct zl10353_config dvico_fusionhdtv_plus_v1_1 = {
+	.demod_address = 0x0F,
+	.pll_set       = zarlink_pll_set,
+};
+#endif
+
 #ifdef HAVE_CX22702
 static struct cx22702_config connexant_refboard_config = {
 	.demod_address = 0x43,
@@ -500,16 +545,27 @@ static int dvb_register(struct cx8802_de
 						   &dev->core->i2c_adap);
 		break;
 #endif
+#if defined(HAVE_MT352) || defined(HAVE_ZL10353)
+	case CX88_BOARD_DVICO_FUSIONHDTV_DVB_T_PLUS:
+		dev->core->pll_addr = 0x60;
+		dev->core->pll_desc = &dvb_pll_thomson_dtt7579;
 #ifdef HAVE_MT352
-	case CX88_BOARD_DVICO_FUSIONHDTV_DVB_T1:
-		dev->core->pll_addr = 0x61;
-		dev->core->pll_desc = &dvb_pll_lg_z201;
 		dev->dvb.frontend = mt352_attach(&dvico_fusionhdtv,
 						 &dev->core->i2c_adap);
+		if (dev->dvb.frontend != NULL)
+			break;
+#endif
+#ifdef HAVE_ZL10353
+		/* ZL10353 replaces MT352 on later cards */
+		dev->dvb.frontend = zl10353_attach(&dvico_fusionhdtv_plus_v1_1,
+						   &dev->core->i2c_adap);
+#endif
 		break;
-	case CX88_BOARD_DVICO_FUSIONHDTV_DVB_T_PLUS:
-		dev->core->pll_addr = 0x60;
-		dev->core->pll_desc = &dvb_pll_thomson_dtt7579;
+#endif /* HAVE_MT352 || HAVE_ZL10353 */
+#ifdef HAVE_MT352
+	case CX88_BOARD_DVICO_FUSIONHDTV_DVB_T1:
+		dev->core->pll_addr = 0x61;
+		dev->core->pll_desc = &dvb_pll_lg_z201;
 		dev->dvb.frontend = mt352_attach(&dvico_fusionhdtv,
 						 &dev->core->i2c_adap);
 		break;
@@ -540,6 +596,14 @@ static int dvb_register(struct cx8802_de
 						 &dev->core->i2c_adap);
 		break;
 #endif
+#ifdef HAVE_ZL10353
+	case CX88_BOARD_DVICO_FUSIONHDTV_DVB_T_HYBRID:
+		dev->core->pll_addr = 0x61;
+		dev->core->pll_desc = &dvb_pll_unknown_fe6600;
+		dev->dvb.frontend = zl10353_attach(&dvico_fusionhdtv_hybrid,
+						   &dev->core->i2c_adap);
+		break;
+#endif
 #ifdef HAVE_OR51132
 	case CX88_BOARD_PCHDTV_HD3000:
 		dev->dvb.frontend = or51132_attach(&pchdtv_hd3000,
diff --git a/drivers/media/video/cx88/cx88.h b/drivers/media/video/cx88/cx88.h
diff --git a/drivers/media/video/cx88/cx88.h b/drivers/media/video/cx88/cx88.h
index a4cf247..21738b6 100644
--- a/drivers/media/video/cx88/cx88.h
+++ b/drivers/media/video/cx88/cx88.h
@@ -189,6 +189,7 @@ extern struct sram_channel cx88_sram_cha
 #define CX88_BOARD_KWORLD_DVB_T_CX22702    43
 #define CX88_BOARD_DVICO_FUSIONHDTV_DVB_T_DUAL 44
 #define CX88_BOARD_KWORLD_HARDWARE_MPEG_TV_XPERT 45
+#define CX88_BOARD_DVICO_FUSIONHDTV_DVB_T_HYBRID 46
 
 enum cx88_itype {
 	CX88_VMUX_COMPOSITE1 = 1,
diff --git a/drivers/media/video/tuner-types.c b/drivers/media/video/tuner-types.c
diff --git a/drivers/media/video/tuner-types.c b/drivers/media/video/tuner-types.c
index 15761dd..d10cfd4 100644
--- a/drivers/media/video/tuner-types.c
+++ b/drivers/media/video/tuner-types.c
@@ -983,6 +983,22 @@ static struct tuner_params tuner_samsung
 	},
 };
 
+/* ------------ TUNER_FE6600 - DViCO Hybrid PAL ------------ */
+
+static struct tuner_range tuner_fe6600_ranges[] = {
+	{ 16 * 160.00 /*MHz*/, 0xfe, 0x11, },
+	{ 16 * 442.00 /*MHz*/, 0xf6, 0x12, },
+	{ 16 * 999.99        , 0xf6, 0x18, },
+};
+
+static struct tuner_params tuner_fe6600_params[] = {
+	{
+		.type   = TUNER_PARAM_TYPE_PAL,
+		.ranges = tuner_fe6600_ranges,
+		.count  = ARRAY_SIZE(tuner_fe6600_ranges),
+	},
+};
+
 /* --------------------------------------------------------------------- */
 
 struct tunertype tuners[] = {
@@ -1354,6 +1370,10 @@ struct tunertype tuners[] = {
 		.name	= "Xceive xc3028",
 		/* see xc3028.c for details */
 	},
+	[TUNER_FE6600] = { /* */
+		.name   = "FE6600",
+		.params = tuner_fe6600_params,
+	},
 };
 
 unsigned const int tuner_count = ARRAY_SIZE(tuners);
diff --git a/include/media/tuner.h b/include/media/tuner.h
diff --git a/include/media/tuner.h b/include/media/tuner.h
index f51759c..039c77e 100644
--- a/include/media/tuner.h
+++ b/include/media/tuner.h
@@ -116,9 +116,10 @@
 #define TUNER_PHILIPS_TUV1236D		68	/* ATI HDTV Wonder */
 #define TUNER_TNF_5335MF                69	/* Sabrent Bt848   */
 #define TUNER_SAMSUNG_TCPN_2121P30A     70 	/* Hauppauge PVR-500MCE NTSC */
-
 #define TUNER_XCEIVE_XC3028		71
 
+#define TUNER_FE6600			72	/* DViCO FusionHDTV DVB-T Hybrid */
+
 /* tv card specific */
 #define TDA9887_PRESENT 		(1<<0)
 #define TDA9887_PORT1_INACTIVE 		(1<<1)

