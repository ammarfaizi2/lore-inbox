Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268246AbUI2GzP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268246AbUI2GzP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 02:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268240AbUI2GyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 02:54:10 -0400
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:39534 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268246AbUI2GsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 02:48:06 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH 7/8] Psmouse - add packet size
Date: Wed, 29 Sep 2004 01:47:34 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200409290140.53350.dtor_core@ameritech.net> <200409290145.39919.dtor_core@ameritech.net> <200409290146.38929.dtor_core@ameritech.net>
In-Reply-To: <200409290146.38929.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409290147.35864.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1954, 2004-09-29 01:07:29-05:00, dtor_core@ameritech.net
  Input: psmouse - explicitely specify packet size instead of relying
         on protocol numbering scheme. Make protocol detection routines
         set mouse parameters by themselves instead of doing it in
         psmouse_extensions.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 alps.c         |   12 +++-
 alps.h         |    2 
 logips2pp.c    |    1 
 psmouse-base.c |  149 +++++++++++++++++++++++++++++----------------------------
 psmouse.h      |    1 
 synaptics.c    |   14 ++++-
 synaptics.h    |    2 
 7 files changed, 101 insertions(+), 80 deletions(-)


===================================================================



diff -Nru a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
--- a/drivers/input/mouse/alps.c	2004-09-29 01:25:12 -05:00
+++ b/drivers/input/mouse/alps.c	2004-09-29 01:25:12 -05:00
@@ -405,12 +405,20 @@
 	psmouse->protocol_handler = alps_process_byte;
 	psmouse->disconnect = alps_disconnect;
 	psmouse->reconnect = alps_reconnect;
+	psmouse->pktsize = 6;
 
 	return 0;
 }
 
-int alps_detect(struct psmouse *psmouse)
+int alps_detect(struct psmouse *psmouse, int set_properties)
 {
-	return alps_get_model(psmouse) < 0 ? 0 : 1;
+	if (alps_get_model(psmouse) < 0)
+		return 0;
+
+	if (set_properties) {
+		psmouse->vendor = "ALPS";
+		psmouse->name = "TouchPad";
+	}
+	return 1;
 }
 
diff -Nru a/drivers/input/mouse/alps.h b/drivers/input/mouse/alps.h
--- a/drivers/input/mouse/alps.h	2004-09-29 01:25:12 -05:00
+++ b/drivers/input/mouse/alps.h	2004-09-29 01:25:12 -05:00
@@ -11,7 +11,7 @@
 #ifndef _ALPS_H
 #define _ALPS_H
 
-int alps_detect(struct psmouse *psmouse);
+int alps_detect(struct psmouse *psmouse, int set_properties);
 int alps_init(struct psmouse *psmouse);
 
 #endif
