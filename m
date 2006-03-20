Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966530AbWCTPRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966530AbWCTPRz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966539AbWCTPRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:17:54 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:53656 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966530AbWCTPRr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:17:47 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Oliver Endriss <o.endriss@gmx.de>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 132/141] V4L/DVB (3404): Refactored LNBP21 and BSBE1 support
Date: Mon, 20 Mar 2006 12:08:59 -0300
Message-id: <20060320150859.PS034722000132@infradead.org>
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

From: Oliver Endriss <o.endriss@gmx.de>
Date: 1141129876 -0300

Moved duplicated code to separate files.
LNBP21 stuff rewritten from scratch, BSBE1 copied from av7110.c.
Modified budget driver to use the new routines.

Signed-off-by: Oliver Endriss <o.endriss@gmx.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/dvb/dvb-core/dvb_frontend.h b/drivers/media/dvb/dvb-core/dvb_frontend.h
diff --git a/drivers/media/dvb/dvb-core/dvb_frontend.h b/drivers/media/dvb/dvb-core/dvb_frontend.h
index 70a6d14..d5aee5a 100644
--- a/drivers/media/dvb/dvb-core/dvb_frontend.h
+++ b/drivers/media/dvb/dvb-core/dvb_frontend.h
@@ -104,6 +104,7 @@ struct dvb_frontend {
 	struct dvb_adapter *dvb;
 	void* demodulator_priv;
 	void* frontend_priv;
+	void* misc_priv;
 };
 
 extern int dvb_register_frontend(struct dvb_adapter* dvb,
diff --git a/drivers/media/dvb/frontends/bsbe1.h b/drivers/media/dvb/frontends/bsbe1.h
diff --git a/drivers/media/dvb/frontends/bsbe1.h b/drivers/media/dvb/frontends/bsbe1.h
new file mode 100644
index 0000000..78573b2
--- /dev/null
+++ b/drivers/media/dvb/frontends/bsbe1.h
@@ -0,0 +1,123 @@
+/*
+ * bsbe1.h - ALPS BSBE1 tuner support (moved from av7110.c)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ * Or, point your browser to http://www.gnu.org/copyleft/gpl.html
+ *
+ *
+ * the project's page is at http://www.linuxtv.org
+ */
+
+#ifndef BSBE1_H
+#define BSBE1_H
+
+static u8 alps_bsbe1_inittab[] = {
+	0x01, 0x15,
+	0x02, 0x30,
+	0x03, 0x00,
+	0x04, 0x7d,   /* F22FR = 0x7d, F22 = f_VCO / 128 / 0x7d = 22 kHz */
+	0x05, 0x35,   /* I2CT = 0, SCLT = 1, SDAT = 1 */
+	0x06, 0x40,   /* DAC not used, set to high impendance mode */
+	0x07, 0x00,   /* DAC LSB */
+	0x08, 0x40,   /* DiSEqC off, LNB power on OP2/LOCK pin on */
+	0x09, 0x00,   /* FIFO */
+	0x0c, 0x51,   /* OP1 ctl = Normal, OP1 val = 1 (LNB Power ON) */
+	0x0d, 0x82,   /* DC offset compensation = ON, beta_agc1 = 2 */
+	0x0e, 0x23,   /* alpha_tmg = 2, beta_tmg = 3 */
+	0x10, 0x3f,   // AGC2  0x3d
+	0x11, 0x84,
+	0x12, 0xb9,
+	0x15, 0xc9,   // lock detector threshold
+	0x16, 0x00,
+	0x17, 0x00,
+	0x18, 0x00,
+	0x19, 0x00,
+	0x1a, 0x00,
+	0x1f, 0x50,
+	0x20, 0x00,
+	0x21, 0x00,
+	0x22, 0x00,
+	0x23, 0x00,
+	0x28, 0x00,  // out imp: normal  out type: parallel FEC mode:0
+	0x29, 0x1e,  // 1/2 threshold
+	0x2a, 0x14,  // 2/3 threshold
+	0x2b, 0x0f,  // 3/4 threshold
+	0x2c, 0x09,  // 5/6 threshold
+	0x2d, 0x05,  // 7/8 threshold
+	0x2e, 0x01,
+	0x31, 0x1f,  // test all FECs
+	0x32, 0x19,  // viterbi and synchro search
+	0x33, 0xfc,  // rs control
+	0x34, 0x93,  // error control
+	0x0f, 0x92,
+	0xff, 0xff
+};
+
+
+static int alps_bsbe1_set_symbol_rate(struct dvb_frontend* fe, u32 srate, u32 ratio)
+{
+	u8 aclk = 0;
+	u8 bclk = 0;
+
+	if (srate < 1500000) { aclk = 0xb7; bclk = 0x47; }
+	else if (srate < 3000000) { aclk = 0xb7; bclk = 0x4b; }
+	else if (srate < 7000000) { aclk = 0xb7; bclk = 0x4f; }
+	else if (srate < 14000000) { aclk = 0xb7; bclk = 0x53; }
+	else if (srate < 30000000) { aclk = 0xb6; bclk = 0x53; }
+	else if (srate < 45000000) { aclk = 0xb4; bclk = 0x51; }
+
+	stv0299_writereg(fe, 0x13, aclk);
+	stv0299_writereg(fe, 0x14, bclk);
+	stv0299_writereg(fe, 0x1f, (ratio >> 16) & 0xff);
+	stv0299_writereg(fe, 0x20, (ratio >>  8) & 0xff);
+	stv0299_writereg(fe, 0x21, (ratio      ) & 0xf0);
+
+	return 0;
+}
+
+static int alps_bsbe1_pll_set(struct dvb_frontend* fe, struct i2c_adapter *i2c, struct dvb_frontend_parameters* params)
+{
+	int ret;
+	u8 data[4];
+	u32 div;
+	struct i2c_msg msg = { .addr = 0x61, .flags = 0, .buf = data, .len = sizeof(data) };
+
+	if ((params->frequency < 950000) || (params->frequency > 2150000))
+		return -EINVAL;
+
+	div = (params->frequency + (125 - 1)) / 125; // round correctly
+	data[0] = (div >> 8) & 0x7f;
+	data[1] = div & 0xff;
+	data[2] = 0x80 | ((div & 0x18000) >> 10) | 4;
+	data[3] = (params->frequency > 1530000) ? 0xE0 : 0xE4;
+
+	ret = i2c_transfer(i2c, &msg, 1);
+	return (ret != 1) ? -EIO : 0;
+}
+
+static struct stv0299_config alps_bsbe1_config = {
+	.demod_address = 0x68,
+	.inittab = alps_bsbe1_inittab,
+	.mclk = 88000000UL,
+	.invert = 1,
+	.skip_reinit = 0,
+	.min_delay_ms = 100,
+	.set_symbol_rate = alps_bsbe1_set_symbol_rate,
+	.pll_set = alps_bsbe1_pll_set,
+};
+
+#endif
diff --git a/drivers/media/dvb/frontends/lnbp21.h b/drivers/media/dvb/frontends/lnbp21.h
diff --git a/drivers/media/dvb/frontends/lnbp21.h b/drivers/media/dvb/frontends/lnbp21.h
new file mode 100644
index 0000000..0dcbe61
--- /dev/null
+++ b/drivers/media/dvb/frontends/lnbp21.h
@@ -0,0 +1,139 @@
+/*
+ * lnbp21.h - driver for lnb supply and control ic lnbp21
+ *
+ * Copyright (C) 2006 Oliver Endriss
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ * Or, point your browser to http://www.gnu.org/copyleft/gpl.html
+ *
+ *
+ * the project's page is at http://www.linuxtv.org
+ */
+
+#ifndef _LNBP21_H
+#define _LNBP21_H
+
+/* system register */
+#define LNBP21_OLF	0x01
+#define LNBP21_OTF	0x02
+#define LNBP21_EN	0x04
+#define LNBP21_VSEL	0x08
+#define LNBP21_LLC	0x10
+#define LNBP21_TEN	0x20
+#define LNBP21_ISEL	0x40
+#define LNBP21_PCL	0x80
+
+struct lnbp21 {
+	u8			config;
+	u8			override_or;
+	u8			override_and;
+	struct i2c_adapter	*i2c;
+	void			(*release_chain)(struct dvb_frontend* fe);
+};
+
+static int lnbp21_set_voltage(struct dvb_frontend *fe, fe_sec_voltage_t voltage)
+{
+	struct lnbp21 *lnbp21 = (struct lnbp21 *) fe->misc_priv;
+	struct i2c_msg msg = {	.addr = 0x08, .flags = 0,
+				.buf = &lnbp21->config,
+				.len = sizeof(lnbp21->config) };
+
+	lnbp21->config &= ~(LNBP21_VSEL | LNBP21_EN);
+
+	switch(voltage) {
+	case SEC_VOLTAGE_OFF:
+		break;
+	case SEC_VOLTAGE_13:
+		lnbp21->config |= LNBP21_EN;
+		break;
+	case SEC_VOLTAGE_18:
+		lnbp21->config |= (LNBP21_EN | LNBP21_VSEL);
+		break;
+	default:
+		return -EINVAL;
+	};
+
+	lnbp21->config |= lnbp21->override_or;
+	lnbp21->config &= lnbp21->override_and;
+
+	return (i2c_transfer(lnbp21->i2c, &msg, 1) == 1) ? 0 : -EIO;
+}
+
+static int lnbp21_enable_high_lnb_voltage(struct dvb_frontend *fe, long arg)
+{
+	struct lnbp21 *lnbp21 = (struct lnbp21 *) fe->misc_priv;
+	struct i2c_msg msg = {	.addr = 0x08, .flags = 0,
+				.buf = &lnbp21->config,
+				.len = sizeof(lnbp21->config) };
+
+	if (arg)
+		lnbp21->config |= LNBP21_LLC;
+	else
+		lnbp21->config &= ~LNBP21_LLC;
+
+	lnbp21->config |= lnbp21->override_or;
+	lnbp21->config &= lnbp21->override_and;
+
+	return (i2c_transfer(lnbp21->i2c, &msg, 1) == 1) ? 0 : -EIO;
+}
+
+static void lnbp21_exit(struct dvb_frontend *fe)
+{
+	struct lnbp21 *lnbp21 = (struct lnbp21 *) fe->misc_priv;
+
+	/* LNBP power off */
+	lnbp21_set_voltage(fe, SEC_VOLTAGE_OFF);
+
+	/* free data & call next release routine */
+	fe->ops->release = lnbp21->release_chain;
+	kfree(fe->misc_priv);
+	fe->misc_priv = NULL;
+	if (fe->ops->release)
+		fe->ops->release(fe);
+}
+
+static int lnbp21_init(struct dvb_frontend *fe, struct i2c_adapter *i2c, u8 override_set, u8 override_clear)
+{
+	struct lnbp21 *lnbp21 = kmalloc(sizeof(struct lnbp21), GFP_KERNEL);
+
+	if (!lnbp21)
+		return -ENOMEM;
+
+	/* default configuration */
+	lnbp21->config = LNBP21_ISEL;
+
+	/* bits which should be forced to '1' */
+	lnbp21->override_or = override_set;
+
+	/* bits which should be forced to '0' */
+	lnbp21->override_and = ~override_clear;
+
+	/* install release callback */
+	lnbp21->release_chain = fe->ops->release;
+	fe->ops->release = lnbp21_exit;
+
+	/* override frontend ops */
+	fe->ops->set_voltage = lnbp21_set_voltage;
+	fe->ops->enable_high_lnb_voltage = lnbp21_enable_high_lnb_voltage;
+
+	lnbp21->i2c = i2c;
+	fe->misc_priv = lnbp21;
+
+	return lnbp21_set_voltage(fe, SEC_VOLTAGE_OFF);
+}
+
+#endif
diff --git a/drivers/media/dvb/ttpci/budget.c b/drivers/media/dvb/ttpci/budget.c
diff --git a/drivers/media/dvb/ttpci/budget.c b/drivers/media/dvb/ttpci/budget.c
index 238c77b..2a0e3ef 100644
--- a/drivers/media/dvb/ttpci/budget.c
+++ b/drivers/media/dvb/ttpci/budget.c
@@ -41,6 +41,8 @@
 #include "l64781.h"
 #include "tda8083.h"
 #include "s5h1420.h"
+#include "lnbp21.h"
+#include "bsbe1.h"
 
 static void Set22K (struct budget *budget, int state)
 {
@@ -184,64 +186,6 @@ static int budget_diseqc_send_burst(stru
 	return 0;
 }
 
-static int lnbp21_set_voltage(struct dvb_frontend* fe, fe_sec_voltage_t voltage)
-{
-	struct budget* budget = (struct budget*) fe->dvb->priv;
-	u8 buf;
-	struct i2c_msg msg = { .addr = 0x08, .flags = I2C_M_RD, .buf = &buf, .len = sizeof(buf) };
-
-	if (i2c_transfer (&budget->i2c_adap, &msg, 1) != 1) return -EIO;
-
-	switch(voltage) {
-	case SEC_VOLTAGE_13:
-		buf = (buf & 0xf7) | 0x04;
-		break;
-
-	case SEC_VOLTAGE_18:
-		buf = (buf & 0xf7) | 0x0c;
-		break;
-
-	case SEC_VOLTAGE_OFF:
-		buf = buf & 0xf0;
-		break;
-	}
-
-	msg.flags = 0;
-	if (i2c_transfer (&budget->i2c_adap, &msg, 1) != 1) return -EIO;
-
-	return 0;
-}
-
-static int lnbp21_enable_high_lnb_voltage(struct dvb_frontend* fe, long arg)
-{
-	struct budget* budget = (struct budget*) fe->dvb->priv;
-	u8 buf;
-	struct i2c_msg msg = { .addr = 0x08, .flags = I2C_M_RD, .buf = &buf, .len = sizeof(buf) };
-
-	if (i2c_transfer (&budget->i2c_adap, &msg, 1) != 1) return -EIO;
-
-	if (arg) {
-		buf = buf | 0x10;
-	} else {
-		buf = buf & 0xef;
-	}
-
-	msg.flags = 0;
-	if (i2c_transfer (&budget->i2c_adap, &msg, 1) != 1) return -EIO;
-
-	return 0;
-}
-
-static int lnbp21_init(struct budget* budget)
-{
-	u8 buf = 0x00;
-	struct i2c_msg msg = { .addr = 0x08, .flags = 0, .buf = &buf, .len = sizeof(buf) };
-
-	if (i2c_transfer (&budget->i2c_adap, &msg, 1) != 1)
-		return -EIO;
-	return 0;
-}
-
 static int alps_bsrv2_pll_set(struct dvb_frontend* fe, struct dvb_frontend_parameters* params)
 {
 	struct budget* budget = (struct budget*) fe->dvb->priv;
@@ -374,79 +318,6 @@ static struct stv0299_config alps_bsru6_
 	.pll_set = alps_bsru6_pll_set,
 };
 
-static u8 alps_bsbe1_inittab[] = {
-	0x01, 0x15,
-	0x02, 0x30,
-	0x03, 0x00,
-	0x04, 0x7d,  /* F22FR = 0x7d, F22 = f_VCO / 128 / 0x7d = 22 kHz */
-	0x05, 0x35,  /* I2CT = 0, SCLT = 1, SDAT = 1 */
-	0x06, 0x40,  /* DAC not used, set to high impendance mode */
-	0x07, 0x00,  /* DAC LSB */
-	0x08, 0x40,  /* DiSEqC off, LNB power on OP2/LOCK pin on */
-	0x09, 0x00,  /* FIFO */
-	0x0c, 0x51,  /* OP1 ctl = Normal, OP1 val = 1 (LNB Power ON) */
-	0x0d, 0x82,  /* DC offset compensation = ON, beta_agc1 = 2 */
-	0x0e, 0x23,  /* alpha_tmg = 2, beta_tmg = 3 */
-	0x10, 0x3f,  // AGC2 0x3d
-	0x11, 0x84,
-	0x12, 0xb9,
-	0x15, 0xc9,  // lock detector threshold
-	0x16, 0x00,
-	0x17, 0x00,
-	0x18, 0x00,
-	0x19, 0x00,
-	0x1a, 0x00,
-	0x1f, 0x50,
-	0x20, 0x00,
-	0x21, 0x00,
-	0x22, 0x00,
-	0x23, 0x00,
-	0x28, 0x00, // out imp: normal out type: parallel FEC mode:0
-	0x29, 0x1e, // 1/2 threshold
-	0x2a, 0x14, // 2/3 threshold
-	0x2b, 0x0f, // 3/4 threshold
-	0x2c, 0x09, // 5/6 threshold
-	0x2d, 0x05, // 7/8 threshold
-	0x2e, 0x01,
-	0x31, 0x1f, // test all FECs
-	0x32, 0x19, // viterbi and synchro search
-	0x33, 0xfc, // rs control
-	0x34, 0x93, // error control
-	0x0f, 0x92, // 0x80 = inverse AGC
-	0xff, 0xff
-};
-
-static int alps_bsbe1_pll_set(struct dvb_frontend* fe, struct i2c_adapter *i2c, struct dvb_frontend_parameters* params)
-{
-	int ret;
-	u8 data[4];
-	u32 div;
-	struct i2c_msg msg = { .addr = 0x61, .flags = 0, .buf = data, .len = sizeof(data) };
-
-	if ((params->frequency < 950000) || (params->frequency > 2150000))
-		return -EINVAL;
-
-	div = (params->frequency + (125 - 1)) / 125; // round correctly
-	data[0] = (div >> 8) & 0x7f;
-	data[1] = div & 0xff;
-	data[2] = 0x80 | ((div & 0x18000) >> 10) | 4;
-	data[3] = (params->frequency > 1530000) ? 0xE0 : 0xE4;
-
-	ret = i2c_transfer(i2c, &msg, 1);
-	return (ret != 1) ? -EIO : 0;
-}
-
-static struct stv0299_config alps_bsbe1_config = {
-	.demod_address = 0x68,
-	.inittab = alps_bsbe1_inittab,
-	.mclk = 88000000UL,
-	.invert = 1,
-	.skip_reinit = 0,
-	.min_delay_ms = 100,
-	.set_symbol_rate = alps_bsru6_set_symbol_rate,
-	.pll_set = alps_bsbe1_pll_set,
-};
-
 static int alps_tdbe2_pll_set(struct dvb_frontend* fe, struct dvb_frontend_parameters* params)
 {
 	struct budget* budget = (struct budget*) fe->dvb->priv;
@@ -584,10 +455,8 @@ static void frontend_init(struct budget 
 		// try the ALPS BSBE1 now
 		budget->dvb_frontend = stv0299_attach(&alps_bsbe1_config, &budget->i2c_adap);
 		if (budget->dvb_frontend) {
-			budget->dvb_frontend->ops->set_voltage = lnbp21_set_voltage;
-			budget->dvb_frontend->ops->enable_high_lnb_voltage = lnbp21_enable_high_lnb_voltage;
 			budget->dvb_frontend->ops->dishnetwork_send_legacy_command = NULL;
-			if (lnbp21_init(budget)) {
+			if (lnbp21_init(budget->dvb_frontend, &budget->i2c_adap, LNBP21_LLC, 0)) {
 				printk("%s: No LNBP21 found!\n", __FUNCTION__);
 				goto error_out;
 			}
@@ -646,9 +515,7 @@ static void frontend_init(struct budget 
 	case 0x1016: // Hauppauge/TT Nova-S SE (samsung s5h1420/????(tda8260))
 		budget->dvb_frontend = s5h1420_attach(&s5h1420_config, &budget->i2c_adap);
 		if (budget->dvb_frontend) {
-			budget->dvb_frontend->ops->set_voltage = lnbp21_set_voltage;
-			budget->dvb_frontend->ops->enable_high_lnb_voltage = lnbp21_enable_high_lnb_voltage;
-			if (lnbp21_init(budget)) {
+			if (lnbp21_init(budget->dvb_frontend, &budget->i2c_adap, 0, 0)) {
 				printk("%s: No LNBP21 found!\n", __FUNCTION__);
 				goto error_out;
 			}

