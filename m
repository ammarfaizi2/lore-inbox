Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262187AbSJJTyO>; Thu, 10 Oct 2002 15:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262193AbSJJTyO>; Thu, 10 Oct 2002 15:54:14 -0400
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:12110 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id <S262187AbSJJTuX>; Thu, 10 Oct 2002 15:50:23 -0400
Date: Thu, 10 Oct 2002 13:04:29 -0700
From: "Matt D. Robinson" <yakker@aparity.com>
Message-Id: <200210102004.g9AK4TO29581@nakedeye.aparity.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com, yakker@aparity.com
Subject: [PATCH] 2.5.41: lkcd (6/8): dump trace/dump calls/dump_in_progress
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

General modifications in the kernel to allow for dumping to
take place without causing system hangs or other anomalies
(like jobs being scheduled while a dump is taking place).
Also included are additional fields for matching /dev/mem
entries to a System.map file, and the addition of dump_init()
to start the driver if it is compiled directly into the
kernel (as opposed to a module).  Most of the changes are for
dealing with exported symbols.


 arch/i386/kernel/Makefile |    2 +-
 arch/i386/kernel/irq.c    |    3 +++
 arch/i386/kernel/nmi.c    |    8 ++++++++
 arch/i386/kernel/traps.c  |   25 ++++++++++++++++++++++++-
 arch/i386/mm/Makefile     |    2 +-
 arch/i386/mm/init.c       |    5 ++++-
 init/main.c               |   10 ++++++++++
 kernel/Makefile           |    2 +-
 kernel/panic.c            |   18 ++++++++++++++++++
 kernel/sched.c            |   32 ++++++++++++++++++++++++++++++++
 10 files changed, 102 insertions(+), 5 deletions(-)


diff -urN -X /home/bharata/dontdiff linux-2.5.41/arch/i386/kernel/Makefile linux-2.5.41+lkcd/arch/i386/kernel/Makefile
--- linux-2.5.41/arch/i386/kernel/Makefile	Mon Oct  7 23:53:33 2002
+++ linux-2.5.41+lkcd/arch/i386/kernel/Makefile	Tue Oct  8 13:05:59 2002
@@ -4,7 +4,7 @@
 
 EXTRA_TARGETS := head.o init_task.o
 
-export-objs     := mca.o i386_ksyms.o time.o
+export-objs     := irq.o traps.o mca.o i386_ksyms.o time.o smp.o
 
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o vm86.o \
 		ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_i386.o \
diff -urN -X /home/bharata/dontdiff linux-2.5.41/arch/i386/kernel/irq.c linux-2.5.41+lkcd/arch/i386/kernel/irq.c
--- linux-2.5.41/arch/i386/kernel/irq.c	Mon Oct  7 23:53:24 2002
+++ linux-2.5.41+lkcd/arch/i386/kernel/irq.c	Tue Oct  8 13:05:59 2002
@@ -32,6 +32,7 @@
 #include <linux/irq.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
+#include <linux/module.h>
 
 #include <asm/atomic.h>
 #include <asm/io.h>
@@ -943,3 +944,5 @@
 		register_irq_proc(i);
 }
 
+EXPORT_SYMBOL(irq_desc);
+EXPORT_SYMBOL(irq_affinity);
diff -urN -X /home/bharata/dontdiff linux-2.5.41/arch/i386/kernel/nmi.c linux-2.5.41+lkcd/arch/i386/kernel/nmi.c
--- linux-2.5.41/arch/i386/kernel/nmi.c	Mon Oct  7 23:54:38 2002
+++ linux-2.5.41+lkcd/arch/i386/kernel/nmi.c	Tue Oct  8 13:05:59 2002
@@ -20,6 +20,7 @@
 #include <linux/interrupt.h>
 #include <linux/mc146818rtc.h>
 #include <linux/kernel_stat.h>
+#include <linux/dump.h>
 
 #include <asm/smp.h>
 #include <asm/mtrr.h>
@@ -348,6 +349,12 @@
 	 */
 	int sum, cpu = smp_processor_id();
 
