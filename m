Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261173AbVBLRrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbVBLRrN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 12:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbVBLRrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 12:47:13 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:27275 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261173AbVBLRrC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 12:47:02 -0500
Message-ID: <420E4139.1050907@watson.ibm.com>
Date: Sat, 12 Feb 2005 12:47:37 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
Reply-To: nagar@watson.ibm.com
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Williams <pwil3058@bigpond.net.au>
CC: ckrm-tech <ckrm-tech@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ckrm-e17
References: <41F92A48.2010100@watson.ibm.com> <420D98A3.3060508@bigpond.net.au>
In-Reply-To: <420D98A3.3060508@bigpond.net.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> Shailabh Nagar wrote:
> 
> 
> At line 3887 of cpu.ckrm-e17.v10.patch you add the line:
> 
>         set_task_cpu(p,this_cpu);
> 
> to the middle of the function wake_up_new_task() resulting in the 
> following code:
> 
>     } else {
>         this_rq = cpu_rq(this_cpu);
> 
>         /*
>          * Not the local CPU - must adjust timestamp. This should
>          * get optimised away in the !CONFIG_SMP case.
>          */
>         p->sdu.ingosched.timestamp = (p->sdu.ingosched.timestamp - 
> this_rq->timestamp_last_tick)
>                     + rq->timestamp_last_tick;
>         set_task_cpu(p,this_cpu);
>         __activate_task(p, rq);
>         if (TASK_PREEMPTS_CURR(p, rq))
>             resched_task(rq->curr);
> 
>         schedstat_inc(rq, wunt_moved);
>         /*
>          * Parent and child are on different CPUs, now get the
>          * parent runqueue to update the parent's 
> ->sdu.ingosched.sleep_avg:
>          */
>         task_rq_unlock(rq, &flags);
>         this_rq = task_rq_lock(current, &flags);
>     }
> 
> where "rq" has been set by the return value of "task_rq_lock(p, 
> &flags)", and the test "(cpu == this_cpu)" has failed with "cpu" set to 
> "task_cpu(p)".  The result of this when the CKRM CPU code is not 
> configured into the build is that "p" will be queued on a runqueue that 
> is not in agreement with "p->thread_info->cpu" which in turn will lead 
> to future use of "task_rq_lock()" locking the wrong run queue and 
> eventually triggering some form of race condition.
> 
> If CKRM CPU is configured into the build the results are less drastic as 
> they only result in "nr_running" being incremented for the wrong run 
> queue.  However, even this will have adverse scheduling effects as it 
> will probably confuse the load balancing code.  Another potentially 
> confusing thing with this code (when CKRM CPU is configured in) is that 
> __activate_task() does NOT queue "p" on "rq" but on the queue found by 
> the call "get_task_lrq(p)".
> 
> The recommended fix for this problem would be to withdraw the:
> 
>         set_task_cpu(p,this_cpu);
> 
> Peter

Thanks for finding that out. Will confirm and fix in the next release.

> PS I reported this to the ckrm-tech list 5 days ago but it was ignored.

Other project priorities prevented us from responding sooner. There's no 
call to jump to conclusions.

-- Shailabh

