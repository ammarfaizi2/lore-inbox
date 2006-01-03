Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751479AbWACTZb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbWACTZb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 14:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbWACTZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 14:25:31 -0500
Received: from hansmi.home.forkbomb.ch ([213.144.146.165]:49948 "EHLO
	hansmi.home.forkbomb.ch") by vger.kernel.org with ESMTP
	id S1751480AbWACTZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 14:25:29 -0500
Date: Tue, 3 Jan 2006 20:25:25 +0100
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: Ben Collins <ben.collins@ubuntu.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       linux-input@atrey.karlin.mff.cuni.cz, linuxppc-dev@ozlabs.org,
       linux-kernel@killerfox.forkbomb.ch, Vojtech Pavlik <vojtech@suse.cz>,
       stelian@popies.net
Subject: Re: [PATCH/RFC?] usb/input: Add support for fn key on Apple PowerBooks
Message-ID: <20060103192525.GB11169@hansmi.ch>
References: <20051225212041.GA6094@hansmi.ch> <200512252304.32830.dtor_core@ameritech.net> <20051231235124.GA18506@hansmi.ch> <1136084207.4635.86.camel@localhost.localdomain> <20060102224640.GB27317@hansmi.ch> <1136255354.27583.77.camel@grayson> <20060103191433.GA11169@hansmi.ch> <1136315929.14744.2.camel@grayson>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136315929.14744.2.camel@grayson>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2006 at 02:18:49PM -0500, Ben Collins wrote:
> For it to be useful, you have to not initialize them (since they are
> static, they will be zero'd anyway). Initializing them defeats the
> purpose.

Dang, should have known that. I feel somewhat guilty having to send so
many patches. Anyway, here's another one with that small issue fixed:

---
diff -rNup linux-2.6.15-rc7.orig/drivers/usb/input/Kconfig linux-2.6.15-rc7/drivers/usb/input/Kconfig
--- linux-2.6.15-rc7.orig/drivers/usb/input/Kconfig	2006-01-01 00:41:15.000000000 +0100
+++ linux-2.6.15-rc7/drivers/usb/input/Kconfig	2006-01-02 20:26:21.000000000 +0100
@@ -37,6 +37,16 @@ config USB_HIDINPUT
 
 	  If unsure, say Y.
 
+config USB_HIDINPUT_POWERBOOK
+	bool "Enable support for iBook/PowerBook special keys"
+	default n
+	depends on USB_HIDINPUT
+	help
+	  Say Y here if you want support for the special keys (Fn, Numlock) on
+	  Apple iBooks and PowerBooks.
+
+	  If unsure, say N.
+
 config HID_FF
 	bool "Force feedback support (EXPERIMENTAL)"
 	depends on USB_HIDINPUT && EXPERIMENTAL
diff -rNup linux-2.6.15-rc7.orig/drivers/usb/input/hid-core.c linux-2.6.15-rc7/drivers/usb/input/hid-core.c
--- linux-2.6.15-rc7.orig/drivers/usb/input/hid-core.c	2006-01-01 00:41:15.000000000 +0100
+++ linux-2.6.15-rc7/drivers/usb/input/hid-core.c	2006-01-02 13:52:59.000000000 +0100
@@ -1580,6 +1580,14 @@ static struct hid_blacklist {
 	{ USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RUMBLEPAD, HID_QUIRK_BADPAD },
 	{ USB_VENDOR_ID_TOPMAX, USB_DEVICE_ID_TOPMAX_COBRAPAD, HID_QUIRK_BADPAD },
 
+	{ USB_VENDOR_ID_APPLE, 0x020E, HID_QUIRK_POWERBOOK_HAS_FN },
+	{ USB_VENDOR_ID_APPLE, 0x020F, HID_QUIRK_POWERBOOK_HAS_FN },
+	{ USB_VENDOR_ID_APPLE, 0x0214, HID_QUIRK_POWERBOOK_HAS_FN },
+	{ USB_VENDOR_ID_APPLE, 0x0215, HID_QUIRK_POWERBOOK_HAS_FN },
+	{ USB_VENDOR_ID_APPLE, 0x0216, HID_QUIRK_POWERBOOK_HAS_FN },
+	{ USB_VENDOR_ID_APPLE, 0x030A, HID_QUIRK_POWERBOOK_HAS_FN },
+	{ USB_VENDOR_ID_APPLE, 0x030B, HID_QUIRK_POWERBOOK_HAS_FN },
+
 	{ 0, 0 }
 };
 
diff -rNup linux-2.6.15-rc7.orig/drivers/usb/input/hid-input.c linux-2.6.15-rc7/drivers/usb/input/hid-input.c
--- linux-2.6.15-rc7.orig/drivers/usb/input/hid-input.c	2006-01-01 00:41:15.000000000 +0100
+++ linux-2.6.15-rc7/drivers/usb/input/hid-input.c	2006-01-03 20:21:00.000000000 +0100
@@ -63,6 +63,71 @@ static struct {
 	__s32 y;
 }  hid_hat_to_axis[] = {{ 0, 0}, { 0,-1}, { 1,-1}, { 1, 0}, { 1, 1}, { 0, 1}, {-1, 1}, {-1, 0}, {-1,-1}};
 
+struct hidinput_key_translation {
+	u16 from;
+	u16 to;
+	u8 flags;
+};
+
+#ifdef CONFIG_USB_HIDINPUT_POWERBOOK
+
+#define POWERBOOK_FLAG_FKEY 0x01
+
+static struct hidinput_key_translation powerbook_fn_keys[] = {
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
+static struct hidinput_key_translation powerbook_numlock_keys[] = {
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
+	{ KEY_F6,	KEY_NUMLOCK },
+	{ KEY_KPENTER,	KEY_KPENTER },
+	{ KEY_BACKSPACE, KEY_BACKSPACE },
+	{ }
+};
+
+static int usbhid_pb_fkeyslast;
+module_param_named(pb_fkeyslast, usbhid_pb_fkeyslast, bool, 0644);
+MODULE_PARM_DESC(usbhid_pb_fkeyslast, "Use F keys only while pressing fn on PowerBooks");
+
+static int usbhid_pb_disablefnkeys;
+module_param_named(pb_disablefnkeys, usbhid_pb_disablefnkeys, bool, 0644);
+MODULE_PARM_DESC(usbhid_pb_disablefnkeys, "Disable fn special keys on PowerBooks");
+
+static int usbhid_pb_disablekeypad;
+module_param_named(pb_disablekeypad, usbhid_pb_disablekeypad, bool, 0644);
+MODULE_PARM_DESC(usbhid_pb_disablekeypad, "Disable keypad keys on PowerBooks");
+#endif
+
 #define map_abs(c)	do { usage->code = c; usage->type = EV_ABS; bit = input->absbit; max = ABS_MAX; } while (0)
 #define map_rel(c)	do { usage->code = c; usage->type = EV_REL; bit = input->relbit; max = REL_MAX; } while (0)
 #define map_key(c)	do { usage->code = c; usage->type = EV_KEY; bit = input->keybit; max = KEY_MAX; } while (0)
@@ -73,6 +138,85 @@ static struct {
 #define map_key_clear(c)	do { map_key(c); clear_bit(c, bit); } while (0)
 #define map_ff_effect(c)	do { set_bit(c, input->ffbit); } while (0)
 
+static inline struct hidinput_key_translation *find_translation(
+	struct hidinput_key_translation *table, u16 from)
+{
+	struct hidinput_key_translation *trans;
+
+	/* Look for the translation */
+	for(trans = table; trans->from && (trans->from != from); trans++);
+
+	return (trans->from?trans:NULL);
+}
+
+static int hidinput_pb_event(struct hid_device *hid, struct input_dev *input,
+	struct hid_usage *usage, __s32 value)
+{
+#ifdef CONFIG_USB_HIDINPUT_POWERBOOK
+	struct hidinput_key_translation *trans;
+
+	if (usage->code == KEY_FN) {
+		if (value) hid->quirks |=  HID_QUIRK_POWERBOOK_FN_ON;
+		else       hid->quirks &= ~HID_QUIRK_POWERBOOK_FN_ON;
+
+		input_event(input, usage->type, usage->code, value);
+
+		return 1;
+	}
+
+	if (!usbhid_pb_disablefnkeys) {
+		trans = find_translation(powerbook_fn_keys, usage->code);
+
+		if (trans) {
+			int do_translate;
+
+			if (test_bit(usage->code, hid->pb_fn))
+				do_translate = 1;
+			else if (trans->flags & POWERBOOK_FLAG_FKEY)
+				do_translate =
+					(!usbhid_pb_fkeyslast &&  (hid->quirks & HID_QUIRK_POWERBOOK_FN_ON)) ||
+					( usbhid_pb_fkeyslast && !(hid->quirks & HID_QUIRK_POWERBOOK_FN_ON));
+			else
+				do_translate = (hid->quirks & HID_QUIRK_POWERBOOK_FN_ON);
+
+			if (do_translate) {
+				if (value)
+					set_bit(usage->code, hid->pb_fn);
+				else
+					clear_bit(usage->code, hid->pb_fn);
+
+				input_event(input, usage->type, trans->to, value);
+
+				return 1;
+			}
+		}
+	}
+
+	if (!usbhid_pb_disablekeypad) {
+		int try_translate =
+			test_bit(usage->code, hid->pb_numlock)?1:
+			test_bit(LED_NUML, input->led);
+
+		if (try_translate) {
+			trans = find_translation(powerbook_numlock_keys, usage->code);
+
+			if (trans) {
+				if (value)
+					set_bit(usage->code, hid->pb_numlock);
+				else
+					clear_bit(usage->code, hid->pb_numlock);
+
+				input_event(input, usage->type, trans->to, value);
+			}
+
+			return 1;
+		}
+	}
+#endif
+
+	return 0;
+}
+
 static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_field *field,
 				     struct hid_usage *usage)
 {
@@ -325,7 +469,27 @@ static void hidinput_configure_usage(str
 
 			set_bit(EV_REP, input->evbit);
 			switch(usage->hid & HID_USAGE) {
-				case 0x003: map_key_clear(KEY_FN);		break;
+#ifdef CONFIG_USB_HIDINPUT_POWERBOOK
+				/* The fn key on Apple PowerBooks */
+				case 0x0003: {
+					struct hidinput_key_translation *trans;
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
+#endif
+
 				default:    goto ignore;
 			}
 			break;
@@ -482,6 +646,11 @@ void hidinput_hid_event(struct hid_devic
 		return;
 	}
 
+	if ((hid->quirks & HID_QUIRK_POWERBOOK_HAS_FN) &&
+	    hidinput_pb_event(hid, input, usage, value)) {
+		return;
+	}
+
 	if (usage->hat_min < usage->hat_max || usage->hat_dir) {
 		int hat_dir = usage->hat_dir;
 		if (!hat_dir)
diff -rNup linux-2.6.15-rc7.orig/drivers/usb/input/hid.h linux-2.6.15-rc7/drivers/usb/input/hid.h
--- linux-2.6.15-rc7.orig/drivers/usb/input/hid.h	2006-01-01 00:41:15.000000000 +0100
+++ linux-2.6.15-rc7/drivers/usb/input/hid.h	2006-01-03 00:45:13.000000000 +0100
@@ -246,6 +246,8 @@ struct hid_item {
 #define HID_QUIRK_2WHEEL_MOUSE_HACK_5		0x100
 #define HID_QUIRK_2WHEEL_MOUSE_HACK_ON		0x200
 #define HID_QUIRK_2WHEEL_POWERMOUSE		0x400
+#define HID_QUIRK_POWERBOOK_HAS_FN		0x00000800
+#define HID_QUIRK_POWERBOOK_FN_ON		0x00001000
 
 /*
  * This is the global environment of the parser. This information is
@@ -431,6 +433,14 @@ struct hid_device {							/* device repo
 	void (*ff_exit)(struct hid_device*);                            /* Called by hid_exit_ff(hid) */
 	int (*ff_event)(struct hid_device *hid, struct input_dev *input,
 			unsigned int type, unsigned int code, int value);
+
+#ifdef CONFIG_USB_HIDINPUT_POWERBOOK
+	/* We do this here because it's only relevant for the
+	 * USB devices, not for all input_dev's.
+	 */
+	unsigned long pb_fn[NBITS(KEY_MAX)];
+	unsigned long pb_numlock[NBITS(KEY_MAX)];
+#endif
 };
 
 #define HID_GLOBAL_STACK_SIZE 4
