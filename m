Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262261AbVDFQzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262261AbVDFQzA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 12:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbVDFQzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 12:55:00 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:19407 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262257AbVDFQxx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 12:53:53 -0400
Subject: Re: ext3 allocate-with-reservation latencies
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1112781070.1981.34.camel@sisko.sctweedie.blueyonder.co.uk>
References: <1112673094.14322.10.camel@mindpipe>
	 <20050405041359.GA17265@elte.hu>
	 <1112765751.3874.14.camel@localhost.localdomain>
	 <1112781070.1981.34.camel@sisko.sctweedie.blueyonder.co.uk>
Content-Type: text/plain
Organization: IBM LTC
Date: Wed, 06 Apr 2005 09:53:49 -0700
Message-Id: <1112806429.5396.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-04-06 at 10:51 +0100, Stephen C. Tweedie wrote:
> Hi,
> 
> On Wed, 2005-04-06 at 06:35, Mingming Cao wrote:
> 
> > It seems we are holding the rsv_block while searching the bitmap for a
> > free bit.  
> 
> Probably something to avoid!
> 
> > In alloc_new_reservation(), we first find a available to
> > create a reservation window, then we check the bitmap to see if it
> > contains any free block. If not, we will search for next available
> > window, so on and on. During the whole process we are holding the global
> > rsv_lock.  We could, and probably should, avoid that.  Just unlock the
> > rsv_lock before the bitmap search and re-grab it after it.  We need to
> > make sure that the available space that are still available after we re-
> > grab the lock. 
> 
> Not necessarily.  As long as the windows remain mutually exclusive in
> the rbtree, it doesn't matter too much if we occasionally allocate a
> full one --- as long as that case is rare, the worst that happens is
> that we fail to allocate from the window and have to repeat the window
> reserve.
> 
> The difficulty will be in keeping it rare.  What we need to avoid is the
> case where multiple tasks need a new window, they all drop the lock,
> find the same bits free in the bitmap, then all try to take that
> window.  One will succeed, the others will fail; but as the files in
> that bit of the disk continue to grow, we risk those processes
> *continually* repeating the same stomp-on-each-others'-windows operation
> and raising the allocation overhead significantly.
> 

Agreed. That's why the second option is preferred. When a file find a
window open to book, it booked it, then drop the lock and do the bitmap
search. So other files will not attempt to book the same window.

> > Another option is to hold that available window before we release the
> > rsv_lock, and if there is no free bit inside that window, we will remove
> > it from the tree in the next round of searching for next available
> > window.
> 
> Possible, but not necessarily nice.  If you've got a nearly-full disk,
> most bits will be already allocated.  As you scan the bitmaps, it may
> take quite a while to find a free bit; do you really want to (a) lock
> the whole block group with a temporary window just to do the scan, or
> (b) keep allocating multiple smaller windows until you finally find a
> free bit?  The former is bad for concurrency if you have multiple tasks
> trying to allocate nearby on disk --- you'll force them into different
> block groups.  The latter is high overhead.
> 

I am not quite understand what you mean about (a).  In this proposal, we
will drop the lock before the scan. 

And for (b), maybe I did not make myself clear: I am not proposing to
keeping allocating multiple smaller windows until finally find a free
bit. I mean, we book the window(just link the node into the tree) before
we drop the lock, if there is no free bit inside that window, we will go
back search for another window(call find_next_reserveable_window()),
inside it, we will remove the temporary window we just created and find
next window. SO we only have one temporary window at a time. In the case
of we did find a free block inside the temporary created window, we make
it official: do the rb tree coloring rotate stuff then.

Does it make sense? Let me know, thanks,

Maybe I should post my proposed patch here.( I am testing it now. )


---

 linux-2.6.11-ming/fs/ext3/balloc.c |  107 +++++++++++++++++++++++--------------
 1 files changed, 68 insertions(+), 39 deletions(-)

diff -puN fs/ext3/balloc.c~ext3-reduce-reservation-lock-latency fs/ext3/balloc.c
--- linux-2.6.11/fs/ext3/balloc.c~ext3-reduce-reservation-lock-latency	2005-04-05 10:48:31.000000000 -0700
+++ linux-2.6.11-ming/fs/ext3/balloc.c	2005-04-06 09:24:24.203028968 -0700
@@ -241,8 +241,13 @@ void ext3_rsv_window_add(struct super_bl
 			BUG();
 	}
 
+	/*
+	 * we only link the node the the rb tree here
+	 * the real color balancing will be done
+	 * after we confirm the window has some free
+	 * block.
+	 */
 	rb_link_node(node, parent, p);
