Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318299AbSHZVQc>; Mon, 26 Aug 2002 17:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318302AbSHZVQc>; Mon, 26 Aug 2002 17:16:32 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6674 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318299AbSHZVQa>;
	Mon, 26 Aug 2002 17:16:30 -0400
Message-ID: <3D6A9E4D.DBCC5D0A@zip.com.au>
Date: Mon, 26 Aug 2002 14:31:57 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>
CC: Christian Ehrhardt <ehrhardt@mathematik.uni-ulm.de>,
       lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: MM patches against 2.5.31
References: <3D644C70.6D100EA5@zip.com.au> <E17jO6g-0002XU-00@starship> <20020826200048.3952.qmail@thales.mathematik.uni-ulm.de> <E17jQB8-0002Zi-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> ...
> > If you think about who is going to remove the page from the lru you'll
> > see the problem.
> 
> Nope, still don't see it.  Whoever hits put_page_testzero frees the page,
> secure in the knowlege that there are no other references to it.

Sure. But this requires that the caller of page_cache_release() has
previously removed the page from the LRU.  We (used to) do that for truncate
and page reclaim.   But we did not do that for anon pages.

For anon pages, we perform magical LRU removal when the page refcount
goes to zero.

The fact that we performed explicit removal in one place, and magical removal
in the other was unfortunate.  I nuked the explicit removal and made it
all magical (explicit removal in truncate_complete_page() was wrong anyway - the
page could have been rescued and anonymised by concurrent pagefault and must
stay on the LRU).

Possibly, we could go back to explicit removal everywhere.   Haven't
really looked at that, but I suspect we're back to a similar problem:
to do you unracily determine whether the page should be removed from
the LRU?  Take ->page_table_lock and look at page_count(page)?  Worried.

I like the magical-removal-just-before-free, and my gut feel is that
it'll provide a cleaner end result.

Making presence on the LRU contribute to page->count is attractive,
if only because it removes some irritating and expensive page_cache_gets
and puts from shrink_cache and refill_inactive.  But for it to be useful,
we must perform explicit removal everywhere.

Making presence on the LRU contribute to page->count doesn't fundamentally
change anything of course - it offsets the current problems by one.

Then again, it would remove all page_cache_gets/releases from vmscan.c
and may thus make the race go away.  That's a bit of a timebomb though.
