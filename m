Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261726AbUKHPEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261726AbUKHPEn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 10:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbUKHPEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 10:04:43 -0500
Received: from mx1.redhat.com ([66.187.233.31]:5060 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261882AbUKHOgO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 09:36:14 -0500
Date: Mon, 8 Nov 2004 14:34:19 GMT
Message-Id: <200411081434.iA8EYJw4023581@warthog.cambridge.redhat.com>
From: dhowells@redhat.com
To: torvalds@osdl.org, akpm@osdl.org, davidm@snapgear.com
cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: [PATCH 13/20] FRV: Fujitsu FR-V arch include files
In-Reply-To: <44bd214c-3193-11d9-8962-0002b3163499@redhat.com> 
References: <44bd214c-3193-11d9-8962-0002b3163499@redhat.com> 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch provides the arch-specific include files for the Fujitsu
FR-V CPU arch.

Signed-Off-By: dhowells@redhat.com
---
diffstat frv-include_2-2610rc1mm3.diff
 ipc.h               |   33 +++
 ipcbuf.h            |   30 +++
 irc-regs.h          |   53 +++++
 irq-routing.h       |   70 +++++++
 irq.h               |   44 ++++
 kmap_types.h        |   29 +++
 linkage.h           |    7 
 local.h             |    6 
 math-emu.h          |  301 +++++++++++++++++++++++++++++++
 mb-regs.h           |  185 +++++++++++++++++++
 mb86943a.h          |   39 ++++
 mb93091-fpga-irqs.h |   44 ++++
 mb93093-fpga-irqs.h |   31 +++
 mb93493-irqs.h      |   52 +++++
 mb93493-regs.h      |  279 +++++++++++++++++++++++++++++
 mem-layout.h        |   78 ++++++++
 mman.h              |   44 ++++
 mmu.h               |   42 ++++
 mmu_context.h       |   50 +++++
 module.h            |   20 ++
 msgbuf.h            |   32 +++
 namei.h             |   18 +
 page.h              |  104 +++++++++++
 param.h             |   23 ++
 pci.h               |  108 +++++++++++
 percpu.h            |    6 
 pgalloc.h           |   66 ++++++
 pgtable.h           |  491 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 poll.h              |   23 ++
 posix_types.h       |   66 ++++++
 processor.h         |  153 ++++++++++++++++
 ptrace.h            |   86 +++++++++
 32 files changed, 2613 insertions(+)

diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/ipcbuf.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/ipcbuf.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/ipcbuf.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/ipcbuf.h	2004-11-05 14:13:04.023485638 +0000
@@ -0,0 +1,30 @@
+#ifndef __ASM_IPCBUF_H__
+#define __ASM_IPCBUF_H__
+
+/*
+ * The user_ipc_perm structure for FR-V architecture.
+ * Note extra padding because this structure is passed back and forth
+ * between kernel and user space.
+ *
+ * Pad space is left for:
+ * - 32-bit mode_t and seq
+ * - 2 miscellaneous 32-bit values
+ */
+
+struct ipc64_perm
+{
+	__kernel_key_t		key;
+	__kernel_uid32_t	uid;
+	__kernel_gid32_t	gid;
+	__kernel_uid32_t	cuid;
+	__kernel_gid32_t	cgid;
+	__kernel_mode_t		mode;
+	unsigned short		__pad1;
+	unsigned short		seq;
+	unsigned short		__pad2;
+	unsigned long		__unused1;
+	unsigned long		__unused2;
+};
+
+#endif /* __ASM_IPCBUF_H__ */
+
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/ipc.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/ipc.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/ipc.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/ipc.h	2004-11-05 14:13:04.027485300 +0000
@@ -0,0 +1,33 @@
+#ifndef __ASM_IPC_H__
+#define __ASM_IPC_H__
+
+/* 
+ * These are used to wrap system calls on FR-V
+ *
+ * See arch/frv/kernel/sys_frv.c for ugly details..
+ */
+struct ipc_kludge {
+	struct msgbuf __user *msgp;
+	long msgtyp;
+};
+
+#define SEMOP		 1
+#define SEMGET		 2
+#define SEMCTL		 3
+#define SEMTIMEDOP	 4
+#define MSGSND		11
+#define MSGRCV		12
+#define MSGGET		13
+#define MSGCTL		14
+#define SHMAT		21
+#define SHMDT		22
+#define SHMGET		23
+#define SHMCTL		24
+
+/* Used by the DIPC package, try and avoid reusing it */
+#define DIPC		25
+
+#define IPCCALL(version,op)	((version)<<16 | (op))
+
+#endif
+
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/irc-regs.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/irc-regs.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/irc-regs.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/irc-regs.h	2004-11-05 14:13:04.031484963 +0000
@@ -0,0 +1,53 @@
+/* irc-regs.h: on-chip interrupt controller registers
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
+#ifndef _ASM_IRC_REGS
+#define _ASM_IRC_REGS
+
+#define __reg(ADDR) (*(volatile unsigned long *)(ADDR))
+
+#define __get_TM0()	({ __reg(0xfeff9800); })
+#define __get_TM1()	({ __reg(0xfeff9808); })
+#define __set_TM1(V)	do { __reg(0xfeff9808) = (V); mb(); } while(0)
+
+#define __set_TM1x(XI,V)			\
+do {						\
+	int shift = (XI) * 2 + 16;		\
+	unsigned long tm1 = __reg(0xfeff9808);	\
+	tm1 &= ~(0x3 << shift);			\
+	tm1 |= (V) << shift;			\
+	__reg(0xfeff9808) = tm1;		\
+	mb();					\
+} while(0)
+
+#define __get_RS(C)	({ (__reg(0xfeff9810) >> ((C)+16)) & 1; })
+
+#define __clr_RC(C)	do { __reg(0xfeff9818) = 1 << ((C)+16); mb(); } while(0)
+
+#define __get_MASK(C)	({ (__reg(0xfeff9820) >> ((C)+16)) & 1; })
+#define __set_MASK(C)	do { __reg(0xfeff9820) |=  1 << ((C)+16); mb(); } while(0)
+#define __clr_MASK(C)	do { __reg(0xfeff9820) &=  ~(1 << ((C)+16)); mb(); } while(0)
+
+#define __get_MASK_all() __get_MASK(0)
+#define __set_MASK_all() __set_MASK(0)
+#define __clr_MASK_all() __clr_MASK(0)
+
+#define __get_IRL()	({ (__reg(0xfeff9828) >> 16) & 0xf; })
+#define __clr_IRL()	do { __reg(0xfeff9828) = 0x100000; mb(); } while(0)
+
+#define __get_IRR(N)	({ __reg(0xfeff9840 + (N) * 8); })
+#define __set_IRR(N,V)	do { __reg(0xfeff9840 + (N) * 8) = (V); } while(0)
+
+#define __get_IITMR(N)	({ __reg(0xfeff9880 + (N) * 8); })
+#define __set_IITMR(N,V) do { __reg(0xfeff9880 + (N) * 8) = (V); } while(0)
+
+
+#endif /* _ASM_IRC_REGS */
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/irq.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/irq.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/irq.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/irq.h	2004-11-05 14:13:04.034484709 +0000
@@ -0,0 +1,44 @@
+/* irq.h: FRV IRQ definitions
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
+#ifndef _ASM_IRQ_H_
+#define _ASM_IRQ_H_
+
+#include <linux/config.h>
+
+/*
+ * the system has an on-CPU PIC and another PIC on the FPGA and other PICs on other peripherals,
+ * so we do some routing in irq-routing.[ch] to reduce the number of false-positives seen by
+ * drivers
+ */
+
+/* this number is used when no interrupt has been assigned */
+#define NO_IRQ				(-1)
+
+#define NR_IRQ_LOG2_ACTIONS_PER_GROUP	5
+#define NR_IRQ_ACTIONS_PER_GROUP	(1 << NR_IRQ_LOG2_ACTIONS_PER_GROUP)
+#define NR_IRQ_GROUPS			4
+#define NR_IRQS				(NR_IRQ_ACTIONS_PER_GROUP * NR_IRQ_GROUPS)
+
+/* probe returns a 32-bit IRQ mask:-/ */
+#define MIN_PROBE_IRQ	(NR_IRQS - 32)
+
+static inline int irq_canonicalize(int irq)
+{
+	return irq;
+}
+
+extern void disable_irq_nosync(unsigned int irq);
+extern void disable_irq(unsigned int irq);
+extern void enable_irq(unsigned int irq);
+
+
+#endif /* _ASM_IRQ_H_ */
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/irq-routing.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/irq-routing.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/irq-routing.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/irq-routing.h	2004-11-05 14:13:04.039484287 +0000
@@ -0,0 +1,70 @@
+/* irq-routing.h: multiplexed IRQ routing
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
+#ifndef _ASM_IRQ_ROUTING_H
+#define _ASM_IRQ_ROUTING_H
+
+#ifndef __ASSEMBLY__
+
+#include <linux/spinlock.h>
+#include <asm/irq.h>
+
+struct irq_source;
+struct irq_level;
+
+/*
+ * IRQ action distribution sets
+ */
+struct irq_group {
+	int			first_irq;	/* first IRQ distributed here */
+	void (*control)(struct irq_group *group, int index, int on);
+
+	struct irqaction	*actions[NR_IRQ_ACTIONS_PER_GROUP];	/* IRQ action chains */
+	struct irq_source	*sources[NR_IRQ_ACTIONS_PER_GROUP];	/* IRQ sources */
+	int			disable_cnt[NR_IRQ_ACTIONS_PER_GROUP];	/* disable counts */
+};
+
+/*
+ * IRQ source manager
+ */
+struct irq_source {
+	struct irq_source	*next;
+	struct irq_level	*level;
+	const char		*muxname;
+	volatile void __iomem	*muxdata;
+	unsigned long		irqmask;
+
+	void (*doirq)(struct irq_source *source);
+};
+
+/*
+ * IRQ level management (per CPU IRQ priority / entry vector)
+ */
+struct irq_level {
+	int			usage;
+	int			disable_count;
+	unsigned long		flags;		/* current SA_INTERRUPT and SA_SHIRQ settings */
+	spinlock_t		lock;
+	struct irq_source	*sources;
+};
+
+extern struct irq_level frv_irq_levels[16];
+extern struct irq_group *irq_groups[NR_IRQ_GROUPS];
+
+extern void frv_irq_route(struct irq_source *source, int irqlevel);
+extern void frv_irq_route_external(struct irq_source *source, int irq);
+extern void frv_irq_set_group(struct irq_group *group);
+extern void distribute_irqs(struct irq_group *group, unsigned long irqmask);
+extern void route_cpu_irqs(void);
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* _ASM_IRQ_ROUTING_H */
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/kmap_types.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/kmap_types.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/kmap_types.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/kmap_types.h	2004-11-05 14:13:04.042484033 +0000
@@ -0,0 +1,29 @@
+                                                                                
+#ifndef _ASM_KMAP_TYPES_H
+#define _ASM_KMAP_TYPES_H
+ 
+enum km_type {
+	/* arch specific kmaps - change the numbers attached to these at your peril */
+	__KM_CACHE,		/* cache flush page attachment point */
+	__KM_PGD,		/* current page directory */
+	__KM_ITLB_PTD,		/* current instruction TLB miss page table lookup */
+	__KM_DTLB_PTD,		/* current data TLB miss page table lookup */
+
+	/* general kmaps */
+        KM_BOUNCE_READ,
+        KM_SKB_SUNRPC_DATA,
+        KM_SKB_DATA_SOFTIRQ,
+        KM_USER0,
+        KM_USER1,
+	KM_BIO_SRC_IRQ,
+	KM_BIO_DST_IRQ,
+	KM_PTE0,
+	KM_PTE1,
+	KM_IRQ0,
+	KM_IRQ1,
+	KM_SOFTIRQ0,
+	KM_SOFTIRQ1,
+	KM_TYPE_NR
+};
+ 
+#endif
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/linkage.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/linkage.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/linkage.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/linkage.h	2004-11-05 14:13:04.046483696 +0000
@@ -0,0 +1,7 @@
+#ifndef __ASM_LINKAGE_H
+#define __ASM_LINKAGE_H
+
+#define __ALIGN		.align 4
+#define __ALIGN_STR	".align 4"
+
+#endif
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/local.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/local.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/local.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/local.h	2004-11-05 14:13:04.051483273 +0000
@@ -0,0 +1,6 @@
+#ifndef _ASM_LOCAL_H
+#define _ASM_LOCAL_H
+
+#include <asm-generic/local.h>
+
+#endif /* _ASM_LOCAL_H */
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/math-emu.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/math-emu.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/math-emu.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/math-emu.h	2004-11-05 14:13:04.000000000 +0000
@@ -0,0 +1,301 @@
+#ifndef _ASM_MATH_EMU_H
+#define _ASM_MATH_EMU_H
+
+#include <asm/setup.h>
+#include <linux/linkage.h>
+
+/* Status Register bits */
+
+/* accrued exception bits */
+#define FPSR_AEXC_INEX	3
+#define FPSR_AEXC_DZ	4
+#define FPSR_AEXC_UNFL	5
+#define FPSR_AEXC_OVFL	6
+#define FPSR_AEXC_IOP	7
+
+/* exception status bits */
+#define FPSR_EXC_INEX1	8
+#define FPSR_EXC_INEX2	9
+#define FPSR_EXC_DZ	10
+#define FPSR_EXC_UNFL	11
+#define FPSR_EXC_OVFL	12
+#define FPSR_EXC_OPERR	13
+#define FPSR_EXC_SNAN	14
+#define FPSR_EXC_BSUN	15
+
+/* quotient byte, assumes big-endian, of course */
+#define FPSR_QUOTIENT(fpsr) (*((signed char *) &(fpsr) + 1))
+
+/* condition code bits */
+#define FPSR_CC_NAN	24
+#define FPSR_CC_INF	25
+#define FPSR_CC_Z	26
+#define FPSR_CC_NEG	27
+
+
+/* Control register bits */
+
+/* rounding mode */
+#define	FPCR_ROUND_RN	0		/* round to nearest/even */
+#define FPCR_ROUND_RZ	1		/* round to zero */
+#define FPCR_ROUND_RM	2		/* minus infinity */
+#define FPCR_ROUND_RP	3		/* plus infinity */
+
+/* rounding precision */
+#define FPCR_PRECISION_X	0	/* long double */
+#define FPCR_PRECISION_S	1	/* double */
+#define FPCR_PRECISION_D	2	/* float */
+
+
+/* Flags to select the debugging output */
+#define PDECODE		0
+#define PEXECUTE	1
+#define PCONV		2
+#define PNORM		3
+#define PREGISTER	4
+#define PINSTR		5
+#define PUNIMPL		6
+#define PMOVEM		7
+
+#define PMDECODE	(1<<PDECODE)
+#define PMEXECUTE	(1<<PEXECUTE)
+#define PMCONV		(1<<PCONV)
+#define PMNORM		(1<<PNORM)
+#define PMREGISTER	(1<<PREGISTER)
+#define PMINSTR		(1<<PINSTR)
+#define PMUNIMPL	(1<<PUNIMPL)
+#define PMMOVEM		(1<<PMOVEM)
+
+#ifndef __ASSEMBLY__
+
+#include <linux/kernel.h>
+#include <linux/sched.h>
+
+union fp_mant64 {
+	unsigned long long m64;
+	unsigned long m32[2];
+};
+
+union fp_mant128 {
+	unsigned long long m64[2];
+	unsigned long m32[4];
+};
+
+/* internal representation of extended fp numbers */
+struct fp_ext {
+	unsigned char lowmant;
+	unsigned char sign;
+	unsigned short exp;
+	union fp_mant64 mant;
+};
+
+/* C representation of FPU registers */
+/* NOTE: if you change this, you have to change the assembler offsets
+   below and the size in <asm/fpu.h>, too */
+struct fp_data {
+	struct fp_ext fpreg[8];
+	unsigned int fpcr;
+	unsigned int fpsr;
+	unsigned int fpiar;
+	unsigned short prec;
+	unsigned short rnd;
+	struct fp_ext temp[2];
+};
+
+#if FPU_EMU_DEBUG
+extern unsigned int fp_debugprint;
+
+#define dprint(bit, fmt, args...) ({			\
+	if (fp_debugprint & (1 << (bit)))		\
+		printk(fmt, ## args);			\
+})
+#else
+#define dprint(bit, fmt, args...)
+#endif
+
+#define uprint(str) ({					\
+	static int __count = 3;				\
+							\
+	if (__count > 0) {				\
+		printk("You just hit an unimplemented "	\
+		       "fpu instruction (%s)\n", str);	\
+		printk("Please report this to ....\n");	\
+		__count--;				\
+	}						\
+})
+
+#define FPDATA		((struct fp_data *)current->thread.fp)
+
+#else	/* __ASSEMBLY__ */
+
+#define FPDATA		%a2
+
+/* offsets from the base register to the floating point data in the task struct */
+#define FPD_FPREG	(TASK_THREAD+THREAD_FPREG+0)
+#define FPD_FPCR	(TASK_THREAD+THREAD_FPREG+96)
+#define FPD_FPSR	(TASK_THREAD+THREAD_FPREG+100)
+#define FPD_FPIAR	(TASK_THREAD+THREAD_FPREG+104)
+#define FPD_PREC	(TASK_THREAD+THREAD_FPREG+108)
+#define FPD_RND		(TASK_THREAD+THREAD_FPREG+110)
+#define FPD_TEMPFP1	(TASK_THREAD+THREAD_FPREG+112)
+#define FPD_TEMPFP2	(TASK_THREAD+THREAD_FPREG+124)
+#define FPD_SIZEOF	(TASK_THREAD+THREAD_FPREG+136)
+
+/* offsets on the stack to access saved registers,
+ * these are only used during instruction decoding
+ * where we always know how deep we're on the stack.
+ */
+#define FPS_DO		(PT_D0)
+#define FPS_D1		(PT_D1)
+#define FPS_D2		(PT_D2)
+#define FPS_A0		(PT_A0)
+#define FPS_A1		(PT_A1)
+#define FPS_A2		(PT_A2)
+#define FPS_SR		(PT_SR)
+#define FPS_PC		(PT_PC)
+#define FPS_EA		(PT_PC+6)
+#define FPS_PC2		(PT_PC+10)
+
+.macro	fp_get_fp_reg
+	lea	(FPD_FPREG,FPDATA,%d0.w*4),%a0
+	lea	(%a0,%d0.w*8),%a0
+.endm
+
+/* Macros used to get/put the current program counter.
+ * 020/030 use a different stack frame then 040/060, for the
+ * 040/060 the return pc points already to the next location,
+ * so this only needs to be modified for jump instructions.
+ */
+.macro	fp_get_pc dest
+	move.l	(FPS_PC+4,%sp),\dest
+.endm
+
+.macro	fp_put_pc src,jump=0
+	move.l	\src,(FPS_PC+4,%sp)
+.endm
+
+.macro	fp_get_instr_data	f,s,dest,label
+	getuser	\f,%sp@(FPS_PC+4)@(0),\dest,\label,%sp@(FPS_PC+4)
+	addq.l	#\s,%sp@(FPS_PC+4)
+.endm
+
+.macro	fp_get_instr_word	dest,label,addr
+	fp_get_instr_data	w,2,\dest,\label,\addr
+.endm
+
+.macro	fp_get_instr_long	dest,label,addr
+	fp_get_instr_data	l,4,\dest,\label,\addr
+.endm
+
+/* These macros are used to read from/write to user space
+ * on error we jump to the fixup section, load the fault
+ * address into %a0 and jump to the exit.
+ * (derived from <asm/uaccess.h>)
+ */
+.macro	getuser	size,src,dest,label,addr
+|	printf	,"[\size<%08x]",1,\addr
+.Lu1\@:	moves\size	\src,\dest
+
+	.section .fixup,"ax"
+	.even
+.Lu2\@:	move.l	\addr,%a0
+	jra	\label
+	.previous
+
+	.section __ex_table,"a"
+	.align	4
+	.long	.Lu1\@,.Lu2\@
+	.previous
+.endm
+
+.macro	putuser	size,src,dest,label,addr
+|	printf	,"[\size>%08x]",1,\addr
+.Lu1\@:	moves\size	\src,\dest
+.Lu2\@:
+
+	.section .fixup,"ax"
+	.even
+.Lu3\@:	move.l	\addr,%a0
+	jra	\label
+	.previous
+
+	.section __ex_table,"a"
+	.align	4
+	.long	.Lu1\@,.Lu3\@
+	.long	.Lu2\@,.Lu3\@
+	.previous
+.endm
+
+
+.macro	movestack	nr,arg1,arg2,arg3,arg4,arg5
+	.if	\nr
+	movestack	(\nr-1),\arg2,\arg3,\arg4,\arg5
+	move.l	\arg1,-(%sp)
+	.endif
+.endm
+
+.macro	printf	bit=-1,string,nr=0,arg1,arg2,arg3,arg4,arg5
+#ifdef FPU_EMU_DEBUG
+	.data
+.Lpdata\@:
+	.string	"\string"
+	.previous
+
+	movem.l	%d0/%d1/%a0/%a1,-(%sp)
+	.if	\bit+1
+#if 0
+	moveq	#\bit,%d0
+	andw	#7,%d0
+	btst	%d0,fp_debugprint+((31-\bit)/8)
+#else
+	btst	#\bit,fp_debugprint+((31-\bit)/8)
+#endif
+	jeq	.Lpskip\@
+	.endif
+	movestack	\nr,\arg1,\arg2,\arg3,\arg4,\arg5
+	pea	.Lpdata\@
+	jsr	printk
+	lea	((\nr+1)*4,%sp),%sp
+.Lpskip\@:
+	movem.l	(%sp)+,%d0/%d1/%a0/%a1
+#endif
+.endm
+
+.macro	printx	bit,fp
+#ifdef FPU_EMU_DEBUG
+	movem.l	%d0/%a0,-(%sp)
+	lea	\fp,%a0
+#if 0
+	moveq	#'+',%d0
+	tst.w	(%a0)
+	jeq	.Lx1\@
+	moveq	#'-',%d0
+.Lx1\@:	printf	\bit," %c",1,%d0
+	move.l	(4,%a0),%d0
+	bclr	#31,%d0
+	jne	.Lx2\@
+	printf	\bit,"0."
+	jra	.Lx3\@
+.Lx2\@:	printf	\bit,"1."
+.Lx3\@:	printf	\bit,"%08x%08x",2,%d0,%a0@(8)
+	move.w	(2,%a0),%d0
+	ext.l	%d0
+	printf	\bit,"E%04x",1,%d0
+#else
+	printf	\bit," %08x%08x%08x",3,%a0@,%a0@(4),%a0@(8)
+#endif
+	movem.l	(%sp)+,%d0/%a0
+#endif
+.endm
+
+.macro	debug	instr,args
+#ifdef FPU_EMU_DEBUG
+	\instr	\args
+#endif
+.endm
+
+
+#endif	/* __ASSEMBLY__ */
+
+#endif	/* _ASM_FRV_MATH_EMU_H */
+
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/mb86943a.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/mb86943a.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/mb86943a.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/mb86943a.h	2004-11-05 14:13:04.060482513 +0000
@@ -0,0 +1,39 @@
+/* mb86943a.h: MB86943 SPARClite <-> PCI bridge registers
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
+#ifndef _ASM_MB86943A_H
+#define _ASM_MB86943A_H
+
+#include <asm/mb-regs.h>
+
+#define __reg_MB86943_sl_ctl		*(volatile uint32_t *) (__region_CS1 + 0x00)
+
+#define MB86943_SL_CTL_BUS_WIDTH_64	0x00000001
+#define MB86943_SL_CTL_AS_HOST		0x00000002
+#define MB86943_SL_CTL_DRCT_MASTER_SWAP	0x00000004
+#define MB86943_SL_CTL_DRCT_SLAVE_SWAP	0x00000008
+#define MB86943_SL_CTL_PCI_CONFIG_SWAP	0x00000010
+#define MB86943_SL_CTL_ECS0_ENABLE	0x00000020
+#define MB86943_SL_CTL_ECS1_ENABLE	0x00000040
+#define MB86943_SL_CTL_ECS2_ENABLE	0x00000080
+
+#define __reg_MB86943_ecs_ctl(N)	*(volatile uint32_t *) (__region_CS1 + 0x08 + (0x08*(N)))
+#define __reg_MB86943_ecs_range(N)	*(volatile uint32_t *) (__region_CS1 + 0x20 + (0x10*(N)))
+#define __reg_MB86943_ecs_base(N)	*(volatile uint32_t *) (__region_CS1 + 0x28 + (0x10*(N)))
+
+#define __reg_MB86943_sl_pci_io_range	*(volatile uint32_t *) (__region_CS1 + 0x50)
+#define __reg_MB86943_sl_pci_io_base	*(volatile uint32_t *) (__region_CS1 + 0x58)
+#define __reg_MB86943_sl_pci_mem_range	*(volatile uint32_t *) (__region_CS1 + 0x60)
+#define __reg_MB86943_sl_pci_mem_base	*(volatile uint32_t *) (__region_CS1 + 0x68)
+#define __reg_MB86943_pci_sl_io_base	*(volatile uint32_t *) (__region_CS1 + 0x70)
+#define __reg_MB86943_pci_sl_mem_base	*(volatile uint32_t *) (__region_CS1 + 0x78)
+
+#endif /* _ASM_MB86943A_H */
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/mb93091-fpga-irqs.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/mb93091-fpga-irqs.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/mb93091-fpga-irqs.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/mb93091-fpga-irqs.h	2004-11-05 14:13:04.065482091 +0000
@@ -0,0 +1,44 @@
+/* mb93091-fpga-irqs.h: MB93091 CPU board FPGA IRQs
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
+#ifndef _ASM_MB93091_FPGA_IRQS_H
+#define _ASM_MB93091_FPGA_IRQS_H
+
+#ifndef __ASSEMBLY__
+
+#include <asm/irq-routing.h>
+
+#define IRQ_BASE_FPGA		(NR_IRQ_ACTIONS_PER_GROUP * 1)
+
+/* IRQ IDs presented to drivers */
+enum {
+	IRQ_FPGA__UNUSED			= IRQ_BASE_FPGA,
+	IRQ_FPGA_SYSINT_BUS_EXPANSION_1,
+	IRQ_FPGA_SL_BUS_EXPANSION_2,
+	IRQ_FPGA_PCI_INTD,
+	IRQ_FPGA_PCI_INTC,
+	IRQ_FPGA_PCI_INTB,
+	IRQ_FPGA_PCI_INTA,
+	IRQ_FPGA_SL_BUS_EXPANSION_7,
+	IRQ_FPGA_SYSINT_BUS_EXPANSION_8,
+	IRQ_FPGA_SL_BUS_EXPANSION_9,
+	IRQ_FPGA_MB86943_PCI_INTA,
+	IRQ_FPGA_MB86943_SLBUS_SIDE,
+	IRQ_FPGA_RTL8029_INTA,
+	IRQ_FPGA_SYSINT_BUS_EXPANSION_13,
+	IRQ_FPGA_SL_BUS_EXPANSION_14,
+	IRQ_FPGA_NMI,
+};
+
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* _ASM_MB93091_FPGA_IRQS_H */
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/mb93093-fpga-irqs.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/mb93093-fpga-irqs.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/mb93093-fpga-irqs.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/mb93093-fpga-irqs.h	2004-11-05 14:13:04.000000000 +0000
@@ -0,0 +1,31 @@
+/* mb93093-fpga-irqs.h: MB93093 CPU board FPGA IRQs
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
+#ifndef _ASM_MB93093_FPGA_IRQS_H
+#define _ASM_MB93093_FPGA_IRQS_H
+
+#ifndef __ASSEMBLY__
+
+#include <asm/irq-routing.h>
+
+#define IRQ_BASE_FPGA		(NR_IRQ_ACTIONS_PER_GROUP * 1)
+
+/* IRQ IDs presented to drivers */
+enum {
+	IRQ_FPGA_PUSH_BUTTON_SW1_5		= IRQ_BASE_FPGA + 8,
+	IRQ_FPGA_ROCKER_C_SW8			= IRQ_BASE_FPGA + 9,
+	IRQ_FPGA_ROCKER_C_SW9			= IRQ_BASE_FPGA + 10,
+};
+
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* _ASM_MB93093_FPGA_IRQS_H */
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/mb93493-irqs.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/mb93493-irqs.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/mb93493-irqs.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/mb93493-irqs.h	2004-11-05 14:13:04.072481500 +0000
@@ -0,0 +1,52 @@
+/* mb93493-irqs.h: MB93493 companion chip IRQs
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
+#ifndef _ASM_MB93493_IRQS_H
+#define _ASM_MB93493_IRQS_H
+
+#ifndef __ASSEMBLY__
+
+#include <asm/irq-routing.h>
+
+#define IRQ_BASE_MB93493	(NR_IRQ_ACTIONS_PER_GROUP * 2)
+
+/* IRQ IDs presented to drivers */
+enum {
+	IRQ_MB93493_VDC			= IRQ_BASE_MB93493 + 0,
+	IRQ_MB93493_VCC			= IRQ_BASE_MB93493 + 1,
+	IRQ_MB93493_AUDIO_OUT		= IRQ_BASE_MB93493 + 2,
+	IRQ_MB93493_I2C_0		= IRQ_BASE_MB93493 + 3,
+	IRQ_MB93493_I2C_1		= IRQ_BASE_MB93493 + 4,
+	IRQ_MB93493_USB			= IRQ_BASE_MB93493 + 5,
+	IRQ_MB93493_LOCAL_BUS		= IRQ_BASE_MB93493 + 7,
+	IRQ_MB93493_PCMCIA		= IRQ_BASE_MB93493 + 8,
+	IRQ_MB93493_GPIO		= IRQ_BASE_MB93493 + 9,
+	IRQ_MB93493_AUDIO_IN		= IRQ_BASE_MB93493 + 10,
+};
+
+/* IRQ multiplexor mappings */
+#define ROUTE_VIA_IRQ0	0	/* route IRQ by way of CPU external IRQ 0 */
+#define ROUTE_VIA_IRQ1	1	/* route IRQ by way of CPU external IRQ 1 */
+
+#define IRQ_MB93493_VDC_ROUTE		ROUTE_VIA_IRQ0
+#define IRQ_MB93493_VCC_ROUTE		ROUTE_VIA_IRQ1
+#define IRQ_MB93493_AUDIO_OUT_ROUTE	ROUTE_VIA_IRQ1
+#define IRQ_MB93493_I2C_0_ROUTE		ROUTE_VIA_IRQ1
+#define IRQ_MB93493_I2C_1_ROUTE		ROUTE_VIA_IRQ1
+#define IRQ_MB93493_USB_ROUTE		ROUTE_VIA_IRQ1
+#define IRQ_MB93493_LOCAL_BUS_ROUTE	ROUTE_VIA_IRQ1
+#define IRQ_MB93493_PCMCIA_ROUTE	ROUTE_VIA_IRQ1
+#define IRQ_MB93493_GPIO_ROUTE		ROUTE_VIA_IRQ1
+#define IRQ_MB93493_AUDIO_IN_ROUTE	ROUTE_VIA_IRQ1
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* _ASM_MB93493_IRQS_H */
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/mb93493-regs.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/mb93493-regs.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/mb93493-regs.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/mb93493-regs.h	2004-11-05 14:13:04.077481078 +0000
@@ -0,0 +1,279 @@
+/* mb93493-regs.h: MB93493 companion chip registers
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
+#ifndef _ASM_MB93493_REGS_H
+#define _ASM_MB93493_REGS_H
+
+#include <asm/mb-regs.h>
+#include <asm/mb93493-irqs.h>
+
+#define __get_MB93493(X)	({ *(volatile unsigned long *)(__region_CS3 + (X)); })
+
+#define __set_MB93493(X,V)						\
+do {									\
+	*(volatile unsigned long *)(__region_CS3 + (X)) = (V); mb();	\
+} while(0)
+
+#define __get_MB93493_STSR(X)	__get_MB93493(0x3c0 + (X) * 4)
+#define __set_MB93493_STSR(X,V)	__set_MB93493(0x3c0 + (X) * 4, (V))
+#define MB93493_STSR_EN
+
+#define __get_MB93493_IQSR(X)	__get_MB93493(0x3d0 + (X) * 4)
+#define __set_MB93493_IQSR(X,V)	__set_MB93493(0x3d0 + (X) * 4, (V))
+
+#define __get_MB93493_DQSR(X)	__get_MB93493(0x3e0 + (X) * 4)
+#define __set_MB93493_DQSR(X,V)	__set_MB93493(0x3e0 + (X) * 4, (V))
+
+#define __get_MB93493_LBSER()	__get_MB93493(0x3f0)
+#define __set_MB93493_LBSER(V)	__set_MB93493(0x3f0, (V))
+
+#define MB93493_LBSER_VDC	0x00010000
+#define MB93493_LBSER_VCC	0x00020000
+#define MB93493_LBSER_AUDIO	0x00040000
+#define MB93493_LBSER_I2C_0	0x00080000
+#define MB93493_LBSER_I2C_1	0x00100000
+#define MB93493_LBSER_USB	0x00200000
+#define MB93493_LBSER_GPIO	0x00800000
+#define MB93493_LBSER_PCMCIA	0x01000000
+
+#define __get_MB93493_LBSR()	__get_MB93493(0x3fc)
+#define __set_MB93493_LBSR(V)	__set_MB93493(0x3fc, (V))
+
+/*
+ * video display controller
+ */
+#define __get_MB93493_VDC(X)	__get_MB93493(MB93493_VDC_##X)
+#define __set_MB93493_VDC(X,V)	__set_MB93493(MB93493_VDC_##X, (V))
+
+#define MB93493_VDC_RCURSOR	0x140	/* cursor position */
+#define MB93493_VDC_RCT1	0x144	/* cursor colour 1 */
+#define MB93493_VDC_RCT2	0x148	/* cursor colour 2 */
+#define MB93493_VDC_RHDC	0x150	/* horizontal display period */
+#define MB93493_VDC_RH_MARGINS	0x154	/* horizontal margin sizes */
+#define MB93493_VDC_RVDC	0x158	/* vertical display period */
+#define MB93493_VDC_RV_MARGINS	0x15c	/* vertical margin sizes */
+#define MB93493_VDC_RC		0x170	/* VDC control */
+#define MB93493_VDC_RCLOCK	0x174	/* clock divider, DMA req delay */
+#define MB93493_VDC_RBLACK	0x178	/* black insert sizes */
+#define MB93493_VDC_RS		0x17c	/* VDC status */
+
+#define __addr_MB93493_VDC_BCI(X)  ({ (volatile unsigned long *)(__region_CS3 + 0x000 + (X)); })
+#define __addr_MB93493_VDC_TPO(X)  (__region_CS3 + 0x1c0 + (X))
+
+#define VDC_TPO_WIDTH		32
+
+#define VDC_RC_DSR		0x00000080	/* VDC master reset */
+
+#define VDC_RS_IT		0x00060000	/* interrupt indicators */
+#define VDC_RS_IT_UNDERFLOW	0x00040000	/* - underflow event */
+#define VDC_RS_IT_VSYNC		0x00020000	/* - VSYNC event */
+#define VDC_RS_DFI		0x00010000	/* current interlace field number */
+#define VDC_RS_DFI_TOP		0x00000000	/* - top field */
+#define VDC_RS_DFI_BOTTOM	0x00010000	/* - bottom field */
+#define VDC_RS_DCSR		0x00000010	/* cursor state */
+#define VDC_RS_DCM		0x00000003	/* display mode */
+#define VDC_RS_DCM_DISABLED	0x00000000	/* - display disabled */
+#define VDC_RS_DCM_STOPPED	0x00000001	/* - VDC stopped */
+#define VDC_RS_DCM_FREERUNNING	0x00000002	/* - VDC free-running */
+#define VDC_RS_DCM_TRANSFERRING	0x00000003	/* - data being transferred to VDC */
+
+/*
+ * video capture controller
+ */
+#define __get_MB93493_VCC(X)	__get_MB93493(MB93493_VCC_##X)
+#define __set_MB93493_VCC(X,V)	__set_MB93493(MB93493_VCC_##X, (V))
+
+#define MB93493_VCC_RREDUCT	0x104	/* reduction rate */
+#define MB93493_VCC_RHY		0x108	/* horizontal brightness filter coefficients */
+#define MB93493_VCC_RHC		0x10c	/* horizontal colour-difference filter coefficients */
+#define MB93493_VCC_RHSIZE	0x110	/* horizontal cycle sizes */
+#define MB93493_VCC_RHBC	0x114	/* horizontal back porch size */
+#define MB93493_VCC_RVCC	0x118	/* vertical capture period */
+#define MB93493_VCC_RVBC	0x11c	/* vertical back porch period */
+#define MB93493_VCC_RV		0x120	/* vertical filter coefficients */
+#define MB93493_VCC_RDTS	0x128	/* DMA transfer size */
+#define MB93493_VCC_RDTS_4B	0x01000000	/* 4-byte transfer */
+#define MB93493_VCC_RDTS_32B	0x03000000	/* 32-byte transfer */
+#define MB93493_VCC_RDTS_SHIFT	24
+#define MB93493_VCC_RCC		0x130	/* VCC control */
+#define MB93493_VCC_RIS		0x134	/* VCC interrupt status */
+
+#define __addr_MB93493_VCC_TPI(X)  (__region_CS3 + 0x180 + (X))
+
+#define VCC_RHSIZE_RHCC		0x000007ff
+#define VCC_RHSIZE_RHCC_SHIFT	0
+#define VCC_RHSIZE_RHTCC	0x0fff0000
+#define VCC_RHSIZE_RHTCC_SHIFT	16
+
+#define VCC_RVBC_RVBC		0x00003f00
+#define VCC_RVBC_RVBC_SHIFT	8
+
+#define VCC_RREDUCT_RHR		0x07ff0000
+#define VCC_RREDUCT_RHR_SHIFT	16
+#define VCC_RREDUCT_RVR		0x000007ff
+#define VCC_RREDUCT_RVR_SHIFT	0
+
+#define VCC_RCC_CE		0x00000001	/* VCC enable */
+#define VCC_RCC_CS		0x00000002	/* request video capture start */
+#define VCC_RCC_CPF		0x0000000c	/* pixel format */
+#define VCC_RCC_CPF_YCBCR_16	0x00000000	/* - YCbCr 4:2:2 16-bit format */
+#define VCC_RCC_CPF_RGB		0x00000004	/* - RGB 4:4:4 format */
+#define VCC_RCC_CPF_YCBCR_24	0x00000008	/* - YCbCr 4:2:2 24-bit format */
+#define VCC_RCC_CPF_BT656	0x0000000c	/* - ITU R-BT.656 format */
+#define VCC_RCC_CPF_SHIFT	2
+#define VCC_RCC_CSR		0x00000080	/* request reset */
+#define VCC_RCC_HSIP		0x00000100	/* HSYNC polarity */
+#define VCC_RCC_HSIP_LOACT	0x00000000	/* - low active */
+#define VCC_RCC_HSIP_HIACT	0x00000100	/* - high active */
+#define VCC_RCC_VSIP		0x00000200	/* VSYNC polarity */
+#define VCC_RCC_VSIP_LOACT	0x00000000	/* - low active */
+#define VCC_RCC_VSIP_HIACT	0x00000200	/* - high active */
+#define VCC_RCC_CIE		0x00000800	/* interrupt enable */
+#define VCC_RCC_CFP		0x00001000	/* RGB pixel packing */
+#define VCC_RCC_CFP_4TO3	0x00000000	/* - pack 4 pixels into 3 words */
+#define VCC_RCC_CFP_1TO1	0x00001000	/* - pack 1 pixel into 1 words */
+#define VCC_RCC_CSM		0x00006000	/* interlace specification */
+#define VCC_RCC_CSM_ONEPASS	0x00002000	/* - non-interlaced */
+#define VCC_RCC_CSM_INTERLACE	0x00004000	/* - interlaced */
+#define VCC_RCC_CSM_SHIFT	13
+#define VCC_RCC_ES		0x00008000	/* capture start polarity */
+#define VCC_RCC_ES_NEG		0x00000000	/* - negative edge */
+#define VCC_RCC_ES_POS		0x00008000	/* - positive edge */
+#define VCC_RCC_IFI		0x00080000	/* inferlace field evaluation reverse */
+#define VCC_RCC_FDTS		0x00300000	/* interlace field start */
+#define VCC_RCC_FDTS_3_8	0x00000000	/* - 3/8 of horizontal entire cycle */
+#define VCC_RCC_FDTS_1_4	0x00100000	/* - 1/4 of horizontal entire cycle */
+#define VCC_RCC_FDTS_7_16	0x00200000	/* - 7/16 of horizontal entire cycle */
+#define VCC_RCC_FDTS_SHIFT	20
+#define VCC_RCC_MOV		0x00400000	/* test bit - always set to 1 */
+#define VCC_RCC_STP		0x00800000	/* request video capture stop */
+#define VCC_RCC_TO		0x01000000	/* input during top-field only */
+
+#define VCC_RIS_VSYNC		0x01000000	/* VSYNC interrupt */
+#define VCC_RIS_OV		0x02000000	/* overflow interrupt */
+#define VCC_RIS_BOTTOM		0x08000000	/* interlace bottom field */
+#define VCC_RIS_STARTED		0x10000000	/* capture started */
+
+/*
+ * I2C
+ */
+#define MB93493_I2C_BSR 	0x340		/* bus status */
+#define MB93493_I2C_BCR		0x344		/* bus control */
+#define MB93493_I2C_CCR		0x348		/* clock control */
+#define MB93493_I2C_ADR		0x34c		/* address */
+#define MB93493_I2C_DTR		0x350		/* data */
+#define MB93493_I2C_BC2R	0x35c		/* bus control 2 */
+
+#define __addr_MB93493_I2C(port,X)   (__region_CS3 + MB93493_I2C_##X + ((port)*0x20))
+#define __get_MB93493_I2C(port,X)    __get_MB93493(MB93493_I2C_##X + ((port)*0x20))
+#define __set_MB93493_I2C(port,X,V)  __set_MB93493(MB93493_I2C_##X + ((port)*0x20), (V))
+
+#define I2C_BSR_BB	(1 << 7)
+
+/*
+ * audio controller (I2S) registers
+ */
+#define __get_MB93493_I2S(X)	__get_MB93493(MB93493_I2S_##X)
+#define __set_MB93493_I2S(X,V)	__set_MB93493(MB93493_I2S_##X, (V))
+
+#define MB93493_I2S_ALDR	0x300		/* L-channel data */
+#define MB93493_I2S_ARDR	0x304		/* R-channel data */
+#define MB93493_I2S_APDR	0x308		/* 16-bit packed data */
+#define MB93493_I2S_AISTR	0x310		/* status */
+#define MB93493_I2S_AICR	0x314		/* control */
+
+#define __addr_MB93493_I2S_ALDR(X)	(__region_CS3 + MB93493_I2S_ALDR + (X))
+#define __addr_MB93493_I2S_ARDR(X)	(__region_CS3 + MB93493_I2S_ARDR + (X))
+#define __addr_MB93493_I2S_APDR(X)	(__region_CS3 + MB93493_I2S_APDR + (X))
+#define __addr_MB93493_I2S_ADR(X)	(__region_CS3 + 0x320 + (X))
+
+#define I2S_AISTR_OTST		0x00000003	/* status of output data transfer */
+#define I2S_AISTR_OTR		0x00000010	/* output transfer request pending */
+#define I2S_AISTR_OUR		0x00000020	/* output FIFO underrun detected */
+#define I2S_AISTR_OOR		0x00000040	/* output FIFO overrun detected */
+#define I2S_AISTR_ODS		0x00000100	/* output DMA transfer size */
+#define I2S_AISTR_ODE		0x00000400	/* output DMA transfer request enable */
+#define I2S_AISTR_OTRIE		0x00001000	/* output transfer request interrupt enable */
+#define I2S_AISTR_OURIE		0x00002000	/* output FIFO underrun interrupt enable */
+#define I2S_AISTR_OORIE		0x00004000	/* output FIFO overrun interrupt enable */
+#define I2S_AISTR__OUT_MASK	0x00007570
+#define I2S_AISTR_ITST		0x00030000	/* status of input data transfer */
+#define I2S_AISTR_ITST_SHIFT	16
+#define I2S_AISTR_ITR		0x00100000	/* input transfer request pending */
+#define I2S_AISTR_IUR		0x00200000	/* input FIFO underrun detected */
+#define I2S_AISTR_IOR		0x00400000	/* input FIFO overrun detected */
+#define I2S_AISTR_IDS		0x01000000	/* input DMA transfer size */
+#define I2S_AISTR_IDE		0x04000000	/* input DMA transfer request enable */
+#define I2S_AISTR_ITRIE		0x10000000	/* input transfer request interrupt enable */
+#define I2S_AISTR_IURIE		0x20000000	/* input FIFO underrun interrupt enable */
+#define I2S_AISTR_IORIE		0x40000000	/* input FIFO overrun interrupt enable */
+#define I2S_AISTR__IN_MASK	0x75700000
+
+#define I2S_AICR_MI		0x00000001	/* mono input requested */
+#define I2S_AICR_AMI		0x00000002	/* relation between LRCKI/FS1 and SDI */
+#define I2S_AICR_LRI		0x00000004	/* function of LRCKI pin */
+#define I2S_AICR_SDMI		0x00000070	/* format of input audio data */
+#define I2S_AICR_SDMI_SHIFT	4
+#define I2S_AICR_CLI		0x00000080	/* input FIFO clearing control */
+#define I2S_AICR_IM		0x00000300	/* input state control */
+#define I2S_AICR_IM_SHIFT	8
+#define I2S_AICR__IN_MASK	0x000003f7
+#define I2S_AICR_MO		0x00001000	/* mono output requested */
+#define I2S_AICR_AMO		0x00002000	/* relation between LRCKO/FS0 and SDO */
+#define I2S_AICR_AMO_SHIFT	13
+#define I2S_AICR_LRO		0x00004000	/* function of LRCKO pin */
+#define I2S_AICR_SDMO		0x00070000	/* format of output audio data */
+#define I2S_AICR_SDMO_SHIFT	16
+#define I2S_AICR_CLO		0x00080000	/* output FIFO clearing control */
+#define I2S_AICR_OM		0x00100000	/* output state control */
+#define I2S_AICR__OUT_MASK	0x001f7000
+#define I2S_AICR_DIV		0x03000000	/* frequency division rate */
+#define I2S_AICR_DIV_SHIFT	24
+#define I2S_AICR_FL		0x20000000	/* frame length */
+#define I2S_AICR_FS		0x40000000	/* frame sync method */
+#define I2S_AICR_ME		0x80000000	/* master enable */
+
+/*
+ * PCMCIA
+ */
+#define __addr_MB93493_PCMCIA(X)  ((volatile unsigned long *)(__region_CS5 + (X)))
+
+/*
+ * GPIO
+ */
+#define __get_MB93493_GPIO_PDR(X)	__get_MB93493(0x380 + (X) * 0xc0)
+#define __set_MB93493_GPIO_PDR(X,V)	__set_MB93493(0x380 + (X) * 0xc0, (V))
+
+#define __get_MB93493_GPIO_GPDR(X)	__get_MB93493(0x384 + (X) * 0xc0)
+#define __set_MB93493_GPIO_GPDR(X,V)	__set_MB93493(0x384 + (X) * 0xc0, (V))
+
+#define __get_MB93493_GPIO_SIR(X)	__get_MB93493(0x388 + (X) * 0xc0)
+#define __set_MB93493_GPIO_SIR(X,V)	__set_MB93493(0x388 + (X) * 0xc0, (V))
+
+#define __get_MB93493_GPIO_SOR(X)	__get_MB93493(0x38c + (X) * 0xc0)
+#define __set_MB93493_GPIO_SOR(X,V)	__set_MB93493(0x38c + (X) * 0xc0, (V))
+
+#define __get_MB93493_GPIO_PDSR(X)	__get_MB93493(0x390 + (X) * 0xc0)
+#define __set_MB93493_GPIO_PDSR(X,V)	__set_MB93493(0x390 + (X) * 0xc0, (V))
+
+#define __get_MB93493_GPIO_PDCR(X)	__get_MB93493(0x394 + (X) * 0xc0)
+#define __set_MB93493_GPIO_PDCR(X,V)	__set_MB93493(0x394 + (X) * 0xc0, (V))
+
+#define __get_MB93493_GPIO_INTST(X)	__get_MB93493(0x398 + (X) * 0xc0)
+#define __set_MB93493_GPIO_INTST(X,V)	__set_MB93493(0x398 + (X) * 0xc0, (V))
+
+#define __get_MB93493_GPIO_IEHL(X)	__get_MB93493(0x39c + (X) * 0xc0)
+#define __set_MB93493_GPIO_IEHL(X,V)	__set_MB93493(0x39c + (X) * 0xc0, (V))
+
+#define __get_MB93493_GPIO_IELH(X)	__get_MB93493(0x3a0 + (X) * 0xc0)
+#define __set_MB93493_GPIO_IELH(X,V)	__set_MB93493(0x3a0 + (X) * 0xc0, (V))
+
+#endif /* _ASM_MB93493_REGS_H */
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/mb-regs.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/mb-regs.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/mb-regs.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/mb-regs.h	2004-11-05 14:13:04.081480740 +0000
@@ -0,0 +1,185 @@
+/* mb-regs.h: motherboard registers
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
+#ifndef _ASM_MB_REGS_H
+#define _ASM_MB_REGS_H
+
+#include <asm/cpu-irqs.h>
+#include <asm/sections.h>
+#include <asm/mem-layout.h>
+
+#define __region_IO	KERNEL_IO_START	/* the region from 0xe0000000 to 0xffffffff has suitable
+					 * protection laid over the top for use in memory-mapped
+					 * I/O
+					 */
+
+#define __region_CS0	0xff000000	/* Boot ROMs area */
+
+#ifdef CONFIG_MB93091_VDK
+/*
+ * VDK motherboard and CPU card specific stuff
+ */
+
+#include <asm/mb93091-fpga-irqs.h>
+
+#define IRQ_CPU_MB93493_0	IRQ_CPU_EXTERNAL0
+#define IRQ_CPU_MB93493_1	IRQ_CPU_EXTERNAL1
+
+#define __region_CS2	0xe0000000	/* SLBUS/PCI I/O space */
+#define __region_CS2_M		0x0fffffff /* mask */
+#define __region_CS2_C		0x00000000 /* control */
+#define __region_CS5	0xf0000000	/* MB93493 CSC area (DAV daughter board) */
+#define __region_CS5_M		0x00ffffff
+#define __region_CS5_C		0x00010000
+#define __region_CS7	0xf1000000	/* CB70 CPU-card PCMCIA port I/O space */
+#define __region_CS7_M		0x00ffffff
+#define __region_CS7_C		0x00410701
+#define __region_CS1	0xfc000000	/* SLBUS/PCI bridge control registers */
+#define __region_CS1_M		0x000fffff
+#define __region_CS1_C		0x00000000
+#define __region_CS6	0xfc100000	/* CB70 CPU-card DM9000 LAN I/O space */
+#define __region_CS6_M		0x000fffff
+#define __region_CS6_C		0x00400707
+#define __region_CS3	0xfc200000	/* MB93493 CSR area (DAV daughter board) */
+#define __region_CS3_M		0x000fffff
+#define __region_CS3_C		0xc8100000
+#define __region_CS4	0xfd000000	/* CB70 CPU-card extra flash space */
+#define __region_CS4_M		0x00ffffff
+#define __region_CS4_C		0x00000f07
+
+#define __region_PCI_IO		(__region_CS2 + 0x04000000UL)
+#define __region_PCI_MEM	(__region_CS2 + 0x08000000UL)
+#define __flush_PCI_writes()						\
+do {									\
+	__builtin_write8((volatile void *) __region_PCI_MEM, 0);	\
+} while(0)
+
+#define __is_PCI_IO(addr) \
+	(((unsigned long)(addr) >> 24) - (__region_PCI_IO >> 24)  < (0x04000000UL >> 24))
+
+#define __is_PCI_MEM(addr) \
+	((unsigned long)(addr) - __region_PCI_MEM < 0x08000000UL)
+
+#define __get_CLKSW()	({ *(volatile unsigned long *)(__region_CS2 + 0x0130000cUL) & 0xffUL; })
+#define __get_CLKIN()	(__get_CLKSW() * 125U * 100000U / 24U)
+
+#ifndef __ASSEMBLY__
+extern int __nongprelbss mb93090_mb00_detected;
+#endif
+
+#define __addr_LEDS()		(__region_CS2 + 0x01200004UL)
+#ifdef CONFIG_MB93090_MB00
+#define __set_LEDS(X)							\
+do {									\
+	if (mb93090_mb00_detected)					\
+		__builtin_write32((void *) __addr_LEDS(), ~(X));	\
+} while (0)
+#else
+#define __set_LEDS(X)
+#endif
+
+#define __addr_LCD()		(__region_CS2 + 0x01200008UL)
+#define __get_LCD(B)		__builtin_read32((volatile void *) (B))
+#define __set_LCD(B,X)		__builtin_write32((volatile void *) (B), (X))
+
+#define LCD_D			0x000000ff		/* LCD data bus */
+#define LCD_RW			0x00000100		/* LCD R/W signal */
+#define LCD_RS			0x00000200		/* LCD Register Select */
+#define LCD_E			0x00000400		/* LCD Start Enable Signal */
+
+#define LCD_CMD_CLEAR		(LCD_E|0x001)
+#define LCD_CMD_HOME		(LCD_E|0x002)
+#define LCD_CMD_CURSOR_INC	(LCD_E|0x004)
+#define LCD_CMD_SCROLL_INC	(LCD_E|0x005)
+#define LCD_CMD_CURSOR_DEC	(LCD_E|0x006)
+#define LCD_CMD_SCROLL_DEC	(LCD_E|0x007)
+#define LCD_CMD_OFF		(LCD_E|0x008)
+#define LCD_CMD_ON(CRSR,BLINK)	(LCD_E|0x00c|(CRSR<<1)|BLINK)
+#define LCD_CMD_CURSOR_MOVE_L	(LCD_E|0x010)
+#define LCD_CMD_CURSOR_MOVE_R	(LCD_E|0x014)
+#define LCD_CMD_DISPLAY_SHIFT_L	(LCD_E|0x018)
+#define LCD_CMD_DISPLAY_SHIFT_R	(LCD_E|0x01c)
+#define LCD_CMD_FUNCSET(DL,N,F)	(LCD_E|0x020|(DL<<4)|(N<<3)|(F<<2))
+#define LCD_CMD_SET_CG_ADDR(X)	(LCD_E|0x040|X)
+#define LCD_CMD_SET_DD_ADDR(X)	(LCD_E|0x080|X)
+#define LCD_CMD_READ_BUSY	(LCD_E|LCD_RW)
+#define LCD_DATA_WRITE(X)	(LCD_E|LCD_RS|(X))
+#define LCD_DATA_READ		(LCD_E|LCD_RS|LCD_RW)
+
+#else
+/*
+ * PDK unit specific stuff
+ */
+
+#include <asm/mb93093-fpga-irqs.h>
+
+#define IRQ_CPU_MB93493_0	IRQ_CPU_EXTERNAL0
+#define IRQ_CPU_MB93493_1	IRQ_CPU_EXTERNAL1
+
+#define __region_CS5	0xf0000000	/* MB93493 CSC area (DAV daughter board) */
+#define __region_CS5_M		0x00ffffff /* mask */
+#define __region_CS5_C		0x00010000 /* control */
+#define __region_CS2	0x20000000	/* FPGA registers */
+#define __region_CS2_M		0x000fffff
+#define __region_CS2_C		0x00000000
+#define __region_CS1	0xfc100000	/* LAN registers */
+#define __region_CS1_M		0x000fffff
+#define __region_CS1_C		0x00010404
+#define __region_CS3	0xfc200000	/* MB93493 CSR area (DAV daughter board) */
+#define __region_CS3_M		0x000fffff
+#define __region_CS3_C		0xc8000000
+#define __region_CS4	0xfd000000	/* extra ROMs area */
+#define __region_CS4_M		0x00ffffff
+#define __region_CS4_C		0x00000f07
+
+#define __region_CS6	0xfe000000	/* not used - hide behind CPU resource I/O regs */
+#define __region_CS6_M		0x000fffff
+#define __region_CS6_C		0x00000f07
+#define __region_CS7	0xfe000000	/* not used - hide behind CPU resource I/O regs */
+#define __region_CS7_M		0x000fffff
+#define __region_CS7_C		0x00000f07
+
+#define __is_PCI_IO(addr)	0	/* no PCI */
+#define __is_PCI_MEM(addr)	0
+#define __region_PCI_IO		0
+#define __region_PCI_MEM	0
+#define __flush_PCI_writes()	do { } while(0)
+
+#define __get_CLKSW()		0UL
+#define __get_CLKIN()		66000000UL
+
+#define __addr_LEDS()		(__region_CS2 + 0x00000023UL)
+#define __set_LEDS(X)		__builtin_write8((volatile void *) __addr_LEDS(), (X))
+
+#define __addr_FPGATR()		(__region_CS2 + 0x00000030UL)
+#define __set_FPGATR(X)		__builtin_write32((volatile void *) __addr_FPGATR(), (X))
+#define __get_FPGATR()		__builtin_read32((volatile void *) __addr_FPGATR())
+
+#define MB93093_FPGA_FPGATR_AUDIO_CLK	0x00000003
+
+#define __set_FPGATR_AUDIO_CLK(V) \
+	__set_FPGATR((__get_FPGATR() & ~MB93093_FPGA_FPGATR_AUDIO_CLK) | (V))
+
+#define MB93093_FPGA_FPGATR_AUDIO_CLK_OFF	0x0
+#define MB93093_FPGA_FPGATR_AUDIO_CLK_11MHz	0x1
+#define MB93093_FPGA_FPGATR_AUDIO_CLK_12MHz	0x2
+#define MB93093_FPGA_FPGATR_AUDIO_CLK_02MHz	0x3
+
+#define MB93093_FPGA_SWR_PUSHSWMASK	(0x1F<<26)
+#define MB93093_FPGA_SWR_PUSHSW4	(1<<29)
+
+#define __addr_FPGA_SWR		((volatile void *)(__region_CS2 + 0x28UL))
+#define __get_FPGA_PUSHSW1_5()	(__builtin_read32(__addr_FPGA_SWR) & MB93093_FPGA_SWR_PUSHSWMASK)
+
+
+#endif
+
+#endif /* _ASM_MB_REGS_H */
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/mem-layout.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/mem-layout.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/mem-layout.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/mem-layout.h	2004-11-05 14:13:04.085480402 +0000
@@ -0,0 +1,78 @@
+/* mem-layout.h: memory layout
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
+#ifndef _ASM_MEM_LAYOUT_H
+#define _ASM_MEM_LAYOUT_H
+
+#ifndef __ASSEMBLY__
+#define __UL(X)	((unsigned long) (X))
+#else
+#define __UL(X)	(X)
+#endif
+
+/*
+ * PAGE_SHIFT determines the page size
+ */
+#define PAGE_SHIFT			14
+
+#ifndef __ASSEMBLY__
+#define PAGE_SIZE			(1UL << PAGE_SHIFT)
+#else
+#define PAGE_SIZE			(1 << PAGE_SHIFT)
+#endif
+
+#define PAGE_MASK			(~(PAGE_SIZE-1))
+
+/*****************************************************************************/
+/*
+ * virtual memory layout from kernel's point of view
+ */
+#define PAGE_OFFSET			((unsigned long) &__page_offset)
+
+#ifdef CONFIG_MMU
+
+/* see Documentation/fujitsu/frv/mmu-layout.txt */
+#define KERNEL_LOWMEM_START		__UL(0xc0000000)
+#define KERNEL_LOWMEM_END		__UL(0xd0000000)
+#define VMALLOC_START			__UL(0xd0000000)
+#define VMALLOC_END			__UL(0xd8000000)
+#define PKMAP_BASE			__UL(0xd8000000)
+#define PKMAP_END			__UL(0xdc000000)
+#define KMAP_ATOMIC_SECONDARY_FRAME	__UL(0xdc000000)
+#define KMAP_ATOMIC_PRIMARY_FRAME	__UL(0xdd000000)
+
+#endif
+
+#define KERNEL_IO_START			__UL(0xe0000000)
+
+
+/*****************************************************************************/
+/*
+ * memory layout from userspace's point of view
+ */
+#define BRK_BASE			__UL(2 * 1024 * 1024 + PAGE_SIZE)
+#define STACK_TOP			__UL(2 * 1024 * 1024)
+
+/* userspace process size */
+#ifdef CONFIG_MMU
+#define TASK_SIZE			(PAGE_OFFSET)
+#else
+#define TASK_SIZE			__UL(0xFFFFFFFFUL)
+#endif
+
+/* base of area at which unspecified mmaps will start */
+#ifdef CONFIG_BINFMT_ELF_FDPIC
+#define TASK_UNMAPPED_BASE		__UL(16 * 1024 * 1024)
+#else
+#define TASK_UNMAPPED_BASE		__UL(TASK_SIZE / 3)
+#endif
+
+#endif /* _ASM_MEM_LAYOUT_H */
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/mman.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/mman.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/mman.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/mman.h	2004-11-05 14:13:04.089480064 +0000
@@ -0,0 +1,44 @@
+#ifndef __ASM_MMAN_H__
+#define __ASM_MMAN_H__
+
+#define PROT_READ	0x1		/* page can be read */
+#define PROT_WRITE	0x2		/* page can be written */
+#define PROT_EXEC	0x4		/* page can be executed */
+#define PROT_SEM	0x8		/* page may be used for atomic ops */
+#define PROT_NONE	0x0		/* page can not be accessed */
+#define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
+#define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
+
+#define MAP_SHARED	0x01		/* Share changes */
+#define MAP_PRIVATE	0x02		/* Changes are private */
+#define MAP_TYPE	0x0f		/* Mask for type of mapping */
+#define MAP_FIXED	0x10		/* Interpret addr exactly */
+#define MAP_ANONYMOUS	0x20		/* don't use a file */
+
+#define MAP_GROWSDOWN	0x0100		/* stack-like segment */
+#define MAP_DENYWRITE	0x0800		/* ETXTBSY */
+#define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
+#define MAP_LOCKED	0x2000		/* pages are locked */
+#define MAP_NORESERVE	0x4000		/* don't check for reservations */
+#define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
+#define MAP_NONBLOCK	0x10000		/* do not block on IO */
+
+#define MS_ASYNC	1		/* sync memory asynchronously */
+#define MS_INVALIDATE	2		/* invalidate the caches */
+#define MS_SYNC		4		/* synchronous memory sync */
+
+#define MCL_CURRENT	1		/* lock all current mappings */
+#define MCL_FUTURE	2		/* lock all future mappings */
+
+#define MADV_NORMAL	0x0		/* default page-in behavior */
+#define MADV_RANDOM	0x1		/* page-in minimum required */
+#define MADV_SEQUENTIAL	0x2		/* read-ahead aggressively */
+#define MADV_WILLNEED	0x3		/* pre-fault pages */
+#define MADV_DONTNEED	0x4		/* discard these pages */
+
+/* compatibility flags */
+#define MAP_ANON	MAP_ANONYMOUS
+#define MAP_FILE	0
+
+#endif /* __ASM_MMAN_H__ */
+
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/mmu_context.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/mmu_context.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/mmu_context.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/mmu_context.h	2004-11-05 15:56:17.064106992 +0000
@@ -0,0 +1,50 @@
+/* mmu_context.h: MMU context management routines
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
+#ifndef _ASM_MMU_CONTEXT_H
+#define _ASM_MMU_CONTEXT_H
+
+#include <linux/config.h>
+#include <asm/setup.h>
+#include <asm/page.h>
+#include <asm/pgalloc.h>
+
+static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
+{
+}
+
+#ifdef CONFIG_MMU
+extern int init_new_context(struct task_struct *tsk, struct mm_struct *mm);
+extern void change_mm_context(mm_context_t *old, mm_context_t *ctx, pml4_t *_pml4);
+extern void destroy_context(struct mm_struct *mm);
+
+#else
+#define init_new_context(tsk, mm)		({ 0; })
+#define change_mm_context(old, ctx, _pml4)	do {} while(0)
+#define destroy_context(mm)			do {} while(0)
+#endif
+
+#define switch_mm(prev, next, tsk)						\
+do {										\
+	if (prev != next)							\
+		change_mm_context(&prev->context, &next->context, next->pml4);	\
+} while(0)
+
+#define activate_mm(prev, next)						\
+do {									\
+	change_mm_context(&prev->context, &next->context, next->pml4);	\
+} while(0)
+
+#define deactivate_mm(tsk, mm)			\
+do {						\
+} while(0)
+
+#endif
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/mmu.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/mmu.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/mmu.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/mmu.h	2004-11-05 14:13:04.097479388 +0000
@@ -0,0 +1,42 @@
+/* mmu.h: memory management context for FR-V with or without MMU support
+ *
+ * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#ifndef _ASM_MMU_H
+#define _ASM_MMU_H
+
+typedef struct {
+#ifdef CONFIG_MMU
+	struct list_head id_link;		/* link in list of context ID owners */
+	unsigned short	id;			/* MMU context ID */
+	unsigned short	id_busy;		/* true if ID is in CXNR */
+	unsigned long	itlb_cached_pge;	/* [SCR0] PGE cached for insn TLB handler */
+	unsigned long	itlb_ptd_mapping;	/* [DAMR4] PTD mapping for itlb cached PGE */
+	unsigned long	dtlb_cached_pge;	/* [SCR1] PGE cached for data TLB handler */
+	unsigned long	dtlb_ptd_mapping;	/* [DAMR5] PTD mapping for dtlb cached PGE */
+
+#else
+	struct mm_tblock_struct	*tblock;
+	unsigned long		end_brk;
+
+#endif
+
+#ifdef CONFIG_BINFMT_ELF_FDPIC
+	unsigned long	exec_fdpic_loadmap;
+	unsigned long	interp_fdpic_loadmap;
+#endif
+
+} mm_context_t;
+
+#ifdef CONFIG_MMU
+extern int __nongpreldata cxn_pinned;
+extern int cxn_pin_by_pid(pid_t pid);
+#endif
+
+#endif /* _ASM_MMU_H */
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/module.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/module.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/module.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/module.h	2004-11-05 14:13:04.103478882 +0000
@@ -0,0 +1,20 @@
+/* module.h: FRV module stuff
+ *
+ * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#ifndef _ASM_MODULE_H
+#define _ASM_MODULE_H
+
+#define module_map(x)		vmalloc(x)
+#define module_unmap(x)		vfree(x)
+#define module_arch_init(x)	(0)
+#define arch_init_modules(x)	do { } while (0)
+
+#endif /* _ASM_MODULE_H */
+
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/msgbuf.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/msgbuf.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/msgbuf.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/msgbuf.h	2004-11-05 14:13:04.107478544 +0000
@@ -0,0 +1,32 @@
+#ifndef _ASM_MSGBUF_H
+#define _ASM_MSGBUF_H
+
+/* 
+ * The msqid64_ds structure for FR-V architecture.
+ * Note extra padding because this structure is passed back and forth
+ * between kernel and user space.
+ *
+ * Pad space is left for:
+ * - 64-bit time_t to solve y2038 problem
+ * - 2 miscellaneous 32-bit values
+ */
+
+struct msqid64_ds {
+	struct ipc64_perm	msg_perm;
+	__kernel_time_t		msg_stime;	/* last msgsnd time */
+	unsigned long		__unused1;
+	__kernel_time_t		msg_rtime;	/* last msgrcv time */
+	unsigned long		__unused2;
+	__kernel_time_t		msg_ctime;	/* last change time */
+	unsigned long		__unused3;
+	unsigned long		msg_cbytes;	/* current number of bytes on queue */
+	unsigned long		msg_qnum;	/* number of messages in queue */
+	unsigned long		msg_qbytes;	/* max number of bytes on queue */
+	__kernel_pid_t		msg_lspid;	/* pid of last msgsnd */
+	__kernel_pid_t		msg_lrpid;	/* last receive pid */
+	unsigned long		__unused4;
+	unsigned long		__unused5;
+};
+
+#endif /* _ASM_MSGBUF_H */
+
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/namei.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/namei.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/namei.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/namei.h	2004-11-05 14:13:04.111478206 +0000
@@ -0,0 +1,18 @@
+/*
+ * asm/namei.h
+ *
+ * Included from linux/fs/namei.c
+ */
+
+#ifndef __ASM_NAMEI_H
+#define __ASM_NAMEI_H
+
+/* This dummy routine maybe changed to something useful
+ * for /usr/gnemul/ emulation stuff.
+ * Look at asm-sparc/namei.h for details.
+ */
+
+#define __emul_prefix() NULL
+
+#endif
+
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/page.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/page.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/page.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/page.h	2004-11-05 16:02:50.175208222 +0000
@@ -0,0 +1,104 @@
+#ifndef _ASM_PAGE_H
+#define _ASM_PAGE_H
+
+#ifdef __KERNEL__
+
+#include <linux/config.h>
+#include <asm/virtconvert.h>
+#include <asm/mem-layout.h>
+#include <asm/sections.h>
+#include <asm/setup.h>
+ 
+#ifndef __ASSEMBLY__
+ 
+#define get_user_page(vaddr)			__get_free_page(GFP_KERNEL)
+#define free_user_page(page, addr)		free_page(addr)
+
+#define clear_page(pgaddr)			memset((pgaddr), 0, PAGE_SIZE)
+#define copy_page(to,from)			memcpy((to), (from), PAGE_SIZE)
+
+#define clear_user_page(pgaddr, vaddr, page)	memset((pgaddr), 0, PAGE_SIZE)
+#define copy_user_page(vto, vfrom, vaddr, topg)	memcpy((vto), (vfrom), PAGE_SIZE)
+
+/*
+ * These are used to make use of C type-checking..
+ */
+typedef struct { unsigned long pte;	} pte_t;
+typedef struct { unsigned long ste[64];	} pmd_t;
+typedef struct { pmd_t         pge[1];	} pgd_t;
+typedef struct { unsigned long pgprot;	} pgprot_t;
+
+#define pte_val(x)	((x).pte)
+#define pmd_val(x)	((x).ste[0])
+#define pgd_val(x)	((x).pge[0])
+#define pgprot_val(x)	((x).pgprot)
+
+#define __pte(x)	((pte_t) { (x) } )
+#define __pmd(x)	((pmd_t) { (x) } )
+#define __pgd(x)	((pgd_t) { (x) } )
+#define __pgprot(x)	((pgprot_t) { (x) } )
+#define PTE_MASK	PAGE_MASK
+
+/* to align the pointer to the (next) page boundary */
+#define PAGE_ALIGN(addr)	(((addr) + PAGE_SIZE - 1) & PAGE_MASK)
+
+/* Pure 2^n version of get_order */
+static inline int get_order(unsigned long size) __attribute_const__;
+static inline int get_order(unsigned long size)
+{
+	int order;
+
+	size = (size - 1) >> (PAGE_SHIFT - 1);
+	order = -1;
+	do {
+		size >>= 1;
+		order++;
+	} while (size);
+	return order;
+}
+
+#define devmem_is_allowed(pfn)	1
+
+#define __pa(vaddr)		virt_to_phys((void *) vaddr)
+#define __va(paddr)		phys_to_virt((unsigned long) paddr)
+
+#define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
+
+extern unsigned long max_low_pfn;
+extern unsigned long min_low_pfn;
+extern unsigned long max_pfn;
+
+#ifdef CONFIG_MMU
+#define pfn_to_page(pfn)	(mem_map + (pfn))
+#define page_to_pfn(page)	((unsigned long) ((page) - mem_map))
+#define pfn_valid(pfn)		((pfn) < max_mapnr)
+
+#else
+#define pfn_to_page(pfn)	(&mem_map[(pfn) - (PAGE_OFFSET >> PAGE_SHIFT)])
+#define page_to_pfn(page)	((PAGE_OFFSET >> PAGE_SHIFT) + (unsigned long) ((page) - mem_map))
+#define pfn_valid(pfn)		((pfn) >= min_low_pfn && (pfn) < max_low_pfn)
+
+#endif
+
+#define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
+#define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
+
+
+#ifdef CONFIG_MMU
+#define VM_DATA_DEFAULT_FLAGS \
+	(VM_READ | VM_WRITE | \
+	((current->personality & READ_IMPLIES_EXEC) ? VM_EXEC : 0 ) | \
+		 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
+#endif
+
+#include <asm-generic/nopml4-page.h>
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* __KERNEL__ */
+
+#ifdef CONFIG_CONTIGUOUS_PAGE_ALLOC
+#define WANT_PAGE_VIRTUAL	1
+#endif
+
+#endif /* _ASM_PAGE_H */
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/param.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/param.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/param.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/param.h	2004-11-05 14:13:04.119477530 +0000
@@ -0,0 +1,23 @@
+#ifndef _ASM_PARAM_H
+#define _ASM_PARAM_H
+
+#ifdef __KERNEL__
+#define HZ		1000		/* Internal kernel timer frequency */
+#define USER_HZ		100		/* .. some user interfaces are in "ticks" */
+#define CLOCKS_PER_SEC	(USER_HZ)	/* like times() */
+#endif
+
+#ifndef HZ
+#define HZ 100
+#endif
+
+#define EXEC_PAGESIZE	16384
+
+#ifndef NOGROUP
+#define NOGROUP		(-1)
+#endif
+
+#define MAXHOSTNAMELEN		64	/* max length of hostname */
+#define COMMAND_LINE_SIZE	512
+
+#endif /* _ASM_PARAM_H */
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/pci.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/pci.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/pci.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/pci.h	2004-11-05 14:13:04.123477193 +0000
@@ -0,0 +1,108 @@
+/* pci.h: FR-V specific PCI declarations
+ *
+ * Copyright (C) 2003 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ * - Derived from include/asm-m68k/pci.h
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef ASM_PCI_H
+#define	ASM_PCI_H
+
+#include <linux/config.h>
+#include <linux/mm.h>
+#include <asm/scatterlist.h>
+#include <asm-generic/pci-dma-compat.h>
+#include <asm-generic/pci.h>
+
+struct pci_dev;
+
+#define pcibios_assign_all_busses()	0
+
+static inline void pcibios_add_platform_entries(struct pci_dev *dev)
+{
+}
+
+extern void pcibios_set_master(struct pci_dev *dev);
+
+extern void pcibios_penalize_isa_irq(int irq);
+
+#ifdef CONFIG_MMU
+extern void *consistent_alloc(int gfp, size_t size, dma_addr_t *dma_handle);
+extern void consistent_free(void *vaddr);
+extern void consistent_sync(void *vaddr, size_t size, int direction);
+extern void consistent_sync_page(struct page *page, unsigned long offset,
+				 size_t size, int direction);
+#endif
+
+extern void *pci_alloc_consistent(struct pci_dev *hwdev, size_t size,
+				  dma_addr_t *dma_handle);
+
+extern void pci_free_consistent(struct pci_dev *hwdev, size_t size,
+				void *vaddr, dma_addr_t dma_handle);
+
+/* This is always fine. */
+#define pci_dac_dma_supported(pci_dev, mask)	(1)
+
+/* Return the index of the PCI controller for device PDEV. */
+#define pci_controller_num(PDEV)	(0)
+
+/* The PCI address space does equal the physical memory
+ * address space.  The networking and block device layers use
+ * this boolean for bounce buffer decisions.
+ */
+#define PCI_DMA_BUS_IS_PHYS	(1)
+
+/*
+ *	These are pretty much arbitary with the CoMEM implementation.
+ *	We have the whole address space to ourselves.
+ */
+#define PCIBIOS_MIN_IO		0x100
+#define PCIBIOS_MIN_MEM		0x00010000
+
+/* Make physical memory consistent for a single
+ * streaming mode DMA translation after a transfer.
+ *
+ * If you perform a pci_map_single() but wish to interrogate the
+ * buffer using the cpu, yet do not wish to teardown the PCI dma
+ * mapping, you must call this function before doing so.  At the
+ * next point you give the PCI dma address back to the card, the
+ * device again owns the buffer.
+ */
+static inline void pci_dma_sync_single(struct pci_dev *hwdev,
+				       dma_addr_t dma_handle,
+				       size_t size, int direction)
+{
+	if (direction == PCI_DMA_NONE)
+                BUG();
+
+	frv_cache_wback_inv((unsigned long)bus_to_virt(dma_handle), 
+			    (unsigned long)bus_to_virt(dma_handle) + size);
+}
+
+/* Make physical memory consistent for a set of streaming
+ * mode DMA translations after a transfer.
+ *
+ * The same as pci_dma_sync_single but for a scatter-gather list,
+ * same rules and usage.
+ */
+static inline void pci_dma_sync_sg(struct pci_dev *hwdev,
+				   struct scatterlist *sg,
+				   int nelems, int direction)
+{
+	int i;
+
+	if (direction == PCI_DMA_NONE)
+                BUG();
+
+	for (i = 0; i < nelems; i++)
+		frv_cache_wback_inv(sg_dma_address(&sg[i]),
+				    sg_dma_address(&sg[i])+sg_dma_len(&sg[i]));
+}
+
+
+#endif
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/percpu.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/percpu.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/percpu.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/percpu.h	2004-11-05 14:13:04.127476855 +0000
@@ -0,0 +1,6 @@
+#ifndef __ASM_PERCPU_H
+#define __ASM_PERCPU_H
+
+#include <asm-generic/percpu.h>
+
+#endif	/* __ASM_PERCPU_H */
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/pgalloc.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/pgalloc.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/pgalloc.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/pgalloc.h	2004-11-05 14:59:30.000000000 +0000
@@ -0,0 +1,66 @@
+/* pgalloc.h: Page allocation routines for FRV
+ *
+ * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ * Derived from:
+ *	include/asm-m68knommu/pgalloc.h
+ *	include/asm-i386/pgalloc.h
+ */
+#ifndef _ASM_PGALLOC_H
+#define _ASM_PGALLOC_H
+
+#include <linux/config.h>
+#include <asm/setup.h>
+#include <asm/virtconvert.h>
+
+#ifdef CONFIG_MMU
+
+#define pmd_populate_kernel(mm, pmd, pte) __set_pmd(pmd, __pa(pte) | _PAGE_TABLE)
+#define pmd_populate(MM, PMD, PAGE)						\
+do {										\
+	__set_pmd((PMD), page_to_pfn(PAGE) << PAGE_SHIFT | _PAGE_TABLE);	\
+} while(0)
+
+/*
+ * Allocate and free page tables.
+ */
+
+extern void pgd_free(pgd_t *);
+
+extern pte_t *pte_alloc_one_kernel(struct mm_struct *, unsigned long);
+
+extern struct page *pte_alloc_one(struct mm_struct *, unsigned long);
+
+static inline void pte_free_kernel(pte_t *pte)
+{
+	free_page((unsigned long)pte);
+}
+
+static inline void pte_free(struct page *pte)
+{
+	__free_page(pte);
+}
+
+#define __pte_free_tlb(tlb,pte)		tlb_remove_page((tlb),(pte))
+
+/*
+ * allocating and freeing a pmd is trivial: the 1-entry pmd is
+ * inside the pgd, so has no extra memory associated with it.
+ * (In the PAE case we free the pmds as part of the pgd.)
+ */
+#define pmd_alloc_one(mm, addr)		({ BUG(); ((pmd_t *) 2); })
+#define pmd_free(x)			do { } while (0)
+#define __pmd_free_tlb(tlb,x)		do { } while (0)
+#define pgd_populate(mm, pmd, pte)	BUG()
+
+#include <asm-generic/nopml4-pgalloc.h>
+
+#endif /* CONFIG_MMU */
+
+#endif /* _ASM_PGALLOC_H */
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/pgtable.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/pgtable.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/pgtable.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/pgtable.h	2004-11-05 14:58:27.452086136 +0000
@@ -0,0 +1,491 @@
+/* pgtable.h: FR-V page table mangling
+ *
+ * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ * Derived from:
+ *	include/asm-m68knommu/pgtable.h
+ *	include/asm-i386/pgtable.h
+ */
+
+#ifndef _ASM_PGTABLE_H
+#define _ASM_PGTABLE_H
+
+#include <linux/config.h>
+#include <asm/mem-layout.h>
+#include <asm/setup.h>
+#include <asm/processor.h>
+
+#ifndef __ASSEMBLY__
+#include <linux/threads.h>
+#include <linux/slab.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#endif
+
+#ifndef __ASSEMBLY__
+#if defined(CONFIG_HIGHPTE)
+typedef unsigned long pte_addr_t;
+#else
+typedef pte_t *pte_addr_t;
+#endif
+#endif
+
+/*****************************************************************************/
+/*
+ * MMU-less operation case first
+ */
+#ifndef CONFIG_MMU
+
+#define pgd_present(pgd)	(1)		/* pages are always present on NO_MM */
+#define pgd_none(pgd)		(0)
+#define pgd_bad(pgd)		(0)
+#define pgd_clear(pgdp)
+#define kern_addr_valid(addr)	(1)
+#define	pmd_offset(a, b)	((void *) 0)
+
+#define PAGE_NONE		__pgprot(0)	/* these mean nothing to NO_MM */
+#define PAGE_SHARED		__pgprot(0)	/* these mean nothing to NO_MM */
+#define PAGE_COPY		__pgprot(0)	/* these mean nothing to NO_MM */
+#define PAGE_READONLY		__pgprot(0)	/* these mean nothing to NO_MM */
+#define PAGE_KERNEL		__pgprot(0)	/* these mean nothing to NO_MM */
+
+#define __swp_type(x)		(0)
+#define __swp_offset(x)		(0)
+#define __swp_entry(typ,off)	((swp_entry_t) { ((typ) | ((off) << 7)) })
+#define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
+#define __swp_entry_to_pte(x)	((pte_t) { (x).val })
+
+#ifndef __ASSEMBLY__
+static inline int pte_file(pte_t pte) { return 0; }
+#endif
+
+#define ZERO_PAGE(vaddr)	({ BUG(); NULL; })
+
+#define swapper_pg_dir		((pgd_t *) NULL)
+
+#define pgtable_cache_init()	do {} while(0)
+
+#else /* !CONFIG_MMU */
+/*****************************************************************************/
+/*
+ * then MMU operation
+ */
+
+/*
+ * ZERO_PAGE is a global shared page that is always zero: used
+ * for zero-mapped memory areas etc..
+ */
+#ifndef __ASSEMBLY__
+extern unsigned long empty_zero_page;
+#define ZERO_PAGE(vaddr)	virt_to_page(empty_zero_page)
+#endif
+
+/*
+ * we use 2-level page tables, folding the PMD (mid-level table) into the PGE (top-level entry)
+ * [see Documentation/fujitsu/frv/mmu-layout.txt]
+ *
+ * 4th-Level Page Directory:
+ *  - Size: 16KB
+ *  - 1 PML4Es per PML4
+ *  - Each PML4E holds 1 PGD and covers 4GB
+ *
+ * Page Directory:
+ *  - Size: 16KB
+ *  - 64 PGEs per PGD
+ *  - Each PGE holds 1 PMD and covers 64MB
+ *
+ * Page Mid-Level Directory
+ *  - 1 PME per PMD
+ *  - Each PME holds 64 STEs, all of which point to separate chunks of the same Page Table
+ *  - All STEs are instantiated at the same time
+ *  - Size: 256B
+ *
+ * Page Table
+ *  - Size: 16KB
+ *  - 4096 PTEs per PT
+ *  - Each Linux PT is subdivided into 64 FR451 PT's, each of which holds 64 entries
+ *
+ * Pages
+ *  - Size: 4KB
+ *
+ * total PTEs
+ *	= 1 PML4E * 64 PGEs * 1 PMEs * 4096 PTEs
+ *	= 1 PML4E * 64 PGEs * 64 STEs * 64 PTEs/FR451-PT
+ *	= 262144 (or 256 * 1024)
+ */
+#define PGDIR_SHIFT		26
+#define PGDIR_SIZE		(1UL << PGDIR_SHIFT)
+#define PGDIR_MASK		(~(PGDIR_SIZE - 1))
+#define PTRS_PER_PGD		64
+
+#define PMD_SHIFT		26
+#define PMD_SIZE		(1UL << PMD_SHIFT)
+#define PMD_MASK		(~(PMD_SIZE - 1))
+#define PTRS_PER_PMD		1
+#define PME_SIZE		256
+
+#define __frv_PT_SIZE		256
+
+#define PTRS_PER_PTE		4096
+
+#define USER_PGDS_IN_LAST_PML4	(TASK_SIZE / PGDIR_SIZE)
+#define FIRST_USER_PGD_NR	0
+
+#define USER_PGD_PTRS		(PAGE_OFFSET >> PGDIR_SHIFT)
+#define KERNEL_PGD_PTRS		(PTRS_PER_PGD - USER_PGD_PTRS)
+
+#define TWOLEVEL_PGDIR_SHIFT	26
+#define BOOT_USER_PGD_PTRS	(__PAGE_OFFSET >> TWOLEVEL_PGDIR_SHIFT)
+#define BOOT_KERNEL_PGD_PTRS	(PTRS_PER_PGD - BOOT_USER_PGD_PTRS)
+
+#ifndef __ASSEMBLY__
+
+extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
+
+#define pte_ERROR(e) \
+	printk("%s:%d: bad pte %08lx.\n", __FILE__, __LINE__, (e).pte)
+#define pmd_ERROR(e) \
+	printk("%s:%d: bad pmd %08lx.\n", __FILE__, __LINE__, pmd_val(e))
+#define pgd_ERROR(e) \
+	printk("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, pmd_val(pgd_val(e)))
+
+/*
+ * The "pgd_xxx()" functions here are trivial for a folded two-level
+ * setup: the pgd is never bad, and a pmd always exists (as it's folded
+ * into the pgd entry)
+ */
+static inline int pgd_none(pgd_t pgd)		{ return 0; }
+static inline int pgd_bad(pgd_t pgd)		{ return 0; }
+static inline int pgd_present(pgd_t pgd)	{ return 1; }
+#define pgd_clear(xp)				do { } while (0)
+
+/*
+ * Certain architectures need to do special things when PTEs
+ * within a page table are directly modified.  Thus, the following
+ * hook is made available.
+ */
+#define set_pte(pteptr, pteval)				\
+do {							\
+	*(pteptr) = (pteval);				\
+	asm volatile("dcf %M0" :: "U"(*pteptr));	\
+} while(0)
+
+#define set_pte_atomic(pteptr, pteval)		set_pte((pteptr), (pteval))
+
+/*
+ * (pmds are folded into pgds so this doesn't get actually called,
+ * but the define is needed for a generic inline function.)
+ */
+#define set_pgd(pgdptr, pgdval)			(*(pgdptr) = pgdval)
+
+extern void __set_pmd(pmd_t *pmdptr, unsigned long __pmd);
+
+#define set_pmd(pmdptr, pmdval)			\
+do {						\
+	__set_pmd((pmdptr), (pmdval).ste[0]);	\
+} while(0)
+
+#define pgd_page(pgd)				((unsigned long) __va(pgd_val(pgd) & PAGE_MASK))
+
+#define __pmd_index(address)			0
+
+static inline pmd_t *pmd_offset(pgd_t *dir, unsigned long address)
+{
+	return (pmd_t *) dir + __pmd_index(address);
+}
+
+#define pte_same(a, b)		((a).pte == (b).pte)
+#define pte_page(x)		(mem_map + ((unsigned long)(((x).pte >> PAGE_SHIFT))))
+#define pte_none(x)		(!(x).pte)
+#define pte_pfn(x)		((unsigned long)(((x).pte >> PAGE_SHIFT)))
+#define pfn_pte(pfn, prot)	__pte(((pfn) << PAGE_SHIFT) | pgprot_val(prot))
+#define pfn_pmd(pfn, prot)	__pmd(((pfn) << PAGE_SHIFT) | pgprot_val(prot))
+
+#define VMALLOC_VMADDR(x)	((unsigned long) (x))
+
+#endif /* !__ASSEMBLY__ */
+
+/*
+ * control flags in AMPR registers and TLB entries
+ */
+#define _PAGE_BIT_PRESENT	xAMPRx_V_BIT
+#define _PAGE_BIT_WP		DAMPRx_WP_BIT
+#define _PAGE_BIT_NOCACHE	xAMPRx_C_BIT
+#define _PAGE_BIT_SUPER		xAMPRx_S_BIT
+#define _PAGE_BIT_ACCESSED	xAMPRx_RESERVED8_BIT
+#define _PAGE_BIT_DIRTY		xAMPRx_M_BIT
+#define _PAGE_BIT_NOTGLOBAL	xAMPRx_NG_BIT
+
+#define _PAGE_PRESENT		xAMPRx_V
+#define _PAGE_WP		DAMPRx_WP
+#define _PAGE_NOCACHE		xAMPRx_C
+#define _PAGE_SUPER		xAMPRx_S
+#define _PAGE_ACCESSED		xAMPRx_RESERVED8	/* accessed if set */
+#define _PAGE_DIRTY		xAMPRx_M
+#define _PAGE_NOTGLOBAL		xAMPRx_NG
+
+#define _PAGE_RESERVED_MASK	(xAMPRx_RESERVED8 | xAMPRx_RESERVED13)
+
+#define _PAGE_FILE		0x002	/* set:pagecache unset:swap */
+#define _PAGE_PROTNONE		0x000	/* If not present */
+
+#define _PAGE_CHG_MASK		(PTE_MASK | _PAGE_ACCESSED | _PAGE_DIRTY)
+
+#define __PGPROT_BASE \
+	(_PAGE_PRESENT | xAMPRx_SS_16Kb | xAMPRx_D | _PAGE_NOTGLOBAL | _PAGE_ACCESSED)
+
+#define PAGE_NONE	__pgprot(_PAGE_PROTNONE | _PAGE_ACCESSED)
+#define PAGE_SHARED	__pgprot(__PGPROT_BASE)
+#define PAGE_COPY	__pgprot(__PGPROT_BASE | _PAGE_WP)
+#define PAGE_READONLY	__pgprot(__PGPROT_BASE | _PAGE_WP)
+
+#define __PAGE_KERNEL		(__PGPROT_BASE | _PAGE_SUPER | _PAGE_DIRTY)
+#define __PAGE_KERNEL_NOCACHE	(__PGPROT_BASE | _PAGE_SUPER | _PAGE_DIRTY | _PAGE_NOCACHE)
+#define __PAGE_KERNEL_RO	(__PGPROT_BASE | _PAGE_SUPER | _PAGE_DIRTY | _PAGE_WP)
+
+#define MAKE_GLOBAL(x) __pgprot((x) & ~_PAGE_NOTGLOBAL)
+
+#define PAGE_KERNEL		MAKE_GLOBAL(__PAGE_KERNEL)
+#define PAGE_KERNEL_RO		MAKE_GLOBAL(__PAGE_KERNEL_RO)
+#define PAGE_KERNEL_NOCACHE	MAKE_GLOBAL(__PAGE_KERNEL_NOCACHE)
+
+#define _PAGE_TABLE		(_PAGE_PRESENT | xAMPRx_SS_16Kb | xAMPRx_D | _PAGE_ACCESSED)
+
+#ifndef __ASSEMBLY__
+
+/*
+ * The FR451 can do execute protection by virtue of having separate TLB miss handlers for
+ * instruction access and for data access. However, we don't have enough reserved bits to say
+ * "execute only", so we don't bother. If you can read it, you can execute it and vice versa.
+ */
+#define __P000	PAGE_NONE
+#define __P001	PAGE_READONLY
+#define __P010	PAGE_COPY
+#define __P011	PAGE_COPY
+#define __P100	PAGE_READONLY
+#define __P101	PAGE_READONLY
+#define __P110	PAGE_COPY
+#define __P111	PAGE_COPY
+
+#define __S000	PAGE_NONE
+#define __S001	PAGE_READONLY
+#define __S010	PAGE_SHARED
+#define __S011	PAGE_SHARED
+#define __S100	PAGE_READONLY
+#define __S101	PAGE_READONLY
+#define __S110	PAGE_SHARED
+#define __S111	PAGE_SHARED
+
+/*
+ * Define this to warn about kernel memory accesses that are
+ * done without a 'verify_area(VERIFY_WRITE,..)'
+ */
+#undef TEST_VERIFY_AREA
+
+#define pte_present(x)	(pte_val(x) & _PAGE_PRESENT)
+#define pte_clear(xp)	do { set_pte(xp, __pte(0)); } while (0)
+
+#define pmd_none(x)	(!pmd_val(x))
+#define pmd_present(x)	(pmd_val(x) & _PAGE_PRESENT)
+#define	pmd_bad(x)	(pmd_val(x) & xAMPRx_SS)
+#define pmd_clear(xp)	do { __set_pmd(xp, 0); } while(0)
+
+#define pmd_page_kernel(pmd) \
+	((unsigned long) __va(pmd_val(pmd) & PAGE_MASK))
+
+#ifndef CONFIG_DISCONTIGMEM
+#define pmd_page(pmd)	(pfn_to_page(pmd_val(pmd) >> PAGE_SHIFT))
+#endif
+
+#define pages_to_mb(x) ((x) >> (20-PAGE_SHIFT))
+
+/*
+ * The following only work if pte_present() is true.
+ * Undefined behaviour if not..
+ */
+static inline int pte_read(pte_t pte)		{ return !((pte).pte & _PAGE_SUPER); }
+static inline int pte_exec(pte_t pte)		{ return !((pte).pte & _PAGE_SUPER); }
+static inline int pte_dirty(pte_t pte)		{ return (pte).pte & _PAGE_DIRTY; }
+static inline int pte_young(pte_t pte)		{ return (pte).pte & _PAGE_ACCESSED; }
+static inline int pte_write(pte_t pte)		{ return !((pte).pte & _PAGE_WP); }
+
+static inline pte_t pte_rdprotect(pte_t pte)	{ (pte).pte |= _PAGE_SUPER; return pte; }
+static inline pte_t pte_exprotect(pte_t pte)	{ (pte).pte |= _PAGE_SUPER; return pte; }
+static inline pte_t pte_mkclean(pte_t pte)	{ (pte).pte &= ~_PAGE_DIRTY; return pte; }
+static inline pte_t pte_mkold(pte_t pte)	{ (pte).pte &= ~_PAGE_ACCESSED; return pte; }
+static inline pte_t pte_wrprotect(pte_t pte)	{ (pte).pte |= _PAGE_WP; return pte; }
+static inline pte_t pte_mkread(pte_t pte)	{ (pte).pte &= ~_PAGE_SUPER; return pte; }
+static inline pte_t pte_mkexec(pte_t pte)	{ (pte).pte &= ~_PAGE_SUPER; return pte; }
+static inline pte_t pte_mkdirty(pte_t pte)	{ (pte).pte |= _PAGE_DIRTY; return pte; }
+static inline pte_t pte_mkyoung(pte_t pte)	{ (pte).pte |= _PAGE_ACCESSED; return pte; }
+static inline pte_t pte_mkwrite(pte_t pte)	{ (pte).pte &= ~_PAGE_WP; return pte; }
+
+static inline int ptep_test_and_clear_dirty(pte_t *ptep)
+{
+	int i = test_and_clear_bit(_PAGE_BIT_DIRTY, ptep);
+	asm volatile("dcf %M0" :: "U"(*ptep));
+	return i;
+}
+
+static inline int ptep_test_and_clear_young(pte_t *ptep)
+{
+	int i = test_and_clear_bit(_PAGE_BIT_ACCESSED, ptep);
+	asm volatile("dcf %M0" :: "U"(*ptep));
+	return i;
+}
+
+static inline pte_t ptep_get_and_clear(pte_t *ptep)
+{
+	unsigned long x = xchg(&ptep->pte, 0);
+	asm volatile("dcf %M0" :: "U"(*ptep));
+	return __pte(x);
+}
+
+static inline void ptep_set_wrprotect(pte_t *ptep)
+{
+	set_bit(_PAGE_BIT_WP, ptep);
+	asm volatile("dcf %M0" :: "U"(*ptep));
+}
+
+static inline void ptep_mkdirty(pte_t *ptep)
+{
+	set_bit(_PAGE_BIT_DIRTY, ptep);
+	asm volatile("dcf %M0" :: "U"(*ptep));
+}
+
+/*
+ * Conversion functions: convert a page and protection to a page entry,
+ * and a page entry and page directory to the page they refer to.
+ */
+
+#define mk_pte(page, pgprot)	pfn_pte(page_to_pfn(page), (pgprot))
+#define mk_pte_huge(entry)	((entry).pte_low |= _PAGE_PRESENT | _PAGE_PSE)
+
+/* This takes a physical page address that is used by the remapping functions */
+#define mk_pte_phys(physpage, pgprot)	pfn_pte((physpage) >> PAGE_SHIFT, pgprot)
+
+static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
+{
+	pte.pte &= _PAGE_CHG_MASK;
+	pte.pte |= pgprot_val(newprot);
+	return pte;
+}
+
+#define page_pte(page)	page_pte_prot(page, __pgprot(0))
+
+/* to find an entry in a page-table-directory. */
+#define pgd_index(address) ((address >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
+#define pgd_index_k(addr) pgd_index(addr)
+
+/* Find an entry in the third-level page table.. */
+#define __pte_index(address) ((address >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
+#define pte_offset(dir, address) ((pte_t *) pmd_page(*(dir)) + __pte_index(address))
+
+/*
+ * the pte page can be thought of an array like this: pte_t[PTRS_PER_PTE]
+ *
+ * this macro returns the index of the entry in the pte page which would
+ * control the given virtual address
+ */
+#define pte_index(address) \
+		(((address) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
+#define pte_offset_kernel(dir, address) \
+	((pte_t *) pmd_page_kernel(*(dir)) +  pte_index(address))
+
+#if defined(CONFIG_HIGHPTE)
+#define pte_offset_map(dir, address) \
+	((pte_t *)kmap_atomic(pmd_page(*(dir)),KM_PTE0) + pte_index(address))
+#define pte_offset_map_nested(dir, address) \
+	((pte_t *)kmap_atomic(pmd_page(*(dir)),KM_PTE1) + pte_index(address))
+#define pte_unmap(pte) kunmap_atomic(pte, KM_PTE0)
+#define pte_unmap_nested(pte) kunmap_atomic(pte, KM_PTE1)
+#else
+#define pte_offset_map(dir, address) \
+	((pte_t *)page_address(pmd_page(*(dir))) + pte_index(address))
+#define pte_offset_map_nested(dir, address) pte_offset_map(dir, address)
+#define pte_unmap(pte) do { } while (0)
+#define pte_unmap_nested(pte) do { } while (0)
+#endif
+
+/*
+ * Handle swap and file entries
+ * - the PTE is encoded in the following format:
+ *	bit 0:		Must be 0 (!_PAGE_PRESENT)
+ *	bit 1:		Type: 0 for swap, 1 for file (_PAGE_FILE)
+ *	bits 2-7:	Swap type
+ *	bits 8-31:	Swap offset
+ *	bits 2-31:	File pgoff
+ */
+#define __swp_type(x)			(((x).val >> 2) & 0x1f)
+#define __swp_offset(x)			((x).val >> 8)
+#define __swp_entry(type, offset)	((swp_entry_t) { ((type) << 2) | ((offset) << 8) })
+#define __pte_to_swp_entry(pte)		((swp_entry_t) { (pte).pte })
+#define __swp_entry_to_pte(x)		((pte_t) { (x).val })
+
+static inline int pte_file(pte_t pte)
+{
+	return pte.pte & _PAGE_FILE;
+}
+
+#define PTE_FILE_MAX_BITS	29
+
+#define pte_to_pgoff(PTE)	((PTE).pte >> 2)
+#define pgoff_to_pte(off)	__pte((off) << 2 | _PAGE_FILE)
+
+/* Needs to be defined here and not in linux/mm.h, as it is arch dependent */
+#define PageSkip(page)		(0)
+#define kern_addr_valid(addr)	(1)
+
+#define io_remap_page_range	remap_page_range
+
+#define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
+#define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_DIRTY
+#define __HAVE_ARCH_PTEP_GET_AND_CLEAR
+#define __HAVE_ARCH_PTEP_SET_WRPROTECT
+#define __HAVE_ARCH_PTEP_MKDIRTY
+#define __HAVE_ARCH_PTE_SAME
+#include <asm-generic/pgtable.h>
+#include <asm-generic/nopml4-pgtable.h>
+
+/*
+ * preload information about a newly instantiated PTE into the SCR0/SCR1 PGE cache
+ */
+static inline void update_mmu_cache(struct vm_area_struct *vma, unsigned long address, pte_t pte)
+{
+	unsigned long ampr;
+	pml4_t *pml4e = pml4_offset(current->mm, address);
+	pgd_t *pge = pml4_pgd_offset(pml4e, address);
+	pmd_t *pme = pmd_offset(pge, address);
+
+	ampr = pme->ste[0] & 0xffffff00;
+	ampr |= xAMPRx_L | xAMPRx_SS_16Kb | xAMPRx_S | xAMPRx_C | xAMPRx_V;
+
+	asm volatile("movgs %0,scr0\n"
+		     "movgs %0,scr1\n"
+		     "movgs %1,dampr4\n"
+		     "movgs %1,dampr5\n"
+		     :
+		     : "r"(address), "r"(ampr)
+		     );
+}
+
+#ifdef CONFIG_PROC_FS
+extern char *proc_pid_status_frv_cxnr(struct mm_struct *mm, char *buffer);
+#endif
+
+extern void __init pgtable_cache_init(void);
+
+#endif /* !__ASSEMBLY__ */
+#endif /* !CONFIG_MMU */
+
+#ifndef __ASSEMBLY__
+extern void __init paging_init(void);
+#endif /* !__ASSEMBLY__ */
+
+#endif /* _ASM_PGTABLE_H */
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/poll.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/poll.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/poll.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/poll.h	2004-11-05 14:13:04.140475757 +0000
@@ -0,0 +1,23 @@
+#ifndef _ASM_POLL_H
+#define _ASM_POLL_H
+
+#define POLLIN		  1
+#define POLLPRI		  2
+#define POLLOUT		  4
+#define POLLERR		  8
+#define POLLHUP		 16
+#define POLLNVAL	 32
+#define POLLRDNORM	 64
+#define POLLWRNORM	POLLOUT
+#define POLLRDBAND	128
+#define POLLWRBAND	256
+#define POLLMSG		0x0400
+
+struct pollfd {
+	int fd;
+	short events;
+	short revents;
+};
+
+#endif
+
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/posix_types.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/posix_types.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/posix_types.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/posix_types.h	2004-11-05 14:13:04.144475419 +0000
@@ -0,0 +1,66 @@
+#ifndef _ASM_POSIX_TYPES_H
+#define _ASM_POSIX_TYPES_H
+
+/*
+ * This file is generally used by user-level software, so you need to
+ * be a little careful about namespace pollution etc.  Also, we cannot
+ * assume GCC is being used.
+ */
+
+typedef unsigned long	__kernel_ino_t;
+typedef unsigned short	__kernel_mode_t;
+typedef unsigned short	__kernel_nlink_t;
+typedef long		__kernel_off_t;
+typedef int		__kernel_pid_t;
+typedef unsigned short	__kernel_ipc_pid_t;
+typedef unsigned short	__kernel_uid_t;
+typedef unsigned short	__kernel_gid_t;
+typedef unsigned int	__kernel_size_t;
+typedef int		__kernel_ssize_t;
+typedef int		__kernel_ptrdiff_t;
+typedef long		__kernel_time_t;
+typedef long		__kernel_suseconds_t;
+typedef long		__kernel_clock_t;
+typedef int		__kernel_timer_t;
+typedef int		__kernel_clockid_t;
+typedef int		__kernel_daddr_t;
+typedef char *		__kernel_caddr_t;
+typedef unsigned short	__kernel_uid16_t;
+typedef unsigned short	__kernel_gid16_t;
+typedef unsigned int	__kernel_uid32_t;
+typedef unsigned int	__kernel_gid32_t;
+
+typedef unsigned short	__kernel_old_uid_t;
+typedef unsigned short	__kernel_old_gid_t;
+typedef unsigned short	__kernel_old_dev_t;
+
+#ifdef __GNUC__
+typedef long long	__kernel_loff_t;
+#endif
+
+typedef struct {
+#if defined(__KERNEL__) || defined(__USE_ALL)
+	int	val[2];
+#else /* !defined(__KERNEL__) && !defined(__USE_ALL) */
+	int	__val[2];
+#endif /* !defined(__KERNEL__) && !defined(__USE_ALL) */
+} __kernel_fsid_t;
+
+#if defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2)
+
+#undef	__FD_SET
+#define	__FD_SET(d, set)	((set)->fds_bits[__FDELT(d)] |= __FDMASK(d))
+
+#undef	__FD_CLR
+#define	__FD_CLR(d, set)	((set)->fds_bits[__FDELT(d)] &= ~__FDMASK(d))
+
+#undef	__FD_ISSET
+#define	__FD_ISSET(d, set)	(!!((set)->fds_bits[__FDELT(d)] & __FDMASK(d)))
+
+#undef	__FD_ZERO
+#define __FD_ZERO(fdsetp) (memset (fdsetp, 0, sizeof(*(fd_set *)fdsetp)))
+
+#endif /* defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2) */
+
+#endif
+
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/processor.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/processor.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/processor.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/processor.h	2004-11-05 14:13:04.151474828 +0000
@@ -0,0 +1,153 @@
+/* processor.h: FRV processor definitions
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
+#ifndef _ASM_PROCESSOR_H
+#define _ASM_PROCESSOR_H
+
+#include <linux/config.h>
+#include <asm/mem-layout.h>
+
+#ifndef __ASSEMBLY__
+/*
+ * Default implementation of macro that returns current
+ * instruction pointer ("program counter").
+ */
+#define current_text_addr() ({ __label__ _l; _l: &&_l;})
+
+#include <linux/linkage.h>
+#include <asm/sections.h>
+#include <asm/segment.h>
+#include <asm/fpu.h>
+#include <asm/registers.h>
+#include <asm/ptrace.h>
+#include <asm/current.h>
+#include <asm/cache.h>
+
+/* Forward declaration, a strange C thing */
+struct task_struct;
+
+/*
+ *  CPU type and hardware bug flags. Kept separately for each CPU.
+ */
+struct cpuinfo_frv {
+#ifdef CONFIG_MMU
+	unsigned long	*pgd_quick;
+	unsigned long	*pte_quick;
+	unsigned long	pgtable_cache_sz;
+#endif
+} __cacheline_aligned;
+
+extern struct cpuinfo_frv __nongprelbss boot_cpu_data;
+
+#define cpu_data		(&boot_cpu_data)
+#define current_cpu_data	boot_cpu_data
+
+/*
+ * Bus types
+ */
+#define EISA_bus 0
+#define MCA_bus 0
+
+struct thread_struct {
+	struct pt_regs		*frame;		/* [GR28] exception frame ptr for this thread */
+	struct task_struct	*curr;		/* [GR29] current pointer for this thread */
+	unsigned long		sp;		/* [GR1 ] kernel stack pointer */
+	unsigned long		fp;		/* [GR2 ] kernel frame pointer */
+	unsigned long		lr;		/* link register */
+	unsigned long		pc;		/* program counter */
+	unsigned long		gr[12];		/* [GR16-GR27] */
+	unsigned long		sched_lr;	/* LR from schedule() */
+
+	union {
+		struct pt_regs		*frame0;	/* top (user) stack frame */
+		struct user_context	*user;		/* userspace context */
+	};
+} __attribute__((aligned(8)));
+
+extern struct pt_regs *__kernel_frame0_ptr;
+extern struct task_struct *__kernel_current_task;
+
+#endif
+
+#ifndef __ASSEMBLY__
+#define INIT_THREAD_FRAME0 \
+	((struct pt_regs *) \
+	(sizeof(init_stack) + (unsigned long) init_stack - sizeof(struct user_context)))
+
+#define INIT_THREAD {				\
+	NULL,					\
+	(struct task_struct *) init_stack,	\
+	0, 0, 0, 0,				\
+	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },	\
+	0,					\
+	{ INIT_THREAD_FRAME0 },			\
+}
+
+/*
+ * do necessary setup to start up a newly executed thread.
+ * - need to discard the frame stacked by init() invoking the execve syscall
+ */
+#define start_thread(_regs, _pc, _usp)			\
+do {							\
+	set_fs(USER_DS); /* reads from user space */	\
+	__frame = __kernel_frame0_ptr;			\
+	__frame->pc	= (_pc);			\
+	__frame->psr	&= ~PSR_S;			\
+	__frame->sp	= (_usp);			\
+} while(0)
+
+extern void prepare_to_copy(struct task_struct *tsk);
+
+/* Free all resources held by a thread. */
+static inline void release_thread(struct task_struct *dead_task)
+{
+}
+
+extern asmlinkage int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags);
+extern asmlinkage void save_user_regs(struct user_context *target);
+extern asmlinkage void restore_user_regs(const struct user_context *target);
+
+#define copy_segments(tsk, mm)		do { } while (0)
+#define release_segments(mm)		do { } while (0)
+#define forget_segments()		do { } while (0)
+
+/*
+ * Free current thread data structures etc..
+ */
+static inline void exit_thread(void)
+{
+}
+
+/*
+ * Return saved PC of a blocked thread.
+ */
+extern unsigned long thread_saved_pc(struct task_struct *tsk);
+
+unsigned long get_wchan(struct task_struct *p);
+
+#define	KSTK_EIP(tsk)	((tsk)->thread.frame0->pc)
+#define	KSTK_ESP(tsk)	((tsk)->thread.frame0->sp)
+
+/* Allocation and freeing of basic task resources. */
+extern struct task_struct *alloc_task_struct(void);
+extern void free_task_struct(struct task_struct *p);
+
+#define cpu_relax()    do { } while (0)
+
+/* data cache prefetch */
+#define ARCH_HAS_PREFETCH
+static inline void prefetch(const void *x)
+{
+	asm volatile("dcpl %0,gr0,#0" : : "r"(x));
+}
+
+#endif /* __ASSEMBLY__ */
+#endif /* _ASM_PROCESSOR_H */
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/ptrace.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/ptrace.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/ptrace.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/ptrace.h	2004-11-05 14:13:04.154474574 +0000
@@ -0,0 +1,86 @@
+/* ptrace.h: ptrace() relevant definitions
+ *
+ * Copyright (C) 2003 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#ifndef _ASM_PTRACE_H
+#define _ASM_PTRACE_H
+
+#include <asm/registers.h>
+
+#define in_syscall(regs) (((regs)->tbr & TBR_TT) == TBR_TT_TRAP0)
+
+
+#define PT_PSR		0
+#define	PT_ISR		1
+#define PT_CCR		2
+#define PT_CCCR		3
+#define PT_LR		4
+#define PT_LCR		5
+#define PT_PC		6
+
+#define PT__STATUS	7	/* exception status */
+#define PT_SYSCALLNO	8	/* syscall number or -1 */
+#define PT_ORIG_GR8	9	/* saved GR8 for signal handling */
+#define PT_GNER0	10
+#define PT_GNER1	11
+#define PT_IACC0H	12
+#define PT_IACC0L	13
+
+#define PT_GR(j)	( 14 + (j))	/* GRj for 0<=j<=63 */
+#define PT_FR(j)	( 78 + (j))	/* FRj for 0<=j<=63 */
+#define PT_FNER(j)	(142 + (j))	/* FNERj for 0<=j<=1 */
+#define PT_MSR(j)	(144 + (j))	/* MSRj for 0<=j<=2 */
+#define PT_ACC(j)	(146 + (j))	/* ACCj for 0<=j<=7 */
+#define PT_ACCG(jklm)	(154 + (jklm))	/* ACCGjklm for 0<=jklm<=1 (reads four regs per slot) */
+#define PT_FSR(j)	(156 + (j))	/* FSRj for 0<=j<=0 */
+#define PT__GPEND	78
+#define PT__END		157
+
+#define PT_TBR		PT_GR(0)
+#define PT_SP		PT_GR(1)
+#define PT_FP		PT_GR(2)
+#define PT_PREV_FRAME	PT_GR(28)	/* previous exception frame pointer (old gr28 value) */
+#define PT_CURR_TASK	PT_GR(29)	/* current task */
+
+
+/* Arbitrarily choose the same ptrace numbers as used by the Sparc code. */
+#define PTRACE_GETREGS		12
+#define PTRACE_SETREGS		13
+#define PTRACE_GETFPREGS	14
+#define PTRACE_SETFPREGS	15
+#define PTRACE_GETFDPIC		31	/* get the ELF fdpic loadmap address */
+
+#define PTRACE_GETFDPIC_EXEC	0	/* [addr] request the executable loadmap */
+#define PTRACE_GETFDPIC_INTERP	1	/* [addr] request the interpreter loadmap */
+
+#ifndef __ASSEMBLY__
+
+/*
+ * dedicate GR28; to keeping the a pointer to the current exception frame
+ */
+register struct pt_regs *__frame asm("gr28");
+register struct pt_regs *__debug_frame asm("gr31");
+
+#ifndef container_of
+#define container_of(ptr, type, member) ({			\
+        const typeof( ((type *)0)->member ) *__mptr = (ptr);	\
+        (type *)( (char *)__mptr - offsetof(type,member) );})
+#endif
+
+#define __debug_regs container_of(__debug_frame, struct pt_debug_regs, normal_regs)
+
+#define user_mode(regs)			(!((regs)->psr & PSR_S))
+#define instruction_pointer(regs)	((regs)->pc)
+
+extern unsigned long user_stack(const struct pt_regs *);
+extern void show_regs(struct pt_regs *);
+#define profile_pc(regs) ((regs)->pc)
+
+#endif /* !__ASSEMBLY__ */
+#endif /* _ASM_PTRACE_H */
