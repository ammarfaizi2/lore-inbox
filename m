Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265054AbUDUGQ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265054AbUDUGQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 02:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264975AbUDUGLF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 02:11:05 -0400
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:41388 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264991AbUDUGFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 02:05:49 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 12/15] New set of input patches: psmouse add protocol_handler
Date: Wed, 21 Apr 2004 01:01:59 -0500
User-Agent: KMail/1.6.1
Cc: Vojtech Pavlik <vojtech@suse.cz>
References: <200404210049.17139.dtor_core@ameritech.net>
In-Reply-To: <200404210049.17139.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404210102.01783.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1913, 2004-04-20 22:41:52-05:00, dtor_core@ameritech.net
  Input: add protocol_handler to psmouse structure to ease adding
         new protocols to psmouse module


 psmouse-base.c |    4 
 psmouse.h      |    1 
 synaptics.c    |  285 ++++++++++++++++++++++++++++-----------------------------
 synaptics.h    |    1 
 4 files changed, 147 insertions(+), 144 deletions(-)


===================================================================



diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	Tue Apr 20 23:12:01 2004
+++ b/drivers/input/mouse/psmouse-base.c	Tue Apr 20 23:12:01 2004
@@ -203,8 +203,7 @@
 		}
 	}
 
-	rc = psmouse->type == PSMOUSE_SYNAPTICS ?
-		synaptics_process_byte(psmouse, regs) : psmouse_process_byte(psmouse, regs);
+	rc = psmouse->protocol_handler(psmouse, regs);
 
 	switch (rc) {
 		case PSMOUSE_BAD_DATA:
@@ -394,6 +393,7 @@
 	psmouse->vendor = "Generic";
 	psmouse->name = "Mouse";
 	psmouse->model = 0;
+	psmouse->protocol_handler = psmouse_process_byte;
 
 /*
  * Try Synaptics TouchPad
diff -Nru a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
--- a/drivers/input/mouse/psmouse.h	Tue Apr 20 23:12:01 2004
+++ b/drivers/input/mouse/psmouse.h	Tue Apr 20 23:12:01 2004
@@ -60,6 +60,7 @@
 	char devname[64];
 	char phys[32];
 
+	psmouse_ret_t (*protocol_handler)(struct psmouse *psmouse, struct pt_regs *regs); 
 	int (*reconnect)(struct psmouse *psmouse);
 	void (*disconnect)(struct psmouse *psmouse);
 };
diff -Nru a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
--- a/drivers/input/mouse/synaptics.c	Tue Apr 20 23:12:01 2004
+++ b/drivers/input/mouse/synaptics.c	Tue Apr 20 23:12:01 2004
@@ -312,146 +312,6 @@
 }
 
 /*****************************************************************************
- *	Driver initialization/cleanup functions
- ****************************************************************************/
-
-static inline void set_abs_params(struct input_dev *dev, int axis, int min, int max, int fuzz, int flat)
-{
-	dev->absmin[axis] = min;
-	dev->absmax[axis] = max;
-	dev->absfuzz[axis] = fuzz;
-	dev->absflat[axis] = flat;
-
-	set_bit(axis, dev->absbit);
-}
-
-static void set_input_params(struct input_dev *dev, struct synaptics_data *priv)
-{
-	int i;
-
-	set_bit(EV_ABS, dev->evbit);
-	set_abs_params(dev, ABS_X, XMIN_NOMINAL, XMAX_NOMINAL, 0, 0);
-	set_abs_params(dev, ABS_Y, YMIN_NOMINAL, YMAX_NOMINAL, 0, 0);
-	set_abs_params(dev, ABS_PRESSURE, 0, 255, 0, 0);
-	set_bit(ABS_TOOL_WIDTH, dev->absbit);
-
-	set_bit(EV_KEY, dev->evbit);
-	set_bit(BTN_TOUCH, dev->keybit);
-	set_bit(BTN_TOOL_FINGER, dev->keybit);
-	set_bit(BTN_TOOL_DOUBLETAP, dev->keybit);
-	set_bit(BTN_TOOL_TRIPLETAP, dev->keybit);
-
-	set_bit(BTN_LEFT, dev->keybit);
-	set_bit(BTN_RIGHT, dev->keybit);
-
-	if (SYN_CAP_MIDDLE_BUTTON(priv->capabilities))
-		set_bit(BTN_MIDDLE, dev->keybit);
-
-	if (SYN_CAP_FOUR_BUTTON(priv->capabilities)) {
-		set_bit(BTN_FORWARD, dev->keybit);
-		set_bit(BTN_BACK, dev->keybit);
-	}
-
-	for (i = 0; i < SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap); i++)
-		set_bit(BTN_0 + i, dev->keybit);
-
-	clear_bit(EV_REL, dev->evbit);
-	clear_bit(REL_X, dev->relbit);
-	clear_bit(REL_Y, dev->relbit);
-}
-
-void synaptics_reset(struct psmouse *psmouse)
-{
-	/* reset touchpad back to relative mode, gestures enabled */
-	synaptics_mode_cmd(psmouse, 0);
-}
-
-static void synaptics_disconnect(struct psmouse *psmouse)
-{
-	synaptics_reset(psmouse);
-	kfree(psmouse->private);
-}
-
-static int synaptics_reconnect(struct psmouse *psmouse)
-{
-	struct synaptics_data *priv = psmouse->private;
-	struct synaptics_data old_priv = *priv;
-
-	if (!synaptics_detect(psmouse))
-		return -1;
-
-	if (synaptics_query_hardware(psmouse)) {
-		printk(KERN_ERR "Unable to query Synaptics hardware.\n");
-		return -1;
-	}
-
-	if (old_priv.identity != priv->identity ||
-	    old_priv.model_id != priv->model_id ||
-	    old_priv.capabilities != priv->capabilities ||
-	    old_priv.ext_cap != priv->ext_cap)
-		return -1;
-
-	if (synaptics_set_mode(psmouse, 0)) {
-		printk(KERN_ERR "Unable to initialize Synaptics hardware.\n");
-		return -1;
-	}
-
-	return 0;
-}
-
-int synaptics_detect(struct psmouse *psmouse)
-{
-	unsigned char param[4];
-
-	param[0] = 0;
-
-	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
-	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
-	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
-	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
-	psmouse_command(psmouse, param, PSMOUSE_CMD_GETINFO);
-
-	return param[1] == 0x47;
-}
-
-int synaptics_init(struct psmouse *psmouse)
-{
-	struct synaptics_data *priv;
-
-	psmouse->private = priv = kmalloc(sizeof(struct synaptics_data), GFP_KERNEL);
-	if (!priv)
-		return -1;
-	memset(priv, 0, sizeof(struct synaptics_data));
-
-	if (synaptics_query_hardware(psmouse)) {
-		printk(KERN_ERR "Unable to query Synaptics hardware.\n");
-		goto init_fail;
-	}
-
-	if (synaptics_set_mode(psmouse, 0)) {
-		printk(KERN_ERR "Unable to initialize Synaptics hardware.\n");
-		goto init_fail;
-	}
-
-	priv->pkt_type = SYN_MODEL_NEWABS(priv->model_id) ? SYN_NEWABS : SYN_OLDABS;
-
-	if (SYN_CAP_PASS_THROUGH(priv->capabilities))
-		synaptics_pt_create(psmouse);
-
-	print_ident(priv);
-	set_input_params(&psmouse->dev, priv);
-
-	psmouse->disconnect = synaptics_disconnect;
-	psmouse->reconnect = synaptics_reconnect;
-
-	return 0;
-
- init_fail:
-	kfree(priv);
-	return -1;
-}
-
-/*****************************************************************************
  *	Functions to interpret the absolute mode packets
  ****************************************************************************/
 
