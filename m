Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269454AbRIGASt>; Thu, 6 Sep 2001 20:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269515AbRIGASk>; Thu, 6 Sep 2001 20:18:40 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:57697 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S269454AbRIGAS3>; Thu, 6 Sep 2001 20:18:29 -0400
Date: Fri, 7 Sep 2001 02:19:00 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: David Mosberger <davidm@hpl.hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] proposed fix for ptrace() SMP race
Message-ID: <20010907021900.L11329@athlon.random>
In-Reply-To: <200109062300.QAA27430@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200109062300.QAA27430@napali.hpl.hp.com>; from davidm@hpl.hp.com on Thu, Sep 06, 2001 at 04:00:51PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2001 at 04:00:51PM -0700, David Mosberger wrote:
> There is currently a nasty race condition in ptrace().  The effect of

Last time I checked for such race it was looking ok (on x86). Do you
have a testcase to demonstrate it?

> this varies from one platform to another but, for example, on ia64, it
> could have the effect of corrupting the state of register f32-f127.
> The problem is that ptrace() uses the expression (child->state ==
> TASK_STOPPED) to determine whether or not a task has stopped
> execution.  On SMP, this is not sufficient because the task may still
> be executing while child->has_cpu is true.  This is easy to fix, but

but it cannot be running in "userspace" any longer once it is set to
TASK_STOPPED which should be the _only_ thing we care in ptrace. If it's
still running it's in its way to schedule() a few lines after the
setting of tsk->state to TASK_STOPPED and that's ok for ptrace.

> clearing child->cpus_allowed while ptrace() is running.  This should

abusing cpus_allowed to forbid scheduling is racy so quite unacceptable,
we want to preserve the cpus_allowed field for the administrator (he
could as well set it during the ptrace).

If on ia64 you really need to have switched the task away completly (not
only out of userspace) you could do this instead of messing with
cpus_allowed:

	if (not task_stopped)
		return
#ifdef CONFIG_SMP
	rmb(); /* read child->has_cpu after child->state */
	while (child->has_cpu);
	mb(); /* allowed to work on the task only when the task is been descheduled */
#endif

in ia64/kernel/ptrace.c

Actually one scary thing I can see in ptrace is the PTRACE_KILL case
that goes ahead doing the get_stack_long and put_stack_long even if the
task isn't out of userspace. I'd feel better with something like this:

--- 2.4.10pre4aa1/arch/i386/kernel/ptrace.c.~1~	Sat Jul 21 00:04:05 2001
+++ 2.4.10pre4aa1/arch/i386/kernel/ptrace.c	Fri Sep  7 02:14:45 2001
@@ -171,10 +171,8 @@
 	ret = -ESRCH;
 	if (!(child->ptrace & PT_PTRACED))
 		goto out_tsk;
-	if (child->state != TASK_STOPPED) {
-		if (request != PTRACE_KILL)
-			goto out_tsk;
-	}
+	if (child->state != TASK_STOPPED || child->state != TASK_ZOMBIE)
+		goto out_tsk;
 	if (child->p_pptr != current)
 		goto out_tsk;
 	switch (request) {


but OTOH I've no idea who is using PTRACE_KILL (but still it looks
saner or otherwise it means PTRACE_KILL implementation is at least
partly wrong anyways).

Andrea
