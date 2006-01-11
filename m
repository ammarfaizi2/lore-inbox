Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751357AbWAKEdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbWAKEdn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 23:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbWAKEdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 23:33:43 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:4517 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751357AbWAKEdn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 23:33:43 -0500
Date: Tue, 10 Jan 2006 20:33:56 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, Dipankar Sarma <dipankar@in.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/3] rcu: don't set ->next_pending in rcu_start_batch()
Message-ID: <20060111043356.GL18252@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <43C3BAC2.C1F20B95@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C3BAC2.C1F20B95@tv-sign.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2006 at 04:46:42PM +0300, Oleg Nesterov wrote:
> I think it is better to set ->next_pending in the caller, when
> it is needed. This saves one parameter, and this coincides with
> cpu_quiet() beahaviour, which sets ->completed = ->cur itself.

Looks good to me, passes a one-hour torture test on x86.

						Thanx, Paul

Acked-by: Paul E. McKenney <paulmck@us.ibm.com>
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
> 
> --- 2.6.15/kernel/rcupdate.c~2_NPEND	2006-01-10 18:35:45.000000000 +0300
> +++ 2.6.15/kernel/rcupdate.c	2006-01-10 18:39:08.000000000 +0300
> @@ -249,12 +249,8 @@ static void rcu_do_batch(struct rcu_data
>   * active batch and the batch to be registered has not already occurred.
>   * Caller must hold rcu_state.lock.
>   */
> -static void rcu_start_batch(struct rcu_ctrlblk *rcp, struct rcu_state *rsp,
> -				int next_pending)
> +static void rcu_start_batch(struct rcu_ctrlblk *rcp, struct rcu_state *rsp)
>  {
> -	if (next_pending)
> -		rcp->next_pending = 1;
> -
>  	if (rcp->next_pending &&
>  			rcp->completed == rcp->cur) {
>  		rcp->next_pending = 0;
> @@ -288,7 +284,7 @@ static void cpu_quiet(int cpu, struct rc
>  	if (cpus_empty(rsp->cpumask)) {
>  		/* batch completed ! */
>  		rcp->completed = rcp->cur;
> -		rcu_start_batch(rcp, rsp, 0);
> +		rcu_start_batch(rcp, rsp);
>  	}
>  }
>  
> @@ -423,7 +419,8 @@ static void __rcu_process_callbacks(stru
>  		if (!rcp->next_pending) {
>  			/* and start it/schedule start if it's a new batch */
>  			spin_lock(&rsp->lock);
> -			rcu_start_batch(rcp, rsp, 1);
> +			rcp->next_pending = 1;
> +			rcu_start_batch(rcp, rsp);
>  			spin_unlock(&rsp->lock);
>  		}
>  	} else {
> 
