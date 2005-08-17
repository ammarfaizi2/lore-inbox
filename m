Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbVHQBs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbVHQBs1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 21:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbVHQBs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 21:48:27 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:11718 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750787AbVHQBs1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 21:48:27 -0400
Date: Tue, 16 Aug 2005 18:48:57 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Ingo Molnar <mingo@elte.hu>, Dipankar Sarma <dipankar@in.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC,PATCH] Use RCU to protect tasklist for unicast signals
Message-ID: <20050817014857.GA3192@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <42FB41B5.98314BA5@tv-sign.ru> <20050812015607.GR1300@us.ibm.com> <42FC6305.E7A00C0A@tv-sign.ru> <20050815174403.GE1562@us.ibm.com> <4301D455.AC721EB7@tv-sign.ru> <20050816170714.GA1319@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050816170714.GA1319@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2005 at 10:07:14AM -0700, Paul E. McKenney wrote:
> On Tue, Aug 16, 2005 at 03:56:05PM +0400, Oleg Nesterov wrote:
> > Paul E. McKenney wrote:
> > >
> > > OK, the attached instead revalidates that the task struct still references
> > > the sighand_struct after obtaining the lock
> > 
> > Personally I think this is a way to go. A nitpick suggestion,
> > could you make a separate function (say, lock_task_sighand)
> > which does all this job?
> 
> Sounds good, will do!
> 
> The other thing that jumped out at me is that signals are very different
> animals from a locking viewpoint depending on whether they are:
> 
> 1.	ignored,
> 
> 2.	caught by a single thread,
> 
> 3.	fatal to multiple threads/processes (though I don't know
> 	of anything that shares sighand_struct between separate
> 	processes), or
> 
> 4.	otherwise global to multiple threads/processes (such as
> 	SIGSTOP and SIGCONT).
> 
> And there are probably other distinctions that I have not yet caught
> on to.
> 
> One way to approach this would be to make your suggested lock_task_sighand()
> look at the signal and acquire the appropriate locks.  If, having acquired
> a given set of locks, it found that the needed set had changed (e.g., due
> to racing exec() or sigaction()), then it drops the locks and retries.
> 
> Does this make sense?
> 
> This approach assumes that realtime latency (of the kill() operation
> itself) is critical only cases #1 and #2 above.  This makes sense to me,
> but some of you might know of situations where #3 and #4 are important.
> But I am hoping not.  ;-)

OK, for this sort of approach to work, lock_task_sighand() must take and
return some sort of mask indicating what locks are held.  The mask returned
by lock_task_sighand() would then be passed to an unlock_task_sighand().

Another alternative would be to make a macro that allowed an arbitrary
statement to be wrapped up in it.

Neither of these are as appealing as I would like -- other ideas?

I have not yet attacked this in the attached patch.

