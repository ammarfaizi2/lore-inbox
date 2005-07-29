Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262552AbVG2J6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262552AbVG2J6c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 05:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262549AbVG2J4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 05:56:35 -0400
Received: from tim.rpsys.net ([194.106.48.114]:5568 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S262555AbVG2JrW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 05:47:22 -0400
Subject: [patch 8/8] Input: Add a new switch event type
From: Richard Purdie <rpurdie@rpsys.net>
To: akpm@osdl.org
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 29 Jul 2005 10:47:06 +0100
Message-Id: <1122630426.7747.99.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The corgi keyboard has need of a switch event type with slightly 
different properties to a standard key. This adds such an event 
type to the input system as recommended by the input maintainer.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

Index: linux-2.6.12/drivers/input/keyboard/corgikbd.c
===================================================================
--- linux-2.6.12.orig/drivers/input/keyboard/corgikbd.c	2005-07-28 17:01:08.000000000 +0100
+++ linux-2.6.12/drivers/input/keyboard/corgikbd.c	2005-07-28 17:01:59.000000000 +0100
@@ -249,9 +249,8 @@
 		if (hinge_count >= HINGE_STABLE_COUNT) {
 			spin_lock_irqsave(&corgikbd_data->lock, flags);
 
-			input_report_key(&corgikbd_data->input, corgikbd_data->keycode[125], (sharpsl_hinge_state == 0x00));
-			input_report_key(&corgikbd_data->input, corgikbd_data->keycode[126], (sharpsl_hinge_state == 0x08));
-			input_report_key(&corgikbd_data->input, corgikbd_data->keycode[127], (sharpsl_hinge_state == 0x0c));
+			input_report_switch(&corgikbd_data->input, SW_0, ((sharpsl_hinge_state & CORGI_SCP_SWA) != 0));
+			input_report_switch(&corgikbd_data->input, SW_1, ((sharpsl_hinge_state & CORGI_SCP_SWB) != 0));
 			input_sync(&corgikbd_data->input);
 
 			spin_unlock_irqrestore(&corgikbd_data->lock, flags);
@@ -321,7 +320,7 @@
 	corgikbd->input.id.vendor = 0x0001;
 	corgikbd->input.id.product = 0x0001;
 	corgikbd->input.id.version = 0x0100;
-	corgikbd->input.evbit[0] = BIT(EV_KEY) | BIT(EV_REP) | BIT(EV_PWR);
+	corgikbd->input.evbit[0] = BIT(EV_KEY) | BIT(EV_REP) | BIT(EV_PWR) | BIT(EV_SW);
 	corgikbd->input.keycode = corgikbd->keycode;
 	corgikbd->input.keycodesize = sizeof(unsigned char);
 	corgikbd->input.keycodemax = ARRAY_SIZE(corgikbd_keycode);
@@ -330,6 +329,8 @@
 	for (i = 0; i < ARRAY_SIZE(corgikbd_keycode); i++)
 		set_bit(corgikbd->keycode[i], corgikbd->input.keybit);
 	clear_bit(0, corgikbd->input.keybit);
+	set_bit(SW_0, corgikbd->input.swbit);
+	set_bit(SW_1, corgikbd->input.swbit);
 
 	input_register_device(&corgikbd->input);
 	mod_timer(&corgikbd->htimer, jiffies + HINGE_SCAN_INTERVAL);
Index: linux-2.6.12/drivers/input/evdev.c
===================================================================
--- linux-2.6.12.orig/drivers/input/evdev.c	2005-07-28 15:18:23.000000000 +0100
+++ linux-2.6.12/drivers/input/evdev.c	2005-07-28 17:01:59.000000000 +0100
@@ -391,6 +391,7 @@
 						case EV_LED: bits = dev->ledbit; len = LED_MAX; break;
 						case EV_SND: bits = dev->sndbit; len = SND_MAX; break;
 						case EV_FF:  bits = dev->ffbit;  len = FF_MAX;  break;
+						case EV_SW:  bits = dev->swbit;  len = SW_MAX;  break;
 						default: return -EINVAL;
 					}
 					len = NBITS(len) * sizeof(long);
@@ -419,6 +420,13 @@
 					return copy_to_user(p, dev->snd, len) ? -EFAULT : len;
 				}
 
