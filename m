Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261968AbTFKOrh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 10:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbTFKOrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 10:47:37 -0400
Received: from dhcp160176008.columbus.rr.com ([24.160.176.8]:13069 "EHLO
	nineveh.rivenstone.net") by vger.kernel.org with ESMTP
	id S261968AbTFKOrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 10:47:04 -0400
From: "Joseph Fannin" <jhf@rivenstone.net>
X-Original-Recipient: jhf@rivenstone.net
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Joseph Fannin <jhf@rivenstone.net>
Subject: [PATCH] Synaptics TouchPad driver for 2.5.70
Date: 11 Jun 2003 00:52:06 +0200
Message-ID: <m2u1axk0kp.fsf@p4.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Here is a driver for the Synaptics TouchPad for 2.5.70. It is largely
based on the XFree86 driver. This driver operates the touchpad in
absolute mode and emulates a three button mouse with two scroll
wheels. Features include:

* Multi finger tapping.
* Vertical and horizontal scrolling.
* Edge scrolling during drag operations.
* Palm detection.
* Corner tapping.

The only major missing feature is runtime configuration of driver
parameters. What is the best way to implement that? I was thinking of
sending EV_MSC events to the driver using the /dev/input/event*
interface and define my own codes for the different driver parameters.

Comments?


diff -u -r -N ../../linus/main/linux/drivers/input/mouse/Kconfig linux/drivers/input/mouse/Kconfig
--- ../../linus/main/linux/drivers/input/mouse/Kconfig	Sat Jun  7 21:40:38 2003
+++ linux/drivers/input/mouse/Kconfig	Tue Jun 10 00:08:14 2003
@@ -28,6 +28,16 @@
 	  The module will be called psmouse. If you want to compile it as a
 	  module, say M here and read <file:Documentation/modules.txt>.
 
+config MOUSE_PS2_SYNAPTICS
+	bool "Synaptics TouchPad"
+	default n
+	depends on INPUT && INPUT_MOUSE && SERIO && MOUSE_PS2
+	---help---
+	  Say Y here if you have a Synaptics TouchPad connected to your system.
+	  This touchpad is found on many modern laptop computers.
+
+	  If unsure, say Y.
+
 config MOUSE_SERIAL
 	tristate "Serial mouse"
 	depends on INPUT && INPUT_MOUSE && SERIO
diff -u -r -N ../../linus/main/linux/drivers/input/mouse/psmouse.c linux/drivers/input/mouse/psmouse.c
--- ../../linus/main/linux/drivers/input/mouse/psmouse.c	Sat Jun  7 21:40:38 2003
+++ linux/drivers/input/mouse/psmouse.c	Tue Jun 10 00:11:37 2003
@@ -41,6 +41,7 @@
 #define PSMOUSE_RET_NAK		0xfe
 
 struct psmouse {
+	void *private;
 	struct input_dev dev;
 	struct serio *serio;
 	char *vendor;
@@ -65,8 +66,11 @@
 #define PSMOUSE_GENPS	4
 #define PSMOUSE_IMPS	5
 #define PSMOUSE_IMEX	6
+#define PSMOUSE_SYNAPTICS 7
 
-static char *psmouse_protocols[] = { "None", "PS/2", "PS2++", "PS2T++", "GenPS/2", "ImPS/2", "ImExPS/2" };
+#include "synaptics.c"
+
+static char *psmouse_protocols[] = { "None", "PS/2", "PS2++", "PS2T++", "GenPS/2", "ImPS/2", "ImExPS/2", "Synaptics"};
 
 /*
  * psmouse_process_packet() anlyzes the PS/2 mouse packet contents and
@@ -209,6 +213,16 @@
 		goto out;
 	}
 
+	if (psmouse->pktcnt == 1 && psmouse->type == PSMOUSE_SYNAPTICS) {
+		/*
+		 * The synaptics driver has its own resync logic,
+		 * so it needs to receive all bytes one at a time.
+		 */
+		synaptics_process_byte(psmouse, regs);
+		psmouse->pktcnt = 0;
+		goto out;
+	}
+
 	if (psmouse->pktcnt == 1 && psmouse->packet[0] == PSMOUSE_RET_BAT) {
 		serio_rescan(serio);
 		goto out;
@@ -343,12 +357,12 @@
        psmouse_command(psmouse, param, PSMOUSE_CMD_GETINFO);
 
        if (param[1] == 0x47) {
-               /* We could do more here. But it's sufficient just
-                  to stop the subsequent probes from screwing the
-                  thing up. */
-               psmouse->vendor = "Synaptics";
-               psmouse->name = "TouchPad";
-               return PSMOUSE_PS2;
+		int type = PSMOUSE_PS2;
+		psmouse->vendor = "Synaptics";
+		psmouse->name = "TouchPad";
+		if (synaptics_init(psmouse) == 0)
+			type = PSMOUSE_SYNAPTICS;
+		return type;
        }
 
 /*
@@ -598,6 +612,7 @@
 	struct psmouse *psmouse = serio->private;
 	input_unregister_device(&psmouse->dev);
 	serio_close(serio);
+	synaptics_disconnect(psmouse);
 	kfree(psmouse);
 }
 
diff -u -r -N ../../linus/main/linux/drivers/input/mouse/synaptics.c linux/drivers/input/mouse/synaptics.c
--- ../../linus/main/linux/drivers/input/mouse/synaptics.c	Thu Jan  1 01:00:00 1970
+++ linux/drivers/input/mouse/synaptics.c	Wed Jun 11 00:34:54 2003
@@ -0,0 +1,801 @@
+/*
+ * Synaptics TouchPad PS/2 mouse driver
+ *
+ *   2003 Peter Osterlund <petero2@telia.com>
+ *     Ported to 2.5 input device infrastructure.
+ *
+ *   2002 Peter Osterlund <petero2@telia.com>
+ *     patches for fast scrolling, palm detection, edge motion,
+ *     horizontal scrolling
+ *
+ *   Copyright (C) 2001 Stefan Gmeiner <riddlebox@freesurf.ch>
+ *     start merging tpconfig and gpm code to a xfree-input module
+ *     adding some changes and extensions (ex. 3rd and 4th button)
+ *
+ *   Copyright (c) 1999 Henry Davies <hdavies@ameritech.net> for the
+ *     absolute to relative translation code (from the gpm-source)
+ *     and some other ideas
+ *
+ *   Copyright (c) 1997 C. Scott Ananian <cananian@alumni.priceton.edu>
+ *   Copyright (c) 1998-2000 Bruce Kalk <kall@compass.com>
+ *     code for the special synaptics commands (from the tpconfig-source)
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * Trademarks are the property of their respective owners.
+ */
+
+#ifndef CONFIG_MOUSE_PS2_SYNAPTICS
+
+static inline void synaptics_process_byte(struct psmouse *psmouse, struct pt_regs *regs) {}
+static inline int synaptics_init(struct psmouse *psmouse) { return -1; }
+static inline void synaptics_disconnect(struct psmouse *psmouse) {}
+
+#else
+
+#include "synaptics.h"
+
+
+static int psmouse_command(struct psmouse *psmouse, unsigned char *param, int command);
+
+/*
+ * Use the Synaptics extended ps/2 syntax to write a special command byte.
+ * special command: 0xE8 rr 0xE8 ss 0xE8 tt 0xE8 uu where (rr*64)+(ss*16)+(tt*4)+uu
+ *                  is the command. A 0xF3 or 0xE9 must follow (see synaptics_send_cmd
+ *                  and synaptics_set_mode)
+ */
+static int synaptics_special_cmd(struct psmouse *psmouse, unsigned char command)
+{
+	int i;
+
+	if (psmouse_command(psmouse, NULL, PSMOUSE_CMD_SETSCALE11))
+		return -1;
+
+	for (i = 6; i >= 0; i -= 2) {
+		unsigned char d = (command >> i) & 3;
+		if (psmouse_command(psmouse, &d, PSMOUSE_CMD_SETRES))
+			return -1;
+	}
+
+	return 0;
+}
+
+/*
+ * Send a command to the synpatics touchpad by special commands
+ */
+static int synaptics_send_cmd(struct psmouse *psmouse, unsigned char c, unsigned char *param)
+{
+	if (synaptics_special_cmd(psmouse, c))
+		return -1;
+	if (psmouse_command(psmouse, param, PSMOUSE_CMD_GETINFO))
+		return -1;
+	return 0;
+}
+
+/*****************************************************************************
+ *	Synaptics communications functions
+ ****************************************************************************/
+
+/*
+ * Set the synaptics touchpad mode byte by special commands
+ */
+static int synaptics_set_mode(struct psmouse *psmouse, unsigned char mode)
+{
+	unsigned char param[1];
+
+	if (synaptics_special_cmd(psmouse, mode))
+		return -1;
+	param[0] = 0x14;
+	if (psmouse_command(psmouse, param, PSMOUSE_CMD_SETRATE))
+		return -1;
+	return 0;
+}
+
+static int synaptics_reset(struct psmouse *psmouse)
+{
+	unsigned char r[2];
+
+	if (psmouse_command(psmouse, r, PSMOUSE_CMD_RESET_BAT))
+		return -1;
+	if (r[0] == 0xAA && r[1] == 0x00)
+		return 0;
+	return -1;
+}
+
+/*
+ * Read the model-id bytes from the touchpad
+ * see also SYN_MODEL_* macros
+ */
+static int synaptics_model_id(struct psmouse *psmouse, unsigned long int *model_id)
+{
+	unsigned char mi[3];
+
+	if (synaptics_send_cmd(psmouse, SYN_QUE_MODEL, mi))
+		return -1;
+	*model_id = (mi[0]<<16) | (mi[1]<<8) | mi[2];
+	return 0;
+}
+
+/*
+ * Read the capability-bits from the touchpad
+ * see also the SYN_CAP_* macros
+ */
+static int synaptics_capability(struct psmouse *psmouse, unsigned long int *capability)
+{
+	unsigned char cap[3];
+
+	if (synaptics_send_cmd(psmouse, SYN_QUE_CAPABILITIES, cap))
+		return -1;
+	*capability = (cap[0]<<16) | (cap[1]<<8) | cap[2];
+	if (SYN_CAP_VALID(*capability))
+		return 0;
+	return -1;
+}
+
+/*
+ * Identify Touchpad
+ * See also the SYN_ID_* macros
+ */
+static int synaptics_identify(struct psmouse *psmouse, unsigned long int *ident)
+{
+	unsigned char id[3];
+
+	if (synaptics_send_cmd(psmouse, SYN_QUE_IDENTIFY, id))
+		return -1;
+	*ident = (id[0]<<16) | (id[1]<<8) | id[2];
+	if (SYN_ID_IS_SYNAPTICS(*ident))
+		return 0;
+	return -1;
+}
+
+static int synaptics_enable_device(struct psmouse *psmouse)
+{
+	if (psmouse_command(psmouse, NULL, PSMOUSE_CMD_ENABLE))
+		return -1;
+	return 0;
+}
+
+static void print_ident(struct synaptics_data *priv)
+{
+	printk(KERN_INFO "Synaptics Touchpad, model: %ld\n", SYN_ID_MODEL(priv->identity));
+	printk(KERN_INFO " Firware: %ld.%ld\n", SYN_ID_MAJOR(priv->identity),
+	       SYN_ID_MINOR(priv->identity));
+
+	if (SYN_MODEL_ROT180(priv->model_id))
+		printk(KERN_INFO " 180 degree mounted touchpad\n");
+	if (SYN_MODEL_PORTRAIT(priv->model_id))
+		printk(KERN_INFO " portrait touchpad\n");
+	printk(KERN_INFO " Sensor: %ld\n", SYN_MODEL_SENSOR(priv->model_id));
+	if (SYN_MODEL_NEWABS(priv->model_id))
+		printk(KERN_INFO " new absolute packet format\n");
+	if (SYN_MODEL_PEN(priv->model_id))
+		printk(KERN_INFO " pen detection\n");
+
+	if (SYN_CAP_EXTENDED(priv->capabilities)) {
+		printk(KERN_INFO " Touchpad has extended capability bits\n");
+		if (SYN_CAP_FOUR_BUTTON(priv->capabilities))
+			printk(KERN_INFO " -> four buttons\n");
+		if (SYN_CAP_MULTIFINGER(priv->capabilities))
+			printk(KERN_INFO " -> multifinger detection\n");
+		if (SYN_CAP_PALMDETECT(priv->capabilities))
+			printk(KERN_INFO " -> palm detection\n");
+	}
+}
+
+static int query_hardware(struct psmouse *psmouse)
+{
+	struct synaptics_data *priv = psmouse->private;
+	int retries = 3;
+
+	while ((retries++ <= 3) && synaptics_reset(psmouse))
+		printk(KERN_ERR "synaptics reset failed\n");
+
+	if (synaptics_identify(psmouse, &priv->identity))
+		return -1;
+	if (synaptics_model_id(psmouse, &priv->model_id))
+		return -1;
+	if (synaptics_capability(psmouse, &priv->capabilities))
+		return -1;
+	if (synaptics_set_mode(psmouse, (SYN_BIT_ABSOLUTE_MODE |
+					 SYN_BIT_HIGH_RATE |
+					 SYN_BIT_DISABLE_GESTURE |
+					 SYN_BIT_W_MODE)))
+		return -1;
+
+	synaptics_enable_device(psmouse);
+
+	print_ident(priv);
+
+	return 0;
+}
+
+static void synaptics_repeat_timer(unsigned long data)
+{
+	struct psmouse *psmouse = (void *) data;
+	struct input_dev *dev = &psmouse->dev;
+	struct synaptics_data *priv = psmouse->private;
+
+	if (priv->repeat_buttons & 0x01)
+		input_report_rel(dev, REL_WHEEL, 1);
+	if (priv->repeat_buttons & 0x02)
+		input_report_rel(dev, REL_WHEEL, -1);
+	input_sync(dev);
+
+	if (atomic_read(&priv->timer_active))
+		mod_timer(&priv->timer, jiffies + 100 * HZ / 1000);
+}
+
+static struct synaptics_parameters default_params = {
+	.left_edge			= 1800,
+	.right_edge			= 5400,
+	.top_edge			= 4200,
+	.bottom_edge			= 1500,
+	.finger_low			= 25,
+	.finger_high			= 30,
+	.tap_time			= 15,
+	.tap_move			= 220,
+	.emulate_mid_button_time	= 6,
+	.scroll_dist_vert		= 100,
+	.scroll_dist_horiz		= 100,
+	.speed				= 25,
+	.edge_motion_speed		= 40,
+	.updown_button_scrolling	= 1
+};
+
+static int synaptics_init(struct psmouse *psmouse)
+{
+	struct synaptics_data *priv;
+
+	psmouse->private = priv = kmalloc(sizeof(struct synaptics_data), GFP_KERNEL);
+	if (!priv)
+		return -1;
+	memset(priv, 0, sizeof(struct synaptics_data));
+
+	priv->inSync = 1;
+
+	/* Set default parameters */
+	priv->params = default_params;
+
+	if (query_hardware(psmouse)) {
+		printk(KERN_ERR "Unable to query/initialize Synaptics hardware.\n");
+		goto init_fail;
+	}
+
+	set_bit(REL_WHEEL, psmouse->dev.relbit);
+	set_bit(REL_HWHEEL, psmouse->dev.relbit);
+
+	init_timer(&priv->timer);
+	priv->timer.data = (unsigned long)psmouse;
+	priv->timer.function = synaptics_repeat_timer;
+	atomic_set(&priv->timer_active, 0);
+
+	return 0;
+
+ init_fail:
+	kfree(priv);
+	return -1;
+}
+
+static void synaptics_disconnect(struct psmouse *psmouse)
+{
+	struct synaptics_data *priv = psmouse->private;
+
+	atomic_set(&priv->timer_active, 0);
+	priv->repeat_buttons = 0;
+	del_timer_sync(&priv->timer);
+
+	kfree(priv);
+}
+
+/*****************************************************************************
+ *	Functions to interpret the absolute mode packets
+ ****************************************************************************/
+
+#define DIFF_TIME(a, b) (((a) > (b)) ? (a) - (b) : (b) - (a))
+
+typedef enum {
+	BOTTOM_EDGE = 1,
+	TOP_EDGE = 2,
+	LEFT_EDGE = 4,
+	RIGHT_EDGE = 8,
+	LEFT_BOTTOM_EDGE = BOTTOM_EDGE | LEFT_EDGE,
+	RIGHT_BOTTOM_EDGE = BOTTOM_EDGE | RIGHT_EDGE,
+	RIGHT_TOP_EDGE = TOP_EDGE | RIGHT_EDGE,
+	LEFT_TOP_EDGE = TOP_EDGE | LEFT_EDGE
+} edge_type;
+
+static edge_type
+edge_detection(struct synaptics_data *priv, int x, int y)
+{
+	edge_type edge = 0;
+
+	if (x > priv->params.right_edge)
+		edge |= RIGHT_EDGE;
+	else if (x < priv->params.left_edge)
+		edge |= LEFT_EDGE;
+
+	if (y > priv->params.top_edge)
+		edge |= TOP_EDGE;
+	else if (y < priv->params.bottom_edge)
+		edge |= BOTTOM_EDGE;
+
+	return edge;
+}
+
+#define MOVE_HIST(a) ((priv->count_packet_finger-(a))%SYNAPTICS_MOVE_HISTORY)
+
+static inline int clamp(int val, int min, int max)
+{
+	if (val < min)
+		return min;
+	else if (val < max)
+		return val;
+	else
+		return max;
+}
+
+static void synaptics_parse_hw_state(struct synaptics_data *priv,
+				     struct synaptics_hw_state *hw)
+{
+	unsigned char *buf = priv->proto_buf;
+
+	hw->x = (((buf[3] & 0x10) << 8) |
+		 ((buf[1] & 0x0f) << 8) |
+		 buf[4]);
+	hw->y = (((buf[3] & 0x20) << 7) |
+		 ((buf[1] & 0xf0) << 4) |
+		 buf[5]);
+
+	hw->z = buf[2];
+	hw->w = (((buf[0] & 0x30) >> 2) |
+		 ((buf[0] & 0x04) >> 1) |
+		 ((buf[3] & 0x04) >> 2));
+
+	hw->left  = (buf[0] & 0x01) ? 1 : 0;
+	hw->right = (buf[0] & 0x2) ? 1 : 0;
+	hw->up    = 0;
+	hw->down  = 0;
+
+	if (SYN_CAP_EXTENDED(priv->capabilities) &&
+	    (SYN_CAP_FOUR_BUTTON(priv->capabilities))) {
+		hw->up = ((buf[3] & 0x01)) ? 1 : 0;
+		if (hw->left)
+			hw->up = !hw->up;
+		hw->down = ((buf[3] & 0x02)) ? 1 : 0;
+		if (hw->right)
+			hw->down = !hw->down;
+	}
+}
+
+static int synaptics_emulate_mid_button(struct synaptics_data *priv,
+					struct synaptics_hw_state *hw)
+{
+	int timeout = (DIFF_TIME(priv->count_packet, priv->count_button_delay) >=
+		       priv->params.emulate_mid_button_time);
+	int mid = 0;
+
+	for (;;) {
+		switch (priv->mid_emu_state) {
+		case MBE_OFF:
+			if (hw->left) {
+				priv->mid_emu_state = MBE_LEFT;
+			} else if (hw->right) {
+				priv->mid_emu_state = MBE_RIGHT;
+			} else {
+				priv->count_button_delay = priv->count_packet;
+				goto done;
+			}
+			break;
+		case MBE_LEFT:
+			if (!hw->left || timeout) {
+				hw->left = 1;
+				priv->mid_emu_state = MBE_OFF;
+				goto done;
+			} else if (hw->right) {
+				priv->mid_emu_state = MBE_MID;
+			} else {
+				hw->left = 0;
+				goto done;
+			}
+			break;
+		case MBE_RIGHT:
+			if (!hw->right || timeout) {
+				hw->right = 1;
+				priv->mid_emu_state = MBE_OFF;
+				goto done;
+			} else if (hw->left) {
+				priv->mid_emu_state = MBE_MID;
+			} else {
+				hw->right = 0;
+				goto done;
+			}
+			break;
+		case MBE_MID:
+			if (!hw->left && !hw->right) {
+				priv->mid_emu_state = MBE_OFF;
+			} else {
+				mid = 1;
+				hw->left = hw->right = 0;
+				goto done;
+			}
+			break;
+		}
+	}
+ done:
+	return mid;
+}
+
+static int synaptics_detect_finger(struct synaptics_data *priv,
+				   const struct synaptics_hw_state *hw)
+{
+	const struct synaptics_parameters *para = &priv->params;
+	int finger;
+
+	/* finger detection thru pressure and threshold */
+	finger = (((hw->z > para->finger_high) && !priv->finger_flag) ||
+		  ((hw->z > para->finger_low)  &&  priv->finger_flag));
+
+	/* palm detection */
+	if (!SYN_CAP_EXTENDED(priv->capabilities) || !SYN_CAP_PALMDETECT(priv->capabilities))
+		return finger;
+
+	if (finger) {
+		if ((hw->z > 200) && (hw->w > 10))
+			priv->palm = 1;
+	} else {
+		priv->palm = 0;
+	}
+	if (hw->x == 0)
+		priv->avg_w = 0;
+	else
+		priv->avg_w += (hw->w - priv->avg_w + 1) / 2;
+	if (finger && !priv->finger_flag) {
+		int safe_w = max_t(int, hw->w, priv->avg_w);
+		if (hw->w < 2)
+			finger = 1;		/* more than one finger -> not a palm */
+		else if ((safe_w < 6) && (priv->prev_z < para->finger_high))
+			finger = 1;		/* thin finger, distinct touch -> not a palm */
+		else if ((safe_w < 7) && (priv->prev_z < para->finger_high / 2))
+			finger = 1;		/* thin finger, distinct touch -> not a palm */
+		else if (hw->z > priv->prev_z + 1)
+			finger = 0;		/* z not stable, may be a palm */
+		else if (hw->z < priv->prev_z - 5)
+			finger = 0;		/* z not stable, may be a palm */
+		else if (hw->z > 200)
+			finger = 0;		/* z too large -> probably palm */
+		else if (hw->w > 10)
+			finger = 0;		/* w too large -> probably palm */
+	}
+	priv->prev_z = hw->z;
+
+	return finger;
+}
+
+/*
+ *  called for each full received packet from the touchpad
+ */
+static void synaptics_process_packet(struct psmouse *psmouse)
+{
+	struct input_dev *dev = &psmouse->dev;
+	struct synaptics_data *priv = psmouse->private;
+	const struct synaptics_parameters *para = &priv->params;
+	struct synaptics_hw_state hw;
+	int dx, dy;
+	edge_type edge;
+	int scroll_up, scroll_down, scroll_left, scroll_right;
+	int double_click;
+
+	int finger;
+	int mid;
+
+	synaptics_parse_hw_state(priv, &hw);
+
+	edge = edge_detection(priv, hw.x, hw.y);
+
+	mid = synaptics_emulate_mid_button(priv, &hw);
+
+	/* Up/Down-button scrolling or middle/double-click */
+	double_click = 0;
+	if (!para->updown_button_scrolling) {
+		if (down) {
+			/* map down-button to middle-button */
+			mid = 1;
+		}
+
+		if (hw.up) {
+			/* up-button generates double-click */
+			if (!priv->prev_up)
+				double_click = 1;
+		}
+		priv->prev_up = hw.up;
+
+		/* reset up/down button events */
+		hw.up = hw.down = 0;
+	}
+
+	finger = synaptics_detect_finger(priv, &hw);
+
+	/* tap and drag detection */
+	if (priv->palm) {
+		/* Palm detected, skip tap/drag processing */
+	} else if (finger && !priv->finger_flag) {
+		/* touched */
+		if (priv->tap) {
+			priv->drag = 1; /* drag gesture */
+		}
+		priv->touch_on.x = hw.x;
+		priv->touch_on.y = hw.y;
+		priv->touch_on.packet = priv->count_packet;
+	} else if (!finger && priv->finger_flag) {
+		/* untouched */
+		/* check if
+		   1. the tap is in tap_time
+		   2. the max movement is in tap_move or more than one finger is tapped */
+		if ((DIFF_TIME(priv->count_packet, priv->touch_on.packet) < para->tap_time) &&
+		    (((abs(hw.x - priv->touch_on.x) < para->tap_move) &&
+		      (abs(hw.y - priv->touch_on.y) < para->tap_move)) ||
+		     priv->finger_count)) {
+			if (priv->drag) {
+				priv->doubletap = 1;
+				priv->tap = 0;
+			} else {
+				priv->count_packet_tapping = priv->count_packet;
+				priv->tap = 1;
+				switch (priv->finger_count) {
+				case 0:
+					switch (edge) {
+					case RIGHT_TOP_EDGE:
+						priv->tap_mid = 1;
+						break;
+					case RIGHT_BOTTOM_EDGE:
+						priv->tap_right = 1;
+						break;
+					case LEFT_TOP_EDGE:
+						break;
+					case LEFT_BOTTOM_EDGE:
+						break;
+					default:
+						priv->tap_left = 1;
+					}
+					break;
+				case 2:
+					priv->tap_mid = 1;
+					break;
+				case 3: 
+					priv->tap_right = 1;
+					break;
+				default:
+					priv->tap_left = 1;
+				}
+			}
+		}
+		priv->drag = 0;
+	}
+
+	/* detecting 2 and 3 fingers */
+	if (finger && /* finger is on the surface */
+	    (DIFF_TIME(priv->count_packet, priv->touch_on.packet) < para->tap_time) &&
+	    SYN_CAP_MULTIFINGER(priv->capabilities)) {
+		/* count fingers when reported */
+		if ((hw.w == 0) && (priv->finger_count == 0))
+			priv->finger_count = 2;
+		if (hw.w == 1)
+			priv->finger_count = 3;
+	} else {
+		priv->finger_count = 0;
+	}
+
+	/* reset tapping button flags */
+	if (!priv->tap && !priv->drag && !priv->doubletap) {
+		priv->tap_left = priv->tap_mid = priv->tap_right = 0;
+	}
+
+	/* tap processing */
+	if (priv->tap &&
+	    (DIFF_TIME(priv->count_packet, priv->count_packet_tapping) < para->tap_time)) {
+		hw.left  |= priv->tap_left;
+		mid      |= priv->tap_mid;
+		hw.right |= priv->tap_right;
+	} else {
+		priv->tap = 0;
+	}
+
+	/* drag processing */
+	if (priv->drag) {
+		hw.left  |= priv->tap_left;
+		mid      |= priv->tap_mid;
+		hw.right |= priv->tap_right;
+	}
+
+	/* double tap processing */
+	if (priv->doubletap && !priv->finger_flag) {
+		hw.left  |= priv->tap_left;
+		mid      |= priv->tap_mid;
+		hw.right |= priv->tap_right;
+		priv->doubletap = 0;
+	}
+
+	/* scroll detection */
+	if (finger && !priv->finger_flag) {
+		if (edge & RIGHT_EDGE) {
+			priv->vert_scroll_on = 1;
+			priv->scroll_y = hw.y;
+		}
+		if (edge & BOTTOM_EDGE) {
+			priv->horiz_scroll_on = 1;
+			priv->scroll_x = hw.x;
+		}
+	}
+	if (priv->vert_scroll_on && (!(edge & RIGHT_EDGE) || !finger || priv->palm)) {
+		priv->vert_scroll_on = 0;
+	}
+	if (priv->horiz_scroll_on && (!(edge & BOTTOM_EDGE) || !finger || priv->palm)) {
+		priv->horiz_scroll_on = 0;
+	}
+
+	/* scroll processing */
+	scroll_up = 0;
+	scroll_down = 0;
+	if (priv->vert_scroll_on) {
+		/* + = up, - = down */
+		while (hw.y - priv->scroll_y > para->scroll_dist_vert) {
+			scroll_up++;
+			priv->scroll_y += para->scroll_dist_vert;
+		}
+		while (hw.y - priv->scroll_y < -para->scroll_dist_vert) {
+			scroll_down++;
+			priv->scroll_y -= para->scroll_dist_vert;
+		}
+	}
+	scroll_left = 0;
+	scroll_right = 0;
+	if (priv->horiz_scroll_on) {
+		/* + = right, - = left */
+		while (hw.x - priv->scroll_x > para->scroll_dist_horiz) {
+			scroll_right++;
+			priv->scroll_x += para->scroll_dist_horiz;
+		}
+		while (hw.x - priv->scroll_x < -para->scroll_dist_horiz) {
+			scroll_left++;
+			priv->scroll_x -= para->scroll_dist_horiz;
+		}
+	}
+
+	/* movement */
+	dx = dy = 0;
+	if (finger && !priv->vert_scroll_on && !priv->horiz_scroll_on &&
+	    !priv->finger_count && !priv->palm) {
+		if (priv->count_packet_finger > 3) { /* min. 3 packets */
+			int h2x = priv->move_hist[MOVE_HIST(2)].x;
+			int h2y = priv->move_hist[MOVE_HIST(2)].y;
+
+			dx =  ((hw.x - h2x) / 2);
+			dy = -((hw.y - h2y) / 2);
+
+			if (priv->drag) {
+				if (edge & RIGHT_EDGE) {
+					dx += clamp(para->edge_motion_speed - dx,
+						    0, para->edge_motion_speed);
+				} else if (edge & LEFT_EDGE) {
+					dx -= clamp(para->edge_motion_speed + dx,
+						    0, para->edge_motion_speed);
+				}
+				if (edge & TOP_EDGE) {
+					dy -= clamp(para->edge_motion_speed + dy,
+						    0, para->edge_motion_speed);
+				} else if (edge & BOTTOM_EDGE) {
+					dy += clamp(para->edge_motion_speed - dy,
+						    0, para->edge_motion_speed);
+				}
+			}
+
+			/* Scale dx and dy to get pointer motion values */
+			priv->accum_dx += dx * para->speed;
+			priv->accum_dy += dy * para->speed;
+
+			dx = priv->accum_dx / 256;
+			dy = priv->accum_dy / 256;
+
+			priv->accum_dx -= dx * 256;
+			priv->accum_dy -= dy * 256;
+		}
+
+		priv->count_packet_finger++;
+	} else {
+		priv->count_packet_finger = 0;
+	}
+
+	priv->count_packet++;
+
+	/* Flags */
+	priv->finger_flag = finger;
+
+	/* generate a history of the absolute positions */
+	priv->move_hist[MOVE_HIST(0)].x = hw.x;
+	priv->move_hist[MOVE_HIST(0)].y = hw.y;
+
+	/* repeat timer for up/down buttons */
+	/* when you press a button the packets will only send for a second, so
+	   we have to use a timer for repeating */
+	if ((hw.up || hw.down) && para->updown_button_scrolling) {
+		if (!atomic_read(&priv->timer_active)) {
+			priv->repeat_buttons = ((hw.up    ? 0x01 : 0) |
+						(hw.down  ? 0x02 : 0));
+			atomic_set(&priv->timer_active, 1);
+			mod_timer(&priv->timer, jiffies + 200 * HZ / 1000);
+		}
+	} else if (atomic_read(&priv->timer_active)) {
+		atomic_set(&priv->timer_active, 0);
+		priv->repeat_buttons = 0;
+		del_timer_sync(&priv->timer);
+	}
+
+	/* Post events */
+	input_report_rel(dev, REL_X, dx);
+	input_report_rel(dev, REL_Y, dy);
+
+	input_report_key(dev, BTN_LEFT,   hw.left);
+	input_report_key(dev, BTN_MIDDLE, mid);
+	input_report_key(dev, BTN_RIGHT,  hw.right);
+
+	if (hw.up && !priv->last_up)
+		input_report_rel(dev, REL_WHEEL, 1);
+	if (hw.down && !priv->last_down)
+		input_report_rel(dev, REL_WHEEL, -1);
+	priv->last_up = hw.up;
+	priv->last_down = hw.down;
+
+	input_report_rel(dev, REL_WHEEL, scroll_up - scroll_down);
+	input_report_rel(dev, REL_HWHEEL, scroll_right - scroll_left);
+
+	if (double_click) {
+		int i;
+		for (i = 0; i < 2; i++) {
+			input_report_key(dev, BTN_LEFT, !hw.left);
+			input_report_key(dev, BTN_LEFT, hw.left);
+		}
+	}
+
+	input_sync(dev);
+}
+
+static void synaptics_process_byte(struct psmouse *psmouse, struct pt_regs *regs)
+{
+	struct input_dev *dev = &psmouse->dev;
+	struct synaptics_data *priv = psmouse->private;
+	unsigned char *pBuf = priv->proto_buf;
+	unsigned char u = psmouse->packet[0];
+
+	input_regs(dev, regs);
+
+	pBuf[priv->proto_buf_tail++] = u;
+
+	/* check first byte */
+	if ((priv->proto_buf_tail == 1) && ((u & 0xC8) != 0x80)) {
+		priv->inSync = 0;
+		priv->proto_buf_tail = 0;
+		printk(KERN_WARNING "Synaptics driver lost sync at 1st byte\n");
+		return;
+	}
+
+	/* check 4th byte */
+	if ((priv->proto_buf_tail == 4) && ((u & 0xc8) != 0xc0)) {
+		priv->inSync = 0;
+		priv->proto_buf_tail = 0;
+		printk(KERN_WARNING "Synaptics driver lost sync at 4th byte\n");
+		return;
+	}
+
+	if (priv->proto_buf_tail >= 6) { /* Full packet received */
+		if (!priv->inSync) {
+			priv->inSync = 1;
+			printk(KERN_NOTICE "Synaptics driver resynced.\n");
+		}
+		synaptics_process_packet(psmouse);
+		priv->proto_buf_tail = 0;
+	}
+}
+
+#endif /* CONFIG_MOUSE_PS2_SYNAPTICS */
diff -u -r -N ../../linus/main/linux/drivers/input/mouse/synaptics.h linux/drivers/input/mouse/synaptics.h
--- ../../linus/main/linux/drivers/input/mouse/synaptics.h	Thu Jan  1 01:00:00 1970
+++ linux/drivers/input/mouse/synaptics.h	Wed Jun 11 00:08:41 2003
@@ -0,0 +1,158 @@
+/*
+ * Synaptics TouchPad PS/2 mouse driver
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#ifndef _SYNAPTICS_H
+#define _SYNAPTICS_H
+
+/* synaptics queries */
+#define SYN_QUE_IDENTIFY		0x00
+#define SYN_QUE_MODES			0x01
+#define SYN_QUE_CAPABILITIES		0x02
+#define SYN_QUE_MODEL			0x03
+#define SYN_QUE_SERIAL_NUMBER_PREFIX	0x06
+#define SYN_QUE_SERIAL_NUMBER_SUFFIX	0x07
+#define SYN_QUE_RESOLUTION		0x08
+
+/* synatics modes */
+#define SYN_BIT_ABSOLUTE_MODE		(1 << 7)
+#define SYN_BIT_HIGH_RATE		(1 << 6)
+#define SYN_BIT_SLEEP_MODE		(1 << 3)
+#define SYN_BIT_DISABLE_GESTURE		(1 << 2)
+#define SYN_BIT_W_MODE			(1 << 0)
+
+/* synaptics model ID bits */
+#define SYN_MODEL_ROT180(m)		((m) & (1 << 23))
+#define SYN_MODEL_PORTRAIT(m)		((m) & (1 << 22))
+#define SYN_MODEL_SENSOR(m)		(((m) >> 16) & 0x3f)
+#define SYN_MODEL_HARDWARE(m)		(((m) >> 9) & 0x7f)
+#define SYN_MODEL_NEWABS(m)		((m) & (1 << 7))
+#define SYN_MODEL_PEN(m)		((m) & (1 << 6))
+#define SYN_MODEL_SIMPLIC(m)		((m) & (1 << 5))
+#define SYN_MODEL_GEOMETRY(m)		((m) & 0x0f)
+
+/* synaptics capability bits */
+#define SYN_CAP_EXTENDED(c)		((c) & (1 << 23))
+#define SYN_CAP_SLEEP(c)		((c) & (1 << 4))
+#define SYN_CAP_FOUR_BUTTON(c)		((c) & (1 << 3))
+#define SYN_CAP_MULTIFINGER(c)		((c) & (1 << 1))
+#define SYN_CAP_PALMDETECT(c)		((c) & (1 << 0))
+#define SYN_CAP_VALID(c)		((((c) & 0x00ff00) >> 8) == 0x47)
+
+/* synaptics modes query bits */
+#define SYN_MODE_ABSOLUTE(m)		((m) & (1 << 7))
+#define SYN_MODE_RATE(m)		((m) & (1 << 6))
+#define SYN_MODE_BAUD_SLEEP(m)		((m) & (1 << 3))
+#define SYN_MODE_DISABLE_GESTURE(m)	((m) & (1 << 2))
+#define SYN_MODE_PACKSIZE(m)		((m) & (1 << 1))
+#define SYN_MODE_WMODE(m)		((m) & (1 << 0))
+
+/* synaptics identify query bits */
+#define SYN_ID_MODEL(i) 		(((i) >> 4) & 0x0f)
+#define SYN_ID_MAJOR(i) 		((i) & 0x0f)
+#define SYN_ID_MINOR(i) 		(((i) >> 16) & 0xff)
+#define SYN_ID_IS_SYNAPTICS(i)		((((i) >> 8) & 0xff) == 0x47)
+
+
+struct synaptics_parameters {
+	int left_edge;				/* Edge coordinates, absolute */
+	int right_edge;
+	int top_edge;
+	int bottom_edge;
+
+	int finger_low, finger_high;		/* finger detection values in Z-values */
+	int tap_time, tap_move;			/* max. tapping-time and movement in packets and coord. */
+	int emulate_mid_button_time;		/* Max time between left and right button presses to
+						   emulate a middle button press. */
+	int scroll_dist_vert;			/* Scrolling distance in absolute coordinates */
+	int scroll_dist_horiz;			/* Scrolling distance in absolute coordinates */
+	int speed;				/* Pointer motion speed */
+	int edge_motion_speed;			/* Edge motion speed when dragging */
+	int updown_button_scrolling;		/* Up/Down-Button scrolling or middle/double-click */
+};
+
+/*
+ * A structure to describe the state of the touchpad hardware (buttons and pad)
+ */
+struct synaptics_hw_state {
+	int x;
+	int y;
+	int z;
+	int w;
+	int left;
+	int right;
+	int up;
+	int down;
+};
+
+#define SYNAPTICS_MOVE_HISTORY	5
+
+struct SynapticsTapRec {
+	int x, y;
+	unsigned int packet;
+};
+
+struct SynapticsMoveHist {
+	int x, y;
+};
+
+enum MidButtonEmulation {
+	MBE_OFF,			/* No button pressed */
+	MBE_LEFT,			/* Left button pressed, waiting for right button or timeout */
+	MBE_RIGHT,			/* Right button pressed, waiting for left button or timeout */
+	MBE_MID				/* Left and right buttons pressed, waiting for both buttons
+					   to be released */
+};
+
+struct synaptics_data {
+	struct synaptics_parameters params;
+
+	/* Data read from the touchpad */
+	unsigned long int model_id;		/* Model-ID */
+	unsigned long int capabilities; 	/* Capabilities */
+	unsigned long int identity;		/* Identification */
+
+	/* Data for normal processing */
+	unsigned char proto_buf[6];		/* Buffer for Packet */
+	unsigned char last_byte;		/* last received byte */
+	int inSync;				/* Packets in sync */
+	int proto_buf_tail;
+
+	struct SynapticsTapRec touch_on;	/* data when the touchpad is touched */
+	struct SynapticsMoveHist move_hist[SYNAPTICS_MOVE_HISTORY];
+						/* movement history */
+	int accum_dx;				/* Accumulated fractional pointer motion */
+	int accum_dy;
+	int scroll_x;				/* last x-scroll position */
+	int scroll_y;				/* last y-scroll position */
+	unsigned int count_packet_finger;	/* packet counter with finger on the touchpad */
+	unsigned int count_packet;		/* packet counter */
+	unsigned int count_packet_tapping;	/* packet counter for tapping */
+	unsigned int count_button_delay;	/* button delay for 3rd button emulation */
+	unsigned int prev_up;			/* Previous up button value, for double click emulation */
+	int finger_flag;			/* previous finger */
+	int tap, drag, doubletap;		/* feature flags */
+	int tap_left, tap_mid, tap_right;	/* tapping buttons */
+	int vert_scroll_on;			/* scrolling flag */
+	int horiz_scroll_on;			/* scrolling flag */
+	enum MidButtonEmulation mid_emu_state;	/* emulated 3rd button */
+
+	atomic_t timer_active;
+	struct timer_list timer;		/* for up/down-button repeat */
+	int repeat_buttons;			/* buttons for repeat */
+	int last_up, last_down;			/* Previous value of up/down buttons */
+
+	int finger_count;			/* tap counter for fingers */
+
+	/* For palm detection */
+	int palm;				/* Set to true when palm detected, reset to false when
+						 * palm/finger contact disappears */
+	int prev_z;				/* previous z value, for palm detection */
+	int avg_w;				/* weighted average of previous w values */
+};
+
+#endif /* _SYNAPTICS_H */

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340

