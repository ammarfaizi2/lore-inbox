Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263149AbTI3Gal (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 02:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263141AbTI3GaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 02:30:23 -0400
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:104 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S263149AbTI3G2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 02:28:23 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 6/6] Synaptics: use serio_reconnect
Date: Tue, 30 Sep 2003 01:27:22 -0500
User-Agent: KMail/1.5.4
Cc: akpm@osdl.org, petero2@telia.com, linux-kernel@vger.kernel.org
References: <200309300052.49908.dtor_core@ameritech.net> <200309300120.51661.dtor_core@ameritech.net> <200309300123.47737.dtor_core@ameritech.net>
In-Reply-To: <200309300123.47737.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309300127.22384.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input/Synaptics:
  1. Support for pass-through port moved from Synaptics driver to psmouse
     itself, it is cleaner and should allow using it in other drivers if
     needed.
  2. The driver makes use of new reconnect functionality in serio. It will
     try to keep the same input device after resume or when it resets itself.
  3. If mouse is disconnected or other mouse plugged in while sleeping the
     driver should correctly recognize that and create a new serio/input 
     device.


 logips2pp.c    |    1 
 psmouse-base.c |  124 +++++++++++++++++++++++++++++++--------------
 psmouse.h      |   13 ++++
 synaptics.c    |  157 ++++++++++++++++++++++++++++++++++-----------------------
 synaptics.h    |    6 --
 5 files changed, 199 insertions(+), 102 deletions(-)

===================================================================

diff -Nru a/drivers/input/mouse/logips2pp.c b/drivers/input/mouse/logips2pp.c
--- a/drivers/input/mouse/logips2pp.c	Tue Sep 30 01:26:06 2003
+++ b/drivers/input/mouse/logips2pp.c	Tue Sep 30 01:26:06 2003
@@ -10,6 +10,7 @@
  */
 
 #include <linux/input.h>
+#include <linux/serio.h>
 #include "psmouse.h"
 #include "logips2pp.h"
 
diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	Tue Sep 30 01:26:06 2003
+++ b/drivers/input/mouse/psmouse-base.c	Tue Sep 30 01:26:06 2003
@@ -141,7 +141,8 @@
 		goto out;
 	}
 
