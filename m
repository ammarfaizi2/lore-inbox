Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750989AbWEQANr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbWEQANr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 20:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751001AbWEQANr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 20:13:47 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:42456 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750993AbWEQANp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 20:13:45 -0400
Date: Wed, 17 May 2006 02:13:24 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: [patch 01/50] genirq: cleanup: merge irq_affinity[] into irq_desc[]
Message-ID: <20060517001323.GB12877@elte.hu>
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

consolidation: remove the irq_affinity[NR_IRQS] array and move it
into the irq_desc[NR_IRQS].affinity field.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/alpha/kernel/irq.c               |    2 +-
 arch/i386/kernel/io_apic.c            |    4 ++--
 arch/i386/kernel/irq.c                |    2 +-
 arch/ia64/kernel/irq.c                |    4 ++--
 arch/parisc/kernel/irq.c              |    8 ++++----
 arch/powerpc/kernel/irq.c             |    2 +-
 arch/powerpc/platforms/pseries/xics.c |    2 +-
 arch/x86_64/kernel/irq.c              |    2 +-
 include/linux/irq.h                   |    7 ++++---
 kernel/irq/handle.c                   |    5 ++++-
 kernel/irq/manage.c                   |    2 --
 kernel/irq/proc.c                     |    4 ++--
 12 files changed, 23 insertions(+), 21 deletions(-)

Index: linux-genirq.q/arch/alpha/kernel/irq.c
===================================================================
--- linux-genirq.q.orig/arch/alpha/kernel/irq.c
+++ linux-genirq.q/arch/alpha/kernel/irq.c
@@ -56,7 +56,7 @@ select_smp_affinity(unsigned int irq)
 		cpu = (cpu < (NR_CPUS-1) ? cpu + 1 : 0);
 	last_cpu = cpu;
 
-	irq_affinity[irq] = cpumask_of_cpu(cpu);
+	irq_desc[irq].affinity = cpumask_of_cpu(cpu);
 	irq_desc[irq].handler->set_affinity(irq, cpumask_of_cpu(cpu));
 	return 0;
 }
Index: linux-genirq.q/arch/i386/kernel/io_apic.c
===================================================================
--- linux-genirq.q.orig/arch/i386/kernel/io_apic.c
+++ linux-genirq.q/arch/i386/kernel/io_apic.c
@@ -340,7 +340,7 @@ static inline void balance_irq(int cpu, 
 	if (irqbalance_disabled)
 		return; 
 
-	cpus_and(allowed_mask, cpu_online_map, irq_affinity[irq]);
+	cpus_and(allowed_mask, cpu_online_map, irq_desc[irq].affinity);
 	new_cpu = move(cpu, allowed_mask, now, 1);
 	if (cpu != new_cpu) {
 		set_pending_irq(irq, cpumask_of_cpu(new_cpu));
@@ -529,7 +529,7 @@ tryanotherirq:
 		}
 	}
 
-	cpus_and(allowed_mask, cpu_online_map, irq_affinity[selected_irq]);
+	cpus_and(allowed_mask, cpu_online_map, irq_desc[selected_irq].affinity);
 	target_cpu_mask = cpumask_of_cpu(min_loaded);
 	cpus_and(tmp, target_cpu_mask, allowed_mask);
 
Index: linux-genirq.q/arch/i386/kernel/irq.c
===================================================================
--- linux-genirq.q.orig/arch/i386/kernel/irq.c
+++ linux-genirq.q/arch/i386/kernel/irq.c
@@ -277,7 +277,7 @@ void fixup_irqs(cpumask_t map)
 		if (irq == 2)
 			continue;
 
