Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263544AbUDVGjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263544AbUDVGjW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 02:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263565AbUDVGjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 02:39:22 -0400
Received: from smtp811.mail.sc5.yahoo.com ([66.163.170.81]:35205 "HELO
	smtp811.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263544AbUDVGjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 02:39:06 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Subject: Re: /dev/psaux-Interface
Date: Thu, 22 Apr 2004 01:39:00 -0500
User-Agent: KMail/1.6.1
Cc: Kim Holviala <kim@holviala.com>, linux-kernel@vger.kernel.org,
       Tuukka Toivonen <tuukkat@ee.oulu.fi>
References: <Pine.GSO.4.58.0402271451420.11281@stekt37> <200404210151.06636.dtor_core@ameritech.net> <xb7smexg5sm.fsf@savona.informatik.uni-freiburg.de>
In-Reply-To: <xb7smexg5sm.fsf@savona.informatik.uni-freiburg.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404220139.02775.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 21 April 2004 02:15 am, Sau Dan Lee wrote:
> >>>>> "Dmitry" == Dmitry Torokhov <dtor_core@ameritech.net> writes:
> 
> 
>     >> Adding the complexity of various devices and protocols into
>     >> kernelspace is insane.
> 
>     Dmitry> The thing is that processing in kernel space is not that
>     Dmitry> complex.
> 
> Even so,  it's not easy to  get it right.  In  kernel programming, you
> have to take  care of many issues, such as whether  you have a process
> context, when to  use spinlock, wait queues, etc.  I  even had to care
> about fasync() when developing the psaux module, even though it's just
> copying a few lines of sample code from the kernel hacking guide.
>

OK, here you go. It is the first cut. The driver creates an absolute device
for the touchscreen and a fake pass-through port to for the pointing device
which works in relative mode. All fancy stuff can be done in userspace via
evdev.
 
Hopefully I got Y-axis direction correctly and init sequence may need some
work. It also hijacks proto=imsp parameter until I merge Kim's protocol
selection changes. I wish I could test it but I do not have a Lifebook so
comments and suggestions are welcome.

Apply on top of patches in:
http://www.geocities.com/dt_or/input/2.6.6-rc2/

-- 
Dmitry

===== drivers/input/mouse/Makefile 1.9 vs edited =====
--- 1.9/drivers/input/mouse/Makefile	Wed Mar  3 11:17:04 2004
+++ edited/drivers/input/mouse/Makefile	Thu Apr 22 00:20:31 2004
@@ -15,4 +15,4 @@
 obj-$(CONFIG_MOUSE_SERIAL)	+= sermouse.o
 obj-$(CONFIG_MOUSE_VSXXXAA)	+= vsxxxaa.o
 
-psmouse-objs  := psmouse-base.o logips2pp.o synaptics.o
+psmouse-objs  := psmouse-base.o lbtouch.o logips2pp.o synaptics.o
===== drivers/input/mouse/psmouse-base.c 1.57 vs edited =====
--- 1.57/drivers/input/mouse/psmouse-base.c	Tue Apr 20 23:59:36 2004
+++ edited/drivers/input/mouse/psmouse-base.c	Thu Apr 22 00:59:31 2004
@@ -21,6 +21,7 @@
 #include "psmouse.h"
 #include "synaptics.h"
 #include "logips2pp.h"
+#include "lbtouch.h"
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
 MODULE_DESCRIPTION("PS/2 mouse driver");
@@ -53,7 +54,7 @@
 __obsolete_setup("psmouse_resetafter=");
 __obsolete_setup("psmouse_rate=");
 
-static char *psmouse_protocols[] = { "None", "PS/2", "PS2++", "PS2T++", "GenPS/2", "ImPS/2", "ImExPS/2", "SynPS/2"};
+static char *psmouse_protocols[] = { "None", "PS/2", "PS2++", "PS2T++", "GenPS/2", "ImPS/2", "ImExPS/2", "SynPS/2", "LBPS/2" };
 
 /*
  * psmouse_process_byte() analyzes the PS/2 data stream and reports
@@ -414,6 +415,15 @@
 			      unsigned int max_proto, int set_properties)
 {
 	int synaptics_hardware = 0;
+
+	if (max_proto == PSMOUSE_IMEX && lbtouch_init(psmouse, set_properties)) {
+		if (set_properties) {
+			psmouse->vendor = "Fujitsu";
+			psmouse->name = "Lifebook Touchscreen";
+		}
+
+		return PSMOUSE_LBTOUCH;
+	}
 
 /*
  * Try Synaptics TouchPad
===== drivers/input/mouse/psmouse.h 1.10 vs edited =====
--- 1.10/drivers/input/mouse/psmouse.h	Tue Apr 20 17:42:10 2004
+++ edited/drivers/input/mouse/psmouse.h	Thu Apr 22 00:14:52 2004
@@ -72,6 +72,7 @@
 #define PSMOUSE_IMPS		5
 #define PSMOUSE_IMEX		6
 #define PSMOUSE_SYNAPTICS 	7
+#define PSMOUSE_LBTOUCH 	8
 
 int psmouse_command(struct psmouse *psmouse, unsigned char *param, int command);
 int psmouse_sliced_command(struct psmouse *psmouse, unsigned char command);
===== drivers/input/mouse/lbtouch.c 1.0 vs 1.1 =====
--- /dev/null	Fri Aug 30 18:31:37 2002
+++ 1.1/drivers/input/mouse/lbtouch.c	Thu Apr 22 01:21:26 2004
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
===== drivers/input/mouse/lbtouch.h 1.0 vs 1.1 =====
--- /dev/null	Fri Aug 30 18:31:37 2002
+++ 1.1/drivers/input/mouse/lbtouch.h	Thu Apr 22 01:21:29 2004
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
