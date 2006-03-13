Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbWCMUy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbWCMUy3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 15:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932388AbWCMUy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 15:54:29 -0500
Received: from cicero0.cybercity.dk ([212.242.40.52]:15073 "EHLO
	cicero0.cybercity.dk") by vger.kernel.org with ESMTP
	id S932342AbWCMUy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 15:54:28 -0500
From: Elias Naur <elias@oddlabs.com>
Organization: Oddlabs ApS
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: [PATCH] Expose input device usages to userspace
Date: Mon, 13 Mar 2006 21:54:38 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200603132154.38876.elias@oddlabs.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I believe that the current event input interface is missing some kind of 
information about the general kind of input device (Mouse, Keyboard, Joystick 
etc.) so I added a simple ioctl to do just that. The relevant line in 
include/linux/input.h is:

#define EVIOCGUSAGE(len)    _IOC(_IOC_READ, 'E', 0x1c, len)         /* get all 
usages */

It returns a bit set with the device usages. Current usages are:

#define USAGE_MOUSE         0x00
#define USAGE_JOYSTICK      0x01
#define USAGE_GAMEPAD       0x02
#define USAGE_KEYBOARD      0x03

The patch against 2.6.16-rc6 adds the bit set in input_dev and adds support 
for the usage set in hid-input.c, psmouse.c and atkbd.c. The change still 
needs to be added to all input devices, but I'm writing now to solicit 
comments about the interface itself. For example, one might want a single 
usage (like DirectInput), not a set (like the usage pairs in the Mac OS X HID 
manager). Additionally, there's always the possibility that the device usages 
are kept secret for a reason :)

Signed-off-by: Elias Naur <elias@oddlabs.com>

---

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index 745979f..f09a2f9 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -504,6 +504,9 @@ static long evdev_ioctl_handler(struct f
 					}
 					return bits_to_user(bits, len, _IOC_SIZE(cmd), p, compat_mode);
 				}
