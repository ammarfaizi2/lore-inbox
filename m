Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262518AbUDAPPi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 10:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262931AbUDAPPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 10:15:38 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:38630
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262518AbUDAPPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 10:15:35 -0500
Date: Thu, 1 Apr 2004 17:15:34 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, vrajesh@umich.edu,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity fix
Message-ID: <20040401151534.GJ18585@dualathlon.random>
References: <20040401020126.GW2143@dualathlon.random> <Pine.LNX.4.44.0404010549540.28566-100000@localhost.localdomain> <20040401133555.GC18585@dualathlon.random> <20040401150911.GI18585@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040401150911.GI18585@dualathlon.random>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> diff -urNp --exclude CVS --exclude BitKeeper --exclude {arch} --exclude .arch-ids x-ref/mm/page_io.c x/mm/page_io.c
> --- x-ref/mm/page_io.c	2004-04-01 17:07:10.231289760 +0200
> +++ x/mm/page_io.c	2004-04-01 17:07:33.182800600 +0200
> @@ -139,7 +139,7 @@ struct address_space_operations swap_aop
>  
>  /*
>   * A scruffy utility function to read or write an arbitrary swap page
> - * and wait on the I/O.
> + * and wait on the I/O.  The caller must have a ref on the page.
>   */
>  int rw_swap_page_sync(int rw, swp_entry_t entry, struct page *page)
>  {
> @@ -151,8 +151,16 @@ int rw_swap_page_sync(int rw, swp_entry_
>  	lock_page(page);
>  
>  	BUG_ON(page->mapping);
> -	page->mapping = &swapper_space;
> -	page->index = entry.val;
> +	ret = add_to_page_cache(page, &swapper_space, entry.val, GFP_KERNEL);
> +	if (unlikely(ret)) {
> +		unlock_page(page);
> +		return ret;
> +	}
> +	/*
> +	 * get one more reference to make page non-exclusive so
> +	 * remove_exclusive_swap_page won't mess with it.
> +	 */
> +	page_cache_get(page);
>  
>  	if (rw == READ) {
>  		ret = swap_readpage(NULL, page);
> @@ -161,7 +169,13 @@ int rw_swap_page_sync(int rw, swp_entry_
>  		ret = swap_writepage(page, &swap_wbc);
>  		wait_on_page_writeback(page);
>  	}
> -	page->mapping = NULL;
> +
> +	lock_page(page);
> +	remove_from_page_cache(page);
> +	unlock_page(page);
> +	page_cache_release(page);
> +	page_cache_release(page);	/* For add_to_page_cache() */
> +
>  	if (ret == 0 && (!PageUptodate(page) || PageError(page)))
>  		ret = -EIO;
>  	return ret;

incrementally to the above I applied this hardness checks in the
anon-vma patch, so we're safe against the problem Andrew outlined
(somebody attempting to do swapin/swapouts of anonymous pages through
that interface, something that shouldn't happen since we want only the
VM to deal with userspace mapped pages).

@@ -149,8 +149,14 @@ int rw_swap_page_sync(int rw, swp_entry_
 	};
 
 	lock_page(page);
-
+	/*
+	 * This library call can be only used to do I/O
+	 * on _private_ pages just allocated with alloc_pages().
+	 */
 	BUG_ON(page->mapping);
+	BUG_ON(PageSwapCache(page));
+	BUG_ON(PageAnon(page));
+	BUG_ON(PageLRU(page));
 	ret = add_to_page_cache(page, &swapper_space, entry.val, GFP_KERNEL);
 	if (unlikely(ret)) {
 		unlock_page(page);
