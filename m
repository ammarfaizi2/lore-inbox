Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269699AbSIRTWz>; Wed, 18 Sep 2002 15:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269700AbSIRTWz>; Wed, 18 Sep 2002 15:22:55 -0400
Received: from [143.127.3.86] ([143.127.3.86]:4871 "EHLO mtvmime01.veritas.com")
	by vger.kernel.org with ESMTP id <S269699AbSIRTWy>;
	Wed, 18 Sep 2002 15:22:54 -0400
Date: Wed, 18 Sep 2002 20:28:39 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: mm gang: you goofed!
Message-ID: <Pine.LNX.4.44.0209182006530.5607-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've not actually seen truncate_inode_pages' "I goofed!" message
(except when I added further debug to cover lstart != 0 truncation,
which fsx is keen on), but I think it could occur even in that case.

It seems that __lookup() can easily return 0, even though there's
more to find, if it starts partway into a RADIX_TREE_MAP_SIZE
array, in which the only occupied slots are before it starts.

Patch below seems to fix it, but I bet you can improve upon it.

Might this relate to Trond/Chuck's NFS invalidation woes?
It's certainly the main contributor to my tmpfs problems.

I look forward to your "erk" - or will you delight us with
some other exclamation?!

Hugh

--- 2.5.36-mm1/lib/radix-tree.c	Tue Sep 17 11:04:08 2002
+++ linux/lib/radix-tree.c	Wed Sep 18 19:46:10 2002
@@ -231,8 +231,6 @@ __lookup(struct radix_tree_root *root, v
 	unsigned int height = root->height;
 	struct radix_tree_node *slot;
 
-	if (index > max_index)
-		return 0;
 	shift = (height-1) * RADIX_TREE_MAP_SHIFT;
 	slot = root->rnode;
 
@@ -307,9 +305,11 @@ radix_tree_gang_lookup(struct radix_tree
 		unsigned int nr_found;
 		unsigned long next_index;	/* Index of next search */
 
+		if (cur_index > max_index)
+			break;
 		nr_found = __lookup(root, results + ret, cur_index,
 				max_items - ret, &next_index, max_index);
-		if (nr_found == 0)
+		if (nr_found == 0 && !(cur_index & RADIX_TREE_MAP_MASK))
 			break;
 		ret += nr_found;
 		cur_index = next_index;

