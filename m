Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbTFNWGI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 18:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbTFNWGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 18:06:08 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:128 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261308AbTFNWFp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 18:05:45 -0400
Date: Sun, 15 Jun 2003 00:19:05 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Peter Osterlund <petero2@telia.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Joseph Fannin <jhf@rivenstone.net>,
       Jens Taprogge <jens.taprogge@rwth-aachen.de>
Subject: Re: [PATCH] Synaptics TouchPad driver for 2.5.70
Message-ID: <20030615001905.A27084@ucw.cz>
References: <m2smqhqk4k.fsf@p4.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m2smqhqk4k.fsf@p4.localdomain>; from petero2@telia.com on Wed, Jun 11, 2003 at 07:05:31AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 11, 2003 at 07:05:31AM +0200, Peter Osterlund wrote:

> [ I'm resending this because the previous message never showed up on
> the list. Maybe it was too big. ]
> 
> Hi!
> 
> Here is a driver for the Synaptics TouchPad for 2.5.70. It is largely
> based on the XFree86 driver. This driver operates the touchpad in
> absolute mode and emulates a three button mouse with two scroll
> wheels. Features include:
> 
> * Multi finger tapping.
> * Vertical and horizontal scrolling.
> * Edge scrolling during drag operations.
> * Palm detection.
> * Corner tapping.

... you may want to put these nice features into the mousedev.c driver
for now, so that the touchpad works with standard XFree without the
event based driver.

Also, I'm attaching Jens Taprogge synaptics work, which you may want to
integrate ...

To Jens: Sorry for me not using your driver. It's very good, too.
Hopefully you'll be able to work together with Peter to bring the best
out of the two to the kernel.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.5.59_mousedev_touchpad.diff"

--- linux-2.5.59/drivers/input/mousedev.c	2003-01-17 03:22:43.000000000 +0100
+++ linux-2.5.59_jlt/drivers/input/mousedev.c	2003-02-02 14:27:36.000000000 +0100
@@ -36,6 +36,12 @@
 #ifndef CONFIG_INPUT_MOUSEDEV_SCREEN_Y
 #define CONFIG_INPUT_MOUSEDEV_SCREEN_Y	768
 #endif
+#ifndef CONFIG_INPUT_MOUSEDEV_TAPFRACT
+#define CONFIG_INPUT_MOUSEDEV_TAPFRACT 12
+#endif
+#ifndef CONFIG_INPUT_MOUSEDEV_DRAGFRACT
+#define CONFIG_INPUT_MOUSEDEV_DRAGFRACT 8
+#endif
 
 struct mousedev {
 	int exist;
@@ -53,7 +59,9 @@
 	struct fasync_struct *fasync;
 	struct mousedev *mousedev;
 	struct list_head node;
-	int dx, dy, dz, oldx, oldy;
+	int dx, dy, dz, oldx, oldy, touchx, touchy;
+	char touched, tapped;
+	unsigned long tstamp;
 	signed char ps2[6];
 	unsigned long buttons;
 	unsigned char ready, buffer, bufsiz;
@@ -62,6 +70,13 @@
 
 #define MOUSEDEV_SEQ_LEN	6
 
+#define TAPSTATE_NONE		0
+#define TAPSTATE_TAPPED		1
+#define TAPSTATE_DRAGORDOUBLE	2
+#define TAPSTATE_DRAG		3
+#define TAPSTATE_DOUBLE		4
+#define TAPSTATE_DOUBLE2	5	
+
 static unsigned char mousedev_imps_seq[] = { 0xf3, 200, 0xf3, 100, 0xf3, 80 };
 static unsigned char mousedev_imex_seq[] = { 0xf3, 200, 0xf3, 200, 0xf3, 80 };
 
@@ -72,6 +87,43 @@
 
 static int xres = CONFIG_INPUT_MOUSEDEV_SCREEN_X;
 static int yres = CONFIG_INPUT_MOUSEDEV_SCREEN_Y;
+static int taptimeout = HZ/CONFIG_INPUT_MOUSEDEV_TAPFRACT;
+static int dragtimeout = HZ/CONFIG_INPUT_MOUSEDEV_DRAGFRACT;
+
+static inline void mousedev_touch(struct mousedev_list *list)
+{
+	list->touched = 1;
+	
+	if (list->tapped == TAPSTATE_TAPPED) 
+		/* drag or double tap */
+		list->tapped++;
+
+	list->tstamp = jiffies;
+	list->touchx = list->oldx;
+	list->touchy = list->oldy;
+}
+
+static inline void mousedev_touch_release(struct input_handle *handle, struct mousedev_list *list)
+{
+	list->touched = 0;
+
+	if (((list->tapped == 0) || (list->tapped == TAPSTATE_DRAGORDOUBLE)) && 
+			(!time_after(jiffies, list->tstamp + taptimeout)) && 
+			(abs(list->oldx - list->touchx) < (handle->dev->absmax[ABS_X] - handle->dev->absmin[ABS_X]) * xres / 40) &&
+			(abs(list->oldy - list->touchy) < (handle->dev->absmax[ABS_Y] - handle->dev->absmin[ABS_Y]) * yres / 40)) {
+		if (list->tapped == TAPSTATE_DRAGORDOUBLE)
+			/* double */
+			list->tapped += 2;
+		else
+			list->tapped++;
+
+		list->dx = 0;
+		list->dy = 0;
+	} else 
+		list->tapped = TAPSTATE_NONE;
+		
+	list->tstamp = jiffies;
+}
 
 static void mousedev_event(struct input_handle *handle, unsigned int type, unsigned int code, int value)
 {
@@ -99,6 +151,8 @@
 								list->dx += value - list->oldx;
 								list->oldx += list->dx;
 							}
+							if (!list->touched || (list->tapped == 1))
+								list->dx = 0;
 							break;
 
 						case ABS_Y:
@@ -110,6 +164,16 @@
 								list->dy -= value - list->oldy;
 								list->oldy -= list->dy;
 							}
