Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264970AbUDUGNf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264970AbUDUGNf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 02:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264993AbUDUGNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 02:13:25 -0400
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:43436 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264970AbUDUGFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 02:05:51 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 14/15] New set of input patches: atkbd reconnect probe
Date: Wed, 21 Apr 2004 01:04:39 -0500
User-Agent: KMail/1.6.1
Cc: Vojtech Pavlik <vojtech@suse.cz>
References: <200404210049.17139.dtor_core@ameritech.net>
In-Reply-To: <200404210049.17139.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404210104.41573.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1915, 2004-04-20 23:59:48-05:00, dtor_core@ameritech.net
  Input: do not modify device's properties when probing for protocol
         extensions on reconnect as it may interfere with reconnect
         process


 logips2pp.c    |  168 ++++++++++++++++++++++++++++++---------------------------
 logips2pp.h    |    5 +
 psmouse-base.c |   78 ++++++++++++++------------
 3 files changed, 137 insertions(+), 114 deletions(-)


===================================================================



diff -Nru a/drivers/input/mouse/logips2pp.c b/drivers/input/mouse/logips2pp.c
--- a/drivers/input/mouse/logips2pp.c	Wed Apr 21 00:06:21 2004
+++ b/drivers/input/mouse/logips2pp.c	Wed Apr 21 00:06:21 2004
@@ -89,7 +89,7 @@
  * enabled if we do nothing to it. Of course I put this in because I want it
  * disabled :P
  * 1 - enabled (if previously disabled, also default)
- * 0/2 - disabled 
+ * 0/2 - disabled
  */
 
 static void ps2pp_set_smartscroll(struct psmouse *psmouse)
@@ -103,14 +103,11 @@
 	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
 	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
 
-	if (psmouse_smartscroll == 1) 
-		param[0] = 1;
-	else
-	if (psmouse_smartscroll > 2)
-		return;
-
-	/* else leave param[0] == 0 to disable */
-	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
+	if (psmouse_smartscroll < 2) {
+		/* 0 - disabled, 1 - enabled */
+		param[0] = psmouse_smartscroll;
+		psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
+	}
 }
 
 /*
@@ -128,111 +125,128 @@
 	psmouse_command(psmouse, &param, PSMOUSE_CMD_SETRES);
 }
 
+
+static int is_model_in_list(unsigned char model, int *model_list)
+{
+	int i;
+
+	for (i = 0; model_list[i] != -1; i++)
+		if (model == model_list[i])
+			return 1;
+	return 0;
+}
+
 /*
- * Detect the exact model and features of a PS2++ or PS2T++ Logitech mouse or
- * touchpad.
+ * Set up input device's properties based on the detected mouse model.
  */
 
