Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312576AbSDXT0r>; Wed, 24 Apr 2002 15:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312575AbSDXT0q>; Wed, 24 Apr 2002 15:26:46 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:51115 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S312576AbSDXT0p>; Wed, 24 Apr 2002 15:26:45 -0400
Date: Wed, 24 Apr 2002 20:26:20 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Jes Sorensen <jes@trained-monkey.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] page->flags cleanup
In-Reply-To: <3CC6720F.BD1367B9@zip.com.au>
Message-ID: <Pine.LNX.4.21.0204241857450.2322-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Apr 2002, Andrew Morton wrote:
> 
> The patch also makes all the page flag macros and functions consistent:
> 
> - Page_Uptodate is renamed to PageUptodate
> - LockPage is removed.  All users updated to use SetPageLocked

Good!

> - UnlockPage is removed.  All callers updated to use unlock_page(). 
>   it's a real function - there's no need to hide that fact.

Hmm, well, I'd prefer not to change that very widely used name;
but I've no serious objection if you wish to.

> - PageTestandClearReferenced renamed to TestClearPageReferenced
> - PageSetSlab renamed to SetPageSlab
> - __SetPageReserved is removed.  It's an infinitesimally small
>    microoptimisation, and is inconsistent.
> - TryLockPage is renamed to TestSetPageLocked

Good!  I especially hate trying to guess the return value of "Try"s.

> - PageSwapCache() is renamed to page_swap_cache(), so it doesn't
>   pretend to be a page->flags bit test.

Again, I'd prefer to leave PageSwapCache as is: it used to have a
page->flags bit, it might be given a page->flags bit again in future
(multiple swapper_spaces?).  I don't think "Page" in the macro name
should have to imply implementation using a page->flags bit.  But
again, I've no serious objection if you wish to make this change.

However, I again want to do that irritating thing I do, Andrew,
propose some related cleanups I'd noticed before and was waiting
for a suitable moment to make.  If these catch your fancy, please
include, else ignore.

1. The two "if (PageSwapCache(page)) BUG();"s  in mm/page_alloc.c
   are redundant and should just be deleted rather than converted:
   we have just checked that page->mapping is unset, so (excepting
   a volatile mod of a kind which would need an infinite number of
   identical tests to protect against) of course it isn't &swapper_space
   (but the compiler doesn't optimize away).  The two PageSwapCache BUG
   tests in mm/page_io.c similarly redundant and should also be deleted.

2. I can't see from your mail (patch against an earlier version?) what
   happened to the comment immediately above #define PageError(page)
   in 2.5.9/include/linux/mm.h - the comment beginning "The first mb".
   That comment originally belonged to UnlockPage(), and should have
   been moved to unlock_page() when that went into mm/filemap.c.
   I sometimes wonder whether those two "mb"s are actually still
   required (quite a lot has changed since they went in), but that's
   a different kind of question, and certainly not one I can answer.

3. You're removing PG_skip and shifting highers down (in patch you
   mailed separately): good, but please remove PG_unused too and shift
   highers down (I cautiously renamed PG_swap_cache to PG_unused when
   changing PageSwapCache macro, the time for that caution has past).

4. You've updated arch/m68k/atari/stram.c.  I'd prefer all traces of
   CONFIG_STRAM_SWAP be removed from m68k's Config.help, config.in
   and stram.c.  If that code even compiles (I never tried), it is
   using at least one function (shm_unuse) which didn't even exist in
   2.4.0, and has not been maintained to match all the swap changes
   which have gone on since.  What it appears to be doing (using
   slow RAM for swap) is sensible enough, but shouldn't that be done
   using the standard mm swap code (with extensions if necessary)
   on some atari/stram block device giving access to the memory?
   But obviously nobody has configured CONFIG_STRAM_SWAP y since
   2.4.0, so providing such functionality doesn't seem to be a high
   priority; and I'd prefer all that out-of-date stram.c swap code
   not to show up when we grep the source tree for such things.  Jes?

Hugh

