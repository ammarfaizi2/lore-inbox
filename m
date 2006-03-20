Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965324AbWCTP2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965324AbWCTP2s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965326AbWCTP2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:28:48 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:56504 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965322AbWCTP2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:28:31 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Oliver Endriss <o.endriss@gmx.de>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 134/141] V4L/DVB (3406): Use refactored LNBP21 and BSBE1
	code
Date: Mon, 20 Mar 2006 12:08:59 -0300
Message-id: <20060320150859.PS360611000134@infradead.org>
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
Date: 1141133545 -0300

Use refactored LNBP21/BSBE1 code for Technotrend/Hauppauge DVB-S rev 2.3.
As a side effect, FE_ENABLE_HIGH_LNB_VOLTAGE ioctl is supported now.

Signed-off-by: Oliver Endriss <o.endriss@gmx.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/dvb/ttpci/av7110.c b/drivers/media/dvb/ttpci/av7110.c
diff --git a/drivers/media/dvb/ttpci/av7110.c b/drivers/media/dvb/ttpci/av7110.c
index d982a50..914f2e3 100644
--- a/drivers/media/dvb/ttpci/av7110.c
+++ b/drivers/media/dvb/ttpci/av7110.c
@@ -66,6 +66,9 @@
 #include "av7110_ca.h"
 #include "av7110_ipack.h"
 
+#include "bsbe1.h"
+#include "lnbp21.h"
+
 #define TS_WIDTH  376
 #define TS_HEIGHT 512
 #define TS_BUFLEN (TS_WIDTH*TS_HEIGHT)
@@ -1672,105 +1675,6 @@ static struct stv0299_config alps_bsru6_
 };
 
 
-static u8 alps_bsbe1_inittab[] = {
-	0x01, 0x15,
-	0x02, 0x30,
-	0x03, 0x00,
-	0x04, 0x7d,   /* F22FR = 0x7d, F22 = f_VCO / 128 / 0x7d = 22 kHz */
-	0x05, 0x35,   /* I2CT = 0, SCLT = 1, SDAT = 1 */
-	0x06, 0x40,   /* DAC not used, set to high impendance mode */
-	0x07, 0x00,   /* DAC LSB */
-	0x08, 0x40,   /* DiSEqC off, LNB power on OP2/LOCK pin on */
-	0x09, 0x00,   /* FIFO */
-	0x0c, 0x51,   /* OP1 ctl = Normal, OP1 val = 1 (LNB Power ON) */
-	0x0d, 0x82,   /* DC offset compensation = ON, beta_agc1 = 2 */
-	0x0e, 0x23,   /* alpha_tmg = 2, beta_tmg = 3 */
-	0x10, 0x3f,   // AGC2  0x3d
-	0x11, 0x84,
-	0x12, 0xb9,
-	0x15, 0xc9,   // lock detector threshold
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
-	0x28, 0x00,  // out imp: normal  out type: parallel FEC mode:0
-	0x29, 0x1e,  // 1/2 threshold
-	0x2a, 0x14,  // 2/3 threshold
-	0x2b, 0x0f,  // 3/4 threshold
-	0x2c, 0x09,  // 5/6 threshold
-	0x2d, 0x05,  // 7/8 threshold
-	0x2e, 0x01,
-	0x31, 0x1f,  // test all FECs
-	0x32, 0x19,  // viterbi and synchro search
-	0x33, 0xfc,  // rs control
-	0x34, 0x93,  // error control
-	0x0f, 0x92,
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
-static int lnbp21_set_voltage(struct dvb_frontend* fe, fe_sec_voltage_t voltage)
-{
-	struct av7110* av7110 = (struct av7110*) fe->dvb->priv;
-	int ret;
-	u8 data[1];
-	struct i2c_msg msg = { .addr = 0x08, .flags = 0, .buf = data, .len = sizeof(data) };
-
-	switch(voltage) {
-	case SEC_VOLTAGE_OFF:
-		data[0] = 0x00;
-		break;
-	case SEC_VOLTAGE_13:
-		data[0] = 0x44;
-		break;
-	case SEC_VOLTAGE_18:
-		data[0] = 0x4c;
-		break;
-	default:
-		return -EINVAL;
-	};
-
-	ret = i2c_transfer(&av7110->i2c_adap, &msg, 1);
-	return (ret != 1) ? -EIO : 0;
-}
-
-
 static int alps_tdbe2_pll_set(struct dvb_frontend* fe, struct dvb_frontend_parameters* params)
 {
 	struct av7110* av7110 = fe->dvb->priv;
@@ -2373,9 +2277,15 @@ static int frontend_init(struct av7110 *
 			/* ALPS BSBE1 */
 			av7110->fe = stv0299_attach(&alps_bsbe1_config, &av7110->i2c_adap);
 			if (av7110->fe) {
-				av7110->fe->ops->set_voltage = lnbp21_set_voltage;
-				av7110->fe->ops->dishnetwork_send_legacy_command = NULL;
-				av7110->recover = dvb_s_recover;
+				if (lnbp21_init(av7110->fe, &av7110->i2c_adap, 0, 0)) {
+					printk("dvb-ttpci: LNBP21 not found!\n");
+					if (av7110->fe->ops->release)
+						av7110->fe->ops->release(av7110->fe);
+					av7110->fe = NULL;
+				} else {
+					av7110->fe->ops->dishnetwork_send_legacy_command = NULL;
+					av7110->recover = dvb_s_recover;
+				}
 			}
 			break;
 		}

