Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751472AbWBLVzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbWBLVzr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 16:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbWBLVzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 16:55:47 -0500
Received: from smtp.osdl.org ([65.172.181.4]:26535 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751472AbWBLVzq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 16:55:46 -0500
Date: Sun, 12 Feb 2006 13:54:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: wli@holomorphy.com, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] compound page: use page[1].lru
Message-Id: <20060212135457.2a3d3b37.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0602121943150.15774@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0602121943150.15774@goblin.wat.veritas.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> If a compound page has its own put_page_testzero destructor (the only
>  current example is free_huge_page), that is noted in page[1].mapping of
>  the compound page.  But that's rather a poor place to keep it: functions
>  which call set_page_dirty_lock after get_user_pages (e.g. Infiniband's
>  __ib_umem_release) ought to be checking first, otherwise set_page_dirty
>  is liable to crash on what's not the address of a struct address_space.
> 
>  And now I'm about to make that worse: it turns out that every compound
>  page needs a destructor, so we can no longer rely on hugetlb pages going
>  their own special way, to avoid further problems of page->mapping reuse.
>  For example, not many people know that: on 50% of i386 -Os builds, the
>  first tail page of a compound page purports to be PageAnon (when its
>  destructor has an odd address), which surprises page_add_file_rmap.
> 
>  Keep the compound page destructor in page[1].lru.next instead.  And to
>  free up the common pairing of mapping and index, also move compound page
>  order from index to lru.prev.  Slab reuses page->lru too: but if we ever
>  need slab to use compound pages, it can easily stack its use above this.

I'm scratching my head over flush_dcache_page() on, say, sparc64.  For
example, the one in fs/direct-io.c.  With this patch, we'll call
flush_dcache_page_impl(), which at least won't crash.  Before the patch I
think we'd just do random stuff.

But I'm not sure that flush_dcache_page(hugetlb tail page) will do the
right thing in aither case?
