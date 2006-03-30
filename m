Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751416AbWC3BPG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbWC3BPG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 20:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbWC3BPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 20:15:06 -0500
Received: from omta02sl.mx.bigpond.com ([144.140.93.154]:44953 "EHLO
	omta02sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751416AbWC3BPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 20:15:04 -0500
Message-ID: <442B3111.5030808@bigpond.net.au>
Date: Thu, 30 Mar 2006 12:14:57 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
CC: Andrew Morton <akpm@osdl.org>, Mike Galbraith <efault@gmx.de>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Con Kolivas <kernel@kolivas.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: smpnice work around for active_load_balance()
References: <4428D112.7050704@bigpond.net.au> <20060328112521.A27574@unix-os.sc.intel.com> <4429BC61.7020201@bigpond.net.au> <20060328185202.A1135@unix-os.sc.intel.com> <442A0235.1060305@bigpond.net.au> <20060329145242.A11376@unix-os.sc.intel.com> <442B1AE8.5030005@bigpond.net.au> <20060329165052.C11376@unix-os.sc.intel.com>
In-Reply-To: <20060329165052.C11376@unix-os.sc.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Thu, 30 Mar 2006 01:14:57 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siddha, Suresh B wrote:
> On Thu, Mar 30, 2006 at 10:40:24AM +1100, Peter Williams wrote:
>> Siddha, Suresh B wrote:
>>> On Wed, Mar 29, 2006 at 02:42:45PM +1100, Peter Williams wrote:
>>>> I meant that it doesn't explicitly address your problem.  What it does 
>>>> is ASSUME that failure of load balancing to move tasks is because there 
>>>> was exactly one task on the source run queue and that this makes it a 
>>>> suitable candidate to have that single task moved elsewhere in the blind 
>>>> hope that it may fix an HT/MC imbalance that may or may not exist.  In 
>>>> my mind this is very close to random.  
>>> That so called assumption happens only when load balancing has
>>> failed for more than the domain specific cache_nice_tries. Only reason
>>> why it can fail so many times is because of all pinned tasks or only a single
>>> task is running on that particular CPU. load balancing code takes care of both
>>> these scenarios..
>>>
>>> sched groups cpu_power controls the mechanism of implementing HT/MC
>>> optimizations in addition to active balance code... There is no randomness
>>> in this.
>> The above explanation just increases my belief in the randomness of this 
>> solution.  This code is mostly done without locks and is therefore very 
>> racy and any assumptions made based on the number of times load 
>> balancing has failed etc. are highly speculative.
> 
> Isn't it the same case with regular cpu load calculations during load
> balance?

Yes.  Which is why move_tasks() is designed to cope.

But this doesn't effect the argument w.r.t. your code.

> 
>> And even if there is only one task on the CPU there's no guarantee that
>> that CPU is in a package that meets the other requirements to make the 
>> move desirable.  So there's a good probability that you'll be moving 
>> tasks unnecessarily.
> 
> sched groups cpu_power and domain topology information cleanly
> encapsulates the imbalance identification and source/destination groups
> to fix the imbalance.

But you don't look at the rest of the queues in the package to see if 
the need is REALLY required.

> 
>> It's a poor solution and it's being inflicted on architectures that 
>> don't need it.  Even if cache_nice_tries is used to suppress this 
>> behaviour on architectures that don't need it they have to carry the 
>> code in their kernel.
> 
> We can clearly throw CONFIG_SCHED_MC/SMT around that code.. Nick/Ingo
> do you see any issue?

That just makes it a poor solution and ugly. :-)

> 
>>>
>>>> Also back to front and inefficient.
>>> HT/MC imbalance is detected in a normal way.. A lightly loaded group
>>> finds an imbalance and tries to pull some load from a busy group (which
>>> is inline with normal load balance)... pull fails because the only task
>>> on that cpu is busy running and needs to go off the cpu (which is triggered
>>> by active load balance)... Scheduler load balance is generally done by a 
>>> pull mechansim and here (HT/MC) it is still a pull mechanism(triggering a 
>>> final push only because of the single running task) 
>>>
>>> If you have any better generic and simple method, please let us know.
>> I gave an example in a previous e-mail.  Basically, at the end of 
>> scheduler_tick() if rebalance_tick() doesn't move any tasks (it would be 
>> foolish to contemplate moving tasks of the queue just after you've moved 
>> some there) and the run queue has exactly one running task and it's time 
>> for a HT/MC rebalance check on the package that this run queue belongs 
>> to then check that package to to see if it meets the rest of criteria 
>> for needing to lose some tasks.  If it does look for a package that is a 
>> suitable recipient for the moved task and if you find one then mark this 
>> run queue as needing active load balancing and arrange for its migration 
>> thread to be started.
>>
>> Simple, direct and amenable to being only built on architectures that 
>> need the functionality.
> 
> First of all we will be doing unnecessary checks to see if there is
> an imbalance.. Current code triggers the checks and movement only when
> it is necessary.. And second, finding the correct destination cpu in the 
> presence of SMT and MC is really complicated.. Look at different examples
> in the OLS paper.. Domain topology provides all this info with no added
> complexity...
> 
>> Another (more complex) solution that would also allow improvements to 
>> other HT related code (e.g. the sleeping dependent code) would be to 
>> modify the load balancing code so that all CPUs in a package share a run 
>> queue and load balancing is then done between packages.  As long as the 
>> number of CPUs in a package is small this shouldn't have scalability 
>> issues.  The big disadvantage of this approach is its complexity which 
>> is probably too great to contemplate doing it in 2.6.X kernels.
> 
> Presence of SMT and MC, implementation of power-savings scheduler
> policy will present more challenges...

And I would recommend a similar approach to what I've suggested above. 
They could probably be combined into a single neat well encapsulated 
solution.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
