Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263794AbSLBPTz>; Mon, 2 Dec 2002 10:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262804AbSLBPTz>; Mon, 2 Dec 2002 10:19:55 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:44886 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id <S263794AbSLBPTx>; Mon, 2 Dec 2002 10:19:53 -0500
Date: Mon, 2 Dec 2002 15:28:30 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Javier Marcet <jmarcet@pobox.com>
cc: Rik van Riel <riel@conectiva.com.br>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rmap15a incremental diff against 2.4.20-ac1
In-Reply-To: <20021202032448.GA26608@jerry.marcet.dyndns.org>
Message-ID: <Pine.LNX.4.44.0212021514080.9845-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Dec 2002, Javier Marcet wrote:

> I had sent this patch a few hours ago but didn't see it on the list...
> Anyway, there was a mistake in the diff I sent so there you go a new
> version.
> I've merged the incremental diffs of rmap (rmap14c-rmap15 and
> rmap15-rmapa) with 2.4.20-ac1
> There was no inconsistency but in three spots.
> Namely:
> 
>     ...from the original rmap...
> diff -Nru a/mm/shmem.c b/mm/shmem.c
> --- a/mm/shmem.c	Mon Nov 18 10:28:28 2002
> +++ b/mm/shmem.c	Mon Nov 18 10:28:28 2002
> @@ -557,7 +557,7 @@
>  		unsigned long flags;
>  
>  		/* Look it up and read it in.. */
> -		page = find_get_page(&swapper_space, entry->val);
> +		page = find_pagecache_page(&swapper_space, entry->val);
>  		if (!page) {
>  			swp_entry_t swap = *entry;
>  			spin_unlock (&info->lock);
> 
>     ...to how I left it...
> diff -purN linux-2.4.20-ac1/mm/shmem.c linux-2.4.20-ac1-rmap15a/mm/shmem.c
> --- linux-2.4.20-ac1/mm/shmem.c	2002-12-01 11:01:04.000000000 +0100
> +++ linux-2.4.20-ac1-rmap15a/mm/shmem.c	2002-12-01 10:43:15.000000000 +0100
> @@ -593,7 +593,7 @@ repeat:
>  		unsigned long flags;
>  
>  		/* Look it up and read it in.. */
> -		page = lookup_swap_cache(*entry);
> +		page = find_pagecache_page(&swapper_space, entry->val);
>  		if (!page) {
>  			swp_entry_t swap = *entry;
>  			spin_unlock (&info->lock);
> 
> I didn't know which version to leave, rmap's or original ac's

It doesn't matter a great deal, but leaving it as lookup_swap_cache
would be correct - the difference lies solely in the swap cache "find"
statistics shown by AltSysRqM, which find_get_page shortcircuited
(whereas "add" and "delete" were getting updated for mm/shmem.c).

lookup_swap_cache is itself patched to say find_pagecache_page instead
of find_get_page - though why an -rmap patch should be changing that
well-established name escapes me: makes maintenance more tiresome.

Hugh

