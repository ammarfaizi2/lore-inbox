Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264966AbUFRC7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264966AbUFRC7Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 22:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264969AbUFRC7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 22:59:24 -0400
Received: from ozlabs.org ([203.10.76.45]:30355 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264966AbUFRC5J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 22:57:09 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16594.23038.178485.917524@cargo.ozlabs.ibm.com>
Date: Fri, 18 Jun 2004 12:57:02 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, anton@samba.org
Subject: [PATCH] Optimize PPC64 exception entry
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This rather large patch rewrites the PPC64 exception entry/exit
routines to make them smaller and faster.  In particular we no longer
save all of the registers for the common exceptions - system calls,
hardware interrupts and decrementer (timer) interrupts - only the
volatile registers.  The other registers are saved and restored (if
used) by the C functions we call.  This involved changing the
registers we use in early exception processing from r20-r23 to r9-r12,
which ended up changing quite a lot of code in head.S.  Overall this
gives us about a 20% reduction in null syscall time.

Some system calls need all the registers (e.g. fork/clone/vfork and
[rt_]sigsuspend).  For these the syscall dispatch code calls a stub that
saves the nonvolatile registers before calling the real handler.

This also implements the force_successful_syscall_return() thing for
ppc64.

This patch depends on the patch to implement preemption that I sent
yesterday.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN preempt/arch/ppc64/kernel/asm-offsets.c test25/arch/ppc64/kernel/asm-offsets.c
--- preempt/arch/ppc64/kernel/asm-offsets.c	2004-06-17 15:51:34.000000000 +1000
+++ test25/arch/ppc64/kernel/asm-offsets.c	2004-06-17 15:46:06.000000000 +1000
@@ -49,6 +49,7 @@
 	DEFINE(THREAD_SIZE, THREAD_SIZE);
 	DEFINE(TI_FLAGS, offsetof(struct thread_info, flags));
 	DEFINE(TI_PREEMPT, offsetof(struct thread_info, preempt_count));
+	DEFINE(TI_SC_NOERR, offsetof(struct thread_info, syscall_noerror));
 
 	/* task_struct->thread */
 	DEFINE(THREAD, offsetof(struct task_struct, thread));
@@ -100,7 +101,10 @@
 	DEFINE(PACALPPACA, offsetof(struct paca_struct, xLpPaca));
         DEFINE(LPPACA, offsetof(struct paca_struct, xLpPaca));
         DEFINE(PACAREGSAV, offsetof(struct paca_struct, xRegSav));
-        DEFINE(PACAEXC, offsetof(struct paca_struct, exception_stack));
+        DEFINE(PACA_EXGEN, offsetof(struct paca_struct, exgen));
+        DEFINE(PACA_EXMC, offsetof(struct paca_struct, exmc));
+        DEFINE(PACA_EXSLB, offsetof(struct paca_struct, exslb));
+        DEFINE(PACA_EXDSI, offsetof(struct paca_struct, exdsi));
         DEFINE(PACAGUARD, offsetof(struct paca_struct, guard));
         DEFINE(LPPACASRR0, offsetof(struct ItLpPaca, xSavedSrr0));
         DEFINE(LPPACASRR1, offsetof(struct ItLpPaca, xSavedSrr1));
@@ -137,6 +141,10 @@
 	DEFINE(GPR7, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[7]));
 	DEFINE(GPR8, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[8]));
 	DEFINE(GPR9, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[9]));
+	DEFINE(GPR10, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[10]));
+	DEFINE(GPR11, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[11]));
+	DEFINE(GPR12, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[12]));
+	DEFINE(GPR13, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[13]));
 	DEFINE(GPR20, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[20]));
 	DEFINE(GPR21, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[21]));
 	DEFINE(GPR22, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[22]));
@@ -155,7 +163,7 @@
 	DEFINE(_DSISR, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, dsisr));
 	DEFINE(ORIG_GPR3, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, orig_gpr3));
 	DEFINE(RESULT, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, result));
-	DEFINE(TRAP, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, trap));
+	DEFINE(_TRAP, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, trap));
 	DEFINE(SOFTE, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, softe));
 
 	/* These _only_ to be used with {PROM,RTAS}_FRAME_SIZE!!! */
diff -urN preempt/arch/ppc64/kernel/entry.S test25/arch/ppc64/kernel/entry.S
--- preempt/arch/ppc64/kernel/entry.S	2004-06-17 15:51:34.000000000 +1000
+++ test25/arch/ppc64/kernel/entry.S	2004-06-17 15:48:02.000000000 +1000
@@ -35,15 +35,9 @@
 #define DO_SOFT_DISABLE
 #endif
 
-#undef SHOW_SYSCALLS
-#undef SHOW_SYSCALLS_TASK
-
-#ifdef SHOW_SYSCALLS_TASK
-	.data
-show_syscalls_task:
-	.long	-1
-#endif
-
+/*
+ * System calls.
+ */
 	.section	".toc","aw"
 .SYS_CALL_TABLE:
 	.tc .sys_call_table[TC],.sys_call_table
@@ -51,107 +45,175 @@
 .SYS_CALL_TABLE32:
 	.tc .sys_call_table32[TC],.sys_call_table32
 
+/* This value is used to mark exception frames on the stack. */
+exception_marker:
+	.tc	ID_72656773_68657265[TC],0x7265677368657265
+
 	.section	".text"
-	.align 3
+	.align 7
 
-/*
- * Handle a system call.
- */
-_GLOBAL(DoSyscall)
+#undef SHOW_SYSCALLS
+
+	.globl SystemCall_common
+SystemCall_common:
+	andi.	r10,r12,MSR_PR
+	mr	r10,r1
+	addi	r1,r1,-INT_FRAME_SIZE
+	beq-	1f
+	ld	r1,PACAKSAVE(r13)
+1:	std	r10,0(r1)
+	std	r11,_NIP(r1)
+	std	r12,_MSR(r1)
+	std	r0,GPR0(r1)
+	std	r10,GPR1(r1)
+	std	r2,GPR2(r1)
+	std	r3,GPR3(r1)
+	std	r4,GPR4(r1)
+	std	r5,GPR5(r1)
+	std	r6,GPR6(r1)
+	std	r7,GPR7(r1)
+	std	r8,GPR8(r1)
+	li	r11,0
+	std	r11,GPR9(r1)
+	std	r11,GPR10(r1)
+	std	r11,GPR11(r1)
+	std	r11,GPR12(r1)
+	std	r9,GPR13(r1)
+	crclr	so
+	mfcr	r9
+	mflr	r10
+	li	r11,0xc01
+	std	r9,_CCR(r1)
+	std	r10,_LINK(r1)
+	std	r11,_TRAP(r1)
+	mfxer	r9
+	mfctr	r10
+	std	r9,_XER(r1)
+	std	r10,_CTR(r1)
 	std	r3,ORIG_GPR3(r1)
-	ld	r11,_CCR(r1)	/* Clear SO bit in CR */
-	lis	r10,0x1000
-	andc	r11,r11,r10
-	std	r11,_CCR(r1)
+	ld	r2,PACATOC(r13)
+	addi	r9,r1,STACK_FRAME_OVERHEAD
+	ld	r11,exception_marker@toc(r2)
+	std	r11,-16(r9)		/* "regshere" marker */
+#ifdef CONFIG_PPC_ISERIES
+	/* Hack for handling interrupts when soft-enabling on iSeries */
+	cmpdi	cr1,r0,0x5555		/* syscall 0x5555 */
+	andi.	r10,r12,MSR_PR		/* from kernel */
+	crand	4*cr0+eq,4*cr1+eq,4*cr0+eq
+	beq	HardwareInterrupt_entry
+	lbz	r10,PACAPROCENABLED(r13)
+	std	r10,SOFTE(r1)
+#endif
+	mfmsr	r11
+	ori	r11,r11,MSR_EE
+	mtmsrd	r11,1
+
 #ifdef SHOW_SYSCALLS
-#ifdef SHOW_SYSCALLS_TASK
-	LOADBASE(r31,show_syscalls_task)
-	ld	r31,show_syscalls_task@l(r31)
-	ld	r10,PACACURRENT(r13)
-	cmp	0,r10,r31
-	bne	1f
+	bl	.do_show_syscall
+	REST_GPR(0,r1)
+	REST_4GPRS(3,r1)
+	REST_2GPRS(7,r1)
+	addi	r9,r1,STACK_FRAME_OVERHEAD
 #endif
-	LOADADDR(r3,7f)
-	ld	r4,GPR0(r1)
-	ld	r5,GPR3(r1)
-	ld	r6,GPR4(r1)
-	ld	r7,GPR5(r1)
-	ld	r8,GPR6(r1)
-	ld	r9,GPR7(r1)
-	bl	.printk
-	LOADADDR(r3,77f)
-	ld	r4,GPR8(r1)
-	ld	r5,GPR9(r1)
-	ld	r6, PACACURRENT(r13)
-	bl	.printk
-	ld	r0,GPR0(r1)
-	ld	r3,GPR3(r1)
-	ld	r4,GPR4(r1)
-	ld	r5,GPR5(r1)
-	ld	r6,GPR6(r1)
-	ld	r7,GPR7(r1)
-	ld	r8,GPR8(r1)
-1:
-#endif /* SHOW_SYSCALLS */
-	clrrdi	r10,r1,THREAD_SHIFT
-	ld	r10,TI_FLAGS(r10)
+	clrrdi	r11,r1,THREAD_SHIFT
+	li	r12,0
+	ld	r10,TI_FLAGS(r11)
+	stb	r12,TI_SC_NOERR(r11)
 	andi.	r11,r10,_TIF_SYSCALL_T_OR_A
-	bne-	50f
+	bne-	syscall_dotrace
+syscall_dotrace_cont:
 	cmpli	0,r0,NR_syscalls
-	bge-	66f
+	bge-	syscall_enosys
+
+system_call:			/* label this so stack traces look sane */
 /*
  * Need to vector to 32 Bit or default sys_call_table here,
  * based on caller's run-mode / personality.
  */
-	andi.	r11,r10,_TIF_32BIT
+	ld	r11,.SYS_CALL_TABLE@toc(2)
+	andi.	r10,r10,_TIF_32BIT
 	beq-	15f
-	ld	r10,.SYS_CALL_TABLE32@toc(2)
-/*
- * We now zero extend all six arguments (r3 - r8), the compatibility
- * layer assumes this.
- */
+	ld	r11,.SYS_CALL_TABLE32@toc(2)
 	clrldi	r3,r3,32
 	clrldi	r4,r4,32
 	clrldi	r5,r5,32
 	clrldi	r6,r6,32
 	clrldi	r7,r7,32
 	clrldi	r8,r8,32
-	b	17f
 15:
-	ld	r10,.SYS_CALL_TABLE@toc(2)
-17:	slwi	r0,r0,3
-	ldx	r10,r10,r0	/* Fetch system call handler [ptr] */
+	slwi	r0,r0,3
+	ldx	r10,r11,r0	/* Fetch system call handler [ptr] */
 	mtlr	r10
-	addi	r9,r1,STACK_FRAME_OVERHEAD
 	blrl			/* Call handler */
-_GLOBAL(ret_from_syscall_1)
-	std	r3,RESULT(r1)	/* Save result */
+
+syscall_exit:
 #ifdef SHOW_SYSCALLS
-#ifdef SHOW_SYSCALLS_TASK
-	ld	r10, PACACURRENT(13)
-	cmp	0,r10,r31
-	bne	91f
-#endif
-	mr	r4,r3
-	LOADADDR(r3,79f)
-	bl	.printk
-	ld	r3,RESULT(r1)
-91:
+	std	r3,GPR3(r1)
+	bl	.do_show_syscall_exit
+	ld	r3,GPR3(r1)
 #endif
+	std	r3,RESULT(r1)
+	ld	r5,_CCR(r1)
 	li	r10,-_LAST_ERRNO
-	cmpld	0,r3,r10
-	blt	30f
+	cmpld	r3,r10
+	clrrdi	r12,r1,THREAD_SHIFT
+	bge-	syscall_error
+syscall_error_cont:
+
+	/* check for syscall tracing or audit */
+	ld	r9,TI_FLAGS(r12)
+	andi.	r0,r9,_TIF_SYSCALL_T_OR_A
+	bne-	syscall_exit_trace
+syscall_exit_trace_cont:
+
+	/* disable interrupts so current_thread_info()->flags can't change,
+	   and so that we don't get interrupted after loading SRR0/1. */
+	ld	r8,_MSR(r1)
+	andi.	r10,r8,MSR_RI
+	beq-	unrecov_restore
+	mfmsr	r10
+	rldicl	r10,r10,48,1
+	rotldi	r10,r10,16
+	mtmsrd	r10,1
+	ld	r9,TI_FLAGS(r12)
+	andi.	r0,r9,(_TIF_SYSCALL_T_OR_A|_TIF_SIGPENDING|_TIF_NEED_RESCHED)
+	bne-	syscall_exit_work
+	ld	r7,_NIP(r1)
+	stdcx.	r0,0,r1			/* to clear the reservation */
+	andi.	r6,r8,MSR_PR
+	ld	r4,_LINK(r1)
+	beq	1f			/* only restore r13 if */
+	ld	r13,GPR13(r1)		/* returning to usermode */
+1:	ld	r2,GPR2(r1)
+	ld	r1,GPR1(r1)
+	li	r12,MSR_RI
+	andc	r10,r10,r12
+	mtmsrd	r10,1			/* clear MSR.RI */
+	mtlr	r4
+	mtcr	r5
+	mtspr	SRR0,r7
+	mtspr	SRR1,r8
+	rfid
+
+syscall_enosys:
+	li	r3,-ENOSYS
+	std	r3,RESULT(r1)
+	clrrdi	r12,r1,THREAD_SHIFT
+	ld	r5,_CCR(r1)
+
+syscall_error:
+	lbz	r11,TI_SC_NOERR(r12)
+	cmpi	0,r11,0
+	bne-	syscall_error_cont
 	neg	r3,r3
-22:	ld	r10,_CCR(r1)	/* Set SO bit in CR */
-	oris	r10,r10,0x1000
-	std	r10,_CCR(r1)
-30:	std	r3,GPR3(r1)	/* Update return value */
-	b	.ret_from_except
-66:	li	r3,ENOSYS
-	b	22b
+	oris	r5,r5,0x1000	/* Set SO bit in CR */
+	std	r5,_CCR(r1)
+	b	syscall_error_cont
         
 /* Traced system call support */
-50:	addi	r3,r1,STACK_FRAME_OVERHEAD
+syscall_dotrace:
+	bl	.save_nvgprs
+	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	.do_syscall_trace_enter
 	ld	r0,GPR0(r1)	/* Restore original registers */
 	ld	r3,GPR3(r1)
@@ -160,65 +222,82 @@
 	ld	r6,GPR6(r1)
 	ld	r7,GPR7(r1)
 	ld	r8,GPR8(r1)
-	/* XXX check this - Anton */
-	ld	r9,GPR9(r1)
-	cmpli	0,r0,NR_syscalls
-	bge-	66f
-/*
- * Need to vector to 32 Bit or default sys_call_table here,
- * based on caller's run-mode / personality.
- */
+	addi	r9,r1,STACK_FRAME_OVERHEAD
 	clrrdi	r10,r1,THREAD_SHIFT
 	ld	r10,TI_FLAGS(r10)
-	andi.	r11,r10,_TIF_32BIT
-	beq-	55f
-	ld	r10,.SYS_CALL_TABLE32@toc(2)
+	b	syscall_dotrace_cont
+
+syscall_exit_trace:
+	std	r3,GPR3(r1)
+	bl	.save_nvgprs
+	bl	.do_syscall_trace_leave
+	REST_NVGPRS(r1)
+	ld	r3,GPR3(r1)
+	ld	r5,_CCR(r1)
+	clrrdi	r12,r1,THREAD_SHIFT
+	b	syscall_exit_trace_cont
+
+/* Stuff to do on exit from a system call. */
+syscall_exit_work:
+	std	r3,GPR3(r1)
+	std	r5,_CCR(r1)
+	b	.ret_from_except_lite
+
+/* Save non-volatile GPRs, if not already saved. */
+_GLOBAL(save_nvgprs)
+	ld	r11,_TRAP(r1)
+	andi.	r0,r11,1
+	beqlr-
+	SAVE_NVGPRS(r1)
+	clrrdi	r0,r11,1
+	std	r0,_TRAP(r1)
+	blr
+
 /*
- * We now zero extend all six arguments (r3 - r8), the compatibility
- * layer assumes this.
+ * The sigsuspend and rt_sigsuspend system calls can call do_signal
+ * and thus put the process into the stopped state where we might
+ * want to examine its user state with ptrace.  Therefore we need
+ * to save all the nonvolatile registers (r14 - r31) before calling
+ * the C code.  Similarly, fork, vfork and clone need the full
+ * register state on the stack so that it can be copied to the child.
  */
