Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261440AbUD1Vkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbUD1Vkn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 17:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbUD1Via
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 17:38:30 -0400
Received: from gprs214-186.eurotel.cz ([160.218.214.186]:2176 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261931AbUD1Vee (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 17:34:34 -0400
Date: Wed, 28 Apr 2004 23:30:40 +0200
From: Pavel Machek <pavel@suse.cz>
To: vojtech@suse.cz, kernel list <linux-kernel@vger.kernel.org>
Subject: locking in psmouse
Message-ID: <20040428213040.GA954@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

psmouse-base.c does not have any locking. For example psmouse_command
could race with data coming from the mouse, resulting in problem. This
should fix it.
								Pavel

--- clean/drivers/input/mouse/psmouse.h	2004-04-05 10:45:16.000000000 +0200
+++ linux/drivers/input/mouse/psmouse.h	2004-04-28 23:26:36.000000000 +0200
@@ -47,7 +47,7 @@
 	unsigned long last;
 	unsigned char state;
 	char acking;
-	volatile char ack;
+	char ack;
 	char error;
 	char devname[64];
 	char phys[32];
--- clean/drivers/input/mouse/psmouse-base.c	2004-04-05 10:45:16.000000000 +0200
+++ linux/drivers/input/mouse/psmouse-base.c	2004-04-28 23:24:51.000000000 +0200
@@ -53,6 +53,8 @@
 __obsolete_setup("psmouse_resetafter=");
 __obsolete_setup("psmouse_rate=");
 
+static spinlock_t psmouse_lock = SPIN_LOCK_UNLOCKED;
+
 static char *psmouse_protocols[] = { "None", "PS/2", "PS2++", "PS2T++", "GenPS/2", "ImPS/2", "ImExPS/2", "SynPS/2"};
 
 /*
@@ -124,6 +126,7 @@
 {
 	struct psmouse *psmouse = serio->private;
 
+	spin_lock_irq(&psmouse_lock);
 	if (psmouse->state == PSMOUSE_IGNORE)
 		goto out;
 
@@ -208,6 +211,7 @@
 		goto out;
 	}
 out:
+	spin_unlock_irq(&psmouse_lock);
 	return IRQ_HANDLED;
 }
 
@@ -215,6 +219,8 @@
  * psmouse_sendbyte() sends a byte to the mouse, and waits for acknowledge.
  * It doesn't handle retransmission, though it could - because when there would
  * be need for retransmissions, the mouse has to be replaced anyway.
+ *
+ * Must be called with psmouse_lock held.
  */
 
 static int psmouse_sendbyte(struct psmouse *psmouse, unsigned char byte)
@@ -228,7 +234,11 @@
 		return -1;
 	}
 
-	while (!psmouse->ack && timeout--) udelay(10);
+	while (!psmouse->ack && timeout--) {
+		spin_unlock_irq(&psmouse_lock);
+		udelay(10);
+		spin_lock_irq(&psmouse_lock);
+	}
 
 	return -(psmouse->ack <= 0);
 }
@@ -243,8 +253,9 @@
 	int timeout = 500000; /* 500 msec */
 	int send = (command >> 12) & 0xf;
 	int receive = (command >> 8) & 0xf;
-	int i;
+	int i, ret = 0;
 
+	spin_lock_irq(&psmouse_lock);
 	psmouse->cmdcnt = receive;
 
 	if (command == PSMOUSE_CMD_RESET_BAT)
@@ -257,11 +268,11 @@
 
 	if (command & 0xff)
 		if (psmouse_sendbyte(psmouse, command & 0xff))
-			return (psmouse->cmdcnt = 0) - 1;
+			goto error;
 
 	for (i = 0; i < send; i++)
 		if (psmouse_sendbyte(psmouse, param[i]))
-			return (psmouse->cmdcnt = 0) - 1;
+			goto error;
 
 	while (psmouse->cmdcnt && timeout--) {
 
@@ -275,16 +286,21 @@
 			break;
 		}
 
+		spin_unlock_irq(&psmouse_lock);
 		udelay(1);
+		spin_lock_irq(&psmouse_lock);
 	}
 
 	for (i = 0; i < receive; i++)
 		param[i] = psmouse->cmdbuf[(receive - 1) - i];
 
-	if (psmouse->cmdcnt)
-		return (psmouse->cmdcnt = 0) - 1;
-
-	return 0;
+	if (psmouse->cmdcnt) {
+	error:
+		psmouse->cmdcnt = 0;
+		ret = - 1;
+	}
+	spin_unlock_irq(&psmouse_lock);
+	return ret;
 }
 
 
@@ -575,7 +591,9 @@
 {
 	struct psmouse *psmouse = serio->private;
 
+	spin_lock_irq(&psmouse_lock);
 	psmouse->state = PSMOUSE_CMD_MODE;
+	spin_unlock_irq(&psmouse_lock);
 
 	if (psmouse->ptport) {
 		if (psmouse->ptport->deactivate)
@@ -588,7 +606,9 @@
 	if (psmouse->disconnect)
 		psmouse->disconnect(psmouse);
 
+	spin_lock_irq(&psmouse_lock);
 	psmouse->state = PSMOUSE_IGNORE;
+	spin_unlock_irq(&psmouse_lock);
 
 	input_unregister_device(&psmouse->dev);
 	serio_close(serio);
@@ -675,10 +695,13 @@
 		return -1;
 	}
 
+	spin_lock_irq(&psmouse_lock);
 	old_type = psmouse->type;
 
 	psmouse->state = PSMOUSE_CMD_MODE;
 	psmouse->type = psmouse->acking = psmouse->cmdcnt = psmouse->pktcnt = 0;
+	spin_unlock_irq(&psmouse_lock);
+
 	if (psmouse->reconnect) {
 	       if (psmouse->reconnect(psmouse))
 			return -1;

-- 
934a471f20d6580d5aad759bf0d97ddc
