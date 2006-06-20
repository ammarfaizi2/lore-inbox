Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750861AbWFTUQX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbWFTUQX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 16:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750857AbWFTUQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 16:16:23 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:18948 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750788AbWFTUQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 16:16:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:x-x-sender:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type:from;
        b=Y5WHGF2vlz58pxxgjTrm0aOgCHnJOjGYIH/9C+uNeEVB/9mZHvYOygjpCfVKTx6oy3a8oWXfUDmLjRE9yiTr6ELkS18UxFfKQYG8RCaPqmM11DVE4dLH0+04nchSx7m3fKec1sB+MfAVTwTBYwexYvS8lxNN5Cc3tzS1UsvzGEU=
Date: Tue, 20 Jun 2006 22:16:23 +0100 (BST)
X-X-Sender: simlo@localhost.localdomain
To: Thomas Gleixner <tglx@linutronix.de>
cc: Esben Nielsen <nielsen.esben@googlemail.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: Why can't I set the priority of softirq-hrt? (Re: 2.6.17-rt1)
In-Reply-To: <1150821311.6780.240.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0606201914170.11643@localhost.localdomain>
References: <20060618070641.GA6759@elte.hu>  <Pine.LNX.4.64.0606201656230.11643@localhost.localdomain>
  <1150816429.6780.222.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0606201725550.11643@localhost.localdomain>
 <1150821311.6780.240.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
From: Esben Nielsen <nielsen.esben@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 20 Jun 2006, Thomas Gleixner wrote:

> On Tue, 2006-06-20 at 18:09 +0100, Esben Nielsen wrote:
>> The only question I have is why the priority of the callback is set to
>> priority of the task calling hrtimer_start() (current->normal_prio). That
>> seems like an odd binding to me. Shouldn't the finding of the priority be moved over to the
>> posix-timer code, where it is needed, and be given as a parameter to
>> hrtimer_start()?
>
> Was the simplest way to do.
>

Yes, when you only use the hrtimers to implement signals. But what if you 
use them for something different?

>> In rtmutex.c, where a hrtimer is used as a timeout on a mutex, wouldn't it
>> make more sense to use current->prio than current->normal_prio if the task
>> is boosted when it starts to wait on a mutex.
>
> Not sure about that.
>
>> Let say you have a bunch of callback running at priority 1 and then the
>> next hrt timer with priority 99 expires. Then the callback which
>> is running will be boosted to priority 99. So the overall latency at
>> priority 99 will at least the latency of the worst hrtimer callback.
>> And worse: What if the callback running is blocked on a mutex? Will the
>> owner of the mutex be boosted as well? Not according to the code in
>> sched.c. Therefore you get priority inversion to priority 1. That is the
>> worst case hrtimer latency is that of priority 1.
>>
>> Therefore, a simpler and more robust design would be to give the thread
>> priority 99 as a default - just as the posix_cpu_timer thread. Then the
>> system designer can move it around with chrt when needed.
>> In fact you can say the current design have both the worst cases of having
>> it running as priority 99 and at priority 1!
>
> We had this before and it is horrible.

"Horrible" in what respect?

>
>> Another complicated design would be to make a task for each priority.
>> Then the interrupt wakes the highest priority one, which handles the first
>> callback and awakes the next one etc.
>
> Uurgh. Thats not a serious proposal ?

No, not really. And then a little bit in a generalized way:
The kernel could have these threads as general working threads on which 
all kind of callbacks could be executed at their right priority.
But, ofcourse, having 100 tasks sitting around per CPU is huge waste of 
memory. But maybe some kind of pooling could be made?

As I said in a another mail some time back: Having 100 different RT 
priorities doesn't make sense. You can at most need 10 anyway.

>
> A nice solution would be to enqueue the timer into the task struct of
> the thread which is target of the signal, wake that thread in a special
> state which only runs the callback and then does the signal delivery.

What if the thread is running?

> The scary thing on this is to get the locking straight, but it might
> well worth to try it. That way we would burden the softirq delivery to
> the thread and maybe save a couple of task switches.
>
> 	tglx
>
>

Hmm, a practical thing to do would be to make a system where you can post 
jobs in a thread. These jobs can then be done in thread context 
around schedule or just before the task returns to user-space.

Esben
