Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261796AbSJDWxx>; Fri, 4 Oct 2002 18:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261778AbSJDWxu>; Fri, 4 Oct 2002 18:53:50 -0400
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:35403 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id <S261796AbSJDWts>; Fri, 4 Oct 2002 18:49:48 -0400
Date: Fri, 4 Oct 2002 16:03:46 -0700
From: "Matt D. Robinson" <yakker@aparity.com>
Message-Id: <200210042303.g94N3kl10047@nakedeye.aparity.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.40: lkcd (7/9): dump trace/dump calls/dump_in_progress
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

General modifications in the kernel to allow for dumping to
take place without causing system hangs or other anomalies
(like jobs being scheduled while a dump is taking place).
Also included are additional fields for matching /dev/mem
entries to a System.map file, and the addition of dump_init()
to start the driver if it is compiled directly into the
kernel (as opposed to a module).

diff -urN -X /home/bharata/dontdiff linux-2.5.40/arch/i386/kernel/nmi.c linux-2.5.40+lkcd/arch/i386/kernel/nmi.c
--- linux-2.5.40/arch/i386/kernel/nmi.c	Tue Oct  1 12:37:02 2002
+++ linux-2.5.40+lkcd/arch/i386/kernel/nmi.c	Thu Oct  3 07:18:35 2002
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
diff -urN -X /home/bharata/dontdiff linux-2.5.40/arch/i386/kernel/traps.c linux-2.5.40+lkcd/arch/i386/kernel/traps.c
--- linux-2.5.40/arch/i386/kernel/traps.c	Tue Oct  1 12:36:20 2002
+++ linux-2.5.40+lkcd/arch/i386/kernel/traps.c	Thu Oct  3 07:18:35 2002
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
@@ -128,6 +128,93 @@
 
 #endif
 
+#ifdef CONFIG_SMP
+void (*dump_trace_ptr)(struct pt_regs *) = NULL;
+/* 
+ * This code mimics show_trace() etc in arch/i386/kernel/traps.c. We don't 
+ * use them directly as they depend on 8K aligned kernel stacks that our
+ * saved stacks don't satisfy. However, there is move to relax the requirement
+ * on task_struct to be 8K-aligned. Once that happens, we could simpify this
+ * function.
+ */
+void show_this_cpu_state(int cpu, struct pt_regs * regs, struct thread_info *ti,
+		struct task_struct *tsk)
+{
+	int i;
+	unsigned long *esp;
+	unsigned char *c;
+	int in_kernel = 1;
+
+	esp = (unsigned long *)regs->esp;
+	c = (unsigned char *)regs->eip;
+
+	if (regs->xcs & 3) {
+		in_kernel = 0;
+	}
+	printk("CPU:    %d\nEIP:    %04x:[<%08lx>]\nEFLAGS: %08lx\n",
+		cpu, 0xffff & regs->xcs, regs->eip, regs->eflags);
+	printk("eax: %08lx   ebx: %08lx   ecx: %08lx   edx: %08lx\n",
+		regs->eax, regs->ebx, regs->ecx, regs->edx);
+	printk("esi: %08lx   edi: %08lx   ebp: %08lx   esp: %p\n",
+		regs->esi, regs->edi, regs->ebp, esp);
+	printk("ds: %04x   es: %04x   ss: %04x\n",
+		regs->xds & 0xffff, regs->xes & 0xffff, regs->xss & 0xffff);
+	if (!ti) {
+		printk("no stack for this cpu\n");
+		return;
+	}
+	printk("Process %s (pid: %d, thread_info=%p task=%p)",
+		tsk->comm, tsk->pid, tsk->thread_info, tsk);
+	/*
+	 * When in-kernel, we also print out the stack and code at the
+	 * time of the fault..
+	 */
+	if (in_kernel) {
+		unsigned long *stack, addr;
+		extern int kstack_depth_to_print;
+
+		esp = (unsigned long *)((unsigned long)ti +
+				(regs->esp & (THREAD_SIZE-1)));
+
+		printk("\nStack: ");
+		stack = esp;
+		for(i=0; i < kstack_depth_to_print; i++) {
+			if ((unsigned long)stack > (unsigned long)ti + 
+					THREAD_SIZE-1)
+				break;
+			if (i && ((i % 8) == 0))
+				printk("\n       ");
+			printk("%08lx ", *stack++);
+		}
+		
+		printk("\nCall Trace: ");
+		i = 1;
+		stack = esp;
+		while ((unsigned long)stack < (unsigned long)ti + THREAD_SIZE) {
+			addr = *stack++;
+			if (kernel_text_address(addr)) {
+				if (i && ((i % 6) == 0))
+					printk("\n   ");
+				printk("[<%08lx>] ", addr);
+				i++;
+			}
+		}
+		printk("\n");
+
+		printk("\nCode: ");
+		if(regs->eip < PAGE_OFFSET) {
+			printk("eip in user space. error.\n");
+		}
+
+		for(i=0;i<20;i++) {
+			printk("%02x ", *c++);
+		}
+	}
+	printk("\n");
+	return;
+}	
+#endif /* CONFIG_SMP */
+
 void show_trace(unsigned long * stack)
 {
 	int i;
@@ -292,6 +379,7 @@
 	handle_BUG(regs);
 	printk("%s: %04lx\n", str, err & 0xffff);
 	show_registers(regs);
+	dump((char *)str, regs);
 	bust_spinlocks(0);
 	spin_unlock_irq(&die_lock);
 	do_exit(SIGSEGV);
@@ -466,6 +554,23 @@
 	outb(reason, 0x61);
 }
 
