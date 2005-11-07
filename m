Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030194AbVKGXpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030194AbVKGXpL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 18:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965608AbVKGXpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 18:45:11 -0500
Received: from hera.kernel.org ([140.211.167.34]:17067 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S965606AbVKGXpK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 18:45:10 -0500
Date: Mon, 7 Nov 2005 16:43:06 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] vm: kswapd incmin
Message-ID: <20051107184306.GA18493@logos.cnet>
References: <4366FA9A.20402@yahoo.com.au> <4366FAF5.8020908@yahoo.com.au> <20051107152816.GA17246@logos.cnet> <436FDE85.9090205@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <436FDE85.9090205@yahoo.com.au>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2005 at 10:08:53AM +1100, Nick Piggin wrote:
> Marcelo Tosatti wrote:
> >Hi Nick,
> >
> >Looks nice, much easier to read than before.
> >
> 
> Hi Marcelo,
> 
> Thanks! That was one of the main aims.
> 
> >One comment: you change the pagecache/slab scanning ratio by moving
> >shrink_slab() outside of the zone loop. 
> >
> >This means that for each kswapd iteration will scan "lru_pages" 
> >SLAB entries, instead of "lru_pages*NR_ZONES" entries.
> >
> >Can you comment on that?
> >
> 
> I believe I have tried to get it right, let me explain. lru_pages
> is just used as the divisor for the ratio between lru scanning
> and slab scanning. So long as it is kept constant across calls to
> shrink_slab, there should be no change in behaviour.
> 
> The the nr_scanned variable is the other half of the equation that
> controls slab shrinking. I have changed from:
> 
>   lru_pages = total_node_lru_pages;
>   for each zone in node {
>      shrink_zone();
>      shrink_slab(zone_scanned, lru_pages);
>   }
> 
> To:
> 
>   lru_pages = 0;
>   for each zone in node {
>      shrink_zone();
>      lru_pages += zone_lru_pages;
>   }
>   shrink_slab(total_zone_scanned, lru_pages);
> 
> So the ratio remains basically the same
> [eg. 10/100 + 20/100 + 30/100 = (10+20+30)/100]
> 
> 2 reasons for doing this. The first is just efficiency and better
> rounding of the divisions.
> 
> The second is that within the for_each_zone loop, we are able to
> set all_unreclaimable without worrying about slab, because the
> final shrink_slab at the end will clear all_unreclaimable if any
> zones have had slab pages freed up.
> 
> I believe it generally should result in more consistent reclaim
> across zones, and also matches direct reclaim better.
> 
> Hope this made sense,

Yes, makes sense. My reading was not correct.

Sounds great.
