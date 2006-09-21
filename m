Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbWIUMX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbWIUMX2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 08:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbWIUMX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 08:23:28 -0400
Received: from mx01.stofanet.dk ([212.10.10.11]:26310 "EHLO mx01.stofanet.dk")
	by vger.kernel.org with ESMTP id S1751139AbWIUMX1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 08:23:27 -0400
Date: Thu, 21 Sep 2006 14:23:19 +0200 (CEST)
From: Esben Nielsen <nielsen.esben@gogglemail.com>
X-X-Sender: simlo@frodo.shire
To: Bill Huey <billh@gnuppy.monkey.org>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>, John Stultz <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [PATCH] move put_task_struct() reaping into a thread [Re:
 2.6.18-rt1]
In-Reply-To: <20060921081333.GC11644@gnuppy.monkey.org>
Message-ID: <Pine.LNX.4.64.0609211417470.8638@frodo.shire>
References: <20060920141907.GA30765@elte.hu> <20060921065624.GA9841@gnuppy.monkey.org>
 <20060921065402.GA22089@elte.hu> <20060921071838.GA10337@gnuppy.monkey.org>
 <20060921071624.GA25281@elte.hu> <20060921073222.GC10337@gnuppy.monkey.org>
 <20060921072908.GA27280@elte.hu> <20060921074805.GA11644@gnuppy.monkey.org>
 <20060921075633.GA30343@elte.hu> <20060921081333.GC11644@gnuppy.monkey.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




On Thu, 21 Sep 2006, Bill Huey wrote:

> On Thu, Sep 21, 2006 at 09:56:33AM +0200, Ingo Molnar wrote:
>> * Bill Huey <billh@gnuppy.monkey.org> wrote:
>>
>>> [...] If the upstream kernel used RCU function in a task allocation or
>>> task struct reading in the first place then call_rcu() would be a
>>> clear choice. However, I didn't see it used in that way (I could be
>>> wrong) [...]
>>
>> it was RCU-ified briefly but then it was further improved to direct
>> freeing, because upstream _can_ free it directly.
>
> Unfortunately, this is a problem with -rt patch and the lock ordering
> in this system when you have to call a memory allocator within an atomic
> critical section. I fully accept this as part of what goes into making a
> kernel preemptive and I'm ok with it. Not many folks know about the
> special case locking rules in the -rt kernel so this might be new to
> various folks.
>
> If you're looking for validation of this technique from me and an ego
> stroking, then you have it from me. :)
>
> Fortunately, it's in a non-critical place so this should *not* be too
> much of a problem, but I've already encountered oddies trying to
> allocate a pool of entities for populating a free list under an atomic
> critical section of some sort for some code I've been writing. This is
> a significant problem with kernel coding in -rt, but I can't say what
> the general solution is other than making the memory allocators
> non-preemptible by reverting the locks back to raw spinlocks, etc...
> using lock-break, who knows. I'm ok with the current scenario, but this
> could eventually be a larger problem.
>

The whole point is to defer those frees to a task. In -rt call_rcu() is 
abused to do that in the case of put_task_struct(). But it is abuse since 
call_rcu() is much more resourcefull than simply defering to a task.

Paul's idea behind de-RCU'ing put_task_struct() is mostly performance and 
partly readability because the extra RCU protection isn't needed.

So the answer is:
Make a general softirq to which free's can be defered from atomic regions, 
don't abuse call_rcu().

Esben

> bill
>
