Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263612AbUDVG47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263612AbUDVG47 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 02:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263632AbUDVG47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 02:56:59 -0400
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:27254 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263612AbUDVG4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 02:56:45 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 17/15] New set of input patches: serio open/close optional
Date: Thu, 22 Apr 2004 01:56:40 -0500
User-Agent: KMail/1.6.1
Cc: Vojtech Pavlik <vojtech@suse.cz>
References: <200404210049.17139.dtor_core@ameritech.net>
In-Reply-To: <200404210049.17139.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404220156.42083.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1928, 2004-04-22 01:55:04-05:00, dtor_core@ameritech.net
  Input: make open and close serio methods optional


 mouse/lbtouch.c   |  203 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 mouse/lbtouch.h   |   16 ++++
 mouse/synaptics.c |   11 --
 serio/parkbd.c    |   11 --
 serio/q40kbd.c    |   11 --
 serio/serio.c     |    5 -
 serio/serport.c   |   10 --
 7 files changed, 224 insertions(+), 43 deletions(-)


===================================================================



diff -Nru a/drivers/input/mouse/lbtouch.c b/drivers/input/mouse/lbtouch.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/input/mouse/lbtouch.c	Thu Apr 22 01:55:34 2004
@@ -0,0 +1,203 @@
+/*
+ *  Copyright (c) 2004 Dmitry Torokhov <dtor@mail.ru>
+ */
+
+/*
+ * Lifebook touchscreen driver for Linux
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/input.h>
+#include <linux/serio.h>
+
+#include "psmouse.h"
+#include "lbtouch.h"
+
+MODULE_AUTHOR("Dmitry Torokhov <dtor@mail.ru>");
+MODULE_DESCRIPTION("Fujitsu Lifebook touchscreen driver");
+MODULE_LICENSE("GPL");
+
+/* The default values are taken from Kenan Esau's driver */
+static int limits[4] = { 86, 955, 37, 937 };
+static int num_limits __initdata = 0;
+module_param_array_named(lbt_size, limits, int, num_limits, 0);
+MODULE_PARM_DESC(lbt_size, "Effective usable area of Lifebook touchscreen (left,right,bottom,up)");
+
+
+/*****************************************************************************
+ *	Lifebook pass-through PS/2 port support
+ ****************************************************************************/
+static int lbtouch_pt_write(struct serio *port, unsigned char c)
+{
+	switch (c) {
+		case PSMOUSE_CMD_RESET_BAT & 0xff:
+			serio_interrupt(port, PSMOUSE_RET_ACK, 0, NULL);
+			serio_interrupt(port, PSMOUSE_RET_BAT, 0, NULL);
+			serio_interrupt(port, PSMOUSE_RET_ID, 0, NULL);
+			break;
+
+		case PSMOUSE_CMD_GETID & 0xff:
+			serio_interrupt(port, PSMOUSE_RET_ACK, 0, NULL);
+			serio_interrupt(port, 0x00, 0, NULL);
+			break;
+
+		case PSMOUSE_CMD_ENABLE & 0xff:
+		case PSMOUSE_CMD_RESET_DIS & 0xff:
+			serio_interrupt(port, PSMOUSE_RET_ACK, 0, NULL);
+			break;
+
+		default:
+			serio_interrupt(port, PSMOUSE_RET_NAK, 0, NULL);
+			break;
+	}
+
+	return 0;
+}
+
+static void lbtouch_pass_pt_packet(struct serio *ptport, unsigned char *packet)
+{
+	struct psmouse *child = ptport->private;
+
+	if (child && child->state == PSMOUSE_ACTIVATED) {
+		serio_interrupt(ptport, packet[0], 0, NULL);
+		serio_interrupt(ptport, packet[1], 0, NULL);
+		serio_interrupt(ptport, packet[2], 0, NULL);
+	}
+}
+
+static void lbtouch_pt_create(struct psmouse *psmouse)
+{
+	struct psmouse_ptport *port;
+
+	psmouse->ptport = port = kmalloc(sizeof(struct psmouse_ptport), GFP_KERNEL);
+	if (!port) {
+		printk(KERN_ERR "lbtouch: not enough memory to allocate pass-through port\n");
+		return;
+	}
+
+	memset(port, 0, sizeof(struct psmouse_ptport));
+
+	port->serio.type = SERIO_PS_PSTHRU;
+	port->serio.name = "Lifebook pass-through";
+	port->serio.phys = "lbtouch-pt/serio0";
+	port->serio.write = lbtouch_pt_write;
+	port->serio.driver = psmouse;
+}
+
+/*****************************************************************************
+ *	Functions to interpret the absolute mode packets
+ ****************************************************************************/
+
+static psmouse_ret_t lbtouch_process_byte(struct psmouse *psmouse, struct pt_regs *regs)
+{
+	struct input_dev *dev = &psmouse->dev;
+	unsigned char *p = psmouse->packet;
+	int x, y, touch;
+
+	input_regs(dev, regs);
+
+	if (psmouse->pktcnt < 3)
+		return PSMOUSE_GOOD_DATA;
+
+	if (p[0] & 0x80) {
+	        x = ((unsigned int)(p[0] & 0x30) << 4) + p[1];
+        	y = ((unsigned int)(p[0] & 0xc0) << 2) + p[2];
+		touch = p[0] & 0x04 ? 1 : 0;
+
+		input_report_key(dev, BTN_TOUCH, touch);
+		if (touch) {
+			input_report_abs(dev, ABS_X, x - limits[0]);
+			input_report_abs(dev, ABS_Y, limits[3] + limits[3] - y);
+		}
+
+		if ((p[0] &= 0x03) != 0 && psmouse->ptport && psmouse->ptport->serio.dev) {
+			p[1] = p[2] = 0;
+			lbtouch_pass_pt_packet(&psmouse->ptport->serio, p);
+		}
+	} else if (psmouse->ptport && psmouse->ptport->serio.dev) {
+		lbtouch_pass_pt_packet(&psmouse->ptport->serio, p);
+	}
+
+	return PSMOUSE_FULL_PACKET;
+}
+
+/*****************************************************************************
+ *	Driver initialization/cleanup functions
+ ****************************************************************************/
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
+static void lbtouch_disconnect(struct psmouse *psmouse)
+{
+	unsigned char param[1];
+
+	param[0] = 0x06;
+
+	if (psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES) ||
+	    psmouse_command(psmouse, NULL, PSMOUSE_CMD_ENABLE) ||
+	    psmouse_command(psmouse, NULL, PSMOUSE_CMD_ENABLE) ||
+	    psmouse_command(psmouse, NULL, PSMOUSE_CMD_ENABLE))
+		printk(KERN_WARNING "lbtouch.c: Failed to restore touchscreen PS/2 emulation\n");
+}
+
+int lbtouch_init(struct psmouse *psmouse, int set_properties)
+{
+	unsigned char param[1];
+
+	if (psmouse->serio->type != SERIO_8042)
+		return 0;
+
+	param[0] = 0x07;
+	if (psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES) ||
+	    psmouse_command(psmouse, NULL, PSMOUSE_CMD_ENABLE) ||
+	    psmouse_command(psmouse, NULL, PSMOUSE_CMD_ENABLE) ||
+	    psmouse_command(psmouse, NULL, PSMOUSE_CMD_ENABLE)) {
+		printk(KERN_ERR "lbtouch.c: Failed to enable touchscreen native mode\n");
+		return 0;
+	}
+
+	if (set_properties) {
+		set_bit(EV_ABS, psmouse->dev.evbit);
+		set_abs_params(&psmouse->dev, ABS_X, limits[0], limits[1], 0, 0);
+		set_abs_params(&psmouse->dev, ABS_Y, limits[2], limits[3], 0, 0);
+
+		set_bit(EV_KEY, psmouse->dev.evbit);
+		set_bit(BTN_TOUCH, psmouse->dev.keybit);
+
+		clear_bit(EV_REL, psmouse->dev.evbit);
+		clear_bit(REL_X, psmouse->dev.relbit);
+		clear_bit(REL_Y, psmouse->dev.relbit);
+
+		psmouse->protocol_handler = lbtouch_process_byte;
+		psmouse->disconnect = lbtouch_disconnect;
+
+		lbtouch_pt_create(psmouse);
+	}
+
+	return 1;
+}
diff -Nru a/drivers/input/mouse/lbtouch.h b/drivers/input/mouse/lbtouch.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/input/mouse/lbtouch.h	Thu Apr 22 01:55:34 2004
@@ -0,0 +1,16 @@
+/*
+ * Fujistsu Lifebook PS/2 touchscreen driver header
+ *
+ * Copyright (c) 2004 Dmitry Torokhov <dtor@mail.ru>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#ifndef _LBTOUCH_H
+#define _LBTOUCH_H
+
+int lbtouch_init(struct psmouse *psmouse, int set_properties);
+
+#endif
diff -Nru a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
--- a/drivers/input/mouse/synaptics.c	Thu Apr 22 01:55:34 2004
+++ b/drivers/input/mouse/synaptics.c	Thu Apr 22 01:55:34 2004
@@ -212,15 +212,6 @@
 /*****************************************************************************
  *	Synaptics pass-through PS/2 port support
  ****************************************************************************/
