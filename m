Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030484AbVKCVLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030484AbVKCVLG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 16:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030485AbVKCVLF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 16:11:05 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:31910 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1030484AbVKCVLE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 16:11:04 -0500
Date: Thu, 3 Nov 2005 21:11:00 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Linus Torvalds <torvalds@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Dave Hansen <haveblue@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, kravetz@us.ibm.com,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>,
       Arjan van de Ven <arjanv@infradead.org>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
In-Reply-To: <Pine.LNX.4.64.0511031006550.27915@g5.osdl.org>
Message-ID: <Pine.LNX.4.58.0511032047210.9172@skynet>
References: <4366C559.5090504@yahoo.com.au> 
 <Pine.LNX.4.58.0511010137020.29390@skynet><4366D469.2010202@yahoo.com.au> 
 <Pine.LNX.4.58.0511011014060.14884@skynet><20051101135651.GA8502@elte.hu> 
 <1130854224.14475.60.camel@localhost><20051101142959.GA9272@elte.hu> 
 <1130856555.14475.77.camel@localhost><20051101150142.GA10636@elte.hu> 
 <1130858580.14475.98.camel@localhost><20051102084946.GA3930@elte.hu> 
 <436880B8.1050207@yahoo.com.au><1130923969.15627.11.camel@localhost> 
 <43688B74.20002@yahoo.com.au><255360000.1130943722@[10.10.2.4]> 
 <4369824E.2020407@yahoo.com.au> <1131040786.2839.18.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.64.0511031006550.27915@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Nov 2005, Linus Torvalds wrote:

> On Thu, 3 Nov 2005, Arjan van de Ven wrote:
>
> > On Thu, 2005-11-03 at 09:51 -0800, Martin J. Bligh wrote:
> >
> > > For amusement, let me put in some tritely oversimplified math. For the
> > > sake of arguement, assume the free watermarks are 8MB or so. Let's assume
> > > a clean 64-bit system with no zone issues, etc (ie all one zone). 4K pages.
> > > I'm going to assume random distribution of free pages, which is
> > > oversimplified, but I'm trying to demonstrate a general premise, not get
> > > accurate numbers.
> >
> > that is VERY over simplified though, given the anti-fragmentation
> > property of buddy algorithm
>

The statistical properties of the buddy system are a nightmare. There is a
paper called "Statistical Properties of the Buddy System" which is a whole
pile of no fun to read. It's because of the difficulty to analyse
fragmentation offline that bench-stresshighalloc was written to see how
well anti-defrag would do.

> Indeed. I write a program at one time doing random allocation and
> de-allocation and looking at what the output was, and buddy is very good
> at avoiding fragmentation.
>

The worse cause of fragmentation I found were kernel caches that were long
lived.  How fragmenting the workload is depended heavily on whether things
like updatedb happened which is why bench-stresshighalloc deliberately ran
it. It's also why anti-defrag tries to group inodes and buffer_heads into
the same areas in memory separate from other
persumed-to-be-even-longer-lived kernel allocations. The assumption is if
the buffer, inode and dcaches are all shrunk, contiguous blocks will
appear.

You're also right on the size of the watermarks for zones and how it
affects fragmentation. A serious problem I had with anti-defrag was when
87.5% of memory is in use. At this point, a "fallback" area is used by any
allocation type that has no pages of it's own. When it is depleted, real
fragmentation starts happening and it's also about here that the high
watermark for reclaiming starts. I wanted to increase the watermarks up to
start reclaiming pages when the "fallback" area started getting used but
didn't think I would get away with adjusting those figures. I could have
cheated and set it via /proc before benchmarks but didn't to avoid "magic
test system" syndrome.

> These days we have things like per-cpu lists in front of the buddy
> allocator that will make fragmentation somewhat higher, but it's still
> absolutely true that the page allocation layout is _not_ random.
>

It's worse than somewhat higher for the per-cpu pages. Using another set
of patches on top of an earlier version of anti-defrag, I was about to
allocate about 75% of physical memory in pinned 4MiB chunks of memory
under loads of 15-20 (kernel builds). To get there, per-cpu pages had to
be drained using an IPI call because for some perverse reason, there were
always 2 or 3 free per-cpu pages in the middle of a 1024 block of pages.

Basically, I don't we have to live with fragmentation in the page
allocator. I think it can be pushed down a whole lot without taking a
performance hit for the 99.99% of users that don't care about this sort of
thing.

-- 
Mel Gorman
Part-time Phd Student                          Java Applications Developer
University of Limerick                         IBM Dublin Software Lab
