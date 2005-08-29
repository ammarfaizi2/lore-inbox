Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751291AbVH2QLw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbVH2QLw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 12:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbVH2QLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 12:11:19 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:5253 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751281AbVH2QLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 12:11:09 -0400
Subject: [patch 11/16] Add support for PowerPC64 platforms to KGDB
Date: Mon, 29 Aug 2005 09:11:08 -0700
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, trini@kernel.crashing.org,
       frowand@mvista.com, paulus@samba.org
From: Tom Rini <trini@kernel.crashing.org>
Message-Id: <resend.11.2982005.trini@kernel.crashing.org>
In-Reply-To: <resend.10.2982005.trini@kernel.crashing.org>
References: <resend.10.2982005.trini@kernel.crashing.org> <1.2982005.trini@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This adds basic KGDB support to ppc64, and support for kgdb8250 on the 'Maple'
board.  All of this was done by Frank Rowand (who is on vacation right now,
but I'll try and answer for him).  This should work on any ppc64 board via
kgdboe, so long as there is an eth driver that supports netpoll.  At the
moment this is mutually exclusive with XMON.  It is probably possible to allow
them to be chained, but that sounds dangerous to me.  This is similar to
ppc32, but ppc32 does not explicitly test.

---

 linux-2.6.13-trini/arch/ppc64/Kconfig.debug        |   14 
 linux-2.6.13-trini/arch/ppc64/kernel/Makefile      |    3 
 linux-2.6.13-trini/arch/ppc64/kernel/kgdb.c        |  422 +++++++++++++++++
 linux-2.6.13-trini/arch/ppc64/kernel/maple_setup.c |    5 
 linux-2.6.13-trini/arch/ppc64/kernel/setup.c       |   14 
 linux-2.6.13-trini/arch/ppc64/mm/fault.c           |    8 
 linux-2.6.13-trini/include/asm-ppc64/kgdb.h        |   55 ++
 linux-2.6.13-trini/lib/Kconfig.debug               |    2 
 8 files changed, 513 insertions(+), 10 deletions(-)

diff -puN arch/ppc64/Kconfig.debug~ppc64-lite arch/ppc64/Kconfig.debug
--- linux-2.6.13/arch/ppc64/Kconfig.debug~ppc64-lite	2005-08-08 19:16:03.000000000 -0700
+++ linux-2.6.13-trini/arch/ppc64/Kconfig.debug	2005-08-08 19:16:03.000000000 -0700
@@ -28,16 +28,9 @@ config DEBUG_STACK_USAGE
 
 	  This option will slow down process creation somewhat.
 
-config DEBUGGER
-	bool "Enable debugger hooks"
-	depends on DEBUG_KERNEL
-	help
-	  Include in-kernel hooks for kernel debuggers. Unless you are
-	  intending to debug the kernel, say N here.
-
 config XMON
 	bool "Include xmon kernel debugger"
-	depends on DEBUGGER && !PPC_ISERIES
+	depends on DEBUG_KERNEL && !PPC_ISERIES
 	help
 	  Include in-kernel hooks for the xmon kernel monitor/debugger.
 	  Unless you are intending to debug the kernel, say N here.
@@ -46,6 +39,11 @@ config XMON_DEFAULT
 	bool "Enable xmon by default"
 	depends on XMON
 
+config DEBUGGER
+	bool
+	depends on KGDB || XMON
+	default y
+
 config PPCDBG
 	bool "Include PPCDBG realtime debugging"
 	depends on DEBUG_KERNEL
diff -puN /dev/null arch/ppc64/kernel/kgdb.c
--- /dev/null	2005-08-08 08:07:04.272443000 -0700
+++ linux-2.6.13-trini/arch/ppc64/kernel/kgdb.c	2005-08-08 19:16:03.000000000 -0700
@@ -0,0 +1,422 @@
+/*
+ * arch/ppc64/kernel/kgdb.c
+ *
+ * PowerPC64 backend to the KGDB stub.
+ *
+ * Maintainer: Tom Rini <trini@kernel.crashing.org>
+ *
+ * Copied from arch/ppc/kernel/kgdb.c, updated for ppc64
+ *
+ * Copyright (C) 1996 Paul Mackerras (setjmp/longjmp)
+ * 1998 (c) Michael AK Tesch (tesch@cs.wisc.edu)
+ * Copyright (C) 2003 Timesys Corporation.
+ * 2004 (c) MontaVista Software, Inc.
+ * 2005 (c) MontaVista Software, Inc.
+ * PPC64 Mods (C) 2005 Frank Rowand (frowand@mvista.com)
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
+ * This table contains the mapping between PowerPC64 hardware trap types, and
+ * signals, which are primarily what GDB understands.  GDB and the kernel
+ * don't always agree on values, so we use constants taken from gdb-6.2.
+ */
+static struct hard_trap_info
+{
+	unsigned int tt;		/* Trap type code for powerpc */
+	unsigned char signo;		/* Signal that we map this trap into */
+} hard_trap_info[] = {
+	{ 0x0100, 0x02 /* SIGINT */  },		/* system reset */
+	{ 0x0200, 0x0b /* SIGSEGV */ },		/* machine check */
+	{ 0x0300, 0x0b /* SIGSEGV */ },		/* data access */
+	{ 0x0400, 0x0a /* SIGBUS */  },		/* instruction access */
+	{ 0x0480, 0x0a /* SIGBUS */  },		/* instruction segment */
+	{ 0x0500, 0x02 /* SIGINT */  },		/* interrupt */
+	{ 0x0600, 0x0a /* SIGBUS */  },		/* alignment */
+	{ 0x0700, 0x04 /* SIGILL */  },		/* program */
+	{ 0x0800, 0x08 /* SIGFPE */  },		/* fpu unavailable */
+	{ 0x0900, 0x0e /* SIGALRM */  },	/* decrementer */
+	{ 0x0a00, 0x04 /* SIGILL */  },		/* reserved */
+	{ 0x0b00, 0x04 /* SIGILL */  },		/* reserved */
+	{ 0x0c00, 0x14 /* SIGCHLD */ },		/* syscall */
+	{ 0x0d00, 0x05 /* SIGTRAP */  },	/* single step */
+	{ 0x0e00, 0x04 /* SIGILL */  },		/* reserved */
+	{ 0x0f00, 0x04 /* SIGILL */  },		/* performance monitor */
+	{ 0x0f20, 0x08 /* SIGFPE */  },		/* altivec unavailable */
+	{ 0x1300, 0x05 /* SIGTRAP */  },	/* instruction address break */
+	{ 0x1500, 0x04 /* SIGILL */  },		/* soft patch */
+	{ 0x1600, 0x04 /* SIGILL */  },		/* maintenance */
+	{ 0x1700, 0x04 /* SIGILL */  },		/* altivec assist */
+	{ 0x1800, 0x04 /* SIGILL */  },		/* thermal */
+	{ 0x2002, 0x05 /* SIGTRAP */},		/* debug */
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
+void kgdb_call_nmi_hook(void *ignored)
+{
+	kgdb_nmihook(smp_processor_id(), (void *)0);
+}
+
+void kgdb_roundup_cpus(unsigned long flags)
+{
+	local_irq_restore(flags);
+	smp_call_function(kgdb_call_nmi_hook, 0, 0, 0);
+	local_irq_save(flags);
+}
+
+/* KGDB functions to use existing PowerPC64 hooks. */
+static int kgdb_debugger(struct pt_regs *regs)
+{
+	return kgdb_handle_exception(0, computeSignal(regs->trap), 0, regs);
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
+#define PACK64(ptr,src) do { *(ptr++) = (src); } while(0)
+
+#define PACK32(ptr,src) do {          \
+	u32 *ptr32;                   \
+	ptr32 = (u32 *)ptr;           \
+	*(ptr32++) = (src);           \
+	ptr = (unsigned long *)ptr32; \
+	} while(0)
+
+void regs_to_gdb_regs(unsigned long *gdb_regs, struct pt_regs *regs)
+{
+	int reg;
+	unsigned long *ptr = gdb_regs;
+
+	memset(gdb_regs, 0, NUMREGBYTES);
+
+	for (reg = 0; reg < 32; reg++)
+		PACK64(ptr, regs->gpr[reg]);
+
+	/* fp registers not used by kernel, leave zero */
+	ptr += 32;
+
+	PACK64(ptr, regs->nip);
+	PACK64(ptr, regs->msr);
+	PACK32(ptr, regs->ccr);
+	PACK64(ptr, regs->link);
+	PACK64(ptr, regs->ctr);
+	PACK32(ptr, regs->xer);
+
+#if 0
+	Following are in struct thread_struct, not struct pt_regs,
+	ignoring for now since kernel does not use them.  Would it
+	make sense to get them from the thread that kgdb is set to?
+
+	If this code is enabled, update the definition of NUMREGBYTES to
+	include the vector registers and vector state registers.
+
+	PACK32(ptr, p->thread->fpscr);
+
+	/* vr registers not used by kernel, leave zero */
+	ptr += 64;
+
+	PACK32(ptr, p->thread->vscr);
+	PACK32(ptr, p->thread->vrsave);
+#else
+	/* fpscr not used by kernel, leave zero */
+	PACK32(ptr, 0);
+#endif
+
+	BUG_ON((unsigned long)ptr >
+	       (unsigned long)(((void *)gdb_regs) + NUMREGBYTES));
+}
+
+void sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct task_struct *p)
+{
+	struct pt_regs *regs = (struct pt_regs *)(p->thread.ksp +
+						  STACK_FRAME_OVERHEAD);
+	int reg;
+	unsigned long *ptr = gdb_regs;
+
+	memset(gdb_regs, 0, NUMREGBYTES);
+
+	/* Regs GPR0-2 */
+	for (reg = 0; reg < 3; reg++)
+		PACK64(ptr, regs->gpr[reg]);
+
+	/* Regs GPR3-13 are caller saved, not in regs->gpr[] */
+	for (reg = 3; reg < 14; reg++)
+		PACK64(ptr, 0);
+
+	/* Regs GPR14-31 */
+	for (reg = 14; reg < 32; reg++)
+		PACK64(ptr, regs->gpr[reg]);
+
+	/* fp registers not used by kernel, leave zero */
+	ptr += 32;
+
+	PACK64(ptr, regs->nip);
+	PACK64(ptr, regs->msr);
+	PACK32(ptr, regs->ccr);
+	PACK64(ptr, regs->link);
+	PACK64(ptr, regs->ctr);
+	PACK32(ptr, regs->xer);
+
+#if 0
+	Following are in struct thread_struct, not struct pt_regs,
+	ignoring for now since kernel does not use them.  Would it
+	make sense to get them from the thread that kgdb is set to?
+
+	If this code is enabled, update the definition of NUMREGBYTES to
+	include the vector registers and vector state registers.
+
+	PACK32(ptr, p->thread->fpscr);
+
+	/* vr registers not used by kernel, leave zero */
+	ptr += 64;
+
+	PACK32(ptr, p->thread->vscr);
+	PACK32(ptr, p->thread->vrsave);
+#else
+	/* fpscr not used by kernel, leave zero */
+	PACK32(ptr, 0);
+#endif
+
+	BUG_ON((unsigned long)ptr >
+	       (unsigned long)(((void *)gdb_regs) + NUMREGBYTES));
+}
+
+#define UNPACK64(dest,ptr) do { dest = *(ptr++); } while(0)
+
+#define UNPACK32(dest,ptr) do {       \
+	u32 *ptr32;                   \
+	ptr32 = (u32 *)ptr;           \
+	dest = *(ptr32++);            \
+	ptr = (unsigned long *)ptr32; \
+	} while(0)
+
+void gdb_regs_to_regs(unsigned long *gdb_regs, struct pt_regs *regs)
+{
+	int reg;
+	unsigned long *ptr = gdb_regs;
+
+	for (reg = 0; reg < 32; reg++)
+		UNPACK64(regs->gpr[reg], ptr);
+
+	/* fp registers not used by kernel, leave zero */
+	ptr += 32;
+
+	UNPACK64(regs->nip, ptr);
+	UNPACK64(regs->msr, ptr);
+	UNPACK32(regs->ccr, ptr);
+	UNPACK64(regs->link, ptr);
+	UNPACK64(regs->ctr, ptr);
+	UNPACK32(regs->xer, ptr);
+
+#if 0
+	Following are in struct thread_struct, not struct pt_regs,
+	ignoring for now since kernel does not use them.  Would it
+	make sense to get them from the thread that kgdb is set to?
+
+	If this code is enabled, update the definition of NUMREGBYTES to
+	include the vector registers and vector state registers.
+
+	/* fpscr, vscr, vrsave not used by kernel, leave unchanged */
+
+	UNPACK32(p->thread->fpscr, ptr);
+
+	/* vr registers not used by kernel, leave zero */
+	ptr += 64;
+
+	UNPACK32(p->thread->vscr, ptr);
+	UNPACK32(p->thread->vrsave, ptr);
+#endif
+
+	BUG_ON((unsigned long)ptr >
+	       (unsigned long)(((void *)gdb_regs) + NUMREGBYTES));
+}
+
+/*
+ * This function does PowerPC64 specific procesing for interfacing to gdb.
+ */
+int kgdb_arch_handle_exception(int vector, int signo, int err_code,
+			       char *remcom_in_buffer, char *remcom_out_buffer,
+			       struct pt_regs *linux_regs)
+{
+	char *ptr = &remcom_in_buffer[1];
+	unsigned long addr;
+
+	switch (remcom_in_buffer[0]) {
+		/*
+		 * sAA..AA   Step one instruction from AA..AA
+		 * This will return an error to gdb ..
+		 */
+	case 's':
+	case 'c':
+		/* handle the optional parameter */
+		if (kgdb_hex2long(&ptr, &addr))
+			linux_regs->nip = addr;
+
+		atomic_set(&cpu_doing_single_step, -1);
+		/* set the trace bit if we're stepping */
+		if (remcom_in_buffer[0] == 's') {
+			linux_regs->msr |= MSR_SE;
+			debugger_step = 1;
+			if (kgdb_contthread)
+				atomic_set(&cpu_doing_single_step,
+					   smp_processor_id());
+		}
+		return 0;
+	}
+
+	return -1;
+}
+
+int kgdb_fault_setjmp(unsigned long *curr_context)
+{
+	__asm__ __volatile__("mflr 0; std 0,0(%0)\n\
+			      std	1,8(%0)\n\
+			      std	2,16(%0)\n\
+			      mfcr 0; std 0,24(%0)\n\
+			      std	13,32(%0)\n\
+			      std	14,40(%0)\n\
+			      std	15,48(%0)\n\
+			      std	16,56(%0)\n\
+			      std	17,64(%0)\n\
+			      std	18,72(%0)\n\
+			      std	19,80(%0)\n\
+			      std	20,88(%0)\n\
+			      std	21,96(%0)\n\
+			      std	22,104(%0)\n\
+			      std	23,112(%0)\n\
+			      std	24,120(%0)\n\
+			      std	25,128(%0)\n\
+			      std	26,136(%0)\n\
+			      std	27,144(%0)\n\
+			      std	28,152(%0)\n\
+			      std	29,160(%0)\n\
+			      std	30,168(%0)\n\
+			      std	31,176(%0)\n" : : "r" (curr_context));
+	return 0;
+}
+
+void kgdb_fault_longjmp(unsigned long *curr_context)
+{
+	__asm__ __volatile__("ld	13,32(%0)\n\
+	 		      ld	14,40(%0)\n\
+			      ld	15,48(%0)\n\
+			      ld	16,56(%0)\n\
+			      ld	17,64(%0)\n\
+			      ld	18,72(%0)\n\
+			      ld	19,80(%0)\n\
+			      ld	20,88(%0)\n\
+			      ld	21,96(%0)\n\
+			      ld	22,104(%0)\n\
+			      ld	23,112(%0)\n\
+			      ld	24,120(%0)\n\
+			      ld	25,128(%0)\n\
+			      ld	26,136(%0)\n\
+			      ld	27,144(%0)\n\
+			      ld	28,152(%0)\n\
+			      ld	29,160(%0)\n\
+			      ld	30,168(%0)\n\
+			      ld	31,176(%0)\n\
+			      ld	0,24(%0)\n\
+			      mtcrf	0x38,0\n\
+			      ld	0,0(%0)\n\
+			      ld	1,8(%0)\n\
+			      ld	2,16(%0)\n\
+			      mtlr	0\n\
+			      mr	3,1\n" : : "r" (curr_context));
+}
+
+/*
+ * Global data
+ */
+struct kgdb_arch arch_kgdb_ops = {
+	.gdb_bpt_instr = {0x7d, 0x82, 0x10, 0x08},
+};
+
+int kgdb_not_implemented(struct pt_regs *regs)
+{
+	return 0;
+}
+
+int kgdb_arch_init(void)
+{
+#ifdef CONFIG_XMON
+#error Both XMON and KGDB selected in .config.  Unselect one of them.
+#endif
+
+	__debugger_ipi = kgdb_not_implemented;
+	__debugger = kgdb_debugger;
+	__debugger_bpt = kgdb_breakpoint;
+	__debugger_sstep = kgdb_singlestep;
+	__debugger_iabr_match = kgdb_iabr_match;
+	__debugger_dabr_match = kgdb_dabr_match;
+	__debugger_fault_handler = kgdb_not_implemented;
+
+	return 0;
+}
+
+arch_initcall(kgdb_arch_init);
diff -puN arch/ppc64/kernel/Makefile~ppc64-lite arch/ppc64/kernel/Makefile
--- linux-2.6.13/arch/ppc64/kernel/Makefile~ppc64-lite	2005-08-08 19:16:03.000000000 -0700
+++ linux-2.6.13-trini/arch/ppc64/kernel/Makefile	2005-08-08 19:16:03.000000000 -0700
@@ -2,7 +2,7 @@
 # Makefile for the linux ppc64 kernel.
 #
 
