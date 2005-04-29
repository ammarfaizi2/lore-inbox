Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262823AbVD2Qm6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262823AbVD2Qm6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 12:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262829AbVD2Qm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 12:42:58 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:61628 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262823AbVD2QmF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 12:42:05 -0400
Subject: [PATCH] Reduce ext3 allocate-with-reservation lock latencies
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>
In-Reply-To: <1114207837.7339.50.camel@localhost.localdomain>
References: <1112673094.14322.10.camel@mindpipe>
	 <20050405041359.GA17265@elte.hu>
	 <1112765751.3874.14.camel@localhost.localdomain>
	 <20050407081434.GA28008@elte.hu>
	 <1112879303.2859.78.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1112917023.3787.75.camel@dyn318043bld.beaverton.ibm.com>
	 <1112971236.1975.104.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1112983801.10605.32.camel@dyn318043bld.beaverton.ibm.com>
	 <1113220089.2164.52.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1113244710.4413.38.camel@localhost.localdomain>
	 <1113249435.2164.198.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1113288087.4319.49.camel@localhost.localdomain>
	 <1113304715.2404.39.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1113348434.4125.54.camel@dyn318043bld.beaverton.ibm.com>
	 <1113388142.3019.12.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1114207837.7339.50.camel@localhost.localdomain>
Content-Type: text/plain
Organization: IBM LTC
Date: Thu, 28 Apr 2005 23:28:27 -0700
Message-Id: <1114756107.2518.38.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Currently in ext3 block reservation code, the global filesystem
reservation tree lock (rsv_block) is hold during the process of
searching for a space to make a new reservation window, including while
scaning the block bitmap to verify if the avalible window has a free
block. Holding the lock during bitmap scan is unnecessary and could
possibly cause scalability issue and latency issues.

This patch trying to address this by dropping the lock before scan the
bitmap. Before that we need to reserve the open window in case someone
else is targetting at the same window. Question was should we reserve
the whole free reservable space or just the window size we need.
Reserve the whole free reservable space will possibly force other
threads which intended to do block allocation nearby move to another
block group(cause bad layout).  In this patch,  we just reserve the
desired size before drop the lock and scan the block bitmap. This patch
fixed a ext3 reservation latency issue seen on a cvs check out test.
Patch is tested with many fsx, tiobench, dbench and untar a kernel test.

Signed-Off-By: Mingming Cao <cmm@us.ibm.com>




---

 linux-2.6.11-ming/fs/ext3/balloc.c |  135 +++++++++++++++++--------------------
 linux-2.6.11-ming/fs/ext3/file.c   |    4 +
 2 files changed, 68 insertions(+), 71 deletions(-)

diff -puN fs/ext3/balloc.c~ext3-reduce-reservation-lock-latency fs/ext3/balloc.c
--- linux-2.6.11/fs/ext3/balloc.c~ext3-reduce-reservation-lock-latency	2005-04-22 10:49:04.000000000 -0700
+++ linux-2.6.11-ming/fs/ext3/balloc.c	2005-04-27 22:34:19.491331405 -0700
@@ -749,24 +749,24 @@ fail_access:
  * 	to find a free region that is of my size and has not
  * 	been reserved.
  *
- *	on succeed, it returns the reservation window to be appended to.
- *	failed, return NULL.
  */
