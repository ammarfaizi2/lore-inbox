Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161052AbWI2IVP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161052AbWI2IVP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 04:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161251AbWI2IVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 04:21:15 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:63181 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161052AbWI2IVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 04:21:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:x-mailer:mime-version:content-type;
        b=ODZnEcFjYDayyofrJufNzuupfcFdLljp90RgQFtAYypQhD5BItfmQzONZOgDmcf8B/YdXX5be2VSBEa9EIocYW6rYeenNbO4C/jiUyM9v7wVfhyDK8v/zEvWc2xq7KSmDdR/8IpInz6oS/3PLY+yLuZQfD/bgFQvtg+Bk3+UVLo=
Date: Fri, 29 Sep 2006 16:21:13 +0800
From: "raise.sail" <raise.sail@gmail.com>
To: "LKML" <linux-kernel@vger.kernel.org>,
       "linux-usb-devel" <linux-usb-devel@lists.sourceforge.net>,
       "greg" <greg@kroah.com>
Subject: [PATCH] usb/hid: The HID Simple Driver Interface 0.3.2 (core)
Message-ID: <200609291621094067925@gmail.com>
X-mailer: Foxmail 6, 5, 104, 21 [cn]
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=====001_Dragon115183436543_====="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--=====001_Dragon115183436543_=====
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit

Changelogs:

	1. A bugfix for clear usage process.

This driver requires:
	1.  [PATCH] usb: HID Simple Driver Interface 0.3.1 (Kconfig and Makefile), this patch can be used without any change.

PS:	Who is the maintainer of the input subsystem today? Should I forward this mail to him/her?

It can be applied on 2.6.18 at least. 

Signed-off-by: Liyu <raise.sail@gmail.com>

diff -Naurp linux-2.6.18/drivers/usb/input/hid-core.c linux-2.6.18/drivers/usb/input.new/hid-core.c
--- linux-2.6.18/drivers/usb/input/hid-core.c	2006-09-20 11:42:06.000000000 +0800
+++ linux-2.6.18/drivers/usb/input.new/hid-core.c	2006-09-28 09:30:47.000000000 +0800
@@ -26,6 +26,7 @@
 #include <asm/byteorder.h>
 #include <linux/input.h>
 #include <linux/wait.h>
+#include <linux/mutex.h>
 
 #undef DEBUG
 #undef DEBUG_DATA
@@ -33,6 +34,7 @@
 #include <linux/usb.h>
 
 #include "hid.h"
+#include "hid-simple.h"
 #include <linux/hiddev.h>
 
 /*
@@ -46,6 +48,15 @@
 
 static char *hid_types[] = {"Device", "Pointer", "Mouse", "Device", "Joystick",
 				"Gamepad", "Keyboard", "Keypad", "Multi-Axis Controller"};
+
+/*
+ * The global data structure for simple device driver interface.
+ */
+static DEFINE_MUTEX(matched_devices_lock);
+static DEFINE_MUTEX(simple_drivers_lock);
+static struct list_head matched_devices_list;
+static struct list_head simple_drivers_list;
+
 /*
  * Module parameters.
  */
