Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271756AbTHHTGS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 15:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271824AbTHHTBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 15:01:19 -0400
Received: from palrel13.hp.com ([156.153.255.238]:57528 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S271811AbTHHSzf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 14:55:35 -0400
Date: Fri, 8 Aug 2003 11:55:34 -0700
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5 IrDA] IrCOMM module fix
Message-ID: <20030808185534.GH13274@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir260_ircomm_owner.diff :
~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Andrey Borzenkov>
	o [CORRECT] Update module refcount in IrCOMM module


diff -u -p linux/net/irda/ircomm/ircomm_tty.d2.c linux/net/irda/ircomm/ircomm_tty.c
--- linux/net/irda/ircomm/ircomm_tty.d2.c	Fri Aug  8 10:47:13 2003
+++ linux/net/irda/ircomm/ircomm_tty.c	Fri Aug  8 10:51:25 2003
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
@@ -443,7 +441,6 @@ static int ircomm_tty_open(struct tty_st
 			return -ERESTARTSYS;
 		}
 
-		/* MOD_DEC_USE_COUNT; "info->tty" will cause this? */
 #ifdef SERIAL_DO_RESTART
 		return ((self->flags & ASYNC_HUP_NOTIFY) ?
 			-EAGAIN : -ERESTARTSYS);
@@ -471,7 +468,6 @@ static int ircomm_tty_open(struct tty_st
 
 	ret = ircomm_tty_block_til_ready(self, filp);
 	if (ret) {
-		/* MOD_DEC_USE_COUNT; "info->tty" will cause this? */
 		IRDA_DEBUG(2, 
 		      "%s(), returning after block_til_ready with %d\n", __FUNCTION__ ,
 		      ret);
@@ -503,7 +499,6 @@ static void ircomm_tty_close(struct tty_
 	spin_lock_irqsave(&self->spinlock, flags);
 
 	if (tty_hung_up_p(filp)) {
-		MOD_DEC_USE_COUNT;
 		spin_unlock_irqrestore(&self->spinlock, flags);
 
 		IRDA_DEBUG(0, "%s(), returning 1\n", __FUNCTION__ );
@@ -530,7 +525,6 @@ static void ircomm_tty_close(struct tty_
 		self->open_count = 0;
 	}
 	if (self->open_count) {
-		MOD_DEC_USE_COUNT;
 		spin_unlock_irqrestore(&self->spinlock, flags);
 
 		IRDA_DEBUG(0, "%s(), open count > 0\n", __FUNCTION__ );
@@ -572,8 +566,6 @@ static void ircomm_tty_close(struct tty_
 
 	self->flags &= ~(ASYNC_NORMAL_ACTIVE|ASYNC_CLOSING);
 	wake_up_interruptible(&self->close_wait);
-
-	MOD_DEC_USE_COUNT;
 }
 
 /*
