Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265725AbTFNUXl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 16:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265727AbTFNUXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 16:23:41 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:46825 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S265725AbTFNUXW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 16:23:22 -0400
Date: Sat, 14 Jun 2003 22:37:08 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] input: Implement HID quirk for A4Tech mice [3/13]
Message-ID: <20030614223708.B25997@ucw.cz>
References: <20030614223513.A25948@ucw.cz> <20030614223629.A25997@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030614223629.A25997@ucw.cz>; from vojtech@suse.cz on Sat, Jun 14, 2003 at 10:36:29PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1215.104.20, 2003-06-09 13:52:46+02:00, warp@mercury.d2dc.net
  input: Implement a HID quirk for 2-wheel A4Tech mice.


 hid-core.c  |    4 ++++
 hid-input.c |   19 +++++++++++++++++++
 hid.h       |   16 +++++++++-------
 3 files changed, 32 insertions(+), 7 deletions(-)

===================================================================

diff -Nru a/drivers/usb/input/hid-core.c b/drivers/usb/input/hid-core.c
--- a/drivers/usb/input/hid-core.c	Sat Jun 14 22:22:02 2003
+++ b/drivers/usb/input/hid-core.c	Sat Jun 14 22:22:02 2003
@@ -1351,6 +1351,9 @@
 #define USB_VENDOR_ID_ESSENTIAL_REALITY	0x0d7f
 #define USB_DEVICE_ID_ESSENTIAL_REALITY_P5	0x0100
 
+#define USB_VENDOR_ID_A4TECH		0x09DA
+#define USB_DEVICE_ID_A4TECH_WCP32PU	0x0006
+
 struct hid_blacklist {
 	__u16 idVendor;
 	__u16 idProduct;
@@ -1398,6 +1401,7 @@
 	{ USB_VENDOR_ID_ONTRAK, USB_DEVICE_ID_ONTRAK_ADU100 + 500, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_TANGTOP, USB_DEVICE_ID_TANGTOP_USBPS2, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_ESSENTIAL_REALITY, USB_DEVICE_ID_ESSENTIAL_REALITY_P5, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_A4TECH, USB_DEVICE_ID_A4TECH_WCP32PU, HID_QUIRK_2WHEEL_MOUSE_HACK },
 	{ 0, 0 }
 };
 
diff -Nru a/drivers/usb/input/hid-input.c b/drivers/usb/input/hid-input.c
--- a/drivers/usb/input/hid-input.c	Sat Jun 14 22:22:02 2003
+++ b/drivers/usb/input/hid-input.c	Sat Jun 14 22:22:02 2003
@@ -376,6 +376,11 @@
 	}
 
 	set_bit(usage->type, input->evbit);
+	if ((usage->type == EV_REL)
+			&& (device->quirks & HID_QUIRK_2WHEEL_MOUSE_HACK)
+			&& (usage->code == REL_WHEEL)) {
+		set_bit(REL_HWHEEL, bit);
+	}
 
 	while (usage->code <= max && test_and_set_bit(usage->code, bit)) {
 		usage->code = find_next_zero_bit(bit, max + 1, usage->code);
@@ -425,6 +430,20 @@
 		return;
 
 	input_regs(input, regs);
+
+	if ((hid->quirks & HID_QUIRK_2WHEEL_MOUSE_HACK)
+			&& (usage->code == BTN_BACK)) {
+		if (value)
+			hid->quirks |= HID_QUIRK_2WHEEL_MOUSE_HACK_ON;
+		else
+			hid->quirks &= ~HID_QUIRK_2WHEEL_MOUSE_HACK_ON;
+		return;
+	}
+	if ((hid->quirks & HID_QUIRK_2WHEEL_MOUSE_HACK_ON)
+			&& (usage->code == REL_WHEEL)) {
+		input_event(input, usage->type, REL_HWHEEL, value);
+		return;
+	}
 
 	if (usage->hat_min != usage->hat_max) {
 		value = (value - usage->hat_min) * 8 / (usage->hat_max - usage->hat_min + 1) + 1;
diff -Nru a/drivers/usb/input/hid.h b/drivers/usb/input/hid.h
--- a/drivers/usb/input/hid.h	Sat Jun 14 22:22:01 2003
+++ b/drivers/usb/input/hid.h	Sat Jun 14 22:22:01 2003
@@ -201,13 +201,15 @@
  * HID device quirks.
  */
 
-#define HID_QUIRK_INVERT	0x01
-#define HID_QUIRK_NOTOUCH	0x02
-#define HID_QUIRK_IGNORE	0x04
-#define HID_QUIRK_NOGET		0x08
-#define HID_QUIRK_HIDDEV	0x10
-#define HID_QUIRK_BADPAD        0x20
-#define HID_QUIRK_MULTI_INPUT	0x40
+#define HID_QUIRK_INVERT		0x001
+#define HID_QUIRK_NOTOUCH		0x002
+#define HID_QUIRK_IGNORE		0x004
+#define HID_QUIRK_NOGET			0x008
+#define HID_QUIRK_HIDDEV		0x010
+#define HID_QUIRK_BADPAD		0x020
+#define HID_QUIRK_MULTI_INPUT		0x040
+#define HID_QUIRK_2WHEEL_MOUSE_HACK	0x080
+#define HID_QUIRK_2WHEEL_MOUSE_HACK_ON	0x100
 
 /*
  * This is the global environment of the parser. This information is