-static int ps2pp_detect_model(struct psmouse *psmouse, unsigned char *param)
+static void ps2pp_set_properties(struct psmouse *psmouse, unsigned char protocol,
+				 unsigned char model, unsigned char buttons)
 {
-	int i;
 	static int logitech_4btn[] = { 12, 40, 41, 42, 43, 52, 73, 80, -1 };
 	static int logitech_wheel[] = { 52, 53, 75, 76, 80, 81, 83, 88, 112, -1 };
-	static int logitech_ps2pp[] = { 12, 13, 40, 41, 42, 43, 50, 51, 52, 53, 73, 75,
-						76, 80, 81, 83, 88, 96, 97, 112, -1 };
 	static int logitech_mx[] = { 61, 112, -1 };
 
 	psmouse->vendor = "Logitech";
-	psmouse->model = ((param[0] >> 4) & 0x07) | ((param[0] << 3) & 0x78);
+	psmouse->model = model;
 
-	if (param[1] < 3)
+	if (buttons < 3)
 		clear_bit(BTN_MIDDLE, psmouse->dev.keybit);
-	if (param[1] < 2)
+	if (buttons < 2)
 		clear_bit(BTN_RIGHT, psmouse->dev.keybit);
 
-	psmouse->type = PSMOUSE_PS2;
+	if (protocol == PSMOUSE_PS2PP) {
 
-	for (i = 0; logitech_ps2pp[i] != -1; i++)
-		if (logitech_ps2pp[i] == psmouse->model)
-			psmouse->type = PSMOUSE_PS2PP;
-
-	if (psmouse->type == PSMOUSE_PS2PP) {
-
-		for (i = 0; logitech_4btn[i] != -1; i++)
-			if (logitech_4btn[i] == psmouse->model)
-				set_bit(BTN_SIDE, psmouse->dev.keybit);
-
-		for (i = 0; logitech_wheel[i] != -1; i++)
-			if (logitech_wheel[i] == psmouse->model) {
-				set_bit(REL_WHEEL, psmouse->dev.relbit);
-				psmouse->name = "Wheel Mouse";
-			}
+		if (is_model_in_list(model, logitech_4btn))
+			set_bit(BTN_SIDE, psmouse->dev.keybit);
+
+		if (is_model_in_list(model, logitech_wheel)) {
+			set_bit(REL_WHEEL, psmouse->dev.relbit);
+			psmouse->name = "Wheel Mouse";
+		}
+
+		if (is_model_in_list(model, logitech_mx)) {
+			set_bit(BTN_SIDE, psmouse->dev.keybit);
+			set_bit(BTN_EXTRA, psmouse->dev.keybit);
+			set_bit(BTN_BACK, psmouse->dev.keybit);
+			set_bit(BTN_FORWARD, psmouse->dev.keybit);
+			set_bit(BTN_TASK, psmouse->dev.keybit);
+			psmouse->name = "MX Mouse";
+		}
+	}
+
+	if (protocol == PSMOUSE_PS2TPP) {
+		set_bit(REL_WHEEL, psmouse->dev.relbit);
+		set_bit(REL_HWHEEL, psmouse->dev.relbit);
+		psmouse->name = "TouchPad 3";
+	}
+}
 
-		for (i = 0; logitech_mx[i] != -1; i++)
-			if (logitech_mx[i]  == psmouse->model) {
-				set_bit(BTN_SIDE, psmouse->dev.keybit);
-				set_bit(BTN_EXTRA, psmouse->dev.keybit);
-				set_bit(BTN_BACK, psmouse->dev.keybit);
-				set_bit(BTN_FORWARD, psmouse->dev.keybit);
-				set_bit(BTN_TASK, psmouse->dev.keybit);
-				psmouse->name = "MX Mouse";
-			}
 
 /*
- * Do Logitech PS2++ / PS2T++ magic init.
+ * Logitech magic init. Detect whether the mouse is a Logitech one
+ * and its exact model and try turning on extended protocol for ones
+ * that support it.
  */
 
-		if (psmouse->model == 97) { /* TouchPad 3 */
+int ps2pp_init(struct psmouse *psmouse, int set_properties)
+{
+	static int logitech_ps2pp[] = { 12, 13, 40, 41, 42, 43, 50, 51, 52, 53, 73, 75,
+					76, 80, 81, 83, 88, 96, 97, 112, -1 };
+	unsigned char param[4];
+	unsigned char protocol = PSMOUSE_PS2;
+	unsigned char model, buttons;
 
-			set_bit(REL_WHEEL, psmouse->dev.relbit);
-			set_bit(REL_HWHEEL, psmouse->dev.relbit);
+	param[0] = 0;
+	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
+	psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE11);
+	psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE11);
+	psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE11);
+	param[1] = 0;
+	psmouse_command(psmouse, param, PSMOUSE_CMD_GETINFO);
 
-			param[0] = 0x11; param[1] = 0x04; param[2] = 0x68; /* Unprotect RAM */
+	if (param[1] != 0) {
+		model = ((param[0] >> 4) & 0x07) | ((param[0] << 3) & 0x78);
+		buttons = param[1];
+/*
+ * Do Logitech PS2++ / PS2T++ magic init.
+ */
+		if (model == 97) { /* Touch Pad 3 */
+
+			/* Unprotect RAM */
+			param[0] = 0x11; param[1] = 0x04; param[2] = 0x68;
 			psmouse_command(psmouse, param, 0x30d1);
-			param[0] = 0x11; param[1] = 0x05; param[2] = 0x0b; /* Enable features */
+			/* Enable features */
+			param[0] = 0x11; param[1] = 0x05; param[2] = 0x0b;
 			psmouse_command(psmouse, param, 0x30d1);
-			param[0] = 0x11; param[1] = 0x09; param[2] = 0xc3; /* Enable PS2++ */
+			/* Enable PS2++ */
+			param[0] = 0x11; param[1] = 0x09; param[2] = 0xc3;
 			psmouse_command(psmouse, param, 0x30d1);
 
 			param[0] = 0;
 			if (!psmouse_command(psmouse, param, 0x13d1) &&
-				param[0] == 0x06 && param[1] == 0x00 && param[2] == 0x14) {
-				psmouse->name = "TouchPad 3";
-				return PSMOUSE_PS2TPP;
+			    param[0] == 0x06 && param[1] == 0x00 && param[2] == 0x14) {
+				protocol = PSMOUSE_PS2TPP;
 			}
 
-		} else {
+		} else if (is_model_in_list(model, logitech_ps2pp)) {
 
 			param[0] = param[1] = param[2] = 0;
 			ps2pp_cmd(psmouse, param, 0x39); /* Magic knock */
 			ps2pp_cmd(psmouse, param, 0xDB);
 
-			if ((param[0] & 0x78) == 0x48 && (param[1] & 0xf3) == 0xc2 &&
-				(param[2] & 3) == ((param[1] >> 2) & 3)) {
-					ps2pp_set_smartscroll(psmouse);
-					return PSMOUSE_PS2PP;
+			if ((param[0] & 0x78) == 0x48 &&
+			    (param[1] & 0xf3) == 0xc2 &&
+			    (param[2] & 0x03) == ((param[1] >> 2) & 3)) {
+				ps2pp_set_smartscroll(psmouse);
+				protocol = PSMOUSE_PS2PP;
 			}
 		}
-	}
-
-	return 0;
-}
 
