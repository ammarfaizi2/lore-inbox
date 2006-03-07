Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964803AbWCGXYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbWCGXYr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 18:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964804AbWCGXYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 18:24:47 -0500
Received: from smtp.osdl.org ([65.172.181.4]:54751 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964803AbWCGXYq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 18:24:46 -0500
Date: Tue, 7 Mar 2006 15:26:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, ck@vds.kolivas.org
Subject: Re: [PATCH] mm: yield during swap prefetching
Message-Id: <20060307152636.1324a5b5.akpm@osdl.org>
In-Reply-To: <200603081013.44678.kernel@kolivas.org>
References: <200603081013.44678.kernel@kolivas.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
>
> Swap prefetching doesn't use very much cpu but spends a lot of time waiting on 
> disk in uninterruptible sleep. This means it won't get preempted often even at 
> a low nice level since it is seen as sleeping most of the time. We want to 
> minimise its cpu impact so yield where possible.
> 
> Signed-off-by: Con Kolivas <kernel@kolivas.org>
> ---
>  mm/swap_prefetch.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> Index: linux-2.6.15-ck5/mm/swap_prefetch.c
> ===================================================================
> --- linux-2.6.15-ck5.orig/mm/swap_prefetch.c	2006-03-02 14:00:46.000000000 +1100
> +++ linux-2.6.15-ck5/mm/swap_prefetch.c	2006-03-08 08:49:32.000000000 +1100
> @@ -421,6 +421,7 @@ static enum trickle_return trickle_swap(
>  
>  		if (trickle_swap_cache_async(swp_entry, node) == TRICKLE_DELAY)
>  			break;
> +		yield();
>  	}
>  
>  	if (sp_stat.prefetched_pages) {

yield() really sucks if there are a lot of runnable tasks.  And the amount
of CPU which that thread uses isn't likely to matter anyway.

I think it'd be better to just not do this.  Perhaps alter the thread's
static priority instead?  Does the scheduler have a knob which can be used
to disable a tasks's dynamic priority boost heuristic?
