Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131013AbQL1VaY>; Thu, 28 Dec 2000 16:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131230AbQL1VaO>; Thu, 28 Dec 2000 16:30:14 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:26638 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131013AbQL1VaF>; Thu, 28 Dec 2000 16:30:05 -0500
Date: Thu, 28 Dec 2000 12:59:22 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test13-pre5
In-Reply-To: <Pine.LNX.4.21.0012281637200.12364-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.10.10012281243010.788-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 28 Dec 2000, Marcelo Tosatti wrote:
> 
> On Thu, 28 Dec 2000, Linus Torvalds wrote:
> 
> > This still doesn't tell "sync()" about dirty pages (ie the "innd loses the
> > active file after a reboot" bug), but now the places that mark pages dirty
> > are under control. Next step..
> 
> Do you really want to split the per-address-space pages list in dirty and
> clean lists for 2.4 ?
> 
> Or do you think walking the current per-address-space page list searching
> for dirty pages and syncing them is ok?

There are a few issues:

 - fdatasync/fsync is often quite critical for databases. It's _possibly_
   ok to just walk all the pages for an inode, but I'm fairly certain that
   this is an area where if we don't have a separate dirty queue we _will_
   need to add one later.

 - global dirty list for global syn(). We don't have one, and I don't
   think we want one. We could add a few lists, and split up the active
   list into "active" and "active_dirty", for example, but I don't like
   the implications that would probably have for the LRU ordering.

 - we absolutely do _not_ want to make "struct page" bigger. We can't
   afford to just throw away another 8 bytes per page on adding a new list
   structure, I feel. Even if this would be the simplest solution.

So right now I think the right idea is to

 - split up "address_space->pages" into "->clean_pages" and
   "->dirty_pages".  This is fairly easily done, it requires small changes
   like making "truncate_inode_pages()" instead be
   "truncate_list_pages()", and making "truncate_inode_pages()" call that
   for both the dirty and the clean lists. That's about 10 lines of diff
   (I already tried this), and that's about the biggest example of
   something like that. Most other areas don't much care about the inode
   page lists.

 - make "SetPageDirty()" do something like

	if (!test_and_set(PG_dirty, &page->flags)) {
		spin_lock(&page_cache_lock);
		list_del(page->list);
		list_add(page->list, page->mapping->dirty_pages);
		spin_unlock(&page_cache_lock);
	}

   This will require making sure that every place that does a
   SetPageDirty() will be ok with this (ie double-check that they all have
   a mapping: right now the free_pte() code in mm/memory.c doesn't care,
   because it knew that it coul dmark even anonymous pages dirty and
   they'd just get ignored.

 - make a filemap_fdatasync() that walks the dirty pages and does a
   writepage() on them all and moves them to the clean list.

 - make fsync() and fdatasync() call the above function before they even
   call the low-level per-FS code.

 - make sync_inodes() use that same filemap_fdatasync() function so that
   the sync() case is handled.

All done. It looks something like 5-10 places, most of which are about 10
lines of diff each, if even that.

The only real worry would be that the locking isn't rigth, but getting the
pagemap lock should be the safe thing, and from a lock contention
standpoint it should be ok (if we move a lot of pages back and forth, lock
contention is going to be the least of our worries, because it implies
that we'd be doing a LOT of IO to actually write the pages out).

If somebody (you? hint, hint) wants to do this, I'd be very happy - I can
do it myself, but because it's my birthday I'm supposed to drag myself off
the computer soon and be social, or Tove will be grumpy.

And you don't want Tove grumpy.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
