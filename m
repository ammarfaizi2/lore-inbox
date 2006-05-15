Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965246AbWEOVRc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965246AbWEOVRc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 17:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965240AbWEOVR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 17:17:26 -0400
Received: from pne-smtpout3-sn2.hy.skanova.net ([81.228.8.111]:30421 "EHLO
	pne-smtpout3-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S965238AbWEOVQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 17:16:19 -0400
Message-Id: <20060515211506.783939000@gmail.com>
References: <20060515211229.521198000@gmail.com>
User-Agent: quilt/0.44-1
Date: Tue, 16 May 2006 00:12:32 +0300
From: Anssi Hannula <anssi.hannula@gmail.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-joystick@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [patch 03/11] input: new force feedback interface
Content-Disposition: inline; filename=ff-refactoring-new-interface.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Implement a new force feedback interface, in which all non-driver-specific
operations are separated to a common module. This module handles effect type
validations, effect timers, locking, etc.

As a result, support is added for gain and envelope for memoryless devices,
periodic => rumble conversion for memoryless devices and rumble => periodic
conversion for devices with periodic support instead of rumble support. Also
the effect memory of devices is not emptied if the root user opens and closes
the device while another user is using effects. This module also obsoletes
some flawed locking and timer code in few ff drivers.

The module is named ff-effects. If INPUT_FF_EFFECTS is enabled, the force
feedback drivers and interfaces (evdev) will be depending on it.

Userspace interface is left unaltered.

Signed-off-by: Anssi Hannula <anssi.hannula@gmail.com>

---
 drivers/input/Kconfig      |    9 
 drivers/input/Makefile     |    1 
 drivers/input/evdev.c      |   12 
 drivers/input/ff-effects.c |  751 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/input/input.c      |   17 -
 include/linux/input.h      |   50 ++
 6 files changed, 831 insertions(+), 9 deletions(-)

Index: linux-2.6.17-rc4-git1/drivers/input/ff-effects.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.17-rc4-git1/drivers/input/ff-effects.c	2006-05-14 00:14:44.000000000 +0300
@@ -0,0 +1,751 @@
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
+#include <linux/input.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/spinlock.h>
+#include <linux/sched.h>
+
+#include "fixp-arith.h"
+
+/* #define DEBUG */
+
+#ifdef DEBUG
+#define debug(format, arg...) printk(KERN_DEBUG "ff-effects: " format "\n" , ## arg)
+#else
+#define debug(format, arg...) do {} while (0)
+#endif
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Anssi Hannula <anssi.hannula@gmail.com>");
+MODULE_DESCRIPTION("Force feedback support for input subsystem");
+
+/* Number of effects handled with memoryless devices */
+#define FF_MEMLESS_EFFECTS	16
+
+/* Envelope update interval in ms */
+#define FF_ENVELOPE_INTERVAL	50
+
+EXPORT_SYMBOL(input_ff_allocate);
+EXPORT_SYMBOL(input_ff_register);
+EXPORT_SYMBOL(input_ff_upload);
+EXPORT_SYMBOL(input_ff_erase);
+
+#define spin_ff_cond_lock(_ff, _flags)					  \
+	do {								  \
+		if (!_ff->driver->playback)				  \
+			spin_lock_irqsave(&_ff->atomiclock, _flags);	  \
+	} while (0);
+
+#define spin_ff_cond_unlock(_ff, _flags)					  \
+	do {								  \
+		if (!_ff->driver->playback)				  \
+			spin_unlock_irqrestore(&_ff->atomiclock, _flags); \
+	} while (0);
+
+static int input_ff_effect_access(struct input_dev *dev, int id, int override)
+{
+	struct ff_device *ff = dev->ff;
+	if (id < dev->ff_effects_max && id >= 0 && test_bit(FF_EFFECT_USED, ff->effects[id].flags))
+		if (override || ff->effects[id].owner == current->pid)
+			return 0;
+		else
+			return -EACCES;
+	else
+		return -EINVAL;
+}
+
+static int input_ff_envelope_time(struct ff_effect_status *effect, struct ff_envelope *envelope, unsigned long *event_time)
+{
+	unsigned long fade_start;
+	if (!envelope)
+		return 0;
+
+	if (envelope->attack_length && time_after(effect->play_at + msecs_to_jiffies(envelope->attack_length), effect->adj_at)) {
+		*event_time = effect->adj_at + msecs_to_jiffies(FF_ENVELOPE_INTERVAL);
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
+					envelope = &ff->effects[i].effect.u.periodic.envelope;
+				else if (ff->effects[i].effect.type == FF_CONSTANT)
+					envelope = &ff->effects[i].effect.u.constant.envelope;
+
+				event_set = input_ff_envelope_time(&ff->effects[i], envelope, &event_time);
+				if (!event_set && ff->effects[i].effect.replay.length) {
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
+static u16 input_ff_unsign(s16 value)
+{
+	if (value == -0x8000)
+		return 0x7fff;
+
+	return (value < 0 ? -value : value);
+}
+
+static int input_ff_envelope(struct ff_effect_status *effect, int value, struct ff_envelope *envelope)
+{
+	unsigned long current_time = jiffies;
+	unsigned int time_from_level;
+	unsigned int time_of_envelope;
+	unsigned int envelope_level;
+	int difference;
+
+	if (envelope->attack_length && time_after(effect->play_at + msecs_to_jiffies(envelope->attack_length),
+						  current_time)) {
+		debug("value = 0x%x, attack_level = 0x%x", value, envelope->attack_level);
+		time_from_level = current_time - effect->play_at;
+		time_of_envelope = msecs_to_jiffies(envelope->attack_length);
+		envelope_level = envelope->attack_level > 0x7fff ? 0x7fff : envelope->attack_level;
+	} else if (envelope->fade_length && effect->effect.replay.length &&
+			  time_after(current_time, effect->stop_at - msecs_to_jiffies(envelope->fade_length)) &&
+			  time_after(effect->stop_at, current_time)) {
+		time_from_level = effect->stop_at - current_time;
+		time_of_envelope = msecs_to_jiffies(envelope->fade_length);
+		envelope_level = envelope->fade_level > 0x7fff ? 0x7fff : envelope->fade_level;
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
+		difference = -((-difference) * time_from_level / time_of_envelope);
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
+static int input_ff_emu_effect_type(struct input_dev *dev, int effect_type) {
+
+	if (test_bit(effect_type, dev->ff->flags))
+		return effect_type;
+
+	if (effect_type == FF_PERIODIC && test_bit(FF_RUMBLE, dev->ff->flags))
+		return FF_RUMBLE;
+
+	printk(KERN_ERR "ff-effects: invalid type in input_ff_emu_effect_type()\n");
+	return 0;
+}
+
+static int input_ff_safe_sum(int a, int b, int limit) {
+	int c;
+	if (!a)
+		return b;
+	c = a + b;
+	if (c > limit)
+		return limit;
+	return c;
+}
+
+static s8 input_ff_s8_sum(int a, int b) {
+	int c;
+	c = input_ff_safe_sum(a, b, 0x7f);
+	if (c < -0x80)
+		return -0x80;
+	return c;
+}
+
+static void input_ff_convert_effect(struct input_dev *dev, struct ff_effect *effect)
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
+		effect->u.periodic.magnitude = input_ff_safe_sum(strong_magnitude, weak_magnitude, 0x7fff);
+		effect->u.periodic.offset = 0;
+		effect->u.periodic.phase = 0;
+		effect->u.periodic.envelope.attack_length = 0;
+		effect->u.periodic.envelope.attack_level = 0;
+		effect->u.periodic.envelope.fade_length = 0;
+		effect->u.periodic.envelope.fade_level = 0;
+		return;
+	}
+
+
+	printk(KERN_ERR "ff-effects: invalid effect type in convert_effect()\n");
+}
+
+static void input_ff_sum_effect(struct ff_effect *effect, struct ff_effect_status *new, unsigned int gain)
+{
+	unsigned int strong, weak, i;
+	int x, y;
+	fixp_t level;
+	switch (new->effect.type) {
+		case FF_CONSTANT:
+			if (effect->type != FF_CONSTANT)
+				break;
+			i = new->effect.direction * 360 / 0xffff;
+			level = fixp_new16(input_ff_envelope(new, new->effect.u.constant.level,
+					   &new->effect.u.constant.envelope));
+			x = fixp_mult(fixp_sin(i), level) * gain / 0xffff;
+			y = fixp_mult(-fixp_cos(i), level) * gain / 0xffff;
+			/* here we abuse ff_ramp to hold x and y of constant force */
+			/* If in future any driver wants something else than
+			x and y in s8, this should be changed to something more generic */
+			effect->u.ramp.start_level = input_ff_s8_sum(effect->u.rumble.strong_magnitude, x);
+			effect->u.ramp.end_level = input_ff_s8_sum(effect->u.rumble.weak_magnitude, y);
+			return;
+		case FF_RUMBLE:
+			if (effect->type != FF_RUMBLE)
+				break;
+			strong = new->effect.u.rumble.strong_magnitude * gain / 0xffff;
+			weak = new->effect.u.rumble.weak_magnitude * gain / 0xffff;
+			effect->u.rumble.strong_magnitude =
+					input_ff_safe_sum(effect->u.rumble.strong_magnitude, strong, 0xffff);
+			effect->u.rumble.weak_magnitude =
+					input_ff_safe_sum(effect->u.rumble.weak_magnitude, weak, 0xffff);
+			return;
+		case FF_PERIODIC:
+			if (effect->type != FF_RUMBLE)
+				break;
+			/* very small period values should lessen the magnitude */
+			i = input_ff_unsign(new->effect.u.periodic.magnitude);
+			i = input_ff_envelope(new, i, &new->effect.u.periodic.envelope);
+			/* here we also scale it 0x7fff => 0xffff */
+			i = i * gain / 0x7fff;
+
+			effect->u.rumble.strong_magnitude =
+					input_ff_safe_sum(effect->u.rumble.strong_magnitude, i, 0xffff);
+			effect->u.rumble.weak_magnitude =
+					input_ff_safe_sum(effect->u.rumble.weak_magnitude, i, 0xffff);
+			return;
+	}
+
+	printk(KERN_ERR "ff-effects: invalid type in input_ff_sum_effect()\n");
+}
+
+static void input_ff_timer(unsigned long timer_data)
+{
+	struct input_dev *dev = (struct input_dev *) timer_data;
+	struct ff_device *ff = dev->ff;
+	struct ff_effect effect;
+	int i;
+	unsigned long flags;
+	int effects_pending;
+	unsigned long effect_handled[NBITS(FF_EFFECTS_MAX)];
+	int effect_type;
+	int safety;
+
+	debug("timer: updating effects");
+
+	spin_lock_irqsave(&ff->atomiclock, flags);
+
+	memset(effect_handled, 0, sizeof(effect_handled));
+	safety = 0;
+	effects_pending = 1;
+
+	while (effects_pending) {
+		if (safety++ > 50) {
+			printk(KERN_ERR "ff-effects: update aborted to avoid deadlock\n");
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
+				if (!test_bit(FF_EFFECT_PLAYING, ff->effects[i].flags))
+					continue;
+				if (!effect.type) {
+					effect.type = input_ff_emu_effect_type(dev, ff->effects[i].effect.type);
+					clear_bit(FF_EFFECT_PLAYING, ff->effects[i].flags);
+					set_bit(i, effect_handled);
+					continue;
+				}
+				if (effect.type == input_ff_emu_effect_type(dev, ff->effects[i].effect.type)) {
+					clear_bit(FF_EFFECT_PLAYING, ff->effects[i].flags);
+					set_bit(i, effect_handled);
+					continue;
+				}
+				debug("effects pending: case 1");
+				effects_pending = 1;
+				continue;
+			}
+
+			if (time_after(ff->effects[i].play_at, jiffies)) {
+				set_bit(i, effect_handled);
+				continue;
+			}
+
+			effect_type = input_ff_emu_effect_type(dev, ff->effects[i].effect.type);
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
+			if (ff->effects[i].effect.replay.length && time_after_eq(jiffies, ff->effects[i].stop_at)) {
+
+				clear_bit(FF_EFFECT_PLAYING, ff->effects[i].flags);
+
+				if (--ff->effects[i].count <= 0) {
+					clear_bit(FF_EFFECT_STARTED, ff->effects[i].flags);
+					set_bit(i, effect_handled);
+					continue;
+				} else {
+					ff->effects[i].play_at =
+							jiffies + msecs_to_jiffies(ff->effects[i].effect.replay.delay);
+					ff->effects[i].stop_at =
+							dev->ff->effects[i].play_at +
+							msecs_to_jiffies(ff->effects[i].effect.replay.length);
+					set_bit(i, effect_handled);
+					continue;
+				}
+			}
+
+			set_bit(FF_EFFECT_PLAYING, ff->effects[i].flags);
+
+			input_ff_sum_effect(&effect, &ff->effects[i], ff->gain);
+			ff->effects[i].adj_at = jiffies;
+			set_bit(i, effect_handled);
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
+static int _input_ff_erase(struct input_dev *dev, int id, int override)
+{
+	int ret = input_ff_effect_access(dev, id, override);
+	if (ret)
+		return ret;
+	if (dev->ff->driver->playback) {
+		dev->ff->driver->playback(dev, id, 0);
+		ret = dev->ff->driver->erase(dev, id);
+		if (!ret)
+			clear_bit(FF_EFFECT_USED, dev->ff->effects[id].flags);
+	} else {
+		if (test_and_clear_bit(FF_EFFECT_STARTED, dev->ff->effects[id].flags))
+			input_ff_calc_timer(dev->ff);
+		clear_bit(FF_EFFECT_USED, dev->ff->effects[id].flags);
+	}
+	return ret;
+}
+
+int input_ff_erase(struct input_dev *dev, int id)
+{
+	struct ff_device *ff;
+	unsigned long flags = 0;
+	int ret;
+	if (!test_bit(EV_FF, dev->evbit))
+		return -EINVAL;
+	mutex_lock(&dev->ff_lock);
+	ff = dev->ff;
+	if (!ff) {
+		mutex_unlock(&dev->ff_lock);
+		return -ENODEV;
+	}
+	spin_ff_cond_lock(ff, flags);
+	ret = _input_ff_erase(dev, id, current->pid == 0);
+	spin_ff_cond_unlock(ff, flags);
+
+	mutex_unlock(&dev->ff_lock);
+	return ret;
+}
+
+static int input_ff_flush(struct input_dev *dev, struct file *file)
+{
+	struct ff_device *ff;
+	unsigned long flags = 0;
+	int i;
+	debug("flushing now");
+	mutex_lock(&dev->ff_lock);
+	ff = dev->ff;
+	if (!ff) {
+		mutex_unlock(&dev->ff_lock);
+		return -ENODEV;
+	}
+	spin_ff_cond_lock(ff, flags);
+	for (i = 0; i < dev->ff_effects_max; i++) {
+		_input_ff_erase(dev, i, 0);
+	}
+	spin_ff_cond_unlock(ff, flags);
+	mutex_unlock(&dev->ff_lock);
+	return 0;
+}
+
+
+static int input_ff_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
+{
+
+	struct ff_device *ff = dev->ff;
+	int ret = 0;
+	unsigned long flags = 0;
+	if (value < 0)
+		return -EINVAL;
+	/* Mutex is already locked in input.c as input_ff_event address is
+	   stored in ff_device struct */
+	spin_ff_cond_lock(ff, flags);
+
+	if (code == FF_GAIN) {
+		int i;
+		if (!test_bit(FF_GAIN, dev->ffbit) || value > 0xffff || value < 0) {
+			ret = -EINVAL;
+		} else if (ff->driver->set_gain) {
+			ff->driver->set_gain(dev, value);
+		} else if (!ff->driver->playback) {
+			ff->gain = value;
+			for (i = 0; i < dev->ff_effects_max; i++)
+				clear_bit(FF_EFFECT_PLAYING, ff->effects[i].flags);
+			input_ff_calc_timer(ff);
+		} else {
+			ret = -ENOSYS;
+		}
+		spin_ff_cond_unlock(ff, flags);
+		return ret;
+	}
+
+	if (code == FF_AUTOCENTER) {
+		if (!test_bit(FF_AUTOCENTER, dev->ffbit) || value > 0xffff || value < 0) {
+			ret = -EINVAL;
+		} else if (ff->driver->set_autocenter) {
+			ff->driver->set_autocenter(dev, value);
+			ret = 0;
+		} else {
+			ret = -ENOSYS;
+		}
+		spin_ff_cond_unlock(ff, flags);
+		return ret;
+	}
+
+
+	ret = input_ff_effect_access(dev, code, 1);
+	if (ret) {
+		spin_ff_cond_unlock(ff, flags);
+		return ret;
+	}
+
+	if (ff->driver->playback) {
+		ret = ff->driver->playback(dev, code, value);
+		return ret;
+	}
+
+	if (value > 0) {
+		debug("initiated play");
+		set_bit(FF_EFFECT_STARTED, ff->effects[code].flags);
+		clear_bit(FF_EFFECT_PLAYING, ff->effects[code].flags);
+		ff->effects[code].count = value;
+		ff->effects[code].play_at = jiffies +
+				msecs_to_jiffies(ff->effects[code].effect.replay.delay);
+		ff->effects[code].stop_at = ff->effects[code].play_at +
+				msecs_to_jiffies(ff->effects[code].effect.replay.length);
+		ff->effects[code].adj_at = ff->effects[code].play_at;
+	} else {
+		debug("initiated stop");
+		clear_bit(FF_EFFECT_STARTED, ff->effects[code].flags);
+	}
+	input_ff_calc_timer(ff);
+
+	spin_unlock_irqrestore(&ff->atomiclock, flags);
+	return 0;
+}
+
+#define VALID_EFFECT_MIN	FF_RUMBLE
+#define VALID_EFFECT_MAX	FF_RAMP
+#define VALID_WFORM_MIN		FF_SQUARE
+#define VALID_WFORM_MAX		FF_CUSTOM
+static int input_ff_validate_effect(struct ff_effect *effect)
+{
+	if (effect->type < VALID_EFFECT_MIN || effect->type > VALID_EFFECT_MAX)
+		return -EINVAL;
+	if (effect->type == FF_PERIODIC &&
+		   (effect->u.periodic.waveform < VALID_WFORM_MIN ||
+		   effect->u.periodic.waveform > VALID_WFORM_MAX))
+		return -EINVAL;
+	return 0;
+}
+
+int input_ff_upload(struct input_dev *dev, struct ff_effect *effect)
+{
+	struct ff_device *ff;
+	unsigned long flags = 0;
+	int ret = 0; int id;
+
+	if (!test_bit(EV_FF, dev->evbit) || input_ff_validate_effect(effect) ||
+		    !test_bit(effect->type, dev->ffbit) ||
+		    (effect->type == FF_PERIODIC &&
+				    !test_bit(effect->u.periodic.waveform, dev->ffbit))) {
+		debug("invalid upload");
+		return -EINVAL;
+	}
+
+	mutex_lock(&dev->ff_lock);
+	ff = dev->ff;
+	if (!ff) {
+		mutex_unlock(&dev->ff_lock);
+		return -ENODEV;
+	}
+	spin_ff_cond_lock(ff, flags);
+
+	if (effect->id == -1) {
+		for (id = 0; id < dev->ff_effects_max && test_bit(FF_EFFECT_USED, ff->effects[id].flags); id++);
+
+		if (id >= dev->ff_effects_max) {
+			spin_ff_cond_unlock(ff, flags);
+			mutex_unlock(&dev->ff_lock);
+			return -ENOSPC;
+		}
+
+		effect->id = id;
+		ff->effects[id].owner = current->pid;
+		ff->effects[id].flags[0] = 0;
+		ff->effects[id].effect = *effect;
+
+		if (ff->driver->playback) {
+			if (!test_bit(effect->type, ff->flags))
+				input_ff_convert_effect(dev, effect);
+			ret = ff->driver->upload(dev, effect, NULL);
+			if (!ret)
+				set_bit(FF_EFFECT_USED, ff->effects[id].flags);
+			mutex_unlock(&dev->ff_lock);
+			return ret;
+		}
+		set_bit(FF_EFFECT_USED, ff->effects[id].flags);
+
+	} else {
+		id = effect->id;
+
+		ret = input_ff_effect_access(dev, id, 1);
+		if (ret) {
+			spin_ff_cond_unlock(ff, flags);
+			mutex_unlock(&dev->ff_lock);
+			return ret;
+		}
+
+		if (effect->type != ff->effects[id].effect.type ||
+				  (effect->type == FF_PERIODIC && effect->u.periodic.waveform !=
+				  ff->effects[id].effect.u.periodic.waveform)) {
+			spin_ff_cond_unlock(ff, flags);
+			mutex_unlock(&dev->ff_lock);
+			return -EINVAL;
+		}
+
+		if (ff->driver->playback) {
+			if (!test_bit(effect->type, ff->flags))
+				input_ff_convert_effect(dev, effect);
+			ret = ff->driver->upload(dev, effect, &ff->effects[id].effect);
+			ff->effects[id].effect = *effect;
+			mutex_unlock(&dev->ff_lock);
+			return ret;
+		}
+		ff->effects[id].effect = *effect;
+		clear_bit(FF_EFFECT_PLAYING, ff->effects[id].flags);
+
+	}
+
+	spin_unlock_irqrestore(&ff->atomiclock, flags);
+	mutex_unlock(&dev->ff_lock);
+	return ret;
+}
+
+int input_ff_allocate(struct input_dev *dev)
+{
+	debug("allocating device");
+	mutex_lock(&dev->ff_lock);
+	if (dev->ff)
+		printk(KERN_ERR "ff-effects: allocating to non-NULL pointer\n");
+	dev->ff = kzalloc(sizeof(*dev->ff), GFP_KERNEL);
+	if (!dev->ff) {
+		mutex_unlock(&dev->ff_lock);
+		return -ENOMEM;
+	}
+	spin_lock_init(&dev->ff->atomiclock);
+	init_timer(&dev->ff->timer);
+	dev->ff->timer.function = input_ff_timer;
+	dev->ff->timer.data = (unsigned long) dev;
+	dev->ff->event = input_ff_event;
+	mutex_unlock(&dev->ff_lock);
+	debug("ff allocated");
+	return 0;
+}
+
+int input_ff_register(struct input_dev *dev, struct ff_driver *driver)
+{
+	debug("registering device");
+	if (!dev->ff) {
+		printk(KERN_ERR "ff-effects: tried to register before allocate\n");
+		return -EPERM;
+	}
+	if (driver->playback && !dev->ff_effects_max) {
+		printk(KERN_ERR "ff-effects: cannot register a device with 0 effects\n");
+		return -EINVAL;
+	}
+	mutex_lock(&dev->ff_lock);
+
+	dev->flush = input_ff_flush;
+	dev->ff->driver = driver;
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
+ 	set_bit(EV_FF, dev->evbit);
+	mutex_unlock(&dev->ff_lock);
+
+	return 0;
+}
+
Index: linux-2.6.17-rc4-git1/drivers/input/Kconfig
===================================================================
--- linux-2.6.17-rc4-git1.orig/drivers/input/Kconfig	2006-03-20 07:53:29.000000000 +0200
+++ linux-2.6.17-rc4-git1/drivers/input/Kconfig	2006-05-14 02:28:42.000000000 +0300
@@ -24,6 +24,14 @@ config INPUT
 
 if INPUT
 
+config INPUT_FF_EFFECTS
+	tristate "Force feedback effects"
+	help
+	  Say Y here if you want to be able to play force feedback effects.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ff-effects.
+
 comment "Userland interfaces"
 
 config INPUT_MOUSEDEV
@@ -110,6 +118,7 @@ config INPUT_TSDEV_SCREEN_Y
 
 config INPUT_EVDEV
 	tristate "Event interface"
+	depends on INPUT_FF_EFFECTS || INPUT_FF_EFFECTS=n
 	help
 	  Say Y here if you want your input device events be accessible
 	  under char device 13:64+ - /dev/input/eventX in a generic way.
Index: linux-2.6.17-rc4-git1/drivers/input/Makefile
===================================================================
--- linux-2.6.17-rc4-git1.orig/drivers/input/Makefile	2006-03-20 07:53:29.000000000 +0200
+++ linux-2.6.17-rc4-git1/drivers/input/Makefile	2006-05-14 00:14:44.000000000 +0300
@@ -5,6 +5,7 @@
 # Each configuration option enables a list of files.
 
 obj-$(CONFIG_INPUT)		+= input.o
+obj-$(CONFIG_INPUT_FF_EFFECTS)	+= ff-effects.o
 obj-$(CONFIG_INPUT_MOUSEDEV)	+= mousedev.o
 obj-$(CONFIG_INPUT_JOYDEV)	+= joydev.o
 obj-$(CONFIG_INPUT_EVDEV)	+= evdev.o
Index: linux-2.6.17-rc4-git1/include/linux/input.h
===================================================================
--- linux-2.6.17-rc4-git1.orig/include/linux/input.h	2006-05-13 19:59:03.000000000 +0300
+++ linux-2.6.17-rc4-git1/include/linux/input.h	2006-05-14 01:36:20.000000000 +0300
@@ -865,6 +865,9 @@ struct input_dev {
 	unsigned long sndbit[NBITS(SND_MAX)];
 	unsigned long ffbit[NBITS(FF_MAX)];
 	unsigned long swbit[NBITS(SW_MAX)];
+
+	struct ff_device *ff;
+	struct mutex ff_lock;
 	int ff_effects_max;
 
 	unsigned int keycodemax;
@@ -1000,6 +1003,53 @@ struct input_handle {
 #define to_handle(n) container_of(n,struct input_handle,d_node)
 #define to_handle_h(n) container_of(n,struct input_handle,h_node)
 
+#define FF_EFFECTS_MAX 64
+
+struct ff_driver {
+	int (*upload)(struct input_dev *dev, struct ff_effect *effect, struct ff_effect *old);
+	int (*erase)(struct input_dev *dev, int effect_id);
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
+	pid_t owner;
+	struct ff_effect effect;
+	unsigned long flags[1];
+	int count;
+	unsigned long play_at;
+	unsigned long stop_at;
+	unsigned long adj_at;
+};
+
+struct ff_device {
+	int (*event)(struct input_dev *dev, unsigned int type, unsigned int code, int value);
+	unsigned long flags[NBITS(FF_MAX)];
+	u16 gain;
+	spinlock_t atomiclock;
+	struct ff_driver *driver;
+	struct timer_list timer;
+	struct ff_effect_status effects[FF_EFFECTS_MAX];
+};
+
+#if defined(CONFIG_INPUT_FF_EFFECTS_MODULE) || defined(CONFIG_INPUT_FF_EFFECTS)
+int input_ff_allocate(struct input_dev *dev);
+int input_ff_register(struct input_dev *dev, struct ff_driver *driver);
+int input_ff_upload(struct input_dev *dev, struct ff_effect *effect);
+int input_ff_erase(struct input_dev *dev, int id);
+#else
+static inline int input_ff_allocate(struct input_dev *dev) { return -ENOSYS; }
+static inline int input_ff_register(struct input_dev *dev, struct ff_driver *driver) { return -ENOSYS; }
+static inline int input_ff_upload(struct input_dev *dev, struct ff_effect *effect) { return -EINVAL; }
+static inline int input_ff_erase(struct input_dev *dev, int id) { return -EINVAL; }
+#endif
+
+
 static inline void init_input_dev(struct input_dev *dev)
 {
 	INIT_LIST_HEAD(&dev->h_list);
Index: linux-2.6.17-rc4-git1/drivers/input/input.c
===================================================================
--- linux-2.6.17-rc4-git1.orig/drivers/input/input.c	2006-05-13 19:58:22.000000000 +0300
+++ linux-2.6.17-rc4-git1/drivers/input/input.c	2006-05-14 00:14:44.000000000 +0300
@@ -172,7 +172,10 @@ void input_event(struct input_dev *dev, 
 			break;
 
 		case EV_FF:
-			if (dev->event) dev->event(dev, type, code, value);
+			mutex_lock(&dev->ff_lock);
+			if (dev->ff)
+				dev->ff->event(dev, type, code, value);
+			mutex_unlock(&dev->ff_lock);
 			break;
 	}
 
@@ -733,6 +736,17 @@ static void input_dev_release(struct cla
 {
 	struct input_dev *dev = to_input_dev(class_dev);
 
+	if (dev->ff) {
+		struct ff_device *ff = dev->ff;
+		clear_bit(EV_FF, dev->evbit);
+		mutex_lock(&dev->ff_lock);
+		del_timer_sync(&ff->timer);
+		dev->flush = NULL;
+		dev->ff = NULL;
+		kfree(ff);
+		mutex_unlock(&dev->ff_lock);
+	}
+
 	kfree(dev);
 	module_put(THIS_MODULE);
 }
@@ -874,6 +888,7 @@ struct input_dev *input_allocate_device(
 		class_device_initialize(&dev->cdev);
 		INIT_LIST_HEAD(&dev->h_list);
 		INIT_LIST_HEAD(&dev->node);
+		mutex_init(&dev->ff_lock);
 	}
 
 	return dev;
Index: linux-2.6.17-rc4-git1/drivers/input/evdev.c
===================================================================
--- linux-2.6.17-rc4-git1.orig/drivers/input/evdev.c	2006-05-13 19:58:22.000000000 +0300
+++ linux-2.6.17-rc4-git1/drivers/input/evdev.c	2006-05-14 00:14:44.000000000 +0300
@@ -458,24 +458,20 @@ static long evdev_ioctl_handler(struct f
 			return 0;
 
 		case EVIOCSFF:
-			if (dev->upload_effect) {
+			{
 				struct ff_effect effect;
 				int err;
 
 				if (copy_from_user(&effect, p, sizeof(effect)))
 					return -EFAULT;
-				err = dev->upload_effect(dev, &effect);
+				err = input_ff_upload(dev, &effect);
 				if (put_user(effect.id, &(((struct ff_effect __user *)p)->id)))
 					return -EFAULT;
 				return err;
-			} else
-				return -ENOSYS;
+			}
 
 		case EVIOCRMFF:
-			if (!dev->erase_effect)
-				return -ENOSYS;
-
-			return dev->erase_effect(dev, (int)(unsigned long) p);
+			return input_ff_erase(dev, (int)(unsigned long) p);
 
 		case EVIOCGEFFECTS:
 			if (put_user(dev->ff_effects_max, ip))

--
Anssi Hannula
