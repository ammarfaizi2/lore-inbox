Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751645AbWADKKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751645AbWADKKm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 05:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751648AbWADKKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 05:10:42 -0500
Received: from [210.76.114.20] ([210.76.114.20]:30120 "EHLO ccoss.com.cn")
	by vger.kernel.org with ESMTP id S1751598AbWADKKl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 05:10:41 -0500
Message-ID: <43BB9F0F.8050605@ccoss.com.cn>
Date: Wed, 04 Jan 2006 18:10:23 +0800
From: liyu <liyu@ccoss.com.cn>
Reply-To: liyu@ccoss.com.cn
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: zh-cn,zh
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] usb/input: HID device simple driver interface 
Content-Type: text/plain; charset=gb18030; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

=====================
HID device simple driver interface
=====================

Date:
------------------
20050104

Source code base
------------------

2.6.15

Goal:
----------------
Let us write HID device driver more easier.


Basic idea:
---------------
Under current HID device driver development technique, We need write one 
new interrupt handler to report event to input subsystem as long as one 
new HID device come. However, the most of them have only some extended 
keys, I think it seem break a fly on the wheel, which write one new 
interrupt handler for this reason,
My idea is reuse the interrupt handler in hid-core.c. so we write driver 
for new simple HID device will be more easier, and need not touch hid core.
In essence, this interface just are some hooks in HID core.

Limitation:
----------------
The driver use this simple interface only can work with one device at 
same time. In most time, this just is not a problem. if you are going to 
make your driver can work with a bundle of devices at same time, the I 
am sorry, this simple interface can not help you so far, and I am afraid 
that driver is not one simple driver. Of course, any improvement on this 
patch is welcome :)


Testing:
--------------
Tested on i386.

The driver use this interface
--------------------

I wrote a driver for MS natural ergonomic keyboard 4000.

Usage:
---------------
Although this simple driver have not direct relation with device driver 
core, but I still make its interface like it on purpose.

The each simple device has five methods:

1. int (*connect)(struct hid_device *);
2. void (*disconnect)(struct hid_device *);

When you simple device is connect with one real HID device, we will call 
connect() method. To return 0 flag it complete its job successfully. Any 
other value is looked as one error.
When the HID device that your simple device connect with is down, or you 
unregister this simple device, we will call disconnect() method.

3. void (*setup_usage)(struct hid_field *, struct hid_usage *);
4. void (*clear_usage)(struct hid_field *, struct hid_usage *);

The setup_usage() method is like hidinput_configure_usage() in 
hid_input.c. You also can setup input_dev here. In most time, I think 
you should
be fill the pointer slot for this method, elsewise the event() method do 
not work for you at all.
The clear_usage() method is used to clear side-effect that came from 
setup_usage() method, if they are there. Of course, you can do same job 
in disconnect() method, but this method let your life more simpler.

5. void (*event)(const struct hid_device *, const struct hid_field *, 
const struct hid_usage *, const __s32, const struct pt_regs *regs);

its behavior is same with hidinput_hid_event() exactly. Note again, if 
you do not correctly configure usage in setup_usage(), this method do 
not work as you want.

All these method are optional, but if they are all NULL pointers, what 
are you want *-)

For detailed, see the sample follow:

#include
#include
#include \"hid-simple.h\"

#define DRIVER_DESC \"HID simple device example #1\"
#define DRIVER_VERSION \"0.1.0\"

/* For BETOP BTP-C033 joystick (A popluar product in China market) */
#define SAMPLE_ID_VENDOR 0x0e8f
#define SAMPLE_ID_PRODUCT 0x0003

struct sample_device {
struct hidinput_simple_device device;
};

static struct usb_device_id __id[] = {
{
USB_DEVICE(SAMPLE_ID_VENDOR, SAMPLE_ID_PRODUCT)
},
{0, }
};

MODULE_DEVICE_TABLE(usb, __id);

