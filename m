Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266173AbSLIVzS>; Mon, 9 Dec 2002 16:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266183AbSLIVzS>; Mon, 9 Dec 2002 16:55:18 -0500
Received: from air-2.osdl.org ([65.172.181.6]:44200 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S266173AbSLIVzJ>;
	Mon, 9 Dec 2002 16:55:09 -0500
Subject: [PATCH] Notifier for significant events on i386
From: Stephen Hemminger <shemminger@osdl.org>
To: Kernel List <linux-kernel@vger.kernel.org>,
       lkcd-devel@lists.sourceforge.net
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1039471369.1055.161.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 09 Dec 2002 14:02:49 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a successor to the previous patch for notifier callback when NMI
watchdog occurs.  It is a port of x86_64 code (thanks for the suggestion
Andi Kleen <ak@suse.de>) with extensions for watchdog, and integration
of panic handling.  

To get notified for panic, oops, NMI and other events the caller needs
to insert itself in the notify_die chain.  The callback can then filter
out which events are of interest. 

This started out as a way to hook in LKCD, but it is general enough that
kprobe, kdb, and other utilities can use it as well. 

Please consider this because it makes integration of other components
much easier.

diff -urN -X dontdiff linux-2.5/include/asm-i386/kdebug.h
linux-2.5-lkcd/include/asm-i386/kdebug.h
--- linux-2.5/include/asm-i386/kdebug.h	1969-12-31 16:00:00.000000000
-0800
+++ linux-2.5-lkcd/include/asm-i386/kdebug.h	2002-12-06
11:52:34.000000000 -0800
@@ -0,0 +1,55 @@
+#ifndef _I386_KDEBUG_H
+#define _I386_KDEBUG_H 1
+
+#include <linux/notifier.h>
+
+struct pt_regs;
+
+struct die_args { 
+	struct pt_regs *regs;
+	const char *str;
+	long err; 
+}; 
+
+extern struct notifier_block *die_chain;
+
+/* Grossly misnamed. */
+enum die_val { 
+	DIE_OOPS = 1,
+	DIE_INT3,
+	DIE_DEBUG,
+	DIE_PANIC,
+	DIE_NMI,
+	DIE_DIE,
+	DIE_CPUINIT,	/* not really a die, but .. */
+	DIE_TRAPINIT,	/* not really a die, but .. */
+	DIE_STOP, 
+	DIE_WATCHDOG,
+}; 
+	
+static inline int notify_die(enum die_val val, const char *str,
+			     struct pt_regs *regs,long err)
+{ 
+	struct die_args args = { regs: regs, str: str, err: err }; 
+	return notifier_call_chain(&die_chain, val, &args); 
+} 
+
+static inline void get_current_regs(struct pt_regs *regs)
+{
+	__asm__ __volatile__("movl %%ebx,%0" : "=m"(regs->ebx));
+	__asm__ __volatile__("movl %%ecx,%0" : "=m"(regs->ecx));
+	__asm__ __volatile__("movl %%edx,%0" : "=m"(regs->edx));
+	__asm__ __volatile__("movl %%esi,%0" : "=m"(regs->esi));
+	__asm__ __volatile__("movl %%edi,%0" : "=m"(regs->edi));
+	__asm__ __volatile__("movl %%ebp,%0" : "=m"(regs->ebp));
+	__asm__ __volatile__("movl %%eax,%0" : "=m"(regs->eax));
+	__asm__ __volatile__("movl %%esp,%0" : "=m"(regs->esp));
+	__asm__ __volatile__("movw %%ss, %%ax;" :"=a"(regs->xss));
+	__asm__ __volatile__("movw %%cs, %%ax;" :"=a"(regs->xcs));
+	__asm__ __volatile__("movw %%ds, %%ax;" :"=a"(regs->xds));
+	__asm__ __volatile__("movw %%es, %%ax;" :"=a"(regs->xes));
+	__asm__ __volatile__("pushfl; popl %0" :"=m"(regs->eflags));
+	regs->eip = (unsigned long)current_text_addr();
+}
+
+#endif
diff -urN -X dontdiff linux-2.5/arch/i386/kernel/nmi.c
linux-2.5-lkcd/arch/i386/kernel/nmi.c
--- linux-2.5/arch/i386/kernel/nmi.c	2002-12-02 09:38:13.000000000 -0800
+++ linux-2.5-lkcd/arch/i386/kernel/nmi.c	2002-12-06 11:52:13.000000000
-0800
@@ -21,6 +21,7 @@
 #include <linux/mc146818rtc.h>
 #include <linux/kernel_stat.h>
 
+#include <asm/kdebug.h>
 #include <asm/smp.h>
 #include <asm/mtrr.h>
 #include <asm/mpspec.h>
@@ -377,6 +378,7 @@
 			bust_spinlocks(1);
 			printk("NMI Watchdog detected LOCKUP on CPU%d, eip %08lx,
registers:\n", cpu, regs->eip);
 			show_registers(regs);
+			notify_die(DIE_WATCHDOG, "nmi_watchdog", regs, 0);
 			printk("console shuts up ...\n");
 			console_silent();
 			spin_unlock(&nmi_print_lock);
diff -urN -X dontdiff linux-2.5/arch/i386/kernel/reboot.c
linux-2.5-lkcd/arch/i386/kernel/reboot.c
--- linux-2.5/arch/i386/kernel/reboot.c	2002-12-02 09:38:13.000000000
-0800
+++ linux-2.5-lkcd/arch/i386/kernel/reboot.c	2002-12-06
11:52:13.000000000 -0800
@@ -8,6 +8,7 @@
 #include <linux/interrupt.h>
 #include <linux/mc146818rtc.h>
 #include <asm/uaccess.h>
+#include <asm/kdebug.h>
 
 /*
  * Power off function, if any
@@ -256,7 +257,8 @@
 	 * Stop all CPUs and turn off local APICs and the IO-APIC, so
 	 * other OSs see a clean IRQ state.
 	 */
-	smp_send_stop();
+	if (notify_die(DIE_STOP,"cpustop",0,0) != NOTIFY_BAD)
+		smp_send_stop();
 	disable_IO_APIC();
 #endif
 
diff -urN -X dontdiff linux-2.5/arch/i386/kernel/setup.c
linux-2.5-lkcd/arch/i386/kernel/setup.c
--- linux-2.5/arch/i386/kernel/setup.c	2002-12-02 09:38:13.000000000
-0800
+++ linux-2.5-lkcd/arch/i386/kernel/setup.c	2002-12-06
11:52:13.000000000 -0800
@@ -36,6 +36,7 @@
 #include <linux/highmem.h>
 #include <asm/e820.h>
 #include <asm/mpspec.h>
+#include <asm/kdebug.h>
 #include <asm/edd.h>
 #include <asm/setup.h>
 #include <asm/arch_hooks.h>
@@ -43,6 +44,12 @@
 
 static inline char * __init machine_specific_memory_setup(void);
 
+extern struct notifier_block *panic_notifier_list;
+static int panic_event(struct notifier_block *, unsigned long, void *);
+static struct notifier_block panic_block = {
+	.notifier_call = panic_event,
+};
+
 /*
  * Machine setup..
  */
@@ -910,6 +917,9 @@
 #endif
 #endif
 	dmi_scan_machine();
+
+	/* Register a call for panic conditions into notify_die. */
+	notifier_chain_register(&panic_notifier_list, &panic_block);
 }
 
 static int __init highio_setup(char *str)
@@ -920,6 +930,16 @@
 }
 __setup("nohighio", highio_setup);
  
