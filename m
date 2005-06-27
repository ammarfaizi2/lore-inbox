Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262120AbVF0MmK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262120AbVF0MmK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 08:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262122AbVF0Mlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 08:41:47 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:3557 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262037AbVF0MQJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 08:16:09 -0400
Message-Id: <20050627121414.081345000@abc>
References: <20050627120600.739151000@abc>
Date: Mon, 27 Jun 2005 14:06:23 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andrew de Quincey <adq_dvb@lidskialf.net>
Content-Disposition: inline; filename=dvb-ttpci-tt-dvb-t-ci-pci-ids.patch
X-SA-Exim-Connect-IP: 84.189.248.249
Subject: [DVB patch 23/51] ttpci: support for new TT DVB-T-CI
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew de Quincey <adq_dvb@lidskialf.net>

Support for new TT DVB-T-CI, thanks to Andre Weidemann

Signed-off-by: Andrew de Quincey <adq_dvb@lidskialf.net>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/ttpci/budget-ci.c |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)

Index: linux-2.6.12-git8/drivers/media/dvb/ttpci/budget-ci.c
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/ttpci/budget-ci.c	2005-06-27 13:23:02.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/ttpci/budget-ci.c	2005-06-27 13:24:16.000000000 +0200
@@ -69,6 +69,7 @@ struct budget_ci {
 	int slot_status;
 	struct dvb_ca_en50221 ca;
 	char ir_dev_name[50];
+	u8 tuner_pll_address; /* used for philips_tdm1316l configs */
 };
 
 /* from reading the following remotes:
@@ -723,7 +724,7 @@ static int philips_tdm1316l_pll_init(str
 	struct budget_ci *budget_ci = (struct budget_ci *) fe->dvb->priv;
 	static u8 td1316_init[] = { 0x0b, 0xf5, 0x85, 0xab };
 	static u8 disable_mc44BC374c[] = { 0x1d, 0x74, 0xa0, 0x68 };
-	struct i2c_msg tuner_msg = {.addr = 0x63,.flags = 0,.buf = td1316_init,.len =
+	struct i2c_msg tuner_msg = {.addr = budget_ci->tuner_pll_address,.flags = 0,.buf = td1316_init,.len =
 			sizeof(td1316_init) };
 
 	// setup PLL configuration
@@ -746,7 +747,7 @@ static int philips_tdm1316l_pll_set(stru
 {
 	struct budget_ci *budget_ci = (struct budget_ci *) fe->dvb->priv;
 	u8 tuner_buf[4];
-	struct i2c_msg tuner_msg = {.addr = 0x63,.flags = 0,.buf = tuner_buf,.len = sizeof(tuner_buf) };
+	struct i2c_msg tuner_msg = {.addr = budget_ci->tuner_pll_address,.flags = 0,.buf = tuner_buf,.len = sizeof(tuner_buf) };
 	int tuner_frequency = 0;
 	u8 band, cp, filter;
 
@@ -869,12 +870,22 @@ static void frontend_init(struct budget_
 		break;
 
 	case 0x1011:		// Hauppauge/TT Nova-T budget (tda10045/Philips tdm1316l(tda6651tt) + TDA9889)
+		budget_ci->tuner_pll_address = 0x63;
 		budget_ci->budget.dvb_frontend =
 			tda10045_attach(&philips_tdm1316l_config, &budget_ci->budget.i2c_adap);
 		if (budget_ci->budget.dvb_frontend) {
 			break;
 		}
 		break;
+
+	case 0x1012:		// Hauppauge/TT Nova-T CI budget (tda10045/Philips tdm1316l(tda6651tt) + TDA9889)
+		budget_ci->tuner_pll_address = 0x60;
+		budget_ci->budget.dvb_frontend =
+			tda10046_attach(&philips_tdm1316l_config, &budget_ci->budget.i2c_adap);
+		if (budget_ci->budget.dvb_frontend) {
+			break;
+		}
+		break;
 	}
 
 	if (budget_ci->budget.dvb_frontend == NULL) {
@@ -954,11 +965,13 @@ static struct saa7146_extension budget_e
 
 MAKE_BUDGET_INFO(ttbci, "TT-Budget/WinTV-NOVA-CI PCI", BUDGET_TT_HW_DISEQC);
 MAKE_BUDGET_INFO(ttbt2, "TT-Budget/WinTV-NOVA-T	 PCI", BUDGET_TT);
+MAKE_BUDGET_INFO(ttbtci, "TT-Budget-T-CI PCI", BUDGET_TT);
 
 static struct pci_device_id pci_tbl[] = {
 	MAKE_EXTENSION_PCI(ttbci, 0x13c2, 0x100c),
 	MAKE_EXTENSION_PCI(ttbci, 0x13c2, 0x100f),
 	MAKE_EXTENSION_PCI(ttbt2, 0x13c2, 0x1011),
+	MAKE_EXTENSION_PCI(ttbtci, 0x13c2, 0x1012),
 	{
 	 .vendor = 0,
 	 }

--

