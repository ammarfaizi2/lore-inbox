Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130820AbRDGTpu>; Sat, 7 Apr 2001 15:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131191AbRDGTpl>; Sat, 7 Apr 2001 15:45:41 -0400
Received: from tomts14.bellnexxia.net ([209.226.175.35]:53720 "EHLO
	tomts14-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S130820AbRDGTpc>; Sat, 7 Apr 2001 15:45:32 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
Subject: [PATCH][RFC] appling pressure to icache and dcache - simplified
Date: Sat, 7 Apr 2001 15:45:28 -0400
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01040507463401.00699@oscar>
Content-Transfer-Encoding: 7BIT
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Rik asked, "Can it be made simpler?"

So I went back to the basics, inserted a printk in kswapd and watched
the dentry_stat and inodes_stat numbers for a while.   I observed
the following pattern.  The dentry cache grows as does the number of 
unused entries in it.  Unless we shrink this cache objects do not seem
to be reused.  At the same time the inode cache usually kept about 15% 
free.

At this point I starting to shrink the dcache.  The goal being to keep 
the size of the cache as observed in /proc/slabinfo reasonable without 
much overhead.  From experimenting, it turns out that if the shrink
call is made when there is over 50% free space the cache stays small.
Using 66% is not quite as aggressive but achieves its effect with about
half the shrink calls.

With the pressure on the dcache, I looked at the icache numbers.  With  
the dcache shrinking the amount of free space in the icache was much 
higher.  It turns out that using the same logic as above with, 80% as 
the amount of free space, it works well.

Here are the results against 2.4.3-ac3

Thoughs?

-----
--- linux.ac3.orig/mm/vmscan.c	Sat Apr  7 15:20:49 2001
+++ linux/mm/vmscan.c	Sat Apr  7 12:37:27 2001
@@ -997,6 +997,21 @@
 		 */
 		refill_inactive_scan(DEF_PRIORITY, 0);
 
+		/* 
+		 * Here we apply pressure to the dcache and icache.
+		 * The nr_inodes and nr_dentry track the used part of
+		 * the slab caches.  When there is more than X% objs free
+		 * in these lists, as reported by the nr_unused fields,
+		 * there is a very good chance that shrinking will free
+		 * pages from the slab caches.  For the dcache 66% works,
+		 * and 80% seems optimal for the icache.
+		 */
+
+		if ((dentry_stat.nr_unused+(dentry_stat.nr_unused>>1)) > dentry_stat.nr_dentry)
+			shrink_dcache_memory(DEF_PRIORITY, GFP_KSWAPD);
+		if ((inodes_stat.nr_unused+(inodes_stat.nr_unused>>2)) > inodes_stat.nr_inodes)
+			shrink_icache_memory(DEF_PRIORITY, GFP_KSWAPD);
+
 		/* Once a second, recalculate some VM stats. */
 		if (time_after(jiffies, recalc + HZ)) {
 			recalc = jiffies;
-----

Ed Tomlinson <tomlins@cam.org>