-	rb_insert_color(node, root);
 }
 
 static void rsv_window_remove(struct super_block *sb,
@@ -749,24 +754,24 @@ fail_access:
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
@@ -782,7 +787,7 @@ static struct ext3_reserve_window_node *
 		 * space with expected-size (or more)...
 		 */
 		if (cur > last_block)
-			return NULL;		/* fail */
+			return -1;		/* fail */
 
 		prev = rsv;
 		next = rb_next(&rsv->rsv_node);
@@ -813,8 +818,29 @@ static struct ext3_reserve_window_node *
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
+	if (rsv)
+		my_rsv->rsv_end = rsv->rsv_start - 1;
+	else
+		my_rsv->rsv_end = last_block;
+	my_rsv->rsv_alloc_hit = 0;
+
+	if (prev != my_rsv)
+		ext3_rsv_window_add(sb, my_rsv);
+
+	return 0;
 }
 
 /**
@@ -852,6 +878,7 @@ static struct ext3_reserve_window_node *
  *	@sb: the super block
  *	@group: the group we are trying to allocate in
  *	@bitmap_bh: the block group block bitmap
+ *
  */
 static int alloc_new_reservation(struct ext3_reserve_window_node *my_rsv,
 		int goal, struct super_block *sb,
@@ -860,10 +887,10 @@ static int alloc_new_reservation(struct 
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
@@ -875,6 +902,8 @@ static int alloc_new_reservation(struct 
 		start_block = goal + group_first_block;
 
 	size = my_rsv->rsv_goal_size;
+
+	spin_lock(rsv_lock);
 	if (!rsv_is_empty(&my_rsv->rsv_window)) {
 		/*
 		 * if the old reservation is cross group boundary
@@ -908,6 +937,7 @@ static int alloc_new_reservation(struct 
 			my_rsv->rsv_goal_size= size;
 		}
 	}
+
 	/*
 	 * shift the search start to the window near the goal block
 	 */
@@ -921,11 +951,11 @@ static int alloc_new_reservation(struct 
 	 * need to check the bitmap after we found a reservable window.
 	 */
 retry:
-	prev_rsv = find_next_reservable_window(search_head, size,
-						&start_block, group_end_block);
-	if (prev_rsv == NULL)
+	ret = find_next_reservable_window(search_head, my_rsv, sb,
+						start_block, group_end_block);
+	if (ret == -1)
 		goto failed;
-	reservable_space_start = start_block;
+
 	/*
 	 * On success, find_next_reservable_window() returns the
 	 * reservation window where there is a reservable space after it.
@@ -937,10 +967,13 @@ retry:
 	 * block. Search start from the start block of the reservable space
 	 * we just found.
 	 */
+	spin_unlock(rsv_lock);
 	first_free_block = bitmap_search_next_usable_block(
-			reservable_space_start - group_first_block,
+			my_rsv->rsv_start - group_first_block,
 			bitmap_bh, group_end_block - group_first_block + 1);
 
+	spin_lock(rsv_lock);
+
 	if (first_free_block < 0) {
 		/*
 		 * no free block left on the bitmap, no point
@@ -948,13 +981,20 @@ retry:
 		 */
 		goto failed;
 	}
+	/*
+	 * it is possible someone else freed the window during we check
+	 * the bitmap
+	 */
+	if (rsv_is_empty(&my_rsv->rsv_window))
+		goto retry;
+
 	start_block = first_free_block + group_first_block;
 	/*
 	 * check if the first free block is within the
 	 * free space we just found
 	 */
-	if ((start_block >= reservable_space_start) &&
-	  (start_block < reservable_space_start + size))
+	if ((start_block >= my_rsv->rsv_start) &&
+		  (start_block < my_rsv->rsv_end))
 		goto found_rsv_window;
 	/*
 	 * if the first free bit we found is out of the reservable space
@@ -963,27 +1003,19 @@ retry:
 	 * start from where the free block is,
 	 * we also shift the list head to where we stopped last time
 	 */
-	search_head = prev_rsv;
+	search_head = my_rsv;
 	goto retry;
 
 found_rsv_window:
 	/*
 	 * great! the reservable space contains some free blocks.
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
+	 */
+	my_rsv->rsv_start = start_block;
+	if ((my_rsv->rsv_end) > (start_block + size -1 ))
+		my_rsv->rsv_end = my_rsv->rsv_start + size - 1;
+
+	rb_insert_color(&my_rsv->rsv_node, fs_rsv_root);
+	spin_unlock(rsv_lock);
 	return 0;		/* succeed */
 failed:
 	/*
@@ -993,6 +1025,7 @@ failed:
 	 */
 	if (!rsv_is_empty(&my_rsv->rsv_window))
 		rsv_window_remove(sb, my_rsv);
+	spin_unlock(rsv_lock);
 	return -1;		/* failed */
 }
 
@@ -1023,7 +1056,6 @@ ext3_try_to_allocate_with_rsv(struct sup
 			int goal, struct ext3_reserve_window_node * my_rsv,
 			int *errp)
 {
-	spinlock_t *rsv_lock;
 	unsigned long group_first_block;
 	int ret = 0;
 	int fatal;
@@ -1052,7 +1084,6 @@ ext3_try_to_allocate_with_rsv(struct sup
 		ret = ext3_try_to_allocate(sb, handle, group, bitmap_bh, goal, NULL);
 		goto out;
 	}
-	rsv_lock = &EXT3_SB(sb)->s_rsv_window_lock;
 	/*
 	 * goal is a group relative block number (if there is a goal)
 	 * 0 < goal < EXT3_BLOCKS_PER_GROUP(sb)
@@ -1085,12 +1116,10 @@ ext3_try_to_allocate_with_rsv(struct sup
 
 		if (rsv_is_empty(&rsv_copy) || (ret < 0) ||
 			!goal_in_my_reservation(&rsv_copy, goal, group, sb)) {
-			spin_lock(rsv_lock);
 			ret = alloc_new_reservation(my_rsv, goal, sb,
 							group, bitmap_bh);
 			rsv_copy._rsv_start = my_rsv->rsv_start;
 			rsv_copy._rsv_end = my_rsv->rsv_end;
-			spin_unlock(rsv_lock);
 			if (ret < 0)
 				break;			/* failed */
 

_


