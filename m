Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423061AbWANE6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423061AbWANE6h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 23:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423064AbWANE6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 23:58:37 -0500
Received: from smtp105.sbc.mail.re2.yahoo.com ([68.142.229.100]:3467 "HELO
	smtp105.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1423061AbWANE6g convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 23:58:36 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Michael Hanselmann <linux-kernel@hansmi.ch>
Subject: Re: [PATCH/RFC?] usb/input: Add support for fn key on Apple PowerBooks
Date: Fri, 13 Jan 2006 23:58:33 -0500
User-Agent: KMail/1.8.3
Cc: Vojtech Pavlik <vojtech@suse.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz,
       linuxppc-dev@ozlabs.org, linux-kernel@killerfox.forkbomb.ch
References: <20051225212041.GA6094@hansmi.ch> <20060113074749.GA7103@midnight.suse.cz> <20060113220252.GA1516@hansmi.ch>
In-Reply-To: <20060113220252.GA1516@hansmi.ch>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601132358.33861.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 January 2006 17:02, Michael Hanselmann wrote:
> -                               case 0x003: map_key_clear(KEY_FN);              break;
> +#ifdef CONFIG_USB_HIDINPUT_POWERBOOK
> +                               /* The fn key on Apple PowerBooks */
> +                               case 0x0003: {
> +                                       struct hidinput_key_translation *trans;
> +
> +                                       map_key_clear(KEY_FN);
> +                                       set_bit(KEY_NUMLOCK, input->keybit);
> +

One little thing - I think that we should report FN key even if PowerBook
support is disabled. Can I solicit input on the patch below (I also rearranged
teh code slightly)? 

-- 
Dmitry

From: Michael Hanselmann <linux-kernel@hansmi.ch>

Input: HID - add support for fn key on Apple PowerBooks

This patch implements support for the fn key on Apple PowerBooks using
USB based keyboards and makes them behave like their ADB counterparts.

Signed-off-by: Michael Hanselmann <linux-kernel@hansmi.ch>
Acked-by: Rene Nussbaumer <linux-kernel@killerfox.forkbomb.ch>
Acked-by: Johannes Berg <johannes@sipsolutions.net>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/usb/input/Kconfig     |   10 ++
 drivers/usb/input/hid-core.c  |    8 ++
 drivers/usb/input/hid-input.c |  166 +++++++++++++++++++++++++++++++++++++++++-
 drivers/usb/input/hid.h       |   31 ++++---
 4 files changed, 201 insertions(+), 14 deletions(-)

Index: work/drivers/usb/input/hid-core.c
===================================================================
--- work.orig/drivers/usb/input/hid-core.c
+++ work/drivers/usb/input/hid-core.c
@@ -1585,6 +1585,14 @@ static const struct hid_blacklist {
 
 	{ USB_VENDOR_ID_CHERRY, USB_DEVICE_ID_CHERRY_CYMOTION, HID_QUIRK_CYMOTION },
 
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
 
Index: work/drivers/usb/input/hid.h
===================================================================
--- work.orig/drivers/usb/input/hid.h
+++ work/drivers/usb/input/hid.h
@@ -235,18 +235,20 @@ struct hid_item {
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
-#define HID_QUIRK_2WHEEL_POWERMOUSE		0x400
-#define HID_QUIRK_CYMOTION			0x800
+#define HID_QUIRK_INVERT			0x00000001
+#define HID_QUIRK_NOTOUCH			0x00000002
+#define HID_QUIRK_IGNORE			0x00000004
+#define HID_QUIRK_NOGET				0x00000008
+#define HID_QUIRK_HIDDEV			0x00000010
+#define HID_QUIRK_BADPAD			0x00000020
+#define HID_QUIRK_MULTI_INPUT			0x00000040
+#define HID_QUIRK_2WHEEL_MOUSE_HACK_7		0x00000080
+#define HID_QUIRK_2WHEEL_MOUSE_HACK_5		0x00000100
+#define HID_QUIRK_2WHEEL_MOUSE_HACK_ON		0x00000200
+#define HID_QUIRK_2WHEEL_POWERMOUSE		0x00000400
+#define HID_QUIRK_CYMOTION			0x00000800
+#define HID_QUIRK_POWERBOOK_HAS_FN		0x00001000
+#define HID_QUIRK_POWERBOOK_FN_ON		0x00002000
 
 /*
  * This is the global environment of the parser. This information is
@@ -432,6 +434,11 @@ struct hid_device {							/* device repo
 	void (*ff_exit)(struct hid_device*);                            /* Called by hid_exit_ff(hid) */
 	int (*ff_event)(struct hid_device *hid, struct input_dev *input,
 			unsigned int type, unsigned int code, int value);
+
+#ifdef CONFIG_USB_HIDINPUT_POWERBOOK
+	unsigned long pb_pressed_fn[NBITS(KEY_MAX)];
+	unsigned long pb_pressed_numlock[NBITS(KEY_MAX)];
+#endif
 };
 
 #define HID_GLOBAL_STACK_SIZE 4
Index: work/drivers/usb/input/hid-input.c
===================================================================
--- work.orig/drivers/usb/input/hid-input.c
+++ work/drivers/usb/input/hid-input.c
@@ -73,6 +73,160 @@ static const struct {
 #define map_key_clear(c)	do { map_key(c); clear_bit(c, bit); } while (0)
 #define map_ff_effect(c)	do { set_bit(c, input->ffbit); } while (0)
 
+#ifdef CONFIG_USB_HIDINPUT_POWERBOOK
+
+struct hidinput_key_translation {
+	u16 from;
+	u16 to;
+	u8 flags;
+};
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
+static int usbhid_pb_fnmode = 1;
+module_param_named(pb_fnmode, usbhid_pb_fnmode, int, 0644);
+MODULE_PARM_DESC(pb_fnmode,
+	"Mode of fn key on PowerBooks (0 = disabled, 1 = fkeyslast, 2 = fkeysfirst)");
+
+static struct hidinput_key_translation *find_translation(struct hidinput_key_translation *table, u16 from)
+{
+	struct hidinput_key_translation *trans;
+
+	/* Look for the translation */
+	for (trans = table; trans->from; trans++)
+		if (trans->from == from)
+			return trans;
+
+	return NULL;
+}
+
+static int hidinput_pb_event(struct hid_device *hid, struct input_dev *input,
+			     struct hid_usage *usage, __s32 value)
+{
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
+	if (usbhid_pb_fnmode) {
+		int do_translate;
+
+		trans = find_translation(powerbook_fn_keys, usage->code);
+		if (trans) {
+			if (test_bit(usage->code, hid->pb_pressed_fn))
+				do_translate = 1;
+			else if (trans->flags & POWERBOOK_FLAG_FKEY)
+				do_translate =
+					(usbhid_pb_fnmode == 2 &&  (hid->quirks & HID_QUIRK_POWERBOOK_FN_ON)) ||
+					(usbhid_pb_fnmode == 1 && !(hid->quirks & HID_QUIRK_POWERBOOK_FN_ON));
+			else
+				do_translate = (hid->quirks & HID_QUIRK_POWERBOOK_FN_ON);
+
+			if (do_translate) {
+				if (value)
+					set_bit(usage->code, hid->pb_pressed_fn);
+				else
+					clear_bit(usage->code, hid->pb_pressed_fn);
+
+				input_event(input, usage->type, trans->to, value);
+
+				return 1;
+			}
+		}
+
+		if (test_bit(usage->code, hid->pb_pressed_numlock) ||
+		    test_bit(LED_NUML, input->led)) {
+			trans = find_translation(powerbook_numlock_keys, usage->code);
+
+			if (trans) {
+				if (value)
+					set_bit(usage->code, hid->pb_pressed_numlock);
+				else
+					clear_bit(usage->code, hid->pb_pressed_numlock);
+
+				input_event(input, usage->type, trans->to, value);
+			}
+
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
+static void hidinput_pb_setup(struct input_dev *input)
+{
+	struct hidinput_key_translation *trans;
+
+	set_bit(KEY_NUMLOCK, input->keybit);
+
+	/* Enable all needed keys */
+	for (trans = powerbook_fn_keys; trans->from; trans++)
+		set_bit(trans->to, input->keybit);
+
+	for (trans = powerbook_numlock_keys; trans->from; trans++)
+		set_bit(trans->to, input->keybit);
+}
+#else
+static inline int hidinput_pb_event(struct hid_device *hid, struct input_dev *input,
+				    struct hid_usage *usage, __s32 value)
+{
+	return 0;
+}
+
+static inline void hidinput_pb_setup(struct input_dev *input)
+{
+}
+#endif
+
 static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_field *field,
 				     struct hid_usage *usage)
 {
@@ -336,7 +490,12 @@ static void hidinput_configure_usage(str
 
 			set_bit(EV_REP, input->evbit);
 			switch(usage->hid & HID_USAGE) {
-				case 0x003: map_key_clear(KEY_FN);		break;
+				case 0x003:
+					/* The fn key on Apple PowerBooks */
+					map_key_clear(KEY_FN);
+					hidinput_pb_setup(input);
+					break;
+
 				default:    goto ignore;
 			}
 			break;
@@ -493,6 +652,9 @@ void hidinput_hid_event(struct hid_devic
 		return;
 	}
 
+	if ((hid->quirks & HID_QUIRK_POWERBOOK_HAS_FN) && hidinput_pb_event(hid, input, usage, value))
+		return;
+
 	if (usage->hat_min < usage->hat_max || usage->hat_dir) {
 		int hat_dir = usage->hat_dir;
 		if (!hat_dir)
@@ -535,7 +697,7 @@ void hidinput_hid_event(struct hid_devic
 		return;
 	}
 
-	if((usage->type == EV_KEY) && (usage->code == 0)) /* Key 0 is "unassigned", not KEY_UNKNOWN */
+	if ((usage->type == EV_KEY) && (usage->code == 0)) /* Key 0 is "unassigned", not KEY_UNKNOWN */
 		return;
 
 	input_event(input, usage->type, usage->code, value);
Index: work/drivers/usb/input/Kconfig
===================================================================
--- work.orig/drivers/usb/input/Kconfig
+++ work/drivers/usb/input/Kconfig
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
