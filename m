Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266210AbTBCLaS>; Mon, 3 Feb 2003 06:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266224AbTBCLaS>; Mon, 3 Feb 2003 06:30:18 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:9579
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S266210AbTBCL3Q>; Mon, 3 Feb 2003 06:29:16 -0500
Date: Mon, 3 Feb 2003 06:37:59 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH][5/6] CPU Hotplug i386
Message-ID: <Pine.LNX.4.44.0302030550480.9361-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 arch/i386/kernel/process.c |   39 ++++++++++++++++++++++++++++--
 arch/i386/kernel/smp.c     |   18 +++++++++++--
 arch/i386/kernel/smpboot.c |   58 +++++++++++++++++++++++++++++++++++++++++----
 include/asm-i386/smp.h     |    4 +++
 4 files changed, 110 insertions(+), 9 deletions(-)

Index: linux-2.5.59-lch2/include/asm-i386/smp.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.59/include/asm-i386/smp.h,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.2.1
diff -u -r1.1.1.1 -r1.1.1.1.2.1
--- linux-2.5.59-lch2/include/asm-i386/smp.h	17 Jan 2003 11:16:10 -0000	1.1.1.1
+++ linux-2.5.59-lch2/include/asm-i386/smp.h	20 Jan 2003 13:48:27 -0000	1.1.1.1.2.1
@@ -100,6 +100,10 @@
 }
 
 #endif
+
+extern int __cpu_disable(void);
+extern void __cpu_die(unsigned int cpu);
+
 #endif /* !__ASSEMBLY__ */
 
 #define NO_PROC_ID		0xFF		/* No processor magic marker */
Index: linux-2.5.59-lch2/arch/i386/kernel/process.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59/arch/i386/kernel/process.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 process.c
--- linux-2.5.59-lch2/arch/i386/kernel/process.c	17 Jan 2003 11:14:42 -0000	1.1.1.1
+++ linux-2.5.59-lch2/arch/i386/kernel/process.c	20 Jan 2003 14:24:35 -0000
@@ -36,7 +36,7 @@
 #include <linux/mc146818rtc.h>
 #include <linux/module.h>
 #include <linux/kallsyms.h>
-
+#include <linux/brlock.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/system.h>
@@ -46,6 +46,7 @@
 #include <asm/i387.h>
 #include <asm/irq.h>
 #include <asm/desc.h>
+#include <asm/tlbflush.h>
 #ifdef CONFIG_MATH_EMULATION
 #include <asm/math_emu.h>
 #endif
@@ -80,6 +81,8 @@
 	hlt_counter--;
 }
 
+DECLARE_PER_CPU(int, cpu_die);
+
 /*
  * We use this if we don't have any better
  * idle routine..
@@ -127,6 +130,36 @@
 	}
 }
 
+#ifdef CONFIG_HOTPLUG
+static inline void maybe_play_dead(void)
+{
+	if (unlikely(__get_cpu_var(cpu_die))) {
+		printk("Cpu %u Dust Dust Dust\n", smp_processor_id());
+		/* Ack it */
+		__get_cpu_var(cpu_die) = 2;
+
+		/* Death loop */
+		local_irq_disable();
+		while (__get_cpu_var(cpu_die))
+			cpu_relax();
+		local_irq_enable();
+
+		/* Now, we missed any cache flush IPIs, so be safe. */
+		local_flush_tlb();
+
+		/* Ack it by setting online bit */
+		br_write_lock_irq(BR_CPU_LOCK);
+		set_bit(smp_processor_id(), &cpu_online_map);
+		br_write_unlock_irq(BR_CPU_LOCK);
+		printk("Cpu %u arisen\n", smp_processor_id());
+	}
+}
+#else
+static inline void maybe_play_dead(void)
+{
+}
+#endif /*CONFIG_HOTPLUG*/
+
 /*
  * The idle thread. There's no useful work to be
  * done, so just try to conserve power and have a
@@ -141,8 +174,10 @@
 		if (!idle)
 			idle = default_idle;
 		irq_stat[smp_processor_id()].idle_timestamp = jiffies;
-		while (!need_resched())
+		while (!need_resched()) {
+			maybe_play_dead();
 			idle();
+		}
 		schedule();
 	}
 }
Index: linux-2.5.59-lch2/arch/i386/kernel/smp.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59/arch/i386/kernel/smp.c,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.2.1
diff -u -r1.1.1.1 -r1.1.1.1.2.1
--- linux-2.5.59-lch2/arch/i386/kernel/smp.c	17 Jan 2003 11:14:42 -0000	1.1.1.1
+++ linux-2.5.59-lch2/arch/i386/kernel/smp.c	20 Jan 2003 13:48:26 -0000	1.1.1.1.2.1
@@ -19,6 +19,7 @@
 #include <linux/mc146818rtc.h>
 #include <linux/cache.h>
 #include <linux/interrupt.h>
+#include <linux/brlock.h>
 
 #include <asm/mtrr.h>
 #include <asm/pgalloc.h>
@@ -350,13 +351,18 @@
 	 */
 	if (!cpumask)
 		BUG();
-	if ((cpumask & cpu_online_map) != cpumask)
+	if ((cpumask & cpu_callout_map) != cpumask)
 		BUG();
 	if (cpumask & (1 << smp_processor_id()))
 		BUG();
 	if (!mm)
 		BUG();
 
