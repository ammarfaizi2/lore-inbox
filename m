Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262185AbVAYWXx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262185AbVAYWXx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 17:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262172AbVAYWUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 17:20:51 -0500
Received: from gizmo03ps.bigpond.com ([144.140.71.13]:23720 "HELO
	gizmo03ps.bigpond.com") by vger.kernel.org with SMTP
	id S262188AbVAYWTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 17:19:02 -0500
Message-ID: <41F6C5CE.9050303@bigpond.net.au>
Date: Wed, 26 Jan 2005 09:18:54 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: "Jack O'Quin" <joq@io.com>, Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature
References: <200501201542.j0KFgOwo019109@localhost.localdomain> <87y8eo9hed.fsf@sulphur.joq.us> <20050120172506.GA20295@elte.hu> <87wtu6fho8.fsf@sulphur.joq.us> <20050122165458.GA14426@elte.hu> <87hdl940ph.fsf@sulphur.joq.us> <20050124085902.GA8059@elte.hu> <20050124125814.GA31471@elte.hu> <20050125135613.GA18650@elte.hu>
In-Reply-To: <20050125135613.GA18650@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> pretty much the only criticism of the RT-CPU patch was that the global
> sysctl is too rigid and that it doesnt allow privileged tasks to ignore
> the limit. I've uploaded a new RT-CPU-limit patch that solves this
> problem:
> 
>   http://redhat.com/~mingo/rt-limit-patches/
> 
> i've removed the global sysctl and implemented a new rlimit,
> RT_CPU_RATIO: the maximum amount of CPU time RT tasks may use, in
> percent. For testing purposes it defaults to 80%.
> 
> the RT-limit being an rlimit makes it much more configurable: root tasks
> can have unlimited CPU time limit, while users could have a more
> conservative setting of say 30%. This also makes it per-process and
> runtime configurable as well. The scheduler will instantly act upon any
> new RT_CPU_RATIO rlimit.
> 
> (this approach is fundamentally different from the previous patch that
> made the "maximum RT-priority available to an unprivileged task" value
> an rlimit - with priorities being an rlimit we still havent made RT
> priorities safe against deadlocks.)
> 
> multiple tasks can have different rlimits as well, and the scheduler
> interprets it the following way: it maintains a per-CPU "RT CPU use"
> load-average value and compares it against the per-task rlimit. If e.g. 
> the task says "i'm in the 60% range" and the current average is 70%,
> then the scheduler delays this RT task - if the next task has an 80%
> rlimit then it will be allowed to run. This logic is straightforward and
> can be used as a further control mechanism against runaway highprio RT
> tasks.
> 
> other properties of the RT_CPU_RATIO rlimit:
> 
>  - if there's idle time in the system then RT tasks will be
>    allowed to use more than the limit.
> 
>  - if an RT task goes above the limit all the time then there
>    is no guarantee that exactly the limit will be allowed for
>    it. (i.e. you should set the limit to somewhat above the real
>    needs of the RT task in question.)
> 
>  - a zero RLIMIT_RT_CPU_RATIO value means unlimited CPU time to that
>    RT task. If the task is not an RT task then it may not change to RT
>    priority. (i.e. a zero value makes it fully compatible with previous
>    RT scheduling semantics.)
> 
>  - a nonzero rt_cpu_limit value also has the effect of allowing
>    the use of RT priorities to nonprivileged users.
> 
>  - on SMP the limit is measured and enforced per-CPU.
> 
>  - runtime overhead is minimal, especially if the limit is set to 0.
> 
>  - the CPU-use measurement code has a 'memory' of roughly 300 msecs.
>    I.e. if an RT task runs 100 msecs nonstop then it will increase
>    its CPU use by about 30%. This should be fast enough for users for
>    the limit to be human-inperceptible, but slow enough to allow
>    occasional longer timeslices to RT tasks.

As I understand this (and I may be wrong), the intention is that if a 
task has its RT_CPU_RATIO rlimit set to a value greater than zero then 
setting its scheduling policy to SCHED_RR or SCHED_FIFO is allowed. 
This causes me to ask the following questions:

1. Why is current->signal->rlim[RLIMIT_RT_CPU_RATIO].rlim_cur being used 
in setscheduler() instead of p->signal->rlim[RLIMIT_RT_CPU_RATIO].rlim_cur?

2. What stops a task that had a non zero RT_CPU_RATIO rlimit and changed 
its policy to SCHED_RR or SCHED_FIFO from then setting RT_CPU_RATIO 
rlimit back to zero and escaping the controls?  As far as I can see 
(and, once again, I may be wrong) the mechanism for setting rlimits only 
requires CAP_SYS_RESOURCE privileges in order to increase the value.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
