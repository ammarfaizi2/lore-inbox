Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129860AbRCAVzz>; Thu, 1 Mar 2001 16:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130020AbRCAVzq>; Thu, 1 Mar 2001 16:55:46 -0500
Received: from colorfullife.com ([216.156.138.34]:60932 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129860AbRCAVza>;
	Thu, 1 Mar 2001 16:55:30 -0500
Message-ID: <3A9EC563.C450FAD3@colorfullife.com>
Date: Thu, 01 Mar 2001 22:55:47 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17-14 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Hemment <markhe@veritas.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Q: explicit alignment control for the slab allocator
In-Reply-To: <Pine.LNX.4.21.0103012011160.11260-100000@alloc>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hemment wrote:
> 
> On Thu, 1 Mar 2001, Manfred Spraul wrote:
> 
> > Mark Hemment wrote:
> > >
> > >   The original idea behind offset was for objects with a "hot" area
> > > greater than a single L1 cache line.  By using offset correctly (and to my
> > > knowledge it has never been used anywhere in the Linux kernel), a SLAB
> > > cache creator (caller of kmem_cache_create()) could ask the SLAB for more
> > > than one colour (space/L1 cache lines) offset between objects.
> > >
> >
> > What's the difference between this definition of 'offset' and alignment?
> 
>   The positioning of the first object within a slab (at least that is how
> it is suppose to work).
> 
>   The distance between all objects within a slab is constant, so the
> colouring of objects depends upon the cache line (offset) the first object
> is placed on.
>   The alignment is the boundary objects fall upon within a slab.  This may
> require 'padding' between the objects so they fall on the correct
> boundaries (ie. they aren't a 'natural' size).
>   For kmem_cache_create(), a zero offset means the offset is the same as
> the alignment.
> 
>   Take the case of offset being 64, and alignment being 32.
>   Here, the allocator attempts to place the first object on a 64byte
> boundary (say, at offset 0), and all subsequent objects (within the same
> cache) on a 32byte boundary.
>   Now, when it comes to construct the next slab, it tries to place the
> first object 64bytes offset from the first object in the previous
> slab (say, at offset 64).  The distance between the objects is still the
> same - ie. they fall on 32byte boundaries.
> 
>   See the difference?
>

Yes, I see the difference, but I'm not sure that it will work as
intended.
offset must be a multiple of the alignment, everything else won't work.

In which cases an offset > alignment is really a win?

Obviously using offset 32 bytes for a structure with a 64 byte hot zone
means that 2 slabs with a different "color" compete for the same cache
lines [just assuming 32 byte cache lines for simplicity] in 50% of the
cases, but otoh offset==64 halfs the number of possible colors.

--
	Manfred
