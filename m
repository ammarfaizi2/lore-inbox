Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263580AbUAHCix (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 21:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263584AbUAHCg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 21:36:56 -0500
Received: from palrel10.hp.com ([156.153.255.245]:52677 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S263580AbUAHCgF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 21:36:05 -0500
Date: Wed, 7 Jan 2004 18:36:02 -0800
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] IrCOMM disconnect Opps (local_bh_enable)
Message-ID: <20040108023602.GG13620@bougret.hpl.hp.com>
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

ir260_ircomm_detach_lock.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	o [CRITICA] Fix IrCOMM Oops at disconnect (local_bh_enable)


diff -u -p linux/include/net/irda/ircomm_tty.d4.h linux/include/net/irda/ircomm_tty.h
--- linux/include/net/irda/ircomm_tty.d4.h	Thu Dec 18 18:22:57 2003
+++ linux/include/net/irda/ircomm_tty.h	Thu Dec 18 18:29:01 2003
@@ -52,6 +52,11 @@
 /* Same for payload size. See qos.c for the smallest max data size */
 #define IRCOMM_TTY_DATA_UNINITIALISED	(64 - IRCOMM_TTY_HDR_UNINITIALISED)
 
+/* Those are really defined in include/linux/serial.h - Jean II */
+#define ASYNC_B_INITIALIZED	31	/* Serial port was initialized */
+#define ASYNC_B_NORMAL_ACTIVE	29	/* Normal device is active */
+#define ASYNC_B_CLOSING		27	/* Serial port is closing */
+
 /*
  * IrCOMM TTY driver state
  */
@@ -75,7 +80,7 @@ struct ircomm_tty_cb {
 	LOCAL_FLOW flow;          /* IrTTP flow status */
 
 	int line;
-	__u32 flags;
+	volatile unsigned long flags;
 
 	__u8 dlsap_sel;
 	__u8 slsap_sel;
diff -u -p linux/net/irda/ircomm_tty.d4.c linux/net/irda/ircomm_tty.c
--- linux/net/irda/ircomm/ircomm_tty.d4.c	Thu Dec 18 17:40:14 2003
+++ linux/net/irda/ircomm/ircomm_tty.c	Thu Dec 18 18:29:09 2003
@@ -182,15 +182,15 @@ void __exit ircomm_tty_cleanup(void)
 static int ircomm_tty_startup(struct ircomm_tty_cb *self)
 {
 	notify_t notify;
-	int ret;
+	int ret = -ENODEV;
 
 	IRDA_DEBUG(2, "%s()\n", __FUNCTION__ );
 
 	ASSERT(self != NULL, return -1;);
 	ASSERT(self->magic == IRCOMM_TTY_MAGIC, return -1;);
 
-	/* Already open */
-	if (self->flags & ASYNC_INITIALIZED) {
+	/* Check if already open */
+	if (test_and_set_bit(ASYNC_B_INITIALIZED, &self->flags)) {
 		IRDA_DEBUG(2, "%s(), already open so break out!\n", __FUNCTION__ );
 		return 0;
 	}
@@ -214,7 +214,7 @@ static int ircomm_tty_startup(struct irc
 					   self->line);
 	}
 	if (!self->ircomm)
-		return -ENODEV;
+		goto err;
 
 	self->slsap_sel = self->ircomm->slsap_sel;
 
@@ -222,12 +222,13 @@ static int ircomm_tty_startup(struct irc
 	ret = ircomm_tty_attach_cable(self);
 	if (ret < 0) {
 		ERROR("%s(), error attaching cable!\n", __FUNCTION__);
-		return ret;
+		goto err;
 	}
 
-	self->flags |= ASYNC_INITIALIZED;
-
 	return 0;
+err:
+	clear_bit(ASYNC_B_INITIALIZED, &self->flags);
+	return ret;
 }
 
 /*
@@ -300,7 +301,8 @@ static int ircomm_tty_block_til_ready(st
 		
 		current->state = TASK_INTERRUPTIBLE;
 		
-		if (tty_hung_up_p(filp) || !(self->flags & ASYNC_INITIALIZED)){
+		if (tty_hung_up_p(filp) ||
+		    !test_bit(ASYNC_B_INITIALIZED, &self->flags)) {
 			retval = (self->flags & ASYNC_HUP_NOTIFY) ?
 					-EAGAIN : -ERESTARTSYS;
 			break;
@@ -311,7 +313,7 @@ static int ircomm_tty_block_til_ready(st
 		 * specified, we cannot return before the IrCOMM link is
 		 * ready 
 		 */
- 		if (!(self->flags & ASYNC_CLOSING) &&
+ 		if (!test_bit(ASYNC_B_CLOSING, &self->flags) &&
  		    (do_clocal || (self->settings.dce & IRCOMM_CD)) &&
 		    self->state == IRCOMM_TTY_READY)
 		{
@@ -426,7 +428,7 @@ static int ircomm_tty_open(struct tty_st
 	 * If the port is the middle of closing, bail out now
 	 */
 	if (tty_hung_up_p(filp) ||
-	    (self->flags & ASYNC_CLOSING)) {
+	    test_bit(ASYNC_B_CLOSING, &self->flags)) {
 
 		/* Hm, why are we blocking on ASYNC_CLOSING if we
 		 * do return -EAGAIN/-ERESTARTSYS below anyway?
@@ -436,7 +438,7 @@ static int ircomm_tty_open(struct tty_st
 		 * probably better sleep uninterruptible?
 		 */
 
-		if (wait_event_interruptible(self->close_wait, !(self->flags&ASYNC_CLOSING))) {
+		if (wait_event_interruptible(self->close_wait, !test_bit(ASYNC_B_CLOSING, &self->flags))) {
 			WARNING("%s - got signal while blocking on ASYNC_CLOSING!\n",
 				__FUNCTION__);
 			return -ERESTARTSYS;
@@ -531,11 +533,13 @@ static void ircomm_tty_close(struct tty_
 		IRDA_DEBUG(0, "%s(), open count > 0\n", __FUNCTION__ );
 		return;
 	}
-	self->flags |= ASYNC_CLOSING;
+
+	/* Hum... Should be test_and_set_bit ??? - Jean II */
+	set_bit(ASYNC_B_CLOSING, &self->flags);
 
 	/* We need to unlock here (we were unlocking at the end of this
 	 * function), because tty_wait_until_sent() may schedule.
-	 * I don't know if the rest should be locked somehow,
+	 * I don't know if the rest should be protected somehow,
 	 * so someone should check. - Jean II */
 	spin_unlock_irqrestore(&self->spinlock, flags);
 
@@ -979,10 +983,12 @@ static void ircomm_tty_shutdown(struct i
 	ASSERT(self->magic == IRCOMM_TTY_MAGIC, return;);
 
 	IRDA_DEBUG(0, "%s()\n", __FUNCTION__ );
-	
-	if (!(self->flags & ASYNC_INITIALIZED))
+
+	if (!test_and_clear_bit(ASYNC_B_INITIALIZED, &self->flags))
 		return;
 
+	ircomm_tty_detach_cable(self);
+
 	spin_lock_irqsave(&self->spinlock, flags);
 
 	del_timer(&self->watchdog_timer);
@@ -999,13 +1005,10 @@ static void ircomm_tty_shutdown(struct i
 		self->tx_skb = NULL;
 	}
 
-	ircomm_tty_detach_cable(self);
-
 	if (self->ircomm) {
 		ircomm_close(self->ircomm);
 		self->ircomm = NULL;
 	}
-	self->flags &= ~ASYNC_INITIALIZED;
 
 	spin_unlock_irqrestore(&self->spinlock, flags);
 }
