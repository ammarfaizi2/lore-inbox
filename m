Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317023AbSHJPW4>; Sat, 10 Aug 2002 11:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317024AbSHJPWz>; Sat, 10 Aug 2002 11:22:55 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:29710 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S317023AbSHJPWr>; Sat, 10 Aug 2002 11:22:47 -0400
Date: Sat, 10 Aug 2002 19:26:10 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@transmeta.com>,
       Richard Henderson <rth@twiddle.net>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 2.5.30] alpha: CPU logical mapping [3/10]
Message-ID: <20020810192610.B20534@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hardware cpu_id to logical cpu mapping is gone.
Converted to cpu_online() etc.

Ivan.

--- 2.5.30/include/asm-alpha/smp.h	Mon Mar 18 23:37:12 2002
+++ linux/include/asm-alpha/smp.h	Sat Aug 10 01:20:59 2002
@@ -42,20 +42,16 @@ extern struct cpuinfo_alpha cpu_data[NR_
 
 #define PROC_CHANGE_PENALTY     20
 
-/* Map from cpu id to sequential logical cpu number.  This will only
-   not be idempotent when cpus failed to come on-line.  */
-extern int __cpu_number_map[NR_CPUS];
-#define cpu_number_map(cpu)  __cpu_number_map[cpu]
-
-/* The reverse map from sequential logical cpu number to cpu id.  */
-extern int __cpu_logical_map[NR_CPUS];
-#define cpu_logical_map(cpu)  __cpu_logical_map[cpu]
-
 #define hard_smp_processor_id()	__hard_smp_processor_id()
 #define smp_processor_id()	(current_thread_info()->cpu)
 
 extern unsigned long cpu_present_mask;
-#define cpu_online_map cpu_present_mask
+extern int smp_num_cpus;
+
+#define cpu_online_map		cpu_present_mask
+#define num_online_cpus()	(smp_num_cpus)
+#define cpu_online(cpu)		(cpu_present_mask & (1<<(cpu)))
+#define cpu_possible(cpu)	cpu_online(cpu)
 
 extern int smp_call_function_on_cpu(void (*func) (void *info), void *info,int retry, int wait, unsigned long cpu);
 
--- 2.5.30/include/asm-alpha/mmu_context.h	Mon Mar 18 23:37:15 2002
+++ linux/include/asm-alpha/mmu_context.h	Sat Aug 10 01:20:59 2002
@@ -227,8 +227,9 @@ init_new_context(struct task_struct *tsk
 {
 	int i;
 
-	for (i = 0; i < smp_num_cpus; i++)
-		mm->context[cpu_logical_map(i)] = 0;
+	for (i = 0; i < NR_CPUS; i++)
+		if (cpu_online(i))
+			mm->context[i] = 0;
         tsk->thread_info->pcb.ptbr
 	  = ((unsigned long)mm->pgd - IDENT_ADDR) >> PAGE_SHIFT;
 	return 0;
--- 2.5.30/arch/alpha/kernel/smp.c	Sat Aug 10 01:19:52 2002
+++ linux/arch/alpha/kernel/smp.c	Sat Aug 10 01:20:59 2002
@@ -37,6 +37,7 @@
 #include <asm/hardirq.h>
 #include <asm/softirq.h>
 #include <asm/mmu_context.h>
+#include <asm/tlbflush.h>
 
 #define __KERNEL_SYSCALLS__
 #include <asm/unistd.h>
@@ -84,9 +85,6 @@ int smp_threads_ready;		/* True once the
 cycles_t cacheflush_time;
 unsigned long cache_decay_ticks;
 
-int __cpu_number_map[NR_CPUS];
-int __cpu_logical_map[NR_CPUS];
-
 extern void calibrate_delay(void);
 extern asmlinkage void entInt(void);
 
@@ -463,9 +461,6 @@ smp_boot_one_cpu(int cpuid, int cpunum)
 	init_idle(idle, cpuid);
 	unhash_process(idle);
 
-	__cpu_logical_map[cpunum] = cpuid;
-	__cpu_number_map[cpuid] = cpunum;
-
 	DBGS(("smp_boot_one_cpu: CPU %d state 0x%lx flags 0x%lx\n",
 	      cpuid, idle->state, idle->flags));
 
@@ -490,9 +485,7 @@ smp_boot_one_cpu(int cpuid, int cpunum)
 		barrier();
 	}
 
-	/* We must invalidate our stuff as we failed to boot the CPU.  */
-	__cpu_logical_map[cpunum] = -1;
-	__cpu_number_map[cpuid] = -1;
+	/* We failed to boot the CPU.  */
 
 	printk(KERN_ERR "SMP: Processor %d is stuck.\n", cpuid);
 	return -1;
@@ -562,12 +555,8 @@ smp_boot_cpus(void)
 	unsigned long bogosum;
 
 	/* Take care of some initial bookkeeping.  */
-	memset(__cpu_number_map, -1, sizeof(__cpu_number_map));
-	memset(__cpu_logical_map, -1, sizeof(__cpu_logical_map));
 	memset(ipi_data, 0, sizeof(ipi_data));
 
-	__cpu_number_map[boot_cpuid] = 0;
-	__cpu_logical_map[0] = boot_cpuid;
 	current_thread_info()->cpu = boot_cpuid;
 
 	smp_store_cpu_info(boot_cpuid);
@@ -942,10 +931,9 @@ flush_tlb_mm(struct mm_struct *mm)
 	if (mm == current->active_mm) {
 		flush_tlb_current(mm);
 		if (atomic_read(&mm->mm_users) <= 1) {
-			int i, cpu, this_cpu = smp_processor_id();
-			for (i = 0; i < smp_num_cpus; i++) {
-				cpu = cpu_logical_map(i);
-				if (cpu == this_cpu)
+			int cpu, this_cpu = smp_processor_id();
+			for (cpu = 0; cpu < NR_CPUS; cpu++) {
+				if (!cpu_online(cpu) || cpu == this_cpu)
 					continue;
 				if (mm->context[cpu])
 					mm->context[cpu] = 0;
@@ -986,10 +974,9 @@ flush_tlb_page(struct vm_area_struct *vm
 	if (mm == current->active_mm) {
 		flush_tlb_current_page(mm, vma, addr);
 		if (atomic_read(&mm->mm_users) <= 1) {
-			int i, cpu, this_cpu = smp_processor_id();
-			for (i = 0; i < smp_num_cpus; i++) {
-				cpu = cpu_logical_map(i);
-				if (cpu == this_cpu)
+			int cpu, this_cpu = smp_processor_id();
+			for (cpu = 0; cpu < NR_CPUS; cpu++) {
+				if (!cpu_online(cpu) || cpu == this_cpu)
 					continue;
 				if (mm->context[cpu])
 					mm->context[cpu] = 0;
@@ -1036,10 +1023,9 @@ flush_icache_user_range(struct vm_area_s
 	if (mm == current->active_mm) {
 		__load_new_mm_context(mm);
 		if (atomic_read(&mm->mm_users) <= 1) {
-			int i, cpu, this_cpu = smp_processor_id();
-			for (i = 0; i < smp_num_cpus; i++) {
-				cpu = cpu_logical_map(i);
-				if (cpu == this_cpu)
+			int cpu, this_cpu = smp_processor_id();
+			for (cpu = 0; cpu < NR_CPUS; cpu++) {
+				if (!cpu_online(cpu) || cpu == this_cpu)
 					continue;
 				if (mm->context[cpu])
 					mm->context[cpu] = 0;
--- 2.5.30/arch/alpha/kernel/setup.c	Wed Jun 19 23:46:54 2002
+++ linux/arch/alpha/kernel/setup.c	Sat Aug 10 01:20:59 2002
@@ -1109,7 +1109,7 @@ show_cpuinfo(struct seq_file *f, void *s
 #ifdef CONFIG_SMP
 	seq_printf(f, "cpus active\t\t: %d\n"
 		      "cpu active mask\t\t: %016lx\n",
-		       smp_num_cpus, cpu_present_mask);
+		       num_online_cpus(), cpu_present_mask);
 #endif
 
 	return 0;
--- 2.5.30/arch/alpha/kernel/irq.c	Mon Aug  5 00:56:40 2002
+++ linux/arch/alpha/kernel/irq.c	Sat Aug 10 01:20:59 2002
@@ -525,12 +525,9 @@ show_interrupts(struct seq_file *p, void
 
 #ifdef CONFIG_SMP
 	seq_puts(p, "           ");
-	for (i = 0; i < smp_num_cpus; i++)
-		seq_printf(p, "CPU%d       ", i);
-#ifdef DO_BROADCAST_INTS
-	for (i = 0; i < smp_num_cpus; i++)
-		seq_printf(p, "TRY%d       ", i);
-#endif
+	for (i = 0; i < NR_CPUS; i++)
+		if (cpu_online(i))
+			seq_printf(p, "CPU%d       ", i);
 	seq_putc(p, '\n');
 #endif
 
@@ -542,14 +539,9 @@ show_interrupts(struct seq_file *p, void
 #ifndef CONFIG_SMP
 		seq_printf(p, "%10u ", kstat_irqs(i));
 #else
-		for (j = 0; j < smp_num_cpus; j++)
-			seq_printf(p, "%10u ",
-				     kstat.irqs[cpu_logical_map(j)][i]);
-#ifdef DO_BROADCAST_INTS
-		for (j = 0; j < smp_num_cpus; j++)
-			seq_printf(p, "%10lu ",
-				     irq_attempt(cpu_logical_map(j), i));
-#endif
+		for (j = 0; j < NR_CPUS; j++)
+			if (cpu_online(j))
+				seq_printf(p, "%10u ", kstat.irqs[j][i]);
 #endif
 		seq_printf(p, " %14s", irq_desc[i].handler->typename);
 		seq_printf(p, "  %c%s",
@@ -565,9 +557,9 @@ show_interrupts(struct seq_file *p, void
 	}
 #if CONFIG_SMP
 	seq_puts(p, "IPI: ");
-	for (j = 0; j < smp_num_cpus; j++)
-		seq_printf(p, "%10lu ",
-			     cpu_data[cpu_logical_map(j)].ipi_count);
+	for (i = 0; i < NR_CPUS; i++)
+		if (cpu_online(i))
+			seq_printf(p, "%10lu ", cpu_data[i].ipi_count);
 	seq_putc(p, '\n');
 #endif
 	seq_printf(p, "ERR: %10lu\n", irq_err_count);
