Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261620AbUKGOgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbUKGOgJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 09:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbUKGOgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 09:36:09 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50578 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261620AbUKGOfi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 09:35:38 -0500
Date: Sun, 7 Nov 2004 09:21:51 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrea Arcangeli <andrea@novell.com>
Cc: Jesse Barnes <jbarnes@sgi.com>, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <piggin@cyberone.com.au>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [PATCH] Remove OOM killer from try_to_free_pages / all_unreclaimable braindamage
Message-ID: <20041107112151.GA28202@logos.cnet>
References: <20041105200118.GA20321@logos.cnet> <200411051532.51150.jbarnes@sgi.com> <20041106012018.GT8229@dualathlon.random> <20041106100516.GA22514@logos.cnet> <20041106154415.GD3851@dualathlon.random> <20041106170925.GA23324@logos.cnet> <20041107004809.GI3851@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041107004809.GI3851@dualathlon.random>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, Nov 07, 2004 at 01:48:09AM +0100, Andrea Arcangeli wrote:
> On Sat, Nov 06, 2004 at 03:09:25PM -0200, Marcelo Tosatti wrote:
> > Sure NUMA can and has to be special cased, as I answered Nick. 
> > 
> > "dont kill if we can allocate from other nodes", should be pretty simple.
> 
> then how do you call the oom killer if some highmem page is still free
> but there's a GFP_KERNEL|__GFP_NOFAIL allocation failing and looping
> forever?

We should probably kill a task if a GFP_KERNEL allocation 
is failing and looping forever. We need some mechanism
to indicate to kswapd that there is a allocator 
failing repeatedly (an indication that we are really getting into
an OOM condition).

With that information kswapd can decide whether to kill or not. 

> > but its not the same problem.
> > 
> > Have you done any tests on this respect?
> 
> the only test I have are based on 2.6.5 and the box simply deadlock
> there, the oom killer is forbidden there if nr_swap_pages > 0. Not
> anymore in 2.6.9rc, however with 2.6.9 and more recent the oom killer is
> invoked too early.

Right. 

> > So "not being able to make progress freeing pages" seems to be reliable
> > information on whether to trigger OOM. Note that reaching priority
> > 0 means we've tried VERY VERY hard already.
> 
> yes, "not being able to make progress freeing pages" has always been the
> only reliable information in linux. The early 2.6 and some older 2.4
> deadlocked in corner cases (like mlock for example) at trying to guess
> the oom time by looking at a few stat numbers (nr_swap_pages for
> example).

Right, and William removed the "nr_swap_pages" check, which fixed 
those - but introduced the spurious OOM kills.

> Though when we reach prio 0 clearly we didn't try hard enough if I'm
> getting spurious oom. It's also possible that the pages are being freed
> in other per-cpu queues and we lose visibility on them, so we do hard
> work and still we cannot allocate anything. Unfortunately I've never
> been able to reproduce the early oom kill here, so I could never figure
> out what's going on. and yes, I know there are patches floating around
> claiming they fixed it, but I'd like to hear positive feedback on those.

Just run a program which allocates a lot of anonymous memory on a 100M setup
and you will see it. 

The OOM killer will be triggered even if there is anonymous memory to be 
swapped out and swap space available. Which is plain wrong.

> > > kswapd page freeing efforts are not very useful. kswapd is an helper,
> > > it's not the thing that can or should guarantee allocations to succeed.
> > 
> > Oh wait, kswapd job is to guarantee that allocations succeed. We used to 
> 
> kswapd is all but a guarantee. kswapd is a pure helper.
> 
> > wait on kswapd before on v2.3 VM development - then we switched to 
> > task-goes-to-memory-reclaim for _performance_ reasons (parallelism).
> 
> it wasn't parallelism.  The only way you could make it safe is that you
> create a message passing mechanism where you post a request to kswapd
> and kswapd wakes you up back. But that'd inefficient compared to current
> model where kswapd is an helper.

Yes, it was inefficient, but it used to work like that. There was a
kswapd waitqueue in which tasks used to sleep. By parallelism I meant 
parallelism freeing pages -> efficiency.  

OK - its not like that anymore - but kswapd is not simply a "helper" - 
its more than that, its responsible for keeping enough pages free.

> Infact kswapd right now only hurts during heavy paging since it will
> prevent the freed pages to go into the right per-cpu queue. kswapd only
> hurts during paging, we should stop it as far as somebody is inside the
> critical section for a certain numa node.

Indeed! But then if you stop kswapd under heavy load, you're pretty much 
guaranteeing tasks will have to free pages themselves - synchronously
, which is not a good thing.

Its not trivial to know when to stop/when to start kswapd. 

Another related problem is that an unlimited number of tasks can go
into reclaim - it should be limited to a sane number.

> > My point here is, kswapd is the entity responsible for freeing pages. 
> 
> it can't even know which is the per-cpu queue where it has to put the
> pages back.

No need - just put send'em back to the buddy allocator - which happens
anyway when the per-cpu queue reaches its high limit. 

