Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280800AbRKLOVS>; Mon, 12 Nov 2001 09:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280801AbRKLOVI>; Mon, 12 Nov 2001 09:21:08 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:20560 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S280800AbRKLOVA>; Mon, 12 Nov 2001 09:21:00 -0500
Date: Mon, 12 Nov 2001 15:20:44 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: mathijs@knoware.nl, jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com, kuznet@ms2.inr.ac.ru,
        Thorsten Kukuk <kukuk@suse.de>
Subject: Re: [PATCH] fix loop with disabled tasklets
Message-ID: <20011112152044.V1381@athlon.random>
In-Reply-To: <20011110152845.8328F231A4@brand.mmohlmann.demon.nl> <20011110173751.C1381@athlon.random> <20011112021142.O1381@athlon.random> <20011112.000305.45744181.davem@redhat.com> <20011112150452.S1381@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20011112150452.S1381@athlon.random>; from andrea@suse.de on Mon, Nov 12, 2001 at 03:04:52PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2001 at 03:04:52PM +0100, Andrea Arcangeli wrote:
> On Mon, Nov 12, 2001 at 12:03:05AM -0800, David S. Miller wrote:
> >    From: Andrea Arcangeli <andrea@suse.de>
> >    Date: Mon, 12 Nov 2001 02:11:42 +0100
> > 
> >    I'm just guessing: the scheduler isn't yet functional when
> >    spawn_ksoftirqd is called.
> > 
> > The scheduler is fully functional, this isn't what is going wrong.
> 
> check ret_from_fork path, sparc32 scheduler is broken and this is why it
> deadlocks at boot, it has nothing to do with the softirq code, softirq
> code is innocent and it only get bitten by the sparc32 bug.

real fix looks like this (no idea what PSR_PIL means so not sure if this
really works on UP but certainly the sched_yield breakage is fixed now
and it won't deadlock in the softirq code any longer):

--- 2.4.15pre2aa1/arch/sparc/kernel/entry.S.~1~	Sat Feb 10 02:34:05 2001
+++ 2.4.15pre2aa1/arch/sparc/kernel/entry.S	Mon Nov 12 15:17:32 2001
@@ -1466,8 +1466,7 @@
 	b	C_LABEL(ret_sys_call)
 	 ld	[%sp + REGWIN_SZ + PT_I0], %o0
 
-#ifdef CONFIG_SMP
-	.globl	C_LABEL(ret_from_smpfork)
+	.globl	C_LABEL(ret_from_fork)
 C_LABEL(ret_from_smpfork):
 	wr	%l0, PSR_ET, %psr
 	WRITE_PAUSE
@@ -1475,7 +1474,6 @@
 	 mov	%g3, %o0
 	b	C_LABEL(ret_sys_call)
 	 ld	[%sp + REGWIN_SZ + PT_I0], %o0
-#endif
 
 	/* Linux native and SunOS system calls enter here... */
 	.align	4
--- 2.4.15pre2aa1/arch/sparc/kernel/process.c.~1~	Thu Oct 11 10:41:52 2001
+++ 2.4.15pre2aa1/arch/sparc/kernel/process.c	Mon Nov 12 15:18:21 2001
@@ -455,11 +455,7 @@
  *       allocate the task_struct and kernel stack in
  *       do_fork().
  */
-#ifdef CONFIG_SMP
-extern void ret_from_smpfork(void);
-#else
-extern void ret_from_syscall(void);
-#endif
+extern void ret_from_smp(void);
 
 int copy_thread(int nr, unsigned long clone_flags, unsigned long sp,
 		unsigned long unused,
@@ -493,13 +489,8 @@
 	copy_regwin(new_stack, (((struct reg_window *) regs) - 1));
 
 	p->thread.ksp = (unsigned long) new_stack;
-#ifdef CONFIG_SMP
 	p->thread.kpc = (((unsigned long) ret_from_smpfork) - 0x8);
 	p->thread.kpsr = current->thread.fork_kpsr | PSR_PIL;
-#else
-	p->thread.kpc = (((unsigned long) ret_from_syscall) - 0x8);
-	p->thread.kpsr = current->thread.fork_kpsr;
-#endif
 	p->thread.kwim = current->thread.fork_kwim;
 
 	/* This is used for sun4c only */

Andrea