-	clrldi	r3,r3,32
-	clrldi	r4,r4,32
-	clrldi	r5,r5,32
-	clrldi	r6,r6,32
-	clrldi	r7,r7,32
-	clrldi	r8,r8,32
-	b	57f
-55:
-	ld	r10,.SYS_CALL_TABLE@toc(2)
-57:
-	slwi	r0,r0,3
-	ldx	r10,r10,r0	/* Fetch system call handler [ptr] */
-	mtlr	r10
-	addi	r9,r1,STACK_FRAME_OVERHEAD
-	blrl			/* Call handler */
-_GLOBAL(ret_from_syscall_2)
-	std	r3,RESULT(r1)	/* Save result */	
-	li	r10,-_LAST_ERRNO
-	cmpld	0,r3,r10
-	blt	60f
-	neg	r3,r3
-57:	ld	r10,_CCR(r1)	/* Set SO bit in CR */
-	oris	r10,r10,0x1000
-	std	r10,_CCR(r1)
-60:	std	r3,GPR3(r1)	/* Update return value */
-	bl	.do_syscall_trace_leave
-	b	.ret_from_except
-66:	li	r3,ENOSYS
-	b	57b
-#ifdef SHOW_SYSCALLS
-7:	.string	"syscall %d(%x, %x, %x, %x, %x, "
-77:	.string	"%x, %x), current=%p\n"
-79:	.string	" -> %x\n"
-	.align	2,0
-#endif
+_GLOBAL(ppc32_sigsuspend)
+	bl	.save_nvgprs
+	bl	.sys32_sigsuspend
+	b	syscall_exit
+
+_GLOBAL(ppc64_rt_sigsuspend)
+	bl	.save_nvgprs
+	bl	.sys_rt_sigsuspend
+	b	syscall_exit
+
+_GLOBAL(ppc32_rt_sigsuspend)
+	bl	.save_nvgprs
+	bl	.sys32_rt_sigsuspend
+	b	syscall_exit
+
+_GLOBAL(ppc_fork)
+	bl	.save_nvgprs
+	bl	.sys_fork
+	b	syscall_exit
+
+_GLOBAL(ppc_vfork)
+	bl	.save_nvgprs
+	bl	.sys_vfork
+	b	syscall_exit
+
+_GLOBAL(ppc_clone)
+	bl	.save_nvgprs
+	bl	.sys_clone
+	b	syscall_exit
 
-	
 _GLOBAL(ppc32_swapcontext)
+	bl	.save_nvgprs
 	bl	.sys32_swapcontext
 	b	80f
 	
 _GLOBAL(ppc64_swapcontext)
+	bl	.save_nvgprs
 	bl	.sys_swapcontext
 	b	80f
 
@@ -233,17 +312,20 @@
 _GLOBAL(ppc64_rt_sigreturn)
 	bl	.sys_rt_sigreturn
 
-80:	clrrdi	r4,r1,THREAD_SHIFT
+80:	cmpdi	0,r3,0
+	blt	syscall_exit
+	clrrdi	r4,r1,THREAD_SHIFT
 	ld	r4,TI_FLAGS(r4)
 	andi.	r4,r4,_TIF_SYSCALL_T_OR_A
-	bne-	81f
-	cmpi	0,r3,0
-	bge	.ret_from_except
-	b	.ret_from_syscall_1
-81:	cmpi	0,r3,0
-	blt	.ret_from_syscall_2
+	beq+	81f
 	bl	.do_syscall_trace_leave
-	b	.ret_from_except
+81:	b	.ret_from_except
+
+_GLOBAL(ret_from_fork)
+	bl	.schedule_tail
+	REST_NVGPRS(r1)
+	li	r3,0
+	b	syscall_exit
 
 /*
  * This routine switches between two different tasks.  The process
@@ -263,6 +345,7 @@
  * The code which creates the new task context is in 'copy_thread'
  * in arch/ppc64/kernel/process.c
  */
+	.align	7
 _GLOBAL(_switch)
 	mflr	r0
 	std	r0,16(r1)
@@ -315,7 +398,10 @@
 2:
 END_FTR_SECTION_IFSET(CPU_FTR_SLB)
 	clrrdi	r7,r8,THREAD_SHIFT	/* base of new stack */
-	addi	r7,r7,THREAD_SIZE-INT_FRAME_SIZE
+	/* Note: this uses SWITCH_FRAME_SIZE rather than INT_FRAME_SIZE
+	   because we don't need to leave the 288-byte ABI gap at the
+	   top of the kernel stack. */
+	addi	r7,r7,THREAD_SIZE-SWITCH_FRAME_SIZE
 
 	mr	r1,r8		/* start using new stack pointer */
 	std	r7,PACAKSAVE(r13)
@@ -350,36 +436,33 @@
 	addi	r1,r1,SWITCH_FRAME_SIZE
 	blr
 
-_GLOBAL(ret_from_fork)
-	bl	.schedule_tail
-	clrrdi	r4,r1,THREAD_SHIFT
-	ld	r4,TI_FLAGS(r4)
-	andi.	r4,r4,_TIF_SYSCALL_T_OR_A
-	beq+	.ret_from_except
-	bl	.do_syscall_trace_leave
-	b	.ret_from_except
-
+	.align	7
 _GLOBAL(ret_from_except)
+	ld	r11,_TRAP(r1)
+	andi.	r0,r11,1
+	bne	.ret_from_except_lite
+	REST_NVGPRS(r1)
+
+_GLOBAL(ret_from_except_lite)
 	/*
 	 * Disable interrupts so that current_thread_info()->flags
 	 * can't change between when we test it and when we return
 	 * from the interrupt.
 	 */
 	mfmsr	r10		/* Get current interrupt state */
-	li	r4,0
-	ori	r4,r4,MSR_EE
-	andc	r9,r10,r4	/* clear MSR_EE */
+	rldicl	r9,r10,48,1	/* clear MSR_EE */
+	rotldi	r9,r9,16
 	mtmsrd	r9,1		/* Update machine state */
 
 #ifdef CONFIG_PREEMPT
 	clrrdi	r9,r1,THREAD_SHIFT	/* current_thread_info() */
+	li	r0,_TIF_NEED_RESCHED	/* bits to check */
 	ld	r3,_MSR(r1)
 	ld	r4,TI_FLAGS(r9)
-	andi.	r0,r3,MSR_PR
-	mtcrf	1,r4		/* get bottom 4 thread flags into cr7 */
-	bt	31-TIF_NEED_RESCHED,do_resched
-	beq	restore		/* if returning to kernel */
-	bt	31-TIF_SIGPENDING,do_user_signal
+	/* Move MSR_PR bit in r3 to _TIF_SIGPENDING position in r0 */
+	rlwimi	r0,r3,32+TIF_SIGPENDING-MSR_PR_LG,_TIF_SIGPENDING
+	and.	r0,r4,r0	/* check NEED_RESCHED and maybe SIGPENDING */
+	bne	do_work
 
 #else /* !CONFIG_PREEMPT */
 	ld	r3,_MSR(r1)	/* Returning to user mode? */
@@ -393,29 +476,16 @@
 	bne	do_work
 #endif
 
-	addi	r0,r1,INT_FRAME_SIZE	/* size of frame */
-	ld	r4,PACACURRENT(r13)
-	std	r0,THREAD+KSP(r4)	/* save kernel stack pointer */
-
-	/*
-	 * r13 is our per cpu area, only restore it if we are returning to
-	 * userspace
-	 */
-	REST_GPR(13,r1)
-
 restore:
 #ifdef CONFIG_PPC_ISERIES
 	ld	r5,SOFTE(r1)
-	mfspr	r4,SPRG3		/* get paca address */
 	cmpdi	0,r5,0
 	beq	4f
 	/* Check for pending interrupts (iSeries) */
-	/* this is CHECKANYINT except that we already have the paca address */
-	ld	r3,PACALPPACA+LPPACAANYINT(r4)
+	ld	r3,PACALPPACA+LPPACAANYINT(r13)
 	cmpdi	r3,0
 	beq+	4f			/* skip do_IRQ if no interrupts */
 
-	mfspr	r13,SPRG3		/* get paca pointer back */
 	li	r3,0
 	stb	r3,PACAPROCENABLED(r13)	/* ensure we are soft-disabled */
 	mtmsrd	r10			/* hard-enable again */
@@ -423,13 +493,22 @@
 	bl	.do_IRQ
 	b	.ret_from_except		/* loop back and handle more */
 
-4:	stb	r5,PACAPROCENABLED(r4)
+4:	stb	r5,PACAPROCENABLED(r13)
 #endif
 
 	ld	r3,_MSR(r1)
-	andi.	r3,r3,MSR_RI
+	andi.	r0,r3,MSR_RI
 	beq-	unrecov_restore
 
+	andi.	r0,r3,MSR_PR
+
+	/*
+	 * r13 is our per cpu area, only restore it if we are returning to
+	 * userspace
+	 */
+	beq	1f
+	REST_GPR(13, r1)
+1:
 	ld	r3,_CTR(r1)
 	ld	r0,_LINK(r1)
 	mtctr	r3
@@ -438,8 +517,6 @@
 	mtspr	XER,r3
 
 	REST_8GPRS(5, r1)
-	REST_10GPRS(14, r1)
-	REST_8GPRS(24, r1)
 
 	stdcx.	r0,0,r1		/* to clear the reservation */
 
@@ -463,16 +540,13 @@
 	ld	r1,GPR1(r1)
 
 	rfid
+	b	.
 
-#ifndef CONFIG_PREEMPT
-/* Note: this must change if we start using the  TIF_NOTIFY_RESUME bit */
+/* Note: this must change if we start using the TIF_NOTIFY_RESUME bit */
 do_work:
-	andi.	r0,r4,_TIF_NEED_RESCHED
-	beq	do_user_signal
-
-#else /* CONFIG_PREEMPT */
-do_resched:
-	bne	do_user_resched		/* if returning to user mode */
+#ifdef CONFIG_PREEMPT
+	andi.	r0,r3,MSR_PR	/* Returning to user mode? */
+	bne	user_work
 	/* Check that preempt_count() == 0 and interrupts are enabled */
 	lwz	r8,TI_PREEMPT(r9)
 	cmpwi	cr1,r8,0
@@ -491,27 +565,37 @@
 	li	r0,1
 	stb	r0,PACAPROCENABLED(r13)
 #endif
-#endif /* CONFIG_PREEMPT */
-
-do_user_resched:
 	mtmsrd	r10,1		/* reenable interrupts */
 	bl	.schedule
-#ifdef CONFIG_PREEMPT
+	mfmsr	r10
 	clrrdi	r9,r1,THREAD_SHIFT
+	rldicl	r10,r10,48,1	/* disable interrupts again */
 	li	r0,0
+	rotldi	r10,r10,16
+	mtmsrd	r10,1
+	ld	r4,TI_FLAGS(r9)
+	andi.	r0,r4,_TIF_NEED_RESCHED
+	bne	1b
 	stw	r0,TI_PREEMPT(r9)
-#endif
-	b	.ret_from_except
+	b	restore
 
-do_user_signal:
+user_work:
+#endif
+	/* Enable interrupts */
 	mtmsrd	r10,1
+
+	andi.	r0,r4,_TIF_NEED_RESCHED
+	beq	1f
+	bl	.schedule
+	b	.ret_from_except_lite
+
+1:	bl	.save_nvgprs
 	li	r3,0
 	addi	r4,r1,STACK_FRAME_OVERHEAD
 	bl	.do_signal
 	b	.ret_from_except
 
 unrecov_restore:
-	mfspr   r13,SPRG3
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	.unrecoverable_exception
 	b	unrecov_restore
@@ -529,7 +613,7 @@
 	mflr	r0
 	std	r0,16(r1)
         stdu	r1,-RTAS_FRAME_SIZE(r1)	/* Save SP and create stack space. */
-	
+
 	/* Because RTAS is running in 32b mode, it clobbers the high order half
 	 * of all registers that it saves.  We therefore save those registers
 	 * RTAS might touch to the stack.  (r0, r3-r13 are caller saved)
diff -urN preempt/arch/ppc64/kernel/head.S test25/arch/ppc64/kernel/head.S
--- preempt/arch/ppc64/kernel/head.S	2004-06-04 20:10:46.000000000 +1000
+++ test25/arch/ppc64/kernel/head.S	2004-06-17 15:46:06.000000000 +1000
@@ -40,15 +40,6 @@
 #define DO_SOFT_DISABLE
 #endif
 
-/* copy saved SOFTE bit or EE bit from saved MSR depending
- * if we are doing soft-disable or not
- */
-#ifdef DO_SOFT_DISABLE
-#define DO_COPY_EE()	ld	r20,SOFTE(r1)
-#else
-#define DO_COPY_EE()	rldicl	r20,r23,49,63
-#endif
-
 /*
  * hcall interface to pSeries LPAR
  */
@@ -177,11 +168,18 @@
 #endif
 #endif
 
+/* This value is used to mark exception frames on the stack. */
+	.section ".toc","aw"
+exception_marker:
+	.tc	ID_72656773_68657265[TC],0x7265677368657265
+	.text
+
 /*
  * The following macros define the code that appears as
  * the prologue to each of the exception handlers.  They
  * are split into two parts to allow a single kernel binary
- * to be used for pSeries, and iSeries.
+ * to be used for pSeries and iSeries.
+ * LOL.  One day... - paulus
  */
 
 /*
@@ -194,81 +192,55 @@
  * This is the start of the interrupt handlers for pSeries
  * This code runs with relocation off.
  */
-#define EX_SRR0		0
-#define EX_SRR1		8
-#define EX_R20		16
-#define EX_R21		24
-#define EX_R22		32
-#define EX_R23		40
+#define EX_R9		0
+#define EX_R10		8
+#define EX_R11		16
+#define EX_R12		24
+#define EX_R13		32
+#define EX_SRR0		40
 #define EX_DAR		48
 #define EX_DSISR	56
 #define EX_CCR   	60
-#define EX_TRAP   	60
 
-#define EXCEPTION_PROLOG_PSERIES(n,label)                                \
-	mtspr   SPRG2,r20;              /* use SPRG2 as scratch reg   */ \
-	mtspr   SPRG1,r21;              /* save r21                   */ \
-	mfspr   r20,SPRG3;              /* get paca virt addr         */ \
-	ld      r21,PACAEXCSP(r20);     /* get exception stack ptr    */ \
-	addi    r21,r21,EXC_FRAME_SIZE; /* make exception frame       */ \
-	std	r22,EX_R22(r21);	/* Save r22 in exc. frame     */ \
-	li	r22,n;                  /* Save the ex # in exc. frame*/ \
-	stw	r22,EX_TRAP(r21);	/*                            */ \
-	std	r23,EX_R23(r21);	/* Save r23 in exc. frame     */ \
-	mfspr   r22,SRR0;               /* EA of interrupted instr    */ \
-	std	r22,EX_SRR0(r21);	/* Save SRR0 in exc. frame    */ \
-	mfspr   r23,SRR1;               /* machine state at interrupt */ \
-	std	r23,EX_SRR1(r21);	/* Save SRR1 in exc. frame    */ \
-                                                                         \
-	mfspr   r23,DAR;                /* Save DAR in exc. frame      */ \
-	std	r23,EX_DAR(r21);	                                  \
-	mfspr	r23,DSISR;		/* Save DSISR in exc. frame    */ \
-	stw	r23,EX_DSISR(r21);	                                  \
-	mfspr	r23,SPRG2;		/* Save r20 in exc. frame      */ \
-	std	r23,EX_R20(r21);	                                  \
-                                                                         \
-	clrrdi  r22,r20,60;             /* Get 0xc part of the vaddr  */ \
-	ori	r22,r22,(label)@l;      /* add in the vaddr offset    */ \
-		                        /*   assumes *_common < 16b   */ \
-	mfmsr   r23;                                                     \
-	rotldi  r23,r23,4;                                               \
-	ori     r23,r23,0x32B;          /* Set IR, DR, RI, SF, ISF, HV*/ \
-	rotldi  r23,r23,60;             /* for generic handlers       */ \
-	mtspr   SRR0,r22;                                                \
-	mtspr   SRR1,r23;                                                \
-	mfcr    r23;                    /* save CR in r23             */ \
+#define EXCEPTION_PROLOG_PSERIES(area, label)				\
+	mfspr	r13,SPRG3;		/* get paca address into r13 */	\
+	std	r9,area+EX_R9(r13);	/* save r9 - r12 */		\
+	std	r10,area+EX_R10(r13);					\
+	std	r11,area+EX_R11(r13);					\
+	std	r12,area+EX_R12(r13);					\
+	mfspr	r9,SPRG1;						\
+	std	r9,area+EX_R13(r13);					\
+	mfcr	r9;							\
+	clrrdi	r12,r13,32;		/* get high part of &label */	\
+	mfmsr	r10;							\
+	mfspr	r11,SRR0;		/* save SRR0 */			\
+	ori	r12,r12,(label)@l;	/* virt addr of handler */	\
+	ori	r10,r10,MSR_IR|MSR_DR|MSR_RI;				\
+	mtspr	SRR0,r12;						\
+	mfspr	r12,SRR1;		/* and SRR1 */			\
+	mtspr	SRR1,r10;						\
 	rfid
 
 /*
  * This is the start of the interrupt handlers for iSeries
  * This code runs with relocation on.
  */