+#ifdef CONFIG_SMP
+int (*dump_ipi_function_ptr)(struct pt_regs *) = NULL;
+static int dump_ipi(struct pt_regs *regs)
+{
+	if (!(dump_ipi_function_ptr && dump_ipi_function_ptr(regs))) {
+		return 0;
+	}
+	ack_APIC_irq();
+	return 1;
+}
+#else
+static int dump_ipi(struct pt_regs *regs)
+{
+	return 0;
+}
+#endif
+
 static void unknown_nmi_error(unsigned char reason, struct pt_regs * regs)
 {
 #ifdef CONFIG_MCA
@@ -486,6 +586,9 @@
 	unsigned char reason = inb(0x61);
 
 	++nmi_count(smp_processor_id());
+        if (dump_ipi(regs)) {
+                return;
+        }
 
 	if (!(reason & 0xc0)) {
 #if CONFIG_X86_LOCAL_APIC
diff -urN -X /home/bharata/dontdiff linux-2.5.40/arch/i386/mm/init.c linux-2.5.40+lkcd/arch/i386/mm/init.c
--- linux-2.5.40/arch/i386/mm/init.c	Tue Oct  1 12:36:23 2002
+++ linux-2.5.40+lkcd/arch/i386/mm/init.c	Thu Oct  3 07:18:35 2002
@@ -157,7 +157,7 @@
 	return 0;
 }
 
-static inline int page_is_ram(unsigned long pagenr)
+int page_is_ram (unsigned long pagenr)
 {
 	int i;
 
diff -urN -X /home/bharata/dontdiff linux-2.5.40/init/main.c linux-2.5.40+lkcd/init/main.c
--- linux-2.5.40/init/main.c	Tue Oct  1 12:36:20 2002
+++ linux-2.5.40+lkcd/init/main.c	Thu Oct  3 07:18:35 2002
@@ -30,6 +30,7 @@
 #include <linux/percpu.h>
 #include <linux/kernel_stat.h>
 #include <linux/security.h>
+#include <linux/dump.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -86,6 +87,16 @@
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
@@ -450,6 +461,9 @@
 #if defined(CONFIG_SYSVIPC)
 	ipc_init();
 #endif
+#if defined(CONFIG_DUMP)
+	dump_init();
+#endif
 	check_bugs();
 	printk("POSIX conformance testing by UNIFIX\n");
 
diff -urN -X /home/bharata/dontdiff linux-2.5.40/kernel/panic.c linux-2.5.40+lkcd/kernel/panic.c
--- linux-2.5.40/kernel/panic.c	Tue Oct  1 12:37:42 2002
+++ linux-2.5.40+lkcd/kernel/panic.c	Thu Oct  3 07:18:35 2002
@@ -16,10 +16,15 @@
 #include <linux/init.h>
 #include <linux/sysrq.h>
 #include <linux/interrupt.h>
+#include <linux/dump.h>
 
 asmlinkage void sys_sync(void);	/* it's really int */
 
 int panic_timeout;
+int (*dump_function_ptr)(char *, struct pt_regs *) = 0;
+int (*dump_device_register_ptr)(void*) = 0;
+volatile int dump_in_progress = 0;
+volatile int dumping_cpu = 0;
 
 struct notifier_block *panic_notifier_list;
 
@@ -48,6 +53,8 @@
 #if defined(CONFIG_ARCH_S390)
         unsigned long caller = (unsigned long) __builtin_return_address(0);
 #endif
+	struct pt_regs regs;
+	get_current_regs(&regs);
 
 	bust_spinlocks(1);
 	va_start(args, fmt);
@@ -62,12 +69,16 @@
 		sys_sync();
 	bust_spinlocks(0);
 
+#if !defined(CONFIG_DUMP) && !defined(CONFIG_DUMP_MODULE)
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
diff -urN -X /home/bharata/dontdiff linux-2.5.40/kernel/sched.c linux-2.5.40+lkcd/kernel/sched.c
--- linux-2.5.40/kernel/sched.c	Tue Oct  1 12:37:35 2002
+++ linux-2.5.40+lkcd/kernel/sched.c	Thu Oct  3 07:18:52 2002
@@ -30,6 +30,7 @@
 #include <linux/notifier.h>
 #include <linux/delay.h>
 #include <linux/timer.h>
+#include <linux/dump.h>
 
 /*
  * Convert user-nice values [ -20 ... 0 ... 19 ]
@@ -944,6 +945,19 @@
 	struct list_head *queue;
 	int idx;
 
+#if defined(CONFIG_DUMP) || defined(CONFIG_DUMP_MODULE)
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
@@ -1033,6 +1047,24 @@
 	preempt_enable_no_resched();
 	if (test_thread_flag(TIF_NEED_RESCHED))
 		goto need_resched;
+
+#if defined(CONFIG_DUMP) || defined(CONFIG_DUMP_MODULE)
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
