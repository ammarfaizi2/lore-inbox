Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262493AbUDKVem (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Apr 2004 17:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262508AbUDKVem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Apr 2004 17:34:42 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:2957 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S262493AbUDKVe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Apr 2004 17:34:26 -0400
Subject: rbtree shrinkage
From: David Woodhouse <dwmw2@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: andrea@suse.de, wli@holomorphy.com
Content-Type: text/plain
Message-Id: <1081719260.20197.740.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8.dwmw2.2) 
Date: Sun, 11 Apr 2004 22:34:20 +0100
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We waste space in struct rbtree by using a whole int for colour. This
patch uses the LSB of the 'rb_parent' pointer, because we know it's
always going to be aligned.

We could possibly optimise the code in rbtree.c a little more by trying
to set parent and colour simultaneously, but the compiler shouldn't do
that bad a job as it is.

===== include/linux/rbtree.h 1.4 vs edited =====
--- 1.4/include/linux/rbtree.h	Mon Oct  7 19:39:24 2002
+++ edited/include/linux/rbtree.h	Sun Apr 11 22:07:35 2004
@@ -99,10 +99,9 @@
 
 struct rb_node
 {
-	struct rb_node *rb_parent;
-	int rb_color;
-#define	RB_RED		0
-#define	RB_BLACK	1
+	unsigned long  rb_parent_colour;
+#define RB_RED		0
+#define RB_BLACK	1
 	struct rb_node *rb_right;
 	struct rb_node *rb_left;
 };
@@ -112,7 +111,28 @@
 	struct rb_node *rb_node;
 };
 
+#define rb_parent(node) ((struct rb_node *)((node)->rb_parent_colour & ~1))
+#define rb_colour(node) (((node)->rb_parent_colour & 1))
+
+#define rb_is_black(node) (((node)->rb_parent_colour & 1))
+#define rb_is_red(node) (!rb_is_black(node))
+#define rb_set_red(node) do { (node)->rb_parent_colour &= ~1; } while(0)
+#define rb_set_black(node) do { (node)->rb_parent_colour |= 1; } while(0)
+
+#define rb_set_parent_colour(node, p, c) ((node->rb_parent_colour) = ((unsigned long)p) | c)
+#define rb_set_parent(node, parent) do {				\
+	struct rb_node *__n = (node);					\
+	__n->rb_parent_colour = rb_colour(__n) | (unsigned long)(parent); \
+} while(0)
+#define rb_set_colour(node, colour) do {				\
+	struct rb_node *__n = (node);					\
+	__n->rb_parent_colour = colour | (unsigned long)rb_parent(__n); \
+} while(0)
+
 #define RB_ROOT	(struct rb_root) { NULL, }
+#define ON_RB(node)	((node)->rb_parent_colour != 2)
+#define RB_CLEAR(node)	((node)->rb_parent_colour = 2)
+
 #define	rb_entry(ptr, type, member)					\
 	((type *)((char *)(ptr)-(unsigned long)(&((type *)0)->member)))
 
@@ -131,8 +151,7 @@
 static inline void rb_link_node(struct rb_node * node, struct rb_node * parent,
 				struct rb_node ** rb_link)
 {
-	node->rb_parent = parent;
-	node->rb_color = RB_RED;
+	rb_set_parent_colour(node, parent, RB_RED);
 	node->rb_left = node->rb_right = NULL;
 
 	*rb_link = node;
===== lib/rbtree.c 1.5 vs edited =====
--- 1.5/lib/rbtree.c	Mon Oct  7 19:39:24 2002
+++ edited/lib/rbtree.c	Sun Apr 11 21:17:07 2004
@@ -28,19 +28,21 @@
 	struct rb_node *right = node->rb_right;
 
 	if ((node->rb_right = right->rb_left))
-		right->rb_left->rb_parent = node;
+		rb_set_parent(right->rb_left, node);
 	right->rb_left = node;
 
-	if ((right->rb_parent = node->rb_parent))
+	rb_set_parent(right, rb_parent(node));
+
+	if (rb_parent(node))
 	{
-		if (node == node->rb_parent->rb_left)
-			node->rb_parent->rb_left = right;
+		if (node == rb_parent(node)->rb_left)
+			rb_parent(node)->rb_left = right;
 		else
-			node->rb_parent->rb_right = right;
+			rb_parent(node)->rb_right = right;
 	}
 	else
 		root->rb_node = right;
-	node->rb_parent = right;
+	rb_set_parent(node, right);
 }
 
 static void __rb_rotate_right(struct rb_node *node, struct rb_root *root)
