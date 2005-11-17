Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932475AbVKQUeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932475AbVKQUeA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 15:34:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932464AbVKQUeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 15:34:00 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:40513 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S964828AbVKQUeA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 15:34:00 -0500
Date: Thu, 17 Nov 2005 21:35:02 +0100
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, rohit.seth@intel.com,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.15-rc1-git crashes in kswapd
Message-ID: <20051117203502.GS7787@suse.de>
References: <20051117154754.GP7787@suse.de> <20051117160624.GR7787@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051117160624.GR7787@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17 2005, Jens Axboe wrote:
> This fixes it for me, does zonelist->zones change further down the path
> and we need the revalidation before after restarting?
> 
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 104e69c..77c663f 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -857,6 +857,7 @@ restart:
>  	if (page)
>  		goto got_pg;
>  
> +	z = zonelist->zones;  /* the list of zones suitable for gfp_mask */
>  	do
>  		wakeup_kswapd(*z, order);
>  	while (*(++z));

Ok, took a second look at this, the current code is definitely broken.
If we hit the oom killer, we goto restart with *z == NULL this time
since we already iterated through this loop once. Bad and 100%
reproducible for me, within 1 minute.

---

We must reassign z before looping through the zones kicking kswapd,
since it will be NULL if we hit an OOM condition and jump back to the
beginning again. 'z' is initially assigned before the restart: label. So
move the restart label up a little.

Signed-off-by: Jens Axboe <axboe@suse.de>

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 104e69c..bd4de59 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -845,21 +845,22 @@ __alloc_pages(gfp_t gfp_mask, unsigned i
 
 	might_sleep_if(wait);
 
+restart:
 	z = zonelist->zones;  /* the list of zones suitable for gfp_mask */
 
 	if (unlikely(*z == NULL)) {
 		/* Should this ever happen?? */
 		return NULL;
 	}
-restart:
+
 	page = get_page_from_freelist(gfp_mask|__GFP_HARDWALL, order,
 				zonelist, ALLOC_CPUSET);
 	if (page)
 		goto got_pg;
 
-	do
+	do {
 		wakeup_kswapd(*z, order);
-	while (*(++z));
+	} while (*(++z));
 
 	/*
 	 * OK, we're below the kswapd watermark and have kicked background

-- 
Jens Axboe

