Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262346AbTHWGfu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 02:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262543AbTHWGft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 02:35:49 -0400
Received: from smtp803.mail.sc5.yahoo.com ([66.163.168.182]:55300 "HELO
	smtp803.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262346AbTHWGcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 02:32:01 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6] Synaptics: support reconnect keeping the same input device
Date: Sat, 23 Aug 2003 01:31:57 -0500
User-Agent: KMail/1.5.1
Cc: Peter Osterlund <petero2@telia.com>, Vojtech Pavlik <vojtech@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200308230131.57111.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the update to the Synaptics touchpad driver. It is supposed to go 
on top of patches form Peter Osterlund site:
(http://w1.894.telia.com/~u89404340/patches/touchpad/2.6.0-test2/v1/)
and on top of 3 serio patches I posted earlier.

The changes are:
1. Support for pass-through port moved from Synaptics driver to psmouse
   itself, it is cleaner and should allow using it in other drivers if
   needed.
2. The driver makes use of new reconnect functionality in serio. It will
   try to keep the same input device after resume or when it resets itself.
3. If mouse is disconnected or other mouse plugged in while sleeping the
   driver should correctly recognize that and create a new serio/input 
   device.

I also have patch against vanilla 2.6.0-test4 incorporating all patches
mentioned above at:
http://www.geocities.com/dt_or/synaptics/synaptics-reconnect-full-2.6.0-t4.patch.gz

Dmitry

diff -urN --exclude-from=/usr/src/exclude 2.6.0-test4/drivers/input/mouse/logips2pp.c linux-2.6.0-test4/drivers/input/mouse/logips2pp.c
--- 2.6.0-test4/drivers/input/mouse/logips2pp.c	2003-07-27 12:04:10.000000000 -0500
+++ linux-2.6.0-test4/drivers/input/mouse/logips2pp.c	2003-08-22 23:57:50.000000000 -0500
@@ -10,6 +10,7 @@
  */
 
 #include <linux/input.h>
+#include <linux/serio.h>
 #include "psmouse.h"
 #include "logips2pp.h"
 
diff -urN --exclude-from=/usr/src/exclude 2.6.0-test4/drivers/input/mouse/psmouse-base.c linux-2.6.0-test4/drivers/input/mouse/psmouse-base.c
--- 2.6.0-test4/drivers/input/mouse/psmouse-base.c	2003-08-23 00:38:14.000000000 -0500
+++ linux-2.6.0-test4/drivers/input/mouse/psmouse-base.c	2003-08-23 00:04:23.000000000 -0500
@@ -138,7 +138,8 @@
 		goto out;
 	}
 
