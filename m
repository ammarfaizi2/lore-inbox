Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750892AbWGLIBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbWGLIBw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 04:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbWGLIBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 04:01:52 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:19769 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750866AbWGLIBu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 04:01:50 -0400
Date: Wed, 12 Jul 2006 10:04:38 +0200
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Cc: nickpiggin@yahoo.com.au
Subject: [PATCH 2/7] rbtree: fixed reversed RB_EMPTY_NODE and rb_next/prev
Message-ID: <20060712080437.GC13920@suse.de>
References: <20060712080319.GA13920@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060712080319.GA13920@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] rbtree: fixed reversed RB_EMPTY_NODE and rb_next/prev

The conditions got reserved. Also make rb_next() and rb_prev() check
for the empty condition.

Signed-off-by: Jens Axboe <axboe@suse.de>
---
 block/as-iosched.c     |    4 ++--
 include/linux/rbtree.h |    2 +-
 lib/rbtree.c           |    6 ++++++
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/block/as-iosched.c b/block/as-iosched.c
index 1c44ce3..d677029 100644
--- a/block/as-iosched.c
+++ b/block/as-iosched.c
@@ -336,7 +336,7 @@ static void as_add_arq_rb(struct as_data
 
 static inline void as_del_arq_rb(struct as_data *ad, struct as_rq *arq)
 {
-	if (!RB_EMPTY_NODE(&arq->rb_node)) {
+	if (RB_EMPTY_NODE(&arq->rb_node)) {
 		WARN_ON(1);
 		return;
 	}
@@ -1039,7 +1039,7 @@ static void as_move_to_dispatch(struct a
 	struct request *rq = arq->request;
 	const int data_dir = arq->is_sync;
 
-	BUG_ON(!RB_EMPTY_NODE(&arq->rb_node));
+	BUG_ON(RB_EMPTY_NODE(&arq->rb_node));
 
 	as_antic_stop(ad);
 	ad->antic_status = ANTIC_OFF;
diff --git a/include/linux/rbtree.h b/include/linux/rbtree.h
index 8d5382e..344bc34 100644
--- a/include/linux/rbtree.h
+++ b/include/linux/rbtree.h
@@ -133,7 +133,7 @@ #define RB_ROOT	(struct rb_root) { NULL,
 #define	rb_entry(ptr, type, member) container_of(ptr, type, member)
 
 #define RB_EMPTY_ROOT(root)	((root)->rb_node == NULL)
-#define RB_EMPTY_NODE(node)	(rb_parent(node) != node)
+#define RB_EMPTY_NODE(node)	(rb_parent(node) == node)
 #define RB_CLEAR_NODE(node)	(rb_set_parent(node, node))
 
 extern void rb_insert_color(struct rb_node *, struct rb_root *);
diff --git a/lib/rbtree.c b/lib/rbtree.c
index 1e55ba1..48499c2 100644
--- a/lib/rbtree.c
+++ b/lib/rbtree.c
@@ -322,6 +322,9 @@ struct rb_node *rb_next(struct rb_node *
 {
 	struct rb_node *parent;
 
+	if (rb_parent(node) == node)
+		return NULL;
+
 	/* If we have a right-hand child, go down and then left as far
 	   as we can. */
 	if (node->rb_right) {
@@ -348,6 +351,9 @@ struct rb_node *rb_prev(struct rb_node *
 {
 	struct rb_node *parent;
 
+	if (rb_parent(node) == node)
+		return NULL;
+
 	/* If we have a left-hand child, go down and then right as far
 	   as we can. */
 	if (node->rb_left) {
-- 
1.4.1.ged0e0

-- 
Jens Axboe

