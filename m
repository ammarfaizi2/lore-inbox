Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161451AbWI2TXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161451AbWI2TXk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 15:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161534AbWI2TXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 15:23:40 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:50996 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S1161451AbWI2TXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 15:23:39 -0400
Subject: Re: [RFC][PATCH 2/2] Swap token re-tuned
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: ashwin.chaugule@celunite.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1159556740.2141.24.camel@localhost.localdomain>
References: <1159556740.2141.24.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 29 Sep 2006 21:23:31 +0200
Message-Id: <1159557812.13651.23.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-09-30 at 00:35 +0530, Ashwin Chaugule wrote:
> New scheme to preempt token. 
> 
> 
> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@celunite.com>
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 34ed0d9..417bbe4 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -342,9 +342,15 @@ struct mm_struct {
>  	/* Architecture-specific MM context */
>  	mm_context_t context;
>  
> -	/* Token based thrashing protection. */
> -	unsigned long swap_token_time;
> -	char recent_pagein;
> +	/* Swap token stuff */
> +	/* Last value of global fault stamp as seen by this process. 
> +	 * In other words, this value gives an indication of how long
> +	 * it has been since this task got the token */
> +	unsigned int faultstamp;
> +
> +       /* Deciding factor ! Increment if (global_faults - faultstamp < 5) 
> +        * else decrement. High priority wins the token.*/
> +	int token_priority;

/*
 * multi line comments look like this
 */

> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -910,6 +910,7 @@ #ifdef HAVE_ARCH_PICK_MMAP_LAYOUT
>  		.extra1		= &zero,
>  	},
>  #endif
> +#if 0	/* Not needed anymore */
>  #ifdef CONFIG_SWAP
>  	{
>  		.ctl_name	= VM_SWAP_TOKEN_TIMEOUT,
> @@ -921,6 +922,7 @@ #ifdef CONFIG_SWAP
>  		.strategy	= &sysctl_jiffies,
>  	},
>  #endif
> +#endif

Just remove it.

>  static int should_release_swap_token(struct mm_struct *mm)
>  {
>  	int ret = 0;
> -	if (!mm->recent_pagein)
> -		ret = SWAP_TOKEN_ENOUGH_RSS;
> -	else if (time_after(jiffies, swap_token_timeout))
> -		ret = SWAP_TOKEN_TIMED_OUT;
> -	mm->recent_pagein = 0;
> -	return ret;
> +	if ( current->mm->token_priority > mm->token_priority )
> +		return ret = SWAP_TOKEN_PREEMPT;
> +	else
> +		return ret;
>  }

if (..)
  ret = SWAP_TOKEN_PREEMPT;

return ret;

> -/*
> - * Try to grab the swapout protection token.  We only try to
> - * grab it once every TOKEN_CHECK_INTERVAL, both to prevent
> - * SMP lock contention and to check that the process that held
> - * the token before is no longer thrashing.
> - */
>  void grab_swap_token(void)
>  {
> -	struct mm_struct *mm;
> +	struct mm_struct *mm_temp;
>  	int reason;
>  
> -	/* We have the token. Let others know we still need it. */
> -	if (has_swap_token(current->mm)) {
> -		current->mm->recent_pagein = 1;
> -		if (unlikely(!swap_token_default_timeout))
> -			disable_swap_token();
> +	/* This gives an indication of the number of processes contending for the token.*/

80 char max

> +	global_faults++; 
> +
> +	if (!spin_trylock(&swap_token_lock))
>  		return;
> -	}
>  
> -	if (time_after(jiffies, swap_token_check)) {
> +	/* First come first served. If a process holding the token exits, its up for grabs immediately */

ditto

> +	if ( swap_token_mm == NULL ) {
> +		swap_token_mm = current->mm;
> +		swap_token_mm->faultstamp = global_faults;
> +		goto out;
> +	}
>  
> -		if (!swap_token_default_timeout) {
> -			swap_token_check = jiffies + SWAP_TOKEN_CHECK_INTERVAL;
> -			return;
> -		}
> +	if ((global_faults - current->mm->faultstamp) < FAULTSTAMP_DIFF )  {
>  
> -		/* ... or if we recently held the token. */
> -		if (time_before(jiffies, current->mm->swap_token_time))
> -			return;
> +	/*  This would mean that too many of the current tasks pages
> +	 *  have been evicted and therefore it's calling swap-in or no-page 
> +	 *  too frequently. */

/*
 * multi line coment
 */

> -		if (!spin_trylock(&swap_token_lock))
> -			return;
> +		current->mm->faultstamp = global_faults;
> +		current->mm->token_priority++;
> +		mm_temp = swap_token_mm;
> +	}
> +	else {
> +	/* Decrement priority to ensure that the token holder doesnt
> +	 * hold on to it for too long. */

more comments

> -		swap_token_check = jiffies + SWAP_TOKEN_CHECK_INTERVAL;
> +		if (current->mm->token_priority > 0)
> +			current->mm->token_priority--;
> +		else {
> +	/* After this, the process will be able to contend for the token 
> +	 * again.*/

ditto


