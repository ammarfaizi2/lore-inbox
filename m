Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964929AbVKAINA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964929AbVKAINA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 03:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964958AbVKAINA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 03:13:00 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:41587 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S964929AbVKAIM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 03:12:59 -0500
Message-ID: <43672362.90205@m1k.net>
Date: Tue, 01 Nov 2005 03:12:18 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org
Subject: [PATCH 02/37] dvb: add support for Technotrend Budget Card S1500
Content-Type: multipart/mixed;
 boundary="------------090503020007060207090307"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090503020007060207090307
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit




--------------090503020007060207090307
Content-Type: text/x-patch;
 name="2357.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2357.patch"

From: Martin Zwickel <martin.zwickel@technotrend.de>

This patch adds support for the Technotrend Budget Card S1500
with a BSBE1 frontend and the LNBP21.

Signed-off-by: Martin Zwickel <martin.zwickel@technotrend.de>
Signed-off-by: Andrew de Quincey <adq_dvb@lidskialf.net>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>

 drivers/media/dvb/ttpci/budget.c |  118 +++++++++++++++++++++++++++++++++++----
 1 file changed, 108 insertions(+), 10 deletions(-)

--- linux-2.6.14-git3.orig/drivers/media/dvb/ttpci/budget.c
+++ linux-2.6.14-git3/drivers/media/dvb/ttpci/budget.c
@@ -226,12 +226,14 @@
 	return 0;
 }
 
-static void lnbp21_init(struct budget* budget)
+static int lnbp21_init(struct budget* budget)
 {
 	u8 buf = 0x00;
 	struct i2c_msg msg = { .addr = 0x08, .flags = 0, .buf = &buf, .len = sizeof(buf) };
 
-	i2c_transfer (&budget->i2c_adap, &msg, 1);
+	if (i2c_transfer (&budget->i2c_adap, &msg, 1) != 1)
+		return -EIO;
+	return 0;
 }
 
 static int alps_bsrv2_pll_set(struct dvb_frontend* fe, struct dvb_frontend_parameters* params)
@@ -273,7 +275,7 @@
 	0x01, 0x15,
 	0x02, 0x00,
 	0x03, 0x00,
-        0x04, 0x7d,   /* F22FR = 0x7d, F22 = f_VCO / 128 / 0x7d = 22 kHz */
+	0x04, 0x7d,   /* F22FR = 0x7d, F22 = f_VCO / 128 / 0x7d = 22 kHz */
 	0x05, 0x35,   /* I2CT = 0, SCLT = 1, SDAT = 1 */
 	0x06, 0x40,   /* DAC not used, set to high impendance mode */
 	0x07, 0x00,   /* DAC LSB */
@@ -367,6 +369,80 @@
 	.pll_set = alps_bsru6_pll_set,
 };
 
