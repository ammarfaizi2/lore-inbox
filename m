Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262666AbVA0RP7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262666AbVA0RP7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 12:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262665AbVA0RPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 12:15:23 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:62943 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S262666AbVA0ROQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 12:14:16 -0500
Subject: [PATCH 4/6] Enable scancode event generation in the HID driver
In-Reply-To: <11068460382702@twilight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Thu, 27 Jan 2005 18:13:58 +0100
Message-Id: <11068460381981@twilight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, vojtech@ucw.cz, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/for-linus

===================================================================

ChangeSet@1.1975.1.2, 2005-01-27 14:48:48+01:00, vojtech@silver.ucw.cz
  input: Enable scancode event generation in the HID driver. This should allow
         changing HID->event mappings (via EVIOCS*) in the future and make 
         debugging easier now.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>


 hid-input.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

===================================================================

diff -Nru a/drivers/usb/input/hid-input.c b/drivers/usb/input/hid-input.c
--- a/drivers/usb/input/hid-input.c	2005-01-27 17:47:44 +01:00
+++ b/drivers/usb/input/hid-input.c	2005-01-27 17:47:44 +01:00
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

