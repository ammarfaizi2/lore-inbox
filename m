Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932270AbWGZKlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbWGZKlj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 06:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbWGZKlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 06:41:39 -0400
Received: from [210.76.114.181] ([210.76.114.181]:12470 "EHLO ccoss.com.cn")
	by vger.kernel.org with ESMTP id S932270AbWGZKli (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 06:41:38 -0400
Message-ID: <44C746D6.1010506@ccoss.com.cn>
Date: Wed, 26 Jul 2006 18:41:26 +0800
From: liyu <liyu@ccoss.com.cn>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Peter <peter@maubp.freeserve.co.uk>,
       The Doctor <thedoctor@tardis.homelinux.org>
Subject: [PATCH 1/2] usbhid: HID device simple driver interface
References: <44B77AB0.8060700@maubp.freeserve.co.uk>
In-Reply-To: <44B77AB0.8060700@maubp.freeserve.co.uk>
Content-Type: multipart/mixed;
 boundary="------------070402070501080804020708"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070402070501080804020708
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

==================================
HID device simple driver interface
==================================

------------------------
Version
------------------------

    This is the second version, this patch can apply on 2.6.17.6 kernel 
tree (also can apply for 2.6.17.7).

    The last version can find here:

        http://www.gossamer-threads.com/lists/linux/kernel/603843.

    As Greg KH words, I split this driver into some more littler patches, and
break some long line in source.

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
    
    I wrote a driver for MS Natural Ergonomic Keyboard 4000. 

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

    The last words that I want to say are sorry, this new version have 
not compatibility with the last version.
        
    Good luck.

-Liyu









--------------070402070501080804020708
Content-Type: text/x-patch;
 name="usbhid-simple-driver.kernel-2.6.17.7.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="usbhid-simple-driver.kernel-2.6.17.7.patch"

==================================
HID device simple driver interface
==================================

------------------------
Version
------------------------

    This is the second version, this patch can apply on 2.6.17.6 kernel 
tree (also for 2.6.17.7).

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
        
Signed-off-by:  Yu Li <liyu@ccoss.com.cn>

diff -Naurp linux-2.6.17.6/drivers/usb/input.orig/hid-core.c linux-2.6.17.6/drivers/usb/input/hid-core.c
--- linux-2.6.17.6/drivers/usb/input.orig/hid-core.c	2006-07-16 03:00:43.000000000 +0800
+++ linux-2.6.17.6/drivers/usb/input/hid-core.c	2006-07-26 09:44:25.000000000 +0800
@@ -4,6 +4,7 @@
  *  Copyright (c) 1999 Andreas Gal
  *  Copyright (c) 2000-2005 Vojtech Pavlik <vojtech@suse.cz>
  *  Copyright (c) 2005 Michael Haboustak <mike-@cinci.rr.com> for Concept2, Inc
+ *  Copyright (c) 2006 Liyu <liyu@ccoss.com.cn>  HID simple driver interface
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
 
@@ -2005,12 +2045,145 @@ static void hid_disconnect(struct usb_in
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
+			printk(KERN_INFO"The simple HID driver \'%s\' attach on"
+								"\'%s\'\n",
+								simple->name,
+								hid->name);
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
+	printk(KERN_INFO"The simple HID driver \'%s\' attach on \'%s\'\n", 
+						simple->name, hid->name);
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
+		printk(KERN_INFO"The simple HID driver \'%s\' attach on"
+							" \'%s\'.\n",
+						 simple->name, hid->name);
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
+	printk(KERN_INFO"The simple HID driver \'%s\' unregistered.\n", 
+							simple->name);
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
@@ -2021,13 +2194,22 @@ static int hid_probe(struct usb_interfac
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
@@ -2108,6 +2290,8 @@ static int __init hid_init(void)
 	retval = hiddev_init();
 	if (retval)
 		goto hiddev_init_fail;
+	INIT_LIST_HEAD(&matched_devices_list);
+	INIT_LIST_HEAD(&simple_drivers_list);
 	retval = usb_register(&hid_driver);
 	if (retval)
 		goto usb_register_fail;
@@ -2122,7 +2306,15 @@ hiddev_init_fail:
 
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
 
diff -Naurp linux-2.6.17.6/drivers/usb/input.orig/hid.h linux-2.6.17.6/drivers/usb/input/hid.h
--- linux-2.6.17.6/drivers/usb/input.orig/hid.h	2006-07-16 03:00:43.000000000 +0800
+++ linux-2.6.17.6/drivers/usb/input/hid.h	2006-07-21 13:46:03.000000000 +0800
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
diff -Naurp linux-2.6.17.6/drivers/usb/input.orig/hid-input.c linux-2.6.17.6/drivers/usb/input/hid-input.c
--- linux-2.6.17.6/drivers/usb/input.orig/hid-input.c	2006-07-16 03:00:43.000000000 +0800
+++ linux-2.6.17.6/drivers/usb/input/hid-input.c	2006-07-26 09:35:11.000000000 +0800
@@ -2,6 +2,7 @@
  * $Id: hid-input.c,v 1.2 2002/04/23 00:59:25 rdamazio Exp $
  *
  *  Copyright (c) 2000-2001 Vojtech Pavlik
+ *  Copyright (c) 2006 Liyu <liyu@ccoss.com.cn>  HID simple driver interface
  *
  *  USB HID to Linux Input mapping
  */
@@ -36,6 +37,7 @@
 #undef DEBUG
 
 #include "hid.h"
+#include "hid-simple.h"
 
 #define unk	KEY_UNKNOWN
 
@@ -849,6 +851,159 @@ int hidinput_connect(struct hid_device *
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
+hidinput_simple_driver_push(struct hidinput_simple_driver *simple, 
+					struct matched_device *matched)
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
+hidinput_simple_driver_pop(struct hidinput_simple_driver *simple, 
+				struct matched_device *matched)
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
+		raw_simple = list_entry(simple->raw_devices.next, 
+					struct raw_simple_device, node);
+		hid = usb_get_intfdata (raw_simple->intf);
+	
+		if (hid->simple) {
+			BUG_ON(hid->simple != simple);
+			hid->simple = NULL;
+		}
+		hidinput_simple_driver_clear_usage(hid);
+		printk("device '%s' disconnect from one simple driver.\n",
+								hid->name);
+		hidinput_simple_driver_disconnect(hid);
+		list_del_init(simple->raw_devices.next);
+	}
+}
+
+/* modify from hidinput_disconnect() */ 
+int hidinput_simple_driver_connect(struct hidinput_simple_driver *simple, 
+						struct hid_device *hid)
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







--------------070402070501080804020708--
