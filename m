Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965046AbWCTPyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965046AbWCTPyR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965233AbWCTPxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:53:51 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:53454 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965046AbWCTPxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:53:00 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Hartmut Hackmann <hartmut.hackmann@t-online.de>,
       Hartmut Hackmann <hartmut.hackmann@t-online.de>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 058/141] V4L/DVB (3304): TDA10046 Driver update
Date: Mon, 20 Mar 2006 12:08:46 -0300
Message-id: <20060320150846.PS650033000058@infradead.org>
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

From: Hartmut Hackmann <hartmut.hackmann@t-online.de>
Date: 1139302150 -0200

- Set outputs to tristate in sleep mode
- Reduce dangerously high firmware download speed with 16MHz xtal
- added tda827x configuration with GPIOs low
- added comments to stupid looking IIC reads that work around bugs in
  the tda10046.
- some minor updates

Signed-off-by: Hartmut Hackmann <hartmut.hackmann@t-online.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/dvb/frontends/tda1004x.c b/drivers/media/dvb/frontends/tda1004x.c
diff --git a/drivers/media/dvb/frontends/tda1004x.c b/drivers/media/dvb/frontends/tda1004x.c
index c63e9a5..8e8df7b 100644
--- a/drivers/media/dvb/frontends/tda1004x.c
+++ b/drivers/media/dvb/frontends/tda1004x.c
@@ -229,7 +229,7 @@ static int tda1004x_enable_tuner_i2c(str
 	dprintk("%s\n", __FUNCTION__);
 
 	result = tda1004x_write_mask(state, TDA1004X_CONFC4, 2, 2);
-	msleep(1);
+	msleep(20);
 	return result;
 }
 
