Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264460AbTFYK0y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 06:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264465AbTFYK0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 06:26:13 -0400
Received: from mail.convergence.de ([212.84.236.4]:17056 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S264454AbTFYKX3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 06:23:29 -0400
Subject: [PATCH 6/7] Update dvb budget driver
In-Reply-To: <10565374581787@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Wed, 25 Jun 2003 12:37:39 +0200
Message-Id: <10565374593380@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Michael Hunold (LinuxTV.org CVS maintainer) 
	<hunold@convergence.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- follow changes in dvb_net, use new eeprom parse code to properly detect the mac
- add new subvendor/subystem id pair
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

