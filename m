Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266641AbRGYHla>; Wed, 25 Jul 2001 03:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266647AbRGYHlL>; Wed, 25 Jul 2001 03:41:11 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:19467 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S266641AbRGYHlH>; Wed, 25 Jul 2001 03:41:07 -0400
Date: Wed, 25 Jul 2001 03:10:58 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Rob Landley <landley@webofficenow.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
        Ben LaHaise <bcrl@redhat.com>, Mike Galbraith <mikeg@wen-online.de>
Subject: Re: [RFC] Optimization for use-once pages
In-Reply-To: <01072415352102.00631@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0107250130400.2515-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing



On Tue, 24 Jul 2001, Rob Landley wrote:

> On Tuesday 24 July 2001 19:09, Daniel Phillips wrote:
> > On Tuesday 24 July 2001 22:53, Marcelo Tosatti wrote:
> > > On Tue, 24 Jul 2001, Rik van Riel wrote:
> > > > On Tue, 24 Jul 2001, Marcelo Tosatti wrote:
> > > > > On Tue, 24 Jul 2001, Daniel Phillips wrote:
> > > > > > Today's patch tackles the use-once problem, that is, the
> > > > > > problem of
> > > > >
> > > > > Well, as I see the patch should remove the problem where
> > > > > drop_behind() deactivates pages of a readahead window even if
> > > > > some of those pages are not "used-once" pages, right ?
> > > > >
> > > > > I just want to make sure the performance improvements you're
> > > > > seeing caused by the fix of this _particular_ problem.
> > > >
> > > > Fully agreed.
> > > >
> > > > Especially since it was a one-liner change from worse
> > > > performance to better performance (IIRC) it would be
> > > > nice to see exactly WHY the system behaves the way it
> > > > does.  ;)
> > >
> > > Yes.
> > >
> > > Daniel's patch adds "drop behind" (that is, adding swapcache
> > > pages to the inactive dirty) behaviour to swapcache pages.
> > >
> > > This is a _new_ thing, and I would like to know how that is changing
> > > the whole VM behaviour..
> >
> > Yes, absolutely.  I knew I was doing that but I also thought it wouldn't
> > hurt.  Rather it's part of a transition towards a full unification of
> > the file and swap paths.
> 
> Stupid question time:
> 
> So basically (lemme get this straight):
> 
> All VM allocation in 2.4 has become some variant of mmap.  
>
> Either we're mmaping in the executable and libraries when we exec,
> we're mmaping in a file, or we're mmaping in the swap file/block
> device which is how we do anonymous page allocations.
>
> 
> And this is why 2.4 keeps wanting to allocate swap space for pages that are 
> still in core.  And why the 2.4 VM keeps going ballistic on boxes that have 
> more physical DRAM than they have swap space.  (I.E. the 2X swap actually 
> being NECESSARY now, and 256 megs of "overflow" swap files for a 2 gig ram 
> box actually hurting matters by confusing the VM if swap is enabled AT ALL, 
> since it clashes conceptually.)

2.4 keeps wanting to allocate swap space for pages that are in core to be
able to add them to the LRU lists. That way we can get more detailed
information about the VM usage on the system.

When we run out of memory, we start looking linearly in all processes ptes
to find ptes which have not been used recently.  When we find one pte
which has not been used recently, we unmap it from the physical page.

For anonymous data, we have to unmap the pte and point it to some
"identifier" which can be used later (at page fault time) to find the
data. (wheter its still on memory or already swapped out to disk)

Currently this "identifier" is a value in the swap map. The swap map is a
_direct_ mapping to backing storage (swap space).

That means we cannot unmap a pte which points to anon data without
allocating swap space for the page first. 

We have added an aging scheme which gets detailed information about the
page usage, great! The problem is that we cannot get detailed anon page
usage info without having to allocate swap space. Result: 2xRAM swap rule
created.

Have you got the idea here ? 

That is not going to change on 2.4, I think. Sorry. 

> So getting swap to exclude in-core pages (so they don't take up space in the 
> swap file) would therefore be conceptually similar to implementing "files 
> with holes in them" support like EXT2 has for these swap file mmaps.

Not really. To exclude in-core pages (in-core meaning all pte's which
point to the in-mem page are mapped and valid) from swap we just need to
remove the page from swapcache. Its as simple as that, really.

However that will cause swap fragmentation. And lots of it.

> And the argument that doing so might "fragment the swap file", while true, is 
> actually a bit of a red herriing because the real objection is that it 
> unnecessarily complicates an otherwise clean and straightforward concept.

Nope. The "objections" for not deallocating in-core pages from swap (on
2.4) are:

- The code would need to avoid fragmentation. It would have to "unmap"
contiguous chunks of swap mappings as soon as swap started to get full.

Take into account that the swap clustering code we are using now was wrote
at the time we used to allocate swap space only when actually writing out
swap data: there was no need for the code to be fast.

- 2.4 is out. Fixing the problem in a performance-decent way would have to
change quite some code.


> Am I even close here?  (That was the stupid question I mentioned earlier, 
> knew I'd get around to it...)  Reading the code's a bit harder when you don't 
> have any sort of conceptual understanding of what the heck it's actually 
> trying to do.

Well, I think so.

> 
> > Basically, I just left that part of it hanging.  If you check my
> > detailed timings you'll see all my test runs have swaps=0, basically
> > because I didn't really want to hear about it just then ;-)
> >
> > I was pretty sure it could be fixed if it broke.
> 
> Just thought I'd say that personally, I think your greatest contribution in 
> this whole thread is that somebody finally clearly explained how the new VM 
> works, using small words.  The actual improvements are just gravy.  Yes I'm 
> biased.  :)
> 
> I don't suppose we could get some variant of your initial post into 
> /Documentation/vm/HowItActuallyWorks.txt?  (I take it the biggest "detail" 
> you glossed over was the seperation of memory into zones?)


Last comment:

Who the heck cares about good swapping performance when tasks are
getting killed because there is no more swap space available due to this
swap preallocation ? No one. 

It makes sense to fuck up swap clustering to avoid the OOM killer.

In case someone is having this problem with the OOM killer in practice
(real workloads), please tell us.