diff -Nru a/drivers/input/mouse/logips2pp.c b/drivers/input/mouse/logips2pp.c
--- a/drivers/input/mouse/logips2pp.c	2004-09-29 01:25:12 -05:00
+++ b/drivers/input/mouse/logips2pp.c	2004-09-29 01:25:12 -05:00
@@ -355,6 +355,7 @@
 
 		if (use_ps2pp) {
 			psmouse->protocol_handler = ps2pp_process_byte;
+			psmouse->pktsize = 3;
 
 			if (model_info->kind != PS2PP_KIND_TP3) {
 				psmouse->set_resolution = ps2pp_set_resolution;
diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	2004-09-29 01:25:12 -05:00
+++ b/drivers/input/mouse/psmouse-base.c	2004-09-29 01:25:12 -05:00
@@ -74,7 +74,7 @@
 	struct input_dev *dev = &psmouse->dev;
 	unsigned char *packet = psmouse->packet;
 
-	if (psmouse->pktcnt < 3 + (psmouse->type >= PSMOUSE_GENPS))
+	if (psmouse->pktcnt < psmouse->pktsize)
 		return PSMOUSE_GOOD_DATA;
 
 /*
@@ -274,7 +274,7 @@
 /*
  * Genius NetMouse magic init.
  */
-static int genius_detect(struct psmouse *psmouse)
+static int genius_detect(struct psmouse *psmouse, int set_properties)
 {
 	struct ps2dev *ps2dev = &psmouse->ps2dev;
 	unsigned char param[4];
@@ -286,13 +286,24 @@
 	ps2_command(ps2dev,  NULL, PSMOUSE_CMD_SETSCALE11);
 	ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO);
 
-	return param[0] == 0x00 && param[1] == 0x33 && param[2] == 0x55;
+	if (param[0] == 0x00 && param[1] == 0x33 && param[2] == 0x55) {
+		if (set_properties) {
+			set_bit(BTN_EXTRA, psmouse->dev.keybit);
+			set_bit(BTN_SIDE, psmouse->dev.keybit);
+			set_bit(REL_WHEEL, psmouse->dev.relbit);
+
+			psmouse->vendor = "Genius";
+			psmouse->name = "Wheel Mouse";
+			psmouse->pktsize = 4;
+		}
+	}
+	return 0;
 }
 
 /*
  * IntelliMouse magic init.
  */
-static int intellimouse_detect(struct psmouse *psmouse)
+static int intellimouse_detect(struct psmouse *psmouse, int set_properties)
 {
 	struct ps2dev *ps2dev = &psmouse->ps2dev;
 	unsigned char param[2];
@@ -305,18 +316,28 @@
 	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRATE);
 	ps2_command(ps2dev, param, PSMOUSE_CMD_GETID);
 
-	return param[0] == 3;
+	if (param[0] == 3) {
+		if (set_properties) {
+			set_bit(REL_WHEEL, psmouse->dev.relbit);
+
+			if (!psmouse->vendor) psmouse->vendor = "Generic";
+			if (!psmouse->name) psmouse->name = "Wheel Mouse";
+			psmouse->pktsize = 4;
+		}
+		return 1;
+	}
+	return 0;
 }
 
 /*
  * Try IntelliMouse/Explorer magic init.
  */
-static int im_explorer_detect(struct psmouse *psmouse)
+static int im_explorer_detect(struct psmouse *psmouse, int set_properties)
 {
 	struct ps2dev *ps2dev = &psmouse->ps2dev;
 	unsigned char param[2];
 
-	intellimouse_detect(psmouse);
+	intellimouse_detect(psmouse, 0);
 
 	param[0] = 200;
 	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRATE);
@@ -326,13 +347,25 @@
 	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRATE);
 	ps2_command(ps2dev, param, PSMOUSE_CMD_GETID);
 
-	return param[0] == 4;
+	if (param[0] == 4) {
+		if (set_properties) {
+			set_bit(REL_WHEEL, psmouse->dev.relbit);
+			set_bit(BTN_SIDE, psmouse->dev.keybit);
+			set_bit(BTN_EXTRA, psmouse->dev.keybit);
+
+			if (!psmouse->vendor) psmouse->vendor = "Generic";
+			if (!psmouse->name) psmouse->name = "Explorer Mouse";
+			psmouse->pktsize = 4;
+		}
+		return 1;
+	}
+	return 0;
 }
 
 /*
  * Kensington ThinkingMouse / ExpertMouse magic init.
  */
-static int thinking_detect(struct psmouse *psmouse)
+static int thinking_detect(struct psmouse *psmouse, int set_properties)
 {
 	struct ps2dev *ps2dev = &psmouse->ps2dev;
 	unsigned char param[2];
@@ -347,7 +380,27 @@
 		ps2_command(ps2dev, seq + i, PSMOUSE_CMD_SETRATE);
 	ps2_command(ps2dev, param, PSMOUSE_CMD_GETID);
 
-	return param[0] == 2;
+	if (param[0] == 2) {
+		if (set_properties) {
+			set_bit(BTN_EXTRA, psmouse->dev.keybit);
+
+			psmouse->vendor = "Kensington";
+			psmouse->name = "ThinkingMouse";
+		}
+		return 1;
+	}
+	return 0;
+}
+
+/*
+ * Bare PS/2 protocol "detection". Always succeeds.
+ */
+static int ps2bare_detect(struct psmouse *psmouse, int set_properties)
+{
+	if (!psmouse->vendor) psmouse->vendor = "Generic";
+	if (!psmouse->name) psmouse->name = "Mouse";
+
+	return 1;
 }
 
 /*
@@ -365,28 +418,15 @@
  * upsets the thinkingmouse).
  */
 
