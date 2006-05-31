Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964951AbWEaKOD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964951AbWEaKOD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 06:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964952AbWEaKOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 06:14:03 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:40554 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964951AbWEaKOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 06:14:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=UQU7OwYNz6SPT609kYfYGSBwQjIQlLZob/G9zcOh91/l3VzD62faOG8wIiBmrPiKUswvJc3s9iHzaPcnWAESDPzF4yM0YjczrFEUHPB/re+vtt93UDOVYnieJRs1o42IcX30iFq6UcR5iSodyd0hyTQn4V8rl2TWmBXXsujV+wk=
Message-ID: <447D6C63.3050702@gmail.com>
Date: Wed, 31 May 2006 13:13:55 +0300
From: Anssi Hannula <anssi.hannula@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6-7.5.20060mdk (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: dtor_core@ameritech.net, linux-joystick@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 03/12] input: new force feedback interface
References: <20060530105705.157014000@gmail.com>	<20060530110131.136225000@gmail.com> <20060530222122.069da389.rdunlap@xenotime.net>
In-Reply-To: <20060530222122.069da389.rdunlap@xenotime.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> On Tue, 30 May 2006 13:57:08 +0300 Anssi Hannula wrote:
> 

Thanks for reviewing.


>> drivers/input/Kconfig      |    5 
>> drivers/input/Makefile     |    1 
>> drivers/input/evdev.c      |   30 -
>> drivers/input/ff-effects.c |  894 +++++++++++++++++++++++++++++++++++++++++++++
>> drivers/input/input.c      |   12 
>> include/linux/input.h      |   81 ++++
>> 6 files changed, 1006 insertions(+), 17 deletions(-)
>>
>>Index: linux-2.6.17-rc4-git12/include/linux/input.h
>>===================================================================
>>--- linux-2.6.17-rc4-git12.orig/include/linux/input.h	2006-05-27 02:28:33.000000000 +0300
>>+++ linux-2.6.17-rc4-git12/include/linux/input.h	2006-05-27 03:06:34.000000000 +0300
>>@@ -1000,6 +1003,84 @@ struct input_handle {
>>+
>>+#ifdef CONFIG_INPUT_FF_EFFECTS
>>+int input_ff_allocate(struct input_dev *dev);
>>+int input_ff_register(struct input_dev *dev, struct ff_driver *driver);
>>+int input_ff_upload(struct input_dev *dev, struct ff_effect *effect,
>>+		    struct file *file);
>>+int input_ff_erase(struct input_dev *dev, int effect_id, struct file *file);
>>+int input_ff_event(struct input_dev *dev, unsigned int type,
>>+		   unsigned int code, int value);
>>+#else
>>+static inline int input_ff_allocate(struct input_dev *dev)
>>+{
>>+	return -EPERM;
>>+}
> 
> 
> -ENOSYS seems more reasonable to me (above + below).
> 

Okay, I'll send a patch to change -EPERM back to -ENOSYS.

I think the -EINVAL should be left as -EINVAL because they get called
only when the user performs upload or erase ioctls on device that is not
marked with EV_FF.

>>+static inline int input_ff_register(struct input_dev *dev,
>>+				    struct ff_driver *driver)
>>+{
>>+	return -EPERM;
>>+}
>>+static inline int input_ff_upload(struct input_dev *dev,
>>+				  struct ff_effect *effect, struct file *file)
>>+{
>>+	return -EINVAL;
>>+}
>>+static inline int input_ff_erase(struct input_dev *dev, int effect_id,
>>+				 struct file *file)
>>+{
>>+	return -EINVAL;
>>+}
>>+static inline int input_ff_event(struct input_dev *dev, unsigned int type,
>>+				 unsigned int code, int value) { }
>>+#endif
>>+
>>+
>> static inline void init_input_dev(struct input_dev *dev)
>> {
>> 	INIT_LIST_HEAD(&dev->h_list);
> 
> 
>>Index: linux-2.6.17-rc4-git12/drivers/input/ff-effects.c
>>===================================================================
>>--- /dev/null	1970-01-01 00:00:00.000000000 +0000
>>+++ linux-2.6.17-rc4-git12/drivers/input/ff-effects.c	2006-05-27 03:06:56.000000000 +0300
>>@@ -0,0 +1,894 @@
>>+/*
>>+ *  Force feedback support for Linux input subsystem
>>+ *
>>+ *  Copyright (c) 2006 Anssi Hannula <anssi.hannula@gmail.com>
>>+ */
>>+
>>+
>>+/**
> 
> 
> "/**" indicates kernel-doc format, but the rest of the function
> comment is not in kernel-doc format.  Please use kernel-doc
> for all non-static/non-inline functions (basically for
> public/exported symbols) and at your discretion for static
> functions.
> (applies to many functions here)

Okay, I didn't know about kernel-doc. I'll adapt the comments.

> 
>>+ * Lock the mutex and check the device has not been deleted
>>+ */
>>+static inline int input_ff_safe_lock(struct input_dev *dev)
>>+{
>>+	mutex_lock(&dev->ff_lock);
>>+	if (dev->ff)
>>+		return 0;
>>+
>>+	mutex_unlock(&dev->ff_lock);
>>+	return 1;
>>+}
>>+
>>+/**
>>+ * Check that the effect_id is a valid effect and the user has access to it
>>+ */
>>+static inline int input_ff_effect_access(struct input_dev *dev, int effect_id,
>>+					 struct file *file)
>>+{
>>+	struct ff_device *ff = dev->ff;
>>+
>>+	if (effect_id >= dev->ff_effects_max || effect_id < 0
>>+	    || !test_bit(FF_EFFECT_USED, ff->effects[effect_id].flags))
>>+		return -EINVAL;
>>+
>>+	if (ff->effects[effect_id].owner != file)
>>+		return -EACCES;
>>+
>>+	return 0;
>>+}
>>+
> 
> 
> See Documentation/kernel-doc-nano-HOWTO.txt for more info:

Ok.

> 
>>+/**
>>+ * Check for the next time envelope requires an update on memoryless devices
>>+ * @event_time: Time of the next update
>>+ *
>>+ * If an event is found before @event_time, @event_time is changed and the
>>+ * functions returns 1. Otherwise it returns 0.
>>+ */
>>+static int input_ff_envelope_time(struct ff_effect_status *effect,
>>+				  struct ff_envelope *envelope,
>>+				  unsigned long *event_time)
>>+{
>>+}
>>+
>>+/**
>>+ * Calculate the next time effect requires an update on memoryless devices
>>+ * @ff: The device
>>+ *
>>+ * Runs through the effects and updates the timer if necessary. This function
>>+ * should be called only when the spinlock is locked.
>>+ */
>>+static void input_ff_calc_timer(struct ff_device *ff)
>>+{
>>+	int i;
>>+	int events = 0;
>>+	unsigned long next_time = 0;
> 
> 
> We generally like a blank line between data and code lines....

Ok.

> 
>>+	debug("calculating next timer");
>>+	for (i = 0; i < FF_MEMLESS_EFFECTS; ++i) {
>>+		unsigned long event_time;
>>+		struct ff_envelope *envelope = NULL;
>>+		int event_set = 0;
>>+
>>+		if (!test_bit(FF_EFFECT_STARTED, ff->effects[i].flags)) {
>>+			if (test_bit(FF_EFFECT_PLAYING, ff->effects[i].flags)) {
>>+				event_time = ff->effects[i].stop_at = jiffies;
>>+				event_set = 1;
>>+			} else
>>+				continue;
>>+		} else {
>>+			if (!test_bit(FF_EFFECT_PLAYING, ff->effects[i].flags)) {
>>+				event_time = ff->effects[i].play_at;
>>+				event_set = 1;
>>+			} else {
>>+				if (ff->effects[i].effect.type == FF_PERIODIC)
>>+					envelope =
>>+					    &ff->effects[i].effect.u.periodic.
>>+					    envelope;
>>+				else if (ff->effects[i].effect.type ==
>>+					 FF_CONSTANT)
>>+					envelope =
>>+					    &ff->effects[i].effect.u.constant.
>>+					    envelope;
>>+
>>+				event_set =
>>+				    input_ff_envelope_time(&ff->effects[i],
>>+							   envelope,
>>+							   &event_time);
>>+				if (!event_set
>>+				    && ff->effects[i].effect.replay.length) {
>>+					event_time = ff->effects[i].stop_at;
>>+					event_set = 1;
>>+				}
>>+			}
>>+		}
>>+
>>+		if (!event_set)
>>+			continue;
>>+		events++;
>>+
>>+		if (time_after(jiffies, event_time)) {
>>+			event_time = jiffies;
>>+			break;
>>+		}
>>+		if (events == 1)
>>+			next_time = event_time;
>>+		else {
>>+			if (time_after(next_time, event_time))
>>+				next_time = event_time;
>>+		}
>>+	}
>>+	if (!events) {
>>+		debug("no actions");
>>+		del_timer(&ff->timer);
>>+	} else {
>>+		debug("timer set");
>>+		mod_timer(&ff->timer, next_time);
>>+	}
>>+}
>>+
>>+
>>+
>>+/**
>>+ * Safe sum
>>+ * @a: Integer to sum
>>+ * @b: Integer to sum
>>+ * @limit: The sum limit
>>+ *
>>+ * If @a+@b is above @limit, return @limit
> 
> 
> unless a == 0, then return b, even if b > limit
> 

Right.

>>+ */
>>+static int input_ff_safe_sum(int a, int b, int limit)
>>+{
>>+	int c;
>>+	if (!a)
>>+		return b;
>>+	c = a + b;
>>+	if (c > limit)
>>+		return limit;
>>+	return c;
>>+}
>>+
>>+/**
>>+ * Convert an effect (for devices with memory)
>>+ */
>>+static void input_ff_convert_effect(struct input_dev *dev,
>>+				    struct ff_effect *effect)
>>+{
>>+	int strong_magnitude, weak_magnitude;
>>+
>>+	if (effect->type == FF_RUMBLE && test_bit(FF_PERIODIC, dev->ff->flags)) {
>>+		/* Strong magnitude as 2/3 full and weak 1/3 full */
>>+		/* Also divide by 2 */
> 
> 
> why?  Comments should explain why, not just what.

Okay, will add.

> 
>>+		strong_magnitude = effect->u.rumble.strong_magnitude * 2 / 6;
>>+		weak_magnitude = effect->u.rumble.weak_magnitude / 6;
>>+
>>+		effect->type = FF_PERIODIC;
>>+
>>+		effect->u.periodic.waveform = FF_SINE;
>>+		effect->u.periodic.period = 50;
>>+		effect->u.periodic.magnitude =
>>+		    input_ff_safe_sum(strong_magnitude, weak_magnitude, 0x7fff);
>>+		effect->u.periodic.offset = 0;
>>+		effect->u.periodic.phase = 0;
>>+		effect->u.periodic.envelope.attack_length = 0;
>>+		effect->u.periodic.envelope.attack_level = 0;
>>+		effect->u.periodic.envelope.fade_length = 0;
>>+		effect->u.periodic.envelope.fade_level = 0;
>>+		return;
>>+	}
>>+
>>+	printk(KERN_ERR
>>+	       "ff-effects: invalid effect type in convert_effect()\n");
>>+}
>>+
>>+
>>+
>>+/**
>>+ * Erase an effect
>>+ * @file: The requester
> 
> 
> needs all parameters listed/explained

Ok.

> 
>>+ *
>>+ * Erases the effect if the requester is also the effect owner. The mutex
>>+ * should already be locked before calling this function. If the device is a
>>+ * memoryless device, the spinlock will be locked.
>>+ */
>>+static int _input_ff_erase(struct input_dev *dev, int effect_id,
>>+			   struct file *file)
>>+{
>>+	unsigned long flags;
>>+	int ret = input_ff_effect_access(dev, effect_id, file);
>>+	if (ret)
>>+		return ret;
>>+	if (dev->ff->driver->playback) {
>>+		dev->ff->driver->playback(dev, effect_id, 0);
>>+		ret = dev->ff->driver->erase(dev, effect_id);
>>+		if (!ret)
>>+			__clear_bit(FF_EFFECT_USED,
>>+				    dev->ff->effects[effect_id].flags);
>>+	} else {
>>+		spin_lock_irqsave(&dev->ff->atomiclock, flags);
>>+		if (__test_and_clear_bit
>>+		    (FF_EFFECT_STARTED, dev->ff->effects[effect_id].flags))
>>+			input_ff_calc_timer(dev->ff);
>>+		spin_unlock_irqrestore(&dev->ff->atomiclock, flags);
>>+		__clear_bit(FF_EFFECT_USED, dev->ff->effects[effect_id].flags);
>>+	}
>>+	return ret;
>>+}
>>+
>>+
>>+/**
>>+ * Set the bits and handlers
>>+ * @driver: The ff_driver struct
>>+ *
>>+ * If possible, this function should be called before the input device is
>>+ * registered. It can however be ran again if the capability bits have
> 
> 
> s/ran/run/
> 

Will change.

>>+ * changed.
>>+ */
>>+int input_ff_register(struct input_dev *dev, struct ff_driver *driver)
>>+{
> 


-- 
Anssi Hannula

