Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261877AbUKHP3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbUKHP3i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 10:29:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbUKHP3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 10:29:38 -0500
Received: from mx1.redhat.com ([66.187.233.31]:49347 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261877AbUKHOfz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 09:35:55 -0500
Date: Mon, 8 Nov 2004 14:34:19 GMT
Message-Id: <200411081434.iA8EYJ7M023588@warthog.cambridge.redhat.com>
From: dhowells@redhat.com
To: torvalds@osdl.org, akpm@osdl.org, davidm@snapgear.com
cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: [PATCH 14/20] FRV: Fujitsu FR-V arch include files
In-Reply-To: <44bd214c-3193-11d9-8962-0002b3163499@redhat.com> 
References: <44bd214c-3193-11d9-8962-0002b3163499@redhat.com> 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch provides the arch-specific include files for the Fujitsu
FR-V CPU arch.

Signed-Off-By: dhowells@redhat.com
---
diffstat frv-include_3-2610rc1mm3.diff
 registers.h   |  255 ++++++++++++++++++++++++++++++++++++
 resource.h    |   53 +++++++
 scatterlist.h |   32 ++++
 sections.h    |   46 ++++++
 segment.h     |   46 ++++++
 semaphore.h   |  161 +++++++++++++++++++++++
 sembuf.h      |   26 +++
 serial-regs.h |   44 ++++++
 serial.h      |   19 ++
 setup.h       |   25 +++
 shmbuf.h      |   43 ++++++
 shmparam.h    |    7 +
 sigcontext.h  |   26 +++
 siginfo.h     |   12 +
 signal.h      |  187 +++++++++++++++++++++++++++
 smp.h         |   10 +
 socket.h      |   51 +++++++
 sockios.h     |   13 +
 spinlock.h    |   17 ++
 spr-regs.h    |  401 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 stat.h        |  100 ++++++++++++++
 statfs.h      |    7 +
 string.h      |   51 +++++++
 suspend.h     |   20 ++
 system.h      |  123 +++++++++++++++++
 termbits.h    |  177 +++++++++++++++++++++++++
 termios.h     |   74 ++++++++++
 thread_info.h |  158 ++++++++++++++++++++++
 timer-regs.h  |  106 +++++++++++++++
 timex.h       |   25 +++
 tlb.h         |   23 +++
 tlbflush.h    |   76 ++++++++++
 topology.h    |   14 ++
 types.h       |   74 ++++++++++
 uaccess.h     |  317 +++++++++++++++++++++++++++++++++++++++++++++
 ucontext.h    |   12 +
 36 files changed, 2831 insertions(+)

diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/registers.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/registers.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/registers.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/registers.h	2004-11-05 14:13:04.159474152 +0000
@@ -0,0 +1,255 @@
+/* registers.h: register frame declarations
+ *
+ * Copyright (C) 2003 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+/*
+ * notes:
+ *
+ * (1) that the members of all these structures are carefully aligned to permit
+ *     usage of STD/STDF instructions
+ *
+ * (2) if you change these structures, you must change the code in
+ *     arch/frvnommu/kernel/{break.S,entry.S,switch_to.S,gdb-stub.c}
+ *
+ *
+ * the kernel stack space block looks like this:
+ *
+ *	+0x2000	+----------------------
+ *		| union {
+ *		|	struct user_context
+ *		|	struct pt_regs [user exception]
+ *		| }
+ *		+---------------------- <-- __kernel_frame0_ptr (maybe GR28)
+ *		|
+ *		| kernel stack
+ *		|
+ *		|......................
+ *		| struct pt_regs [kernel exception]
+ *		|...................... <-- __kernel_frame0_ptr (maybe GR28)
+ *		|
+ *		| kernel stack
+ *		|
+ *		|...................... <-- stack pointer (GR1)
+ *		|
+ *		| unused stack space
+ *		|
+ *		+----------------------
+ *		| struct thread_info
+ *	+0x0000	+---------------------- <-- __current_thread_info (GR15);
+ *	
+ * note that GR28 points to the current exception frame
+ */
+
+#ifndef _ASM_REGISTERS_H
+#define _ASM_REGISTERS_H
+
+#ifndef __ASSEMBLY__
+#define __OFFSET(X)	(X)
+#define __OFFSETC(X,N)	xxxxxxxxxxxxxxxxxxxxxxxx
+#else
+#define __OFFSET(X)	((X)*4)
+#define __OFFSETC(X,N)	((X)*4+(N))
+#endif
+
+/*****************************************************************************/
+/*
+ * Exception/Interrupt frame
+ * - held on kernel stack
+ * - 8-byte aligned on stack (old SP is saved in frame)
+ * - GR0 is fixed 0, so we don't save it
+ */
+#ifndef __ASSEMBLY__
+
+struct pt_regs {
+	unsigned long		psr;		/* Processor Status Register */
+	unsigned long		isr;		/* Integer Status Register */
+	unsigned long		ccr;		/* Condition Code Register */
+	unsigned long		cccr;		/* Condition Code for Conditional Insns Register */
+	unsigned long		lr;		/* Link Register */
+	unsigned long		lcr;		/* Loop Count Register */
+	unsigned long		pc;		/* Program Counter Register */
+	unsigned long		__status;	/* exception status */
+	unsigned long		syscallno;	/* syscall number or -1 */
+	unsigned long		orig_gr8;	/* original syscall arg #1 */
+	unsigned long		gner0;
+	unsigned long		gner1;
+	unsigned long long	iacc0;
+	unsigned long		tbr;		/* GR0 is fixed zero, so we use this for TBR */
+	unsigned long		sp;		/* GR1: USP/KSP */
+	unsigned long		fp;		/* GR2: FP */
+	unsigned long		gr3;
+	unsigned long		gr4;
+	unsigned long		gr5;
+	unsigned long		gr6;
+	unsigned long		gr7;		/* syscall number */
+	unsigned long		gr8;		/* 1st syscall param; syscall return */
+	unsigned long		gr9;		/* 2nd syscall param */
+	unsigned long		gr10;		/* 3rd syscall param */
+	unsigned long		gr11;		/* 4th syscall param */
+	unsigned long		gr12;		/* 5th syscall param */
+	unsigned long		gr13;		/* 6th syscall param */
+	unsigned long		gr14;
+	unsigned long		gr15;
+	unsigned long		gr16;		/* GP pointer */
+	unsigned long		gr17;		/* small data */
+	unsigned long		gr18;		/* PIC/PID */
+	unsigned long		gr19;
+	unsigned long		gr20;
+	unsigned long		gr21;
+	unsigned long		gr22;
+	unsigned long		gr23;
+	unsigned long		gr24;
+	unsigned long		gr25;
+	unsigned long		gr26;
+	unsigned long		gr27;
+	struct pt_regs		*next_frame;	/* GR28 - next exception frame */
+	unsigned long		gr29;		/* GR29 - OS reserved */
+	unsigned long		gr30;		/* GR30 - OS reserved */
+	unsigned long		gr31;		/* GR31 - OS reserved */
+} __attribute__((aligned(8)));
+
+#endif
+
+#define REG_PSR		__OFFSET( 0)	/* Processor Status Register */
+#define REG_ISR		__OFFSET( 1)	/* Integer Status Register */
+#define REG_CCR		__OFFSET( 2)	/* Condition Code Register */
+#define REG_CCCR	__OFFSET( 3)	/* Condition Code for Conditional Insns Register */
+#define REG_LR		__OFFSET( 4)	/* Link Register */
+#define REG_LCR		__OFFSET( 5)	/* Loop Count Register */
+#define REG_PC		__OFFSET( 6)	/* Program Counter */
+
+#define REG__STATUS	__OFFSET( 7)	/* exception status */
+#define REG__STATUS_STEP	0x00000001	/* - reenable single stepping on return */
+#define REG__STATUS_STEPPED	0x00000002	/* - single step caused exception */
+#define REG__STATUS_BROKE	0x00000004	/* - BREAK insn caused exception */
+#define REG__STATUS_SYSC_ENTRY	0x40000000	/* - T on syscall entry (ptrace.c only) */
+#define REG__STATUS_SYSC_EXIT	0x80000000	/* - T on syscall exit (ptrace.c only) */
+
+#define REG_SYSCALLNO	__OFFSET( 8)	/* syscall number or -1 */
+#define REG_ORIG_GR8	__OFFSET( 9)	/* saved GR8 for signal handling */
+#define REG_GNER0	__OFFSET(10)
+#define REG_GNER1	__OFFSET(11)
+#define REG_IACC0	__OFFSET(12)
+
+#define REG_TBR		__OFFSET(14)	/* Trap Vector Register */
+#define REG_GR(R)	__OFFSET((14+(R)))
+#define REG__END	REG_GR(32)
+
+#define REG_SP		REG_GR(1)
+#define REG_FP		REG_GR(2)
+#define REG_PREV_FRAME	REG_GR(28)	/* previous exception frame pointer (old gr28 value) */
+#define REG_CURR_TASK	REG_GR(29)	/* current task */
+
+/*****************************************************************************/
+/*
+ * extension tacked in front of the exception frame in debug mode
+ */
+#ifndef __ASSEMBLY__
+
+struct pt_debug_regs
+{
+	unsigned long		bpsr;
+	unsigned long		dcr;
+	unsigned long		brr;
+	unsigned long		nmar;
+	struct pt_regs		normal_regs;
+} __attribute__((aligned(8)));
+
+#endif
+
+#define REG_NMAR		__OFFSET(-1)
+#define REG_BRR			__OFFSET(-2)
+#define REG_DCR			__OFFSET(-3)
+#define REG_BPSR		__OFFSET(-4)
+#define REG__DEBUG_XTRA		__OFFSET(4)
+
+/*****************************************************************************/
+/*
+ * userspace registers
+ */
+#ifndef __ASSEMBLY__
+
+struct user_int_regs
+{
+	/* integer registers
+	 * - up to gr[31] mirror pt_regs
+	 * - total size must be multiple of 8 bytes
+	 */
+	unsigned long		psr;		/* Processor Status Register */
+	unsigned long		isr;		/* Integer Status Register */
+	unsigned long		ccr;		/* Condition Code Register */
+	unsigned long		cccr;		/* Condition Code for Conditional Insns Register */
+	unsigned long		lr;		/* Link Register */
+	unsigned long		lcr;		/* Loop Count Register */
+	unsigned long		pc;		/* Program Counter Register */
+	unsigned long		__status;	/* exception status */
+	unsigned long		syscallno;	/* syscall number or -1 */
+	unsigned long		orig_gr8;	/* original syscall arg #1 */
+	unsigned long		gner[2];
+	unsigned long long	iacc[1];
+
+	union {
+		unsigned long	tbr;
+		unsigned long	gr[64];
+	};
+};
+
+struct user_fpmedia_regs
+{
+	/* FP/Media registers */
+	unsigned long	fr[64];
+	unsigned long	fner[2];
+	unsigned long	msr[2];
+	unsigned long	acc[8];
+	unsigned char	accg[8];
+	unsigned long	fsr[1];
+};
+
+struct user_context
+{
+	struct user_int_regs		i;
+	struct user_fpmedia_regs	f;
+
+	/* we provide a context extension so that we can save the regs for CPUs that
+	 * implement many more of Fujitsu's lavish register spec
+	 */
+	void *extension;
+} __attribute__((aligned(8)));
+
+#endif
+
+#define NR_USER_INT_REGS	(14 + 64)
+#define NR_USER_FPMEDIA_REGS	(64 + 2 + 2 + 8 + 8/4 + 1)
+#define NR_USER_CONTEXT		(NR_USER_INT_REGS + NR_USER_FPMEDIA_REGS + 1)
+
+#define USER_CONTEXT_SIZE	(((NR_USER_CONTEXT + 1) & ~1) * 4)
+
+#define __THREAD_FRAME		__OFFSET(0)
+#define __THREAD_CURR		__OFFSET(1)
+#define __THREAD_SP		__OFFSET(2)
+#define __THREAD_FP		__OFFSET(3)
+#define __THREAD_LR		__OFFSET(4)
+#define __THREAD_PC		__OFFSET(5)
+#define __THREAD_GR(R)		__OFFSET(6 + (R) - 16)
+#define __THREAD_FRAME0		__OFFSET(19)
+#define __THREAD_USER		__OFFSET(19)
+
+#define __USER_INT		__OFFSET(0)
+#define __INT_GR(R)		__OFFSET(14 + (R))
+
+#define __USER_FPMEDIA		__OFFSET(NR_USER_INT_REGS)
+#define __FPMEDIA_FR(R)		__OFFSET(NR_USER_INT_REGS + (R))
+#define __FPMEDIA_FNER(R)	__OFFSET(NR_USER_INT_REGS + 64 + (R))
+#define __FPMEDIA_MSR(R)	__OFFSET(NR_USER_INT_REGS + 66 + (R))
+#define __FPMEDIA_ACC(R)	__OFFSET(NR_USER_INT_REGS + 68 + (R))
+#define __FPMEDIA_ACCG(R)	__OFFSETC(NR_USER_INT_REGS + 76, (R))
+#define __FPMEDIA_FSR(R)	__OFFSET(NR_USER_INT_REGS + 78 + (R))
+
+#endif /* _ASM_REGISTERS_H */
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/resource.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/resource.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/resource.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/resource.h	2004-11-05 14:13:04.164473730 +0000
@@ -0,0 +1,53 @@
+#ifndef _ASM_RESOURCE_H
+#define _ASM_RESOURCE_H
+
+/*
+ * Resource limits
+ */
+
+#define RLIMIT_CPU	0		/* CPU time in ms */
+#define RLIMIT_FSIZE	1		/* Maximum filesize */
+#define RLIMIT_DATA	2		/* max data size */
+#define RLIMIT_STACK	3		/* max stack size */
+#define RLIMIT_CORE	4		/* max core file size */
+#define RLIMIT_RSS	5		/* max resident set size */
+#define RLIMIT_NPROC	6		/* max number of processes */
+#define RLIMIT_NOFILE	7		/* max number of open files */
+#define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
+#define RLIMIT_AS	9		/* address space limit */
+#define RLIMIT_LOCKS	10		/* maximum file locks held */
+#define RLIMIT_SIGPENDING 11		/* max number of pending signals */
+#define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
+
+#define RLIM_NLIMITS	13
+
+
+/*
+ * SuS says limits have to be unsigned.
+ * Which makes a ton more sense anyway.
+ */
+#define RLIM_INFINITY	(~0UL)
+
+#ifdef __KERNEL__
+
+#define INIT_RLIMITS					\
+{							\
+	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{      _STK_LIM, RLIM_INFINITY },		\
+	{             0, RLIM_INFINITY },		\
+	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{             0,             0 },		\
+	{      INR_OPEN,     INR_OPEN  },		\
+	{   MLOCK_LIMIT,   MLOCK_LIMIT },		\
+	{ RLIM_INFINITY, RLIM_INFINITY },		\
+        { RLIM_INFINITY, RLIM_INFINITY },		\
+	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
+	{ MQ_BYTES_MAX, MQ_BYTES_MAX },			\
+}
+
+#endif /* __KERNEL__ */
+
+#endif /* _ASM_RESOURCE_H */
+
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/scatterlist.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/scatterlist.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/scatterlist.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/scatterlist.h	2004-11-05 14:13:04.168473392 +0000
@@ -0,0 +1,32 @@
+#ifndef _ASM_SCATTERLIST_H
+#define _ASM_SCATTERLIST_H
+
+/*
+ * Drivers must set either ->address or (preferred) ->page and ->offset
+ * to indicate where data must be transferred to/from.
+ *
+ * Using ->page is recommended since it handles highmem data as well as
+ * low mem. ->address is restricted to data which has a virtual mapping, and
+ * it will go away in the future. Updating to ->page can be automated very
+ * easily -- something like
+ *
+ * sg->address = some_ptr;
+ *
+ * can be rewritten as
+ *
+ * sg->page = virt_to_page(some_ptr);
+ * sg->offset = (unsigned long) some_ptr & ~PAGE_MASK;
+ *
+ * and that's it. There's no excuse for not highmem enabling YOUR driver. /jens
+ */
+struct scatterlist {
+	struct page	*page;		/* Location for highmem page, if any */
+	unsigned int	offset;		/* for highmem, page offset */
+
+	dma_addr_t	dma_address;
+	unsigned int	length;
+};
+
+#define ISA_DMA_THRESHOLD (0xffffffffUL)
+
+#endif /* !_ASM_SCATTERLIST_H */
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/sections.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/sections.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/sections.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/sections.h	2004-11-05 14:13:04.172473054 +0000
@@ -0,0 +1,46 @@
+/* sections.h: linkage layout variables
+ *
+ * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _ASM_SECTIONS_H
+#define _ASM_SECTIONS_H
+
+#ifndef __ASSEMBLY__
+
+#include <linux/types.h>
+#include <asm-generic/sections.h>
+
+#ifdef __KERNEL__
+
+/*
+ * we don't want to put variables in the GP-REL section if they're not used very much - that would
+ * be waste since GP-REL addressing is limited to GP16+/-2048
+ */
+#define __nongpreldata	__attribute__((section(".data")))
+#define __nongprelbss	__attribute__((section(".bss")))
+
+/*
+ * linker symbols
+ */
+extern const void __kernel_image_start, __kernel_image_end, __page_offset;
+
+extern unsigned long __nongprelbss memory_start;
+extern unsigned long __nongprelbss memory_end;
+extern unsigned long __nongprelbss rom_length;
+
+/* determine if we're running from ROM */
+static inline int is_in_rom(unsigned long addr)
+{
+	return 0; /* default case: not in ROM */
+}
+
+#endif
+#endif
+#endif /* _ASM_SECTIONS_H */
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/segment.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/segment.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/segment.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/segment.h	2004-11-05 14:13:04.176472716 +0000
@@ -0,0 +1,46 @@
+/* segment.h: MMU segment settings
+ *
+ * Copyright (C) 2003 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _ASM_SEGMENT_H
+#define _ASM_SEGMENT_H
+
+#include <linux/config.h>
+
+#ifndef __ASSEMBLY__
+
+typedef struct {
+	unsigned long seg;
+} mm_segment_t;
+
+#define MAKE_MM_SEG(s)	((mm_segment_t) { (s) })
+
+#define KERNEL_DS		MAKE_MM_SEG(0xdfffffffUL)
+
+#ifdef CONFIG_MMU
+#define USER_DS			MAKE_MM_SEG(TASK_SIZE - 1)
+#else
+#define USER_DS			KERNEL_DS
+#endif
+
+#define get_ds()		(KERNEL_DS)
+#define get_fs()		(__current_thread_info->addr_limit)
+#define segment_eq(a,b)		((a).seg == (b).seg)
+#define __kernel_ds_p()		segment_eq(get_fs(), KERNEL_DS)
+#define get_addr_limit()	(get_fs().seg)
+
+#define set_fs(_x)					\
+do {							\
+	__current_thread_info->addr_limit = (_x);	\
+} while(0)
+
+
+#endif /* __ASSEMBLY__ */
+#endif /* _ASM_SEGMENT_H */
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/semaphore.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/semaphore.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/semaphore.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/semaphore.h	2004-11-05 14:13:04.179472463 +0000
@@ -0,0 +1,161 @@
+/* semaphore.h: semaphores for the FR-V
+ *
+ * Copyright (C) 2003 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#ifndef _ASM_SEMAPHORE_H
+#define _ASM_SEMAPHORE_H
+
+#define RW_LOCK_BIAS		 0x01000000
+
+#ifndef __ASSEMBLY__
+
+#include <linux/linkage.h>
+#include <linux/wait.h>
+#include <linux/spinlock.h>
+#include <linux/rwsem.h>
+
+#define SEMAPHORE_DEBUG		WAITQUEUE_DEBUG
+
+/*
+ * the semaphore definition
+ * - if counter is >0 then there are tokens available on the semaphore for down to collect
+ * - if counter is <=0 then there are no spare tokens, and anyone that wants one must wait
+ * - if wait_list is not empty, then there are processes waiting for the semaphore
+ */
+struct semaphore {
+	unsigned		counter;
+	spinlock_t		wait_lock;
+	struct list_head	wait_list;
+#if SEMAPHORE_DEBUG
+	unsigned		__magic;
+#endif
+};
+
+#if SEMAPHORE_DEBUG
+# define __SEM_DEBUG_INIT(name) , (long)&(name).__magic
+#else
+# define __SEM_DEBUG_INIT(name)
+#endif
+
+
+#define __SEMAPHORE_INITIALIZER(name,count) \
+{ count, SPIN_LOCK_UNLOCKED, LIST_HEAD_INIT((name).wait_list) __SEM_DEBUG_INIT(name) }
+
+#define __MUTEX_INITIALIZER(name) \
+	__SEMAPHORE_INITIALIZER(name,1)
+
+#define __DECLARE_SEMAPHORE_GENERIC(name,count) \
+	struct semaphore name = __SEMAPHORE_INITIALIZER(name,count)
+
+#define DECLARE_MUTEX(name) __DECLARE_SEMAPHORE_GENERIC(name,1)
+#define DECLARE_MUTEX_LOCKED(name) __DECLARE_SEMAPHORE_GENERIC(name,0)
+
+static inline void sema_init (struct semaphore *sem, int val)
+{
+	*sem = (struct semaphore) __SEMAPHORE_INITIALIZER(*sem, val);
+}
+
+static inline void init_MUTEX (struct semaphore *sem)
+{
+	sema_init(sem, 1);
+}
+
+static inline void init_MUTEX_LOCKED (struct semaphore *sem)
+{
+	sema_init(sem, 0);
+}
+
+extern void __down(struct semaphore *sem, unsigned long flags);
+extern int  __down_interruptible(struct semaphore *sem, unsigned long flags);
+extern void __up(struct semaphore *sem);
+
+static inline void down(struct semaphore *sem)
+{
+	unsigned long flags;
+
+#if SEMAPHORE_DEBUG
+	CHECK_MAGIC(sem->__magic);
+#endif
+
+	spin_lock_irqsave(&sem->wait_lock, flags);
+	if (likely(sem->counter > 0)) {
+		sem->counter--;
+		spin_unlock_irqrestore(&sem->wait_lock, flags);
+	}
+	else {
+		__down(sem, flags);
+	}
+}
+
+static inline int down_interruptible(struct semaphore *sem)
+{
+	unsigned long flags;
+	int ret = 0;
+
+#if SEMAPHORE_DEBUG
+	CHECK_MAGIC(sem->__magic);
+#endif
+
+	spin_lock_irqsave(&sem->wait_lock, flags);
+	if (likely(sem->counter > 0)) {
+		sem->counter--;
+		spin_unlock_irqrestore(&sem->wait_lock, flags);
+	}
+	else {
+		ret = __down_interruptible(sem, flags);
+	}
+	return ret;
+}
+
+/*
+ * non-blockingly attempt to down() a semaphore.
+ * - returns zero if we acquired it
+ */
+static inline int down_trylock(struct semaphore *sem)
+{
+	unsigned long flags;
+	int success = 0;
+
+#if SEMAPHORE_DEBUG
+	CHECK_MAGIC(sem->__magic);
+#endif
+
+	spin_lock_irqsave(&sem->wait_lock, flags);
+	if (sem->counter > 0) {
+		sem->counter--;
+		success = 1;
+	}
+	spin_unlock_irqrestore(&sem->wait_lock, flags);
+	return !success;
+}
+
+static inline void up(struct semaphore *sem)
+{
+	unsigned long flags;
+
+#if SEMAPHORE_DEBUG
+	CHECK_MAGIC(sem->__magic);
+#endif
+
+	spin_lock_irqsave(&sem->wait_lock, flags);
+	if (!list_empty(&sem->wait_list))
+		__up(sem);
+	else
+		sem->counter++;
+	spin_unlock_irqrestore(&sem->wait_lock, flags);
+}
+
+static inline int sem_getcount(struct semaphore *sem)
+{
+	return sem->counter;
+}
+
+#endif /* __ASSEMBLY__ */
+
+#endif
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/sembuf.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/sembuf.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/sembuf.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/sembuf.h	2004-11-05 14:13:04.184472041 +0000
@@ -0,0 +1,26 @@
+#ifndef _ASM_SEMBUF_H
+#define _ASM_SEMBUF_H
+
+/* 
+ * The semid64_ds structure for FR-V architecture.
+ * Note extra padding because this structure is passed back and forth
+ * between kernel and user space.
+ *
+ * Pad space is left for:
+ * - 64-bit time_t to solve y2038 problem
+ * - 2 miscellaneous 32-bit values
+ */
+
+struct semid64_ds {
+	struct ipc64_perm	sem_perm;	/* permissions .. see ipc.h */
+	__kernel_time_t		sem_otime;	/* last semop time */
+	unsigned long		__unused1;
+	__kernel_time_t		sem_ctime;	/* last change time */
+	unsigned long		__unused2;
+	unsigned long		sem_nsems;	/* no. of semaphores in array */
+	unsigned long		__unused3;
+	unsigned long		__unused4;
+};
+
+#endif /* _ASM_SEMBUF_H */
+
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/serial.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/serial.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/serial.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/serial.h	2004-11-05 14:13:04.187471787 +0000
@@ -0,0 +1,19 @@
+/*
+ * serial.h
+ *
+ * Copyright (C) 2003 Develer S.r.l. (http://www.develer.com/)
+ * Author: Bernardo Innocenti <bernie@codewiz.org>
+ *
+ * Based on linux/include/asm-i386/serial.h
+ */
+#include <linux/config.h>
+#include <asm/serial-regs.h>
+
+/*
+ * the base baud is derived from the clock speed and so is variable
+ */
+#define BASE_BAUD 0
+
+#define STD_COM_FLAGS		ASYNC_BOOT_AUTOCONF
+
+#define SERIAL_PORT_DFNS
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/serial-regs.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/serial-regs.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/serial-regs.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/serial-regs.h	2004-11-05 14:13:04.191471450 +0000
@@ -0,0 +1,44 @@
+/* serial-regs.h: serial port registers
+ *
+ * Copyright (C) 2003 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _ASM_SERIAL_REGS_H
+#define _ASM_SERIAL_REGS_H
+
+#include <linux/serial_reg.h>
+#include <asm/irc-regs.h>
+
+#define SERIAL_ICLK	33333333	/* the target serial input clock */
+#define UART0_BASE	0xfeff9c00
+#define UART1_BASE	0xfeff9c40
+
+#define __get_UART0(R) ({ __reg(UART0_BASE + (R) * 8) >> 24; })
+#define __get_UART1(R) ({ __reg(UART1_BASE + (R) * 8) >> 24; })
+#define __set_UART0(R,V) do { __reg(UART0_BASE + (R) * 8) = (V) << 24; } while(0)
+#define __set_UART1(R,V) do { __reg(UART1_BASE + (R) * 8) = (V) << 24; } while(0)
+
+#define __get_UART0_LSR() ({ __get_UART0(UART_LSR); })
+#define __get_UART1_LSR() ({ __get_UART1(UART_LSR); })
+
+#define __set_UART0_IER(V) __set_UART0(UART_IER,(V))
+#define __set_UART1_IER(V) __set_UART1(UART_IER,(V))
+
+/* serial prescaler select register */
+#define __get_UCPSR()	({ *(volatile unsigned long *)(0xfeff9c90); })
+#define __set_UCPSR(V)	do { *(volatile unsigned long *)(0xfeff9c90) = (V); } while(0)
+#define UCPSR_SELECT0	0x07000000
+#define UCPSR_SELECT1	0x38000000
+
+/* serial prescaler base value register */
+#define __get_UCPVR()	({ *(volatile unsigned long *)(0xfeff9c98); mb(); })
+#define __set_UCPVR(V)	do { *(volatile unsigned long *)(0xfeff9c98) = (V) << 24; mb(); } while(0)
+
+
+#endif /* _ASM_SERIAL_REGS_H */
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/setup.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/setup.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/setup.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/setup.h	2004-11-05 14:13:04.195471112 +0000
@@ -0,0 +1,25 @@
+/* setup.h: setup stuff
+ *
+ * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _ASM_SETUP_H
+#define _ASM_SETUP_H
+
+#include <linux/init.h>
+
+#ifndef __ASSEMBLY__
+
+#ifdef CONFIG_MMU
+extern unsigned long __initdata num_mappedpages;
+#endif
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* _ASM_SETUP_H */
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/shmbuf.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/shmbuf.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/shmbuf.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/shmbuf.h	2004-11-05 14:13:04.199470774 +0000
@@ -0,0 +1,43 @@
+#ifndef _ASM_SHMBUF_H
+#define _ASM_SHMBUF_H
+
+/* 
+ * The shmid64_ds structure for FR-V architecture.
+ * Note extra padding because this structure is passed back and forth
+ * between kernel and user space.
+ *
+ * Pad space is left for:
+ * - 64-bit time_t to solve y2038 problem
+ * - 2 miscellaneous 32-bit values
+ */
+
+struct shmid64_ds {
+	struct ipc64_perm	shm_perm;	/* operation perms */
+	size_t			shm_segsz;	/* size of segment (bytes) */
+	__kernel_time_t		shm_atime;	/* last attach time */
+	unsigned long		__unused1;
+	__kernel_time_t		shm_dtime;	/* last detach time */
+	unsigned long		__unused2;
+	__kernel_time_t		shm_ctime;	/* last change time */
+	unsigned long		__unused3;
+	__kernel_pid_t		shm_cpid;	/* pid of creator */
+	__kernel_pid_t		shm_lpid;	/* pid of last operator */
+	unsigned long		shm_nattch;	/* no. of current attaches */
+	unsigned long		__unused4;
+	unsigned long		__unused5;
+};
+
+struct shminfo64 {
+	unsigned long	shmmax;
+	unsigned long	shmmin;
+	unsigned long	shmmni;
+	unsigned long	shmseg;
+	unsigned long	shmall;
+	unsigned long	__unused1;
+	unsigned long	__unused2;
+	unsigned long	__unused3;
+	unsigned long	__unused4;
+};
+
+#endif /* _ASM_SHMBUF_H */
+
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/shmparam.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/shmparam.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/shmparam.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/shmparam.h	2004-11-05 14:13:04.203470436 +0000
@@ -0,0 +1,7 @@
+#ifndef _ASM_SHMPARAM_H
+#define _ASM_SHMPARAM_H
+
+#define	SHMLBA PAGE_SIZE		 /* attach addr a multiple of this */
+
+#endif /* _ASM_SHMPARAM_H */
+
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/sigcontext.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/sigcontext.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/sigcontext.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/sigcontext.h	2004-11-05 14:13:04.207470098 +0000
@@ -0,0 +1,26 @@
+/* sigcontext.h: FRV signal context
+ *
+ * Copyright (C) 2003 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#ifndef _ASM_SIGCONTEXT_H
+#define _ASM_SIGCONTEXT_H
+
+#include <asm/registers.h>
+
+/*
+ * Signal context structure - contains all info to do with the state
+ * before the signal handler was invoked.  Note: only add new entries
+ * to the end of the structure.
+ */
+struct sigcontext {
+	struct user_context	sc_context;
+	unsigned long		sc_oldmask; 	/* old sigmask */
+} __attribute__((aligned(8)));
+
+#endif
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/siginfo.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/siginfo.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/siginfo.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/siginfo.h	2004-11-05 14:13:04.214469507 +0000
@@ -0,0 +1,12 @@
+#ifndef _ASM_SIGINFO_H
+#define _ASM_SIGINFO_H
+
+#include <linux/types.h>
+#include <asm-generic/siginfo.h>
+
+#define FPE_MDAOVF	(__SI_FAULT|9)	/* media overflow */
+#undef NSIGFPE
+#define NSIGFPE		9
+
+#endif
+
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/signal.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/signal.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/signal.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/signal.h	2004-11-05 14:13:04.218469169 +0000
@@ -0,0 +1,187 @@
+#ifndef _ASM_SIGNAL_H
+#define _ASM_SIGNAL_H
+
+#include <linux/types.h>
+
+/* Avoid too many header ordering problems.  */
+struct siginfo;
+
+#ifdef __KERNEL__
+/* Most things should be clean enough to redefine this at will, if care
+   is taken to make libc match.  */
+
+#define _NSIG		64
+#define _NSIG_BPW	32
+#define _NSIG_WORDS	(_NSIG / _NSIG_BPW)
+
+typedef unsigned long old_sigset_t;		/* at least 32 bits */
+
+typedef struct {
+	unsigned long sig[_NSIG_WORDS];
+} sigset_t;
+
+#else
+/* Here we must cater to libcs that poke about in kernel headers.  */
+
+#define NSIG		32
+typedef unsigned long sigset_t;
+
+#endif /* __KERNEL__ */
+
+#define SIGHUP		 1
+#define SIGINT		 2
+#define SIGQUIT		 3
+#define SIGILL		 4
+#define SIGTRAP		 5
+#define SIGABRT		 6
+#define SIGIOT		 6
+#define SIGBUS		 7
+#define SIGFPE		 8
+#define SIGKILL		 9
+#define SIGUSR1		10
+#define SIGSEGV		11
+#define SIGUSR2		12
+#define SIGPIPE		13
+#define SIGALRM		14
+#define SIGTERM		15
+#define SIGSTKFLT	16
+#define SIGCHLD		17
+#define SIGCONT		18
+#define SIGSTOP		19
+#define SIGTSTP		20
+#define SIGTTIN		21
+#define SIGTTOU		22
+#define SIGURG		23
+#define SIGXCPU		24
+#define SIGXFSZ		25
+#define SIGVTALRM	26
+#define SIGPROF		27
+#define SIGWINCH	28
+#define SIGIO		29
+#define SIGPOLL		SIGIO
+/*
+#define SIGLOST		29
+*/
+#define SIGPWR		30
+#define SIGSYS		31
+#define	SIGUNUSED	31
+
+/* These should not be considered constants from userland.  */
+#define SIGRTMIN	32
+#define SIGRTMAX	(_NSIG-1)
+
+/*
+ * SA_FLAGS values:
+ *
+ * SA_ONSTACK indicates that a registered stack_t will be used.
+ * SA_INTERRUPT is a no-op, but left due to historical reasons. Use the
+ * SA_RESTART flag to get restarting signals (which were the default long ago)
+ * SA_NOCLDSTOP flag to turn off SIGCHLD when children stop.
+ * SA_RESETHAND clears the handler when the signal is delivered.
+ * SA_NOCLDWAIT flag on SIGCHLD to inhibit zombies.
+ * SA_NODEFER prevents the current signal from being masked in the handler.
+ *
+ * SA_ONESHOT and SA_NOMASK are the historical Linux names for the Single
+ * Unix names RESETHAND and NODEFER respectively.
+ */
+#define SA_NOCLDSTOP	0x00000001
+#define SA_NOCLDWAIT	0x00000002 /* not supported yet */
+#define SA_SIGINFO	0x00000004
+#define SA_ONSTACK	0x08000000
+#define SA_RESTART	0x10000000
+#define SA_NODEFER	0x40000000
+#define SA_RESETHAND	0x80000000
+
+#define SA_NOMASK	SA_NODEFER
+#define SA_ONESHOT	SA_RESETHAND
+#define SA_INTERRUPT	0x20000000 /* dummy -- ignored */
+
+#define SA_RESTORER	0x04000000
+
+/* 
+ * sigaltstack controls
+ */
+#define SS_ONSTACK	1
+#define SS_DISABLE	2
+
+#define MINSIGSTKSZ	2048
+#define SIGSTKSZ	8192
+
+#ifdef __KERNEL__
+
+/*
+ * These values of sa_flags are used only by the kernel as part of the
+ * irq handling routines.
+ *
+ * SA_INTERRUPT is also used by the irq handling routines.
+ * SA_SHIRQ is for shared interrupt support on PCI and EISA.
+ */
+#define SA_PROBE		SA_ONESHOT
+#define SA_SAMPLE_RANDOM	SA_RESTART
+#define SA_SHIRQ		0x04000000
+#endif
+
+#define SIG_BLOCK          0	/* for blocking signals */
+#define SIG_UNBLOCK        1	/* for unblocking signals */
+#define SIG_SETMASK        2	/* for setting the signal mask */
+
+/* Type of a signal handler.  */
+typedef void (*__sighandler_t)(int);
+
+#define SIG_DFL	((__sighandler_t)0)	/* default signal handling */
+#define SIG_IGN	((__sighandler_t)1)	/* ignore signal */
+#define SIG_ERR	((__sighandler_t)-1)	/* error return from signal */
+
+#ifdef __KERNEL__
+struct old_sigaction {
+	__sighandler_t sa_handler;
+	old_sigset_t sa_mask;
+	unsigned long sa_flags;
+	void (*sa_restorer)(void);
+};
+
+struct sigaction {
+	__sighandler_t sa_handler;
+	unsigned long sa_flags;
+	void (*sa_restorer)(void);
+	sigset_t sa_mask;		/* mask last for extensibility */
+};
+
+struct k_sigaction {
+	struct sigaction sa;
+};
+#else
+/* Here we must cater to libcs that poke about in kernel headers.  */
+
+struct sigaction {
+	union {
+	  __sighandler_t _sa_handler;
+	  void (*_sa_sigaction)(int, struct siginfo *, void *);
+	} _u;
+	sigset_t sa_mask;
+	unsigned long sa_flags;
+	void (*sa_restorer)(void);
+};
+
+#define sa_handler	_u._sa_handler
+#define sa_sigaction	_u._sa_sigaction
+
+#endif /* __KERNEL__ */
+
+typedef struct sigaltstack {
+	void *ss_sp;
+	int ss_flags;
+	size_t ss_size;
+} stack_t;
+
+extern int do_signal(struct pt_regs *regs, sigset_t *oldset);
+#define ptrace_signal_deliver(regs, cookie) do { } while (0)
+
+#ifdef __KERNEL__
+
+#include <asm/sigcontext.h>
+#undef __HAVE_ARCH_SIG_BITOPS
+
+#endif /* __KERNEL__ */
+
+#endif /* _ASM_SIGNAL_H */
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/smp.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/smp.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/smp.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/smp.h	2004-11-05 14:13:04.222468831 +0000
@@ -0,0 +1,10 @@
+#ifndef __ASM_SMP_H
+#define __ASM_SMP_H
+
+#include <linux/config.h>
+
+#ifdef CONFIG_SMP
+#error SMP not supported
+#endif
+
+#endif
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/socket.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/socket.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/socket.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/socket.h	2004-11-05 14:13:04.226468494 +0000
@@ -0,0 +1,51 @@
+#ifndef _ASM_SOCKET_H
+#define _ASM_SOCKET_H
+
+#include <asm/sockios.h>
+
+/* For setsockopt(2) */
+#define SOL_SOCKET	1
+
+#define SO_DEBUG	1
+#define SO_REUSEADDR	2
+#define SO_TYPE		3
+#define SO_ERROR	4
+#define SO_DONTROUTE	5
+#define SO_BROADCAST	6
+#define SO_SNDBUF	7
+#define SO_RCVBUF	8
+#define SO_KEEPALIVE	9
+#define SO_OOBINLINE	10
+#define SO_NO_CHECK	11
+#define SO_PRIORITY	12
+#define SO_LINGER	13
+#define SO_BSDCOMPAT	14
+/* To add :#define SO_REUSEPORT 15 */
+#define SO_PASSCRED	16
+#define SO_PEERCRED	17
+#define SO_RCVLOWAT	18
+#define SO_SNDLOWAT	19
+#define SO_RCVTIMEO	20
+#define SO_SNDTIMEO	21
+
+/* Security levels - as per NRL IPv6 - don't actually do anything */
+#define SO_SECURITY_AUTHENTICATION		22
+#define SO_SECURITY_ENCRYPTION_TRANSPORT	23
+#define SO_SECURITY_ENCRYPTION_NETWORK		24
+
+#define SO_BINDTODEVICE	25
+
+/* Socket filtering */
+#define SO_ATTACH_FILTER        26
+#define SO_DETACH_FILTER        27
+
+#define SO_PEERNAME             28
+#define SO_TIMESTAMP		29
+#define SCM_TIMESTAMP		SO_TIMESTAMP
+
+#define SO_ACCEPTCONN		30
+
+#define SO_PEERSEC		31
+
+#endif /* _ASM_SOCKET_H */
+
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/sockios.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/sockios.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/sockios.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/sockios.h	2004-11-05 14:13:04.230468156 +0000
@@ -0,0 +1,13 @@
+#ifndef _ASM_SOCKIOS__
+#define _ASM_SOCKIOS__
+
+/* Socket-level I/O control calls. */
+#define FIOSETOWN 	0x8901
+#define SIOCSPGRP	0x8902
+#define FIOGETOWN	0x8903
+#define SIOCGPGRP	0x8904
+#define SIOCATMARK	0x8905
+#define SIOCGSTAMP	0x8906		/* Get stamp */
+
+#endif /* _ASM_SOCKIOS__ */
+
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/spinlock.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/spinlock.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/spinlock.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/spinlock.h	2004-11-05 14:13:04.000000000 +0000
@@ -0,0 +1,17 @@
+/* spinlock.h: spinlocks for FR-V
+ *
+ * Copyright (C) 2003 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _ASM_SPINLOCK_H
+#define _ASM_SPINLOCK_H
+
+#error no spinlocks for FR-V yet
+
+#endif /* _ASM_SPINLOCK_H */
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/spr-regs.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/spr-regs.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/spr-regs.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/spr-regs.h	2004-11-05 14:13:04.238467480 +0000
@@ -0,0 +1,401 @@
+/* spr-regs.h: special-purpose registers on the FRV
+ *
+ * Copyright (C) 2003, 2004 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _ASM_SPR_REGS_H
+#define _ASM_SPR_REGS_H
+
+/*
+ * PSR - Processor Status Register
+ */
+#define PSR_ET			0x00000001	/* enable interrupts/exceptions flag */
+#define PSR_PS			0x00000002	/* previous supervisor mode flag */
+#define PSR_S			0x00000004	/* supervisor mode flag */
+#define PSR_PIL			0x00000078	/* processor external interrupt level */
+#define PSR_PIL_0		0x00000000	/* - no interrupt in progress */
+#define PSR_PIL_13		0x00000068	/* - debugging only */
+#define PSR_PIL_14		0x00000070	/* - debugging in progress */
+#define PSR_PIL_15		0x00000078	/* - NMI in progress */
+#define PSR_EM			0x00000080	/* enable media operation */
+#define PSR_EF			0x00000100	/* enable FPU operation */
+#define PSR_BE			0x00001000	/* endianness mode */
+#define PSR_BE_LE		0x00000000	/* - little endian mode */
+#define PSR_BE_BE		0x00001000	/* - big endian mode */
+#define PSR_CM			0x00002000	/* conditional mode */
+#define PSR_NEM			0x00004000	/* non-excepting mode */
+#define PSR_ICE			0x00010000	/* in-circuit emulation mode */
+#define PSR_VERSION_SHIFT	24		/* CPU silicon ID */
+#define PSR_IMPLE_SHIFT		28		/* CPU core ID */
+
+#define PSR_VERSION(psr)	(((psr) >> PSR_VERSION_SHIFT) & 0xf)
+#define PSR_IMPLE(psr)		(((psr) >> PSR_IMPLE_SHIFT) & 0xf)
+
+#define PSR_IMPLE_FR401		0x2
+#define PSR_VERSION_FR401_MB93401	0x0
+#define PSR_VERSION_FR401_MB93401A	0x1
+#define PSR_VERSION_FR401_MB93403	0x2
+
+#define PSR_IMPLE_FR405		0x4
+#define PSR_VERSION_FR405_MB93405	0x0
+
+#define PSR_IMPLE_FR451		0x5
+#define PSR_VERSION_FR451_MB93451	0x0
+
+#define PSR_IMPLE_FR501		0x1
+#define PSR_VERSION_FR501_MB93501	0x1
+#define PSR_VERSION_FR501_MB93501A	0x2
+
+#define PSR_IMPLE_FR551		0x3
+#define PSR_VERSION_FR551_MB93555	0x1
+
+#define __get_PSR()	({ unsigned long x; asm volatile("movsg psr,%0" : "=r"(x)); x; })
+#define __set_PSR(V)	do { asm volatile("movgs %0,psr" : : "r"(V)); } while(0)
+
+/*
+ * TBR - Trap Base Register
+ */
+#define TBR_TT			0x00000ff0
+#define TBR_TT_INSTR_MMU_MISS	(0x01 << 4)
+#define TBR_TT_INSTR_ACC_ERROR	(0x02 << 4)
+#define TBR_TT_INSTR_ACC_EXCEP	(0x03 << 4)
+#define TBR_TT_PRIV_INSTR	(0x06 << 4)
+#define TBR_TT_ILLEGAL_INSTR	(0x07 << 4)
+#define TBR_TT_FP_EXCEPTION	(0x0d << 4)
+#define TBR_TT_MP_EXCEPTION	(0x0e << 4)
+#define TBR_TT_DATA_ACC_ERROR	(0x11 << 4)
+#define TBR_TT_DATA_MMU_MISS	(0x12 << 4)
+#define TBR_TT_DATA_ACC_EXCEP	(0x13 << 4)
+#define TBR_TT_DATA_STR_ERROR	(0x14 << 4)
+#define TBR_TT_DIVISION_EXCEP	(0x17 << 4)
+#define TBR_TT_COMMIT_EXCEP	(0x19 << 4)
+#define TBR_TT_INSTR_TLB_MISS	(0x1a << 4)
+#define TBR_TT_DATA_TLB_MISS	(0x1b << 4)
+#define TBR_TT_DATA_DAT_EXCEP	(0x1d << 4)
+#define TBR_TT_DECREMENT_TIMER	(0x1f << 4)
+#define TBR_TT_COMPOUND_EXCEP	(0x20 << 4)
+#define TBR_TT_INTERRUPT_1	(0x21 << 4)
+#define TBR_TT_INTERRUPT_2	(0x22 << 4)
+#define TBR_TT_INTERRUPT_3	(0x23 << 4)
+#define TBR_TT_INTERRUPT_4	(0x24 << 4)
+#define TBR_TT_INTERRUPT_5	(0x25 << 4)
+#define TBR_TT_INTERRUPT_6	(0x26 << 4)
+#define TBR_TT_INTERRUPT_7	(0x27 << 4)
+#define TBR_TT_INTERRUPT_8	(0x28 << 4)
+#define TBR_TT_INTERRUPT_9	(0x29 << 4)
+#define TBR_TT_INTERRUPT_10	(0x2a << 4)
+#define TBR_TT_INTERRUPT_11	(0x2b << 4)
+#define TBR_TT_INTERRUPT_12	(0x2c << 4)
+#define TBR_TT_INTERRUPT_13	(0x2d << 4)
+#define TBR_TT_INTERRUPT_14	(0x2e << 4)
+#define TBR_TT_INTERRUPT_15	(0x2f << 4)
+#define TBR_TT_TRAP0		(0x80 << 4)
+#define TBR_TT_TRAP1		(0x81 << 4)
+#define TBR_TT_TRAP2		(0x82 << 4)
+#define TBR_TT_TRAP126		(0xfe << 4)
+#define TBR_TT_BREAK		(0xff << 4)
+
+#define __get_TBR()	({ unsigned long x; asm volatile("movsg tbr,%0" : "=r"(x)); x; })
+
+/*
+ * HSR0 - Hardware Status Register 0
+ */
+#define HSR0_PDM		0x00000007	/* power down mode */
+#define HSR0_PDM_NORMAL		0x00000000	/* - normal mode */
+#define HSR0_PDM_CORE_SLEEP	0x00000001	/* - CPU core sleep mode */
+#define HSR0_PDM_BUS_SLEEP	0x00000003	/* - bus sleep mode */
+#define HSR0_PDM_PLL_RUN	0x00000005	/* - PLL run */
+#define HSR0_PDM_PLL_STOP	0x00000007	/* - PLL stop */
+#define HSR0_GRLE		0x00000040	/* GR lower register set enable */
+#define HSR0_GRHE		0x00000080	/* GR higher register set enable */
+#define HSR0_FRLE		0x00000100	/* FR lower register set enable */
+#define HSR0_FRHE		0x00000200	/* FR higher register set enable */
+#define HSR0_GRN		0x00000400	/* GR quantity */
+#define HSR0_GRN_64		0x00000000	/* - 64 GR registers */
+#define HSR0_GRN_32		0x00000400	/* - 32 GR registers */
+#define HSR0_FRN		0x00000800	/* FR quantity */
+#define HSR0_FRN_64		0x00000000	/* - 64 FR registers */
+#define HSR0_FRN_32		0x00000800	/* - 32 FR registers */
+#define HSR0_SA			0x00001000	/* start address (RAMBOOT#) */
+#define HSR0_ETMI		0x00008000	/* enable TIMERI (64-bit up timer) */
+#define HSR0_ETMD		0x00004000	/* enable TIMERD (32-bit down timer) */
+#define HSR0_PEDAT		0x00010000	/* previous DAT mode */
+#define HSR0_XEDAT		0x00020000	/* exception DAT mode */
+#define HSR0_EDAT		0x00080000	/* enable DAT mode */
+#define HSR0_RME		0x00400000	/* enable RAM mode */
+#define HSR0_EMEM		0x00800000	/* enable MMU_Miss mask */
+#define HSR0_EXMMU		0x01000000	/* enable extended MMU mode */
+#define HSR0_EDMMU		0x02000000	/* enable data MMU */
+#define HSR0_EIMMU		0x04000000	/* enable instruction MMU */
+#define HSR0_CBM		0x08000000	/* copy back mode */
+#define HSR0_CBM_WRITE_THRU	0x00000000	/* - write through */
+#define HSR0_CBM_COPY_BACK	0x08000000	/* - copy back */
+#define HSR0_NWA		0x10000000	/* no write allocate */
+#define HSR0_DCE		0x40000000	/* data cache enable */
+#define HSR0_ICE		0x80000000	/* instruction cache enable */
+
+#define __get_HSR(R)	({ unsigned long x; asm volatile("movsg hsr"#R",%0" : "=r"(x)); x; })
+#define __set_HSR(R,V)	do { asm volatile("movgs %0,hsr"#R : : "r"(V)); } while(0)
+
+/*
+ * CCR - Condition Codes Register
+ */
+#define CCR_FCC0		0x0000000f	/* FP/Media condition 0 (fcc0 reg) */
+#define CCR_FCC1		0x000000f0	/* FP/Media condition 1 (fcc1 reg) */
+#define CCR_FCC2		0x00000f00	/* FP/Media condition 2 (fcc2 reg) */
+#define CCR_FCC3		0x0000f000	/* FP/Media condition 3 (fcc3 reg) */
+#define CCR_ICC0		0x000f0000	/* Integer condition 0 (icc0 reg) */
+#define CCR_ICC0_C		0x00010000	/* - Carry flag */
+#define CCR_ICC0_V		0x00020000	/* - Overflow flag */
+#define CCR_ICC0_Z		0x00040000	/* - Zero flag */
+#define CCR_ICC0_N		0x00080000	/* - Negative flag */
+#define CCR_ICC1		0x00f00000	/* Integer condition 1 (icc1 reg) */
+#define CCR_ICC2		0x0f000000	/* Integer condition 2 (icc2 reg) */
+#define CCR_ICC3		0xf0000000	/* Integer condition 3 (icc3 reg) */
+
+/*
+ * CCCR - Condition Codes for Conditional Instructions Register
+ */
+#define CCCR_CC0		0x00000003	/* condition 0 (cc0 reg) */
+#define CCCR_CC0_FALSE		0x00000002	/* - condition is false */
+#define CCCR_CC0_TRUE		0x00000003	/* - condition is true */
+#define CCCR_CC1		0x0000000c	/* condition 1 (cc1 reg) */
+#define CCCR_CC2		0x00000030	/* condition 2 (cc2 reg) */
+#define CCCR_CC3		0x000000c0	/* condition 3 (cc3 reg) */
+#define CCCR_CC4		0x00000300	/* condition 4 (cc4 reg) */
+#define CCCR_CC5		0x00000c00	/* condition 5 (cc5 reg) */
+#define CCCR_CC6		0x00003000	/* condition 6 (cc6 reg) */
+#define CCCR_CC7		0x0000c000	/* condition 7 (cc7 reg) */
+
+/*
+ * ISR - Integer Status Register
+ */
+#define ISR_EMAM		0x00000001	/* memory misaligned access handling */
+#define ISR_EMAM_EXCEPTION	0x00000000	/* - generate exception */
+#define ISR_EMAM_FUDGE		0x00000001	/* - mask out invalid address bits */
+#define ISR_AEXC		0x00000004	/* accrued [overflow] exception */
+#define ISR_DTT			0x00000018	/* division type trap */
+#define ISR_DTT_IGNORE		0x00000000	/* - ignore division error */
+#define ISR_DTT_DIVBYZERO	0x00000008	/* - generate exception */
+#define ISR_DTT_OVERFLOW	0x00000010	/* - record overflow */
+#define ISR_EDE			0x00000020	/* enable division exception */
+#define ISR_PLI			0x20000000	/* pre-load instruction information */
+#define ISR_QI			0x80000000	/* quad data implementation information */
+
+/*
+ * EPCR0 - Exception PC Register
+ */
+#define EPCR0_V			0x00000001	/* register content validity indicator */
+#define EPCR0_PC		0xfffffffc	/* faulting instruction address */
+
+/*
+ * ESR0/14/15 - Exception Status Register
+ */
+#define ESRx_VALID		0x00000001	/* register content validity indicator */
+#define ESRx_EC			0x0000003e	/* exception type */
+#define ESRx_EC_DATA_STORE	0x00000000	/* - data_store_error */
+#define ESRx_EC_INSN_ACCESS	0x00000006	/* - instruction_access_error */
+#define ESRx_EC_PRIV_INSN	0x00000008	/* - privileged_instruction */
+#define ESRx_EC_ILL_INSN	0x0000000a	/* - illegal_instruction */
+#define ESRx_EC_MP_EXCEP	0x0000001c	/* - mp_exception */
+#define ESRx_EC_DATA_ACCESS	0x00000024	/* - data_access_error */
+#define ESRx_EC_DIVISION	0x00000026	/* - division_exception */
+#define ESRx_EC_ITLB_MISS	0x00000034	/* - instruction_access_TLB_miss */
+#define ESRx_EC_DTLB_MISS	0x00000036	/* - data_access_TLB_miss */
+#define ESRx_EC_DATA_ACCESS_DAT	0x0000003a	/* - data_access_DAT_exception */
+
+#define ESR0_IAEC		0x00000100	/* info for instruction-access-exception */
+#define ESR0_IAEC_RESV		0x00000000	/* - reserved */
+#define ESR0_IAEC_PROT_VIOL	0x00000100	/* - protection violation */
+
+#define ESR0_ATXC		0x00f00000	/* address translation exception code */
+#define ESR0_ATXC_MMU_MISS	0x00000000	/* - MMU miss exception and more (?) */
+#define ESR0_ATXC_MULTI_DAT	0x00800000	/* - multiple DAT entry hit */
+#define ESR0_ATXC_MULTI_SAT	0x00900000	/* - multiple SAT entry hit */
+#define ESR0_ATXC_AMRTLB_MISS	0x00a00000	/* - MMU/TLB miss exception */
+#define ESR0_ATXC_PRIV_EXCEP	0x00c00000	/* - privilege protection fault */
+#define ESR0_ATXC_WP_EXCEP	0x00d00000	/* - write protection fault */
+
+#define ESR0_EAV		0x00000800	/* true if EAR0 register valid */
+#define ESR15_EAV		0x00000800	/* true if EAR15 register valid */
+
+/*
+ * ESFR1 - Exception Status Valid Flag Register
+ */
+#define ESFR1_ESR0		0x00000001	/* true if ESR0 is valid */
+#define ESFR1_ESR14		0x00004000	/* true if ESR14 is valid */
+#define ESFR1_ESR15		0x00008000	/* true if ESR15 is valid */
+
+/*
+ * MSR - Media Status Register
+ */
+#define MSR0_AOVF		0x00000001	/* overflow exception accrued */
+#define MSRx_OVF		0x00000002	/* overflow exception detected */
+#define MSRx_SIE		0x0000003c	/* last SIMD instruction exception detected */
+#define MSRx_SIE_NONE		0x00000000	/* - none detected */
+#define MSRx_SIE_FRkHI_ACCk	0x00000020	/* - exception at FRkHI or ACCk */
+#define MSRx_SIE_FRkLO_ACCk1	0x00000010	/* - exception at FRkLO or ACCk+1 */
+#define MSRx_SIE_FRk1HI_ACCk2	0x00000008	/* - exception at FRk+1HI or ACCk+2 */
+#define MSRx_SIE_FRk1LO_ACCk3	0x00000004	/* - exception at FRk+1LO or ACCk+3 */
+#define MSR0_MTT		0x00007000	/* type of last media trap detected */
+#define MSR0_MTT_NONE		0x00000000	/* - none detected */
+#define MSR0_MTT_OVERFLOW	0x00001000	/* - overflow detected */
+#define MSR0_HI			0x00c00000	/* hardware implementation */
+#define MSR0_HI_ROUNDING	0x00000000	/* - rounding mode */
+#define MSR0_HI_NONROUNDING	0x00c00000	/* - non-rounding mode */
+#define MSR0_EMCI		0x01000000	/* enable media custom instructions */
+#define MSR0_SRDAV		0x10000000	/* select rounding mode of MAVEH */
+#define MSR0_SRDAV_RDAV		0x00000000	/* - controlled by MSR.RDAV */
+#define MSR0_SRDAV_RD		0x10000000	/* - controlled by MSR.RD */
+#define MSR0_RDAV		0x20000000	/* rounding mode of MAVEH */
+#define MSR0_RDAV_NEAREST_MI	0x00000000	/* - round to nearest minus */
+#define MSR0_RDAV_NEAREST_PL	0x20000000	/* - round to nearest plus */
+#define MSR0_RD			0xc0000000	/* rounding mode */
+#define MSR0_RD_NEAREST		0x00000000	/* - nearest */
+#define MSR0_RD_ZERO		0x40000000	/* - zero */
+#define MSR0_RD_POS_INF		0x80000000	/* - postive infinity */
+#define MSR0_RD_NEG_INF		0xc0000000	/* - negative infinity */
+
+/*
+ * IAMPR0-7 - Instruction Address Mapping Register
+ * DAMPR0-7 - Data Address Mapping Register
+ */
+#define xAMPRx_V		0x00000001	/* register content validity indicator */
+#define DAMPRx_WP		0x00000002	/* write protect */
+#define DAMPRx_WP_RW		0x00000000	/* - read/write */
+#define DAMPRx_WP_RO		0x00000002	/* - read-only */
+#define xAMPRx_C		0x00000004	/* cached/uncached */
+#define xAMPRx_C_CACHED		0x00000000	/* - cached */
+#define xAMPRx_C_UNCACHED	0x00000004	/* - uncached */
+#define xAMPRx_S		0x00000008	/* supervisor only */
+#define xAMPRx_S_USER		0x00000000	/* - userspace can access */
+#define xAMPRx_S_KERNEL		0x00000008	/* - kernel only */
+#define xAMPRx_SS		0x000000f0	/* segment size */
+#define xAMPRx_SS_16Kb		0x00000000	/* - 16 kilobytes */
+#define xAMPRx_SS_64Kb		0x00000010	/* - 64 kilobytes */
+#define xAMPRx_SS_256Kb		0x00000020	/* - 256 kilobytes */
+#define xAMPRx_SS_1Mb		0x00000030	/* - 1 megabyte */
+#define xAMPRx_SS_2Mb		0x00000040	/* - 2 megabytes */
+#define xAMPRx_SS_4Mb		0x00000050	/* - 4 megabytes */
+#define xAMPRx_SS_8Mb		0x00000060	/* - 8 megabytes */
+#define xAMPRx_SS_16Mb		0x00000070	/* - 16 megabytes */
+#define xAMPRx_SS_32Mb		0x00000080	/* - 32 megabytes */
+#define xAMPRx_SS_64Mb		0x00000090	/* - 64 megabytes */
+#define xAMPRx_SS_128Mb		0x000000a0	/* - 128 megabytes */
+#define xAMPRx_SS_256Mb		0x000000b0	/* - 256 megabytes */
+#define xAMPRx_SS_512Mb		0x000000c0	/* - 512 megabytes */
+#define xAMPRx_RESERVED8	0x00000100	/* reserved bit */
+#define xAMPRx_NG		0x00000200	/* non-global */
+#define xAMPRx_L		0x00000400	/* locked */
+#define xAMPRx_M		0x00000800	/* modified */
+#define xAMPRx_D		0x00001000	/* DAT entry */
+#define xAMPRx_RESERVED13	0x00002000	/* reserved bit */
+#define xAMPRx_PPFN		0xfff00000	/* physical page frame number */
+
+#define xAMPRx_V_BIT		0
+#define DAMPRx_WP_BIT		1
+#define xAMPRx_C_BIT		2
+#define xAMPRx_S_BIT		3
+#define xAMPRx_RESERVED8_BIT	8
+#define xAMPRx_NG_BIT		9
+#define xAMPRx_L_BIT		10
+#define xAMPRx_M_BIT		11
+#define xAMPRx_D_BIT		12
+#define xAMPRx_RESERVED13_BIT	13
+
+#define __get_IAMPR(R) ({ unsigned long x; asm volatile("movsg iampr"#R",%0" : "=r"(x)); x; })
+#define __get_DAMPR(R) ({ unsigned long x; asm volatile("movsg dampr"#R",%0" : "=r"(x)); x; })
+
+#define __get_IAMLR(R) ({ unsigned long x; asm volatile("movsg iamlr"#R",%0" : "=r"(x)); x; })
+#define __get_DAMLR(R) ({ unsigned long x; asm volatile("movsg damlr"#R",%0" : "=r"(x)); x; })
+
+#define __set_IAMPR(R,V) 	do { asm volatile("movgs %0,iampr"#R : : "r"(V)); } while(0)
+#define __set_DAMPR(R,V)  	do { asm volatile("movgs %0,dampr"#R : : "r"(V)); } while(0)
+
+#define __set_IAMLR(R,V) 	do { asm volatile("movgs %0,iamlr"#R : : "r"(V)); } while(0)
+#define __set_DAMLR(R,V)  	do { asm volatile("movgs %0,damlr"#R : : "r"(V)); } while(0)
+
+#define save_dampr(R, _dampr)					\
+do {								\
+	asm volatile("movsg dampr"R",%0" : "=r"(_dampr));	\
+} while(0)
+
+#define restore_dampr(R, _dampr)			\
+do {							\
+	asm volatile("movgs %0,dampr"R :: "r"(_dampr));	\
+} while(0)
+
+/*
+ * AMCR - Address Mapping Control Register
+ */
+#define AMCR_IAMRN		0x000000ff	/* quantity of IAMPR registers */
+#define AMCR_DAMRN		0x0000ff00	/* quantity of DAMPR registers */
+
+/*
+ * TTBR - Address Translation Table Base Register
+ */
+#define __get_TTBR()		({ unsigned long x; asm volatile("movsg ttbr,%0" : "=r"(x)); x; })
+
+/*
+ * TPXR - TLB Probe Extend Register
+ */
+#define TPXR_E			0x00000001
+#define TPXR_LMAX_SHIFT		20
+#define TPXR_LMAX_SMASK		0xf
+#define TPXR_WMAX_SHIFT		24
+#define TPXR_WMAX_SMASK		0xf
+#define TPXR_WAY_SHIFT		28
+#define TPXR_WAY_SMASK		0xf
+
+/*
+ * DCR - Debug Control Register
+ */
+#define DCR_IBCE3		0x00000001	/* break on conditional insn pointed to by IBAR3 */
+#define DCR_IBE3		0x00000002	/* break on insn pointed to by IBAR3 */
+#define DCR_IBCE1		0x00000004	/* break on conditional insn pointed to by IBAR2 */
+#define DCR_IBE1		0x00000008	/* break on insn pointed to by IBAR2 */
+#define DCR_IBCE2		0x00000010	/* break on conditional insn pointed to by IBAR1 */
+#define DCR_IBE2		0x00000020	/* break on insn pointed to by IBAR1 */
+#define DCR_IBCE0		0x00000040	/* break on conditional insn pointed to by IBAR0 */
+#define DCR_IBE0		0x00000080	/* break on insn pointed to by IBAR0 */
+
+#define DCR_DDBE1		0x00004000	/* use DBDR1x when checking DBAR1 */
+#define DCR_DWBE1		0x00008000	/* break on store to address in DBAR1/DBMR1x */
+#define DCR_DRBE1		0x00010000	/* break on load from address in DBAR1/DBMR1x */
+#define DCR_DDBE0		0x00020000	/* use DBDR0x when checking DBAR0 */
+#define DCR_DWBE0		0x00040000	/* break on store to address in DBAR0/DBMR0x */
+#define DCR_DRBE0		0x00080000	/* break on load from address in DBAR0/DBMR0x */
+
+#define DCR_EIM			0x0c000000	/* external interrupt disable */
+#define DCR_IBM			0x10000000	/* instruction break disable */
+#define DCR_SE			0x20000000	/* single step enable */
+#define DCR_EBE			0x40000000	/* exception break enable */
+
+/*
+ * BRR - Break Interrupt Request Register
+ */
+#define BRR_ST			0x00000001	/* single-step detected */
+#define BRR_SB			0x00000002	/* break instruction detected */
+#define BRR_BB			0x00000004	/* branch with hint detected */
+#define BRR_CBB			0x00000008	/* branch to LR detected */
+#define BRR_IBx			0x000000f0	/* hardware breakpoint detected */
+#define BRR_DBx			0x00000f00	/* hardware watchpoint detected */
+#define BRR_DBNEx		0x0000f000	/* ? */
+#define BRR_EBTT		0x00ff0000	/* trap type of exception break */
+#define BRR_TB			0x10000000	/* external break request detected */
+#define BRR_CB			0x20000000	/* ICE break command detected */
+#define BRR_EB			0x40000000	/* exception break detected */
+
+/*
+ * BPSR - Break PSR Save Register
+ */
+#define BPSR_BET		0x00000001	/* former PSR.ET */
+#define BPSR_BS			0x00001000	/* former PSR.S */
+
+#endif /* _ASM_SPR_REGS_H */
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/statfs.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/statfs.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/statfs.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/statfs.h	2004-11-05 14:13:04.242467142 +0000
@@ -0,0 +1,7 @@
+#ifndef _ASM_STATFS_H
+#define _ASM_STATFS_H
+
+#include <asm-generic/statfs.h>
+
+#endif /* _ASM_STATFS_H */
+
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/stat.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/stat.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/stat.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/stat.h	2004-11-05 14:13:04.246466805 +0000
@@ -0,0 +1,100 @@
+#ifndef _ASM_STAT_H
+#define _ASM_STAT_H
+
+struct __old_kernel_stat {
+	unsigned short st_dev;
+	unsigned short st_ino;
+	unsigned short st_mode;
+	unsigned short st_nlink;
+	unsigned short st_uid;
+	unsigned short st_gid;
+	unsigned short st_rdev;
+	unsigned long  st_size;
+	unsigned long  st_atime;
+	unsigned long  st_mtime;
+	unsigned long  st_ctime;
+};
+
+/* This matches struct stat in uClibc/glibc.  */
+struct stat {
+	unsigned char __pad1[6];
+	unsigned short st_dev;
+
+	unsigned long __pad2;
+	unsigned long st_ino;
+
+	unsigned short __pad3;
+	unsigned short st_mode;
+	unsigned short __pad4;
+	unsigned short st_nlink;
+
+	unsigned short __pad5;
+	unsigned short st_uid;
+	unsigned short __pad6;
+	unsigned short st_gid;
+
+	unsigned char __pad7[6];
+	unsigned short st_rdev;
+
+	unsigned long __pad8;
+	unsigned long st_size;
+
+	unsigned long __pad9;		/* align 64-bit st_blocks to 2-word */
+	unsigned long st_blksize;
+
+	unsigned long __pad10;	/* future possible st_blocks high bits */
+	unsigned long st_blocks;	/* Number 512-byte blocks allocated. */
+
+	unsigned long __unused1;
+	unsigned long st_atime;
+
+	unsigned long __unused2;
+	unsigned long st_mtime;
+
+	unsigned long __unused3;
+	unsigned long st_ctime;
+
+	unsigned long long __unused4;
+};
+
+/* This matches struct stat64 in uClibc/glibc.  The layout is exactly
+   the same as that of struct stat above, with 64-bit types taking up
+   space that was formerly used by padding.  stat syscalls are still
+   different from stat64, though, in that the former tests for
+   overflow.  */
+struct stat64 {
+	unsigned char __pad1[6];
+	unsigned short st_dev;
+
+	unsigned long long st_ino;
+
+	unsigned int st_mode;
+	unsigned int st_nlink;
+
+	unsigned long st_uid;
+	unsigned long st_gid;
+
+	unsigned char __pad2[6];
+	unsigned short st_rdev;
+
+	long long st_size;
+
+	unsigned long __pad3;		/* align 64-bit st_blocks to 2-word */
+	unsigned long st_blksize;
+
+	unsigned long __pad4;		/* future possible st_blocks high bits */
+	unsigned long st_blocks;	/* Number 512-byte blocks allocated. */
+
+	unsigned long st_atime_nsec;
+	unsigned long st_atime;
+
+	unsigned int st_mtime_nsec;
+	unsigned long st_mtime;
+
+	unsigned long st_ctime_nsec;
+	unsigned long st_ctime;
+
+	unsigned long long __unused4;
+};
+
+#endif /* _ASM_STAT_H */
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/string.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/string.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/string.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/string.h	2004-11-05 14:13:04.250466467 +0000
@@ -0,0 +1,51 @@
+/* string.h: FRV string handling
+ *
+ * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _ASM_STRING_H_
+#define _ASM_STRING_H_
+
+#ifdef __KERNEL__ /* only set these up for kernel code */
+
+#define __HAVE_ARCH_MEMSET 1
+#define __HAVE_ARCH_MEMCPY 1
+
+extern void *memset(void *, int, __kernel_size_t);
+extern void *memcpy(void *, const void *, __kernel_size_t);
+
+#else /* KERNEL */
+
+/*
+ *	let user libraries deal with these,
+ *	IMHO the kernel has no place defining these functions for user apps
+ */
+
+#define __HAVE_ARCH_STRCPY 1
+#define __HAVE_ARCH_STRNCPY 1
+#define __HAVE_ARCH_STRCAT 1
+#define __HAVE_ARCH_STRNCAT 1
+#define __HAVE_ARCH_STRCMP 1
+#define __HAVE_ARCH_STRNCMP 1
+#define __HAVE_ARCH_STRNICMP 1
+#define __HAVE_ARCH_STRCHR 1
+#define __HAVE_ARCH_STRRCHR 1
+#define __HAVE_ARCH_STRSTR 1
+#define __HAVE_ARCH_STRLEN 1
+#define __HAVE_ARCH_STRNLEN 1
+#define __HAVE_ARCH_MEMSET 1
+#define __HAVE_ARCH_MEMCPY 1
+#define __HAVE_ARCH_MEMMOVE 1
+#define __HAVE_ARCH_MEMSCAN 1
+#define __HAVE_ARCH_MEMCMP 1
+#define __HAVE_ARCH_MEMCHR 1
+#define __HAVE_ARCH_STRTOK 1
+
+#endif /* KERNEL */
+#endif /* _ASM_STRING_H_ */
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/suspend.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/suspend.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/suspend.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/suspend.h	2004-11-05 14:13:04.254466129 +0000
@@ -0,0 +1,20 @@
+/* suspend.h: suspension stuff
+ *
+ * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _ASM_SUSPEND_H
+#define _ASM_SUSPEND_H
+
+static inline int arch_prepare_suspend(void)
+{
+	return 0;
+}
+
+#endif /* _ASM_SUSPEND_H */
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/system.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/system.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/system.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/system.h	2004-11-05 14:13:04.259465707 +0000
@@ -0,0 +1,123 @@
+/* system.h: FR-V CPU control definitions
+ *
+ * Copyright (C) 2003 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _ASM_SYSTEM_H
+#define _ASM_SYSTEM_H
+
+#include <linux/config.h> /* get configuration macros */
+#include <linux/linkage.h>
+#include <asm/atomic.h>
+
+struct thread_struct;
+
+#define prepare_to_switch()    do { } while(0)
+
+/*
+ * switch_to(prev, next) should switch from task `prev' to `next'
+ * `prev' will never be the same as `next'.
+ * The `mb' is to tell GCC not to cache `current' across this call.
+ */
+extern asmlinkage
+void __switch_to(struct thread_struct *prev, struct thread_struct *next);
+
+#define switch_to(prev, next, last)						\
+do {										\
+	prev->thread.sched_lr = (unsigned long) __builtin_return_address(0);	\
+	__switch_to(&prev->thread, &next->thread);				\
+	mb();									\
+} while(0)
+
+/*
+ * interrupt flag manipulation
+ */
+#define local_irq_disable()				\
+do {							\
+	unsigned long psr;				\
+	asm volatile("	movsg	psr,%0		\n"	\
+		     "	andi	%0,%2,%0	\n"	\
+		     "	ori	%0,%1,%0	\n"	\
+		     "	movgs	%0,psr		\n"	\
+		     : "=r"(psr)			\
+		     : "i" (PSR_PIL_14), "i" (~PSR_PIL)	\
+		     : "memory");			\
+} while(0)
+
+#define local_irq_enable()				\
+do {							\
+	unsigned long psr;				\
+	asm volatile("	movsg	psr,%0		\n"	\
+		     "	andi	%0,%1,%0	\n"	\
+		     "	movgs	%0,psr		\n"	\
+		     : "=r"(psr)			\
+		     : "i" (~PSR_PIL)			\
+		     : "memory");			\
+} while(0)
+
+#define local_save_flags(flags)			\
+do {						\
+	typecheck(unsigned long, flags);	\
+	asm("movsg psr,%0"			\
+	    : "=r"(flags)			\
+	    :					\
+	    : "memory");			\
+} while(0)
+
+#define	local_irq_save(flags)				\
+do {							\
+	unsigned long npsr;				\
+	typecheck(unsigned long, flags);		\
+	asm volatile("	movsg	psr,%0		\n"	\
+		     "	andi	%0,%3,%1	\n"	\
+		     "	ori	%1,%2,%1	\n"	\
+		     "	movgs	%1,psr		\n"	\
+		     : "=r"(flags), "=r"(npsr)		\
+		     : "i" (PSR_PIL_14), "i" (~PSR_PIL)	\
+		     : "memory");			\
+} while(0)
+
+#define	local_irq_restore(flags)			\
+do {							\
+	typecheck(unsigned long, flags);		\
+	asm volatile("	movgs	%0,psr		\n"	\
+		     :					\
+		     : "r" (flags)			\
+		     : "memory");			\
+} while(0)
+
+#define irqs_disabled() \
+	((__get_PSR() & PSR_PIL) >= PSR_PIL_14)
+
+/*
+ * Force strict CPU ordering.
+ */
+#define nop()			asm volatile ("nop"::)
+#define mb()			asm volatile ("membar" : : :"memory")
+#define rmb()			asm volatile ("membar" : : :"memory")
+#define wmb()			asm volatile ("membar" : : :"memory")
+#define set_mb(var, value)	do { var = value; mb(); } while (0)
+#define set_wmb(var, value)	do { var = value; wmb(); } while (0)
+
+#define smp_mb()		mb()
+#define smp_rmb()		rmb()
+#define smp_wmb()		wmb()
+
+#define read_barrier_depends()		do {} while(0)
+#define smp_read_barrier_depends()	read_barrier_depends()
+
+#define HARD_RESET_NOW()			\
+do {						\
+	cli();					\
+} while(1)
+
+extern void die_if_kernel(const char *, ...) __attribute__((format(printf, 1, 2)));
+extern void free_initmem(void);
+
+#endif /* _ASM_SYSTEM_H */
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/termbits.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/termbits.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/termbits.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/termbits.h	2004-11-05 16:11:21.023484003 +0000
@@ -0,0 +1,177 @@
+#ifndef _ASM_TERMBITS_H__
+#define _ASM_TERMBITS_H__
+
+#include <linux/posix_types.h>
+
+typedef unsigned char	cc_t;
+typedef unsigned int	speed_t;
+typedef unsigned int	tcflag_t;
+
+#define NCCS 19
+struct termios {
+	tcflag_t c_iflag;		/* input mode flags */
+	tcflag_t c_oflag;		/* output mode flags */
+	tcflag_t c_cflag;		/* control mode flags */
+	tcflag_t c_lflag;		/* local mode flags */
+	cc_t c_line;			/* line discipline */
+	cc_t c_cc[NCCS];		/* control characters */
+};
+
+/* c_cc characters */
+#define VINTR 0
+#define VQUIT 1
+#define VERASE 2
+#define VKILL 3
+#define VEOF 4
+#define VTIME 5
+#define VMIN 6
+#define VSWTC 7
+#define VSTART 8
+#define VSTOP 9
+#define VSUSP 10
+#define VEOL 11
+#define VREPRINT 12
+#define VDISCARD 13
+#define VWERASE 14
+#define VLNEXT 15
+#define VEOL2 16
+
+
+/* c_iflag bits */
+#define IGNBRK	0000001
+#define BRKINT	0000002
+#define IGNPAR	0000004
+#define PARMRK	0000010
+#define INPCK	0000020
+#define ISTRIP	0000040
+#define INLCR	0000100
+#define IGNCR	0000200
+#define ICRNL	0000400
+#define IUCLC	0001000
+#define IXON	0002000
+#define IXANY	0004000
+#define IXOFF	0010000
+#define IMAXBEL	0020000
+#define IUTF8	0040000
+
+/* c_oflag bits */
+#define OPOST	0000001
+#define OLCUC	0000002
+#define ONLCR	0000004
+#define OCRNL	0000010
+#define ONOCR	0000020
+#define ONLRET	0000040
+#define OFILL	0000100
+#define OFDEL	0000200
+#define NLDLY	0000400
+#define   NL0	0000000
+#define   NL1	0000400
+#define CRDLY	0003000
+#define   CR0	0000000
+#define   CR1	0001000
+#define   CR2	0002000
+#define   CR3	0003000
+#define TABDLY	0014000
+#define   TAB0	0000000
+#define   TAB1	0004000
+#define   TAB2	0010000
+#define   TAB3	0014000
+#define   XTABS	0014000
+#define BSDLY	0020000
+#define   BS0	0000000
+#define   BS1	0020000
+#define VTDLY	0040000
+#define   VT0	0000000
+#define   VT1	0040000
+#define FFDLY	0100000
+#define   FF0	0000000
+#define   FF1	0100000
+
+/* c_cflag bit meaning */
+#define CBAUD	0010017
+#define  B0	0000000		/* hang up */
+#define  B50	0000001
+#define  B75	0000002
+#define  B110	0000003
+#define  B134	0000004
+#define  B150	0000005
+#define  B200	0000006
+#define  B300	0000007
+#define  B600	0000010
+#define  B1200	0000011
+#define  B1800	0000012
+#define  B2400	0000013
+#define  B4800	0000014
+#define  B9600	0000015
+#define  B19200	0000016
+#define  B38400	0000017
+#define EXTA B19200
+#define EXTB B38400
+#define CSIZE	0000060
+#define   CS5	0000000
+#define   CS6	0000020
+#define   CS7	0000040
+#define   CS8	0000060
+#define CSTOPB	0000100
+#define CREAD	0000200
+#define PARENB	0000400
+#define PARODD	0001000
+#define HUPCL	0002000
+#define CLOCAL	0004000
+#define CBAUDEX 0010000
+#define    B57600 0010001
+#define   B115200 0010002
+#define   B230400 0010003
+#define   B460800 0010004
+#define   B500000 0010005
+#define   B576000 0010006
+#define   B921600 0010007
+#define  B1000000 0010010
+#define  B1152000 0010011
+#define  B1500000 0010012
+#define  B2000000 0010013
+#define  B2500000 0010014
+#define  B3000000 0010015
+#define  B3500000 0010016
+#define  B4000000 0010017
+#define CIBAUD	  002003600000	/* input baud rate (not used) */
+#define CTVB	  004000000000		/* VisioBraille Terminal flow control */
+#define CMSPAR	  010000000000		/* mark or space (stick) parity */
+#define CRTSCTS	  020000000000		/* flow control */
+
+/* c_lflag bits */
+#define ISIG	0000001
+#define ICANON	0000002
+#define XCASE	0000004
+#define ECHO	0000010
+#define ECHOE	0000020
+#define ECHOK	0000040
+#define ECHONL	0000100
+#define NOFLSH	0000200
+#define TOSTOP	0000400
+#define ECHOCTL	0001000
+#define ECHOPRT	0002000
+#define ECHOKE	0004000
+#define FLUSHO	0010000
+#define PENDIN	0040000
+#define IEXTEN	0100000
+
+
+/* tcflow() and TCXONC use these */
+#define	TCOOFF		0
+#define	TCOON		1
+#define	TCIOFF		2
+#define	TCION		3
+
+/* tcflush() and TCFLSH use these */
+#define	TCIFLUSH	0
+#define	TCOFLUSH	1
+#define	TCIOFLUSH	2
+
+/* tcsetattr uses these */
+#define	TCSANOW		0
+#define	TCSADRAIN	1
+#define	TCSAFLUSH	2
+
+#endif /* _ASM_TERMBITS_H__ */
+
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/termios.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/termios.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/termios.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/termios.h	2004-11-05 14:13:04.267465031 +0000
@@ -0,0 +1,74 @@
+#ifndef _ASM_TERMIOS_H
+#define _ASM_TERMIOS_H
+
+#include <asm/termbits.h>
+#include <asm/ioctls.h>
+
+struct winsize {
+	unsigned short ws_row;
+	unsigned short ws_col;
+	unsigned short ws_xpixel;
+	unsigned short ws_ypixel;
+};
+
+#define NCC 8
+struct termio {
+	unsigned short c_iflag;		/* input mode flags */
+	unsigned short c_oflag;		/* output mode flags */
+	unsigned short c_cflag;		/* control mode flags */
+	unsigned short c_lflag;		/* local mode flags */
+	unsigned char c_line;		/* line discipline */
+	unsigned char c_cc[NCC];	/* control characters */
+};
+
+#ifdef __KERNEL__
+/*	intr=^C		quit=^|		erase=del	kill=^U
+	eof=^D		vtime=\0	vmin=\1		sxtc=\0
+	start=^Q	stop=^S		susp=^Z		eol=\0
+	reprint=^R	discard=^U	werase=^W	lnext=^V
+	eol2=\0
+*/
+#define INIT_C_CC "\003\034\177\025\004\0\1\0\021\023\032\0\022\017\027\026\0"
+#endif
+
+/* modem lines */
+#define TIOCM_LE	0x001
+#define TIOCM_DTR	0x002
+#define TIOCM_RTS	0x004
+#define TIOCM_ST	0x008
+#define TIOCM_SR	0x010
+#define TIOCM_CTS	0x020
+#define TIOCM_CAR	0x040
+#define TIOCM_RNG	0x080
+#define TIOCM_DSR	0x100
+#define TIOCM_CD	TIOCM_CAR
+#define TIOCM_RI	TIOCM_RNG
+#define TIOCM_OUT1	0x2000
+#define TIOCM_OUT2	0x4000
+#define TIOCM_LOOP	0x8000
+
+#define TIOCM_MODEM_BITS       TIOCM_OUT2      /* IRDA support */
+
+/* ioctl (fd, TIOCSERGETLSR, &result) where result may be as below */
+
+/* line disciplines */
+#define N_TTY		0
+#define N_SLIP		1
+#define N_MOUSE		2
+#define N_PPP		3
+#define N_STRIP		4
+#define N_AX25		5
+#define N_X25		6	/* X.25 async */
+#define N_6PACK		7
+#define N_MASC		8	/* Reserved for Mobitex module <kaz@cafe.net> */
+#define N_R3964		9	/* Reserved for Simatic R3964 module */
+#define N_PROFIBUS_FDL	10	/* Reserved for Profibus <Dave@mvhi.com> */
+#define N_IRDA		11	/* Linux IrDa - http://irda.sourceforge.net/ */
+#define N_SMSBLOCK	12	/* SMS block mode - for talking to GSM data cards about SMS messages */
+#define N_HDLC		13	/* synchronous HDLC */
+#define N_SYNC_PPP	14
+#define N_HCI		15  /* Bluetooth HCI UART */
+
+#include <asm-generic/termios.h>
+
+#endif /* _ASM_TERMIOS_H */
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/thread_info.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/thread_info.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/thread_info.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/thread_info.h	2004-11-05 14:13:04.272464609 +0000
@@ -0,0 +1,158 @@
+/* thread_info.h: description
+ *
+ * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ * Derived from include/asm-i386/thread_info.h
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _ASM_THREAD_INFO_H
+#define _ASM_THREAD_INFO_H
+
+#ifdef __KERNEL__
+
+#ifndef __ASSEMBLY__
+#include <asm/processor.h>
+#endif
+
+/*
+ * low level task data that entry.S needs immediate access to
+ * - this struct should fit entirely inside of one cache line
+ * - this struct shares the supervisor stack pages
+ * - if the contents of this structure are changed, the assembly constants must also be changed
+ */
+#ifndef __ASSEMBLY__
+
+struct thread_info {
+	struct task_struct	*task;		/* main task structure */
+	struct exec_domain	*exec_domain;	/* execution domain */
+	unsigned long		flags;		/* low level flags */
+	unsigned long		status;		/* thread-synchronous flags */
+	__u32			cpu;		/* current CPU */
+	__s32			preempt_count;	/* 0 => preemptable, <0 => BUG */
+
+	mm_segment_t		addr_limit;	/* thread address space:
+					 	   0-0xBFFFFFFF for user-thead
+						   0-0xFFFFFFFF for kernel-thread
+						*/
+	struct restart_block    restart_block;
+
+	__u8			supervisor_stack[0];
+};
+
+#else /* !__ASSEMBLY__ */
+
+/* offsets into the thread_info struct for assembly code access */
+#define TI_TASK			0x00000000
+#define TI_EXEC_DOMAIN		0x00000004
+#define TI_FLAGS		0x00000008
+#define TI_STATUS		0x0000000C
+#define TI_CPU			0x00000010
+#define TI_PRE_COUNT		0x00000014
+#define TI_ADDR_LIMIT		0x00000018
+#define TI_RESTART_BLOCK	0x0000001C
+
+#endif
+
+#define PREEMPT_ACTIVE		0x4000000
+
+/*
+ * macros/functions for gaining access to the thread information structure
+ *
+ * preempt_count needs to be 1 initially, until the scheduler is functional.
+ */
+#ifndef __ASSEMBLY__
+
+#define INIT_THREAD_INFO(tsk)			\
+{						\
+	.task		= &tsk,			\
+	.exec_domain	= &default_exec_domain,	\
+	.flags		= 0,			\
+	.cpu		= 0,			\
+	.preempt_count	= 1,			\
+	.addr_limit	= KERNEL_DS,		\
+	.restart_block = {			\
+		.fn = do_no_restart_syscall,	\
+	},					\
+}
+
+#define init_thread_info	(init_thread_union.thread_info)
+#define init_stack		(init_thread_union.stack)
+
+#ifdef CONFIG_SMALL_TASKS
+#define THREAD_SIZE		4096
+#else
+#define THREAD_SIZE		8192
+#endif
+
+/* how to get the thread information struct from C */
+register struct thread_info *__current_thread_info asm("gr15");
+
+#define current_thread_info() ({ __current_thread_info; })
+
+/* thread information allocation */
+#ifdef CONFIG_DEBUG_STACK_USAGE
+#define alloc_thread_info(tsk)					\
+	({							\
+		struct thread_info *ret;			\
+								\
+		ret = kmalloc(THREAD_SIZE, GFP_KERNEL);		\
+		if (ret)					\
+			memset(ret, 0, THREAD_SIZE);		\
+		ret;						\
+	})
+#else
+#define alloc_thread_info(tsk)	kmalloc(THREAD_SIZE, GFP_KERNEL)
+#endif
+
+#define free_thread_info(info)	kfree(info)
+#define get_thread_info(ti)	get_task_struct((ti)->task)
+#define put_thread_info(ti)	put_task_struct((ti)->task)
+
+#else /* !__ASSEMBLY__ */
+
+#define THREAD_SIZE	8192
+
+#endif
+
+/*
+ * thread information flags
+ * - these are process state flags that various assembly files may need to access
+ * - pending work-to-be-done flags are in LSW
+ * - other flags in MSW
+ */
+#define TIF_SYSCALL_TRACE	0	/* syscall trace active */
+#define TIF_NOTIFY_RESUME	1	/* resumption notification requested */
+#define TIF_SIGPENDING		2	/* signal pending */
+#define TIF_NEED_RESCHED	3	/* rescheduling necessary */
+#define TIF_SINGLESTEP		4	/* restore singlestep on return to user mode */
+#define TIF_IRET		5	/* return with iret */
+#define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling TIF_NEED_RESCHED */
+
+#define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
+#define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
+#define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
+#define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
+#define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
+#define _TIF_IRET		(1 << TIF_IRET)
+#define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
+
+#define _TIF_WORK_MASK		0x0000FFFE	/* work to do on interrupt/exception return */
+#define _TIF_ALLWORK_MASK	0x0000FFFF	/* work to do on any return to u-space */
+
+/*
+ * Thread-synchronous status.
+ *
+ * This is different from the flags in that nobody else
+ * ever touches our thread-synchronous status, so we don't
+ * have to worry about atomic accesses.
+ */
+#define TS_USEDFPM		0x0001	/* FPU/Media was used by this task this quantum (SMP) */
+
+#endif /* __KERNEL__ */
+
+#endif /* _ASM_THREAD_INFO_H */
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/timer-regs.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/timer-regs.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/timer-regs.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/timer-regs.h	2004-11-05 14:13:04.276464271 +0000
@@ -0,0 +1,106 @@
+/* timer-regs.h: hardware timer register definitions
+ *
+ * Copyright (C) 2003 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _ASM_TIMER_REGS_H
+#define _ASM_TIMER_REGS_H
+
+#include <asm/sections.h>
+
+extern unsigned long __nongprelbss __clkin_clock_speed_HZ;
+extern unsigned long __nongprelbss __ext_bus_clock_speed_HZ;
+extern unsigned long __nongprelbss __res_bus_clock_speed_HZ;
+extern unsigned long __nongprelbss __sdram_clock_speed_HZ;
+extern unsigned long __nongprelbss __core_bus_clock_speed_HZ;
+extern unsigned long __nongprelbss __core_clock_speed_HZ;
+extern unsigned long __nongprelbss __dsu_clock_speed_HZ;
+extern unsigned long __nongprelbss __serial_clock_speed_HZ;
+
+#define __get_CLKC()	({ *(volatile unsigned long *)(0xfeff9a00); })
+
+static inline void __set_CLKC(unsigned long v)
+{
+	int tmp;
+
+	asm volatile("	st%I0.p	%2,%M0		\n"
+		     "	setlos	%3,%1		\n"
+		     "	membar			\n"
+		     "0:			\n"
+		     "	subicc	%1,#1,%1,icc0	\n"
+		     "	bnc	icc0,#1,0b	\n"
+		     : "=m"(*(volatile unsigned long *) 0xfeff9a00), "=r"(tmp)
+		     : "r"(v), "i"(256)
+		     : "icc0");
+}
+
+#define __get_TCTR()	({ *(volatile unsigned long *)(0xfeff9418); })
+#define __get_TPRV()	({ *(volatile unsigned long *)(0xfeff9420); })
+#define __get_TPRCKSL()	({ *(volatile unsigned long *)(0xfeff9428); })
+#define __get_TCSR(T)	({ *(volatile unsigned long *)(0xfeff9400 + 8 * (T)); })
+#define __get_TxCKSL(T)	({ *(volatile unsigned long *)(0xfeff9430 + 8 * (T)); })
+
+#define __get_TCSR_DATA(T) ({ __get_TCSR(T) >> 24; })
+
+#define __set_TCTR(V)	do { *(volatile unsigned long *)(0xfeff9418) = (V); mb(); } while(0)
+#define __set_TPRV(V)	do { *(volatile unsigned long *)(0xfeff9420) = (V) << 24; mb(); } while(0)
+#define __set_TPRCKSL(V) do { *(volatile unsigned long *)(0xfeff9428) = (V); mb(); } while(0)
+#define __set_TCSR(T,V)	\
+do { *(volatile unsigned long *)(0xfeff9400 + 8 * (T)) = (V); mb(); } while(0)
+
+#define __set_TxCKSL(T,V) \
+do { *(volatile unsigned long *)(0xfeff9430 + 8 * (T)) = (V); mb(); } while(0)
+
+#define __set_TCSR_DATA(T,V) __set_TCSR(T, (V) << 24)
+#define __set_TxCKSL_DATA(T,V) __set_TxCKSL(T, TxCKSL_EIGHT | __TxCKSL_SELECT((V)))
+
+/* clock control register */
+#define CLKC_CMODE		0x0f000000
+#define CLKC_SLPL		0x000f0000
+#define CLKC_P0			0x00000100
+#define CLKC_CM			0x00000003
+
+#define CLKC_CMODE_s		24
+
+/* timer control register - non-readback mode */
+#define TCTR_MODE_0		0x00000000
+#define TCTR_MODE_2		0x04000000
+#define TCTR_MODE_4		0x08000000
+#define TCTR_MODE_5		0x0a000000
+#define TCTR_RL_LATCH		0x00000000
+#define TCTR_RL_RW_LOW8		0x10000000
+#define TCTR_RL_RW_HIGH8	0x20000000
+#define TCTR_RL_RW_LH8		0x30000000
+#define TCTR_SC_CTR0		0x00000000
+#define TCTR_SC_CTR1		0x40000000
+#define TCTR_SC_CTR2		0x80000000
+
+/* timer control register - readback mode */
+#define TCTR_CNT0		0x02000000
+#define TCTR_CNT1		0x04000000
+#define TCTR_CNT2		0x08000000
+#define TCTR_NSTATUS		0x10000000
+#define TCTR_NCOUNT		0x20000000
+#define TCTR_SC_READBACK	0xc0000000
+
+/* timer control status registers - non-readback mode */
+#define TCSRx_DATA		0xff000000
+
+/* timer control status registers - readback mode */
+#define TCSRx_OUTPUT		0x80000000
+#define TCSRx_NULLCOUNT		0x40000000
+#define TCSRx_RL		0x30000000
+#define TCSRx_MODE		0x07000000
+
+/* timer clock select registers */
+#define TxCKSL_SELECT		0x0f000000
+#define __TxCKSL_SELECT(X)	((X) << 24)
+#define TxCKSL_EIGHT		0xf0000000
+
+#endif /* _ASM_TIMER_REGS_H */
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/timex.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/timex.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/timex.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/timex.h	2004-11-05 14:13:04.279464017 +0000
@@ -0,0 +1,25 @@
+/* timex.h: FR-V architecture timex specifications
+ */
+#ifndef _ASM_TIMEX_H
+#define _ASM_TIMEX_H
+
+#define CLOCK_TICK_RATE		1193180 /* Underlying HZ */
+#define CLOCK_TICK_FACTOR	20	/* Factor of both 1000000 and CLOCK_TICK_RATE */
+
+#define FINETUNE							\
+((((((long)LATCH * HZ - CLOCK_TICK_RATE) << SHIFT_HZ) *			\
+   (1000000/CLOCK_TICK_FACTOR) / (CLOCK_TICK_RATE/CLOCK_TICK_FACTOR))	\
+  << (SHIFT_SCALE-SHIFT_HZ)) / HZ)
+
+typedef unsigned long cycles_t;
+
+static inline cycles_t get_cycles(void)
+{
+	return 0;
+}
+
+#define vxtime_lock()		do {} while (0)
+#define vxtime_unlock()		do {} while (0)
+
+#endif
+
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/tlbflush.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/tlbflush.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/tlbflush.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/tlbflush.h	2004-11-05 14:13:04.283463680 +0000
@@ -0,0 +1,76 @@
+/* tlbflush.h: TLB flushing functions
+ *
+ * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _ASM_TLBFLUSH_H
+#define _ASM_TLBFLUSH_H
+
+#include <linux/config.h>
+#include <linux/mm.h>
+#include <asm/processor.h>
+
+#ifdef CONFIG_MMU
+
+#ifndef __ASSEMBLY__
+extern void asmlinkage __flush_tlb_all(void);
+extern void asmlinkage __flush_tlb_mm(unsigned long contextid);
+extern void asmlinkage __flush_tlb_page(unsigned long contextid, unsigned long start);
+extern void asmlinkage __flush_tlb_range(unsigned long contextid,
+					 unsigned long start, unsigned long end);
+#endif /* !__ASSEMBLY__ */
+
+#define flush_tlb_all()				\
+do {						\
+	preempt_disable();			\
+	__flush_tlb_all();			\
+	preempt_enable();			\
+} while(0)
+
+#define flush_tlb_mm(mm)			\
+do {						\
+	preempt_disable();			\
+	__flush_tlb_mm((mm)->context.id);	\
+	preempt_enable();			\
+} while(0)
+
+#define flush_tlb_range(vma,start,end)					\
+do {									\
+	preempt_disable();						\
+	__flush_tlb_range((vma)->vm_mm->context.id, start, end);	\
+	preempt_enable();						\
+} while(0)
+
+#define flush_tlb_page(vma,addr)				\
+do {								\
+	preempt_disable();					\
+	__flush_tlb_page((vma)->vm_mm->context.id, addr);	\
+	preempt_enable();					\
+} while(0)
+
+
+#define __flush_tlb_global()			flush_tlb_all()
+#define flush_tlb()				flush_tlb_all()
+#define flush_tlb_kernel_range(start, end)	flush_tlb_all()
+#define flush_tlb_pgtables(mm,start,end)	asm volatile("movgs gr0,scr0 ! movgs gr0,scr1");
+
+#else
+
+#define flush_tlb()				BUG()
+#define flush_tlb_all()				BUG()
+#define flush_tlb_mm(mm)			BUG()
+#define flush_tlb_page(vma,addr)		BUG()
+#define flush_tlb_range(mm,start,end)		BUG()
+#define flush_tlb_pgtables(mm,start,end)	BUG()
+#define flush_tlb_kernel_range(start, end)	BUG()
+
+#endif
+
+
+#endif /* _ASM_TLBFLUSH_H */
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/tlb.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/tlb.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/tlb.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/tlb.h	2004-11-05 14:13:04.287463342 +0000
@@ -0,0 +1,23 @@
+#ifndef _ASM_TLB_H
+#define _ASM_TLB_H
+
+#include <asm/tlbflush.h>
+
+#define check_pgt_cache() do {} while(0)
+
+/*
+ * we don't need any special per-pte or per-vma handling...
+ */
+#define tlb_start_vma(tlb, vma)				do { } while (0)
+#define tlb_end_vma(tlb, vma)				do { } while (0)
+#define __tlb_remove_tlb_entry(tlb, ptep, address)	do { } while (0)
+
+/*
+ * .. because we flush the whole mm when it fills up
+ */
+#define tlb_flush(tlb)		flush_tlb_mm((tlb)->mm)
+
+#include <asm-generic/tlb.h>
+
+#endif /* _ASM_TLB_H */
+
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/topology.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/topology.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/topology.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/topology.h	2004-11-05 14:13:04.290463088 +0000
@@ -0,0 +1,14 @@
+#ifndef _ASM_TOPOLOGY_H
+#define _ASM_TOPOLOGY_H
+
+#ifdef CONFIG_NUMA
+
+#error NUMA not supported yet
+
+#else /* !CONFIG_NUMA */
+
+#include <asm-generic/topology.h>
+
+#endif /* CONFIG_NUMA */
+
+#endif /* _ASM_TOPOLOGY_H */
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/types.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/types.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/types.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/types.h	2004-11-05 14:13:04.294462751 +0000
@@ -0,0 +1,74 @@
+/* types.h: FRV types
+ *
+ * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _ASM_TYPES_H
+#define _ASM_TYPES_H
+
+#ifndef __ASSEMBLY__
+
+typedef unsigned short umode_t;
+
+/*
+ * __xx is ok: it doesn't pollute the POSIX namespace. Use these in the
+ * header files exported to user space
+ */
+
+typedef __signed__ char __s8;
+typedef unsigned char __u8;
+
+typedef __signed__ short __s16;
+typedef unsigned short __u16;
+
+typedef __signed__ int __s32;
+typedef unsigned int __u32;
+
+#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
+typedef __signed__ long long __s64;
+typedef unsigned long long __u64;
+#endif
+
+#endif /* __ASSEMBLY__ */
+
+/*
+ * These aren't exported outside the kernel to avoid name space clashes
+ */
+#ifdef __KERNEL__
+
+#define BITS_PER_LONG 32
+
+#ifndef __ASSEMBLY__
+
+#include <linux/config.h>
+
+typedef signed char s8;
+typedef unsigned char u8;
+
+typedef signed short s16;
+typedef unsigned short u16;
+
+typedef signed int s32;
+typedef unsigned int u32;
+
+typedef signed long long s64;
+typedef unsigned long long u64;
+typedef u64 u_quad_t;
+
+/* Dma addresses are 32-bits wide.  */
+
+typedef u32 dma_addr_t;
+
+typedef unsigned short kmem_bufctl_t;
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* __KERNEL__ */
+
+#endif /* _ASM_TYPES_H */
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/uaccess.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/uaccess.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/uaccess.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/uaccess.h	2004-11-05 14:13:04.299462328 +0000
@@ -0,0 +1,317 @@
+/* uaccess.h: userspace accessor functions
+ *
+ * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _ASM_UACCESS_H
+#define _ASM_UACCESS_H
+
+/*
+ * User space memory access functions
+ */
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <asm/segment.h>
+#include <asm/sections.h>
+
+#define HAVE_ARCH_UNMAPPED_AREA	/* we decide where to put mmaps */
+
+#define __ptr(x) ((unsigned long *)(x))
+
+#define VERIFY_READ	0
+#define VERIFY_WRITE	1
+
+#define __addr_ok(addr) ((unsigned long)(addr) < get_addr_limit())
+
+/*
+ * check that a range of addresses falls within the current address limit
+ */
+static inline int ___range_ok(unsigned long addr, unsigned long size)
+{
+#ifdef CONFIG_MMU
+	int flag = -EFAULT, tmp;
+
+	asm volatile (
+		"	addcc	%3,%2,%1,icc0	\n"	/* set C-flag if addr+size>4GB */
+		"	subcc.p	%1,%4,gr0,icc1	\n"	/* jump if addr+size>limit */
+		"	bc	icc0,#0,0f	\n"
+		"	bhi	icc1,#0,0f	\n"
+		"	setlos	#0,%0		\n"	/* mark okay */
+		"0:				\n"
+		: "=r"(flag), "=&r"(tmp)
+		: "r"(addr), "r"(size), "r"(get_addr_limit()), "0"(flag)
+		);
+
+	return flag;
+
+#else
+
+	if (addr < memory_start ||
+	    addr > memory_end ||
+	    size > memory_end - memory_start ||
+	    addr + size > memory_end)
+		return -EFAULT;
+
+	return 0;
+#endif
+}
+
+#define __range_ok(addr,size) ___range_ok((unsigned long) (addr), (unsigned long) (size))
+
+#define access_ok(type,addr,size) (__range_ok((addr), (size)) == 0)
+#define __access_ok(addr,size) (__range_ok((addr), (size)) == 0)
+
+static inline int verify_area(int type, const void * addr, unsigned long size)
+{
+	return __range_ok(addr, size);
+}
+
+/*
+ * The exception table consists of pairs of addresses: the first is the
+ * address of an instruction that is allowed to fault, and the second is
+ * the address at which the program should continue.  No registers are
+ * modified, so it is entirely up to the continuation code to figure out
+ * what to do.
+ *
+ * All the routines below use bits of fixup code that are out of line
+ * with the main instruction path.  This means when everything is well,
+ * we don't even have to jump over them.  Further, they do not intrude
+ * on our cache or tlb entries.
+ */
+struct exception_table_entry
+{
+	unsigned long insn, fixup;
+};
+
+/* Returns 0 if exception not found and fixup otherwise.  */
+extern unsigned long search_exception_table(unsigned long);
+
+
+/*
+ * These are the main single-value transfer routines.  They automatically
+ * use the right size if we just have the right pointer type.
+ */
+#define __put_user(x, ptr)						\
+({									\
+	int __pu_err = 0;						\
+									\
+	typeof(*(ptr)) __pu_val = (x);					\
+									\
+	switch (sizeof (*(ptr))) {					\
+	case 1:								\
+		__put_user_asm(__pu_err, __pu_val, ptr, "b", "r");	\
+		break;							\
+	case 2:								\
+		__put_user_asm(__pu_err, __pu_val, ptr, "h", "r");	\
+		break;							\
+	case 4:								\
+		__put_user_asm(__pu_err, __pu_val, ptr, "",  "r");	\
+		break;							\
+	case 8:								\
+		__put_user_asm(__pu_err, __pu_val, ptr, "d", "e");	\
+		break;							\
+	default:							\
+		__pu_err = __put_user_bad();				\
+		break;							\
+	}								\
+	__pu_err;							\
+})
+
+#define put_user(x, ptr)			\
+({						\
+	typeof(&*ptr) _p = (ptr);		\
+	int _e;					\
+						\
+	_e = __range_ok(_p, sizeof(*_p));	\
+	if (_e == 0)				\
+		_e = __put_user((x), _p);	\
+	_e;					\
+})
+
+extern int __put_user_bad(void);
+
+/*
+ * Tell gcc we read from memory instead of writing: this is because
+ * we do not write to any memory gcc knows about, so there are no
+ * aliasing issues.
+ */
+
+#ifdef CONFIG_MMU
+
+#define __put_user_asm(err,x,ptr,dsize,constraint)					\
+do {											\
+	asm volatile("1:	st"dsize"%I1	%2,%M1	\n"				\
+		     "2:				\n"				\
+		     ".subsection 2			\n"				\
+		     "3:	setlos		%3,%0	\n"				\
+		     "		bra		2b	\n"				\
+		     ".previous				\n"				\
+		     ".section __ex_table,\"a\"		\n"				\
+		     "		.balign		8	\n"				\
+		     "		.long		1b,3b	\n"				\
+		     ".previous"							\
+		     : "=r" (err)							\
+		     : "m" (*__ptr(ptr)), constraint (x), "i"(-EFAULT), "0"(err)	\
+		     : "memory");							\
+} while (0)
+
+#else
+
+#define __put_user_asm(err,x,ptr,bwl,con)	\
+do {						\
+	asm("	st"bwl"%I0	%1,%M0	\n"	\
+	    "	membar			\n"	\
+	    :					\
+	    : "m" (*__ptr(ptr)), con (x)	\
+	    : "memory");			\
+} while (0)
+
+#endif
+
+/*****************************************************************************/
+/*
+ *
+ */
+#define __get_user(x, ptr)						\
+({									\
+	typeof(*(ptr)) __gu_val = 0;					\
+	int __gu_err = 0;						\
+									\
+	switch (sizeof(*(ptr))) {					\
+	case 1:								\
+		__get_user_asm(__gu_err, __gu_val, ptr, "ub", "=r");	\
+		break;							\
+	case 2:								\
+		__get_user_asm(__gu_err, __gu_val, ptr, "uh", "=r");	\
+		break;							\
+	case 4:								\
+		__get_user_asm(__gu_err, __gu_val, ptr, "", "=r");	\
+		break;							\
+	case 8:								\
+		__get_user_asm(__gu_err, __gu_val, ptr, "d", "=e");	\
+		break;							\
+	default:							\
+		__gu_err = __get_user_bad();				\
+		break;							\
+	}								\
+	(x) = __gu_val;							\
+	__gu_err;							\
+})
+
+#define get_user(x, ptr)			\
+({						\
+	typeof(&*ptr) _p = (ptr);		\
+	int _e;					\
+						\
+	_e = __range_ok(_p, sizeof(*_p));	\
+	if (likely(_e == 0))			\
+		_e = __get_user((x), _p);	\
+	else					\
+		(x) = (typeof(x)) 0;		\
+	_e;					\
+})
+
+extern int __get_user_bad(void);
+
+#ifdef CONFIG_MMU
+
+#define __get_user_asm(err,x,ptr,dtype,constraint)	\
+do {							\
+	asm("1:		ld"dtype"%I2	%M2,%1	\n"	\
+	    "2:					\n"	\
+	    ".subsection 2			\n"	\
+	    "3:		setlos		%3,%0	\n"	\
+	    "		setlos		#0,%1	\n"	\
+	    "		bra		2b	\n"	\
+	    ".previous				\n"	\
+	    ".section __ex_table,\"a\"		\n"	\
+	    "		.balign		8	\n"	\
+	    "		.long		1b,3b	\n"	\
+	    ".previous"					\
+	    : "=r" (err), constraint (x)		\
+	    : "m" (*__ptr(ptr)), "i"(-EFAULT), "0"(err)	\
+	    );						\
+} while(0)
+
+#else
+
+#define __get_user_asm(err,x,ptr,bwl,con)	\
+	asm("	ld"bwl"%I1	%M1,%0	\n"	\
+	    "	membar			\n"	\
+	    : con(x)				\
+	    : "m" (*__ptr(ptr)))
+
+#endif
+
+/*****************************************************************************/
+/*
+ *
+ */
+#ifdef CONFIG_MMU
+extern long __memset_user(void *dst, unsigned long count);
+extern long __memcpy_user(void *dst, const void *src, unsigned long count);
+
+#define clear_user(dst,count)			__memset_user((dst), (count))
+#define __copy_from_user_inatomic(to, from, n)	__memcpy_user((to), (from), (n))
+#define __copy_to_user_inatomic(to, from, n)	__memcpy_user((to), (from), (n))
+
+#else
+
+#define clear_user(dst,count)			(memset((dst), 0, (count)), 0)
+#define __copy_from_user_inatomic(to, from, n)	(memcpy((to), (from), (n)), 0)
+#define __copy_to_user_inatomic(to, from, n)	(memcpy((to), (from), (n)), 0)
+
+#endif
+
+static inline unsigned long __must_check
+__copy_to_user(void __user *to, const void *from, unsigned long n)
+{
+       might_sleep();
+       return __copy_to_user_inatomic(to, from, n);
+}
+
+static inline unsigned long
+__copy_from_user(void *to, const void __user *from, unsigned long n)
+{
+       might_sleep();
+       return __copy_from_user_inatomic(to, from, n);
+}
+
+static inline long copy_from_user(void *to, const void *from, unsigned long n)
+{
+	unsigned long ret = n;
+
+	if (likely(__access_ok(from, n)))
+		ret = __copy_from_user(to, from, n);
+
+	if (unlikely(ret != 0))
+		memset(to + (n - ret), 0, ret);
+
+	return ret;
+}
+
+static inline long copy_to_user(void *to, const void *from, unsigned long n)
+{
+	return likely(__access_ok(to, n)) ? __copy_to_user(to, from, n) : n;
+}
+
+#define copy_to_user_ret(to,from,n,retval)	({ if (copy_to_user(to,from,n)) return retval; })
+#define copy_from_user_ret(to,from,n,retval)	({ if (copy_from_user(to,from,n)) return retval; })
+
+extern long strncpy_from_user(char *dst, const char *src, long count);
+extern long strnlen_user(const char *src, long count);
+
+#define strlen_user(str) strnlen_user(str, 32767)
+
+extern unsigned long search_exception_table(unsigned long addr);
+
+#define copy_to_user_page(vma, page, vaddr, dst, src, len)	memcpy(dst, src, len)
+#define copy_from_user_page(vma, page, vaddr, dst, src, len)	memcpy(dst, src, len)
+
+#endif /* _ASM_UACCESS_H */
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/ucontext.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/ucontext.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/ucontext.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/ucontext.h	2004-11-05 14:13:04.303461991 +0000
@@ -0,0 +1,12 @@
+#ifndef _ASM_UCONTEXT_H
+#define _ASM_UCONTEXT_H
+
+struct ucontext {
+	unsigned long		uc_flags;
+	struct ucontext		*uc_link;
+	stack_t			uc_stack;
+	struct sigcontext	uc_mcontext;
+	sigset_t		uc_sigmask;	/* mask last for extensibility */
+};
+
+#endif
