Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265922AbVBDRci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265922AbVBDRci (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 12:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264739AbVBDRch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 12:32:37 -0500
Received: from mx1.redhat.com ([66.187.233.31]:36807 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265801AbVBDRbP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 12:31:15 -0500
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] FRV: cli/sti cleanup
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Fri, 04 Feb 2005 17:31:01 +0000
Message-ID: <28715.1107538261@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch cleans up the remaining references to the cli() and sti()
functions from the FRV arch now they're deprecated.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 frv-clisti-cleanup-2611rc3.diff 
 arch/frv/kernel/irq-routing.c |    4 ++--
 arch/frv/kernel/irq.c         |   12 ++++++------
 arch/frv/kernel/pm.c          |   12 ++++++------
 3 files changed, 14 insertions(+), 14 deletions(-)

diff -uNrp /warthog/kernels/linux-2.6.11-rc3/arch/frv/kernel/irq.c linux-2.6.11-rc3-frv/arch/frv/kernel/irq.c
--- /warthog/kernels/linux-2.6.11-rc3/arch/frv/kernel/irq.c	2005-02-04 11:49:30.000000000 +0000
+++ linux-2.6.11-rc3-frv/arch/frv/kernel/irq.c	2005-02-04 12:36:25.000000000 +0000
@@ -316,16 +316,16 @@ asmlinkage void do_IRQ(void)
 			do_softirq();
 
 #ifdef CONFIG_PREEMPT
-	cli();
+	local_irq_disable();
 	while (--current->preempt_count == 0) {
-		if (!(__frame->psr & PSR_S)
-		    || (current->need_resched == 0)
-		    || in_interrupt())
+		if (!(__frame->psr & PSR_S) ||
+		    current->need_resched == 0 ||
+		    in_interrupt())
 			break;
 		current->preempt_count++;
-		sti();
+		local_irq_enable();
 		preempt_schedule();
-		cli();
+		local_irq_disable();
 	}
 #endif
 
diff -uNrp /warthog/kernels/linux-2.6.11-rc3/arch/frv/kernel/irq-routing.c linux-2.6.11-rc3-frv/arch/frv/kernel/irq-routing.c
--- /warthog/kernels/linux-2.6.11-rc3/arch/frv/kernel/irq-routing.c	2005-02-04 11:49:30.000000000 +0000
+++ linux-2.6.11-rc3-frv/arch/frv/kernel/irq-routing.c	2005-02-04 12:36:46.000000000 +0000
@@ -82,7 +82,7 @@ void distribute_irqs(struct irq_group *g
 			int status = 0;
 
 //			if (!(action->flags & SA_INTERRUPT))
-//				sti();
+//				local_irq_enable();
 
 			do {
 				status |= action->flags;
@@ -92,7 +92,7 @@ void distribute_irqs(struct irq_group *g
 
 			if (status & SA_SAMPLE_RANDOM)
 				add_interrupt_randomness(irq);
-			cli();
+			local_irq_disable();
 		}
 	}
 }
diff -uNrp /warthog/kernels/linux-2.6.11-rc3/arch/frv/kernel/pm.c linux-2.6.11-rc3-frv/arch/frv/kernel/pm.c
--- /warthog/kernels/linux-2.6.11-rc3/arch/frv/kernel/pm.c	2005-02-04 11:49:30.000000000 +0000
+++ linux-2.6.11-rc3-frv/arch/frv/kernel/pm.c	2005-02-04 12:38:21.000000000 +0000
@@ -36,7 +36,7 @@ extern void frv_change_cmode(int);
 
 int pm_do_suspend(void)
 {
-	cli();
+	local_irq_disable();
 
 	__set_LEDS(0xb1);
 
@@ -45,7 +45,7 @@ int pm_do_suspend(void)
 
 	__set_LEDS(0xb2);
 
-	sti();
+	local_irq_enable();
 
 	return 0;
 }
@@ -84,7 +84,7 @@ void (*__power_switch_wake_cleanup)(void
 
 int pm_do_bus_sleep(void)
 {
-	cli();
+	local_irq_disable();
 
 	/*
          * Here is where we need some platform-dependent setup
@@ -113,7 +113,7 @@ int pm_do_bus_sleep(void)
 	 */
 	__power_switch_wake_cleanup();
 
-	sti();
+	local_irq_enable();
 
 	return 0;
 }
@@ -191,7 +191,7 @@ static int try_set_cmode(int new_cmode)
 	pm_send_all(PM_SUSPEND, (void *)3);
 
 	/* now change cmode */
-	cli();
+	local_irq_disable();
 	frv_dma_pause_all();
 
 	frv_change_cmode(new_cmode);
@@ -203,7 +203,7 @@ static int try_set_cmode(int new_cmode)
 	determine_clocks(1);
 #endif
 	frv_dma_resume_all();
-	sti();
+	local_irq_enable();
 
 	/* tell all the drivers we're resuming */
 	pm_send_all(PM_RESUME, (void *)0);
