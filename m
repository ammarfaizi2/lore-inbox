Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266619AbTGFHJH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 03:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266621AbTGFHJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 03:09:07 -0400
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:52368 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266619AbTGFHIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 03:08:49 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Synaptics: support for pass-through port (stick)
Date: Sun, 6 Jul 2003 02:23:14 -0500
User-Agent: KMail/1.5.1
Cc: Vojtech Pavlik <vojtech@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307060223.15730.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is my attempt to add support for pass-through port to the Synaptics 
touchpad driver so the track stick would work when the touchpad is in
absolute mode.

After synaptics driver and the rest of psmouse is fully initialized and
is about to enable reporting of motion data the new code creates and 
registers a new serio structure that does encapsulation of PS/2 commands
so touchpad would pass them to the stick. Synaptics' interrupt routine 
recognizes stick's packets and passes them to that new serio. The rest of 
the processing is done again by psmouse driver that binds on that new
pass-through serio and doesn't even notice anything unusual.

In order to register that pass-though serio I had to add 2 new functions
to the serio interface - serio_register/unregister_slave_port. These
functions do not try to acquire serio semaphore as it has already been 
downed. If this isn't appropriate I'm open to any suggestions.

The driver's output is like this:

Synaptics Touchpad, model: 1
 Firmware: 5.7
 180 degree mounted touchpad
 Sensor: 1
 new absolute packet format
 Touchpad has extended capability bits
 -> multifinger detection
 -> palm detection
 -> pass-through port
input: Synaptics Synaptics TouchPad on isa0060/serio1
serio: Synaptics pass-through port at isa0060/serio1/input0
input: PS/2 Generic Mouse on synaptics-pt/serio0


What you think?

Dmitry

diff -urN --exclude-from=/usr/src/exclude 2.5.74-vanilla/drivers/input/mouse/psmouse-base.c linux-2.5.74/drivers/input/mouse/psmouse-base.c
--- 2.5.74-vanilla/drivers/input/mouse/psmouse-base.c	2003-07-05 00:28:41.000000000 -0500
+++ linux-2.5.74/drivers/input/mouse/psmouse-base.c	2003-07-06 01:41:18.000000000 -0500
@@ -132,31 +132,33 @@
 	}
 
 	if (psmouse->pktcnt && time_after(jiffies, psmouse->last + HZ/2)) {
-		printk(KERN_WARNING "psmouse.c: Lost synchronization, throwing %d bytes away.\n", psmouse->pktcnt);
+		printk(KERN_WARNING "psmouse.c: %s at %s lost synchronization, throwing %d bytes away.\n", 
+		       psmouse->name, psmouse->phys, psmouse->pktcnt);
 		psmouse->pktcnt = 0;
 	}
 	
 	psmouse->last = jiffies;
 	psmouse->packet[psmouse->pktcnt++] = data;
