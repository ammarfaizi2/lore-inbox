Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S156284AbPK2QNh>; Mon, 29 Nov 1999 11:13:37 -0500
Received: by vger.rutgers.edu id <S156231AbPK2QN1>; Mon, 29 Nov 1999 11:13:27 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:17177 "EHLO penguin.e-mind.com") by vger.rutgers.edu with ESMTP id <S156204AbPK2QNS>; Mon, 29 Nov 1999 11:13:18 -0500
Date: Mon, 29 Nov 1999 16:54:01 +0100 (CET)
From: Andrea Arcangeli <andrea@suse.de>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: "Kevin O'Connor" <koconnor@cse.Buffalo.EDU>, linux-mm@kvack.org, linux-kernel@vger.rutgers.edu, Marc Lehmann <pcg@opengroup.org>, Linus Torvalds <torvalds@transmeta.com>
Subject: [patch] rbtrees [was Re: AVL trees vs. Red-Black trees]
In-Reply-To: <Pine.LNX.4.10.9911272326150.29377-100000@waste.org>
Message-ID: <Pine.LNX.4.10.9911291649470.5133-100000@alpha.random>
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

On Sat, 27 Nov 1999, Oliver Xymoron wrote:

>I'd like to take a look at this, I've been looking at putting some more
>uniform tree structures in the kernel (post 2.4).

This patch will add btree support to linux. I extracted it from my old
patches. I think it could be added also in the stock kernel so if somebody
needs rbtrees, he won't have to reinvent the wheel each time ;). The patch
is against 2.3.30pre3.

