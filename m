Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932246AbWDKBNx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbWDKBNx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 21:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbWDKBNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 21:13:53 -0400
Received: from mga06.intel.com ([134.134.136.21]:19755 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S932246AbWDKBNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 21:13:52 -0400
TrustExchangeSourcedMail: True
X-ExchangeTrusted: True
X-IronPort-AV: i="4.04,109,1144047600"; 
   d="scan'208"; a="21687528:sNHT17525550"
Date: Mon, 10 Apr 2006 18:12:37 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Andrew Morton <akpm@osdl.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
       Mike Galbraith <efault@gmx.de>, Nick Piggin <nickpiggin@yahoo.com.au>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: move enough load to balance average load per task
Message-ID: <20060410181237.A26977@unix-os.sc.intel.com>
References: <4439FF0C.8030407@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4439FF0C.8030407@bigpond.net.au>; from pwil3058@bigpond.net.au on Mon, Apr 10, 2006 at 04:45:32PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2006 at 04:45:32PM +1000, Peter Williams wrote:
> Problem:
> 
> The current implementation of find_busiest_group() recognizes that 
> approximately equal average loads per task for each group/queue are 
> desirable (e.g. this condition will increase the probability that the 
> top N highest priority tasks on an N CPU system will be on different 
> CPUs) by being slightly more aggressive when *imbalance is small but the 
> average load per task in "busiest" group is more than that in "this" 
> group.  Unfortunately, the amount moved from "busiest" to "this" is too 
> small to reduce the average load per task on "busiest" (at best there 
> will be no change and at worst it will get bigger).

Peter, We don't need to reduce the average load per task on "busiest"
always. By moving a "busiest_load_per_task", we will increase the 
average load per task of lesser busy cpu (there by trying to achieve
the equality with busiest...)

Can you give an example scenario where this patch helps? And doesn't
the normal imabalance calculations capture those issues?

thanks,
suresh

> 
> Solution:
> 
> Increase the amount of load moved from "busiest" to "this" in these 
> circumstances while making sure that the amount of load moved won't 
> increase the (absolute) difference in the two groups' total weighted 
> loads.  A task with a weighted load greater than the average needs to be 
> moved to cause the average to be reduced.
> 
> NB This makes no difference to load balancing for the case where all 
> tasks have nice==0.
> 
> Signed-off-by: Peter Williams <pwil3058@bigpond.com.au>
> 
> -- 
> Peter Williams                                   pwil3058@bigpond.net.au
> 
> "Learning, n. The kind of ignorance distinguishing the studious."
>   -- Ambrose Bierce

> Index: MM-2.6.17-rc1-mm2/kernel/sched.c
> ===================================================================
> --- MM-2.6.17-rc1-mm2.orig/kernel/sched.c	2006-04-10 10:46:53.000000000 +1000
> +++ MM-2.6.17-rc1-mm2/kernel/sched.c	2006-04-10 14:16:32.000000000 +1000
> @@ -2258,16 +2258,20 @@ find_busiest_group(struct sched_domain *
>  	if (*imbalance < busiest_load_per_task) {
>  		unsigned long pwr_now = 0, pwr_move = 0;
>  		unsigned long tmp;
> -		unsigned int imbn = 2;
>  
> -		if (this_nr_running) {
> +		if (this_nr_running)
>  			this_load_per_task /= this_nr_running;
> -			if (busiest_load_per_task > this_load_per_task)
> -				imbn = 1;
> -		} else
> +		else
>  			this_load_per_task = SCHED_LOAD_SCALE;
>  
> -		if (max_load - this_load >= busiest_load_per_task * imbn) {
> +		if (busiest_load_per_task > this_load_per_task) {
> +			unsigned long dld = max_load - this_load;
> +
> +			if (dld > busiest_load_per_task) {
> +				*imbalance = (dld + busiest_load_per_task) / 2;
> +				return busiest;
> +			}
> +		} else if (max_load - this_load >= busiest_load_per_task * 2) {
>  			*imbalance = busiest_load_per_task;
>  			return busiest;
>  		}
