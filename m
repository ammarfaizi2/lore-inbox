Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262068AbUDDALi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 19:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262077AbUDDALi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 19:11:38 -0500
Received: from user-0can02j.cable.mindspring.com ([24.171.128.83]:29061 "EHLO
	mayonaise.dyndns.org") by vger.kernel.org with ESMTP
	id S262068AbUDDALd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 19:11:33 -0500
Date: Sat, 3 Apr 2004 16:11:32 -0800
From: Eric Wong <eric@yhbt.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] add MX510/310 + cleanup logips2pp.c (resend)
Message-ID: <20040404001132.GA10847@Muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Vojtech, LKML:

I've updated the logips2pp driver to detect the MX310 and MX510 mice
and also made it more maintainable by putting everything into one
table instead of having 4 arrays for them (the MX700 support wasn't
added correctly in the last revision).  Please apply.

===== drivers/input/mouse/logips2pp.c 1.5 vs 1.6 =====
--- 1.5/drivers/input/mouse/logips2pp.c	Wed Jan 14 15:17:09 2004
+++ 1.6/drivers/input/mouse/logips2pp.c	Sun Mar  7 16:05:21 2004
@@ -146,11 +146,35 @@
 static int ps2pp_detect_model(struct psmouse *psmouse, unsigned char *param)
 {
 	int i;
-	static int logitech_4btn[] = { 12, 40, 41, 42, 43, 52, 73, 80, -1 };
-	static int logitech_wheel[] = { 52, 53, 75, 76, 80, 81, 83, 88, 112, -1 };
-	static int logitech_ps2pp[] = { 12, 13, 40, 41, 42, 43, 50, 51, 52, 53, 73, 75,
-						76, 80, 81, 83, 88, 96, 97, 112, -1 };
-	static int logitech_mx[] = { 61, 112, -1 };
+	static struct _logips2_list {
+		const int model;
+		unsigned const int features;
+	} logips2pp_list [] = {
+		{ 12,	PS2PP_4BTN},
+		{ 13,	0 },
+		{ 40,	PS2PP_4BTN },
+		{ 41,	PS2PP_4BTN },
+		{ 42,	PS2PP_4BTN },
+		{ 43,	PS2PP_4BTN },
+		{ 50,	0 },
+		{ 51,	0 },
+		{ 52,	PS2PP_4BTN | PS2PP_WHEEL },
+		{ 53,	PS2PP_WHEEL },
+		{ 61,	PS2PP_WHEEL | PS2PP_MX },	/* MX700 */
+		{ 73,	PS2PP_4BTN },
+		{ 75,	PS2PP_WHEEL },
+		{ 76,	PS2PP_WHEEL },
+		{ 80,	PS2PP_4BTN | PS2PP_WHEEL },
+		{ 81,	PS2PP_WHEEL },
+		{ 83,	PS2PP_WHEEL },
+		{ 88,	PS2PP_WHEEL },
+		{ 96,	0 },
+		{ 97,	0 },
+		{ 100 ,	PS2PP_WHEEL | PS2PP_MX },	/* MX510 */
+		{ 112 ,	PS2PP_WHEEL | PS2PP_MX },	/* MX500 */
+		{ 114 ,	PS2PP_WHEEL | PS2PP_MX | PS2PP_MX310 },	/* MX310 */
+		{ }
+	};
 
 	psmouse->vendor = "Logitech";
 	psmouse->model = ((param[0] >> 4) & 0x07) | ((param[0] << 3) & 0x78);
@@ -162,35 +186,33 @@
 
 	psmouse->type = PSMOUSE_PS2;
 
-	for (i = 0; logitech_ps2pp[i] != -1; i++)
-		if (logitech_ps2pp[i] == psmouse->model)
+	for (i = 0; logips2pp_list[i].model; i++){
+		if (logips2pp_list[i].model == psmouse->model){
 			psmouse->type = PSMOUSE_PS2PP;
-
-	if (psmouse->type == PSMOUSE_PS2PP) {
-
-		for (i = 0; logitech_4btn[i] != -1; i++)
-			if (logitech_4btn[i] == psmouse->model)
+			if (logips2pp_list[i].features & PS2PP_4BTN)
 				set_bit(BTN_SIDE, psmouse->dev.keybit);
 
-		for (i = 0; logitech_wheel[i] != -1; i++)
-			if (logitech_wheel[i] == psmouse->model) {
+			if (logips2pp_list[i].features & PS2PP_WHEEL){
 				set_bit(REL_WHEEL, psmouse->dev.relbit);
 				psmouse->name = "Wheel Mouse";
 			}
-
-		for (i = 0; logitech_mx[i] != -1; i++)
-			if (logitech_mx[i]  == psmouse->model) {
+			if (logips2pp_list[i].features & PS2PP_MX) {
 				set_bit(BTN_SIDE, psmouse->dev.keybit);
 				set_bit(BTN_EXTRA, psmouse->dev.keybit);
-				set_bit(BTN_BACK, psmouse->dev.keybit);
-				set_bit(BTN_FORWARD, psmouse->dev.keybit);
 				set_bit(BTN_TASK, psmouse->dev.keybit);
+				if (!(logips2pp_list[i].features & PS2PP_MX310)){
+					set_bit(BTN_BACK, psmouse->dev.keybit);
+					set_bit(BTN_FORWARD, psmouse->dev.keybit);
+				}
 				psmouse->name = "MX Mouse";
 			}
-
+			break;
+		}
+	}
 /*
  * Do Logitech PS2++ / PS2T++ magic init.
  */
+	if (psmouse->type == PSMOUSE_PS2PP) {
 
 		if (psmouse->model == 97) { /* TouchPad 3 */
 
===== drivers/input/mouse/logips2pp.h 1.3 vs 1.4 =====
--- 1.3/drivers/input/mouse/logips2pp.h	Tue Dec 16 22:47:29 2003
+++ 1.4/drivers/input/mouse/logips2pp.h	Sun Mar  7 18:46:31 2004
@@ -10,6 +10,12 @@
 
 #ifndef _LOGIPS2PP_H
 #define _LOGIPS2PP_H
+
+#define PS2PP_4BTN	0x01
+#define PS2PP_WHEEL	0x02
+#define PS2PP_MX	0x04
+#define PS2PP_MX310	0x08
+
 struct psmouse;
 void ps2pp_process_packet(struct psmouse *psmouse);
 void ps2pp_set_800dpi(struct psmouse *psmouse);



-- 
Eric Wong                normalperson@yhbt.net
Petta Technology, Inc      eric@petta-tech.com
