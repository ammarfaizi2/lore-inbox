Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755182AbWKRROn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755182AbWKRROn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 12:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755193AbWKRROn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 12:14:43 -0500
Received: from extu-mxob-2.symantec.com ([216.10.194.135]:21671 "EHLO
	extu-mxob-2.symantec.com") by vger.kernel.org with ESMTP
	id S1755182AbWKRROm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 12:14:42 -0500
X-AuditID: d80ac287-a0796bb000006994-c1-455f3f817730 
Date: Sat, 18 Nov 2006 13:37:53 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: David Rientjes <rientjes@cs.washington.edu>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, Nick Piggin <npiggin@suse.de>,
       Andre Noll <maan@systemlinux.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: do not call bad_page on PG_reserved check
In-Reply-To: <Pine.LNX.4.64N.0611172359200.6177@attu4.cs.washington.edu>
Message-ID: <Pine.LNX.4.64.0611181326380.6889@blonde.wat.veritas.com>
References: <Pine.LNX.4.64.0611152008450.3349@woody.osdl.org>
 <20061117204036.GK31879@stusta.de> <Pine.LNX.4.64N.0611172359200.6177@attu4.cs.washington.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 18 Nov 2006 17:14:41.0242 (UTC) FILETIME=[08D0C3A0:01C70B35]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Nov 2006, David Rientjes wrote:

> The return value of free_pages_check() indicates if PG_reserved was set.
> If so, the calling functions return immediately and no pages are freed so
> there is no need to call bad_page().
> 
> Cc: Andi Kleen <ak@suse.de>
> Cc: Nick Piggin <npiggin@suse.de>
> Signed-off-by: David Rientjes <rientjes@cs.washington.edu>

NAK.  You're missing the point.  If an attempt is made to free a
reserved page, it implies that the page reference counting has
gone wrong: we want to hear about that (so call bad_page),
and we dare not reuse the page (so skip freeing it).

What might be a good change, is to avoid freeing a page which meets
_any_ of the criteria for calling bad_page: I often wonder whether
to do that, alongside abandoning that hopeless page_mapcount BUG in
page_remove_rmap, which has almost(?) never helped lead us to any fix.

Hugh

> ---
>  mm/page_alloc.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index bf2f6cf..99bc29d 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -439,7 +439,6 @@ static inline int free_pages_check(struc
>  			1 << PG_slab	|
>  			1 << PG_swapcache |
>  			1 << PG_writeback |
> -			1 << PG_reserved |
>  			1 << PG_buddy ))))
>  		bad_page(page);
>  	if (PageDirty(page))
