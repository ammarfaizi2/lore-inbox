Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751288AbVHQVT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbVHQVT0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 17:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbVHQVT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 17:19:26 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:40077 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751288AbVHQVTZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 17:19:25 -0400
Date: Wed, 17 Aug 2005 14:19:57 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Ingo Molnar <mingo@elte.hu>, Dipankar Sarma <dipankar@in.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC,PATCH] Use RCU to protect tasklist for unicast signals
Message-ID: <20050817211957.GN1300@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <42FB41B5.98314BA5@tv-sign.ru> <20050812015607.GR1300@us.ibm.com> <42FC6305.E7A00C0A@tv-sign.ru> <20050815174403.GE1562@us.ibm.com> <4301D455.AC721EB7@tv-sign.ru> <20050816170714.GA1319@us.ibm.com> <20050817014857.GA3192@us.ibm.com> <43034B17.3DEE0884@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43034B17.3DEE0884@tv-sign.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2005 at 06:35:03PM +0400, Oleg Nesterov wrote:
> Paul E. McKenney wrote:
> >
> > > The other thing that jumped out at me is that signals are very different
> > > animals from a locking viewpoint depending on whether they are:
> > >
> > > 1.	ignored,
> > >
> > > 2.	caught by a single thread,
> > >
> > > 3.	fatal to multiple threads/processes (though I don't know
> > > 	of anything that shares sighand_struct between separate
> > > 	processes), or
> > >
> > > 4.	otherwise global to multiple threads/processes (such as
> > > 	SIGSTOP and SIGCONT).
> > >
> > > And there are probably other distinctions that I have not yet caught
> > > on to.
> > >
> > > One way to approach this would be to make your suggested lock_task_sighand()
> > > look at the signal and acquire the appropriate locks.  If, having acquired
> > > a given set of locks, it found that the needed set had changed (e.g., due
> > > to racing exec() or sigaction()), then it drops the locks and retries.
> >
> > OK, for this sort of approach to work, lock_task_sighand() must take and
> > return some sort of mask indicating what locks are held.  The mask returned
> > by lock_task_sighand() would then be passed to an unlock_task_sighand().
> 
> Sorry, I don't understand you. CLONE_THREAD implies CLONE_SIGHAND,
> so we always need to lock one ->sighand. Could you please clarify?

On the #3 and #4 code paths, the code assumes that the task-list lock
is held.  So I was thinking of something (very roughly) as follows:

#define SIGLOCK_HOLD_RCU      (1 << 0)
#define SIGLOCK_HOLD_TASKLIST (1 << 1)
#define SIGLOCK_HOLD_SIGLOCK  (1 << 2)

int lock_task_sighand(int sig, struct task_struct *p, int locksheld, struct sighand_struct **spp, int *flags)
{
	int locksret = 0;
	struct sighand_struct *sp;

retry:
	if (!(locksheld & SIGLOCK_HOLD_RCU)) {
		locksret |= SIGLOCK_HOLD_RCU;
		rcu_read_lock();
	}
	sp = rcu_dereference(p->sighand);
	if (sp == NULL) {
		unlock_task_sighand(NULL, locksret, *flags);
		*spp = NULL;
		return 0;
	}
	if (!(locksheld & SIGLOCK_HOLD_TASKLIST)) {
		/* Complain if siglock held. */
		if (sig_kernel_stop(sig) /* expand for other conditions */) {
			locksret |= SIGLOCK_HOLD_TASKLIST;
			read_lock(&tasklist_lock);
		}
	}
	if (!(locksheld & SIGLOCK_HOLD_SIGLOCK)) {
		*flags = 0;
	} else {
		locksret |= SIGLOCK_HOLD_SIGLOCK;
		spin_lock_irqsave(&sp->siglock, *flags);
		if (p->sighand != sp) {
			unlock_task_sighand(sp, locksret, *flags);
			goto retry;
		}
	}
	*spp = sp;
	return locksret;
}

void unlock_task_sighand(struct sighand_struct *sp, int lockstodrop, int flags)
{
	/* lockstodrop had better be non-negative! */

	if (lockstodrop & SIGLOCK_HOLD_SIGLOCK) {
		spin_unlock_irqrestore(&sp->siglock, flags);
	}
	if (lockstodrop & SIGLOCK_HOLD_TASKLIST) {
		read_unlock(&tasklist_lock);
	}
	if (lockstodrop & SIGLOCK_HOLD_RCU) {
		rcu_read_unlock();
	}
}

