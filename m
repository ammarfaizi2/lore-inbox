Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262272AbUDTHjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262272AbUDTHjJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 03:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262208AbUDTHjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 03:39:08 -0400
Received: from [194.89.250.117] ([194.89.250.117]:16770 "EHLO
	kimputer.holviala.com") by vger.kernel.org with ESMTP
	id S262272AbUDTHit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 03:38:49 -0400
From: Kim Holviala <kim@holviala.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] psmouse fixes for 2.6.5
Date: Tue, 20 Apr 2004 10:38:46 +0300
User-Agent: KMail/1.6.1
Cc: vojtech@suse.cz
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_GONhA5q7fFVw6I3"
Message-Id: <200404201038.46644.kim@holviala.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_GONhA5q7fFVw6I3
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Some fixes for PS/2 mice:

- fixed hotplugging (real reset of device instead of softreset)
- support for Targus Scroller mice (from my last weeks patch)
- extended protocol probing fixed

The major change is that the probing of extended protocols is now changed to 
be more configurable. Previously the driver probed for all the protocols it 
knew about and stopped when it found one that the mouse accepted. This didn't 
work with a bunch of mice so now you can choose the protocols which are to be 
probed.

In current 2.6.5 the parameter "proto=imps" probes all protocols up to ImPS/2. 
The patch changes this so that "proto=imps" ONLY probes for ImPS/2 and if 
that fails uses regular PS/2. Similarly "proto=ps2pp,genps,exps" probes for 
Logitech, Genius and Intellimouse Expolorer and if none found uses the bare 
PS/2.

To be continued.....



Kim

--Boundary-00=_GONhA5q7fFVw6I3
Content-Type: text/plain;
  charset="us-ascii";
  name="psmouse.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="psmouse.patch"

diff -ruN linux-2.6.5-orig/Documentation/kernel-parameters.txt linux-2.6.5-mouse/Documentation/kernel-parameters.txt
--- linux-2.6.5-orig/Documentation/kernel-parameters.txt	2004-04-04 06:38:27.000000000 +0300
+++ linux-2.6.5-mouse/Documentation/kernel-parameters.txt	2004-04-20 10:03:09.182129723 +0300
@@ -874,8 +874,8 @@
 			before loading.
 			See Documentation/ramdisk.txt.
 
-	psmouse.proto=  [HW,MOUSE] Highest PS2 mouse protocol extension to
-			probe for (bare|imps|exps).
+	psmouse.proto=  [HW,MOUSE] PS2 mouse protocols to probe for (probes all except targus default)
+			{ bare | ps2pp | genps | imps | exps | targus | synaptics }
 	psmouse.rate=	[HW,MOUSE] Set desired mouse report rate, in reports
 			per second.
 	psmouse.resetafter=
diff -ruN linux-2.6.5-orig/drivers/input/mouse/Kconfig linux-2.6.5-mouse/drivers/input/mouse/Kconfig
--- linux-2.6.5-orig/drivers/input/mouse/Kconfig	2004-04-04 06:37:45.000000000 +0300
+++ linux-2.6.5-mouse/drivers/input/mouse/Kconfig	2004-04-08 11:29:01.000000000 +0300
@@ -33,6 +33,9 @@
 	  If you do not want install specialized drivers but want tapping
 	  working please use option psmouse.proto=imps.
 
+	  If you have a Targus Scroller mouse and the scroll wheel moves the
+	  cursor instead of scrolling, use option psmouse.proto=targus.
+
 	  If unsure, say Y.
 
 	  To compile this driver as a module, choose M here: the
diff -ruN linux-2.6.5-orig/drivers/input/mouse/logips2pp.c linux-2.6.5-mouse/drivers/input/mouse/logips2pp.c
--- linux-2.6.5-orig/drivers/input/mouse/logips2pp.c	2004-04-04 06:37:36.000000000 +0300
+++ linux-2.6.5-mouse/drivers/input/mouse/logips2pp.c	2004-04-19 14:28:18.498643867 +0300
@@ -152,6 +152,7 @@
 						76, 80, 81, 83, 88, 96, 97, 112, -1 };
 	static int logitech_mx[] = { 61, 112, -1 };
 
