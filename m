Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262991AbUCKHnV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 02:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbUCKHje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 02:39:34 -0500
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:36030 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262983AbUCKHjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 02:39:05 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 1/3] Input patches: psmouse cleanup fix
Date: Thu, 11 Mar 2004 02:30:05 -0500
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org
References: <200403110226.23897.dtor_core@ameritech.net>
In-Reply-To: <200403110226.23897.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200403110230.07892.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1662, 2004-03-11 01:26:03-05:00, dtor_core@ameritech.net
  Input: when disconnecting PS/2 mouse give protocol's disconnect 
         handler chance to run before starting ignoring mouse data.
         Otherwise interrupt handler will discard all ACKs and the
         very first command in cleanup sequence will fail (Synaptics
         was failing to return to relative mode on module unload).


 psmouse-base.c |    8 +++++---
 psmouse.h      |    4 ++--
 2 files changed, 7 insertions(+), 5 deletions(-)


===================================================================



diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	Thu Mar 11 02:07:09 2004
+++ b/drivers/input/mouse/psmouse-base.c	Thu Mar 11 02:07:09 2004
@@ -552,7 +552,7 @@
 {
 	struct psmouse *psmouse = serio->private;
 
-	psmouse->state = PSMOUSE_IGNORE;
+	psmouse->state = PSMOUSE_CMD_MODE;
 
 	if (psmouse->ptport) {
 		if (psmouse->ptport->deactivate)
@@ -565,6 +565,8 @@
 	if (psmouse->disconnect)
 		psmouse->disconnect(psmouse);
 
+	psmouse->state = PSMOUSE_IGNORE;
+
 	input_unregister_device(&psmouse->dev);
 	serio_close(serio);
 	kfree(psmouse);
@@ -592,7 +594,7 @@
 	psmouse->dev.keybit[LONG(BTN_MOUSE)] = BIT(BTN_LEFT) | BIT(BTN_MIDDLE) | BIT(BTN_RIGHT);
 	psmouse->dev.relbit[0] = BIT(REL_X) | BIT(REL_Y);
 
-	psmouse->state = PSMOUSE_NEW_DEVICE;
+	psmouse->state = PSMOUSE_CMD_MODE;
 	psmouse->serio = serio;
 	psmouse->dev.private = psmouse;
 
@@ -650,7 +652,7 @@
 		return -1;
 	}
 
-	psmouse->state = PSMOUSE_NEW_DEVICE;
+	psmouse->state = PSMOUSE_CMD_MODE;
 	psmouse->type = psmouse->acking = psmouse->cmdcnt = psmouse->pktcnt = 0;
 	if (psmouse->reconnect) {
 	       if (psmouse->reconnect(psmouse))
diff -Nru a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
--- a/drivers/input/mouse/psmouse.h	Thu Mar 11 02:07:09 2004
+++ b/drivers/input/mouse/psmouse.h	Thu Mar 11 02:07:09 2004
@@ -5,7 +5,7 @@
 #define PSMOUSE_CMD_SETRES	0x10e8
 #define PSMOUSE_CMD_GETINFO	0x03e9
 #define PSMOUSE_CMD_SETSTREAM	0x00ea
-#define PSMOUSE_CMD_POLL	0x03eb	
+#define PSMOUSE_CMD_POLL	0x03eb
 #define PSMOUSE_CMD_GETID	0x02f2
 #define PSMOUSE_CMD_SETRATE	0x10f3
 #define PSMOUSE_CMD_ENABLE	0x00f4
@@ -18,7 +18,7 @@
 #define PSMOUSE_RET_NAK		0xfe
 
 /* psmouse states */
-#define PSMOUSE_NEW_DEVICE	0
+#define PSMOUSE_CMD_MODE	0
 #define PSMOUSE_ACTIVATED	1
 #define PSMOUSE_IGNORE		2
 
