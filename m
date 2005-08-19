Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbVHSB2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbVHSB2p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 21:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbVHSB2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 21:28:45 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:46300 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750715AbVHSB2p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 21:28:45 -0400
Date: Thu, 18 Aug 2005 18:29:18 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Ingo Molnar <mingo@elte.hu>, Dipankar Sarma <dipankar@in.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC,PATCH] Use RCU to protect tasklist for unicast signals
Message-ID: <20050819012918.GG1372@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <42FB41B5.98314BA5@tv-sign.ru> <20050812015607.GR1300@us.ibm.com> <42FC6305.E7A00C0A@tv-sign.ru> <20050815174403.GE1562@us.ibm.com> <4301D455.AC721EB7@tv-sign.ru> <20050816170714.GA1319@us.ibm.com> <20050817014857.GA3192@us.ibm.com> <43034B17.3DEE0884@tv-sign.ru> <20050817211957.GN1300@us.ibm.com> <43047570.4089FCF1@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43047570.4089FCF1@tv-sign.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2005 at 03:48:00PM +0400, Oleg Nesterov wrote:
> Paul E. McKenney wrote:
> >
> > On Wed, Aug 17, 2005 at 06:35:03PM +0400, Oleg Nesterov wrote:
> > >
> > > Sorry, I don't understand you. CLONE_THREAD implies CLONE_SIGHAND,
> > > so we always need to lock one ->sighand. Could you please clarify?
> >
> > On the #3 and #4 code paths, the code assumes that the task-list lock
> > is held.  So I was thinking of something (very roughly) as follows:
> >
> > #define SIGLOCK_HOLD_RCU      (1 << 0)
> > #define SIGLOCK_HOLD_TASKLIST (1 << 1)
> > #define SIGLOCK_HOLD_SIGLOCK  (1 << 2)
> 
> Oh, no, sorry for confusion.
> 
> I meant this function should only lock ->sighand, nothing more, something
> like this:
> 
> // must be called with preemtion disabled !!!
> struct sighand_struct *lock_task_sighand(struct task_struct *tsk, unsigned long *flags)
> {
> 	struct sighand_struct *sighand;
> 
> //	sighand = NULL;
> //	if (!get_task_struct_rcu(tsk))
> //		goto out;
> 
> 	for (;;) {
> 		sighand = tsk->sighand;
> 		if (unlikely(sighand == NULL))
> 			break;
> 
> 		spin_lock_irqsave(sighand->siglock, *flags);
> 
> 		if (likely(sighand == tsk->sighand)
> 			goto out;
> 
> 		spin_unlock_irqrestore(sighand->siglock, *flags);
> 	}
> 
> //	put_task_struct(tsk);
> out:
> 	return sighand;
> }
> 
> static inline void unlock_task_sighand(struct task_struct *tsk, unsigned long *flags)
> {
> 	spin_unlock_irqrestore(tsk->sighand->siglock, flags);
> //	put_task_struct(tsk);
> }
> 
> int group_send_sig_info(int sig, struct siginfo *info, struct task_struct *p)
> {
> 	unsigned long flags;
> 	int ret;
> 
> 	ret = check_kill_permission(sig, info, p);
> 	if (!ret && sig) {
> 		ret = -ESRCH;
> 		if (lock_task_sighand(p, &flags)) {
> 			ret = __group_send_sig_info(sig, info, p);
> 			unlock_task_sighand(p, &flags);
> 		}
> 	}
> 
> 	return ret;
> }
> 
> Currently the only user of it will be group_send_sig_info(),

Well, that is one reason that I didn't think that you were talking
about lock_task_sighand() working only on siglock...

>                                                              but I hope
> you have devil plans to kill the "tasklist_lock guards the very rare
> ->sighand change" finally :)

;-)

I have indeed been thinking along these lines, but all of the devil plans
that I have come up thus far are quite intrusive, and might have some
performance problems in some situations.  So it seems best to remove
tasklist_lock in steps:

1.	Single-recipient catch and ignore cases.

2.	Single-recipient stop/continue cases.

3.	Single-recipient fatal cases.

4.	Single-process multi-threaded stop/continue cases.

5.	Single-process multi-threaded fatal cases.

6.	And on to process-group cases.

There are a number of ways of handling this, and they all have some
scary aspects (and here you thought the current patches were scary!!!):

1.	Provide a single signal-reception data structure for each
	multi-recipient case: process for multithreaded processes,
	process-group leader for process-group signals, controlling
	terminal for tty-based signals.  The task delivering the
	signal records the signal (perhaps queuing it) on the
	signal-reception data structure, and sends an IPI to each
	CPU currently running one of the affected tasks.

	What about the tasks not currently running?  There are a
	number of devil-planlet alternatives possible here:

	a.	Have a daemon responsible for waking up any signaled
		tasks (assuming that they are blocked or sleeping
		interruptibly).

	b.	Have the tasks running on the CPUs each wake up 
		one sleeping task, who in turn wake up another
		once they receive the signal, and so on.

	c.	Have tasks check their signal-reception data structures
		(might have up to three: process, process group,
		controlling terminal).  Hopefully can get by with
		a very few such checks, but...

	What to do if several signals arrive at about the same time?
	What about consistent ordering of signals to different groups
	with partially overlapping task membership?  Are we allowed
	to see different signal orderings for different tasks sharing
	two different groupings?  Devil-planlet alternatives:

	a.	Serialize on controlling terminal (but this might as
		well be a global lock on single-user systems).

	b.	Allow signals to arrive in different orders at different
		threads of a process, if the different signals are
		targetted at different groups (e.g., process vs.
		process group vs. controlling terminal).

		Is POSIX OK with this?  I certainly hope so!!!  :-/

	c.	Have a signal-delivery kernel task to do the
		actual delivery.  This seems like overkill to me.

2.	Have a signal-delivery daemon do the delivery, so that
	the sender need only record the presence of the signal.
	This option would at least keep the context-switch code
	fully fit and exercised.  Other than that, it seems not
	to be all that good.

There are probably others.  But all are quite intrusive, and I think it
would be better to get a partial step into mainline sooner, and follow
up with improvements later.

So, what am I missing?  ;-)

							Thanx, Paul