-static int synaptics_pt_open(struct serio *port)
-{
-	return 0;
-}
-
-static void synaptics_pt_close(struct serio *port)
-{
-}
-
 static int synaptics_pt_write(struct serio *port, unsigned char c)
 {
 	struct psmouse *parent = port->driver;
@@ -282,8 +273,6 @@
 	port->serio.name = "Synaptics pass-through";
 	port->serio.phys = "synaptics-pt/serio0";
 	port->serio.write = synaptics_pt_write;
-	port->serio.open = synaptics_pt_open;
-	port->serio.close = synaptics_pt_close;
 	port->serio.driver = psmouse;
 
 	port->activate = synaptics_pt_activate;
diff -Nru a/drivers/input/serio/parkbd.c b/drivers/input/serio/parkbd.c
--- a/drivers/input/serio/parkbd.c	Thu Apr 22 01:55:34 2004
+++ b/drivers/input/serio/parkbd.c	Thu Apr 22 01:55:34 2004
@@ -86,20 +86,9 @@
 	return 0;
 }
 
-static int parkbd_open(struct serio *port)
-{
-	return 0;
-}
-
-static void parkbd_close(struct serio *port)
-{
-}
-
 static struct serio parkbd_port =
 {
 	.write	= parkbd_write,
-	.open	= parkbd_open,
-	.close	= parkbd_close,
 	.name	= parkbd_name,
 	.phys	= parkbd_phys,
 };
