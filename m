Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262256AbVCVHV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbVCVHV1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 02:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262140AbVCVHTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 02:19:55 -0500
Received: from smtp815.mail.sc5.yahoo.com ([66.163.170.1]:52625 "HELO
	smtp815.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262195AbVCVHSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 02:18:52 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Kenan Esau <kenan.esau@conan.de>
Subject: [PATCH 3/4] Lifebook: rearrange init code
Date: Tue, 22 Mar 2005 02:16:38 -0500
User-Agent: KMail/1.7.2
Cc: harald.hoyer@redhat.de, linux-input@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
References: <20050217194217.GA2458@ucw.cz> <200503220214.55379.dtor_core@ameritech.net> <200503220215.34198.dtor_core@ameritech.net>
In-Reply-To: <200503220215.34198.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503220216.38756.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===================================================================

Input: lifebook - adjust initialization routines to be in line with
       the rest of protocols in preparation to dynamic protocol
       switching.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 lifebook.c     |   46 ++++++++++++++++++++++++++++------------------
 lifebook.h     |    4 ++--
 psmouse-base.c |   14 ++++++++++++--
 3 files changed, 42 insertions(+), 22 deletions(-)

Index: dtor/drivers/input/mouse/lifebook.h
===================================================================
--- dtor.orig/drivers/input/mouse/lifebook.h
+++ dtor/drivers/input/mouse/lifebook.h
@@ -11,7 +11,7 @@
 #ifndef _LIFEBOOK_H
 #define _LIFEBOOK_H
 
-int lifebook_detect(struct psmouse *psmouse, unsigned int max_proto,
-                    int set_properties);
+int lifebook_detect(struct psmouse *psmouse, int set_properties);
+int lifebook_init(struct psmouse *psmouse);
 
 #endif
Index: dtor/drivers/input/mouse/psmouse-base.c
===================================================================
--- dtor.orig/drivers/input/mouse/psmouse-base.c
+++ dtor/drivers/input/mouse/psmouse-base.c
@@ -424,8 +424,18 @@ static int psmouse_extensions(struct psm
 {
 	int synaptics_hardware = 0;
 
-	if (lifebook_detect(psmouse, max_proto, set_properties) == 0)
-		return PSMOUSE_LIFEBOOK;
+/*
+ * We always check for lifebook because it does not disturb mouse
+ * (it only checks DMI information).
+ */
+	if (lifebook_detect(psmouse, set_properties) == 0 ||
+	    max_proto == PSMOUSE_LIFEBOOK) {
+
+		if (max_proto > PSMOUSE_IMEX) {
+			if (!set_properties || lifebook_init(psmouse) == 0)
+				return PSMOUSE_LIFEBOOK;
+		}
+	}
 
 /*
  * Try Kensington ThinkingMouse (we try first, because synaptics probe
Index: dtor/drivers/input/mouse/lifebook.c
===================================================================
--- dtor.orig/drivers/input/mouse/lifebook.c
+++ dtor/drivers/input/mouse/lifebook.c
@@ -71,7 +71,7 @@ static psmouse_ret_t lifebook_process_by
 	return PSMOUSE_FULL_PACKET;
 }
 
-static int lifebook_initialize(struct psmouse *psmouse)
+static int lifebook_absolute_mode(struct psmouse *psmouse)
 {
 	struct ps2dev *ps2dev = &psmouse->ps2dev;
 	unsigned char param;
@@ -95,27 +95,37 @@ static void lifebook_disconnect(struct p
 	psmouse_reset(psmouse);
 }
 
-int lifebook_detect(struct psmouse *psmouse, unsigned int max_proto,
-                    int set_properties)
+int lifebook_detect(struct psmouse *psmouse, int set_properties)
 {
-        if (lifebook_check_dmi() && max_proto != PSMOUSE_LIFEBOOK)
+        if (lifebook_check_dmi())
                 return -1;
 
 	if (set_properties) {
-		psmouse->vendor = "Fujitsu Lifebook";
-		psmouse->name = "TouchScreen";
-		psmouse->dev.evbit[0] = BIT(EV_ABS) | BIT(EV_KEY) | BIT(EV_REL);
-		psmouse->dev.keybit[LONG(BTN_LEFT)] = BIT(BTN_LEFT) | BIT(BTN_MIDDLE) | BIT(BTN_RIGHT);
-		psmouse->dev.keybit[LONG(BTN_TOUCH)] = BIT(BTN_TOUCH);
-		psmouse->dev.relbit[0] = BIT(REL_X) | BIT(REL_Y);
-		input_set_abs_params(&psmouse->dev, ABS_X, 0, 1024, 0, 0);
-		input_set_abs_params(&psmouse->dev, ABS_Y, 0, 1024, 0, 0);
-
-		psmouse->protocol_handler = lifebook_process_byte;
-		psmouse->disconnect = lifebook_disconnect;
-		psmouse->reconnect  = lifebook_initialize;
-		psmouse->pktsize = 3;
+		psmouse->vendor = "Fujitsu";
+		psmouse->name = "Lifebook TouchScreen";
+
 	}
 
-        return lifebook_initialize(psmouse);
+        return 0;
 }
+
+int lifebook_init(struct psmouse *psmouse)
+{
+	if (lifebook_absolute_mode(psmouse))
+		return -1;
+
+	psmouse->dev.evbit[0] = BIT(EV_ABS) | BIT(EV_KEY) | BIT(EV_REL);
+	psmouse->dev.keybit[LONG(BTN_LEFT)] = BIT(BTN_LEFT) | BIT(BTN_MIDDLE) | BIT(BTN_RIGHT);
+	psmouse->dev.keybit[LONG(BTN_TOUCH)] = BIT(BTN_TOUCH);
+	psmouse->dev.relbit[0] = BIT(REL_X) | BIT(REL_Y);
+	input_set_abs_params(&psmouse->dev, ABS_X, 0, 1024, 0, 0);
+	input_set_abs_params(&psmouse->dev, ABS_Y, 0, 1024, 0, 0);
+
+	psmouse->protocol_handler = lifebook_process_byte;
+	psmouse->disconnect = lifebook_disconnect;
+	psmouse->reconnect  = lifebook_absolute_mode;
+	psmouse->pktsize = 3;
+
+	return 0;
+}
+