+				if (_IOC_NR(cmd) == _IOC_NR(EVIOCGSW(0))) {
+					int len;
+					len = NBITS(SW_MAX) * sizeof(long);
+					if (len > _IOC_SIZE(cmd)) len = _IOC_SIZE(cmd);
+					return copy_to_user(p, dev->sw, len) ? -EFAULT : len;
+				}
+
 				if (_IOC_NR(cmd) == _IOC_NR(EVIOCGNAME(0))) {
 					int len;
 					if (!dev->name) return -ENOENT;
Index: linux-2.6.12/drivers/input/input.c
===================================================================
--- linux-2.6.12.orig/drivers/input/input.c	2005-07-28 15:18:23.000000000 +0100
+++ linux-2.6.12/drivers/input/input.c	2005-07-28 17:01:59.000000000 +0100
@@ -89,6 +89,15 @@
 
 			break;
 
+		case EV_SW:
+
+			if (code > SW_MAX || !test_bit(code, dev->swbit) || !!test_bit(code, dev->sw) == value)
+				return;
+
+			change_bit(code, dev->sw);
+
+			break;
+
 		case EV_ABS:
 
 			if (code > ABS_MAX || !test_bit(code, dev->absbit))
@@ -402,6 +411,7 @@
 	SPRINTF_BIT_A2(ledbit, "LED=", LED_MAX, EV_LED);
 	SPRINTF_BIT_A2(sndbit, "SND=", SND_MAX, EV_SND);
 	SPRINTF_BIT_A2(ffbit,  "FF=",  FF_MAX, EV_FF);
+	SPRINTF_BIT_A2(swbit,  "SW=",  SW_MAX, EV_SW);
 
 	envp[i++] = NULL;
 
@@ -490,6 +500,7 @@
 		SPRINTF_BIT_B2(ledbit, "LED=", LED_MAX, EV_LED);
 		SPRINTF_BIT_B2(sndbit, "SND=", SND_MAX, EV_SND);
 		SPRINTF_BIT_B2(ffbit,  "FF=",  FF_MAX, EV_FF);
+		SPRINTF_BIT_B2(swbit,  "SW=",  SW_MAX, EV_SW);
 
 		len += sprintf(buf + len, "\n");
 
Index: linux-2.6.12/include/linux/input.h
===================================================================
--- linux-2.6.12.orig/include/linux/input.h	2005-07-28 15:18:23.000000000 +0100
+++ linux-2.6.12/include/linux/input.h	2005-07-28 17:01:59.000000000 +0100
@@ -66,6 +66,7 @@
 #define EVIOCGKEY(len)		_IOC(_IOC_READ, 'E', 0x18, len)		/* get global keystate */
 #define EVIOCGLED(len)		_IOC(_IOC_READ, 'E', 0x19, len)		/* get all LEDs */
 #define EVIOCGSND(len)		_IOC(_IOC_READ, 'E', 0x1a, len)		/* get all sounds status */
+#define EVIOCGSW(len)		_IOC(_IOC_READ, 'E', 0x1b, len)		/* get all switch states */
 
 #define EVIOCGBIT(ev,len)	_IOC(_IOC_READ, 'E', 0x20 + ev, len)	/* get event bits */
 #define EVIOCGABS(abs)		_IOR('E', 0x40 + abs, struct input_absinfo)		/* get abs value/limits */
@@ -86,6 +87,7 @@
 #define EV_REL			0x02
 #define EV_ABS			0x03
 #define EV_MSC			0x04
+#define EV_SW			0x05
 #define EV_LED			0x11
 #define EV_SND			0x12
 #define EV_REP			0x14
@@ -559,6 +561,20 @@
 #define ABS_MAX			0x3f
 
 /*
+ * Switch events
+ */
+
+#define SW_0		0x00
+#define SW_1		0x01
+#define SW_2		0x02
+#define SW_3		0x03
+#define SW_4		0x04
+#define SW_5		0x05
+#define SW_6		0x06
+#define SW_7		0x07
+#define SW_MAX		0x0f
+
+/*
  * Misc events
  */
 
@@ -832,6 +848,7 @@
 	unsigned long ledbit[NBITS(LED_MAX)];
 	unsigned long sndbit[NBITS(SND_MAX)];
 	unsigned long ffbit[NBITS(FF_MAX)];
+	unsigned long swbit[NBITS(SW_MAX)];
 	int ff_effects_max;
 
 	unsigned int keycodemax;
@@ -852,6 +869,7 @@
 	unsigned long key[NBITS(KEY_MAX)];
 	unsigned long led[NBITS(LED_MAX)];
 	unsigned long snd[NBITS(SND_MAX)];
+	unsigned long sw[NBITS(SW_MAX)];
 
 	int absmax[ABS_MAX + 1];
 	int absmin[ABS_MAX + 1];
@@ -894,6 +912,7 @@
 #define INPUT_DEVICE_ID_MATCH_LEDBIT	0x200
 #define INPUT_DEVICE_ID_MATCH_SNDBIT	0x400
 #define INPUT_DEVICE_ID_MATCH_FFBIT	0x800
+#define INPUT_DEVICE_ID_MATCH_SWBIT	0x1000
 
 #define INPUT_DEVICE_ID_MATCH_DEVICE\
 	(INPUT_DEVICE_ID_MATCH_BUS | INPUT_DEVICE_ID_MATCH_VENDOR | INPUT_DEVICE_ID_MATCH_PRODUCT)
@@ -914,6 +933,7 @@
 	unsigned long ledbit[NBITS(LED_MAX)];
 	unsigned long sndbit[NBITS(SND_MAX)];
 	unsigned long ffbit[NBITS(FF_MAX)];
+	unsigned long swbit[NBITS(SW_MAX)];
 
 	unsigned long driver_info;
 };
@@ -1006,6 +1026,11 @@
 	input_event(dev, EV_FF_STATUS, code, value);
 }
 
+static inline void input_report_switch(struct input_dev *dev, unsigned int code, int value)
+{
+	input_event(dev, EV_SW, code, !!value);
+}
+
 static inline void input_regs(struct input_dev *dev, struct pt_regs *regs)
 {
 	dev->regs = regs;


