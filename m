Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbVFCNGI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbVFCNGI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 09:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVFCNGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 09:06:07 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:12224 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261252AbVFCNFw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 09:05:52 -0400
Date: Fri, 3 Jun 2005 14:05:47 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: jschopp@austin.ibm.com, "Martin J. Bligh" <mbligh@mbligh.org>,
       linux-mm@kvack.org, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Avoiding external fragmentation with a placement policy Version
 12
In-Reply-To: <1117770488.5084.25.camel@npiggin-nld.site>
Message-ID: <Pine.LNX.4.58.0506031349280.10779@skynet>
References: <20050531112048.D2511E57A@skynet.csn.ul.ie>  <429E20B6.2000907@austin.ibm.com>
 <429E4023.2010308@yahoo.com.au>  <423970000.1117668514@flay>
 <429E483D.8010106@yahoo.com.au>  <434510000.1117670555@flay>
 <429E50B8.1060405@yahoo.com.au>  <429F2B26.9070509@austin.ibm.com>
 <1117770488.5084.25.camel@npiggin-nld.site>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Jun 2005, Nick Piggin wrote:

> On Thu, 2005-06-02 at 10:52 -0500, Joel Schopp wrote:
> > > I see your point... Mel's patch has failure cases though.
> > > For example, someone turns swap off, or mlocks some memory
> > > (I guess we then add the page migration defrag patch and
> > > problem is solved?).
> >
> > This reminds me that page migration defrag will be pretty useless
> > without something like this done first.  There will be stuff that can't
> > be migrated and it needs to be grouped together somehow.
> >
> > In summary here are the reasons I see to run with Mel's patch:
> >
> > 1. It really helps with medium-large allocations under memory pressure.
> > 2. Page migration defrag will need it.
> > 3. Memory hotplug remove will need it.
> >
>
> I guess I'm now more convinced of its need ;)
>
> add:
> 4. large pages
> 5. (hopefully) helps with smaller allocations (ie. order 3)
>

6. Avoid calls to the page allocator

If a subsystem needs 8 pages to do a job, it should only have to call the
allocator once, not 8 times only to spend more time breaking the work up
into page-sized chunks.

If you look at rmqueue_bulk() in the patch, you'll see that it tries to
fill the per-cpu lists of order-0 pages with one call to the allocator
which saved some time. The additional statistics patch shows how many of
these bulk requests are made and what sizes were actually allocated. It
shows that a sizable number of additional calls to the buddy allocator are
avoided.

> It would really help your cause in the short term if you can
> demonstrate improvements for say order-3 allocations (eg. use
> gige networking, TSO, jumbo frames, etc).
>

I will work on this early next week unless someone else does not beat me
to it. Right now, I need to catch a flight and I'll be offline for a few
days.

Once I start, I'm going to be running tests on network filesystems mounted
on the loopback device to see what sort of results I find.

>
> > On the downside we have:
> >
> > 1. Slightly more complexity in the allocator.
> >
>
> For some definitions of 'slightly', perhaps :(
>

Does it need more documentation? If so, I'll write up a detailed blurb on
how it works and drop it into Documentation/

> Although I can't argue that a buddy allocator is no good without
> being able to satisfy higher order allocations.
>

Unfortunately, it is a fundemental flaw of the buddy allocator that it
fragments badly. The thing is, other allocators that do not fragment are
also slower.

> So in that case, I'm personally OK with it going into -mm. Hopefully
> there will be a bit more review and hopefully some simplification if
> possible.
>

Fingers crossed. I would be very interested to see anything that makes it
simplier.

> Last question: how does it go on systems with really tiny memories?
> (4MB, 8MB, that kind of thing).
>

I tested it with mem=16M (anything lower and my machine doesn't boot the
standard kernel with going OOM, let alone the patched one). There was no
significant change in performance of the aim9 benchmarks. The additional
memory overhead of the patch is insignificant.

However, at low memory, the fragmentation strategy does not work unless
MAX_ORDER is also dropped. As the block reservations are 2^MAX_ORDER in
size, there is no point reserving anything if the system only has 4
MAX_ORDER blocks to being with.

-- 
Mel Gorman
Part-time Phd Student                          Java Applications Developer
University of Limerick                         IBM Dublin Software Lab
