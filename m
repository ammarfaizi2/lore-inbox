Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758792AbWLCXIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758792AbWLCXIE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 18:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758801AbWLCXIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 18:08:04 -0500
Received: from sp604001mt.neufgp.fr ([84.96.92.60]:52369 "EHLO Smtp.neuf.fr")
	by vger.kernel.org with ESMTP id S1758792AbWLCXIB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 18:08:01 -0500
Date: Mon, 04 Dec 2006 00:08:01 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: PATCH? rcu_do_batch: fix a pure theoretical memory ordering race
In-reply-to: <20061203221227.GA468@oleg>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org
Message-id: <457358D1.3050601@cosmosbay.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 8BIT
References: <20061202212517.GA1199@oleg> <45730AAD.1050006@cosmosbay.com>
 <20061203200153.GA107@oleg> <457334C4.8010604@cosmosbay.com>
 <20061203221227.GA468@oleg>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov a écrit :
> On 12/03, Eric Dumazet wrote:
>> Oleg Nesterov a ?crit :
>>
>> Yes, but how is it related to RCU ?
>> I mean, rcu_do_batch() is just a loop like others in kernel.
>> The loop itself is not buggy, but can call a buggy function, you are right.
> 
> 	int start_me_again;
> 
> 	struct rcu_head rcu_head;
> 
> 	void rcu_func(struct rcu_head *rcu)
> 	{
> 		start_me_again = 1;
> 	}
> 
> 	// could be called on arbitrary CPU
> 	void check_start_me_again(void)
> 	{
> 		static spinlock_t lock;
> 
> 		spin_lock(lock);
> 		if (start_me_again) {
> 			start_me_again = 0;
> 			call_rcu(&rcu_head, rcu_func);
> 		}
> 		spin_unlock(lock);
> 	}
> 
> I'd say this code is not buggy.

Are you sure ? Can you prove it ? :)

I do think your rcu_func() misses some sync primitive, *after* start_me_again=1;
You seem to rely on some undocumented side effect.
Adding smp_rmb() before calling rcu_func() wont help.

> 
> In case it was not clear. I do not claim we need this patch (I don't know).
> And yes, I very much doubt we can hit this problem in practice (even if I am
> right).
> 
> What I don't agree with is that it is callback which should take care of this
> problem.
> 
>> A smp_rmb() wont avoid all possible bugs...
> 
> For example?

A smp_rmb() wont avoid stores pending on this CPU to be committed to memory 
after another cpu takes the object for itself. Those stores could overwrite 
stores done by the other cpu as well.

So in theory you could design a buggy callback function even after your patch 
applied.

Any function that can transfer an object from CPU A scope to CPU B scope must 
take care of memory barrier by itself. The caller *cannot* possibly do the 
job, especially if it used an indirect call. However, in some cases it is 
possible some clever algos are doing the reverse, ie doing the memory barrier 
in the callers.

Kernel is full of such constructs :

for (ptr = head; ptr != NULL ; ptr = next) {
	next = ptr->next;
	some_subsys_delete(ptr);
}

And we dont need to add smp_rmb() before the call to some_subsys_delete(), it 
would be a nightmare, and would slow down modern cpus.

When the callback function dont need a memory barrier, why should we force a 
generic one in the caller ?

AFAIK most kfree() calls dont need a barrier, since slab just queue the 
pointer into the cpu's array_cache if there is one available slot.