-EXTRA_CFLAGS	+= -mno-minimal-toc
+#EXTRA_CFLAGS	+= -mno-minimal-toc
 extra-y		:= head.o vmlinux.lds
 
 obj-y               :=	setup.o entry.o traps.o irq.o idle.o dma.o \
@@ -53,6 +53,7 @@ obj-$(CONFIG_HVCS)		+= hvcserver.o
 obj-$(CONFIG_IBMVIO)		+= vio.o
 obj-$(CONFIG_XICS)		+= xics.o
 obj-$(CONFIG_MPIC)		+= mpic.o
+obj-$(CONFIG_KGDB)		+= kgdb.o
 
 obj-$(CONFIG_PPC_PMAC)		+= pmac_setup.o pmac_feature.o pmac_pci.o \
 				   pmac_time.o pmac_nvram.o pmac_low_i2c.o
diff -puN arch/ppc64/kernel/maple_setup.c~ppc64-lite arch/ppc64/kernel/maple_setup.c
--- linux-2.6.13/arch/ppc64/kernel/maple_setup.c~ppc64-lite	2005-08-08 19:16:03.000000000 -0700
+++ linux-2.6.13-trini/arch/ppc64/kernel/maple_setup.c	2005-08-08 19:16:03.000000000 -0700
@@ -77,6 +77,7 @@ extern void maple_pcibios_fixup(void);
 extern int maple_pci_get_legacy_ide_irq(struct pci_dev *dev, int channel);
 extern void generic_find_legacy_serial_ports(u64 *physport,
 		unsigned int *default_speed);
