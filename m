Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750999AbWC3FFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbWC3FFK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 00:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750931AbWC3FE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 00:04:56 -0500
Received: from smtp.osdl.org ([65.172.181.4]:20692 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750854AbWC3FEa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 00:04:30 -0500
Date: Wed, 29 Mar 2006 21:04:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch 6/8] virtual cpu run time
Message-Id: <20060329210415.5d84e5a5.akpm@osdl.org>
In-Reply-To: <442B2C5D.2020300@watson.ibm.com>
References: <442B271D.10208@watson.ibm.com>
	<442B2C5D.2020300@watson.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shailabh Nagar <nagar@watson.ibm.com> wrote:
>
> delayacct-virtcpu.patch
> 
> Distinguish between "wall-clock" and "virtual" cpu run times and return
> both, at per-task and per-tgid granularity.
> 
> Some architectures adjust tsk->utime+tsk->stime to reflect the time that
> the kernel wasn't scheduled in hypervised environments and this is the
> "wall-clock" cpu run time. "Virtual" cpu run time, on the other hand, does
> not account for the kernel being descheduled.
> 
> This patch allows the most accurate "virtual" cpu run time, collected by
> the schedstats code (now shared with delay accounting code), to be returned
> to user space, in addition to the "wall-clock" cpu time that was being exported
> earlier. Both these times are useful for workload management in different
> situations.
> 
> In a non-virtualized environment, or on architectures which do not adjust
> tsk->utime/stime, these will effectively be the same value but at different
> granularities.
> 
> ...
> 
> Index: linux-2.6.16/include/linux/taskstats.h
> ===================================================================
> --- linux-2.6.16.orig/include/linux/taskstats.h	2006-03-29 18:13:18.000000000 -0500
> +++ linux-2.6.16/include/linux/taskstats.h	2006-03-29 18:13:20.000000000 -0500
> @@ -46,8 +46,14 @@ struct taskstats {
>  	__u64	swapin_count;
>  	__u64	swapin_delay_total;	/* swapin page fault wait*/
> 
> -	__u64	cpu_run_total;		/* cpu running time
> -					 * no count available/provided */
> +	__u64	cpu_run_real_total;	/* cpu "wall-clock" running time
> +					 * Potentially accounts for cpu
> +					 * virtualization, on some arches
> +					 */
> +	__u64	cpu_run_virtual_total;	/* cpu "virtual" running time
> +					 * Uses time intervals as seen by
> +					 * the kernel
> +					 */
>  };
> 

Again, the reader of this struct wants to know what the atomicity rules are.

> +	d->cpu_run_real_total = (tmp < (nsec_t)d->cpu_run_real_total)? 0: tmp;

	lval = expr1 ? expr2 : expr3;

> +	tmp = (nsec_t)d->cpu_run_virtual_total
> +		+ (nsec_t)jiffies_to_usecs(t3) * 1000;

umm, Linux doesn't have nsec_t any more.

