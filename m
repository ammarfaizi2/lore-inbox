Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261564AbUJ2SxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbUJ2SxJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 14:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261446AbUJ2Swu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 14:52:50 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:54416 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S263479AbUJ2SdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 14:33:25 -0400
Subject: [patch 2/8] KGDB support for i386
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, trini@kernel.crashing.org
From: Tom Rini <trini@kernel.crashing.org>
Message-Id: <2.29102004.trini@kernel.crashing.org>
In-Reply-To: <1.29102004.trini@kernel.crashing.org>
References: <1.29102004.trini@kernel.crashing.org>
Date: Fri, 29 Oct 2004 11:33:18 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This adds support for KGDB on the i386 architecture.  The only slightly
related change is to make i386 parse early_params now as KGDB registers as
one.  We also add an early_trap_init() call which does the parts of
trap_init() which need to be done for KGDB to be entered, and can be done
safely this early.

As an aside, I believe the hunk to arch/i386/kernel/signal.c can be dropped in
a post 2.6.10-rc1 tree as something similar using unlikey() has been put in.

---

 linux-2.6.10-rc1-trini/arch/i386/kernel/Makefile |    1 
 linux-2.6.10-rc1-trini/arch/i386/kernel/irq.c    |    3 
 linux-2.6.10-rc1-trini/arch/i386/kernel/kgdb.c   |  300 +++++++++++++++++++++++
 linux-2.6.10-rc1-trini/arch/i386/kernel/nmi.c    |   11 
 linux-2.6.10-rc1-trini/arch/i386/kernel/setup.c  |    3 
 linux-2.6.10-rc1-trini/arch/i386/kernel/signal.c |    3 
 linux-2.6.10-rc1-trini/arch/i386/kernel/traps.c  |   31 +-
 linux-2.6.10-rc1-trini/arch/i386/mm/fault.c      |   10 
 linux-2.6.10-rc1-trini/include/asm-i386/kgdb.h   |   48 +++
 linux-2.6.10-rc1-trini/include/asm-i386/system.h |   10 
 linux-2.6.10-rc1-trini/lib/Kconfig.debug         |    2 
 11 files changed, 405 insertions(+), 17 deletions(-)

diff -puN arch/i386/kernel/Makefile~i386-lite arch/i386/kernel/Makefile
--- linux-2.6.10-rc1/arch/i386/kernel/Makefile~i386-lite	2004-10-29 11:26:44.461448834 -0700
+++ linux-2.6.10-rc1-trini/arch/i386/kernel/Makefile	2004-10-29 11:26:44.481444139 -0700
@@ -32,6 +32,7 @@ obj-$(CONFIG_ACPI_SRAT) 	+= srat.o
 obj-$(CONFIG_HPET_TIMER) 	+= time_hpet.o
 obj-$(CONFIG_EFI) 		+= efi.o efi_stub.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
+obj-$(CONFIG_KGDB)		+= kgdb.o
 
 EXTRA_AFLAGS   := -traditional
 
diff -puN arch/i386/kernel/irq.c~i386-lite arch/i386/kernel/irq.c
--- linux-2.6.10-rc1/arch/i386/kernel/irq.c~i386-lite	2004-10-29 11:26:44.463448364 -0700
+++ linux-2.6.10-rc1-trini/arch/i386/kernel/irq.c	2004-10-29 11:26:44.482443904 -0700
@@ -15,6 +15,7 @@
 #include <linux/seq_file.h>
 #include <linux/interrupt.h>
 #include <linux/kernel_stat.h>
