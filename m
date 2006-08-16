Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750724AbWHPCJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWHPCJ6 (ORCPT <rfc822;akpm@zip.com.au>);
	Tue, 15 Aug 2006 22:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbWHPCJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 22:09:37 -0400
Received: from m5-82.163.com ([202.108.5.82]:32735 "HELO m5-82.163.com")
	by vger.kernel.org with SMTP id S1750724AbWHPCJf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 22:09:35 -0400
Date: Wed, 16 Aug 2006 10:09:15 +0800
From: "liyu" <raise_sail@163.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Cc: "Vojtech Pavlik" <vojtech@suse.cz>, "Greg" <greg@kroah.com>,
        "linux-usb-devel" <linux-usb-devel@lists.sourceforge.net>
Subject: [PATCH] usb: Microsoft Natural Ergonomic Keyboard 4000 Driver 0.3.1
X-mailer: Foxmail 5.0 [cn]
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
Message-Id: <44E27D29.04D613.25851>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Changelogs:

	1. some code style clean works.
	2. rebuild with The HID Simple Driver Interface 0.3.1

NOTE:	This driver requires:
	1.  [PATCH] usb: The HID Simple Driver Interface 0.3.1 (core)
	2.  [PATCH] usb: HID Simple Driver Interface 0.3.1 (Kconfig and Makefile)

It also can apply on 2.6.17.6 and 2.6.17.8 at least. 

PS: I have not Subscribe linux-usb-devel maillist, please CC me your reply, thanks. 
	
Signed-off-by: Liyu <raise.sail@gmail.com>

