Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261274AbVGGLPG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbVGGLPG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 07:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbVGGLPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 07:15:06 -0400
Received: from mail.math.TU-Berlin.DE ([130.149.12.212]:36089 "EHLO
	mail.math.TU-Berlin.DE") by vger.kernel.org with ESMTP
	id S261274AbVGGLPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 07:15:03 -0400
From: Thomas Richter <thor@math.TU-Berlin.DE>
Message-Id: <200507071114.NAA10656@mersenne.math.tu-berlin.de>
Subject: [PATCH] joydev.c: Digital joysticks on analog ports
To: linux-kernel@vger.kernel.org, vojtech@suse.cz
Date: Thu, 7 Jul 2005 13:14:58 +0200 (CEST)
X-Mailer: ELM [version 2.4ME+ PL108 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi folks, hi Vojtech,

the following is a patch to drivers/input/joydev.c and
include/linux/joystick.h that allows you to connect the "traditional"
digital joysticks for C64, Atari, Amiga... on analog input ports by
means of a minimalistic self- made adapter board ("ElCheapo",
schematics below). The patch converts the digital inputs to suitable
"analog" versions that are interpreted fine. The patch "as is" applies
to kernel 2.4.31, but it should work for other kernel versions as
well.

New kernel parameters for joydev: "digital = 1" sets all default input
modes to "digital" instead of analog.

The new ioctl JSIOCSDIGITAL for joydev allows to adjusts this
on the running driver.

Greetings,
	Thomas Richter

Patch for drivers/input/joydev.c:

/* snip */

--- ../linux-2.4.31/drivers/input/joydev.c	2003-06-13 16:51:34.000000000 +0200
+++ drivers/input/joydev.c	2005-07-06 22:37:21.000000000 +0200
@@ -65,6 +65,7 @@
 	struct JS_DATA_SAVE_TYPE glue;
 	int nabs;
 	int nkey;
+        int digital;
 	__u16 keymap[KEY_MAX - BTN_MISC];
 	__u16 keypam[KEY_MAX - BTN_MISC];
 	__u8 absmap[ABS_MAX];
@@ -84,6 +85,11 @@
 
 static struct joydev *joydev_table[JOYDEV_MINORS];
 
+static int digital = 0;
+
+MODULE_PARM(digital,"i");
+MODULE_PARM_DESC(digital,"if 1, handle digital joysticks via the 'ElCheapo' interface");
+
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
 MODULE_DESCRIPTION("Joystick device driver");
 MODULE_LICENSE("GPL");
@@ -109,13 +115,68 @@
 	return value;
 }
 
+static int joydev_digital_event(struct js_event *ev,struct input_handle *handle,unsigned int type,
+				unsigned int code, int value)
+{
+  struct joydev *joydev = handle->private;
+
+  switch(type) {
+  case EV_KEY:
+    if (code < BTN_MISC || value == 2) return 0;
+    code = joydev->keymap[code - BTN_MISC];
+    switch(code) {
+    case 0:
+      ev->type   = JS_EVENT_AXIS;
+      ev->number = 1;
+      ev->value  = (value)?+32767:0;
+      break;
+    case 1:
+      ev->type   = JS_EVENT_AXIS;
+      ev->number = 0;
+      ev->value  = (value)?+32767:0;
+      break;
+    case 2:
+      ev->type   = JS_EVENT_AXIS;
+      ev->number = 1;
+      ev->value  = (value)?-32767:0;
+      break;
+    case 3:
+      ev->type   = JS_EVENT_AXIS;
+      ev->number = 0;
+      ev->value  = (value)?-32767:0;
+      break;
+    default:
+      ev->type   = JS_EVENT_BUTTON;
+      ev->number = code;
+      ev->value  = value;
+    }
+    break;
+  case EV_ABS:
+    if (joydev->absmap[code] == 0) {
+      ev->type   = JS_EVENT_BUTTON;
+      ev->number = 0;
+      if (joydev_correct(value, joydev->corr) >= 16384)
+	ev->value = 1;
+      else
+	ev->value = 0;
+    } else return 0;
+    break;
+  default:
+    return 0;
+  }
+  return 1;
+}
+
 static void joydev_event(struct input_handle *handle, unsigned int type, unsigned int code, int value)
 {
 	struct joydev *joydev = handle->private;
 	struct joydev_list *list = joydev->list;
 	struct js_event event;
 
-	switch (type) {
+	if (joydev->digital) {
+	  if (joydev_digital_event(&event,handle,type,code,value) == 0)
+	    return;
+	} else switch (type) {
 
 		case EV_KEY:
 			if (code < BTN_MISC || value == 2) return;
@@ -382,6 +443,8 @@
 				joydev->absmap[joydev->abspam[i]] = i;
 			}
 			return 0;
+	        case JSIOCSDIGITAL:
+		        return get_user(joydev->digital, (__u8 *)arg);
 		case JSIOCGAXMAP:
 			return copy_to_user((__u8 *) arg, joydev->abspam,
 						sizeof(__u8) * ABS_MAX) ? -EFAULT : 0;
@@ -450,6 +513,7 @@
 	joydev->handle.private = joydev;
 
 	joydev->exist = 1;
+	joydev->digital = digital;
 
 	for (i = 0; i < ABS_MAX; i++)
 		if (test_bit(i, dev->absbit)) {

/* snip */

Patch for include/linux/joystick.h:

/* snip */

--- ../linux-2.4.31/include/linux/joystick.h	2005-06-26 15:44:37.000000000 +0200
+++ include/linux/joystick.h	2005-07-06 22:37:36.000000000 +0200
@@ -70,6 +70,7 @@
 #define JSIOCGAXMAP		_IOR('j', 0x32, __u8[ABS_MAX])			/* get axis mapping */
 #define JSIOCSBTNMAP		_IOW('j', 0x33, __u16[KEY_MAX - BTN_MISC])	/* set button mapping */
 #define JSIOCGBTNMAP		_IOR('j', 0x34, __u16[KEY_MAX - BTN_MISC])	/* get button mapping */
+#define JSIOCSDIGITAL           _IOW('j', 0x35, __u8)                           /* set digital/analog flag */
 
 /*
  * Types and constants for get/set correction

/* snip */

Finally, a figure explaining the required connections to be made to
connect a digital joystick to an analog input (xfig required):

/* snip */
#FIG 3.2  Produced by xfig version 3.2.5-alpha5
Landscape
Center
Metric
A4      
70.00
Single
-2
1200 2
6 2250 4050 4275 4500
2 1 0 1 0 7 50 0 -1 0.000 0 0 -1 0 0 2
	 2250 4275 2700 4275
2 1 0 1 0 7 50 0 -1 0.000 0 0 -1 0 0 5
	 2700 4500 2700 4050 3825 4050 3825 4500 2700 4500
2 1 0 1 0 7 50 0 -1 0.000 0 0 -1 0 0 2
	 3825 4275 4275 4275
-6
6 4050 4050 6075 4500
2 1 0 1 0 7 50 0 -1 0.000 0 0 -1 0 0 2
	 4050 4275 4500 4275
2 1 0 1 0 7 50 0 -1 0.000 0 0 -1 0 0 5
	 4500 4500 4500 4050 5625 4050 5625 4500 4500 4500
2 1 0 1 0 7 50 0 -1 0.000 0 0 -1 0 0 2
	 5625 4275 6075 4275
-6
6 6075 4050 8100 4500
2 1 0 1 0 7 50 0 -1 0.000 0 0 -1 0 0 2
	 6075 4275 6525 4275
2 1 0 1 0 7 50 0 -1 0.000 0 0 -1 0 0 5
	 6525 4500 6525 4050 7650 4050 7650 4500 6525 4500
2 1 0 1 0 7 50 0 -1 0.000 0 0 -1 0 0 2
	 7650 4275 8100 4275
-6
6 6075 2250 8100 2700
2 1 0 1 0 7 50 0 -1 0.000 0 0 -1 0 0 2
	 6075 2475 6525 2475
2 1 0 1 0 7 50 0 -1 0.000 0 0 -1 0 0 5
	 6525 2700 6525 2250 7650 2250 7650 2700 6525 2700
2 1 0 1 0 7 50 0 -1 0.000 0 0 -1 0 0 2
	 7650 2475 8100 2475
-6
6 6075 8550 8100 9000
2 1 0 1 0 7 50 0 -1 0.000 0 0 -1 0 0 2
	 6075 8775 6525 8775
2 1 0 1 0 7 50 0 -1 0.000 0 0 -1 0 0 5
	 6525 9000 6525 8550 7650 8550 7650 9000 6525 9000
2 1 0 1 0 7 50 0 -1 0.000 0 0 -1 0 0 2
	 7650 8775 8100 8775
-6
6 6075 6750 8100 7200
2 1 0 1 0 7 50 0 -1 0.000 0 0 -1 0 0 2
	 6075 6975 6525 6975
2 1 0 1 0 7 50 0 -1 0.000 0 0 -1 0 0 5
	 6525 7200 6525 6750 7650 6750 7650 7200 6525 7200
2 1 0 1 0 7 50 0 -1 0.000 0 0 -1 0 0 2
	 7650 6975 8100 6975
-6
1 3 0 1 0 7 50 0 -1 0.000 1 0.0000 1125 3825 225 225 1125 3825 1350 3825
1 3 0 1 0 7 50 0 -1 0.000 1 0.0000 1125 4725 225 225 1125 4725 1350 4725
1 3 0 1 0 7 50 0 -1 0.000 1 0.0000 1125 5625 225 225 1125 5625 1350 5625
1 3 0 1 0 7 50 0 -1 0.000 1 0.0000 1125 6525 225 225 1125 6525 1350 6525
1 3 0 1 0 7 50 0 -1 0.000 1 0.0000 1125 7425 225 225 1125 7425 1350 7425
1 3 0 1 0 7 50 0 -1 0.000 1 0.0000 2025 4275 225 225 2025 4275 2250 4275
1 3 0 1 0 7 50 0 -1 0.000 1 0.0000 2025 5175 225 225 2025 5175 2250 5175
1 3 0 1 0 7 50 0 -1 0.000 1 0.0000 2025 6075 225 225 2025 6075 2250 6075
1 3 0 1 0 7 50 0 -1 0.000 1 0.0000 2025 6975 225 225 2025 6975 2250 6975
1 3 0 1 0 0 50 0 20 0.000 1 0.0000 6075 4275 75 75 6075 4275 6150 4275
1 3 0 1 0 7 50 0 -1 0.000 1 0.0000 9900 4275 225 225 9900 4275 10125 4275
1 3 0 1 0 7 50 0 -1 0.000 1 0.0000 9900 3375 225 225 9900 3375 10125 3375
1 3 0 1 0 7 50 0 -1 0.000 1 0.0000 9900 2475 225 225 9900 2475 10125 2475
1 3 0 1 0 7 50 0 -1 0.000 1 0.0000 9900 5175 225 225 9900 5175 10125 5175
1 3 0 1 0 7 50 0 -1 0.000 1 0.0000 9900 6075 225 225 9900 6075 10125 6075
1 3 0 1 0 7 50 0 -1 0.000 1 0.0000 9900 6975 225 225 9900 6975 10125 6975
1 3 0 1 0 7 50 0 -1 0.000 1 0.0000 9900 7875 225 225 9900 7875 10125 7875
1 3 0 1 0 7 50 0 -1 0.000 1 0.0000 9900 8775 225 225 9900 8775 10125 8775
1 3 0 1 0 7 50 0 -1 0.000 1 0.0000 10800 2925 225 225 10800 2925 11025 2925
1 3 0 1 0 7 50 0 -1 0.000 1 0.0000 10800 3825 225 225 10800 3825 11025 3825
1 3 0 1 0 7 50 0 -1 0.000 1 0.0000 10800 4725 225 225 10800 4725 11025 4725
1 3 0 1 0 7 50 0 -1 0.000 1 0.0000 10800 5625 225 225 10800 5625 11025 5625
1 3 0 1 0 7 50 0 -1 0.000 1 0.0000 10800 6525 225 225 10800 6525 11025 6525
1 3 0 1 0 7 50 0 -1 0.000 1 0.0000 10800 7425 225 225 10800 7425 11025 7425
1 3 0 1 0 7 50 0 -1 0.000 1 0.0000 10800 8325 225 225 10800 8325 11025 8325
2 1 0 1 0 7 50 0 -1 0.000 0 0 -1 0 0 2
	 8100 4275 9675 4275
2 1 0 1 0 7 50 0 -1 0.000 0 0 -1 0 0 2
	 6075 2475 6075 4275
2 1 0 1 0 7 50 0 -1 0.000 0 0 -1 0 0 2
	 8100 2475 9675 2475
2 1 0 1 0 7 50 0 -1 0.000 0 0 -1 0 0 2
	 8100 6975 9675 6975
2 1 0 1 0 7 50 0 -1 0.000 0 0 -1 0 0 2
	 8100 8775 9675 8775
2 1 0 1 0 7 50 0 -1 0.000 0 0 -1 0 0 2
	 6075 6975 6075 8775
2 1 0 1 0 7 50 0 -1 0.000 0 0 -1 0 0 2
	 1350 3825 10575 3825
2 1 0 1 0 7 50 0 -1 0.000 0 0 -1 0 0 4
	 9675 7875 3600 7875 3600 6525 1350 6525
2 1 0 1 0 7 50 0 -1 0.000 0 0 -1 0 0 4
	 1350 5625 4050 5625 4050 7425 10575 7425
2 1 0 1 0 7 50 0 -1 0.000 0 0 -1 0 0 4
	 1350 4725 8550 4725 8550 3375 9675 3375
2 1 0 1 0 7 50 0 -1 0.000 0 0 -1 0 0 4
	 2250 6075 6075 6075 6075 5175 9675 5175
4 0 0 50 0 0 24 0.0000 4 270 210 675 3825 1\001
4 0 0 50 0 0 24 0.0000 4 270 210 675 4725 2\001
4 0 0 50 0 0 24 0.0000 4 270 210 675 5625 3\001
4 0 0 50 0 0 24 0.0000 4 270 210 675 6525 4\001
4 0 0 50 0 0 24 0.0000 4 285 210 675 7425 5\001
4 0 0 50 0 0 24 0.0000 4 270 210 1575 4275 6\001
4 0 0 50 0 0 24 0.0000 4 270 210 1575 5175 7\001
4 0 0 50 0 0 24 0.0000 4 270 210 1575 6075 8\001
4 0 0 50 0 0 24 0.0000 4 285 210 1575 6975 9\001
4 0 0 50 0 0 24 0.0000 4 270 210 10125 2475 1\001
4 0 0 50 0 0 24 0.0000 4 270 210 10125 3375 2\001
4 0 0 50 0 0 24 0.0000 4 270 210 10125 4275 3\001
4 0 0 50 0 0 24 0.0000 4 270 210 10125 5175 4\001
4 0 0 50 0 0 24 0.0000 4 285 210 10125 6075 5\001
4 0 0 50 0 0 24 0.0000 4 270 210 10125 6975 6\001
4 0 0 50 0 0 24 0.0000 4 270 210 10125 7875 7\001
4 0 0 50 0 0 24 0.0000 4 270 210 10125 8775 8\001
4 0 0 50 0 0 24 0.0000 4 285 210 11025 2925 9\001
4 0 0 50 0 0 24 0.0000 4 270 420 11025 3825 10\001
4 0 0 50 0 0 24 0.0000 4 270 420 11025 4725 11\001
4 0 0 50 0 0 24 0.0000 4 270 420 11025 5625 12\001
4 0 0 50 0 0 24 0.0000 4 270 420 11025 6525 13\001
4 0 0 50 0 0 24 0.0000 4 270 420 11025 7425 14\001
4 0 0 50 0 0 24 0.0000 4 285 420 11025 8325 15\001
4 0 0 50 0 0 36 0.0000 4 540 2865 9225 1800 PC Joystick\001
4 0 0 50 0 0 36 0.0000 4 540 3360 450 1800 Atari Joystick\001
4 0 0 50 0 0 48 0.0000 4 720 9945 1800 900 "El Cheapo" Joystick Interface\001
4 0 0 50 0 0 24 0.0000 4 270 2025 10575 9450 2003 THOR\001
4 0 0 50 0 32 36 0.0000 4 420 465 5220 8730 W\001
4 0 0 50 0 0 36 0.0000 4 420 4110 1170 8730 All resistors 22K\001
/* snip */

