Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264638AbUFGMBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264638AbUFGMBv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 08:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264640AbUFGMBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 08:01:05 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:16257 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S264638AbUFGL5P convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 07:57:15 -0400
To: torvalds@osdl.org, akpm@osdl.org, vojtech@ucw.cz,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
Message-Id: <10866093551505@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <10866093542233@twilight.ucw.cz>
Mime-Version: 1.0
Date: Mon, 7 Jun 2004 13:55:55 +0200
Subject: [PATCH 35/39] input: Mousedev - better multiplex absolute and relative devices
X-Mailer: gregkh_patchbomb_levon_offspring
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input-for-linus

===================================================================

ChangeSet@1.1587.27.15, 2004-05-10 01:44:03-05:00, dtor_core@ameritech.net
  Input: mousedev - better multiplex absolute and relative devices;
         cleanups


 mousedev.c |  260 ++++++++++++++++++++++++++++++++++---------------------------
 1 files changed, 146 insertions(+), 114 deletions(-)

===================================================================

diff -Nru a/drivers/input/mousedev.c b/drivers/input/mousedev.c
--- a/drivers/input/mousedev.c	2004-06-07 13:10:38 +02:00
+++ b/drivers/input/mousedev.c	2004-06-07 13:10:38 +02:00
@@ -2,6 +2,7 @@
  * Input driver to ExplorerPS/2 device driver module.
  *
  * Copyright (c) 1999-2002 Vojtech Pavlik
+ * Copyright (c) 2004      Dmitry Torokhov
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as published by
@@ -47,15 +48,24 @@
 module_param(yres, uint, 0);
 MODULE_PARM_DESC(yres, "Vertical screen resolution");
 
+struct mousedev_motion {
+	int dx, dy, dz;
+};
+
 struct mousedev {
 	int exist;
 	int open;
 	int minor;
-	int misc;
 	char name[16];
 	wait_queue_head_t wait;
 	struct list_head list;
 	struct input_handle handle;
+
+	struct mousedev_motion packet;
+	unsigned long buttons;
+	unsigned int pkt_count;
+	int old_x[4], old_y[4];
+	unsigned int touch;
 };
 
 struct mousedev_list {
@@ -63,13 +73,10 @@
 	struct mousedev *mousedev;
 	struct list_head node;
 	int dx, dy, dz;
-	int old_x[4], old_y[4];
 	unsigned long buttons;
 	signed char ps2[6];
 	unsigned char ready, buffer, bufsiz;
 	unsigned char mode, imexseq, impsseq;
-	unsigned int pkt_count;
-	unsigned char touch;
 };
 
 #define MOUSEDEV_SEQ_LEN	6
@@ -82,135 +89,157 @@
 static struct mousedev *mousedev_table[MOUSEDEV_MINORS];
 static struct mousedev mousedev_mix;
 
-#define fx(i)  (list->old_x[(list->pkt_count - (i)) & 03])
-#define fy(i)  (list->old_y[(list->pkt_count - (i)) & 03])
+#define fx(i)  (mousedev->old_x[(mousedev->pkt_count - (i)) & 03])
+#define fy(i)  (mousedev->old_y[(mousedev->pkt_count - (i)) & 03])
 
-static void mousedev_abs_event(struct input_handle *handle, struct mousedev_list *list, unsigned int code, int value)
+static void mousedev_touchpad_event(struct mousedev *mousedev, unsigned int code, int value)
 {
-	int size;
-	int touchpad;
+	if (mousedev->touch) {
+		switch (code) {
+			case ABS_X:
+				fx(0) = value;
+				if (mousedev->pkt_count >= 2)
+					mousedev->packet.dx = ((fx(0) - fx(1)) / 2 + (fx(1) - fx(2)) / 2) / 8;
+				break;
 
-	/* Ignore joysticks */
-	if (test_bit(BTN_TRIGGER, handle->dev->keybit))
-		return;
+			case ABS_Y:
+				fy(0) = value;
+				if (mousedev->pkt_count >= 2)
+					mousedev->packet.dy = -((fy(0) - fy(1)) / 2 + (fy(1) - fy(2)) / 2) / 8;
+				break;
+		}
+	}
+}
 
