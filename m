Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932520AbWGZKma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932520AbWGZKma (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 06:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932521AbWGZKma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 06:42:30 -0400
Received: from [210.76.114.181] ([210.76.114.181]:15798 "EHLO ccoss.com.cn")
	by vger.kernel.org with ESMTP id S932520AbWGZKm2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 06:42:28 -0400
Message-ID: <44C74708.6090907@ccoss.com.cn>
Date: Wed, 26 Jul 2006 18:42:16 +0800
From: liyu <liyu@ccoss.com.cn>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Peter <peter@maubp.freeserve.co.uk>,
       The Doctor <thedoctor@tardis.homelinux.org>
Subject: [PATCH 1/3] usbhid: Driver for microsoft natural ergonomic keyboard
 4000
Content-Type: multipart/mixed;
 boundary="------------050405020703020205000209"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050405020703020205000209
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


    This driver use "HID device simple driver interface", you must
install that patch first. This new version get some improvements.

    The patch is core of driver.

    I am sorry for sendding patches in the attachment, beacause of my mail client always break TAB into some spaces.

    Good luck

-Liyu


--------------050405020703020205000209
Content-Type: text/x-patch;
 name="msnek4k-keyboard-driver.kernel-2.6.17.7.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="msnek4k-keyboard-driver.kernel-2.6.17.7.patch"

    First, this driver use "HID device simple driver interface", you must 
apply that patch before use me.

    As Greg KH words, I split this driver into some more littler patches, and
break some long line in source.

    This new version get some improvements:
   
    1. These five "My Favorites" keys map FN_F{1,2,3,4,5}_KEY directly,
instead of map them to KEY_VENDOR hacking means.

    2. Support left paren key "(", right paren key ")", equal key "=" on
right-top keypad. In fact, this keyboard generate KEYPAD_XXX usage code
for them, but I find many applications can not handle them on default
configuration, especially X.org. To get the most best usability, I use a
bit magic here: map them to "Shift+9" and "Shift+0".

    This patch is main part of driver.

    First, this driver use "HID device simple driver interface", you must apply that patch before use me.

    Signed-off-by:  Yu Li <liyu@ccoss.com.cn>

diff -Naurp linux-2.6.17.6/drivers/usb/input.orig/usbnek4k.c linux-2.6.17.6/drivers/usb/input/usbnek4k.c
--- linux-2.6.17.6/drivers/usb/input.orig/usbnek4k.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.17.6/drivers/usb/input/usbnek4k.c	2006-07-26 09:42:01.000000000 +0800
@@ -0,0 +1,420 @@
+/*
+ *  Microsoft Natural Ergonomic Keyboard 4000 Driver
+ *
+ *  Version:	0.2.0
+ *
+ *  TODO:	
+ *	Refactoring to escape from switch {case ...} hell.
+ *
+ *  Copyright (c) 2006 Liyu <liyu@ccoss.com.cn> 	
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/input.h>
+#include "hid.h"
+#include "hid-simple.h"
+
+#define map_key(c) \
+	do { \
+		usage->code = c; \
+		usage->type = EV_KEY; \
+		set_bit(c,input->keybit); \
+	} while (0)
+
+#define clear_key(c) \
+	do { \
+		usage->code = 0; \
+		usage->type = 0; \
+		clear_bit(c,input->keybit); \
+	} while (0)
+
+#define clear_usage(c)	\
+	do { \
+		usage->code = 0; \
+		usage->type = 0; \
+	} while (0)
+
+#define LEFTP_PRESSED	0x1
+#define RIGHTP_PRESSED	0x2
+#define KPP_PRESSED_MASK	(LEFTP_PRESSED|RIGHTP_PRESSED)
+
+#define set_leftp_pressed(hiddev) \
+	set_bit(LEFTP_PRESSED, (unsigned long*)(&hiddev->simple->private))
+#define set_rightp_pressed(hiddev) \
+	set_bit(RIGHTP_PRESSED, (unsigned long*)(&hiddev->simple->private))
+#define clear_leftp_pressed(hiddev) \
+	clear_bit(LEFTP_PRESSED, (unsigned long*)(&hiddev->simple->private))
+#define clear_rightp_pressed(hiddev) \
+	clear_bit(RIGHTP_PRESSED, (unsigned long*)(&hiddev->simple->private))
+
+#define is_kpp_pressed(hiddev) \
+	((unsigned long)(hiddev->simple->private) & KPP_PRESSED_MASK)
+#define is_leftp_pressed(hiddev) \
+	((unsigned long)(hiddev->simple->private) & LEFTP_PRESSED)
+#define is_rightp_pressed(hiddev) \
+	((unsigned long)(hiddev->simple->private) & RIGHTP_PRESSED)
+
+
+
+#define USAGE_ZOOM_IN 0x22d
+#define USAGE_ZOOM_OUT 0x22e
+#define USAGE_HOME	0x223
+#define USAGE_SEARCH	0x221
+#define USAGE_EMAIL	0x18a
+#define USAGE_FAVORITES	0x182
+#define USAGE_MUTE	0xe2
+#define USAGE_VOLUME_DOWN	0xea
+#define USAGE_VOLUME_UP	0xe9
+#define USAGE_PLAY_PAUSE	0xcd
+#define USAGE_CALCULATOR	0x192
+#define USAGE_BACK	0x224
+#define USAGE_FORWARD	0x225
+#define USAGE_CUSTOM	0xff05
+
+#define USAGE_CUSTEM_1	0x1
+#define USAGE_CUSTEM_2	0x2
+#define USAGE_CUSTEM_3	0x4
+#define USAGE_CUSTEM_4	0x8
+#define USAGE_CUSTEM_5	0x10
+
+#define USAGE_HELP	0x95
+#define USAGE_UNDO	0x21a
+#define USAGE_REDO	0x279
+#define USAGE_NEW	0x201
+#define USAGE_OPEN	0x202
+#define USAGE_CLOSE	0x203
+
+#define USAGE_REPLY	0x289
+#define USAGE_FWD	0x28b
+#define USAGE_SEND	0x28c
+#define USAGE_SPELL	0x1ab
+#define USAGE_SAVE	0x207
+#define USAGE_PRINT	0x208
+
+#define USAGE_KEYPAD_EQUAL 0x67
+#define USAGE_KEYPAD_LEFT_PARENTHESES 0xb6
+#define USAGE_KEYPAD_RIGHT_PARENTHESES 0xb7
+
+
+#define MSNEK4K_ID_VENDOR	0x045e
+#define MSNEK4K_ID_PRODUCT	0x00db
+
+
+static struct usb_device_id __id[] = {
+	{
+		USB_DEVICE(MSNEK4K_ID_VENDOR, MSNEK4K_ID_PRODUCT)
+	},
+	{0, }
+};
+
+MODULE_DEVICE_TABLE(usb, __id);
+
+static char driver_name[] = "Microsoft Natural Ergonomic Keyboard 4000";
+
+static void nek4k_setup_usage(struct hid_field *field,	struct hid_usage *usage)
+{	
+	struct hid_input *hidinput = field->hidinput;
+	struct input_dev *input = hidinput->input;
+
+	if ((usage->hid & HID_USAGE_PAGE) == HID_UP_CONSUMER) {
+		switch (usage->hid & HID_USAGE) {
+			case USAGE_ZOOM_IN:
+				map_key(KEY_F13);break;
+			case USAGE_ZOOM_OUT:
+				map_key(KEY_F14);break;
+			case USAGE_HOME:
+				map_key(KEY_HOMEPAGE);break;
+			case USAGE_SEARCH:
+				map_key(KEY_SEARCH);break;
+			case USAGE_EMAIL:
+				map_key(KEY_EMAIL);break;
+			case USAGE_FAVORITES:
+				map_key(KEY_FAVORITES);break;
+			case USAGE_MUTE:
+				map_key(KEY_MUTE);break;
+			case USAGE_VOLUME_DOWN:
+				map_key(KEY_VOLUMEDOWN);break;
+			case USAGE_VOLUME_UP:
+				map_key(KEY_VOLUMEUP);	break;
+			case USAGE_PLAY_PAUSE:
+				map_key(KEY_PLAYPAUSE);break;
+			case USAGE_CALCULATOR:
+				map_key(KEY_CALC);break;
+			case USAGE_BACK:
+				map_key(KEY_BACK);break;
+			case USAGE_FORWARD:
+				map_key(KEY_FORWARD);break;
+			case USAGE_HELP:
+				map_key(KEY_HELP);break;
+			case USAGE_UNDO:
+				map_key(KEY_UNDO);break;
+			case USAGE_REDO:
+				map_key(KEY_REDO);break;
+			case USAGE_NEW:
+				map_key(KEY_NEW);break;
+			case USAGE_OPEN:
+				map_key(KEY_OPEN);break;
+			case USAGE_CLOSE:
+				map_key(KEY_CLOSE);break;
+			case USAGE_REPLY:
+				map_key(KEY_REPLY);break;
+			case USAGE_FWD:
+				map_key(KEY_FORWARDMAIL);break;
+			case USAGE_SEND:
+				map_key(KEY_SEND);break;
+			case USAGE_SPELL:
+				map_key(KEY_F13);break;
+			case USAGE_SAVE:
+				map_key(KEY_SAVE);break;
+			case USAGE_PRINT:
+				map_key(KEY_PRINT);break;
+			default:	
+				return;
+		}
+	} else if ((usage->hid & HID_USAGE_PAGE) == HID_UP_MSVENDOR) {
+		if ((usage->hid & HID_USAGE) == USAGE_CUSTOM) {
+			map_key(KEY_FN_F1);
+			map_key(KEY_FN_F2);
+			map_key(KEY_FN_F3);
+			map_key(KEY_FN_F4);
+			map_key(KEY_FN_F5);
+		}
+	} else if ((usage->hid & HID_USAGE_PAGE) == HID_UP_KEYBOARD) {
+		switch (usage->hid & HID_USAGE) {
+			case USAGE_KEYPAD_EQUAL:
+				map_key(KEY_EQUAL);
+				break;
+			case USAGE_KEYPAD_LEFT_PARENTHESES:
+				map_key(KEY_9);
+				break;
+			case USAGE_KEYPAD_RIGHT_PARENTHESES:
+				map_key(KEY_0);
+				break;
+			default:
+				return;
+		}
+	}
+	else if ((usage->hid & HID_USAGE_PAGE) == HID_UP_LED)
+		return;
+	else
+		printk(KERN_WARNING"Unknown usage page 0x%x in %s:%d\n",
+			usage->hid & HID_USAGE_PAGE, __FUNCTION__, __LINE__);
+	return;
+}
+
+static void nek4k_clear_usage(struct hid_field *field,	struct hid_usage *usage)
+{
+	struct hid_input *hidinput = field->hidinput;
+	struct input_dev *input = hidinput->input;
+
+	if ((usage->hid & HID_USAGE_PAGE) == HID_UP_CONSUMER) {
+		switch (usage->hid & HID_USAGE) {
+			case USAGE_ZOOM_IN:
+				clear_key(KEY_F13);break;
+			case USAGE_ZOOM_OUT:
+				clear_key(KEY_F14);break;
+			case USAGE_HOME:
+				clear_key(KEY_HOMEPAGE);break;
+			case USAGE_SEARCH:
+				clear_key(KEY_SEARCH);break;
+			case USAGE_EMAIL:
+				clear_key(KEY_EMAIL);break;
+			case USAGE_FAVORITES:
+				clear_key(KEY_FAVORITES);break;
+			case USAGE_MUTE:
+				clear_key(KEY_MUTE);break;
+			case USAGE_VOLUME_DOWN:
+				clear_key(KEY_VOLUMEDOWN);break;
+			case USAGE_VOLUME_UP:
+				clear_key(KEY_VOLUMEUP);	break;
+			case USAGE_PLAY_PAUSE:
+				clear_key(KEY_PLAYPAUSE);break;
+			case USAGE_CALCULATOR:
+				clear_key(KEY_CALC);break;
+			case USAGE_BACK:
+				clear_key(KEY_BACK);break;
+			case USAGE_FORWARD:
+				clear_key(KEY_FORWARD);break;
+			case USAGE_HELP:
+				clear_key(KEY_HELP);break;
+			case USAGE_UNDO:
+				clear_key(KEY_UNDO);break;
+			case USAGE_REDO:
+				clear_key(KEY_REDO);break;
+			case USAGE_NEW:
+				clear_key(KEY_NEW);break;
+			case USAGE_OPEN:
+				clear_key(KEY_OPEN);break;
+			case USAGE_CLOSE:
+				clear_key(KEY_CLOSE);break;
+			case USAGE_REPLY:
+				clear_key(KEY_REPLY);break;
+			case USAGE_FWD:
+				clear_key(KEY_FORWARDMAIL);break;
+			case USAGE_SEND:
+				clear_key(KEY_SEND);break;
+			case USAGE_SPELL:
+				clear_key(KEY_F13);break;
+			case USAGE_SAVE:
+				clear_key(KEY_SAVE);break;
+			case USAGE_PRINT:
+				clear_key(KEY_PRINT);break;
+			default:	
+				return;
+		}
+	} else if ((usage->hid & HID_USAGE_PAGE) == HID_UP_MSVENDOR) {
+		if ((usage->hid & HID_USAGE) == USAGE_CUSTOM) {
+			clear_bit(KEY_FN_F1,input->keybit);
+			clear_bit(KEY_FN_F2,input->keybit);
+			clear_bit(KEY_FN_F3,input->keybit);
+			clear_bit(KEY_FN_F4,input->keybit);
+			clear_bit(KEY_FN_F5,input->keybit);
+			return;
+		}
+	} else if ((usage->hid & HID_USAGE_PAGE) == HID_UP_KEYBOARD) {
+		clear_usage(USAGE_EQUAL);
+		return;
+	} else 
+		printk(KERN_ERR"Unknown usage page 0x%x in %s:%d\n",
+			usage->hid & HID_USAGE_PAGE, __FUNCTION__, __LINE__);
+
+}
+
+static int
+nek4k_hid_event(const struct hid_device *hid, const struct hid_field *field,
+			const struct hid_usage * usage, const __s32 value,
+						const struct pt_regs *regs)
+{
+	struct hid_input *hidinput = field->hidinput;
+	struct input_dev *input = hidinput->input;
+	int code=0;
+
+	if ( (usage->hid&HID_USAGE_PAGE)==HID_UP_MSVENDOR &&
+	     (usage->hid&HID_USAGE) == USAGE_CUSTOM ) {
+		switch (value) {
+			case 0x0:
+				input_event(input, EV_KEY, code, 0);
+				input_sync(input);
+				return 0;
+			case USAGE_CUSTEM_1:	
+				code = KEY_FN_F1;
+				break;
+			case USAGE_CUSTEM_2:
+				code = KEY_FN_F2;
+				break;
+			case USAGE_CUSTEM_3:
+				code = KEY_FN_F3;
+				break;
+			case USAGE_CUSTEM_4:
+				code = KEY_FN_F4;
+				break;
+			case USAGE_CUSTEM_5:
+				code = KEY_FN_F5;
+				break;
+			default:
+				return -EINVAL;
+		};
+		input_event(input, EV_KEY, code, 1);
+		input_sync(input);
+	}
+	else if ( (usage->hid&HID_USAGE_PAGE) == HID_UP_KEYBOARD ) {
+		if ((usage->hid&HID_USAGE) == USAGE_KEYPAD_LEFT_PARENTHESES)
+			code = KEY_9;
+		else if ((usage->hid&HID_USAGE) == USAGE_KEYPAD_RIGHT_PARENTHESES)
+			code = KEY_0;
+		else 
+			return -EINVAL;
+		if (1 == value) {
+			if (!is_kpp_pressed(hid)) {
+				input_event(input, EV_KEY, KEY_LEFTSHIFT, 1);
+				input_sync(hidinput->input);
+			}
+			input_event(input, EV_KEY, code, 1);
+			input_sync(hidinput->input);
+			if (KEY_9 == code)
+				set_leftp_pressed(hid);
+			else if (KEY_0 == code)
+				set_rightp_pressed(hid);
+		} else if (0 == value) {
+			input_event(input, EV_KEY, code, 0);
+			input_sync(hidinput->input);
+			if (KEY_9 == code)
+				clear_leftp_pressed(hid);
+			else if (KEY_0 == code) 
+				clear_rightp_pressed(hid);
+			if (!is_kpp_pressed(hid)) {
+				input_event(input, EV_KEY, KEY_LEFTSHIFT, 0);
+				input_sync(input);
+			}
+		}
+	}
+	return 0;
+}
+
+static void nek4k_disconnect(struct hid_device *hid, struct hid_input *hidinput)
+{
+	if (is_leftp_pressed(hid)) {
+		input_event(hidinput->input, EV_KEY, KEY_9, 0);
+		input_sync(hidinput->input);
+		input_event(hidinput->input, EV_KEY, KEY_LEFTSHIFT, 0);
+	}
+	if (is_rightp_pressed(hid)) {
+		input_event(hidinput->input, EV_KEY, KEY_0, 0);
+		input_sync(hidinput->input);
+		input_event(hidinput->input, EV_KEY, KEY_LEFTSHIFT, 0);
+	}
+	input_sync(hidinput->input);
+}
+
+static struct usb_device_id my_id_table[] = {
+	{ USB_DEVICE(MSNEK4K_ID_VENDOR, MSNEK4K_ID_PRODUCT) },
+	{}
+};
+
+static struct hidinput_simple_driver nek4k_driver = {
+	.name = driver_name,
+	.setup_usage = nek4k_setup_usage,
+	.clear_usage = nek4k_clear_usage,
+	.pre_event = nek4k_hid_event,
+	.disconnect = nek4k_disconnect,
+	.id_table = my_id_table,
+	.private = NULL
+};
+
+static int __init nek4k_init(void)
+{
+	int result;
+
+	result = hidinput_register_simple_driver(&nek4k_driver);
+	switch (result) {
+		case 0:
+			goto ok;
+		case -ENOMEM:
+		case -EBUSY:
+			goto ok;
+		case -EINVAL:
+			return result;
+		default:
+			return -ENODEV;
+	};
+
+	ok:
+	return 0;
+}
+
+static void __exit nek4k_exit(void)
+{
+	hidinput_unregister_simple_driver(&nek4k_driver);
+}
+
+module_init(nek4k_init);
+module_exit(nek4k_exit);
+
+MODULE_LICENSE("GPL");




--------------050405020703020205000209--
