Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750973AbWBKB1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbWBKB1K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 20:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbWBKB1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 20:27:09 -0500
Received: from omta05sl.mx.bigpond.com ([144.140.93.195]:60111 "EHLO
	omta05sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750973AbWBKB1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 20:27:08 -0500
Message-ID: <43ED3D6A.8010300@bigpond.net.au>
Date: Sat, 11 Feb 2006 12:27:06 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, kernel@kolivas.org,
       npiggin@suse.de, mingo@elte.hu, rostedt@goodmis.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [rfc][patch] sched: remove smpnice
References: <20060207142828.GA20930@wotan.suse.de>	<200602080157.07823.kernel@kolivas.org>	<20060207141525.19d2b1be.akpm@osdl.org>	<200602081011.09749.kernel@kolivas.org>	<20060207153617.6520f126.akpm@osdl.org>	<20060209230145.A17405@unix-os.sc.intel.com> <20060209231703.4bd796bf.akpm@osdl.org>
In-Reply-To: <20060209231703.4bd796bf.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sat, 11 Feb 2006 01:27:06 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> "Siddha, Suresh B" <suresh.b.siddha@intel.com> wrote:
> 
>>On Tue, Feb 07, 2006 at 03:36:17PM -0800, Andrew Morton wrote:
>>
>>>Suresh, Martin, Ingo, Nick and Con: please drop everything, triple-check
>>>and test this:
>>>
>>>From: Peter Williams <pwil3058@bigpond.net.au>
>>>
>>>This is a modified version of Con Kolivas's patch to add "nice" support to
>>>load balancing across physical CPUs on SMP systems.
>>
>>I have couple of issues with this patch.
>>
>>a) on a lightly loaded system, this will result in higher priority job hopping 
>>around from one processor to another processor.. This is because of the 
>>code in find_busiest_group() which assumes that SCHED_LOAD_SCALE represents 
>>a unit process load and with nice_to_bias calculations this is no longer 
>>true(in the presence of non nice-0 tasks)
>>
>>My testing showed that 178.galgel in SPECfp2000 is down by ~10% when run with 
>>nice -20 on a 4P(8-way with HT) system compared to a nice-0 run.

This is a bit of a surprise.  Surely, even with this mod, a task 
shouldn't be moved if it's the only runnable one on its CPU.  If it 
isn't the only runnable one on its CPU, it's not actually on the CPU and 
it's not cache hot then moving it to another (presumably) idle CPU 
should be a gain?

Presumably the delay waiting for the current task to exit the CPU is 
less than the time taken to move the task to the new CPU?  I'd guess 
that this means that the task about to be moved is either: a) higher 
priority than the current task on the CPU and is waiting for it to be 
preempted off or b) it's equal priority (or at least next one due to be 
scheduled) to the current task, waiting for the current task to 
surrender the CPU and that surrender is going to happen pretty quickly 
due to the current task's natural behaviour?

Is it normal to run enough -20 tasks to cause this problem to manifest?

>>
>>b) On a lightly loaded system, this can result in HT scheduler optimizations
>>being disabled in presence of low priority tasks... in this case, they(low
>>priority ones) can end up running on the same package, even in the presence 
>>of other idle packages.. Though this is not as serious as "a" above...
>>

I think that this issue comes under the heading of "Result of better 
nice enforcement" which is the purpose of the patch :-).  I wouldn't 
call this HT disablement or do I misunderstand the issue.

The only way that I can see load balancing subverting the HT scheduling 
mechanisms is if (say) there are 2 CPUs with 2 HT channels each and all 
of the high priority tasks end up sharing the 2 channels of one CPU 
while all of the low priority tasks share the 2 channels of the other 
one.  This scenario is far more likely to happen without the smpnice 
patches than with them.

> 
> 
> Thanks very much for discvoring those things.
> 
> That rather leaves us in a pickle wrt 2.6.16.
> 
> It looks like we back out smpnice after all?
> 
> Whatever we do, time is pressing.

I don't think either of these issues warrant abandoning smpnice.  The 
first is highly unlikely to occur on real systems and the second is just 
an example of the patch doing its job (maybe too officiously).  I don't 
think users would notice either on real systems.

Even if you pull it from 2.6.16 rather than upgrading it with my patch 
can you please leave both in -mm?

I think that there a few inexpensive things that can be tried before we 
go as far as sophisticated solutions (such as guesstimating how long a 
task will have to wait for CPU access if we don't move it).  E.g. with 
this patch move_tasks() takes two arguments: a) maximum number of tasks 
to be moved and b) maximum amount of biased load to be moved; and for 
normal use is just passed max(nr_running - 1, 0) as the first of these 
arguments and the move is controlled by the second but we could modify 
find_busiest_group() to give us values for both arguments.  Other 
options include modifying the function that maps nice to bias_prio so 
that the weights aren't quite so heavy.  Leaving the patches in -mm 
would allow some of these options to be tested.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
