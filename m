Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263655AbUDVHzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263655AbUDVHzn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 03:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263741AbUDVHzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 03:55:42 -0400
Received: from [194.89.250.117] ([194.89.250.117]:16274 "EHLO
	kimputer.holviala.com") by vger.kernel.org with ESMTP
	id S263655AbUDVHzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 03:55:01 -0400
From: Kim Holviala <kim@holviala.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] psmouse: fix ExPS/2 probing
Date: Thu, 22 Apr 2004 10:53:25 +0300
User-Agent: KMail/1.6.1
Cc: vojtech@suse.cz, Dmitry Torokhov <dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404221053.25019.kim@holviala.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Split off from an earlier (big and confusing) patch.

Some mice (Logitech trackballs at least) support ExPS/2 but don't support
ImPS/2. The current probing order forces all such devices to use regular
three-button PS/2. This patch fixes it by taking the ExPS/2 probing out
of the ImPS/2 if-then block.

Applies to 2.6.5, 2.6.6-rc2. Won't apply to rc2-mm1 nor on top of Dmitry's
patches.

The third part of the earlier patch fixed protocol probing, but I'll wait
2.6.6 comes out until I redo it.



Kim



--- linux-2.6.6-rc2/drivers/input/mouse/psmouse-base.c	2004-04-21 13:35:43.000000000 +0300
+++ linux-2.6.6-rc2-kim/drivers/input/mouse/psmouse-base.c	2004-04-21 14:17:42.194090939 +0300
@@ -414,19 +414,19 @@
 	if (psmouse_max_proto >= PSMOUSE_IMPS && intellimouse_detect(psmouse)) {
 		set_bit(REL_WHEEL, psmouse->dev.relbit);
 
-		if (psmouse_max_proto >= PSMOUSE_IMEX &&
-					im_explorer_detect(psmouse)) {
-			set_bit(BTN_SIDE, psmouse->dev.keybit);
-			set_bit(BTN_EXTRA, psmouse->dev.keybit);
-
-			psmouse->name = "Explorer Mouse";
-			return PSMOUSE_IMEX;
-		}
-
 		psmouse->name = "Wheel Mouse";
 		return PSMOUSE_IMPS;
 	}
 
+	if (psmouse_max_proto >= PSMOUSE_IMEX && im_explorer_detect(psmouse)) {
+		set_bit(REL_WHEEL, psmouse->dev.relbit);
+		set_bit(BTN_SIDE, psmouse->dev.keybit);
+		set_bit(BTN_EXTRA, psmouse->dev.keybit);
+
+		psmouse->name = "Explorer Mouse";
+		return PSMOUSE_IMEX;
+	}
+
 /*
  * Okay, all failed, we have a standard mouse here. The number of the buttons
  * is still a question, though. We assume 3.



