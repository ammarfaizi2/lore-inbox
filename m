Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264542AbUFGMjC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264542AbUFGMjC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 08:39:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264723AbUFGMbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 08:31:22 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:63616 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S264527AbUFGLzy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 07:55:54 -0400
To: torvalds@osdl.org, akpm@osdl.org, vojtech@ucw.cz,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
Message-Id: <10866093532158@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <10866093521452@twilight.ucw.cz>
Mime-Version: 1.0
Date: Mon, 7 Jun 2004 13:55:53 +0200
Subject: [PATCH 6/39] input: Pass psmouse_extensions as a parameter
X-Mailer: gregkh_patchbomb_levon_offspring
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input-for-linus

===================================================================

ChangeSet@1.1371.753.13, 2004-04-23 02:33:04-05:00, dtor_core@ameritech.net
  Input: pass maximum allowed protocol to psmouse_extensions instead of
         accessing psmouse_max_proto directly allowing to avoid changing
         the global parameter when synaptics initialization fails


 psmouse-base.c |   19 +++++++++----------
 1 files changed, 9 insertions(+), 10 deletions(-)

===================================================================

diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	2004-06-07 13:13:21 +02:00
+++ b/drivers/input/mouse/psmouse-base.c	2004-06-07 13:13:21 +02:00
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

