Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262467AbTIURUg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 13:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262466AbTIURUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 13:20:36 -0400
Received: from smtp5.hy.skanova.net ([195.67.199.134]:65531 "EHLO
	smtp5.hy.skanova.net") by vger.kernel.org with ESMTP
	id S262467AbTIURUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 13:20:22 -0400
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: Broken synaptics mouse..
References: <Pine.LNX.4.44.0309110744030.28410-100000@home.osdl.org>
	<Pine.LNX.4.44.0309190129170.32637-100000@telia.com>
	<20030919114806.GD784@ucw.cz>
From: Peter Osterlund <petero2@telia.com>
Date: 21 Sep 2003 19:20:09 +0200
In-Reply-To: <20030919114806.GD784@ucw.cz>
Message-ID: <m2fziqukhi.fsf@p4.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@suse.cz> writes:

> On Fri, Sep 19, 2003 at 01:43:11AM +0200, Peter Osterlund wrote:
> > On Thu, 11 Sep 2003, Linus Torvalds wrote:
> > 
> > > Actually, I think I've changed my mind.
> > > 
> > > How hard would it be to have the "event" driver _notice_ when somebody is 
> > > trying to use it?
> > > 
> > > In particular, what about something that
> > >  - just keeps the touchpad in "ps/2 compatibility mode" by default
> > >  - moves to absolute mode only if somebody actually uses the 
> > >    /dev/input/event0 thing for it (and that would obviously disable the 
> > >    ps/2 mode).
> > > 
> > > That sounds like the simpler setup, especially since the touchpad does a 
> > > pretty good job of PS/2 emulation on its own..
> > 
> > What do you think about the following patch? This patch makes the touchpad
> > stay in compatibility mode until user space explicitly asks for absolute
> > mode by sending a SYN_CONFIG event with value != 0 to the synaptics event
> > device.
> 
> The patch is nice and small, but I'm still not sure if we really want
> input devices to have different modes, changing 'under hands' when one
> process switches the mode while another is having the device open.
> Things will then break.
> 
> I'd really prefer to contain the ugliness in mousedev.c, which then
> could be removed completely in 2.8 or so, when XFree and GPM is already
> well adapted to the event interface.

That's certainly possible too. See patch below. Note though that this
patch has the disadvantage mentioned by Dmitry:

        We also can't just emulate relative events as everything is
        multiplexed into /dev/input/mice and I can see many people
        using Synaptics via /dev/input/eventX and everything else via
        /dev/input/mice as it nicely handles hot plugging (at least I
        use it this way).

 linux-petero/drivers/input/mousedev.c |  102 +++++++++++++++++++++++++---------
 1 files changed, 76 insertions(+), 26 deletions(-)

diff -puN drivers/input/mousedev.c~mousedev-synaptics drivers/input/mousedev.c
--- linux/drivers/input/mousedev.c~mousedev-synaptics	2003-09-21 14:55:34.000000000 +0200
+++ linux-petero/drivers/input/mousedev.c	2003-09-21 18:58:47.000000000 +0200
@@ -26,6 +26,8 @@
 #ifdef CONFIG_INPUT_MOUSEDEV_PSAUX
 #include <linux/miscdevice.h>
 #endif
+#include <linux/serio.h>
+#include "mouse/psmouse.h"		    /* For the PSMOUSE_SYNAPTICS definition */
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("Mouse (ExplorerPS/2) device interfaces");
@@ -58,6 +60,7 @@ struct mousedev_list {
 	unsigned long buttons;
 	unsigned char ready, buffer, bufsiz;
 	unsigned char mode, imexseq, impsseq;
+	int finger;
 };
 
 #define MOUSEDEV_SEQ_LEN	6
@@ -73,12 +76,76 @@ static struct mousedev mousedev_mix;
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
+	if (test_bit(ABS_PRESSURE, handle->dev->absbit) &&
+	    (handle->dev->id.product == PSMOUSE_SYNAPTICS)) {
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
+				list->dy += (value - list->oldy) / 8;
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
 
@@ -87,31 +154,7 @@ static void mousedev_event(struct input_
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
@@ -473,6 +516,13 @@ static struct input_device_id mousedev_i
 		.absbit = { BIT(ABS_X) | BIT(ABS_Y) },
 	},	/* A tablet like device, at least touch detection, two absolute axes */
 
+	{
+		.flags = INPUT_DEVICE_ID_MATCH_EVBIT | INPUT_DEVICE_ID_MATCH_ABSBIT | INPUT_DEVICE_ID_MATCH_PRODUCT,
+		.evbit = { BIT(EV_KEY) | BIT(EV_ABS) },
+		.absbit = { BIT(ABS_X) | BIT(ABS_Y) | BIT(ABS_PRESSURE) },
+		.id.product = PSMOUSE_SYNAPTICS,
+	},	/* A synaptics touchpad */
+
 	{ }, 	/* Terminating entry */
 };
 

_

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
