Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265234AbUIOAVB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265234AbUIOAVB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 20:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264954AbUIOAVB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 20:21:01 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:40344 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S265234AbUIOAUn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 20:20:43 -0400
Subject: [Patch 2/2]: ext3 reservations window allocation fix
From: Mingming Cao <cmm@us.ibm.com>
To: Stephen Tweedie <sct@redhat.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       pbadari@us.ibm.com
In-Reply-To: <200409071302.i87D2bDf030921@sisko.scot.redhat.com>
References: <200409071302.i87D2bDf030921@sisko.scot.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 14 Sep 2004 17:20:36 -0700
Message-Id: <1095207637.1180.22613.camel@w-ming2.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Found that in the current reservation code, if there is a need to
allocate a new window to replace the old window to satisfy the new
allocation goal, no matter where is the allocation goal, the new window
will be allocated _after_ the old window.

So, if the allocation goal block is smaller than the start block of the
old reservation window, the goal block will _not_ be satisfied. This
happens due to we adjusted the goal block to the block next to the end
of the old reservation window, and then start from the old reservation, 
we search for a space to make a new reservation window. This is not our
intention, as we always want to grant the goal block.

Though the bug present with/without recent red-black tree changes, here
is the fix based on red-black tree change: we will do a red-black tree
search from the old reservation window , to locate a window nearest the
allocation goal.

---

 linux-2.6.9-rc1-mm5-ming/fs/ext3/balloc.c |   26 ++++++--------------------
 1 files changed, 6 insertions(+), 20 deletions(-)

diff -puN fs/ext3/balloc.c~ext3_reservation_window_allocation_fix fs/ext3/balloc.c
--- linux-2.6.9-rc1-mm5/fs/ext3/balloc.c~ext3_reservation_window_allocation_fix	2004-09-14 00:35:50.662385224 -0700
+++ linux-2.6.9-rc1-mm5-ming/fs/ext3/balloc.c	2004-09-14 00:35:50.670384008 -0700
@@ -184,10 +184,9 @@ goal_in_my_reservation(struct reserve_wi
  * if the goal is not in any window.
  * Returns NULL if there are no windows or if all windows start after the goal.
  */
-static struct reserve_window_node *search_reserve_window(struct rb_root *root,
+static struct reserve_window_node *search_reserve_window(struct rb_node *n,
 							 unsigned long goal)
 {
-	struct rb_node *n = root->rb_node;
 	struct reserve_window_node *rsv;
 
 	if (!n)
@@ -767,19 +766,11 @@ static struct reserve_window_node *find_
 
 /**
  * 	alloc_new_reservation()--allocate a new reservation window
- *		if there is an existing reservation, discard it first
- *		then allocate the new one from there
- *		otherwise allocate the new reservation from the given
- *		start block, or the beginning of the group, if a goal
- *		is not given.
  *
  *		To make a new reservation, we search part of the filesystem
- *		reservation list (the list that inside the group).
- *
- *		If we have a old reservation, the search goal is the end of
- *		last reservation. If we do not have a old reservation, then we
- *		start from a given goal, or the first block of the group, if
- *		the goal is not given.
+ *		reservation list (the list that inside the group). We try to
+ *		allocate a new reservation window near the allocation goal,
+ *		or the beginning of the group, if there is no goal.
  *
  *		We first find a reservable space after the goal, then from
  *		there, we check the bitmap for the first free block after
@@ -801,8 +792,6 @@ static struct reserve_window_node *find_
  *
  *	@goal: The goal (group-relative).  It is where the search for a
  *		free reservable space should start from.
- *		if we have a old reservation, start_block is the end of
- *		old reservation. Otherwise,
  *		if we have a goal(goal >0 ), then start from there,
  *		no goal(goal = -1), we start from the first block
  *		of the group.
@@ -852,10 +841,7 @@ static int alloc_new_reservation(struct 
 				(my_rsv->rsv_end > group_end_block))
 			return -1;
 
-		/* remember where we are before we discard the old one */
-		if (my_rsv->rsv_end + 1 > start_block)
-			start_block = my_rsv->rsv_end + 1;
-		search_head = my_rsv;
+		search_head = search_reserve_window(&my_rsv->rsv_node, start_block);
 		if ((atomic_read(&my_rsv->rsv_alloc_hit) >
 		     (my_rsv->rsv_end - my_rsv->rsv_start + 1) / 2)) {
 			/*
@@ -875,7 +861,7 @@ static int alloc_new_reservation(struct 
 		 * we set our goal(start_block) and
 		 * the list head for the search
 		 */
-		search_head = search_reserve_window(fs_rsv_root, start_block);
+		search_head = search_reserve_window(fs_rsv_root->rb_node, start_block);
 	}
 
 	/*

_

