Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751093AbVH2QJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbVH2QJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 12:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbVH2QJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 12:09:28 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:28035 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751093AbVH2QJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 12:09:25 -0400
Subject: [patch 03/16] Add support for PowerPC32 platforms to KGDB
Date: Mon, 29 Aug 2005 09:09:23 -0700
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, trini@kernel.crashing.org, paulus@samba.org,
       kato.takeharu@jp.fujitsu.com
From: Tom Rini <trini@kernel.crashing.org>
Message-Id: <resend.3.2982005.trini@kernel.crashing.org>
In-Reply-To: <resend.2.2982005.trini@kernel.crashing.org>
References: <resend.2.2982005.trini@kernel.crashing.org> <1.2982005.trini@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This adds basic KGDB support to ppc32 (classic, e500 and 4xx), and support
for kgdb8250 to a number of boards.  This was done mostly myself with some
help from Scott Hall for e500 and Frank Rowand pointed out some parts as he
did the ppc64 code, as well as Takeharu KATO <kato.takeharu@jp.fujitsu.com>
for some of the 4xx code and testing.

Index: linux-2.6.13/arch/ppc/Kconfig.debug
===================================================================
--- linux-2.6.13.orig/arch/ppc/Kconfig.debug
+++ linux-2.6.13/arch/ppc/Kconfig.debug
@@ -2,42 +2,6 @@ menu "Kernel hacking"
 
 source "lib/Kconfig.debug"
 
-config KGDB
-	bool "Include kgdb kernel debugger"
-	depends on DEBUG_KERNEL && (BROKEN || PPC_GEN550 || 4xx)
-	select DEBUG_INFO
-	help
-	  Include in-kernel hooks for kgdb, the Linux kernel source level
-	  debugger.  See <http://kgdb.sourceforge.net/> for more information.
-	  Unless you are intending to debug the kernel, say N here.
-
-choice
-	prompt "Serial Port"
-	depends on KGDB
-	default KGDB_TTYS1
-
-config KGDB_TTYS0
-	bool "ttyS0"
-
-config KGDB_TTYS1
-	bool "ttyS1"
-
-config KGDB_TTYS2
-	bool "ttyS2"
-
-config KGDB_TTYS3
-	bool "ttyS3"
-
-endchoice
-
-config KGDB_CONSOLE
-	bool "Enable serial console thru kgdb port"
-	depends on KGDB && 8xx || CPM2
-	help
-	  If you enable this, all serial console messages will be sent
-	  over the gdb stub.
-	  If unsure, say N.
-
 config XMON
 	bool "Include xmon kernel debugger"
 	depends on DEBUG_KERNEL
Index: linux-2.6.13/arch/ppc/kernel/kgdb.c
===================================================================
--- /dev/null
+++ linux-2.6.13/arch/ppc/kernel/kgdb.c
@@ -0,0 +1,329 @@
+/*
+ * arch/ppc/kernel/kgdb.c
+ *
+ * PowerPC backend to the KGDB stub.
+ *
+ * Maintainer: Tom Rini <trini@kernel.crashing.org>
+ *
+ * 1998 (c) Michael AK Tesch (tesch@cs.wisc.edu)
+ * Copyright (C) 2003 Timesys Corporation.
+ * 2004 (c) MontaVista Software, Inc.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program as licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/kgdb.h>
+#include <linux/smp.h>
+#include <linux/signal.h>
+#include <linux/ptrace.h>
+#include <asm/current.h>
+#include <asm/ptrace.h>
+#include <asm/processor.h>
+#include <asm/machdep.h>
+
+/*
+ * This table contains the mapping between PowerPC hardware trap types, and
+ * signals, which are primarily what GDB understands.  GDB and the kernel
+ * don't always agree on values, so we use constants taken from gdb-6.2.
+ */
+static struct hard_trap_info
+{
+	unsigned int tt;		/* Trap type code for powerpc */
+	unsigned char signo;		/* Signal that we map this trap into */
+} hard_trap_info[] = {
+#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
+	{ 0x0100, 0x02 /* SIGINT */  },		/* critical input interrupt */
+	{ 0x0200, 0x0b /* SIGSEGV */ },		/* machine check */
+	{ 0x0300, 0x0b /* SIGSEGV */ },		/* data storage */
+	{ 0x0400, 0x0a /* SIGBUS */  },		/* instruction storage */
+	{ 0x0500, 0x02 /* SIGINT */  },		/* interrupt */
+	{ 0x0600, 0x0a /* SIGBUS */  },		/* alignment */
+	{ 0x0700, 0x04 /* SIGILL */  },		/* program */
+	{ 0x0800, 0x04 /* SIGILL */  },		/* reserved */
+	{ 0x0900, 0x04 /* SIGILL */  },		/* reserved */
+	{ 0x0a00, 0x04 /* SIGILL */  },		/* reserved */
+	{ 0x0b00, 0x04 /* SIGILL */  },		/* reserved */
+	{ 0x0c00, 0x14 /* SIGCHLD */ },		/* syscall */
+	{ 0x0d00, 0x04 /* SIGILL */  },		/* reserved */
+	{ 0x0e00, 0x04 /* SIGILL */  },		/* reserved */
+	{ 0x0f00, 0x04 /* SIGILL */  },		/* reserved */
+	{ 0x2002, 0x05 /* SIGTRAP */},		/* debug */
+#else
+	{ 0x0200, 0x0b /* SIGSEGV */ },		/* machine check */
+	{ 0x0300, 0x0b /* SIGSEGV */ },		/* address error (store) */
+	{ 0x0400, 0x0a /* SIGBUS */ },		/* instruction bus error */
+	{ 0x0500, 0x02 /* SIGINT */ },		/* interrupt */
+	{ 0x0600, 0x0a /* SIGBUS */ },		/* alingment */
+	{ 0x0700, 0x05 /* SIGTRAP */ },		/* breakpoint trap */
+	{ 0x0800, 0x08 /* SIGFPE */},		/* fpu unavail */
+	{ 0x0900, 0x0e /* SIGALRM */ },		/* decrementer */
+	{ 0x0a00, 0x04 /* SIGILL */ },		/* reserved */
+	{ 0x0b00, 0x04 /* SIGILL */ },		/* reserved */
+	{ 0x0c00, 0x14 /* SIGCHLD */ },		/* syscall */
+	{ 0x0d00, 0x05 /* SIGTRAP */ },		/* single-step/watch */
+	{ 0x0e00, 0x08 /* SIGFPE */ },		/* fp assist */
+#endif
+	{ 0x0000, 0x000 }			/* Must be last */
+};
+
+extern atomic_t cpu_doing_single_step;
+
+static int computeSignal(unsigned int tt)
+{
+	struct hard_trap_info *ht;
+
+	for (ht = hard_trap_info; ht->tt && ht->signo; ht++)
+		if (ht->tt == tt)
+			return ht->signo;
+
+	return SIGHUP;		/* default for things we don't know about */
+}
+
+/* KGDB functions to use existing PowerPC hooks. */
+static void kgdb_debugger(struct pt_regs *regs)
+{
+	kgdb_handle_exception(0, computeSignal(regs->trap), 0, regs);
+}
+
+static int kgdb_breakpoint(struct pt_regs *regs)
+{
+	if (user_mode(regs))
+		return 0;
+
+	kgdb_handle_exception(0, SIGTRAP, 0, regs);
+
+	if (*(u32 *) (regs->nip) == *(u32 *) (&arch_kgdb_ops.gdb_bpt_instr))
+		regs->nip += 4;
+
+	return 1;
+}
+
+static int kgdb_singlestep(struct pt_regs *regs)
+{
+	if (user_mode(regs))
+		return 0;
+
+	kgdb_handle_exception(0, SIGTRAP, 0, regs);
+	return 1;
+}
+
+int kgdb_iabr_match(struct pt_regs *regs)
+{
+	if (user_mode(regs))
+		return 0;
+
+	kgdb_handle_exception(0, computeSignal(regs->trap), 0, regs);
+	return 1;
+}
+
+int kgdb_dabr_match(struct pt_regs *regs)
+{
+	if (user_mode(regs))
+		return 0;
+
+	kgdb_handle_exception(0, computeSignal(regs->trap), 0, regs);
+	return 1;
+}
+
+void regs_to_gdb_regs(unsigned long *gdb_regs, struct pt_regs *regs)
+{
+	int reg;
+	unsigned long *ptr = gdb_regs;
+
+	memset(gdb_regs, 0, MAXREG * 4);
+
+	for (reg = 0; reg < 32; reg++)
+		*(ptr++) = regs->gpr[reg];
+
+#ifndef CONFIG_E500
+	for (reg = 0; reg < 64; reg++)
+		*(ptr++) = 0;
+#else
+	for (reg = 0; reg < 32; reg++)
+		*(ptr++) = current->thread.evr[reg];
+#endif
+
+	*(ptr++) = regs->nip;
+	*(ptr++) = regs->msr;
+	*(ptr++) = regs->ccr;
+	*(ptr++) = regs->link;
+	*(ptr++) = regs->ctr;
+	*(ptr++) = regs->xer;
+
+#ifdef CONFIG_SPE
+	/* u64 acc */
+	*(ptr++) = (current->thread.acc >> 32);
+	*(ptr++) = (current->thread.acc & 0xffffffff);
+	*(ptr++) = current->thread.spefscr;
+#endif
+}
+
+void sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct task_struct *p)
+{
+	struct pt_regs *regs = (struct pt_regs *)(p->thread.ksp +
+						  STACK_FRAME_OVERHEAD);
+	int reg;
+	unsigned long *ptr = gdb_regs;
+
+	memset(gdb_regs, 0, MAXREG * 4);
+
+	/* Regs GPR0-2 */
+	for (reg = 0; reg < 3; reg++)
+		*(ptr++) = regs->gpr[reg];
+
+	/* Regs GPR3-13 are not saved */
+	for (reg = 3; reg < 14; reg++)
+		*(ptr++) = 0;
+
+	/* Regs GPR14-31 */
+	for (reg = 14; reg < 32; reg++)
+		*(ptr++) = regs->gpr[reg];
+
+#ifndef CONFIG_E500
+	for (reg = 0; reg < 64; reg++)
+		*(ptr++) = 0;
+#else
+	for (reg = 0; reg < 32; reg++)
+		*(ptr++) = current->thread.evr[reg];
+#endif
+
+	*(ptr++) = regs->nip;
+	*(ptr++) = regs->msr;
+	*(ptr++) = regs->ccr;
+	*(ptr++) = regs->link;
+	*(ptr++) = regs->ctr;
+	*(ptr++) = regs->xer;
+
+#ifdef CONFIG_SPE
+	/* u64 acc */
+	*(ptr++) = (current->thread.acc >> 32);
+	*(ptr++) = (current->thread.acc & 0xffffffff);
+	*(ptr++) = current->thread.spefscr;
+#endif
+}
+
+void gdb_regs_to_regs(unsigned long *gdb_regs, struct pt_regs *regs)
+{
+	int reg;
+	unsigned long *ptr = gdb_regs;
+#ifdef CONFIG_SPE
+	union {
+		u32 v32[2];
+		u64 v64;
+	} u;
+#endif
+
+	for (reg = 0; reg < 32; reg++)
+		regs->gpr[reg] = *(ptr++);
+
+#ifndef CONFIG_E500
+	for (reg = 0; reg < 64; reg++)
+		ptr++;
+#else
+	for (reg = 0; reg < 32; reg++)
+		current->thread.evr[reg] = *(ptr++);
+#endif
+
+	regs->nip = *(ptr++);
+	regs->msr = *(ptr++);
+	regs->ccr = *(ptr++);
+	regs->link = *(ptr++);
+	regs->ctr = *(ptr++);
+	regs->xer = *(ptr++);
+
+#ifdef CONFIG_SPE
+	/* u64 acc */
+	u.v32[0] = *(ptr++);
+	u.v32[1] = *(ptr++);
+	current->thread.acc = u.v64;
+	current->thread.spefscr = *(ptr++);
+#endif
+}
+
+/*
+ * Save/restore state in case a memory access causes a fault.
+ */
+int kgdb_fault_setjmp(unsigned long *curr_context)
+{
+	__asm__ __volatile__("mflr 0; stw 0,0(%0);"
+			     "stw 1,4(%0); stw 2,8(%0);"
+			     "mfcr 0; stw 0,12(%0);"
+			     "stmw 13,16(%0)"::"r"(curr_context));
+	return 0;
+}
+
+void kgdb_fault_longjmp(unsigned long *curr_context)
+{
+	__asm__ __volatile__("lmw 13,16(%0);"
+			     "lwz 0,12(%0); mtcrf 0x38,0;"
+			     "lwz 0,0(%0); lwz 1,4(%0); lwz 2,8(%0);"
+			     "mtlr 0; mr 3,1"::"r"(curr_context));
+}
+
+/*
+ * This function does PoerPC specific procesing for interfacing to gdb.
+ */
+int kgdb_arch_handle_exception(int vector, int signo, int err_code,
+			       char *remcom_in_buffer, char *remcom_out_buffer,
+			       struct pt_regs *linux_regs)
+{
+	char *ptr = &remcom_in_buffer[1];
+	unsigned long addr;
+
+	switch (remcom_in_buffer[0])
+		{
+		/*
+		 * sAA..AA   Step one instruction from AA..AA
+		 * This will return an error to gdb ..
+		 */
+		case 's':
+		case 'c':
+			/* handle the optional parameter */
+			if (kgdb_hex2long (&ptr, &addr))
+				linux_regs->nip = addr;
+
+			atomic_set(&cpu_doing_single_step, -1);
+			/* set the trace bit if we're stepping */
+			if (remcom_in_buffer[0] == 's') {
+#if defined (CONFIG_40x) || defined(CONFIG_BOOKE)
+				mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) |
+						DBCR0_IC | DBCR0_IDM);
+				linux_regs->msr |= MSR_DE;
+#else
+				linux_regs->msr |= MSR_SE;
+#endif
+				debugger_step = 1;
+				if (kgdb_contthread)
+					atomic_set(&cpu_doing_single_step,
+							smp_processor_id());
+			}
+			return 0;
+	}
+
+	return -1;
+}
+
+/*
+ * Global data
+ */
+struct kgdb_arch arch_kgdb_ops = {
+	.gdb_bpt_instr = {0x7d, 0x82, 0x10, 0x08},
+};
+
+int kgdb_arch_init(void)
+{
+	debugger = kgdb_debugger;
+	debugger_bpt = kgdb_breakpoint;
+	debugger_sstep = kgdb_singlestep;
+	debugger_iabr_match = kgdb_iabr_match;
+	debugger_dabr_match = kgdb_dabr_match;
+
+	return 0;
+}
+
+arch_initcall(kgdb_arch_init);
Index: linux-2.6.13/arch/ppc/kernel/Makefile
===================================================================
--- linux-2.6.13.orig/arch/ppc/kernel/Makefile
+++ linux-2.6.13/arch/ppc/kernel/Makefile
@@ -22,7 +22,7 @@ obj-$(CONFIG_POWER4)		+= cpu_setup_power
 obj-$(CONFIG_MODULES)		+= module.o ppc_ksyms.o
 obj-$(CONFIG_NOT_COHERENT_CACHE)	+= dma-mapping.o
 obj-$(CONFIG_PCI)		+= pci.o
