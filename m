Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262014AbUCPObA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 09:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262019AbUCPOar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 09:30:47 -0500
Received: from styx.suse.cz ([82.208.2.94]:2178 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S261940AbUCPOTt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 09:19:49 -0500
Content-Transfer-Encoding: 7BIT
Message-Id: <1079446777406@twilight.ucw.cz>
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 30/44] Separate HID quirks for different A4Tech mice
X-Mailer: gregkh_patchbomb_levon_offspring
To: torvalds@osdl.org, vojtech@ucw.cz, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Date: Tue, 16 Mar 2004 15:19:37 +0100
In-Reply-To: <1079446777851@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1608.61.3, 2004-03-04 10:58:18+01:00, warp@mercury.d2dc.net
  input: HID needs to distinguish between two types of A4Tech
         two-wheel mice.


 hid-core.c  |    4 ++--
 hid-input.c |    7 ++++---
 hid.h       |   19 ++++++++++---------
 3 files changed, 16 insertions(+), 14 deletions(-)

===================================================================

diff -Nru a/drivers/usb/input/hid-core.c b/drivers/usb/input/hid-core.c
--- a/drivers/usb/input/hid-core.c	Tue Mar 16 13:18:15 2004
+++ b/drivers/usb/input/hid-core.c	Tue Mar 16 13:18:15 2004
@@ -1428,8 +1428,8 @@
 	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_4PORTKVMC, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_TANGTOP, USB_DEVICE_ID_TANGTOP_USBPS2, HID_QUIRK_NOGET },
 
-	{ USB_VENDOR_ID_A4TECH, USB_DEVICE_ID_A4TECH_WCP32PU, HID_QUIRK_2WHEEL_MOUSE_HACK },
-	{ USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_MOUSE, HID_QUIRK_2WHEEL_MOUSE_HACK },
+	{ USB_VENDOR_ID_A4TECH, USB_DEVICE_ID_A4TECH_WCP32PU, HID_QUIRK_2WHEEL_MOUSE_HACK_BACK },
+	{ USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_MOUSE, HID_QUIRK_2WHEEL_MOUSE_HACK_EXTRA },
 
 	{ USB_VENDOR_ID_ALPS, USB_DEVICE_ID_IBM_GAMEPAD, HID_QUIRK_BADPAD },
 	{ USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_DRIVING, HID_QUIRK_BADPAD | HID_QUIRK_MULTI_INPUT },
diff -Nru a/drivers/usb/input/hid-input.c b/drivers/usb/input/hid-input.c
--- a/drivers/usb/input/hid-input.c	Tue Mar 16 13:18:15 2004
+++ b/drivers/usb/input/hid-input.c	Tue Mar 16 13:18:15 2004
@@ -377,7 +377,8 @@
 
 	set_bit(usage->type, input->evbit);
 	if ((usage->type == EV_REL)
-			&& (device->quirks & HID_QUIRK_2WHEEL_MOUSE_HACK)
+			&& (device->quirks & (HID_QUIRK_2WHEEL_MOUSE_HACK_BACK
+				| HID_QUIRK_2WHEEL_MOUSE_HACK_EXTRA))
 			&& (usage->code == REL_WHEEL)) {
 		set_bit(REL_HWHEEL, bit);
 	}
@@ -431,8 +432,8 @@
 
 	input_regs(input, regs);
 
-	if ((hid->quirks & HID_QUIRK_2WHEEL_MOUSE_HACK)
-			&& (usage->code == BTN_BACK || usage->code == BTN_EXTRA)) {
+	if (((hid->quirks & HID_QUIRK_2WHEEL_MOUSE_HACK_EXTRA) && (usage->code == BTN_EXTRA))
+		|| ((hid->quirks & HID_QUIRK_2WHEEL_MOUSE_HACK_BACK) && (usage->code == BTN_BACK))) {
 		if (value)
 			hid->quirks |= HID_QUIRK_2WHEEL_MOUSE_HACK_ON;
 		else
diff -Nru a/drivers/usb/input/hid.h b/drivers/usb/input/hid.h
--- a/drivers/usb/input/hid.h	Tue Mar 16 13:18:15 2004
+++ b/drivers/usb/input/hid.h	Tue Mar 16 13:18:15 2004
@@ -201,15 +201,16 @@
  * HID device quirks.
  */
 
-#define HID_QUIRK_INVERT		0x001
-#define HID_QUIRK_NOTOUCH		0x002
-#define HID_QUIRK_IGNORE		0x004
-#define HID_QUIRK_NOGET			0x008
-#define HID_QUIRK_HIDDEV		0x010
-#define HID_QUIRK_BADPAD		0x020
-#define HID_QUIRK_MULTI_INPUT		0x040
-#define HID_QUIRK_2WHEEL_MOUSE_HACK	0x080
-#define HID_QUIRK_2WHEEL_MOUSE_HACK_ON	0x100
+#define HID_QUIRK_INVERT			0x001
+#define HID_QUIRK_NOTOUCH			0x002
+#define HID_QUIRK_IGNORE			0x004
+#define HID_QUIRK_NOGET				0x008
+#define HID_QUIRK_HIDDEV			0x010
+#define HID_QUIRK_BADPAD			0x020
+#define HID_QUIRK_MULTI_INPUT			0x040
+#define HID_QUIRK_2WHEEL_MOUSE_HACK_BACK	0x080
+#define HID_QUIRK_2WHEEL_MOUSE_HACK_EXTRA	0x100
+#define HID_QUIRK_2WHEEL_MOUSE_HACK_ON		0x200
 
 /*
  * This is the global environment of the parser. This information is

