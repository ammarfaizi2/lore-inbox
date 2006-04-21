Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbWDUQwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbWDUQwA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 12:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932291AbWDUQwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 12:52:00 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:41452 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S932213AbWDUQv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 12:51:59 -0400
Date: Fri, 21 Apr 2006 18:51:58 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: [PATCH] -mm: make noirqdebug/irqfixup __read_mostly, add (un)likely()
Message-ID: <20060421165158.GA5513@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

"noirqdebug" is checked in main IRQ handler, thus __read_mostly is useful.
Threw in an additional __read_mostly for "irqfixup" (that codepath is
enabled by default, too, thus also useful).
Add some (un)likely() in the hot paths of spurious IRQ detection code.

Patch compiled and tested on 2.6.17-rc1-mm3.
I did not test the arm part, though, for obvious reasons.

Those were the boring things, somewhat more interesting ones coming soon.

Thanks!

Signed-off-by: Andreas Mohr <andi@lisas.de>


--- linux-2.6.17-rc1-mm3.orig/kernel/irq/spurious.c	2006-04-18 11:45:16.000000000 +0200
+++ linux-2.6.17-rc1-mm3/kernel/irq/spurious.c	2006-04-21 18:14:19.000000000 +0200
@@ -11,7 +11,7 @@
 #include <linux/kallsyms.h>
 #include <linux/interrupt.h>
 
-static int irqfixup;
+static int irqfixup __read_mostly;
 
 /*
  * Recovery handler for misrouted interrupts.
@@ -138,7 +138,7 @@
 {
 	if (action_ret != IRQ_HANDLED) {
 		desc->irqs_unhandled++;
-		if (action_ret != IRQ_NONE)
+		if (unlikely(action_ret != IRQ_NONE))
 			report_bad_irq(irq, desc, action_ret);
 	}
 
@@ -152,7 +152,7 @@
 	}
 
 	desc->irq_count++;
-	if (desc->irq_count < 100000)
+	if (likely(desc->irq_count < 100000))
 		return;
 
 	desc->irq_count = 0;
@@ -171,7 +171,7 @@
 	desc->irqs_unhandled = 0;
 }
 
-int noirqdebug;
+int noirqdebug __read_mostly;
 
 int __init noirqdebug_setup(char *str)
 {
--- linux-2.6.17-rc1-mm3.orig/arch/arm/kernel/irq.c	2006-04-18 11:47:29.000000000 +0200
+++ linux-2.6.17-rc1-mm3/arch/arm/kernel/irq.c	2006-04-21 18:18:56.000000000 +0200
@@ -52,7 +52,7 @@
  */
 #define MAX_IRQ_CNT	100000
 
-static int noirqdebug;
+static int noirqdebug __read_mostly;
 static volatile unsigned long irq_err_count;
 static DEFINE_SPINLOCK(irq_controller_lock);
 static LIST_HEAD(irq_pending);
@@ -81,7 +81,7 @@
 
 void do_bad_IRQ(unsigned int irq, struct irqdesc *desc, struct pt_regs *regs)
 {
-	irq_err_count += 1;
+	irq_err_count++;
 	printk(KERN_ERR "IRQ: spurious interrupt %d\n", irq);
 }
 
