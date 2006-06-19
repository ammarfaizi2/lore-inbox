Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932226AbWFSHFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbWFSHFe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 03:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbWFSHFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 03:05:34 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:56723 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932226AbWFSHFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 03:05:33 -0400
Message-ID: <44964C89.6060003@jp.fujitsu.com>
Date: Mon, 19 Jun 2006 16:04:41 +0900
From: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: Sam Vilain <sam@vilain.net>
Cc: vatsa@in.ibm.com, Nick Piggin <nickpiggin@yahoo.com.au>,
       Kirill Korotaev <dev@openvz.org>, Mike Galbraith <efault@gmx.de>,
       Ingo Molnar <mingo@elte.hu>, Peter Williams <pwil3058@bigpond.net.au>,
       Andrew Morton <akpm@osdl.org>, sekharan@us.ibm.com,
       Balbir Singh <balbir@in.ibm.com>, linux-kernel@vger.kernel.org,
       kurosawa@valinux.co.jp, ckrm-tech@lists.sourceforge.net,
       MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
Subject: Re: [RFC] CPU controllers?
References: <20060615134632.GA22033@in.ibm.com> <4493C1D1.4020801@yahoo.com.au> <20060617164812.GB4643@in.ibm.com> <4494DF50.2070509@yahoo.com.au> <4494EA66.8030305@vilain.net> <20060618071847.GA4988@in.ibm.com> <449606F5.6050909@vilain.net>
In-Reply-To: <449606F5.6050909@vilain.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Vilain wrote:
> Srivatsa Vaddagiri wrote:
>> On Sun, Jun 18, 2006 at 05:53:42PM +1200, Sam Vilain wrote:
>>   
>>> Bear in mind that we have on the table at least one group of scheduling 
>>> solutions (timeslice scaling based ones, such as the VServer one) which 
>>> is virtually no overhead and could potentially provide the "jumpers" 
>>> necessary for implementing more complex scheduling policies.
>>>     
>> 	Do you have any plans to post the vserver CPU control
>> implementation hooked against maybe Resource Groups (for grouping
>> tasks)? Seeing several different implementation against current
>> kernel may perhaps help maintainers decide what they like and what they
>> don't?
> 
> That sounds like a good idea, I like the Resource Groups concept in
> general and it would be good to be able to fit this into a more generic
> and comprehensive framework.

That sounds nice.

> I'll try it against Chandra and Maeda's Apr 27 submission (a shame I
> missed it the first time around), and see how far I get.
> 
> [goes away a bit]
> 
> ok, so basically the bit in cpu_rc_load() where for_each_cpu_mask() is
> called, in Maeda Naoaki's patch "CPU controller - Add class load
> estimation support", is where O(N) creeps in that could be remedied with
> a token bucket algorithm. You don't want this because if you have 10,000
> processes on a system in two resource groups, the aggregate performance
> will suffer due to the large number of cacheline misses during the 5,000
> size loop that runs every resched.

Thank you for looking the code.

cpu_rc_load() is never called unless sysadm tries to access the load
information via configfs from userland. In addition, it sums up per-CPU
group stats, so the size of loop is the number of CPU, not process in
the group.

However, there is a similer loop in cpu_rc_recalc_tsfactor(), which runs
every CPU_RC_RECALC_INTERVAL that is defined as HZ. I don't think it
will cause a big performance penalty.

> To apply the token bucket here, you would first change the per-CPU
> struct cpu_rc to have the TBF fields; minimally:
> 
> int tokens; /* current number of CPU tokens */
> 
> int fill_rate[2]; /* Fill rate: add X tokens... */
> int interval[2]; /* Divisor: per Y jiffies */
> int tokens_max; /* Limit: no more than N tokens */
> 
> unsigned long last_time; /* last time accounted */
> 
> (note: the VServer implementation has several other fields for various
> reasons; the above are the important ones).
> 
> Then, in cpu_rc_record_allocation(), you'd take the length of the slice
> out of the bucket (subtract from tokens). In cpu_rc_account(), you would
> then "refund" unused CPU tokens back. The approach in Linux-VServer is
> to remove tokens every scheduler_tick(), but perhaps there are
> advantages to doing it the way you are in the CPU controller Resource
> Groups patch.
> 
> That part should obviate the need for cpu_rc_load() altogether.
> 
> Then, in cpu_rc_scale_timeslice(), you would make it add a bonus
> depending on (tokens / tokens_max); I found a quadratic back-off,
> scaling 0% full to a +15 penalty, 100% full to a -5 bonus and 50% full
> to no bonus, worked well - in my simple purely CPU bound process tests
> using tight loop processes.
> 
> Note that when the bucket reaches 0, there is a choice to keep
> allocating short timeslices anyway, under the presumption that the
> system has CPU to burn (sched_soft), or to put all processes in that RC
> on hold (sched_hard). This could potentially be controlled by flags on
> the bucket - as well as the size of the boost.
> 
> Hence, the "jumpers" I refer to are the bucket parameters - for
> instance, if you set the tokens_max to ~HZ, and have a suitably high
> priority/RT task monitoring the buckets, then that process should be
> able to;
> 
> - get a complete record of how many tokens were used by a RC since it
> last checked,
> - influence subsequent scheduling priority of the RC, by adjusting the
> fill rate, current tokens value, the size of the boost, or the
> "sched_hard" flag
> 
> ...and it could probably do that with very occasional timeslices, such
> as one slice per N*HZ (where N ~ the number of resource groups). So that
> makes it a candidate for moving to userland.
> 
> The current VServer implementation fails to schedule fairly when the CPU
> allocations do not add up correctly; if you only allocated 25% of CPU to
> one vserver, then 40% to another, and they are both busy, they might end
> up both with empty buckets and an equal +15 penalty - effectively using
> 50/50 CPU and allocating very short timeslices, yielding poor batch
> performance.
> 
> So, with (possibly userland) policy monitoring for this sort of
> condition and adjusting bucket sizes and levels appropriately, that old
> "problem" that leads people to conclude that the VServer scheduler does
> not work could be solved - all without incurring major overhead even on
> very busy systems.
> 
> I think that the characteristics of these two approaches are subtly
> different. Both scale timeslices, but in a different way - instead of
> estimating the load and scaling back timeslices up front, busy Resource
> Groups are relied on to deplete their tokens in a timely manner, and get
> shorter slices allocated because of that. No doubt from 10,000 feet they
> both look the same.

Current 0(1) scheduler gives extra bonus for interactive tasks by
requeuing them to active array for a while. It would break
the controller's efforts. So, I'm planning to stop the interactive
task requeuing if the target share doesn't meet.

Are there a similar issue on the vserver scheduler?

> There is probably enough information here for an implementation, but
> I'll wait for feedback on this post before going any further with it.
> 
> Sam.

Thanks,
MAEDA Naoaki

