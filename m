Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030395AbVKCRy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030395AbVKCRy5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 12:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030399AbVKCRy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 12:54:57 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:28126
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1030395AbVKCRy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 12:54:57 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Date: Thu, 3 Nov 2005 11:54:10 -0600
User-Agent: KMail/1.8
Cc: Gerrit Huizenga <gh@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Dave Hansen <haveblue@us.ibm.com>, Mel Gorman <mel@csn.ul.ie>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>
References: <E1EXEfW-0005ON-00@w-gerrit.beaverton.ibm.com> <200511030007.34285.rob@landley.net> <4369BD7D.6050507@yahoo.com.au>
In-Reply-To: <4369BD7D.6050507@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511031154.11219.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 November 2005 01:34, Nick Piggin wrote:
> Rob Landley wrote:
> > On Wednesday 02 November 2005 22:43, Nick Piggin wrote:
> >>I'd just be happy with UML handing back page sized chunks of memory that
> >>it isn't currently using. How does contiguous memory (in either the host
> >>or the guest) help this?
> >
> > Smaller chunks of memory are likely to be reclaimed really soon, and
> > adding in the syscall overhead working with individual pages of memory is
> > almost guaranteed to slow us down.
>
> Because UML doesn't already make a syscall per individual page of
> memory freed? (If I read correctly)

UML does a big mmap to get "physical" memory, and then manages itself using 
the normal Linux kernel mechanisms for doing so.  We even have page tables, 
although I'm still somewhat unclear on quite how that works.

> >  Plus with punch, we'd be fragmenting the heck
> > out of the underlying file.
>
> Why? No you wouldn't.

Creating holes in the file and freeing up the underlying blocks on disk?  4k 
at a time?  Randomly scattered?

> > I read it.  It just didn't contain an answer the the question.  I want
> > UML to be able to hand back however much memory it's not using, but
> > handing back individual pages as we free them and inserting a syscall
> > overhead for every page freed and allocated is just nuts.  (Plus, at page
> > size, the OS isn't likely to zero them much faster than we can ourselves
> > even without the syscall overhead.)  Defragmentation means we can batch
> > this into a granularity that makes it worth it.
>
> Oh you have measured it and found out that "defragmentation" makes
> it worthwhile?

Lots of work has gone into batching up syscalls and making as few of them as 
possible because they are a performance bottleneck.  You want to introduce a 
syscall for every single individual page of memory allocated or freed.

That's stupid.

> > This has nothing to do with hard limits on anything.
>
> You said:
>
>    "What does this have to do with specifying hard limits of
>     anything? What's to specify?  Workloads vary.  Deal with it."
>
> And I was answering your very polite questions.

You didn't answer.  You keep saying you've already answered, but there 
continues to be no answer.  Maybe you think you've answered, but I haven't 
seen it yet.  You brought up hard limits, I asked what that had to do with 
anything, and in response you quote my question back at me.

> >>Have you looked at the frag patches?
> >
> > I've read Mel's various descriptions, and tried to stay more or less up
> > to date ever since LWN brought it to my attention.  But I can't say I'm a
> > linux VM system expert.  (The last time I felt I had a really firm grasp
> > on it was before Andrea and Rik started arguing circa 2.4 and Andrea
> > spent six months just assuming everybody already knew what a classzone
> > was.  I've had other things to do since then...)
>
> Maybe you have better things to do now as well?

Yeah, thanks for reminding me.  I need to test Mel's newest round of 
fragmentation avoidance patches in my UML build system...

> >>Duplicating the
> >>same or similar infrastructure (in this case, a memory zoning facility)
> >>is a bad thing in general.
> >
> > Even when they keep track of very different things?  The memory zoning
> > thing is about where stuff is in physical memory, and it exists because
> > various hardware that wants to access memory (24 bit DMA, 32 bit DMA, and
> > PAE) is evil and crippled and we have to humor it by not asking it to do
> > stuff it can't.
>
> No, the buddy allocator is and always has been what tracks the "long
> contiguous runs of free memory".

We are still discussing fragmentation avoidance, right?  (I know _I'm_ trying 
to...)

> Both zones and Mels patches classify blocks of memory according to some
> criteria. They're not exactly the  same obviously, but they're equivalent in
> terms of capability to guarantee contiguous freeable regions.

Back up.

I don't care _where_ the freeable regions are.  I just wan't them coalesced.

Zones are all about _where_ the memory is.

I'm pretty sure we're arguing past each other.

> > I was under the impression it was orthogonal to figuring out whether or
> > not a given bank of physical memory is accessable to your sound blaster
> > without an IOMMU.
>
> Huh?

Fragmentation avoidance is what is orthogonal to...

> >>Err, the point is so we don't now have 2 layers doing very similar
> >> things, at least one of which has "particularly silly" bugs in it.
> >
> > Similar is not identical.  You seem to be implying that the IO elevator
> > and the network stack queueing should be merged because they do similar
> > things.
>
> No I don't.

They're similar though, aren't they?  Why should we have different code in 
there to do both?  (I know why, but that's what your argument sounds like to 
me.)

> > If you'd like to write a counter-patch to Mel's to prove it...
>
> It has already been written as you have been told numerous times.

Quoting Yasunori Goto, Yesterday at 2:33 pm,
Message-Id: <20051102172729.9E7C.Y-GOTO@jp.fujitsu.com>

> Hmmm. I don't see at this point.
> Why do you think ZONE_REMOVABLE can satisfy for hugepage.
> At leaset, my ZONE_REMOVABLE patch doesn't any concern about
> fragmentation.

He's NOT ADDRESSING FRAGMENTATION.

So unless you're talking about some OTHER patch, we're talking past each other 
again.

> Now if you'd like to actually learn about what you're commenting on,
> that would be really good too.

The feeling is mutual.

> >>So you didn't look at Yasunori Goto's patch from last year that
> >> implements exactly what I described, then?
> >
> > I saw the patch he just posted, if that's what you mean.  By his own
> > admission, it doesn't address fragmentation at all.
>
> It seems to be that it provides exactly the same (actually stronger)
> guarantees than the current frag patches do. Or were you going to point
> out a bug in the implementation?

No, I'm going to point out that the author of the patch contradicts you.

> >>>Yes, zones are a way of categorizing memory.
> >>
> >>Yes, have you read Mel's patches? Guess what they do?
> >
> > The swap file is a way of storing data on disk.  So is ext3.  Obviously,
> > one is a trivial extension of the other and there's no reason to have
> > both.
>
> Don't try to bullshit your way around with stupid analogies please, it
> is an utter waste of time.

I agree that this conversation is a waste of time, and will stop trying to 
reason with you now.

Rob
