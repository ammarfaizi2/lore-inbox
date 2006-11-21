Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030934AbWKUM7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030934AbWKUM7X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 07:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030932AbWKUM7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 07:59:23 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:26822 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030930AbWKUM7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 07:59:20 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Oliver Endriss <o.endriss@gmx.de>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 2/5] V4L/DVB (4840): Budget: diseqc_method module parameter
	for cards with subsystem-id 13c2:1003
Date: Tue, 21 Nov 2006 10:38:50 -0200
Message-id: <20061121123850.PS3243860002@infradead.org>
In-Reply-To: <20061121123202.PS8610150000@infradead.org>
References: <20061121123202.PS8610150000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Oliver Endriss <o.endriss@gmx.de>

New module parameter diseqc_method for cards with subsystem-id 13c2:1003.
- 0: unreliable method, can be used by all board revisions (default)
- 1: reliable method, works for newer board layouts only
The parameter has no effect for cards with other subsystem-ids.

Signed-off-by: Oliver Endriss <o.endriss@gmx.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/dvb/ttpci/budget.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/drivers/media/dvb/ttpci/budget.c b/drivers/media/dvb/ttpci/budget.c
index e28617b..56f1c80 100644
--- a/drivers/media/dvb/ttpci/budget.c
+++ b/drivers/media/dvb/ttpci/budget.c
@@ -46,6 +46,10 @@ #include "tda826x.h"
 #include "lnbp21.h"
 #include "bsru6.h"
 
+static int diseqc_method;
+module_param(diseqc_method, int, 0444);
+MODULE_PARM_DESC(diseqc_method, "Select DiSEqC method for subsystem id 13c2:1003, 0: default, 1: more reliable (for newer revisions only)");
+
 static void Set22K (struct budget *budget, int state)
 {
 	struct saa7146_dev *dev=budget->dev;
@@ -382,7 +386,11 @@ static void frontend_init(struct budget 
 		if (budget->dvb_frontend) {
 			budget->dvb_frontend->ops.tuner_ops.set_params = alps_bsru6_tuner_set_params;
 			budget->dvb_frontend->tuner_priv = &budget->i2c_adap;
-			budget->dvb_frontend->ops.set_tone = budget_set_tone;
+			if (budget->dev->pci->subsystem_device == 0x1003 && diseqc_method == 0) {
+				budget->dvb_frontend->ops.diseqc_send_master_cmd = budget_diseqc_send_master_cmd;
+				budget->dvb_frontend->ops.diseqc_send_burst = budget_diseqc_send_burst;
+				budget->dvb_frontend->ops.set_tone = budget_set_tone;
+			}
 			break;
 		}
 		break;

