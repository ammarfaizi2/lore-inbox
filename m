Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292774AbSCDS7A>; Mon, 4 Mar 2002 13:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292778AbSCDS6w>; Mon, 4 Mar 2002 13:58:52 -0500
Received: from 64-178-80-34.customer.algx.net ([64.178.80.34]:46064 "HELO
	mail2.there.com") by vger.kernel.org with SMTP id <S292774AbSCDS6l>;
	Mon, 4 Mar 2002 13:58:41 -0500
Date: Mon, 4 Mar 2002 10:58:32 -0800
Message-Id: <200203041858.g24IwW115990@thdev4.there.com>
From: Eric Ries <eries@there.com>
To: linux-kernel@vger.kernel.org
Subject: FPU precision & signal handlers (bug?)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have uncovered what I believe to be a bug in the 2.4.2 i386
kernel. I know that this is not the latest kernel, but I believe the
bug is present in later versions. I will outline the symptoms of the
bug, my belief about what causes it, and a proposed solution. If this
solution seems right, I'm happy to code up a patch and submit it to
the appropriate maintainer (I was unable to figure out who the correct
maintainer-target was for this message, so suggestions are welcome).

Background (or, why this seemingly minor bug is a problem): 

We develop an application that relies heavily on being able to do
floating-point operations in a precise way across platforms in a
distributed system. Because we need to be able to marshal the results
of these operations across the network, we have to be very careful
that they are rounded the same on all machines. To accomplish this, we
have to set the FPU precision mode in all processors to 64 bits of
precision (80 bits is the default). This is because, as you already
know, performing an operation in 80 bits of precision and then
rounding it to 64 bits is not the same as doing that same operation at
64 bits of precision in the first place. We set the FPU precision mode
with the 'fldcw' instruction once, and naively expected this control
word to be in effect throughout the life of our process.

Symptoms: 

We have been tracking a nasty bug in our program where some of our
operations happen at the 80-bit precision mode despite our having
explicitly set it to 64 bits. After much searching, we realized that
all of the offending operations originate in one of our signal
handlers. We use signals extensively in our program, and were quite
surprised to find kernel FINIT traps being generated from them. After
reading through the 2.4.2 source, I now believe that all signal
handlers run with the default FPU control word in effect. Here's
why...

Explanation:

When it's time to deliver a signal to a user process, the kernel goes
through setup_sigcontext() (arch/i386/kernel/signal.c:318) which saves
the state of the CPU registers at the time of the signal
call. Naturally, the kernel will use this saved state to restore the
registers after the signal handler returns. In order to save the state
of the FPU, it calls save_i387() (signal.c:347). save_i387()
(arch/i386/kernel/i387.c:321) uses one of several appropriate
instructions to save the state of the FPU registers. You will find, in
that function, this handy comment:

/* This will cause a "finit" to be triggered by the next
  * attempted FPU operation by the 'current' process.
  */

This happens because, when you save the state of the FPU registers
using an FNSAVE instruction (and I believe that all of the
instructions used in save_i387 are equivalent to the FNSAVE
instruction, although they differ in their details), you reset the FPU
state as a side-effect. (see
http://webster.cs.ucr.edu/Page_TechDocs/MASMDoc/ReferenceGuide/Chap_05.htm
which has a nice little reference on 387 instructions). Here's the
definition of FNSAVE I am familiar with: "Stores the 94-byte
coprocessor state to the specified memory location. In 32-bit mode on
the 80387–80486, the environment state takes 108 bytes. This
instruction has wait and no-wait versions. After the save, the
coprocessor is initialized as if FINIT had been executed." It's this
last bit that is interesting for this bug. In i387.c:329, still in
save_i387, the kernel has this line:

current->used_math = 0;

My belief is that this allows the kernel to leave the i387 in FINIT
mode. Now, back in user space, if the signal handler does any
floating-point operations, the FINIT trap will be generated, and the
kernel will respond by issuing the FNINIT instruction (in
i387.c:init_fpu). The net result is that this floating point
operation, and any others that take place before the signal
handler-return code is executed, will use the default FPU precision
mode (and the defaults for all other FPU flags) instead of the
(expected) process-global FPU precision mode.

Work-Around:

Now, in our application, we only care about the FPU precision mode
part of the FPU control word, so we can work around this problem by
simply resetting the control word in every signal handler. But this
strikes me as kind of a hack. Why should the signal handler, alone
among all my functions (excepting main) be responsible for blowing
away the control word?

Solution:

As the symptoms of this bug are relatively minor, so too I believe is
the solution. It seems to me that the FPU control word is the only FPU
register in the i387 that is considered to be "global" in scope. If
there are others, I'd appreciate someone letting me know. In any
event, I can think of two solutions. One is less efficient but
probably cleaner. At the time that we invoke the signal handler, we
save the FPU state, which resets the FPU state as a side-effect. At
this time, we could (if the FPU control word is in a non-default
setting) immediately re-set the FPU control word, causing an FINIT
trap, and then invoke the signal handler. This would impose a small
performance penalty on signal-handler invocations. A possibly more
efficient solution would be to add another member (along with
used_math) to the 'current' process data structure. Then, whenever a
process generated an FINIT trap, we could inspect this extra member to
see if we should, in addition to clearing the FPU registers, also
reset the FPU control word. To figure out what to reset the FPU cw to
would involve finding the saved _fpstate that we created with
save_i387 for this process, and then extracting the control word from
that.

So, both solutions have some performance implications, but only during
signal-handler invocation, and both, at least it seems to me, are very
small.

If someone would take a minute of their time to let me know if this
approach seems right/wrong/crazy, I'd greatly appreciate
it. Furthermore, if anybody thinks a patch along these lines would get
incorporated into the kernel, I'd be happy to produce it.

Thanks so much,

Eric Ries
eries@there.com

PS. Here's the output from ver_linux for one machine that I've noticed
this problem on:

Linux thdev4 2.4.2-2 #1 Sun Apr 8 20:41:30 EDT 2001 i686 unknown
 
Gnu C                  2.96
Gnu make               3.77
binutils               2.10.91.0.2
util-linux             2.10r
modutils               2.4.2
e2fsprogs              1.19
pcmcia-cs              3.1.22
PPP                    2.4.0
Linux C Library        2.2.2
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.57
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         nfs lockd sunrpc 3c59x ipchains usb-uhci usbcore

And here's /proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 7
model name	: Pentium III (Katmai)
stepping	: 3
cpu MHz		: 548.745
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 1094.45
