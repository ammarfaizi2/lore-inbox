Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262314AbVF2RrC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262314AbVF2RrC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 13:47:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262298AbVF2RrC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 13:47:02 -0400
Received: from alog0025.analogic.com ([208.224.220.40]:21994 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262326AbVF2Rpp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 13:45:45 -0400
Date: Wed, 29 Jun 2005 13:43:59 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Steven Rostedt <rostedt@goodmis.org>
cc: Timur Tabi <timur.tabi@ammasso.com>, Denis Vlasenko <vda@ilport.com.ua>,
       Arjan van de Ven <arjan@infradead.org>, Jens Axboe <axboe@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: kmalloc without GFP_xxx?
In-Reply-To: <Pine.LNX.4.58.0506291306530.22775@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0506291337230.5067@chaos.analogic.com>
References: <200506291402.18064.vda@ilport.com.ua> <1120045024.3196.34.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.58.0506290927370.22775@localhost.localdomain>
 <200506291714.32990.vda@ilport.com.ua> <42C2D0C1.4030500@ammasso.com>
 <Pine.LNX.4.58.0506291306530.22775@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jun 2005, Steven Rostedt wrote:

>
> On Wed, 29 Jun 2005, Timur Tabi wrote:
>
>> Denis Vlasenko wrote:
>>
>>> This is why I always use _irqsave. Less error prone.
>>
>> No, it's just bad programming.  How hard can it be to see which spinlocks are being used
>> by your ISR and which ones aren't?  Only the ones that your ISR touches should have
>> _irqsave.  It's really quite simple.
>
> What about my argument that spin_lock is actually a longer latency on an
> SMP system?  That is, if you grab a spin_lock and task on another CPU
> tries to grab it and starts to spin. It will spin while the first task is
> servicing interrupts.  It can be even worst with the following scenario:
>
> task 1:
>  spin_lock(&non_irq_lock);
>
> task 2:
>
>  spin_lock_irqsave(&some_irq_used_lock);
>  spin_lock(&non_irq_lock);
>
> Here we see that task 2 can spin with interrupts off, while the first task
> is servicing an interrupt, and God forbid if the IRQ handler sends some
> kind of SMP signal to the CPU running task 2 since that would be a
> deadlock.  Granted, this is a hypothetical situation, but makes using
> spin_lock with interrupts enabled a little scary.
>

But it wouldn't deadlock! It would just spin until the guy on
another CPU that had the lock unlocked.

FYI, spin_lock() is supposed to be used in an interrupt where it
is already known that the interrupts are OFF so you don't need
to save/restore flags because you know the condition. IFF the
ISR were to enable interrupts, with a spin-lock held (bad practice),
it still wouldn't deadlock, it's just that the entire system could
potentially degenerate into a poll-mode, spin in the ISR, mode
with awful performance.

>
>>> This is more or less what I meant. Why think about each kmalloc and when you
>>> eventually did get it right: "Aha, we _sometimes_ get called from spinlocked code,
>>> GFP_ATOMIC then" - you still do atomic alloc even if cases when you
>>> were _not_ called from locked code! Thus you needed to think longer and got
>>> code which is worse.
>>
>> So you're saying that you're the kind of programmer who makes more mistakes the longer you
>> think about something?????
>>
>> Using GFP_ATOMIC increases the probability that you won't be able to allocate the memory
>> you need, and it also increases the probability that some other module that really needs
>> GFP_ATOMIC will also be unable to allocate the memory it needs.  Please tell me, how is
>> this considered good programming?
>
> I believe he was trying to say that there might be a function that is
> called by both an interrupt and non interrupt (schedulable) code.  That
> means that the code would always need to do a GFP_ATOMIC and yes, it would
> mean that there's a higher chance that it would fail.  So if you have some
> function that's used by lots of schedulable code and that same function is
> seldom used by an interrupt, then you either need to maintain two versions
> of the function (one with GFP_ATOMIC and one without) or always use
> GFP_ATOMIC which would mean the the majority user would suffer
> unsuccessful allocations more often.
>
> -- Steve
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
