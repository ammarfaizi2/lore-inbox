Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262304AbUKKRnC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262304AbUKKRnC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 12:43:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262330AbUKKRjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 12:39:04 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26258 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262326AbUKKR0D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 12:26:03 -0500
Date: Thu, 11 Nov 2004 11:56:14 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrea Arcangeli <andrea@novell.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Nick Piggin <piggin@cyberone.com.au>, Rik van Riel <riel@redhat.com>,
       Martin MOKREJ? <mmokrejs@ribosome.natur.cuni.cz>, tglx@linutronix.de
Subject: Re: [PATCH] fix spurious OOM kills
Message-ID: <20041111135614.GB16349@logos.cnet>
References: <20041111112922.GA15948@logos.cnet> <20041111154238.GD18365@x30.random> <20041111123850.GA16349@logos.cnet> <20041111165050.GA5822@x30.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041111165050.GA5822@x30.random>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2004 at 05:50:51PM +0100, Andrea Arcangeli wrote:
> On Thu, Nov 11, 2004 at 10:38:50AM -0200, Marcelo Tosatti wrote:
> > 
> > Hi!
> > 
> > On Thu, Nov 11, 2004 at 04:42:38PM +0100, Andrea Arcangeli wrote:
> > > On Thu, Nov 11, 2004 at 09:29:22AM -0200, Marcelo Tosatti wrote:
> > > > Hi,
> > > > 
> > > > This is an improved version of OOM-kill-from-kswapd patch.
> > > > 
> > > > I believe triggering the OOM killer from task reclaim context 
> > > > is broken because the chances that it happens increases as the amount
> > > > of tasks inside reclaim increases - and that approach ignores efforts 
> > > > being done by kswapd, who is the main entity responsible for
> > > > freeing pages.
> > > > 
> > > > There have been a few problems pointed out by others (Andrea, Nick) on the 
> > > > last patch - this one solves them.
> > > 
> > > I disagree about the design of killing anything from kswapd. kswapd is
> > > an async helper like pdflush and it has no knowledge on the caller (it
> > > cannot know if the caller is ok with the memory currently available in
> > > the freelists, before triggering the oom). 
> > 
> > If zone_dma / zone_normal are below pages_min no caller is "OK with
> > memory currently available" except GFP_ATOMIC/realtime callers.
> 
> If the GFP_DMA zone is filled, and nobody allocates with GFP_DMA,
> nothing should be killed and everything should run fine, how can you
> get this right from kswapd? 

It does get it right. It only triggers OOM killer if _both_ 
GFP_DMA / GFP_KERNEL are full _and_ there is a task failing 
to allocate/free memory.

I think you missed the "task_looping_oom" variable in the patch, which is
set as soon as a task is unable to allocate/free memory. This variable
is set where the code used to call the OOM killer.

> > > I'm just about to move the
> > > oom killing away from vmscan.c to page_alloc.c which is basically the
> > > opposite of moving the oom invocation from the task context to kswapd.
> > > page_alloc.c in the task context is the only one who can know if
> > > something has to be killed, vmscan.c cannot know. vmscan.c can only know
> > > if something is still freeable, but if something isn't freeable it
> > > doesn't mean that we've to kill anything 
> > 
> > Well Andrea, its not about "if something isnt freeable", its about
> > "the VM is unable to make progress reclaiming pages". 
> 
> "VM is unable to reclaim pages" == "nothing is freeable"

OK, correct, silly me. I noted the gaffe after sending the email. 

But still, the main idea is valid here.

I'll say this again just in case: If ZONE_DMA and ZONE_NORMAL reclaiming 
efforts are in vain, and there is task which is looping on try_to_free_pages() 
unable to succeed, _and_ both DMA/normal are below pages_min, the OOM 
killer will be triggered.

(should be pages_min + higher protection).

> > > (for example if a task exited
> > > or some dma or normal-zone or highmem memory was released by another
> > > task while we were paging waiting for I/O). 
> > 
> > My last patch checks for pages_min before OOM killing, have you read it?
> 
> checking pages_min isn't correct anyways, the lowmem_reserve must taken
> into account or you may not kill tasks when you should really kill
> tasks.

Indeed - this can be improved. 

> Plus you're checking for all zones, but kswapd cannot know that it
> doesn't matter if the zone dma is under pages_min, as far as there's no
> GFP_DMA.

You mean boxes with no DMA zone?

If the normal zone is below pages_min+protection, then GFP_KERNEL allocations 
will fallback and eat from DMA zone.

I dont get you? 

> > > Every allocation is different and page_alloc.c is the only one who 
> > > knows what has to be done for every single allocation.
> > 
> > OK, what do you propose? Its the third time I ask you this and got no 
> > concrete answer yet. 
> 
> I want to move it to page_alloc.c (and up to the caller) and not in
> kswapd, I mention this a few times.
> 
> > Sure, allocators should receive -ENOMEM whenever possible, but this 
> > is not the issue here.
> 
> it is the issue, because only the context of the task can choose if to
> return -ENOMEM or to invoke the oom killer and try again. 

If the task chooses to return -ENOMEM it wont set "task_looping_oom" flag. 

OK - you are right to say that "only the context of the task can choose
to return -ENOMEM or invoke the oom killer". 

This allocator-context-only information is passed to kswapd via
 "task_looping_oom".

> > Triggering OOM killer on __alloc_pages() failure ? 
> 
> yes, ideally I'd put the oom killer _outside_ alloc_pages, but just
> moving it into alloc_pages should make things better than they are right
> now in vmscan.c.
> 
> > Show us the code, please :) 
> 
> I'm supposedly listening to a meeting right now, then I've a bad kernel
> crash to debug with random mem corruption that I just managed to
> reproduce deterministcally inside uml by emulating numa inside uml and
> I'll be busy until next week at the very least. So I doubt I'll be able
> to write any oom-related code until next week, sorry.

Good luck!
