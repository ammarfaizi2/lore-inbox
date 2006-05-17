Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750917AbWEQF3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750917AbWEQF3I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 01:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbWEQF3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 01:29:08 -0400
Received: from mga07.intel.com ([143.182.124.22]:47776 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1750917AbWEQF3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 01:29:07 -0400
X-IronPort-AV: i="4.05,135,1146466800"; 
   d="scan'208"; a="37564021:sNHT57991556"
Subject: [PATCH] Kernel irq balance doesn't work
From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: "venkatesh.pallipadi" <venkatesh.pallipadi@intel.com>
Content-Type: text/plain
Message-Id: <1147843543.4377.339.camel@ymzhang-perf.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Wed, 17 May 2006 13:25:43 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Yanmin <yanmin.zhang@intel.com>

On i386, kernel irq balance doesn't work.

1) In function do_irq_balance, after kernel finds the min_loaded cpu
but before calling set_pending_irq to really pin the selected_irq
to the target cpu, kernel does a cpus_and with irq_affinity[selected_irq].
Later on, when the irq is acked, kernel would calls
move_native_irq=>desc->handler->set_affinity to change the irq affinity.
However, every function pointed by hw_interrupt_type->set_affinity(unsigned
int irq, cpumask_t cpumask) always changes irq_affinity[irq] to cpumask.
Next time when recalling do_irq_balance, it has to do cpu_ands again with
irq_affinity[selected_irq], but irq_affinity[selected_irq] already becomes
one cpu selected by the first irq balance.
2) Function balance_irq in file arch/i386/kernel/io_apic.c has the same issue.

My patch against 2.6.17-rc4 fixes it.

Signed-off-by: Zhang Yanmin <yanmin.zhang@intel.com>

---

diff -Nraup linux-2.6.17-rc4/arch/i386/kernel/io_apic.c linux-2.6.17-rc4_kirqd/arch/i386/kernel/io_apic.c
--- linux-2.6.17-rc4/arch/i386/kernel/io_apic.c	2006-05-17 17:16:23.000000000 +0800
+++ linux-2.6.17-rc4_kirqd/arch/i386/kernel/io_apic.c	2006-05-17 21:05:02.000000000 +0800
@@ -304,6 +304,15 @@ static struct irq_cpu_info {
 
 static long balanced_irq_interval = MAX_BALANCED_IRQ_INTERVAL;
 
+static cpumask_t balance_irq_affinity[NR_IRQS] = {
+	[0 ... NR_IRQS-1] = CPU_MASK_ALL
+};
+
+void set_balance_irq_affinity(unsigned int irq, cpumask_t mask)
+{
+	balance_irq_affinity[irq] = mask;
+}
+
 static unsigned long move(int curr_cpu, cpumask_t allowed_mask,
 			unsigned long now, int direction)
 {
@@ -340,7 +349,7 @@ static inline void balance_irq(int cpu, 
 	if (irqbalance_disabled)
 		return; 
 
-	cpus_and(allowed_mask, cpu_online_map, irq_affinity[irq]);
+	cpus_and(allowed_mask, cpu_online_map, balance_irq_affinity[irq]);
 	new_cpu = move(cpu, allowed_mask, now, 1);
 	if (cpu != new_cpu) {
 		set_pending_irq(irq, cpumask_of_cpu(new_cpu));
@@ -529,7 +538,9 @@ tryanotherirq:
 		}
 	}
 
-	cpus_and(allowed_mask, cpu_online_map, irq_affinity[selected_irq]);
+	cpus_and(allowed_mask,
+		cpu_online_map,
+		balance_irq_affinity[selected_irq]);
 	target_cpu_mask = cpumask_of_cpu(min_loaded);
 	cpus_and(tmp, target_cpu_mask, allowed_mask);
 
diff -Nraup linux-2.6.17-rc4/include/linux/irq.h linux-2.6.17-rc4_kirqd/include/linux/irq.h
--- linux-2.6.17-rc4/include/linux/irq.h	2006-05-17 17:16:27.000000000 +0800
+++ linux-2.6.17-rc4_kirqd/include/linux/irq.h	2006-05-17 21:05:02.000000000 +0800
@@ -165,6 +165,12 @@ static inline void set_irq_info(int irq,
 
 #endif // CONFIG_SMP
 
+#ifdef CONFIG_IRQBALANCE
+extern void set_balance_irq_affinity(unsigned int irq, cpumask_t mask);
+#else
+#define set_balance_irq_affinity(irq, mask)
+#endif
+
 extern int no_irq_affinity;
 extern int noirqdebug_setup(char *str);
 
diff -Nraup linux-2.6.17-rc4/kernel/irq/proc.c linux-2.6.17-rc4_kirqd/kernel/irq/proc.c
--- linux-2.6.17-rc4/kernel/irq/proc.c	2006-04-20 21:19:24.000000000 +0800
+++ linux-2.6.17-rc4_kirqd/kernel/irq/proc.c	2006-05-17 21:05:02.000000000 +0800
@@ -24,6 +24,8 @@ static struct proc_dir_entry *smp_affini
 #ifdef CONFIG_GENERIC_PENDING_IRQ
 void proc_set_irq_affinity(unsigned int irq, cpumask_t mask_val)
 {
+	set_balance_irq_affinity(irq, mask_val);
+
 	/*
 	 * Save these away for later use. Re-progam when the
 	 * interrupt is pending
@@ -33,6 +35,7 @@ void proc_set_irq_affinity(unsigned int 
 #else
 void proc_set_irq_affinity(unsigned int irq, cpumask_t mask_val)
 {
+	set_balance_irq_affinity(irq, mask_val);
 	irq_affinity[irq] = mask_val;
 	irq_desc[irq].handler->set_affinity(irq, mask_val);
 }
