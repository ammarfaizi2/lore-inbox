Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270998AbTG1CZP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 22:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270987AbTG1AAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:00:31 -0400
Received: from zeus.kernel.org ([204.152.189.113]:14071 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272954AbTG0XCX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 19:02:23 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][2.6.0-test2] remove MOD_{INC,DEC}_USE_COUNT from ircomm_tty.c
Date: Sun, 27 Jul 2003 23:57:40 +0400
User-Agent: KMail/1.5
Cc: irda-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_06CJ/fRCaqBdi7e"
Message-Id: <200307272357.40144.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_06CJ/fRCaqBdi7e
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This compiles and loads but I am not sure how to test it, I do not actually 
have any ircomm device currently.

-andrey
--Boundary-00=_06CJ/fRCaqBdi7e
Content-Type: text/x-diff;
  charset="us-ascii";
  name="2.6.0-test2-ircomm_tty-USE_COUNT.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="2.6.0-test2-ircomm_tty-USE_COUNT.patch"

--- linux-2.6.0-test2-smp/net/irda/ircomm/ircomm_tty.c.MOD	2003-07-14 20:21:31.000000000 +0400
+++ linux-2.6.0-test2-smp/net/irda/ircomm/ircomm_tty.c	2003-07-27 23:22:20.000000000 +0400
@@ -117,6 +117,7 @@ int __init ircomm_tty_init(void)
 		return -ENOMEM;
 	}
 
+	driver->owner		= THIS_MODULE,
 	driver->driver_name     = "ircomm";
 	driver->name            = "ircomm";
 	driver->devfs_name      = "ircomm";
@@ -363,10 +364,8 @@ static int ircomm_tty_open(struct tty_st
 
 	IRDA_DEBUG(2, "%s()\n", __FUNCTION__ );
 
-	MOD_INC_USE_COUNT;
 	line = tty->index;
 	if ((line < 0) || (line >= IRCOMM_TTY_PORTS)) {
-		MOD_DEC_USE_COUNT;
 		return -ENODEV;
 	}
 
@@ -377,7 +376,6 @@ static int ircomm_tty_open(struct tty_st
 		self = kmalloc(sizeof(struct ircomm_tty_cb), GFP_KERNEL);
 		if (self == NULL) {
 			ERROR("%s(), kmalloc failed!\n", __FUNCTION__);
-			MOD_DEC_USE_COUNT;
 			return -ENOMEM;
 		}
 		memset(self, 0, sizeof(struct ircomm_tty_cb));
@@ -503,7 +501,6 @@ static void ircomm_tty_close(struct tty_
 	spin_lock_irqsave(&self->spinlock, flags);
 
 	if (tty_hung_up_p(filp)) {
-		MOD_DEC_USE_COUNT;
 		spin_unlock_irqrestore(&self->spinlock, flags);
 
 		IRDA_DEBUG(0, "%s(), returning 1\n", __FUNCTION__ );
@@ -530,7 +527,6 @@ static void ircomm_tty_close(struct tty_
 		self->open_count = 0;
 	}
 	if (self->open_count) {
-		MOD_DEC_USE_COUNT;
 		spin_unlock_irqrestore(&self->spinlock, flags);
 
 		IRDA_DEBUG(0, "%s(), open count > 0\n", __FUNCTION__ );
@@ -572,8 +568,6 @@ static void ircomm_tty_close(struct tty_
 
 	self->flags &= ~(ASYNC_NORMAL_ACTIVE|ASYNC_CLOSING);
 	wake_up_interruptible(&self->close_wait);
-
-	MOD_DEC_USE_COUNT;
 }
 
 /*

--Boundary-00=_06CJ/fRCaqBdi7e--

