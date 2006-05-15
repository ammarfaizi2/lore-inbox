Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965236AbWEOVQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965236AbWEOVQt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 17:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965243AbWEOVQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 17:16:19 -0400
Received: from pne-smtpout3-sn2.hy.skanova.net ([81.228.8.111]:30421 "EHLO
	pne-smtpout3-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S965236AbWEOVPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 17:15:44 -0400
Message-Id: <20060515211508.783811000@gmail.com>
References: <20060515211229.521198000@gmail.com>
User-Agent: quilt/0.44-1
Date: Tue, 16 May 2006 00:12:35 +0300
From: Anssi Hannula <anssi.hannula@gmail.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-joystick@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [patch 06/11] input: adapt iforce driver for the new force feedback interface
Content-Disposition: inline; filename=ff-refactoring-iforce-to-new-interface.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Modify the iforce driver for the new force feedback interface.

Signed-off-by: Anssi Hannula <anssi.hannula@gmail.com>

---
 drivers/input/joystick/iforce/Kconfig       |    2 
 drivers/input/joystick/iforce/iforce-ff.c   |   61 +++------
 drivers/input/joystick/iforce/iforce-main.c |  188 ++++++++--------------------
 drivers/input/joystick/iforce/iforce.h      |   15 --
 4 files changed, 87 insertions(+), 179 deletions(-)

Index: linux-2.6.17-rc4-git1/drivers/input/joystick/iforce/iforce-ff.c
===================================================================
--- linux-2.6.17-rc4-git1.orig/drivers/input/joystick/iforce/iforce-ff.c	2006-05-14 01:36:21.000000000 +0300
+++ linux-2.6.17-rc4-git1/drivers/input/joystick/iforce/iforce-ff.c	2006-05-14 01:42:00.000000000 +0300
@@ -198,10 +198,8 @@ static unsigned char find_button(struct 
  * Analyse the changes in an effect, and tell if we need to send an condition
  * parameter packet
  */
-static int need_condition_modifier(struct iforce* iforce, struct ff_effect* new)
+static int need_condition_modifier(struct ff_effect* old, struct ff_effect* new)
 {
-	int id = new->id;
-	struct ff_effect* old = &iforce->core_effects[id].effect;
 	int ret=0;
 	int i;
 
@@ -225,11 +223,8 @@ static int need_condition_modifier(struc
  * Analyse the changes in an effect, and tell if we need to send a magnitude
  * parameter packet
  */
-static int need_magnitude_modifier(struct iforce* iforce, struct ff_effect* effect)
+static int need_magnitude_modifier(struct ff_effect* old, struct ff_effect* effect)
 {
-	int id = effect->id;
-	struct ff_effect* old = &iforce->core_effects[id].effect;
-
 	if (effect->type != FF_CONSTANT) {
 		printk(KERN_WARNING "iforce.c: bad effect type in need_envelope_modifier\n");
 		return FALSE;
@@ -242,11 +237,8 @@ static int need_magnitude_modifier(struc
  * Analyse the changes in an effect, and tell if we need to send an envelope
  * parameter packet
  */
-static int need_envelope_modifier(struct iforce* iforce, struct ff_effect* effect)
+static int need_envelope_modifier(struct ff_effect* old, struct ff_effect* effect)
 {
-	int id = effect->id;
-	struct ff_effect* old = &iforce->core_effects[id].effect;
-
 	switch (effect->type) {
 	case FF_CONSTANT:
 		if (old->u.constant.envelope.attack_length != effect->u.constant.envelope.attack_length
@@ -275,16 +267,12 @@ static int need_envelope_modifier(struct
  * Analyse the changes in an effect, and tell if we need to send a periodic
  * parameter effect
  */
-static int need_period_modifier(struct iforce* iforce, struct ff_effect* new)
+static int need_period_modifier(struct ff_effect* old, struct ff_effect* new)
 {
-	int id = new->id;
-	struct ff_effect* old = &iforce->core_effects[id].effect;
-
 	if (new->type != FF_PERIODIC) {
-		printk(KERN_WARNING "iforce.c: bad effect type in need_periodic_modifier\n");
+		printk(KERN_WARNING "iforce.c: bad effect type in need_period_modifier\n");
 		return FALSE;
 	}
-
 	return (old->u.periodic.period != new->u.periodic.period
 		|| old->u.periodic.magnitude != new->u.periodic.magnitude
 		|| old->u.periodic.offset != new->u.periodic.offset
@@ -295,11 +283,8 @@ static int need_period_modifier(struct i
  * Analyse the changes in an effect, and tell if we need to send an effect
  * packet
  */
-static int need_core(struct iforce* iforce, struct ff_effect* new)
+static int need_core(struct ff_effect* old, struct ff_effect* new)
 {
-	int id = new->id;
-	struct ff_effect* old = &iforce->core_effects[id].effect;
-
 	if (old->direction != new->direction
 		|| old->trigger.button != new->trigger.button
 		|| old->trigger.interval != new->trigger.interval
@@ -360,7 +345,7 @@ static int make_core(struct iforce* ifor
  * Upload a periodic effect to the device
  * See also iforce_upload_constant.
  */
-int iforce_upload_periodic(struct iforce* iforce, struct ff_effect* effect, int is_update)
+int iforce_upload_periodic(struct iforce* iforce, struct ff_effect* effect, struct ff_effect *old)
 {
 	u8 wave_code;
 	int core_id = effect->id;
@@ -371,18 +356,18 @@ int iforce_upload_periodic(struct iforce
 	int param2_err = 1;
 	int core_err = 0;
 
-	if (!is_update || need_period_modifier(iforce, effect)) {
+	if (!old || need_period_modifier(old, effect)) {
 		param1_err = make_period_modifier(iforce, mod1_chunk,
-			is_update,
+			old ? 1 : 0,
 			effect->u.periodic.magnitude, effect->u.periodic.offset,
 			effect->u.periodic.period, effect->u.periodic.phase);
 		if (param1_err) return param1_err;
 		set_bit(FF_MOD1_IS_USED, core_effect->flags);
 	}
 
-	if (!is_update || need_envelope_modifier(iforce, effect)) {
+	if (!old || need_envelope_modifier(old, effect)) {
 		param2_err = make_envelope_modifier(iforce, mod2_chunk,
-			is_update,
+			old ? 1 : 0,
 			effect->u.periodic.envelope.attack_length,
 			effect->u.periodic.envelope.attack_level,
 			effect->u.periodic.envelope.fade_length,
@@ -400,7 +385,7 @@ int iforce_upload_periodic(struct iforce
 		default:		wave_code = 0x20; break;
 	}
 
-	if (!is_update || need_core(iforce, effect)) {
+	if (!old || need_core(old, effect)) {
 		core_err = make_core(iforce, effect->id,
 			mod1_chunk->start,
 			mod2_chunk->start,
@@ -429,7 +414,7 @@ int iforce_upload_periodic(struct iforce
  *  0 Ok, effect created or updated
  *  1 effect did not change since last upload, and no packet was therefore sent
  */
-int iforce_upload_constant(struct iforce* iforce, struct ff_effect* effect, int is_update)
+int iforce_upload_constant(struct iforce* iforce, struct ff_effect* effect, struct ff_effect* old)
 {
 	int core_id = effect->id;
 	struct iforce_core_effect* core_effect = iforce->core_effects + core_id;
@@ -439,17 +424,17 @@ int iforce_upload_constant(struct iforce
 	int param2_err = 1;
 	int core_err = 0;
 
-	if (!is_update || need_magnitude_modifier(iforce, effect)) {
+	if (!old || need_magnitude_modifier(old, effect)) {
 		param1_err = make_magnitude_modifier(iforce, mod1_chunk,
-			is_update,
+			old ? 1 : 0,
 			effect->u.constant.level);
 		if (param1_err) return param1_err;
 		set_bit(FF_MOD1_IS_USED, core_effect->flags);
 	}
 
-	if (!is_update || need_envelope_modifier(iforce, effect)) {
+	if (!old || need_envelope_modifier(old, effect)) {
 		param2_err = make_envelope_modifier(iforce, mod2_chunk,
-			is_update,
+			old ? 1 : 0,
 			effect->u.constant.envelope.attack_length,
 			effect->u.constant.envelope.attack_level,
 			effect->u.constant.envelope.fade_length,
@@ -458,7 +443,7 @@ int iforce_upload_constant(struct iforce
 		set_bit(FF_MOD2_IS_USED, core_effect->flags);
 	}
 
-	if (!is_update || need_core(iforce, effect)) {
+	if (!old || need_core(old, effect)) {
 		core_err = make_core(iforce, effect->id,
 			mod1_chunk->start,
 			mod2_chunk->start,
@@ -483,7 +468,7 @@ int iforce_upload_constant(struct iforce
 /*
  * Upload an condition effect. Those are for example friction, inertia, springs...
  */
-int iforce_upload_condition(struct iforce* iforce, struct ff_effect* effect, int is_update)
+int iforce_upload_condition(struct iforce* iforce, struct ff_effect* effect, struct ff_effect* old)
 {
 	int core_id = effect->id;
 	struct iforce_core_effect* core_effect = iforce->core_effects + core_id;
@@ -499,9 +484,9 @@ int iforce_upload_condition(struct iforc
 		default: return -1;
 	}
 
-	if (!is_update || need_condition_modifier(iforce, effect)) {
+	if (!old || need_condition_modifier(old, effect)) {
 		param_err = make_condition_modifier(iforce, mod1_chunk,
-			is_update,
+			old ? 1 : 0,
 			effect->u.condition[0].right_saturation,
 			effect->u.condition[0].left_saturation,
 			effect->u.condition[0].right_coeff,
@@ -512,7 +497,7 @@ int iforce_upload_condition(struct iforc
 		set_bit(FF_MOD1_IS_USED, core_effect->flags);
 
 		param_err = make_condition_modifier(iforce, mod2_chunk,
-			is_update,
+			old ? 1 : 0,
 			effect->u.condition[1].right_saturation,
 			effect->u.condition[1].left_saturation,
 			effect->u.condition[1].right_coeff,
@@ -524,7 +509,7 @@ int iforce_upload_condition(struct iforc
 
 	}
 
-	if (!is_update || need_core(iforce, effect)) {
+	if (!old || need_core(old, effect)) {
 		core_err = make_core(iforce, effect->id,
 			mod1_chunk->start, mod2_chunk->start,
 			type, 0xc0,
Index: linux-2.6.17-rc4-git1/drivers/input/joystick/iforce/iforce.h
===================================================================
--- linux-2.6.17-rc4-git1.orig/drivers/input/joystick/iforce/iforce.h	2006-05-14 01:36:21.000000000 +0300
+++ linux-2.6.17-rc4-git1/drivers/input/joystick/iforce/iforce.h	2006-05-14 01:42:00.000000000 +0300
@@ -55,7 +55,7 @@
 #define FALSE 0
 #define TRUE 1
 
-#define FF_EFFECTS_MAX	32
+#define IFORCE_EFFECTS_MAX	32
 
 /* Each force feedback effect is made of one core effect, which can be
  * associated to at most to effect modifiers
@@ -79,13 +79,6 @@ struct iforce_core_effect {
 	struct resource mod1_chunk;
 	struct resource mod2_chunk;
 	unsigned long flags[NBITS(FF_MODCORE_MAX)];
-	pid_t owner;
-	/* Used to keep track of parameters of an effect. They are needed
-	 * to know what parts of an effect changed in an update operation.
-	 * We try to send only parameter packets if possible, as sending
-	 * effect parameter requires the effect to be stoped and restarted
-	 */
-	struct ff_effect effect;
 };
 
 #define FF_CMD_EFFECT		0x010e
@@ -183,9 +176,9 @@ void iforce_dump_packet(char *msg, u16 c
 int iforce_get_id_packet(struct iforce *iforce, char *packet);
 
 /* iforce-ff.c */
-int iforce_upload_periodic(struct iforce*, struct ff_effect*, int is_update);
-int iforce_upload_constant(struct iforce*, struct ff_effect*, int is_update);
-int iforce_upload_condition(struct iforce*, struct ff_effect*, int is_update);
+int iforce_upload_periodic(struct iforce*, struct ff_effect*, struct ff_effect* old);
+int iforce_upload_constant(struct iforce*, struct ff_effect*, struct ff_effect* old);
+int iforce_upload_condition(struct iforce*, struct ff_effect*, struct ff_effect* old);
 
 /* Public variables */
 extern struct serio_driver iforce_serio_drv;
Index: linux-2.6.17-rc4-git1/drivers/input/joystick/iforce/iforce-main.c
===================================================================
--- linux-2.6.17-rc4-git1.orig/drivers/input/joystick/iforce/iforce-main.c	2006-05-14 01:36:21.000000000 +0300
+++ linux-2.6.17-rc4-git1/drivers/input/joystick/iforce/iforce-main.c	2006-05-14 01:42:00.000000000 +0300
@@ -82,103 +82,57 @@ static struct iforce_device iforce_devic
 	{ 0x0000, 0x0000, "Unknown I-Force Device [%04x:%04x]",		btn_joystick, abs_joystick, ff_iforce }
 };
 
+static int iforce_playback(struct input_dev *dev, int effect_id, int value)
+{
+	struct iforce* iforce = (struct iforce*)(dev->private);
+	if (value > 0) {
+		set_bit(FF_CORE_SHOULD_PLAY, iforce->core_effects[effect_id].flags);
+	}
+	else {
+		clear_bit(FF_CORE_SHOULD_PLAY, iforce->core_effects[effect_id].flags);
+	}
 
+	iforce_control_playback(iforce, effect_id, value);
+	return 0;
+}
 
-static int iforce_input_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
+static void iforce_set_gain(struct input_dev *dev, u16 gain)
 {
 	struct iforce* iforce = (struct iforce*)(dev->private);
 	unsigned char data[3];
+	data[0] = gain >> 9;
+	iforce_send_packet(iforce, FF_CMD_GAIN, data);
+}
 
-	if (type != EV_FF)
-		return -1;
-
-	switch (code) {
-
-		case FF_GAIN:
-
-			data[0] = value >> 9;
-			iforce_send_packet(iforce, FF_CMD_GAIN, data);
-
-			return 0;
-
-		case FF_AUTOCENTER:
-
-			data[0] = 0x03;
-			data[1] = value >> 9;
-			iforce_send_packet(iforce, FF_CMD_AUTOCENTER, data);
-
-			data[0] = 0x04;
-			data[1] = 0x01;
-			iforce_send_packet(iforce, FF_CMD_AUTOCENTER, data);
-
-			return 0;
-
-		default: /* Play or stop an effect */
-
-			if (!CHECK_OWNERSHIP(code, iforce)) {
-				return -1;
-			}
-			if (value > 0) {
-				set_bit(FF_CORE_SHOULD_PLAY, iforce->core_effects[code].flags);
-			}
-			else {
-				clear_bit(FF_CORE_SHOULD_PLAY, iforce->core_effects[code].flags);
-			}
-
-			iforce_control_playback(iforce, code, value);
-			return 0;
-	}
-
-	return -1;
+static void iforce_set_autocenter(struct input_dev *dev, u16 magnitude)
+{
+	struct iforce* iforce = (struct iforce*)(dev->private);
+	unsigned char data[3];
+	data[0] = 0x03;
+	data[1] = magnitude >> 9;
+	iforce_send_packet(iforce, FF_CMD_AUTOCENTER, data);
+
+	data[0] = 0x04;
+	data[1] = 0x01;
+	iforce_send_packet(iforce, FF_CMD_AUTOCENTER, data);
 }
 
 /*
  * Function called when an ioctl is performed on the event dev entry.
  * It uploads an effect to the device
  */
-static int iforce_upload_effect(struct input_dev *dev, struct ff_effect *effect)
+static int iforce_upload_effect(struct input_dev *dev, struct ff_effect *effect, struct ff_effect *old)
 {
 	struct iforce* iforce = (struct iforce*)(dev->private);
-	int id;
 	int ret;
-	int is_update;
-
-/* Check this effect type is supported by this device */
-	if (!test_bit(effect->type, iforce->dev->ffbit))
-		return -EINVAL;
-
-/*
- * If we want to create a new effect, get a free id
- */
-	if (effect->id == -1) {
-
-		for (id = 0; id < FF_EFFECTS_MAX; ++id)
-			if (!test_and_set_bit(FF_CORE_IS_USED, iforce->core_effects[id].flags))
-				break;
-
-		if (id == FF_EFFECTS_MAX || id >= iforce->dev->ff_effects_max)
-			return -ENOMEM;
 
-		effect->id = id;
-		iforce->core_effects[id].owner = current->pid;
-		iforce->core_effects[id].flags[0] = (1 << FF_CORE_IS_USED);	/* Only IS_USED bit must be set */
-
-		is_update = FALSE;
+	if (!old) {
+		iforce->core_effects[effect->id].flags[0] = (1 << FF_CORE_IS_USED);	/* Only IS_USED bit must be set */
 	}
 	else {
-		/* We want to update an effect */
-		if (!CHECK_OWNERSHIP(effect->id, iforce))
-			return -EACCES;
-
-		/* Parameter type cannot be updated */
-		if (effect->type != iforce->core_effects[effect->id].effect.type)
-			return -EINVAL;
-
 		/* Check the effect is not already being updated */
 		if (test_bit(FF_CORE_UPDATE, iforce->core_effects[effect->id].flags))
 			return -EAGAIN;
-
-		is_update = TRUE;
 	}
 
 /*
@@ -187,16 +141,16 @@ static int iforce_upload_effect(struct i
 	switch (effect->type) {
 
 		case FF_PERIODIC:
-			ret = iforce_upload_periodic(iforce, effect, is_update);
+			ret = iforce_upload_periodic(iforce, effect, old);
 			break;
 
 		case FF_CONSTANT:
-			ret = iforce_upload_constant(iforce, effect, is_update);
+			ret = iforce_upload_constant(iforce, effect, old);
 			break;
 
 		case FF_SPRING:
 		case FF_DAMPER:
-			ret = iforce_upload_condition(iforce, effect, is_update);
+			ret = iforce_upload_condition(iforce, effect, old);
 			break;
 
 		default:
@@ -208,7 +162,6 @@ static int iforce_upload_effect(struct i
 		 */
 		set_bit(FF_CORE_UPDATE, iforce->core_effects[effect->id].flags);
 	}
-	iforce->core_effects[effect->id].effect = *effect;
 	return ret;
 }
 
@@ -222,15 +175,6 @@ static int iforce_erase_effect(struct in
 	int err = 0;
 	struct iforce_core_effect* core_effect;
 
-	/* Check who is trying to erase this effect */
-	if (iforce->core_effects[effect_id].owner != current->pid) {
-		printk(KERN_WARNING "iforce-main.c: %d tried to erase an effect belonging to %d\n", current->pid, iforce->core_effects[effect_id].owner);
-		return -EACCES;
-	}
-
-	if (effect_id < 0 || effect_id >= FF_EFFECTS_MAX)
-		return -EINVAL;
-
 	core_effect = iforce->core_effects + effect_id;
 
 	if (test_bit(FF_MOD1_IS_USED, core_effect->flags))
@@ -265,30 +209,6 @@ static int iforce_open(struct input_dev 
 	return 0;
 }
 
-static int iforce_flush(struct input_dev *dev, struct file *file)
-{
-	struct iforce *iforce = dev->private;
-	int i;
-
-	/* Erase all effects this process owns */
-	for (i=0; i<dev->ff_effects_max; ++i) {
-
-		if (test_bit(FF_CORE_IS_USED, iforce->core_effects[i].flags) &&
-			current->pid == iforce->core_effects[i].owner) {
-
-			/* Stop effect */
-			input_report_ff(dev, i, 0);
-
-			/* Free ressources assigned to effect */
-			if (iforce_erase_effect(dev, i)) {
-				printk(KERN_WARNING "iforce_flush: erase effect %d failed\n", i);
-			}
-		}
-
-	}
-	return 0;
-}
-
 static void iforce_release(struct input_dev *dev)
 {
 	struct iforce *iforce = dev->private;
@@ -302,7 +222,6 @@ static void iforce_release(struct input_
 	if (i<dev->ff_effects_max) {
 		printk(KERN_WARNING "iforce_release: Device still owns effects\n");
 	}
-
 	/* Disable force feedback playback */
 	iforce_send_packet(iforce, FF_CMD_ENABLE, "\001");
 
@@ -338,11 +257,19 @@ void iforce_delete_device(struct iforce 
 	}
 }
 
+static struct ff_driver iforce_ff_driver = {
+	.upload = iforce_upload_effect,
+	.erase	= iforce_erase_effect,
+	.set_gain = iforce_set_gain,
+	.set_autocenter = iforce_set_autocenter,
+	.playback = iforce_playback,
+};
+
 int iforce_init_device(struct iforce *iforce)
 {
 	struct input_dev *input_dev;
 	unsigned char c[] = "CEOV";
-	int i;
+	int i, ff_err;
 
 	input_dev = input_allocate_device();
 	if (!input_dev)
@@ -354,6 +281,8 @@ int iforce_init_device(struct iforce *if
 	iforce->xmit.buf = iforce->xmit_data;
 	iforce->dev = input_dev;
 
+	ff_err = input_ff_allocate(input_dev);
+
 /*
  * Input device fields.
  */
@@ -377,11 +306,8 @@ int iforce_init_device(struct iforce *if
 	input_dev->name = "Unknown I-Force device";
 	input_dev->open = iforce_open;
 	input_dev->close = iforce_release;
-	input_dev->flush = iforce_flush;
-	input_dev->event = iforce_input_event;
-	input_dev->upload_effect = iforce_upload_effect;
-	input_dev->erase_effect = iforce_erase_effect;
-	input_dev->ff_effects_max = 10;
+	if (!ff_err)
+		input_dev->ff_effects_max = 10;
 
 /*
  * On-device memory allocation.
@@ -428,16 +354,17 @@ int iforce_init_device(struct iforce *if
 	else
 		printk(KERN_WARNING "iforce-main.c: Device does not respond to id packet B\n");
 
-	if (!iforce_get_id_packet(iforce, "N"))
-		iforce->dev->ff_effects_max = iforce->edata[1];
-	else
+	if (!iforce_get_id_packet(iforce, "N")) {
+		if (!ff_err)
+			iforce->dev->ff_effects_max = iforce->edata[1];
+	} else
 		printk(KERN_WARNING "iforce-main.c: Device does not respond to id packet N\n");
 
 	/* Check if the device can store more effects than the driver can really handle */
-	if (iforce->dev->ff_effects_max > FF_EFFECTS_MAX) {
+	if (!ff_err && iforce->dev->ff_effects_max > IFORCE_EFFECTS_MAX) {
 		printk(KERN_WARNING "input??: Device can handle %d effects, but N_EFFECTS_MAX is set to %d in iforce.h\n",
-			iforce->dev->ff_effects_max, FF_EFFECTS_MAX);
-		iforce->dev->ff_effects_max = FF_EFFECTS_MAX;
+		       iforce->dev->ff_effects_max, IFORCE_EFFECTS_MAX);
+		iforce->dev->ff_effects_max = IFORCE_EFFECTS_MAX;
 	}
 
 /*
@@ -471,7 +398,7 @@ int iforce_init_device(struct iforce *if
  * Set input device bitfields and ranges.
  */
 
-	input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_ABS) | BIT(EV_FF) | BIT(EV_FF_STATUS);
+	input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_ABS) | BIT(EV_FF_STATUS);
 
 	for (i = 0; iforce->type->btn[i] >= 0; i++) {
 		signed short t = iforce->type->btn[i];
@@ -515,8 +442,11 @@ int iforce_init_device(struct iforce *if
 		}
 	}
 
-	for (i = 0; iforce->type->ff[i] >= 0; i++)
-		set_bit(iforce->type->ff[i], input_dev->ffbit);
+	if (!ff_err) {
+		for (i = 0; iforce->type->ff[i] >= 0; i++)
+			set_bit(iforce->type->ff[i], input_dev->ff->flags);
+		input_ff_register(input_dev, &iforce_ff_driver);
+	}
 
 /*
  * Register input device.
Index: linux-2.6.17-rc4-git1/drivers/input/joystick/iforce/Kconfig
===================================================================
--- linux-2.6.17-rc4-git1.orig/drivers/input/joystick/iforce/Kconfig	2006-05-15 22:16:40.000000000 +0300
+++ linux-2.6.17-rc4-git1/drivers/input/joystick/iforce/Kconfig	2006-05-15 22:16:56.000000000 +0300
@@ -3,7 +3,7 @@
 #
 config JOYSTICK_IFORCE
 	tristate "I-Force devices"
-	depends on INPUT && INPUT_JOYSTICK
+	depends on INPUT && INPUT_JOYSTICK && (INPUT_FF_EFFECTS || INPUT_FF_EFFECTS=n)
 	help
 	  Say Y here if you have an I-Force joystick or steering wheel
 

--
Anssi Hannula
