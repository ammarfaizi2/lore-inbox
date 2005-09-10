Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932273AbVIJWft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbVIJWft (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 18:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbVIJWe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 18:34:27 -0400
Received: from styx.suse.cz ([82.119.242.94]:40100 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932363AbVIJWdw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 18:33:52 -0400
Subject: [PATCH 20/26] HID - add a quirk for the Apple Powermouse
In-Reply-To: <11263916533298@midnight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Sun, 11 Sep 2005 00:34:13 +0200
Message-Id: <11263916532577@midnight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, dtor_core@ameritech.net, linux-kernel@vger.kernel.org,
       vojtech@suse.cz
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH] Input: HID - add a quirk for the Apple Powermouse
From: Vojtech Pavlik <vojtech@suse.cz>
Date: 1125897195 -0500

Add a quirk for the Apple Powermouse, remapping GenericDesktop.Z to
Rel.HWheel, to allow horizontal scrolling in Linux.

Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

---

 drivers/usb/input/hid-core.c  |    3 +++
 drivers/usb/input/hid-input.c |    3 +++
 drivers/usb/input/hid.h       |    1 +
 3 files changed, 7 insertions(+), 0 deletions(-)

c58de6d949a9d2c386c4d814013b6c967c14ea5a
diff --git a/drivers/usb/input/hid-core.c b/drivers/usb/input/hid-core.c
--- a/drivers/usb/input/hid-core.c
+++ b/drivers/usb/input/hid-core.c
@@ -1442,6 +1442,8 @@ void hid_init_reports(struct hid_device 
 #define USB_DEVICE_ID_NETWORKANALYSER	0x2020
 #define USB_DEVICE_ID_POWERCONTROL	0x2030
 
+#define USB_VENDOR_ID_APPLE		0x05ac
+#define USB_DEVICE_ID_APPLE_POWERMOUSE	0x0304
 
 /*
  * Alphabetically sorted blacklist by quirk type.
@@ -1546,6 +1548,7 @@ static struct hid_blacklist {
 	{ USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_USBHUB_KB, HID_QUIRK_NOGET},
 	{ USB_VENDOR_ID_TANGTOP, USB_DEVICE_ID_TANGTOP_USBPS2, HID_QUIRK_NOGET },
 
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_POWERMOUSE, HID_QUIRK_2WHEEL_POWERMOUSE },
 	{ USB_VENDOR_ID_A4TECH, USB_DEVICE_ID_A4TECH_WCP32PU, HID_QUIRK_2WHEEL_MOUSE_HACK_7 },
 	{ USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_MOUSE, HID_QUIRK_2WHEEL_MOUSE_HACK_5 },
 
diff --git a/drivers/usb/input/hid-input.c b/drivers/usb/input/hid-input.c
--- a/drivers/usb/input/hid-input.c
+++ b/drivers/usb/input/hid-input.c
@@ -396,6 +396,9 @@ static void hidinput_configure_usage(str
 	if (usage->code > max)
 		goto ignore;
 
+	if (((device->quirks & (HID_QUIRK_2WHEEL_POWERMOUSE)) && (usage->hid == 0x00010032)))
+		map_rel(REL_HWHEEL);
+
 	if ((device->quirks & (HID_QUIRK_2WHEEL_MOUSE_HACK_7 | HID_QUIRK_2WHEEL_MOUSE_HACK_5)) &&
 		 (usage->type == EV_REL) && (usage->code == REL_WHEEL))
 			set_bit(REL_HWHEEL, bit);
diff --git a/drivers/usb/input/hid.h b/drivers/usb/input/hid.h
--- a/drivers/usb/input/hid.h
+++ b/drivers/usb/input/hid.h
@@ -245,6 +245,7 @@ struct hid_item {
 #define HID_QUIRK_2WHEEL_MOUSE_HACK_7		0x080
 #define HID_QUIRK_2WHEEL_MOUSE_HACK_5		0x100
 #define HID_QUIRK_2WHEEL_MOUSE_HACK_ON		0x200
+#define HID_QUIRK_2WHEEL_POWERMOUSE		0x400
 
 /*
  * This is the global environment of the parser. This information is