-/*
- * Logitech magic init.
- */
-int ps2pp_detect(struct psmouse *psmouse)
-{
-	unsigned char param[4];
-
-	param[0] = 0;
-	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
-	psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE11);
-	psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE11);
-	psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE11);
-	param[1] = 0;
-	psmouse_command(psmouse, param, PSMOUSE_CMD_GETINFO);
+		if (set_properties)
+			ps2pp_set_properties(psmouse, protocol, model, buttons);
+	}
 
-	return param[1] != 0 ? ps2pp_detect_model(psmouse, param) : 0;
+	return protocol;
 }
 
diff -Nru a/drivers/input/mouse/logips2pp.h b/drivers/input/mouse/logips2pp.h
--- a/drivers/input/mouse/logips2pp.h	Wed Apr 21 00:06:21 2004
+++ b/drivers/input/mouse/logips2pp.h	Wed Apr 21 00:06:21 2004
@@ -10,8 +10,9 @@
 
 #ifndef _LOGIPS2PP_H
 #define _LOGIPS2PP_H
-struct psmouse;
+
 void ps2pp_process_packet(struct psmouse *psmouse);
 void ps2pp_set_800dpi(struct psmouse *psmouse);
-int ps2pp_detect(struct psmouse *psmouse);
+int ps2pp_init(struct psmouse *psmouse, int set_properties);
+
 #endif
diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	Wed Apr 21 00:06:21 2004
+++ b/drivers/input/mouse/psmouse-base.c	Wed Apr 21 00:06:21 2004
@@ -410,22 +410,21 @@
  * the mouse may have.
  */
 
