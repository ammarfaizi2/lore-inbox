Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261423AbVAXDBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261423AbVAXDBq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 22:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbVAXDBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 22:01:46 -0500
Received: from mx1.redhat.com ([66.187.233.31]:19160 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261423AbVAXDBP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 22:01:15 -0500
Date: Sun, 23 Jan 2005 19:01:09 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: vojtech@suse.cz
Cc: linux-kernel@vger.kernel.org
Subject: Touchpad problems with 2.6.11-rc2
Message-ID: <20050123190109.3d082021@localhost.localdomain>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.14; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Vojtech:

Since the 2.6.11-rc2, I encounter problems with touchpad and keyboard 
on my laptop, Dell Lattitude D600. The following patch appears to be
the culprit:

diff -urp -X dontdiff linux-2.6.11-rc1/drivers/input/mouse/psmouse-base.c linux-2.6.11-rc2/drivers/input/mouse/psmouse-base.c
--- linux-2.6.11-rc1/drivers/input/mouse/psmouse-base.c	2005-01-12 16:20:42.000000000 -0800
+++ linux-2.6.11-rc2/drivers/input/mouse/psmouse-base.c	2005-01-22 14:54:14.000000000 -0800
@@ -451,14 +451,16 @@ static int psmouse_extensions(struct psm
 /*
  * Try ALPS TouchPad
  */
-	if (max_proto > PSMOUSE_IMEX && alps_detect(psmouse, set_properties) == 0) {
-		if (!set_properties || alps_init(psmouse) == 0)
-			return PSMOUSE_ALPS;
-
+	if (max_proto > PSMOUSE_IMEX) {
+		ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_RESET_DIS);
+		if (alps_detect(psmouse, set_properties) == 0) {
+			if (!set_properties || alps_init(psmouse) == 0)
+				return PSMOUSE_ALPS;
 /*
  * Init failed, try basic relative protocols
  */
-		max_proto = PSMOUSE_IMEX;
+			max_proto = PSMOUSE_IMEX;
+		}
 	}
 
 	if (max_proto > PSMOUSE_IMEX && genius_detect(psmouse, set_properties) == 0)

Without the patch, touchpad is not detected as such. Instead, dmesg shows:

input: PS/2 Generic Mouse on isa0060/serio1

With this patch, I see this:

ALPS Touchpad (Dualpoint) detected
  Disabling hardware tapping
input: AlpsPS/2 ALPS TouchPad on isa0060/serio1

Looks like detection is correct, however either ALPS specific code doesn't work
right, or it sets wrong parameters, I cannot tell. Here's the list of problems,
from worst to least annoying:

- Very often, keyboard stops working after a click. Typing anything has no effect.
  However, any smallest pointer movement will restore keyboard, and then an
  application receives all buffered characters. This is very bad.

- Double-click sometimes fails to work. I have to wait a second and retry it.
  Retrying right away is likely not to work again.

- Slow motion of finger produces no motion, then a jump. So, it's very hard to
  target smaller UI elements and some web links.

I do not use the nipple, so I cannot tell if that one works or worked before.

Not everything is bad. For example, old input code (in 2.6.10) sometimes "warped"
mouse to the bottom of the screen, or confused motion with clicks. This problem
appears to be gone now. It would be just great if you could look into keyboard
stoppages, too.

Have a great day,
-- Pete

P.S. I hate the tap, so keep it disabled by default, please :-)
