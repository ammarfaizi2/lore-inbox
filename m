Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265724AbUFDKoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265724AbUFDKoX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 06:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265725AbUFDKoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 06:44:23 -0400
Received: from darwin.snarc.org ([81.56.210.228]:3736 "EHLO darwin.snarc.org")
	by vger.kernel.org with ESMTP id S265724AbUFDKmT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 06:42:19 -0400
Date: Fri, 4 Jun 2004 12:42:11 +0200
To: lkml <linux-kernel@vger.kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] remove hardcoded offsets in arch/ppc/
Message-ID: <20040604104210.GA16904@snarc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Email may contain unsmilyfied humor and/or satire.
User-Agent: Mutt/1.5.6i
From: Vincent Hanquez <tab@snarc.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

Here is the same cleanups as in i386 to remove hardcoded offsets of
thread_info in ppc/. it apply on top of 2.6.7-rc2.

Signed-off-by: Vincent Hanquez <tab@snarc.org>

diff -u -Naur linux-2.6.7-rc2.orig/arch/ppc/kernel/asm-offsets.c linux-2.6.7-rc2/arch/ppc/kernel/asm-offsets.c
--- linux-2.6.7-rc2.orig/arch/ppc/kernel/asm-offsets.c	2004-06-04 10:07:19.000000000 +0200
+++ linux-2.6.7-rc2/arch/ppc/kernel/asm-offsets.c	2004-06-04 11:57:16.000000000 +0200
@@ -123,6 +123,13 @@
 	DEFINE(CPU_SPEC_FEATURES, offsetof(struct cpu_spec, cpu_features));
 	DEFINE(CPU_SPEC_SETUP, offsetof(struct cpu_spec, cpu_setup));
 
+	DEFINE(TI_task, offsetof(struct thread_info, task));
+	DEFINE(TI_exec_domain, offsetof(struct thread_info, exec_domain));
+	DEFINE(TI_flags, offsetof(struct thread_info, flags));
+	DEFINE(TI_local_flags, offsetof(struct thread_info, local_flags));
+	DEFINE(TI_cpu, offsetof(struct thread_info, cpu));
+	DEFINE(TI_preempt_count, offsetof(struct thread_info, preempt_count));
+	
 	DEFINE(NUM_USER_SEGMENTS, TASK_SIZE>>28);
 	return 0;
 }
diff -u -Naur linux-2.6.7-rc2.orig/arch/ppc/kernel/entry.S linux-2.6.7-rc2/arch/ppc/kernel/entry.S
--- linux-2.6.7-rc2.orig/arch/ppc/kernel/entry.S	2004-06-04 10:40:58.000000000 +0200
+++ linux-2.6.7-rc2/arch/ppc/kernel/entry.S	2004-06-04 11:14:34.000000000 +0200
@@ -199,10 +199,10 @@
 	bl	do_show_syscall
 #endif /* SHOW_SYSCALLS */
 	rlwinm	r10,r1,0,0,18	/* current_thread_info() */
-	lwz	r11,TI_LOCAL_FLAGS(r10)
+	lwz	r11,TI_local_flags(r10)
 	rlwinm	r11,r11,0,~_TIFL_FORCE_NOERROR
-	stw	r11,TI_LOCAL_FLAGS(r10)
-	lwz	r11,TI_FLAGS(r10)
+	stw	r11,TI_local_flags(r10)
+	lwz	r11,TI_flags(r10)
 	andi.	r11,r11,_TIF_SYSCALL_TRACE
 	bne-	syscall_dotrace
 syscall_dotrace_cont:
@@ -225,7 +225,7 @@
 	cmpl	0,r3,r11
 	rlwinm	r12,r1,0,0,18	/* current_thread_info() */
 	blt+	30f
-	lwz	r11,TI_LOCAL_FLAGS(r12)
+	lwz	r11,TI_local_flags(r12)
 	andi.	r11,r11,_TIFL_FORCE_NOERROR
 	bne	30f
 	neg	r3,r3
@@ -237,7 +237,7 @@
 30:	LOAD_MSR_KERNEL(r10,MSR_KERNEL)	/* doesn't include MSR_EE */
 	SYNC
 	MTMSRD(r10)
-	lwz	r9,TI_FLAGS(r12)
+	lwz	r9,TI_flags(r12)
 	andi.	r0,r9,(_TIF_SYSCALL_TRACE|_TIF_SIGPENDING|_TIF_NEED_RESCHED)
 	bne-	syscall_exit_work
 syscall_exit_cont:
