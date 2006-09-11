Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964853AbWIKAet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964853AbWIKAet (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 20:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbWIKAet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 20:34:49 -0400
Received: from sccrmhc15.comcast.net ([63.240.77.85]:61149 "EHLO
	sccrmhc15.comcast.net") by vger.kernel.org with ESMTP
	id S964855AbWIKAes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 20:34:48 -0400
Message-ID: <4504AF26.9040807@comcast.net>
Date: Sun, 10 Sep 2006 20:34:46 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Cache line size
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Is there a way for the Linux Kernel to know the cache line size of the
CPU it's on, besides #define X86_CACHE_LINE_SZ 32 or whatnot?  I am
looking in /proc/cpuinfo trying to determine how to run caching
optimizations and interested in this information and its implications.
It may also be useful if I can get this information at run time in
application code.



For the curious (those of you who don't care, stop reading; those who
are going to tell me I shouldn't care about these numbers, keep reading
anyway), I am trying to avoid false sharing in a memory allocator,
mainly by bitmapping cache lines on top of the 16 byte block bitmap per
thread.

In many cases I avoid segment sharing altogether.  Segments suffering
from lack of use are returned to the global scope for other threads; but
so are segments in terminated threads.  Threads needing more space try
to retrieve their own segments; when this is not possible, they retrieve
segments from terminated threads.  When both of these options fails,
segments owned by active threads set in the global scope are adopted.

When segments are shared, there is the potential that the same cache
line may be allocated in different threads, possibly leading to
concurrent access to the same cache line on different CPUs in an SMP
environment.  To avoid this, each active thread with any allocations in
a shared segment will keep a bitmap of its own used cache lines, and
overlay that bitmap onto the master cache line bitmap for the segment.

Cache lines in use but not by the current thread will not be used by the
current thread for allocations.  Whenever a thread terminates, it
removes all cache lines it holds from use in the master cache line
bitmap; false sharing cannot occur if there is no thread to share with,
so overlapping cache lines with the dead thread is not an issue (and not
technically possible).

Diagram:

Bitmap:  |x|x| |x|x| | | |x|x|  16 byte blocks
CLnBMP:  | X | X | X |   |   |  32 byte cache lines
T1CLnB:  | X |   | X |   |   |  Cache lines from Thread 1
T2CLnB:  |   | X |   |   |   |  Cache lines from Thread 2
                      ^   ^--Used by dead thread
                      |--Unused

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond

    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRQSvJAs1xW0HCTEFAQIAqg/+MPRPOIJyJAjofYY6vihj+2+THCKEXUL8
wdWbxSixKSi12RWK3YJhlDI4TjeSfke4QU5CwC80msb4tKnMouS6oWqauWMLHOqG
ky1b4I57IAB94Jol2ydyUd87GhNShQWpwACnH5+e6bdm4qUCtY62mDRH3DcEC+Vr
yAtNVClXQjOvHBkhDaraHZQVXXa4ucOPgLr4eyVutxOMDQQ2Rf8wOGHvSIFMkEK3
qTledtIOrTfvMEpB75peT2+1cS08ku90j+as3+IyDIPviRBuF5goO6JcH3XJFBlE
Yqord1i44PZdsQHPK68W7x+Pglof3yGw1VEmB2/UTf3J+n2FMh+NxEdrxeq1pyKJ
MljokFb8u6czjN/g10xGj/JvJKhV/9k2xwcs0SRPR0CHavrKCpO4QdvOQOMalqZ9
dzPKQHMiLJliTRsDAD9gVhplMODFEbGaiHDmjccuDtyFs8TtxgMc0wQArzJu9SSO
YZOszWMXpR9HbE3P1KKctQuD4h2T2wdUnR2Rc49Upoo8TdtOAMJgabx9jlPlt5IZ
uZrUiBx+gC5ac2UhrI2shOJBUYc4h5OG3zFZ4b4UJ97kz2v50V8FCYzqENMDhfQQ
8VHLd2LDDdhBGKKKUTWboYFV/NlJBiWpxzhOfEz8wg9llmYIMIY+iGdGRqBzkCkf
xUyVeiEgSFE=
=+Y7F
-----END PGP SIGNATURE-----
