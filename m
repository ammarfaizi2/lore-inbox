Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311936AbSDXUVj>; Wed, 24 Apr 2002 16:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312031AbSDXUVi>; Wed, 24 Apr 2002 16:21:38 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2829 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S311936AbSDXUVh>;
	Wed, 24 Apr 2002 16:21:37 -0400
Message-ID: <3CC7139E.F9E96F66@zip.com.au>
Date: Wed, 24 Apr 2002 13:20:46 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Jes Sorensen <jes@trained-monkey.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] page->flags cleanup
In-Reply-To: <3CC6720F.BD1367B9@zip.com.au> <Pine.LNX.4.21.0204241857450.2322-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> 
> ...
> > - UnlockPage is removed.  All callers updated to use unlock_page().
> >   it's a real function - there's no need to hide that fact.
> 
> Hmm, well, I'd prefer not to change that very widely used name;
> but I've no serious objection if you wish to.

UnlockPage() looks like a simple clear_bit(), but it very much isn't.
I think it's better this way.

> ...
> 
> > - PageSwapCache() is renamed to page_swap_cache(), so it doesn't
> >   pretend to be a page->flags bit test.
> 
> Again, I'd prefer to leave PageSwapCache as is: it used to have a
> page->flags bit, it might be given a page->flags bit again in future
> (multiple swapper_spaces?).  I don't think "Page" in the macro name
> should have to imply implementation using a page->flags bit.  But
> again, I've no serious objection if you wish to make this change.

OK, I re-renamed the predicate back to PageSwapCache, added some
commentary about this.
 
> ...
> 
> 1. The two "if (PageSwapCache(page)) BUG();"s  in mm/page_alloc.c
>    are redundant and should just be deleted rather than converted:
>    we have just checked that page->mapping is unset, so (excepting
>    a volatile mod of a kind which would need an infinite number of
>    identical tests to protect against) of course it isn't &swapper_space
>    (but the compiler doesn't optimize away).  The two PageSwapCache BUG
>    tests in mm/page_io.c similarly redundant and should also be deleted.

OK, I've done this in a separate patch.
 
> 2. I can't see from your mail (patch against an earlier version?) what
>    happened to the comment immediately above #define PageError(page)
>    in 2.5.9/include/linux/mm.h - the comment beginning "The first mb".
>    That comment originally belonged to UnlockPage(), and should have
>    been moved to unlock_page() when that went into mm/filemap.c.
>    I sometimes wonder whether those two "mb"s are actually still
>    required (quite a lot has changed since they went in), but that's
>    a different kind of question, and certainly not one I can answer.

I moved the comment to unlock_page().

> 3. You're removing PG_skip and shifting highers down (in patch you
>    mailed separately): good, but please remove PG_unused too and shift
>    highers down (I cautiously renamed PG_swap_cache to PG_unused when
>    changing PageSwapCache macro, the time for that caution has past).

I wondered what that was doing there ;)  Done.

Updated patch series (compiles, untested, should be OK) is at
http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.10/

Thanks.

Sometime I'll bite the bullet and actually change all .c
files to include page-flags.h direct.  I did that yesterday
but wasn't happy with it.  There are some unfortunate dependencies
in pagemap.h and highmem.h which need cleaning up first.

-
