Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264987AbTLWHmQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 02:42:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265030AbTLWHmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 02:42:16 -0500
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:17001 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264987AbTLWHmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 02:42:05 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Thomas Molina <tmolina@cablespeed.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: synaptics mouse jitter in 2.6.0
Date: Tue, 23 Dec 2003 02:41:49 -0500
User-Agent: KMail/1.5.4
References: <Pine.LNX.4.58.0312222127530.18261@localhost.localdomain> <200312222238.17076.dtor_core@ameritech.net>
In-Reply-To: <200312222238.17076.dtor_core@ameritech.net>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Peter Osterlund <petero2@telia.com>,
       Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312230241.52168.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 December 2003 10:38 pm, Dmitry Torokhov wrote:
> On Monday 22 December 2003 09:40 pm, Thomas Molina wrote:
> > I am running Fedora Core 1 updated on a Presario 12XL325 laptop.  For
> > a long time during the 2.5 series I couldn't use the synaptics
> > support. As a result, I haven't tested this for some time.  I just
> > compiled a fresh 2.6.0 tree, included synaptics support and now I am
> > getting mouse jitter.
> >
<..SKIP..>
>
> Right, I think I see it. The mousedev module does not do any smoothing
> of the reported coordinates which would cause the jitter you are
> seeing. Normally drivers do 3- or 4-point average.
>
> I'll cook up something to fix it. Meanwhile could you give a try Peter
> Osterlund XFree86 Synaptics driver:
> http://w1.894.telia.com/~u89404340/touchpad/index.html
>

OK, here it is. It will apply against 2.6.0 although will complain about
some offsets as I have extra stuff in my tree...

Dmitry

===================================================================


ChangeSet@1.1522, 2003-12-23 02:24:12-05:00, dtor_core@ameritech.net
  Input: when calculating deltas for touchpads that generate
         absolute events use average over the last 3 packets
         to remove jitter


 mouse/synaptics.c |   11 ++++---
 mousedev.c        |   84 +++++++++++++++++++++++++++++++-----------------------
 2 files changed, 56 insertions(+), 39 deletions(-)


===================================================================



diff -Nru a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
--- a/drivers/input/mouse/synaptics.c	Tue Dec 23 02:25:14 2003
+++ b/drivers/input/mouse/synaptics.c	Tue Dec 23 02:25:14 2003
@@ -553,15 +553,18 @@
 		finger_width = 0;
 	}
 
-	/* Post events */
+	/* Post events
+	 * BTN_TOUCH has to be first as mousedev relies on it when doing
+	 * absolute -> relative conversion
+	 */
+	if (hw.z > 30) input_report_key(dev, BTN_TOUCH, 1);
+	if (hw.z < 25) input_report_key(dev, BTN_TOUCH, 0);
+
 	if (hw.z > 0) {
 		input_report_abs(dev, ABS_X, hw.x);
 		input_report_abs(dev, ABS_Y, YMAX_NOMINAL + YMIN_NOMINAL - hw.y);
 	}
 	input_report_abs(dev, ABS_PRESSURE, hw.z);
-
-	if (hw.z > 30) input_report_key(dev, BTN_TOUCH, 1);
-	if (hw.z < 25) input_report_key(dev, BTN_TOUCH, 0);
 
 	input_report_abs(dev, ABS_TOOL_WIDTH, finger_width);
 	input_report_key(dev, BTN_TOOL_FINGER, num_fingers == 1);
diff -Nru a/drivers/input/mousedev.c b/drivers/input/mousedev.c
--- a/drivers/input/mousedev.c	Tue Dec 23 02:25:14 2003
+++ b/drivers/input/mousedev.c	Tue Dec 23 02:25:14 2003
@@ -53,12 +53,14 @@
 	struct fasync_struct *fasync;
 	struct mousedev *mousedev;
 	struct list_head node;
-	int dx, dy, dz, oldx, oldy;
-	signed char ps2[6];
+	int dx, dy, dz;
+	int old_x[4], old_y[4];
 	unsigned long buttons;
+	signed char ps2[6];
 	unsigned char ready, buffer, bufsiz;
 	unsigned char mode, imexseq, impsseq;