> > The action of triggering OOM killer from inside a task context (whether 
> > its from the alloc_pages path or the fault path is irrelevant here) 
> > is WRONG because at the same time, kswapd, who is the main entity freeing 
> > pages, is also running the memory reclaim code - it might just have freed 
> > a bunch of pages but we have no way of knowing that from normal task context. 
> 
> we definitely have a way of knowing, the fact the current code is buggy
> doesn't mean we don't have a way of knowing, 2.4 VM perfectly knows when
> kswapd did the right thing and helped. Though I agree kswapd generally
> hurts during paging and we'd better stop it to reduce the synchronous
> amount of work.
> 
> the allocator must check if the levels are above pages.low before
> killing, if it doesn't do that it's broken, moving the oom killer in
> kswapd cannot fix this problem, because obviously then it'll be the task
> context that will have freed the additional pages instead of kswapd.

OK - the pages.low check before killing makes total sense.

We dont do that right now - and we should - whatever callee 
invokes the OOM killer.

> The rule is to do:
> 
> 	paging
> 	check the levels and kill
> 
> If you just do paging and oom kill if paging has failed there's no way
> it can work. 2.6 is broken here, and that could be the reason of the oom
> kills too.
> 
> There will be always a race condition even with the above, since the
> check for the levels and oom kill isn't an atomic operation and we don't
> block all other cpus in that path, but it's an insignificant window we
> don't have to worry about (only theoretical).
> 
> But if you check the levels; paging; kill, like current 2.6, there is an
> huge window while we wait for I/O. After we finished the I/O the whole
> VM status may have changed and we may be full of free pages in the
> per-cpu queue and in the buddy as well. so we've to recheck the levels
> before killing anything. This is again why doing oom_kill inside the
> try_to_free_pages (or in kswapd anyways) is flawed.

OK, it could be a task who now freed pages instead of kswapd - but I still 
prefer having the OOM killer be called from a centralized place, which is 
also the main responsible task for freeing pages, than to call it from each 
task try_to_free_pages() path. 

Anyway, where do you suggest oom_kill to be called from if you think 
both try_to_free_pages/kswapd are not the right callees? 

Failure of handle_mm_fault ? 

> > > The rule is that if you want to allocate 1 page, you've to free the page
> > > yourself. Then if kswapd frees a page too, that's welcome. But keep also
> > > in mind kswapd may be running in another cpu, and it will put the pages
> > > back into the per-cpu queue of the other cpu. 
> > 
> > Exactly another reason for _NOT_ triggering the OOM killer from task context 
> > - pages which have been freed might be in the per-CPU queue (but a task
> > running on another CPU can't see them).
> > 
> > We should be flushing the per-cpu queues quite often under these circumstances. 
> 
> we should never flush per-cpu pages, that'd hurt performance, per-cpu
> pages are lost memory. this is also why we must give up freeing memory
> only if everything else is not available, in 2.4 I had to stop after 50
> tries or so. We must keep going until all per-cpu queues are full,
> because if kswapd is in our way every other cpu may get the ram before
> us. This is why stopping kswapd would be beneficial while we're working
> on it, it'd probabilistically reduce the amount of synchronous work.

OK - flushing the per-cpu queues would hurt performance. 

I meant, if we're kswapd, send'em back to the buddy allocator 
so that tasks on other CPUs can see the just-freed-memory.  

But thats indeed bad from a performance point of view.

> > Why's that? blk_congestion_wait looks clean and correct to me - if the queue 
> > is full dont bother queueing more pages at this device.
> 
> blk_contestion_wait is waiting on random I/O, it doesn't mean it's
> waiting on any substantial VM related paging (an O_DIRECT I/O would fool
> blk_congestion_wait), and if there's no I/O it just wakeup after a fixed
> random number of seconds.
> 
> the VM should only throttle on locked pages or locked bh it can see,
> never on random I/O happening at the blkdev layer just because somebody
> is rolling some directio. Throttling on random I/O will lead to oom
> failures too and that's another bug in the 2.6 VM (and if it's not a
> bug, and we throttle elsewhere too, then it's simply useless and it
> should be replaced with a yield, if there's no I/O waiting there is a
> nosense, especially given that even if the oom killer triggers there
> won't be any additional ram to free, since the oom killer will generate
> free memory, not memory to free).
> 
> > OK - so you seem to be agreeing with me that triggering OOM killer
> > from kswapd context is the correct thing to do now?
> 
> I disagree about that sorry. not even try_to_free_pages should ever call
> the oom killer (unless you want to move the watermark checks from
> page_alloc.c to vmscan.c that would not be clean at all). Taking the
> decision on when to oom kill inside vmscan.c (like current 2.6 does)
> looks wrong to me.

OK, so, please answer my question above on "where do you think is 
the correct callee".

IMHO OOM killing from kswapd, is way better than the current approach 
- and I will try to enhance my patch handling the NUMA and GFP_KERNEL
allocation cases (with a notification mechanism used by allocators 
to inform successive failure to kswapd).

Either way - this discussion is being productive.