diff -Naurp linux-2.6.17.7/drivers/usb/input.orig/usbnek4k.c linux-2.6.17.7/drivers/usb/input/usbnek4k.c
--- linux-2.6.17.7/drivers/usb/input.orig/usbnek4k.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.17.7/drivers/usb/input/usbnek4k.c	2006-08-16 09:06:04.000000000 +0800
@@ -0,0 +1,194 @@
+/*
+ *  Microsoft Natural Ergonomic Keyboard 4000 Driver
+ *
+ *  Version:	0.3.1
+ *
+ *  Copyright (c) 2006 Liyu <raise.sail@gmail.com>
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
+#define USAGE_CUSTOM_RELEASE	0x0
+#define USAGE_CUSTOM_1	0x1
+#define USAGE_CUSTOM_2	0x2
+#define USAGE_CUSTOM_3	0x4
+#define USAGE_CUSTOM_4	0x8
+#define USAGE_CUSTOM_5	0x10
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
+#define USAGE_KEYPAD_LEFT_PAREN 0xb6
+#define USAGE_KEYPAD_RIGHT_PAREN 0xb7
+
+#define MSNEK4K_ID_VENDOR	0x045e
+#define MSNEK4K_ID_PRODUCT	0x00db
+
+static struct usb_device_id nek4k_id_table[] = {
+	{
+		USB_DEVICE(MSNEK4K_ID_VENDOR, MSNEK4K_ID_PRODUCT)
+	},
+	{}
+};
+
+MODULE_DEVICE_TABLE(usb, nek4k_id_table);
+
+static char driver_name[] = "Microsoft Natural Ergonomic Keyboard 4000";
+
+struct usage_block consumer_usage_block[] = {
+	USAGE_BLOCK(USAGE_ZOOM_IN, 0, EV_KEY, KEY_F13, 0),
+	USAGE_BLOCK(USAGE_ZOOM_OUT, 0, EV_KEY, KEY_F14, 0),
+	USAGE_BLOCK(USAGE_HOME, 0, EV_KEY, KEY_HOMEPAGE, 0),
+	USAGE_BLOCK(USAGE_SEARCH, 0, EV_KEY, KEY_SEARCH, 0),
+	USAGE_BLOCK(USAGE_EMAIL, 0, EV_KEY, KEY_EMAIL, 0),
+	USAGE_BLOCK(USAGE_FAVORITES, 0, EV_KEY, KEY_FAVORITES, 0),
+	USAGE_BLOCK(USAGE_MUTE, 0, EV_KEY, KEY_MUTE, 0),
+	USAGE_BLOCK(USAGE_VOLUME_DOWN, 0, EV_KEY, KEY_VOLUMEDOWN, 0),
+	USAGE_BLOCK(USAGE_VOLUME_UP, 0, EV_KEY, KEY_VOLUMEUP, 0),
+	USAGE_BLOCK(USAGE_PLAY_PAUSE, 0, EV_KEY, KEY_PLAYPAUSE, 0),
+	USAGE_BLOCK(USAGE_CALCULATOR, 0, EV_KEY, KEY_CALC, 0),
+	USAGE_BLOCK(USAGE_BACK, 0, EV_KEY, KEY_BACK, 0),
+	USAGE_BLOCK(USAGE_FORWARD, 0, EV_KEY, KEY_FORWARD, 0),
+	USAGE_BLOCK(USAGE_HELP, 0, EV_KEY, KEY_HELP, 0),
+	USAGE_BLOCK(USAGE_UNDO, 0, EV_KEY, KEY_UNDO, 0),
+	USAGE_BLOCK(USAGE_REDO, 0, EV_KEY, KEY_REDO, 0),
+	USAGE_BLOCK(USAGE_NEW, 0, EV_KEY, KEY_NEW, 0),
+	USAGE_BLOCK(USAGE_OPEN, 0, EV_KEY, KEY_OPEN, 0),
+	USAGE_BLOCK(USAGE_CLOSE, 0, EV_KEY, KEY_CLOSE, 0),
+	USAGE_BLOCK(USAGE_REPLY, 0, EV_KEY, KEY_REPLY, 0),
+	USAGE_BLOCK(USAGE_FWD, 0, EV_KEY, KEY_FORWARDMAIL, 0),
+	USAGE_BLOCK(USAGE_SEND, 0, EV_KEY, KEY_SEND, 0),
+	USAGE_BLOCK(USAGE_SPELL, 0, EV_KEY, KEY_F15, 0),
+	USAGE_BLOCK(USAGE_SAVE, 0, EV_KEY, KEY_SAVE, 0),
+	USAGE_BLOCK(USAGE_PRINT, 0, EV_KEY, KEY_PRINT, 0),
+	USAGE_BLOCK_NULL
+};
+
+struct usage_block msvendor_usage_block[] = {
+	USAGE_BLOCK(USAGE_CUSTOM, USAGE_CUSTOM_1, EV_KEY, KEY_FN_F1, 0),
+	USAGE_BLOCK(USAGE_CUSTOM, USAGE_CUSTOM_2, EV_KEY, KEY_FN_F2, 0),
+	USAGE_BLOCK(USAGE_CUSTOM, USAGE_CUSTOM_3, EV_KEY, KEY_FN_F3, 0),
+	USAGE_BLOCK(USAGE_CUSTOM, USAGE_CUSTOM_4, EV_KEY, KEY_FN_F4, 0),
+	USAGE_BLOCK(USAGE_CUSTOM, USAGE_CUSTOM_5, EV_KEY, KEY_FN_F5, 0),
+	USAGE_BLOCK_NULL
+};
+
+struct usage_block keyboard_usage_block[] = {
+	USAGE_BLOCK(USAGE_KEYPAD_EQUAL, 0, EV_KEY, KEY_KPEQUAL, 0),
+	USAGE_BLOCK(USAGE_KEYPAD_LEFT_PAREN, 0, EV_KEY, KEY_KPLEFTPAREN, 0),
+	USAGE_BLOCK(USAGE_KEYPAD_RIGHT_PAREN, 0, EV_KEY, KEY_KPRIGHTPAREN, 0),
+	USAGE_BLOCK_NULL
+};
+
+struct usage_page_block nek4k_usage_page_blockes[] = {
+	USAGE_PAGE_BLOCK(HID_UP_CONSUMER, consumer_usage_block),
+	USAGE_PAGE_BLOCK(HID_UP_MSVENDOR, msvendor_usage_block),
+	USAGE_PAGE_BLOCK(HID_UP_KEYBOARD, keyboard_usage_block),
+	USAGE_PAGE_BLOCK_NULL
+};
+
+static int nek4k_hid_event(const struct hid_device *hid, 
+						const struct hid_field *field,
+						const struct hid_usage *usage,
+						const __s32 value,
+						const struct pt_regs *regs)
+{
+	struct hid_input *hidinput = field->hidinput;
+	struct input_dev *input = hidinput->input;
+	int code = 0;
+
+	if ( (usage->hid&HID_USAGE_PAGE) != HID_UP_MSVENDOR ||
+				     (usage->hid&HID_USAGE) != USAGE_CUSTOM )
+		return (!0);
+	
+	switch (value) {
+		case USAGE_CUSTOM_RELEASE:
+			code = (int)hidinput->private;
+			hidinput->private = NULL;
+			input_event(input, EV_KEY, code, 0);
+			input_sync(input);
+			return 0;
+		case USAGE_CUSTOM_1:
+			code = KEY_FN_F1;
+			break;
+		case USAGE_CUSTOM_2:
+			code = KEY_FN_F2;
+			break;
+		case USAGE_CUSTOM_3:
+			code = KEY_FN_F3;
+			break;
+		case USAGE_CUSTOM_4:
+			code = KEY_FN_F4;
+			break;
+		case USAGE_CUSTOM_5:
+			code = KEY_FN_F5;
+			break;
+	}
+	if (code) {
+		hidinput->private = (void*)code;
+		input_event(input, EV_KEY, code, 1);
+		input_sync(input);
+	}
+	return 0; 
+}
+
+static struct hidinput_simple_driver nek4k_driver = {
+	__SIMPLE_DRIVER_INIT
+	.name = driver_name,
+	.pre_event = nek4k_hid_event,
+	.id_table = nek4k_id_table,
+	.usage_page_table = nek4k_usage_page_blockes,
+	.private = NULL
+};
+
+static int __init nek4k_init(void)
+{
+	return hidinput_register_simple_driver(&nek4k_driver);
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



