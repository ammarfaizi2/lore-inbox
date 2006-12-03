Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759969AbWLCXr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759969AbWLCXr7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 18:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759973AbWLCXr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 18:47:59 -0500
Received: from host-233-54.several.ru ([213.234.233.54]:46549 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S1759969AbWLCXr7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 18:47:59 -0500
Date: Mon, 4 Dec 2006 02:46:38 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org
Subject: Re: PATCH? rcu_do_batch: fix a pure theoretical memory ordering race
Message-ID: <20061203234638.GA506@oleg>
References: <20061202212517.GA1199@oleg> <45730AAD.1050006@cosmosbay.com> <20061203200153.GA107@oleg> <457334C4.8010604@cosmosbay.com> <20061203221227.GA468@oleg> <457358D1.3050601@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <457358D1.3050601@cosmosbay.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04, Eric Dumazet wrote:
>
> Oleg Nesterov a ?crit :
> >
> >	int start_me_again;
> >
> >	struct rcu_head rcu_head;
> >
> >	void rcu_func(struct rcu_head *rcu)
> >	{
> >		start_me_again = 1;
> >	}
> >
> >	// could be called on arbitrary CPU
> >	void check_start_me_again(void)
> >	{
> >		static spinlock_t lock;
> >
> >		spin_lock(lock);
> >		if (start_me_again) {
> >			start_me_again = 0;
> >			call_rcu(&rcu_head, rcu_func);
> >		}
> >		spin_unlock(lock);
> >	}
> >
> >I'd say this code is not buggy.
> 
> Are you sure ? Can you prove it ? :)

Looks like you think differently :)

> I do think your rcu_func() misses some sync primitive, *after* 
> start_me_again=1;
> You seem to rely on some undocumented side effect.
> Adding smp_rmb() before calling rcu_func() wont help.

I guess you mean that check_start_me_again() can miss start_me_again != 0 ?
Yes, of course, it should check the condition from time to time. We can even
do
	start_me_again = 1;
	wake_up(&start_me_again_wq);

, this is still unsafe.

> >>A smp_rmb() wont avoid all possible bugs...
> >
> >For example?
> 
> A smp_rmb() wont avoid stores pending on this CPU to be committed to memory 
> after another cpu takes the object for itself. Those stores could overwrite 
> stores done by the other cpu as well.

Yes. But RCU core doesn't write to rcu_head (except call_rcu). Callback _owns_
rcu_head, it should be ok to use it in any way without fear to break RCU.
Of course, callback should take care of its own locking/ordering.

> So in theory you could design a buggy callback function even after your 
> patch applied.

So. Do you claim that rcu_func() above is buggy?

> Any function that can transfer an object from CPU A scope to CPU B scope 
> must take care of memory barrier by itself. The caller *cannot* possibly do 
> the job, especially if it used an indirect call. However, in some cases it 
> is possible some clever algos are doing the reverse, ie doing the memory 
> barrier in the callers.
> 
> Kernel is full of such constructs :
> 
> for (ptr = head; ptr != NULL ; ptr = next) {
> 	next = ptr->next;
> 	some_subsys_delete(ptr);
> }
> 
> And we dont need to add smp_rmb() before the call to some_subsys_delete(), 
> it would be a nightmare, and would slow down modern cpus.

Agreed.

Oleg.

