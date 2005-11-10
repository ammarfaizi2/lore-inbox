Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbVKJQkJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbVKJQkJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 11:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbVKJQkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 11:40:09 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:44527 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751142AbVKJQkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 11:40:06 -0500
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Tom Rini <trini@kernel.crashing.org>, lkml <linux-kernel@vger.kernel.org>
Message-Id: <20051110163956.20950.22779.sendpatchset@localhost.localdomain>
In-Reply-To: <20051110163906.20950.45704.sendpatchset@localhost.localdomain>
References: <20051110163906.20950.45704.sendpatchset@localhost.localdomain>
Subject: [PATCH,RFC 2.6.14 02/15] KGDB: i386-specific changes
Date: Thu, 10 Nov 2005 11:39:44 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the basic support for i386.  The only real changes outside of new
KGDB files and Makefile/related is that for support early on we must set some
traps sooner rather than later, but it is safe to always do this.  Also, to
break in as early as possible, i386 now calls parse_early_param() to
explicitly look at anything marked early_param().  We also add a few more
notify_die() calls in areas where KGDB needs to take a peek sometimes.
Finally, we add some labels to switch_to macros so that when backtracing we
can see where we really are.

 arch/i386/kernel/Makefile   |    1 
 arch/i386/kernel/kgdb-jmp.S |   74 ++++++++++
 arch/i386/kernel/kgdb.c     |  300 ++++++++++++++++++++++++++++++++++++++++++++
 arch/i386/kernel/setup.c    |    3 
 arch/i386/kernel/traps.c    |   14 +-
 arch/i386/mm/fault.c        |    4 
 include/asm-i386/kdebug.h   |    1 
 include/asm-i386/kgdb.h     |   49 +++++++
 include/asm-i386/system.h   |    8 +
 lib/Kconfig.debug           |    2 
 10 files changed, 449 insertions(+), 7 deletions(-)

