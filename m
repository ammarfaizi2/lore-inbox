Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965302AbWCTP0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965302AbWCTP0Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964875AbWCTP0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:26:06 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:27064 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965295AbWCTPZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:25:18 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Perceval Anichini <perceval.anichini@streamvision.fr>,
       Oliver Endriss <o.endriss@gmx.de>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 133/141] V4L/DVB (3405): TechnoTrend S-1500 card handling
	moved from budget.c to budget-ci.c
Date: Mon, 20 Mar 2006 12:08:59 -0300
Message-id: <20060320150859.PS198475000133@infradead.org>
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

From: Perceval Anichini <perceval.anichini@streamvision.fr>
Date: 1141131164 -0300

TechnoTrend S-1500 card handling moved from budget.c to budget-ci.c.

Signed-off-by: Perceval Anichini <perceval.anichini@streamvision.fr>
Signed-off-by: Oliver Endriss <o.endriss@gmx.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/dvb/ttpci/budget-ci.c b/drivers/media/dvb/ttpci/budget-ci.c
diff --git a/drivers/media/dvb/ttpci/budget-ci.c b/drivers/media/dvb/ttpci/budget-ci.c
index b9b3cd9..09b972b 100644
--- a/drivers/media/dvb/ttpci/budget-ci.c
+++ b/drivers/media/dvb/ttpci/budget-ci.c
@@ -42,6 +42,8 @@
 #include "stv0299.h"
 #include "stv0297.h"
 #include "tda1004x.h"
+#include "lnbp21.h"
+#include "bsbe1.h"
 
 #define DEBIADDR_IR		0x1234
 #define DEBIADDR_CICONTROL	0x0000
@@ -1069,6 +1071,20 @@ static void frontend_init(struct budget_
 			break;
 		}
 		break;
+
+	case 0x1017:		// TT S-1500 PCI
+		budget_ci->budget.dvb_frontend = stv0299_attach(&alps_bsbe1_config, &budget_ci->budget.i2c_adap);
+		if (budget_ci->budget.dvb_frontend) {
+			budget_ci->budget.dvb_frontend->ops->dishnetwork_send_legacy_command = NULL;
+			if (lnbp21_init(budget_ci->budget.dvb_frontend, &budget_ci->budget.i2c_adap, LNBP21_LLC, 0)) {
+				printk("%s: No LNBP21 found!\n", __FUNCTION__);
+				if (budget_ci->budget.dvb_frontend->ops->release)
+					budget_ci->budget.dvb_frontend->ops->release(budget_ci->budget.dvb_frontend);
+				budget_ci->budget.dvb_frontend = NULL;
+			}
+		}
+
+		break;
 	}
 
 	if (budget_ci->budget.dvb_frontend == NULL) {
@@ -1146,6 +1162,7 @@ static int budget_ci_detach(struct saa71
 
 static struct saa7146_extension budget_extension;
 
+MAKE_BUDGET_INFO(ttbs2, "TT-Budget/S-1500 PCI", BUDGET_TT);
 MAKE_BUDGET_INFO(ttbci, "TT-Budget/WinTV-NOVA-CI PCI", BUDGET_TT_HW_DISEQC);
 MAKE_BUDGET_INFO(ttbt2, "TT-Budget/WinTV-NOVA-T	 PCI", BUDGET_TT);
 MAKE_BUDGET_INFO(ttbtci, "TT-Budget-T-CI PCI", BUDGET_TT);
@@ -1157,6 +1174,7 @@ static struct pci_device_id pci_tbl[] = 
 	MAKE_EXTENSION_PCI(ttbcci, 0x13c2, 0x1010),
 	MAKE_EXTENSION_PCI(ttbt2, 0x13c2, 0x1011),
 	MAKE_EXTENSION_PCI(ttbtci, 0x13c2, 0x1012),
+	MAKE_EXTENSION_PCI(ttbs2, 0x13c2, 0x1017),
 	{
 	 .vendor = 0,
 	 }
diff --git a/drivers/media/dvb/ttpci/budget.c b/drivers/media/dvb/ttpci/budget.c
diff --git a/drivers/media/dvb/ttpci/budget.c b/drivers/media/dvb/ttpci/budget.c
index 2a0e3ef..bfb8092 100644
--- a/drivers/media/dvb/ttpci/budget.c
+++ b/drivers/media/dvb/ttpci/budget.c
@@ -42,7 +42,6 @@
 #include "tda8083.h"
 #include "s5h1420.h"
 #include "lnbp21.h"
-#include "bsbe1.h"
 
 static void Set22K (struct budget *budget, int state)
 {
@@ -451,18 +450,6 @@ static u8 read_pwm(struct budget* budget
 static void frontend_init(struct budget *budget)
 {
 	switch(budget->dev->pci->subsystem_device) {
-	case 0x1017:
-		// try the ALPS BSBE1 now
-		budget->dvb_frontend = stv0299_attach(&alps_bsbe1_config, &budget->i2c_adap);
-		if (budget->dvb_frontend) {
-			budget->dvb_frontend->ops->dishnetwork_send_legacy_command = NULL;
-			if (lnbp21_init(budget->dvb_frontend, &budget->i2c_adap, LNBP21_LLC, 0)) {
-				printk("%s: No LNBP21 found!\n", __FUNCTION__);
-				goto error_out;
-			}
-		}
-
-		break;
 	case 0x1003: // Hauppauge/TT Nova budget (stv0299/ALPS BSRU6(tsa5059) OR ves1893/ALPS BSRV2(sp5659))
 	case 0x1013:
 		// try the ALPS BSRV2 first of all
@@ -586,7 +573,6 @@ static int budget_detach (struct saa7146
 
 static struct saa7146_extension budget_extension;
 
-MAKE_BUDGET_INFO(ttbs2, "TT-Budget/WinTV-NOVA-S PCI (rev AL/alps bsbe1 lnbp21 frontend)", BUDGET_TT);
 MAKE_BUDGET_INFO(ttbs,	"TT-Budget/WinTV-NOVA-S  PCI",	BUDGET_TT);
 MAKE_BUDGET_INFO(ttbc,	"TT-Budget/WinTV-NOVA-C  PCI",	BUDGET_TT);
 MAKE_BUDGET_INFO(ttbt,	"TT-Budget/WinTV-NOVA-T  PCI",	BUDGET_TT);
@@ -599,7 +585,6 @@ static struct pci_device_id pci_tbl[] = 
 	MAKE_EXTENSION_PCI(ttbc,  0x13c2, 0x1004),
 	MAKE_EXTENSION_PCI(ttbt,  0x13c2, 0x1005),
 	MAKE_EXTENSION_PCI(satel, 0x13c2, 0x1013),
-	MAKE_EXTENSION_PCI(ttbs2, 0x13c2, 0x1017),
 	MAKE_EXTENSION_PCI(ttbs,  0x13c2, 0x1016),
 	MAKE_EXTENSION_PCI(fsacs1,0x1131, 0x4f60),
 	MAKE_EXTENSION_PCI(fsacs0,0x1131, 0x4f61),

