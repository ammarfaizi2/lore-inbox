Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267419AbTGOMMr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 08:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267402AbTGOMMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 08:12:23 -0400
Received: from mail.convergence.de ([212.84.236.4]:34720 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S267419AbTGOMGH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 08:06:07 -0400
Subject: [PATCH 6/17] Update the DVB budget drivers
In-Reply-To: <1058271654905@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Tue, 15 Jul 2003 14:20:55 +0200
Message-Id: <10582716551228@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Michael Hunold (LinuxTV.org CVS maintainer) 
	<hunold@convergence.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[DVB] - follow changes in dvb_net, use new eeprom parse code to properly detect the mac
[DVB] - add new subvendor/subystem id pair
diff -uNrwB --new-file linux-2.5.73.bk/drivers/media/dvb/ttpci/budget-core.c linux-2.5.73.work/drivers/media/dvb/ttpci/budget-core.c
--- linux-2.5.73.bk/drivers/media/dvb/ttpci/budget-core.c	2003-06-25 09:46:54.000000000 +0200
+++ linux-2.5.73.work/drivers/media/dvb/ttpci/budget-core.c	2003-06-23 12:40:50.000000000 +0200
@@ -1,4 +1,5 @@
 #include "budget.h"
+#include "ttpci-eeprom.h"
 
 int budget_debug = 0;
 
@@ -165,7 +166,6 @@
         if (ret < 0)
                 return ret;
 
-        budget->dvb_net.card_num = budget->dvb_adapter->num;
         dvb_net_init(budget->dvb_adapter, &budget->dvb_net, &dvbdemux->dmx);
 
 	return 0;
@@ -222,7 +222,7 @@
            get recognized before the main driver is loaded */
         saa7146_write(dev, GPIO_CTRL, 0x500000);
 	
-	saa7146_i2c_adapter_prepare(dev, NULL, SAA7146_I2C_BUS_BIT_RATE_3200);
+	saa7146_i2c_adapter_prepare(dev, NULL, SAA7146_I2C_BUS_BIT_RATE_120);
 
 	budget->i2c_bus = dvb_register_i2c_bus (master_xfer, dev,
 						budget->dvb_adapter, 0);
@@ -232,6 +232,8 @@
 		return -ENOMEM;
 	}
 
+	ttpci_eeprom_parse_mac(budget->i2c_bus);
+
 	if( NULL == (budget->grabbing = saa7146_vmalloc_build_pgtable(dev->pci,length,&budget->pt))) {
 		ret = -ENOMEM;
 		goto err;
diff -uNrwB --new-file linux-2.5.73.bk/drivers/media/dvb/ttpci/budget.c linux-2.5.73.work/drivers/media/dvb/ttpci/budget.c
--- linux-2.5.73.bk/drivers/media/dvb/ttpci/budget.c	2003-06-25 09:46:54.000000000 +0200
+++ linux-2.5.73.work/drivers/media/dvb/ttpci/budget.c	2003-06-18 13:51:03.000000000 +0200
@@ -192,6 +192,7 @@
 MAKE_BUDGET_INFO(ttbs,	"TT-Budget/WinTV-NOVA-S  PCI",	BUDGET_TT);
 MAKE_BUDGET_INFO(ttbc,	"TT-Budget/WinTV-NOVA-C  PCI",	BUDGET_TT);
 MAKE_BUDGET_INFO(ttbt,	"TT-Budget/WinTV-NOVA-T  PCI",	BUDGET_TT);
+MAKE_BUDGET_INFO(ttbt2,	"TT-Budget/WinTV-NOVA-T  PCI",	BUDGET_TT);
 MAKE_BUDGET_INFO(satel,	"SATELCO Multimedia PCI",	BUDGET_TT_HW_DISEQC);
 /* Uncomment for Budget Patch */
 /*MAKE_BUDGET_INFO(fs_1_3,"Siemens/Technotrend/Hauppauge PCI rev1.3+Budget_Patch", BUDGET_PATCH);*/
@@ -202,6 +203,7 @@
 	MAKE_EXTENSION_PCI(ttbs,  0x13c2, 0x1003),
 	MAKE_EXTENSION_PCI(ttbc,  0x13c2, 0x1004),
 	MAKE_EXTENSION_PCI(ttbt,  0x13c2, 0x1005),
+	MAKE_EXTENSION_PCI(ttbt2,  0x13c2, 0x1011),	
 	MAKE_EXTENSION_PCI(satel, 0x13c2, 0x1013),
 	{
 		.vendor    = 0,

