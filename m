Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266665AbUBQWMl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 17:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266691AbUBQWMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 17:12:40 -0500
Received: from fed1mtao08.cox.net ([68.6.19.123]:4564 "EHLO fed1mtao08.cox.net")
	by vger.kernel.org with ESMTP id S266665AbUBQWE6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 17:04:58 -0500
Date: Tue, 17 Feb 2004 15:04:56 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Pavel Machek <pavel@suse.cz>
Subject: [PATCH][6/6] A different KGDB stub
Message-ID: <20040217220456.GG16881@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following is the x86_64-specific bits to this KGDB stub (Pavel, can
you give this a try please?  Thanks).

 arch/x86_64/Kconfig              |    5 
 arch/x86_64/kernel/Makefile      |    1 
 arch/x86_64/kernel/entry.S       |   41 ++
 arch/x86_64/kernel/irq.c         |    2 
 arch/x86_64/kernel/nmi.c         |   14 
 arch/x86_64/kernel/traps.c       |    3 
 arch/x86_64/kernel/x86_64-stub.c |  551 +++++++++++++++++++++++++++++++++++++++
 arch/x86_64/mm/fault.c           |    6 
 include/asm-x86_64/kgdb.h        |   57 ++++
 include/asm-x86_64/processor.h   |    1 
 include/asm-x86_64/system.h      |   50 +++
 11 files changed, 722 insertions(+), 9 deletions(-)
--- linux-2.6.3-rc4/arch/x86_64/Kconfig	2004-02-17 09:53:43.000000000 -0700
+++ linux-2.6.3-rc4-kgdb/arch/x86_64/Kconfig	2004-02-17 11:34:11.411950235 -0700
@@ -465,10 +465,7 @@ config IOMMU_LEAK
          Add a simple leak tracer to the IOMMU code. This is useful when you
 	 are debugging a buggy device driver that leaks IOMMU mappings.
        
-#config X86_REMOTE_DEBUG
-#       bool "kgdb debugging stub"
-
-endmenu
+source "kernel/Kconfig.kgdb"
 
 source "security/Kconfig"
 
--- linux-2.6.3-rc4/arch/x86_64/kernel/Makefile	2004-02-17 09:53:29.000000000 -0700
+++ linux-2.6.3-rc4-kgdb/arch/x86_64/kernel/Makefile	2004-02-17 11:34:09.374412669 -0700
@@ -24,6 +24,7 @@ obj-$(CONFIG_GART_IOMMU)	+= pci-gart.o a
 obj-$(CONFIG_DUMMY_IOMMU)	+= pci-nommu.o pci-dma.o
 
 obj-$(CONFIG_MODULES)		+= module.o
+obj-$(CONFIG_KGDB)		+= x86_64-stub.o
 
 obj-y				+= topology.o
 
--- linux-2.6.3-rc4/arch/x86_64/kernel/entry.S	2004-02-17 09:52:01.000000000 -0700
+++ linux-2.6.3-rc4-kgdb/arch/x86_64/kernel/entry.S	2004-02-17 11:33:57.472113993 -0700
@@ -219,7 +219,7 @@ sysret_careful:
 	jnc sysret_signal
 	sti
 	pushq %rdi
-	call schedule
+	call user_schedule
 	popq  %rdi
 	jmp sysret_check
 
@@ -288,7 +288,7 @@ int_careful:
 	jnc  int_very_careful
 	sti
 	pushq %rdi
-	call schedule
+	call user_schedule
 	popq %rdi
 	jmp int_with_check
 
@@ -482,7 +482,7 @@ retint_careful:
 	jnc   retint_signal
 	sti
 	pushq %rdi
-	call  schedule
+	call  user_schedule
 	popq %rdi		
 	GET_THREAD_INFO(%rcx)
 	cli
@@ -868,3 +868,38 @@ ENTRY(machine_check)
 ENTRY(call_debug)
        zeroentry do_call_debug
 
