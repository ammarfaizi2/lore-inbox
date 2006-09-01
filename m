Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964843AbWIAB3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbWIAB3W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 21:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964844AbWIAB3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 21:29:22 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:38031 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964843AbWIAB3T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 21:29:19 -0400
Date: Thu, 31 Aug 2006 18:30:00 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Josh Triplett <josht@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: [PATCH 3/4] rcu: Add rcu_bh_sync torture type to rcutorture
Message-ID: <20060901013000.GF4927@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <1157065016.25808.8.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157065016.25808.8.camel@josh-work.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2006 at 03:56:56PM -0700, Josh Triplett wrote:
> Use the newly-generic synchronous deferred free function to implement torture
> testing for rcu_bh using synchronize_rcu_bh rather than the asynchronous
> call_rcu_bh.

Acked-by: Paul E. McKenney <paulmck@us.ibm.com>

> Signed-off-by: Josh Triplett <josh@freedesktop.org>
> ---
>  Documentation/RCU/torture.txt |    5 +++--
>  kernel/rcutorture.c           |   16 +++++++++++++++-
>  2 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/RCU/torture.txt b/Documentation/RCU/torture.txt
> index 6714b53..cc4b1ef 100644
> --- a/Documentation/RCU/torture.txt
> +++ b/Documentation/RCU/torture.txt
> @@ -55,8 +55,9 @@ test_no_idle_hz	Whether or not to test t
>  
>  torture_type	The type of RCU to test: "rcu" for the rcu_read_lock() API,
>  		"rcu_sync" for rcu_read_lock() with synchronous reclamation,
> -		"rcu_bh" for the rcu_read_lock_bh() API, and "srcu" for the
> -		"srcu_read_lock()" API.
> +		"rcu_bh" for the rcu_read_lock_bh() API, "rcu_bh_sync" for
> +		rcu_read_lock_bh() with synchronous reclamation, and "srcu"
> +		for the "srcu_read_lock()" API.
>  
>  verbose		Enable debug printk()s.  Default is disabled.
>  
> diff --git a/kernel/rcutorture.c b/kernel/rcutorture.c
> index 1c329df..0f0ff15 100644
> --- a/kernel/rcutorture.c
> +++ b/kernel/rcutorture.c
> @@ -370,6 +370,19 @@ static struct rcu_torture_ops rcu_bh_ops
>  	.name = "rcu_bh"
>  };
>  
> +static struct rcu_torture_ops rcu_bh_sync_ops = {
> +	.init = rcu_sync_torture_init,
> +	.cleanup = NULL,
> +	.readlock = rcu_bh_torture_read_lock,
> +	.readdelay = rcu_read_delay,  /* just reuse rcu's version. */
> +	.readunlock = rcu_bh_torture_read_unlock,
> +	.completed = rcu_bh_torture_completed,
> +	.deferredfree = rcu_sync_torture_deferred_free,
> +	.sync = rcu_bh_torture_synchronize,
> +	.stats = NULL,
> +	.name = "rcu_bh_sync"
> +};
> +
>  /*
>   * Definitions for srcu torture testing.
>   */
> @@ -452,7 +465,8 @@ static struct rcu_torture_ops srcu_ops =
>  };
>  
>  static struct rcu_torture_ops *torture_ops[] =
> -	{ &rcu_ops, &rcu_sync_ops, &rcu_bh_ops, &srcu_ops, NULL };
> +	{ &rcu_ops, &rcu_sync_ops, &rcu_bh_ops, &rcu_bh_sync_ops, &srcu_ops,
> +	  NULL };
>  
>  /*
>   * RCU torture writer kthread.  Repeatedly substitutes a new structure
> -- 
> 1.4.1.1
> 
> 
