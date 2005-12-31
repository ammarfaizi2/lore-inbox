Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751087AbVLaXvd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbVLaXvd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 18:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbVLaXvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 18:51:33 -0500
Received: from hansmi.home.forkbomb.ch ([213.144.146.165]:40732 "EHLO
	hansmi.home.forkbomb.ch") by vger.kernel.org with ESMTP
	id S1751087AbVLaXvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 18:51:32 -0500
Date: Sun, 1 Jan 2006 00:51:24 +0100
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz,
       linuxppc-dev@ozlabs.org, benh@kernel.crashing.org,
       linux-kernel@killerfox.forkbomb.ch, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH/RFC?] usb/input: Add support for fn key on Apple PowerBooks
Message-ID: <20051231235124.GA18506@hansmi.ch>
References: <20051225212041.GA6094@hansmi.ch> <200512252304.32830.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512252304.32830.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 25, 2005 at 11:04:30PM -0500, Dmitry Torokhov wrote:
> Well, we have used 11 out of 32 available bits so there still some
> reserves. My concern is that your implementation allows only one
> hook to be installed while with quirks you can have several of them
> active per device.

Below you find an implementation using quirks:

---
diff -rNup linux-2.6.15-rc7.orig/drivers/usb/input/hid-core.c linux-2.6.15-rc7/drivers/usb/input/hid-core.c
--- linux-2.6.15-rc7.orig/drivers/usb/input/hid-core.c	2006-01-01 00:41:15.000000000 +0100
+++ linux-2.6.15-rc7/drivers/usb/input/hid-core.c	2005-12-31 22:39:53.000000000 +0100
@@ -1580,6 +1580,10 @@ static struct hid_blacklist {
 	{ USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RUMBLEPAD, HID_QUIRK_BADPAD },
 	{ USB_VENDOR_ID_TOPMAX, USB_DEVICE_ID_TOPMAX_COBRAPAD, HID_QUIRK_BADPAD },
 
+	{ USB_VENDOR_ID_APPLE, 0x0214, HID_QUIRK_POWERBOOK_HAS_FN },
+	{ USB_VENDOR_ID_APPLE, 0x0215, HID_QUIRK_POWERBOOK_HAS_FN },
+	{ USB_VENDOR_ID_APPLE, 0x0216, HID_QUIRK_POWERBOOK_HAS_FN },
+
 	{ 0, 0 }
 };
 
diff -rNup linux-2.6.15-rc7.orig/drivers/usb/input/hid-input.c linux-2.6.15-rc7/drivers/usb/input/hid-input.c
--- linux-2.6.15-rc7.orig/drivers/usb/input/hid-input.c	2006-01-01 00:41:15.000000000 +0100
+++ linux-2.6.15-rc7/drivers/usb/input/hid-input.c	2005-12-31 23:49:42.000000000 +0100
@@ -63,6 +63,66 @@ static struct {
 	__s32 y;
 }  hid_hat_to_axis[] = {{ 0, 0}, { 0,-1}, { 1,-1}, { 1, 0}, { 1, 1}, { 0, 1}, {-1, 1}, {-1, 0}, {-1,-1}};
 
