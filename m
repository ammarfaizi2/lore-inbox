Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263786AbUELVcv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263786AbUELVcv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 17:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263798AbUELVcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 17:32:51 -0400
Received: from mail-relay-1.tiscali.it ([212.123.84.91]:6089 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S265239AbUELVcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 17:32:15 -0400
From: Antonio Cuni <cuni@programmazione.it>
To: vojtech@suse.cz
Subject: [PATCH] Chicony USB Keyboard
Date: Wed, 12 May 2004 23:13:53 +0200
User-Agent: KMail/1.5
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ROpoAvoLIxUt9QB"
Message-Id: <200405122313.53549.cuni@programmazione.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_ROpoAvoLIxUt9QB
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,
I've got a Chicony KU-0108 USB keyboard with some multimedial keys: most of 
them works fine, but there is no chance to use the 'cut', 'copy' and 'paste' 
keys with the official kernels: the problem is that the keyboard reports 
strange usages for those keys, so I write a little patch that fixes the bug.

This patch (against 2.6.6) modifies the hidinput_configure_usage function in 
drivers/usb/input/hid-input.c: it checks for the usages reported by the 
keyboard and fixes the values so that they can be seen as "standard" keys.

Comments are appreciated
[I've subscribed only linux-usb-devel, so plese CC replies from linux-kernel]

cheers,
Antonio


--Boundary-00=_ROpoAvoLIxUt9QB
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch"

--- drivers/usb/input/hid-input.c.orig	2004-04-25 10:23:49.000000000 +0200
+++ drivers/usb/input/hid-input.c	2004-04-25 10:32:54.000000000 +0200
@@ -122,6 +122,22 @@ static void hidinput_configure_usage(str
 				case HID_GD_GAMEPAD:  usage->code += 0x10;
 				case HID_GD_JOYSTICK: usage->code += 0x10;
 				case HID_GD_MOUSE:    usage->code += 0x10; break;
+
+				case 0x000C0003:
+					/* reported on a Chicony KU-0108 USB Keyboard.
+					 * The 'cut', 'copy' and 'paste' keys are seen as
+					 * HID_UP_BUTTON instead of, e.g.,
+					 * HID_UP_CONSUMER. The keys report a keycode > 255,
+					 * so we need to fix it. 
+					 */
+
+					switch (usage->code) {
+						case 0x10f: usage->code = KEY_CUT; break;
+						case 0x100: usage->code = KEY_COPY; break;
+						case 0x101: usage->code = KEY_PASTE; break;
+					}
+					break;
+
 				default:
 					if (field->physical == HID_GD_POINTER)
 						usage->code += 0x10;

--Boundary-00=_ROpoAvoLIxUt9QB--

