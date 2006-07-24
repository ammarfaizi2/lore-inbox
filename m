Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751425AbWGXG5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbWGXG5M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 02:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbWGXG5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 02:57:12 -0400
Received: from [210.76.114.181] ([210.76.114.181]:39610 "EHLO ccoss.com.cn")
	by vger.kernel.org with ESMTP id S1751425AbWGXG5K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 02:57:10 -0400
Message-ID: <44C46F5B.8080506@ccoss.com.cn>
Date: Mon, 24 Jul 2006 14:57:31 +0800
From: liyu <liyu@ccoss.com.cn>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Peter <peter@maubp.freeserve.co.uk>, thedoctor@tardis.homelinux.org,
       LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Subject: [PATCH] USBHID: HID device simple driver interface
References: <44B77AB0.8060700@maubp.freeserve.co.uk>
In-Reply-To: <44B77AB0.8060700@maubp.freeserve.co.uk>
Content-Type: multipart/mixed;
 boundary="------------090007090708070802090204"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090007090708070802090204
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

==================================
HID device simple driver interface
==================================

------------------------
Version
------------------------

    This is the second version, this patch can apply on 2.6.17.6 kernel 
tree.

    The last version can find here:

        http://www.gossamer-threads.com/lists/linux/kernel/603843.

    I am sorry I just see Greg KH reply. The traffic of LKML is so great :)

------------------------
Goal
------------------------

    Let us write HID device driver more easier.


------------------------
Basic idea
------------------------

    Under current HID device driver development technique, We need write 
one new interrupt handler for each new HID device to report event to 
input subsystem. However, the most of them have only some extended keys, 
e.g. many remote controllers. I think it seem break a fly on the wheel, 
which write one new interrupt handler for this reason.
    My idea is reuse the interrupt handler in hid-core.c. so  writing 
driver for new simple HID device will be more easier, quickly, and need 
not touch hid core.
    In essence, this interface just is some hooks in HID core.
        
------------------------
Limitation
------------------------
    
    In the last version of this interface, Each driver use this 
interface only can work with one device at same time. As the Greg KH 
words, this limitation make this interface too useless. e.g. we often 
can find there are two joysticks connected with one host. In this 
version, the driver can work with more than one device at same time. 
However, I still do not recommend you use this interface, if your driver 
need handle a lot of devices (e.g. more than 20) at same time, beacause 
of I used simple algorithm to search/insert/delete each device.
    
    This interface can not support the more drivers handle one device at 
same time yet. I can not sure if we need this feature? What do you 
think, Greg KH?


------------------------    
Testing
------------------------

    Tested on i386.

        
------------------------
The driver use this interface
------------------------
    
    I wrote a driver for MS Natural Ergonomic Keyboard 4000. This driver 
also get some improvements for this new version simple driver interface:
    
    1. These five "My Favorites" keys map FN_F{1,2,3,4,5}_KEY directly, 
instead of map them to KEY_VENDOR hacking means.
    2. Support left paren key "(", right paren key ")", equal key "=" on 
right-top keypad. In fact, this keyboard generate KEYPAD_XXX usage code 
for them, but I find many applications can not handle them on default 
configuration, especially X.org. To get the most best usability, I use a 
bit magic here: map them to "Shift+9" and "Shift+0".

------------------------
Usage
------------------------    

    Although this simple driver have not direct relation with Linux 
device driver architecture, but I still make its API like it on purpose.

    The simple driver have five methods:

1.    int (*connect)(struct hid_device *, struct hid_input *);
2.    void (*disconnect)(struct hid_device *, struct hid_input *);

    When you simple driver is to bind with one real HID device, we will 
call connect() method first. To return 0 flag if it complete its mission 
successfully, so we can continue, return any other value is looked as 
error. any thing do not happen.
    When the HID device that your simple driver connect with is down, or 
you unregister this simple driver, we will call disconnect() method, it 
have none return value.
    Note: the these method may be called more times on one device. 
beacause of some device will yield more than one hid_device/hid_input 
instances. of course, you can ignore them that you do not interest.
    