+#ifdef CONFIG_KGDB_THREAD
+ENTRY(kern_schedule)
+	subq $21*8,%rsp
+	movq %rax,10*8(%rsp)
+
+	movq %rsp,%rax
+	addq $21*8,%rax
+	movq %rax, 19*8(%rsp)
+
+	pushfq
+	popq 18*8(%rsp)
+
+	movq 21*8(%rsp),%rax
+	movq %rax,16*8(%rsp)
+
+	movq %rdi,14*8(%rsp)
+	movq %rsi,13*8(%rsp)
+	movq %rdx,12*8(%rsp)
+	movq %rcx,11*8(%rsp)
+
+	movq %r8, 9*8(%rsp)
+	movq %r9, 8*8(%rsp)
+	movq %r10,7*8(%rsp)
+	movq %r11,6*8(%rsp)
+	movq %rbx,5*8(%rsp) 
+	movq %rbp,4*8(%rsp) 
+	movq %r12,3*8(%rsp) 
+	movq %r13,2*8(%rsp) 
+	movq %r14,1*8(%rsp) 
+	movq %r15,(%rsp) 
+	call kern_do_schedule
+	movq 10*8(%rsp), %rax
+	addq $21*8,%rsp
+	ret
+#endif
--- linux-2.6.3-rc4/arch/x86_64/kernel/irq.c	2004-02-17 09:52:16.000000000 -0700
+++ linux-2.6.3-rc4-kgdb/arch/x86_64/kernel/irq.c	2004-02-17 11:33:59.629624327 -0700
@@ -405,6 +405,8 @@ out:
 	spin_unlock(&desc->lock);
 
 	irq_exit();
+
+	kgdb_process_breakpoint();
 	return 1;
 }
 
--- linux-2.6.3-rc4/arch/x86_64/kernel/nmi.c	2004-02-17 09:52:26.000000000 -0700
+++ linux-2.6.3-rc4-kgdb/arch/x86_64/kernel/nmi.c	2004-02-17 11:34:00.374455281 -0700
@@ -24,6 +24,7 @@
 #include <linux/module.h>
 #include <linux/sysdev.h>
 #include <linux/nmi.h>
+#include <linux/debugger.h>
 
 #include <asm/smp.h>
 #include <asm/mtrr.h>
