Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264546AbTFKV66 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 17:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264547AbTFKV65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 17:58:57 -0400
Received: from maild.telia.com ([194.22.190.101]:28102 "EHLO maild.telia.com")
	by vger.kernel.org with ESMTP id S264546AbTFKV6q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 17:58:46 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
To: Vojtech Pavlik <vojtech@ucw.cz>
Cc: Andrew Morton <akpm@digeo.com>, Joseph Fannin <jhf@rivenstone.net>,
       linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: [PATCH] Synaptics TouchPad driver for 2.5.70
References: <m2u1axk0kp.fsf@p4.localdomain>
	<20030611131742.3b057c93.akpm@digeo.com> <20030611222959.A8473@ucw.cz>
From: Peter Osterlund <petero2@telia.com>
Date: 12 Jun 2003 00:12:08 +0200
In-Reply-To: <20030611222959.A8473@ucw.cz>
Message-ID: <m23cigqn5z.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@ucw.cz> writes:

> On Wed, Jun 11, 2003 at 01:17:42PM -0700, Andrew Morton wrote:
> 
> > "Joseph Fannin" <jhf@rivenstone.net> wrote:
> > >
> > > Here is a driver for the Synaptics TouchPad for 2.5.70.
> > 
> > The code looks nice.
> > 
> > > +#include "synaptics.c"
> > 
> > But why on earth do we need to do this?
> 
> I'm sure we don't. That will be fixed easily.

No we don't. That was just a hack to keep the size of the patch down.
Something like the patch below (applies on top of my previous patch)
would take care of this, except that it renames the psmouse module to
psmouse2. To fix this I think we have to rename the psmouse.c file,
and I didn't want to do that in the original patch, because that would
have made it much harder to review the patch.


diff -u -r -N --exclude='.*' --exclude='*.o' --exclude='*~' linux/drivers/input/mouse.absolute/Makefile linux/drivers/input/mouse/Makefile
--- linux/drivers/input/mouse.absolute/Makefile	Wed Jun 11 23:05:11 2003
+++ linux/drivers/input/mouse/Makefile	Wed Jun 11 23:53:01 2003
@@ -11,5 +11,7 @@
 obj-$(CONFIG_MOUSE_MAPLE)	+= maplemouse.o
 obj-$(CONFIG_MOUSE_PC110PAD)	+= pc110pad.o
 obj-$(CONFIG_MOUSE_PC9800)	+= 98busmouse.o
-obj-$(CONFIG_MOUSE_PS2)		+= psmouse.o
+obj-$(CONFIG_MOUSE_PS2)		+= psmouse2.o
 obj-$(CONFIG_MOUSE_SERIAL)	+= sermouse.o
+
+psmouse2-objs	:= psmouse.o synaptics.o
diff -u -r -N --exclude='.*' --exclude='*.o' --exclude='*~' linux/drivers/input/mouse.absolute/psmouse.c linux/drivers/input/mouse/psmouse.c
--- linux/drivers/input/mouse.absolute/psmouse.c	Wed Jun 11 23:05:25 2003
+++ linux/drivers/input/mouse/psmouse.c	Wed Jun 11 23:56:46 2003
@@ -17,6 +17,8 @@
 #include <linux/input.h>
 #include <linux/serio.h>
 #include <linux/init.h>
+#include "psmouse.h"
+#include "synaptics.h"
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
 MODULE_DESCRIPTION("PS/2 mouse driver");
@@ -25,50 +27,6 @@
 
 static int psmouse_noext;
 
-#define PSMOUSE_CMD_SETSCALE11	0x00e6
-#define PSMOUSE_CMD_SETRES	0x10e8
-#define PSMOUSE_CMD_GETINFO	0x03e9
-#define PSMOUSE_CMD_SETSTREAM	0x00ea
-#define PSMOUSE_CMD_POLL	0x03eb	
-#define PSMOUSE_CMD_GETID	0x02f2
-#define PSMOUSE_CMD_SETRATE	0x10f3
-#define PSMOUSE_CMD_ENABLE	0x00f4
-#define PSMOUSE_CMD_RESET_DIS	0x00f6
-#define PSMOUSE_CMD_RESET_BAT	0x02ff
-
-#define PSMOUSE_RET_BAT		0xaa
-#define PSMOUSE_RET_ACK		0xfa
-#define PSMOUSE_RET_NAK		0xfe
-
-struct psmouse {
-	void *private;
-	struct input_dev dev;
-	struct serio *serio;
-	char *vendor;
-	char *name;
-	unsigned char cmdbuf[8];
-	unsigned char packet[8];
-	unsigned char cmdcnt;
-	unsigned char pktcnt;
-	unsigned char type;
-	unsigned char model;
-	unsigned long last;
-	char acking;
-	volatile char ack;
-	char error;
-	char devname[64];
-	char phys[32];
-};
-
-#define PSMOUSE_PS2	1
-#define PSMOUSE_PS2PP	2
-#define PSMOUSE_PS2TPP	3
-#define PSMOUSE_GENPS	4
-#define PSMOUSE_IMPS	5
-#define PSMOUSE_IMEX	6
-#define PSMOUSE_SYNAPTICS 7
-
-#include "synaptics.c"
 
 static char *psmouse_protocols[] = { "None", "PS/2", "PS2++", "PS2T++", "GenPS/2", "ImPS/2", "ImExPS/2", "Synaptics"};
 
@@ -258,7 +216,7 @@
  * then waits for the response and puts it in the param array.
  */
 
