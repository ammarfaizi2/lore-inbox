Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263487AbUDBBGz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 20:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263493AbUDBBGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 20:06:55 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:61586
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263487AbUDBBGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 20:06:46 -0500
Date: Fri, 2 Apr 2004 03:06:45 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: hugh@veritas.com, vrajesh@umich.edu, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity fix
Message-ID: <20040402010645.GI18585@dualathlon.random>
References: <20040401020126.GW2143@dualathlon.random> <Pine.LNX.4.44.0404010549540.28566-100000@localhost.localdomain> <20040401133555.GC18585@dualathlon.random> <20040401150911.GI18585@dualathlon.random> <20040401151534.GJ18585@dualathlon.random> <20040402001535.GG18585@dualathlon.random> <20040401165216.40b9be98.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040401165216.40b9be98.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2004 at 04:52:16PM -0800, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > > @@ -149,8 +149,14 @@ int rw_swap_page_sync(int rw, swp_entry_
> > >  	};
> > >  
> > >  	lock_page(page);
> > > -
> > > +	/*
> > > +	 * This library call can be only used to do I/O
> > > +	 * on _private_ pages just allocated with alloc_pages().
> > > +	 */
> > >  	BUG_ON(page->mapping);
> > > +	BUG_ON(PageSwapCache(page));
> > > +	BUG_ON(PageAnon(page));
> > > +	BUG_ON(PageLRU(page));
> > >  	ret = add_to_page_cache(page, &swapper_space, entry.val, GFP_KERNEL);
> > >  	if (unlikely(ret)) {
> > >  		unlock_page(page);
> > 
> > 
> > the good thing is that I believe this fix will make it work with the -mm
> > writeback changes. However this fix now collides with anon-vma since
> > swapsuspend passes compound pages to rw_swap_page_sync and
> > add_to_page_cache overwrites page->private and the kernel crashes at the
> > next page_cache_get() since page->private is now the swap entry and not
> > a page_t pointer.
> 
> Why do swapcache pages have their ->index in ->private?  That should have
> been commented.

that's because I must leave page->index free for the anon-vma tracking.
Now an anonymous page while being swapped is just like a pagecache page,
however the index on swap is different than the index in-address-space,
because the swap is nonlinear. So I need to indexes, one for finding the
page in the anon-vma in the task address space (page->index), the other
(the swap-entry) for finding the page in the swap address-space
(swapcache, or disk).

> (hugetlb pages are also added to pagecache, and they are compound, but the
> code looks OK).

hugetlb is never swapped so yes, it cannot generate problems. The only
thing swapping a compound page is swap suspend and that's why we didn't
notice it yet.

> > So I guess I've a good reason now to giveup trying to
> > add the page to the swapcache, and to just fake the radix tree like I
> > did in my original fix. That way the page won't be swapcache either so I
> > don't even need to use get_page to avoid remove_exclusive_swap_page to
> > mess with it.
> 
> The BUG_ON in radix_tree_tag_set() is a fairly arbitrary sanity check:
> "hey, why are you tagging a non-existent item?".
> 
> We could simply replace it with a `return NULL;'?

I wouldn't like to reduce the hardness checks in the radix tree, I was
very happy to find this robusteness checks trapping those bugs so
reliably.

But I think the compound thing is overkill for 99% of usages, hugetlbfs
is the only one really needing that sort of transparency in the
refcounting I believe, so I'm now adding a __GFP_NO_COMP that
swapsuspend will start to use to allocate the multipages, I'd better add
it before somebody gets the idea of removing the order parameter to
free_pages (something you could do just fine with page compound since
the order is in page[1].index ;). This should fix it, I don't want to
teach rw_swap_page_sync how to swapout a compound page, I'd rather make
a compound page look like a regular page as far as rw_swap_page_sync is
concerned. This will not slowdown the kernel at all since the additional
check if to create a compound page or not will only trigger if the
previous check of order > 0 is positive.
