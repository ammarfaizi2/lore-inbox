Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313613AbSD3PIi>; Tue, 30 Apr 2002 11:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313628AbSD3PIh>; Tue, 30 Apr 2002 11:08:37 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:24540 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S313613AbSD3PIg>;
	Tue, 30 Apr 2002 11:08:36 -0400
Date: Tue, 30 Apr 2002 20:38:14 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, marcelo@brutus.conectiva.com.br,
        linux-mm@kvack.org
Subject: Re: [PATCH]Fix: Init page count for all pages during higher order allocs
Message-ID: <20020430203814.A2064@in.ibm.com>
Reply-To: suparna@in.ibm.com
In-Reply-To: <20020429202446.A2326@in.ibm.com> <m1r8ky1jzu.fsf@frodo.biederman.org> <20020430110108.A1275@in.ibm.com> <m1it691dtl.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2002 at 08:05:58AM -0600, Eric W. Biederman wrote:
> Suparna Bhattacharya <suparna@in.ibm.com> writes:
> 
> > On Mon, Apr 29, 2002 at 11:40:21AM -0600, Eric W. Biederman wrote:
> > > Suparna Bhattacharya <suparna@in.ibm.com> writes:
> > > 
> > > > The call to set_page_count(page, 1) in page_alloc.c appears to happen 
> > > > only for the first page, for order 1 and higher allocations.
> > > > This leaves the count for the rest of the pages in that block 
> > > > uninitialised.
> > > 
> > > Actually it should be zero.
> > > 
> > > This is deliberate because high order pages should not be referenced by
> > > their partial pages.  
> > 
> > That sounds reasonable provided there is a way to identify the main 
> > page struct corresponding to an area that's part of a higher 
> > order page. 
> 
> Reasonable.  For a crash dump you are doing a physical scan through
> the struct pages correct?

Yes. 

> 
> Actually I have a stupid question.  Given the fact that the kernel keeps
> most pages in active use why is it worth checking for which pages are not
> used?

You mean slabs, mempools etc will cause pages to be in active use ? Or
you mean that page cache will be filled up if there's lots of memory ?
That probably depends on the load on the system ... if you have a 
large memory system that's not heavily loaded, then don't we expect
lots of inactive pages ?


>  
> > > It might make sense to add a PG_large flag and
> > > then in the immediately following struct page add a pointer to the next
> > > page, so you can identify these pages by inspection.  Doing something
> > > similar to the PG_skip flag.
> > 
> > Maybe different solutions could emerge for this in 2.4 and 2.5. 
> > 
> > Even a PG_partial flag for the partial pages will enable us to
> > traverse back to the main page, and vice-versa to determine the
> > partial pages covered by the main page, without any additional
> > pointers. Is that an acceptable option for 2.4 ? (That's one
> > more page flag ...)
> > 
> > It would be good to have a way to determine the order directly
> > from the page struct, without such traversals, at least in 2.5. 
> 
> It is important the page struct be kept small.  Especially for very rarely
> used features.  I can see dedicating a bit that says get all of the information
> out of the next struct page that is totally unused.  And as part of freeing
> the page the first thing we do is clear that bit.  But I can't see a justification
> for putting any more in the primary struct page.
> 
> > > 
> > > Beyond that I get nervous, that people will treat it as endorsement of
> > > doing a high order continuous allocation and then fragmenting the page.
> > 
> > I don't think it would amount to such an endorsement. It's just a matter
> > of replicating the settings from the main page to the partial pages - 
> > which might be considered an alternate protocol, though a little 
> > inefficient for really high orders. However, having the partial page 
> > counts zeroed out probably helps as a safeguard in some situations in
> > view of the page count sanity checks. Or are there any scenarios where 
> > you forsee a problem/breakage ?
> 
> Using the count on the unused page structs implies you can use them
> independently.  The page count is only accurate on the initial page
> struct.  The one that is used.

Depends on the way we look at it, and how we define the policy.
True, the page count is only accurate for the initial page struct in
terms of determining the number of references to the page, post allocation.
For the other pages, page count is only an indicator of whether it is
in use or not - the only user is the allocator, and the allocator will
only release them when the main page is released. No one else is
supposed to be using/holding those page structs directly.

To make any decisions about reference counting of the page etc, one 
should be looking at the first one, and nothing prevents that. 

> 
> Eric
