Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317260AbSFCC66>; Sun, 2 Jun 2002 22:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317261AbSFCC65>; Sun, 2 Jun 2002 22:58:57 -0400
Received: from rj.SGI.COM ([192.82.208.96]:54226 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S317260AbSFCC6z>;
	Sun, 2 Jun 2002 22:58:55 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: kbuild 2.5 timing comparisons
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 03 Jun 2002 12:58:46 +1000
Message-ID: <28211.1023073126@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timing comparisons of kbuild 2.5 release 3.0 and existing 2.5.19
makefiles.

======================================================================

I don't care how fast a build is, if it is not accurate then the time
is wasted.  Fortunately kbuild 2.5 is both fast and 100% accurate,
unlike the existing build system.

======================================================================

Full 2.5.19 config.  The full config is too big for bzImage so build vmlinux.
Machine 1 - 4 x PIII @700 MHz, 1GB ram.

  kbuild 2.5

    make -f Makefile-2.5 -j4 allyes installable		14:11.39
    make -f Makefile-2.5 -j4				00:07.94 [a]
    rm drivers/net/wan/cosa.o (module)
    make -f Makefile-2.5 -j4				00:10.79
    rm drivers/net/wan/cosa.o
    make -f Makefile-2.5 -j4 NO_MAKEFILE_GEN=1		00:06.36 [b]
    rm drivers/net/wan/cosa.o
    make -f Makefile-2.5 -j4 NO_MAKEFILE_GEN=1		00:04.51 [c]
    rm vmlinux
    make -f Makefile-2.5 -j4				00:41.80 [d]
    make -f Makefile-2.5 -j4 NO_MAKEFILE_GEN=1		00:03.48 [b]
    make -f Makefile-2.5 -j4 NO_MAKEFILE_GEN=1		00:01.63 [e]

    [a] No spurious rebuilds in kbuild 2.5.  8 seconds to regenerate
        the global makefile and determine that the entire kernel is up
        to date.
    [b] First use of NO_MAKEFILE_GEN=1 takes ~2 seconds to set up the
        correct environment.
    [c] Mainly the build time for cosa.o.
    [d] Mainly the link time for vmlinux.
    [e] 1.6 seconds to run the entire kernel makefile once it has been
        built.

 Existing kbuild.  Slightly shorter .config because some of the 2.5.19
 Makefiles are broken.  The code compiles under kbuild 2.5 but not
 under the 2.5.19 makefiles.

    make oldconfig dep					00:55.21 [a]
    make -j4 BUILD_MODULES=1 vmlinux			13:48.89
    make -j4 BUILD_MODULES=1 vmlinux			04:51.24 [b]
    make -j4 BUILD_MODULES=1 vmlinux			00:48.20 [c]
    make -j4 BUILD_MODULES=1 vmlinux			00:43.15 [d]

    [a] make dep is not parallel safe.
    [b] No change from [a], but spurious rebuilds all over the place.
        That's what you get for using recursive make instead of a
        global makefile.
    [c] No change from [b], but it still has spurious rebuilds.
    [d] No change from [c], it rebuilt init files and relinked vmlinux
        for no good reason.

 Not only is the existing build system significantly slower than kbuild
 2.5, it is also unreliable.  It takes four builds to get a stable
 result.

 Total time to a stable result:

   kbuild 2.5	14:11  (one pass)
   Existing	21:00+ (four passes)

======================================================================

Minimal 2.5.19 config.
Machine 2 - 1 x PIII @550 MHz, 32MB ram.

  kbuild 2.5

    make -f Makefile-2.5 allno installable		03:53.16
    make -f Makefile-2.5 				00:19.89 [a]
    rm vmlinux
    make -f Makefile-2.5				00:26.08
    make -f Makefile-2.5 NO_MAKEFILE_GEN=1	 	00:04.31 [b]
    make -f Makefile-2.5 NO_MAKEFILE_GEN=1	 	00:01.38 [c]

    [a] No spurious rebuilds in kbuild 2.5.
    [b] First use of NO_MAKEFILE_GEN=1 takes ~2 seconds to set up the
        correct environment.
    [c] 1.38 seconds to run the entire kernel makefile once it has been
        built.

  Existing kbuild on same config.

    make oldconfig dep					01:10.72
    make BUILD_MODULES=1 vmlinux			02:43.88
    make BUILD_MODULES=1 vmlinux			00:07.04

  On a minimal configuration, the existing system is slightly faster.
  But that comes at the expense of an unreliable build method on
  parallel builds.

======================================================================

Medium 2.5.19 config.
Machine 2 - 1 x PIII @550 MHz, 32MB ram.

  kbuild 2.5

    make -f Makefile-2.5 oldconfig installable		10:26.88
    make -f Makefile-2.5 				00:27.58

  Existing kbuild.

    make BUILD_MODULES=1 oldconfig dep vmlinux		10:18.09

  On a small machine, the two systems are comparable.  But only kbuild
  2.5 is accurate.

  2:01.12
  0:05.55


Medium 2.5.19 config.
Machine 1 - 4 x PIII @700 MHz, 1GB ram.

  kbuild 2.5

    make -f Makefile-2.5 oldconfig installable		02:01.12
    make -f Makefile-2.5 				00:05.55

  Existing kbuild.

    make oldconfig dep					00:44.87 [a]
    make -j4 BUILD_MODULES=1 vmlinux			01:43.06
    make -j4 BUILD_MODULES=1 vmlinux			00:36.28 [b]
    make -j4 BUILD_MODULES=1 vmlinux			00:03.79 [c]

    [a] make dep is not parallel safe.
    [b] No change from [a], but spurious rebuilds all over the place.
        That's what you get for using recursive make instead of a
        global makefile.
    [c] No change from [b], finally stable.

  kbuild 2.5 is both faster and accurate.

======================================================================

The spurious rebuilds are not even deterministic.  They depend on the
relative time that each directory is processed (which depends on the
system load and the number of processors) and the timestamps on the
files before you did the build.  IOW, the spurious rebuilds depend on
what you did in the source tree last time.

Which raises the interesting question - how many of the rebuilds are
spurious and how many are really required?

To demonstrate the unreliable parallel build on an SMP box -

find -type f | xargs touch
make oldconfig dep
make -j4 BUILD_MODULES=1 vmlinux
make -j4 BUILD_MODULES=1 vmlinux

Don't be surprised if it rebuilds vmlinux even if nothing else changes.
There is a bug somewhere in the existing 2.5.19 makefiles that does not
get the rebuild rule right.

======================================================================

The fact that the existing rules generate spurious rebuilds is bad
enough.  What is much worse is that they do not detect changes
correctly, so objects are not recompiled when they should be.  Build a
config with all of ACPI turned on, run the existing rules until you get
a stable build (all spurious rebuilds have finished).

echo '#warning aclocal.h used' >> drivers/acpi/include/aclocal.h 
make -j4 BUILD_MODULES=1 vmlinux

ACPI does not rebuild, even though its headers have changed.

======================================================================

I don't care how fast a build is, if it is not accurate then the time
is wasted.  Fortunately kbuild 2.5 is both fast and 100% accurate,
unlike the existing build system.

