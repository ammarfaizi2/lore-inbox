Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261980AbUCPRiR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 12:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbUCPOV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 09:21:27 -0500
Received: from styx.suse.cz ([82.208.2.94]:5250 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S261938AbUCPOTy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 09:19:54 -0500
Content-Transfer-Encoding: 7BIT
Message-Id: <10794467783476@twilight.ucw.cz>
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 42/44] Do a full reset of Synaptics touchpad if extended protocol probes failed
X-Mailer: gregkh_patchbomb_levon_offspring
To: torvalds@osdl.org, vojtech@ucw.cz, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Date: Tue, 16 Mar 2004 15:19:38 +0100
In-Reply-To: <1079446778856@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1608.54.11, 2004-03-11 02:20:12-05:00, dtor_core@ameritech.net
  Input: do a full reset of Synaptics touchpad if extended protocol
         probes failed, otherwise trackpoint on the pass-through port
         may stop working (reset-disable isn't enough to revive it)    


 psmouse-base.c |   23 +++++++++++++++++++++--
 psmouse.h      |    1 +
 synaptics.c    |   13 +------------
 3 files changed, 23 insertions(+), 14 deletions(-)

===================================================================

diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	Tue Mar 16 13:17:30 2004
+++ b/drivers/input/mouse/psmouse-base.c	Tue Mar 16 13:17:30 2004
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
--- a/drivers/input/mouse/psmouse.h	Tue Mar 16 13:17:30 2004
+++ b/drivers/input/mouse/psmouse.h	Tue Mar 16 13:17:30 2004
@@ -65,6 +65,7 @@
 #define PSMOUSE_SYNAPTICS 	7
 
 int psmouse_command(struct psmouse *psmouse, unsigned char *param, int command);
+int psmouse_reset(struct psmouse *psmouse);
 
 extern int psmouse_smartscroll;
 extern unsigned int psmouse_rate;
diff -Nru a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
--- a/drivers/input/mouse/synaptics.c	Tue Mar 16 13:17:30 2004
+++ b/drivers/input/mouse/synaptics.c	Tue Mar 16 13:17:30 2004
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

