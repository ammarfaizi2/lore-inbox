Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270268AbTGSPnA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 11:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270150AbTGSPlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 11:41:53 -0400
Received: from mail.kroah.org ([65.200.24.183]:21664 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270268AbTGSPkF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 11:40:05 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10586300933079@kroah.com>
Subject: Re: [PATCH] i2c driver changes 2.6.0-test1
In-Reply-To: <10586300923537@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Sat, 19 Jul 2003 08:54:53 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1358.10.3, 2003/07/10 13:26:49-07:00, benh@kernel.crashing.org

[PATCH] I2C: timer clean up for i2c-keywest.c

On Tue, 2003-07-08 at 12:26, Benjamin Herrenschmidt wrote:
> On Mon, 2003-07-07 at 09:03, Paul Mackerras wrote:
> > This patch changes i2c-keywest.c to use mod_timer instead of a
> > two-line sequence to compute .expires and call add_timer in 3 places.
> > Without this patch I get a BUG from time to time in add_timer.
>
> Ok, here it is. It also remove the never used "polled" mode. The
> driver is now in sync with the more up-to-date 2.4 version ;)
>
> Sorry for not sending that earlier, I forgot about it and didn't
> notice it was out of sync.

And just in case you didn't merge it yet... Here's a version changing
the timer->expire ; add_timer() pairs into calls to mod_timer, makes
the code slighly cleaner.


 drivers/i2c/i2c-keywest.c |   90 ++++++++--------------------------------------
 1 files changed, 16 insertions(+), 74 deletions(-)


diff -Nru a/drivers/i2c/i2c-keywest.c b/drivers/i2c/i2c-keywest.c
--- a/drivers/i2c/i2c-keywest.c	Sat Jul 19 08:48:26 2003
+++ b/drivers/i2c/i2c-keywest.c	Sat Jul 19 08:48:26 2003
@@ -66,8 +66,6 @@
 
 #include "i2c-keywest.h"
 
-#undef POLLED_MODE
-
 #define DBG(x...) do {\
 	if (debug > 0) \
 		printk(KERN_DEBUG "KW:" x); \
@@ -85,27 +83,6 @@
 
 static struct keywest_iface *ifaces = NULL;
 
-#ifdef POLLED_MODE
-/* This isn't fast, but will go once I implement interrupt with
- * proper timeout
- */
-static u8
-wait_interrupt(struct keywest_iface* iface)
-{
-	int i;
-	u8 isr;
-	
-	for (i = 0; i < POLL_TIMEOUT; i++) {
-		isr = read_reg(reg_isr) & KW_I2C_IRQ_MASK;
-		if (isr != 0)
-			return isr;
-		current->state = TASK_UNINTERRUPTIBLE;
-		schedule_timeout(1);
-	}
-	return isr;
-}
-#endif /* POLLED_MODE */
-
 
 static void
 do_stop(struct keywest_iface* iface, int result)
@@ -116,16 +93,17 @@
 }
 
 /* Main state machine for standard & standard sub mode */
-static void
+static int
 handle_interrupt(struct keywest_iface *iface, u8 isr)
 {
 	int ack;
+	int rearm_timer = 1;
 	
 	DBG("handle_interrupt(), got: %x, status: %x, state: %d\n",
 		isr, read_reg(reg_status), iface->state);
 	if (isr == 0 && iface->state != state_stop) {
 		do_stop(iface, -1);
-		return;
+		return rearm_timer;
 	}
 	if (isr & KW_I2C_IRQ_STOP && iface->state != state_stop) {
 		iface->result = -1;
@@ -196,20 +174,19 @@
 		if (!(isr & KW_I2C_IRQ_STOP) && (++iface->stopretry) < 10)
 			do_stop(iface, -1);
 		else {
+			rearm_timer = 0;
 			iface->state = state_idle;
 			write_reg(reg_control, 0x00);
 			write_reg(reg_ier, 0x00);
-#ifndef POLLED_MODE
 			complete(&iface->complete);
-#endif /* POLLED_MODE */			
 		}
 		break;
 	}
 	
 	write_reg(reg_isr, isr);
-}
 
-#ifndef POLLED_MODE
+	return rearm_timer;
+}
 
 /* Interrupt handler */
 static irqreturn_t
@@ -219,11 +196,8 @@
 
 	spin_lock(&iface->lock);
 	del_timer(&iface->timeout_timer);
-	handle_interrupt(iface, read_reg(reg_isr));
-	if (iface->state != state_idle) {
-		iface->timeout_timer.expires = jiffies + POLL_TIMEOUT;
-		add_timer(&iface->timeout_timer);
-	}
+	if (handle_interrupt(iface, read_reg(reg_isr)))
+		mod_timer(&iface->timeout_timer, jiffies + POLL_TIMEOUT);
 	spin_unlock(&iface->lock);
 	return IRQ_HANDLED;
 }
