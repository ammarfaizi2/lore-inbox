Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132561AbRDWXZn>; Mon, 23 Apr 2001 19:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132537AbRDWXZa>; Mon, 23 Apr 2001 19:25:30 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:2061 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S132574AbRDWXXS>; Mon, 23 Apr 2001 19:23:18 -0400
Date: Mon, 23 Apr 2001 18:43:11 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Move __GFP_IO check in shrink_icache_memory to prune_icache()
Message-ID: <Pine.LNX.4.21.0104231837360.1179-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

With the prune_icache() modifications which were integrated in pre5 there
is no more need to avoid non __GFP_IO allocations to go down to
prune_icache().

The following patch moves the __GFP_IO check down to prune_icache(),
allowing !__GFP_IO allocations to free clean unused inodes.


diff --exclude-from=/home/marcelo/exclude -Nur linux.orig/fs/dquot.c linux/fs/dquot.c
--- linux.orig/fs/dquot.c	Mon Apr 23 19:15:23 2001
+++ linux/fs/dquot.c	Mon Apr 23 19:18:14 2001
@@ -554,7 +554,7 @@
 	if (shrink) {
 		printk(KERN_DEBUG "get_empty_dquot: pruning dcache and icache\n");
 		prune_dcache(128);
-		prune_icache(128);
+		prune_icache(128, GFP_USER);
 		shrink--;
 		goto repeat;
 	}
diff --exclude-from=/home/marcelo/exclude -Nur linux.orig/fs/inode.c linux/fs/inode.c
--- linux.orig/fs/inode.c	Mon Apr 23 19:15:23 2001
+++ linux/fs/inode.c	Mon Apr 23 19:18:04 2001
@@ -540,7 +540,7 @@
 	 !inode_has_buffers(inode))
 #define INODE(entry)	(list_entry(entry, struct inode, i_list))
 
-void prune_icache(int goal)
+void prune_icache(int goal, int gfp_mask)
 {
 	LIST_HEAD(list);
 	struct list_head *entry, *freeable = &list;
@@ -577,6 +577,16 @@
 
 	dispose_list(freeable);
 
+	/*
+	 * Nasty deadlock avoidance..
+	 *
+	 * We may hold various FS locks, and we don't
+	 * want to recurse into the FS that called us
+	 * in clear_inode() and friends..
+	 */
+	if (!(gfp_mask & __GFP_IO))
+		return;
+
 	/* 
 	 * If we freed enough clean inodes, avoid writing 
 	 * dirty ones. Also giveup if we already tried to
@@ -596,20 +606,10 @@
 {
 	int count = 0;
 
-	/*
-	 * Nasty deadlock avoidance..
-	 *
-	 * We may hold various FS locks, and we don't
-	 * want to recurse into the FS that called us
-	 * in clear_inode() and friends..
-	 */
-	if (!(gfp_mask & __GFP_IO))
-		return;
-
 	if (priority)
 		count = inodes_stat.nr_unused / priority;
 
-	prune_icache(count);
+	prune_icache(count, gfp_mask);
 	kmem_cache_shrink(inode_cachep);
 }
 
diff --exclude-from=/home/marcelo/exclude -Nur linux.orig/include/linux/dcache.h linux/include/linux/dcache.h
--- linux.orig/include/linux/dcache.h	Mon Apr 23 19:15:23 2001
+++ linux/include/linux/dcache.h	Mon Apr 23 19:18:31 2001
@@ -176,7 +176,7 @@
 
 /* icache memory management (defined in linux/fs/inode.c) */
 extern void shrink_icache_memory(int, int);
-extern void prune_icache(int);
+extern void prune_icache(int, int);
 
 /* only used at mount-time */
 extern struct dentry * d_alloc_root(struct inode *);