+static int panic_event(struct notifier_block *this,
+		       unsigned long event,
+		       void *ptr)
+{
+	struct pt_regs regs;
+	get_current_regs(&regs);
+
+	return notify_die(DIE_PANIC, (const char *)ptr, &regs, event);
+}
+
 
 #include "setup_arch_post.h"
 /*
diff -urN -X dontdiff linux-2.5/arch/i386/kernel/smpboot.c
linux-2.5-lkcd/arch/i386/kernel/smpboot.c
--- linux-2.5/arch/i386/kernel/smpboot.c	2002-12-02 09:38:13.000000000
-0800
+++ linux-2.5-lkcd/arch/i386/kernel/smpboot.c	2002-12-06
11:52:13.000000000 -0800
@@ -49,6 +49,7 @@
 #include <asm/tlbflush.h>
 #include <asm/smpboot.h>
 #include <asm/desc.h>
+#include <asm/kdebug.h>
 #include <asm/arch_hooks.h>
 #include "smpboot_hooks.h"
 #include "mach_apic.h"
@@ -418,6 +419,8 @@
 	 */
  	smp_store_cpu_info(cpuid);
 
+	notify_die(DIE_CPUINIT, "cpuinit", NULL, 0);
+
 	disable_APIC_timer();
 	local_irq_disable();
 	/*

diff -urN -X dontdiff linux-2.5/arch/i386/kernel/traps.c
linux-2.5-lkcd/arch/i386/kernel/traps.c
--- linux-2.5/arch/i386/kernel/traps.c	2002-12-02 09:38:13.000000000
-0800
+++ linux-2.5-lkcd/arch/i386/kernel/traps.c	2002-12-06
11:52:13.000000000 -0800
@@ -41,6 +41,7 @@
 #include <asm/debugreg.h>
 #include <asm/desc.h>
 #include <asm/i387.h>
+#include <asm/kdebug.h>
 #include <asm/nmi.h>
 
 #include <asm/smp.h>
@@ -85,8 +86,9 @@
 asmlinkage void spurious_interrupt_bug(void);
 asmlinkage void machine_check(void);
 
-static int kstack_depth_to_print = 24;
+struct notifier_block *die_chain;
 
+static int kstack_depth_to_print = 24;
 
 /*
  * If the address is either in the .text section of the
@@ -291,7 +293,12 @@
 
 void die(const char * str, struct pt_regs * regs, long err)
 {
+	struct die_args args = { regs, str, err };
+
 	console_verbose();
+	if (notifier_call_chain(&die_chain,  DIE_DIE, &args) == NOTIFY_BAD)
+		goto segv;
+
 	spin_lock_irq(&die_lock);
 	bust_spinlocks(1);
 	handle_BUG(regs);
@@ -299,6 +306,9 @@
 	show_registers(regs);
 	bust_spinlocks(0);
 	spin_unlock_irq(&die_lock);
+
+	notifier_call_chain(&die_chain, DIE_OOPS, &args);
+ segv:
 	do_exit(SIGSEGV);
 }
 
@@ -404,7 +414,6 @@
 }
 
 DO_VM86_ERROR_INFO( 0, SIGFPE,  "divide error", divide_error,
FPE_INTDIV, regs->eip)
-DO_VM86_ERROR( 3, SIGTRAP, "int3", int3)
 DO_VM86_ERROR( 4, SIGSEGV, "overflow", overflow)
 DO_VM86_ERROR( 5, SIGSEGV, "bounds", bounds)
 DO_ERROR_INFO( 6, SIGILL,  "invalid operand", invalid_op, ILL_ILLOPN,
regs->eip)
@@ -471,6 +480,7 @@
 	outb(reason, 0x61);
 }
 
+
 static void unknown_nmi_error(unsigned char reason, struct pt_regs *
regs)
 {
 #ifdef CONFIG_MCA
@@ -505,10 +515,13 @@
 		unknown_nmi_error(reason, regs);
 		return;
 	}
+	if (notify_die(DIE_NMI, "nmi", regs, reason) == NOTIFY_BAD)
+		return;
 	if (reason & 0x80)
 		mem_parity_error(reason, regs);
 	if (reason & 0x40)
 		io_check_error(reason, regs);
+
 	/*
 	 * Reassert NMI in case it became active meanwhile
 	 * as it's edge-triggered.
@@ -551,6 +564,15 @@
 	nmi_callback = dummy_nmi_callback;
 }
 
+
+asmlinkage void do_int3(struct pt_regs *regs, long error_code)
+{
+	if (notify_die(DIE_INT3, "int3", regs, error_code) == NOTIFY_BAD)
+		return; 
+
+	do_trap(3, SIGTRAP, "int3", 1, regs, error_code, NULL);
+}
+
 /*
  * Our handling of the processor debug registers is non-trivial.
  * We do not clear them on entry and exit from the kernel. Therefore
@@ -581,6 +603,9 @@
 
 	__asm__ __volatile__("movl %%db6,%0" : "=r" (condition));
 
+	if (notify_die(DIE_DEBUG, "debug", regs, error_code) == NOTIFY_BAD)
+		return; 
+
 	/* Mask out spurious debug traps due to lazy DR7 setting */
 	if (condition & (DR_TRAP0|DR_TRAP1|DR_TRAP2|DR_TRAP3)) {
 		if (!tsk->thread.debugreg[7])
@@ -927,6 +952,7 @@
 	set_call_gate(&default_ldt[0],lcall7);
 	set_call_gate(&default_ldt[4],lcall27);
 
+	notify_die(DIE_TRAPINIT, "traps initialized", 0, 0); 
 	/*
 	 * Should be a barrier for any external CPU state.
 	 */