-#define EXCEPTION_PROLOG_ISERIES(n)	                                      \
-	mtspr	SPRG2,r20;		    /* use SPRG2 as scratch reg    */ \
-	mtspr   SPRG1,r21;                  /* save r21                    */ \
-	mfspr	r20,SPRG3;		    /* get paca                    */ \
-	ld      r21,PACAEXCSP(r20);         /* get exception stack ptr     */ \
-	addi    r21,r21,EXC_FRAME_SIZE;     /* make exception frame        */ \
-	std	r22,EX_R22(r21);	    /* save r22 on exception frame */ \
-	li	r22,n;                      /* Save the ex # in exc. frame */ \
-	stw	r22,EX_TRAP(r21);	    /*                             */ \
-	std	r23,EX_R23(r21);	    /* Save r23 in exc. frame      */ \
-	ld      r22,LPPACA+LPPACASRR0(r20); /* Get SRR0 from ItLpPaca      */ \
-	std	r22,EX_SRR0(r21);	    /* save SRR0 in exc. frame     */ \
-	ld      r23,LPPACA+LPPACASRR1(r20); /* Get SRR1 from ItLpPaca      */ \
-	std	r23,EX_SRR1(r21);	    /* save SRR1 in exc. frame     */ \
-                                                                         \
-	mfspr   r23,DAR;                /* Save DAR in exc. frame      */ \
-	std	r23,EX_DAR(r21);	                                  \
-	mfspr	r23,DSISR;		/* Save DSISR in exc. frame    */ \
-	stw	r23,EX_DSISR(r21);	                                  \
-	mfspr	r23,SPRG2;		/* Save r20 in exc. frame      */ \
-	std	r23,EX_R20(r21);	                                  \
-                                                                         \
-	mfmsr	r22;			    /* set MSR.RI		   */ \
-	ori	r22,r22,MSR_RI;						      \
-	mtmsrd	r22,1;							      \
-	mfcr    r23;                        /* save CR in r23              */
+#define EXCEPTION_PROLOG_ISERIES_1(area)				\
+	mfspr	r13,SPRG3;		/* get paca address into r13 */	\
+	std	r9,area+EX_R9(r13);	/* save r9 - r12 */		\
+	std	r10,area+EX_R10(r13);					\
+	std	r11,area+EX_R11(r13);					\
+	std	r12,area+EX_R12(r13);					\
+	mfspr	r9,SPRG1;						\
+	std	r9,area+EX_R13(r13);					\
+	mfcr	r9
+
+#define EXCEPTION_PROLOG_ISERIES_2					\
+	mfmsr	r10;							\
+	ld	r11,LPPACA+LPPACASRR0(r13);				\
+	ld	r12,LPPACA+LPPACASRR1(r13);				\
+	ori	r10,r10,MSR_RI;						\
+	mtmsrd	r10,1
 
 /*
  * The common exception prolog is used for all except a few exceptions
@@ -276,107 +248,154 @@
  * to take another exception from the point where we first touch the
  * kernel stack onwards.
  *
- * On entry r20 points to the paca and r21 points to the exception
- * frame on entry, r23 contains the saved CR, and relocation is on.
- */
-#define EXCEPTION_PROLOG_COMMON                                           \
-	mfspr	r22,SPRG1;		/* Save r21 in exc. frame      */ \
-	std	r22,EX_R21(r21);	                                  \
-	std     r21,PACAEXCSP(r20);     /* update exception stack ptr  */ \
-	ld	r22,EX_SRR1(r21);	/* Get SRR1 from exc. frame    */ \
-	andi.   r22,r22,MSR_PR;         /* Set CR for later branch     */ \
-	mr      r22,r1;                 /* Save r1                     */ \
-	subi    r1,r1,INT_FRAME_SIZE;   /* alloc frame on kernel stack */ \
-	beq-    1f;                                                       \
-	ld      r1,PACAKSAVE(r20);      /* kernel stack to use         */ \
-1:      cmpdi	cr1,r1,0;		/* check if r1 is in userspace */ \
-	bge	cr1,bad_stack;		/* abort if it is	       */ \
-	std     r22,GPR1(r1);           /* save r1 in stackframe       */ \
-	std     r22,0(r1);              /* make stack chain pointer    */ \
-	std     r23,_CCR(r1);           /* save CR in stackframe       */ \
-	ld	r22,EX_R20(r21);	/* move r20 to stackframe      */ \
-	std	r22,GPR20(r1);		                                  \
-	ld	r23,EX_R21(r21);	/* move r21 to stackframe      */ \
-	std	r23,GPR21(r1);		                                  \
-	ld	r22,EX_R22(r21);	/* move r22 to stackframe      */ \
-	std	r22,GPR22(r1);		                                  \
-	ld	r23,EX_R23(r21);	/* move r23 to stackframe      */ \
-	std	r23,GPR23(r1);		                                  \
-	mflr    r22;                    /* save LR in stackframe       */ \
-	std     r22,_LINK(r1);                                            \
-	mfctr   r23;                    /* save CTR in stackframe      */ \
-	std     r23,_CTR(r1);                                             \
-	mfspr   r22,XER;                /* save XER in stackframe      */ \
-	std     r22,_XER(r1);                                             \
-	ld	r23,EX_DAR(r21);	/* move DAR to stackframe      */ \
-	std	r23,_DAR(r1);		                                  \
-	lwz     r22,EX_DSISR(r21);	/* move DSISR to stackframe    */ \
-	std	r22,_DSISR(r1);		                                  \
-	lbz	r22,PACAPROCENABLED(r20);                                 \
-	std	r22,SOFTE(r1);		                                  \
-	ld	r22,EX_SRR0(r21);	/* get SRR0 from exc. frame    */ \
-	ld	r23,EX_SRR1(r21);	/* get SRR1 from exc. frame    */ \
-	addi    r21,r21,-EXC_FRAME_SIZE;/* pop off exception frame     */ \
-	std     r21,PACAEXCSP(r20);                                       \
-	SAVE_GPR(0, r1);                /* save r0 in stackframe       */ \
-	SAVE_8GPRS(2, r1);              /* save r2 - r13 in stackframe */ \
-	SAVE_4GPRS(10, r1);                                               \
-	ld      r2,PACATOC(r20);	                                  \
-	mr	r13,r20
-
-/*
- * Note: code which follows this uses cr0.eq (set if from kernel),
- * r1, r22 (SRR0), and r23 (SRR1).
- */
+ * On entry r13 points to the paca, r9-r13 are saved in the paca,
+ * r9 contains the saved CR, r11 and r12 contain the saved SRR0 and
+ * SRR1, and relocation is on.
+ */
+#define EXCEPTION_PROLOG_COMMON(n, area)				   \
+	andi.	r10,r12,MSR_PR;		/* See if coming from user	*/ \
+	mr	r10,r1;			/* Save r1			*/ \
+	subi    r1,r1,INT_FRAME_SIZE;   /* alloc frame on kernel stack  */ \
+	beq-    1f;                                                        \
+	ld	r1,PACAKSAVE(r13);	/* kernel stack to use		*/ \
+1:      cmpdi	cr1,r1,0;		/* check if r1 is in userspace  */ \
+	bge-	cr1,bad_stack;		/* abort if it is		*/ \
+	std	r9,_CCR(r1);		/* save CR in stackframe	*/ \
+	std	r11,_NIP(r1);		/* save SRR0 in stackframe	*/ \
+	std	r12,_MSR(r1);		/* save SRR1 in stackframe	*/ \
+	std	r10,0(r1);		/* make stack chain pointer	*/ \
+	std	r0,GPR0(r1);		/* save r0 in stackframe	*/ \
+	std	r10,GPR1(r1);		/* save r1 in stackframe	*/ \
+	std	r2,GPR2(r1);		/* save r2 in stackframe	*/ \
+	SAVE_4GPRS(3, r1);		/* save r3 - r6 in stackframe	*/ \
+	SAVE_2GPRS(7, r1);		/* save r7, r8 in stackframe	*/ \
+	ld	r9,area+EX_R9(r13);	/* move r9, r10 to stackframe	*/ \
+	ld	r10,area+EX_R10(r13);					   \
+	std	r9,GPR9(r1);						   \
+	std	r10,GPR10(r1);						   \
+	ld	r9,area+EX_R11(r13);	/* move r11 - r13 to stackframe	*/ \
+	ld	r10,area+EX_R12(r13);					   \
+	ld	r11,area+EX_R13(r13);					   \
+	std	r9,GPR11(r1);						   \
+	std	r10,GPR12(r1);						   \
+	std	r11,GPR13(r1);						   \
+	ld	r2,PACATOC(r13);	/* get kernel TOC into r2	*/ \
+	mflr	r9;			/* save LR in stackframe	*/ \
+	std	r9,_LINK(r1);						   \
+	mfctr	r10;			/* save CTR in stackframe	*/ \
+	std	r10,_CTR(r1);						   \
+	mfspr	r11,XER;		/* save XER in stackframe	*/ \
+	std	r11,_XER(r1);						   \
+	li	r9,(n)+1;						   \
+	std	r9,_TRAP(r1);		/* set trap number		*/ \
+	li	r10,0;							   \
+	ld	r11,exception_marker@toc(r2);				   \
+	std	r10,RESULT(r1);		/* clear regs->result		*/ \
+	std	r11,STACK_FRAME_OVERHEAD-16(r1); /* mark the frame	*/
 
 /*
  * Exception vectors.
  */
-#define STD_EXCEPTION_PSERIES(n, label )	\
-	. = n;					\
-	.globl label##_Pseries;			\
-label##_Pseries:				\
-	EXCEPTION_PROLOG_PSERIES( n, label##_common )
-
-#define STD_EXCEPTION_ISERIES( n, label )	\
-	.globl label##_Iseries;			\
-label##_Iseries:				\
-	EXCEPTION_PROLOG_ISERIES( n );          \
+#define STD_EXCEPTION_PSERIES(n, label )		\
+	. = n;						\
+	.globl label##_Pseries;				\
+label##_Pseries:					\
+	mtspr	SPRG1,r13;		/* save r13 */	\
+	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, label##_common)
+
+#define STD_EXCEPTION_ISERIES(n, label, area)		\
+	.globl label##_Iseries;				\
+label##_Iseries:					\
+	mtspr	SPRG1,r13;		/* save r13 */	\
+	EXCEPTION_PROLOG_ISERIES_1(area);		\
+	EXCEPTION_PROLOG_ISERIES_2;			\
 	b	label##_common
 
-#define MASKABLE_EXCEPTION_ISERIES( n, label )	\
-	.globl label##_Iseries;			\
-label##_Iseries:				\
-	EXCEPTION_PROLOG_ISERIES( n );		\
-	lbz	r22,PACAPROFENABLED(r20);	\
-	cmpi	0,r22,0;			\
-	bne-	label##_Iseries_profile;	\
-label##_Iseries_prof_ret:			\
-	lbz	r22,PACAPROCENABLED(r20);	\
-	cmpi	0,r22,0;			\
-	beq-	label##_Iseries_masked;		\
-	b	label##_common;			\
-label##_Iseries_profile:			\
-	std	r24,48(r21);			\
-	std	r25,56(r21);			\
-	mflr	r24;				\
-	bl	do_profile;			\
-	mtlr	r24;				\
-	ld	r24,48(r21);			\
-	ld	r25,56(r21);			\
+#define MASKABLE_EXCEPTION_ISERIES( n, label )				\
+	.globl label##_Iseries;						\
+label##_Iseries:							\
+	mtspr	SPRG1,r13;		/* save r13 */			\
+	EXCEPTION_PROLOG_ISERIES_1(PACA_EXGEN);				\
+	lbz	r10,PACAPROFENABLED(r13);				\
+	cmpwi	r10,0;							\
+	bne-	label##_Iseries_profile;				\
+label##_Iseries_prof_ret:						\
+	lbz	r10,PACAPROCENABLED(r13);				\
+	cmpwi	0,r10,0;						\
+	beq-	label##_Iseries_masked;					\
+	EXCEPTION_PROLOG_ISERIES_2;					\
+	b	label##_common;						\
+label##_Iseries_profile:						\
+	ld	r12,LPPACA+LPPACASRR1(r13);				\
+	andi.	r12,r12,MSR_PR;		/* Test if in kernel */		\
+	bne	label##_Iseries_prof_ret;				\
+	ld	r11,LPPACA+LPPACASRR0(r13);				\
+	ld	r12,PACAPROFSTEXT(r13);	/* _stext */			\
+	subf	r11,r12,r11;		/* offset into kernel */	\
+	lwz	r12,PACAPROFSHIFT(r13);					\
+	srd	r11,r11,r12;						\
+	lwz	r12,PACAPROFLEN(r13);	/* profile table length - 1 */	\
+	cmpd	r11,r12;		/* off end? */			\
+	ble	1f;							\
+	mr	r11,r12;		/* force into last entry */	\
+1:	sldi	r11,r11,2;		/* convert to offset */		\
+	ld	r12,PACAPROFBUFFER(r13);/* profile buffer */		\
+	add	r12,r12,r11;						\
+2:	lwarx	r11,0,r12;		/* atomically increment */	\
+	addi	r11,r11,1;						\
+	stwcx.	r11,0,r12;						\
+	bne-	2b;							\
 	b	label##_Iseries_prof_ret
 
+#ifdef DO_SOFT_DISABLE
+#define DISABLE_INTS				\
+	lbz	r10,PACAPROCENABLED(r13);	\
+	li	r11,0;				\
+	std	r10,SOFTE(r1);			\
+	mfmsr	r10;				\
+	stb	r11,PACAPROCENABLED(r13);	\
+	ori	r10,r10,MSR_EE;			\
+	mtmsrd	r10,1
+
+#define ENABLE_INTS				\
+	lbz	r10,PACAPROCENABLED(r13);	\
+	mfmsr	r11;				\
+	std	r10,SOFTE(r1);			\
+	ori	r11,r11,MSR_EE;			\
+	mtmsrd	r11,1
+
+#else	/* hard enable/disable interrupts */
+#define DISABLE_INTS
+
+#define ENABLE_INTS				\
+	ld	r12,_MSR(r1);			\
+	mfmsr	r11;				\
+	rlwimi	r11,r12,0,MSR_EE;		\
+	mtmsrd	r11,1
+
+#endif
+
 #define STD_EXCEPTION_COMMON( trap, label, hdlr )	\
-	.globl label##_common;			\
-label##_common:					\
-	EXCEPTION_PROLOG_COMMON;		\
-	addi	r3,r1,STACK_FRAME_OVERHEAD;	\
-	li	r20,0;				\
-	li	r6,trap;			\
-	bl      .save_remaining_regs;           \
-	bl      hdlr;                           \
+	.align	7;					\
+	.globl label##_common;				\
+label##_common:						\
+	EXCEPTION_PROLOG_COMMON(trap, PACA_EXGEN);	\
+	DISABLE_INTS;					\
+	bl	.save_nvgprs;				\
+	addi	r3,r1,STACK_FRAME_OVERHEAD;		\
+	bl      hdlr;					\
 	b       .ret_from_except
 
+#define STD_EXCEPTION_COMMON_LITE(trap, label, hdlr)	\
+	.align	7;					\
+	.globl label##_common;				\
+label##_common:						\
+	EXCEPTION_PROLOG_COMMON(trap, PACA_EXGEN);	\
+	DISABLE_INTS;					\
+	addi	r3,r1,STACK_FRAME_OVERHEAD;		\
+	bl	hdlr;					\
+	b	.ret_from_except_lite
+
 /*
  * Start of pSeries system interrupt routines
  */
@@ -385,9 +404,45 @@
 __start_interrupts:
 
 	STD_EXCEPTION_PSERIES( 0x100, SystemReset )
-	STD_EXCEPTION_PSERIES( 0x200, MachineCheck )
-	STD_EXCEPTION_PSERIES( 0x300, DataAccess )
-	STD_EXCEPTION_PSERIES( 0x380, DataAccessSLB )
+
+	. = 0x200
+	.globl MachineCheck_Pseries
+_MachineCheckPseries:
+	mtspr	SPRG1,r13		/* save r13 */
+	EXCEPTION_PROLOG_PSERIES(PACA_EXMC, MachineCheck_common)
+
+	. = 0x300
+	.globl DataAccess_Pseries
+DataAccess_Pseries:
+	mtspr	SPRG1,r13
+BEGIN_FTR_SECTION
+	mtspr	SPRG2,r12
+	mfspr	r13,DAR
+	mfspr	r12,DSISR
+	srdi	r13,r13,60
+	rlwimi	r13,r12,16,0x20
+	mfcr	r12
+	cmpwi	r13,0x2c
+	beq	.do_stab_bolted_Pseries
+	mtcrf	0x80,r12
+	mfspr	r12,SPRG2
+END_FTR_SECTION_IFCLR(CPU_FTR_SLB)
+	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, DataAccess_common)
+
+	. = 0x380
+	.globl DataAccessSLB_Pseries
+DataAccessSLB_Pseries:
+	mtspr	SPRG1,r13
+	mtspr	SPRG2,r12
+	mfspr	r13,DAR
+	mfcr	r12
+	srdi	r13,r13,60
+	cmpdi	r13,0xc
+	beq	.do_slb_bolted_Pseries
+	mtcrf	0x80,r12
+	mfspr	r12,SPRG2
+	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, DataAccessSLB_common)
+
 	STD_EXCEPTION_PSERIES( 0x400, InstructionAccess )
 	STD_EXCEPTION_PSERIES( 0x480, InstructionAccessSLB )
 	STD_EXCEPTION_PSERIES( 0x500, HardwareInterrupt )