@@ -502,7 +502,12 @@ static int tda10046_fwupload(struct dvb_
 	const struct firmware *fw;
 
 	/* reset + wake up chip */
-	tda1004x_write_byteI(state, TDA1004X_CONFC4, 0);
+	if (state->config->xtal_freq == TDA10046_XTAL_4M) {
+		tda1004x_write_byteI(state, TDA1004X_CONFC4, 0);
+	} else {
+		dprintk("%s: 16MHz Xtal, reducing I2C speed\n", __FUNCTION__);
+		tda1004x_write_byteI(state, TDA1004X_CONFC4, 0x80);
+	}
 	tda1004x_write_mask(state, TDA10046H_CONF_TRISTATE1, 1, 0);
 	/* let the clocks recover from sleep */
 	msleep(5);
@@ -651,7 +656,7 @@ static int tda10046_init(struct dvb_fron
 	// tda setup
 	tda1004x_write_mask(state, TDA1004X_CONFC4, 0x20, 0); // disable DSP watchdog timer
 	tda1004x_write_byteI(state, TDA1004X_AUTO, 0x87);    // 100 ppm crystal, select HP stream
-	tda1004x_write_byteI(state, TDA1004X_CONFC1, 8);      // disable pulse killer
+	tda1004x_write_byteI(state, TDA1004X_CONFC1, 0x88);      // enable pulse killer
 
 	switch (state->config->agc_config) {
 	case TDA10046_AGC_DEFAULT:
@@ -672,6 +677,12 @@ static int tda10046_init(struct dvb_fron
 		tda1004x_write_byteI(state, TDA10046H_AGC_RENORM, 0x08); // Gain Renormalize
 		tda1004x_write_byteI(state, TDA10046H_CONF_POLARITY, 0x6a); // set AGC polarities
 		break;
+	case TDA10046_AGC_TDA827X_GPL:
+		tda1004x_write_byteI(state, TDA10046H_AGC_CONF, 0x02);   // AGC setup
+		tda1004x_write_byteI(state, TDA10046H_AGC_THR, 0x70);    // AGC Threshold
+		tda1004x_write_byteI(state, TDA10046H_AGC_RENORM, 0x08); // Gain Renormalize
+		tda1004x_write_byteI(state, TDA10046H_CONF_POLARITY, 0x60); // set AGC polarities
+		break;
 	}
 	tda1004x_write_byteI(state, TDA1004X_CONFADC2, 0x38);
 	tda1004x_write_byteI(state, TDA10046H_CONF_TRISTATE1, 0x61); // Turn both AGC outputs on
@@ -683,6 +694,7 @@ static int tda10046_init(struct dvb_fron
 	tda1004x_write_byteI(state, TDA10046H_CVBER_CTRL, 0x1a); // 10^6 VBER measurement bits
 	tda1004x_write_byteI(state, TDA1004X_CONF_TS1, 7); // MPEG2 interface config
 	tda1004x_write_byteI(state, TDA1004X_CONF_TS2, 0xc0); // MPEG2 interface config
+	// tda1004x_write_mask(state, 0x50, 0x80, 0x80);         // handle out of guard echoes
 	tda1004x_write_mask(state, 0x3a, 0x80, state->config->invert_oclk << 7);
 
 	state->initialised = 1;
@@ -1027,6 +1039,7 @@ static int tda1004x_read_status(struct d
 		if (status == -1)
 			return -EIO;
 		cber |= (status << 8);
+		// The address 0x20 should be read to cope with a TDA10046 bug
 		tda1004x_read_byte(state, TDA1004X_CBER_RESET);
 
 		if (cber != 65535)
@@ -1047,7 +1060,8 @@ static int tda1004x_read_status(struct d
 		status = tda1004x_read_byte(state, TDA1004X_VBER_MSB);
 		if (status == -1)
 			return -EIO;
-		vber |= ((status << 16) & 0x0f);
+		vber |= (status & 0x0f) << 16;
+		// The CVBER_LUT should be read to cope with TDA10046 hardware bug
 		tda1004x_read_byte(state, TDA1004X_CVBER_LUT);
 
 		// if RS has passed some valid TS packets, then we must be
@@ -1161,6 +1175,7 @@ static int tda1004x_read_ber(struct dvb_
 	if (tmp < 0)
 		return -EIO;
 	*ber |= (tmp << 9);
+	// The address 0x20 should be read to cope with a TDA10046 bug
 	tda1004x_read_byte(state, TDA1004X_CBER_RESET);
 
 	dprintk("%s: ber=0x%x\n", __FUNCTION__, *ber);
@@ -1187,6 +1202,8 @@ static int tda1004x_sleep(struct dvb_fro
 				tda1004x_disable_tuner_i2c(state);
 			}
 		}
+		/* set outputs to tristate */
+		tda1004x_write_byteI(state, TDA10046H_CONF_TRISTATE1, 0xff);
 		tda1004x_write_mask(state, TDA1004X_CONFC4, 1, 1);
 		break;
 	}
diff --git a/drivers/media/dvb/frontends/tda1004x.h b/drivers/media/dvb/frontends/tda1004x.h
diff --git a/drivers/media/dvb/frontends/tda1004x.h b/drivers/media/dvb/frontends/tda1004x.h
index 8659c52..cc0c4af 100644
--- a/drivers/media/dvb/frontends/tda1004x.h
+++ b/drivers/media/dvb/frontends/tda1004x.h
@@ -35,7 +35,8 @@ enum tda10046_agc {
 	TDA10046_AGC_DEFAULT,		/* original configuration */
 	TDA10046_AGC_IFO_AUTO_NEG,	/* IF AGC only, automatic, negtive */
 	TDA10046_AGC_IFO_AUTO_POS,	/* IF AGC only, automatic, positive */
-	TDA10046_AGC_TDA827X,	    /* IF AGC only, special setup for tda827x */
+	TDA10046_AGC_TDA827X,		/* IF AGC only, special setup for tda827x */
+	TDA10046_AGC_TDA827X_GPL,	/* same as above, but GPIOs 0 */
 };
 
 enum tda10046_if {

