Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266311AbUBLAJF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 19:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266301AbUBLAIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 19:08:45 -0500
Received: from fed1mtao04.cox.net ([68.6.19.241]:49821 "EHLO
	fed1mtao04.cox.net") by vger.kernel.org with ESMTP id S266170AbUBLADo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 19:03:44 -0500
Date: Wed, 11 Feb 2004 17:03:42 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][4/6] A different KGDB stub
Message-ID: <20040212000342.GE19676@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following is the i386-specific bits to this KGDB stub.

 arch/i386/Kconfig            |    2 
 arch/i386/kernel/Makefile    |    1 
 arch/i386/kernel/entry.S     |   39 +++
 arch/i386/kernel/i386-stub.c |  442 +++++++++++++++++++++++++++++++++++++++++++
 arch/i386/kernel/irq.c       |    9 
 arch/i386/kernel/nmi.c       |   14 +
 arch/i386/kernel/signal.c    |    3 
 arch/i386/kernel/traps.c     |   20 +
 arch/i386/mm/fault.c         |   15 +
 include/asm-i386/kgdb.h      |   53 +++++
 include/asm-i386/processor.h |    1 
 11 files changed, 586 insertions(+), 13 deletions(-)
--- a/arch/i386/Kconfig	Wed Feb 11 15:41:51 2004
+++ b/arch/i386/Kconfig	Wed Feb 11 15:41:51 2004
@@ -1361,6 +1361,8 @@
 	  If you say Y here, various routines which may sleep will become very
 	  noisy if they are called with a spinlock held.	
 
+source "kernel/Kconfig.kgdb"
+
 config FRAME_POINTER
 	bool "Compile the kernel with frame pointers"
 	help
--- a/arch/i386/kernel/Makefile	Wed Feb 11 15:41:51 2004
+++ b/arch/i386/kernel/Makefile	Wed Feb 11 15:41:51 2004
@@ -32,6 +32,7 @@
 obj-$(CONFIG_HPET_TIMER) 	+= time_hpet.o
 obj-$(CONFIG_EFI) 		+= efi.o efi_stub.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
+obj-$(CONFIG_KGDB)		+= i386-stub.o
 
 EXTRA_AFLAGS   := -traditional
 
--- a/arch/i386/kernel/entry.S	Wed Feb 11 15:41:51 2004
+++ b/arch/i386/kernel/entry.S	Wed Feb 11 15:41:51 2004
@@ -330,7 +330,7 @@
 	jz restore_all
 	movl $PREEMPT_ACTIVE,TI_preempt_count(%ebp)
 	sti
-	call schedule
+	call user_schedule
 	movl $0,TI_preempt_count(%ebp)
 	cli
 	jmp need_resched
@@ -438,7 +438,7 @@
 	testb $_TIF_NEED_RESCHED, %cl
 	jz work_notifysig
 work_resched:
-	call schedule
+	call user_schedule
 	cli				# make sure we don't miss an interrupt
 					# setting need_resched or sigpending
 					# between sampling and the iret
@@ -545,7 +545,17 @@
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
@@ -758,6 +768,31 @@
 	jmp error_code
 
 .previous