@@ -397,7 +452,23 @@
 	STD_EXCEPTION_PSERIES( 0x900, Decrementer )
 	STD_EXCEPTION_PSERIES( 0xa00, Trap_0a )
 	STD_EXCEPTION_PSERIES( 0xb00, Trap_0b )
-	STD_EXCEPTION_PSERIES( 0xc00, SystemCall )
+
+	. = 0xc00
+	.globl	SystemCall_Pseries
+SystemCall_Pseries:
+	mr	r9,r13
+	mfmsr	r10
+	mfspr	r13,SPRG3
+	mfspr	r11,SRR0
+	clrrdi	r12,r13,32
+	oris	r12,r12,SystemCall_common@h
+	ori	r12,r12,SystemCall_common@l
+	mtspr	SRR0,r12
+	ori	r10,r10,MSR_IR|MSR_DR|MSR_RI
+	mfspr	r12,SRR1
+	mtspr	SRR1,r10
+	rfid
+
 	STD_EXCEPTION_PSERIES( 0xd00, SingleStep )
 	STD_EXCEPTION_PSERIES( 0xe00, Trap_0e )
 
@@ -407,25 +478,26 @@
 	 * trickery is thus necessary
 	 */
 	. = 0xf00
-	b	.PerformanceMonitor_Pseries
-	. = 0xf20
-	b	.AltivecUnavailable_Pseries
+	b	PerformanceMonitor_Pseries
+
+	STD_EXCEPTION_PSERIES(0xf20, AltivecUnavailable)
 
 	STD_EXCEPTION_PSERIES( 0x1300, InstructionBreakpoint )
 	STD_EXCEPTION_PSERIES( 0x1700, AltivecAssist )
 
-	/* Here are the "moved" performance monitor and
-	 * altivec unavailable exceptions
-	 */
-	. = 0x3000
-	.globl PerformanceMonitor_Pseries;
-.PerformanceMonitor_Pseries:
-	EXCEPTION_PROLOG_PSERIES(0xf00, PerformanceMonitor_common)
+	/* moved from 0xf00 */
+	STD_EXCEPTION_PSERIES(0x3000, PerformanceMonitor)
 	
 	. = 0x3100
-	.globl AltivecUnavailable_Pseries;
-.AltivecUnavailable_Pseries:
-	EXCEPTION_PROLOG_PSERIES(0xf20, AltivecUnavailable_common)
+_GLOBAL(do_stab_bolted_Pseries)
+	mtcrf	0x80,r12
+	mfspr	r12,SPRG2
+	EXCEPTION_PROLOG_PSERIES(PACA_EXSLB, .do_stab_bolted)
+
+_GLOBAL(do_slb_bolted_Pseries)
+	mtcrf	0x80,r12
+	mfspr	r12,SPRG2
+	EXCEPTION_PROLOG_PSERIES(PACA_EXSLB, .do_slb_bolted)
 	
 		
 	/* Space for the naca.  Architected to be located at real address
@@ -484,31 +556,82 @@
 
 /***  ISeries-LPAR interrupt handlers ***/
 
-	STD_EXCEPTION_ISERIES( 0x200, MachineCheck )
-	STD_EXCEPTION_ISERIES( 0x300, DataAccess )
-	STD_EXCEPTION_ISERIES( 0x380, DataAccessSLB )
-	STD_EXCEPTION_ISERIES( 0x400, InstructionAccess )
-	STD_EXCEPTION_ISERIES( 0x480, InstructionAccessSLB )
-	MASKABLE_EXCEPTION_ISERIES( 0x500, HardwareInterrupt )
-	STD_EXCEPTION_ISERIES( 0x600, Alignment )
-	STD_EXCEPTION_ISERIES( 0x700, ProgramCheck )
-	STD_EXCEPTION_ISERIES( 0x800, FPUnavailable )
-	MASKABLE_EXCEPTION_ISERIES( 0x900, Decrementer )
-	STD_EXCEPTION_ISERIES( 0xa00, Trap_0a )
-	STD_EXCEPTION_ISERIES( 0xb00, Trap_0b )
-	STD_EXCEPTION_ISERIES( 0xc00, SystemCall )
-	STD_EXCEPTION_ISERIES( 0xd00, SingleStep )
-	STD_EXCEPTION_ISERIES( 0xe00, Trap_0e )
-	STD_EXCEPTION_ISERIES( 0xf00, PerformanceMonitor )
+	STD_EXCEPTION_ISERIES(0x200, MachineCheck, PACA_EXMC)
+
+	.globl DataAccess_Iseries
+DataAccess_Iseries:
+	mtspr	SPRG1,r13
+BEGIN_FTR_SECTION
+	mtspr	SPRG2,r12
+	mfspr	r13,DAR
+	mfspr	r12,DSISR
+	srdi	r13,r13,60
+	rlwimi	r13,r12,16,0x20
+	mfcr	r12
+	cmpwi	r13,0x2c
+	beq	.do_stab_bolted_Iseries
+	mtcrf	0x80,r12
+	mfspr	r12,SPRG2
+END_FTR_SECTION_IFCLR(CPU_FTR_SLB)
+	EXCEPTION_PROLOG_ISERIES_1(PACA_EXGEN)
+	EXCEPTION_PROLOG_ISERIES_2
+	b	DataAccess_common
+
+.do_stab_bolted_Iseries:
+	mtcrf	0x80,r12
+	mfspr	r12,SPRG2
+	EXCEPTION_PROLOG_ISERIES_1(PACA_EXSLB)
+	EXCEPTION_PROLOG_ISERIES_2
+	b	.do_stab_bolted
+
+	.globl	DataAccessSLB_Iseries
+DataAccessSLB_Iseries:
+	mtspr	SPRG1,r13		/* save r13 */
+	mtspr	SPRG2,r12
+	mfspr	r13,DAR
+	mfcr	r12
+	srdi	r13,r13,60
+	cmpdi	r13,0xc
+	beq	.do_slb_bolted_Iseries
+	mtcrf	0x80,r12
+	mfspr	r12,SPRG2
+	EXCEPTION_PROLOG_ISERIES_1(PACA_EXGEN)
+	EXCEPTION_PROLOG_ISERIES_2
+	b	DataAccessSLB_common
+
+.do_slb_bolted_Iseries:
+	mtcrf	0x80,r12
+	mfspr	r12,SPRG2
+	EXCEPTION_PROLOG_ISERIES_1(PACA_EXSLB)
+	EXCEPTION_PROLOG_ISERIES_2
+	b	.do_slb_bolted
+
+	STD_EXCEPTION_ISERIES(0x400, InstructionAccess, PACA_EXGEN)
+	STD_EXCEPTION_ISERIES(0x480, InstructionAccessSLB, PACA_EXGEN)
+	MASKABLE_EXCEPTION_ISERIES(0x500, HardwareInterrupt)
+	STD_EXCEPTION_ISERIES(0x600, Alignment, PACA_EXGEN)
+	STD_EXCEPTION_ISERIES(0x700, ProgramCheck, PACA_EXGEN)
+	STD_EXCEPTION_ISERIES(0x800, FPUnavailable, PACA_EXGEN)
+	MASKABLE_EXCEPTION_ISERIES(0x900, Decrementer)
+	STD_EXCEPTION_ISERIES(0xa00, Trap_0a, PACA_EXGEN)
+	STD_EXCEPTION_ISERIES(0xb00, Trap_0b, PACA_EXGEN)
+
+	.globl	SystemCall_Iseries
+SystemCall_Iseries:
+	mr	r9,r13
+	mfspr	r13,SPRG3
+	EXCEPTION_PROLOG_ISERIES_2
+	b	SystemCall_common
+
+	STD_EXCEPTION_ISERIES( 0xd00, SingleStep, PACA_EXGEN)
+	STD_EXCEPTION_ISERIES( 0xe00, Trap_0e, PACA_EXGEN)
+	STD_EXCEPTION_ISERIES( 0xf00, PerformanceMonitor, PACA_EXGEN)
 
 	.globl SystemReset_Iseries
 SystemReset_Iseries:
 	mfspr	r13,SPRG3		/* Get paca address */
-	mfmsr	r24
-	ori	r24,r24,MSR_RI
-	mtmsrd	r24			/* RI on */
 	lhz	r24,PACAPACAINDEX(r13)	/* Get processor # */
-	cmpi	0,r24,0			/* Are we processor 0? */
+	cmpwi	0,r24,0			/* Are we processor 0? */
 	beq	.__start_initialization_iSeries	/* Start up the first processor */
 	mfspr	r4,CTRLF
 	li	r5,RUNLATCH		/* Turn off the run light */
@@ -527,7 +650,7 @@
 	addi	r1,r3,THREAD_SIZE
 	subi	r1,r1,STACK_FRAME_OVERHEAD
 
-	cmpi	0,r23,0
+	cmpwi	0,r23,0
 	beq	iseries_secondary_smp_loop	/* Loop until told to go */
 #ifdef SECONDARY_PROCESSORS
 	bne	.__secondary_start		/* Loop until told to go */
@@ -552,28 +675,29 @@
 	b	1b			/* If SMP not configured, secondaries
 					 * loop forever */
 
-	.globl HardwareInterrupt_Iseries_masked
-HardwareInterrupt_Iseries_masked:
-	b	maskable_exception_exit
-
 	.globl Decrementer_Iseries_masked
 Decrementer_Iseries_masked:
-	li	r22,1
-	stb	r22,PACALPPACA+LPPACADECRINT(r20)
-	lwz	r22,PACADEFAULTDECR(r20)
-	mtspr	DEC,r22
-maskable_exception_exit:
-	mtcrf	0xff,r23		/* Restore regs and free exception frame */
-	ld	r22,EX_SRR0(r21)
-	ld	r23,EX_SRR1(r21)
-	mtspr	SRR0,r22
-	mtspr	SRR1,r23
-	ld	r22,EX_R22(r21)
-	ld	r23,EX_R23(r21)
-	mfspr	r21,SPRG1
-	mfspr	r20,SPRG2
+	li	r11,1
+	stb	r11,PACALPPACA+LPPACADECRINT(r13)
+	lwz	r12,PACADEFAULTDECR(r13)
+	mtspr	DEC,r12
+	/* fall through */
+
+	.globl HardwareInterrupt_Iseries_masked
+HardwareInterrupt_Iseries_masked:
+	mtcrf	0x80,r9		/* Restore regs */
+	ld	r11,LPPACA+LPPACASRR0(r13)
+	ld	r12,LPPACA+LPPACASRR1(r13)
+	mtspr	SRR0,r11
+	mtspr	SRR1,r12
+	ld	r9,PACA_EXGEN+EX_R9(r13)
+	ld	r10,PACA_EXGEN+EX_R10(r13)
+	ld	r11,PACA_EXGEN+EX_R11(r13)
+	ld	r12,PACA_EXGEN+EX_R12(r13)
+	ld	r13,PACA_EXGEN+EX_R13(r13)
 	rfid
 #endif
+
 /*
  * Data area reserved for FWNMI option.
  */
@@ -587,10 +711,12 @@
 	. = 0x8000
 	.globl SystemReset_FWNMI
 SystemReset_FWNMI:
-	EXCEPTION_PROLOG_PSERIES(0x100, SystemReset_common)
+	mtspr	SPRG1,r13		/* save r13 */
+	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, SystemReset_common)
 	.globl MachineCheck_FWNMI
 MachineCheck_FWNMI:
-	EXCEPTION_PROLOG_PSERIES(0x200, MachineCheck_common)
+	mtspr	SPRG1,r13		/* save r13 */
+	EXCEPTION_PROLOG_PSERIES(PACA_EXMC, MachineCheck_common)
 
 	/*
 	 * Space for the initial segment table
@@ -609,8 +735,22 @@
 /*** Common interrupt handlers ***/
 
 	STD_EXCEPTION_COMMON( 0x100, SystemReset, .SystemResetException )
-	STD_EXCEPTION_COMMON( 0x200, MachineCheck, .MachineCheckException )
-	STD_EXCEPTION_COMMON( 0x900, Decrementer, .timer_interrupt )
+
+	/*
+	 * Machine check is different because we use a different
+	 * save area: PACA_EXMC instead of PACA_EXGEN.
+	 */
+	.align	7
+	.globl MachineCheck_common
+MachineCheck_common:
+	EXCEPTION_PROLOG_COMMON(0x200, PACA_EXMC)
+	DISABLE_INTS
+	bl	.save_nvgprs
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	.MachineCheckException
+	b	.ret_from_except
+
+	STD_EXCEPTION_COMMON_LITE(0x900, Decrementer, .timer_interrupt)
 	STD_EXCEPTION_COMMON( 0xa00, Trap_0a, .UnknownException )
 	STD_EXCEPTION_COMMON( 0xb00, Trap_0b, .UnknownException )
 	STD_EXCEPTION_COMMON( 0xd00, SingleStep, .SingleStepException )
@@ -624,65 +764,56 @@
 #endif
 
 /*
- * Here the exception frame is filled out and we have detected that
- * the kernel stack pointer is bad.  R23 contains the saved CR, r20
- * points to the paca, r21 points to the exception frame, and r22
- * contains the (bad) kernel stack pointer.
+ * Here we have detected that the kernel stack pointer is bad.
+ * R9 contains the saved CR, r13 points to the paca,
+ * r10 contains the (bad) kernel stack pointer,
+ * r11 and r12 contain the saved SRR0 and SRR1.
  * We switch to using the paca guard page as an emergency stack,
- * save the registers on there, and call kernel_bad_stack(),
- * which panics.
+ * save the registers there, and call kernel_bad_stack(), which panics.
  */
 bad_stack:
-	addi	r1,r20,8192-64-INT_FRAME_SIZE
-	std	r22,GPR1(r1)
-	std	r23,_CCR(r1)
-	ld	r22,EX_R20(r21)
-	std	r22,GPR20(r1)
-	ld	r23,EX_R21(r21)
-	std	r23,GPR21(r1)
-	ld	r22,EX_R22(r21)
-	std	r22,GPR22(r1)
-	ld	r23,EX_R23(r21)
-	std	r23,GPR23(r1)
-	ld	r23,EX_DAR(r21)
-	std	r23,_DAR(r1)
-	lwz     r22,EX_DSISR(r21)
-	std	r22,_DSISR(r1)
-	lwz	r23,EX_TRAP(r21)
-	std	r23,TRAP(r1)
-	ld	r22,EX_SRR0(r21)
-	ld	r23,EX_SRR1(r21)
-	std	r22,_NIP(r1)
-	std	r23,_MSR(r1)
-	addi	r21,r21,-EXC_FRAME_SIZE
-	std	r21,PACAEXCSP(r20)
-	mflr	r22
-	std	r22,_LINK(r1)
-	mfctr	r23
-	std	r23,_CTR(r1)
-	mfspr	r22,XER
-	std	r22,_XER(r1)
+	addi	r1,r13,8192-64-INT_FRAME_SIZE
+	std	r9,_CCR(r1)
+	std	r10,GPR1(r1)
+	std	r11,_NIP(r1)
+	std	r12,_MSR(r1)
+	mfspr	r11,DAR
+	mfspr	r12,DSISR
+	std	r11,_DAR(r1)
+	std	r12,_DSISR(r1)
+	mflr	r10
+	mfctr	r11
+	mfxer	r12
+	std	r10,_LINK(r1)
+	std	r11,_CTR(r1)
+	std	r12,_XER(r1)
 	SAVE_GPR(0, r1)
