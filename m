Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266003AbTLaBbG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 20:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266049AbTLaBbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 20:31:06 -0500
Received: from dp.samba.org ([66.70.73.150]:32198 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266003AbTLaBas (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 20:30:48 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: akpm@osdl.org
Cc: Paul Jackson <pj@sgi.com>
Cc: anton@samba.org, linux-kernel@vger.kernel.org, ioe-lkml@rameria.de,
       William Lee Irwin III <wli@holomorphy.com>
Subject: [PATCH 1/2] Make for_each_cpu() Iterator More Friendly
Date: Wed, 31 Dec 2003 12:26:34 +1100
Message-Id: <20031231013046.23B3B2C079@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please apply.  Applies against 2.6.0-mm2 and 2.6.0-bk3.  Yay!

Anton: breaks PPC64, as it needs cpu_possible_mask, but fix is already
in Ameslab tree.

Name: Make for_each_cpu() more friendly.
Author: Rusty Russell
Status: Booted on 2.6.0

D: The for_each_cpu() and for_each_online_cpu() iterators take a mask,
D: and noone uses them that way (except for arch/i386/mach-voyager, which
D: uses for_each_cpu(cpu_online_mask).  Make them more usable iterators,
D: by dropping the "mask" arg.
D: 
D: This requires that archs provide a cpu_possible_mask: most do,
D: but PPC64 doesn't, so it is broken by this patch.  The other archs
D: use a #define to define it in asm/smp.h.
D: 
D: Most places doing loops over cpus testing for cpu_online() should use
D: for_each_cpu: it is synonymous at the moment, but with the CPU hotplug patch
D: the difference becomes important.
D: 
D: Followup patches will convert users.
D: 
D: Thanks!
D: Rusty.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18232-linux-2.6.0-bk3/arch/i386/mach-voyager/voyager_smp.c .18232-linux-2.6.0-bk3.updated/arch/i386/mach-voyager/voyager_smp.c
--- .18232-linux-2.6.0-bk3/arch/i386/mach-voyager/voyager_smp.c	2003-11-24 15:42:27.000000000 +1100
+++ .18232-linux-2.6.0-bk3.updated/arch/i386/mach-voyager/voyager_smp.c	2003-12-31 11:39:42.000000000 +1100
@@ -130,7 +130,7 @@ send_QIC_CPI(__u32 cpuset, __u8 cpi)
 {
 	int cpu;
 
-	for_each_cpu(cpu, cpu_online_map) {
+	for_each_online_cpu(cpu) {
 		if(cpuset & (1<<cpu)) {
 #ifdef VOYAGER_DEBUG
 			if(!cpu_isset(cpu, cpu_online_map))
@@ -1465,7 +1465,7 @@ send_CPI(__u32 cpuset, __u8 cpi)
 	cpuset &= 0xff;		/* only first 8 CPUs vaild for VIC CPI */
 	if(cpuset == 0)
 		return;
-	for_each_cpu(cpu, cpu_online_map) {
+	for_each_online_cpu(cpu) {
 		if(cpuset & (1<<cpu))
 			set_bit(cpi, &vic_cpi_mailbox[cpu]);
 	}
@@ -1579,7 +1579,7 @@ enable_vic_irq(unsigned int irq)
 	VDEBUG(("VOYAGER: enable_vic_irq(%d) CPU%d affinity 0x%lx\n",
 		irq, cpu, cpu_irq_affinity[cpu]));
 	spin_lock_irqsave(&vic_irq_lock, flags);
-	for_each_cpu(real_cpu, cpu_online_map) {
+	for_each_online_cpu(real_cpu) {
 		if(!(voyager_extended_vic_processors & (1<<real_cpu)))
 			continue;
 		if(!(cpu_irq_affinity[real_cpu] & mask)) {
@@ -1720,7 +1720,7 @@ after_handle_vic_irq(unsigned int irq)
 			int i;
 			__u8 cpu = smp_processor_id();
 			__u8 real_cpu;
-			int mask;
+			int mask; /* Um... initialize me??? --RR */
 
 			printk("VOYAGER SMP: CPU%d lost interrupt %d\n",
 			       cpu, irq);
@@ -1809,7 +1809,7 @@ set_vic_irq_affinity(unsigned int irq, c
 		 * bus) */
 		return;
 
-	for_each_cpu(cpu, cpu_online_map) {
+	for_each_online_cpu(cpu) {
 		unsigned long cpu_mask = 1 << cpu;
 		
 		if(cpu_mask & real_mask) {
@@ -1875,7 +1875,7 @@ voyager_smp_dump()
 	int old_cpu = smp_processor_id(), cpu;
 
 	/* dump the interrupt masks of each processor */
-	for_each_cpu(cpu, cpu_online_map) {
+	for_each_online_cpu(cpu) {
 		__u16 imr, isr, irr;
 		unsigned long flags;
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18232-linux-2.6.0-bk3/include/asm-alpha/smp.h .18232-linux-2.6.0-bk3.updated/include/asm-alpha/smp.h
--- .18232-linux-2.6.0-bk3/include/asm-alpha/smp.h	2003-09-29 10:25:56.000000000 +1000
+++ .18232-linux-2.6.0-bk3.updated/include/asm-alpha/smp.h	2003-12-31 11:39:43.000000000 +1100
@@ -48,8 +48,8 @@ extern struct cpuinfo_alpha cpu_data[NR_
 extern cpumask_t cpu_present_mask;
 extern cpumask_t cpu_online_map;
 extern int smp_num_cpus;
+#define cpu_possible_map	cpu_present_map
 
-#define cpu_possible(cpu)	cpu_isset(cpu, cpu_present_mask)
 #define cpu_online(cpu)		cpu_isset(cpu, cpu_online_map)
 
 extern int smp_call_function_on_cpu(void (*func) (void *info), void *info,int retry, int wait, unsigned long cpu);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18232-linux-2.6.0-bk3/include/asm-i386/smp.h .18232-linux-2.6.0-bk3.updated/include/asm-i386/smp.h
--- .18232-linux-2.6.0-bk3/include/asm-i386/smp.h	2003-09-22 10:28:12.000000000 +1000
+++ .18232-linux-2.6.0-bk3.updated/include/asm-i386/smp.h	2003-12-31 11:39:43.000000000 +1100
@@ -53,8 +53,7 @@ extern void zap_low_mappings (void);
 #define smp_processor_id() (current_thread_info()->cpu)
 
 extern cpumask_t cpu_callout_map;
-
-#define cpu_possible(cpu) cpu_isset(cpu, cpu_callout_map)
+#define cpu_possible_map cpu_callout_map
 
 /* We don't mark CPUs online until __cpu_up(), so we need another measure */
 static inline int num_booting_cpus(void)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18232-linux-2.6.0-bk3/include/asm-ia64/smp.h .18232-linux-2.6.0-bk3.updated/include/asm-ia64/smp.h
--- .18232-linux-2.6.0-bk3/include/asm-ia64/smp.h	2003-09-22 10:27:36.000000000 +1000
+++ .18232-linux-2.6.0-bk3.updated/include/asm-ia64/smp.h	2003-12-31 11:39:43.000000000 +1100
@@ -48,7 +48,7 @@ extern volatile int ia64_cpu_to_sapicid[
 
 extern unsigned long ap_wakeup_vector;
 
-#define cpu_possible(cpu)	cpu_isset(cpu, phys_cpu_present_map)
+#define cpu_possible_map phys_cpu_present_map
 
 /*
  * Function to map hard smp processor id to logical id.  Slow, so don't use this in
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18232-linux-2.6.0-bk3/include/asm-mips/smp.h .18232-linux-2.6.0-bk3.updated/include/asm-mips/smp.h
--- .18232-linux-2.6.0-bk3/include/asm-mips/smp.h	2003-09-22 10:27:36.000000000 +1000
+++ .18232-linux-2.6.0-bk3.updated/include/asm-mips/smp.h	2003-12-31 11:39:43.000000000 +1100
@@ -48,8 +48,8 @@ extern struct call_data_struct *call_dat
 
 extern cpumask_t phys_cpu_present_map;
 extern cpumask_t cpu_online_map;
+#define cpu_possible_map	phys_cpu_present_map
 
-#define cpu_possible(cpu)	cpu_isset(cpu, phys_cpu_present_map)
 #define cpu_online(cpu)		cpu_isset(cpu, cpu_online_map)
 
 static inline unsigned int num_online_cpus(void)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18232-linux-2.6.0-bk3/include/asm-parisc/smp.h .18232-linux-2.6.0-bk3.updated/include/asm-parisc/smp.h
--- .18232-linux-2.6.0-bk3/include/asm-parisc/smp.h	2003-09-22 10:27:36.000000000 +1000
+++ .18232-linux-2.6.0-bk3.updated/include/asm-parisc/smp.h	2003-12-31 11:39:43.000000000 +1100
@@ -54,7 +54,7 @@ extern unsigned long cpu_present_mask;
 #define smp_processor_id()	(current_thread_info()->cpu)
 #define cpu_online(cpu) cpu_isset(cpu, cpu_online_map)
 
-#define cpu_possible(cpu)       cpu_isset(cpu, cpu_present_mask)
+#define cpu_possible_map	cpu_present_map
 
 #endif /* CONFIG_SMP */
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18232-linux-2.6.0-bk3/include/asm-ppc/smp.h .18232-linux-2.6.0-bk3.updated/include/asm-ppc/smp.h
--- .18232-linux-2.6.0-bk3/include/asm-ppc/smp.h	2003-09-22 10:27:36.000000000 +1000
+++ .18232-linux-2.6.0-bk3.updated/include/asm-ppc/smp.h	2003-12-31 11:39:43.000000000 +1100
@@ -48,7 +48,6 @@ extern void smp_local_timer_interrupt(st
 #define smp_processor_id() (current_thread_info()->cpu)
 
 #define cpu_online(cpu) cpu_isset(cpu, cpu_online_map)
-#define cpu_possible(cpu) cpu_isset(cpu, cpu_possible_map)
 
 extern int __cpu_up(unsigned int cpu);
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18232-linux-2.6.0-bk3/include/asm-s390/smp.h .18232-linux-2.6.0-bk3.updated/include/asm-s390/smp.h
--- .18232-linux-2.6.0-bk3/include/asm-s390/smp.h	2003-09-29 10:26:01.000000000 +1000
+++ .18232-linux-2.6.0-bk3.updated/include/asm-s390/smp.h	2003-12-31 11:39:43.000000000 +1100
@@ -49,7 +49,6 @@ extern cpumask_t cpu_possible_map;
 #define smp_processor_id() (S390_lowcore.cpu_data.cpu_nr)
 
 #define cpu_online(cpu) cpu_isset(cpu, cpu_online_map)
-#define cpu_possible(cpu) cpu_isset(cpu, cpu_possible_map)
 
 extern __inline__ __u16 hard_smp_processor_id(void)
 {
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18232-linux-2.6.0-bk3/include/asm-sh/smp.h .18232-linux-2.6.0-bk3.updated/include/asm-sh/smp.h
--- .18232-linux-2.6.0-bk3/include/asm-sh/smp.h	2003-09-22 10:23:00.000000000 +1000
+++ .18232-linux-2.6.0-bk3.updated/include/asm-sh/smp.h	2003-12-31 11:39:43.000000000 +1100
@@ -16,7 +16,6 @@
 extern unsigned long cpu_online_map;
 
 #define cpu_online(cpu)		(cpu_online_map & (1 << (cpu)))
-#define cpu_possible(cpu)	(cpu_online(cpu))
 
 #define smp_processor_id()	(current_thread_info()->cpu)
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18232-linux-2.6.0-bk3/include/asm-sparc64/smp.h .18232-linux-2.6.0-bk3.updated/include/asm-sparc64/smp.h
--- .18232-linux-2.6.0-bk3/include/asm-sparc64/smp.h	2003-09-22 10:27:37.000000000 +1000
+++ .18232-linux-2.6.0-bk3.updated/include/asm-sparc64/smp.h	2003-12-31 11:39:43.000000000 +1100
@@ -33,7 +33,7 @@
 extern unsigned char boot_cpu_id;
 
 extern cpumask_t phys_cpu_present_map;
-#define cpu_possible(cpu)	cpu_isset(cpu, phys_cpu_present_map)
+#define cpu_possible_map phys_cpu_present_map
 
 #define cpu_online(cpu)		cpu_isset(cpu, cpu_online_map)
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18232-linux-2.6.0-bk3/include/asm-um/smp.h .18232-linux-2.6.0-bk3.updated/include/asm-um/smp.h
--- .18232-linux-2.6.0-bk3/include/asm-um/smp.h	2003-09-22 10:27:37.000000000 +1000
+++ .18232-linux-2.6.0-bk3.updated/include/asm-um/smp.h	2003-12-31 11:39:43.000000000 +1100
@@ -20,7 +20,7 @@ extern int hard_smp_processor_id(void);
 #define cpu_online(cpu) cpu_isset(cpu, cpu_online_map)
 
 extern int ncpus;
-#define cpu_possible(cpu) (cpu < ncpus)
+
 
 extern inline void smp_cpus_done(unsigned int maxcpus)
 {
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18232-linux-2.6.0-bk3/include/asm-x86_64/smp.h .18232-linux-2.6.0-bk3.updated/include/asm-x86_64/smp.h
--- .18232-linux-2.6.0-bk3/include/asm-x86_64/smp.h	2003-11-24 15:42:33.000000000 +1100
+++ .18232-linux-2.6.0-bk3.updated/include/asm-x86_64/smp.h	2003-12-31 11:39:43.000000000 +1100
@@ -57,8 +57,7 @@ void smp_stop_cpu(void);
  */
 
 extern cpumask_t cpu_callout_map;
-
-#define cpu_possible(cpu) cpu_isset(cpu, cpu_callout_map)
+#define cpu_possible_map cpu_callout_map
 #define cpu_online(cpu) cpu_isset(cpu, cpu_online_map)
 
 static inline int num_booting_cpus(void)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18232-linux-2.6.0-bk3/include/linux/cpumask.h .18232-linux-2.6.0-bk3.updated/include/linux/cpumask.h
--- .18232-linux-2.6.0-bk3/include/linux/cpumask.h	2003-12-31 10:04:40.000000000 +1100
+++ .18232-linux-2.6.0-bk3.updated/include/linux/cpumask.h	2003-12-31 11:40:59.000000000 +1100
@@ -8,32 +8,28 @@
 #ifdef CONFIG_SMP
 
 extern cpumask_t cpu_online_map;
+extern cpumask_t cpu_possible_map;
 
 #define num_online_cpus()		cpus_weight(cpu_online_map)
 #define cpu_online(cpu)			cpu_isset(cpu, cpu_online_map)
+#define cpu_possible(cpu)		cpu_isset(cpu, cpu_possible_map)
+
+#define for_each_cpu_mask(cpu, mask)			\
+	for (cpu = first_cpu_const(mask);		\
+		cpu < NR_CPUS;				\
+		cpu = next_cpu_const(cpu, mask))
+
+#define for_each_cpu(cpu) for_each_cpu_mask(cpu, cpu_possible_map)
+#define for_each_online_cpu(cpu) for_each_cpu_mask(cpu, cpu_online_map)
 #else
 #define	cpu_online_map			cpumask_of_cpu(0)
 #define num_online_cpus()		1
 #define cpu_online(cpu)			({ BUG_ON((cpu) != 0); 1; })
-#endif
-
-static inline int next_online_cpu(int cpu, cpumask_t map)
-{
-	do
-		cpu = next_cpu_const(cpu, mk_cpumask_const(map));
-	while (cpu < NR_CPUS && !cpu_online(cpu));
-	return cpu;
-}
-
-#define for_each_cpu(cpu, map)						\
-	for (cpu = first_cpu_const(mk_cpumask_const(map));		\
-		cpu < NR_CPUS;						\
-		cpu = next_cpu_const(cpu,mk_cpumask_const(map)))
+#define cpu_possible(cpu)		({ BUG_ON((cpu) != 0); 1; })
 
-#define for_each_online_cpu(cpu, map)					\
-	for (cpu = first_cpu_const(mk_cpumask_const(map));		\
-		cpu < NR_CPUS;						\
-		cpu = next_online_cpu(cpu,map))
+#define for_each_cpu(cpu) for (cpu = 0; cpu < 1; cpu++)
+#define for_each_online_cpu(cpu) for (cpu = 0; cpu < 1; cpu++)
+#endif
 
 extern int __mask_snprintf_len(char *buf, unsigned int buflen,
 		const unsigned long *maskp, unsigned int maskbytes);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18232-linux-2.6.0-bk3/include/linux/smp.h .18232-linux-2.6.0-bk3.updated/include/linux/smp.h
--- .18232-linux-2.6.0-bk3/include/linux/smp.h	2003-09-22 10:27:37.000000000 +1000
+++ .18232-linux-2.6.0-bk3.updated/include/linux/smp.h	2003-12-31 11:39:43.000000000 +1100
@@ -103,7 +103,6 @@ void smp_prepare_boot_cpu(void);
 #define on_each_cpu(func,info,retry,wait)	({ func(info); 0; })
 static inline void smp_send_reschedule(int cpu) { }
 #define num_booting_cpus()			1
-#define cpu_possible(cpu)			({ BUG_ON((cpu) != 0); 1; })
 #define smp_prepare_boot_cpu()			do {} while (0)
 
 #endif /* !SMP */

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