@@ -48,38 +50,39 @@
 	struct rb_node *left = node->rb_left;
 
 	if ((node->rb_left = left->rb_right))
-		left->rb_right->rb_parent = node;
+		rb_set_parent(left->rb_right, node);
 	left->rb_right = node;
 
-	if ((left->rb_parent = node->rb_parent))
+	rb_set_parent(left, rb_parent(node));
+	if (rb_parent(node))
 	{
-		if (node == node->rb_parent->rb_right)
-			node->rb_parent->rb_right = left;
+		if (node == rb_parent(node)->rb_right)
+			rb_parent(node)->rb_right = left;
 		else
-			node->rb_parent->rb_left = left;
+			rb_parent(node)->rb_left = left;
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
@@ -94,17 +97,17 @@
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
@@ -119,13 +122,13 @@
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
 
@@ -134,43 +137,43 @@
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
 			if ((!other->rb_left ||
-			     other->rb_left->rb_color == RB_BLACK)
+			     rb_is_black(other->rb_left))
 			    && (!other->rb_right ||
-				other->rb_right->rb_color == RB_BLACK))
+				rb_is_black(other->rb_right)))
 			{
-				other->rb_color = RB_RED;
+				rb_set_red(other);
 				node = parent;
-				parent = node->rb_parent;
+				parent = rb_parent(node);
 			}
 			else
 			{
 				if (!other->rb_right ||
-				    other->rb_right->rb_color == RB_BLACK)
+				    rb_is_black(other->rb_right))
 				{
 					register struct rb_node *o_left;
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
@@ -179,38 +182,38 @@
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
 			if ((!other->rb_left ||
-			     other->rb_left->rb_color == RB_BLACK)
+			     rb_is_black(other->rb_left))
 			    && (!other->rb_right ||
-				other->rb_right->rb_color == RB_BLACK))
+				rb_is_black(other->rb_right)))
 			{
-				other->rb_color = RB_RED;
+				rb_set_red(other);
 				node = parent;
-				parent = node->rb_parent;
+				parent = rb_parent(node);
 			}
 			else
 			{
 				if (!other->rb_left ||
-				    other->rb_left->rb_color == RB_BLACK)
+				    rb_is_black(other->rb_left))
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
@@ -218,7 +221,7 @@
 		}
 	}
 	if (node)
-		node->rb_color = RB_BLACK;
+		rb_set_black(node);
 }
 
 void rb_erase(struct rb_node *node, struct rb_root *root)
@@ -238,11 +241,11 @@
 		while ((left = node->rb_left))
 			node = left;
 		child = node->rb_right;
-		parent = node->rb_parent;
-		color = node->rb_color;
+		parent = rb_parent(node);
+		color = rb_colour(node);
 
 		if (child)
-			child->rb_parent = parent;
+			rb_set_parent(child, parent);
 		if (parent)
 		{
 			if (parent->rb_left == node)
@@ -253,33 +256,33 @@
 		else
 			root->rb_node = child;
 
-		if (node->rb_parent == old)
+		if (rb_parent(node) == old)
 			parent = node;
-		node->rb_parent = old->rb_parent;
-		node->rb_color = old->rb_color;
+		rb_set_parent(node, rb_parent(old));
+		rb_set_colour(node, rb_colour(old));
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
@@ -329,10 +332,10 @@
 	   ancestor is a right-hand child of its parent, keep going
 	   up. First time it's a left-hand child of its parent, said
 	   parent is our 'next' node. */
-	while (node->rb_parent && node == node->rb_parent->rb_right)
-		node = node->rb_parent;
+	while (rb_parent(node) && node == rb_parent(node)->rb_right)
+		node = rb_parent(node);
 
-	return node->rb_parent;
+	return rb_parent(node);
 }
 EXPORT_SYMBOL(rb_next);
 
@@ -349,17 +352,17 @@
 
 	/* No left-hand children. Go up till we find an ancestor which
 	   is a right-hand child of its parent */
-	while (node->rb_parent && node == node->rb_parent->rb_left)
-		node = node->rb_parent;
+	while (rb_parent(node) && node == rb_parent(node)->rb_left)
+		node = rb_parent(node);
 