-	SAVE_10GPRS(2, r1)
-	SAVE_8GPRS(12, r1)
-	SAVE_8GPRS(24, r1)
-	addi	r21,r1,INT_FRAME_SIZE
-	std	r21,0(r1)
-	li	r22,0
-	std	r22,0(r21)
-	ld	r2,PACATOC(r20)
-	mr	r13,r20
+	SAVE_GPR(2,r1)
+	SAVE_4GPRS(3,r1)
+	SAVE_2GPRS(7,r1)
+	SAVE_10GPRS(12,r1)
+	SAVE_10GPRS(22,r1)
+	addi	r11,r1,INT_FRAME_SIZE
+	std	r11,0(r1)
+	li	r12,0
+	std	r12,0(r11)
+	ld	r2,PACATOC(r13)
 1:	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	.kernel_bad_stack
 	b	1b
 
 /*
- * Return from an exception which is handled without calling
- * save_remaining_regs.  The caller is assumed to have done
- * EXCEPTION_PROLOG_COMMON.
+ * Return from an exception with minimal checks.
+ * The caller is assumed to have done EXCEPTION_PROLOG_COMMON.
+ * If interrupts have been enabled, or anything has been
+ * done that might have changed the scheduling status of
+ * any task or sent any task a signal, you should use
+ * ret_from_except or ret_from_except_lite instead of this.
  */
 fast_exception_return:
-	andi.	r3,r23,MSR_RI		/* check if RI is set */
+	ld	r12,_MSR(r1)
+	ld	r11,_NIP(r1)
+	andi.	r3,r12,MSR_RI		/* check if RI is set */
 	beq-	unrecov_fer
 	ld      r3,_CCR(r1)
 	ld      r4,_LINK(r1)
@@ -691,244 +822,178 @@
 	mtcr    r3
 	mtlr    r4
 	mtctr   r5
-	mtspr   XER,r6
+	mtxer	r6
 	REST_GPR(0, r1)
 	REST_8GPRS(2, r1)
-	REST_4GPRS(10, r1)
 
-	mfmsr	r20
-	li	r21, MSR_RI
-	andc	r20,r20,r21
-	mtmsrd	r20,1
-
-	mtspr   SRR1,r23
-	mtspr   SRR0,r22
-	REST_4GPRS(20, r1)
+	mfmsr	r10
+	clrrdi	r10,r10,2		/* clear RI (LE is 0 already) */
+	mtmsrd	r10,1
+
+	mtspr	SRR1,r12
+	mtspr	SRR0,r11
+	REST_4GPRS(10, r1)
 	ld      r1,GPR1(r1)
 	rfid
 
 unrecov_fer:
-	li	r6,0x4000
-	li	r20,0
-	bl	.save_remaining_regs
+	bl	.save_nvgprs
 1:	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	.unrecoverable_exception
 	b	1b
 
 /*
- * Here r20 points to the PACA, r21 to the exception frame,
- * r23 contains the saved CR.
- * r20 - r23, SRR0 and SRR1 are saved in the exception frame.
+ * Here r13 points to the paca, r9 contains the saved CR,
+ * SRR0 and SRR1 are saved in r11 and r12,
+ * r9 - r13 are saved in paca->exgen.
  */
+	.align	7
 	.globl DataAccess_common
 DataAccess_common:
-BEGIN_FTR_SECTION
-	mfspr   r22,DAR
-	srdi    r22,r22,60
-	cmpi    0,r22,0xc
-
-	/* Segment fault on a bolted segment. Go off and map that segment. */
-	beq-	.do_stab_bolted
-END_FTR_SECTION_IFCLR(CPU_FTR_SLB)
-stab_bolted_user_return:
-	EXCEPTION_PROLOG_COMMON
-	ld      r3,_DSISR(r1)
-	andis.	r0,r3,0xa450		/* weird error? */
-	bne	1f			/* if not, try to put a PTE */
-	andis.	r0,r3,0x0020		/* Is it a page table fault? */
-	rlwinm	r4,r3,32-23,29,29	/* DSISR_STORE -> _PAGE_RW */
-	ld      r3,_DAR(r1)             /* into the hash table */
-
-BEGIN_FTR_SECTION
-	beq+	2f			/* If so handle it */
-	li	r4,0x300                /* Trap number */
-	bl	.do_stab_SI
-	b	1f
-END_FTR_SECTION_IFCLR(CPU_FTR_SLB)
-
-2:	li	r5,0x300
-	bl	.do_hash_page_DSI 	/* Try to handle as hpte fault */
-1:
-	ld      r4,_DAR(r1)
-	ld      r5,_DSISR(r1)
-	addi	r3,r1,STACK_FRAME_OVERHEAD
-	DO_COPY_EE()
-	li	r6,0x300
-	bl      .save_remaining_regs
-	bl      .do_page_fault
-	b       .ret_from_except
+	mfspr	r10,DAR
+	std	r10,PACA_EXGEN+EX_DAR(r13)
+	mfspr	r10,DSISR
+	stw	r10,PACA_EXGEN+EX_DSISR(r13)
+	EXCEPTION_PROLOG_COMMON(0x300, PACA_EXGEN)
+	ld	r3,PACA_EXGEN+EX_DAR(r13)
+	lwz	r4,PACA_EXGEN+EX_DSISR(r13)
+	li	r5,0x300
+	b	.do_hash_page	 	/* Try to handle as hpte fault */
 
+	.align	7
 	.globl DataAccessSLB_common
 DataAccessSLB_common:
-	mfspr   r22,DAR
-	srdi    r22,r22,60
-	cmpi    0,r22,0xc
-
-	/* Segment fault on a bolted segment. Go off and map that segment. */
-	beq     .do_slb_bolted
-
-	EXCEPTION_PROLOG_COMMON
-	ld      r3,_DAR(r1)
-	li      r4,0x380                /* Exception vector  */
+	mfspr	r10,DAR
+	std	r10,PACA_EXGEN+EX_DAR(r13)
+	EXCEPTION_PROLOG_COMMON(0x380, PACA_EXGEN)
+	ld	r3,PACA_EXGEN+EX_DAR(r13)
+	std	r3,_DAR(r1)
 	bl	.slb_allocate
-	or.	r3,r3,r3		/* Check return code */
+	cmpdi	r3,0			/* Check return code */
 	beq     fast_exception_return   /* Return if we succeeded */
-	addi	r3,r1,STACK_FRAME_OVERHEAD
-	DO_COPY_EE()
-	ld      r4,_DAR(r1)
-	li	r6,0x380
 	li	r5,0
-	bl      .save_remaining_regs
-	bl      .do_page_fault
-	b       .ret_from_except
+	std	r5,_DSISR(r1)
+	b	.handle_page_fault
 
+	.align	7
 	.globl InstructionAccess_common
 InstructionAccess_common:
-	EXCEPTION_PROLOG_COMMON
-
-BEGIN_FTR_SECTION
-	andis.	r0,r23,0x0020		/* no ste found? */
-	beq+	2f
-	mr	r3,r22			/* SRR0 at interrupt */
-	li	r4,0x400		/* Trap number       */
-	bl	.do_stab_SI
-	b	1f
-END_FTR_SECTION_IFCLR(CPU_FTR_SLB)
-
-2:	mr	r3,r22
+	EXCEPTION_PROLOG_COMMON(0x400, PACA_EXGEN)
+	ld	r3,_NIP(r1)
+	andis.	r4,r12,0x5820
 	li	r5,0x400
-	bl	.do_hash_page_ISI	/* Try to handle as hpte fault */
-1:
-	mr	r4,r22
-	rlwinm	r5,r23,0,4,4		/* We only care about PR in error_code */
-	addi	r3,r1,STACK_FRAME_OVERHEAD
-	DO_COPY_EE()
-	li	r6,0x400
-	bl      .save_remaining_regs
-	bl      .do_page_fault
-	b       .ret_from_except
+	b	.do_hash_page		/* Try to handle as hpte fault */
 
+	.align	7
 	.globl InstructionAccessSLB_common
 InstructionAccessSLB_common:
-	EXCEPTION_PROLOG_COMMON
-	mr      r3,r22                  /* SRR0 = NIA        */
-	li	r4,0x480                /* Exception vector  */
+	EXCEPTION_PROLOG_COMMON(0x480, PACA_EXGEN)
+	ld	r3,_NIP(r1)		/* SRR0 = NIA	*/
 	bl	.slb_allocate
 	or.	r3,r3,r3		/* Check return code */
 	beq+	fast_exception_return   /* Return if we succeeded */
 
-	addi	r3,r1,STACK_FRAME_OVERHEAD
-	DO_COPY_EE()
-	mr      r4,r22                  /* SRR0 = NIA        */
-	li	r6,0x480
+	ld	r4,_NIP(r1)
 	li	r5,0
-	bl      .save_remaining_regs
-	bl      .do_page_fault
-	b       .ret_from_except
+	std	r4,_DAR(r1)
+	std	r5,_DSISR(r1)
+	b      .handle_page_fault
 
+	.align	7
 	.globl HardwareInterrupt_common
+	.globl HardwareInterrupt_entry
 HardwareInterrupt_common:
-	EXCEPTION_PROLOG_COMMON
+	EXCEPTION_PROLOG_COMMON(0x500, PACA_EXGEN)
 HardwareInterrupt_entry:
+	DISABLE_INTS
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	li	r20,0
-	li	r6,0x500
-	bl      .save_remaining_regs
 	bl      .do_IRQ
-	b       .ret_from_except
+	b	.ret_from_except_lite
 
+	.align	7
 	.globl Alignment_common
 Alignment_common:
-	EXCEPTION_PROLOG_COMMON
+	mfspr	r10,DAR
+	std	r10,PACA_EXGEN+EX_DAR(r13)
+	mfspr	r10,DSISR
+	stw	r10,PACA_EXGEN+EX_DSISR(r13)
+	EXCEPTION_PROLOG_COMMON(0x600, PACA_EXGEN)
+	ld	r3,PACA_EXGEN+EX_DAR(r13)
+	lwz	r4,PACA_EXGEN+EX_DSISR(r13)
+	std	r3,_DAR(r1)
+	std	r4,_DSISR(r1)
+	bl	.save_nvgprs
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	DO_COPY_EE()
-	li	r6,0x600
-	bl      .save_remaining_regs
+	ENABLE_INTS
 	bl      .AlignmentException
 	b       .ret_from_except
 
+	.align	7
 	.globl ProgramCheck_common
 ProgramCheck_common:
-	EXCEPTION_PROLOG_COMMON
+	EXCEPTION_PROLOG_COMMON(0x700, PACA_EXGEN)
+	bl	.save_nvgprs
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	DO_COPY_EE()
-	li	r6,0x700
-	bl      .save_remaining_regs
+	ENABLE_INTS
 	bl      .ProgramCheckException
 	b       .ret_from_except
 
+	.align	7
 	.globl FPUnavailable_common
 FPUnavailable_common:
-	EXCEPTION_PROLOG_COMMON
+	EXCEPTION_PROLOG_COMMON(0x800, PACA_EXGEN)
 	bne	.load_up_fpu		/* if from user, just load it up */
+	bl	.save_nvgprs
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	DO_COPY_EE()
-	li	r6,0x800
-	bl      .save_remaining_regs
+	ENABLE_INTS
 	bl      .KernelFPUnavailableException
 	BUG_OPCODE
 
+	.align	7
 	.globl AltivecUnavailable_common
 AltivecUnavailable_common:
-	EXCEPTION_PROLOG_COMMON
+	EXCEPTION_PROLOG_COMMON(0xf20, PACA_EXGEN)
 #ifdef CONFIG_ALTIVEC
-	bne	.load_up_altivec		/* if from user, just load it up */
+	bne	.load_up_altivec	/* if from user, just load it up */
 #endif
+	bl	.save_nvgprs
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	DO_COPY_EE()
-	li	r6,0xf20
-	bl      .save_remaining_regs
-#ifdef CONFIG_ALTIVEC
-	bl	.KernelAltivecUnavailableException
-#else
-	bl      .UnknownException
-#endif
-	BUG_OPCODE
+	ENABLE_INTS
+	bl	.AltivecUnavailableException
+	b	.ret_from_except
 		
-	.globl SystemCall_common
-SystemCall_common:
-	EXCEPTION_PROLOG_COMMON
-#ifdef CONFIG_PPC_ISERIES
-	cmpi	0,r0,0x5555		/* Special syscall to handle pending */
-	bne+	1f			/* interrupts */
-	andi.	r6,r23,MSR_PR		/* Only allowed from kernel */
-	beq+	HardwareInterrupt_entry
-1:
-#endif
-	DO_COPY_EE()
-	li	r6,0xC00
-	bl      .save_remaining_regs
-	bl      .DoSyscall
-	b       .ret_from_except
+/*
+ * Hash table stuff
+ */
+	.align	7
+_GLOBAL(do_hash_page)
+	std	r3,_DAR(r1)
+	std	r4,_DSISR(r1)
+
+	andis.	r0,r4,0xa450		/* weird error? */
+	bne-	.handle_page_fault	/* if not, try to insert a HPTE */
+BEGIN_FTR_SECTION
+	andis.	r0,r4,0x0020		/* Is it a segment table fault? */
+	bne-	.do_ste_alloc		/* If so handle it */
+END_FTR_SECTION_IFCLR(CPU_FTR_SLB)
 
-_GLOBAL(do_hash_page_ISI)
-	li	r4,0
-_GLOBAL(do_hash_page_DSI)
 	/*
 	 * We need to set the _PAGE_USER bit if MSR_PR is set or if we are
 	 * accessing a userspace segment (even from the kernel). We assume
 	 * kernel addresses always have the high bit set.
 	 */
-	rotldi	r0,r3,15		/* Move high bit into MSR_PR position */
-	orc	r0,r23,r0
-	rlwimi	r4,r0,32-13,30,30	/* Insert into _PAGE_USER */
+	rlwinm	r4,r4,32-23,29,29	/* DSISR_STORE -> _PAGE_RW */
+	rotldi	r0,r3,15		/* Move high bit into MSR_PR posn */
+	orc	r0,r12,r0		/* MSR_PR | ~high_bit */
+	rlwimi	r4,r0,32-13,30,30	/* becomes _PAGE_USER access bit */
 	ori	r4,r4,1			/* add _PAGE_PRESENT */
 
-	mflr	r21			/* Save LR in r21 */
-
-#ifdef DO_SOFT_DISABLE
 	/*
-	 * We hard enable here (but first soft disable) so that the hash_page
-	 * code can spin on the hash_table_lock with problem on a shared
-	 * processor.
+	 * On iSeries, we soft-disable interrupts here, then
+	 * hard-enable interrupts so that the hash_page code can spin on
+	 * the hash_table_lock without problems on a shared processor.
 	 */
-	li	r0,0
-	stb	r0,PACAPROCENABLED(r20)	/* Soft Disabled */
-
-	mfmsr	r0
-	ori	r0,r0,MSR_EE
-	mtmsrd	r0,1			/* Hard Enable */
-#endif
+	DISABLE_INTS
 
 	/*
 	 * r3 contains the faulting address
@@ -937,184 +1002,159 @@
 	 *
 	 * at return r3 = 0 for success
 	 */
-
 	bl	.hash_page		/* build HPTE if possible */
+	cmpdi	r3,0			/* see if hash_page succeeded */
 
 #ifdef DO_SOFT_DISABLE
 	/*
-	 * Now go back to hard disabled.
+	 * If we had interrupts soft-enabled at the point where the
+	 * DSI/ISI occurred, and an interrupt came in during hash_page,
+	 * handle it now.
+	 * We jump to ret_from_except_lite rather than fast_exception_return
+	 * because ret_from_except_lite will check for and handle pending
+	 * interrupts if necessary.
 	 */
-	mfmsr	r0
-	li	r4,0
-	ori	r4,r4,MSR_EE
-	andc	r0,r0,r4
-	mtmsrd	r0,1			/* Hard Disable */
-
-	ld	r0,SOFTE(r1)
-	cmpdi	0,r0,0			/* See if we will soft enable in */
-					/* save_remaining_regs */
-	beq	5f
-	CHECKANYINT(r4,r5)
-	bne-	HardwareInterrupt_entry	/* Convert this DSI into an External */
-					/* to process interrupts which occurred */
-					/* during hash_page */
-5:
-	stb	r0,PACAPROCENABLED(r20)	/* Restore soft enable/disable status */
+	beq	.ret_from_except_lite
+	/*
+	 * hash_page couldn't handle it, set soft interrupt enable back
+	 * to what it was before the trap.  Note that .local_irq_restore
+	 * handles any interrupts pending at this point.
+	 */
+	ld	r3,SOFTE(r1)
+	bl	.local_irq_restore
+	b	11f
+#else
+	beq+	fast_exception_return   /* Return from exception on success */
+	/* fall through */
 #endif
-	or.	r3,r3,r3		/* Check return code */
-	beq     fast_exception_return   /* Return from exception on success */
 