diff -urN 2.3.30pre3/include/linux/rbtree.h 2.3.30pre3-rbtree/include/linux/rbtree.h
--- 2.3.30pre3/include/linux/rbtree.h	Thu Jan  1 01:00:00 1970
+++ 2.3.30pre3-rbtree/include/linux/rbtree.h	Mon Nov 29 16:33:26 1999
@@ -0,0 +1,128 @@
+/*
+  Red Black Trees
+  (C) 1999  Andrea Arcangeli <andrea@suse.de>
+  
+  This program is free software; you can redistribute it and/or modify
+  it under the terms of the GNU General Public License as published by
+  the Free Software Foundation; either version 2 of the License, or
+  (at your option) any later version.
+
+  This program is distributed in the hope that it will be useful,
+  but WITHOUT ANY WARRANTY; without even the implied warranty of
+  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+  GNU General Public License for more details.
+
+  You should have received a copy of the GNU General Public License
+  along with this program; if not, write to the Free Software
+  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+
+  linux/include/linux/rbtree.h
+
+  To use rbtrees you'll have to implement your own insert and search cores.
+  This will avoid us to use callbacks and to drop drammatically performances.
+  I know it's not the cleaner way,  but in C (not in C++) to get
+  performances and genericity...
+
+  Some example of insert and search follows here. The search is a plain
+  normal search over an ordered tree. The insert instead must be implemented
+  int two steps: as first thing the code must insert the element in
+  order as a red leaf in the tree, then the support library function
+  rb_insert_color() must be called. Such function will do the
+  not trivial work to rebalance the rbtree if necessary.
+
+-----------------------------------------------------------------------
+static inline struct page * rb_search_page_cache(struct inode * inode,
+						 unsigned long offset)
+{
+	rb_node_t * n = inode->i_rb_page_cache.rb_node;
+	struct page * page;
+
+	while (n)
+	{
+		page = rb_entry(n, struct page, rb_page_cache);
+
+		if (offset < page->offset)
+			n = n->rb_left;
+		else if (offset > page->offset)
+			n = n->rb_right;
+		else
+			return page;
+	}
+	return NULL;
+}
+
+static inline struct page * __rb_insert_page_cache(struct inode * inode,
+						   unsigned long offset,
+						   rb_node_t * node)
+{
+	rb_node_t ** p = &inode->i_rb_page_cache.rb_node;
+	rb_node_t * parent = NULL;
+	struct page * page;
+
+	while (*p)
+	{
+		parent = *p;
+		page = rb_entry(parent, struct page, rb_page_cache);
+
+		if (offset < page->offset)
+			p = &(*p)->rb_left;
+		else if (offset > page->offset)
+			p = &(*p)->rb_right;
+		else
+			return page;
+	}
+
+	node->rb_parent = parent;
+	node->rb_color = RB_RED;
+	node->rb_left = node->rb_right = NULL;
+
+	*p = node;
+
+	return NULL;
+}
+
+static inline struct page * rb_insert_page_cache(struct inode * inode,
+						 unsigned long offset,
+						 rb_node_t * node)
+{
+	struct page * ret;
+	if ((ret = __rb_insert_page_cache(inode, offset, node)))
+		goto out;
+	rb_insert_color(node, &inode->i_rb_page_cache);
+ out:
+	return ret;
+}
+-----------------------------------------------------------------------
+*/
+
+#ifndef	_LINUX_RBTREE_H
+#define	_LINUX_RBTREE_H
+
+#include <linux/kernel.h>
+#include <linux/stddef.h>
+
+typedef struct rb_node_s
+{
+	struct rb_node_s * rb_parent;
+	int rb_color;
+#define	RB_RED		0
+#define	RB_BLACK	1
+	struct rb_node_s * rb_right;
+	struct rb_node_s * rb_left;
+}
+rb_node_t;
+
+typedef struct rb_root_s
+{
+	struct rb_node_s * rb_node;
+}
+rb_root_t;
+
+#define RB_ROOT	(rb_root_t) { NULL, }
+#define	rb_entry(ptr, type, member)					\
+	((type *)((char *)(ptr)-(unsigned long)(&((type *)0)->member)))
+
+extern void rb_insert_color(rb_node_t *, rb_root_t *);
+extern void rb_erase(rb_node_t *, rb_root_t *);
+
+#endif	/* _LINUX_RBTREE_H */
diff -urN 2.3.30pre3/lib/Makefile 2.3.30pre3-rbtree/lib/Makefile
--- 2.3.30pre3/lib/Makefile	Mon Jan 18 02:27:00 1999
+++ 2.3.30pre3-rbtree/lib/Makefile	Mon Nov 29 16:22:36 1999
@@ -7,6 +7,6 @@
 #
 
 L_TARGET := lib.a
-L_OBJS   := errno.o ctype.o string.o vsprintf.o
+L_OBJS   := errno.o ctype.o string.o vsprintf.o rbtree.o
 
 include $(TOPDIR)/Rules.make
