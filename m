Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310128AbSCFTMR>; Wed, 6 Mar 2002 14:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310127AbSCFTMH>; Wed, 6 Mar 2002 14:12:07 -0500
Received: from gra-lx1.iram.es ([150.214.224.41]:33286 "EHLO gra-lx1.iram.es")
	by vger.kernel.org with ESMTP id <S310123AbSCFTL4> convert rfc822-to-8bit;
	Wed, 6 Mar 2002 14:11:56 -0500
Date: Wed, 6 Mar 2002 20:11:45 +0100 (CET)
From: Gabriel Paubert <paubert@iram.es>
To: Eric Ries <eries@there.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: FPU precision & signal handlers (bug?)
In-Reply-To: <200203041858.g24IwW115990@thdev4.there.com>
Message-ID: <Pine.LNX.4.33.0203051918520.7951-100000@gra-lx1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 4 Mar 2002, Eric Ries wrote:

>
> I have uncovered what I believe to be a bug in the 2.4.2 i386
> kernel. I know that this is not the latest kernel, but I believe the
> bug is present in later versions. I will outline the symptoms of the
> bug, my belief about what causes it, and a proposed solution. If this
> solution seems right, I'm happy to code up a patch and submit it to
> the appropriate maintainer (I was unable to figure out who the correct
> maintainer-target was for this message, so suggestions are welcome).
>
> Background (or, why this seemingly minor bug is a problem):
>
> We develop an application that relies heavily on being able to do
> floating-point operations in a precise way across platforms in a
> distributed system.

<Offtopic>
Believing in getting the same floating-point results down to the last bit
on different platforms is almost always bound to fail: for transcendental
functions, a 486 will not give the same results as a Pentium, a PIV will
use a library and give different results if you use SSE2 mode, and so on.
I don't even know whether an Athlon and the PII/PIII always give the same
results or not.

Now if you have other architectures, even if they all use IEEE-[78]54
floating point format, this becomes even more interesting. For examples
PPC, MIPS, IA64, and perhaps others will tend to use fused
multiply-accumulate instructions unless you tell the compiler not do do so
(BTW after a quick look at GCC doc and sources, -mno-fused-madd is not
even an option for IA-64).
</Offtopic>

> Because we need to be able to marshal the results
> of these operations across the network, we have to be very careful
> that they are rounded the same on all machines. To accomplish this, we
> have to set the FPU precision mode in all processors to 64 bits of
> precision (80 bits is the default). This is because, as you already
> know, performing an operation in 80 bits of precision and then
> rounding it to 64 bits is not the same as doing that same operation at
> 64 bits of precision in the first place. We set the FPU precision mode
> with the 'fldcw' instruction once, and naively expected this control
> word to be in effect throughout the life of our process.
>
> Symptoms:
>
> We have been tracking a nasty bug in our program where some of our
> operations happen at the 80-bit precision mode despite our having
> explicitly set it to 64 bits. After much searching, we realized that
> all of the offending operations originate in one of our signal
> handlers. We use signals extensively in our program, and were quite
> surprised to find kernel FINIT traps being generated from them. After
> reading through the 2.4.2 source, I now believe that all signal
> handlers run with the default FPU control word in effect.

Right.
[Snipped the clear explanation showing that you've done your homework]

> instruction, although they differ in their details), you reset the FPU
> state as a side-effect.

Actually, fxsave does not reset the FPU state IIRC (so it could be faster
for signal delivery to use fxsave followed by fnsave instead of the format
conversion routine if the FPU happens to hold the state of the current
process).

> http://webster.cs.ucr.edu/Page_TechDocs/MASMDoc/ReferenceGuide/Chap_05.htm
> which has a nice little reference on 387 instructions). Here's the
> definition of FNSAVE I am familiar with: "Stores the 94-byte
> coprocessor state to the specified memory location. In 32-bit mode on
> the 80387–80486, the environment state takes 108 bytes. This
> instruction has wait and no-wait versions. After the save, the
> coprocessor is initialized as if FINIT had been executed." It's this
> last bit that is interesting for this bug. In i387.c:329, still in
> save_i387, the kernel has this line:
>
> current->used_math = 0;
>
> My belief is that this allows the kernel to leave the i387 in FINIT
> mode. Now, back in user space, if the signal handler does any
> floating-point operations, the FINIT trap will be generated, and the
> kernel will respond by issuing the FNINIT instruction (in
> i387.c:init_fpu). The net result is that this floating point
> operation, and any others that take place before the signal
> handler-return code is executed, will use the default FPU precision
> mode (and the defaults for all other FPU flags) instead of the
> (expected) process-global FPU precision mode.
>
> Work-Around:
>
> Now, in our application, we only care about the FPU precision mode
> part of the FPU control word, so we can work around this problem by
> simply resetting the control word in every signal handler. But this
> strikes me as kind of a hack. Why should the signal handler, alone
> among all my functions (excepting main) be responsible for blowing
> away the control word?
>
> Solution:
>
> As the symptoms of this bug are relatively minor, so too I believe is
> the solution. It seems to me that the FPU control word is the only FPU
> register in the i387 that is considered to be "global" in scope. If
> there are others, I'd appreciate someone letting me know. In any
> event, I can think of two solutions. One is less efficient but
> probably cleaner. At the time that we invoke the signal handler, we
> save the FPU state, which resets the FPU state as a side-effect. At
> this time, we could (if the FPU control word is in a non-default
> setting) immediately re-set the FPU control word, causing an FINIT
> trap, and then invoke the signal handler. This would impose a small
> performance penalty on signal-handler invocations. A possibly more
> efficient solution would be to add another member (along with
> used_math) to the 'current' process data structure. Then, whenever a
> process generated an FINIT trap, we could inspect this extra member to
> see if we should, in addition to clearing the FPU registers, also
> reset the FPU control word. To figure out what to reset the FPU cw to
> would involve finding the saved _fpstate that we created with
> save_i387 for this process, and then extracting the control word from
> that.

Very bad idea, the control word is often changed in the middle of the
code, especially the rounding mode field for float->int conversions; have
a look at the code that GCC generates (grep for f{nst,ld}cw). The Pentium
IV doc even states that you can efficiently toggle between 2 values of the
control word, but not more.

Therefore you certainly don't want to inherit the control word of the
executing thread. Now adding a prctl or something similar to say "I'd like
to get this control word(s) value as initial value(s) in signal handlers"
might make sense, even on other architectures or for SSE/SSE2 to control
such things as handle denormal as zeros or change the set of exceptions
enabled by default...

	Regards,
	Gabriel.