-static struct ext3_reserve_window_node *find_next_reservable_window(
+static int find_next_reservable_window(
 				struct ext3_reserve_window_node *search_head,
-				unsigned long size, int *start_block,
+				struct ext3_reserve_window_node *my_rsv,
+				struct super_block * sb, int start_block,
 				int last_block)
 {
 	struct rb_node *next;
 	struct ext3_reserve_window_node *rsv, *prev;
 	int cur;
+	int size = my_rsv->rsv_goal_size;
 
 	/* TODO: make the start of the reservation window byte-aligned */
 	/* cur = *start_block & ~7;*/
-	cur = *start_block;
+	cur = start_block;
 	rsv = search_head;
 	if (!rsv)
-		return NULL;
+		return -1;
 
 	while (1) {
 		if (cur <= rsv->rsv_end)
@@ -782,7 +782,7 @@ static struct ext3_reserve_window_node *
 		 * space with expected-size (or more)...
 		 */
 		if (cur > last_block)
-			return NULL;		/* fail */
+			return -1;		/* fail */
 
 		prev = rsv;
 		next = rb_next(&rsv->rsv_node);
@@ -813,8 +813,26 @@ static struct ext3_reserve_window_node *
 	 * return the reservation window that we could append to.
 	 * succeed.
 	 */
-	*start_block = cur;
-	return prev;
+
+	if ((prev != my_rsv) && (!rsv_is_empty(&my_rsv->rsv_window)))
+		rsv_window_remove(sb, my_rsv);
+
+	/* let's book the whole avaliable window for now
+	 * we will check the
+	 * disk bitmap later and then, if there are free block
+	 * then we adjust the window size if the it's
+	 * larger than requested.
+	 * Otherwise, we will remove this node from the tree next time
+	 * call find_next_reservable_window.
+	 */
+	my_rsv->rsv_start = cur;
+	my_rsv->rsv_end = cur + size - 1;
+	my_rsv->rsv_alloc_hit = 0;
+
+	if (prev != my_rsv)
+		ext3_rsv_window_add(sb, my_rsv);
+
+	return 0;
 }
 
 /**
@@ -852,6 +870,7 @@ static struct ext3_reserve_window_node *
  *	@sb: the super block
  *	@group: the group we are trying to allocate in
  *	@bitmap_bh: the block group block bitmap
+ *
  */
 static int alloc_new_reservation(struct ext3_reserve_window_node *my_rsv,
 		int goal, struct super_block *sb,
@@ -860,10 +879,10 @@ static int alloc_new_reservation(struct 
 	struct ext3_reserve_window_node *search_head;
 	int group_first_block, group_end_block, start_block;
 	int first_free_block;
-	int reservable_space_start;
-	struct ext3_reserve_window_node *prev_rsv;
 	struct rb_root *fs_rsv_root = &EXT3_SB(sb)->s_rsv_window_root;
 	unsigned long size;
+	int ret;
+	spinlock_t *rsv_lock = &EXT3_SB(sb)->s_rsv_window_lock;
 
 	group_first_block = le32_to_cpu(EXT3_SB(sb)->s_es->s_first_data_block) +
 				group * EXT3_BLOCKS_PER_GROUP(sb);
@@ -875,6 +894,7 @@ static int alloc_new_reservation(struct 
 		start_block = goal + group_first_block;
 
 	size = my_rsv->rsv_goal_size;
+
 	if (!rsv_is_empty(&my_rsv->rsv_window)) {
 		/*
 		 * if the old reservation is cross group boundary
@@ -908,6 +928,8 @@ static int alloc_new_reservation(struct 
 			my_rsv->rsv_goal_size= size;
 		}
 	}
+
+	spin_lock(rsv_lock);
 	/*
 	 * shift the search start to the window near the goal block
 	 */
@@ -921,11 +943,16 @@ static int alloc_new_reservation(struct 
 	 * need to check the bitmap after we found a reservable window.
 	 */
 retry:
-	prev_rsv = find_next_reservable_window(search_head, size,
-						&start_block, group_end_block);
-	if (prev_rsv == NULL)
-		goto failed;
-	reservable_space_start = start_block;
+	ret = find_next_reservable_window(search_head, my_rsv, sb,
+						start_block, group_end_block);
+
+	if (ret == -1) {
+		if (!rsv_is_empty(&my_rsv->rsv_window))
+			rsv_window_remove(sb, my_rsv);
+		spin_unlock(rsv_lock);
+		return -1;
+	}
+
 	/*
 	 * On success, find_next_reservable_window() returns the
 	 * reservation window where there is a reservable space after it.
@@ -937,8 +964,9 @@ retry:
 	 * block. Search start from the start block of the reservable space
 	 * we just found.
 	 */
+	spin_unlock(rsv_lock);
 	first_free_block = bitmap_search_next_usable_block(
-			reservable_space_start - group_first_block,
+			my_rsv->rsv_start - group_first_block,
 			bitmap_bh, group_end_block - group_first_block + 1);
 
 	if (first_free_block < 0) {
@@ -946,54 +974,30 @@ retry:
 		 * no free block left on the bitmap, no point
 		 * to reserve the space. return failed.
 		 */
-		goto failed;
+		spin_lock(rsv_lock);
+		if (!rsv_is_empty(&my_rsv->rsv_window))
+			rsv_window_remove(sb, my_rsv);
+		spin_unlock(rsv_lock);
+		return -1;		/* failed */
 	}
+
 	start_block = first_free_block + group_first_block;
 	/*
 	 * check if the first free block is within the
-	 * free space we just found
+	 * free space we just reserved
 	 */
-	if ((start_block >= reservable_space_start) &&
-	  (start_block < reservable_space_start + size))
-		goto found_rsv_window;
+	if ((start_block >= my_rsv->rsv_start) &&
+		  (start_block < my_rsv->rsv_end))
+		return 0;		/* succeed */
 	/*
 	 * if the first free bit we found is out of the reservable space
-	 * this means there is no free block on the reservable space
-	 * we should continue search for next reservable space,
+	 * continue search for next reservable space,
 	 * start from where the free block is,
 	 * we also shift the list head to where we stopped last time
 	 */
-	search_head = prev_rsv;
+	search_head = my_rsv;
+	spin_lock(rsv_lock);
 	goto retry;
-
-found_rsv_window:
-	/*
-	 * great! the reservable space contains some free blocks.
-	 * if the search returns that we should add the new
-	 * window just next to where the old window, we don't
- 	 * need to remove the old window first then add it to the
-	 * same place, just update the new start and new end.
-	 */
-	if (my_rsv != prev_rsv)  {
-		if (!rsv_is_empty(&my_rsv->rsv_window))
-			rsv_window_remove(sb, my_rsv);
-	}
-	my_rsv->rsv_start = reservable_space_start;
-	my_rsv->rsv_end = my_rsv->rsv_start + size - 1;
-	my_rsv->rsv_alloc_hit = 0;
-	if (my_rsv != prev_rsv)  {
-		ext3_rsv_window_add(sb, my_rsv);
-	}
-	return 0;		/* succeed */
-failed:
-	/*
-	 * failed to find a new reservation window in the current
-	 * group, remove the current(stale) reservation window
-	 * if there is any
-	 */
-	if (!rsv_is_empty(&my_rsv->rsv_window))
-		rsv_window_remove(sb, my_rsv);
-	return -1;		/* failed */
 }
 
 /*
@@ -1023,7 +1027,6 @@ ext3_try_to_allocate_with_rsv(struct sup
 			int goal, struct ext3_reserve_window_node * my_rsv,
 			int *errp)
 {
-	spinlock_t *rsv_lock;
 	unsigned long group_first_block;
 	int ret = 0;
 	int fatal;
@@ -1052,7 +1055,6 @@ ext3_try_to_allocate_with_rsv(struct sup
 		ret = ext3_try_to_allocate(sb, handle, group, bitmap_bh, goal, NULL);
 		goto out;
 	}
-	rsv_lock = &EXT3_SB(sb)->s_rsv_window_lock;
 	/*
 	 * goal is a group relative block number (if there is a goal)
 	 * 0 < goal < EXT3_BLOCKS_PER_GROUP(sb)
@@ -1078,30 +1080,21 @@ ext3_try_to_allocate_with_rsv(struct sup
 	 * then we could go to allocate from the reservation window directly.
 	 */
 	while (1) {
-		struct ext3_reserve_window rsv_copy;
-
-		rsv_copy._rsv_start = my_rsv->rsv_start;
-		rsv_copy._rsv_end = my_rsv->rsv_end;
-
-		if (rsv_is_empty(&rsv_copy) || (ret < 0) ||
-			!goal_in_my_reservation(&rsv_copy, goal, group, sb)) {
-			spin_lock(rsv_lock);
+		if (rsv_is_empty(&my_rsv->rsv_window) || (ret < 0) ||
+			!goal_in_my_reservation(&my_rsv->rsv_window, goal, group, sb)) {
 			ret = alloc_new_reservation(my_rsv, goal, sb,
 							group, bitmap_bh);
-			rsv_copy._rsv_start = my_rsv->rsv_start;
-			rsv_copy._rsv_end = my_rsv->rsv_end;
-			spin_unlock(rsv_lock);
 			if (ret < 0)
 				break;			/* failed */
 
-			if (!goal_in_my_reservation(&rsv_copy, goal, group, sb))
+			if (!goal_in_my_reservation(&my_rsv->rsv_window, goal, group, sb))
 				goal = -1;
 		}
-		if ((rsv_copy._rsv_start >= group_first_block + EXT3_BLOCKS_PER_GROUP(sb))
-		    || (rsv_copy._rsv_end < group_first_block))
+		if ((my_rsv->rsv_start >= group_first_block + EXT3_BLOCKS_PER_GROUP(sb))
+		    || (my_rsv->rsv_end < group_first_block))
 			BUG();
 		ret = ext3_try_to_allocate(sb, handle, group, bitmap_bh, goal,
-					   &rsv_copy);
+					   &my_rsv->rsv_window);
 		if (ret >= 0) {
 			my_rsv->rsv_alloc_hit++;
 			break;				/* succeed */
diff -puN fs/ext3/file.c~ext3-reduce-reservation-lock-latency fs/ext3/file.c
--- linux-2.6.11/fs/ext3/file.c~ext3-reduce-reservation-lock-latency	2005-04-22 10:49:04.000000000 -0700
+++ linux-2.6.11-ming/fs/ext3/file.c	2005-04-26 11:09:56.000000000 -0700
@@ -36,7 +36,11 @@ static int ext3_release_file (struct ino
 	/* if we are the last writer on the inode, drop the block reservation */
 	if ((filp->f_mode & FMODE_WRITE) &&
 			(atomic_read(&inode->i_writecount) == 1))
+	{
+		down(&EXT3_I(inode)->truncate_sem);
 		ext3_discard_reservation(inode);
+		up(&EXT3_I(inode)->truncate_sem); 
+	}
 	if (is_dx(inode) && filp->private_data)
 		ext3_htree_free_dir_info(filp->private_data);
 

_