-obj-$(CONFIG_KGDB)		+= ppc-stub.o
+obj-$(CONFIG_KGDB)		+= kgdb.o
 obj-$(CONFIG_SMP)		+= smp.o smp-tbsync.o
 obj-$(CONFIG_TAU)		+= temp.o
 obj-$(CONFIG_ALTIVEC)		+= vecemu.o vector.o
Index: linux-2.6.13/arch/ppc/kernel/ppc-stub.c
===================================================================
--- linux-2.6.13.orig/arch/ppc/kernel/ppc-stub.c
+++ /dev/null
@@ -1,867 +0,0 @@
-/*
- * ppc-stub.c:  KGDB support for the Linux kernel.
- *
- * adapted from arch/sparc/kernel/sparc-stub.c for the PowerPC
- * some stuff borrowed from Paul Mackerras' xmon
- * Copyright (C) 1998 Michael AK Tesch (tesch@cs.wisc.edu)
- *
- * Modifications to run under Linux
- * Copyright (C) 1995 David S. Miller (davem@caip.rutgers.edu)
- *
- * This file originally came from the gdb sources, and the
- * copyright notices have been retained below.
- */
-
-/****************************************************************************
-
-		THIS SOFTWARE IS NOT COPYRIGHTED
-
-   HP offers the following for use in the public domain.  HP makes no
-   warranty with regard to the software or its performance and the
-   user accepts the software "AS IS" with all faults.
-
-   HP DISCLAIMS ANY WARRANTIES, EXPRESS OR IMPLIED, WITH REGARD
-   TO THIS SOFTWARE INCLUDING BUT NOT LIMITED TO THE WARRANTIES
-   OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
-
-****************************************************************************/
-
-/****************************************************************************
- *  Header: remcom.c,v 1.34 91/03/09 12:29:49 glenne Exp $
- *
- *  Module name: remcom.c $
- *  Revision: 1.34 $
- *  Date: 91/03/09 12:29:49 $
- *  Contributor:     Lake Stevens Instrument Division$
- *
- *  Description:     low level support for gdb debugger. $
- *
- *  Considerations:  only works on target hardware $
- *
- *  Written by:      Glenn Engel $
- *  ModuleState:     Experimental $
- *
- *  NOTES:           See Below $
- *
- *  Modified for SPARC by Stu Grossman, Cygnus Support.
- *
- *  This code has been extensively tested on the Fujitsu SPARClite demo board.
- *
- *  To enable debugger support, two things need to happen.  One, a
- *  call to set_debug_traps() is necessary in order to allow any breakpoints
- *  or error conditions to be properly intercepted and reported to gdb.
- *  Two, a breakpoint needs to be generated to begin communication.  This
- *  is most easily accomplished by a call to breakpoint().  Breakpoint()
- *  simulates a breakpoint by executing a trap #1.
- *
- *************
- *
- *    The following gdb commands are supported:
- *
- * command          function		          Return value
- *
- *    g             return the value of the CPU registers  hex data or ENN
- *    G             set the value of the CPU registers     OK or ENN
- *    qOffsets      Get section offsets.  Reply is Text=xxx;Data=yyy;Bss=zzz
- *
- *    mAA..AA,LLLL  Read LLLL bytes at address AA..AA      hex data or ENN
- *    MAA..AA,LLLL: Write LLLL bytes at address AA.AA      OK or ENN
- *
- *    c             Resume at current address              SNN   ( signal NN)
- *    cAA..AA       Continue at address AA..AA             SNN
- *
- *    s             Step one instruction                   SNN
- *    sAA..AA       Step one instruction from AA..AA       SNN
- *
- *    k             kill
- *
- *    ?             What was the last sigval ?             SNN   (signal NN)
- *
- *    bBB..BB	    Set baud rate to BB..BB		   OK or BNN, then sets
- *							   baud rate
- *
- * All commands and responses are sent with a packet which includes a
- * checksum.  A packet consists of
- *
- * $<packet info>#<checksum>.
- *
- * where
- * <packet info> :: <characters representing the command or response>
- * <checksum>    :: <two hex digits computed as modulo 256 sum of <packetinfo>>
- *
- * When a packet is received, it is first acknowledged with either '+' or '-'.
- * '+' indicates a successful transfer.  '-' indicates a failed transfer.
- *
- * Example:
- *
- * Host:                  Reply:
- * $m0,10#2a               +$00010203040506070809101112131415#42
- *
- ****************************************************************************/
-
-#include <linux/config.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/mm.h>
-#include <linux/smp.h>
-#include <linux/smp_lock.h>
-#include <linux/init.h>
-#include <linux/sysrq.h>
-
-#include <asm/cacheflush.h>
-#include <asm/system.h>
-#include <asm/signal.h>
-#include <asm/kgdb.h>
-#include <asm/pgtable.h>
-#include <asm/ptrace.h>
-
-void breakinst(void);
-
-/*
- * BUFMAX defines the maximum number of characters in inbound/outbound buffers
- * at least NUMREGBYTES*2 are needed for register packets
- */
-#define BUFMAX 2048
-static char remcomInBuffer[BUFMAX];
-static char remcomOutBuffer[BUFMAX];
-
-static int initialized;
-static int kgdb_active;
-static int kgdb_started;
-static u_int fault_jmp_buf[100];
-static int kdebug;
-
-
-static const char hexchars[]="0123456789abcdef";
-
-/* Place where we save old trap entries for restoration - sparc*/
-/* struct tt_entry kgdb_savettable[256]; */
-/* typedef void (*trapfunc_t)(void); */
-
-static void kgdb_fault_handler(struct pt_regs *regs);
-static int handle_exception (struct pt_regs *regs);
-
-#if 0
-/* Install an exception handler for kgdb */
-static void exceptionHandler(int tnum, unsigned int *tfunc)
-{
-	/* We are dorking with a live trap table, all irqs off */
-}
-#endif
-
-int
-kgdb_setjmp(long *buf)
-{
-	asm ("mflr 0; stw 0,0(%0);"
-	     "stw 1,4(%0); stw 2,8(%0);"
-	     "mfcr 0; stw 0,12(%0);"
-	     "stmw 13,16(%0)"
-	     : : "r" (buf));
-	/* XXX should save fp regs as well */
-	return 0;
-}
-void
-kgdb_longjmp(long *buf, int val)
-{
-	if (val == 0)
-		val = 1;
-	asm ("lmw 13,16(%0);"
-	     "lwz 0,12(%0); mtcrf 0x38,0;"
-	     "lwz 0,0(%0); lwz 1,4(%0); lwz 2,8(%0);"
-	     "mtlr 0; mr 3,%1"
-	     : : "r" (buf), "r" (val));
-}
-/* Convert ch from a hex digit to an int */
-static int
-hex(unsigned char ch)
-{
-	if (ch >= 'a' && ch <= 'f')
-		return ch-'a'+10;
-	if (ch >= '0' && ch <= '9')
-		return ch-'0';
-	if (ch >= 'A' && ch <= 'F')
-		return ch-'A'+10;
-	return -1;
-}
-
-/* Convert the memory pointed to by mem into hex, placing result in buf.
- * Return a pointer to the last char put in buf (null), in case of mem fault,
- * return 0.
- */
-static unsigned char *
-mem2hex(const char *mem, char *buf, int count)
-{
-	unsigned char ch;
-	unsigned short tmp_s;
-	unsigned long tmp_l;
-
-	if (kgdb_setjmp((long*)fault_jmp_buf) == 0) {
-		debugger_fault_handler = kgdb_fault_handler;
-
-		/* Accessing 16 bit and 32 bit objects in a single
-		** load instruction is required to avoid bad side
-		** effects for some IO registers.
-		*/
-
-		if ((count == 2) && (((long)mem & 1) == 0)) {
-			tmp_s = *(unsigned short *)mem;
-			mem += 2;
-			*buf++ = hexchars[(tmp_s >> 12) & 0xf];
-			*buf++ = hexchars[(tmp_s >> 8) & 0xf];
-			*buf++ = hexchars[(tmp_s >> 4) & 0xf];
-			*buf++ = hexchars[tmp_s & 0xf];
-
-		} else if ((count == 4) && (((long)mem & 3) == 0)) {
-			tmp_l = *(unsigned int *)mem;
-			mem += 4;
-			*buf++ = hexchars[(tmp_l >> 28) & 0xf];
-			*buf++ = hexchars[(tmp_l >> 24) & 0xf];
-			*buf++ = hexchars[(tmp_l >> 20) & 0xf];
-			*buf++ = hexchars[(tmp_l >> 16) & 0xf];
-			*buf++ = hexchars[(tmp_l >> 12) & 0xf];
-			*buf++ = hexchars[(tmp_l >> 8) & 0xf];
-			*buf++ = hexchars[(tmp_l >> 4) & 0xf];
-			*buf++ = hexchars[tmp_l & 0xf];
-
-		} else {
-			while (count-- > 0) {
-				ch = *mem++;
-				*buf++ = hexchars[ch >> 4];
-				*buf++ = hexchars[ch & 0xf];
-			}
-		}
-
-	} else {
-		/* error condition */
-	}
-	debugger_fault_handler = NULL;
-	*buf = 0;
-	return buf;
-}
-
-/* convert the hex array pointed to by buf into binary to be placed in mem
- * return a pointer to the character AFTER the last byte written.
-*/
-static char *
-hex2mem(char *buf, char *mem, int count)
-{
-	unsigned char ch;
-	int i;
-	char *orig_mem;
-	unsigned short tmp_s;
-	unsigned long tmp_l;
-
-	orig_mem = mem;
-
-	if (kgdb_setjmp((long*)fault_jmp_buf) == 0) {
-		debugger_fault_handler = kgdb_fault_handler;
-
-		/* Accessing 16 bit and 32 bit objects in a single
-		** store instruction is required to avoid bad side
-		** effects for some IO registers.
-		*/
-
-		if ((count == 2) && (((long)mem & 1) == 0)) {
-			tmp_s = hex(*buf++) << 12;
-			tmp_s |= hex(*buf++) << 8;
-			tmp_s |= hex(*buf++) << 4;
-			tmp_s |= hex(*buf++);
-
-			*(unsigned short *)mem = tmp_s;
-			mem += 2;
-
-		} else if ((count == 4) && (((long)mem & 3) == 0)) {
-			tmp_l = hex(*buf++) << 28;
-			tmp_l |= hex(*buf++) << 24;
-			tmp_l |= hex(*buf++) << 20;
-			tmp_l |= hex(*buf++) << 16;
-			tmp_l |= hex(*buf++) << 12;
-			tmp_l |= hex(*buf++) << 8;
-			tmp_l |= hex(*buf++) << 4;
-			tmp_l |= hex(*buf++);
-
-			*(unsigned long *)mem = tmp_l;
-			mem += 4;
-
-		} else {
-			for (i=0; i<count; i++) {
-				ch = hex(*buf++) << 4;
-				ch |= hex(*buf++);
-				*mem++ = ch;
-			}
-		}
-
-
-		/*
-		** Flush the data cache, invalidate the instruction cache.
-		*/
-		flush_icache_range((int)orig_mem, (int)orig_mem + count - 1);
-
-	} else {
-		/* error condition */
-	}
-	debugger_fault_handler = NULL;
-	return mem;
-}
-
-/*
- * While we find nice hex chars, build an int.
- * Return number of chars processed.
- */
-static int
-hexToInt(char **ptr, int *intValue)
-{
-	int numChars = 0;
-	int hexValue;
-
-	*intValue = 0;
-
-	if (kgdb_setjmp((long*)fault_jmp_buf) == 0) {
-		debugger_fault_handler = kgdb_fault_handler;
-		while (**ptr) {
-			hexValue = hex(**ptr);
-			if (hexValue < 0)
-				break;
-
-			*intValue = (*intValue << 4) | hexValue;
-			numChars ++;
-
-			(*ptr)++;
-		}
-	} else {
-		/* error condition */
-	}
-	debugger_fault_handler = NULL;
-
-	return (numChars);
-}
-
-/* scan for the sequence $<data>#<checksum> */
-static void
-getpacket(char *buffer)
-{
-	unsigned char checksum;
-	unsigned char xmitcsum;
-	int i;
-	int count;
-	unsigned char ch;
-
-	do {
-		/* wait around for the start character, ignore all other
-		 * characters */
-		while ((ch = (getDebugChar() & 0x7f)) != '$') ;
-
-		checksum = 0;
-		xmitcsum = -1;
-
-		count = 0;
-
-		/* now, read until a # or end of buffer is found */
-		while (count < BUFMAX) {
-			ch = getDebugChar() & 0x7f;
-			if (ch == '#')
-				break;
-			checksum = checksum + ch;
-			buffer[count] = ch;
-			count = count + 1;
-		}
-
-		if (count >= BUFMAX)
-			continue;
-
-		buffer[count] = 0;
-
-		if (ch == '#') {
-			xmitcsum = hex(getDebugChar() & 0x7f) << 4;
-			xmitcsum |= hex(getDebugChar() & 0x7f);
-			if (checksum != xmitcsum)
-				putDebugChar('-');	/* failed checksum */
-			else {
-				putDebugChar('+'); /* successful transfer */
-				/* if a sequence char is present, reply the ID */
-				if (buffer[2] == ':') {
-					putDebugChar(buffer[0]);
-					putDebugChar(buffer[1]);
-					/* remove sequence chars from buffer */
-					count = strlen(buffer);
-					for (i=3; i <= count; i++)
-						buffer[i-3] = buffer[i];
-				}
-			}
-		}
-	} while (checksum != xmitcsum);
-}
-
-/* send the packet in buffer. */
-static void putpacket(unsigned char *buffer)
-{
-	unsigned char checksum;
-	int count;
-	unsigned char ch, recv;
-
-	/* $<packet info>#<checksum>. */
-	do {
-		putDebugChar('$');
-		checksum = 0;
-		count = 0;
-
-		while ((ch = buffer[count])) {
-			putDebugChar(ch);
-			checksum += ch;
-			count += 1;
-		}
-
-		putDebugChar('#');
-		putDebugChar(hexchars[checksum >> 4]);
-		putDebugChar(hexchars[checksum & 0xf]);
-		recv = getDebugChar();
-	} while ((recv & 0x7f) != '+');
-}
-
-static void kgdb_flush_cache_all(void)
-{
-	flush_instruction_cache();
-}
-
-/* Set up exception handlers for tracing and breakpoints
- * [could be called kgdb_init()]
- */
-void set_debug_traps(void)
-{
-#if 0
-	unsigned char c;
-
-	save_and_cli(flags);
-
-	/* In case GDB is started before us, ack any packets (presumably
-	 * "$?#xx") sitting there.
-	 *
-	 * I've found this code causes more problems than it solves,
-	 * so that's why it's commented out.  GDB seems to work fine
-	 * now starting either before or after the kernel   -bwb
-	 */
-
-	while((c = getDebugChar()) != '$');
-	while((c = getDebugChar()) != '#');
-	c = getDebugChar(); /* eat first csum byte */
-	c = getDebugChar(); /* eat second csum byte */
-	putDebugChar('+'); /* ack it */
-#endif
-	debugger = kgdb;
-	debugger_bpt = kgdb_bpt;
-	debugger_sstep = kgdb_sstep;
-	debugger_iabr_match = kgdb_iabr_match;
-	debugger_dabr_match = kgdb_dabr_match;
-
-	initialized = 1;
-}
-
-static void kgdb_fault_handler(struct pt_regs *regs)
-{
-	kgdb_longjmp((long*)fault_jmp_buf, 1);
-}
-
-int kgdb_bpt(struct pt_regs *regs)
-{
-	return handle_exception(regs);
-}
-
-int kgdb_sstep(struct pt_regs *regs)
-{
-	return handle_exception(regs);
-}
-
-void kgdb(struct pt_regs *regs)
-{
-	handle_exception(regs);
-}
-
-int kgdb_iabr_match(struct pt_regs *regs)
-{
-	printk(KERN_ERR "kgdb doesn't support iabr, what?!?\n");
-	return handle_exception(regs);
-}
-
-int kgdb_dabr_match(struct pt_regs *regs)
-{
-	printk(KERN_ERR "kgdb doesn't support dabr, what?!?\n");
-	return handle_exception(regs);
-}
-
-/* Convert the hardware trap type code to a unix signal number. */
-/*
- * This table contains the mapping between PowerPC hardware trap types, and
- * signals, which are primarily what GDB understands.
- */
-static struct hard_trap_info
-{
-	unsigned int tt;		/* Trap type code for powerpc */
-	unsigned char signo;		/* Signal that we map this trap into */
-} hard_trap_info[] = {
-#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
-	{ 0x100, SIGINT  },		/* critical input interrupt */
-	{ 0x200, SIGSEGV },		/* machine check */
-	{ 0x300, SIGSEGV },		/* data storage */
-	{ 0x400, SIGBUS  },		/* instruction storage */
-	{ 0x500, SIGINT  },		/* interrupt */
-	{ 0x600, SIGBUS  },		/* alignment */
-	{ 0x700, SIGILL  },		/* program */
-	{ 0x800, SIGILL  },		/* reserved */
-	{ 0x900, SIGILL  },		/* reserved */
-	{ 0xa00, SIGILL  },		/* reserved */
-	{ 0xb00, SIGILL  },		/* reserved */
-	{ 0xc00, SIGCHLD },		/* syscall */
-	{ 0xd00, SIGILL  },		/* reserved */
-	{ 0xe00, SIGILL  },		/* reserved */
-	{ 0xf00, SIGILL  },		/* reserved */
-	/*
-	** 0x1000  PIT
-	** 0x1010  FIT
-	** 0x1020  watchdog
-	** 0x1100  data TLB miss
-	** 0x1200  instruction TLB miss
-	*/
-	{ 0x2002, SIGTRAP},		/* debug */
-#else
-	{ 0x200, SIGSEGV },		/* machine check */
-	{ 0x300, SIGSEGV },		/* address error (store) */
-	{ 0x400, SIGBUS },		/* instruction bus error */
-	{ 0x500, SIGINT },		/* interrupt */
-	{ 0x600, SIGBUS },		/* alingment */
-	{ 0x700, SIGTRAP },		/* breakpoint trap */
-	{ 0x800, SIGFPE },		/* fpu unavail */
-	{ 0x900, SIGALRM },		/* decrementer */
-	{ 0xa00, SIGILL },		/* reserved */
-	{ 0xb00, SIGILL },		/* reserved */
-	{ 0xc00, SIGCHLD },		/* syscall */
-	{ 0xd00, SIGTRAP },		/* single-step/watch */
-	{ 0xe00, SIGFPE },		/* fp assist */
-#endif
-	{ 0, 0}				/* Must be last */
-
-};
-
-static int computeSignal(unsigned int tt)
-{
-	struct hard_trap_info *ht;
-
-	for (ht = hard_trap_info; ht->tt && ht->signo; ht++)
-		if (ht->tt == tt)
-			return ht->signo;
-
-	return SIGHUP; /* default for things we don't know about */
-}
-
-#define PC_REGNUM 64
-#define SP_REGNUM 1
-
-/*
- * This function does all command processing for interfacing to gdb.
- */
-static int
-handle_exception (struct pt_regs *regs)
-{
-	int sigval;
-	int addr;
-	int length;
-	char *ptr;
-	unsigned int msr;
-
-	/* We don't handle user-mode breakpoints. */
-	if (user_mode(regs))
-		return 0;
-
-	if (debugger_fault_handler) {
-		debugger_fault_handler(regs);
-		panic("kgdb longjump failed!\n");
-	}
-	if (kgdb_active) {
-		printk(KERN_ERR "interrupt while in kgdb, returning\n");
-		return 0;
-	}
-
-	kgdb_active = 1;
-	kgdb_started = 1;
-
-#ifdef KGDB_DEBUG
-	printk("kgdb: entering handle_exception; trap [0x%x]\n",
-			(unsigned int)regs->trap);
-#endif
-
-	kgdb_interruptible(0);
-	lock_kernel();
-	msr = mfmsr();
-	mtmsr(msr & ~MSR_EE);	/* disable interrupts */
-
-	if (regs->nip == (unsigned long)breakinst) {
-		/* Skip over breakpoint trap insn */
-		regs->nip += 4;
-	}
-
-	/* reply to host that an exception has occurred */
-	sigval = computeSignal(regs->trap);
-	ptr = remcomOutBuffer;
-
-	*ptr++ = 'T';
-	*ptr++ = hexchars[sigval >> 4];
-	*ptr++ = hexchars[sigval & 0xf];
-	*ptr++ = hexchars[PC_REGNUM >> 4];
-	*ptr++ = hexchars[PC_REGNUM & 0xf];
-	*ptr++ = ':';
-	ptr = mem2hex((char *)&regs->nip, ptr, 4);
-	*ptr++ = ';';
-	*ptr++ = hexchars[SP_REGNUM >> 4];
-	*ptr++ = hexchars[SP_REGNUM & 0xf];
-	*ptr++ = ':';
-	ptr = mem2hex(((char *)regs) + SP_REGNUM*4, ptr, 4);
-	*ptr++ = ';';
-	*ptr++ = 0;
-
-	putpacket(remcomOutBuffer);
-	if (kdebug)
-		printk("remcomOutBuffer: %s\n", remcomOutBuffer);
-
-	/* XXX We may want to add some features dealing with poking the
-	 * XXX page tables, ... (look at sparc-stub.c for more info)
-	 * XXX also required hacking to the gdb sources directly...
-	 */
-
-	while (1) {
-		remcomOutBuffer[0] = 0;
-
-		getpacket(remcomInBuffer);
-		switch (remcomInBuffer[0]) {
-		case '?': /* report most recent signal */
-			remcomOutBuffer[0] = 'S';
-			remcomOutBuffer[1] = hexchars[sigval >> 4];
-			remcomOutBuffer[2] = hexchars[sigval & 0xf];
-			remcomOutBuffer[3] = 0;
-			break;
-#if 0
-		case 'q': /* this screws up gdb for some reason...*/
-		{
-			extern long _start, sdata, __bss_start;
-
-			ptr = &remcomInBuffer[1];
-			if (strncmp(ptr, "Offsets", 7) != 0)
-				break;
-
-			ptr = remcomOutBuffer;
-			sprintf(ptr, "Text=%8.8x;Data=%8.8x;Bss=%8.8x",
-				&_start, &sdata, &__bss_start);
-			break;
-		}
-#endif
-		case 'd':
-			/* toggle debug flag */
-			kdebug ^= 1;
-			break;
-
-		case 'g':	/* return the value of the CPU registers.
-				 * some of them are non-PowerPC names :(
-				 * they are stored in gdb like:
-				 * struct {
-				 *     u32 gpr[32];
-				 *     f64 fpr[32];
-				 *     u32 pc, ps, cnd, lr; (ps=msr)
-				 *     u32 cnt, xer, mq;
-				 * }
-				 */
-		{
-			int i;
-			ptr = remcomOutBuffer;
-			/* General Purpose Regs */
-			ptr = mem2hex((char *)regs, ptr, 32 * 4);
-			/* Floating Point Regs - FIXME */
-			/*ptr = mem2hex((char *), ptr, 32 * 8);*/
-			for(i=0; i<(32*8*2); i++) { /* 2chars/byte */
-				ptr[i] = '0';
-			}
-			ptr += 32*8*2;
-			/* pc, msr, cr, lr, ctr, xer, (mq is unused) */
-			ptr = mem2hex((char *)&regs->nip, ptr, 4);
-			ptr = mem2hex((char *)&regs->msr, ptr, 4);
-			ptr = mem2hex((char *)&regs->ccr, ptr, 4);
-			ptr = mem2hex((char *)&regs->link, ptr, 4);
-			ptr = mem2hex((char *)&regs->ctr, ptr, 4);
-			ptr = mem2hex((char *)&regs->xer, ptr, 4);
-		}
-			break;
-
-		case 'G': /* set the value of the CPU registers */
-		{
-			ptr = &remcomInBuffer[1];
-
-			/*
-			 * If the stack pointer has moved, you should pray.
-			 * (cause only god can help you).
-			 */
-
-			/* General Purpose Regs */
-			hex2mem(ptr, (char *)regs, 32 * 4);
-
-			/* Floating Point Regs - FIXME?? */
-			/*ptr = hex2mem(ptr, ??, 32 * 8);*/
-			ptr += 32*8*2;
-
-			/* pc, msr, cr, lr, ctr, xer, (mq is unused) */
-			ptr = hex2mem(ptr, (char *)&regs->nip, 4);
-			ptr = hex2mem(ptr, (char *)&regs->msr, 4);
-			ptr = hex2mem(ptr, (char *)&regs->ccr, 4);
-			ptr = hex2mem(ptr, (char *)&regs->link, 4);
-			ptr = hex2mem(ptr, (char *)&regs->ctr, 4);
-			ptr = hex2mem(ptr, (char *)&regs->xer, 4);
-
-			strcpy(remcomOutBuffer,"OK");
-		}
-			break;
-		case 'H':
-			/* don't do anything, yet, just acknowledge */
-			hexToInt(&ptr, &addr);
-			strcpy(remcomOutBuffer,"OK");
-			break;
-
-		case 'm':	/* mAA..AA,LLLL  Read LLLL bytes at address AA..AA */
-				/* Try to read %x,%x.  */
-
-			ptr = &remcomInBuffer[1];
-
-			if (hexToInt(&ptr, &addr) && *ptr++ == ','
-					&& hexToInt(&ptr, &length)) {
-				if (mem2hex((char *)addr, remcomOutBuffer,
-							length))
-					break;
-				strcpy(remcomOutBuffer, "E03");
-			} else
-				strcpy(remcomOutBuffer, "E01");
-			break;
-
-		case 'M': /* MAA..AA,LLLL: Write LLLL bytes at address AA.AA return OK */
-			/* Try to read '%x,%x:'.  */
-
-			ptr = &remcomInBuffer[1];
-
-			if (hexToInt(&ptr, &addr) && *ptr++ == ','
-					&& hexToInt(&ptr, &length)
-					&& *ptr++ == ':') {
-				if (hex2mem(ptr, (char *)addr, length))
-					strcpy(remcomOutBuffer, "OK");
-				else
-					strcpy(remcomOutBuffer, "E03");
-				flush_icache_range(addr, addr+length);
-			} else
-				strcpy(remcomOutBuffer, "E02");
-			break;
-
-
-		case 'k': /* kill the program, actually just continue */
-		case 'c': /* cAA..AA  Continue; address AA..AA optional */
-			/* try to read optional parameter, pc unchanged if no parm */
-
-			ptr = &remcomInBuffer[1];
-			if (hexToInt(&ptr, &addr))
-				regs->nip = addr;
-
-/* Need to flush the instruction cache here, as we may have deposited a
- * breakpoint, and the icache probably has no way of knowing that a data ref to
- * some location may have changed something that is in the instruction cache.
- */
-			kgdb_flush_cache_all();
-			mtmsr(msr);
-
-			kgdb_interruptible(1);
-			unlock_kernel();
-			kgdb_active = 0;
-			if (kdebug) {
-				printk("remcomInBuffer: %s\n", remcomInBuffer);
-				printk("remcomOutBuffer: %s\n", remcomOutBuffer);
-			}
-			return 1;
-
-		case 's':
-			kgdb_flush_cache_all();
-#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
-			mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) | DBCR0_IC);
-			regs->msr |= MSR_DE;
-#else
-			regs->msr |= MSR_SE;
-#endif
-			unlock_kernel();
-			kgdb_active = 0;
-			if (kdebug) {
-				printk("remcomInBuffer: %s\n", remcomInBuffer);
-				printk("remcomOutBuffer: %s\n", remcomOutBuffer);
-			}
-			return 1;
-
-		case 'r':		/* Reset (if user process..exit ???)*/
-			panic("kgdb reset.");
-			break;
-		}			/* switch */
-		if (remcomOutBuffer[0] && kdebug) {
-			printk("remcomInBuffer: %s\n", remcomInBuffer);
-			printk("remcomOutBuffer: %s\n", remcomOutBuffer);
-		}
-		/* reply to the request */
-		putpacket(remcomOutBuffer);
-	} /* while(1) */
-}
-
-/* This function will generate a breakpoint exception.  It is used at the
-   beginning of a program to sync up with a debugger and can be used
-   otherwise as a quick means to stop program execution and "break" into
-   the debugger. */
-
-void
-breakpoint(void)
-{
-	if (!initialized) {
-		printk("breakpoint() called b4 kgdb init\n");
-		return;
-	}
-
-	asm("	.globl breakinst	\n\
-	     breakinst: .long 0x7d821008");
-}
-
-#ifdef CONFIG_KGDB_CONSOLE
-/* Output string in GDB O-packet format if GDB has connected. If nothing
-   output, returns 0 (caller must then handle output). */
-int
-kgdb_output_string (const char* s, unsigned int count)
-{
-	char buffer[512];
-
-	if (!kgdb_started)
-		return 0;
-
-	count = (count <= (sizeof(buffer) / 2 - 2))
-		? count : (sizeof(buffer) / 2 - 2);
-
-	buffer[0] = 'O';
-	mem2hex (s, &buffer[1], count);
-	putpacket(buffer);
-
-	return 1;
-}
-#endif
-
-static void sysrq_handle_gdb(int key, struct pt_regs *pt_regs,
-			     struct tty_struct *tty)
-{
-	printk("Entering GDB stub\n");
-	breakpoint();
-}
-static struct sysrq_key_op sysrq_gdb_op = {
-        .handler        = sysrq_handle_gdb,
-        .help_msg       = "Gdb",
-        .action_msg     = "GDB",
-};
-
-static int gdb_register_sysrq(void)
-{
-	printk("Registering GDB sysrq handler\n");
-	register_sysrq_key('g', &sysrq_gdb_op);
-	return 0;
-}
-module_init(gdb_register_sysrq);
Index: linux-2.6.13/arch/ppc/kernel/setup.c
===================================================================
--- linux-2.6.13.orig/arch/ppc/kernel/setup.c
+++ linux-2.6.13/arch/ppc/kernel/setup.c
@@ -45,10 +45,6 @@
 #include <asm/ppc_sys.h>
 #endif
 
