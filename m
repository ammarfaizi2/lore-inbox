Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262349AbVCVCd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262349AbVCVCd1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 21:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262513AbVCVCdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 21:33:08 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:57995 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262354AbVCVBgi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:36:38 -0500
Message-Id: <20050322013500.477945000@abc>
References: <20050322013427.919515000@abc>
Date: Tue, 22 Mar 2005 02:24:18 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-ttusb-budget-novas22.patch
X-SA-Exim-Connect-IP: 217.231.55.169
Subject: [DVB patch 45/48] support Nova-S rev 2.2
X-SA-Exim-Version: 4.2 (built Tue, 25 Jan 2005 19:36:50 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Support for Nova-S rev 2.2 (Gregor Kroesen)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 dvb-ttusb-budget.c |  107 ++++++++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 94 insertions(+), 13 deletions(-)

Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c	2005-03-22 00:17:50.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c	2005-03-22 00:28:34.000000000 +0100
@@ -68,6 +68,7 @@ MODULE_PARM_DESC(debug, "Turn on/off deb
 #define TTUSB_MAXFILTER    16	/* ??? */
 #endif
 
+#define TTUSB_REV_2_2	0x22
 #define TTUSB_BUDGET_NAME "ttusb_stc_fw"
 
 /**
@@ -120,6 +121,8 @@ struct ttusb {
 
 	u8 last_result[32];
 
+	int revision;
+
 #if 0
 	devfs_handle_t stc_devfs_handle;
 #endif
@@ -432,13 +435,17 @@ static int ttusb_init_controller(struct 
 
 	if (memcmp(get_version + 4, "V 0.0", 5) &&
 	    memcmp(get_version + 4, "V 1.1", 5) &&
-	    memcmp(get_version + 4, "V 2.1", 5)) {
+	    memcmp(get_version + 4, "V 2.1", 5) &&
+	    memcmp(get_version + 4, "V 2.2", 5)) {
 		printk
 		    ("%s: unknown STC version %c%c%c%c%c, please report!\n",
 		     __FUNCTION__, get_version[4], get_version[5],
 		     get_version[6], get_version[7], get_version[8]);
 	}
 
+	ttusb->revision = ((get_version[6] - '0') << 4) |
+			   (get_version[8] - '0');
+
 	err =
 	    ttusb_cmd(ttusb, get_dsp_version, sizeof(get_dsp_version), 1);
 	if (err)
@@ -478,6 +485,31 @@ static int ttusb_send_diseqc(struct dvb_
 }
 #endif
 
+static int lnbp21_set_voltage(struct dvb_frontend* fe, fe_sec_voltage_t voltage)
+{
+        struct  ttusb* ttusb = (struct ttusb*)  fe->dvb->priv;
+        int ret;
+        u8 data[1];
+        struct i2c_msg msg = { .addr = 0x08, .flags = 0, .buf = data, .len = sizeof(data) };
+
+        switch(voltage) {
+        case SEC_VOLTAGE_OFF:
+                data[0] = 0x00;
+                break;
+        case SEC_VOLTAGE_13:
+                data[0] = 0x44;
+                break;
+        case SEC_VOLTAGE_18:
+                data[0] = 0x4c;
+                break;
+        default:
+                return -EINVAL;
+        };
+
+        ret = i2c_transfer(&ttusb->i2c_adap, &msg, 1);
+        return (ret != 1) ? -EIO : 0;
+}
+
 static int ttusb_update_lnb(struct ttusb *ttusb)
 {
 	u8 b[] = { 0xaa, ++ttusb->c, 0x16, 5, /*power: */ 1,
@@ -1148,10 +1180,51 @@ static struct tda1004x_config philips_td
 	.request_firmware = philips_tdm1316l_request_firmware,
 };
 
+static u8 alps_bsbe1_inittab[] = {
+        0x01, 0x15,
+        0x02, 0x30,
+        0x03, 0x00,
+        0x04, 0x7d,             /* F22FR = 0x7d, F22 = f_VCO / 128 / 0x7d = 22 kHz */
+        0x05, 0x35,             /* I2CT = 0, SCLT = 1, SDAT = 1 */
+        0x06, 0x40,             /* DAC not used, set to high impendance mode */
+        0x07, 0x00,             /* DAC LSB */
+        0x08, 0x40,             /* DiSEqC off, LNB power on OP2/LOCK pin on */
+        0x09, 0x00,             /* FIFO */
+        0x0c, 0x51,             /* OP1 ctl = Normal, OP1 val = 1 (LNB Power ON) */
+        0x0d, 0x82,             /* DC offset compensation = ON, beta_agc1 = 2 */
+        0x0e, 0x23,             /* alpha_tmg = 2, beta_tmg = 3 */
+        0x10, 0x3f,             // AGC2  0x3d
+        0x11, 0x84,
+        0x12, 0xb5,             // Lock detect: -64  Carrier freq detect:on
+        0x15, 0xc9,             // lock detector threshold
+        0x16, 0x00,
+        0x17, 0x00,
+        0x18, 0x00,
+        0x19, 0x00,
+        0x1a, 0x00,
+        0x1f, 0x50,
+        0x20, 0x00,
+        0x21, 0x00,
+        0x22, 0x00,
+        0x23, 0x00,
+        0x28, 0x00,             // out imp: normal  out type: parallel FEC mode:0
+        0x29, 0x1e,             // 1/2 threshold
+        0x2a, 0x14,             // 2/3 threshold
+        0x2b, 0x0f,             // 3/4 threshold
+        0x2c, 0x09,             // 5/6 threshold
+        0x2d, 0x05,             // 7/8 threshold
+        0x2e, 0x01,
+        0x31, 0x1f,             // test all FECs
+        0x32, 0x19,             // viterbi and synchro search
+        0x33, 0xfc,             // rs control
+        0x34, 0x93,             // error control
+        0x0f, 0x92,
+        0xff, 0xff
+};
 
 static u8 alps_bsru6_inittab[] = {
 	0x01, 0x15,
-	0x02, 0x00,
+	0x02, 0x30,
 	0x03, 0x00,
 	0x04, 0x7d,		/* F22FR = 0x7d, F22 = f_VCO / 128 / 0x7d = 22 kHz */
 	0x05, 0x35,		/* I2CT = 0, SCLT = 1, SDAT = 1 */
@@ -1191,7 +1264,7 @@ static u8 alps_bsru6_inittab[] = {
 	0xff, 0xff
 };
 
-static int alps_bsru6_set_symbol_rate(struct dvb_frontend *fe, u32 srate, u32 ratio)
+static int alps_stv0299_set_symbol_rate(struct dvb_frontend *fe, u32 srate, u32 ratio)
 {
 	u8 aclk = 0;
 	u8 bclk = 0;
@@ -1225,7 +1298,7 @@ static int alps_bsru6_set_symbol_rate(st
 	return 0;
 }
 
-static int alps_bsru6_pll_set(struct dvb_frontend *fe, struct dvb_frontend_parameters *params)
+static int philips_tsa5059_pll_set(struct dvb_frontend *fe, struct dvb_frontend_parameters *params)
 {
 	struct ttusb* ttusb = (struct ttusb*) fe->dvb->priv;
 	u8 buf[4];
@@ -1242,7 +1315,11 @@ static int alps_bsru6_pll_set(struct dvb
 	buf[3] = 0xC4;
 
 	if (params->frequency > 1530000)
-		buf[3] = 0xc0;
+		buf[3] = 0xC0;
+
+	/* BSBE1 wants XCE bit set */
+	if (ttusb->revision == TTUSB_REV_2_2)
+		buf[3] |= 0x20;
 
 	if (i2c_transfer(&ttusb->i2c_adap, &msg, 1) != 1)
 		return -EIO;
@@ -1250,8 +1327,7 @@ static int alps_bsru6_pll_set(struct dvb
 	return 0;
 }
 
-static struct stv0299_config alps_bsru6_config = {
-
+static struct stv0299_config alps_stv0299_config = {
 	.demod_address = 0x68,
 	.inittab = alps_bsru6_inittab,
 	.mclk = 88000000UL,
@@ -1261,8 +1337,8 @@ static struct stv0299_config alps_bsru6_
 	.lock_output = STV0229_LOCKOUTPUT_1,
 	.volt13_op0_op1 = STV0299_VOLT13_OP1,
 	.min_delay_ms = 100,
-	.set_symbol_rate = alps_bsru6_set_symbol_rate,
-	.pll_set = alps_bsru6_pll_set,
+	.set_symbol_rate = alps_stv0299_set_symbol_rate,
+	.pll_set = philips_tsa5059_pll_set,
 };
 
 static int ttusb_novas_grundig_29504_491_pll_set(struct dvb_frontend *fe, struct dvb_frontend_parameters *params)
@@ -1296,11 +1372,16 @@ static struct tda8083_config ttusb_novas
 static void frontend_init(struct ttusb* ttusb)
 {
 	switch(le16_to_cpu(ttusb->dev->descriptor.idProduct)) {
-	case 0x1003: // Hauppauge/TT Nova-USB-S budget (stv0299/ALPS BSRU6(tsa5059)
-		// try the ALPS BSRU6 first
-		ttusb->fe = stv0299_attach(&alps_bsru6_config, &ttusb->i2c_adap);
+	case 0x1003: // Hauppauge/TT Nova-USB-S budget (stv0299/ALPS BSRU6|BSBE1(tsa5059))
+		// try the stv0299 based first
+		ttusb->fe = stv0299_attach(&alps_stv0299_config, &ttusb->i2c_adap);
 		if (ttusb->fe != NULL) {
-			ttusb->fe->ops->set_voltage = ttusb_set_voltage;
+			if(ttusb->revision == TTUSB_REV_2_2) { // ALPS BSBE1
+				alps_stv0299_config.inittab = alps_bsbe1_inittab;
+				ttusb->fe->ops->set_voltage = lnbp21_set_voltage;
+			} else { // ALPS BSRU6
+				ttusb->fe->ops->set_voltage = ttusb_set_voltage;
+			}
 			break;
 		}
 

--

