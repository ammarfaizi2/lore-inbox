Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751289AbWELNb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbWELNb0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 09:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWELNb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 09:31:26 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:21204 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1751289AbWELNbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 09:31:25 -0400
Message-ID: <44648E89.8060605@bull.net>
Date: Fri, 12 May 2006 15:32:57 +0200
From: Pierre Peiffer <pierre.peiffer@bull.net>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>,
       LKML <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC][PATCH RT 0/2] futex priority based wakeup
References: <20060510112651.24a36e7b@frecb000686> <20060510100858.GA31504@elte.hu>
In-Reply-To: <20060510100858.GA31504@elte.hu>
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 12/05/2006 15:34:24,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 12/05/2006 15:34:26,
	Serialize complete at 12/05/2006 15:34:26
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just few comments for my understanding:

Ingo Molnar a écrit :
> * Sébastien Dugué <sebastien.dugue@bull.net> wrote:
> 
>>   in the current futex implementation, tasks are woken up in FIFO 
>> order, (i.e. in the order they were put to sleep). For realtime 
>> systems needing system wide strict realtime priority scheduling, tasks 
>> should be woken up in priority order.
>>
>>   This patchset achieves this by changing the futex hash bucket list 
>> into a plist. Tasks waiting on a futex are enqueued in this plist 
>> based on their priority so that they can be woken up in priority 
>> order.
> 
> hm, i dont think this is enough. Basically, waking up in priority order 
> is just the (easier) half of the story - what you want is to also 
> propagate priorities when you block. We provided a complete solution via 
> the PI-futex patchset (currently included in -mm).
> 
> In other words: as long as locking primitives go, i dont think real-time 
> applications should use wakeup-priority-ordered futexes, they should use 
> the real thing, PI futexes.

In fact, I agree with that for a lock (pthread_mutex, etc).

> 
> There is one exception: when a normal futex is used as a waitqueue 
> without any contention properties. (for example a waitqueue for worker 
> threads) But those are both rare, and typically dont muster tasks with 
> different priorities - i.e. FIFO is good enough.
> 

But here, I think this is what we have with the condvar, no ? When some 
threads are blocked on the condvar (pthread_cond_wait), they must be 
woken in priority order with pthread_broadcast, but there is no 
"lock-owner" to boost here.
Even if all threads but one are requeued on the second futex (i.e. the 
mutex used with the condvar), with the patch from Seb, they are requeued 
in priority order and thus get woken in priority order: we don't need 
any priority propagation here, I think.

So, I think that the PI-futexes are the right solution for the mutexes 
and rwlocks. But this patch seems to me correct for condvar 
(FUTEX_REQUEUE), I don't think that PI-futexes will add any benefit for 
condvar (?). But I may have missed something ?


> Also, there's a performance cost to this. Could you try to measure the 
> impact to SCHED_OTHER tasks via some pthread locking benchmark?
> 
> 	Ingo

-- 
Pierre
