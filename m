Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290814AbSBFVMn>; Wed, 6 Feb 2002 16:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290810AbSBFVMg>; Wed, 6 Feb 2002 16:12:36 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17683 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S290812AbSBFVMU>;
	Wed, 6 Feb 2002 16:12:20 -0500
Message-ID: <3C619C0F.367A6E67@zip.com.au>
Date: Wed, 06 Feb 2002 13:11:43 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Benjamin LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] __free_pages_ok oops
In-Reply-To: <3C618863.DA7AC3B9@zip.com.au> <Pine.LNX.4.21.0202061958100.2009-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> 
> On Wed, 6 Feb 2002, Andrew Morton wrote:
> > Hugh Dickins wrote:
> > >
> > > Sorry, no solution, but maybe another oops in __free_pages_ok might help?
> >
> > What problem are you trying to solve?
> 
> Amidst all the prune_dcache and other kswapd oopses reported
> (which I'd love to solve, but still can't work out), there have
> been a couple in shrink_cache itself, where the page from the
> inactive_list is not marked as on LRU, or is marked as Active;
> and also I think a couple in rmqueue, where the free page is
> found to be on LRU.

You noticed too, hey :)

I've been collecting these reports for five or six weeks,
also getting things like .config, machine usage patterns,
machine history, etc.

It's like grabbing shadows, really.  A significant number
of the reporters are using netfilter, and that's basically
the only thing I have to go on at this time.  And a lot of
people use netfilter, so it's probably coincidental.

A number of the reports were confirmed to be against flakey
hardware.  A few more were on cranky old P150's and such,
which I'm tending to dismiss.  In fact the great majority
of reports are likely to be hardware failures.

But I don't recall seeing this volume of reports against
2.2.x.

And we have things like zeus.kernel.org's death yesterday.
Peter is quite certain that it was a software failure.

It certainly looks like random memory corruption.  Quite
frequently the faulting address is just "data".   Examples
from my growing vm-oopses folder include:

364d0a11
16a1842f
5f33f59b
410a0d26
d70f589b
6964656e
3562726b
0017e980
65726198
008209dc

Many more are null-pointer derefs.

> Some of those may have been memtest86ed out of contention since,
> and some may have been on SMP and so not candidates; but it did
> just occur to me that we'd like to be sure nothing is messing
> with the LRU at interrupt time, hence the patch.  Which of
> course solves nothing, but might shed some light.

Sure.  I can't think of any way of chasing this down (if it
exists) apart from putting special-purpose debug code into
the mainstream kernel.

Al suggests a `honey pot' kernel thread which ticks over,
allocating, validating and releasing memory, waiting for
it to get stomped on.   If it gets corrupted we can dump
lots of memory and a task list, I guess.

We could also re-enable slab debugging.

Also we can add some magic numbers to inodes and dentries,
validate addresses and memory locations as we walk the lists,
mainly on the shrink_cache path.  If corruption is detected
then we dump out lots of memory and look through it for
suspicious kernel addresses.

Any other ideas?

-
