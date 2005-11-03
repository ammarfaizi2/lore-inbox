Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932591AbVKCGIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932591AbVKCGIj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 01:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932708AbVKCGIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 01:08:39 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:7061 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP id S932692AbVKCGIi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 01:08:38 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Date: Thu, 3 Nov 2005 00:07:33 -0600
User-Agent: KMail/1.8
Cc: Gerrit Huizenga <gh@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Dave Hansen <haveblue@us.ibm.com>, Mel Gorman <mel@csn.ul.ie>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>
References: <E1EXEfW-0005ON-00@w-gerrit.beaverton.ibm.com> <200511021747.45599.rob@landley.net> <43699573.4070301@yahoo.com.au>
In-Reply-To: <43699573.4070301@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511030007.34285.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 November 2005 22:43, Nick Piggin wrote:
> Rob Landley wrote:
> > In the UML case, I want the system to automatically be able to hand back
> > any sufficiently large chunks of memory it currently isn't using.
>
> I'd just be happy with UML handing back page sized chunks of memory that
> it isn't currently using. How does contiguous memory (in either the host
> or the guest) help this?

Smaller chunks of memory are likely to be reclaimed really soon, and adding in 
the syscall overhead working with individual pages of memory is almost 
guaranteed to slow us down.  Plus with punch, we'd be fragmenting the heck 
out of the underlying file.

> > What does this have to do with specifying hard limits of anything? 
> > What's to specify?  Workloads vary.  Deal with it.
>
> Umm, if you hadn't bothered to read the thread then I won't go through
> it all again. The short of it is that if you want guaranteed unfragmented
> memory you have to specify a limit.

I read it.  It just didn't contain an answer the the question.  I want UML to 
be able to hand back however much memory it's not using, but handing back 
individual pages as we free them and inserting a syscall overhead for every 
page freed and allocated is just nuts.  (Plus, at page size, the OS isn't 
likely to zero them much faster than we can ourselves even without the 
syscall overhead.)  Defragmentation means we can batch this into a 
granularity that makes it worth it.

This has nothing to do with hard limits on anything.

> Have you looked at the frag patches?

I've read Mel's various descriptions, and tried to stay more or less up to 
date ever since LWN brought it to my attention.  But I can't say I'm a linux 
VM system expert.  (The last time I felt I had a really firm grasp on it was 
before Andrea and Rik started arguing circa 2.4 and Andrea spent six months 
just assuming everybody already knew what a classzone was.  I've had other 
things to do since then...)

> Do you realise that they have to 
> balance between the different types of memory blocks?

I realise they merge them back together into larger chunks as they free up 
space, and split larger chunks when they haven't got a smaller one.

> Duplicating the 
> same or similar infrastructure (in this case, a memory zoning facility)
> is a bad thing in general.

Even when they keep track of very different things?  The memory zoning thing 
is about where stuff is in physical memory, and it exists because various 
hardware that wants to access memory (24 bit DMA, 32 bit DMA, and PAE) is 
evil and crippled and we have to humor it by not asking it to do stuff it 
can't.

The fragmentation stuff is about what long contiguous runs of free memory we 
can arrange, and it's also nice to be able to categorize them as "zeroed" or 
"not zeroed" to make new allocations faster.  Where they actually are in 
memory is not at issue here.

You can have prezeroed memory in 32 bit DMA space, and prezeroed memory in 
highmem, but there's memory in both that isn't prezeroed.  I thought there 
was a hierarchy of zones.  You want overlapping, interlaced, randomly laid 
out zones.

> >>[*] and there are, sadly enough - see the recent patches I posted to
> >>     lkml for example.
> >
> > I was under the impression that zone balancing is, conceptually speaking,
> > a difficult problem.
>
> I am under the impression that you think proper fragmentation avoidance
> is easier.

I was under the impression it was orthogonal to figuring out whether or not a 
given bank of physical memory is accessable to your sound blaster without an 
IOMMU.

> >>     But I'm fairly confident that once the particularly
> >>     silly ones have been fixed,
> >
> > Great, you're advocating migrating the fragmentation patches to an area
> > of code that has known problems you yourself describe as "particularly
> > silly". A ringing endorsement, that.
>
> Err, the point is so we don't now have 2 layers doing very similar things,
> at least one of which has "particularly silly" bugs in it.

Similar is not identical.  You seem to be implying that the IO elevator and 
the network stack queueing should be merged because they do similar things.

> > The fact that the migrated version wouldn't even address fragmentation
> > avoidance at all (the topic of this thread!) is apparently a side issue.
>
> Zones can be used to guaranteee physically contiguous regions with exactly
> the same effectiveness as the frag patches.

If you'd like to write a counter-patch to Mel's to prove it...

> >>     zone balancing will no longer be a
> >>     derogatory term as has been thrown around (maybe rightly) in this
> >>     thread!
> >
> > If I'm not mistaken, you introduced zones into this thread, you are the
> > primary (possibly only) proponent of them.
>
> So you didn't look at Yasunori Goto's patch from last year that implements
> exactly what I described, then?

I saw the patch he just posted, if that's what you mean.  By his own 
admission, it doesn't address fragmentation at all.

> > Yes, zones are a way of categorizing memory.
>
> Yes, have you read Mel's patches? Guess what they do?

The swap file is a way of storing data on disk.  So is ext3.  Obviously, one 
is a trivial extension of the other and there's no reason to have both.

> > They're not a way of defragmenting it.
>
> Guess what they don't?

I have no idea what you intended to mean by that.  Mel posted a set of patches 
in a thread titled "fragmentation avoidance", and you've been arguing about 
hotplug, and pointing to a set of patches from Goto that do not address 
fragmentation at all.  This confuses me.

Rob
