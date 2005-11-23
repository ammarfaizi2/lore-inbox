Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932419AbVKWW1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbVKWW1n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 17:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932588AbVKWW1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 17:27:43 -0500
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:41738 "EHLO
	anchor-post-31.mail.demon.net") by vger.kernel.org with ESMTP
	id S932419AbVKWW1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 17:27:41 -0500
Date: Wed, 23 Nov 2005 21:46:00 +0000
From: Darren Salt <linux@youmustbejoking.demon.co.uk>
Subject: [RFC][PATCH] USB HID buttons quirk for Chic Technology Corp. Browser Mice
Message-ID: <4DCE821F72%linux@youmustbejoking.demon.co.uk>
User-Agent: Messenger-Pro/3.30b11 (MsgServe/3.11b2) (RISC-OS/4.02) POPstar/2.06+cvs
To: vojtech@suse.cz, linux-usb-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Mail-Followup-To: vojtech@suse.cz, linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux@youmustbejoking.demon.co.uk
X-Editor: Zap 1.47 (17 Oct 2005) [TEST], ZapEmail 0.28.3 (25 Mar 2005) (32)
X-SDate: Wed, 4467 Sep 1993 21:46:00 +0000
X-Message-Flag: Outlook Express is broken. Upgrade to mail(1).
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: 192.168.0.2
X-SA-Exim-Mail-From: linux@youmustbejoking.demon.co.uk
X-SA-Exim-Scanned: No (on pentagram.youmustbejoking.demon.co.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

USB HID buttons quirk for Chic Technology Corp. Browser Mice (ID 05FE:0011).

The example which I have (Advent-badged) has a wheel which can be pushed
sideways (effectively two extra buttons) and a "hot-key" button. These extra
buttons are reported as pairs of other buttons (presumably so that the mouse
can appear as an ExplorerPS/2 device when connected via PS/2). This quirk
maps this behaviour to input events for a USB-connected mouse.

  Action             Reported as               Mapped to
  ------             -----------               ---------
  Wheel left         BTN_MIDDLE + BTN_SIDE     BTN_BACK
  Wheel right        BTN_MIDDLE + BTN_EXTRA    BTN_FORWARD
  "Hot key" press    BTN_RIGHT + BTN_SIDE      BTN_TASK

For a mapping to be used and the appropriate key-down event to be generated,
the relevant reported buttons must be transitioned to "pressed"
simultaneously. With the mapping in use, release of any of them is enough for
the corresponding key-up event.

A suitable X configuration fragment looks something like the following. The
extra buttons appear as 8, 10 and 12 respectively.

Section "InputDevice"
        Identifier      "USB Mouse"
        Driver          "mouse"
        Option          "Protocol"              "evdev"
        Option          "Dev Name"              "Wireless Mouse Wireless Mouse"
        Option          "Dev Phys"              "usb-*/input0"
        Option          "Buttons"               "12"
        Option          "ZAxisMapping"          "4 5"
EndSection

(Compile-tested on 2.6.15-rc2; only one trivial change required from
2.6.13/2.6.14, where it has seen actual use.)


Signed-off-by: Darren Salt <linux@youmustbejoking.demon.co.uk>


diff -up linux-2.6.15-rc2/drivers/usb/input.orig/hid-core.c linux-2.6.15-rc2/drivers/usb/input/hid-core.c
--- linux-2.6.15-rc2/drivers/usb/input.orig/hid-core.c	2005-11-23 20:58:27.000000000 +0000
+++ linux-2.6.15-rc2/drivers/usb/input/hid-core.c	2005-11-23 21:15:17.000000000 +0000
@@ -847,6 +847,9 @@ static void hid_input_field(struct hid_d
 				hid_process_event(hid, field, &field->usage[value[n] - min], 1, interrupt, regs);
 	}
 
+	if (hid->claimed & HID_CLAIMED_INPUT)
+		hidinput_hid_quirks(hid, field, regs);
+
 	memcpy(field->value, value, count * sizeof(__s32));
 exit:
 	kfree(value);
@@ -1393,6 +1396,7 @@ void hid_init_reports(struct hid_device 
 #define USB_DEVICE_ID_NEC_USB_GAME_PAD	0x0301
 
 #define USB_VENDOR_ID_CHIC		0x05fe
+#define USB_DEVICE_ID_CHIC_BROWSER_MOUSE 0x0011
 #define USB_DEVICE_ID_CHIC_GAMEPAD	0x0014
 
 #define USB_VENDOR_ID_GLAB		0x06c2
@@ -1566,6 +1570,7 @@ static struct hid_blacklist {
 	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_POWERMOUSE, HID_QUIRK_2WHEEL_POWERMOUSE },
 	{ USB_VENDOR_ID_A4TECH, USB_DEVICE_ID_A4TECH_WCP32PU, HID_QUIRK_2WHEEL_MOUSE_HACK_7 },
 	{ USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_MOUSE, HID_QUIRK_2WHEEL_MOUSE_HACK_5 },
+	{ USB_VENDOR_ID_CHIC, USB_DEVICE_ID_CHIC_BROWSER_MOUSE, HID_QUIRK_CHIC_2BUTTON_COMBOS_HACK },
 
 	{ USB_VENDOR_ID_AASHIMA, USB_DEVICE_ID_AASHIMA_GAMEPAD, HID_QUIRK_BADPAD },
 	{ USB_VENDOR_ID_AASHIMA, USB_DEVICE_ID_AASHIMA_PREDATOR, HID_QUIRK_BADPAD },
diff -up linux-2.6.15-rc2/drivers/usb/input.orig/hid-input.c linux-2.6.15-rc2/drivers/usb/input/hid-input.c
--- linux-2.6.15-rc2/drivers/usb/input.orig/hid-input.c	2005-11-23 20:58:27.000000000 +0000
+++ linux-2.6.15-rc2/drivers/usb/input/hid-input.c	2005-11-23 21:15:17.000000000 +0000
@@ -407,6 +407,13 @@ static void hidinput_configure_usage(str
 	if (((device->quirks & (HID_QUIRK_2WHEEL_POWERMOUSE)) && (usage->hid == 0x00010032)))
 		map_rel(REL_HWHEEL);
 
+	if ((device->quirks & HID_QUIRK_CHIC_2BUTTON_COMBOS_HACK) &&
+		 (usage->type == EV_KEY) && (usage->code == BTN_EXTRA)) {
+		set_bit(BTN_FORWARD, bit);
+		set_bit(BTN_BACK, bit);
+		set_bit(BTN_TASK, bit);
+	}
+
 	if ((device->quirks & (HID_QUIRK_2WHEEL_MOUSE_HACK_7 | HID_QUIRK_2WHEEL_MOUSE_HACK_5)) &&
 		 (usage->type == EV_REL) && (usage->code == REL_WHEEL))
 			set_bit(REL_HWHEEL, bit);
@@ -523,9 +530,20 @@ void hidinput_hid_event(struct hid_devic
 		return;
 	}
 
+	/* For quirks where one physical button looks like (at least) two other physical buttons */
+	if ((usage->type == EV_KEY) && (usage->hid > 0x00090000) && (usage->hid <= 0x00090010)) {
+		if (value)
+			hid->btn_state |= 1 << (usage->hid - 0x00090001);
+		else
+			hid->btn_state &= ~(1 << (usage->hid - 0x00090001));
+	}
+
 	if((usage->type == EV_KEY) && (usage->code == 0)) /* Key 0 is "unassigned", not KEY_UNKNOWN */
 		return;
 
+	if ((usage->type == EV_KEY) && (hid->quirks & HID_QUIRK_CHIC_2BUTTON_COMBOS_HACK)) /* some buttons may have quirks - *don't* generate events just yet */
+		return;
+
 	input_event(input, usage->type, usage->code, value);
 
 	if ((field->flags & HID_MAIN_ITEM_RELATIVE) && (usage->type == EV_KEY))
@@ -540,6 +558,62 @@ void hidinput_report_event(struct hid_de
 		input_sync(hidinput->input);
 }
 
+void hidinput_hid_quirks(struct hid_device *hid, struct hid_field *field, struct pt_regs *regs)
+{
+	struct input_dev *input;
+	__u16 buttons = hid->btn_state;
+	__u16 previous = hid->btn_prev_state;
+	int i;
+
+	hid->btn_prev_state = buttons;
+
+	if (!field->hidinput || buttons == previous)
+		return;
+
+	input = field->hidinput->input;
+	/*input_regs(input, regs);*/
+
+	/* Chic browser mouse (sold as, at least, Advent 5-button) */
+	if (hid->quirks & HID_QUIRK_CHIC_2BUTTON_COMBOS_HACK) {
+		/* button data */
+		static const struct {
+			__u16 mask, type, button;
+			__s16 value;
+		} meta[] = {
+			{ 1 << 1 | 1 << 3, EV_KEY, BTN_TASK, 1 }, /* 2 and 4 (hot-key) */
+			{ 1 << 2 | 1 << 3, EV_KEY, BTN_BACK, 1 }, /* 3 and 4 (wheel left) */
+			{ 1 << 2 | 1 << 4, EV_KEY, BTN_FORWARD, 1 }, /* 3 and 5 (wheel right) */
+		};
+		int i;
+
+		for (i = 0; i < sizeof(meta) / sizeof(meta[0]); ++i) {
+			/* both clear -> both set => button is now pressed */
+			if (!(hid->btn_quirks & (1 << i))
+			    && ((previous & meta[i].mask) == 0)
+			    && ((buttons & meta[i].mask) == meta[i].mask)) {
+				buttons &= ~meta[i].mask;
+				hid->btn_quirks |= 1 << i;
+				input_event (input, meta[i].type, meta[i].button, meta[i].value);
+			}
+			/* both set -> either clear => button is now released */
+			else
+			if ((hid->btn_quirks & (1 << i))
+			    && ((previous & meta[i].mask) == meta[i].mask)
+			    && ((buttons & meta[i].mask) != meta[i].mask)) {
+				buttons &= ~meta[i].mask;
+				hid->btn_quirks &= ~(1 << i);
+				input_event (input, meta[i].type, meta[i].button, 0);
+			}
+		}
+	}
+	else
+		return;
+
+	for (i = 0; i < 16; ++i)
+		if ((buttons ^ previous) & (1 << i))
+			input_event (input, EV_KEY, BTN_MOUSE + i, (buttons >> i) & 1);
+}
+
 static int hidinput_find_field(struct hid_device *hid, unsigned int type, unsigned int code, struct hid_field **field)
 {
 	struct hid_report *report;
@@ -672,6 +746,10 @@ int hidinput_connect(struct hid_device *
 		input_register_device(hidinput->input);
 	}
 
+	hid->btn_state = 0;
+	hid->btn_prev_state = 0;
+	hid->btn_quirks = 0;
+
 	return 0;
 }
 
diff -up linux-2.6.15-rc2/drivers/usb/input.orig/hid.h linux-2.6.15-rc2/drivers/usb/input/hid.h
--- linux-2.6.15-rc2/drivers/usb/input.orig/hid.h	2005-11-23 20:58:27.000000000 +0000
+++ linux-2.6.15-rc2/drivers/usb/input/hid.h	2005-11-23 21:15:17.000000000 +0000
@@ -246,6 +246,7 @@ struct hid_item {
 #define HID_QUIRK_2WHEEL_MOUSE_HACK_5		0x100
 #define HID_QUIRK_2WHEEL_MOUSE_HACK_ON		0x200
 #define HID_QUIRK_2WHEEL_POWERMOUSE		0x400
+#define HID_QUIRK_CHIC_2BUTTON_COMBOS_HACK	0x800
 
 /*
  * This is the global environment of the parser. This information is
@@ -431,6 +432,10 @@ struct hid_device {							/* device repo
 	void (*ff_exit)(struct hid_device*);                            /* Called by hid_exit_ff(hid) */
 	int (*ff_event)(struct hid_device *hid, struct input_dev *input,
 			unsigned int type, unsigned int code, int value);
+
+	/* For quirks where one physical button looks like (at least) two other physical buttons */
+	__u16 btn_state, btn_prev_state;				/* Button map data */
+	__u32 btn_quirks;						/* Which of the extra buttons are active */
 };
 
 #define HID_GLOBAL_STACK_SIZE 4
@@ -479,6 +484,7 @@ struct hid_descriptor {
 #define IS_INPUT_APPLICATION(a) (((a >= 0x00010000) && (a <= 0x00010008)) || (a == 0x00010080) || (a == 0x000c0001))
 extern void hidinput_hid_event(struct hid_device *, struct hid_field *, struct hid_usage *, __s32, struct pt_regs *regs);
 extern void hidinput_report_event(struct hid_device *hid, struct hid_report *report);
+extern void hidinput_hid_quirks(struct hid_device *, struct hid_field *, struct pt_regs *);
 extern int hidinput_connect(struct hid_device *);
 extern void hidinput_disconnect(struct hid_device *);
 #else

-- 
| Darren Salt | nr. Ashington, | d youmustbejoking,demon,co,uk
| Debian,     | Northumberland | s zap,tartarus,org
| RISC OS     | Toon Army      | @
|   Retrocomputing: a PC card in a Risc PC

For best results, squeeze from the bottom of the tube.
