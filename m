Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263355AbTF0CZE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 22:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263365AbTF0CZD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 22:25:03 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:52184 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S263355AbTF0CYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 22:24:55 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Vojtech Pavlik <vojtech@suse.cz>
Date: Fri, 27 Jun 2003 12:38:50 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16123.44602.150927.280989@gargle.gargle.HOWL>
Cc: linux-kernel@vger.kernel.org
Subject: PATCH - ALPS glidepoint/dualpoint driver for 2.5.7x
X-Mailer: VM 7.16 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
 The following adds support for the ALPS glidepoint/dualpoint pointing
 devices to the mouse driver in 2.5.7x

 It "works-for-me" but there are issues that probably need to be
 addressed.

 1/ The code is based on other code fragments I have collected off the
   internet.  I have found no documentation and the one request I made to
   ALPS has so-far been unanswered.  So I cannot be sure it is right,
   but as I say it seems to work.

 2/ It appears (but see 1) that it is not possible to reliably detect
    an ALPS device.  There is a sequence where you send 3 SetRes2:1
    commands, and then a GetStatus command and you get something which
    isn't really a status, but I don't know what range of status
    values mean "ALPS".  I tried checking for "any status which must
    be wrong" i.e. any status that say the device is in 1:1 mode, or
    is enabled etc.  But a Logitech mouse seem to respond
    interestingly to that sequence too.

    Also, there is no guarantee that the reply will come from the ALPS
    device.  For example, on my Dell Latitude D800, if I have a
    logitech mouse plugged in the expansion port, the GetStatus reply
    comes from the logitech and not the ALPS.  So it would seem that
    reliable detection is impossible.

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

  3/ I haven't set the Min and Max absolute values (though both X and
     Y seem to range from 0 to 100 in practice on my notebook).
     This was because declaring a Min and Max causes the mousedev
     driver to scale values to fit a supposed screen size, and I don't
     think that is really appropriate for a touchpad.  Would there be
     some other way to decide when to scale?  I would like to be able
     to include Min and Max so that a post-processor (possibly in
     mousedev) would be able to differentiate edge based activity
     (scroll regions, corner taps, etc).


  This patch also includes a fix for mousedev_event that allows it to
  work sensibly with a touchpad in absolute mode.  With a touchpad, if
  you lift your finger and place it down again you don't want that to
  be interpreted as movement, but mousedev_event currently will.
  I have changed it so that if ABS_PRESSURE is an available event,
  then a new ABS_{X,Y} event while the current ABS_PRESSURE is zero
  will not generate any movement.

 ----------- Diffstat output ------------
 ./drivers/input/mouse/psmouse-base.c |   83 ++++++++++++++++++++++++++++++++++-
 ./drivers/input/mouse/psmouse.h      |    1 
 ./drivers/input/mousedev.c           |   26 +++++++---
 3 files changed, 100 insertions(+), 10 deletions(-)

