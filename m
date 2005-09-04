Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbVIDXou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbVIDXou (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 19:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbVIDXaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 19:30:46 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:36225 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932120AbVIDXaW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 19:30:22 -0400
Message-Id: <20050904232320.909281000@abc>
References: <20050904232259.777473000@abc>
Date: Mon, 05 Sep 2005 01:23:12 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andreas Oberritter <obi@linuxtv.org>
Content-Disposition: inline; filename=dvb-frontend-pass-i2c-bus-to-pll-callbacks.patch
X-SA-Exim-Connect-IP: 84.189.198.88
Subject: [DVB patch 13/54] frontend: stv0299: pass i2c bus to pll callback
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Oberritter <obi@linuxtv.org>

Pass a pointer to the i2c bus to the pll callbacks (stv0299 only).

It was not possible to tell which i2c bus should be used if an adapter has
multiple frontends on multiple i2c buses.

Signed-off-by: Andreas Oberritter <obi@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/b2c2/flexcop-fe-tuner.c         |    5 ++---
 drivers/media/dvb/frontends/stv0299.c             |    6 +++---
 drivers/media/dvb/frontends/stv0299.h             |    4 ++--
 drivers/media/dvb/ttpci/av7110.c                  |   10 ++++------
 drivers/media/dvb/ttpci/budget-av.c               |    4 ++--
 drivers/media/dvb/ttpci/budget-ci.c               |    9 ++++-----
 drivers/media/dvb/ttpci/budget-patch.c            |    5 ++---
 drivers/media/dvb/ttpci/budget.c                  |    5 ++---
 drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c |    4 ++--
 9 files changed, 23 insertions(+), 29 deletions(-)

--- linux-2.6.13-git4.orig/drivers/media/dvb/b2c2/flexcop-fe-tuner.c	2005-09-04 22:54:07.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/b2c2/flexcop-fe-tuner.c	2005-09-04 22:54:23.000000000 +0200
@@ -164,12 +164,11 @@ static int samsung_tbmu24112_set_symbol_
 	return 0;
 }
 
