Return-Path: <linux-kernel-owner+w=401wt.eu-S1751447AbXAPRwH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbXAPRwH (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 12:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbXAPRwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 12:52:06 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:60548 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447AbXAPRwF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 12:52:05 -0500
Date: Tue, 16 Jan 2007 09:53:55 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: [mm PATCH 3/6] RCU: Fix barriers
Message-ID: <20070116175355.GF1776@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20070115191909.GA32238@in.ibm.com> <20070115192446.GD32238@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070115192446.GD32238@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 16, 2007 at 12:54:46AM +0530, Dipankar Sarma wrote:
> 
> 
> Fix rcu_barrier() to work properly in preemptive kernel environment.
> Also, the ordering of callback must be preserved while moving
> callbacks to another CPU during CPU hotplug.

Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

> Signed-off-by: Dipankar Sarma <dipankar@in.ibm.com>
> ---
> 
> 
> 
> diff -puN kernel/rcuclassic.c~rcu-fix-barriers kernel/rcuclassic.c
> --- linux-2.6.20-rc3-mm1-rcu/kernel/rcuclassic.c~rcu-fix-barriers	2007-01-15 15:36:47.000000000 +0530
> +++ linux-2.6.20-rc3-mm1-rcu-dipankar/kernel/rcuclassic.c	2007-01-15 15:36:47.000000000 +0530
> @@ -350,9 +350,9 @@ static void __rcu_offline_cpu(struct rcu
>  	if (rcp->cur != rcp->completed)
>  		cpu_quiet(rdp->cpu, rcp);
>  	spin_unlock_bh(&rcp->lock);
> +	rcu_move_batch(this_rdp, rdp->donelist, rdp->donetail);
>  	rcu_move_batch(this_rdp, rdp->curlist, rdp->curtail);
>  	rcu_move_batch(this_rdp, rdp->nxtlist, rdp->nxttail);
> -	rcu_move_batch(this_rdp, rdp->donelist, rdp->donetail);
>  }
> 
>  static void rcu_offline_cpu(int cpu)
> diff -puN kernel/rcupdate.c~rcu-fix-barriers kernel/rcupdate.c
> --- linux-2.6.20-rc3-mm1-rcu/kernel/rcupdate.c~rcu-fix-barriers	2007-01-15 15:36:47.000000000 +0530
> +++ linux-2.6.20-rc3-mm1-rcu-dipankar/kernel/rcupdate.c	2007-01-15 15:36:47.000000000 +0530
> @@ -117,7 +117,18 @@ void rcu_barrier(void)
>  	mutex_lock(&rcu_barrier_mutex);
>  	init_completion(&rcu_barrier_completion);
>  	atomic_set(&rcu_barrier_cpu_count, 0);
> +	/*
> +	 * The queueing of callbacks in all CPUs must be
> +	 * atomic with respect to RCU, otherwise one cpu may
> +	 * queue a callback, wait for a grace period, decrement
> +	 * barrier count and call complete(), while other CPUs
> +	 * haven't yet queued anything. So, we need to make sure
> +	 * that no grace period happens until all the callbacks
> +	 * are queued.
> +	 */
> +	rcu_read_lock();
>  	on_each_cpu(rcu_barrier_func, NULL, 0, 1);
> +	rcu_read_unlock();
>  	wait_for_completion(&rcu_barrier_completion);
>  	mutex_unlock(&rcu_barrier_mutex);
>  }
> 
> _
