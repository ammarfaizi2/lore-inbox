Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316532AbSE3Jpk>; Thu, 30 May 2002 05:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316535AbSE3Jpj>; Thu, 30 May 2002 05:45:39 -0400
Received: from dsl-213-023-038-015.arcor-ip.net ([213.23.38.15]:28118 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316532AbSE3Jph>;
	Thu, 30 May 2002 05:45:37 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: KBuild 2.5 Impressions
Date: Thu, 30 May 2002 11:45:14 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Keith Owens <kaos@ocs.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17DMUd-0007dJ-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wanted to know how well kbuild 2.5 really works, so I got the patches
from kbuild.sourceforge.net and gave them a test drive, comparing to
old kbuild.  First I did an out-of-the-box build, then I did 'touch
fs/ext2/inode.c' and rebuilt.  Results are as follows:

                         old kbuild       kbuild 2.5     Speedup

   First time build:     7 min 8 sec     5 min 55 sec     17%
   Incremental build:     25.94 sec       15.31 sec       41% :-)

The test system is a 2 x 1 GHz server with scsi raid.  Note that I only
used one processor for the tests, as I normally do: in my experience,
with old kbuild I spend more time picking up the broken pices than
I save in compile time.

For good measure, I did a make mrproper and rebuild with -j3.  That
completed in 3 minutes, 25 seconds.  Very impressive, and what's more,
running that make a second time completes in 12 seconds, as opposed to
old make, which tends to erroneously rebuild a large number of files,
and sometimes does not complete the job correctly.

I have only one point on the curve, but it confirms what Keith has
been saying.  The incremental build speed is especially important to
me.  If I were working all the time on 2.5 - sadly, I'm not - I would
without question be using kbuild 2.5 simply by reason of the fast
incremental builds.

Miscellaneous Notes
-------------------

Along the way, old kbuild did the usual wrong things:

  - In the incremental build, 6 files rebuilt that should not have been

  - Once, when I interrupted the make dep, subsequent make deps would
    no longer work, forcing me to do make mrproper and start again.

  - Way too much output to the screen

I took a quick look into some of the kbuild 2.5 Makefile.in files, just
to get a feeling for what they look like, and they look fine to me.  For
example, fs/ext2 has acquired a Makefile.in file, with contents that
seem easily understandible.  The syntax of these files is explained in
the documentation, which is provided by the patch set, in:

   Documentation/kbuild/kbuild-2.5.txt

Reading through it, I found out about the NO_MAKEFILE_GEN, an option
that promises to make a fast build system even faster for interative
development, the type I always do.  There is also a lot of informative
design documentation.  Amazingly, there is even postscript
documentation.  Full marks for documentation here.

Note to Keith: this file needs to be in some obvious place on the
sourceforge site.

Both the old and new build systems failed the rename test: rename the
root of the source tree and it will no longer build.  The kbuild 2.5
documentation explains:

  Unlike kbuild 2.4, renaming a source or object tree does not force a
  complete rebuild.  After renaming any tree and updating the KBUILD_SRCTREE
  and KBUILD_OBJTREE variables, just run make.  Unless you have changed any
  files, nothing should be rebuilt, however the make step must be run to save
  the new tree names ready for the install step.

but this did not work for me.  However, I do not doubt that it will
soon.

Reading through the patches, I noticed there is some useful looking
help text added for the makefile operations, but it wasn't immediately
obvious how to get it.  Reading the patch is, of course, one way.

There is no Python anywhere to be seen in kbuild 2.5, for those who
worry about that.  It is coded in C, about 10,000 lines it seems.
It has a simple built in database which I suppose accounts for some
of that.  For what it does, it seems quite reasonable.  There is a
bison-generated grammar, presumeably to parse the Makefile.in
language.  This is the proper way do do things - much more reliable
and maintainable than a hand-coded parser, not to mention more
efficient.  Most of the rest of the patch consists of Makefile.in
files.  I can really see why this is a big job for Keith to maintain
by himself: the maintainers really need to be involved.  I doubt that
it will be hard, and by appearances, there is no need for any
particular arch to step up to kbuild 2.5 immediately, since the old
build system still works.  In any event, the 1386-specific part of
the patch is only 700 or so lines long.

The output that kbuild 2.5 generates is a vast improvment over old
make.  It's enough to see the progress of the make, while not
obscuring the warnings.  This by itself should help in cleaning up
the tree.

Note to anyone who wants to try this themselves: with the kbuild 2.5
patches applied, nothing changes (and the old build system is used)
unless you add '-f Makefile-2.5' to the make command.  It does not
appear to be necessary to supply a bzImage target, and in fact,
Makefile-2.5 doesn't recognize it.  That's basically all you have to
know.

Detailed Timings
----------------

Old kbuild, out of the box build:

424.18user 29.65system 7:07.94elapsed 106%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (1552796major+1856222minor)pagefaults 0swaps

touch fs/ext2/inode.c incremental build:

24.08user 2.04system 0:25.94elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (114294major+80954minor)pagefaults 0swaps

kbuild 2.5, out of the box build:

341.29user 18.71system 5:54.87elapsed 101%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (1080599major+1427293minor)pagefaults 0swaps

touch fs/ext2/inode.c incremental build:

13.75user 1.76system 0:15.31elapsed 101%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (122776major+59338minor)pagefaults 0swaps

-- 
Daniel
