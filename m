Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965721AbWCTQEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965721AbWCTQEk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 11:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965714AbWCTQEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 11:04:37 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:35480 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966423AbWCTPPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:15:49 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Adrian Bunk <bunk@stusta.de>,
       Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 085/141] V4L/DVB (3337):
	Drivers/media/dvb/frontends/mt312.c: cleanups
Date: Mon, 20 Mar 2006 12:08:51 -0300
Message-id: <20060320150851.PS209490000085@infradead.org>
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

From: Adrian Bunk <bunk@stusta.de>
Date: 1141009669 -0300

This patch contains the following possible cleanups:
- update the Kconfig help to mention the VP310
- merge vp310_attach and mt312_attach into a new vp310_mt312_attach
  to remove some code duplication

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/dvb/b2c2/flexcop-fe-tuner.c b/drivers/media/dvb/b2c2/flexcop-fe-tuner.c
diff --git a/drivers/media/dvb/b2c2/flexcop-fe-tuner.c b/drivers/media/dvb/b2c2/flexcop-fe-tuner.c
index 390cc3a..9c7f122 100644
--- a/drivers/media/dvb/b2c2/flexcop-fe-tuner.c
+++ b/drivers/media/dvb/b2c2/flexcop-fe-tuner.c
@@ -526,7 +526,7 @@ int flexcop_frontend_init(struct flexcop
 		info("found the stv0297 at i2c address: 0x%02x",alps_tdee4_stv0297_config.demod_address);
 	} else
 	/* try the sky v2.3 (vp310/Samsung tbdu18132(tsa5059)) */
