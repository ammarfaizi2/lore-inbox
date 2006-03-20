Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965808AbWCTQKN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965808AbWCTQKN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 11:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965812AbWCTQKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 11:10:11 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:20120 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965164AbWCTPOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:14:24 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Manu Abraham <manu@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 116/141] V4L/DVB (3389): Fix broken IF-OUT Relay handling
Date: Mon, 20 Mar 2006 12:08:56 -0300
Message-id: <20060320150856.PS440758000116@infradead.org>
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

From: Manu Abraham <manu@linuxtv.org>
Date: 1141009769 -0300

Fixed broken IF-OUT on pinnacle sat board.
Thanks to Edgar Toernig

Signed-off-by: Manu Abraham <manu@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/dvb/bt8xx/dvb-bt8xx.c b/drivers/media/dvb/bt8xx/dvb-bt8xx.c
diff --git a/drivers/media/dvb/bt8xx/dvb-bt8xx.c b/drivers/media/dvb/bt8xx/dvb-bt8xx.c
index 1649846..f5bfcd2 100644
--- a/drivers/media/dvb/bt8xx/dvb-bt8xx.c
+++ b/drivers/media/dvb/bt8xx/dvb-bt8xx.c
@@ -239,6 +239,20 @@ static int cx24108_pll_set(struct dvb_fr
 
 static int pinnsat_pll_init(struct dvb_frontend* fe)
 {
+	struct dvb_bt8xx_card *card = fe->dvb->priv;
+
+	bttv_gpio_enable(card->bttv_nr, 1, 1);  /* output */
+	bttv_write_gpio(card->bttv_nr, 1, 1);   /* relay on */
+	
+	return 0;
+}
+
+static int pinnsat_pll_sleep(struct dvb_frontend* fe)
+{
+	struct dvb_bt8xx_card *card = fe->dvb->priv;
+
+	bttv_write_gpio(card->bttv_nr, 1, 0);   /* relay off */
+
 	return 0;
 }
 
@@ -246,6 +260,7 @@ static struct cx24110_config pctvsat_con
 	.demod_address = 0x55,
 	.pll_init = pinnsat_pll_init,
 	.pll_set = cx24108_pll_set,
+	.pll_sleep = pinnsat_pll_sleep,
 };
 
 static int microtune_mt7202dtf_pll_set(struct dvb_frontend* fe, struct dvb_frontend_parameters* params)
diff --git a/drivers/media/dvb/frontends/cx24110.c b/drivers/media/dvb/frontends/cx24110.c
diff --git a/drivers/media/dvb/frontends/cx24110.c b/drivers/media/dvb/frontends/cx24110.c
index cc68b7e..f3edf8b 100644
--- a/drivers/media/dvb/frontends/cx24110.c
+++ b/drivers/media/dvb/frontends/cx24110.c
@@ -371,6 +371,15 @@ static int cx24110_initfe(struct dvb_fro
 	return 0;
 }
 
+static int cx24110_sleep(struct dvb_frontend *fe)
+{
+	struct cx24110_state *state = fe->demodulator_priv;
+
+	if (state->config->pll_sleep)
+		  return state->config->pll_sleep(fe);
+	return 0;
+}
+
 static int cx24110_set_voltage (struct dvb_frontend* fe, fe_sec_voltage_t voltage)
 {
 	struct cx24110_state *state = fe->demodulator_priv;
@@ -642,6 +651,7 @@ static struct dvb_frontend_ops cx24110_o
 	.release = cx24110_release,
 
 	.init = cx24110_initfe,
+	.sleep = cx24110_sleep,
 	.set_frontend = cx24110_set_frontend,
 	.get_frontend = cx24110_get_frontend,
 	.read_status = cx24110_read_status,
diff --git a/drivers/media/dvb/frontends/cx24110.h b/drivers/media/dvb/frontends/cx24110.h
diff --git a/drivers/media/dvb/frontends/cx24110.h b/drivers/media/dvb/frontends/cx24110.h
index b63ecf2..609ac64 100644
--- a/drivers/media/dvb/frontends/cx24110.h
+++ b/drivers/media/dvb/frontends/cx24110.h
@@ -35,6 +35,7 @@ struct cx24110_config
 	/* PLL maintenance */
 	int (*pll_init)(struct dvb_frontend* fe);
 	int (*pll_set)(struct dvb_frontend* fe, struct dvb_frontend_parameters* params);
+	int (*pll_sleep)(struct dvb_frontend* fe);
 };
 
 extern struct dvb_frontend* cx24110_attach(const struct cx24110_config* config,

