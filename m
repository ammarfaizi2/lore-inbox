Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129858AbRCAUXG>; Thu, 1 Mar 2001 15:23:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129865AbRCAUWz>; Thu, 1 Mar 2001 15:22:55 -0500
Received: from bacchus.veritas.com ([204.177.156.37]:59610 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S129858AbRCAUWi>; Thu, 1 Mar 2001 15:22:38 -0500
Date: Thu, 1 Mar 2001 20:28:35 +0000 (GMT)
From: Mark Hemment <markhe@veritas.com>
To: Manfred Spraul <manfred@colorfullife.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Q: explicit alignment control for the slab allocator
In-Reply-To: <3A9EA940.CB82665C@colorfullife.com>
Message-ID: <Pine.LNX.4.21.0103012011160.11260-100000@alloc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Mar 2001, Manfred Spraul wrote:

> Mark Hemment wrote:
> > 
> >   The original idea behind offset was for objects with a "hot" area
> > greater than a single L1 cache line.  By using offset correctly (and to my
> > knowledge it has never been used anywhere in the Linux kernel), a SLAB
> > cache creator (caller of kmem_cache_create()) could ask the SLAB for more
> > than one colour (space/L1 cache lines) offset between objects.
> >
> 
> What's the difference between this definition of 'offset' and alignment?

  The positioning of the first object within a slab (at least that is how
it is suppose to work).

  The distance between all objects within a slab is constant, so the
colouring of objects depends upon the cache line (offset) the first object
is placed on.
  The alignment is the boundary objects fall upon within a slab.  This may
require 'padding' between the objects so they fall on the correct
boundaries (ie. they aren't a 'natural' size).
  For kmem_cache_create(), a zero offset means the offset is the same as
the alignment.

  Take the case of offset being 64, and alignment being 32.
  Here, the allocator attempts to place the first object on a 64byte
boundary (say, at offset 0), and all subsequent objects (within the same
cache) on a 32byte boundary.
  Now, when it comes to construct the next slab, it tries to place the
first object 64bytes offset from the first object in the previous
slab (say, at offset 64).  The distance between the objects is still the
same - ie. they fall on 32byte boundaries.

  See the difference?

> alignment means that (addr%alignment==0)
> offset means that (addr1-addr2 == n*offset)
> 
> Isn't the only difference the alignment of the first object in a slab?

  Yes (as explained above).  It is important.
 
> Some hardware drivers use HW_CACHEALIGN and assume certain byte
> alignments, and arm needs 1024 byte aligned blocks.

  I should have put a big comment in the allocator, saying aligment/offset
are only hints to the allocator and not guarantees.
  Unfortunately, the allocator was always returning L1 aligned objects
with HW_CACHEALIGN, so folks started to depend on it.  Too late to break
that now.
  It sounds as if HW_CACHEALIGN has been broken by a config option, and
this needs to be fixed.
  But leave 'offset' alone?!  If it isn't working as described above, then
it needs fixing, but don't change its definition.

Mark