+struct input_pb_translation {
+	u16 from;
+	u16 to;
+	u8 flags;
+};
+
+#define POWERBOOK_FLAG_FKEY 0x01
+
+static struct input_pb_translation powerbook_fn_keys[] = {
+	{ KEY_BACKSPACE, KEY_DELETE },
+	{ KEY_F1,	KEY_BRIGHTNESSDOWN,	POWERBOOK_FLAG_FKEY },
+	{ KEY_F2,	KEY_BRIGHTNESSUP,	POWERBOOK_FLAG_FKEY },
+	{ KEY_F3,	KEY_MUTE,		POWERBOOK_FLAG_FKEY },
+	{ KEY_F4,	KEY_VOLUMEDOWN,		POWERBOOK_FLAG_FKEY },
+	{ KEY_F5,	KEY_VOLUMEUP,		POWERBOOK_FLAG_FKEY },
+	{ KEY_F6,	KEY_NUMLOCK,		POWERBOOK_FLAG_FKEY },
+	{ KEY_F7,	KEY_SWITCHVIDEOMODE,	POWERBOOK_FLAG_FKEY },
+	{ KEY_F8,	KEY_KBDILLUMTOGGLE,	POWERBOOK_FLAG_FKEY },
+	{ KEY_F9,	KEY_KBDILLUMDOWN,	POWERBOOK_FLAG_FKEY },
+	{ KEY_F10,	KEY_KBDILLUMUP,		POWERBOOK_FLAG_FKEY },
+	{ KEY_UP,	KEY_PAGEUP },
+	{ KEY_DOWN,	KEY_PAGEDOWN },
+	{ KEY_LEFT,	KEY_HOME },
+	{ KEY_RIGHT,	KEY_END },
+	{ }
+};
+
+static struct input_pb_translation powerbook_numlock_keys[] = {
+	{ KEY_J,	KEY_KP1 },
+	{ KEY_K,	KEY_KP2 },
+	{ KEY_L,	KEY_KP3 },
+	{ KEY_U,	KEY_KP4 },
+	{ KEY_I,	KEY_KP5 },
+	{ KEY_O,	KEY_KP6 },
+	{ KEY_7,	KEY_KP7 },
+	{ KEY_8,	KEY_KP8 },
+	{ KEY_9,	KEY_KP9 },
+	{ KEY_M,	KEY_KP0 },
+	{ KEY_DOT,	KEY_KPDOT },
+	{ KEY_SLASH,	KEY_KPPLUS },
+	{ KEY_SEMICOLON, KEY_KPMINUS },
+	{ KEY_P,	KEY_KPASTERISK },
+	{ KEY_MINUS,	KEY_KPEQUAL },
+	{ KEY_0,	KEY_KPSLASH },
+	{ KEY_ENTER,	KEY_KPENTER },
+	{ }
+};
+
+static int powerbook_fkeysfirst = 1;
+module_param_named(pb_fkeysfirst, powerbook_fkeysfirst, bool, 0644);
+MODULE_PARM_DESC(powerbook_fkeysfirst, "Use fn special keys only while pressing fn");
+
+static int powerbook_enablefnkeys = 1;
+module_param_named(pb_enablefnkeys, powerbook_enablefnkeys, bool, 0644);
+MODULE_PARM_DESC(powerbook_enablefnkeys, "Enable fn special keys");
+
+static int powerbook_enablekeypad = 1;
+module_param_named(pb_enablekeypad, powerbook_enablekeypad, bool, 0644);
+MODULE_PARM_DESC(powerbook_enablekeypad, "Enable keypad keys");
+
 #define map_abs(c)	do { usage->code = c; usage->type = EV_ABS; bit = input->absbit; max = ABS_MAX; } while (0)
 #define map_rel(c)	do { usage->code = c; usage->type = EV_REL; bit = input->relbit; max = REL_MAX; } while (0)
 #define map_key(c)	do { usage->code = c; usage->type = EV_KEY; bit = input->keybit; max = KEY_MAX; } while (0)
