Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbTJHNeY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 09:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbTJHNdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 09:33:49 -0400
Received: from mail.convergence.de ([212.84.236.4]:8417 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S261539AbTJHN26 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 09:28:58 -0400
Subject: [PATCH 8/14] various patches for non-av7110 dvb-drivers
In-Reply-To: <10656197362976@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Wed, 8 Oct 2003 15:28:57 +0200
Message-Id: <10656197373087@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Michael Hunold (LinuxTV.org CVS maintainer) <hunold@linuxtv.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- [DVB] patch by Jon Burgess to fix DMA issues
- [DVB] reduce the number of dropped TS packets when an error is detected (Jon Burgess)
- [DVB] use budget-ci driver for new TT DVB-T cards with onboard MSP430.
diff -uNrwB --new-file xx-linux-2.6.0-test5/drivers/media/dvb/ttpci/budget-ci.c linux-2.6.0-test5/drivers/media/dvb/ttpci/budget-ci.c
--- xx-linux-2.6.0-test5/drivers/media/dvb/ttpci/budget-ci.c	2003-09-10 11:28:41.000000000 +0200
+++ linux-2.6.0-test5/drivers/media/dvb/ttpci/budget-ci.c	2003-09-09 09:24:21.000000000 +0200
@@ -357,10 +363,12 @@
 static struct saa7146_extension budget_extension; 
 
 MAKE_BUDGET_INFO(ttbci,	"TT-Budget/WinTV-NOVA-CI PCI",	BUDGET_TT_HW_DISEQC);
+MAKE_BUDGET_INFO(ttbt2,	"TT-Budget/WinTV-NOVA-T  PCI",	BUDGET_TT);
 
 static struct pci_device_id pci_tbl[] = {
 	MAKE_EXTENSION_PCI(ttbci, 0x13c2, 0x100c),
 	MAKE_EXTENSION_PCI(ttbci, 0x13c2, 0x100f),
+	MAKE_EXTENSION_PCI(ttbt2,  0x13c2, 0x1011),
 	{
 		.vendor    = 0,
 	}
diff -uNrwB --new-file xx-linux-2.6.0-test5/drivers/media/dvb/ttpci/budget-core.c linux-2.6.0-test5/drivers/media/dvb/ttpci/budget-core.c
--- xx-linux-2.6.0-test5/drivers/media/dvb/ttpci/budget-core.c	2003-09-10 11:28:41.000000000 +0200
+++ linux-2.6.0-test5/drivers/media/dvb/ttpci/budget-core.c	2003-09-09 09:24:21.000000000 +0200
@@ -46,12 +46,12 @@
         mdelay(10);
 
         saa7146_write(dev, BASE_ODD3, 0);
-        saa7146_write(dev, BASE_EVEN3, TS_WIDTH*TS_HEIGHT/2);
+        saa7146_write(dev, BASE_EVEN3, 0);
         saa7146_write(dev, PROT_ADDR3, TS_WIDTH*TS_HEIGHT);	
         saa7146_write(dev, BASE_PAGE3, budget->pt.dma |ME1|0x90);
         saa7146_write(dev, PITCH3, TS_WIDTH);
 
-        saa7146_write(dev, NUM_LINE_BYTE3, ((TS_HEIGHT/2)<<16)|TS_WIDTH);
+        saa7146_write(dev, NUM_LINE_BYTE3, (TS_HEIGHT<<16)|TS_WIDTH);
       	saa7146_write(dev, MC2, (MASK_04 | MASK_20));
      	saa7146_write(dev, MC1, (MASK_04 | MASK_20)); // DMA3 on
 
diff -uNrwB --new-file xx-linux-2.6.0-test5/drivers/media/dvb/ttpci/budget.c linux-2.6.0-test5/drivers/media/dvb/ttpci/budget.c
--- xx-linux-2.6.0-test5/drivers/media/dvb/ttpci/budget.c	2003-09-10 11:28:41.000000000 +0200
+++ linux-2.6.0-test5/drivers/media/dvb/ttpci/budget.c	2003-09-09 09:24:21.000000000 +0200
@@ -192,7 +192,6 @@
 MAKE_BUDGET_INFO(ttbs,	"TT-Budget/WinTV-NOVA-S  PCI",	BUDGET_TT);
 MAKE_BUDGET_INFO(ttbc,	"TT-Budget/WinTV-NOVA-C  PCI",	BUDGET_TT);
 MAKE_BUDGET_INFO(ttbt,	"TT-Budget/WinTV-NOVA-T  PCI",	BUDGET_TT);
-MAKE_BUDGET_INFO(ttbt2,	"TT-Budget/WinTV-NOVA-T  PCI",	BUDGET_TT);
 MAKE_BUDGET_INFO(satel,	"SATELCO Multimedia PCI",	BUDGET_TT_HW_DISEQC);
 /* Uncomment for Budget Patch */
 /*MAKE_BUDGET_INFO(fs_1_3,"Siemens/Technotrend/Hauppauge PCI rev1.3+Budget_Patch", BUDGET_PATCH);*/
@@ -203,7 +202,6 @@
 	MAKE_EXTENSION_PCI(ttbs,  0x13c2, 0x1003),
 	MAKE_EXTENSION_PCI(ttbc,  0x13c2, 0x1004),
 	MAKE_EXTENSION_PCI(ttbt,  0x13c2, 0x1005),
-	MAKE_EXTENSION_PCI(ttbt2,  0x13c2, 0x1011),	
 	MAKE_EXTENSION_PCI(satel, 0x13c2, 0x1013),
 	{
 		.vendor    = 0,


