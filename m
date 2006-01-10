Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932596AbWAJWof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932596AbWAJWof (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 17:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932598AbWAJWoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 17:44:34 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:21932 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932596AbWAJWod
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 17:44:33 -0500
Date: Tue, 10 Jan 2006 14:44:57 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, Dipankar Sarma <dipankar@in.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/3] rcu: uninline __rcu_pending()
Message-ID: <20060110224457.GJ18252@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <43C3BA8C.FD288DB2@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C3BA8C.FD288DB2@tv-sign.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2006 at 04:45:48PM +0300, Oleg Nesterov wrote:
> __rcu_pending() is rather fat and called twice from rcu_pending().
> 
> rcu_pending() has multiple callers, and not that small too.
> 
> This patch uninlines both of them.

Looks good to me!  Passes a quick rcutorture test on x86.  Running
more extensive tests on both x86 and ppc64.

						Thanx, Paul

Acked-by: Paul E. McKenney <paulmck@us.ibm.com>
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
> 
> --- 2.6.15/include/linux/rcupdate.h~1_OUTL	2006-01-10 18:34:22.000000000 +0300
> +++ 2.6.15/include/linux/rcupdate.h	2006-01-10 18:35:45.000000000 +0300
> @@ -125,36 +125,7 @@ static inline void rcu_bh_qsctr_inc(int 
>  	rdp->passed_quiesc = 1;
>  }
>  
> -static inline int __rcu_pending(struct rcu_ctrlblk *rcp,
> -						struct rcu_data *rdp)
> -{
> -	/* This cpu has pending rcu entries and the grace period
> -	 * for them has completed.
> -	 */
> -	if (rdp->curlist && !rcu_batch_before(rcp->completed, rdp->batch))
> -		return 1;
> -
> -	/* This cpu has no pending entries, but there are new entries */
> -	if (!rdp->curlist && rdp->nxtlist)
> -		return 1;
> -
> -	/* This cpu has finished callbacks to invoke */
> -	if (rdp->donelist)
> -		return 1;
> -
> -	/* The rcu core waits for a quiescent state from the cpu */
> -	if (rdp->quiescbatch != rcp->cur || rdp->qs_pending)
> -		return 1;
> -
> -	/* nothing to do */
> -	return 0;
> -}
> -
> -static inline int rcu_pending(int cpu)
> -{
> -	return __rcu_pending(&rcu_ctrlblk, &per_cpu(rcu_data, cpu)) ||
> -		__rcu_pending(&rcu_bh_ctrlblk, &per_cpu(rcu_bh_data, cpu));
> -}
> +extern int rcu_pending(int cpu);
>  
>  /**
>   * rcu_read_lock - mark the beginning of an RCU read-side critical section.
> --- 2.6.15/kernel/rcupdate.c~1_OUTL	2006-01-10 18:34:41.000000000 +0300
> +++ 2.6.15/kernel/rcupdate.c	2006-01-10 18:35:45.000000000 +0300
> @@ -442,6 +442,36 @@ static void rcu_process_callbacks(unsign
>  				&__get_cpu_var(rcu_bh_data));
>  }
>  
> +static int __rcu_pending(struct rcu_ctrlblk *rcp, struct rcu_data *rdp)
> +{
> +	/* This cpu has pending rcu entries and the grace period
> +	 * for them has completed.
> +	 */
> +	if (rdp->curlist && !rcu_batch_before(rcp->completed, rdp->batch))
> +		return 1;
> +
> +	/* This cpu has no pending entries, but there are new entries */
> +	if (!rdp->curlist && rdp->nxtlist)
> +		return 1;
> +
> +	/* This cpu has finished callbacks to invoke */
> +	if (rdp->donelist)
> +		return 1;
> +
> +	/* The rcu core waits for a quiescent state from the cpu */
> +	if (rdp->quiescbatch != rcp->cur || rdp->qs_pending)
> +		return 1;
> +
> +	/* nothing to do */
> +	return 0;
> +}
> +
> +int rcu_pending(int cpu)
> +{
> +	return __rcu_pending(&rcu_ctrlblk, &per_cpu(rcu_data, cpu)) ||
> +		__rcu_pending(&rcu_bh_ctrlblk, &per_cpu(rcu_bh_data, cpu));
> +}
> +
>  void rcu_check_callbacks(int cpu, int user)
>  {
>  	if (user ||
> 