@@ -632,7 +492,7 @@
 	return SYN_NEWABS_STRICT;
 }
 
-psmouse_ret_t synaptics_process_byte(struct psmouse *psmouse, struct pt_regs *regs)
+static psmouse_ret_t synaptics_process_byte(struct psmouse *psmouse, struct pt_regs *regs)
 {
 	struct input_dev *dev = &psmouse->dev;
 	struct synaptics_data *priv = psmouse->private;
@@ -654,3 +514,146 @@
 	return synaptics_validate_byte(psmouse->packet, psmouse->pktcnt - 1, priv->pkt_type) ?
 		PSMOUSE_GOOD_DATA : PSMOUSE_BAD_DATA;
 }
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
+static void set_input_params(struct input_dev *dev, struct synaptics_data *priv)
+{
+	int i;
+
+	set_bit(EV_ABS, dev->evbit);
+	set_abs_params(dev, ABS_X, XMIN_NOMINAL, XMAX_NOMINAL, 0, 0);
+	set_abs_params(dev, ABS_Y, YMIN_NOMINAL, YMAX_NOMINAL, 0, 0);
+	set_abs_params(dev, ABS_PRESSURE, 0, 255, 0, 0);
+	set_bit(ABS_TOOL_WIDTH, dev->absbit);
+
+	set_bit(EV_KEY, dev->evbit);
+	set_bit(BTN_TOUCH, dev->keybit);
+	set_bit(BTN_TOOL_FINGER, dev->keybit);
+	set_bit(BTN_TOOL_DOUBLETAP, dev->keybit);
+	set_bit(BTN_TOOL_TRIPLETAP, dev->keybit);
+
+	set_bit(BTN_LEFT, dev->keybit);
+	set_bit(BTN_RIGHT, dev->keybit);
+
+	if (SYN_CAP_MIDDLE_BUTTON(priv->capabilities))
+		set_bit(BTN_MIDDLE, dev->keybit);
+
+	if (SYN_CAP_FOUR_BUTTON(priv->capabilities)) {
+		set_bit(BTN_FORWARD, dev->keybit);
+		set_bit(BTN_BACK, dev->keybit);
+	}
+
+	for (i = 0; i < SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap); i++)
+		set_bit(BTN_0 + i, dev->keybit);
+
+	clear_bit(EV_REL, dev->evbit);
+	clear_bit(REL_X, dev->relbit);
+	clear_bit(REL_Y, dev->relbit);
+}
+
+void synaptics_reset(struct psmouse *psmouse)
+{
+	/* reset touchpad back to relative mode, gestures enabled */
+	synaptics_mode_cmd(psmouse, 0);
+}
+
+static void synaptics_disconnect(struct psmouse *psmouse)
+{
+	synaptics_reset(psmouse);
+	kfree(psmouse->private);
+}
+
+static int synaptics_reconnect(struct psmouse *psmouse)
+{
+	struct synaptics_data *priv = psmouse->private;
+	struct synaptics_data old_priv = *priv;
+
+	if (!synaptics_detect(psmouse))
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
+	    old_priv.ext_cap != priv->ext_cap)
+		return -1;
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
+	return param[1] == 0x47;
+}
+
+int synaptics_init(struct psmouse *psmouse)
+{
+	struct synaptics_data *priv;
+
+	psmouse->private = priv = kmalloc(sizeof(struct synaptics_data), GFP_KERNEL);
+	if (!priv)
+		return -1;
+	memset(priv, 0, sizeof(struct synaptics_data));
+
+	if (synaptics_query_hardware(psmouse)) {
+		printk(KERN_ERR "Unable to query Synaptics hardware.\n");
+		goto init_fail;
+	}
+
+	if (synaptics_set_mode(psmouse, 0)) {
+		printk(KERN_ERR "Unable to initialize Synaptics hardware.\n");
+		goto init_fail;
+	}
+
+	priv->pkt_type = SYN_MODEL_NEWABS(priv->model_id) ? SYN_NEWABS : SYN_OLDABS;
+
+	if (SYN_CAP_PASS_THROUGH(priv->capabilities))
+		synaptics_pt_create(psmouse);
+
+	print_ident(priv);
+	set_input_params(&psmouse->dev, priv);
+
+	psmouse->protocol_handler = synaptics_process_byte;
+	psmouse->disconnect = synaptics_disconnect;
+	psmouse->reconnect = synaptics_reconnect;
+
+	return 0;
+
+ init_fail:
+	kfree(priv);
+	return -1;
+}
+
+
diff -Nru a/drivers/input/mouse/synaptics.h b/drivers/input/mouse/synaptics.h
--- a/drivers/input/mouse/synaptics.h	Tue Apr 20 23:12:01 2004
+++ b/drivers/input/mouse/synaptics.h	Tue Apr 20 23:12:01 2004
@@ -9,7 +9,6 @@
 #ifndef _SYNAPTICS_H
 #define _SYNAPTICS_H
 
-extern psmouse_ret_t synaptics_process_byte(struct psmouse *psmouse, struct pt_regs *regs);
 extern int synaptics_detect(struct psmouse *psmouse);
 extern int synaptics_init(struct psmouse *psmouse);
 extern void synaptics_reset(struct psmouse *psmouse);
