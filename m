Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133061AbRDLHL3>; Thu, 12 Apr 2001 03:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133060AbRDLHLO>; Thu, 12 Apr 2001 03:11:14 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:35557 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S133059AbRDLHKu>;
	Thu, 12 Apr 2001 03:10:50 -0400
Date: Thu, 12 Apr 2001 03:10:46 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Andreas Dilger <adilger@turbolinux.com>, kowalski@datrix.co.za,
        linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: [CFT][PATCH] Re: Fwd: Re: memory usage - dentry_cache
In-Reply-To: <3AD550F0.8058FAA@mandrakesoft.com>
Message-ID: <Pine.GSO.4.21.0104120257070.18135-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 12 Apr 2001, Jeff Garzik wrote:

> Alexander Viro wrote:
> > We _have_ VM pressure there. However, such loads had never been used, so
> > there's no wonder that system gets unbalanced under them.
> > 
> > I suspect that simple replacement of goto next; with continue; in the
> > fs/dcache.c::prune_dcache() may make situation seriously better.
> 
> Awesome.  With the obvious patch attached, some local ramfs problems
> disappeared, and my browser and e-mail program are no longer swapped out
> when doing a kernel build.
> 
> Thanks :)

OK, how about wider testing? Theory: prune_dcache() goes through the
list of immediately killable dentries and tries to free given amount.
It has a "one warning" policy - it kills dentry if it sees it twice without
lookup finding that dentry in the interval. Unfortunately, as implemented
it stops when it had freed _or_ warned given amount. As the result, memory
pressure on dcache is less than expected.

Patch being:
--- fs/dcache.c Sun Apr  1 23:57:19 2001
+++ /tmp/dcache.c       Thu Apr 12 03:07:39 2001
@@ -340,7 +340,7 @@
                if (dentry->d_flags & DCACHE_REFERENCED) {
                        dentry->d_flags &= ~DCACHE_REFERENCED;
                        list_add(&dentry->d_lru, &dentry_unused);
-                       goto next;
+                       continue;
                }
                dentry_stat.nr_unused--;
 
@@ -349,7 +349,6 @@
                        BUG();
 
                prune_one_dentry(dentry);
-       next:
                if (!--count)
                        break;
        }


