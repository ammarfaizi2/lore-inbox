Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319604AbSH3QO7>; Fri, 30 Aug 2002 12:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319606AbSH3QO7>; Fri, 30 Aug 2002 12:14:59 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:62460 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S319604AbSH3QO5>; Fri, 30 Aug 2002 12:14:57 -0400
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] rb_prev and rb_next.
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 30 Aug 2002 17:19:19 +0100
Message-ID: <2559.1030724359@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Functions to find the next or previous item in an rbtree. I accidentally 
violated the coding style of the file by letting a comment slip in; I can 
remove it if that's a problem :)

===== lib/rbtree.c 1.2 vs edited =====
--- 1.2/lib/rbtree.c	Wed Mar 27 13:07:17 2002
+++ edited/lib/rbtree.c	Fri Aug 30 17:13:42 2002
@@ -294,3 +294,43 @@
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
+rb_node_t *rb_prev (rb_node_t *node)
+{
+	if (node->rb_left) {
+		node = node->rb_left;
+		while(node->rb_right)
+			node = node->rb_right;
+		return node;
+	}
+
+	while (node->rb_parent && node == node->rb_parent->rb_left)
+		node = node->rb_parent;
+
+	return node->rb_parent;
+}
+EXPORT_SYMBOL(rb_prev);
===== include/linux/rbtree.h 1.1 vs edited =====
--- 1.1/include/linux/rbtree.h	Tue Feb  5 20:18:53 2002
+++ edited/include/linux/rbtree.h	Fri Aug 30 17:03:06 2002
@@ -120,6 +120,8 @@
 
 extern void rb_insert_color(rb_node_t *, rb_root_t *);
 extern void rb_erase(rb_node_t *, rb_root_t *);
+extern rb_node_t *rb_next(rb_node_t *);
+extern rb_node_t *rb_prev(rb_node_t *);
 
 static inline void rb_link_node(rb_node_t * node, rb_node_t * parent, rb_node_t ** rb_link)
 {

--
dwmw2


