Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262984AbUCKHk2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 02:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262989AbUCKHj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 02:39:58 -0500
Received: from smtp811.mail.sc5.yahoo.com ([66.163.170.81]:11455 "HELO
	smtp811.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262984AbUCKHjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 02:39:07 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 2/3] Input patches: synaptics passthrough fix
Date: Thu, 11 Mar 2004 02:30:59 -0500
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org
References: <200403110226.23897.dtor_core@ameritech.net> <200403110230.07892.dtor_core@ameritech.net>
In-Reply-To: <200403110230.07892.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200403110231.01676.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1663, 2004-03-11 01:43:39-05:00, dtor_core@ameritech.net
  Input: do a full reset of Synaptics touchpad if extended protocol
         probes failed, otherwise trackpoint on the pass-through port
         may stop working (reset-disable isn't enough to revive it)    


 psmouse-base.c |   23 +++++++++++++++++++++--
 psmouse.h      |    1 +
 synaptics.c    |   13 +------------
 3 files changed, 23 insertions(+), 14 deletions(-)


===================================================================



diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	Thu Mar 11 02:07:38 2004
+++ b/drivers/input/mouse/psmouse-base.c	Thu Mar 11 02:07:38 2004
@@ -287,6 +287,24 @@
 	return 0;
 }
 
+
+/*
+ * psmouse_reset() resets the mouse into power-on state.
+ */
+int psmouse_reset(struct psmouse *psmouse)
+{
+	unsigned char param[2];
+
+	if (psmouse_command(psmouse, param, PSMOUSE_CMD_RESET_BAT))
+		return -1;
+
+	if (param[0] != PSMOUSE_RET_BAT && param[1] != PSMOUSE_RET_ID)
+		return -1;
+
+	return 0;
+}
+
+
 /*
  * Genius NetMouse magic init.
  */
@@ -416,6 +434,7 @@
  * pass through port it could get disabled while probing for protocol
  * extensions.
  */
+		psmouse_reset(psmouse);
 		psmouse_command(psmouse, NULL, PSMOUSE_CMD_RESET_DIS);
 	}
 
@@ -540,8 +559,8 @@
 static void psmouse_cleanup(struct serio *serio)
 {
 	struct psmouse *psmouse = serio->private;
-	unsigned char param[2];
-	psmouse_command(psmouse, param, PSMOUSE_CMD_RESET_BAT);
+
+	psmouse_reset(psmouse);
 }
 
 /*
diff -Nru a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
--- a/drivers/input/mouse/psmouse.h	Thu Mar 11 02:07:38 2004
+++ b/drivers/input/mouse/psmouse.h	Thu Mar 11 02:07:38 2004
@@ -65,6 +65,7 @@
 #define PSMOUSE_SYNAPTICS 	7
 
 int psmouse_command(struct psmouse *psmouse, unsigned char *param, int command);
+int psmouse_reset(struct psmouse *psmouse);
 
 extern int psmouse_smartscroll;
 extern unsigned int psmouse_rate;
diff -Nru a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
--- a/drivers/input/mouse/synaptics.c	Thu Mar 11 02:07:38 2004
+++ b/drivers/input/mouse/synaptics.c	Thu Mar 11 02:07:38 2004
@@ -92,17 +92,6 @@
 	return 0;
 }
 
-static int synaptics_reset(struct psmouse *psmouse)
-{
-	unsigned char r[2];
-
-	if (psmouse_command(psmouse, r, PSMOUSE_CMD_RESET_BAT))
-		return -1;
-	if (r[0] == PSMOUSE_RET_BAT && r[1] == PSMOUSE_RET_ID)
-		return 0;
-	return -1;
-}
-
 /*
  * Read the model-id bytes from the touchpad
  * see also SYN_MODEL_* macros
@@ -197,7 +186,7 @@
 {
 	int retries = 0;
 
-	while ((retries++ < 3) && synaptics_reset(psmouse))
+	while ((retries++ < 3) && psmouse_reset(psmouse))
 		printk(KERN_ERR "synaptics reset failed\n");
 
 	if (synaptics_identify(psmouse))