-	if ((fc->fe = vp310_attach(&skystar23_samsung_tbdu18132_config, &fc->i2c_adap)) != NULL) {
+	if ((fc->fe = vp310_mt312_attach(&skystar23_samsung_tbdu18132_config, &fc->i2c_adap)) != NULL) {
 		ops = fc->fe->ops;
 
 		ops->diseqc_send_master_cmd = flexcop_diseqc_send_master_cmd;
diff --git a/drivers/media/dvb/frontends/Kconfig b/drivers/media/dvb/frontends/Kconfig
diff --git a/drivers/media/dvb/frontends/Kconfig b/drivers/media/dvb/frontends/Kconfig
index 76b6a2a..c676b1e 100644
--- a/drivers/media/dvb/frontends/Kconfig
+++ b/drivers/media/dvb/frontends/Kconfig
@@ -29,7 +29,7 @@ config DVB_TDA8083
 	  A DVB-S tuner module. Say Y when you want to support this frontend.
 
 config DVB_MT312
-	tristate "Zarlink MT312 based"
+	tristate "Zarlink VP310/MT312 based"
 	depends on DVB_CORE
 	help
 	  A DVB-S tuner module. Say Y when you want to support this frontend.
diff --git a/drivers/media/dvb/frontends/mt312.c b/drivers/media/dvb/frontends/mt312.c
diff --git a/drivers/media/dvb/frontends/mt312.c b/drivers/media/dvb/frontends/mt312.c
index ec4e641..d3aea83 100644
--- a/drivers/media/dvb/frontends/mt312.c
+++ b/drivers/media/dvb/frontends/mt312.c
@@ -612,76 +612,6 @@ static void mt312_release(struct dvb_fro
 	kfree(state);
 }
 
-static struct dvb_frontend_ops vp310_mt312_ops;
-
-struct dvb_frontend* vp310_attach(const struct mt312_config* config,
-				  struct i2c_adapter* i2c)
-{
-	struct mt312_state* state = NULL;
-
-	/* allocate memory for the internal state */
-	state = kmalloc(sizeof(struct mt312_state), GFP_KERNEL);
-	if (state == NULL)
-		goto error;
-
-	/* setup the state */
-	state->config = config;
-	state->i2c = i2c;
-	memcpy(&state->ops, &vp310_mt312_ops, sizeof(struct dvb_frontend_ops));
-	strcpy(state->ops.info.name, "Zarlink VP310 DVB-S");
-
-	/* check if the demod is there */
-	if (mt312_readreg(state, ID, &state->id) < 0)
-		goto error;
-	if (state->id != ID_VP310) {
-		goto error;
-	}
-
-	/* create dvb_frontend */
-	state->frequency = 90;
-	state->frontend.ops = &state->ops;
-	state->frontend.demodulator_priv = state;
-	return &state->frontend;
-
-error:
-	kfree(state);
-	return NULL;
-}
-
-struct dvb_frontend* mt312_attach(const struct mt312_config* config,
-				  struct i2c_adapter* i2c)
-{
-	struct mt312_state* state = NULL;
-
-	/* allocate memory for the internal state */
-	state = kmalloc(sizeof(struct mt312_state), GFP_KERNEL);
-	if (state == NULL)
-		goto error;
-
-	/* setup the state */
-	state->config = config;
-	state->i2c = i2c;
-	memcpy(&state->ops, &vp310_mt312_ops, sizeof(struct dvb_frontend_ops));
-	strcpy(state->ops.info.name, "Zarlink MT312 DVB-S");
-
-	/* check if the demod is there */
-	if (mt312_readreg(state, ID, &state->id) < 0)
-		goto error;
-	if (state->id != ID_MT312) {
-		goto error;
-	}
-
-	/* create dvb_frontend */
-	state->frequency = 60;
-	state->frontend.ops = &state->ops;
-	state->frontend.demodulator_priv = state;
-	return &state->frontend;
-
-error:
-	kfree(state);
-	return NULL;
-}
-
 static struct dvb_frontend_ops vp310_mt312_ops = {
 
 	.info = {
@@ -720,6 +650,49 @@ static struct dvb_frontend_ops vp310_mt3
 	.set_voltage = mt312_set_voltage,
 };
 
+struct dvb_frontend* vp310_mt312_attach(const struct mt312_config* config,
+					struct i2c_adapter* i2c)
+{
+	struct mt312_state* state = NULL;
+
+	/* allocate memory for the internal state */
+	state = kmalloc(sizeof(struct mt312_state), GFP_KERNEL);
+	if (state == NULL)
+		goto error;
+
+	/* setup the state */
+	state->config = config;
+	state->i2c = i2c;
+	memcpy(&state->ops, &vp310_mt312_ops, sizeof(struct dvb_frontend_ops));
+
+	/* check if the demod is there */
+	if (mt312_readreg(state, ID, &state->id) < 0)
+		goto error;
+
+	switch (state->id) {
+	case ID_VP310:
+		strcpy(state->ops.info.name, "Zarlink VP310 DVB-S");
+		state->frequency = 90;
+		break;
+	case ID_MT312:
+		strcpy(state->ops.info.name, "Zarlink MT312 DVB-S");
+		state->frequency = 60;
+		break;
+	default:
+		printk (KERN_WARNING "Only Zarlink VP310/MT312 are supported chips.\n");
+		goto error;
+	}
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
 module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug, "Turn on/off frontend debugging (default:off).");
 
@@ -727,5 +700,4 @@ MODULE_DESCRIPTION("Zarlink VP310/MT312 
 MODULE_AUTHOR("Andreas Oberritter <obi@linuxtv.org>");
 MODULE_LICENSE("GPL");
 
-EXPORT_SYMBOL(mt312_attach);
-EXPORT_SYMBOL(vp310_attach);
+EXPORT_SYMBOL(vp310_mt312_attach);
diff --git a/drivers/media/dvb/frontends/mt312.h b/drivers/media/dvb/frontends/mt312.h
diff --git a/drivers/media/dvb/frontends/mt312.h b/drivers/media/dvb/frontends/mt312.h
index b3a53a7..074d844 100644
--- a/drivers/media/dvb/frontends/mt312.h
+++ b/drivers/media/dvb/frontends/mt312.h
@@ -38,10 +38,8 @@ struct mt312_config
 	int (*pll_set)(struct dvb_frontend* fe, struct dvb_frontend_parameters* params);
 };
 
-extern struct dvb_frontend* mt312_attach(const struct mt312_config* config,
-					 struct i2c_adapter* i2c);
+struct dvb_frontend* vp310_mt312_attach(const struct mt312_config* config,
+					struct i2c_adapter* i2c);
 
-extern struct dvb_frontend* vp310_attach(const struct mt312_config* config,
-					 struct i2c_adapter* i2c);
 
 #endif // MT312_H

