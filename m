Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265712AbTIJVEo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 17:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265626AbTIJVEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 17:04:44 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:10385 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S265731AbTIJVET
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 17:04:19 -0400
Date: Wed, 10 Sep 2003 22:04:16 +0100
From: Jamie Lokier <jamie@shareable.org>
To: linux-kernel@vger.kernel.org
Subject: Virtual alias cache coherency results (was: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this)
Message-ID: <20030910210416.GA24258@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First, a big thanks to everyone who ran the program.  Some of you have
quite impressively diverse machines.  I didn't expect results from a VAX! :)

The test was to establish two mappings of the same shared memory at
different virtual addresses, and see if both views were cache
coherent.  That means that writes to one view are seen immediately
by reads from the equivalent address in the other view.

(Multiple views of the same memory is called virtual aliasing, and
this test is only for one kind of cache coherency: coherency between
virtual aliases.  Other kinds, such as coherency between different
CPUs or with the i-cache, are not the subject of this test).

The test also measured whether alternating accesses between two
different addresses which view the same memory location was
significantly slower than when the two different addresses viewed
different memory.  This was intended to detect kernels which implement
cache coherency by marking the pages uncacheable, or using page faults.

The test also measured whether a tight write/write/read instruction
sequence was cache incoherent, even when a looser instruction sequence
was coherent.  This was to detect CPUs which have incoherent write
buffer (aka. store buffer) pipelines in the presence of virtual
aliasing, despite having coherent L1 caches.


Observations
============

Virtual alias performance penalty
.................................

It was a surprise to me to learn of L1 caches which are coherent, but
have a performance penalty when there is virtual aliasing.  In
retrospect this is obvious, but I didn't think of it at the time.

This penalty is present on all the AMD chips (x86 clones, x86_64), but
not the Intels (x86s, IA64).  It's possible that there's a small
penalty on Intels, lower than the threshold of the test, but I did not
detect any penalty at all on my Intel Celeron.

The file <asm-ia64/shmparam.h> suggests that IA64 will see a
performance penalty for virtual aliases that aren't a multiple of 1MB
apart.  None of the results I received indicate a significant penalty.
(The test deems a factor of 2 in access time to be significant).


Write buffers
.............

It was a surprise to discover CPUs which have incoherent write buffers
yet have coherent L1 caches.  (This means that a write to a virtual
address which is read from within very few instructions returns the
written data, completely ignoring any intervening write instructions
which write to a different virtual address which maps to the same
memory location.)  I didn't exect to find any of these.

    CPUs with incoherent write buffers: PA-RISC 2.0, 68040 and ARMs.


Coherent and not coherent CPUs
..............................

As expected, some CPUs don't offer cache coherency between virtual
alises at small address separations, and some do.  Generally:

    Virtual alias coherent:     x86, IA64, x86_64, PPC, Alpha, VAX, S390
    Virtual alias not coherent: Sparc, PA-RISC, ARM, MIPS, m68k, SH


Validity of SHMLBA value
........................

Many CPUs offer virtual cache coherency when the aliases are separated
by a certain CPU-dependent multiple.  In principle, all
Linux-supported architectures _should_ have a multiple which makes
virtual aliases coherent, because it's defined in the API as "SHMLBA".
However, on some specific CPUs, no coherent multiple was found.

    Valid kernel SHMLBA:	Sparc, PA-RISC, MIPS
				(plus all the coherent architectures)
    SHMLBA not valid:		ARM, m68k
    SHMLBA not defined:		SH

Note that "SHMLBA" is defined for some architectures on which it
doesn't actually provide coherent virtual aliases.  On the ARM this is
believed to be due to a chip bug, and very recent kernels may contain
a workaround for it (disabling the write buffer for aliased pages).

No workaround for the m68k was determined during this test.

Note that Glibc's definition of SHMLBA may differ from the kernel's
definition.  I'm looking at
glibc-2.3.1/sysdeps/unix/sysv/linux/sparc/bits/shm.h, which defines
SHMLBA to be the same as the page size.  The Glibc MIPS definition is
similar.

Moral: you can't trust "SHMLBA" to indicate when virtual aliases are coherent.


Test results
============

Here are all the results that folk sent me.

    - "all pass" means the cache is coherent and the timing acceptable

    - "SLOW <16k" means the cache is coherent but there's a timing penalty
      for alternating rapidly between the same location in two views.

    - "PIPELINE FAIL!" means the L1 cache is coherent, but the CPU's
      pipeline is not for instructions close together.

    - "FAIL <16k" means the cache is not coherent below a certain size.

    - "ALL FAIL" means the cache is not coherent at any size.

    - "ALL MAPS FAIL" means it wasn't possible to do a MAP_SHARED
      mapping of a file at two different addresses.  This only happens
      with some other operating systems, not GNU/Linux.


