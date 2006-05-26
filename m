Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751063AbWEZQab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751063AbWEZQab (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 12:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750949AbWEZQaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 12:30:12 -0400
Received: from pne-smtpout4-sn2.hy.skanova.net ([81.228.8.154]:63908 "EHLO
	pne-smtpout4-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1751075AbWEZQaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 12:30:02 -0400
Message-Id: <20060526162903.196531000@gmail.com>
References: <20060526161129.557416000@gmail.com>
User-Agent: quilt/0.44-1
Date: Fri, 26 May 2006 19:11:33 +0300
From: Anssi Hannula <anssi.hannula@gmail.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-joystick@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [patch 04/13] input: new force feedback interface
Content-Disposition: inline; filename=ff-refactoring-new-interface.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Implement a new force feedback interface, in which all non-driver-specific
operations are separated to to the input module. This includes handling effect
type validations, effect timers, locking, etc.

As a result, support is added for gain and envelope for memoryless devices,
periodic => rumble conversion for memoryless devices and rumble => periodic
conversion for devices with periodic support instead of rumble support. Also
the effect memory of devices is not emptied if the root user opens and closes
the device while another user is using effects. This module also obsoletes
some flawed locking and timer code in few ff drivers.

The effects are now file descriptor specific instead of the previous strange
half-process half-fd specific behaviour. This is a minor change and most
likely no force feedback aware programs are affected by this negatively.

Otherwise the userspace interface is left unaltered.

The code will be built into the input module.

Signed-off-by: Anssi Hannula <anssi.hannula@gmail.com>

---
 drivers/input/Kconfig      |    5 
 drivers/input/Makefile     |    3 
 drivers/input/evdev.c      |   30 -
 drivers/input/input-core.c |   15 
 drivers/input/input-ff.c   |  889 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/input/input-ff.h   |   34 +
 include/linux/input.h      |   61 +++
 7 files changed, 1019 insertions(+), 18 deletions(-)

Index: linux-2.6.17-rc4-git12/drivers/input/Kconfig
===================================================================
--- linux-2.6.17-rc4-git12.orig/drivers/input/Kconfig	2006-05-26 16:53:01.000000000 +0300
+++ linux-2.6.17-rc4-git12/drivers/input/Kconfig	2006-05-26 16:55:12.000000000 +0300
@@ -24,6 +24,11 @@ config INPUT
 
 if INPUT
 
+config INPUT_FF_EFFECTS
+	bool "Force feedback effects"
+	help
+	  Say Y here if you want to be able to play force feedback effects.
+
 comment "Userland interfaces"
 
 config INPUT_MOUSEDEV
Index: linux-2.6.17-rc4-git12/drivers/input/Makefile
===================================================================
--- linux-2.6.17-rc4-git12.orig/drivers/input/Makefile	2006-05-26 16:55:12.000000000 +0300
+++ linux-2.6.17-rc4-git12/drivers/input/Makefile	2006-05-26 16:55:12.000000000 +0300
@@ -5,6 +5,9 @@
 # Each configuration option enables a list of files.
 
 input-objs			:= input-core.o
+ifeq ($(CONFIG_INPUT_FF_EFFECTS),y)
+	input-objs		+= input-ff.o
+endif
 
 obj-$(CONFIG_INPUT)		+= input.o
 obj-$(CONFIG_INPUT_MOUSEDEV)	+= mousedev.o
Index: linux-2.6.17-rc4-git12/include/linux/input.h
===================================================================
--- linux-2.6.17-rc4-git12.orig/include/linux/input.h	2006-05-26 16:53:01.000000000 +0300
+++ linux-2.6.17-rc4-git12/include/linux/input.h	2006-05-26 18:55:12.000000000 +0300
@@ -865,6 +865,9 @@ struct input_dev {
 	unsigned long sndbit[NBITS(SND_MAX)];
 	unsigned long ffbit[NBITS(FF_MAX)];
 	unsigned long swbit[NBITS(SW_MAX)];
+
+	struct ff_device *ff;
+	struct mutex ff_lock;
 	int ff_effects_max;
 
 	unsigned int keycodemax;
@@ -1000,6 +1003,64 @@ struct input_handle {
 #define to_handle(n) container_of(n,struct input_handle,d_node)
 #define to_handle_h(n) container_of(n,struct input_handle,h_node)
 
+#define FF_EFFECTS_MAX 64 /* maximum number of effects handled */
+
+struct ff_driver {
+	/* In case of devices with effect memory, upload() is called with the
+	   effect to be uploaded into the device. old is the effect this
+	   new effect replaces, otherwise NULL.
+	   In case of memoryless devices, upload() is called with the effect
+	   to be played back by the device. In case of memoryless devices,
+	   upload() is called in atomic context. All other handlers are never
+	   called in atomic context. */
+	int (*upload)(struct input_dev *dev, struct ff_effect *effect,
+		      struct ff_effect *old);
+	int (*erase)(struct input_dev *dev, int effect_id);
+	/* Controls the playback on devices with effect memory */
+	int (*playback)(struct input_dev *dev, int effect_id, int value);
+	void (*set_gain)(struct input_dev *dev, u16 gain);
+	void (*set_autocenter)(struct input_dev *dev, u16 magnitude);
+};
+
+#define FF_EFFECT_USED		0
+#define FF_EFFECT_STARTED	1
+#define FF_EFFECT_PLAYING	2
+
+struct ff_effect_status {
+	struct file *owner;
+	struct ff_effect effect;
+	unsigned long flags[1]; /* effect state (USED, STARTED, PLAYING) */
+	/* for memoryless devices: */
+	int count; /* loop count of the effect */
+	unsigned long play_at; /* start time */
+	unsigned long stop_at; /* stop time */
+	unsigned long adj_at; /* last time the effect was sent */
+};
+
+struct ff_device {
+	/* flags has the same values as ffbit, but the capabilities declared
+	   here are really implemented by the driver, not by conversion etc */
+	unsigned long flags[NBITS(FF_MAX)];
+	u16 gain; /* the gain of memoryless device */
+	spinlock_t atomiclock; /* atomic lock for the memoryless devices */
+	struct ff_driver *driver;
+	struct timer_list timer;
+	struct ff_effect_status effects[FF_EFFECTS_MAX];
+};
+
+#ifdef CONFIG_INPUT_FF_EFFECTS
+int input_ff_allocate(struct input_dev *dev);
+int input_ff_register(struct input_dev *dev, struct ff_driver *driver);
+int input_ff_upload(struct input_dev *dev, struct ff_effect *effect, struct file *file);
+int input_ff_erase(struct input_dev *dev, int effect_id, struct file *file);
+#else
+static inline int input_ff_allocate(struct input_dev *dev) { return -EPERM; }
+static inline int input_ff_register(struct input_dev *dev, struct ff_driver *driver) { return -EPERM; }
+static inline int input_ff_upload(struct input_dev *dev, struct ff_effect *effect, struct file *file) { return -EINVAL; }
+static inline int input_ff_erase(struct input_dev *dev, int effect_id, struct file *file) { return -EINVAL; }
+#endif
+
+
 static inline void init_input_dev(struct input_dev *dev)
 {
 	INIT_LIST_HEAD(&dev->h_list);
Index: linux-2.6.17-rc4-git12/drivers/input/input-core.c
===================================================================
--- linux-2.6.17-rc4-git12.orig/drivers/input/input-core.c	2006-05-26 16:55:12.000000000 +0300
+++ linux-2.6.17-rc4-git12/drivers/input/input-core.c	2006-05-26 18:55:29.000000000 +0300
@@ -23,6 +23,7 @@
 #include <linux/poll.h>
 #include <linux/device.h>
 #include <linux/mutex.h>
+#include "input-ff.h"
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
 MODULE_DESCRIPTION("Input core");
@@ -172,7 +173,7 @@ void input_event(struct input_dev *dev, 
 			break;
 
 		case EV_FF:
-			if (dev->event) dev->event(dev, type, code, value);
+			input_ff_event(dev, type, code, value);
 			break;
 	}
 
@@ -733,6 +734,17 @@ static void input_dev_release(struct cla
 {
 	struct input_dev *dev = to_input_dev(class_dev);
 
+	if (dev->ff) {
+		struct ff_device *ff = dev->ff;
+		clear_bit(EV_FF, dev->evbit);
+		mutex_lock(&dev->ff_lock);
+		del_timer_sync(&ff->timer);
+		dev->flush = NULL;
+		dev->ff = NULL;
+		mutex_unlock(&dev->ff_lock);
+		kfree(ff);
+	}
+
 	kfree(dev);
 	module_put(THIS_MODULE);
 }
@@ -874,6 +886,7 @@ struct input_dev *input_allocate_device(
 		class_device_initialize(&dev->cdev);
 		INIT_LIST_HEAD(&dev->h_list);
 		INIT_LIST_HEAD(&dev->node);
+		mutex_init(&dev->ff_lock);
 	}
 
 	return dev;
Index: linux-2.6.17-rc4-git12/drivers/input/evdev.c
===================================================================
--- linux-2.6.17-rc4-git12.orig/drivers/input/evdev.c	2006-05-26 16:53:01.000000000 +0300
+++ linux-2.6.17-rc4-git12/drivers/input/evdev.c	2006-05-26 18:56:55.000000000 +0300
@@ -457,25 +457,21 @@ static long evdev_ioctl_handler(struct f
 
 			return 0;
 
-		case EVIOCSFF:
-			if (dev->upload_effect) {
-				struct ff_effect effect;
-				int err;
-
-				if (copy_from_user(&effect, p, sizeof(effect)))
-					return -EFAULT;
-				err = dev->upload_effect(dev, &effect);
-				if (put_user(effect.id, &(((struct ff_effect __user *)p)->id)))
-					return -EFAULT;
-				return err;
-			} else
-				return -ENOSYS;
+		case EVIOCSFF: {
+			struct ff_effect effect;
+			int err;
 
-		case EVIOCRMFF:
-			if (!dev->erase_effect)
-				return -ENOSYS;
+			if (copy_from_user(&effect, p, sizeof(effect)))
+				return -EFAULT;
+			err = input_ff_upload(dev, &effect, file);
+			if (put_user(effect.id, &(((struct ff_effect __user *)p)->id)))
+				return -EFAULT;
+			return err;
+		}
 
-			return dev->erase_effect(dev, (int)(unsigned long) p);
+		case EVIOCRMFF:
+			return input_ff_erase(dev, (int)(unsigned long) p,
+					      file);
 
 		case EVIOCGEFFECTS:
 			if (put_user(dev->ff_effects_max, ip))
Index: linux-2.6.17-rc4-git12/drivers/input/input-ff.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.17-rc4-git12/drivers/input/input-ff.c	2006-05-26 19:01:49.000000000 +0300
@@ -0,0 +1,889 @@
+/*
+ *  Force feedback support for Linux input subsystem
+ *
+ *  Copyright (c) 2006 Anssi Hannula <anssi.hannula@gmail.com>
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
+ */
+
+/* #define DEBUG */
+
+#define debug(format, arg...) pr_debug("input-ff: " format "\n", ## arg)
+
+#include <linux/input.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/spinlock.h>
+#include <linux/sched.h>
+
+#include "fixp-arith.h"
+
+/* Number of effects handled with memoryless devices */
+#define FF_MEMLESS_EFFECTS	16
+
+/* Envelope update interval in ms */
+#define FF_ENVELOPE_INTERVAL	50
+
+EXPORT_SYMBOL_GPL(input_ff_allocate);
+EXPORT_SYMBOL_GPL(input_ff_register);
+EXPORT_SYMBOL_GPL(input_ff_upload);
+EXPORT_SYMBOL_GPL(input_ff_erase);
+
+/**
+ * Lock the mutex and check the device has not been deleted
+ */
+static inline int input_ff_safe_lock(struct input_dev *dev)
+{
+	mutex_lock(&dev->ff_lock);
+	if (dev->ff)
+		return 0;
+
+	mutex_unlock(&dev->ff_lock);
+	return 1;
+}
+
+/**
+ * Check that the effect_id is a valid effect and the user has access to it
+ */
+static inline int input_ff_effect_access(struct input_dev *dev, int effect_id,
+					 struct file *file)
+{
+	struct ff_device *ff = dev->ff;
+
+	if (effect_id >= dev->ff_effects_max || effect_id < 0
+	    || !test_bit(FF_EFFECT_USED, ff->effects[effect_id].flags))
+		return -EINVAL;
+
+	if (ff->effects[effect_id].owner != file)
+		return -EACCES;
+
+	return 0;
+}
+
+/**
+ * Check for the next time envelope requires an update on memoryless devices
+ * @event_time: Time of the next update
+ *
+ * If an event is found before @event_time, @event_time is changed and the
+ * functions returns 1. Otherwise it returns 0.
+ */
+static int input_ff_envelope_time(struct ff_effect_status *effect,
+				  struct ff_envelope *envelope,
+				  unsigned long *event_time)
+{
+	unsigned long fade_start;
+	if (!envelope)
+		return 0;
+
+	if (envelope->attack_length
+	    && time_after(effect->play_at +
+			  msecs_to_jiffies(envelope->attack_length),
+			  effect->adj_at)) {
+		*event_time =
+		    effect->adj_at + msecs_to_jiffies(FF_ENVELOPE_INTERVAL);
+		return 1;
+	}
+
+	if (!envelope->fade_length || !effect->effect.replay.length)
+		return 0;
+
+	fade_start = effect->stop_at - msecs_to_jiffies(envelope->fade_length);
+
+	if (time_after(fade_start, effect->adj_at)) {
+		*event_time = fade_start;
+		return 1;
+	}
+
+	*event_time = effect->adj_at + msecs_to_jiffies(FF_ENVELOPE_INTERVAL);
+	if (time_after(*event_time, effect->stop_at))
+		*event_time = effect->stop_at;
+
+	return 1;
+}
+
+/**
+ * Calculate the next time effect requires an update on memoryless devices
+ * @ff: The device
+ *
+ * Runs through the effects and updates the timer if necessary. This function
+ * should be called only when the spinlock is locked.
+ */
+static void input_ff_calc_timer(struct ff_device *ff)
+{
+	int i;
+	int events = 0;
+	unsigned long next_time = 0;
+	debug("calculating next timer");
+	for (i = 0; i < FF_MEMLESS_EFFECTS; ++i) {
+		unsigned long event_time;
+		struct ff_envelope *envelope = NULL;
+		int event_set = 0;
+
+		if (!test_bit(FF_EFFECT_STARTED, ff->effects[i].flags)) {
+			if (test_bit(FF_EFFECT_PLAYING, ff->effects[i].flags)) {
+				event_time = ff->effects[i].stop_at = jiffies;
+				event_set = 1;
+			} else
+				continue;
+		} else {
+			if (!test_bit(FF_EFFECT_PLAYING, ff->effects[i].flags)) {
+				event_time = ff->effects[i].play_at;
+				event_set = 1;
+			} else {
+				if (ff->effects[i].effect.type == FF_PERIODIC)
+					envelope =
+					    &ff->effects[i].effect.u.periodic.
+					    envelope;
+				else if (ff->effects[i].effect.type ==
+					 FF_CONSTANT)
+					envelope =
+					    &ff->effects[i].effect.u.constant.
+					    envelope;
+
+				event_set =
+				    input_ff_envelope_time(&ff->effects[i],
+							   envelope,
+							   &event_time);
+				if (!event_set
+				    && ff->effects[i].effect.replay.length) {
+					event_time = ff->effects[i].stop_at;
+					event_set = 1;
+				}
+			}
+		}
+
+		if (!event_set)
+			continue;
+		events++;
+
+		if (time_after(jiffies, event_time)) {
+			event_time = jiffies;
+			break;
+		}
+		if (events == 1)
+			next_time = event_time;
+		else {
+			if (time_after(next_time, event_time))
+				next_time = event_time;
+		}
+	}
+	if (!events) {
+		debug("no actions");
+		del_timer(&ff->timer);
+	} else {
+		debug("timer set");
+		mod_timer(&ff->timer, next_time);
+	}
+}
+
+/**
+ * abs() with -0x8000 => 0x7fff exception
+ */
+static inline u16 input_ff_unsign(s16 value)
+{
+	if (value == -0x8000)
+		return 0x7fff;
+
+	return (value < 0 ? -value : value);
+}
+
+/**
+ * Apply an envelope to a value
+ */
+static int input_ff_envelope(struct ff_effect_status *effect, int value,
+			     struct ff_envelope *envelope)
+{
+	unsigned long current_time = jiffies;
+	unsigned int time_from_level;
+	unsigned int time_of_envelope;
+	unsigned int envelope_level;
+	int difference;
+
+	if (envelope->attack_length
+	    && time_after(effect->play_at +
+			  msecs_to_jiffies(envelope->attack_length),
+			  current_time)) {
+		debug("value = 0x%x, attack_level = 0x%x", value,
+		      envelope->attack_level);
+		time_from_level = current_time - effect->play_at;
+		time_of_envelope = msecs_to_jiffies(envelope->attack_length);
+		envelope_level =
+		    envelope->attack_level >
+		    0x7fff ? 0x7fff : envelope->attack_level;
+	} else if (envelope->fade_length && effect->effect.replay.length
+		   && time_after(current_time,
+				 effect->stop_at -
+				 msecs_to_jiffies(envelope->fade_length))
+		   && time_after(effect->stop_at, current_time)) {
+		time_from_level = effect->stop_at - current_time;
+		time_of_envelope = msecs_to_jiffies(envelope->fade_length);
+		envelope_level =
+		    envelope->fade_level >
+		    0x7fff ? 0x7fff : envelope->fade_level;
+	} else {
+		return value;
+	}
+
+	difference = abs(value) - envelope_level;
+
+	debug("difference = %d", difference);
+	debug("time_from_level = 0x%x", time_from_level);
+	debug("time_of_envelope = 0x%x", time_of_envelope);
+	if (difference < 0)
+		difference =
+		    -((-difference) * time_from_level / time_of_envelope);
+	else
+		difference = difference * time_from_level / time_of_envelope;
+
+	debug("difference = %d", difference);
+
+	if (value < 0)
+		return -(difference + envelope_level);
+
+	return difference + envelope_level;
+}
+
+/**
+ * Return the type the effect has to be converted into (memless devices)
+ */
+static int input_ff_emu_effect_type(struct input_dev *dev, int effect_type)
+{
+
+	if (test_bit(effect_type, dev->ff->flags))
+		return effect_type;
+
+	if (effect_type == FF_PERIODIC && test_bit(FF_RUMBLE, dev->ff->flags))
+		return FF_RUMBLE;
+
+	printk(KERN_ERR
+	       "input-ff: invalid type in input_ff_emu_effect_type()\n");
+	return 0;
+}
+
+/**
+ * Safe sum
+ * @a: Integer to sum
+ * @b: Integer to sum
+ * @limit: The sum limit
+ *
+ * If @a+@b is above @limit, return @limit
+ */
+static int input_ff_safe_sum(int a, int b, int limit)
+{
+	int c;
+	if (!a)
+		return b;
+	c = a + b;
+	if (c > limit)
+		return limit;
+	return c;
+}
+
+/**
+ * Signed safe sum with range -0x80-0x7f
+ */
+static s8 input_ff_s8_sum(int a, int b)
+{
+	int c;
+	c = input_ff_safe_sum(a, b, 0x7f);
+	if (c < -0x80)
+		return -0x80;
+	return c;
+}
+
+/**
+ * Convert an effect (for devices with memory)
+ */
+static void input_ff_convert_effect(struct input_dev *dev,
+				    struct ff_effect *effect)
+{
+	int strong_magnitude, weak_magnitude;
+
+	if (effect->type == FF_RUMBLE && test_bit(FF_PERIODIC, dev->ff->flags)) {
+		/* Strong magnitude as 2/3 full and weak 1/3 full */
+		/* Also divide by 2 */
+		strong_magnitude = effect->u.rumble.strong_magnitude * 2 / 6;
+		weak_magnitude = effect->u.rumble.weak_magnitude / 6;
+
+		effect->type = FF_PERIODIC;
+
+		effect->u.periodic.waveform = FF_SINE;
+		effect->u.periodic.period = 50;
+		effect->u.periodic.magnitude =
+		    input_ff_safe_sum(strong_magnitude, weak_magnitude, 0x7fff);
+		effect->u.periodic.offset = 0;
+		effect->u.periodic.phase = 0;
+		effect->u.periodic.envelope.attack_length = 0;
+		effect->u.periodic.envelope.attack_level = 0;
+		effect->u.periodic.envelope.fade_length = 0;
+		effect->u.periodic.envelope.fade_level = 0;
+		return;
+	}
+
+	printk(KERN_ERR
+	       "input-ff: invalid effect type in convert_effect()\n");
+}
+
+/**
+ * Sum two effects and apply gain
+ * @effect: The effect that is going to be sent to the device
+ * @new: The effect that is added to @effect
+ * @gain: The gain to be applied to @new before adding
+ *
+ * Memoryless devices have only one effect per effect type active at one time,
+ * so we have to convert multiple effects to a single effect.
+ */
+static void input_ff_sum_effect(struct ff_effect *effect,
+				struct ff_effect_status *new, unsigned int gain)
+{
+	unsigned int strong, weak, i;
+	int x, y;
+	fixp_t level;
+	switch (new->effect.type) {
+	case FF_CONSTANT:
+		if (effect->type != FF_CONSTANT)
+			break;
+		i = new->effect.direction * 360 / 0xffff;
+		level =
+		    fixp_new16(input_ff_envelope
+			       (new, new->effect.u.constant.level,
+				&new->effect.u.constant.envelope));
+		x = fixp_mult(fixp_sin(i), level) * gain / 0xffff;
+		y = fixp_mult(-fixp_cos(i), level) * gain / 0xffff;
+		/* here we abuse ff_ramp to hold x and y of constant force */
+		/* If in future any driver wants something else than
+		   x and y in s8, this should be changed to something more generic */
+		effect->u.ramp.start_level =
+		    input_ff_s8_sum(effect->u.rumble.strong_magnitude, x);
+		effect->u.ramp.end_level =
+		    input_ff_s8_sum(effect->u.rumble.weak_magnitude, y);
+		return;
+	case FF_RUMBLE:
+		if (effect->type != FF_RUMBLE)
+			break;
+		strong = new->effect.u.rumble.strong_magnitude * gain / 0xffff;
+		weak = new->effect.u.rumble.weak_magnitude * gain / 0xffff;
+		effect->u.rumble.strong_magnitude =
+		    input_ff_safe_sum(effect->u.rumble.strong_magnitude, strong,
+				      0xffff);
+		effect->u.rumble.weak_magnitude =
+		    input_ff_safe_sum(effect->u.rumble.weak_magnitude, weak,
+				      0xffff);
+		return;
+	case FF_PERIODIC:
+		if (effect->type != FF_RUMBLE)
+			break;
+		/* very small period values should lessen the magnitude */
+		i = input_ff_unsign(new->effect.u.periodic.magnitude);
+		i = input_ff_envelope(new, i, &new->effect.u.periodic.envelope);
+		/* here we also scale it 0x7fff => 0xffff */
+		i = i * gain / 0x7fff;
+
+		effect->u.rumble.strong_magnitude =
+		    input_ff_safe_sum(effect->u.rumble.strong_magnitude, i,
+				      0xffff);
+		effect->u.rumble.weak_magnitude =
+		    input_ff_safe_sum(effect->u.rumble.weak_magnitude, i,
+				      0xffff);
+		return;
+	}
+
+	printk(KERN_ERR "input-ff: invalid type in input_ff_sum_effect()\n");
+}
+
+/**
+ * Send the effects to the memoryless device
+ * @timer_data: struct input_dev
+ *
+ * All effects are converted and sent to the device. This function is atomic
+ * so it cannot lock the mutex. Therefore any data structures this function
+ * uses should not be used anywhere without locking the spinlock.
+ */
+static void input_ff_timer(unsigned long timer_data)
+{
+	struct input_dev *dev = (struct input_dev *)timer_data;
+	struct ff_device *ff = dev->ff;
+	struct ff_effect effect;
+	int i;
+	unsigned long flags;
+	int effects_pending = 1;
+	DECLARE_BITMAP(effect_handled, FF_MEMLESS_EFFECTS);
+	int effect_type;
+	int safety = 0;
+
+	debug("timer: updating effects");
+
+	memset(effect_handled, 0, sizeof(effect_handled));
+	spin_lock_irqsave(&ff->atomiclock, flags);
+
+	while (effects_pending) {
+		if (safety++ > 50) {
+			printk(KERN_ERR
+			       "input-ff: update aborted to avoid deadlock\n");
+			BUG();
+			break;
+		}
+		effects_pending = 0;
+		memset(&effect, 0, sizeof(effect));
+		for (i = 0; i < dev->ff_effects_max; i++) {
+
+			if (test_bit(i, effect_handled))
+				continue;
+
+			if (!test_bit(FF_EFFECT_STARTED, ff->effects[i].flags)) {
+				if (!test_bit
+				    (FF_EFFECT_PLAYING, ff->effects[i].flags))
+					continue;
+				if (!effect.type) {
+					effect.type =
+					    input_ff_emu_effect_type(dev,
+								     ff->
+								     effects[i].
+								     effect.
+								     type);
+					__clear_bit(FF_EFFECT_PLAYING,
+						    ff->effects[i].flags);
+					__set_bit(i, effect_handled);
+					continue;
+				}
+				if (effect.type ==
+				    input_ff_emu_effect_type(dev,
+							     ff->effects[i].
+							     effect.type)) {
+					__clear_bit(FF_EFFECT_PLAYING,
+						    ff->effects[i].flags);
+					__set_bit(i, effect_handled);
+					continue;
+				}
+				debug("effects pending: case 1");
+				effects_pending = 1;
+				continue;
+			}
+
+			if (time_after(ff->effects[i].play_at, jiffies)) {
+				__set_bit(i, effect_handled);
+				continue;
+			}
+
+			effect_type =
+			    input_ff_emu_effect_type(dev,
+						     ff->effects[i].effect.
+						     type);
+
+			if (effect.type != effect_type) {
+				if (effect.type) {
+					debug("effects pending: case 2");
+					effects_pending = 1;
+					continue;
+				}
+				effect.type = effect_type;
+			}
+
+			if (ff->effects[i].effect.replay.length
+			    && time_after_eq(jiffies, ff->effects[i].stop_at)) {
+
+				__clear_bit(FF_EFFECT_PLAYING,
+					    ff->effects[i].flags);
+
+				if (--ff->effects[i].count <= 0) {
+					__clear_bit(FF_EFFECT_STARTED,
+						    ff->effects[i].flags);
+					__set_bit(i, effect_handled);
+					continue;
+				} else {
+					ff->effects[i].play_at =
+					    jiffies +
+					    msecs_to_jiffies(ff->effects[i].
+							     effect.replay.
+							     delay);
+					ff->effects[i].stop_at =
+					    dev->ff->effects[i].play_at +
+					    msecs_to_jiffies(ff->effects[i].
+							     effect.replay.
+							     length);
+					__set_bit(i, effect_handled);
+					continue;
+				}
+			}
+
+			__set_bit(FF_EFFECT_PLAYING, ff->effects[i].flags);
+
+			input_ff_sum_effect(&effect, &ff->effects[i], ff->gain);
+			ff->effects[i].adj_at = jiffies;
+			__set_bit(i, effect_handled);
+		}
+
+		ff->driver->upload(dev, &effect, NULL);
+	}
+
+	input_ff_calc_timer(ff);
+	spin_unlock_irqrestore(&ff->atomiclock, flags);
+
+}
+
+/**
+ * Erase an effect
+ * @file: The requester
+ *
+ * Erases the effect if the requester is also the effect owner. The mutex
+ * should already be locked before calling this function. If the device is a
+ * memoryless device, the spinlock will be locked.
+ */
+static int _input_ff_erase(struct input_dev *dev, int effect_id,
+			   struct file *file)
+{
+	unsigned long flags;
+	int ret = input_ff_effect_access(dev, effect_id, file);
+	if (ret)
+		return ret;
+	if (dev->ff->driver->playback) {
+		dev->ff->driver->playback(dev, effect_id, 0);
+		ret = dev->ff->driver->erase(dev, effect_id);
+		if (!ret)
+			__clear_bit(FF_EFFECT_USED,
+				    dev->ff->effects[effect_id].flags);
+	} else {
+		spin_lock_irqsave(&dev->ff->atomiclock, flags);
+		if (__test_and_clear_bit
+		    (FF_EFFECT_STARTED, dev->ff->effects[effect_id].flags))
+			input_ff_calc_timer(dev->ff);
+		spin_unlock_irqrestore(&dev->ff->atomiclock, flags);
+		__clear_bit(FF_EFFECT_USED, dev->ff->effects[effect_id].flags);
+	}
+	return ret;
+}
+
+/**
+ * Lock the mutex and call _input_ff_erase
+ */
+int input_ff_erase(struct input_dev *dev, int effect_id, struct file *file)
+{
+	struct ff_device *ff;
+	int ret;
+	if (!test_bit(EV_FF, dev->evbit))
+		return -EINVAL;
+	if (input_ff_safe_lock(dev))
+		return -ENODEV;
+	ff = dev->ff;
+
+	ret = _input_ff_erase(dev, effect_id, file);
+
+	mutex_unlock(&dev->ff_lock);
+	return ret;
+}
+
+/**
+ * Lock the mutex and call _input_ff_erase for all effects
+ */
+static int input_ff_flush(struct input_dev *dev, struct file *file)
+{
+	struct ff_device *ff;
+	int i;
+	debug("flushing now");
+	if (input_ff_safe_lock(dev))
+		return -ENODEV;
+	ff = dev->ff;
+	for (i = 0; i < dev->ff_effects_max; i++)
+		_input_ff_erase(dev, i, file);
+	mutex_unlock(&dev->ff_lock);
+	return 0;
+}
+
+/**
+ * Handle the EV_FF input event
+ */
+void input_ff_event(struct input_dev *dev, unsigned int type, unsigned int code,
+		    int value)
+{
+	struct ff_device *ff;
+	unsigned long flags;
+	int i;
+	if (value < 0)
+		return;
+
+	if (input_ff_safe_lock(dev))
+		return;
+	ff = dev->ff;
+
+	if (code == FF_GAIN) {
+		if (!test_bit(FF_GAIN, dev->ffbit) || value > 0xffff)
+			goto out;
+
+		if (ff->driver->playback) {
+			ff->driver->set_gain(dev, value);
+		} else {
+			spin_lock_irqsave(&ff->atomiclock, flags);
+			ff->gain = value;
+			for (i = 0; i < dev->ff_effects_max; i++)
+				__clear_bit(FF_EFFECT_PLAYING,
+					    ff->effects[i].flags);
+			input_ff_calc_timer(ff);
+			spin_unlock_irqrestore(&ff->atomiclock, flags);
+		}
+
+		goto out;
+	}
+
+	if (code == FF_AUTOCENTER) {
+		if (!test_bit(FF_AUTOCENTER, dev->ffbit) || value > 0xffff)
+			goto out;
+
+		if (ff->driver->playback)
+			ff->driver->set_autocenter(dev, value);
+
+		goto out;
+	}
+
+	if (ff->driver->playback) {
+		ff->driver->playback(dev, code, value);
+		goto out;
+	}
+
+	spin_lock_irqsave(&ff->atomiclock, flags);
+	if (value > 0) {
+		debug("initiated play");
+		__set_bit(FF_EFFECT_STARTED, ff->effects[code].flags);
+		__clear_bit(FF_EFFECT_PLAYING, ff->effects[code].flags);
+		ff->effects[code].count = value;
+		ff->effects[code].play_at = jiffies +
+		    msecs_to_jiffies(ff->effects[code].effect.replay.delay);
+		ff->effects[code].stop_at = ff->effects[code].play_at +
+		    msecs_to_jiffies(ff->effects[code].effect.replay.length);
+		ff->effects[code].adj_at = ff->effects[code].play_at;
+	} else {
+		debug("initiated stop");
+		__clear_bit(FF_EFFECT_STARTED, ff->effects[code].flags);
+	}
+	input_ff_calc_timer(ff);
+	spin_unlock_irqrestore(&ff->atomiclock, flags);
+
+      out:
+	mutex_unlock(&dev->ff_lock);
+	return;
+}
+
+#define VALID_EFFECT_MIN	FF_RUMBLE
+#define VALID_EFFECT_MAX	FF_RAMP
+#define VALID_WFORM_MIN		FF_SQUARE
+#define VALID_WFORM_MAX		FF_CUSTOM
+/**
+ * Check that the effect type and waveform are valid
+ */
+static int input_ff_validate_effect(struct ff_effect *effect)
+{
+	if (effect->type < VALID_EFFECT_MIN || effect->type > VALID_EFFECT_MAX)
+		return -EINVAL;
+	if (effect->type == FF_PERIODIC &&
+	    (effect->u.periodic.waveform < VALID_WFORM_MIN ||
+	     effect->u.periodic.waveform > VALID_WFORM_MAX))
+		return -EINVAL;
+	return 0;
+}
+
+/**
+ * Handle effect upload
+ */
+int input_ff_upload(struct input_dev *dev, struct ff_effect *effect,
+		    struct file *file)
+{
+	struct ff_device *ff;
+	unsigned long flags;
+	int ret = 0;
+	int id;
+
+	if (!test_bit(EV_FF, dev->evbit) || input_ff_validate_effect(effect) ||
+	    !test_bit(effect->type, dev->ffbit) ||
+	    (effect->type == FF_PERIODIC &&
+	     !test_bit(effect->u.periodic.waveform, dev->ffbit))) {
+		debug("invalid upload");
+		return -EINVAL;
+	}
+
+	if (input_ff_safe_lock(dev))
+		return -ENODEV;
+	ff = dev->ff;
+
+	if (effect->id == -1) {
+		for (id = 0;
+		     id < dev->ff_effects_max
+		     && test_bit(FF_EFFECT_USED, ff->effects[id].flags); id++) ;
+
+		if (id >= dev->ff_effects_max) {
+			mutex_unlock(&dev->ff_lock);
+			return -ENOSPC;
+		}
+
+		effect->id = id;
+		ff->effects[id].owner = file;
+		ff->effects[id].flags[0] = 0;
+		ff->effects[id].effect = *effect;
+
+		if (ff->driver->playback) {
+			if (!test_bit(effect->type, ff->flags))
+				input_ff_convert_effect(dev, effect);
+			ret = ff->driver->upload(dev, effect, NULL);
+			if (!ret)
+				__set_bit(FF_EFFECT_USED,
+					  ff->effects[id].flags);
+		} else
+			__set_bit(FF_EFFECT_USED, ff->effects[id].flags);
+
+	} else {
+		id = effect->id;
+
+		ret = input_ff_effect_access(dev, id, file);
+		if (ret) {
+			mutex_unlock(&dev->ff_lock);
+			return ret;
+		}
+
+		if (effect->type != ff->effects[id].effect.type ||
+		    (effect->type == FF_PERIODIC
+		     && effect->u.periodic.waveform !=
+		     ff->effects[id].effect.u.periodic.waveform)) {
+			mutex_unlock(&dev->ff_lock);
+			return -EINVAL;
+		}
+
+		if (ff->driver->playback) {
+			if (!test_bit(effect->type, ff->flags))
+				input_ff_convert_effect(dev, effect);
+			ret =
+			    ff->driver->upload(dev, effect,
+					       &ff->effects[id].effect);
+			ff->effects[id].effect = *effect;
+			mutex_unlock(&dev->ff_lock);
+			return ret;
+		}
+		spin_lock_irqsave(&ff->atomiclock, flags);
+		ff->effects[id].effect = *effect;
+		__clear_bit(FF_EFFECT_PLAYING, ff->effects[id].flags);
+		spin_unlock_irqrestore(&ff->atomiclock, flags);
+
+	}
+
+	mutex_unlock(&dev->ff_lock);
+	return ret;
+}
+
+/**
+ * Allocate the ff_device in dev->ff
+ */
+int input_ff_allocate(struct input_dev *dev)
+{
+	debug("allocating device");
+	mutex_lock(&dev->ff_lock);
+	WARN_ON(dev->ff);
+	dev->ff = kzalloc(sizeof(*dev->ff), GFP_KERNEL);
+	if (!dev->ff) {
+		mutex_unlock(&dev->ff_lock);
+		return -ENOMEM;
+	}
+	spin_lock_init(&dev->ff->atomiclock);
+	setup_timer(&dev->ff->timer, input_ff_timer, (unsigned long)dev);
+	mutex_unlock(&dev->ff_lock);
+	debug("ff allocated");
+	return 0;
+}
+
+/**
+ * Set the bits and handlers
+ * @driver: The ff_driver struct
+ *
+ * If possible, this function should be called before the input device is
+ * registered. It can however be ran again if the capability bits have
+ * changed.
+ */
+int input_ff_register(struct input_dev *dev, struct ff_driver *driver)
+{
+	int i;
+	debug("registering device");
+	if (!dev->ff) {
+		printk(KERN_ERR
+		       "input-ff: tried to register before allocate\n");
+		return -EPERM;
+	}
+	if (driver->playback && !dev->ff_effects_max) {
+		printk(KERN_ERR
+		       "input-ff: cannot register a device with 0 effects\n");
+		return -EINVAL;
+	}
+	mutex_lock(&dev->ff_lock);
+
+	dev->flush = input_ff_flush;
+	dev->ff->driver = driver;
+
+	for (i = 0; i <= FF_MAX; i++)
+		clear_bit(i, dev->ffbit);
+
+	if (!dev->ff->driver->playback) {
+		dev->ff_effects_max = FF_MEMLESS_EFFECTS;
+		dev->ff->gain = 0xffff;
+		set_bit(FF_GAIN, dev->ffbit);
+	}
+
+	if (test_bit(FF_RUMBLE, dev->ff->flags)) {
+		debug("device has rumble");
+		set_bit(FF_RUMBLE, dev->ffbit);
+		if (!dev->ff->driver->playback) {
+			set_bit(FF_PERIODIC, dev->ffbit);
+			set_bit(FF_SINE, dev->ffbit);
+			set_bit(FF_TRIANGLE, dev->ffbit);
+			set_bit(FF_SQUARE, dev->ffbit);
+		}
+	}
+
+	if (test_bit(FF_PERIODIC, dev->ff->flags)) {
+		set_bit(FF_PERIODIC, dev->ffbit);
+		if (dev->ff->driver->playback)
+			set_bit(FF_RUMBLE, dev->ffbit);
+	}
+
+	if (test_bit(FF_CONSTANT, dev->ff->flags))
+		set_bit(FF_CONSTANT, dev->ffbit);
+	if (test_bit(FF_SPRING, dev->ff->flags))
+		set_bit(FF_SPRING, dev->ffbit);
+	if (test_bit(FF_FRICTION, dev->ff->flags))
+		set_bit(FF_FRICTION, dev->ffbit);
+	if (test_bit(FF_DAMPER, dev->ff->flags))
+		set_bit(FF_DAMPER, dev->ffbit);
+	if (test_bit(FF_INERTIA, dev->ff->flags))
+		set_bit(FF_INERTIA, dev->ffbit);
+	if (test_bit(FF_RAMP, dev->ff->flags))
+		set_bit(FF_RAMP, dev->ffbit);
+	if (test_bit(FF_SQUARE, dev->ff->flags))
+		set_bit(FF_SQUARE, dev->ffbit);
+	if (test_bit(FF_TRIANGLE, dev->ff->flags))
+		set_bit(FF_TRIANGLE, dev->ffbit);
+	if (test_bit(FF_SINE, dev->ff->flags))
+		set_bit(FF_SINE, dev->ffbit);
+	if (test_bit(FF_SAW_UP, dev->ff->flags))
+		set_bit(FF_SAW_UP, dev->ffbit);
+	if (test_bit(FF_SAW_DOWN, dev->ff->flags))
+		set_bit(FF_SAW_DOWN, dev->ffbit);
+	if (test_bit(FF_CUSTOM, dev->ff->flags))
+		set_bit(FF_CUSTOM, dev->ffbit);
+	if (test_bit(FF_GAIN, dev->ff->flags))
+		set_bit(FF_GAIN, dev->ffbit);
+	if (test_bit(FF_AUTOCENTER, dev->ff->flags))
+		set_bit(FF_AUTOCENTER, dev->ffbit);
+
+	set_bit(EV_FF, dev->evbit);
+	mutex_unlock(&dev->ff_lock);
+
+	return 0;
+}
Index: linux-2.6.17-rc4-git12/drivers/input/input-ff.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.17-rc4-git12/drivers/input/input-ff.h	2006-05-26 16:55:12.000000000 +0300
@@ -0,0 +1,34 @@
+
+#ifndef _INPUT_FF_H
+#define _INPUT_FF_H
+
+/*
+ *  Copyright (c) 2006 Anssi Hannula <anssi.hannula@gmail.com>
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
+ */
+
+
+#ifdef CONFIG_INPUT_FF_EFFECTS
+void input_ff_event(struct input_dev *dev, unsigned int type,
+		    unsigned int code, int value);
+#else
+static inline void input_ff_event(struct input_dev *dev, unsigned int type,
+				  unsigned int code, int value) { return; }
+#endif
+
+#endif

--
Anssi Hannula
