Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030320AbVKCQ1a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030320AbVKCQ1a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 11:27:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030375AbVKCQ1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 11:27:30 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:150 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1030320AbVKCQ13 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 11:27:29 -0500
Date: Thu, 3 Nov 2005 16:27:18 +0000 (GMT)
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
In-Reply-To: <Pine.LNX.4.64.0511030747450.27915@g5.osdl.org>
Message-ID: <Pine.LNX.4.58.0511031613560.3571@skynet>
References: <4366C559.5090504@yahoo.com.au>  <Pine.LNX.4.58.0511010137020.29390@skynet>
 <4366D469.2010202@yahoo.com.au>  <Pine.LNX.4.58.0511011014060.14884@skynet>
 <20051101135651.GA8502@elte.hu>  <1130854224.14475.60.camel@localhost>
 <20051101142959.GA9272@elte.hu>  <1130856555.14475.77.camel@localhost>
 <20051101150142.GA10636@elte.hu>  <1130858580.14475.98.camel@localhost>
 <20051102084946.GA3930@elte.hu>  <436880B8.1050207@yahoo.com.au>
 <1130923969.15627.11.camel@localhost>  <43688B74.20002@yahoo.com.au>
 <255360000.1130943722@[10.10.2.4]>  <4369824E.2020407@yahoo.com.au> 
 <306020000.1131032193@[10.10.2.4]> <1131032422.2839.8.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.64.0511030747450.27915@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Nov 2005, Linus Torvalds wrote:

>
>
> On Thu, 3 Nov 2005, Arjan van de Ven wrote:
>
> > On Thu, 2005-11-03 at 07:36 -0800, Martin J. Bligh wrote:
> > > >> Can we quit coming up with specialist hacks for hotplug, and try to solve
> > > >> the generic problem please? hotplug is NOT the only issue here. Fragmentation
> > > >> in general is.
> > > >>
> > > >
> > > > Not really it isn't. There have been a few cases (e1000 being the main
> > > > one, and is fixed upstream) where fragmentation in general is a problem.
> > > > But mostly it is not.
> > >
> > > Sigh. OK, tell me how you're going to fix kernel stacks > 4K please.
> >
> > with CONFIG_4KSTACKS :)
>
> 2-page allocations are _not_ a problem.
>
> Especially not for fork()/clone(). If you don't even have 2-page
> contiguous areas, you are doing something _wrong_, or you're so low on
> memory that there's no point in forking any more.
>
> Don't confuse "fragmentation" with "perfectly spread out page
> allocations".
>
> Fragmentation means that it gets _exponentially_ more unlikely that you
> can allocate big contiguous areas. But contiguous areas of order 1 are
> very very likely indeed. It's only the _big_ areas that aren't going to
> happen.
>

For me, it's the big areas that I am interested in, especially if we want
to give HugeTLB pages to a user when they are asking for them. The obvious
one here is database and HPC loads, particularly the HPC loads which may
not have had a chance to reserve what they needed at boot time. These
loads need 1024 contiguous pages on the x86 at least, not 2. We can free
all we want on todays kernels and you're not going to get more than 1 or
two blocks this large unless you are very lucky.

Hotplug is, for me, an additional benefit. For others, it is the main
benefit. For others of course, they don't care, but others don't are about
scalability to 64 processors either but we provide it anyway at a low cost
to smaller machines.

> This is why fragmentation avoidance has always been totally useless. It is
>  - only useful for big areas
>  - very hard for big areas
>
> (Corollary: when it's easy and possible, it's not useful).
>

Unless you are a user that wants a large area when it suddenly is useful.

> Don't do it. We've never done it, and we've been fine. Claiming that
> fork() is a reason to do fragmentation avoidance is invalid.
>

We've never done it but, but we've only supported HugeTLB pages being
reserved at boot time and nothing else as well.

I'm going to setup a kbuild environment, hopefully this evening, and see
are these patches adversely impacting a load that kernel developers care
about. If I am impacting it, oops I'm in some trouble. If I'm not, then
why not try and help out the people who care about the big areas.

-- 
Mel Gorman
Part-time Phd Student                          Java Applications Developer
University of Limerick                         IBM Dublin Software Lab