+	/* CPUs might have gone offline: don't worry about them. */
+	cpumask &= cpu_online_map;
+	if (!cpumask)
+		return;
+
 	/*
 	 * i'm not happy about this global shared spinlock in the
 	 * MM hot path, but we'll see how contended it is.
@@ -515,10 +521,15 @@
  */
 {
 	struct call_data_struct data;
-	int cpus = num_online_cpus()-1;
+	int cpus;
 
-	if (!cpus)
+	br_read_lock(BR_CPU_LOCK);
+	cpus = num_online_cpus()-1;
+
+	if (!cpus) {
+		br_read_unlock(BR_CPU_LOCK);
 		return 0;
+	}
 
 	data.func = func;
 	data.info = info;
@@ -542,6 +553,7 @@
 			barrier();
 	spin_unlock(&call_lock);
 
+	br_read_unlock(BR_CPU_LOCK);
 	return 0;
 }
 
Index: linux-2.5.59-lch2/arch/i386/kernel/smpboot.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59/arch/i386/kernel/smpboot.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 smpboot.c
--- linux-2.5.59-lch2/arch/i386/kernel/smpboot.c	17 Jan 2003 11:14:42 -0000	1.1.1.1
+++ linux-2.5.59-lch2/arch/i386/kernel/smpboot.c	3 Feb 2003 11:19:12 -0000
@@ -45,6 +45,8 @@
 
 #include <linux/delay.h>
 #include <linux/mc146818rtc.h>
+#include <linux/brlock.h>
+#include <linux/percpu.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include <asm/desc.h>
@@ -64,9 +66,10 @@
 /* Bitmask of currently online CPUs */
 unsigned long cpu_online_map;
 
-static volatile unsigned long cpu_callin_map;
+/* Initialize, although master cpu never calls in */
+static volatile unsigned long cpu_callin_map = 1;
 volatile unsigned long cpu_callout_map;
-static unsigned long smp_commenced_mask;
+static unsigned long smp_commenced_mask = 1;
 
 /* Per CPU bogomips and other parameters */
 struct cpuinfo_x86 cpu_data[NR_CPUS] __cacheline_aligned;
@@ -222,6 +225,8 @@
 	int buggy = 0;
 
 	printk("checking TSC synchronization across %u CPUs: ", num_booting_cpus());
+	if (fast_gettimeoffset_quotient == 0)
+		fast_gettimeoffset_quotient = 1<<30;
 
 	one_usec = ((1<<30)/fast_gettimeoffset_quotient)*(1<<2);
 
@@ -458,7 +463,9 @@
 	 * the local TLBs too.
 	 */
 	local_flush_tlb();
+	br_write_lock_irq(BR_CPU_LOCK);
 	set_bit(smp_processor_id(), &cpu_online_map);
+	br_write_unlock_irq(BR_CPU_LOCK);
 	wmb();
 	return cpu_idle();
 }
@@ -1138,10 +1145,11 @@
 	set_bit(smp_processor_id(), &cpu_callout_map);
 }
 
+DEFINE_PER_CPU(int, cpu_die) = { 0 };
+
 int __devinit __cpu_up(unsigned int cpu)
 {
-	/* This only works at boot for x86.  See "rewrite" above. */
-	if (test_bit(cpu, &smp_commenced_mask)) {
+	if (test_bit(cpu, &smp_commenced_mask) && cpu_online(cpu)) {
 		local_irq_enable();
 		return -ENOSYS;
 	}
@@ -1152,12 +1160,54 @@
 		return -EIO;
 	}
 
+	/* Already up, and in maybe_play_dead now? */
+	if (test_bit(cpu, &smp_commenced_mask)) {
+		per_cpu(cpu_die, cpu) = 0;
+		wmb();
+		wake_idle_cpu(cpu);
+		while (!cpu_online(cpu))
+			yield();
+		printk("Cpu %u says it's online\n", cpu);
+		return 0;
+	}
+
 	local_irq_enable();
 	/* Unleash the CPU! */
 	set_bit(cpu, &smp_commenced_mask);
 	while (!test_bit(cpu, &cpu_online_map))
 		mb();
 	return 0;
+}
+
+int __cpu_disable(void)
+{
+	br_write_lock_irq(BR_CPU_LOCK);
+  	cpu_online_map &= ~(1UL << smp_processor_id());
+	br_write_unlock_irq(BR_CPU_LOCK);
+
+	printk("Disabled cpu %u\n", smp_processor_id());
+	return 0;
+}
+
+void __cpu_die(unsigned int cpu)
+{
+	unsigned int start;
+
+	/* Final threads can take some time to actually clean up */
+	while (!idle_cpu(cpu))
+		yield();
+
+	/* FIXME: Rebind interrupts which have affinity. --RR */
+	per_cpu(cpu_die, cpu) = 1;
+	wmb();
+	for (start = jiffies; time_before(jiffies, start + HZ); ) {
+		wake_idle_cpu(cpu);
+		/* They ack this in maybe_play_dead by incrementing it. */
+		if (per_cpu(cpu_die, cpu) == 2)
+			return;
+		yield();
+	}
+	printk(KERN_ERR "CPU %u didn't die...\n", cpu);
 }
 
 void __init smp_cpus_done(unsigned int max_cpus)


