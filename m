Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261927AbVAaFdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261927AbVAaFdP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 00:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbVAaFdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 00:33:15 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:38621
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261929AbVAaFdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 00:33:07 -0500
Date: Sun, 30 Jan 2005 21:27:39 -0800
From: "David S. Miller" <davem@davemloft.net>
To: linux-kernel@vger.kernel.org
Cc: vojtech@suse.cz
Subject: recent 2.6.x USB HID input weirdness
Message-Id: <20050130212739.060f8e6f.davem@davemloft.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On sparc64 I just started getting this in my kernel logs
on 2.6.x-BK from hidinput_input_event:

warning: event field not found

I added some debugging:

hidinput_input_event: type[4] code [4] value[458759]
hidinput_input_event: type[4] code [4] value[458761]

This is on a Sun Type-6 USB keyboard.  It does this for
every key I press.  The keys work properly, just the
warning is printed (which makes the console kind of hard
to use :-)

I backed out the most recent change (included below)
to that code and the messages went away.

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/01/27 14:48:48+01:00 vojtech@silver.ucw.cz 
#   input: Enable scancode event generation in the HID driver. This should allow
#          changing HID->event mappings (via EVIOCS*) in the future and make 
#          debugging easier now.
#   
#   Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
# 
# drivers/usb/input/hid-input.c
#   2005/01/27 14:48:37+01:00 vojtech@silver.ucw.cz +7 -3
#   input: Enable scancode event generation in the HID driver. This should allow
#          changing HID->event mappings (via EVIOCS*) in the future.
# 
diff -Nru a/drivers/usb/input/hid-input.c b/drivers/usb/input/hid-input.c
--- a/drivers/usb/input/hid-input.c	2005-01-30 20:56:15 -08:00
+++ b/drivers/usb/input/hid-input.c	2005-01-30 20:56:15 -08:00
@@ -403,11 +403,12 @@
 	if (!input)
 		return;
 
+	input_regs(input, regs);
+	input_event(input, EV_MSC, MSC_SCAN, usage->hid);
+
 	if (!usage->type)
 		return;
 
-	input_regs(input, regs);
-
 	if (((hid->quirks & HID_QUIRK_2WHEEL_MOUSE_HACK_5) && (usage->hid == 0x00090005))
 		|| ((hid->quirks & HID_QUIRK_2WHEEL_MOUSE_HACK_7) && (usage->hid == 0x00090007))) {
 		if (value) hid->quirks |=  HID_QUIRK_2WHEEL_MOUSE_HACK_ON;
@@ -574,13 +575,16 @@
 				hidinput->input.id.product = le16_to_cpu(dev->descriptor.idProduct);
 				hidinput->input.id.version = le16_to_cpu(dev->descriptor.bcdDevice);
 				hidinput->input.dev = &hid->intf->dev;
+
+				set_bit(EV_MSC, hidinput->input.evbit);
+				set_bit(MSC_SCAN, hidinput->input.mscbit);
 			}
 
 			for (i = 0; i < report->maxfield; i++)
 				for (j = 0; j < report->field[i]->maxusage; j++)
 					hidinput_configure_usage(hidinput, report->field[i],
 								 report->field[i]->usage + j);
-
+			
 			if (hid->quirks & HID_QUIRK_MULTI_INPUT) {
 				/* This will leave hidinput NULL, so that it
 				 * allocates another one if we have more inputs on


