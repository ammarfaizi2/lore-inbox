Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261790AbUJ2TVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbUJ2TVE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 15:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261772AbUJ2TVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 15:21:03 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:21225 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S263458AbUJ2SeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 14:34:24 -0400
Subject: [patch 7/8] KGDB support for x86_64
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, trini@kernel.crashing.org, ak@suse.de
From: Tom Rini <trini@kernel.crashing.org>
Message-Id: <7.29102004.trini@kernel.crashing.org>
In-Reply-To: <6.29102004.trini@kernel.crashing.org>
References: <6.29102004.trini@kernel.crashing.org> <1.29102004.trini@kernel.crashing.org>
Date: Fri, 29 Oct 2004 11:34:21 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Cc: Andi Kleen <ak@suse.de>
This adds KGDB support for x86_64.

---

 linux-2.6.10-rc1-trini/arch/x86_64/Kconfig.debug   |    3 
 linux-2.6.10-rc1-trini/arch/x86_64/kernel/Makefile |    3 
 linux-2.6.10-rc1-trini/arch/x86_64/kernel/irq.c    |    8 
 linux-2.6.10-rc1-trini/arch/x86_64/kernel/kgdb.c   |  448 +++++++++++++++++++++
 linux-2.6.10-rc1-trini/arch/x86_64/kernel/traps.c  |    3 
 linux-2.6.10-rc1-trini/include/asm-x86_64/kgdb.h   |   56 ++
 linux-2.6.10-rc1-trini/lib/Kconfig.debug           |    2 
 7 files changed, 518 insertions(+), 5 deletions(-)

diff -puN arch/x86_64/Kconfig.debug~x86_64-lite arch/x86_64/Kconfig.debug
--- linux-2.6.10-rc1/arch/x86_64/Kconfig.debug~x86_64-lite	2004-10-29 11:26:45.744147657 -0700
+++ linux-2.6.10-rc1-trini/arch/x86_64/Kconfig.debug	2004-10-29 11:26:45.757144605 -0700
@@ -41,7 +41,4 @@ config IOMMU_LEAK
          Add a simple leak tracer to the IOMMU code. This is useful when you
 	 are debugging a buggy device driver that leaks IOMMU mappings.
 
-#config X86_REMOTE_DEBUG
-#       bool "kgdb debugging stub"
-
 endmenu
diff -puN arch/x86_64/kernel/Makefile~x86_64-lite arch/x86_64/kernel/Makefile
--- linux-2.6.10-rc1/arch/x86_64/kernel/Makefile~x86_64-lite	2004-10-29 11:26:45.746147187 -0700
+++ linux-2.6.10-rc1-trini/arch/x86_64/kernel/Makefile	2004-10-29 11:26:45.757144605 -0700
@@ -10,6 +10,8 @@ obj-y	:= process.o semaphore.o signal.o 
 		setup64.o bootflag.o e820.o reboot.o warmreboot.o
 obj-y += mce.o
 
+CFLAGS_vsyscall.o := -g0
+
 obj-$(CONFIG_MTRR)		+= ../../i386/kernel/cpu/mtrr/
 obj-$(CONFIG_ACPI_BOOT)		+= acpi/
 obj-$(CONFIG_X86_MSR)		+= msr.o
@@ -27,6 +29,7 @@ obj-$(CONFIG_DUMMY_IOMMU)	+= pci-nommu.o
 obj-$(CONFIG_SWIOTLB)		+= swiotlb.o
 
 obj-$(CONFIG_MODULES)		+= module.o
+obj-$(CONFIG_KGDB)		+= kgdb.o
 
 obj-y				+= topology.o
 obj-y				+= intel_cacheinfo.o