+				
+				if (_IOC_NR(cmd) == _IOC_NR(EVIOCGUSAGE(0)))
+					return bits_to_user(dev->usagebit, USAGE_MAX, _IOC_SIZE(cmd), p, 
compat_mode);
 
 				if (_IOC_NR(cmd) == _IOC_NR(EVIOCGKEY(0)))
 					return bits_to_user(dev->key, KEY_MAX, _IOC_SIZE(cmd),
diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index ffacf6e..4b61e19 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -794,6 +794,8 @@ static void atkbd_set_device_attrs(struc
 
 	input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_REP) | BIT(EV_MSC);
 
+	input_dev->usagebit[0] = BIT(USAGE_KEYBOARD);
+
 	if (atkbd->write) {
 		input_dev->evbit[0] |= BIT(EV_LED);
 		input_dev->ledbit[0] = BIT(LED_NUML) | BIT(LED_CAPSL) | BIT(LED_SCROLLL);
diff --git a/drivers/input/mouse/psmouse-base.c 
b/drivers/input/mouse/psmouse-base.c
index ad62174..d058960 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -1018,6 +1018,8 @@ static int psmouse_switch_protocol(struc
 	input_dev->keybit[LONG(BTN_MOUSE)] = BIT(BTN_LEFT) | BIT(BTN_MIDDLE) | 
BIT(BTN_RIGHT);
 	input_dev->relbit[0] = BIT(REL_X) | BIT(REL_Y);
 
+	input_dev->usagebit[0] = BIT(USAGE_MOUSE);
+
 	psmouse->set_rate = psmouse_set_rate;
 	psmouse->set_resolution = psmouse_set_resolution;
 	psmouse->poll = psmouse_poll;
diff --git a/drivers/usb/input/hid-input.c b/drivers/usb/input/hid-input.c
index cb0d80f..bcde293 100644
--- a/drivers/usb/input/hid-input.c
+++ b/drivers/usb/input/hid-input.c
@@ -766,6 +766,38 @@ static void hidinput_close(struct input_
 }
 
 /*
+ * Register the device usages, if any
+ */
+static void hidinput_init_usages(struct hid_device *hid, struct input_dev 
*input) {
+	int i;
+
+	for (i = 0; i < hid->maxcollection; i++)
+		if (hid->collection[i].type == HID_COLLECTION_APPLICATION ||
+				hid->collection[i].type == HID_COLLECTION_PHYSICAL) {
+			switch (hid->collection[i].usage) {
+				case HID_GD_POINTER: /* Fall through */
+				case HID_GD_MOUSE:
+					set_bit(USAGE_MOUSE, input->usagebit);
+					break;
+				case HID_GD_KEYBOARD: /* Fall through */
+				case HID_GD_KEYPAD:
+					set_bit(USAGE_KEYBOARD, input->usagebit);
+					break;
+				case HID_GD_JOYSTICK:
+					set_bit(USAGE_JOYSTICK, input->usagebit);
+					break;
+				case HID_GD_GAMEPAD:
+					set_bit(USAGE_GAMEPAD, input->usagebit);
+					break;
+				default: /* ignore it */
+					break;
+			}
+		}
+}
+
+
+
+/*
  * Register the input device; print a message.
  * Configure the input layer interface
  * Read all reports and initialize the absolute field values.
@@ -833,6 +865,7 @@ int hidinput_connect(struct hid_device *
 				 * UGCI) cram a lot of unrelated inputs into the
 				 * same interface. */
 				hidinput->report = report;
+				hidinput_init_usages(hid, hidinput->input);
 				input_register_device(hidinput->input);
 				hidinput = NULL;
 			}
@@ -843,6 +876,7 @@ int hidinput_connect(struct hid_device *
 	 * only useful in this case, and not for multi-input quirks. */
 	if (hidinput) {
 		hid_ff_init(hid);
+		hidinput_init_usages(hid, hidinput->input);
 		input_register_device(hidinput->input);
 	}
 
diff --git a/include/linux/input.h b/include/linux/input.h
index 6d4cc3c..398f4ac 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -35,7 +35,7 @@ struct input_event {
  * Protocol version.
  */
 
-#define EV_VERSION		0x010000
+#define EV_VERSION		0x010001
 
 /*
  * IOCTLs (0x00 - 0x7f)
@@ -70,6 +70,8 @@ struct input_absinfo {
 #define EVIOCGSND(len)		_IOC(_IOC_READ, 'E', 0x1a, len)		/* get all sounds 
status */
 #define EVIOCGSW(len)		_IOC(_IOC_READ, 'E', 0x1b, len)		/* get all switch 
states */
 
+#define EVIOCGUSAGE(len)	_IOC(_IOC_READ, 'E', 0x1c, len)         /* get all 
usages */
+
 #define EVIOCGBIT(ev,len)	_IOC(_IOC_READ, 'E', 0x20 + ev, len)	/* get event 
bits */
 #define EVIOCGABS(abs)		_IOR('E', 0x40 + abs, struct input_absinfo)		/* get 
abs value/limits */
 #define EVIOCSABS(abs)		_IOW('E', 0xc0 + abs, struct input_absinfo)		/* set 
abs value/limits */
@@ -579,6 +581,15 @@ struct input_absinfo {
 #define SW_MAX		0x0f
 
 /*
+ * Usage flags
+ */
+#define USAGE_MOUSE			0x00
+#define USAGE_JOYSTICK		0x01
+#define USAGE_GAMEPAD		0x02
+#define USAGE_KEYBOARD		0x03
+#define USAGE_MAX			0x0f
+
+/*
  * Misc events
  */
 
@@ -892,6 +903,9 @@ struct input_dev {
 	unsigned long sndbit[NBITS(SND_MAX)];
 	unsigned long ffbit[NBITS(FF_MAX)];
 	unsigned long swbit[NBITS(SW_MAX)];
+	
+	unsigned long usagebit[NBITS(USAGE_MAX)];
+
 	int ff_effects_max;
 
 	unsigned int keycodemax;