-		cpus_and(mask, irq_affinity[irq], map);
+		cpus_and(mask, irq_desc[irq].affinity, map);
 		if (any_online_cpu(mask) == NR_CPUS) {
 			printk("Breaking affinity for irq %i\n", irq);
 			mask = map;
Index: linux-genirq.q/arch/ia64/kernel/irq.c
===================================================================
--- linux-genirq.q.orig/arch/ia64/kernel/irq.c
+++ linux-genirq.q/arch/ia64/kernel/irq.c
@@ -100,7 +100,7 @@ void set_irq_affinity_info (unsigned int
 	cpu_set(cpu_logical_id(hwid), mask);
 
 	if (irq < NR_IRQS) {
-		irq_affinity[irq] = mask;
+		irq_desc[irq].affinity = mask;
 		set_irq_info(irq, mask);
 		irq_redir[irq] = (char) (redir & 0xff);
 	}
@@ -132,7 +132,7 @@ static void migrate_irqs(void)
 		if (desc->status == IRQ_PER_CPU)
 			continue;
 
-		cpus_and(mask, irq_affinity[irq], cpu_online_map);
+		cpus_and(mask, irq_desc[irq].affinity, cpu_online_map);
 		if (any_online_cpu(mask) == NR_CPUS) {
 			/*
 			 * Save it for phase 2 processing
Index: linux-genirq.q/arch/parisc/kernel/irq.c
===================================================================
--- linux-genirq.q.orig/arch/parisc/kernel/irq.c
+++ linux-genirq.q/arch/parisc/kernel/irq.c
@@ -94,7 +94,7 @@ int cpu_check_affinity(unsigned int irq,
 	if (irq == TIMER_IRQ || irq == IPI_IRQ) {
 		/* Bad linux design decision.  The mask has already
 		 * been set; we must reset it */
-		irq_affinity[irq] = CPU_MASK_ALL;
+		irq_desc[irq].affinity = CPU_MASK_ALL;
 		return -EINVAL;
 	}
 
@@ -110,7 +110,7 @@ static void cpu_set_affinity_irq(unsigne
 	if (cpu_check_affinity(irq, &dest))
 		return;
 
-	irq_affinity[irq] = dest;
+	irq_desc[irq].affinity = dest;
 }
 #endif
 
@@ -265,7 +265,7 @@ int txn_alloc_irq(unsigned int bits_wide
 unsigned long txn_affinity_addr(unsigned int irq, int cpu)
 {
 #ifdef CONFIG_SMP
-	irq_affinity[irq] = cpumask_of_cpu(cpu);
+	irq_desc[irq].affinity = cpumask_of_cpu(cpu);
 #endif
 
 	return cpu_data[cpu].txn_addr;
@@ -326,7 +326,7 @@ void do_cpu_irq_mask(struct pt_regs *reg
 		/* Work our way from MSb to LSb...same order we alloc EIRs */
 		for (irq = TIMER_IRQ; eirr_val && bit; bit>>=1, irq++) {
 #ifdef CONFIG_SMP
-			cpumask_t dest = irq_affinity[irq];
+			cpumask_t dest = irq_desc[irq].affinity;
 #endif
 			if (!(bit & eirr_val))
 				continue;
Index: linux-genirq.q/arch/powerpc/kernel/irq.c
===================================================================
--- linux-genirq.q.orig/arch/powerpc/kernel/irq.c
+++ linux-genirq.q/arch/powerpc/kernel/irq.c
@@ -163,7 +163,7 @@ void fixup_irqs(cpumask_t map)
 		if (irq_desc[irq].status & IRQ_PER_CPU)
 			continue;
 
-		cpus_and(mask, irq_affinity[irq], map);
+		cpus_and(mask, irq_desc[irq].affinity, map);
 		if (any_online_cpu(mask) == NR_CPUS) {
 			printk("Breaking affinity for irq %i\n", irq);
 			mask = map;
Index: linux-genirq.q/arch/powerpc/platforms/pseries/xics.c
===================================================================
--- linux-genirq.q.orig/arch/powerpc/platforms/pseries/xics.c
+++ linux-genirq.q/arch/powerpc/platforms/pseries/xics.c
@@ -238,7 +238,7 @@ static int get_irq_server(unsigned int i
 {
 	unsigned int server;
 	/* For the moment only implement delivery to all cpus or one cpu */
-	cpumask_t cpumask = irq_affinity[irq];
+	cpumask_t cpumask = irq_desc[irq].affinity;
 	cpumask_t tmp = CPU_MASK_NONE;
 
 	if (!distribute_irqs)
Index: linux-genirq.q/arch/x86_64/kernel/irq.c
===================================================================
--- linux-genirq.q.orig/arch/x86_64/kernel/irq.c
+++ linux-genirq.q/arch/x86_64/kernel/irq.c
@@ -114,7 +114,7 @@ void fixup_irqs(cpumask_t map)
 		if (irq == 2)
 			continue;
 
-		cpus_and(mask, irq_affinity[irq], map);
+		cpus_and(mask, irq_desc[irq].affinity, map);
 		if (any_online_cpu(mask) == NR_CPUS) {
 			printk("Breaking affinity for irq %i\n", irq);
 			mask = map;
Index: linux-genirq.q/include/linux/irq.h
===================================================================
--- linux-genirq.q.orig/include/linux/irq.h
+++ linux-genirq.q/include/linux/irq.h
@@ -77,6 +77,9 @@ typedef struct irq_desc {
 	unsigned int irq_count;		/* For detecting broken interrupts */
 	unsigned int irqs_unhandled;
 	spinlock_t lock;
+#ifdef CONFIG_SMP
+	cpumask_t affinity;
+#endif
 #if defined (CONFIG_GENERIC_PENDING_IRQ) || defined (CONFIG_IRQBALANCE)
 	unsigned int move_irq;		/* Flag need to re-target intr dest*/
 #endif
@@ -96,12 +99,10 @@ irq_descp (int irq)
 extern int setup_irq(unsigned int irq, struct irqaction * new);
 
 #ifdef CONFIG_GENERIC_HARDIRQS
-extern cpumask_t irq_affinity[NR_IRQS];
-
 #ifdef CONFIG_SMP
 static inline void set_native_irq_info(int irq, cpumask_t mask)
 {
-	irq_affinity[irq] = mask;
+	irq_desc[irq].affinity = mask;
 }
 #else
 static inline void set_native_irq_info(int irq, cpumask_t mask)
Index: linux-genirq.q/kernel/irq/handle.c
===================================================================
--- linux-genirq.q.orig/kernel/irq/handle.c
+++ linux-genirq.q/kernel/irq/handle.c
@@ -32,7 +32,10 @@ irq_desc_t irq_desc[NR_IRQS] __cacheline
 	[0 ... NR_IRQS-1] = {
 		.status = IRQ_DISABLED,
 		.handler = &no_irq_type,
-		.lock = SPIN_LOCK_UNLOCKED
+		.lock = SPIN_LOCK_UNLOCKED,
+#ifdef CONFIG_SMP
+		.affinity = CPU_MASK_ALL
+#endif
 	}
 };
 
Index: linux-genirq.q/kernel/irq/manage.c
===================================================================
--- linux-genirq.q.orig/kernel/irq/manage.c
+++ linux-genirq.q/kernel/irq/manage.c
@@ -16,8 +16,6 @@
 
 #ifdef CONFIG_SMP
 
-cpumask_t irq_affinity[NR_IRQS] = { [0 ... NR_IRQS-1] = CPU_MASK_ALL };
-
 #if defined (CONFIG_GENERIC_PENDING_IRQ) || defined (CONFIG_IRQBALANCE)
 cpumask_t __cacheline_aligned pending_irq_cpumask[NR_IRQS];
 #endif
Index: linux-genirq.q/kernel/irq/proc.c
===================================================================
--- linux-genirq.q.orig/kernel/irq/proc.c
+++ linux-genirq.q/kernel/irq/proc.c
@@ -33,7 +33,7 @@ void proc_set_irq_affinity(unsigned int 
 #else
 void proc_set_irq_affinity(unsigned int irq, cpumask_t mask_val)
 {
-	irq_affinity[irq] = mask_val;
+	irq_desc[irq].affinity = mask_val;
 	irq_desc[irq].handler->set_affinity(irq, mask_val);
 }
 #endif
@@ -41,7 +41,7 @@ void proc_set_irq_affinity(unsigned int 
 static int irq_affinity_read_proc(char *page, char **start, off_t off,
 				  int count, int *eof, void *data)
 {
-	int len = cpumask_scnprintf(page, count, irq_affinity[(long)data]);
+	int len = cpumask_scnprintf(page, count, irq_desc[(long)data].affinity);
 
 	if (count - len < 2)
 		return -EINVAL;
