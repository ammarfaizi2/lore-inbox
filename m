Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266997AbTGHKMU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 06:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267017AbTGHKMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 06:12:20 -0400
Received: from griffon.mipsys.com ([217.167.51.129]:6137 "EHLO gaston")
	by vger.kernel.org with ESMTP id S266997AbTGHKMP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 06:12:15 -0400
Subject: Re: [PATCH] timer clean up for i2c-keywest.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Greg KH <greg@kroah.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <16137.6948.764603.59450@cargo.ozlabs.ibm.com>
References: <16137.6948.764603.59450@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1057659989.11708.113.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 08 Jul 2003 12:26:29 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-07-07 at 09:03, Paul Mackerras wrote:
> This patch changes i2c-keywest.c to use mod_timer instead of a
> two-line sequence to compute .expires and call add_timer in 3 places.
> Without this patch I get a BUG from time to time in add_timer.

Ok, here it is. It also remove the never used "polled" mode. The
driver is now in sync with the more up-to-date 2.4 version ;)

Sorry for not sending that earlier, I forgot about it and didn't
notice it was out of sync.

Ben.

===== drivers/i2c/i2c-keywest.c 1.2 vs edited =====
--- 1.2/drivers/i2c/i2c-keywest.c	Wed Apr 23 13:32:32 2003
+++ edited/drivers/i2c/i2c-keywest.c	Tue Jul  8 12:16:51 2003
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
@@ -219,8 +196,7 @@
 
 	spin_lock(&iface->lock);
 	del_timer(&iface->timeout_timer);
-	handle_interrupt(iface, read_reg(reg_isr));
-	if (iface->state != state_idle) {
+	if (handle_interrupt(iface, read_reg(reg_isr))) {
 		iface->timeout_timer.expires = jiffies + POLL_TIMEOUT;
 		add_timer(&iface->timeout_timer);
 	}
@@ -235,16 +211,13 @@
 
 	DBG("timeout !\n");
 	spin_lock_irq(&iface->lock);
-	handle_interrupt(iface, read_reg(reg_isr));
-	if (iface->state != state_idle) {
+	if (handle_interrupt(iface, read_reg(reg_isr))) {
 		iface->timeout_timer.expires = jiffies + POLL_TIMEOUT;
 		add_timer(&iface->timeout_timer);
 	}
 	spin_unlock(&iface->lock);
 }
 
-#endif /* POLLED_MODE */
-
 /*
  * SMBUS-type transfer entrypoint
  */
@@ -338,17 +311,7 @@
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
@@ -428,17 +391,7 @@
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
@@ -540,8 +493,8 @@
 			*prate);
 	}
 	
-	/* Select standard sub mode */
-	iface->cur_mode |= KW_I2C_MODE_STANDARDSUB;
+	/* Select standard mode by default */
+	iface->cur_mode |= KW_I2C_MODE_STANDARD;
 	
 	/* Write mode */
 	write_reg(reg_mode, iface->cur_mode);
@@ -550,7 +503,6 @@
 	write_reg(reg_ier, 0x00);
 	write_reg(reg_isr, KW_I2C_IRQ_MASK);
 
-#ifndef POLLED_MODE
 	/* Request chip interrupt */	
 	rc = request_irq(iface->irq, keywest_irq, 0, "keywest i2c", iface);
 	if (rc) {
@@ -559,7 +511,6 @@
 		kfree(iface);
 		return -ENODEV;
 	}
-#endif /* POLLED_MODE */
 
 	for (i=0; i<nchan; i++) {
 		struct keywest_chan* chan = &iface->channels[i];
@@ -609,19 +560,16 @@
 
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

