Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263141AbUCMRsA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 12:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263142AbUCMRsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 12:48:00 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:265
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263141AbUCMRr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 12:47:58 -0500
Date: Sat, 13 Mar 2004 18:48:40 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Rik van Riel <riel@redhat.com>,
       William Lee Irwin III <wli@holomorphy.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: anon_vma RFC2
Message-ID: <20040313174840.GJ30940@dualathlon.random>
References: <Pine.LNX.4.58.0403130759150.1045@ppc970.osdl.org> <Pine.LNX.4.44.0403131653010.3585-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403131653010.3585-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2004 at 05:24:12PM +0000, Hugh Dickins wrote:
> On Sat, 13 Mar 2004, Linus Torvalds wrote:
> > 
> > Ok, guys,
> >  how about this anon-page suggestion?
> 
> What you describe is pretty much exactly what my anobjrmap patch
> from a year ago did.  I'm currently looking through that again

it is. Linus simply provided a solution to the mremap issue, that is to
make it impossible to share anonymous pages through an mremap, that
solves the problem indeed at some cpu and memory cost after an mremap.

I realized you could solve it also by walking the whole list of vmas in
every mm->mmap list but that complexity would be way too high.

> > The only problem is mremap() after a fork(), and hell, we know that's a
> > special case anyway, and let's just add a few lines to copy_one_pte(),
> > which basically does:
> > 
> > 	if (PageAnonymous(page) && page->count > 1) {
> > 		newpage = alloc_page();
> > 		copy_page(page, newpage);
> > 		page = newpage;
> > 	}
> > 	/* Move the page to the new address */
> > 	page->index = address >> PAGE_SHIFT;
> > 
> > and now we have zero special cases.
> 
> That's always been a fallback solution, I was just a little too ashamed
> to propose it originally - seems a little wrong to waste whole pages
> rather than wasting a few bytes of data structure trying to track them:
> though the pages are pageable unlike any data structure we come up with.
> 
> I think we have page_table_lock in copy_one_pte, so won't want to do
> it quite like that.  It won't matter at all if pages are transiently
> untrackable.  Might want to do something like make_pages_present
> afterwards (but it should only be COWing instantiated pages; and
> does need to COW pages currently on swap too).
> 
> There's probably an issue with Alan's strict commit memory accounting,
> if the mapping is readonly; but so long as we get that counting right,
> I don't think it's really going to matter at all if we sometimes fail
> an mremap for that reason - but probably need to avoid mistaking the
> common case (mremap of own area) for the rare case which needs this
> copying (mremap of inherited area).

It still looks like quite an hack to me, though I must agree in a
desktop scenario with swapoff -a, it will save around 24 bytes per
anonymous vma and 12 bytes per file vma plus it doesn't restrict the vma
merging in any way, compared to my anon_vma, and it avoids me to worry
about people doing a flood of vma_splits that will generate a long list
of vmas for every anon_vma.

I still feel anon_vma is more preferable than
anonmm+linus-unshare-mremap if one needs to swap, and while the
prio_tree on i_mmap{shared} in practice is needed only for 32bit apps, I
know some app with hundred of processes allocating huge chunks of direct
anon memory each and swapping a lot at the same time.
