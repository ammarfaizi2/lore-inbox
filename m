Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262930AbTHZXLo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 19:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262708AbTHZXLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 19:11:44 -0400
Received: from smtp5.hy.skanova.net ([195.67.199.134]:20714 "EHLO
	smtp5.hy.skanova.net") by vger.kernel.org with ESMTP
	id S262930AbTHZXLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 19:11:31 -0400
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>,
       Peter Berg Larsen <pebl@math.ku.dk>
Subject: Re: [PATCH 2.6] Synaptics: support reconnect keeping the same input device
References: <200308230131.57111.dtor_core@ameritech.net>
From: Peter Osterlund <petero2@telia.com>
Date: 27 Aug 2003 01:07:30 +0200
In-Reply-To: <200308230131.57111.dtor_core@ameritech.net>
Message-ID: <m2he4410i5.fsf@p4.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov <dtor_core@ameritech.net> writes:

> Here is the update to the Synaptics touchpad driver. It is supposed to go 
> on top of patches form Peter Osterlund site:
> (http://w1.894.telia.com/~u89404340/patches/touchpad/2.6.0-test2/v1/)
> and on top of 3 serio patches I posted earlier.

I have uploaded a new patch set to my web site:

http://w1.894.telia.com/~u89404340/patches/touchpad/2.6.0-test4/v1/

It contains this patch and some other patches from you with some
modifications:

* I got a kernel panic in synaptics_process_byte() because my touchpad
  doesn't have a pass through port. Fixed by making sure ptport is
  non-NULL before dereferencing it.
* While tracking down the panic, I split this patch in two. One
  cleanup patch and one patch that implements the reconnect changes.
* Peter Berg Larsen mentioned that we need to detect synaptics devices
  even if they don't want to use absolute mode, so I changed the code
  to do that.

The reconnect patch now looks like this, but it can only be applied on
top of the other patches from my web site:

 linux-petero/drivers/input/mouse/logips2pp.c    |    1 
 linux-petero/drivers/input/mouse/psmouse-base.c |   96 +++++++++++---
 linux-petero/drivers/input/mouse/psmouse.h      |   13 ++
 linux-petero/drivers/input/mouse/synaptics.c    |  156 ++++++++++++++----------
 linux-petero/drivers/input/mouse/synaptics.h    |    4 
 5 files changed, 188 insertions(+), 82 deletions(-)

diff -puN drivers/input/mouse/logips2pp.c~synaptics-reconnect drivers/input/mouse/logips2pp.c
--- linux/drivers/input/mouse/logips2pp.c~synaptics-reconnect	2003-08-27 00:39:32.000000000 +0200
+++ linux-petero/drivers/input/mouse/logips2pp.c	2003-08-27 00:39:32.000000000 +0200
@@ -10,6 +10,7 @@
  */
 
 #include <linux/input.h>
+#include <linux/serio.h>
 #include "psmouse.h"
 #include "logips2pp.h"
 
diff -puN drivers/input/mouse/psmouse-base.c~synaptics-reconnect drivers/input/mouse/psmouse-base.c
--- linux/drivers/input/mouse/psmouse-base.c~synaptics-reconnect	2003-08-27 00:39:32.000000000 +0200
+++ linux-petero/drivers/input/mouse/psmouse-base.c	2003-08-27 00:39:32.000000000 +0200
@@ -138,7 +138,8 @@ static irqreturn_t psmouse_interrupt(str
 		goto out;
 	}
 
-	if (psmouse->pktcnt && time_after(jiffies, psmouse->last + HZ/2)) {
+	if (psmouse->state == PSMOUSE_ACTIVATED &&
+	    psmouse->pktcnt && time_after(jiffies, psmouse->last + HZ/2)) {
 		printk(KERN_WARNING "psmouse.c: %s at %s lost synchronization, throwing %d bytes away.\n",
 		       psmouse->name, psmouse->phys, psmouse->pktcnt);
 		psmouse->pktcnt = 0;
@@ -286,9 +287,11 @@ static int psmouse_extensions(struct psm
        if (param[1] == 0x47) {
 		psmouse->vendor = "Synaptics";
 		psmouse->name = "TouchPad";
+#if CONFIG_MOUSE_PS2_SYNAPTICS
 		if (!synaptics_init(psmouse))
 			return PSMOUSE_SYNAPTICS;
 		else
+#endif
 			return PSMOUSE_PS2;
        }
 
@@ -506,7 +509,16 @@ static void psmouse_disconnect(struct se
 	struct psmouse *psmouse = serio->private;
 
 	psmouse->state = PSMOUSE_IGNORE;
-	synaptics_disconnect(psmouse);
+
+	if (psmouse->ptport) {
+		if (psmouse->ptport->deactivate)
+			psmouse->ptport->deactivate(psmouse);
+		serio_unregister_slave_port(&psmouse->ptport->serio);
+	}
+
+	if (psmouse->disconnect)
+		psmouse->disconnect(psmouse);
+
 	input_unregister_device(&psmouse->dev);
 	serio_close(serio);
 	kfree(psmouse);
@@ -519,19 +531,9 @@ static void psmouse_disconnect(struct se
 static int psmouse_pm_callback(struct pm_dev *dev, pm_request_t request, void *data)
 {
 	struct psmouse *psmouse = dev->data;
-	struct serio_dev *ser_dev = psmouse->serio->dev;
 
-	synaptics_disconnect(psmouse);
-
-	/* We need to reopen the serio port to reinitialize the i8042 controller */
-	serio_close(psmouse->serio);
-	serio_open(psmouse->serio, ser_dev);
-
-	/* Probe and re-initialize the mouse */
-	psmouse_probe(psmouse);
-	psmouse_initialize(psmouse);
-	synaptics_pt_init(psmouse);
-	psmouse_activate(psmouse);
+	psmouse->state = PSMOUSE_IGNORE;
+	serio_reconnect(psmouse->serio);
 
 	return 0;
 }
@@ -577,10 +579,12 @@ static void psmouse_connect(struct serio
 		return;
 	}
 	
-	pmdev = pm_register(PM_SYS_DEV, PM_SYS_UNKNOWN, psmouse_pm_callback);
-	if (pmdev) {
-		psmouse->dev.pm_dev = pmdev;
-		pmdev->data = psmouse;
+	if (serio->type != SERIO_PS_PSTHRU) {
+		pmdev = pm_register(PM_SYS_DEV, PM_SYS_UNKNOWN, psmouse_pm_callback);
+		if (pmdev) {
+			psmouse->dev.pm_dev = pmdev;
+			pmdev->data = psmouse;
+		}
 	}
 
 	sprintf(psmouse->devname, "%s %s %s",
@@ -601,14 +605,68 @@ static void psmouse_connect(struct serio
 
 	psmouse_initialize(psmouse);
 
-	synaptics_pt_init(psmouse);
+	if (psmouse->ptport) {
+		printk(KERN_INFO "serio: %s port at %s\n", psmouse->ptport->serio.name, psmouse->phys);
+		serio_register_slave_port(&psmouse->ptport->serio);
+		if (psmouse->ptport->activate)
+			psmouse->ptport->activate(psmouse);
+	}
+
+	psmouse_activate(psmouse);
+}
+
+static int psmouse_reconnect(struct serio *serio)
+{
+	struct psmouse *psmouse = serio->private;
+	struct serio_dev *dev = serio->dev;
+	int old_type = psmouse->type;
+
+	if (!dev) {
+		printk(KERN_DEBUG "psmouse: reconnect request, but serio is disconnected, ignoring...\n");
+		return -1;
+	}
+
+	/* We need to reopen the serio port to reinitialize the i8042 controller */
+	serio_close(serio);
+	if (serio_open(serio, dev)) {
+		/* do a disconnect here as serio_open leaves dev as NULL so disconnect
+		 * will not be called automatically later
+		 */
+		psmouse_disconnect(serio);
+		return -1;
+	}
+
+	psmouse->state = PSMOUSE_NEW_DEVICE;
+	psmouse->type = psmouse->acking = psmouse->cmdcnt = psmouse->pktcnt = 0;
+	if (psmouse->reconnect) {
+	       if (psmouse->reconnect(psmouse))
+			return -1;
+	} else if (psmouse_probe(psmouse) != old_type)
+		return -1;
+
+	/* ok, the device type (and capabilities) match the old one,
+	 * we can continue using it, complete intialization
+	 */
+	psmouse->type = old_type;
+	psmouse_initialize(psmouse);
+
+	if (psmouse->ptport) {
+       		if (psmouse_reconnect(&psmouse->ptport->serio)) {
+			serio_unregister_slave_port(&psmouse->ptport->serio);
+			serio_register_slave_port(&psmouse->ptport->serio);
+			if (psmouse->ptport->activate)
+				psmouse->ptport->activate(psmouse);
+		}
+	}
 
 	psmouse_activate(psmouse);
+	return 0;
 }
 
 static struct serio_dev psmouse_dev = {
 	.interrupt =	psmouse_interrupt,
 	.connect =	psmouse_connect,
+	.reconnect =	psmouse_reconnect,
 	.disconnect =	psmouse_disconnect,
 	.cleanup =	psmouse_cleanup,
 };
diff -puN drivers/input/mouse/psmouse.h~synaptics-reconnect drivers/input/mouse/psmouse.h
--- linux/drivers/input/mouse/psmouse.h~synaptics-reconnect	2003-08-27 00:39:32.000000000 +0200
+++ linux-petero/drivers/input/mouse/psmouse.h	2003-08-27 00:39:32.000000000 +0200
@@ -22,10 +22,20 @@
 #define PSMOUSE_ACTIVATED	1
 #define PSMOUSE_IGNORE		2
 
+struct psmouse;
+
+struct psmouse_ptport {
+	struct serio serio;
+
+	void (*activate)(struct psmouse *parent);
+	void (*deactivate)(struct psmouse *parent);
+};
+
 struct psmouse {
 	void *private;
 	struct input_dev dev;
 	struct serio *serio;
+	struct psmouse_ptport *ptport;
 	char *vendor;
 	char *name;
 	unsigned char cmdbuf[8];
@@ -41,6 +51,9 @@ struct psmouse {
 	char error;
 	char devname[64];
 	char phys[32];
+
+	int (*reconnect)(struct psmouse *psmouse);
+	void (*disconnect)(struct psmouse *psmouse);
 };
 
 #define PSMOUSE_PS2		1
diff -puN drivers/input/mouse/synaptics.c~synaptics-reconnect drivers/input/mouse/synaptics.c
--- linux/drivers/input/mouse/synaptics.c~synaptics-reconnect	2003-08-27 00:39:32.000000000 +0200
+++ linux-petero/drivers/input/mouse/synaptics.c	2003-08-27 00:39:32.000000000 +0200
@@ -182,11 +182,24 @@ static void print_ident(struct synaptics
 	}
 }
 
+static int synaptics_detect(struct psmouse *psmouse)
+{
+	unsigned char param[4];
+
+	param[0] = 0;
+
+	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
+	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
+	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
+	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
+	psmouse_command(psmouse, param, PSMOUSE_CMD_GETINFO);
+
+	return param[1] == 0x47 ? 0 : -1;
+}
+
 static int synaptics_query_hardware(struct psmouse *psmouse)
 {
-	struct synaptics_data *priv = psmouse->private;
 	int retries = 0;
-	int mode;
 
 	while ((retries++ < 3) && synaptics_reset(psmouse))
 		printk(KERN_ERR "synaptics reset failed\n");
@@ -198,7 +211,14 @@ static int synaptics_query_hardware(stru
 	if (synaptics_capability(psmouse))
 		return -1;
 
-	mode = SYN_BIT_ABSOLUTE_MODE | SYN_BIT_HIGH_RATE;
+	return 0;
+}
+
+static int synaptics_set_mode(struct psmouse *psmouse, int mode)
+{
+	struct synaptics_data *priv = psmouse->private;
+
+	mode |= SYN_BIT_ABSOLUTE_MODE | SYN_BIT_HIGH_RATE;
 	if (SYN_ID_MAJOR(priv->identity) >= 4)
 		mode |= SYN_BIT_DISABLE_GESTURE;
 	if (SYN_CAP_EXTENDED(priv->capabilities))
@@ -255,49 +275,38 @@ static void synaptics_pass_pt_packet(str
 	}
 }
 
-int synaptics_pt_init(struct psmouse *psmouse)
+static void synaptics_pt_activate(struct psmouse *psmouse)
 {
-	struct synaptics_data *priv = psmouse->private;
-	struct serio *port;
-	struct psmouse *child;
+	struct psmouse *child = psmouse->ptport->serio.private;
 
-	if (psmouse->type != PSMOUSE_SYNAPTICS)
-		return -1;
-	if (!SYN_CAP_EXTENDED(priv->capabilities))
-		return -1;
-	if (!SYN_CAP_PASS_THROUGH(priv->capabilities))
-		return -1;
+	/* adjust the touchpad to child's choice of protocol */
+	if (child && child->type >= PSMOUSE_GENPS) {
+		if (synaptics_set_mode(psmouse, SYN_BIT_FOUR_BYTE_CLIENT))
+			printk(KERN_INFO "synaptics: failed to enable 4-byte guest protocol\n");
+	}
+}
+
+static void synaptics_pt_create(struct psmouse *psmouse)
+{
+	struct psmouse_ptport *port;
 
-	priv->ptport = port = kmalloc(sizeof(struct serio), GFP_KERNEL);
+	psmouse->ptport = port = kmalloc(sizeof(struct psmouse_ptport), GFP_KERNEL);
 	if (!port) {
-		printk(KERN_ERR "synaptics: not enough memory to allocate serio port\n");
-		return -1;
+		printk(KERN_ERR "synaptics: not enough memory to allocate pass-through port\n");
+		return;
 	}
 
-	memset(port, 0, sizeof(struct serio));
-	port->type = SERIO_PS_PSTHRU;
-	port->name = "Synaptics pass-through";
-	port->phys = "synaptics-pt/serio0";
-	port->write = synaptics_pt_write;
-	port->open = synaptics_pt_open;
-	port->close = synaptics_pt_close;
-	port->driver = psmouse;
-
-	printk(KERN_INFO "serio: %s port at %s\n", port->name, psmouse->phys);
-	serio_register_slave_port(port);
+	memset(port, 0, sizeof(struct psmouse_ptport));
 
-	/* adjust the touchpad to child's choice of protocol */
-	child = port->private;
-	if (child && child->type >= PSMOUSE_GENPS) {
-		if (synaptics_mode_cmd(psmouse, (SYN_BIT_ABSOLUTE_MODE |
-					 	 SYN_BIT_HIGH_RATE |
-					 	 SYN_BIT_DISABLE_GESTURE |
-						 SYN_BIT_FOUR_BYTE_CLIENT |
-					 	 SYN_BIT_W_MODE)))
-			printk(KERN_INFO "synaptics: failed to enable 4-byte guest protocol\n");
-	}
+	port->serio.type = SERIO_PS_PSTHRU;
+	port->serio.name = "Synaptics pass-through";
+	port->serio.phys = "synaptics-pt/serio0";
+	port->serio.write = synaptics_pt_write;
+	port->serio.open = synaptics_pt_open;
+	port->serio.close = synaptics_pt_close;
+	port->serio.driver = psmouse;
 
-	return 0;
+	port->activate = synaptics_pt_activate;
 }
 
 /*****************************************************************************
@@ -363,26 +372,67 @@ static void set_input_params(struct inpu
 	clear_bit(REL_Y, dev->relbit);
 }
 
+static void synaptics_disconnect(struct psmouse *psmouse)
+{
+	synaptics_mode_cmd(psmouse, 0);
+	kfree(psmouse->private);
+}
+
+static int synaptics_reconnect(struct psmouse *psmouse)
+{
+	struct synaptics_data *priv = psmouse->private;
+	struct synaptics_data old_priv = *priv;
+
+	if (synaptics_detect(psmouse))
+		return -1;
+
+	if (synaptics_query_hardware(psmouse)) {
+		printk(KERN_ERR "Unable to query Synaptics hardware.\n");
+		return -1;
+	}
+
+	if (old_priv.identity != priv->identity ||
+	    old_priv.model_id != priv->model_id ||
+	    old_priv.capabilities != priv->capabilities ||
+    	    old_priv.ext_cap != priv->ext_cap)
+    		return -1;
+
+	if (synaptics_set_mode(psmouse, 0)) {
+		printk(KERN_ERR "Unable to initialize Synaptics hardware.\n");
+		return -1;
+	}
+
+	return 0;
+}
+
 int synaptics_init(struct psmouse *psmouse)
 {
 	struct synaptics_data *priv;
 
-#ifndef CONFIG_MOUSE_PS2_SYNAPTICS
-	return -1;
-#endif
 	psmouse->private = priv = kmalloc(sizeof(struct synaptics_data), GFP_KERNEL);
 	if (!priv)
 		return -1;
 	memset(priv, 0, sizeof(struct synaptics_data));
 
 	if (synaptics_query_hardware(psmouse)) {
-		printk(KERN_ERR "Unable to query/initialize Synaptics hardware.\n");
+		printk(KERN_ERR "Unable to query Synaptics hardware.\n");
+		goto init_fail;
+	}
+
+	if (synaptics_set_mode(psmouse, 0)) {
+		printk(KERN_ERR "Unable to initialize Synaptics hardware.\n");
 		goto init_fail;
 	}
 
+	if (SYN_CAP_EXTENDED(priv->capabilities) && SYN_CAP_PASS_THROUGH(priv->capabilities))
+		synaptics_pt_create(psmouse);
+
 	print_ident(priv);
 	set_input_params(&psmouse->dev, priv);
 
+	psmouse->disconnect = synaptics_disconnect;
+	psmouse->reconnect = synaptics_reconnect;
+
 	return 0;
 
  init_fail:
@@ -390,20 +440,6 @@ int synaptics_init(struct psmouse *psmou
 	return -1;
 }
 
-void synaptics_disconnect(struct psmouse *psmouse)
-{
-	struct synaptics_data *priv = psmouse->private;
-
-	if (psmouse->type == PSMOUSE_SYNAPTICS && priv) {
-		synaptics_mode_cmd(psmouse, 0);
-		if (priv->ptport) {
-			serio_unregister_slave_port(priv->ptport);
-			kfree(priv->ptport);
-		}
-		kfree(priv);
-	}
-}
-
 /*****************************************************************************
  *	Functions to interpret the absolute mode packets
  ****************************************************************************/
@@ -597,8 +633,9 @@ void synaptics_process_byte(struct psmou
 			printk(KERN_NOTICE "Synaptics driver resynced.\n");
 		}
 
-		if (priv->ptport && synaptics_is_pt_packet(psmouse->packet))
-			synaptics_pass_pt_packet(priv->ptport, psmouse->packet);
+		if (psmouse->ptport && psmouse->ptport->serio.dev &&
+		    synaptics_is_pt_packet(psmouse->packet))
+			synaptics_pass_pt_packet(&psmouse->ptport->serio, psmouse->packet);
 		else
 			synaptics_process_packet(psmouse);
 
@@ -612,6 +649,7 @@ void synaptics_process_byte(struct psmou
 	psmouse->pktcnt = 0;
 	if (psmouse_resetafter > 0 && priv->out_of_sync	== psmouse_resetafter) {
 		psmouse->state = PSMOUSE_IGNORE;
-		serio_rescan(psmouse->serio);
+		printk(KERN_NOTICE "synaptics: issuing reconnect request\n");
+		serio_reconnect(psmouse->serio);
 	}
 }
diff -puN drivers/input/mouse/synaptics.h~synaptics-reconnect drivers/input/mouse/synaptics.h
--- linux/drivers/input/mouse/synaptics.h~synaptics-reconnect	2003-08-27 00:39:32.000000000 +0200
+++ linux-petero/drivers/input/mouse/synaptics.h	2003-08-27 00:39:32.000000000 +0200
@@ -12,8 +12,6 @@
 
 extern void synaptics_process_byte(struct psmouse *psmouse, struct pt_regs *regs);
 extern int synaptics_init(struct psmouse *psmouse);
-extern int synaptics_pt_init(struct psmouse *psmouse);
-extern void synaptics_disconnect(struct psmouse *psmouse);
 
 /* synaptics queries */
 #define SYN_QUE_IDENTIFY		0x00
@@ -105,8 +103,6 @@ struct synaptics_data {
 	/* Data for normal processing */
 	unsigned int out_of_sync;		/* # of packets out of sync */
 	int old_w;				/* Previous w value */
-
-	struct serio *ptport;			/* pass-through port */
 };
 
 #endif /* _SYNAPTICS_H */

_

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
