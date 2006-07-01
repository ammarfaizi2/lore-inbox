Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030186AbWGAPDG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030186AbWGAPDG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 11:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751902AbWGAO5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 10:57:41 -0400
Received: from www.osadl.org ([213.239.205.134]:43172 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751863AbWGAO5O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 10:57:14 -0400
Message-Id: <20060701145225.646863000@cruncher.tec.linutronix.de>
References: <20060701145211.856500000@cruncher.tec.linutronix.de>
Date: Sat, 01 Jul 2006 14:54:43 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       David Miller <davem@davemloft.net>, davem@davemloft.net
Subject: [RFC][patch 21/44] SPARC: Use the new IRQF_ constansts
Content-Disposition: inline; filename=irqflags-sparc.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use the new IRQF_ constants and remove the SA_INTERRUPT define

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
 arch/sparc/kernel/irq.c       |   14 +++++++-------
 arch/sparc/kernel/pcic.c      |    2 +-
 arch/sparc/kernel/sun4c_irq.c |    2 +-
 arch/sparc/kernel/sun4d_irq.c |   12 ++++++------
 arch/sparc/kernel/sun4m_irq.c |    2 +-
 arch/sparc/kernel/tick14.c    |    2 +-
 include/asm-sparc/floppy.h    |    3 ++-
 include/asm-sparc/signal.h    |    3 ---
 8 files changed, 19 insertions(+), 21 deletions(-)

Index: linux-2.6.git/include/asm-sparc/floppy.h
===================================================================
--- linux-2.6.git.orig/include/asm-sparc/floppy.h	2006-07-01 16:51:22.000000000 +0200
+++ linux-2.6.git/include/asm-sparc/floppy.h	2006-07-01 16:51:37.000000000 +0200
@@ -271,7 +271,8 @@ static int sun_fd_request_irq(void)
 
 	if(!once) {
 		once = 1;
-		error = request_fast_irq(FLOPPY_IRQ, floppy_hardint, SA_INTERRUPT, "floppy");
+		error = request_fast_irq(FLOPPY_IRQ, floppy_hardint,
+					 IRQF_DISABLED, "floppy");
 		return ((error == 0) ? 0 : -1);
 	} else return 0;
 }
Index: linux-2.6.git/include/asm-sparc/signal.h
===================================================================
--- linux-2.6.git.orig/include/asm-sparc/signal.h	2006-07-01 16:51:22.000000000 +0200
+++ linux-2.6.git/include/asm-sparc/signal.h	2006-07-01 16:51:37.000000000 +0200
@@ -132,16 +132,13 @@ struct sigstack {
  * usage of signal stacks by using the (now obsolete) sa_restorer field in
  * the sigaction structure as a stack pointer. This is now possible due to
  * the changes in signal handling. LBT 010493.
- * SA_INTERRUPT is a no-op, but left due to historical reasons. Use the
  * SA_RESTART flag to get restarting signals (which were the default long ago)
- * SA_SHIRQ flag is for shared interrupt support on PCI and EISA.
  */
 #define SA_NOCLDSTOP	_SV_IGNCHILD
 #define SA_STACK	_SV_SSTACK
 #define SA_ONSTACK	_SV_SSTACK
 #define SA_RESTART	_SV_INTR
 #define SA_ONESHOT	_SV_RESET
-#define SA_INTERRUPT	0x10u
 #define SA_NOMASK	0x20u
 #define SA_NOCLDWAIT	0x100u
 #define SA_SIGINFO	0x200u
Index: linux-2.6.git/arch/sparc/kernel/irq.c
===================================================================
--- linux-2.6.git.orig/arch/sparc/kernel/irq.c	2006-07-01 16:51:22.000000000 +0200
+++ linux-2.6.git/arch/sparc/kernel/irq.c	2006-07-01 16:51:37.000000000 +0200
@@ -191,11 +191,11 @@ int show_interrupts(struct seq_file *p, 
 		}
 #endif
 		seq_printf(p, " %c %s",
-			(action->flags & SA_INTERRUPT) ? '+' : ' ',
+			(action->flags & IRQF_DISABLED) ? '+' : ' ',
 			action->name);
 		for (action=action->next; action; action = action->next) {
 			seq_printf(p, ",%s %s",
-				(action->flags & SA_INTERRUPT) ? " +" : "",
+				(action->flags & IRQF_DISABLED) ? " +" : "",
 				action->name);
 		}
 		seq_putc(p, '\n');
@@ -243,7 +243,7 @@ void free_irq(unsigned int irq, void *de
 			printk("Trying to free free shared IRQ%d\n",irq);
 			goto out_unlock;
 		}
-	} else if (action->flags & SA_SHIRQ) {
+	} else if (action->flags & IRQF_SHARED) {
 		printk("Trying to free shared IRQ%d with NULL device ID\n", irq);
 		goto out_unlock;
 	}
