Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750940AbVLYVUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbVLYVUu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 16:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbVLYVUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 16:20:49 -0500
Received: from hansmi.home.forkbomb.ch ([213.144.146.165]:49692 "EHLO
	hansmi.home.forkbomb.ch") by vger.kernel.org with ESMTP
	id S1750939AbVLYVUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 16:20:49 -0500
Date: Sun, 25 Dec 2005 22:20:41 +0100
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: linux-kernel@vger.kernel.org
Cc: linux-input@atrey.karlin.mff.cuni.cz, linuxppc-dev@ozlabs.org,
       benh@kernel.crashing.org, linux-kernel@killerfox.forkbomb.ch
Subject: [PATCH/RFC?] usb/input: Add support for fn key on Apple PowerBooks
Message-ID: <20051225212041.GA6094@hansmi.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a basic input hook support to usbhid because the quirks
method is outrunning the available bits. A hook for the Fn and Numlock
keys on Apple PowerBooks is included.

Signed-off-by: Michael Hanselmann <linux-kernel@hansmi.ch>
Acked-by: Rene Nussbaumer <linux-kernel@killerfox.forkbomb.ch>
Acked-by: Johannes Berg <johannes@sipsolutions.net>

---
diff -rNup linux-2.6.15-rc6.orig/drivers/usb/input/Kconfig linux-2.6.15-rc6/drivers/usb/input/Kconfig
--- linux-2.6.15-rc6.orig/drivers/usb/input/Kconfig	2005-12-22 20:51:57.000000000 +0100
+++ linux-2.6.15-rc6/drivers/usb/input/Kconfig	2005-12-22 22:01:09.000000000 +0100
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
diff -rNup linux-2.6.15-rc6.orig/drivers/usb/input/Makefile linux-2.6.15-rc6/drivers/usb/input/Makefile
--- linux-2.6.15-rc6.orig/drivers/usb/input/Makefile	2005-12-22 20:51:57.000000000 +0100
+++ linux-2.6.15-rc6/drivers/usb/input/Makefile	2005-12-22 23:16:54.000000000 +0100
@@ -25,6 +25,9 @@ endif
 ifeq ($(CONFIG_HID_FF),y)
 	usbhid-objs	+= hid-ff.o
 endif
+ifeq ($(CONFIG_USB_HIDINPUT_POWERBOOK),y)
+   usbhid-objs += hid-input-powerbook.o
+endif
 
 obj-$(CONFIG_USB_AIPTEK)	+= aiptek.o
 obj-$(CONFIG_USB_ATI_REMOTE)	+= ati_remote.o
diff -rNup linux-2.6.15-rc6.orig/drivers/usb/input/hid-input-powerbook.c linux-2.6.15-rc6/drivers/usb/input/hid-input-powerbook.c
--- linux-2.6.15-rc6.orig/drivers/usb/input/hid-input-powerbook.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.15-rc6/drivers/usb/input/hid-input-powerbook.c	2005-12-25 21:23:04.000000000 +0100
@@ -0,0 +1,226 @@
+/*
+ * Mapping for special keys on Apple iBook and PowerBook keyboards
+ *
+ * Copyright (C) 2005 Michael Hanselmann (linux-kernel@hansmi.ch)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ *
+ */
+
+#include <linux/input.h>
+#include <linux/usb.h>
+
+#include "hid.h"
+
+#define map_key(c)	do { usage->code = c; usage->type = EV_KEY; bit = input->keybit; max = KEY_MAX; } while (0)
+#define map_key_clear(c)	do { map_key(c); clear_bit(c, bit); } while (0)
+
+#define APPLE_VENDOR_ID	0x05AC
+#define PB_ENABLED_FN	0x0001
+#define PB_FLAG_FKEY	0x0001
+
+static struct hid_input_hook_device input_pb_devices[] = {
+	{ APPLE_VENDOR_ID, 0x020E },
+	{ APPLE_VENDOR_ID, 0x020F },
+	{ APPLE_VENDOR_ID, 0x0214 },
+	{ APPLE_VENDOR_ID, 0x0215 },
+	{ APPLE_VENDOR_ID, 0x0216 },
+	{ }
+};
+
+struct input_pb_data {
+	u8 enabled_keys;
+};
+
+struct input_pb_translation {
+	u16 from;
+	u16 to;
+	u8 flags;
+};
+
+static struct input_pb_translation fn_keys[] = {
+	{ KEY_BACKSPACE, KEY_DELETE },
+	{ KEY_F1,	KEY_BRIGHTNESSDOWN,	PB_FLAG_FKEY },
+	{ KEY_F2,	KEY_BRIGHTNESSUP,	PB_FLAG_FKEY },
+	{ KEY_F3,	KEY_MUTE,		PB_FLAG_FKEY },
+	{ KEY_F4,	KEY_VOLUMEDOWN, 	PB_FLAG_FKEY },
+	{ KEY_F5,	KEY_VOLUMEUP,		PB_FLAG_FKEY },
+	{ KEY_F6,	KEY_NUMLOCK,		PB_FLAG_FKEY },
+	{ KEY_F7,	KEY_SWITCHVIDEOMODE,	PB_FLAG_FKEY },
+	{ KEY_F8,	KEY_KBDILLUMTOGGLE,	PB_FLAG_FKEY },
+	{ KEY_F9,	KEY_KBDILLUMDOWN,	PB_FLAG_FKEY },
+	{ KEY_F10,	KEY_KBDILLUMUP,		PB_FLAG_FKEY },
+	{ KEY_UP,	KEY_PAGEUP },
+	{ KEY_DOWN,	KEY_PAGEDOWN },
+	{ KEY_LEFT,	KEY_HOME },
+	{ KEY_RIGHT,	KEY_END },
+	{ }
+};
+
+static struct input_pb_translation numlock_keys[] = {
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
+static int fkeysfirst = 1;
+module_param_named(pb_fkeysfirst, fkeysfirst, bool, 0644);
+MODULE_PARM_DESC(fkeysfirst, "Use fn special keys only while pressing fn");
+
+static int enablefnkeys = 1;
+module_param_named(pb_enablefnkeys, enablefnkeys, bool, 0644);
+MODULE_PARM_DESC(enablefnkeys, "Enable fn special keys");
+
+static int enablekeypad = 1;
+module_param_named(pb_enablekeypad, enablekeypad, bool, 0644);
+MODULE_PARM_DESC(enablekeypad, "Enable keypad keys");
+
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
+static int input_pb_init(struct hid_device* hid)
+{
+	hid->hook_private = kzalloc(sizeof(struct input_pb_data), GFP_KERNEL);
+
+	if (!hid->hook_private)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void input_pb_exit(struct hid_device* hid)
+{
+	kfree(hid->hook_private);
+
+	return;
+}
+
+static int input_pb_event(struct hid_device *hid, struct hid_field *field,
+			  struct hid_usage *usage, __s32 value, struct pt_regs *regs)
+{
+	struct input_pb_data *private = hid->hook_private;
+	struct input_dev *input;
+	struct input_pb_translation *trans;
+
+	if (usage->type != EV_KEY)
+		return -1;
+
+	input = field->hidinput->input;
+
+	switch(usage->code) {
+	case KEY_FN:
+		if (value) private->enabled_keys |= PB_ENABLED_FN;
+		else	   private->enabled_keys &= ~PB_ENABLED_FN;
+
+		input_event(input, usage->type, usage->code, value);
+
+		return 0;
+	}
+
+	if (enablefnkeys) {
+		trans = find_translation(fn_keys, usage->code);
+
+		if (trans) {
+			int known_key;
+
+			if (trans->flags & PB_FLAG_FKEY)
+				known_key =
+					( fkeysfirst &&  (private->enabled_keys & PB_ENABLED_FN)) ||
+					(!fkeysfirst && !(private->enabled_keys & PB_ENABLED_FN));
+			else
+				known_key = (private->enabled_keys & PB_ENABLED_FN);
+
+			if (known_key) {
+				input_event(input, usage->type, trans->to, value);
+				return 0;
+			}
+		}
+	}
+
+	if (enablekeypad && test_bit(LED_NUML, input->led)) {
+		trans = find_translation(numlock_keys, usage->code);
+		if (trans)
+			input_event(input, usage->type, trans->to, value);
+
+		return 0;
+	}
+
+	return -1;
+}
+
+static int input_pb_conf(struct hid_input *hidinput, struct hid_field *field,
+			 struct hid_usage *usage)
+{
+	struct input_dev *input = hidinput->input;
+	struct input_pb_translation *trans;
+	int max = 0;
+	unsigned long *bit = NULL;
+
+	field->hidinput = hidinput;
+
+	switch (usage->hid & HID_USAGE_PAGE) {
+	case HID_UP_CUSTOM:
+		switch(usage->hid & HID_USAGE) {
+		/* The fn key on Apple PowerBooks */
+		case 0x003:
+			map_key_clear(KEY_FN);
+
+			set_bit(KEY_FN, input->keybit);
+			set_bit(KEY_NUMLOCK, input->keybit);
+
+			/* Enable all needed keys */
+			for(trans = fn_keys; trans->from; trans++)
+				set_bit(trans->to, input->keybit);
+
+			for(trans = numlock_keys; trans->from; trans++)
+				set_bit(trans->to, input->keybit);
+
+			return 0;
+		}
+	}
+
+	return -1;
+}
+
+struct hid_input_hook usbhid_input_powerbook = {
+	.devices = input_pb_devices,
+	.init = input_pb_init,
+	.conf = input_pb_conf,
+	.event = input_pb_event,
+	.exit = input_pb_exit,
+};
diff -rNup linux-2.6.15-rc6.orig/drivers/usb/input/hid-input.c linux-2.6.15-rc6/drivers/usb/input/hid-input.c
--- linux-2.6.15-rc6.orig/drivers/usb/input/hid-input.c	2005-12-22 20:51:57.000000000 +0100
+++ linux-2.6.15-rc6/drivers/usb/input/hid-input.c	2005-12-25 21:48:09.000000000 +0100
@@ -63,6 +63,16 @@ static struct {
 	__s32 y;
 }  hid_hat_to_axis[] = {{ 0, 0}, { 0,-1}, { 1,-1}, { 1, 0}, { 1, 1}, { 0, 1}, {-1, 1}, {-1, 0}, {-1,-1}};
 
+/*
+ * This table contains pointers to hook structures.
+ */
+static struct hid_input_hook* hooks[] = {
+#ifdef CONFIG_USB_HIDINPUT_POWERBOOK
+	&usbhid_input_powerbook,
+#endif
+	NULL /* Terminating entry */
+};
+
 #define map_abs(c)	do { usage->code = c; usage->type = EV_ABS; bit = input->absbit; max = ABS_MAX; } while (0)
 #define map_rel(c)	do { usage->code = c; usage->type = EV_REL; bit = input->relbit; max = REL_MAX; } while (0)
 #define map_key(c)	do { usage->code = c; usage->type = EV_KEY; bit = input->keybit; max = KEY_MAX; } while (0)
@@ -73,6 +83,33 @@ static struct {
 #define map_key_clear(c)	do { map_key(c); clear_bit(c, bit); } while (0)
 #define map_ff_effect(c)	do { set_bit(c, input->ffbit); } while (0)
 
+static int hidinput_hook_wants_device(struct hid_input_hook *hook, u16 idVendor, u16 idProduct)
+{
+	struct hid_input_hook_device *curdev;
+
+	if (!hook->devices)
+		return 0;
+
+	/* Try to find device */
+	for (curdev = hook->devices;                                 
+	     curdev->idVendor && !(curdev->idVendor == idVendor && curdev->idProduct == idProduct);
+	     curdev++);
+
+	return !!curdev->idVendor;
+}
+
+static struct hid_input_hook *hid_input_get_hook(u16 idVendor, u16 idProduct)
+{
+	struct hid_input_hook **hook;
+
+	for (hook = hooks;
+	     *hook && !hidinput_hook_wants_device(*hook, idVendor, idProduct);
+	     hook++);
+
+	return *hook;
+}
+
+
 static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_field *field,
 				     struct hid_usage *usage)
 {
@@ -92,6 +129,12 @@ static void hidinput_configure_usage(str
 	if (field->flags & HID_MAIN_ITEM_CONSTANT)
 		goto ignore;
 
+	if(field->hidinput->hook) {
+		struct hid_input_hook *hook = field->hidinput->hook;
+		if(hook->conf && hook->conf(hidinput, field, usage) == 0)
+			return;
+	}
+
 	switch (usage->hid & HID_USAGE_PAGE) {
 
 		case HID_UP_UNDEFINED:
@@ -325,7 +368,6 @@ static void hidinput_configure_usage(str
 
 			set_bit(EV_REP, input->evbit);
 			switch(usage->hid & HID_USAGE) {
-				case 0x003: map_key_clear(KEY_FN);		break;
 				default:    goto ignore;
 			}
 			break;
@@ -470,6 +512,12 @@ void hidinput_hid_event(struct hid_devic
 	if (!usage->type)
 		return;
 
+	if(field->hidinput->hook) {
+		struct hid_input_hook *hook = field->hidinput->hook;
+		if(hook->event && hook->event(hid, field, usage, value, regs) == 0)
+			return;
+	}
+
 	if (((hid->quirks & HID_QUIRK_2WHEEL_MOUSE_HACK_5) && (usage->hid == 0x00090005))
 		|| ((hid->quirks & HID_QUIRK_2WHEEL_MOUSE_HACK_7) && (usage->hid == 0x00090007))) {
 		if (value) hid->quirks |=  HID_QUIRK_2WHEEL_MOUSE_HACK_ON;
@@ -648,6 +696,17 @@ int hidinput_connect(struct hid_device *
 				list_add_tail(&hidinput->list, &hid->inputs);
 			}
 
+			hidinput->hook = hid_input_get_hook(
+				le16_to_cpu(hid->dev->descriptor.idVendor),
+				le16_to_cpu(hid->dev->descriptor.idProduct));
+
+			if(hidinput->hook &&
+			   hidinput->hook->init &&
+			   hidinput->hook->init(hid) < 0) {
+				printk(KERN_ERR "input: Hook initialization failed.\n");
+				hidinput->hook = NULL;
+			}
+
 			for (i = 0; i < report->maxfield; i++)
 				for (j = 0; j < report->field[i]->maxusage; j++)
 					hidinput_configure_usage(hidinput, report->field[i],
@@ -681,6 +740,8 @@ void hidinput_disconnect(struct hid_devi
 	struct hid_input *hidinput, *next;
 
 	list_for_each_entry_safe(hidinput, next, &hid->inputs, list) {
+		if(hidinput->hook && hidinput->hook->exit)
+			hidinput->hook->exit(hid);
 		list_del(&hidinput->list);
 		input_unregister_device(hidinput->input);
 		kfree(hidinput);
diff -rNup linux-2.6.15-rc6.orig/drivers/usb/input/hid.h linux-2.6.15-rc6/drivers/usb/input/hid.h
--- linux-2.6.15-rc6.orig/drivers/usb/input/hid.h	2005-12-22 20:51:57.000000000 +0100
+++ linux-2.6.15-rc6/drivers/usb/input/hid.h	2005-12-25 21:50:33.000000000 +0100
@@ -368,10 +368,33 @@ struct hid_control_fifo {
 #define HID_CTRL_RUNNING	1
 #define HID_OUT_RUNNING		2
 
+struct hid_input_hook_device {
+	u16 idVendor;
+	u16 idProduct;
+};
+
+struct hid_input_hook {
+	struct list_head list;
+	struct hid_input_hook_device *devices;
+
+	int (*init)(struct hid_device*);
+	void (*exit)(struct hid_device*);
+	int (*event)(struct hid_device *hid, struct hid_field *field,
+		     struct hid_usage *usage, __s32 value, struct pt_regs *regs);
+	int (*conf)(struct hid_input *hidinput, struct hid_field *field,
+		    struct hid_usage *usage);
+};
+
+#ifdef CONFIG_USB_HIDINPUT_POWERBOOK
+extern struct hid_input_hook usbhid_input_powerbook;
+#endif
+
 struct hid_input {
 	struct list_head list;
 	struct hid_report *report;
 	struct input_dev *input;
+
+	struct hid_input_hook *hook;
 };
 
 struct hid_device {							/* device report descriptor */
@@ -431,6 +454,8 @@ struct hid_device {							/* device repo
 	void (*ff_exit)(struct hid_device*);                            /* Called by hid_exit_ff(hid) */
 	int (*ff_event)(struct hid_device *hid, struct input_dev *input,
 			unsigned int type, unsigned int code, int value);
+
+	void *hook_private;
 };
 
 #define HID_GLOBAL_STACK_SIZE 4
