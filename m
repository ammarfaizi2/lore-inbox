Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318158AbSG2VAG>; Mon, 29 Jul 2002 17:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318159AbSG2VAG>; Mon, 29 Jul 2002 17:00:06 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27654 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318158AbSG2VAE>;
	Mon, 29 Jul 2002 17:00:04 -0400
Message-ID: <3D45AD1B.864458B@zip.com.au>
Date: Mon, 29 Jul 2002 14:01:15 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH 2.5] Introduce 64-bit versions of 
 PAGE_{CACHE_,}{MASK,ALIGN}
References: <5.1.0.14.2.20020728193528.04336a80@pop.cus.cam.ac.uk> <Pine.LNX.4.44.0207281622350.8208-100000@home.transmeta.com> <3D448808.CF8D18BA@zip.com.au> <20020729004942.GL1201@dualathlon.random> <3D44A2DF.F751B564@zip.com.au> <20020729205211.GB1201@dualathlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> On Sun, Jul 28, 2002 at 07:05:19PM -0700, Andrew Morton wrote:
> > But yes, all of this is a straight speed/space tradeoff.  Probably
> > some of it should be ifdeffed.
> 
> I would say so. recalculating page_address in cpu core with no cacheline
> access is one thing, deriving the index is a different thing.
> 
> > The cost of the tree walk doesn't worry me much - generally we
> > walk the tree with good locality of reference, so most everything is
> > in cache anyway.
> 
> well, the rbtree showedup heavily when it started growing more than a
> few steps, it has less locality of reference though.
> 
> >    Good luck setting up a testcase which does this ;)
> 
> a gigabit will trigger it in a millisecond. of course nobody tested it
> either I guess (I guess not many people tested the 800Gbyte offset
> either in the first place).

There's still the mempool.

We could perform a GFP_KERNEL replenishment of the ratnode mempool
after the page_cache_alloc(), and before taking any locks, if
that's needed.

> > Then again, Andi says that sizeof(struct page) is a problem for
> > x86-64.
> 
> not true.
> 
> > No recursion needed, no allocations needed.
> 
> the 28 bytes if they're on the stack they're like recursion, just using
> an interactive algorithm.
> 
> you're done with 28 bytes with a max 7/8 level tree, so 7*4 = 28 (4 size
> of pointer/long). On a 32bit arch the max index supported is
> 2^32, on a 64bit arch the max index supported is
> 2^(64-PAGE_CACHE_SHFIT), plus each pointer is 8 bytes. You may want to
> do the math to verify if you've enough stack to walk the tree in order,
> it's not obvious.

I make that 144 bytes of stack.

-
