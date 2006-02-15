Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932186AbWBOWgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbWBOWgQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 17:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWBOWgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 17:36:16 -0500
Received: from omta03ps.mx.bigpond.com ([144.140.82.155]:55038 "EHLO
	omta03ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932186AbWBOWgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 17:36:16 -0500
Message-ID: <43F3ACDD.4060901@bigpond.net.au>
Date: Thu, 16 Feb 2006 09:36:13 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
CC: Andrew Morton <akpm@osdl.org>, kernel@kolivas.org, npiggin@suse.de,
       mingo@elte.hu, rostedt@goodmis.org, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [rfc][patch] sched: remove smpnice
References: <43ED3D6A.8010300@bigpond.net.au> <20060214010712.B20191@unix-os.sc.intel.com> <43F25C60.4080603@bigpond.net.au> <20060214230745.A1677@unix-os.sc.intel.com>
In-Reply-To: <20060214230745.A1677@unix-os.sc.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Wed, 15 Feb 2006 22:36:13 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siddha, Suresh B wrote:
> On Wed, Feb 15, 2006 at 09:40:32AM +1100, Peter Williams wrote:
> 
>>Siddha, Suresh B wrote:
>>
>>>On a 4P(8-way with HT), if you run a -20 task(a simple infinite loop)
>>>it hops from one processor to another processor... you can observe it
>>>using top.
>>
>>How do you get top to display which CPU tasks are running on?
> 
> 
> In the interactive mode, you can select the "last used cpu" field to display.
> or you can use /proc/pid/stat
> 
> 
>>>find_busiest_group() thinks there is an imbalance and ultimately the
>>>idle cpu kicks active load balance on busy cpu, resulting in the hopping.
>>
>>I'm still having trouble getting my head around this.  A task shouldn't 
>>be moved unless there's at least one other task on its current CPU, it 
> 
> 
> Because of the highest priority task, weighted load of that cpu
> will be > SCHED_LOAD_SCALE. Because of this, an idle cpu in 
> find_busiest_group() thinks that there is an imbalance.. This is due to
> the code near the comment "however we may be able to increase 
> total CPU power used by ...". That piece of code assumes that a unit load
> is represented by SCHED_LOAD_SCALE (which is no longer true with smpnice)
> and finally results in "pwr_move > pwr_now".. This will make the idle cpu
> try to pull that process from busiest cpu and the process will ultimately move
> with the help of active load balance...

But as I pointed out, with the code as it is in the recent -mm kernels, 
the amount of biased load (i.e. NICE_TO_BIAS_PRIO(0)) that 
find_busiest_group() sets *imbalance to in these circumstances is too 
small for a task with nice less than zero to be moved i.e. move_tasks() 
will skip it.  Or are you just referring to the vanilla kernels?

> 
> 
>>>I agree with you.. But lets take a DP system with HT, now if there are
>>>only two low priority tasks running, ideally we should be running them
>>>on two different packages. With this patch, we may end up running on the
>>>same logical processor.. leave alone running on the same package..
>>>As these are low priority tasks, it might be ok.. But...
>>
>>Yes, this is an issue but it's not restricted to HT systems (except for 
> 
> 
> Agreed.
> 
> 
>>the same package part).  The latest patch that I've posted addresses 
>>(part of) this problem by replacing SCHED_LOAD_SCALE with the average 
>>load per runnable task in the code at the end of find_busiest_group() 
>>which handles the case where imbalance is small.  This should enable 
>>load balancing to occur even if all runnable tasks are low priority.
> 
> 
> Yes. We need to fix the code I mentioned above too.... And please make sure
> it doesn't break HT optimizations as this piece of code is mainly used
> for implementing HT optimizations..

OK, but I wouldn't call them optimizations (to say something is optimal 
is a big call :-)) as the HT code is more about enforcing "nice" (at the 
expense of throughput) than it is anything else.  By the way, I think 
that one avenue that should be considered for HT systems is to have a 
single run queue for each package and feed the logical CPUs in the 
package from that.  This would greatly improve the likelihood that the 
tasks selected to run on the logical CPUs within the package are of 
approximately the same priority and, consequently reduce the need to 
idle one of them.  The downside of this is the extra complexity that it 
would introduce.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