-	touchpad = test_bit(BTN_TOOL_FINGER, handle->dev->keybit);
+static void mousedev_abs_event(struct input_dev *dev, struct mousedev *mousedev, unsigned int code, int value)
+{
+	int size;
 
 	switch (code) {
 		case ABS_X:
-			if (touchpad) {
-				if (list->touch) {
-					fx(0) = value;
-					if (list->pkt_count >= 2)
-						list->dx = ((fx(0) - fx(1)) / 2 + (fx(1) - fx(2)) / 2) / 8;
-				}
-			} else {
-				size = handle->dev->absmax[ABS_X] - handle->dev->absmin[ABS_X];
-				if (size == 0) size = xres;
-				list->dx += (value * xres - list->old_x[0]) / size;
-				list->old_x[0] += list->dx * size;
-			}
+			size = dev->absmax[ABS_X] - dev->absmin[ABS_X];
+			if (size == 0) size = xres;
+			mousedev->packet.dx = (value * xres - mousedev->old_x[0]) / size;
+			mousedev->old_x[0] = mousedev->packet.dx * size;
 			break;
+
 		case ABS_Y:
-			if (touchpad) {
-				if (list->touch) {
-					fy(0) = value;
-					if (list->pkt_count >= 2)
-						list->dy = -((fy(0) - fy(1)) / 2 + (fy(1) - fy(2)) / 2) / 8;
-				}
-			} else {
-				size = handle->dev->absmax[ABS_Y] - handle->dev->absmin[ABS_Y];
-				if (size == 0) size = yres;
-				list->dy -= (value * yres - list->old_y[0]) / size;
-				list->old_y[0] -= list->dy * size;
-			}
+			size = dev->absmax[ABS_Y] - dev->absmin[ABS_Y];
+			if (size == 0) size = yres;
+			mousedev->packet.dy = (value * yres - mousedev->old_y[0]) / size;
+			mousedev->old_y[0] = mousedev->packet.dy * size;
 			break;
 	}
 }
 