diff ./drivers/input/mouse/psmouse-base.c~current~ ./drivers/input/mouse/psmouse-base.c
--- ./drivers/input/mouse/psmouse-base.c~current~	2003-06-26 13:49:26.000000000 +1000
+++ ./drivers/input/mouse/psmouse-base.c	2003-06-26 13:51:49.000000000 +1000
@@ -99,6 +99,48 @@ static void psmouse_process_packet(struc
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
+		input_report_abs(dev, ABS_PRESSURE, z);
+	} else
+		input_report_abs(dev, ABS_PRESSURE, 0);
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
@@ -139,6 +181,19 @@ static irqreturn_t psmouse_interrupt(str
 	psmouse->last = jiffies;
 	psmouse->packet[psmouse->pktcnt++] = data;
 
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
@@ -424,6 +479,17 @@ static void psmouse_set_resolution(struc
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
@@ -453,8 +519,23 @@ static void psmouse_initialize(struct ps
 
 /*
  * Last, we enable the mouse so that we get reports from it.
- */
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
+		set_bit(EV_ABS, psmouse->dev.evbit);
+		set_abs_params(&psmouse->dev, ABS_X, 0, 0, 0, 0);
+		set_abs_params(&psmouse->dev, ABS_Y, 0, 0, 0, 0);
+		set_abs_params(&psmouse->dev, ABS_PRESSURE, 0, 127, 0, 0);
 
+	}
 	if (psmouse_command(psmouse, NULL, PSMOUSE_CMD_ENABLE))
 		printk(KERN_WARNING "psmouse.c: Failed to enable mouse on %s\n", psmouse->serio->phys);
 

diff ./drivers/input/mouse/psmouse.h~current~ ./drivers/input/mouse/psmouse.h
--- ./drivers/input/mouse/psmouse.h~current~	2003-06-26 13:49:26.000000000 +1000
+++ ./drivers/input/mouse/psmouse.h	2003-06-26 13:50:16.000000000 +1000
@@ -9,6 +9,7 @@
 #define PSMOUSE_CMD_GETID	0x02f2
 #define PSMOUSE_CMD_SETRATE	0x10f3
 #define PSMOUSE_CMD_ENABLE	0x00f4
+#define	PSMOUSE_CMD_DISABLE	0x00f5
 #define PSMOUSE_CMD_RESET_DIS	0x00f6
 #define PSMOUSE_CMD_RESET_BAT	0x02ff
 

diff ./drivers/input/mousedev.c~current~ ./drivers/input/mousedev.c
--- ./drivers/input/mousedev.c~current~	2003-06-26 13:49:26.000000000 +1000
+++ ./drivers/input/mousedev.c	2003-06-26 13:50:22.000000000 +1000
@@ -53,7 +53,7 @@ struct mousedev_list {
 	struct fasync_struct *fasync;
 	struct mousedev *mousedev;
 	struct list_head node;
-	int dx, dy, dz, oldx, oldy;
+	int dx, dy, dz, oldx, oldy, finger;
 	signed char ps2[6];
 	unsigned long buttons;
 	unsigned char ready, buffer, bufsiz;
@@ -79,6 +79,7 @@ static void mousedev_event(struct input_
 	struct mousedev **mousedev = mousedevs;
 	struct mousedev_list *list;
 	int index, size, wake;
+	int dx, dy;
 
 	while (*mousedev) {
 
@@ -93,23 +94,30 @@ static void mousedev_event(struct input_
 						case ABS_X:	
 							size = handle->dev->absmax[ABS_X] - handle->dev->absmin[ABS_X];
 							if (size != 0) {
-								list->dx += (value * xres - list->oldx) / size;
-								list->oldx += list->dx * size;
+								dx = list->dx + (value * xres - list->oldx) / size;
+								list->oldx += dx * size;
 							} else {
-								list->dx += value - list->oldx;
-								list->oldx += list->dx;
+								dx = list->dx + value - list->oldx;
+								list->oldx += dx;
 							}
+							if (list->finger || !test_bit(ABS_PRESSURE, handle->dev->absbit))
+								list->dx = dx;
 							break;
 
 						case ABS_Y:
 							size = handle->dev->absmax[ABS_Y] - handle->dev->absmin[ABS_Y];
 							if (size != 0) {
-								list->dy -= (value * yres - list->oldy) / size;
-								list->oldy -= list->dy * size;
+								dy = list->dy - (value * yres - list->oldy) / size;
+								list->oldy -= dy * size;
 							} else {
-								list->dy -= value - list->oldy;
-								list->oldy -= list->dy;
+								dy = list->dy - (value - list->oldy);
+								list->oldy -= dy;
 							}
+							if (list->finger || !test_bit(ABS_PRESSURE, handle->dev->absbit))
+								list->dy = dy;
+							break;
+						case ABS_PRESSURE:
+							list->finger = value;
 							break;
 					}
 					break;
