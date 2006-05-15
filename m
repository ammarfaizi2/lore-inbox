Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965238AbWEOVTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965238AbWEOVTK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 17:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965239AbWEOVQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 17:16:11 -0400
Received: from pne-smtpout3-sn2.hy.skanova.net ([81.228.8.111]:30421 "EHLO
	pne-smtpout3-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S965238AbWEOVP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 17:15:57 -0400
Message-Id: <20060515211507.451601000@gmail.com>
References: <20060515211229.521198000@gmail.com>
User-Agent: quilt/0.44-1
Date: Tue, 16 May 2006 00:12:33 +0300
From: Anssi Hannula <anssi.hannula@gmail.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-joystick@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [patch 04/11] input: adapt hid force feedback drivers for the new interface
Content-Disposition: inline; filename=ff-refactoring-hid-to-new-interface.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Modify the HID force feedback drivers for the new interface. This removes a
lot of code duplication.

Signed-off-by: Anssi Hannula <anssi.hannula@gmail.com>

---
 drivers/usb/input/Kconfig     |    2 
 drivers/usb/input/hid-input.c |    3 
 drivers/usb/input/hid-lgff.c  |  457 ++++--------------------------------------
 drivers/usb/input/hid-tmff.c  |  353 ++------------------------------
 drivers/usb/input/hid.h       |    9 
 5 files changed, 81 insertions(+), 743 deletions(-)

Index: linux-2.6.17-rc4-git1/drivers/usb/input/hid.h
===================================================================
--- linux-2.6.17-rc4-git1.orig/drivers/usb/input/hid.h	2006-05-13 19:58:57.000000000 +0300
+++ linux-2.6.17-rc4-git1/drivers/usb/input/hid.h	2006-05-14 01:36:21.000000000 +0300
@@ -442,8 +442,6 @@ struct hid_device {							/* device repo
 
 	void *ff_private;                                               /* Private data for the force-feedback driver */
 	void (*ff_exit)(struct hid_device*);                            /* Called by hid_exit_ff(hid) */
-	int (*ff_event)(struct hid_device *hid, struct input_dev *input,
-			unsigned int type, unsigned int code, int value);
 
 #ifdef CONFIG_USB_HIDINPUT_POWERBOOK
 	unsigned long pb_pressed_fn[NBITS(KEY_MAX)];
@@ -526,13 +524,6 @@ static inline void hid_ff_exit(struct hi
 	if (hid->ff_exit)
 		hid->ff_exit(hid);
 }
-static inline int hid_ff_event(struct hid_device *hid, struct input_dev *input,
-			unsigned int type, unsigned int code, int value)
-{
-	if (hid->ff_event)
-		return hid->ff_event(hid, input, type, code, value);
-	return -ENOSYS;
-}
 
 int hid_lgff_init(struct hid_device* hid);
 int hid_tmff_init(struct hid_device* hid);
Index: linux-2.6.17-rc4-git1/drivers/usb/input/hid-input.c
===================================================================
--- linux-2.6.17-rc4-git1.orig/drivers/usb/input/hid-input.c	2006-05-13 19:58:57.000000000 +0300
+++ linux-2.6.17-rc4-git1/drivers/usb/input/hid-input.c	2006-05-14 01:36:21.000000000 +0300
@@ -736,9 +736,6 @@ static int hidinput_input_event(struct i
 	struct hid_field *field;
 	int offset;
 
-	if (type == EV_FF)
-		return hid_ff_event(hid, dev, type, code, value);
-
 	if (type != EV_LED)
 		return -1;
 
Index: linux-2.6.17-rc4-git1/drivers/usb/input/hid-lgff.c
===================================================================
--- linux-2.6.17-rc4-git1.orig/drivers/usb/input/hid-lgff.c	2006-05-14 00:14:43.000000000 +0300
+++ linux-2.6.17-rc4-git1/drivers/usb/input/hid-lgff.c	2006-05-14 01:41:39.000000000 +0300
@@ -7,6 +7,7 @@
  * - WingMan Force 3D
  *
  *  Copyright (c) 2002-2004 Johann Deneux
+ *  Copyright (c) 2006 Anssi Hannula <anssi.hannula@gmail.com>
  */
 
 /*
@@ -29,41 +30,8 @@
  */
 
 #include <linux/input.h>
-#include <linux/sched.h>
-
-//#define DEBUG
 #include <linux/usb.h>
-
-#include <linux/circ_buf.h>
-
 #include "hid.h"
-//#include "fixp-arith.h"
-
-
-/* Periodicity of the update */
-#define PERIOD (HZ/10)
-
-#define RUN_AT(t) (jiffies + (t))
-
-/* Effect status */
-#define EFFECT_STARTED 0     /* Effect is going to play after some time
-				(ff_replay.delay) */
-#define EFFECT_PLAYING 1     /* Effect is being played */
-#define EFFECT_USED    2
-
-// For lgff_device::flags
-#define DEVICE_CLOSING 0     /* The driver is being unitialised */
-
-/* Check that the current process can access an effect */
-#define CHECK_OWNERSHIP(effect) (current->pid == 0 \
-        || effect.owner == current->pid)
-
-#define LGFF_CHECK_OWNERSHIP(i, l) \
-        (i>=0 && i<LGFF_EFFECTS \
-        && test_bit(EFFECT_USED, l->effects[i].flags) \
-        && CHECK_OWNERSHIP(l->effects[i]))
-
-#define LGFF_EFFECTS 8
 
 struct device_type {
 	u16 idVendor;
@@ -71,48 +39,12 @@ struct device_type {
 	signed short *ff;
 };
 
-struct lgff_effect {
-	pid_t owner;
-
-	struct ff_effect effect;
-
-	unsigned long flags[1];
-	unsigned int count;          /* Number of times left to play */
-	unsigned long started_at;    /* When the effect started to play */
-};
-
-struct lgff_device {
-	struct hid_device* hid;
-
-	struct hid_report* constant;
-	struct hid_report* rumble;
-	struct hid_report* condition;
-
-	struct lgff_effect effects[LGFF_EFFECTS];
-	spinlock_t lock;             /* device-level lock. Having locks on
-					a per-effect basis could be nice, but
-					isn't really necessary */
-
-	unsigned long flags[1];      /* Contains various information about the
-				        state of the driver for this device */
-
-	struct timer_list timer;
-};
-
 /* Callbacks */
 static void hid_lgff_exit(struct hid_device* hid);
-static int hid_lgff_event(struct hid_device *hid, struct input_dev *input,
-			  unsigned int type, unsigned int code, int value);
-static int hid_lgff_flush(struct input_dev *input, struct file *file);
-static int hid_lgff_upload_effect(struct input_dev *input,
-				  struct ff_effect *effect);
-static int hid_lgff_erase(struct input_dev *input, int id);
+static int hid_lgff_play(struct input_dev *dev, struct ff_effect *effect, struct ff_effect *old);
 
-/* Local functions */
+/* Local function */
 static void hid_lgff_input_init(struct hid_device* hid);
-static void hid_lgff_timer(unsigned long timer_data);
-static struct hid_report* hid_lgff_duplicate_report(struct hid_report*);
-static void hid_lgff_delete_report(struct hid_report*);
 
 static signed short ff_rumble[] = {
 	FF_RUMBLE,
@@ -131,11 +63,17 @@ static struct device_type devices[] = {
 	{0x0000, 0x0000, ff_joystick}
 };
 
+static struct ff_driver lgff_driver = {
+	.upload = hid_lgff_play,
+};
+
 int hid_lgff_init(struct hid_device* hid)
 {
-	struct lgff_device *private;
 	struct hid_report* report;
 	struct hid_field* field;
+	struct hid_input *hidinput = list_entry(hid->inputs.next, struct hid_input, list);
+	struct input_dev *dev = hidinput->input;
+	int ret;
 
 	/* Find the report to use */
 	if (list_empty(&hid->report_enum[HID_OUTPUT_REPORT].report_list)) {
@@ -143,7 +81,7 @@ int hid_lgff_init(struct hid_device* hid
 		return -1;
 	}
 	/* Check that the report looks ok */
-	report = (struct hid_report*)hid->report_enum[HID_OUTPUT_REPORT].report_list.next;
+	report = list_entry(hid->report_enum[HID_OUTPUT_REPORT].report_list.next, struct hid_report, list);
 	if (!report) {
 		err("NULL output report");
 		return -1;
@@ -154,98 +92,22 @@ int hid_lgff_init(struct hid_device* hid
 		return -1;
 	}
 
-	private = kzalloc(sizeof(struct lgff_device), GFP_KERNEL);
-	if (!private)
-		return -1;
-	hid->ff_private = private;
+	ret = input_ff_allocate(dev);
+	if (ret)
+		return ret;
 
 	/* Input init */
 	hid_lgff_input_init(hid);
 
-
-	private->constant = hid_lgff_duplicate_report(report);
-	if (!private->constant) {
-		kfree(private);
-		return -1;
-	}
-	private->constant->field[0]->value[0] = 0x51;
-	private->constant->field[0]->value[1] = 0x08;
-	private->constant->field[0]->value[2] = 0x7f;
-	private->constant->field[0]->value[3] = 0x7f;
-
-	private->rumble = hid_lgff_duplicate_report(report);
-	if (!private->rumble) {
-		hid_lgff_delete_report(private->constant);
-		kfree(private);
-		return -1;
-	}
-	private->rumble->field[0]->value[0] = 0x42;
-
-
-	private->condition = hid_lgff_duplicate_report(report);
-	if (!private->condition) {
-		hid_lgff_delete_report(private->rumble);
-		hid_lgff_delete_report(private->constant);
-		kfree(private);
-		return -1;
-	}
-
-	private->hid = hid;
-
-	spin_lock_init(&private->lock);
-	init_timer(&private->timer);
-	private->timer.data = (unsigned long)private;
-	private->timer.function = hid_lgff_timer;
-
-	/* Event and exit callbacks */
-	hid->ff_exit = hid_lgff_exit;
-	hid->ff_event = hid_lgff_event;
-
-	/* Start the update task */
-	private->timer.expires = RUN_AT(PERIOD);
-	add_timer(&private->timer);  /*TODO: only run the timer when at least
-				       one effect is playing */
+	ret = input_ff_register(dev, &lgff_driver);
+	if (ret)
+		return ret;
 
 	printk(KERN_INFO "Force feedback for Logitech force feedback devices by Johann Deneux <johann.deneux@it.uu.se>\n");
 
 	return 0;
 }
 
-static struct hid_report* hid_lgff_duplicate_report(struct hid_report* report)
-{
-	struct hid_report* ret;
-
-	ret = kmalloc(sizeof(struct lgff_device), GFP_KERNEL);
-	if (!ret)
-		return NULL;
-	*ret = *report;
-
-	ret->field[0] = kmalloc(sizeof(struct hid_field), GFP_KERNEL);
-	if (!ret->field[0]) {
-		kfree(ret);
-		return NULL;
-	}
-	*ret->field[0] = *report->field[0];
-
-	ret->field[0]->value = kzalloc(sizeof(s32[8]), GFP_KERNEL);
-	if (!ret->field[0]->value) {
-		kfree(ret->field[0]);
-		kfree(ret);
-		return NULL;
-	}
-
-	return ret;
-}
-
-static void hid_lgff_delete_report(struct hid_report* report)
-{
-	if (report) {
-		kfree(report->field[0]->value);
-		kfree(report->field[0]);
-		kfree(report);
-	}
-}
-
 static void hid_lgff_input_init(struct hid_device* hid)
 {
 	struct device_type* dev = devices;
@@ -259,265 +121,46 @@ static void hid_lgff_input_init(struct h
 		dev++;
 
 	for (ff = dev->ff; *ff >= 0; ff++)
-		set_bit(*ff, input_dev->ffbit);
-
-	input_dev->upload_effect = hid_lgff_upload_effect;
-	input_dev->flush = hid_lgff_flush;
+		set_bit(*ff, input_dev->ff->flags);
 
-	set_bit(EV_FF, input_dev->evbit);
-	input_dev->ff_effects_max = LGFF_EFFECTS;
 }
 
-static void hid_lgff_exit(struct hid_device* hid)
-{
-	struct lgff_device *lgff = hid->ff_private;
-
-	set_bit(DEVICE_CLOSING, lgff->flags);
-	del_timer_sync(&lgff->timer);
-
-	hid_lgff_delete_report(lgff->condition);
-	hid_lgff_delete_report(lgff->rumble);
-	hid_lgff_delete_report(lgff->constant);
-
-	kfree(lgff);
-}
-
-static int hid_lgff_event(struct hid_device *hid, struct input_dev* input,
-			  unsigned int type, unsigned int code, int value)
-{
-	struct lgff_device *lgff = hid->ff_private;
-	struct lgff_effect *effect = lgff->effects + code;
-	unsigned long flags;
-
-	if (type != EV_FF)                     return -EINVAL;
-	if (!LGFF_CHECK_OWNERSHIP(code, lgff)) return -EACCES;
-	if (value < 0)                         return -EINVAL;
-
-	spin_lock_irqsave(&lgff->lock, flags);
-
-	if (value > 0) {
-		if (test_bit(EFFECT_STARTED, effect->flags)) {
-			spin_unlock_irqrestore(&lgff->lock, flags);
-			return -EBUSY;
-		}
-		if (test_bit(EFFECT_PLAYING, effect->flags)) {
-			spin_unlock_irqrestore(&lgff->lock, flags);
-			return -EBUSY;
-		}
-
-		effect->count = value;
-
-		if (effect->effect.replay.delay) {
-			set_bit(EFFECT_STARTED, effect->flags);
-		} else {
-			set_bit(EFFECT_PLAYING, effect->flags);
-		}
-		effect->started_at = jiffies;
-	}
-	else { /* value == 0 */
-		clear_bit(EFFECT_STARTED, effect->flags);
-		clear_bit(EFFECT_PLAYING, effect->flags);
-	}
-
-	spin_unlock_irqrestore(&lgff->lock, flags);
-
-	return 0;
-
-}
-
-/* Erase all effects this process owns */
-static int hid_lgff_flush(struct input_dev *dev, struct file *file)
-{
-	struct hid_device *hid = dev->private;
-	struct lgff_device *lgff = hid->ff_private;
-	int i;
-
-	for (i=0; i<dev->ff_effects_max; ++i) {
-
-		/*NOTE: no need to lock here. The only times EFFECT_USED is
-		  modified is when effects are uploaded or when an effect is
-		  erased. But a process cannot close its dev/input/eventX fd
-		  and perform ioctls on the same fd all at the same time */
-		if ( current->pid == lgff->effects[i].owner
-		     && test_bit(EFFECT_USED, lgff->effects[i].flags)) {
-
-			if (hid_lgff_erase(dev, i))
-				warn("erase effect %d failed", i);
-		}
-
-	}
-
-	return 0;
-}
-
-static int hid_lgff_erase(struct input_dev *dev, int id)
+static int hid_lgff_play(struct input_dev *dev, struct ff_effect *effect, struct ff_effect *old)
 {
 	struct hid_device *hid = dev->private;
-	struct lgff_device *lgff = hid->ff_private;
-	unsigned long flags;
-
-	if (!LGFF_CHECK_OWNERSHIP(id, lgff)) return -EACCES;
-
-	spin_lock_irqsave(&lgff->lock, flags);
-	lgff->effects[id].flags[0] = 0;
-	spin_unlock_irqrestore(&lgff->lock, flags);
-
-	return 0;
-}
-
-static int hid_lgff_upload_effect(struct input_dev* input,
-				  struct ff_effect* effect)
-{
-	struct hid_device *hid = input->private;
-	struct lgff_device *lgff = hid->ff_private;
-	struct lgff_effect new;
-	int id;
-	unsigned long flags;
-
-	dbg("ioctl rumble");
-
-	if (!test_bit(effect->type, input->ffbit)) return -EINVAL;
-
-	spin_lock_irqsave(&lgff->lock, flags);
-
-	if (effect->id == -1) {
-		int i;
-
-		for (i=0; i<LGFF_EFFECTS && test_bit(EFFECT_USED, lgff->effects[i].flags); ++i);
-		if (i >= LGFF_EFFECTS) {
-			spin_unlock_irqrestore(&lgff->lock, flags);
-			return -ENOSPC;
-		}
-
-		effect->id = i;
-		lgff->effects[i].owner = current->pid;
-		lgff->effects[i].flags[0] = 0;
-		set_bit(EFFECT_USED, lgff->effects[i].flags);
-	}
-	else if (!LGFF_CHECK_OWNERSHIP(effect->id, lgff)) {
-		spin_unlock_irqrestore(&lgff->lock, flags);
-		return -EACCES;
-	}
-
-	id = effect->id;
-	new = lgff->effects[id];
-
-	new.effect = *effect;
-
-	if (test_bit(EFFECT_STARTED, lgff->effects[id].flags)
-	    || test_bit(EFFECT_STARTED, lgff->effects[id].flags)) {
-
-		/* Changing replay parameters is not allowed (for the time
-		   being) */
-		if (new.effect.replay.delay != lgff->effects[id].effect.replay.delay
-		    || new.effect.replay.length != lgff->effects[id].effect.replay.length) {
-			spin_unlock_irqrestore(&lgff->lock, flags);
-			return -ENOSYS;
-		}
-
-		lgff->effects[id] = new;
-
-	} else {
-		lgff->effects[id] = new;
-	}
-
-	spin_unlock_irqrestore(&lgff->lock, flags);
-	return 0;
-}
-
-static void hid_lgff_timer(unsigned long timer_data)
-{
-	struct lgff_device *lgff = (struct lgff_device*)timer_data;
-	struct hid_device *hid = lgff->hid;
-	unsigned long flags;
-	int x = 0x7f, y = 0x7f;   // Coordinates of constant effects
-	unsigned int left = 0, right = 0;   // Rumbling
-	int i;
-
-	spin_lock_irqsave(&lgff->lock, flags);
-
-	for (i=0; i<LGFF_EFFECTS; ++i) {
-		struct lgff_effect* effect = lgff->effects +i;
-
-		if (test_bit(EFFECT_PLAYING, effect->flags)) {
-
-			switch (effect->effect.type) {
-			case FF_CONSTANT: {
-				//TODO: handle envelopes
-				int degrees = effect->effect.direction * 360 >> 16;
-	/*			x += fixp_mult(fixp_sin(degrees),
-					       fixp_new16(effect->effect.u.constant.level));
-				y += fixp_mult(-fixp_cos(degrees),
-					       fixp_new16(effect->effect.u.constant.level));*/
-			}       break;
-			case FF_RUMBLE:
-				right += effect->effect.u.rumble.strong_magnitude;
-				left += effect->effect.u.rumble.weak_magnitude;
-				break;
-			};
-
-			/* One run of the effect is finished playing */
-			if (time_after(jiffies,
-					effect->started_at
-					+ effect->effect.replay.delay*HZ/1000
-					+ effect->effect.replay.length*HZ/1000)) {
-				dbg("Finished playing once %d", i);
-				if (--effect->count <= 0) {
-					dbg("Stopped %d", i);
-					clear_bit(EFFECT_PLAYING, effect->flags);
-				}
-				else {
-					dbg("Start again %d", i);
-					if (effect->effect.replay.length != 0) {
-						clear_bit(EFFECT_PLAYING, effect->flags);
-						set_bit(EFFECT_STARTED, effect->flags);
-					}
-					effect->started_at = jiffies;
-				}
-			}
-
-		} else if (test_bit(EFFECT_STARTED, lgff->effects[i].flags)) {
-			/* Check if we should start playing the effect */
-			if (time_after(jiffies,
-					lgff->effects[i].started_at
-					+ lgff->effects[i].effect.replay.delay*HZ/1000)) {
-				dbg("Now playing %d", i);
-				clear_bit(EFFECT_STARTED, lgff->effects[i].flags);
-				set_bit(EFFECT_PLAYING, lgff->effects[i].flags);
-			}
-		}
-	}
-
+	int x, y;   // Coordinates of constant effects, 0x7f = center
+	unsigned int left, right;   // Rumbling
+	struct hid_report* report = list_entry(hid->report_enum[HID_OUTPUT_REPORT].report_list.next,
+					       struct hid_report, list);
+
 #define CLAMP(x) if (x < 0) x = 0; if (x > 0xff) x = 0xff
-
-	// Clamp values
-	CLAMP(x);
-	CLAMP(y);
-	CLAMP(left);
-	CLAMP(right);
-
-#undef CLAMP
-
-	if (x != lgff->constant->field[0]->value[2]
-	    || y != lgff->constant->field[0]->value[3]) {
-		lgff->constant->field[0]->value[2] = x;
-		lgff->constant->field[0]->value[3] = y;
+	switch (effect->type) {
+	case FF_CONSTANT:
+		x = effect->u.ramp.start_level + 0x7f;
+		y = effect->u.ramp.end_level + 0x7f;
+		CLAMP(x);
+		CLAMP(y);
+		report->field[0]->value[0] = 0x51;
+		report->field[0]->value[1] = 0x08;
+		report->field[0]->value[2] = x;
+		report->field[0]->value[3] = y;
 		dbg("(x,y)=(%04x, %04x)", x, y);
-		hid_submit_report(hid, lgff->constant, USB_DIR_OUT);
-	}
-
-	if (left != lgff->rumble->field[0]->value[2]
-	    || right != lgff->rumble->field[0]->value[3]) {
-		lgff->rumble->field[0]->value[2] = left;
-		lgff->rumble->field[0]->value[3] = right;
+		hid_submit_report(hid, report, USB_DIR_OUT);
+		break;
+	case FF_RUMBLE:
+		right = effect->u.rumble.strong_magnitude;
+		left = effect->u.rumble.weak_magnitude;
+		right = right * 0xff / 0xffff;
+		left = left * 0xff / 0xffff;
+		CLAMP(left);
+		CLAMP(right);
+		report->field[0]->value[0] = 0x42;
+		report->field[0]->value[1] = 0x00;
+		report->field[0]->value[2] = left;
+		report->field[0]->value[3] = right;
 		dbg("(left,right)=(%04x, %04x)", left, right);
-		hid_submit_report(hid, lgff->rumble, USB_DIR_OUT);
-	}
-
-	if (!test_bit(DEVICE_CLOSING, lgff->flags)) {
-		lgff->timer.expires = RUN_AT(PERIOD);
-		add_timer(&lgff->timer);
+		hid_submit_report(hid, report, USB_DIR_OUT);
+		break;
 	}
-
-	spin_unlock_irqrestore(&lgff->lock, flags);
+	return 0;
 }
Index: linux-2.6.17-rc4-git1/drivers/usb/input/hid-tmff.c
===================================================================
--- linux-2.6.17-rc4-git1.orig/drivers/usb/input/hid-tmff.c	2006-05-13 19:58:57.000000000 +0300
+++ linux-2.6.17-rc4-git1/drivers/usb/input/hid-tmff.c	2006-05-14 00:14:44.000000000 +0300
@@ -28,83 +28,28 @@
  */
 
 #include <linux/input.h>
-#include <linux/sched.h>
 
 #undef DEBUG
 #include <linux/usb.h>
 
-#include <linux/circ_buf.h>
-
 #include "hid.h"
-#include "fixp-arith.h"
 
 /* Usages for thrustmaster devices I know about */
 #define THRUSTMASTER_USAGE_RUMBLE_LR	(HID_UP_GENDESK | 0xbb)
-#define DELAY_CALC(t,delay)		((t) + (delay)*HZ/1000)
-
-/* Effect status */
-#define EFFECT_STARTED 0	/* Effect is going to play after some time */
-#define EFFECT_PLAYING 1	/* Effect is playing */
-#define EFFECT_USED    2
-
-/* For tmff_device::flags */
-#define DEVICE_CLOSING 0	/* The driver is being unitialised */
-
-/* Check that the current process can access an effect */
-#define CHECK_OWNERSHIP(effect) (current->pid == 0 \
-        || effect.owner == current->pid)
-
-#define TMFF_CHECK_ID(id)	((id) >= 0 && (id) < TMFF_EFFECTS)
-
-#define TMFF_CHECK_OWNERSHIP(i, l) \
-        (test_bit(EFFECT_USED, l->effects[i].flags) \
-        && CHECK_OWNERSHIP(l->effects[i]))
-
-#define TMFF_EFFECTS 8
-
-struct tmff_effect {
-	pid_t owner;
 
-	struct ff_effect effect;
-
-	unsigned long flags[1];
-	unsigned int count;             /* Number of times left to play */
-
-	unsigned long play_at;          /* When the effect starts to play */
-	unsigned long stop_at;		/* When the effect ends */
-};
 
 struct tmff_device {
-	struct hid_device *hid;
-
 	struct hid_report *report;
-
 	struct hid_field *rumble;
-
-	unsigned int effects_playing;
-	struct tmff_effect effects[TMFF_EFFECTS];
-	spinlock_t lock;             /* device-level lock. Having locks on
-					a per-effect basis could be nice, but
-					isn't really necessary */
-
-	unsigned long flags[1];      /* Contains various information about the
-					state of the driver for this device */
-
-	struct timer_list timer;
 };
 
 /* Callbacks */
 static void hid_tmff_exit(struct hid_device *hid);
-static int hid_tmff_event(struct hid_device *hid, struct input_dev *input,
-			  unsigned int type, unsigned int code, int value);
-static int hid_tmff_flush(struct input_dev *input, struct file *file);
-static int hid_tmff_upload_effect(struct input_dev *input,
-				  struct ff_effect *effect);
-static int hid_tmff_erase(struct input_dev *input, int id);
-
-/* Local functions */
-static void hid_tmff_recalculate_timer(struct tmff_device *tmff);
-static void hid_tmff_timer(unsigned long timer_data);
+static int hid_tmff_play(struct input_dev *dev, struct ff_effect *effect, struct ff_effect *old);
+
+static struct ff_driver tmff_driver = {
+	.upload = hid_tmff_play,
+};
 
 int hid_tmff_init(struct hid_device *hid)
 {
@@ -112,11 +57,18 @@ int hid_tmff_init(struct hid_device *hid
 	struct list_head *pos;
 	struct hid_input *hidinput = list_entry(hid->inputs.next, struct hid_input, list);
 	struct input_dev *input_dev = hidinput->input;
+	int ret;
 
 	private = kzalloc(sizeof(struct tmff_device), GFP_KERNEL);
 	if (!private)
 		return -ENOMEM;
 
+	ret = input_ff_allocate(input_dev);
+	if (ret) {
+		kfree(private);
+		return ret;
+	}
+
 	hid->ff_private = private;
 
 	/* Find the report to use */
@@ -155,33 +107,24 @@ int hid_tmff_init(struct hid_device *hid
 					private->report = report;
 					private->rumble = field;
 
-					set_bit(FF_RUMBLE, input_dev->ffbit);
+					set_bit(FF_RUMBLE, input_dev->ff->flags);
 					break;
 
 				default:
 					warn("ignoring unknown output usage %08x", field->usage[0].hid);
 					continue;
 			}
-
-			/* Fallthrough to here only when a valid usage is found */
-			input_dev->upload_effect = hid_tmff_upload_effect;
-			input_dev->flush = hid_tmff_flush;
-
-			set_bit(EV_FF, input_dev->evbit);
-			input_dev->ff_effects_max = TMFF_EFFECTS;
 		}
 	}
 
-	private->hid = hid;
-
-	spin_lock_init(&private->lock);
-	init_timer(&private->timer);
-	private->timer.data = (unsigned long)private;
-	private->timer.function = hid_tmff_timer;
+	ret = input_ff_register(input_dev, &tmff_driver);
+	if (ret) {
+		kfree(private);
+		return ret;
+	}
 
-	/* Event and exit callbacks */
+	/* Exit callback */
 	hid->ff_exit = hid_tmff_exit;
-	hid->ff_event = hid_tmff_event;
 
 	info("Force feedback for ThrustMaster rumble pad devices by Zinx Verituse <zinx@epicsol.org>");
 
@@ -191,196 +134,10 @@ int hid_tmff_init(struct hid_device *hid
 static void hid_tmff_exit(struct hid_device *hid)
 {
 	struct tmff_device *tmff = hid->ff_private;
-	unsigned long flags;
-
-	spin_lock_irqsave(&tmff->lock, flags);
-
-	set_bit(DEVICE_CLOSING, tmff->flags);
-	del_timer_sync(&tmff->timer);
-
-	spin_unlock_irqrestore(&tmff->lock, flags);
 
 	kfree(tmff);
 }
 
-static int hid_tmff_event(struct hid_device *hid, struct input_dev *input,
-			  unsigned int type, unsigned int code, int value)
-{
-	struct tmff_device *tmff = hid->ff_private;
-	struct tmff_effect *effect = &tmff->effects[code];
-	unsigned long flags;
-
-	if (type != EV_FF)
-		return -EINVAL;
-	if (!TMFF_CHECK_ID(code))
-		return -EINVAL;
-	if (!TMFF_CHECK_OWNERSHIP(code, tmff))
-		return -EACCES;
-	if (value < 0)
-		return -EINVAL;
-
-	spin_lock_irqsave(&tmff->lock, flags);
-
-	if (value > 0) {
-		set_bit(EFFECT_STARTED, effect->flags);
-		clear_bit(EFFECT_PLAYING, effect->flags);
-		effect->count = value;
-		effect->play_at = DELAY_CALC(jiffies, effect->effect.replay.delay);
-	} else {
-		clear_bit(EFFECT_STARTED, effect->flags);
-		clear_bit(EFFECT_PLAYING, effect->flags);
-	}
-
-	hid_tmff_recalculate_timer(tmff);
-
-	spin_unlock_irqrestore(&tmff->lock, flags);
-
-	return 0;
-
-}
-
-/* Erase all effects this process owns */
-
-static int hid_tmff_flush(struct input_dev *dev, struct file *file)
-{
-	struct hid_device *hid = dev->private;
-	struct tmff_device *tmff = hid->ff_private;
-	int i;
-
-	for (i=0; i<dev->ff_effects_max; ++i)
-
-	     /* NOTE: no need to lock here. The only times EFFECT_USED is
-		modified is when effects are uploaded or when an effect is
-		erased. But a process cannot close its dev/input/eventX fd
-		and perform ioctls on the same fd all at the same time */
-
-		if (current->pid == tmff->effects[i].owner
-		     && test_bit(EFFECT_USED, tmff->effects[i].flags))
-			if (hid_tmff_erase(dev, i))
-				warn("erase effect %d failed", i);
-
-
-	return 0;
-}
-
-static int hid_tmff_erase(struct input_dev *dev, int id)
-{
-	struct hid_device *hid = dev->private;
-	struct tmff_device *tmff = hid->ff_private;
-	unsigned long flags;
-
-	if (!TMFF_CHECK_ID(id))
-		return -EINVAL;
-	if (!TMFF_CHECK_OWNERSHIP(id, tmff))
-		return -EACCES;
-
-	spin_lock_irqsave(&tmff->lock, flags);
-
-	tmff->effects[id].flags[0] = 0;
-	hid_tmff_recalculate_timer(tmff);
-
-	spin_unlock_irqrestore(&tmff->lock, flags);
-
-	return 0;
-}
-
-static int hid_tmff_upload_effect(struct input_dev *input,
-				  struct ff_effect *effect)
-{
-	struct hid_device *hid = input->private;
-	struct tmff_device *tmff = hid->ff_private;
-	int id;
-	unsigned long flags;
-
-	if (!test_bit(effect->type, input->ffbit))
-		return -EINVAL;
-	if (effect->id != -1 && !TMFF_CHECK_ID(effect->id))
-		return -EINVAL;
-
-	spin_lock_irqsave(&tmff->lock, flags);
-
-	if (effect->id == -1) {
-		/* Find a free effect */
-		for (id = 0; id < TMFF_EFFECTS && test_bit(EFFECT_USED, tmff->effects[id].flags); ++id);
-
-		if (id >= TMFF_EFFECTS) {
-			spin_unlock_irqrestore(&tmff->lock, flags);
-			return -ENOSPC;
-		}
-
-		effect->id = id;
-		tmff->effects[id].owner = current->pid;
-		tmff->effects[id].flags[0] = 0;
-		set_bit(EFFECT_USED, tmff->effects[id].flags);
-
-	} else {
-		/* Re-uploading an owned effect, to change parameters */
-		id = effect->id;
-		clear_bit(EFFECT_PLAYING, tmff->effects[id].flags);
-	}
-
-	tmff->effects[id].effect = *effect;
-
-	hid_tmff_recalculate_timer(tmff);
-
-	spin_unlock_irqrestore(&tmff->lock, flags);
-	return 0;
-}
-
-/* Start the timer for the next start/stop/delay */
-/* Always call this while tmff->lock is locked */
-
-static void hid_tmff_recalculate_timer(struct tmff_device *tmff)
-{
-	int i;
-	int events = 0;
-	unsigned long next_time;
-
-	next_time = 0;	/* Shut up compiler's incorrect warning */
-
-	/* Find the next change in an effect's status */
-	for (i = 0; i < TMFF_EFFECTS; ++i) {
-		struct tmff_effect *effect = &tmff->effects[i];
-		unsigned long play_time;
-
-		if (!test_bit(EFFECT_STARTED, effect->flags))
-			continue;
-
-		effect->stop_at = DELAY_CALC(effect->play_at, effect->effect.replay.length);
-
-		if (!test_bit(EFFECT_PLAYING, effect->flags))
-			play_time = effect->play_at;
-		else
-			play_time = effect->stop_at;
-
-		events++;
-
-		if (time_after(jiffies, play_time))
-			play_time = jiffies;
-
-		if (events == 1)
-			next_time = play_time;
-		else {
-			if (time_after(next_time, play_time))
-				next_time = play_time;
-		}
-	}
-
-	if (!events && tmff->effects_playing) {
-		/* Treat all effects turning off as an event */
-		events = 1;
-		next_time = jiffies;
-	}
-
-	if (!events) {
-		/* No events, no time, no need for a timer. */
-		del_timer_sync(&tmff->timer);
-		return;
-	}
-
-	mod_timer(&tmff->timer, next_time);
-}
-
 /* Changes values from 0 to 0xffff into values from minimum to maximum */
 static inline int hid_tmff_scale(unsigned int in, int minimum, int maximum)
 {
@@ -394,70 +151,20 @@ static inline int hid_tmff_scale(unsigne
 	return ret;
 }
 
-static void hid_tmff_timer(unsigned long timer_data)
+static int hid_tmff_play(struct input_dev *dev, struct ff_effect *effect, struct ff_effect *old)
 {
-	struct tmff_device *tmff = (struct tmff_device *) timer_data;
-	struct hid_device *hid = tmff->hid;
-	unsigned long flags;
-	int left = 0, right = 0;	/* Rumbling */
-	int i;
-
-	spin_lock_irqsave(&tmff->lock, flags);
-
-	tmff->effects_playing = 0;
-
-	for (i = 0; i < TMFF_EFFECTS; ++i) {
-		struct tmff_effect *effect = &tmff->effects[i];
-
-		if (!test_bit(EFFECT_STARTED, effect->flags))
-			continue;
-
-		if (!time_after(jiffies, effect->play_at))
-			continue;
-
-		if (time_after(jiffies, effect->stop_at)) {
-
-			dbg("Finished playing once %d", i);
-			clear_bit(EFFECT_PLAYING, effect->flags);
-
-			if (--effect->count <= 0) {
-				dbg("Stopped %d", i);
-				clear_bit(EFFECT_STARTED, effect->flags);
-				continue;
-			} else {
-				dbg("Start again %d", i);
-				effect->play_at = DELAY_CALC(jiffies, effect->effect.replay.delay);
-				continue;
-			}
-		}
-
-		++tmff->effects_playing;
-
-		set_bit(EFFECT_PLAYING, effect->flags);
-
-		switch (effect->effect.type) {
-			case FF_RUMBLE:
-				right += effect->effect.u.rumble.strong_magnitude;
-				left += effect->effect.u.rumble.weak_magnitude;
-				break;
-			default:
-				BUG();
-				break;
-		}
-	}
+	struct hid_device *hid = dev->private;
+	struct tmff_device *tmff = hid->ff_private;
+	int left, right;	/* Rumbling */
+	right = effect->u.rumble.strong_magnitude;
+	left = effect->u.rumble.weak_magnitude;
 
 	left = hid_tmff_scale(left, tmff->rumble->logical_minimum, tmff->rumble->logical_maximum);
 	right = hid_tmff_scale(right, tmff->rumble->logical_minimum, tmff->rumble->logical_maximum);
 
-	if (left != tmff->rumble->value[0] || right != tmff->rumble->value[1]) {
-		tmff->rumble->value[0] = left;
-		tmff->rumble->value[1] = right;
-		dbg("(left,right)=(%08x, %08x)", left, right);
-		hid_submit_report(hid, tmff->report, USB_DIR_OUT);
-	}
-
-	if (!test_bit(DEVICE_CLOSING, tmff->flags))
-		hid_tmff_recalculate_timer(tmff);
-
-	spin_unlock_irqrestore(&tmff->lock, flags);
+	tmff->rumble->value[0] = left;
+	tmff->rumble->value[1] = right;
+	dbg("(left,right)=(%08x, %08x)", left, right);
+	hid_submit_report(hid, tmff->report, USB_DIR_OUT);
+	return 0;
 }
Index: linux-2.6.17-rc4-git1/drivers/usb/input/Kconfig
===================================================================
--- linux-2.6.17-rc4-git1.orig/drivers/usb/input/Kconfig	2006-05-13 19:58:57.000000000 +0300
+++ linux-2.6.17-rc4-git1/drivers/usb/input/Kconfig	2006-05-14 01:36:21.000000000 +0300
@@ -49,7 +49,7 @@ config USB_HIDINPUT_POWERBOOK
 
 config HID_FF
 	bool "Force feedback support (EXPERIMENTAL)"
-	depends on USB_HIDINPUT && EXPERIMENTAL
+	depends on USB_HIDINPUT && EXPERIMENTAL && INPUT_FF_EFFECTS
 	help
 	  Say Y here is you want force feedback support for a few HID devices.
 	  See below for a list of supported devices.

--
Anssi Hannula
