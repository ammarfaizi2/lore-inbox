Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270705AbRIGB1p>; Thu, 6 Sep 2001 21:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270758AbRIGB1Z>; Thu, 6 Sep 2001 21:27:25 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:1900 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S270705AbRIGB1O>; Thu, 6 Sep 2001 21:27:14 -0400
Date: Fri, 7 Sep 2001 03:28:01 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: David Mosberger <davidm@hpl.hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] proposed fix for ptrace() SMP race
Message-ID: <20010907032801.N11329@athlon.random>
In-Reply-To: <200109062300.QAA27430@napali.hpl.hp.com> <20010907021900.L11329@athlon.random> <15256.6038.599811.557582@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15256.6038.599811.557582@napali.hpl.hp.com>; from davidm@hpl.hp.com on Thu, Sep 06, 2001 at 05:40:54PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2001 at 05:40:54PM -0700, David Mosberger wrote:
>   Andrea> abusing cpus_allowed to forbid scheduling is racy so quite
>   Andrea> unacceptable, we want to preserve the cpus_allowed field for
>   Andrea> the administrator (he could as well set it during the
>   Andrea> ptrace).
> 
> As long as the CPU manipulates cpus_allowed in an atomic fashion (xchg
> or cmpxchg) this will be fine.  I'd argue it has to do this anyhow
> (unless a task is changing its own cpus_allowed field).

atomic updates of cpus_allowed it's not the point I was making, it's
still racy:

	ptrace				admin via /proc
	--------------			---------------
	save and clear
					set cpus_allowed to something
	restore cpus_allowed <destroy modification>

the modification of the user is been destroyed if he sets cpus_allowed
inside ptrace, this is the race condition I was thinking about.
	
> If you don't like the cpus_allowed approach, please propose another
> solution that ensures that the task does not get woken up while ptrace

For making sure the task isn't wakenup while it's under ptrace we should
just do that in kernel/signal.c::ignored_signal() as far I can tell.

To ensure the task just sleeps I suggest the one I mentioned in the
previous email. here a patch (possibly breaks PTRACE_KILL, I didn't
backed out the PTRACE_KILL change yet):

--- 2.4.10pre4aa1/arch/i386/kernel/ptrace.c.~1~	Sat Jul 21 00:04:05 2001
+++ 2.4.10pre4aa1/arch/i386/kernel/ptrace.c	Fri Sep  7 03:19:53 2001
@@ -171,12 +171,15 @@
 	ret = -ESRCH;
 	if (!(child->ptrace & PT_PTRACED))
 		goto out_tsk;
-	if (child->state != TASK_STOPPED) {
-		if (request != PTRACE_KILL)
-			goto out_tsk;
-	}
+	if (child->state != TASK_STOPPED && child->state != TASK_ZOMBIE)
+		goto out_tsk;
 	if (child->p_pptr != current)
 		goto out_tsk;
+#ifdef CONFIG_SMP
+	rmb(); /* read child->has_cpu after child->state */
+	while (child->has_cpu);
+	mb(); /* allowed to work on the task only when the task is been descheduled */
+#endif
 	switch (request) {
 	/* when I and D space are separate, these will need to be fixed. */
 	case PTRACE_PEEKTEXT: /* read word at location addr. */ 


Andrea