-	mtlr    r21                     /* restore LR */
-	blr                             /* Return to DSI or ISI on failure */
+/* Here we have a page fault that hash_page can't handle. */
+_GLOBAL(handle_page_fault)
+	ENABLE_INTS
+11:	ld	r4,_DAR(r1)
+	ld	r5,_DSISR(r1)
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	.do_page_fault
+	cmpdi	r3,0
+	beq+	.ret_from_except_lite
+	bl	.save_nvgprs
+	mr	r5,r3
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	lwz	r4,_DAR(r1)
+	bl	.bad_page_fault
+	b	.ret_from_except
+
+	/* here we have a segment miss */
+_GLOBAL(do_ste_alloc)
+	bl	.ste_allocate		/* try to insert stab entry */
+	cmpdi	r3,0
+	beq+	fast_exception_return
+	b	.handle_page_fault
 
 /*
- * r20 points to the PACA, r21 to the exception frame,
- * r23 contains the saved CR.
- * r20 - r23, SRR0 and SRR1 are saved in the exception frame.
+ * r13 points to the PACA, r9 contains the saved CR,
+ * r11 and r12 contain the saved SRR0 and SRR1.
+ * r9 - r13 are saved in paca->exslb.
  * We assume we aren't going to take any exceptions during this procedure.
+ * We assume (DAR >> 60) == 0xc.
  */
+	.align	7
 _GLOBAL(do_stab_bolted)
-	stw	r23,EX_CCR(r21)	/* save CR in exc. frame */
+	stw	r9,PACA_EXSLB+EX_CCR(r13)	/* save CR in exc. frame */
+	std	r11,PACA_EXSLB+EX_SRR0(r13)	/* save SRR0 in exc. frame */
 
-	mfspr   r22,DSISR
-	andis.  r22,r22,0x0020
-	beq-	stab_bolted_user_return
+	/* Hash to the primary group */
+	ld	r10,PACASTABVIRT(r13)
+	mfspr	r11,DAR
+	srdi	r11,r11,28
+	rldimi	r10,r11,7,52	/* r10 = first ste of the group */
 
+	/* Calculate VSID */
 	/* (((ea >> 28) & 0x1fff) << 15) | (ea >> 60) */
-	mfspr	r21,DAR
-	rldicl	r20,r21,36,51
-	sldi	r20,r20,15
-	srdi	r21,r21,60
-	or	r20,r20,r21
+	rldic	r11,r11,15,36
+	ori	r11,r11,0xc
 
 	/* VSID_RANDOMIZER */
-	li      r21,9
-	sldi    r21,r21,32
-	oris    r21,r21,58231
-	ori     r21,r21,39831
+	li	r9,9
+	sldi	r9,r9,32
+	oris	r9,r9,58231
+	ori	r9,r9,39831
 
-	mulld   r20,r20,r21
-	clrldi  r20,r20,28      /* r20 = vsid */
-
-	mfsprg  r21,3
-	ld      r21,PACASTABVIRT(r21)
-
-	/* Hash to the primary group */
-	mfspr	r22,DAR
-	rldicl  r22,r22,36,59
-	rldicr  r22,r22,7,56
-	or      r21,r21,r22     /* r21 = first ste of the group */
+	mulld	r9,r11,r9
+	rldic	r9,r9,12,16	/* r9 = vsid << 12 */
 
 	/* Search the primary group for a free entry */
-	li      r22,0
-1:
-	ld      r23,0(r21)      /* Test valid bit of the current ste   */
-	rldicl  r23,r23,57,63
-	cmpwi   r23,0
-	bne     2f
-	li	r23,0
-	rldimi  r23,r20,12,0    /* Insert the new vsid value            */
-	std     r23,8(r21)      /* Put new entry back into the stab     */
-	eieio                  /* Order vsid update                    */
-	li	r23,0
-	mfspr	r20,DAR        /* Get the new esid                     */
-	rldicl  r20,r20,36,28  /* Permits a full 36b of ESID           */
-	rldimi  r23,r20,28,0    /* Insert the new esid value            */
-	ori     r23,r23,144      /* Turn on valid and kp                 */
-	std     r23,0(r21)      /* Put new entry back into the stab     */
-	sync                   /* Order the update                     */
-	b       3f
-2:
-	addi    r22,r22,1
-	addi    r21,r21,16
-	cmpldi  r22,7
-	ble     1b
+1:	ld	r11,0(r10)	/* Test valid bit of the current ste	*/
+	andi.	r11,r11,0x80
+	beq	2f
+	addi	r10,r10,16
+	andi.	r11,r10,0x70
+	bne	1b
 
 	/* Stick for only searching the primary group for now.          */
 	/* At least for now, we use a very simple random castout scheme */
 	/* Use the TB as a random number ;  OR in 1 to avoid entry 0    */
-	mftb    r22
-	andi.   r22,r22,7
-	ori	r22,r22,1
-	sldi	r22,r22,4
+	mftb	r11
+	rldic	r11,r11,4,57	/* r11 = (r11 << 4) & 0x70 */
+	ori	r11,r11,0x10
 
-	/* r21 currently points to and ste one past the group of interest */
+	/* r10 currently points to an ste one past the group of interest */
 	/* make it point to the randomly selected entry                   */
-	subi	r21,r21,128
-	or 	r21,r21,r22      /* r21 is the entry to invalidate        */
+	subi	r10,r10,128
+	or 	r10,r10,r11	/* r10 is the entry to invalidate	*/
 
 	isync                    /* mark the entry invalid                */
-	ld      r23,0(r21)
-	li      r22,-129
-	and     r23,r23,r22
-	std     r23,0(r21)
+	ld	r11,0(r10)
+	rldicl	r11,r11,56,1	/* clear the valid bit */
+	rotldi	r11,r11,8
+	std	r11,0(r10)
 	sync
 
-	li	r23,0
-	rldimi  r23,r20,12,0
-	std     r23,8(r21)
+	clrrdi	r11,r11,28	/* Get the esid part of the ste		*/
+	slbie	r11
+
+2:	std	r9,8(r10)	/* Store the vsid part of the ste	*/
 	eieio
 
-	ld	r22,0(r21)	/* Get the esid part of the ste         */
-	li	r23,0
-	mfspr	r20,DAR         /* Get the new esid                     */
-	rldicl  r20,r20,36,28   /* Permits a full 32b of ESID           */
-	rldimi  r23,r20,28,0    /* Insert the new esid value            */
-	ori     r23,r23,144     /* Turn on valid and kp                 */
-	std     r23,0(r21)      /* Put new entry back into the stab     */
-
-	rldicl  r22,r22,36,28
-	rldicr  r22,r22,28,35
-	slbie   r22
+	mfspr	r11,DAR		/* Get the new esid			*/
+	clrrdi	r11,r11,28	/* Permits a full 32b of ESID		*/
+	ori	r11,r11,0x90	/* Turn on valid and kp			*/
+	std	r11,0(r10)	/* Put new entry back into the stab	*/
+
 	sync
 
-3:
 	/* All done -- return from exception. */
-	mfsprg  r20,3                   /* Load the PACA pointer  */
-	ld      r21,PACAEXCSP(r20)      /* Get the exception frame pointer */
-	addi    r21,r21,EXC_FRAME_SIZE
-	lwz	r23,EX_CCR(r21)		/* get saved CR */
-
-	ld	r22,EX_SRR1(r21)
-	andi.	r22,r22,MSR_RI
-	beq-	unrecov_stab
-
-	/* note that this is almost identical to maskable_exception_exit */
-	mtcr    r23                     /* restore CR */
-
-	mfmsr	r22
-	li	r23, MSR_RI
-	andc	r22,r22,r23
-	mtmsrd	r22,1
-
-	ld	r22,EX_SRR0(r21)	/* Get SRR0 from exc. frame */
-	ld	r23,EX_SRR1(r21)	/* Get SRR1 from exc. frame */
-	mtspr	SRR0,r22
-	mtspr   SRR1,r23
-	ld	r22,EX_R22(r21)		/* restore r22 and r23 */
-	ld	r23,EX_R23(r21)
-	mfspr	r20,SPRG2
-	mfspr	r21,SPRG1
-	rfid
+	lwz	r9,PACA_EXSLB+EX_CCR(r13)	/* get saved CR */
+	ld	r11,PACA_EXSLB+EX_SRR0(r13)	/* get saved SRR0 */
 
-unrecov_stab:
-	EXCEPTION_PROLOG_COMMON
-	li	r6,0x4100
-	li	r20,0
-	bl	.save_remaining_regs
-1:	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	.unrecoverable_exception
-	b	1b
+	andi.	r10,r12,MSR_RI
+	beq-	unrecov_slb
+
+	mtcrf	0x80,r9			/* restore CR */
+
+	mfmsr	r10
+	clrrdi	r10,r10,2
+	mtmsrd	r10,1
+
+	mtspr	SRR0,r11
+	mtspr	SRR1,r12
+	ld	r9,PACA_EXSLB+EX_R9(r13)
+	ld	r10,PACA_EXSLB+EX_R10(r13)
+	ld	r11,PACA_EXSLB+EX_R11(r13)
+	ld	r12,PACA_EXSLB+EX_R12(r13)
+	ld	r13,PACA_EXSLB+EX_R13(r13)
+	rfid
 
 /*
- * r20 points to the PACA, r21 to the exception frame,
- * r23 contains the saved CR.
- * r20 - r23, SRR0 and SRR1 are saved in the exception frame.
+ * r13 points to the PACA, r9 contains the saved CR,
+ * r11 and r12 contain the saved SRR0 and SRR1.
+ * r9 - r13 are saved in paca->exslb.
  * We assume we aren't going to take any exceptions during this procedure.
  */
 /* XXX note fix masking in get_kernel_vsid to match */
 _GLOBAL(do_slb_bolted)
-	stw	r23,EX_CCR(r21)		/* save CR in exc. frame */
+	stw	r9,PACA_EXSLB+EX_CCR(r13)	/* save CR in exc. frame */
+	std	r11,PACA_EXSLB+EX_SRR0(r13)	/* save SRR0 in exc. frame */
 
 	/*
 	 * We take the next entry, round robin. Previously we tried
@@ -1122,15 +1162,15 @@
 	 * we dont have any LRU information to help us choose a slot.
 	 */
 
-	/* r20 = paca */
-1:	ld	r22,PACASTABRR(r20)
-	addi	r21,r22,1
-	cmpdi	r21,SLB_NUM_ENTRIES
+	/* r13 = paca */
+1:	ld	r10,PACASTABRR(r13)
+	addi	r9,r10,1
+	cmpdi	r9,SLB_NUM_ENTRIES
 	blt+	2f
-	li	r21,2			/* dont touch slot 0 or 1 */
-2:	std	r21,PACASTABRR(r20)
+	li	r9,2			/* dont touch slot 0 or 1 */
+2:	std	r9,PACASTABRR(r13)
 
-	/* r20 = paca, r22 = entry */
+	/* r13 = paca, r10 = entry */
 
 	/* 
 	 * Never cast out the segment for our kernel stack. Since we
@@ -1139,8 +1179,8 @@
 	 * which gets invalidated due to a tlbie from another cpu at a
 	 * non recoverable point (after setting srr0/1) - Anton
 	 */
-	slbmfee	r21,r22
-	srdi	r21,r21,27
+	slbmfee	r9,r10
+	srdi	r9,r9,27
 	/*
 	 * Use paca->ksave as the value of the kernel stack pointer,
 	 * because this is valid at all times.
@@ -1150,74 +1190,71 @@
 	 * switch (between updating r1 and updating paca->ksave),
 	 * we check against both r1 and paca->ksave.
 	 */
-	srdi	r23,r1,27
-	ori	r23,r23,1
-	cmpd	r23,r21
+	srdi	r11,r1,27
+	ori	r11,r11,1
+	cmpd	r11,r9
 	beq-	1b
-	ld	r23,PACAKSAVE(r20)
-	srdi	r23,r23,27
- 	ori	r23,r23,1
- 	cmpd	r23,r21
+	ld	r11,PACAKSAVE(r13)
+	srdi	r11,r11,27
+ 	ori	r11,r11,1
+ 	cmpd	r11,r9
  	beq-	1b
 
-	/* r20 = paca, r22 = entry */
+	/* r13 = paca, r10 = entry */
 
 	/* (((ea >> 28) & 0x1fff) << 15) | (ea >> 60) */
-	mfspr	r21,DAR
-	rldicl	r23,r21,36,51
-	sldi	r23,r23,15
-	srdi	r21,r21,60
-	or	r23,r23,r21
+	mfspr	r9,DAR
+	rldicl	r11,r9,36,51
+	sldi	r11,r11,15
+	srdi	r9,r9,60
+	or	r11,r11,r9
 
 	/* VSID_RANDOMIZER */
-	li	r21,9
-	sldi	r21,r21,32
-	oris	r21,r21,58231
-	ori	r21,r21,39831
+	li	r9,9
+	sldi	r9,r9,32
+	oris	r9,r9,58231
+	ori	r9,r9,39831
 
 	/* vsid = (ordinal * VSID_RANDOMIZER) & VSID_MASK */
-	mulld	r23,r23,r21
-	clrldi	r23,r23,28
+	mulld	r11,r11,r9
+	clrldi	r11,r11,28
 
-	/* r20 = paca, r22 = entry, r23 = vsid */
+	/* r13 = paca, r10 = entry, r11 = vsid */
 
 	/* Put together slb word1 */
-	sldi	r23,r23,12
+	sldi	r11,r11,12
 
 BEGIN_FTR_SECTION
 	/* set kp and c bits */
-	ori	r23,r23,0x480
+	ori	r11,r11,0x480
 END_FTR_SECTION_IFCLR(CPU_FTR_16M_PAGE)
 BEGIN_FTR_SECTION
 	/* set kp, l and c bits */
-	ori	r23,r23,0x580
+	ori	r11,r11,0x580
 END_FTR_SECTION_IFSET(CPU_FTR_16M_PAGE)
 
-	/* r20 = paca, r22 = entry, r23 = slb word1 */
+	/* r13 = paca, r10 = entry, r11 = slb word1 */
 
 	/* Put together slb word0 */
-	mfspr	r21,DAR
-	rldicr	r21,r21,0,35	/* get the new esid */
-	oris	r21,r21,2048	/* set valid bit */
-	rldimi	r21,r22,0,52	/* insert entry */
+	mfspr	r9,DAR
+	clrrdi	r9,r9,28	/* get the new esid */
+	oris	r9,r9,0x800	/* set valid bit */
+	rldimi	r9,r10,0,52	/* insert entry */
 
-	/* r20 = paca, r21 = slb word0, r23 = slb word1 */
+	/* r13 = paca, r9 = slb word0, r11 = slb word1 */
 
 	/* 
 	 * No need for an isync before or after this slbmte. The exception
 	 * we enter with and the rfid we exit with are context synchronizing .
 	 */
-	slbmte	r23,r21
+	slbmte	r11,r9
 
 	/* All done -- return from exception. */
-	ld	r21,PACAEXCSP(r20)	/* Get the exception frame pointer */
-	addi	r21,r21,EXC_FRAME_SIZE
-	lwz	r23,EX_CCR(r21)		/* get saved CR */
-	/* note that this is almost identical to maskable_exception_exit */
-
-	ld	r22,EX_SRR1(r21)
-	andi.	r22,r22,MSR_RI
-	beq-	unrecov_stab
+	lwz	r9,PACA_EXSLB+EX_CCR(r13)	/* get saved CR */
+	ld	r11,PACA_EXSLB+EX_SRR0(r13)	/* get saved SRR0 */
+
+	andi.	r10,r12,MSR_RI	/* check for unrecoverable exception */
+	beq-	unrecov_slb
 
 	/*
 	 * Until everyone updates binutils hardwire the POWER4 optimised
@@ -1226,124 +1263,32 @@
 #if 0
 	.machine	push
 	.machine	"power4"
-	mtcrf	0x80,r23
+	mtcrf	0x80,r9
 	.machine	pop
 #else
-	.long 0x7ef80120
+	.long 0x7d380120
 #endif
 
-	mfmsr	r22
-	li	r23, MSR_RI
-	andc	r22,r22,r23
-	mtmsrd	r22,1
-
-	ld	r22,EX_SRR0(r21)	/* Get SRR0 from exc. frame */
-	ld	r23,EX_SRR1(r21)	/* Get SRR1 from exc. frame */
-	mtspr	SRR0,r22
-	mtspr	SRR1,r23
-	ld	r22,EX_R22(r21)		/* restore r22 and r23 */
-	ld	r23,EX_R23(r21)
-	ld	r20,EX_R20(r21)
-	mfspr	r21,SPRG1
+	mfmsr	r10
+	clrrdi	r10,r10,2
+	mtmsrd	r10,1
+
+	mtspr	SRR0,r11
+	mtspr	SRR1,r12
+	ld	r9,PACA_EXSLB+EX_R9(r13)
+	ld	r10,PACA_EXSLB+EX_R10(r13)
+	ld	r11,PACA_EXSLB+EX_R11(r13)
+	ld	r12,PACA_EXSLB+EX_R12(r13)
+	ld	r13,PACA_EXSLB+EX_R13(r13)
 	rfid
 
