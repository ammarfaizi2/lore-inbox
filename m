Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932321AbVIYW1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbVIYW1P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 18:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbVIYW1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 18:27:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49347 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932321AbVIYW1O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 18:27:14 -0400
Date: Sun, 25 Sep 2005 15:26:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/21] mm: zap_pte_range dont dirty anon
Message-Id: <20050925152630.75560571.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0509251649100.3490@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0509251644100.3490@goblin.wat.veritas.com>
	<Pine.LNX.4.61.0509251649100.3490@goblin.wat.veritas.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> zap_pte_range already avoids wasting time to mark_page_accessed on anon
> pages: it can also skip anon set_page_dirty - the page only needs to be
> marked dirty if shared with another mm, but that will say pte_dirty too.
> 

Are you sure about this?

> --- mm03/mm/memory.c	2005-09-24 19:26:38.000000000 +0100
> +++ mm04/mm/memory.c	2005-09-24 19:27:05.000000000 +0100
> @@ -574,12 +574,14 @@ static void zap_pte_range(struct mmu_gat
>  						addr) != page->index)
>  				set_pte_at(tlb->mm, addr, pte,
>  					   pgoff_to_pte(page->index));
> -			if (pte_dirty(ptent))
> -				set_page_dirty(page);
>  			if (PageAnon(page))
>  				dec_mm_counter(tlb->mm, anon_rss);
> -			else if (pte_young(ptent))
> -				mark_page_accessed(page);
> +			else {
> +				if (pte_dirty(ptent))
> +					set_page_dirty(page);
> +				if (pte_young(ptent))
> +					mark_page_accessed(page);
> +			}
>  			tlb->freed++;
>  			page_remove_rmap(page);
>  			tlb_remove_page(tlb, page);

What is the page is (for example) clean swapcache, having been recently
faulted in.  If this pte indicates that this process has modified the page
and we don't run set_page_dirty(), the page could be reclaimed and the
change is lost.

Or what is the page was an anon page resulting from (say) a swapoff, and
it's shared by two mm's and one has modified it and we drop that dirty pte?

Or <other scenarios>.

Need more convincing.