-#if defined CONFIG_KGDB
-#include <asm/kgdb.h>
-#endif
-
 extern void platform_init(unsigned long r3, unsigned long r4,
 		unsigned long r5, unsigned long r6, unsigned long r7);
 extern void bootx_init(unsigned long r4, unsigned long phys);
@@ -703,18 +699,6 @@ void __init setup_arch(char **cmdline_p)
 #endif /* CONFIG_XMON */
 	if ( ppc_md.progress ) ppc_md.progress("setup_arch: enter", 0x3eab);
 
-#if defined(CONFIG_KGDB)
-	if (ppc_md.kgdb_map_scc)
-		ppc_md.kgdb_map_scc();
-	set_debug_traps();
-	if (strstr(cmd_line, "gdb")) {
-		if (ppc_md.progress)
-			ppc_md.progress("setup_arch: kgdb breakpoint", 0x4000);
-		printk("kgdb breakpoint activated\n");
-		breakpoint();
-	}
-#endif
-
 	/*
 	 * Set cache line size based on type of cpu as a default.
 	 * Systems with OF can look in the properties on the cpu node(s)
Index: linux-2.6.13/arch/ppc/mm/fault.c
===================================================================
--- linux-2.6.13.orig/arch/ppc/mm/fault.c
+++ linux-2.6.13/arch/ppc/mm/fault.c
@@ -28,6 +28,7 @@
 #include <linux/interrupt.h>
 #include <linux/highmem.h>
 #include <linux/module.h>
+#include <linux/kgdb.h>
 
 #include <asm/page.h>
 #include <asm/pgtable.h>
@@ -332,6 +333,14 @@ bad_page_fault(struct pt_regs *regs, uns
 		return;
 	}
 
+#ifdef CONFIG_KGDB
+	if (atomic_read(&debugger_active) && kgdb_may_fault) {
+		/* Restore our previous state. */
+		kgdb_fault_longjmp(kgdb_fault_jmp_regs);
+		/* Not reached. */
+	}
+#endif
+
 	/* kernel has accessed a bad area */
 #if defined(CONFIG_XMON) || defined(CONFIG_KGDB)
 	if (debugger_kernel_faults)