-	int finger;
+	unsigned int pkt_count;
+	unsigned char touch;
 };
 
 #define MOUSEDEV_SEQ_LEN	6
@@ -74,49 +76,49 @@
 static int xres = CONFIG_INPUT_MOUSEDEV_SCREEN_X;
 static int yres = CONFIG_INPUT_MOUSEDEV_SCREEN_Y;
 
+#define fx(i)  (list->old_x[(list->pkt_count - (i)) & 03])
+#define fy(i)  (list->old_y[(list->pkt_count - (i)) & 03])
+
 static void mousedev_abs_event(struct input_handle *handle, struct mousedev_list *list, unsigned int code, int value)
 {
 	int size;
+	int touchpad;
 
 	/* Ignore joysticks */
 	if (test_bit(BTN_TRIGGER, handle->dev->keybit))
 		return;
 
-	/* Handle touchpad data */
-	if (test_bit(BTN_TOOL_FINGER, handle->dev->keybit)) {
+	touchpad = test_bit(BTN_TOOL_FINGER, handle->dev->keybit);
 
-		if (list->finger && list->finger < 3)
-			list->finger++;
-
-		switch (code) {
-			case ABS_X:
-				if (list->finger == 3)
-					list->dx += (value - list->oldx) / 8;
-				list->oldx = value;
-				return;
-			case ABS_Y:
-				if (list->finger == 3)
-					list->dy -= (value - list->oldy) / 8;
-				list->oldy = value;
-				return;
-		}
-		return;
-	}
-
-	/* Handle tablet data */
 	switch (code) {
 		case ABS_X:
-			size = handle->dev->absmax[ABS_X] - handle->dev->absmin[ABS_X];
-			if (size == 0) size = xres;
-			list->dx += (value * xres - list->oldx) / size;
-			list->oldx += list->dx * size;
-			return;
+			if (touchpad) {
+				if (list->touch) {
+					fx(0) = value;
+					if (list->pkt_count >= 2)
+						list->dx = ((fx(0) - fx(1)) / 2 + (fx(1) - fx(2)) / 2) / 8;
+				}
+			} else {
+				size = handle->dev->absmax[ABS_X] - handle->dev->absmin[ABS_X];
+				if (size == 0) size = xres;
+				list->dx += (value * xres - list->old_x[0]) / size;
+				list->old_x[0] += list->dx * size;
+			}
+			break;
 		case ABS_Y:
-			size = handle->dev->absmax[ABS_Y] - handle->dev->absmin[ABS_Y];
-			if (size == 0) size = yres;
-			list->dy -= (value * yres - list->oldy) / size;
-			list->oldy -= list->dy * size;
-			return;
+			if (touchpad) {
+				if (list->touch) {
+					fy(0) = value;
+					if (list->pkt_count >= 2)
+						list->dy = -((fy(0) - fy(1)) / 2 + (fy(1) - fy(2)) / 2) / 8;
+				}
+			} else {
+				size = handle->dev->absmax[ABS_Y] - handle->dev->absmin[ABS_Y];
+				if (size == 0) size = yres;
+				list->dy -= (value * yres - list->old_y[0]) / size;
+				list->old_y[0] -= list->dy * size;
+			}
+			break;
 	}
 }
 
@@ -149,7 +151,9 @@
 					switch (code) {
 						case BTN_TOUCH: /* Handle touchpad data */
 							if (test_bit(BTN_TOOL_FINGER, handle->dev->keybit)) {
-								list->finger = value;
+								list->touch = value;
+								if (!list->touch)
+									list->pkt_count = 0;
 								return;
 							}
 						case BTN_0:
@@ -178,6 +182,16 @@
 				case EV_SYN:
 					switch (code) {
 						case SYN_REPORT:
+							if (list->touch) {
+								list->pkt_count++;
+								/* Input system eats duplicate events, 
+								 * but we need all of them to do correct
+								 * averaging so apply present one forward
+								 */
+								fx(0) = fx(1);
+								fy(0) = fy(1);
+							}
+
 							list->ready = 1;
 							kill_fasync(&list->fasync, SIGIO, POLL_IN);
 							wake = 1;