Index: linux-2.6.14/arch/i386/kernel/kgdb.c
===================================================================
--- /dev/null
+++ linux-2.6.14/arch/i386/kernel/kgdb.c
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
+ *  Updated by:	     Tom Rini <trini@kernel.crashing.org>
+ *  Modified for 386 by Jim Kingdon, Cygnus Support.
+ *  Origianl kgdb, compatibility with 2.1.xx kernel by
+ *  David Grothe <dave@gcom.com>
+ *  Additional support from Tigran Aivazian <tigran@sco.com>
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
+#include <asm/apicdef.h>
+#include <asm/desc.h>
+#include <asm/kdebug.h>
+
+#include "mach_ipi.h"
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
+}
+
+static struct hw_breakpoint {
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
+	if (correctit)
+		asm volatile ("movl %0, %%db7\n"::"r" (dr7));
+}
+
+void kgdb_disable_hw_debug(struct pt_regs *regs)
+{
+	/* Disable hardware debugging while we are in kgdb */
+	asm volatile ("movl %0,%%db7": /* no output */ :"r" (0));
+}
+
+void kgdb_post_master_code(struct pt_regs *regs, int e_vector, int err_code)
+{
+	/* Master processor is completely in the debugger */
+	gdb_i386vector = e_vector;
+	gdb_i386errcode = err_code;
+}
+
+void kgdb_roundup_cpus(unsigned long flags)
+{
+	send_IPI_allbutself(APIC_DM_NMI);
+}
+
+int kgdb_arch_handle_exception(int e_vector, int signo,
+			       int err_code, char *remcom_in_buffer,
+			       char *remcom_out_buffer,
+			       struct pt_regs *linux_regs)
+{
+	long addr;
+	char *ptr;
+	int newPC, dr6;
+
+	switch (remcom_in_buffer[0]) {
+	case 'c':
+	case 's':
+		/* try to read optional parameter, pc unchanged if no parm */
+		ptr = &remcom_in_buffer[1];
+		if (kgdb_hex2long(&ptr, &addr))
+			linux_regs->eip = addr;
+		newPC = linux_regs->eip;
+
+		/* clear the trace bit */
+		linux_regs->eflags &= ~TF_MASK;
+		atomic_set(&cpu_doing_single_step, -1);
+
+		/* set the trace bit if we're stepping */
+		if (remcom_in_buffer[0] == 's') {
+			linux_regs->eflags |= TF_MASK;
+			debugger_step = 1;
+			if (kgdb_contthread)
+				atomic_set(&cpu_doing_single_step,
+					   smp_processor_id());
+		}
+
+		asm volatile ("movl %%db6, %0\n":"=r" (dr6));
+		if (!(dr6 & 0x4000)) {
+			long breakno;
+			for (breakno = 0; breakno < 4; ++breakno) {
+				if (dr6 & (1 << breakno) &&
+				    breakinfo[breakno].type == 0) {
+					/* Set restore flag */
+					linux_regs->eflags |= X86_EFLAGS_RF;
+					break;
+				}
+			}
+		}
+		kgdb_correct_hw_break();
+		asm volatile ("movl %0, %%db6\n"::"r" (0));
+
+		return (0);
+	}			/* switch */
+	/* this means that we do not want to exit from the handler */
+	return -1;
+}
+
+/* Register KGDB with the i386die_chain so that we hook into all of the right
+ * spots. */
+static int kgdb_notify(struct notifier_block *self, unsigned long cmd,
+		       void *ptr)
+{
+	struct die_args *args = ptr;
+	struct pt_regs *regs = args->regs;
+
+	/* Bad memory access? */
+	if (cmd == DIE_PAGE_FAULT_NO_CONTEXT && atomic_read(&debugger_active)
+			&& kgdb_may_fault) {
+		kgdb_fault_longjmp(kgdb_fault_jmp_regs);
+		return NOTIFY_STOP;
+	} else if (cmd == DIE_PAGE_FAULT)
+		/* A normal page fault, ignore. */
+		return NOTIFY_DONE;
+	else if (cmd == DIE_NMI && atomic_read(&debugger_active)) {
+		/* CPU roundup */
+		kgdb_nmihook(smp_processor_id(), regs);
+		return NOTIFY_STOP;
+	} else if (cmd == DIE_NMI_IPI || user_mode(regs) ||
+		   (cmd == DIE_DEBUG && atomic_read(&debugger_active)))
+		/* Normal watchdog event or userspace debugging, or spurious
+		 * debug exception, ignore. */
+		return NOTIFY_DONE;
+
+	kgdb_handle_exception(args->trapnr, args->signr, args->err, regs);
+
+	return NOTIFY_STOP;
+}
+
+static struct notifier_block kgdb_notifier = {
+	.notifier_call = kgdb_notify,
+};
+
+int kgdb_arch_init(void)
+{
+	notifier_chain_register(&i386die_chain, &kgdb_notifier);
+	return 0;
+}
+
+struct kgdb_arch arch_kgdb_ops = {
+	.gdb_bpt_instr = {0xcc},
+};
Index: linux-2.6.14/arch/i386/kernel/kgdb-jmp.S
===================================================================
--- /dev/null
+++ linux-2.6.14/arch/i386/kernel/kgdb-jmp.S
@@ -0,0 +1,74 @@
+/*
+ * arch/i386/kernel/kgdb-jmp.S
+ *
+ * Save and restore system registers so that within a limited frame we
+ * may have a fault and "jump back" to a known safe location.
+ *
+ * Author: George Anzinger <george@mvista.com>
+ *
+ * Cribbed from glibc, which carries the following:
+ * Copyright (C) 1996, 1996, 1997, 2000, 2001 Free Software Foundation, Inc.
+ * Copyright (C) 2005 by MontaVista Software.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program as licensed "as is" without any warranty of
+ * any kind, whether express or implied.
+ */
+
+#include <linux/linkage.h>
+
+#define PCOFF		0
+#define LINKAGE		4		/* just the return address */
+#define PTR_SIZE	4
+#define PARMS		LINKAGE		/* no space for saved regs */
+#define JMPBUF		PARMS
+#define VAL		JMPBUF+PTR_SIZE
+
+#define JB_BX		0
+#define JB_SI		1
+#define JB_DI		2
+#define JB_BP		3
+#define JB_SP		4
+#define JB_PC		5
+
+/* This must be called prior to kgdb_fault_longjmp and
+ * kgdb_fault_longjmp must not be called outside of the context of the
+ * last call to kgdb_fault_setjmp.
+ * kgdb_fault_setjmp(int *jmp_buf[6])
+ */
+ENTRY(kgdb_fault_setjmp)
+	movl JMPBUF(%esp), %eax
+
+	/* Save registers.  */
+	movl	%ebx, (JB_BX*4)(%eax)
+	movl	%esi, (JB_SI*4)(%eax)
+	movl	%edi, (JB_DI*4)(%eax)
+	/* Save SP as it will be after we return.  */
+	leal	JMPBUF(%esp), %ecx
+	movl	%ecx, (JB_SP*4)(%eax)
+	movl	PCOFF(%esp), %ecx	/* Save PC we are returning to now.  */
+	movl	%ecx, (JB_PC*4)(%eax)
+	movl	%ebp, (JB_BP*4)(%eax)	/* Save caller's frame pointer.  */
+
+	/* Restore state so we can now try the access. */
+	movl	JMPBUF(%esp), %ecx	/* User's jmp_buf in %ecx.  */
+	/* Save the return address now.  */
+	movl	(JB_PC*4)(%ecx), %edx
+	/* Restore registers.  */
+	movl	$0, %eax
+	movl	(JB_SP*4)(%ecx), %esp
+	jmp	*%edx		/* Jump to saved PC. */
+
+/* kgdb_fault_longjmp(int *jmp_buf[6]) */
+ENTRY(kgdb_fault_longjmp)
+	movl	JMPBUF(%esp), %ecx	/* User's jmp_buf in %ecx.  */
+	/* Save the return address now.  */
+	movl	(JB_PC*4)(%ecx), %edx
+	/* Restore registers.  */
+	movl	(JB_BX*4)(%ecx), %ebx
+	movl	(JB_SI*4)(%ecx), %esi
+	movl	(JB_DI*4)(%ecx), %edi
+	movl	(JB_BP*4)(%ecx), %ebp
+	movl	$1, %eax
+	movl	(JB_SP*4)(%ecx), %esp
+	jmp	*%edx		/* Jump to saved PC. */
Index: linux-2.6.14/arch/i386/kernel/Makefile
===================================================================
--- linux-2.6.14.orig/arch/i386/kernel/Makefile
+++ linux-2.6.14/arch/i386/kernel/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_ACPI_SRAT) 	+= srat.o
 obj-$(CONFIG_HPET_TIMER) 	+= time_hpet.o
 obj-$(CONFIG_EFI) 		+= efi.o efi_stub.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
