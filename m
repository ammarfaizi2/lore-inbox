Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129845AbRCCXSL>; Sat, 3 Mar 2001 18:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129851AbRCCXRv>; Sat, 3 Mar 2001 18:17:51 -0500
Received: from mozart.stat.wisc.edu ([128.105.5.24]:5135 "EHLO
	mozart.stat.wisc.edu") by vger.kernel.org with ESMTP
	id <S129845AbRCCXRt>; Sat, 3 Mar 2001 18:17:49 -0500
To: Jason Riedy <ejr@CS.Berkeley.EDU>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: changing precision control setting in initial FPU context
In-Reply-To: <200103032100.NAA22606@lotus.CS.Berkeley.EDU>
From: buhr@stat.wisc.edu (Kevin Buhr)
In-Reply-To: Jason Riedy's message of "Sat, 03 Mar 2001 13:00:08 -0800"
Date: 03 Mar 2001 17:17:47 -0600
Message-ID: <vbar90eqw6c.fsf@mozart.stat.wisc.edu>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Riedy <ejr@CS.Berkeley.EDU> writes:
> 
> Note that getting what some people want to call `true' IEEE 754 
> arithmetic on an x86 is frightfully tricky.  Changing the precision
> does not shorten the exponent field, and that can have, um, fun
> effects on and around under/overflow.

Whoops.  This is an important point and something I'd missed.

> What Linux does presently on x86 is as right as right can be on 
> this platform.

I'm not so sure.  If most floating point programs and math libraries
used 80-bit "long double"s (and if GCC did 80-bit arithmetic
correctly, as you seem to imply it doesn't), then I would argue that
the current default is a perfect default.

As it is, I think most C floating point software (that isn't written
by i386 FPU gurus) is written with "double"s, written without
attention to the FPU control word, and compiled with no special
options.  These programs can be made, at least, predictable with
respect to compiler optimizations and compatible with many other
architectures if we change the default to the *BSD choice.

>                                                The *BSD choice is 
> valid by some lines of thought, but it also denies people the happy 
> accident of computing with more precision and range than they thought 
> they needed.

If this "accident" happened reliably when the program was compiled
with and without "-O2", or if this "accident" couldn't be affected by,
say, which branch of an if-else was taken (by means of causing a
reload from a 64-bit memory location in one case and not the other,
for example), and if this accident was compatible with other i386
Unixish operating systems, it would, indeed, be a *happy* accident.
Here, I think it's just an accident.

Someone whose code actually benefits from extra mantissa precision
beyond 53 bits without them understanding the intricacies of i387
programming needs to be pummelled with a stick.  Of course, someone
whose code *breaks* from extra mantissa precision *also* needs to be
pummeled with a stick.  But, in between beatings, I'd still like to
get the default changed.

It seems to me that this issue is a little different from, say, the
"Linux modifies the timeout field in select calls" kind of
incompatibility.  If an FP program under Linux behaved differently
but, at least, reliably and predictably, I wouldn't be bringing this
up.  An incompatibile implementation that *also* leads to bizarre
surprises (with any change to compilation flags, program flow, phase
of the moon, whatever) especially when the alternative, compatible
implementation *doesn't* lead to surprises.... well, that's what has
gotten me up in arms.

> Overall, computing with x86 double-extended is a good
> thing so long as you don't introduce multiple roundings.  That's a
> compiler issue, not a kernel one.

Yes, maybe it is.  The issue as I see it is to set a reasonable,
default floating-point policy without compromising Linux's lazy FPU
context switching---it can't be done in the C library startup code
without a kernel change.  It *could* be done by the compiler (which
would clearly know when a particular function used floating point and
what control word setting was appropriate).  It's something to think
about, at any rate.

Kevin <buhr@stat.wisc.edu>
