Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314045AbSDKNOb>; Thu, 11 Apr 2002 09:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314046AbSDKNOa>; Thu, 11 Apr 2002 09:14:30 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:29272 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S314045AbSDKNO2>; Thu, 11 Apr 2002 09:14:28 -0400
Date: Thu, 11 Apr 2002 15:13:53 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: the oom killer
Message-ID: <20020411151353.K14605@dualathlon.random>
In-Reply-To: <20020405164348.K32431@dualathlon.random> <Pine.LNX.4.21.0204051844521.11472-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2002 at 06:45:08PM -0300, Marcelo Tosatti wrote:
> 
> 
> On Fri, 5 Apr 2002, Andrea Arcangeli wrote:
> 
> > On Fri, Apr 05, 2002 at 01:18:26AM -0800, Andrew Morton wrote:
> > > 
> > > Andrea,
> > > 
> > > Marcelo would prefer that the VM retain the oom killer.  The thinking
> > > is that if try_to_free_pages fails, then we're better off making a
> > > deliberate selection of the process to kill rather than the random(ish)
> > > selection which we make by failing the allocation.
> > > 
> > > One example is at
> > > 
> > > http://marc.theaimsgroup.com/?l=linux-kernel&m=101405688319160&w=2
> > > 
> > > That failure was with vm-24, which I think had the less aggressive
> > 
> > vm-24 had a problem yes, that is fixed in the latest releases.
> > 
> > > i/dcache shrink code.  We do need to robustly handle the no-swap-left
> > > situation.
> > > 
> > > So I have resurrected the oom killer.  The patch is below.
> > > 
> > > During testing of this, a problem cropped up.  The machine has 64 megs
> > > of memory, no swap.  The workload consisted of running `make -j0
> > > bzImage' in parallel with `usemem 40'.  usemem will malloc a 40
> > > megabyte chunk, memset it and exit.
> > > 
> > > The kernel livelocked.  What appeared to be happening was that ZONE_DMA
> > > was short on free pages, but ZONE_NORMAL was not.  So this check:
> > > 
> > > 	if (!check_classzone_need_balance(classzone))
> > >         	break;
> > > 
> > > in try_to_free_pages() was seeing that ZONE_NORMAL had some headroom
> > > and was causing a return to __alloc_pages().
> > > 
> > > __alloc_pages has this logic:
> > > 
> > > 	min = 1UL << order;
> > > 	for (;;) {
> > > 		zone_t *z = *(zone++);
> > > 		if (!z)
> > > 			break;
> > > 
> > > 		min += z->pages_min;
> > > 		if (z->free_pages > min) {
> > > 			page = rmqueue(z, order);
> > > 			if (page)
> > > 				return page;
> > > 		}
> > > 	}
> > > 
> > > 
> > > On the first pass through this loop, `min' gets the value
> > > zone_dma.pages_min + 1.  On the second pass through the loop it gets
> > > the value zone_dma.pages_min + 1 + zone_normal.pages_min.  And this is
> > > greater than zone_normal.free_pages! So alloc_pages() gets stuck in an
> > > infinite loop.
> > 
> > This is a bug I fixed in the -rest patch, that's also broken on numa.
> > The deadlock cannot happen if you apply all my patches.
> 
> How did you fixed this specific problem?

I didn't really fixed it, it's just that the problem never existed in my
tree. I don't" min += z->pages_min" and so the
check_classzone_need_balance path sees exactly the same state of the VM
as the main allocator, so if it breaks the loop the main allocator will
go ahead just fine.

Andrea
