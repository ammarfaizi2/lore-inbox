Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261750AbTJHTDg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 15:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbTJHTDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 15:03:36 -0400
Received: from smtp4.hy.skanova.net ([195.67.199.133]:56802 "EHLO
	smtp4.hy.skanova.net") by vger.kernel.org with ESMTP
	id S261750AbTJHTD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 15:03:26 -0400
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Neil Brown <neilb@cse.unsw.edu.au>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Johan Braennlund <spahmtrahp@yahoo.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: PATCH - ALPS glidepoint/dualpoint driver for 2.5.7x
References: <16123.44602.150927.280989@gargle.gargle.HOWL>
	<1056699687.599.2.camel@teapot.felipe-alfaro.com>
	<16124.2893.587755.586343@gargle.gargle.HOWL>
	<m2smm7oc8s.fsf@p4.localdomain> <20031005171724.GA13141@ucw.cz>
From: Peter Osterlund <petero2@telia.com>
Date: 08 Oct 2003 21:01:28 +0200
In-Reply-To: <20031005171724.GA13141@ucw.cz>
Message-ID: <m2zngbo8on.fsf@p4.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@suse.cz> writes:

> On Sun, Oct 05, 2003 at 06:55:31PM +0200, Peter Osterlund wrote:
>  
> > I have updated your patch for kernel 2.6.0-test6-bk6 and made it
> > report events compatible with the synaptics touchpad kernel driver.
> > This should make it possible to use an ALPS device with the XFree86
> > synaptics driver:
> > 
> >         http://w1.894.telia.com/~u89404340/touchpad/index.html
> > 
> > Using this driver will give you edge scrolling and similar things.
> > 
> > I don't have an ALPS GlidePoint so I haven't been able to test this
> > patch at all. Test reports are appreciated. You probably need to
> > change a few parameters in the X configuration, like edge parameters
> > and finger pressure thresholds. Also note that the auto detection will
> > not work with an ALPS device, so you have to use Protocol="event" and
> > Device="/dev/input/eventN" for some value of N.
> 
> Very nice. Could you also make it a separate file? I think it's enough
> code to make that worth it ...

Here is a new patch that moves the ALPS code to a separate file. The
logic in ALPS_process_packet() has also gone through a few iterations
with Johan Braennlund as a tester, so that it actually even works now,
at least with his touchpad.

Note though that the potential problems mentioned by Neil Brown in his
initial announcement have not been dealt with:

    It appears (but see 1) that it is not possible to reliably detect
    an ALPS device.
    ...
    So the current code always sends the ALPS set-absolute-mode
    sequence (4 disables before the enable) unless a
    non-3-byte-protocol device was detected.

    There are two consequences of always assuming an ALPS that may not
    be good.
     1) The mouse always claims to generate various ABS events even
       when there might not be any ABS-generating device behind the
       mouse.
     2) The driver could misinterpret a normal mouse event that
       overflowed in the negative direction for both X and Y as part
       of an ALPS absolute event.  This is because ALPS absolute
       events are detected by checking if the top 5 bits of the first
       byte are all one.   I doubt this is a real problem as double
       overflows are very unlikely (aren't they?)


 linux-petero/drivers/input/mouse/Makefile       |    2 
 linux-petero/drivers/input/mouse/alps.c         |  131 ++++++++++++++++++++++++
 linux-petero/drivers/input/mouse/alps.h         |   17 +++
 linux-petero/drivers/input/mouse/psmouse-base.c |    7 +
 linux-petero/drivers/input/mouse/psmouse.h      |    1 
 5 files changed, 157 insertions(+), 1 deletion(-)

diff -puN drivers/input/mouse/Makefile~alps drivers/input/mouse/Makefile
--- linux/drivers/input/mouse/Makefile~alps	2003-10-08 18:30:40.000000000 +0200
+++ linux-petero/drivers/input/mouse/Makefile	2003-10-08 18:30:40.000000000 +0200
@@ -14,5 +14,5 @@ obj-$(CONFIG_MOUSE_PC9800)	+= 98busmouse
 obj-$(CONFIG_MOUSE_PS2)		+= psmouse.o
 obj-$(CONFIG_MOUSE_SERIAL)	+= sermouse.o
 
-psmouse-objs				:= psmouse-base.o logips2pp.o
+psmouse-objs				:= psmouse-base.o logips2pp.o alps.o
 psmouse-$(CONFIG_MOUSE_PS2_SYNAPTICS)	+= synaptics.o
diff -puN drivers/input/mouse/alps.c~alps drivers/input/mouse/alps.c
--- linux/drivers/input/mouse/alps.c~alps	2003-10-08 18:30:40.000000000 +0200
+++ linux-petero/drivers/input/mouse/alps.c	2003-10-08 18:30:40.000000000 +0200
@@ -0,0 +1,131 @@
+/*
+ * Logitech PS/2++ mouse driver
+ *
+ * Copyright (c) 2003 Neil Brown <neilb@cse.unsw.edu.au>
+ * Copyright (c) 2003 Peter Osterlund <petero2@telia.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#include "alps.h"
+#include <linux/input.h>
+#include <linux/serio.h>
+#include "psmouse.h"
+
+static inline void set_abs_params(struct input_dev *dev, int axis, int min, int max, int fuzz, int flat)
+{
+	dev->absmin[axis] = min;
+	dev->absmax[axis] = max;
+	dev->absfuzz[axis] = fuzz;
+	dev->absflat[axis] = flat;
+
+	set_bit(axis, dev->absbit);
+}
+
+/*
+ * If it is a 3-byte setting and we are allowed to use extensions,
+ * then it could be an ALPS Glidepoint, so send the init sequence just
+ * incase. i.e. 4 consecutive "disable"s before the "enable"
+ */
+
+void ALPS_initialize(struct psmouse *psmouse)
+{
+	if (psmouse->type < PSMOUSE_GENPS) {
+		psmouse_command(psmouse, NULL, PSMOUSE_CMD_DISABLE);
+		psmouse_command(psmouse, NULL, PSMOUSE_CMD_DISABLE);
+		psmouse_command(psmouse, NULL, PSMOUSE_CMD_DISABLE);
+		psmouse_command(psmouse, NULL, PSMOUSE_CMD_DISABLE);
+
+		set_bit(BTN_TOUCH, psmouse->dev.keybit);
+		set_bit(BTN_BACK, psmouse->dev.keybit);
+		set_bit(BTN_FORWARD, psmouse->dev.keybit);
+		set_bit(BTN_TOOL_FINGER, psmouse->dev.keybit);
+		set_bit(EV_ABS, psmouse->dev.evbit);
+		set_abs_params(&psmouse->dev, ABS_X, 0, 0, 0, 0);
+		set_abs_params(&psmouse->dev, ABS_Y, 0, 0, 0, 0);
+		set_abs_params(&psmouse->dev, ABS_PRESSURE, 0, 127, 0, 0);
+	}
+}
+
+/*
+ * ALPS abolute Mode
+ * byte 0: 1 1 1 1 1 mid0 rig0 lef0
+ * byte 1: 0 x6 x5 x4 x3 x2 x1 x0
+ * byte 2: 0 x10 x9 x8 x7 up1 fin ges
+ * byte 3: 0 y9 y8 y7 1 mid1 rig1 lef1
+ * byte 4: 0 y6 y5 y4 y3 y2 y1 y0
+ * byte 5: 0 z6 z5 z4 z3 z2 z1 z0
+ *
+ * On a dualpoint, {mid,rig,lef}0 are the stick, 1 are the pad.
+ * We just 'or' them together for now.
+ * We also send 'ges'ture as BTN_TOUCH
+ *
+ * The touchpad on an 'Acer Aspire' has 4 buttons:
+ *   left,right,up,down.
+ * This device always sets {mid,rig,lef}0 to 1 and
+ * reflects left,right,down,up in lef1,rig1,mid1,up1.
+ */
+
+static void ALPS_process_packet(struct psmouse *psmouse, struct pt_regs *regs)
+{
+	unsigned char *packet = psmouse->packet;
+	struct input_dev *dev = &psmouse->dev;
+	int x, y, z;
+	int left = 0, right = 0, middle = 0;
+
+	input_regs(dev, regs);
+
+	x = (packet[1] & 0x7f) | ((packet[2] & 0x78)<<(7-3));
+	y = (packet[4] & 0x7f) | ((packet[3] & 0x70)<<(7-4));
+	z = packet[5];
+
+	if (z > 0) {
+		input_report_abs(dev, ABS_X, x);
+		input_report_abs(dev, ABS_Y, y);
+	}
+	input_report_abs(dev, ABS_PRESSURE, z);
+	input_report_key(dev, BTN_TOOL_FINGER, z > 0);
+
+	if (z > 30) input_report_key(dev, BTN_TOUCH, 1);
+	if (z < 25) input_report_key(dev, BTN_TOUCH, 0);
+
+	left  |= (packet[2]     ) & 1;
+	left  |= (packet[3]     ) & 1;
+	right |= (packet[3] >> 1) & 1;
+	if (packet[0] == 0xff) {
+		input_report_key(dev, BTN_BACK,    (packet[3] >> 2) & 1);
+		input_report_key(dev, BTN_FORWARD, (packet[2] >> 2) & 1);
+	} else {
+		left   |= (packet[0]     ) & 1;
+		right  |= (packet[0] >> 1) & 1;
+		middle |= (packet[0] >> 2) & 1;
+		middle |= (packet[3] >> 2) & 1;
+	}
+
+	input_report_key(dev, BTN_LEFT, left);
+	input_report_key(dev, BTN_RIGHT, right);
+	input_report_key(dev, BTN_MIDDLE, middle);
+
+	input_sync(dev);
+}
+
+int ALPS_process_byte(struct psmouse *psmouse, struct pt_regs *regs)
+{
+	if (psmouse->type >= PSMOUSE_GENPS)
+		return -1;
+
+	/* ALPS absolute mode packets start with 0b11111mrl
+	 * Normal mouse packets are extremely unlikely to overflow both
+	 * x and y
+	 */
+	if ((psmouse->packet[0] & 0xf8) != 0xf8)
+		return -1;
+
+	if (psmouse->pktcnt == 6) {
+		ALPS_process_packet(psmouse, regs);
+		psmouse->pktcnt = 0;
+	}
+	return 0;
+}
diff -puN drivers/input/mouse/alps.h~alps drivers/input/mouse/alps.h
--- linux/drivers/input/mouse/alps.h~alps	2003-10-08 18:30:40.000000000 +0200
+++ linux-petero/drivers/input/mouse/alps.h	2003-10-08 20:23:41.000000000 +0200
@@ -0,0 +1,17 @@
+/*
+ * Logitech PS/2++ mouse driver
+ *
+ * Copyright (c) 2003 Peter Osterlund <petero2@telia.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#ifndef _ALPS_H
+#define _ALPS_H
+struct psmouse;
+struct pt_regs;
+void ALPS_initialize(struct psmouse *psmouse);
+int ALPS_process_byte(struct psmouse *psmouse, struct pt_regs *regs);
+#endif
diff -puN drivers/input/mouse/psmouse-base.c~alps drivers/input/mouse/psmouse-base.c
--- linux/drivers/input/mouse/psmouse-base.c~alps	2003-10-08 18:30:40.000000000 +0200
+++ linux-petero/drivers/input/mouse/psmouse-base.c	2003-10-08 18:30:40.000000000 +0200
@@ -21,6 +21,7 @@
 #include "psmouse.h"
 #include "synaptics.h"
 #include "logips2pp.h"
+#include "alps.h"
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
 MODULE_DESCRIPTION("PS/2 mouse driver");
@@ -180,6 +181,9 @@ static irqreturn_t psmouse_interrupt(str
 		goto out;
 	}
 
+	if (!psmouse_noext && !ALPS_process_byte(psmouse, regs))
+		goto out;
+
 	if (psmouse->pktcnt == 3 + (psmouse->type >= PSMOUSE_GENPS)) {
 		psmouse_process_packet(psmouse, regs);
 		psmouse->pktcnt = 0;
@@ -486,6 +490,9 @@ static void psmouse_initialize(struct ps
  */
 
 	psmouse_command(psmouse, param, PSMOUSE_CMD_SETSTREAM);
+
+	if (!psmouse_noext)
+		ALPS_initialize(psmouse);
 }
 
 /*
diff -puN drivers/input/mouse/psmouse.h~alps drivers/input/mouse/psmouse.h
--- linux/drivers/input/mouse/psmouse.h~alps	2003-10-08 18:30:40.000000000 +0200
+++ linux-petero/drivers/input/mouse/psmouse.h	2003-10-08 18:30:40.000000000 +0200
@@ -9,6 +9,7 @@
 #define PSMOUSE_CMD_GETID	0x02f2
 #define PSMOUSE_CMD_SETRATE	0x10f3
 #define PSMOUSE_CMD_ENABLE	0x00f4
+#define PSMOUSE_CMD_DISABLE	0x00f5
 #define PSMOUSE_CMD_RESET_DIS	0x00f6
 #define PSMOUSE_CMD_RESET_BAT	0x02ff
 

_

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
