Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263154AbTJEQzu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 12:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263158AbTJEQzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 12:55:50 -0400
Received: from smtp4.hy.skanova.net ([195.67.199.133]:55526 "EHLO
	smtp4.hy.skanova.net") by vger.kernel.org with ESMTP
	id S263154AbTJEQzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 12:55:45 -0400
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Vojtech Pavlik <vojtech@suse.cz>,
       Johan Braennlund <spahmtrahp@yahoo.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: PATCH - ALPS glidepoint/dualpoint driver for 2.5.7x
References: <16123.44602.150927.280989@gargle.gargle.HOWL>
	<1056699687.599.2.camel@teapot.felipe-alfaro.com>
	<16124.2893.587755.586343@gargle.gargle.HOWL>
From: Peter Osterlund <petero2@telia.com>
Date: 05 Oct 2003 18:55:31 +0200
In-Reply-To: <16124.2893.587755.586343@gargle.gargle.HOWL>
Message-ID: <m2smm7oc8s.fsf@p4.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown <neilb@cse.unsw.edu.au> writes:

> On  June 27, felipe_alfaro@linuxmail.org wrote:
> > 
> > Is there any trick to force enabling ALPS support? I'm using a NEC
> > Chrom@ laptop with an ALPS GlidePoint touchpad, 2.5.73-mm1 and your
> > patch, but I can't seem to get the enhanced functionality of my
> > touchpad, like using the edges of the touchpad to simulate the wheel or
> > else. It seems to behave like a normal PS/2 mouse.
> 
> Well, if it behaves like a normal PS/2 mouse, it is quite possibly
> working :-)  
> That patch didn't add any obvious new functionality.  It just change
> things to the ALPS device was used in absolute mode.
> If you manage to find evtest.c, you can watch events on
> /dev/input/event1 (or similar) and see the absolute event.
> 
> The next step is adding scroll-edge functionality and similar things
> to mousedev.c 
> I've almost got it so that when yor finger hits the edge of the
> touchpad, the mouse keeps moving, and moves faster if you press
> harder.   Once I'm happy with that I'll post it and start on the
> scroll-wheel thing.

Hi!

I have updated your patch for kernel 2.6.0-test6-bk6 and made it
report events compatible with the synaptics touchpad kernel driver.
This should make it possible to use an ALPS device with the XFree86
synaptics driver:

        http://w1.894.telia.com/~u89404340/touchpad/index.html

Using this driver will give you edge scrolling and similar things.

I don't have an ALPS GlidePoint so I haven't been able to test this
patch at all. Test reports are appreciated. You probably need to
change a few parameters in the X configuration, like edge parameters
and finger pressure thresholds. Also note that the auto detection will
not work with an ALPS device, so you have to use Protocol="event" and
Device="/dev/input/eventN" for some value of N.


 linux-petero/drivers/input/mouse/psmouse-base.c |   86 ++++++++++++++++++++++++
 linux-petero/drivers/input/mouse/psmouse.h      |    1 
 2 files changed, 87 insertions(+)

diff -puN drivers/input/mouse/psmouse-base.c~alps drivers/input/mouse/psmouse-base.c
--- linux/drivers/input/mouse/psmouse-base.c~alps	2003-10-05 09:00:49.000000000 +0200
+++ linux-petero/drivers/input/mouse/psmouse-base.c	2003-10-05 18:30:40.000000000 +0200
@@ -106,6 +106,48 @@ static void psmouse_process_packet(struc
 }
 
 /*
+ * ALPS abolute Mode
+ * byte 0: 1 1 1 1 1 mid0 rig0 lef0
+ * byte 1: 0 x6 x5 x4 x3 x2 x1 x0
+ * byte 2: 0 x10 x9 x8 x7 0 fin ges
+ * byte 3: 0 y9 y8 y7 1 mid1 rig1 lef1
+ * byte 4: 0 y6 y5 y4 y3 y2 y1 y0
+ * byte 5: 0 z6 z5 z4 z3 z2 z1 z0
+ *
+ * On a dualpoint, {mid,rig,lef}0 are the stick, 1 are the pad.
+ * We just 'or' them together for now.
+ * We also send 'ges'ture as BTN_TOUCH
+ */
+
+static void ALPS_process_packet(struct psmouse *psmouse, struct pt_regs *regs)
+{
+	unsigned char *packet = psmouse->packet;
+	struct input_dev *dev = &psmouse->dev;
+	int x,y,z;
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
+	input_report_key(dev, BTN_LEFT,   ((packet[0] | packet[3])     ) & 1);
+	input_report_key(dev, BTN_MIDDLE, ((packet[0] | packet[3]) >> 2) & 1);
+	input_report_key(dev, BTN_RIGHT,  ((packet[0] | packet[3]) >> 1) & 1);
+
+	input_report_key(dev, BTN_TOUCH,  packet[2] & 1);
+
+	input_sync(dev);
+}
+
+/*
  * psmouse_interrupt() handles incoming characters, either gathering them into
  * packets or passing them to the command routine as command output.
  */
