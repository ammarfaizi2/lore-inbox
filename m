Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161256AbWI2IYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161256AbWI2IYL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 04:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161255AbWI2IYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 04:24:11 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:36311 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030375AbWI2IYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 04:24:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=NJKyoeAEOVCmodxuTl7DEvlXSmXw7C2bcmA+zHRExFF66DyttpGj1gMfDZEy76pa0i1YT1p1Ox3dGyewvuy9vbyPeOqCl/9EsxJH/waA8YCp3vK8yjXoVh6PjTmjGhuPX/QAqbm6RYEKqyXp/V4S+B9IN9sMNlNr6AMd42m82QU=
Date: Fri, 29 Sep 2006 16:24:15 +0800
From: "raise.sail" <raise.sail@gmail.com>
To: "LKML" <linux-kernel@vger.kernel.org>,
       "linux-usb-devel" <linux-usb-devel@lists.sourceforge.net>,
       "greg" <greg@kroah.com>
Subject: [PATCH] usb/hid: The HID Simple Driver Interface 0.3.2 (core)
Message-ID: <200609291624123283320@gmail.com>
X-mailer: Foxmail 6, 5, 104, 21 [cn]
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

