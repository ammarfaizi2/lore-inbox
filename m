Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262633AbTFPGoe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 02:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263451AbTFPGoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 02:44:34 -0400
Received: from p5082054E.dip0.t-ipconnect.de ([80.130.5.78]:16829 "EHLO
	localhost") by vger.kernel.org with ESMTP id S262633AbTFPGnv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 02:43:51 -0400
To: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@ucw.cz>
Subject: [PATCH] Synaptics Client/Passthrough (for Inspiron...)
References: <m2smqhqk4k.fsf@p4.localdomain> <20030611170246.A4187@ucw.cz>
	<m27k7sv5si.fsf@telia.com> <20030611203408.A6961@ucw.cz>
	<m2ptlkqpej.fsf@telia.com> <m3llw7d763.fsf@lugabout.jhcloos.org>
From: Arne Koewing <ark@gmx.net>
Date: Sun, 15 Jun 2003 23:42:37 +0200
In-Reply-To: <m3llw7d763.fsf@lugabout.jhcloos.org> (James H. Cloos, Jr.'s
 message of "12 Jun 2003 04:36:04 -0400")
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
Message-ID: <87adcio6qw.fsf@localhost.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=


I've written some code for the synaptics-client-pasthroug thing
for the synaptics driver.
it's just working now, but may not be perfect/ready in any sense.


synaptics-client-full.patch
-includes the synsptics patch

synaptics-client-incremental.patch
-for kernels with synaptics-patch already applied

happy testing!!

Arne



--=-=-=
Content-Type: text/x-patch; charset=iso-8859-1
Content-Disposition: attachment; filename=synaptics-client-full.patch
Content-Transfer-Encoding: quoted-printable

Index: linux/drivers/input/mouse/synaptics.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux/drivers/input/mouse/synaptics.h	(revision 4)
+++ linux/drivers/input/mouse/synaptics.h	(revision 10)
@@ -0,0 +1,163 @@
+/*
+ * Synaptics TouchPad PS/2 mouse driver
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as publishe=
d by
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
+#define SYN_CAP_CLIENT(c)               ((c) & (1 << 7))
+#define SYN_CAP_SLEEP(c)		((c) & (1 << 4))
+#define SYN_CAP_FOUR_BUTTON(c)		((c) & (1 << 3))
+#define SYN_CAP_MULTIFINGER(c)		((c) & (1 << 1))
+#define SYN_CAP_PALMDETECT(c)		((c) & (1 << 0))
+#define SYN_CAP_VALID(c)		((((c) & 0x00ff00) >> 8) =3D=3D 0x47)
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
+#define SYN_ID_IS_SYNAPTICS(i)		((((i) >> 8) & 0xff) =3D=3D 0x47)
+
+/* client commands*/
+
+
+struct synaptics_parameters {
+	int left_edge;				/* Edge coordinates, absolute */
+	int right_edge;
+	int top_edge;
+	int bottom_edge;
+
+	int finger_low, finger_high;		/* finger detection values in Z-values */
+	int tap_time, tap_move;			/* max. tapping-time and movement in packets an=
d coord. */
+	int emulate_mid_button_time;		/* Max time between left and right button p=
resses to
+						   emulate a middle button press. */
+	int scroll_dist_vert;			/* Scrolling distance in absolute coordinates */
+	int scroll_dist_horiz;			/* Scrolling distance in absolute coordinates */
+	int speed;				/* Pointer motion speed */
+	int client_speed;				/* Client Pointer motion speed */
+	int edge_motion_speed;			/* Edge motion speed when dragging */
+	int updown_button_scrolling;		/* Up/Down-Button scrolling or middle/doubl=
e-click */
+};
+
+/*
+ * A structure to describe the state of the touchpad hardware (buttons and=
 pad)
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
+        int client;
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
+	MBE_RIGHT,			/* Right button pressed, waiting for left button or timeout =
*/
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
+	unsigned int count_packet_finger;	/* packet counter with finger on the to=
uchpad */
+	unsigned int count_packet;		/* packet counter */
+	unsigned int count_packet_tapping;	/* packet counter for tapping */
+	unsigned int count_button_delay;	/* button delay for 3rd button emulation=
 */
+	unsigned int prev_up;			/* Previous up button value, for double click emu=
lation */
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
Index: linux/drivers/input/mouse/synaptics.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux/drivers/input/mouse/synaptics.c	(revision 4)
+++ linux/drivers/input/mouse/synaptics.c	(revision 10)
@@ -0,0 +1,939 @@
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
+ *   2003 Arne K=F6wing <Arne.Koewing@informatik.uni-oldenburg.de>
+ *     Code for Synaptics client/passthrough  (from gpm source)
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as publishe=
d by
+ * the Free Software Foundation.
+ *
+ * Trademarks are the property of their respective owners.
+ */
+
+#ifndef CONFIG_MOUSE_PS2_SYNAPTICS
+
+static inline void synaptics_process_byte(struct psmouse *psmouse, struct =
pt_regs *regs) {}
+static inline int synaptics_init(struct psmouse *psmouse) { return -1; }
+static inline void synaptics_disconnect(struct psmouse *psmouse) {}
+
+#else
+
+#include "synaptics.h"
+
+
+static int psmouse_command(struct psmouse *psmouse, unsigned char *param, =
int command);
+
+/*
+ * Use the Synaptics extended ps/2 syntax to write a special command byte.
+ * special command: 0xE8 rr 0xE8 ss 0xE8 tt 0xE8 uu where (rr*64)+(ss*16)+=
(tt*4)+uu
+ *                  is the command. A 0xF3 or 0xE9 must follow (see synapt=
ics_send_cmd
+ *                  and synaptics_set_mode)
+ */
+static int synaptics_special_cmd(struct psmouse *psmouse, unsigned char co=
mmand)
+{
+	int i;
+
+	if (psmouse_command(psmouse, NULL, PSMOUSE_CMD_SETSCALE11))
+		return -1;
+
+	for (i =3D 6; i >=3D 0; i -=3D 2) {
+		unsigned char d =3D (command >> i) & 3;
+		if (psmouse_command(psmouse, &d, PSMOUSE_CMD_SETRES))
+			return -1;
+	}
+
+	return 0;
+}
+
+
+/*
+ * Send a command to the synpatics touchpad by special commands
+ */
+static int synaptics_send_cmd(struct psmouse *psmouse, unsigned char c, un=
signed char *param)
+{
+	if (synaptics_special_cmd(psmouse, c))
+		return -1;
+	if (psmouse_command(psmouse, param, PSMOUSE_CMD_GETINFO))
+		return -1;
+	return 0;
+}
+
+static int synaptics_client_sendbyte(struct psmouse *psmouse, unsigned cha=
r c)
+{
+  unsigned char param[4];
+  synaptics_special_cmd(psmouse, c);
+  param[0]=3D40;
+  if (psmouse_command(psmouse, param, PSMOUSE_CMD_SETRATE))
+    return -1;
+  return 0;
+}
+
+static int synaptics_client_command(struct psmouse *psmouse, unsigned char=
 *param, int command)
+{
+  int timeout =3D 500000; /* 500 msec */
+  int send =3D (command >> 12) & 0xf;
+  int receive =3D (command >> 8) & 0xf;
+  int i;
+=20=20
+  psmouse->cmdcnt =3D receive;
+=20=20
+	if (command =3D=3D PSMOUSE_CMD_RESET_BAT)
+                timeout =3D 2000000; /* 2 sec */
+
+	if (command & 0xff)
+		if (synaptics_client_sendbyte(psmouse, command & 0xff))
+			return (psmouse->cmdcnt =3D 0) - 1;
+
+	for (i =3D 0; i < send; i++)
+		if (synaptics_client_sendbyte(psmouse, param[i]))
+			return (psmouse->cmdcnt =3D 0) - 1;
+
+	while (psmouse->cmdcnt && timeout--) {
+=09
+		if (psmouse->cmdcnt =3D=3D 1 && command =3D=3D PSMOUSE_CMD_RESET_BAT)
+			timeout =3D 100000;
+
+		if (psmouse->cmdcnt =3D=3D 1 && command =3D=3D PSMOUSE_CMD_GETID &&
+		    psmouse->cmdbuf[1] !=3D 0xab && psmouse->cmdbuf[1] !=3D 0xac) {
+			psmouse->cmdcnt =3D 0;
+			break;
+		}
+
+		udelay(1);
+	}
+
+	for (i =3D 0; i < receive; i++)
+		param[i] =3D psmouse->cmdbuf[(receive - 1) - i];
+
+	if (psmouse->cmdcnt)=20
+		return (psmouse->cmdcnt =3D 0) - 1;
+
+	return 0;
+}
+
+/*
+static int synaptics_client_special_cmd(struct psmouse *psmouse, unsigned =
char command)
+{
+	int i;
+
+	if (synaptics_client_command(psmouse,NULL,PSMOUSE_CMD_SETSCALE11))
+		return -1;
+
+	for (i =3D 6; i >=3D 0; i -=3D 2) {
+		unsigned char d =3D (command >> i) & 3;
+		if (synaptics_client_command(psmouse,&d, PSMOUSE_CMD_SETRES))
+			return -1;
+	}
+	return 0;
+}
+*/
+static int synaptics_client_reset(struct psmouse *psmouse)
+{
+  unsigned char param[2];
+  if(synaptics_client_command(psmouse,param,PSMOUSE_CMD_RESET_BAT))
+    return -1;
+  if (param[0] =3D=3D 0xAA && param[1] =3D=3D 0x00)
+    return 0;
+  return -1;
+}
+=20
+/*************************************************************************=
****
+ *	Synaptics communications functions
+ *************************************************************************=
***/
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
+	param[0] =3D 0x14;
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
+	if (r[0] =3D=3D 0xAA && r[1] =3D=3D 0x00)
+		return 0;
+	return -1;
+}
+
+
+/*
+ * Read the model-id bytes from the touchpad
+ * see also SYN_MODEL_* macros
+ */
+static int synaptics_model_id(struct psmouse *psmouse, unsigned long int *=
model_id)
+{
+	unsigned char mi[3];
+
+	if (synaptics_send_cmd(psmouse, SYN_QUE_MODEL, mi))
+		return -1;
+	*model_id =3D (mi[0]<<16) | (mi[1]<<8) | mi[2];
+	return 0;
+}
+
+/*
+ * Read the capability-bits from the touchpad
+ * see also the SYN_CAP_* macros
+ */
+static int synaptics_capability(struct psmouse *psmouse, unsigned long int=
 *capability)
