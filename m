Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964983AbWDDDYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964983AbWDDDYM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 23:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964982AbWDDDYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 23:24:11 -0400
Received: from omta01ps.mx.bigpond.com ([144.140.82.153]:17584 "EHLO
	omta01ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S964983AbWDDDYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 23:24:10 -0400
Message-ID: <4431E6D7.2060604@bigpond.net.au>
Date: Tue, 04 Apr 2006 13:24:07 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
CC: Andrew Morton <akpm@osdl.org>, Mike Galbraith <efault@gmx.de>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Con Kolivas <kernel@kolivas.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: smpnice loadbalancing with high priority tasks
References: <20060328185202.A1135@unix-os.sc.intel.com> <442A0235.1060305@bigpond.net.au> <20060329145242.A11376@unix-os.sc.intel.com> <442B1AE8.5030005@bigpond.net.au> <20060329165052.C11376@unix-os.sc.intel.com> <442B3111.5030808@bigpond.net.au> <20060401204824.A8662@unix-os.sc.intel.com> <442F7871.4030405@bigpond.net.au> <20060403172408.A31895@unix-os.sc.intel.com> <4431CA4F.3020304@bigpond.net.au> <20060403191122.B31895@unix-os.sc.intel.com>
In-Reply-To: <20060403191122.B31895@unix-os.sc.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta01ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Tue, 4 Apr 2006 03:24:08 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siddha, Suresh B wrote:
> On Tue, Apr 04, 2006 at 11:22:23AM +1000, Peter Williams wrote:
>> OK.  I think this means some fiddling with avg_load may be necessary in 
>> some cases but this will be complex.  I'm not really happy about making 
>> this code more complex until some of the current unnecessary complexity 
>> is removed.  I.e. until a proper solution to the problem of triggering 
>> active_load_balance() is implemented.
> 
> Here is Nicks view about active_load_balance()
> 
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=3950745131e23472fb5ace2ee4a2093e7590ec69

That's pre smpnice. :-)

> 
>>> c) DP system: if the cpu-0 has two high priority and cpu-1 has one normal
>>> priority task, how can the current code detect this imbalance..
>> How would it not?
> 
> imbalance will be always < busiest_load_per_task and
> max_load - this_load will be < 2 * busiest_load_per_task...
> and pwr_move will be <= pwr_now...

I had thought about substituting (busiest_load_per_task + 
this_load_per_task) for (busiest_load_per_task * 2) but couldn't 
convince myself that it was the right thing to do.  (The final update to 
this_load_per_task would need to be moved.)  The reason I couldn't 
convince myself is that I thought it might be too aggressive and cause 
excessive balancing.  Maybe something more sophisticated is needed to 
prevent that possibility.  It should be noted that the relative sizes of 
busiest_load_per_task and this_load_per_task my be useful in deciding 
what to do in these cases.  I'll put some thought into that.

BTW load balancing without smpnice would do just as badly here in that 
it wouldn't notice an imbalance either.

> 
>>> d) 4-way MP system: if the cpu-0 has two high priority tasks, cpu-1 has
>>> one high priority and four normal priority and cpu-2,3 each has one
>>> high priority task.. how does the current code distribute the normal
>>> priority tasks among cpu-1,2,3... (in this case, max_load will always
>>> point to cpu-0 and will never distribute the noraml priority tasks...)
>> This should cause cpu-0 to lose one of its tasks creating a new state 
> 
> how? in this case also...
> 
> imbalance will be always < busiest_load_per_task and
> max_load - this_load will be < 2 * busiest_load_per_task...
> and pwr_move will be <= pwr_now...
> 
> 
>> Without smpnice, can you show how the default load balancing would 
>> result in the "nice" values being reliably enforced in your examples.
> 
> I agree with the issue that we are trying to fix here.. but I feel
> it is incomplete.. With the current code in mainline, anyone can say the 
> behavior by going through the code.... with smpnice code, code is complex
> and really doesn't achieve what that patch really wants to fix..

It does in most cases and we could reduce the complexity if we had an 
alternative trigger for active_load_balance() :-)

> 
>> The good news is that, in real life, high priority tasks generally only 
>> use very short bursts of CPU. :-)
> 
> do we then really need smpnice complexity?

Most people who express unhappiness with SMP and nice are looking at the 
other end of the problem i.e. they nice 19 a process to make it run in 
the background but it gets a CPU to itself while a couple nice 0 tasks 
have to share the other CPU.  The high priority case has to be 
considered as well (e.g. one high priority task and one normal priority 
task running on a 2 CPU machine with a CPU each when another task wakes 
-- you'd like that to end up on the CPU of the normal priority task not 
the one with the high priority task, etc.) but its effects are more 
likely to be transitory and high priority tasks would not be expected to 
have a long term effect on balancing.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