Index: linux-2.6.13/arch/ppc/platforms/4xx/bubinga.c
===================================================================
--- linux-2.6.13.orig/arch/ppc/platforms/4xx/bubinga.c
+++ linux-2.6.13/arch/ppc/platforms/4xx/bubinga.c
@@ -4,7 +4,7 @@
  * Author: SAW (IBM), derived from walnut.c.
  *         Maintained by MontaVista Software <source@mvista.com>
  *
- * 2003 (c) MontaVista Softare Inc.  This file is licensed under the
+ * 2003-2004 (c) MontaVista Softare Inc.  This file is licensed under the
  * terms of the GNU General Public License version 2. This program is
  * licensed "as is" without any warranty of any kind, whether express
  * or implied.
@@ -101,17 +101,26 @@ bubinga_early_serial_map(void)
 	port.flags = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
 	port.line = 0;
 
-	if (early_serial_setup(&port) != 0) {
+#ifdef CONFIG_SERIAL_8250
+	if (early_serial_setup(&port) != 0)
 		printk("Early serial init of port 0 failed\n");
-	}
+#endif
+
+#ifdef CONFIG_KGDB_8250
+	kgdb8250_add_port(0, &port);
+#endif
 
 	port.membase = (void*)ACTING_UART1_IO_BASE;
 	port.irq = ACTING_UART1_INT;
 	port.line = 1;
 
-	if (early_serial_setup(&port) != 0) {
+#ifdef CONFIG_SERIAL_8250
+	if (early_serial_setup(&port) != 0)
 		printk("Early serial init of port 1 failed\n");
-	}
+#endif
+#ifdef CONFIG_KGDB_8250
+	kgdb8250_add_port(1, &port);
+#endif
 }
 
 void __init
@@ -256,8 +265,4 @@ platform_init(unsigned long r3, unsigned
 	ppc_md.nvram_read_val = todc_direct_read_val;
 	ppc_md.nvram_write_val = todc_direct_write_val;
 #endif
-#ifdef CONFIG_KGDB
-	ppc_md.early_serial_map = bubinga_early_serial_map;
-#endif
 }
-
Index: linux-2.6.13/arch/ppc/platforms/4xx/ebony.c
===================================================================
--- linux-2.6.13.orig/arch/ppc/platforms/4xx/ebony.c
+++ linux-2.6.13/arch/ppc/platforms/4xx/ebony.c
@@ -36,6 +36,7 @@
 #include <linux/tty.h>
 #include <linux/serial.h>
 #include <linux/serial_core.h>