i386
====

all pass	- x86, unknown type running NetBSD
all pass	- x86, unknown type running OpenBSD
all pass	- x86, unknown type running SCO
all pass	- x86, Intel  90MHz Pentium
all pass	- x86, Intel 133MHz Pentium
all pass	- x86, Intel 200MHz Pentium MMX
all pass	- x86, Intel 200MHz dual Pentium Pro
all pass	- x86, Intel 233MHz P2 Klamath
all pass	- x86, Intel 300MHz P2 Klamath
all pass	- x86, Intel 300MHz P2 Deschutes
all pass	- x86, Intel 350MHz P2 Deschutes
all pass	- x86, Intel 366MHz Celeron Mendocino
all pass	- x86, Intel 400MHz unknown 686 on FreeBSD
all pass	- x86, Intel 400MHz P2 Deschutes
all pass	- x86, Intel 400MHz dual P2 Deschutes
all pass	- x86, Intel 400MHz dual P3 Katmai
all pass	- x86, Intel 450MHz dual Xeon running SunOS 5.7
all pass	- x86, Intel 466MHz Celeron Mendocino
all pass	- x86, Intel 466MHz Celeron Mendocino
all pass	- x86, Intel 466MHz dual Celeron Mendocino
all pass	- x86, Intel 500MHz Celeron Mendocino
all pass	- x86, Intel 500MHz dual P3 Katmai
all pass	- x86, Intel 533MHz Celeron Mendocino
all pass	- x86, Intel 550MHz dual P3 Katmai
all pass	- x86, Intel 668MHz dual P3 Coppermine
all pass	- x86, Intel 700MHz P3 Coppermine
all pass	- x86, Intel 700MHz P3 Coppermine
all pass	- x86, Intel 700MHz Celeron Coppermine
all pass	- x86, Intel 800MHz P3 Coppermine
all pass	- x86, Intel 850MHz P3 Coppermine +2HT
all pass	- x86, Intel 900MHz Celeron Coppermine
all pass	- x86, Intel 1.133GHz dual P3
all pass	- x86, Intel 1.7GHz P4
all pass	- x86, Intel 1.7GHz P4
all pass	- x86, Intel 1.7GHz P4
all pass	- x86, Intel 1.8GHz P4
all pass	- x86, Intel 1.8GHz dual P4 Xeon
all pass	- x86, Intel 2.0GHz mobile P4
all pass	- x86, Intel 2.4GHz dual P4 Xeon +2HT - cpufreq set to minimum
unsure		- x86, Intel 2.4GHz dual P4 Xeon +2HT - cpufreq set to maximum

SLOW <16k	- x86, AMD 200MHz K6
SLOW <16k	- x86, AMD 233MHz K6-2
SLOW <16k	- x86, AMD 300MHz K6-2
SLOW <16k	- x86, AMD 300MHz K6 3D
SLOW <16k	- x86, AMD 350MHz K6 3D
SLOW <16k	- x86, AMD 450MHz K6 3D
SLOW <32k	- x86, AMD 750MHz Athlon
SLOW <32k	- x86, AMD 800MHz Athlon
SLOW <32k	- x86, AMD 900MHz Athlon
SLOW <32k	- x86, AMD 900MHz Athlon
SLOW <32k	- x86, AMD 1.2GHz Athlon
SLOW <32k	- x86, AMD 1.3GHz Duron
SLOW <32k	- x86, AMD 1.4GHz Athlon XP 1600+
SLOW <32k	- x86, AMD 1.5GHz Athlon XP 1800+
SLOW <32k	- x86, AMD 1.5GHz dual Athlon
SLOW <32k	- x86, AMD 1.5GHz dual Athlon MP 1800+
SLOW <32k	- x86, AMD 1.5GHz dual Athlon MP 1800+
SLOW <32k	- x86, AMD 1.5GHz dual Athlon MP 1800+
SLOW <32k	- x86, AMD 1.6Ghz Athlon XP 1900+
SLOW <32k	- x86, AMD 1.6GHz dual Athlon MP 1900+
SLOW <32k	- x86, AMD 1.85GHz Athlon XP 2100+
SLOW <32k	- x86, AMD 1.8GHz dual Athlon MP 2200+
SLOW <32k	- x86, AMD 2.15GHz Athlon XP 2700+
SLOW <32k	- x86, AMD 2.1GHZ Athlon XP 2800+

IA64
====

all pass	- IA64, 800MHz dual Itanium
all pass	- IA64, 900MHz dual Itanium 2 in HP ZX6000
all pass	- IA64, 900MHz quad Itanium 2

x86_64
======

SLOW <32k	- x86_64, AMD 1.8GHz dual Opteron 244

Sparc
=====

