Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261268AbUJ2TCQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbUJ2TCQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 15:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261607AbUJ2TBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 15:01:49 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:21914 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S263486AbUJ2Sdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 14:33:37 -0400
Subject: [patch 3/8] KGDB support for ppc32
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, trini@kernel.crashing.org,
       mporter@kernel.crashing.org
From: Tom Rini <trini@kernel.crashing.org>
Message-Id: <3.29102004.trini@kernel.crashing.org>
In-Reply-To: <2.29102004.trini@kernel.crashing.org>
References: <2.29102004.trini@kernel.crashing.org> <1.29102004.trini@kernel.crashing.org>
Date: Fri, 29 Oct 2004 11:33:29 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Cc: Matt Porter <mporter@kernel.crashing.org>
This adds KGDB support for ppc32 and was done by myself.  Note that this
currently doesn't work on 40x || BOOKE, but that problem is more generic (the
current ppc stub doesn't work either) and Matt Porter is close to having a
tested solution now.

---

 linux-2.6.10-rc1-trini/arch/ppc/Kconfig.debug          |   36 
 linux-2.6.10-rc1-trini/arch/ppc/kernel/Makefile        |    2 
 linux-2.6.10-rc1-trini/arch/ppc/kernel/irq.c           |    5 
 linux-2.6.10-rc1-trini/arch/ppc/kernel/kgdb.c          |  276 +++++
 linux-2.6.10-rc1-trini/arch/ppc/kernel/setup.c         |   16 
 linux-2.6.10-rc1-trini/arch/ppc/platforms/sandpoint.c  |   11 
 linux-2.6.10-rc1-trini/arch/ppc/syslib/Makefile        |    2 
 linux-2.6.10-rc1-trini/arch/ppc/syslib/ppc4xx_serial.c |    5 
 linux-2.6.10-rc1-trini/include/asm-ppc/kgdb.h          |   20 
 linux-2.6.10-rc1-trini/lib/Kconfig.debug               |    2 
 linux-2.6.10-rc1/arch/ppc/kernel/ppc-stub.c            |  879 -----------------
 linux-2.6.10-rc1/arch/ppc/syslib/gen550_kgdb.c         |   86 -
 linux-2.6.10-rc1/arch/ppc/syslib/ppc4xx_kgdb.c         |  124 --
 13 files changed, 295 insertions(+), 1169 deletions(-)

diff -puN arch/ppc/Kconfig.debug~ppc-lite arch/ppc/Kconfig.debug
--- linux-2.6.10-rc1/arch/ppc/Kconfig.debug~ppc-lite	2004-10-29 11:26:44.705391556 -0700
+++ linux-2.6.10-rc1-trini/arch/ppc/Kconfig.debug	2004-10-29 11:26:44.729385922 -0700
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
diff -puN arch/ppc/kernel/Makefile~ppc-lite arch/ppc/kernel/Makefile
--- linux-2.6.10-rc1/arch/ppc/kernel/Makefile~ppc-lite	2004-10-29 11:26:44.706391321 -0700
+++ linux-2.6.10-rc1-trini/arch/ppc/kernel/Makefile	2004-10-29 11:26:44.729385922 -0700
@@ -20,7 +20,7 @@ obj-$(CONFIG_POWER4)		+= cpu_setup_power
 obj-$(CONFIG_MODULES)		+= module.o ppc_ksyms.o
 obj-$(CONFIG_NOT_COHERENT_CACHE)	+= dma-mapping.o
 obj-$(CONFIG_PCI)		+= pci.o
-obj-$(CONFIG_KGDB)		+= ppc-stub.o
+obj-$(CONFIG_KGDB)		+= kgdb.o
 obj-$(CONFIG_SMP)		+= smp.o smp-tbsync.o
 obj-$(CONFIG_TAU)		+= temp.o
 obj-$(CONFIG_ALTIVEC)		+= vecemu.o vector.o
