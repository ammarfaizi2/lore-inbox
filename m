Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292156AbSBBA0D>; Fri, 1 Feb 2002 19:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292159AbSBBAZy>; Fri, 1 Feb 2002 19:25:54 -0500
Received: from noodles.codemonkey.org.uk ([62.49.180.5]:49044 "EHLO
	noodles.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id <S292156AbSBBAZi>; Fri, 1 Feb 2002 19:25:38 -0500
Date: Sat, 2 Feb 2002 00:25:32 +0000
From: Dave Jones <davej@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.5 include file shakeup.
Message-ID: <20020202002532.A7782@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

after yesterdays cleanup removing sched.h inclusion from fs/,
I looked at the dependancy graph for sched.h[1], and noticed that
even with the removal of the explicit #include <linux/fs.h>, it
was still being sucked in via <linux/capability.h>

Ripping this out meant breakage in various parts of the tree, who
until now were relying on xxx including sched.h including fs.h
these things are now including fs.h.

The next step is to split up fs.h some more, as some things are
including it for trivial bits, but sucking in things like the superblock
includes for every fs.  I've already started this by moving ERR_PTR and
friends into <linux/err.h>

Patch is at ftp://ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.5/misc/include-cleanup-1.diff.gz

Not tested on anything other than x86, and I expect some breakage.
In most cases, it should be missing includes of err.h, some others may
fs.h (but better would be to include whatever fs.h provides)
non-x86 testers/patches are more than welcomed.

Is all this worth it ? Take a look at the updated dependancy graph
after the cleanups[2], and I think you'll agree things look much more
sensible.  We also gain a little speed increase on the compile..

make dep bzImage on a 866MHz Cyrix3 with a fast disk..
                real       user      sys
2.5.3           12m37.110s 11m8.580s 0m47.590s
2.5.3+cleanup   12m8.053s  11m0.670s 0m47.450s

make dep on a quad ppro with a _slow_ disk.
                real       user       sys
2.5.3           2m50.229s  1m51.370s  0m12.640s
2.5.3+cleanup   1m44.634s  1m32.580s  0m10.200s

make -j4 bzImage on the same quad
2.5.3           9m11.167s  31m8.060s  2m20.950s
2.5.3+cleanup   9m8.546s   30m33.020s 2m18.710s

Further compile time decreases should be possible by looking a little
harder at various places that are including sched.h, and also when we
get to the aforementioned fs.h cleanup.  Currently some of the compile
fixes introduced in this patch are taking the easy way out, and including
fs.h, but this is after all, the first phase of this cleanup.

Comments?


[1] ftp://ftp.kernel.org/pub/linux/kernel/people/davej/misc/schedh-before.ps.gz
[2] ftp://ftp.kernel.org/pub/linux/kernel/people/davej/misc/schedh-after.ps.gz

-- 
Dave Jones.                    http://www.codemonkey.org.uk
SuSE Labs.
