Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273269AbRIQBIe>; Sun, 16 Sep 2001 21:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273294AbRIQBIZ>; Sun, 16 Sep 2001 21:08:25 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:56586 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S273269AbRIQBIN>; Sun, 16 Sep 2001 21:08:13 -0400
Date: Sun, 16 Sep 2001 18:07:34 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: broken VM in 2.4.10-pre9
In-Reply-To: <20010917003422Z16197-2757+375@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.33.0109161738110.1054-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 17 Sep 2001, Daniel Phillips wrote:
>
> Can we confirm that the mp3 player is making subpage accesses? (strace)

People claim that they do mmap's, which the old code definitely didn't
handle correctly at all.

I'm not 100% sure that the 2.4.10-pre10 aging is right for anonymous pages
either, and the page-referenced handling at COW time looks suspiciously
broken, for example. It's not something we have ever gotten right, I think
- if the old pre-C-O-W page was marked accessed, we should mark that page
referenced before we break the COW. Otherwise we'll move over to a new
page without crediting the source.

> The 'partially read/written' state isn't handled properly now.  The
> transition to the 'used-once' state should only occur if the transfer ends at
> the exact end of the page.  Right now it always takes place after the *first*
> transfer on the page which is correct only for full-page transfers.

No, it's not as easy as you make it sound.

The problem is that partial accesses are real, and they should be counted
as such - except when they are _linear_ partial accesses, in which case
they should not be counted at all except for the first one.

Having some "if transfer ends at end of page" logic would minimally get
the enf-of-file case wrong, for example, never mind the case of a reader
that is seeking around in the file. The EOF case could be worked around
with yet another hack, but I suspect that the real fix is to try to fix
applications that do bad things.

> It's still best to start all pages unreferenced, because otherwise we don't
> have a means of distinguishing between the first and subsequent page cache
> lookups.  The check_used_once logic should set the page referenced if the IO
> transfer ends in the interior of the page or unreferenced if it ends at the
> end of the page.

See how 2.4.10-pre10 doesn't have any use_once hackery at all, but instead
has a clear path on references:

 prefetching: non-referenced page on inactive list
 after 1st reference: refrenced page on inactive list
 after 2nd reference: non-referenced page on active list
 after 3rd and subsequent accesses: referenced page on active list

while the "age down" logic is the exact reverse of the above. Logical and
easy to implement, and gives four distinct "stages" for all pages (along
with the LRU ordering within each list, of course).

Now, the above _is_ different from what we used to do. For one thing, it's
logical. But it might be different enough that the heuristics we have for
aging may need some tuning again. "Logical" is not enough..

There's also a few issues that I don't like right now wrt reference
handling, notably:

 - COW issue mentioned above. Probably trivially fixed by something like

	diff -u --recursive --new-file pre10/linux/mm/memory.c linux/mm/memory.c
	--- pre10/linux/mm/memory.c     Sun Sep 16 18:01:48 2001
	+++ linux/mm/memory.c   Sun Sep 16 18:00:59 2001
	@@ -955,6 +955,8 @@
	        if (pte_same(*page_table, pte)) {
	                if (PageReserved(old_page))
	                        ++mm->rss;
	+               if (pte_young(pte))
	+                       mark_page_accessed(old_page);
	                break_cow(vma, new_page, address, page_table);

	                /* Free the old page.. */

   which looks right (it basically saves off the referenced bit for the
   old page table entry in the physical page reference count).

 - truly anonymous pages (ie before they've been added to the swap cache)
   are not necessarily going to behave as nicely as other pages. They
   magically appear after VM scanning as a "1st reference", and I have a
   reasonably good argument that says that they'll have been aged up and
   down roughly the same number of times, which makes this more-or-less
   correct. But it's still a theoretical argument, nothing more.

   This could reasonably easily be fixed by adding these anonymous pages
   to the LRU lists anyway (with a bogus "page->mapping" which causes them
   to be re-mapped as _real_ swap cache pages when they need writeout),
   but that's a bit too subtle for my taste. If anybody wants to look into
   this, I'd love to know if it makes a difference in behaviour, though..

 - I don't like the lack of aging in 'reclaim_page()'. It will walk the
   whole LRU list if required, which kind of defeats the purpose of having
   reference bits and LRU on that list. The code _claims_ that it almost
   always succeeds with the first page, but I don't see why it would. I
   think that comment assumed that the inactive_clean list cannot have any
   referenced pages, but that's never been true.

There are probably other issues too, these are the ones I was wondering
about when I walked over the use of the PG_referenced bit..

		Linus

