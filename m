Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154405-23312>; Sun, 25 Oct 1998 23:03:52 -0500
Received: from campino.Informatik.RWTH-Aachen.DE ([137.226.116.240]:61751 "EHLO campino.informatik.rwth-aachen.de" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <154403-23312>; Sun, 25 Oct 1998 23:01:10 -0500
Date: Mon, 26 Oct 1998 11:58:59 +0100 (MET)
From: Bernd Schmidt <crux@pool.informatik.rwth-aachen.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andi Kleen <ak@muc.de>, Khimenko Victor <khim@sch57.msk.ru>, linux-kernel@vger.rutgers.edu
Subject: Re: 2.2.0 and egcs 1.1 was Re: Sorry, wrong gcc-version
In-Reply-To: <Pine.LNX.3.96.981025144701.3859K-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.02A.9810261116190.15628-100000@matula.informatik.rwth-aachen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu


> > Actually this is not entirely correct. Even 2.1.x kernels still have lots
> > of incorrect inline assembler constraints which can cause the compiler
> > to misoptimize the kernel.

First, I should note that there are two issues here: we have bugs related to
inline assembly in both the kernel, and in the compiler.  The compiler bugs
are present in every version of gcc, not just gcc-2.8 or egcs.

1. Explicitly clobbering a register is supposed to make it unavailable for
   both inputs and outputs of the same statement.  This rule has been there
   for a long time; it's documented at least since gcc-2.6.0 (I have no earlier
   docs available at the moment; I suspect it's been there forever).  This is
   from gcc.info, version 2.6.0:

     The input operands are guaranteed not to use any of the clobbered
     registers, and neither will the output operands' addresses, so you can
     read and write the clobbered registers as many times as you like. 

   [Obviously, the clobbered regs aren't used for output operands either.]
   Thus, using a construct like
   __asm__ (" " : : "a" (somevalue) : "eax")
   is incorrect.  This sort of thing occurs in the kernel, and it's a bug.
   It should be written as
   __asm__ (" " : "=&a" (dummy) : "0" (somevalue));

2. Clobbers are dangerous on the i386.  The compiler can't guarantee that
   even for a correctly-written asm, the clobbered register will not be used
   for another operand.  Thus, it is highly advisable not to use clobbers
   at all, and to use earlyclobbers as described above.  This is a compiler
   bug, and it's very closely related to the one that lets you use "a" as
   a constraint in the example above.

All of this only affects the i386 and other machines for which gcc has to
define the macro SMALL_REGISTER_CLASSES in the machine description.  Without
this macro, which normally isn't defined, gcc doesn't use registers which
are explicitly mentioned anywhere in the internal representation at all for
other purposes (like register allocation or for spill registers).  That makes
the code correct, but it would also make the compiler fail to work at all for
a machine where registers can be used explicitly (like eax as the function
return value) and be necessary for certain instructions (like some
multiplications that also require eax).

Thus, on most machines supported by gcc the incorrect asm statement above
would cause a spill failure error, if it could be written for other machines
(most other machine descriptions don't have single-register register classes).

> I don't agree.
> 
> The assembler used to be correct, and the gcc people unilaterally decided
> to change the rules. As such, I don't think the asm is any more
> "incorrect" than the new gcc versions are incorrect. 

The assembler never was correct.  It happens to work most of the time, because
even when SMALL_REGISTER_CLASSES is defined, the compiler puts the explicitly
mentioned registers at the end of the list that it chooses its reload regs
from.  Only when it can't find any other register will it use any of the
explicitly mentioned ones.

> The changes I have seen break older compilers. 

In what ways?

> So Andi, don't go saying that the kernel has problems, when it is equally
> true to say that gcc has problems. 

Right.  Both have problems.  I'm currently working with the egcs people to
fix the ones in gcc (make the compiler generate errors for the illegal asms,
and avoid the whole SMALL_REGISTER_CLASSES nonsense).  However, once the
compiler is fixed, the current kernels will fail to compile.

> > In short, if you want to play safe stay with 2.7.2.3 for kernel compilation.
> 
> That, I think, everybody can agree on.

Except that 2.7.2 is buggy as hell.  It has the same problems as egcs when
it comes to asm statements, it just happens you may not have seen them yet.
Fact is, any change in the kernel could cause the 2.7.2 to fall over just
as well.

> For example, everybody in the egcs camp just decided that clobbers and
> inputs must not overlap. Nobody told me why,

Because it's documented that way.  Because on sane machines, it has always
worked that way.
You seem to suggest that the meaning of clobbered registers should be
redefined so that they work the way you expect them to work.  Technically,
that's feasible.  However, for the kernel inline assembly, you'd be left with
the oh-so-stable gcc-2.7.2 which still doesn't work properly.  Worse,
redefining the meaning of clobbers will suddenly make hundreds of correctly
written asm statements for other machines as well as for the i386 generate
incorrect code silently.  Are you seriously proposing this is a good idea?

> and why they can't just be
> automatically converted to early-clobbers inside gcc.

Clobbers in an asm statement can use a register number.  The operands need
a register class.  There may not be a register class for a register you want
to clobber (consider clobbering ebp which has no corresponding register class).

Bernd


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
