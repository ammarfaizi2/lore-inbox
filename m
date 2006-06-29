Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932766AbWF2Vil@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932766AbWF2Vil (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 17:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932754AbWF2Vik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 17:38:40 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:23520 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932755AbWF2Vge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:36:34 -0400
Message-Id: <200606292136.k5TLaXHZ010812@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 5/9] UML - Add locking to xtime accesses
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 29 Jun 2006 17:36:32 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

do_timer must be called with xtime_lock held. I'm not sure
boot_timer_handler needs this, however I don't think it hurts: it simply
disables irq and takes a spinlock.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Index: linux-2.6.17/arch/um/kernel/time_kern.c
===================================================================
--- linux-2.6.17.orig/arch/um/kernel/time_kern.c	2006-06-29 10:37:16.000000000 -0400
+++ linux-2.6.17/arch/um/kernel/time_kern.c	2006-06-29 11:39:57.000000000 -0400
@@ -96,11 +96,15 @@ void time_init_kern(void)
 
 void do_boot_timer_handler(struct sigcontext * sc)
 {
+	unsigned long flags;
 	struct pt_regs regs;
 
 	CHOOSE_MODE((void) (UPT_SC(&regs.regs) = sc),
 		    (void) (regs.regs.skas.is_user = 0));
+
+	write_seqlock_irqsave(&xtime_lock, flags);
 	do_timer(&regs);
+	write_sequnlock_irqrestore(&xtime_lock, flags);
 }
 
 static DEFINE_SPINLOCK(timer_spinlock);
@@ -125,15 +129,17 @@ irqreturn_t um_timer(int irq, void *dev,
 	unsigned long long nsecs;
 	unsigned long flags;
 
+	write_seqlock_irqsave(&xtime_lock, flags);
+
 	do_timer(regs);
 
-	write_seqlock_irqsave(&xtime_lock, flags);
 	nsecs = get_time() + local_offset;
 	xtime.tv_sec = nsecs / NSEC_PER_SEC;
 	xtime.tv_nsec = nsecs - xtime.tv_sec * NSEC_PER_SEC;
+
 	write_sequnlock_irqrestore(&xtime_lock, flags);
 
-	return(IRQ_HANDLED);
+	return IRQ_HANDLED;
 }
 
 long um_time(int __user *tloc)

