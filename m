Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262404AbUKKW6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262404AbUKKW6w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 17:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262412AbUKKW5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 17:57:41 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9610 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262404AbUKKWv3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 17:51:29 -0500
Date: Thu, 11 Nov 2004 17:19:43 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrea Arcangeli <andrea@novell.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Nick Piggin <piggin@cyberone.com.au>, Rik van Riel <riel@redhat.com>,
       Martin MOKREJ? <mmokrejs@ribosome.natur.cuni.cz>, tglx@linutronix.de
Subject: Re: [PATCH] fix spurious OOM kills
Message-ID: <20041111191943.GD17496@logos.cnet>
References: <20041111112922.GA15948@logos.cnet> <20041111154238.GD18365@x30.random> <20041111123850.GA16349@logos.cnet> <20041111165050.GA5822@x30.random> <20041111135614.GB16349@logos.cnet> <20041111214550.GB5138@x30.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041111214550.GB5138@x30.random>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2004 at 10:45:50PM +0100, Andrea Arcangeli wrote:
> On Thu, Nov 11, 2004 at 11:56:14AM -0200, Marcelo Tosatti wrote:
> > It does get it right. It only triggers OOM killer if _both_ 
> > GFP_DMA / GFP_KERNEL are full _and_ there is a task failing 
> > to allocate/free memory.
> 
> you should check for highmem too before killing the task.

How's that? It doesnt really matter for OOM killing purposes if highmem 
is full or not because of the fallback scheme, right?

> > I think you missed the "task_looping_oom" variable in the patch, which is
> > set as soon as a task is unable to allocate/free memory. This variable
> > is set where the code used to call the OOM killer.
> 
> why do you use a global variable to pass a message from the task context
> to kswapd, when you can do the real thing in the task context since the
> first place?

OK - I'll try to explain my reasoning below.

> > But still, the main idea is valid here.
> 
> Putting the oom killer in kswapd is just flawed. I recall somebody
> already put it in kswapd in the old days, but that can't work right in
> all scenarios.

It should work right as long as you provide the necessary information
to kswapd.

> The single fact you had to implement the task_looping_oom variable,
> means you also felt the need to send some bit of info to kswapd from the
> task context, then why don't you do the real thing from the task
> context where you've a load of additional information to know exactly
> what to do in the first place instead of adding global variables?

Because its not a centralized place, the chances the OOM killer will 
get triggered increases as the number of parallel tasks inside 
reclaim increases.

And that is the main thing that feels wrong to me in killing from task context.

> > I'll say this again just in case: If ZONE_DMA and ZONE_NORMAL reclaiming 
> > efforts are in vain, and there is task which is looping on try_to_free_pages() 
> > unable to succeed, _and_ both DMA/normal are below pages_min, the OOM 
> > killer will be triggered.
> 
> the oom killer must be triggered even if only ZONE_DMA is under page_min
> if somebody allocates with __GFP_NOFAIL|GFP_DMA.

True. Needs fixing.

> Those special cases
> don't make much sense to me. The only one that can know what to do is
> the task context, never kswapd. And I don't see the point of using the
> task_looping_oom variable when you can invoke the oom killer from
> page_alloc _after_ checking the watermarks again with lowmem_reserve
> into the equation (something that sure kswapd can't do, unless you pass
> more bits of info than just a 0 or 1 via task_looping_oom).

True, more bits of info passed to kswapd are needed for perfect functionality 
(ie more information about the failing tasks).

> > (should be pages_min + higher protection).
> 
> higher protection requires you to define the classzone where the task is
> allocating from, only the task context knows it.
> 
> > > Plus you're checking for all zones, but kswapd cannot know that it
> > > doesn't matter if the zone dma is under pages_min, as far as there's no
> > > GFP_DMA.
> > 
> > You mean boxes with no DMA zone?
> 
> I mean GFP_DMA as an allocation from the DMA classzone. If nobody
> allocates ram passing GFP_DMA to alloc pages, nobody should worry or
> notice if the GFP_DMA is under pages_min, because no allocation risk to
> fail.

Sure.

> The oom killing must be strictly connected with a classzone allocation
> failing (the single zone doesn't matter) and if nobody uses GFP_DMA it
> doesn't matter if the dma zone is under pages_min.

Sure.

> 2.4 gets all of this perfectly right and for sure it's not even remotely
> attempting at killing anything from kswapd (and infact there's not a
> single bugreport outstanding). all it can happen in 2.4 is some wasted
> cpu while kswapd tries to do the paging, but exactly because kswapd is
> purerly an helper (like 2.6 right now too and I don't want to change
> this bit, since kswapd in 2.6 looks sane, much saner than the task
> context itself which is the real problematic part that needs fixing),
> nothing risk to go wrong (you can only argue about performance issues
> when the dma zone gets pinned and under watermark[].min ;).
> 
> > If the task chooses to return -ENOMEM it wont set "task_looping_oom"
> > flag. 
> > 
> > OK - you are right to say that "only the context of the task can choose
> > to return -ENOMEM or invoke the oom killer". 
> > 
> > This allocator-context-only information is passed to kswapd via
> >  "task_looping_oom".
> 
> what's the point of passing info to kswapd? why don't you schedule a
> callback instead, why don't you use keventd instead of kswapd? 

Because keventd or whatever userspace daemon are not responsible for 
freeing pages.

> I just
> don't get what benefit you get from that except form complexity and
> overhead. And to do it right right like this you'd need to pass more
> than 1 bit of info.

My thinking is this, please argue back if it doenst make any sense to you:

The tasks on reclaiming procedure do not know about kswapd's
reclaiming efforts (again, I'm thinking of kswapd as the main entity
freeing pages, not purely a helper), and also do not know about other 
tasks reclaiming progress.

Its impossible for a task to know if kswapd or any other reclaiming
tasks have been able to free pages (progress freeing pages means 
the OOM killer should NOT be triggered).

So, to illustrate, if you have 100 tasks inside reclaim, and 99 of them 
successfully free pages, but one of them doesnt (mainly due to the competition),
it will wrongly trigger the OOM killer. 

So my thinking is "we need to centralize OOM detection for it to be reliable".

And to detect OOM in a certain zone, you need to fully scan it. You dont
want to be scanning the full ZONE_NORMAL zone multiplied by number of 
tasks inside reclaim, do you?

This are the benefits, and the need, to move the OOM killer inside one
single kernel daemon who is responsible for keeping the free page 
reserves full.

Thats it.

> I mean, one could even change the code to send the whole task
> information to an userspace daemon, that will open a device driver and
> issue an ioctl that eventually calls the oom killer on a certain pid, in
> order to invoke the oom killer. I just don't see why to waste any effort
> with non trivial message passing when the oom killer itself can be
> invoked by page_alloc.c where all the watermark checks are already
> implemented, without passing down information to some random kernel
> daemon.

Its not really "random kernel daemon" - its the daemon running the
page reclaiming code.

> > Good luck!
> 
> thanks! ;)
