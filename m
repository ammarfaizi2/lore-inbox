Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbQL2BmD>; Thu, 28 Dec 2000 20:42:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129464AbQL2Blx>; Thu, 28 Dec 2000 20:41:53 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:46088 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129226AbQL2Bll>; Thu, 28 Dec 2000 20:41:41 -0500
Date: Thu, 28 Dec 2000 17:10:45 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test13-pre5
In-Reply-To: <Pine.LNX.4.21.0012282012480.12680-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.10.10012281701190.1231-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 28 Dec 2000, Marcelo Tosatti wrote:
> 
> We also want to move the page to the per-address-space clean list in
> ClearPageDirty I suppose.

I would actually advice against this.

 - it's ok to have too many pages on the dirty list (think o fthe dirty
   list as a "these pages _can_ be dirty")

 - whenever we do a ClearPageDirty() we're likely to remove the page from
   the lists altogether, so it's not worth it doing extra work.

The exception, of course, is the actual "filemap_fdatasync()" function,
but that one would probably look something like

	spin_lock(&page_cache_lock);
	while (!list_empty(&mapping->dirty_pages)) {
		struct page *page = list_entry(mapping->dirty_pages.next, struct page, list);

		list_del(&page->list);
		list_add(&page->list, &mapping->clean_pages);

		if (!PageDirty(page))
			continue;
		page_get(page);
		spin_unlock(&page_cache_lock);

		lock_page(page);
		if (PageDirty(page)) {
			ClearPageDirty(page);
			page->mapping->writepage(page);
		}
		UnlockPage(page);
		page_cache_put(page);
		spin_lock(&page_cache_lock);
	}
	spin_unlock(&page_cache_lock);

and again note how we can move it to the clean list early and we don't
have to keep the PageDirty bit 100% in sync with which list is it on. If
somebody marks it dirty later on (and the dirty bit is still set), that
somebody won't move it back to the dirty list (because it noticved that
the dirty bit is already set), but that's ok: as long as we do the
"ClearPageDirty(page);" call before startign the actual writeout(), we're
fine.

So the "mapping->dirty_pages" list is maybe not so much a _dirty_ list, as
a "scheduled for writeout" list. Marking the page clean doesn't remove it
from that list - it can happily stay on the list and then when the
writeout is started we'd just skip it.

	Ok?

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
