Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312883AbSDEOo2>; Fri, 5 Apr 2002 09:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312871AbSDEOoS>; Fri, 5 Apr 2002 09:44:18 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:19531 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S312872AbSDEOoG>; Fri, 5 Apr 2002 09:44:06 -0500
Date: Fri, 5 Apr 2002 16:43:48 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: the oom killer
Message-ID: <20020405164348.K32431@dualathlon.random>
In-Reply-To: <3CAD6BE2.40ADC2B4@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2002 at 01:18:26AM -0800, Andrew Morton wrote:
> 
> Andrea,
> 
> Marcelo would prefer that the VM retain the oom killer.  The thinking
> is that if try_to_free_pages fails, then we're better off making a
> deliberate selection of the process to kill rather than the random(ish)
> selection which we make by failing the allocation.
> 
> One example is at
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=101405688319160&w=2
> 
> That failure was with vm-24, which I think had the less aggressive

vm-24 had a problem yes, that is fixed in the latest releases.

> i/dcache shrink code.  We do need to robustly handle the no-swap-left
> situation.
> 
> So I have resurrected the oom killer.  The patch is below.
> 
> During testing of this, a problem cropped up.  The machine has 64 megs
> of memory, no swap.  The workload consisted of running `make -j0
> bzImage' in parallel with `usemem 40'.  usemem will malloc a 40
> megabyte chunk, memset it and exit.
> 
> The kernel livelocked.  What appeared to be happening was that ZONE_DMA
> was short on free pages, but ZONE_NORMAL was not.  So this check:
> 
> 	if (!check_classzone_need_balance(classzone))
>         	break;
> 
> in try_to_free_pages() was seeing that ZONE_NORMAL had some headroom
> and was causing a return to __alloc_pages().
> 
> __alloc_pages has this logic:
> 
> 	min = 1UL << order;
> 	for (;;) {
> 		zone_t *z = *(zone++);
> 		if (!z)
> 			break;
> 
> 		min += z->pages_min;
> 		if (z->free_pages > min) {
> 			page = rmqueue(z, order);
> 			if (page)
> 				return page;
> 		}
> 	}
> 
> 
> On the first pass through this loop, `min' gets the value
> zone_dma.pages_min + 1.  On the second pass through the loop it gets
> the value zone_dma.pages_min + 1 + zone_normal.pages_min.  And this is
> greater than zone_normal.free_pages! So alloc_pages() gets stuck in an
> infinite loop.

This is a bug I fixed in the -rest patch, that's also broken on numa.
The deadlock cannot happen if you apply all my patches.

As for your patch it reintroduces a deadlock by looping in GFP relying
on the oom killer (that will also go and kill the
bigger task most of the time), the oom killer can select a task in D
state, or it can a sigterm, and secondly you broke google DB (the right
fix for that min thing are the point-of-view watermarks in the -rest
patch in my collection). the worst thing is that with the oom killer
we've to keep looping, so if the task is for whatever reason hung in R
state in kernel the machine will deadlock, while current way it will
make progress either in the do_exit, or in the -ENOMEM fail path (modulo
getblk that's not too bad anyways). the current memory balancing is now
been good enough to kill in function of probability, so I didn't feel
the need of risking (at the very least theorical) deadlocks there, this
is why I left it disabled.

Andrea
