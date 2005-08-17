Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbVHQOYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbVHQOYK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 10:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbVHQOYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 10:24:10 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:19898 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751140AbVHQOYJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 10:24:09 -0400
Message-ID: <43034B17.3DEE0884@tv-sign.ru>
Date: Wed, 17 Aug 2005 18:35:03 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: paulmck@us.ibm.com
Cc: Ingo Molnar <mingo@elte.hu>, Dipankar Sarma <dipankar@in.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC,PATCH] Use RCU to protect tasklist for unicast signals
References: <42FB41B5.98314BA5@tv-sign.ru> <20050812015607.GR1300@us.ibm.com> <42FC6305.E7A00C0A@tv-sign.ru> <20050815174403.GE1562@us.ibm.com> <4301D455.AC721EB7@tv-sign.ru> <20050816170714.GA1319@us.ibm.com> <20050817014857.GA3192@us.ibm.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul E. McKenney wrote:
>
> > The other thing that jumped out at me is that signals are very different
> > animals from a locking viewpoint depending on whether they are:
> >
> > 1.	ignored,
> >
> > 2.	caught by a single thread,
> >
> > 3.	fatal to multiple threads/processes (though I don't know
> > 	of anything that shares sighand_struct between separate
> > 	processes), or
> >
> > 4.	otherwise global to multiple threads/processes (such as
> > 	SIGSTOP and SIGCONT).
> >
> > And there are probably other distinctions that I have not yet caught
> > on to.
> >
> > One way to approach this would be to make your suggested lock_task_sighand()
> > look at the signal and acquire the appropriate locks.  If, having acquired
> > a given set of locks, it found that the needed set had changed (e.g., due
> > to racing exec() or sigaction()), then it drops the locks and retries.
>
> OK, for this sort of approach to work, lock_task_sighand() must take and
> return some sort of mask indicating what locks are held.  The mask returned
> by lock_task_sighand() would then be passed to an unlock_task_sighand().

Sorry, I don't understand you. CLONE_THREAD implies CLONE_SIGHAND,
so we always need to lock one ->sighand. Could you please clarify?

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

Yes, this is bad and should be fixed, I agree.

But why do you think we need to bump task->usage? It can't make any
difference, afaics. The task_struct can't dissapear, the caller was
converted to use rcu_read_lock() or it holds tasklist_lock.

Nonzero task_struct->usage can't stop do_exit or sys_wait4, it will
only postpone call_rcu(__put_task_struct_cb).

And after we locked ->sighand we have sufficient memory barrier, so
if we read the stale value into 'sp' we will notice that (if you were
worried about this issue).

Am I missed something?

>  void exit_sighand(struct task_struct *tsk)
>  {
>  	write_lock_irq(&tasklist_lock);
> -	__exit_sighand(tsk);
> +	spin_lock(&tsk->sighand->siglock);
> +	if (tsk->sighand != NULL) {
> +		__exit_sighand(tsk);
> +	}
> +	spin_unlock(&tsk->sighand->siglock);
>  	write_unlock_irq(&tasklist_lock);
>  }

Very strange code. Why this check? And what happens with

	spin_unlock(&tsk->sighand->siglock);

when tsk->sighand == NULL ?

Oleg.
