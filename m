Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264797AbTBTUFG>; Thu, 20 Feb 2003 15:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262806AbTBTUFG>; Thu, 20 Feb 2003 15:05:06 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:62146 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S264797AbTBTUFE>; Thu, 20 Feb 2003 15:05:04 -0500
Date: Thu, 20 Feb 2003 20:16:48 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] umount versus iprune
In-Reply-To: <Pine.LNX.4.44.0302201925050.2226-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0302202007290.5008-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Feb 2003, Hugh Dickins wrote:
> 
> But that raises the doubt: maybe 2.4 won't get any Self-destruct
> message, but when prune_icache calls dispose_list calls clear_inode
> and destroy_inode, there could be a reference to freed super_block?

Which triggers the realization that my original patch was wrong for
this very reason: 2.5 prune_icache must hold iprune_sem until _after_
its dispose_list, and invalidate_inodes might as well do the same:

--- 2.5.62/fs/inode.c	Mon Feb 10 20:12:50 2003
+++ linux/fs/inode.c	Thu Feb 20 20:13:30 2003
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
@@ -320,6 +325,7 @@
 	int busy;
 	LIST_HEAD(throw_away);
 
+	down(&iprune_sem);
 	spin_lock(&inode_lock);
 	busy = invalidate_list(&inode_in_use, sb, &throw_away);
 	busy |= invalidate_list(&inode_unused, sb, &throw_away);
@@ -328,6 +334,7 @@
 	spin_unlock(&inode_lock);
 
 	dispose_list(&throw_away);
+	up(&iprune_sem);
 
 	return busy;
 }
@@ -395,6 +402,7 @@
 	int nr_scanned;
 	unsigned long reap = 0;
 
+	down(&iprune_sem);
 	spin_lock(&inode_lock);
 	for (nr_scanned = 0; nr_scanned < nr_to_scan; nr_scanned++) {
 		struct inode *inode;
@@ -429,7 +437,10 @@
 	}
 	inodes_stat.nr_unused -= nr_pruned;
 	spin_unlock(&inode_lock);
+
 	dispose_list(&freeable);
+	up(&iprune_sem);
+
 	if (current_is_kswapd)
 		mod_page_state(kswapd_inodesteal, reap);
 	else

