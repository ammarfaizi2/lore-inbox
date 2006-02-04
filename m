Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932584AbWBDXhx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932584AbWBDXhx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 18:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932585AbWBDXhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 18:37:53 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:24584 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932584AbWBDXhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 18:37:52 -0500
Date: Sun, 5 Feb 2006 00:37:51 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andreas Oberritter <obi@linuxtv.org>
Cc: linux-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/media/dvb/frontends/mt312.c: possible cleanups
Message-ID: <20060204233751.GH4528@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- update the Kconfig help to mention the VP310
- merge vp310_attach and mt312_attach into a new vp310_mt312_attach
  to remove some code duplication


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 28 Jan 2006

 drivers/media/dvb/b2c2/flexcop-fe-tuner.c |    2 
 drivers/media/dvb/frontends/Kconfig       |    2 
 drivers/media/dvb/frontends/mt312.c       |  111 +++++++---------------
 drivers/media/dvb/frontends/mt312.h       |    6 -
 4 files changed, 43 insertions(+), 78 deletions(-)

--- linux-2.6.16-rc1-mm3-full/drivers/media/dvb/frontends/Kconfig.old	2006-01-28 17:12:59.000000000 +0100
+++ linux-2.6.16-rc1-mm3-full/drivers/media/dvb/frontends/Kconfig	2006-01-28 17:13:26.000000000 +0100
@@ -29,7 +29,7 @@
 	  A DVB-S tuner module. Say Y when you want to support this frontend.
 
 config DVB_MT312
-	tristate "Zarlink MT312 based"
+	tristate "Zarlink VP310/MT312 based"
 	depends on DVB_CORE
 	help
 	  A DVB-S tuner module. Say Y when you want to support this frontend.
--- linux-2.6.16-rc1-mm3-full/drivers/media/dvb/frontends/mt312.h.old	2006-01-28 17:23:16.000000000 +0100
+++ linux-2.6.16-rc1-mm3-full/drivers/media/dvb/frontends/mt312.h	2006-01-28 17:23:45.000000000 +0100
@@ -38,10 +38,8 @@
 	int (*pll_set)(struct dvb_frontend* fe, struct dvb_frontend_parameters* params);
 };
 
-extern struct dvb_frontend* mt312_attach(const struct mt312_config* config,
-					 struct i2c_adapter* i2c);
+struct dvb_frontend* vp310_mt312_attach(const struct mt312_config* config,
+					struct i2c_adapter* i2c);
 
-extern struct dvb_frontend* vp310_attach(const struct mt312_config* config,
-					 struct i2c_adapter* i2c);
 
 #endif // MT312_H
--- linux-2.6.16-rc1-mm3-full/drivers/media/dvb/frontends/mt312.c.old	2006-01-28 17:13:36.000000000 +0100
+++ linux-2.6.16-rc1-mm3-full/drivers/media/dvb/frontends/mt312.c	2006-01-28 17:20:15.000000000 +0100
@@ -612,76 +612,6 @@
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
@@ -720,6 +650,44 @@
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
+	if (state->id == ID_VP310){
+		strcpy(state->ops.info.name, "Zarlink VP310 DVB-S");
+		state->frequency = 90;
+	} else if (state->id == ID_MT312) {
+		strcpy(state->ops.info.name, "Zarlink MT312 DVB-S");
+		state->frequency = 60;
+	} else
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
 module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug, "Turn on/off frontend debugging (default:off).");
 
@@ -727,5 +695,4 @@
 MODULE_AUTHOR("Andreas Oberritter <obi@linuxtv.org>");
 MODULE_LICENSE("GPL");
 
-EXPORT_SYMBOL(mt312_attach);
-EXPORT_SYMBOL(vp310_attach);
+EXPORT_SYMBOL(vp310_mt312_attach);
--- linux-2.6.16-rc1-mm3-full/drivers/media/dvb/b2c2/flexcop-fe-tuner.c.old	2006-01-28 17:17:41.000000000 +0100
+++ linux-2.6.16-rc1-mm3-full/drivers/media/dvb/b2c2/flexcop-fe-tuner.c	2006-01-28 17:29:53.000000000 +0100
@@ -526,7 +526,7 @@
 		info("found the stv0297 at i2c address: 0x%02x",alps_tdee4_stv0297_config.demod_address);
 	} else
 	/* try the sky v2.3 (vp310/Samsung tbdu18132(tsa5059)) */
-	if ((fc->fe = vp310_attach(&skystar23_samsung_tbdu18132_config, &fc->i2c_adap)) != NULL) {
+	if ((fc->fe = vp310_mt312_attach(&skystar23_samsung_tbdu18132_config, &fc->i2c_adap)) != NULL) {
 		ops = fc->fe->ops;
 
 		ops->diseqc_send_master_cmd = flexcop_diseqc_send_master_cmd;

