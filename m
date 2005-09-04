Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbVIDXdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbVIDXdE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 19:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbVIDXcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 19:32:41 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:58753 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932150AbVIDXbK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 19:31:10 -0400
Message-Id: <20050904232334.237562000@abc>
References: <20050904232259.777473000@abc>
Date: Mon, 05 Sep 2005 01:23:45 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andrew de Quincey <adq_dvb@lidskialf.net>
Content-Disposition: inline; filename=dvb-ttpci-add-dvb-c-ci-support.patch
X-SA-Exim-Connect-IP: 84.189.198.88
Subject: [DVB patch 46/54] budget-ci: add support for TT DVB-C CI card
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew de Quincey <adq_dvb@lidskialf.net>

Add support for TT DVB-C CI card.

Signed-off-by: Andrew de Quincey <adq_dvb@lidskialf.net>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/b2c2/flexcop-fe-tuner.c |   97 +++++++++++++++
 drivers/media/dvb/frontends/stv0297.c     |  121 -------------------
 drivers/media/dvb/frontends/stv0297.h     |    8 +
 drivers/media/dvb/ttpci/av7110.c          |   95 +++++++++++++++
 drivers/media/dvb/ttpci/budget-ci.c       |  188 +++++++++++++++++++++++++++++-
 5 files changed, 387 insertions(+), 122 deletions(-)

--- linux-2.6.13-git4.orig/drivers/media/dvb/ttpci/budget-ci.c	2005-09-04 22:28:03.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/ttpci/budget-ci.c	2005-09-04 22:30:55.000000000 +0200
@@ -40,6 +40,7 @@
 
 #include "dvb_ca_en50221.h"
 #include "stv0299.h"
+#include "stv0297.h"
 #include "tda1004x.h"
 
 #define DEBIADDR_IR		0x1234
@@ -847,6 +848,180 @@ static struct tda1004x_config philips_td
 	.request_firmware = philips_tdm1316l_request_firmware,
 };
 
