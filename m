Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317283AbSFCFsn>; Mon, 3 Jun 2002 01:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317284AbSFCFsm>; Mon, 3 Jun 2002 01:48:42 -0400
Received: from rj.SGI.COM ([192.82.208.96]:31964 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S317283AbSFCFsi>;
	Mon, 3 Jun 2002 01:48:38 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 timing comparisons 
In-Reply-To: Your message of "Mon, 03 Jun 2002 12:58:46 +1000."
             <28211.1023073126@kao2.melbourne.sgi.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 03 Jun 2002 15:48:29 +1000
Message-ID: <31268.1023083309@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timing comparisons of kbuild 2.5 release 3.0 and existing 2.5.20
makefiles.

======================================================================

I don't care how fast a build is, if it is not accurate then the time
is wasted.  Fortunately kbuild 2.5 is both fast and 100% accurate,
unlike the existing build system.

======================================================================

Full 2.5.20 config.  The full config is too big for bzImage so build
vmlinux.  This is a smaller config than 2.5.19, 2.5.20 introduced yet
more driver errors so fewer objects will build.
Machine 1 - 4 x PIII @700 MHz, 1GB ram.

  kbuild 2.5

    make -f Makefile-2.5 -j4 allyes installable		13:43.53
    make -f Makefile-2.5 -j4				00:07.94 [a]
    rm drivers/net/wan/cosa.o (module)
    make -f Makefile-2.5 -j4				00:10.72
    rm drivers/net/wan/cosa.o
    make -f Makefile-2.5 -j4 NO_MAKEFILE_GEN=1		00:06.30 [b]
    rm drivers/net/wan/cosa.o
    make -f Makefile-2.5 -j4 NO_MAKEFILE_GEN=1		00:04.43 [c]
    rm vmlinux
    make -f Makefile-2.5 -j4				00:37.21 [d]
    make -f Makefile-2.5 -j4 NO_MAKEFILE_GEN=1		00:03.47 [b]
    make -f Makefile-2.5 -j4 NO_MAKEFILE_GEN=1		00:01.57 [e]

    [a] No spurious rebuilds in kbuild 2.5.  8 seconds to regenerate
        the global makefile and determine that the entire kernel is up
        to date.
    [b] First use of NO_MAKEFILE_GEN=1 takes ~2 seconds to set up the
        correct environment.
    [c] Mainly the build time for cosa.o.
    [d] Mainly the link time for vmlinux.
    [e] 1.6 seconds to run the entire kernel makefile once it has been
        built.

 Existing kbuild.  Slightly shorter .config because some of the 2.5.20
 Makefiles are broken.  The code compiles under kbuild 2.5 but not
 under the 2.5.20 makefiles.

    make oldconfig dep					00:54.89 [a]
    make -j4 BUILD_MODULES=1 vmlinux			13:10.45
    make -j4 BUILD_MODULES=1 vmlinux			05:24.95 [b]
    make -j4 BUILD_MODULES=1 vmlinux			00:39.92 [c]
    make -j4 BUILD_MODULES=1 vmlinux			00:10.43 [d]

    [a] make dep is not parallel safe.
    [b] No change from [a], but spurious rebuilds all over the place.
        That's what you get for using recursive make instead of a
        global makefile.
    [c] No change from [b], but it still has spurious rebuilds.
    [d] Finally a stable build.

 Not only is the existing build system significantly slower than kbuild
 2.5, it is also unreliable.  It takes four builds to verify that you
 have a stable result.

 Total time to a stable result:

   kbuild 2.5	13:43  (one pass)
   Existing	20:00+ (four passes)

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

