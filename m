Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266994AbTBLKB2>; Wed, 12 Feb 2003 05:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266995AbTBLKB2>; Wed, 12 Feb 2003 05:01:28 -0500
Received: from bjl1.jlokier.co.uk ([81.29.64.88]:10624 "EHLO
	bjl1.jlokier.co.uk") by vger.kernel.org with ESMTP
	id <S266994AbTBLKBZ>; Wed, 12 Feb 2003 05:01:25 -0500
Date: Wed, 12 Feb 2003 10:12:06 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Bug 350] New: i386 context switch very slow compared to 2.4 due to wrmsr (performance)
Message-ID: <20030212101206.GA10422@bjl1.jlokier.co.uk>
References: <629040000.1045013743@flay> <20030212025902.GA14092@codemonkey.org.uk> <20030212042143.GB9273@bjl1.jlokier.co.uk> <b2cn96$7dk$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2cn96$7dk$1@penguin.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> >That leaves the other MSR write, which is also unnecessary.
> 
> No, the other one _is_ necessary.  I did timings, and having it in the
> context switch path made system calls clearly faster on a P4 (as
> compared to my original trampoline approach).
> 
> It may be only two instructions difference ("movl xx,%esp ; jmp common")
> in the system call path, but it was much more than two cycles.  I don't
> know why, but I assume the system call causes a total pipeline flush,
> and then the immediate jmp basically means that the P4 has a hard time
> getting the pipe restarted.

The jump is not necessary, and you don't need to duplicate the system
call code either.  You place an instruction like this at the start of
the system call code - this is _all_ that you need.

	movl -60(%esp),%esp

The current task's esp0 is always stored in the TSS.  We get that for
free.  And you can point SYSENTER_ESP in, before or after the TSS too.
The trampoline stack needs exactly 6 words to handle debug and NMI.

The constant may vary according to how you lay things out, and you
might put it after cld;sti[2] in the entry code, but you get the idea.

I suspect you are right that it is the jump which is expensive - a
stack load _should_ be less than a cycle.  Normal functions do it all
the time.  But then a jump _should_ be less than a cycle too.  Ah well!

(Of course even a single load of %esp, even if it turns out to be
cheap, can cost more on average than writing the MSR per context
switch.)

> This might be fixable by moving more (all?) of the kernel-side fast
> system call code into the per-cpu trampoline page, so that you wouldn't
> have the immediate jump. Somebody needs to try it and time it, otherwise
> the wrmsr stays in the context switch.

I have timed how long it takes to do sysenter, call a function in
kernel space and sysexit to return, complete with the above method of
stack setup (and the debug + NMI fixups).  This is a module for <=2.4 kernels.

It takes ages - 82 cycles.

Here are my notes from last year (sorry, I don't have a P4):

   Performance and emulation methods
   ---------------------------------

     * On everything since later Pentium Pros from Intel, and since
       the K7 from AMD, `sysenter' is available as a native instruction.

       On my Celeron 366, it takes 82 (84.5 on an 800MHz P3) cycles to
       enter the kernel, call an empty C function and return to
       userspace.  Compare this to 236 (242) cycles using `int $0x81' to
       do the same thing.

     * On old CPUs which don't support `sysenter', it is emulated
       using the "illegal opcode" trap (#UD).

       This is actually quite fast: the empty C function takes only 17
       (16) cycles longer than `int $0x81'.  Because classic system
       calls use `int $0x80', you can see that emulating `sysenter'
       would be a useful fallback method for userspace system calls.

     * Don't take the cycle timings too seriously.  They vary by about
       8% according to the exact layout of the userspace code and also
       from one module loading to the next (probably due to cache or TLB
       colour effects).  I haven't quoted the _best_ timings (which are
       about 8% better than the ones I quoted), because they only occur
       occasionally and cannot be repeated to order (you have to unload
       and reload the module until the best timing appears).

> I want fast system calls. Most people don't see it yet (because you need
> a glibc that takes advantage of it), but those fast system calls are
> more than enough to make up for some scheduling overhead.

By the way, your suggestion of comparing %ds and %es to __USER_DS and
avoiding loading them if they are the expected values saves 8 cycles
on the two CPUs I did it on.  Not loading them on exit, which you
already do, saves a further 10 cycles.

Because you are careful to disallow sysenter from vm86 mode,
transitions from vm86 _always_ go through the
interrupt/int$0x80/exception paths, which always reload %ds and %es.

So your concern about vm86 screwing with the cpu's internal segment
descriptors doesn't apply, AFAICT, to the sysenter path.  (It probably
does apply to the interrupt and exception paths).

So here are some system call optimisation hints:

  [0] Comparing %ds and %es to __USER_DS and not reloading them in the
      sysenter path is safe, and worth 8 cycles on my CPUs.

  [1] "movl %ds,%ebx" is about 9-10 cycles faster than "pushl %ds;
      popl %ebx" for what its worth.  I think it's the pushl which is
      slow but I haven't timed it by itself.

  [2] Putting cli immediately before sti saves exactly 5 cycles on my
      Celeron, and putting that just before the %esp load helps a little.
      Cost of loading the flags register?

I am a wimp, or perhaps impatient, when it comes to the
compile-reboot-test cycle so I'm not likely to try the above any time
soon.  But those are good hints if anyone (Ingo? :) wants to try them.

enjoy,
-- Jamie
