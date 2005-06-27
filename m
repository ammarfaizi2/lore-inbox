Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262083AbVF0Nhe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262083AbVF0Nhe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 09:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262049AbVF0Nek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 09:34:40 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:28389 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262082AbVF0MQ5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 08:16:57 -0400
Message-Id: <20050627121410.360665000@abc>
References: <20050627120600.739151000@abc>
Date: Mon, 27 Jun 2005 14:06:04 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andrew de Quincey <adq_dvb@lidskialf.net>
Content-Disposition: inline; filename=dvb-core-frontend-lnbswitch-workaround.patch
X-SA-Exim-Connect-IP: 84.189.248.249
Subject: [DVB patch 04/51] core: add workaround for tuning problem
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew de Quincey <adq_dvb@lidskialf.net>

Add workaround for signal lock loss issue, where the
frontend loses the signal after some hours without
any visible reason.

Signed-off-by: Andrew de Quincey <adq_dvb@lidskialf.net>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/dvb-core/dvb_frontend.c |   28 +++++++++++++++++++++++++---
 1 files changed, 25 insertions(+), 3 deletions(-)

Index: linux-2.6.12-git8/drivers/media/dvb/dvb-core/dvb_frontend.c
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/dvb-core/dvb_frontend.c	2005-06-27 13:22:55.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/dvb-core/dvb_frontend.c	2005-06-27 13:22:58.000000000 +0200
@@ -42,6 +42,8 @@
 #include "dvb_frontend.h"
 #include "dvbdev.h"
 
+// #define DEBUG_LOCKLOSS 1
+
 static int dvb_frontend_debug;
 static int dvb_shutdown_timeout = 5;
 static int dvb_force_auto_inversion;
@@ -113,6 +115,7 @@ struct dvb_frontend_private {
 	int exit;
 	int wakeup;
 	fe_status_t status;
+	fe_sec_tone_mode_t tone;
 };
 
 
@@ -434,9 +437,26 @@ static int dvb_frontend_thread(void *dat
 			/* we're tuned, and the lock is still good... */
 			if (s & FE_HAS_LOCK)
 				continue;
-			else {
-				/* if we _WERE_ tuned, but now don't have a lock,
-				 * need to zigzag */
+			else { /* if we _WERE_ tuned, but now don't have a lock */
+#ifdef DEBUG_LOCKLOSS
+				/* first of all try setting the tone again if it was on - this
+				 * sometimes works around problems with noisy power supplies */
+				if (fe->ops->set_tone && (fepriv->tone == SEC_TONE_ON)) {
+					fe->ops->set_tone(fe, fepriv->tone);
+					mdelay(100);
+					s = 0;
+					fe->ops->read_status(fe, &s);
+					if (s & FE_HAS_LOCK) {
+						printk("DVB%i: Lock was lost, but regained by setting "
+						       "the tone. This may indicate your power supply "
+						       "is noisy/slightly incompatable with this DVB-S "
+						       "adapter\n", fe->dvb->num);
+						fepriv->state = FESTATE_TUNED;
+						continue;
+					}
+				}
+#endif
+				/* some other reason for losing the lock - start zigzagging */
 				fepriv->state = FESTATE_ZIGZAG_FAST;
 				fepriv->started_auto_step = fepriv->auto_step;
 				check_wrapped = 0;
@@ -691,6 +711,7 @@ static int dvb_frontend_ioctl(struct ino
 			err = fe->ops->set_tone(fe, (fe_sec_tone_mode_t) parg);
 			fepriv->state = FESTATE_DISEQC;
 			fepriv->status = 0;
+			fepriv->tone = (fe_sec_tone_mode_t) parg;
 		}
 		break;
 
@@ -893,6 +914,7 @@ int dvb_register_frontend(struct dvb_ada
 	init_MUTEX (&fepriv->events.sem);
 	fe->dvb = dvb;
 	fepriv->inversion = INVERSION_OFF;
+	fepriv->tone = SEC_TONE_OFF;
 
 	printk ("DVB: registering frontend %i (%s)...\n",
 		fe->dvb->num,

--