+{
+	unsigned char cap[3];
+
+	if (synaptics_send_cmd(psmouse, SYN_QUE_CAPABILITIES, cap))
+		return -1;
+	*capability =3D (cap[0]<<16) | (cap[1]<<8) | cap[2];
+	if (SYN_CAP_VALID(*capability))
+		return 0;
+	return -1;
+}
+
+/*
+ * Identify Touchpad
+ * See also the SYN_ID_* macros
+ */
+static int synaptics_identify(struct psmouse *psmouse, unsigned long int *=
ident)
+{
+	unsigned char id[3];
+
+	if (synaptics_send_cmd(psmouse, SYN_QUE_IDENTIFY, id))
+		return -1;
+	*ident =3D (id[0]<<16) | (id[1]<<8) | id[2];
+	if (SYN_ID_IS_SYNAPTICS(*ident))
+		return 0;
+	return -1;
+}
+
+static int synaptics_enable_device(struct psmouse *psmouse)
+{
+  struct synaptics_data *priv =3D psmouse->private;=20=20
+  if (SYN_CAP_CLIENT(priv->capabilities))
+    {
+      if(synaptics_client_reset(psmouse))
+	return -1;
+      if(synaptics_client_command(psmouse,NULL,PSMOUSE_CMD_ENABLE))
+	 return -1;
+    }
+  if (psmouse_command(psmouse, NULL, PSMOUSE_CMD_ENABLE))
+    return -1;
+  return 0;
+}
+
+static void print_ident(struct synaptics_data *priv)
+{
+	printk(KERN_INFO "Synaptics Touchpad, model: %ld\n", SYN_ID_MODEL(priv->i=
dentity));
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
+		if (SYN_CAP_CLIENT(priv->capabilities))
+			printk(KERN_INFO " -> client detection\n");
+	}
+}
+
+static int query_hardware(struct psmouse *psmouse)
+{
+	struct synaptics_data *priv =3D psmouse->private;
+	int retries =3D 3;
+
+	while ((retries++ <=3D 3) && synaptics_reset(psmouse))
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
+	struct psmouse *psmouse =3D (void *) data;
+	struct input_dev *dev =3D &psmouse->dev;
+	struct synaptics_data *priv =3D psmouse->private;
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
+static struct synaptics_parameters default_params =3D {
+	.left_edge			=3D 1800,
+	.right_edge			=3D 5400,
+	.top_edge			=3D 4200,
+	.bottom_edge			=3D 1500,
+	.finger_low			=3D 25,
+	.finger_high			=3D 30,
+	.tap_time			=3D 15,
+	.tap_move			=3D 220,
+	.emulate_mid_button_time	=3D 6,
+	.scroll_dist_vert		=3D 100,
+	.scroll_dist_horiz		=3D 100,
+	.speed				=3D 25,
+	.client_speed			=3D 200,
+	.edge_motion_speed		=3D 40,
+	.updown_button_scrolling	=3D 1
+};
+
+static int synaptics_init(struct psmouse *psmouse)
+{
+	struct synaptics_data *priv;
+
+	psmouse->private =3D priv =3D kmalloc(sizeof(struct synaptics_data), GFP_=
KERNEL);
+	if (!priv)
+		return -1;
+	memset(priv, 0, sizeof(struct synaptics_data));
+
+	priv->inSync =3D 1;
+
+	/* Set default parameters */
+	priv->params =3D default_params;
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
+	priv->timer.data =3D (unsigned long)psmouse;
+	priv->timer.function =3D synaptics_repeat_timer;
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
+	struct synaptics_data *priv =3D psmouse->private;
+
+	atomic_set(&priv->timer_active, 0);
+	priv->repeat_buttons =3D 0;
+	del_timer_sync(&priv->timer);
+
+	kfree(priv);
+}
+
+/*************************************************************************=
****
+ *	Functions to interpret the absolute mode packets
+ *************************************************************************=
***/
+
+#define DIFF_TIME(a, b) (((a) > (b)) ? (a) - (b) : (b) - (a))
+
+typedef enum {
+	BOTTOM_EDGE =3D 1,
+	TOP_EDGE =3D 2,
+	LEFT_EDGE =3D 4,
+	RIGHT_EDGE =3D 8,
+	LEFT_BOTTOM_EDGE =3D BOTTOM_EDGE | LEFT_EDGE,
+	RIGHT_BOTTOM_EDGE =3D BOTTOM_EDGE | RIGHT_EDGE,
+	RIGHT_TOP_EDGE =3D TOP_EDGE | RIGHT_EDGE,
+	LEFT_TOP_EDGE =3D TOP_EDGE | LEFT_EDGE
+} edge_type;
+
+static edge_type
+edge_detection(struct synaptics_data *priv, int x, int y)
+{
+	edge_type edge =3D 0;
+
+	if (x > priv->params.right_edge)
+		edge |=3D RIGHT_EDGE;
+	else if (x < priv->params.left_edge)
+		edge |=3D LEFT_EDGE;
+
+	if (y > priv->params.top_edge)
+		edge |=3D TOP_EDGE;
+	else if (y < priv->params.bottom_edge)
+		edge |=3D BOTTOM_EDGE;
+
+	return edge;
+}
+
+#define MOVE_HIST(a) ((priv->count_packet_finger-(a))%SYNAPTICS_MOVE_HISTO=
RY)
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
+	unsigned char *buf =3D priv->proto_buf;
+	hw->w =3D (((buf[0] & 0x30) >> 2) |
+		 ((buf[0] & 0x04) >> 1) |
+		 ((buf[3] & 0x04) >> 2));
+	hw->client =3D0;
+	if (SYN_CAP_EXTENDED(priv->capabilities) &&
+	    (SYN_CAP_CLIENT(priv->capabilities))) {
+	  if(hw->w =3D=3D 0x03)
+	    {
+	      printk(KERN_DEBUG "SYN client pkg.\n");
+	      hw->client=3D1;
+	    }
+	}
+	if (hw->client){
+	  if (buf[4])
+	    hw->x =3D (buf[1] & 0x10) ? buf[4]-256:buf[4];
+	  else
+	    hw->x =3D 0;
+	  if (buf[5])
+	    hw->y =3D -((buf[1] & 0x20) ? buf[5]-256:buf[5]);
+	  else
+	    hw->y =3D 0;
+	}
+
+	else {
+	  hw->x =3D (((buf[3] & 0x10) << 8) |
+		 ((buf[1] & 0x0f) << 8) |
+		 buf[4]);
+	  hw->y =3D (((buf[3] & 0x20) << 7) |
+		 ((buf[1] & 0xf0) << 4) |
+		 buf[5]);
+	}
+	hw->z =3D buf[2];
+=09
+	hw->left  =3D (buf[0] & 0x01) ? 1 : 0;
+	hw->right =3D (buf[0] & 0x2) ? 1 : 0;
+	hw->up    =3D 0;
+	hw->down  =3D 0;
+	if (SYN_CAP_EXTENDED(priv->capabilities) &&
+	    (SYN_CAP_FOUR_BUTTON(priv->capabilities))) {
+		hw->up =3D ((buf[3] & 0x01)) ? 1 : 0;
+		if (hw->left)
+			hw->up =3D !hw->up;
+		hw->down =3D ((buf[3] & 0x02)) ? 1 : 0;
+		if (hw->right)
+			hw->down =3D !hw->down;
+	}
+
+}
+
+static int synaptics_emulate_mid_button(struct synaptics_data *priv,
+					struct synaptics_hw_state *hw)
+{
+	int timeout =3D (DIFF_TIME(priv->count_packet, priv->count_button_delay) =
>=3D
+		       priv->params.emulate_mid_button_time);
+	int mid =3D 0;
+
+	for (;;) {
+		switch (priv->mid_emu_state) {
+		case MBE_OFF:
+			if (hw->left) {
+				priv->mid_emu_state =3D MBE_LEFT;
+			} else if (hw->right) {
+				priv->mid_emu_state =3D MBE_RIGHT;
+			} else {
+				priv->count_button_delay =3D priv->count_packet;
+				goto done;
+			}
+			break;
+		case MBE_LEFT:
+			if (!hw->left || timeout) {
+				hw->left =3D 1;
+				priv->mid_emu_state =3D MBE_OFF;
+				goto done;
+			} else if (hw->right) {
+				priv->mid_emu_state =3D MBE_MID;
+			} else {
+				hw->left =3D 0;
+				goto done;
+			}
+			break;
+		case MBE_RIGHT:
+			if (!hw->right || timeout) {
+				hw->right =3D 1;
+				priv->mid_emu_state =3D MBE_OFF;
+				goto done;
+			} else if (hw->left) {
+				priv->mid_emu_state =3D MBE_MID;
+			} else {
+				hw->right =3D 0;
+				goto done;
+			}
+			break;
+		case MBE_MID:
+			if (!hw->left && !hw->right) {
+				priv->mid_emu_state =3D MBE_OFF;
+			} else {
+				mid =3D 1;
+				hw->left =3D hw->right =3D 0;
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
+	const struct synaptics_parameters *para =3D &priv->params;
+	int finger;
+
+	/* finger detection thru pressure and threshold */
+	finger =3D (((hw->z > para->finger_high) && !priv->finger_flag) ||
+		  ((hw->z > para->finger_low)  &&  priv->finger_flag));
+
+	/* palm detection */
+	if (!SYN_CAP_EXTENDED(priv->capabilities) || !SYN_CAP_PALMDETECT(priv->ca=
pabilities))
+		return finger;
+
+	if (finger) {
+		if ((hw->z > 200) && (hw->w > 10))
+			priv->palm =3D 1;
+	} else {
+		priv->palm =3D 0;
+	}
+	if (hw->x =3D=3D 0)
+		priv->avg_w =3D 0;
+	else
+		priv->avg_w +=3D (hw->w - priv->avg_w + 1) / 2;
+	if (finger && !priv->finger_flag) {
+		int safe_w =3D max_t(int, hw->w, priv->avg_w);
+		if (hw->w < 2)
+			finger =3D 1;		/* more than one finger -> not a palm */
+		else if ((safe_w < 6) && (priv->prev_z < para->finger_high))
+			finger =3D 1;		/* thin finger, distinct touch -> not a palm */
+		else if ((safe_w < 7) && (priv->prev_z < para->finger_high / 2))
+			finger =3D 1;		/* thin finger, distinct touch -> not a palm */
+		else if (hw->z > priv->prev_z + 1)
+			finger =3D 0;		/* z not stable, may be a palm */
+		else if (hw->z < priv->prev_z - 5)
+			finger =3D 0;		/* z not stable, may be a palm */
+		else if (hw->z > 200)
+			finger =3D 0;		/* z too large -> probably palm */
+		else if (hw->w > 10)
+			finger =3D 0;		/* w too large -> probably palm */
+	}
+	priv->prev_z =3D hw->z;
+
+	return finger;
+}
+
+/*
+ *  called for each full received packet from the touchpad
+ */
+static void synaptics_process_packet(struct psmouse *psmouse)
+{
+	struct input_dev *dev =3D &psmouse->dev;
+	struct synaptics_data *priv =3D psmouse->private;
+	const struct synaptics_parameters *para =3D &priv->params;
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
+	edge =3D edge_detection(priv, hw.x, hw.y);
+
+	/*
+	 * client-mouse handling
+	 */
+=09
+=09
+	mid =3D synaptics_emulate_mid_button(priv, &hw);
+
+	/* Up/Down-button scrolling or middle/double-click */
+	double_click =3D 0;
+	if (!para->updown_button_scrolling) {
+		if (down) {
+			/* map down-button to middle-button */
+			mid =3D 1;
+		}
+
+		if (hw.up) {
+			/* up-button generates double-click */
+			if (!priv->prev_up)
+				double_click =3D 1;
+		}
+		priv->prev_up =3D hw.up;
+
+		/* reset up/down button events */
+		hw.up =3D hw.down =3D 0;
+	}
+
+	if(hw.client)
+	  finger=3D0;
+	else=20
+	  finger =3D synaptics_detect_finger(priv, &hw);
+=09=20=20=20=20=20=20=20
+	/* tap and drag detection */
+	if (priv->palm) {
+		/* Palm detected, skip tap/drag processing */
+	} else if (finger && !priv->finger_flag) {
+		/* touched */
+		if (priv->tap) {
+			priv->drag =3D 1; /* drag gesture */
+		}
+		priv->touch_on.x =3D hw.x;
+		priv->touch_on.y =3D hw.y;
+		priv->touch_on.packet =3D priv->count_packet;
+	} else if (!finger && priv->finger_flag) {
+		/* untouched */
+		/* check if
+		   1. the tap is in tap_time
+		   2. the max movement is in tap_move or more than one finger is tapped =
*/
+		if ((DIFF_TIME(priv->count_packet, priv->touch_on.packet) < para->tap_ti=
me) &&
+		    (((abs(hw.x - priv->touch_on.x) < para->tap_move) &&
+		      (abs(hw.y - priv->touch_on.y) < para->tap_move)) ||
+		     priv->finger_count)) {
+			if (priv->drag) {
+				priv->doubletap =3D 1;
+				priv->tap =3D 0;
+			} else {
+				priv->count_packet_tapping =3D priv->count_packet;
+				priv->tap =3D 1;
+				switch (priv->finger_count) {
+				case 0:
+					switch (edge) {
+					case RIGHT_TOP_EDGE:
+						priv->tap_mid =3D 1;
+						break;
+					case RIGHT_BOTTOM_EDGE:
+						priv->tap_right =3D 1;
+						break;
+					case LEFT_TOP_EDGE:
+						break;
+					case LEFT_BOTTOM_EDGE:
+						break;
+					default:
+						priv->tap_left =3D 1;
+					}
+					break;
+				case 2:
+					priv->tap_mid =3D 1;
+					break;
+				case 3:=20
+					priv->tap_right =3D 1;
+					break;
+				default:
+					priv->tap_left =3D 1;
+				}
+			}
+		}
+		priv->drag =3D 0;
+	}
+
+	/* detecting 2 and 3 fingers */
+	if (finger && /* finger is on the surface */
+	    (DIFF_TIME(priv->count_packet, priv->touch_on.packet) < para->tap_tim=
e) &&
+	    SYN_CAP_MULTIFINGER(priv->capabilities)) {
+		/* count fingers when reported */
+		if ((hw.w =3D=3D 0) && (priv->finger_count =3D=3D 0))
+			priv->finger_count =3D 2;
+		if (hw.w =3D=3D 1)
+			priv->finger_count =3D 3;
+	} else {
+		priv->finger_count =3D 0;
+	}
+
+	/* reset tapping button flags */
+	if (!priv->tap && !priv->drag && !priv->doubletap) {
+		priv->tap_left =3D priv->tap_mid =3D priv->tap_right =3D 0;
+	}
+
+	/* tap processing */
+	if (priv->tap &&
+	    (DIFF_TIME(priv->count_packet, priv->count_packet_tapping) < para->ta=
p_time)) {
+		hw.left  |=3D priv->tap_left;
+		mid      |=3D priv->tap_mid;
+		hw.right |=3D priv->tap_right;
+	} else {
+		priv->tap =3D 0;
+	}
+=09
+	/* drag processing */
+	if (priv->drag) {
+		hw.left  |=3D priv->tap_left;
+		mid      |=3D priv->tap_mid;
+		hw.right |=3D priv->tap_right;
+	}
+
+	/* double tap processing */
+	if (priv->doubletap && !priv->finger_flag) {
+		hw.left  |=3D priv->tap_left;
+		mid      |=3D priv->tap_mid;
+		hw.right |=3D priv->tap_right;
+		priv->doubletap =3D 0;
+	}
+
+	/* scroll detection */
+	if (finger && !priv->finger_flag) {
+		if (edge & RIGHT_EDGE) {
+			priv->vert_scroll_on =3D 1;
+			priv->scroll_y =3D hw.y;
+		}
+		if (edge & BOTTOM_EDGE) {
+			priv->horiz_scroll_on =3D 1;
+			priv->scroll_x =3D hw.x;
+		}
+	}
+	if (priv->vert_scroll_on && (!(edge & RIGHT_EDGE) || !finger || priv->pal=
m)) {
+		priv->vert_scroll_on =3D 0;
+	}
+	if (priv->horiz_scroll_on && (!(edge & BOTTOM_EDGE) || !finger || priv->p=
alm)) {
+		priv->horiz_scroll_on =3D 0;
+	}
+
+	/* scroll processing */
+	scroll_up =3D 0;
+	scroll_down =3D 0;
+	if (priv->vert_scroll_on) {
+		/* + =3D up, - =3D down */
+		while (hw.y - priv->scroll_y > para->scroll_dist_vert) {
+			scroll_up++;
+			priv->scroll_y +=3D para->scroll_dist_vert;
+		}
+		while (hw.y - priv->scroll_y < -para->scroll_dist_vert) {
+			scroll_down++;
+			priv->scroll_y -=3D para->scroll_dist_vert;
+		}
+	}
+	scroll_left =3D 0;
+	scroll_right =3D 0;
+	if (priv->horiz_scroll_on) {
+		/* + =3D right, - =3D left */
+		while (hw.x - priv->scroll_x > para->scroll_dist_horiz) {
+			scroll_right++;
+			priv->scroll_x +=3D para->scroll_dist_horiz;
+		}
+		while (hw.x - priv->scroll_x < -para->scroll_dist_horiz) {
+			scroll_left++;
+			priv->scroll_x -=3D para->scroll_dist_horiz;
+		}
+	}
+
+	/* client movement */
+	dx =3D dy =3D 0;
+	if (hw.client){
+	  dx=3Dhw.x;
+	  dy=3Dhw.y;
+	  priv->accum_dx +=3D dx * para->client_speed ;
+	  priv->accum_dy +=3D dy * para->client_speed ;
+=09=20=20
+	  dx =3D priv->accum_dx / 256;
+	  dy =3D priv->accum_dy / 256;
+=09=20=20
+	  priv->accum_dx -=3D dx * 256;
+	  priv->accum_dy -=3D dy * 256;
+	}
+
+	/* movement */
+	if (finger&& !priv->vert_scroll_on && !priv->horiz_scroll_on &&
+	    !priv->finger_count && !priv->palm) {
+		if (priv->count_packet_finger > 3) { /* min. 3 packets */
+			int h2x =3D priv->move_hist[MOVE_HIST(2)].x;
+			int h2y =3D priv->move_hist[MOVE_HIST(2)].y;
+
+			dx =3D  ((hw.x - h2x) / 2);
+			dy =3D -((hw.y - h2y) / 2);
+
+			if (priv->drag) {
+				if (edge & RIGHT_EDGE) {
+					dx +=3D clamp(para->edge_motion_speed - dx,
+						    0, para->edge_motion_speed);
+				} else if (edge & LEFT_EDGE) {
+					dx -=3D clamp(para->edge_motion_speed + dx,
+						    0, para->edge_motion_speed);
+				}
+				if (edge & TOP_EDGE) {
+					dy -=3D clamp(para->edge_motion_speed + dy,
+						    0, para->edge_motion_speed);
+				} else if (edge & BOTTOM_EDGE) {
+					dy +=3D clamp(para->edge_motion_speed - dy,
+						    0, para->edge_motion_speed);
+				}
+			}
+
+			/* Scale dx and dy to get pointer motion values */
+			priv->accum_dx +=3D dx * para->speed;
+			priv->accum_dy +=3D dy * para->speed;
+
+			dx =3D priv->accum_dx / 256;
+			dy =3D priv->accum_dy / 256;
+
+			priv->accum_dx -=3D dx * 256;
+			priv->accum_dy -=3D dy * 256;
+		}
+
+		priv->count_packet_finger++;
+	} else {
+		priv->count_packet_finger =3D 0;
+	}
+
+	priv->count_packet++;
+
+	/* Flags */
+	priv->finger_flag =3D finger;
+
+	/* generate a history of the absolute positions */
+	if(!hw.client){
+	  priv->move_hist[MOVE_HIST(0)].x =3D hw.x;
+	  priv->move_hist[MOVE_HIST(0)].y =3D hw.y;
+	}
+	/* repeat timer for up/down buttons */
+	/* when you press a button the packets will only send for a second, so
+	   we have to use a timer for repeating */
+	if ((hw.up || hw.down) && para->updown_button_scrolling) {
+		if (!atomic_read(&priv->timer_active)) {
+			priv->repeat_buttons =3D ((hw.up    ? 0x01 : 0) |
+						(hw.down  ? 0x02 : 0));
+			atomic_set(&priv->timer_active, 1);
+			mod_timer(&priv->timer, jiffies + 200 * HZ / 1000);
+		}
+	} else if (atomic_read(&priv->timer_active)) {
+		atomic_set(&priv->timer_active, 0);
+		priv->repeat_buttons =3D 0;
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
+	priv->last_up =3D hw.up;
+	priv->last_down =3D hw.down;
+
+	input_report_rel(dev, REL_WHEEL, scroll_up - scroll_down);
+	input_report_rel(dev, REL_HWHEEL, scroll_right - scroll_left);
+
+	if (double_click) {
+		int i;
+		for (i =3D 0; i < 2; i++) {
+			input_report_key(dev, BTN_LEFT, !hw.left);
+			input_report_key(dev, BTN_LEFT, hw.left);
+		}
+	}
+
+	input_sync(dev);
+}
+
+static void synaptics_process_byte(struct psmouse *psmouse, struct pt_regs=
 *regs)
+{
+	struct input_dev *dev =3D &psmouse->dev;
+	struct synaptics_data *priv =3D psmouse->private;
+	unsigned char *pBuf =3D priv->proto_buf;
+	unsigned char u =3D psmouse->packet[0];
+
+	input_regs(dev, regs);
+
+	pBuf[priv->proto_buf_tail++] =3D u;
+
+	/* check first byte */
+	if ((priv->proto_buf_tail =3D=3D 1) && ((u & 0xC8) !=3D 0x80)) {
+		priv->inSync =3D 0;
+		priv->proto_buf_tail =3D 0;
+		printk(KERN_WARNING "Synaptics driver lost sync at 1st byte\n");
+		return;
+	}
+
+	/* check 4th byte */
+	if ((priv->proto_buf_tail =3D=3D 4) && ((u & 0xc8) !=3D 0xc0)) {
+		priv->inSync =3D 0;
+		priv->proto_buf_tail =3D 0;
+		printk(KERN_WARNING "Synaptics driver lost sync at 4th byte\n");
+		return;
+	}
+
+	if (priv->proto_buf_tail >=3D 6) { /* Full packet received */
+		if (!priv->inSync) {
+			priv->inSync =3D 1;
+			printk(KERN_NOTICE "Synaptics driver resynced.\n");
+		}
+		synaptics_process_packet(psmouse);
+		priv->proto_buf_tail =3D 0;
+	}
+}
+
+#endif /* CONFIG_MOUSE_PS2_SYNAPTICS */

--=-=-=
Content-Type: text/x-patch; charset=iso-8859-1
Content-Disposition: attachment;
  filename=synaptics-client-incremental.patch
Content-Transfer-Encoding: quoted-printable

Index: linux/drivers/input/mouse/synaptics.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux/drivers/input/mouse/synaptics.h	(revision 5)
+++ linux/drivers/input/mouse/synaptics.h	(revision 10)
@@ -37,6 +37,7 @@
=20
 /* synaptics capability bits */
 #define SYN_CAP_EXTENDED(c)		((c) & (1 << 23))
+#define SYN_CAP_CLIENT(c)               ((c) & (1 << 7))
 #define SYN_CAP_SLEEP(c)		((c) & (1 << 4))
 #define SYN_CAP_FOUR_BUTTON(c)		((c) & (1 << 3))
 #define SYN_CAP_MULTIFINGER(c)		((c) & (1 << 1))
@@ -57,7 +58,9 @@
 #define SYN_ID_MINOR(i) 		(((i) >> 16) & 0xff)
 #define SYN_ID_IS_SYNAPTICS(i)		((((i) >> 8) & 0xff) =3D=3D 0x47)
=20
+/* client commands*/
=20
+
 struct synaptics_parameters {
 	int left_edge;				/* Edge coordinates, absolute */
 	int right_edge;
@@ -71,6 +74,7 @@
 	int scroll_dist_vert;			/* Scrolling distance in absolute coordinates */
 	int scroll_dist_horiz;			/* Scrolling distance in absolute coordinates */
 	int speed;				/* Pointer motion speed */
+	int client_speed;				/* Client Pointer motion speed */
 	int edge_motion_speed;			/* Edge motion speed when dragging */
 	int updown_button_scrolling;		/* Up/Down-Button scrolling or middle/doubl=
e-click */
 };
@@ -87,6 +91,7 @@
 	int right;
 	int up;
 	int down;
+        int client;
 };
=20
 #define SYNAPTICS_MOVE_HISTORY	5
Index: linux/drivers/input/mouse/synaptics.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux/drivers/input/mouse/synaptics.c	(revision 5)
+++ linux/drivers/input/mouse/synaptics.c	(revision 10)
@@ -20,6 +20,9 @@
  *   Copyright (c) 1998-2000 Bruce Kalk <kall@compass.com>
  *     code for the special synaptics commands (from the tpconfig-source)
  *
+ *   2003 Arne K=F6wing <Arne.Koewing@informatik.uni-oldenburg.de>
+ *     Code for Synaptics client/passthrough  (from gpm source)
+ *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License version 2 as publishe=
d by
  * the Free Software Foundation.
@@ -62,6 +65,7 @@
 	return 0;
 }
=20
+
 /*
  * Send a command to the synpatics touchpad by special commands
  */
@@ -74,6 +78,85 @@
 	return 0;
 }
=20
+static int synaptics_client_sendbyte(struct psmouse *psmouse, unsigned cha=
r c)
+{
+  unsigned char param[4];
+  synaptics_special_cmd(psmouse, c);
+  param[0]=3D40;
+  if (psmouse_command(psmouse, param, PSMOUSE_CMD_SETRATE))
+    return -1;
+  return 0;
+}
+
+static int synaptics_client_command(struct psmouse *psmouse, unsigned char=
 *param, int command)
+{
+  int timeout =3D 500000; /* 500 msec */
+  int send =3D (command >> 12) & 0xf;
+  int receive =3D (command >> 8) & 0xf;
+  int i;
+=20=20
+  psmouse->cmdcnt =3D receive;
+=20=20
+	if (command =3D=3D PSMOUSE_CMD_RESET_BAT)
+                timeout =3D 2000000; /* 2 sec */
+
+	if (command & 0xff)
+		if (synaptics_client_sendbyte(psmouse, command & 0xff))
+			return (psmouse->cmdcnt =3D 0) - 1;
+
+	for (i =3D 0; i < send; i++)
+		if (synaptics_client_sendbyte(psmouse, param[i]))
+			return (psmouse->cmdcnt =3D 0) - 1;
+
+	while (psmouse->cmdcnt && timeout--) {
+=09
+		if (psmouse->cmdcnt =3D=3D 1 && command =3D=3D PSMOUSE_CMD_RESET_BAT)
+			timeout =3D 100000;
+
+		if (psmouse->cmdcnt =3D=3D 1 && command =3D=3D PSMOUSE_CMD_GETID &&
+		    psmouse->cmdbuf[1] !=3D 0xab && psmouse->cmdbuf[1] !=3D 0xac) {
+			psmouse->cmdcnt =3D 0;
+			break;
+		}
+
+		udelay(1);
+	}
+
+	for (i =3D 0; i < receive; i++)
+		param[i] =3D psmouse->cmdbuf[(receive - 1) - i];
+
+	if (psmouse->cmdcnt)=20
+		return (psmouse->cmdcnt =3D 0) - 1;
+
+	return 0;
+}
+
+/*
+static int synaptics_client_special_cmd(struct psmouse *psmouse, unsigned =
char command)
+{
+	int i;
+
+	if (synaptics_client_command(psmouse,NULL,PSMOUSE_CMD_SETSCALE11))
+		return -1;
+
+	for (i =3D 6; i >=3D 0; i -=3D 2) {
+		unsigned char d =3D (command >> i) & 3;
+		if (synaptics_client_command(psmouse,&d, PSMOUSE_CMD_SETRES))
+			return -1;
+	}
+	return 0;
+}
+*/
+static int synaptics_client_reset(struct psmouse *psmouse)
+{
+  unsigned char param[2];
+  if(synaptics_client_command(psmouse,param,PSMOUSE_CMD_RESET_BAT))
+    return -1;
+  if (param[0] =3D=3D 0xAA && param[1] =3D=3D 0x00)
+    return 0;
+  return -1;
+}
+=20
 /*************************************************************************=
****
  *	Synaptics communications functions
  *************************************************************************=
***/
@@ -104,6 +187,7 @@
 	return -1;
 }
