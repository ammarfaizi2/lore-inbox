Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422852AbWBNWkg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422852AbWBNWkg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 17:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422856AbWBNWkg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 17:40:36 -0500
Received: from omta04ps.mx.bigpond.com ([144.140.83.156]:42824 "EHLO
	omta04ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1422852AbWBNWkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 17:40:35 -0500
Message-ID: <43F25C60.4080603@bigpond.net.au>
Date: Wed, 15 Feb 2006 09:40:32 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
CC: Andrew Morton <akpm@osdl.org>, kernel@kolivas.org, npiggin@suse.de,
       mingo@elte.hu, rostedt@goodmis.org, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [rfc][patch] sched: remove smpnice
References: <43ED3D6A.8010300@bigpond.net.au> <20060214010712.B20191@unix-os.sc.intel.com>
In-Reply-To: <20060214010712.B20191@unix-os.sc.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta04ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Tue, 14 Feb 2006 22:40:33 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siddha, Suresh B wrote:
> On Fri, Feb 10, 2006 at 05:27:06PM -0800, Peter Williams wrote:
> 
>>>"Siddha, Suresh B" <suresh.b.siddha@intel.com> wrote:
>>>
>>>>My testing showed that 178.galgel in SPECfp2000 is down by 
>>
>>~10% when run with 
>>
>>>>nice -20 on a 4P(8-way with HT) system compared to a nice-0 run.
>>
>>Is it normal to run enough -20 tasks to cause this problem to manifest?
> 
> 
> On a 4P(8-way with HT), if you run a -20 task(a simple infinite loop)
> it hops from one processor to another processor... you can observe it
> using top.

How do you get top to display which CPU tasks are running on?

> 
> find_busiest_group() thinks there is an imbalance and ultimately the
> idle cpu kicks active load balance on busy cpu, resulting in the hopping.

I'm still having trouble getting my head around this.  A task shouldn't 
be moved unless there's at least one other task on its current CPU, it 
(the task to be moved) is cache cold and it (the task to be moved) is 
not the currently active task.  In these circumstances, moving the task 
to an idle CPU should be a "good thing" unless the time taken for the 
move is longer than the time that will pass before the task becomes the 
running task on its current CPU.

For a nice==-20 task to be hopping from CPU to CPU there must be higher 
(or equal) priority tasks running on each of the CPUs that it gets 
booted off at the time it gets booted off.

> 
> 
>>>>b) On a lightly loaded system, this can result in HT 
>>
>>scheduler optimizations
>>
>>>>being disabled in presence of low priority tasks... in this 
>>
>>case, they(low
>>
>>>>priority ones) can end up running on the same package, even 
>>
>>in the presence 
>>
>>>>of other idle packages.. Though this is not as serious as 
>>
>>"a" above...
>>
>>I think that this issue comes under the heading of "Result of better 
>>nice enforcement" which is the purpose of the patch :-).  I wouldn't 
>>call this HT disablement or do I misunderstand the issue.
>>
>>The only way that I can see load balancing subverting the HT 
>>scheduling 
>>mechanisms is if (say) there are 2 CPUs with 2 HT channels 
>>each and all 
>>of the high priority tasks end up sharing the 2 channels of one CPU 
>>while all of the low priority tasks share the 2 channels of the other 
>>one.  This scenario is far more likely to happen without the smpnice 
>>patches than with them.
> 
> 
> I agree with you.. But lets take a DP system with HT, now if there are
> only two low priority tasks running, ideally we should be running them
> on two different packages. With this patch, we may end up running on the
> same logical processor.. leave alone running on the same package..
> As these are low priority tasks, it might be ok.. But...

Yes, this is an issue but it's not restricted to HT systems (except for 
the same package part).  The latest patch that I've posted addresses 
(part of) this problem by replacing SCHED_LOAD_SCALE with the average 
load per runnable task in the code at the end of find_busiest_group() 
which handles the case where imbalance is small.  This should enable 
load balancing to occur even if all runnable tasks are low priority.

The issue of the two tasks ending up on the same package isn't (as far 
as I can see) caused by the smpnice load balancing changes.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
