Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbTLHUwo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 15:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbTLHUwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 15:52:44 -0500
Received: from modemcable067.88-70-69.mc.videotron.ca ([69.70.88.67]:44675
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S262030AbTLHUwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 15:52:34 -0500
Date: Mon, 8 Dec 2003 15:51:12 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Nick Piggin <piggin@cyberone.com.au>
cc: Ingo Molnar <mingo@redhat.com>, Anton Blanchard <anton@samba.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] make cpu_sibling_map a cpumask_t
In-Reply-To: <3FD3FD52.7020001@cyberone.com.au>
Message-ID: <Pine.LNX.4.58.0312080109010.1758@montezuma.fsmlabs.com>
References: <3FD3FD52.7020001@cyberone.com.au>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY=------------040107070607050508050907
Content-ID: <Pine.LNX.4.58.0312080109011.1758@montezuma.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--------------040107070607050508050907
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; FORMAT=flowed
Content-ID: <Pine.LNX.4.58.0312080109012.1758@montezuma.fsmlabs.com>

On Mon, 8 Dec 2003, Nick Piggin wrote:

> It turns the cpu_sibling_map array from an array of cpus to an array
> of cpumasks. This allows handling of more than 2 siblings, not that
> I know of any immediate need.
>
> I think it generalises cpu_sibling_map sufficiently that it can become
> generic code. This would allow architecture specific code to build the
> sibling map, and then Ingo's or my HT implementations to build their
> scheduling descriptions in generic code.
>
> I'm not aware of any reason why the kernel should not become generally
> SMT aware. It is sufficiently different to SMP that it is worth
> specialising it, although I am only aware of P4 and POWER5 implementations.

Generally i agree, it's fairly unintrusive and appears to clean up some
things. Perhaps Andrew will take it a bit later after release.

> P.S.
> I have an alternative to Ingo's HT scheduler which basically does
> the same thing. It is showing a 20% elapsed time improvement with a
> make -j3 on a 2xP4 Xeon (4 logical CPUs).

-j3 is an odd number, what does -j4, -j8, -j16 look like?
--------------040107070607050508050907
Content-Type: TEXT/PLAIN; NAME="sibling-map-to-cpumask.patch"
Content-ID: <Pine.LNX.4.58.0312080109013.1758@montezuma.fsmlabs.com>
Content-Description: 
Content-Disposition: INLINE; FILENAME="sibling-map-to-cpumask.patch"

 linux-2.6-npiggin/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c |    9 --
 linux-2.6-npiggin/arch/i386/kernel/io_apic.c                 |   19 ++--
 linux-2.6-npiggin/arch/i386/kernel/smpboot.c                 |   46 +++++------
 linux-2.6-npiggin/arch/i386/oprofile/op_model_p4.c           |    7 -
 linux-2.6-npiggin/include/asm-i386/smp.h                     |    2 
 5 files changed, 37 insertions(+), 46 deletions(-)

diff -puN include/asm-i386/smp.h~sibling-map-to-cpumask include/asm-i386/smp.h
--- linux-2.6/include/asm-i386/smp.h~sibling-map-to-cpumask	2003-12-08 14:42:28.000000000 +1100
+++ linux-2.6-npiggin/include/asm-i386/smp.h	2003-12-08 14:42:28.000000000 +1100
@@ -34,7 +34,7 @@
 extern void smp_alloc_memory(void);
 extern int pic_mode;
 extern int smp_num_siblings;
-extern int cpu_sibling_map[];
+extern cpumask_t cpu_sibling_map[];
 
 extern void smp_flush_tlb(void);
 extern void smp_message_irq(int cpl, void *dev_id, struct pt_regs *regs);
diff -puN arch/i386/kernel/smpboot.c~sibling-map-to-cpumask arch/i386/kernel/smpboot.c
--- linux-2.6/arch/i386/kernel/smpboot.c~sibling-map-to-cpumask	2003-12-08 14:42:28.000000000 +1100
+++ linux-2.6-npiggin/arch/i386/kernel/smpboot.c	2003-12-08 15:07:48.000000000 +1100
@@ -933,7 +933,7 @@ static int boot_cpu_logical_apicid;
 /* Where the IO area was mapped on multiquad, always 0 otherwise */
 void *xquad_portio;
 
