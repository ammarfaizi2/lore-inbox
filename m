Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265285AbTBTN1a>; Thu, 20 Feb 2003 08:27:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265320AbTBTN1a>; Thu, 20 Feb 2003 08:27:30 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:19636 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S265285AbTBTN13>; Thu, 20 Feb 2003 08:27:29 -0500
Date: Thu, 20 Feb 2003 13:39:12 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] umount versus iprune
Message-ID: <Pine.LNX.4.44.0302201337110.1623-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When prune_icache coincides with unmounting, invalidate_inodes notices
the inode it's working on as busy but doesn't wait: Self-destruct in 5
seconds message, and later iput oopses on freed super_block.

Neither end is a fast path, so patch below just adds iprune_sem for
exclusion: if you've got a neater solution, great - I shied away from
games with i_state, and extending use of shrinker_sem felt like abuse.

Hugh

--- 2.5.62/fs/inode.c	Mon Feb 10 20:12:50 2003
+++ linux/fs/inode.c	Thu Feb 20 13:01:58 2003
@@ -81,6 +81,11 @@
 spinlock_t inode_lock = SPIN_LOCK_UNLOCKED;
 
 /*
+ * A semaphore to delay invalidate_inodes while prune_icache is busy.
+ */
+static DECLARE_MUTEX(iprune_sem);
+
+/*
  * Statistics gathering..
  */
 struct inodes_stat_t inodes_stat;
@@ -320,12 +325,14 @@
 	int busy;
 	LIST_HEAD(throw_away);
 
+	down(&iprune_sem);
 	spin_lock(&inode_lock);
 	busy = invalidate_list(&inode_in_use, sb, &throw_away);
 	busy |= invalidate_list(&inode_unused, sb, &throw_away);
 	busy |= invalidate_list(&sb->s_dirty, sb, &throw_away);
 	busy |= invalidate_list(&sb->s_io, sb, &throw_away);
 	spin_unlock(&inode_lock);
+	up(&iprune_sem);
 
 	dispose_list(&throw_away);
 
@@ -395,6 +402,7 @@
 	int nr_scanned;
 	unsigned long reap = 0;
 
+	down(&iprune_sem);
 	spin_lock(&inode_lock);
 	for (nr_scanned = 0; nr_scanned < nr_to_scan; nr_scanned++) {
 		struct inode *inode;
@@ -429,6 +437,7 @@
 	}
 	inodes_stat.nr_unused -= nr_pruned;
 	spin_unlock(&inode_lock);
+	up(&iprune_sem);
 	dispose_list(&freeable);
 	if (current_is_kswapd)
 		mod_page_state(kswapd_inodesteal, reap);

