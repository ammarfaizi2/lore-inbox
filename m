Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266095AbUFJBtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266095AbUFJBtQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 21:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266072AbUFJBtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 21:49:16 -0400
Received: from mail4.speakeasy.net ([216.254.0.204]:56026 "EHLO
	mail4.speakeasy.net") by vger.kernel.org with ESMTP id S266095AbUFJBtF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 21:49:05 -0400
Date: Wed, 9 Jun 2004 18:48:58 -0700
Message-Id: <200406100148.i5A1mwHl009763@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@osdl.org>
X-Fcc: ~/Mail/linus
Cc: linux-kernel@vger.kernel.org, Jeremy Kerr <jk@ozlabs.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] Fix signal race during process exit
In-Reply-To: Andrew Morton's message of  Thursday, 3 June 2004 18:30:44 -0700 <20040603183044.40e4a95c.akpm@osdl.org>
X-Zippy-Says: I pretend I'm living in a styrofoam packing crate, high in th'
   SWISS ALPS, still unable to accept th' idea of TOUCH-TONE DIALING!!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to Rusty for the test case.  It did reproduce the crash on my test
box using vanilla 2.6.6, so we can use it to verify differing fixes as needed.

> > --- linux-2.6/kernel/signal.c 10 May 2004 20:28:20 -0000 1.120
> > +++ linux-2.6/kernel/signal.c 4 Jun 2004 01:16:31 -0000
> > @@ -161,6 +161,9 @@ static int sig_ignored(struct task_struc
> >  {
> >  	void * handler;
> >  
> > +	if (t->flags & PF_DEAD)
> > +		return 1;
> > +
> 
> I'm not sure about the locking here.  What happens if the task starts
> exitting immediately after the above test?

This is effectively governed by the tasklist_lock.  PF_DEAD is set with
tasklist_lock write-locked and irqs disabled.  All the signal code that
calls sig_ignored runs with tasklist_lock read-locked.  So whatever other
process doing this test would be blocking the exiting task at the start of
exit_notify.

Even if that were not so, this particular race concern may be moot if in
all the race situations the same aforementioned locking reality means that
any other thread would be excluded from fetching the task_struct pointer
from the list in the first place during the PF_DEAD window.

The concern I had is basically that this might not be true of all cases.
The only problem case that has come up is the current task's own interrupt
handlers calling signal code while interrupting release_task.  I know for
the case of posix-timers it's not an issue because their cleanup is handled
with special synchronization in __exit_signal.  What I'm not sure about is
all other sources of asynchronous signals that use task_struct pointers
rather than PID lookups and so might do one while release_task is in progress.
e.g. async IO signals triggered via driver interrupts, etc.

> Plus the above adds code to the delivery fastpath, rather than exit().

That is a good point.  If there are in reality not other cases to worry
about, then this is reason enough to omit what's then just a sanity check.
If other cases do appear in the wild, then perhaps we'll be lucky and they
will be the obvious null pointer dereference we got this time.  But in the
worst case, it could be the cached ->sighand or ->signal pointer to memory
that's already been reused in another thread for something else and is then
clobbered by the signaller, bringing endless joy.

I am fairly confident I understand the code for timer signals, child-death
signals, parent-death signals, and how it relates to the exit issues.  But
for any other miscellaneous asynchronous signals sent by whatever else, I
do not know for sure whether such sources are synchronously detached from
tasks during exit so as to avoid this kind of race.

> If we're going to do the above for other reasons (what are they?) then it
> would be neater to add a new PF_NO_SIGNALS rather than overloading PF_DEAD.

I wouldn't call this "overloading".  There isn't any separate "all signals
ignored by short-circuit" mode that we want to be able to enable (I don't,
anyway).  The point of the test is to short-circuit checking ->sighand or
->signal when they might be null, i.e. after exit_notify unlocks.  It could
as well check (p->state & (TASK_ZOMBIE|TASK_DEAD)), which is state checked
elsewhere in the signal code.  

My patch above is actually useless.  All calls to sig_ignored take place
with ->sighand->siglock held, so it's after the window where the timer can
produce the crash.  If the check is needed, then it's needed between:

	read_lock(&tasklist_lock);  

and:

	spin_lock_irqsave(&p->sighand->siglock, flags);

in places like send_sigqueue, send_group_sigqueue, send_sig_info,
group_send_sig_info.  Given my unsureness about other kinds of asynchronous
signals, I would be most comfortable with at least a:

	BUG_ON(p->flags & PF_DEAD);

after read_lock(&tasklist_lock); in those functions.


Back to the local fix for the case we have hit, the signals produced by
update_process_times.  I think the patch below that went in has a bug.
Perhaps I've missed something.  It seems to me that clearing it_virt_incr
doesn't really cut it, since there will be one more hit before that value
is reloaded.  Shouldn't it clear it_virt_value, as it clears it_prof_value?


Index: linux-2.6/kernel/exit.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/kernel/exit.c,v
retrieving revision 1.135
retrieving revision 1.136
diff -u -b -p -r1.135 -r1.136
--- linux-2.6/kernel/exit.c 29 May 2004 18:15:01 -0000 1.135
+++ linux-2.6/kernel/exit.c 2 Jun 2004 14:18:12 -0000 1.136
@@ -737,6 +737,14 @@ static void exit_notify(struct task_stru
 	tsk->flags |= PF_DEAD;
 
 	/*
+	 * Clear these here so that update_process_times() won't try to deliver
+	 * itimer, profile or rlimit signals to this task while it is in late exit.
+	 */
+	tsk->it_virt_incr = 0;
+	tsk->it_prof_value = 0;
+	tsk->rlim[RLIMIT_CPU].rlim_cur = RLIM_INFINITY;
+
+	/*
 	 * In the preemption case it must be impossible for the task
 	 * to get runnable again, so use "_raw_" unlock to keep
 	 * preempt_count elevated until we schedule().


And btw, as I think someone else mentioned, update_one_process really
should be made static so it can be inlined.  It has just the one caller,
update_process_times in the same file (kernel/timer.c).



Thanks,
Roland
