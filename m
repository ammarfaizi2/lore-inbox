Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281890AbRLFPK4>; Thu, 6 Dec 2001 10:10:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282242AbRLFPKR>; Thu, 6 Dec 2001 10:10:17 -0500
Received: from nat.transgeek.com ([66.92.79.28]:61679 "HELO smtp.transgeek.com")
	by vger.kernel.org with SMTP id <S281890AbRLFPJ6>;
	Thu, 6 Dec 2001 10:09:58 -0500
Content-Type: text/plain; charset=US-ASCII
From: Craig Christophel <merlin@transgeek.com>
To: Jan Kara <jack@suse.cz>
Subject: Re: shrink_caches inconsistancy
Date: Thu, 6 Dec 2001 10:11:45 -0500
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011205180526.DCB78C7382@smtp.transgeek.com> <20011206121615.A21816@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20011206121615.A21816@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011206110726.D601FC7382@smtp.transgeek.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well here is the fixed patch with __GFP_FS check removed from dqcache.  
Thanks for the note.

Craig


> > 	Possibly incorrect __GFP_FS check added to the dqcache function.  but
> > again consistancy is my goal.
>
>   This check really isn't needed for shrink_dqcache() function. This
> function can never recurse into fs so there's no need to have __GFP_FS set.


diff -urN linux/fs/dcache.c linux.mt/fs/dcache.c
--- linux/fs/dcache.c   Wed Dec  5 18:22:42 2001
+++ linux.mt/fs/dcache.c        Wed Dec  5 18:22:26 2001
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
--- linux/fs/dquot.c    Wed Dec  5 18:22:42 2001
+++ linux.mt/fs/dquot.c Thu Dec  6 10:09:24 2001
@@ -407,11 +407,28 @@
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
--- linux/fs/inode.c    Wed Dec  5 18:22:42 2001
+++ linux.mt/fs/inode.c Wed Dec  5 18:22:26 2001
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


