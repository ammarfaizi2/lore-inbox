Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264358AbUF1FJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264358AbUF1FJp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 01:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264650AbUF1FJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 01:09:44 -0400
Received: from smtp806.mail.sc5.yahoo.com ([66.163.168.185]:65398 "HELO
	smtp806.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264358AbUF1FJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 01:09:40 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 1/19] psmouse state locking
Date: Mon, 28 Jun 2004 00:09:36 -0500
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200406280008.21465.dtor_core@ameritech.net>
In-Reply-To: <200406280008.21465.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406280009.37987.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1775, 2004-06-27 15:44:44-05:00, dtor_core@ameritech.net
  Input: when changing psmouse state (activated, ignore) do it while
         holding serio lock so it will not fight with the interrupt
         handler.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 psmouse-base.c |   32 ++++++++++++++++++++++----------
 1 files changed, 22 insertions(+), 10 deletions(-)


===================================================================



diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	2004-06-27 17:46:50 -05:00
+++ b/drivers/input/mouse/psmouse-base.c	2004-06-27 17:46:50 -05:00
@@ -622,6 +622,23 @@
 }
 
 /*
+ * psmouse_set_state() sets new psmouse state and resets all flags and
+ * counters while holding serio lock so fighting with interrupt handler
+ * is not a concern.
+ */
+
+static void psmouse_set_state(struct psmouse *psmouse, unsigned char new_state)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&psmouse->serio->lock, flags);
+	psmouse->state = new_state;
+	psmouse->pktcnt = psmouse->cmdcnt = psmouse->out_of_sync = 0;
+	psmouse->flags = 0;
+	spin_unlock_irqrestore(&psmouse->serio->lock, flags);
+}
+
+/*
  * psmouse_activate() enables the mouse so that we get motion reports from it.
  */
 
@@ -630,7 +647,7 @@
 	if (psmouse_command(psmouse, NULL, PSMOUSE_CMD_ENABLE))
 		printk(KERN_WARNING "psmouse.c: Failed to enable mouse on %s\n", psmouse->serio->phys);
 
-	psmouse->state = PSMOUSE_ACTIVATED;
+	psmouse_set_state(psmouse, PSMOUSE_ACTIVATED);
 }
 
 /*
@@ -652,7 +669,7 @@
 {
 	struct psmouse *psmouse = serio->private;
 
-	psmouse->state = PSMOUSE_CMD_MODE;
+	psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
 
 	if (psmouse->ptport) {
 		if (psmouse->ptport->deactivate)
@@ -665,7 +682,7 @@
 	if (psmouse->disconnect)
 		psmouse->disconnect(psmouse);
 
-	psmouse->state = PSMOUSE_IGNORE;
+	psmouse_set_state(psmouse, PSMOUSE_IGNORE);
 
 	input_unregister_device(&psmouse->dev);
 	serio_close(serio);
@@ -693,9 +710,9 @@
 	psmouse->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_REL);
 	psmouse->dev.keybit[LONG(BTN_MOUSE)] = BIT(BTN_LEFT) | BIT(BTN_MIDDLE) | BIT(BTN_RIGHT);
 	psmouse->dev.relbit[0] = BIT(REL_X) | BIT(REL_Y);
-	psmouse->state = PSMOUSE_CMD_MODE;
 	psmouse->serio = serio;
 	psmouse->dev.private = psmouse;
+	psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
 
 	serio->private = psmouse;
 	if (serio_open(serio, dev)) {
@@ -758,12 +775,7 @@
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
