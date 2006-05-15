Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965247AbWEOVSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965247AbWEOVSN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 17:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965238AbWEOVSB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 17:18:01 -0400
Received: from pne-smtpout3-sn2.hy.skanova.net ([81.228.8.111]:63701 "EHLO
	pne-smtpout3-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S965247AbWEOVR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 17:17:57 -0400
Message-Id: <20060515211512.018811000@gmail.com>
References: <20060515211229.521198000@gmail.com>
User-Agent: quilt/0.44-1
Date: Tue, 16 May 2006 00:12:40 +0300
From: Anssi Hannula <anssi.hannula@gmail.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-joystick@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [patch 11/11] input: drop the old PID driver
Content-Disposition: inline; filename=ff-refactoring-drop-old-pid.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the old PID driver that is now obsoleted by a new implementation in
hid-pidff.c. This older driver was never completed and is not able to upload
effects.

Signed-off-by: Anssi Hannula <anssi.hannula@gmail.com>

---
 drivers/usb/input/pid.c |  295 ------------------------------------------------
 drivers/usb/input/pid.h |   62 ----------
 2 files changed, 357 deletions(-)

Index: linux-2.6.16-git20/drivers/usb/input/pid.c
===================================================================
--- linux-2.6.16-git20.orig/drivers/usb/input/pid.c	2006-04-10 21:02:44.000000000 +0300
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,295 +0,0 @@
-/*
- *  PID Force feedback support for hid devices.
- *
- *  Copyright (c) 2002 Rodrigo Damazio.
- *  Portions by Johann Deneux and Bjorn Augustson
- */
-
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- * Should you need to contact me, the author, you can do so by
- * e-mail - mail your message to <rdamazio@lsi.usp.br>
- */
-
-#include <linux/config.h>
-#include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/mm.h>
-#include <linux/smp_lock.h>
-#include <linux/spinlock.h>
-#include <linux/input.h>
-#include <linux/usb.h>
-#include "hid.h"
-#include "pid.h"
-
-#define CHECK_OWNERSHIP(i, hid_pid)	\
-	((i) < FF_EFFECTS_MAX && i >= 0 && \
-	test_bit(FF_PID_FLAGS_USED, &hid_pid->effects[(i)].flags) && \
-	(current->pid == 0 || \
-	(hid_pid)->effects[(i)].owner == current->pid))
-
-/* Called when a transfer is completed */
-static void hid_pid_ctrl_out(struct urb *u, struct pt_regs *regs)
-{
-	dev_dbg(&u->dev->dev, "hid_pid_ctrl_out - Transfer Completed\n");
-}
-
-static void hid_pid_exit(struct hid_device *hid)
-{
-	struct hid_ff_pid *private = hid->ff_private;
-
-	if (private->urbffout) {
-		usb_kill_urb(private->urbffout);
-		usb_free_urb(private->urbffout);
-	}
-}
-
-static int pid_upload_periodic(struct hid_ff_pid *pid, struct ff_effect *effect, int is_update)
-{
-	dev_info(&pid->hid->dev->dev, "requested periodic force upload\n");
-	return 0;
-}
-
-static int pid_upload_constant(struct hid_ff_pid *pid, struct ff_effect *effect, int is_update)
-{
-	dev_info(&pid->hid->dev->dev, "requested constant force upload\n");
-	return 0;
-}
-
-static int pid_upload_condition(struct hid_ff_pid *pid, struct ff_effect *effect, int is_update)
-{
-	dev_info(&pid->hid->dev->dev, "requested Condition force upload\n");
-	return 0;
-}
-
-static int pid_upload_ramp(struct hid_ff_pid *pid, struct ff_effect *effect, int is_update)
-{
-	dev_info(&pid->hid->dev->dev, "request ramp force upload\n");
-	return 0;
-}
-
-static int hid_pid_event(struct hid_device *hid, struct input_dev *input,
-			 unsigned int type, unsigned int code, int value)
-{
-	dev_dbg(&hid->dev->dev, "PID event received: type=%d,code=%d,value=%d.\n", type, code, value);
-
-	if (type != EV_FF)
-		return -1;
-
-	return 0;
-}
-
-/* Lock must be held by caller */
-static void hid_pid_ctrl_playback(struct hid_device *hid, struct hid_pid_effect *effect, int play)
-{
-	if (play)
-		set_bit(FF_PID_FLAGS_PLAYING, &effect->flags);
-	else
-		clear_bit(FF_PID_FLAGS_PLAYING, &effect->flags);
-}
-
-static int hid_pid_erase(struct input_dev *dev, int id)
-{
-	struct hid_device *hid = dev->private;
-	struct hid_ff_pid *pid = hid->ff_private;
-	struct hid_field *field;
-	unsigned long flags;
-	int ret;
-
-	if (!CHECK_OWNERSHIP(id, pid))
-		return -EACCES;
-
-	/* Find report */
-	field = hid_find_field_by_usage(hid, HID_UP_PID | FF_PID_USAGE_BLOCK_FREE,
-					HID_OUTPUT_REPORT);
-	if (!field) {
-		dev_err(&hid->dev->dev, "couldn't find report\n");
-		return -EIO;
-	}
-
-	ret = hid_set_field(field, 0, pid->effects[id].device_id);
-	if (ret) {
-		dev_err(&hid->dev->dev, "couldn't set field\n");
-		return ret;
-	}
-
-	hid_submit_report(hid, field->report, USB_DIR_OUT);
-
-	spin_lock_irqsave(&pid->lock, flags);
-	hid_pid_ctrl_playback(hid, pid->effects + id, 0);
-	pid->effects[id].flags = 0;
-	spin_unlock_irqrestore(&pid->lock, flags);
-
-	return 0;
-}
-
-/* Erase all effects this process owns */
-static int hid_pid_flush(struct input_dev *dev, struct file *file)
-{
-	struct hid_device *hid = dev->private;
-	struct hid_ff_pid *pid = hid->ff_private;
-	int i;
-
-	/*NOTE: no need to lock here. The only times EFFECT_USED is
-	   modified is when effects are uploaded or when an effect is
-	   erased. But a process cannot close its dev/input/eventX fd
-	   and perform ioctls on the same fd all at the same time */
-	/*FIXME: multiple threads, anyone? */
-	for (i = 0; i < dev->ff_effects_max; ++i)
-		if (current->pid == pid->effects[i].owner
-		    && test_bit(FF_PID_FLAGS_USED, &pid->effects[i].flags))
-			if (hid_pid_erase(dev, i))
-				dev_warn(&hid->dev->dev, "erase effect %d failed", i);
-
-	return 0;
-}
-
-static int hid_pid_upload_effect(struct input_dev *dev,
-				 struct ff_effect *effect)
-{
-	struct hid_ff_pid *pid_private = (struct hid_ff_pid *)(dev->private);
-	int ret;
-	int is_update;
-	unsigned long flags;
-
-	dev_dbg(&pid_private->hid->dev->dev, "upload effect called: effect_type=%x\n", effect->type);
-	/* Check this effect type is supported by this device */
-	if (!test_bit(effect->type, dev->ffbit)) {
-		dev_dbg(&pid_private->hid->dev->dev,
-			"invalid kind of effect requested.\n");
-		return -EINVAL;
-	}
-
-	/*
-	 * If we want to create a new effect, get a free id
-	 */
-	if (effect->id == -1) {
-		int id = 0;
-
-		// Spinlock so we don`t get a race condition when choosing IDs
-		spin_lock_irqsave(&pid_private->lock, flags);
-
-		while (id < FF_EFFECTS_MAX)
-			if (!test_and_set_bit(FF_PID_FLAGS_USED, &pid_private->effects[id++].flags))
-				break;
-
-		if (id == FF_EFFECTS_MAX) {
-			spin_unlock_irqrestore(&pid_private->lock, flags);
-// TEMP - We need to get ff_effects_max correctly first:  || id >= dev->ff_effects_max) {
-			dev_dbg(&pid_private->hid->dev->dev, "Not enough device memory\n");
-			return -ENOMEM;
-		}
-
-		effect->id = id;
-		dev_dbg(&pid_private->hid->dev->dev, "effect ID is %d.\n", id);
-		pid_private->effects[id].owner = current->pid;
-		pid_private->effects[id].flags = (1 << FF_PID_FLAGS_USED);
-		spin_unlock_irqrestore(&pid_private->lock, flags);
-
-		is_update = FF_PID_FALSE;
-	} else {
-		/* We want to update an effect */
-		if (!CHECK_OWNERSHIP(effect->id, pid_private))
-			return -EACCES;
-
-		/* Parameter type cannot be updated */
-		if (effect->type != pid_private->effects[effect->id].effect.type)
-			return -EINVAL;
-
-		/* Check the effect is not already being updated */
-		if (test_bit(FF_PID_FLAGS_UPDATING, &pid_private->effects[effect->id].flags))
-			return -EAGAIN;
-
-		is_update = FF_PID_TRUE;
-	}
-
-	/*
-	 * Upload the effect
-	 */
-	switch (effect->type) {
-	case FF_PERIODIC:
-		ret = pid_upload_periodic(pid_private, effect, is_update);
-		break;
-
-	case FF_CONSTANT:
-		ret = pid_upload_constant(pid_private, effect, is_update);
-		break;
-
-	case FF_SPRING:
-	case FF_FRICTION:
-	case FF_DAMPER:
-	case FF_INERTIA:
-		ret = pid_upload_condition(pid_private, effect, is_update);
-		break;
-
-	case FF_RAMP:
-		ret = pid_upload_ramp(pid_private, effect, is_update);
-		break;
-
-	default:
-		dev_dbg(&pid_private->hid->dev->dev,
-			"invalid type of effect requested - %x.\n",
-			effect->type);
-		return -EINVAL;
-	}
-	/* If a packet was sent, forbid new updates until we are notified
-	 * that the packet was updated
-	 */
-	if (ret == 0)
-		set_bit(FF_PID_FLAGS_UPDATING, &pid_private->effects[effect->id].flags);
-	pid_private->effects[effect->id].effect = *effect;
-	return ret;
-}
-
-int hid_pid_init(struct hid_device *hid)
-{
-	struct hid_ff_pid *private;
-	struct hid_input *hidinput = list_entry(hid->inputs.next, struct hid_input, list);
-	struct input_dev *input_dev = hidinput->input;
-
-	private = hid->ff_private = kzalloc(sizeof(struct hid_ff_pid), GFP_KERNEL);
-	if (!private)
-		return -ENOMEM;
-
-	private->hid = hid;
-
-	hid->ff_exit = hid_pid_exit;
-	hid->ff_event = hid_pid_event;
-
-	/* Open output URB */
-	if (!(private->urbffout = usb_alloc_urb(0, GFP_KERNEL))) {
-		kfree(private);
-		return -1;
-	}
-
-	usb_fill_control_urb(private->urbffout, hid->dev, 0,
-			     (void *)&private->ffcr, private->ctrl_buffer, 8,
-			     hid_pid_ctrl_out, hid);
-
-	input_dev->upload_effect = hid_pid_upload_effect;
-	input_dev->flush = hid_pid_flush;
-	input_dev->ff_effects_max = 8;	// A random default
-	set_bit(EV_FF, input_dev->evbit);
-	set_bit(EV_FF_STATUS, input_dev->evbit);
-
-	spin_lock_init(&private->lock);
-
-	printk(KERN_INFO "Force feedback driver for PID devices by Rodrigo Damazio <rdamazio@lsi.usp.br>.\n");
-
-	return 0;
-}
Index: linux-2.6.16-git20/drivers/usb/input/pid.h
===================================================================
--- linux-2.6.16-git20.orig/drivers/usb/input/pid.h	2006-04-10 21:02:44.000000000 +0300
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,62 +0,0 @@
-/*
- *  PID Force feedback support for hid devices.
- *
- *  Copyright (c) 2002 Rodrigo Damazio.
- */
-
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- * Should you need to contact me, the author, you can do so by
- * e-mail - mail your message to <rdamazio@lsi.usp.br>
- */
-
-#define FF_EFFECTS_MAX 64
-
-#define FF_PID_FLAGS_USED	1	/* If the effect exists */
-#define FF_PID_FLAGS_UPDATING	2	/* If the effect is being updated */
-#define FF_PID_FLAGS_PLAYING	3	/* If the effect is currently being played */
-
-#define FF_PID_FALSE	0
-#define FF_PID_TRUE	1
-
-struct hid_pid_effect {
-	unsigned long flags;
-	pid_t owner;
-	unsigned int device_id;	/* The device-assigned ID */
-	struct ff_effect effect;
-};
-
-struct hid_ff_pid {
-	struct hid_device *hid;
-	unsigned long gain;
-
-	struct urb *urbffout;
-	struct usb_ctrlrequest ffcr;
-	spinlock_t lock;
-
-	unsigned char ctrl_buffer[8];
-
-	struct hid_pid_effect effects[FF_EFFECTS_MAX];
-};
-
-/*
- * Constants from the PID usage table (still far from complete)
- */
-
-#define FF_PID_USAGE_BLOCK_LOAD 	0x89UL
-#define FF_PID_USAGE_BLOCK_FREE		0x90UL
-#define FF_PID_USAGE_NEW_EFFECT 	0xABUL
-#define FF_PID_USAGE_POOL_REPORT	0x7FUL

--
Anssi Hannula
