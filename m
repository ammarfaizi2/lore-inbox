Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750805AbWERHSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbWERHSg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 03:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbWERHSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 03:18:36 -0400
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:6530 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750805AbWERHSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 03:18:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=SJndt5yRe0ZriaZWTRQBj4RELuHlXJ922byyT/mJLY5xK91vUh7us6AVpo8T2nCtuCndjJuJxKu0xW8vZ4ou0pWSOy2jwOt+5xjPXZrVhXhYkZXKf4+tQcrAroKvArFPL4MLbw9ri1ovo34qZMFumNDGqQO9+BqpTBoMU4z0hNk=  ;
Message-ID: <446C1FC7.1020405@yahoo.com.au>
Date: Thu, 18 May 2006 17:18:31 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck list <ck@vds.kolivas.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] mm: swap prefetch fix lowmem reserve calc
References: <200605181558.57777.kernel@kolivas.org>
In-Reply-To: <200605181558.57777.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> When examining the free limits in swap_prefetch we should ensure the largest
> lowmem_reserve for each zone is free.
> 
> Signed-off-by: Con Kolivas <kernel@kolivas.org>
> 
> ---
>  mm/swap_prefetch.c |   14 +++++++++++++-
>  1 files changed, 13 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6.17-rc4-mm1/mm/swap_prefetch.c
> ===================================================================
> --- linux-2.6.17-rc4-mm1.orig/mm/swap_prefetch.c	2006-05-18 15:48:22.000000000 +1000
> +++ linux-2.6.17-rc4-mm1/mm/swap_prefetch.c	2006-05-18 15:52:42.000000000 +1000
> @@ -258,6 +258,18 @@ static void clear_current_prefetch_free(
>  	}
>  }
>  
> +static inline unsigned long largest_lowmem_reserve(struct zone *z)
> +{
> +	unsigned long ret = 0;
> +	unsigned int idx = zone_idx(z);
> +
> +	while (!is_highmem_idx(idx)) {
> +		idx++;
> +		ret = max(ret, z->lowmem_reserve[idx]);
> +	}
> +	return ret;
> +}
> +
>  /*
>   * This updates the high and low watermarks of amount of free ram in each
>   * node used to start and stop prefetching. We prefetch from pages_high * 4
> @@ -276,7 +288,7 @@ static void examine_free_limits(void)
>  
>  		ns = &sp_stat.node[z->zone_pgdat->node_id];
>  		idx = zone_idx(z);
> -		ns->lowfree[idx] = z->pages_high * 3 + z->lowmem_reserve[idx];
> +		ns->lowfree[idx] = z->pages_high * 3 + largest_lowmem_reserve(z);
>  		ns->highfree[idx] = ns->lowfree[idx] + z->pages_high;

Anonymous memory is GFP_HIGHUSER, yeah? Anything wrong with

-		ns->lowfree[idx] = z->pages_high * 3 + z->lowmem_reserve[idx];
+		ns->lowfree[idx] = z->pages_high * 3 + z->lowmem_reserve[ZONE_HIGHMEM];


-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
