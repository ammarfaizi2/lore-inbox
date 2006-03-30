Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbWC3IWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbWC3IWn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 03:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbWC3IWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 03:22:43 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:24148 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S932104AbWC3IWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 03:22:42 -0500
Date: Thu, 30 Mar 2006 16:22:39 +0800
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Hans Reiser <reiserfs-dev@namesys.com>
Subject: [-mm patch] reiser4fs: use list_move()
Message-ID: <20060330082239.GA11340@miraclelinux.com>
References: <20060330081605.085383000@localhost.localdomain> <20060330081731.538392000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060330081731.538392000@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts the combination of list_del(A) and list_add(A, B)
to list_move(A, B) under fs/reiser4.

CC: Hans Reiser <reiserfs-dev@namesys.com>
Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

 fs/reiser4/flush.c                        |    3 +--
 fs/reiser4/flush_queue.c                  |    3 +--
 fs/reiser4/plugin/item/extent_flush_ops.c |    6 ++----
 fs/reiser4/search.c                       |    9 +++------
 fs/reiser4/txnmgr.c                       |    9 +++------
 5 files changed, 10 insertions(+), 20 deletions(-)

Index: work/fs/reiser4/flush.c
===================================================================
--- work.orig/fs/reiser4/flush.c
+++ work/fs/reiser4/flush.c
@@ -940,8 +940,7 @@ static jnode * find_flush_start_jnode(
 
 		if (JF_ISSET(node, JNODE_WRITEBACK)) {
 			/* move node to the end of atom's writeback list */
-			list_del_init(&node->capture_link);
-			list_add_tail(&node->capture_link, ATOM_WB_LIST(atom));
+			list_move_tail(&node->capture_link, ATOM_WB_LIST(atom));
 
 			/*
 			 * jnode is not necessarily on dirty list: if it was dirtied when
Index: work/fs/reiser4/flush_queue.c
===================================================================
--- work.orig/fs/reiser4/flush_queue.c
+++ work/fs/reiser4/flush_queue.c
@@ -214,8 +214,7 @@ void queue_jnode(flush_queue_t * fq, jno
 	assert("vs-1481", NODE_LIST(node) != FQ_LIST);
 
 	mark_jnode_queued(fq, node);
-	list_del(&node->capture_link);
-	list_add_tail(&node->capture_link, ATOM_FQ_LIST(fq));
+	list_move_tail(&node->capture_link, ATOM_FQ_LIST(fq));
 
 	ON_DEBUG(count_jnode(node->atom, node, NODE_LIST(node),
 			     FQ_LIST, 1));
Index: work/fs/reiser4/plugin/item/extent_flush_ops.c
===================================================================
--- work.orig/fs/reiser4/plugin/item/extent_flush_ops.c
+++ work/fs/reiser4/plugin/item/extent_flush_ops.c
@@ -470,8 +470,7 @@ static void protect_reloc_node(struct li
 	assert_spin_locked(&(node->guard));
 
 	JF_SET(node, JNODE_EPROTECTED);
-	list_del_init(&node->capture_link);
-	list_add_tail(&node->capture_link, jnodes);
+	list_move_tail(&node->capture_link, jnodes);
 	ON_DEBUG(count_jnode(node->atom, node, DIRTY_LIST, PROTECT_LIST, 0));
 }
 
@@ -751,8 +750,7 @@ static void make_node_ovrwr(struct list_
 	assert("zam-918", !JF_ISSET(node, JNODE_OVRWR));
 
 	JF_SET(node, JNODE_OVRWR);
-	list_del_init(&node->capture_link);
-	list_add_tail(&node->capture_link, jnodes);
+	list_move_tail(&node->capture_link, jnodes);
 	ON_DEBUG(count_jnode(node->atom, node, DIRTY_LIST, OVRWR_LIST, 0));
 
 	spin_unlock_jnode(node);
Index: work/fs/reiser4/search.c
===================================================================
--- work.orig/fs/reiser4/search.c
+++ work/fs/reiser4/search.c
@@ -153,8 +153,7 @@ void cbk_cache_invalidate(const znode * 
 	write_lock(&(cache->guard));
 	for (i = 0, slot = cache->slot; i < cache->nr_slots; ++i, ++slot) {
 		if (slot->node == node) {
-			list_del(&slot->lru);
-			list_add_tail(&slot->lru, &cache->lru);
+			list_move_tail(&slot->lru, &cache->lru);
 			slot->node = NULL;
 			break;
 		}
@@ -191,8 +190,7 @@ static void cbk_cache_add(const znode *n
 		slot = list_entry(cache->lru.prev, cbk_cache_slot, lru);
 		slot->node = (znode *) node;
 	}
-	list_del(&slot->lru);
-	list_add(&slot->lru, &cache->lru);
+	list_move(&slot->lru, &cache->lru);
 	write_unlock(&(cache->guard));
 	assert("nikita-2473", cbk_cache_invariant(cache));
 }
@@ -1257,8 +1255,7 @@ static int cbk_cache_scan_slots(cbk_hand
 			if (slot->node == h->active_lh->node /*node */ ) {
 				/* if this node is still in cbk cache---move
 				   its slot to the head of the LRU list. */
-				list_del(&slot->lru);
-				list_add(&slot->lru, &cache->lru);
+				list_move(&slot->lru, &cache->lru);
 			}
 			write_unlock(&(cache->guard));
 		}
Index: work/fs/reiser4/txnmgr.c
===================================================================
--- work.orig/fs/reiser4/txnmgr.c
+++ work/fs/reiser4/txnmgr.c
@@ -981,8 +981,7 @@ static void dispatch_wb_list(txn_atom * 
 				queue_jnode(fq, cur);
 			} else {
 				/* move jnode to atom's clean list */
-				list_del(&cur->capture_link);
-				list_add_tail(&cur->capture_link,
+				list_move_tail(&cur->capture_link,
 					      ATOM_CLEAN_LIST(atom));
 			}
 		}
@@ -2474,8 +2473,7 @@ static void do_jnode_make_dirty(jnode * 
 		assert("nikita-2606", level <= REAL_MAX_ZTREE_HEIGHT);
 
 		/* move node to atom's dirty list */
-		list_del(&node->capture_link);
-		list_add_tail(&node->capture_link, ATOM_DIRTY_LIST(atom, level));
+		list_move_tail(&node->capture_link, ATOM_DIRTY_LIST(atom, level));
 		ON_DEBUG(count_jnode
 			 (atom, node, NODE_LIST(node), DIRTY_LIST, 1));
 		/*
@@ -2748,8 +2746,7 @@ void jnode_make_wander_nolock(jnode * no
 
 	JF_SET(node, JNODE_OVRWR);
 	/* move node to atom's overwrite list */
-	list_del(&node->capture_link);
-	list_add_tail(&node->capture_link, ATOM_OVRWR_LIST(atom));
+	list_move_tail(&node->capture_link, ATOM_OVRWR_LIST(atom));
 	ON_DEBUG(count_jnode(atom, node, DIRTY_LIST, OVRWR_LIST, 1));
 }
 
