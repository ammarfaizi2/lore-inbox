Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317928AbSFSQ2T>; Wed, 19 Jun 2002 12:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317929AbSFSQ2S>; Wed, 19 Jun 2002 12:28:18 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:1810 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317928AbSFSQ2R>; Wed, 19 Jun 2002 12:28:17 -0400
Date: Wed, 19 Jun 2002 09:28:40 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: latest linus-2.5 BK broken 
In-Reply-To: <E17KhJj-0001Pb-00@wagner.rustcorp.com.au>
Message-ID: <Pine.LNX.4.44.0206190907520.2053-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 20 Jun 2002, Rusty Russell wrote:
> > and then add a few simple operations like
> >
> > 	cpumask_and(cpu_mask_t * res, cpu_mask_t *a, cpu_mask_t *b);
>
> Sure... or just make all archs supply a "cpus_online_of(mask)" which
> does that, unless there are other interesting cases.  Or we can go the
> other way and have a general "and_region(void *res, void *a, void *b,
> int len)".  Which one do you want?

There are definitely other "interesting" cases that already do the full
bitwise and/or on bitmasks - see sigset_t and sigaddset/sigdelset/
sigfillset. It's really the exact same code, and the exact same issues.

The problem with a generic "and_region" is that it's a slight amount of
work to make sure that we optimize for the common cases (and since I'm not
a huge believer in hundreds of nodes, I consider the common case to be a
single word). And do things like just automatically get the UP case right:
which we do right now by just virtue of having a constant cpu_online_mask,
and letting the compiler just do the (obvious) optimizations.

I'm a _huge_ believer in having generic code that is automatically
optimized away by the compiler into nothingness. (And by contrast, I
absolutely _detest_ #ifdef's in source code that makes those optimizations
explicit). But that sometimes requires some thought, notably making sure
that all constants hang around as constants all the way to the code
generation phase (this tends to mean inline functions and #defines).

It _would_ probably be worthwhile to try to have better support for
"bitmaps" as real kernel data structures, since we actually have this
problem in multiple places. Right now we already use bitmaps for signal
handling (one or two words, constant size), for FD_SET's (variable size),
for various filesystems (variable size, largish), and for a lot of random
drivers (some variable, some constant).

It wasn't that long ago that I added a "bitmap_member()" macro to
<linux/types.h> to declare bitmaps exactly because a lot of people _were_
doing it and getting it wrong. Actually, the most common case was not a
bug, but a latent problem with code that did something like

	unsigned char bitmap[BITMAP_SIZE/8];

which works on x86 as long as the bitmap size was a multiple of 8.

It would probably make sense to make a real <linux/bitmap.h>, move the
bitmap_member() there (and rename to "bitmap_declare()" - it's called
member because all the places I first looked at were structure members),
and add some simple generic routines for handling these things.

(We've obviously had the bit_set/clear/test() stuff forever, but the more
involved stuff should be fairly easy to abstract out too, instead of
having special functions for signal masks).

> Breaking userspace code does.  One can be fixed if it proves to be a
> bottleneck.  Understand?

What I don't understand is why you don't accept the fact that these
things can be considered infinitely big. There's nothing fundamentally
wrong with static allocation.

People who build thousand-node systems _are_ going to compile their own
distribution. Trust me. They aren't just going to slap down redhat-7.3 on
a 16k-node ASCI Purple. It makes no sense to do that. They may want to run
quake or something standard on it without recompiling, but especially the
maintenance stuff - the stuff which cares about CPU affinity - is a
nobrainer.

So you can easily just accept the fact that at some point the max number
of CPU's can be considered fixed. And that "some point" isn't even very
high, especially since bitmaps _are_ so dense that there is basically no
overhead to just starting out with

	#define MAX_CPU (1024)

	bitmap_declare(cpu_bitmap, MAX_CPU);

and let it be at that. That 1024 is already ridiculously high, in my
opinion - simply because people who are playing with bigger numbers _are_
going to be able to just increase the number and recompile.

		Linus

