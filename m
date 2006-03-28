Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932478AbWC1Wox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbWC1Wox (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 17:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932479AbWC1Wox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 17:44:53 -0500
Received: from omta03ps.mx.bigpond.com ([144.140.82.155]:13457 "EHLO
	omta03ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932478AbWC1Wow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 17:44:52 -0500
Message-ID: <4429BC61.7020201@bigpond.net.au>
Date: Wed, 29 Mar 2006 09:44:49 +1100
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
References: <4428D112.7050704@bigpond.net.au> <20060328112521.A27574@unix-os.sc.intel.com>
In-Reply-To: <20060328112521.A27574@unix-os.sc.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Tue, 28 Mar 2006 22:44:49 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siddha, Suresh B wrote:
> On Tue, Mar 28, 2006 at 05:00:50PM +1100, Peter Williams wrote:
>> Problem:
>>
>> It is undesirable for HT/MC packages to have more than one of their CPUs
>> busy if there are other packages that have all of their CPUs idle.  This
> 
> We need to balance even if the other packages are not idle.. For example,
> consider a 4-core DP system, if we have 6 runnable(assume same priority)
> processes, we want to schedule 3 of them in each package..

Well I hope that when you do a proper implementation for this issue that 
it takes this into account.  The current implementation doesn't.

> 
> Todays active load balance implementation is very simple and generic. And
> hence it works smoothly with dual and multi-core..

The application of active balancing to address your problem in the 
current implementation is essentially random.

> Please read my OLS 
> 2005 paper which talks about different scheduling scenarios and also how 

A URL would be handy.

> we were planning to implement Power savings policy incase of multi-core.. 
> I had a prototype patch for doing this, which I held it up before going
> on vacation, as it needed some rework with your smpnice patch in place..
> I will post a patch ontop of current mainline for your reference.
> 
>> +		} else if (!busiest_has_loaded_cpus && avg_load < max_load) {
> 
> I haven't fully digested the result of this patch but should this be
> avg_load < max_load or avg_load > max_load ?

Yes.  Thanks for spotting that.

> 
> Either way, I can show scheduling scenarios which will fail...

I'd be interested to see the ones that would fail with the corrected 
code.  I can show lots of examples where load balancing fails to do the 
right thing without the smpnice patches so it becomes a matter of which 
are more important.

> 
>>  
>> -		if (rqi->raw_weighted_load > max_load && rqi->nr_running > 1) {
>> +		if (rqi->nr_running > 1) {
>> +			if (rqi->raw_weighted_load > max_load || !busiest_is_loaded) {
>> +				max_load = rqi->raw_weighted_load;
>> +				busiest = rqi;
>> +				busiest_is_loaded = 1;
>> +			}
>> +		} else if (!busiest_is_loaded && rqi->raw_weighted_load > max_load) {
> 
> Please note the point that same scheduling logic has to work for all
> the different levels of scheduler domains... I think these checks complicates
> the decisions as we go up in the scheduling hirerachy.. Please go through
> the HT/MC/MP/Numa combinations and with same/different priority processes for
> different scenarios..

Sometimes complexity is necessary.  E.g. to handle the limitations of HT 
technology.  In this case, the complexity is necessary to make "nice" 
work on SMP systems.  The thing that broke "nice" on SMP systems was the 
adoption of separate run queues for each CPU and backing out that change 
in order to fix the problem is not an option so alternative solutions 
such as smpnice are required.

> 
> Even with no HT and MC, this patch has still has issues in the presence
> of different priority tasks... consider a simple DP system and run two
> instances of high priority tasks(simple infinite loop) and two normal priority
> tasks. With "top" I observed that these normal priority tasks keep on jumping
> from one processor to another... Ideally with smpnice, we would assume that 
> each processor should have two tasks (one high priority and another one 
> with normal priority) ..

Yes, but you are failing to take into account the effect of the other 
tasks on your system (e.g. top) that run from time to time.  If their 
burst of CPU use happens to coincide with some load balancing activity 
they will cause an imbalance to be detected (that is different to that 
which only considers your test tasks) and this will result in some tasks 
being moved.  Beware the Heisenberg Uncertainty Principle :-).

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
