Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264980AbUDUGVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264980AbUDUGVh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 02:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264972AbUDUGHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 02:07:42 -0400
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:36012 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264980AbUDUGFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 02:05:42 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 3/15] New set of input patches: dont change max proto
Date: Wed, 21 Apr 2004 00:51:47 -0500
User-Agent: KMail/1.6.1
Cc: Vojtech Pavlik <vojtech@suse.cz>
References: <200404210049.17139.dtor_core@ameritech.net>
In-Reply-To: <200404210049.17139.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404210051.49357.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1904, 2004-04-20 22:24:21-05:00, dtor_core@ameritech.net
  Input: pass maximum allowed protocol to psmouse_extensions instead of
         accessing psmouse_max_proto directly allowing to avoid changing
         the global parameter when synaptics initialization fails


 psmouse-base.c |   19 +++++++++----------
 1 files changed, 9 insertions(+), 10 deletions(-)


===================================================================



diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	Tue Apr 20 23:00:21 2004
+++ b/drivers/input/mouse/psmouse-base.c	Tue Apr 20 23:00:21 2004
@@ -363,7 +363,7 @@
  * the mouse may have.
  */
 
-static int psmouse_extensions(struct psmouse *psmouse)
+static int psmouse_extensions(struct psmouse *psmouse, unsigned int max_proto)
 {
 	int synaptics_hardware = 0;
 
@@ -374,12 +374,12 @@
 /*
  * Try Synaptics TouchPad
  */
-	if (psmouse_max_proto > PSMOUSE_PS2 && synaptics_detect(psmouse)) {
+	if (max_proto > PSMOUSE_PS2 && synaptics_detect(psmouse)) {
 		synaptics_hardware = 1;
 		psmouse->vendor = "Synaptics";
 		psmouse->name = "TouchPad";
 
-		if (psmouse_max_proto > PSMOUSE_IMEX) {
+		if (max_proto > PSMOUSE_IMEX) {
 			if (synaptics_init(psmouse) == 0)
 				return PSMOUSE_SYNAPTICS;
 /*
@@ -387,7 +387,7 @@
  * Unfortunately Logitech/Genius probes confuse some firmware versions so
  * we'll have to skip them.
  */
-			psmouse_max_proto = PSMOUSE_IMEX;
+			max_proto = PSMOUSE_IMEX;
 		}
 /*
  * Make sure that touchpad is in relative mode, gestures (taps) are enabled
@@ -395,7 +395,7 @@
 		synaptics_reset(psmouse);
 	}
 
-	if (psmouse_max_proto > PSMOUSE_IMEX && genius_detect(psmouse)) {
+	if (max_proto > PSMOUSE_IMEX && genius_detect(psmouse)) {
 		set_bit(BTN_EXTRA, psmouse->dev.keybit);
 		set_bit(BTN_SIDE, psmouse->dev.keybit);
 		set_bit(REL_WHEEL, psmouse->dev.relbit);
@@ -405,17 +405,16 @@
 		return PSMOUSE_GENPS;
 	}
 
-	if (psmouse_max_proto > PSMOUSE_IMEX) {
+	if (max_proto > PSMOUSE_IMEX) {
 		int type = ps2pp_detect(psmouse);
 		if (type)
 			return type;
 	}
 
-	if (psmouse_max_proto >= PSMOUSE_IMPS && intellimouse_detect(psmouse)) {
+	if (max_proto >= PSMOUSE_IMPS && intellimouse_detect(psmouse)) {
 		set_bit(REL_WHEEL, psmouse->dev.relbit);
 
-		if (psmouse_max_proto >= PSMOUSE_IMEX &&
-					im_explorer_detect(psmouse)) {
+		if (max_proto >= PSMOUSE_IMEX && im_explorer_detect(psmouse)) {
 			set_bit(BTN_SIDE, psmouse->dev.keybit);
 			set_bit(BTN_EXTRA, psmouse->dev.keybit);
 
@@ -478,7 +477,7 @@
  * basic PS/2 3-button mouse.
  */
 
-	return psmouse->type = psmouse_extensions(psmouse);
+	return psmouse->type = psmouse_extensions(psmouse, psmouse_max_proto);
 }
 
 /*
