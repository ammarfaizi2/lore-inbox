Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261469AbVFJXbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261469AbVFJXbO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 19:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbVFJX30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 19:29:26 -0400
Received: from smtp04.auna.com ([62.81.186.14]:12213 "EHLO smtp04.retemail.es")
	by vger.kernel.org with ESMTP id S261389AbVFJX1h convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 19:27:37 -0400
Date: Fri, 10 Jun 2005 23:14:20 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: 2.6.12-rc6-mm1
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Lameter <clameter@engr.sgi.com>,
       Nick Piggin <piggin@cyberone.com.au>
References: <20050607170853.3f81007a.akpm@osdl.org>
	<20050610070214.GA31323@elte.hu> <200506102203.15909.kernel@kolivas.org>
	<200506110019.13204.kernel@kolivas.org>
X-Mailer: Balsa 2.3.3
Message-Id: <1118445260l.7785l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Auth-Info: Auth:LOGIN IP:[83.138.215.85] Login:jamagallon@able.es Fecha:Sat, 11 Jun 2005 01:14:20 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 06.10, Con Kolivas wrote:

> The priority biasing was off by mutliplying the total load by the total 
> priority bias and this ruins the ratio of loads between runqueues. This
> patch should correct the ratios of loads between runqueues to be proportional
> to overall load.
> 

2.6.12-rc6-mm1 + this patch just oopses nicely on boot.
I did not had a digital camera handy, but the first oops that fit in the
screen was this call chain:

kernel_thread_helper
init
init
do:base_setup
usermodehelper_init
__create_workqueue
EIP in try_to_wake_up

After this, there was another with some do_div_error calls...

Something looks un-initialized the first time, or the integer arithmetic
is wrong. I really dont like a*(b/c), I really prefer (a*b)/c. It is more
common b/c == 0 (because b<c), than the possibility of overflowing (a*b).

So I tried both. With this, it boots again:

--- linux-2.6.11-jam24/kernel/sched.c.orig	2005-06-11 00:59:44.000000000 +0200
+++ linux-2.6.11-jam24/kernel/sched.c	2005-06-11 01:03:32.000000000 +0200
@@ -987,9 +987,10 @@
 		 * prevent idle rebalance from trying to pull tasks from a
 		 * queue with only one running task.
 		 */
-		unsigned long prio_bias = rq->prio_bias / rq->nr_running;
+		unsigned long prio_scale = (rq->nr_running > 0 ? 
+										rq->nr_running : 1);
 
-		source_load *= prio_bias;
+		source_load = (source_load*rq->prio_bias) / prio_scale;
 	}
 
 	return source_load;
@@ -1015,9 +1016,10 @@
 		target_load = max(cpu_load, load_now);
 
 	if (idle == NOT_IDLE || rq->nr_running > 1) {
-		unsigned long prio_bias = rq->prio_bias / rq->nr_running;
+		unsigned long prio_scale = (rq->nr_running > 0 ? 
+										rq->nr_running : 1);
 
-		target_load *= prio_bias;
+		target_load = (target_load*rq->prio_bias) / prio_scale;
 	}
 
 	return target_load;


Perhaps this:

	if (idle == NOT_IDLE || rq->nr_running > 1)

should be

	if (idle == NOT_IDLE && rq->nr_running > 1)

???

Hope this helps, thanks.

> Signed-off-by: Con Kolivas <kernel@kolivas.org>
> 
> Index: linux-2.6.12-rc6-mm1/kernel/sched.c
> ===================================================================
> --- linux-2.6.12-rc6-mm1.orig/kernel/sched.c	2005-06-10 23:56:56.000000000 +1000
> +++ linux-2.6.12-rc6-mm1/kernel/sched.c	2005-06-10 23:59:57.000000000 +1000
> @@ -978,7 +978,7 @@ static inline unsigned long __source_loa
>  	else
>  		source_load = min(cpu_load, load_now);
>  
> -	if (idle == NOT_IDLE || rq->nr_running > 1)
> +	if (idle == NOT_IDLE || rq->nr_running > 1) {
>  		/*
>  		 * If we are busy rebalancing the load is biased by
>  		 * priority to create 'nice' support across cpus. When
> @@ -987,7 +987,10 @@ static inline unsigned long __source_loa
>  		 * prevent idle rebalance from trying to pull tasks from a
>  		 * queue with only one running task.
>  		 */
> -		source_load *= rq->prio_bias;
> +		unsigned long prio_bias = rq->prio_bias / rq->nr_running;
> +
> +		source_load *= prio_bias;
> +	}
>  
>  	return source_load;
>  }
> @@ -1011,8 +1014,11 @@ static inline unsigned long __target_loa
>  	else
>  		target_load = max(cpu_load, load_now);
>  
> -	if (idle == NOT_IDLE || rq->nr_running > 1)
> -		target_load *= rq->prio_bias;
> +	if (idle == NOT_IDLE || rq->nr_running > 1) {
> +		unsigned long prio_bias = rq->prio_bias / rq->nr_running;
> +
> +		target_load *= prio_bias;
> +	}
>  
>  	return target_load;
>  }
> 

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandriva Linux release 2006.0 (Cooker) for i586
Linux 2.6.11-jam24 (gcc 4.0.0 (4.0.0-3mdk for Mandriva Linux release 2006.0))




