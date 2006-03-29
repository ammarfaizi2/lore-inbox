Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbWC2Dmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWC2Dmu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 22:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbWC2Dmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 22:42:50 -0500
Received: from omta03ps.mx.bigpond.com ([144.140.82.155]:14324 "EHLO
	omta03ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750714AbWC2Dmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 22:42:50 -0500
Message-ID: <442A0235.1060305@bigpond.net.au>
Date: Wed, 29 Mar 2006 14:42:45 +1100
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
References: <4428D112.7050704@bigpond.net.au> <20060328112521.A27574@unix-os.sc.intel.com> <4429BC61.7020201@bigpond.net.au> <20060328185202.A1135@unix-os.sc.intel.com>
In-Reply-To: <20060328185202.A1135@unix-os.sc.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Wed, 29 Mar 2006 03:42:45 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siddha, Suresh B wrote:
> On Wed, Mar 29, 2006 at 09:44:49AM +1100, Peter Williams wrote:
>> Siddha, Suresh B wrote:
>>> We need to balance even if the other packages are not idle.. For example,
>>> consider a 4-core DP system, if we have 6 runnable(assume same priority)
>>> processes, we want to schedule 3 of them in each package..
>> Well I hope that when you do a proper implementation for this issue that 
>> it takes this into account.  The current implementation doesn't.
> 
> This will also have issues when we want to implement power savings policy
> for multi-core. Attached is the prototype patch(against 2.6.16-git15)
> I was planning to send to mainline..
> 
>>> Todays active load balance implementation is very simple and generic. And
>>> hence it works smoothly with dual and multi-core..
>> The application of active balancing to address your problem in the 
>> current implementation is essentially random.
> 
> why so? we wanted to implement these HT and MC optimizations generically
> in the scheduler and domain topology(and sched groups cpu_power) provided
> that infrastructure cleanly..

I meant that it doesn't explicitly address your problem.  What it does 
is ASSUME that failure of load balancing to move tasks is because there 
was exactly one task on the source run queue and that this makes it a 
suitable candidate to have that single task moved elsewhere in the blind 
hope that it may fix an HT/MC imbalance that may or may not exist.  In 
my mind this is very close to random.  Also back to front and inefficient.

> 
>>> Please read my OLS 
>>> 2005 paper which talks about different scheduling scenarios and also how 
>> A URL would be handy.
> 
> http://www.linuxsymposium.org/2005/linuxsymposium_procv2.pdf
> Look for the paper titled "Chip Multi Processing aware Linux Kernel Scheduler"
> 
>>> Either way, I can show scheduling scenarios which will fail...
>> I'd be interested to see the ones that would fail with the corrected 
>> code.  
> 
> 4-way system with HT (8 logical processors) ... 
> 
> Package-P0 T0 has a highest priority task, T1 is idle
> Package-P1 Both T0 and T1 have 1 normal priority task each..
> P2 and P3 are idle.
> 
> Scheduler needs to move one of the normal priority tasks to P2 or P3.. 
> But find_busiest_group() will always think P0 as the busy group and
> will not distribute the load as expected..

This is a variation of the problem that active_load_balance() is being 
used as a random fix for.  I.e. it's HT/MC specific and should 
eventually be fixed in HT/MC specific code.  As I've said several times 
the mechanism for triggering active_load_balance() to try and achieve 
your aims is essentially random and it's a matter of luck whether it 
works or not (even without smpnice patches).  The smpnice patch probably 
reduces the odds that it will work but that's not their problem.  The 
unique load balancing needs of HT/MC need to be handled more 
deterministically.

> 
> I am giving so many examples that I am confused at the end of day, which
> examples are fixed and which are not by your patches :)
> So please send the latest smpnice patch, which you think is clean and fixes 
> all the issues(look at all my examples and also the ones mentioned in the 
> OLS paper...)

I'm in the process of doing that.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
