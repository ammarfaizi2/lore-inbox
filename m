Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262279AbVCVB6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbVCVB6h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 20:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262278AbVCVB6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 20:58:35 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:28555 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262337AbVCVBfr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:35:47 -0500
Message-Id: <20050322013459.689970000@abc>
References: <20050322013427.919515000@abc>
Date: Tue, 22 Mar 2005 02:24:12 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-ttpci-tt-dvb-t.patch
X-SA-Exim-Connect-IP: 217.231.55.169
Subject: [DVB patch 39/48] support for Technotrend PCI DVB-T
X-SA-Exim-Version: 4.2 (built Tue, 25 Jan 2005 19:36:50 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

patch by Anssi Hannula: add support for Technotrend PCI DVB-T
(0x13c2,0x0008, Grundig 29504-401 (LSI L64781 Based) frontend)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 Kconfig  |    1 +
 av7110.c |   47 ++++++++++++++++++++++++++++++++++++++++++++++-
 av7110.h |    1 +
 3 files changed, 48 insertions(+), 1 deletion(-)

Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/ttpci/Kconfig
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/ttpci/Kconfig	2005-03-21 23:27:56.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/ttpci/Kconfig	2005-03-22 00:27:46.000000000 +0100
@@ -10,6 +10,7 @@ config DVB_AV7110
 	select DVB_TDA8083
 	select DVB_SP8870
 	select DVB_STV0297
+	select DVB_L64781
 	help
 	  Support for SAA7146 and AV7110 based DVB cards as produced 
 	  by Fujitsu-Siemens, Technotrend, Hauppauge and others.
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/ttpci/av7110.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/ttpci/av7110.c	2005-03-22 00:18:08.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/ttpci/av7110.c	2005-03-22 00:27:46.000000000 +0100
@@ -1853,6 +1853,45 @@ static struct stv0297_config nexusca_stv
 };
 
 
+
+static int grundig_29504_401_pll_set(struct dvb_frontend* fe, struct dvb_frontend_parameters* params)
+{
+	struct av7110* av7110 = (struct av7110*) fe->dvb->priv;
+	u32 div;
+	u8 cfg, cpump, band_select;
+	u8 data[4];
+	struct i2c_msg msg = { .addr = 0x61, .flags = 0, .buf = data, .len = sizeof(data) };
+
+	div = (36125000 + params->frequency) / 166666;
+
+	cfg = 0x88;
+
+	if (params->frequency < 175000000) cpump = 2;
+	else if (params->frequency < 390000000) cpump = 1;
+	else if (params->frequency < 470000000) cpump = 2;
+	else if (params->frequency < 750000000) cpump = 1;
+	else cpump = 3;
+
+	if (params->frequency < 175000000) band_select = 0x0e;
+	else if (params->frequency < 470000000) band_select = 0x05;
+	else band_select = 0x03;
+
+	data[0] = (div >> 8) & 0x7f;
+	data[1] = div & 0xff;
+	data[2] = ((div >> 10) & 0x60) | cfg;
+	data[3] = (cpump << 6) | band_select;
+
+	if (i2c_transfer (&av7110->i2c_adap, &msg, 1) != 1) return -EIO;
+	return 0;
+}
+
+static struct l64781_config grundig_29504_401_config = {
+	.demod_address = 0x55,
+	.pll_set = grundig_29504_401_pll_set,
+};
+
+
+
 static void av7110_fe_lock_fix(struct av7110* av7110, fe_status_t status)
 {
 	int synced = (status & FE_HAS_LOCK) ? 1 : 0;
@@ -2060,6 +2099,11 @@ static int frontend_init(struct av7110 *
 			}
 			break;
 
+		case 0x0008: // Hauppauge/TT DVB-T
+
+			av7110->fe = l64781_attach(&grundig_29504_401_config, &av7110->i2c_adap);
+			break;
+
 		case 0x000A: // Hauppauge/TT Nexus-CA rev1.X
 
 			av7110->fe = stv0297_attach(&nexusca_stv0297_config, &av7110->i2c_adap, 0x7b);
@@ -2629,6 +2673,7 @@ MAKE_AV7110_INFO(ttc_1_X,    "Technotren
 MAKE_AV7110_INFO(ttc_2_X,    "Technotrend/Hauppauge WinTV DVB-C rev2.X");
 MAKE_AV7110_INFO(tts_2_X,    "Technotrend/Hauppauge WinTV Nexus-S rev2.X");
 MAKE_AV7110_INFO(tts_1_3se,  "Technotrend/Hauppauge WinTV DVB-S rev1.3 SE");
+MAKE_AV7110_INFO(ttt,        "Technotrend/Hauppauge DVB-T");
 MAKE_AV7110_INFO(fsc,        "Fujitsu Siemens DVB-C");
 MAKE_AV7110_INFO(fss,        "Fujitsu Siemens DVB-S rev1.6");
 
@@ -2641,10 +2686,10 @@ static struct pci_device_id pci_tbl[] = 
 	MAKE_EXTENSION_PCI(fsc,       0x110a, 0x0000),
 	MAKE_EXTENSION_PCI(ttc_1_X,   0x13c2, 0x000a),
 	MAKE_EXTENSION_PCI(fss,       0x13c2, 0x0006),
+	MAKE_EXTENSION_PCI(ttt,       0x13c2, 0x0008),
 
 /*	MAKE_EXTENSION_PCI(???, 0x13c2, 0x0004), UNDEFINED CARD */ // Galaxis DVB PC-Sat-Carte
 /*	MAKE_EXTENSION_PCI(???, 0x13c2, 0x0005), UNDEFINED CARD */ // Technisat SkyStar1
-/*	MAKE_EXTENSION_PCI(???, 0x13c2, 0x0008), UNDEFINED CARD */ // TT/Hauppauge WinTV DVB-T v????
 /*	MAKE_EXTENSION_PCI(???, 0x13c2, 0x0009), UNDEFINED CARD */ // TT/Hauppauge WinTV Nexus-CA v????
 
 	{
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/ttpci/av7110.h
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/ttpci/av7110.h	2005-03-22 00:18:08.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/ttpci/av7110.h	2005-03-22 00:27:46.000000000 +0100
@@ -31,6 +31,7 @@
 #include "tda8083.h"
 #include "sp8870.h"
 #include "stv0297.h"
+#include "l64781.h"
 
 #include <media/saa7146_vv.h>
 

--