+obj-$(CONFIG_KGDB)		+= kgdb.o kgdb-jmp.o
 
 EXTRA_AFLAGS   := -traditional
 
Index: linux-2.6.14/arch/i386/kernel/setup.c
===================================================================
--- linux-2.6.14.orig/arch/i386/kernel/setup.c
+++ linux-2.6.14/arch/i386/kernel/setup.c
@@ -148,6 +148,7 @@ EXPORT_SYMBOL(ist_info);
 struct e820map e820;
 
 extern void early_cpu_init(void);
+extern void early_trap_init(void);
 extern void dmi_scan_machine(void);
 extern void generic_apic_probe(char *);
 extern int root_mountflags;
@@ -1481,6 +1482,7 @@ void __init setup_arch(char **cmdline_p)
 	memcpy(&boot_cpu_data, &new_cpu_data, sizeof(new_cpu_data));
 	pre_setup_arch_hook();
 	early_cpu_init();
+	early_trap_init();
 
 	/*
 	 * FIXME: This isn't an official loader_type right
@@ -1537,6 +1539,7 @@ void __init setup_arch(char **cmdline_p)
 	data_resource.end = virt_to_phys(_edata)-1;
 
 	parse_cmdline_early(cmdline_p);
+	parse_early_param();
 
 	max_low_pfn = setup_memory();
 
Index: linux-2.6.14/arch/i386/kernel/traps.c
===================================================================
--- linux-2.6.14.orig/arch/i386/kernel/traps.c
+++ linux-2.6.14/arch/i386/kernel/traps.c
@@ -333,7 +333,7 @@ void die(const char * str, struct pt_reg
 #endif
 		if (nl)
 			printk("\n");
-	notify_die(DIE_OOPS, (char *)str, regs, err, 255, SIGSEGV);
+		notify_die(DIE_OOPS, (char *)str, regs, err, 255, SIGSEGV);
 		show_registers(regs);
   	} else
 		printk(KERN_ERR "Recursive die() failure, output suppressed\n");
@@ -759,6 +759,7 @@ fastcall void __kprobes do_debug(struct 
 	 */
 clear_dr7:
 	set_debugreg(0, 7);
+	notify_die(DIE_DEBUG, "debug2", regs, condition, error_code, SIGTRAP);
 	return;
 
 debug_vm86:
