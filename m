Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261269AbULMQdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbULMQdR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 11:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbULMQdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 11:33:17 -0500
Received: from mx1.redhat.com ([66.187.233.31]:29655 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261270AbULMQcm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 11:32:42 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20041210130137.432edacb.akpm@osdl.org> 
References: <20041210130137.432edacb.akpm@osdl.org>  <20041209141718.6acec9ee.akpm@osdl.org> <7ad0b24c-4955-11d9-8e19-0002b3163499@redhat.com> <200412082012.iB8KCTBK010123@warthog.cambridge.redhat.com> <30544.1102693553@redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: davidm@snapgear.com, gerg%snapgear.com.wli@holomorphy.com,
       linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: Re: [PATCH 2/5] NOMMU: High-order page management overhaul 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.3
Date: Mon, 13 Dec 2004 16:32:06 +0000
Message-ID: <13399.1102955526@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Morton <akpm@osdl.org> wrote:

> I think I was the original "use compound pages" culprit.

You were, but several other people have chimed in since.

> But when I realised that nommu needs access to fields in the sub-pages which
> are currently used for compound page metadata I withdrew into the "if what's
> there now works, stick with it" camp.

The nommu stuff only needs access to a flag or two (PG_compound or
PG_compound_slave) and the refcount. I don't believe that any of the stuff
that pins secondary pages for userspace's benefit cares about anything else.

And, apart from that, as far as kernel side code is concerned, high-order
pages should be dealt with as high-order pages, or they should be properly
split and used as arrays of pages.

> >  (2) Splitting high-order pages has to be done differently on MMU vs
> >      NOMMU.
> 
> Oh.  Why?

There are three cases of splitting that I can think of:

 (1) Split down to zero-order pages. I think this can be handled the same in
     both cases, since _every_ secondaty page needs reinitialisation.

     Note that I'm ignoring the case of a secondary page already being
     pinned. That is one case where the old way is superior _ASSUMING_ the
     counts on the secondary pages are incremented, not just set to 1.

     However, if a high-order page is being split after being exposed to
     userspace, the driver writer probably deserves everything they get:-)

 (2) Split down to smaller high-order pages. If a driver doing this just
     reinitialises the first page of every chunk, it'll probably be okay,
     _provided_ it doesn't touch the secondary pages. If it does do that - say
     by initialising the size to zero, the whole thing is likely to explode.

 (3) Splitting compound pages. Obviously, if a driver requests a compound
     page, it should be able to handle dissociation into lower-order compound
     pages or zero-order pages. I'd argue that the core kernel should provide
     a function to do this.

So, case (2) is potentially problematical.

> The current code (which pins each subpage individually) seems robust
> enough.

Maybe.

> I assume that nommu will thenceforth simply treat the region as an
> array of zero-order pages.

That depends what you mean by "nommu". It's actually the common bits that
thenceforth treat high-order pages as individual pages, be they compound pages
from hugetlbfs, single pages from the page cache or high-order pages from the
slab allocator or alloc_pages().

> >  (5) Abstraction of some compound page related functions, including a way to
> >      make it more efficient to access the first page (PG_compound_slave).
> 
> If there is any way at all in which we can avoid consuming another page
> flag then we should do so.  There are various concepts (many zones,
> advanced page aging algorithms) which would be unfeasible if there are not
> several more bits available in ->flags.   And they continue to dribble away.

There is. We can move the current occupant of the compound-second struct
page's mapping into page[1].lru and stick a unique magic value in there.

	[mm/page_alloc.c]
	const char compound_page_slave_magic[4];

	[include/linux/mm.h]
	extern const char compound_page_slave_magic[];
	#define COMPOUND_PAGE_SLAVE_MAGIC \
		((struct address space *) &compound_page_slave[3])

	#define PageCompoundSlave(page) \
		((page)->mapping == COMPOUND_PAGE_SLAVE_MAGIC)

	#define SetPageCompoundSlave(page) \
	do { \
		BUG_ON((page)->mapping); \
		(page)->mapping = COMPOUND_PAGE_SLAVE_MAGIC; \
	} while(0)

	#define ClearPageCompoundSlave(page) \
	do { \
		BUG_ON(!PageCompoundSlave(page)); \
		(page)->mapping = NULL; \
	} while(0)

This would have a useful property of causing a misalignment exception
(assuming it's not the i386 arch) if someone tries to access the mapping.

Andrew Morton <akpm@osdl.org> wrote:

> But there's nothing actually *essential* here, is there?  No bugs are
> fixed?

Well, I feel it's more robust. I can't say that it _definitely_ fixes any
bugs, but I can see how they could happen.

> > I think the drivers need a good auditing too. A lot of them allocate
> > high-order pages for various uses, some for use as single units, and some
> > for use as arrays of pages.
> 
> I think an ARM driver is freeing zero-order pages within a higher-order
> page.  But as long as the driver didn't set __GFP_COMP then the higher
> order page is not compound, and that splitting treatment is appropriate.

I'd changed my patch to honour __GFP_COMP. However, such driver should
probably be changed to call a splitting function in mm/page_alloc.c. This sort
of thing is definitely the territory of the master mm routines.

It might be worth adding a new allocator routine that takes arguments along
the lines of calloc() - so that you ask for 2^N pages of 2^M size. This would
allow the allocator to initialise everything correctly up front.

David