-	if (max_proto > PSMOUSE_PS2 && thinking_detect(psmouse)) {
-
-		if (set_properties) {
-			set_bit(BTN_EXTRA, psmouse->dev.keybit);
-			psmouse->vendor = "Kensington";
-			psmouse->name = "ThinkingMouse";
-		}
-
+	if (max_proto > PSMOUSE_PS2 && thinking_detect(psmouse, set_properties))
 		return PSMOUSE_THINKPS;
-	}
 
 /*
  * Try Synaptics TouchPad
  */
-	if (max_proto > PSMOUSE_PS2 && synaptics_detect(psmouse)) {
+	if (max_proto > PSMOUSE_PS2 && synaptics_detect(psmouse, set_properties)) {
 		synaptics_hardware = 1;
 
-		if (set_properties) {
-			psmouse->vendor = "Synaptics";
-			psmouse->name = "TouchPad";
-		}
-
 		if (max_proto > PSMOUSE_IMEX) {
 			if (!set_properties || synaptics_init(psmouse) == 0)
 				return PSMOUSE_SYNAPTICS;
@@ -406,13 +446,7 @@
 /*
  * Try ALPS TouchPad
  */
-	if (max_proto > PSMOUSE_IMEX && alps_detect(psmouse)) {
-
-		if (set_properties) {
-			psmouse->vendor = "ALPS";
-			psmouse->name = "TouchPad";
-		}
-
+	if (max_proto > PSMOUSE_IMEX && alps_detect(psmouse, set_properties)) {
 		if (!set_properties || alps_init(psmouse) == 0)
 			return PSMOUSE_ALPS;
 
@@ -422,18 +456,8 @@
 		max_proto = PSMOUSE_IMEX;
 	}
 
-	if (max_proto > PSMOUSE_IMEX && genius_detect(psmouse)) {
-
-		if (set_properties) {
-			set_bit(BTN_EXTRA, psmouse->dev.keybit);
-			set_bit(BTN_SIDE, psmouse->dev.keybit);
-			set_bit(REL_WHEEL, psmouse->dev.relbit);
-			psmouse->vendor = "Genius";
-			psmouse->name = "Wheel Mouse";
-		}
-
+	if (max_proto > PSMOUSE_IMEX && genius_detect(psmouse, set_properties))
 		return PSMOUSE_GENPS;
-	}
 
 	if (max_proto > PSMOUSE_IMEX && ps2pp_init(psmouse, set_properties))
 		return PSMOUSE_PS2PP;
@@ -444,34 +468,18 @@
  */
 	ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_RESET_DIS);
 
-	if (max_proto >= PSMOUSE_IMEX && im_explorer_detect(psmouse)) {
-
-		if (set_properties) {
-			set_bit(REL_WHEEL, psmouse->dev.relbit);
-			set_bit(BTN_SIDE, psmouse->dev.keybit);
-			set_bit(BTN_EXTRA, psmouse->dev.keybit);
-			if (!psmouse->name)
-				psmouse->name = "Explorer Mouse";
-		}
-
+	if (max_proto >= PSMOUSE_IMEX && im_explorer_detect(psmouse, set_properties))
 		return PSMOUSE_IMEX;
-	}
-
-	if (max_proto >= PSMOUSE_IMPS && intellimouse_detect(psmouse)) {
-
-		if (set_properties) {
-			set_bit(REL_WHEEL, psmouse->dev.relbit);
-			if (!psmouse->name)
-				psmouse->name = "Wheel Mouse";
-		}
 
+	if (max_proto >= PSMOUSE_IMPS && intellimouse_detect(psmouse, set_properties))
 		return PSMOUSE_IMPS;
-	}
 
 /*
  * Okay, all failed, we have a standard mouse here. The number of the buttons
  * is still a question, though. We assume 3.
  */
+	ps2bare_detect(psmouse, set_properties);
+
 	if (synaptics_hardware) {
 /*
  * We detected Synaptics hardware but it did not respond to IMPS/2 probes.
@@ -706,17 +714,12 @@
 	psmouse->resolution = psmouse_resolution;
 	psmouse->resetafter = psmouse_resetafter;
 	psmouse->smartscroll = psmouse_smartscroll;
+	psmouse->set_rate = psmouse_set_rate;
+	psmouse->set_resolution = psmouse_set_resolution;
+	psmouse->protocol_handler = psmouse_process_byte;
+	psmouse->pktsize = 3;
+
 	psmouse->type = psmouse_extensions(psmouse, psmouse_max_proto, 1);
-	if (!psmouse->vendor)
-		psmouse->vendor = "Generic";
-	if (!psmouse->name)
-		psmouse->name = "Mouse";
-	if (!psmouse->protocol_handler)
-		psmouse->protocol_handler = psmouse_process_byte;
-	if (!psmouse->set_rate)
-		psmouse->set_rate = psmouse_set_rate;
-	if (!psmouse->set_resolution)
-		psmouse->set_resolution = psmouse_set_resolution;
 
 	sprintf(psmouse->devname, "%s %s %s",
 		psmouse_protocols[psmouse->type], psmouse->vendor, psmouse->name);
diff -Nru a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
--- a/drivers/input/mouse/psmouse.h	2004-09-29 01:25:12 -05:00
+++ b/drivers/input/mouse/psmouse.h	2004-09-29 01:25:12 -05:00
@@ -42,6 +42,7 @@
 	char *name;
 	unsigned char packet[8];
 	unsigned char pktcnt;
+	unsigned char pktsize;
 	unsigned char type;
 	unsigned char model;
 	unsigned long last;
diff -Nru a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
--- a/drivers/input/mouse/synaptics.c	2004-09-29 01:25:12 -05:00
+++ b/drivers/input/mouse/synaptics.c	2004-09-29 01:25:12 -05:00
@@ -558,7 +558,7 @@
 	struct synaptics_data *priv = psmouse->private;
 	struct synaptics_data old_priv = *priv;
 
-	if (!synaptics_detect(psmouse))
+	if (!synaptics_detect(psmouse, 0))
 		return -1;
 
 	if (synaptics_query_hardware(psmouse)) {
@@ -580,7 +580,7 @@
 	return 0;
 }
 
-int synaptics_detect(struct psmouse *psmouse)
+int synaptics_detect(struct psmouse *psmouse, int set_properties)
 {
 	struct ps2dev *ps2dev = &psmouse->ps2dev;
 	unsigned char param[4];
@@ -593,7 +593,14 @@
 	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES);
 	ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO);
 
-	return param[1] == 0x47;
+	if (param[1] == 0x47) {
+		if (set_properties) {
+			psmouse->vendor = "Synaptics";
+			psmouse->name = "TouchPad";
+		}
+		return 1;
+	}
+	return 0;
 }
 
 int synaptics_init(struct psmouse *psmouse)
@@ -627,6 +634,7 @@
 	psmouse->set_rate = synaptics_set_rate;
 	psmouse->disconnect = synaptics_disconnect;
 	psmouse->reconnect = synaptics_reconnect;
+	psmouse->pktsize = 6;
 
 	return 0;
 
diff -Nru a/drivers/input/mouse/synaptics.h b/drivers/input/mouse/synaptics.h
--- a/drivers/input/mouse/synaptics.h	2004-09-29 01:25:12 -05:00
+++ b/drivers/input/mouse/synaptics.h	2004-09-29 01:25:12 -05:00
@@ -9,7 +9,7 @@
 #ifndef _SYNAPTICS_H
 #define _SYNAPTICS_H
 
-extern int synaptics_detect(struct psmouse *psmouse);
+extern int synaptics_detect(struct psmouse *psmouse, int set_properties);
 extern int synaptics_init(struct psmouse *psmouse);
 extern void synaptics_reset(struct psmouse *psmouse);
 
