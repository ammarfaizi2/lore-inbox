Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266546AbRGYEiB>; Wed, 25 Jul 2001 00:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268469AbRGYEhw>; Wed, 25 Jul 2001 00:37:52 -0400
Received: from 216-60-128-137.ati.utexas.edu ([216.60.128.137]:32474 "HELO
	tsunami.webofficenow.com") by vger.kernel.org with SMTP
	id <S266546AbRGYEhm>; Wed, 25 Jul 2001 00:37:42 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@webofficenow.com>
Reply-To: landley@webofficenow.com
To: Daniel Phillips <phillips@bonn-fries.net>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: [RFC] Optimization for use-once pages
Date: Tue, 24 Jul 2001 15:35:21 -0400
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org, Ben LaHaise <bcrl@redhat.com>,
        Mike Galbraith <mikeg@wen-online.de>
In-Reply-To: <Pine.LNX.4.21.0107241750090.2263-100000@freak.distro.conectiva> <01072501092707.00520@starship>
In-Reply-To: <01072501092707.00520@starship>
MIME-Version: 1.0
Message-Id: <01072415352102.00631@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tuesday 24 July 2001 19:09, Daniel Phillips wrote:
> On Tuesday 24 July 2001 22:53, Marcelo Tosatti wrote:
> > On Tue, 24 Jul 2001, Rik van Riel wrote:
> > > On Tue, 24 Jul 2001, Marcelo Tosatti wrote:
> > > > On Tue, 24 Jul 2001, Daniel Phillips wrote:
> > > > > Today's patch tackles the use-once problem, that is, the
> > > > > problem of
> > > >
> > > > Well, as I see the patch should remove the problem where
> > > > drop_behind() deactivates pages of a readahead window even if
> > > > some of those pages are not "used-once" pages, right ?
> > > >
> > > > I just want to make sure the performance improvements you're
> > > > seeing caused by the fix of this _particular_ problem.
> > >
> > > Fully agreed.
> > >
> > > Especially since it was a one-liner change from worse
> > > performance to better performance (IIRC) it would be
> > > nice to see exactly WHY the system behaves the way it
> > > does.  ;)
> >
> > Yes.
> >
> > Daniel's patch adds "drop behind" (that is, adding swapcache
> > pages to the inactive dirty) behaviour to swapcache pages.
> >
> > This is a _new_ thing, and I would like to know how that is changing
> > the whole VM behaviour..
>
> Yes, absolutely.  I knew I was doing that but I also thought it wouldn't
> hurt.  Rather it's part of a transition towards a full unification of
> the file and swap paths.

Stupid question time:

So basically (lemme get this straight):

All VM allocation in 2.4 has become some variant of mmap.  Either we're 
mmaping in the executable and libraries when we exec, we're mmaping in a 
file, or we're mmaping in the swap file/block device which is how we do 
anonymous page allocations.

And this is why 2.4 keeps wanting to allocate swap space for pages that are 
still in core.  And why the 2.4 VM keeps going ballistic on boxes that have 
more physical DRAM than they have swap space.  (I.E. the 2X swap actually 
being NECESSARY now, and 256 megs of "overflow" swap files for a 2 gig ram 
box actually hurting matters by confusing the VM if swap is enabled AT ALL, 
since it clashes conceptually.)

So getting swap to exclude in-core pages (so they don't take up space in the 
swap file) would therefore be conceptually similar to implementing "files 
with holes in them" support like EXT2 has for these swap file mmaps.

And the argument that doing so might "fragment the swap file", while true, is 
actually a bit of a red herriing because the real objection is that it 
unnecessarily complicates an otherwise clean and straightforward concept.

Am I even close here?  (That was the stupid question I mentioned earlier, 
knew I'd get around to it...)  Reading the code's a bit harder when you don't 
have any sort of conceptual understanding of what the heck it's actually 
trying to do.

> Basically, I just left that part of it hanging.  If you check my
> detailed timings you'll see all my test runs have swaps=0, basically
> because I didn't really want to hear about it just then ;-)
>
> I was pretty sure it could be fixed if it broke.

Just thought I'd say that personally, I think your greatest contribution in 
this whole thread is that somebody finally clearly explained how the new VM 
works, using small words.  The actual improvements are just gravy.  Yes I'm 
biased.  :)

I don't suppose we could get some variant of your initial post into 
/Documentation/vm/HowItActuallyWorks.txt?  (I take it the biggest "detail" 
you glossed over was the seperation of memory into zones?)

> --
> Daniel

Rob
