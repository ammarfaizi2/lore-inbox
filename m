Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbTGAHtg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 03:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbTGAHtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 03:49:35 -0400
Received: from smtp809.mail.sc5.yahoo.com ([66.163.168.188]:15530 "HELO
	smtp809.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261180AbTGAHtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 03:49:32 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [RFC/PATCH] Touchpads in absolute mode (synaptics) and mousedev
Date: Tue, 1 Jul 2003 03:03:51 -0500
User-Agent: KMail/1.5.1
Cc: linux-usb-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200307010303.53405.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was trying to teach mousedev to bind to new synaptics driver. This 
may be useful for gpm and other programs that don't have native event
processing module written yet. Unfortunately absolute to relative 
conversion in mousedev only suits for tablets (digitizers) and not for
touchpads because:

- touchpads are not precise; when I take my finger off touchpad and then
  touch it again somewhere else I do not expect my cursor jump anywhere,
  I only expect cursor to move when I move my finger while pressing 
  touchpad.
- synaptics has Y axis reversed from what mousedev expects.

I tried to modify mousedev to account for differences between touchpads 
in absolute mode and digitizers in absolute mode but all my solutions 
required ugly flags - brrr... So what if we:

1. Modify mousedev so if an input device announces that it generates both
   relative and absolute events mousedev will discard all absolute axis 
   events and will rely on device supplied relative events.
2. Add absolute->relative conversion code to touchpad drivers themselves
   as drivers should know the best how to do that. If they turn out to be
   similar across different touchpads then the common module could be 
   made.

What you think?

Dmitry

diff -urN --exclude-from=/usr/src/exclude 2.5.72-vanilla/drivers/input/mouse/synaptics.c linux-2.5.72/drivers/input/mouse/synaptics.c
--- 2.5.72-vanilla/drivers/input/mouse/synaptics.c	2003-06-19 20:23:32.000000000 -0500
+++ linux-2.5.72/drivers/input/mouse/synaptics.c	2003-07-01 02:54:34.000000000 -0500
@@ -244,9 +244,9 @@
 	set_bit(BTN_FORWARD, psmouse->dev.keybit);
 	set_bit(BTN_BACK, psmouse->dev.keybit);
 
-	clear_bit(EV_REL, psmouse->dev.evbit);
-	clear_bit(REL_X, psmouse->dev.relbit);
-	clear_bit(REL_Y, psmouse->dev.relbit);
+	set_bit(EV_REL, psmouse->dev.evbit);
+	set_bit(REL_X, psmouse->dev.relbit);
+	set_bit(REL_Y, psmouse->dev.relbit);
 
 	return 0;
 
@@ -302,11 +302,14 @@
 /*
  *  called for each full received packet from the touchpad
  */
+#define fx(i)	priv->old_x[(priv->pkt_count - (i)) & 03]
+#define fy(i)	priv->old_y[(priv->pkt_count - (i)) & 03]
 static void synaptics_process_packet(struct psmouse *psmouse)
 {
 	struct input_dev *dev = &psmouse->dev;
 	struct synaptics_data *priv = psmouse->private;
 	struct synaptics_hw_state hw;
+	int dx, dy;
 
 	synaptics_parse_hw_state(priv, &hw);
 
@@ -332,6 +335,21 @@
 		}
 		if (!w_ok)
 			hw.w = 5;
+
+		if (hw.z > SYN_REL_PRESSURE_THRESHOLD) {
+			fx(0) = hw.x;
+			fy(0) = hw.y;
+			if (priv->pkt_count >= 2) {
+				dx = ((fx(0) - fx(1)) / 2 + (fx(1) - fx(2)) / 2) / SYN_REL_DECEL_FACTOR;
+				dy = ((fy(0) - fy(1)) / 2 + (fy(1) - fy(2)) / 2) / SYN_REL_DECEL_FACTOR;
+			      	
+				input_report_rel(dev, REL_X, dx);
+				input_report_rel(dev, REL_Y, -dy);
+			}
+			priv->pkt_count++;
+		} else {
+			priv->pkt_count = 0;
+		}
 	}
 
 	/* Post events */
diff -urN --exclude-from=/usr/src/exclude 2.5.72-vanilla/drivers/input/mouse/synaptics.h linux-2.5.72/drivers/input/mouse/synaptics.h
--- 2.5.72-vanilla/drivers/input/mouse/synaptics.h	2003-06-19 20:23:32.000000000 -0500
+++ linux-2.5.72/drivers/input/mouse/synaptics.h	2003-07-01 03:00:43.000000000 -0500
@@ -72,6 +72,9 @@
 #define SYN_ID_MINOR(i) 		(((i) >> 16) & 0xff)
 #define SYN_ID_IS_SYNAPTICS(i)		((((i) >> 8) & 0xff) == 0x47)
 
+#define SYN_REL_DECEL_FACTOR		8
+#define SYN_REL_PRESSURE_THRESHOLD	30
+
 /*
  * A structure to describe the state of the touchpad hardware (buttons and pad)
  */
@@ -100,6 +103,9 @@
 	int proto_buf_tail;
 
 	int old_w;				/* Previous w value */
+	int old_x[4];
+	int old_y[4];
+	int pkt_count;				/* number of packets with pressure above threshold */
 };
 
 #endif /* _SYNAPTICS_H */
diff -urN --exclude-from=/usr/src/exclude 2.5.72-vanilla/drivers/input/mousedev.c linux-2.5.72/drivers/input/mousedev.c
--- 2.5.72-vanilla/drivers/input/mousedev.c	2003-06-14 14:18:33.000000000 -0500
+++ linux-2.5.72/drivers/input/mousedev.c	2003-07-01 00:37:01.000000000 -0500
@@ -90,25 +90,29 @@
 					if (test_bit(BTN_TRIGGER, handle->dev->keybit))
 						break;
 					switch (code) {
-						case ABS_X:	
-							size = handle->dev->absmax[ABS_X] - handle->dev->absmin[ABS_X];
-							if (size != 0) {
-								list->dx += (value * xres - list->oldx) / size;
-								list->oldx += list->dx * size;
-							} else {
-								list->dx += value - list->oldx;
-								list->oldx += list->dx;
+						case ABS_X:
+							if (!test_bit(REL_X, handle->dev->relbit)) {	
+								size = handle->dev->absmax[ABS_X] - handle->dev->absmin[ABS_X];
+								if (size != 0) {
+									list->dx += (value * xres - list->oldx) / size;
+									list->oldx += list->dx * size;
+								} else {
+									list->dx += value - list->oldx;
+									list->oldx += list->dx;
+								}
 							}
 							break;
 
 						case ABS_Y:
-							size = handle->dev->absmax[ABS_Y] - handle->dev->absmin[ABS_Y];
-							if (size != 0) {
-								list->dy -= (value * yres - list->oldy) / size;
-								list->oldy -= list->dy * size;
-							} else {
-								list->dy -= value - list->oldy;
-								list->oldy -= list->dy;
+							if (!test_bit(REL_Y, handle->dev->relbit)) {	
+								size = handle->dev->absmax[ABS_Y] - handle->dev->absmin[ABS_Y];
+								if (size != 0) {
+									list->dy -= (value * yres - list->oldy) / size;
+									list->oldy -= list->dy * size;
+								} else {
+									list->dy -= value - list->oldy;
+									list->oldy -= list->dy;
+								}
 							}
 							break;
 					}
