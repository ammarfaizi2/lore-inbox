Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751332AbWIAB3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbWIAB3K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 21:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbWIAB3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 21:29:10 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:65487 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751316AbWIAB3I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 21:29:08 -0400
Date: Thu, 31 Aug 2006 18:29:48 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Josh Triplett <josht@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: [PATCH 2/4] rcu: Add rcu_sync torture type to rcutorture
Message-ID: <20060901012948.GE4927@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <1157065014.25808.7.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157065014.25808.7.camel@josh-work.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2006 at 03:56:54PM -0700, Josh Triplett wrote:
> Use the newly-generic synchronous deferred free function to implement torture
> testing for RCU using synchronize_rcu rather than the asynchronous call_rcu.

Acked-by: Paul E. McKenney <paulmck@us.ibm.com>

> Signed-off-by: Josh Triplett <josh@freedesktop.org>
> ---
>  Documentation/RCU/torture.txt |    7 ++++---
>  kernel/rcutorture.c           |   17 +++++++++++++++--
>  2 files changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/RCU/torture.txt b/Documentation/RCU/torture.txt
> index 2180ef9..6714b53 100644
> --- a/Documentation/RCU/torture.txt
> +++ b/Documentation/RCU/torture.txt
> @@ -53,9 +53,10 @@ test_no_idle_hz	Whether or not to test t
>  		a kernel that disables the scheduling-clock interrupt to
>  		idle CPUs.  Boolean parameter, "1" to test, "0" otherwise.
>  
> -torture_type	The type of RCU to test: "rcu" for the rcu_read_lock()
> -		API, "rcu_bh" for the rcu_read_lock_bh() API, and "srcu"
> -		for the "srcu_read_lock()" API.
> +torture_type	The type of RCU to test: "rcu" for the rcu_read_lock() API,
> +		"rcu_sync" for rcu_read_lock() with synchronous reclamation,
> +		"rcu_bh" for the rcu_read_lock_bh() API, and "srcu" for the
> +		"srcu_read_lock()" API.
>  
>  verbose		Enable debug printk()s.  Default is disabled.
>  
> diff --git a/kernel/rcutorture.c b/kernel/rcutorture.c
> index 6e2f0a8..1c329df 100644
> --- a/kernel/rcutorture.c
> +++ b/kernel/rcutorture.c
> @@ -58,7 +58,7 @@ static int stat_interval;	/* Interval be
>  static int verbose;		/* Print more debug info. */
>  static int test_no_idle_hz;	/* Test RCU's support for tickless idle CPUs. */
>  static int shuffle_interval = 5; /* Interval between shuffles (in sec)*/
> -static char *torture_type = "rcu"; /* What to torture: rcu, rcu_bh, srcu. */
> +static char *torture_type = "rcu"; /* What RCU implementation to torture. */
>  
>  module_param(nreaders, int, 0);
>  MODULE_PARM_DESC(nreaders, "Number of RCU reader threads");
> @@ -297,6 +297,19 @@ static void rcu_sync_torture_init(void)
>  	INIT_LIST_HEAD(&rcu_torture_removed);
>  }
>  
> +static struct rcu_torture_ops rcu_sync_ops = {
> +	.init = rcu_sync_torture_init,
> +	.cleanup = NULL,
> +	.readlock = rcu_torture_read_lock,
> +	.readdelay = rcu_read_delay,
> +	.readunlock = rcu_torture_read_unlock,
> +	.completed = rcu_torture_completed,
> +	.deferredfree = rcu_sync_torture_deferred_free,
> +	.sync = synchronize_rcu,
> +	.stats = NULL,
> +	.name = "rcu_sync"
> +};
> +
>  /*
>   * Definitions for rcu_bh torture testing.
>   */
> @@ -439,7 +452,7 @@ static struct rcu_torture_ops srcu_ops =
>  };
>  
>  static struct rcu_torture_ops *torture_ops[] =
> -	{ &rcu_ops, &rcu_bh_ops, &srcu_ops, NULL };
> +	{ &rcu_ops, &rcu_sync_ops, &rcu_bh_ops, &srcu_ops, NULL };
>  
>  /*
>   * RCU torture writer kthread.  Repeatedly substitutes a new structure
> -- 
> 1.4.1.1
> 
> 
