Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268236AbUI2GzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268236AbUI2GzQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 02:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268239AbUI2Gwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 02:52:45 -0400
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:39022 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268240AbUI2GsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 02:48:04 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 7/8] Separate PS2PP protocol handling
Date: Wed, 29 Sep 2004 01:46:36 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200409290140.53350.dtor_core@ameritech.net> <200409290144.50310.dtor_core@ameritech.net> <200409290145.39919.dtor_core@ameritech.net>
In-Reply-To: <200409290145.39919.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409290146.38929.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1953, 2004-09-29 01:06:41-05:00, dtor_core@ameritech.net
  Input: psmouse - make logips2pp fully decode its protocol packets
         and not rely on generic handler to finish job.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 logips2pp.c    |   43 +++++++++++++++++++++++++++++++++----------
 logips2pp.h    |    1 -
 psmouse-base.c |    7 -------
 3 files changed, 33 insertions(+), 18 deletions(-)


===================================================================



diff -Nru a/drivers/input/mouse/logips2pp.c b/drivers/input/mouse/logips2pp.c
--- a/drivers/input/mouse/logips2pp.c	2004-09-29 01:23:24 -05:00
+++ b/drivers/input/mouse/logips2pp.c	2004-09-29 01:23:24 -05:00
@@ -38,13 +38,23 @@
  * Process a PS2++ or PS2T++ packet.
  */
 
-void ps2pp_process_packet(struct psmouse *psmouse)
+static psmouse_ret_t ps2pp_process_byte(struct psmouse *psmouse, struct pt_regs *regs)
 {
 	struct input_dev *dev = &psmouse->dev;
-        unsigned char *packet = psmouse->packet;
+	unsigned char *packet = psmouse->packet;
+
+	if (psmouse->pktcnt < 3)
+		return PSMOUSE_GOOD_DATA;
+
+/*
+ * Full packet accumulated, process it
+ */
+
+	input_regs(dev, regs);
 
 	if ((packet[0] & 0x48) == 0x48 && (packet[1] & 0x02) == 0x02) {
 
+		/* Logitech extended packet */
 		switch ((packet[1] >> 4) | (packet[0] & 0x30)) {
 
 			case 0x0d: /* Mouse extra info */
@@ -79,11 +89,20 @@
 					(packet[1] >> 4) | (packet[0] & 0x30));
 #endif
 		}
-
-		packet[0] &= 0x0f;
-		packet[1] = 0;
-		packet[2] = 0;
+	} else {
+		/* Standard PS/2 motion data */
+		input_report_rel(dev, REL_X, packet[1] ? (int) packet[1] - (int) ((packet[0] << 4) & 0x100) : 0);
+		input_report_rel(dev, REL_Y, packet[2] ? (int) ((packet[0] << 3) & 0x100) - (int) packet[2] : 0);
 	}
+
+	input_report_key(dev, BTN_LEFT,    packet[0]       & 1);
+	input_report_key(dev, BTN_MIDDLE, (packet[0] >> 2) & 1);
+	input_report_key(dev, BTN_RIGHT,  (packet[0] >> 1) & 1);
+
+	input_sync(dev);
+
+	return PSMOUSE_FULL_PACKET;
+
 }
 
 /*
@@ -334,11 +353,15 @@
 		psmouse->vendor = "Logitech";
 		psmouse->model = model;
 
-		if (use_ps2pp && model_info->kind != PS2PP_KIND_TP3) {
-			psmouse->set_resolution = ps2pp_set_resolution;
-			psmouse->disconnect = ps2pp_disconnect;
+		if (use_ps2pp) {
+			psmouse->protocol_handler = ps2pp_process_byte;
+
+			if (model_info->kind != PS2PP_KIND_TP3) {
+				psmouse->set_resolution = ps2pp_set_resolution;
+				psmouse->disconnect = ps2pp_disconnect;
 
-			device_create_file(&psmouse->ps2dev.serio->dev, &psmouse_attr_smartscroll);
+				device_create_file(&psmouse->ps2dev.serio->dev, &psmouse_attr_smartscroll);
+			}
 		}
 
 		if (buttons < 3)
diff -Nru a/drivers/input/mouse/logips2pp.h b/drivers/input/mouse/logips2pp.h
--- a/drivers/input/mouse/logips2pp.h	2004-09-29 01:23:24 -05:00
+++ b/drivers/input/mouse/logips2pp.h	2004-09-29 01:23:24 -05:00
@@ -11,7 +11,6 @@
 #ifndef _LOGIPS2PP_H
 #define _LOGIPS2PP_H
 
-void ps2pp_process_packet(struct psmouse *psmouse);
 int ps2pp_init(struct psmouse *psmouse, int set_properties);
 
 #endif
diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	2004-09-29 01:23:24 -05:00
+++ b/drivers/input/mouse/psmouse-base.c	2004-09-29 01:23:24 -05:00
@@ -84,13 +84,6 @@
 	input_regs(dev, regs);
 
 /*
- * The PS2++ protocol is a little bit complex
- */
-
-	if (psmouse->type == PSMOUSE_PS2PP)
-		ps2pp_process_packet(psmouse);
-
-/*
  * Scroll wheel on IntelliMice, scroll buttons on NetMice
  */
 
