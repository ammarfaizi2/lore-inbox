Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265203AbUBEBVl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 20:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265207AbUBEBVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 20:21:41 -0500
Received: from [195.39.17.254] ([195.39.17.254]:30849 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265203AbUBEBTf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 20:19:35 -0500
Date: Thu, 5 Feb 2004 02:19:03 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: "La Monte H.P. Yarroll" <piggy@timesys.com>, linux-kernel@vger.kernel.org,
       amitkale@emsyssoft.com
Subject: Re: kgdb support in vanilla 2.6.2
Message-ID: <20040205011903.GC8768@elf.ucw.cz>
References: <20040204230133.GA8702@elf.ucw.cz> <20040204152137.500e8319.akpm@osdl.org> <402182B8.7030900@timesys.com> <20040204155452.49c1eba8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040204155452.49c1eba8.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Could you elaborate a little on the first two?
> > 
> > What major kinds of cleanup are we talking about?  Style issues?
> 
> Coding style compliance, reduction of ifdefs, etc.  Reduction of patch
> footprint.  There are a few features in the patch in -mm which I am not
> aware of anyone having used.
> 
> > What features (or classes of features) do you find excessive?  Would
> > it be sufficient to add a few config items to control subfeatures
> > of kgdb?
> > 
> 
> People have added timestamping infrastructure, stack overflow testing and
> inbuilt assertion frameworks to various gdb stubs at various times.  We
> need to take a look at such things and really convice ourselves that
> they're worthwhile.  Personally, I'd only be interested in the basic stub.
> 
> I need to take a look at Amit's current patch - it sounds good.

Amit's version does not contain neither timestamping, nor assertions,
nor overflows.

It has config option that allows it to hook into scheduling
(CONFIG_KGDB_THREAD) that wraps schedules() with some code. Without
that, patch is not intrusive at all. It would look like (untested, but
you should get the idea):

[I combined i386, core and serial patch; that's minimum usefull
configuration, and killed code inside CONFIG_KGDB_THREAD, as its a
little intrusive. It does not look bad at all.]

								Pavel


--- linux-2.6.1/include/linux/debugger.h	1970-01-01 05:30:00.000000000 +0530
+++ linux-2.6.1-kgdb-2.1.0-core/include/linux/debugger.h	2004-01-13 14:21:47.000000000 +0530
@@ -0,0 +1,67 @@
....definition of gdb_debug_hook and some functions to keep ifdef
noise down...

--- linux-2.6.1/include/linux/kgdb.h	1970-01-01 05:30:00.000000000 +0530
+++ linux-2.6.1-kgdb-2.1.0-core/include/linux/kgdb.h	2004-01-21 21:53:49.000000000 +0530
@@ -0,0 +1,113 @@
...definition of kgdb_breakpoint, kgdb_arch and kgdb_serial...

--- linux-2.6.1/init/main.c	2004-01-10 11:01:50.000000000 +0530
+++ linux-2.6.1-kgdb-2.1.0-core/init/main.c	2004-01-12 19:11:04.000000000 +0530
@@ -39,6 +39,7 @@
 #include <linux/writeback.h>
 #include <linux/cpu.h>
 #include <linux/efi.h>
+#include <linux/debugger.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -578,6 +579,7 @@ static int init(void * unused)
 	do_pre_smp_initcalls();
 
 	smp_init();
+	debugger_entry();
 	do_basic_setup();
 
 	prepare_namespace();

--- linux-2.6.1/kernel/kgdbstub.c	1970-01-01 05:30:00.000000000 +0530
+++ linux-2.6.1-kgdb-2.1.0-core/kernel/kgdbstub.c	2004-01-20 11:44:09.000000000 +0530
@@ -0,0 +1,1236 @@
...okay, here lies the debugger. It still could take some cleanups.

--- linux-2.6.1/kernel/Makefile	2003-11-24 07:01:15.000000000 +0530
+++ linux-2.6.1-kgdb-2.1.0-core/kernel/Makefile	2004-01-12 19:11:04.000000000 +0530
@@ -19,6 +19,7 @@ obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_COMPAT) += compat.o
 obj-$(CONFIG_IKCONFIG) += configs.o
 obj-$(CONFIG_IKCONFIG_PROC) += configs.o
