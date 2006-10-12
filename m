Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161414AbWJLFsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161414AbWJLFsq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 01:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161413AbWJLFse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 01:48:34 -0400
Received: from wx-out-0506.google.com ([66.249.82.238]:39700 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1161377AbWJLFsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 01:48:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=b/4/0vppPv+Y8rDb4rwlbOkBldvidAMJR80gV+As/XeALcLyyakqXTPUOICjXlpPUUMWjHdWr2e08qb0F2Xlz6pvImKm9zehpikQX0CL13mITtxRUYeooL1FNaoA5Oj1E+V+k83c5hsH7V1uBSdEQbZbj8D5sCKSLbwtIHCG0Qc=
Date: Thu, 12 Oct 2006 13:48:44 +0800
From: "Li Yu" <raise.sail@gmail.com>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
       "linux-usb-devel" <linux-usb-devel@lists.sourceforge.net>,
       "Greg Kroah Hartman" <greg@kroah.com>,
       "linux-usb-devel" <linux-usb-devel@lists.sourceforge.net>,
       "LKML" <linux-kernel@vger.kernel.org>
Cc: "liyu" <liyu@ccoss.com.cn>
Subject: [PATCH] usb/hid:Microsoft Natural Ergonomic Keyboard 4000 Driver 0.4.0
Message-ID: <200610121348418902784@gmail.com>
X-mailer: Foxmail 6, 5, 104, 21 [cn]
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changelogs:

	1. More better implementation of ascii keycode feature.

This is one patch of The HID Simple Driver patches, for convenience, you can find them all in that mail:

[PATCH] usb/hid: The HID Simple Driver Patches 0.4.0 (all-in-one)

You also can use this under the early version of the HID simple driver interface, however, I recommend v0.4.0, it is more stable.

It can be applied on 2.6.18 at least.

Is this ready to merge? or What still is problem in them? Thanks.

Signed-off-by: Liyu <raise.sail@gmail.com>

--- linux-2.6.18/drivers/usb/input.orig/usbnek4k.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.18/drivers/usb/input/usbnek4k.c	2006-10-12 13:29:28.000000000 +0800
@@ -0,0 +1,252 @@
+/*
+ *  Microsoft Natural Ergonomic Keyboard 4000 Driver
+ *
+ *  Version:	0.4.0
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
+#include <linux/module.h>
+#include <linux/input.h>
+#include "hid.h"
+#include "hid-simple.h"
+
+static int ascii_keycode;
+module_param(ascii_keycode, bool, 0444);
+MODULE_PARM_DESC(ascii_keycode, "Only yield ASCII keycodes when turn on this, default=n");
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
+#define map_key(c) do { usage->code = c; usage->type = EV_KEY; set_bit(c,input->keybit); } while (0)
+#define clear_key(c) do { usage->code = 0; usage->type = 0; clear_bit(c,input->keybit); } while (0)
+
+static struct usb_device_id nek4k_id_table[] = {
+	{ USB_DEVICE(MSNEK4K_ID_VENDOR, MSNEK4K_ID_PRODUCT) },
+	{}
+};
+
+MODULE_DEVICE_TABLE(usb, nek4k_id_table);
+MODULE_DESCRIPTION("Microsoft Natural Ergonomic Keyboard 4000 Driver");
+MODULE_VERSION("0.4.0");
+
+struct usage_block consumer_usage_block[] = {
+	USAGE_BLOCK(USAGE_ZOOM_IN, 0, EV_KEY, KEY_F13, 0),
+	USAGE_BLOCK(USAGE_ZOOM_OUT, 0, EV_KEY, KEY_F14, 0),
+	USAGE_BLOCK(USAGE_HOME, 0, EV_KEY, KEY_HOMEPAGE, 0),
+	USAGE_BLOCK(USAGE_SEARCH, 0, EV_KEY, KEY_SEARCH, 0),
+	USAGE_BLOCK(USAGE_EMAIL, 0, EV_KEY, KEY_EMAIL, 0),
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
+static void nek4k_setup_usage(struct hid_field *field, struct hid_usage *usage)
+{
+	struct hid_input *hidinput = field->hidinput;
+	struct input_dev *input = hidinput->input;
+
+	if ((usage->hid & HID_USAGE_PAGE) == HID_UP_CONSUMER) {
+		if ((usage->hid & HID_USAGE) == USAGE_FAVORITES) {
+			if (ascii_keycode)
+				map_key(KEY_F16);
+			else
+				map_key(KEY_FAVORITES);
+		}
+	} else if ((usage->hid & HID_USAGE_PAGE) == HID_UP_MSVENDOR) {
+		if ((usage->hid & HID_USAGE) == USAGE_CUSTOM) {
+			if (ascii_keycode) {
+				set_bit(KEY_F18,input->keybit);
+				set_bit(KEY_F19,input->keybit);
+				set_bit(KEY_F20,input->keybit);
+				set_bit(KEY_F21,input->keybit);
+				set_bit(KEY_F22,input->keybit);
+			} else {
+				set_bit(KEY_FN_F1,input->keybit);
+				set_bit(KEY_FN_F2,input->keybit);
+				set_bit(KEY_FN_F3,input->keybit);
+				set_bit(KEY_FN_F4,input->keybit);
+				set_bit(KEY_FN_F5,input->keybit);
+			}
+		}
+	}
+}
+
+static void nek4k_clear_usage(struct hid_field *field, struct hid_usage *usage)
+{
+	struct hid_input *hidinput = field->hidinput;
+	struct input_dev *input = hidinput->input;
+
+	if ((usage->hid & HID_USAGE_PAGE) == HID_UP_CONSUMER) {
+		if ((usage->hid & HID_USAGE) == USAGE_FAVORITES) {
+			if (ascii_keycode)
+				clear_key(KEY_F16);
+			else
+				clear_key(KEY_FAVORITES);
+		}
+	} else if ((usage->hid & HID_USAGE_PAGE) == HID_UP_MSVENDOR) {
+		if ((usage->hid & HID_USAGE) == USAGE_CUSTOM) {
+			if (ascii_keycode) {
+				clear_bit(KEY_F18,input->keybit);
+				clear_bit(KEY_F19,input->keybit);
+				clear_bit(KEY_F20,input->keybit);
+				clear_bit(KEY_F21,input->keybit);
+				clear_bit(KEY_F22,input->keybit);
+			} else {
+				clear_bit(KEY_FN_F1,input->keybit);
+				clear_bit(KEY_FN_F2,input->keybit);
+				clear_bit(KEY_FN_F3,input->keybit);
+				clear_bit(KEY_FN_F4,input->keybit);
+				clear_bit(KEY_FN_F5,input->keybit);
+			}
+		}
+	}
+}
+
+static int nek4k_pre_event(const struct hid_device *hid, 
+					const struct hid_field *field,
+					const struct hid_usage *usage,
+					const __s32 value,
+					const struct pt_regs *regs)
+{
+	struct hid_input *hidinput = field->hidinput;
+	struct input_dev *input = hidinput->input;
+	int code = 0;
+
+	if (((usage->hid&HID_USAGE_PAGE) != HID_UP_MSVENDOR) ||
+				(usage->hid&HID_USAGE) != USAGE_CUSTOM)
+		return (!0); /* Let hid core continue to process them */
+
+	code = ascii_keycode ? KEY_F18-1 : KEY_FN_F1-1;
+	switch (value) {
+	case USAGE_CUSTOM_RELEASE:
+		code = (int)hidinput->private;
+		break;
+	case USAGE_CUSTOM_1:
+	case USAGE_CUSTOM_2:
+	case USAGE_CUSTOM_3:
+	case USAGE_CUSTOM_4:
+	case USAGE_CUSTOM_5:
+		code += ffs(value);
+	}
+	if (code) {
+		hidinput->private = (void*)code;
+		input_report_key(input, code, value);
+		input_sync(input);
+	}
+	return 0; 
+}
+
+static struct hidinput_simple_driver nek4k_driver = {
+	.owner = THIS_MODULE,
+	.name = "usbnek4k",
+	.setup_usage = nek4k_setup_usage,
+	.clear_usage = nek4k_clear_usage,
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