+static u8 alps_bsbe1_inittab[] = {
+	0x01, 0x15,
+	0x02, 0x30,
+	0x03, 0x00,
+	0x04, 0x7d,  /* F22FR = 0x7d, F22 = f_VCO / 128 / 0x7d = 22 kHz */
+	0x05, 0x35,  /* I2CT = 0, SCLT = 1, SDAT = 1 */
+	0x06, 0x40,  /* DAC not used, set to high impendance mode */
+	0x07, 0x00,  /* DAC LSB */
+	0x08, 0x40,  /* DiSEqC off, LNB power on OP2/LOCK pin on */
+	0x09, 0x00,  /* FIFO */
+	0x0c, 0x51,  /* OP1 ctl = Normal, OP1 val = 1 (LNB Power ON) */
+	0x0d, 0x82,  /* DC offset compensation = ON, beta_agc1 = 2 */
+	0x0e, 0x23,  /* alpha_tmg = 2, beta_tmg = 3 */
+	0x10, 0x3f,  // AGC2 0x3d
+	0x11, 0x84,
+	0x12, 0xb5,  // Lock detect: -64 Carrier freq detect:on
+	0x15, 0xc9,  // lock detector threshold
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
+	0x28, 0x00, // out imp: normal out type: parallel FEC mode:0
+	0x29, 0x1e, // 1/2 threshold
+	0x2a, 0x14, // 2/3 threshold
+	0x2b, 0x0f, // 3/4 threshold
+	0x2c, 0x09, // 5/6 threshold
+	0x2d, 0x05, // 7/8 threshold
+	0x2e, 0x01,
+	0x31, 0x1f, // test all FECs
+	0x32, 0x19, // viterbi and synchro search
+	0x33, 0xfc, // rs control
+	0x34, 0x93, // error control
+	0x0f, 0x92, // 0x80 = inverse AGC
+	0xff, 0xff
+};
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
+	.enhanced_tuning = 0,
+	.skip_reinit = 0,
+	.min_delay_ms = 100,
+	.set_symbol_rate = alps_bsru6_set_symbol_rate,
+	.pll_set = alps_bsbe1_pll_set,
+};
+
 static int alps_tdbe2_pll_set(struct dvb_frontend* fe, struct dvb_frontend_parameters* params)
 {
 	struct budget* budget = (struct budget*) fe->dvb->priv;
@@ -500,6 +576,19 @@
 static void frontend_init(struct budget *budget)
 {
 	switch(budget->dev->pci->subsystem_device) {
+	case 0x1017:
+		// try the ALPS BSBE1 now
+		budget->dvb_frontend = stv0299_attach(&alps_bsbe1_config, &budget->i2c_adap);
+		if (budget->dvb_frontend) {
+			budget->dvb_frontend->ops->set_voltage = lnbp21_set_voltage;
+			budget->dvb_frontend->ops->enable_high_lnb_voltage = lnbp21_enable_high_lnb_voltage;
+			if (lnbp21_init(budget)) {
+				printk("%s: No LNBP21 found!\n", __FUNCTION__);
+				goto error_out;
+			}
+		}
+
+		break;
 	case 0x1003: // Hauppauge/TT Nova budget (stv0299/ALPS BSRU6(tsa5059) OR ves1893/ALPS BSRV2(sp5659))
 	case 0x1013:
 		// try the ALPS BSRV2 first of all
@@ -554,7 +643,10 @@
 		if (budget->dvb_frontend) {
 			budget->dvb_frontend->ops->set_voltage = lnbp21_set_voltage;
 			budget->dvb_frontend->ops->enable_high_lnb_voltage = lnbp21_enable_high_lnb_voltage;
-			lnbp21_init(budget);
+			if (lnbp21_init(budget)) {
+				printk("%s: No LNBP21 found!\n", __FUNCTION__);
+				goto error_out;
+			}
 			break;
 		}
 	}
@@ -566,13 +658,17 @@
 		       budget->dev->pci->subsystem_vendor,
 		       budget->dev->pci->subsystem_device);
 	} else {
-		if (dvb_register_frontend(&budget->dvb_adapter, budget->dvb_frontend)) {
-			printk("budget: Frontend registration failed!\n");
-			if (budget->dvb_frontend->ops->release)
-				budget->dvb_frontend->ops->release(budget->dvb_frontend);
-			budget->dvb_frontend = NULL;
-		}
+		if (dvb_register_frontend(&budget->dvb_adapter, budget->dvb_frontend))
+			goto error_out;
 	}
+	return;
+
+error_out:
+	printk("budget: Frontend registration failed!\n");
+	if (budget->dvb_frontend->ops->release)
+		budget->dvb_frontend->ops->release(budget->dvb_frontend);
+	budget->dvb_frontend = NULL;
+	return;
 }
 
 static int budget_attach (struct saa7146_dev* dev, struct saa7146_pci_extension_data *info)
@@ -618,6 +714,7 @@
 
 static struct saa7146_extension budget_extension;
 
+MAKE_BUDGET_INFO(ttbs2, "TT-Budget/WinTV-NOVA-S PCI (rev AL/alps bsbe1 lnbp21 frontend)", BUDGET_TT);
 MAKE_BUDGET_INFO(ttbs,	"TT-Budget/WinTV-NOVA-S  PCI",	BUDGET_TT);
 MAKE_BUDGET_INFO(ttbc,	"TT-Budget/WinTV-NOVA-C  PCI",	BUDGET_TT);
 MAKE_BUDGET_INFO(ttbt,	"TT-Budget/WinTV-NOVA-T  PCI",	BUDGET_TT);
@@ -630,6 +727,7 @@
 	MAKE_EXTENSION_PCI(ttbc,  0x13c2, 0x1004),
 	MAKE_EXTENSION_PCI(ttbt,  0x13c2, 0x1005),
 	MAKE_EXTENSION_PCI(satel, 0x13c2, 0x1013),
+	MAKE_EXTENSION_PCI(ttbs2, 0x13c2, 0x1017),
 	MAKE_EXTENSION_PCI(ttbs,  0x13c2, 0x1016),
 	MAKE_EXTENSION_PCI(fsacs1,0x1131, 0x4f60),
 	MAKE_EXTENSION_PCI(fsacs0,0x1131, 0x4f61),


--------------090503020007060207090307--
