Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289210AbSBSBqf>; Mon, 18 Feb 2002 20:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289243AbSBSBqZ>; Mon, 18 Feb 2002 20:46:25 -0500
Received: from dsl-213-023-040-169.arcor-ip.net ([213.23.40.169]:17042 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289234AbSBSBpa>;
	Mon, 18 Feb 2002 20:45:30 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFC] Page table sharing
Date: Tue, 19 Feb 2002 02:50:09 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Hugh Dickins <hugh@veritas.com>, <dmccr@us.ibm.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Robert Love <rml@tech9.net>,
        Rik van Riel <riel@conectiva.com.br>, <mingo@redhat.com>,
        Andrew Morton <akpm@zip.com.au>, <manfred@colorfullife.com>,
        <wli@holomorphy.com>
In-Reply-To: <Pine.LNX.4.33.0202181631120.24405-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0202181631120.24405-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16czQ1-0000yf-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 19, 2002 01:56 am, Linus Torvalds wrote:
> On Tue, 19 Feb 2002, Daniel Phillips wrote:
> >
> > Thanks, here it is again.  This time I left the gratuitous whitespace
> > cleanup in as the route of least resistance ;-)
> 
> Daniel, there's something wrong in the locking.
> 
> I can see _no_ reason to have "page_table_share_lock". What is the point
> of that one?
> 
> Whenever we end up touching the pmd counts, we already hold the local
> mm->page_table_lock. That means that we are always guaranteed to have a
> count of at least one when we start out on it.
> 
> We have two cases:
>  (a) sharing a new pmd
>  (b) unsharing
> 
> So let's go through the cases.
> 
>  (a) Sharing
> 	- test old count. It is either 1 or not.
> 	- if old count > 1, then we know it was already marked read-only,
> 	  and we have nothing to do but to increment the count.
> 	- if the old count == 1, then we are the only users and nobody
> 	  else can even try to add sharing due to mm->page_table_lock.
> 	  So just mark the thing read-only, invalidate the current TLB,
> 	  and increment the count.
> 
>      Do you see any reason to lock anything?

No, that's correct.  Never mind that I'm currently doing setting the CoW at
that point, regardless of the share count.  That's extra work that doesn't 
need doing.

>  (b) Unsharing
> 	- test old count. It is either 1 or not.
> 	- if old-count > 1, then we know somebody else might unshare in
> 	  parallel, but that doesn't matter. Everybody does:
>
> 		- allocate new pmd
> 		- copy over into new pmd and mark writable, increment page
> 		  counts.
> 		- install new pmd
> 		- unuse_pmd() on old pmd, ie:
> 			if (put_page_testzero(pmd_page)) {
> 				for-each-page()
> 					free the pages
> 				__free_pages_ok(pmd_page);
> 			}

Yes.  I'm still working with the existing design that deletes page tables
only in one place.  Because of that I wanted to be sure that two would not
unshare at the same time, requiring the original to be freed after two
copies are made.  Your suggestions for freeing page tables agressively on
the fly are the way to go I agree, but it's a more agressive change and
I'd like to get the current, more boring design stable as a step in that
direction.  I find it easier to start with a functioning system and remove
locking until it breaks than start with a broken system and add locking
until it works.  Of course it would be even better to have a perfect
understanding of the situation from the very beginning, but things seem
to seldom work out that way.

I feel the same way about the RO on the page table, it's where we want to
go but I'd like to go there like an inchworm as opposed to a grasshopper.
 
> 	- if old-count == 1, we know we're exclusive, and nobody else can
> 	  ever get at it, we just mark everything writable and do not play
> 	  any games at all with the count.
> 
>       Do you see any reason to lock anything?

Somebody might read fault, changing an entry when we're in the middle of
copying it and might might do a duplicated read fault.

> In short, I do not believe that that lock is needed. And if it isn't
> needed, it is _incorrect_. Locking that doesn't buy you anything is not
> just a performance overhead, it's bad thinking.
>
> Look at all the potential races:
> 
>  - share+share:
> 	no races. Either the page started out exclusive (in which case
> 	only one user can see it at 1), or it started out shared (in which
> 	case all users see it > 1).
> 
>  - share+unshare:
> 	This implies that the count _must_ have been at least
> 	"1+(nr-of-unsharers)", as one user is obviously adding sharing
> 	(the "1"), and everybody else must be have it shared. (And we will
> 	end up with a count of at least 2 after the share, because of the
> 	sharer)
> 
> 	Regardless of _what_ the order is, the unsharers must have seen at
> 	least a count of 2 to start with (their own + the one who si
> 	about to share or has just shared). So all unsharers will clearly
> 	allocate a new page, and will end up with
> 
> 		if (put_page_testzero(pmd_page)) {
> 			...
> 		}
> 
> 	where the "testzero" case will never happen.
> 
>  - unshare+unshare:
> 	This is the only halfway interesting case. You might have both
> 	unsharers seeing the count > 1, in which case _both_ will do the
> 	copy, and both will do the "put_page_testzero()".
> 
> 	However, only one will actually end up triggering the
> 	"put_page_testzero()", and by the time that happens, the pmd is
> 	totally exclusive, and the only thing it should do (and does) is
> 	to just go through the pmd and decrement the counts for the pte
> 	entries.
> 
> 	Note that no way can both unsharers see a count of 1 - the
> 	unsharers both see at least their own counts, and the other
> 	unsharers count will only be decremented after it has already
> 	copied the page away into its private storage.
> 
> 	The other possibility is that one sees a count > 1, and gets to
> 	copy and decrement it before the other racer even sees the count,
> 	so the other one sees the 1, and won't bother with the copy.
> 	That's likely to be the common case (serialized by other things),
> 	and is the case we want.
> 
> Does anybody see any reason why this doesn't work totally without the
> lock?

With the exception of the missing read fault exclusion this looks good.

OK, still working on it.  There is a massive memory leak to hunt down
also, so even though I may have more locking than needed, something's
still missing.

-- 
Daniel