+static int dvbc_philips_tdm1316l_pll_set(struct dvb_frontend *fe, struct dvb_frontend_parameters *params)
+{
+	struct budget_ci *budget_ci = (struct budget_ci *) fe->dvb->priv;
+	u8 tuner_buf[5];
+	struct i2c_msg tuner_msg = {.addr = budget_ci->tuner_pll_address,
+				    .flags = 0,
+				    .buf = tuner_buf,
+				    .len = sizeof(tuner_buf) };
+	int tuner_frequency = 0;
+	u8 band, cp, filter;
+
+	// determine charge pump
+	tuner_frequency = params->frequency + 36125000;
+	if (tuner_frequency < 87000000)
+		return -EINVAL;
+	else if (tuner_frequency < 130000000) {
+		cp = 3;
+		band = 1;
+	} else if (tuner_frequency < 160000000) {
+		cp = 5;
+		band = 1;
+	} else if (tuner_frequency < 200000000) {
+		cp = 6;
+		band = 1;
+	} else if (tuner_frequency < 290000000) {
+		cp = 3;
+		band = 2;
+	} else if (tuner_frequency < 420000000) {
+		cp = 5;
+		band = 2;
+	} else if (tuner_frequency < 480000000) {
+		cp = 6;
+		band = 2;
+	} else if (tuner_frequency < 620000000) {
+		cp = 3;
+		band = 4;
+	} else if (tuner_frequency < 830000000) {
+		cp = 5;
+		band = 4;
+	} else if (tuner_frequency < 895000000) {
+		cp = 7;
+		band = 4;
+	} else
+		return -EINVAL;
+
+	// assume PLL filter should always be 8MHz for the moment.
+	filter = 1;
+
+	// calculate divisor
+	tuner_frequency = (params->frequency + 36125000 + (62500/2)) / 62500;
+
+	// setup tuner buffer
+	tuner_buf[0] = tuner_frequency >> 8;
+	tuner_buf[1] = tuner_frequency & 0xff;
+	tuner_buf[2] = 0xc8;
+	tuner_buf[3] = (cp << 5) | (filter << 3) | band;
+	tuner_buf[4] = 0x80;
+
+	stv0297_enable_plli2c(fe);
+	if (i2c_transfer(&budget_ci->budget.i2c_adap, &tuner_msg, 1) != 1)
+		return -EIO;
+
+	msleep(50);
+
+	stv0297_enable_plli2c(fe);
+	if (i2c_transfer(&budget_ci->budget.i2c_adap, &tuner_msg, 1) != 1)
+		return -EIO;
+
+	msleep(1);
+
+	return 0;
+}
+
+static u8 dvbc_philips_tdm1316l_inittab[] = {
+	0x80, 0x01,
+	0x80, 0x00,
+	0x81, 0x01,
+	0x81, 0x00,
+	0x00, 0x09,
+	0x01, 0x69,
+	0x03, 0x00,
+	0x04, 0x00,
+	0x07, 0x00,
+	0x08, 0x00,
+	0x20, 0x00,
+	0x21, 0x40,
+	0x22, 0x00,
+	0x23, 0x00,
+	0x24, 0x40,
+	0x25, 0x88,
+	0x30, 0xff,
+	0x31, 0x00,
+	0x32, 0xff,
+	0x33, 0x00,
+	0x34, 0x50,
+	0x35, 0x7f,
+	0x36, 0x00,
+	0x37, 0x20,
+	0x38, 0x00,
+	0x40, 0x1c,
+	0x41, 0xff,
+	0x42, 0x29,
+	0x43, 0x20,
+	0x44, 0xff,
+	0x45, 0x00,
+	0x46, 0x00,
+	0x49, 0x04,
+	0x4a, 0x00,
+	0x4b, 0x7b,
+	0x52, 0x30,
+	0x55, 0xae,
+	0x56, 0x47,
+	0x57, 0xe1,
+	0x58, 0x3a,
+	0x5a, 0x1e,
+	0x5b, 0x34,
+	0x60, 0x00,
+	0x63, 0x00,
+	0x64, 0x00,
+	0x65, 0x00,
+	0x66, 0x00,
+	0x67, 0x00,
+	0x68, 0x00,
+	0x69, 0x00,
+	0x6a, 0x02,
+	0x6b, 0x00,
+	0x70, 0xff,
+	0x71, 0x00,
+	0x72, 0x00,
+	0x73, 0x00,
+	0x74, 0x0c,
+	0x80, 0x00,
+	0x81, 0x00,
+	0x82, 0x00,
+	0x83, 0x00,
+	0x84, 0x04,
+	0x85, 0x80,
+	0x86, 0x24,
+	0x87, 0x78,
+	0x88, 0x10,
+	0x89, 0x00,
+	0x90, 0x01,
+	0x91, 0x01,
+	0xa0, 0x04,
+	0xa1, 0x00,
+	0xa2, 0x00,
+	0xb0, 0x91,
+	0xb1, 0x0b,
+	0xc0, 0x53,
+	0xc1, 0x70,
+	0xc2, 0x12,
+	0xd0, 0x00,
+	0xd1, 0x00,
+	0xd2, 0x00,
+	0xd3, 0x00,
+	0xd4, 0x00,
+	0xd5, 0x00,
+	0xde, 0x00,
+	0xdf, 0x00,
+	0x61, 0x38,
+	0x62, 0x0a,
+	0x53, 0x13,
+	0x59, 0x08,
+	0xff, 0xff,
+};
+
+static struct stv0297_config dvbc_philips_tdm1316l_config = {
+	.demod_address = 0x1c,
+	.inittab = dvbc_philips_tdm1316l_inittab,
+	.invert = 0,
+	.pll_set = dvbc_philips_tdm1316l_pll_set,
+};
+
+
 
 
 static void frontend_init(struct budget_ci *budget_ci)
@@ -868,6 +1043,15 @@ static void frontend_init(struct budget_
 		}
 		break;
 
+	case 0x1010:		// TT DVB-C CI budget (stv0297/Philips tdm1316l(tda6651tt))
+		budget_ci->tuner_pll_address = 0x61;
+		budget_ci->budget.dvb_frontend =
+			stv0297_attach(&dvbc_philips_tdm1316l_config, &budget_ci->budget.i2c_adap);
+		if (budget_ci->budget.dvb_frontend) {
+			break;
+		}
+		break;
+
 	case 0x1011:		// Hauppauge/TT Nova-T budget (tda10045/Philips tdm1316l(tda6651tt) + TDA9889)
 		budget_ci->tuner_pll_address = 0x63;
 		budget_ci->budget.dvb_frontend =
