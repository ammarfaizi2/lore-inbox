Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264346AbTGHFnm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 01:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264544AbTGHFnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 01:43:42 -0400
Received: from smtp806.mail.sc5.yahoo.com ([66.163.168.185]:65418 "HELO
	smtp806.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264346AbTGHFn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 01:43:27 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Peter Berg Larsen <pebl@math.ku.dk>
Subject: Re: [PATCH] Synaptics: support for pass-through port (stick)
Date: Tue, 8 Jul 2003 00:59:41 -0500
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
References: <Pine.LNX.4.40.0307071400140.28730-100000@shannon.math.ku.dk>
In-Reply-To: <Pine.LNX.4.40.0307071400140.28730-100000@shannon.math.ku.dk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307080059.55925.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 July 2003 07:09 am, Peter Berg Larsen wrote:
> On Mon, 7 Jul 2003, Peter Berg Larsen wrote:
>
> Replying to myself.
>
> > > button reporting (only left and right as I am not sure to which buttons
> > > up/down should be mapped),
> >
> > hmm. You dont know what the guest protocol, so you can't just | the
> > button information. However, reallity is that this will work for nearly
> > anybody now.
>
> This is not the greatest idea as the guest sometimes does not recieve the
> button release. This is bad only if the userdriver multiplex the
> micebuttons from different mice, because it would then seem as the user
> holds the button down.
>

Ok, here is hopefully the final version:

- no button multiplexing is done in kernel, this task is left for the 
userland (gpm/XFree);

- the driver looks for both 0xAA and 0x00 before attempting rescan;

- there is a new module parameter - psmouse_resetafter - which specifies 
how many bad packets synaptics will receive before attempting to rescan
(plugging my laptop into a docking station causes synaptics to be silently
reset back into relative mode, having this parameter set to let's say 10 
allows quickly restore it). 0 - never.

Dmitry

diff -urN --exclude-from=/usr/src/exclude 2.5.74-vanilla/Documentation/kernel-parameters.txt linux-2.5.74/Documentation/kernel-parameters.txt
--- 2.5.74-vanilla/Documentation/kernel-parameters.txt	2003-06-14 14:18:52.000000000 -0500
+++ linux-2.5.74/Documentation/kernel-parameters.txt	2003-07-08 00:14:07.000000000 -0500
@@ -780,6 +780,10 @@
 
 	psmouse_noext	[HW,MOUSE] Disable probing for PS2 mouse protocol extensions
 
+	psmouse_resetafter= 
+			[HW,MOUSE] Try to reset Synaptics Touchpad after so many
+			bad packets (0 = never).
+
 	pss=		[HW,OSS] Personal Sound System (ECHO ESC614)
 			Format: <io>,<mss_io>,<mss_irq>,<mss_dma>,<mpu_io>,<mpu_irq>
 
diff -urN --exclude-from=/usr/src/exclude 2.5.74-vanilla/drivers/input/mouse/psmouse-base.c linux-2.5.74/drivers/input/mouse/psmouse-base.c
--- 2.5.74-vanilla/drivers/input/mouse/psmouse-base.c	2003-07-05 00:28:41.000000000 -0500
+++ linux-2.5.74/drivers/input/mouse/psmouse-base.c	2003-07-08 00:14:15.000000000 -0500
@@ -29,18 +29,20 @@
 MODULE_PARM_DESC(psmouse_resolution, "Resolution, in dpi.");
 MODULE_PARM(psmouse_smartscroll, "i");
 MODULE_PARM_DESC(psmouse_smartscroll, "Logitech Smartscroll autorepeat, 1 = enabled (default), 0 = disabled.");
+MODULE_PARM(psmouse_resetafter, "i");
+MODULE_PARM_DESC(psmouse_resetafter, "Reset Synaptics Touchpad after so many bad packets (0 = never).");
 MODULE_LICENSE("GPL");
 
 #define PSMOUSE_LOGITECH_SMARTSCROLL	1
-
 static int psmouse_noext;
 int psmouse_resolution;
 int psmouse_smartscroll = PSMOUSE_LOGITECH_SMARTSCROLL;
+unsigned int psmouse_resetafter;
 
 static char *psmouse_protocols[] = { "None", "PS/2", "PS2++", "PS2T++", "GenPS/2", "ImPS/2", "ImExPS/2", "Synaptics"};
 
 /*
- * psmouse_process_packet() anlyzes the PS/2 mouse packet contents and
+ * psmouse_process_packet() analyzes the PS/2 mouse packet contents and
  * reports relevant events to the input module.
  */
 
@@ -108,6 +110,9 @@
 {
 	struct psmouse *psmouse = serio->private;
 
+	if (psmouse->state == PSMOUSE_IGNORE)
+		goto out;
+	
 	if (psmouse->acking) {
 		switch (data) {
 			case PSMOUSE_RET_ACK:
@@ -132,31 +137,46 @@
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
-		goto out;
+	
+	if (psmouse->packet[0] == PSMOUSE_RET_BAT) {
+		if (psmouse->pktcnt == 1) 
+			goto out;
+		
+		if (psmouse->pktcnt == 2) {
+			if (psmouse->packet[1] == PSMOUSE_RET_ID) {
+				psmouse->state = PSMOUSE_IGNORE;
+				serio_rescan(serio);
+				goto out;
+			}
+			if (psmouse->type == PSMOUSE_SYNAPTICS) {
+				/* neither 0xAA nor 0x00 are valid first bytes
+				 * for a packet in absolute mode
+				 */
+				psmouse->pktcnt = 0;
+				goto out;
+			}
+		}
 	}
-
-	if (psmouse->pktcnt == 1 && psmouse->type == PSMOUSE_SYNAPTICS) {
+	
+	if (psmouse->type == PSMOUSE_SYNAPTICS) {
 		/*
 		 * The synaptics driver has its own resync logic,
 		 * so it needs to receive all bytes one at a time.
 		 */
 		synaptics_process_byte(psmouse, regs);
-		psmouse->pktcnt = 0;
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
@@ -450,14 +470,18 @@
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
 
+	psmouse->state = PSMOUSE_ACTIVATED;
 }
 
 /*
@@ -478,9 +502,11 @@
 static void psmouse_disconnect(struct serio *serio)
 {
 	struct psmouse *psmouse = serio->private;
+
+	psmouse->state = PSMOUSE_IGNORE;
 	input_unregister_device(&psmouse->dev);
-	serio_close(serio);
 	synaptics_disconnect(psmouse);
+	serio_close(serio);
 	kfree(psmouse);
 }
 
@@ -493,7 +519,8 @@
 {
 	struct psmouse *psmouse;
 	
-	if ((serio->type & SERIO_TYPE) != SERIO_8042)
+	if ((serio->type & SERIO_TYPE) != SERIO_8042 &&
+	    (serio->type & SERIO_TYPE) != SERIO_PS_PSTHRU)
 		return;
 
 	if (!(psmouse = kmalloc(sizeof(struct psmouse), GFP_KERNEL)))
@@ -506,6 +533,7 @@
 	psmouse->dev.keybit[LONG(BTN_MOUSE)] = BIT(BTN_LEFT) | BIT(BTN_MIDDLE) | BIT(BTN_RIGHT);
 	psmouse->dev.relbit[0] = BIT(REL_X) | BIT(REL_Y);
 
+	psmouse->state = PSMOUSE_NEW_DEVICE;
 	psmouse->serio = serio;
 	psmouse->dev.private = psmouse;
 
@@ -539,6 +567,10 @@
 	printk(KERN_INFO "input: %s on %s\n", psmouse->devname, serio->phys);
 
 	psmouse_initialize(psmouse);
+
+	synaptics_pt_init(psmouse);
+
+	psmouse_activate(psmouse);
 }
 
 static struct serio_dev psmouse_dev = {
@@ -567,9 +599,16 @@
 	return 1;
 }
 
+static int __init psmouse_resetafter_setup(char *str)
+{
+	get_option(&str, &psmouse_resetafter);
+	return 1;
+}
+
 __setup("psmouse_noext", psmouse_noext_setup);
 __setup("psmouse_resolution=", psmouse_resolution_setup);
 __setup("psmouse_smartscroll=", psmouse_smartscroll_setup);
+__setup("psmouse_resetafter=", psmouse_resetafter_setup);
 
 #endif
 
diff -urN --exclude-from=/usr/src/exclude 2.5.74-vanilla/drivers/input/mouse/psmouse.h linux-2.5.74/drivers/input/mouse/psmouse.h
--- 2.5.74-vanilla/drivers/input/mouse/psmouse.h	2003-07-05 00:28:41.000000000 -0500
+++ linux-2.5.74/drivers/input/mouse/psmouse.h	2003-07-08 00:52:55.000000000 -0500
@@ -13,9 +13,15 @@
 #define PSMOUSE_CMD_RESET_BAT	0x02ff
 
 #define PSMOUSE_RET_BAT		0xaa
+#define PSMOUSE_RET_ID		0x00
 #define PSMOUSE_RET_ACK		0xfa
 #define PSMOUSE_RET_NAK		0xfe
 
+/* psmouse states */
+#define PSMOUSE_NEW_DEVICE	0
+#define PSMOUSE_ACTIVATED	1
+#define PSMOUSE_IGNORE		2
+
 struct psmouse {
 	void *private;
 	struct input_dev dev;
@@ -29,6 +35,7 @@
 	unsigned char type;
 	unsigned char model;
 	unsigned long last;
+	unsigned char state;
 	char acking;
 	volatile char ack;
 	char error;
@@ -36,16 +43,17 @@
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
 
 extern int psmouse_smartscroll;
+extern unsigned int psmouse_resetafter;
 
 #endif /* _PSMOUSE_H */
diff -urN --exclude-from=/usr/src/exclude 2.5.74-vanilla/drivers/input/mouse/synaptics.c linux-2.5.74/drivers/input/mouse/synaptics.c
--- 2.5.74-vanilla/drivers/input/mouse/synaptics.c	2003-07-05 00:28:41.000000000 -0500
+++ linux-2.5.74/drivers/input/mouse/synaptics.c	2003-07-08 00:41:39.000000000 -0500
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
 
@@ -71,7 +75,7 @@
 
 	if (synaptics_special_cmd(psmouse, mode))
 		return -1;
-	param[0] = 0x14;
+	param[0] = SYN_PS_SET_MODE2;
 	if (psmouse_command(psmouse, param, PSMOUSE_CMD_SETRATE))
 		return -1;
 	return 0;
@@ -83,7 +87,7 @@
 
 	if (psmouse_command(psmouse, r, PSMOUSE_CMD_RESET_BAT))
 		return -1;
-	if (r[0] == 0xAA && r[1] == 0x00)
+	if (r[0] == PSMOUSE_RET_BAT && r[1] == PSMOUSE_RET_ID)
 		return 0;
 	return -1;
 }
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
 
@@ -188,13 +187,100 @@
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
 
+static void synaptics_pt_close(struct serio *port)
+{
+}
+
+static int synaptics_pt_write(struct serio *port, unsigned char c)
+{
+	struct psmouse *parent = port->driver;
+	char rate_param = SYN_PS_CLIENT_CMD; // indicates that we want pass-through port
+
+	if (synaptics_special_cmd(parent, c))
+		return -1;
+	if (psmouse_command(parent, &rate_param, PSMOUSE_CMD_SETRATE))
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
+		if (child->state == PSMOUSE_ACTIVATED) {
+			serio_interrupt(ptport, packet[1], 0, NULL);
+			serio_interrupt(ptport, packet[4], 0, NULL);
+			serio_interrupt(ptport, packet[5], 0, NULL);
+			if (child->type >= PSMOUSE_GENPS)	
+				serio_interrupt(ptport, packet[2], 0, NULL);
+		} else if (child->state != PSMOUSE_IGNORE) {
+			serio_interrupt(ptport, packet[1], 0, NULL);
+		}
+	}
+}
+
+int synaptics_pt_init(struct psmouse *psmouse)
+{
+	struct synaptics_data *priv = psmouse->private;
+	struct serio *port;
+	struct psmouse *child;
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
+	/* adjust the touchpad to child's choice of protocol */
+	child = port->private;
+	if (child && child->type >= PSMOUSE_GENPS) {
+		if (synaptics_set_mode(psmouse, (SYN_BIT_ABSOLUTE_MODE |
+					 	 SYN_BIT_HIGH_RATE |
+					 	 SYN_BIT_DISABLE_GESTURE |
+						 SYN_BIT_FOUR_BYTE_CLIENT |
+					 	 SYN_BIT_W_MODE)))
+			printk(KERN_INFO "synaptics: failed to enable 4-byte guest protocol\n");
+	}
+	
+	return 0;	
+}
+
 /*****************************************************************************
  *	Driver initialization/cleanup functions
  ****************************************************************************/
@@ -218,13 +304,15 @@
 		return -1;
 	memset(priv, 0, sizeof(struct synaptics_data));
 
-	priv->inSync = 1;
+	priv->out_of_sync = 0;
 
 	if (query_hardware(psmouse)) {
 		printk(KERN_ERR "Unable to query/initialize Synaptics hardware.\n");
 		goto init_fail;
 	}
 
+	print_ident(priv);
+
 	/*
 	 * The x/y limits are taken from the Synaptics TouchPad interfacing Guide,
 	 * which says that they should be valid regardless of the actual size of
@@ -259,17 +347,24 @@
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
@@ -283,7 +378,7 @@
 		 ((buf[3] & 0x04) >> 2));
 
 	hw->left  = (buf[0] & 0x01) ? 1 : 0;
-	hw->right = (buf[0] & 0x2) ? 1 : 0;
+	hw->right = (buf[0] & 0x02) ? 1 : 0;
 	hw->up    = 0;
 	hw->down  = 0;
 
@@ -307,7 +402,7 @@
 	struct synaptics_data *priv = psmouse->private;
 	struct synaptics_hw_state hw;
 
-	synaptics_parse_hw_state(priv, &hw);
+	synaptics_parse_hw_state(psmouse->packet, priv, &hw);
 
 	if (hw.z > 0) {
 		int w_ok = 0;
@@ -355,35 +450,47 @@
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
-		priv->inSync = 0;
-		priv->proto_buf_tail = 0;
+	if (psmouse->pktcnt == 1 && (data & 0xC8) != 0x80) {
 		printk(KERN_WARNING "Synaptics driver lost sync at 1st byte\n");
+		priv->out_of_sync++;
+		psmouse->pktcnt = 0;
+	        if (psmouse_resetafter > 0 && priv->out_of_sync	== psmouse_resetafter) {
+			psmouse->state = PSMOUSE_IGNORE;
+			serio_rescan(psmouse->serio);
+		}
 		return;
 	}
 
 	/* check 4th byte */
-	if ((priv->proto_buf_tail == 4) && ((u & 0xc8) != 0xc0)) {
-		priv->inSync = 0;
-		priv->proto_buf_tail = 0;
+	if (psmouse->pktcnt == 4 && (data & 0xC8) != 0xC0) {
 		printk(KERN_WARNING "Synaptics driver lost sync at 4th byte\n");
+		priv->out_of_sync++;
+		psmouse->pktcnt = 0;
+	        if (psmouse_resetafter > 0 && priv->out_of_sync	== psmouse_resetafter) {
+			psmouse->state = PSMOUSE_IGNORE;
+			serio_rescan(psmouse->serio);
+		}
 		return;
 	}
 
-	if (priv->proto_buf_tail >= 6) { /* Full packet received */
-		if (!priv->inSync) {
-			priv->inSync = 1;
+	if (psmouse->pktcnt >= 6) { /* Full packet received */
+		if (priv->out_of_sync) {
+			priv->out_of_sync = 0;
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
+		psmouse->pktcnt = 0;	
 	}
 }
+
+
diff -urN --exclude-from=/usr/src/exclude 2.5.74-vanilla/drivers/input/mouse/synaptics.h linux-2.5.74/drivers/input/mouse/synaptics.h
--- 2.5.74-vanilla/drivers/input/mouse/synaptics.h	2003-07-05 00:28:41.000000000 -0500
+++ linux-2.5.74/drivers/input/mouse/synaptics.h	2003-07-08 00:03:23.000000000 -0500
@@ -12,6 +12,7 @@
 
 extern void synaptics_process_byte(struct psmouse *psmouse, struct pt_regs *regs);
 extern int synaptics_init(struct psmouse *psmouse);
+extern int synaptics_pt_init(struct psmouse *psmouse);
 extern void synaptics_disconnect(struct psmouse *psmouse);
 
 /* synaptics queries */
@@ -28,6 +29,7 @@
 #define SYN_BIT_HIGH_RATE		(1 << 6)
 #define SYN_BIT_SLEEP_MODE		(1 << 3)
 #define SYN_BIT_DISABLE_GESTURE		(1 << 2)
+#define SYN_BIT_FOUR_BYTE_CLIENT	(1 << 1)
 #define SYN_BIT_W_MODE			(1 << 0)
 
 /* synaptics model ID bits */
@@ -42,6 +44,7 @@
 
 /* synaptics capability bits */
 #define SYN_CAP_EXTENDED(c)		((c) & (1 << 23))
+#define SYN_CAP_PASS_THROUGH(c)		((c) & (1 << 7))
 #define SYN_CAP_SLEEP(c)		((c) & (1 << 4))
 #define SYN_CAP_FOUR_BUTTON(c)		((c) & (1 << 3))
 #define SYN_CAP_MULTIFINGER(c)		((c) & (1 << 1))
@@ -62,6 +65,10 @@
 #define SYN_ID_MINOR(i) 		(((i) >> 16) & 0xff)
 #define SYN_ID_IS_SYNAPTICS(i)		((((i) >> 8) & 0xff) == 0x47)
 
+/* synaptics special commands */
+#define SYN_PS_SET_MODE2		0x14
+#define SYN_PS_CLIENT_CMD		0x28
+
 /*
  * A structure to describe the state of the touchpad hardware (buttons and pad)
  */
@@ -84,12 +91,10 @@
 	unsigned long int identity;		/* Identification */
 
 	/* Data for normal processing */
-	unsigned char proto_buf[6];		/* Buffer for Packet */
-	unsigned char last_byte;		/* last received byte */
-	int inSync;				/* Packets in sync */
-	int proto_buf_tail;
-
+	unsigned int out_of_sync;		/* # of packets out of sync */
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
