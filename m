Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265825AbUGHHCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265825AbUGHHCK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 03:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265828AbUGHHBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 03:01:20 -0400
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:51842 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265831AbUGHG7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 02:59:18 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 5/8] New set of input patches
Date: Thu, 8 Jul 2004 01:57:36 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200407080155.07827.dtor_core@ameritech.net> <200407080156.32341.dtor_core@ameritech.net> <200407080157.17205.dtor_core@ameritech.net>
In-Reply-To: <200407080157.17205.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407080157.38459.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1824, 2004-07-08 00:25:13-05:00, dtor_core@ameritech.net
  Input: when changing psmouse state (activated, ignore) use srio_pause_rx/
         serio_continue_rx so it will not fight with the interrupt handler
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 psmouse-base.c |   32 +++++++++++++++++++++-----------
 1 files changed, 21 insertions(+), 11 deletions(-)


===================================================================



diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	2004-07-08 01:35:23 -05:00
+++ b/drivers/input/mouse/psmouse-base.c	2004-07-08 01:35:23 -05:00
@@ -308,7 +308,7 @@
 	while (test_bit(PSMOUSE_FLAG_CMD, &psmouse->flags) && timeout--) {
 
 		if (!test_bit(PSMOUSE_FLAG_CMD1, &psmouse->flags)) {
-		    
+
 			if (command == PSMOUSE_CMD_RESET_BAT && timeout > 100000)
 				timeout = 100000;
 
@@ -626,6 +626,21 @@
 }
 
 /*
+ * psmouse_set_state() sets new psmouse state and resets all flags and
+ * counters while holding serio lock so fighting with interrupt handler
+ * is not a concern.
+ */
+
+static void psmouse_set_state(struct psmouse *psmouse, unsigned char new_state)
+{
+	serio_pause_rx(psmouse->serio);
+	psmouse->state = new_state;
+	psmouse->pktcnt = psmouse->cmdcnt = psmouse->out_of_sync = 0;
+	psmouse->flags = 0;
+	serio_continue_rx(psmouse->serio);
+}
+
+/*
  * psmouse_activate() enables the mouse so that we get motion reports from it.
  */
 
@@ -634,7 +649,7 @@
 	if (psmouse_command(psmouse, NULL, PSMOUSE_CMD_ENABLE))
 		printk(KERN_WARNING "psmouse.c: Failed to enable mouse on %s\n", psmouse->serio->phys);
 
-	psmouse->state = PSMOUSE_ACTIVATED;
+	psmouse_set_state(psmouse, PSMOUSE_ACTIVATED);
 }
 
 /*
@@ -657,7 +672,7 @@
 	struct psmouse *psmouse, *parent;
 
 	psmouse = serio->private;
-	psmouse->state = PSMOUSE_CMD_MODE;
+	psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
 
 	if (serio->parent && (serio->type & SERIO_TYPE) == SERIO_PS_PSTHRU) {
 		parent = serio->parent->private;
@@ -668,7 +683,7 @@
 	if (psmouse->disconnect)
 		psmouse->disconnect(psmouse);
 
-	psmouse->state = PSMOUSE_IGNORE;
+	psmouse_set_state(psmouse, PSMOUSE_IGNORE);
 
 	input_unregister_device(&psmouse->dev);
 	serio_close(serio);
@@ -699,9 +714,9 @@
 	psmouse->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_REL);
 	psmouse->dev.keybit[LONG(BTN_MOUSE)] = BIT(BTN_LEFT) | BIT(BTN_MIDDLE) | BIT(BTN_RIGHT);
 	psmouse->dev.relbit[0] = BIT(REL_X) | BIT(REL_Y);
-	psmouse->state = PSMOUSE_CMD_MODE;
 	psmouse->serio = serio;
 	psmouse->dev.private = psmouse;
+	psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
 
 	serio->private = psmouse;
 	if (serio_open(serio, drv)) {
@@ -780,12 +795,7 @@
 		return -1;
 	}
 
-	psmouse->state = PSMOUSE_CMD_MODE;
-
-	clear_bit(PSMOUSE_FLAG_ACK, &psmouse->flags);
-	clear_bit(PSMOUSE_FLAG_CMD,  &psmouse->flags);
-
-	psmouse->pktcnt = psmouse->out_of_sync = 0;
+	psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
 
 	if (psmouse->reconnect) {
 	       if (psmouse->reconnect(psmouse))
