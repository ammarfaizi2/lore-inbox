Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbVKEXU0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbVKEXU0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 18:20:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbVKEXU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 18:20:26 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:63407 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750707AbVKEXUZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 18:20:25 -0500
Date: Sat, 5 Nov 2005 15:20:28 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, dipankar@in.ibm.com, suzannew@cs.pdx.edu
Subject: Re: [PATCH] Fixes for RCU handling of task_struct
Message-ID: <20051105232027.GA20178@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20051031020535.GA46@us.ibm.com> <20051031140459.GA5664@elte.hu> <20051031205119.5bd897f3.akpm@osdl.org> <20051103190916.GA13417@us.ibm.com> <436B9D5D.3EB28CD5@tv-sign.ru> <20051104200801.GA16092@us.ibm.com> <436CDEAC.A7D56A94@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <436CDEAC.A7D56A94@tv-sign.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2005 at 07:32:44PM +0300, Oleg Nesterov wrote:
> "Paul E. McKenney" wrote:
> >
> > > > -       spin_lock_irqsave(&p->sighand->siglock, flags);
> > > > +       spin_lock_irqsave(&sh->siglock, flags);
> > >
> > > But 'sh' can be NULL, no? Yes, you already checked PF_EXITING, so this is
> > > very unlikely, but I think it is still possible in theory. 'sh' was loaded
> > > before reading p->flags, but rcu_read_lock() does not imply memory barrier.
> >
> > 'sh' cannot be NULL, because the caller holds ->it_lock and has checked
> > for timer deletion under that lock, and because the exiting process
> > quiesces and deletes timers before freeing sighand.
>                ^^^^^^^^^^^^^^
> 
> Exiting process (thread group) - yes, but exiting thread - no. That is why
> send_sigqueue() should check that the target thread is not exiting now. If
> we do not take tasklist_lock we can't be sure that ->sighand != NULL. The
> caller holds ->it_lock, yes, but this can't help.
> 
> Please don't be confused by the 'posix_cpu_timers_exit(tsk)' in __exit_signal()
> which is called under sighand->siglock before clearing ->signal/->sighand. This
> is completely different, it detaches (but not destroys) cpu-timers, these timers
> can have another thread/process as a target for signal sending.

OK, thank you for catching this!

So the idea is to error out of send_sigqueue() so that posix_timer_event()
will instead call send_group_sigqueeue().  But that could suffer from
the same race if the new leader thread also exits -- or if the exiting
thread was the leader thread to begin with.

But once send_group_sigqueue() read-acquires tasklist_lock, threads
and processes must stay put.  So it should be possible to follow the
->group_leader chain at that point.  We know that there must still be a
group leader because we hold it_lock (so that the entire process cannot
have vanished prior to acquiring tasklist_lock), and the group leader
cannot change because we are read-holding tasklist_lock.  Hence traversing
all of the group_leader pointers has to get us somewhere safe to dump
the signal.

Except that the group leader could do an exec(), right?  If it does so,
it must do so before tasklist_lock is read-acquired.  So the nightmare
case is where all but one thread exits, and then that one thread does
and exec().  If this case can really happen, we want to drop the signal
on the floor, right?

Attached is an incremental patch for everything except for the possible
race with exec().

Thoughts?

						Thanx, Paul

Signed-off-by: <paulmck@us.ibm.com>

---

 signal.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletion(-)

diff -urpNa -X dontdiff linux-2.6.14-mm0-fix/kernel/signal.c linux-2.6.14-mm0-fix-2/kernel/signal.c
--- linux-2.6.14-mm0-fix/kernel/signal.c	2005-11-04 17:23:40.000000000 -0800
+++ linux-2.6.14-mm0-fix-2/kernel/signal.c	2005-11-05 15:05:38.000000000 -0800
@@ -1408,6 +1408,11 @@ send_sigqueue(int sig, struct sigqueue *
 
 retry:
 	sh = rcu_dereference(p->sighand);
+	if (sh == NULL) {
+		/* We raced with pthread_exit()... */
+		ret = -1;
+		goto out_err;
+	}
 
 	spin_lock_irqsave(&sh->siglock, flags);
 	if (p->sighand != sh) {
@@ -1474,7 +1479,8 @@ send_group_sigqueue(int sig, struct sigq
 	BUG_ON(!(q->flags & SIGQUEUE_PREALLOC));
 
 	read_lock(&tasklist_lock);
-	/* Since it_lock is held, p->sighand cannot be NULL. */
+	while (p->group_leader != p)
+		p = p->group_leader;
 	spin_lock_irqsave(&p->sighand->siglock, flags);
 	handle_stop_signal(sig, p);
 