=20
+
 /*
  * Read the model-id bytes from the touchpad
  * see also SYN_MODEL_* macros
@@ -152,9 +236,17 @@
=20
 static int synaptics_enable_device(struct psmouse *psmouse)
 {
-	if (psmouse_command(psmouse, NULL, PSMOUSE_CMD_ENABLE))
-		return -1;
-	return 0;
+  struct synaptics_data *priv =3D psmouse->private;=20=20
+  if (SYN_CAP_CLIENT(priv->capabilities))
+    {
+      if(synaptics_client_reset(psmouse))
+	return -1;
+      if(synaptics_client_command(psmouse,NULL,PSMOUSE_CMD_ENABLE))
+	 return -1;
+    }
+  if (psmouse_command(psmouse, NULL, PSMOUSE_CMD_ENABLE))
+    return -1;
+  return 0;
 }
=20
 static void print_ident(struct synaptics_data *priv)
@@ -181,6 +273,8 @@
 			printk(KERN_INFO " -> multifinger detection\n");
 		if (SYN_CAP_PALMDETECT(priv->capabilities))
 			printk(KERN_INFO " -> palm detection\n");
+		if (SYN_CAP_CLIENT(priv->capabilities))
+			printk(KERN_INFO " -> client detection\n");
 	}
 }
=20
@@ -240,6 +334,7 @@
 	.scroll_dist_vert		=3D 100,
 	.scroll_dist_horiz		=3D 100,
 	.speed				=3D 25,
+	.client_speed			=3D 200,
 	.edge_motion_speed		=3D 40,
 	.updown_button_scrolling	=3D 1
 };
@@ -340,24 +435,43 @@
 				     struct synaptics_hw_state *hw)
 {
 	unsigned char *buf =3D priv->proto_buf;
+	hw->w =3D (((buf[0] & 0x30) >> 2) |
+		 ((buf[0] & 0x04) >> 1) |
+		 ((buf[3] & 0x04) >> 2));
+	hw->client =3D0;
+	if (SYN_CAP_EXTENDED(priv->capabilities) &&
+	    (SYN_CAP_CLIENT(priv->capabilities))) {
+	  if(hw->w =3D=3D 0x03)
+	    {
+	      printk(KERN_DEBUG "SYN client pkg.\n");
+	      hw->client=3D1;
+	    }
+	}
+	if (hw->client){
+	  if (buf[4])
+	    hw->x =3D (buf[1] & 0x10) ? buf[4]-256:buf[4];
+	  else
+	    hw->x =3D 0;
+	  if (buf[5])
+	    hw->y =3D -((buf[1] & 0x20) ? buf[5]-256:buf[5]);
+	  else
+	    hw->y =3D 0;
+	}
=20
-	hw->x =3D (((buf[3] & 0x10) << 8) |
+	else {
+	  hw->x =3D (((buf[3] & 0x10) << 8) |
 		 ((buf[1] & 0x0f) << 8) |
 		 buf[4]);
-	hw->y =3D (((buf[3] & 0x20) << 7) |
+	  hw->y =3D (((buf[3] & 0x20) << 7) |
 		 ((buf[1] & 0xf0) << 4) |
 		 buf[5]);
-
+	}
 	hw->z =3D buf[2];
-	hw->w =3D (((buf[0] & 0x30) >> 2) |
-		 ((buf[0] & 0x04) >> 1) |
-		 ((buf[3] & 0x04) >> 2));
-
+=09
 	hw->left  =3D (buf[0] & 0x01) ? 1 : 0;
 	hw->right =3D (buf[0] & 0x2) ? 1 : 0;
 	hw->up    =3D 0;
 	hw->down  =3D 0;
-
 	if (SYN_CAP_EXTENDED(priv->capabilities) &&
 	    (SYN_CAP_FOUR_BUTTON(priv->capabilities))) {
 		hw->up =3D ((buf[3] & 0x01)) ? 1 : 0;
@@ -367,6 +481,7 @@
 		if (hw->right)
 			hw->down =3D !hw->down;
 	}
+
 }
=20
 static int synaptics_emulate_mid_button(struct synaptics_data *priv,
@@ -494,6 +609,11 @@
=20
 	edge =3D edge_detection(priv, hw.x, hw.y);
=20
+	/*
+	 * client-mouse handling
+	 */
+=09
+=09
 	mid =3D synaptics_emulate_mid_button(priv, &hw);
