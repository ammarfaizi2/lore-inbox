Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422645AbWHDX2B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422645AbWHDX2B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 19:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161578AbWHDX2B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 19:28:01 -0400
Received: from halon.profiwh.com ([85.93.165.2]:43462 "EHLO orfeus.profiwh.com")
	by vger.kernel.org with ESMTP id S1161473AbWHDX17 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 19:27:59 -0400
Message-ID: <44D3D810.4020903@liberouter.org>
Date: Sat, 05 Aug 2006 01:27:53 +0159
From: Jiri Slaby <slaby@liberouter.org>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: liyu <liyu@ccoss.com.cn>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: The HID Simple Driver Interface 0.3.0
References: <200608031806087610533@ccoss.com.cn>
In-Reply-To: <200608031806087610533@ccoss.com.cn>
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
X-SpamReason: {Bypass=00}-{0,00}-{0,00}-{0,00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

liyu wrote:
> You can see one example in  "[PATCH] usb: Microsoft Natural Ergonomic Keyboard 4000 Driver 0.3.0"
> 
> Changelogs: ( upto 20060803)
> 
> 	1. Release version 0.3.0.	
> 
> Changelogs: ( upto 20060728)
> 
> 	1. Fixed the inline function redefine error.
> 	2. Fixed the bug that access invalid address hidinput_simple_driver_pop().
> 	
> Signed-off-by: Liyu <liyu@ccoss.com.cn>
> 
> diff -Naurp linux-2.6.17.7/drivers/usb/input.orig/hid-core.c linux-2.6.17.7/drivers/usb/input/hid-core.c
> --- linux-2.6.17.7/drivers/usb/input.orig/hid-core.c	2006-07-25 11:36:01.000000000 +0800
> +++ linux-2.6.17.7/drivers/usb/input/hid-core.c	2006-08-03 15:44:45.000000000 +0800
> @@ -4,6 +4,7 @@
>   *  Copyright (c) 1999 Andreas Gal
>   *  Copyright (c) 2000-2005 Vojtech Pavlik <vojtech@suse.cz>
>   *  Copyright (c) 2005 Michael Haboustak <mike-@cinci.rr.com> for Concept2, Inc
> + *  Copyright (c) 2006 Liyu <liyu@ccoss.com.cn>  HID simple driver interface
>   */
>  
>  /*
> @@ -26,6 +27,7 @@
>  #include <asm/byteorder.h>
>  #include <linux/input.h>
>  #include <linux/wait.h>
> +#include <asm/semaphore.h>
>  
>  #undef DEBUG
>  #undef DEBUG_DATA
> @@ -33,6 +35,7 @@
>  #include <linux/usb.h>
>  
>  #include "hid.h"
> +#include "hid-simple.h"
>  #include <linux/hiddev.h>
>  
>  /*
> @@ -46,6 +49,15 @@
>  
>  static char *hid_types[] = {"Device", "Pointer", "Mouse", "Device", "Joystick",
>  				"Gamepad", "Keyboard", "Keypad", "Multi-Axis Controller"};
> +
> +/*
> + * The global data structure for simple device driver interface.
> + */
> +static DECLARE_MUTEX(matched_lock);
> +static DECLARE_MUTEX(simple_lock);
> +static struct list_head matched_devices_list;
> +static struct list_head simple_drivers_list;
> +
>  /*
>   * Module parameters.
>   */
> @@ -785,8 +797,17 @@ static __inline__ int search(__s32 *arra
>  static void hid_process_event(struct hid_device *hid, struct hid_field *field, struct hid_usage *usage, __s32 value, int interrupt, struct pt_regs *regs)
>  {
>  	hid_dump_input(usage, value);
> -	if (hid->claimed & HID_CLAIMED_INPUT)
> +	if (hid->claimed & HID_CLAIMED_INPUT) {
> +		if (hid->simple) {
> +			if (hid->simple->pre_event &&
> +				!hid->simple->pre_event(hid, field, usage, 
> +								value, regs))
> +			return;
> +		}
>  		hidinput_hid_event(hid, field, usage, value, regs);
> +		if (hid->simple && hid->simple->post_event)
> +			hid->simple->post_event(hid, field, usage, value, regs);
> +	}
>  	if (hid->claimed & HID_CLAIMED_HIDDEV && interrupt)
>  		hiddev_hid_event(hid, field, usage, value, regs);
>  }
> @@ -832,7 +853,6 @@ static void hid_input_field(struct hid_d
>  			&& field->usage[field->value[n] - min].hid
>  			&& search(value, field->value[n], count))
>  				hid_process_event(hid, field, &field->usage[field->value[n] - min], 0, interrupt, regs);
> -
>  		if (value[n] >= min && value[n] <= max
>  			&& field->usage[value[n] - min].hid
>  			&& search(field->value, value[n], count))
> @@ -1977,6 +1997,8 @@ fail:
>  static void hid_disconnect(struct usb_interface *intf)
>  {
>  	struct hid_device *hid = usb_get_intfdata (intf);
> +	struct list_head *node;
> +	struct matched_device *matched;
>  
>  	if (!hid)
>  		return;
> @@ -1991,8 +2013,29 @@ static void hid_disconnect(struct usb_in
>  	del_timer_sync(&hid->io_retry);
>  	flush_scheduled_work();
>  
> -	if (hid->claimed & HID_CLAIMED_INPUT)
> +	if (hid->claimed & HID_CLAIMED_INPUT) {
> +		matched = NULL;
> +		down(&matched_lock);
> +		list_for_each(node, &matched_devices_list) {
> +			matched = list_entry(node, struct matched_device, node);
> +			if (matched->intf == intf) {
> +				list_del(&matched->node);
> +				break;
> +			}
> +			matched = NULL;
> +		}
> +		up(&matched_lock);
> +		/* disconnect simple device driver if need */
> +		if (matched && hid->simple) {
> +			hidinput_simple_driver_disconnect(hid);
> +			hidinput_simple_driver_pop(hid, matched);
> +		}
> +		if (matched) {
> +			matched->intf = NULL;
> +			kfree(matched);
> +		}
>  		hidinput_disconnect(hid);
> +	}
>  	if (hid->claimed & HID_CLAIMED_HIDDEV)
>  		hiddev_disconnect(hid);
>  
> @@ -2005,12 +2048,143 @@ static void hid_disconnect(struct usb_in
>  	hid_free_device(hid);
>  }
>  
> +
> +/* called when we unregister a hidinput simple device driver */
> +static void
> +hidinput_simple_driver_bind_foreach(void)
> +{
> +	struct hidinput_simple_driver *simple;
> +	struct matched_device *matched=NULL;
> +	struct list_head *matched_node = NULL;
> +	struct list_head *simple_node = NULL;
> +	struct hid_device *hid=NULL;
> +
> +	down(&matched_lock);
> +	list_for_each(matched_node, &matched_devices_list) {
> +		matched = list_entry(matched_node, struct matched_device, node);
> +		hid = usb_get_intfdata(matched->intf);
> +		if (hid->simple)
> +			continue;
> +		down(&simple_lock);
> +		list_for_each(simple_node, &simple_drivers_list) {
> +			simple = list_entry(simple_node, struct hidinput_simple_driver, node);
> +			if (!usb_match_id(matched->intf, simple->id_table))
> +				continue;
> +			if (hidinput_simple_driver_connect(simple, hid))
> +				continue;
> +			if (hidinput_simple_driver_push(hid, simple, matched))
> +				continue;
> +			hidinput_simple_driver_setup_usage(hid);
> +			printk(KERN_INFO"The simple HID driver \'%s\' attach on"
> +								"\'%s\'\n",
> +								simple->name,
> +								hid->name);
> +		}
> +		up(&simple_lock);
> +	}
> +	up(&matched_lock);
> +	
> +}
> +
> +/* called in hid_probe() */
> +static void
> +hidinput_simple_driver_bind(struct matched_device *matched)
> +{
> +	struct hidinput_simple_driver *simple;
> +	struct list_head *node;
> +	struct hid_device *hid;
> +	
> +	if (!matched->intf)
> +		return;
> +	hid = usb_get_intfdata (matched->intf);
> +	if (hid->simple)
> +		return;
> +
> +	simple = NULL;
> +	down(&simple_lock);
> +	list_for_each(node, &simple_drivers_list) {
> +		simple = list_entry(node, struct hidinput_simple_driver, node);
> +		if (usb_match_id(matched->intf, simple->id_table))
> +			break;
> +		simple = NULL;
> +	}
> +	up(&simple_lock);
> +	
> +	if (!simple) 
> +		return;
> +	if (hidinput_simple_driver_connect(simple, hid))
> +		return;
> +	if (hidinput_simple_driver_push(hid, simple, matched))
> +		return;
> +	hidinput_simple_driver_setup_usage(hid);
> +
> +	printk(KERN_INFO"The simple HID driver \'%s\' attach on \'%s\'\n", 
> +						simple->name, hid->name);
> +}
> +
> +int
> +hidinput_register_simple_driver(struct hidinput_simple_driver *simple)
> +{
> +	struct list_head *node=NULL;
> +	struct matched_device *matched;
> +	struct hid_device *hid=NULL;
> +	int ret=0;
> +
> +	if (!simple || !simple->name)
> +		return -EINVAL;
> +
> +	hidinput_simple_driver_init(simple);
> +
> +	down(&matched_lock);
> +	list_for_each(node, &matched_devices_list) {
> +		matched = list_entry(node, struct matched_device, node);
> +		hid = usb_get_intfdata (matched->intf);
> +		if (hid->simple)
> +			continue;
> +		if (!usb_match_id(matched->intf, simple->id_table))
> +			continue;
> +		if (hidinput_simple_driver_connect(simple, hid))
> +			continue;
> +		if (hidinput_simple_driver_push(hid, simple, matched))
> +			continue;
> +		hidinput_simple_driver_setup_usage(hid);
> +		ret = 0;
> +		printk(KERN_INFO"The simple HID driver \'%s\' attach on"
> +							" \'%s\'.\n",
> +						 simple->name, hid->name);
> +	}
> +	up(&matched_lock);
> +
> +	down(&simple_lock);
> +	list_add(&simple->node, &simple_drivers_list);
> +	up(&simple_lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(hidinput_register_simple_driver);
> +
> +void
> +hidinput_unregister_simple_driver(struct hidinput_simple_driver *simple)
> +{
> +	hidinput_simple_driver_clear(simple);
> +	down(&simple_lock);
> +	list_del(&simple->node);
> +	up(&simple_lock);
> +	/* to active simple device driver that it is waiting */
> +	hidinput_simple_driver_bind_foreach();
> +	printk(KERN_INFO"The simple HID driver \'%s\' unregistered.\n", 
> +							simple->name);
> +}
> +
> +EXPORT_SYMBOL_GPL(hidinput_unregister_simple_driver);
> +
>  static int hid_probe(struct usb_interface *intf, const struct usb_device_id *id)
>  {
>  	struct hid_device *hid;
>  	char path[64];
>  	int i;
>  	char *c;
> +	struct matched_device *matched;
>  
>  	dbg("HID probe called for ifnum %d",
>  			intf->altsetting->desc.bInterfaceNumber);
> @@ -2021,13 +2195,22 @@ static int hid_probe(struct usb_interfac
>  	hid_init_reports(hid);
>  	hid_dump_device(hid);
>  
> -	if (!hidinput_connect(hid))
> +	usb_set_intfdata(intf, hid);
> +
> +	if (!hidinput_connect(hid)) {
> +		matched = kmalloc(sizeof(struct matched_device), GFP_KERNEL);
> +		if (matched) {
> +			matched->intf = intf;
> +			down(&matched_lock);
> +			list_add(&matched->node, &matched_devices_list);
> +			up(&matched_lock);
> +			hidinput_simple_driver_bind(matched);
> +		}
>  		hid->claimed |= HID_CLAIMED_INPUT;
> +	}
>  	if (!hiddev_connect(hid))
>  		hid->claimed |= HID_CLAIMED_HIDDEV;
>  
> -	usb_set_intfdata(intf, hid);
> -
>  	if (!hid->claimed) {
>  		printk ("HID device not claimed by input or hiddev\n");
>  		hid_disconnect(intf);
> @@ -2108,6 +2291,8 @@ static int __init hid_init(void)
>  	retval = hiddev_init();
>  	if (retval)
>  		goto hiddev_init_fail;
> +	INIT_LIST_HEAD(&matched_devices_list);
> +	INIT_LIST_HEAD(&simple_drivers_list);
>  	retval = usb_register(&hid_driver);
>  	if (retval)
>  		goto usb_register_fail;
> @@ -2122,7 +2307,15 @@ hiddev_init_fail:
>  
>  static void __exit hid_exit(void)
>  {
> +	struct list_head *node, *tmp;
> +	struct matched_device *matched;
> +	
>  	usb_deregister(&hid_driver);
> +	list_for_each_safe(node, tmp, &matched_devices_list) {
> +		matched = list_entry(node, struct matched_device, node);
> +		list_del(&matched->node);
> +		kfree(matched);
> +	}
>  	hiddev_exit();
>  }
>  
> diff -Naurp linux-2.6.17.7/drivers/usb/input.orig/hid.h linux-2.6.17.7/drivers/usb/input/hid.h
> --- linux-2.6.17.7/drivers/usb/input.orig/hid.h	2006-07-25 11:36:01.000000000 +0800
> +++ linux-2.6.17.7/drivers/usb/input/hid.h	2006-08-03 15:23:15.000000000 +0800
> @@ -6,6 +6,7 @@
>   *
>   *  Copyright (c) 1999 Andreas Gal
>   *  Copyright (c) 2000-2001 Vojtech Pavlik
> + *  Copyright (c) 2006 Liyu     To support simple HID device.
>   */
>  
>  /*
> @@ -380,8 +381,11 @@ struct hid_input {
>  	struct list_head list;
>  	struct hid_report *report;
>  	struct input_dev *input;
> +	void *private;
>  };
>  
> +struct hidinput_simple_driver;
> +
>  struct hid_device {							/* device report descriptor */
>  	 __u8 *rdesc;
>  	unsigned rsize;
> @@ -445,6 +449,8 @@ struct hid_device {							/* device repo
>  	int (*ff_event)(struct hid_device *hid, struct input_dev *input,
>  			unsigned int type, unsigned int code, int value);
>  
> +	struct hidinput_simple_driver *simple;
> +
>  #ifdef CONFIG_USB_HIDINPUT_POWERBOOK
>  	unsigned long pb_pressed_fn[NBITS(KEY_MAX)];
>  	unsigned long pb_pressed_numlock[NBITS(KEY_MAX)];
> diff -Naurp linux-2.6.17.7/drivers/usb/input.orig/hid-input.c linux-2.6.17.7/drivers/usb/input/hid-input.c
> --- linux-2.6.17.7/drivers/usb/input.orig/hid-input.c	2006-07-25 11:36:01.000000000 +0800
> +++ linux-2.6.17.7/drivers/usb/input/hid-input.c	2006-08-03 17:26:48.000000000 +0800
> @@ -2,6 +2,7 @@
>   * $Id: hid-input.c,v 1.2 2002/04/23 00:59:25 rdamazio Exp $
>   *
>   *  Copyright (c) 2000-2001 Vojtech Pavlik
> + *  Copyright (c) 2006 Liyu <liyu@ccoss.com.cn>  HID simple driver interface
>   *
>   *  USB HID to Linux Input mapping
>   */
> @@ -36,6 +37,7 @@
>  #undef DEBUG
>  
>  #include "hid.h"
> +#include "hid-simple.h"
>  
>  #define unk	KEY_UNKNOWN
>  
> @@ -63,6 +65,8 @@ static const struct {
>  	__s32 y;
>  }  hid_hat_to_axis[] = {{ 0, 0}, { 0,-1}, { 1,-1}, { 1, 0}, { 1, 1}, { 0, 1}, {-1, 1}, {-1, 0}, {-1,-1}};
>  
> +typedef void (*do_usage_t)(struct hid_field *, struct hid_usage *);
> +
>  #define map_abs(c)	do { usage->code = c; usage->type = EV_ABS; bit = input->absbit; max = ABS_MAX; } while (0)
>  #define map_rel(c)	do { usage->code = c; usage->type = EV_REL; bit = input->relbit; max = REL_MAX; } while (0)
>  #define map_key(c)	do { usage->code = c; usage->type = EV_KEY; bit = input->keybit; max = KEY_MAX; } while (0)
> @@ -849,6 +853,245 @@ int hidinput_connect(struct hid_device *
>  	return 0;
>  }
>  
> +int
> +hidinput_simple_driver_init(struct hidinput_simple_driver *drv)
> +{
> +	if (unlikely(!drv))
> +		return -EINVAL;
> +	INIT_LIST_HEAD(&drv->node);
> +	INIT_LIST_HEAD(&drv->raw_devices);
> +	drv->flags = 0;
> +	return 0;
> +}
> +
> +#define SET_BIT (1)
> +#define CLR_BIT (0)
> +static void inline
> +hidinput_simple_configure_one_usage(int op, struct input_dev *input, struct hid_usage *usage, struct usage_block *usage_block)
> +{
> +	unsigned long *bits;
> +
> +	switch (usage_block->event) {
> +		case EV_KEY:
> +			bits = input->keybit;	break;
> +		case EV_REL:
> +			bits = input->relbit;	break;
> +		case EV_ABS:
> +			bits = input->relbit;	break;
> +		case EV_MSC:
> +			bits = input->absbit;	break;
> +		case EV_SW:
> +			bits = input->swbit;	break;
> +		case EV_LED:
> +			bits = input->ledbit;	break;
> +		case EV_SND:
> +			bits = input->sndbit;	break;
> +		case EV_FF:
> +			bits = input->ffbit;	break;
> +		default:
> +			return;
> +	}
> +
> +	if (SET_BIT == op) {
> +		usage->code = usage_block->code;
> +		usage->type = usage_block->event;
> +		set_bit(usage_block->code, bits);
> +	}
> +	else if (CLR_BIT == op) {
> +		usage->code = 0;
> +		usage->type = 0;
> +		clear_bit(usage_block->code, bits);
> +	}
> +}
> +
> +static do_usage_t
> +hidinput_simple_driver_configure_usage_prep(struct hid_device *hid, int *op)
> +{
> +	do_usage_t do_usage;
> +
> +	if (!hid->simple)
> +		return NULL;
> +
> +	if (hid->simple->flags & HIDINPUT_SIMPLE_SETUP_USAGE) {
> +		do_usage = hid->simple->setup_usage;
> +		*op = SET_BIT;
> +	}
> +	else {
> +		do_usage = hid->simple->clear_usage;
> +		*op = CLR_BIT;
> +	}
> +	return do_usage;
> +}
> +
> +static void
> +__hidinput_simple_driver_configure_usage(int op,
> +					struct hid_field *field,
> +					struct hid_usage *hid_usage)
> +{
> +	struct input_dev *input = field->hidinput->input;
> +	struct hid_device *hid = input->private;
> +	struct usage_block *usage_block;
> +	struct usage_page_block *page_block;
> +	int page;
> +	int usage;
> +	
> +	page = (hid_usage->hid & HID_USAGE_PAGE);
> +	usage = (hid_usage->hid & HID_USAGE);
> +	page_block = hid->simple->usage_page_table;
> +
> +	for (;page_block && page_block->usage_blockes;page_block++) {
> +		if (page_block->page != page)
> +			continue;
> +		usage_block = page_block->usage_blockes;
> +		for (; usage_block && usage_block->usage; usage_block++) {
> +			if (usage_block->usage != usage)
> +				continue;
> +			hidinput_simple_configure_one_usage(op, input, 
> +						hid_usage, usage_block);
> +		}
> +	}
> +}
> +
> +/*
> + *  To give one simple device a configure usage chance.
> + *  The framework of this function come from hidinput_connect()
> + */
> +void hidinput_simple_driver_configure_usage(struct hid_device *hid)
> +{
> +	struct hid_report *report;
> +	int i, j, k;
> +	do_usage_t do_usage;
> +	int op;
> +
> +	if (!hid->simple)
> +		return;
> +
> +	do_usage = hidinput_simple_driver_configure_usage_prep(hid, &op);
> +
> +	for (i = 0; i < hid->maxcollection; i++)
> +		if (hid->collection[i].type == HID_COLLECTION_APPLICATION ||
> +			hid->collection[i].type==HID_COLLECTION_PHYSICAL)
> +			if (IS_INPUT_APPLICATION(hid->collection[i].usage))
> +				break;
> +
> +	if (i == hid->maxcollection)
> +		return;
> +
> +	for (k = HID_INPUT_REPORT; k <= HID_OUTPUT_REPORT; k++)
> +		list_for_each_entry(report, &hid->report_enum[k].report_list, list) {
> +			if (!report->maxfield)
> +				continue;
> +
> +			for (i = 0; i < report->maxfield; i++)
> +				for (j = 0; j < report->field[i]->maxusage; j++) {
> +					__hidinput_simple_driver_configure_usage(
> +									op,
> +							report->field[i],
> +						report->field[i]->usage + j);

this piece is ugly.

> +					if (do_usage)
> +						do_usage(report->field[i],
> +						report->field[i]->usage + j);
> +				}
> +		}
> +
> +	return;
> +}
> +#undef SET_BIT
> +#undef CLR_BIT
> +
> +int

unbsd this and others.

regards,
-- 
<a href="http://www.fi.muni.cz/~xslaby/">Jiri Slaby</a>
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