+	psmouse->proto = "PS2++";
 	psmouse->vendor = "Logitech";
 	psmouse->model = ((param[0] >> 4) & 0x07) | ((param[0] << 3) & 0x78);
 
@@ -167,7 +168,6 @@
 			psmouse->type = PSMOUSE_PS2PP;
 
 	if (psmouse->type == PSMOUSE_PS2PP) {
-
 		for (i = 0; logitech_4btn[i] != -1; i++)
 			if (logitech_4btn[i] == psmouse->model)
 				set_bit(BTN_SIDE, psmouse->dev.keybit);
@@ -191,9 +191,7 @@
 /*
  * Do Logitech PS2++ / PS2T++ magic init.
  */
-
 		if (psmouse->model == 97) { /* TouchPad 3 */
-
 			set_bit(REL_WHEEL, psmouse->dev.relbit);
 			set_bit(REL_HWHEEL, psmouse->dev.relbit);
 
@@ -206,19 +204,19 @@
 
 			param[0] = 0;
 			if (!psmouse_command(psmouse, param, 0x13d1) &&
-				param[0] == 0x06 && param[1] == 0x00 && param[2] == 0x14) {
+			     param[0] == 0x06 && param[1] == 0x00 && param[2] == 0x14) {
+				psmouse->proto = "PS2T++";
 				psmouse->name = "TouchPad 3";
 				return PSMOUSE_PS2TPP;
 			}
 
 		} else {
-
 			param[0] = param[1] = param[2] = 0;
 			ps2pp_cmd(psmouse, param, 0x39); /* Magic knock */
 			ps2pp_cmd(psmouse, param, 0xDB);
 
 			if ((param[0] & 0x78) == 0x48 && (param[1] & 0xf3) == 0xc2 &&
-				(param[2] & 3) == ((param[1] >> 2) & 3)) {
+			    (param[2] & 3) == ((param[1] >> 2) & 3)) {
 					ps2pp_set_smartscroll(psmouse);
 					return PSMOUSE_PS2PP;
 			}
diff -ruN linux-2.6.5-orig/drivers/input/mouse/psmouse-base.c linux-2.6.5-mouse/drivers/input/mouse/psmouse-base.c
--- linux-2.6.5-orig/drivers/input/mouse/psmouse-base.c	2004-04-04 06:36:27.000000000 +0300
+++ linux-2.6.5-mouse/drivers/input/mouse/psmouse-base.c	2004-04-20 10:19:17.317528215 +0300
@@ -2,6 +2,7 @@
  * PS/2 mouse driver
  *
  * Copyright (c) 1999-2002 Vojtech Pavlik
+ * Copyright (c) 2004 Kim Holviala
  */
 
 /*
@@ -27,9 +28,9 @@
 MODULE_LICENSE("GPL");
 
 static char *psmouse_proto;
-static unsigned int psmouse_max_proto = -1U;
+static unsigned int psmouse_probe_proto = PSMOUSE_ANY;
 module_param_named(proto, psmouse_proto, charp, 0);
-MODULE_PARM_DESC(proto, "Highest protocol extension to probe (bare, imps, exps). Useful for KVM switches.");
+MODULE_PARM_DESC(proto, "Protocol extensions to probe (bare, ps2pp, genps, imps, exps, targus, synaptics).");
 
 int psmouse_resolution = 200;
 module_param_named(resolution, psmouse_resolution, uint, 0);
@@ -53,7 +54,6 @@
 __obsolete_setup("psmouse_resetafter=");
 __obsolete_setup("psmouse_rate=");
 
-static char *psmouse_protocols[] = { "None", "PS/2", "PS2++", "PS2T++", "GenPS/2", "ImPS/2", "ImExPS/2", "SynPS/2"};
 
 /*
  * psmouse_process_packet() analyzes the PS/2 mouse packet contents and
@@ -70,21 +70,18 @@
 /*
  * The PS2++ protocol is a little bit complex
  */
-
 	if (psmouse->type == PSMOUSE_PS2PP || psmouse->type == PSMOUSE_PS2TPP)
 		ps2pp_process_packet(psmouse);
 
 /*
  * Scroll wheel on IntelliMice, scroll buttons on NetMice
  */
-
 	if (psmouse->type == PSMOUSE_IMPS || psmouse->type == PSMOUSE_GENPS)
 		input_report_rel(dev, REL_WHEEL, -(signed char) packet[3]);
 
 /*
  * Scroll wheel and buttons on IntelliMouse Explorer
  */
-
 	if (psmouse->type == PSMOUSE_IMEX) {
 		input_report_rel(dev, REL_WHEEL, (int) (packet[3] & 8) - (int) (packet[3] & 7));
 		input_report_key(dev, BTN_SIDE, (packet[3] >> 4) & 1);
@@ -94,16 +91,31 @@
 /*
  * Extra buttons on Genius NewNet 3D
  */
-
 	if (psmouse->type == PSMOUSE_GENPS) {
 		input_report_key(dev, BTN_SIDE, (packet[0] >> 6) & 1);
 		input_report_key(dev, BTN_EXTRA, (packet[0] >> 7) & 1);
 	}
 
 /*
- * Generic PS/2 Mouse
+ * Scroll wheel on Targus Scroller
  */
+	if (psmouse->type == PSMOUSE_TARGUS) {
+		if ((packet[2] >> 7) != (packet[0] >> 5)) {
+			input_report_rel(dev, REL_WHEEL, -(signed char) packet[2]);
+			packet[2] = 0;
+		}
 
+		/* Horizontal scrolling - uncomment when hardware becomes available, if ever...
+		if ((packet[1] >> 7) != ((packet[0] >> 4) & 0x01)) {
+			input_report_rel(dev, REL_HWHEEL, -(signed char) packet[1]);
+			packet[1] = 0;
+		}
+		*/
+	}
+
+/*
+ * Generic PS/2 Mouse
+ */
 	input_report_key(dev, BTN_LEFT,    packet[0]       & 1);
 	input_report_key(dev, BTN_MIDDLE, (packet[0] >> 2) & 1);
 	input_report_key(dev, BTN_RIGHT,  (packet[0] >> 1) & 1);
@@ -264,7 +276,6 @@
 			return (psmouse->cmdcnt = 0) - 1;
 
 	while (psmouse->cmdcnt && timeout--) {
-
 		if (psmouse->cmdcnt == 1 && command == PSMOUSE_CMD_RESET_BAT &&
 				timeout > 100000) /* do not run in a endless loop */
 			timeout = 100000; /* 1 sec */
@@ -291,6 +302,7 @@
 /*
  * psmouse_reset() resets the mouse into power-on state.
  */
+
 int psmouse_reset(struct psmouse *psmouse)
 {
 	unsigned char param[2];
@@ -367,6 +379,7 @@
 {
 	int synaptics_hardware = 0;
 
+	psmouse->proto = "PS/2";
 	psmouse->vendor = "Generic";
 	psmouse->name = "Mouse";
 	psmouse->model = 0;
@@ -374,12 +387,13 @@
 /*
  * Try Synaptics TouchPad
  */
-	if (psmouse_max_proto > PSMOUSE_PS2 && synaptics_detect(psmouse)) {
+	if ((psmouse_probe_proto & PSMOUSE_SYNAPTICS) && synaptics_detect(psmouse)) {
 		synaptics_hardware = 1;
+		psmouse->proto = "SynPS/2";
 		psmouse->vendor = "Synaptics";
 		psmouse->name = "TouchPad";
 
-		if (psmouse_max_proto > PSMOUSE_IMEX) {
+		if (psmouse_probe_proto & PSMOUSE_IMEX) {
 			if (synaptics_init(psmouse) == 0)
 				return PSMOUSE_SYNAPTICS;
 /*
@@ -387,7 +401,7 @@
  * Unfortunately Logitech/Genius probes confuse some firmware versions so
  * we'll have to skip them.
  */
-			psmouse_max_proto = PSMOUSE_IMEX;
+			psmouse_probe_proto &= (PSMOUSE_ANY ^ (PSMOUSE_GENPS & PSMOUSE_PS2PP));
 		}
 /*
  * Make sure that touchpad is in relative mode, gestures (taps) are enabled
@@ -395,38 +409,60 @@
 		synaptics_reset(psmouse);
 	}
 
-	if (psmouse_max_proto > PSMOUSE_IMEX && genius_detect(psmouse)) {
+/*
+ * Genius mice
+ */
+	if ((psmouse_probe_proto & PSMOUSE_GENPS) && genius_detect(psmouse)) {
 		set_bit(BTN_EXTRA, psmouse->dev.keybit);
 		set_bit(BTN_SIDE, psmouse->dev.keybit);
 		set_bit(REL_WHEEL, psmouse->dev.relbit);
 
+		psmouse->proto = "GenPS/2";
 		psmouse->vendor = "Genius";
 		psmouse->name = "Wheel Mouse";
 		return PSMOUSE_GENPS;
 	}
 
-	if (psmouse_max_proto > PSMOUSE_IMEX) {
+/*
+ * Logitech mice
+ */
+	if (psmouse_probe_proto & PSMOUSE_PS2PP) {
 		int type = ps2pp_detect(psmouse);
-		if (type)
-			return type;
+		if (type) return type;
 	}
 
-	if (psmouse_max_proto >= PSMOUSE_IMPS && intellimouse_detect(psmouse)) {
+/*
+ * Microsoft Intellimouse and Intellimouse Explorer protocols
+ */
+	if ((psmouse_probe_proto & PSMOUSE_IMPS) && intellimouse_detect(psmouse)) {
 		set_bit(REL_WHEEL, psmouse->dev.relbit);
 
-		if (psmouse_max_proto >= PSMOUSE_IMEX &&
-					im_explorer_detect(psmouse)) {
-			set_bit(BTN_SIDE, psmouse->dev.keybit);
-			set_bit(BTN_EXTRA, psmouse->dev.keybit);
-
-			psmouse->name = "Explorer Mouse";
-			return PSMOUSE_IMEX;
-		}
-
+		psmouse->proto = "ImPS/2";
 		psmouse->name = "Wheel Mouse";
 		return PSMOUSE_IMPS;
 	}
 
+	if ((psmouse_probe_proto & PSMOUSE_IMEX) && im_explorer_detect(psmouse)) {
+		set_bit(REL_WHEEL, psmouse->dev.relbit);
+		set_bit(BTN_SIDE, psmouse->dev.keybit);
+		set_bit(BTN_EXTRA, psmouse->dev.keybit);
+
+		psmouse->proto = "ExPS/2";
+		psmouse->name = "Explorer Mouse";
+		return PSMOUSE_IMEX;
+	}
+
+/*
+ * Targus Scroller mice can't be detected so proto has to be explicitly enabled
+ */
+	if (psmouse_probe_proto & PSMOUSE_TARGUS) {
+		psmouse->vendor = "Targus";
+		psmouse->name = "Scroller Mouse";
+		set_bit(REL_WHEEL, psmouse->dev.relbit);
+
+		return PSMOUSE_TARGUS;
+	}
+
 /*
  * Okay, all failed, we have a standard mouse here. The number of the buttons
  * is still a question, though. We assume 3.
@@ -457,7 +493,6 @@
  * First, we check if it's a mouse. It should send 0x00 or 0x03
  * in case of an IntelliMouse in 4-byte mode or 0x04 for IM Explorer.
  */
-
 	param[0] = 0xa5;
 
 	if (psmouse_command(psmouse, param, PSMOUSE_CMD_GETID))
@@ -469,15 +504,13 @@
 /*
  * Then we reset and disable the mouse so that it doesn't generate events.
  */
-
-	if (psmouse_command(psmouse, NULL, PSMOUSE_CMD_RESET_DIS))
+	if (psmouse_reset(psmouse))
 		printk(KERN_WARNING "psmouse.c: Failed to reset mouse on %s\n", psmouse->serio->phys);
 
 /*
  * And here we try to determine if it has any extensions over the
  * basic PS/2 3-button mouse.
  */
-
 	return psmouse->type = psmouse_extensions(psmouse);
 }
 
@@ -530,8 +563,7 @@
 /*
  * We set the mouse report rate, resolution and scaling.
  */
-
-	if (psmouse_max_proto != PSMOUSE_PS2) {
+	if (psmouse_probe_proto != PSMOUSE_PS2) {
 		psmouse_set_rate(psmouse);
 		psmouse_set_resolution(psmouse);
 		psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE11);
@@ -540,7 +572,6 @@
 /*
  * We set the mouse into streaming mode.
  */
-
 	psmouse_command(psmouse, param, PSMOUSE_CMD_SETSTREAM);
 }
 
@@ -636,7 +667,7 @@
 	}
 
 	sprintf(psmouse->devname, "%s %s %s",
-		psmouse_protocols[psmouse->type], psmouse->vendor, psmouse->name);
+		psmouse->proto, psmouse->vendor, psmouse->name);
 	sprintf(psmouse->phys, "%s/input0",
 		serio->phys);
 
@@ -716,14 +747,18 @@
 static inline void psmouse_parse_proto(void)
 {
 	if (psmouse_proto) {
-		if (!strcmp(psmouse_proto, "bare"))
-			psmouse_max_proto = PSMOUSE_PS2;
-		else if (!strcmp(psmouse_proto, "imps"))
-			psmouse_max_proto = PSMOUSE_IMPS;
-		else if (!strcmp(psmouse_proto, "exps"))
-			psmouse_max_proto = PSMOUSE_IMEX;
-		else
-			printk(KERN_ERR "psmouse: unknown protocol type '%s'\n", psmouse_proto);
+		psmouse_probe_proto = 0;
+
+		if (strstr(psmouse_proto, "bare")) psmouse_probe_proto |= PSMOUSE_PS2;
+		if (strstr(psmouse_proto, "targus")) psmouse_probe_proto |= PSMOUSE_TARGUS;
+		if (strstr(psmouse_proto, "ps2pp")) psmouse_probe_proto |= PSMOUSE_PS2PP;
+		if (strstr(psmouse_proto, "genps")) psmouse_probe_proto |= PSMOUSE_GENPS;
+		if (strstr(psmouse_proto, "imps")) psmouse_probe_proto |= PSMOUSE_IMPS;
+		if (strstr(psmouse_proto, "exps")) psmouse_probe_proto |= PSMOUSE_IMEX;
+		if (strstr(psmouse_proto, "synaptics")) psmouse_probe_proto |= PSMOUSE_IMEX;
+
+		if (!psmouse_probe_proto)
+			printk(KERN_ERR "psmouse: '%s' contains no valid protocols\n", psmouse_proto);
 	}
 }
 
diff -ruN linux-2.6.5-orig/drivers/input/mouse/psmouse.h linux-2.6.5-mouse/drivers/input/mouse/psmouse.h
--- linux-2.6.5-orig/drivers/input/mouse/psmouse.h	2004-04-04 06:38:13.000000000 +0300
+++ linux-2.6.5-mouse/drivers/input/mouse/psmouse.h	2004-04-19 14:17:07.623109614 +0300
@@ -36,6 +36,7 @@
 	struct input_dev dev;
 	struct serio *serio;
 	struct psmouse_ptport *ptport;
+	char *proto;
 	char *vendor;
 	char *name;
 	unsigned char cmdbuf[8];
@@ -56,13 +57,15 @@
 	void (*disconnect)(struct psmouse *psmouse);
 };
 
-#define PSMOUSE_PS2		1
-#define PSMOUSE_PS2PP		2
-#define PSMOUSE_PS2TPP		3
-#define PSMOUSE_GENPS		4
-#define PSMOUSE_IMPS		5
-#define PSMOUSE_IMEX		6
-#define PSMOUSE_SYNAPTICS 	7
+#define PSMOUSE_ANY		0xFFFF
+#define PSMOUSE_PS2		0x0001
+#define PSMOUSE_TARGUS		0x0002
+#define PSMOUSE_PS2PP		0x0004
+#define PSMOUSE_PS2TPP		0x0008
+#define PSMOUSE_GENPS		0x0010
+#define PSMOUSE_IMPS		0x0020
+#define PSMOUSE_IMEX		0x0040
+#define PSMOUSE_SYNAPTICS 	0x0080
 
 int psmouse_command(struct psmouse *psmouse, unsigned char *param, int command);
 int psmouse_reset(struct psmouse *psmouse);

--Boundary-00=_GONhA5q7fFVw6I3--
