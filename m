Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964844AbWIAB3m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964844AbWIAB3m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 21:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964845AbWIAB3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 21:29:42 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:62944 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964844AbWIAB3b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 21:29:31 -0400
Date: Thu, 31 Aug 2006 18:30:11 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Josh Triplett <josht@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: [PATCH 4/4] rcu: Add sched torture type to rcutorture
Message-ID: <20060901013011.GG4927@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <1157065018.25808.9.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157065018.25808.9.camel@josh-work.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2006 at 03:56:58PM -0700, Josh Triplett wrote:
> Implement torture testing for the "sched" variant of RCU, which uses
> preempt_disable, preempt_enable, and synchronize_sched.

Acked-by: Paul E. McKenney <paulmck@us.ibm.com>

> Signed-off-by: Josh Triplett <josh@freedesktop.org>
> ---
>  Documentation/RCU/torture.txt |    5 +++--
>  kernel/rcutorture.c           |   40 +++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 42 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/RCU/torture.txt b/Documentation/RCU/torture.txt
> index cc4b1ef..25a3c3f 100644
> --- a/Documentation/RCU/torture.txt
> +++ b/Documentation/RCU/torture.txt
> @@ -56,8 +56,9 @@ test_no_idle_hz	Whether or not to test t
>  torture_type	The type of RCU to test: "rcu" for the rcu_read_lock() API,
>  		"rcu_sync" for rcu_read_lock() with synchronous reclamation,
>  		"rcu_bh" for the rcu_read_lock_bh() API, "rcu_bh_sync" for
> -		rcu_read_lock_bh() with synchronous reclamation, and "srcu"
> -		for the "srcu_read_lock()" API.
> +		rcu_read_lock_bh() with synchronous reclamation, "srcu" for
> +		the "srcu_read_lock()" API, and "sched" for the use of
> +		preempt_disable() together with synchronize_sched().
>  
>  verbose		Enable debug printk()s.  Default is disabled.
>  
> diff --git a/kernel/rcutorture.c b/kernel/rcutorture.c
> index 0f0ff15..e2bda18 100644
> --- a/kernel/rcutorture.c
> +++ b/kernel/rcutorture.c
> @@ -464,9 +464,47 @@ static struct rcu_torture_ops srcu_ops =
>  	.name = "srcu"
>  };
>  
> +/*
> + * Definitions for sched torture testing.
> + */
> +
> +static int sched_torture_read_lock(void)
> +{
> +	preempt_disable();
> +	return 0;
> +}
> +
> +static void sched_torture_read_unlock(int idx)
> +{
> +	preempt_enable();
> +}
> +
> +static int sched_torture_completed(void)
> +{
> +	return 0;
> +}
> +
> +static void sched_torture_synchronize(void)
> +{
> +	synchronize_sched();
> +}
> +
> +static struct rcu_torture_ops sched_ops = {
> +	.init = rcu_sync_torture_init,
> +	.cleanup = NULL,
> +	.readlock = sched_torture_read_lock,
> +	.readdelay = rcu_read_delay,  /* just reuse rcu's version. */
> +	.readunlock = sched_torture_read_unlock,
> +	.completed = sched_torture_completed,
> +	.deferredfree = rcu_sync_torture_deferred_free,
> +	.sync = sched_torture_synchronize,
> +	.stats = NULL,
> +	.name = "sched"
> +};
> +
>  static struct rcu_torture_ops *torture_ops[] =
>  	{ &rcu_ops, &rcu_sync_ops, &rcu_bh_ops, &rcu_bh_sync_ops, &srcu_ops,
> -	  NULL };
> +	  &sched_ops, NULL };
>  
>  /*
>   * RCU torture writer kthread.  Repeatedly substitutes a new structure
> -- 
> 1.4.1.1
> 
> 
