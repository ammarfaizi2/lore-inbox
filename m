Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265044AbUFRIpI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265044AbUFRIpI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 04:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265062AbUFRIpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 04:45:07 -0400
Received: from smtp801.mail.sc5.yahoo.com ([66.163.168.180]:34389 "HELO
	smtp801.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265044AbUFRIow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 04:44:52 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/11] psmouse state locking
Date: Fri, 18 Jun 2004 03:37:46 -0500
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>,
       vojtech@ucw.cz
References: <200406180335.52843.dtor_core@ameritech.net> <200406180337.17457.dtor_core@ameritech.net>
In-Reply-To: <200406180337.17457.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406180337.47669.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1791, 2004-06-17 18:15:07-05:00, dtor_core@ameritech.net
  Input: when changing psmouse state (activated, ignore) do it while
         holding serio lock so it will not fight with the interrupt
         handler.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 psmouse-base.c |   32 ++++++++++++++++++++++----------
 1 files changed, 22 insertions(+), 10 deletions(-)


===================================================================



diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	2004-06-18 03:14:47 -05:00
+++ b/drivers/input/mouse/psmouse-base.c	2004-06-18 03:14:47 -05:00
@@ -625,6 +625,23 @@
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
 
@@ -633,7 +650,7 @@
 	if (psmouse_command(psmouse, NULL, PSMOUSE_CMD_ENABLE))
 		printk(KERN_WARNING "psmouse.c: Failed to enable mouse on %s\n", psmouse->serio->phys);
 
-	psmouse->state = PSMOUSE_ACTIVATED;
+	psmouse_set_state(psmouse, PSMOUSE_ACTIVATED);
 }
 
 /*
@@ -655,7 +672,7 @@
 {
 	struct psmouse *psmouse = serio->private;
 
-	psmouse->state = PSMOUSE_CMD_MODE;
+	psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
 
 	if (psmouse->ptport) {
 		if (psmouse->ptport->deactivate)
@@ -668,7 +685,7 @@
 	if (psmouse->disconnect)
 		psmouse->disconnect(psmouse);
 
-	psmouse->state = PSMOUSE_IGNORE;
+	psmouse_set_state(psmouse, PSMOUSE_IGNORE);
 
 	input_unregister_device(&psmouse->dev);
 	serio_close(serio);
@@ -696,9 +713,9 @@
 	psmouse->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_REL);
 	psmouse->dev.keybit[LONG(BTN_MOUSE)] = BIT(BTN_LEFT) | BIT(BTN_MIDDLE) | BIT(BTN_RIGHT);
 	psmouse->dev.relbit[0] = BIT(REL_X) | BIT(REL_Y);
-	psmouse->state = PSMOUSE_CMD_MODE;
 	psmouse->serio = serio;
 	psmouse->dev.private = psmouse;
+	psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
 
 	serio->private = psmouse;
 	if (serio_open(serio, dev)) {
@@ -761,12 +778,7 @@
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
