Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268257AbUI2G75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268257AbUI2G75 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 02:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268249AbUI2GvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 02:51:22 -0400
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:38510 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268239AbUI2GsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 02:48:04 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 6/8] Drop PS2TPP protocol identifier
Date: Wed, 29 Sep 2004 01:45:37 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200409290140.53350.dtor_core@ameritech.net> <200409290144.04783.dtor_core@ameritech.net> <200409290144.50310.dtor_core@ameritech.net>
In-Reply-To: <200409290144.50310.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409290145.39919.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1952, 2004-09-29 01:05:22-05:00, dtor_core@ameritech.net
  Input: psmouse - drop PS2TPP protocol (it is handled exactly like
         PS2PP) to free spot for THINKPS protocol and keep old protocol
         numbers for binary compatibility with Synaptics/ALPS touchpad
         driver for X.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 logips2pp.c    |   52 ++++++++++++++++++++++++++++------------------------
 psmouse-base.c |   11 ++++-------
 psmouse.h      |    1 -
 3 files changed, 32 insertions(+), 32 deletions(-)


===================================================================



diff -Nru a/drivers/input/mouse/logips2pp.c b/drivers/input/mouse/logips2pp.c
--- a/drivers/input/mouse/logips2pp.c	2004-09-29 01:22:10 -05:00
+++ b/drivers/input/mouse/logips2pp.c	2004-09-29 01:22:10 -05:00
@@ -274,9 +274,9 @@
 {
 	struct ps2dev *ps2dev = &psmouse->ps2dev;
 	unsigned char param[4];
-	unsigned char protocol = PSMOUSE_PS2;
 	unsigned char model, buttons;
 	struct ps2pp_info *model_info;
+	int use_ps2pp = 0;
 
 	param[0] = 0;
 	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES);
@@ -286,10 +286,13 @@
 	param[1] = 0;
 	ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO);
 
-	if (param[1] != 0) {
-		model = ((param[0] >> 4) & 0x07) | ((param[0] << 3) & 0x78);
-		buttons = param[1];
-		model_info = get_model_info(model);
+	if (!param[1])
+		return 0;
+
+	model = ((param[0] >> 4) & 0x07) | ((param[0] << 3) & 0x78);
+	buttons = param[1];
+
+	if ((model_info = get_model_info(model)) != NULL) {
 
 /*
  * Do Logitech PS2++ / PS2T++ magic init.
@@ -309,10 +312,10 @@
 			param[0] = 0;
 			if (!ps2_command(ps2dev, param, 0x13d1) &&
 			    param[0] == 0x06 && param[1] == 0x00 && param[2] == 0x14) {
-				protocol = PSMOUSE_PS2TPP;
+				use_ps2pp = 1;
 			}
 
-		} else if (model_info != NULL) {
+		} else {
 
 			param[0] = param[1] = param[2] = 0;
 			ps2pp_cmd(psmouse, param, 0x39); /* Magic knock */
@@ -322,30 +325,31 @@
 			    (param[1] & 0xf3) == 0xc2 &&
 			    (param[2] & 0x03) == ((param[1] >> 2) & 3)) {
 				ps2pp_set_smartscroll(psmouse, psmouse->smartscroll);
-				protocol = PSMOUSE_PS2PP;
+				use_ps2pp = 1;
 			}
 		}
+	}
 
-		if (set_properties) {
-			psmouse->vendor = "Logitech";
-			psmouse->model = model;
-			if (protocol == PSMOUSE_PS2PP) {
-				psmouse->set_resolution = ps2pp_set_resolution;
-				psmouse->disconnect = ps2pp_disconnect;
+	if (set_properties) {
+		psmouse->vendor = "Logitech";
+		psmouse->model = model;
+
+		if (use_ps2pp && model_info->kind != PS2PP_KIND_TP3) {
+			psmouse->set_resolution = ps2pp_set_resolution;
+			psmouse->disconnect = ps2pp_disconnect;
 
-				device_create_file(&psmouse->ps2dev.serio->dev, &psmouse_attr_smartscroll);
-			}
+			device_create_file(&psmouse->ps2dev.serio->dev, &psmouse_attr_smartscroll);
+		}
 
-			if (buttons < 3)
-				clear_bit(BTN_MIDDLE, psmouse->dev.keybit);
-			if (buttons < 2)
-				clear_bit(BTN_RIGHT, psmouse->dev.keybit);
+		if (buttons < 3)
+			clear_bit(BTN_MIDDLE, psmouse->dev.keybit);
+		if (buttons < 2)
+			clear_bit(BTN_RIGHT, psmouse->dev.keybit);
 
-			if (model_info)
-				ps2pp_set_model_properties(psmouse, model_info);
-		}
+		if (model_info)
+			ps2pp_set_model_properties(psmouse, model_info);
 	}
 
-	return protocol;
+	return use_ps2pp;
 }
 
diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	2004-09-29 01:22:10 -05:00
+++ b/drivers/input/mouse/psmouse-base.c	2004-09-29 01:22:10 -05:00
@@ -62,7 +62,7 @@
 __obsolete_setup("psmouse_resetafter=");
 __obsolete_setup("psmouse_rate=");
 
-static char *psmouse_protocols[] = { "None", "PS/2", "PS2++", "PS2T++", "ThinkPS/2", "GenPS/2", "ImPS/2", "ImExPS/2", "SynPS/2", "AlpsPS/2" };
+static char *psmouse_protocols[] = { "None", "PS/2", "PS2++", "ThinkPS/2", "GenPS/2", "ImPS/2", "ImExPS/2", "SynPS/2", "AlpsPS/2" };
 
 /*
  * psmouse_process_byte() analyzes the PS/2 data stream and reports
@@ -87,7 +87,7 @@
  * The PS2++ protocol is a little bit complex
  */
 
-	if (psmouse->type == PSMOUSE_PS2PP || psmouse->type == PSMOUSE_PS2TPP)
+	if (psmouse->type == PSMOUSE_PS2PP)
 		ps2pp_process_packet(psmouse);
 
 /*
@@ -442,11 +442,8 @@
 		return PSMOUSE_GENPS;
 	}
 
-	if (max_proto > PSMOUSE_IMEX) {
-		int type = ps2pp_init(psmouse, set_properties);
-		if (type > PSMOUSE_PS2)
-			return type;
-	}
+	if (max_proto > PSMOUSE_IMEX && ps2pp_init(psmouse, set_properties))
+		return PSMOUSE_PS2PP;
 
 /*
  * Reset to defaults in case the device got confused by extended
diff -Nru a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
--- a/drivers/input/mouse/psmouse.h	2004-09-29 01:22:10 -05:00
+++ b/drivers/input/mouse/psmouse.h	2004-09-29 01:22:10 -05:00
@@ -70,7 +70,6 @@
 	PSMOUSE_NONE,
 	PSMOUSE_PS2,
 	PSMOUSE_PS2PP,
-	PSMOUSE_PS2TPP,
 	PSMOUSE_THINKPS,
 	PSMOUSE_GENPS,
 	PSMOUSE_IMPS,