+							if (!list->touched || (list->tapped == 1))
+								list->dy = 0;
+							break;
+
+						case ABS_PRESSURE:
+							if (!list->touched) {
+								if (value > 30) 
+									mousedev_touch(list);
+							} else if (value < 25)
+								mousedev_touch_release(handle, list);
 							break;
 					}
 					break;
@@ -235,6 +299,8 @@
 	memset(list, 0, sizeof(struct mousedev_list));
 
 	list->mousedev = mousedev_table[i];
+	list->touched = 1;
+	list->tapped = 0;
 	list_add_tail(&list->node, &mousedev_table[i]->list);
 	file->private_data = list;
 
@@ -255,28 +321,70 @@
 
 static void mousedev_packet(struct mousedev_list *list, unsigned char off)
 {
-	list->ps2[off] = 0x08 | ((list->dx < 0) << 4) | ((list->dy < 0) << 5) | (list->buttons & 0x07);
-	list->ps2[off + 1] = (list->dx > 127 ? 127 : (list->dx < -127 ? -127 : list->dx));
-	list->ps2[off + 2] = (list->dy > 127 ? 127 : (list->dy < -127 ? -127 : list->dy));
-	list->dx -= list->ps2[off + 1];
-	list->dy -= list->ps2[off + 2];
-	list->bufsiz = off + 3;
-
-	if (list->mode == 2) {
-		list->ps2[off + 3] = (list->dz > 7 ? 7 : (list->dz < -7 ? -7 : list->dz));
-		list->dz -= list->ps2[off + 3];
-		list->ps2[off + 3] = (list->ps2[off + 3] & 0x0f) | ((list->buttons & 0x18) << 1);
-		list->bufsiz++;
-	}
-	
-	if (list->mode == 1) {
-		list->ps2[off + 3] = (list->dz > 127 ? 127 : (list->dz < -127 ? -127 : list->dz));
-		list->dz -= list->ps2[off + 3];
-		list->bufsiz++;
+    	/* Dont move during taps. But accumulate dx, dy etc. - we might drag. */
+	if (!list->tapped || (list->tapped == TAPSTATE_DRAG)) {
+		list->ps2[off] = 0x08 | ((list->dx < 0) << 4) | ((list->dy < 0) << 5) | (list->buttons & 0x07);
+		list->ps2[off + 1] = (list->dx > 127 ? 127 : (list->dx < -127 ? -127 : list->dx));
+		list->ps2[off + 2] = (list->dy > 127 ? 127 : (list->dy < -127 ? -127 : list->dy));
+		list->dx -= list->ps2[off + 1];
+		list->dy -= list->ps2[off + 2];
+		list->bufsiz = off + 3;
+
+		if (list->mode == 2) {
+			list->ps2[off + 3] = (list->dz > 7 ? 7 : (list->dz < -7 ? -7 : list->dz));
+			list->dz -= list->ps2[off + 3];
+			list->ps2[off + 3] = (list->ps2[off + 3] & 0x0f) | ((list->buttons & 0x18) << 1);
+			list->bufsiz++;
+		}
+		
+		if (list->mode == 1) {
+			list->ps2[off + 3] = (list->dz > 127 ? 127 : (list->dz < -127 ? -127 : list->dz));
+			list->dz -= list->ps2[off + 3];
+			list->bufsiz++;
+		}
+	} else {
+		list->ps2[off] = 0x08 | (list->buttons & 0x07);
+		list->ps2[off + 1] = 0;
+		list->ps2[off + 2] = 0;
+		list->bufsiz = off + 3;
+		
+		if (list->mode == 2) {
+			list->ps2[off + 3] = (list->buttons & 0x18) << 1;
+			list->bufsiz++;
+		}
 	}
 
 	if (!list->dx && !list->dy && (!list->mode || !list->dz)) list->ready = 0;
 	list->buffer = list->bufsiz;
+
+	switch (list->tapped) {
+		case TAPSTATE_TAPPED:
+		    	/* tap -> press and hold until we know if it is a drag */
+			if (!time_after(jiffies, list->tstamp + dragtimeout))
+			    	list->ps2[off] |= 0x01;
+			else
+				list->tapped = TAPSTATE_NONE;
+			break;
+		case TAPSTATE_DRAGORDOUBLE:
+			/* drag or doubletap -> hold button */
+			list->ps2[off] |= 0x01;
+			if (time_after(jiffies, list->tstamp + taptimeout))
+			    	list->tapped++;
+			break;
+		case TAPSTATE_DRAG:
+			/* drag -> hold button */
+			list->ps2[off] |= 0x01;
+			break;
+		case TAPSTATE_DOUBLE:
+			/* double tap (part 1) -> release button */
+			list->tapped++;
+			break;
+		case TAPSTATE_DOUBLE2:
+			/* double tap (part 2) -> click button */
+			list->ps2[off] |= 0x01;
+			list->tapped = TAPSTATE_NONE;
+			break;
+	}
 }
 
 

--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="synaptics.c"

/*
 * Synaptics touchpad driver
 *
 * Copyright (c) 2003 Jens Taprogge
 *
 * based on psmouse.c by Vojetech Pavlik,
 * http://
 * and the Synaptics XFree86 driver by Stefan Gmeiner et. al.
 */

/*
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License version 2 as published by
 * the Free Software Foundation.
 */

#include <linux/delay.h>
#include <linux/module.h>
#include <linux/slab.h>
#include <linux/interrupt.h>
#include <linux/input.h>
#include <linux/serio.h>
#include <linux/init.h>

MODULE_AUTHOR("Jens Taprogge <jens.taprogge@rwth-aachen.de");
MODULE_DESCRIPTION("Synaptics touchpad driver");
MODULE_LICENSE("GPL");

#define PSMOUSE_CMD_SETSCALE11	0x00e6
#define PSMOUSE_CMD_SETRES	0x10e8
#define PSMOUSE_CMD_GETINFO	0x03e9
#define PSMOUSE_CMD_SETSTREAM	0x00ea
#define PSMOUSE_CMD_POLL	0x03eb	
#define PSMOUSE_CMD_GETID	0x01f2
#define PSMOUSE_CMD_GETID2	0x0100
#define PSMOUSE_CMD_SETRATE	0x10f3
#define PSMOUSE_CMD_ENABLE	0x00f4
#define PSMOUSE_CMD_RESET_DIS	0x00f6
#define PSMOUSE_CMD_RESET_BAT	0x02ff

#define PSMOUSE_RET_BAT		0xaa
#define PSMOUSE_RET_ACK		0xfa
#define PSMOUSE_RET_NAK		0xfe

#define SYN_QUE_IDENTIFY	0x00
#define SYN_QUE_CAPABILITIES	0x02
#define SYN_QUE_MODEL		0x03

#define SYN_MODE_WMODE			(1 << 0)
#define SYN_MODE_DISABLE_GESTURE	(1 << 2)
#define SYN_MODE_HIGH_RATE		(1 << 6)
#define SYN_MODE_ABSOLUTE		(1 << 7)

#define SYN_ECAP_PALMDETECT		(1 << 0)
#define SYN_ECAP_MULTIFINGER		(1 << 1)
#define SYN_ECAP_4BUTTON		(1 << 3)

#define SYN_CAP_PEN			(1 << 5)

#define SYN_MAXCOORD			0x1fff
	
struct synap {
	struct input_dev dev;
	struct serio *serio;
	char *vendor;
	char *name;
	unsigned char cmdbuf[8];
	unsigned char packet[8];
	unsigned char cmdcnt;
	unsigned char pktcnt;
	unsigned char type;
	unsigned int  model;
	unsigned int  version;
	unsigned int  caps;
	unsigned long last;
	char acking;
	char ack;
	char error;
	char devname[64];
	char phys[32];
	int  hindex;
	int finger;
	unsigned int buttons;
	int x, y;
	char w, z;
};

#define PSMOUSE_PS2	1
#define PSMOUSE_PS2PP	2
#define PSMOUSE_PS2TPP	3
#define PSMOUSE_GENPS	4
#define PSMOUSE_IMPS	5
#define PSMOUSE_IMEX	6
#define PSMOUSE_SYNAPTICS	7

static char *synap_protocols[] = { "None", "PS/2", "PS2++", "PS2T++", "GenPS/2", "ImPS/2", "ImExPS/2", "Synaptics" };


/*
 * check_buttons checks if buttons are pressed.
 * returns 0 if nothing else needs to be done
 */

inline static int check_buttons(struct synap *synap) 
{
	unsigned char *packet = synap->packet;

	synap->buttons |= packet[0] & 1;
	synap->buttons |= (packet[0] << 1) & (1 << 2);

	if (synap->caps & SYN_ECAP_4BUTTON) {
		if (packet[3] == 0xc2) {
		    	/* 6 buttons. not in doc */
			synap->buttons |= (packet[4] << 2) & (1 << 3);
			synap->buttons |= (packet[5] << 3) & (1 << 4);
			synap->buttons |= (packet[4] << 5) & (1 << 5);
			synap->buttons |= (packet[5] << 6) & (1 << 6);
			return 0;
		} else {
			synap->buttons |=
				(((packet[3] & 1) && 
				(packet[0]   & 1)) << 3) & (1 << 3);
			synap->buttons |=
				(((packet[3] & 2) && 
				(packet[0]   & 2)) << 3) & (1 << 4);
		}
	}
	return 1;
}

inline static void read_pos(struct synap *synap) 
{
	unsigned char *packet = synap->packet;
	
	synap->x = ((packet[3] & 0x10) << 8) |
		   ((packet[1] & 0x0f) << 8) |
		     packet[4];

	synap->y = ((packet[3] & 0x20) << 7) |
		   ((packet[1] & 0xf0) << 4) |
		     packet[5];
	
	synap->z =   packet[2];
	
	synap->w = ((packet[0] & 0x30) >> 2) |
		   ((packet[0] & 0x04) >> 1) |
		   ((packet[3] & 0x04) >> 2);
}

#if 0
inline static void check_multifinger(struct synap *synap)
{
	switch (synap->w) {
		case 0: 
			/* two fingers */
			if (synap->caps & SYN_ECAP_MULTIFINGER)
				input_report_abs(&(synap->dev), ABS_GESTURE, GES_TWOFINGER);
			break;
		case 1:
			/* three or more fingers */
			if (synap->caps & SYN_ECAP_MULTIFINGER)
				input_report_abs(&(synap->dev), ABS_GESTURE, GES_THREEFINGER);
			break;
		case 2:
			/* pen */
			if (synap->model & SYN_CAP_PEN)
				input_report_abs(&(synap->dev), ABS_GESTURE, GES_PEN);
			break;
		case 4:
		case 5:
		case 6:
		case 7:
		case 8:
		        /* finger normal width */
			if (synap->caps & SYN_ECAP_PALMDETECT)
				input_report_abs(&(synap->dev), ABS_GESTURE, GES_ONEFINGER);
		/* FIXME: 9..14 */
		case 15:
			/* palm */
			if (synap->caps & SYN_ECAP_PALMDETECT)
				input_report_abs(&(synap->dev), ABS_GESTURE, GES_PALM);
	}
}
#endif

inline static void report_pos(struct synap *synap) 
{
	input_report_abs(&(synap->dev), ABS_X, synap->x);
	input_report_abs(&(synap->dev), ABS_Y, SYN_MAXCOORD - synap->y);
	input_report_abs(&(synap->dev), ABS_PRESSURE, synap->z);
}


/*
 * try to send as few events as possible
 */

static void do_buttons(struct synap *synap)
{
	struct input_dev *dev = &synap->dev;
	static int oldbuttons = 0;
	int i;
	int mask;

	for (i = 0; i < 5; i++) {
	    	mask = 1 << i;
		if ((synap->buttons) & mask) {
		    	if (!(oldbuttons & mask)) 
				input_report_key(dev, BTN_MOUSE + i, 1);
		}
		else if (oldbuttons & mask)
	                input_report_key(dev, BTN_MOUSE + i, 0);
	}
	
	oldbuttons = synap->buttons;
}


/*
 * synap_process_packet() anlyzes the PS/2 mouse packet contents and
 * reports relevant events to the input module.
 */

static void synap_process_packet(struct synap *synap)
{
	struct input_dev *dev = &synap->dev;

	synap->buttons = synap->buttons >> 8;

	if (check_buttons(synap)) {
		read_pos(synap);
//		check_multifinger(synap);
		report_pos(synap);
	}

	do_buttons(synap);
	input_sync(dev);
}

/*
 * synap_interrupt() handles incoming characters, either gathering them into
 * packets or passing them to the command routine as command output.
 */

static void synap_interrupt(struct serio *serio, unsigned char data, unsigned int flags)
{
	struct synap *synap = serio->private;

	if (synap->acking) {
		switch (data) {
			case PSMOUSE_RET_ACK:
				synap->ack = 1;
				break;
			case PSMOUSE_RET_NAK:
				synap->ack = -1;
				break;
			default:
				synap->ack = 1;	/* Workaround for mice which don't ACK the Get ID command */
				if (synap->cmdcnt)
					synap->cmdbuf[--synap->cmdcnt] = data;
				break;
		}
		synap->acking = 0;
		return;
	}

	if (synap->cmdcnt) {
		synap->cmdbuf[--synap->cmdcnt] = data;
		return;
	}

	if (synap->pktcnt && time_after(jiffies, synap->last + HZ/2)) {
		printk(KERN_WARNING "synap.c: Lost synchronization, throwing %d bytes away.\n", synap->pktcnt);
		synap->pktcnt = 0;
	}
	
	synap->last = jiffies;
	synap->packet[synap->pktcnt++] = data;

	if (synap->pktcnt == 6) {
		synap_process_packet(synap);
		synap->pktcnt = 0;
		return;
	}

	if (synap->pktcnt == 1 && synap->packet[0] == PSMOUSE_RET_BAT) {
		serio_rescan(serio);
		return;
	}	
}

/*
 * synap_sendbyte() sends a byte to the mouse, and waits for acknowledge.
 * It doesn't handle retransmission, though it could - because when there would
 * be need for retransmissions, the mouse has to be replaced anyway.
 */

static int synap_sendbyte(struct synap *synap, unsigned char byte)
{
	int timeout = 10000; /* 100 msec */
	synap->ack = 0;
	synap->acking = 1;

	if (serio_write(synap->serio, byte)) {
		synap->acking = 0;
		return -1;
	}

	while (!synap->ack && timeout--) udelay(10);

	return -(synap->ack <= 0);
}

/*
 * synap_command() sends a command and its parameters to the mouse,
 * then waits for the response and puts it in the param array.
 */

static int synap_command(struct synap *synap, unsigned char *param, int command)
{
	int timeout = 500000; /* 500 msec */
	int send = (command >> 12) & 0xf;
	int receive = (command >> 8) & 0xf;
	int i;

	synap->cmdcnt = receive;

	if (command & 0xff)
		if (synap_sendbyte(synap, command & 0xff))
			return (synap->cmdcnt = 0) - 1;

	for (i = 0; i < send; i++)
		if (synap_sendbyte(synap, param[i]))
			return (synap->cmdcnt = 0) - 1;

	while (synap->cmdcnt && timeout--) udelay(1);

	for (i = 0; i < receive; i++)
		param[i] = synap->cmdbuf[(receive - 1) - i];

	if (synap->cmdcnt) 
		return (synap->cmdcnt = 0) - 1;

	return 0;
}

/*
 * synap_ps2pp_cmd() sends a PS2++ command, sliced into two bit
 * pieces through the SETRES command. This is needed to send extended
 * commands to mice on notebooks that try to understand the PS/2 protocol
 * Ugly.
 */

static int synap_syn_cmd(struct synap *synap, unsigned char *param, unsigned char command)
{
	unsigned char d;
	int i;

	if (synap_command(synap,  NULL, PSMOUSE_CMD_SETSCALE11))
		return -1;

	for (i = 6; i >= 0; i -= 2) {
		d = (command >> i) & 3;
		
		if (synap_command(synap, &d, PSMOUSE_CMD_SETRES))
			return -1;
	}

	return 0;
}


/*
 * synap_probe() probes for a PS/2 mouse.
 */

static int synaptics_probe(struct synap *synap)
{
	unsigned char param[4];

/*
 * First, we check if it's a mouse. It should send 0x00 or 0x03
 * in case of an IntelliMouse in 4-byte mode or 0x04 for IM Explorer.
 */

	param[0] = param[1] = 0xa5;

	if (synap_command(synap, param, PSMOUSE_CMD_GETID))
		return -1;

	if (param[0] == 0xab || param[0] == 0xac) {
		synap_command(synap, param, PSMOUSE_CMD_GETID2);
		return -1;
	}

	if (param[0] != 0x00 && param[0] != 0x03 && param[0] != 0x04)
		return -1;

/*
 * Then we reset and disable the mouse so that it doesn't generate events.
 */

	if (synap_command(synap, NULL, PSMOUSE_CMD_RESET_DIS))
		return -1;

        param[0] = 0;
        synap_syn_cmd(synap, param, SYN_QUE_IDENTIFY);
        synap_command(synap, param, PSMOUSE_CMD_GETINFO);

        if (param[1] == 0x47) {
		synap->vendor = "Synaptics";
		synap->name = "TouchPad ";
		synap->version = param[0] | ((param[2] & 0xf) << 8);
	        printk(KERN_INFO "synaptics: version %d.%d\n", param[2] & 0xf,
			param[0]);
	       
		synap_syn_cmd(synap, param, SYN_QUE_MODEL);
		synap_command(synap, param, PSMOUSE_CMD_GETINFO);
		synap->model = param[0] << 16 | param[1] << 8 | param[2];
		if (param[1] == 0x47) {
			/* Synaptics prior to V3.2 */
		        synap->model = 0;
		} else if (param[1] & 1)
		        /* no Synaptics at all */
			return -1;
	        printk(KERN_INFO "synaptics: model %x\n", synap->model);
		
		/* Starting with version 3.0 it is safe to query the
		 * capabilities. If bit 7 of the first byte is set capabilities
		 * are supported. */
		if (synap->version > 0x0300) {
			synap_syn_cmd(synap, param, SYN_QUE_CAPABILITIES);
			synap_command(synap, param, PSMOUSE_CMD_GETINFO);
			if (param[0] & (1<<7))
				synap->caps = param[0] << 8 | param[2];
			else
				synap->caps = 0;
		} else
			synap->caps = 0;
		
	        printk(KERN_INFO "synaptics: caps %x\n", synap->caps);
		return PSMOUSE_SYNAPTICS;
	}
	else
		return -1;
}

/*
 * synap_initialize() initializes the mouse to a sane state.
 */

static void synaptics_initialize(struct synap *synap)
{
	unsigned char param[2];
	
      
/*
 * We set the mouse report rate to a highest possible value.
 * We try 100 first in case mouse fails to set 200.
 */

	param[0] = 100;
	synap_command(synap, param, PSMOUSE_CMD_SETRATE);

	param[0] = 200;
	synap_command(synap, param, PSMOUSE_CMD_SETRATE);

/*
 * We also set the resolution and scaling.
 */

	param[0] = 3;
	synap_command(synap, param, PSMOUSE_CMD_SETRES);
	synap_command(synap,  NULL, PSMOUSE_CMD_SETSCALE11);

/*
 * special synaptics initilaization
 */
	
	synap_syn_cmd(synap, param, SYN_MODE_HIGH_RATE | SYN_MODE_WMODE |
		SYN_MODE_ABSOLUTE | SYN_MODE_DISABLE_GESTURE);
        param[0] = 0x14;
        synap_command(synap, param, PSMOUSE_CMD_SETRATE);
	
/*
 * We set the mouse into streaming mode.
 */

	synap_command(synap, param, PSMOUSE_CMD_SETSTREAM);

/*
 * Last, we enable the mouse so that we get reports from it.
 */

	if (synap_command(synap, NULL, PSMOUSE_CMD_ENABLE))
		printk(KERN_WARNING "synap.c: Failed to enable mouse on %s\n", synap->serio->phys);

}

/*
 * synap_cleanup() resets the mouse into power-on state.
 */

static void synap_cleanup(struct serio *serio)
{
	struct synap *synap = serio->private;
	unsigned char param[2];
	synap_command(synap, param, PSMOUSE_CMD_RESET_BAT);
}

/*
 * synap_disconnect() closes and frees.
 */

static void synap_disconnect(struct serio *serio)
{
	struct synap *synap = serio->private;
	input_unregister_device(&synap->dev);
	serio_close(serio);
	kfree(synap);
}

/*
 * synap_connect() is a callback form the serio module when
 * an unhandled serio port is found.
 */

static void synaptics_connect(struct serio *serio, struct serio_dev *dev)
{
	struct synap *synap;
	
	if ((serio->type & SERIO_TYPE) != SERIO_8042)
		return;

	if (!(synap = kmalloc(sizeof(struct synap), GFP_KERNEL)))
		return;

	memset(synap, 0, sizeof(struct synap));

	init_input_dev(&synap->dev);
	synap->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_REL) | BIT(EV_ABS);
	synap->dev.keybit[LONG(BTN_MOUSE)] = BIT(BTN_LEFT) | BIT(BTN_RIGHT);
	//| BIT(BTN_EXTRA) | BIT(BTN_SIDE);
	synap->dev.relbit[0] |= BIT(REL_X) | BIT(REL_Y);
	synap->dev.absbit[0] |= BIT(ABS_X) | BIT(ABS_Y);
	synap->dev.absbit[LONG(ABS_PRESSURE)] |= BIT(ABS_PRESSURE);
	
	synap->dev.absmin[ABS_X] =  0;
	synap->dev.absmax[ABS_X] =  SYN_MAXCOORD;
	synap->dev.absfuzz[ABS_X] = 0x2f;
	
	synap->dev.absmin[ABS_Y] =  0;
	synap->dev.absmax[ABS_Y] =  SYN_MAXCOORD;
	synap->dev.absfuzz[ABS_Y] = 0x2f;
	
	synap->dev.absmin[ABS_PRESSURE] = 0x0;
	synap->dev.absmax[ABS_PRESSURE] = 0xff;
	

	synap->serio = serio;
	synap->dev.private = synap;

	serio->private = synap;

	if (serio_open(serio, dev)) {
		kfree(synap);
		return;
	}

	if (synaptics_probe(synap) <= 0) {
		serio_close(serio);
		kfree(synap);
		return;
	}
	
	sprintf(synap->devname, "%s %s %s",
		synap_protocols[synap->type], synap->vendor, synap->name);
	sprintf(synap->phys, "%s/input0",
		serio->phys);

	synap->dev.name = synap->devname;
	synap->dev.phys = synap->phys;
	synap->dev.id.bustype = BUS_I8042;
	synap->dev.id.vendor = 0x0002;
	synap->dev.id.product = synap->type;
	synap->dev.id.version = synap->model;

	input_register_device(&synap->dev);
	
	printk(KERN_INFO "input: %s on %s\n", synap->devname, serio->phys);

	synaptics_initialize(synap);
}

static struct serio_dev synap_dev = {
	.interrupt =	synap_interrupt,
	.connect =	synaptics_connect,
	.disconnect =	synap_disconnect,
	.cleanup =	synap_cleanup,
};

#ifndef MODULE
static int __init synap_setup(char *str)
{
	return 1;
}
#endif

int __init synap_init(void)
{
	serio_register_device(&synap_dev);
	return 0;
}

void __exit synap_exit(void)
{
	serio_unregister_device(&synap_dev);
}

module_init(synap_init);
module_exit(synap_exit);

--bp/iNruPH9dso1Pn--
