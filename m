Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261553AbVECSg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261553AbVECSg0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 14:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbVECSgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 14:36:25 -0400
Received: from fmr23.intel.com ([143.183.121.15]:21647 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S261553AbVECSc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 14:32:26 -0400
Date: Tue, 3 May 2005 11:31:30 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, ak@muc.de, zwane@arm.linux.org.uk
Subject: optimize-move-irq : Optimize speed patch checks for move_irq
Message-ID: <20050503113130.A19323@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew

This addreses one of the concerns Andi had about checks for empty cpumask
in the intr speed patch. This patch adds a flag check, so we just check it
rather than the entire cpumask for work to do in move_irq time.

This depends on the other deferred irq write patches we have in -mm so far.

-- 
Cheers,
Ashok Raj
- Open Source Technology Center


---
Signed-off-by: Ashok Raj <ashok.raj@intel.com>

Depends-on: Following file 

x86-x86_64-deferred-handling-of-writes-to-proc-irq-xx-smp_affinitypatch-added-to-mm-tree-fix-4.patch


This patch speeds up checks in move_irq which is called in intr_path.
Earlier checks for the same under CONFIG_IRQBALANCE would check if 
the cpumask is empty, which is a slower operation when NR_CPUS is large.

This patch adds a check to speed up processing in the irq_desc structure.
Also adds a new function to generalize setting the pending_irq array
so it can be used in other places.
---
---

 linux-2.6.12-rc3-mm2-araj/arch/i386/kernel/io_apic.c |   16 ++---------
 linux-2.6.12-rc3-mm2-araj/include/linux/irq.h        |   27 +++++++++++++++----
 linux-2.6.12-rc3-mm2-araj/kernel/irq/proc.c          |    7 ----
 3 files changed, 27 insertions(+), 23 deletions(-)

diff -puN arch/i386/kernel/io_apic.c~optimize-move-irq arch/i386/kernel/io_apic.c
--- linux-2.6.12-rc3-mm2/arch/i386/kernel/io_apic.c~optimize-move-irq	2005-05-03 11:03:46.000000000 -0700
+++ linux-2.6.12-rc3-mm2-araj/arch/i386/kernel/io_apic.c	2005-05-03 11:03:46.000000000 -0700
@@ -334,12 +334,7 @@ static inline void balance_irq(int cpu, 
 	cpus_and(allowed_mask, cpu_online_map, irq_affinity[irq]);
 	new_cpu = move(cpu, allowed_mask, now, 1);
 	if (cpu != new_cpu) {
-		irq_desc_t *desc = irq_desc + irq;
-		unsigned long flags;
-
-		spin_lock_irqsave(&desc->lock, flags);
-		pending_irq_cpumask[irq] = cpumask_of_cpu(new_cpu);
-		spin_unlock_irqrestore(&desc->lock, flags);
+		set_pending_irq(irq, cpumask_of_cpu(new_cpu));
 	}
 }
 
@@ -534,16 +529,12 @@ tryanotherirq:
 	cpus_and(tmp, target_cpu_mask, allowed_mask);
 
 	if (!cpus_empty(tmp)) {
-		irq_desc_t *desc = irq_desc + selected_irq;
-		unsigned long flags;
 
 		Dprintk("irq = %d moved to cpu = %d\n",
 				selected_irq, min_loaded);
 		/* mark for change destination */
-		spin_lock_irqsave(&desc->lock, flags);
-		pending_irq_cpumask[selected_irq] =
-					cpumask_of_cpu(min_loaded);
-		spin_unlock_irqrestore(&desc->lock, flags);
+		set_pending_irq(selected_irq, cpumask_of_cpu(min_loaded));
+
 		/* Since we made a change, come back sooner to 
 		 * check for more variation.
 		 */
@@ -575,6 +566,7 @@ static int balanced_irq(void *unused)
 	/* push everything to CPU 0 to give us a starting point.  */
 	for (i = 0 ; i < NR_IRQS ; i++) {
 		pending_irq_cpumask[i] = cpumask_of_cpu(0);
+		set_pending_irq(i, cpumask_of_cpu(0));
 	}
 
 	for ( ; ; ) {
diff -puN include/linux/irq.h~optimize-move-irq include/linux/irq.h
--- linux-2.6.12-rc3-mm2/include/linux/irq.h~optimize-move-irq	2005-05-03 11:03:46.000000000 -0700
+++ linux-2.6.12-rc3-mm2-araj/include/linux/irq.h	2005-05-03 11:08:52.000000000 -0700
@@ -67,6 +67,9 @@ typedef struct irq_desc {
 	unsigned int irq_count;		/* For detecting broken interrupts */
 	unsigned int irqs_unhandled;
 	spinlock_t lock;
+#if defined (CONFIG_GENERIC_PENDING_IRQ) || defined (CONFIG_IRQBALANCE)
+	unsigned int move_irq;		/* Flag need to re-target intr dest*/
+#endif
 } ____cacheline_aligned irq_desc_t;
 
 extern irq_desc_t irq_desc [NR_IRQS];
@@ -78,7 +81,6 @@ irq_descp (int irq)
 	return irq_desc + irq;
 }
 
-
 #include <asm/hw_irq.h> /* the arch dependent stuff */
 
 extern int setup_irq(unsigned int irq, struct irqaction * new);
@@ -101,19 +103,33 @@ static inline void set_native_irq_info(i
 
 #if defined (CONFIG_GENERIC_PENDING_IRQ) || defined (CONFIG_IRQBALANCE)
 extern cpumask_t pending_irq_cpumask[NR_IRQS];
-#endif
 
-#ifdef CONFIG_GENERIC_PENDING_IRQ
+static inline void set_pending_irq(unsigned int irq, cpumask_t mask)
+{
+	irq_desc_t *desc = irq_desc + irq;
+	unsigned long flags;
+
+	spin_lock_irqsave(&desc->lock, flags);
+	desc->move_irq = 1;
+	pending_irq_cpumask[irq] = mask;
+	spin_unlock_irqrestore(&desc->lock, flags);
+}
+
 static inline void
 move_native_irq(int irq)
 {
 	cpumask_t tmp;
 	irq_desc_t *desc = irq_descp(irq);
 
+	if (likely (!desc->move_irq))
+		return;
+
+	desc->move_irq = 0;
+
 	if (likely(cpus_empty(pending_irq_cpumask[irq])))
 		return;
 
-	if (unlikely(!desc->handler->set_affinity))
+	if (!desc->handler->set_affinity)
 		return;
 
 	/* note - we hold the desc->lock */
@@ -165,10 +181,11 @@ static inline void set_irq_info(int irq,
 }
 #endif // CONFIG_PCI_MSI
 
-#else	// CONFIG_GENERIC_PENDING_IRQ
+#else	// CONFIG_GENERIC_PENDING_IRQ || CONFIG_IRQBALANCE
 
 #define move_irq(x)
 #define move_native_irq(x)
+#define set_pending_irq(x,y)
 static inline void set_irq_info(int irq, cpumask_t mask)
 {
 	set_native_irq_info(irq, mask);
diff -puN kernel/irq/proc.c~optimize-move-irq kernel/irq/proc.c
--- linux-2.6.12-rc3-mm2/kernel/irq/proc.c~optimize-move-irq	2005-05-03 11:03:46.000000000 -0700
+++ linux-2.6.12-rc3-mm2-araj/kernel/irq/proc.c	2005-05-03 11:03:46.000000000 -0700
@@ -22,16 +22,11 @@ static struct proc_dir_entry *smp_affini
 #ifdef CONFIG_GENERIC_PENDING_IRQ
 void proc_set_irq_affinity(unsigned int irq, cpumask_t mask_val)
 {
-	irq_desc_t	*desc = irq_descp(irq);
-	unsigned long flags;
-
 	/*
 	 * Save these away for later use. Re-progam when the
 	 * interrupt is pending
 	 */
-	spin_lock_irqsave(&desc->lock, flags);
-	pending_irq_cpumask[irq] = mask_val;
-	spin_unlock_irqrestore(&desc->lock, flags);
+	set_pending_irq(irq, mask_val);
 }
 #else
 void proc_set_irq_affinity(unsigned int irq, cpumask_t mask_val)
_