@@ -785,8 +796,18 @@ static __inline__ int search(__s32 *arra
 static void hid_process_event(struct hid_device *hid, struct hid_field *field, struct hid_usage *usage, __s32 value, int interrupt, struct pt_regs *regs)
 {
 	hid_dump_input(usage, value);
-	if (hid->claimed & HID_CLAIMED_INPUT)
+	if (hid->claimed & HID_CLAIMED_INPUT) {
+		/* event filter here */
+		if (hid->simple) {
+			if (hid->simple->pre_event &&
+				!hid->simple->pre_event(hid, field, usage, 
+								value, regs))
+			return;
+		}
 		hidinput_hid_event(hid, field, usage, value, regs);
+		if (hid->simple && hid->simple->post_event)
+			hid->simple->post_event(hid, field, usage, value, regs);
+	}
 	if (hid->claimed & HID_CLAIMED_HIDDEV && interrupt)
 		hiddev_hid_event(hid, field, usage, value, regs);
 }
@@ -832,7 +853,6 @@ static void hid_input_field(struct hid_d
 			&& field->usage[field->value[n] - min].hid
 			&& search(value, field->value[n], count))
 				hid_process_event(hid, field, &field->usage[field->value[n] - min], 0, interrupt, regs);
-
 		if (value[n] >= min && value[n] <= max
 			&& field->usage[value[n] - min].hid
 			&& search(field->value, value[n], count))
@@ -2031,8 +2051,33 @@ static void hid_disconnect(struct usb_in
 	del_timer_sync(&hid->io_retry);
 	flush_scheduled_work();
 
-	if (hid->claimed & HID_CLAIMED_INPUT)
+	if (hid->claimed & HID_CLAIMED_INPUT) {
+		struct list_head *node;
+		struct matched_device *matched;
+
+		matched = NULL;
+		mutex_lock(&matched_devices_lock);
+		list_for_each(node, &matched_devices_list) {
+			matched = list_entry(node, struct matched_device, node);
+			if (matched->intf == intf) {
+				list_del(&matched->node);
+				break;
+			}
+			matched = NULL;
+		}
+		mutex_unlock(&matched_devices_lock);
+		/* disconnect simple device driver if need */
+		if (matched && hid->simple) {
+			hidinput_simple_driver_disconnect(hid);
+			module_put(hid->simple->owner);
+			hidinput_simple_driver_pop(hid, matched);
+		}
+		if (matched) {
+			matched->intf = NULL;
+			kfree(matched);
+		}
 		hidinput_disconnect(hid);
+	}
 	if (hid->claimed & HID_CLAIMED_HIDDEV)
 		hiddev_disconnect(hid);
 
@@ -2045,6 +2090,141 @@ static void hid_disconnect(struct usb_in
 	hid_free_device(hid);
 }
 
+#ifdef CONFIG_HID_SIMPLE
+static int hidinput_simple_driver_bind_one(struct hidinput_simple_driver *simple,
+							struct hid_device *hid,
+						struct matched_device *matched)
+{
+	int ret;
+
+	if (!try_module_get(simple->owner))
+		return -ENODEV;
+	ret = hidinput_simple_driver_connect(simple, hid);
+	if (ret)
+		goto exit_err;
+	ret = hidinput_simple_driver_push(hid, simple, matched);
+	if (ret)
+		goto exit_err;
+	hidinput_simple_driver_setup_usage(hid);
+	printk(KERN_INFO "The Simple HID driver \'%s\' attach on \'%s\'\n",
+						simple->name, hid->name);
+	goto exit;
+exit_err:
+	module_put(simple->owner);
+exit:
+	return ret;
+}
+
+static void hidinput_simple_driver_bind_foreach_simple(
+						struct matched_device *matched)
+{
+	struct hidinput_simple_driver *simple;
+	struct list_head *node;
+	struct hid_device *hid;
+	
+	if (!matched->intf)
+		return;
+	hid = usb_get_intfdata (matched->intf);
+	if (!hid || hid->simple)
+		return;
+
+	mutex_lock(&simple_drivers_lock);
+	list_for_each(node, &simple_drivers_list) {
+		simple = list_entry(node, struct hidinput_simple_driver, node);
+		if (test_bit(HIDINPUT_SIMPLE_CONNECTED, &simple->flags))
+			continue;
+		if (usb_match_id(matched->intf, simple->id_table)) {
+			hidinput_simple_driver_bind_one(simple, hid, matched);
+			break;
+		}
+	}
+	mutex_unlock(&simple_drivers_lock);
+}
+
+static void hidinput_simple_driver_bind_foreach(void)
+{
+	struct hidinput_simple_driver *simple;
+	struct matched_device *matched=NULL;
+	struct list_head *matched_node = NULL;
+	struct list_head *simple_node = NULL;
+	struct hid_device *hid=NULL;
+
+	mutex_lock(&matched_devices_lock);
+	list_for_each(matched_node, &matched_devices_list) {
+		matched = list_entry(matched_node, struct matched_device, node);
+		hid = usb_get_intfdata(matched->intf);
+		if (hid->simple)
+			continue;
+		mutex_lock(&simple_drivers_lock);
+		list_for_each(simple_node, &simple_drivers_list) {
+			simple = list_entry(simple_node, struct hidinput_simple_driver, node);
+
+			if (test_bit(HIDINPUT_SIMPLE_CONNECTED, &simple->flags))
+				continue;
+			if (!usb_match_id(matched->intf, simple->id_table))
+				continue;
+			hidinput_simple_driver_bind_one(simple, hid, matched);
+		}
+		mutex_unlock(&simple_drivers_lock);
+	}
+	mutex_unlock(&matched_devices_lock);
+}
+
+static void hidinput_simple_driver_bind_foreach_matched(
+					struct hidinput_simple_driver *simple)
+{
+	struct list_head *node=NULL;
+	struct matched_device *matched;
+	struct hid_device *hid=NULL;
+
+	if (!simple || test_bit(HIDINPUT_SIMPLE_CONNECTED, &simple->flags))
+		return;
+
+	mutex_lock(&matched_devices_lock);
+	list_for_each(node, &matched_devices_list) {
+		matched = list_entry(node, struct matched_device, node);
+		hid = usb_get_intfdata (matched->intf);
+		if (hid->simple)
+			continue;
+		if (!usb_match_id(matched->intf, simple->id_table))
+			continue;
+		hidinput_simple_driver_bind_one(simple, hid, matched);
+	}
+	mutex_unlock(&matched_devices_lock);
+}
+
+int hidinput_register_simple_driver(struct hidinput_simple_driver *simple)
+{
+	if (!simple || !simple->name)
+		return -EINVAL;
+
+	printk(KERN_INFO "The Simple HID driver \'%s\' register.\n", 
+								simple->name);
+	hidinput_simple_driver_init(simple);
+	hidinput_simple_driver_bind_foreach_matched(simple);
+
+	mutex_lock(&simple_drivers_lock);
+	list_add(&simple->node, &simple_drivers_list);
+	mutex_unlock(&simple_drivers_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hidinput_register_simple_driver);
+
+void hidinput_unregister_simple_driver(struct hidinput_simple_driver *simple)
+{
+	printk(KERN_INFO "The Simple HID driver \'%s\' unregister.\n", 
+							simple->name);
+	hidinput_simple_driver_clear(simple);
+	mutex_lock(&simple_drivers_lock);
+	list_del(&simple->node);
+	mutex_unlock(&simple_drivers_lock);
+	/* to active simple device driver that it is waiting */
+	hidinput_simple_driver_bind_foreach();
+}
+EXPORT_SYMBOL_GPL(hidinput_unregister_simple_driver);
+#endif
+
 static int hid_probe(struct usb_interface *intf, const struct usb_device_id *id)
 {
 	struct hid_device *hid;
@@ -2061,15 +2241,25 @@ static int hid_probe(struct usb_interfac
 	hid_init_reports(hid);
 	hid_dump_device(hid);
 
-	if (!hidinput_connect(hid))
+	usb_set_intfdata(intf, hid);
+
+	if (!hidinput_connect(hid)) {
+		struct matched_device *matched;
+		matched = kmalloc(sizeof(struct matched_device), GFP_KERNEL);
+		if (matched) {
+			matched->intf = intf;
+			mutex_lock(&matched_devices_lock);
+			list_add(&matched->node, &matched_devices_list);
+			mutex_unlock(&matched_devices_lock);
+			hidinput_simple_driver_bind_foreach_simple(matched);
+		}
 		hid->claimed |= HID_CLAIMED_INPUT;
+	}
 	if (!hiddev_connect(hid))
 		hid->claimed |= HID_CLAIMED_HIDDEV;
 
-	usb_set_intfdata(intf, hid);
-
 	if (!hid->claimed) {
-		printk ("HID device not claimed by input or hiddev\n");
+		printk (KERN_INFO "HID device not claimed by input or hiddev\n");
 		hid_disconnect(intf);
 		return -ENODEV;
 	}
@@ -2168,6 +2358,8 @@ static int __init hid_init(void)
 	retval = hiddev_init();
 	if (retval)
 		goto hiddev_init_fail;
+	INIT_LIST_HEAD(&matched_devices_list);
+	INIT_LIST_HEAD(&simple_drivers_list);
 	retval = usb_register(&hid_driver);
 	if (retval)
 		goto usb_register_fail;
@@ -2182,7 +2374,15 @@ hiddev_init_fail:
 
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
 
diff -Naurp linux-2.6.18/drivers/usb/input/hid.h linux-2.6.18/drivers/usb/input.new/hid.h
--- linux-2.6.18/drivers/usb/input/hid.h	2006-09-20 11:42:06.000000000 +0800
+++ linux-2.6.18/drivers/usb/input.new/hid.h	2006-09-28 09:28:15.000000000 +0800
@@ -389,8 +389,11 @@ struct hid_input {
 	struct list_head list;
 	struct hid_report *report;
 	struct input_dev *input;
+	void *private;
 };
 
+struct hidinput_simple_driver;
+
 struct hid_device {							/* device report descriptor */
 	 __u8 *rdesc;
 	unsigned rsize;
@@ -454,6 +457,8 @@ struct hid_device {							/* device repo
 	int (*ff_event)(struct hid_device *hid, struct input_dev *input,
 			unsigned int type, unsigned int code, int value);
 
+	struct hidinput_simple_driver *simple;
+
 #ifdef CONFIG_USB_HIDINPUT_POWERBOOK
 	unsigned long pb_pressed_fn[NBITS(KEY_MAX)];
 	unsigned long pb_pressed_numlock[NBITS(KEY_MAX)];
diff -Naurp linux-2.6.18/drivers/usb/input/hid-input.c linux-2.6.18/drivers/usb/input.new/hid-input.c
--- linux-2.6.18/drivers/usb/input/hid-input.c	2006-09-20 11:42:06.000000000 +0800
+++ linux-2.6.18/drivers/usb/input.new/hid-input.c	2006-09-28 09:28:15.000000000 +0800
@@ -34,7 +34,7 @@
 #undef DEBUG
 
 #include "hid.h"
-
+#include "hid-simple.h"
 #define unk	KEY_UNKNOWN
 
 static const unsigned char hid_keyboard[256] = {
@@ -61,6 +61,8 @@ static const struct {
 	__s32 y;
 }  hid_hat_to_axis[] = {{ 0, 0}, { 0,-1}, { 1,-1}, { 1, 0}, { 1, 1}, { 0, 1}, {-1, 1}, {-1, 0}, {-1,-1}};
 
+typedef void (*do_usage_t)(struct hid_field *, struct hid_usage *);
+
 #define map_abs(c)	do { usage->code = c; usage->type = EV_ABS; bit = input->absbit; max = ABS_MAX; } while (0)
 #define map_rel(c)	do { usage->code = c; usage->type = EV_REL; bit = input->relbit; max = REL_MAX; } while (0)
 #define map_key(c)	do { usage->code = c; usage->type = EV_KEY; bit = input->keybit; max = KEY_MAX; } while (0)
@@ -747,8 +749,13 @@ static int hidinput_input_event(struct i
 	struct hid_field *field;
 	int offset;
 
-	if (type == EV_FF)
+	if (type == EV_FF) {
+		if (hid->simple && hid->simple->ff_event) {
+			if (!hid->simple->ff_event(dev, type, code, value));
+				return 0;
+		}
 		return hid_ff_event(hid, dev, type, code, value);
+	}
 
 	if (type != EV_LED)
 		return -1;
@@ -767,12 +774,22 @@ static int hidinput_input_event(struct i
 static int hidinput_open(struct input_dev *dev)
 {
 	struct hid_device *hid = dev->private;
-	return hid_open(hid);
+	int ret = 0;
+
+	if (hid->simple && hid->simple->open)
+		ret = hid->simple->open(dev);
+	if (!ret)
+		return hid_open(hid);
+	else
+		return ret;
 }
 
 static void hidinput_close(struct input_dev *dev)
 {
 	struct hid_device *hid = dev->private;
+
+	if (hid->simple && hid->simple->close)
+		hid->simple->close(dev);
 	hid_close(hid);
 }
 
@@ -821,7 +838,7 @@ int hidinput_connect(struct hid_device *
 				input_dev->event = hidinput_input_event;
 				input_dev->open = hidinput_open;
 				input_dev->close = hidinput_close;
-
+				hidinput_simple_driver_ff_init(input_dev);
 				input_dev->name = hid->name;
 				input_dev->phys = hid->phys;
 				input_dev->uniq = hid->uniq;
diff -Naurp linux-2.6.18/drivers/usb/input/hid-simple.c linux-2.6.18/drivers/usb/input.new/hid-simple.c
--- linux-2.6.18/drivers/usb/input/hid-simple.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.18/drivers/usb/input.new/hid-simple.c	2006-09-29 09:22:38.000000000 +0800
@@ -0,0 +1,315 @@
+/*
+ *  HID Simple Driver Interface v0.3.2
+ * 
+ *  Copyright (c) 2006 Li Yu <raise.sail@gmail.com>
+ */
+
+/*
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
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ *
+ * Should you need to contact me, the author, you can do so either by
+ * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
+ * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
+ */
+
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/kernel.h>
+#include <linux/input.h>
+
+#include "hid.h"
+#include "hid-simple.h"
+
+typedef void (*do_usage_t)(struct hid_field *, struct hid_usage *);
+
+int hidinput_simple_driver_init(struct hidinput_simple_driver *drv)
+{
+	if (unlikely(!drv))
+		return -EINVAL;
+	INIT_LIST_HEAD(&drv->node);
+	INIT_LIST_HEAD(&drv->raw_devices);
+	drv->flags = 0;
+	return 0;
+}
+
+static void inline hidinput_simple_configure_one_usage(int op, 
+						struct input_dev *input,
+						struct hid_usage *usage,
+						struct usage_block *usage_block)
+{
+	unsigned long *bits;
+	int flag;
+	struct hid_device *hid;
+
+	hid = input->private;
+	switch (usage_block->event) {
+	case EV_KEY:
+		flag = HIDINPUT_SIMPLE_KEYBIT;
+		bits = input->keybit;
+		break;
+	case EV_REL:
+		flag = HIDINPUT_SIMPLE_RELBIT;
+		bits = input->relbit;
+		break;
+	case EV_ABS:
+		flag = HIDINPUT_SIMPLE_ABSBIT;
+		bits = input->relbit;
+		break;
+	case EV_MSC:
+		flag = HIDINPUT_SIMPLE_MSCBIT;
+		bits = input->absbit;
+		break;
+	case EV_SW:
+		flag = HIDINPUT_SIMPLE_SWBIT;
+		bits = input->swbit;
+		break;
+	case EV_LED:
+		flag = HIDINPUT_SIMPLE_LEDBIT;
+		bits = input->ledbit;
+		break;
+	case EV_SND:
+		flag = HIDINPUT_SIMPLE_SNDBIT;
+		bits = input->sndbit;
+		break;
+	case EV_FF:
+		flag = HIDINPUT_SIMPLE_FFBIT;
+		bits = input->ffbit;
+		break;
+	case EV_FF_STATUS:
+		flag = HIDINPUT_SIMPLE_FFSTSBIT;
+		bits = NULL;
+		break;
+	default:
+		return;
+	}
+
+	if (__OP_SET_BIT == op) {
+		usage->code = usage_block->code;
+		usage->type = usage_block->event;
+		if (bits)
+			set_bit(usage_block->code, bits);
+		/* if this event bit is set by us first, remember it */
+		if (!test_and_set_bit(usage_block->event, input->evbit))
+			set_bit(flag, &hid->simple->flags);
+	}
+	else if (__OP_CLR_BIT == op) {
+		usage->code = 0;
+		usage->type = 0;
+		if (bits)
+			clear_bit(usage_block->code, bits);
+		/* clear event bit, only if it's set by us. */
+		if (test_and_clear_bit(flag, &hid->simple->flags))
+			clear_bit(usage_block->event, input->evbit);
+	}
+}
+
+static do_usage_t hidinput_simple_driver_configure_usage_prep(
+							struct hid_device *hid,
+							int *op)
+{
+	do_usage_t do_usage;
+
+	if (!hid->simple)
+		return NULL;
+
+	if (test_bit(HIDINPUT_SIMPLE_SETUP_USAGE, &hid->simple->flags)) {
+		do_usage = hid->simple->setup_usage;
+		*op = __OP_SET_BIT;
+	}
+	else {
+		do_usage = hid->simple->clear_usage;
+		*op = __OP_CLR_BIT;
+	}
+	return do_usage;
+}
+
+static void __hidinput_simple_driver_configure_usage(int op,
+						struct hid_field *field,
+						struct hid_usage *hid_usage)
+{
+	struct input_dev *input = field->hidinput->input;
+	struct hid_device *hid = input->private;
+	struct usage_block *usage_block;
+	struct usage_page_block *page_block;
+	int page;
+	int usage;
+
+	page = (hid_usage->hid & HID_USAGE_PAGE);
+	usage = (hid_usage->hid & HID_USAGE);
+	page_block = hid->simple->usage_page_table;
+	for (;page_block && page_block->usage_blockes;page_block++) {
+		if (page_block->page != page)
+			continue;
+		usage_block = page_block->usage_blockes;
+		for (; usage_block && usage_block->usage; usage_block++) {
+			if (usage_block->usage != usage)
+				continue;
+			hidinput_simple_configure_one_usage(op, input, 
+						hid_usage, usage_block);
+		}
+	}
+}
+
+/*
+ *  To give one simple device a configure usage chance.
+ *  The framework of this function come from hidinput_connect()
+ */
+void hidinput_simple_driver_configure_usage(struct hid_device *hid)
+{
+	struct hid_report *report;
+	int i, j, k;
+	do_usage_t do_usage;
+	int op;
+
+	if (!hid->simple)
+		return;
+	do_usage = hidinput_simple_driver_configure_usage_prep(hid, &op);
+
+	for (i = 0; i < hid->maxcollection; i++)
+		if (hid->collection[i].type == HID_COLLECTION_APPLICATION ||
+			hid->collection[i].type==HID_COLLECTION_PHYSICAL)
+			if (IS_INPUT_APPLICATION(hid->collection[i].usage))
+				break;
+
+	if (i == hid->maxcollection)
+		return;
+
+	for (k = HID_INPUT_REPORT; k <= HID_OUTPUT_REPORT; k++)
+		list_for_each_entry(report, &hid->report_enum[k].report_list, list) {
+			if (!report->maxfield)
+				continue;
+
+			for (i = 0; i < report->maxfield; i++)
+				for (j = 0; j < report->field[i]->maxusage; j++) {
+					__hidinput_simple_driver_configure_usage(op, report->field[i], report->field[i]->usage + j);
+					if (do_usage)
+						do_usage(report->field[i],
+						report->field[i]->usage + j);
+				}
+		}
+
+	return;
+}
+
+int hidinput_simple_driver_push(struct hid_device *hid, 
+					struct hidinput_simple_driver *simple,
+					struct matched_device *matched)
+{
+	struct raw_simple_device *raw_simple;
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
+void hidinput_simple_driver_pop(struct hid_device *hid,
+					struct matched_device *matched)
+{
+	struct list_head *node;
+	struct raw_simple_device *raw_simple=NULL;
+
+	list_for_each (node, &hid->simple->raw_devices) {
+		raw_simple = list_entry(node, struct raw_simple_device, node);
+		if (raw_simple && raw_simple->intf == matched->intf) {
+			hid->simple = NULL;
+			list_del(&raw_simple->node);
+			kfree(raw_simple);
+			return;
+		}
+	}
+}
+
+void hidinput_simple_driver_clear(struct hidinput_simple_driver *simple)
+{
+	struct raw_simple_device *raw_simple;
+	struct hid_device *hid;
+
+	while (!list_empty_careful(&simple->raw_devices)) {
+		raw_simple = list_entry(simple->raw_devices.next, 
+					struct raw_simple_device, node);
+		hid = usb_get_intfdata (raw_simple->intf);
+		if (hid) {
+			if (hid->simple)
+				BUG_ON(hid->simple != simple);
+			hidinput_simple_driver_clear_usage(hid);
+			wmb();
+			hidinput_simple_driver_disconnect(hid);
+			hid->simple = NULL;
+		}
+		list_del_init(simple->raw_devices.next);
+	}
+}
+
+int hidinput_simple_driver_connect(struct hidinput_simple_driver *simple, 
+						struct hid_device *hid)
+{
+	struct hid_input *hidinput, *next;
+	int ret = -ENODEV;
+
+	if (!simple)
+		goto exit;
+	if (!simple->connect) {
+		ret = 0;
+		goto exit;
+	}
+
+	list_for_each_entry_safe(hidinput, next, &hid->inputs, list) {
+		if (!simple->connect(hid, hidinput)) {
+			hid->simple = simple;
+			ret = 0;
+		}
+	}
+exit:
+	set_bit(HIDINPUT_SIMPLE_CONNECTED, &simple->flags);
+	return ret;
+}
+
+
+void hidinput_simple_driver_disconnect(struct hid_device *hid)
+{
+	struct hid_input *hidinput, *next;
+
+	if (!hid || !hid->simple)
+		return;
+
+	if (!hid->simple->disconnect)
+		goto exit;
+	list_for_each_entry_safe(hidinput, next, &hid->inputs, list) {
+		hid->simple->disconnect(hid, hidinput);
+	}
+exit:
+	clear_bit(HIDINPUT_SIMPLE_CONNECTED, &hid->simple->flags);
+	return;
+}
+
+struct hid_input* hidinput_simple_inputdev_to_hidinput(struct input_dev *dev)
+{
+	struct hid_device *hid = dev->private;
+	struct list_head *iter;
+	struct hid_input *hidinput;
+
+	list_for_each(iter, &hid->inputs) {
+		hidinput = list_entry(iter, struct hid_input, list);
+		if (hidinput->input == dev)
+			return hidinput;
+	}
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(hidinput_simple_inputdev_to_hidinput);
diff -Naurp linux-2.6.18/drivers/usb/input/hid-simple.h linux-2.6.18/drivers/usb/input.new/hid-simple.h
--- linux-2.6.18/drivers/usb/input/hid-simple.h	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.18/drivers/usb/input.new/hid-simple.h	2006-09-28 09:28:15.000000000 +0800
@@ -0,0 +1,232 @@
+/*
+ *  NOTE:
+ *	For use me , you must include hid.h in your source first. 
+ */
+#ifndef __HID_SIMPLE_H
+#define __HID_SIMPLE_H
+
+#ifdef __KERNEL__
+
+#include <linux/usb.h>
+
+/***** The public interface for simple device driver *****/
+struct usage_block {
+	int usage; /* usage code */
+	int value; /* not used, for F_EVENT_BY_VALUE in future  */
+	int event; /* input event type, e.g. EV_KEY. */
+	int code;  /* input subsystem code, e.g. KEY_F1. */
+	int flags; /* not used */
+};
+
+struct usage_page_block {
+	int page; /* usage page code */
+	int flags; /* not used */
+	struct usage_block *usage_blockes;
+};
+
+/* usage_block flags list */
+#define F_EVENT_BY_VALUE (0x1) /* submit input event by usage_block.value, 
+				  not implement yet */
+
+#define USAGE_BLOCK(i_usage, i_value, i_event, i_code, i_flags) \
+	{\
+		.usage = (i_usage),\
+		.value = (i_value),\
+		.event = (i_event),\
+		.code = (i_code),\
+		.flags = (i_flags),\
+	}
+
+#define USAGE_BLOCK_NULL {}
+
+#define USAGE_PAGE_BLOCK(i_page, i_usage_blockes) \
+	{\
+		.page = (i_page),\
+		.usage_blockes = (i_usage_blockes),\
+	}
+
+#define USAGE_PAGE_BLOCK_NULL {}
+
+#define __SIMPLE_DRIVER_INIT \
+	.owner = THIS_MODULE,
+
+struct hidinput_simple_driver {
+/* private */
+	struct list_head node; /* link with simple_drivers_list */
+	struct list_head raw_devices;
+	unsigned long flags;
+/* public */
+	struct module *owner;
+	char *name;
+	int (*connect)(struct hid_device *, struct hid_input *);	
+	void (*disconnect)(struct hid_device *, struct hid_input *);
+	void (*setup_usage)(struct hid_field *,   struct hid_usage *);
+	void (*clear_usage)(struct hid_field *,   struct hid_usage *);
+	int (*pre_event)(const struct hid_device *, const struct hid_field *,
+					const struct hid_usage *, const __s32,
+					const struct pt_regs *regs);
+	int (*post_event)(const struct hid_device *, const struct hid_field *,
+					const struct hid_usage *, const __s32,
+					const struct pt_regs *regs);
+	int (*open)(struct input_dev *dev);
+	void (*close)(struct input_dev *dev);
+        int (*upload_effect)(struct input_dev *dev, struct ff_effect *effect);
+        int (*erase_effect)(struct input_dev *dev, int effect_id);
+	int (*flush)(struct input_dev *dev, struct file *file);
+	int (*ff_event)(struct input_dev *dev, int type, int code, int value);
+	struct usb_device_id *id_table;
+	struct usage_page_block *usage_page_table;
+	void *private;
+};
+
+
+int hidinput_register_simple_driver(struct hidinput_simple_driver *device);
+void hidinput_unregister_simple_driver(struct hidinput_simple_driver *device);
+struct hid_input* hidinput_simple_inputdev_to_hidinput(struct input_dev *dev);
+
+/********************* The public section end ***********/
+
+/***** The private section for simple device driver implement only *****/
+
+/* simple driver internal flags */
+#define HIDINPUT_SIMPLE_SETUP_USAGE	(0x0)
+#define HIDINPUT_SIMPLE_KEYBIT	(0x1)
+#define HIDINPUT_SIMPLE_RELBIT	(0x2)
+#define HIDINPUT_SIMPLE_ABSBIT	(0x3)
+#define HIDINPUT_SIMPLE_MSCBIT	(0x4)
+#define HIDINPUT_SIMPLE_SWBIT	(0x5)
+#define HIDINPUT_SIMPLE_LEDBIT	(0x6)
+#define HIDINPUT_SIMPLE_SNDBIT	(0x7)
+#define HIDINPUT_SIMPLE_FFBIT	(0x8)
+#define HIDINPUT_SIMPLE_FFSTSBIT	(0x9)
+#define HIDINPUT_SIMPLE_CONNECTED	(0x1f)
+
+/* used in hidinput_simple_driver_configure_usage() */
+#define __OP_SET_BIT (1)
+#define __OP_CLR_BIT (0)
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
+#ifdef CONFIG_HID_SIMPLE
+extern void hidinput_simple_driver_configure_usage(struct hid_device *hid);
+extern int hidinput_simple_driver_init(struct hidinput_simple_driver *simple);
+extern int hidinput_simple_driver_push(struct hid_device *hid,
+				struct hidinput_simple_driver *simple,
+				struct matched_device *dev);
+extern void hidinput_simple_driver_pop(struct hid_device *hid,
+				struct matched_device *dev);
+extern void hidinput_simple_driver_clear(struct hidinput_simple_driver *simple);
+extern int hidinput_simple_driver_connect(struct hidinput_simple_driver *simple, 
+							struct hid_device *hid);
+extern void hidinput_simple_driver_disconnect(struct hid_device *hid);
+static void inline hidinput_simple_driver_setup_usage(struct hid_device *hid)
+{
+	if (hid && hid->simple) {
+		set_bit(HIDINPUT_SIMPLE_SETUP_USAGE, &hid->simple->flags);
+		hidinput_simple_driver_configure_usage(hid);
+	}
+}
+
+static void inline hidinput_simple_driver_clear_usage(struct hid_device *hid)
+{
+	if (hid && hid->simple) {
+		clear_bit(HIDINPUT_SIMPLE_SETUP_USAGE, &hid->simple->flags);
+		hidinput_simple_driver_configure_usage(hid);
+	}
+}
+
+#ifdef CONFIG_HID_SIMPLE_FF
+static inline int hidinput_upload_effect(struct input_dev *dev,
+						struct ff_effect *effect)
+{
+	struct hid_device *hid;
+
+	hid = dev->private;
+	if (hid->simple && hid->simple->upload_effect)
+		return hid->simple->upload_effect(dev, effect);
+	return 0;
+}
+
+static inline int hidinput_erase_effect(struct input_dev *dev, int effect_id)
+{
+	struct hid_device *hid;
+
+	hid = dev->private;
+	if (hid->simple && hid->simple->erase_effect)
+		return hid->simple->erase_effect(dev, effect_id);
+	return 0;
+}
+
+static inline int hidinput_flush(struct input_dev *dev, struct file *filep)
+{
+	struct hid_device *hid;
+
+	hid = dev->private;
+	if (hid->simple && hid->simple->flush)
+		return hid->simple->flush(dev, filep);
+	return 0;
+}
+
+static void inline hidinput_simple_driver_ff_init(struct input_dev *input_dev)
+{
+	input_dev->upload_effect = hidinput_upload_effect;
+	input_dev->erase_effect = hidinput_erase_effect;
+	input_dev->flush = hidinput_flush;
+}
+#else /* CONFIG_HID_SIMPLE_FF */
+static void inline hidinput_simple_driver_ff_init(struct input_dev *input_dev) {}
+#endif /* CONFIG_HID_SIMPLE_FF */
+#else /* CONFIG_HID_SIMPLE */
+static inline void hidinput_simple_driver_bind_foreach_simple(
+					struct matched_device *matched) {}
+static inline void hidinput_simple_driver_configure_usage(struct hid_device *hid)
+{}
+static inline int hidinput_simple_driver_init(struct hidinput_simple_driver *simple)
+{
+	return 0;
+}
+static inline int hidinput_simple_driver_push(struct hid_device *hid,
+				struct hidinput_simple_driver *simple,
+				struct matched_device *dev)
+{
+	return 0;
+}
+static inline void hidinput_simple_driver_pop(struct hid_device *hid,
+				struct matched_device *dev) {}
+static inline void hidinput_simple_driver_clear(
+				struct hidinput_simple_driver *simple) {}
+static inline int hidinput_simple_driver_connect(
+				struct hidinput_simple_driver *simple, 
+				struct hid_device *hid)
+{
+	return 0;
+}
+static inline void hidinput_simple_driver_disconnect(struct hid_device *hid) {}
+static inline void hidinput_simple_driver_setup_usage(struct hid_device *hid) {}
+static inline void hidinput_simple_driver_clear_usage(struct hid_device *hid) {}
+static void inline hidinput_simple_driver_ff_init(struct input_dev *input_dev) {}
+#endif
+
+/***** The private section end.  *****/
+#endif /* __KERNEL__ */
+#endif /* __HID_SIMPLE_H */
--=====001_Dragon115183436543_=====
Content-Type: application/octet-stream;
	name="all-in-one.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="all-in-one.patch"

ZGlmZiAtTmF1cnAgbGludXgtMi42LjE4L2RyaXZlcnMvdXNiL2lucHV0L2J0cDIxMTguYyBsaW51
eC0yLjYuMTgvZHJpdmVycy91c2IvaW5wdXQubmV3L2J0cDIxMTguYwotLS0gbGludXgtMi42LjE4
L2RyaXZlcnMvdXNiL2lucHV0L2J0cDIxMTguYwkxOTcwLTAxLTAxIDA4OjAwOjAwLjAwMDAwMDAw
MCArMDgwMAorKysgbGludXgtMi42LjE4L2RyaXZlcnMvdXNiL2lucHV0Lm5ldy9idHAyMTE4LmMJ
MjAwNi0wOS0yOCAwOToyODoxNS4wMDAwMDAwMDAgKzA4MDAKQEAgLTAsMCArMSw0MzQgQEAKKy8q
CisgKiAgQmV0b3AgQlRQLTIxMTggam95c3RpY2sgZm9yY2UtZmVlZGJhY2sgZHJpdmVyCisgKgor
ICogIFZlcnNpb246CTAuMS4wCisgKgorICogIENvcHlyaWdodCAoYykgMjAwNiBMaSBZdSA8cmFp
c2Uuc2FpbEBnbWFpbC5jb20+CisgKi8KKworLyoKKyAqIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNv
ZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5IGl0CisgKiB1bmRl
ciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hl
ZCBieSB0aGUgRnJlZQorICogU29mdHdhcmUgRm91bmRhdGlvbjsgZWl0aGVyIHZlcnNpb24gMiBv
ZiB0aGUgTGljZW5zZSwgb3IgKGF0IHlvdXIgb3B0aW9uKQorICogYW55IGxhdGVyIHZlcnNpb24u
CisgKi8KKworI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPgorI2luY2x1ZGUgPGxpbnV4L2lucHV0
Lmg+CisjaW5jbHVkZSA8bGludXgvc3BpbmxvY2suaD4KKyNpbmNsdWRlIDxsaW51eC90aW1lci5o
PgorI2luY2x1ZGUgPGxpbnV4L3NjaGVkLmg+CisjaW5jbHVkZSAiaGlkLmgiCisjaW5jbHVkZSAi
aGlkLXNpbXBsZS5oIgorCisjZGVmaW5lIFVTQl9JRF9WRU5ET1IJMHgxMmJkCisjZGVmaW5lIFVT
Ql9JRF9QUk9EVUNUCTB4YzAwMworCisjZGVmaW5lIFVTQUdFX1BBR0VfQlRQX0ZGCTB4MDA4YzAw
MDAgLyogQmFyIENvZGUgU2Nhbm5lciA/ICovCisjZGVmaW5lIFVTQUdFX0JUUF9GRgkweDAwMDIK
KworI2RlZmluZSBCVFBfRUZGRUNUX05PTkUJKC0xKQorCisvKiB1c2JfYnRwX2luZm8tPmZsYWdz
IGxpc3QgKi8KKyNkZWZpbmUgQlRQX0RJU0NPTk5FQ1RJTkcJMAorI2RlZmluZSBCVFBfVVJCX0RP
TkUJCTEKKyNkZWZpbmUgQlRQX0JVU1kJCTIJLyogYXZvaWQgdG8gcmVzZW5kIHVyYiAqLworCisj
ZGVmaW5lIElTX0JUUF9ESVNDT05ORUNUSU5HKGluZm8pICh0ZXN0X2JpdChCVFBfRElTQ09OTkVD
VElORywgJihpbmZvKS0+ZmxhZ3MpKQorI2RlZmluZSBJU19CVFBfVVJCX0RPTkUoaW5mbykgXAor
CSh0ZXN0X2JpdChCVFBfVVJCX0RPTkV8QlRQX0RJU0NPTk5FQ1RJTkcsICYoaW5mbyktPmZsYWdz
KSkKKyNkZWZpbmUgSVNfQlRQX0JVU1koaW5mbykgKHRlc3RfYml0KEJUUF9CVVNZLCAmKGluZm8p
LT5mbGFncykpCisKKyNkZWZpbmUgQlRQX1NFVF9ESVNDT05ORUNUSU5HKGluZm8pIChzZXRfYml0
KEJUUF9ESVNDT05ORUNUSU5HLCAmKGluZm8pLT5mbGFncykpCisjZGVmaW5lIEJUUF9TRVRfVVJC
X0RPTkUoaW5mbykgKHNldF9iaXQoQlRQX1VSQl9ET05FLCAmKGluZm8pLT5mbGFncykpCisjZGVm
aW5lIEJUUF9TRVRfQlVTWShpbmZvKQkoc2V0X2JpdChCVFBfQlVTWSwgJihpbmZvKS0+ZmxhZ3Mp
KQorCisjZGVmaW5lIEJUUF9DTFJfQlVTWShpbmZvKQkoY2xlYXJfYml0KEJUUF9CVVNZLCAmKGlu
Zm8pLT5mbGFncykpCisKK3N0YXRpYyBzcGlubG9ja190IGJ0cF9sb2NrOworCitzdHJ1Y3QgdXNi
X2J0cF9pbmZvIHsKKwlzdHJ1Y3QgdGltZXJfbGlzdCB0aW1lcjsKKwl1bnNpZ25lZCBsb25nIGZs
YWdzOworCS8qIGRlZmF1bHQgc2hvY2sgc3RyZW5ndGggKi8KKwl1bnNpZ25lZCBjaGFyIGxlZnRf
c3RyZW5ndGg7CisJdW5zaWduZWQgY2hhciByaWdodF9zdHJlbmd0aDsKKwl1bnNpZ25lZCBjaGFy
IHN0YXJ0X3BhY2tldFs4XTsKKwl1bnNpZ25lZCBjaGFyIHN0b3BfcGFja2V0WzhdOworCS8qIGZm
IGRhdGEgKi8KKwlzdHJ1Y3QgZmZfZWZmZWN0CWVmZmVjdHNbOF07CisJaW50IHJ1bm5pbmdfZWZm
ZWN0OworCWludCByZXBlYXQ7CisJLyogdXNiIGRhdGEgKi8KKwlzdHJ1Y3QgdXNiX2N0cmxyZXF1
ZXN0IHJlcTsKKwlzdHJ1Y3QgdXNiX2RldmljZSAqZGV2OworCXN0cnVjdCB1cmIgKmN0cmwwOwkK
Kwl1bnNpZ25lZCBpbnQgcGlwZTA7CisJaW50IHRpbWVvdXQ7Cit9OworCitzdGF0aWMgc3RydWN0
IHVzYl9kZXZpY2VfaWQgYnRwX2lkX3RhYmxlW10gPSB7CisJeworCQlVU0JfREVWSUNFKFVTQl9J
RF9WRU5ET1IsIFVTQl9JRF9QUk9EVUNUKQorCX0sCisJe30KK307CisKK01PRFVMRV9ERVZJQ0Vf
VEFCTEUodXNiLCBidHBfaWRfdGFibGUpOworCitzdGF0aWMgY2hhciBkcml2ZXJfbmFtZVtdID0g
IkJFVE9QIFZpYnJhdGlvbiBHYW1lcGFkIChCVFAtMjExOCkgRHJpdmVyIjsKKworLyogVGhpcyBn
YW1lcGFkIHJlcG9ydHMgdGhyZWUgdXNhZ2VzLCBidXQgYWxsIGFyZSBzYW1lLiAqLworc3RhdGlj
IHN0cnVjdCB1c2FnZV9ibG9jayBidHBfZmZfdXNhZ2VfYmxvY2tbXSA9IHsKKwlVU0FHRV9CTE9D
SyhVU0FHRV9CVFBfRkYsIDAsIEVWX0ZGLCBGRl9HQUlOLCAwKSwKKwlVU0FHRV9CTE9DSyhVU0FH
RV9CVFBfRkYsIDAsIEVWX0ZGLCBGRl9SVU1CTEUsIDApLAorCVVTQUdFX0JMT0NLKFVTQUdFX0JU
UF9GRiwgMCwgRVZfRkYsIEZGX0NPTlNUQU5ULCAwKSwKKwlVU0FHRV9CTE9DSyhVU0FHRV9CVFBf
RkYsIDAsIEVWX0ZGLCBGRl9TUFJJTkcsIDApLAorCVVTQUdFX0JMT0NLKFVTQUdFX0JUUF9GRiwg
MCwgRVZfRkYsIEZGX0ZSSUNUSU9OLCAwKSwKKwlVU0FHRV9CTE9DSyhVU0FHRV9CVFBfRkYsIDAs
IEVWX0ZGLCBGRl9EQU1QRVIsIDApLAorCVVTQUdFX0JMT0NLKFVTQUdFX0JUUF9GRiwgMCwgRVZf
RkYsIEZGX0lORVJUSUEsIDApLAorCVVTQUdFX0JMT0NLKFVTQUdFX0JUUF9GRiwgMCwgRVZfRkYs
IEZGX1JBTVAsIDApLAorCVVTQUdFX0JMT0NLKFVTQUdFX0JUUF9GRiwgMCwgRVZfRkZfU1RBVFVT
LCBGRl9TVEFUVVNfU1RPUFBFRCwgMCksCisJVVNBR0VfQkxPQ0soVVNBR0VfQlRQX0ZGLCAwLCBF
Vl9GRl9TVEFUVVMsIEZGX1NUQVRVU19QTEFZSU5HLCAwKSwKKwlVU0FHRV9CTE9DS19OVUxMCit9
OworCitzdGF0aWMgc3RydWN0IHVzYWdlX3BhZ2VfYmxvY2sgYnRwX2ZmX3VzYWdlX3BhZ2VfYmxv
Y2tlc1tdID0geworCVVTQUdFX1BBR0VfQkxPQ0soVVNBR0VfUEFHRV9CVFBfRkYsIGJ0cF9mZl91
c2FnZV9ibG9jayksCisJVVNBR0VfUEFHRV9CTE9DS19OVUxMCit9OworCisvKiB1c2JfY29tcGxl
dGVfdCAqLworc3RhdGljIHZvaWQgdXJiX2NvbXBsZXRlKHN0cnVjdCB1cmIgKnVyYiwgc3RydWN0
IHB0X3JlZ3MgKnJlZ3MpCit7CisJc3RydWN0IHVzYl9idHBfaW5mbyAqaW5mbyA9IHVyYi0+Y29u
dGV4dDsKKwkKKwl1c2JfdW5saW5rX3VyYih1cmIpOworCWlmIChJU19CVFBfRElTQ09OTkVDVElO
RyhpbmZvKSkKKwkJQlRQX1NFVF9VUkJfRE9ORShpbmZvKTsKKwlCVFBfQ0xSX0JVU1koaW5mbyk7
Cit9CisKK3N0YXRpYyBpbnQgaW5saW5lIGJ0cF9lZmZlY3RfcmVxdWVzdChzdHJ1Y3QgdXNiX2J0
cF9pbmZvICppbmZvLCBjaGFyICpwYWNrZXQpCit7CisJaWYgKElTX0JUUF9CVVNZKGluZm8pKQor
CQlyZXR1cm4gLUVCVVNZOworCisJdXNiX2ZpbGxfY29udHJvbF91cmIgKGluZm8tPmN0cmwwLCBp
bmZvLT5kZXYsIGluZm8tPnBpcGUwLAorCQkJCQkJCShjaGFyKikmaW5mby0+cmVxLAorCQkJCQkJ
CXBhY2tldCwKKwkJCQkJCQlpbmZvLT5yZXEud0xlbmd0aCwKKwkJCQkJCQl1cmJfY29tcGxldGUs
CisJCSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbmZvKTsKKwlCVFBf
U0VUX0JVU1koaW5mbyk7CisJdXNiX3N1Ym1pdF91cmIoaW5mby0+Y3RybDAsIEdGUF9BVE9NSUMp
OworCXJldHVybiAwOworfQorCisvKiBydW4gYnkgdXNiX2J0cF9pbmZvLT50aW1lciAqLworc3Rh
dGljIHZvaWQgYnRwX2VmZmVjdF9yZXBlYXQodW5zaWduZWQgbG9uZyBkYXRhKQoreworCXN0cnVj
dCB1c2JfYnRwX2luZm8gKmluZm8gPSAoc3RydWN0IHVzYl9idHBfaW5mbyopZGF0YTsKKworCWlm
IChJU19CVFBfRElTQ09OTkVDVElORyhpbmZvKSkKKwkJcmV0dXJuOworCisJc3Bpbl9sb2NrKCZi
dHBfbG9jayk7CisJaWYgKCFpbmZvLT5yZXBlYXQpIHsKKwkJaW5mby0+cnVubmluZ19lZmZlY3Qg
PSBCVFBfRUZGRUNUX05PTkU7CisJfSBlbHNlIHsKKwkJbW9kX3RpbWVyKCZpbmZvLT50aW1lciwg
amlmZmllcys0KkhaKTsKKwkJQlRQX0NMUl9CVVNZKGluZm8pOworCQlidHBfZWZmZWN0X3JlcXVl
c3QoaW5mbywgaW5mby0+c3RhcnRfcGFja2V0KTsKKwkJLS1pbmZvLT5yZXBlYXQ7CisJfQorCXNw
aW5fdW5sb2NrKCZidHBfbG9jayk7Cit9CisKKy8qIHRoZSBjYWxsZXIgbXVzdCBob2xkIGJ0cF9s
b2NrIGZpcnN0ICovCitzdGF0aWMgaW50IGJ0cF9lZmZlY3Rfc3RhcnQoc3RydWN0IGhpZF9pbnB1
dCAqaGlkaW5wdXQpCit7CisJc3RydWN0IHVzYl9idHBfaW5mbyAqaW5mbzsKKworCWluZm8gPSBo
aWRpbnB1dC0+cHJpdmF0ZTsKKwlpZiAoaW5mbykKKwkJcmV0dXJuIGJ0cF9lZmZlY3RfcmVxdWVz
dChpbmZvLCBpbmZvLT5zdGFydF9wYWNrZXQpOworCXJldHVybiAtRU5PREVWOworfQorCisvKiB0
aGUgY2FsbGVyIG11c3QgaG9sZCBidHBfbG9jayBmaXJzdCAqLworc3RhdGljIGludCBidHBfZWZm
ZWN0X3N0b3Aoc3RydWN0IGhpZF9pbnB1dCAqaGlkaW5wdXQpCit7CisJc3RydWN0IHVzYl9idHBf
aW5mbyAqaW5mbzsKKworCWluZm8gPSBoaWRpbnB1dC0+cHJpdmF0ZTsKKwlpZiAoaW5mbykKKwkJ
cmV0dXJuIGJ0cF9lZmZlY3RfcmVxdWVzdChpbmZvLCBpbmZvLT5zdG9wX3BhY2tldCk7CisJcmV0
dXJuIC1FTk9ERVY7Cit9CisKK3N0YXRpYyBpbnQgYnRwX2Nvbm5lY3Qoc3RydWN0IGhpZF9kZXZp
Y2UgKmhpZCwgc3RydWN0IGhpZF9pbnB1dCAqaGlkaW5wdXQpCit7CisJc3RydWN0IHVzYl9idHBf
aW5mbyAqaW5mbzsKKwkKKwlpbmZvID0ga3phbGxvYyhzaXplb2Yoc3RydWN0IHVzYl9idHBfaW5m
byksIEdGUF9LRVJORUwpOworCWlmICghaW5mbykKKwkJcmV0dXJuIC1FTk9NRU07CQorCWluZm8t
PmN0cmwwID0gdXNiX2FsbG9jX3VyYigwLCBHRlBfS0VSTkVMKTsKKwlpZiAoIWluZm8tPmN0cmww
KSB7CisJCWtmcmVlKGluZm8pOworCQlyZXR1cm4gLUVOT01FTTsKKwl9CisJLyogQmV0b3AtMjEx
OCBqb3lzdGljayBkZWZhdWx0IHBhcmFtZXRlciAqLworCWluZm8tPmxlZnRfc3RyZW5ndGggPSAn
XHgxNCc7CisJaW5mby0+cmlnaHRfc3RyZW5ndGggPSAnXHgxNCc7CisJaW5mby0+cmVxLmJSZXF1
ZXN0ID0gMHg5OworCWluZm8tPnJlcS5iUmVxdWVzdFR5cGUgPSAoVVNCX1RZUEVfQ0xBU1N8VVNC
X1JFQ0lQX0lOVEVSRkFDRSk7CisJaW5mby0+cmVxLndJbmRleCA9IDB4MDsKKwlpbmZvLT5yZXEu
d1ZhbHVlID0gMHgyMDA7CisJaW5mby0+cmVxLndMZW5ndGggPSAweDM7CisJaW5mby0+dGltZW91
dCA9IFVTQl9DVFJMX1NFVF9USU1FT1VUOworCWluZm8tPmRldiA9IGhpZC0+ZGV2OworCWluZm8t
PnBpcGUwID0gdXNiX3NuZGN0cmxwaXBlKGhpZC0+ZGV2LCAwKTsKKwlpbmZvLT5zdGFydF9wYWNr
ZXRbMF0gPSBpbmZvLT5sZWZ0X3N0cmVuZ3RoOworCWluZm8tPnN0YXJ0X3BhY2tldFsxXSA9IGlu
Zm8tPnJpZ2h0X3N0cmVuZ3RoOworCWluZm8tPnJ1bm5pbmdfZWZmZWN0ID0gQlRQX0VGRkVDVF9O
T05FOworCWluaXRfdGltZXIoJmluZm8tPnRpbWVyKTsKKwlpbmZvLT50aW1lci5kYXRhID0gKHVu
c2lnbmVkIGxvbmcpaW5mbzsKKwlpbmZvLT50aW1lci5mdW5jdGlvbiA9IGJ0cF9lZmZlY3RfcmVw
ZWF0OworCWhpZGlucHV0LT5wcml2YXRlID0gaW5mbzsKKwlzcGluX2xvY2tfaW5pdCgmYnRwX2xv
Y2spOworCXJldHVybiAwOworfQorCitzdGF0aWMgdm9pZCBpbmxpbmUgYnRwX3dhaXRfZm9yX2Vm
ZmVjdChzdHJ1Y3QgdXNiX2J0cF9pbmZvICppbmZvKQoreworCXdoaWxlICggaW5mby0+ZmxhZ3Mg
JiYgIUlTX0JUUF9VUkJfRE9ORShpbmZvKSApCisJCXNjaGVkdWxlKCk7Cit9CisKK3N0YXRpYyB2
b2lkIGJ0cF9kaXNjb25uZWN0KHN0cnVjdCBoaWRfZGV2aWNlICpoaWQsIHN0cnVjdCBoaWRfaW5w
dXQgKmhpZGlucHV0KQoreworCXN0cnVjdCB1c2JfYnRwX2luZm8gKmluZm87CisJdW5zaWduZWQg
bG9uZyBmbGFnczsKKworCWlmICghaGlkaW5wdXQpCisJCXJldHVybjsKKworCXNwaW5fbG9ja19p
cnFzYXZlKCZidHBfbG9jaywgZmxhZ3MpOworCWluZm8gPSBoaWRpbnB1dC0+cHJpdmF0ZTsKKwlp
ZiAoSVNfQlRQX0JVU1koaW5mbykpCisJCUJUUF9TRVRfRElTQ09OTkVDVElORyhpbmZvKTsKKwlp
bmZvLT5yZXBlYXQgPSAwOworCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmJ0cF9sb2NrLCBmbGFn
cyk7CisKKwlkZWxfdGltZXJfc3luYygmaW5mby0+dGltZXIpOworCWJ0cF93YWl0X2Zvcl9lZmZl
Y3QoaW5mbyk7CisKKwlzcGluX2xvY2tfaXJxc2F2ZSgmYnRwX2xvY2ssIGZsYWdzKTsKKwloaWRp
bnB1dC0+cHJpdmF0ZSA9IE5VTEw7CisJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmYnRwX2xvY2ss
IGZsYWdzKTsKKworCXVzYl9mcmVlX3VyYihpbmZvLT5jdHJsMCk7CisJa2ZyZWUoaW5mbyk7Cit9
CisKK3N0YXRpYyB2b2lkIHVzYl9idHBfdXBkYXRlX2VmZmVjdChzdHJ1Y3QgaGlkX2lucHV0ICpo
aWRpbnB1dCwgaW50IG9mZnNldCkKK3sKKwlzdHJ1Y3QgdXNiX2J0cF9pbmZvICppbmZvOworCisJ
c3Bpbl9sb2NrKCZidHBfbG9jayk7CisJaW5mbyA9IGhpZGlucHV0LT5wcml2YXRlOworCWlmIChv
ZmZzZXQgPT0gaW5mby0+cnVubmluZ19lZmZlY3QpIHsKKwkJaWYgKGJ0cF9lZmZlY3Rfc3RvcCho
aWRpbnB1dCkpCisJCQlnb3RvIGV4aXQ7CisJCWlmIChpbmZvLT5lZmZlY3RzW29mZnNldF0udHlw
ZSkgeworCQkJaWYgKGJ0cF9lZmZlY3Rfc3RhcnQoaGlkaW5wdXQpKQorCQkJCWdvdG8gZXhpdDsK
KwkJfQorCQllbHNlCS8qIHJlbW92ZSBlZmZlY3QgKi8KKwkJCWRlbF90aW1lcigmaW5mby0+dGlt
ZXIpOworCX0KK2V4aXQ6CisJc3Bpbl91bmxvY2soJmJ0cF9sb2NrKTsKK30KKworc3RhdGljIGlu
dCBidHBfRkZfR0FJTl9oYW5kbGVyKHN0cnVjdCBoaWRfaW5wdXQgKmhpZGlucHV0LCBpbnQgdmFs
dWUpCit7CisJaW50IG9mZnNldDsKKwl1bnNpZ25lZCBjaGFyIHN0cmVuZ3RoOworCXN0cnVjdCB1
c2JfYnRwX2luZm8gKmluZm87CisKKwlpZiAodmFsdWUgPCAwIHx8IHZhbHVlID4gOTkpCisJCXJl
dHVybiAtRUlOVkFMOworCW9mZnNldCA9ICh2YWx1ZT40OSk7IC8qMCAtIGxlZnQgbW90b3IsIDEg
LSByaWdodCBtb3RvciAqLworCWlmIChvZmZzZXQpCisJCXZhbHVlIC09IDUwOworCWlmICghdmFs
dWUpIHsKKwkJc3RyZW5ndGggPSAwOworCQlnb3RvIGV4aXQwOworCX0KKwkvKiB0aGUgcmFuZ2Ug
b2YgdmFsdWUgaXMgZnJvbSAxIHRvIDUwICovCisJLyogdGhpcyBtYXBwaW5nIHZhbHVlIHRvIHNo
b2NrIHN0cmVuZ3RoIChmcm9tIDB4YSB0byAweDFmKSAqLworCXN0cmVuZ3RoID0gKCgyMSp2YWx1
ZSkrNDU5KS80ODsKK2V4aXQwOgorCXNwaW5fbG9jaygmYnRwX2xvY2spOworCWluZm8gPSBoaWRp
bnB1dC0+cHJpdmF0ZTsKKwlpZiAoaW5mbykKKwkJaW5mby0+c3RhcnRfcGFja2V0W29mZnNldF0g
PSBzdHJlbmd0aDsKKwlzcGluX3VubG9jaygmYnRwX2xvY2spOworCXJldHVybiAwOworfQorCitz
dGF0aWMgaW50IGJ0cF9mZl9ldmVudChzdHJ1Y3QgaW5wdXRfZGV2ICpkZXYsIGludCB0eXBlLCBp
bnQgY29kZSwgaW50IHZhbHVlKQoreworCXN0cnVjdCBoaWRfaW5wdXQgKmhpZGlucHV0OworCXN0
cnVjdCB1c2JfYnRwX2luZm8gKmluZm87CisJaW50IHJldCA9IDA7CisJaW50IHJ1bm5pbmdfZWZm
ZWN0OworCisJaGlkaW5wdXQgPSBoaWRpbnB1dF9zaW1wbGVfaW5wdXRkZXZfdG9faGlkaW5wdXQo
ZGV2KTsKKwlpZiAoIWhpZGlucHV0KQorCQlyZXR1cm4gLUVOT0RFVjsKKworCXNwaW5fbG9jaygm
YnRwX2xvY2spOworCWluZm8gPSBoaWRpbnB1dC0+cHJpdmF0ZTsKKwlpZiAoIWluZm8gfHwgSVNf
QlRQX0RJU0NPTk5FQ1RJTkcoaW5mbykpIHsKKwkJcmV0ID0gLUVOT0RFVjsKKwkJZ290byB1bmxv
Y2tfZXhpdDsKKwl9CisJcnVubmluZ19lZmZlY3QgPSBpbmZvLT5ydW5uaW5nX2VmZmVjdDsKKwlz
cGluX3VubG9jaygmYnRwX2xvY2spOworCisJaWYgKHR5cGUgPT0gRVZfRkZfU1RBVFVTKSB7CisJ
CWlmIChjb2RlID09IHJ1bm5pbmdfZWZmZWN0KQorCQkJaW5wdXRfcmVwb3J0X2ZmX3N0YXR1cyhk
ZXYsIGNvZGUsIEZGX1NUQVRVU19QTEFZSU5HKTsKKwkJZWxzZQorCQkJaW5wdXRfcmVwb3J0X2Zm
X3N0YXR1cyhkZXYsIGNvZGUsIEZGX1NUQVRVU19TVE9QUEVEKTsKKwl9CisKKwlpZiAodHlwZSAh
PSBFVl9GRikKKwkJcmV0dXJuIC1FSU5WQUw7CisKKwlzd2l0Y2ggKGNvZGUpIHsKKwljYXNlIEZG
X0dBSU46CisJCXJldHVybiBidHBfRkZfR0FJTl9oYW5kbGVyKGhpZGlucHV0LCB2YWx1ZSk7CisJ
ZGVmYXVsdDoKKwkJc3Bpbl9sb2NrKCZidHBfbG9jayk7CisJCWluZm8gPSBoaWRpbnB1dC0+cHJp
dmF0ZTsKKwkJaWYgKCFpbmZvKSB7CisJCQlyZXQgPSAtRU5PREVWOworCQkJZ290byB1bmxvY2tf
ZXhpdDsKKwkJfQorCQlpbmZvLT5yZXBlYXQgPSB2YWx1ZTsKKwkJaWYgKHZhbHVlKSB7CisJCQlp
ZiAoYnRwX2VmZmVjdF9zdGFydChoaWRpbnB1dCkpCisJCQkJZ290byB1bmxvY2tfZXhpdDsKKwkJ
CWlmICh2YWx1ZT4xKSB7CisJCQkJZGVsX3RpbWVyKCZpbmZvLT50aW1lcik7CisJCQkJbW9kX3Rp
bWVyKCZpbmZvLT50aW1lciwgamlmZmllcys0KkhaKTsKKwkJCX0KKwkJCWluZm8tPnJ1bm5pbmdf
ZWZmZWN0ID0gY29kZTsKKwkJfQorCQllbHNlIHsKKwkJCWRlbF90aW1lcigmaW5mby0+dGltZXIp
OworCQkJaWYgKGJ0cF9lZmZlY3Rfc3RvcChoaWRpbnB1dCkpCisJCQkJZ290byB1bmxvY2tfZXhp
dDsKKwkJCWluZm8tPnJ1bm5pbmdfZWZmZWN0ID0gQlRQX0VGRkVDVF9OT05FOworCQl9CisJfQor
Cit1bmxvY2tfZXhpdDoKKwlzcGluX3VubG9jaygmYnRwX2xvY2spOworCXJldHVybiByZXQ7IAor
fQorCitzdGF0aWMgaW50IGlubGluZSBidHBfbmV3X2VmZmVjdF9pZCh2b2lkKQoreworCXN0YXRp
YyBhdG9taWNfdCBlZmZlY3RfaWQ9IEFUT01JQ19JTklUKDApOworCQorCWF0b21pY19pbmMoJmVm
ZmVjdF9pZCk7CisJcmV0dXJuIGF0b21pY19yZWFkKCZlZmZlY3RfaWQpOworfQorCitzdGF0aWMg
aW50IGJ0cF91cGxvYWRfZWZmZWN0KHN0cnVjdCBpbnB1dF9kZXYgKmRldiwgc3RydWN0IGZmX2Vm
ZmVjdCAqZWZmZWN0KQoreworCXN0cnVjdCBoaWRfaW5wdXQgKmhpZGlucHV0OworCXN0cnVjdCB1
c2JfYnRwX2luZm8gKmluZm87CisJaW50IG9mZnNldDsKKworCWhpZGlucHV0ID0gaGlkaW5wdXRf
c2ltcGxlX2lucHV0ZGV2X3RvX2hpZGlucHV0KGRldik7CisJaWYgKCFoaWRpbnB1dCkgeworCQly
ZXR1cm4gLUVOT0RFVjsKKwl9CisJb2Zmc2V0ID0gZWZmZWN0LT50eXBlIC0gRkZfUlVNQkxFOwor
CWVmZmVjdC0+aWQgPSAoKGVmZmVjdC0+aWQgIT0gLTEpID86IGJ0cF9uZXdfZWZmZWN0X2lkKCkp
OworCWlmIChvZmZzZXQ+PTAgJiYgb2Zmc2V0PDgpIHsKKwkJc3Bpbl9sb2NrKCZidHBfbG9jayk7
CisJCWluZm8gPSBoaWRpbnB1dC0+cHJpdmF0ZTsKKwkJaWYgKCFpbmZvIHx8IElTX0JUUF9ESVND
T05ORUNUSU5HKGluZm8pKSB7CisJCQlzcGluX3VubG9jaygmYnRwX2xvY2spOworCQkJcmV0dXJu
IC1FTk9ERVY7CisJCX0KKwkJbWVtY3B5KGluZm8tPmVmZmVjdHMrb2Zmc2V0LCBlZmZlY3QsIHNp
emVvZihzdHJ1Y3QgZmZfZWZmZWN0KSk7CisJCXNwaW5fdW5sb2NrKCZidHBfbG9jayk7CisJCXVz
Yl9idHBfdXBkYXRlX2VmZmVjdChoaWRpbnB1dCwgZWZmZWN0LT50eXBlKTsKKwkJcmV0dXJuIDA7
CisJfQorCXJldHVybiAtRUlOVkFMOworfQorCitzdGF0aWMgaW50IGJ0cF9lcmFzZV9lZmZlY3Qo
c3RydWN0IGlucHV0X2RldiAqZGV2LCBpbnQgZWZmZWN0X2lkKQorewkKKwlzdHJ1Y3QgaGlkX2lu
cHV0ICpoaWRpbnB1dDsKKwlzdHJ1Y3QgdXNiX2J0cF9pbmZvICppbmZvOworCWludCBvZmZzZXQ7
CisKKwloaWRpbnB1dCA9IGhpZGlucHV0X3NpbXBsZV9pbnB1dGRldl90b19oaWRpbnB1dChkZXYp
OworCWlmICghaGlkaW5wdXQpCisJCXJldHVybiAtRU5PREVWOworCisJc3Bpbl9sb2NrKCZidHBf
bG9jayk7CisJaW5mbyA9IGhpZGlucHV0LT5wcml2YXRlOworCWlmICghaW5mbyB8fCBJU19CVFBf
RElTQ09OTkVDVElORyhpbmZvKSkgeworCQlzcGluX3VubG9jaygmYnRwX2xvY2spOworCQlyZXR1
cm4gLUVOT0RFVjsKKwl9CisJZm9yIChvZmZzZXQ9MDsgb2Zmc2V0PDg7ICsrb2Zmc2V0KSB7CisJ
CWlmIChlZmZlY3RfaWQgPT0gaW5mby0+ZWZmZWN0c1tvZmZzZXRdLmlkKSB7CisJCQltZW1zZXQo
aW5mby0+ZWZmZWN0cytvZmZzZXQsIDAsIHNpemVvZihzdHJ1Y3QgZmZfZWZmZWN0KSk7CisJCQli
cmVhazsKKwkJfQorCX0KKwlzcGluX3VubG9jaygmYnRwX2xvY2spOworCXVzYl9idHBfdXBkYXRl
X2VmZmVjdChoaWRpbnB1dCwgb2Zmc2V0KTsKKwlyZXR1cm4gMDsKK30KKworc3RhdGljIHN0cnVj
dCBoaWRpbnB1dF9zaW1wbGVfZHJpdmVyIGJ0cF9kcml2ZXIgPSB7CisJLm93bmVyID0gVEhJU19N
T0RVTEUsCisJLm5hbWUgPSBkcml2ZXJfbmFtZSwKKwkuY29ubmVjdCA9IGJ0cF9jb25uZWN0LAor
CS5kaXNjb25uZWN0ID0gYnRwX2Rpc2Nvbm5lY3QsCisJLmZmX2V2ZW50ID0gYnRwX2ZmX2V2ZW50
LAorCS51cGxvYWRfZWZmZWN0ID0gYnRwX3VwbG9hZF9lZmZlY3QsCisJLmVyYXNlX2VmZmVjdCA9
IGJ0cF9lcmFzZV9lZmZlY3QsCisJLmlkX3RhYmxlID0gYnRwX2lkX3RhYmxlLAorCS51c2FnZV9w
YWdlX3RhYmxlID0gYnRwX2ZmX3VzYWdlX3BhZ2VfYmxvY2tlcywKKwkucHJpdmF0ZSA9IE5VTEws
Cit9OworCitzdGF0aWMgaW50IF9faW5pdCBidHBfaW5pdCh2b2lkKQoreworCXJldHVybiBoaWRp
bnB1dF9yZWdpc3Rlcl9zaW1wbGVfZHJpdmVyKCZidHBfZHJpdmVyKTsKK30KKworc3RhdGljIHZv
aWQgX19leGl0IGJ0cF9leGl0KHZvaWQpCit7CisJaGlkaW5wdXRfdW5yZWdpc3Rlcl9zaW1wbGVf
ZHJpdmVyKCZidHBfZHJpdmVyKTsKK30KKworbW9kdWxlX2luaXQoYnRwX2luaXQpOworbW9kdWxl
X2V4aXQoYnRwX2V4aXQpOworCitNT0RVTEVfTElDRU5TRSgiR1BMIik7CmRpZmYgLU5hdXJwIGxp
bnV4LTIuNi4xOC9kcml2ZXJzL3VzYi9pbnB1dC9oaWQtY29yZS5jIGxpbnV4LTIuNi4xOC9kcml2
ZXJzL3VzYi9pbnB1dC5uZXcvaGlkLWNvcmUuYwotLS0gbGludXgtMi42LjE4L2RyaXZlcnMvdXNi
L2lucHV0L2hpZC1jb3JlLmMJMjAwNi0wOS0yMCAxMTo0MjowNi4wMDAwMDAwMDAgKzA4MDAKKysr
IGxpbnV4LTIuNi4xOC9kcml2ZXJzL3VzYi9pbnB1dC5uZXcvaGlkLWNvcmUuYwkyMDA2LTA5LTI4
IDA5OjMwOjQ3LjAwMDAwMDAwMCArMDgwMApAQCAtMjYsNiArMjYsNyBAQAogI2luY2x1ZGUgPGFz
bS9ieXRlb3JkZXIuaD4KICNpbmNsdWRlIDxsaW51eC9pbnB1dC5oPgogI2luY2x1ZGUgPGxpbnV4
L3dhaXQuaD4KKyNpbmNsdWRlIDxsaW51eC9tdXRleC5oPgogCiAjdW5kZWYgREVCVUcKICN1bmRl
ZiBERUJVR19EQVRBCkBAIC0zMyw2ICszNCw3IEBACiAjaW5jbHVkZSA8bGludXgvdXNiLmg+CiAK
ICNpbmNsdWRlICJoaWQuaCIKKyNpbmNsdWRlICJoaWQtc2ltcGxlLmgiCiAjaW5jbHVkZSA8bGlu
dXgvaGlkZGV2Lmg+CiAKIC8qCkBAIC00Niw2ICs0OCwxNSBAQAogCiBzdGF0aWMgY2hhciAqaGlk
X3R5cGVzW10gPSB7IkRldmljZSIsICJQb2ludGVyIiwgIk1vdXNlIiwgIkRldmljZSIsICJKb3lz
dGljayIsCiAJCQkJIkdhbWVwYWQiLCAiS2V5Ym9hcmQiLCAiS2V5cGFkIiwgIk11bHRpLUF4aXMg
Q29udHJvbGxlciJ9OworCisvKgorICogVGhlIGdsb2JhbCBkYXRhIHN0cnVjdHVyZSBmb3Igc2lt
cGxlIGRldmljZSBkcml2ZXIgaW50ZXJmYWNlLgorICovCitzdGF0aWMgREVGSU5FX01VVEVYKG1h
dGNoZWRfZGV2aWNlc19sb2NrKTsKK3N0YXRpYyBERUZJTkVfTVVURVgoc2ltcGxlX2RyaXZlcnNf
bG9jayk7CitzdGF0aWMgc3RydWN0IGxpc3RfaGVhZCBtYXRjaGVkX2RldmljZXNfbGlzdDsKK3N0
YXRpYyBzdHJ1Y3QgbGlzdF9oZWFkIHNpbXBsZV9kcml2ZXJzX2xpc3Q7CisKIC8qCiAgKiBNb2R1
bGUgcGFyYW1ldGVycy4KICAqLwpAQCAtNzg1LDggKzc5NiwxOCBAQCBzdGF0aWMgX19pbmxpbmVf
XyBpbnQgc2VhcmNoKF9fczMyICphcnJhCiBzdGF0aWMgdm9pZCBoaWRfcHJvY2Vzc19ldmVudChz
dHJ1Y3QgaGlkX2RldmljZSAqaGlkLCBzdHJ1Y3QgaGlkX2ZpZWxkICpmaWVsZCwgc3RydWN0IGhp
ZF91c2FnZSAqdXNhZ2UsIF9fczMyIHZhbHVlLCBpbnQgaW50ZXJydXB0LCBzdHJ1Y3QgcHRfcmVn
cyAqcmVncykKIHsKIAloaWRfZHVtcF9pbnB1dCh1c2FnZSwgdmFsdWUpOwotCWlmIChoaWQtPmNs
YWltZWQgJiBISURfQ0xBSU1FRF9JTlBVVCkKKwlpZiAoaGlkLT5jbGFpbWVkICYgSElEX0NMQUlN
RURfSU5QVVQpIHsKKwkJLyogZXZlbnQgZmlsdGVyIGhlcmUgKi8KKwkJaWYgKGhpZC0+c2ltcGxl
KSB7CisJCQlpZiAoaGlkLT5zaW1wbGUtPnByZV9ldmVudCAmJgorCQkJCSFoaWQtPnNpbXBsZS0+
cHJlX2V2ZW50KGhpZCwgZmllbGQsIHVzYWdlLCAKKwkJCQkJCQkJdmFsdWUsIHJlZ3MpKQorCQkJ
cmV0dXJuOworCQl9CiAJCWhpZGlucHV0X2hpZF9ldmVudChoaWQsIGZpZWxkLCB1c2FnZSwgdmFs
dWUsIHJlZ3MpOworCQlpZiAoaGlkLT5zaW1wbGUgJiYgaGlkLT5zaW1wbGUtPnBvc3RfZXZlbnQp
CisJCQloaWQtPnNpbXBsZS0+cG9zdF9ldmVudChoaWQsIGZpZWxkLCB1c2FnZSwgdmFsdWUsIHJl
Z3MpOworCX0KIAlpZiAoaGlkLT5jbGFpbWVkICYgSElEX0NMQUlNRURfSElEREVWICYmIGludGVy
cnVwdCkKIAkJaGlkZGV2X2hpZF9ldmVudChoaWQsIGZpZWxkLCB1c2FnZSwgdmFsdWUsIHJlZ3Mp
OwogfQpAQCAtODMyLDcgKzg1Myw2IEBAIHN0YXRpYyB2b2lkIGhpZF9pbnB1dF9maWVsZChzdHJ1
Y3QgaGlkX2QKIAkJCSYmIGZpZWxkLT51c2FnZVtmaWVsZC0+dmFsdWVbbl0gLSBtaW5dLmhpZAog
CQkJJiYgc2VhcmNoKHZhbHVlLCBmaWVsZC0+dmFsdWVbbl0sIGNvdW50KSkKIAkJCQloaWRfcHJv
Y2Vzc19ldmVudChoaWQsIGZpZWxkLCAmZmllbGQtPnVzYWdlW2ZpZWxkLT52YWx1ZVtuXSAtIG1p
bl0sIDAsIGludGVycnVwdCwgcmVncyk7Ci0KIAkJaWYgKHZhbHVlW25dID49IG1pbiAmJiB2YWx1
ZVtuXSA8PSBtYXgKIAkJCSYmIGZpZWxkLT51c2FnZVt2YWx1ZVtuXSAtIG1pbl0uaGlkCiAJCQkm
JiBzZWFyY2goZmllbGQtPnZhbHVlLCB2YWx1ZVtuXSwgY291bnQpKQpAQCAtMjAzMSw4ICsyMDUx
LDMzIEBAIHN0YXRpYyB2b2lkIGhpZF9kaXNjb25uZWN0KHN0cnVjdCB1c2JfaW4KIAlkZWxfdGlt
ZXJfc3luYygmaGlkLT5pb19yZXRyeSk7CiAJZmx1c2hfc2NoZWR1bGVkX3dvcmsoKTsKIAotCWlm
IChoaWQtPmNsYWltZWQgJiBISURfQ0xBSU1FRF9JTlBVVCkKKwlpZiAoaGlkLT5jbGFpbWVkICYg
SElEX0NMQUlNRURfSU5QVVQpIHsKKwkJc3RydWN0IGxpc3RfaGVhZCAqbm9kZTsKKwkJc3RydWN0
IG1hdGNoZWRfZGV2aWNlICptYXRjaGVkOworCisJCW1hdGNoZWQgPSBOVUxMOworCQltdXRleF9s
b2NrKCZtYXRjaGVkX2RldmljZXNfbG9jayk7CisJCWxpc3RfZm9yX2VhY2gobm9kZSwgJm1hdGNo
ZWRfZGV2aWNlc19saXN0KSB7CisJCQltYXRjaGVkID0gbGlzdF9lbnRyeShub2RlLCBzdHJ1Y3Qg
bWF0Y2hlZF9kZXZpY2UsIG5vZGUpOworCQkJaWYgKG1hdGNoZWQtPmludGYgPT0gaW50Zikgewor
CQkJCWxpc3RfZGVsKCZtYXRjaGVkLT5ub2RlKTsKKwkJCQlicmVhazsKKwkJCX0KKwkJCW1hdGNo
ZWQgPSBOVUxMOworCQl9CisJCW11dGV4X3VubG9jaygmbWF0Y2hlZF9kZXZpY2VzX2xvY2spOwor
CQkvKiBkaXNjb25uZWN0IHNpbXBsZSBkZXZpY2UgZHJpdmVyIGlmIG5lZWQgKi8KKwkJaWYgKG1h
dGNoZWQgJiYgaGlkLT5zaW1wbGUpIHsKKwkJCWhpZGlucHV0X3NpbXBsZV9kcml2ZXJfZGlzY29u
bmVjdChoaWQpOworCQkJbW9kdWxlX3B1dChoaWQtPnNpbXBsZS0+b3duZXIpOworCQkJaGlkaW5w
dXRfc2ltcGxlX2RyaXZlcl9wb3AoaGlkLCBtYXRjaGVkKTsKKwkJfQorCQlpZiAobWF0Y2hlZCkg
eworCQkJbWF0Y2hlZC0+aW50ZiA9IE5VTEw7CisJCQlrZnJlZShtYXRjaGVkKTsKKwkJfQogCQlo
aWRpbnB1dF9kaXNjb25uZWN0KGhpZCk7CisJfQogCWlmIChoaWQtPmNsYWltZWQgJiBISURfQ0xB
SU1FRF9ISURERVYpCiAJCWhpZGRldl9kaXNjb25uZWN0KGhpZCk7CiAKQEAgLTIwNDUsNiArMjA5
MCwxNDEgQEAgc3RhdGljIHZvaWQgaGlkX2Rpc2Nvbm5lY3Qoc3RydWN0IHVzYl9pbgogCWhpZF9m
cmVlX2RldmljZShoaWQpOwogfQogCisjaWZkZWYgQ09ORklHX0hJRF9TSU1QTEUKK3N0YXRpYyBp
bnQgaGlkaW5wdXRfc2ltcGxlX2RyaXZlcl9iaW5kX29uZShzdHJ1Y3QgaGlkaW5wdXRfc2ltcGxl
X2RyaXZlciAqc2ltcGxlLAorCQkJCQkJCXN0cnVjdCBoaWRfZGV2aWNlICpoaWQsCisJCQkJCQlz
dHJ1Y3QgbWF0Y2hlZF9kZXZpY2UgKm1hdGNoZWQpCit7CisJaW50IHJldDsKKworCWlmICghdHJ5
X21vZHVsZV9nZXQoc2ltcGxlLT5vd25lcikpCisJCXJldHVybiAtRU5PREVWOworCXJldCA9IGhp
ZGlucHV0X3NpbXBsZV9kcml2ZXJfY29ubmVjdChzaW1wbGUsIGhpZCk7CisJaWYgKHJldCkKKwkJ
Z290byBleGl0X2VycjsKKwlyZXQgPSBoaWRpbnB1dF9zaW1wbGVfZHJpdmVyX3B1c2goaGlkLCBz
aW1wbGUsIG1hdGNoZWQpOworCWlmIChyZXQpCisJCWdvdG8gZXhpdF9lcnI7CisJaGlkaW5wdXRf
c2ltcGxlX2RyaXZlcl9zZXR1cF91c2FnZShoaWQpOworCXByaW50ayhLRVJOX0lORk8gIlRoZSBT
aW1wbGUgSElEIGRyaXZlciBcJyVzXCcgYXR0YWNoIG9uIFwnJXNcJ1xuIiwKKwkJCQkJCXNpbXBs
ZS0+bmFtZSwgaGlkLT5uYW1lKTsKKwlnb3RvIGV4aXQ7CitleGl0X2VycjoKKwltb2R1bGVfcHV0
KHNpbXBsZS0+b3duZXIpOworZXhpdDoKKwlyZXR1cm4gcmV0OworfQorCitzdGF0aWMgdm9pZCBo
aWRpbnB1dF9zaW1wbGVfZHJpdmVyX2JpbmRfZm9yZWFjaF9zaW1wbGUoCisJCQkJCQlzdHJ1Y3Qg
bWF0Y2hlZF9kZXZpY2UgKm1hdGNoZWQpCit7CisJc3RydWN0IGhpZGlucHV0X3NpbXBsZV9kcml2
ZXIgKnNpbXBsZTsKKwlzdHJ1Y3QgbGlzdF9oZWFkICpub2RlOworCXN0cnVjdCBoaWRfZGV2aWNl
ICpoaWQ7CisJCisJaWYgKCFtYXRjaGVkLT5pbnRmKQorCQlyZXR1cm47CisJaGlkID0gdXNiX2dl
dF9pbnRmZGF0YSAobWF0Y2hlZC0+aW50Zik7CisJaWYgKCFoaWQgfHwgaGlkLT5zaW1wbGUpCisJ
CXJldHVybjsKKworCW11dGV4X2xvY2soJnNpbXBsZV9kcml2ZXJzX2xvY2spOworCWxpc3RfZm9y
X2VhY2gobm9kZSwgJnNpbXBsZV9kcml2ZXJzX2xpc3QpIHsKKwkJc2ltcGxlID0gbGlzdF9lbnRy
eShub2RlLCBzdHJ1Y3QgaGlkaW5wdXRfc2ltcGxlX2RyaXZlciwgbm9kZSk7CisJCWlmICh0ZXN0
X2JpdChISURJTlBVVF9TSU1QTEVfQ09OTkVDVEVELCAmc2ltcGxlLT5mbGFncykpCisJCQljb250
aW51ZTsKKwkJaWYgKHVzYl9tYXRjaF9pZChtYXRjaGVkLT5pbnRmLCBzaW1wbGUtPmlkX3RhYmxl
KSkgeworCQkJaGlkaW5wdXRfc2ltcGxlX2RyaXZlcl9iaW5kX29uZShzaW1wbGUsIGhpZCwgbWF0
Y2hlZCk7CisJCQlicmVhazsKKwkJfQorCX0KKwltdXRleF91bmxvY2soJnNpbXBsZV9kcml2ZXJz
X2xvY2spOworfQorCitzdGF0aWMgdm9pZCBoaWRpbnB1dF9zaW1wbGVfZHJpdmVyX2JpbmRfZm9y
ZWFjaCh2b2lkKQoreworCXN0cnVjdCBoaWRpbnB1dF9zaW1wbGVfZHJpdmVyICpzaW1wbGU7CisJ
c3RydWN0IG1hdGNoZWRfZGV2aWNlICptYXRjaGVkPU5VTEw7CisJc3RydWN0IGxpc3RfaGVhZCAq
bWF0Y2hlZF9ub2RlID0gTlVMTDsKKwlzdHJ1Y3QgbGlzdF9oZWFkICpzaW1wbGVfbm9kZSA9IE5V
TEw7CisJc3RydWN0IGhpZF9kZXZpY2UgKmhpZD1OVUxMOworCisJbXV0ZXhfbG9jaygmbWF0Y2hl
ZF9kZXZpY2VzX2xvY2spOworCWxpc3RfZm9yX2VhY2gobWF0Y2hlZF9ub2RlLCAmbWF0Y2hlZF9k
ZXZpY2VzX2xpc3QpIHsKKwkJbWF0Y2hlZCA9IGxpc3RfZW50cnkobWF0Y2hlZF9ub2RlLCBzdHJ1
Y3QgbWF0Y2hlZF9kZXZpY2UsIG5vZGUpOworCQloaWQgPSB1c2JfZ2V0X2ludGZkYXRhKG1hdGNo
ZWQtPmludGYpOworCQlpZiAoaGlkLT5zaW1wbGUpCisJCQljb250aW51ZTsKKwkJbXV0ZXhfbG9j
aygmc2ltcGxlX2RyaXZlcnNfbG9jayk7CisJCWxpc3RfZm9yX2VhY2goc2ltcGxlX25vZGUsICZz
aW1wbGVfZHJpdmVyc19saXN0KSB7CisJCQlzaW1wbGUgPSBsaXN0X2VudHJ5KHNpbXBsZV9ub2Rl
LCBzdHJ1Y3QgaGlkaW5wdXRfc2ltcGxlX2RyaXZlciwgbm9kZSk7CisKKwkJCWlmICh0ZXN0X2Jp
dChISURJTlBVVF9TSU1QTEVfQ09OTkVDVEVELCAmc2ltcGxlLT5mbGFncykpCisJCQkJY29udGlu
dWU7CisJCQlpZiAoIXVzYl9tYXRjaF9pZChtYXRjaGVkLT5pbnRmLCBzaW1wbGUtPmlkX3RhYmxl
KSkKKwkJCQljb250aW51ZTsKKwkJCWhpZGlucHV0X3NpbXBsZV9kcml2ZXJfYmluZF9vbmUoc2lt
cGxlLCBoaWQsIG1hdGNoZWQpOworCQl9CisJCW11dGV4X3VubG9jaygmc2ltcGxlX2RyaXZlcnNf
bG9jayk7CisJfQorCW11dGV4X3VubG9jaygmbWF0Y2hlZF9kZXZpY2VzX2xvY2spOworfQorCitz
dGF0aWMgdm9pZCBoaWRpbnB1dF9zaW1wbGVfZHJpdmVyX2JpbmRfZm9yZWFjaF9tYXRjaGVkKAor
CQkJCQlzdHJ1Y3QgaGlkaW5wdXRfc2ltcGxlX2RyaXZlciAqc2ltcGxlKQoreworCXN0cnVjdCBs
aXN0X2hlYWQgKm5vZGU9TlVMTDsKKwlzdHJ1Y3QgbWF0Y2hlZF9kZXZpY2UgKm1hdGNoZWQ7CisJ
c3RydWN0IGhpZF9kZXZpY2UgKmhpZD1OVUxMOworCisJaWYgKCFzaW1wbGUgfHwgdGVzdF9iaXQo
SElESU5QVVRfU0lNUExFX0NPTk5FQ1RFRCwgJnNpbXBsZS0+ZmxhZ3MpKQorCQlyZXR1cm47CisK
KwltdXRleF9sb2NrKCZtYXRjaGVkX2RldmljZXNfbG9jayk7CisJbGlzdF9mb3JfZWFjaChub2Rl
LCAmbWF0Y2hlZF9kZXZpY2VzX2xpc3QpIHsKKwkJbWF0Y2hlZCA9IGxpc3RfZW50cnkobm9kZSwg
c3RydWN0IG1hdGNoZWRfZGV2aWNlLCBub2RlKTsKKwkJaGlkID0gdXNiX2dldF9pbnRmZGF0YSAo
bWF0Y2hlZC0+aW50Zik7CisJCWlmIChoaWQtPnNpbXBsZSkKKwkJCWNvbnRpbnVlOworCQlpZiAo
IXVzYl9tYXRjaF9pZChtYXRjaGVkLT5pbnRmLCBzaW1wbGUtPmlkX3RhYmxlKSkKKwkJCWNvbnRp
bnVlOworCQloaWRpbnB1dF9zaW1wbGVfZHJpdmVyX2JpbmRfb25lKHNpbXBsZSwgaGlkLCBtYXRj
aGVkKTsKKwl9CisJbXV0ZXhfdW5sb2NrKCZtYXRjaGVkX2RldmljZXNfbG9jayk7Cit9CisKK2lu
dCBoaWRpbnB1dF9yZWdpc3Rlcl9zaW1wbGVfZHJpdmVyKHN0cnVjdCBoaWRpbnB1dF9zaW1wbGVf
ZHJpdmVyICpzaW1wbGUpCit7CisJaWYgKCFzaW1wbGUgfHwgIXNpbXBsZS0+bmFtZSkKKwkJcmV0
dXJuIC1FSU5WQUw7CisKKwlwcmludGsoS0VSTl9JTkZPICJUaGUgU2ltcGxlIEhJRCBkcml2ZXIg
XCclc1wnIHJlZ2lzdGVyLlxuIiwgCisJCQkJCQkJCXNpbXBsZS0+bmFtZSk7CisJaGlkaW5wdXRf
c2ltcGxlX2RyaXZlcl9pbml0KHNpbXBsZSk7CisJaGlkaW5wdXRfc2ltcGxlX2RyaXZlcl9iaW5k
X2ZvcmVhY2hfbWF0Y2hlZChzaW1wbGUpOworCisJbXV0ZXhfbG9jaygmc2ltcGxlX2RyaXZlcnNf
bG9jayk7CisJbGlzdF9hZGQoJnNpbXBsZS0+bm9kZSwgJnNpbXBsZV9kcml2ZXJzX2xpc3QpOwor
CW11dGV4X3VubG9jaygmc2ltcGxlX2RyaXZlcnNfbG9jayk7CisKKwlyZXR1cm4gMDsKK30KK0VY
UE9SVF9TWU1CT0xfR1BMKGhpZGlucHV0X3JlZ2lzdGVyX3NpbXBsZV9kcml2ZXIpOworCit2b2lk
IGhpZGlucHV0X3VucmVnaXN0ZXJfc2ltcGxlX2RyaXZlcihzdHJ1Y3QgaGlkaW5wdXRfc2ltcGxl
X2RyaXZlciAqc2ltcGxlKQoreworCXByaW50ayhLRVJOX0lORk8gIlRoZSBTaW1wbGUgSElEIGRy
aXZlciBcJyVzXCcgdW5yZWdpc3Rlci5cbiIsIAorCQkJCQkJCXNpbXBsZS0+bmFtZSk7CisJaGlk
aW5wdXRfc2ltcGxlX2RyaXZlcl9jbGVhcihzaW1wbGUpOworCW11dGV4X2xvY2soJnNpbXBsZV9k
cml2ZXJzX2xvY2spOworCWxpc3RfZGVsKCZzaW1wbGUtPm5vZGUpOworCW11dGV4X3VubG9jaygm
c2ltcGxlX2RyaXZlcnNfbG9jayk7CisJLyogdG8gYWN0aXZlIHNpbXBsZSBkZXZpY2UgZHJpdmVy
IHRoYXQgaXQgaXMgd2FpdGluZyAqLworCWhpZGlucHV0X3NpbXBsZV9kcml2ZXJfYmluZF9mb3Jl
YWNoKCk7Cit9CitFWFBPUlRfU1lNQk9MX0dQTChoaWRpbnB1dF91bnJlZ2lzdGVyX3NpbXBsZV9k
cml2ZXIpOworI2VuZGlmCisKIHN0YXRpYyBpbnQgaGlkX3Byb2JlKHN0cnVjdCB1c2JfaW50ZXJm
YWNlICppbnRmLCBjb25zdCBzdHJ1Y3QgdXNiX2RldmljZV9pZCAqaWQpCiB7CiAJc3RydWN0IGhp
ZF9kZXZpY2UgKmhpZDsKQEAgLTIwNjEsMTUgKzIyNDEsMjUgQEAgc3RhdGljIGludCBoaWRfcHJv
YmUoc3RydWN0IHVzYl9pbnRlcmZhYwogCWhpZF9pbml0X3JlcG9ydHMoaGlkKTsKIAloaWRfZHVt
cF9kZXZpY2UoaGlkKTsKIAotCWlmICghaGlkaW5wdXRfY29ubmVjdChoaWQpKQorCXVzYl9zZXRf
aW50ZmRhdGEoaW50ZiwgaGlkKTsKKworCWlmICghaGlkaW5wdXRfY29ubmVjdChoaWQpKSB7CisJ
CXN0cnVjdCBtYXRjaGVkX2RldmljZSAqbWF0Y2hlZDsKKwkJbWF0Y2hlZCA9IGttYWxsb2Moc2l6
ZW9mKHN0cnVjdCBtYXRjaGVkX2RldmljZSksIEdGUF9LRVJORUwpOworCQlpZiAobWF0Y2hlZCkg
eworCQkJbWF0Y2hlZC0+aW50ZiA9IGludGY7CisJCQltdXRleF9sb2NrKCZtYXRjaGVkX2Rldmlj
ZXNfbG9jayk7CisJCQlsaXN0X2FkZCgmbWF0Y2hlZC0+bm9kZSwgJm1hdGNoZWRfZGV2aWNlc19s
aXN0KTsKKwkJCW11dGV4X3VubG9jaygmbWF0Y2hlZF9kZXZpY2VzX2xvY2spOworCQkJaGlkaW5w
dXRfc2ltcGxlX2RyaXZlcl9iaW5kX2ZvcmVhY2hfc2ltcGxlKG1hdGNoZWQpOworCQl9CiAJCWhp
ZC0+Y2xhaW1lZCB8PSBISURfQ0xBSU1FRF9JTlBVVDsKKwl9CiAJaWYgKCFoaWRkZXZfY29ubmVj
dChoaWQpKQogCQloaWQtPmNsYWltZWQgfD0gSElEX0NMQUlNRURfSElEREVWOwogCi0JdXNiX3Nl
dF9pbnRmZGF0YShpbnRmLCBoaWQpOwotCiAJaWYgKCFoaWQtPmNsYWltZWQpIHsKLQkJcHJpbnRr
ICgiSElEIGRldmljZSBub3QgY2xhaW1lZCBieSBpbnB1dCBvciBoaWRkZXZcbiIpOworCQlwcmlu
dGsgKEtFUk5fSU5GTyAiSElEIGRldmljZSBub3QgY2xhaW1lZCBieSBpbnB1dCBvciBoaWRkZXZc
biIpOwogCQloaWRfZGlzY29ubmVjdChpbnRmKTsKIAkJcmV0dXJuIC1FTk9ERVY7CiAJfQpAQCAt
MjE2OCw2ICsyMzU4LDggQEAgc3RhdGljIGludCBfX2luaXQgaGlkX2luaXQodm9pZCkKIAlyZXR2
YWwgPSBoaWRkZXZfaW5pdCgpOwogCWlmIChyZXR2YWwpCiAJCWdvdG8gaGlkZGV2X2luaXRfZmFp
bDsKKwlJTklUX0xJU1RfSEVBRCgmbWF0Y2hlZF9kZXZpY2VzX2xpc3QpOworCUlOSVRfTElTVF9I
RUFEKCZzaW1wbGVfZHJpdmVyc19saXN0KTsKIAlyZXR2YWwgPSB1c2JfcmVnaXN0ZXIoJmhpZF9k
cml2ZXIpOwogCWlmIChyZXR2YWwpCiAJCWdvdG8gdXNiX3JlZ2lzdGVyX2ZhaWw7CkBAIC0yMTgy
LDcgKzIzNzQsMTUgQEAgaGlkZGV2X2luaXRfZmFpbDoKIAogc3RhdGljIHZvaWQgX19leGl0IGhp
ZF9leGl0KHZvaWQpCiB7CisJc3RydWN0IGxpc3RfaGVhZCAqbm9kZSwgKnRtcDsKKwlzdHJ1Y3Qg
bWF0Y2hlZF9kZXZpY2UgKm1hdGNoZWQ7CisKIAl1c2JfZGVyZWdpc3RlcigmaGlkX2RyaXZlcik7
CisJbGlzdF9mb3JfZWFjaF9zYWZlKG5vZGUsIHRtcCwgJm1hdGNoZWRfZGV2aWNlc19saXN0KSB7
CisJCW1hdGNoZWQgPSBsaXN0X2VudHJ5KG5vZGUsIHN0cnVjdCBtYXRjaGVkX2RldmljZSwgbm9k
ZSk7CisJCWxpc3RfZGVsKCZtYXRjaGVkLT5ub2RlKTsKKwkJa2ZyZWUobWF0Y2hlZCk7CisJfQog
CWhpZGRldl9leGl0KCk7CiB9CiAKZGlmZiAtTmF1cnAgbGludXgtMi42LjE4L2RyaXZlcnMvdXNi
L2lucHV0L2hpZC5oIGxpbnV4LTIuNi4xOC9kcml2ZXJzL3VzYi9pbnB1dC5uZXcvaGlkLmgKLS0t
IGxpbnV4LTIuNi4xOC9kcml2ZXJzL3VzYi9pbnB1dC9oaWQuaAkyMDA2LTA5LTIwIDExOjQyOjA2
LjAwMDAwMDAwMCArMDgwMAorKysgbGludXgtMi42LjE4L2RyaXZlcnMvdXNiL2lucHV0Lm5ldy9o
aWQuaAkyMDA2LTA5LTI4IDA5OjI4OjE1LjAwMDAwMDAwMCArMDgwMApAQCAtMzg5LDggKzM4OSwx
MSBAQCBzdHJ1Y3QgaGlkX2lucHV0IHsKIAlzdHJ1Y3QgbGlzdF9oZWFkIGxpc3Q7CiAJc3RydWN0
IGhpZF9yZXBvcnQgKnJlcG9ydDsKIAlzdHJ1Y3QgaW5wdXRfZGV2ICppbnB1dDsKKwl2b2lkICpw
cml2YXRlOwogfTsKIAorc3RydWN0IGhpZGlucHV0X3NpbXBsZV9kcml2ZXI7CisKIHN0cnVjdCBo
aWRfZGV2aWNlIHsJCQkJCQkJLyogZGV2aWNlIHJlcG9ydCBkZXNjcmlwdG9yICovCiAJIF9fdTgg
KnJkZXNjOwogCXVuc2lnbmVkIHJzaXplOwpAQCAtNDU0LDYgKzQ1Nyw4IEBAIHN0cnVjdCBoaWRf
ZGV2aWNlIHsJCQkJCQkJLyogZGV2aWNlIHJlcG8KIAlpbnQgKCpmZl9ldmVudCkoc3RydWN0IGhp
ZF9kZXZpY2UgKmhpZCwgc3RydWN0IGlucHV0X2RldiAqaW5wdXQsCiAJCQl1bnNpZ25lZCBpbnQg
dHlwZSwgdW5zaWduZWQgaW50IGNvZGUsIGludCB2YWx1ZSk7CiAKKwlzdHJ1Y3QgaGlkaW5wdXRf
c2ltcGxlX2RyaXZlciAqc2ltcGxlOworCiAjaWZkZWYgQ09ORklHX1VTQl9ISURJTlBVVF9QT1dF
UkJPT0sKIAl1bnNpZ25lZCBsb25nIHBiX3ByZXNzZWRfZm5bTkJJVFMoS0VZX01BWCldOwogCXVu
c2lnbmVkIGxvbmcgcGJfcHJlc3NlZF9udW1sb2NrW05CSVRTKEtFWV9NQVgpXTsKZGlmZiAtTmF1
cnAgbGludXgtMi42LjE4L2RyaXZlcnMvdXNiL2lucHV0L2hpZC1pbnB1dC5jIGxpbnV4LTIuNi4x
OC9kcml2ZXJzL3VzYi9pbnB1dC5uZXcvaGlkLWlucHV0LmMKLS0tIGxpbnV4LTIuNi4xOC9kcml2
ZXJzL3VzYi9pbnB1dC9oaWQtaW5wdXQuYwkyMDA2LTA5LTIwIDExOjQyOjA2LjAwMDAwMDAwMCAr
MDgwMAorKysgbGludXgtMi42LjE4L2RyaXZlcnMvdXNiL2lucHV0Lm5ldy9oaWQtaW5wdXQuYwky
MDA2LTA5LTI4IDA5OjI4OjE1LjAwMDAwMDAwMCArMDgwMApAQCAtMzQsNyArMzQsNyBAQAogI3Vu
ZGVmIERFQlVHCiAKICNpbmNsdWRlICJoaWQuaCIKLQorI2luY2x1ZGUgImhpZC1zaW1wbGUuaCIK
ICNkZWZpbmUgdW5rCUtFWV9VTktOT1dOCiAKIHN0YXRpYyBjb25zdCB1bnNpZ25lZCBjaGFyIGhp
ZF9rZXlib2FyZFsyNTZdID0gewpAQCAtNjEsNiArNjEsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0
IHsKIAlfX3MzMiB5OwogfSAgaGlkX2hhdF90b19heGlzW10gPSB7eyAwLCAwfSwgeyAwLC0xfSwg
eyAxLC0xfSwgeyAxLCAwfSwgeyAxLCAxfSwgeyAwLCAxfSwgey0xLCAxfSwgey0xLCAwfSwgey0x
LC0xfX07CiAKK3R5cGVkZWYgdm9pZCAoKmRvX3VzYWdlX3QpKHN0cnVjdCBoaWRfZmllbGQgKiwg
c3RydWN0IGhpZF91c2FnZSAqKTsKKwogI2RlZmluZSBtYXBfYWJzKGMpCWRvIHsgdXNhZ2UtPmNv
ZGUgPSBjOyB1c2FnZS0+dHlwZSA9IEVWX0FCUzsgYml0ID0gaW5wdXQtPmFic2JpdDsgbWF4ID0g
QUJTX01BWDsgfSB3aGlsZSAoMCkKICNkZWZpbmUgbWFwX3JlbChjKQlkbyB7IHVzYWdlLT5jb2Rl
ID0gYzsgdXNhZ2UtPnR5cGUgPSBFVl9SRUw7IGJpdCA9IGlucHV0LT5yZWxiaXQ7IG1heCA9IFJF
TF9NQVg7IH0gd2hpbGUgKDApCiAjZGVmaW5lIG1hcF9rZXkoYykJZG8geyB1c2FnZS0+Y29kZSA9
IGM7IHVzYWdlLT50eXBlID0gRVZfS0VZOyBiaXQgPSBpbnB1dC0+a2V5Yml0OyBtYXggPSBLRVlf
TUFYOyB9IHdoaWxlICgwKQpAQCAtNzQ3LDggKzc0OSwxMyBAQCBzdGF0aWMgaW50IGhpZGlucHV0
X2lucHV0X2V2ZW50KHN0cnVjdCBpCiAJc3RydWN0IGhpZF9maWVsZCAqZmllbGQ7CiAJaW50IG9m
ZnNldDsKIAotCWlmICh0eXBlID09IEVWX0ZGKQorCWlmICh0eXBlID09IEVWX0ZGKSB7CisJCWlm
IChoaWQtPnNpbXBsZSAmJiBoaWQtPnNpbXBsZS0+ZmZfZXZlbnQpIHsKKwkJCWlmICghaGlkLT5z
aW1wbGUtPmZmX2V2ZW50KGRldiwgdHlwZSwgY29kZSwgdmFsdWUpKTsKKwkJCQlyZXR1cm4gMDsK
KwkJfQogCQlyZXR1cm4gaGlkX2ZmX2V2ZW50KGhpZCwgZGV2LCB0eXBlLCBjb2RlLCB2YWx1ZSk7
CisJfQogCiAJaWYgKHR5cGUgIT0gRVZfTEVEKQogCQlyZXR1cm4gLTE7CkBAIC03NjcsMTIgKzc3
NCwyMiBAQCBzdGF0aWMgaW50IGhpZGlucHV0X2lucHV0X2V2ZW50KHN0cnVjdCBpCiBzdGF0aWMg
aW50IGhpZGlucHV0X29wZW4oc3RydWN0IGlucHV0X2RldiAqZGV2KQogewogCXN0cnVjdCBoaWRf
ZGV2aWNlICpoaWQgPSBkZXYtPnByaXZhdGU7Ci0JcmV0dXJuIGhpZF9vcGVuKGhpZCk7CisJaW50
IHJldCA9IDA7CisKKwlpZiAoaGlkLT5zaW1wbGUgJiYgaGlkLT5zaW1wbGUtPm9wZW4pCisJCXJl
dCA9IGhpZC0+c2ltcGxlLT5vcGVuKGRldik7CisJaWYgKCFyZXQpCisJCXJldHVybiBoaWRfb3Bl
bihoaWQpOworCWVsc2UKKwkJcmV0dXJuIHJldDsKIH0KIAogc3RhdGljIHZvaWQgaGlkaW5wdXRf
Y2xvc2Uoc3RydWN0IGlucHV0X2RldiAqZGV2KQogewogCXN0cnVjdCBoaWRfZGV2aWNlICpoaWQg
PSBkZXYtPnByaXZhdGU7CisKKwlpZiAoaGlkLT5zaW1wbGUgJiYgaGlkLT5zaW1wbGUtPmNsb3Nl
KQorCQloaWQtPnNpbXBsZS0+Y2xvc2UoZGV2KTsKIAloaWRfY2xvc2UoaGlkKTsKIH0KIApAQCAt
ODIxLDcgKzgzOCw3IEBAIGludCBoaWRpbnB1dF9jb25uZWN0KHN0cnVjdCBoaWRfZGV2aWNlICoK
IAkJCQlpbnB1dF9kZXYtPmV2ZW50ID0gaGlkaW5wdXRfaW5wdXRfZXZlbnQ7CiAJCQkJaW5wdXRf
ZGV2LT5vcGVuID0gaGlkaW5wdXRfb3BlbjsKIAkJCQlpbnB1dF9kZXYtPmNsb3NlID0gaGlkaW5w
dXRfY2xvc2U7Ci0KKwkJCQloaWRpbnB1dF9zaW1wbGVfZHJpdmVyX2ZmX2luaXQoaW5wdXRfZGV2
KTsKIAkJCQlpbnB1dF9kZXYtPm5hbWUgPSBoaWQtPm5hbWU7CiAJCQkJaW5wdXRfZGV2LT5waHlz
ID0gaGlkLT5waHlzOwogCQkJCWlucHV0X2Rldi0+dW5pcSA9IGhpZC0+dW5pcTsKZGlmZiAtTmF1
cnAgbGludXgtMi42LjE4L2RyaXZlcnMvdXNiL2lucHV0L2hpZC1zaW1wbGUuYyBsaW51eC0yLjYu
MTgvZHJpdmVycy91c2IvaW5wdXQubmV3L2hpZC1zaW1wbGUuYwotLS0gbGludXgtMi42LjE4L2Ry
aXZlcnMvdXNiL2lucHV0L2hpZC1zaW1wbGUuYwkxOTcwLTAxLTAxIDA4OjAwOjAwLjAwMDAwMDAw
MCArMDgwMAorKysgbGludXgtMi42LjE4L2RyaXZlcnMvdXNiL2lucHV0Lm5ldy9oaWQtc2ltcGxl
LmMJMjAwNi0wOS0yOSAwOTo0OTozMy4wMDAwMDAwMDAgKzA4MDAKQEAgLTAsMCArMSwzMTUgQEAK
Ky8qCisgKiAgSElEIFNpbXBsZSBEcml2ZXIgSW50ZXJmYWNlIHYwLjMuMgorICogCisgKiAgQ29w
eXJpZ2h0IChjKSAyMDA2IExpIFl1IDxyYWlzZS5zYWlsQGdtYWlsLmNvbT4KKyAqLworCisvKgor
ICogVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0
IGFuZC9vciBtb2RpZnkKKyAqIGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwg
UHVibGljIExpY2Vuc2UgYXMgcHVibGlzaGVkIGJ5CisgKiB0aGUgRnJlZSBTb2Z0d2FyZSBGb3Vu
ZGF0aW9uOyBlaXRoZXIgdmVyc2lvbiAyIG9mIHRoZSBMaWNlbnNlLCBvcgorICogKGF0IHlvdXIg
b3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4KKyAqCisgKiBUaGlzIHByb2dyYW0gaXMgZGlzdHJp
YnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3aWxsIGJlIHVzZWZ1bCwKKyAqIGJ1dCBXSVRIT1VU
IEFOWSBXQVJSQU5UWTsgd2l0aG91dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mCisgKiBN
RVJDSEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuICBTZWUg
dGhlCisgKiBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IgbW9yZSBkZXRhaWxzLgorICoK
KyAqIFlvdSBzaG91bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFsIFB1
YmxpYyBMaWNlbnNlCisgKiBhbG9uZyB3aXRoIHRoaXMgcHJvZ3JhbTsgaWYgbm90LCB3cml0ZSB0
byB0aGUgRnJlZSBTb2Z0d2FyZQorICogRm91bmRhdGlvbiwgSW5jLiwgNTkgVGVtcGxlIFBsYWNl
LCBTdWl0ZSAzMzAsIEJvc3RvbiwgTUEgMDIxMTEtMTMwNyBVU0EKKyAqCisgKiBTaG91bGQgeW91
IG5lZWQgdG8gY29udGFjdCBtZSwgdGhlIGF1dGhvciwgeW91IGNhbiBkbyBzbyBlaXRoZXIgYnkK
KyAqIGUtbWFpbCAtIG1haWwgeW91ciBtZXNzYWdlIHRvIDx2b2p0ZWNoQHVjdy5jej4sIG9yIGJ5
IHBhcGVyIG1haWw6CisgKiBWb2p0ZWNoIFBhdmxpaywgU2ltdW5rb3ZhIDE1OTQsIFByYWd1ZSA4
LCAxODIgMDAgQ3plY2ggUmVwdWJsaWMKKyAqLworCisjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+
CisjaW5jbHVkZSA8bGludXgvc2xhYi5oPgorI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPgorI2lu
Y2x1ZGUgPGxpbnV4L2lucHV0Lmg+CisKKyNpbmNsdWRlICJoaWQuaCIKKyNpbmNsdWRlICJoaWQt
c2ltcGxlLmgiCisKK3R5cGVkZWYgdm9pZCAoKmRvX3VzYWdlX3QpKHN0cnVjdCBoaWRfZmllbGQg
Kiwgc3RydWN0IGhpZF91c2FnZSAqKTsKKworaW50IGhpZGlucHV0X3NpbXBsZV9kcml2ZXJfaW5p
dChzdHJ1Y3QgaGlkaW5wdXRfc2ltcGxlX2RyaXZlciAqZHJ2KQoreworCWlmICh1bmxpa2VseSgh
ZHJ2KSkKKwkJcmV0dXJuIC1FSU5WQUw7CisJSU5JVF9MSVNUX0hFQUQoJmRydi0+bm9kZSk7CisJ
SU5JVF9MSVNUX0hFQUQoJmRydi0+cmF3X2RldmljZXMpOworCWRydi0+ZmxhZ3MgPSAwOworCXJl
dHVybiAwOworfQorCitzdGF0aWMgdm9pZCBpbmxpbmUgaGlkaW5wdXRfc2ltcGxlX2NvbmZpZ3Vy
ZV9vbmVfdXNhZ2UoaW50IG9wLCAKKwkJCQkJCXN0cnVjdCBpbnB1dF9kZXYgKmlucHV0LAorCQkJ
CQkJc3RydWN0IGhpZF91c2FnZSAqdXNhZ2UsCisJCQkJCQlzdHJ1Y3QgdXNhZ2VfYmxvY2sgKnVz
YWdlX2Jsb2NrKQoreworCXVuc2lnbmVkIGxvbmcgKmJpdHM7CisJaW50IGZsYWc7CisJc3RydWN0
IGhpZF9kZXZpY2UgKmhpZDsKKworCWhpZCA9IGlucHV0LT5wcml2YXRlOworCXN3aXRjaCAodXNh
Z2VfYmxvY2stPmV2ZW50KSB7CisJY2FzZSBFVl9LRVk6CisJCWZsYWcgPSBISURJTlBVVF9TSU1Q
TEVfS0VZQklUOworCQliaXRzID0gaW5wdXQtPmtleWJpdDsKKwkJYnJlYWs7CisJY2FzZSBFVl9S
RUw6CisJCWZsYWcgPSBISURJTlBVVF9TSU1QTEVfUkVMQklUOworCQliaXRzID0gaW5wdXQtPnJl
bGJpdDsKKwkJYnJlYWs7CisJY2FzZSBFVl9BQlM6CisJCWZsYWcgPSBISURJTlBVVF9TSU1QTEVf
QUJTQklUOworCQliaXRzID0gaW5wdXQtPnJlbGJpdDsKKwkJYnJlYWs7CisJY2FzZSBFVl9NU0M6
CisJCWZsYWcgPSBISURJTlBVVF9TSU1QTEVfTVNDQklUOworCQliaXRzID0gaW5wdXQtPmFic2Jp
dDsKKwkJYnJlYWs7CisJY2FzZSBFVl9TVzoKKwkJZmxhZyA9IEhJRElOUFVUX1NJTVBMRV9TV0JJ
VDsKKwkJYml0cyA9IGlucHV0LT5zd2JpdDsKKwkJYnJlYWs7CisJY2FzZSBFVl9MRUQ6CisJCWZs
YWcgPSBISURJTlBVVF9TSU1QTEVfTEVEQklUOworCQliaXRzID0gaW5wdXQtPmxlZGJpdDsKKwkJ
YnJlYWs7CisJY2FzZSBFVl9TTkQ6CisJCWZsYWcgPSBISURJTlBVVF9TSU1QTEVfU05EQklUOwor
CQliaXRzID0gaW5wdXQtPnNuZGJpdDsKKwkJYnJlYWs7CisJY2FzZSBFVl9GRjoKKwkJZmxhZyA9
IEhJRElOUFVUX1NJTVBMRV9GRkJJVDsKKwkJYml0cyA9IGlucHV0LT5mZmJpdDsKKwkJYnJlYWs7
CisJY2FzZSBFVl9GRl9TVEFUVVM6CisJCWZsYWcgPSBISURJTlBVVF9TSU1QTEVfRkZTVFNCSVQ7
CisJCWJpdHMgPSBOVUxMOworCQlicmVhazsKKwlkZWZhdWx0OgorCQlyZXR1cm47CisJfQorCisJ
aWYgKF9fT1BfU0VUX0JJVCA9PSBvcCkgeworCQl1c2FnZS0+Y29kZSA9IHVzYWdlX2Jsb2NrLT5j
b2RlOworCQl1c2FnZS0+dHlwZSA9IHVzYWdlX2Jsb2NrLT5ldmVudDsKKwkJaWYgKGJpdHMpCisJ
CQlzZXRfYml0KHVzYWdlX2Jsb2NrLT5jb2RlLCBiaXRzKTsKKwkJLyogaWYgdGhpcyBldmVudCBi
aXQgaXMgc2V0IGJ5IHVzIGZpcnN0LCByZW1lbWJlciBpdCAqLworCQlpZiAoIXRlc3RfYW5kX3Nl
dF9iaXQodXNhZ2VfYmxvY2stPmV2ZW50LCBpbnB1dC0+ZXZiaXQpKQorCQkJc2V0X2JpdChmbGFn
LCAmaGlkLT5zaW1wbGUtPmZsYWdzKTsKKwl9CisJZWxzZSBpZiAoX19PUF9DTFJfQklUID09IG9w
KSB7CisJCXVzYWdlLT5jb2RlID0gMDsKKwkJdXNhZ2UtPnR5cGUgPSAwOworCQlpZiAoYml0cykK
KwkJCWNsZWFyX2JpdCh1c2FnZV9ibG9jay0+Y29kZSwgYml0cyk7CisJCS8qIGNsZWFyIGV2ZW50
IGJpdCwgb25seSBpZiBpdCdzIHNldCBieSB1cy4gKi8KKwkJaWYgKHRlc3RfYW5kX2NsZWFyX2Jp
dChmbGFnLCAmaGlkLT5zaW1wbGUtPmZsYWdzKSkKKwkJCWNsZWFyX2JpdCh1c2FnZV9ibG9jay0+
ZXZlbnQsIGlucHV0LT5ldmJpdCk7CisJfQorfQorCitzdGF0aWMgZG9fdXNhZ2VfdCBoaWRpbnB1
dF9zaW1wbGVfZHJpdmVyX2NvbmZpZ3VyZV91c2FnZV9wcmVwKAorCQkJCQkJCXN0cnVjdCBoaWRf
ZGV2aWNlICpoaWQsCisJCQkJCQkJaW50ICpvcCkKK3sKKwlkb191c2FnZV90IGRvX3VzYWdlOwor
CisJaWYgKCFoaWQtPnNpbXBsZSkKKwkJcmV0dXJuIE5VTEw7CisKKwlpZiAodGVzdF9iaXQoSElE
SU5QVVRfU0lNUExFX1NFVFVQX1VTQUdFLCAmaGlkLT5zaW1wbGUtPmZsYWdzKSkgeworCQlkb191
c2FnZSA9IGhpZC0+c2ltcGxlLT5zZXR1cF91c2FnZTsKKwkJKm9wID0gX19PUF9TRVRfQklUOwor
CX0KKwllbHNlIHsKKwkJZG9fdXNhZ2UgPSBoaWQtPnNpbXBsZS0+Y2xlYXJfdXNhZ2U7CisJCSpv
cCA9IF9fT1BfQ0xSX0JJVDsKKwl9CisJcmV0dXJuIGRvX3VzYWdlOworfQorCitzdGF0aWMgdm9p
ZCBfX2hpZGlucHV0X3NpbXBsZV9kcml2ZXJfY29uZmlndXJlX3VzYWdlKGludCBvcCwKKwkJCQkJ
CXN0cnVjdCBoaWRfZmllbGQgKmZpZWxkLAorCQkJCQkJc3RydWN0IGhpZF91c2FnZSAqaGlkX3Vz
YWdlKQoreworCXN0cnVjdCBpbnB1dF9kZXYgKmlucHV0ID0gZmllbGQtPmhpZGlucHV0LT5pbnB1
dDsKKwlzdHJ1Y3QgaGlkX2RldmljZSAqaGlkID0gaW5wdXQtPnByaXZhdGU7CisJc3RydWN0IHVz
YWdlX2Jsb2NrICp1c2FnZV9ibG9jazsKKwlzdHJ1Y3QgdXNhZ2VfcGFnZV9ibG9jayAqcGFnZV9i
bG9jazsKKwlpbnQgcGFnZTsKKwlpbnQgdXNhZ2U7CisKKwlwYWdlID0gKGhpZF91c2FnZS0+aGlk
ICYgSElEX1VTQUdFX1BBR0UpOworCXVzYWdlID0gKGhpZF91c2FnZS0+aGlkICYgSElEX1VTQUdF
KTsKKwlwYWdlX2Jsb2NrID0gaGlkLT5zaW1wbGUtPnVzYWdlX3BhZ2VfdGFibGU7CisJZm9yICg7
cGFnZV9ibG9jayAmJiBwYWdlX2Jsb2NrLT51c2FnZV9ibG9ja2VzO3BhZ2VfYmxvY2srKykgewor
CQlpZiAocGFnZV9ibG9jay0+cGFnZSAhPSBwYWdlKQorCQkJY29udGludWU7CisJCXVzYWdlX2Js
b2NrID0gcGFnZV9ibG9jay0+dXNhZ2VfYmxvY2tlczsKKwkJZm9yICg7IHVzYWdlX2Jsb2NrICYm
IHVzYWdlX2Jsb2NrLT51c2FnZTsgdXNhZ2VfYmxvY2srKykgeworCQkJaWYgKHVzYWdlX2Jsb2Nr
LT51c2FnZSAhPSB1c2FnZSkKKwkJCQljb250aW51ZTsKKwkJCWhpZGlucHV0X3NpbXBsZV9jb25m
aWd1cmVfb25lX3VzYWdlKG9wLCBpbnB1dCwgCisJCQkJCQloaWRfdXNhZ2UsIHVzYWdlX2Jsb2Nr
KTsKKwkJfQorCX0KK30KKworLyoKKyAqICBUbyBnaXZlIG9uZSBzaW1wbGUgZGV2aWNlIGEgY29u
ZmlndXJlIHVzYWdlIGNoYW5jZS4KKyAqICBUaGUgZnJhbWV3b3JrIG9mIHRoaXMgZnVuY3Rpb24g
Y29tZSBmcm9tIGhpZGlucHV0X2Nvbm5lY3QoKQorICovCit2b2lkIGhpZGlucHV0X3NpbXBsZV9k
cml2ZXJfY29uZmlndXJlX3VzYWdlKHN0cnVjdCBoaWRfZGV2aWNlICpoaWQpCit7CisJc3RydWN0
IGhpZF9yZXBvcnQgKnJlcG9ydDsKKwlpbnQgaSwgaiwgazsKKwlkb191c2FnZV90IGRvX3VzYWdl
OworCWludCBvcDsKKworCWlmICghaGlkLT5zaW1wbGUpCisJCXJldHVybjsKKwlkb191c2FnZSA9
IGhpZGlucHV0X3NpbXBsZV9kcml2ZXJfY29uZmlndXJlX3VzYWdlX3ByZXAoaGlkLCAmb3ApOwor
CisJZm9yIChpID0gMDsgaSA8IGhpZC0+bWF4Y29sbGVjdGlvbjsgaSsrKQorCQlpZiAoaGlkLT5j
b2xsZWN0aW9uW2ldLnR5cGUgPT0gSElEX0NPTExFQ1RJT05fQVBQTElDQVRJT04gfHwKKwkJCWhp
ZC0+Y29sbGVjdGlvbltpXS50eXBlPT1ISURfQ09MTEVDVElPTl9QSFlTSUNBTCkKKwkJCWlmIChJ
U19JTlBVVF9BUFBMSUNBVElPTihoaWQtPmNvbGxlY3Rpb25baV0udXNhZ2UpKQorCQkJCWJyZWFr
OworCisJaWYgKGkgPT0gaGlkLT5tYXhjb2xsZWN0aW9uKQorCQlyZXR1cm47CisKKwlmb3IgKGsg
PSBISURfSU5QVVRfUkVQT1JUOyBrIDw9IEhJRF9PVVRQVVRfUkVQT1JUOyBrKyspCisJCWxpc3Rf
Zm9yX2VhY2hfZW50cnkocmVwb3J0LCAmaGlkLT5yZXBvcnRfZW51bVtrXS5yZXBvcnRfbGlzdCwg
bGlzdCkgeworCQkJaWYgKCFyZXBvcnQtPm1heGZpZWxkKQorCQkJCWNvbnRpbnVlOworCisJCQlm
b3IgKGkgPSAwOyBpIDwgcmVwb3J0LT5tYXhmaWVsZDsgaSsrKQorCQkJCWZvciAoaiA9IDA7IGog
PCByZXBvcnQtPmZpZWxkW2ldLT5tYXh1c2FnZTsgaisrKSB7CisJCQkJCV9faGlkaW5wdXRfc2lt
cGxlX2RyaXZlcl9jb25maWd1cmVfdXNhZ2Uob3AsIHJlcG9ydC0+ZmllbGRbaV0sIHJlcG9ydC0+
ZmllbGRbaV0tPnVzYWdlICsgaik7CisJCQkJCWlmIChkb191c2FnZSkKKwkJCQkJCWRvX3VzYWdl
KHJlcG9ydC0+ZmllbGRbaV0sCisJCQkJCQlyZXBvcnQtPmZpZWxkW2ldLT51c2FnZSArIGopOwor
CQkJCX0KKwkJfQorCisJcmV0dXJuOworfQorCitpbnQgaGlkaW5wdXRfc2ltcGxlX2RyaXZlcl9w
dXNoKHN0cnVjdCBoaWRfZGV2aWNlICpoaWQsIAorCQkJCQlzdHJ1Y3QgaGlkaW5wdXRfc2ltcGxl
X2RyaXZlciAqc2ltcGxlLAorCQkJCQlzdHJ1Y3QgbWF0Y2hlZF9kZXZpY2UgKm1hdGNoZWQpCit7
CisJc3RydWN0IHJhd19zaW1wbGVfZGV2aWNlICpyYXdfc2ltcGxlOworCisJcmF3X3NpbXBsZSA9
IGttYWxsb2Moc2l6ZW9mKHN0cnVjdCByYXdfc2ltcGxlX2RldmljZSksIEdGUF9LRVJORUwpOwor
CWlmICghcmF3X3NpbXBsZSkKKwkJcmV0dXJuIC1FTk9NRU07CisJcmF3X3NpbXBsZS0+aW50ZiA9
IG1hdGNoZWQtPmludGY7CisJaGlkID0gdXNiX2dldF9pbnRmZGF0YShtYXRjaGVkLT5pbnRmKTsK
KwloaWQtPnNpbXBsZSA9IHNpbXBsZTsKKwlsaXN0X2FkZCgmcmF3X3NpbXBsZS0+bm9kZSwgJnNp
bXBsZS0+cmF3X2RldmljZXMpOworCXJldHVybiAwOworfQorCit2b2lkIGhpZGlucHV0X3NpbXBs
ZV9kcml2ZXJfcG9wKHN0cnVjdCBoaWRfZGV2aWNlICpoaWQsCisJCQkJCXN0cnVjdCBtYXRjaGVk
X2RldmljZSAqbWF0Y2hlZCkKK3sKKwlzdHJ1Y3QgbGlzdF9oZWFkICpub2RlOworCXN0cnVjdCBy
YXdfc2ltcGxlX2RldmljZSAqcmF3X3NpbXBsZT1OVUxMOworCisJbGlzdF9mb3JfZWFjaCAobm9k
ZSwgJmhpZC0+c2ltcGxlLT5yYXdfZGV2aWNlcykgeworCQlyYXdfc2ltcGxlID0gbGlzdF9lbnRy
eShub2RlLCBzdHJ1Y3QgcmF3X3NpbXBsZV9kZXZpY2UsIG5vZGUpOworCQlpZiAocmF3X3NpbXBs
ZSAmJiByYXdfc2ltcGxlLT5pbnRmID09IG1hdGNoZWQtPmludGYpIHsKKwkJCWhpZC0+c2ltcGxl
ID0gTlVMTDsKKwkJCWxpc3RfZGVsKCZyYXdfc2ltcGxlLT5ub2RlKTsKKwkJCWtmcmVlKHJhd19z
aW1wbGUpOworCQkJcmV0dXJuOworCQl9CisJfQorfQorCit2b2lkIGhpZGlucHV0X3NpbXBsZV9k
cml2ZXJfY2xlYXIoc3RydWN0IGhpZGlucHV0X3NpbXBsZV9kcml2ZXIgKnNpbXBsZSkKK3sKKwlz
dHJ1Y3QgcmF3X3NpbXBsZV9kZXZpY2UgKnJhd19zaW1wbGU7CisJc3RydWN0IGhpZF9kZXZpY2Ug
KmhpZDsKKworCXdoaWxlICghbGlzdF9lbXB0eV9jYXJlZnVsKCZzaW1wbGUtPnJhd19kZXZpY2Vz
KSkgeworCQlyYXdfc2ltcGxlID0gbGlzdF9lbnRyeShzaW1wbGUtPnJhd19kZXZpY2VzLm5leHQs
IAorCQkJCQlzdHJ1Y3QgcmF3X3NpbXBsZV9kZXZpY2UsIG5vZGUpOworCQloaWQgPSB1c2JfZ2V0
X2ludGZkYXRhIChyYXdfc2ltcGxlLT5pbnRmKTsKKwkJaWYgKGhpZCkgeworCQkJaWYgKGhpZC0+
c2ltcGxlKQorCQkJCUJVR19PTihoaWQtPnNpbXBsZSAhPSBzaW1wbGUpOworCQkJaGlkaW5wdXRf
c2ltcGxlX2RyaXZlcl9jbGVhcl91c2FnZShoaWQpOworCQkJd21iKCk7CisJCQloaWRpbnB1dF9z
aW1wbGVfZHJpdmVyX2Rpc2Nvbm5lY3QoaGlkKTsKKwkJCWhpZC0+c2ltcGxlID0gTlVMTDsKKwkJ
fQorCQlsaXN0X2RlbF9pbml0KHNpbXBsZS0+cmF3X2RldmljZXMubmV4dCk7CisJfQorfQorCitp
bnQgaGlkaW5wdXRfc2ltcGxlX2RyaXZlcl9jb25uZWN0KHN0cnVjdCBoaWRpbnB1dF9zaW1wbGVf
ZHJpdmVyICpzaW1wbGUsIAorCQkJCQkJc3RydWN0IGhpZF9kZXZpY2UgKmhpZCkKK3sKKwlzdHJ1
Y3QgaGlkX2lucHV0ICpoaWRpbnB1dCwgKm5leHQ7CisJaW50IHJldCA9IC1FTk9ERVY7CisKKwlp
ZiAoIXNpbXBsZSkKKwkJZ290byBleGl0OworCWlmICghc2ltcGxlLT5jb25uZWN0KSB7CisJCXJl
dCA9IDA7CisJCWdvdG8gZXhpdDsKKwl9CisKKwlsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUoaGlk
aW5wdXQsIG5leHQsICZoaWQtPmlucHV0cywgbGlzdCkgeworCQlpZiAoIXNpbXBsZS0+Y29ubmVj
dChoaWQsIGhpZGlucHV0KSkgeworCQkJaGlkLT5zaW1wbGUgPSBzaW1wbGU7CisJCQlyZXQgPSAw
OworCQl9CisJfQorZXhpdDoKKwlzZXRfYml0KEhJRElOUFVUX1NJTVBMRV9DT05ORUNURUQsICZz
aW1wbGUtPmZsYWdzKTsKKwlyZXR1cm4gcmV0OworfQorCisKK3ZvaWQgaGlkaW5wdXRfc2ltcGxl
X2RyaXZlcl9kaXNjb25uZWN0KHN0cnVjdCBoaWRfZGV2aWNlICpoaWQpCit7CisJc3RydWN0IGhp
ZF9pbnB1dCAqaGlkaW5wdXQsICpuZXh0OworCisJaWYgKCFoaWQgfHwgIWhpZC0+c2ltcGxlKQor
CQlyZXR1cm47CisKKwlpZiAoIWhpZC0+c2ltcGxlLT5kaXNjb25uZWN0KQorCQlnb3RvIGV4aXQ7
CisJbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlKGhpZGlucHV0LCBuZXh0LCAmaGlkLT5pbnB1dHMs
IGxpc3QpIHsKKwkJaGlkLT5zaW1wbGUtPmRpc2Nvbm5lY3QoaGlkLCBoaWRpbnB1dCk7CisJfQor
ZXhpdDoKKwljbGVhcl9iaXQoSElESU5QVVRfU0lNUExFX0NPTk5FQ1RFRCwgJmhpZC0+c2ltcGxl
LT5mbGFncyk7CisJcmV0dXJuOworfQorCitzdHJ1Y3QgaGlkX2lucHV0KiBoaWRpbnB1dF9zaW1w
bGVfaW5wdXRkZXZfdG9faGlkaW5wdXQoc3RydWN0IGlucHV0X2RldiAqZGV2KQoreworCXN0cnVj
dCBoaWRfZGV2aWNlICpoaWQgPSBkZXYtPnByaXZhdGU7CisJc3RydWN0IGxpc3RfaGVhZCAqaXRl
cjsKKwlzdHJ1Y3QgaGlkX2lucHV0ICpoaWRpbnB1dDsKKworCWxpc3RfZm9yX2VhY2goaXRlciwg
JmhpZC0+aW5wdXRzKSB7CisJCWhpZGlucHV0ID0gbGlzdF9lbnRyeShpdGVyLCBzdHJ1Y3QgaGlk
X2lucHV0LCBsaXN0KTsKKwkJaWYgKGhpZGlucHV0LT5pbnB1dCA9PSBkZXYpCisJCQlyZXR1cm4g
aGlkaW5wdXQ7CisJfQorCXJldHVybiBOVUxMOworfQorRVhQT1JUX1NZTUJPTF9HUEwoaGlkaW5w
dXRfc2ltcGxlX2lucHV0ZGV2X3RvX2hpZGlucHV0KTsKZGlmZiAtTmF1cnAgbGludXgtMi42LjE4
L2RyaXZlcnMvdXNiL2lucHV0L2hpZC1zaW1wbGUuaCBsaW51eC0yLjYuMTgvZHJpdmVycy91c2Iv
aW5wdXQubmV3L2hpZC1zaW1wbGUuaAotLS0gbGludXgtMi42LjE4L2RyaXZlcnMvdXNiL2lucHV0
L2hpZC1zaW1wbGUuaAkxOTcwLTAxLTAxIDA4OjAwOjAwLjAwMDAwMDAwMCArMDgwMAorKysgbGlu
dXgtMi42LjE4L2RyaXZlcnMvdXNiL2lucHV0Lm5ldy9oaWQtc2ltcGxlLmgJMjAwNi0wOS0yOCAw
OToyODoxNS4wMDAwMDAwMDAgKzA4MDAKQEAgLTAsMCArMSwyMzIgQEAKKy8qCisgKiAgTk9URToK
KyAqCUZvciB1c2UgbWUgLCB5b3UgbXVzdCBpbmNsdWRlIGhpZC5oIGluIHlvdXIgc291cmNlIGZp
cnN0LiAKKyAqLworI2lmbmRlZiBfX0hJRF9TSU1QTEVfSAorI2RlZmluZSBfX0hJRF9TSU1QTEVf
SAorCisjaWZkZWYgX19LRVJORUxfXworCisjaW5jbHVkZSA8bGludXgvdXNiLmg+CisKKy8qKioq
KiBUaGUgcHVibGljIGludGVyZmFjZSBmb3Igc2ltcGxlIGRldmljZSBkcml2ZXIgKioqKiovCitz
dHJ1Y3QgdXNhZ2VfYmxvY2sgeworCWludCB1c2FnZTsgLyogdXNhZ2UgY29kZSAqLworCWludCB2
YWx1ZTsgLyogbm90IHVzZWQsIGZvciBGX0VWRU5UX0JZX1ZBTFVFIGluIGZ1dHVyZSAgKi8KKwlp
bnQgZXZlbnQ7IC8qIGlucHV0IGV2ZW50IHR5cGUsIGUuZy4gRVZfS0VZLiAqLworCWludCBjb2Rl
OyAgLyogaW5wdXQgc3Vic3lzdGVtIGNvZGUsIGUuZy4gS0VZX0YxLiAqLworCWludCBmbGFnczsg
Lyogbm90IHVzZWQgKi8KK307CisKK3N0cnVjdCB1c2FnZV9wYWdlX2Jsb2NrIHsKKwlpbnQgcGFn
ZTsgLyogdXNhZ2UgcGFnZSBjb2RlICovCisJaW50IGZsYWdzOyAvKiBub3QgdXNlZCAqLworCXN0
cnVjdCB1c2FnZV9ibG9jayAqdXNhZ2VfYmxvY2tlczsKK307CisKKy8qIHVzYWdlX2Jsb2NrIGZs
YWdzIGxpc3QgKi8KKyNkZWZpbmUgRl9FVkVOVF9CWV9WQUxVRSAoMHgxKSAvKiBzdWJtaXQgaW5w
dXQgZXZlbnQgYnkgdXNhZ2VfYmxvY2sudmFsdWUsIAorCQkJCSAgbm90IGltcGxlbWVudCB5ZXQg
Ki8KKworI2RlZmluZSBVU0FHRV9CTE9DSyhpX3VzYWdlLCBpX3ZhbHVlLCBpX2V2ZW50LCBpX2Nv
ZGUsIGlfZmxhZ3MpIFwKKwl7XAorCQkudXNhZ2UgPSAoaV91c2FnZSksXAorCQkudmFsdWUgPSAo
aV92YWx1ZSksXAorCQkuZXZlbnQgPSAoaV9ldmVudCksXAorCQkuY29kZSA9IChpX2NvZGUpLFwK
KwkJLmZsYWdzID0gKGlfZmxhZ3MpLFwKKwl9CisKKyNkZWZpbmUgVVNBR0VfQkxPQ0tfTlVMTCB7
fQorCisjZGVmaW5lIFVTQUdFX1BBR0VfQkxPQ0soaV9wYWdlLCBpX3VzYWdlX2Jsb2NrZXMpIFwK
Kwl7XAorCQkucGFnZSA9IChpX3BhZ2UpLFwKKwkJLnVzYWdlX2Jsb2NrZXMgPSAoaV91c2FnZV9i
bG9ja2VzKSxcCisJfQorCisjZGVmaW5lIFVTQUdFX1BBR0VfQkxPQ0tfTlVMTCB7fQorCisjZGVm
aW5lIF9fU0lNUExFX0RSSVZFUl9JTklUIFwKKwkub3duZXIgPSBUSElTX01PRFVMRSwKKworc3Ry
dWN0IGhpZGlucHV0X3NpbXBsZV9kcml2ZXIgeworLyogcHJpdmF0ZSAqLworCXN0cnVjdCBsaXN0
X2hlYWQgbm9kZTsgLyogbGluayB3aXRoIHNpbXBsZV9kcml2ZXJzX2xpc3QgKi8KKwlzdHJ1Y3Qg
bGlzdF9oZWFkIHJhd19kZXZpY2VzOworCXVuc2lnbmVkIGxvbmcgZmxhZ3M7CisvKiBwdWJsaWMg
Ki8KKwlzdHJ1Y3QgbW9kdWxlICpvd25lcjsKKwljaGFyICpuYW1lOworCWludCAoKmNvbm5lY3Qp
KHN0cnVjdCBoaWRfZGV2aWNlICosIHN0cnVjdCBoaWRfaW5wdXQgKik7CQorCXZvaWQgKCpkaXNj
b25uZWN0KShzdHJ1Y3QgaGlkX2RldmljZSAqLCBzdHJ1Y3QgaGlkX2lucHV0ICopOworCXZvaWQg
KCpzZXR1cF91c2FnZSkoc3RydWN0IGhpZF9maWVsZCAqLCAgIHN0cnVjdCBoaWRfdXNhZ2UgKik7
CisJdm9pZCAoKmNsZWFyX3VzYWdlKShzdHJ1Y3QgaGlkX2ZpZWxkICosICAgc3RydWN0IGhpZF91
c2FnZSAqKTsKKwlpbnQgKCpwcmVfZXZlbnQpKGNvbnN0IHN0cnVjdCBoaWRfZGV2aWNlICosIGNv
bnN0IHN0cnVjdCBoaWRfZmllbGQgKiwKKwkJCQkJY29uc3Qgc3RydWN0IGhpZF91c2FnZSAqLCBj
b25zdCBfX3MzMiwKKwkJCQkJY29uc3Qgc3RydWN0IHB0X3JlZ3MgKnJlZ3MpOworCWludCAoKnBv
c3RfZXZlbnQpKGNvbnN0IHN0cnVjdCBoaWRfZGV2aWNlICosIGNvbnN0IHN0cnVjdCBoaWRfZmll
bGQgKiwKKwkJCQkJY29uc3Qgc3RydWN0IGhpZF91c2FnZSAqLCBjb25zdCBfX3MzMiwKKwkJCQkJ
Y29uc3Qgc3RydWN0IHB0X3JlZ3MgKnJlZ3MpOworCWludCAoKm9wZW4pKHN0cnVjdCBpbnB1dF9k
ZXYgKmRldik7CisJdm9pZCAoKmNsb3NlKShzdHJ1Y3QgaW5wdXRfZGV2ICpkZXYpOworICAgICAg
ICBpbnQgKCp1cGxvYWRfZWZmZWN0KShzdHJ1Y3QgaW5wdXRfZGV2ICpkZXYsIHN0cnVjdCBmZl9l
ZmZlY3QgKmVmZmVjdCk7CisgICAgICAgIGludCAoKmVyYXNlX2VmZmVjdCkoc3RydWN0IGlucHV0
X2RldiAqZGV2LCBpbnQgZWZmZWN0X2lkKTsKKwlpbnQgKCpmbHVzaCkoc3RydWN0IGlucHV0X2Rl
diAqZGV2LCBzdHJ1Y3QgZmlsZSAqZmlsZSk7CisJaW50ICgqZmZfZXZlbnQpKHN0cnVjdCBpbnB1
dF9kZXYgKmRldiwgaW50IHR5cGUsIGludCBjb2RlLCBpbnQgdmFsdWUpOworCXN0cnVjdCB1c2Jf
ZGV2aWNlX2lkICppZF90YWJsZTsKKwlzdHJ1Y3QgdXNhZ2VfcGFnZV9ibG9jayAqdXNhZ2VfcGFn
ZV90YWJsZTsKKwl2b2lkICpwcml2YXRlOworfTsKKworCitpbnQgaGlkaW5wdXRfcmVnaXN0ZXJf
c2ltcGxlX2RyaXZlcihzdHJ1Y3QgaGlkaW5wdXRfc2ltcGxlX2RyaXZlciAqZGV2aWNlKTsKK3Zv
aWQgaGlkaW5wdXRfdW5yZWdpc3Rlcl9zaW1wbGVfZHJpdmVyKHN0cnVjdCBoaWRpbnB1dF9zaW1w
bGVfZHJpdmVyICpkZXZpY2UpOworc3RydWN0IGhpZF9pbnB1dCogaGlkaW5wdXRfc2ltcGxlX2lu
cHV0ZGV2X3RvX2hpZGlucHV0KHN0cnVjdCBpbnB1dF9kZXYgKmRldik7CisKKy8qKioqKioqKioq
KioqKioqKioqKiogVGhlIHB1YmxpYyBzZWN0aW9uIGVuZCAqKioqKioqKioqKi8KKworLyoqKioq
IFRoZSBwcml2YXRlIHNlY3Rpb24gZm9yIHNpbXBsZSBkZXZpY2UgZHJpdmVyIGltcGxlbWVudCBv
bmx5ICoqKioqLworCisvKiBzaW1wbGUgZHJpdmVyIGludGVybmFsIGZsYWdzICovCisjZGVmaW5l
IEhJRElOUFVUX1NJTVBMRV9TRVRVUF9VU0FHRQkoMHgwKQorI2RlZmluZSBISURJTlBVVF9TSU1Q
TEVfS0VZQklUCSgweDEpCisjZGVmaW5lIEhJRElOUFVUX1NJTVBMRV9SRUxCSVQJKDB4MikKKyNk
ZWZpbmUgSElESU5QVVRfU0lNUExFX0FCU0JJVAkoMHgzKQorI2RlZmluZSBISURJTlBVVF9TSU1Q
TEVfTVNDQklUCSgweDQpCisjZGVmaW5lIEhJRElOUFVUX1NJTVBMRV9TV0JJVAkoMHg1KQorI2Rl
ZmluZSBISURJTlBVVF9TSU1QTEVfTEVEQklUCSgweDYpCisjZGVmaW5lIEhJRElOUFVUX1NJTVBM
RV9TTkRCSVQJKDB4NykKKyNkZWZpbmUgSElESU5QVVRfU0lNUExFX0ZGQklUCSgweDgpCisjZGVm
aW5lIEhJRElOUFVUX1NJTVBMRV9GRlNUU0JJVAkoMHg5KQorI2RlZmluZSBISURJTlBVVF9TSU1Q
TEVfQ09OTkVDVEVECSgweDFmKQorCisvKiB1c2VkIGluIGhpZGlucHV0X3NpbXBsZV9kcml2ZXJf
Y29uZmlndXJlX3VzYWdlKCkgKi8KKyNkZWZpbmUgX19PUF9TRVRfQklUICgxKQorI2RlZmluZSBf
X09QX0NMUl9CSVQgKDApCisKKy8qIAorICogIG1hdGNoZWRfZGV2aWNlIHJlY29yZCBvbmUgZGV2
aWNlIHdoaWNoIGhpZC1zdWJzeXN0ZW0gaGFuZGxlLCBpdCBtYXkgCisgKiAgYmUgb25lIHNpbXBs
ZSBkZXZpY2UgY2FuIG5vdCBoYW5kbGUuCisgKgorICogIFRoZSBlbGVtZW50IG9mIG1hdGNoZWRf
ZGV2aWNlIGxpc3QgaXMgaW5zZXJ0ZWQgYXQgaGlkaW5wdXRfY29ubmVjdCgpLCAKKyAqICBhbmQg
aXMgcmVtb3ZlZCAgYXQgaGlkaW5wdXRfZGlzY29ubmVjdCgpLgorICovIAorc3RydWN0IG1hdGNo
ZWRfZGV2aWNlIHsKKwlzdHJ1Y3QgdXNiX2ludGVyZmFjZSAqaW50ZjsKKwlzdHJ1Y3QgbGlzdF9o
ZWFkIG5vZGU7Cit9OworCisvKiAKKyAqICByYXdfc2ltcGxlX2RyaXZlciByZWNvcmQgb25lIGRl
dmljZSB3aGljaCBoaWQgc2ltcGxlIGRldmljZSBoYW5kbGUuCisgKiAgSXQgdXNlZCBhcyBvbmUg
bWVtYmVyIG9mIGhpZF9zaW1wbGVfZHJpdmVyLgorICovIAorCitzdHJ1Y3QgcmF3X3NpbXBsZV9k
ZXZpY2UgeworCXN0cnVjdCB1c2JfaW50ZXJmYWNlICppbnRmOworCXN0cnVjdCBsaXN0X2hlYWQg
bm9kZTsKK307CisKKyNpZmRlZiBDT05GSUdfSElEX1NJTVBMRQorZXh0ZXJuIHZvaWQgaGlkaW5w
dXRfc2ltcGxlX2RyaXZlcl9jb25maWd1cmVfdXNhZ2Uoc3RydWN0IGhpZF9kZXZpY2UgKmhpZCk7
CitleHRlcm4gaW50IGhpZGlucHV0X3NpbXBsZV9kcml2ZXJfaW5pdChzdHJ1Y3QgaGlkaW5wdXRf
c2ltcGxlX2RyaXZlciAqc2ltcGxlKTsKK2V4dGVybiBpbnQgaGlkaW5wdXRfc2ltcGxlX2RyaXZl
cl9wdXNoKHN0cnVjdCBoaWRfZGV2aWNlICpoaWQsCisJCQkJc3RydWN0IGhpZGlucHV0X3NpbXBs
ZV9kcml2ZXIgKnNpbXBsZSwKKwkJCQlzdHJ1Y3QgbWF0Y2hlZF9kZXZpY2UgKmRldik7CitleHRl
cm4gdm9pZCBoaWRpbnB1dF9zaW1wbGVfZHJpdmVyX3BvcChzdHJ1Y3QgaGlkX2RldmljZSAqaGlk
LAorCQkJCXN0cnVjdCBtYXRjaGVkX2RldmljZSAqZGV2KTsKK2V4dGVybiB2b2lkIGhpZGlucHV0
X3NpbXBsZV9kcml2ZXJfY2xlYXIoc3RydWN0IGhpZGlucHV0X3NpbXBsZV9kcml2ZXIgKnNpbXBs
ZSk7CitleHRlcm4gaW50IGhpZGlucHV0X3NpbXBsZV9kcml2ZXJfY29ubmVjdChzdHJ1Y3QgaGlk
aW5wdXRfc2ltcGxlX2RyaXZlciAqc2ltcGxlLCAKKwkJCQkJCQlzdHJ1Y3QgaGlkX2RldmljZSAq
aGlkKTsKK2V4dGVybiB2b2lkIGhpZGlucHV0X3NpbXBsZV9kcml2ZXJfZGlzY29ubmVjdChzdHJ1
Y3QgaGlkX2RldmljZSAqaGlkKTsKK3N0YXRpYyB2b2lkIGlubGluZSBoaWRpbnB1dF9zaW1wbGVf
ZHJpdmVyX3NldHVwX3VzYWdlKHN0cnVjdCBoaWRfZGV2aWNlICpoaWQpCit7CisJaWYgKGhpZCAm
JiBoaWQtPnNpbXBsZSkgeworCQlzZXRfYml0KEhJRElOUFVUX1NJTVBMRV9TRVRVUF9VU0FHRSwg
JmhpZC0+c2ltcGxlLT5mbGFncyk7CisJCWhpZGlucHV0X3NpbXBsZV9kcml2ZXJfY29uZmlndXJl
X3VzYWdlKGhpZCk7CisJfQorfQorCitzdGF0aWMgdm9pZCBpbmxpbmUgaGlkaW5wdXRfc2ltcGxl
X2RyaXZlcl9jbGVhcl91c2FnZShzdHJ1Y3QgaGlkX2RldmljZSAqaGlkKQoreworCWlmIChoaWQg
JiYgaGlkLT5zaW1wbGUpIHsKKwkJY2xlYXJfYml0KEhJRElOUFVUX1NJTVBMRV9TRVRVUF9VU0FH
RSwgJmhpZC0+c2ltcGxlLT5mbGFncyk7CisJCWhpZGlucHV0X3NpbXBsZV9kcml2ZXJfY29uZmln
dXJlX3VzYWdlKGhpZCk7CisJfQorfQorCisjaWZkZWYgQ09ORklHX0hJRF9TSU1QTEVfRkYKK3N0
YXRpYyBpbmxpbmUgaW50IGhpZGlucHV0X3VwbG9hZF9lZmZlY3Qoc3RydWN0IGlucHV0X2RldiAq
ZGV2LAorCQkJCQkJc3RydWN0IGZmX2VmZmVjdCAqZWZmZWN0KQoreworCXN0cnVjdCBoaWRfZGV2
aWNlICpoaWQ7CisKKwloaWQgPSBkZXYtPnByaXZhdGU7CisJaWYgKGhpZC0+c2ltcGxlICYmIGhp
ZC0+c2ltcGxlLT51cGxvYWRfZWZmZWN0KQorCQlyZXR1cm4gaGlkLT5zaW1wbGUtPnVwbG9hZF9l
ZmZlY3QoZGV2LCBlZmZlY3QpOworCXJldHVybiAwOworfQorCitzdGF0aWMgaW5saW5lIGludCBo
aWRpbnB1dF9lcmFzZV9lZmZlY3Qoc3RydWN0IGlucHV0X2RldiAqZGV2LCBpbnQgZWZmZWN0X2lk
KQoreworCXN0cnVjdCBoaWRfZGV2aWNlICpoaWQ7CisKKwloaWQgPSBkZXYtPnByaXZhdGU7CisJ
aWYgKGhpZC0+c2ltcGxlICYmIGhpZC0+c2ltcGxlLT5lcmFzZV9lZmZlY3QpCisJCXJldHVybiBo
aWQtPnNpbXBsZS0+ZXJhc2VfZWZmZWN0KGRldiwgZWZmZWN0X2lkKTsKKwlyZXR1cm4gMDsKK30K
Kworc3RhdGljIGlubGluZSBpbnQgaGlkaW5wdXRfZmx1c2goc3RydWN0IGlucHV0X2RldiAqZGV2
LCBzdHJ1Y3QgZmlsZSAqZmlsZXApCit7CisJc3RydWN0IGhpZF9kZXZpY2UgKmhpZDsKKworCWhp
ZCA9IGRldi0+cHJpdmF0ZTsKKwlpZiAoaGlkLT5zaW1wbGUgJiYgaGlkLT5zaW1wbGUtPmZsdXNo
KQorCQlyZXR1cm4gaGlkLT5zaW1wbGUtPmZsdXNoKGRldiwgZmlsZXApOworCXJldHVybiAwOwor
fQorCitzdGF0aWMgdm9pZCBpbmxpbmUgaGlkaW5wdXRfc2ltcGxlX2RyaXZlcl9mZl9pbml0KHN0
cnVjdCBpbnB1dF9kZXYgKmlucHV0X2RldikKK3sKKwlpbnB1dF9kZXYtPnVwbG9hZF9lZmZlY3Qg
PSBoaWRpbnB1dF91cGxvYWRfZWZmZWN0OworCWlucHV0X2Rldi0+ZXJhc2VfZWZmZWN0ID0gaGlk
aW5wdXRfZXJhc2VfZWZmZWN0OworCWlucHV0X2Rldi0+Zmx1c2ggPSBoaWRpbnB1dF9mbHVzaDsK
K30KKyNlbHNlIC8qIENPTkZJR19ISURfU0lNUExFX0ZGICovCitzdGF0aWMgdm9pZCBpbmxpbmUg
aGlkaW5wdXRfc2ltcGxlX2RyaXZlcl9mZl9pbml0KHN0cnVjdCBpbnB1dF9kZXYgKmlucHV0X2Rl
dikge30KKyNlbmRpZiAvKiBDT05GSUdfSElEX1NJTVBMRV9GRiAqLworI2Vsc2UgLyogQ09ORklH
X0hJRF9TSU1QTEUgKi8KK3N0YXRpYyBpbmxpbmUgdm9pZCBoaWRpbnB1dF9zaW1wbGVfZHJpdmVy
X2JpbmRfZm9yZWFjaF9zaW1wbGUoCisJCQkJCXN0cnVjdCBtYXRjaGVkX2RldmljZSAqbWF0Y2hl
ZCkge30KK3N0YXRpYyBpbmxpbmUgdm9pZCBoaWRpbnB1dF9zaW1wbGVfZHJpdmVyX2NvbmZpZ3Vy
ZV91c2FnZShzdHJ1Y3QgaGlkX2RldmljZSAqaGlkKQore30KK3N0YXRpYyBpbmxpbmUgaW50IGhp
ZGlucHV0X3NpbXBsZV9kcml2ZXJfaW5pdChzdHJ1Y3QgaGlkaW5wdXRfc2ltcGxlX2RyaXZlciAq
c2ltcGxlKQoreworCXJldHVybiAwOworfQorc3RhdGljIGlubGluZSBpbnQgaGlkaW5wdXRfc2lt
cGxlX2RyaXZlcl9wdXNoKHN0cnVjdCBoaWRfZGV2aWNlICpoaWQsCisJCQkJc3RydWN0IGhpZGlu
cHV0X3NpbXBsZV9kcml2ZXIgKnNpbXBsZSwKKwkJCQlzdHJ1Y3QgbWF0Y2hlZF9kZXZpY2UgKmRl
dikKK3sKKwlyZXR1cm4gMDsKK30KK3N0YXRpYyBpbmxpbmUgdm9pZCBoaWRpbnB1dF9zaW1wbGVf
ZHJpdmVyX3BvcChzdHJ1Y3QgaGlkX2RldmljZSAqaGlkLAorCQkJCXN0cnVjdCBtYXRjaGVkX2Rl
dmljZSAqZGV2KSB7fQorc3RhdGljIGlubGluZSB2b2lkIGhpZGlucHV0X3NpbXBsZV9kcml2ZXJf
Y2xlYXIoCisJCQkJc3RydWN0IGhpZGlucHV0X3NpbXBsZV9kcml2ZXIgKnNpbXBsZSkge30KK3N0
YXRpYyBpbmxpbmUgaW50IGhpZGlucHV0X3NpbXBsZV9kcml2ZXJfY29ubmVjdCgKKwkJCQlzdHJ1
Y3QgaGlkaW5wdXRfc2ltcGxlX2RyaXZlciAqc2ltcGxlLCAKKwkJCQlzdHJ1Y3QgaGlkX2Rldmlj
ZSAqaGlkKQoreworCXJldHVybiAwOworfQorc3RhdGljIGlubGluZSB2b2lkIGhpZGlucHV0X3Np
bXBsZV9kcml2ZXJfZGlzY29ubmVjdChzdHJ1Y3QgaGlkX2RldmljZSAqaGlkKSB7fQorc3RhdGlj
IGlubGluZSB2b2lkIGhpZGlucHV0X3NpbXBsZV9kcml2ZXJfc2V0dXBfdXNhZ2Uoc3RydWN0IGhp
ZF9kZXZpY2UgKmhpZCkge30KK3N0YXRpYyBpbmxpbmUgdm9pZCBoaWRpbnB1dF9zaW1wbGVfZHJp
dmVyX2NsZWFyX3VzYWdlKHN0cnVjdCBoaWRfZGV2aWNlICpoaWQpIHt9CitzdGF0aWMgdm9pZCBp
bmxpbmUgaGlkaW5wdXRfc2ltcGxlX2RyaXZlcl9mZl9pbml0KHN0cnVjdCBpbnB1dF9kZXYgKmlu
cHV0X2Rldikge30KKyNlbmRpZgorCisvKioqKiogVGhlIHByaXZhdGUgc2VjdGlvbiBlbmQuICAq
KioqKi8KKyNlbmRpZiAvKiBfX0tFUk5FTF9fICovCisjZW5kaWYgLyogX19ISURfU0lNUExFX0gg
Ki8KZGlmZiAtTmF1cnAgbGludXgtMi42LjE4L2RyaXZlcnMvdXNiL2lucHV0L0tjb25maWcgbGlu
dXgtMi42LjE4L2RyaXZlcnMvdXNiL2lucHV0Lm5ldy9LY29uZmlnCi0tLSBsaW51eC0yLjYuMTgv
ZHJpdmVycy91c2IvaW5wdXQvS2NvbmZpZwkyMDA2LTA5LTIwIDExOjQyOjA2LjAwMDAwMDAwMCAr
MDgwMAorKysgbGludXgtMi42LjE4L2RyaXZlcnMvdXNiL2lucHV0Lm5ldy9LY29uZmlnCTIwMDYt
MDktMjggMDk6Mjg6MTUuMDAwMDAwMDAwICswODAwCkBAIC0zMjYsMyArMzI2LDMxIEBAIGNvbmZp
ZyBVU0JfQVBQTEVUT1VDSAogCiAJICBUbyBjb21waWxlIHRoaXMgZHJpdmVyIGFzIGEgbW9kdWxl
LCBjaG9vc2UgTSBoZXJlOiB0aGUKIAkgIG1vZHVsZSB3aWxsIGJlIGNhbGxlZCBhcHBsZXRvdWNo
LgorCitjb25maWcgSElEX1NJTVBMRQorCWJvb2wgIkhJRCBzaW1wbGUgZHJpdmVyIGludGVyZmFj
ZSIKKwlkZXBlbmRzIG9uIFVTQl9ISURJTlBVVAorCWhlbHAKKwkgIFRoaXMgc2ltcGxlIGludGVy
ZmFjZSBsZXQgdGhlIHdyaXRpbmcgSElEIGRyaXZlciBtb3JlIGVhc2llci4gTW9yZW92ZXIsCisJ
ICB0aGlzIGFsbG93IHlvdSB3cml0ZSBmb3JjZS1mZWVkYmFjayBkcml2ZXIgd2l0aG91dCB0b3Vj
aCBISUQgaW5wdXQgCisJICBpbXBsZW1lbnRhdGlvbiBjb2RlLiBBbHNvLCBpdCBjYW4gYmUgdXNl
ZCBhcyBpbnB1dCBmaWx0ZXIuCisKK2NvbmZpZyBISURfU0lNUExFX01TTkVLNEsKKwl0cmlzdGF0
ZSAiTWljcm9zb2Z0IE5hdHVyYWwgRXJnb25vbWljIEtleWJvYXJkIDQwMDAgRHJpdmVyIgorCWRl
cGVuZHMgb24gSElEX1NJTVBMRQorCWhlbHAKKwkgIE1pY3Jvc29mdCBOYXR1cmFsIEVyZ29ub21p
YyBLZXlib2FyZCA0MDAwIGV4dGVuZCBrZXlzIHN1cHBvcnQuIFRoZXNlCisgIAkgIG1heSBub3Qg
d29yayB3aXRob3V0IGNoYW5nZSB1c2VyIHNwYWNlIGNvbmZpZ3JhdGlvbiwgZS5nLCBYS0IgY29u
Zi0KKwkgIGlndXJhdGlvbiBpbiBYLgorCitjb25maWcgSElEX1NJTVBMRV9GRgorCWJvb2wgIkhJ
RCBzaW1wbGUgZHJpdmVyIGludGVyZmFjZSBmb3JjZSBmZWVkYmFjayBzdXBwb3J0IgorCWRlcGVu
ZHMgb24gSElEX1NJTVBMRSAmJiAhSElEX0ZGCisJaGVscAorCSAgVGhpcyBmZWF0dXJlIGNhbiBu
b3QgYmUgY29tcGF0aWJsZSB3aXRoICJGb3JjZSBmZWVkYmFjayBzdXBwb3J0IiAoSElEX0ZGKS4K
KworY29uZmlnIEhJRF9TSU1QTEVfRkZfQlRQMjExOAorCXRyaXN0YXRlICJCZXRvcCAyMTE4IGpv
eXN0aWNrIGZvcmNlIGZlZWRiYWNrIHN1cHBvcnQiCisJZGVwZW5kcyBvbiBISURfU0lNUExFX0ZG
CisJaGVscAorCSAgVGhpcyBjYW4gZW5hYmxlIEJldG9wIDIxMTggam95c3RpY2sgZm9yY2UgZmVl
ZGJhY2sgZmVhdHVyZS4KZGlmZiAtTmF1cnAgbGludXgtMi42LjE4L2RyaXZlcnMvdXNiL2lucHV0
L01ha2VmaWxlIGxpbnV4LTIuNi4xOC9kcml2ZXJzL3VzYi9pbnB1dC5uZXcvTWFrZWZpbGUKLS0t
IGxpbnV4LTIuNi4xOC9kcml2ZXJzL3VzYi9pbnB1dC9NYWtlZmlsZQkyMDA2LTA5LTIwIDExOjQy
OjA2LjAwMDAwMDAwMCArMDgwMAorKysgbGludXgtMi42LjE4L2RyaXZlcnMvdXNiL2lucHV0Lm5l
dy9NYWtlZmlsZQkyMDA2LTA5LTI4IDA5OjI4OjE1LjAwMDAwMDAwMCArMDgwMApAQCAtMjUsNiAr
MjUsOSBAQCBlbmRpZgogaWZlcSAoJChDT05GSUdfSElEX0ZGKSx5KQogCXVzYmhpZC1vYmpzCSs9
IGhpZC1mZi5vCiBlbmRpZgoraWZlcSAoJChDT05GSUdfSElEX1NJTVBMRSkseSkKKwl1c2JoaWQt
b2JqcwkrPSBoaWQtc2ltcGxlLm8KK2VuZGlmCiAKIG9iai0kKENPTkZJR19VU0JfQUlQVEVLKQkr
PSBhaXB0ZWsubwogb2JqLSQoQ09ORklHX1VTQl9BVElfUkVNT1RFKQkrPSBhdGlfcmVtb3RlLm8K
QEAgLTQ0LDYgKzQ3LDggQEAgb2JqLSQoQ09ORklHX1VTQl9BQ0VDQUQpCSs9IGFjZWNhZC5vCiBv
YmotJChDT05GSUdfVVNCX1lFQUxJTkspCSs9IHllYWxpbmsubwogb2JqLSQoQ09ORklHX1VTQl9Y
UEFEKQkJKz0geHBhZC5vCiBvYmotJChDT05GSUdfVVNCX0FQUExFVE9VQ0gpCSs9IGFwcGxldG91
Y2gubworb2JqLSQoQ09ORklHX0hJRF9TSU1QTEVfTVNORUs0SykJKz0gdXNibmVrNGsubworb2Jq
LSQoQ09ORklHX0hJRF9TSU1QTEVfRkZfQlRQMjExOCkJKz0gYnRwMjExOC5vCiAKIGlmZXEgKCQo
Q09ORklHX1VTQl9ERUJVRykseSkKIEVYVFJBX0NGTEFHUyArPSAtRERFQlVHCmRpZmYgLU5hdXJw
IGxpbnV4LTIuNi4xOC9kcml2ZXJzL3VzYi9pbnB1dC91c2JuZWs0ay5jIGxpbnV4LTIuNi4xOC9k
cml2ZXJzL3VzYi9pbnB1dC5uZXcvdXNibmVrNGsuYwotLS0gbGludXgtMi42LjE4L2RyaXZlcnMv
dXNiL2lucHV0L3VzYm5lazRrLmMJMTk3MC0wMS0wMSAwODowMDowMC4wMDAwMDAwMDAgKzA4MDAK
KysrIGxpbnV4LTIuNi4xOC9kcml2ZXJzL3VzYi9pbnB1dC5uZXcvdXNibmVrNGsuYwkyMDA2LTA5
LTI5IDExOjIxOjAyLjAwMDAwMDAwMCArMDgwMApAQCAtMCwwICsxLDIxMCBAQAorLyoKKyAqICBN
aWNyb3NvZnQgTmF0dXJhbCBFcmdvbm9taWMgS2V5Ym9hcmQgNDAwMCBEcml2ZXIKKyAqCisgKiAg
VmVyc2lvbjoJMC4zLjIKKyAqCisgKiAgQ29weXJpZ2h0IChjKSAyMDA2IExpIFl1IDxyYWlzZS5z
YWlsQGdtYWlsLmNvbT4KKyAqLworCisvKgorICogVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdh
cmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkgaXQKKyAqIHVuZGVyIHRo
ZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgYXMgcHVibGlzaGVkIGJ5
IHRoZSBGcmVlCisgKiBTb2Z0d2FyZSBGb3VuZGF0aW9uOyBlaXRoZXIgdmVyc2lvbiAyIG9mIHRo
ZSBMaWNlbnNlLCBvciAoYXQgeW91ciBvcHRpb24pCisgKiBhbnkgbGF0ZXIgdmVyc2lvbi4KKyAq
LworCisjaW5jbHVkZSA8bGludXgva2VybmVsLmg+CisjaW5jbHVkZSA8bGludXgvaW5wdXQuaD4K
KyNpbmNsdWRlICJoaWQuaCIKKyNpbmNsdWRlICJoaWQtc2ltcGxlLmgiCisKKyNkZWZpbmUgVVNB
R0VfWk9PTV9JTgkweDIyZAorI2RlZmluZSBVU0FHRV9aT09NX09VVAkweDIyZQorI2RlZmluZSBV
U0FHRV9IT01FCTB4MjIzCisjZGVmaW5lIFVTQUdFX1NFQVJDSAkweDIyMQorI2RlZmluZSBVU0FH
RV9FTUFJTAkweDE4YQorI2RlZmluZSBVU0FHRV9GQVZPUklURVMJMHgxODIKKyNkZWZpbmUgVVNB
R0VfTVVURQkweGUyCisjZGVmaW5lIFVTQUdFX1ZPTFVNRV9ET1dOCTB4ZWEKKyNkZWZpbmUgVVNB
R0VfVk9MVU1FX1VQCTB4ZTkKKyNkZWZpbmUgVVNBR0VfUExBWV9QQVVTRQkweGNkCisjZGVmaW5l
IFVTQUdFX0NBTENVTEFUT1IJMHgxOTIKKyNkZWZpbmUgVVNBR0VfQkFDSwkweDIyNAorI2RlZmlu
ZSBVU0FHRV9GT1JXQVJECTB4MjI1CisjZGVmaW5lIFVTQUdFX0NVU1RPTQkweGZmMDUKKworI2Rl
ZmluZSBVU0FHRV9DVVNUT01fUkVMRUFTRQkweDAKKyNkZWZpbmUgVVNBR0VfQ1VTVE9NXzEJMHgx
CisjZGVmaW5lIFVTQUdFX0NVU1RPTV8yCTB4MgorI2RlZmluZSBVU0FHRV9DVVNUT01fMwkweDQK
KyNkZWZpbmUgVVNBR0VfQ1VTVE9NXzQJMHg4CisjZGVmaW5lIFVTQUdFX0NVU1RPTV81CTB4MTAK
KworI2RlZmluZSBVU0FHRV9IRUxQCTB4OTUKKyNkZWZpbmUgVVNBR0VfVU5ETwkweDIxYQorI2Rl
ZmluZSBVU0FHRV9SRURPCTB4Mjc5CisjZGVmaW5lIFVTQUdFX05FVwkweDIwMQorI2RlZmluZSBV
U0FHRV9PUEVOCTB4MjAyCisjZGVmaW5lIFVTQUdFX0NMT1NFCTB4MjAzCisKKyNkZWZpbmUgVVNB
R0VfUkVQTFkJMHgyODkKKyNkZWZpbmUgVVNBR0VfRldECTB4MjhiCisjZGVmaW5lIFVTQUdFX1NF
TkQJMHgyOGMKKyNkZWZpbmUgVVNBR0VfU1BFTEwJMHgxYWIKKyNkZWZpbmUgVVNBR0VfU0FWRQkw
eDIwNworI2RlZmluZSBVU0FHRV9QUklOVAkweDIwOAorCisjZGVmaW5lIFVTQUdFX0tFWVBBRF9F
UVVBTAkweDY3CisjZGVmaW5lIFVTQUdFX0tFWVBBRF9MRUZUX1BBUkVOCTB4YjYKKyNkZWZpbmUg
VVNBR0VfS0VZUEFEX1JJR0hUX1BBUkVOCTB4YjcKKworI2RlZmluZSBNU05FSzRLX0lEX1ZFTkRP
UgkweDA0NWUKKyNkZWZpbmUgTVNORUs0S19JRF9QUk9EVUNUCTB4MDBkYgorCitNT0RVTEVfREVW
SUNFX1RBQkxFKHVzYiwgbmVrNGtfaWRfdGFibGUpOworCitzdGF0aWMgY2hhciBkcml2ZXJfbmFt
ZVtdID0gIk1pY3Jvc29mdCBOYXR1cmFsIEVyZ29ub21pYyBLZXlib2FyZCA0MDAwIjsKKworc3Ry
dWN0IHVzYWdlX2Jsb2NrIGNvbnN1bWVyX3VzYWdlX2Jsb2NrW10gPSB7CisJVVNBR0VfQkxPQ0so
VVNBR0VfWk9PTV9JTiwgMCwgRVZfS0VZLCBLRVlfRjEzLCAwKSwKKwlVU0FHRV9CTE9DSyhVU0FH
RV9aT09NX09VVCwgMCwgRVZfS0VZLCBLRVlfRjE0LCAwKSwKKwlVU0FHRV9CTE9DSyhVU0FHRV9I
T01FLCAwLCBFVl9LRVksIEtFWV9IT01FUEFHRSwgMCksCisJVVNBR0VfQkxPQ0soVVNBR0VfU0VB
UkNILCAwLCBFVl9LRVksIEtFWV9TRUFSQ0gsIDApLAorCVVTQUdFX0JMT0NLKFVTQUdFX0VNQUlM
LCAwLCBFVl9LRVksIEtFWV9FTUFJTCwgMCksCisJVVNBR0VfQkxPQ0soVVNBR0VfRkFWT1JJVEVT
LCAwLCBFVl9LRVksIEtFWV9GMTYsIDApLAorCVVTQUdFX0JMT0NLKFVTQUdFX0ZBVk9SSVRFUywg
MCwgRVZfS0VZLCBLRVlfRkFWT1JJVEVTLCAwKSwKKwlVU0FHRV9CTE9DSyhVU0FHRV9NVVRFLCAw
LCBFVl9LRVksIEtFWV9NVVRFLCAwKSwKKwlVU0FHRV9CTE9DSyhVU0FHRV9WT0xVTUVfRE9XTiwg
MCwgRVZfS0VZLCBLRVlfVk9MVU1FRE9XTiwgMCksCisJVVNBR0VfQkxPQ0soVVNBR0VfVk9MVU1F
X1VQLCAwLCBFVl9LRVksIEtFWV9WT0xVTUVVUCwgMCksCisJVVNBR0VfQkxPQ0soVVNBR0VfUExB
WV9QQVVTRSwgMCwgRVZfS0VZLCBLRVlfUExBWVBBVVNFLCAwKSwKKwlVU0FHRV9CTE9DSyhVU0FH
RV9DQUxDVUxBVE9SLCAwLCBFVl9LRVksIEtFWV9DQUxDLCAwKSwKKwlVU0FHRV9CTE9DSyhVU0FH
RV9CQUNLLCAwLCBFVl9LRVksIEtFWV9CQUNLLCAwKSwKKwlVU0FHRV9CTE9DSyhVU0FHRV9GT1JX
QVJELCAwLCBFVl9LRVksIEtFWV9GT1JXQVJELCAwKSwKKwlVU0FHRV9CTE9DSyhVU0FHRV9IRUxQ
LCAwLCBFVl9LRVksIEtFWV9IRUxQLCAwKSwKKwlVU0FHRV9CTE9DSyhVU0FHRV9VTkRPLCAwLCBF
Vl9LRVksIEtFWV9VTkRPLCAwKSwKKwlVU0FHRV9CTE9DSyhVU0FHRV9SRURPLCAwLCBFVl9LRVks
IEtFWV9GMTcsIDApLAorCVVTQUdFX0JMT0NLKFVTQUdFX1JFRE8sIDAsIEVWX0tFWSwgS0VZX1JF
RE8sIDApLAorCVVTQUdFX0JMT0NLKFVTQUdFX05FVywgMCwgRVZfS0VZLCBLRVlfTkVXLCAwKSwK
KwlVU0FHRV9CTE9DSyhVU0FHRV9PUEVOLCAwLCBFVl9LRVksIEtFWV9PUEVOLCAwKSwKKwlVU0FH
RV9CTE9DSyhVU0FHRV9DTE9TRSwgMCwgRVZfS0VZLCBLRVlfQ0xPU0UsIDApLAorCVVTQUdFX0JM
T0NLKFVTQUdFX1JFUExZLCAwLCBFVl9LRVksIEtFWV9SRVBMWSwgMCksCisJVVNBR0VfQkxPQ0so
VVNBR0VfRldELCAwLCBFVl9LRVksIEtFWV9GT1JXQVJETUFJTCwgMCksCisJVVNBR0VfQkxPQ0so
VVNBR0VfU0VORCwgMCwgRVZfS0VZLCBLRVlfU0VORCwgMCksCisJVVNBR0VfQkxPQ0soVVNBR0Vf
U1BFTEwsIDAsIEVWX0tFWSwgS0VZX0YxNSwgMCksCisJVVNBR0VfQkxPQ0soVVNBR0VfU0FWRSwg
MCwgRVZfS0VZLCBLRVlfU0FWRSwgMCksCisJVVNBR0VfQkxPQ0soVVNBR0VfUFJJTlQsIDAsIEVW
X0tFWSwgS0VZX1BSSU5ULCAwKSwKKwlVU0FHRV9CTE9DS19OVUxMCit9OworCitzdHJ1Y3QgdXNh
Z2VfYmxvY2sgbXN2ZW5kb3JfdXNhZ2VfYmxvY2tbXSA9IHsKKwlVU0FHRV9CTE9DSyhVU0FHRV9D
VVNUT00sIFVTQUdFX0NVU1RPTV8xLCBFVl9LRVksIEtFWV9GTl9GMSwgMCksCisJVVNBR0VfQkxP
Q0soVVNBR0VfQ1VTVE9NLCBVU0FHRV9DVVNUT01fMiwgRVZfS0VZLCBLRVlfRk5fRjIsIDApLAor
CVVTQUdFX0JMT0NLKFVTQUdFX0NVU1RPTSwgVVNBR0VfQ1VTVE9NXzMsIEVWX0tFWSwgS0VZX0ZO
X0YzLCAwKSwKKwlVU0FHRV9CTE9DSyhVU0FHRV9DVVNUT00sIFVTQUdFX0NVU1RPTV80LCBFVl9L
RVksIEtFWV9GTl9GNCwgMCksCisJVVNBR0VfQkxPQ0soVVNBR0VfQ1VTVE9NLCBVU0FHRV9DVVNU
T01fNSwgRVZfS0VZLCBLRVlfRk5fRjUsIDApLAorCVVTQUdFX0JMT0NLX05VTEwKK307CisKK3N0
cnVjdCB1c2FnZV9ibG9jayBrZXlib2FyZF91c2FnZV9ibG9ja1tdID0geworCVVTQUdFX0JMT0NL
KFVTQUdFX0tFWVBBRF9FUVVBTCwgMCwgRVZfS0VZLCBLRVlfS1BFUVVBTCwgMCksCisJVVNBR0Vf
QkxPQ0soVVNBR0VfS0VZUEFEX0xFRlRfUEFSRU4sIDAsIEVWX0tFWSwgS0VZX0tQTEVGVFBBUkVO
LCAwKSwKKwlVU0FHRV9CTE9DSyhVU0FHRV9LRVlQQURfUklHSFRfUEFSRU4sIDAsIEVWX0tFWSwg
S0VZX0tQUklHSFRQQVJFTiwgMCksCisJVVNBR0VfQkxPQ0tfTlVMTAorfTsKKworc3RydWN0IHVz
YWdlX3BhZ2VfYmxvY2sgbmVrNGtfdXNhZ2VfcGFnZV9ibG9ja2VzW10gPSB7CisJVVNBR0VfUEFH
RV9CTE9DSyhISURfVVBfQ09OU1VNRVIsIGNvbnN1bWVyX3VzYWdlX2Jsb2NrKSwKKwlVU0FHRV9Q
QUdFX0JMT0NLKEhJRF9VUF9NU1ZFTkRPUiwgbXN2ZW5kb3JfdXNhZ2VfYmxvY2spLAorCVVTQUdF
X1BBR0VfQkxPQ0soSElEX1VQX0tFWUJPQVJELCBrZXlib2FyZF91c2FnZV9ibG9jayksCisJVVNB
R0VfUEFHRV9CTE9DS19OVUxMCit9OworCitzdGF0aWMgaW50IG5lazRrX3ByZV9ldmVudChjb25z
dCBzdHJ1Y3QgaGlkX2RldmljZSAqaGlkLCAKKwkJCQkJY29uc3Qgc3RydWN0IGhpZF9maWVsZCAq
ZmllbGQsCisJCQkJCWNvbnN0IHN0cnVjdCBoaWRfdXNhZ2UgKnVzYWdlLAorCQkJCQljb25zdCBf
X3MzMiB2YWx1ZSwKKwkJCQkJY29uc3Qgc3RydWN0IHB0X3JlZ3MgKnJlZ3MpCit7CisJc3RydWN0
IGhpZF9pbnB1dCAqaGlkaW5wdXQgPSBmaWVsZC0+aGlkaW5wdXQ7CisJc3RydWN0IGlucHV0X2Rl
diAqaW5wdXQgPSBoaWRpbnB1dC0+aW5wdXQ7CisJaW50IGNvZGUgPSAwLCBhc2NpaV9rZXljb2Rl
ID0gMCwgZXZfdmFsdWU7CisKKwlldl92YWx1ZSA9IHZhbHVlPzE6MDsKKworCXN3aXRjaCAodXNh
Z2UtPmhpZCZISURfVVNBR0UpIHsKKwljYXNlIFVTQUdFX0ZBVk9SSVRFUzoKKwkJY29kZSA9IEtF
WV9GQVZPUklURVM7CisJCWFzY2lpX2tleWNvZGUgPSBLRVlfRjE2OworCQlnb3RvIGV4aXQ7CisJ
Y2FzZSBVU0FHRV9SRURPOgorCQljb2RlID0gS0VZX1JFRE87CisJCWFzY2lpX2tleWNvZGUgPSBL
RVlfRjE3OworCQlnb3RvIGV4aXQ7CisJfTsKKworCWlmICgodXNhZ2UtPmhpZCZISURfVVNBR0Up
ICE9IFVTQUdFX0NVU1RPTSkKKwkJLyogbGV0IGhpZCBjb3JlIGNvbnRpbnVlIHRvIHByb2Nlc3Mg
dGhlbSAqLworCQlyZXR1cm4gKCEwKTsKKworCXN3aXRjaCAodmFsdWUpIHsKKwljYXNlIFVTQUdF
X0NVU1RPTV9SRUxFQVNFOgorCQljb2RlID0gZ2V0X2tleWNvZGUoaGlkaW5wdXQtPnByaXZhdGUp
OworCQlhc2NpaV9rZXljb2RlID0gS0VZX0YxOCsoY29kZS1LRVlfRk5fRjEpOworCQlicmVhazsK
KwljYXNlIFVTQUdFX0NVU1RPTV8xOgorCQljb2RlID0gS0VZX0ZOX0YxOworCQlhc2NpaV9rZXlj
b2RlID0gS0VZX0YxODsKKwkJYnJlYWs7CisJY2FzZSBVU0FHRV9DVVNUT01fMjoKKwkJY29kZSA9
IEtFWV9GTl9GMjsKKwkJYXNjaWlfa2V5Y29kZSA9IEtFWV9GMTk7CisJCWJyZWFrOworCWNhc2Ug
VVNBR0VfQ1VTVE9NXzM6CisJCWNvZGUgPSBLRVlfRk5fRjM7CisJCWFzY2lpX2tleWNvZGUgPSBL
RVlfRjIwOworCQlicmVhazsKKwljYXNlIFVTQUdFX0NVU1RPTV80OgorCQljb2RlID0gS0VZX0ZO
X0Y0OworCQlhc2NpaV9rZXljb2RlID0gS0VZX0YyMTsKKwkJYnJlYWs7CisJY2FzZSBVU0FHRV9D
VVNUT01fNToKKwkJY29kZSA9IEtFWV9GTl9GNTsKKwkJYXNjaWlfa2V5Y29kZSA9IEtFWV9GMjI7
CisJCWJyZWFrOworCX0KK2V4aXQ6CisJaWYgKGNvZGUpIHsKKwkJaGlkaW5wdXQtPnByaXZhdGUg
PSAodm9pZCopY29kZTsKKwkJaW5wdXRfZXZlbnQoaW5wdXQsIEVWX0tFWSwgY29kZSwgZXZfdmFs
dWUpOworCQlpbnB1dF9zeW5jKGlucHV0KTsKKwl9CisJaWYgKGFzY2lpX2tleWNvZGUpIHsKKwkJ
aW5wdXRfZXZlbnQoaW5wdXQsIEVWX0tFWSwgYXNjaWlfa2V5Y29kZSwgZXZfdmFsdWUpOworCQlp
bnB1dF9zeW5jKGlucHV0KTsKKwl9CisJcmV0dXJuIDA7IAorfQorCitzdGF0aWMgc3RydWN0IGhp
ZGlucHV0X3NpbXBsZV9kcml2ZXIgbmVrNGtfZHJpdmVyID0geworCS5vd25lciA9IFRISVNfTU9E
VUxFLAorCS5uYW1lID0gZHJpdmVyX25hbWUsCisJLnByZV9ldmVudCA9IG5lazRrX3ByZV9ldmVu
dCwKKwkuaWRfdGFibGUgPSBuZWs0a19pZF90YWJsZSwKKwkudXNhZ2VfcGFnZV90YWJsZSA9IG5l
azRrX3VzYWdlX3BhZ2VfYmxvY2tlcywKKwkucHJpdmF0ZSA9IE5VTEwKK307CisKK3N0YXRpYyBp
bnQgX19pbml0IG5lazRrX2luaXQodm9pZCkKK3sKKwlyZXR1cm4gaGlkaW5wdXRfcmVnaXN0ZXJf
c2ltcGxlX2RyaXZlcigmbmVrNGtfZHJpdmVyKTsKK30KKworc3RhdGljIHZvaWQgX19leGl0IG5l
azRrX2V4aXQodm9pZCkKK3sKKwloaWRpbnB1dF91bnJlZ2lzdGVyX3NpbXBsZV9kcml2ZXIoJm5l
azRrX2RyaXZlcik7Cit9CisKK21vZHVsZV9pbml0KG5lazRrX2luaXQpOworbW9kdWxlX2V4aXQo
bmVrNGtfZXhpdCk7CisKK01PRFVMRV9MSUNFTlNFKCJHUEwiKTsK

--=====001_Dragon115183436543_=====--

