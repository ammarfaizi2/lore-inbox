Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289116AbSBSA6o>; Mon, 18 Feb 2002 19:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289115AbSBSA6i>; Mon, 18 Feb 2002 19:58:38 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:55048 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289102AbSBSA61>; Mon, 18 Feb 2002 19:58:27 -0500
Date: Mon, 18 Feb 2002 16:56:48 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Hugh Dickins <hugh@veritas.com>, <dmccr@us.ibm.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Robert Love <rml@tech9.net>,
        Rik van Riel <riel@conectiva.com.br>, <mingo@redhat.co>,
        Andrew Morton <akpm@zip.com.au>, <manfred@colorfullife.com>,
        <wli@holomorphy.com>
Subject: Re: [RFC] Page table sharing
In-Reply-To: <E16cxM4-0000xB-00@starship.berlin>
Message-ID: <Pine.LNX.4.33.0202181631120.24405-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 19 Feb 2002, Daniel Phillips wrote:
>
> Thanks, here it is again.  This time I left the gratuitous whitespace
> cleanup in as the route of least resistance ;-)

Daniel, there's something wrong in the locking.

I can see _no_ reason to have "page_table_share_lock". What is the point
of that one?

Whenever we end up touching the pmd counts, we already hold the local
mm->page_table_lock. That means that we are always guaranteed to have a
count of at least one when we start out on it.

We have two cases:
 (a) sharing a new pmd
 (b) unsharing

So let's go through the cases.

 (a) Sharing
	- test old count. It is either 1 or not.
	- if old count > 1, then we know it was already marked read-only,
	  and we have nothing to do but to increment the count.
	- if the old count == 1, then we are the only users and nobody
	  else can even try to add sharing due to mm->page_table_lock.
	  So just mark the thing read-only, invalidate the current TLB,
	  and increment the count.

     Do you see any reason to lock anything?

 (b) Unsharing
	- test old count. It is either 1 or not.
	- if old-count > 1, then we know somebody else might unshare in
	  parallel, but that doesn't matter. Everybody does:

		- allocate new pmd
		- copy over into new pmd and mark writable, increment page
		  counts.
		- install new pmd
		- unuse_pmd() on old pmd, ie:
			if (put_page_testzero(pmd_page)) {
				for-each-page()
					free the pages
				__free_pages_ok(pmd_page);
			}

	- if old-count == 1, we know we're exclusive, and nobody else can
	  ever get at it, we just mark everything writable and do not play
	  any games at all with the count.

      Do you see any reason to lock anything?

In short, I do not believe that that lock is needed. And if it isn't
needed, it is _incorrect_. Locking that doesn't buy you anything is not
just a performance overhead, it's bad thinking.

Look at all the potential races:

 - share+share:
	no races. Either the page started out exclusive (in which case
	only one user can see it at 1), or it started out shared (in which
	case all users see it > 1).

 - share+unshare:
	This implies that the count _must_ have been at least
	"1+(nr-of-unsharers)", as one user is obviously adding sharing
	(the "1"), and everybody else must be have it shared. (And we will
	end up with a count of at least 2 after the share, because of the
	sharer)

	Regardless of _what_ the order is, the unsharers must have seen at
	least a count of 2 to start with (their own + the one who si
	about to share or has just shared). So all unsharers will clearly
	allocate a new page, and will end up with

		if (put_page_testzero(pmd_page)) {
			...
		}

	where the "testzero" case will never happen.

 - unshare+unshare:
	This is the only halfway interesting case. You might have both
	unsharers seeing the count > 1, in which case _both_ will do the
	copy, and both will do the "put_page_testzero()".

	However, only one will actually end up triggering the
	"put_page_testzero()", and by the time that happens, the pmd is
	totally exclusive, and the only thing it should do (and does) is
	to just go through the pmd and decrement the counts for the pte
	entries.

	Note that no way can both unsharers see a count of 1 - the
	unsharers both see at least their own counts, and the other
	unsharers count will only be decremented after it has already
	copied the page away into its private storage.

	The other possibility is that one sees a count > 1, and gets to
	copy and decrement it before the other racer even sees the count,
	so the other one sees the 1, and won't bother with the copy.
	That's likely to be the common case (serialized by other things),
	and is the case we want.

Does anybody see any reason why this doesn't work totally without the
lock?

		Linus

