Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbWHAPIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbWHAPIq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 11:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbWHAPIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 11:08:46 -0400
Received: from filfla-vlan276.msk.corbina.net ([213.234.233.49]:56492 "EHLO
	several.ru") by vger.kernel.org with ESMTP id S1750774AbWHAPIp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 11:08:45 -0400
Date: Tue, 1 Aug 2006 23:32:03 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Nick Piggin <npiggin@suse.de>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Andy Whitcroft <apw@shadowen.org>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 1/2] mm: speculative get_page
Message-ID: <20060801193203.GA191@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
>
> --- linux-2.6.orig/mm/vmscan.c
> +++ linux-2.6/mm/vmscan.c
> @@ -380,6 +380,8 @@ int remove_mapping(struct address_space 
>  	if (!mapping)
>  		return 0;		/* truncate got there first */
>
> +	SetPageNoNewRefs(page);
> +	smp_wmb();
>  	write_lock_irq(&mapping->tree_lock);
>

Is it enough?

PG_nonewrefs could be already set by another add_to_page_cache()/remove_mapping(),
and it will be cleared when we take ->tree_lock. For example:

CPU_0					CPU_1					CPU_3

add_to_page_cache:

    SetPageNoNewRefs();
    write_lock_irq(->tree_lock);
    ...
    write_unlock_irq(->tree_lock);

					remove_mapping:
	
					    SetPageNoNewRefs();

    ClearPageNoNewRefs();
					    write_lock_irq(->tree_lock);

					    check page_count()

										page_cache_get_speculative:

										    increment page_count()

										    no PG_nonewrefs => return

Oleg.