@@ -180,6 +222,19 @@ static irqreturn_t psmouse_interrupt(str
 		goto out;
 	}
 
+	/* ALPS absolute mode packets start with 0b11111mrl
+	 * Normal mouse packets are extremely unlikely to overflow both
+	 * x and y
+	 */
+	if (!psmouse_noext && psmouse->type < PSMOUSE_GENPS &&
+	    (psmouse->packet[0] & 0xf8)== 0xf8) {
+		if (psmouse->pktcnt == 6) {
+			ALPS_process_packet(psmouse, regs);
+			psmouse->pktcnt = 0;
+		}
+		goto out;
+	}
+
 	if (psmouse->pktcnt == 3 + (psmouse->type >= PSMOUSE_GENPS)) {
 		psmouse_process_packet(psmouse, regs);
 		psmouse->pktcnt = 0;
@@ -463,6 +518,17 @@ static void psmouse_set_rate(struct psmo
  * psmouse_initialize() initializes the mouse to a sane state.
  */
 
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
+
 static void psmouse_initialize(struct psmouse *psmouse)
 {
 	unsigned char param[2];
@@ -486,6 +552,26 @@ static void psmouse_initialize(struct ps
  */
 
 	psmouse_command(psmouse, param, PSMOUSE_CMD_SETSTREAM);
+
+/*
+ * If it is a 3-byte setting and we are allowed to use extensions,
+ * then it could be an ALPS Glidepoint, so send the init sequence just
+ * incase. i.e. 4 consecutive "disable"s before the "enable"
+ */
+	if (psmouse->type < PSMOUSE_GENPS && !psmouse_noext) {
+		psmouse_command(psmouse, NULL, PSMOUSE_CMD_DISABLE);
+		psmouse_command(psmouse, NULL, PSMOUSE_CMD_DISABLE);
+		psmouse_command(psmouse, NULL, PSMOUSE_CMD_DISABLE);
+		psmouse_command(psmouse, NULL, PSMOUSE_CMD_DISABLE);
+
+		set_bit(BTN_TOUCH, psmouse->dev.keybit);
+		set_bit(BTN_TOOL_FINGER, psmouse->dev.keybit);
+		set_bit(EV_ABS, psmouse->dev.evbit);
+		set_abs_params(&psmouse->dev, ABS_X, 0, 0, 0, 0);
+		set_abs_params(&psmouse->dev, ABS_Y, 0, 0, 0, 0);
+		set_abs_params(&psmouse->dev, ABS_PRESSURE, 0, 127, 0, 0);
+
+	}
 }
 
 /*
diff -puN drivers/input/mouse/psmouse.h~alps drivers/input/mouse/psmouse.h
--- linux/drivers/input/mouse/psmouse.h~alps	2003-10-05 09:00:49.000000000 +0200
+++ linux-petero/drivers/input/mouse/psmouse.h	2003-10-05 09:00:49.000000000 +0200
@@ -9,6 +9,7 @@
 #define PSMOUSE_CMD_GETID	0x02f2
 #define PSMOUSE_CMD_SETRATE	0x10f3
 #define PSMOUSE_CMD_ENABLE	0x00f4
+#define	PSMOUSE_CMD_DISABLE	0x00f5
 #define PSMOUSE_CMD_RESET_DIS	0x00f6
 #define PSMOUSE_CMD_RESET_BAT	0x02ff
 

_

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
