Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284785AbRLEWrs>; Wed, 5 Dec 2001 17:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284789AbRLEWrk>; Wed, 5 Dec 2001 17:47:40 -0500
Received: from nat.transgeek.com ([66.92.79.28]:45821 "HELO smtp.transgeek.com")
	by vger.kernel.org with SMTP id <S284788AbRLEWrX>;
	Wed, 5 Dec 2001 17:47:23 -0500
Content-Type: text/plain; charset=US-ASCII
From: Craig Christophel <merlin@transgeek.com>
To: linux-kernel@vger.kernel.org
Subject: Re: shrink_caches inconsistancy
Date: Wed, 5 Dec 2001 17:49:12 -0500
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011205184445.3E4B6C7382@smtp.transgeek.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


locking issue with return 0; inside the lock/unlock_kernel calls.  previous 
patch is crap.  use this one instead.


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
+++ linux.mt/fs/dquot.c Wed Dec  5 17:46:29 2001
@@ -407,11 +407,31 @@
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
+
+       if (!(gfp_mask & __GFP_FS))
+               return 0;
+
        lock_kernel();
-       prune_dqcache(nr_free_dquots / (priority + 1));
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
