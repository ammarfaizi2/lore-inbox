Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030248AbVHPRGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030248AbVHPRGz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 13:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030251AbVHPRGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 13:06:54 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:31133 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030248AbVHPRGw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 13:06:52 -0400
Date: Tue, 16 Aug 2005 10:07:14 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Ingo Molnar <mingo@elte.hu>, Dipankar Sarma <dipankar@in.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC,PATCH] Use RCU to protect tasklist for unicast signals
Message-ID: <20050816170714.GA1319@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <42FB41B5.98314BA5@tv-sign.ru> <20050812015607.GR1300@us.ibm.com> <42FC6305.E7A00C0A@tv-sign.ru> <20050815174403.GE1562@us.ibm.com> <4301D455.AC721EB7@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4301D455.AC721EB7@tv-sign.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2005 at 03:56:05PM +0400, Oleg Nesterov wrote:
> Paul E. McKenney wrote:
> >
> > OK, the attached instead revalidates that the task struct still references
> > the sighand_struct after obtaining the lock
> 
> Personally I think this is a way to go. A nitpick suggestion,
> could you make a separate function (say, lock_task_sighand)
> which does all this job?

Sounds good, will do!

The other thing that jumped out at me is that signals are very different
animals from a locking viewpoint depending on whether they are:

1.	ignored,

2.	caught by a single thread,

3.	fatal to multiple threads/processes (though I don't know
	of anything that shares sighand_struct between separate
	processes), or

4.	otherwise global to multiple threads/processes (such as
	SIGSTOP and SIGCONT).

And there are probably other distinctions that I have not yet caught
on to.

One way to approach this would be to make your suggested lock_task_sighand()
look at the signal and acquire the appropriate locks.  If, having acquired
a given set of locks, it found that the needed set had changed (e.g., due
to racing exec() or sigaction()), then it drops the locks and retries.

Does this make sense?

This approach assumes that realtime latency (of the kill() operation
itself) is critical only cases #1 and #2 above.  This makes sense to me,
but some of you might know of situations where #3 and #4 are important.
But I am hoping not.  ;-)

> > > and there are some remaining problems
> > > that I need to sort out, including:
> > ...
> >
> > o	Some of the functions invoked by __group_send_sig_info(),
> > 	including handle_stop_signal(), momentarily drop ->siglock.
> 
> Just to be sure that one point doesn't escape your attention, this:
> 
> > +++ linux-2.6.13-rc4-realtime-preempt-V0.7.53-01-tasklistRCU/kernel/signal.c	2005-08-14 19:53:28.000000000 -0700
> > @@ -328,9 +328,11 @@ void __exit_sighand(struct task_struct *
> >  	struct sighand_struct * sighand = tsk->sighand;
> >  
> >  	/* Ok, we're done with the signal handlers */
> > +	spin_lock(&sighand->siglock);
> >  	tsk->sighand = NULL;
> >  	if (atomic_dec_and_test(&sighand->count))
> > -		kmem_cache_free(sighand_cachep, sighand);
> > +		sighand_free(sighand);
> > +	spin_unlock(&sighand->siglock);
> 
> is not enough (and unneeded). Unless I missed something, we have
> a race:
> 
> release_task:
> 
> 	__exit_signal:
> 		spin_lock(sighand);
> 		spin_unlock(sighand);
> 		flush_sigqueue(&sig->shared_pending);
> 		kmem_cache_free(tsk->signal);
> 							// here comes group_send_sig_info(), locks ->sighand,
> 							// delivers the signal to the ->shared_pending.
> 							// siginfo leaked, or crash.
> 	__exit_sighand:
> 		spin_lock(sighand);
> 		tsk->sighand = NULL;
> 		// too late !!!!
> 
> I think that release_task() should not use __exit_sighand()
> at all. Instead, __exit_signal() should set tsk->sighand = NULL
> under ->sighand->lock.

Will look into this -- I was inserting the locking to handle a race with
my revalidation.  It looks like I also need to pay some more attention
to the race with exiting tasks, good catch!  Your suggestion of invoking
__exit_signal() from under siglock within __exit_signal() sounds good
at first glance, will think it through.

> >  int group_send_sig_info(int sig, struct siginfo *info, struct task_struct *p)
> >  {
> >  	unsigned long flags;
> > +	struct sighand_struct *sp;
> >  	int ret;
> >
> > +retry:
> >  	ret = check_kill_permission(sig, info, p);
> > -	if (!ret && sig && p->sighand) {
> > +	if (!ret && sig && (sp = p->sighand)) {
> >  		if (!get_task_struct_rcu(p)) {
> >  			return -ESRCH;
> >  		}
> > -		spin_lock_irqsave(&p->sighand->siglock, flags);
> > +		spin_lock_irqsave(&sp->siglock, flags);
> > +		if (p->sighand != sp) {
> > +			spin_unlock_irqrestore(&sp->siglock, flags);
> > +			put_task_struct(p);
> > +			goto retry;
> > +		}
> >  		ret = __group_send_sig_info(sig, info, p);
> > -		spin_unlock_irqrestore(&p->sighand->siglock, flags);
> > +		spin_unlock_irqrestore(&sp->siglock, flags);
> >  		put_task_struct(p);
> 
> Do we really need get_task_struct_rcu/put_task_struct here?
> 
> The task_struct can't go away under us, it is rcu protected.
> When ->sighand is locked, and it is still the same after
> the re-check, it means that 'p' has not done __exit_signal()
> yet, so it is safe to send the signal.
> 
> And if the task has ->usage == 0, it means that it also has
> ->sighand == NULL, and your code will notice that.
> 
> No?

Seems plausible.  I got paranoid after seeing the lock dropped in
handle_stop_signal(), though.

							Thanx, Paul
