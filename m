Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbTIYQuo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 12:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbTIYQuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 12:50:44 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:36311 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261492AbTIYQu3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 12:50:29 -0400
Subject: [PATCH 8/8] Add BTN_TOUCH to Synaptics driver. Update mousedev.
In-Reply-To: <10645086122225@twilight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Thu, 25 Sep 2003 18:50:12 +0200
Message-Id: <10645086121286@twilight.ucw.cz>
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

ChangeSet@1.1348, 2003-09-25 18:32:35+02:00, vojtech@mail.parknet.co.jp
  input: Add BTN_TOUCH to Synaptics pad driver. This fixes the joydev
         grabbing of the pads, as well as simplifies the mousedev driver.


 mouse/synaptics.c |    4 ++
 mousedev.c        |   77 ++++++++++++++++++++++--------------------------------
 2 files changed, 36 insertions(+), 45 deletions(-)

===================================================================

diff -Nru a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
--- a/drivers/input/mouse/synaptics.c	Thu Sep 25 18:36:58 2003
+++ b/drivers/input/mouse/synaptics.c	Thu Sep 25 18:36:58 2003
@@ -333,6 +333,7 @@
 	set_bit(ABS_TOOL_WIDTH, dev->absbit);
 
 	set_bit(EV_KEY, dev->evbit);
+	set_bit(BTN_TOUCH, dev->keybit);
 	set_bit(BTN_TOOL_FINGER, dev->keybit);
 	set_bit(BTN_TOOL_DOUBLETAP, dev->keybit);
 	set_bit(BTN_TOOL_TRIPLETAP, dev->keybit);
@@ -531,6 +532,9 @@
 		input_report_abs(dev, ABS_Y, YMAX_NOMINAL + YMIN_NOMINAL - hw.y);
 	}
 	input_report_abs(dev, ABS_PRESSURE, hw.z);
+
+	if (hw.z > 30) input_report_key(dev, BTN_TOUCH, 1);
+	if (hw.z < 25) input_report_key(dev, BTN_TOUCH, 0);
 
 	input_report_abs(dev, ABS_TOOL_WIDTH, finger_width);
 	input_report_key(dev, BTN_TOOL_FINGER, num_fingers == 1);
diff -Nru a/drivers/input/mousedev.c b/drivers/input/mousedev.c
--- a/drivers/input/mousedev.c	Thu Sep 25 18:36:58 2003
+++ b/drivers/input/mousedev.c	Thu Sep 25 18:36:58 2003
@@ -83,59 +83,40 @@
 		return;
 
 	/* Handle touchpad data */
-	if (test_bit(BTN_TOOL_FINGER, handle->dev->keybit) &&
-	    test_bit(ABS_PRESSURE, handle->dev->absbit) &&
-	    test_bit(ABS_TOOL_WIDTH, handle->dev->absbit)) {
+	if (test_bit(BTN_TOOL_FINGER, handle->dev->keybit)) {
+
+		if (list->finger && list->finger < 3)
+			list->finger++;
+
 		switch (code) {
-		case ABS_PRESSURE:
-			if (!list->finger) {
-				if (value > 30)
-					list->finger = 1;
-			} else {
-				if (value < 25)
-					list->finger = 0;
-				else if (list->finger < 3)
-					list->finger++;
-			}
-			break;
-		case ABS_X:
-			if (list->finger >= 3) {
-				list->dx += (value - list->oldx) / 8;
-			}
-			list->oldx = value;
-			break;
-		case ABS_Y:
-			if (list->finger >= 3) {
-				list->dy -= (value - list->oldy) / 8;
-			}
-			list->oldy = value;
-			break;
+			case ABS_X:
+				if (list->finger == 3)
+					list->dx += (value - list->oldx) / 8;
+				list->oldx = value;
+				return;
+			case ABS_Y:
+				if (list->finger == 3)
+					list->dy -= (value - list->oldy) / 8;
+				list->oldy = value;
+				return;
 		}
 		return;
 	}
 
-	/* Handle tablet like devices */
+	/* Handle tablet data */
 	switch (code) {
-	case ABS_X:
-		size = handle->dev->absmax[ABS_X] - handle->dev->absmin[ABS_X];
-		if (size != 0) {
+		case ABS_X:
+			size = handle->dev->absmax[ABS_X] - handle->dev->absmin[ABS_X];
+			if (size == 0) size = xres;
 			list->dx += (value * xres - list->oldx) / size;
 			list->oldx += list->dx * size;
-		} else {
-			list->dx += value - list->oldx;
-			list->oldx += list->dx;
-		}
-		break;
-	case ABS_Y:
-		size = handle->dev->absmax[ABS_Y] - handle->dev->absmin[ABS_Y];
-		if (size != 0) {
+			return;
+		case ABS_Y:
+			size = handle->dev->absmax[ABS_Y] - handle->dev->absmin[ABS_Y];
+			if (size == 0) size = yres;
 			list->dy -= (value * yres - list->oldy) / size;
 			list->oldy -= list->dy * size;
-		} else {
-			list->dy -= value - list->oldy;
-			list->oldy -= list->dy;
-		}
-		break;
+			return;
 	}
 }
 
@@ -166,8 +147,13 @@
 
 				case EV_KEY:
 					switch (code) {
+						case BTN_TOUCH: /* Handle touchpad data */
+							if (test_bit(BTN_TOOL_FINGER, handle->dev->keybit)) {
+								list->finger = value;
+								return;
+							}
 						case BTN_0:
-						case BTN_TOUCH:
+						case BTN_FORWARD:
 						case BTN_LEFT:   index = 0; break;
 						case BTN_4:
 						case BTN_EXTRA:  if (list->mode == 2) { index = 4; break; }
@@ -175,6 +161,7 @@
 						case BTN_1:
 						case BTN_RIGHT:  index = 1; break;
 						case BTN_3:
+						case BTN_BACK:
 						case BTN_SIDE:   if (list->mode == 2) { index = 3; break; }
 						case BTN_2:
 						case BTN_STYLUS2:
@@ -333,7 +320,7 @@
 {
 	struct mousedev_list *list = file->private_data;
 	unsigned char c;
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < count; i++) {
 