=20
 	/* Up/Down-button scrolling or middle/double-click */
@@ -515,8 +635,11 @@
 		hw.up =3D hw.down =3D 0;
 	}
=20
-	finger =3D synaptics_detect_finger(priv, &hw);
-
+	if(hw.client)
+	  finger=3D0;
+	else=20
+	  finger =3D synaptics_detect_finger(priv, &hw);
+=09=20=20=20=20=20=20=20
 	/* tap and drag detection */
 	if (priv->palm) {
 		/* Palm detected, skip tap/drag processing */
@@ -601,7 +724,7 @@
 	} else {
 		priv->tap =3D 0;
 	}
-
+=09
 	/* drag processing */
 	if (priv->drag) {
 		hw.left  |=3D priv->tap_left;
@@ -663,9 +786,23 @@
 		}
 	}
=20
+	/* client movement */
+	dx =3D dy =3D 0;
+	if (hw.client){
+	  dx=3Dhw.x;
+	  dy=3Dhw.y;
+	  priv->accum_dx +=3D dx * para->client_speed ;
+	  priv->accum_dy +=3D dy * para->client_speed ;
+=09=20=20
+	  dx =3D priv->accum_dx / 256;
+	  dy =3D priv->accum_dy / 256;
+=09=20=20
+	  priv->accum_dx -=3D dx * 256;
+	  priv->accum_dy -=3D dy * 256;
+	}
+
 	/* movement */
