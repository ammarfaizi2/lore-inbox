Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262539AbTIUT3Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 15:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262540AbTIUT3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 15:29:25 -0400
Received: from smtp5.hy.skanova.net ([195.67.199.134]:55287 "EHLO
	smtp5.hy.skanova.net") by vger.kernel.org with ESMTP
	id S262539AbTIUT3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 15:29:18 -0400
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: Broken synaptics mouse..
References: <Pine.LNX.4.44.0309110744030.28410-100000@home.osdl.org>
	<Pine.LNX.4.44.0309190129170.32637-100000@telia.com>
	<20030919114806.GD784@ucw.cz> <m2fziqukhi.fsf@p4.localdomain>
	<20030921172758.GA21014@ucw.cz>
From: Peter Osterlund <petero2@telia.com>
Date: 21 Sep 2003 21:29:10 +0200
In-Reply-To: <20030921172758.GA21014@ucw.cz>
Message-ID: <m2u176rldl.fsf@p4.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@suse.cz> writes:

> On Sun, Sep 21, 2003 at 07:20:09PM +0200, Peter Osterlund wrote:
> 
> > > I'd really prefer to contain the ugliness in mousedev.c, which then
> > > could be removed completely in 2.8 or so, when XFree and GPM is already
> > > well adapted to the event interface.
> > 
> > That's certainly possible too. See patch below. Note though that this
> > patch has the disadvantage mentioned by Dmitry:
> > 
> >         We also can't just emulate relative events as everything is
> >         multiplexed into /dev/input/mice and I can see many people
> >         using Synaptics via /dev/input/eventX and everything else via
> >         /dev/input/mice as it nicely handles hot plugging (at least I
> >         use it this way).
> 
> You can use EVIOCGRAB for the time being in the XFree86 synaptics
> driver, this way you'll prevent its events coming into mousedev the
> moment it's opened by XFree86, which is probably exactly what one wants.

OK, I'll try this, but I'll wait until we have worked out what events
we want the kernel driver to report.

> One thing I don't particularly like is the check for product ==
> PSMOUSE_SYNAPTICS, since it's very non-generic. Also, ABS_PRESSURE is
> defined on most tablets ...
> 
> We should define a standard set of features (ABS_*, BTN_*) that a
> touchpad should have, and what they should mean. I fear the current
> Synaptics driver gets some of it wrong. (Like the axis orientation,
> which is defined to be the same as the USB HID spec, or the fact that
> invalid ABS_* values should not be reported).

OK, below is a new patch that splits the W value as has been suggested
before. The synaptics driver now reports BTN_TOOL_FINGER,
BTN_TOOL_DOUBLETAP and BTN_TOOL_TRIPLETAP for one, two and three
fingers respectively, and it reports ABS_TOOL_WIDTH for the finger
width value. These event types are also used by mousedev.c to decide
if it is dealing with a touchpad.

It should also gets the direction of the Y axis right.

One thing that it doesn't get right is the handling of invalid ABS_*
values. How is this supposed to be handled? The driver doesn't know
the exact limits for the X/Y values, and discarding values outside
some guessed limits will only have the effect that some parts of the
touchpad area becomes dead.

 linux-petero/drivers/input/mouse/synaptics.c |   45 +++++++-----
 linux-petero/drivers/input/mousedev.c        |  100 +++++++++++++++++++--------
 linux-petero/include/linux/input.h           |    3 
 3 files changed, 103 insertions(+), 45 deletions(-)

diff -puN drivers/input/mouse/synaptics.c~mousedev-synaptics drivers/input/mouse/synaptics.c
--- linux/drivers/input/mouse/synaptics.c~mousedev-synaptics	2003-09-21 20:56:18.000000000 +0200
+++ linux-petero/drivers/input/mouse/synaptics.c	2003-09-21 20:56:18.000000000 +0200
@@ -334,11 +334,13 @@ static void set_input_params(struct inpu
 	set_abs_params(dev, ABS_X, 1472, 5472, 0, 0);
 	set_abs_params(dev, ABS_Y, 1408, 4448, 0, 0);
 	set_abs_params(dev, ABS_PRESSURE, 0, 255, 0, 0);
-
-	set_bit(EV_MSC, dev->evbit);
-	set_bit(MSC_GESTURE, dev->mscbit);
+	set_bit(ABS_TOOL_WIDTH, dev->absbit);
 
 	set_bit(EV_KEY, dev->evbit);
+	set_bit(BTN_TOOL_FINGER, dev->keybit);
+	set_bit(BTN_TOOL_DOUBLETAP, dev->keybit);
+	set_bit(BTN_TOOL_TRIPLETAP, dev->keybit);
+
 	set_bit(BTN_LEFT, dev->keybit);
 	set_bit(BTN_RIGHT, dev->keybit);
 	set_bit(BTN_FORWARD, dev->keybit);
@@ -528,42 +530,47 @@ static void synaptics_process_packet(str
 	struct input_dev *dev = &psmouse->dev;
 	struct synaptics_data *priv = psmouse->private;
 	struct synaptics_hw_state hw;
+	int num_fingers;
+	int finger_width;
 
 	synaptics_parse_hw_state(psmouse->packet, priv, &hw);
 
 	if (hw.z > 0) {
-		int w_ok = 0;
-		/*
-		 * Use capability bits to decide if the w value is valid.
-		 * If not, set it to 5, which corresponds to a finger of
-		 * normal width.
-		 */
+		num_fingers = 1;
+		finger_width = 5;
 		if (SYN_CAP_EXTENDED(priv->capabilities)) {
 			switch (hw.w) {
 			case 0 ... 1:
-				w_ok = SYN_CAP_MULTIFINGER(priv->capabilities);
+				if (SYN_CAP_MULTIFINGER(priv->capabilities))
+					num_fingers = hw.w + 2;
 				break;
 			case 2:
-				w_ok = SYN_MODEL_PEN(priv->model_id);
+				if (SYN_MODEL_PEN(priv->model_id))
+					;   /* Nothing, treat a pen as a single finger */
 				break;
 			case 4 ... 15:
-				w_ok = SYN_CAP_PALMDETECT(priv->capabilities);
+				if (SYN_CAP_PALMDETECT(priv->capabilities))
+					finger_width = hw.w;
 				break;
 			}
 		}
-		if (!w_ok)
-			hw.w = 5;
+	} else {
+		num_fingers = 0;
+		finger_width = 0;
 	}
 
 	/* Post events */
 	input_report_abs(dev, ABS_X,        hw.x);
-	input_report_abs(dev, ABS_Y,        hw.y);
+	if (SYN_MODEL_ROT180(priv->model_id))
+		input_report_abs(dev, ABS_Y, -hw.y);
+	else
+		input_report_abs(dev, ABS_Y, hw.y);
 	input_report_abs(dev, ABS_PRESSURE, hw.z);
 
-	if (hw.w != priv->old_w) {
-		input_event(dev, EV_MSC, MSC_GESTURE, hw.w);
-		priv->old_w = hw.w;
-	}
+	input_report_abs(dev, ABS_TOOL_WIDTH, finger_width);
+	input_report_key(dev, BTN_TOOL_FINGER, num_fingers == 1);
+	input_report_key(dev, BTN_TOOL_DOUBLETAP, num_fingers == 2);
+	input_report_key(dev, BTN_TOOL_TRIPLETAP, num_fingers == 3);
 
 	input_report_key(dev, BTN_LEFT,    hw.left);
 	input_report_key(dev, BTN_RIGHT,   hw.right);
diff -puN drivers/input/mousedev.c~mousedev-synaptics drivers/input/mousedev.c
--- linux/drivers/input/mousedev.c~mousedev-synaptics	2003-09-21 20:56:18.000000000 +0200
+++ linux-petero/drivers/input/mousedev.c	2003-09-21 20:56:18.000000000 +0200
@@ -58,6 +58,7 @@ struct mousedev_list {
 	unsigned long buttons;
 	unsigned char ready, buffer, bufsiz;
 	unsigned char mode, imexseq, impsseq;
+	int finger;
 };
 
 #define MOUSEDEV_SEQ_LEN	6
@@ -73,12 +74,77 @@ static struct mousedev mousedev_mix;
 static int xres = CONFIG_INPUT_MOUSEDEV_SCREEN_X;
 static int yres = CONFIG_INPUT_MOUSEDEV_SCREEN_Y;
 
+static void mousedev_abs_event(struct input_handle *handle, struct mousedev_list *list, unsigned int code, int value)
+{
+	int size;
+
+	/* Ignore joysticks */
+	if (test_bit(BTN_TRIGGER, handle->dev->keybit))
+		return;
+
+	/* Handle touchpad data */
+	if (test_bit(BTN_TOOL_FINGER, handle->dev->keybit) &&
+	    test_bit(ABS_PRESSURE, handle->dev->absbit) &&
+	    test_bit(ABS_TOOL_WIDTH, handle->dev->absbit)) {
+		switch (code) {
+		case ABS_PRESSURE:
+			if (!list->finger) {
+				if (value > 30)
+					list->finger = 1;
+			} else {
+				if (value < 25)
+					list->finger = 0;
+				else if (list->finger < 3)
+					list->finger++;
+			}
+			break;
+		case ABS_X:
+			if (list->finger >= 3) {
+				list->dx += (value - list->oldx) / 8;
+			}
+			list->oldx = value;
+			break;
+		case ABS_Y:
+			if (list->finger >= 3) {
+				list->dy -= (value - list->oldy) / 8;
+			}
+			list->oldy = value;
+			break;
+		}
+		return;
+	}
+
+	/* Handle tablet like devices */
+	switch (code) {
+	case ABS_X:
+		size = handle->dev->absmax[ABS_X] - handle->dev->absmin[ABS_X];
+		if (size != 0) {
+			list->dx += (value * xres - list->oldx) / size;
+			list->oldx += list->dx * size;
+		} else {
+			list->dx += value - list->oldx;
+			list->oldx += list->dx;
+		}
+		break;
+	case ABS_Y:
+		size = handle->dev->absmax[ABS_Y] - handle->dev->absmin[ABS_Y];
+		if (size != 0) {
+			list->dy -= (value * yres - list->oldy) / size;
+			list->oldy -= list->dy * size;
+		} else {
+			list->dy -= value - list->oldy;
+			list->oldy -= list->dy;
+		}
+		break;
+	}
+}
+
 static void mousedev_event(struct input_handle *handle, unsigned int type, unsigned int code, int value)
 {
 	struct mousedev *mousedevs[3] = { handle->private, &mousedev_mix, NULL };
 	struct mousedev **mousedev = mousedevs;
 	struct mousedev_list *list;
-	int index, size, wake;
+	int index, wake;
 
 	while (*mousedev) {
 
@@ -87,31 +153,7 @@ static void mousedev_event(struct input_
 		list_for_each_entry(list, &(*mousedev)->list, node)
 			switch (type) {
 				case EV_ABS:
-					if (test_bit(BTN_TRIGGER, handle->dev->keybit))
-						break;
-					switch (code) {
-						case ABS_X:	
-							size = handle->dev->absmax[ABS_X] - handle->dev->absmin[ABS_X];
-							if (size != 0) {
-								list->dx += (value * xres - list->oldx) / size;
-								list->oldx += list->dx * size;
-							} else {
-								list->dx += value - list->oldx;
-								list->oldx += list->dx;
-							}
-							break;
-
-						case ABS_Y:
-							size = handle->dev->absmax[ABS_Y] - handle->dev->absmin[ABS_Y];
-							if (size != 0) {
-								list->dy -= (value * yres - list->oldy) / size;
-								list->oldy -= list->dy * size;
-							} else {
-								list->dy -= value - list->oldy;
-								list->oldy -= list->dy;
-							}
-							break;
-					}
+					mousedev_abs_event(handle, list, code, value);
 					break;
 
 				case EV_REL:
@@ -472,6 +514,12 @@ static struct input_device_id mousedev_i
 		.keybit = { [LONG(BTN_TOUCH)] = BIT(BTN_TOUCH) },
 		.absbit = { BIT(ABS_X) | BIT(ABS_Y) },
 	},	/* A tablet like device, at least touch detection, two absolute axes */
+	{
+		.flags = INPUT_DEVICE_ID_MATCH_EVBIT | INPUT_DEVICE_ID_MATCH_KEYBIT | INPUT_DEVICE_ID_MATCH_ABSBIT,
+		.evbit = { BIT(EV_KEY) | BIT(EV_ABS) },
+		.keybit = { [LONG(BTN_TOOL_FINGER)] = BIT(BTN_TOOL_FINGER) },
+		.absbit = { BIT(ABS_X) | BIT(ABS_Y) | BIT(ABS_PRESSURE) | BIT(ABS_TOOL_WIDTH) },
+	},	/* A touchpad */
 
 	{ }, 	/* Terminating entry */
 };
diff -puN include/linux/input.h~mousedev-synaptics include/linux/input.h
--- linux/include/linux/input.h~mousedev-synaptics	2003-09-21 20:56:18.000000000 +0200
+++ linux-petero/include/linux/input.h	2003-09-21 20:56:18.000000000 +0200
@@ -404,6 +404,8 @@ struct input_absinfo {
 #define BTN_TOUCH		0x14a
 #define BTN_STYLUS		0x14b
 #define BTN_STYLUS2		0x14c
+#define BTN_TOOL_DOUBLETAP	0x14d
+#define BTN_TOOL_TRIPLETAP	0x14e
 
 #define BTN_WHEEL		0x150
 #define BTN_GEAR_DOWN		0x150
@@ -521,6 +523,7 @@ struct input_absinfo {
 #define ABS_DISTANCE		0x19
 #define ABS_TILT_X		0x1a
 #define ABS_TILT_Y		0x1b
+#define ABS_TOOL_WIDTH		0x1c
 #define ABS_VOLUME		0x20
 #define ABS_MISC		0x28
 #define ABS_MAX			0x3f

_

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
