Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbUCPO1a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 09:27:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261990AbUCPOY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 09:24:26 -0500
Received: from styx.suse.cz ([82.208.2.94]:4994 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S261958AbUCPOTu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 09:19:50 -0500
Content-Transfer-Encoding: 7BIT
Message-Id: <1079446778856@twilight.ucw.cz>
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 41/44] Don't ignore PS/2 data immediately after disconnect
X-Mailer: gregkh_patchbomb_levon_offspring
To: torvalds@osdl.org, vojtech@ucw.cz, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Date: Tue, 16 Mar 2004 15:19:38 +0100
In-Reply-To: <10794467782137@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1608.54.10, 2004-03-11 02:16:51-05:00, dtor_core@ameritech.net
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
--- a/drivers/input/mouse/psmouse-base.c	Tue Mar 16 13:17:34 2004
+++ b/drivers/input/mouse/psmouse-base.c	Tue Mar 16 13:17:34 2004
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
--- a/drivers/input/mouse/psmouse.h	Tue Mar 16 13:17:34 2004
+++ b/drivers/input/mouse/psmouse.h	Tue Mar 16 13:17:34 2004
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
 

