Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbUBWI7I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 03:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261883AbUBWI7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 03:59:08 -0500
Received: from fw.osdl.org ([65.172.181.6]:55734 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261885AbUBWI7E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 03:59:04 -0500
Date: Mon, 23 Feb 2004 00:59:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vm-fix-all_zones_ok (was Re: 2.6.3-mm3)
Message-Id: <20040223005948.10a3b325.akpm@osdl.org>
In-Reply-To: <4039BE41.1000804@cyberone.com.au>
References: <20040222172200.1d6bdfae.akpm@osdl.org>
	<40395ACE.4030203@cyberone.com.au>
	<20040222175507.558a5b3d.akpm@osdl.org>
	<40396ACD.7090109@cyberone.com.au>
	<40396DA7.70200@cyberone.com.au>
	<4039B4E6.3050801@cyberone.com.au>
	<4039BE41.1000804@cyberone.com.au>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <piggin@cyberone.com.au> wrote:
>
> 
> 
> Nick Piggin wrote:
> 
> >
> > Humph. OK you're right.
> 
> 
> Aha but you've broken something!

I'm a microsoft spy.

> Tell me I'm still useful.

You're still useful.

> diff -puN mm/vmscan.c~vm-fix-all_zones_ok mm/vmscan.c
> --- linux-2.6/mm/vmscan.c~vm-fix-all_zones_ok	2004-02-23 19:44:06.000000000 +1100
> +++ linux-2.6-npiggin/mm/vmscan.c	2004-02-23 19:45:10.000000000 +1100
> @@ -1008,10 +1008,12 @@ static int balance_pgdat(pg_data_t *pgda
>  
>  			if (nr_pages)		/* Software suspend */
>  				to_reclaim = min(to_free, SWAP_CLUSTER_MAX*8);
> -			else			/* Zone balancing */
> +			else {			/* Zone balancing */
>  				to_reclaim = zone->reclaim_batch;
> +				if (zone->pages_high < zone->free_pages)
> +					all_zones_ok = 0;
> +			}

I wouldna spotted that in a million years.  That all_zones_ok code was a
bitch to test and really needs retesting.

We used to have <= in there actually:

		to_reclaim = zone->pages_high-zone->free_pages;
		if (to_reclaim <= 0)
			continue;

We've never clearly defined whether pages_high == free_pages means the zone
is under limits.  According to __alloc_pages() it means that the zone is
not under limits, so you've fixed two bugs there.