> > > > and there are some remaining problems
> > > > that I need to sort out, including:
> > > ...
> > >
> > > o	Some of the functions invoked by __group_send_sig_info(),
> > > 	including handle_stop_signal(), momentarily drop ->siglock.
> > 
> > Just to be sure that one point doesn't escape your attention, this:
> > 
> > > +++ linux-2.6.13-rc4-realtime-preempt-V0.7.53-01-tasklistRCU/kernel/signal.c	2005-08-14 19:53:28.000000000 -0700
> > > @@ -328,9 +328,11 @@ void __exit_sighand(struct task_struct *
> > >  	struct sighand_struct * sighand = tsk->sighand;
> > >  
> > >  	/* Ok, we're done with the signal handlers */
> > > +	spin_lock(&sighand->siglock);
> > >  	tsk->sighand = NULL;
> > >  	if (atomic_dec_and_test(&sighand->count))
> > > -		kmem_cache_free(sighand_cachep, sighand);
> > > +		sighand_free(sighand);
> > > +	spin_unlock(&sighand->siglock);
> > 
> > is not enough (and unneeded). Unless I missed something, we have
> > a race:
> > 
> > release_task:
> > 
> > 	__exit_signal:
> > 		spin_lock(sighand);
> > 		spin_unlock(sighand);
> > 		flush_sigqueue(&sig->shared_pending);
> > 		kmem_cache_free(tsk->signal);
> > 							// here comes group_send_sig_info(), locks ->sighand,
> > 							// delivers the signal to the ->shared_pending.
> > 							// siginfo leaked, or crash.
> > 	__exit_sighand:
> > 		spin_lock(sighand);
> > 		tsk->sighand = NULL;
> > 		// too late !!!!
> > 
> > I think that release_task() should not use __exit_sighand()
> > at all. Instead, __exit_signal() should set tsk->sighand = NULL
> > under ->sighand->lock.
> 
> Will look into this -- I was inserting the locking to handle a race with
> my revalidation.  It looks like I also need to pay some more attention
> to the race with exiting tasks, good catch!  Your suggestion of invoking
> __exit_signal() from under siglock within __exit_signal() sounds good
> at first glance, will think it through.

This turned out to be easy, the attached patch covers it.

> > >  int group_send_sig_info(int sig, struct siginfo *info, struct task_struct *p)
> > >  {
> > >  	unsigned long flags;
> > > +	struct sighand_struct *sp;
> > >  	int ret;
> > >
> > > +retry:
> > >  	ret = check_kill_permission(sig, info, p);
> > > -	if (!ret && sig && p->sighand) {
> > > +	if (!ret && sig && (sp = p->sighand)) {
> > >  		if (!get_task_struct_rcu(p)) {
> > >  			return -ESRCH;
> > >  		}
> > > -		spin_lock_irqsave(&p->sighand->siglock, flags);
> > > +		spin_lock_irqsave(&sp->siglock, flags);
> > > +		if (p->sighand != sp) {
> > > +			spin_unlock_irqrestore(&sp->siglock, flags);
> > > +			put_task_struct(p);
> > > +			goto retry;
> > > +		}
> > >  		ret = __group_send_sig_info(sig, info, p);
> > > -		spin_unlock_irqrestore(&p->sighand->siglock, flags);
> > > +		spin_unlock_irqrestore(&sp->siglock, flags);
> > >  		put_task_struct(p);
> > 
> > Do we really need get_task_struct_rcu/put_task_struct here?
> > 
> > The task_struct can't go away under us, it is rcu protected.
> > When ->sighand is locked, and it is still the same after
> > the re-check, it means that 'p' has not done __exit_signal()
> > yet, so it is safe to send the signal.
> > 
> > And if the task has ->usage == 0, it means that it also has
> > ->sighand == NULL, and your code will notice that.
> > 
> > No?
> 
> Seems plausible.  I got paranoid after seeing the lock dropped in
> handle_stop_signal(), though.

Still paranoid, but on the list for eventual cleanup after the rest of
the interactions are covered.

My tests are not finding even glaring races, so time to go and create
some torture tests before getting too much more elaborate.  10,000 eyes
are nice (and Oleg's eyes do seem to be working especially well), but
a good software-test sledgehammer has its uses as well.

						Thanx, Paul

diff -urpNa -X dontdiff linux-2.6.13-rc4-realtime-preempt-V0.7.53-01/fs/exec.c linux-2.6.13-rc4-realtime-preempt-V0.7.53-01-tasklistRCU/fs/exec.c
--- linux-2.6.13-rc4-realtime-preempt-V0.7.53-01/fs/exec.c	2005-08-11 11:44:55.000000000 -0700
+++ linux-2.6.13-rc4-realtime-preempt-V0.7.53-01-tasklistRCU/fs/exec.c	2005-08-12 21:18:33.000000000 -0700
@@ -790,7 +790,7 @@ no_thread_group:
 		write_unlock_irq(&tasklist_lock);
 
 		if (atomic_dec_and_test(&oldsighand->count))
-			kmem_cache_free(sighand_cachep, oldsighand);
+			sighand_free(oldsighand);
 	}
 
 	BUG_ON(!thread_group_empty(current));
diff -urpNa -X dontdiff linux-2.6.13-rc4-realtime-preempt-V0.7.53-01/include/linux/sched.h linux-2.6.13-rc4-realtime-preempt-V0.7.53-01-tasklistRCU/include/linux/sched.h
--- linux-2.6.13-rc4-realtime-preempt-V0.7.53-01/include/linux/sched.h	2005-08-11 11:44:57.000000000 -0700
+++ linux-2.6.13-rc4-realtime-preempt-V0.7.53-01-tasklistRCU/include/linux/sched.h	2005-08-12 21:19:34.000000000 -0700
@@ -450,8 +450,16 @@ struct sighand_struct {
 	atomic_t		count;
 	struct k_sigaction	action[_NSIG];
 	spinlock_t		siglock;
+	struct rcu_head		rcu;
 };
 
+static inline void sighand_free(struct sighand_struct *sp)
+{
+	extern void sighand_free_cb(struct rcu_head *rhp);
+
+	call_rcu(&sp->rcu, sighand_free_cb);
+}
+
 /*
  * NOTE! "signal_struct" does not have it's own
  * locking, because a shared signal_struct always
diff -urpNa -X dontdiff linux-2.6.13-rc4-realtime-preempt-V0.7.53-01/kernel/exit.c linux-2.6.13-rc4-realtime-preempt-V0.7.53-01-tasklistRCU/kernel/exit.c
--- linux-2.6.13-rc4-realtime-preempt-V0.7.53-01/kernel/exit.c	2005-08-11 11:44:57.000000000 -0700
+++ linux-2.6.13-rc4-realtime-preempt-V0.7.53-01-tasklistRCU/kernel/exit.c	2005-08-16 11:37:44.000000000 -0700
@@ -74,7 +74,6 @@ repeat: 
 		__ptrace_unlink(p);
 	BUG_ON(!list_empty(&p->ptrace_list) || !list_empty(&p->ptrace_children));
 	__exit_signal(p);
-	__exit_sighand(p);
 	/*
 	 * Note that the fastpath in sys_times depends on __exit_signal having
 	 * updated the counters before a task is removed from the tasklist of
diff -urpNa -X dontdiff linux-2.6.13-rc4-realtime-preempt-V0.7.53-01/kernel/fork.c linux-2.6.13-rc4-realtime-preempt-V0.7.53-01-tasklistRCU/kernel/fork.c
--- linux-2.6.13-rc4-realtime-preempt-V0.7.53-01/kernel/fork.c	2005-08-11 11:44:57.000000000 -0700
+++ linux-2.6.13-rc4-realtime-preempt-V0.7.53-01-tasklistRCU/kernel/fork.c	2005-08-12 21:24:00.000000000 -0700
@@ -43,6 +43,7 @@
 #include <linux/acct.h>
 #include <linux/kthread.h>
 #include <linux/notifier.h>
+#include <linux/rcupdate.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -769,6 +770,14 @@ int unshare_files(void)
 
 EXPORT_SYMBOL(unshare_files);
 
+void sighand_free_cb(struct rcu_head *rhp)
+{
+	struct sighand_struct *sp =
+		container_of(rhp, struct sighand_struct, rcu);
+
+	kmem_cache_free(sighand_cachep, sp);
+}
+
 static inline int copy_sighand(unsigned long clone_flags, struct task_struct * tsk)
 {
 	struct sighand_struct *sig;
diff -urpNa -X dontdiff linux-2.6.13-rc4-realtime-preempt-V0.7.53-01/kernel/signal.c linux-2.6.13-rc4-realtime-preempt-V0.7.53-01-tasklistRCU/kernel/signal.c
--- linux-2.6.13-rc4-realtime-preempt-V0.7.53-01/kernel/signal.c	2005-08-11 11:44:57.000000000 -0700
+++ linux-2.6.13-rc4-realtime-preempt-V0.7.53-01-tasklistRCU/kernel/signal.c	2005-08-16 16:18:22.000000000 -0700
@@ -330,13 +330,17 @@ void __exit_sighand(struct task_struct *
 	/* Ok, we're done with the signal handlers */
 	tsk->sighand = NULL;
 	if (atomic_dec_and_test(&sighand->count))
-		kmem_cache_free(sighand_cachep, sighand);
+		sighand_free(sighand);
 }
 
 void exit_sighand(struct task_struct *tsk)
 {
 	write_lock_irq(&tasklist_lock);
-	__exit_sighand(tsk);
+	spin_lock(&tsk->sighand->siglock);
+	if (tsk->sighand != NULL) {
+		__exit_sighand(tsk);
+	}
+	spin_unlock(&tsk->sighand->siglock);
 	write_unlock_irq(&tasklist_lock);
 }
 
@@ -359,6 +363,7 @@ void __exit_signal(struct task_struct *t
 		if (tsk == sig->curr_target)
 			sig->curr_target = next_thread(tsk);
 		tsk->signal = NULL;
+		__exit_sighand(tsk);
 		spin_unlock(&sighand->siglock);
 		flush_sigqueue(&sig->shared_pending);
 	} else {
@@ -390,6 +395,7 @@ void __exit_signal(struct task_struct *t
 		sig->nvcsw += tsk->nvcsw;
 		sig->nivcsw += tsk->nivcsw;
 		sig->sched_time += tsk->sched_time;
+		__exit_sighand(tsk);
 		spin_unlock(&sighand->siglock);
 		sig = NULL;	/* Marker for below.  */
 	}
@@ -1150,16 +1156,23 @@ void zap_other_threads(struct task_struc
 int group_send_sig_info(int sig, struct siginfo *info, struct task_struct *p)
 {
 	unsigned long flags;
+	struct sighand_struct *sp;
 	int ret;
 
+retry:
 	ret = check_kill_permission(sig, info, p);
-	if (!ret && sig && p->sighand) {
+	if (!ret && sig && (sp = p->sighand)) {
 		if (!get_task_struct_rcu(p)) {
 			return -ESRCH;
 		}
-		spin_lock_irqsave(&p->sighand->siglock, flags);
+		spin_lock_irqsave(&sp->siglock, flags);
+		if (p->sighand != sp) {
+			spin_unlock_irqrestore(&sp->siglock, flags);
+			put_task_struct(p);
+			goto retry;
+		}
 		ret = __group_send_sig_info(sig, info, p);
-		spin_unlock_irqrestore(&p->sighand->siglock, flags);
+		spin_unlock_irqrestore(&sp->siglock, flags);
 		put_task_struct(p);
 	}
 