@@ -317,13 +318,24 @@ void nmi_watchdog_tick (struct pt_regs *
 		return;
 
 	sum = read_pda(apic_timer_irqs);
-	if (last_irq_sums[cpu] == sum) {
+	if (atomic_read(&debugger_active)) {
+
+		/*
+		 * The machine is in debugger, hold this cpu if already
+		 * not held.
+		 */
+		debugger_nmihook(cpu, regs);
+		alert_counter[cpu] = 0;
+
+	} else if (last_irq_sums[cpu] == sum) {
+
 		/*
 		 * Ayiee, looks like this CPU is stuck ...
 		 * wait a few IRQs (5 seconds) before doing the oops ...
 		 */
 		alert_counter[cpu]++;
 		if (alert_counter[cpu] == 5*nmi_hz) {
+
 			if (notify_die(DIE_NMI, "nmi", regs, reason, 2, SIGINT) == NOTIFY_BAD) { 
 				alert_counter[cpu] = 0; 
 				return;
--- linux-2.6.3-rc4/arch/x86_64/kernel/traps.c	2004-02-17 09:49:51.000000000 -0700
+++ linux-2.6.3-rc4-kgdb/arch/x86_64/kernel/traps.c	2004-02-17 11:33:46.882517404 -0700
@@ -28,6 +28,7 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/debugger.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -614,7 +615,7 @@ asmlinkage void do_debug(struct pt_regs 
 	tsk->thread.debugreg6 = condition;
 
 	/* Mask out spurious TF errors due to lazy TF clearing */
-	if (condition & DR_STEP) {
+	if (condition & DR_STEP && !debugger_step) {
 		/*
 		 * The TF error should be masked out only if the current
 		 * process is not traced and if the TRAP flag has been set
--- linux-2.6.3-rc4/arch/x86_64/kernel/x86_64-stub.c	1969-12-31 17:00:00.000000000 -0700
+++ linux-2.6.3-rc4-kgdb/arch/x86_64/kernel/x86_64-stub.c	2004-02-17 11:33:54.511785866 -0700
@@ -0,0 +1,551 @@
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
+ *  Header: remcom.c,v 1.34 91/03/09 12:29:49 glenne Exp $
+ *
+ *  Module name: remcom.c $
+ *  Revision: 1.34 $
+ *  Date: 91/03/09 12:29:49 $
+ *  Contributor:     Lake Stevens Instrument Division$
+ *
+ *  Description:     low level support for gdb debugger. $
+ *
+ *  Considerations:  only works on target hardware $
+ *
+ *  Written by:      Glenn Engel $
+ *  Updated by:	     Amit Kale<akale@veritas.com>
+ *  ModuleState:     Experimental $
+ *
+ *  NOTES:           See Below $
+ *
+ *  Modified for 386 by Jim Kingdon, Cygnus Support.
+ *  Origianl kgdb, compatibility with 2.1.xx kernel by David Grothe <dave@gcom.com>
+ *  Integrated into 2.2.5 kernel by Tigran Aivazian <tigran@sco.com>
+ *      thread support,
+ *      support for multiple processors,
+ *  	support for ia-32(x86) hardware debugging,
+ *  	Console support,
+ *  	handling nmi watchdog
+ *  	Amit S. Kale ( amitkale@emsyssoft.com )
+ *
+ *  X86_64 changes from Andi Kleen's patch merged by Jim Houston
+ *
+ *
+ *  To enable debugger support, two things need to happen.  One, a
+ *  call to set_debug_traps() is necessary in order to allow any breakpoints
+ *  or error conditions to be properly intercepted and reported to gdb.
+ *  Two, a breakpoint needs to be generated to begin communication.  This
+ *  is most easily accomplished by a call to breakpoint().  Breakpoint()
+ *  simulates a breakpoint by executing an int 3.
+ *
+ *************
+ *
+ *    The following gdb commands are supported:
+ *
+ * command          function                               Return value
+ *
+ *    g             return the value of the CPU registers  hex data or ENN
+ *    G             set the value of the CPU registers     OK or ENN
+ *
+ *    mAA..AA,LLLL  Read LLLL bytes at address AA..AA      hex data or ENN
+ *    MAA..AA,LLLL: Write LLLL bytes at address AA.AA      OK or ENN
+ *
+ *    c             Resume at current address              SNN   ( signal NN)
+ *    cAA..AA       Continue at address AA..AA             SNN
+ *
+ *    s             Step one instruction                   SNN
+ *    sAA..AA       Step one instruction from AA..AA       SNN
+ *
+ *    k             kill
+ *
+ *    ?             What was the last sigval ?             SNN   (signal NN)
+ *
+ * All commands and responses are sent with a packet which includes a
+ * checksum.  A packet consists of
+ *
+ * $<packet info>#<checksum>.
+ *
+ * where
+ * <packet info> :: <characters representing the command or response>
+ * <checksum>    :: < two hex digits computed as modulo 256 sum of <packetinfo>>
+ *
+ * When a packet is received, it is first acknowledged with either '+' or '-'.
+ * '+' indicates a successful transfer.  '-' indicates a failed transfer.
+ *
+ * Example:
+ *
+ * Host:                  Reply:
+ * $m0,10#2a               +$00010203040506070809101112131415#42
+ *
+ ****************************************************************************/
+
+#include <linux/string.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/smp.h>
+#include <linux/spinlock.h>
+#include <linux/delay.h>
+#include <asm/system.h>
+#include <asm/ptrace.h>			/* for linux pt_regs struct */
+#include <linux/kgdb.h>
+#ifdef CONFIG_GDB_CONSOLE
+#include <linux/console.h>
+#endif
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
+#if KGDB_MAX_NO_CPUS != 8
+#error change the definition of slavecpulocks
+#endif
+
+void regs_to_gdb_regs(unsigned long *gdb_regs, struct pt_regs *regs)
+{
+	gdb_regs[_RAX] =  regs->rax;
+	gdb_regs[_RBX] =  regs->rbx;
+	gdb_regs[_RCX] =  regs->rcx;
+	gdb_regs[_RDX] =  regs->rdx;
+	gdb_regs[_RSI] =  regs->rsi;
+	gdb_regs[_RDI] =  regs->rdi;
+	gdb_regs[_RBP] =  regs->rbp;
+	gdb_regs[ _PS] =  regs->eflags;
+	gdb_regs[ _PC] =  regs->rip;
+	gdb_regs[ _R8] =  regs->r8;
+	gdb_regs[ _R9] =  regs->r9;
+	gdb_regs[_R10] = regs->r10;
+	gdb_regs[_R11] = regs->r11;
+	gdb_regs[_R12] = regs->r12;
+	gdb_regs[_R13] = regs->r13;
+	gdb_regs[_R14] = regs->r14;
+	gdb_regs[_R15] = regs->r15;
+	gdb_regs[_RSP] =  regs->rsp;
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
+	gdb_regs[ _PS] = 0;
+	gdb_regs[ _PC] = (unsigned long) __switch_to;
+	gdb_regs[ _R8] = 0;
+	gdb_regs[ _R9] = 0;
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
+	regs->rax	=     gdb_regs[_RAX] ;
+	regs->rbx	=     gdb_regs[_RBX] ;
+	regs->rcx	=     gdb_regs[_RCX] ;
+	regs->rdx	=     gdb_regs[_RDX] ;
+	regs->rsi	=     gdb_regs[_RSI] ;
+	regs->rdi	=     gdb_regs[_RDI] ;
+	regs->rbp	=     gdb_regs[_RBP] ;
+	regs->eflags=     gdb_regs[ _PS] ;
+	regs->rip	=     gdb_regs[ _PC] ;
+	regs->r8	=     gdb_regs[ _R8] ;
+	regs->r9	=     gdb_regs[ _R9] ;
+	regs->r10	=     gdb_regs[ _R10] ;
+	regs->r11    =     gdb_regs[ _R11] ;
+	regs->r12	=     gdb_regs[ _R12] ;
+	regs->r13	=     gdb_regs[ _R13] ;
+	regs->r14	=     gdb_regs[ _R14] ;
+	regs->r15	=     gdb_regs[ _R15] ;
+#if 0					/* can't change these */
+	regs->rsp	=     gdb_regs[_RSP] ;
+	regs->ss	=     gdb_regs[ _SS] ;
+	regs->fs	=     gdb_regs[ _FS] ;
+	regs->gs	=     gdb_regs[ _GS] ;
+#endif
+
+} /* gdb_regs_to_regs */
+
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
+	asm volatile ("movq %%db7, %0\n":"=r" (dr7) :);
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
+int kgdb_remove_hw_break(unsigned long addr, int type)
+{
+	int i, idx = -1;
+	for (i = 0; i < 4; i ++) {
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
+int kgdb_set_hw_break(unsigned long addr, int type)
+{
+	int i, idx = -1;
+	for (i = 0; i < 4; i ++) {
+		if (!breakinfo[i].enabled) {
+			idx = i;
+			break;
+		}
+	}
+	if (idx == -1)
+		return -1;
+
+	breakinfo[idx].enabled = 1;
+	breakinfo[idx].type = type;
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
+int set_hw_break(unsigned breakno,
+		 unsigned type, unsigned len, unsigned addr)
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
+void kgdb_printexceptioninfo(int exceptionNo, int errorcode, char *buffer)
+{
+	unsigned long	dr6;
+	int		i;
+	switch (exceptionNo) {
+	case 1:		/* debug exception */
+		break;
+	case 3:		/* breakpoint */
+		sprintf(buffer, "Software breakpoint");
+		return;
+	default:
+		sprintf(buffer, "Details not available");
+		return;
+	}
+	asm volatile ("movq %%db6, %0\n":"=r" (dr6)
+		      :);
+	if (dr6 & 0x4000) {
+		sprintf(buffer, "Single step");
+		return;
+	}
+	for (i = 0; i < 4; ++i) {
+		if (dr6 & (1 << i)) {
+			sprintf(buffer, "Hardware breakpoint %d", i);
+			return;
+		}
+	}
+	sprintf(buffer, "Unknown trap");
+	return;
+}
+
+void kgdb_disable_hw_debug(struct pt_regs *regs) 
+{
+	/* Disable hardware debugging while we are in kgdb */
+	asm volatile("movq %0,%%db7": /* no output */ : "r"(0UL));
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
+                                 char *remcomInBuffer, char *remcomOutBuffer,
+                                 struct pt_regs *linux_regs)
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
+		kgdb_contthread = NULL;
+
+		/* try to read optional parameter, pc unchanged if no parm */
+		ptr = &remcomInBuffer[1];
+		if (kgdb_hex2long(&ptr, &addr)) {
+			linux_regs->rip = addr;
+		} 
+		newPC = linux_regs->rip;
+		
+		/* clear the trace bit */
+		linux_regs->eflags &= 0xfffffeff;
+
+		/* set the trace bit if we're stepping */
+		if (remcomInBuffer[0] == 's') {
+			linux_regs->eflags |= 0x100;
+			debugger_step = 1;
+		}
+
+		asm volatile ("movq %%db6, %0\n" : "=r" (dr6));
+		if (!(dr6 & 0x4000)) {
+			for (breakno = 0; breakno < 4; ++breakno) {
+				if (dr6 & (1 << breakno)) {
+					if (breakinfo[breakno].type == 0) {
+						/* Set restore flag */
+						linux_regs->eflags |= 0x10000;
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
+	}		/* switch */
+	return -1; /* this means that we do not want to exit from the handler */
+}
+
+static struct pt_regs *in_interrupt_stack(unsigned long rsp, int cpu) 
+{ 
+	struct pt_regs *regs;
+	unsigned long end = (unsigned long) cpu_pda[cpu].irqstackptr; 
+	if (rsp <= end  && 
+	    rsp >= end - IRQSTACKSIZE + 8) { 
+		regs = *(((struct pt_regs **)end) -1);
+		return regs;
+	} 
+	return NULL; 
+} 
+
+static struct pt_regs *in_exception_stack(unsigned long rsp, int cpu)
+{ 
+	int i;
+	for (i = 0; i < N_EXCEPTION_STACKS; i++) 
+	       if (rsp >= init_tss[cpu].ist[i] && 
+		   rsp <= init_tss[cpu].ist[i] + EXCEPTION_STKSZ) {
+		       struct pt_regs *r = (void *)init_tss[cpu].ist[i] + EXCEPTION_STKSZ;
+		       return r-1; 
+	       } 
+	return NULL;
+} 
+
+static void kgdb_shadowinfo(struct pt_regs *regs, char *buffer,
+		unsigned threadid)
+{
+	static char intr_desc[] = "Stack at interrupt entrypoint";
+	static char exc_desc[] = "Stack at exception entrypoint";
+	struct pt_regs *stregs;
+	int cpu = hard_smp_processor_id();
+
+	if ((stregs = in_interrupt_stack(regs->rsp, cpu))) {
+		kgdb_mem2hex(intr_desc, buffer, strlen(intr_desc), 0);
+	} else if ((stregs = in_exception_stack(regs->rsp, cpu))) {
+		kgdb_mem2hex(exc_desc, buffer, strlen(exc_desc), 0);
+	}
+}
+
+static struct task_struct *kgdb_get_shadow_thread(struct pt_regs *regs,
+		int threadid)
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
+static struct pt_regs *kgdb_shadow_regs(struct pt_regs *regs, int threadid)
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
+        if (!kgdb_connected || (cmd == DIE_DEBUG && user_mode(d->regs)))
+                return NOTIFY_DONE;
+        if (cmd == DIE_NMI_IPI) {
+                if (atomic_read(debugger_active))
+                        return NOTIFY_BAD;
+        } else if ((*linux_debug_hook)(d->trapnr, d->signr, d->err, d->regs))
+                return NOTIFY_BAD; /* skip */
+
+        return NOTIFY_DONE;
+}
+
+static struct notifier_block kgdb_notifier = {
+        .notifier_call = kgdb_notify,
+};
+
+int kgdb_arch_init(void)
+{
+	notifier_chain_register(&die_chain, &kgdb_notifier);
+}
+
+struct kgdb_arch arch_kgdb_ops =  {
+	.gdb_bpt_instr = {0xcc},
+	.flags = KGDB_HW_BREAKPOINT,
+	.shadowth = 1,
+};
--- linux-2.6.3-rc4/arch/x86_64/mm/fault.c	2004-02-17 09:50:05.000000000 -0700
+++ linux-2.6.3-rc4-kgdb/arch/x86_64/mm/fault.c	2004-02-17 11:33:47.025484956 -0700
@@ -23,6 +23,7 @@
 #include <linux/vt_kern.h>		/* For unblank_screen() */
 #include <linux/compiler.h>
 #include <linux/module.h>
+#include <linux/debugger.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -290,6 +291,11 @@ asmlinkage void do_page_fault(struct pt_
 		return;
 
  again:
+	if (debugger_memerr_expected) {
+		/* This fault was caused by memory access through a debugger.
+		 * Don't handle it like user accesses */
+		goto no_context;
+	}
 	down_read(&mm->mmap_sem);
 
 	vma = find_vma(mm, address);
--- linux-2.6.3-rc4/include/asm-x86_64/kgdb.h	1969-12-31 17:00:00.000000000 -0700
+++ linux-2.6.3-rc4-kgdb/include/asm-x86_64/kgdb.h	2004-02-17 11:34:07.822764827 -0700
@@ -0,0 +1,57 @@
+#ifndef _ASM_KGDB_H_
+#define _ASM_KGDB_H_
+
+/*
+ * Copyright (C) 2001-2004 Amit S. Kale
+ */
+
+#include <linux/ptrace.h>
+
+/* gdb locks */
+#define KGDB_MAX_NO_CPUS 8
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
+enum regnames {_RAX,	
+	       _RDX,
+	       _RCX,
+	       _RBX,
+	       _RSI,		
+	       _RDI,		
+	       _RBP,	       
+	       _RSP,		
+	       _R8,
+	       _R9,
+	       _R10,
+	       _R11,
+	       _R12,
+	       _R13,
+	       _R14,
+	       _R15,
+	       _PC, 		
+	       _PS,
+	       _LASTREG=_PS }; 
+
+#define PC_REGNUM	_PC	/* Program Counter */
+#define SP_REGNUM	_RSP	/* Stack Pointer */
+#define PTRACE_PC	rip	/* Program Counter, in ptrace regs. */
+
+/* Number of bytes of registers.  */
+#define NUMREGBYTES (_LASTREG*8)
+
+#define BREAKPOINT() asm("   int $3");
+#define BREAK_INSTR_SIZE       1
+
+#endif /* _ASM_KGDB_H_ */
--- linux-2.6.3-rc4/include/asm-x86_64/processor.h	2004-02-17 09:54:25.000000000 -0700
+++ linux-2.6.3-rc4-kgdb/include/asm-x86_64/processor.h	2004-02-17 11:34:27.054400086 -0700
@@ -252,6 +252,7 @@ struct thread_struct {
 	unsigned long	*io_bitmap_ptr;
 /* cached TLS descriptors. */
 	u64 tls_array[GDT_ENTRY_TLS_ENTRIES];
+	void		*debuggerinfo;
 };
 
 #define INIT_THREAD  {}
--- linux-2.6.3-rc4/include/asm-x86_64/system.h	2004-02-17 09:53:49.000000000 -0700
+++ linux-2.6.3-rc4-kgdb/include/asm-x86_64/system.h	2004-02-17 11:34:20.762827993 -0700
@@ -19,6 +19,56 @@
 #define __SAVE(reg,offset) "movq %%" #reg ",(14-" #offset ")*8(%%rsp)\n\t"
 #define __RESTORE(reg,offset) "movq (14-" #offset ")*8(%%rsp),%%" #reg "\n\t"
 
+/* #ifdef CONFIG_KGDB */
+
+/* full frame for the debug stub */
+/* Should be replaced with a dwarf2 cie/fde description, then gdb could
+   figure it out all by itself. */
+struct save_context_frame { 
+	unsigned long rbp; 
+	unsigned long rbx;
+	unsigned long r11;
+	unsigned long r10;
+	unsigned long r9;
+	unsigned long r8;
+	unsigned long rcx;
+	unsigned long rdx;	
+	unsigned long r15;
+	unsigned long r14;
+	unsigned long r13;
+	unsigned long r12;
+	unsigned long rdi;
+	unsigned long rsi;
+	unsigned long flags;
+}; 
+
+#if 0
+#define SAVE_CONTEXT \
+	"pushfq\n\t"							\
+	"subq $14*8,%%rsp\n\t" 						\
+	__SAVE(rbx, 12) __SAVE(rdi,  1)					\
+	__SAVE(rdx,  6) __SAVE(rcx,  7)					\
+	__SAVE(r8,   8) __SAVE(r9,   9)					\
+	__SAVE(r12,  2) __SAVE(r13,  3)					\
+	__SAVE(r14,  4) __SAVE(r15,  5)					\
+	__SAVE(r10, 10) __SAVE(r11, 11)					\
+	__SAVE(rsi, 0)  __SAVE(rbp, 13) 				\
+
+
+#define RESTORE_CONTEXT \
+	__RESTORE(rbx, 12) __RESTORE(rdi,  1) 					\
+	__RESTORE(rdx,  6) __RESTORE(rcx,  7)					\
+	__RESTORE(r12,  2) __RESTORE(r13,  3)					\
+	__RESTORE(r14,  4) __RESTORE(r15,  5)					\
+	__RESTORE(r10, 10) __RESTORE(r11, 11)					\
+	__RESTORE(r8,   8) __RESTORE(r9,   9)					\
+	__RESTORE(rbp, 13) __RESTORE(rsi, 0) 		   		        \
+	"addq $14*8,%%rsp\n\t" 							\
+	"popfq\n\t"
+
+#define __EXTRA_CLOBBER 
+
+#else
 /* frame pointer must be last for get_wchan */
 #define SAVE_CONTEXT    "pushfq ; pushq %%rbp ; movq %%rsi,%%rbp\n\t"
 #define RESTORE_CONTEXT "movq %%rbp,%%rsi ; popq %%rbp ; popfq\n\t" 

-- 
Tom Rini
http://gate.crashing.org/~trini/