+obj-$(CONFIG_KGDB) += kgdbstub.o
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is

--- linux-2.6.1/kernel/module.c	2004-01-10 11:01:50.000000000 +0530
+++ linux-2.6.1-kgdb-2.1.0-core/kernel/module.c	2004-01-12 19:11:04.000000000 +0530
@@ -727,6 +727,11 @@ sys_delete_module(const char __user *nam
 	mod->state = MODULE_STATE_GOING;
 	restart_refcounts();
 
+	down(&notify_mutex);
+	notifier_call_chain(&module_notify_list, MODULE_STATE_GOING,
+				mod);
+	up(&notify_mutex);
+
 	/* Never wait if forced. */
 	if (!forced && module_refcount(mod) != 0)
 		wait_for_zero_refcount(mod);
@@ -1744,7 +1749,12 @@ sys_init_module(void __user *umod,
 	if (ret < 0) {
 		/* Init routine failed: abort.  Try to protect us from
                    buggy refcounters. */
+
 		mod->state = MODULE_STATE_GOING;
+		down(&notify_mutex);
+		notifier_call_chain(&module_notify_list, MODULE_STATE_GOING,
+					mod);
+		up(&notify_mutex);
 		synchronize_kernel();
 		if (mod->unsafe)
 			printk(KERN_ERR "%s: module is now stuck!\n",

--- linux-2.6.1/kernel/sched.c	2004-01-10 11:01:50.000000000 +0530
+++ linux-2.6.1-kgdb-2.1.0-core/kernel/sched.c	2004-01-14 17:05:11.000000000 +0530
@@ -37,6 +37,7 @@
 #include <linux/rcupdate.h>
 #include <linux/cpu.h>
 #include <linux/percpu.h>
+#include <linux/debugger.h>
 
 #ifdef CONFIG_NUMA
 #define cpu_to_node_mask(cpu) node_to_cpumask(cpu_to_node(cpu))
@@ -2851,6 +2869,8 @@ void __might_sleep(char *file, int line)
 #if defined(in_atomic)
 	static unsigned long prev_jiffy;	/* ratelimiting */
 
+	if (atomic_read(&debugger_active))
+		return;
 	if ((in_atomic() || irqs_disabled()) && system_running) {
 		if (time_before(jiffies, prev_jiffy + HZ) && prev_jiffy)
 			return;

--- linux-2.6.1/Makefile	2004-01-10 11:01:35.000000000 +0530
+++ linux-2.6.1-kgdb-2.1.0-core/Makefile	2004-01-12 19:11:05.000000000 +0530
@@ -439,6 +439,8 @@ endif
 
 ifndef CONFIG_FRAME_POINTER
 CFLAGS		+= -fomit-frame-pointer
+else
+CFLAGS		+= -fno-omit-frame-pointer
 endif
 
 ifdef CONFIG_DEBUG_INFO

--- linux-2.6.1/arch/i386/Kconfig	2004-01-10 11:01:35.000000000 +0530
+++ linux-2.6.1-kgdb-2.1.0-i386/arch/i386/Kconfig	2004-01-12 19:11:34.000000000 +0530
@@ -1252,6 +1252,37 @@ config DEBUG_SPINLOCK_SLEEP
 	  If you say Y here, various routines which may sleep will become very
 	  noisy if they are called with a spinlock held.	
 
+config KGDB
+	bool "KGDB: kernel debugging with remote gdb"
+	depends on DEBUG_KERNEL
+	select DEBUG_INFO
+	select FRAME_POINTER
+	help
+	  If you say Y here, it will be possible to remotely debug the
+	  kernel using gdb. This enlarges your kernel image disk size by
+	  several megabytes and requires a machine with more than 128 MB
+	  RAM to avoid excessive linking time. 
+	  Documentation of kernel debugger available at
+	  http://kgdb.sourceforge.net
+	  This is only useful for kernel hackers. If unsure, say N.
+
+config KGDB_THREAD
+	bool "KGDB: Thread analysis"
+	depends on KGDB
+	help
+	  With thread analysis enabled, gdb can talk to kgdb stub to list
+	  threads and to get stack trace for a thread. This option also enables
+	  some code which helps gdb get exact status of thread. Thread analysis
+	  adds some overhead to schedule and down functions. You can disable
+	  this option if you do not want to compromise on speed.
+
+config KGDB_CONSOLE
+	bool "KGDB: Console messages through gdb"
+	depends on KGDB
+	help
+	  If you say Y here, console messages will appear through gdb.
+	  Other consoles such as tty or ttyS will continue to work as usual.
+
 config FRAME_POINTER
 	bool "Compile the kernel with frame pointers"
 	help

--- linux-2.6.1/arch/i386/kernel/entry.S	2003-11-24 07:01:26.000000000 +0530
+++ linux-2.6.1-kgdb-2.1.0-i386/arch/i386/kernel/entry.S	2004-01-20 20:03:48.000000000 +0530
@@ -399,7 +399,17 @@ vector=vector+1
 	ALIGN
 common_interrupt:
 	SAVE_ALL
+	movl %esp, %eax
+/* Create a fake function call followed by a fake function prologue to fool
+ * gdb into believing that this is a normal function call. */
+	pushl EIP(%eax)
+
+common_interrupt_1:
+	pushl %ebp
+	movl %esp, %ebp
+	pushl %eax
 	call do_IRQ
+	addl $12, %esp
 	jmp ret_from_intr
 
 #define BUILD_INTERRUPT(name, nr)	\

--- linux-2.6.1/arch/i386/kernel/i386-stub.c	1970-01-01 05:30:00.000000000 +0530
+++ linux-2.6.1-kgdb-2.1.0-i386/arch/i386/kernel/i386-stub.c	2004-01-12 19:11:34.000000000 +0530
@@ -0,0 +1,457 @@
...and i386 dependend parts go here...

--- linux-2.6.1/arch/i386/kernel/Makefile	2004-01-10 11:01:35.000000000 +0530
+++ linux-2.6.1-kgdb-2.1.0-i386/arch/i386/kernel/Makefile	2004-01-12 19:11:34.000000000 +0530
@@ -31,6 +31,7 @@ obj-y				+= sysenter.o vsyscall.o
 obj-$(CONFIG_ACPI_SRAT) 	+= srat.o
 obj-$(CONFIG_HPET_TIMER) 	+= time_hpet.o
 obj-$(CONFIG_EFI) 		+= efi.o efi_stub.o
+obj-$(CONFIG_KGDB)		+= i386-stub.o
 
 EXTRA_AFLAGS   := -traditional
 

--- linux-2.6.1/arch/i386/kernel/nmi.c	2003-11-24 07:02:02.000000000 +0530
+++ linux-2.6.1-kgdb-2.1.0-i386/arch/i386/kernel/nmi.c	2004-01-12 19:11:34.000000000 +0530
@@ -25,6 +25,7 @@
 #include <linux/module.h>
 #include <linux/nmi.h>
 #include <linux/sysdev.h>
+#include <linux/debugger.h>
 
 #include <asm/smp.h>
 #include <asm/mtrr.h>
@@ -420,14 +421,25 @@ void nmi_watchdog_tick (struct pt_regs *
 	int sum, cpu = smp_processor_id();
 
 	sum = irq_stat[cpu].apic_timer_irqs;
+	if (atomic_read(&debugger_active)) {
 
-	if (last_irq_sums[cpu] == sum) {
+		/*
+		 * The machine is in debugger, hold this cpu if already
+		 * not held.
+		 */
+		debugger_nmihook(cpu, regs);
+		alert_counter[cpu] = 0;
+
+	} else if (last_irq_sums[cpu] == sum) {
 		/*
 		 * Ayiee, looks like this CPU is stuck ...
 		 * wait a few IRQs (5 seconds) before doing the oops ...
 		 */
 		alert_counter[cpu]++;
 		if (alert_counter[cpu] == 5*nmi_hz) {
+
+			CHK_DEBUGGER(2,SIGSEGV,0,regs,)
+
 			spin_lock(&nmi_print_lock);
 			/*
 			 * We are in trouble anyway, lets at least try

--- linux-2.6.1/arch/i386/kernel/signal.c	2003-11-24 07:01:52.000000000 +0530
+++ linux-2.6.1-kgdb-2.1.0-i386/arch/i386/kernel/signal.c	2004-01-12 19:11:34.000000000 +0530
@@ -580,7 +580,8 @@ int do_signal(struct pt_regs *regs, sigs
 		 * have been cleared if the watchpoint triggered
 		 * inside the kernel.
 		 */
-		__asm__("movl %0,%%db7"	: : "r" (current->thread.debugreg[7]));
+		if (current->thread.debugreg[7])
+			__asm__("movl %0,%%db7"	: : "r" (current->thread.debugreg[7]));
 
 		/* Whee!  Actually deliver the signal.  */
 		handle_signal(signr, &info, oldset, regs);

--- linux-2.6.1/arch/i386/kernel/traps.c	2003-11-24 07:01:14.000000000 +0530
+++ linux-2.6.1-kgdb-2.1.0-i386/arch/i386/kernel/traps.c	2004-01-12 19:11:34.000000000 +0530
@@ -51,6 +51,7 @@
 
 #include <linux/irq.h>
 #include <linux/module.h>
+#include <linux/debugger.h>
 
 #include "mach_traps.h"
 
@@ -256,6 +257,7 @@ void die(const char * str, struct pt_reg
 {
 	static int die_counter;
 
+	CHK_DEBUGGER(1,SIGTRAP,err,regs,)
 	console_verbose();
 	spin_lock_irq(&die_lock);
 	bust_spinlocks(1);
@@ -330,6 +332,7 @@ static inline void do_trap(int trapnr, i
 #define DO_ERROR(trapnr, signr, str, name) \
 asmlinkage void do_##name(struct pt_regs * regs, long error_code) \
 { \
+	CHK_DEBUGGER(trapnr,signr,error_code,regs,)\
 	do_trap(trapnr, signr, str, 0, regs, error_code, NULL); \
 }
 
@@ -347,7 +350,10 @@ asmlinkage void do_##name(struct pt_regs
 #define DO_VM86_ERROR(trapnr, signr, str, name) \
 asmlinkage void do_##name(struct pt_regs * regs, long error_code) \
 { \
+	CHK_DEBUGGER(trapnr,signr,error_code,regs,goto skip_trap)\
 	do_trap(trapnr, signr, str, 1, regs, error_code, NULL); \
+skip_trap: \
+	return; \
 }
 
 #define DO_VM86_ERROR_INFO(trapnr, signr, str, name, sicode, siaddr) \
@@ -547,7 +553,7 @@ asmlinkage void do_debug(struct pt_regs 
 	tsk->thread.debugreg[6] = condition;
 
 	/* Mask out spurious TF errors due to lazy TF clearing */
-	if (condition & DR_STEP) {
+	if (condition & DR_STEP && !debugger_step) {
 		/*
 		 * The TF error should be masked out only if the current
 		 * process is not traced and if the TRAP flag has been set
@@ -570,11 +576,13 @@ asmlinkage void do_debug(struct pt_regs 
 	info.si_errno = 0;
 	info.si_code = TRAP_BRKPT;
 	
-	/* If this is a kernel mode trap, save the user PC on entry to 
-	 * the kernel, that's what the debugger can make sense of.
-	 */
-	info.si_addr = ((regs->xcs & 3) == 0) ? (void *)tsk->thread.eip : 
-	                                        (void *)regs->eip;
+
+	/* If this is a kernel mode trap, we need to reset db7 to allow us
+	 * to continue sanely */
+	if ((regs->xcs & 3) == 0)
+		goto clear_dr7;
+
+	info.si_addr = (void *)regs->eip;
 	force_sig_info(SIGTRAP, &info, tsk);
 
 	/* Disable additional traps. They'll be re-enabled when
@@ -584,6 +592,7 @@ clear_dr7:
 	__asm__("movl %0,%%db7"
 		: /* no output */
 		: "r" (0));
+	CHK_DEBUGGER(1,SIGTRAP,error_code,regs,)
 	return;
 
 debug_vm86:

--- linux-2.6.1/arch/i386/mm/fault.c	2003-12-26 18:33:55.000000000 +0530
+++ linux-2.6.1-kgdb-2.1.0-i386/arch/i386/mm/fault.c	2004-01-12 19:11:35.000000000 +0530
@@ -2,6 +2,11 @@
  *  linux/arch/i386/mm/fault.c
  *
  *  Copyright (C) 1995  Linus Torvalds
+ *
+ *  Change History
+ *
+ *	Tigran Aivazian <tigran@sco.com>	Remote debugging support.
+ *
  */
 
 #include <linux/signal.h>
@@ -21,6 +26,7 @@
 #include <linux/vt_kern.h>		/* For unblank_screen() */
 #include <linux/highmem.h>
 #include <linux/module.h>
+#include <linux/debugger.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -262,6 +268,12 @@ asmlinkage void do_page_fault(struct pt_
 	if (in_atomic() || !mm)
 		goto bad_area_nosemaphore;
 
+	if (debugger_memerr_expected) {
+		/* This fault was caused by memory access through a debugger.
+		 * Don't handle it like user accesses */
+		goto no_context;
+	}
+
 	down_read(&mm->mmap_sem);
 
 	vma = find_vma(mm, address);
@@ -399,6 +411,8 @@ no_context:
  	if (is_prefetch(regs, address))
  		return;
 
+	CHK_DEBUGGER(14, SIGSEGV,error_code, regs,)
+
 /*
  * Oops. The kernel tried to access some bad page. We'll have to
  * terminate things with extreme prejudice.

--- linux-2.6.1/include/asm-i386/kgdb.h	1970-01-01 05:30:00.000000000 +0530
+++ linux-2.6.1-kgdb-2.1.0-i386/include/asm-i386/kgdb.h	2004-01-12 19:11:35.000000000 +0530
@@ -0,0 +1,49 @@
....i386-specific kgdb stuff....

--- linux-2.6.1/include/asm-i386/processor.h	2004-01-10 11:01:47.000000000 +0530
+++ linux-2.6.1-kgdb-2.1.0-i386/include/asm-i386/processor.h	2004-01-12 19:11:35.000000000 +0530
@@ -425,6 +426,8 @@ struct thread_struct {
 	unsigned int		saved_fs, saved_gs;
 /* IO permissions */
 	unsigned long	*io_bitmap_ptr;
+	void *		debuggerinfo;
+
 };
 
 #define INIT_THREAD  {							\

--- linux-2.6.1/drivers/serial/8250.c	2004-01-10 11:01:45.000000000 +0530
+++ linux-2.6.1-kgdb-2.1.0-8250/drivers/serial/8250.c	2004-01-12 19:10:45.000000000 +0530
@@ -1198,12 +1198,17 @@ static void serial8250_break_ctl(struct 
 	spin_unlock_irqrestore(&up->port.lock, flags);
 }
 
+static int released_irq = -1;
+
 static int serial8250_startup(struct uart_port *port)
 {
 	struct uart_8250_port *up = (struct uart_8250_port *)port;
 	unsigned long flags;
 	int retval;
 
+	if (up->port.irq == released_irq)
+		return -EBUSY;
+
 	up->capabilities = uart_config[up->port.type].flags;
 
 	if (up->port.type == PORT_16C950) {
@@ -1869,6 +1874,10 @@ static void __init serial8250_register_p
 	for (i = 0; i < UART_NR; i++) {
 		struct uart_8250_port *up = &serial8250_ports[i];
 
+		if (up->port.irq == released_irq) {
+			continue;
+		}
+
 		up->port.line = i;
 		up->port.ops = &serial8250_pops;
 		init_timer(&up->timer);
@@ -2138,6 +2147,36 @@ void serial8250_resume_port(int line)
 	uart_resume_port(&serial8250_reg, &serial8250_ports[line].port);
 }
 
+/*
+ * Find all the ports using the given irq and shut them down.
+ * Result should be that the irq will be released.
+ * At most one irq can be released this way.
+ * Once an irq is released, any attempts to initialize a port with that irq
+ * will fail with EBUSY.
+ */
+
+int serial8250_release_irq(int irq)
+{
+        struct uart_8250_port *up;
+	int ttyS;
+
+	if (released_irq != -1) {
+		return 1;
+	}
+	released_irq = irq;
+	for (ttyS = 0; ttyS < UART_NR; ttyS++){
+		up =  &serial8250_ports[ttyS];
+		if (up->port.irq == irq && (irq_lists + irq)->head) {
+#ifdef CONFIG_DEBUG_SPINLOCK   /* ugly business... */
+			if(up->port.lock.magic != SPINLOCK_MAGIC)
+				spin_lock_init(&up->port.lock);
+#endif
+			serial8250_shutdown(&up->port);
+		}
+        }
+	return 0;
+}
+
 static int __init serial8250_init(void)
 {
 	int ret, i;
diff -Naurp linux-2.6.1/drivers/serial/Kconfig linux-2.6.1-kgdb-2.1.0-8250/drivers/serial/Kconfig
--- linux-2.6.1/drivers/serial/Kconfig	2003-11-24 07:03:13.000000000 +0530
+++ linux-2.6.1-kgdb-2.1.0-8250/drivers/serial/Kconfig	2004-01-12 19:10:45.000000000 +0530
@@ -6,6 +6,13 @@
 
 menu "Serial drivers"
 
+config KGDB_8250
+	bool "KGDB: On generic serial port (8250)"
+	depends on KGDB
+	help
+	  Uses generic serial port (8250) for kgdb. This is independent of the
+	  option 9250/16550 and compatible serial port.
+
 #
 # The new 8250/16550 serial drivers
 config SERIAL_8250

--- linux-2.6.1/drivers/serial/kgdb_8250.c	1970-01-01 05:30:00.000000000 +0530
+++ linux-2.6.1-kgdb-2.1.0-8250/drivers/serial/kgdb_8250.c	2004-01-17 13:55:58.000000000 +0530
@@ -0,0 +1,408 @@
....second copy of serial driver I guess....

--- linux-2.6.1/drivers/serial/Makefile	2003-11-24 07:01:55.000000000 +0530
+++ linux-2.6.1-kgdb-2.1.0-8250/drivers/serial/Makefile	2004-01-12 19:10:45.000000000 +0530
@@ -32,3 +32,5 @@ obj-$(CONFIG_SERIAL_COLDFIRE) += mcfseri
 obj-$(CONFIG_V850E_UART) += v850e_uart.o
 obj-$(CONFIG_SERIAL98) += serial98.o
 obj-$(CONFIG_SERIAL_PMACZILOG) += pmac_zilog.o
+
+obj-$(CONFIG_KGDB_8250) += kgdb_8250.o

--- linux-2.6.1/drivers/serial/serial_core.c	2004-01-10 11:01:45.000000000 +0530
+++ linux-2.6.1-kgdb-2.1.0-8250/drivers/serial/serial_core.c	2004-01-12 19:10:45.000000000 +0530
@@ -1209,7 +1209,11 @@ static void uart_set_termios(struct tty_
 static void uart_close(struct tty_struct *tty, struct file *filp)
 {
 	struct uart_state *state = tty->driver_data;
-	struct uart_port *port = state->port;
+	struct uart_port *port;
+
+	if (!state)
+		return;
+	port = state->port;
 
 	BUG_ON(!kernel_locked());
 	DPRINTK("uart_close(%d) called\n", port->line);

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
