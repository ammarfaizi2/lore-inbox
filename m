Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964954AbWFAUrh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964954AbWFAUrh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 16:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965295AbWFAUrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 16:47:37 -0400
Received: from pne-smtpout3-sn2.hy.skanova.net ([81.228.8.111]:60288 "EHLO
	pne-smtpout3-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S964954AbWFAUrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 16:47:36 -0400
Date: Thu, 1 Jun 2006 23:47:16 +0300
From: Anssi Hannula <anssi@mandriva.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: dtor_core@ameritech.net, linux-joystick@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: input: fix comments and blank lines in new ff code
Message-ID: <20060601204716.GA6847@delta.onse.fi>
References: <20060530105705.157014000@gmail.com> <20060530110131.136225000@gmail.com> <20060530222122.069da389.rdunlap@xenotime.net> <447F3AE4.6010206@gmail.com> <20060601125256.de2897f4.rdunlap@xenotime.net> <447F47FD.2050705@gmail.com> <20060601130923.38f83fb6.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060601130923.38f83fb6.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anssi Hannula <anssi.hannula@gmail.com>

Fix comments so that they conform to kernel-doc or remove ** if they are
not in kernel-doc format.
Akso add/remove some blank lines.

Signed-off-by: Anssi Hannula <anssi.hannula@gmail.com>

---

Note that the From header of my email is different as otherwise
osdl.org would mark my email as spam. Please use my gmail.com address.

 drivers/input/ff-effects.c    |  144 +++++++++++++++++++++------------
 drivers/usb/input/hid-pidff.c |  183 ++++++++++++++++++++++--------------------
 2 files changed, 191 insertions(+), 136 deletions(-)

Index: linux-2.6.17-rc4-git12/drivers/input/ff-effects.c
===================================================================
--- linux-2.6.17-rc4-git12.orig/drivers/input/ff-effects.c	2006-05-27 03:06:56.000000000 +0300
+++ linux-2.6.17-rc4-git12/drivers/input/ff-effects.c	2006-06-01 23:25:11.000000000 +0300
@@ -48,8 +48,10 @@ EXPORT_SYMBOL_GPL(input_ff_upload);
 EXPORT_SYMBOL_GPL(input_ff_erase);
 EXPORT_SYMBOL_GPL(input_ff_event);
 
-/**
- * Lock the mutex and check the device has not been deleted
+/*
+ * input_ff_safe_lock - lock the mutex and check for the ff_device struct
+ *
+ * Returns 0 if device still present, 1 otherwise.
  */
 static inline int input_ff_safe_lock(struct input_dev *dev)
 {
@@ -61,8 +63,12 @@ static inline int input_ff_safe_lock(str
 	return 1;
 }
 
-/**
- * Check that the effect_id is a valid effect and the user has access to it
+/*
+ * input_ff_effect_access - check effect id validity and access rights
+ *
+ * Returns -EINVAL if the effect @effect_id is not a real effect.
+ * Returns -EACCES if the effect @effect_id is owned by another fd.
+ * Otherwise returns 0.
  */
 static inline int input_ff_effect_access(struct input_dev *dev, int effect_id,
 					 struct file *file)
@@ -79,10 +85,11 @@ static inline int input_ff_effect_access
 	return 0;
 }
 
-/**
- * Check for the next time envelope requires an update on memoryless devices
+/*
+ * input_ff_envelope_time - find the time when envelope will require an update
  * @event_time: Time of the next update
  *
+ * Checks for the next time envelope requires an update on memoryless devices.
  * If an event is found before @event_time, @event_time is changed and the
  * functions returns 1. Otherwise it returns 0.
  */
@@ -91,6 +98,7 @@ static int input_ff_envelope_time(struct
 				  unsigned long *event_time)
 {
 	unsigned long fade_start;
+
 	if (!envelope)
 		return 0;
 
@@ -120,18 +128,20 @@ static int input_ff_envelope_time(struct
 	return 1;
 }
 
-/**
- * Calculate the next time effect requires an update on memoryless devices
- * @ff: The device
+/*
+ * input_ff_calc_timer - recalculate the timer
  *
- * Runs through the effects and updates the timer if necessary. This function
- * should be called only when the spinlock is locked.
+ * Calculate the next time some effect requires an update on a memoryless
+ * device. Functions runs through all the effects and updates the timer if
+ * necessary. This function should be called only while the spinlock is
+ * locked.
  */
 static void input_ff_calc_timer(struct ff_device *ff)
 {
 	int i;
 	int events = 0;
 	unsigned long next_time = 0;
+
 	debug("calculating next timer");
 	for (i = 0; i < FF_MEMLESS_EFFECTS; ++i) {
 		unsigned long event_time;
@@ -195,8 +205,8 @@ static void input_ff_calc_timer(struct f
 	}
 }
 
-/**
- * abs() with -0x8000 => 0x7fff exception
+/*
+ * input_ff_unsign - abs() with -0x8000 => 0x7fff exception
  */
 static inline u16 input_ff_unsign(s16 value)
 {
@@ -206,8 +216,8 @@ static inline u16 input_ff_unsign(s16 va
 	return (value < 0 ? -value : value);
 }
 
-/**
- * Apply an envelope to a value
+/*
+ * input_ff_envelope - apply an envelope to a value
  */
 static int input_ff_envelope(struct ff_effect_status *effect, int value,
 			     struct ff_envelope *envelope)
@@ -262,8 +272,11 @@ static int input_ff_envelope(struct ff_e
 	return difference + envelope_level;
 }
 
-/**
- * Return the type the effect has to be converted into (memless devices)
+/*
+ * input_ff_emu_effect_type - get the new effect type
+ *
+ * Get the effect type into which an @effect_type type effect has to be
+ * converted for device @dev.
  */
 static int input_ff_emu_effect_type(struct input_dev *dev, int effect_type)
 {
@@ -279,13 +292,11 @@ static int input_ff_emu_effect_type(stru
 	return 0;
 }
 
-/**
- * Safe sum
- * @a: Integer to sum
- * @b: Integer to sum
- * @limit: The sum limit
+/*
+ * input_ff_safe_sum - safe sum
  *
- * If @a+@b is above @limit, return @limit
+ * If @a == 0, returns @b. If @a+@b is above @limit, returns @limit. Otherwise
+ * returns @a+@b.
  */
 static int input_ff_safe_sum(int a, int b, int limit)
 {
@@ -298,8 +309,8 @@ static int input_ff_safe_sum(int a, int 
 	return c;
 }
 
-/**
- * Signed safe sum with range -0x80-0x7f
+/*
+ * input_ff_s8_sum - signed safe sum with range -0x80-0x7f
  */
 static s8 input_ff_s8_sum(int a, int b)
 {
@@ -310,8 +321,8 @@ static s8 input_ff_s8_sum(int a, int b)
 	return c;
 }
 
-/**
- * Convert an effect (for devices with memory)
+/*
+ * input_ff_convert_effect - convert an effect (for devices with memory)
  */
 static void input_ff_convert_effect(struct input_dev *dev,
 				    struct ff_effect *effect)
@@ -319,8 +330,11 @@ static void input_ff_convert_effect(stru
 	int strong_magnitude, weak_magnitude;
 
 	if (effect->type == FF_RUMBLE && test_bit(FF_PERIODIC, dev->ff->flags)) {
-		/* Strong magnitude as 2/3 full and weak 1/3 full */
-		/* Also divide by 2 */
+		/* All the below values are only estimates */
+		/* Strong magnitude is regarded as 2/3 of the
+		   periodic.magnitude and weak magnitude as 1/3 */
+		/* They are also divided by 2 as they are u16 while
+		   periodic.magnitude is s16 */
 		strong_magnitude = effect->u.rumble.strong_magnitude * 2 / 6;
 		weak_magnitude = effect->u.rumble.weak_magnitude / 6;
 
@@ -343,11 +357,11 @@ static void input_ff_convert_effect(stru
 	       "ff-effects: invalid effect type in convert_effect()\n");
 }
 
-/**
- * Sum two effects and apply gain
- * @effect: The effect that is going to be sent to the device
- * @new: The effect that is added to @effect
- * @gain: The gain to be applied to @new before adding
+/*
+ * input_ff_sum_effect - sum two effects and apply gain
+ * @effect: the effect that is going to be sent to the device
+ * @new: the effect that is added to @effect
+ * @gain: the gain to be applied to @new before adding
  *
  * Memoryless devices have only one effect per effect type active at one time,
  * so we have to convert multiple effects to a single effect.
@@ -358,6 +372,7 @@ static void input_ff_sum_effect(struct f
 	unsigned int strong, weak, i;
 	int x, y;
 	fixp_t level;
+
 	switch (new->effect.type) {
 	case FF_CONSTANT:
 		if (effect->type != FF_CONSTANT)
@@ -410,9 +425,9 @@ static void input_ff_sum_effect(struct f
 	printk(KERN_ERR "ff-effects: invalid type in input_ff_sum_effect()\n");
 }
 
-/**
- * Send the effects to the memoryless device
- * @timer_data: struct input_dev
+/*
+ * input_ff_timer - send the effects to the memoryless device
+ * @timer_data: &struct input_dev
  *
  * All effects are converted and sent to the device. This function is atomic
  * so it cannot lock the mutex. Therefore any data structures this function
@@ -540,9 +555,11 @@ static void input_ff_timer(unsigned long
 
 }
 
-/**
- * Erase an effect
- * @file: The requester
+/*
+ * _input_ff_erase - erase an effect
+ * @dev: the current device
+ * @effect_id: the effect id of the effect to be erased
+ * @file: the requester
  *
  * Erases the effect if the requester is also the effect owner. The mutex
  * should already be locked before calling this function. If the device is a
@@ -553,6 +570,7 @@ static int _input_ff_erase(struct input_
 {
 	unsigned long flags;
 	int ret = input_ff_effect_access(dev, effect_id, file);
+
 	if (ret)
 		return ret;
 	if (dev->ff->driver->playback) {
@@ -573,12 +591,18 @@ static int _input_ff_erase(struct input_
 }
 
 /**
- * Lock the mutex and call _input_ff_erase
+ * input_ff_erase - lock the mutex and erase an effect
+ * @dev: the current device
+ * @effect_id: the effect id of the effect to be erased
+ * @file: the requester
+ *
+ * Locks the mutex and calls _input_ff_erase.
  */
 int input_ff_erase(struct input_dev *dev, int effect_id, struct file *file)
 {
 	struct ff_device *ff;
 	int ret;
+
 	if (!test_bit(EV_FF, dev->evbit))
 		return -EINVAL;
 	if (input_ff_safe_lock(dev))
@@ -591,13 +615,17 @@ int input_ff_erase(struct input_dev *dev
 	return ret;
 }
 
-/**
- * Lock the mutex and call _input_ff_erase for all effects
+/*
+ * input_ff_flush - lock the mutex and erase all owned effects
+ *
+ * Locks the mutex and calls _input_ff_erase for all effects thus erasing all
+ * effects that are owned by the closed fd @file.
  */
 static int input_ff_flush(struct input_dev *dev, struct file *file)
 {
 	struct ff_device *ff;
 	int i;
+
 	debug("flushing now");
 	if (input_ff_safe_lock(dev))
 		return -ENODEV;
@@ -609,7 +637,14 @@ static int input_ff_flush(struct input_d
 }
 
 /**
- * Handle the EV_FF input event
+ * input_ff_event - handle the EV_FF input event
+ * @dev: the input device
+ * @type: EV_FF
+ * @code: FF_GAIN, FF_AUTOCENTER or the effect id
+ * @value: gain value, autocenter gain or the effect repeat count
+ *
+ * This function can be either assigned to the event() handler of input_dev
+ * directly or be called from the device driver's own event() handler.
  */
 int input_ff_event(struct input_dev *dev, unsigned int type, unsigned int code,
 		    int value)
@@ -617,6 +652,7 @@ int input_ff_event(struct input_dev *dev
 	struct ff_device *ff;
 	unsigned long flags;
 	int i;
+
 	if (type != EV_FF || value < 0)
 		return -EINVAL;
 
@@ -685,8 +721,8 @@ int input_ff_event(struct input_dev *dev
 #define VALID_EFFECT_MAX	FF_RAMP
 #define VALID_WFORM_MIN		FF_SQUARE
 #define VALID_WFORM_MAX		FF_CUSTOM
-/**
- * Check that the effect type and waveform are valid
+/*
+ * input_ff_validate_effect - validate the effect type and waveform
  */
 static int input_ff_validate_effect(struct ff_effect *effect)
 {
@@ -700,7 +736,10 @@ static int input_ff_validate_effect(stru
 }
 
 /**
- * Handle effect upload
+ * input_ff_upload - handle effect upload
+ * @dev: the device
+ * @effect: the effect
+ * @file: the requester
  */
 int input_ff_upload(struct input_dev *dev, struct ff_effect *effect,
 		    struct file *file)
@@ -786,7 +825,8 @@ int input_ff_upload(struct input_dev *de
 }
 
 /**
- * Allocate the ff_device in dev->ff
+ * input_ff_allocate - allocate the ff_device in dev->ff for @dev
+ * @dev: the input device for which the ff_device is allocated
  */
 int input_ff_allocate(struct input_dev *dev)
 {
@@ -806,16 +846,18 @@ int input_ff_allocate(struct input_dev *
 }
 
 /**
- * Set the bits and handlers
- * @driver: The ff_driver struct
+ * input_ff_register - set the ff bits and handlers
+ * @dev: the input_dev struct
+ * @driver: the ff_driver struct
  *
  * If possible, this function should be called before the input device is
- * registered. It can however be ran again if the capability bits have
+ * registered. It can however be run again if the capability bits have
  * changed.
  */
 int input_ff_register(struct input_dev *dev, struct ff_driver *driver)
 {
 	int i;
+
 	debug("registering device");
 	if (!dev->ff) {
 		printk(KERN_ERR
Index: linux-2.6.17-rc4-git12/drivers/usb/input/hid-pidff.c
===================================================================
--- linux-2.6.17-rc4-git12.orig/drivers/usb/input/hid-pidff.c	2006-06-01 18:51:39.000000000 +0300
+++ linux-2.6.17-rc4-git12/drivers/usb/input/hid-pidff.c	2006-06-01 23:24:47.000000000 +0300
@@ -192,13 +192,14 @@ struct pidff_device {
 static void pidff_exit(struct hid_device *hid)
 {
 	struct pidff_device *pidff = hid->ff_private;
+
 	debug("exiting");
 	hid->ff_private = NULL;
 	kfree(pidff);
 }
 
-/**
- * Scale unsigned @i with max @max for the field @field
+/*
+ * pidff_rescale - scale unsigned @i with max @max for the field @field
  */
 static int pidff_rescale(int i, int max, struct hid_field *field)
 {
@@ -206,8 +207,8 @@ static int pidff_rescale(int i, int max,
 	    field->logical_minimum;
 }
 
-/**
- * Scale signed @i with max 0x7fff and min -0x8000 for the field @field
+/*
+ * pidff_rescale_signed - scale signed 16-bit @i for the field @field
  */
 static int pidff_rescale_signed(int i, struct hid_field *field)
 {
@@ -216,8 +217,10 @@ static int pidff_rescale_signed(int i, s
 	    field->logical_minimum / -0x8000;
 }
 
-/**
- * Scale unsigned @value for field in @usage and set it to @usage->value[0]
+/*
+ * pidff_set - scale and set unsigned @value for @usage
+ *
+ * Scale unsigned @value for field in @usage and set it to @usage->value[0].
  */
 static void pidff_set(struct pidff_usage *usage, u16 value)
 {
@@ -225,8 +228,10 @@ static void pidff_set(struct pidff_usage
 	debug("calculated from %d to %d", value, usage->value[0]);
 }
 
-/**
- * Scale signed @value for field in @usage and set it to @usage->value[0]
+/*
+ * pidff_set_signed - scale and set signed @value for @usage
+ *
+ * Scale signed @value for field in @usage and set it to @usage->value[0].
  */
 static void pidff_set_signed(struct pidff_usage *usage, s16 value)
 {
@@ -243,8 +248,8 @@ static void pidff_set_signed(struct pidf
 	debug("calculated from %d to %d", value, usage->value[0]);
 }
 
-/**
- * Send envelope report to the device
+/*
+ * pidff_set_envelope_report - send envelope report to the device
  */
 static void pidff_set_envelope_report(struct input_dev *dev,
 				      struct ff_envelope *envelope)
@@ -273,8 +278,8 @@ static void pidff_set_envelope_report(st
 	hid_submit_report(hid, pidff->reports[PID_SET_ENVELOPE], USB_DIR_OUT);
 }
 
-/**
- * Test if the @envelope differs from @old
+/*
+ * pidff_needs_set_envelope - test if the @envelope differs from @old
  */
 static int pidff_needs_set_envelope(struct ff_envelope *envelope,
 				    struct ff_envelope *old)
@@ -285,14 +290,15 @@ static int pidff_needs_set_envelope(stru
 		envelope->fade_length != old->fade_length);
 }
 
-/**
- * Send constant force report to the device
+/*
+ * pidff_set_constant_force_report - send constant force report to the device
  */
 static void pidff_set_constant_force_report(struct input_dev *dev,
 					    struct ff_effect *effect)
 {
 	struct hid_device *hid = dev->private;
 	struct pidff_device *pidff = hid->ff_private;
+
 	pidff->set_constant[PID_EFFECT_BLOCK_INDEX].value[0] =
 	    pidff->block_load[PID_EFFECT_BLOCK_INDEX].value[0];
 	pidff_set_signed(&pidff->set_constant[PID_MAGNITUDE],
@@ -301,8 +307,8 @@ static void pidff_set_constant_force_rep
 	hid_submit_report(hid, pidff->reports[PID_SET_CONSTANT], USB_DIR_OUT);
 }
 
-/**
- * Test if the constant parameters have changed between @effect and @old
+/*
+ * pidff_needs_set_constant - test if the constant parameters differ
  */
 static int pidff_needs_set_constant(struct ff_effect *effect,
 				    struct ff_effect *old)
@@ -310,14 +316,15 @@ static int pidff_needs_set_constant(stru
 	return (effect->u.constant.level != old->u.constant.level);
 }
 
-/**
- * Send set effect report to the device
+/*
+ * pidff_set_effect_report - send set effect report to the device
  */
 static void pidff_set_effect_report(struct input_dev *dev,
 				    struct ff_effect *effect)
 {
 	struct hid_device *hid = dev->private;
 	struct pidff_device *pidff = hid->ff_private;
+
 	pidff->set_effect[PID_EFFECT_BLOCK_INDEX].value[0] =
 	    pidff->block_load[PID_EFFECT_BLOCK_INDEX].value[0];
 	pidff->set_effect_type->value[0] =
@@ -336,8 +343,8 @@ static void pidff_set_effect_report(stru
 	hid_submit_report(hid, pidff->reports[PID_SET_EFFECT], USB_DIR_OUT);
 }
 
-/**
- * Test if the values used in set_effect have changed between @effect and @old
+/*
+ * pidff_needs_set_effect - test if set_effect has to be resent to the device
  */
 static int pidff_needs_set_effect(struct ff_effect *effect,
 				  struct ff_effect *old)
@@ -349,8 +356,8 @@ static int pidff_needs_set_effect(struct
 		effect->replay.delay != old->replay.delay);
 }
 
-/**
- * Send periodic effect report to the device
+/*
+ * pidff_set_periodic_report - send periodic effect report to the device
  */
 static void pidff_set_periodic_report(struct input_dev *dev,
 				      struct ff_effect *effect)
@@ -371,8 +378,8 @@ static void pidff_set_periodic_report(st
 
 }
 
-/**
- * Test if periodic effect parameters have changed between @effect and @old
+/*
+ * pidff_needs_set_periodic - test if periodic effect parameters have changed
  */
 static int pidff_needs_set_periodic(struct ff_effect *effect,
 				    struct ff_effect *old)
@@ -383,8 +390,8 @@ static int pidff_needs_set_periodic(stru
 		effect->u.periodic.period != old->u.periodic.period);
 }
 
-/**
- * Send condition effect reports to the device
+/*
+ * pidff_set_condition_report - send condition effect reports to the device
  */
 static void pidff_set_condition_report(struct input_dev *dev,
 				       struct ff_effect *effect)
@@ -417,14 +424,15 @@ static void pidff_set_condition_report(s
 
 }
 
-/**
- * Test if condition effect parameters have changed between @effect and @old
+/*
+ * pidff_needs_set_condition - test if condition effect parameters differ
  */
 static int pidff_needs_set_condition(struct ff_effect *effect,
 				     struct ff_effect *old)
 {
 	int i;
 	int ret = 0;
+
 	for (i = 0; i < 2; i++)
 		ret |=
 		    effect->u.condition[i].center != old->u.condition[i].center
@@ -441,14 +449,15 @@ static int pidff_needs_set_condition(str
 	return ret;
 }
 
-/**
- * Send ramp force report to the device
+/*
+ * pidff_set_ramp_force_report - send ramp force report to the device
  */
 static void pidff_set_ramp_force_report(struct input_dev *dev,
 					struct ff_effect *effect)
 {
 	struct hid_device *hid = dev->private;
 	struct pidff_device *pidff = hid->ff_private;
+
 	pidff->set_ramp[PID_EFFECT_BLOCK_INDEX].value[0] =
 	    pidff->block_load[PID_EFFECT_BLOCK_INDEX].value[0];
 	pidff_set_signed(&pidff->set_ramp[PID_RAMP_START],
@@ -458,8 +467,8 @@ static void pidff_set_ramp_force_report(
 	hid_submit_report(hid, pidff->reports[PID_SET_RAMP], USB_DIR_OUT);
 }
 
-/**
- * Test if ramp force parameters have changed between @effect and @old
+/*
+ * pidff_needs_set_ramp - test if ramp force parameters have changed
  */
 static int pidff_needs_set_ramp(struct ff_effect *effect, struct ff_effect *old)
 {
@@ -467,8 +476,8 @@ static int pidff_needs_set_ramp(struct f
 		effect->u.ramp.end_level != old->u.ramp.end_level);
 }
 
-/**
- * Send a request for effect upload to the device
+/*
+ * pidff_request_effect_upload - send a request for effect upload
  * @efnum: effect type number as assigned in pidff->type_id[]
  *
  * Returns 0 if device reported success, -ENOSPC if the device reported memory
@@ -516,8 +525,8 @@ static int pidff_request_effect_upload(s
 	return -EIO;
 }
 
-/**
- * Play the effect with PID id @pidid for @value times
+/*
+ * pidff_playback_pid - play the effect with PID id @pidid for @value times
  */
 static int pidff_playback_pid(struct input_dev *dev, int pid_id, int value)
 {
@@ -540,42 +549,45 @@ static int pidff_playback_pid(struct inp
 	return 0;
 }
 
-/**
- * Play the effect with effect id @effect_id for @value times
+/*
+ * pidff_playback - play the effect with effect id @effect_id for @value times
  */
 static int pidff_playback(struct input_dev *dev, int effect_id, int value)
 {
 	struct hid_device *hid = dev->private;
 	struct pidff_device *pidff = hid->ff_private;
+
 	return pidff_playback_pid(dev, pidff->pid_id[effect_id], value);
 }
 
-/**
- * Erase effect with PID id @pid_id
+/*
+ * pidff_erase_effect_pid - erase effect with PID id @pid_id
  */
 static void pidff_erase_effect_pid(struct input_dev *dev, int pid_id)
 {
 	struct hid_device *hid = dev->private;
 	struct pidff_device *pidff = hid->ff_private;
+
 	pidff->block_free[PID_EFFECT_BLOCK_INDEX].value[0] = pid_id;
 	hid_submit_report(hid, pidff->reports[PID_BLOCK_FREE], USB_DIR_OUT);
 }
 
-/**
- * Stop and erase effect with effect_id @effect_id
+/*
+ * pidff_erase_effect - stop and erase effect with effect_id @effect_id
  */
 static int pidff_erase_effect(struct input_dev *dev, int effect_id)
 {
 	struct hid_device *hid = dev->private;
 	struct pidff_device *pidff = hid->ff_private;
+
 	debug("starting to erase %d/%d", effect_id, pidff->pid_id[effect_id]);
 	pidff_playback(dev, effect_id, 0);
 	pidff_erase_effect_pid(dev, pidff->pid_id[effect_id]);
 	return 0;
 }
 
-/**
- * Effect upload handler
+/*
+ * pidff_upload_effect - effect upload handler
  */
 static int pidff_upload_effect(struct input_dev *dev, struct ff_effect *effect,
 			       struct ff_effect *old)
@@ -749,21 +761,21 @@ static int pidff_upload_effect(struct in
 	return 0;
 }
 
-/**
- * set_gain() handler
+/*
+ * pidff_set_gain - set_gain() handler
  */
 static void pidff_set_gain(struct input_dev *dev, u16 gain)
 {
 	struct hid_device *hid = dev->private;
 	struct pidff_device *pidff = hid->ff_private;
+
 	pidff_set(&pidff->device_gain[PID_DEVICE_GAIN_FIELD], gain);
 	hid_submit_report(hid, pidff->reports[PID_DEVICE_GAIN], USB_DIR_OUT);
 	return;
-
 }
 
-/**
- * set_autocenter() handler
+/*
+ * pidff_set_autocenter - set_autocenter() handler
  */
 static void pidff_set_autocenter(struct input_dev *dev, u16 magnitude)
 {
@@ -791,16 +803,15 @@ static void pidff_set_autocenter(struct 
 	pidff->set_effect[PID_START_DELAY].value[0] = 0;
 
 	hid_submit_report(hid, pidff->reports[PID_SET_EFFECT], USB_DIR_OUT);
-
 }
 
-/**
- * Find fields from a report and fill a pidff_usage
- * @usage: The pidff_usage to fill
- * @table: The table that contains the fields to search
- * @report: The report where the fields are searched
- * count: sizeof(table)
- * strict: Fail if some field is not found
+/*
+ * pidff_find_fields - find fields from a report and fill a pidff_usage
+ * @usage: the pidff_usage to fill
+ * @table: the table that contains the fields to search
+ * @report: the report where the fields are searched
+ * @count: sizeof(table)
+ * @strict: fail if some field is not found
  */
 static int pidff_find_fields(struct pidff_usage *usage, u8 * table,
 			     struct hid_report *report, int count, int strict)
@@ -838,8 +849,8 @@ static int pidff_find_fields(struct pidf
 	return 0;
 }
 
-/**
- * Return index into pidff_reports for the usage @usage
+/*
+ * pidff_check_usage - return index into pidff_reports for the usage @usage
  */
 static int pidff_check_usage(int usage)
 {
@@ -853,8 +864,8 @@ static int pidff_check_usage(int usage)
 	return -1;
 }
 
-/**
- * Find the reports and fill pidff->reports[]
+/*
+ * pidff_find_reports - find the reports and fill pidff->reports[]
  * @report_type: OUTPUT or FEATURE reports
  */
 static void pidff_find_reports(struct input_dev *dev, int report_type)
@@ -896,8 +907,8 @@ static void pidff_find_reports(struct in
 	}
 }
 
-/**
- * Test if the required reports have been found
+/*
+ * pidff_reports_ok - test if the required reports have been found
  */
 static int pidff_reports_ok(struct input_dev *dev)
 {
@@ -914,16 +925,17 @@ static int pidff_reports_ok(struct input
 	return 1;
 }
 
-/**
- * Find a field with a specific usage within a report
- * @report: The report from where to find
- * @usage: The wanted usage
+/*
+ * pidff_find_logical_field - find a field with a specific logical usage
+ * @report: the report from where to find
+ * @usage: the wanted usage
  * @enforce_min: logical_minimum should be 1, otherwise return NULL
  */
 static struct hid_field *pidff_find_special_field(struct hid_report *report,
 						  int usage, int enforce_min)
 {
 	int i;
+
 	for (i = 0; i < report->maxfield; i++) {
 		if (report->field[i]->logical == (HID_UP_PID | usage)
 		    && report->field[i]->report_count > 0) {
@@ -940,19 +952,19 @@ static struct hid_field *pidff_find_spec
 	return NULL;
 }
 
-/**
- * Fill a pidff->*_id struct table
- * @keys: The table that is to be filled
- * @field: The field from where to find the values
- * @usagetable: The table where the wanted values are listed
+/*
+ * pidff_find_special_keys - fill a pidff->*_id struct table
+ * @keys: the table that is to be filled
+ * @field: the field from where to find the values
+ * @usagetable: the table where the wanted values are listed
  * @count: sizeof(usagetable)
  */
 static int pidff_find_special_keys(int *keys, struct hid_field *field,
 				   u8 * usagetable, int count)
 {
-
 	int i, j;
 	int found = 0;
+
 	for (i = 0; i < count; i++) {
 		for (j = 0; j < field->maxusage; j++) {
 			if (field->usage[j].hid == (HID_UP_PID | usagetable[i])) {
@@ -969,8 +981,8 @@ static int pidff_find_special_keys(int *
 	pidff_find_special_keys(pidff->keys, pidff->field, pidff_ ## name, \
 		sizeof(pidff_ ## name))
 
-/**
- * Find and check the special fields
+/*
+ * pidff_find_special_fields - find and check the special fields
  */
 static int pidff_find_special_fields(struct pidff_device *pidff)
 {
@@ -1047,8 +1059,8 @@ static int pidff_find_special_fields(str
 	return 0;
 }
 
-/**
- * Find the implemented effect types
+/*
+ * pidff_find_effects - find the implemented effect types
  */
 static int pidff_find_effects(struct input_dev *dev)
 {
@@ -1102,7 +1114,6 @@ static int pidff_find_effects(struct inp
 		set_bit(FF_FRICTION, ff->flags);
 
 	return 0;
-
 }
 
 #define PIDFF_FIND_FIELDS(name, report, strict) \
@@ -1110,8 +1121,8 @@ static int pidff_find_effects(struct inp
 		pidff->reports[report], \
 		sizeof(pidff_ ## name), strict)
 
-/**
- * Fill and check the pidff_usages
+/*
+ * pidff_init_fields - fill and check the pidff_usages
  */
 static int pidff_init_fields(struct input_dev *dev)
 {
@@ -1204,8 +1215,8 @@ static int pidff_init_fields(struct inpu
 	return 0;
 }
 
-/**
- * Reset the device
+/*
+ * pidff_reset - reset the device
  */
 static void pidff_reset(struct input_dev *dev)
 {
@@ -1246,8 +1257,8 @@ static void pidff_reset(struct input_dev
 	}
 }
 
-/**
- * Test if autocenter modification is using the supported method
+/*
+ * pidff_check_autocenter - test if autocenter modification is supported
  */
 static int pidff_check_autocenter(struct input_dev *dev)
 {
@@ -1295,7 +1306,8 @@ static struct ff_driver pidff_driver = {
 };
 
 /**
- * Check if the device is PID and initialize it
+ * pidff_init - check if the device is PID and initialize it
+ * @hid: the HID device
  */
 int pidff_init(struct hid_device *hid)
 {
@@ -1306,6 +1318,7 @@ int pidff_init(struct hid_device *hid)
 	    list_entry(hid->inputs.next, struct hid_input, list);
 	struct input_dev *dev = hidinput->input;
 	struct ff_device *ff;
+
 	debug("starting pid init");
 
 	if (list_empty(&hid->report_enum[HID_OUTPUT_REPORT].report_list)) {
