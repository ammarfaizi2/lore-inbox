Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136326AbRD1Cgq>; Fri, 27 Apr 2001 22:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136327AbRD1Cgh>; Fri, 27 Apr 2001 22:36:37 -0400
Received: from tomts6.bellnexxia.net ([209.226.175.26]:23692 "EHLO
	tomts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S136326AbRD1Cg1>; Fri, 27 Apr 2001 22:36:27 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: Atrocious icache/dcache in 2.4.2
Date: Fri, 27 Apr 2001 22:36:20 -0400
X-Mailer: KMail [version 1.2]
Cc: linux-mm@kvack.org, Alexander Viro <viro@math.psu.edu>,
        Pete Zaitcev <zaitcev@redhat.com>
MIME-Version: 1.0
Message-Id: <01042722362000.01922@oscar>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is a patch that prunes unused, clean inodes from the icache
faster.  I have previously checked out cleaning the unused dirty
icache entries from the the same place in kswapd but did not find
it to be much a win.

This code does the following.  It factors prune_icache to use,  
prune_unused_icache to actually prune the list.   This makes it
simple to add a shrink_unused_icache_memory routine which gets
plugged into the kswapd loop.  The result is the icache is kept 
smaller.

fast_prune.diff
-----
--- 2.4.4-pre7/include/linux/dcache.h	Thu Apr 26 12:57:47 2001
+++ linux/include/linux/dcache.h	Fri Apr 27 18:17:20 2001
@@ -176,6 +176,7 @@
 
 /* icache memory management (defined in linux/fs/inode.c) */
 extern void shrink_icache_memory(int, int);
+extern void shrink_unused_icache_memory(int);
 extern void prune_icache(int);
 
 /* only used at mount-time */
--- 2.4.4-pre7/mm/vmscan.c	Fri Apr 27 11:36:04 2001
+++ linux/mm/vmscan.c	Fri Apr 27 18:33:07 2001
@@ -953,6 +953,11 @@
 		 */
 		refill_inactive_scan(DEF_PRIORITY, 0);
 
+		/* 
+		 * Free unused inodes.
+		 */
+		shrink_unused_icache_memory(GFP_KSWAPD);
+
 		/* Once a second, recalculate some VM stats. */
 		if (time_after(jiffies, recalc + HZ)) {
 			recalc = jiffies;
--- 2.4.4-pre7/fs/inode.c	Thu Apr 26 12:49:33 2001
+++ linux/fs/inode.c	Fri Apr 27 18:54:25 2001
@@ -540,16 +540,16 @@
 	 !inode_has_buffers(inode))
 #define INODE(entry)	(list_entry(entry, struct inode, i_list))
 
-void prune_icache(int goal)
+/*
+ * Called with inode lock held, returns with it released.
+ */
+int prune_unused_icache(int goal)
 {
 	LIST_HEAD(list);
 	struct list_head *entry, *freeable = &list;
-	int count = 0, synced = 0;
+	int count = 0;
 	struct inode * inode;
 
-	spin_lock(&inode_lock);
-
-free_unused:
 	entry = inode_unused.prev;
 	while (entry != &inode_unused)
 	{
@@ -577,19 +577,27 @@
 
 	dispose_list(freeable);
 
+	return count;
+}
+
+/*
+ * A goal of zero frees everything
+ */
+void prune_icache(int goal)
+{
+	spin_lock(&inode_lock);
+	goal -= prune_unused_icache(goal);
+
 	/* 
 	 * If we freed enough clean inodes, avoid writing 
-	 * dirty ones. Also giveup if we already tried to
-	 * sync dirty inodes.
+	 * dirty ones.
 	 */
-	if (!goal || synced)
+	if (!goal)
 		return;
 	
-	synced = 1;
-
 	spin_lock(&inode_lock);
 	try_to_sync_unused_inodes();
-	goto free_unused;
+ 	prune_unused_icache(goal);
 }
 
 void shrink_icache_memory(int priority, int gfp_mask)
@@ -611,6 +619,20 @@
 
 	prune_icache(count);
 	kmem_cache_shrink(inode_cachep);
+}
+
+void shrink_unused_icache_memory(int gfp_mask)
+{
+	/*
+	 * Nasty deadlock avoidance..
+	 */
+	if (!(gfp_mask & __GFP_IO))
+		return;
+
+	if (spin_trylock(&inode_lock)) {
+		prune_unused_icache(0);
+		kmem_cache_shrink(inode_cachep);
+	}
 }
 
 /*
-----

Comments?

Ed Tomlinson <tomlins@cam.org>
