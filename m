Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751468AbWCWTaz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbWCWTaz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 14:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbWCWTaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 14:30:55 -0500
Received: from kanga.kvack.org ([66.96.29.28]:57573 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1751468AbWCWTay (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 14:30:54 -0500
Date: Thu, 23 Mar 2006 16:30:57 -0600
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org, bob.picco@hp.com,
       iwamoto@valinux.co.jp, christoph@lameter.com, wfg@mail.ustc.edu.cn,
       npiggin@suse.de, riel@redhat.com
Subject: Re: [PATCH 00/34] mm: Page Replacement Policy Framework
Message-ID: <20060323223057.GA12895@dmt.cnet>
References: <20060322223107.12658.14997.sendpatchset@twins.localnet> <20060322145132.0886f742.akpm@osdl.org> <20060323205324.GA11676@dmt.cnet> <Pine.LNX.4.64.0603231003390.26286@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603231003390.26286@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Thu, Mar 23, 2006 at 10:15:47AM -0800, Linus Torvalds wrote:
> 
> 
> On Thu, 23 Mar 2006, Marcelo Tosatti wrote:
> > 
> > IMHO the page replacement framework intent is wider than fixing the     
> > currently known performance problems.
> > 
> > It allows easier implementation of new algorithms, which are being
> > invented/adapted over time as necessity appears.
> 
> Yes and no.
> 
> It smells wonderful for a pluggable page replacement standpoint, but 
> here's a couple of observations/questions:
>  a) the current one actually seems to have beaten the on-comers (except 
>     for loads that were actually made up to try to defeat LRU)

Nope, LRU only beat CLOCK-Pro/CART on the "UMass trace" (which is trace
replay, which can be very sensitive and not necessarily meaningful).
Needs more study though (talk is cheap).

Anyway, smarter algorithms such as this two have been proven to be more
efficient than LRU under a large range of real life loads. LRU's lack of
frequency information is really terrible.

LRU's worst case scenarios were well known before I was born.

>  b) is page replacement actually a huge issue? 
>
> Now, the reason I ask about (b) is that these days, you buy a Mac Mini, 
> and it comes with half a gig of RAM, and some apple users seem to worry 
> about the fact that the UMA graphics removes 50MB or something of that is 
> a problem. 

And why do they worry about having 50MB of memory less? Because memory
_is_ a very precious resource.

Therefore it should be managed as efficently and intelligently as
possible. 

> IOW, just under half a _gigabyte_ of RAM is apparently considered to be 
> low end, and this is when talking about low-end (modern) hardware!

Exactly. Tight memory condition is not a prerequisite for page
replacement being a bottleneck.

> And don't tell me that the high-end people care, because both databases 
> (high end commercial) and video/graphics editing (high end desktop) very 
> much do _not_ care, since they tend to try to do their own memory 
> management anyway. 

So basically you're saying that if applications want smarter memory
management under Linux they should do it on their own? 

What percentage of the applications can afford doing that? Oracle, yeah.

> > One example (which I mentioned several times) is power saving:
> > 
> > PB-LRU: A Self-Tuning Power Aware Storage Cache Replacement Algorithm
> > for Conserving Disk Energy.
> 
> Please name a load that really actually hits the page replacement today.

Any sort of indexing process where the dataset is larger than memory
(cscope is a great example) or database load care _very much_, just
to name a few. The cost of waiting for a page to come from disk is
extremely bad compared to the time of a memory access, you know.

> It smells like university research to me.
> 
> And don't flame me: I'm perfectly happy to be shown to be wrong. I just 
> get a very strong feeling that the people who care about tight memory 
> conditions and perhaps about page replacement are the same people who 
> think that our kernel is too big - the embedded people. And somehow I'm 
> not convinced they want the added abstraction either - they'd probably 
> rather just have a smaller kernel ;)

Not really - small/medium end servers and desktops care more. 

Embedded people don't care about page replacement: such scenarios have,
99.9% of the time, a working set smaller than total memory size.

> What I'm trying to say is that page replacement hasn't been what seems to 
> have worried people over the last year or two.

Well, system certainly works with LRU, but the system can be faster with
a smarter algorithm. The popularity of the swap prefetching patchset is
a clear indication to me that people do care about memory management,
and that they usually have a working set larger than memory.

- "Every time I wake up in the morning updatedb has thrown my applications
out of memory".

- "Linux is awful every time I untar something larger than memory to disk".

BTW, Peter just pointed out to a message from Jens where he describes his
experience with CLOCK-Pro (http://lkml.org/lkml/2006/3/23/39):

"
> To prefetch applications from swap to physical memory when there is 
> little activity seems so obvious that I can't believe it hasn't been 
> implemented before.

It's a heuristic, and sometimes that will work well and sometimes it
will not. What if during this period of inactivity, you start bringing
everything in from swap again, only to page it right out because the
next memory hog starts running? From a logical standpoint, swap prefetch
and the vm must work closely together to avoid paging in things which
really aren't needed.

I've been running with the clockpro for the past week, which seems to
handle this sort of thing extremely well. On a 1GB machine, running the
vanilla kernels usually didn't see my use any swap. With the workload I
use, I typically had about ~100MiB of page cache and the rest of memory
full. Running clockpro, it's stabilized at ~288MiB of swap leaving me
more room for cache - with very rare paging activity going on. Hardly a
scientific test, but the feel is good."

> We had some ugly problems in the early 2.4.x timeframe, and I'll
> claim that most (but not all) of those were related to highmem/zoning
> issues which we largely solved. Which was about page replacement, but
> really a very specific issue within that area.
>
> So seriously, I suspect Andrew's "Holy cow" comes from the fact that
> he is more worried about VM maintainability and stability than page
> replacement. I certainly am.

It would be great if you/Andrew could go over the patchset and give your
comments on to specific points, telling where you think the API is dumb
and could be improved, etc.

It does not seem to introduce a hell lot of maintainability burden to me, 
its simple in general (can certainly get better).

Page replacement is, without any doubt, an important issue. It does
matter _a lot_.


