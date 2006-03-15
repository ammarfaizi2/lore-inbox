Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750958AbWCOSws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbWCOSws (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 13:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbWCOSws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 13:52:48 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:1377 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750958AbWCOSws (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 13:52:48 -0500
Date: Wed, 15 Mar 2006 19:52:40 +0100
From: Jens Axboe <axboe@suse.de>
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: akpm@osdl.org, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] -mm: Small CFQ I/O sched optimization
Message-ID: <20060315185240.GV3595@suse.de>
References: <20060315172422.GA25435@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060315172422.GA25435@rhlx01.fht-esslingen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15 2006, Andreas Mohr wrote:
> Hello all,
> 
> this is a small optimization to cfq_choose_req() in the CFQ I/O scheduler
> (this function is a semi-often invoked candidate in an oprofile log):
> by using a bit mask variable, we can use a simple switch() to check
> the various cases instead of having to query two variables for each check.
> Benefit: 251 vs. 285 bytes footprint of cfq_choose_req().

Not much saved, but every byte is worth while and the code is cleaner.

> Also, common case 0 (no request wrapping) is now checked first in code.
> During some heavy testing on a single-HDD UP P3/700 my instrumentation showed
> that case 0 was the *only* thing occurring, no request wrapping ever inside
> this function.
> Is that expected behaviour??

Hmm that does sound a little strange - care to do the same
instrumentation for 'as' to see if this is just a 'cfq' anomaly?

> --- linux-2.6.16-rc6-mm1/block/cfq-iosched.c.orig	2006-03-15 18:09:08.000000000 +0100
> +++ linux-2.6.16-rc6-mm1/block/cfq-iosched.c	2006-03-15 18:09:43.000000000 +0100
> @@ -96,6 +96,9 @@
>  #define ASYNC			(0)
>  #define SYNC			(1)
>  
> +#define CFQ_RQ1_WRAP	0x01 /* request 1 wraps */
> +#define CFQ_RQ2_WRAP	0x02 /* request 2 wraps */

Please put these near where they are used, it's a little confusing to
have to go look for them. They only make sense in cfq_choose_req().

> +
>  #define cfq_cfqq_dispatched(cfqq)	\
>  	((cfqq)->on_dispatch[ASYNC] + (cfqq)->on_dispatch[SYNC])
>  
> @@ -361,15 +364,15 @@
>  
>  /*
>   * Lifted from AS - choose which of crq1 and crq2 that is best served now.
> - * We choose the request that is closest to the head right now. Distance
> + * We choose the request that is closest to the head right now. Distances
>   * behind the head are penalized and only allowed to a certain extent.

I sort-of prefer 'distance' here, you may want to change that to an 'is'
though :-)

>   */
>  static struct cfq_rq *
>  cfq_choose_req(struct cfq_data *cfqd, struct cfq_rq *crq1, struct cfq_rq *crq2)
>  {
>  	sector_t last, s1, s2, d1 = 0, d2 = 0;
> -	int r1_wrap = 0, r2_wrap = 0;	/* requests are behind the disk head */
>  	unsigned long back_max;
> +	unsigned wrap = 0; /* bit mask: requests behind the disk head? */
>  
>  	if (crq1 == NULL || crq1 == crq2)
>  		return crq2;
> @@ -401,38 +404,42 @@
>  	else if (s1 + back_max >= last)
>  		d1 = (last - s1) * cfqd->cfq_back_penalty;
>  	else
> -		r1_wrap = 1;
> +		wrap |= CFQ_RQ1_WRAP;
>  
>  	if (s2 >= last)
>  		d2 = s2 - last;
>  	else if (s2 + back_max >= last)
>  		d2 = (last - s2) * cfqd->cfq_back_penalty;
>  	else
> -		r2_wrap = 1;
> +		wrap |= CFQ_RQ2_WRAP;
>  
>  	/* Found required data */
> -	if (!r1_wrap && r2_wrap)
> -		return crq1;
> -	else if (!r2_wrap && r1_wrap)
> -		return crq2;
> -	else if (r1_wrap && r2_wrap) {
> -		/* both behind the head */
> -		if (s1 <= s2)
> -			return crq1;
> -		else
> -			return crq2;
> -	}
>  
> -	/* Both requests in front of the head */
> -	if (d1 < d2)
> -		return crq1;
> -	else if (d2 < d1)
> -		return crq2;
> -	else {
> -		if (s1 >= s2)
> +	/* by doing switch() on the bit mask "wrap" we avoid having to
> +	 * check two variables for all permutations: --> faster! */

Multiple line comments have /* and */ on a separate line.

> +	switch (wrap) {
> +		case 0: /* common case: crq1 and crq2 not wrapped */
> +			if (d1 < d2)
> +				return crq1;
> +			else if (d2 < d1)
> +				return crq2;
> +			else {
> +				if (s1 >= s2)
> +					return crq1;
> +				else
> +					return crq2;
> +			}
> +
> +		case CFQ_RQ2_WRAP:
>  			return crq1;
> -		else
> +		case CFQ_RQ1_WRAP:
>  			return crq2;
> +		case (CFQ_RQ1_WRAP|CFQ_RQ2_WRAP): /* both crqs wrapped */
> +		default:
> +			if (s1 <= s2)
> +				return crq1;
> +			else
> +				return crq2;
>  	}
>  }

Andrew will ask you to move that 'case' to be lined up with the
'switch'.

-- 
Jens Axboe

