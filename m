Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317278AbSG1UVR>; Sun, 28 Jul 2002 16:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317299AbSG1UVR>; Sun, 28 Jul 2002 16:21:17 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:19544 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S317278AbSG1UVQ>; Sun, 28 Jul 2002 16:21:16 -0400
To: Anton Altaparmakov <aia21@cantab.net>
Cc: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH 2.5] Introduce 64-bit versions of  PAGE_{CACHE_,}{MASK,ALIGN}
References: <3D42D706.9899A4A0@zip.com.au>
	<E17YRp5-0006H6-00@storm.christs.cam.ac.uk>
	<3D42D706.9899A4A0@zip.com.au>
	<5.1.0.14.2.20020728193528.04336a80@pop.cus.cam.ac.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 28 Jul 2002 14:12:30 -0600
In-Reply-To: <5.1.0.14.2.20020728193528.04336a80@pop.cus.cam.ac.uk>
Message-ID: <m1it2zhas1.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov <aia21@cantab.net> writes:

> At 18:53 28/07/02, Eric W. Biederman wrote:
> >Andrew Morton <akpm@zip.com.au> writes:
> > > Anton Altaparmakov wrote:
> > > >
> > > > Linus,
> > > >
> > > > This patch introduces 64-bit versions of PAGE_{CACHE_,}MASK and
> > > > PAGE_{CACHE_,}ALIGN:
> > > >         PAGE_{CACHE_,}MASK_LL and PAGE_{CACHE_,}ALIGN_LL.
> > > >
> > > > These are needed when 64-bit values are worked with on 32-bit
> > > > architectures, otherwise the high 32-bits are destroyed.
> > > >
> > > > ...
> > > >  #define PAGE_SIZE      (1UL << PAGE_SHIFT)
> > > >  #define PAGE_MASK      (~(PAGE_SIZE-1))
> > > > +#define PAGE_MASK_LL   (~(u64)(PAGE_SIZE-1))
> > >
> > > The problem here is that we've explicitly forced the
> > > PAGE_foo type to unsigned long.
> > >
> > > If we instead take the "UL" out of PAGE_SIZE altogether,
> > > the compiler can then promote the type of PAGE_SIZE and PAGE_MASK
> > > to the widest type being used in the expression (ie: long long)
> > > and everything should work.
> > >
> > > Which seems to be a much cleaner solution, if it works.
> > >
> > > Will it work?

With the current set of macros I will agree that it becomes error
prone, to use large offsets.  So perhaps we should just provide
the larger type in the MASK and ALIGN functions.  Having to track
if you are using a 64bit type to closely is problematic.   An alternative
is to ignore the ALIGN macro and provide PAGE_OFFSET instead of PAGE_MASK,
which keeps the supplied values small.

> I will reply to that point later, I want to do some experiments with gcc
> first... I think it may work due to signextension but that implies the value
> must be signed which is of course implied by leaving out the "UL"... I will try
> it and report results...

It would also be interesting to see if the value was ULL if it would make the
code worse.

> 
> >I don't quite see the point of this work.
> >
> >There is exactly one operation that must be done in 64bit.
> >if (my64bitval > max) {
> >         return -E2BIG;
> >}
> >After that the value can be broken into, an index/offset pair.
> >Which is how the data is used in the page cache.
> 
> Why should I need to bother with index/offset? It is much more natural to work
> with bytes.  Also ntfs has to convert back and forth to bytes (internal NTFS
> storage for sizes is s64 in units of bytes in many places), ntfs clusters,
> pages, and buffer heads which are all different sizes so your approach would be
> a complete code mess.

For the internals of ntfs, and similar systems I will concede that a 64bit value
may be a more natural intermediate type.  This doesn't mean we need to do
weird things in the generic code.

> Also the page cache limit of 32-bit index is IMO not good and needs to be
> removed. The code needs to be able to cope with true 64-bits. We already have
> sector_t that can be defined to 64-bit. Once it is used everywhere it will be
> relatively easy to do something simillar for struct page. Of course people are
> going to scream so it will just be a compile time option. Or even just an out of
> 
> tree patch but still I consider 64-bit support on 32-bit architectures very
> important in the future and I belive I am not alone seeing Matt Domsch (sp?)'s
> comments for example... I guess it boils down to how quickly the 64-bit cpus
> will become standard comodity hardware vs how quick available storage will blow
> the 32-bit page cache limit...

The page cache limit is currently 44bits/16TB on x86.  Current drives
are currently running at about 37-38 bits.  Which means it takes about
64 drives to blow the current page cache.  So we probably have 2 or 3
years before this becomes a concern with commodity hardware.  And we
should have commodity 64bit cpus by then.  We can afford to
hold off a little longer.

For disk sizes we need the larger sector_t simply because drives
really are exceeding it, today.

Eric
