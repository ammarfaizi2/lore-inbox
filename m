Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbWCTXDd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbWCTXDd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 18:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbWCTXDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 18:03:32 -0500
Received: from build.arklinux.osuosl.org ([140.211.166.26]:13198 "EHLO
	mail.arklinux.org") by vger.kernel.org with ESMTP id S932172AbWCTXDc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 18:03:32 -0500
From: Bernhard Rosenkraenzer <bero@arklinux.org>
To: linux-usb-devel@lists.sourceforge.net
Subject: [PATCH] Add quirks required to make a Shuttle PN-31 remote control work
Date: Mon, 20 Mar 2006 23:59:24 +0100
User-Agent: KMail/1.9.1
Cc: vojtech@suse.cz, akpm@osdl.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603202359.25558.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add some quirks to make a Shuttle PN-31 remote control work.

Shuttle PN31 remote controls are supposed to act as a USB keyboard and mouse,
but they (in particular the mouse part) don't follow the standards.
 
5 quirks are needed to get this device to work, 2 of which are unique to this
device so far (it sets a superfluous extra bit on the GenericDesktop keycodes,
and the mouse flags are wrong (_Constant_, Variable, Relative). 

Tested with 2.6.16-rc6-mm1 and 2.6.16-rc6-mm2.

Signed-off-by: Bernhard Rosenkraenzer <bero@arklinux.org>

---

--- linux-2.6.15/drivers/usb/input/hid.h.pn31~	2006-01-22 18:12:59.000000000 
+0100
+++ linux-2.6.15/drivers/usb/input/hid.h	2006-01-22 19:47:13.000000000 +0100
@@ -249,6 +249,9 @@
 #define HID_QUIRK_CYMOTION			0x00000800
 #define HID_QUIRK_POWERBOOK_HAS_FN		0x00001000
 #define HID_QUIRK_POWERBOOK_FN_ON		0x00002000
+#define HID_QUIRK_BAD_LOGICAL_RANGE		0x00004000
+#define HID_QUIRK_WRONG_CONSTANT		0x00008000
+#define HID_QUIRK_GENDESK_EXTRA_BIT		0x00010000
 
 /*
  * This is the global environment of the parser. This information is
--- linux-2.6.15/drivers/usb/input/hid-input.c.pn31~	2006-01-22 
18:12:59.000000000 +0100
+++ linux-2.6.15/drivers/usb/input/hid-input.c	2006-01-22 18:13:35.000000000 
+0100
@@ -243,7 +243,7 @@
 	printk(" ---> ");
 #endif
 
-	if (field->flags & HID_MAIN_ITEM_CONSTANT)
+	if ((field->flags & HID_MAIN_ITEM_CONSTANT) && !(device->quirks & 
HID_QUIRK_WRONG_CONSTANT))
 		goto ignore;
 
 	switch (usage->hid & HID_USAGE_PAGE) {
@@ -326,16 +326,21 @@
 				break;
 			}
 
-			switch (usage->hid) {
+			if (device->quirks & HID_QUIRK_GENDESK_EXTRA_BIT)
+				code = usage->hid & 0xfff9ffff;
+			else
+				code = usage->hid;
+
+			switch (code) {
 
 				/* These usage IDs map directly to the usage codes. */
 				case HID_GD_X: case HID_GD_Y: case HID_GD_Z:
 				case HID_GD_RX: case HID_GD_RY: case HID_GD_RZ:
 				case HID_GD_SLIDER: case HID_GD_DIAL: case HID_GD_WHEEL:
 					if (field->flags & HID_MAIN_ITEM_RELATIVE)
-						map_rel(usage->hid & 0xf);
+						map_rel(code & 0xf);
 					else
-						map_abs(usage->hid & 0xf);
+						map_abs(code & 0xf);
 					break;
 
 				case HID_GD_HATSWITCH:
@@ -569,6 +574,12 @@
 
 	set_bit(usage->type, input->evbit);
 
+	if ((usage->type == EV_REL) &&
+		(device->quirks & HID_QUIRK_BAD_LOGICAL_RANGE) && (field->logical_minimum 
== field->logical_maximum)) {
+		field->logical_minimum = -127;
+		field->logical_maximum = 127;
+	}
+
 	while (usage->code <= max && test_and_set_bit(usage->code, bit))
 		usage->code = find_next_zero_bit(bit, max + 1, usage->code);
 
--- linux-2.6.15/drivers/usb/input/hid-core.c.pn31~	2006-01-22 
18:13:18.000000000 +0100
+++ linux-2.6.15/drivers/usb/input/hid-core.c	2006-01-22 18:13:35.000000000 
+0100
@@ -1449,6 +1449,9 @@
  * Alphabetically sorted blacklist by quirk type.
  */
 
+#define USB_VENDOR_ID_SHUTTLE_REMOTE	0x4572
+#define USB_DEVICE_ID_SHUTTLE_PN31	0x4572
+
 static const struct hid_blacklist {
 	__u16 idVendor;
 	__u16 idProduct;
@@ -1585,6 +1588,8 @@
 	{ USB_VENDOR_ID_APPLE, 0x030A, HID_QUIRK_POWERBOOK_HAS_FN },
 	{ USB_VENDOR_ID_APPLE, 0x030B, HID_QUIRK_POWERBOOK_HAS_FN },
 
+	{ USB_VENDOR_ID_SHUTTLE_REMOTE, USB_DEVICE_ID_SHUTTLE_PN31, 
HID_QUIRK_BAD_LOGICAL_RANGE | HID_QUIRK_HIDDEV | HID_QUIRK_MULTI_INPUT | 
HID_QUIRK_WRONG_CONSTANT | HID_QUIRK_GENDESK_EXTRA_BIT },
+
 	{ 0, 0 }
 };
 
