Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268892AbTCCXX1>; Mon, 3 Mar 2003 18:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268893AbTCCXX1>; Mon, 3 Mar 2003 18:23:27 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:28559 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id <S268892AbTCCXXV>;
	Mon, 3 Mar 2003 18:23:21 -0500
Date: Tue, 4 Mar 2003 00:33:45 +0100 (MET)
From: Mikael Pettersson <mikpe@user.it.uu.se>
Message-Id: <200303032333.h23NXjxA012513@harpo.it.uu.se>
To: albert@users.sourceforge.net
Subject: Re: perfctr-2.4.6 released
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02 Mar 2003 13:13:40 -0500, Albert Cahalan wrote:
>> perfctr-2.4.6 is now available at the usual place:
>> http://www.csd.uu.se/~mikpe/linux/perfctr/
>
>So, what is it? I figure it does profiling, but that

Sorry, the perfctr-2.4 announce skeleton is a bit terse for LKML.
It used to be sent only to perfctr-devel, but I changed that
to avoid Linus' "not at LKML implies bad project" complaint.
The perfctr-2.5 announce skeleton clarifies that it's a driver
for the performance monitoring counters found in x86 CPUs.

>sure is vague. The SourceForge site is pretty empty too.

SourceForge is only used to host the mailing list.

>>From freshmeat.net and an ANNOUNCE-2.5.0-pre1 file, I'm
>guessing you made some user-readable x86 registers be
>per-process instead of system-wide, but maybe you've
>done much more or less.

It virtualises the performance counters, so it's per-process
just like the integer and f.p. state. Actually there are
three components: a low-level x86-specific driver, a driver
for per-process performance counters, and a driver for
global non-virtualised performance counters. The latter is
rather rudimentary.

The low-level driver caches control data and uses an accumulating-
differences approach for event counting, which keeps context
switching costs down in common cases. (Writing to the performance
counter and control registers is expensive, so the driver avoids
that as far as possible.)

The package also has a user-space access library. The driver
allows a process to mmap() its counter state, and the library
uses this to implement a low-overhead syscall-free algorithm
for sampling the counters in user-space. The overhead for sampling
a single counter is around 50-250 clock cycles, depending on CPU
generation: approximately 45 cycles for P5 MMX, 115 cycles for P6,
50-60 cycles for K7, and 230 cycles for P4. Sampling all counters
a process is using is less expensive than sampling them one by one.

Other people have higher-level libraries on top of this, for
things like posix threads, user-friendly abstractions, and
portable interfaces.

>Does it use the oprofile interface? (why or why not?)

Different interfaces. perfctr predates oprofile. oprofile
is mostly about interrupt-driven kernel profiling, perfctr
is primarily about application developers profiling user-level
code, using both event counting and interrupt-driven profiling.

>Does it use the IA-64 perfmon system call?

No. IA-64 gets to use its own stuff since the IA-64 developers
put that in from the beginning. sparc64 also has its own stuff.

>Does it support the Pentium-MMX in an old PC?

Yes. It supports P5 classic and MMX, P6 (all), P4 (all, including
hyper-threaded multi-processor boxes which are a PITA), K7 and K8,
and Cyrix' P5 clones. It also supports Centaur's semi-broken P5
clones (WinChip) and Centaur's limited P6 Celeron clone (VIA C3).

x86_64 (the K8 in 64-bit mode) support will be added RSN.

>Does it support the PowerPC MPC7400 ("G4") in a Mac?

Not yet. I may be able to lay my hands on a 604 soon, at which
point I'll start working on ppc support. (There are at least 3
major kinds: 604 and 750, early 74xx, and later 74xx.)

>(if not, what would porting involve?)

Writing a new low-level driver:
Data structures to describe CPU-specific control data.
Control data validation procedures.
Procedures for updating control data.
Procedures for sampling the counters.
For counter overflow interrupt support, there are some additional
steps to take when suspending and resuming the counters.
CPU family detection procedures, and ensuring you use the correct
code for each supported CPU type.

The x86 low-level driver is semi-large (about 1800 lines) due to
the large variation in that processor processor family, but I
expect the x86_64 driver to be at most 200-300 lines.
A complete driver for 32-bit PPC would be somewhere in-between.

>Does it work without root privileges?

Per-process counters don't require any special privileges.
It does require a modified kernel (even when built as a module),
which is problematic for many users.

>Does it handle unmodified executables? (regular, -s, -g)

Yes. performance counters are maintained across exec() so
this works to some extent.
They are cleared for fork() children because of semantic
problems related to how results should be propagated back.
Some user-space tools developers use LD_PRELOAD tricks to
handle fork() and threads.

The package includes a 'perfex' (clone of Irix' perfex)
program which runs another program with a given counter setup,
and reports the final counter values.

>Does it handle stripped dynamic libraries?
>Does it unmangle names for C++ code?

No. My user-space library is just a thin access library.
I rely on others to do higher-level stuff. See the link to
PAPI in the package.

>Does it handle the kernel itself?

Many CPUs have "scope" control which allows counters to be
restricted to user-level, kernel-level, or both. Profiling
the kernel can be done using the global-mode counters driver
and putting the counters' scope to kernel-level.
But since I've been concentrating on per-process counters,
this usage mode is much less developed. It wouldn't take
much work to fix it, however. (Add interrupt support to that
driver, a buffer for overflow PC samples, and a user-space
app to read it and correlate it with the kernel's symbol table.)

/Mikael
