Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261489AbVE3Atj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbVE3Atj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 20:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbVE3At0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 20:49:26 -0400
Received: from build.arklinux.osuosl.org ([140.211.166.26]:22207 "EHLO
	mail.arklinux.org") by vger.kernel.org with ESMTP id S261485AbVE3AtH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 20:49:07 -0400
From: Bernhard Rosenkraenzer <bero@arklinux.org>
Organization: Ark Linux team
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.12-rc5-mm1] Get Shuttle PN31 remote controls to work
Date: Mon, 30 May 2005 02:49:26 +0200
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_XMmmCxgnwSJLmuz"
Message-Id: <200505300249.27178.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_XMmmCxgnwSJLmuz
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Shuttle PN31 remote controls are supposed to act as a USB keyboard and mouse 
-- this worked fine for older revisions of the remote control, started 
becoming harder with some interim revisions, and in the latest revision, the 
protocol the device speaks is diverging really far from the standard.

As usual, they didn't even change the USB ID or revision number when 
introducing more breakages -- the current revision needs 5 quirks, 2 of which 
are unique to this device so far (it sets a superfluous extra bit on the 
GenericDesktop keycodes, and the mouse flags are wrong (_Constant_, Variable, 
Relative).

The attached patch makes it work.

LLaP
bero

--Boundary-00=_XMmmCxgnwSJLmuz
Content-Type: text/x-diff;
  charset="us-ascii";
  name="shuttle-pn31.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="shuttle-pn31.patch"

--- linux-2.6.11/drivers/usb/input/hid-core.c.pn31~	2005-05-29 15:47:43.000000000 +0000
+++ linux-2.6.11/drivers/usb/input/hid-core.c	2005-05-29 15:47:54.000000000 +0000
@@ -1423,6 +1423,9 @@
  * Alphabetically sorted blacklist by quirk type.
  */
 
+#define USB_VENDOR_ID_SHUTTLE_REMOTE	0x4572
+#define USB_DEVICE_ID_SHUTTLE_PN31	0x4572
+
 static struct hid_blacklist {
 	__u16 idVendor;
 	__u16 idProduct;
@@ -1516,6 +1519,8 @@
 	{ USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RUMBLEPAD, HID_QUIRK_BADPAD },
 	{ USB_VENDOR_ID_TOPMAX, USB_DEVICE_ID_TOPMAX_COBRAPAD, HID_QUIRK_BADPAD },
 
+	{ USB_VENDOR_ID_SHUTTLE_REMOTE, USB_DEVICE_ID_SHUTTLE_PN31, HID_QUIRK_BAD_LOGICAL_RANGE | HID_QUIRK_HIDDEV | HID_QUIRK_MULTI_INPUT | HID_QUIRK_WRONG_CONSTANT | HID_QUIRK_GENDESK_EXTRA_BIT },
+
 	{ 0, 0 }
 };
 
--- linux-2.6.11/drivers/usb/input/hid-input.c.pn31~	2005-05-29 15:47:43.000000000 +0000
+++ linux-2.6.11/drivers/usb/input/hid-input.c	2005-05-29 15:50:08.000000000 +0000
@@ -88,7 +88,7 @@
 	printk(" ---> ");
 #endif
 
-	if (field->flags & HID_MAIN_ITEM_CONSTANT)
+	if ((field->flags & HID_MAIN_ITEM_CONSTANT) && !(device->quirks & HID_QUIRK_WRONG_CONSTANT))
 		goto ignore;
 
 	switch (usage->hid & HID_USAGE_PAGE) {
@@ -158,16 +158,21 @@
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
@@ -342,6 +347,12 @@
 
 	set_bit(usage->type, input->evbit);
 
+	if ((usage->type == EV_REL) &&
+		(device->quirks & HID_QUIRK_BAD_LOGICAL_RANGE) && (field->logical_minimum == field->logical_maximum)) {
+		field->logical_minimum = -127;
+		field->logical_maximum = 127;
+	}
+
 	while (usage->code <= max && test_and_set_bit(usage->code, bit))
 		usage->code = find_next_zero_bit(bit, max + 1, usage->code);
 
--- linux-2.6.11/drivers/usb/input/hid.h.pn31~	2005-05-29 15:47:43.000000000 +0000
+++ linux-2.6.11/drivers/usb/input/hid.h	2005-05-29 15:47:54.000000000 +0000
@@ -232,16 +232,19 @@
  * HID device quirks.
  */
 
-#define HID_QUIRK_INVERT			0x001
-#define HID_QUIRK_NOTOUCH			0x002
-#define HID_QUIRK_IGNORE			0x004
-#define HID_QUIRK_NOGET				0x008
-#define HID_QUIRK_HIDDEV			0x010
-#define HID_QUIRK_BADPAD			0x020
-#define HID_QUIRK_MULTI_INPUT			0x040
-#define HID_QUIRK_2WHEEL_MOUSE_HACK_7		0x080
-#define HID_QUIRK_2WHEEL_MOUSE_HACK_5		0x100
-#define HID_QUIRK_2WHEEL_MOUSE_HACK_ON		0x200
+#define HID_QUIRK_INVERT			0x0001
+#define HID_QUIRK_NOTOUCH			0x0002
+#define HID_QUIRK_IGNORE			0x0004
+#define HID_QUIRK_NOGET				0x0008
+#define HID_QUIRK_HIDDEV			0x0010
+#define HID_QUIRK_BADPAD			0x0020
+#define HID_QUIRK_MULTI_INPUT			0x0040
+#define HID_QUIRK_2WHEEL_MOUSE_HACK_7		0x0080
+#define HID_QUIRK_2WHEEL_MOUSE_HACK_5		0x0100
+#define HID_QUIRK_2WHEEL_MOUSE_HACK_ON		0x0200
+#define HID_QUIRK_BAD_LOGICAL_RANGE		0x0400
+#define HID_QUIRK_WRONG_CONSTANT		0x0800
+#define HID_QUIRK_GENDESK_EXTRA_BIT		0x1000
 
 /*
  * This is the global environment of the parser. This information is

--Boundary-00=_XMmmCxgnwSJLmuz--
