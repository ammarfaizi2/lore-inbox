Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130428AbRCCHMh>; Sat, 3 Mar 2001 02:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130429AbRCCHM2>; Sat, 3 Mar 2001 02:12:28 -0500
Received: from mozart.stat.wisc.edu ([128.105.5.24]:38158 "EHLO
	mozart.stat.wisc.edu") by vger.kernel.org with ESMTP
	id <S130428AbRCCHMO>; Sat, 3 Mar 2001 02:12:14 -0500
To: linux-kernel@vger.kernel.org
cc: adam@yggdrasil.com, drepper@cygnus.com
Subject: RFC: changing precision control setting in initial FPU context
From: buhr@stat.wisc.edu (Kevin Buhr)
Date: 03 Mar 2001 01:12:13 -0600
Message-ID: <vbaelwfwcky.fsf@mozart.stat.wisc.edu>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A question recently came up in "c.o.l.d.s"; actually, it was a comment
on Slashdot that had been cross-posted to 15 Usenet groups by some
ignoramus.  It concerned a snippet of C code that cast a double to int
in such a way as to get a different answer under i386 Linux than under
the i386 free BSDs and most non-i386 architectures.  In fact, the
exact same assembly, running under Linux and under FreeBSD on the same
machine, reportedly gave different results.

For those who might care,

#include <stdio.h>
int main()
{
        int a = 10;
        printf("%d %d\n", 
                /* now for some BAD CODE! */
                (int)( a*.3 +  a*.7),   /* first expression */
                (int)(10*.3 + 10*.7));  /* second expression */
        return 0;
}

when compiled under GCC *without optimization*, will print "9 10" on
i386 Linux and "10 10" most every place else.  (And, by the way, if
you sit down with a pencil and paper, you'll find that IEEE 754
arithmetic in 32-bit, 64-bit, or 80-bit precision tells us that
floor(10*.3 + 10*.7) == 10, not 9.)

It boils down to the fact that, under i386 Linux, the FPU control word
has its precision control (PC) set to 3 (for 80-bit extended
precision) while under i386 FreeBSD, NetBSD, and others, it's set to 2
(for 64-bit double precision).  On other architectures, I assume
there's usually no mismatch between the C "double" precision and the
FPU's default internal precision.

<details>
   To be specific, under Linux, the first expression takes 64-bit
   versions of the constants 0.3 and 0.7 (each slightly less than the
   true values of 0.3 and 0.7), and does 80-bit multiplies and an add
   to get a number slightly less than 10.  This gets truncated to 9.
   On the other hand, under the BSDs, the 64-bit add rounds upward
   before the truncation, giving the answer "10".

   The second expression always produces 10 (and, with -O2, the first
   also produces 10), probably because GCC itself either does all the
   constant optimization arithmetic (including forming the constants
   0.3 and 0.7) in 80 bits or stores the interim results often enough
   in 64-bit registers to make it come out "right".
</details>

Initially, I was quick to dismiss the whole thing as symptomatic of a
severe floating-point-related cluon shortage.  However, the more I
think about it, the better the case seems for changing the Linux
default:

1.  First, PC=3 is a dangerous setting.  A floating point program
    using "double"s, compiled with GCC without attention to
    FPU-related compilation options, won't do IEEE arithmetic running
    under this setting.  Instead, it will use a mixture of 80-bit and
    64-bit IEEE arithmetic depending rather unpredictably on compiler
    register allocations and optimizations.

2.  Second, PC=3 is a mostly *useless* setting for GCC-compiled
    programs.  There can obviously be no way to guarantee reliable
    IEEE 80-bit arithmetic in GCC-compiled code when "double"s are
    only 64 bits, so our only hope is to guarantee reliable IEEE
    64-bit arithmetic.  But, then we should have set PC=2 in the first
    place.

    Worse yet, I don't know of any compilation flags that *can*
    guarantee IEEE 64-bit arithmetic.  I would have thought
    -ffloat-store would do the trick, but it doesn't change the
    assembly generated for the above example, at least on my Debian
    potato build of gcc 2.95.2.

    The only use for PC=3 is in hand-assembled code (or perhaps using
    GCC "long double"s); in those cases, the people doing the coding
    (or the compiler) should know enough to set the required control
    word value.

2.  Finally, the setting is incompatible with other Unixish platforms.
    As mentioned, Free/NetBSD both use PC=2, and most non-IA-64 FPU
    architectures appear to use a floating point representation that
    matches their C "double" precision which prevents these kinds of
    surprises.

The case against, as I see it, boils down to this:

1.  The current setting is the hardware default, so it somehow "makes
    sense" to leave it.

2.  It could potentially break existing code.  Can anyone guess
    how badly?

3.  Implementation is a bit of a pain.  It requires both kernel and
    libc changes.

On the third point, Ulrich and Adam hashed out weirdness with the FPU
control word setting some time ago in the context of selecting IEEE or
POSIX error handling behavior with "-lieee" without thwarting the
kernel's lazy FPU context initialization scheme.

So, on a related note, is it reasonable to consider resurrecting the
"sys_setfpucw" idea at this point, to push the decision on the correct
initial control word up to the C library level where it belongs?  (For
those who don't remember the proposal, the idea is that the C library
can use "sys_setfpucw" to set the desired initial control word.  If
the C program actually executes an FPU instruction, the kernel will
use that saved control word to initialize the FPU context in
"init_fpu()"; otherwise, lazy FPU initialization works as expected.)

Comments, anyone?

Kevin <buhr@stat.wisc.edu>