-static int psmouse_command(struct psmouse *psmouse, unsigned char *param, int command)
+int psmouse_command(struct psmouse *psmouse, unsigned char *param, int command)
 {
 	int timeout = 500000; /* 500 msec */
 	int send = (command >> 12) & 0xf;
diff -u -r -N --exclude='.*' --exclude='*.o' --exclude='*~' linux/drivers/input/mouse.absolute/psmouse.h linux/drivers/input/mouse/psmouse.h
--- linux/drivers/input/mouse.absolute/psmouse.h	Thu Jan  1 01:00:00 1970
+++ linux/drivers/input/mouse/psmouse.h	Wed Jun 11 23:56:41 2003
@@ -0,0 +1,49 @@
+#ifndef _PSMOUSE_H
+#define _PSMOUSE_H
+
+#define PSMOUSE_CMD_SETSCALE11	0x00e6
+#define PSMOUSE_CMD_SETRES	0x10e8
+#define PSMOUSE_CMD_GETINFO	0x03e9
+#define PSMOUSE_CMD_SETSTREAM	0x00ea
+#define PSMOUSE_CMD_POLL	0x03eb	
+#define PSMOUSE_CMD_GETID	0x02f2
+#define PSMOUSE_CMD_SETRATE	0x10f3
+#define PSMOUSE_CMD_ENABLE	0x00f4
+#define PSMOUSE_CMD_RESET_DIS	0x00f6
+#define PSMOUSE_CMD_RESET_BAT	0x02ff
+
+#define PSMOUSE_RET_BAT		0xaa
+#define PSMOUSE_RET_ACK		0xfa
+#define PSMOUSE_RET_NAK		0xfe
+
+struct psmouse {
+	void *private;
+	struct input_dev dev;
+	struct serio *serio;
+	char *vendor;
+	char *name;
+	unsigned char cmdbuf[8];
+	unsigned char packet[8];
+	unsigned char cmdcnt;
+	unsigned char pktcnt;
+	unsigned char type;
+	unsigned char model;
+	unsigned long last;
+	char acking;
+	volatile char ack;
+	char error;
+	char devname[64];
+	char phys[32];
+};
+
+#define PSMOUSE_PS2	1
+#define PSMOUSE_PS2PP	2
+#define PSMOUSE_PS2TPP	3
+#define PSMOUSE_GENPS	4
+#define PSMOUSE_IMPS	5
+#define PSMOUSE_IMEX	6
+#define PSMOUSE_SYNAPTICS 7
+
+int psmouse_command(struct psmouse *psmouse, unsigned char *param, int command);
+
+#endif /* _PSMOUSE_H */
diff -u -r -N --exclude='.*' --exclude='*.o' --exclude='*~' linux/drivers/input/mouse.absolute/synaptics.c linux/drivers/input/mouse/synaptics.c
--- linux/drivers/input/mouse.absolute/synaptics.c	Wed Jun 11 23:04:59 2003
+++ linux/drivers/input/mouse/synaptics.c	Wed Jun 11 23:56:32 2003
@@ -19,19 +19,15 @@
  * Trademarks are the property of their respective owners.
  */
 
-#ifndef CONFIG_MOUSE_PS2_SYNAPTICS
+#include <linux/module.h>
 
-static inline void synaptics_process_byte(struct psmouse *psmouse, struct pt_regs *regs) {}
-static inline int synaptics_init(struct psmouse *psmouse) { return -1; }
-static inline void synaptics_disconnect(struct psmouse *psmouse) {}
-
-#else
+#ifdef CONFIG_MOUSE_PS2_SYNAPTICS
 
+#include <linux/input.h>
+#include "psmouse.h"
 #include "synaptics.h"
 
 
-static int psmouse_command(struct psmouse *psmouse, unsigned char *param, int command);
-
 /*****************************************************************************
  *	Synaptics communications functions
  ****************************************************************************/
@@ -217,7 +213,7 @@
 	set_bit(axis, dev->absbit);
 }
 
-static int synaptics_init(struct psmouse *psmouse)
+int synaptics_init(struct psmouse *psmouse)
 {
 	struct synaptics_data *priv;
 
@@ -263,7 +259,7 @@
 	return -1;
 }
 
-static void synaptics_disconnect(struct psmouse *psmouse)
+void synaptics_disconnect(struct psmouse *psmouse)
 {
 	struct synaptics_data *priv = psmouse->private;
 
@@ -360,7 +356,7 @@
 	input_sync(dev);
 }
 
-static void synaptics_process_byte(struct psmouse *psmouse, struct pt_regs *regs)
+void synaptics_process_byte(struct psmouse *psmouse, struct pt_regs *regs)
 {
 	struct input_dev *dev = &psmouse->dev;
 	struct synaptics_data *priv = psmouse->private;
diff -u -r -N --exclude='.*' --exclude='*.o' --exclude='*~' linux/drivers/input/mouse.absolute/synaptics.h linux/drivers/input/mouse/synaptics.h
--- linux/drivers/input/mouse.absolute/synaptics.h	Wed Jun 11 23:04:50 2003
+++ linux/drivers/input/mouse/synaptics.h	Wed Jun 11 23:49:42 2003
@@ -9,6 +9,21 @@
 #ifndef _SYNAPTICS_H
 #define _SYNAPTICS_H
 
+#ifdef CONFIG_MOUSE_PS2_SYNAPTICS
+
+extern void synaptics_process_byte(struct psmouse *psmouse, struct pt_regs *regs);
+extern int synaptics_init(struct psmouse *psmouse);
+extern void synaptics_disconnect(struct psmouse *psmouse);
+
+#else
+
+static inline void synaptics_process_byte(struct psmouse *psmouse, struct pt_regs *regs) {}
+static inline int synaptics_init(struct psmouse *psmouse) { return -1; }
+static inline void synaptics_disconnect(struct psmouse *psmouse) {}
+
+#endif
+
+
 /* synaptics queries */
 #define SYN_QUE_IDENTIFY		0x00
 #define SYN_QUE_MODES			0x01

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
