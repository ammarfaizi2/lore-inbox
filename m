Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272839AbRIPV3w>; Sun, 16 Sep 2001 17:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272843AbRIPV3n>; Sun, 16 Sep 2001 17:29:43 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:18695 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S272839AbRIPV32>; Sun, 16 Sep 2001 17:29:28 -0400
Date: Sun, 16 Sep 2001 14:28:48 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andreas Steinmetz <ast@domdv.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: broken VM in 2.4.10-pre9
In-Reply-To: <XFMail.20010916222959.ast@domdv.de>
Message-ID: <Pine.LNX.4.33.0109161415340.22182-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 16 Sep 2001, Andreas Steinmetz wrote:
>
> > The fact that the "use-once" logic didn't kick in is the problem. It's
> > hard to tell _why_ it didn't kick in, possibly because the MP3 player
> > read small chunks of the pages (touching them multiple times).
> >
> Then you should have an eye on mmap(). aide uses it. And it causes a real
> problem. The basic logic is here:
>
> open(file,O_RDONLY);
> mmap(whole-file,PROT_READ,MAP_SHARED);
> <do md5sum of mapped file>
> munmap();
> close();

Okey-dokey.

I actually started looking at the current Linux page referenced logic, and
it just looks incredibly broken. There's no logic to it, and it's obvious
how some of it has grown over time without people really understanding or
caring about the referenced bit.

It looks very much like part of the VM was done with only "page->age", and
another part was done with the reference bit. So some users will totally
ignore the information that other users use and update. It's not pretty.

> No matter how you call the thing above (not my code, anyway): I strongly feel
> that the use once logic isn't a great idea. What if lots of pages get accessed
> twice? Where to set the limit?

Actually, the once-used approach _should_ work fine for mmap'ed pages too,
but the fact is that the code didn't even try, partly because the mmap
code was the code that used page->age and didn't care about the referenced
bit at all (except it _did_ care about the referenced bit in the page
tables: just not the bit in "struct page". And it's the latter bit that
actually ends up being the best once-used logic).

> How about adding a swapout cost factor? This would prevent swapping until
> pressure is really high without any fixed limits. Calculate clean page reuse in
> microseconds whereas swapout followed by swapin is going to be milliseconds.
> That's a factor of at least 1000 which needs to be applied in page selection.

Well, the thing is, swap-out is often cheaper than read-in, and just
dropping a page is often the cheapest of all. And all of these things are
a bit intertwined.

I actually have a _sane_ generic "used-once" approach that works with
mmap'ed memory and with other kinds too, and right now it doesn't bother
with "page->age" _at_all_. Instead, the aging is done by moving things
from one list to another, which actually seems to be better, but who
knows.

And that automatically gets used-once right - any pages are always added
to the inactive lists, and get bumped up to active only after they are
physically referenced the second time. This is actually incredibly trivial
to do without any aging at all:

	void mark_page_accessed(struct page *page)
	{
	        if (!PageActive(page) && PageReferenced(page)) {
	                activate_page(page);
	                ClearPageReferenced(page);
	                return;
	        }

	        /* Mark the page referenced, AFTER checking for previous usage..  */
	        SetPageReferenced(page);
	}

and the other importan tpart that we got (completely) wrong wrt the
use-once logic is the fact that when we scan the inactive lists and find a
page that is marked "referenced", we should NOT move it to the active list
(that defeats the whole point of use-once), but we should instead just
clear the reference bit and move it to the head of the right inactive
list.

So it actually looks like the use-once logic only worked under some very
specific circumstances, not in general.

Anybody willing to test the simple used-once cleanups? No guarantees, but
at least they make sense (some of the old interactions certainly do not).

(The new code is a simple state machine:

 - touch non-referenced page: set the reference bit

 - touch already referenced page: move it to next list "upwards" (ie the
   active list)

 - age a non-referenced page on a list: move to "next" list downwards (ie
   free if already inactive, move to inactive if currently active)

 - age a referenced page on a list: clear ref bit and move to beginning of
   same list.

which works fine for mmap pages too. I left the age updates, because the
page age may well make sense within the active list).

I'll make a 2.4.10pre10.

		Linus

