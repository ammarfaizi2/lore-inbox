Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbWGGAdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbWGGAdo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 20:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbWGGAdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 20:33:44 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:46787 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751107AbWGGAdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 20:33:42 -0400
Message-Id: <200607070033.k670XcXG008692@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 7/19] UML - timer handler tidying
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 06 Jul 2006 20:33:38 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Get rid of a user of timer_irq_inited (and first_tick) by observing
that prev_ticks can be used to decide if this is the first call.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16-rc-mm/arch/um/kernel/time_kern.c
===================================================================
--- linux-2.6.16-rc-mm.orig/arch/um/kernel/time_kern.c	2006-06-26 17:50:17.000000000 -0400
+++ linux-2.6.16-rc-mm/arch/um/kernel/time_kern.c	2006-06-28 13:07:08.000000000 -0400
@@ -38,7 +38,6 @@ unsigned long long sched_clock(void)
 /* Changed at early boot */
 int timer_irq_inited = 0;
 
-static int first_tick;
 static unsigned long long prev_nsecs;
 #ifdef CONFIG_UML_REAL_TIME_CLOCK
 static long long delta;   		/* Deviation per interval */
@@ -48,15 +47,8 @@ void timer_irq(union uml_pt_regs *regs)
 {
 	unsigned long long ticks = 0;
 
-	if(!timer_irq_inited){
-		/* This is to ensure that ticks don't pile up when
-		 * the timer handler is suspended */
-		first_tick = 0;
-		return;
-	}
-
-	if(first_tick){
 #ifdef CONFIG_UML_REAL_TIME_CLOCK
+	if(prev_nsecs){
 		/* We've had 1 tick */
 		unsigned long long nsecs = os_nsecs();
 
@@ -69,15 +61,11 @@ void timer_irq(union uml_pt_regs *regs)
 
 		ticks += (delta * HZ) / BILLION;
 		delta -= (ticks * BILLION) / HZ;
+	}
+	else prev_nsecs = os_nsecs();
 #else
-		ticks = 1;
+	ticks = 1;
 #endif
-	}
-	else {
-		prev_nsecs = os_nsecs();
-		first_tick = 1;
-	}
-
 	while(ticks > 0){
 		do_IRQ(TIMER_IRQ, regs);
 		ticks--;