-static int samsung_tbmu24112_pll_set(struct dvb_frontend* fe, struct dvb_frontend_parameters* params)
+static int samsung_tbmu24112_pll_set(struct dvb_frontend* fe, struct i2c_adapter *i2c, struct dvb_frontend_parameters* params)
 {
 	u8 buf[4];
 	u32 div;
 	struct i2c_msg msg = { .addr = 0x61, .flags = 0, .buf = buf, .len = sizeof(buf) };
-	struct flexcop_device *fc = fe->dvb->priv;
 
 	div = params->frequency / 125;
 
@@ -180,7 +179,7 @@ static int samsung_tbmu24112_pll_set(str
 
 	if (params->frequency < 1500000) buf[3] |= 0x10;
 
-	if (i2c_transfer(&fc->i2c_adap, &msg, 1) != 1)
+	if (i2c_transfer(i2c, &msg, 1) != 1)
 		return -EIO;
 	return 0;
 }
--- linux-2.6.13-git4.orig/drivers/media/dvb/frontends/stv0299.c	2005-09-04 22:54:07.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/frontends/stv0299.c	2005-09-04 22:54:23.000000000 +0200
@@ -481,7 +481,7 @@ static int stv0299_init (struct dvb_fron
 
 	if (state->config->pll_init) {
 		stv0299_writeregI(state, 0x05, 0xb5);	/*  enable i2c repeater on stv0299  */
-		state->config->pll_init(fe);
+		state->config->pll_init(fe, state->i2c);
 		stv0299_writeregI(state, 0x05, 0x35);	/*  disable i2c repeater on stv0299  */
 	}
 
@@ -603,7 +603,7 @@ static int stv0299_set_frontend(struct d
 		} else {
 			/* A "normal" tune is requested */
 			stv0299_writeregI(state, 0x05, 0xb5);	/*  enable i2c repeater on stv0299  */
-			state->config->pll_set(fe, p);
+			state->config->pll_set(fe, state->i2c, p);
 			stv0299_writeregI(state, 0x05, 0x35);	/*  disable i2c repeater on stv0299  */
 
 			stv0299_writeregI(state, 0x32, 0x80);
@@ -615,7 +615,7 @@ static int stv0299_set_frontend(struct d
 		}
 	} else {
 		stv0299_writeregI(state, 0x05, 0xb5);	/*  enable i2c repeater on stv0299  */
-		state->config->pll_set(fe, p);
+		state->config->pll_set(fe, state->i2c, p);
 		stv0299_writeregI(state, 0x05, 0x35);	/*  disable i2c repeater on stv0299  */
 
 		stv0299_set_FEC (state, p->u.qpsk.fec_inner);
--- linux-2.6.13-git4.orig/drivers/media/dvb/frontends/stv0299.h	2005-09-04 22:54:07.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/frontends/stv0299.h	2005-09-04 22:54:23.000000000 +0200
@@ -92,8 +92,8 @@ struct stv0299_config
 	int (*set_symbol_rate)(struct dvb_frontend* fe, u32 srate, u32 ratio);
 
 	/* PLL maintenance */
-	int (*pll_init)(struct dvb_frontend* fe);
-	int (*pll_set)(struct dvb_frontend* fe, struct dvb_frontend_parameters* params);
+	int (*pll_init)(struct dvb_frontend *fe, struct i2c_adapter *i2c);
+	int (*pll_set)(struct dvb_frontend *fe, struct i2c_adapter *i2c, struct dvb_frontend_parameters *params);
 };
 
 extern int stv0299_writereg (struct dvb_frontend* fe, u8 reg, u8 data);
--- linux-2.6.13-git4.orig/drivers/media/dvb/ttpci/av7110.c	2005-09-04 22:54:07.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/ttpci/av7110.c	2005-09-04 22:54:23.000000000 +0200
@@ -1668,9 +1668,8 @@ static int alps_bsru6_set_symbol_rate(st
 	return 0;
 }
 
-static int alps_bsru6_pll_set(struct dvb_frontend* fe, struct dvb_frontend_parameters* params)
+static int alps_bsru6_pll_set(struct dvb_frontend* fe, struct i2c_adapter *i2c, struct dvb_frontend_parameters* params)
 {
-	struct av7110* av7110 = (struct av7110*) fe->dvb->priv;
 	int ret;
 	u8 data[4];
 	u32 div;
@@ -1687,7 +1686,7 @@ static int alps_bsru6_pll_set(struct dvb
 
 	if (params->frequency > 1530000) data[3] = 0xc0;
 
-	ret = i2c_transfer(&av7110->i2c_adap, &msg, 1);
+	ret = i2c_transfer(i2c, &msg, 1);
 	if (ret != 1)
 		return -EIO;
 	return 0;
@@ -1751,9 +1750,8 @@ static u8 alps_bsbe1_inittab[] = {
 	0xff, 0xff
 };
 
-static int alps_bsbe1_pll_set(struct dvb_frontend* fe, struct dvb_frontend_parameters* params)
+static int alps_bsbe1_pll_set(struct dvb_frontend* fe, struct i2c_adapter *i2c, struct dvb_frontend_parameters* params)
 {
-	struct av7110* av7110 = (struct av7110*) fe->dvb->priv;
 	int ret;
 	u8 data[4];
 	u32 div;
@@ -1768,7 +1766,7 @@ static int alps_bsbe1_pll_set(struct dvb
 	data[2] = 0x80 | ((div & 0x18000) >> 10) | 4;
 	data[3] = (params->frequency > 1530000) ? 0xE0 : 0xE4;
 
-	ret = i2c_transfer(&av7110->i2c_adap, &msg, 1);
+	ret = i2c_transfer(i2c, &msg, 1);
 	return (ret != 1) ? -EIO : 0;
 }
 
--- linux-2.6.13-git4.orig/drivers/media/dvb/ttpci/budget-ci.c	2005-09-04 22:54:07.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/ttpci/budget-ci.c	2005-09-04 22:54:23.000000000 +0200
@@ -548,9 +548,8 @@ static int alps_bsru6_set_symbol_rate(st
 	return 0;
 }
 
-static int alps_bsru6_pll_set(struct dvb_frontend *fe, struct dvb_frontend_parameters *params)
+static int alps_bsru6_pll_set(struct dvb_frontend *fe, struct i2c_adapter *i2c, struct dvb_frontend_parameters *params)
 {
-	struct budget_ci *budget_ci = (struct budget_ci *) fe->dvb->priv;
 	u8 buf[4];
 	u32 div;
 	struct i2c_msg msg = {.addr = 0x61,.flags = 0,.buf = buf,.len = sizeof(buf) };
@@ -567,7 +566,7 @@ static int alps_bsru6_pll_set(struct dvb
 	if (params->frequency > 1530000)
 		buf[3] = 0xc0;
 
-	if (i2c_transfer(&budget_ci->budget.i2c_adap, &msg, 1) != 1)
+	if (i2c_transfer(i2c, &msg, 1) != 1)
 		return -EIO;
 	return 0;
 }
@@ -669,9 +668,9 @@ static int philips_su1278_tt_set_symbol_
 }
 
 static int philips_su1278_tt_pll_set(struct dvb_frontend *fe,
+				     struct i2c_adapter *i2c,
 				     struct dvb_frontend_parameters *params)
 {
-	struct budget_ci *budget_ci = (struct budget_ci *) fe->dvb->priv;
 	u32 div;
 	u8 buf[4];
 	struct i2c_msg msg = {.addr = 0x60,.flags = 0,.buf = buf,.len = sizeof(buf) };
@@ -697,7 +696,7 @@ static int philips_su1278_tt_pll_set(str
 	else if (params->frequency < 2150000)
 		buf[3] |= 0xC0;
 
-	if (i2c_transfer(&budget_ci->budget.i2c_adap, &msg, 1) != 1)
+	if (i2c_transfer(i2c, &msg, 1) != 1)
 		return -EIO;
 	return 0;
 }
--- linux-2.6.13-git4.orig/drivers/media/dvb/ttpci/budget-patch.c	2005-09-04 22:54:07.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/ttpci/budget-patch.c	2005-09-04 22:54:23.000000000 +0200
@@ -353,9 +353,8 @@ static int alps_bsru6_set_symbol_rate(st
 	return 0;
 }
 
-static int alps_bsru6_pll_set(struct dvb_frontend* fe, struct dvb_frontend_parameters* params)
+static int alps_bsru6_pll_set(struct dvb_frontend* fe, struct i2c_adapter *i2c, struct dvb_frontend_parameters* params)
 {
-	struct budget_patch* budget = (struct budget_patch*) fe->dvb->priv;
 	u8 data[4];
 	u32 div;
 	struct i2c_msg msg = { .addr = 0x61, .flags = 0, .buf = data, .len = sizeof(data) };
@@ -370,7 +369,7 @@ static int alps_bsru6_pll_set(struct dvb
 
 	if (params->frequency > 1530000) data[3] = 0xc0;
 
-	if (i2c_transfer (&budget->i2c_adap, &msg, 1) != 1) return -EIO;
+	if (i2c_transfer(i2c, &msg, 1) != 1) return -EIO;
 	return 0;
 }
 
--- linux-2.6.13-git4.orig/drivers/media/dvb/ttpci/budget.c	2005-09-04 22:54:07.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/ttpci/budget.c	2005-09-04 22:54:23.000000000 +0200
@@ -332,9 +332,8 @@ static int alps_bsru6_set_symbol_rate(st
 	return 0;
 }
 
-static int alps_bsru6_pll_set(struct dvb_frontend* fe, struct dvb_frontend_parameters* params)
+static int alps_bsru6_pll_set(struct dvb_frontend* fe, struct i2c_adapter *i2c, struct dvb_frontend_parameters* params)
 {
-	struct budget* budget = (struct budget*) fe->dvb->priv;
 	u8 data[4];
 	u32 div;
 	struct i2c_msg msg = { .addr = 0x61, .flags = 0, .buf = data, .len = sizeof(data) };
@@ -349,7 +348,7 @@ static int alps_bsru6_pll_set(struct dvb
 
 	if (params->frequency > 1530000) data[3] = 0xc0;
 
-	if (i2c_transfer (&budget->i2c_adap, &msg, 1) != 1) return -EIO;
+	if (i2c_transfer(i2c, &msg, 1) != 1) return -EIO;
 	return 0;
 }
 
--- linux-2.6.13-git4.orig/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c	2005-09-04 22:54:07.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c	2005-09-04 22:54:23.000000000 +0200
@@ -1299,7 +1299,7 @@ static int alps_stv0299_set_symbol_rate(
 	return 0;
 }
 
-static int philips_tsa5059_pll_set(struct dvb_frontend *fe, struct dvb_frontend_parameters *params)
+static int philips_tsa5059_pll_set(struct dvb_frontend *fe, struct i2c_adapter *i2c, struct dvb_frontend_parameters *params)
 {
 	struct ttusb* ttusb = (struct ttusb*) fe->dvb->priv;
 	u8 buf[4];
@@ -1322,7 +1322,7 @@ static int philips_tsa5059_pll_set(struc
 	if (ttusb->revision == TTUSB_REV_2_2)
 		buf[3] |= 0x20;
 
-	if (i2c_transfer(&ttusb->i2c_adap, &msg, 1) != 1)
+	if (i2c_transfer(i2c, &msg, 1) != 1)
 		return -EIO;
 
 	return 0;
--- linux-2.6.13-git4.orig/drivers/media/dvb/ttpci/budget-av.c	2005-09-04 22:31:15.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/ttpci/budget-av.c	2005-09-04 22:54:43.000000000 +0200
@@ -453,9 +453,9 @@ static int philips_su1278_ty_ci_set_symb
 }
 
 static int philips_su1278_ty_ci_pll_set(struct dvb_frontend *fe,
+					struct i2c_adapter *i2c,
 					struct dvb_frontend_parameters *params)
 {
-	struct budget_av *budget_av = (struct budget_av *) fe->dvb->priv;
 	u32 div;
 	u8 buf[4];
 	struct i2c_msg msg = {.addr = 0x61,.flags = 0,.buf = buf,.len = sizeof(buf) };
@@ -481,7 +481,7 @@ static int philips_su1278_ty_ci_pll_set(
 	else if (params->frequency < 2150000)
 		buf[3] |= 0xC0;
 
-	if (i2c_transfer(&budget_av->budget.i2c_adap, &msg, 1) != 1)
+	if (i2c_transfer(i2c, &msg, 1) != 1)
 		return -EIO;
 	return 0;
 }

--

