Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030441AbVIOHJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030441AbVIOHJo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 03:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030439AbVIOHEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 03:04:05 -0400
Received: from smtp101.sbc.mail.re2.yahoo.com ([68.142.229.104]:25511 "HELO
	smtp101.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030436AbVIOHEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 03:04:02 -0400
Message-Id: <20050915070303.064107000.dtor_core@ameritech.net>
References: <20050915070131.813650000.dtor_core@ameritech.net>
Date: Thu, 15 Sep 2005 02:01:41 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>,
       Kay Sievers <kay.sievers@vrfy.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Hannes Reinecke <hare@suse.de>
Subject: [patch 10/28] Input: convert drivers/macintosh to dynamic input_dev allocation
Content-Disposition: inline; filename=input-dynalloc-macintosh.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: convert drivers/macntosh to dynamic input_dev allocation

This is required for input_dev sysfs integration

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/macintosh/adbhid.c  |  220 +++++++++++++++++++++++---------------------
 drivers/macintosh/mac_hid.c |   44 ++++----
 2 files changed, 139 insertions(+), 125 deletions(-)

Index: work/drivers/macintosh/adbhid.c
===================================================================
--- work.orig/drivers/macintosh/adbhid.c
+++ work/drivers/macintosh/adbhid.c
@@ -206,7 +206,7 @@ u8 adb_to_linux_keycodes[128] = {
 };
 
 struct adbhid {
-	struct input_dev input;
+	struct input_dev *input;
 	int id;
 	int default_id;
 	int original_handler_id;
@@ -291,10 +291,10 @@ adbhid_input_keycode(int id, int keycode
 
 	switch (keycode) {
 	case ADB_KEY_CAPSLOCK: /* Generate down/up events for CapsLock everytime. */
-		input_regs(&ahid->input, regs);
-		input_report_key(&ahid->input, KEY_CAPSLOCK, 1);
-		input_report_key(&ahid->input, KEY_CAPSLOCK, 0);
-		input_sync(&ahid->input);
+		input_regs(ahid->input, regs);
+		input_report_key(ahid->input, KEY_CAPSLOCK, 1);
+		input_report_key(ahid->input, KEY_CAPSLOCK, 0);
+		input_sync(ahid->input);
 		return;
 #ifdef CONFIG_PPC_PMAC
 	case ADB_KEY_POWER_OLD: /* Power key on PBook 3400 needs remapping */
@@ -347,10 +347,10 @@ adbhid_input_keycode(int id, int keycode
 	}
 
 	if (adbhid[id]->keycode[keycode]) {
-		input_regs(&adbhid[id]->input, regs);
-		input_report_key(&adbhid[id]->input,
+		input_regs(adbhid[id]->input, regs);
+		input_report_key(adbhid[id]->input,
 				 adbhid[id]->keycode[keycode], !up_flag);
-		input_sync(&adbhid[id]->input);
+		input_sync(adbhid[id]->input);
 	} else
 		printk(KERN_INFO "Unhandled ADB key (scancode %#02x) %s.\n", keycode,
 		       up_flag ? "released" : "pressed");
@@ -441,20 +441,20 @@ adbhid_mouse_input(unsigned char *data, 
                 break;
 	}
 
-	input_regs(&adbhid[id]->input, regs);
+	input_regs(adbhid[id]->input, regs);
 
-	input_report_key(&adbhid[id]->input, BTN_LEFT,   !((data[1] >> 7) & 1));
-	input_report_key(&adbhid[id]->input, BTN_MIDDLE, !((data[2] >> 7) & 1));
+	input_report_key(adbhid[id]->input, BTN_LEFT,   !((data[1] >> 7) & 1));
+	input_report_key(adbhid[id]->input, BTN_MIDDLE, !((data[2] >> 7) & 1));
 
 	if (nb >= 4 && adbhid[id]->mouse_kind != ADBMOUSE_TRACKPAD)
-		input_report_key(&adbhid[id]->input, BTN_RIGHT,  !((data[3] >> 7) & 1));
+		input_report_key(adbhid[id]->input, BTN_RIGHT,  !((data[3] >> 7) & 1));
 
-	input_report_rel(&adbhid[id]->input, REL_X,
+	input_report_rel(adbhid[id]->input, REL_X,
 			 ((data[2]&0x7f) < 64 ? (data[2]&0x7f) : (data[2]&0x7f)-128 ));
-	input_report_rel(&adbhid[id]->input, REL_Y,
+	input_report_rel(adbhid[id]->input, REL_Y,
 			 ((data[1]&0x7f) < 64 ? (data[1]&0x7f) : (data[1]&0x7f)-128 ));
 
-	input_sync(&adbhid[id]->input);
+	input_sync(adbhid[id]->input);
 }
 
 static void
@@ -467,7 +467,7 @@ adbhid_buttons_input(unsigned char *data
 		return;
 	}
 
-	input_regs(&adbhid[id]->input, regs);
+	input_regs(adbhid[id]->input, regs);
 
 	switch (adbhid[id]->original_handler_id) {
 	default:
@@ -477,19 +477,19 @@ adbhid_buttons_input(unsigned char *data
 
 		switch (data[1] & 0x0f) {
 		case 0x0:	/* microphone */
-			input_report_key(&adbhid[id]->input, KEY_SOUND, down);
+			input_report_key(adbhid[id]->input, KEY_SOUND, down);
 			break;
 
 		case 0x1:	/* mute */
-			input_report_key(&adbhid[id]->input, KEY_MUTE, down);
+			input_report_key(adbhid[id]->input, KEY_MUTE, down);
 			break;
 
 		case 0x2:	/* volume decrease */
-			input_report_key(&adbhid[id]->input, KEY_VOLUMEDOWN, down);
+			input_report_key(adbhid[id]->input, KEY_VOLUMEDOWN, down);
 			break;
 
 		case 0x3:	/* volume increase */
-			input_report_key(&adbhid[id]->input, KEY_VOLUMEUP, down);
+			input_report_key(adbhid[id]->input, KEY_VOLUMEUP, down);
 			break;
 
 		default:
@@ -513,19 +513,19 @@ adbhid_buttons_input(unsigned char *data
 
 		switch (data[1] & 0x0f) {
 		case 0x8:	/* mute */
-			input_report_key(&adbhid[id]->input, KEY_MUTE, down);
+			input_report_key(adbhid[id]->input, KEY_MUTE, down);
 			break;
 
 		case 0x7:	/* volume decrease */
-			input_report_key(&adbhid[id]->input, KEY_VOLUMEDOWN, down);
+			input_report_key(adbhid[id]->input, KEY_VOLUMEDOWN, down);
 			break;
 
 		case 0x6:	/* volume increase */
-			input_report_key(&adbhid[id]->input, KEY_VOLUMEUP, down);
+			input_report_key(adbhid[id]->input, KEY_VOLUMEUP, down);
 			break;
 
 		case 0xb:	/* eject */
-			input_report_key(&adbhid[id]->input, KEY_EJECTCD, down);
+			input_report_key(adbhid[id]->input, KEY_EJECTCD, down);
 			break;
 
 		case 0xa:	/* brightness decrease */
@@ -539,7 +539,7 @@ adbhid_buttons_input(unsigned char *data
 				}
 			}
 #endif /* CONFIG_PMAC_BACKLIGHT */
-			input_report_key(&adbhid[id]->input, KEY_BRIGHTNESSDOWN, down);
+			input_report_key(adbhid[id]->input, KEY_BRIGHTNESSDOWN, down);
 			break;
 
 		case 0x9:	/* brightness increase */
@@ -553,19 +553,19 @@ adbhid_buttons_input(unsigned char *data
 				}
 			}
 #endif /* CONFIG_PMAC_BACKLIGHT */
-			input_report_key(&adbhid[id]->input, KEY_BRIGHTNESSUP, down);
+			input_report_key(adbhid[id]->input, KEY_BRIGHTNESSUP, down);
 			break;
 
 		case 0xc:	/* videomode switch */
-			input_report_key(&adbhid[id]->input, KEY_SWITCHVIDEOMODE, down);
+			input_report_key(adbhid[id]->input, KEY_SWITCHVIDEOMODE, down);
 			break;
 
 		case 0xd:	/* keyboard illumination toggle */
-			input_report_key(&adbhid[id]->input, KEY_KBDILLUMTOGGLE, down);
+			input_report_key(adbhid[id]->input, KEY_KBDILLUMTOGGLE, down);
 			break;
 
 		case 0xe:	/* keyboard illumination decrease */
-			input_report_key(&adbhid[id]->input, KEY_KBDILLUMDOWN, down);
+			input_report_key(adbhid[id]->input, KEY_KBDILLUMDOWN, down);
 			break;
 
 		case 0xf:
@@ -573,7 +573,7 @@ adbhid_buttons_input(unsigned char *data
 			case 0x8f:
 			case 0x0f:
 				/* keyboard illumination increase */
-				input_report_key(&adbhid[id]->input, KEY_KBDILLUMUP, down);
+				input_report_key(adbhid[id]->input, KEY_KBDILLUMUP, down);
 				break;
 
 			case 0x7f:
@@ -596,7 +596,7 @@ adbhid_buttons_input(unsigned char *data
 	  break;
 	}
 
-	input_sync(&adbhid[id]->input);
+	input_sync(adbhid[id]->input);
 }
 
 static struct adb_request led_request;
@@ -683,7 +683,7 @@ adb_message_handler(struct notifier_bloc
 			int i;
 			for (i = 1; i < 16; i++) {
 				if (adbhid[i])
-					del_timer_sync(&adbhid[i]->input.timer);
+					del_timer_sync(&adbhid[i]->input->timer);
 			}
 		}
 
@@ -699,153 +699,163 @@ adb_message_handler(struct notifier_bloc
 	return NOTIFY_DONE;
 }
 
-static void
+static int
 adbhid_input_register(int id, int default_id, int original_handler_id,
 		      int current_handler_id, int mouse_kind)
 {
+	struct adbhid *hid;
+	struct input_dev *input_dev;
+	int err;
 	int i;
 
 	if (adbhid[id]) {
 		printk(KERN_ERR "Trying to reregister ADB HID on ID %d\n", id);
-		return;
+		return -EEXIST;
 	}
 
-	if (!(adbhid[id] = kmalloc(sizeof(struct adbhid), GFP_KERNEL)))
-		return;
-
-	memset(adbhid[id], 0, sizeof(struct adbhid));
-	sprintf(adbhid[id]->phys, "adb%d:%d.%02x/input", id, default_id, original_handler_id);
+	adbhid[id] = hid = kzalloc(sizeof(struct adbhid), GFP_KERNEL);
+	input_dev = input_allocate_device();
+	if (!hid || !input_dev) {
+		err = -ENOMEM;
+		goto fail;
 
-	init_input_dev(&adbhid[id]->input);
+	}
 
-	adbhid[id]->id = default_id;
-	adbhid[id]->original_handler_id = original_handler_id;
-	adbhid[id]->current_handler_id = current_handler_id;
-	adbhid[id]->mouse_kind = mouse_kind;
-	adbhid[id]->flags = 0;
-	adbhid[id]->input.private = adbhid[id];
-	adbhid[id]->input.name = adbhid[id]->name;
-	adbhid[id]->input.phys = adbhid[id]->phys;
-	adbhid[id]->input.id.bustype = BUS_ADB;
-	adbhid[id]->input.id.vendor = 0x0001;
-	adbhid[id]->input.id.product = (id << 12) | (default_id << 8) | original_handler_id;
-	adbhid[id]->input.id.version = 0x0100;
+	sprintf(hid->phys, "adb%d:%d.%02x/input", id, default_id, original_handler_id);
+
+	hid->id = default_id;
+	hid->original_handler_id = original_handler_id;
+	hid->current_handler_id = current_handler_id;
+	hid->mouse_kind = mouse_kind;
+	hid->flags = 0;
+	input_dev->private = hid;
+	input_dev->name = hid->name;
+	input_dev->phys = hid->phys;
+	input_dev->id.bustype = BUS_ADB;
+	input_dev->id.vendor = 0x0001;
+	input_dev->id.product = (id << 12) | (default_id << 8) | original_handler_id;
+	input_dev->id.version = 0x0100;
 
 	switch (default_id) {
 	case ADB_KEYBOARD:
-		if (!(adbhid[id]->keycode = kmalloc(sizeof(adb_to_linux_keycodes), GFP_KERNEL))) {
-			kfree(adbhid[id]);
-			return;
+		hid->keycode = kmalloc(sizeof(adb_to_linux_keycodes), GFP_KERNEL);
+		if (!hid->keycode) {
+			err = -ENOMEM;
+			goto fail;
 		}
 
-		sprintf(adbhid[id]->name, "ADB keyboard");
+		sprintf(hid->name, "ADB keyboard");
 
-		memcpy(adbhid[id]->keycode, adb_to_linux_keycodes, sizeof(adb_to_linux_keycodes));
+		memcpy(hid->keycode, adb_to_linux_keycodes, sizeof(adb_to_linux_keycodes));
 
 		printk(KERN_INFO "Detected ADB keyboard, type ");
 		switch (original_handler_id) {
 		default:
 			printk("<unknown>.\n");
-			adbhid[id]->input.id.version = ADB_KEYBOARD_UNKNOWN;
+			input_dev->id.version = ADB_KEYBOARD_UNKNOWN;
 			break;
 
 		case 0x01: case 0x02: case 0x03: case 0x06: case 0x08:
 		case 0x0C: case 0x10: case 0x18: case 0x1B: case 0x1C:
 		case 0xC0: case 0xC3: case 0xC6:
 			printk("ANSI.\n");
-			adbhid[id]->input.id.version = ADB_KEYBOARD_ANSI;
+			input_dev->id.version = ADB_KEYBOARD_ANSI;
 			break;
 
 		case 0x04: case 0x05: case 0x07: case 0x09: case 0x0D:
 		case 0x11: case 0x14: case 0x19: case 0x1D: case 0xC1:
 		case 0xC4: case 0xC7:
 			printk("ISO, swapping keys.\n");
-			adbhid[id]->input.id.version = ADB_KEYBOARD_ISO;
-			i = adbhid[id]->keycode[10];
-			adbhid[id]->keycode[10] = adbhid[id]->keycode[50];
-			adbhid[id]->keycode[50] = i;
+			input_dev->id.version = ADB_KEYBOARD_ISO;
+			i = hid->keycode[10];
+			hid->keycode[10] = hid->keycode[50];
+			hid->keycode[50] = i;
 			break;
 
 		case 0x12: case 0x15: case 0x16: case 0x17: case 0x1A:
 		case 0x1E: case 0xC2: case 0xC5: case 0xC8: case 0xC9:
 			printk("JIS.\n");
-			adbhid[id]->input.id.version = ADB_KEYBOARD_JIS;
+			input_dev->id.version = ADB_KEYBOARD_JIS;
 			break;
 		}
 
 		for (i = 0; i < 128; i++)
-			if (adbhid[id]->keycode[i])
-				set_bit(adbhid[id]->keycode[i], adbhid[id]->input.keybit);
+			if (hid->keycode[i])
+				set_bit(hid->keycode[i], input_dev->keybit);
 
-		adbhid[id]->input.evbit[0] = BIT(EV_KEY) | BIT(EV_LED) | BIT(EV_REP);
-		adbhid[id]->input.ledbit[0] = BIT(LED_SCROLLL) | BIT(LED_CAPSL) | BIT(LED_NUML);
-		adbhid[id]->input.event = adbhid_kbd_event;
-		adbhid[id]->input.keycodemax = 127;
-		adbhid[id]->input.keycodesize = 1;
+		input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_LED) | BIT(EV_REP);
+		input_dev->ledbit[0] = BIT(LED_SCROLLL) | BIT(LED_CAPSL) | BIT(LED_NUML);
+		input_dev->event = adbhid_kbd_event;
+		input_dev->keycodemax = 127;
+		input_dev->keycodesize = 1;
 		break;
 
 	case ADB_MOUSE:
-		sprintf(adbhid[id]->name, "ADB mouse");
+		sprintf(hid->name, "ADB mouse");
 
-		adbhid[id]->input.evbit[0] = BIT(EV_KEY) | BIT(EV_REL);
-		adbhid[id]->input.keybit[LONG(BTN_MOUSE)] = BIT(BTN_LEFT) | BIT(BTN_MIDDLE) | BIT(BTN_RIGHT);
-		adbhid[id]->input.relbit[0] = BIT(REL_X) | BIT(REL_Y);
+		input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_REL);
+		input_dev->keybit[LONG(BTN_MOUSE)] = BIT(BTN_LEFT) | BIT(BTN_MIDDLE) | BIT(BTN_RIGHT);
+		input_dev->relbit[0] = BIT(REL_X) | BIT(REL_Y);
 		break;
 
 	case ADB_MISC:
 		switch (original_handler_id) {
 		case 0x02: /* Adjustable keyboard button device */
-			sprintf(adbhid[id]->name, "ADB adjustable keyboard buttons");
-			adbhid[id]->input.evbit[0] = BIT(EV_KEY) | BIT(EV_REP);
-			set_bit(KEY_SOUND, adbhid[id]->input.keybit);
-			set_bit(KEY_MUTE, adbhid[id]->input.keybit);
-			set_bit(KEY_VOLUMEUP, adbhid[id]->input.keybit);
-			set_bit(KEY_VOLUMEDOWN, adbhid[id]->input.keybit);
+			sprintf(hid->name, "ADB adjustable keyboard buttons");
+			input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_REP);
+			set_bit(KEY_SOUND, input_dev->keybit);
+			set_bit(KEY_MUTE, input_dev->keybit);
+			set_bit(KEY_VOLUMEUP, input_dev->keybit);
+			set_bit(KEY_VOLUMEDOWN, input_dev->keybit);
 			break;
 		case 0x1f: /* Powerbook button device */
-			sprintf(adbhid[id]->name, "ADB Powerbook buttons");
-			adbhid[id]->input.evbit[0] = BIT(EV_KEY) | BIT(EV_REP);
-			set_bit(KEY_MUTE, adbhid[id]->input.keybit);
-			set_bit(KEY_VOLUMEUP, adbhid[id]->input.keybit);
-			set_bit(KEY_VOLUMEDOWN, adbhid[id]->input.keybit);
-			set_bit(KEY_BRIGHTNESSUP, adbhid[id]->input.keybit);
-			set_bit(KEY_BRIGHTNESSDOWN, adbhid[id]->input.keybit);
-			set_bit(KEY_EJECTCD, adbhid[id]->input.keybit);
-			set_bit(KEY_SWITCHVIDEOMODE, adbhid[id]->input.keybit);
-			set_bit(KEY_KBDILLUMTOGGLE, adbhid[id]->input.keybit);
-			set_bit(KEY_KBDILLUMDOWN, adbhid[id]->input.keybit);
-			set_bit(KEY_KBDILLUMUP, adbhid[id]->input.keybit);
+			sprintf(hid->name, "ADB Powerbook buttons");
+			input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_REP);
+			set_bit(KEY_MUTE, input_dev->keybit);
+			set_bit(KEY_VOLUMEUP, input_dev->keybit);
+			set_bit(KEY_VOLUMEDOWN, input_dev->keybit);
+			set_bit(KEY_BRIGHTNESSUP, input_dev->keybit);
+			set_bit(KEY_BRIGHTNESSDOWN, input_dev->keybit);
+			set_bit(KEY_EJECTCD, input_dev->keybit);
+			set_bit(KEY_SWITCHVIDEOMODE, input_dev->keybit);
+			set_bit(KEY_KBDILLUMTOGGLE, input_dev->keybit);
+			set_bit(KEY_KBDILLUMDOWN, input_dev->keybit);
+			set_bit(KEY_KBDILLUMUP, input_dev->keybit);
 			break;
 		}
-		if (adbhid[id]->name[0])
+		if (hid->name[0])
 			break;
 		/* else fall through */
 
 	default:
 		printk(KERN_INFO "Trying to register unknown ADB device to input layer.\n");
-		kfree(adbhid[id]);
-		return;
+		err = -ENODEV;
+		goto fail;
 	}
 
-	adbhid[id]->input.keycode = adbhid[id]->keycode;
-
-	input_register_device(&adbhid[id]->input);
+	input_dev->keycode = hid->keycode;
 
-	printk(KERN_INFO "input: %s on %s\n",
-	       adbhid[id]->name, adbhid[id]->phys);
+	input_register_device(input_dev);
 
 	if (default_id == ADB_KEYBOARD) {
 		/* HACK WARNING!! This should go away as soon there is an utility
 		 * to control that for event devices.
 		 */
-		adbhid[id]->input.rep[REP_DELAY] = 500;   /* input layer default: 250 */
-		adbhid[id]->input.rep[REP_PERIOD] = 66; /* input layer default: 33 */
+		input_dev->rep[REP_DELAY] = 500;   /* input layer default: 250 */
+		input_dev->rep[REP_PERIOD] = 66; /* input layer default: 33 */
 	}
+
+	return 0;
+
+ fail:	input_free_device(input_dev);
+	kfree(hid);
+	adbhid[id] = NULL;
+	return err;
 }
 
 static void adbhid_input_unregister(int id)
 {
-	input_unregister_device(&adbhid[id]->input);
+	input_unregister_device(adbhid[id]->input);
 	if (adbhid[id]->keycode)
 		kfree(adbhid[id]->keycode);
 	kfree(adbhid[id]);
@@ -858,7 +868,7 @@ adbhid_input_reregister(int id, int defa
 			int cur_handler_id, int mk)
 {
 	if (adbhid[id]) {
-		if (adbhid[id]->input.id.product !=
+		if (adbhid[id]->input->id.product !=
 		    ((id << 12)|(default_id << 8)|org_handler_id)) {
 			adbhid_input_unregister(id);
 			adbhid_input_register(id, default_id, org_handler_id,
Index: work/drivers/macintosh/mac_hid.c
===================================================================
--- work.orig/drivers/macintosh/mac_hid.c
+++ work/drivers/macintosh/mac_hid.c
@@ -16,8 +16,8 @@
 #include <linux/module.h>
 
 
-static struct input_dev emumousebtn;
-static void emumousebtn_input_register(void);
+static struct input_dev *emumousebtn;
+static int emumousebtn_input_register(void);
 static int mouse_emulate_buttons = 0;
 static int mouse_button2_keycode = KEY_RIGHTCTRL;	/* right control key */
 static int mouse_button3_keycode = KEY_RIGHTALT;	/* right option key */
@@ -90,10 +90,10 @@ int mac_hid_mouse_emulate_buttons(int ca
 		    && (keycode == mouse_button2_keycode
 			|| keycode == mouse_button3_keycode)) {
 			if (mouse_emulate_buttons == 1) {
-			 	input_report_key(&emumousebtn,
+				input_report_key(emumousebtn,
 						 keycode == mouse_button2_keycode ? BTN_MIDDLE : BTN_RIGHT,
 						 down);
-				input_sync(&emumousebtn);
+				input_sync(emumousebtn);
 				return 1;
 			}
 			mouse_last_keycode = down ? keycode : 0;
@@ -105,30 +105,34 @@ int mac_hid_mouse_emulate_buttons(int ca
 
 EXPORT_SYMBOL(mac_hid_mouse_emulate_buttons);
 
-static void emumousebtn_input_register(void)
+static int emumousebtn_input_register(void)
 {
-	emumousebtn.name = "Macintosh mouse button emulation";
+	emumousebtn = input_allocate_device();
+	if (!emumousebtn)
+		return -ENOMEM;
+
+	emumousebtn->name = "Macintosh mouse button emulation";
+	emumousebtn->id.bustype = BUS_ADB;
+	emumousebtn->id.vendor = 0x0001;
+	emumousebtn->id.product = 0x0001;
+	emumousebtn->id.version = 0x0100;
+
+	emumousebtn->evbit[0] = BIT(EV_KEY) | BIT(EV_REL);
+	emumousebtn->keybit[LONG(BTN_MOUSE)] = BIT(BTN_LEFT) | BIT(BTN_MIDDLE) | BIT(BTN_RIGHT);
+	emumousebtn->relbit[0] = BIT(REL_X) | BIT(REL_Y);
 
-	init_input_dev(&emumousebtn);
+	input_register_device(emumousebtn);
 
-	emumousebtn.evbit[0] = BIT(EV_KEY) | BIT(EV_REL);
-	emumousebtn.keybit[LONG(BTN_MOUSE)] = BIT(BTN_LEFT) | BIT(BTN_MIDDLE) | BIT(BTN_RIGHT);
-	emumousebtn.relbit[0] = BIT(REL_X) | BIT(REL_Y);
-
-	emumousebtn.id.bustype = BUS_ADB;
-	emumousebtn.id.vendor = 0x0001;
-	emumousebtn.id.product = 0x0001;
-	emumousebtn.id.version = 0x0100;
-
-	input_register_device(&emumousebtn);
-
-	printk(KERN_INFO "input: Macintosh mouse button emulation\n");
+	return 0;
 }
 
 int __init mac_hid_init(void)
 {
+	int err;
 
-	emumousebtn_input_register();
+	err = emumousebtn_input_register();
+	if (err)
+		return err;
 
 #if defined(CONFIG_SYSCTL)
 	mac_hid_sysctl_header = register_sysctl_table(mac_hid_root_dir, 1);

