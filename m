Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262265AbUKKQIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262265AbUKKQIm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 11:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262267AbUKKQIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 11:08:42 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:139 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262265AbUKKQIi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 11:08:38 -0500
Date: Thu, 11 Nov 2004 10:38:50 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrea Arcangeli <andrea@novell.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Nick Piggin <piggin@cyberone.com.au>, Rik van Riel <riel@redhat.com>,
       Martin MOKREJ? <mmokrejs@ribosome.natur.cuni.cz>, tglx@linutronix.de
Subject: Re: [PATCH] fix spurious OOM kills
Message-ID: <20041111123850.GA16349@logos.cnet>
References: <20041111112922.GA15948@logos.cnet> <20041111154238.GD18365@x30.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041111154238.GD18365@x30.random>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

On Thu, Nov 11, 2004 at 04:42:38PM +0100, Andrea Arcangeli wrote:
> On Thu, Nov 11, 2004 at 09:29:22AM -0200, Marcelo Tosatti wrote:
> > Hi,
> > 
> > This is an improved version of OOM-kill-from-kswapd patch.
> > 
> > I believe triggering the OOM killer from task reclaim context 
> > is broken because the chances that it happens increases as the amount
> > of tasks inside reclaim increases - and that approach ignores efforts 
> > being done by kswapd, who is the main entity responsible for
> > freeing pages.
> > 
> > There have been a few problems pointed out by others (Andrea, Nick) on the 
> > last patch - this one solves them.
> 
> I disagree about the design of killing anything from kswapd. kswapd is
> an async helper like pdflush and it has no knowledge on the caller (it
> cannot know if the caller is ok with the memory currently available in
> the freelists, before triggering the oom). 

If zone_dma / zone_normal are below pages_min no caller is "OK with
memory currently available" except GFP_ATOMIC/realtime callers.

And the system can't make progress with only those callers happy. 

> I'm just about to move the
> oom killing away from vmscan.c to page_alloc.c which is basically the
> opposite of moving the oom invocation from the task context to kswapd.
> page_alloc.c in the task context is the only one who can know if
> something has to be killed, vmscan.c cannot know. vmscan.c can only know
> if something is still freeable, but if something isn't freeable it
> doesn't mean that we've to kill anything 

Well Andrea, its not about "if something isnt freeable", its about
"the VM is unable to make progress reclaiming pages". 

> (for example if a task exited
> or some dma or normal-zone or highmem memory was released by another
> task while we were paging waiting for I/O). 

My last patch checks for pages_min before OOM killing, have you read it?

> Every allocation is different and page_alloc.c is the only one who 
> knows what has to be done for every single allocation.

OK, what do you propose? Its the third time I ask you this and got no 
concrete answer yet. 

Sure, allocators should receive -ENOMEM whenever possible, but this 
is not the issue here.

Triggering OOM killer on __alloc_pages() failure ? 

Show us the code, please :) 

Thanks
