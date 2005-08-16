Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932653AbVHPLpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932653AbVHPLpU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 07:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932643AbVHPLpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 07:45:19 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:62654 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932658AbVHPLpS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 07:45:18 -0400
Message-ID: <4301D455.AC721EB7@tv-sign.ru>
Date: Tue, 16 Aug 2005 15:56:05 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: paulmck@us.ibm.com
Cc: Ingo Molnar <mingo@elte.hu>, Dipankar Sarma <dipankar@in.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC,PATCH] Use RCU to protect tasklist for unicast signals
References: <42FB41B5.98314BA5@tv-sign.ru> <20050812015607.GR1300@us.ibm.com> <42FC6305.E7A00C0A@tv-sign.ru> <20050815174403.GE1562@us.ibm.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul E. McKenney wrote:
>
> OK, the attached instead revalidates that the task struct still references
> the sighand_struct after obtaining the lock

Personally I think this is a way to go. A nitpick suggestion,
could you make a separate function (say, lock_task_sighand)
which does all this job?

> > and there are some remaining problems
> > that I need to sort out, including:
> ...
>
> o	Some of the functions invoked by __group_send_sig_info(),
> 	including handle_stop_signal(), momentarily drop ->siglock.

Just to be sure that one point doesn't escape your attention, this:

> +++ linux-2.6.13-rc4-realtime-preempt-V0.7.53-01-tasklistRCU/kernel/signal.c	2005-08-14 19:53:28.000000000 -0700
> @@ -328,9 +328,11 @@ void __exit_sighand(struct task_struct *
>  	struct sighand_struct * sighand = tsk->sighand;
>  
>  	/* Ok, we're done with the signal handlers */
> +	spin_lock(&sighand->siglock);
>  	tsk->sighand = NULL;
>  	if (atomic_dec_and_test(&sighand->count))
> -		kmem_cache_free(sighand_cachep, sighand);
> +		sighand_free(sighand);
> +	spin_unlock(&sighand->siglock);

is not enough (and unneeded). Unless I missed something, we have
a race:

release_task:

	__exit_signal:
		spin_lock(sighand);
		spin_unlock(sighand);
		flush_sigqueue(&sig->shared_pending);
		kmem_cache_free(tsk->signal);
							// here comes group_send_sig_info(), locks ->sighand,
							// delivers the signal to the ->shared_pending.
							// siginfo leaked, or crash.
	__exit_sighand:
		spin_lock(sighand);
		tsk->sighand = NULL;
		// too late !!!!

I think that release_task() should not use __exit_sighand()
at all. Instead, __exit_signal() should set tsk->sighand = NULL
under ->sighand->lock.

>  int group_send_sig_info(int sig, struct siginfo *info, struct task_struct *p)
>  {
>  	unsigned long flags;
> +	struct sighand_struct *sp;
>  	int ret;
>
> +retry:
>  	ret = check_kill_permission(sig, info, p);
> -	if (!ret && sig && p->sighand) {
> +	if (!ret && sig && (sp = p->sighand)) {
>  		if (!get_task_struct_rcu(p)) {
>  			return -ESRCH;
>  		}
> -		spin_lock_irqsave(&p->sighand->siglock, flags);
> +		spin_lock_irqsave(&sp->siglock, flags);
> +		if (p->sighand != sp) {
> +			spin_unlock_irqrestore(&sp->siglock, flags);
> +			put_task_struct(p);
> +			goto retry;
> +		}
>  		ret = __group_send_sig_info(sig, info, p);
> -		spin_unlock_irqrestore(&p->sighand->siglock, flags);
> +		spin_unlock_irqrestore(&sp->siglock, flags);
>  		put_task_struct(p);

Do we really need get_task_struct_rcu/put_task_struct here?

The task_struct can't go away under us, it is rcu protected.
When ->sighand is locked, and it is still the same after
the re-check, it means that 'p' has not done __exit_signal()
yet, so it is safe to send the signal.

And if the task has ->usage == 0, it means that it also has
->sighand == NULL, and your code will notice that.

No?

Oleg.
