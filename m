Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269802AbRHIQZZ>; Thu, 9 Aug 2001 12:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269808AbRHIQZF>; Thu, 9 Aug 2001 12:25:05 -0400
Received: from medusa.sparta.lu.se ([194.47.250.193]:6779 "EHLO
	medusa.sparta.lu.se") by vger.kernel.org with ESMTP
	id <S269802AbRHIQYz>; Thu, 9 Aug 2001 12:24:55 -0400
Date: Thu, 9 Aug 2001 17:12:43 +0200 (MET DST)
From: Bjorn Wesen <bjorn@sparta.lu.se>
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: alloc_area_pte: page already exists
In-Reply-To: <20010809180344.J4895@athlon.random>
Message-ID: <Pine.LNX.3.96.1010809170813.5473D-100000@medusa.sparta.lu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Aug 2001, Andrea Arcangeli wrote:
> > I'm trying to track down a problem which seems to be a race condition
> > vmalloc page table delayed PTE copying", or "you must never
> > call free_kiovec in an interrupt context" etc..)
> 
> The latter is certainly the case. The former could be the case, however

Had some nasty bugs in that case before.. 

> if you know you're running any free_kiovec from irqs remove it and try
> again first.

Yes, I found it. The irq which signals end-of-I/O also frees the kiovec,
which is bad. But it seemed that what would happen then would be deadlocks
(due to the spinlocks) and not races - but I'll try to make it free in a
task or something instead (there is no kernel context for the "calling"
process because the driver is asynchronous so the context which did the
alloc_kiovec etc. has exited when the irq comes later) and see if it works
better.

> BTW, you should also avoid all the kiobuf allocation in all the fast
> paths, try to pre-allocate it in a slow path to deliver higher
> performance. (shortly we'll split the bh/blocks array out of the kiobuf

Ok, that's probably not a problem since the allocation is done in a normal
system-call context.

/Bjorn

