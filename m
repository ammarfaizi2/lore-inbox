Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266683AbUHCPZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266683AbUHCPZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 11:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266670AbUHCPZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 11:25:44 -0400
Received: from mail.gmx.de ([213.165.64.20]:4807 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266607AbUHCPZE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 11:25:04 -0400
X-Authenticated: #420190
Message-ID: <410FAE9B.5010909@gmx.net>
Date: Tue, 03 Aug 2004 17:26:19 +0200
From: Marko Macek <marko.macek@gmx.net>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040615)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: linux-kernel@vger.kernel.org, Eric Wong <eric@yhbt.net>
Subject: KVM & mouse wheel
Content-Type: multipart/mixed;
 boundary="------------010409000305050901000003"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010409000305050901000003
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello!

A few months ago I posted about problems with 2.6 kernel, KVM and mouse
wheel.

I was using 2.4 kernel until recently, but with the switch to FC2 with
2.6 kernel this problem became much more annoying.

My mouse is Logitech MX 510.

I figured out a few things.

1. Trying to set the mouse/kvm into a stream mode makes things insane.
Since streaming mode is supposed to be the default, I propose not
doing this at all. I haven't researched this further.

-      psmouse_command(psmouse, param, PSMOUSE_CMD_SETSTREAM);

2. synaptics_detect hoses imps and exps detection. Resetting the mouse
after failed detect fixes it. This makes 'imps' and 'exps' protocols
work when used as proto=imps or proto=exps. Wheel works, I haven't tried
the buttons.

3. PS2++ detection correctly detects Logitech MX mouse but doesn't
enable the PS2PP protocol, because of unexpected results in this code:

	param[0] = param[1] = param[2] = 0;
         ps2pp_cmd(psmouse, param, 0x39); /* Magic knock */
         ps2pp_cmd(psmouse, param, 0xDB);

         if ((param[0] & 0x78) == 0x48 &&
             (param[1] & 0xf3) == 0xc2 &&
             (param[2] & 0x03) == ((param[1] >> 2) & 3)) {
                 ps2pp_set_smartscroll(psmouse);
	        protocol = PSMOUSE_PS2PP;
         }

The returned param array in my case is: 08 01 00 or 08 00 00 (hex)
(without KVM: C8 C2 64)

I don't understand what this code is trying to check or why the protocol
is only set conditionally. If I set it unconditionally (swap last 2
lines) the PS2++ protocol now works including detection of all buttons
(I don't really need the buttons, just the wheel).

This is not included in the patch. The alternative solution
is to reset the mouse again and resume probing for imps or exps.


I plan on using the mouse in 'exps' mode since I haven't yet determined
out how the PS2++ mode will cooperate with the other OS.

Please consider the patch.

Regards,
Mark


--------------010409000305050901000003
Content-Type: text/x-patch;
 name="linux-2.6.7-kvm-mouse.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.7-kvm-mouse.patch"

--- psmouse-base.c.orig	2004-06-16 07:19:01.000000000 +0200
+++ psmouse-base.c	2004-08-03 17:21:24.948668832 +0200
@@ -418,28 +418,36 @@
 /*
  * Try Synaptics TouchPad
  */
-	if (max_proto > PSMOUSE_PS2 && synaptics_detect(psmouse)) {
-		synaptics_hardware = 1;
-
-		if (set_properties) {
-			psmouse->vendor = "Synaptics";
-			psmouse->name = "TouchPad";
-		}
-
-		if (max_proto > PSMOUSE_IMEX) {
-			if (!set_properties || synaptics_init(psmouse) == 0)
-				return PSMOUSE_SYNAPTICS;
+	if (max_proto > PSMOUSE_PS2) {
+		if (synaptics_detect(psmouse)) {
+			synaptics_hardware = 1;
+
+			if (set_properties) {
+				psmouse->vendor = "Synaptics";
+				psmouse->name = "TouchPad";
+			}
+
+			if (max_proto > PSMOUSE_IMEX) {
+				if (!set_properties || synaptics_init(psmouse) == 0)
+					return PSMOUSE_SYNAPTICS;
 /*
  * Some Synaptics touchpads can emulate extended protocols (like IMPS/2).
  * Unfortunately Logitech/Genius probes confuse some firmware versions so
  * we'll have to skip them.
  */
-			max_proto = PSMOUSE_IMEX;
-		}
+				max_proto = PSMOUSE_IMEX;
+			}
 /*
  * Make sure that touchpad is in relative mode, gestures (taps) are enabled
  */
-		synaptics_reset(psmouse);
+			synaptics_reset(psmouse);
+		} else {
+/* 
+ * Reset mouse if synaptics detect failed (KVM switch problem)
+ */
+			psmouse_reset(psmouse);
+			psmouse_command(psmouse, NULL, PSMOUSE_CMD_RESET_DIS);
+		}
 	}
 
 	if (max_proto > PSMOUSE_IMEX && genius_detect(psmouse)) {
@@ -459,6 +467,10 @@
 		int type = ps2pp_init(psmouse, set_properties);
 		if (type > PSMOUSE_PS2)
 			return type;
+		else {
+			psmouse_reset(psmouse);
+			psmouse_command(psmouse, NULL, PSMOUSE_CMD_RESET_DIS);
+		}
 	}
 
 	if (max_proto >= PSMOUSE_IMEX && im_explorer_detect(psmouse)) {
@@ -589,12 +601,6 @@
 		psmouse_set_resolution(psmouse);
 		psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE11);
 	}
-
-/*
- * We set the mouse into streaming mode.
- */
-
-	psmouse_command(psmouse, param, PSMOUSE_CMD_SETSTREAM);
 }
 
 /*

--------------010409000305050901000003--
