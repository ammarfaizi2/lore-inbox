Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263475AbUDBBDS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 20:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263479AbUDBBDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 20:03:18 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:62910 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263475AbUDBBDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 20:03:14 -0500
Date: Fri, 2 Apr 2004 02:03:14 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrea Arcangeli <andrea@suse.de>
cc: Andrew Morton <akpm@osdl.org>, <vrajesh@umich.edu>,
       <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity
    fix
In-Reply-To: <20040402001535.GG18585@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0404020145490.2423-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Apr 2004, Andrea Arcangeli wrote:
> 
> the good thing is that I believe this fix will make it work with the -mm
> writeback changes. However this fix now collides with anon-vma since
> swapsuspend passes compound pages to rw_swap_page_sync and
> add_to_page_cache overwrites page->private and the kernel crashes at the
> next page_cache_get() since page->private is now the swap entry and not
> a page_t pointer. So I guess I've a good reason now to giveup trying to
> add the page to the swapcache, and to just fake the radix tree like I
> did in my original fix. That way the page won't be swapcache either so I
> don't even need to use get_page to avoid remove_exclusive_swap_page to
> mess with it.

Yes, I too was feeling that we'd gone far enough in this "make it like
a real swap page" direction, and we'd probably have better luck with
"take away all resemblance to a real swap page".

I've still done no work or testing on rw_swap_page_sync, but I wonder...
remember how your page_mapping(page) gives &swapper_space on a swap
cache page, whereas my page_mapping(page) gives NULL on them?  My guess
(quite possibly wrong) is that I won't have any of the trouble you've
had with this, that the page_writeback functions, seeing NULL mapping,
won't get involved with the radix tree at all - and why should they,
it isn't doing anything useful for rw_swap_page_sync, just getting you
into memory allocation difficulties.  No need for add_to_page_cache or
add_to_swap_cache there at all.  As I say, I haven't tested this path,
but I do know that the rest of swap works fine with NULL page_mapping.

Hugh