@@ -1063,6 +1064,12 @@ static void __init set_task_gate(unsigne
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
@@ -1079,10 +1086,8 @@ void __init trap_init(void)
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
@@ -1092,7 +1097,6 @@ void __init trap_init(void)
 	set_trap_gate(11,&segment_not_present);
 	set_trap_gate(12,&stack_segment);
 	set_trap_gate(13,&general_protection);
-	set_intr_gate(14,&page_fault);
 	set_trap_gate(15,&spurious_interrupt_bug);
 	set_trap_gate(16,&coprocessor_error);
 	set_trap_gate(17,&alignment_check);
Index: linux-2.6.14/arch/i386/mm/fault.c
===================================================================
--- linux-2.6.14.orig/arch/i386/mm/fault.c
+++ linux-2.6.14/arch/i386/mm/fault.c
@@ -433,6 +433,10 @@ no_context:
  	if (is_prefetch(regs, address, error_code))
  		return;
 
+	if (notify_die(DIE_PAGE_FAULT_NO_CONTEXT, "no context", regs,
+				error_code, 14, SIGSEGV) == NOTIFY_STOP)
+		return;
+
 /*
  * Oops. The kernel tried to access some bad page. We'll have to
  * terminate things with extreme prejudice.
Index: linux-2.6.14/include/asm-i386/kgdb.h
===================================================================
--- /dev/null
+++ linux-2.6.14/include/asm-i386/kgdb.h
@@ -0,0 +1,49 @@
+#ifdef __KERNEL__
+#ifndef _ASM_KGDB_H_
+#define _ASM_KGDB_H_
+
+/*
+ * Copyright (C) 2001-2004 Amit S. Kale
+ */
+
+/************************************************************************/
+/* BUFMAX defines the maximum number of characters in inbound/outbound buffers*/
+/* at least NUMREGBYTES*2 are needed for register packets */
+/* Longer buffer is needed to list all threads */
+#define BUFMAX			1024
+
+/* Number of bytes of registers.  */
+#define NUMREGBYTES		64
+/* Number of bytes of registers we need to save for a setjmp/longjmp. */
+#define NUMCRITREGBYTES		24
+
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
+#define BREAKPOINT()		asm("   int $3");
+#define BREAK_INSTR_SIZE	1
+#define CACHE_FLUSH_IS_SAFE	1
+#endif				/* _ASM_KGDB_H_ */
+#endif				/* __KERNEL__ */
Index: linux-2.6.14/include/asm-i386/system.h
===================================================================
--- linux-2.6.14.orig/include/asm-i386/system.h
+++ linux-2.6.14/include/asm-i386/system.h
@@ -12,9 +12,13 @@
 struct task_struct;	/* one of the stranger aspects of C forward declarations.. */
 extern struct task_struct * FASTCALL(__switch_to(struct task_struct *prev, struct task_struct *next));
 
+/* sleeping_thread_to_gdb_regs depends on this code. Correct it if you change
+ * any of the following */
 #define switch_to(prev,next,last) do {					\
 	unsigned long esi,edi;						\
-	asm volatile("pushl %%ebp\n\t"					\
+	asm volatile(".globl __switch_to_begin\n"			\
+		     "__switch_to_begin:"				\
+		     "pushl %%ebp\n\t"					\
 		     "movl %%esp,%0\n\t"	/* save ESP */		\
 		     "movl %5,%%esp\n\t"	/* restore ESP */	\
 		     "movl $1f,%1\n\t"		/* save EIP */		\
@@ -22,6 +26,8 @@ extern struct task_struct * FASTCALL(__s
 		     "jmp __switch_to\n"				\
 		     "1:\t"						\
 		     "popl %%ebp\n\t"					\
+		     ".globl __switch_to_end\n"				\
+		     "__switch_to_end:\n"				\
 		     :"=m" (prev->thread.esp),"=m" (prev->thread.eip),	\
 		      "=a" (last),"=S" (esi),"=D" (edi)			\
 		     :"m" (next->thread.esp),"m" (next->thread.eip),	\
Index: linux-2.6.14/lib/Kconfig.debug
===================================================================
--- linux-2.6.14.orig/lib/Kconfig.debug
+++ linux-2.6.14/lib/Kconfig.debug
@@ -187,7 +187,7 @@ config WANT_EXTRA_DEBUG_INFORMATION
 config KGDB
 	bool "KGDB: kernel debugging with remote gdb"
 	select WANT_EXTRA_DEBUG_INFORMATION
-	depends on DEBUG_KERNEL
+	depends on DEBUG_KERNEL && (X86)
 	help
 	  If you say Y here, it will be possible to remotely debug the
 	  kernel using gdb. It is strongly suggested that you enable
Index: linux-2.6.14/include/asm-i386/kdebug.h
===================================================================
--- linux-2.6.14.orig/include/asm-i386/kdebug.h
+++ linux-2.6.14/include/asm-i386/kdebug.h
@@ -39,6 +39,7 @@ enum die_val {
 	DIE_CALL,
 	DIE_NMI_IPI,
 	DIE_PAGE_FAULT,
+	DIE_PAGE_FAULT_NO_CONTEXT,
 };
 
 static inline int notify_die(enum die_val val, const char *str,

-- 
Tom
