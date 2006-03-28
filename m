Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751112AbWC1ERU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbWC1ERU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 23:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWC1ERU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 23:17:20 -0500
Received: from omta05ps.mx.bigpond.com ([144.140.83.195]:8564 "EHLO
	omta05ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751112AbWC1ERT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 23:17:19 -0500
Message-ID: <4428B8CC.7050909@bigpond.net.au>
Date: Tue, 28 Mar 2006 15:17:16 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
CC: Andrew Morton <akpm@osdl.org>, Mike Galbraith <efault@gmx.de>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: prevent high load weight tasks suppressing balancing
References: <4427873A.4010601@bigpond.net.au> <20060327135204.B12364@unix-os.sc.intel.com> <44287382.4050108@bigpond.net.au> <20060327191519.C12364@unix-os.sc.intel.com>
In-Reply-To: <20060327191519.C12364@unix-os.sc.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Tue, 28 Mar 2006 04:17:17 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siddha, Suresh B wrote:
> On Tue, Mar 28, 2006 at 10:21:38AM +1100, Peter Williams wrote:
>> Siddha, Suresh B wrote:
>>> This breaks HT and MC optimizations.. Consider a DP system with each
>>> physical processor having two HT logical threads.. if there are two 
>>> runnable processes running on package-0, with this patch scheduler 
>>> will never move one of those processes to package-1..
>> Is this an active_load_balance() issue?
> 
> No. find_busiest_group() doesn't find an imbalance in this case..

But active_load_balance() is the only code that would want to move the 
only runnable task off a CPU, isn't it?  No other load balancing code 
will try to do this that I can see.

> 
>> If it is then I suggest that the solution is to fix the 
>> active_load_balance() and associated code so that it works with this 
>> patch in place.
>>
>> It would be possible to modify find_busiest_group() and 
>> find_busiest_queue() so that they just PREFER the busiest group to have 
>> at least one CPU with more than one running task and the busiest queue 
>> to have more than one task.  However, this would make the code 
> 
> Please don't do that... Its not for the complexity I say NO but we 
> are kind of patching the code instead of addressing the root issue..
> 
>> considerably more complex and I'm reluctant to impose that on all 
>> architectures just to satisfy HT and MC requirements.  Are there 
>> configuration macros or other means that I can use to exclude this 
>> (proposed) code on systems where it isn't needed i.e. non HT and MC 
>> systems or HT and MC systems with only one package.
> 
> There is no config option to disable that portion of the code. Interaction
> of this code with mainstream code is very small. Look at the
> active_load_balance() and how this comes into play with the help of
> migration thread(which gets activated through load_balance)

Yes, I've read that which is why I say (see below) that it's backwards 
and haphazard.

I'll make a temporary patch that does the PREFER I mentioned above to 
tide us over until a proper rewrite of the active load balancing 
functionality can be done.  After giving it some more thought I think I 
can keep the extra complexity fairly small.

> 
>> Personally, I think that the optimal performance of the load balancing 
>> code has already been considerably compromised by its unconditionally 
>> accommodating the requirements of active_load_balance() (which you have 
>> said is now only required by HT and MC systems) and that it might be 
>> better if active load balancing was separated out into a separate 
>> mechanism that could be excluded from the build on architectures that 
>> don't need it.  I can't help thinking that this would result in a more 
>> efficient active load balancing mechanism as well because the current 
>> one is very inefficient.
> 
> No. Upto now, this has been encapsulated very generically using cpu_power
> and thats the reason why adding a sched domain for multi-core was simple.

It seems to me that it's being done backwards and haphazardly.  As far 
as I can see the problem that's trying to be solved is there is a 
package that has two or more CPUs that have exactly one runnable task 
and there are other packages that have all of their CPUs idle and we 
want to move one task to each idle package, right?

If any of the CPUs in the package have more than one runnable task then 
normal load balancing will kick in which is why I say this special code 
is only required for the case where there's exactly one task for two or 
more of the CPUs in the package.

So why not write code that (every so many ticks) checks to see if a 
package meets these criteria and if it does then looks for idle packages 
(that's packages not groups or queues) and if it finds them initiates 
active load balancing?  Or some variation of that theme.

At the end of scheduler_tick() you could do (every so many ticks):

if rebalance_tick() didn't pull any tasks and this run queue has exactly 
one runnable task then
         if the package that this run queue is in meets the criteria then
                 set the run queue's active_balance flag and let the 
migration thread know that it has work to do.

Properly packaged this code could be excluded from the build on 
architectures that don't need it.

> 
>> Peter
>> PS I don't think that this issue is sufficiently important to prevent 
>> the adoption of the smpnice patches while it's being resolved.
> 
> Scheduler is a very critical piece in the kernel. We need to understand and fix
> all the cases..

Yes, but this particular problem is a very minor especially when 
compared to the general breakage of "nice" on SMP systems without the 
smpnice patch.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
