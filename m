Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264423AbTLWCjA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 21:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264433AbTLWCjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 21:39:00 -0500
Received: from dp.samba.org ([66.70.73.150]:65515 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264423AbTLWCid (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 21:38:33 -0500
Date: Tue, 23 Dec 2003 12:45:04 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, ioe-lkml@rameria.de
Subject: Re: [PATCH] another minor bit of cpumask cleanup
Message-Id: <20031223124504.29dc5ed1.rusty@rustcorp.com.au>
In-Reply-To: <20031221231918.34fcca86.pj@sgi.com>
References: <20031221180044.0f27eca1.pj@sgi.com>
	<20031221224745.268db46d.akpm@osdl.org>
	<20031221231918.34fcca86.pj@sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Dec 2003 23:19:18 -0800
Paul Jackson <pj@sgi.com> wrote:

> > Please, hang onto it until we get things synced up a bit more.
> 
> Ok - good idea.  I'll resend later on.  There is no hurry on this one.

For the hotplug CPU stuff, I have a patch which changes these iterators anyway,
as discussed with wli and Patrick Mochel.  I'll push once we see a -pre: I
didn't know there was such widespread interest.

The idea is simple: encourage people to use the right iterators.  So
for_each_cpu() does each possible cpu (normally the right thing), 
for_each_online_cpu() does online cpus (implying you're holding the
cpucontrol sem) and for_each_cpu_mask() does a generic iteration.

FYI, patches below against 2.6.0: there are some other changes here which
conflict in -mm.

As to appreciation: I'd rather have 12 crossing patches than silence and
apathy.  At least this way we get informed criticism 8)

Thanks,
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy

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
D: use a #define to define it in asm/smp.h, so the iterators are moved
D: from linux/cpumask.h to linux/smp.h, where that is asm/smp.h is included.
D: 
D: Most places doing loops over cpus testing for cpu_online() should use
D: for_each_cpu: it is synonymous at the moment, but with the CPU hotplug patch
D: the difference becomes important.
D: 
D: Followup patches will convert users.
D: 
D: Thanks!
D: Rusty.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22261-linux-2.6.0-test9-bk4/arch/i386/mach-voyager/voyager_smp.c .22261-linux-2.6.0-test9-bk4.updated/arch/i386/mach-voyager/voyager_smp.c
--- .22261-linux-2.6.0-test9-bk4/arch/i386/mach-voyager/voyager_smp.c	2003-09-22 10:27:54.000000000 +1000
+++ .22261-linux-2.6.0-test9-bk4.updated/arch/i386/mach-voyager/voyager_smp.c	2003-10-31 16:26:20.000000000 +1100
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
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22261-linux-2.6.0-test9-bk4/include/asm-alpha/smp.h .22261-linux-2.6.0-test9-bk4.updated/include/asm-alpha/smp.h
--- .22261-linux-2.6.0-test9-bk4/include/asm-alpha/smp.h	2003-09-29 10:25:56.000000000 +1000
+++ .22261-linux-2.6.0-test9-bk4.updated/include/asm-alpha/smp.h	2003-10-31 16:26:20.000000000 +1100
@@ -48,8 +48,8 @@ extern struct cpuinfo_alpha cpu_data[NR_
 extern cpumask_t cpu_present_mask;
 extern cpumask_t cpu_online_map;
 extern int smp_num_cpus;
+#define cpu_possible_map	cpu_present_map
 
-#define cpu_possible(cpu)	cpu_isset(cpu, cpu_present_mask)
 #define cpu_online(cpu)		cpu_isset(cpu, cpu_online_map)
 
 extern int smp_call_function_on_cpu(void (*func) (void *info), void *info,int retry, int wait, unsigned long cpu);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22261-linux-2.6.0-test9-bk4/include/asm-i386/smp.h .22261-linux-2.6.0-test9-bk4.updated/include/asm-i386/smp.h
--- .22261-linux-2.6.0-test9-bk4/include/asm-i386/smp.h	2003-09-22 10:28:12.000000000 +1000
+++ .22261-linux-2.6.0-test9-bk4.updated/include/asm-i386/smp.h	2003-10-31 16:26:20.000000000 +1100
@@ -53,8 +53,7 @@ extern void zap_low_mappings (void);
 #define smp_processor_id() (current_thread_info()->cpu)
 
 extern cpumask_t cpu_callout_map;
-
-#define cpu_possible(cpu) cpu_isset(cpu, cpu_callout_map)
+#define cpu_possible_map cpu_callout_map
 
 /* We don't mark CPUs online until __cpu_up(), so we need another measure */
 static inline int num_booting_cpus(void)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22261-linux-2.6.0-test9-bk4/include/asm-ia64/smp.h .22261-linux-2.6.0-test9-bk4.updated/include/asm-ia64/smp.h
--- .22261-linux-2.6.0-test9-bk4/include/asm-ia64/smp.h	2003-09-22 10:27:36.000000000 +1000
+++ .22261-linux-2.6.0-test9-bk4.updated/include/asm-ia64/smp.h	2003-10-31 16:26:20.000000000 +1100
@@ -48,7 +48,7 @@ extern volatile int ia64_cpu_to_sapicid[
 
 extern unsigned long ap_wakeup_vector;
 
-#define cpu_possible(cpu)	cpu_isset(cpu, phys_cpu_present_map)
+#define cpu_possible_map phys_cpu_present_map
 
 /*
  * Function to map hard smp processor id to logical id.  Slow, so don't use this in
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22261-linux-2.6.0-test9-bk4/include/asm-mips/smp.h .22261-linux-2.6.0-test9-bk4.updated/include/asm-mips/smp.h
--- .22261-linux-2.6.0-test9-bk4/include/asm-mips/smp.h	2003-09-22 10:27:36.000000000 +1000
+++ .22261-linux-2.6.0-test9-bk4.updated/include/asm-mips/smp.h	2003-10-31 16:26:20.000000000 +1100
@@ -48,8 +48,8 @@ extern struct call_data_struct *call_dat
 
 extern cpumask_t phys_cpu_present_map;
 extern cpumask_t cpu_online_map;
+#define cpu_possible_map	phys_cpu_present_map
 
-#define cpu_possible(cpu)	cpu_isset(cpu, phys_cpu_present_map)
 #define cpu_online(cpu)		cpu_isset(cpu, cpu_online_map)
 
 static inline unsigned int num_online_cpus(void)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22261-linux-2.6.0-test9-bk4/include/asm-parisc/smp.h .22261-linux-2.6.0-test9-bk4.updated/include/asm-parisc/smp.h
--- .22261-linux-2.6.0-test9-bk4/include/asm-parisc/smp.h	2003-09-22 10:27:36.000000000 +1000
+++ .22261-linux-2.6.0-test9-bk4.updated/include/asm-parisc/smp.h	2003-10-31 16:26:20.000000000 +1100
@@ -54,7 +54,7 @@ extern unsigned long cpu_present_mask;
 #define smp_processor_id()	(current_thread_info()->cpu)
 #define cpu_online(cpu) cpu_isset(cpu, cpu_online_map)
 
-#define cpu_possible(cpu)       cpu_isset(cpu, cpu_present_mask)
+#define cpu_possible_map	cpu_present_map
 
 #endif /* CONFIG_SMP */
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22261-linux-2.6.0-test9-bk4/include/asm-ppc/smp.h .22261-linux-2.6.0-test9-bk4.updated/include/asm-ppc/smp.h
--- .22261-linux-2.6.0-test9-bk4/include/asm-ppc/smp.h	2003-09-22 10:27:36.000000000 +1000
+++ .22261-linux-2.6.0-test9-bk4.updated/include/asm-ppc/smp.h	2003-10-31 16:26:20.000000000 +1100
@@ -48,7 +48,6 @@ extern void smp_local_timer_interrupt(st
 #define smp_processor_id() (current_thread_info()->cpu)
 
 #define cpu_online(cpu) cpu_isset(cpu, cpu_online_map)
-#define cpu_possible(cpu) cpu_isset(cpu, cpu_possible_map)
 
 extern int __cpu_up(unsigned int cpu);
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22261-linux-2.6.0-test9-bk4/include/asm-s390/smp.h .22261-linux-2.6.0-test9-bk4.updated/include/asm-s390/smp.h
--- .22261-linux-2.6.0-test9-bk4/include/asm-s390/smp.h	2003-09-29 10:26:01.000000000 +1000
+++ .22261-linux-2.6.0-test9-bk4.updated/include/asm-s390/smp.h	2003-10-31 16:26:20.000000000 +1100
@@ -49,7 +49,6 @@ extern cpumask_t cpu_possible_map;
 #define smp_processor_id() (S390_lowcore.cpu_data.cpu_nr)
 
 #define cpu_online(cpu) cpu_isset(cpu, cpu_online_map)
-#define cpu_possible(cpu) cpu_isset(cpu, cpu_possible_map)
 
 extern __inline__ __u16 hard_smp_processor_id(void)
 {
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22261-linux-2.6.0-test9-bk4/include/asm-sh/smp.h .22261-linux-2.6.0-test9-bk4.updated/include/asm-sh/smp.h
--- .22261-linux-2.6.0-test9-bk4/include/asm-sh/smp.h	2003-09-22 10:23:00.000000000 +1000
+++ .22261-linux-2.6.0-test9-bk4.updated/include/asm-sh/smp.h	2003-10-31 16:26:20.000000000 +1100
@@ -16,7 +16,6 @@
 extern unsigned long cpu_online_map;
 
 #define cpu_online(cpu)		(cpu_online_map & (1 << (cpu)))
-#define cpu_possible(cpu)	(cpu_online(cpu))
 
 #define smp_processor_id()	(current_thread_info()->cpu)
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22261-linux-2.6.0-test9-bk4/include/asm-sparc64/smp.h .22261-linux-2.6.0-test9-bk4.updated/include/asm-sparc64/smp.h
--- .22261-linux-2.6.0-test9-bk4/include/asm-sparc64/smp.h	2003-09-22 10:27:37.000000000 +1000
+++ .22261-linux-2.6.0-test9-bk4.updated/include/asm-sparc64/smp.h	2003-10-31 16:26:20.000000000 +1100
@@ -33,7 +33,7 @@
 extern unsigned char boot_cpu_id;
 
 extern cpumask_t phys_cpu_present_map;
-#define cpu_possible(cpu)	cpu_isset(cpu, phys_cpu_present_map)
+#define cpu_possible_map phys_cpu_present_map
 
 #define cpu_online(cpu)		cpu_isset(cpu, cpu_online_map)
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22261-linux-2.6.0-test9-bk4/include/asm-um/smp.h .22261-linux-2.6.0-test9-bk4.updated/include/asm-um/smp.h
--- .22261-linux-2.6.0-test9-bk4/include/asm-um/smp.h	2003-09-22 10:27:37.000000000 +1000
+++ .22261-linux-2.6.0-test9-bk4.updated/include/asm-um/smp.h	2003-10-31 16:26:20.000000000 +1100
@@ -20,7 +20,7 @@ extern int hard_smp_processor_id(void);
 #define cpu_online(cpu) cpu_isset(cpu, cpu_online_map)
 
 extern int ncpus;
-#define cpu_possible(cpu) (cpu < ncpus)
+
 
 extern inline void smp_cpus_done(unsigned int maxcpus)
 {
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22261-linux-2.6.0-test9-bk4/include/asm-x86_64/smp.h .22261-linux-2.6.0-test9-bk4.updated/include/asm-x86_64/smp.h
--- .22261-linux-2.6.0-test9-bk4/include/asm-x86_64/smp.h	2003-10-31 10:27:44.000000000 +1100
+++ .22261-linux-2.6.0-test9-bk4.updated/include/asm-x86_64/smp.h	2003-10-31 16:26:20.000000000 +1100
@@ -57,8 +57,7 @@ void smp_stop_cpu(void);
  */
 
 extern cpumask_t cpu_callout_map;
-
-#define cpu_possible(cpu) cpu_isset(cpu, cpu_callout_map)
+#define cpu_possible_map cpu_callout_map
 #define cpu_online(cpu) cpu_isset(cpu, cpu_online_map)
 
 static inline int num_booting_cpus(void)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22261-linux-2.6.0-test9-bk4/include/linux/cpumask.h .22261-linux-2.6.0-test9-bk4.updated/include/linux/cpumask.h
--- .22261-linux-2.6.0-test9-bk4/include/linux/cpumask.h	2003-09-22 10:27:37.000000000 +1000
+++ .22261-linux-2.6.0-test9-bk4.updated/include/linux/cpumask.h	2003-10-31 16:28:16.000000000 +1100
@@ -41,31 +41,27 @@ typedef unsigned long cpumask_t;
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
-		cpu = next_cpu_const(cpu, map);
-	while (cpu < NR_CPUS && !cpu_online(cpu));
-	return cpu;
-}
-
-#define for_each_cpu(cpu, map)						\
-	for (cpu = first_cpu_const(map);				\
-		cpu < NR_CPUS;						\
-		cpu = next_cpu_const(cpu,map))
+#define cpu_possible(cpu)		({ BUG_ON((cpu) != 0); 1; })
 
-#define for_each_online_cpu(cpu, map)					\
-	for (cpu = first_cpu_const(map);				\
-		cpu < NR_CPUS;						\
-		cpu = next_online_cpu(cpu,map))
+#define for_each_cpu(cpu) for (cpu = 0; cpu < 1; cpu++)
+#define for_each_online_cpu(cpu) for (cpu = 0; cpu < 1; cpu++)
+#endif
 
 #endif /* __LINUX_CPUMASK_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .22261-linux-2.6.0-test9-bk4/include/linux/smp.h .22261-linux-2.6.0-test9-bk4.updated/include/linux/smp.h
--- .22261-linux-2.6.0-test9-bk4/include/linux/smp.h	2003-09-22 10:27:37.000000000 +1000
+++ .22261-linux-2.6.0-test9-bk4.updated/include/linux/smp.h	2003-10-31 16:26:20.000000000 +1100
@@ -103,7 +103,6 @@ void smp_prepare_boot_cpu(void);
 #define on_each_cpu(func,info,retry,wait)	({ func(info); 0; })
 static inline void smp_send_reschedule(int cpu) { }
 #define num_booting_cpus()			1
-#define cpu_possible(cpu)			({ BUG_ON((cpu) != 0); 1; })
 #define smp_prepare_boot_cpu()			do {} while (0)
 
 #endif /* !SMP */


Name: Use for_each_cpu() where cpu_online() is incorrectly used.
Author: Rusty Russell
Status: Booted on 2.6.0
Depends: Hotcpu/cpu_iterator.patch.gz

D: Some places use cpu_online() where they should be using cpu_possible,
D: most commonly for tallying statistics.  This makes no difference without
D: hotplug CPU.
D: 
D: Use the for_each_cpu() macro in those places, providing good
D: examples (and making the external hotplug CPU patch smaller).

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .908-linux-2.6.0-test7-bk3/fs/buffer.c .908-linux-2.6.0-test7-bk3.updated/fs/buffer.c
--- .908-linux-2.6.0-test7-bk3/fs/buffer.c	2003-10-09 18:02:57.000000000 +1000
+++ .908-linux-2.6.0-test7-bk3.updated/fs/buffer.c	2003-10-13 08:45:09.000000000 +1000
@@ -2944,10 +2944,8 @@ static void recalc_bh_state(void)
 	if (__get_cpu_var(bh_accounting).ratelimit++ < 4096)
 		return;
 	__get_cpu_var(bh_accounting).ratelimit = 0;
-	for (i = 0; i < NR_CPUS; i++) {
-		if (cpu_online(i))
-			tot += per_cpu(bh_accounting, i).nr;
-	}
+	for_each_cpu(i)
+		tot += per_cpu(bh_accounting, i).nr;
 	buffer_heads_over_limit = (tot > max_buffer_heads);
 }
 	
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .908-linux-2.6.0-test7-bk3/fs/proc/proc_misc.c .908-linux-2.6.0-test7-bk3.updated/fs/proc/proc_misc.c
--- .908-linux-2.6.0-test7-bk3/fs/proc/proc_misc.c	2003-09-29 10:25:53.000000000 +1000
+++ .908-linux-2.6.0-test7-bk3.updated/fs/proc/proc_misc.c	2003-10-13 08:45:09.000000000 +1000
@@ -378,10 +378,9 @@ int show_stat(struct seq_file *p, void *
 	jif = ((u64)now.tv_sec * HZ) + (now.tv_usec/(1000000/HZ)) - jif;
 	do_div(jif, HZ);
 
-	for (i = 0; i < NR_CPUS; i++) {
+	for_each_cpu(i) {
 		int j;
 
-		if (!cpu_online(i)) continue;
 		user += kstat_cpu(i).cpustat.user;
 		nice += kstat_cpu(i).cpustat.nice;
 		system += kstat_cpu(i).cpustat.system;
@@ -401,8 +400,7 @@ int show_stat(struct seq_file *p, void *
 		jiffies_to_clock_t(iowait),
 		jiffies_to_clock_t(irq),
 		jiffies_to_clock_t(softirq));
-	for (i = 0; i < NR_CPUS; i++){
-		if (!cpu_online(i)) continue;
+	for_each_online_cpu(i) {
 		seq_printf(p, "cpu%d %u %u %u %u %u %u %u\n",
 			i,
 			jiffies_to_clock_t(kstat_cpu(i).cpustat.user),
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .908-linux-2.6.0-test7-bk3/kernel/fork.c .908-linux-2.6.0-test7-bk3.updated/kernel/fork.c
--- .908-linux-2.6.0-test7-bk3/kernel/fork.c	2003-10-12 11:04:17.000000000 +1000
+++ .908-linux-2.6.0-test7-bk3.updated/kernel/fork.c	2003-10-13 08:45:09.000000000 +1000
@@ -60,10 +60,9 @@ int nr_processes(void)
 	int cpu;
 	int total = 0;
 
-	for (cpu = 0; cpu < NR_CPUS; cpu++) {
-		if (cpu_online(cpu))
-			total += per_cpu(process_counts, cpu);
-	}
+	for_each_cpu(cpu)
+		total += per_cpu(process_counts, cpu);
+
 	return total;
 }
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .908-linux-2.6.0-test7-bk3/kernel/sched.c .908-linux-2.6.0-test7-bk3.updated/kernel/sched.c
--- .908-linux-2.6.0-test7-bk3/kernel/sched.c	2003-10-09 18:03:02.000000000 +1000
+++ .908-linux-2.6.0-test7-bk3.updated/kernel/sched.c	2003-10-13 08:45:09.000000000 +1000
@@ -829,11 +829,9 @@ unsigned long nr_uninterruptible(void)
 {
 	unsigned long i, sum = 0;
 
-	for (i = 0; i < NR_CPUS; i++) {
-		if (!cpu_online(i))
-			continue;
+	for_each_cpu(i)
 		sum += cpu_rq(i)->nr_uninterruptible;
-	}
+
 	return sum;
 }
 
@@ -841,11 +839,9 @@ unsigned long nr_context_switches(void)
 {
 	unsigned long i, sum = 0;
 
-	for (i = 0; i < NR_CPUS; i++) {
-		if (!cpu_online(i))
-			continue;
+	for_each_cpu(i)
 		sum += cpu_rq(i)->nr_switches;
-	}
+
 	return sum;
 }
 
@@ -853,11 +849,9 @@ unsigned long nr_iowait(void)
 {
 	unsigned long i, sum = 0;
 
-	for (i = 0; i < NR_CPUS; ++i) {
-		if (!cpu_online(i))
-			continue;
+	for_each_cpu(i)
 		sum += atomic_read(&cpu_rq(i)->nr_iowait);
-	}
+
 	return sum;
 }
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .908-linux-2.6.0-test7-bk3/kernel/workqueue.c .908-linux-2.6.0-test7-bk3.updated/kernel/workqueue.c
--- .908-linux-2.6.0-test7-bk3/kernel/workqueue.c	2003-09-22 10:27:38.000000000 +1000
+++ .908-linux-2.6.0-test7-bk3.updated/kernel/workqueue.c	2003-10-13 08:45:09.000000000 +1000
@@ -366,9 +366,7 @@ int current_is_keventd(void)
 
 	BUG_ON(!keventd_wq);
 
-	for (cpu = 0; cpu < NR_CPUS; cpu++) {
-		if (!cpu_online(cpu))
-			continue;
+	for_each_cpu(cpu) {
 		cwq = keventd_wq->cpu_wq + cpu;
 		if (current == cwq->thread)
 			return 1;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .908-linux-2.6.0-test7-bk3/mm/page_alloc.c .908-linux-2.6.0-test7-bk3.updated/mm/page_alloc.c
--- .908-linux-2.6.0-test7-bk3/mm/page_alloc.c	2003-10-09 18:03:02.000000000 +1000
+++ .908-linux-2.6.0-test7-bk3.updated/mm/page_alloc.c	2003-10-13 08:49:27.000000000 +1000
@@ -867,14 +867,14 @@ void __get_page_state(struct page_state 
 	while (cpu < NR_CPUS) {
 		unsigned long *in, *out, off;
 
-		if (!cpu_online(cpu)) {
+		if (!cpu_possible(cpu)) {
 			cpu++;
 			continue;
 		}
 
 		in = (unsigned long *)&per_cpu(page_states, cpu);
 		cpu++;
-		if (cpu < NR_CPUS && cpu_online(cpu))
+		if (cpu < NR_CPUS && cpu_possible(cpu))
 			prefetch(&per_cpu(page_states, cpu));
 		out = (unsigned long *)ret;
 		for (off = 0; off < nr; off++)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .908-linux-2.6.0-test7-bk3/net/ipv4/route.c .908-linux-2.6.0-test7-bk3.updated/net/ipv4/route.c
--- .908-linux-2.6.0-test7-bk3/net/ipv4/route.c	2003-10-09 18:03:03.000000000 +1000
+++ .908-linux-2.6.0-test7-bk3.updated/net/ipv4/route.c	2003-10-13 08:45:09.000000000 +1000
@@ -2703,12 +2703,9 @@ static int ip_rt_acct_read(char *buffer,
 		memcpy(dst, src, length);
 
 		/* Add the other cpus in, one int at a time */
-		for (i = 1; i < NR_CPUS; i++) {
+		for_each_cpu(i) {
 			unsigned int j;
 
-			if (!cpu_online(i))
-				continue;
-
 			src = ((u32 *) IP_RT_ACCT_CPU(i)) + offset;
 
 			for (j = 0; j < length/4; j++)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .3441-2.6.0-test9-hotcpu-i386.pre/kernel/timer.c .3441-2.6.0-test9-hotcpu-i386/kernel/timer.c
--- .3441-2.6.0-test9-hotcpu-i386.pre/kernel/timer.c	2003-10-27 13:26:01.000000000 +1100
+++ .3441-2.6.0-test9-hotcpu-i386/kernel/timer.c	2003-10-27 13:26:02.000000000 +1100
@@ -332,10 +332,7 @@ int del_timer_sync(struct timer_list *ti
 del_again:
 	ret += del_timer(timer);
 
-	for (i = 0; i < NR_CPUS; i++) {
-		if (!cpu_online(i))
-			continue;
-
+	for_each_cpu(i) {
 		base = &per_cpu(tvec_bases, i);
 		if (base->running_timer == timer) {
 			while (base->running_timer == timer) {
