Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263711AbTJ0BBe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 20:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263713AbTJ0BBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 20:01:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:50078 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263711AbTJ0BBa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 20:01:30 -0500
Date: Sun, 26 Oct 2003 17:02:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: Burton Windle <bwindle@fint.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: fsstress causes memory leak in test6, test8
Message-Id: <20031026170241.628069e3.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0310251842570.371@morpheus>
References: <Pine.LNX.4.58.0310251842570.371@morpheus>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Burton Windle <bwindle@fint.org> wrote:
>
> There is a memory leak in the test6 - test8 kernels when doing heavy disk
>  IO. After running fsstress, there is a significant ammount of memory that
>  is unaccounted for.

OK, this is simple, but fixing it invalidates lots of testing of the
traditionally-tricky VFS cache shrinking code.

It is not a "leak" as such - the dentries will get shrunk in normal usage
(create enough non-dir dentries and the "leaked" directory dentries will
get reclaimed).  The really deep directories which fsstress creates
demonstrated the bug.


Given that it took a year for anyone to notice, it's probably best that
this not be included for 2.6.0.




This fixes the recently-reported "fsstress memory leak" problem.  It has been
there since November 2002.

shrink_dcache() has a heuristic to prevent the dcache (and hence icache) from
getting shrunk too far: it refuses to allow the dcache to shrink below
2*nr_used.

Problem is, _all_ non-leaf dentries (directories) count as used.  So when you
have really deep directory hierarchies (fsstress creates these), nr_used is
really high, and there is no upper bound to the amount of pinned dcache.

The patch just rips out the heuristic.  This means that dcache (and hence
icache (and hence pagecache)) will be shrunk more aggressively.  This could
be a problem, and tons of testing is needed - a new heuristic may be needed.

However I am not able to reproduce the problem which cause me to add this
heuristic in the first place:

   Simple testcase: run a huge `dd' while running a concurrent `watch -n1
   cat /proc/meminfo'.  The program text for `cat' gets loaded from disk once
   per second.




 fs/dcache.c |   21 +--------------------
 1 files changed, 1 insertion(+), 20 deletions(-)

diff -puN fs/dcache.c~dentry-bloat-fix-2 fs/dcache.c
--- 25/fs/dcache.c~dentry-bloat-fix-2	2003-10-26 04:00:13.000000000 -0800
+++ 25-akpm/fs/dcache.c	2003-10-26 16:31:05.000000000 -0800
@@ -639,24 +639,9 @@ void shrink_dcache_anon(struct hlist_hea
 
 /*
  * This is called from kswapd when we think we need some more memory.
- *
- * We don't want the VM to steal _all_ unused dcache.  Because that leads to
- * the VM stealing all unused inodes, which shoots down recently-used
- * pagecache.  So what we do is to tell fibs to the VM about how many reapable
- * objects there are in this cache.   If the number of unused dentries is
- * less than half of the total dentry count then return zero.  The net effect
- * is that the number of unused dentries will be, at a minimum, equal to the
- * number of used ones.
- *
- * If unused_ratio is set to 5, the number of unused dentries will not fall
- * below 5* the number of used ones.
  */
 static int shrink_dcache_memory(int nr, unsigned int gfp_mask)
 {
-	int nr_used;
-	int nr_unused;
-	const int unused_ratio = 1;
-
 	if (nr) {
 		/*
 		 * Nasty deadlock avoidance.
@@ -672,11 +657,7 @@ static int shrink_dcache_memory(int nr, 
 		if (gfp_mask & __GFP_FS)
 			prune_dcache(nr);
 	}
-	nr_unused = dentry_stat.nr_unused;
-	nr_used = dentry_stat.nr_dentry - nr_unused;
-	if (nr_unused < nr_used * unused_ratio)
-		return 0;
-	return nr_unused - nr_used * unused_ratio;
+	return dentry_stat.nr_unused;
 }
 
 #define NAME_ALLOC_LEN(len)	((len+16) & ~15)

_