diff -puN arch/x86_64/kernel/irq.c~x86_64-lite arch/x86_64/kernel/irq.c
--- linux-2.6.10-rc1/arch/x86_64/kernel/irq.c~x86_64-lite	2004-10-29 11:26:45.748146718 -0700
+++ linux-2.6.10-rc1-trini/arch/x86_64/kernel/irq.c	2004-10-29 11:26:45.757144605 -0700
@@ -14,6 +14,7 @@
 #include <linux/interrupt.h>
 #include <linux/seq_file.h>
 #include <linux/module.h>
+#include <linux/kgdb.h>
 #include <asm/uaccess.h>
 #include <asm/io_apic.h>
 
@@ -103,6 +104,13 @@ asmlinkage unsigned int do_IRQ(struct pt
 	__do_IRQ(irq, regs);
 	irq_exit();
 
+	/*
+	 * Do not call breakpoint as on the x86_64 architecture if the
+	 * exception tables are not set.
+	 */
+	if(CHECK_EXCEPTION_STACK())
+		kgdb_process_breakpoint();
+
 	return 1;
 }
 
diff -puN /dev/null arch/x86_64/kernel/kgdb.c
--- /dev/null	2004-10-25 00:35:20.587727328 -0700
+++ linux-2.6.10-rc1-trini/arch/x86_64/kernel/kgdb.c	2004-10-29 11:26:45.758144370 -0700
@@ -0,0 +1,448 @@
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
+ * Copyright (C) 2004 Amit S. Kale
+ * Copyright (C) 2000-2001 VERITAS Software Corporation.
+ * Copyright (C) 2002 Andi Kleen, SuSE Labs
+ */
+/****************************************************************************
+ *  Contributor:     Lake Stevens Instrument Division$
+ *  Written by:      Glenn Engel $
+ *  Updated by:	     Amit Kale<akale@veritas.com>
+ *  Modified for 386 by Jim Kingdon, Cygnus Support.
+ *  Origianl kgdb, compatibility with 2.1.xx kernel by David Grothe <dave@gcom.com>
+ *  Integrated into 2.2.5 kernel by Tigran Aivazian <tigran@sco.com>
+ *  X86_64 changes from Andi Kleen's patch merged by Jim Houston
+ */
+
+#include <linux/string.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/smp.h>
+#include <linux/spinlock.h>
+#include <linux/delay.h>
+#include <asm/system.h>
+#include <asm/ptrace.h>		/* for linux pt_regs struct */
+#include <linux/kgdb.h>
+#include <linux/init.h>
+#include <linux/debugger.h>
+#include <asm/kdebug.h>
+
+/* Put the error code here just in case the user cares.  */
+int gdb_x86_64errcode;
+/* Likewise, the vector number here (since GDB only gets the signal
+   number through the usual means, and that's not very specific).  */
+int gdb_x86_64vector = -1;
+
+extern atomic_t cpu_doing_single_step;
+
+void regs_to_gdb_regs(unsigned long *gdb_regs, struct pt_regs *regs)
+{
+	gdb_regs[_RAX] = regs->rax;
+	gdb_regs[_RBX] = regs->rbx;
+	gdb_regs[_RCX] = regs->rcx;
+	gdb_regs[_RDX] = regs->rdx;
+	gdb_regs[_RSI] = regs->rsi;
+	gdb_regs[_RDI] = regs->rdi;
+	gdb_regs[_RBP] = regs->rbp;
+	gdb_regs[_PS] = regs->eflags;
+	gdb_regs[_PC] = regs->rip;
+	gdb_regs[_R8] = regs->r8;
+	gdb_regs[_R9] = regs->r9;
+	gdb_regs[_R10] = regs->r10;
+	gdb_regs[_R11] = regs->r11;
+	gdb_regs[_R12] = regs->r12;
+	gdb_regs[_R13] = regs->r13;
+	gdb_regs[_R14] = regs->r14;
+	gdb_regs[_R15] = regs->r15;
+	gdb_regs[_RSP] = regs->rsp;
+}
+
+struct task_struct *__switch_to(struct task_struct *prev_p,
+				struct task_struct *next_p);
+void sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct task_struct *p)
+{
+	gdb_regs[_RAX] = 0;
+	gdb_regs[_RBX] = 0;
+	gdb_regs[_RCX] = 0;
+	gdb_regs[_RDX] = 0;
+	gdb_regs[_RSI] = 0;
+	gdb_regs[_RDI] = 0;
+	gdb_regs[_RBP] = 0;
+	gdb_regs[_PS] = 0;
+	gdb_regs[_PC] = (unsigned long)__switch_to;
+	gdb_regs[_R8] = 0;
+	gdb_regs[_R9] = 0;
+	gdb_regs[_R10] = 0;
+	gdb_regs[_R11] = 0;
+	gdb_regs[_R12] = 0;
+	gdb_regs[_R13] = 0;
+	gdb_regs[_R14] = 0;
+	gdb_regs[_R15] = 0;
+	gdb_regs[_RSP] = p->thread.rsp;
+}
+
+void gdb_regs_to_regs(unsigned long *gdb_regs, struct pt_regs *regs)
+{
+	regs->rax = gdb_regs[_RAX];
+	regs->rbx = gdb_regs[_RBX];
+	regs->rcx = gdb_regs[_RCX];
+	regs->rdx = gdb_regs[_RDX];
+	regs->rsi = gdb_regs[_RSI];
+	regs->rdi = gdb_regs[_RDI];
+	regs->rbp = gdb_regs[_RBP];
+	regs->eflags = gdb_regs[_PS];
+	regs->rip = gdb_regs[_PC];
+	regs->r8 = gdb_regs[_R8];
+	regs->r9 = gdb_regs[_R9];
+	regs->r10 = gdb_regs[_R10];
+	regs->r11 = gdb_regs[_R11];
+	regs->r12 = gdb_regs[_R12];
+	regs->r13 = gdb_regs[_R13];
+	regs->r14 = gdb_regs[_R14];
+	regs->r15 = gdb_regs[_R15];
+#if 0				/* can't change these */
+	regs->rsp = gdb_regs[_RSP];
+	regs->ss = gdb_regs[_SS];
+	regs->fs = gdb_regs[_FS];
+	regs->gs = gdb_regs[_GS];
+#endif
+
+}				/* gdb_regs_to_regs */
+
+struct hw_breakpoint {
+	unsigned enabled;
+	unsigned type;
+	unsigned len;
+	unsigned long addr;
+} breakinfo[4] = { {
+enabled:0}, {
+enabled:0}, {
+enabled:0}, {
+enabled:0}};
+
+void kgdb_correct_hw_break(void)
+{
+	int breakno;
+	int correctit;
+	int breakbit;
+	unsigned long dr7;
+
+	asm volatile ("movq %%db7, %0\n":"=r" (dr7):);
+	do {
+		unsigned long addr0, addr1, addr2, addr3;
+		asm volatile ("movq %%db0, %0\n"
+			      "movq %%db1, %1\n"
+			      "movq %%db2, %2\n"
+			      "movq %%db3, %3\n":"=r" (addr0), "=r"(addr1),
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
+				asm volatile ("movq %0, %%dr0\n"::"r"
+					      (breakinfo[breakno].addr));
+				break;
+
+			case 1:
+				asm volatile ("movq %0, %%dr1\n"::"r"
+					      (breakinfo[breakno].addr));
+				break;
+
+			case 2:
+				asm volatile ("movq %0, %%dr2\n"::"r"
+					      (breakinfo[breakno].addr));
+				break;
+
+			case 3:
+				asm volatile ("movq %0, %%dr3\n"::"r"
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
+		asm volatile ("movq %0, %%db7\n"::"r" (dr7));
+	}
+}
+
+int kgdb_remove_hw_break(unsigned long addr)
+{
+	int i, idx = -1;
+	for (i = 0; i < 4; i++) {
+		if (breakinfo[i].addr == addr && breakinfo[i].enabled) {
+			idx = i;
+			break;
+		}
+	}
+	if (idx == -1)
+		return -1;
+
+	breakinfo[idx].enabled = 0;
+	return 0;
+}
+
+int kgdb_set_hw_break(unsigned long addr)
+{
+	int i, idx = -1;
+	for (i = 0; i < 4; i++) {
+		if (!breakinfo[i].enabled) {
+			idx = i;
+			break;
+		}
+	}
+	if (idx == -1)
+		return -1;
+
+	breakinfo[idx].enabled = 1;
+	breakinfo[idx].type = 1;
+	breakinfo[idx].len = 1;
+	breakinfo[idx].addr = addr;
+	return 0;
+}
+
+int remove_hw_break(unsigned breakno)
+{
+	if (!breakinfo[breakno].enabled) {
+		return -1;
+	}
+	breakinfo[breakno].enabled = 0;
+	return 0;
+}
+
+int set_hw_break(unsigned breakno, unsigned type, unsigned len, unsigned addr)
+{
+	if (breakinfo[breakno].enabled) {
+		return -1;
+	}
+	breakinfo[breakno].enabled = 1;
+	breakinfo[breakno].type = type;
+	breakinfo[breakno].len = len;
+	breakinfo[breakno].addr = addr;
+	return 0;
+}
+
+void kgdb_disable_hw_debug(struct pt_regs *regs)
+{
+	/* Disable hardware debugging while we are in kgdb */
+	asm volatile ("movq %0,%%db7": /* no output */ :"r" (0UL));
+}
+
+void kgdb_post_master_code(struct pt_regs *regs, int eVector, int err_code)
+{
+	/* Master processor is completely in the debugger */
+	gdb_x86_64vector = eVector;
+	gdb_x86_64errcode = err_code;
+}
+
+int kgdb_arch_handle_exception(int exceptionVector, int signo, int err_code,
+			       char *remcomInBuffer, char *remcomOutBuffer,
+			       struct pt_regs *linux_regs)
+{
+	unsigned long addr, length;
+	unsigned long breakno, breaktype;
+	char *ptr;
+	int newPC;
+	unsigned long dr6;
+
+	switch (remcomInBuffer[0]) {
+	case 'c':
+	case 's':
+		if (kgdb_contthread && kgdb_contthread != current) {
+			strcpy(remcomOutBuffer, "E00");
+			break;
+		}
+
+		/* try to read optional parameter, pc unchanged if no parm */
+		ptr = &remcomInBuffer[1];
+		if (kgdb_hex2long(&ptr, &addr)) {
+			linux_regs->rip = addr;
+		}
+		newPC = linux_regs->rip;
+
+		/* clear the trace bit */
+		linux_regs->eflags &= ~TF_MASK;
+
+                atomic_set(&cpu_doing_single_step,-1);
+		/* set the trace bit if we're stepping */
+		if (remcomInBuffer[0] == 's') {
+			linux_regs->eflags |= TF_MASK;
+			debugger_step = 1;
+			if (kgdb_contthread)
+                                atomic_set(&cpu_doing_single_step,smp_processor_id());
+
+		}
+
+		asm volatile ("movq %%db6, %0\n":"=r" (dr6));
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
+		asm volatile ("movq %0, %%db6\n"::"r" (0UL));
+
+		return (0);
+
+	case 'Y':
+		ptr = &remcomInBuffer[1];
+		kgdb_hex2long(&ptr, &breakno);
+		ptr++;
+		kgdb_hex2long(&ptr, &breaktype);
+		ptr++;
+		kgdb_hex2long(&ptr, &length);
+		ptr++;
+		kgdb_hex2long(&ptr, &addr);
+		if (set_hw_break(breakno & 0x3, breaktype & 0x3,
+				 length & 0x3, addr) == 0) {
+			strcpy(remcomOutBuffer, "OK");
+		} else {
+			strcpy(remcomOutBuffer, "ERROR");
+		}
+		break;
+
+		/* Remove hardware breakpoint */
+	case 'y':
+		ptr = &remcomInBuffer[1];
+		kgdb_hex2long(&ptr, &breakno);
+		if (remove_hw_break(breakno & 0x3) == 0) {
+			strcpy(remcomOutBuffer, "OK");
+		} else {
+			strcpy(remcomOutBuffer, "ERROR");
+		}
+		break;
+
+	}			/* switch */
+	return -1;		/* this means that we do not want to exit from the handler */
+}
+
+static struct pt_regs *in_interrupt_stack(unsigned long rsp, int cpu)
+{
+	struct pt_regs *regs;
+	unsigned long end = (unsigned long)cpu_pda[cpu].irqstackptr;
+	if (rsp <= end && rsp >= end - IRQSTACKSIZE + 8) {
+		regs = *(((struct pt_regs **)end) - 1);
+		return regs;
+	}
+	return NULL;
+}
+
+static struct pt_regs *in_exception_stack(unsigned long rsp, int cpu)
+{
+	int i;
+	struct tss_struct *init_tss = &per_cpu(init_tss,get_cpu());
+	for (i = 0; i < N_EXCEPTION_STACKS; i++)
+		if (rsp >= init_tss[cpu].ist[i] &&
+		    rsp <= init_tss[cpu].ist[i] + EXCEPTION_STKSZ) {
+			struct pt_regs *r =
+			    (void *)init_tss[cpu].ist[i] + EXCEPTION_STKSZ;
+			return r - 1;
+		}
+	return NULL;
+}
+
+void kgdb_shadowinfo(struct pt_regs *regs, char *buffer, unsigned threadid)
+{
+	static char intr_desc[] = "Stack at interrupt entrypoint";
+	static char exc_desc[] = "Stack at exception entrypoint";
+	struct pt_regs *stregs;
+	int cpu = hard_smp_processor_id();
+
+	if ((stregs = in_interrupt_stack(regs->rsp, cpu))) {
+		kgdb_mem2hex(intr_desc, buffer, strlen(intr_desc));
+	} else if ((stregs = in_exception_stack(regs->rsp, cpu))) {
+		kgdb_mem2hex(exc_desc, buffer, strlen(exc_desc));
+	}
+}
+
+struct task_struct *kgdb_get_shadow_thread(struct pt_regs *regs, int threadid)
+{
+	struct pt_regs *stregs;
+	int cpu = hard_smp_processor_id();
+
+	if ((stregs = in_interrupt_stack(regs->rsp, cpu))) {
+		return current;
+	} else if ((stregs = in_exception_stack(regs->rsp, cpu))) {
+		return current;
+	}
+	return NULL;
+}
+
+struct pt_regs *kgdb_shadow_regs(struct pt_regs *regs, int threadid)
+{
+	struct pt_regs *stregs;
+	int cpu = hard_smp_processor_id();
+
+	if ((stregs = in_interrupt_stack(regs->rsp, cpu))) {
+		return stregs;
+	} else if ((stregs = in_exception_stack(regs->rsp, cpu))) {
+		return stregs;
+	}
+	return NULL;
+}
+
+/* Register KGDB with the die_chain so that we hook into all of the right
+ * spots. */
+static int kgdb_notify(struct notifier_block *self, unsigned long cmd,
+		void *ptr)
+{
+        struct die_args *d = ptr;
+
+        if (cmd == DIE_DEBUG && user_mode(d->regs))
+                return NOTIFY_STOP;
+	else if (cmd == DIE_NMI_IPI) {
+		if (atomic_read(&debugger_active))
+			debugger_nmihook(smp_processor_id(), ptr);
+        } else
+		CHK_DEBUGGER(d->trapnr, d->signr, d->err, d->regs,);
+
+        return NOTIFY_STOP;
+}
+
+static struct notifier_block kgdb_notifier = {
+        .notifier_call = kgdb_notify,
+	.priority = 0x7fffffff, /* we need to notified first */
+};
+
+int kgdb_arch_init(void)
+{
+	notifier_chain_register(&die_chain, &kgdb_notifier);
+	return 0;
+}
+
+struct kgdb_arch arch_kgdb_ops = {
+	.gdb_bpt_instr = {0xcc},
+	.flags = KGDB_HW_BREAKPOINT,
+	.shadowth = 1,
+};
diff -puN arch/x86_64/kernel/traps.c~x86_64-lite arch/x86_64/kernel/traps.c
--- linux-2.6.10-rc1/arch/x86_64/kernel/traps.c~x86_64-lite	2004-10-29 11:26:45.750146248 -0700
+++ linux-2.6.10-rc1-trini/arch/x86_64/kernel/traps.c	2004-10-29 11:26:45.759144136 -0700
@@ -28,6 +28,7 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/debugger.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -642,7 +643,7 @@ asmlinkage void *do_debug(struct pt_regs
 	tsk->thread.debugreg6 = condition;
 
 	/* Mask out spurious TF errors due to lazy TF clearing */
-	if (condition & DR_STEP) {
+	if (condition & DR_STEP && !debugger_step) {
 		/*
 		 * The TF error should be masked out only if the current
 		 * process is not traced and if the TRAP flag has been set
diff -puN /dev/null include/asm-x86_64/kgdb.h
--- /dev/null	2004-10-25 00:35:20.587727328 -0700
+++ linux-2.6.10-rc1-trini/include/asm-x86_64/kgdb.h	2004-10-29 11:26:45.759144136 -0700
@@ -0,0 +1,56 @@
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
+/*
+ *  Note that this register image is in a different order than
+ *  the register image that Linux produces at interrupt time.
+ *
+ *  Linux's register image is defined by struct pt_regs in ptrace.h.
+ *  Just why GDB uses a different order is a historical mystery.
+ */
+
+enum regnames { _RAX,
+	_RDX,
+	_RCX,
+	_RBX,
+	_RSI,
+	_RDI,
+	_RBP,
+	_RSP,
+	_R8,
+	_R9,
+	_R10,
+	_R11,
+	_R12,
+	_R13,
+	_R14,
+	_R15,
+	_PC,
+	_PS,
+	_LASTREG = _PS
+};
+
+/* Number of bytes of registers.  */
+#define NUMREGBYTES (_LASTREG*8)
+
+#define BREAKPOINT() asm("   int $3");
+#define BREAK_INSTR_SIZE       1
+
+/*
+ * Call kgdb_process_breakpoint() only if the interrupt and exception
+ * stacks of x86_64 are setup.
+ */
+#define CHECK_EXCEPTION_STACK()        ((&per_cpu(init_tss, get_cpu ()))[0].ist[0])
+#endif				/* _ASM_KGDB_H_ */
diff -puN lib/Kconfig.debug~x86_64-lite lib/Kconfig.debug
--- linux-2.6.10-rc1/lib/Kconfig.debug~x86_64-lite	2004-10-29 11:26:45.753145544 -0700
+++ linux-2.6.10-rc1-trini/lib/Kconfig.debug	2004-10-29 11:32:54.317581029 -0700
@@ -115,7 +115,7 @@ endif
 
 config KGDB
 	bool "KGDB: kernel debugging with remote gdb"
-	depends on DEBUG_KERNEL && (X86 || MIPS32 || IA64 || ((!SMP || BROKEN) && PPC32))
+	depends on DEBUG_KERNEL && (X86 || MIPS32 || IA64 || X86_64 || ((!SMP || BROKEN) && PPC32))
 	help
 	  If you say Y here, it will be possible to remotely debug the
 	  kernel using gdb. This enlarges your kernel image disk size by
_