all pass	- Sparc, TI MicroSparc, 50 bogomips (test takes >1 second)
all pass	- Sparc, TI dual SuperSparc II, 50 bogomips
all pass	- Sparc, UltraSparc II 296MHz running SunOS 5.6
FAIL <16k	- Sparc, TI UltraSparc IIi Spitfire, 539 bogomips
FAIL <16k	- Sparc, TI UltraSparc II BlackBird, 600 bogomips
FAIL <16k	- Sparc, TI UltraSparc II BlackBird, 600 bogomips
FAIL <16k	- Sparc, TI UltraSparc IIi Spitfire, 719 bogomips

PowerPC
=======

all pass	- PPC, unknown type, iMac running OS X 10.2, Darwin
all pass	- PPC, 604r (PRep Utah Powerstack II Pro4000), 299 bogomips
all pass	- PPC, 232MHz 604r (PReP IBM 43P-140 Tiger1)
all pass	- PPC, 200MHz 405CR in Ericsson ELN 2XX
all pass	- PPC, 333MHz 750 in PowerMac
all pass	- PPC, 500MHz G4, 7400 + altivec in PowerMac
all pass	- PPC, IBM 440GX Rev. A in Ocotea, 625 bogomips
all pass	- PPC, 667MHz G4, 7455 + altivec in PowerBook Titanium 3

PA-RISC
=======

FAIL <128k	- PA-RISC, 1.1d PA7100LC 80MHz
PIPELINE FAIL!	- PA-RISC, 2.0 Crescendo 550 (9000/800/A500-5X)
PIPELINE FAIL!	- PA-RISC, 2.0 Crescendo 550 (9000/800/A500-5X)
(In both of these, L1 FAILs <256k, stores fail <4M, and data cache size is 1M)

ARM
===

all pass	- ARM, ARM720T rev 2 (v4l), Philips SAA7752, 47.8 bogomips
FAIL ALL	- ARM, SA-110 rev 3 (v4l)
FAIL ALL	- ARM, 275MHz SA-110 rev 3, 186 bogomips in Rebel Netwinder
FAIL ALL	- ARM, SA-110 rev 3, 262 bogomips, in Rebel NetWinder
SLOW ALL	- ARM, SA-1110 rev 8, 147 bogomips in Intel Assabet
SLOW ALL	- ARM, Intel XScale-PXA250 rev 3, 397 bogomips
SLOW ALL	- ARM, Intel XScale-PXA255 rev 6, 397 bogomips on Zaurus

MIPS
====

all pass	- MIPS, R3400A V3.0 40 bogomips in Digital DECstation 5000/240
SLOW <16k	- MIPS, R4400SC V4.0 60 bogomips in Digital DECstation 5000/260
SLOW <16k	- MIPS, R4000SC V5.0, 75 bogomips, in SGI Indigo2
SLOW <16k	- MIPS, R4000SC V6.0, 87 bogomips
FAIL <16k	- MIPS, R5000 Nevada V10.0, 250 bogomips, in Cobalt Qube
FAIL <16k	- MIPS, R5000 Nevada V10.0, 250 bogomips, in Cobalt Qube
all pass	- MIPS, 5Kc V0.1, 160 bogomips in Malta
all pass	- MIPS, R10000 V2.6, 195MHz running SGI IRIX64

Alpha
=====

all pass	- Alpha, 166MHz LCA4 (1.4sec test)
all pass	- Alpha, 500MHz EV56 in Digital AlphaPC 164
SLOW <32k	- Alpha, 500MHz dual EV6 in AlphaServer DS20 500 (4sec test)
all pass	- Alpha, a Tru64 running OSF1

m68k
====

all pass	- m68k, 15.6MHz 68020 + 68851 MMU on Plessey PME 68-22
FAIL ALL	- m68k, 19.6MHz 68030, 4.90 bogomips on Motorola MVME147
PIPELINE FAIL!	- m68k, 24.8MHz 68040
(Stores fail at all sizes)
all pass	- m68k, 50MHz   68060

VAX
===

all pass	- VAX 8650

SH
==

FAIL <16k	- SH4, 200MHz SH7750 on Sega Dreamcast
FAIL <8k	- SH5, 315MHz SH5-101 on Hitachi Cayman

IBM S390
========

all pass	- S390, 582 bogomips
all pass	- S390, 613 bogomips

OSes that fail to map
=====================

ALL MAPS FAIL	- PPC, 332MHz 604e, running AIX
ALL MAPS FAIL	- PA-RISC, C360 on HPUX 10.20
ALL MAPS FAIL	- PA-RISC, HPPA 9000/785 running HPUX 10.20, all compile flags
ALL MAPS FAIL	- x86, unknown type running Windows XP


Enjoy, and thanks again,
-- Jamie
