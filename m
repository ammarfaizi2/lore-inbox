Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261466AbUKFUXW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261466AbUKFUXW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 15:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbUKFUXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 15:23:22 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42936 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261462AbUKFUWX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 15:22:23 -0500
Date: Sat, 6 Nov 2004 15:09:25 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrea Arcangeli <andrea@novell.com>
Cc: Jesse Barnes <jbarnes@sgi.com>, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <piggin@cyberone.com.au>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [PATCH] Remove OOM killer from try_to_free_pages / all_unreclaimable braindamage
Message-ID: <20041106170925.GA23324@logos.cnet>
References: <20041105200118.GA20321@logos.cnet> <200411051532.51150.jbarnes@sgi.com> <20041106012018.GT8229@dualathlon.random> <20041106100516.GA22514@logos.cnet> <20041106154415.GD3851@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041106154415.GD3851@dualathlon.random>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 06, 2004 at 04:44:15PM +0100, Andrea Arcangeli wrote:
> Hi Marcelo,

Hi again!

> On Sat, Nov 06, 2004 at 08:05:16AM -0200, Marcelo Tosatti wrote:
> > The OOM killer is only going to get triggered if kswapd is not able 
> > to make _any_ progress in all zones.  So it wont "fail balancing because there's 
> > a GFP_DMA allocation that eat the last dma page".  
> > 
> > As long as frees _one_ page during all passes from DEF_PRIORITY till priority=0, 
> > it wont kill any task. See?
> 
> It's still wrong on numa. the machine isn't oom despite kswapd couldn't
> free any page (the local node will fallback in the other nodes instead)

Sure NUMA can and has to be special cased, as I answered Nick. 

"dont kill if we can allocate from other nodes", should be pretty simple.

> > > If you move it in kswapd there's no way to prevent oom-killing from a
> > > syscall allocation (I guess even right now it would go wrong in this
> > > sense, but at least right now it's more fixable).
> > 
> > I dont understand what you mean. "prevent oom-killing from a syscall allocation" ?
> 
> yes. oom killing should be avoided as far as we can avoid it. Ideally we
> should never invoke the oom killer and we should always return -ENOMEM
> to applications. If a syscall runs oom then we can return -ENOMEM and
> handle the failure gracefully instead of getting a sigkill.
> 
> With 2.4 -ENOMEM is returned and the machine doesn't deadlock when the
> zone normal is full and that works fine.

I agree with you here. But then there are the cases which you can't return ENOMEM - 
the fault paths you have mentioned, and the PMD/PTE allocation mentioned by Arjan
on mmap, and probably others.

We should be returning -ENOMEM to syscalls right now in v2.6, but thats 
not the problem here. The problem are the page faults.

If v2.6 is failing to return -ENOMEM to syscalls then its indeed screwed, 
but its not the same problem.

Have you done any tests on this respect?

> > Isnt OOM killing all about the reclaiming efforts not being able to make progress? 
> 
> it's invoked when we're not able to make progress and no fail path
> exists.

The system will, in the vast majority of cases, be OOM due to page faults
which can't be handled (anonymous memory mappings created by brk/sbrk) anyway.

So "not being able to make progress freeing pages" seems to be reliable
information on whether to trigger OOM. Note that reaching priority
0 means we've tried VERY VERY hard already.

> > To me having tasks trigger the OOM kill is fundamentally broken 
> > because it doesnt take into account kswapd page freeing 
> > efforts which are in-progress at the very moment.
> 
> kswapd page freeing efforts are not very useful. kswapd is an helper,
> it's not the thing that can or should guarantee allocations to succeed.

Oh wait, kswapd job is to guarantee that allocations succeed. We used to 
wait on kswapd before on v2.3 VM development - then we switched to 
task-goes-to-memory-reclaim for _performance_ reasons (parallelism).

My point here is, kswapd is the entity responsible for freeing pages. 

The action of triggering OOM killer from inside a task context (whether 
its from the alloc_pages path or the fault path is irrelevant here) 
is WRONG because at the same time, kswapd, who is the main entity freeing 
pages, is also running the memory reclaim code - it might just have freed 
a bunch of pages but we have no way of knowing that from normal task context. 

> The rule is that if you want to allocate 1 page, you've to free the page
> yourself. Then if kswapd frees a page too, that's welcome. But keep also
> in mind kswapd may be running in another cpu, and it will put the pages
> back into the per-cpu queue of the other cpu. 

Exactly another reason for _NOT_ triggering the OOM killer from task context 
- pages which have been freed might be in the per-CPU queue (but a task
running on another CPU can't see them).

We should be flushing the per-cpu queues quite often under these circumstances. 

> So you should really free
> a page yourself to be guaranteed to find that page later on.
> 
> kswapd is more for keeping the balance between low and high so that we
> never block freeing memory, and to keep the disk running.
> 
> > See, its completly screwed right now. The code inside out_of_memory()
> > which only triggers OOM if it has happened several times during the 
> > past few seconds is horrible and shows how bad it is. 
> 
> that's very bad indeed. But anything happening inside out_of_memory has
> nothing to do with what we discussed above like Thomas Gleixner pointed
> out yesterday.
> 
> these are two different things:
> 
> 1) choose when we need to invoke out_of_memory
> 2) choose what to do inside out_of_memory

OK - agreed.

> I definitely agree about the 5 sec waiting being an hack, to me even
> blk_congest_wait looks an hack.

Why's that? blk_congestion_wait looks clean and correct to me - if the queue 
is full dont bother queueing more pages at this device.

OK - so you seem to be agreeing with me that triggering OOM killer
from kswapd context is the correct thing to do now?