+	/*
+	 * Ignore watchdog when dumping is in progress.
+	 * Todo: consider using the touch_nmi_watchdog() approach instead
+	 */
+	if (dump_in_progress && cpu != dumping_cpu) return;
+
 	sum = apic_timer_irqs[cpu];
 
 	if (last_irq_sums[cpu] == sum) {
@@ -366,6 +373,7 @@
 			printk("NMI Watchdog detected LOCKUP on CPU%d, eip %08lx, registers:\n", cpu, regs->eip);
 			show_registers(regs);
 			printk("console shuts up ...\n");
+			dump("NMI Watchdog Detected", regs);
 			console_silent();
 			spin_unlock(&nmi_print_lock);
 			bust_spinlocks(0);
diff -urN -X /home/bharata/dontdiff linux-2.5.41/arch/i386/kernel/traps.c linux-2.5.41+lkcd/arch/i386/kernel/traps.c
--- linux-2.5.41/arch/i386/kernel/traps.c	Mon Oct  7 23:53:33 2002
+++ linux-2.5.41+lkcd/arch/i386/kernel/traps.c	Tue Oct  8 13:29:36 2002
@@ -23,6 +23,7 @@
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
 #include <linux/highmem.h>
+#include <linux/dump.h>
 
 #ifdef CONFIG_EISA
 #include <linux/ioport.h>
@@ -85,7 +86,6 @@
 
 static int kstack_depth_to_print = 24;
 
-
 /*
  * If the address is either in the .text section of the
  * kernel, or in the vmalloc'ed module regions, it *may* 
@@ -294,6 +294,7 @@
 	handle_BUG(regs);
 	printk("%s: %04lx\n", str, err & 0xffff);
 	show_registers(regs);
+	dump((char *)str, regs);
 	bust_spinlocks(0);
 	spin_unlock_irq(&die_lock);
 	do_exit(SIGSEGV);
@@ -468,6 +469,23 @@
 	outb(reason, 0x61);
 }
 
+#ifdef CONFIG_SMP
+int (*dump_ipi_function_ptr)(struct pt_regs *) = NULL;
+int dump_ipi(struct pt_regs *regs)
+{
+	if (!(dump_ipi_function_ptr && dump_ipi_function_ptr(regs))) {
+		return 0;
+	}
+	ack_APIC_irq();
+	return 1;
+}
+#else
+int dump_ipi(struct pt_regs *regs)
+{
+	return 0;
+}
+#endif
+
 static void unknown_nmi_error(unsigned char reason, struct pt_regs * regs)
 {
 #ifdef CONFIG_MCA
@@ -488,6 +506,9 @@
 	unsigned char reason = inb(0x61);
 
 	++nmi_count(smp_processor_id());
+        if (dump_ipi(regs)) {
+                return;
+        }
 
 	if (!(reason & 0xc0)) {
 #if CONFIG_X86_LOCAL_APIC
@@ -898,3 +919,5 @@
 
 	trap_init_hook();
 }
+
+EXPORT_SYMBOL(dump_ipi_function_ptr);
diff -urN -X /home/bharata/dontdiff linux-2.5.41/arch/i386/mm/Makefile linux-2.5.41+lkcd/arch/i386/mm/Makefile
--- linux-2.5.41/arch/i386/mm/Makefile	Mon Oct  7 23:53:38 2002
+++ linux-2.5.41+lkcd/arch/i386/mm/Makefile	Tue Oct  8 13:05:59 2002
@@ -2,7 +2,7 @@
 # Makefile for the linux i386-specific parts of the memory manager.
 #
 
-export-objs := pageattr.o
+export-objs := pageattr.o init.o
 
 obj-y	:= init.o pgtable.o fault.o ioremap.o extable.o pageattr.o 
 obj-$(CONFIG_DISCONTIGMEM)	+= discontig.o
diff -urN -X /home/bharata/dontdiff linux-2.5.41/arch/i386/mm/init.c linux-2.5.41+lkcd/arch/i386/mm/init.c
--- linux-2.5.41/arch/i386/mm/init.c	Mon Oct  7 23:53:35 2002
+++ linux-2.5.41+lkcd/arch/i386/mm/init.c	Tue Oct  8 13:05:59 2002
@@ -19,6 +19,7 @@
 #include <linux/swap.h>
 #include <linux/smp.h>
 #include <linux/init.h>
+#include <linux/module.h>
 #ifdef CONFIG_BLK_DEV_INITRD
 #include <linux/blk.h>
 #endif
@@ -157,7 +158,7 @@
 	return 0;
 }
 
-static inline int page_is_ram(unsigned long pagenr)
+int page_is_ram (unsigned long pagenr)
 {
 	int i;
 
@@ -589,3 +590,5 @@
 	}
 }
 #endif
+
+EXPORT_SYMBOL(page_is_ram);
diff -urN -X /home/bharata/dontdiff linux-2.5.41/init/main.c linux-2.5.41+lkcd/init/main.c
--- linux-2.5.41/init/main.c	Mon Oct  7 23:53:33 2002
+++ linux-2.5.41+lkcd/init/main.c	Tue Oct  8 13:05:59 2002
@@ -87,6 +87,16 @@
 int system_running = 0;
 
 /*
+ * The kernel_magic value represents the address of _end, which allows
+ * namelist tools to "match" each other respectively.  That way a tool
+ * that looks at /dev/mem can verify that it is using the right System.map
+ * file -- if kernel_magic doesn't equal the namelist value of _end,
+ * something's wrong.
+ */
+extern unsigned long _end;
+unsigned long *kernel_magic = &_end;
+
+/*
  * Boot command-line arguments
  */
 #define MAX_INIT_ARGS 8
diff -urN -X /home/bharata/dontdiff linux-2.5.41/kernel/Makefile linux-2.5.41+lkcd/kernel/Makefile
--- linux-2.5.41/kernel/Makefile	Mon Oct  7 23:53:34 2002
+++ linux-2.5.41+lkcd/kernel/Makefile	Tue Oct  8 13:05:59 2002
@@ -3,7 +3,7 @@
 #
 
 export-objs = signal.o sys.o kmod.o workqueue.o ksyms.o pm.o exec_domain.o \
-	      printk.o platform.o suspend.o dma.o module.o cpufreq.o
+	      printk.o platform.o suspend.o dma.o module.o cpufreq.o panic.o
 
 obj-y     = sched.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o time.o softirq.o resource.o \
diff -urN -X /home/bharata/dontdiff linux-2.5.41/kernel/panic.c linux-2.5.41+lkcd/kernel/panic.c
--- linux-2.5.41/kernel/panic.c	Mon Oct  7 23:55:17 2002
+++ linux-2.5.41+lkcd/kernel/panic.c	Tue Oct  8 13:05:59 2002
@@ -16,10 +16,16 @@
 #include <linux/init.h>
 #include <linux/sysrq.h>
 #include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/dump.h>
 
 asmlinkage void sys_sync(void);	/* it's really int */
 
 int panic_timeout;
+int (*dump_function_ptr)(char *, struct pt_regs *) = 0;
+int (*dump_device_register_ptr)(void*) = 0;
+volatile int dump_in_progress = 0;
+volatile int dumping_cpu = 0;
 
 struct notifier_block *panic_notifier_list;
 
@@ -48,6 +54,8 @@
 #if defined(CONFIG_ARCH_S390)
         unsigned long caller = (unsigned long) __builtin_return_address(0);
 #endif
+	struct pt_regs regs;
+	get_current_regs(&regs);
 
 	bust_spinlocks(1);
 	va_start(args, fmt);
@@ -62,12 +70,16 @@
 		sys_sync();
 	bust_spinlocks(0);
 
+#if !defined(CONFIG_CRASH_DUMP) && !defined(CONFIG_CRASH_DUMP_MODULE)
 #ifdef CONFIG_SMP
 	smp_send_stop();
 #endif
+#endif
 
        notifier_call_chain(&panic_notifier_list, 0, buf);
 
+	dump(buf, &regs);
+
 	if (panic_timeout > 0)
 	{
 		/*
@@ -125,3 +137,9 @@
 }
 
 int tainted = 0;
+
+EXPORT_SYMBOL(panic_timeout);
+EXPORT_SYMBOL(dump_function_ptr);
+EXPORT_SYMBOL(dump_device_register_ptr);
+EXPORT_SYMBOL(dump_in_progress);
+EXPORT_SYMBOL(dumping_cpu);
diff -urN -X /home/bharata/dontdiff linux-2.5.41/kernel/sched.c linux-2.5.41+lkcd/kernel/sched.c
--- linux-2.5.41/kernel/sched.c	Mon Oct  7 23:54:49 2002
+++ linux-2.5.41+lkcd/kernel/sched.c	Tue Oct  8 13:05:59 2002
@@ -31,6 +31,7 @@
 #include <linux/blkdev.h>
 #include <linux/delay.h>
 #include <linux/timer.h>
+#include <linux/dump.h>
 
 /*
  * Convert user-nice values [ -20 ... 0 ... 19 ]
@@ -951,6 +952,19 @@
 	struct list_head *queue;
 	int idx;
 
+#if defined(CONFIG_CRASH_DUMP) || defined(CONFIG_CRASH_DUMP_MODULE)
+	/*
+	 * Note that this code is only for kernels with dumping
+	 * enabled -- otherwise, something better should be put
+	 * in place to avoid scheduling a task while dumping.
+	 * Then this #if can be removed.  Obviously, this can
+	 * slow down scheduling ever so slightly.
+	 */
+	if (dump_in_progress) {
+		goto dump_scheduling_disabled;
+	}
+#endif
+
 	/*
 	 * Test if we are atomic.  Since do_exit() needs to call into
 	 * schedule() atomically, we ignore that path for now.
@@ -1040,6 +1054,24 @@
 	preempt_enable_no_resched();
 	if (test_thread_flag(TIF_NEED_RESCHED))
 		goto need_resched;
+
+#if defined(CONFIG_CRASH_DUMP) || defined(CONFIG_CRASH_DUMP_MODULE)
+dump_scheduling_disabled:
+{
+	int this_cpu;
+	/* make sure we assign our this_cpu ... */
+	if (!current->active_mm) BUG();
+	this_cpu = current_thread_info()->cpu;
+
+	/*
+	 * If this is not the dumping cpu, then spin right here
+	 * till the dump is complete
+	 */
+	if (this_cpu != dumping_cpu) {
+		while (dump_in_progress);
+	}
+}
+#endif
 }
 
 #ifdef CONFIG_PREEMPT
