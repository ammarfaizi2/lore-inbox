Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261689AbUDEDOj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 23:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbUDEDOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 23:14:39 -0400
Received: from struggle.mr.itd.umich.edu ([141.211.14.79]:56021 "EHLO
	struggle.mr.itd.umich.edu") by vger.kernel.org with ESMTP
	id S261689AbUDEDOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 23:14:35 -0400
Date: Sun, 4 Apr 2004 23:14:25 -0400 (EDT)
From: Rajesh Venkatasubramanian <vrajesh@umich.edu>
X-X-Sender: vrajesh@red.engin.umich.edu
To: Andrea Arcangeli <andrea@suse.de>
cc: akpm@osdl.org, hugh@veritas.com, mbligh@aracnet.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity
 fix
In-Reply-To: <Pine.GSO.4.58.0403252258170.4298@azure.engin.umich.edu>
Message-ID: <Pine.LNX.4.58.0404042311380.19523@red.engin.umich.edu>
References: <Pine.LNX.4.44.0403150527400.28579-100000@localhost.localdomain>
 <Pine.GSO.4.58.0403211634350.10248@azure.engin.umich.edu>
 <20040325225919.GL20019@dualathlon.random> <Pine.GSO.4.58.0403252258170.4298@azure.engin.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch fixes a couple of mask overflow bugs in the prio_tree
search code. These bugs trigger in some very rare corner cases.
The patch also removes a couple of BUG_ONs from the fast paths.

Now the code is well-tested. I have tested all __vma_prio_tree_*
functions in the user-space with as many as 10 million vmas and
all prio_tree functions work fine.

This patch is against 2.6.5-aa2. It will apply on top of Hugh's
patches also.

If you like to test the prio_tree code further in the user-space,
the programs in the following link may help you.

http://www-personal.engin.umich.edu/~vrajesh/linux/prio_tree/user_space/



 mm/prio_tree.c |   46 ++++++++++++++++++++++++++++++----------------
 1 files changed, 30 insertions(+), 16 deletions(-)

diff -puN mm/prio_tree.c~080_prio_tree mm/prio_tree.c
--- mmlinux-2.6/mm/prio_tree.c~080_prio_tree	2004-04-04 22:25:29.000000000 -0400
+++ mmlinux-2.6-jaya/mm/prio_tree.c	2004-04-04 22:25:30.000000000 -0400
@@ -124,10 +124,8 @@ static inline struct prio_tree_node *pri
 		node->parent = old->parent;
 		if (old->parent->left == old)
 			old->parent->left = node;
-		else {
-			BUG_ON(old->parent->right != old);
+		else
 			old->parent->right = node;
-		}
 	}

 	if (!prio_tree_left_empty(old)) {
@@ -271,10 +269,8 @@ void prio_tree_remove(struct prio_tree_r

 	if (cur->parent->right == cur)
 		cur->parent->right = cur->parent;
-	else {
-		BUG_ON(cur->parent->left != cur);
+	else
 		cur->parent->left = cur->parent;
-	}

 	while (cur != node)
 		cur = prio_tree_replace(root, cur->parent, cur);
@@ -308,8 +304,16 @@ static inline struct prio_tree_node *__p
 				iter->size_level++;
 		}
 		else {
-			iter->size_level = 1;
-			iter->mask = 1UL << (root->index_bits - 1);
+			if (iter->size_level) {
+				BUG_ON(!prio_tree_left_empty(iter->cur));
+				BUG_ON(!prio_tree_right_empty(iter->cur));
+				iter->size_level++;
+				iter->mask = ULONG_MAX;
+			}
+			else {
+				iter->size_level = 1;
+				iter->mask = 1UL << (root->index_bits - 1);
+			}
 		}
 		return iter->cur;
 	}
@@ -347,8 +351,16 @@ static inline struct prio_tree_node *__p
 				iter->size_level++;
 		}
 		else {
-			iter->size_level = 1;
-			iter->mask = 1UL << (root->index_bits - 1);
+			if (iter->size_level) {
+				BUG_ON(!prio_tree_left_empty(iter->cur));
+				BUG_ON(!prio_tree_right_empty(iter->cur));
+				iter->size_level++;
+				iter->mask = ULONG_MAX;
+			}
+			else {
+				iter->size_level = 1;
+				iter->mask = 1UL << (root->index_bits - 1);
+			}
 		}
 		return iter->cur;
 	}
@@ -360,13 +372,15 @@ static inline struct prio_tree_node *__p
 	struct prio_tree_iter *iter)
 {
 	iter->cur = iter->cur->parent;
-	iter->mask <<= 1;
-	if (iter->size_level) {
-		if (iter->size_level == 1)
-			iter->mask = 1UL;
+	if (iter->mask == ULONG_MAX)
+		iter->mask = 1UL;
+	else if (iter->size_level == 1)
+		iter->mask = 1UL;
+	else
+		iter->mask <<= 1;
+	if (iter->size_level)
 		iter->size_level--;
-	}
-	else if (iter->value & iter->mask)
+	if (!iter->size_level && (iter->value & iter->mask))
 		iter->value ^= iter->mask;
 	return iter->cur;
 }

_

