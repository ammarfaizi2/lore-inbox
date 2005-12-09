Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932480AbVLIWf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932480AbVLIWf2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 17:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932482AbVLIWf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 17:35:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:21921 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932480AbVLIWf1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 17:35:27 -0500
Date: Fri, 9 Dec 2005 14:36:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: david@gibson.dropbear.id.au, axboe@suse.de, mst@mellanox.co.il,
       wli@holomorphy.com, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] PageCompound avoid page[1].mapping
Message-Id: <20051209143629.6b65c008.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0512092151240.28965@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0512092151240.28965@goblin.wat.veritas.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> If a compound page has its own put_page_testzero destructor (the only
> current example is free_huge_page), that is noted in page[1].mapping of
> the compound page.  But David Gibson's recent fix to access_process_vm
> shows that to be rather a poor place to keep it: functions which call
> set_page_dirty(_lock) after get_user_pages ought to check !PageCompound
> first, otherwise set_page_dirty may crash on what's not the address of
> a struct address_space; but Infiniband for one is unaware of this issue.
> 
> Even if we fixed all callers, or set_page_dirty(_lock) itself, it would
> still be unsatisfactory: e.g. get_user_pages calls flush_dcache_page,
> which involves page->mapping on some architectures - not a problem while
> hugetlb goes its own way in get_user_pages, but needs a test if another
> compound page destructor were added.  page->mapping is used too widely
> to be a safe field to reuse in this way.
> 
> The safest field to reuse, given how PageCompound redirects callers to
> the page count of the first page, is actually the _count field of the
> second page: save order (only used for debug) there, and move destructor
> address from mapping to index.  Add __page_count inline for internal
> debug use - to avoid reliance on page_private when page is in doubt.
> 
> Revert David's mod to access_process_vm, no longer required.  But leave
> the PageCompound tests in fs/bio.c and fs/direct-io.c: perhaps those are
> worthwhile optimizations when working on hugetlb areas.
> 
> ...
> -	page[1].mapping = (void *)free_huge_page;
> +	page[1].index = (unsigned long)free_huge_page;	/* set dtor */

This is a little awkward, IMO.  page.index is actually pgoff_t, not
unsigned long.  Conceivably someday someone may want to make pgoff_t 64-bit
on 32-bit machines, for example.  Yes, that'll still work, but it's still
awkward.

Is it not possible to put the dtor address into some address-type field
within the pageframe rather than into an integer-type?

Or just leave it using page.mapping?  Anyone who uses page.mapping of a
tail page in a compound page should go oops.

> +/*
> + * Ignore PageCompound when checking page_count for debugging -
> + * page_private might be corrupt; but never expose this to wider use.
> + */
> +static inline int __page_count(struct page *page)
> +{
> +	return atomic_read(&page->_count) + 1;
> +}

hm, spose so.  Nick has a patch which unskews page.count which will need
updating for this.

<checks>

Looks like I didn't apply Nick's patch yet - mm/ in -mm has a nutty amount
of stuff in it now.