-	if (psmouse->pktcnt && time_after(jiffies, psmouse->last + HZ/2)) {
+	if (psmouse->state == PSMOUSE_ACTIVATED && 
+	    psmouse->pktcnt && time_after(jiffies, psmouse->last + HZ/2)) {
 		printk(KERN_WARNING "psmouse.c: %s at %s lost synchronization, throwing %d bytes away.\n",
 		       psmouse->name, psmouse->phys, psmouse->pktcnt);
 		psmouse->pktcnt = 0;
@@ -276,24 +277,18 @@
 		return PSMOUSE_PS2;
 
 /*
- * Try Synaptics TouchPad magic ID
+ * Try Synaptics TouchPad
  */
-
-       param[0] = 0;
-       psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
-       psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
-       psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
-       psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
-       psmouse_command(psmouse, param, PSMOUSE_CMD_GETINFO);
-
-       if (param[1] == 0x47) {
+	if (synaptics_detect(psmouse) == 0) {
 		psmouse->vendor = "Synaptics";
 		psmouse->name = "TouchPad";
-		if (!synaptics_init(psmouse))
+
+#if CONFIG_MOUSE_PS2_SYNAPTICS
+		if (synaptics_init(psmouse) == 0)
 			return PSMOUSE_SYNAPTICS;
-		else
-			return PSMOUSE_PS2;
-       }
+#endif
+		return PSMOUSE_PS2;
+	}
 
 /*
  * Try Genius NetMouse magic init.
@@ -519,7 +514,18 @@
 	struct psmouse *psmouse = serio->private;
 
 	psmouse->state = PSMOUSE_IGNORE;
-	synaptics_disconnect(psmouse);
+	
+	if (psmouse->ptport) {
+		if (psmouse->ptport->deactivate)
+			psmouse->ptport->deactivate(psmouse);
+		__serio_unregister_port(&psmouse->ptport->serio); /* we have serio_sem */
+		kfree(psmouse->ptport);
+		psmouse->ptport = NULL;
+	}
+		
+	if (psmouse->disconnect)
+		psmouse->disconnect(psmouse);
+	
 	input_unregister_device(&psmouse->dev);
 	serio_close(serio);
 	kfree(psmouse);
@@ -532,20 +538,10 @@
 static int psmouse_pm_callback(struct pm_dev *dev, pm_request_t request, void *data)
 {
 	struct psmouse *psmouse = dev->data;
-	struct serio_dev *ser_dev = psmouse->serio->dev;
-
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
+	
 	return 0;
 }
 
@@ -553,7 +549,6 @@
  * psmouse_connect() is a callback from the serio module when
  * an unhandled serio port is found.
  */
-
 static void psmouse_connect(struct serio *serio, struct serio_dev *dev)
 {
 	struct psmouse *psmouse;
@@ -578,7 +573,6 @@
 	psmouse->dev.private = psmouse;
 
 	serio->private = psmouse;
-
 	if (serio_open(serio, dev)) {
 		kfree(psmouse);
 		return;
@@ -590,10 +584,12 @@
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
@@ -614,14 +610,70 @@
 
 	psmouse_initialize(psmouse);
 
-	synaptics_pt_init(psmouse);
+	if (psmouse->ptport) {
+		printk(KERN_INFO "serio: %s port at %s\n", psmouse->ptport->serio.name, psmouse->phys);
+		__serio_register_port(&psmouse->ptport->serio); /* we have serio_sem */
+		if (psmouse->ptport->activate)
+			psmouse->ptport->activate(psmouse);
+	}
+	
+	psmouse_activate(psmouse);
+}
+
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
 
+	if (psmouse->ptport) {
+       		if (psmouse_reconnect(&psmouse->ptport->serio)) {
+			__serio_unregister_port(&psmouse->ptport->serio);
+			__serio_register_port(&psmouse->ptport->serio);
+			if (psmouse->ptport->activate)
+				psmouse->ptport->activate(psmouse);
+		}
+	}
+	
 	psmouse_activate(psmouse);
+	return 0;
 }
 
+
 static struct serio_dev psmouse_dev = {
 	.interrupt =	psmouse_interrupt,
 	.connect =	psmouse_connect,
+	.reconnect =	psmouse_reconnect,
 	.disconnect =	psmouse_disconnect,
 	.cleanup =	psmouse_cleanup,
 };
diff -Nru a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
--- a/drivers/input/mouse/psmouse.h	Tue Sep 30 01:26:06 2003
+++ b/drivers/input/mouse/psmouse.h	Tue Sep 30 01:26:06 2003
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
@@ -41,6 +51,9 @@
 	char error;
 	char devname[64];
 	char phys[32];
+	
+	int (*reconnect)(struct psmouse *psmouse);
+	void (*disconnect)(struct psmouse *psmouse);
 };
 
 #define PSMOUSE_PS2		1
diff -Nru a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
--- a/drivers/input/mouse/synaptics.c	Tue Sep 30 01:26:06 2003
+++ b/drivers/input/mouse/synaptics.c	Tue Sep 30 01:26:06 2003
@@ -195,9 +195,7 @@
 
 static int synaptics_query_hardware(struct psmouse *psmouse)
 {
-	struct synaptics_data *priv = psmouse->private;
 	int retries = 0;
-	int mode;
 
 	while ((retries++ < 3) && synaptics_reset(psmouse))
 		printk(KERN_ERR "synaptics reset failed\n");
@@ -208,8 +206,15 @@
 		return -1;
 	if (synaptics_capability(psmouse))
 		return -1;
+	
+	return 0;
+}
 
-	mode = SYN_BIT_ABSOLUTE_MODE | SYN_BIT_HIGH_RATE;
+static int synaptics_set_mode(struct psmouse *psmouse, int mode)
+{
+	struct synaptics_data *priv = psmouse->private;
+
+	mode |= SYN_BIT_ABSOLUTE_MODE | SYN_BIT_HIGH_RATE;
 	if (SYN_ID_MAJOR(priv->identity) >= 4)
 		mode |= SYN_BIT_DISABLE_GESTURE;
 	if (SYN_CAP_EXTENDED(priv->capabilities))
@@ -266,49 +271,38 @@
 	}
 }
 
-int synaptics_pt_init(struct psmouse *psmouse)
+static void synaptics_pt_activate(struct psmouse *psmouse)
 {
-	struct synaptics_data *priv = psmouse->private;
-	struct serio *port;
-	struct psmouse *child;
+	struct psmouse *child = psmouse->ptport->serio.private;
+	
+	/* adjust the touchpad to child's choice of protocol */
+	if (child && child->type >= PSMOUSE_GENPS) {
+		if (synaptics_set_mode(psmouse, SYN_BIT_FOUR_BYTE_CLIENT))
+			printk(KERN_INFO "synaptics: failed to enable 4-byte guest protocol\n");
+	}
+}
 