-	return node->rb_parent;
+	return rb_parent(node);
 }
 EXPORT_SYMBOL(rb_prev);
 
 void rb_replace_node(struct rb_node *victim, struct rb_node *new,
 		     struct rb_root *root)
 {
-	struct rb_node *parent = victim->rb_parent;
+	struct rb_node *parent = rb_parent(victim);
 
 	/* Set the surrounding nodes to point to the replacement */
 	if (parent) {
@@ -371,9 +374,9 @@
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
===== drivers/block/as-iosched.c 1.35 vs edited =====
--- 1.35/drivers/block/as-iosched.c	Mon Jan 19 06:28:32 2004
+++ edited/drivers/block/as-iosched.c	Sun Apr 11 22:16:21 2004
@@ -326,10 +326,7 @@
 /*
  * rb tree support functions
  */
-#define RB_NONE		(2)
 #define RB_EMPTY(root)	((root)->rb_node == NULL)
-#define ON_RB(node)	((node)->rb_color != RB_NONE)
-#define RB_CLEAR(node)	((node)->rb_color = RB_NONE)
 #define rb_entry_arq(node)	rb_entry((node), struct as_rq, rb_node)
 #define ARQ_RB_ROOT(ad, arq)	(&(ad)->sort_list[(arq)->is_sync])
 #define rq_rb_key(rq)		(rq)->sector
===== drivers/block/deadline-iosched.c 1.28 vs edited =====
--- 1.28/drivers/block/deadline-iosched.c	Wed Oct 22 06:10:19 2003
+++ edited/drivers/block/deadline-iosched.c	Sun Apr 11 22:07:39 2004
@@ -177,10 +177,7 @@
 /*
  * rb tree support functions
  */
-#define RB_NONE		(2)
 #define RB_EMPTY(root)	((root)->rb_node == NULL)
-#define ON_RB(node)	((node)->rb_color != RB_NONE)
-#define RB_CLEAR(node)	((node)->rb_color = RB_NONE)
 #define rb_entry_drq(node)	rb_entry((node), struct deadline_rq, rb_node)
 #define DRQ_RB_ROOT(dd, drq)	(&(dd)->sort_list[rq_data_dir((drq)->request)])
 #define rq_rb_key(rq)		(rq)->sector
===== fs/ext3/dir.c 1.17 vs edited =====
--- 1.17/fs/ext3/dir.c	Fri Mar 12 09:30:20 2004
+++ edited/fs/ext3/dir.c	Sun Apr 11 21:17:07 2004
@@ -287,7 +287,7 @@
 		 * beginning of the loop and try to free the parent
 		 * node.
 		 */
-		parent = n->rb_parent;
+		parent = rb_parent(n);
 		fname = rb_entry(n, struct fname, rb_hash);
 		while (fname) {
 			struct fname * old = fname;
===== fs/jffs2/nodelist.h 1.10 vs edited =====
--- 1.10/fs/jffs2/nodelist.h	Sat Oct 11 15:47:54 2003
+++ edited/fs/jffs2/nodelist.h	Sun Apr 11 21:17:07 2004
@@ -300,7 +300,6 @@
 		node = node->rb_left;
 	return rb_entry(node, struct jffs2_node_frag, rb);
 }
-#define rb_parent(rb) ((rb)->rb_parent)
 #define frag_next(frag) rb_entry(rb_next(&(frag)->rb), struct jffs2_node_frag, rb)
 #define frag_prev(frag) rb_entry(rb_prev(&(frag)->rb), struct jffs2_node_frag, rb)
 #define frag_parent(frag) rb_entry(rb_parent(&(frag)->rb), struct jffs2_node_frag, rb)
===== net/sched/sch_htb.c 1.22 vs edited =====
--- 1.22/net/sched/sch_htb.c	Mon Mar 22 06:51:20 2004
+++ edited/net/sched/sch_htb.c	Sun Apr 11 21:17:07 2004
@@ -71,7 +71,7 @@
 
 #define HTB_HSIZE 16	/* classid hash size */
 #define HTB_EWMAC 2	/* rate average over HTB_EWMAC*HTB_HSIZE sec */
-#define HTB_DEBUG 1	/* compile debugging support (activated by tc tool) */
+//#define HTB_DEBUG 1	/* compile debugging support (activated by tc tool) */
 #define HTB_RATECM 1    /* whether to use rate computer */
 #define HTB_HYSTERESIS 1/* whether to use mode hysteresis for speedup */
 #define HTB_QLOCK(S) spin_lock_bh(&(S)->dev->queue_lock)


-- 
dwmw2


