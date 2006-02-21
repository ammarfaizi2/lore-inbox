Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161221AbWBULaz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161221AbWBULaz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 06:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161222AbWBULaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 06:30:55 -0500
Received: from linuxhacker.ru ([217.76.32.60]:1190 "EHLO shrek.linuxhacker.ru")
	by vger.kernel.org with ESMTP id S1161221AbWBULax (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 06:30:53 -0500
Date: Tue, 21 Feb 2006 13:30:26 +0200
From: Oleg Drokin <green@linuxhacker.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Request for export of truncate_complete_page
Message-ID: <20060221113026.GE5733@linuxhacker.ru>
References: <20060220223810.GD5733@linuxhacker.ru> <20060220215410.5990c612.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220215410.5990c612.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, Feb 20, 2006 at 09:54:10PM -0800, Andrew Morton wrote:
> >    Can I ask for truncate_complete_page() to be exported?
> >    For Lustre filesystem it is necessary to poke out pages in the middle of
> >    a file, but truncate_inode_pages() is not very suitable, because we
> >    poke those pages one at a time when locks on those pages are cancelled, but
> >    we cannot kill entire set of pages as a group, because there might be some
> >    other lock that covers a subset of those pages, so we still need to iterate
> >    through all of them, and while we are at it, it is easier to kill pages
> >    as we check them one by one.
> Isn't truncate_inode_pages_range() suitable?

No, for the reason I specified above. We still walk entire region on page by
page basis, checking that page is not covered by other locks that might warrant
its exclusion from truncating, pushing writing of the page if it is still dirty
and needs to be written (or clearing its dirty flag if it needs to be
discarded).
So we have sort of reimplemented truncate_inode_pages_range() with extra logic
specific to Lustre and calling truncate_inode_pages_range() for every page
we want to get rid of is overkill.

> > +EXPORT_SYMBOL(truncate_complete_page);
> _GPL would be nicer.   Plus a comment to keep people from "cleaning it up".

Not that I mind if it is GPL or not, but currently truncate_complete_page()
can be reimplemented with EXPORT_SYMBOL stuff only. Here's how:

static inline void ll_remove_from_page_cache(struct page *page)
{
        struct address_space *mapping = page->mapping;

        BUG_ON(!PageLocked(page));

        write_lock_irq(&mapping->tree_lock);
        radix_tree_delete(&mapping->page_tree, page->index);
        page->mapping = NULL;
        mapping->nrpages--;
        atomic_add(-1, &nr_pagecache); // XXX pagecache_acct(-1);
        write_unlock_irq(&mapping->tree_lock);
}

static inline void
truncate_complete_page(struct address_space *mapping, struct page *page)
{
        if (page->mapping != mapping)
                return;

        if (PagePrivate(page))
                page->mapping->a_ops->invalidatepage(page, 0);

        clear_page_dirty(page);
        ClearPageUptodate(page);
        ClearPageMappedToDisk(page);
        ll_remove_from_page_cache(page);
        page_cache_release(page);       /* pagecache ref */
}

Bye,
    Oleg
