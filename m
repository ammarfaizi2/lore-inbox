Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263142AbUCMRxZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 12:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263143AbUCMRxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 12:53:25 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:4361
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263142AbUCMRxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 12:53:23 -0500
Date: Sat, 13 Mar 2004 18:54:06 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@redhat.com>
Cc: Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: anon_vma RFC2
Message-ID: <20040313175406.GK30940@dualathlon.random>
References: <Pine.LNX.4.44.0403131653010.3585-100000@localhost.localdomain> <Pine.LNX.4.44.0403131227210.15971-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403131227210.15971-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2004 at 12:28:31PM -0500, Rik van Riel wrote:
> On Sat, 13 Mar 2004, Hugh Dickins wrote:
> > On Sat, 13 Mar 2004, Linus Torvalds wrote:
> 
> > > 	if (PageAnonymous(page) && page->count > 1) {
> > > 		newpage = alloc_page();
> > > 		copy_page(page, newpage);
> > > 		page = newpage;
> > > 	}
> > > 	/* Move the page to the new address */
> > > 	page->index = address >> PAGE_SHIFT;
> > > 
> > > and now we have zero special cases.
> > 
> > That's always been a fallback solution, I was just a little too ashamed
> > to propose it originally - seems a little wrong to waste whole pages
> > rather than wasting a few bytes of data structure trying to track them:
> > though the pages are pageable unlike any data structure we come up with.
> 
> No, Linus is right.
> 
> If a child process uses mremap(), it stands to reason that
> it's about to use those pages for something.
> 
> Think of it as taking the COW faults early, because chances
> are you'd be taking them anyway, just a little bit later...

using mremap to _move_ anonymous maps is simply not frequent. It's so
unfrequent that it's hard to tell if the child is going to _read_ or to
_write_. Using those pages means nothing, all it matters is if it will
use those pages from reading or for writing, and I don't see how you can
assume it's going to write to them and how can you assume this is an
early-COW in the common case.

the only interesting point to me is that it's non frequent, with that I
certainly agreee, but I don't see this as an early-COW.

What worries me most are things like kde, they used the library design
with the only object of sharing readonly anonymous pages, that's very
smart since it still avoids one bug in one app to take down the whole
GUI, but if they happen to use mremap to move those readonly page around
after the for we'll screw them completely. I've no indication that this
may be the case and if they ever call mrmap, but I cannot tell the
opposite either.