@@ -877,7 +1061,7 @@ static void frontend_init(struct budget_
 		}
 		break;
 
-	case 0x1012:		// Hauppauge/TT Nova-T CI budget (tda10045/Philips tdm1316l(tda6651tt) + TDA9889)
+	case 0x1012:		// TT DVB-T CI budget (tda10046/Philips tdm1316l(tda6651tt))
 		budget_ci->tuner_pll_address = 0x60;
 		budget_ci->budget.dvb_frontend =
 			tda10046_attach(&philips_tdm1316l_config, &budget_ci->budget.i2c_adap);
@@ -965,10 +1149,12 @@ static struct saa7146_extension budget_e
 MAKE_BUDGET_INFO(ttbci, "TT-Budget/WinTV-NOVA-CI PCI", BUDGET_TT_HW_DISEQC);
 MAKE_BUDGET_INFO(ttbt2, "TT-Budget/WinTV-NOVA-T	 PCI", BUDGET_TT);
 MAKE_BUDGET_INFO(ttbtci, "TT-Budget-T-CI PCI", BUDGET_TT);
+MAKE_BUDGET_INFO(ttbcci, "TT-Budget-C-CI PCI", BUDGET_TT);
 
 static struct pci_device_id pci_tbl[] = {
 	MAKE_EXTENSION_PCI(ttbci, 0x13c2, 0x100c),
 	MAKE_EXTENSION_PCI(ttbci, 0x13c2, 0x100f),
+	MAKE_EXTENSION_PCI(ttbcci, 0x13c2, 0x1010),
 	MAKE_EXTENSION_PCI(ttbt2, 0x13c2, 0x1011),
 	MAKE_EXTENSION_PCI(ttbtci, 0x13c2, 0x1012),
 	{
--- linux-2.6.13-git4.orig/drivers/media/dvb/frontends/stv0297.c	2005-09-04 22:28:12.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/frontends/stv0297.c	2005-09-04 22:30:55.000000000 +0200
@@ -35,7 +35,6 @@ struct stv0297_state {
 	struct dvb_frontend frontend;
 
 	unsigned long base_freq;
-	u8 pwm;
 };
 
 #if 1
@@ -46,94 +45,6 @@ struct stv0297_state {
 
 #define STV0297_CLOCK_KHZ   28900
 
-static u8 init_tab[] = {
-	0x00, 0x09,
-	0x01, 0x69,
-	0x03, 0x00,
-	0x04, 0x00,
-	0x07, 0x00,
-	0x08, 0x00,
-	0x20, 0x00,
-	0x21, 0x40,
-	0x22, 0x00,
-	0x23, 0x00,
-	0x24, 0x40,
-	0x25, 0x88,
-	0x30, 0xff,
-	0x31, 0x00,
-	0x32, 0xff,
-	0x33, 0x00,
-	0x34, 0x50,
-	0x35, 0x7f,
-	0x36, 0x00,
-	0x37, 0x20,
-	0x38, 0x00,
-	0x40, 0x1c,
-	0x41, 0xff,
-	0x42, 0x29,
-	0x43, 0x00,
-	0x44, 0xff,
-	0x45, 0x00,
-	0x46, 0x00,
-	0x49, 0x04,
-	0x4a, 0xff,
-	0x4b, 0x7f,
-	0x52, 0x30,
-	0x55, 0xae,
-	0x56, 0x47,
-	0x57, 0xe1,
-	0x58, 0x3a,
-	0x5a, 0x1e,
-	0x5b, 0x34,
-	0x60, 0x00,
-	0x63, 0x00,
-	0x64, 0x00,
-	0x65, 0x00,
-	0x66, 0x00,
-	0x67, 0x00,
-	0x68, 0x00,
-	0x69, 0x00,
-	0x6a, 0x02,
-	0x6b, 0x00,
-	0x70, 0xff,
-	0x71, 0x00,
-	0x72, 0x00,
-	0x73, 0x00,
-	0x74, 0x0c,
-	0x80, 0x00,
-	0x81, 0x00,
-	0x82, 0x00,
-	0x83, 0x00,
-	0x84, 0x04,
-	0x85, 0x80,
-	0x86, 0x24,
-	0x87, 0x78,
-	0x88, 0x00,
-	0x89, 0x00,
-	0x90, 0x01,
-	0x91, 0x01,
-	0xa0, 0x00,
-	0xa1, 0x00,
-	0xa2, 0x00,
-	0xb0, 0x91,
-	0xb1, 0x0b,
-	0xc0, 0x53,
-	0xc1, 0x70,
-	0xc2, 0x12,
-	0xd0, 0x00,
-	0xd1, 0x00,
-	0xd2, 0x00,
-	0xd3, 0x00,
-	0xd4, 0x00,
-	0xd5, 0x00,
-	0xde, 0x00,
-	0xdf, 0x00,
-	0x61, 0x49,
-	0x62, 0x0b,
-	0x53, 0x08,
-	0x59, 0x08,
-};
-
 
 static int stv0297_writereg(struct stv0297_state *state, u8 reg, u8 data)
 {
@@ -378,34 +289,9 @@ static int stv0297_init(struct dvb_front
 	struct stv0297_state *state = fe->demodulator_priv;
 	int i;
 
-	/* soft reset */
-	stv0297_writereg_mask(state, 0x80, 1, 1);
-	stv0297_writereg_mask(state, 0x80, 1, 0);
-
-	/* reset deinterleaver */
-	stv0297_writereg_mask(state, 0x81, 1, 1);
-	stv0297_writereg_mask(state, 0x81, 1, 0);
-
 	/* load init table */
-	for (i = 0; i < sizeof(init_tab); i += 2) {
-		stv0297_writereg(state, init_tab[i], init_tab[i + 1]);
-	}
-
-	/* set a dummy symbol rate */
-	stv0297_set_symbolrate(state, 6900);
-
-	/* invert AGC1 polarity */
-	stv0297_writereg_mask(state, 0x88, 0x10, 0x10);
-
-	/* setup bit error counting */
-	stv0297_writereg_mask(state, 0xA0, 0x80, 0x00);
-	stv0297_writereg_mask(state, 0xA0, 0x10, 0x00);
-	stv0297_writereg_mask(state, 0xA0, 0x08, 0x00);
-	stv0297_writereg_mask(state, 0xA0, 0x07, 0x04);
-
-	/* min + max PWM */
-	stv0297_writereg(state, 0x4a, 0x00);
-	stv0297_writereg(state, 0x4b, state->pwm);
+	for (i=0; !(state->config->inittab[i] == 0xff && state->config->inittab[i+1] == 0xff); i+=2)
+		stv0297_writereg(state, state->config->inittab[i], state->config->inittab[i+1]);
 	msleep(200);
 
 	if (state->config->pll_init)
@@ -738,7 +624,7 @@ static void stv0297_release(struct dvb_f
 static struct dvb_frontend_ops stv0297_ops;
 
 struct dvb_frontend *stv0297_attach(const struct stv0297_config *config,
-				    struct i2c_adapter *i2c, int pwm)
+				    struct i2c_adapter *i2c)
 {
 	struct stv0297_state *state = NULL;
 
@@ -752,7 +638,6 @@ struct dvb_frontend *stv0297_attach(cons
 	state->i2c = i2c;
 	memcpy(&state->ops, &stv0297_ops, sizeof(struct dvb_frontend_ops));
 	state->base_freq = 0;
-	state->pwm = pwm;
 
 	/* check if the demod is there */
 	if ((stv0297_readreg(state, 0x80) & 0x70) != 0x20)
--- linux-2.6.13-git4.orig/drivers/media/dvb/frontends/stv0297.h	2005-09-04 22:03:40.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/frontends/stv0297.h	2005-09-04 22:30:55.000000000 +0200
@@ -29,6 +29,12 @@ struct stv0297_config
 	/* the demodulator's i2c address */
 	u8 demod_address;
 
+	/* inittab - array of pairs of values.
+	* First of each pair is the register, second is the value.
+	* List should be terminated with an 0xff, 0xff pair.
+	*/
+	u8* inittab;
+
 	/* does the "inversion" need inverted? */
 	u8 invert:1;
 
@@ -38,7 +44,7 @@ struct stv0297_config
 };
 
 extern struct dvb_frontend* stv0297_attach(const struct stv0297_config* config,
-					   struct i2c_adapter* i2c, int pwm);
+					   struct i2c_adapter* i2c);
 extern int stv0297_enable_plli2c(struct dvb_frontend* fe);
 
 #endif // STV0297_H
--- linux-2.6.13-git4.orig/drivers/media/dvb/ttpci/av7110.c	2005-09-04 22:28:03.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/ttpci/av7110.c	2005-09-04 22:30:55.000000000 +0200
@@ -1934,6 +1934,98 @@ static struct sp8870_config alps_tdlb7_c
 };
 
 
+static u8 nexusca_stv0297_inittab[] = {
+	0x80, 0x01,
+	0x80, 0x00,
+	0x81, 0x01,
+	0x81, 0x00,
+	0x00, 0x09,
+	0x01, 0x69,
+	0x03, 0x00,
+	0x04, 0x00,
+	0x07, 0x00,
+	0x08, 0x00,
+	0x20, 0x00,
+	0x21, 0x40,
+	0x22, 0x00,
+	0x23, 0x00,
+	0x24, 0x40,
+	0x25, 0x88,
+	0x30, 0xff,
+	0x31, 0x00,
+	0x32, 0xff,
+	0x33, 0x00,
+	0x34, 0x50,
+	0x35, 0x7f,
+	0x36, 0x00,
+	0x37, 0x20,
+	0x38, 0x00,
+	0x40, 0x1c,
+	0x41, 0xff,
+	0x42, 0x29,
+	0x43, 0x00,
+	0x44, 0xff,
+	0x45, 0x00,
+	0x46, 0x00,
+	0x49, 0x04,
+	0x4a, 0x00,
+	0x4b, 0x7b,
+	0x52, 0x30,
+	0x55, 0xae,
+	0x56, 0x47,
+	0x57, 0xe1,
+	0x58, 0x3a,
+	0x5a, 0x1e,
+	0x5b, 0x34,
+	0x60, 0x00,
+	0x63, 0x00,
+	0x64, 0x00,
+	0x65, 0x00,
+	0x66, 0x00,
+	0x67, 0x00,
+	0x68, 0x00,
+	0x69, 0x00,
+	0x6a, 0x02,
+	0x6b, 0x00,
+	0x70, 0xff,
+	0x71, 0x00,
+	0x72, 0x00,
+	0x73, 0x00,
+	0x74, 0x0c,
+	0x80, 0x00,
+	0x81, 0x00,
+	0x82, 0x00,
+	0x83, 0x00,
+	0x84, 0x04,
+	0x85, 0x80,
+	0x86, 0x24,
+	0x87, 0x78,
+	0x88, 0x10,
+	0x89, 0x00,
+	0x90, 0x01,
+	0x91, 0x01,
+	0xa0, 0x04,
+	0xa1, 0x00,
+	0xa2, 0x00,
+	0xb0, 0x91,
+	0xb1, 0x0b,
+	0xc0, 0x53,
+	0xc1, 0x70,
+	0xc2, 0x12,
+	0xd0, 0x00,
+	0xd1, 0x00,
+	0xd2, 0x00,
+	0xd3, 0x00,
+	0xd4, 0x00,
+	0xd5, 0x00,
+	0xde, 0x00,
+	0xdf, 0x00,
+	0x61, 0x49,
+	0x62, 0x0b,
+	0x53, 0x08,
+	0x59, 0x08,
+	0xff, 0xff,
+};
 
 static int nexusca_stv0297_pll_set(struct dvb_frontend* fe, struct dvb_frontend_parameters* params)
 {
@@ -1982,6 +2074,7 @@ static int nexusca_stv0297_pll_set(struc
 static struct stv0297_config nexusca_stv0297_config = {
 
 	.demod_address = 0x1C,
+	.inittab = nexusca_stv0297_inittab,
 	.invert = 1,
 	.pll_set = nexusca_stv0297_pll_set,
 };
@@ -2259,7 +2352,7 @@ static int frontend_init(struct av7110 *
 
 		case 0x000A: // Hauppauge/TT Nexus-CA rev1.X
 
-			av7110->fe = stv0297_attach(&nexusca_stv0297_config, &av7110->i2c_adap, 0x7b);
+			av7110->fe = stv0297_attach(&nexusca_stv0297_config, &av7110->i2c_adap);
 			if (av7110->fe) {
 				/* set TDA9819 into DVB mode */
 				saa7146_setgpio(av7110->dev, 1, SAA7146_GPIO_OUTLO); // TDA9198 pin9(STD)
--- linux-2.6.13-git4.orig/drivers/media/dvb/b2c2/flexcop-fe-tuner.c	2005-09-04 22:28:03.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/b2c2/flexcop-fe-tuner.c	2005-09-04 22:30:55.000000000 +0200
@@ -334,8 +334,103 @@ static struct mt312_config skystar23_sam
 	.pll_set = skystar23_samsung_tbdu18132_pll_set,
 };
 
+
+static u8 alps_tdee4_stv0297_inittab[] = {
+	0x80, 0x01,
+	0x80, 0x00,
+	0x81, 0x01,
+	0x81, 0x00,
+	0x00, 0x09,
+	0x01, 0x69,
+	0x03, 0x00,
+	0x04, 0x00,
+	0x07, 0x00,
+	0x08, 0x00,
+	0x20, 0x00,
+	0x21, 0x40,
+	0x22, 0x00,
+	0x23, 0x00,
+	0x24, 0x40,
+	0x25, 0x88,
+	0x30, 0xff,
+	0x31, 0x00,
+	0x32, 0xff,
+	0x33, 0x00,
+	0x34, 0x50,
+	0x35, 0x7f,
+	0x36, 0x00,
+	0x37, 0x20,
+	0x38, 0x00,
+	0x40, 0x1c,
+	0x41, 0xff,
+	0x42, 0x29,
+	0x43, 0x00,
+	0x44, 0xff,
+	0x45, 0x00,
+	0x46, 0x00,
+	0x49, 0x04,
+	0x4a, 0x00,
+	0x4b, 0xf8,
+	0x52, 0x30,
+	0x55, 0xae,
+	0x56, 0x47,
+	0x57, 0xe1,
+	0x58, 0x3a,
+	0x5a, 0x1e,
+	0x5b, 0x34,
+	0x60, 0x00,
+	0x63, 0x00,
+	0x64, 0x00,
+	0x65, 0x00,
+	0x66, 0x00,
+	0x67, 0x00,
+	0x68, 0x00,
+	0x69, 0x00,
+	0x6a, 0x02,
+	0x6b, 0x00,
+	0x70, 0xff,
+	0x71, 0x00,
+	0x72, 0x00,
+	0x73, 0x00,
+	0x74, 0x0c,
+	0x80, 0x00,
+	0x81, 0x00,
+	0x82, 0x00,
+	0x83, 0x00,
+	0x84, 0x04,
+	0x85, 0x80,
+	0x86, 0x24,
+	0x87, 0x78,
+	0x88, 0x10,
+	0x89, 0x00,
+	0x90, 0x01,
+	0x91, 0x01,
+	0xa0, 0x04,
+	0xa1, 0x00,
+	0xa2, 0x00,
+	0xb0, 0x91,
+	0xb1, 0x0b,
+	0xc0, 0x53,
+	0xc1, 0x70,
+	0xc2, 0x12,
+	0xd0, 0x00,
+	0xd1, 0x00,
+	0xd2, 0x00,
+	0xd3, 0x00,
+	0xd4, 0x00,
+	0xd5, 0x00,
+	0xde, 0x00,
+	0xdf, 0x00,
+	0x61, 0x49,
+	0x62, 0x0b,
+	0x53, 0x08,
+	0x59, 0x08,
+	0xff, 0xff,
+};
+
 static struct stv0297_config alps_tdee4_stv0297_config = {
 	.demod_address = 0x1c,
+	.inittab = alps_tdee4_stv0297_inittab,
 //	.invert = 1,
 //	.pll_set = alps_tdee4_stv0297_pll_set,
 };
@@ -369,7 +464,7 @@ int flexcop_frontend_init(struct flexcop
 		info("found the bcm3510 at i2c address: 0x%02x",air2pc_atsc_first_gen_config.demod_address);
 	} else
 	/* try the cable dvb (stv0297) */
-	if ((fc->fe = stv0297_attach(&alps_tdee4_stv0297_config, &fc->i2c_adap, 0xf8)) != NULL) {
+	if ((fc->fe = stv0297_attach(&alps_tdee4_stv0297_config, &fc->i2c_adap)) != NULL) {
 		fc->dev_type                        = FC_CABLE;
 		info("found the stv0297 at i2c address: 0x%02x",alps_tdee4_stv0297_config.demod_address);
 	} else

--

