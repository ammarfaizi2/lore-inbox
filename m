Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262986AbUDBAuN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 19:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263389AbUDBAuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 19:50:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:18140 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262986AbUDBAuH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 19:50:07 -0500
Date: Thu, 1 Apr 2004 16:52:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: hugh@veritas.com, vrajesh@umich.edu, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap
 complexity fix
Message-Id: <20040401165216.40b9be98.akpm@osdl.org>
In-Reply-To: <20040402001535.GG18585@dualathlon.random>
References: <20040401020126.GW2143@dualathlon.random>
	<Pine.LNX.4.44.0404010549540.28566-100000@localhost.localdomain>
	<20040401133555.GC18585@dualathlon.random>
	<20040401150911.GI18585@dualathlon.random>
	<20040401151534.GJ18585@dualathlon.random>
	<20040402001535.GG18585@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> > @@ -149,8 +149,14 @@ int rw_swap_page_sync(int rw, swp_entry_
> >  	};
> >  
> >  	lock_page(page);
> > -
> > +	/*
> > +	 * This library call can be only used to do I/O
> > +	 * on _private_ pages just allocated with alloc_pages().
> > +	 */
> >  	BUG_ON(page->mapping);
> > +	BUG_ON(PageSwapCache(page));
> > +	BUG_ON(PageAnon(page));
> > +	BUG_ON(PageLRU(page));
> >  	ret = add_to_page_cache(page, &swapper_space, entry.val, GFP_KERNEL);
> >  	if (unlikely(ret)) {
> >  		unlock_page(page);
> 
> 
> the good thing is that I believe this fix will make it work with the -mm
> writeback changes. However this fix now collides with anon-vma since
> swapsuspend passes compound pages to rw_swap_page_sync and
> add_to_page_cache overwrites page->private and the kernel crashes at the
> next page_cache_get() since page->private is now the swap entry and not
> a page_t pointer.

Why do swapcache pages have their ->index in ->private?  That should have
been commented.

(hugetlb pages are also added to pagecache, and they are compound, but the
code looks OK).

> So I guess I've a good reason now to giveup trying to
> add the page to the swapcache, and to just fake the radix tree like I
> did in my original fix. That way the page won't be swapcache either so I
> don't even need to use get_page to avoid remove_exclusive_swap_page to
> mess with it.

The BUG_ON in radix_tree_tag_set() is a fairly arbitrary sanity check:
"hey, why are you tagging a non-existent item?".

We could simply replace it with a `return NULL;'?
