Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135735AbRECRYV>; Thu, 3 May 2001 13:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135737AbRECRYM>; Thu, 3 May 2001 13:24:12 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:31266 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S135735AbRECRYA>; Thu, 3 May 2001 13:24:00 -0400
Date: Thu, 3 May 2001 19:23:36 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Cabaniols, Sebastien" <Sebastien.Cabaniols@Compaq.com>
Cc: "'Andrew Morton'" <andrewm@uow.edu.au>,
        "'netdev@oss.sgi.com'" <netdev@oss.sgi.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'davem@redhat.com'" <davem@redhat.com>,
        "'kuznet@ms2.inr.ac.ru'" <kuznet@ms2.inr.ac.ru>
Subject: Re: [BUG] freeze Alpha ES40 SMP 2.4.4.ac3, another TCP/IP Problem ? ( was 2.4.4 kernel crash , possibly tcp related )
Message-ID: <20010503192335.U1162@athlon.random>
In-Reply-To: <1FF17ADDAC64D0119A6E0000F830C9EA04B3CDD1@aeoexc1.aeo.cpqcorp.net> <20010503184610.T1162@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010503184610.T1162@athlon.random>; from andrea@suse.de on Thu, May 03, 2001 at 06:46:10PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2001 at 06:46:10PM +0200, Andrea Arcangeli wrote:
> as well. The only annoying thing is that UP kernel compiles seems not to
> boot but I hope that will be fixed soon too.

Ok I spotted and fixed that bug that forbidden my tree to boot with UP
compiles on alpha. The bug is that the SCHED_YIELD handling was broken
on alpha UP, this is the fix:

--- 2.4.5pre1aa1/arch/alpha/kernel/entry.S.~1~	Thu May  3 18:22:13 2001
+++ 2.4.5pre1aa1/arch/alpha/kernel/entry.S	Thu May  3 19:18:16 2001
@@ -709,16 +709,14 @@
 	br	restore_all
 .end entSys
 
-#ifdef CONFIG_SMP
-        .globl  ret_from_smp_fork
+        .globl  ret_from_fork
 .align 3
-.ent ret_from_smp_fork
-ret_from_smp_fork:
+.ent ret_from_fork
+ret_from_fork:
 	lda	$26,ret_from_sys_call
 	mov	$17,$16
 	jsr	$31,schedule_tail
-.end ret_from_smp_fork
-#endif /* CONFIG_SMP */
+.end ret_from_fork
 
 .align 3
 .ent reschedule
--- 2.4.5pre1aa1/arch/alpha/kernel/process.c.~1~	Thu May  3 18:22:09 2001
+++ 2.4.5pre1aa1/arch/alpha/kernel/process.c	Thu May  3 19:15:41 2001
@@ -306,7 +306,7 @@
 	    struct task_struct * p, struct pt_regs * regs)
 {
 	extern void ret_from_sys_call(void);
-	extern void ret_from_smp_fork(void);
+	extern void ret_from_fork(void);
 
 	struct pt_regs * childregs;
 	struct switch_stack * childstack, *stack;
@@ -325,11 +325,7 @@
 	stack = ((struct switch_stack *) regs) - 1;
 	childstack = ((struct switch_stack *) childregs) - 1;
 	*childstack = *stack;
-#ifdef CONFIG_SMP
-	childstack->r26 = (unsigned long) ret_from_smp_fork;
-#else
-	childstack->r26 = (unsigned long) ret_from_sys_call;
-#endif
+	childstack->r26 = (unsigned long) ret_from_fork;
 	p->thread.usp = usp;
 	p->thread.ksp = (unsigned long) childstack;
 	p->thread.pal_flags = 1;	/* set FEN, clear everything else */


(SCHED_YIELD of the previous task is cleared by __schedule_tail, it
wasn't cleared so a non running task had a SCHED_YIELD set and it was
deadlocking, this can explain many malfunction of UP alpha kernels)
I never noticed so far because I always compiled it SMP.

Andrea
