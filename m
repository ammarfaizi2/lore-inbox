Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbTIYQxE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 12:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261647AbTIYQve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 12:51:34 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:36823 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261509AbTIYQub convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 12:50:31 -0400
Subject: [PATCH 4/8] Add touchpad support to mousedev.c.
In-Reply-To: <10645086121942@twilight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Thu, 25 Sep 2003 18:50:12 +0200
Message-Id: <10645086122209@twilight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org, dtor_core@ameritech.net, petero2@telia.com,
       Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1344, 2003-09-25 18:22:01+02:00, petero2@telia.com
  input: Tidy up events reported by a Synaptics pad, add touchpad
         support to mousedev.


 drivers/input/mouse/synaptics.c |   68 ++++++++++++++++-----------
 drivers/input/mousedev.c        |  100 +++++++++++++++++++++++++++++-----------
 include/linux/input.h           |    3 +
 3 files changed, 118 insertions(+), 53 deletions(-)

===================================================================

diff -Nru a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
--- a/drivers/input/mouse/synaptics.c	Thu Sep 25 18:37:28 2003
+++ b/drivers/input/mouse/synaptics.c	Thu Sep 25 18:37:28 2003
@@ -28,6 +28,16 @@
 #include "psmouse.h"
 #include "synaptics.h"
 
+/*
+ * The x/y limits are taken from the Synaptics TouchPad interfacing Guide,
+ * section 2.3.2, which says that they should be valid regardless of the
+ * actual size of the sensor.
+ */
+#define XMIN_NOMINAL 1472
+#define XMAX_NOMINAL 5472
+#define YMIN_NOMINAL 1408
+#define YMAX_NOMINAL 4448
+
 /*****************************************************************************
  *	Synaptics communications functions
  ****************************************************************************/
@@ -316,20 +326,17 @@
 
 static void set_input_params(struct input_dev *dev, struct synaptics_data *priv)
 {
-	/*
-	 * The x/y limits are taken from the Synaptics TouchPad interfacing Guide,
-	 * which says that they should be valid regardless of the actual size of
-	 * the sensor.
-	 */
 	set_bit(EV_ABS, dev->evbit);
-	set_abs_params(dev, ABS_X, 1472, 5472, 0, 0);
-	set_abs_params(dev, ABS_Y, 1408, 4448, 0, 0);
+	set_abs_params(dev, ABS_X, XMIN_NOMINAL, XMAX_NOMINAL, 0, 0);
+	set_abs_params(dev, ABS_Y, YMIN_NOMINAL, YMAX_NOMINAL, 0, 0);
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
@@ -489,42 +496,49 @@
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
-	input_report_abs(dev, ABS_X,        hw.x);
-	input_report_abs(dev, ABS_Y,        hw.y);
+	if (hw.z > 0) {
+		input_report_abs(dev, ABS_X, hw.x);
+		if (SYN_MODEL_ROT180(priv->model_id))
+			input_report_abs(dev, ABS_Y, YMAX_NOMINAL + YMIN_NOMINAL - hw.y);
+		else
+			input_report_abs(dev, ABS_Y, hw.y);
+	}
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
diff -Nru a/drivers/input/mousedev.c b/drivers/input/mousedev.c
--- a/drivers/input/mousedev.c	Thu Sep 25 18:37:28 2003
+++ b/drivers/input/mousedev.c	Thu Sep 25 18:37:28 2003
@@ -58,6 +58,7 @@
 	unsigned long buttons;
 	unsigned char ready, buffer, bufsiz;
 	unsigned char mode, imexseq, impsseq;
+	int finger;
 };
 
 #define MOUSEDEV_SEQ_LEN	6
@@ -73,12 +74,77 @@
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
 
@@ -87,31 +153,7 @@
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
@@ -472,6 +514,12 @@
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
diff -Nru a/include/linux/input.h b/include/linux/input.h
--- a/include/linux/input.h	Thu Sep 25 18:37:28 2003
+++ b/include/linux/input.h	Thu Sep 25 18:37:28 2003
@@ -404,6 +404,8 @@
 #define BTN_TOUCH		0x14a
 #define BTN_STYLUS		0x14b
 #define BTN_STYLUS2		0x14c
+#define BTN_TOOL_DOUBLETAP	0x14d
+#define BTN_TOOL_TRIPLETAP	0x14e
 
 #define BTN_WHEEL		0x150
 #define BTN_GEAR_DOWN		0x150
@@ -521,6 +523,7 @@
 #define ABS_DISTANCE		0x19
 #define ABS_TILT_X		0x1a
 #define ABS_TILT_Y		0x1b
+#define ABS_TOOL_WIDTH		0x1c
 #define ABS_VOLUME		0x20
 #define ABS_MISC		0x28
 #define ABS_MAX			0x3f

