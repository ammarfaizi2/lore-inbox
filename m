Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752332AbWJ1NXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752332AbWJ1NXn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 09:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752329AbWJ1NXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 09:23:43 -0400
Received: from sp604003mt.neufgp.fr ([84.96.92.56]:20477 "EHLO smTp.neuf.fr")
	by vger.kernel.org with ESMTP id S1752321AbWJ1NXl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 09:23:41 -0400
Date: Sat, 28 Oct 2006 15:23:40 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [take21 1/4] kevent: Core files.
In-reply-to: <20061028130350.GA18737@2ka.mipt.ru>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org
Message-id: <454359DC.4020905@cosmosbay.com>
MIME-version: 1.0
Content-type: text/plain; charset=KOI8-R; format=flowed
Content-transfer-encoding: 7BIT
References: <11619654011980@2ka.mipt.ru> <454330BC.9000108@cosmosbay.com>
 <20061028105340.GC15038@2ka.mipt.ru> <45434ECF.4090209@cosmosbay.com>
 <20061028130350.GA18737@2ka.mipt.ru>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov a e'crit :
> On Sat, Oct 28, 2006 at 02:36:31PM +0200, Eric Dumazet (dada1@cosmosbay.com) wrote:
>> Evgeniy Polyakov a e'crit :
>>> On Sat, Oct 28, 2006 at 12:28:12PM +0200, Eric Dumazet 
>>> (dada1@cosmosbay.com) wrote:
>>>> I really dont understand how you manage to queue multiple kevents in the 
>>>> 'overflow list'. You just queue one kevent at most. What am I missing ?
>>> There is no overflow list - it is a pointer to the first kevent in the
>>> ready queue, which was not put into ring buffer. It is an optimisation, 
>>> which allows to not search for that position each time new event should 
>>> be placed into the buffer, when it starts to have an empty slot.
>> This overflow list (you may call it differently, but still it IS a list), 
>> is not complete. I feel you add it just to make me happy, but I am not (yet 
>> :) )
> 
> There is no overflow list.
> There is ready queue, part of which (first several entries) is copied
> into the ring buffer, overflow_kevent is a pointer to the first kevent which
> was not copied.
> 
>> For example, you make no test at kevent_finish_user_complete() time.
>>
>> Obviously, you can have a dangling pointer, and crash your box in certain 
>> conditions.
> 
> You are right, I did not put overflow_kevent check into all places which
> can remove kevent.
> 
> Here is a patch I am about to commit into the kevent tree:
> 
> diff --git a/kernel/kevent/kevent_user.c b/kernel/kevent/kevent_user.c
> index 711a8a8..ecee668 100644
> --- a/kernel/kevent/kevent_user.c
> +++ b/kernel/kevent/kevent_user.c
> @@ -235,6 +235,36 @@ static void kevent_free_rcu(struct rcu_h
>  }
>  
>  /*
> + * Must be called under u->ready_lock.
> + * This function removes kevent from ready queue and 
> + * tries to add new kevent into ring buffer.
> + */
> +static void kevent_remove_ready(struct kevent *k)
> +{
> +	struct kevent_user *u = k->user;
> +
> +	list_del(&k->ready_entry);

Arg... no

You cannot call list_del() , then check overflow_kevent.

I you call list_del on what happens to be the kevent pointed by 
overflow_kevent, you loose...

> +	k->flags &= ~KEVENT_READY;
> +	u->ready_num--;
> +	if (++u->pring[0]->uidx == KEVENT_MAX_EVENTS)
> +		u->pring[0]->uidx = 0;
> +	
> +	if (u->overflow_kevent) {
> +		int err;
> +
> +		err = kevent_user_ring_add_event(u->overflow_kevent);
> +		if (!err || u->overflow_kevent == k) {
> +			if (u->overflow_kevent->ready_entry.next == &u->ready_list)
> +				u->overflow_kevent = NULL;
> +			else
> +				u->overflow_kevent = 
> +					list_entry(u->overflow_kevent->ready_entry.next, 
> +							struct kevent, ready_entry);
> +		}
> +	}
> +}
> +
> +/*
>   * Complete kevent removing - it dequeues kevent from storage list
>   * if it is requested, removes kevent from ready list, drops userspace
>   * control block reference counter and schedules kevent freeing through RCU.
> @@ -248,11 +278,8 @@ static void kevent_finish_user_complete(
>  		kevent_dequeue(k);
>  
>  	spin_lock_irqsave(&u->ready_lock, flags);
> -	if (k->flags & KEVENT_READY) {
> -		list_del(&k->ready_entry);
> -		k->flags &= ~KEVENT_READY;
> -		u->ready_num--;
> -	}
> +	if (k->flags & KEVENT_READY)
> +		kevent_remove_ready(k);
>  	spin_unlock_irqrestore(&u->ready_lock, flags);
>  
>  	kevent_user_put(u);
> @@ -303,25 +330,7 @@ static struct kevent *kqueue_dequeue_rea
>  	spin_lock_irqsave(&u->ready_lock, flags);
>  	if (u->ready_num && !list_empty(&u->ready_list)) {
>  		k = list_entry(u->ready_list.next, struct kevent, ready_entry);
> -		list_del(&k->ready_entry);
> -		k->flags &= ~KEVENT_READY;
> -		u->ready_num--;
> -		if (++u->pring[0]->uidx == KEVENT_MAX_EVENTS)
> -			u->pring[0]->uidx = 0;
> -		
> -		if (u->overflow_kevent) {
> -			int err;
> -
> -			err = kevent_user_ring_add_event(u->overflow_kevent);
> -			if (!err) {
> -				if (u->overflow_kevent->ready_entry.next == &u->ready_list)
> -					u->overflow_kevent = NULL;
> -				else
> -					u->overflow_kevent = 
> -						list_entry(u->overflow_kevent->ready_entry.next, 
> -								struct kevent, ready_entry);
> -			}
> -		}
> +		kevent_remove_ready(k);
>  	}
>  	spin_unlock_irqrestore(&u->ready_lock, flags);
>  