+#include <linux/kgdb.h>
 
 #ifndef CONFIG_X86_LOCAL_APIC
 /*
@@ -103,6 +104,8 @@ asmlinkage unsigned int do_IRQ(struct pt
 
 	irq_exit();
 
+	kgdb_process_breakpoint();
+
 	return 1;
 }
 
diff -puN /dev/null arch/i386/kernel/kgdb.c
--- /dev/null	2004-10-25 00:35:20.587727328 -0700
+++ linux-2.6.10-rc1-trini/arch/i386/kernel/kgdb.c	2004-10-29 11:26:44.482443904 -0700
@@ -0,0 +1,300 @@
+/*
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2, or (at your option) any
+ * later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ */
+
+/*
+ * Copyright (C) 2000-2001 VERITAS Software Corporation.
+ */
+/*
+ *  Contributor:     Lake Stevens Instrument Division$
+ *  Written by:      Glenn Engel $
+ *  Updated by:	     Amit Kale<akale@veritas.com>
+ *  Modified for 386 by Jim Kingdon, Cygnus Support.
+ *  Origianl kgdb, compatibility with 2.1.xx kernel by David Grothe <dave@gcom.com>
+ */
+
+#include <linux/string.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/smp.h>
+#include <linux/spinlock.h>
+#include <linux/delay.h>
+#include <asm/vm86.h>
+#include <asm/system.h>
+#include <asm/ptrace.h>		/* for linux pt_regs struct */
+#include <linux/kgdb.h>
+#include <linux/init.h>
+#include <linux/debugger.h>
+#include <asm/desc.h>
+#include <asm/kdebug.h>
+
+/* Put the error code here just in case the user cares.  */
+int gdb_i386errcode;
+/* Likewise, the vector number here (since GDB only gets the signal
+   number through the usual means, and that's not very specific).  */
+int gdb_i386vector = -1;
+
+extern atomic_t cpu_doing_single_step;
+
+void regs_to_gdb_regs(unsigned long *gdb_regs, struct pt_regs *regs)
+{
+	gdb_regs[_EAX] = regs->eax;
+	gdb_regs[_EBX] = regs->ebx;
+	gdb_regs[_ECX] = regs->ecx;
+	gdb_regs[_EDX] = regs->edx;
+	gdb_regs[_ESI] = regs->esi;
+	gdb_regs[_EDI] = regs->edi;
+	gdb_regs[_EBP] = regs->ebp;
+	gdb_regs[_DS] = regs->xds;
+	gdb_regs[_ES] = regs->xes;
+	gdb_regs[_PS] = regs->eflags;
+	gdb_regs[_CS] = regs->xcs;
+	gdb_regs[_PC] = regs->eip;
+	gdb_regs[_ESP] = (int)(&regs->esp);
+	gdb_regs[_SS] = __KERNEL_DS;
+	gdb_regs[_FS] = 0xFFFF;
+	gdb_regs[_GS] = 0xFFFF;
+}
+
+/*
+ * Extracts ebp, esp and eip values understandable by gdb from the values
+ * saved by switch_to.
+ * thread.esp points to ebp. flags and ebp are pushed in switch_to hence esp
+ * prior to entering switch_to is 8 greater then the value that is saved.
+ * If switch_to changes, change following code appropriately.
+ */
+void sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct task_struct *p)
+{
+	gdb_regs[_EAX] = 0;
+	gdb_regs[_EBX] = 0;
+	gdb_regs[_ECX] = 0;
+	gdb_regs[_EDX] = 0;
+	gdb_regs[_ESI] = 0;
+	gdb_regs[_EDI] = 0;
+	gdb_regs[_EBP] = *(unsigned long *)p->thread.esp;
+	gdb_regs[_DS] = __KERNEL_DS;
+	gdb_regs[_ES] = __KERNEL_DS;
+	gdb_regs[_PS] = *(unsigned long *)(p->thread.esp + 4);
+	gdb_regs[_CS] = __KERNEL_CS;
+	gdb_regs[_PC] = p->thread.eip;
+	gdb_regs[_ESP] = p->thread.esp;
+	gdb_regs[_SS] = __KERNEL_DS;
+	gdb_regs[_FS] = 0xFFFF;
+	gdb_regs[_GS] = 0xFFFF;
+}
+
+void gdb_regs_to_regs(unsigned long *gdb_regs, struct pt_regs *regs)
+{
+	regs->eax = gdb_regs[_EAX];
+	regs->ebx = gdb_regs[_EBX];
+	regs->ecx = gdb_regs[_ECX];
+	regs->edx = gdb_regs[_EDX];
+	regs->esi = gdb_regs[_ESI];
+	regs->edi = gdb_regs[_EDI];
+	regs->ebp = gdb_regs[_EBP];
+	regs->xds = gdb_regs[_DS];
+	regs->xes = gdb_regs[_ES];
+	regs->eflags = gdb_regs[_PS];
+	regs->xcs = gdb_regs[_CS];
+	regs->eip = gdb_regs[_PC];
+#if 0				/* can't change these */
+	regs->esp = gdb_regs[_ESP];
+	regs->xss = gdb_regs[_SS];
+	regs->fs = gdb_regs[_FS];
+	regs->gs = gdb_regs[_GS];
+#endif
+
+}
+
+struct hw_breakpoint {
+	unsigned enabled;
+	unsigned type;
+	unsigned len;
+	unsigned addr;
+} breakinfo[4] = {
+	{ .enabled = 0 },
+	{ .enabled = 0 },
+	{ .enabled = 0 },
+	{ .enabled = 0 },
+};
+
+void kgdb_correct_hw_break(void)
+{
+	int breakno;
+	int correctit;
+	int breakbit;
+	unsigned dr7;
+
+	asm volatile ("movl %%db7, %0\n":"=r" (dr7)
+		      :);
+	do {
+		unsigned addr0, addr1, addr2, addr3;
+		asm volatile ("movl %%db0, %0\n"
+			      "movl %%db1, %1\n"
+			      "movl %%db2, %2\n"
+			      "movl %%db3, %3\n":"=r" (addr0), "=r"(addr1),
+			      "=r"(addr2), "=r"(addr3):);
+	} while (0);
+	correctit = 0;
+	for (breakno = 0; breakno < 3; breakno++) {
+		breakbit = 2 << (breakno << 1);
+		if (!(dr7 & breakbit) && breakinfo[breakno].enabled) {
+			correctit = 1;
+			dr7 |= breakbit;
+			dr7 &= ~(0xf0000 << (breakno << 2));
+			dr7 |= (((breakinfo[breakno].len << 2) |
+				 breakinfo[breakno].type) << 16) <<
+			    (breakno << 2);
+			switch (breakno) {
+			case 0:
+				asm volatile ("movl %0, %%dr0\n"::"r"
+					      (breakinfo[breakno].addr));
+				break;
+
+			case 1:
+				asm volatile ("movl %0, %%dr1\n"::"r"
+					      (breakinfo[breakno].addr));
+				break;
+
+			case 2:
+				asm volatile ("movl %0, %%dr2\n"::"r"
+					      (breakinfo[breakno].addr));
+				break;
+
+			case 3:
+				asm volatile ("movl %0, %%dr3\n"::"r"
+					      (breakinfo[breakno].addr));
+				break;
+			}
+		} else if ((dr7 & breakbit) && !breakinfo[breakno].enabled) {
+			correctit = 1;
+			dr7 &= ~breakbit;
+			dr7 &= ~(0xf0000 << (breakno << 2));
+		}
+	}
+	if (correctit) {
+		asm volatile ("movl %0, %%db7\n"::"r" (dr7));
+	}
+}
+
+void kgdb_disable_hw_debug(struct pt_regs *regs)
+{
+	/* Disable hardware debugging while we are in kgdb */
+	asm volatile ("movl %0,%%db7": /* no output */ :"r" (0));
+}
+
+void kgdb_post_master_code(struct pt_regs *regs, int eVector, int err_code)
+{
+	/* Master processor is completely in the debugger */
+	gdb_i386vector = eVector;
+	gdb_i386errcode = err_code;
+}
+
+int kgdb_arch_handle_exception(int exceptionVector, int signo,
+			       int err_code, char *remcom_in_buffer,
+			       char *remcom_out_buffer,
+			       struct pt_regs *linux_regs)
+{
+	long addr;
+	long breakno;
+	char *ptr;
+	int newPC;
+	int dr6;
+
+	switch (remcom_in_buffer[0]) {
+	case 'c':
+	case 's':
+		if (kgdb_contthread && kgdb_contthread != current) {
+			strcpy(remcom_out_buffer, "E00");
+			break;
+		}
+
+		/* try to read optional parameter, pc unchanged if no parm */
+		ptr = &remcom_in_buffer[1];
+		if (kgdb_hex2long(&ptr, &addr)) {
+			linux_regs->eip = addr;
+		}
+		newPC = linux_regs->eip;
+
+		/* clear the trace bit */
+		linux_regs->eflags &= ~TF_MASK;
+		atomic_set(&cpu_doing_single_step,-1);
+
+		/* set the trace bit if we're stepping */
+		if (remcom_in_buffer[0] == 's') {
+			linux_regs->eflags |= TF_MASK;
+			debugger_step = 1;
+			if (kgdb_contthread)
+				atomic_set(&cpu_doing_single_step,smp_processor_id());
+		}
+
+		asm volatile ("movl %%db6, %0\n":"=r" (dr6));
+		if (!(dr6 & 0x4000)) {
+			for (breakno = 0; breakno < 4; ++breakno) {
+				if (dr6 & (1 << breakno)) {
+					if (breakinfo[breakno].type == 0) {
+						/* Set restore flag */
+						linux_regs->eflags |= X86_EFLAGS_RF;
+						break;
+					}
+				}
+			}
+		}
+		kgdb_correct_hw_break();
+		asm volatile ("movl %0, %%db6\n"::"r" (0));
+
+		return (0);
+	}			/* switch */
+	return -1;		/* this means that we do not want to exit from the handler */
+}
+
+/* Register KGDB with the i386die_chain so that we hook into all of the right
+ * spots. */
+static int kgdb_notify(struct notifier_block *self, unsigned long cmd,
+		void *ptr)
+{
+	struct die_args *args = (struct die_args *)ptr;
+	struct pt_regs *regs = args->regs;
+
+	/* See if KGDB is interested. */
+	if (cmd == DIE_PAGE_FAULT)
+		return NOTIFY_DONE;
+	else if (user_mode(regs)) {
+		if (cmd == DIE_OOPS)
+			CHK_DEBUGGER(args->trapnr, args->signr, args->err,
+					args->regs,);
+		return NOTIFY_DONE;
+	} else if (cmd == DIE_NMI_IPI) {
+		if (atomic_read(&debugger_active)) {
+			debugger_nmihook(smp_processor_id(), ptr);
+			return NOTIFY_STOP;
+		}
+	}
+
+	CHK_DEBUGGER(args->trapnr, args->signr, args->err, args->regs,);
+
+	return NOTIFY_STOP;
+}
+
+static struct notifier_block kgdb_notifier = {
+	.notifier_call = kgdb_notify,
+};
+
+int kgdb_arch_init(void) {
+	notifier_chain_register(&i386die_chain, &kgdb_notifier);
+	return 0;
+}
+
+struct kgdb_arch arch_kgdb_ops = {
+	.gdb_bpt_instr = {0xcc},
+};
diff -puN arch/i386/kernel/nmi.c~i386-lite arch/i386/kernel/nmi.c
--- linux-2.6.10-rc1/arch/i386/kernel/nmi.c~i386-lite	2004-10-29 11:26:44.465447895 -0700
+++ linux-2.6.10-rc1-trini/arch/i386/kernel/nmi.c	2004-10-29 11:26:44.483443669 -0700
@@ -26,6 +26,7 @@
 #include <linux/nmi.h>
 #include <linux/sysdev.h>
 #include <linux/sysctl.h>