diff -urN 2.3.30pre3/lib/rbtree.c 2.3.30pre3-rbtree/lib/rbtree.c
--- 2.3.30pre3/lib/rbtree.c	Thu Jan  1 01:00:00 1970
+++ 2.3.30pre3-rbtree/lib/rbtree.c	Mon Nov 29 16:31:37 1999
@@ -0,0 +1,293 @@
+/*
+  Red Black Trees
+  (C) 1999  Andrea Arcangeli <andrea@suse.de>
+  
+  This program is free software; you can redistribute it and/or modify
+  it under the terms of the GNU General Public License as published by
+  the Free Software Foundation; either version 2 of the License, or
+  (at your option) any later version.
+
+  This program is distributed in the hope that it will be useful,
+  but WITHOUT ANY WARRANTY; without even the implied warranty of
+  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+  GNU General Public License for more details.
+
+  You should have received a copy of the GNU General Public License
+  along with this program; if not, write to the Free Software
+  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+
+  linux/lib/rbtree.c
+*/
+
+#include <linux/rbtree.h>
+
+static void __rb_rotate_left(rb_node_t * node, rb_root_t * root)
+{
+	rb_node_t * right = node->rb_right;
+
+	if ((node->rb_right = right->rb_left))
+		right->rb_left->rb_parent = node;
+	right->rb_left = node;
+
+	if ((right->rb_parent = node->rb_parent))
+	{
+		if (node == node->rb_parent->rb_left)
+			node->rb_parent->rb_left = right;
+		else
+			node->rb_parent->rb_right = right;
+	}
+	else
+		root->rb_node = right;
+	node->rb_parent = right;
+}
+
+static void __rb_rotate_right(rb_node_t * node, rb_root_t * root)
+{
+	rb_node_t * left = node->rb_left;
+
+	if ((node->rb_left = left->rb_right))
+		left->rb_right->rb_parent = node;
+	left->rb_right = node;
+
+	if ((left->rb_parent = node->rb_parent))
+	{
+		if (node == node->rb_parent->rb_right)
+			node->rb_parent->rb_right = left;
+		else
+			node->rb_parent->rb_left = left;
+	}
+	else
+		root->rb_node = left;
+	node->rb_parent = left;
+}
+
+void rb_insert_color(rb_node_t * node, rb_root_t * root)
+{
+	rb_node_t * parent, * gparent;
+
+	while ((parent = node->rb_parent) && parent->rb_color == RB_RED)
+	{
+		gparent = parent->rb_parent;
+
+		if (parent == gparent->rb_left)
+		{
+			{
+				register rb_node_t * uncle = gparent->rb_right;
+				if (uncle && uncle->rb_color == RB_RED)
+				{
+					uncle->rb_color = RB_BLACK;
+					parent->rb_color = RB_BLACK;
+					gparent->rb_color = RB_RED;
+					node = gparent;
+					continue;
+				}
+			}
+
+			if (parent->rb_right == node)
+			{
+				register rb_node_t * tmp;
+				__rb_rotate_left(parent, root);
+				tmp = parent;
+				parent = node;
+				node = tmp;
+			}
+
+			parent->rb_color = RB_BLACK;
+			gparent->rb_color = RB_RED;
+			__rb_rotate_right(gparent, root);
+		} else {
+			{
+				register rb_node_t * uncle = gparent->rb_left;
+				if (uncle && uncle->rb_color == RB_RED)
+				{
+					uncle->rb_color = RB_BLACK;
+					parent->rb_color = RB_BLACK;
+					gparent->rb_color = RB_RED;
+					node = gparent;
+					continue;
+				}
+			}
+
+			if (parent->rb_left == node)
+			{
+				register rb_node_t * tmp;
+				__rb_rotate_right(parent, root);
+				tmp = parent;
+				parent = node;
+				node = tmp;
+			}
+
+			parent->rb_color = RB_BLACK;
+			gparent->rb_color = RB_RED;
+			__rb_rotate_left(gparent, root);
+		}
+	}
+
+	root->rb_node->rb_color = RB_BLACK;
+}
+
+static void __rb_erase_color(rb_node_t * node, rb_node_t * parent,
+			     rb_root_t * root)
+{
+	rb_node_t * other;
+
+	while ((!node || node->rb_color == RB_BLACK) && node != root->rb_node)
+	{
+		if (parent->rb_left == node)
+		{
+			other = parent->rb_right;
+			if (other->rb_color == RB_RED)
+			{
+				other->rb_color = RB_BLACK;
+				parent->rb_color = RB_RED;
+				__rb_rotate_left(parent, root);
+				other = parent->rb_right;
+			}
+			if ((!other->rb_left ||
+			     other->rb_left->rb_color == RB_BLACK)
+			    && (!other->rb_right ||
+				other->rb_right->rb_color == RB_BLACK))
+			{
+				other->rb_color = RB_RED;
+				node = parent;
+				parent = node->rb_parent;
+			}
+			else
+			{
+				if (!other->rb_right ||
+				    other->rb_right->rb_color == RB_BLACK)
+				{
+					register rb_node_t * o_left;
+					if ((o_left = other->rb_left))
+						o_left->rb_color = RB_BLACK;
+					other->rb_color = RB_RED;
+					__rb_rotate_right(other, root);
+					other = parent->rb_right;
+				}
+				other->rb_color = parent->rb_color;
+				parent->rb_color = RB_BLACK;
+				if (other->rb_right)
+					other->rb_right->rb_color = RB_BLACK;
+				__rb_rotate_left(parent, root);
+				node = root->rb_node;
+				break;
+			}
+		}
+		else
+		{
+			other = parent->rb_left;
+			if (other->rb_color == RB_RED)
+			{
+				other->rb_color = RB_BLACK;
+				parent->rb_color = RB_RED;
+				__rb_rotate_right(parent, root);
+				other = parent->rb_left;
+			}
+			if ((!other->rb_left ||
+			     other->rb_left->rb_color == RB_BLACK)
+			    && (!other->rb_right ||
+				other->rb_right->rb_color == RB_BLACK))
+			{
+				other->rb_color = RB_RED;
+				node = parent;
+				parent = node->rb_parent;
+			}
+			else
+			{
+				if (!other->rb_left ||
+				    other->rb_left->rb_color == RB_BLACK)
+				{
+					register rb_node_t * o_right;
+					if ((o_right = other->rb_right))
+						o_right->rb_color = RB_BLACK;
+					other->rb_color = RB_RED;
+					__rb_rotate_left(other, root);
+					other = parent->rb_left;
+				}
+				other->rb_color = parent->rb_color;
+				parent->rb_color = RB_BLACK;
+				if (other->rb_left)
+					other->rb_left->rb_color = RB_BLACK;
+				__rb_rotate_right(parent, root);
+				node = root->rb_node;
+				break;
+			}
+		}
+	}
+	if (node)
+		node->rb_color = RB_BLACK;
+}
+
+void rb_erase(rb_node_t * node, rb_root_t * root)
+{
+	rb_node_t * child, * parent;
+	int color;
+
+	if (!node->rb_left)
+		child = node->rb_right;
+	else if (!node->rb_right)
+		child = node->rb_left;
+	else
+	{
+		rb_node_t * old = node, * left;
+
+		node = node->rb_right;
+		while ((left = node->rb_left))
+			node = left;
+		child = node->rb_right;
+		parent = node->rb_parent;
+		color = node->rb_color;
+
+		if (child)
+			child->rb_parent = parent;
+		if (parent)
+		{
+			if (parent->rb_left == node)
+				parent->rb_left = child;
+			else
+				parent->rb_right = child;
+		}
+		else
+			root->rb_node = child;
+
+		if (node->rb_parent == old)
+			parent = node;
+		node->rb_parent = old->rb_parent;
+		node->rb_color = old->rb_color;
+		node->rb_right = old->rb_right;
+		node->rb_left = old->rb_left;
+
+		if (old->rb_parent)
+		{
+			if (old->rb_parent->rb_left == old)
+				old->rb_parent->rb_left = node;
+			else
+				old->rb_parent->rb_right = node;
+		} else
+			root->rb_node = node;
+
+		old->rb_left->rb_parent = node;
+		if (old->rb_right)
+			old->rb_right->rb_parent = node;
+		goto color;
+	}
+
+	parent = node->rb_parent;
+	color = node->rb_color;
+
+	if (child)
+		child->rb_parent = parent;
+	if (parent)
+	{
+		if (parent->rb_left == node)
+			parent->rb_left = child;
+		else
+			parent->rb_right = child;
+	}
+	else
+		root->rb_node = child;
+
+ color:
+	if (color == RB_BLACK)
+		__rb_erase_color(child, parent, root);
+}


Downloadable also from:

	ftp://ftp.*.kernel.org/pub/linux/kernel/people/andrea/patches/v2.3/2.3.30pre3/rbtree-1.bz2

Andrea


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
