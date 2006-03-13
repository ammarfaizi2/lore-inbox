Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932410AbWCMXOG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbWCMXOG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 18:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932509AbWCMXOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 18:14:06 -0500
Received: from omta05sl.mx.bigpond.com ([144.140.93.195]:58049 "EHLO
	omta05sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932410AbWCMXOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 18:14:05 -0500
Message-ID: <4415FCBA.7030100@bigpond.net.au>
Date: Tue, 14 Mar 2006 10:14:02 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, ck list <ck@vds.kolivas.org>
Subject: Re: [PATCH][3/4] sched: add above background load function
References: <200603131908.00161.kernel@kolivas.org>
In-Reply-To: <200603131908.00161.kernel@kolivas.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omtas01sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Mon, 13 Mar 2006 23:08:33 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> Add an above_background_load() function which can be used by other subsystems
> to detect if there is anything besides niced tasks running. Place it in
> sched.h to allow it to be compiled out if not used.
> 
> Signed-off-by: Con Kolivas <kernel@kolivas.org>
> 
> ---
>  include/linux/sched.h |   16 ++++++++++++++++
>  1 files changed, 16 insertions(+)
> 
> Index: linux-2.6.16-rc6-mm1/include/linux/sched.h
> ===================================================================
> --- linux-2.6.16-rc6-mm1.orig/include/linux/sched.h	2006-03-13 17:05:14.000000000 +1100
> +++ linux-2.6.16-rc6-mm1/include/linux/sched.h	2006-03-13 17:24:18.000000000 +1100
> @@ -638,6 +638,22 @@ extern unsigned int max_cache_size;
>  
>  #endif	/* CONFIG_SMP */
>  
> +/*
> + * A runqueue laden with a single nice 0 task scores a weighted_cpuload of
> + * SCHED_LOAD_SCALE. This function returns 1 if any cpu is laden with a
> + * task of nice 0 or enough lower priority tasks to bring up the
> + * weighted_cpuload
> + */
> +static inline int above_background_load(void)
> +{
> +	unsigned long cpu;
> +
> +	for_each_online_cpu(cpu) {
> +		if (weighted_cpuload(cpu) >= SCHED_LOAD_SCALE)
> +			return 1;
> +	}
> +	return 0;
> +}
>  
>  struct io_context;			/* See blkdev.h */
>  void exit_io_context(void);

I think that you may need to take into account the contribution to the 
load by your swap prefetching thread when it calls this function 
otherwise it could cause an incorrect (from your point of view) positive 
return value.  If the thread has a positive nice value this comment can 
probably be ignored.

If not, then the adjustment could be made by subtracting the threads 
load_weight from the weighted_cpuload() when looking at the CPU the 
thread is running on.  To minimize the effect on the overhead of the 
function this refinement could be only performed when the current if 
statement succeeds e.g. something like

if (weighted_cpuload(cpu) >= SCHED_LOAD_SCALE) {
	if (smp_processor_id() != cpu || (weighted_cpuload(cpu) - 
current->load_weight) >= SCHED_LOAD_SCALE)
		return 1;
}

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
