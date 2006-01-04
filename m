Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751654AbWADKL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751654AbWADKL6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 05:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751648AbWADKL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 05:11:58 -0500
Received: from [210.76.114.20] ([210.76.114.20]:31912 "EHLO ccoss.com.cn")
	by vger.kernel.org with ESMTP id S1751654AbWADKL5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 05:11:57 -0500
Message-ID: <43BB9F64.5020303@ccoss.com.cn>
Date: Wed, 04 Jan 2006 18:11:48 +0800
From: liyu <liyu@ccoss.com.cn>
Reply-To: liyu@ccoss.com.cn
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: zh-cn,zh
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] usb/input: Microsoft Natural Ergonomic Keyboard 4000 Driver
Content-Type: text/plain; charset=gb18030; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

=====================
Microsoft Natural Ergonomic Keyboard 4000 Driver
=====================

Date:
------------------
20050104

Source code base
------------------

2.6.15

Testing:
------------------
Tested on i386.

Other Tips
------------------

This driver use \"HID device simple driver interface\", so you need that 
patch first, you can find it in my last email.

The zoom-in handler is mapped to KEY_F13
The zoom-out handler is mapped to KEY_F14
The custom key #1 is mapped to KEY_FN_F1
The custom key #2 is mapped to KEY_FN_F2
The custom key #3 is mapped to KEY_FN_F3
The custom key #4 is mapped to KEY_FN_F4
The custom key #5 is mapped to KEY_FN_F5

Does such arrange suitable?

Signed-off-by: Liyu <liyu@ccoss.com.cn>

diff -Naurp linux-2.6.15.orig/drivers/usb/input/Kconfig 
linux-2.6.15/drivers/usb/input/Kconfig
--- linux-2.6.15.orig/drivers/usb/input/Kconfig 2006-01-03 
11:21:10.000000000 +0800
+++ linux-2.6.15/drivers/usb/input/Kconfig 2006-01-04 16:30:44.000000000 
+0800
@@ -306,3 +306,10 @@ config USB_APPLETOUCH

To compile this driver as a module, choose M here: the
module will be called appletouch.
+
+config HID_MSNEK4K
+ tristate \"MS NEK4K Driver\"
+ depends on USB && USB_HID
+ help
+ NEK4K keyboard driver.
+
diff -Naurp linux-2.6.15.orig/drivers/usb/input/Makefile 
linux-2.6.15/drivers/usb/input/Makefile
--- linux-2.6.15.orig/drivers/usb/input/Makefile 2006-01-03 
11:21:10.000000000 +0800
+++ linux-2.6.15/drivers/usb/input/Makefile 2006-01-04 
16:29:59.000000000 +0800
@@ -42,6 +42,7 @@ obj-$(CONFIG_USB_ACECAD) += acecad.o
obj-$(CONFIG_USB_YEALINK) += yealink.o
obj-$(CONFIG_USB_XPAD) += xpad.o
obj-$(CONFIG_USB_APPLETOUCH) += appletouch.o
+obj-$(CONFIG_HID_MSNEK4K) += usbnek4k.o

