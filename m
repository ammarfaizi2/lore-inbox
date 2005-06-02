Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261409AbVFBNz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbVFBNz6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 09:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261415AbVFBNz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 09:55:58 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:35249 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261409AbVFBNzk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 09:55:40 -0400
Date: Thu, 2 Jun 2005 14:55:37 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>, jschopp@austin.ibm.com,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Avoiding external fragmentation with a placement policy Version
 12
In-Reply-To: <429E50B8.1060405@yahoo.com.au>
Message-ID: <Pine.LNX.4.58.0506021420130.8617@skynet>
References: <20050531112048.D2511E57A@skynet.csn.ul.ie> <429E20B6.2000907@austin.ibm.com>
 <429E4023.2010308@yahoo.com.au> <423970000.1117668514@flay>
 <429E483D.8010106@yahoo.com.au> <434510000.1117670555@flay>
 <429E50B8.1060405@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jun 2005, Nick Piggin wrote:

> Martin J. Bligh wrote:
>
> > There's one example ... we can probably work around it if we try hard
> > enough. However, the fundamental question becomes "do we support higher
> > order allocs, or not?". If not fine ... but we ought to quit pretending
> > we do. If so, then we need to make them more reliable.
> >
>
> It appears that we basically support order 3 allocations and
> less (those will stay in the page allocator until something
> happens).
>

That would appear to be the case. I'd like to run a few tests that require
order-3 allocations a lot. My current thinking is that running stress
tests over a CIFS filesystem may do the job. I'm open to suggestions.

> I see your point... Mel's patch has failure cases though.
> For example, someone turns swap off, or mlocks some memory
> (I guess we then add the page migration defrag patch and
> problem is solved?).
>

If swap is turned off, it will not work as well. However, buffer pages are
grouped together with anonymous pages so we might not get MAX_ORDER
allocations succeeding, but I think it the order-3 to 5 allocations would
still have a higher success rate.  If we found that no-swap was a common
scenario, we could teach the patch to treat anonymous userspace pages as
KERNNORCLM rather than USERRCLM. The ordinary file-backed pages would then
be freeable for the high order allocations. mlock() is a case I have not
thought about at all.

These cases would be addressed by page migration but page migration is a
lot more complex than this lower fragmentation patch.

> I do see your point. The extra complexity makes me cringe though
> (no offence to Mel - I'm sure it is a complex problem).
>

No offence taken, I had trouble keeping the performance of this patch
comparable to the normal allocator and the patch is large for a problem
that seems so straight-forward. Despite the additional complexity, the
performance is still comparable (sometimes it runs faster, other times
slower). It is only when memory is running low that the additional lists
that were introduced have to be searched.

> > > Yeah more or less. But with the fragmentation patch, it by
> > > no means becomes an exact science ;) I wouldn't have thought
> > > it would make it hugely easier to free an order 2 or 3 area
> > > memory block on a loaded machine.
> >
> >
> > Ummm. so the blunderbuss is an exact science? ;-) At least it fairly
> > consistently doesn't work, I suppose ;-) ;-)
> >
>
> No but I was just saying it is just another degree of
> "unsuportedness" (or supportedness, if you are a half full man).
>

Again, I would assert that our Supported-ness is better with this patch
than without it. If we wanted to really support high-order allocations, we
would also need to be able to free pages in adjacent physical pages, not
just LRU ordering.

> > > Why not just have kernel allocations going from the bottom
> > > up, and user allocations going from the top down. That would
> > > get you most of the way there, wouldn't it? (disclaimer: I
> > > could well be talking shit here).
> >
> >
> > Not sure it's quite that simple, though I haven't looked in detail
> > at these patches. My point was merely that we need to do *something*.
> > Off the top of my head ... what happens when kernel meets user in
> > the middle. where do we free and allocate from now ? ;-) Once we've
> > been up for a while, mem is nearly all used, nearly all of the time.
> >
>
> No, I'm quite sure it isn't that simple, unfortunately. Hence
> disclaimer ;)
>

It isn't that simple :(. This was my first solution and one I dropped
after a while. Under a stress test, the two areas meet and fragmentation
is as bad as it ever was. It would only delay the problem, not fix it.
Even if there is a shared zone in the middle that both can use, it will
fill.

I ran a stress test over large periods of time with this patch and it
managed to consistently keep fragmentation down. In fact, the introduction
of the fallback reserve was to address the problem of slowly fragmenting
over long periods of time

> > Is a good discussion to have though ;-)
> >
>
> Yep, I was trying to help get something going!
> Send instant messages to your online friends http://au.messenger.yahoo.com

-- 
Mel Gorman
Part-time Phd Student                          Java Applications Developer
University of Limerick                         IBM Dublin Software Lab