3.    void (*setup_usage)(struct hid_field *,   struct hid_usage *);
4.    void (*clear_usage)(struct hid_field *,   struct hid_usage *);
    
    The setup_usage() method is like hidinput_configure_usage() in 
hid_input.c. You also can setup input_dev here. In most time, I think 
you should be fill the pointer slot for this method, elsewise the 
event() method do not work for you at all. Please see example in "MS 
Natural Ergonomic Keyboard 4000" driver.
    The clear_usage() method is used to clear side-effect that came from 
setup_usage() method, if they are there. Of course, you can do same 
things in disconnect() method, but this method let your life more 
simpler.    

6.    int (*pre_event)(const struct hid_device *, const struct hid_field 
*, const struct hid_usage *, const __s32, const struct pt_regs *regs);

    First, you can use this method send event to input subsystem, 
moreover, you can use this as one usage code filter: if it return 
non-zero , any event handling method do not be called , even the 
hidinput_hid_event().
    If this method return zero, the normally event handling process will 
continue.
    Note again, if you do not correctly configure usage in 
setup_usage(), this method do not work as you want.

7.    void (*post_event)(const struct hid_device *, const struct 
hid_field *, const struct hid_usage *, const __s32, const struct pt_regs 
*regs);

    Its behavior like with hidinput_hid_event() exactly. but if 
pre_event() return non-zero value, this method also do not called at all.
    Note again, if you do not correctly configure usage in 
setup_usage(), this method do not work as you want.
    This method have not return value.
    
    All these methods are optional, but if they are all NULL pointers, 
what are you want? If you do not supply one method, We see as it 
complete its task successfully.

    For detailed usage, you can find out in the MS Natural Ergonomic 
Keyboard 4000 driver , usbnek4k.c. it is in my other patch.

------------------------
The most simplest demo
------------------------

/* NOTE: As another HID driver, you must place this source in 
drivers/usb/input directory before build it. */
#include <linux/kernel.h>
#include <linux/input.h>
#include "hid.h"
#include "hid-simple.h"
 
#define VENDOR_ID 0x1234
#define PRODUCT_ID 0x5678
 
static struct usb_device_id my_id_table[] = {
        { USB_DEVICE(VENDOR_ID, PRODUCT_ID) },
        {}
};
 
static int process_your_device_input_event(const struct hid_device *hid, 
const struct hid_field *field, const struct hid_usage * usage, const 
__s32 value, const struct pt_regs *regs)
{
        struct hid_input *hidinput = field->hidinput;
        struct input_dev *input = hidinput->input;
 
        /* send event that you want to send to input subsystem here */
        return 0;
}
 
static struct hidinput_simple_driver nek4k_driver = {
        .name = "DEMO",
        .pre_event = process_your_device_input_event,
        .id_table = my_id_table,
};
 
static int __init nek4k_init(void)
{
        int result;
 
        result = hidinput_register_simple_driver(&nek4k_driver);
 
        switch (result) {
                case 0:
                        return 0;
                default:
                        return -ENODEV;
        };
}
                                                                                                  
 
static void __exit nek4k_exit(void)
{
        hidinput_unregister_simple_driver(&nek4k_driver);
}
                                                                                                  
 
module_init(nek4k_init);
module_exit(nek4k_exit);
/* demo end */
------------------------
post_event()
------------------------

    The last words that I want to say are sorry, this new version have 
not compatibility with the last version.
        
    Good luck.
    
EOF.


--------------090007090708070802090204
Content-Type: text/x-patch;
 name="usbnek4k.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="usbnek4k.patch"