The "expand for other conditions" must also cover signals that cause
coredumps, that kill all threads in a process, or that otherwise affect
more than one thread (e.g., kill with a negative signal number).  I am
assuming that your argument about not needing the get_task_struct_rcu()
eventually work their way through my skull.  ;-)

Of course, the "expand for other conditions" requires reference to the
sighand_struct.  And for that, you really need to be holding siglock.
But you have to drop siglock to acquire tasklist_lock.  So will end up
relying on RCU some more to safely peek into sighand_struct -before-
acquiring siglock -- which is why I snapshot p->sighand so early, it
will need to be referenced when checking "other conditions".

I am not exactly happy with the above pair of functions, but I suspect
that they might -really- simplify things a bit.

The usage would be as follows:

	if ((lockstodrop = lock_task_sighand(sig, tsk, 0, &sp, &flags)) < 0)
		return lockstodrop;  /* error code */
	if (sp != NULL) {
		/* invoke the function to send the signal */
	}
	unlock_task_sighand(sp, lockstodrop, flags);

Thoughts?  Hey, you asked for this!!!  ;-)

> > > > +	if (!ret && sig && (sp = p->sighand)) {
> > > >  		if (!get_task_struct_rcu(p)) {
> > > >  			return -ESRCH;
> > > >  		}
> > > > -		spin_lock_irqsave(&p->sighand->siglock, flags);
> > > > +		spin_lock_irqsave(&sp->siglock, flags);
> > > > +		if (p->sighand != sp) {
> > > > +			spin_unlock_irqrestore(&sp->siglock, flags);
> > > > +			put_task_struct(p);
> > > > +			goto retry;
> > > > +		}
> > > >  		ret = __group_send_sig_info(sig, info, p);
> > > > -		spin_unlock_irqrestore(&p->sighand->siglock, flags);
> > > > +		spin_unlock_irqrestore(&sp->siglock, flags);
> > > >  		put_task_struct(p);
> > >
> > > Do we really need get_task_struct_rcu/put_task_struct here?
> > >
> > > The task_struct can't go away under us, it is rcu protected.
> > > When ->sighand is locked, and it is still the same after
> > > the re-check, it means that 'p' has not done __exit_signal()
> > > yet, so it is safe to send the signal.
> > >
> > > And if the task has ->usage == 0, it means that it also has
> > > ->sighand == NULL, and your code will notice that.
> > >
> > > No?
> >
> > Seems plausible.  I got paranoid after seeing the lock dropped in
> > handle_stop_signal(), though.
> 
> Yes, this is bad and should be fixed, I agree.
> 
> But why do you think we need to bump task->usage? It can't make any
> difference, afaics. The task_struct can't dissapear, the caller was
> converted to use rcu_read_lock() or it holds tasklist_lock.
> 
> Nonzero task_struct->usage can't stop do_exit or sys_wait4, it will
> only postpone call_rcu(__put_task_struct_cb).
> 
> And after we locked ->sighand we have sufficient memory barrier, so
> if we read the stale value into 'sp' we will notice that (if you were
> worried about this issue).
> 
> Am I missed something?

I doubt if you are missing anything.  I was just being paranoid.
Seeing locks get momentarily get dropped in the middle of functions is
a -really- good way to get me into that state!  But since that code
path can be called with tasklist_lock held, it should not be sleeping,
so I believe that you are correct.

Hence my switching to rcu_read_lock() in lock_task_sighand() above.

> >  void exit_sighand(struct task_struct *tsk)
> >  {
> >  	write_lock_irq(&tasklist_lock);
> > -	__exit_sighand(tsk);
> > +	spin_lock(&tsk->sighand->siglock);
> > +	if (tsk->sighand != NULL) {
> > +		__exit_sighand(tsk);
> > +	}
> > +	spin_unlock(&tsk->sighand->siglock);
> >  	write_unlock_irq(&tasklist_lock);
> >  }
> 
> Very strange code. Why this check? And what happens with
> 
> 	spin_unlock(&tsk->sighand->siglock);
> 
> when tsk->sighand == NULL ?

My bad.  Ingo beat you to it though.  ;-)

							Thanx, Paul
