Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbTI3Pbe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 11:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261587AbTI3Pbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 11:31:34 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:6022 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S261585AbTI3PbP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 11:31:15 -0400
Date: Tue, 30 Sep 2003 16:30:52 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Dave Jones <davej@redhat.com>, John Bradford <john@grabjohn.com>,
       akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: your mail
Message-ID: <20030930153052.GE28876@mail.shareable.org>
References: <200309300817.h8U8HGrf000881@81-2-122-30.bradfords.org.uk> <20030930133113.GC23333@redhat.com> <20030930140627.GB28876@mail.shareable.org> <20030930145007.GB12812@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030930145007.GB12812@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
>  > I'm not sure what the fuss is; a strict 386 kernel runs just fine
>  > without any problems on an Athlon.  But anyway...
> 
> Unless it got configured away as proposed in your earlier patch.

No, I don't understand.  What about my patch, or indeed anything else,
stops a "strict 386" kernel from running on an Athlon?

>  > The latter is for distro boots.  The former is for that
>  > 386-as-a-firewall with 1MB of RAM, where it _really_ has to trim
>  > everything it can, and no errata thank you.
> 
> Again, 'trimming' away a few hundred bytes of errata workarounds
> is ridiculous when we have bigger fish to fry where we can save
> KBs of .text size, and MB's of runtime memory.

Well I think both are worthwhile.  Low hanging fruit and all that -
this is an example of a small saving that's very clear and easy.

>  > I've not heard of anyone actually wanting a strict 386 kernel lately,
>  > but strict 486 is not so unusual.
> 
> ISTR that current gcc's emit 486 instructions anyway, so its possible
> that with a modern toolchain, you can't *build* a 386 kernel.
> I'm not sure if that got fixed or not, I don't track gcc lists any more.

Afaict GCC has fine targetting for the 386, better than it did years
ago.  It didn't used to use the "leave" instruction, have an option to
optimise for size, or options for selecting exactly which
architectural instruction set it would use.

Anyway, that there is very little difference between 386 and 486 from
an application point of view anyway.  You may be thinking of the
recent C++ ABI debacle, I think it was, which accidentially turned out
to require some instruction emulation in the Debian kernel.  I think
they've fixed it in GCC now.

>  > Just as some people want a P4 optimised kernel, and some people want a
>  > K7 optimised kernel, so some people want a 386 or 486 or Pentium
>  > optimised kernel.  Lowest-common-denominator means it runs on
>  > everything, and isn't really anything to do with 386 any more - that's
>  > not really the lowest-common-denominator, by virtue of the obvious
>  > fact that pure 386 code isn't reliable on all other CPUs.
> 
> Elaborate? "pure 386 code" (whatever that means in your definition)
> should run perfectly reliable on every CPU we care about.

If that were true, why are we talking about needing workarounds for
non-386 chips to work correctly?

The canonical example is the F00F sequence: reliable on a 386, crashes
a Pentium.  That's a fine example of pure 386 code not being reliable
on a higher CPU.  And that's why it isn't safe to run Linux 1.0 on
your Pentium web server.

> So first you argue for compiling out a few hundred bytes of errata
> workaround, now you want to instead compile in checks & printk's
> (which probably add up to not far off the same amount of space).

Oh, I have nothing against __init space :)

>  > By selecting a PII kernel, it is possible to configure out the code
>  > for X86_PPRO_FENCE and X86_F00F_BUG, yet as far as I can tell, those
>  > _can_ possibly boot on kernels where the errata are needed, and nary a
>  > printk is emitted for it.  Nasty bugs they are, too.
> 
> Indeed. That's arguably a bug that occured when someone split the
> original CONFIG_M686 into _M686 & MPENTIUMII.

It's a bit more complicated.  It dates from before we had the
"alternative" macro, and it was still cool to optimise spin_unlock()
into the most minimal instruction sequence at compile time.

It's only since then that we've been generalising to "M586 should run
on all later models correctly".  Arguably, tidying up in the process.

Now we could use "alternative" to put the locked store or non-locked
store there and it would not look out of place.

If we're honest, Linux seems to have evolved through the 2.5 series
from "optimise the primitives as tight as reasonable for a target
architecture" to "a few nops here and there won't hurt".  Perhaps
Transmeta's malign influence, as nops cost virtually nothing on those :)

Or perhaps it's because CPU models have branched and don't make a
straight line any more.  So we have to do more run-time checking to
keep it sane.

>  > More generally than the CPU, you can also configure out BLK_DEV_RZ1000
>  > which is another crucial workaround that needs to go in any
>  > lowest-common-denominator kernel.
> 
> I wouldn't look at the history of drivers/ide/ as a shining example of
> good design 8-)

No, but as an example of needing to enable all the workarounds for a
distro boot kernel, it's a glorious gem.  Even now people aren't quite
sure if multi-sector mode or DMA should be enabled by default :)

>  > Basically, if you're building a
>  > distro boot kernel, you must turn on all known workarounds.  That's
>  > certainly lowest-common-denominator, but it's a far cry from the
>  > configuration that a 386-as-firewall user wants.
> 
> Ok, I see what you're getting at, but Adrian's patch turned arch/i386/Kconfig
> and arch/i386/Makefile into guacamole.  After spending so much time
> getting that crap into something maintainable, it seemed a huge step
> backwards to litter it with dozens of ifdefs and duplication.
> There has to be a cleaner way of pleasing everyone.

Perhaps it's in a name.  It doesn't help that there's an assumed
linear progression of CPUs to support, up to the point where they
branch off all over the place in feature space.  In the linear part,
CONFIG_M586, CONFIG_M686 etc. seem to mean "support this CPU or
later", whatever later means (and it's not stated exactly).  After the
explosion of different feature directions, they stop meaning that and
just become optimisation knobs, as all the different essential features
are supported at run time.

Personally I think Adrian's patch's heart is in the right place,
simply because the menu options make more sense than the present
rather confusion decision, if you intend to (or might ever, take your
pick) run a kernel compiled for one CPU on another.  I am never sure,
for example, if it's safe to take the hard disk from my K6 and drop it
into a P5MMX box and boot from it.  The kernel config just doesn't
make that clear.

With Adrian's it does, even if the code behind it is a little like
guacamole.  Perhaps the code could be cleaner; I don't see that
individual CPU model support is much different than what we already
have, except for the option to fix features at compile time rather than
run time.

And that gives me an idea.... ;)

-- Jamie
