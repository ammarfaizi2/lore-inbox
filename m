Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136428AbREDPV1>; Fri, 4 May 2001 11:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136429AbREDPVR>; Fri, 4 May 2001 11:21:17 -0400
Received: from fyserv1.fy.chalmers.se ([129.16.110.66]:49884 "EHLO
	fyserv1.fy.chalmers.se") by vger.kernel.org with ESMTP
	id <S136428AbREDPVJ>; Fri, 4 May 2001 11:21:09 -0400
Message-ID: <3AF2C8F2.AD9AC69E@fy.chalmers.se>
Date: Fri, 04 May 2001 17:21:22 +0200
From: Andy Polyakov <appro@fy.chalmers.se>
X-Mailer: Mozilla 4.08C-SGI [en] (X11; U; IRIX 6.5 IP32)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: modularized SYSENTER support
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Below is the comment section from my SYSENTER module. Code itself (~20K)
can be found at the URL below. I want to point out that I'm not
subscribed to the linux-kernel list and would appreciate if you drop me
a CC when (or if:-) commenting.

http://fy.chalmers.se/~appro/linux/sysenter.c

Copyright (c) 2001 by <appro@fy.chalmers.se>

This is Linux kernel module implementing support for Intel SYSENTER
"Fast System Call" facility (see "IA-32 System Programming Guide" for
further details). It's meant for research purposes and is subject to
usual "no-warranty-don't-complain" blah-blah...

As I figured after the module was almost ready the matter has already
been discussed on the kernel development list in late December, 1999
and the idea was basically condemned... Well, when I started I wanted
to learn kernel insights and I certainly did so that the project
"goal" was achieved. And then I felt like sharing it:-)

Note that it's not a patch, but a loadable module! Well, it does some
*run-time* patching to 2.2.x kernel by replacing first instructions of
the context switching procedure with jump instruction transferring the
control to equivalent procedure of own design, but there is no source
code patching involved...

If executed, this file (yes, this is self-compiling C-code:-) will
compile and install the module, compile shared object (to be preloaded
with LD_PRELOAD) overriding couple of system calls and benchmarks a
syscall hungry application, namely 'dd if=/dev/zero of=/dev/null':-)
On a 550MHz PIII the program exhibits 20% performance improvement when
tricked to take the SYSENTER path.

Pre-requirements. Up-to-date kernel headers in /usr/src/linux as well
as System.map (alternatively /boot/System.map) matching the current
/proc/ksyms. See the embedded script for details. I use UTS_RELEASE
and address of sock_register() function for fingerprinting in order to
prevent module compiled for another kernel from being loaded.

Questions and answers.

Q. Is the module SMP-safe?
A. Almost. When being compiled for 2.2.x the code can be compiled to
   be "cruel" (run-time patching, see above, default behavior) and
   "gentle." "Cruel" version is SMP-safe, "non-cruel" is not (because
   it uses a global variable). Under 2.4.x the generated code is
   always SMP-safe (unlike 2.2.x 2.4.x doesn't flip the Task Register
   at context switch thus making pointer to TSS a perfect candidate
   for SYSENTER_ESP_MSR:-).

Q. How come the handler doesn't manage so called "bottom halves" or
   "soft IRQs"?
A. There is no need for this. Soft IRQs can only appear at exit from
   hardware interrupt handlers. Indeed, we can't count on user app.
   being around and performing a system call when it comes to
   interrupt handling, right?

Q. Where do you set up the pointer to the current task structure?
A. Normally it's done with "%%esp & -8192", right? Here it's done with
   "leal -8152(%esp),%ebp" (i.e. with carefully chosen offset:-). It's
   possible because user originated system call is always executed
   from the very bottom of kernel stack. No, kernel can't use SYSENTER
   as SYSEXIT unconditionally drops CPL to 3.

Q. Why aren't there any fix-ups?
A. Well, "1: movl -4(%%ebp),%%edi # fetch the return address" and
   "2: movl (%%ebp),%%ebp # fetch 6-th argument" should probably be
   guarded by fix-up code. On the other hand the arguments are
   expected to be passed through "flat" (stack) segment. As we can't
   possibly know if user stack segment was "flat" (and we basically
   shouldn't care as SYSEXIT unconditionally write 0x2B to %ss) there
   isn't much reasonable we can do, but to let it fail with segfault.
   Well, I could call do_exit() in order to kill the application with
   little more discretion... Give me a reason to...

Q. What about VM86?
A. VM86 task should never call SYSENTER. It it does it should simply
   be terminated. Right now I do nothing about it counting on that the
   user code will screw itself (see also previous question) at SYSEXIT
   which unconditionally overwrites %cs and %ss with predefined
   values.

Q. What about AMD's SYSCALL/SYSRET?
A. Adaptation is trivial. It's not done only because I don't have
   access to appropriate AMD box to play with. Keep in mind that AMD
   didn't bother to provide means for setting up %esp so that "non-
   cruel" code is the only option. Then it should also be noted that
   later AMD processors implement Intel's SYSENTER/SYSEXIT. 

Cheers! Andy.
