Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262593AbVG2M6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262593AbVG2M6l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 08:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262597AbVG2M6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 08:58:40 -0400
Received: from gw.alcove.fr ([81.80.245.157]:27535 "EHLO smtp.fr.alcove.com")
	by vger.kernel.org with ESMTP id S262593AbVG2M6k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 08:58:40 -0400
Subject: [PATCH] Input quirk for the Fn key on Powerbooks with an USB
	keyboard
From: Stelian Pop <stelian@popies.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Johannes Berg <johannes@sipsolutions.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 29 Jul 2005 14:55:48 +0200
Message-Id: <1122641749.4521.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On newer Apple Powerbooks (post February 2005 ones at least) the ADB
keyboard has been replaced with an USB one conforming to the HID spec.

The 'Fn' modifier key on this keyboard is a soft key reported using an
application specific hid code. This key should act as a modifier in
order to make Home/End/Page Up/Page Down etc. work.

The attached patch makes the Fn key report a modifier keycode
(KEY_RIGHTCTRL) to the input layer by adding a quirk to the USB HID
input driver. Johannes Berg <johannes@sipsolutions.net> should be
credited for the original version of this patch.

'Right control' is not the best choice for this key, especially since it
is physically placed on the keyboard on the left bottom corner. However,
this laptop already has left shift, control, alt and meta (apple) keys,
and right meta and shift keys. The only modifiers left are 'right
control' and 'right alt' and the first one was chosen. Choosing an
already defined modifier key eases the handling of this key especially
in X (where it can be mapped to SuperL or whatever).

Comments welcomed.

Thanks,

Stelian.

Signed-off-by: Stelian Pop <stelian@popies.net>

 hid-core.c  |    7 +++++++
 hid-input.c |    8 ++++++++
 hid.h       |    1 +
 3 files changed, 16 insertions(+)

Index: linux-2.6.git/drivers/usb/input/hid-core.c
===================================================================
--- linux-2.6.git.orig/drivers/usb/input/hid-core.c	2005-07-28 09:35:52.000000000 +0200
+++ linux-2.6.git/drivers/usb/input/hid-core.c	2005-07-28 12:22:31.000000000 +0200
@@ -1446,6 +1446,10 @@
  * Alphabetically sorted blacklist by quirk type.
  */
 
+#define USB_VENDOR_ID_APPLE		0x05AC
+#define USB_DEVICE_ID_POWERBOOK_KB_US	0x020E
+#define USB_DEVICE_ID_POWERBOOK_KB_UK	0x020F
+
 static struct hid_blacklist {
 	__u16 idVendor;
 	__u16 idProduct;
@@ -1557,6 +1561,9 @@
 	{ USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RUMBLEPAD, HID_QUIRK_BADPAD },
 	{ USB_VENDOR_ID_TOPMAX, USB_DEVICE_ID_TOPMAX_COBRAPAD, HID_QUIRK_BADPAD },
 
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_POWERBOOK_KB_US, HID_QUIRK_POWERBOOK_FN_BUTTON },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_POWERBOOK_KB_UK, HID_QUIRK_POWERBOOK_FN_BUTTON },
+
 	{ 0, 0 }
 };
 
Index: linux-2.6.git/drivers/usb/input/hid-input.c
===================================================================
--- linux-2.6.git.orig/drivers/usb/input/hid-input.c	2005-07-28 09:35:52.000000000 +0200
+++ linux-2.6.git/drivers/usb/input/hid-input.c	2005-07-28 12:23:14.000000000 +0200
@@ -106,6 +106,10 @@
 			} else
 				map_key(KEY_UNKNOWN);
 
+			if ((device->quirks & HID_QUIRK_POWERBOOK_FN_BUTTON) &&
+			    (hid_keyboard[usage->hid & HID_USAGE] == KEY_RIGHTCTRL))
+				map_key(KEY_UNKNOWN);
+
 			break;
 
 		case HID_UP_BUTTON:
@@ -324,6 +328,10 @@
 
 		default:
 		unknown:
+			if ((device->quirks & HID_QUIRK_POWERBOOK_FN_BUTTON) && (usage->hid == 0x00ff0003)) {
+				map_key_clear(KEY_RIGHTCTRL);
+				break;
+			}
 			if (field->report_size == 1) {
 				if (field->report->type == HID_OUTPUT_REPORT) {
 					map_led(LED_MISC);
Index: linux-2.6.git/drivers/usb/input/hid.h
===================================================================
--- linux-2.6.git.orig/drivers/usb/input/hid.h	2005-07-28 09:35:52.000000000 +0200
+++ linux-2.6.git/drivers/usb/input/hid.h	2005-07-28 12:22:31.000000000 +0200
@@ -242,6 +242,7 @@
 #define HID_QUIRK_2WHEEL_MOUSE_HACK_7		0x080
 #define HID_QUIRK_2WHEEL_MOUSE_HACK_5		0x100
 #define HID_QUIRK_2WHEEL_MOUSE_HACK_ON		0x200
+#define HID_QUIRK_POWERBOOK_FN_BUTTON		0x400
 
 /*
  * This is the global environment of the parser. This information is

-- 
Stelian Pop <stelian@popies.net>

