Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265567AbTGCIeG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 04:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265569AbTGCIeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 04:34:06 -0400
Received: from dp.samba.org ([66.70.73.150]:65164 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265567AbTGCId6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 04:33:58 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 5/4] Make Generic irq_stat Structure Use per-cpu 
Date: Thu, 03 Jul 2003 18:47:15 +1000
Message-Id: <20030703084824.9FB122C0CB@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Sorry about the counting thing, decided to split this patch after I'd
  sent the first two. ]

Changes the generic irq_stat structure to use DECLARE_PER_CPU.
This saves a little space, and is more efficient on some archs.

Only i386 is fixed here.

Some archs refer to this in assembler: this is easy on UP (append
__per_cpu to the symbol name), but more complex on SMP (you need to
add __per_cpu_offset[smp_processor_id()]).  If that's too hard then
you can just stop using the generic structure.  Please remember to
drop the ____cacheline_aligned from the typedef of irq_cpustat_t!

Name: Make Generic irq_stat Structure Use per-cpu 
Author: Rusty Russell
Status: Tested on 2.5.74
Depends: Percpu/local_softirq_pending.patch.gz

D: Changes the generic irq_stat structure to use DECLARE_PER_CPU.
D: This saves a little space, and is more efficient on some archs.
D: 
D: Only i386 is fixed here.
D: 
D: Some archs refer to this in assembler: this is easy on UP (append
D: __per_cpu to the symbol name), but more complex on SMP (you need
D: to add __per_cpu_offset[smp_processor_id()]).  If that's too hard
D: then you can just stop using the generic structure.
D: Please remember to drop the ____cacheline_aligned from the typedef
D: of irq_cpustat_t!

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15631-linux-2.5.74/arch/i386/kernel/apic.c .15631-linux-2.5.74.updated/arch/i386/kernel/apic.c
--- .15631-linux-2.5.74/arch/i386/kernel/apic.c	2003-07-03 09:43:41.000000000 +1000
+++ .15631-linux-2.5.74.updated/arch/i386/kernel/apic.c	2003-07-03 16:24:21.000000000 +1000
@@ -1039,12 +1039,10 @@ inline void smp_local_timer_interrupt(st
 
 void smp_apic_timer_interrupt(struct pt_regs regs)
 {
-	int cpu = smp_processor_id();
-
 	/*
 	 * the NMI deadlock-detector uses this.
 	 */
-	irq_stat[cpu].apic_timer_irqs++;
+	__get_cpu_var(irq_stat).apic_timer_irqs++;
 
 	/*
 	 * NOTE! We'd better ACK the irq immediately,
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15631-linux-2.5.74/arch/i386/kernel/io_apic.c .15631-linux-2.5.74.updated/arch/i386/kernel/io_apic.c
--- .15631-linux-2.5.74/arch/i386/kernel/io_apic.c	2003-07-03 09:43:41.000000000 +1000
+++ .15631-linux-2.5.74.updated/arch/i386/kernel/io_apic.c	2003-07-03 16:24:21.000000000 +1000
@@ -304,7 +304,7 @@ struct irq_cpu_info {
 #define IRQ_DELTA(cpu,irq) 	(irq_cpu_data[cpu].irq_delta[irq])
 
 #define IDLE_ENOUGH(cpu,now) \
-		(idle_cpu(cpu) && ((now) - irq_stat[(cpu)].idle_timestamp > 1))
+		(idle_cpu(cpu) && ((now) - per_cpu(irq_stat,(cpu)).idle_timestamp > 1))
 
 #define IRQ_ALLOWED(cpu,allowed_mask) \
 		((1 << cpu) & (allowed_mask))
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15631-linux-2.5.74/arch/i386/kernel/irq.c .15631-linux-2.5.74.updated/arch/i386/kernel/irq.c
--- .15631-linux-2.5.74/arch/i386/kernel/irq.c	2003-06-15 11:29:47.000000000 +1000
+++ .15631-linux-2.5.74.updated/arch/i386/kernel/irq.c	2003-07-03 16:24:21.000000000 +1000
@@ -181,7 +181,8 @@ skip:
 	seq_printf(p, "LOC: ");
 	for (j = 0; j < NR_CPUS; j++)
 		if (cpu_online(j))
-			seq_printf(p, "%10u ", irq_stat[j].apic_timer_irqs);
+			seq_printf(p, "%10u ",
+				   per_cpu(irq_stat, j).apic_timer_irqs);
 	seq_putc(p, '\n');
 #endif
 	seq_printf(p, "ERR: %10u\n", atomic_read(&irq_err_count));
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15631-linux-2.5.74/arch/i386/kernel/nmi.c .15631-linux-2.5.74.updated/arch/i386/kernel/nmi.c
--- .15631-linux-2.5.74/arch/i386/kernel/nmi.c	2003-06-23 10:52:42.000000000 +1000
+++ .15631-linux-2.5.74.updated/arch/i386/kernel/nmi.c	2003-07-03 16:24:21.000000000 +1000
@@ -90,7 +90,7 @@ int __init check_nmi_watchdog (void)
 	printk(KERN_INFO "testing NMI watchdog ... ");
 
 	for (cpu = 0; cpu < NR_CPUS; cpu++)
-		prev_nmi_count[cpu] = irq_stat[cpu].__nmi_count;
+		prev_nmi_count[cpu] = nmi_count(cpu);
 	local_irq_enable();
 	mdelay((10*1000)/nmi_hz); // wait 10 ticks
 
@@ -409,7 +409,7 @@ void nmi_watchdog_tick (struct pt_regs *
 	 */
 	int sum, cpu = smp_processor_id();
 
-	sum = irq_stat[cpu].apic_timer_irqs;
+	sum = __get_cpu_var(irq_stat).apic_timer_irqs;
 
 	if (last_irq_sums[cpu] == sum) {
 		/*
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15631-linux-2.5.74/arch/i386/kernel/process.c .15631-linux-2.5.74.updated/arch/i386/kernel/process.c
--- .15631-linux-2.5.74/arch/i386/kernel/process.c	2003-06-23 10:52:42.000000000 +1000
+++ .15631-linux-2.5.74.updated/arch/i386/kernel/process.c	2003-07-03 16:24:21.000000000 +1000
@@ -141,7 +141,7 @@ void cpu_idle (void)
 		void (*idle)(void) = pm_idle;
 		if (!idle)
 			idle = default_idle;
-		irq_stat[smp_processor_id()].idle_timestamp = jiffies;
+		__get_cpu_var(irq_stat).idle_timestamp = jiffies;
 		while (!need_resched())
 			idle();
 		schedule();
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15631-linux-2.5.74/arch/i386/kernel/traps.c .15631-linux-2.5.74.updated/arch/i386/kernel/traps.c
--- .15631-linux-2.5.74/arch/i386/kernel/traps.c	2003-07-03 09:43:41.000000000 +1000
+++ .15631-linux-2.5.74.updated/arch/i386/kernel/traps.c	2003-07-03 16:24:21.000000000 +1000
@@ -475,7 +475,7 @@ asmlinkage void do_nmi(struct pt_regs * 
 	nmi_enter();
 
 	cpu = smp_processor_id();
-	++nmi_count(cpu);
+	++local_nmi_count();
 
 	if (!nmi_callback(regs, cpu))
 		default_do_nmi(regs);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15631-linux-2.5.74/arch/x86_64/kernel/irq.c .15631-linux-2.5.74.updated/arch/x86_64/kernel/irq.c
--- .15631-linux-2.5.74/arch/x86_64/kernel/irq.c	2003-06-15 11:29:50.000000000 +1000
+++ .15631-linux-2.5.74.updated/arch/x86_64/kernel/irq.c	2003-07-03 16:24:22.000000000 +1000
@@ -173,7 +173,7 @@ skip:
 	seq_printf(p, "NMI: ");
 	for (j = 0; j < NR_CPUS; j++)
 		if (cpu_online(j))
-		seq_printf(p, "%10u ", cpu_pda[j].__nmi_count);
+		seq_printf(p, "%10u ", nmi_count(j));
 	seq_putc(p, '\n');
 #ifdef CONFIG_X86_LOCAL_APIC
 	seq_printf(p, "LOC: ");
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15631-linux-2.5.74/arch/x86_64/kernel/nmi.c .15631-linux-2.5.74.updated/arch/x86_64/kernel/nmi.c
--- .15631-linux-2.5.74/arch/x86_64/kernel/nmi.c	2003-07-03 09:43:46.000000000 +1000
+++ .15631-linux-2.5.74.updated/arch/x86_64/kernel/nmi.c	2003-07-03 16:26:24.000000000 +1000
@@ -86,17 +86,17 @@ int __init check_nmi_watchdog (void)
 	printk(KERN_INFO "testing NMI watchdog ... ");
 
 	for (cpu = 0; cpu < NR_CPUS; cpu++)
-		counts[cpu] = cpu_pda[cpu].__nmi_count; 
+		counts[cpu] = nmi_count(cpu);
 	local_irq_enable();
 	mdelay((10*1000)/nmi_hz); // wait 10 ticks
 
 	for (cpu = 0; cpu < NR_CPUS; cpu++) {
 		if (!cpu_online(cpu))
 			continue;
-		if (cpu_pda[cpu].__nmi_count - counts[cpu] <= 5) {
+		if (nmi_count(cpu) - counts[cpu] <= 5) {
 			printk("CPU#%d: NMI appears to be stuck (%d)!\n", 
 			       cpu,
-			       cpu_pda[cpu].__nmi_count);
+			       nmi_count(cpu));
 			nmi_active = 0;
 			return -1;
 		}
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15631-linux-2.5.74/include/asm-i386/hardirq.h .15631-linux-2.5.74.updated/include/asm-i386/hardirq.h
--- .15631-linux-2.5.74/include/asm-i386/hardirq.h	2003-07-03 16:24:19.000000000 +1000
+++ .15631-linux-2.5.74.updated/include/asm-i386/hardirq.h	2003-07-03 16:24:22.000000000 +1000
@@ -10,7 +10,7 @@ typedef struct {
 	unsigned long idle_timestamp;
 	unsigned int __nmi_count;	/* arch dependent */
 	unsigned int apic_timer_irqs;	/* arch dependent */
-} ____cacheline_aligned irq_cpustat_t;
+} irq_cpustat_t;
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15631-linux-2.5.74/include/linux/irq_cpustat.h .15631-linux-2.5.74.updated/include/linux/irq_cpustat.h
--- .15631-linux-2.5.74/include/linux/irq_cpustat.h	2003-07-03 16:24:19.000000000 +1000
+++ .15631-linux-2.5.74.updated/include/linux/irq_cpustat.h	2003-07-03 16:24:22.000000000 +1000
@@ -10,6 +10,7 @@
  */
 
 #include <linux/config.h>
+#include <linux/percpu.h>
 
 /*
  * Simple wrappers reducing source bloat.  Define all irq_stat fields
@@ -18,19 +19,17 @@
  */
 
 #ifndef __ARCH_IRQ_STAT
-extern irq_cpustat_t irq_stat[];		/* defined in asm/hardirq.h */
-#ifdef CONFIG_SMP
-#define __IRQ_STAT(cpu, member)	(irq_stat[cpu].member)
-#else
-#define __IRQ_STAT(cpu, member)	((void)(cpu), irq_stat[0].member)
-#endif	
+DECLARE_PER_CPU(irq_cpustat_t, irq_stat);	/* defined in asm/hardirq.h */
+#define __IRQ_STAT(cpu, member)	(per_cpu(irq_stat, (cpu)).member)
+#define __LOCAL_IRQ_STAT(member) (__get_cpu_var(irq_stat).member)
 #endif
 
   /* arch independent irq_stat fields */
-#define softirq_pending(cpu)	__IRQ_STAT((cpu), __softirq_pending)
-#define local_softirq_pending()	softirq_pending(smp_processor_id())
+#define local_softirq_pending()	__LOCAL_IRQ_STAT(__softirq_pending)
 
   /* arch dependent irq_stat fields */
-#define nmi_count(cpu)		__IRQ_STAT((cpu), __nmi_count)	/* i386 */
+/* i386, x86-64 */
+#define nmi_count(cpu)		__IRQ_STAT((cpu), __nmi_count)
+#define local_nmi_count()	__LOCAL_IRQ_STAT(__nmi_count)
 
 #endif	/* __irq_cpustat_h */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15631-linux-2.5.74/kernel/softirq.c .15631-linux-2.5.74.updated/kernel/softirq.c
--- .15631-linux-2.5.74/kernel/softirq.c	2003-07-03 16:24:19.000000000 +1000
+++ .15631-linux-2.5.74.updated/kernel/softirq.c	2003-07-03 16:24:22.000000000 +1000
@@ -36,8 +36,8 @@
  */
 
 #ifndef __ARCH_IRQ_STAT
-irq_cpustat_t irq_stat[NR_CPUS] ____cacheline_aligned;
-EXPORT_SYMBOL(irq_stat);
+DEFINE_PER_CPU(irq_cpustat_t,  irq_stat);
+EXPORT_PER_CPU_SYMBOL(irq_stat);
 #endif
 
 static struct softirq_action softirq_vec[32] __cacheline_aligned_in_smp;
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
