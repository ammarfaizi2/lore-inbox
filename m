Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266438AbSLWEzC>; Sun, 22 Dec 2002 23:55:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266555AbSLWEzC>; Sun, 22 Dec 2002 23:55:02 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:10504 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266438AbSLWEzA>; Sun, 22 Dec 2002 23:55:00 -0500
Date: Sun, 22 Dec 2002 21:03:44 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Ingo Molnar <mingo@elte.hu>, Ulrich Drepper <drepper@redhat.com>,
       <bart@etpmod.phys.tue.nl>, <davej@codemonkey.org.uk>,
       <hpa@transmeta.com>, <terje.eggestad@scali.com>,
       <matti.aarnio@zmailer.org>, <hugh@veritas.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <Pine.LNX.4.44.0212221050210.2587-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0212222050030.1217-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 22 Dec 2002, Linus Torvalds wrote:
>
> I looked a bit at what it would take to have the TF bit handled by the
> sysenter path, and it might not be so horrible - certainly not as ugly as
> the register restore bits.

Hey, I tried it out, and it does indeed turn out to be fairly easy and
clean (in fact, it's mostly four pretty obvious "one-liners").

Let nobody say I won't change my mind - you were right Jamie (*). The
pushfl/popfl is unnessary, and does show up in microbenchmarks.

How does the attached patch work for people? I've verified that
single-stepping works, and I've also verified that it does improve
performance for simple system calls. Everything looks quite simple.

		Linus

(*) In fact, people sometimes complain that I change my mind way too
often. Hey, sue me.

-=-=-=

===== arch/i386/kernel/signal.c 1.22 vs edited =====
--- 1.22/arch/i386/kernel/signal.c	Fri Dec  6 09:43:43 2002
+++ edited/arch/i386/kernel/signal.c	Sun Dec 22 20:31:38 2002
@@ -609,6 +609,11 @@
 void do_notify_resume(struct pt_regs *regs, sigset_t *oldset,
 		      __u32 thread_info_flags)
 {
+	/* Pending single-step? */
+	if (thread_info_flags & _TIF_SINGLESTEP) {
+		regs->eflags |= TF_MASK;
+		clear_thread_flag(TIF_SINGLESTEP);
+	}
 	/* deal with pending signal delivery */
 	if (thread_info_flags & _TIF_SIGPENDING)
 		do_signal(regs,oldset);
===== arch/i386/kernel/sysenter.c 1.4 vs edited =====
--- 1.4/arch/i386/kernel/sysenter.c	Sat Dec 21 16:02:02 2002
+++ edited/arch/i386/kernel/sysenter.c	Sun Dec 22 20:17:28 2002
@@ -54,19 +54,18 @@
 		0xc3			/* ret */
 	};
 	static const char sysent[] = {
-		0x9c,			/* pushf */
 		0x51,			/* push %ecx */
 		0x52,			/* push %edx */
 		0x55,			/* push %ebp */
 		0x89, 0xe5,		/* movl %esp,%ebp */
 		0x0f, 0x34,		/* sysenter */
+		0x00,			/* align return point */
 	/* System call restart point is here! (SYSENTER_RETURN - 2) */
 		0xeb, 0xfa,		/* jmp to "movl %esp,%ebp" */
 	/* System call normal return point is here! (SYSENTER_RETURN in entry.S) */
 		0x5d,			/* pop %ebp */
 		0x5a,			/* pop %edx */
 		0x59,			/* pop %ecx */
-		0x9d,			/* popf - restore TF */
 		0xc3			/* ret */
 	};
 	unsigned long page = get_zeroed_page(GFP_ATOMIC);
===== arch/i386/kernel/traps.c 1.36 vs edited =====
--- 1.36/arch/i386/kernel/traps.c	Mon Nov 18 10:10:45 2002
+++ edited/arch/i386/kernel/traps.c	Sun Dec 22 20:03:35 2002
@@ -605,7 +605,7 @@
 		 * interface.
 		 */
 		if ((regs->xcs & 3) == 0)
-			goto clear_TF;
+			goto clear_TF_reenable;
 		if ((tsk->ptrace & (PT_DTRACE|PT_PTRACED)) == PT_DTRACE)
 			goto clear_TF;
 	}
@@ -637,6 +637,8 @@
 	handle_vm86_trap((struct kernel_vm86_regs *) regs, error_code, 1);
 	return;

+clear_TF_reenable:
+	set_tsk_thread_flag(tsk, TIF_SINGLESTEP);
 clear_TF:
 	regs->eflags &= ~TF_MASK;
 	return;
===== include/asm-i386/thread_info.h 1.8 vs edited =====
--- 1.8/include/asm-i386/thread_info.h	Fri Dec  6 09:43:43 2002
+++ edited/include/asm-i386/thread_info.h	Sun Dec 22 20:30:28 2002
@@ -109,6 +109,7 @@
 #define TIF_NOTIFY_RESUME	1	/* resumption notification requested */
 #define TIF_SIGPENDING		2	/* signal pending */
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
+#define TIF_SINGLESTEP		4	/* restore singlestep on return to user mode */
 #define TIF_USEDFPU		16	/* FPU was used by this task this quantum (SMP) */
 #define TIF_POLLING_NRFLAG	17	/* true if poll_idle() is polling TIF_NEED_RESCHED */

@@ -116,6 +117,7 @@
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1<<TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
+#define _TIF_SINGLESTEP		(1<<TIF_SINGLESTEP)
 #define _TIF_USEDFPU		(1<<TIF_USEDFPU)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)


