Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129065AbRBVLcF>; Thu, 22 Feb 2001 06:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129199AbRBVLbz>; Thu, 22 Feb 2001 06:31:55 -0500
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:56534 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S129111AbRBVLbl>; Thu, 22 Feb 2001 06:31:41 -0500
Date: Thu, 22 Feb 2001 12:31:37 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [rfc] Near-constant time directory index for Ext2
Message-ID: <20010222123137.T724@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <200102220203.f1M237Z20870@webber.adilger.net> <3A947C54.E4750E74@transmeta.com> <3A948ACB.7B55BEAE@innominate.de> <97230a$16k$1@penguin.transmeta.com> <9727hh$1e7$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <9727hh$1e7$1@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Feb 21, 2001 at 09:19:45PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
Hi LKML people,

On Wed, Feb 21, 2001 at 09:19:45PM -0800, Linus Torvalds wrote:
> In article <97230a$16k$1@penguin.transmeta.com>,
> Linus Torvalds <torvalds@transmeta.com> wrote:
> >allocate blocks one at a time. Make the blocksize something nice and
> >big, not just 4kB or 8kB or something.
> 
> Btw, this is also going to be a VM and performance issue some time in
> the future.  Tgere are already CPU's that would _love_ to have 64kB
> pages etc, and as such a filesystem that doesn't play with the old silly
> "everthing is a block" rules would be much appreciated with the kind of
> people who have multi-gigabyte files and want to read in big chunks at a
> time. 
 
For this we need a block remapper layer that can map any
blocksize n to any blocksize m with only the following constraints:

   - n and m are powers of 2
   - n is a multiple of m

Both should use the page cache ( of size p) of course, so it
becomes 2 layers, if n > p.

   -  translating a buffer of n into some pages
   -  translating a page into buffers of m (current buffercache)

We could limit the translation to 5 powers of 2 obove and 5 powers of 2
below PAGE_CACHE_SIZE so that we can maintain a validity bitmap
(2^5 = 32 bits) for each layer if access is too expensive[1].

Some subsystems could certainly benefit from it.

   -  loop device (with all the crypto stuff)
   -  LVM
   -  FSes that support block sizes != PAGE_CACHE_SIZE
   -  Devices with blocksize != 512 (they don't have to care
      being special anymore). There are even some rumors
      about very pervert blocksizes of 1M and the like.

Since these remapped buffers will look like merged requests, I
see even no problems with the elevator any more.

The question is, where we implement this infrastructure, esp. if
we consider the last user (devices with blocksize != 512).

This has to be answered by the main architects of Linux before
anyone could start.

> So either you have a simple block-based filesystem (current ext2, no
> extents, no crapola), or you decide to do it over.  Don't do some
> half-way thing, please. 

Daniel (and others) uses ext2 as as a playground, because it is
implemented, tested and not that hard to understand and verify.

Hope they will switch to some own design later, once they
sufficiently played around with^W^W^Wtested their ideas.

Regards

Ingo Oeser

[1] In buffer cache we use read-modify-write for partial pages,
   which hurts performance for them and is annoying for media
   with limited write cycles like flash and CD-RW[2].

[2] Yes I know about packet writing mode ;-)
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<       come and join the fun       >>>>>>>>>>>>