-
-	if (psmouse->pktcnt == 3 + (psmouse->type >= PSMOUSE_GENPS)) {
-		psmouse_process_packet(psmouse, regs);
-		psmouse->pktcnt = 0;
+	
+	if (psmouse->pktcnt == 1 && psmouse->packet[0] == PSMOUSE_RET_BAT) {
+		serio_rescan(serio);
 		goto out;
 	}
 
-	if (psmouse->pktcnt == 1 && psmouse->type == PSMOUSE_SYNAPTICS) {
+	if (psmouse->type == PSMOUSE_SYNAPTICS) {
 		/*
 		 * The synaptics driver has its own resync logic,
 		 * so it needs to receive all bytes one at a time.
 		 */
-		synaptics_process_byte(psmouse, regs);
-		psmouse->pktcnt = 0;
+		if (synaptics_process_byte(psmouse, regs))
+			psmouse->pktcnt = 0;
+		
 		goto out;
 	}
 
-	if (psmouse->pktcnt == 1 && psmouse->packet[0] == PSMOUSE_RET_BAT) {
-		serio_rescan(serio);
+	if (psmouse->pktcnt == 3 + (psmouse->type >= PSMOUSE_GENPS)) {
+		psmouse_process_packet(psmouse, regs);
+		psmouse->pktcnt = 0;
 		goto out;
 	}
 out:
@@ -450,14 +452,18 @@
  */
 
 	psmouse_command(psmouse, param, PSMOUSE_CMD_SETSTREAM);
+}
 
 /*
- * Last, we enable the mouse so that we get reports from it.
+ * psmouse_activate() enables the mouse so that we get motion reports from it.
  */
 
+static void psmouse_activate(struct psmouse *psmouse)
+{
 	if (psmouse_command(psmouse, NULL, PSMOUSE_CMD_ENABLE))
 		printk(KERN_WARNING "psmouse.c: Failed to enable mouse on %s\n", psmouse->serio->phys);
 
+	psmouse->init_done = 1;
 }
 
 /*
@@ -478,9 +484,10 @@
 static void psmouse_disconnect(struct serio *serio)
 {
 	struct psmouse *psmouse = serio->private;
+
 	input_unregister_device(&psmouse->dev);
-	serio_close(serio);
 	synaptics_disconnect(psmouse);
+	serio_close(serio);
 	kfree(psmouse);
 }
 
@@ -493,7 +500,8 @@
 {
 	struct psmouse *psmouse;
 	
-	if ((serio->type & SERIO_TYPE) != SERIO_8042)
+	if ((serio->type & SERIO_TYPE) != SERIO_8042 &&
+	    (serio->type & SERIO_TYPE) != SERIO_PS_PSTHRU)
 		return;
 
 	if (!(psmouse = kmalloc(sizeof(struct psmouse), GFP_KERNEL)))
@@ -539,6 +547,10 @@
 	printk(KERN_INFO "input: %s on %s\n", psmouse->devname, serio->phys);
 
 	psmouse_initialize(psmouse);
+
+	synaptics_pt_init(psmouse);
+
+	psmouse_activate(psmouse);
 }
 
 static struct serio_dev psmouse_dev = {
diff -urN --exclude-from=/usr/src/exclude 2.5.74-vanilla/drivers/input/mouse/psmouse.h linux-2.5.74/drivers/input/mouse/psmouse.h
--- 2.5.74-vanilla/drivers/input/mouse/psmouse.h	2003-07-05 00:28:41.000000000 -0500
+++ linux-2.5.74/drivers/input/mouse/psmouse.h	2003-07-05 00:42:51.000000000 -0500
@@ -31,18 +31,19 @@
 	unsigned long last;
 	char acking;
 	volatile char ack;
+	char init_done;
 	char error;
 	char devname[64];
 	char phys[32];
 };
 
-#define PSMOUSE_PS2	1
-#define PSMOUSE_PS2PP	2
-#define PSMOUSE_PS2TPP	3
-#define PSMOUSE_GENPS	4
-#define PSMOUSE_IMPS	5
-#define PSMOUSE_IMEX	6
-#define PSMOUSE_SYNAPTICS 7
+#define PSMOUSE_PS2		1
+#define PSMOUSE_PS2PP		2
+#define PSMOUSE_PS2TPP		3
+#define PSMOUSE_GENPS		4
+#define PSMOUSE_IMPS		5
+#define PSMOUSE_IMEX		6
+#define PSMOUSE_SYNAPTICS 	7
 
 int psmouse_command(struct psmouse *psmouse, unsigned char *param, int command);
 
diff -urN --exclude-from=/usr/src/exclude 2.5.74-vanilla/drivers/input/mouse/synaptics.c linux-2.5.74/drivers/input/mouse/synaptics.c
--- 2.5.74-vanilla/drivers/input/mouse/synaptics.c	2003-07-05 00:28:41.000000000 -0500
+++ linux-2.5.74/drivers/input/mouse/synaptics.c	2003-07-05 19:23:11.000000000 -0500
@@ -1,6 +1,9 @@
 /*
  * Synaptics TouchPad PS/2 mouse driver
  *
+ *   2003 Dmitry Torokhov <dtor@mail.ru>
+ *     Added support for pass-through port
+ *     
  *   2003 Peter Osterlund <petero2@telia.com>
  *     Ported to 2.5 input device infrastructure.
  *
@@ -21,6 +24,7 @@
 
 #include <linux/module.h>
 #include <linux/input.h>
+#include <linux/serio.h>
 #include "psmouse.h"
 #include "synaptics.h"
 
@@ -134,17 +138,10 @@
 	return -1;
 }
 
-static int synaptics_enable_device(struct psmouse *psmouse)
-{
-	if (psmouse_command(psmouse, NULL, PSMOUSE_CMD_ENABLE))
-		return -1;
-	return 0;
-}
-
 static void print_ident(struct synaptics_data *priv)
 {
 	printk(KERN_INFO "Synaptics Touchpad, model: %ld\n", SYN_ID_MODEL(priv->identity));
-	printk(KERN_INFO " Firware: %ld.%ld\n", SYN_ID_MAJOR(priv->identity),
+	printk(KERN_INFO " Firmware: %ld.%ld\n", SYN_ID_MAJOR(priv->identity),
 	       SYN_ID_MINOR(priv->identity));
 
 	if (SYN_MODEL_ROT180(priv->model_id))
@@ -165,6 +162,8 @@
 			printk(KERN_INFO " -> multifinger detection\n");
 		if (SYN_CAP_PALMDETECT(priv->capabilities))
 			printk(KERN_INFO " -> palm detection\n");
+		if (SYN_CAP_PASS_THROUGH(priv->capabilities))
+			printk(KERN_INFO " -> pass-through port\n");
 	}
 }
 
@@ -188,13 +187,88 @@
 					 SYN_BIT_W_MODE)))
 		return -1;
 
-	synaptics_enable_device(psmouse);
+	return 0;
+}
 
-	print_ident(priv);
+/*****************************************************************************
+ *	Synaptics pass-through PS/2 port support
+ ****************************************************************************/
+static int synaptics_pt_open(struct serio *port)
+{
+	return 0;
+}
+
+static void synaptics_pt_close(struct serio *port)
+{
+}
+
+static int synaptics_pt_write(struct serio *port, unsigned char c)
+{
+	struct psmouse *parent = port->driver;
+	char client_cmd = 0x28; // indicates that we want pass-through port
 
+	if (synaptics_special_cmd(parent, c))
+		return -1;
+	if (psmouse_command(parent, &client_cmd, PSMOUSE_CMD_SETRATE))
+		return -1;
 	return 0;
 }
 
+static inline int synaptics_is_pt_packet(unsigned char *buf)
+{
+	return (buf[0] & 0xFC) == 0x84 && (buf[3] & 0xCC) == 0xC4;
+}
+
+static void synaptics_pass_pt_packet(struct serio *ptport, unsigned char *packet)
+{
+	struct psmouse *child = ptport->private;
+
+	if (child) {
+		if (child->init_done) {
+			serio_interrupt(ptport, packet[1], 0, NULL);
+			if (child->type >= PSMOUSE_GENPS)	
+				serio_interrupt(ptport, packet[2], 0, NULL);
+			serio_interrupt(ptport, packet[4], 0, NULL);
+			serio_interrupt(ptport, packet[5], 0, NULL);
+		} else {
+			serio_interrupt(ptport, packet[1], 0, NULL);
+		}
+	}
+}
+
+int synaptics_pt_init(struct psmouse *psmouse)
+{
+	struct synaptics_data *priv = psmouse->private;
+	struct serio *port;
+	
+	if (psmouse->type != PSMOUSE_SYNAPTICS)
+		return -1;
+	if (!SYN_CAP_EXTENDED(priv->capabilities))
+		return -1;
+	if (!SYN_CAP_PASS_THROUGH(priv->capabilities))
+		return -1;
+
+	priv->ptport = port = kmalloc(sizeof(struct serio), GFP_KERNEL);
+	if (unlikely(!port)) {
+		printk(KERN_ERR "synaptics: not enough memory to allocate serio port\n");	
+		return -1;
+	}
+	
+	memset(port, 0, sizeof(struct serio));
+	port->type = SERIO_PS_PSTHRU;
+	port->name = "Synaptics pass-through";
+	port->phys = "synaptics-pt/serio0";
+	port->write = synaptics_pt_write;
+	port->open = synaptics_pt_open;
+	port->close = synaptics_pt_close;
+	port->driver = psmouse;
+	
+	printk(KERN_INFO "serio: %s port at %s\n", port->name, psmouse->phys);
+	serio_register_slave_port(port);
+	
+	return 0;	
+}
+
 /*****************************************************************************
  *	Driver initialization/cleanup functions
  ****************************************************************************/
@@ -225,6 +299,8 @@
 		goto init_fail;
 	}
 
+	print_ident(priv);
+
 	/*
 	 * The x/y limits are taken from the Synaptics TouchPad interfacing Guide,
 	 * which says that they should be valid regardless of the actual size of
@@ -259,17 +335,24 @@
 {
 	struct synaptics_data *priv = psmouse->private;
 
-	kfree(priv);
+	if (psmouse->type == PSMOUSE_SYNAPTICS && priv) {
+		synaptics_set_mode(psmouse, 0);
+		if (priv->ptport) {
+			serio_unregister_slave_port(priv->ptport);
+			kfree(priv->ptport);
+		} 
+		kfree(priv);
+	}
 }
 
 /*****************************************************************************
  *	Functions to interpret the absolute mode packets
  ****************************************************************************/
 
-static void synaptics_parse_hw_state(struct synaptics_data *priv, struct synaptics_hw_state *hw)
+static void synaptics_parse_hw_state(unsigned char buf[],
+				     struct synaptics_data *priv,
+				     struct synaptics_hw_state *hw)
 {
-	unsigned char *buf = priv->proto_buf;
-
 	hw->x = (((buf[3] & 0x10) << 8) |
 		 ((buf[1] & 0x0f) << 8) |
 		 buf[4]);
@@ -283,7 +366,7 @@
 		 ((buf[3] & 0x04) >> 2));
 
 	hw->left  = (buf[0] & 0x01) ? 1 : 0;
-	hw->right = (buf[0] & 0x2) ? 1 : 0;
+	hw->right = (buf[0] & 0x02) ? 1 : 0;
 	hw->up    = 0;
 	hw->down  = 0;
 
@@ -307,7 +390,7 @@
 	struct synaptics_data *priv = psmouse->private;
 	struct synaptics_hw_state hw;
 
-	synaptics_parse_hw_state(priv, &hw);
+	synaptics_parse_hw_state(psmouse->packet, priv, &hw);
 
 	if (hw.z > 0) {
 		int w_ok = 0;
@@ -351,39 +434,42 @@
 	input_sync(dev);
 }
 
-void synaptics_process_byte(struct psmouse *psmouse, struct pt_regs *regs)
+int synaptics_process_byte(struct psmouse *psmouse, struct pt_regs *regs)
 {
 	struct input_dev *dev = &psmouse->dev;
 	struct synaptics_data *priv = psmouse->private;
-	unsigned char *pBuf = priv->proto_buf;
-	unsigned char u = psmouse->packet[0];
+	unsigned char data = psmouse->packet[psmouse->pktcnt - 1];
 
 	input_regs(dev, regs);
 
-	pBuf[priv->proto_buf_tail++] = u;
-
 	/* check first byte */
-	if ((priv->proto_buf_tail == 1) && ((u & 0xC8) != 0x80)) {
+	if (psmouse->pktcnt == 1 && (data & 0xC8) != 0x80) {
 		priv->inSync = 0;
-		priv->proto_buf_tail = 0;
 		printk(KERN_WARNING "Synaptics driver lost sync at 1st byte\n");
-		return;
+		return 1;
 	}
 
 	/* check 4th byte */
-	if ((priv->proto_buf_tail == 4) && ((u & 0xc8) != 0xc0)) {
+	if (psmouse->pktcnt == 4 && (data & 0xC8) != 0xC0) {
 		priv->inSync = 0;
-		priv->proto_buf_tail = 0;
 		printk(KERN_WARNING "Synaptics driver lost sync at 4th byte\n");
-		return;
+		return 1;
 	}
 
-	if (priv->proto_buf_tail >= 6) { /* Full packet received */
+	if (psmouse->pktcnt >= 6) { /* Full packet received */
 		if (!priv->inSync) {
 			priv->inSync = 1;
 			printk(KERN_NOTICE "Synaptics driver resynced.\n");
 		}
-		synaptics_process_packet(psmouse);
-		priv->proto_buf_tail = 0;
+		
+		if (priv->ptport && synaptics_is_pt_packet(psmouse->packet)) 
+			synaptics_pass_pt_packet(priv->ptport, psmouse->packet);
+		else
+			synaptics_process_packet(psmouse);
+		
+		return 1;	
 	}
+	
+	return 0;
 }
+
diff -urN --exclude-from=/usr/src/exclude 2.5.74-vanilla/drivers/input/mouse/synaptics.h linux-2.5.74/drivers/input/mouse/synaptics.h
--- 2.5.74-vanilla/drivers/input/mouse/synaptics.h	2003-07-05 00:28:41.000000000 -0500
+++ linux-2.5.74/drivers/input/mouse/synaptics.h	2003-07-05 00:44:41.000000000 -0500
@@ -10,8 +10,9 @@
 #define _SYNAPTICS_H
 
 
-extern void synaptics_process_byte(struct psmouse *psmouse, struct pt_regs *regs);
+extern int synaptics_process_byte(struct psmouse *psmouse, struct pt_regs *regs);
 extern int synaptics_init(struct psmouse *psmouse);
+extern int synaptics_pt_init(struct psmouse *psmouse);
 extern void synaptics_disconnect(struct psmouse *psmouse);
 
 /* synaptics queries */
@@ -42,6 +43,7 @@
 
 /* synaptics capability bits */
 #define SYN_CAP_EXTENDED(c)		((c) & (1 << 23))
+#define SYN_CAP_PASS_THROUGH(c)		((c) & (1 << 7))
 #define SYN_CAP_SLEEP(c)		((c) & (1 << 4))
 #define SYN_CAP_FOUR_BUTTON(c)		((c) & (1 << 3))
 #define SYN_CAP_MULTIFINGER(c)		((c) & (1 << 1))
@@ -62,6 +64,9 @@
 #define SYN_ID_MINOR(i) 		(((i) >> 16) & 0xff)
 #define SYN_ID_IS_SYNAPTICS(i)		((((i) >> 8) & 0xff) == 0x47)
 
+#define SYN_REL_DECEL_FACTOR		8
+#define SYN_REL_PRESSURE_THRESHOLD	30
+
 /*
  * A structure to describe the state of the touchpad hardware (buttons and pad)
  */
@@ -84,12 +89,10 @@
 	unsigned long int identity;		/* Identification */
 
 	/* Data for normal processing */
-	unsigned char proto_buf[6];		/* Buffer for Packet */
-	unsigned char last_byte;		/* last received byte */
 	int inSync;				/* Packets in sync */
-	int proto_buf_tail;
-
 	int old_w;				/* Previous w value */
+	
+	struct serio *ptport;			/* pass-through port */
 };
 
 #endif /* _SYNAPTICS_H */
diff -urN --exclude-from=/usr/src/exclude 2.5.74-vanilla/drivers/input/serio/serio.c linux-2.5.74/drivers/input/serio/serio.c
--- 2.5.74-vanilla/drivers/input/serio/serio.c	2003-07-05 00:28:41.000000000 -0500
+++ linux-2.5.74/drivers/input/serio/serio.c	2003-07-05 19:21:35.000000000 -0500
@@ -45,7 +45,9 @@
 
 EXPORT_SYMBOL(serio_interrupt);
 EXPORT_SYMBOL(serio_register_port);
+EXPORT_SYMBOL(serio_register_slave_port);
 EXPORT_SYMBOL(serio_unregister_port);
+EXPORT_SYMBOL(serio_unregister_slave_port);
 EXPORT_SYMBOL(serio_register_device);
 EXPORT_SYMBOL(serio_unregister_device);
 EXPORT_SYMBOL(serio_open);
@@ -162,6 +164,16 @@
 	up(&serio_sem);
 }
 
+/* Same as serio_register_port but does not try to acquire serio_sem.
+ * Should be used when registering a serio from other input device's
+ * connect() function.
+ */
+void serio_register_slave_port(struct serio *serio)
+{
+	list_add_tail(&serio->node, &serio_list);
+	serio_find_dev(serio);
+}
+
 void serio_unregister_port(struct serio *serio)
 {
 	down(&serio_sem);
@@ -171,6 +183,17 @@
 	up(&serio_sem);
 }
 
+/* Same as serio_register_port but does not try to acquire serio_sem.
+ * Should be used when unregistering a serio from other input device's
+ * disconnect() function.
+ */
+void serio_unregister_slave_port(struct serio *serio)
+{
+	list_del_init(&serio->node);
+	if (serio->dev && serio->dev->disconnect)
+		serio->dev->disconnect(serio);
+}
+
 void serio_register_device(struct serio_dev *dev)
 {
 	struct serio *serio;
diff -urN --exclude-from=/usr/src/exclude 2.5.74-vanilla/include/linux/serio.h linux-2.5.74/include/linux/serio.h
--- 2.5.74-vanilla/include/linux/serio.h	2003-07-05 00:29:02.000000000 -0500
+++ linux-2.5.74/include/linux/serio.h	2003-07-05 19:17:56.000000000 -0500
@@ -65,7 +65,9 @@
 irqreturn_t serio_interrupt(struct serio *serio, unsigned char data, unsigned int flags, struct pt_regs *regs);
 
 void serio_register_port(struct serio *serio);
+void serio_register_slave_port(struct serio *serio);
 void serio_unregister_port(struct serio *serio);
+void serio_unregister_slave_port(struct serio *serio);
 void serio_register_device(struct serio_dev *dev);
 void serio_unregister_device(struct serio_dev *dev);
 
@@ -104,6 +106,7 @@
 #define SERIO_RS232	0x02000000UL
 #define SERIO_HIL_MLC	0x03000000UL
 #define SERIO_PC9800	0x04000000UL
+#define SERIO_PS_PSTHRU	0x05000000UL
 
 #define SERIO_PROTO	0xFFUL
 #define SERIO_MSC	0x01