static char device_name[] = \"The sample of HID simple device #1\";

static void sample_setup_usage(struct hid_field *field, struct hid_usage 
*usage)
{
struct input_dev *input = &field->hidinput->input;

if ((usage->hid & HID_USAGE_PAGE) == HID_UP_BUTTON)
set_bit(EV_REP, input->evbit);
}

static void sample_clear_usage(struct hid_field *field, struct hid_usage 
*usage)
{
struct input_dev *input = &field->hidinput->input;

if ((usage->hid & HID_USAGE_PAGE) == HID_UP_BUTTON)
clear_bit(EV_REP, input->evbit);
}

static struct sample_device sample_device = {
.device = {
.name = device_name,
.setup_usage = sample_setup_usage,
.clear_usage = sample_clear_usage,
.id = {
{ USB_DEVICE(SAMPLE_ID_VENDOR, SAMPLE_ID_PRODUCT) }, {}
}
}
};

static int __init sample_init(void)
{
int result = hidinput_register_simple_device(&sample_device.device);

if (result == 1) {
/*
* The device that matched is busy, this can see as one error,
* but we bypass it in this sample.
*/
printk(\"hid device busy\\n\");
}
if (result >= 0)
info(DRIVER_DESC \":\" DRIVER_VERSION);
return 0;
}

static void __exit sample_exit(void)
{
hidinput_unregister_simple_device(&sample_device.device);
}

module_init(sample_init);
module_exit(sample_exit);

MODULE_LICENSE(\"GPL\");

/* the sample end */

As above showed, the sample use simple interface is simple :)

Signed-off-by: Liyu <liyu@ccoss.com.cn>

diff -Naurp linux-2.6.15.orig/drivers/usb/input/hid-core.c 
linux-2.6.15/drivers/usb/input/hid-core.c
--- linux-2.6.15.orig/drivers/usb/input/hid-core.c 2006-01-03 
11:21:10.000000000 +0800
+++ linux-2.6.15/drivers/usb/input/hid-core.c 2006-01-04 
16:59:03.000000000 +0800
@@ -4,6 +4,8 @@
* Copyright (c) 1999 Andreas Gal
* Copyright (c) 2000-2005 Vojtech Pavlik <vojtech@suse.cz>
* Copyright (c) 2005 Michael Haboustak <mike-@cinci.rr.com> for 
Concept2, Inc
+ * Copyright (c) 2005 Liyu <liyu@ccoss.com.cn>
+ * To support simple HID device driver interface.
*/

/*
@@ -35,6 +37,8 @@
#include \"hid.h\"
#include

+#include \"hid-simple.h\"
+
/*
* Version Information
*/
@@ -46,6 +50,15 @@

static char *hid_types[] = {\"Device\", \"Pointer\", \"Mouse\", 
\"Device\", \"Joystick\",
\"Gamepad\", \"Keyboard\", \"Keypad\", \"Multi-Axis Controller\"};
+
+/*
+ * The global data structure for simple device driver interface.
+ */
+static spinlock_t matched_lock;
+static spinlock_t simple_lock;
+static struct list_head matched_devices_list;
+static struct list_head simple_devices_list;
+
/*
* Module parameters.
*/
@@ -793,8 +806,11 @@ static __inline__ int search(__s32 *arra
static void hid_process_event(struct hid_device *hid, struct hid_field 
*field, struct hid_usage *usage, __s32 value, int interrupt, struct 
pt_regs *regs)
{
hid_dump_input(usage, value);
- if (hid->claimed & HID_CLAIMED_INPUT)
+ if (hid->claimed & HID_CLAIMED_INPUT) {
hidinput_hid_event(hid, field, usage, value, regs);
+ if (hid->simple && hid->simple->event)
+ hid->simple->event(hid, field, usage, value, regs);
+ }
if (hid->claimed & HID_CLAIMED_HIDDEV && interrupt)
hiddev_hid_event(hid, field, usage, value, regs);
}
@@ -1820,6 +1836,8 @@ fail:
static void hid_disconnect(struct usb_interface *intf)
{
struct hid_device *hid = usb_get_intfdata (intf);
+ struct list_head *node;
+ struct matched_device *matched;

if (!hid)
return;
@@ -1829,8 +1847,38 @@ static void hid_disconnect(struct usb_in
usb_kill_urb(hid->urbout);
usb_kill_urb(hid->urbctrl);

- if (hid->claimed & HID_CLAIMED_INPUT)
- hidinput_disconnect(hid);
+ if (hid->claimed & HID_CLAIMED_INPUT) {
+ /* disconnect simple device if need */
+ if (hid->simple) {
+ if (hid->simple->disconnect)
+ hid->simple->disconnect(hid);
+ /* save them to matche other hid_device later */
+ spin_lock(&simple_lock);
+ list_add(&hid->simple->node, &simple_devices_list);
+ spin_unlock(&simple_lock);
+ hid->simple->intf = NULL;
+ hid->simple = NULL;
+ }
+ /* scan matched_devices_list to free our matched_device */
+ matched = NULL; /* shut up gcc */
+
+ spin_lock(&matched_lock);
+ list_for_each(node, &matched_devices_list) {
+ matched = list_entry(node, struct matched_device, node);
+ if (matched->intf == intf) {
+ list_del(&matched->node);
+ break;
+ }
+ matched = NULL;
+ }
+ spin_unlock(&matched_lock);
+ if (matched) {
+ matched->intf = 0;
+ kfree(matched);
+ }
+ hidinput_disconnect(hid);
+ }
+
if (hid->claimed & HID_CLAIMED_HIDDEV)
hiddev_disconnect(hid);

@@ -1843,13 +1891,162 @@ static void hid_disconnect(struct usb_in
hid_free_device(hid);
}

+static void
+hidinput_simple_device_bind_foreach(void)
+{
+ struct hidinput_simple_device *simple=0;
+ struct matched_device *matched=0;
+ struct list_head *simple_node;
+ struct list_head *matched_node;
+ struct hid_device *hid;
+
+ spin_lock(&matched_lock);
+ list_for_each(matched_node, &matched_devices_list) {
+ matched = list_entry(matched_node, struct matched_device, node);
+ spin_lock(&simple_lock);
+ list_for_each(simple_node, &simple_devices_list) {
+ simple = list_entry(simple_node, struct hidinput_simple_device, node);
+ if (usb_match_id(matched->intf, simple->id))
+ break;
+ simple = 0;
+ }
+ spin_unlock(&simple_lock);
+ if (simple)
+ break;
+ }
+ spin_unlock(&matched_lock);
+ /* no such simple device match this hid_device, also ok */
+ if (0 == simple)
+ return;
+
+ hid = usb_get_intfdata(matched->intf);
+ if ((simple->connect && 0==simple->connect(hid)) || !simple->connect) {
+ simple->intf = matched->intf;
+ hid->simple = simple;
+ spin_lock(&simple_lock);
+ list_del(&simple->node);
+ spin_unlock(&simple_lock);
+ hidinput_simple_device_setup_usage(hid);
+ printk(KERN_INFO\"The simple HID device \\\'%s\\\' attatch on 
\\\'%s\\\'\\n\", simple->name, hid->name);
+ }
+}
+
+static void
+hidinput_simple_device_bind(struct usb_interface *intf)
+{
+ struct hidinput_simple_device *simple;
+ struct list_head *node;
+ struct hid_device *hid;
+
+ if (!intf)
+ return;
+
+ simple = 0;
+ spin_lock(&simple_lock);
+ list_for_each(node, &simple_devices_list) {
+ simple = list_entry(node, struct hidinput_simple_device, node);
+ if (usb_match_id(intf, simple->id))
+ break;
+ simple = 0;
+ }
+ spin_unlock(&simple_lock);
+ /* no such simple device match this hid_device, also ok */
+ if (0 == simple)
+ return;
+
+ hid = usb_get_intfdata (intf);
+ if ((simple->connect && 0==simple->connect(hid)) || !simple->connect) {
+ simple->intf = intf;
+ hid->simple = simple;
+ spin_lock(&simple_lock);
+ list_del(&simple->node);
+ spin_unlock(&simple_lock);
+ hidinput_simple_device_setup_usage(hid);
+ printk(KERN_INFO\"The simple HID device \\\'%s\\\' attatch on 
\\\'%s\\\'\\n\", simple->name, hid->name);
+ }
+}
+
+int
+hidinput_register_simple_device(struct hidinput_simple_device *simple)
+{
+ struct list_head *node;
+ struct matched_device *matched;
+
+ if (!simple || !simple->name || simple->intf)
+ return -1;
+
+ simple->flags = 0;
+ matched = 0;
+
+ spin_lock(&matched_lock);
+ list_for_each(node, &matched_devices_list) {
+ matched = list_entry(node, struct matched_device, node);
+ if (usb_match_id(matched->intf, simple->id))
+ break;
+ matched = 0;
+ }
+ spin_unlock(&matched_lock);
+
+ if (matched) {/* We called hid_probe() on this usb_interface ago */
+ struct hid_device *hid;
+
+ hid = usb_get_intfdata (matched->intf);
+ if (hid->simple)
+ goto device_busy;
+ if ((simple->connect && 0==simple->connect(hid)) || !simple->connect) {
+ simple->intf = matched->intf;
+ hid->simple = simple;
+ hidinput_simple_device_setup_usage(hid);
+ printk(KERN_INFO\"The simple HID device \\\'%s\\\' attatch on 
\\\'%s\\\'\\n\", simple->name, hid->name);
+ return 0;
+ }
+ }
+ return 0;
+
+ device_busy:
+ spin_lock(&simple_lock);
+ list_add(&simple->node, &simple_devices_list);
+ spin_unlock(&simple_lock);
+ return 1;
+}
+
+EXPORT_SYMBOL(hidinput_register_simple_device);
+
+void
+hidinput_unregister_simple_device(struct hidinput_simple_device *simple)
+{
+ if (simple->intf) {
+ struct hid_device *hid;
+ hid = usb_get_intfdata (simple->intf);
+
+ if (hid->simple != simple)
+ printk(KERN_ERR\"failed to check simple device for consistency at %s 
%d \\n\", __FUNCTION__, __LINE__);
+ hidinput_simple_device_clear_usage(hid);
+ if (simple->disconnect)
+ simple->disconnect(hid);
+ hid->simple = 0;
+ simple->intf = 0;
+ simple->flags = 0;
+ } else {
+ spin_lock(&simple_lock);
+ list_del(&simple->node);
+ spin_unlock(&simple_lock);
+ }
+ /* to active simple device that matched current HID device is waiting */
+ hidinput_simple_device_bind_foreach();
+ printk(KERN_INFO\"The simple HID device \\\'%s\\\' unregistered.\\n\", 
simple->name);
+}
+
+EXPORT_SYMBOL(hidinput_unregister_simple_device);
+
static int hid_probe(struct usb_interface *intf, const struct 
usb_device_id *id)
{
struct hid_device *hid;
char path[64];
int i;
char *c;
-
+ struct matched_device *matched;
+
dbg(\"HID probe called for ifnum %d\",
intf->altsetting->desc.bInterfaceNumber);

@@ -1858,14 +2055,23 @@ static int hid_probe(struct usb_interfac

hid_init_reports(hid);
hid_dump_device(hid);
-
- if (!hidinput_connect(hid))
+
+ usb_set_intfdata(intf, hid);
+
+ if (!hidinput_connect(hid)) {
+ matched = kmalloc(sizeof(struct matched_device), GFP_KERNEL);
+ if (matched) {
+ matched->intf = intf;
+ spin_lock(&matched_lock);
+ list_add(&matched->node, &matched_devices_list);
+ spin_unlock(&matched_lock);
+ hidinput_simple_device_bind(intf);
+ }
hid->claimed |= HID_CLAIMED_INPUT;
+ }
if (!hiddev_connect(hid))
hid->claimed |= HID_CLAIMED_HIDDEV;

- usb_set_intfdata(intf, hid);
-
if (!hid->claimed) {
printk (\"HID device not claimed by input or hiddev\\n\");
hid_disconnect(intf);
@@ -1945,6 +2151,12 @@ static int __init hid_init(void)
retval = hiddev_init();
if (retval)
goto hiddev_init_fail;
+
+ spin_lock_init(&matched_lock);
+ spin_lock_init(&simple_lock);
+ INIT_LIST_HEAD(&matched_devices_list);
+ INIT_LIST_HEAD(&simple_devices_list);
+
retval = usb_register(&hid_driver);
if (retval)
goto usb_register_fail;
diff -Naurp linux-2.6.15.orig/drivers/usb/input/hid.h 
linux-2.6.15/drivers/usb/input/hid.h
--- linux-2.6.15.orig/drivers/usb/input/hid.h 2006-01-03 
11:21:10.000000000 +0800
+++ linux-2.6.15/drivers/usb/input/hid.h 2006-01-04 10:17:10.000000000 +0800
@@ -6,6 +6,7 @@
*
* Copyright (c) 1999 Andreas Gal
* Copyright (c) 2000-2001 Vojtech Pavlik
+ * Copyright (c) 2005 Liyu To support simple HID device.
*/

/*
@@ -374,6 +375,8 @@ struct hid_input {
struct input_dev *input;
};

+struct hidinput_simple_device;
+
struct hid_device { /* device report descriptor */
__u8 *rdesc;
unsigned rsize;
@@ -431,6 +434,7 @@ struct hid_device { /* device repo
void (*ff_exit)(struct hid_device*); /* Called by hid_exit_ff(hid) */
int (*ff_event)(struct hid_device *hid, struct input_dev *input,
unsigned int type, unsigned int code, int value);
+ struct hidinput_simple_device *simple;
};

#define HID_GLOBAL_STACK_SIZE 4
@@ -471,7 +475,6 @@ struct hid_descriptor {
#define resolv_event(a,b) do { } while (0)
#endif

-#endif

#ifdef CONFIG_USB_HIDINPUT
/* Applications from HID Usage Tables 4/8/99 Version 1.1 */
@@ -515,3 +518,5 @@ static inline int hid_ff_event(struct hi
return hid->ff_event(hid, input, type, code, value);
return -ENOSYS;
}
+
+#endif
diff -Naurp linux-2.6.15.orig/drivers/usb/input/hid-input.c 
linux-2.6.15/drivers/usb/input/hid-input.c
--- linux-2.6.15.orig/drivers/usb/input/hid-input.c 2006-01-03 
11:21:10.000000000 +0800
+++ linux-2.6.15/drivers/usb/input/hid-input.c 2006-01-04 
10:17:11.000000000 +0800
@@ -36,6 +36,7 @@
#undef DEBUG

#include \"hid.h\"
+#include \"hid-simple.h\"

#define unk KEY_UNKNOWN

@@ -676,6 +677,49 @@ int hidinput_connect(struct hid_device *
return 0;
}

+/*
+ * To give one simple device a configure usage chance.
+ * The most code of this function is copied from hidinput_connect()
+ */
+void hidinput_simple_device_configure_usage(struct hid_device *hid)
+{
+ struct hid_report *report;
+ int i, j, k;
+ void (*do_usage)(struct hid_field *, struct hid_usage *);
+
+ if (!hid->simple)
+ return;
+ do_usage = 0;
+ if (hid->simple->flags & HIDINPUT_SIMPLE_SETUP_USAGE)
+ do_usage = hid->simple->setup_usage;
+ else
+ do_usage = hid->simple->clear_usage;
+ if (!do_usage)
+ return;
+
+ for (i = 0; i < hid->maxcollection; i++)
+ if (hid->collection[i].type == HID_COLLECTION_APPLICATION ||
+ hid->collection[i].type == HID_COLLECTION_PHYSICAL)
+ if (IS_INPUT_APPLICATION(hid->collection[i].usage))
+ break;
+
+ if (i == hid->maxcollection)
+ return;
+
+ for (k = HID_INPUT_REPORT; k <= HID_OUTPUT_REPORT; k++)
+ list_for_each_entry(report, &hid->report_enum[k].report_list, list) {
+
+ if (!report->maxfield)
+ continue;
+
+ for (i = 0; i < report->maxfield; i++)
+ for (j = 0; j < report->field[i]->maxusage; j++)
+ do_usage(report->field[i], report->field[i]->usage + j);
+ }
+
+ return;
+}
+
void hidinput_disconnect(struct hid_device *hid)
{
struct hid_input *hidinput, *next;
diff -Naurp linux-2.6.15.orig/drivers/usb/input/hid-simple.h 
linux-2.6.15/drivers/usb/input/hid-simple.h
--- linux-2.6.15.orig/drivers/usb/input/hid-simple.h 1970-01-01 
08:00:00.000000000 +0800
+++ linux-2.6.15/drivers/usb/input/hid-simple.h 2006-01-04 
10:17:11.000000000 +0800
@@ -0,0 +1,62 @@
+#ifndef __HID_SIMPLE_H
+#define __HID_SIMPLE_H
+
+#include
+#include \"hid.h\"
+
+/************ The private section for simple device implement only 
**************/
+
+/* The element of matched_device list is inserted at hidinput_connect(),
+ and is removed at hidinput_disconnect().
+ */
+struct matched_device {
+ struct usb_interface *intf;
+ struct list_head node;
+};
+
+/* simple device internal flags */
+#define HIDINPUT_SIMPLE_SETUP_USAGE 0x1 /* the reverse is to call 
clear_usage */
+
+#define hidinput_simple_device_setup_usage(hid) \\
+do {\\
+ if (hid->simple) {\\
+ hid->simple->flags |= HIDINPUT_SIMPLE_SETUP_USAGE; \\
+ hidinput_simple_device_configure_usage(hid); \\
+ }\\
+} while (0)
+
+#define hidinput_simple_device_clear_usage(hid) \\
+do {\\
+ if (hid->simple) {\\
+ hid->simple->flags &= (~HIDINPUT_SIMPLE_SETUP_USAGE); \\
+ hidinput_simple_device_configure_usage(hid); \\
+ }\\
+} while (0)
+
+/* It is defined at hid_input.c, however is called at hid-core.c */
+void hidinput_simple_device_configure_usage(struct hid_device *hid);
+
+/******************** The private section end. 
*****************************/
+
+
+/********************* The public interface for simple device driver 
***********/
+struct hidinput_simple_device {
+/* private */
+ struct list_head node;
+ struct usb_interface *intf;
+ int flags;
+/* public */
+ char *name;
+ int (*connect)(struct hid_device *);
+ void (*setup_usage)(struct hid_field *, struct hid_usage *);
+ void (*event)(const struct hid_device *, const struct hid_field *, 
const struct hid_usage *, const __s32, const struct pt_regs *regs);
+ void (*clear_usage)(struct hid_field *, struct hid_usage *);
+ void (*disconnect)(struct hid_device *);
+ struct usb_device_id id[2]; /* variable length member */
+};
+
+int hidinput_register_simple_device(struct hidinput_simple_device *device);
+void hidinput_unregister_simple_device(struct hidinput_simple_device 
*device);
+/********************* The public section end ***********/
+
+#endif /* __HID_SIMPLE_H */