-_GLOBAL(do_stab_SI)
-	mflr	r21			/* Save LR in r21 */
-
-	/*
-	 * r3 contains the faulting address
-	 * r4 contains the required access permissions
-	 *
-	 * at return r3 = 0 for success
-	 */
-
-	bl	.ste_allocate		/* build STE if possible */
-	or.	r3,r3,r3		/* Check return code */
-	beq     fast_exception_return   /* Return from exception on success */
-	mtlr    r21                     /* restore LR */
-	blr                             /* Return to DSI or ISI on failure */
-
-/*
- * This code finishes saving the registers to the exception frame.
- * Address translation is already on.
- */
-_GLOBAL(save_remaining_regs)
-	/*
-	 * Save the rest of the registers into the pt_regs structure
-	 */
-	std     r22,_NIP(r1)
-	std     r23,_MSR(r1)
-	std     r6,TRAP(r1)
-	ld      r6,GPR6(r1)
-	SAVE_2GPRS(14, r1)
-	SAVE_4GPRS(16, r1)
-	SAVE_8GPRS(24, r1)
-
-	/* Set the marker value "regshere" just before the reg values */
-	SET_REG_TO_CONST(r22, 0x7265677368657265)
-	std	r22,STACK_FRAME_OVERHEAD-16(r1)
-
-	/*
-	 * Clear the RESULT field
-	 */
-	li	r22,0
-	std	r22,RESULT(r1)
-
-	/*
-	 * Test if from user state; result will be tested later
-	 */
-	andi.	r23,r23,MSR_PR		/* Set CR for later branch */
-
-	/*
-	 * Indicate that r1 contains the kernel stack and
-	 * get the Kernel TOC pointer from the paca
-	 */
-	ld	r2,PACATOC(r13)		/* Get Kernel TOC pointer */
-
-	/*
-	 * If from user state, update THREAD.regs
-	 */
-	beq	2f			/* Modify THREAD.regs if from user */
-	addi	r23,r1,STACK_FRAME_OVERHEAD
-	ld	r22, PACACURRENT(r13)
-	std	r23,THREAD+PT_REGS(r22)
-2:
-	SET_REG_TO_CONST(r22, MSR_KERNEL)
-
-#ifdef DO_SOFT_DISABLE
-	stb	r20,PACAPROCENABLED(r13) /* possibly soft enable */
-	ori	r22,r22,MSR_EE		/* always hard enable */
-#else
-	rldimi	r22,r20,15,48		/* Insert desired EE value */
-#endif
-
-	mtmsrd  r22,1
-	blr
-
-/*
- * Kernel profiling with soft disable on iSeries
- */
-do_profile:
-	ld	r22,8(r21)		/* Get SRR1 */
-	andi.	r22,r22,MSR_PR		/* Test if in kernel */
-	bnelr				/* return if not in kernel */
-	ld	r22,0(r21)		/* Get SRR0 */
-	ld	r25,PACAPROFSTEXT(r20)	/* _stext */
-	subf	r22,r25,r22		/* offset into kernel */
-	lwz	r25,PACAPROFSHIFT(r20)
-	srd	r22,r22,r25
-	lwz	r25,PACAPROFLEN(r20)	/* length of profile table (-1) */
-	cmp	0,r22,r25		/* off end? */
-	ble	1f
-	mr	r22,r25			/* force into last entry */
-1:	sldi	r22,r22,2		/* convert to offset into buffer */
-	ld	r25,PACAPROFBUFFER(r20)	/* profile buffer */
-	add	r25,r25,r22
-2:	lwarx	r22,0,r25		/* atomically increment */
-	addi	r22,r22,1
-	stwcx.	r22,0,r25
-	bne-	2b
-	blr
+unrecov_slb:
+	EXCEPTION_PROLOG_COMMON(0x4100, PACA_EXSLB)
+	DISABLE_INTS
+	bl	.save_nvgprs
+1:	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	.unrecoverable_exception
+	b	1b
 
 
 /*
@@ -1375,7 +1320,7 @@
         addi    r1,r1,0x1000
         subi    r1,r1,STACK_FRAME_OVERHEAD
 
-	cmpi	0,r23,0
+	cmpwi	0,r23,0
 #ifdef CONFIG_SMP
 #ifdef SECONDARY_PROCESSORS
 	bne	.__secondary_start
@@ -1594,9 +1539,9 @@
  *
  */
 #ifndef CONFIG_SMP
-	LOADBASE(r3,last_task_used_math)
-	ld	r4,last_task_used_math@l(r3)
-	cmpi	0,r4,0
+	ld	r3,last_task_used_math@got(r2)
+	ld	r4,0(r3)
+	cmpdi	0,r4,0
 	beq	1f
 	/* Save FP state to last_task_used_math's THREAD struct */
 	addi	r4,r4,THREAD
@@ -1606,8 +1551,8 @@
 	/* Disable FP for last_task_used_math */
 	ld	r5,PT_REGS(r4)
 	ld	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
-	li	r20,MSR_FP|MSR_FE0|MSR_FE1
-	andc	r4,r4,r20
+	li	r6,MSR_FP|MSR_FE0|MSR_FE1
+	andc	r4,r4,r6
 	std	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
 1:
 #endif /* CONFIG_SMP */
@@ -1615,15 +1560,16 @@
 	ld	r4,PACACURRENT(r13)
 	addi	r5,r4,THREAD		/* Get THREAD */
 	ld	r4,THREAD_FPEXC_MODE(r5)
-	ori	r23,r23,MSR_FP
-	or	r23,r23,r4
+	ori	r12,r12,MSR_FP
+	or	r12,r12,r4
+	std	r12,_MSR(r1)
 	lfd	fr0,THREAD_FPSCR(r5)
 	mtfsf	0xff,fr0
 	REST_32FPRS(0, r5)
 #ifndef CONFIG_SMP
 	/* Update last_task_used_math to 'current' */
 	subi	r4,r5,THREAD		/* Back to 'current' */
-	std	r4,last_task_used_math@l(r3)
+	std	r4,0(r3)
 #endif /* CONFIG_SMP */
 	/* restore registers and return */
 	b	fast_exception_return
@@ -1651,11 +1597,11 @@
 	ori	r5,r5,MSR_FP
 	mtmsrd	r5			/* enable use of fpu now */
 	isync
-	cmpi	0,r3,0
+	cmpdi	0,r3,0
 	beqlr-				/* if no previous owner, done */
 	addi	r3,r3,THREAD		/* want THREAD of task */
 	ld	r5,PT_REGS(r3)
-	cmpi	0,r5,0
+	cmpdi	0,r5,0
 	SAVE_32FPRS(0, r3)
 	mffs	fr0
 	stfd	fr0,THREAD_FPSCR(r3)
@@ -1667,8 +1613,8 @@
 1:
 #ifndef CONFIG_SMP
 	li	r5,0
-	LOADBASE(r4,last_task_used_math)
-	std	r5,last_task_used_math@l(r4)
+	ld	r4,last_task_used_math@got(r2)
+	std	r5,0(r4)
 #endif /* CONFIG_SMP */
 	blr
 
@@ -1699,9 +1645,9 @@
  * avoid saving all of the VREGs here...
  */
 #ifndef CONFIG_SMP
-	LOADBASE(r3,last_task_used_altivec)
-	ld	r4,last_task_used_altivec@l(r3)
-	cmpi	0,r4,0
+	ld	r3,last_task_used_altivec@got(r2)
+	ld	r4,0(r3)
+	cmpdi	0,r4,0
 	beq	1f
 	/* Save VMX state to last_task_used_altivec's THREAD struct */
 	addi	r4,r4,THREAD
@@ -1712,8 +1658,8 @@
 	/* Disable VMX for last_task_used_altivec */
 	ld	r5,PT_REGS(r4)
 	ld	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
-	lis	r20,MSR_VEC@h
-	andc	r4,r4,r20
+	lis	r6,MSR_VEC@h
+	andc	r4,r4,r6
 	std	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
 1:
 #endif /* CONFIG_SMP */
@@ -1723,7 +1669,7 @@
 	 * all 1's
 	 */
 	mfspr	r4,SPRN_VRSAVE
-	cmpi	0,r4,0
+	cmpdi	0,r4,0
 	bne+	1f
 	li	r4,-1
 	mtspr	SPRN_VRSAVE,r4
@@ -1731,7 +1677,8 @@
 	/* enable use of VMX after return */
 	ld	r4,PACACURRENT(r13)
 	addi	r5,r4,THREAD		/* Get THREAD */
-	oris	r23,r23,MSR_VEC@h
+	oris	r12,r12,MSR_VEC@h
+	std	r12,_MSR(r1)
 	li	r4,1
 	li	r10,THREAD_VSCR
 	stw	r4,THREAD_USED_VR(r5)
@@ -1740,7 +1687,7 @@
 #ifndef CONFIG_SMP
 	/* Update last_task_used_math to 'current' */
 	subi	r4,r5,THREAD		/* Back to 'current' */
-	std	r4,last_task_used_altivec@l(r3)
+	std	r4,0(r3)
 #endif /* CONFIG_SMP */
 	/* restore registers and return */
 	b	fast_exception_return
@@ -1768,11 +1715,11 @@
 	oris	r5,r5,MSR_VEC@h
 	mtmsrd	r5			/* enable use of VMX now */
 	isync
-	cmpi	0,r3,0
+	cmpdi	0,r3,0
 	beqlr-				/* if no previous owner, done */
 	addi	r3,r3,THREAD		/* want THREAD of task */
 	ld	r5,PT_REGS(r3)
-	cmpi	0,r5,0
+	cmpdi	0,r5,0
 	SAVE_32VRS(0,r4,r3)
 	mfvscr	vr0
 	li	r4,THREAD_VSCR
@@ -1785,8 +1732,8 @@
 1:
 #ifndef CONFIG_SMP
 	li	r5,0
-	LOADBASE(r4,last_task_used_altivec)
-	std	r5,last_task_used_altivec@l(r4)
+	ld	r4,last_task_used_altivec@got(r2)
+	std	r5,0(r4)
 #endif /* CONFIG_SMP */
 	blr
 
@@ -1885,8 +1832,9 @@
 	LOADADDR(r3,current_set)
 	sldi	r28,r24,3		/* get current_set[cpu#] */
 	ldx	r1,r3,r28
-	addi	r1,r1,THREAD_SIZE
-	subi	r1,r1,STACK_FRAME_OVERHEAD
+	addi	r1,r1,THREAD_SIZE-STACK_FRAME_OVERHEAD
+	li	r0,0
+	std	r0,0(r1)
 	std	r1,PACAKSAVE(r13)
 
 	ld	r3,PACASTABREAL(r13)    /* get raddr of segment table       */
@@ -1943,7 +1891,7 @@
 #endif
 
 /*
- * This subroutine clobbers r11, r12 and the LR
+ * This subroutine clobbers r11 and r12
  */
 _GLOBAL(enable_64b_mode)
 	mfmsr   r11                      /* grab the current MSR */
@@ -2144,7 +2092,6 @@
 	std	r4,PACACURRENT(r13)
 
 	std	r2,PACATOC(r13)
-	li	r5,0
 	std	r1,PACAKSAVE(r13)
 
 	/* Restore the parms passed in from the bootloader. */
diff -urN preempt/arch/ppc64/kernel/misc.S test25/arch/ppc64/kernel/misc.S
--- preempt/arch/ppc64/kernel/misc.S	2004-05-26 07:58:59.000000000 +1000
+++ test25/arch/ppc64/kernel/misc.S	2004-06-17 15:46:06.000000000 +1000
@@ -85,16 +85,17 @@
 	cmpw	0,r3,r5
 	beqlr
 	/* are we enabling interrupts? */
-	cmpi	0,r3,0
+	cmpdi	0,r3,0
 	stb	r3,PACAPROCENABLED(r13)
 	beqlr
 	/* Check pending interrupts */
 	/*   A decrementer, IPI or PMC interrupt may have occurred
 	 *   while we were in the hypervisor (which enables) */
-	CHECKANYINT(r4,r5)
+	ld	r4,PACALPPACA+LPPACAANYINT(r13)
+	cmpdi	r4,0
 	beqlr
 
-	/* 
+	/*
 	 * Handle pending interrupts in interrupt context
 	 */
 	li	r0,0x5555
@@ -608,7 +609,7 @@
 _GLOBAL(sys_call_table32)
 	.llong .sys_restart_syscall	/* 0 */
 	.llong .sys_exit
-	.llong .sys_fork
+	.llong .ppc_fork
 	.llong .sys_read
 	.llong .sys_write
 	.llong .sys32_open		/* 5 */
@@ -678,7 +679,7 @@
 	.llong .sys32_ssetmask
 	.llong .sys_setreuid	        /* 70 */
 	.llong .sys_setregid
-	.llong .sys32_sigsuspend
+	.llong .ppc32_sigsuspend
 	.llong .compat_sys_sigpending
 	.llong .sys32_sethostname
 	.llong .compat_sys_setrlimit	        /* 75 */
@@ -726,7 +727,7 @@
 	.llong .sys32_ipc
 	.llong .sys_fsync
 	.llong .ppc32_sigreturn
-	.llong .sys_clone		/* 120 */
+	.llong .ppc_clone		/* 120 */
 	.llong .sys32_setdomainname
 	.llong .ppc64_newuname
 	.llong .sys_ni_syscall		/* old modify_ldt syscall */
@@ -784,7 +785,7 @@
 	.llong .sys32_rt_sigpending     /* 175 */
 	.llong .sys32_rt_sigtimedwait
 	.llong .sys32_rt_sigqueueinfo
-	.llong .sys32_rt_sigsuspend
+	.llong .ppc32_rt_sigsuspend
 	.llong .sys32_pread64
 	.llong .sys32_pwrite64	        /* 180 */
 	.llong .sys_chown
@@ -795,7 +796,7 @@
 	.llong .sys32_sendfile
 	.llong .sys_ni_syscall		/* reserved for streams1 */
 	.llong .sys_ni_syscall		/* reserved for streams2 */
-	.llong .sys_vfork
+	.llong .ppc_vfork
 	.llong .compat_sys_getrlimit	        /* 190 */
 	.llong .sys32_readahead
 	.llong .sys32_mmap2
@@ -880,7 +881,7 @@
 _GLOBAL(sys_call_table)
 	.llong .sys_restart_syscall	/* 0 */
 	.llong .sys_exit
-	.llong .sys_fork
+	.llong .ppc_fork
 	.llong .sys_read
 	.llong .sys_write
 	.llong .sys_open		/* 5 */
@@ -998,7 +999,7 @@
 	.llong .sys_ipc
 	.llong .sys_fsync
 	.llong .sys_ni_syscall
-	.llong .sys_clone		/* 120 */
+	.llong .ppc_clone		/* 120 */
 	.llong .sys_setdomainname
 	.llong .ppc64_newuname
 	.llong .sys_ni_syscall		/* old modify_ldt syscall */
@@ -1056,7 +1057,7 @@
 	.llong .sys_rt_sigpending	/* 175 */
 	.llong .sys_rt_sigtimedwait
 	.llong .sys_rt_sigqueueinfo
-	.llong .sys_rt_sigsuspend
+	.llong .ppc64_rt_sigsuspend
 	.llong .sys_pread64
 	.llong .sys_pwrite64	        /* 180 */
 	.llong .sys_chown
@@ -1067,7 +1068,7 @@
 	.llong .sys_sendfile64
 	.llong .sys_ni_syscall		/* reserved for streams1 */
 	.llong .sys_ni_syscall		/* reserved for streams2 */
-	.llong .sys_vfork
+	.llong .ppc_vfork
 	.llong .sys_getrlimit	        /* 190 */
 	.llong .sys_readahead
 	.llong .sys_ni_syscall		/* 32bit only mmap2 */
diff -urN preempt/arch/ppc64/kernel/pacaData.c test25/arch/ppc64/kernel/pacaData.c
--- preempt/arch/ppc64/kernel/pacaData.c	2004-06-04 07:19:00.000000000 +1000
+++ test25/arch/ppc64/kernel/pacaData.c	2004-06-17 15:46:06.000000000 +1000
@@ -62,8 +62,6 @@
 		.xDesc = 0xd397d9e2,	/* "LpRS" */			    \
 		.xSize = sizeof(struct ItLpRegSave)			    \
 	},								    \
