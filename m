Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267437AbUHDV14@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267437AbUHDV14 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 17:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267440AbUHDV14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 17:27:56 -0400
Received: from mx2.elte.hu ([157.181.151.9]:10448 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S267437AbUHDV0M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 17:26:12 -0400
Date: Wed, 4 Aug 2004 23:26:58 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Morton <akpm@osdl.org>, kernel@kolivas.org,
       linux-kernel@vger.kernel.org, Rick Lindsley <ricklind@us.ibm.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.8-rc2-mm2, schedstat-2.6.8-rc2-mm2-A4.patch
Message-ID: <20040804212658.GA26023@elte.hu>
References: <20040804122414.4f8649df.akpm@osdl.org> <211490000.1091648060@flay>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <211490000.1091648060@flay>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Martin J. Bligh <mbligh@aracnet.com> wrote:

> PS. schedstats is great for this kind of thing. Very useful, minimally
> invasive, no impact unless configed in, and nothing measurable even
> then. Hint. Hint ;-)

no objections from me. I like Nick's variant most:

 http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm1/broken-out/schedstats.patch

i have merged this patch to 2.6.8-rc2-mm2 (to be applied before the
staircase scheduler, attached as schedstat-2.6.8-rc2-mm2-A4.patch).

I fixed a number of cleanliness items, readying this patch for a
mainline merge:

 - added kernel/Kconfig.debug for generic debug options (such as 
   schedstat) and removed tons of debug options from various arch
   Kconfig's, instead of adding a boatload of new SCHEDSTAT entries. 
   This felt good.

 - removed sbc_pushed (there's no clone balancing anymore). This also 
   fixes the stats7.c parser at: 

      http://www.zip.com.au/~akpm/linux/patches/stuff/stats7.c

 - moved some definitions from sched.h to sched.c

 - style & whitespace police

tested it on x86.

is this patch fine with everyone? Rick, Nick?

	Ingo

--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="schedstat-2.6.8-rc2-mm2-A4.patch"

--- linux/arch/i386/Kconfig.orig	
+++ linux/arch/i386/Kconfig	
@@ -1196,14 +1196,9 @@ source "fs/Kconfig"
 
 source "arch/i386/oprofile/Kconfig"
 
-
 menu "Kernel hacking"
 
-config DEBUG_KERNEL
-	bool "Kernel debugging"
-	help
-	  Say Y here if you are developing drivers or trying to debug and
-	  identify kernel problems.
+source "kernel/Kconfig.debug"
 
 config EARLY_PRINTK
 	bool "Early printk" if EMBEDDED
@@ -1231,14 +1226,6 @@ config DEBUG_STACK_USAGE
 
 	  This option will slow down process creation somewhat.
 
-config DEBUG_SLAB
-	bool "Debug memory allocations"
-	depends on DEBUG_KERNEL
-	help
-	  Say Y here to have the kernel do limited verification on memory
-	  allocation as well as poisoning memory on free to catch use of freed
-	  memory.
-
 config MAGIC_SYSRQ
 	bool "Magic SysRq key"
 	depends on DEBUG_KERNEL
@@ -1253,23 +1240,6 @@ config MAGIC_SYSRQ
 	  keys are documented in <file:Documentation/sysrq.txt>. Don't say Y
 	  unless you really know what this hack does.
 
-config DEBUG_SPINLOCK
-	bool "Spinlock debugging"
-	depends on DEBUG_KERNEL
-	help
-	  Say Y here and build SMP to catch missing spinlock initialization
-	  and certain other kinds of spinlock errors commonly made.  This is
-	  best used in conjunction with the NMI watchdog so that spinlock
-	  deadlocks are also debuggable.
-
-config DEBUG_PAGEALLOC
-	bool "Page alloc debugging"
-	depends on DEBUG_KERNEL
-	help
-	  Unmap pages from the kernel linear mapping after free_pages().
-	  This results in a large slowdown, but helps to find certain types
-	  of memory corruptions.
-
 config DEBUG_HIGHMEM
 	bool "Highmem debugging"
 	depends on DEBUG_KERNEL && HIGHMEM
@@ -1277,28 +1247,6 @@ config DEBUG_HIGHMEM
 	  This options enables addition error checking for high memory systems.
 	  Disable for production systems.
 
-config DEBUG_INFO
-	bool "Compile the kernel with debug info"
-	depends on DEBUG_KERNEL
-	help
-          If you say Y here the resulting kernel image will include
-	  debugging info resulting in a larger kernel image.
-	  Say Y here only if you plan to use gdb to debug the kernel.
-	  If you don't debug the kernel, you can say N.
-	  
-config LOCKMETER
-	bool "Kernel lock metering"
-	depends on SMP
-	help
-	  Say Y to enable kernel lock metering, which adds overhead to SMP locks,
-	  but allows you to see various statistics using the lockstat command.
-
-config DEBUG_SPINLOCK_SLEEP
-	bool "Sleep-inside-spinlock checking"
-	help
-	  If you say Y here, various routines which may sleep will become very
-	  noisy if they are called with a spinlock held.	
-
 config KGDB
 	bool "Include kgdb kernel debugger"
 	depends on DEBUG_KERNEL
--- linux/arch/ppc/Kconfig.orig	
+++ linux/arch/ppc/Kconfig	
@@ -1265,12 +1265,7 @@ source "arch/ppc/oprofile/Kconfig"
 
 menu "Kernel hacking"
 
-config DEBUG_KERNEL
-	bool "Kernel debugging"
-
-config DEBUG_SLAB
-	bool "Debug memory allocations"
-	depends on DEBUG_KERNEL
+source "kernel/Kconfig.debug"
 
 config MAGIC_SYSRQ
 	bool "Magic SysRq key"
@@ -1286,13 +1281,6 @@ config MAGIC_SYSRQ
 	  keys are documented in <file:Documentation/sysrq.txt>. Don't say Y
 	  unless you really know what this hack does.
 
-config DEBUG_SPINLOCK
-	bool "Spinlock debugging"
-	depends on DEBUG_KERNEL
-	help
-	  Say Y here and to CONFIG_SMP to include code to check for missing
-	  spinlock initialization and some other common spinlock errors.
-
 config DEBUG_HIGHMEM
 	bool "Highmem debugging"
 	depends on DEBUG_KERNEL && HIGHMEM
@@ -1300,13 +1288,6 @@ config DEBUG_HIGHMEM
 	  This options enables additional error checking for high memory
 	  systems.  Disable for production systems.
 
-config DEBUG_SPINLOCK_SLEEP
-	bool "Sleep-inside-spinlock checking"
-	depends on DEBUG_KERNEL
-	help
-	  If you say Y here, various routines which may sleep will become very
-	  noisy if they are called with a spinlock held.
-
 config KGDB
 	bool "Include kgdb kernel debugger"
 	depends on DEBUG_KERNEL && (BROKEN || PPC_GEN550 || 4xx)
@@ -1358,16 +1339,6 @@ config BDI_SWITCH
 	  Unless you are intending to debug the kernel with one of these
 	  machines, say N here.
 
-config DEBUG_INFO
-	bool "Compile the kernel with debug info"
-	depends on DEBUG_KERNEL
-	help
-          If you say Y here the resulting kernel image will include
-	  debugging info resulting in a larger kernel image.
-	  Say Y here only if you plan to use some sort of debugger to
-	  debug the kernel.
-	  If you don't debug the kernel, you can say N.
-
 config BOOTX_TEXT
 	bool "Support for early boot text console (BootX or OpenFirmware only)"
 	depends PPC_OF
--- linux/arch/ia64/Kconfig.orig	
+++ linux/arch/ia64/Kconfig	
@@ -596,11 +596,7 @@ config IA64_GRANULE_64MB
 
 endchoice
 
-config DEBUG_KERNEL
-	bool "Kernel debugging"
-	help
-	  Say Y here if you are developing drivers or trying to debug and
-	  identify kernel problems.
+source "arch/i386/oprofile/Kconfig"
 
 config IA64_PRINT_HAZARDS
 	bool "Print possible IA-64 dependency violations to console"
@@ -635,29 +631,6 @@ config MAGIC_SYSRQ
 	  keys are documented in <file:Documentation/sysrq.txt>. Don't say Y
 	  unless you really know what this hack does.
 
-config DEBUG_SLAB
-	bool "Debug memory allocations"
-	depends on DEBUG_KERNEL
-	help
-	  Say Y here to have the kernel do limited verification on memory
-	  allocation as well as poisoning memory on free to catch use of freed
-	  memory.
-
-config DEBUG_SPINLOCK
-	bool "Spinlock debugging"
-	depends on DEBUG_KERNEL
-	help
-	  Say Y here and build SMP to catch missing spinlock initialization
-	  and certain other kinds of spinlock errors commonly made.  This is
-	  best used in conjunction with the NMI watchdog so that spinlock
-	  deadlocks are also debuggable.
-
-config DEBUG_SPINLOCK_SLEEP
-	  bool "Sleep-inside-spinlock checking"
-	  help
-	    If you say Y here, various routines which may sleep will become very
-	    noisy if they are called with a spinlock held.
-
 config IA64_DEBUG_CMPXCHG
 	bool "Turn on compare-and-exchange bug checking (slow!)"
 	depends on DEBUG_KERNEL
@@ -675,22 +648,6 @@ config IA64_DEBUG_IRQ
 	  and restore instructions.  It's useful for tracking down spinlock
 	  problems, but slow!  If you're unsure, select N.
 
-config DEBUG_INFO
-	bool "Compile the kernel with debug info"
-	depends on DEBUG_KERNEL
-	help
-          If you say Y here the resulting kernel image will include
-	  debugging info resulting in a larger kernel image.
-	  Say Y here only if you plan to use gdb to debug the kernel.
-	  If you don't debug the kernel, you can say N.
-
-config LOCKMETER
-       bool "Kernel lock metering"
-       depends on SMP
-       help
-         Say Y to enable kernel lock metering, which adds overhead to SMP locks,
-         but allows you to see various statistics using the lockstat command.
-
 config SYSVIPC_COMPAT
 	bool
 	depends on COMPAT && SYSVIPC
--- linux/arch/ppc64/Kconfig.orig	
+++ linux/arch/ppc64/Kconfig	
@@ -345,11 +345,7 @@ source "arch/ppc64/oprofile/Kconfig"
 
 menu "Kernel hacking"
 
-config DEBUG_KERNEL
-	bool "Kernel debugging"
-	help
-	  Say Y here if you are developing drivers or trying to debug and
-	  identify kernel problems.
+source "kernel/Kconfig.debug"
 
 config DEBUG_STACKOVERFLOW
 	bool "Check for stack overflows"
@@ -364,14 +360,6 @@ config DEBUG_STACK_USAGE
 
 	  This option will slow down process creation somewhat.
 
-config DEBUG_SLAB
-	bool "Debug memory allocations"
-	depends on DEBUG_KERNEL
-	help
-	  Say Y here to have the kernel do limited verification on memory
-	  allocation as well as poisoning memory on free to catch use of freed
-	  memory.
-
 config MAGIC_SYSRQ
 	bool "Magic SysRq key"
 	depends on DEBUG_KERNEL
@@ -408,15 +396,6 @@ config PPCDBG
 	bool "Include PPCDBG realtime debugging"
 	depends on DEBUG_KERNEL
 
-config DEBUG_INFO
-	bool "Compile the kernel with debug info"
-	depends on DEBUG_KERNEL
-	help
-          If you say Y here the resulting kernel image will include
-	  debugging info resulting in a larger kernel image.
-	  Say Y here only if you plan to use gdb to debug the kernel.
-	  If you don't debug the kernel, you can say N.
-
 config IRQSTACKS
 	bool "Use separate kernel stacks when processing interrupts"
 	help
@@ -424,8 +403,6 @@ config IRQSTACKS
 	  for handling hard and soft interrupts.  This can help avoid
 	  overflowing the process kernel stacks.
 	  
-endmenu
-
 config SPINLINE
 	bool "Inline spinlock code at each call site"
 	depends on SMP && !PPC_SPLPAR && !PPC_ISERIES
@@ -436,6 +413,8 @@ config SPINLINE
 
 	  If in doubt, say N.
 
+endmenu
+
 source "security/Kconfig"
 
 source "crypto/Kconfig"
--- linux/arch/x86_64/Kconfig.orig	
+++ linux/arch/x86_64/Kconfig	
@@ -402,19 +402,7 @@ source "arch/x86_64/oprofile/Kconfig"
 
 menu "Kernel hacking"
 
-config DEBUG_KERNEL
-	bool "Kernel debugging"
-	help
-	  Say Y here if you are developing drivers or trying to debug and
-	  identify kernel problems.
-
-config DEBUG_SLAB
-	bool "Debug memory allocations"
-	depends on DEBUG_KERNEL
-	help
-	  Say Y here to have the kernel do limited verification on memory
-	  allocation as well as poisoning memory on free to catch use of freed
-	  memory.
+source "kernel/Kconfig.debug"
 
 config MAGIC_SYSRQ
 	bool "Magic SysRq key"
@@ -429,15 +417,6 @@ config MAGIC_SYSRQ
 	  keys are documented in <file:Documentation/sysrq.txt>. Don't say Y
 	  unless you really know what this hack does.
 
-config DEBUG_SPINLOCK
-	bool "Spinlock debugging"
-	depends on DEBUG_KERNEL
-	help
-	  Say Y here and build SMP to catch missing spinlock initialization
-	  and certain other kinds of spinlock errors commonly made.  This is
-	  best used in conjunction with the NMI watchdog so that spinlock
-	  deadlocks are also debuggable.
-
 # !SMP for now because the context switch early causes GPF in segment reloading
 # and the GS base checking does the wrong thing then, causing a hang.
 config CHECKING
@@ -454,17 +433,6 @@ config INIT_DEBUG
 	  Fill __init and __initdata at the end of boot. This helps debugging
 	  illegal uses of __init and __initdata after initialization.	  
 
-config DEBUG_INFO
-	bool "Compile the kernel with debug info"
-	depends on DEBUG_KERNEL
-	default n
-	help
-          If you say Y here the resulting kernel image will include
-	  debugging info resulting in a larger kernel image.
-	  Say Y here only if you plan to use gdb to debug the kernel.
-	  Please note that this option requires new binutils.
-	  If you don't debug the kernel, you can say N.
-	  
 config FRAME_POINTER
        bool "Compile the kernel with frame pointers"
        help
--- linux/include/linux/sched.h.orig	
+++ linux/include/linux/sched.h	
@@ -632,6 +632,32 @@ struct sched_domain {
 	unsigned long last_balance;	/* init to jiffies. units in jiffies */
 	unsigned int balance_interval;	/* initialise to 1. units in ms. */
 	unsigned int nr_balance_failed; /* initialise to 0 */
+
+#ifdef CONFIG_SCHEDSTATS
+	unsigned long lb_cnt[3];
+	unsigned long lb_balanced[3];
+	unsigned long lb_failed[3];
+	unsigned long lb_pulled[3];
+	unsigned long lb_hot_pulled[3];
+	unsigned long lb_imbalance[3];
+
+	/* Active load balancing */
+	unsigned long alb_cnt;
+	unsigned long alb_failed;
+	unsigned long alb_pushed;
+
+	/* Wakeups */
+	unsigned long sched_wake_remote;
+
+	/* Passive load balancing */
+	unsigned long plb_pulled;
+
+	/* Affine wakeups */
+	unsigned long afw_pulled;
+
+	/* SD_BALANCE_EXEC balances */
+	unsigned long sbe_pushed;
+#endif
 };
 
 #ifndef ARCH_HAS_SCHED_TUNE
--- linux/fs/proc/proc_misc.c.orig	
+++ linux/fs/proc/proc_misc.c	
@@ -282,6 +282,10 @@ static struct file_operations proc_vmsta
 	.release	= seq_release,
 };
 
