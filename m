Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317918AbSG2WO1>; Mon, 29 Jul 2002 18:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318049AbSG2WO0>; Mon, 29 Jul 2002 18:14:26 -0400
Received: from [195.223.140.120] ([195.223.140.120]:18706 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S317918AbSG2WOW>; Mon, 29 Jul 2002 18:14:22 -0400
Date: Tue, 30 Jul 2002 00:18:52 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH 2.5] Introduce 64-bit versions of PAGE_{CACHE_,}{MASK,ALIGN}
Message-ID: <20020729221852.GI1201@dualathlon.random>
References: <5.1.0.14.2.20020728193528.04336a80@pop.cus.cam.ac.uk> <Pine.LNX.4.44.0207281622350.8208-100000@home.transmeta.com> <3D448808.CF8D18BA@zip.com.au> <20020729004942.GL1201@dualathlon.random> <3D44A2DF.F751B564@zip.com.au> <20020729205211.GB1201@dualathlon.random> <3D45AD1B.864458B@zip.com.au> <20020729213132.GG1201@dualathlon.random> <3D45B79F.D228226@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D45B79F.D228226@zip.com.au>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2002 at 02:46:07PM -0700, Andrew Morton wrote:
> Andrea Arcangeli wrote:
> > 
> > On Mon, Jul 29, 2002 at 02:01:15PM -0700, Andrew Morton wrote:
> > > Andrea Arcangeli wrote:
> > > >
> > > > On Sun, Jul 28, 2002 at 07:05:19PM -0700, Andrew Morton wrote:
> > > > > But yes, all of this is a straight speed/space tradeoff.  Probably
> > > > > some of it should be ifdeffed.
> > > >
> > > > I would say so. recalculating page_address in cpu core with no cacheline
> > > > access is one thing, deriving the index is a different thing.
> > > >
> > > > > The cost of the tree walk doesn't worry me much - generally we
> > > > > walk the tree with good locality of reference, so most everything is
> > > > > in cache anyway.
> > > >
> > > > well, the rbtree showedup heavily when it started growing more than a
> > > > few steps, it has less locality of reference though.
> > > >
> > > > >    Good luck setting up a testcase which does this ;)
> > > >
> > > > a gigabit will trigger it in a millisecond. of course nobody tested it
> > > > either I guess (I guess not many people tested the 800Gbyte offset
> > > > either in the first place).
> > >
> > > There's still the mempool.
> > 
> > that's hiding the problem at the moment, it's global, it doesn't provide
> > any real guarantee.
> 
> Sizing the mempool to max_cpus * max tree depth provides a guarantee,
> provided you take care of context switches, which is pretty easy.

I guess I still prefer the GFP_KERNEL fallback because it avoids to
waste/reserve lots of ram, but I only care about correctness, the
current code isn't correct, doing max_cpus * max tree depth would
satisfy me completely too (saving ram is a lower prio), so it's up to
you as far as it cannot fail unless it's truly oom (i.e. you need a
GFP_KERNEL in your way).

> 
> > ...
> > 
> > so it's not too bad in terms of stack because there's not going to be
> > more than one walk at time, thanks for doing the math btw. You'd
> > basically need a second radix tree for the dirty pages (using the same
> > radix tree is not an option because it would increase pdflush complexity
> > too much with terabytes of clean pages in the tree).
> 
> Not sure.  If each ratnode has a 64-bit bitmap which represents
> dirty pages if it's a leaf node, or nodes which have dirty pages
> if it's a higher node then the "find the next 16 dirty pages above index
> N" is a pretty efficient thing.

You will have """only""" 18 layers, but scanning through 2**(6*18)
entries will take too long time even if only entry takes 1 nanosecond to
scan. Of course that's the extreme case, but still it should be too much
in practice. I doubt you can avoid at least an additional infrastructure
that tells you if any of the underlying ratnodes has any dirty page,
which will probably save ram at least because it can be coded as a
bitflag in each node, but that will force you an up-walk of the tree
every time you mark a page dirty (but of course also a second tree would
force you to do some tree every time you mark a page dirty/clean). The
second tree probably allows you not to go into the radix-tree
implementation details to provide the "underlying node dirty page" info,
and it would be faster if for example only the start of the inode has
dirty pages, that would allow the dirty page flushing to walk only a few
levels instead of potential 18 of them even to reach the first  few
pages. But I don't think it's a common case, so probably the best
(but not simpler) approch is to mark each ratnode with a dirty
cumulative information.

Andrea