-	if (psmouse->type != PSMOUSE_SYNAPTICS)
-		return -1;
-	if (!SYN_CAP_EXTENDED(priv->capabilities))
-		return -1;
-	if (!SYN_CAP_PASS_THROUGH(priv->capabilities))
-		return -1;
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
+	memset(port, 0, sizeof(struct psmouse_ptport));
 
-	printk(KERN_INFO "serio: %s port at %s\n", port->name, psmouse->phys);
-	__serio_register_port(port);	/* already have serio_sem */
+	port->serio.type = SERIO_PS_PSTHRU;
+	port->serio.name = "Synaptics pass-through";
+	port->serio.phys = "synaptics-pt/serio0";
+	port->serio.write = synaptics_pt_write;
+	port->serio.open = synaptics_pt_open;
+	port->serio.close = synaptics_pt_close;
+	port->serio.driver = psmouse;
 
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
-
-	return 0;
+	port->activate = synaptics_pt_activate;
 }
 
 /*****************************************************************************
@@ -372,27 +366,82 @@
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
+int synaptics_detect(struct psmouse *psmouse)
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
 int synaptics_init(struct psmouse *psmouse)
 {
 	struct synaptics_data *priv;
 
-#ifndef CONFIG_MOUSE_PS2_SYNAPTICS
-	return -1;
-#endif
-
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
+       		synaptics_pt_create(psmouse);
+	
 	print_ident(priv);
 	set_input_params(&psmouse->dev, priv);
 
+	psmouse->disconnect = synaptics_disconnect;
+	psmouse->reconnect = synaptics_reconnect;
+	
 	return 0;
 
  init_fail:
@@ -400,20 +449,6 @@
 	return -1;
 }
 
-void synaptics_disconnect(struct psmouse *psmouse)
-{
-	struct synaptics_data *priv = psmouse->private;
-
-	if (psmouse->type == PSMOUSE_SYNAPTICS && priv) {
-		synaptics_mode_cmd(psmouse, 0);
-		if (priv->ptport) {
-			__serio_unregister_port(priv->ptport); /* already have serio_sem */
-			kfree(priv->ptport);
-		}
-		kfree(priv);
-	}
-}
-
 /*****************************************************************************
  *	Functions to interpret the absolute mode packets
  ****************************************************************************/
@@ -590,8 +625,8 @@
 			printk(KERN_NOTICE "Synaptics driver resynced.\n");
 		}
 
-		if (priv->ptport && synaptics_is_pt_packet(psmouse->packet))
-			synaptics_pass_pt_packet(priv->ptport, psmouse->packet);
+		if (psmouse->ptport && psmouse->ptport->serio.dev && synaptics_is_pt_packet(psmouse->packet))
+			synaptics_pass_pt_packet(&psmouse->ptport->serio, psmouse->packet);
 		else
 			synaptics_process_packet(psmouse);
 		psmouse->pktcnt = 0;
@@ -601,8 +636,8 @@
 		psmouse->pktcnt = 0;
 		if (++priv->out_of_sync == psmouse_resetafter) {
 			psmouse->state = PSMOUSE_IGNORE;
-			printk(KERN_NOTICE "synaptics: issuing rescan request\n");
-			serio_rescan(psmouse->serio);
+			printk(KERN_NOTICE "synaptics: issuing reconnect request\n");
+			serio_reconnect(psmouse->serio);
 		}
 	}
 }
diff -Nru a/drivers/input/mouse/synaptics.h b/drivers/input/mouse/synaptics.h
--- a/drivers/input/mouse/synaptics.h	Tue Sep 30 01:26:06 2003
+++ b/drivers/input/mouse/synaptics.h	Tue Sep 30 01:26:06 2003
@@ -9,11 +9,9 @@
 #ifndef _SYNAPTICS_H
 #define _SYNAPTICS_H
 
-
 extern void synaptics_process_byte(struct psmouse *psmouse, struct pt_regs *regs);
+extern int synaptics_detect(struct psmouse *psmouse);
 extern int synaptics_init(struct psmouse *psmouse);
-extern int synaptics_pt_init(struct psmouse *psmouse);
-extern void synaptics_disconnect(struct psmouse *psmouse);
 
 /* synaptics queries */
 #define SYN_QUE_IDENTIFY		0x00
@@ -105,8 +103,6 @@
 	/* Data for normal processing */
 	unsigned int out_of_sync;		/* # of packets out of sync */
 	int old_w;				/* Previous w value */
-	
-	struct serio *ptport;			/* pass-through port */
 };
 
 #endif /* _SYNAPTICS_H */

