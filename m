Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262329AbUJBLwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbUJBLwx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 07:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263795AbUJBLww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 07:52:52 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:27066 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S262329AbUJBLwp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 07:52:45 -0400
Message-ID: <415E981E.4632746E@tv-sign.ru>
Date: Sat, 02 Oct 2004 15:59:26 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] copy_thread(): unneeded child_tid initialization
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

{set,clear}_child_tid initialized in copy_process() right after
return from copy_thread().

These vars are not used in cleanup path if copy_thread() fails.

grep -r _child_tid arch/ shows only ia64/kernel/asm-offsets.c,
so i blindly patched non i386 archs too.

Oleg.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

diff -pur 2.6.9-rc3/arch/cris/arch-v10/kernel/process.c child_tid/arch/cris/arch-v10/kernel/process.c
--- 2.6.9-rc3/arch/cris/arch-v10/kernel/process.c	Mon Sep 13 09:32:54 2004
+++ child_tid/arch/cris/arch-v10/kernel/process.c	Sat Oct  2 15:36:12 2004
@@ -122,8 +122,6 @@ int copy_thread(int nr, unsigned long cl
         
 	*childregs = *regs;  /* struct copy of pt_regs */
         
-        p->set_child_tid = p->clear_child_tid = NULL;
-	
         childregs->r10 = 0;  /* child returns 0 after a fork/clone */
 	
 	/* put the switch stack right below the pt_regs */
diff -pur 2.6.9-rc3/arch/i386/kernel/process.c child_tid/arch/i386/kernel/process.c
--- 2.6.9-rc3/arch/i386/kernel/process.c	Thu Sep 30 15:05:13 2004
+++ child_tid/arch/i386/kernel/process.c	Sat Oct  2 15:27:12 2004
@@ -368,7 +368,6 @@ int copy_thread(int nr, unsigned long cl
 	*childregs = *regs;
 	childregs->eax = 0;
 	childregs->esp = esp;
-	p->set_child_tid = p->clear_child_tid = NULL;
 
 	p->thread.esp = (unsigned long) childregs;
 	p->thread.esp0 = (unsigned long) (childregs+1);
diff -pur 2.6.9-rc3/arch/m32r/kernel/process.c child_tid/arch/m32r/kernel/process.c
--- 2.6.9-rc3/arch/m32r/kernel/process.c	Thu Sep 30 15:05:13 2004
+++ child_tid/arch/m32r/kernel/process.c	Sat Oct  2 15:28:54 2004
@@ -247,8 +247,6 @@ int copy_thread(int nr, unsigned long cl
 	unsigned long sp = (unsigned long)tsk->thread_info + THREAD_SIZE;
 	extern void ret_from_fork(void);
 
-	tsk->set_child_tid = tsk->clear_child_tid = NULL;
-
 	/* Copy registers */
 	sp -= sizeof (struct pt_regs);
 	childregs = (struct pt_regs *)sp;
diff -pur 2.6.9-rc3/arch/mips/kernel/process.c child_tid/arch/mips/kernel/process.c
--- 2.6.9-rc3/arch/mips/kernel/process.c	Mon Sep 13 09:32:26 2004
+++ child_tid/arch/mips/kernel/process.c	Sat Oct  2 15:29:44 2004
@@ -140,7 +140,6 @@ int copy_thread(int nr, unsigned long cl
 	p->thread.cp0_status = read_c0_status() & ~(ST0_CU2|ST0_CU1);
 	childregs->cp0_status &= ~(ST0_CU2|ST0_CU1);
 	clear_tsk_thread_flag(p, TIF_USEDFPU);
-	p->set_child_tid = p->clear_child_tid = NULL;
 
 	return 0;
 }
diff -pur 2.6.9-rc3/arch/ppc/kernel/process.c child_tid/arch/ppc/kernel/process.c
--- 2.6.9-rc3/arch/ppc/kernel/process.c	Mon Sep 13 09:32:27 2004
+++ child_tid/arch/ppc/kernel/process.c	Sat Oct  2 15:30:19 2004
@@ -422,8 +422,6 @@ copy_thread(int nr, unsigned long clone_
 	unsigned long sp = (unsigned long)p->thread_info + THREAD_SIZE;
 	unsigned long childframe;
 
-	p->set_child_tid = p->clear_child_tid = NULL;
-
 	CHECK_FULL_REGS(regs);
 	/* Copy registers */
 	sp -= sizeof(struct pt_regs);
diff -pur 2.6.9-rc3/arch/ppc64/kernel/process.c child_tid/arch/ppc64/kernel/process.c
--- 2.6.9-rc3/arch/ppc64/kernel/process.c	Thu Sep 30 15:05:14 2004
+++ child_tid/arch/ppc64/kernel/process.c	Sat Oct  2 15:30:40 2004
@@ -317,8 +317,6 @@ copy_thread(int nr, unsigned long clone_
 	extern void ret_from_fork(void);
 	unsigned long sp = (unsigned long)p->thread_info + THREAD_SIZE;
 
-	p->set_child_tid = p->clear_child_tid = NULL;
-
 	/* Copy registers */
 	sp -= sizeof(struct pt_regs);
 	childregs = (struct pt_regs *) sp;
diff -pur 2.6.9-rc3/arch/s390/kernel/process.c child_tid/arch/s390/kernel/process.c
--- 2.6.9-rc3/arch/s390/kernel/process.c	Mon Sep 13 09:33:11 2004
+++ child_tid/arch/s390/kernel/process.c	Sat Oct  2 15:31:02 2004
@@ -238,7 +238,6 @@ int copy_thread(int nr, unsigned long cl
         frame = ((struct fake_frame *)
 		 (THREAD_SIZE + (unsigned long) p->thread_info)) - 1;
         p->thread.ksp = (unsigned long) frame;
-	p->set_child_tid = p->clear_child_tid = NULL;
 	/* Store access registers to kernel stack of new process. */
         frame->childregs = *regs;
 	frame->childregs.gprs[2] = 0;	/* child returns 0 on fork. */
diff -pur 2.6.9-rc3/arch/sh/kernel/process.c child_tid/arch/sh/kernel/process.c
--- 2.6.9-rc3/arch/sh/kernel/process.c	Mon Sep 13 09:32:56 2004
+++ child_tid/arch/sh/kernel/process.c	Sat Oct  2 15:31:20 2004
@@ -306,7 +306,6 @@ int copy_thread(int nr, unsigned long cl
 		childregs->gbr = childregs->regs[0];
 	}
 	childregs->regs[0] = 0; /* Set return value for child */
-	p->set_child_tid = p->clear_child_tid = NULL;
 
 	p->thread.sp = (unsigned long) childregs;
 	p->thread.pc = (unsigned long) ret_from_fork;
diff -pur 2.6.9-rc3/arch/sh64/kernel/process.c child_tid/arch/sh64/kernel/process.c
--- 2.6.9-rc3/arch/sh64/kernel/process.c	Mon Sep 13 09:33:39 2004
+++ child_tid/arch/sh64/kernel/process.c	Sat Oct  2 15:31:34 2004
@@ -765,9 +765,6 @@ int copy_thread(int nr, unsigned long cl
 	childregs->regs[9] = 0; /* Set return value for child */
 	childregs->sr |= SR_FD; /* Invalidate FPU flag */
 
-	/* From sh */
-	p->set_child_tid = p->clear_child_tid = NULL;
-
 	p->thread.sp = (unsigned long) childregs;
 	p->thread.pc = (unsigned long) ret_from_fork;
 
diff -pur 2.6.9-rc3/arch/sparc/kernel/process.c child_tid/arch/sparc/kernel/process.c
--- 2.6.9-rc3/arch/sparc/kernel/process.c	Mon Sep 13 09:31:44 2004
+++ child_tid/arch/sparc/kernel/process.c	Sat Oct  2 15:31:45 2004
@@ -480,8 +480,6 @@ int copy_thread(int nr, unsigned long cl
 #endif
 	}
 
-	p->set_child_tid = p->clear_child_tid = NULL;
-
 	/*
 	 *  p->thread_info         new_stack   childregs
 	 *  !                      !           !             {if(PSR_PS) }
diff -pur 2.6.9-rc3/arch/sparc64/kernel/process.c child_tid/arch/sparc64/kernel/process.c
--- 2.6.9-rc3/arch/sparc64/kernel/process.c	Mon Sep 13 09:32:26 2004
+++ child_tid/arch/sparc64/kernel/process.c	Sat Oct  2 15:32:33 2004
@@ -621,8 +621,6 @@ int copy_thread(int nr, unsigned long cl
 	p->thread.smp_lock_pc = 0;
 #endif
 
-	p->set_child_tid = p->clear_child_tid = NULL;
-
 	/* Calculate offset to stack_frame & pt_regs */
 	child_trap_frame = ((char *)t) + (THREAD_SIZE - (TRACEREG_SZ+STACKFRAME_SZ));
 	memcpy(child_trap_frame, (((struct sparc_stackf *)regs)-1), (TRACEREG_SZ+STACKFRAME_SZ));
diff -pur 2.6.9-rc3/arch/x86_64/kernel/process.c child_tid/arch/x86_64/kernel/process.c
--- 2.6.9-rc3/arch/x86_64/kernel/process.c	Thu Sep 30 15:05:15 2004
+++ child_tid/arch/x86_64/kernel/process.c	Sat Oct  2 15:32:47 2004
@@ -359,7 +359,6 @@ int copy_thread(int nr, unsigned long cl
 	if (rsp == ~0UL) {
 		childregs->rsp = (unsigned long)childregs;
 	}
-	p->set_child_tid = p->clear_child_tid = NULL;
 
 	p->thread.rsp = (unsigned long) childregs;
 	p->thread.rsp0 = (unsigned long) (childregs+1);
