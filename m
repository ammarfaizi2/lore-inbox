Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751582AbWI2Evf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582AbWI2Evf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 00:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751526AbWI2Evf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 00:51:35 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:12391 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750812AbWI2Eve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 00:51:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=Sn8UIvDKKKru+Ya/84GhXE3s7Y2p5bHBG/Z++HDZ3K/2+InAWPSWFl2FQH6LhSSYBxZlxvaf3bWynznJc5Z4MXBvKQQ0CTWdQPMTISdl6QlXwAf0CmBkNKCIIoxuOfcD4vV3IbIM70e2mr2h5vdEhKM9RyAnnaKMIvtP9DGu9Wc=
Date: Fri, 29 Sep 2006 12:51:44 +0800
From: "raise.sail" <raise.sail@gmail.com>
To: "LKML" <linux-kernel@vger.kernel.org>,
       "linux-usb-devel" <linux-usb-devel@lists.sourceforge.net>,
       "greg" <greg@kroah.com>
Subject: [Patch] usb/hid:Microsoft Natural Ergonomic Keyboard 4000 Driver 0.3.2
Message-ID: <200609291251420464183@gmail.com>
X-mailer: Foxmail 6, 5, 104, 21 [cn]
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changelogs:

	1. As Trantorvega suggestion, some key also yield keycode that less than 255. so we can use them under console, etc.

	For how use this driver in userspace, you can find much useful information at follow URL:

	http://gentoo-wiki.com/HOWTO_Microsoft_Natural_Ergonomic_Keyboard_4000

	However, many discusses can be found here:

	http://www.ubuntuforums.org/showthread.php?t=229559

	Thanks trantorvega here again.

This driver requires:
	1.  [PATCH] usb: The HID Simple Driver Interface 0.3.2 (core)
	2.  [PATCH] usb: HID Simple Driver Interface 0.3.1 (Kconfig and Makefile)

	Or you also can get all patches in the mail of "[PATCH] usb: The HID Simple Driver Interface 0.3.2 (core)", see its attachment.

PS:	Who is the maintainer of the input subsystem today, Should I forward this mail to him/her?

It can be applied on 2.6.18 at least. 

Signed-off-by: Liyu <raise.sail@gmail.com>

diff -Naurp linux-2.6.18/drivers/usb/input/usbnek4k.c linux-2.6.18/drivers/usb/input.new/usbnek4k.c
--- linux-2.6.18/drivers/usb/input/usbnek4k.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.18/drivers/usb/input.new/usbnek4k.c	2006-09-29 11:21:02.000000000 +0800
@@ -0,0 +1,210 @@
+/*
+ *  Microsoft Natural Ergonomic Keyboard 4000 Driver
+ *
+ *  Version:	0.3.2
+ *
+ *  Copyright (c) 2006 Li Yu <raise.sail@gmail.com>
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
+#define USAGE_ZOOM_IN	0x22d
+#define USAGE_ZOOM_OUT	0x22e
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
+#define USAGE_KEYPAD_EQUAL	0x67
+#define USAGE_KEYPAD_LEFT_PAREN	0xb6
+#define USAGE_KEYPAD_RIGHT_PAREN	0xb7
+
+#define MSNEK4K_ID_VENDOR	0x045e
+#define MSNEK4K_ID_PRODUCT	0x00db
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
+	USAGE_BLOCK(USAGE_FAVORITES, 0, EV_KEY, KEY_F16, 0),
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
+	USAGE_BLOCK(USAGE_REDO, 0, EV_KEY, KEY_F17, 0),
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
+static int nek4k_pre_event(const struct hid_device *hid, 
+					const struct hid_field *field,
+					const struct hid_usage *usage,
+					const __s32 value,
+					const struct pt_regs *regs)
+{
+	struct hid_input *hidinput = field->hidinput;
+	struct input_dev *input = hidinput->input;
+	int code = 0, ascii_keycode = 0, ev_value;
+
+	ev_value = value?1:0;
+
+	switch (usage->hid&HID_USAGE) {
+	case USAGE_FAVORITES:
+		code = KEY_FAVORITES;
+		ascii_keycode = KEY_F16;
+		goto exit;
+	case USAGE_REDO:
+		code = KEY_REDO;
+		ascii_keycode = KEY_F17;
+		goto exit;
+	};
+
+	if ((usage->hid&HID_USAGE) != USAGE_CUSTOM)
+		/* let hid core continue to process them */
+		return (!0);
+
+	switch (value) {
+	case USAGE_CUSTOM_RELEASE:
+		code = get_keycode(hidinput->private);
+		ascii_keycode = KEY_F18+(code-KEY_FN_F1);
+		break;
+	case USAGE_CUSTOM_1:
+		code = KEY_FN_F1;
+		ascii_keycode = KEY_F18;
+		break;
+	case USAGE_CUSTOM_2:
+		code = KEY_FN_F2;
+		ascii_keycode = KEY_F19;
+		break;
+	case USAGE_CUSTOM_3:
+		code = KEY_FN_F3;
+		ascii_keycode = KEY_F20;
+		break;
+	case USAGE_CUSTOM_4:
+		code = KEY_FN_F4;
+		ascii_keycode = KEY_F21;
+		break;
+	case USAGE_CUSTOM_5:
+		code = KEY_FN_F5;
+		ascii_keycode = KEY_F22;
+		break;
+	}
+exit:
+	if (code) {
+		hidinput->private = (void*)code;
+		input_event(input, EV_KEY, code, ev_value);
+		input_sync(input);
+	}
+	if (ascii_keycode) {
+		input_event(input, EV_KEY, ascii_keycode, ev_value);
+		input_sync(input);
+	}
+	return 0; 
+}
+
+static struct hidinput_simple_driver nek4k_driver = {
+	.owner = THIS_MODULE,
+	.name = driver_name,
+	.pre_event = nek4k_pre_event,
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

