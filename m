Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318136AbSG2VpD>; Mon, 29 Jul 2002 17:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318138AbSG2VpD>; Mon, 29 Jul 2002 17:45:03 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18440 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318136AbSG2VpC>;
	Mon, 29 Jul 2002 17:45:02 -0400
Message-ID: <3D45B79F.D228226@zip.com.au>
Date: Mon, 29 Jul 2002 14:46:07 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH 2.5] Introduce 64-bit versions of 
 PAGE_{CACHE_,}{MASK,ALIGN}
References: <5.1.0.14.2.20020728193528.04336a80@pop.cus.cam.ac.uk> <Pine.LNX.4.44.0207281622350.8208-100000@home.transmeta.com> <3D448808.CF8D18BA@zip.com.au> <20020729004942.GL1201@dualathlon.random> <3D44A2DF.F751B564@zip.com.au> <20020729205211.GB1201@dualathlon.random> <3D45AD1B.864458B@zip.com.au> <20020729213132.GG1201@dualathlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> On Mon, Jul 29, 2002 at 02:01:15PM -0700, Andrew Morton wrote:
> > Andrea Arcangeli wrote:
> > >
> > > On Sun, Jul 28, 2002 at 07:05:19PM -0700, Andrew Morton wrote:
> > > > But yes, all of this is a straight speed/space tradeoff.  Probably
> > > > some of it should be ifdeffed.
> > >
> > > I would say so. recalculating page_address in cpu core with no cacheline
> > > access is one thing, deriving the index is a different thing.
> > >
> > > > The cost of the tree walk doesn't worry me much - generally we
> > > > walk the tree with good locality of reference, so most everything is
> > > > in cache anyway.
> > >
> > > well, the rbtree showedup heavily when it started growing more than a
> > > few steps, it has less locality of reference though.
> > >
> > > >    Good luck setting up a testcase which does this ;)
> > >
> > > a gigabit will trigger it in a millisecond. of course nobody tested it
> > > either I guess (I guess not many people tested the 800Gbyte offset
> > > either in the first place).
> >
> > There's still the mempool.
> 
> that's hiding the problem at the moment, it's global, it doesn't provide
> any real guarantee.

Sizing the mempool to max_cpus * max tree depth provides a guarantee,
provided you take care of context switches, which is pretty easy.

> ...
> 
> so it's not too bad in terms of stack because there's not going to be
> more than one walk at time, thanks for doing the math btw. You'd
> basically need a second radix tree for the dirty pages (using the same
> radix tree is not an option because it would increase pdflush complexity
> too much with terabytes of clean pages in the tree).

Not sure.  If each ratnode has a 64-bit bitmap which represents
dirty pages if it's a leaf node, or nodes which have dirty pages
if it's a higher node then the "find the next 16 dirty pages above index
N" is a pretty efficient thing.

Tricky to code though.