+
+#ifdef CONFIG_KGDB_THREAD
+ENTRY(kern_schedule)
+	pushl	%ebp
+	movl	%esp, %ebp
+	pushl	%ss		
+	pushl	%ebp
+	pushfl
+	pushl	%cs
+	pushl	4(%ebp)
+	pushl	%eax		
+	pushl	%es
+	pushl	%ds
+	pushl	%eax
+	pushl	(%ebp)
+	pushl	%edi
+	pushl	%esi
+	pushl	%edx
+	pushl	%ecx
+	pushl	%ebx
+	call	kern_do_schedule
+	movl	%ebp, %esp
+	pop	%ebp
+	ret
+#endif
 
 .data
 ENTRY(sys_call_table)
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/i386/kernel/i386-stub.c	Wed Feb 11 15:41:51 2004
@@ -0,0 +1,442 @@
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
+#include <asm/vm86.h>
+#include <asm/system.h>
+#include <asm/ptrace.h>			/* for linux pt_regs struct */
+#include <linux/kgdb.h>
+#ifdef CONFIG_GDB_CONSOLE
+#include <linux/console.h>
+#endif
+#include <linux/init.h>
+#include <linux/debugger.h>
+
+/* Put the error code here just in case the user cares.  */
+int gdb_i386errcode;
+/* Likewise, the vector number here (since GDB only gets the signal
+   number through the usual means, and that's not very specific).  */
+int gdb_i386vector = -1;
+
+#if KGDB_MAX_NO_CPUS != 8
+#error change the definition of slavecpulocks
+#endif
+
+void regs_to_gdb_regs(unsigned long *gdb_regs, struct pt_regs *regs)
+{
+    gdb_regs[_EAX] =  regs->eax;
+    gdb_regs[_EBX] =  regs->ebx;
+    gdb_regs[_ECX] =  regs->ecx;
+    gdb_regs[_EDX] =  regs->edx;
+    gdb_regs[_ESI] =  regs->esi;
+    gdb_regs[_EDI] =  regs->edi;
+    gdb_regs[_EBP] =  regs->ebp;
+    gdb_regs[ _DS] =  regs->xds;
+    gdb_regs[ _ES] =  regs->xes;
+    gdb_regs[ _PS] =  regs->eflags;
+    gdb_regs[ _CS] =  regs->xcs;
+    gdb_regs[ _PC] =  regs->eip;
+    gdb_regs[_ESP] =  (int) (&regs->esp) ;
+    gdb_regs[ _SS] =  __KERNEL_DS;
+    gdb_regs[ _FS] =  0xFFFF;
+    gdb_regs[ _GS] =  0xFFFF;
+}
+
+void sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct task_struct *p)
+{
+	gdb_regs[_EAX] = 0;
+	gdb_regs[_EBX] = 0;
+	gdb_regs[_ECX] = 0;
+	gdb_regs[_EDX] = 0;
+	gdb_regs[_ESI] = 0;
+	gdb_regs[_EDI] = 0;
+	gdb_regs[_EBP] = *(int *)p->thread.esp;
+	gdb_regs[_DS]  = __KERNEL_DS;
+	gdb_regs[_ES]  = __KERNEL_DS;
+	gdb_regs[_PS]  = 0;
+	gdb_regs[_CS]  = __KERNEL_CS;
+	gdb_regs[_PC]  = p->thread.eip;
+	gdb_regs[_ESP] = p->thread.esp;
+	gdb_regs[_SS]  = __KERNEL_DS;
+	gdb_regs[_FS]  = 0xFFFF;
+	gdb_regs[_GS]  = 0xFFFF;
+}
+
+void gdb_regs_to_regs(unsigned long *gdb_regs, struct pt_regs *regs)
+{
+    regs->eax	=     gdb_regs[_EAX] ;
+    regs->ebx	=     gdb_regs[_EBX] ;
+    regs->ecx	=     gdb_regs[_ECX] ;
+    regs->edx	=     gdb_regs[_EDX] ;
+    regs->esi	=     gdb_regs[_ESI] ;
+    regs->edi	=     gdb_regs[_EDI] ;
+    regs->ebp	=     gdb_regs[_EBP] ;
+    regs->xds	=     gdb_regs[ _DS] ;
+    regs->xes	=     gdb_regs[ _ES] ;
+    regs->eflags=     gdb_regs[ _PS] ;
+    regs->xcs	=     gdb_regs[ _CS] ;
+    regs->eip	=     gdb_regs[ _PC] ;
+#if 0					/* can't change these */
+    regs->esp	=     gdb_regs[_ESP] ;
+    regs->xss	=     gdb_regs[ _SS] ;
+    regs->fs	=     gdb_regs[ _FS] ;
+    regs->gs	=     gdb_regs[ _GS] ;
+#endif
+
+}
+
+struct hw_breakpoint {
+	unsigned enabled;
+	unsigned type;
+	unsigned len;
+	unsigned addr;
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
+	unsigned	dr6;
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
+	asm volatile ("movl %%db6, %0\n":"=r" (dr6)
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
+	asm volatile("movl %0,%%db7": /* no output */ : "r"(0));
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
+		int err_code, char *remcomInBuffer, char *remcomOutBuffer,
+		struct pt_regs *linux_regs)
+{
+	long addr, length;
+	long breakno, breaktype;
+	char *ptr;
+	int newPC;
+	int dr6;
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
+		if (kgdb_hexToLong(&ptr, &addr)) {
+			linux_regs->eip = addr;
+		} 
+		newPC = linux_regs->eip;
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
+		asm volatile ("movl %%db6, %0\n" : "=r" (dr6));
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
+		asm volatile ("movl %0, %%db6\n"::"r" (0));
+
+		return (0);
+
+	case 'Y':
+		ptr = &remcomInBuffer[1];
+		kgdb_hexToLong(&ptr, &breakno);
+		ptr++;
+		kgdb_hexToLong(&ptr, &breaktype);
+		ptr++;
+		kgdb_hexToLong(&ptr, &length);
+		ptr++;
+		kgdb_hexToLong(&ptr, &addr);
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
+		kgdb_hexToLong(&ptr, &breakno);
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
+struct kgdb_arch arch_kgdb_ops =  {
+	.gdb_bpt_instr = {0xcc},
+	.flags = KGDB_HW_BREAKPOINT,
+};
--- a/arch/i386/kernel/irq.c	Wed Feb 11 15:41:51 2004
+++ b/arch/i386/kernel/irq.c	Wed Feb 11 15:41:51 2004
@@ -36,6 +36,7 @@
 #include <linux/kallsyms.h>
 #include <linux/notifier.h>
 #include <linux/cpu.h>
+#include <linux/kgdb.h>
 
 #include <asm/atomic.h>
 #include <asm/io.h>
@@ -412,7 +413,7 @@
  * SMP cross-CPU interrupts have their own specific
  * handlers).
  */
-asmlinkage unsigned int do_IRQ(struct pt_regs regs)
+asmlinkage unsigned int do_IRQ(struct pt_regs *regs)
 {	
 	/* 
 	 * We ack quickly, we don't want the irq controller
@@ -424,7 +425,7 @@
 	 * 0 return value means that this irq is already being
 	 * handled by some other CPU. (or is disabled)
 	 */
-	int irq = regs.orig_eax & 0xff; /* high bits used in ret_from_ code  */
+	int irq = regs->orig_eax & 0xff; /* high bits used in ret_from_ code  */
 	irq_desc_t *desc = irq_desc + irq;
 	struct irqaction * action;
 	unsigned int status;
@@ -490,7 +491,7 @@
 		irqreturn_t action_ret;
 
 		spin_unlock(&desc->lock);
-		action_ret = handle_IRQ_event(irq, &regs, action);
+		action_ret = handle_IRQ_event(irq, regs, action);
 		spin_lock(&desc->lock);
 		if (!noirqdebug)
 			note_interrupt(irq, desc, action_ret);
@@ -509,6 +510,8 @@
 	spin_unlock(&desc->lock);
 
 	irq_exit();
+
+	kgdb_process_breakpoint();
 
 	return 1;
 }
--- a/arch/i386/kernel/nmi.c	Wed Feb 11 15:41:51 2004
+++ b/arch/i386/kernel/nmi.c	Wed Feb 11 15:41:51 2004
@@ -25,6 +25,7 @@
 #include <linux/module.h>
 #include <linux/nmi.h>
 #include <linux/sysdev.h>
+#include <linux/debugger.h>
 
 #include <asm/smp.h>
 #include <asm/mtrr.h>
@@ -420,14 +421,25 @@
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
--- a/arch/i386/kernel/signal.c	Wed Feb 11 15:41:51 2004
+++ b/arch/i386/kernel/signal.c	Wed Feb 11 15:41:51 2004
@@ -578,7 +578,8 @@
 		 * have been cleared if the watchpoint triggered
 		 * inside the kernel.
 		 */
-		__asm__("movl %0,%%db7"	: : "r" (current->thread.debugreg[7]));
+		if (current->thread.debugreg[7])
+			__asm__("movl %0,%%db7"	: : "r" (current->thread.debugreg[7]));
 
 		/* Whee!  Actually deliver the signal.  */
 		handle_signal(signr, &info, oldset, regs);
--- a/arch/i386/kernel/traps.c	Wed Feb 11 15:41:51 2004
+++ b/arch/i386/kernel/traps.c	Wed Feb 11 15:41:51 2004
@@ -51,6 +51,7 @@
 
 #include <linux/irq.h>
 #include <linux/module.h>
+#include <linux/debugger.h>
 
 #include "mach_traps.h"
 
@@ -258,6 +259,7 @@
 	static int die_counter;
 	int nl = 0;
 
+	CHK_DEBUGGER(1,SIGTRAP,err,regs,)
 	console_verbose();
 	spin_lock_irq(&die_lock);
 	bust_spinlocks(1);
@@ -346,6 +348,7 @@
 #define DO_ERROR(trapnr, signr, str, name) \
 asmlinkage void do_##name(struct pt_regs * regs, long error_code) \
 { \
+	CHK_DEBUGGER(trapnr,signr,error_code,regs,)\
 	do_trap(trapnr, signr, str, 0, regs, error_code, NULL); \
 }
 
@@ -363,7 +366,9 @@
 #define DO_VM86_ERROR(trapnr, signr, str, name) \
 asmlinkage void do_##name(struct pt_regs * regs, long error_code) \
 { \
+	CHK_DEBUGGER(trapnr,signr,error_code,regs,goto skip_trap)\
 	do_trap(trapnr, signr, str, 1, regs, error_code, NULL); \
+skip_trap: \
 	return; \
 }
 
@@ -572,7 +577,7 @@
 	tsk->thread.debugreg[6] = condition;
 
 	/* Mask out spurious TF errors due to lazy TF clearing */
-	if (condition & DR_STEP) {
+	if (condition & DR_STEP && !debugger_step) {
 		/*
 		 * The TF error should be masked out only if the current
 		 * process is not traced and if the TRAP flag has been set
@@ -595,11 +600,13 @@
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
@@ -609,6 +616,7 @@
 	__asm__("movl %0,%%db7"
 		: /* no output */
 		: "r" (0));
+	CHK_DEBUGGER(1,SIGTRAP,error_code,regs,)
 	return;
 
 debug_vm86:
--- a/arch/i386/mm/fault.c	Wed Feb 11 15:41:51 2004
+++ b/arch/i386/mm/fault.c	Wed Feb 11 15:41:51 2004
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
@@ -289,6 +295,12 @@
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
@@ -426,12 +438,15 @@
  	if (is_prefetch(regs, address))
  		return;
 
+	CHK_DEBUGGER(14, SIGSEGV,error_code, regs,)
+
 /*
  * Oops. The kernel tried to access some bad page. We'll have to
  * terminate things with extreme prejudice.
  */
 
 	bust_spinlocks(1);
+
 
 	if (address < PAGE_SIZE)
 		printk(KERN_ALERT "Unable to handle kernel NULL pointer dereference");
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-i386/kgdb.h	Wed Feb 11 15:41:51 2004
@@ -0,0 +1,53 @@
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
+/* Number of bytes of registers.  */
+#define NUMREGBYTES 64
+/*
+ *  Note that this register image is in a different order than
+ *  the register image that Linux produces at interrupt time.
+ *  
+ *  Linux's register image is defined by struct pt_regs in ptrace.h.
+ *  Just why GDB uses a different order is a historical mystery.
+ */
+enum regnames { _EAX,  /* 0 */
+	_ECX,  /* 1 */
+	_EDX,  /* 2 */
+	_EBX,  /* 3 */
+	_ESP,  /* 4 */
+	_EBP,  /* 5 */
+	_ESI,  /* 6 */
+	_EDI,  /* 7 */
+	_PC,   /* 8 also known as eip */
+	_PS,   /* 9 also known as eflags */
+	_CS,   /* 10 */
+	_SS,   /* 11 */
+	_DS,   /* 12 */
+	_ES,   /* 13 */
+	_FS,   /* 14 */
+	_GS    /* 15 */
+};
+
+#define PC_REGNUM	_PC	/* Program Counter */
+#define SP_REGNUM	_ESP	/* Stack Pointer */
+#define PTRACE_PC	eip	/* Program Counter, in ptrace regs. */
+
+#define BREAKPOINT() asm("   int $3");
+#define BREAK_INSTR_SIZE       1
+
+#endif /* _ASM_KGDB_H_ */
--- a/include/asm-i386/processor.h	Wed Feb 11 15:41:51 2004
+++ b/include/asm-i386/processor.h	Wed Feb 11 15:41:51 2004
@@ -423,6 +423,7 @@
 	unsigned int		saved_fs, saved_gs;
 /* IO permissions */
 	unsigned long	*io_bitmap_ptr;
+	void *		debuggerinfo;
 };
 
 #define INIT_THREAD  {							\

-- 
Tom Rini
http://gate.crashing.org/~trini/
