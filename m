Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932215AbWDFRYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbWDFRYj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 13:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbWDFRYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 13:24:39 -0400
Received: from dvhart.com ([64.146.134.43]:24519 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S932215AbWDFRYj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 13:24:39 -0400
From: Darren Hart <darren@dvhart.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: RT task scheduling
Date: Thu, 6 Apr 2006 10:24:34 -0700
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>,
       "Stultz, John" <johnstul@us.ibm.com>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>
References: <200604052025.05679.darren@dvhart.com> <443496CA.6050905@bigpond.net.au>
In-Reply-To: <443496CA.6050905@bigpond.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604061024.35300.darren@dvhart.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 April 2006 21:19, Peter Williams wrote:
> Darren Hart wrote:
> > My last mail specifically addresses preempt-rt, but I'd like to know
> > people's thoughts regarding this issue in the mainline kernel.  Please
> > see my previous post "realtime-preempt scheduling - rt_overload behavior"
> > for a testcase that produces unpredictable scheduling results.
> >
> > Part of the issue here is to define what we consider "correct behavior"
> > for SCHED_FIFO realtime tasks.  Do we (A) need to strive for "strict
> > realtime priority scheduling" where the NR_CPUS highest priority runnable
> > SCHED_FIFO tasks are _always_ running?  Or do we (B) take the best effort
> > approach with an upper limit RT priority imbalances, where an imbalance
> > may occur (say at wakeup or exit) but will be remedied within 1 tick. 
> > The smpnice patches improve load balancing, but don't provide (A).
> >
> > More details in the previous mail...
>
> I'm currently researching some ideas to improve smpnice that may help in
> this situation.  The basic idea is that as well as trying to equally
> distribute the weighted load among the groups/queues we should also try
> to achieve equal "average load per task" for each group/queue.  (As well
> as helping with problems such as yours, this will help to restore the
> "equal distribution of nr_running" amongst groups/queues aim that is
> implicit without smpnice due to the fact that load is just a smoothed
> version of nr_running.)

Can you elaborate on what you mean by "average load per task" ?  

Also, since smpnice is (correct me if I am wrong) load_balancing, I don't 
think it will prevent the problem from happening, but rather fix it when it 
does.  If we want to prevent it from happening, I think we need to do 
something like the rt_overload code from the RT patchset.

>
> In find_busiest_group(), I think that load balancing in the case where
> *imbalance is greater than busiest_load_per_task will tend towards this
> result and also when *imbalance is less than busiest_load_per_task AND
> busiest_load_per_task is less than this_load_per_task.  However, in the
> case where *imbalance is less than busiest_load_per_task AND
> busiest_load_per_task is greater than this_load_per_task this will not
> be the case as the amount of load moved from "busiest" to "this" will be
> less than or equal to busiest_load_per_task and this will actually
> increase the value of busiest_load_per_task.  So, although it will
> achieve the aim of equally distributing the weighted load, it won't help
> the second aim of equal "average load per task" values for groups/queues.
>
> The obvious way to fix this problem is to alter the code so that more
> than busiest_load_per_task is moved from "busiest" to "this" in these
> cases while at the same time ensuring that the imbalance between their
> loads doesn't get any bigger.  I'm working on a patch along these lines.
>
> Changes to find_idlest_group() and try_to_wake_up() taking into account
> the "average load per task" on the candidate queues/groups as well as
> their weighted loads may also help and I'll be looking at them as well.
>   It's not immediately obvious to me how this can be done so any ideas
> would be welcome.  It will likely involve taking the load weight of the
> waking task into account as well.
>
> Peter