@@ -73,6 +133,17 @@ static struct {
 #define map_key_clear(c)	do { map_key(c); clear_bit(c, bit); } while (0)
 #define map_ff_effect(c)	do { set_bit(c, input->ffbit); } while (0)
 
+static inline struct input_pb_translation *find_translation(
+	struct input_pb_translation *table, int from)
+{
+	struct input_pb_translation *trans;
+
+	/* Look for the translation */
+	for(trans = table; trans->from && !(trans->from == from); trans++);
+
+	return (trans->from?trans:NULL);
+}
+
 static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_field *field,
 				     struct hid_usage *usage)
 {
@@ -94,7 +165,7 @@ static void hidinput_configure_usage(str
 
 	switch (usage->hid & HID_USAGE_PAGE) {
 
-		case HID_UP_UNDEFINED:
+	case HID_UP_UNDEFINED:
 			goto ignore;
 
 		case HID_UP_KEYBOARD:
@@ -325,7 +396,25 @@ static void hidinput_configure_usage(str
 
 			set_bit(EV_REP, input->evbit);
 			switch(usage->hid & HID_USAGE) {
-				case 0x003: map_key_clear(KEY_FN);		break;
+				/* The fn key on Apple PowerBooks */
+				case 0x0003: {
+					struct input_pb_translation *trans;
+
+					map_key_clear(KEY_FN);
+
+					set_bit(KEY_FN, input->keybit);
+					set_bit(KEY_NUMLOCK, input->keybit);
+
+					/* Enable all needed keys */
+					for(trans = powerbook_fn_keys; trans->from; trans++)
+						set_bit(trans->to, input->keybit);
+
+					for(trans = powerbook_numlock_keys; trans->from; trans++)
+						set_bit(trans->to, input->keybit);
+
+					goto ignore;
+				}
+
 				default:    goto ignore;
 			}
 			break;
@@ -482,6 +571,49 @@ void hidinput_hid_event(struct hid_devic
 		return;
 	}
 
+	if (hid->quirks & HID_QUIRK_POWERBOOK_HAS_FN) {
+		struct input_pb_translation *trans;
+
+		switch(usage->code) {
+		case KEY_FN:
+			if (value) hid->quirks |=  HID_QUIRK_POWERBOOK_FN_ON;
+			else       hid->quirks &= ~HID_QUIRK_POWERBOOK_FN_ON;
+
+			input_event(input, usage->type, usage->code, value);
+
+			return;
+		}
+
+		if (powerbook_enablefnkeys) {
+			trans = find_translation(powerbook_fn_keys, usage->code);
+
+			if (trans) {
+				int known_key;
+
+				if (trans->flags & POWERBOOK_FLAG_FKEY)
+					known_key =
+						( powerbook_fkeysfirst &&  (hid->quirks & HID_QUIRK_POWERBOOK_FN_ON)) ||
+						(!powerbook_fkeysfirst && !(hid->quirks & HID_QUIRK_POWERBOOK_FN_ON));
+				else
+					known_key = (hid->quirks & HID_QUIRK_POWERBOOK_FN_ON);
+
+				if (known_key) {
+					input_event(input, usage->type, trans->to, value);
+					return;
+				}
+			}
+		}
+
+		if (powerbook_enablekeypad && test_bit(LED_NUML, input->led)) {
+			trans = find_translation(powerbook_numlock_keys, usage->code);
+
+			if (trans)
+				input_event(input, usage->type, trans->to, value);
+
+			return;
+		}
+	}
+
 	if (usage->hat_min < usage->hat_max || usage->hat_dir) {
 		int hat_dir = usage->hat_dir;
 		if (!hat_dir)
diff -rNup linux-2.6.15-rc7.orig/drivers/usb/input/hid.h linux-2.6.15-rc7/drivers/usb/input/hid.h
--- linux-2.6.15-rc7.orig/drivers/usb/input/hid.h	2006-01-01 00:41:15.000000000 +0100
+++ linux-2.6.15-rc7/drivers/usb/input/hid.h	2005-12-31 22:39:49.000000000 +0100
@@ -246,6 +246,9 @@ struct hid_item {
 #define HID_QUIRK_2WHEEL_MOUSE_HACK_5		0x100
 #define HID_QUIRK_2WHEEL_MOUSE_HACK_ON		0x200
 #define HID_QUIRK_2WHEEL_POWERMOUSE		0x400
+#define HID_QUIRK_POWERBOOK_HAS_FN		0x0000800
+#define HID_QUIRK_POWERBOOK_FN_ON		0x0001000
+#define HID_QUIRK_POWERBOOK_NUMLOCK_ON		0x0002000
 
 /*
  * This is the global environment of the parser. This information is
