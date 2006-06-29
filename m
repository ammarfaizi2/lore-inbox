Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932911AbWF2Vti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932911AbWF2Vti (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 17:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932928AbWF2Vt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 17:49:28 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:2224 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932853AbWF2VtL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:49:11 -0400
Date: Thu, 29 Jun 2006 14:49:48 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Josh Triplett <josht@vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, Dipkanar Sarma <dipankar@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] rcu: Add lock annotations to RCU locking primitives
Message-ID: <20060629214948.GJ1294@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <1151617163.6507.15.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1151617163.6507.15.camel@josh-work.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2006 at 02:39:23PM -0700, Josh Triplett wrote:
> Add __acquire annotations to rcu_read_lock and rcu_read_lock_bh, and add
> __release annotations to rcu_read_unlock and rcu_read_unlock_bh.  This allows
> sparse to detect improperly paired calls to these functions.

I will take whatever automated help I can get!!!

Acked-by: Paul E. McKenney <paulmck@us.ibm.com>
> Signed-off-by: Josh Triplett <josh@freedesktop.org>
> 
> ---
> 
>  include/linux/rcupdate.h |   24 ++++++++++++++++++++----
>  1 files changed, 20 insertions(+), 4 deletions(-)
> 
> 0a6ff66d5cf24cf6106c933e1f183687358ebc7e
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 48dfe00..b4ca73d 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -163,14 +163,22 @@ extern int rcu_needs_cpu(int cpu);
>   *
>   * It is illegal to block while in an RCU read-side critical section.
>   */
> -#define rcu_read_lock()		preempt_disable()
> +#define rcu_read_lock() \
> +	do { \
> +		preempt_disable(); \
> +		__acquire(RCU); \
> +	} while(0)
>  
>  /**
>   * rcu_read_unlock - marks the end of an RCU read-side critical section.
>   *
>   * See rcu_read_lock() for more information.
>   */
> -#define rcu_read_unlock()	preempt_enable()
> +#define rcu_read_unlock() \
> +	do { \
> +		__release(RCU); \
> +		preempt_enable(); \
> +	} while(0)
>  
>  /*
>   * So where is rcu_write_lock()?  It does not exist, as there is no
> @@ -193,14 +201,22 @@ #define rcu_read_unlock()	preempt_enable
>   * can use just rcu_read_lock().
>   *
>   */
> -#define rcu_read_lock_bh()	local_bh_disable()
> +#define rcu_read_lock_bh() \
> +	do { \
> +		local_bh_disable(); \
> +		__acquire(RCU_BH); \
> +	} while(0)
>  
>  /*
>   * rcu_read_unlock_bh - marks the end of a softirq-only RCU critical section
>   *
>   * See rcu_read_lock_bh() for more information.
>   */
> -#define rcu_read_unlock_bh()	local_bh_enable()
> +#define rcu_read_unlock_bh() \
> +	do { \
> +		__release(RCU_BH); \
> +		local_bh_enable(); \
> +	} while(0)
>  
>  /**
>   * rcu_dereference - fetch an RCU-protected pointer in an
> 
> 