-	dx =3D dy =3D 0;
-	if (finger && !priv->vert_scroll_on && !priv->horiz_scroll_on &&
+	if (finger&& !priv->vert_scroll_on && !priv->horiz_scroll_on &&
 	    !priv->finger_count && !priv->palm) {
 		if (priv->count_packet_finger > 3) { /* min. 3 packets */
 			int h2x =3D priv->move_hist[MOVE_HIST(2)].x;
@@ -713,9 +850,10 @@
 	priv->finger_flag =3D finger;
=20
 	/* generate a history of the absolute positions */
-	priv->move_hist[MOVE_HIST(0)].x =3D hw.x;
-	priv->move_hist[MOVE_HIST(0)].y =3D hw.y;
-
+	if(!hw.client){
+	  priv->move_hist[MOVE_HIST(0)].x =3D hw.x;
+	  priv->move_hist[MOVE_HIST(0)].y =3D hw.y;
+	}
 	/* repeat timer for up/down buttons */
 	/* when you press a button the packets will only send for a second, so
 	   we have to use a timer for repeating */

--=-=-=



> Have you tested with Arne Koewing <ark@gmx.net>'s synaptics_reset patch:
>
> diff -Nru a/drivers/input/mouse/psmouse.c b/drivers/input/mouse/psmouse.c
> --- a/drivers/input/mouse/psmouse.c     Thu Jun 12 04:26:48 2003
> +++ b/drivers/input/mouse/psmouse.c     Thu Jun 12 04:26:48 2003
> @@ -345,6 +345,7 @@
>                    thing up. */
>                 psmouse->vendor = "Synaptics";
>                 psmouse->name = "TouchPad";
> +              psmouse_command(psmouse, param, PSMOUSE_CMD_RESET_BAT);
>                 return PSMOUSE_PS2;
>         }
>
>
> w/o that patch, using 2.5 on a dell laptop disables the track point
> until something else causes a rest on the ps/2 bus, such as hot-
> plugging an external ps2 mouse or suspending and resuming the box.
>
> For that matter, does running the touchpad in absolute mode affect
> the track point at all?
>
> (I'm primarily just interested in stopping the unintended mouse button
> events I get from the pad's default config....)
>
> -JimC
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=-=-=--