-static int psmouse_extensions(struct psmouse *psmouse, unsigned int max_proto)
+static int psmouse_extensions(struct psmouse *psmouse,
+			      unsigned int max_proto, int set_properties)
 {
 	int synaptics_hardware = 0;
 
-	psmouse->vendor = "Generic";
-	psmouse->name = "Mouse";
-	psmouse->model = 0;
-	psmouse->protocol_handler = psmouse_process_byte;
-
 /*
  * Try Synaptics TouchPad
  */
 	if (max_proto > PSMOUSE_PS2 && synaptics_detect(psmouse)) {
 		synaptics_hardware = 1;
-		psmouse->vendor = "Synaptics";
-		psmouse->name = "TouchPad";
+
+		if (set_properties) {
+			psmouse->vendor = "Synaptics";
+			psmouse->name = "TouchPad";
+		}
 
 		if (max_proto > PSMOUSE_IMEX) {
 			if (synaptics_init(psmouse) == 0)
@@ -444,33 +443,44 @@
 	}
 
 	if (max_proto > PSMOUSE_IMEX && genius_detect(psmouse)) {
-		set_bit(BTN_EXTRA, psmouse->dev.keybit);
-		set_bit(BTN_SIDE, psmouse->dev.keybit);
-		set_bit(REL_WHEEL, psmouse->dev.relbit);
 
-		psmouse->vendor = "Genius";
-		psmouse->name = "Wheel Mouse";
+		if (set_properties) {
+			set_bit(BTN_EXTRA, psmouse->dev.keybit);
+			set_bit(BTN_SIDE, psmouse->dev.keybit);
+			set_bit(REL_WHEEL, psmouse->dev.relbit);
+			psmouse->vendor = "Genius";
+			psmouse->name = "Wheel Mouse";
+		}
+
 		return PSMOUSE_GENPS;
 	}
 
 	if (max_proto > PSMOUSE_IMEX) {
-		int type = ps2pp_detect(psmouse);
-		if (type)
+		int type = ps2pp_init(psmouse, set_properties);
+		if (type > PSMOUSE_PS2)
 			return type;
 	}
 
 	if (max_proto >= PSMOUSE_IMPS && intellimouse_detect(psmouse)) {
-		set_bit(REL_WHEEL, psmouse->dev.relbit);
+
+		if (set_properties) {
+			set_bit(REL_WHEEL, psmouse->dev.relbit);
+			if (!psmouse->name)
+				psmouse->name = "Wheel Mouse";
+		}
 
 		if (max_proto >= PSMOUSE_IMEX && im_explorer_detect(psmouse)) {
-			set_bit(BTN_SIDE, psmouse->dev.keybit);
-			set_bit(BTN_EXTRA, psmouse->dev.keybit);
 
-			psmouse->name = "Explorer Mouse";
+			if (!set_properties) {
+				set_bit(BTN_SIDE, psmouse->dev.keybit);
+				set_bit(BTN_EXTRA, psmouse->dev.keybit);
+				if (!psmouse->name)
+					psmouse->name = "Explorer Mouse";
+			}
+
 			return PSMOUSE_IMEX;
 		}
 
-		psmouse->name = "Wheel Mouse";
 		return PSMOUSE_IMPS;
 	}
 
@@ -520,12 +530,7 @@
 	if (psmouse_command(psmouse, NULL, PSMOUSE_CMD_RESET_DIS))
 		printk(KERN_WARNING "psmouse.c: Failed to reset mouse on %s\n", psmouse->serio->phys);
 
-/*
- * And here we try to determine if it has any extensions over the
- * basic PS/2 3-button mouse.
- */
-
-	return psmouse->type = psmouse_extensions(psmouse, psmouse_max_proto);
+	return 0;
 }
 
 /*
@@ -663,7 +668,6 @@
 	psmouse->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_REL);
 	psmouse->dev.keybit[LONG(BTN_MOUSE)] = BIT(BTN_LEFT) | BIT(BTN_MIDDLE) | BIT(BTN_RIGHT);
 	psmouse->dev.relbit[0] = BIT(REL_X) | BIT(REL_Y);
-
 	psmouse->state = PSMOUSE_CMD_MODE;
 	psmouse->serio = serio;
 	psmouse->dev.private = psmouse;
@@ -675,13 +679,21 @@
 		return;
 	}
 
-	if (psmouse_probe(psmouse) <= 0) {
+	if (psmouse_probe(psmouse) < 0) {
 		serio_close(serio);
 		kfree(psmouse);
 		serio->private = NULL;
 		return;
 	}
 
+	psmouse->type = psmouse_extensions(psmouse, psmouse_max_proto, 1);
+	if (!psmouse->vendor)
+		psmouse->vendor = "Generic";
+	if (!psmouse->name)
+		psmouse->name = "Mouse";
+	if (!psmouse->protocol_handler)
+		psmouse->protocol_handler = psmouse_process_byte;
+
 	sprintf(psmouse->devname, "%s %s %s",
 		psmouse_protocols[psmouse->type], psmouse->vendor, psmouse->name);
 	sprintf(psmouse->phys, "%s/input0",
@@ -715,28 +727,24 @@
 {
 	struct psmouse *psmouse = serio->private;
 	struct serio_dev *dev = serio->dev;
-	int old_type;
 
 	if (!dev || !psmouse) {
 		printk(KERN_DEBUG "psmouse: reconnect request, but serio is disconnected, ignoring...\n");
 		return -1;
 	}
 
-	old_type = psmouse->type;
-
 	psmouse->state = PSMOUSE_CMD_MODE;
-	psmouse->type = psmouse->acking = 0;
-	psmouse->cmdcnt = psmouse->pktcnt = psmouse->out_of_sync = 0;
+	psmouse->acking = psmouse->cmdcnt = psmouse->pktcnt = psmouse->out_of_sync = 0;
 	if (psmouse->reconnect) {
 	       if (psmouse->reconnect(psmouse))
 			return -1;
-	} else if (psmouse_probe(psmouse) != old_type)
+	} else if (psmouse_probe(psmouse) < 0 ||
+		   psmouse->type != psmouse_extensions(psmouse, psmouse_max_proto, 0))
 		return -1;
 
 	/* ok, the device type (and capabilities) match the old one,
 	 * we can continue using it, complete intialization
 	 */
-	psmouse->type = old_type;
 	psmouse_initialize(psmouse);
 
 	if (psmouse->ptport) {
