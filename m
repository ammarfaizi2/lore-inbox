Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964882AbVKQWyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964882AbVKQWyt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 17:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964883AbVKQWys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 17:54:48 -0500
Received: from fmr24.intel.com ([143.183.121.16]:10208 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S964882AbVKQWyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 17:54:47 -0500
Subject: Re: 2.6.15-rc1-git crashes in kswapd
From: Rohit Seth <rohit.seth@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20051117130215.33889990.akpm@osdl.org>
References: <20051117154754.GP7787@suse.de> <20051117160624.GR7787@suse.de>
	 <20051117130215.33889990.akpm@osdl.org>
Content-Type: text/plain
Organization: Intel 
Date: Thu, 17 Nov 2005 15:00:52 -0800
Message-Id: <1132268452.14243.4.camel@akash.sc.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Nov 2005 22:53:57.0635 (UTC) FILETIME=[CAFB5530:01C5EBC9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-11-17 at 13:02 -0800, Andrew Morton wrote:
> Jens Axboe <axboe@suse.de> wrote:
> >
> > does zonelist->zones change further down the path
> > and we need the revalidation before after restarting?
> > 
> 
> err, yeah.   Like this, I think?
> 
> 

Good catch Jens.  The zone variables (and their initialization) got
slightly changed because we moved the zone_statistics part from
_alloc_pages to get_page_from_freelist function.

Andrew's patch below is the right fix.

-rohit
> 
> We modify local variable `z' while walking across the zones.  So we need to
> restore it if we do the `goto restart' thing in the rare case where the
> oom-killer was called.
> 
> 
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  mm/page_alloc.c |    9 ++++-----
>  1 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff -puN mm/page_alloc.c~alloc_pages-oops-fix mm/page_alloc.c
> --- 25/mm/page_alloc.c~alloc_pages-oops-fix	Thu Nov 17 12:58:38 2005
> +++ 25-akpm/mm/page_alloc.c	Thu Nov 17 12:59:19 2005
> @@ -845,13 +845,12 @@ __alloc_pages(gfp_t gfp_mask, unsigned i
>  
>  	might_sleep_if(wait);
>  
> -	z = zonelist->zones;  /* the list of zones suitable for gfp_mask */
> +restart:
> +	z = zonelist->zones;	  /* the list of zones suitable for gfp_mask */
>  
> -	if (unlikely(*z == NULL)) {
> -		/* Should this ever happen?? */
> +	if (unlikely(*z == NULL)) /* Should this ever happen?? */
>  		return NULL;
> -	}
> -restart:
> +
>  	page = get_page_from_freelist(gfp_mask|__GFP_HARDWALL, order,
>  				zonelist, ALLOC_CPUSET);
>  	if (page)
> _
> 