-int cpu_sibling_map[NR_CPUS] __cacheline_aligned;
+cpumask_t cpu_sibling_map[NR_CPUS] __cacheline_aligned;
 
 static void __init smp_boot_cpus(unsigned int max_cpus)
 {
@@ -1079,32 +1079,28 @@ static void __init smp_boot_cpus(unsigne
 	Dprintk("Boot done.\n");
 
 	/*
-	 * If Hyper-Threading is avaialble, construct cpu_sibling_map[], so
-	 * that we can tell the sibling CPU efficiently.
+	 * construct cpu_sibling_map[], so that we can tell sibling CPUs
+	 * efficiently.
 	 */
-	if (cpu_has_ht && smp_num_siblings > 1) {
-		for (cpu = 0; cpu < NR_CPUS; cpu++)
-			cpu_sibling_map[cpu] = NO_PROC_ID;
-
-		for (cpu = 0; cpu < NR_CPUS; cpu++) {
-			int 	i;
-			if (!cpu_isset(cpu, cpu_callout_map))
-				continue;
+	for (cpu = 0; cpu < NR_CPUS; cpu++)
+		cpu_sibling_map[cpu] = CPU_MASK_NONE;
 
-			for (i = 0; i < NR_CPUS; i++) {
-				if (i == cpu || !cpu_isset(i, cpu_callout_map))
-					continue;
-				if (phys_proc_id[cpu] == phys_proc_id[i]) {
-					cpu_sibling_map[cpu] = i;
-					printk("cpu_sibling_map[%d] = %d\n", cpu, cpu_sibling_map[cpu]);
-					break;
-				}
-			}
-			if (cpu_sibling_map[cpu] == NO_PROC_ID) {
-				smp_num_siblings = 1;
-				printk(KERN_WARNING "WARNING: No sibling found for CPU %d.\n", cpu);
+	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+		int siblings = 0;
+		int 	i;
+		if (!cpu_isset(cpu, cpu_callout_map))
+			continue;
+
+		for (i = 0; i < NR_CPUS; i++) {
+			if (!cpu_isset(i, cpu_callout_map))
+				continue;
+			if (phys_proc_id[cpu] == phys_proc_id[i]) {
+				siblings++;
+				cpu_set(i, cpu_sibling_map[cpu]);
 			}
 		}
+		if (siblings != smp_num_siblings)
+			printk(KERN_WARNING "WARNING: %d siblings found for CPU%d, should be %d\n", siblings, cpu, smp_num_siblings);
 	}
 
 	smpboot_setup_io_apic();
@@ -1143,8 +1139,8 @@ __init void arch_init_sched_domains(void
 
 		*cpu_domain = SD_CPU_INIT;
 		cpu_domain->span = CPU_MASK_NONE;
-		cpu_set(i, cpu_domain->span);
-		cpu_set(cpu_sibling_map[i], cpu_domain->span);
+		cpu_domain->span = cpu_sibling_map[i];
+		WARN_ON(!cpu_isset(i, cpu_sibling_map[i]));
 		cpu_domain->flags |= SD_FLAG_WAKE | SD_FLAG_IDLE;
 		cpu_domain->cache_hot_time = 0;
 		cpu_domain->cache_nice_tries = 0;
diff -puN arch/i386/kernel/io_apic.c~sibling-map-to-cpumask arch/i386/kernel/io_apic.c
--- linux-2.6/arch/i386/kernel/io_apic.c~sibling-map-to-cpumask	2003-12-08 14:42:28.000000000 +1100
+++ linux-2.6-npiggin/arch/i386/kernel/io_apic.c	2003-12-08 14:42:28.000000000 +1100
@@ -309,8 +309,7 @@ struct irq_cpu_info {
 
 #define IRQ_ALLOWED(cpu, allowed_mask)	cpu_isset(cpu, allowed_mask)
 
-#define CPU_TO_PACKAGEINDEX(i) \
-		((physical_balance && i > cpu_sibling_map[i]) ? cpu_sibling_map[i] : i)
+#define CPU_TO_PACKAGEINDEX(i) (first_cpu(cpu_sibling_map[i]))
 
 #define MAX_BALANCED_IRQ_INTERVAL	(5*HZ)
 #define MIN_BALANCED_IRQ_INTERVAL	(HZ/2)
@@ -393,6 +392,7 @@ static void do_irq_balance(void)
 	unsigned long max_cpu_irq = 0, min_cpu_irq = (~0);
 	unsigned long move_this_load = 0;
 	int max_loaded = 0, min_loaded = 0;
+	int load;
 	unsigned long useful_load_threshold = balanced_irq_interval + 10;
 	int selected_irq;
 	int tmp_loaded, first_attempt = 1;
@@ -444,7 +444,7 @@ static void do_irq_balance(void)
 	for (i = 0; i < NR_CPUS; i++) {
 		if (!cpu_online(i))
 			continue;
-		if (physical_balance && i > cpu_sibling_map[i])
+		if (i != CPU_TO_PACKAGEINDEX(i))
 			continue;
 		if (min_cpu_irq > CPU_IRQ(i)) {
 			min_cpu_irq = CPU_IRQ(i);
@@ -463,7 +463,7 @@ tryanothercpu:
 	for (i = 0; i < NR_CPUS; i++) {
 		if (!cpu_online(i))
 			continue;
-		if (physical_balance && i > cpu_sibling_map[i])
+		if (i != CPU_TO_PACKAGEINDEX(i))
 			continue;
 		if (max_cpu_irq <= CPU_IRQ(i)) 
 			continue;
@@ -543,9 +543,14 @@ tryanotherirq:
 	 * We seek the least loaded sibling by making the comparison
 	 * (A+B)/2 vs B
 	 */
-	if (physical_balance && (CPU_IRQ(min_loaded) >> 1) >
-					CPU_IRQ(cpu_sibling_map[min_loaded]))
-		min_loaded = cpu_sibling_map[min_loaded];
+	load = CPU_IRQ(min_loaded) >> 1;
+	for_each_cpu(j, cpu_sibling_map[min_loaded]) {
+		if (load > CPU_IRQ(j)) {
+			/* This won't change cpu_sibling_map[min_loaded] */
+			load = CPU_IRQ(j);
+			min_loaded = j;
+		}
+	}
 
 	cpus_and(allowed_mask, cpu_online_map, irq_affinity[selected_irq]);
 	target_cpu_mask = cpumask_of_cpu(min_loaded);
diff -puN arch/i386/kernel/cpu/cpufreq/p4-clockmod.c~sibling-map-to-cpumask arch/i386/kernel/cpu/cpufreq/p4-clockmod.c
--- linux-2.6/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c~sibling-map-to-cpumask	2003-12-08 14:42:28.000000000 +1100
+++ linux-2.6-npiggin/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	2003-12-08 14:42:28.000000000 +1100
@@ -67,14 +67,7 @@ static int cpufreq_p4_setdc(unsigned int
 	cpus_allowed = current->cpus_allowed;
 
 	/* only run on CPU to be set, or on its sibling */
-       affected_cpu_map = cpumask_of_cpu(cpu);
-#ifdef CONFIG_X86_HT
-	hyperthreading = ((cpu_has_ht) && (smp_num_siblings == 2));
-	if (hyperthreading) {
-		sibling = cpu_sibling_map[cpu];
-                cpu_set(sibling, affected_cpu_map);
-	}
-#endif
+	affected_cpu_map = cpu_sibling_map[cpu];
 	set_cpus_allowed(current, affected_cpu_map);
         BUG_ON(!cpu_isset(smp_processor_id(), affected_cpu_map));
 
diff -puN arch/i386/oprofile/op_model_p4.c~sibling-map-to-cpumask arch/i386/oprofile/op_model_p4.c
--- linux-2.6/arch/i386/oprofile/op_model_p4.c~sibling-map-to-cpumask	2003-12-08 14:42:28.000000000 +1100
+++ linux-2.6-npiggin/arch/i386/oprofile/op_model_p4.c	2003-12-08 14:42:28.000000000 +1100
@@ -382,11 +382,8 @@ static struct p4_event_binding p4_events
 static unsigned int get_stagger(void)
 {
 #ifdef CONFIG_SMP
-	int cpu;
-	if (smp_num_siblings > 1) {
-		cpu = smp_processor_id();
-		return (cpu_sibling_map[cpu] > cpu) ? 0 : 1;
-	}
+	int cpu = smp_processor_id();
+	return (cpu != first_cpu(cpu_sibling_map[cpu]));
 #endif	
 	return 0;
 }

_

--------------040107070607050508050907--
