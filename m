Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267879AbRGVDpM>; Sat, 21 Jul 2001 23:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267881AbRGVDpC>; Sat, 21 Jul 2001 23:45:02 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:61455 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267879AbRGVDop>; Sat, 21 Jul 2001 23:44:45 -0400
Date: Sat, 21 Jul 2001 20:43:43 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Richard Henderson <rth@twiddle.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Why Plan 9 C compilers don't have asm("")
In-Reply-To: <20010721151055.A3676@twiddle.net>
Message-ID: <Pine.LNX.4.33.0107212017470.6166-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


On Sat, 21 Jul 2001, Richard Henderson wrote:
>
> >   Even the "good" Digital compilers tended to nop out unnecessary
> >   instructions rather than remove them, causing more icache pressure on
> >   a CPU that was already famous for needing tons of icache ]
>
> But you're absolutely right about the nopping -- removing the nops would
> require debug info and EH info to be re-coded.  The later being a matter
> of correctness.  This is a bit nastier than I ever cared to deal with.

I don't see it as being all that nasty.  It's only nasty if you make the
compiler default to the long form - because it's so hard to reduce the
size later (branches around call-sites etc). But if you make the compiler
default to the short form, you're ok - you can trivially expand the short
form later without any of the same problems.

Isn't this what mips32 used to do too - it didn't have the GP reload
issue, but it has 16-bit branch offsets if I remember correctly. So they
ended up adding trampoline branches on demand later. And a 16-bit branch
offset is a lot more constraining than a 20-bit one. 128kB is not a huge
jump, but 2MB is getting to be pretty far in most applications..

So:
 - you _always_ generate the fast case. A call is always considered to be
   a short one, simple "bsr", no GP change, no nothing.
 - you generate a trampoline as well, and teach the linker to go through
   the trampoline if it has to do a far call (one trampoline per target,
   not per caller). Think of it as a "overflow" case for a .rel20.
 - If it's not a weak reference and you can satisfy it at link-time, you
   can obviously just get rid of the trampoline then and there. This takes
   care of all the normal "intra-GP" things.

Sure, if you want to be fancy, you also drop unused GOT entries for
anything that ends up not having a trampoline.

So the above takes care of correctness. For bonus points, you allow the
user to specify "this will be a far call (or weak)" as an attribute, which
you use on intra-modules code. Which is almost entirely library
interfaces, so you'd have the system header files use this so that shared
library calls don't get the hit of the trampoline.

As far as I can see, this should take care of about 99% of all static
jumps.  Most applications have less than 2MB code-space, and the only real
reason for the long form is for intra-module calls which tend to be fairly
well specified (ie they are declared in standard headers etc).

Sure, you could sometimes get the slower case: more than a 2MB offset
within a module, so that you'd have to use the trampoline, or if you're
lazy and don't update the headers for dynamically linked libraries. But
even then there would be the potential for icache win. And you could
always have a "-mlarge-model" compiler option for those cases, so if you
notice that you lose on this optimization, you just disable it.

No?

		Linus

