Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932304AbWEQAQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbWEQAQG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 20:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbWEQAQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 20:16:05 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:19152 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932299AbWEQAP6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 20:15:58 -0400
Date: Wed, 17 May 2006 02:15:45 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: [patch 08/50] genirq: cleanup: merge pending_irq_cpumask[] into irq_desc[]
Message-ID: <20060517001545.GI12877@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

consolidation: remove the pending_irq_cpumask[NR_IRQS] array and move it
into the irq_desc[NR_IRQS].pending_mask field.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/i386/kernel/io_apic.c |    2 +-
 include/linux/irq.h        |    2 +-
 kernel/irq/manage.c        |    4 ----
 kernel/irq/migration.c     |    8 ++++----
 4 files changed, 6 insertions(+), 10 deletions(-)

Index: linux-genirq.q/arch/i386/kernel/io_apic.c
===================================================================
--- linux-genirq.q.orig/arch/i386/kernel/io_apic.c
+++ linux-genirq.q/arch/i386/kernel/io_apic.c
@@ -570,7 +570,7 @@ static int balanced_irq(void *unused)
 	
 	/* push everything to CPU 0 to give us a starting point.  */
 	for (i = 0 ; i < NR_IRQS ; i++) {
-		pending_irq_cpumask[i] = cpumask_of_cpu(0);
+		irq_desc[i].pending_mask = cpumask_of_cpu(0);
 		set_pending_irq(i, cpumask_of_cpu(0));
 	}
 
Index: linux-genirq.q/include/linux/irq.h
===================================================================
--- linux-genirq.q.orig/include/linux/irq.h
+++ linux-genirq.q/include/linux/irq.h
@@ -83,6 +83,7 @@ struct irq_desc {
 	cpumask_t		affinity;
 #endif
 #if defined(CONFIG_GENERIC_PENDING_IRQ) || defined(CONFIG_IRQBALANCE)
+	cpumask_t		pending_mask;
 	unsigned int		move_irq;	/* need to re-target IRQ dest */
 #endif
 #ifdef CONFIG_PROC_FS
@@ -123,7 +124,6 @@ static inline void set_native_irq_info(i
 #ifdef CONFIG_SMP
 
 #if defined(CONFIG_GENERIC_PENDING_IRQ) || defined(CONFIG_IRQBALANCE)
-extern cpumask_t pending_irq_cpumask[NR_IRQS];
 
 void set_pending_irq(unsigned int irq, cpumask_t mask);
 void move_native_irq(int irq);
Index: linux-genirq.q/kernel/irq/manage.c
===================================================================
--- linux-genirq.q.orig/kernel/irq/manage.c
+++ linux-genirq.q/kernel/irq/manage.c
@@ -16,10 +16,6 @@
 
 #ifdef CONFIG_SMP
 
-#if defined (CONFIG_GENERIC_PENDING_IRQ) || defined (CONFIG_IRQBALANCE)
-cpumask_t __cacheline_aligned pending_irq_cpumask[NR_IRQS];
-#endif
-
 /**
  *	synchronize_irq - wait for pending IRQ handlers (on other CPUs)
  *	@irq: interrupt number to wait for
Index: linux-genirq.q/kernel/irq/migration.c
===================================================================
--- linux-genirq.q.orig/kernel/irq/migration.c
+++ linux-genirq.q/kernel/irq/migration.c
@@ -8,7 +8,7 @@ void set_pending_irq(unsigned int irq, c
 
 	spin_lock_irqsave(&desc->lock, flags);
 	desc->move_irq = 1;
-	pending_irq_cpumask[irq] = mask;
+	irq_desc[irq].pending_mask = mask;
 	spin_unlock_irqrestore(&desc->lock, flags);
 }
 
@@ -30,7 +30,7 @@ void move_native_irq(int irq)
 
 	desc->move_irq = 0;
 
-	if (likely(cpus_empty(pending_irq_cpumask[irq])))
+	if (likely(cpus_empty(irq_desc[irq].pending_mask)))
 		return;
 
 	if (!desc->handler->set_affinity)
@@ -38,7 +38,7 @@ void move_native_irq(int irq)
 
 	assert_spin_locked(&desc->lock);
 
-	cpus_and(tmp, pending_irq_cpumask[irq], cpu_online_map);
+	cpus_and(tmp, irq_desc[irq].pending_mask, cpu_online_map);
 
 	/*
 	 * If there was a valid mask to work with, please
@@ -58,5 +58,5 @@ void move_native_irq(int irq)
 		if (likely(!(desc->status & IRQ_DISABLED)))
 			desc->handler->enable(irq);
 	}
-	cpus_clear(pending_irq_cpumask[irq]);
+	cpus_clear(irq_desc[irq].pending_mask);
 }
