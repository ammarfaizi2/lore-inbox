Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932160AbWBKDgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbWBKDgR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 22:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbWBKDgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 22:36:17 -0500
Received: from omta01ps.mx.bigpond.com ([144.140.82.153]:21137 "EHLO
	omta01ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932160AbWBKDgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 22:36:17 -0500
Message-ID: <43ED5BAE.1020307@bigpond.net.au>
Date: Sat, 11 Feb 2006 14:36:14 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
CC: Andrew Morton <akpm@osdl.org>, kernel@kolivas.org, npiggin@suse.de,
       mingo@elte.hu, rostedt@goodmis.org, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [rfc][patch] sched: remove smpnice
References: <20060207142828.GA20930@wotan.suse.de>	<200602080157.07823.kernel@kolivas.org>	<20060207141525.19d2b1be.akpm@osdl.org>	<200602081011.09749.kernel@kolivas.org>	<20060207153617.6520f126.akpm@osdl.org>	<20060209230145.A17405@unix-os.sc.intel.com> <20060209231703.4bd796bf.akpm@osdl.org> <43ED3D6A.8010300@bigpond.net.au>
In-Reply-To: <43ED3D6A.8010300@bigpond.net.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta01ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sat, 11 Feb 2006 03:36:14 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> Andrew Morton wrote:
> 
>> "Siddha, Suresh B" <suresh.b.siddha@intel.com> wrote:
>>
>>> On Tue, Feb 07, 2006 at 03:36:17PM -0800, Andrew Morton wrote:
>>>
>>>> Suresh, Martin, Ingo, Nick and Con: please drop everything, 
>>>> triple-check
>>>> and test this:
>>>>
>>>> From: Peter Williams <pwil3058@bigpond.net.au>
>>>>
>>>> This is a modified version of Con Kolivas's patch to add "nice" 
>>>> support to
>>>> load balancing across physical CPUs on SMP systems.
>>>
>>>
>>> I have couple of issues with this patch.
>>>
>>> a) on a lightly loaded system, this will result in higher priority 
>>> job hopping around from one processor to another processor.. This is 
>>> because of the code in find_busiest_group() which assumes that 
>>> SCHED_LOAD_SCALE represents a unit process load and with nice_to_bias 
>>> calculations this is no longer true(in the presence of non nice-0 tasks)
>>>
>>> My testing showed that 178.galgel in SPECfp2000 is down by ~10% when 
>>> run with nice -20 on a 4P(8-way with HT) system compared to a nice-0 
>>> run.
> 
> 
> This is a bit of a surprise.  Surely, even with this mod, a task 
> shouldn't be moved if it's the only runnable one on its CPU.  If it 
> isn't the only runnable one on its CPU, it's not actually on the CPU and 
> it's not cache hot then moving it to another (presumably) idle CPU 
> should be a gain?
> 
> Presumably the delay waiting for the current task to exit the CPU is 
> less than the time taken to move the task to the new CPU?  I'd guess 
> that this means that the task about to be moved is either: a) higher 
> priority than the current task on the CPU and is waiting for it to be 
> preempted off or b) it's equal priority (or at least next one due to be 
> scheduled) to the current task, waiting for the current task to 
> surrender the CPU and that surrender is going to happen pretty quickly 
> due to the current task's natural behaviour?

After a little lie down :-),  I now think that this problem has been 
misdiagnosed and the actual problem is that movement of high priority 
tasks on lightly loaded systems is supressed by this patch rather than 
it causing such tasks to hop from CPU to CPU.

The reason that I think this is that the implementation of biased_load() 
makes it a likely outcome.  As a shortcut to converting weighted load to 
biased load it assumes the the average weighted load per runnable task 
is 1 (or, equivalently, that the average biased prio per runnable is 
NICE_TO_BIAS_PRIO(p)) and this means that if there's only one task to 
move and its nice value is less than zero (i.e. it's high priority) then 
the biased load to be moved that is calculated will be smaller than that 
task's bias_prio causing it to NOT be moved by move_tasks().

Do you have any direct evidence to support your "hopping" hypothesis or 
is my hypothesis equally likely?

If my hypothesis holds there is a relatively simple fix that would 
involve modifying biased_load() to take into account rq->prio_bias and 
rq->nr_running during its calculations.  Basically, in that function, 
(wload * NICE_TO_BIAS_PRIO(0)) would be replaced by (wload * 
rq->prio_bias / rq->nr_running) which would, in turn, create a 
requirement for rq to be passed in as an argument.

If there is direct evidence of hopping then, because of my hypothesis 
above, I would shift the suspicion from find_busiest_group() to 
try_to_wake_up().

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
