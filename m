Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317458AbSGJF2S>; Wed, 10 Jul 2002 01:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317465AbSGJF2R>; Wed, 10 Jul 2002 01:28:17 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:181 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S317458AbSGJF2Q>;
	Wed, 10 Jul 2002 01:28:16 -0400
Date: Wed, 10 Jul 2002 01:30:59 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Dave Hansen <haveblue@us.ibm.com>
cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Robert Love <rml@mvista.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Rick Lindsley <ricklind@us.ibm.com>, Greg KH <greg@kroah.com>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: BKL removal
In-Reply-To: <3D2B4C42.4090404@us.ibm.com>
Message-ID: <Pine.GSO.4.21.0207100050050.3293-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 9 Jul 2002, Dave Hansen wrote:

> I have the feeling that the filesystems' use of lots of function 
> pointers will add a large amount of complexity to whatever programming 
> any checker would require.  Bill Irwin and I were discussing it and we 
> have ways of getting around most of them, but there are _lots_ of 
> special cases.

The real complexity is _not_ on compiler level.  Checker manages that
quite fine.  The problem is in the coverage - making sure that code
gets to compiler is much, much more painful.
 
> > Normally it's not that bad, but "can this function block?" is very nasty
> > in that respect - changes of configuration can and do affect that in
> > non-trivial ways.
> 
> I also wonder how it handles things like kmalloc(), which can block 
> depending on arguments.

Not a big deal - checker can be taught how kmalloc() works (normally we
either pass it explict constant or an argument of calling function -
without any changes).

Again, the real mess is due to the way we use cpp.  It would be wonderful if
we had 4-6 options really affecting stuff (changing structure sizes, etc.)
and everything else would be handled either on compiler (
	if (CONFIG_FOO) {
		...
	}
and let compiler eliminate dead branches) or on the linker (
obj-$(CONFIG_BAR) += bar.o
) level.  Then the life would be _way_ easier and we would really have
a chance to do a meaningful coverage.

As it is, we have way too many ifdefs to hope that any automated tool
would be able to cope with the damn thing.  It used to be worse -
these days several really nasty piles of ifdefs are gone.  However,
we still have quite a few remaining.

Quick-and-dirty search shows ~1.2e4 ifdefs on CONFIG_... in the tree.
Most of them - patently ridiculous (random example: fs/ncpfs/symlink.c
/*
 <usual comments in the beginning>
 */

#include <linux/config.h>

#ifdef CONFIG_NCPFS_EXTRAS
<lots of stuff>
#endif

/* ----- EOF ----- */ 

which should be

ifneq ($(CONFIG_NCPFS_EXTRAS),n)
ifneq ($(CONFIG_NCPFS_EXTRAS),)
ncpfs-objs += symlink.o
endif
endif

in Makefile and none of the crap in symlink.c).

However, there's really bad stuff and it also has to be dealt with...