@@ -395,9 +395,9 @@ int request_fast_irq(unsigned int irq,
 
 	action = sparc_irq[cpu_irq].action;
 	if(action) {
-		if(action->flags & SA_SHIRQ)
+		if(action->flags & IRQF_SHARED)
 			panic("Trying to register fast irq when already shared.\n");
-		if(irqflags & SA_SHIRQ)
+		if(irqflags & IRQF_SHARED)
 			panic("Trying to register fast irq as shared.\n");
 
 		/* Anyway, someone already owns it so cannot be made fast. */
@@ -497,11 +497,11 @@ int request_irq(unsigned int irq,
 	actionp = &sparc_irq[cpu_irq].action;
 	action = *actionp;
 	if (action) {
-		if (!(action->flags & SA_SHIRQ) || !(irqflags & SA_SHIRQ)) {
+		if (!(action->flags & IRQF_SHARED) || !(irqflags & IRQF_SHARED)) {
 			ret = -EBUSY;
 			goto out_unlock;
 		}
-		if ((action->flags & SA_INTERRUPT) != (irqflags & SA_INTERRUPT)) {
+		if ((action->flags & IRQF_DISABLED) != (irqflags & IRQF_DISABLED)) {
 			printk("Attempt to mix fast and slow interrupts on IRQ%d denied\n", irq);
 			ret = -EBUSY;
 			goto out_unlock;
Index: linux-2.6.git/arch/sparc/kernel/pcic.c
===================================================================
--- linux-2.6.git.orig/arch/sparc/kernel/pcic.c	2006-07-01 16:51:22.000000000 +0200
+++ linux-2.6.git/arch/sparc/kernel/pcic.c	2006-07-01 16:51:37.000000000 +0200
@@ -745,7 +745,7 @@ void __init pci_time_init(void)
 	writel (PCI_COUNTER_IRQ_SET(timer_irq, 0),
 		pcic->pcic_regs+PCI_COUNTER_IRQ);
 	irq = request_irq(timer_irq, pcic_timer_handler,
-			  (SA_INTERRUPT | SA_STATIC_ALLOC), "timer", NULL);
+			  (IRQF_DISABLED | SA_STATIC_ALLOC), "timer", NULL);
 	if (irq) {
 		prom_printf("time_init: unable to attach IRQ%d\n", timer_irq);
 		prom_halt();
Index: linux-2.6.git/arch/sparc/kernel/sun4c_irq.c
===================================================================
--- linux-2.6.git.orig/arch/sparc/kernel/sun4c_irq.c	2006-07-01 16:51:22.000000000 +0200
+++ linux-2.6.git/arch/sparc/kernel/sun4c_irq.c	2006-07-01 16:51:37.000000000 +0200
@@ -179,7 +179,7 @@ static void __init sun4c_init_timers(irq
 
 	irq = request_irq(TIMER_IRQ,
 			  counter_fn,
-			  (SA_INTERRUPT | SA_STATIC_ALLOC),
+			  (IRQF_DISABLED | SA_STATIC_ALLOC),
 			  "timer", NULL);
 	if (irq) {
 		prom_printf("time_init: unable to attach IRQ%d\n",TIMER_IRQ);
Index: linux-2.6.git/arch/sparc/kernel/sun4d_irq.c
===================================================================
--- linux-2.6.git.orig/arch/sparc/kernel/sun4d_irq.c	2006-07-01 16:51:22.000000000 +0200
+++ linux-2.6.git/arch/sparc/kernel/sun4d_irq.c	2006-07-01 16:51:37.000000000 +0200
@@ -107,13 +107,13 @@ found_it:	seq_printf(p, "%3d: ", i);
 			       kstat_cpu(cpu_logical_map(x)).irqs[i]);
 #endif
 		seq_printf(p, "%c %s",
-			(action->flags & SA_INTERRUPT) ? '+' : ' ',
+			(action->flags & IRQF_DISABLED) ? '+' : ' ',
 			action->name);
 		action = action->next;
 		for (;;) {
 			for (; action; action = action->next) {
 				seq_printf(p, ",%s %s",
-					(action->flags & SA_INTERRUPT) ? " +" : "",
+					(action->flags & IRQF_DISABLED) ? " +" : "",
 					action->name);
 			}
 			if (!sbusl) break;
@@ -160,7 +160,7 @@ void sun4d_free_irq(unsigned int irq, vo
 			printk("Trying to free free shared IRQ%d\n",irq);
 			goto out_unlock;
 		}
-	} else if (action->flags & SA_SHIRQ) {
+	} else if (action->flags & IRQF_SHARED) {
 		printk("Trying to free shared IRQ%d with NULL device ID\n", irq);
 		goto out_unlock;
 	}
@@ -298,13 +298,13 @@ int sun4d_request_irq(unsigned int irq,
 	action = *actionp;
 	
 	if (action) {
-		if ((action->flags & SA_SHIRQ) && (irqflags & SA_SHIRQ)) {
+		if ((action->flags & IRQF_SHARED) && (irqflags & IRQF_SHARED)) {
 			for (tmp = action; tmp->next; tmp = tmp->next);
 		} else {
 			ret = -EBUSY;
 			goto out_unlock;
 		}
-		if ((action->flags & SA_INTERRUPT) ^ (irqflags & SA_INTERRUPT)) {
+		if ((action->flags & IRQF_DISABLED) ^ (irqflags & IRQF_DISABLED)) {
 			printk("Attempt to mix fast and slow interrupts on IRQ%d denied\n", irq);
 			ret = -EBUSY;
 			goto out_unlock;
@@ -490,7 +490,7 @@ static void __init sun4d_init_timers(irq
 
 	irq = request_irq(TIMER_IRQ,
 			  counter_fn,
-			  (SA_INTERRUPT | SA_STATIC_ALLOC),
+			  (IRQF_DISABLED | SA_STATIC_ALLOC),
 			  "timer", NULL);
 	if (irq) {
 		prom_printf("time_init: unable to attach IRQ%d\n",TIMER_IRQ);
Index: linux-2.6.git/arch/sparc/kernel/sun4m_irq.c
===================================================================
--- linux-2.6.git.orig/arch/sparc/kernel/sun4m_irq.c	2006-07-01 16:51:22.000000000 +0200
+++ linux-2.6.git/arch/sparc/kernel/sun4m_irq.c	2006-07-01 16:51:37.000000000 +0200
@@ -278,7 +278,7 @@ static void __init sun4m_init_timers(irq
 
 	irq = request_irq(TIMER_IRQ,
 			  counter_fn,
-			  (SA_INTERRUPT | SA_STATIC_ALLOC),
+			  (IRQF_DISABLED | SA_STATIC_ALLOC),
 			  "timer", NULL);
 	if (irq) {
 		prom_printf("time_init: unable to attach IRQ%d\n",TIMER_IRQ);
Index: linux-2.6.git/arch/sparc/kernel/tick14.c
===================================================================
--- linux-2.6.git.orig/arch/sparc/kernel/tick14.c	2006-07-01 16:51:22.000000000 +0200
+++ linux-2.6.git/arch/sparc/kernel/tick14.c	2006-07-01 16:51:37.000000000 +0200
@@ -74,7 +74,7 @@ void claim_ticker14(irqreturn_t (*handle
 
 	if (!request_irq(irq_nr,
 			 handler,
-			 (SA_INTERRUPT | SA_STATIC_ALLOC),
+			 (IRQF_DISABLED | SA_STATIC_ALLOC),
 			 "counter14",
 			 NULL)) {
 		install_linux_ticker();

--

