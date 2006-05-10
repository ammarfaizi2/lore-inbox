Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964801AbWEJEER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbWEJEER (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 00:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964800AbWEJEEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 00:04:16 -0400
Received: from ozlabs.org ([203.10.76.45]:44424 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S964799AbWEJEEP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 00:04:15 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17505.26159.807484.477212@cargo.ozlabs.ibm.com>
Date: Wed, 10 May 2006 14:03:59 +1000
From: Paul Mackerras <paulus@samba.org>
To: linux-kernel@vger.kernel.org
CC: linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [RFC/PATCH] Make powerpc64 use __thread for per-cpu variables
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With this patch, 64-bit powerpc uses __thread for per-cpu variables.

The motivation for doing this is that getting the address of a per-cpu
variable currently requires two loads (one to get our per-cpu offset
and one to get the address of the variable in the .data.percpu
section) plus an add.  With __thread we can get the address of our
copy of a per-cpu variable with just an add (r13 plus a constant).

This means that r13 now has to hold the per-cpu base address + 0x7000
(the 0x7000 is to allow us to address 60k of per-cpu data with a
16-bit signed offset, and is dictated by the toolchain).  In
particular that means that the r13 can't hold the pointer to the
paca.  Instead we can get the paca pointer from the SPRG3 register.
We use r13 for the paca pointer for the early exception entry code,
and load the thread pointer into r13 before calling C code.

With this there is an incentive to move things that are currently
stored in the paca into per-cpu variables, and eventually to get rid
of the paca altogether.  I'll address that in future patches.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index ed5b26a..95a7480 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -58,12 +58,13 @@ override LD	+= -m elf$(SZ)ppc
 override CC	+= -m$(SZ)
 endif
 
-LDFLAGS_vmlinux	:= -Bstatic
+LDFLAGS_vmlinux	:= -Bstatic --no-tls-optimize
 
 # The -Iarch/$(ARCH)/include is temporary while we are merging
 CPPFLAGS-$(CONFIG_PPC32) := -Iarch/$(ARCH) -Iarch/$(ARCH)/include
 AFLAGS-$(CONFIG_PPC32)	:= -Iarch/$(ARCH)
-CFLAGS-$(CONFIG_PPC64)	:= -mminimal-toc -mtraceback=none  -mcall-aixdesc
+CFLAGS-$(CONFIG_PPC64)	:= -mminimal-toc -mtraceback=none -mcall-aixdesc \
+			   -ftls-model=local-exec -mtls-size=16
 CFLAGS-$(CONFIG_PPC32)	:= -Iarch/$(ARCH) -ffixed-r2 -mmultiple
 CPPFLAGS	+= $(CPPFLAGS-y)
 AFLAGS		+= $(AFLAGS-y)
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 8f85c5e..1cd54a6 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -112,6 +112,7 @@ #ifdef CONFIG_PPC64
 	DEFINE(PACAPROCSTART, offsetof(struct paca_struct, cpu_start));
 	DEFINE(PACAKSAVE, offsetof(struct paca_struct, kstack));
 	DEFINE(PACACURRENT, offsetof(struct paca_struct, __current));
+	DEFINE(PACATHREADPTR, offsetof(struct paca_struct, thread_ptr));
 	DEFINE(PACASAVEDMSR, offsetof(struct paca_struct, saved_msr));
 	DEFINE(PACASTABREAL, offsetof(struct paca_struct, stab_real));
 	DEFINE(PACASTABVIRT, offsetof(struct paca_struct, stab_addr));
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 19ad5c6..455443e 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -92,14 +92,15 @@ system_call_common:
 	ld	r11,exception_marker@toc(r2)
 	std	r11,-16(r9)		/* "regshere" marker */
 #ifdef CONFIG_PPC_ISERIES
+	lbz	r10,PACAPROCENABLED(r13)
+	std	r10,SOFTE(r1)
 	/* Hack for handling interrupts when soft-enabling on iSeries */
 	cmpdi	cr1,r0,0x5555		/* syscall 0x5555 */
 	andi.	r10,r12,MSR_PR		/* from kernel */
 	crand	4*cr0+eq,4*cr1+eq,4*cr0+eq
 	beq	hardware_interrupt_entry
-	lbz	r10,PACAPROCENABLED(r13)
-	std	r10,SOFTE(r1)
 #endif
+	ld	r13,PACATHREADPTR(r13)
 	mfmsr	r11
 	ori	r11,r11,MSR_EE
 	mtmsrd	r11,1
@@ -170,6 +171,7 @@ syscall_error_cont:
 	andi.	r6,r8,MSR_PR
 	ld	r4,_LINK(r1)
 	beq-	1f
+	mfspr	r13,SPRN_SPRG3
 	ACCOUNT_CPU_USER_EXIT(r11, r12)
 	ld	r13,GPR13(r1)	/* only restore r13 if returning to usermode */
 1:	ld	r2,GPR2(r1)
@@ -361,7 +363,8 @@ #ifdef CONFIG_SMP
 #endif /* CONFIG_SMP */
 
 	addi	r6,r4,-THREAD	/* Convert THREAD to 'current' */
-	std	r6,PACACURRENT(r13)	/* Set new 'current' */
+	mfspr	r10,SPRN_SPRG3
+	std	r6,PACACURRENT(r10)	/* Set new 'current' */
 
 	ld	r8,KSP(r4)	/* new stack pointer */
 BEGIN_FTR_SECTION
@@ -390,7 +393,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_SLB)
 	addi	r7,r7,THREAD_SIZE-SWITCH_FRAME_SIZE
 
 	mr	r1,r8		/* start using new stack pointer */
-	std	r7,PACAKSAVE(r13)
+	std	r7,PACAKSAVE(r10)
 
 	ld	r6,_CCR(r1)
 	mtcrf	0xFF,r6
@@ -457,22 +460,23 @@ restore:
 #ifdef CONFIG_PPC_ISERIES
 	ld	r5,SOFTE(r1)
 	cmpdi	0,r5,0
+	mfspr	r11,SPRN_SPRG3
 	beq	4f
 	/* Check for pending interrupts (iSeries) */
-	ld	r3,PACALPPACAPTR(r13)
+	ld	r3,PACALPPACAPTR(r11)
 	ld	r3,LPPACAANYINT(r3)
 	cmpdi	r3,0
 	beq+	4f			/* skip do_IRQ if no interrupts */
 
 	li	r3,0
-	stb	r3,PACAPROCENABLED(r13)	/* ensure we are soft-disabled */
+	stb	r3,PACAPROCENABLED(r11)	/* ensure we are soft-disabled */
 	ori	r10,r10,MSR_EE
 	mtmsrd	r10			/* hard-enable again */
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	.do_IRQ
 	b	.ret_from_except_lite		/* loop back and handle more */
 
-4:	stb	r5,PACAPROCENABLED(r13)
+4:	stb	r5,PACAPROCENABLED(r11)
 #endif
 
 	ld	r3,_MSR(r1)
@@ -486,6 +490,7 @@ #endif
 	 * userspace
 	 */
 	beq	1f
+	mfspr	r13,SPRN_SPRG3
 	ACCOUNT_CPU_USER_EXIT(r3, r4)
 	REST_GPR(13, r1)
 1:
@@ -541,8 +546,9 @@ #endif
 	/* here we are preempting the current task */
 1:
 #ifdef CONFIG_PPC_ISERIES
+	mfspr	r11,SPRN_SPRG3
 	li	r0,1
-	stb	r0,PACAPROCENABLED(r13)
+	stb	r0,PACAPROCENABLED(r11)
 #endif
 	ori	r10,r10,MSR_EE
 	mtmsrd	r10,1		/* reenable interrupts */
@@ -641,8 +647,9 @@ _GLOBAL(enter_rtas)
 	 * so they are saved in the PACA which allows us to restore
 	 * our original state after RTAS returns.
          */
-	std	r1,PACAR1(r13)
-        std	r6,PACASAVEDMSR(r13)
+	mfspr	r5,SPRN_SPRG3
+	std	r1,PACAR1(r5)
+	std	r6,PACASAVEDMSR(r5)
 
 	/* Setup our real return addr */	
 	LOAD_REG_ADDR(r4,.rtas_return_loc)
@@ -698,6 +705,7 @@ _STATIC(rtas_restore_regs)
 	REST_10GPRS(22, r1)		/* ditto */
 
 	mfspr	r13,SPRN_SPRG3
+	ld	r13,PACATHREADPTR(r13)
 
 	ld	r4,_CCR(r1)
 	mtcr	r4
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index b7d1404..80d95b4 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -298,6 +298,7 @@ #define EXCEPTION_PROLOG_COMMON(n, area)
 	std	r10,_CTR(r1);						   \
 	mfspr	r11,SPRN_XER;		/* save XER in stackframe	*/ \
 	std	r11,_XER(r1);						   \
+	SAVE_INT_ENABLE(r10);		/* save soft irq disable state	*/ \
 	li	r9,(n)+1;						   \
 	std	r9,_TRAP(r1);		/* set trap number		*/ \
 	li	r10,0;							   \
@@ -338,27 +339,27 @@ label##_iSeries:							\
 	b	label##_common;						\
 
 #ifdef DO_SOFT_DISABLE
+#define SAVE_INT_ENABLE(rn)			\
+	lbz	rn,PACAPROCENABLED(r13);	\
+	std	rn,SOFTE(r1)
+
 #define DISABLE_INTS				\
-	lbz	r10,PACAPROCENABLED(r13);	\
 	li	r11,0;				\
-	std	r10,SOFTE(r1);			\
 	mfmsr	r10;				\
 	stb	r11,PACAPROCENABLED(r13);	\
 	ori	r10,r10,MSR_EE;			\
 	mtmsrd	r10,1
 
 #define ENABLE_INTS				\
-	lbz	r10,PACAPROCENABLED(r13);	\
 	mfmsr	r11;				\
-	std	r10,SOFTE(r1);			\
 	ori	r11,r11,MSR_EE;			\
 	mtmsrd	r11,1
 
 #else	/* hard enable/disable interrupts */
+#define SAVE_INT_ENABLE(rn)
 #define DISABLE_INTS
 
 #define ENABLE_INTS				\
-	ld	r12,_MSR(r1);			\
 	mfmsr	r11;				\
 	rlwimi	r11,r12,0,MSR_EE;		\
 	mtmsrd	r11,1
@@ -371,6 +372,7 @@ #define STD_EXCEPTION_COMMON(trap, label
 label##_common:						\
 	EXCEPTION_PROLOG_COMMON(trap, PACA_EXGEN);	\
 	DISABLE_INTS;					\
+	ld	r13,PACATHREADPTR(r13);		\
 	bl	.save_nvgprs;				\
 	addi	r3,r1,STACK_FRAME_OVERHEAD;		\
 	bl	hdlr;					\
@@ -387,6 +389,7 @@ label##_common:						\
 	EXCEPTION_PROLOG_COMMON(trap, PACA_EXGEN);	\
 	FINISH_NAP;					\
 	DISABLE_INTS;					\
+	ld	r13,PACATHREADPTR(r13);		\
 	bl	.save_nvgprs;				\
 	addi	r3,r1,STACK_FRAME_OVERHEAD;		\
 	bl	hdlr;					\
@@ -399,6 +402,7 @@ label##_common:						\
 	EXCEPTION_PROLOG_COMMON(trap, PACA_EXGEN);	\
 	FINISH_NAP;					\
 	DISABLE_INTS;					\
+	ld	r13,PACATHREADPTR(r13);		\
 	bl	.ppc64_runlatch_on;			\
 	addi	r3,r1,STACK_FRAME_OVERHEAD;		\
 	bl	hdlr;					\
@@ -810,6 +814,7 @@ machine_check_common:
 	EXCEPTION_PROLOG_COMMON(0x200, PACA_EXMC)
 	FINISH_NAP
 	DISABLE_INTS
+	ld	r13,PACATHREADPTR(r13)
 	bl	.save_nvgprs
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	.machine_check_exception
@@ -864,6 +869,7 @@ bad_stack:
 	li	r12,0
 	std	r12,0(r11)
 	ld	r2,PACATOC(r13)
+	ld	r13,PACATHREADPTR(r13)
 1:	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	.kernel_bad_stack
 	b	1b
@@ -886,6 +892,7 @@ fast_exception_return:
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
 	andi.	r3,r12,MSR_PR
 	beq	2f
+	mfspr	r13,SPRN_SPRG3
 	ACCOUNT_CPU_USER_EXIT(r3, r4)
 2:
 #endif
@@ -913,6 +920,8 @@ #endif
 	b	.	/* prevent speculative execution */
 
 unrecov_fer:
+	mfspr	r13,SPRN_SPRG3
+	ld	r13,PACATHREADPTR(r13)
 	bl	.save_nvgprs
 1:	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	.unrecoverable_exception
@@ -933,16 +942,20 @@ data_access_common:
 	EXCEPTION_PROLOG_COMMON(0x300, PACA_EXGEN)
 	ld	r3,PACA_EXGEN+EX_DAR(r13)
 	lwz	r4,PACA_EXGEN+EX_DSISR(r13)
+	DISABLE_INTS
 	li	r5,0x300
+	ld	r13,PACATHREADPTR(r13)
 	b	.do_hash_page	 	/* Try to handle as hpte fault */
 
 	.align	7
 	.globl instruction_access_common
 instruction_access_common:
 	EXCEPTION_PROLOG_COMMON(0x400, PACA_EXGEN)
+	DISABLE_INTS
 	ld	r3,_NIP(r1)
 	andis.	r4,r12,0x5820
 	li	r5,0x400
+	ld	r13,PACATHREADPTR(r13)
 	b	.do_hash_page		/* Try to handle as hpte fault */
 
 /*
@@ -958,7 +971,7 @@ slb_miss_user_common:
 	stw	r9,PACA_EXGEN+EX_CCR(r13)
 	std	r10,PACA_EXGEN+EX_LR(r13)
 	std	r11,PACA_EXGEN+EX_SRR0(r13)
-	bl	.slb_allocate_user
+	bl	..slb_allocate_user
 
 	ld	r10,PACA_EXGEN+EX_LR(r13)
 	ld	r3,PACA_EXGEN+EX_R3(r13)
@@ -996,11 +1009,14 @@ slb_miss_fault:
 	li	r5,0
 	std	r4,_DAR(r1)
 	std	r5,_DSISR(r1)
+	ld	r13,PACATHREADPTR(r13)
+	ENABLE_INTS
 	b	.handle_page_fault
 
 unrecov_user_slb:
 	EXCEPTION_PROLOG_COMMON(0x4200, PACA_EXGEN)
 	DISABLE_INTS
+	ld	r13,PACATHREADPTR(r13)
 	bl	.save_nvgprs
 1:	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	.unrecoverable_exception
@@ -1023,7 +1039,7 @@ _GLOBAL(slb_miss_realmode)
 	stw	r9,PACA_EXSLB+EX_CCR(r13)	/* save CR in exc. frame */
 	std	r10,PACA_EXSLB+EX_LR(r13)	/* save LR */
 
-	bl	.slb_allocate_realmode
+	bl	..slb_allocate_realmode
 
 	/* All done -- return from exception. */
 
@@ -1061,6 +1077,7 @@ #endif /* CONFIG_PPC_ISERIES */
 unrecov_slb:
 	EXCEPTION_PROLOG_COMMON(0x4100, PACA_EXSLB)
 	DISABLE_INTS
+	ld	r13,PACATHREADPTR(r13)
 	bl	.save_nvgprs
 1:	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	.unrecoverable_exception
@@ -1074,6 +1091,7 @@ hardware_interrupt_common:
 	FINISH_NAP
 hardware_interrupt_entry:
 	DISABLE_INTS
+	ld	r13,PACATHREADPTR(r13)
 	bl	.ppc64_runlatch_on
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	.do_IRQ
@@ -1100,9 +1118,10 @@ alignment_common:
 	lwz	r4,PACA_EXGEN+EX_DSISR(r13)
 	std	r3,_DAR(r1)
 	std	r4,_DSISR(r1)
+	ld	r13,PACATHREADPTR(r13)
+	ENABLE_INTS
 	bl	.save_nvgprs
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	ENABLE_INTS
 	bl	.alignment_exception
 	b	.ret_from_except
 
@@ -1110,9 +1129,10 @@ alignment_common:
 	.globl program_check_common
 program_check_common:
 	EXCEPTION_PROLOG_COMMON(0x700, PACA_EXGEN)
+	ld	r13,PACATHREADPTR(r13)
+	ENABLE_INTS
 	bl	.save_nvgprs
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	ENABLE_INTS
 	bl	.program_check_exception
 	b	.ret_from_except
 
@@ -1121,9 +1141,10 @@ program_check_common:
 fp_unavailable_common:
 	EXCEPTION_PROLOG_COMMON(0x800, PACA_EXGEN)
 	bne	.load_up_fpu		/* if from user, just load it up */
+	ld	r13,PACATHREADPTR(r13)
+	ENABLE_INTS
 	bl	.save_nvgprs
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	ENABLE_INTS
 	bl	.kernel_fp_unavailable_exception
 	BUG_OPCODE
 
@@ -1136,9 +1157,10 @@ BEGIN_FTR_SECTION
 	bne	.load_up_altivec	/* if from user, just load it up */
 END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 #endif
+	ld	r13,PACATHREADPTR(r13)
+	ENABLE_INTS
 	bl	.save_nvgprs
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	ENABLE_INTS
 	bl	.altivec_unavailable_exception
 	b	.ret_from_except
 
@@ -1242,13 +1264,6 @@ END_FTR_SECTION_IFCLR(CPU_FTR_SLB)
 	rlwimi	r4,r0,32-13,30,30	/* becomes _PAGE_USER access bit */
 	ori	r4,r4,1			/* add _PAGE_PRESENT */
 	rlwimi	r4,r5,22+2,31-2,31-2	/* Set _PAGE_EXEC if trap is 0x400 */
-
-	/*
-	 * On iSeries, we soft-disable interrupts here, then
-	 * hard-enable interrupts so that the hash_page code can spin on
-	 * the hash_table_lock without problems on a shared processor.
-	 */
-	DISABLE_INTS
 
 	/*
 	 * r3 contains the faulting address
@@ -1258,6 +1273,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_SLB)
 	 * at return r3 = 0 for success
 	 */
 	bl	.hash_page		/* build HPTE if possible */
+11:					/* re-enter here from do_ste_alloc */
 	cmpdi	r3,0			/* see if hash_page succeeded */
 
 #ifdef DO_SOFT_DISABLE
@@ -1280,18 +1296,18 @@ #ifdef DO_SOFT_DISABLE
 	 */
 	ld	r3,SOFTE(r1)
 	bl	.local_irq_restore
-	b	11f
 #else
 	beq	fast_exception_return   /* Return from exception on success */
 	ble-	12f			/* Failure return from hash_page */
 
-	/* fall through */
+	ld	r12,_MSR(r1)		/* Reenable interrupts if they */
+	ENABLE_INTS			/* were enabled when trap occurred */
 #endif
+	/* fall through */
 
 /* Here we have a page fault that hash_page can't handle. */
 _GLOBAL(handle_page_fault)
-	ENABLE_INTS
-11:	ld	r4,_DAR(r1)
+	ld	r4,_DAR(r1)
 	ld	r5,_DSISR(r1)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	.do_page_fault
@@ -1316,9 +1332,7 @@ _GLOBAL(handle_page_fault)
 	/* here we have a segment miss */
 _GLOBAL(do_ste_alloc)
 	bl	.ste_allocate		/* try to insert stab entry */
-	cmpdi	r3,0
-	beq+	fast_exception_return
-	b	.handle_page_fault
+	b	11b
 
 /*
  * r13 points to the PACA, r9 contains the saved CR,
@@ -1796,6 +1810,9 @@ _GLOBAL(__secondary_start)
 	/* Clear backchain so we get nice backtraces */
 	li	r7,0
 	mtlr	r7
+
+	/* load per-cpu data area pointer */
+	ld	r13,PACATHREADPTR(r13)
 
 	/* enable MMU and jump to start_secondary */
 	LOAD_REG_ADDR(r3, .start_secondary_prolog)
@@ -1808,9 +1825,11 @@ #endif
 	rfid
 	b	.	/* prevent speculative execution */
 
-/* 
+/*
  * Running with relocation on at this point.  All we want to do is
  * zero the stack back-chain pointer before going into C code.
+ * We can't do this in __secondary_start because the stack isn't
+ * necessarily in the RMA, so it might not be accessible in real mode.
  */
 _GLOBAL(start_secondary_prolog)
 	li	r3,0
diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index 2778cce..f1899b0 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -27,6 +27,7 @@ #include <asm/ppc_asm.h>
 #include <asm/asm-offsets.h>
 #include <asm/cputable.h>
 #include <asm/thread_info.h>
+#include <asm/reg.h>
 
 	.text
 
@@ -820,6 +821,7 @@ #ifdef CONFIG_KEXEC
  * join other cpus in kexec_wait(phys_id)
  */
 _GLOBAL(kexec_smp_wait)
+	mfspr	r13,SPRN_SPRG3
 	lhz	r3,PACAHWCPUID(r13)
 	li	r4,-1
 	sth	r4,PACAHWCPUID(r13)	/* let others know we left */
@@ -885,6 +887,7 @@ _GLOBAL(kexec_sequence)
 	mr	r28,r6			/* control, unused */
 	mr	r27,r7			/* clear_all() fn desc */
 	mr	r26,r8			/* spare */
+	mfspr	r13,SPRN_SPRG3
 	lhz	r25,PACAHWCPUID(r13)	/* get our phys cpu from paca */
 
 	/* disable interrupts, we are overwriting kernel data next */
diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index ba34001..8140cbe 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -357,9 +357,7 @@ int apply_relocate_add(Elf64_Shdr *sechd
 				       me->name, value);
 				return -ENOEXEC;
 			}