diff -Naurp input.orig/Kconfig input/Kconfig
--- input.orig/Kconfig	2006-07-16 03:00:43.000000000 +0800
+++ input/Kconfig	2006-07-24 14:04:56.000000000 +0800
@@ -326,3 +326,11 @@ config USB_APPLETOUCH
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called appletouch.
+
+config HID_MSNEK4K
+	tristate "Microsoft Natural Ergonomic Keyboard 4000 Driver"
+	depends on USB && USB_HID
+	---help---
+	Microsoft Natural Ergonomic Keyboard 4000 driver. These extend keys
+	may not work without change user space configration, e.g, XKB conf-
+	iguration in X. 
diff -Naurp input.orig/Makefile input/Makefile
--- input.orig/Makefile	2006-07-16 03:00:43.000000000 +0800
+++ input/Makefile	2006-07-24 14:04:46.000000000 +0800
@@ -44,6 +44,7 @@ obj-$(CONFIG_USB_ACECAD)	+= acecad.o
 obj-$(CONFIG_USB_YEALINK)	+= yealink.o
 obj-$(CONFIG_USB_XPAD)		+= xpad.o
 obj-$(CONFIG_USB_APPLETOUCH)	+= appletouch.o
+obj-$(CONFIG_HID_MSNEK4K)	+= usbnek4k.o
 
 ifeq ($(CONFIG_USB_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
diff -Naurp input.orig/usbnek4k.c input/usbnek4k.c
--- input.orig/usbnek4k.c	1970-01-01 08:00:00.000000000 +0800
+++ input/usbnek4k.c	2006-07-24 14:27:10.000000000 +0800
@@ -0,0 +1,400 @@
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
+#define map_key(c)	do { usage->code = c; usage->type = EV_KEY; set_bit(c,input->keybit); } while (0)
+#define clear_key(c)	do { usage->code = 0; usage->type = 0; clear_bit(c,input->keybit); } while (0)
+#define clear_usage(c)	do { usage->code = 0; usage->type = 0; } while (0)
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
+		printk(KERN_WARNING"Unknown usage page 0x%x in %s:%d\n", usage->hid & HID_USAGE_PAGE, __FUNCTION__, __LINE__);
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
+		printk(KERN_ERR"Unknown usage page 0x%x in %s:%d\n", usage->hid & HID_USAGE_PAGE, __FUNCTION__, __LINE__);
+
+}
+
+static int
+nek4k_hid_event(const struct hid_device *hid, const struct hid_field *field, const struct hid_usage * usage, const __s32 value, const struct pt_regs *regs)
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

--------------090007090708070802090204
Content-Type: text/x-patch;
 name="simple.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="simple.patch"

diff -Naurp input.orig/hid-core.c input/hid-core.c
--- input.orig/hid-core.c	2006-07-16 03:00:43.000000000 +0800
+++ input/hid-core.c	2006-07-24 14:01:22.000000000 +0800
@@ -4,6 +4,7 @@
  *  Copyright (c) 1999 Andreas Gal
  *  Copyright (c) 2000-2005 Vojtech Pavlik <vojtech@suse.cz>
  *  Copyright (c) 2005 Michael Haboustak <mike-@cinci.rr.com> for Concept2, Inc
+ *  Copyright (c) 2006 Liyu <liyu@ccoss.com.cn>  For support simple HID device driver interface.
  */
 
 /*
@@ -26,6 +27,7 @@
 #include <asm/byteorder.h>
 #include <linux/input.h>
 #include <linux/wait.h>
+#include <asm/semaphore.h>
 
 #undef DEBUG
 #undef DEBUG_DATA
@@ -34,6 +36,7 @@
 
 #include "hid.h"
 #include <linux/hiddev.h>
+#include "hid-simple.h"
 
 /*
  * Version Information
@@ -46,6 +49,15 @@
 
 static char *hid_types[] = {"Device", "Pointer", "Mouse", "Device", "Joystick",
 				"Gamepad", "Keyboard", "Keypad", "Multi-Axis Controller"};
+
+/*
+ * The global data structure for simple device driver interface.
+ */
+static DECLARE_MUTEX(matched_lock);
+static DECLARE_MUTEX(simple_lock);
+static struct list_head matched_devices_list;
+static struct list_head simple_drivers_list;
+
 /*
  * Module parameters.
  */
@@ -785,8 +797,14 @@ static __inline__ int search(__s32 *arra
 static void hid_process_event(struct hid_device *hid, struct hid_field *field, struct hid_usage *usage, __s32 value, int interrupt, struct pt_regs *regs)
 {
 	hid_dump_input(usage, value);
-	if (hid->claimed & HID_CLAIMED_INPUT)
+	if (hid->claimed & HID_CLAIMED_INPUT) {
+		if (hid->simple && hid->simple->pre_event &&
+			!hid->simple->pre_event(hid, field, usage, value, regs))
+			return;
 		hidinput_hid_event(hid, field, usage, value, regs);
+		if (hid->simple && hid->simple->post_event)
+			hid->simple->post_event(hid, field, usage, value, regs);
+	}
 	if (hid->claimed & HID_CLAIMED_HIDDEV && interrupt)
 		hiddev_hid_event(hid, field, usage, value, regs);
 }
@@ -832,7 +850,6 @@ static void hid_input_field(struct hid_d
 			&& field->usage[field->value[n] - min].hid
 			&& search(value, field->value[n], count))
 				hid_process_event(hid, field, &field->usage[field->value[n] - min], 0, interrupt, regs);
-
 		if (value[n] >= min && value[n] <= max
 			&& field->usage[value[n] - min].hid
 			&& search(field->value, value[n], count))
@@ -1977,6 +1994,8 @@ fail:
 static void hid_disconnect(struct usb_interface *intf)
 {
 	struct hid_device *hid = usb_get_intfdata (intf);
+	struct list_head *node;
+	struct matched_device *matched;
 
 	if (!hid)
 		return;
@@ -1991,8 +2010,29 @@ static void hid_disconnect(struct usb_in
 	del_timer_sync(&hid->io_retry);
 	flush_scheduled_work();
 
-	if (hid->claimed & HID_CLAIMED_INPUT)
+	if (hid->claimed & HID_CLAIMED_INPUT) {
+		matched = NULL;
+		down(&matched_lock);
+		list_for_each(node, &matched_devices_list) {
+			matched = list_entry(node, struct matched_device, node);
+			if (matched->intf == intf) {
+				list_del(&matched->node);
+				break;
+			}
+			matched = NULL;
+		}
+		up(&matched_lock);
+		/* disconnect simple device driver if need */
+		if (matched && hid->simple) {
+			hidinput_simple_driver_disconnect(hid);
+			hidinput_simple_driver_pop(hid->simple, matched);
+		}
+		if (matched) {
+			matched->intf = NULL;
+			kfree(matched);
+		}
 		hidinput_disconnect(hid);
+	}
 	if (hid->claimed & HID_CLAIMED_HIDDEV)
 		hiddev_disconnect(hid);
 
@@ -2005,12 +2045,138 @@ static void hid_disconnect(struct usb_in
 	hid_free_device(hid);
 }
 
+
+/* called when we unregister a hidinput simple device driver */
+static void
+hidinput_simple_driver_bind_foreach(void)
+{
+	struct hidinput_simple_driver *simple;
+	struct matched_device *matched=NULL;
+	struct list_head *matched_node = NULL;
+	struct list_head *simple_node = NULL;
+	struct hid_device *hid=NULL;
+
+	down(&matched_lock);
+	list_for_each(matched_node, &matched_devices_list) {
+		matched = list_entry(matched_node, struct matched_device, node);
+		hid = usb_get_intfdata(matched->intf);
+		printk(KERN_DEBUG"foreach: %s\n", hid->name);
+		if (hid->simple)
+			continue;
+		down(&simple_lock);
+		list_for_each(simple_node, &simple_drivers_list) {
+			simple = list_entry(simple_node, struct hidinput_simple_driver, node);
+			printk(KERN_DEBUG"foreach inner: %s\n", simple->name);
+			if (!usb_match_id(matched->intf, simple->id_table))
+				continue;
+			if (hidinput_simple_driver_connect(simple, hid))
+				continue;
+			if (hidinput_simple_driver_push(simple, matched))
+				continue;
+			hidinput_simple_driver_setup_usage(hid);
+			printk(KERN_INFO"The simple HID driver \'%s\' attach on \'%s\'\n", simple->name, hid->name);
+		}
+		up(&simple_lock);
+	}
+	up(&matched_lock);
+	
+}
+
+/* called in hid_probe() */
+static void
+hidinput_simple_driver_bind(struct matched_device *matched)
+{
+	struct hidinput_simple_driver *simple;
+	struct list_head *node;
+	struct hid_device *hid;
+	
+	if (!matched->intf)
+		return;
+	hid = usb_get_intfdata (matched->intf);
+	if (hid->simple)
+		return;
+
+	simple = NULL;
+	down(&simple_lock);
+	list_for_each(node, &simple_drivers_list) {
+		simple = list_entry(node, struct hidinput_simple_driver, node);
+		if (usb_match_id(matched->intf, simple->id_table))
+			break;
+		simple = NULL;
+	}
+	up(&simple_lock);
+	
+	if (!simple) 
+		return;
+	if (hidinput_simple_driver_connect(simple, hid))
+		return;
+	if (hidinput_simple_driver_push(simple, matched))
+		return;
+	hidinput_simple_driver_setup_usage(hid);
+
+	printk(KERN_INFO"The simple HID driver \'%s\' attach on \'%s\'\n", simple->name, hid->name);
+}
+
+int
+hidinput_register_simple_driver(struct hidinput_simple_driver *simple)
+{
+	struct list_head *node=NULL;
+	struct matched_device *matched;
+	struct hid_device *hid=NULL;
+	int ret=-ENODEV;
+
+	if (!simple || !simple->name)
+		return -EINVAL;
+
+	hidinput_simple_driver_init(simple);
+
+	down(&matched_lock);
+	list_for_each(node, &matched_devices_list) {
+		matched = list_entry(node, struct matched_device, node);
+		hid = usb_get_intfdata (matched->intf);
+		if (hid->simple)
+			continue;
+		if (!usb_match_id(matched->intf, simple->id_table))
+			continue;
+		if (hidinput_simple_driver_connect(simple, hid))
+			continue;
+		if (hidinput_simple_driver_push(simple, matched))
+			continue;
+		hidinput_simple_driver_setup_usage(hid);
+		ret = 0;
+		printk(KERN_INFO"The simple HID driver \'%s\' attach on \'%s\'.\n", simple->name, hid->name);
+	}
+	up(&matched_lock);
+
+	down(&simple_lock);
+	list_add(&simple->node, &simple_drivers_list);
+	up(&simple_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(hidinput_register_simple_driver);
+
+void
+hidinput_unregister_simple_driver(struct hidinput_simple_driver *simple)
+{
+	hidinput_simple_driver_clear(simple);
+	down(&simple_lock);
+	list_del(&simple->node);
+	up(&simple_lock);
+	/* to active simple device driver that it is waiting */
+	hidinput_simple_driver_bind_foreach();
+	printk(KERN_INFO"The simple HID driver \'%s\' unregistered.\n", simple->name);
+}
+
+EXPORT_SYMBOL_GPL(hidinput_unregister_simple_driver);
+
 static int hid_probe(struct usb_interface *intf, const struct usb_device_id *id)
 {
 	struct hid_device *hid;
 	char path[64];
 	int i;
 	char *c;
+	struct matched_device *matched;
 
 	dbg("HID probe called for ifnum %d",
 			intf->altsetting->desc.bInterfaceNumber);
@@ -2021,13 +2187,22 @@ static int hid_probe(struct usb_interfac
 	hid_init_reports(hid);
 	hid_dump_device(hid);
 
-	if (!hidinput_connect(hid))
+	usb_set_intfdata(intf, hid);
+
+	if (!hidinput_connect(hid)) {
+		matched = kmalloc(sizeof(struct matched_device), GFP_KERNEL);
+		if (matched) {
+			matched->intf = intf;
+			down(&matched_lock);
+			list_add(&matched->node, &matched_devices_list);
+			up(&matched_lock);
+			hidinput_simple_driver_bind(matched);
+		}
 		hid->claimed |= HID_CLAIMED_INPUT;
+	}
 	if (!hiddev_connect(hid))
 		hid->claimed |= HID_CLAIMED_HIDDEV;
 
-	usb_set_intfdata(intf, hid);
-
 	if (!hid->claimed) {
 		printk ("HID device not claimed by input or hiddev\n");
 		hid_disconnect(intf);
@@ -2108,6 +2283,8 @@ static int __init hid_init(void)
 	retval = hiddev_init();
 	if (retval)
 		goto hiddev_init_fail;
+	INIT_LIST_HEAD(&matched_devices_list);
+	INIT_LIST_HEAD(&simple_drivers_list);
 	retval = usb_register(&hid_driver);
 	if (retval)
 		goto usb_register_fail;
@@ -2122,7 +2299,15 @@ hiddev_init_fail:
 
 static void __exit hid_exit(void)
 {
+	struct list_head *node, *tmp;
+	struct matched_device *matched;
+	
 	usb_deregister(&hid_driver);
+	list_for_each_safe(node, tmp, &matched_devices_list) {
+		matched = list_entry(node, struct matched_device, node);
+		list_del(&matched->node);
+		kfree(matched);
+	}
 	hiddev_exit();
 }
 
diff -Naurp input.orig/hid.h input/hid.h
--- input.orig/hid.h	2006-07-16 03:00:43.000000000 +0800
+++ input/hid.h	2006-07-21 13:46:03.000000000 +0800
@@ -6,6 +6,7 @@
  *
  *  Copyright (c) 1999 Andreas Gal
  *  Copyright (c) 2000-2001 Vojtech Pavlik
+ *  Copyright (c) 2006 Liyu     To support simple HID device.
  */
 
 /*
@@ -382,6 +383,8 @@ struct hid_input {
 	struct input_dev *input;
 };
 
+struct hidinput_simple_driver;
+
 struct hid_device {							/* device report descriptor */
 	 __u8 *rdesc;
 	unsigned rsize;
@@ -445,6 +448,8 @@ struct hid_device {							/* device repo
 	int (*ff_event)(struct hid_device *hid, struct input_dev *input,
 			unsigned int type, unsigned int code, int value);
 
+	struct hidinput_simple_driver *simple;
+
 #ifdef CONFIG_USB_HIDINPUT_POWERBOOK
 	unsigned long pb_pressed_fn[NBITS(KEY_MAX)];
 	unsigned long pb_pressed_numlock[NBITS(KEY_MAX)];
diff -Naurp input.orig/hid-input.c input/hid-input.c
--- input.orig/hid-input.c	2006-07-16 03:00:43.000000000 +0800
+++ input/hid-input.c	2006-07-22 15:05:35.000000000 +0800
@@ -36,6 +36,7 @@
 #undef DEBUG
 
 #include "hid.h"
+#include "hid-simple.h"
 
 #define unk	KEY_UNKNOWN
 
@@ -849,6 +850,153 @@ int hidinput_connect(struct hid_device *
 	return 0;
 }
 
+int
+hidinput_simple_driver_init(struct hidinput_simple_driver *drv)
+{
+	if (unlikely(!drv))
+		return -EINVAL;
+	INIT_LIST_HEAD(&drv->node);
+	INIT_LIST_HEAD(&drv->raw_devices);
+	drv->flags = 0;
+	return 0;
+}
+
+/*
+ *  To give one simple device a configure usage chance.
+ *  The most code of this function is copied from hidinput_connect()
+ */
+void hidinput_simple_driver_configure_usage(struct hid_device *hid)
+{
+	struct hid_report *report;
+	int i, j, k;
+	void (*do_usage)(struct hid_field *,   struct hid_usage *);
+	
+	if (!hid->simple)
+		return;
+
+	do_usage = NULL;
+	if (hid->simple->flags & HIDINPUT_SIMPLE_SETUP_USAGE)
+		do_usage = hid->simple->setup_usage;
+	else
+		do_usage = hid->simple->clear_usage;
+	if (!do_usage)
+		return;
+
+	for (i = 0; i < hid->maxcollection; i++)
+		if (hid->collection[i].type == HID_COLLECTION_APPLICATION || hid->collection[i].type==HID_COLLECTION_PHYSICAL)
+			if (IS_INPUT_APPLICATION(hid->collection[i].usage))
+				break;
+
+	if (i == hid->maxcollection)
+		return;
+
+	for (k = HID_INPUT_REPORT; k <= HID_OUTPUT_REPORT; k++)
+		list_for_each_entry(report, &hid->report_enum[k].report_list, list) {
+
+			if (!report->maxfield)
+				continue;
+
+			for (i = 0; i < report->maxfield; i++)
+				for (j = 0; j < report->field[i]->maxusage; j++)
+					do_usage(report->field[i], report->field[i]->usage + j);
+		}
+
+	return;
+}
+
+int
+hidinput_simple_driver_push(struct hidinput_simple_driver *simple, struct matched_device *matched)
+{
+	struct raw_simple_device *raw_simple;
+	struct hid_device *hid;
+	
+	raw_simple = kmalloc(sizeof(struct raw_simple_device), GFP_KERNEL);
+	if (!raw_simple)
+		return -ENOMEM;
+	raw_simple->intf = matched->intf;
+	hid = usb_get_intfdata(matched->intf);
+	hid->simple = simple;
+	list_add(&raw_simple->node, &simple->raw_devices);
+	return 0;
+}
+
+void
+hidinput_simple_driver_pop(struct hidinput_simple_driver *simple, struct matched_device *matched)
+{
+	struct list_head *node;
+	struct raw_simple_device *raw_simple=NULL;
+	struct hid_device *hid;
+
+	list_for_each (node, &simple->raw_devices) {
+		printk(KERN_DEBUG"list_entry\n");
+		raw_simple = list_entry(node, struct raw_simple_device, node);
+		if (raw_simple && raw_simple->intf == matched->intf) {
+			printk(KERN_DEBUG"usb_get_intfdata\n");
+			hid = usb_get_intfdata(matched->intf);
+			hid->simple = NULL;
+			printk(KERN_DEBUG"list_del\n");
+			list_del(&raw_simple->node);
+			kfree(raw_simple);
+			return;
+		}
+	}
+}
+
+void
+hidinput_simple_driver_clear(struct hidinput_simple_driver *simple)
+{
+	struct raw_simple_device *raw_simple;
+	struct hid_device *hid;
+
+	while (!list_empty_careful(&simple->raw_devices)) {
+		raw_simple = list_entry(simple->raw_devices.next, struct raw_simple_device, node);
+		hid = usb_get_intfdata (raw_simple->intf);
+	
+		if (hid->simple) {
+			BUG_ON(hid->simple != simple);
+			hid->simple = NULL;
+		}
+		hidinput_simple_driver_clear_usage(hid);
+		printk("device '%s' disconnect from one simple driver.\n", hid->name);
+		hidinput_simple_driver_disconnect(hid);
+		list_del_init(simple->raw_devices.next);
+	}
+}
+
+/* modify from hidinput_disconnect() */ 
+int hidinput_simple_driver_connect(struct hidinput_simple_driver *simple, struct hid_device *hid)
+{
+	struct hid_input *hidinput, *next;
+	int ret = -ENODEV;
+
+	if (!simple)
+		return ret;
+	if (!simple->connect)
+		return 0;
+
+	list_for_each_entry_safe(hidinput, next, &hid->inputs, list) {
+		if (!simple->connect(hid, hidinput)) {
+			hid->simple = simple;
+			ret = 0;
+		}
+	}
+	return ret;
+}
+
+
+/* modify from hidinput_disconnect() */ 
+void hidinput_simple_driver_disconnect(struct hid_device *hid)
+{
+	struct hid_input *hidinput, *next;
+
+	if (!hid->simple || !hid->simple->disconnect)
+		return;
+
+	list_for_each_entry_safe(hidinput, next, &hid->inputs, list) {
+		hid->simple->disconnect(hid, hidinput);
+	}
+}
+
 void hidinput_disconnect(struct hid_device *hid)
 {
 	struct hid_input *hidinput, *next;
diff -Naurp input.orig/hid-simple.h input/hid-simple.h
--- input.orig/hid-simple.h	1970-01-01 08:00:00.000000000 +0800
+++ input/hid-simple.h	2006-07-24 11:25:27.000000000 +0800
@@ -0,0 +1,101 @@
+/*
+ *  NOTE:
+ *	For use me , you must include hid.h in your source first. 
+ */
+#ifndef __HID_SIMPLE_H
+#define __HID_SIMPLE_H
+
+/* list_*_entry like interface */
+/* FIXME: Would you like move them to include/linux/list.h ? */
+#define list_for_each_continue(pos, head) \
+	for ((pos) = (pos)->next; \
+	prefetch((pos)->next), (pos) != (head); \
+	(pos) = (pos)->next)
+#define list_prepare(pos, head) ((pos) ? : head)
+
+#include <linux/usb.h>
+/******** The private section for simple device implement only ***********/
+
+/* 
+ *  matched_device record one device which hid-subsystem handle, it may 
+ *  be one simple device can not handle.
+ *
+ *  The element of matched_device list is inserted at hidinput_connect(), 
+ *  and is removed  at hidinput_disconnect().
+ */ 
+struct matched_device {
+	struct usb_interface *intf;
+	struct list_head node;
+	/* this need not atomic_t. beacause it only change while simple driver module insert or delete. thus, one module can not insert and delete at same time, even under SMP */
+	int refcnt;
+};
+
+/* 
+ *  raw_simple_driver record one device which hid simple device handle.
+ *  It used as one member of hid_simple_driver.
+ */ 
+
+struct raw_simple_device {
+	struct usb_interface *intf;
+	struct list_head node;
+};
+
+
+/* simple device internal flags */
+#define HIDINPUT_SIMPLE_SETUP_USAGE 0x1 /* the reverse is to call clear_usage */
+
+#define hidinput_simple_driver_setup_usage(hid) \
+do {\
+	if (hid->simple) {\
+		hid->simple->flags |= HIDINPUT_SIMPLE_SETUP_USAGE; \
+		hidinput_simple_driver_configure_usage(hid); \
+	}\
+} while (0)
+
+#define hidinput_simple_driver_clear_usage(hid) \
+do {\
+	if (hid->simple) {\
+		hid->simple->flags &= (~HIDINPUT_SIMPLE_SETUP_USAGE); \
+		hidinput_simple_driver_configure_usage(hid); \
+	}\
+} while (0)
+
+/* Note again here, you must include hid.h in your source first. */
+
+struct hidinput_simple_driver;
+void hidinput_simple_driver_configure_usage(struct hid_device *hid);
+int hidinput_simple_driver_init(struct hidinput_simple_driver *simple);
+int hidinput_simple_driver_push(struct hidinput_simple_driver *simple, struct matched_device *dev);
+void hidinput_simple_driver_pop(struct hidinput_simple_driver *simple, struct matched_device *dev);
+void hidinput_simple_driver_clear(struct hidinput_simple_driver *simple);
+int hidinput_simple_driver_connect(struct hidinput_simple_driver *simple, struct hid_device *hid);
+void hidinput_simple_driver_disconnect(struct hid_device *hid);
+
+
+/******************** The private section end.  *****************************/
+
+
+/********************* The public interface for simple device driver ***********/
+struct hidinput_simple_driver {
+/* private */
+	struct list_head node; /* link with simple_drivers_list */
+	struct list_head raw_devices;
+	int flags;
+/* public */
+	char *name;
+	int (*connect)(struct hid_device *, struct hid_input *);	
+	void (*setup_usage)(struct hid_field *,   struct hid_usage *);
+	int (*pre_event)(const struct hid_device *, const struct hid_field *, const struct hid_usage *, const __s32, const struct pt_regs *regs);
+	int (*post_event)(const struct hid_device *, const struct hid_field *, const struct hid_usage *, const __s32, const struct pt_regs *regs);
+	void (*clear_usage)(struct hid_field *,   struct hid_usage *);
+	void (*disconnect)(struct hid_device *, struct hid_input *);
+	void *private;
+	struct usb_device_id *id_table;
+};
+
+
+int hidinput_register_simple_driver(struct hidinput_simple_driver *device);
+void hidinput_unregister_simple_driver(struct hidinput_simple_driver *device);
+
+/********************* The public section end ***********/
+#endif /* __HID_SIMPLE_H */

--------------090007090708070802090204--