ifeq ($(CONFIG_USB_DEBUG),y)
EXTRA_CFLAGS += -DDEBUG
diff -Naurp linux-2.6.15.orig/drivers/usb/input/usbnek4k.c 
linux-2.6.15/drivers/usb/input/usbnek4k.c
--- linux-2.6.15.orig/drivers/usb/input/usbnek4k.c 1970-01-01 
08:00:00.000000000 +0800
+++ linux-2.6.15/drivers/usb/input/usbnek4k.c 2006-01-04 
16:47:42.000000000 +0800
@@ -0,0 +1,328 @@
+/*
+ * Microsoft Natural Ergonomic Keyboard 4000 Driver
+ *
+ * Copyright (c) 2005 Liyu <liyu@ccoss.com.cn> Initial release.
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by 
the Free
+ * Software Foundation; either version 2 of the License, or (at your 
option)
+ * any later version.
+ */
+#include >
+#include
+#include
+#include \"hid.h\"
+#include \"hid-simple.h\"
+
+#define map_key(c) do { usage->code = c; usage->type = EV_KEY; 
set_bit(c,input->keybit); } while (0)
+#define clear_key(c) do { usage->code = 0; usage->type = 0; 
clear_bit(c,input->keybit); } while (0)
+
+/* */
+#define USAGE_ZOOM_IN 0x22d
+#define USAGE_ZOOM_OUT 0x22e
+#define USAGE_HOME 0x223
+#define USAGE_SEARCH 0x221
+#define USAGE_EMAIL 0x18a
+#define USAGE_FAVORITES 0x182
+#define USAGE_MUTE 0xe2
+#define USAGE_VOLUME_DOWN 0xea
+#define USAGE_VOLUME_UP 0xe9
+#define USAGE_PLAY_PAUSE 0xcd
+#define USAGE_CALCULATOR 0x192
+#define USAGE_BACK 0x224
+#define USAGE_FORWARD 0x225
+#define USAGE_CUSTOM 0xff05
+
+#define USAGE_CUSTEM_1 0x1
+#define USAGE_CUSTEM_2 0x2
+#define USAGE_CUSTEM_3 0x4
+#define USAGE_CUSTEM_4 0x8
+#define USAGE_CUSTEM_5 0x10
+
+#define USAGE_HELP 0x95
+#define USAGE_UNDO 0x21a
+#define USAGE_REDO 0x279
+#define USAGE_NEW 0x201
+#define USAGE_OPEN 0x202
+#define USAGE_CLOSE 0x203
+
+#define USAGE_REPLY 0x289
+#define USAGE_FWD 0x28b
+#define USAGE_SEND 0x28c
+#define USAGE_SPELL 0x1ab
+#define USAGE_SAVE 0x207
+#define USAGE_PRINT 0x208
+
+#define DRIVER_DESC \"Microsoft Natural Ergonomic Keyboard 4000 driver\"
+#define DRIVER_VERSION \"0.1.0\"
+
+#define MSNEK4K_ID_VENDOR 0x045e
+#define MSNEK4K_ID_PRODUCT 0x00db
+
+struct nek4k_device {
+ struct hidinput_simple_device device;
+};
+
+static struct usb_device_id __id[] = {
+ {
+ USB_DEVICE(MSNEK4K_ID_VENDOR, MSNEK4K_ID_PRODUCT)
+ },
+ {0, }
+};
+
+MODULE_DEVICE_TABLE(usb, __id);
+
+static char device_name[] = \"Microsoft Natural Ergonomic Keyboard 4000\";
+
+static void nek4k_setup_usage(struct hid_field *field, struct hid_usage 
*usage)
+{
+ struct hid_input *hidinput = field->hidinput;
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,15))
+ struct input_dev *input = hidinput->input;
+#else
+ struct input_dev *input = &hidinput->input;
+#endif
+
+ if ((usage->hid & HID_USAGE_PAGE) == HID_UP_CONSUMER) {
+ switch (usage->hid & HID_USAGE) {
+ case USAGE_ZOOM_IN:
+ map_key(KEY_F13);break;
+ case USAGE_ZOOM_OUT:
+ map_key(KEY_F14);break;
+ case USAGE_HOME:
+ map_key(KEY_HOMEPAGE);break;
+ case USAGE_SEARCH:
+ map_key(KEY_SEARCH);break;
+ case USAGE_EMAIL:
+ map_key(KEY_EMAIL);break;
+ case USAGE_FAVORITES:
+ map_key(KEY_FAVORITES);break;
+ case USAGE_MUTE:
+ map_key(KEY_MUTE);break;
+ case USAGE_VOLUME_DOWN:
+ map_key(KEY_VOLUMEDOWN);break;
+ case USAGE_VOLUME_UP:
+ map_key(KEY_VOLUMEUP); break;
+ case USAGE_PLAY_PAUSE:
+ map_key(KEY_PLAYPAUSE);break;
+ case USAGE_CALCULATOR:
+ map_key(KEY_CALC);break;
+ case USAGE_BACK:
+ map_key(KEY_BACK);break;
+ case USAGE_FORWARD:
+ map_key(KEY_FORWARD);break;
+ case USAGE_HELP:
+ map_key(KEY_HELP);break;
+ case USAGE_UNDO:
+ map_key(KEY_UNDO);break;
+ case USAGE_REDO:
+ map_key(KEY_REDO);break;
+ case USAGE_NEW:
+ map_key(KEY_NEW);break;
+ case USAGE_OPEN:
+ map_key(KEY_OPEN);break;
+ case USAGE_CLOSE:
+ map_key(KEY_CLOSE);break;
+ case USAGE_REPLY:
+ map_key(KEY_REPLY);break;
+ case USAGE_FWD:
+ map_key(KEY_FORWARDMAIL);break;
+ case USAGE_SEND:
+ map_key(KEY_SEND);break;
+ case USAGE_SPELL:
+ map_key(KEY_F13);break;
+ case USAGE_SAVE:
+ map_key(KEY_SAVE);break;
+ case USAGE_PRINT:
+ map_key(KEY_PRINT);break;
+ default:
+ return;
+ }
+ } else if ((usage->hid & HID_USAGE_PAGE) == HID_UP_MSVENDOR) {
+ if ((usage->hid & HID_USAGE) == USAGE_CUSTOM) {
+ /*
+ * These are custom feature key. they can not be
+ * distinguished by HID usage, nek4k_hid_event() handle
+ * them.
+ */
+ map_key(KEY_VENDOR);
+ set_bit(KEY_FN_F1,input->keybit);
+ set_bit(KEY_FN_F2,input->keybit);
+ set_bit(KEY_FN_F3,input->keybit);
+ set_bit(KEY_FN_F4,input->keybit);
+ set_bit(KEY_FN_F5,input->keybit);
+ return;
+ }
+ } else if ((usage->hid & HID_USAGE_PAGE) == HID_UP_KEYBOARD)
+ return;
+ else
+ printk(KERN_ERR\"Unknown usage page 0x%x in %s:%d\\n\", usage->hid & 
HID_USAGE_PAGE, __FUNCTION__, __LINE__);
+
+}
+
+static void nek4k_clear_usage(struct hid_field *field, struct hid_usage 
*usage)
+{
+ struct hid_input *hidinput = field->hidinput;
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,15))
+ struct input_dev *input = hidinput->input;
+#else
+ struct input_dev *input = &hidinput->input;
+#endif
+
+ if ((usage->hid & HID_USAGE_PAGE) == HID_UP_CONSUMER) {
+ switch (usage->hid & HID_USAGE) {
+ case USAGE_ZOOM_IN:
+ clear_key(KEY_F13);break;
+ case USAGE_ZOOM_OUT:
+ clear_key(KEY_F14);break;
+ case USAGE_HOME:
+ clear_key(KEY_HOMEPAGE);break;
+ case USAGE_SEARCH:
+ clear_key(KEY_SEARCH);break;
+ case USAGE_EMAIL:
+ clear_key(KEY_EMAIL);break;
+ case USAGE_FAVORITES:
+ clear_key(KEY_FAVORITES);break;
+ case USAGE_MUTE:
+ clear_key(KEY_MUTE);break;
+ case USAGE_VOLUME_DOWN:
+ clear_key(KEY_VOLUMEDOWN);break;
+ case USAGE_VOLUME_UP:
+ clear_key(KEY_VOLUMEUP); break;
+ case USAGE_PLAY_PAUSE:
+ clear_key(KEY_PLAYPAUSE);break;
+ case USAGE_CALCULATOR:
+ clear_key(KEY_CALC);break;
+ case USAGE_BACK:
+ clear_key(KEY_BACK);break;
+ case USAGE_FORWARD:
+ clear_key(KEY_FORWARD);break;
+ case USAGE_HELP:
+ clear_key(KEY_HELP);break;
+ case USAGE_UNDO:
+ clear_key(KEY_UNDO);break;
+ case USAGE_REDO:
+ clear_key(KEY_REDO);break;
+ case USAGE_NEW:
+ clear_key(KEY_NEW);break;
+ case USAGE_OPEN:
+ clear_key(KEY_OPEN);break;
+ case USAGE_CLOSE:
+ clear_key(KEY_CLOSE);break;
+ case USAGE_REPLY:
+ clear_key(KEY_REPLY);break;
+ case USAGE_FWD:
+ clear_key(KEY_FORWARDMAIL);break;
+ case USAGE_SEND:
+ clear_key(KEY_SEND);break;
+ case USAGE_SPELL:
+ clear_key(KEY_F13);break;
+ case USAGE_SAVE:
+ clear_key(KEY_SAVE);break;
+ case USAGE_PRINT:
+ clear_key(KEY_PRINT);break;
+ default:
+ return;
+ }
+ } else if ((usage->hid & HID_USAGE_PAGE) == HID_UP_MSVENDOR) {
+ if ((usage->hid & HID_USAGE) == USAGE_CUSTOM) {
+ clear_key(KEY_VENDOR);
+ clear_bit(KEY_FN_F1,input->keybit);
+ clear_bit(KEY_FN_F2,input->keybit);
+ clear_bit(KEY_FN_F3,input->keybit);
+ clear_bit(KEY_FN_F4,input->keybit);
+ clear_bit(KEY_FN_F5,input->keybit);
+ return;
+ }
+ } else if ((usage->hid & HID_USAGE_PAGE) == HID_UP_KEYBOARD) {
+ return;
+ } else
+ printk(KERN_ERR\"Unknown usage page 0x%x in %s:%d\\n\", usage->hid & 
HID_USAGE_PAGE, __FUNCTION__, __LINE__);
+
+}
+
+static void
+nek4k_hid_event(const struct hid_device *hid, const struct hid_field 
*field, const struct hid_usage * usage, const __s32 value, const struct 
pt_regs *regs)
+{
+ struct hid_input *hidinput = field->hidinput;
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,15))
+ struct input_dev *input = hidinput->input;
+#else
+ struct input_dev *input = &hidinput->input;
+#endif
+ int code;
+
+ if ( (usage->hid&HID_USAGE_PAGE)!=HID_UP_MSVENDOR ||
+ (usage->hid&HID_USAGE)!=USAGE_CUSTOM )
+ return;
+
+ switch (value) {
+ case 0x0:
+ return;
+ case 0x1:
+ code = KEY_FN_F1;
+ break;
+ case 0x2:
+ code = KEY_FN_F2;
+ break;
+ case 0x4:
+ code = KEY_FN_F3;
+ break;
+ case 0x8:
+ code = KEY_FN_F4;
+ break;
+ case 0x10:
+ code = KEY_FN_F5;
+ break;
+ default:
+ printk(KERN_ERR\"Unknown hid event value 0x%x in %s:%d\\n\", value, 
__FUNCTION__, __LINE__);
+ return;
+ };
+
+ input_event(input, EV_KEY, code, 1);
+ input_event(input, EV_KEY, code, 0);
+ input_sync(input);
+}
+
+static struct nek4k_device nek4k_device = {
+ .device = {
+ .name = device_name,
+ .setup_usage = nek4k_setup_usage,
+ .clear_usage = nek4k_clear_usage,
+ .event = nek4k_hid_event,
+ .id = {
+ { USB_DEVICE(MSNEK4K_ID_VENDOR, MSNEK4K_ID_PRODUCT) }, {}
+ }
+ }
+};
+
+static int __init nek4k_init(void)
+{
+ int result = hidinput_register_simple_device(&nek4k_device.device);
+
+ if (result == 1) {
+ /*
+ * The device that matched is busy, this can see as one error,
+ * but we bypass it in this nek4k.
+ */
+ printk(\"hid device busy\\n\");
+ }
+ if (result >= 0)
+ info(DRIVER_DESC \":\" DRIVER_VERSION);
+ else
+ return -ENODEV;
+ return 0;
+}
+
+static void __exit nek4k_exit(void)
+{
+ hidinput_unregister_simple_device(&nek4k_device.device);
+}
+
+module_init(nek4k_init);
+module_exit(nek4k_exit);
+
+MODULE_LICENSE(\"GPL\");
+

