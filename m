Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262943AbVEHT4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262943AbVEHT4L (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 15:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262879AbVEHTzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 15:55:33 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:6551 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262943AbVEHTK0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 15:10:26 -0400
Message-Id: <20050508184345.178661000@abc>
References: <20050508184229.957247000@abc>
Date: Sun, 08 May 2005 20:42:30 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-ttpci-nexus23.patch
X-SA-Exim-Connect-IP: 217.231.45.168
Subject: [DVB patch 01/37] support for TT/Hauppauge Nexus-S Rev 2.3
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Support for TT/Hauppauge Nexus-S Rev 2.3 (Oliver Endriss)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>
---

 drivers/media/dvb/ttpci/av7110.c |  116 +++++++++++++++++++++++++++++++++++++--
 1 files changed, 113 insertions(+), 3 deletions(-)

Index: linux-2.6.12-rc4/drivers/media/dvb/ttpci/av7110.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/ttpci/av7110.c	2005-05-08 18:23:20.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/ttpci/av7110.c	2005-05-08 20:24:35.000000000 +0200
@@ -1673,6 +1673,106 @@ static struct stv0299_config alps_bsru6_
 };
 
 
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
+	0x12, 0xb5,   // Lock detect: -64  Carrier freq detect:on
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
+static int alps_bsbe1_pll_set(struct dvb_frontend* fe, struct dvb_frontend_parameters* params)
+{
+	struct av7110* av7110 = (struct av7110*) fe->dvb->priv;
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
+	ret = i2c_transfer(&av7110->i2c_adap, &msg, 1);
+	return (ret != 1) ? -EIO : 0;
+}
+
+static struct stv0299_config alps_bsbe1_config = {
+	.demod_address = 0x68,
+	.inittab = alps_bsbe1_inittab,
+	.mclk = 88000000UL,
+	.invert = 1,
+	.enhanced_tuning = 0,
+	.skip_reinit = 0,
+	.min_delay_ms = 100,
+	.set_symbol_rate = alps_bsru6_set_symbol_rate,
+	.pll_set = alps_bsbe1_pll_set,
+};
+
+static int lnbp21_set_voltage(struct dvb_frontend* fe, fe_sec_voltage_t voltage)
+{
+	struct av7110* av7110 = (struct av7110*) fe->dvb->priv;
+	int ret;
+	u8 data[1];
+	struct i2c_msg msg = { .addr = 0x08, .flags = 0, .buf = data, .len = sizeof(data) };
+
+	switch(voltage) {
+	case SEC_VOLTAGE_OFF:
+		data[0] = 0x00;
+		break;
+	case SEC_VOLTAGE_13:
+		data[0] = 0x44;
+		break;
+	case SEC_VOLTAGE_18:
+		data[0] = 0x4c;
+		break;
+	default:
+		return -EINVAL;
+	};
+
+	ret = i2c_transfer(&av7110->i2c_adap, &msg, 1);
+	return (ret != 1) ? -EIO : 0;
+}
+
 
 static int alps_tdbe2_pll_set(struct dvb_frontend* fe, struct dvb_frontend_parameters* params)
 {
@@ -2116,6 +2216,14 @@ static int frontend_init(struct av7110 *
 				av7110->dev->i2c_bitrate = SAA7146_I2C_BUS_BIT_RATE_240;
 				break;
 			}
+			break;
+
+		case 0x000E: /* Hauppauge/TT Nexus-S rev 2.3 */
+			/* ALPS BSBE1 */
+			av7110->fe = stv0299_attach(&alps_bsbe1_config, &av7110->i2c_adap);
+			if (av7110->fe)
+				av7110->fe->ops->set_voltage = lnbp21_set_voltage;
+			break;
 		}
 	}
 
@@ -2672,21 +2780,23 @@ MAKE_AV7110_INFO(ttt_1_X,    "Technotren
 MAKE_AV7110_INFO(ttc_1_X,    "Technotrend/Hauppauge WinTV Nexus-CA rev1.X");
 MAKE_AV7110_INFO(ttc_2_X,    "Technotrend/Hauppauge WinTV DVB-C rev2.X");
 MAKE_AV7110_INFO(tts_2_X,    "Technotrend/Hauppauge WinTV Nexus-S rev2.X");
+MAKE_AV7110_INFO(tts_2_3,    "Technotrend/Hauppauge WinTV Nexus-S rev2.3");
 MAKE_AV7110_INFO(tts_1_3se,  "Technotrend/Hauppauge WinTV DVB-S rev1.3 SE");
 MAKE_AV7110_INFO(ttt,        "Technotrend/Hauppauge DVB-T");
 MAKE_AV7110_INFO(fsc,        "Fujitsu Siemens DVB-C");
 MAKE_AV7110_INFO(fss,        "Fujitsu Siemens DVB-S rev1.6");
 
 static struct pci_device_id pci_tbl[] = {
+	MAKE_EXTENSION_PCI(fsc,       0x110a, 0x0000),
 	MAKE_EXTENSION_PCI(tts_1_X,   0x13c2, 0x0000),
 	MAKE_EXTENSION_PCI(ttt_1_X,   0x13c2, 0x0001),
 	MAKE_EXTENSION_PCI(ttc_2_X,   0x13c2, 0x0002),
 	MAKE_EXTENSION_PCI(tts_2_X,   0x13c2, 0x0003),
-	MAKE_EXTENSION_PCI(tts_1_3se, 0x13c2, 0x1002),
-	MAKE_EXTENSION_PCI(fsc,       0x110a, 0x0000),
-	MAKE_EXTENSION_PCI(ttc_1_X,   0x13c2, 0x000a),
 	MAKE_EXTENSION_PCI(fss,       0x13c2, 0x0006),
 	MAKE_EXTENSION_PCI(ttt,       0x13c2, 0x0008),
+	MAKE_EXTENSION_PCI(ttc_1_X,   0x13c2, 0x000a),
+	MAKE_EXTENSION_PCI(tts_2_3,   0x13c2, 0x000e),
+	MAKE_EXTENSION_PCI(tts_1_3se, 0x13c2, 0x1002),
 
 /*	MAKE_EXTENSION_PCI(???, 0x13c2, 0x0004), UNDEFINED CARD */ // Galaxis DVB PC-Sat-Carte
 /*	MAKE_EXTENSION_PCI(???, 0x13c2, 0x0005), UNDEFINED CARD */ // Technisat SkyStar1

--

