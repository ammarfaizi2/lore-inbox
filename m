Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315458AbSILNOh>; Thu, 12 Sep 2002 09:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315472AbSILNOh>; Thu, 12 Sep 2002 09:14:37 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:59642 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S315458AbSILNOf>; Thu, 12 Sep 2002 09:14:35 -0400
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [RESEND] Red Black Tree cleanups [1/2]
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 12 Sep 2002 14:19:23 +0100
Message-ID: <25148.1031836763@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the first of two rbtree patches which can be pulled from
	master.kernel.org:/home/dwmw2/BK/rbtree-2.5

This adds three new rbtree functions. rb_next() and rb_prev() are used for 
traversing a tree, and rb_replace_node() is for replacing a single node 
without having to erase, rebalance, insert the replacement and rebalance 
again.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.621   -> 1.622  
#	        lib/rbtree.c	1.2     -> 1.3    
#	include/linux/rbtree.h	1.1     -> 1.2    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/09	dwmw2@infradead.org	1.622
# Add three functions for rbtree manipulation -- rb_next(), rb_prev() and rb_replace_node()
#     
# rb_next() and rb_prev() return the next and previous nodes in the tree, respectively.
# 
# rb_replace_node() allows fast replacement of a single node without having to remove the 
# victim, rebalance the tree, insert the replacement and then rebalance again to the original
# topology.
# --------------------------------------------
#
diff -Nru a/include/linux/rbtree.h b/include/linux/rbtree.h
--- a/include/linux/rbtree.h	Thu Sep 12 13:49:39 2002
+++ b/include/linux/rbtree.h	Thu Sep 12 13:49:39 2002
@@ -121,6 +121,13 @@
 extern void rb_insert_color(rb_node_t *, rb_root_t *);
 extern void rb_erase(rb_node_t *, rb_root_t *);
 
+/* Find logical next and previous nodes in a tree */
+extern rb_node_t *rb_next(rb_node_t *);
+extern rb_node_t *rb_prev(rb_node_t *);
+
+/* Fast replacement of a single node without remove/rebalance/add/rebalance */
+extern void rb_replace_node(rb_node_t *victim, rb_node_t *new, rb_root_t *root);
+
 static inline void rb_link_node(rb_node_t * node, rb_node_t * parent, rb_node_t ** rb_link)
 {
 	node->rb_parent = parent;
diff -Nru a/lib/rbtree.c b/lib/rbtree.c
--- a/lib/rbtree.c	Thu Sep 12 13:49:39 2002
+++ b/lib/rbtree.c	Thu Sep 12 13:49:39 2002
@@ -1,6 +1,7 @@
 /*
   Red Black Trees
   (C) 1999  Andrea Arcangeli <andrea@suse.de>
+  (C) 2002  David Woodhouse <dwmw2@infradead.org>
   
   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
@@ -294,3 +295,70 @@
 		__rb_erase_color(child, parent, root);
 }
 EXPORT_SYMBOL(rb_erase);
+
+rb_node_t *rb_next(rb_node_t *node)
+{
+	/* If we have a right-hand child, go down and then left as far
+	   as we can. */
+	if (node->rb_right) {
+		node = node->rb_right; 
+		while (node->rb_left)
+			node=node->rb_left;
+		return node;
+	}
+
+	/* No right-hand children.  Everything down and left is
+	   smaller than us, so any 'next' node must be in the general
+	   direction of our parent. Go up the tree; any time the
+	   ancestor is a right-hand child of its parent, keep going
+	   up. First time it's a left-hand child of its parent, said
+	   parent is our 'next' node. */
+	while (node->rb_parent && node == node->rb_parent->rb_right)
+		node = node->rb_parent;
+
+	return node->rb_parent;
+}
+EXPORT_SYMBOL(rb_next);
+
+rb_node_t *rb_prev(rb_node_t *node)
+{
+	/* If we have a left-hand child, go down and then right as far
+	   as we can. */
+	if (node->rb_left) {
+		node = node->rb_left; 
+		while (node->rb_right)
+			node=node->rb_right;
+		return node;
+	}
+
+	/* No left-hand children. Go up till we find an ancestor which
+	   is a right-hand child of its parent */
+	while (node->rb_parent && node == node->rb_parent->rb_left)
+		node = node->rb_parent;
+
+	return node->rb_parent;
+}
+EXPORT_SYMBOL(rb_prev);
+
+void rb_replace_node(rb_node_t *victim, rb_node_t *new, rb_root_t *root)
+{
+	rb_node_t *parent = victim->rb_parent;
+
+	/* Set the surrounding nodes to point to the replacement */
+	if (parent) {
+		if (victim == parent->rb_left)
+			parent->rb_left = new;
+		else
+			parent->rb_right = new;
+	} else {
+		root->rb_node = new;
+	}
+	if (victim->rb_left)
+		victim->rb_left->rb_parent = new;
+	if (victim->rb_right)
+		victim->rb_right->rb_parent = new;
+
+	/* Copy the pointers/colour from the victim to the replacement */
+	*new = *victim;
+}
+EXPORT_SYMBOL(rb_replace_node);


--
dwmw2


