Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262275AbVCVHVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262275AbVCVHVX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 02:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbVCVHT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 02:19:26 -0500
Received: from smtp815.mail.sc5.yahoo.com ([66.163.170.1]:51089 "HELO
	smtp815.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262140AbVCVHSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 02:18:51 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Kenan Esau <kenan.esau@conan.de>
Subject: [PATCH 2/4] Lifebook: various cleanups
Date: Tue, 22 Mar 2005 02:15:33 -0500
User-Agent: KMail/1.7.2
Cc: harald.hoyer@redhat.de, linux-input@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
References: <20050217194217.GA2458@ucw.cz> <200503220213.46375.dtor_core@ameritech.net> <200503220214.55379.dtor_core@ameritech.net>
In-Reply-To: <200503220214.55379.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503220215.34198.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===================================================================

Input: lifebook - various cleanups:
       - do not try to set rate and resolution in init method, let
         psmouse core do it for us. This also removes special quirks
         from the core;
       - do not disable mouse before doing full reset - meaningless;
       - some formatting and whitespace cleanups.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 lifebook.c     |   31 ++++++++++---------------------
 lifebook.h     |    2 +-
 psmouse-base.c |    2 --
 3 files changed, 11 insertions(+), 24 deletions(-)

Index: dtor/drivers/input/mouse/lifebook.h
===================================================================
--- dtor.orig/drivers/input/mouse/lifebook.h
+++ dtor/drivers/input/mouse/lifebook.h
@@ -11,7 +11,7 @@
 #ifndef _LIFEBOOK_H
 #define _LIFEBOOK_H
 
-int lifebook_detect(struct psmouse *psmouse, unsigned int max_proto, 
+int lifebook_detect(struct psmouse *psmouse, unsigned int max_proto,
                     int set_properties);
 
 #endif
Index: dtor/drivers/input/mouse/psmouse-base.c
===================================================================
--- dtor.orig/drivers/input/mouse/psmouse-base.c
+++ dtor/drivers/input/mouse/psmouse-base.c
@@ -579,8 +579,6 @@ static void psmouse_set_rate(struct psmo
 
 static void psmouse_initialize(struct psmouse *psmouse)
 {
-        if (psmouse->type==PSMOUSE_LIFEBOOK)
-                return;
 /*
  * We set the mouse into streaming mode.
  */
Index: dtor/drivers/input/mouse/lifebook.c
===================================================================
--- dtor.orig/drivers/input/mouse/lifebook.c
+++ dtor/drivers/input/mouse/lifebook.c
@@ -19,8 +19,6 @@
 #include "psmouse.h"
 #include "lifebook.h"
 
-static int max_y = 1024;
-
 #if defined(__i386__)
 #include <linux/dmi.h>
 static struct dmi_system_id lifebook_dmi_table[] = {
@@ -46,7 +44,7 @@ static psmouse_ret_t lifebook_process_by
 	unsigned char *packet = psmouse->packet;
 	struct input_dev *dev = &psmouse->dev;
 
-	if ( psmouse->pktcnt != 3 )
+	if (psmouse->pktcnt != 3)
 		return PSMOUSE_GOOD_DATA;
 
 	input_regs(dev, regs);
@@ -56,12 +54,12 @@ static psmouse_ret_t lifebook_process_by
 		input_report_abs(dev, ABS_X,
 				 (packet[1] | ((packet[0] & 0x30) << 4)));
 		input_report_abs(dev, ABS_Y,
-				 max_y - (packet[2] | ((packet[0] & 0xC0) << 2)));
+				 1024 - (packet[2] | ((packet[0] & 0xC0) << 2)));
 	} else {
-		input_report_rel(dev, REL_X, 
-				((packet[0] & 0x10) ? packet[1]-256 : packet[1]));
-		input_report_rel(dev, REL_Y, 
-				(- (int)((packet[0] & 0x20) ? packet[2]-256 : packet[2])));
+		input_report_rel(dev, REL_X,
+				((packet[0] & 0x10) ? packet[1] - 256 : packet[1]));
+		input_report_rel(dev, REL_Y,
+				 -(int)((packet[0] & 0x20) ? packet[2] - 256 : packet[2]));
 	}
 
 	input_report_key(dev, BTN_LEFT, packet[0] & 0x01);
@@ -78,26 +76,17 @@ static int lifebook_initialize(struct ps
 	struct ps2dev *ps2dev = &psmouse->ps2dev;
 	unsigned char param;
 
-	if (ps2_command(ps2dev, NULL, PSMOUSE_CMD_DISABLE))
-		return -1;
-
-	if (ps2_command(ps2dev, NULL, PSMOUSE_CMD_RESET_BAT))
+	if (psmouse_reset(psmouse))
 		return -1;
 
-	/* 
+	/*
 	   Enable absolute output -- ps2_command fails always but if
 	   you leave this call out the touchsreen will never send
 	   absolute coordinates
-	*/ 
+	*/
 	param = 0x07;
 	ps2_command(ps2dev, &param, PSMOUSE_CMD_SETRES);
 
-	psmouse->set_rate(psmouse, psmouse->rate);
-	psmouse->set_resolution(psmouse, psmouse->resolution);
-	
-	if (ps2_command(ps2dev, NULL, PSMOUSE_CMD_ENABLE))
-		return -1;
-
 	return 0;
 }
 
@@ -106,7 +95,7 @@ static void lifebook_disconnect(struct p
 	psmouse_reset(psmouse);
 }
 
-int lifebook_detect(struct psmouse *psmouse, unsigned int max_proto, 
+int lifebook_detect(struct psmouse *psmouse, unsigned int max_proto,
                     int set_properties)
 {
         if (lifebook_check_dmi() && max_proto != PSMOUSE_LIFEBOOK)
