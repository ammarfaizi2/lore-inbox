Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262884AbTE0JS4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 05:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263023AbTE0JIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 05:08:46 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:13530 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S262884AbTE0JI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 05:08:26 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][v850]  Handle new do_fork return value on v850
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030527092132.8EFD73701@mcspd15.ucom.lsi.nec.co.jp>
Date: Tue, 27 May 2003 18:21:32 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruN -X../cludes linux-2.5.70/arch/v850/kernel/entry.S linux-2.5.70-v850-20030527/arch/v850/kernel/entry.S
--- linux-2.5.70/arch/v850/kernel/entry.S	2003-04-21 10:52:40.000000000 +0900
+++ linux-2.5.70-v850-20030527/arch/v850/kernel/entry.S	2003-05-27 16:53:39.000000000 +0900
@@ -554,11 +571,14 @@
 
 L_ENTRY(sys_fork_wrapper):
 #ifdef CONFIG_MMU
-	addi	SIGCHLD, r0, r6		// Arg 0: flags
+	addi	SIGCHLD, r0, r6		   // Arg 0: flags
 	ld.w	PTO+PT_GPR(GPR_SP)[sp], r7 // Arg 1: child SP (use parent's)
-	movea	PTO, sp, r8		// Arg 2: parent context
-	mov	hilo(CSYM(fork_common)), r18// Where the real work gets done
-	br	save_extra_state_tramp	// Save state and go there
+	movea	PTO, sp, r8		   // Arg 2: parent context
+	mov	r0, r9			   // Arg 3/4/5: 0
+	st.w	r0, 16[sp]
+	st.w	r0, 20[sp]
+	mov	hilo(CSYM(do_fork)), r18   // Where the real work gets done
+	br	save_extra_state_tramp	   // Save state and go there
 #else
 	// fork almost works, enough to trick you into looking elsewhere :-(
 	addi	-EINVAL, r0, r10
@@ -569,18 +589,24 @@
 L_ENTRY(sys_vfork_wrapper):
 	addi	CLONE_VFORK | CLONE_VM | SIGCHLD, r0, r6 // Arg 0: flags
 	ld.w	PTO+PT_GPR(GPR_SP)[sp], r7 // Arg 1: child SP (use parent's)
-	movea	PTO, sp, r8		// Arg 2: parent context
-	mov	hilo(CSYM(fork_common)), r18// Where the real work gets done
-	br	save_extra_state_tramp	// Save state and go there
+	movea	PTO, sp, r8		   // Arg 2: parent context
+	mov	r0, r9			   // Arg 3/4/5: 0
+	st.w	r0, 16[sp]
+	st.w	r0, 20[sp]
+	mov	hilo(CSYM(do_fork)), r18   // Where the real work gets done
+	br	save_extra_state_tramp	   // Save state and go there
 END(sys_vfork_wrapper)
 
 L_ENTRY(sys_clone_wrapper):
-	ld.w	PTO+PT_GPR(GPR_SP)[sp], r19 // parent's stack pointer
-        cmp	r7, r0			// See if child SP arg (arg 1) is 0.
-	cmov	z, r19, r7, r7		// ... and use the parent's if so. 
-	movea	PTO, sp, r8		// Arg 2: parent context
-	mov	hilo(CSYM(fork_common)), r18// Where the real work gets done
-	br	save_extra_state_tramp	// Save state and go there
+	ld.w	PTO+PT_GPR(GPR_SP)[sp], r19// parent's stack pointer
+	cmp	r7, r0			   // See if child SP arg (arg 1) is 0.
+	cmov	z, r19, r7, r7		   // ... and use the parent's if so.
+	movea	PTO, sp, r8		   // Arg 2: parent context
+	mov	r0, r9			   // Arg 3/4/5: 0
+	st.w	r0, 16[sp]
+	st.w	r0, 20[sp]
+	mov	hilo(CSYM(do_fork)), r18   // Where the real work gets done
+	br	save_extra_state_tramp	   // Save state and go there
 END(sys_clone_wrapper)
 
 
diff -ruN -X../cludes linux-2.5.70/arch/v850/kernel/process.c linux-2.5.70-v850-20030527/arch/v850/kernel/process.c
--- linux-2.5.70/arch/v850/kernel/process.c	2003-04-21 10:52:40.000000000 +0900
+++ linux-2.5.70-v850-20030527/arch/v850/kernel/process.c	2003-05-27 16:54:00.000000000 +0900
@@ -200,14 +200,6 @@
 	return error;
 }
 
-/* This is the common part of the various fork-like system calls (which
-   are in entry.S).  */
-int fork_common (int flags, unsigned long new_sp, struct pt_regs *regs)
-{
-	struct task_struct *p = do_fork (flags, new_sp, regs, 0, 0, 0);
-	return IS_ERR (p) ? PTR_ERR (p) : p->pid;
-}
-
 
 /*
  * These bracket the sleeping functions..