+#include <linux/debugger.h>
 
 #include <asm/smp.h>
 #include <asm/mtrr.h>
@@ -481,7 +482,15 @@ void nmi_watchdog_tick (struct pt_regs *
 
 	sum = irq_stat[cpu].apic_timer_irqs;
 
-	if (last_irq_sums[cpu] == sum) {
+	if (atomic_read(&debugger_active)) {
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
diff -puN arch/i386/kernel/setup.c~i386-lite arch/i386/kernel/setup.c
--- linux-2.6.10-rc1/arch/i386/kernel/setup.c~i386-lite	2004-10-29 11:26:44.467447425 -0700
+++ linux-2.6.10-rc1-trini/arch/i386/kernel/setup.c	2004-10-29 11:26:44.484443435 -0700
@@ -117,6 +117,7 @@ struct e820map e820;
 unsigned char aux_device_present;
 
 extern void early_cpu_init(void);
+extern void early_trap_init(void);
 extern void dmi_scan_machine(void);
 extern void generic_apic_probe(char *);
 extern int root_mountflags;
@@ -1302,6 +1303,7 @@ void __init setup_arch(char **cmdline_p)
 	memcpy(&boot_cpu_data, &new_cpu_data, sizeof(new_cpu_data));
 	pre_setup_arch_hook();
 	early_cpu_init();
+	early_trap_init();
 
 	/*
 	 * FIXME: This isn't an official loader_type right
@@ -1358,6 +1360,7 @@ void __init setup_arch(char **cmdline_p)
 	data_resource.end = virt_to_phys(_edata)-1;
 
 	parse_cmdline_early(cmdline_p);
+	parse_early_param();
 
 	max_low_pfn = setup_memory();
 
diff -puN arch/i386/kernel/signal.c~i386-lite arch/i386/kernel/signal.c
--- linux-2.6.10-rc1/arch/i386/kernel/signal.c~i386-lite	2004-10-29 11:26:44.469446956 -0700
+++ linux-2.6.10-rc1-trini/arch/i386/kernel/signal.c	2004-10-29 11:26:44.485443200 -0700
@@ -600,7 +600,8 @@ int fastcall do_signal(struct pt_regs *r
 		 * have been cleared if the watchpoint triggered
 		 * inside the kernel.
 		 */
-		__asm__("movl %0,%%db7"	: : "r" (current->thread.debugreg[7]));
+		if (current->thread.debugreg[7])
+			__asm__("movl %0,%%db7"	: : "r" (current->thread.debugreg[7]));
 
 		/* Whee!  Actually deliver the signal.  */
 		handle_signal(signr, &info, &ka, oldset, regs);
diff -puN arch/i386/kernel/traps.c~i386-lite arch/i386/kernel/traps.c
--- linux-2.6.10-rc1/arch/i386/kernel/traps.c~i386-lite	2004-10-29 11:26:44.471446486 -0700
+++ linux-2.6.10-rc1-trini/arch/i386/kernel/traps.c	2004-10-29 11:26:44.486442965 -0700
@@ -53,6 +53,7 @@
 
 #include <linux/irq.h>
 #include <linux/module.h>
+#include <linux/debugger.h>
 
 #include "mach_traps.h"
 
@@ -332,7 +333,7 @@ void die(const char * str, struct pt_reg
 #endif
 		if (nl)
 			printk("\n");
-	notify_die(DIE_OOPS, (char *)str, regs, err, 255, SIGSEGV);
+		notify_die(DIE_OOPS, (char *)str, regs, err, 255, SIGSEGV);
 		show_registers(regs);
   	} else
 		printk(KERN_ERR "Recursive die() failure, output suppressed\n");
@@ -711,7 +712,7 @@ asmlinkage void do_debug(struct pt_regs 
 	tsk->thread.debugreg[6] = condition;
 
 	/* Mask out spurious TF errors due to lazy TF clearing */
-	if (condition & DR_STEP) {
+	if (condition & DR_STEP && !debugger_step) {
 		/*
 		 * The TF error should be masked out only if the current
 		 * process is not traced and if the TRAP flag has been set
@@ -733,12 +734,14 @@ asmlinkage void do_debug(struct pt_regs 
 	info.si_signo = SIGTRAP;
 	info.si_errno = 0;
 	info.si_code = TRAP_BRKPT;
-	
-	/* If this is a kernel mode trap, save the user PC on entry to 
-	 * the kernel, that's what the debugger can make sense of.
-	 */
-	info.si_addr = ((regs->xcs & 3) == 0) ? (void __user *)tsk->thread.eip
-	                                      : (void __user *)regs->eip;
+
+	/* If this is a kernel mode trap, we need to reset db7 to allow us
+	 * to continue sanely */
+	if ((regs->xcs & 3) == 0)
+		goto clear_dr7;
+
+	info.si_addr = (void *)regs->eip;
+
 	force_sig_info(SIGTRAP, &info, tsk);
 
 	/* Disable additional traps. They'll be re-enabled when
@@ -748,6 +751,7 @@ clear_dr7:
 	__asm__("movl %0,%%db7"
 		: /* no output */
 		: "r" (0));
+	notify_die(DIE_DEBUG, "debug", regs, condition, error_code, SIGTRAP);
 	return;
 
 debug_vm86:
@@ -1005,6 +1009,12 @@ static void __init set_task_gate(unsigne
 	_set_gate(idt_table+n,5,0,0,(gdt_entry<<3));
 }
 
+/* Some traps need to be set early. */
+void __init early_trap_init(void) {
+	set_intr_gate(1,&debug);
+	set_system_intr_gate(3, &int3); /* int3 can be called from all */
+	set_intr_gate(14,&page_fault);
+}
 
 void __init trap_init(void)
 {
@@ -1019,10 +1029,8 @@ void __init trap_init(void)
 #endif
 
 	set_trap_gate(0,&divide_error);
-	set_intr_gate(1,&debug);
 	set_intr_gate(2,&nmi);
-	set_system_intr_gate(3, &int3); /* int3-5 can be called from all */
-	set_system_gate(4,&overflow);
+	set_system_gate(4,&overflow); /* int4/5 can be called from all */
 	set_system_gate(5,&bounds);
 	set_trap_gate(6,&invalid_op);
 	set_trap_gate(7,&device_not_available);
@@ -1032,7 +1040,6 @@ void __init trap_init(void)
 	set_trap_gate(11,&segment_not_present);
 	set_trap_gate(12,&stack_segment);
 	set_trap_gate(13,&general_protection);
-	set_intr_gate(14,&page_fault);
 	set_trap_gate(15,&spurious_interrupt_bug);
 	set_trap_gate(16,&coprocessor_error);
 	set_trap_gate(17,&alignment_check);
diff -puN arch/i386/mm/fault.c~i386-lite arch/i386/mm/fault.c
--- linux-2.6.10-rc1/arch/i386/mm/fault.c~i386-lite	2004-10-29 11:26:44.473446017 -0700
+++ linux-2.6.10-rc1-trini/arch/i386/mm/fault.c	2004-10-29 11:26:44.486442965 -0700
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
@@ -426,6 +432,10 @@ no_context:
  	if (is_prefetch(regs, address, error_code))
  		return;
 
+	if (notify_die(DIE_PAGE_FAULT, "page fault", regs, error_code, 14,
+				SIGSEGV) == NOTIFY_BAD)
+		return;
+
 /*
  * Oops. The kernel tried to access some bad page. We'll have to
  * terminate things with extreme prejudice.
diff -puN /dev/null include/asm-i386/kgdb.h
--- /dev/null	2004-10-25 00:35:20.587727328 -0700
+++ linux-2.6.10-rc1-trini/include/asm-i386/kgdb.h	2004-10-29 11:26:44.487442730 -0700
@@ -0,0 +1,48 @@
+#ifndef _ASM_KGDB_H_
+#define _ASM_KGDB_H_
+
+/*
+ * Copyright (C) 2001-2004 Amit S. Kale
+ */
+
+#include <linux/ptrace.h>
+
+/************************************************************************/
+/* BUFMAX defines the maximum number of characters in inbound/outbound buffers*/
+/* at least NUMREGBYTES*2 are needed for register packets */
+/* Longer buffer is needed to list all threads */
+#define BUFMAX 1024
+
+/* Number of bytes of registers.  */
+#define NUMREGBYTES 64
+/*
+ *  Note that this register image is in a different order than
+ *  the register image that Linux produces at interrupt time.
+ *
+ *  Linux's register image is defined by struct pt_regs in ptrace.h.
+ *  Just why GDB uses a different order is a historical mystery.
+ */
+enum regnames { _EAX,		/* 0 */
+	_ECX,			/* 1 */
+	_EDX,			/* 2 */
+	_EBX,			/* 3 */
+	_ESP,			/* 4 */
+	_EBP,			/* 5 */
+	_ESI,			/* 6 */
+	_EDI,			/* 7 */
+	_PC,			/* 8 also known as eip */
+	_PS,			/* 9 also known as eflags */
+	_CS,			/* 10 */
+	_SS,			/* 11 */
+	_DS,			/* 12 */
+	_ES,			/* 13 */
+	_FS,			/* 14 */
+	_GS			/* 15 */
+};
+
+#define BREAKPOINT() asm("   int $3");
+#define BREAK_INSTR_SIZE       1
+
+#define CHECK_EXCEPTION_STACK() 	1
+
+#endif				/* _ASM_KGDB_H_ */
diff -puN include/asm-i386/system.h~i386-lite include/asm-i386/system.h
--- linux-2.6.10-rc1/include/asm-i386/system.h~i386-lite	2004-10-29 11:26:44.476445313 -0700
+++ linux-2.6.10-rc1-trini/include/asm-i386/system.h	2004-10-29 11:26:44.487442730 -0700
@@ -12,9 +12,13 @@
 struct task_struct;	/* one of the stranger aspects of C forward declarations.. */
 extern struct task_struct * FASTCALL(__switch_to(struct task_struct *prev, struct task_struct *next));
 
+/* sleeping_thread_to_gdb_regs depends on this code. Correct it if you change
+ * any of the following */
 #define switch_to(prev,next,last) do {					\
 	unsigned long esi,edi;						\
-	asm volatile("pushfl\n\t"					\
+	asm volatile(".globl __switch_to_begin\n"			\
+		     "__switch_to_begin:"				\
+		     "pushfl\n\t"					\
 		     "pushl %%ebp\n\t"					\
 		     "movl %%esp,%0\n\t"	/* save ESP */		\
 		     "movl %5,%%esp\n\t"	/* restore ESP */	\
@@ -23,7 +27,9 @@ extern struct task_struct * FASTCALL(__s
 		     "jmp __switch_to\n"				\
 		     "1:\t"						\
 		     "popl %%ebp\n\t"					\
-		     "popfl"						\
+		     "popfl\n"						\
+		     ".globl __switch_to_end\n"				\
+		     "__switch_to_end:\n"				\
 		     :"=m" (prev->thread.esp),"=m" (prev->thread.eip),	\
 		      "=a" (last),"=S" (esi),"=D" (edi)			\
 		     :"m" (next->thread.esp),"m" (next->thread.eip),	\
diff -puN lib/Kconfig.debug~i386-lite lib/Kconfig.debug
--- linux-2.6.10-rc1/lib/Kconfig.debug~i386-lite	2004-10-29 11:26:44.477445078 -0700
+++ linux-2.6.10-rc1-trini/lib/Kconfig.debug	2004-10-29 11:32:58.640565630 -0700
@@ -115,7 +115,7 @@ endif
 
 config KGDB
 	bool "KGDB: kernel debugging with remote gdb"
-	depends on DEBUG_KERNEL
+	depends on DEBUG_KERNEL && (X86)
 	help
 	  If you say Y here, it will be possible to remotely debug the
 	  kernel using gdb. This enlarges your kernel image disk size by
_