-	.exception_sp =							    \
-		(&paca[number].exception_stack[0]) - EXC_FRAME_SIZE,	    \
 }
 
 struct paca_struct paca[] __page_aligned = {
diff -urN preempt/arch/ppc64/kernel/process.c test25/arch/ppc64/kernel/process.c
--- preempt/arch/ppc64/kernel/process.c	2004-06-17 15:51:34.000000000 +1000
+++ test25/arch/ppc64/kernel/process.c	2004-06-17 15:46:06.000000000 +1000
@@ -219,6 +219,7 @@
 void show_regs(struct pt_regs * regs)
 {
 	int i;
+	unsigned long trap;
 
 	printk("NIP: %016lX XER: %016lX LR: %016lX\n",
 	       regs->nip, regs->xer, regs->link);
@@ -229,7 +230,8 @@
 	       regs->msr & MSR_FP ? 1 : 0,regs->msr&MSR_ME ? 1 : 0,
 	       regs->msr&MSR_IR ? 1 : 0,
 	       regs->msr&MSR_DR ? 1 : 0);
-	if (regs->trap == 0x300 || regs->trap == 0x380 || regs->trap == 0x600)
+	trap = TRAP(regs);
+	if (trap == 0x300 || trap == 0x380 || trap == 0x600)
 		printk("DAR: %016lx, DSISR: %016lx\n", regs->dar, regs->dsisr);
 	printk("TASK: %p[%d] '%s' THREAD: %p",
 	       current, current->pid, current->comm, current->thread_info);
@@ -244,6 +246,8 @@
 		}
 
 		printk("%016lX ", regs->gpr[i]);
+		if (i == 13 && !FULL_REGS(regs))
+			break;
 	}
 	printk("\n");
 	/*
diff -urN preempt/arch/ppc64/kernel/signal.c test25/arch/ppc64/kernel/signal.c
--- preempt/arch/ppc64/kernel/signal.c	2004-06-17 15:51:34.000000000 +1000
+++ test25/arch/ppc64/kernel/signal.c	2004-06-17 15:46:06.000000000 +1000
@@ -528,13 +528,13 @@
 		struct k_sigaction *ka = &current->sighand->action[signr-1];
 
 		/* Whee!  Actually deliver the signal.  */
-		if (regs->trap == 0x0C00)
+		if (TRAP(regs) == 0x0C00)
 			syscall_restart(regs, ka);
 		handle_signal(signr, ka, &info, oldset, regs);
 		return 1;
 	}
 
-	if (regs->trap == 0x0C00) {	/* System Call! */
+	if (TRAP(regs) == 0x0C00) {	/* System Call! */
 		if ((int)regs->result == -ERESTARTNOHAND ||
 		    (int)regs->result == -ERESTARTSYS ||
 		    (int)regs->result == -ERESTARTNOINTR) {
diff -urN preempt/arch/ppc64/kernel/signal32.c test25/arch/ppc64/kernel/signal32.c
--- preempt/arch/ppc64/kernel/signal32.c	2004-06-17 15:51:34.000000000 +1000
+++ test25/arch/ppc64/kernel/signal32.c	2004-06-17 15:46:06.000000000 +1000
@@ -932,7 +932,7 @@
 
 	ka = (signr == 0)? NULL: &current->sighand->action[signr-1];
 
-	if (regs->trap == 0x0C00		/* System Call! */
+	if (TRAP(regs) == 0x0C00		/* System Call! */
 	    && regs->ccr & 0x10000000		/* error signalled */
 	    && ((ret = regs->gpr[3]) == ERESTARTSYS
 		|| ret == ERESTARTNOHAND || ret == ERESTARTNOINTR
diff -urN preempt/arch/ppc64/kernel/syscalls.c test25/arch/ppc64/kernel/syscalls.c
--- preempt/arch/ppc64/kernel/syscalls.c	2004-05-30 11:50:25.000000000 +1000
+++ test25/arch/ppc64/kernel/syscalls.c	2004-06-17 15:46:06.000000000 +1000
@@ -237,5 +237,19 @@
 	return secs;
 }
 
+void do_show_syscall(unsigned long r3, unsigned long r4, unsigned long r5,
+		     unsigned long r6, unsigned long r7, unsigned long r8,
+		     struct pt_regs *regs)
+{
+	printk("syscall %ld(%lx, %lx, %lx, %lx, %lx, %lx) regs=%p current=%p"
+	       " cpu=%d\n", regs->gpr[0], r3, r4, r5, r6, r7, r8, regs,
+	       current, smp_processor_id());
+}
+
+void do_show_syscall_exit(unsigned long r3)
+{
+	printk(" -> %lx, current=%p cpu=%d\n", r3, current, smp_processor_id());
+}
+
 /* Only exists on P-series. */
 cond_syscall(ppc_rtas);
diff -urN preempt/arch/ppc64/kernel/traps.c test25/arch/ppc64/kernel/traps.c
--- preempt/arch/ppc64/kernel/traps.c	2004-06-17 15:51:34.000000000 +1000
+++ test25/arch/ppc64/kernel/traps.c	2004-06-17 15:46:06.000000000 +1000
@@ -441,8 +441,22 @@
 	die("Unrecoverable FP Unavailable Exception", regs, SIGABRT);
 }
 
-void KernelAltivecUnavailableException(struct pt_regs *regs)
+void AltivecUnavailableException(struct pt_regs *regs)
 {
+#ifndef CONFIG_ALTIVEC
+	if (user_mode(regs)) {
+		/* A user program has executed an altivec instruction,
+		   but this kernel doesn't support altivec. */
+		siginfo_t info;
+
+		memset(&info, 0, sizeof(info));
+		info.si_signo = SIGILL;
+		info.si_code = ILL_ILLOPC;
+		info.si_addr = (void *) regs->nip;
+		_exception(SIGILL, &info, regs);
+		return;
+	}
+#endif
 	printk(KERN_EMERG "Unrecoverable VMX/Altivec Unavailable Exception "
 			  "%lx at %lx\n", regs->trap, regs->nip);
 	die("Unrecoverable VMX/Altivec Unavailable Exception", regs, SIGABRT);
diff -urN preempt/arch/ppc64/mm/fault.c test25/arch/ppc64/mm/fault.c
--- preempt/arch/ppc64/mm/fault.c	2004-06-01 08:11:19.000000000 +1000
+++ test25/arch/ppc64/mm/fault.c	2004-06-17 16:23:50.000000000 +1000
@@ -80,36 +80,45 @@
  *  - DSISR for a non-SLB data access fault,
  *  - SRR1 & 0x08000000 for a non-SLB instruction access fault
  *  - 0 any SLB fault.
+ * The return value is 0 if the fault was handled, or the signal
+ * number if this is a kernel fault that can't be handled here.
  */
-void do_page_fault(struct pt_regs *regs, unsigned long address,
-		   unsigned long error_code)
+int do_page_fault(struct pt_regs *regs, unsigned long address,
+		  unsigned long error_code)
 {
 	struct vm_area_struct * vma;
 	struct mm_struct *mm = current->mm;
 	siginfo_t info;
 	unsigned long code = SEGV_MAPERR;
 	unsigned long is_write = error_code & 0x02000000;
+	unsigned long trap = TRAP(regs);
 
-	if (regs->trap == 0x300 || regs->trap == 0x380) {
+	if (trap == 0x300 || trap == 0x380) {
 		if (debugger_fault_handler(regs))
-			return;
+			return 0;
 	}
 
 	/* On a kernel SLB miss we can only check for a valid exception entry */
-	if (!user_mode(regs) && (regs->trap == 0x380)) {
-		bad_page_fault(regs, address, SIGSEGV);
-		return;
-	}
+	if (!user_mode(regs) && (trap == 0x380 || address >= TASK_SIZE))
+		return SIGSEGV;
 
 	if (error_code & 0x00400000) {
 		if (debugger_dabr_match(regs))
-			return;
+			return 0;
 	}
 
 	if (in_atomic() || mm == NULL) {
-		bad_page_fault(regs, address, SIGSEGV);
-		return;
+		if (!user_mode(regs))
+			return SIGSEGV;
+		/* in_atomic() in user mode is really bad,
+		   as is current->mm == NULL. */
+		printk(KERN_EMERG "Page fault in user mode with"
+		       "in_atomic() = %d mm = %p\n", in_atomic(), mm);
+		printk(KERN_EMERG "NIP = %lx  MSR = %lx\n",
+		       regs->nip, regs->msr);
+		die("Weird page fault", regs, SIGSEGV);
 	}
+
 	down_read(&mm->mmap_sem);
 	vma = find_vma(mm, address);
 	if (!vma)
@@ -195,7 +204,7 @@
 	}
 
 	up_read(&mm->mmap_sem);
-	return;
+	return 0;
 
 bad_area:
 	up_read(&mm->mmap_sem);
@@ -207,11 +216,10 @@
 		info.si_code = code;
 		info.si_addr = (void *) address;
 		force_sig_info(SIGSEGV, &info, current);
-		return;
+		return 0;
 	}
 
-	bad_page_fault(regs, address, SIGSEGV);
-	return;
+	return SIGSEGV;
 
 /*
  * We ran out of memory, or some other thing happened to us that made
@@ -227,18 +235,19 @@
 	printk("VM: killing process %s\n", current->comm);
 	if (user_mode(regs))
 		do_exit(SIGKILL);
-	bad_page_fault(regs, address, SIGKILL);
-	return;
+	return SIGKILL;
 
 do_sigbus:
 	up_read(&mm->mmap_sem);
-	info.si_signo = SIGBUS;
-	info.si_errno = 0;
-	info.si_code = BUS_ADRERR;
-	info.si_addr = (void *)address;
-	force_sig_info (SIGBUS, &info, current);
-	if (!user_mode(regs))
-		bad_page_fault(regs, address, SIGBUS);
+	if (user_mode(regs)) {
+		info.si_signo = SIGBUS;
+		info.si_errno = 0;
+		info.si_code = BUS_ADRERR;
+		info.si_addr = (void *)address;
+		force_sig_info(SIGBUS, &info, current);
+		return 0;
+	}
+	return SIGBUS;
 }
 
 /*
diff -urN preempt/arch/ppc64/xmon/xmon.c test25/arch/ppc64/xmon/xmon.c
--- preempt/arch/ppc64/xmon/xmon.c	2004-06-04 07:19:00.000000000 +1000
+++ test25/arch/ppc64/xmon/xmon.c	2004-06-17 15:46:06.000000000 +1000
@@ -44,9 +44,6 @@
 static int xmon_gate;
 #endif /* CONFIG_SMP */
 
-#define TRAP(regs)	((regs)->trap)
-#define FULL_REGS(regs)	1
-
 static unsigned long in_xmon = 0;
 
 static unsigned long adrs;
diff -urN preempt/include/asm-ppc64/paca.h test25/include/asm-ppc64/paca.h
--- preempt/include/asm-ppc64/paca.h	2004-06-09 07:01:14.000000000 +1000
+++ test25/include/asm-ppc64/paca.h	2004-06-17 15:46:06.000000000 +1000
@@ -136,23 +136,21 @@
 	u8  rsvd6[0x500 - 0x8];
 
 /*=====================================================================================
- * CACHE_LINE_31 0x0F00 - 0x0F7F Exception stack
+ * CACHE_LINE_31-32 0x0F00 - 0x0FFF Exception register save areas
  *=====================================================================================
  */
-	u8 exception_stack[N_EXC_STACK*EXC_FRAME_SIZE];
+	u64 exgen[8];		/* used for most interrupts/exceptions */
+	u64 exmc[8];		/* used for machine checks */
+	u64 exslb[8];		/* used for SLB/segment table misses
+				 * on the linear mapping */
+	u64 exdsi[8];		/* used for linear mapping hash table misses */
 
 /*=====================================================================================
- * CACHE_LINE_32 0x0F80 - 0x0FFF Reserved
+ * Page 2 used as a stack when we detect a bad kernel stack pointer,
+ * and early in SMP boots before relocation is enabled.
  *=====================================================================================
  */
-	u8 rsvd7[0x80];                  /* Give the stack some rope ... */
-
-/*=====================================================================================
- * Page 2 Reserved for guard page.  Also used as a stack early in SMP boots before
- *        relocation is enabled.
- *=====================================================================================
- */
-	u8 guard[0x1000];               /* ... and then hang 'em         */ 
+	u8 guard[0x1000];
 };
 
 #endif /* _PPC64_PACA_H */
diff -urN preempt/include/asm-ppc64/ppc_asm.h test25/include/asm-ppc64/ppc_asm.h
--- preempt/include/asm-ppc64/ppc_asm.h	2004-02-01 13:11:53.000000000 +1100
+++ test25/include/asm-ppc64/ppc_asm.h	2004-06-17 15:46:06.000000000 +1000
@@ -28,6 +28,9 @@
 #define REST_8GPRS(n, base)	REST_4GPRS(n, base); REST_4GPRS(n+4, base)
 #define REST_10GPRS(n, base)	REST_8GPRS(n, base); REST_2GPRS(n+8, base)
 
+#define SAVE_NVGPRS(base)	SAVE_8GPRS(14, base); SAVE_10GPRS(22, base)
+#define REST_NVGPRS(base)	REST_8GPRS(14, base); REST_10GPRS(22, base)
+
 #define SAVE_FPR(n, base)	stfd	n,THREAD_FPR0+8*(n)(base)
 #define SAVE_2FPRS(n, base)	SAVE_FPR(n, base); SAVE_FPR(n+1, base)
 #define SAVE_4FPRS(n, base)	SAVE_2FPRS(n, base); SAVE_2FPRS(n+2, base)
@@ -54,11 +57,6 @@
 #define REST_16VRS(n,b,base)	REST_8VRS(n,b,base); REST_8VRS(n+8,b,base)
 #define REST_32VRS(n,b,base)	REST_16VRS(n,b,base); REST_16VRS(n+16,b,base)
 
-#define CHECKANYINT(ra,rb)			\
-	mfspr	rb,SPRG3;		/* Get Paca address */\
-	ld	ra,PACALPPACA+LPPACAANYINT(rb); /* Get pending interrupt flags */\
-	cmpldi	0,ra,0;
-
 /* Macros to adjust thread priority for Iseries hardware multithreading */
 #define HMT_LOW		or 1,1,1
 #define HMT_MEDIUM	or 2,2,2
diff -urN preempt/include/asm-ppc64/processor.h test25/include/asm-ppc64/processor.h
--- preempt/include/asm-ppc64/processor.h	2004-06-04 07:19:01.000000000 +1000
+++ test25/include/asm-ppc64/processor.h	2004-06-17 15:46:06.000000000 +1000
@@ -543,8 +543,7 @@
 	double		fpr[32];	/* Complete floating point set */
 	unsigned long	fpscr;		/* Floating point status (plus pad) */
 	unsigned long	fpexc_mode;	/* Floating-point exception mode */
-	unsigned long	saved_msr;	/* Save MSR across signal handlers */
-	unsigned long	saved_softe;	/* Ditto for Soft Enable/Disable */
+	unsigned long	pad[3];		/* was saved_msr, saved_softe */
 #ifdef CONFIG_ALTIVEC
 	/* Complete AltiVec register set */
 	vector128	vr[32] __attribute((aligned(16)));
diff -urN preempt/include/asm-ppc64/ptrace.h test25/include/asm-ppc64/ptrace.h
--- preempt/include/asm-ppc64/ptrace.h	2004-05-20 08:06:38.000000000 +1000
+++ test25/include/asm-ppc64/ptrace.h	2004-06-17 15:46:06.000000000 +1000
@@ -71,6 +71,18 @@
 #define instruction_pointer(regs) ((regs)->nip)
 #define user_mode(regs) ((((regs)->msr) >> MSR_PR_LG) & 0x1)
 
+#define force_successful_syscall_return()   \
+		(current_thread_info()->syscall_noerror = 1)
+
+/*
+ * We use the least-significant bit of the trap field to indicate
+ * whether we have saved the full set of registers, or only a
+ * partial set.  A 1 there means the partial set.
+ */
+#define FULL_REGS(regs)		(((regs)->trap & 1) == 0)
+#define TRAP(regs)		((regs)->trap & ~0xF)
+#define CHECK_FULL_REGS(regs)	BUG_ON(regs->trap & 1)
+
 /*
  * Offsets used by 'ptrace' system call interface.
  */
diff -urN preempt/include/asm-ppc64/thread_info.h test25/include/asm-ppc64/thread_info.h
--- preempt/include/asm-ppc64/thread_info.h	2004-06-17 15:51:34.000000000 +1000
+++ test25/include/asm-ppc64/thread_info.h	2004-06-17 15:46:06.000000000 +1000
@@ -26,6 +26,8 @@
 	int		cpu;			/* cpu we're on */
 	int		preempt_count;
 	struct restart_block restart_block;
+	/* set by force_successful_syscall_return */
+	unsigned char	syscall_noerror;
 };
 
 /*
@@ -84,8 +86,6 @@
 
 /*
  * thread information flag bit numbers
- * N.B. If TIF_SIGPENDING or TIF_NEED_RESCHED are changed
- * to be >= 4, code in entry.S will need to be changed.
  */
 #define TIF_SYSCALL_TRACE	0	/* syscall trace active */
 #define TIF_NOTIFY_RESUME	1	/* resumption notification requested */