-	if (psmouse->pktcnt && time_after(jiffies, psmouse->last + HZ/2)) {
+	if (psmouse->state == PSMOUSE_ACTIVATED && 
+	    psmouse->pktcnt && time_after(jiffies, psmouse->last + HZ/2)) {
 		printk(KERN_WARNING "psmouse.c: %s at %s lost synchronization, throwing %d bytes away.\n",
 		       psmouse->name, psmouse->phys, psmouse->pktcnt);
 		psmouse->pktcnt = 0;
@@ -272,25 +273,16 @@
 	if (psmouse_noext)
 		return PSMOUSE_PS2;
 
+#if CONFIG_MOUSE_PS2_SYNAPTICS
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
+	if (!synaptics_init(psmouse)) {
 		psmouse->vendor = "Synaptics";
 		psmouse->name = "TouchPad";
-		if (!synaptics_init(psmouse))
-			return PSMOUSE_SYNAPTICS;
-		else
-			return PSMOUSE_PS2;
-       }
+		return PSMOUSE_SYNAPTICS;
+	}
+#endif
 
 /*
  * Try Genius NetMouse magic init.
@@ -506,7 +498,16 @@
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
@@ -519,20 +520,10 @@
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
 
@@ -540,7 +531,6 @@
  * psmouse_connect() is a callback from the serio module when
  * an unhandled serio port is found.
  */
-
 static void psmouse_connect(struct serio *serio, struct serio_dev *dev)
 {
 	struct psmouse *psmouse;
@@ -565,7 +555,6 @@
 	psmouse->dev.private = psmouse;
 
 	serio->private = psmouse;
-
 	if (serio_open(serio, dev)) {
 		kfree(psmouse);
 		return;
@@ -577,10 +566,12 @@
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
@@ -601,14 +592,70 @@
 
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
diff -urN --exclude-from=/usr/src/exclude 2.6.0-test4/drivers/input/mouse/psmouse.h linux-2.6.0-test4/drivers/input/mouse/psmouse.h
--- 2.6.0-test4/drivers/input/mouse/psmouse.h	2003-08-23 00:38:10.000000000 -0500
+++ linux-2.6.0-test4/drivers/input/mouse/psmouse.h	2003-08-22 23:57:50.000000000 -0500
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
diff -urN --exclude-from=/usr/src/exclude 2.6.0-test4/drivers/input/mouse/synaptics.c linux-2.6.0-test4/drivers/input/mouse/synaptics.c
--- 2.6.0-test4/drivers/input/mouse/synaptics.c	2003-08-23 00:38:24.000000000 -0500
+++ linux-2.6.0-test4/drivers/input/mouse/synaptics.c	2003-08-22 23:57:50.000000000 -0500
@@ -69,7 +69,7 @@
 /*
  * Set the synaptics touchpad mode byte by special commands
  */
-static int synaptics_set_mode(struct psmouse *psmouse, unsigned char mode)
+static int synaptics_mode_cmd(struct psmouse *psmouse, unsigned char mode)
 {
 	unsigned char param[1];
 
@@ -96,13 +96,14 @@
  * Read the model-id bytes from the touchpad
  * see also SYN_MODEL_* macros
  */
-static int synaptics_model_id(struct psmouse *psmouse, unsigned long int *model_id)
+static int synaptics_model_id(struct psmouse *psmouse)
 {
+	struct synaptics_data *priv = psmouse->private;
 	unsigned char mi[3];
 
 	if (synaptics_send_cmd(psmouse, SYN_QUE_MODEL, mi))
 		return -1;
-	*model_id = (mi[0]<<16) | (mi[1]<<8) | mi[2];
+	priv->model_id = (mi[0]<<16) | (mi[1]<<8) | mi[2];
 	return 0;
 }
 
@@ -110,23 +111,24 @@
  * Read the capability-bits from the touchpad
  * see also the SYN_CAP_* macros
  */
-static int synaptics_capability(struct psmouse *psmouse, unsigned long int *capability, unsigned long int *ext_cap)
+static int synaptics_capability(struct psmouse *psmouse)
 {
+	struct synaptics_data *priv = psmouse->private;
 	unsigned char cap[3];
 
 	if (synaptics_send_cmd(psmouse, SYN_QUE_CAPABILITIES, cap))
 		return -1;
-	*capability = (cap[0]<<16) | (cap[1]<<8) | cap[2];
-	*ext_cap = 0;
-	if (!SYN_CAP_VALID(*capability))
+	priv->capabilities = (cap[0]<<16) | (cap[1]<<8) | cap[2];
+	priv->ext_cap = 0;
+	if (!SYN_CAP_VALID(priv->capabilities))
 		return -1;
 
-	if (SYN_EXT_CAP_REQUESTS(*capability)) {
+	if (SYN_EXT_CAP_REQUESTS(priv->capabilities)) {
 		if (synaptics_send_cmd(psmouse, SYN_QUE_EXT_CAPAB, cap)) {
 			printk(KERN_ERR "Synaptics claims to have extended capabilities,"
 			       " but I'm not able to read them.");
 		} else
-			*ext_cap = (cap[0]<<16) | (cap[1]<<8) | cap[2];
+			priv->ext_cap = (cap[0]<<16) | (cap[1]<<8) | cap[2];
 	}
 	return 0;
 }
@@ -135,14 +137,15 @@
  * Identify Touchpad
  * See also the SYN_ID_* macros
  */
-static int synaptics_identify(struct psmouse *psmouse, unsigned long int *ident)
+static int synaptics_identify(struct psmouse *psmouse)
 {
+	struct synaptics_data *priv = psmouse->private;
 	unsigned char id[3];
 
 	if (synaptics_send_cmd(psmouse, SYN_QUE_IDENTIFY, id))
 		return -1;
-	*ident = (id[0]<<16) | (id[1]<<8) | id[2];
-	if (SYN_ID_IS_SYNAPTICS(*ident))
+	priv->identity = (id[0]<<16) | (id[1]<<8) | id[2];
+	if (SYN_ID_IS_SYNAPTICS(priv->identity))
 		return 0;
 	return -1;
 }
@@ -178,28 +181,48 @@
 	}
 }
 
-static int query_hardware(struct psmouse *psmouse)
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
+static int synaptics_query_hardware(struct psmouse *psmouse)
 {
-	struct synaptics_data *priv = psmouse->private;
 	int retries = 0;
-	int mode;
 
 	while ((retries++ < 3) && synaptics_reset(psmouse))
 		printk(KERN_ERR "synaptics reset failed\n");
 
-	if (synaptics_identify(psmouse, &priv->identity))
+	if (synaptics_identify(psmouse))
 		return -1;
-	if (synaptics_model_id(psmouse, &priv->model_id))
+	if (synaptics_model_id(psmouse))
 		return -1;
-	if (synaptics_capability(psmouse, &priv->capabilities, &priv->ext_cap))
+	if (synaptics_capability(psmouse))
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
 		mode |= SYN_BIT_W_MODE;
-	if (synaptics_set_mode(psmouse, mode))
+	if (synaptics_mode_cmd(psmouse, mode))
 		return -1;
 
 	return 0;
@@ -251,49 +274,38 @@
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
-	serio_register_slave_port(port);
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
-		if (synaptics_set_mode(psmouse, (SYN_BIT_ABSOLUTE_MODE |
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
@@ -310,86 +322,121 @@
 	set_bit(axis, dev->absbit);
 }
 
-int synaptics_init(struct psmouse *psmouse)
+static void set_input_params(struct input_dev *dev, struct synaptics_data *priv)
 {
-	struct synaptics_data *priv;
-
-#ifndef CONFIG_MOUSE_PS2_SYNAPTICS
-	return -1;
-#endif
-	psmouse->private = priv = kmalloc(sizeof(struct synaptics_data), GFP_KERNEL);
-	if (!priv)
-		return -1;
-	memset(priv, 0, sizeof(struct synaptics_data));
-
-	priv->out_of_sync = 0;
-
-	if (query_hardware(psmouse)) {
-		printk(KERN_ERR "Unable to query/initialize Synaptics hardware.\n");
-		goto init_fail;
-	}
-
-	print_ident(priv);
-
 	/*
 	 * The x/y limits are taken from the Synaptics TouchPad interfacing Guide,
 	 * which says that they should be valid regardless of the actual size of
 	 * the sensor.
 	 */
-	set_bit(EV_ABS, psmouse->dev.evbit);
-	set_abs_params(&psmouse->dev, ABS_X, 1472, 5472, 0, 0);
-	set_abs_params(&psmouse->dev, ABS_Y, 1408, 4448, 0, 0);
-	set_abs_params(&psmouse->dev, ABS_PRESSURE, 0, 255, 0, 0);
-
-	set_bit(EV_MSC, psmouse->dev.evbit);
-	set_bit(MSC_GESTURE, psmouse->dev.mscbit);
-
-	set_bit(EV_KEY, psmouse->dev.evbit);
-	set_bit(BTN_LEFT, psmouse->dev.keybit);
-	set_bit(BTN_RIGHT, psmouse->dev.keybit);
-	set_bit(BTN_FORWARD, psmouse->dev.keybit);
-	set_bit(BTN_BACK, psmouse->dev.keybit);
-	if (SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap))
+	set_bit(EV_ABS, dev->evbit);
+	set_abs_params(dev, ABS_X, 1472, 5472, 0, 0);
+	set_abs_params(dev, ABS_Y, 1408, 4448, 0, 0);
+	set_abs_params(dev, ABS_PRESSURE, 0, 255, 0, 0);
+
+	set_bit(EV_MSC, dev->evbit);
+	set_bit(MSC_GESTURE, dev->mscbit);
+
+	set_bit(EV_KEY, dev->evbit);
+	set_bit(BTN_LEFT, dev->keybit);
+	set_bit(BTN_RIGHT, dev->keybit);
+	set_bit(BTN_FORWARD, dev->keybit);
+	set_bit(BTN_BACK, dev->keybit);
+	if (SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap)) {
 		switch (SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap) & ~0x01) {
 		default:
 			printk(KERN_ERR "This touchpad reports more than 8 multi-buttons, don't know how to handle.\n");
 		case 8:
-			set_bit(BTN_7, psmouse->dev.keybit);
-			set_bit(BTN_6, psmouse->dev.keybit);
+			set_bit(BTN_7, dev->keybit);
+			set_bit(BTN_6, dev->keybit);
 		case 6:
-			set_bit(BTN_5, psmouse->dev.keybit);
-			set_bit(BTN_4, psmouse->dev.keybit);
+			set_bit(BTN_5, dev->keybit);
+			set_bit(BTN_4, dev->keybit);
 		case 4:
-			set_bit(BTN_3, psmouse->dev.keybit);
-			set_bit(BTN_2, psmouse->dev.keybit);
+			set_bit(BTN_3, dev->keybit);
+			set_bit(BTN_2, dev->keybit);
 		case 2:
-			set_bit(BTN_1, psmouse->dev.keybit);
-			set_bit(BTN_0, psmouse->dev.keybit);
+			set_bit(BTN_1, dev->keybit);
+			set_bit(BTN_0, dev->keybit);
 			break;
 		}
-	clear_bit(EV_REL, psmouse->dev.evbit);
-	clear_bit(REL_X, psmouse->dev.relbit);
-	clear_bit(REL_Y, psmouse->dev.relbit);
+	}
 
-	return 0;
+	clear_bit(EV_REL, dev->evbit);
+	clear_bit(REL_X, dev->relbit);
+	clear_bit(REL_Y, dev->relbit);
+}
 
- init_fail:
-	kfree(priv);
-	return -1;
+static void synaptics_disconnect(struct psmouse *psmouse)
+{
+	synaptics_mode_cmd(psmouse, 0);
+	kfree(psmouse->private);
 }
 
-void synaptics_disconnect(struct psmouse *psmouse)
+static int synaptics_reconnect(struct psmouse *psmouse)
 {
 	struct synaptics_data *priv = psmouse->private;
+	struct synaptics_data old_priv = *priv;
 
-	if (psmouse->type == PSMOUSE_SYNAPTICS && priv) {
-		synaptics_set_mode(psmouse, 0);
-		if (priv->ptport) {
-			serio_unregister_slave_port(priv->ptport);
-			kfree(priv->ptport);
-		}
-		kfree(priv);
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
+int synaptics_init(struct psmouse *psmouse)
+{
+	struct synaptics_data *priv;
+
+	if (synaptics_detect(psmouse))
+		return -1;
+	
+	psmouse->private = priv = kmalloc(sizeof(struct synaptics_data), GFP_KERNEL);
+	if (!priv)
+		return -1;
+	
+	memset(priv, 0, sizeof(struct synaptics_data));
+
+	if (synaptics_query_hardware(psmouse)) {
+		printk(KERN_ERR "Unable to query Synaptics hardware.\n");
+		goto init_fail;
 	}
+	
+	if (synaptics_set_mode(psmouse, 0)) {
+		printk(KERN_ERR "Unable to initialize Synaptics hardware.\n");
+		goto init_fail;
+	}
+
+	if (SYN_CAP_EXTENDED(priv->capabilities) && SYN_CAP_PASS_THROUGH(priv->capabilities))
+       		synaptics_pt_create(psmouse);
+	
+	print_ident(priv);
+	set_input_params(&psmouse->dev, priv);
+
+	psmouse->disconnect = synaptics_disconnect;
+	psmouse->reconnect = synaptics_reconnect;
+	
+	return 0;
+
+ init_fail:
+	kfree(priv);
+	return -1;
 }
 
 /*****************************************************************************
@@ -575,8 +622,8 @@
 				printk(KERN_NOTICE "Synaptics driver resynced.\n");
 			}
 
-			if (priv->ptport && synaptics_is_pt_packet(psmouse->packet))
-				synaptics_pass_pt_packet(priv->ptport, psmouse->packet);
+			if (psmouse->ptport->serio.dev && synaptics_is_pt_packet(psmouse->packet))
+				synaptics_pass_pt_packet(&psmouse->ptport->serio, psmouse->packet);
 			else
 				synaptics_process_packet(psmouse);
 
@@ -591,6 +638,7 @@
 	psmouse->pktcnt = 0;
 	if (psmouse_resetafter > 0 && priv->out_of_sync	== psmouse_resetafter) {
 		psmouse->state = PSMOUSE_IGNORE;
-		serio_rescan(psmouse->serio);
+		printk(KERN_NOTICE "synaptics: issuing reconnect request\n");
+		serio_reconnect(psmouse->serio);
 	}
 }
diff -urN --exclude-from=/usr/src/exclude 2.6.0-test4/drivers/input/mouse/synaptics.h linux-2.6.0-test4/drivers/input/mouse/synaptics.h
--- 2.6.0-test4/drivers/input/mouse/synaptics.h	2003-08-23 00:38:10.000000000 -0500
+++ linux-2.6.0-test4/drivers/input/mouse/synaptics.h	2003-08-22 23:58:33.000000000 -0500
@@ -9,11 +9,8 @@
 #ifndef _SYNAPTICS_H
 #define _SYNAPTICS_H
 
-
 extern void synaptics_process_byte(struct psmouse *psmouse, struct pt_regs *regs);
 extern int synaptics_init(struct psmouse *psmouse);
-extern int synaptics_pt_init(struct psmouse *psmouse);
-extern void synaptics_disconnect(struct psmouse *psmouse);
 
 /* synaptics queries */
 #define SYN_QUE_IDENTIFY		0x00
@@ -105,8 +102,6 @@
 	/* Data for normal processing */
 	unsigned int out_of_sync;		/* # of packets out of sync */
 	int old_w;				/* Previous w value */
-	
-	struct serio *ptport;			/* pass-through port */
 };
 
 #endif /* _SYNAPTICS_H */
