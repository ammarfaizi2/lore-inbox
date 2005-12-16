Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751317AbVLPRvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbVLPRvz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 12:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbVLPRvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 12:51:55 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:34192 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751317AbVLPRvy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 12:51:54 -0500
Date: Fri, 16 Dec 2005 09:52:01 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, Eric Dumazet <dada1@cosmosbay.com>,
       linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       Simon Derr <Simon.Derr@bull.net>, Andi Kleen <ak@suse.de>,
       Christoph Lameter <clameter@sgi.com>
Subject: Re: [PATCH 04/04] Cpuset: skip rcu check if task is in root cpuset
Message-ID: <20051216175201.GA24876@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20051214084031.21054.13829.sendpatchset@jackhammer.engr.sgi.com> <20051214084049.21054.34108.sendpatchset@jackhammer.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051214084049.21054.34108.sendpatchset@jackhammer.engr.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2005 at 12:40:49AM -0800, Paul Jackson wrote:
> For systems that aren't using cpusets, but have them
> CONFIG_CPUSET enabled in their kernel (eventually this
> may be most distribution kernels), this patch removes
> even the minimal rcu_read_lock() from the memory page
> allocation path.
> 
> Actually, it removes that rcu call for any task that is
> in the root cpuset (top_cpuset), which on systems not
> actively using cpusets, is all tasks.
> 
> We don't need the rcu check for tasks in the top_cpuset,
> because the top_cpuset is statically allocated, so at
> no risk of being freed out from underneath us.
> 
> Signed-off-by: Paul Jackson <pj@sgi.com>
> 
> ---
> 
>  kernel/cpuset.c |   13 +++++++++----
>  1 files changed, 9 insertions(+), 4 deletions(-)
> 
> --- 2.6.15-rc3-mm1.orig/kernel/cpuset.c	2005-12-13 18:14:42.529952708 -0800
> +++ 2.6.15-rc3-mm1/kernel/cpuset.c	2005-12-13 20:54:26.323911532 -0800
> @@ -647,10 +647,15 @@ void cpuset_update_task_memory_state()
>  	struct task_struct *tsk = current;
>  	struct cpuset *cs;
>  
> -	rcu_read_lock();
> -	cs = rcu_dereference(tsk->cpuset);
> -	my_cpusets_mem_gen = cs->mems_generation;
> -	rcu_read_unlock();
> +	if (tsk->cpuset == &top_cpuset) {
> +		/* Don't need rcu for top_cpuset.  It's never freed. */
> +		my_cpusets_mem_gen = top_cpuset.mems_generation;
> +	} else {
> +		rcu_read_lock();
> +		cs = rcu_dereference(tsk->cpuset);
> +		my_cpusets_mem_gen = cs->mems_generation;
> +		rcu_read_unlock();
> +	}

Hmmm...  In non-CONFIG_PREEMPT kernels on non-Alpha CPUs, rcu_read_lock(),
rcu_read_unlock(), and rcu_reference() do nothing.  So in such cases, the
above code will be slower than unconditionally using RCU read side.

In CONFIG_PREEMPT kernels on non-Alpha CPUs, rcu_read_lock() and
rcu_read_unlock() are private non-atomic increment and decrement,
so are likely to be about the same cost as the branch.

In CONFIG_PREEMPT_RT kernels, this optimization would currently buy
you something, but might not once we get rcu_read_lock() and
rcu_read_unlock() more fully optimized.

So I am not convinced that this optimization is worthwhile.

							Thanx, Paul

>  
>  	if (my_cpusets_mem_gen != tsk->cpuset_mems_generation) {
>  		down(&callback_sem);
> 
> -- 
>                           I won't rest till it's the best ...
>                           Programmer, Linux Scalability
>                           Paul Jackson <pj@sgi.com> 1.650.933.1373
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