@@ -311,7 +311,7 @@
 	SYNC
 	MTMSRD(r10)		/* disable interrupts again */
 	rlwinm	r12,r1,0,0,18	/* current_thread_info() */
-	lwz	r9,TI_FLAGS(r12)
+	lwz	r9,TI_flags(r12)
 5:
 	andi.	r0,r9,_TIF_NEED_RESCHED
 	bne	1f
@@ -558,7 +558,7 @@
 sigreturn_exit:
 	subi	r1,r3,STACK_FRAME_OVERHEAD
 	rlwinm	r12,r1,0,0,18	/* current_thread_info() */
-	lwz	r9,TI_FLAGS(r12)
+	lwz	r9,TI_flags(r12)
 	andi.	r0,r9,_TIF_SYSCALL_TRACE
 	bnel-	do_syscall_trace
 	/* fall through */
@@ -584,7 +584,7 @@
 user_exc_return:		/* r10 contains MSR_KERNEL here */
 	/* Check current_thread_info()->flags */
 	rlwinm	r9,r1,0,0,18
-	lwz	r9,TI_FLAGS(r9)
+	lwz	r9,TI_flags(r9)
 	andi.	r0,r9,(_TIF_SIGPENDING|_TIF_NEED_RESCHED)
 	bne	do_work
 
@@ -603,16 +603,16 @@
 resume_kernel:
 	/* check current_thread_info->preempt_count */
 	rlwinm	r9,r1,0,0,18
-	lwz	r0,TI_PREEMPT(r9)
+	lwz	r0,TI_preempt_count(r9)
 	cmpwi	0,r0,0		/* if non-zero, just restore regs and return */
 	bne	restore
-	lwz	r0,TI_FLAGS(r9)
+	lwz	r0,TI_flags(r9)
 	andi.	r0,r0,_TIF_NEED_RESCHED
 	beq+	restore
 	andi.	r0,r3,MSR_EE	/* interrupts off? */
 	beq	restore		/* don't schedule if so */
 1:	lis	r0,PREEMPT_ACTIVE@h
-	stw	r0,TI_PREEMPT(r9)
+	stw	r0,TI_preempt_count(r9)
 	ori	r10,r10,MSR_EE
 	SYNC
 	MTMSRD(r10)		/* hard-enable interrupts */
@@ -622,8 +622,8 @@
 	MTMSRD(r10)		/* disable interrupts */
 	rlwinm	r9,r1,0,0,18
 	li	r0,0
-	stw	r0,TI_PREEMPT(r9)
-	lwz	r3,TI_FLAGS(r9)
+	stw	r0,TI_preempt_count(r9)
+	lwz	r3,TI_flags(r9)
 	andi.	r0,r3,_TIF_NEED_RESCHED
 	bne-	1b
 #else
@@ -901,7 +901,7 @@
 	SYNC
 	MTMSRD(r10)		/* disable interrupts */
 	rlwinm	r9,r1,0,0,18
-	lwz	r9,TI_FLAGS(r9)
+	lwz	r9,TI_flags(r9)
 	andi.	r0,r9,_TIF_NEED_RESCHED
 	bne-	do_resched
 	andi.	r0,r9,_TIF_SIGPENDING
diff -u -Naur linux-2.6.7-rc2.orig/arch/ppc/kernel/head.S linux-2.6.7-rc2/arch/ppc/kernel/head.S
--- linux-2.6.7-rc2.orig/arch/ppc/kernel/head.S	2004-06-04 10:40:58.000000000 +0200
+++ linux-2.6.7-rc2/arch/ppc/kernel/head.S	2004-06-04 11:56:00.000000000 +0200
@@ -1240,7 +1240,7 @@
 	tophys(r1,r1)
 	lwz	r1,secondary_ti@l(r1)
 	tophys(r2,r1)
-	lwz	r2,TI_TASK(r2)
+	lwz	r2,TI_task(r2)
 
 	/* stack */
 	addi	r1,r1,THREAD_SIZE-STACK_FRAME_OVERHEAD