+extern void add_kgdb_port(void);
 
 static void maple_restart(char *cmd)
 {
@@ -213,6 +214,10 @@ static void __init maple_init_early(void
 		DBG("Hello World !\n");
 	}
 
+#ifdef CONFIG_KGDB_8250
+	add_kgdb_port();
+#endif
+
 	/* Setup interrupt mapping options */
 	ppc64_interrupt_controller = IC_OPEN_PIC;
 
diff -puN arch/ppc64/kernel/setup.c~ppc64-lite arch/ppc64/kernel/setup.c
--- linux-2.6.13/arch/ppc64/kernel/setup.c~ppc64-lite	2005-08-08 19:16:03.000000000 -0700
+++ linux-2.6.13-trini/arch/ppc64/kernel/setup.c	2005-08-08 19:16:03.000000000 -0700
@@ -33,6 +33,7 @@
 #include <linux/unistd.h>
 #include <linux/serial.h>
 #include <linux/serial_8250.h>
+#include <linux/kgdb.h>
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/processor.h>
@@ -1258,6 +1259,7 @@ void __init generic_find_legacy_serial_p
 		serial_ports[index].iobase = reg->address;
 		serial_ports[index].irq = interrupts ? interrupts[0] : 0;
 		serial_ports[index].flags = ASYNC_BOOT_AUTOCONF;
+		serial_ports[index].line = index;
 
 		DBG("Added legacy port, index: %d, port: %x, irq: %d, clk: %d\n",
 		    index,
@@ -1311,6 +1313,18 @@ void __init generic_find_legacy_serial_p
 	DBG(" <- generic_find_legacy_serial_port()\n");
 }
 
+
+#ifdef CONFIG_KGDB_8250
+void add_kgdb_port(void)
+{
+	int ttyS;
+
+	ttyS = kgdb8250_get_ttyS();
+	if (ttyS < old_serial_count)
+		kgdb8250_add_platform_port(ttyS, &serial_ports[ttyS]);
+}
+#endif
+
 static struct platform_device serial_device = {
 	.name	= "serial8250",
 	.id	= 0,
diff -puN arch/ppc64/mm/fault.c~ppc64-lite arch/ppc64/mm/fault.c
--- linux-2.6.13/arch/ppc64/mm/fault.c~ppc64-lite	2005-08-08 19:16:03.000000000 -0700
+++ linux-2.6.13-trini/arch/ppc64/mm/fault.c	2005-08-08 19:16:03.000000000 -0700
@@ -29,6 +29,7 @@
 #include <linux/interrupt.h>
 #include <linux/smp_lock.h>
 #include <linux/module.h>
+#include <linux/kgdb.h>
 
 #include <asm/page.h>
 #include <asm/pgtable.h>
@@ -306,6 +307,13 @@ void bad_page_fault(struct pt_regs *regs
 		regs->nip = entry->fixup;
 		return;
 	}
+#ifdef CONFIG_KGDB
+	if (atomic_read(&debugger_active) && kgdb_may_fault) {
+		/* Restore our previous state. */
+		kgdb_fault_longjmp(kgdb_fault_jmp_regs);
+		/* Not reached. */
+	}
+#endif
 
 	/* kernel has accessed a bad area */
 	die("Kernel access of bad area", regs, sig);
diff -puN /dev/null include/asm-ppc64/kgdb.h
--- /dev/null	2005-08-08 08:07:04.272443000 -0700
+++ linux-2.6.13-trini/include/asm-ppc64/kgdb.h	2005-08-08 19:16:03.000000000 -0700
@@ -0,0 +1,55 @@
+/*
+ * kgdb.h: Defines and declarations for serial line source level
+ *         remote debugging of the Linux kernel using gdb.
+ *
+ * copied from include/asm-ppc, modified for ppc64
+ *
+ * PPC64 Mods (C) 2005 Frank Rowand (frowand@mvista.com)
+ * PPC Mods (C) 2004 Tom Rini (trini@mvista.com)
+ * PPC Mods (C) 2003 John Whitney (john.whitney@timesys.com)
+ * PPC Mods (C) 1998 Michael Tesch (tesch@cs.wisc.edu)
+ *
+ * Copyright (C) 1995 David S. Miller (davem@caip.rutgers.edu)
+ */
+#ifdef __KERNEL__
+#ifndef _PPC64_KGDB_H
+#define _PPC64_KGDB_H
+
+#ifndef __ASSEMBLY__
+
+#define BREAK_INSTR_SIZE	4
+#if 1
+/*
+ * Does not include vector registers and vector state registers.
+ *
+ * 64 bit (8 byte) registers:
+ *   32 gpr, 32 fpr, nip, msr, link, ctr
+ * 32 bit (4 byte) registers:
+ *   ccr, xer, fpscr
+ */
+#define NUMREGBYTES		((68 * 8) + (3 * 4))
+#else
+/*
+ * Includes vector registers and vector state registers.
+ *
+ * 128 bit (16 byte) registers:
+ *   32 vr
+ * 64 bit (8 byte) registers:
+ *   32 gpr, 32 fpr, nip, msr, link, ctr
+ * 32 bit (4 byte) registers:
+ *   ccr, xer, fpscr, vscr, vrsave
+ */
+#define NUMREGBYTES		((128 * 16) + (68 * 8) + (5 * 4))
+#endif
+#define NUMCRITREGBYTES		184
+#define BUFMAX			((NUMREGBYTES * 2) + 512)
+#define OUTBUFMAX		((NUMREGBYTES * 2) + 512)
+#define BREAKPOINT()		asm(".long 0x7d821008"); /* twge r2, r2 */
+#define CHECK_EXCEPTION_STACK()	1
+#define CACHE_FLUSH_IS_SAFE	1
+
+#endif /* !(__ASSEMBLY__) */
+
+#endif /* !(_PPC64_KGDB_H) */
+
+#endif /* __KERNEL__ */
diff -puN lib/Kconfig.debug~ppc64-lite lib/Kconfig.debug
--- linux-2.6.13/lib/Kconfig.debug~ppc64-lite	2005-08-08 19:16:03.000000000 -0700
+++ linux-2.6.13-trini/lib/Kconfig.debug	2005-08-10 10:53:35.000000000 -0700
@@ -163,7 +163,7 @@ config FRAME_POINTER
 config KGDB
 	bool "KGDB: kernel debugging with remote gdb"
 	select WANT_EXTRA_DEBUG_INFORMATION
-	depends on DEBUG_KERNEL && (ARM || X86 || MIPS32 || (SUPERH && !SUPERH64) || IA64 || X86_64 || ((!SMP || BROKEN) && PPC32))
+	depends on DEBUG_KERNEL && (ARM || X86 || MIPS32 || PPC64 || (SUPERH && !SUPERH64) || IA64 || X86_64 || ((!SMP || BROKEN) && PPC32))
 	help
 	  If you say Y here, it will be possible to remotely debug the
 	  kernel using gdb. It is strongly suggested that you enable
_