@@ -235,16 +209,11 @@
 
 	DBG("timeout !\n");
 	spin_lock_irq(&iface->lock);
-	handle_interrupt(iface, read_reg(reg_isr));
-	if (iface->state != state_idle) {
-		iface->timeout_timer.expires = jiffies + POLL_TIMEOUT;
-		add_timer(&iface->timeout_timer);
-	}
+	if (handle_interrupt(iface, read_reg(reg_isr)))
+		mod_timer(&iface->timeout_timer, jiffies + POLL_TIMEOUT);
 	spin_unlock(&iface->lock);
 }
 
-#endif /* POLLED_MODE */
-
 /*
  * SMBUS-type transfer entrypoint
  */
@@ -331,24 +300,13 @@
 		write_reg(reg_subaddr, command);
 
 	/* Arm timeout */
-	iface->timeout_timer.expires = jiffies + POLL_TIMEOUT;
-	add_timer(&iface->timeout_timer);
+	mod_timer(&iface->timeout_timer, jiffies + POLL_TIMEOUT);
 
 	/* Start sending address & enable interrupt*/
 	write_reg(reg_control, read_reg(reg_control) | KW_I2C_CTL_XADDR);
 	write_reg(reg_ier, KW_I2C_IRQ_MASK);
 
-#ifdef POLLED_MODE
-	DBG("using polled mode...\n");
-	/* State machine, to turn into an interrupt handler */
-	while(iface->state != state_idle) {
-		u8 isr = wait_interrupt(iface);
-		handle_interrupt(iface, isr);
-	}
-#else /* POLLED_MODE */
-	DBG("using interrupt mode...\n");
 	wait_for_completion(&iface->complete);	
-#endif /* POLLED_MODE */	
 
 	rc = iface->result;	
 	DBG("transfer done, result: %d\n", rc);
@@ -421,24 +379,13 @@
 			((iface->read_write == I2C_SMBUS_READ) ? 0x01 : 0x00));
 
 		/* Arm timeout */
-		iface->timeout_timer.expires = jiffies + POLL_TIMEOUT;
-		add_timer(&iface->timeout_timer);
+		mod_timer(&iface->timeout_timer, jiffies + POLL_TIMEOUT);
 
 		/* Start sending address & enable interrupt*/
 		write_reg(reg_control, read_reg(reg_control) | KW_I2C_CTL_XADDR);
 		write_reg(reg_ier, KW_I2C_IRQ_MASK);
 
-#ifdef POLLED_MODE
-		DBG("using polled mode...\n");
-		/* State machine, to turn into an interrupt handler */
-		while(iface->state != state_idle) {
-			u8 isr = wait_interrupt(iface);
-			handle_interrupt(iface, isr);
-		}
-#else /* POLLED_MODE */
-		DBG("using interrupt mode...\n");
 		wait_for_completion(&iface->complete);	
-#endif /* POLLED_MODE */	
 
 		rc = iface->result;
 		if (rc == 0)
@@ -540,8 +487,8 @@
 			*prate);
 	}
 	
-	/* Select standard sub mode */
-	iface->cur_mode |= KW_I2C_MODE_STANDARDSUB;
+	/* Select standard mode by default */
+	iface->cur_mode |= KW_I2C_MODE_STANDARD;
 	
 	/* Write mode */
 	write_reg(reg_mode, iface->cur_mode);
@@ -550,7 +497,6 @@
 	write_reg(reg_ier, 0x00);
 	write_reg(reg_isr, KW_I2C_IRQ_MASK);
 
-#ifndef POLLED_MODE
 	/* Request chip interrupt */	
 	rc = request_irq(iface->irq, keywest_irq, 0, "keywest i2c", iface);
 	if (rc) {
@@ -559,7 +505,6 @@
 		kfree(iface);
 		return -ENODEV;
 	}
-#endif /* POLLED_MODE */
 
 	for (i=0; i<nchan; i++) {
 		struct keywest_chan* chan = &iface->channels[i];
@@ -609,19 +554,16 @@
 
 	/* Make sure we stop all activity */
 	down(&iface->sem);
-#ifndef POLLED_MODE
 	spin_lock_irq(&iface->lock);
 	while (iface->state != state_idle) {
 		spin_unlock_irq(&iface->lock);
-		schedule();
+		set_task_state(current,TASK_UNINTERRUPTIBLE);
+		schedule_timeout(HZ/10);
 		spin_lock_irq(&iface->lock);
 	}
-#endif /* POLLED_MODE */
 	iface->state = state_dead;
-#ifndef POLLED_MODE
 	spin_unlock_irq(&iface->lock);
 	free_irq(iface->irq, iface);
-#endif /* POLLED_MODE */
 	up(&iface->sem);
 
 	/* Release all channels */

