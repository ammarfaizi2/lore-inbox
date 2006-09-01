Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751248AbWIAB2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbWIAB2r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 21:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbWIAB2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 21:28:47 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:25310 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751248AbWIAB2q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 21:28:46 -0400
Date: Thu, 31 Aug 2006 18:29:27 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Josh Triplett <josht@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: [PATCH 1/4] rcu: Refactor srcu_torture_deferred_free to work for any implementation
Message-ID: <20060901012926.GD4927@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <1157065012.25808.5.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157065012.25808.5.camel@josh-work.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2006 at 03:56:52PM -0700, Josh Triplett wrote:
> Make srcu_torture_deferred_free use cur_ops->sync() so it will work for any
> implementation.  Move and rename it in preparation for use in the ops of other
> implementations.

Acked-by: Paul E. McKenney <paulmck@us.ibm.com>

> Signed-off-by: Josh Triplett <josh@freedesktop.org>
> ---
>  kernel/rcutorture.c |   53 ++++++++++++++++++++++++++++-----------------------
>  1 files changed, 29 insertions(+), 24 deletions(-)
> 
> diff --git a/kernel/rcutorture.c b/kernel/rcutorture.c
> index e045021..6e2f0a8 100644
> --- a/kernel/rcutorture.c
> +++ b/kernel/rcutorture.c
> @@ -117,6 +117,7 @@ static atomic_t n_rcu_torture_alloc_fail
>  static atomic_t n_rcu_torture_free;
>  static atomic_t n_rcu_torture_mberror;
>  static atomic_t n_rcu_torture_error;
> +static struct list_head rcu_torture_removed;
>  
>  /*
>   * Allocate an element from the rcu_tortures pool.
> @@ -270,6 +271,32 @@ static struct rcu_torture_ops rcu_ops = 
>  	.name = "rcu"
>  };
>  
> +static void rcu_sync_torture_deferred_free(struct rcu_torture *p)
> +{
> +	int i;
> +	struct rcu_torture *rp;
> +	struct rcu_torture *rp1;
> +
> +	cur_ops->sync();
> +	list_add(&p->rtort_free, &rcu_torture_removed);
> +	list_for_each_entry_safe(rp, rp1, &rcu_torture_removed, rtort_free) {
> +		i = rp->rtort_pipe_count;
> +		if (i > RCU_TORTURE_PIPE_LEN)
> +			i = RCU_TORTURE_PIPE_LEN;
> +		atomic_inc(&rcu_torture_wcount[i]);
> +		if (++rp->rtort_pipe_count >= RCU_TORTURE_PIPE_LEN) {
> +			rp->rtort_mbtest = 0;
> +			list_del(&rp->rtort_free);
> +			rcu_torture_free(rp);
> +		}
> +	}
> +}
> +
> +static void rcu_sync_torture_init(void)
> +{
> +	INIT_LIST_HEAD(&rcu_torture_removed);
> +}
> +
>  /*
>   * Definitions for rcu_bh torture testing.
>   */
> @@ -335,12 +362,11 @@ static struct rcu_torture_ops rcu_bh_ops
>   */
>  
>  static struct srcu_struct srcu_ctl;
> -static struct list_head srcu_removed;
>  
>  static void srcu_torture_init(void)
>  {
>  	init_srcu_struct(&srcu_ctl);
> -	INIT_LIST_HEAD(&srcu_removed);
> +	rcu_sync_torture_init();
>  }
>  
>  static void srcu_torture_cleanup(void)
> @@ -377,27 +403,6 @@ static int srcu_torture_completed(void)
>  	return srcu_batches_completed(&srcu_ctl);
>  }
>  
> -static void srcu_torture_deferred_free(struct rcu_torture *p)
> -{
> -	int i;
> -	struct rcu_torture *rp;
> -	struct rcu_torture *rp1;
> -
> -	synchronize_srcu(&srcu_ctl);
> -	list_add(&p->rtort_free, &srcu_removed);
> -	list_for_each_entry_safe(rp, rp1, &srcu_removed, rtort_free) {
> -		i = rp->rtort_pipe_count;
> -		if (i > RCU_TORTURE_PIPE_LEN)
> -			i = RCU_TORTURE_PIPE_LEN;
> -		atomic_inc(&rcu_torture_wcount[i]);
> -		if (++rp->rtort_pipe_count >= RCU_TORTURE_PIPE_LEN) {
> -			rp->rtort_mbtest = 0;
> -			list_del(&rp->rtort_free);
> -			rcu_torture_free(rp);
> -		}
> -	}
> -}
> -
>  static void srcu_torture_synchronize(void)
>  {
>  	synchronize_srcu(&srcu_ctl);
> @@ -427,7 +432,7 @@ static struct rcu_torture_ops srcu_ops =
>  	.readdelay = srcu_read_delay,
>  	.readunlock = srcu_torture_read_unlock,
>  	.completed = srcu_torture_completed,
> -	.deferredfree = srcu_torture_deferred_free,
> +	.deferredfree = rcu_sync_torture_deferred_free,
>  	.sync = srcu_torture_synchronize,
>  	.stats = srcu_torture_stats,
>  	.name = "srcu"
> -- 
> 1.4.1.1
> 
> 
