Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751198AbWCMWj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbWCMWj2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 17:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbWCMWj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 17:39:28 -0500
Received: from omta02sl.mx.bigpond.com ([144.140.93.154]:62668 "EHLO
	omta02sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751057AbWCMWj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 17:39:27 -0500
Message-ID: <4415F49C.8020208@bigpond.net.au>
Date: Tue, 14 Mar 2006 09:39:24 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, ck list <ck@vds.kolivas.org>
Subject: Re: [PATCH][2/4] sched: add discrete weighted cpu load function
References: <200603131906.11739.kernel@kolivas.org>
In-Reply-To: <200603131906.11739.kernel@kolivas.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Mon, 13 Mar 2006 22:39:25 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> When the type of weighting is known to be zero we can use a simpler
> version of source_load with a weighted_cpuload() function. Export that
> function to allow relative weighted cpu load to be used by other
> subsystems if desired.
> 
> Signed-off-by: Con Kolivas <kernel@kolivas.org>
> 
> ---
>  include/linux/sched.h |    1 +
>  kernel/sched.c        |   10 ++++++++--
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6.16-rc6-mm1/include/linux/sched.h
> ===================================================================
> --- linux-2.6.16-rc6-mm1.orig/include/linux/sched.h	2006-03-13 13:25:31.000000000 +1100
> +++ linux-2.6.16-rc6-mm1/include/linux/sched.h	2006-03-13 18:29:34.000000000 +1100
> @@ -102,6 +102,7 @@ extern int nr_processes(void);
>  extern unsigned long nr_running(void);
>  extern unsigned long nr_uninterruptible(void);
>  extern unsigned long nr_iowait(void);
> +extern unsigned long weighted_cpuload(const int cpu);
>  
>  #include <linux/time.h>
>  #include <linux/param.h>
> Index: linux-2.6.16-rc6-mm1/kernel/sched.c
> ===================================================================
> --- linux-2.6.16-rc6-mm1.orig/kernel/sched.c	2006-03-13 13:25:39.000000000 +1100
> +++ linux-2.6.16-rc6-mm1/kernel/sched.c	2006-03-13 17:05:26.000000000 +1100
> @@ -914,6 +914,12 @@ inline int task_curr(const task_t *p)
>  	return cpu_curr(task_cpu(p)) == p;
>  }
>  
> +/* Used instead of source_load when we know the type == 0 */
> +unsigned long weighted_cpuload(const int cpu)
> +{
> +	return (cpu_rq(cpu)->raw_weighted_load);
> +}
> +

Wouldn't this be a candidate for inlining?

>  #ifdef CONFIG_SMP
>  typedef struct {
>  	struct list_head list;
> @@ -1114,7 +1120,7 @@ find_idlest_cpu(struct sched_group *grou
>  	cpus_and(tmp, group->cpumask, p->cpus_allowed);
>  
>  	for_each_cpu_mask(i, tmp) {
> -		load = source_load(i, 0);
> +		load = weighted_cpuload(i);
>  
>  		if (load < min_load || (load == min_load && i == this_cpu)) {
>  			min_load = load;
> @@ -2186,7 +2192,7 @@ static runqueue_t *find_busiest_queue(st
>  	int i;
>  
>  	for_each_cpu_mask(i, group->cpumask) {
> -		load = source_load(i, 0);
> +		load = weighted_cpuload(i);
>  
>  		if (load > max_load) {
>  			max_load = load;
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