diff -u -Naur linux-2.6.7-rc2.orig/arch/ppc/kernel/idle_6xx.S linux-2.6.7-rc2/arch/ppc/kernel/idle_6xx.S
--- linux-2.6.7-rc2.orig/arch/ppc/kernel/idle_6xx.S	2004-06-04 10:07:19.000000000 +0200
+++ linux-2.6.7-rc2/arch/ppc/kernel/idle_6xx.S	2004-06-04 11:54:59.000000000 +0200
@@ -94,7 +94,7 @@
 
 	/* Check current_thread_info()->flags */
 	rlwinm	r4,r1,0,0,18
-	lwz	r4,TI_FLAGS(r4)
+	lwz	r4,TI_flags(r4)
 	andi.	r0,r4,_TIF_NEED_RESCHED
 	beq	1f
 	mtmsr	r7	/* out of line this ? */
@@ -191,7 +191,7 @@
 	
 	rlwinm	r9,r1,0,0,18
 	tophys(r9,r9)
-	lwz	r11,TI_CPU(r9)
+	lwz	r11,TI_cpu(r9)
 	slwi	r11,r11,2
 	/* Todo make sure all these are in the same page
 	 * and load r22 (@ha part + CPU offset) only once
diff -u -Naur linux-2.6.7-rc2.orig/arch/ppc/kernel/idle_power4.S linux-2.6.7-rc2/arch/ppc/kernel/idle_power4.S
--- linux-2.6.7-rc2.orig/arch/ppc/kernel/idle_power4.S	2004-06-04 10:07:19.000000000 +0200
+++ linux-2.6.7-rc2/arch/ppc/kernel/idle_power4.S	2004-06-04 11:54:42.000000000 +0200
@@ -66,7 +66,7 @@
 
 	/* Check current_thread_info()->flags */
 	rlwinm	r4,r1,0,0,18
-	lwz	r4,TI_FLAGS(r4)
+	lwz	r4,TI_flags(r4)
 	andi.	r0,r4,_TIF_NEED_RESCHED
 	beq	1f
 	mtmsr	r7	/* out of line this ? */
diff -u -Naur linux-2.6.7-rc2.orig/arch/ppc/kernel/misc.S linux-2.6.7-rc2/arch/ppc/kernel/misc.S
--- linux-2.6.7-rc2.orig/arch/ppc/kernel/misc.S	2004-06-04 10:40:58.000000000 +0200
+++ linux-2.6.7-rc2/arch/ppc/kernel/misc.S	2004-06-04 11:55:42.000000000 +0200
@@ -233,7 +233,7 @@
 
 	/* Store new HID1 image */
 	rlwinm	r6,r1,0,0,18
-	lwz	r6,TI_CPU(r6)
+	lwz	r6,TI_cpu(r6)
 	slwi	r6,r6,2
 	addis	r6,r6,nap_save_hid1@ha
 	stw	r4,nap_save_hid1@l(r6)
@@ -422,7 +422,7 @@
 #else /* !(CONFIG_40x || CONFIG_44x) */
 #if defined(CONFIG_SMP)
 	rlwinm	r8,r1,0,0,18
-	lwz	r8,TI_CPU(r8)
+	lwz	r8,TI_cpu(r8)
 	oris	r8,r8,10
 	mfmsr	r10
 	SYNC
@@ -490,7 +490,7 @@
 #else /* !(CONFIG_40x || CONFIG_44x) */
 #if defined(CONFIG_SMP)
 	rlwinm	r8,r1,0,0,18
-	lwz	r8,TI_CPU(r8)
+	lwz	r8,TI_cpu(r8)
 	oris	r8,r8,11
 	mfmsr	r10
 	SYNC
diff -u -Naur linux-2.6.7-rc2.orig/include/asm-ppc/thread_info.h linux-2.6.7-rc2/include/asm-ppc/thread_info.h
--- linux-2.6.7-rc2.orig/include/asm-ppc/thread_info.h	2004-06-04 10:07:48.000000000 +0200
+++ linux-2.6.7-rc2/include/asm-ppc/thread_info.h	2004-06-04 11:12:21.000000000 +0200
@@ -65,16 +65,6 @@
  */
 #define THREAD_SIZE		8192	/* 2 pages */
 
-/*
- * Offsets in thread_info structure, used in assembly code
- */
-#define TI_TASK		0
-#define TI_EXECDOMAIN	4
-#define TI_FLAGS	8
-#define TI_LOCAL_FLAGS	12
-#define TI_CPU		16
-#define TI_PREEMPT	20
-
 #define PREEMPT_ACTIVE		0x4000000
 
 /*
