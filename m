Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751490AbWBLXK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbWBLXK1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 18:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbWBLXK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 18:10:27 -0500
Received: from omta05ps.mx.bigpond.com ([144.140.83.195]:29265 "EHLO
	omta05ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751490AbWBLXK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 18:10:26 -0500
Message-ID: <43EFC05F.6010204@bigpond.net.au>
Date: Mon, 13 Feb 2006 10:10:23 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Williams <pwil3058@bigpond.net.au>
CC: Andrew Morton <akpm@osdl.org>, suresh.b.siddha@intel.com,
       kernel@kolivas.org, npiggin@suse.de, mingo@elte.hu, rostedt@goodmis.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [rfc][patch] sched: remove smpnice
References: <20060207142828.GA20930@wotan.suse.de>	<200602080157.07823.kernel@kolivas.org>	<20060207141525.19d2b1be.akpm@osdl.org>	<200602081011.09749.kernel@kolivas.org>	<20060207153617.6520f126.akpm@osdl.org>	<20060209230145.A17405@unix-os.sc.intel.com>	<20060209231703.4bd796bf.akpm@osdl.org>	<43ED3D6A.8010300@bigpond.net.au> <20060210180010.16c9d20a.akpm@osdl.org> <43EE8BAD.9040601@bigpond.net.au>
In-Reply-To: <43EE8BAD.9040601@bigpond.net.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sun, 12 Feb 2006 23:10:23 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> Andrew Morton wrote:
> 
>> Peter Williams <pwil3058@bigpond.net.au> wrote:
>>
>>> I don't think either of these issues warrant abandoning smpnice.  The 
>>> first is highly unlikely to occur on real systems and the second is 
>>> just an example of the patch doing its job (maybe too officiously).  
>>> I don't think users would notice either on real systems.
>>>
>>> Even if you pull it from 2.6.16 rather than upgrading it with my 
>>> patch can you please leave both in -mm?
>>
>>
>>
>> Yes, I have done that.  I currently have:
>>
>> sched-restore-smpnice.patch
>> sched-modified-nice-support-for-smp-load-balancing.patch
>> sched-cleanup_task_activated.patch
>> sched-alter_uninterruptible_sleep_interactivity.patch
>> sched-make_task_noninteractive_use_sleep_type.patch
>> sched-dont_decrease_idle_sleep_avg.patch
>> sched-include_noninteractive_sleep_in_idle_detect.patch
>> sched-new-sched-domain-for-representing-multi-core.patch
>> sched-fix-group-power-for-allnodes_domains.patch
> 
> 
> OK.  Having slept on these problems I am now of the opinion that the 
> problems are caused by the use of NICE_TO_BIAS_PRIO(0) to set *imbalance 
> inside the (*imbalance < SCHED_LOAD_SCALE) if statement in 
> find_busiest_group().  What is happening here is that even though the 
> imbalance is less than one (average) task sometimes the decision is made 
> to move a task anyway but with the current version this decision can be 
> subverted in two ways: 1) if the task to be moved has a nice value less 
> than zero the value of *imbalance that is set will be too small for 
> move_tasks() to move it; and 2) if there are a number of tasks with nice 
> values greater than zero on the "busiest" more than one of them may be 
> moved as the value of *imbalance that is set may be big enough to 
> include more than one of these tasks.
> 
> The fix for this problem is to replace NICE_TO_BIAS_PRIO(0) with the 
> "average bias prio per runnable task" on "busiest".  This will 
> (generally) result in a larger value for *imbalance in case 1. above and 
> a smaller one in case 2. and alleviate both problems.  A patch to apply 
> this fix is attached.
> 
> Signed-off-by: Peter Williams <pwil3058@bigpond.com.au>
> 
> Could you please add this patch to -mm so that it can be tested?
> 
> Thanks
> Peter
> 
> 
> ------------------------------------------------------------------------
> 
> Index: MM-2.6.X/kernel/sched.c
> ===================================================================
> --- MM-2.6.X.orig/kernel/sched.c	2006-02-12 11:24:48.000000000 +1100
> +++ MM-2.6.X/kernel/sched.c	2006-02-12 11:35:40.000000000 +1100
> @@ -735,6 +735,19 @@ static inline unsigned long biased_load(
>  {
>  	return (wload * NICE_TO_BIAS_PRIO(0)) / SCHED_LOAD_SCALE;
>  }
> +
> +/* get the average biased load per runnable task for a run queue */
> +static inline unsigned long avg_biased_load(runqueue_t *rq)
> +{
> +	/*
> +	 * When I'm convinced that this won't be called with a zero nr_running
> +	 * and that it can't change during the call this can be simplified.
> +	 * For the time being and for proof of concept let's paly it safe.
> +	 */
> +	unsigned long n = rq->nr_running;
> +
> +	return n ? rq->prio_bias / n : 0;
> +}
>  #else
>  static inline void set_bias_prio(task_t *p)
>  {
> @@ -2116,7 +2129,7 @@ find_busiest_group(struct sched_domain *
>  		unsigned long tmp;
>  
>  		if (max_load - this_load >= SCHED_LOAD_SCALE*2) {
> -			*imbalance = NICE_TO_BIAS_PRIO(0);
> +			*imbalance = avg_biased_load(busiest);
>  			return busiest;
>  		}
>  
> @@ -2149,7 +2162,7 @@ find_busiest_group(struct sched_domain *
>  		if (pwr_move <= pwr_now)
>  			goto out_balanced;
>  
> -		*imbalance = NICE_TO_BIAS_PRIO(0);
> +		*imbalance = avg_biased_load(busiest);
>  		return busiest;
>  	}
>  

Can we pull this one, please?  I've mistakenly assumed that busiest was 
a run queue when it's actually a sched group. :-(

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
