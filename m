Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268235AbUI2GvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268235AbUI2GvF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 02:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268249AbUI2Gt1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 02:49:27 -0400
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:37486 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268237AbUI2GsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 02:48:02 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 4/8] Psmouse probe fixes
Date: Wed, 29 Sep 2004 01:44:03 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200409290140.53350.dtor_core@ameritech.net> <200409290142.33707.dtor_core@ameritech.net> <200409290143.11562.dtor_core@ameritech.net>
In-Reply-To: <200409290143.11562.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409290144.04783.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1950, 2004-09-28 00:09:06-05:00, dtor_core@ameritech.net
  Input: psmouse - reset mouse before doing intellimouse/explorer
         probes in case it got confused by earlier probes; switch
         to streaming mode before setting scale and resolution,
         otherwise some KVMs get confused.
  
  Patch-by: Marko Macek <Marko.Macek@gmx.net>
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 psmouse-base.c |   18 +++++++++++-------
 1 files changed, 11 insertions(+), 7 deletions(-)


===================================================================



diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	2004-09-29 01:18:55 -05:00
+++ b/drivers/input/mouse/psmouse-base.c	2004-09-29 01:18:55 -05:00
@@ -444,6 +444,12 @@
 			return type;
 	}
 
+/*
+ * Reset to defaults in case the device got confused by extended
+ * protocol probes.
+ */
+	ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_RESET_DIS);
+
 	if (max_proto >= PSMOUSE_IMEX && im_explorer_detect(psmouse)) {
 
 		if (set_properties) {
@@ -552,7 +558,11 @@
 
 static void psmouse_initialize(struct psmouse *psmouse)
 {
-	unsigned char param[2];
+/*
+ * We set the mouse into streaming mode.
+ */
+
+	ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_SETSTREAM);
 
 /*
  * We set the mouse report rate, resolution and scaling.
@@ -563,12 +573,6 @@
 		psmouse->set_resolution(psmouse, psmouse->resolution);
 		ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_SETSCALE11);
 	}
-
-/*
- * We set the mouse into streaming mode.
- */
-
-	ps2_command(&psmouse->ps2dev, param, PSMOUSE_CMD_SETSTREAM);
 }
 
 /*
