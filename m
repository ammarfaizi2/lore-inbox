Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131607AbQL1TZw>; Thu, 28 Dec 2000 14:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131575AbQL1TZm>; Thu, 28 Dec 2000 14:25:42 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:47625 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131357AbQL1TZ1>; Thu, 28 Dec 2000 14:25:27 -0500
Date: Thu, 28 Dec 2000 10:54:32 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Phillips <phillips@innominate.de>
cc: Rik van Riel <riel@conectiva.com.br>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: innd mmap bug in 2.4.0-test12
In-Reply-To: <3A4B8895.CEDA8311@innominate.de>
Message-ID: <Pine.LNX.4.10.10012281051480.12260-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 28 Dec 2000, Daniel Phillips wrote:

> [in vmscan.c]
> > Between line 573 and 594 the page can have 1 user and be unlocked, so it
> > can be removed by invalidate_inode_pages, and the mapping will be
> > cleared here:
> > http://innominate.org/~graichen/projects/lxr/source/mm/filemap.c?v=v2.3#L98
> 
> This seems like the obvious thing to do:
> 
> --- 2.4.0-test13.clean/mm/filemap.c	Fri Dec 29 03:14:58 2000
> +++ 2.4.0-test13/mm/filemap.c	Fri Dec 29 03:16:21 2000
> @@ -96,6 +96,7 @@
>  	remove_page_from_inode_queue(page);
>  	remove_page_from_hash_queue(page);
>  	page->mapping = NULL;
> +	ClearPageDirty(page);
>  }
>  
>  void remove_inode_page(struct page *page)

No, I'd much rather have

	if (PageDirty(page)) BUG();

there, and then have the free_swap_cache code clear the dirty bit.

We don't want to lose dirty bits by mistake. The only cases where it's ok
to clear the dirty bit is when we truncate a page completely (so it won't
be needed and obviously really shouldn't be written out) and when we've
lost the last user of a swap cache entry.

Any other cases might be bugs, where we remove a page from a mapping
without noticing that it is dirty (we had this bug in reclaim_pages(), for
example).

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
