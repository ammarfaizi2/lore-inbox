Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266123AbRGSWme>; Thu, 19 Jul 2001 18:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266129AbRGSWmZ>; Thu, 19 Jul 2001 18:42:25 -0400
Received: from ja.ssi.bg ([212.95.166.64]:14853 "EHLO u.domain.uli")
	by vger.kernel.org with ESMTP id <S266123AbRGSWmL>;
	Thu, 19 Jul 2001 18:42:11 -0400
Date: Fri, 20 Jul 2001 01:42:54 +0000 (GMT)
From: Julian Anastasov <ja@ssi.bg>
X-X-Sender: <ja@u.domain.uli>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: cpuid_eax damages registers (2.4.7pre7)
In-Reply-To: <200107182204.f6IM4K001282@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0107200051480.984-100000@u.domain.uli>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


	Hello,

> > kernel files that volatile solves gcc bugs. The question is whether
> > the volatile is needed only as a work-around or it is needed in this
> > case particulary, i.e. where the output registers are not used and are
> > optimized.
> >
>
> It certainly shouldn't; obviously, the assembly code is clearly
> declaring that it is outputting multiple things.  "volatile" on an
> "asm" statement basically means "do this even if you don't need the
> output values" (i.e. don't assume you're doing this just for the
> computation), which is incorrect in this case (we *are* doing it just
> for the output values, not for any side effects), but it is not really
> surprising that it works around this bug.

	I'm now learning the inline asm but I found some interesting
notes on this/similar issue:

http://gcc.gnu.org/fom_serv/cache/23.html

In my distro (now with gcc 2.96) I have a gcc info with name "Extended
Asm", "Assembler Instructions with C Expression Operands" with the
following text:

---
   If an `asm' has output operands, GNU CC assumes for optimization
purposes the instruction has no side effects except to change the output
operands.  This does not mean instructions with a side effect cannot be
used, but you must be careful, because the compiler may eliminate them
if the output operands aren't used, or move them out of loops, or
replace two with one if they constitute a common subexpression.  Also,
if your instruction does have a side effect on a variable that otherwise
appears not to change, the old value of the variable may be reused later
if it happens to be found in a register.

   You can prevent an `asm' instruction from being deleted, moved
significantly, or combined, by writing the keyword `volatile' after the
`asm'.
------

follows example, etc.

What I want to say (I could be wrong and that can't surprise me) is
that the original cpuid_eax is in fact incorrect. All cpuid_XXX funcs
use only dummy output operands and because they are not used, they
are removed and not considered as changed. By using dummy vars we
say "We don't care for these output values, use them in current
scope only". As result, the cpuid instruction appears as not to
change the 3 of the 4 registers. This explains why cpuid() behaves
differently from the cpuid_XXX funcs: because the cpuid_XXX funcs
declare eax ... edx as local vars, while in cpuid() they are not
local and hence are not optimized.

	The two solutions looks valid:

- to clobber the changed registers and hence not to use them as
dummy output operands - already in 2.4.7pre8

- to specify volatile, which in some way avoids the default
behavior to make optimizations and to remove assumptions about the
used dummy output registers

Of course, it is interesting why 2.95 behaves differently, may be
it simply proves that I'm wrong or there is a bug/precaution
introduced after 2.91.66. The key is in the "volatile" semantic.


Regards

--
Julian Anastasov <ja@ssi.bg>

