Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750930AbWC2Wt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbWC2Wt4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 17:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751025AbWC2Wt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 17:49:56 -0500
Received: from omta02sl.mx.bigpond.com ([144.140.93.154]:26722 "EHLO
	omta02sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750929AbWC2Wtz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 17:49:55 -0500
Message-ID: <442B0F10.9000606@bigpond.net.au>
Date: Thu, 30 Mar 2006 09:49:52 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Tim Chen <tim.c.chen@linux.intel.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: smpnice try to wakeup modification
References: <4429F5AC.4000103@linux.intel.com>
In-Reply-To: <4429F5AC.4000103@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Wed, 29 Mar 2006 22:49:53 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Chen wrote:
> Peter,
> 
> If there is no load on this_cpu, (i.e. tl_per_task is 0), we will fail 
> the  "tl + target_load(cpu, idx) <= tl_per_task" check.

This isn't the case.  If this_cpu is idle tl_per_task will be set to 
SCHED_LOAD_SCALE (see implementation of cpu_avg_load_per_task()) and 
that expression should succeed unless the value returned by 
target_load(cpu, idx) is bigger than SCHED_LOAD_SCALE.  This is exactly 
the same as would have happened with the original code.

(BTW cpu_avg_load_per_task()'s original implementation would have had 
the effect you describe but it was modified when it was realized that it 
would break the code in a lot of places (not just here).  The thinking 
now is that if there isn't enough data available to calculate the 
average load per task for a run queue then the correct value to use is 
the theoretical average i.e. SCHED_LOAD_SCALE.)

>  I think the 
> original intention was
> to put task on this_cpu if it has no load and when there's already one 
> task on cpu. This helps spread tasks out for low load condition.
> 
> Thanks.
> 
> Tim
> 
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> 
> --- linux-2.6.16-mm2-a/kernel/sched.c    2006-03-28 16:00:37.091779904 
> -0800
> +++ linux-2.6.16-mm2-b/kernel/sched.c    2006-03-28 16:09:08.237074008 
> -0800
> @@ -1393,7 +1393,7 @@ static int try_to_wake_up(task_t *p, uns
> 
>         if (this_sd->flags & SD_WAKE_AFFINE) {
>             unsigned long tl = this_load;
> -            unsigned long tl_per_task = cpu_avg_load_per_task(this_cpu);
> +            unsigned long sl_per_task = cpu_avg_load_per_task(cpu);
> 
>             /*
>              * If sync wakeup then subtract the (maximum possible)
> @@ -1404,7 +1404,7 @@ static int try_to_wake_up(task_t *p, uns
>                 tl -= current->load_weight;
> 
>             if ((tl <= load &&
> -                tl + target_load(cpu, idx) <= tl_per_task) ||
> +                tl + target_load(cpu, idx) <= sl_per_task) ||
>                 100*(tl + p->load_weight) <= imbalance*load) {
>                 /*
>                  * This domain has SD_WAKE_AFFINE and

Nevertheless, in some cases, it was difficult to decide which run 
queue's average load per task should be used to replace SCHED_LOAD_SCALE 
and a careful review of the code by those with expertise in this area 
would be appreciated as I may have made mistakes.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
