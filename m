Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129753AbRCCVAc>; Sat, 3 Mar 2001 16:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129754AbRCCVAX>; Sat, 3 Mar 2001 16:00:23 -0500
Received: from lotus.CS.Berkeley.EDU ([128.32.46.236]:6291 "EHLO
	lotus.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id <S129753AbRCCVAK>; Sat, 3 Mar 2001 16:00:10 -0500
Message-Id: <200103032100.NAA22606@lotus.CS.Berkeley.EDU>
To: linux-kernel@vger.kernel.org
Subject: Re: RFC: changing precision control setting in initial FPU context 
In-Reply-To: Your message of "Sat, 03 Mar 2001 15:04:01 EST."
             <200103032004.f23K417447302@saturn.cs.uml.edu> 
Date: Sat, 03 Mar 2001 13:00:08 -0800
From: Jason Riedy <ejr@CS.Berkeley.EDU>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And "Albert D. Cahalan" writes:
 - 
 - 2. Extra precision when it comes free. The precision control is set
 -    to 80-bit and the compiler tries to keep values in registers.
 -    This is usually the more useful behavior, and it performs better.

Even better is for gcc to spill intermediate results to 80 bits.
Unfortunately, these 80 bits have to be expanded to 128 for 
alignment, and this eats cache.  IIRC, this has been discussed
many times by gcc developers.  I don't recall the final verdict.
The original intent with the 8087 was that the compiler and/or
OS could transparently extend the stack into memory, but one
necessary feature was left out until the 80387.  By that point,
it was too late.  And then came caches...

 - What you are suggesting is a gross hybrid. You claim it has something
 - to do with IEEE, but it doesn't handle 32-bit math correctly. Your
 - proposal is NOT true IEEE math.

Note that getting what some people want to call `true' IEEE 754 
arithmetic on an x86 is frightfully tricky.  Changing the precision
does not shorten the exponent field, and that can have, um, fun
effects on and around under/overflow.  The mantissa and exponent 
lengths were chosen carefully to protect against those effects in 
many computations.

What Linux does presently on x86 is as right as right can be on 
this platform.  Compare with what MS's compilers do (die when you 
run out of the fp stack slots, telling users to simplify the 
expressions in the source code) and be happy.  The *BSD choice is 
valid by some lines of thought, but it also denies people the happy 
accident of computing with more precision and range than they thought 
they needed.  Overall, computing with x86 double-extended is a good
thing so long as you don't introduce multiple roundings.  That's a
compiler issue, not a kernel one.

Historical note:  According to one of the x87 designers, this all
boils down to the simple fact that there's no time when a pair of
collaborators in California and Israel can be both awake and lucid
enough to explain things well over a noisy telephone line.  Amazing
that it really wasn't long ago.  And if anyone's really interested,
keep checking
	http://www.cs.berkeley.edu/~wkahan/
as some of Dr. Kahan's older papers are slowly converted and added.
They give a great deal of insight into the choices that eventually
became the accepted IEEE 754 standard.

Jason