diff -Nru a/drivers/input/serio/q40kbd.c b/drivers/input/serio/q40kbd.c
--- a/drivers/input/serio/q40kbd.c	Thu Apr 22 01:55:34 2004
+++ b/drivers/input/serio/q40kbd.c	Thu Apr 22 01:55:34 2004
@@ -47,23 +47,12 @@
 MODULE_DESCRIPTION("Q40 PS/2 keyboard controller driver");
 MODULE_LICENSE("GPL");
 
-
-static int q40kbd_open(struct serio *port)
-{
-	return 0;
-}
-static void q40kbd_close(struct serio *port)
-{
-}
-
 static struct serio q40kbd_port =
 {
 	.type	= SERIO_8042,
 	.name	= "Q40 kbd port",
 	.phys	= "Q40",
 	.write	= NULL,
-	.open	= q40kbd_open,
-	.close	= q40kbd_close,
 };
 
 static irqreturn_t q40kbd_interrupt(int irq, void *dev_id,
diff -Nru a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
--- a/drivers/input/serio/serio.c	Thu Apr 22 01:55:34 2004
+++ b/drivers/input/serio/serio.c	Thu Apr 22 01:55:34 2004
@@ -293,7 +293,7 @@
 int serio_open(struct serio *serio, struct serio_dev *dev)
 {
 	serio->dev = dev;
-	if (serio->open(serio)) {
+	if (serio->open && serio->open(serio)) {
 		serio->dev = NULL;
 		return -1;
 	}
@@ -303,7 +303,8 @@
 /* called from serio_dev->connect/disconnect methods under serio_sem */
 void serio_close(struct serio *serio)
 {
-	serio->close(serio);
+	if (serio->close)
+		serio->close(serio);
 	serio->dev = NULL;
 }
 
diff -Nru a/drivers/input/serio/serport.c b/drivers/input/serio/serport.c
--- a/drivers/input/serio/serport.c	Thu Apr 22 01:55:34 2004
+++ b/drivers/input/serio/serport.c	Thu Apr 22 01:55:34 2004
@@ -48,11 +48,6 @@
 	return -(serport->tty->driver->write(serport->tty, 0, &data, 1) != 1);
 }
 
-static int serport_serio_open(struct serio *serio)
-{
-        return 0;
-}
-
 static void serport_serio_close(struct serio *serio)
 {
 	struct serport *serport = serio->driver;
@@ -87,7 +82,6 @@
 
 	serport->serio.type = SERIO_RS232;
 	serport->serio.write = serport_serio_write;
-	serport->serio.open = serport_serio_open;
 	serport->serio.close = serport_serio_close;
 	serport->serio.driver = serport;
 
@@ -135,7 +129,7 @@
 }
 
 /*
- * serport_ldisc_read() just waits indefinitely if everything goes well. 
+ * serport_ldisc_read() just waits indefinitely if everything goes well.
  * However, when the serio driver closes the serio port, it finishes,
  * returning 0 characters.
  */
@@ -165,7 +159,7 @@
 static int serport_ldisc_ioctl(struct tty_struct * tty, struct file * file, unsigned int cmd, unsigned long arg)
 {
 	struct serport *serport = (struct serport*) tty->disc_data;
-	
+
 	if (cmd == SPIOCSTYPE)
 		return get_user(serport->serio.type, (unsigned long *) arg);
 
