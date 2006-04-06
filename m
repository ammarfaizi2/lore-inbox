Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932237AbWDFXCf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbWDFXCf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 19:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbWDFXCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 19:02:35 -0400
Received: from omta05ps.mx.bigpond.com ([144.140.83.195]:21991 "EHLO
	omta05ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932237AbWDFXCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 19:02:35 -0400
Message-ID: <44359E04.8050309@bigpond.net.au>
Date: Fri, 07 Apr 2006 09:02:28 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Darren Hart <darren@dvhart.com>
CC: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>,
       "Stultz, John" <johnstul@us.ibm.com>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: RT task scheduling
References: <200604052025.05679.darren@dvhart.com> <443496CA.6050905@bigpond.net.au> <200604061024.35300.darren@dvhart.com>
In-Reply-To: <200604061024.35300.darren@dvhart.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Thu, 6 Apr 2006 23:02:29 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Darren Hart wrote:
> On Wednesday 05 April 2006 21:19, Peter Williams wrote:
>> Darren Hart wrote:
>>> My last mail specifically addresses preempt-rt, but I'd like to know
>>> people's thoughts regarding this issue in the mainline kernel.  Please
>>> see my previous post "realtime-preempt scheduling - rt_overload behavior"
>>> for a testcase that produces unpredictable scheduling results.
>>>
>>> Part of the issue here is to define what we consider "correct behavior"
>>> for SCHED_FIFO realtime tasks.  Do we (A) need to strive for "strict
>>> realtime priority scheduling" where the NR_CPUS highest priority runnable
>>> SCHED_FIFO tasks are _always_ running?  Or do we (B) take the best effort
>>> approach with an upper limit RT priority imbalances, where an imbalance
>>> may occur (say at wakeup or exit) but will be remedied within 1 tick. 
>>> The smpnice patches improve load balancing, but don't provide (A).
>>>
>>> More details in the previous mail...
>> I'm currently researching some ideas to improve smpnice that may help in
>> this situation.  The basic idea is that as well as trying to equally
>> distribute the weighted load among the groups/queues we should also try
>> to achieve equal "average load per task" for each group/queue.  (As well
>> as helping with problems such as yours, this will help to restore the
>> "equal distribution of nr_running" amongst groups/queues aim that is
>> implicit without smpnice due to the fact that load is just a smoothed
>> version of nr_running.)
> 
> Can you elaborate on what you mean by "average load per task" ?  

It's the total weighted load on a run group/queue divided by the 
nr_running for that group/queue.  If this is equal for all groups/queues 
and the total weighted load for them are also equal then the 
distribution of priorities in each group/queue should be similar and 
this will give a high probability that (for an N CPU system) the N 
highest priority tasks will be on different CPUs and hence the highest 
priority task on their CPU.  But these are just tendencies not 
guarantees as it's a statistical process not a deterministic one.

> 
> Also, since smpnice is (correct me if I am wrong) load_balancing, I don't 
> think it will prevent the problem from happening, but rather fix it when it 
> does.  If we want to prevent it from happening, I think we need to do 
> something like the rt_overload code from the RT patchset.

I agree.  Changes to smpnice (as described above) would help with this 
problem (i.e. they'll make the distribution of tasks TEND towards the 
desired state) but would not provide the necessary determinism.  I think 
special measures (such as rt_overload) are required if you want determinism.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