+#include <linux/kgdb.h>
 
 #include <asm/system.h>
 #include <asm/pgtable.h>
@@ -242,14 +243,20 @@ ebony_early_serial_map(void)
 	port.flags = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
 	port.line = 0;
 
-	if (early_serial_setup(&port) != 0) {
+#ifdef CONFIG_SERIAL_8250
+	if (early_serial_setup(&port) != 0)
 		printk("Early serial init of port 0 failed\n");
-	}
+#endif
 
-#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
+#ifdef CONFIG_SERIAL_TEXT_DEBUG
 	/* Configure debug serial access */
 	gen550_init(0, &port);
+#endif
+#ifdef CONFIG_KGDB_8250
+	kgdb8250_add_port(0, &port);
+#endif
 
+#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB_8250)
 	/* Purge TLB entry added in head_44x.S for early serial access */
 	_tlbie(UART0_IO_BASE);
 #endif
@@ -259,14 +266,18 @@ ebony_early_serial_map(void)
 	port.uartclk = clocks.uart1;
 	port.line = 1;
 
-	if (early_serial_setup(&port) != 0) {
+#ifdef CONFIG_SERIAL_8250
+	if (early_serial_setup(&port) != 1)
 		printk("Early serial init of port 1 failed\n");
-	}
+#endif
 
-#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
+#ifdef CONFIG_SERIAL_TEXT_DEBUG
 	/* Configure debug serial access */
 	gen550_init(1, &port);
 #endif
+#ifdef CONFIG_KGDB_8250
+	kgdb8250_add_port(1, &port);
+#endif
 }
 
 static void __init
@@ -352,8 +363,4 @@ void __init platform_init(unsigned long 
 
 	ppc_md.nvram_read_val = todc_direct_read_val;
 	ppc_md.nvram_write_val = todc_direct_write_val;
-#ifdef CONFIG_KGDB
-	ppc_md.early_serial_map = ebony_early_serial_map;
-#endif
 }
-
Index: linux-2.6.13/arch/ppc/platforms/4xx/ocotea.c
===================================================================
--- linux-2.6.13.orig/arch/ppc/platforms/4xx/ocotea.c
+++ linux-2.6.13/arch/ppc/platforms/4xx/ocotea.c
@@ -34,6 +34,7 @@
 #include <linux/tty.h>
 #include <linux/serial.h>
 #include <linux/serial_core.h>
+#include <linux/kgdb.h>
 
 #include <asm/system.h>
 #include <asm/pgtable.h>
@@ -260,14 +261,20 @@ ocotea_early_serial_map(void)
 	port.flags = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
 	port.line = 0;
 
-	if (early_serial_setup(&port) != 0) {
+#ifdef CONFIG_SERIAL_8250
+	if (early_serial_setup(&port) != 0)
 		printk("Early serial init of port 0 failed\n");
-	}
+#endif
 
-#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
+#ifdef CONFIG_SERIAL_TEXT_DEBUG
 	/* Configure debug serial access */
 	gen550_init(0, &port);
+#endif
+#ifdef CONFIG_KGDB_8250
+	kgdb8250_add_port(0, &port);
+#endif
 
+#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB_8250)
 	/* Purge TLB entry added in head_44x.S for early serial access */
 	_tlbie(UART0_IO_BASE);
 #endif
@@ -277,14 +284,18 @@ ocotea_early_serial_map(void)
 	port.uartclk = clocks.uart1;
 	port.line = 1;
 
-	if (early_serial_setup(&port) != 0) {
+#ifdef CONFIG_SERIAL_8250
+	if (early_serial_setup(&port) != 1)
 		printk("Early serial init of port 1 failed\n");
-	}
+#endif
 
-#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
+#ifdef CONFIG_SERIAL_TEXT_DEBUG
 	/* Configure debug serial access */
 	gen550_init(1, &port);
 #endif
+#ifdef CONFIG_KGDB_8250
+	kgdb8250_add_port(1, &port);
+#endif
 }
 
 static void __init
@@ -363,8 +374,5 @@ void __init platform_init(unsigned long 
 
 	ppc_md.nvram_read_val = todc_direct_read_val;
 	ppc_md.nvram_write_val = todc_direct_write_val;
-#ifdef CONFIG_KGDB
-	ppc_md.early_serial_map = ocotea_early_serial_map;
-#endif
 	ppc_md.init = ocotea_init;
 }
Index: linux-2.6.13/arch/ppc/platforms/4xx/xilinx_ml300.c
===================================================================
--- linux-2.6.13.orig/arch/ppc/platforms/4xx/xilinx_ml300.c
+++ linux-2.6.13/arch/ppc/platforms/4xx/xilinx_ml300.c
@@ -42,9 +42,6 @@
  *      ppc4xx_map_io				arch/ppc/syslib/ppc4xx_setup.c
  *  start_kernel				init/main.c
  *    setup_arch				arch/ppc/kernel/setup.c
- * #if defined(CONFIG_KGDB)
- *      *ppc_md.kgdb_map_scc() == gen550_kgdb_map_scc
- * #endif
  *      *ppc_md.setup_arch == ml300_setup_arch	this file
  *        ppc4xx_setup_arch			arch/ppc/syslib/ppc4xx_setup.c
  *          ppc4xx_find_bridges			arch/ppc/syslib/ppc405_pci.c
@@ -83,7 +80,6 @@ ml300_map_io(void)
 static void __init
 ml300_early_serial_map(void)
 {
-#ifdef CONFIG_SERIAL_8250
 	struct serial_state old_ports[] = { SERIAL_PORT_DFNS };
 	struct uart_port port;
 	int i;
@@ -99,11 +95,14 @@ ml300_early_serial_map(void)
 		port.flags = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
 		port.line = i;
 
-		if (early_serial_setup(&port) != 0) {
+#ifdef CONFIG_SERIAL_8250
+		if (early_serial_setup(&port) != 0)
 			printk("Early serial init of port %d failed\n", i);
-		}
+#endif
+#ifdef CONFIG_KGDB_8250
+		kgdb8250_add_port(i, &port)
+#endif
 	}
-#endif /* CONFIG_SERIAL_8250 */
 }
 
 void __init
@@ -138,9 +137,4 @@ platform_init(unsigned long r3, unsigned
 #if defined(XPAR_POWER_0_POWERDOWN_BASEADDR)
 	ppc_md.power_off = xilinx_power_off;
 #endif
-
-#ifdef CONFIG_KGDB
-	ppc_md.early_serial_map = ml300_early_serial_map;
-#endif
 }
-
Index: linux-2.6.13/arch/ppc/platforms/85xx/sbc8560.c
===================================================================
--- linux-2.6.13.orig/arch/ppc/platforms/85xx/sbc8560.c
+++ linux-2.6.13/arch/ppc/platforms/85xx/sbc8560.c
@@ -54,7 +54,6 @@
 #include <syslib/ppc85xx_common.h>
 #include <syslib/ppc85xx_setup.h>
 
-#ifdef CONFIG_SERIAL_8250
 static void __init
 sbc8560_early_serial_map(void)
 {
@@ -70,27 +69,34 @@ sbc8560_early_serial_map(void)
         uart_req.membase = ioremap(uart_req.mapbase, MPC85xx_UART0_SIZE);
 	uart_req.type = PORT_16650;
 
-#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
-        gen550_init(0, &uart_req);
+#ifdef CONFIG_SERIAL_8250
+	if (early_serial_setup(&uart_req) != 0)
+		printk("Early serial init of port 0 failed\n");
 #endif
- 
-        if (early_serial_setup(&uart_req) != 0)
-                printk("Early serial init of port 0 failed\n");
- 
+#ifdef CONFIG_SERIAL_TEXT_DEBUG
+	gen550_init(0, &uart_req);
+#endif
+#ifdef CONFIG_KGDB_8250
+	kgdb8250_add_port(0, &uart_req);
+#endif
+
         /* Assume early_serial_setup() doesn't modify uart_req */
 	uart_req.line = 1;
         uart_req.mapbase = UARTB_ADDR;
         uart_req.membase = ioremap(uart_req.mapbase, MPC85xx_UART1_SIZE);
 	uart_req.irq = MPC85xx_IRQ_EXT10;
- 
-#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
-        gen550_init(1, &uart_req);
+
+#ifdef CONFIG_SERIAL_8250
+	if (early_serial_setup(&uart_req) != 0)
+		printk("Early serial init of port 1 failed\n");
 #endif
- 
-        if (early_serial_setup(&uart_req) != 0)
-                printk("Early serial init of port 1 failed\n");
-}
+#ifdef CONFIG_SERIAL_TEXT_DEBUG
+	gen550_init(1, &uart_req);
 #endif
+#ifdef CONFIG_KGDB_8250
+	kgdb8250_add_port(1, &uart_req);
+#endif
+}
 
 /* ************************************************************************
  *
@@ -118,9 +124,7 @@ sbc8560_setup_arch(void)
 	/* setup PCI host bridges */
 	mpc85xx_setup_hose();
 #endif
-#ifdef CONFIG_SERIAL_8250
 	sbc8560_early_serial_map();
-#endif
 #ifdef CONFIG_SERIAL_TEXT_DEBUG
 	/* Invalidate the entry we stole earlier the serial ports
 	 * should be properly mapped */ 