diff -puN arch/ppc/kernel/irq.c~ppc-lite arch/ppc/kernel/irq.c
--- linux-2.6.10-rc1/arch/ppc/kernel/irq.c~ppc-lite	2004-10-29 11:26:44.708390852 -0700
+++ linux-2.6.10-rc1-trini/arch/ppc/kernel/irq.c	2004-10-29 11:26:44.730385688 -0700
@@ -48,6 +48,7 @@
 #include <linux/cpumask.h>
 #include <linux/profile.h>
 #include <linux/bitops.h>
+#include <linux/kgdb.h>
 
 #include <asm/uaccess.h>
 #include <asm/system.h>
@@ -155,7 +156,9 @@ void do_IRQ(struct pt_regs *regs)
 	if (irq != -2 && first)
 		/* That's not SMP safe ... but who cares ? */
 		ppc_spurious_interrupts++;
-        irq_exit();
+	irq_exit();
+
+	kgdb_process_breakpoint();
 }
 
 void __init init_IRQ(void)
diff -puN /dev/null arch/ppc/kernel/kgdb.c
--- /dev/null	2004-10-25 00:35:20.587727328 -0700
+++ linux-2.6.10-rc1-trini/arch/ppc/kernel/kgdb.c	2004-10-29 11:26:44.730385688 -0700
@@ -0,0 +1,276 @@
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
+ * 1998 (c) Michael AK Tesch (tesch@cs.wisc.edu)
+ * Copyright (C) 2003 Timesys Corporation.
+ * KGDB for the PowerPC processor
+ */
+
+#include <linux/kernel.h>
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/debugger.h>
+#include <linux/kgdb.h>
+#include <asm/current.h>
+#include <asm/ptrace.h>
+#include <asm/processor.h>
+#include <asm/machdep.h>
+
+/* Convert the hardware trap type code to a unix signal number. */
+/*
+ * This table contains the mapping between PowerPC hardware trap types, and
+ * signals, which are primarily what GDB understands.
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
+	{ 0x2000, 0x05 /* SIGTRAP */},		/* debug */
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
+	return SIGHUP; /* default for things we don't know about */
+}
+
+/*
+ * Routines
+ */
+static void kgdb_debugger (struct pt_regs *regs)
+{
+	(*linux_debug_hook) (0, computeSignal(regs->trap), 0, regs);
+}
+
+static int kgdb_breakpoint (struct pt_regs *regs)
+{
+	if (user_mode(regs))
+		return 0;
+
+	(*linux_debug_hook) (0, SIGTRAP, 0, regs);
+
+	if (atomic_read (&kgdb_setting_breakpoint))
+		regs->nip += 4;
+
+	return 1;
+}
+
+static int kgdb_singlestep (struct pt_regs *regs)
+{
+	if (user_mode(regs))
+		return 0;
+
+	(*linux_debug_hook) (0, SIGTRAP, 0, regs);
+	return 1;
+}
+
+int kgdb_iabr_match(struct pt_regs *regs)
+{
+	if (user_mode(regs))
+		return 0;
+
+	(*linux_debug_hook) (0, computeSignal(regs->trap), 0, regs);
+	return 1;
+}
+
+int kgdb_dabr_match(struct pt_regs *regs)
+{
+	if (user_mode(regs))
+		return 0;
+
+	(*linux_debug_hook) (0, computeSignal(regs->trap), 0, regs);
+	return 1;
+}
+
+void regs_to_gdb_regs(unsigned long *gdb_regs, struct pt_regs *regs)
+{
+	int reg;
+	unsigned long *ptr = gdb_regs;
+
+	memset(gdb_regs, 0, MAXREG*4);
+
+	for (reg = 0; reg < 32; reg++)
+		*(ptr++) = regs->gpr[reg];
+
+	for (reg = 0; reg < 64; reg++)
+		*(ptr++) = 0;
+
+	*(ptr++) = regs->nip;
+	*(ptr++) = regs->msr;
+	*(ptr++) = regs->ccr;
+	*(ptr++) = regs->link;
+	*(ptr++) = regs->ctr;
+	*(ptr++) = regs->xer;
+}
+
+void sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct task_struct *p)
+{
+	struct pt_regs *regs = (struct pt_regs *) (p->thread.ksp +
+	                                           STACK_FRAME_OVERHEAD);
+	int reg;
+	unsigned long *ptr = gdb_regs;
+
+	memset(gdb_regs, 0, MAXREG*4);
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
+	for (reg = 0; reg < 64; reg++)
+		*(ptr++) = 0;
+
+	*(ptr++) = regs->nip;
+	*(ptr++) = regs->msr;
+	*(ptr++) = regs->ccr;
+	*(ptr++) = regs->link;
+	*(ptr++) = regs->ctr;
+	*(ptr++) = regs->xer;
+}
+
+void gdb_regs_to_regs(unsigned long *gdb_regs, struct pt_regs *regs)
+{
+	int reg;
+	unsigned long *ptr = gdb_regs;
+
+	for (reg = 0; reg < 32; reg++)
+		regs->gpr[reg] = *(ptr++);
+
+	for (reg = 0; reg < 64; reg++)
+		ptr++;
+
+	regs->nip = *(ptr++);
+	regs->msr = *(ptr++);
+	regs->ccr = *(ptr++);
+	regs->link = *(ptr++);
+	regs->ctr = *(ptr++);
+	regs->xer = *(ptr++);
+}
+
+/*
+ * This function does PoerPC specific procesing for interfacing to gdb.
+ */
+int kgdb_arch_handle_exception (int vector, int signo, int err_code,
+		char *remcom_in_buffer, char *remcom_out_buffer,
+		struct pt_regs *linux_regs)
+{
+	char *ptr;
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
+			if (kgdb_contthread && kgdb_contthread != current)
+			{
+				strcpy(remcom_out_buffer, "E00");
+				break;
+			}
+
+			/* handle the optional parameter */
+			ptr = &remcom_in_buffer[1];
+			if (kgdb_hex2long (&ptr, &addr))
+				linux_regs->nip = addr;
+
+			atomic_set(&cpu_doing_single_step,-1);
+			/* set the trace bit if we're stepping */
+			if (remcom_in_buffer[0] == 's')
+			{
+#if defined (CONFIG_40x) || defined(CONFIG_BOOKE)
+				linux_regs->msr |= MSR_DE;
+				current->thread.dbcr0 |= (DBCR0_IDM | DBCR0_IC);
+#else
+				linux_regs->msr |= MSR_SE;
+#endif
+				debugger_step = 1;
+				if (kgdb_contthread)
+					atomic_set(&cpu_doing_single_step,smp_processor_id());
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
+struct kgdb_arch arch_kgdb_ops =
+{
+	.gdb_bpt_instr = { 0x7d, 0x82, 0x10, 0x08 },
+};
+
+int kgdb_arch_init (void)
+{
+	debugger = kgdb_debugger;
+	debugger_bpt = kgdb_breakpoint;
+	debugger_sstep = kgdb_singlestep;
+	debugger_iabr_match = kgdb_iabr_match;
+	debugger_dabr_match = kgdb_dabr_match;
+
+	return 0;
+}
+arch_initcall(kgdb_arch_init);
diff -L arch/ppc/kernel/ppc-stub.c -puN arch/ppc/kernel/ppc-stub.c~ppc-lite /dev/null
--- linux-2.6.10-rc1/arch/ppc/kernel/ppc-stub.c
+++ /dev/null	2004-10-25 00:35:20.587727328 -0700
@@ -1,879 +0,0 @@
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
-#if defined(CONFIG_40x)
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
-	{ 0x2000, SIGTRAP},		/* debug */
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
-#if defined(CONFIG_40x)
-	*ptr++ = 'S';
-	*ptr++ = hexchars[sigval >> 4];
-	*ptr++ = hexchars[sigval & 0xf];
-#else
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
-#endif
-
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
-#if defined(CONFIG_40x)
-			strcpy(remcomOutBuffer, "OK");
-			putpacket(remcomOutBuffer);
-#endif
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
-#if defined(CONFIG_40x)
-			regs->msr |= MSR_DE;
-			regs->dbcr0 |= (DBCR0_IDM | DBCR0_IC);
-			mtmsr(msr);
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
diff -puN arch/ppc/kernel/setup.c~ppc-lite arch/ppc/kernel/setup.c
--- linux-2.6.10-rc1/arch/ppc/kernel/setup.c~ppc-lite	2004-10-29 11:26:44.713389678 -0700
+++ linux-2.6.10-rc1-trini/arch/ppc/kernel/setup.c	2004-10-29 11:26:44.733384983 -0700
@@ -40,10 +40,6 @@
 #include <asm/xmon.h>
 #include <asm/ocp.h>
 
-#if defined CONFIG_KGDB
-#include <asm/kgdb.h>
-#endif
-
 extern void platform_init(unsigned long r3, unsigned long r4,
 		unsigned long r5, unsigned long r6, unsigned long r7);
 extern void bootx_init(unsigned long r4, unsigned long phys);
@@ -699,18 +695,6 @@ void __init setup_arch(char **cmdline_p)
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
diff -puN arch/ppc/platforms/sandpoint.c~ppc-lite arch/ppc/platforms/sandpoint.c
--- linux-2.6.10-rc1/arch/ppc/platforms/sandpoint.c~ppc-lite	2004-10-29 11:26:44.715389209 -0700
+++ linux-2.6.10-rc1-trini/arch/ppc/platforms/sandpoint.c	2004-10-29 11:26:44.733384983 -0700
@@ -252,8 +252,7 @@ sandpoint_find_bridges(void)
 	return;
 }
 
-#if defined(CONFIG_SERIAL_8250) && \
-	(defined(CONFIG_KGDB) || defined(CONFIG_SERIAL_TEXT_DEBUG))
+#if defined(CONFIG_SERIAL_8250) && defined(CONFIG_SERIAL_TEXT_DEBUG)
 static void __init
 sandpoint_early_serial_map(void)
 {
@@ -689,16 +688,10 @@ platform_init(unsigned long r3, unsigned
 	ppc_md.nvram_read_val = todc_mc146818_read_val;
 	ppc_md.nvram_write_val = todc_mc146818_write_val;
 
-#if defined(CONFIG_SERIAL_8250) && \
-	(defined(CONFIG_KGDB) || defined(CONFIG_SERIAL_TEXT_DEBUG))
+#if defined(CONFIG_SERIAL_8250) && defined(CONFIG_SERIAL_TEXT_DEBUG)
 	sandpoint_early_serial_map();
-#ifdef CONFIG_KGDB
-	ppc_md.kgdb_map_scc = gen550_kgdb_map_scc;
-#endif
-#ifdef CONFIG_SERIAL_TEXT_DEBUG
 	ppc_md.progress = gen550_progress;
 #endif
-#endif
 
 #if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
 	ppc_ide_md.default_irq = sandpoint_ide_default_irq;
diff -puN arch/ppc/syslib/Makefile~ppc-lite arch/ppc/syslib/Makefile
--- linux-2.6.10-rc1/arch/ppc/syslib/Makefile~ppc-lite	2004-10-29 11:26:44.716388974 -0700
+++ linux-2.6.10-rc1-trini/arch/ppc/syslib/Makefile	2004-10-29 11:26:44.734384749 -0700
@@ -25,7 +25,6 @@ obj-$(CONFIG_GEN_RTC)		+= todc_time.o
 obj-$(CONFIG_PPC4xx_DMA)	+= ppc4xx_dma.o
 obj-$(CONFIG_PPC4xx_EDMA)	+= ppc4xx_sgdma.o
 ifeq ($(CONFIG_40x),y)
-obj-$(CONFIG_KGDB)		+= ppc4xx_kgdb.o
 obj-$(CONFIG_PCI)		+= indirect_pci.o pci_auto.o ppc405_pci.o
 endif
 endif
@@ -72,7 +71,6 @@ obj-$(CONFIG_PCI_8260)		+= m8260_pci.o i
 obj-$(CONFIG_8260_PCI9)		+= m8260_pci_erratum9.o
 obj-$(CONFIG_CPM2)		+= cpm2_common.o cpm2_pic.o
 ifeq ($(CONFIG_PPC_GEN550),y)
-obj-$(CONFIG_KGDB)		+= gen550_kgdb.o gen550_dbg.o
 obj-$(CONFIG_SERIAL_TEXT_DEBUG)	+= gen550_dbg.o
 endif
 obj-$(CONFIG_BOOTX_TEXT)	+= btext.o
diff -L arch/ppc/syslib/gen550_kgdb.c -puN arch/ppc/syslib/gen550_kgdb.c~ppc-lite /dev/null
--- linux-2.6.10-rc1/arch/ppc/syslib/gen550_kgdb.c
+++ /dev/null	2004-10-25 00:35:20.587727328 -0700
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
diff -L arch/ppc/syslib/ppc4xx_kgdb.c -puN arch/ppc/syslib/ppc4xx_kgdb.c~ppc-lite /dev/null
--- linux-2.6.10-rc1/arch/ppc/syslib/ppc4xx_kgdb.c
+++ /dev/null	2004-10-25 00:35:20.587727328 -0700
@@ -1,124 +0,0 @@
-#include <linux/config.h>
-#include <linux/types.h>
-#include <asm/ibm4xx.h>
-#include <linux/kernel.h>
-
-
-
-#define LSR_DR		0x01 /* Data ready */
-#define LSR_OE		0x02 /* Overrun */
-#define LSR_PE		0x04 /* Parity error */
-#define LSR_FE		0x08 /* Framing error */
-#define LSR_BI		0x10 /* Break */
-#define LSR_THRE	0x20 /* Xmit holding register empty */
-#define LSR_TEMT	0x40 /* Xmitter empty */
-#define LSR_ERR		0x80 /* Error */
-
-#include <platforms/4xx/ibm_ocp.h>
-
-extern struct NS16550* COM_PORTS[];
-#ifndef NULL
-#define NULL 0x00
-#endif
-
-static volatile struct NS16550 *kgdb_debugport = NULL;
-
-volatile struct NS16550 *
-NS16550_init(int chan)
-{
-	volatile struct NS16550 *com_port;
-	int quot;
-#ifdef BASE_BAUD
-	quot = BASE_BAUD / 9600;
-#else
-	quot = 0x000c; /* 0xc = 9600 baud (on a pc) */
-#endif
-
-	com_port = (struct NS16550 *) COM_PORTS[chan];
-
-	com_port->lcr = 0x00;
-	com_port->ier = 0xFF;
-	com_port->ier = 0x00;
-	com_port->lcr = com_port->lcr | 0x80; /* Access baud rate */
-	com_port->dll = ( quot & 0x00ff ); /* 0xc = 9600 baud */
-	com_port->dlm = ( quot & 0xff00 ) >> 8;
-	com_port->lcr = 0x03; /* 8 data, 1 stop, no parity */
-	com_port->mcr = 0x00; /* RTS/DTR */
-	com_port->fcr = 0x07; /* Clear & enable FIFOs */
-
-	return( com_port );
-}
-
-
-void
-NS16550_putc(volatile struct NS16550 *com_port, unsigned char c)
-{
-	while ((com_port->lsr & LSR_THRE) == 0)
-		;
-	com_port->thr = c;
-	return;
-}
-
-unsigned char
-NS16550_getc(volatile struct NS16550 *com_port)
-{
-	while ((com_port->lsr & LSR_DR) == 0)
-		;
-	return (com_port->rbr);
-}
-
-unsigned char
-NS16550_tstc(volatile struct NS16550 *com_port)
-{
-	return ((com_port->lsr & LSR_DR) != 0);
-}
-
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
-void putDebugChar( unsigned char c )
-{
-	if ( kgdb_debugport == NULL )
-		kgdb_debugport = NS16550_init(KGDB_PORT);
-	NS16550_putc( kgdb_debugport, c );
-}
-
-int getDebugChar( void )
-{
-	if (kgdb_debugport == NULL)
-		kgdb_debugport = NS16550_init(KGDB_PORT);
-
-	return(NS16550_getc(kgdb_debugport));
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
-void
-kgdb_map_scc(void)
-{
-	printk("kgdb init \n");
-	kgdb_debugport = NS16550_init(KGDB_PORT);
-}
diff -puN arch/ppc/syslib/ppc4xx_serial.c~ppc-lite arch/ppc/syslib/ppc4xx_serial.c
--- linux-2.6.10-rc1/arch/ppc/syslib/ppc4xx_serial.c~ppc-lite	2004-10-29 11:26:44.722387566 -0700
+++ linux-2.6.10-rc1-trini/arch/ppc/syslib/ppc4xx_serial.c	2004-10-29 11:26:44.734384749 -0700
@@ -20,11 +20,6 @@
 
 #if defined(CONFIG_IBM405GP) || defined(CONFIG_IBM405CR)
 
-#ifdef CONFIG_KGDB
-#include <asm/kgdb.h>
-#include <linux/init.h>
-#endif
-
 #ifdef CONFIG_DEBUG_BRINGUP
 
 #include <linux/console.h>
diff -puN include/asm-ppc/kgdb.h~ppc-lite include/asm-ppc/kgdb.h
--- linux-2.6.10-rc1/include/asm-ppc/kgdb.h~ppc-lite	2004-10-29 11:26:44.723387331 -0700
+++ linux-2.6.10-rc1-trini/include/asm-ppc/kgdb.h	2004-10-29 11:26:44.735384514 -0700
@@ -2,6 +2,8 @@
  * kgdb.h: Defines and declarations for serial line source level
  *         remote debugging of the Linux kernel using gdb.
  *
+ * PPC Mods (C) 2004 Tom Rini (trini@mvista.com)
+ * PPC Mods (C) 2003 John Whitney (john.whitney@timesys.com)
  * PPC Mods (C) 1998 Michael Tesch (tesch@cs.wisc.edu)
  *
  * Copyright (C) 1995 David S. Miller (davem@caip.rutgers.edu)
@@ -12,6 +14,15 @@
 
 #ifndef __ASSEMBLY__
 
+#define BREAK_INSTR_SIZE	4
+#define MAXREG			(PT_FPSCR+1)
+#define NUMREGBYTES		(MAXREG * sizeof(int))
+#define BUFMAX			((NUMREGBYTES * 2) + 512)
+#define OUTBUFMAX		((NUMREGBYTES * 2) + 512)
+#define BREAKPOINT()		asm(".long 0x7d821008"); /* twge r2, r2 */
+
+#define CHECK_EXCEPTION_STACK() 	1
+
 /* Things specific to the gen550 backend. */
 struct uart_port;
 
@@ -19,15 +30,6 @@ extern void gen550_progress(char *, unsi
 extern void gen550_kgdb_map_scc(void);
 extern void gen550_init(int, struct uart_port *);
 
-/* Things specific to the pmac backend. */
-extern void zs_kgdb_hook(int tty_num);
-
-/* To init the kgdb engine. (called by serial hook)*/
-extern void set_debug_traps(void);
-
-/* To enter the debugger explicitly. */
-extern void breakpoint(void);
-
 /* For taking exceptions
  * these are defined in traps.c
  */
diff -puN lib/Kconfig.debug~ppc-lite lib/Kconfig.debug
--- linux-2.6.10-rc1/lib/Kconfig.debug~ppc-lite	2004-10-29 11:26:44.725386861 -0700
+++ linux-2.6.10-rc1-trini/lib/Kconfig.debug	2004-10-29 11:32:57.778768052 -0700
@@ -115,7 +115,7 @@ endif
 
 config KGDB
 	bool "KGDB: kernel debugging with remote gdb"
-	depends on DEBUG_KERNEL && (X86)
+	depends on DEBUG_KERNEL && (X86 || ((!SMP || BROKEN) && (PPC32)))
 	help
 	  If you say Y here, it will be possible to remotely debug the
 	  kernel using gdb. This enlarges your kernel image disk size by
_