-static void mousedev_event(struct input_handle *handle, unsigned int type, unsigned int code, int value)
+static void mousedev_rel_event(struct mousedev *mousedev, unsigned int code, int value)
+{
+	switch (code) {
+		case REL_X:	mousedev->packet.dx += value; break;
+		case REL_Y:	mousedev->packet.dy -= value; break;
+		case REL_WHEEL:	mousedev->packet.dz -= value; break;
+	}
+}
+
+static void mousedev_key_event(struct mousedev *mousedev, unsigned int code, int value)
+{
+	int index;
+
+	switch (code) {
+		case BTN_TOUCH:
+		case BTN_0:
+		case BTN_FORWARD:
+		case BTN_LEFT:		index = 0; break;
+		case BTN_STYLUS:
+		case BTN_1:
+		case BTN_RIGHT:		index = 1; break;
+		case BTN_2:
+		case BTN_STYLUS2:
+		case BTN_MIDDLE:	index = 2; break;
+		case BTN_3:
+		case BTN_BACK:
+		case BTN_SIDE:		index = 3; break;
+		case BTN_4:
+		case BTN_EXTRA:		index = 4; break;
+		default: 		return;
+	}
+
+	if (value) {
+		set_bit(index, &mousedev->buttons);
+		set_bit(index, &mousedev_mix.buttons);
+	} else {
+		clear_bit(index, &mousedev->buttons);
+		clear_bit(index, &mousedev_mix.buttons);
+	}
+}
+
+static void mousedev_notify_readers(struct mousedev *mousedev, struct mousedev_motion *packet)
 {
-	struct mousedev *mousedevs[3] = { handle->private, &mousedev_mix, NULL };
-	struct mousedev **mousedev = mousedevs;
 	struct mousedev_list *list;
-	int index, wake;
 
-	while (*mousedev) {
+	list_for_each_entry(list, &mousedev->list, node) {
+		list->dx += packet->dx;
+		list->dy += packet->dy;
+		list->dz += packet->dz;
+		list->buttons = mousedev->buttons;
+		list->ready = 1;
+		kill_fasync(&list->fasync, SIGIO, POLL_IN);
+	}
+
+	wake_up_interruptible(&mousedev->wait);
+}
+
+static void mousedev_event(struct input_handle *handle, unsigned int type, unsigned int code, int value)
+{
+	struct mousedev *mousedev = handle->private;
+
+	switch (type) {
+		case EV_ABS:
+			/* Ignore joysticks */
+			if (test_bit(BTN_TRIGGER, handle->dev->keybit))
+				return;
+
+			if (test_bit(BTN_TOOL_FINGER, handle->dev->keybit))
+				mousedev_touchpad_event(mousedev, code, value);
+			else
+				mousedev_abs_event(handle->dev, mousedev, code, value);
 
-		wake = 0;
+			break;
+
+		case EV_REL:
+			mousedev_rel_event(mousedev, code, value);
+			break;
 
-		list_for_each_entry(list, &(*mousedev)->list, node)
-			switch (type) {
-				case EV_ABS:
-					mousedev_abs_event(handle, list, code, value);
-					break;
-
-				case EV_REL:
-					switch (code) {
-						case REL_X:	list->dx += value; break;
-						case REL_Y:	list->dy -= value; break;
-						case REL_WHEEL:	if (list->mode) list->dz -= value; break;
-					}
-					break;
-
-				case EV_KEY:
-					if (code == BTN_TOUCH && test_bit(BTN_TOOL_FINGER, handle->dev->keybit)) {
-						/* Handle touchpad data */
-						list->touch = value;
-						if (!list->touch)
-							list->pkt_count = 0;
-						break;
-					}
-
-					switch (code) {
-						case BTN_TOUCH:
-						case BTN_0:
-						case BTN_FORWARD:
-						case BTN_LEFT:   index = 0; break;
-						case BTN_4:
-						case BTN_EXTRA:  if (list->mode == 2) { index = 4; break; }
-						case BTN_STYLUS:
-						case BTN_1:
-						case BTN_RIGHT:  index = 1; break;
-						case BTN_3:
-						case BTN_BACK:
-						case BTN_SIDE:   if (list->mode == 2) { index = 3; break; }
-						case BTN_2:
-						case BTN_STYLUS2:
-						case BTN_MIDDLE: index = 2; break;
-						default: return;
-					}
-					switch (value) {
-						case 0: clear_bit(index, &list->buttons); break;
-						case 1: set_bit(index, &list->buttons); break;
-						case 2: return;
-					}
-					break;
-
-				case EV_SYN:
-					switch (code) {
-						case SYN_REPORT:
-							if (list->touch) {
-								list->pkt_count++;
-								/* Input system eats duplicate events,
-								 * but we need all of them to do correct
-								 * averaging so apply present one forward
-								 */
-								fx(0) = fx(1);
-								fy(0) = fy(1);
-							}
-
-							list->ready = 1;
-							kill_fasync(&list->fasync, SIGIO, POLL_IN);
-							wake = 1;
-							break;
-					}
+		case EV_KEY:
+			if (value != 2) {
+				if (code == BTN_TOUCH && test_bit(BTN_TOOL_FINGER, handle->dev->keybit)) {
+					/* Handle touchpad data */
+					mousedev->touch = value;
+					if (!mousedev->touch)
+						mousedev->pkt_count = 0;
+				}
+				else
+					mousedev_key_event(mousedev, code, value);
 			}
+			break;
+
+		case EV_SYN:
+			if (code == SYN_REPORT) {
+				if (mousedev->touch) {
+					mousedev->pkt_count++;
+					/* Input system eats duplicate events, but we need all of them
+					 * to do correct averaging so apply present one forward
+			 		 */
+					fx(0) = fx(1);
+					fy(0) = fy(1);
+				}
 
-		if (wake)
-			wake_up_interruptible(&((*mousedev)->wait));
+				mousedev_notify_readers(mousedev, &mousedev->packet);
+				mousedev_notify_readers(&mousedev_mix, &mousedev->packet);
 
-		mousedev++;
+				memset(&mousedev->packet, 0, sizeof(struct mousedev_motion));
+			}
+			break;
 	}
 }
 
@@ -326,6 +355,8 @@
 		list->dz -= list->ps2[off + 3];
 		list->ps2[off + 3] = (list->ps2[off + 3] & 0x0f) | ((list->buttons & 0x18) << 1);
 		list->bufsiz++;
+	} else {
+		list->ps2[off] |= ((list->buttons & 0x10) >> 3) | ((list->buttons & 0x08) >> 1);
 	}
 
 	if (list->mode == 1) {
@@ -553,6 +584,7 @@
 static struct miscdevice psaux_mouse = {
 	PSMOUSE_MINOR, "psaux", &mousedev_fops
 };
+static int psaux_registered;
 #endif
 
 static int __init mousedev_init(void)
@@ -572,7 +604,7 @@
 				NULL, "mice");
 
 #ifdef CONFIG_INPUT_MOUSEDEV_PSAUX
-	if (!(mousedev_mix.misc = !misc_register(&psaux_mouse)))
+	if (!(psaux_registered = !misc_register(&psaux_mouse)))
 		printk(KERN_WARNING "mice: could not misc_register the device\n");
 #endif
 
@@ -584,7 +616,7 @@
 static void __exit mousedev_exit(void)
 {
 #ifdef CONFIG_INPUT_MOUSEDEV_PSAUX
-	if (mousedev_mix.misc)
+	if (psaux_registered)
 		misc_deregister(&psaux_mouse);
 #endif
 	devfs_remove("input/mice");