-			*((uint16_t *) location)
-				= (*((uint16_t *) location) & ~0xffff)
-				| (value & 0xffff);
+			*(u16 *)location = value;
 			break;
 
 		case R_PPC64_TOC16_DS:
@@ -398,6 +396,32 @@ int apply_relocate_add(Elf64_Shdr *sechd
 			*(uint32_t *)location 
 				= (*(uint32_t *)location & ~0x03fffffc)
 				| (value & 0x03fffffc);
+			break;
+
+		case R_PPC64_TPREL16:
+			if (value > 0xffff) {
+				printk(KERN_ERR "%s: TPREL16 relocation "
+				       "too large (%d)\n", value - 0x8000);
+				return -ENOEXEC;
+			}
+			*(u16 *)location = value - 0x8000;
+			break;
+
+		case R_PPC64_TPREL16_LO:
+			*(u16 *)location = PPC_LO(value - 0x8000);
+			break;
+
+		case R_PPC64_TPREL16_LO_DS:
+			*(u16 *)location = ((*(u16 *)location) & ~0xfffc)
+				| ((value - 0x8000) & 0xfffc);
+			break;
+
+		case R_PPC64_TPREL16_HA:
+			*(u16 *)location = PPC_HA(value - 0x8000);
+			break;
+
+		case R_PPC64_TPREL64:
+			*(u64 *)location = value - 0x8000;
 			break;
 
 		default:
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 4467c49..7fe7c7d 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -605,6 +605,7 @@ void __init setup_per_cpu_areas(void)
 {
 	int i;
 	unsigned long size;
+	unsigned long initsize;
 	char *ptr;
 
 	/* Copy section for each CPU (we discard the original) */
@@ -613,14 +614,19 @@ #ifdef CONFIG_MODULES
 	if (size < PERCPU_ENOUGH_ROOM)
 		size = PERCPU_ENOUGH_ROOM;
 #endif
+	initsize = __end_tdata - __start_tdata;
 
 	for_each_possible_cpu(i) {
 		ptr = alloc_bootmem_node(NODE_DATA(cpu_to_node(i)), size);
 		if (!ptr)
 			panic("Cannot allocate cpu data for CPU %d\n", i);
 
-		paca[i].data_offset = ptr - __per_cpu_start;
-		memcpy(ptr, __per_cpu_start, __per_cpu_end - __per_cpu_start);
+		paca[i].thread_ptr = (unsigned long)ptr + 0x7000;
+		memcpy(ptr, __start_tdata, initsize);
+		if (initsize < size)
+			memset(ptr + initsize, 0, size - initsize);
 	}
+	/* Set our percpu area pointer register */
+	asm volatile("mr 13,%0" : : "r" (paca[boot_cpuid].thread_ptr));
 }
 #endif
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index fe79c25..c83ff6a 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -141,11 +141,12 @@ #ifdef CONFIG_PPC32
 #else
 	. = ALIGN(128);
 #endif
-	.data.percpu : {
-		__per_cpu_start = .;
-		*(.data.percpu)
-		__per_cpu_end = .;
-	}
+	__start_tdata = .;
+	.tdata : { *(.tdata .tdata.* .gnu.linkonce.td.*) }
+	__end_tdata = .;
+	.tbss  : { *(.tbss .tbss.* .gnu.linkonce.tb.*) *(.tcommon) }
+	__per_cpu_start = 0x1000;
+	__per_cpu_end = 0x1000 + ALIGN(SIZEOF(.tdata), 128) + SIZEOF(.tbss);
 
 	. = ALIGN(8);
 	.machine.desc : {
diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
index abfaabf..92f11cd 100644
--- a/arch/powerpc/mm/slb_low.S
+++ b/arch/powerpc/mm/slb_low.S
@@ -23,14 +23,30 @@ #include <asm/page.h>
 #include <asm/mmu.h>
 #include <asm/pgtable.h>
 
-/* void slb_allocate_realmode(unsigned long ea);
+/*
+ * void slb_allocate_realmode(unsigned long ea);
  *
+ * This version is callable from C; the version with two dots at the
+ * start of the name assumes r13 points to the PACA and thus isn't.
+ */
+_GLOBAL(slb_allocate_realmode)
+	mflr	r0
+	std	r0,16(r1)
+	mr	r8,r13
+	mfspr	r13,SPRN_SPRG3
+	bl	..slb_allocate_realmode
+	mr	r13,r8
+	mtlr	r0
+	blr
+
+/*
  * Create an SLB entry for the given EA (user or kernel).
  * 	r3 = faulting address, r13 = PACA
  *	r9, r10, r11 are clobbered by this function
  * No other registers are examined or changed.
  */
-_GLOBAL(slb_allocate_realmode)
+	.globl	..slb_allocate_realmode
+..slb_allocate_realmode:
 	/* r3 = faulting address */
 
 	srdi	r9,r3,60		/* get region */
@@ -121,7 +137,8 @@ #ifdef __DISABLED__
  * It is called with translation enabled in order to be able to walk the
  * page tables. This is not currently used.
  */
-_GLOBAL(slb_allocate_user)
+	.globl	..slb_allocate_user
+..slb_allocate_user:
 	/* r3 = faulting address */
 	srdi	r10,r3,28		/* get esid */
 
diff --git a/arch/powerpc/platforms/iseries/misc.S b/arch/powerpc/platforms/iseries/misc.S
index 7641fc7..d8a3ab5 100644
--- a/arch/powerpc/platforms/iseries/misc.S
+++ b/arch/powerpc/platforms/iseries/misc.S
@@ -21,30 +21,33 @@ #include <asm/ppc_asm.h>
 
 /* unsigned long local_save_flags(void) */
 _GLOBAL(local_get_flags)
-	lbz	r3,PACAPROCENABLED(r13)
+	mfspr	r3,SPRG3
+	lbz	r3,PACAPROCENABLED(r3)
 	blr
 
 /* unsigned long local_irq_disable(void) */
 _GLOBAL(local_irq_disable)
-	lbz	r3,PACAPROCENABLED(r13)
+	mfspr	r5,SPRG3
+	lbz	r3,PACAPROCENABLED(r5)
 	li	r4,0
-	stb	r4,PACAPROCENABLED(r13)
+	stb	r4,PACAPROCENABLED(r5)
 	blr			/* Done */
 
 /* void local_irq_restore(unsigned long flags) */
 _GLOBAL(local_irq_restore)
-	lbz	r5,PACAPROCENABLED(r13)
+	mfspr	r6,SPRG3
+	lbz	r5,PACAPROCENABLED(r6)
 	 /* Check if things are setup the way we want _already_. */
 	cmpw	0,r3,r5
 	beqlr
 	/* are we enabling interrupts? */
 	cmpdi	0,r3,0
-	stb	r3,PACAPROCENABLED(r13)
+	stb	r3,PACAPROCENABLED(r6)
 	beqlr
 	/* Check pending interrupts */
 	/*   A decrementer, IPI or PMC interrupt may have occurred
 	 *   while we were in the hypervisor (which enables) */
-	ld	r4,PACALPPACAPTR(r13)
+	ld	r4,PACALPPACAPTR(r6)
 	ld	r4,LPPACAANYINT(r4)
 	cmpdi	r4,0
 	beqlr
diff --git a/include/asm-powerpc/paca.h b/include/asm-powerpc/paca.h
index 706325f..afbfb5c 100644
--- a/include/asm-powerpc/paca.h
+++ b/include/asm-powerpc/paca.h
@@ -21,8 +21,14 @@ #include	<asm/types.h>
 #include	<asm/lppaca.h>
 #include	<asm/mmu.h>
 
-register struct paca_struct *local_paca asm("r13");
-#define get_paca()	local_paca
+static inline struct paca_struct *get_paca(void)
+{
+	struct paca_struct *p;
+
+	asm volatile("mfsprg3 %0" : "=r" (p));
+	return p;
+}
+
 #define get_lppaca()	(get_paca()->lppaca_ptr)
 
 struct task_struct;
@@ -66,7 +72,7 @@ #endif /* CONFIG_PPC_ISERIES */
 	u64 stab_real;			/* Absolute address of segment table */
 	u64 stab_addr;			/* Virtual address of segment table */
 	void *emergency_sp;		/* pointer to emergency stack */
-	u64 data_offset;		/* per cpu data offset */
+	u64 thread_ptr;			/* per cpu data pointer + 0x7000 */
 	s16 hw_cpu_id;			/* Physical processor number */
 	u8 cpu_start;			/* At startup, processor spins until */
 					/* this becomes non-zero. */
diff --git a/include/asm-powerpc/percpu.h b/include/asm-powerpc/percpu.h
index 5d603ff..dcd9aa0 100644
--- a/include/asm-powerpc/percpu.h
+++ b/include/asm-powerpc/percpu.h
@@ -2,40 +2,76 @@ #ifndef _ASM_POWERPC_PERCPU_H_
 #define _ASM_POWERPC_PERCPU_H_
 #ifdef __powerpc64__
 #include <linux/compiler.h>
-
-/*
- * Same as asm-generic/percpu.h, except that we store the per cpu offset
- * in the paca. Based on the x86-64 implementation.
- */
-
-#ifdef CONFIG_SMP
-
 #include <asm/paca.h>
 
-#define __per_cpu_offset(cpu) (paca[cpu].data_offset)
-#define __my_cpu_offset() get_paca()->data_offset
+#ifdef CONFIG_SMP
 
 /* Separate out the type, so (int[3], foo) works. */
 #define DEFINE_PER_CPU(type, name) \
-    __attribute__((__section__(".data.percpu"))) __typeof__(type) per_cpu__##name
+	__thread __typeof__(type) per_cpu__##name __attribute__((__used__))
+
+#define __get_cpu_var(var)	per_cpu__##var
+#define __raw_get_cpu_var(var)	per_cpu__##var
 
-/* var is in discarded region: offset to particular copy we want */
-#define per_cpu(var, cpu) (*RELOC_HIDE(&per_cpu__##var, __per_cpu_offset(cpu)))
-#define __get_cpu_var(var) (*RELOC_HIDE(&per_cpu__##var, __my_cpu_offset()))
-#define __raw_get_cpu_var(var) (*RELOC_HIDE(&per_cpu__##var, __my_cpu_offset()))
+#define per_cpu(var, cpu)					\
+	(*(__typeof__(&per_cpu__##var))({			\
+		void *__ptr;					\
+		asm("addi %0,%1,per_cpu__"#var"@tprel"		\
+		    : "=b" (__ptr)				\
+		    : "b" (paca[(cpu)].thread_ptr));		\
+		__ptr;						\
+	}))
 
 /* A macro to avoid #include hell... */
-#define percpu_modcopy(pcpudst, src, size, zero_size)		\
-do {								\
-	unsigned int __i;					\
-	BUG_ON(zero_size != 0);					\
-	for_each_possible_cpu(__i)				\
-		memcpy((pcpudst)+__per_cpu_offset(__i),		\
-		       (src), (size));				\
+#define percpu_modcopy(pcpudst, src, size, total_size)			    \
+do {									    \
+	unsigned int __i;						    \
+	extern char __per_cpu_start[];					    \
+	unsigned long offset = (unsigned long)(pcpudst) - 0x8000;	    \
+	for_each_possible_cpu(__i) {					    \
+		memcpy((void *)(offset + paca[__i].thread_ptr),		    \
+		       (src), (size));					    \
+		if ((size) < (total_size))				    \
+			memset((void *)(offset + (size) + paca[__i].thread_ptr), \
+			       0, (total_size) - (size));		    \
+	}								    \
 } while (0)
 
 extern void setup_per_cpu_areas(void);
+
+#define DECLARE_PER_CPU(type, name) \
+	extern __thread __typeof__(type) per_cpu__##name
+
+#ifndef __GENKSYMS__
+#define __EXPORT_PER_CPU_SYMBOL(sym, sec)				\
+	extern __thread typeof(sym) sym;				\
+	__CRC_SYMBOL(sym, sec)						\
+	static const char __kstrtab_##sym[]				\
+	__attribute__((used, section("__ksymtab_strings"))) = #sym;	\
+	asm(".section	__ksymtab"sec",\"aw\",@progbits\n"		\
+	    "	.align 3\n"						\
+	    "	.type	__ksymtab_"#sym", @object\n"			\
+	    "	.size	__ksymtab_"#sym", 16\n"				\
+	    "__ksymtab_"#sym":\n"					\
+	    "	.quad	0x8000+"#sym"@tprel\n"				\
+	    "	.quad	__kstrtab_"#sym)
+
+#define EXPORT_PER_CPU_SYMBOL(var) \
+	__EXPORT_PER_CPU_SYMBOL(per_cpu__##var, "")
+#define EXPORT_PER_CPU_SYMBOL_GPL(var) \
+	__EXPORT_PER_CPU_SYMBOL(per_cpu__##var, "_gpl")
+
+#else
+/* for genksyms's sake... */
+#define __thread
+#define EXPORT_PER_CPU_SYMBOL(var) EXPORT_SYMBOL(per_cpu__##var)
+#define EXPORT_PER_CPU_SYMBOL_GPL(var) EXPORT_SYMBOL_GPL(per_cpu__##var)
+#endif
 
+/* Actual kernel address of .tdata section contents */
+extern char __start_tdata[];
+extern char __end_tdata[];
+
 #else /* ! SMP */
 
 #define DEFINE_PER_CPU(type, name) \
@@ -45,12 +81,12 @@ #define per_cpu(var, cpu)			(*((void)(cp
 #define __get_cpu_var(var)			per_cpu__##var
 #define __raw_get_cpu_var(var)			per_cpu__##var
 
-#endif	/* SMP */
-
 #define DECLARE_PER_CPU(type, name) extern __typeof__(type) per_cpu__##name
 
 #define EXPORT_PER_CPU_SYMBOL(var) EXPORT_SYMBOL(per_cpu__##var)
 #define EXPORT_PER_CPU_SYMBOL_GPL(var) EXPORT_SYMBOL_GPL(per_cpu__##var)
+
+#endif	/* SMP */
 
 #else
 #include <asm-generic/percpu.h>
diff --git a/kernel/printk.c b/kernel/printk.c