Index: linux-2.6.13/arch/ppc/platforms/chestnut.c
===================================================================
--- linux-2.6.13.orig/arch/ppc/platforms/chestnut.c
+++ linux-2.6.13/arch/ppc/platforms/chestnut.c
@@ -496,7 +496,7 @@ chestnut_power_off(void)
 static void __init
 chestnut_map_io(void)
 {
-#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
+#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB_8250)
 	io_block_mapping(CHESTNUT_UART_BASE, CHESTNUT_UART_BASE, 0x100000,
 		_PAGE_IO);
 #endif
@@ -571,9 +571,6 @@ platform_init(unsigned long r3, unsigned
 #if defined(CONFIG_SERIAL_TEXT_DEBUG)
 	ppc_md.progress = gen550_progress;
 #endif
-#if defined(CONFIG_KGDB)
-	ppc_md.kgdb_map_scc = gen550_kgdb_map_scc;
-#endif
 
 	if (ppc_md.progress)
                 ppc_md.progress("chestnut_init(): exit", 0);
Index: linux-2.6.13/arch/ppc/platforms/cpci690.c
===================================================================
--- linux-2.6.13.orig/arch/ppc/platforms/cpci690.c
+++ linux-2.6.13/arch/ppc/platforms/cpci690.c
@@ -429,7 +429,7 @@ cpci690_set_bat(u32 addr, u32 size)
 	mb();
 }
 
-#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
+#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB_MPSC)
 static void __init
 cpci690_map_io(void)
 {
@@ -475,15 +475,13 @@ platform_init(unsigned long r3, unsigned
 	cpci690_set_bat(CPCI690_BR_BASE, 32 * MB);
 	cpci690_br_base = CPCI690_BR_BASE;
 
-#ifdef	CONFIG_SERIAL_TEXT_DEBUG
+#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB_MPSC)
 	ppc_md.setup_io_mappings = cpci690_map_io;
+#ifdef CONFIG_SERIAL_TEXT_DEBUG
 	ppc_md.progress = mv64x60_mpsc_progress;
 	mv64x60_progress_init(CONFIG_MV64X60_NEW_BASE);
 #endif	/* CONFIG_SERIAL_TEXT_DEBUG */
-#ifdef	CONFIG_KGDB
-	ppc_md.setup_io_mappings = cpci690_map_io;
-	ppc_md.early_serial_map = cpci690_early_serial_map;
-#endif	/* CONFIG_KGDB */
+#endif	/* defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB_MPSC) */
 
 #if defined(CONFIG_SERIAL_MPSC)
 	platform_notify = cpci690_platform_notify;
Index: linux-2.6.13/arch/ppc/platforms/mcpn765.c
===================================================================
--- linux-2.6.13.orig/arch/ppc/platforms/mcpn765.c
+++ linux-2.6.13/arch/ppc/platforms/mcpn765.c
@@ -519,9 +519,4 @@ platform_init(unsigned long r3, unsigned
 #ifdef CONFIG_SERIAL_TEXT_DEBUG
 	ppc_md.progress = gen550_progress;
 #endif
-#ifdef CONFIG_KGDB
-	ppc_md.kgdb_map_scc = gen550_kgdb_map_scc;
-#endif
-
-	return;
 }
Index: linux-2.6.13/arch/ppc/platforms/pcore.c
===================================================================
--- linux-2.6.13.orig/arch/ppc/platforms/pcore.c
+++ linux-2.6.13/arch/ppc/platforms/pcore.c
@@ -346,7 +346,4 @@ platform_init(unsigned long r3, unsigned
 #ifdef CONFIG_SERIAL_TEXT_DEBUG
 	ppc_md.progress = gen550_progress;
 #endif
-#ifdef CONFIG_KGDB
-	ppc_md.kgdb_map_scc = gen550_kgdb_map_scc;
-#endif
 }
Index: linux-2.6.13/arch/ppc/platforms/pplus.c
===================================================================
--- linux-2.6.13.orig/arch/ppc/platforms/pplus.c
+++ linux-2.6.13/arch/ppc/platforms/pplus.c
@@ -908,9 +908,6 @@ platform_init(unsigned long r3, unsigned
 #ifdef CONFIG_SERIAL_TEXT_DEBUG
 	ppc_md.progress = gen550_progress;
 #endif				/* CONFIG_SERIAL_TEXT_DEBUG */
-#ifdef CONFIG_KGDB
-	ppc_md.kgdb_map_scc = gen550_kgdb_map_scc;
-#endif
 #ifdef CONFIG_SMP
 	ppc_md.smp_ops = &pplus_smp_ops;
 #endif				/* CONFIG_SMP */
Index: linux-2.6.13/arch/ppc/platforms/sandpoint.c
===================================================================
--- linux-2.6.13.orig/arch/ppc/platforms/sandpoint.c
+++ linux-2.6.13/arch/ppc/platforms/sandpoint.c
@@ -751,9 +751,6 @@ platform_init(unsigned long r3, unsigned
 	ppc_md.nvram_read_val = todc_mc146818_read_val;
 	ppc_md.nvram_write_val = todc_mc146818_write_val;
 
-#ifdef CONFIG_KGDB
-	ppc_md.kgdb_map_scc = gen550_kgdb_map_scc;
-#endif
 #ifdef CONFIG_SERIAL_TEXT_DEBUG
 	ppc_md.progress = gen550_progress;
 #endif
Index: linux-2.6.13/arch/ppc/platforms/spruce.c
===================================================================
--- linux-2.6.13.orig/arch/ppc/platforms/spruce.c
+++ linux-2.6.13/arch/ppc/platforms/spruce.c
@@ -181,26 +181,32 @@ spruce_early_serial_map(void)
 	serial_req.membase = (u_char *)UART0_IO_BASE;
 	serial_req.regshift = 0;
 
-#if defined(CONFIG_KGDB) || defined(CONFIG_SERIAL_TEXT_DEBUG)
-	gen550_init(0, &serial_req);
-#endif
 #ifdef CONFIG_SERIAL_8250
 	if (early_serial_setup(&serial_req) != 0)
 		printk("Early serial init of port 0 failed\n");
 #endif
+#ifdef CONFIG_SERIAL_TEXT_DEBUG
+	gen550_init(0, &serial_req);
+#endif
+#ifdef CONFIG_KGDB_8250
+	kgdb8250_add_port(0, &port);
+#endif
 
 	/* Assume early_serial_setup() doesn't modify serial_req */
 	serial_req.line = 1;
 	serial_req.irq = UART1_INT;
 	serial_req.membase = (u_char *)UART1_IO_BASE;
 
-#if defined(CONFIG_KGDB) || defined(CONFIG_SERIAL_TEXT_DEBUG)
-	gen550_init(1, &serial_req);
-#endif
 #ifdef CONFIG_SERIAL_8250
 	if (early_serial_setup(&serial_req) != 0)
 		printk("Early serial init of port 1 failed\n");
 #endif
+#ifdef CONFIG_SERIAL_TEXT_DEBUG
+	gen550_init(1, &serial_req);
+#endif
+#ifdef CONFIG_KGDB_8250
+	kgdb8250_add_port(1, &serial_req);
+#endif
 }
 
 TODC_ALLOC();
@@ -319,7 +325,4 @@ platform_init(unsigned long r3, unsigned
 #ifdef CONFIG_SERIAL_TEXT_DEBUG
 	ppc_md.progress = gen550_progress;
 #endif /* CONFIG_SERIAL_TEXT_DEBUG */
-#ifdef CONFIG_KGDB
-	ppc_md.kgdb_map_scc = gen550_kgdb_map_scc;
-#endif
 }
Index: linux-2.6.13/arch/ppc/syslib/gen550.h
===================================================================
--- linux-2.6.13.orig/arch/ppc/syslib/gen550.h
+++ linux-2.6.13/arch/ppc/syslib/gen550.h
@@ -13,4 +13,3 @@
 
 extern void gen550_progress(char *, unsigned short);
 extern void gen550_init(int, struct uart_port *);
-extern void gen550_kgdb_map_scc(void);
Index: linux-2.6.13/arch/ppc/syslib/gen550_kgdb.c
===================================================================
--- linux-2.6.13.orig/arch/ppc/syslib/gen550_kgdb.c
+++ /dev/null
@@ -1,86 +0,0 @@
-/*
- * arch/ppc/syslib/gen550_kgdb.c
- *
- * Generic 16550 kgdb support intended to be useful on a variety
- * of platforms.  To enable this support, it is necessary to set
- * the CONFIG_GEN550 option.  Any virtual mapping of the serial
- * port(s) to be used can be accomplished by setting
- * ppc_md.early_serial_map to a platform-specific mapping function.
- *
- * Adapted from ppc4xx_kgdb.c.
- *
- * Author: Matt Porter <mporter@kernel.crashing.org>
- *
- * 2002-2004 (c) MontaVista Software, Inc.  This file is licensed under
- * the terms of the GNU General Public License version 2.  This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- */
-
-#include <linux/config.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-
-#include <asm/machdep.h>
-
-extern unsigned long serial_init(int, void *);
-extern unsigned long serial_getc(unsigned long);
-extern unsigned long serial_putc(unsigned long, unsigned char);
-
-#if defined(CONFIG_KGDB_TTYS0)
-#define KGDB_PORT 0
-#elif defined(CONFIG_KGDB_TTYS1)
-#define KGDB_PORT 1
-#elif defined(CONFIG_KGDB_TTYS2)
-#define KGDB_PORT 2
-#elif defined(CONFIG_KGDB_TTYS3)
-#define KGDB_PORT 3
-#else
-#error "invalid kgdb_tty port"
-#endif
-
-static volatile unsigned int kgdb_debugport;
-
-void putDebugChar(unsigned char c)
-{
-	if (kgdb_debugport == 0)
-		kgdb_debugport = serial_init(KGDB_PORT, NULL);
-
-	serial_putc(kgdb_debugport, c);
-}
-
-int getDebugChar(void)
-{
-	if (kgdb_debugport == 0)
-		kgdb_debugport = serial_init(KGDB_PORT, NULL);
-
-	return(serial_getc(kgdb_debugport));
-}
-
-void kgdb_interruptible(int enable)
-{
-	return;
-}
-
-void putDebugString(char* str)
-{
-	while (*str != '\0') {
-		putDebugChar(*str);
-		str++;
-	}
-	putDebugChar('\r');
-	return;
-}
-
-/*
- * Note: gen550_init() must be called already on the port we are going
- * to use.
- */
-void
-gen550_kgdb_map_scc(void)
-{
-	printk(KERN_DEBUG "kgdb init\n");
-	if (ppc_md.early_serial_map)
-		ppc_md.early_serial_map();
-	kgdb_debugport = serial_init(KGDB_PORT, NULL);
-}
Index: linux-2.6.13/arch/ppc/syslib/ibm44x_common.c
===================================================================
--- linux-2.6.13.orig/arch/ppc/syslib/ibm44x_common.c
+++ linux-2.6.13/arch/ppc/syslib/ibm44x_common.c
@@ -161,9 +161,6 @@ void __init ibm44x_platform_init(void)
 #ifdef CONFIG_SERIAL_TEXT_DEBUG
 	ppc_md.progress = gen550_progress;
 #endif /* CONFIG_SERIAL_TEXT_DEBUG */
-#ifdef CONFIG_KGDB
-	ppc_md.kgdb_map_scc = gen550_kgdb_map_scc;
-#endif
 
 	/*
 	 * The Abatron BDI JTAG debugger does not tolerate others
Index: linux-2.6.13/arch/ppc/syslib/Makefile
===================================================================
--- linux-2.6.13.orig/arch/ppc/syslib/Makefile
+++ linux-2.6.13/arch/ppc/syslib/Makefile
@@ -87,7 +87,6 @@ obj-$(CONFIG_PCI_8260)		+= m82xx_pci.o i
 obj-$(CONFIG_8260_PCI9)		+= m8260_pci_erratum9.o
 obj-$(CONFIG_CPM2)		+= cpm2_common.o cpm2_pic.o
 ifeq ($(CONFIG_PPC_GEN550),y)
-obj-$(CONFIG_KGDB)		+= gen550_kgdb.o gen550_dbg.o
 obj-$(CONFIG_SERIAL_TEXT_DEBUG)	+= gen550_dbg.o
 endif
 ifeq ($(CONFIG_SERIAL_MPSC_CONSOLE),y)
Index: linux-2.6.13/arch/ppc/syslib/mv64x60.c
===================================================================
--- linux-2.6.13.orig/arch/ppc/syslib/mv64x60.c
+++ linux-2.6.13/arch/ppc/syslib/mv64x60.c
@@ -239,6 +239,12 @@ static struct resource mv64x60_mpsc0_res
 		.end	= MV64x60_IRQ_SDMA_0,
 		.flags	= IORESOURCE_IRQ,
 	},
+	[4] = {
+		.name	= "mpsc 0 irq",
+		.start	= MV64x60_IRQ_MPSC_0,
+		.end	= MV64x60_IRQ_MPSC_0,
+		.flags	= IORESOURCE_IRQ,
+	},
 };
 
 static struct platform_device mpsc0_device = {
@@ -296,6 +302,12 @@ static struct resource mv64x60_mpsc1_res
 		.end	= MV64360_IRQ_SDMA_1,
 		.flags	= IORESOURCE_IRQ,
 	},
+	[4] = {
+		.name	= "mpsc 1 irq",
+		.start	= MV64360_IRQ_MPSC_1,
+		.end	= MV64360_IRQ_MPSC_1,
+		.flags	= IORESOURCE_IRQ,
+	},
 };
 
 static struct platform_device mpsc1_device = {
@@ -1435,12 +1447,46 @@ mv64x60_pd_fixup(struct mv64x60_handle *
 static int __init
 mv64x60_add_pds(void)
 {
-	return platform_add_devices(mv64x60_pd_devs,
-		ARRAY_SIZE(mv64x60_pd_devs));
+	int i, ret = 0;
+
+	for (i = 0; i < ARRAY_SIZE(mv64x60_pd_devs); i++) {
+		if (mv64x60_pd_devs[i]) {
+			ret = platform_device_register(mv64x60_pd_devs[i]);
+		}
+		if (ret) {
+			while (--i >= 0)
+				platform_device_unregister(mv64x60_pd_devs[i]);
+			break;
+		}
+	}
+	return ret;
 }
 arch_initcall(mv64x60_add_pds);
 
 /*
+ * mv64x60_early_get_pdev_data()
+ *
+ * Get the data associated with a platform device by name and number.
+ */
+struct platform_device * __init
+mv64x60_early_get_pdev_data(const char *name, int id, int remove)
+{
+	int i;
+	struct platform_device *pdev;
+
+	for (i = 0; i <ARRAY_SIZE(mv64x60_pd_devs); i++) {
+		if ((pdev = mv64x60_pd_devs[i]) &&
+			pdev->id == id &&
+			!strcmp(pdev->name, name)) {
+			if (remove)
+				mv64x60_pd_devs[i] = NULL;
+			return pdev;
+		}
+	}
+	return NULL;
+}
+
+/*
  *****************************************************************************
  *
  *	GT64260-Specific Routines
@@ -1866,6 +1912,12 @@ gt64260b_chip_specific_init(struct mv64x
 		r->start = MV64x60_IRQ_SDMA_0;
 		r->end = MV64x60_IRQ_SDMA_0;
 	}
+	if ((r = platform_get_resource(&mpsc1_device, IORESOURCE_IRQ, 1))
+		!= NULL) {
+
+		r->start = GT64260_IRQ_MPSC_1;
+		r->end = GT64260_IRQ_MPSC_1;
+	}
 #endif
 
 	return;
Index: linux-2.6.13/arch/ppc/syslib/mv64x60_dbg.c
===================================================================
--- linux-2.6.13.orig/arch/ppc/syslib/mv64x60_dbg.c
+++ linux-2.6.13/arch/ppc/syslib/mv64x60_dbg.c
@@ -36,7 +36,7 @@ static struct mv64x60_handle	mv64x60_dbg
 void
 mv64x60_progress_init(u32 base)
 {
-	mv64x60_dbg_bh.v_base = base;
+	mv64x60_dbg_bh.v_base = (void*)base;
 	return;
 }
 
@@ -71,53 +71,3 @@ mv64x60_mpsc_progress(char *s, unsigned 
 	return;
 }
 #endif	/* CONFIG_SERIAL_TEXT_DEBUG */
-
-
-#if defined(CONFIG_KGDB)
-
-#if defined(CONFIG_KGDB_TTYS0)
-#define KGDB_PORT 0
-#elif defined(CONFIG_KGDB_TTYS1)
-#define KGDB_PORT 1
-#else
-#error "Invalid kgdb_tty port"
-#endif
-
-void
-putDebugChar(unsigned char c)
-{
-	mv64x60_polled_putc(KGDB_PORT, (char)c);
-}
-
-int
-getDebugChar(void)
-{
-	unsigned char	c;
-
-	while (!mv64x60_polled_getc(KGDB_PORT, &c));
-	return (int)c;
-}
-
-void
-putDebugString(char* str)
-{
-	while (*str != '\0') {
-		putDebugChar(*str);
-		str++;
-	}
-	putDebugChar('\r');
-	return;
-}
-
-void
-kgdb_interruptible(int enable)
-{
-}
-
-void
-kgdb_map_scc(void)
-{
-	if (ppc_md.early_serial_map)
-		ppc_md.early_serial_map();
-}
-#endif	/* CONFIG_KGDB */
Index: linux-2.6.13/arch/ppc/syslib/ppc85xx_setup.c
===================================================================
--- linux-2.6.13.orig/arch/ppc/syslib/ppc85xx_setup.c
+++ linux-2.6.13/arch/ppc/syslib/ppc85xx_setup.c
@@ -71,7 +71,6 @@ mpc85xx_calibrate_decr(void)
 	mtspr(SPRN_TCR, TCR_DIE);
 }
 
-#ifdef CONFIG_SERIAL_8250
 void __init
 mpc85xx_early_serial_map(void)
 {
@@ -87,7 +86,7 @@ mpc85xx_early_serial_map(void)
 	pdata[0].mapbase += binfo->bi_immr_base;
 	pdata[0].membase = ioremap(pdata[0].mapbase, MPC85xx_UART0_SIZE);
 
-#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
+#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB_8250)
 	memset(&serial_req, 0, sizeof (serial_req));
 	serial_req.iotype = SERIAL_IO_MEM;
 	serial_req.mapbase = pdata[0].mapbase;
@@ -95,18 +94,24 @@ mpc85xx_early_serial_map(void)
 	serial_req.regshift = 0;
 
 	gen550_init(0, &serial_req);
+#ifdef CONFIG_KGDB_8250
+	kgdb8250_add_port(0, &serial_req);
+#endif
 #endif
 
 	pdata[1].uartclk = binfo->bi_busfreq;
 	pdata[1].mapbase += binfo->bi_immr_base;
 	pdata[1].membase = ioremap(pdata[1].mapbase, MPC85xx_UART0_SIZE);
 
-#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
+#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB_8250)
 	/* Assume gen550_init() doesn't modify serial_req */
 	serial_req.mapbase = pdata[1].mapbase;
 	serial_req.membase = pdata[1].membase;
 
 	gen550_init(1, &serial_req);
+#ifdef CONFIG_KGDB_8250
+	kgdb8250_add_port(1, &serial_req);
+#endif
 #endif
 }
 #endif
@@ -365,5 +370,3 @@ mpc85xx_setup_hose(void)
 	return;
 }
 #endif /* CONFIG_PCI */
-
-
Index: linux-2.6.13/drivers/serial/kgdb_mpsc.c
===================================================================
--- /dev/null
+++ linux-2.6.13/drivers/serial/kgdb_mpsc.c
@@ -0,0 +1,313 @@
+/*
+ * drivers/serial/kgdb_mpsc.
+ *
+ * KGDB driver for the Marvell MultiProtocol Serial Controller (MPCS)
+ *
+ * Based on the polled boot loader driver by Ajit Prem (ajit.prem@motorola.com)
+ *
+ * Author: Randy Vinson <rvinson@mvista.com>
+ *
+ * 2005 (c) MontaVista Software, Inc.
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/config.h>
+#include <linux/kgdb.h>
+#include <linux/mv643xx.h>
+#include <linux/device.h>
+#include <asm/mv64x60.h>
+#include <asm/serial.h>
+#include <asm/io.h>
+#include <asm/delay.h>
+
+#include "mpsc.h"
+
+/* Speed of the UART. */
+#if defined(CONFIG_KGDB_9600BAUD)
+static int kgdbmpsc_baud = 9600;
+#elif defined(CONFIG_KGDB_19200BAUD)
+static int kgdbmpsc_baud = 19200;
+#elif defined(CONFIG_KGDB_38400BAUD)
+static int kgdbmpsc_baud = 38400;
+#elif defined(CONFIG_KGDB_57600BAUD)
+static int kgdbmpsc_baud = 57600;
+#else
+static int kgdbmpsc_baud = 115200;	/* Start with this if not given */
+#endif
+
+/* Index of the UART, matches ttyMX naming. */
+#if defined(CONFIG_KGDB_SERIAL_PORT_1)
+static int kgdbmpsc_ttyMM = 1;
+#else
+static int kgdbmpsc_ttyMM = 0;	/* Start with this if not given */
+#endif
+
+#define MPSC_INTR_REG_SELECT(x)	((x) + (8 * kgdbmpsc_ttyMM))
+
+static int kgdbmpsc_init(void);
+
+static struct platform_device mpsc_dev, shared_dev;
+
+static void __iomem *mpsc_base;
+static void __iomem *brg_base;
+static void __iomem *routing_base;
+static void __iomem *sdma_base;
+
+static unsigned int mpsc_irq;
+
+static void kgdb_write_debug_char(int c)
+{
+	u32 data;
+
+	data = readl(mpsc_base + MPSC_MPCR);
+	writeb(c, mpsc_base + MPSC_CHR_1);
+	mb();
+	data = readl(mpsc_base + MPSC_CHR_2);
+	data |= MPSC_CHR_2_TTCS;
+	writel(data, mpsc_base + MPSC_CHR_2);
+	mb();
+
+	while (readl(mpsc_base + MPSC_CHR_2) & MPSC_CHR_2_TTCS) ;
+}
+
+static int kgdb_get_debug_char(void)
+{
+	unsigned char c;
+
+	while (!(readl(sdma_base + MPSC_INTR_REG_SELECT(MPSC_INTR_CAUSE)) &
+		 MPSC_INTR_CAUSE_RCC)) ;
+
+	c = readb(mpsc_base + MPSC_CHR_10 + (1 << 1));
+	mb();
+	writeb(c, mpsc_base + MPSC_CHR_10 + (1 << 1));
+	mb();
+	writel(~MPSC_INTR_CAUSE_RCC, sdma_base +
+	       MPSC_INTR_REG_SELECT(MPSC_INTR_CAUSE));
+	return (c);
+}
+
+/*
+ * This is the receiver interrupt routine for the GDB stub.
+ * All that we need to do is verify that the interrupt happened on the
+ * line we're in charge of.  If this is true, schedule a breakpoint and
+ * return.
+ */
+static irqreturn_t
+kgdbmpsc_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	if (irq != mpsc_irq)
+		return IRQ_NONE;
+	/*
+	 * If  there is some other CPU in KGDB then this is a
+	 * spurious interrupt. so return without even checking a byte
+	 */
+	if (atomic_read(&debugger_active))
+		return IRQ_NONE;
+
+	if (readl(sdma_base + MPSC_INTR_REG_SELECT(MPSC_INTR_CAUSE)) &
+	    MPSC_INTR_CAUSE_RCC)
+		breakpoint();
+
+	return IRQ_HANDLED;
+}
+
+static int __init kgdbmpsc_init(void)
+{
+	struct mpsc_pdata *pdata;
+	u32 cdv;
+
+	if (!brg_base || !mpsc_base || !routing_base || !sdma_base)
+		return -1;
+
+	/* Set MPSC Routing to enable both ports */
+	writel(0x0, routing_base + MPSC_MRR);
+
+	/* MPSC 0/1 Rx & Tx get clocks BRG0/1 */
+	writel(0x00000100, routing_base + MPSC_RCRR);
+	writel(0x00000100, routing_base + MPSC_TCRR);
+
+	/* Disable all MPSC interrupts and clear any pending interrupts */
+	writel(0, sdma_base + MPSC_INTR_REG_SELECT(MPSC_INTR_MASK));
+	writel(0, sdma_base + MPSC_INTR_REG_SELECT(MPSC_INTR_CAUSE));
+
+	pdata = (struct mpsc_pdata *)mpsc_dev.dev.platform_data;
+
+	/* cdv = (clock/(2*16*baud rate)) for 16X mode. */
+	cdv = ((pdata->brg_clk_freq / (32 * kgdbmpsc_baud)) - 1);
+	writel((pdata->brg_clk_src << 18) | (1 << 16) | cdv,
+	       brg_base + BRG_BCR);
+
+	/* Put MPSC into UART mode, no null modem, 16x clock mode */
+	writel(0x000004c4, mpsc_base + MPSC_MMCRL);
+	writel(0x04400400, mpsc_base + MPSC_MMCRH);
+
+	writel(0, mpsc_base + MPSC_CHR_1);
+	writel(0, mpsc_base + MPSC_CHR_9);
+	writel(0, mpsc_base + MPSC_CHR_10);
+	writel(4, mpsc_base + MPSC_CHR_3);
+	writel(0x20000000, mpsc_base + MPSC_CHR_4);
+	writel(0x9000, mpsc_base + MPSC_CHR_5);
+	writel(0, mpsc_base + MPSC_CHR_6);
+	writel(0, mpsc_base + MPSC_CHR_7);
+	writel(0, mpsc_base + MPSC_CHR_8);
+
+	/* 8 data bits, 1 stop bit */
+	writel((3 << 12), mpsc_base + MPSC_MPCR);
+
+	/* Enter "hunt" mode */
+	writel((1 << 31), mpsc_base + MPSC_CHR_2);
+
+	udelay(100);
+	return 0;
+}
+
+static void __iomem *__init
+kgdbmpsc_map_resource(struct platform_device *pd, int type, int num)
+{
+	void __iomem *base = NULL;
+	struct resource *r;
+
+	if ((r = platform_get_resource(pd, IORESOURCE_MEM, num)))
+		base = ioremap(r->start, r->end - r->start + 1);
+	return base;
+}
+
+static void __iomem *__init
+kgdbmpsc_unmap_resource(struct platform_device *pd, int type, int num,
+			void __iomem * base)
+{
+	if (base)
+		iounmap(base);
+	return NULL;
+}
+
+static void __init
+kgdbmpsc_reserve_resource(struct platform_device *pd, int type, int num)
+{
+	struct resource *r;
+
+	if ((r = platform_get_resource(pd, IORESOURCE_MEM, num)))
+		request_mem_region(r->start, r->end - r->start + 1, "kgdb");
+}
+
+static int __init kgdbmpsc_local_init(void)
+{
+	if (!mpsc_dev.num_resources || !shared_dev.num_resources)
+		return 1;	/* failure */
+
+	mpsc_base = kgdbmpsc_map_resource(&mpsc_dev, IORESOURCE_MEM,
+					  MPSC_BASE_ORDER);
+	brg_base = kgdbmpsc_map_resource(&mpsc_dev, IORESOURCE_MEM,
+					 MPSC_BRG_BASE_ORDER);
+
+	/* get the platform data for the shared registers and get them mapped */
+	routing_base = kgdbmpsc_map_resource(&shared_dev,
+					     IORESOURCE_MEM,
+					     MPSC_ROUTING_BASE_ORDER);
+	sdma_base =
+	    kgdbmpsc_map_resource(&shared_dev, IORESOURCE_MEM,
+				  MPSC_SDMA_INTR_BASE_ORDER);
+
+	mpsc_irq = platform_get_irq(&mpsc_dev, 1);
+
+	if (mpsc_base && brg_base && routing_base && sdma_base)
+		return 0;	/* success */
+
+	return 1;		/* failure */
+}
+
+static void __init kgdbmpsc_local_exit(void)
+{
+	if (sdma_base)
+		sdma_base = kgdbmpsc_unmap_resource(&shared_dev, IORESOURCE_MEM,
+						    MPSC_SDMA_INTR_BASE_ORDER,
+						    sdma_base);
+	if (routing_base)
+		routing_base = kgdbmpsc_unmap_resource(&shared_dev,
+						       IORESOURCE_MEM,
+						       MPSC_ROUTING_BASE_ORDER,
+						       routing_base);
+	if (brg_base)
+		brg_base = kgdbmpsc_unmap_resource(&mpsc_dev, IORESOURCE_MEM,
+						   MPSC_BRG_BASE_ORDER,
+						   brg_base);
+	if (mpsc_base)
+		mpsc_base = kgdbmpsc_unmap_resource(&mpsc_dev, IORESOURCE_MEM,
+						    MPSC_BASE_ORDER, mpsc_base);
+}
+
+static void __init kgdbmpsc_update_pdata(struct platform_device *pdev)
+{
+
+	snprintf(pdev->dev.bus_id, BUS_ID_SIZE, "%s%u", pdev->name, pdev->id);
+}
+
+static int __init kgdbmpsc_pdev_init(void)
+{
+	struct platform_device *pdev;
+
+	/* get the platform data for the specified port. */
+	pdev = mv64x60_early_get_pdev_data(MPSC_CTLR_NAME, kgdbmpsc_ttyMM, 1);
+	if (pdev) {
+		memcpy(&mpsc_dev, pdev, sizeof(struct platform_device));
+		if (platform_notify) {
+			kgdbmpsc_update_pdata(&mpsc_dev);
+			platform_notify(&mpsc_dev.dev);
+		}
+
+		/* get the platform data for the shared registers. */
+		pdev = mv64x60_early_get_pdev_data(MPSC_SHARED_NAME, 0, 0);
+		if (pdev) {
+			memcpy(&shared_dev, pdev,
+			       sizeof(struct platform_device));
+			if (platform_notify) {
+				kgdbmpsc_update_pdata(&shared_dev);
+				platform_notify(&shared_dev.dev);
+			}
+		}
+	}
+	return 0;
+}
+
+postcore_initcall(kgdbmpsc_pdev_init);
+
+static int __init kgdbmpsc_init_io(void)
+{
+
+	kgdbmpsc_pdev_init();
+
+	if (kgdbmpsc_local_init()) {
+		kgdbmpsc_local_exit();
+		return -1;
+	}
+
+	if (kgdbmpsc_init() == -1)
+		return -1;
+	return 0;
+}
+
+static void __init kgdbmpsc_hookup_irq(void)
+{
+	unsigned int msk;
+	if (!request_irq(mpsc_irq, kgdbmpsc_interrupt, 0, "kgdb mpsc", NULL)) {
+		/* Enable interrupt */
+		msk = readl(sdma_base + MPSC_INTR_REG_SELECT(MPSC_INTR_MASK));
+		msk |= MPSC_INTR_CAUSE_RCC;
+		writel(msk, sdma_base + MPSC_INTR_REG_SELECT(MPSC_INTR_MASK));
+
+		kgdbmpsc_reserve_resource(&mpsc_dev, IORESOURCE_MEM,
+					  MPSC_BASE_ORDER);
+		kgdbmpsc_reserve_resource(&mpsc_dev, IORESOURCE_MEM,
+					  MPSC_BRG_BASE_ORDER);
+	}
+}
+
+struct kgdb_io kgdb_io_ops = {
+	.read_char = kgdb_get_debug_char,
+	.write_char = kgdb_write_debug_char,
+	.init = kgdbmpsc_init_io,
+	.late_init = kgdbmpsc_hookup_irq,
+};
Index: linux-2.6.13/drivers/serial/Makefile
===================================================================
--- linux-2.6.13.orig/drivers/serial/Makefile
+++ linux-2.6.13/drivers/serial/Makefile
@@ -50,6 +50,7 @@ obj-$(CONFIG_SERIAL_IMX) += imx.o
 obj-$(CONFIG_SERIAL_MPC52xx) += mpc52xx_uart.o
 obj-$(CONFIG_SERIAL_ICOM) += icom.o
 obj-$(CONFIG_SERIAL_M32R_SIO) += m32r_sio.o
+obj-$(CONFIG_KGDB_MPSC) += kgdb_mpsc.o
 obj-$(CONFIG_SERIAL_MPSC) += mpsc.o
 obj-$(CONFIG_ETRAX_SERIAL) += crisv10.o
 obj-$(CONFIG_SERIAL_JSM) += jsm/
Index: linux-2.6.13/drivers/serial/mpsc.h
===================================================================
--- linux-2.6.13.orig/drivers/serial/mpsc.h
+++ linux-2.6.13/drivers/serial/mpsc.h
@@ -207,6 +207,10 @@ struct mpsc_port_info *mpsc_device_remov
 #define	MPSC_RCRR			0x0004
 #define	MPSC_TCRR			0x0008
 
+/* MPSC Interrupt registers (offset from MV64x60_SDMA_INTR_OFFSET) */
+#define MPSC_INTR_CAUSE			0x0004
+#define MPSC_INTR_MASK			0x0084
+#define MPSC_INTR_CAUSE_RCC		(1<<6)
 /*
  *****************************************************************************
  *
Index: linux-2.6.13/include/asm-ppc/kgdb.h
===================================================================
--- linux-2.6.13.orig/include/asm-ppc/kgdb.h
+++ linux-2.6.13/include/asm-ppc/kgdb.h
@@ -2,6 +2,8 @@
  * kgdb.h: Defines and declarations for serial line source level
  *         remote debugging of the Linux kernel using gdb.
  *
+ * PPC Mods (C) 2004 Tom Rini (trini@mvista.com)
+ * PPC Mods (C) 2003 John Whitney (john.whitney@timesys.com)
  * PPC Mods (C) 1998 Michael Tesch (tesch@cs.wisc.edu)
  *
  * Copyright (C) 1995 David S. Miller (davem@caip.rutgers.edu)
@@ -12,46 +14,32 @@
 
 #ifndef __ASSEMBLY__
 
-/* Things specific to the gen550 backend. */
-struct uart_port;
-
-extern void gen550_progress(char *, unsigned short);
-extern void gen550_kgdb_map_scc(void);
-extern void gen550_init(int, struct uart_port *);
-
-/* Things specific to the pmac backend. */
-extern void zs_kgdb_hook(int tty_num);
-
-/* To init the kgdb engine. (called by serial hook)*/
-extern void set_debug_traps(void);
-
-/* To enter the debugger explicitly. */
-extern void breakpoint(void);
+#define BREAK_INSTR_SIZE	4
+#ifndef CONFIG_E500
+#define MAXREG			(PT_FPSCR+1)
+#else
+/* 32 GPRs (8 bytes), nip, msr, ccr, link, ctr, xer, acc (8 bytes), spefscr*/
+#define MAXREG                 ((32*2)+6+2+1)
+#endif
+#define NUMREGBYTES		(MAXREG * sizeof(int))
+#define BUFMAX			((NUMREGBYTES * 2) + 512)
+#define OUTBUFMAX		((NUMREGBYTES * 2) + 512)
+/* CR/LR, R1, R2, R13-R31 inclusive. */
+#define NUMCRITREGBYTES		(23 * sizeof(int))
+#define BREAKPOINT()		asm(".long 0x7d821008"); /* twge r2, r2 */
+#define CHECK_EXCEPTION_STACK()	1
+#define CACHE_FLUSH_IS_SAFE	1
 
 /* For taking exceptions
  * these are defined in traps.c
  */
+struct pt_regs;
 extern void (*debugger)(struct pt_regs *regs);
 extern int (*debugger_bpt)(struct pt_regs *regs);
 extern int (*debugger_sstep)(struct pt_regs *regs);
 extern int (*debugger_iabr_match)(struct pt_regs *regs);
 extern int (*debugger_dabr_match)(struct pt_regs *regs);
 extern void (*debugger_fault_handler)(struct pt_regs *regs);
-
-/* What we bring to the party */
-int kgdb_bpt(struct pt_regs *regs);
-int kgdb_sstep(struct pt_regs *regs);
-void kgdb(struct pt_regs *regs);
-int kgdb_iabr_match(struct pt_regs *regs);
-int kgdb_dabr_match(struct pt_regs *regs);
-
-/*
- * external low-level support routines (ie macserial.c)
- */
-extern void kgdb_interruptible(int); /* control interrupts from serial */
-extern void putDebugChar(char);   /* write a single character      */
-extern char getDebugChar(void);   /* read and return a single char */
-
 #endif /* !(__ASSEMBLY__) */
 #endif /* !(_PPC_KGDB_H) */
 #endif /* __KERNEL__ */
Index: linux-2.6.13/include/asm-ppc/machdep.h
===================================================================
--- linux-2.6.13.orig/include/asm-ppc/machdep.h
+++ linux-2.6.13/include/asm-ppc/machdep.h
@@ -59,9 +59,7 @@ struct machdep_calls {
 	unsigned long	(*find_end_of_memory)(void);
 	void		(*setup_io_mappings)(void);
 
-	void		(*early_serial_map)(void);
   	void		(*progress)(char *, unsigned short);
-	void		(*kgdb_map_scc)(void);
 
 	unsigned char 	(*nvram_read_val)(int addr);
 	void		(*nvram_write_val)(int addr, unsigned char val);
Index: linux-2.6.13/include/asm-ppc/mv64x60_defs.h
===================================================================
--- linux-2.6.13.orig/include/asm-ppc/mv64x60_defs.h
+++ linux-2.6.13/include/asm-ppc/mv64x60_defs.h
@@ -57,7 +57,8 @@
 #define	MV64x60_IRQ_I2C				37
 #define	MV64x60_IRQ_BRG				39
 #define	MV64x60_IRQ_MPSC_0			40
-#define	MV64x60_IRQ_MPSC_1			42
+#define	MV64360_IRQ_MPSC_1			41
+#define	GT64260_IRQ_MPSC_1			42
 #define	MV64x60_IRQ_COMM			43
 #define	MV64x60_IRQ_P0_GPP_0_7			56
 #define	MV64x60_IRQ_P0_GPP_8_15			57
Index: linux-2.6.13/include/asm-ppc/mv64x60.h
===================================================================
--- linux-2.6.13.orig/include/asm-ppc/mv64x60.h
+++ linux-2.6.13/include/asm-ppc/mv64x60.h
@@ -332,6 +332,8 @@ u32 mv64x60_calc_mem_size(struct mv64x60
 
 void mv64x60_progress_init(u32 base);
 void mv64x60_mpsc_progress(char *s, unsigned short hex);
+struct platform_device * mv64x60_early_get_pdev_data(const char *name,
+		int id, int remove);
 
 extern struct mv64x60_32bit_window
 	gt64260_32bit_windows[MV64x60_32BIT_WIN_COUNT];
Index: linux-2.6.13/lib/Kconfig.debug
===================================================================
--- linux-2.6.13.orig/lib/Kconfig.debug
+++ linux-2.6.13/lib/Kconfig.debug
@@ -168,7 +168,7 @@ config WANT_EXTRA_DEBUG_INFORMATION
 config KGDB
 	bool "KGDB: kernel debugging with remote gdb"
 	select WANT_EXTRA_DEBUG_INFORMATION
-	depends on DEBUG_KERNEL && (X86)
+	depends on DEBUG_KERNEL && (X86 || ((!SMP || BROKEN) && (PPC32)))
 	help
 	  If you say Y here, it will be possible to remotely debug the
 	  kernel using gdb. It is strongly suggested that you enable
@@ -194,6 +194,7 @@ choice
 	prompt "Method for KGDB communication"
 	depends on KGDB
 	default KGDB_ONLY_MODULES
+	default KGDB_MPSC if SERIAL_MPSC
 	help
 	  There are a number of different ways in which you can communicate
 	  with KGDB.  The most common is via serial, with the 8250 driver
@@ -210,4 +211,11 @@ config KGDB_ONLY_MODULES
 	  Use only kernel modules to configure KGDB I/O after the
 	  kernel is booted.
 
+config KGDB_MPSC
+	bool "KGDB on MV64x60 MPSC"
+	depends on SERIAL_MPSC
+	help
+	  Uses a Marvell GT64260B or MV64x60 Multi-Purpose Serial
+	  Controller (MPSC) channel. Note that the GT64260A is not
+	  supported.
 endchoice
_
