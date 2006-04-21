Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932186AbWDUMsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbWDUMsA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 08:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbWDUMsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 08:48:00 -0400
Received: from canuck.infradead.org ([205.233.218.70]:54445 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S932186AbWDUMr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 08:47:59 -0400
Subject: [PATCH] Shrink rbtree
From: David Woodhouse <dwmw2@infradead.org>
To: akpm@osdl.org
Cc: andrea@suse.de, linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 21 Apr 2006 13:47:43 +0100
Message-Id: <1145623663.11909.139.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Our rbtree implementation uses a whole integer for colour information.
In fact, because of alignment constraints on a 64-bit machine it'll be a
whole 64 bits there. We only need a single bit, though -- and we know
the pointers are always going to be aligned. So let's just use the
lowest bit of the parent pointer instead. This shrinks the rb_node from
4 machine-words to 3.

This doesn't change the documented mode of using rbtrees -- users
weren't encouraged to use the parent pointers directly anyway. But we
add new accessor macros rb_parent(), rb_is_red() etc. and a few places
do need changing to use them.

Some users were just abusing the colour to mark a node as being
off-tree, and I've switched those to use same method for that as
eventpoll.c does -- setting the parent pointer to point to itself.

There's also an obvious optimisation to rb_erase() which jumped out at
me while I was passing.

Full patch below -- individual changes are in a git tree at
git://git.infradead.org/~dwmw2/rbtree-2.6 or viewable by gitweb at
http://git.infradead.org/?p=users/dwmw2/rbtree-2.6.git

    [RBTREE] Merge colour and parent fields of struct rb_node.
    [RBTREE] Remove dead code in rb_erase()
    [RBTREE] Update JFFS2 to use rb_parent() accessor macro.
    [RBTREE] Update eventpoll.c to use rb_parent() accessor macro.
    [RBTREE] Update key.c to use rb_parent() accessor macro.
    [RBTREE] Update ext3 to use rb_parent() accessor macro.
    [RBTREE] Change rbtree off-tree marking in I/O schedulers.
    [RBTREE] Add accessor macros for colour and parent fields of rb_node

Another pair of eyes on the 'remove dead code in rb_erase()' bit in
particular would be appreciated. That's
http://git.infradead.org/?p=users/dwmw2/rbtree-2.6.git;a=commitdiff;h=1975e59375756da4ff4e6e7d12f67485e813ace0

diff --git a/block/as-iosched.c b/block/as-iosched.c
index e25a5d7..ed336ab 100644
--- a/block/as-iosched.c
+++ b/block/as-iosched.c
@@ -353,10 +353,9 @@ static struct request *as_find_arq_hash(
 /*
  * rb tree support functions
  */
-#define RB_NONE		(2)
 #define RB_EMPTY(root)	((root)->rb_node == NULL)
-#define ON_RB(node)	((node)->rb_color != RB_NONE)
-#define RB_CLEAR(node)	((node)->rb_color = RB_NONE)
+#define ON_RB(node)	(rb_parent(node) != node)
+#define RB_CLEAR(node)	(rb_set_parent(node, node))
 #define rb_entry_arq(node)	rb_entry((node), struct as_rq, rb_node)
 #define ARQ_RB_ROOT(ad, arq)	(&(ad)->sort_list[(arq)->is_sync])
 #define rq_rb_key(rq)		(rq)->sector
diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index 2540dfa..01c416b 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -60,14 +60,9 @@ #define RQ_DATA(rq)		(rq)->elevator_priv
 /*
  * rb-tree defines
  */
-#define RB_NONE			(2)
 #define RB_EMPTY(node)		((node)->rb_node == NULL)
-#define RB_CLEAR_COLOR(node)	(node)->rb_color = RB_NONE
 #define RB_CLEAR(node)		do {	\
-	(node)->rb_parent = NULL;	\
-	RB_CLEAR_COLOR((node));		\
-	(node)->rb_right = NULL;	\
-	(node)->rb_left = NULL;		\
+		memset(node, 0, sizeof(*node)); \
 } while (0)
 #define RB_CLEAR_ROOT(root)	((root)->rb_node = NULL)
 #define rb_entry_crq(node)	rb_entry((node), struct cfq_rq, rb_node)
@@ -563,7 +558,6 @@ static inline void cfq_del_crq_rb(struct
 	cfq_update_next_crq(crq);
 
 	rb_erase(&crq->rb_node, &cfqq->sort_list);
-	RB_CLEAR_COLOR(&crq->rb_node);
 
 	if (cfq_cfqq_on_rr(cfqq) && RB_EMPTY(&cfqq->sort_list))
 		cfq_del_cfqq_rr(cfqd, cfqq);
diff --git a/block/deadline-iosched.c b/block/deadline-iosched.c
index 399fa1e..06962d8 100644
--- a/block/deadline-iosched.c
+++ b/block/deadline-iosched.c
@@ -165,10 +165,9 @@ deadline_find_drq_hash(struct deadline_d
 /*
  * rb tree support functions
  */
-#define RB_NONE		(2)
 #define RB_EMPTY(root)	((root)->rb_node == NULL)
-#define ON_RB(node)	((node)->rb_color != RB_NONE)
-#define RB_CLEAR(node)	((node)->rb_color = RB_NONE)
+#define ON_RB(node)	(rb_parent(node) != node)
+#define RB_CLEAR(node)	(rb_set_parent(node, node))
 #define rb_entry_drq(node)	rb_entry((node), struct deadline_rq, rb_node)
 #define DRQ_RB_ROOT(dd, drq)	(&(dd)->sort_list[rq_data_dir((drq)->request)])
 #define rq_rb_key(rq)		(rq)->sector
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 1b4491c..2695337 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -337,20 +337,20 @@ static inline int ep_cmp_ffd(struct epol
 /* Special initialization for the rb-tree node to detect linkage */
 static inline void ep_rb_initnode(struct rb_node *n)
 {
-	n->rb_parent = n;
+	rb_set_parent(n, n);
 }
 
 /* Removes a node from the rb-tree and marks it for a fast is-linked check */
 static inline void ep_rb_erase(struct rb_node *n, struct rb_root *r)
 {
 	rb_erase(n, r);
-	n->rb_parent = n;
+	rb_set_parent(n, n);
 }
 
 /* Fast check to verify that the item is linked to the main rb-tree */
 static inline int ep_rb_linked(struct rb_node *n)
 {
-	return n->rb_parent != n;
+	return rb_parent(n) != n;
 }
 
 /*
diff --git a/fs/ext3/dir.c b/fs/ext3/dir.c
index f37528e..fbb0d4e 100644
--- a/fs/ext3/dir.c
+++ b/fs/ext3/dir.c
@@ -284,7 +284,7 @@ static void free_rb_tree_fname(struct rb
 		 * beginning of the loop and try to free the parent
 		 * node.
 		 */
-		parent = n->rb_parent;
+		parent = rb_parent(n);
 		fname = rb_entry(n, struct fname, rb_hash);
 		while (fname) {
 			struct fname * old = fname;
diff --git a/fs/jffs2/nodelist.h b/fs/jffs2/nodelist.h
index 23a67bb..131b67b 100644
--- a/fs/jffs2/nodelist.h
+++ b/fs/jffs2/nodelist.h
@@ -299,7 +299,6 @@ static inline struct jffs2_node_frag *fr
 	return rb_entry(node, struct jffs2_node_frag, rb);
 }
 
-#define rb_parent(rb) ((rb)->rb_parent)
 #define frag_next(frag) rb_entry(rb_next(&(frag)->rb), struct jffs2_node_frag, rb)
 #define frag_prev(frag) rb_entry(rb_prev(&(frag)->rb), struct jffs2_node_frag, rb)
 #define frag_parent(frag) rb_entry(rb_parent(&(frag)->rb), struct jffs2_node_frag, rb)
diff --git a/fs/jffs2/readinode.c b/fs/jffs2/readinode.c
index f169564..6f4a7d8 100644
--- a/fs/jffs2/readinode.c
+++ b/fs/jffs2/readinode.c
@@ -66,7 +66,7 @@ static void jffs2_free_tmp_dnode_info_li
 			jffs2_free_full_dnode(tn->fn);
 			jffs2_free_tmp_dnode_info(tn);
 
-			this = this->rb_parent;
+			this = rb_parent(this);
 			if (!this)
 				break;
 
@@ -679,12 +679,12 @@ static int jffs2_do_read_inode_internal(
 			jffs2_mark_node_obsolete(c, fn->raw);
 
 		BUG_ON(rb->rb_left);
-		if (rb->rb_parent && rb->rb_parent->rb_left == rb) {
+		if (rb_parent(rb) && rb_parent(rb)->rb_left == rb) {
 			/* We were then left-hand child of our parent. We need
 			 * to move our own right-hand child into our place. */
 			repl_rb = rb->rb_right;
 			if (repl_rb)
-				repl_rb->rb_parent = rb->rb_parent;
+				rb_set_parent(repl_rb, rb_parent(rb));
 		} else
 			repl_rb = NULL;
 
@@ -692,14 +692,14 @@ static int jffs2_do_read_inode_internal(
 
 		/* Remove the spent tn from the tree; don't bother rebalancing
 		 * but put our right-hand child in our own place. */
-		if (tn->rb.rb_parent) {
-			if (tn->rb.rb_parent->rb_left == &tn->rb)
-				tn->rb.rb_parent->rb_left = repl_rb;
-			else if (tn->rb.rb_parent->rb_right == &tn->rb)
-				tn->rb.rb_parent->rb_right = repl_rb;
+		if (rb_parent(&tn->rb)) {
+			if (rb_parent(&tn->rb)->rb_left == &tn->rb)
+				rb_parent(&tn->rb)->rb_left = repl_rb;
+			else if (rb_parent(&tn->rb)->rb_right == &tn->rb)
+				rb_parent(&tn->rb)->rb_right = repl_rb;
 			else BUG();
 		} else if (tn->rb.rb_right)
-			tn->rb.rb_right->rb_parent = NULL;
+			rb_set_parent(tn->rb.rb_right, NULL);
 
 		jffs2_free_tmp_dnode_info(tn);
 		if (ret) {
diff --git a/include/linux/rbtree.h b/include/linux/rbtree.h
index 4b7cc4f..748be50 100644
--- a/include/linux/rbtree.h
+++ b/include/linux/rbtree.h
@@ -99,8 +99,7 @@ #include <linux/stddef.h>
 
 struct rb_node
 {
-	struct rb_node *rb_parent;
-	int rb_color;
+	unsigned long  rb_parent_colour;
 #define	RB_RED		0
 #define	RB_BLACK	1
 	struct rb_node *rb_right;
@@ -112,6 +111,23 @@ struct rb_root
 	struct rb_node *rb_node;
 };
 
+
+#define rb_parent(r)   ((struct rb_node *)((r)->rb_parent_colour & ~3))
+#define rb_colour(r)   ((r)->rb_parent_colour & 1)
+#define rb_is_red(r)   (!rb_colour(r))
+#define rb_is_black(r) rb_colour(r)
+#define rb_set_red(r)  do { (r)->rb_parent_colour &= ~1; } while (0)
+#define rb_set_black(r)  do { (r)->rb_parent_colour |= 1; } while (0)
+
+static inline void rb_set_parent(struct rb_node *rb, struct rb_node *p)
+{
+	rb->rb_parent_colour = (rb->rb_parent_colour & 3) | (unsigned long)p;
+}
+static inline void rb_set_colour(struct rb_node *rb, int colour)
+{
+	rb->rb_parent_colour = (rb->rb_parent_colour & ~1) | colour;
+}
+
 #define RB_ROOT	(struct rb_root) { NULL, }
 #define	rb_entry(ptr, type, member) container_of(ptr, type, member)
 
@@ -131,8 +147,7 @@ extern void rb_replace_node(struct rb_no
 static inline void rb_link_node(struct rb_node * node, struct rb_node * parent,
 				struct rb_node ** rb_link)
 {
-	node->rb_parent = parent;
-	node->rb_color = RB_RED;
+	node->rb_parent_colour = (unsigned long )parent;
 	node->rb_left = node->rb_right = NULL;
 
 	*rb_link = node;
diff --git a/lib/rbtree.c b/lib/rbtree.c
index 14b791a..4a7173c 100644
--- a/lib/rbtree.c
+++ b/lib/rbtree.c
@@ -26,60 +26,66 @@ #include <linux/module.h>
 static void __rb_rotate_left(struct rb_node *node, struct rb_root *root)
 {
 	struct rb_node *right = node->rb_right;
+	struct rb_node *parent = rb_parent(node);
 
 	if ((node->rb_right = right->rb_left))
-		right->rb_left->rb_parent = node;
+		rb_set_parent(right->rb_left, node);
 	right->rb_left = node;
 
-	if ((right->rb_parent = node->rb_parent))
+	rb_set_parent(right, parent);
+
+	if (parent)
 	{
-		if (node == node->rb_parent->rb_left)
-			node->rb_parent->rb_left = right;
+		if (node == parent->rb_left)
+			parent->rb_left = right;
 		else
-			node->rb_parent->rb_right = right;
+			parent->rb_right = right;
 	}
 	else
 		root->rb_node = right;
-	node->rb_parent = right;
+	rb_set_parent(node, right);
 }
 
 static void __rb_rotate_right(struct rb_node *node, struct rb_root *root)
 {
 	struct rb_node *left = node->rb_left;
+	struct rb_node *parent = rb_parent(node);
 
 	if ((node->rb_left = left->rb_right))
-		left->rb_right->rb_parent = node;
+		rb_set_parent(left->rb_right, node);
 	left->rb_right = node;
 
-	if ((left->rb_parent = node->rb_parent))
+	rb_set_parent(left, parent);
+
+	if (parent)
 	{
-		if (node == node->rb_parent->rb_right)
-			node->rb_parent->rb_right = left;
+		if (node == parent->rb_right)
+			parent->rb_right = left;
 		else
-			node->rb_parent->rb_left = left;
+			parent->rb_left = left;
 	}
 	else
 		root->rb_node = left;
-	node->rb_parent = left;
+	rb_set_parent(node, left);
 }
 
 void rb_insert_color(struct rb_node *node, struct rb_root *root)
 {
 	struct rb_node *parent, *gparent;
 
-	while ((parent = node->rb_parent) && parent->rb_color == RB_RED)
+	while ((parent = rb_parent(node)) && rb_is_red(parent))
 	{
-		gparent = parent->rb_parent;
+		gparent = rb_parent(parent);
 
 		if (parent == gparent->rb_left)
 		{
 			{
 				register struct rb_node *uncle = gparent->rb_right;
-				if (uncle && uncle->rb_color == RB_RED)
+				if (uncle && rb_is_red(uncle))
 				{
-					uncle->rb_color = RB_BLACK;
-					parent->rb_color = RB_BLACK;
-					gparent->rb_color = RB_RED;
+					rb_set_black(uncle);
+					rb_set_black(parent);
+					rb_set_red(gparent);
 					node = gparent;
 					continue;
 				}
@@ -94,17 +100,17 @@ void rb_insert_color(struct rb_node *nod
 				node = tmp;
 			}
 
-			parent->rb_color = RB_BLACK;
-			gparent->rb_color = RB_RED;
+			rb_set_black(parent);
+			rb_set_red(gparent);
 			__rb_rotate_right(gparent, root);
 		} else {
 			{
 				register struct rb_node *uncle = gparent->rb_left;
-				if (uncle && uncle->rb_color == RB_RED)
+				if (uncle && rb_is_red(uncle))
 				{
-					uncle->rb_color = RB_BLACK;
-					parent->rb_color = RB_BLACK;
-					gparent->rb_color = RB_RED;
+					rb_set_black(uncle);
+					rb_set_black(parent);
+					rb_set_red(gparent);
 					node = gparent;
 					continue;
 				}
@@ -119,13 +125,13 @@ void rb_insert_color(struct rb_node *nod
 				node = tmp;
 			}
 
-			parent->rb_color = RB_BLACK;
-			gparent->rb_color = RB_RED;
+			rb_set_black(parent);
+			rb_set_red(gparent);
 			__rb_rotate_left(gparent, root);
 		}
 	}
 
-	root->rb_node->rb_color = RB_BLACK;
+	rb_set_black(root->rb_node);
 }
 EXPORT_SYMBOL(rb_insert_color);
 
@@ -134,43 +140,40 @@ static void __rb_erase_color(struct rb_n
 {
 	struct rb_node *other;
 
-	while ((!node || node->rb_color == RB_BLACK) && node != root->rb_node)
+	while ((!node || rb_is_black(node)) && node != root->rb_node)
 	{
 		if (parent->rb_left == node)
 		{
 			other = parent->rb_right;
-			if (other->rb_color == RB_RED)
+			if (rb_is_red(other))
 			{
-				other->rb_color = RB_BLACK;
-				parent->rb_color = RB_RED;
+				rb_set_black(other);
+				rb_set_red(parent);
 				__rb_rotate_left(parent, root);
 				other = parent->rb_right;
 			}
-			if ((!other->rb_left ||
-			     other->rb_left->rb_color == RB_BLACK)
-			    && (!other->rb_right ||
-				other->rb_right->rb_color == RB_BLACK))
+			if ((!other->rb_left || rb_is_black(other->rb_left)) &&
+			    (!other->rb_right || rb_is_black(other->rb_right)))
 			{
-				other->rb_color = RB_RED;
+				rb_set_red(other);
 				node = parent;
-				parent = node->rb_parent;
+				parent = rb_parent(node);
 			}
 			else
 			{
-				if (!other->rb_right ||
-				    other->rb_right->rb_color == RB_BLACK)
+				if (!other->rb_right || rb_is_black(other->rb_right))
 				{
-					register struct rb_node *o_left;
+					struct rb_node *o_left;
 					if ((o_left = other->rb_left))
-						o_left->rb_color = RB_BLACK;
-					other->rb_color = RB_RED;
+						rb_set_black(o_left);
+					rb_set_red(other);
 					__rb_rotate_right(other, root);
 					other = parent->rb_right;
 				}
-				other->rb_color = parent->rb_color;
-				parent->rb_color = RB_BLACK;
+				rb_set_colour(other, rb_colour(parent));
+				rb_set_black(parent);
 				if (other->rb_right)
-					other->rb_right->rb_color = RB_BLACK;
+					rb_set_black(other->rb_right);
 				__rb_rotate_left(parent, root);
 				node = root->rb_node;
 				break;
@@ -179,38 +182,35 @@ static void __rb_erase_color(struct rb_n
 		else
 		{
 			other = parent->rb_left;
-			if (other->rb_color == RB_RED)
+			if (rb_is_red(other))
 			{
-				other->rb_color = RB_BLACK;
-				parent->rb_color = RB_RED;
+				rb_set_black(other);
+				rb_set_red(parent);
 				__rb_rotate_right(parent, root);
 				other = parent->rb_left;
 			}
-			if ((!other->rb_left ||
-			     other->rb_left->rb_color == RB_BLACK)
-			    && (!other->rb_right ||
-				other->rb_right->rb_color == RB_BLACK))
+			if ((!other->rb_left || rb_is_black(other->rb_left)) &&
+			    (!other->rb_right || rb_is_black(other->rb_right)))
 			{
-				other->rb_color = RB_RED;
+				rb_set_red(other);
 				node = parent;
-				parent = node->rb_parent;
+				parent = rb_parent(node);
 			}
 			else
 			{
-				if (!other->rb_left ||
-				    other->rb_left->rb_color == RB_BLACK)
+				if (!other->rb_left || rb_is_black(other->rb_left))
 				{
 					register struct rb_node *o_right;
 					if ((o_right = other->rb_right))
-						o_right->rb_color = RB_BLACK;
-					other->rb_color = RB_RED;
+						rb_set_black(o_right);
+					rb_set_red(other);
 					__rb_rotate_left(other, root);
 					other = parent->rb_left;
 				}
-				other->rb_color = parent->rb_color;
-				parent->rb_color = RB_BLACK;
+				rb_set_colour(other, rb_colour(parent));
+				rb_set_black(parent);
 				if (other->rb_left)
-					other->rb_left->rb_color = RB_BLACK;
+					rb_set_black(other->rb_left);
 				__rb_rotate_right(parent, root);
 				node = root->rb_node;
 				break;
@@ -218,7 +218,7 @@ static void __rb_erase_color(struct rb_n
 		}
 	}
 	if (node)
-		node->rb_color = RB_BLACK;
+		rb_set_black(node);
 }
 
 void rb_erase(struct rb_node *node, struct rb_root *root)
@@ -238,48 +238,41 @@ void rb_erase(struct rb_node *node, stru
 		while ((left = node->rb_left) != NULL)
 			node = left;
 		child = node->rb_right;
-		parent = node->rb_parent;
-		color = node->rb_color;
+		parent = rb_parent(node);
+		color = rb_colour(node);
 
 		if (child)
-			child->rb_parent = parent;
-		if (parent)
-		{
-			if (parent->rb_left == node)
-				parent->rb_left = child;
-			else
-				parent->rb_right = child;
-		}
-		else
-			root->rb_node = child;
-
-		if (node->rb_parent == old)
+			rb_set_parent(child, parent);
+		if (parent == old) {
+			parent->rb_right = child;
 			parent = node;
-		node->rb_parent = old->rb_parent;
-		node->rb_color = old->rb_color;
+		} else
+			parent->rb_left = child;
+
+		node->rb_parent_colour = old->rb_parent_colour;
 		node->rb_right = old->rb_right;
 		node->rb_left = old->rb_left;
 
-		if (old->rb_parent)
+		if (rb_parent(old))
 		{
-			if (old->rb_parent->rb_left == old)
-				old->rb_parent->rb_left = node;
+			if (rb_parent(old)->rb_left == old)
+				rb_parent(old)->rb_left = node;
 			else
-				old->rb_parent->rb_right = node;
+				rb_parent(old)->rb_right = node;
 		} else
 			root->rb_node = node;
 
-		old->rb_left->rb_parent = node;
+		rb_set_parent(old->rb_left, node);
 		if (old->rb_right)
-			old->rb_right->rb_parent = node;
+			rb_set_parent(old->rb_right, node);
 		goto color;
 	}
 
-	parent = node->rb_parent;
-	color = node->rb_color;
+	parent = rb_parent(node);
+	color = rb_colour(node);
 
 	if (child)
-		child->rb_parent = parent;
+		rb_set_parent(child, parent);
 	if (parent)
 	{
 		if (parent->rb_left == node)
@@ -327,6 +320,8 @@ EXPORT_SYMBOL(rb_last);
 
 struct rb_node *rb_next(struct rb_node *node)
 {
+	struct rb_node *parent;
+
 	/* If we have a right-hand child, go down and then left as far
 	   as we can. */
 	if (node->rb_right) {
@@ -342,15 +337,17 @@ struct rb_node *rb_next(struct rb_node *
 	   ancestor is a right-hand child of its parent, keep going
 	   up. First time it's a left-hand child of its parent, said
 	   parent is our 'next' node. */
-	while (node->rb_parent && node == node->rb_parent->rb_right)
-		node = node->rb_parent;
+	while ((parent = rb_parent(node)) && node == parent->rb_right)
+		node = parent;
 
-	return node->rb_parent;
+	return parent;
 }
 EXPORT_SYMBOL(rb_next);
 
 struct rb_node *rb_prev(struct rb_node *node)
 {
+	struct rb_node *parent;
+
 	/* If we have a left-hand child, go down and then right as far
 	   as we can. */
 	if (node->rb_left) {
@@ -362,17 +359,17 @@ struct rb_node *rb_prev(struct rb_node *
 
 	/* No left-hand children. Go up till we find an ancestor which
 	   is a right-hand child of its parent */
-	while (node->rb_parent && node == node->rb_parent->rb_left)
-		node = node->rb_parent;
+	while ((parent = rb_parent(node)) && node == parent->rb_left)
+		node = parent;
 
-	return node->rb_parent;
+	return parent;
 }
 EXPORT_SYMBOL(rb_prev);
 
 void rb_replace_node(struct rb_node *victim, struct rb_node *new,
 		     struct rb_root *root)
 {
-	struct rb_node *parent = victim->rb_parent;
+	struct rb_node *parent = rb_parent(victim);
 
 	/* Set the surrounding nodes to point to the replacement */
 	if (parent) {
@@ -384,9 +381,9 @@ void rb_replace_node(struct rb_node *vic
 		root->rb_node = new;
 	}
 	if (victim->rb_left)
-		victim->rb_left->rb_parent = new;
+		rb_set_parent(victim->rb_left, new);
 	if (victim->rb_right)
-		victim->rb_right->rb_parent = new;
+		rb_set_parent(victim->rb_right, new);
 
 	/* Copy the pointers/colour from the victim to the replacement */
 	*new = *victim;
diff --git a/security/keys/key.c b/security/keys/key.c
index b6061fa..3fdc49c 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -211,12 +211,12 @@ static inline void key_alloc_serial(stru
 			key->serial = 2;
 		key_serial_next = key->serial + 1;
 
-		if (!parent->rb_parent)
+		if (!rb_parent(parent))
 			p = &key_serial_tree.rb_node;
-		else if (parent->rb_parent->rb_left == parent)
-			p = &parent->rb_parent->rb_left;
+		else if (rb_parent(parent)->rb_left == parent)
+			p = &(rb_parent(parent)->rb_left);
 		else
-			p = &parent->rb_parent->rb_right;
+			p = &(rb_parent(parent)->rb_right);
 
 		parent = rb_next(parent);
 		if (!parent)


-- 
dwmw2