+#ifdef CONFIG_SCHEDSTATS
+extern struct file_operations proc_schedstat_operations;
+#endif
+
 #ifdef CONFIG_PROC_HARDWARE
 static int hardware_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
@@ -711,6 +715,9 @@ void __init proc_misc_init(void)
 #ifdef CONFIG_MODULES
 	create_seq_entry("modules", 0, &proc_modules_operations);
 #endif
+#ifdef CONFIG_SCHEDSTATS
+	create_seq_entry("schedstat", 0, &proc_schedstat_operations);
+#endif
 #ifdef CONFIG_PROC_KCORE
 	proc_root_kcore = create_proc_entry("kcore", S_IRUSR, NULL);
 	if (proc_root_kcore) {
--- linux/kernel/sched.c.orig	
+++ linux/kernel/sched.c	
@@ -41,6 +41,8 @@
 #include <linux/percpu.h>
 #include <linux/perfctr.h>
 #include <linux/kthread.h>
+#include <linux/seq_file.h>
+#include <linux/times.h>
 #include <asm/tlb.h>
 
 #include <asm/unistd.h>
@@ -234,6 +236,22 @@ struct runqueue {
 	task_t *migration_thread;
 	struct list_head migration_queue;
 #endif
+#ifdef CONFIG_SCHEDSTATS
+	/* sys_sched_yield stats */
+	unsigned long yld_exp_empty;
+	unsigned long yld_act_empty;
+	unsigned long yld_both_empty;
+	unsigned long yld_cnt;
+
+	/* schedule stats */
+	unsigned long sched_cnt;
+	unsigned long sched_switch;
+	unsigned long sched_idle;
+
+	/* wake stats */
+	unsigned long sched_wake;
+	unsigned long sched_wake_local;
+#endif
 };
 
 static DEFINE_PER_CPU(struct runqueue, runqueues);
@@ -280,6 +298,97 @@ static inline void task_rq_unlock(runque
 	spin_unlock_irqrestore(&rq->lock, *flags);
 }
 
+
+#ifdef CONFIG_SCHEDSTATS
+
+/*
+ * bump this up when changing the output format or the meaning of an existing
+ * format, so that tools can adapt (or abort)
+ */
+#define SCHEDSTAT_VERSION	7
+
+static int show_schedstat(struct seq_file *seq, void *v)
+{
+	int i;
+
+	seq_printf(seq, "version %d\n", SCHEDSTAT_VERSION);
+	seq_printf(seq, "timestamp %lu\n", jiffies);
+	for_each_cpu(i) {
+		/* Include offline CPUs */
+		runqueue_t *rq = cpu_rq(i);
+#ifdef CONFIG_SMP
+		struct sched_domain *sd;
+		int j = 0;
+#endif
+
+		seq_printf(seq,
+		    "cpu%d %lu %lu %lu %lu %lu %lu %lu %lu %lu",
+		    i,
+		    rq->yld_both_empty, rq->yld_act_empty,
+		    rq->yld_exp_empty, rq->yld_cnt,
+		    rq->sched_switch, rq->sched_cnt,
+		    rq->sched_idle, rq->sched_wake, rq->sched_wake_local);
+#ifdef CONFIG_SMP
+		for_each_domain(i, sd) {
+			char str[NR_CPUS];
+			int k;
+			cpumask_scnprintf(str, NR_CPUS, sd->span);
+			seq_printf(seq, " domain%d %s", j++, str);
+
+			for (k = 0; k < 3; k++) {
+				seq_printf(seq, " %lu %lu %lu %lu %lu %lu",
+				    sd->lb_cnt[k], sd->lb_balanced[k],
+				    sd->lb_failed[k], sd->lb_pulled[k],
+				    sd->lb_hot_pulled[k], sd->lb_imbalance[k]);
+			}
+
+			seq_printf(seq, " %lu %lu %lu %lu %lu %lu %lu",
+			    sd->alb_cnt, sd->alb_failed,
+			    sd->alb_pushed, sd->sched_wake_remote,
+			    sd->plb_pulled, sd->afw_pulled,
+			    sd->sbe_pushed);
+		}
+#endif
+
+		seq_printf(seq, "\n");
+	}
+
+	return 0;
+}
+
+static int schedstat_open(struct inode *inode, struct file *file)
+{
+	unsigned size = 4096 * (1 + num_online_cpus() / 32);
+	char *buf = kmalloc(size, GFP_KERNEL);
+	struct seq_file *m;
+	int res;
+
+	if (!buf)
+		return -ENOMEM;
+	res = single_open(file, show_schedstat, NULL);
+	if (!res) {
+		m = file->private_data;
+		m->buf = buf;
+		m->size = size;
+	} else
+		kfree(buf);
+	return res;
+}
+
+struct file_operations proc_schedstat_operations = {
+	.open    = schedstat_open,
+	.read    = seq_read,
+	.llseek  = seq_lseek,
+	.release = single_release,
+};
+
+# define schedstat_inc(s, field)	((s)->field++)
+# define schedstat_add(s, field, amt)	((s)->field += (amt))
+#else
+# define schedstat_inc(s, field)	do { } while (0)
+# define schedstat_add(d, field, amt)	do { } while (0)
+#endif
+
 /*
  * rq_lock - lock a given runqueue and disable interrupts.
  */
@@ -751,7 +860,24 @@ static int try_to_wake_up(task_t * p, un
 	cpu = task_cpu(p);
 	this_cpu = smp_processor_id();
 
+	schedstat_inc(rq, sched_wake);
+#ifndef CONFIG_SMP
+	schedstat_inc(rq, sched_wake_local);
+#endif
+
 #ifdef CONFIG_SMP
+#ifdef CONFIG_SCHEDSTATS
+	if (cpu == this_cpu)
+		schedstat_inc(rq, sched_wake_local);
+	else {
+		for_each_domain(this_cpu, sd)
+			if (cpu_isset(cpu, sd->span))
+				break;
+		if (sd)
+			schedstat_inc(sd, sched_wake_remote);
+	}
+#endif
+
 	if (unlikely(task_running(rq, p)))
 		goto out_activate;
 
@@ -796,8 +922,17 @@ static int try_to_wake_up(task_t * p, un
 			 * Now sd has SD_WAKE_AFFINE and p is cache cold in sd
 			 * or sd has SD_WAKE_BALANCE and there is an imbalance
 			 */
-			if (cpu_isset(cpu, sd->span))
+			if (cpu_isset(cpu, sd->span)) {
+#ifdef CONFIG_SCHEDSTATS
+				if ((sd->flags & SD_WAKE_AFFINE) &&
+				     !task_hot(p, rq->timestamp_last_tick, sd))
+					schedstat_inc(sd, afw_pulled);
+				else if ((sd->flags & SD_WAKE_BALANCE) &&
+					  imbalance*this_load <= 100*load)
+					schedstat_inc(sd, plb_pulled);
+#endif
 				goto out_set_cpu;
+			}
 		}
 	}
 
@@ -1321,6 +1456,7 @@ void sched_exec(void)
 	if (sd) {
 		new_cpu = find_idlest_cpu(current, this_cpu, sd);
 		if (new_cpu != this_cpu) {
+			schedstat_inc(sd, sbe_pushed);
 			put_cpu();
 			sched_migrate_task(current, new_cpu);
 			return;
@@ -1378,6 +1514,13 @@ int can_migrate_task(task_t *p, runqueue
 			return 0;
 	}
 
+#ifdef CONFIG_SCHEDSTATS
+	if (!task_hot(p, rq->timestamp_last_tick, sd))
+		schedstat_inc(sd, lb_pulled[idle]);
+	else
+		schedstat_inc(sd, lb_hot_pulled[idle]);
+#endif
+
 	return 1;
 }
 
@@ -1638,14 +1781,20 @@ static int load_balance(int this_cpu, ru
 	int nr_moved;
 
 	spin_lock(&this_rq->lock);
+	schedstat_inc(sd, lb_cnt[idle]);
 
 	group = find_busiest_group(sd, this_cpu, &imbalance, idle);
-	if (!group)
+	if (!group) {
+		schedstat_inc(sd, lb_balanced[idle]);
 		goto out_balanced;
+	}
 
 	busiest = find_busiest_queue(group);
-	if (!busiest)
+	if (!busiest) {
+		schedstat_inc(sd, lb_balanced[idle]);
 		goto out_balanced;
+	}
+
 	/*
 	 * This should be "impossible", but since load
 	 * balancing is inherently racy and statistical,
@@ -1655,6 +1804,7 @@ static int load_balance(int this_cpu, ru
 		WARN_ON(1);
 		goto out_balanced;
 	}
+	schedstat_add(sd, lb_imbalance[idle], imbalance);
 
 	nr_moved = 0;
 	if (busiest->nr_running > 1) {
@@ -1672,6 +1822,7 @@ static int load_balance(int this_cpu, ru
 	spin_unlock(&this_rq->lock);
 
 	if (!nr_moved) {
+		schedstat_inc(sd, lb_failed[idle]);
 		sd->nr_balance_failed++;
 
 		if (unlikely(sd->nr_balance_failed > sd->cache_nice_tries+2)) {
@@ -1726,13 +1877,20 @@ static int load_balance_newidle(int this
 	unsigned long imbalance;
 	int nr_moved = 0;
 
+	schedstat_inc(sd, lb_cnt[NEWLY_IDLE]);
 	group = find_busiest_group(sd, this_cpu, &imbalance, NEWLY_IDLE);
-	if (!group)
+	if (!group) {
+		schedstat_inc(sd, lb_balanced[NEWLY_IDLE]);
 		goto out;
+	}
 
 	busiest = find_busiest_queue(group);
-	if (!busiest || busiest == this_rq)
+	if (!busiest || busiest == this_rq) {
+		schedstat_inc(sd, lb_balanced[NEWLY_IDLE]);
 		goto out;
+	}
+
+	schedstat_add(sd, lb_imbalance[NEWLY_IDLE], imbalance);
 
 	/* Attempt to move tasks */
 	double_lock_balance(this_rq, busiest);
@@ -1777,6 +1935,7 @@ static void active_load_balance(runqueue
 	struct sched_domain *sd;
 	struct sched_group *group, *busy_group;
 	int i;
+	int moved = 0;
 
 	if (busiest->nr_running <= 1)
 		return;
@@ -1788,6 +1947,7 @@ static void active_load_balance(runqueue
 		WARN_ON(1);
 		return;
 	}
+	schedstat_inc(sd, alb_cnt);
 
  	group = sd->groups;
 	while (!cpu_isset(busiest_cpu, group->cpumask))
@@ -1824,11 +1984,16 @@ static void active_load_balance(runqueue
 		if (unlikely(busiest == rq))
 			goto next_group;
 		double_lock_balance(busiest, rq);
-		move_tasks(rq, push_cpu, busiest, 1, sd, IDLE);
+		moved += move_tasks(rq, push_cpu, busiest, 1, sd, IDLE);
 		spin_unlock(&rq->lock);
 next_group:
 		group = group->next;
 	} while (group != sd->groups);
+
+	if (moved)
+		schedstat_add(sd, alb_pushed, moved);
+	else
+		schedstat_inc(sd, alb_failed);
 }
 
 /*
@@ -2181,6 +2346,7 @@ need_resched:
 	}
 
 	release_kernel_lock(prev);
+	schedstat_inc(rq, sched_cnt);
 	now = sched_clock();
 	if (likely(now - prev->timestamp < NS_MAX_SLEEP_AVG))
 		run_time = now - prev->timestamp;
@@ -2218,6 +2384,7 @@ need_resched:
 			next = rq->idle;
 			rq->expired_timestamp = 0;
 			wake_sleeping_dependent(cpu, rq);
+			schedstat_inc(rq, sched_idle);
 			goto switch_tasks;
 		}
 	}
@@ -2227,6 +2394,7 @@ need_resched:
 		/*
 		 * Switch the active and expired arrays.
 		 */
+		schedstat_inc(rq, sched_switch);
 		rq->active = rq->expired;
 		rq->expired = array;
 		array = rq->active;
@@ -2986,6 +3154,7 @@ asmlinkage long sys_sched_yield(void)
 	prio_array_t *array = current->array;
 	prio_array_t *target = rq->expired;
 
+	schedstat_inc(rq, yld_cnt);
 	/*
 	 * We implement yielding by moving the task into the expired
 	 * queue.
--- linux/kernel/Kconfig.debug.orig	
+++ linux/kernel/Kconfig.debug	
@@ -0,0 +1,71 @@
+#
+# Kernel debug configuration - the generic bits
+#
+
+config DEBUG_KERNEL
+	bool "Kernel debugging"
+	help
+	  Say Y here if you are developing drivers or trying to debug and
+	  identify kernel problems.
+
+config DEBUG_SLAB
+	bool "Debug memory allocations"
+	depends on DEBUG_KERNEL
+	help
+	  Say Y here to have the kernel do limited verification on memory
+	  allocation as well as poisoning memory on free to catch use of freed
+	  memory.
+
+config DEBUG_SPINLOCK
+	bool "Spinlock debugging"
+	depends on DEBUG_KERNEL
+	help
+	  Say Y here and build SMP to catch missing spinlock initialization
+	  and certain other kinds of spinlock errors commonly made.  This is
+	  best used in conjunction with the NMI watchdog so that spinlock
+	  deadlocks are also debuggable.
+
+config DEBUG_SPINLOCK_SLEEP
+	bool "Sleep-inside-spinlock checking"
+	depends on DEBUG_KERNEL && SMP
+	help
+	  If you say Y here, various routines which may sleep will become very
+	  noisy if they are called with a spinlock held.	
+
+config DEBUG_PAGEALLOC
+	bool "Page alloc debugging"
+	depends on DEBUG_KERNEL
+	help
+	  Unmap pages from the kernel linear mapping after free_pages().
+	  This results in a large slowdown, but helps to find certain types
+	  of memory corruptions.
+
+config DEBUG_INFO
+	bool "Compile the kernel with debug info"
+	depends on DEBUG_KERNEL
+	help
+          If you say Y here the resulting kernel image will include
+	  debugging info resulting in a larger kernel image.
+	  Say Y here only if you plan to use gdb to debug the kernel.
+	  If you don't debug the kernel, you can say N.
+
+config LOCKMETER
+	bool "Kernel lock metering"
+	depends on DEBUG_KERNEL && SMP
+	help
+	  Say Y to enable kernel lock metering, which adds overhead to SMP locks,
+	  but allows you to see various statistics using the lockstat command.
+
+config SCHEDSTATS
+	bool "Collect scheduler statistics"
+	depends on DEBUG_KERNEL && PROC_FS
+	default n
+	help
+	  If you say Y here, additional code will be inserted into the
+	  scheduler and related routines to collect statistics about
+	  scheduler behavior and provide them in /proc/schedstat.  These
+	  stats may be useful for both tuning and debugging the scheduler
+	  If you aren't debugging the scheduler or trying to tune a specific
+	  application, you can say N to avoid the very slight overhead
+	  this adds.
+

--Qxx1br4bt0+wmkIi--
