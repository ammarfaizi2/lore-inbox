Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292529AbSBPVDy>; Sat, 16 Feb 2002 16:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292530AbSBPVDo>; Sat, 16 Feb 2002 16:03:44 -0500
Received: from dsl-213-023-039-202.arcor-ip.net ([213.23.39.202]:8083 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S292529AbSBPVD0>;
	Sat, 16 Feb 2002 16:03:26 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFC] Page table sharing
Date: Sat, 16 Feb 2002 22:08:05 +0100
X-Mailer: KMail [version 1.3.2]
Cc: <dmccr@us.ibm.com>, Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0202161212200.24268-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0202161212200.24268-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16cC3z-0004Kf-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 16, 2002 09:21 pm, Linus Torvalds wrote:
> On Sat, 16 Feb 2002, Daniel Phillips wrote:
> >
> > I think this patch is ready to look at now.  It's been pretty stable, 
> > though I haven't gone as far as booting with it - page table sharing is 
> > still restricted to uid 9999.  I'm running it on a 2 way under moderate 
> > load without apparent problems.  The speedup on forking from a parent 
> > with large vm is *way* more than I expected.
> 
> I'd really like to hear what happens when you enable it unconditionally,
> and then run various real loads along with things like "lmbench".

I'm running on it unconditionally now.  I'm still up though I haven't run 
really heavy stress tests.  I've had one bug report, curiously with the 
version keying on uid 9999 while *not* running as uid 9999.  This makes me 
think that there are some uninitialized page use counts on page tables 
somewhere in the system.

> Also, when you test forking over a parent, do you test just the fork, or
> do you test the "fork+wait" combination that waits for the child to exit
> too? The latter is the only really meaningful thing to test.

Will do.  Does this do the trick:

    wait();
    gettimeofday(&etime, NULL);

If so, it doesn't affect the timings at all, in other words I haven't just 
pushed the work into the child's exit.

> Anyway, the patch certainly looks pretty simple and small. Great.
> 
> > I haven't fully analyzed the locking yet, but I'm beginning to suspect it
> > just works as is, i.e., I haven't exposed any new critical regions.  I'd
> > be happy to be corrected on that though.
> 
> What's the protection against two different MM's doing a
> "zap_page_range()" concurrently, both thinking that they can just drop the
> page table directory entry, and neither actually freeing it? I don't see
> any such logic there..

Nothing prevents that, duh.

> I suspect that the only _good_ way to handle it is to do
> 
> 	pmd_page = ..
> 
> 	if (put_page_testzero(pmd_page)) {
> 		.. free the actual page table entries ..
> 		__free_pages_ok(pmd_page, 0);
> 	}
> 
> instead of using the free_page() logic. Maybe you do that already, I
> didn't go through the patches _that_ closely.

I do something similar in clear_page_tables->free_one_pmd, after the entries
are all gone.  I have to do something different in zap_page_range - it wants
to free the pmd only if the count is *greater* than one, and can't tolerate 
two mms thinking that at the same time.  I think I'd better lock the pmd page 
there.

> Ie you'd do a "two-phase" page free - first do the count handling, and if
> that indicates you should really free the pmd, you free the lower page
> tables before you physically free the pmd page (ie the page is "live" even
> though it has a count of zero).

Actually, I'm not freeing the pmd I'm freeing *pmd, a page table.  So, if the
count is > 1 it can be freed without doing anything to the ptes on it.  This
is the entire source of the speedup, by the way.

-- 
Daniel
