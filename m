Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284536AbRLEWIu>; Wed, 5 Dec 2001 17:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284762AbRLEWIX>; Wed, 5 Dec 2001 17:08:23 -0500
Received: from nat.transgeek.com ([66.92.79.28]:44029 "HELO smtp.transgeek.com")
	by vger.kernel.org with SMTP id <S284657AbRLEWIH>;
	Wed, 5 Dec 2001 17:08:07 -0500
Content-Type: text/plain; charset=US-ASCII
From: Craig Christophel <merlin@transgeek.com>
To: linux-kernel@vger.kernel.org
Subject: shrink_caches inconsistancy
Date: Wed, 5 Dec 2001 17:09:54 -0500
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011205180526.DCB78C7382@smtp.transgeek.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	This patch makes the comments match for icache,dcache,dqcache   shrink 
functions.  Initially the comment stated that a priority of 0 could be used, 
but after looking into mm/vmscan.c::shrink_caches this cannot be true.  So 
the comment now states that 1 is the highest priority.  This appears __really 
true as at priority 1 all of the cache possible is removed.

	Also shrink_dqcache_memory now uses the count variable like everyone else.
	
	Possibly incorrect __GFP_FS check added to the dqcache function.  but again 
consistancy is my goal.  

	Another dqcache issue in that the dqcache was being shrunk at priority+1 
rather than at priority, this looked suspect, and with no comment around the 
code, it to has been remanded to consistancy.


Well, here goes.    Any comments and/or b#$chslaps welcome.  This is my first 
attempted patch after studying the VFS layer for a while, so please be 
(fairly) kind.

	Craig.


diff -urN linux/fs/dcache.c linux.mt/fs/dcache.c
--- linux/fs/dcache.c   Sat Dec  1 17:21:03 2001
+++ linux.mt/fs/dcache.c        Wed Dec  5 16:13:38 2001
@@ -543,7 +543,7 @@
  * too much.
  *
  * Priority:
- *   0 - very urgent: shrink everything
+ *   1 - very urgent: shrink everything
  *  ...
  *   6 - base-level: try to shrink a bit.
  */
diff -urN linux/fs/dquot.c linux.mt/fs/dquot.c
--- linux/fs/dquot.c    Thu Nov 22 13:38:31 2001
+++ linux.mt/fs/dquot.c Wed Dec  5 17:07:23 2001
@@ -407,11 +407,30 @@
                head = free_dquots.prev;
        }
 }
+/*
+ * This is called from kswapd when we think we need some
+ * more memory, but aren't really sure how much. So we
+ * carefully try to free a _bit_ of our dqcache, but not
+ * too much.
+ *
+ * Priority:
+ *   1 - very urgent: shrink everything
+ *   ...
+ *   6 - base-level: try to shrink a bit.
+ */

 int shrink_dqcache_memory(int priority, unsigned int gfp_mask)
 {
+       int count = 0;
+
        lock_kernel();
-       prune_dqcache(nr_free_dquots / (priority + 1));
+
+       if (!(gfp_mask & __GFP_FS))
+               return 0;
+
+       count = nr_free_dquots / priority;
+
+       prune_dqcache(count);
        unlock_kernel();
        kmem_cache_shrink(dquot_cachep);
        return 0;
diff -urN linux/fs/inode.c linux.mt/fs/inode.c
--- linux/fs/inode.c    Sat Dec  1 17:21:03 2001
+++ linux.mt/fs/inode.c Wed Dec  5 16:37:25 2001
@@ -707,7 +707,17 @@
        if (goal)
                schedule_task(&unused_inodes_flush_task);
 }
-
+/*
+ * This is called from kswapd when we think we need some
+ * more memory, but aren't really sure how much. So we
+ * carefully try to free a _bit_ of our icache, but not
+ * too much.
+ *
+ * Priority:
+ *   1 - very urgent: shrink everything
+ *  ...
+ *   6 - base-level: try to shrink a bit.
+ */
 int shrink_icache_memory(int priority, int gfp_mask)
 {
        int count = 0;
