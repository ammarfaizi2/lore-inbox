Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267279AbUG1QOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267279AbUG1QOy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 12:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267275AbUG1QOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 12:14:22 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:25538 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S267279AbUG1QJz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 12:09:55 -0400
Message-ID: <4107D0D0.18A961B0@tv-sign.ru>
Date: Wed, 28 Jul 2004 20:14:08 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Rajesh Venkatasubramanian <vrajesh@umich.edu>
Subject: [PATCH] prio_tree 3/3: shared.vm_set simplifications
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rajesh,

I'd like to give one more chance to this patch. Original
description below.

I strongly beleive, it is correct. You can get ugly user-space
test i wrote today here: http://tv-sign.ru/update/prio_tree.tgz

It saves 10% of code size in mm/prio_tree.o, from 2420 to 2135.

Reimplements vma_prio_tree_add() and vma_prio_tree_remove().
Please note, that vma_prio_tree_add() now becomes just open
coded list_add_tail() with one additional check. The "else"
branch in vma_prio_tree_remove() - __list_del().


I think, prio_tree vm_set managment can be simplified.
Patch at the end.

New layout:

struct prio_tree_node {                   struct "vm_area_struct.shared.vmset" {
        struct prio_tree_node  *parent;           void    *parent;
        struct prio_tree_node  *left;             void    *unused;
        struct prio_tree_node  *right;            struct list_head list;
};                                        };                    // list.next == prio_tree_node.right

vmas with identical [radix_index, heap_index] values iterated via
list.prev, last element has list.prev == NULL.
First vma (used as a tree node, parent != NULL) do not use list.next,
others use it to point back in list.

So, after vma_prio_tree_insert():
	
       right_node
         /\	
          |
       (next) prev		// parent != 0
               |
               \/
              NULL

after vma_prio_tree_add():

       right_node
         /\
          |
       (next) prev		// parent != 0
         /\    |
          |    \/
        next  prev		// parent == 0
         /\    |
          |    \/
        next  prev		// parent == 0
               |
               \/
              NULL

So, we can use list.next as list pointer if:
parent == 0 OR we reached this node via prev.

With this patch applied, code looks like:

void vma_prio_tree_add(struct vm_area_struct *vma, struct vm_area_struct *old)
{
	struct list_head
		*new  = &vma->shared.vm_set.list;
		*head = &old->shared.vm_set.list;

	new->prev = head->prev;
	if (new->prev)                    <------ TRUE for nonlinear vma!
		new->prev->next = new;    <------ reached via prev, safe

	head->prev = new;
	new->next = head;
}
void vma_prio_tree_remove(struct vm_area_struct *vma, struct prio_tree_root *root)
{
	struct list_head *prev = vma->shared.vm_set.list.prev;

	if (vma->shared.vm_set.parent) {
		if (prev)
			prio_tree_replace(root, &vma->shared.prio_tree_node,
						list_entry(prev, ....));
		else
			prio_tree_remove(root,  &vma->shared.prio_tree_node);
	} else {
		struct list_head *next = vma->shared.vm_set.list.next;

		next->prev = prev;          <------ parent == NULL, safe
		if (prev)
			prev->next = next;  <------ reached via prev, safe
	}
}
struct vm_area_struct *vma_prio_tree_next(vma)
{
	if (!vma)
		return prio_tree_first();

	if (!vma->shared.vm_set.list.prev)
		return prio_tree_next();

	return list_entry(vma->shared.vm_set.list.prev, ....);
}

Please note, that vma_prio_tree_add() works for nonlinear vmas too.

Oleg.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

diff -urp prio_iter/include/linux/mm.h prio_list/include/linux/mm.h
--- prio_iter/include/linux/mm.h	2004-07-28 14:07:48.000000000 +0400
+++ prio_list/include/linux/mm.h	2004-07-28 16:07:40.000000000 +0400
@@ -72,9 +72,9 @@ struct vm_area_struct {
 	 */
 	union {
 		struct {
-			struct list_head list;
-			void *parent;	/* aligns with prio_tree_node parent */
-			struct vm_area_struct *head;
+			void	*parent;
+			void	*unused;
+			struct	list_head list;
 		} vm_set;
 
 		struct prio_tree_node prio_tree_node;
@@ -612,7 +612,6 @@ struct vm_area_struct *vma_prio_tree_nex
 static inline void vma_nonlinear_insert(struct vm_area_struct *vma,
 					struct list_head *list)
 {
-	vma->shared.vm_set.parent = NULL;
 	list_add_tail(&vma->shared.vm_set.list, list);
 }
 
diff -urp prio_iter/include/linux/prio_tree.h prio_list/include/linux/prio_tree.h
--- prio_iter/include/linux/prio_tree.h	2004-07-27 20:29:59.000000000 +0400
+++ prio_list/include/linux/prio_tree.h	2004-07-28 16:08:43.000000000 +0400
@@ -2,9 +2,9 @@
 #define _LINUX_PRIO_TREE_H
 
 struct prio_tree_node {
+	struct prio_tree_node	*parent;
 	struct prio_tree_node	*left;
 	struct prio_tree_node	*right;
-	struct prio_tree_node	*parent;
 };
 
 struct prio_tree_root {
diff -urp prio_iter/mm/prio_tree.c prio_list/mm/prio_tree.c
--- prio_iter/mm/prio_tree.c	2004-07-27 20:29:59.000000000 +0400
+++ prio_list/mm/prio_tree.c	2004-07-28 16:12:44.000000000 +0400
@@ -523,24 +523,31 @@ repeat:
  */
 void vma_prio_tree_add(struct vm_area_struct *vma, struct vm_area_struct *old)
 {
+	struct list_head *new, *head;
+
+	BUILD_BUG_ON(
+		offsetof(struct prio_tree_node, parent) !=
+		offsetof(typeof(vma->shared.vm_set), parent)
+			||
+		sizeof(struct prio_tree_node) !=
+		offsetof(typeof(vma->shared.vm_set), list.prev)
+	);
+
 	/* Leave these BUG_ONs till prio_tree patch stabilizes */
 	BUG_ON(RADIX_INDEX(vma) != RADIX_INDEX(old));
 	BUG_ON(HEAP_INDEX(vma) != HEAP_INDEX(old));
 
-	vma->shared.vm_set.head = NULL;
 	vma->shared.vm_set.parent = NULL;
 
-	if (!old->shared.vm_set.parent)
-		list_add(&vma->shared.vm_set.list,
-				&old->shared.vm_set.list);
-	else if (old->shared.vm_set.head)
-		list_add_tail(&vma->shared.vm_set.list,
-				&old->shared.vm_set.head->shared.vm_set.list);
-	else {
-		INIT_LIST_HEAD(&vma->shared.vm_set.list);
-		vma->shared.vm_set.head = old;
-		old->shared.vm_set.head = vma;
-	}
+	new  = &vma->shared.vm_set.list;
+	head = &old->shared.vm_set.list;
+
+	new->prev = head->prev;
+	if (new->prev)
+		new->prev->next = new;
+
+	head->prev = new;
+	new->next = head;
 }
 
 void vma_prio_tree_insert(struct vm_area_struct *vma,
@@ -549,7 +556,7 @@ void vma_prio_tree_insert(struct vm_area
 	struct prio_tree_node *ptr;
 	struct vm_area_struct *old;
 
-	vma->shared.vm_set.head = NULL;
+	vma->shared.vm_set.list.prev = NULL;
 
 	ptr = prio_tree_insert(root, &vma->shared.prio_tree_node);
 	if (ptr != &vma->shared.prio_tree_node) {
@@ -562,46 +569,23 @@ void vma_prio_tree_insert(struct vm_area
 void vma_prio_tree_remove(struct vm_area_struct *vma,
 			  struct prio_tree_root *root)
 {
-	struct vm_area_struct *node, *head, *new_head;
+	struct list_head *prev = vma->shared.vm_set.list.prev;
 
-	if (!vma->shared.vm_set.head) {
-		if (!vma->shared.vm_set.parent)
-			list_del_init(&vma->shared.vm_set.list);
-		else
-			prio_tree_remove(root, &vma->shared.prio_tree_node);
-	} else {
-		/* Leave this BUG_ON till prio_tree patch stabilizes */
-		BUG_ON(vma->shared.vm_set.head->shared.vm_set.head != vma);
-		if (vma->shared.vm_set.parent) {
-			head = vma->shared.vm_set.head;
-			if (!list_empty(&head->shared.vm_set.list)) {
-				new_head = list_entry(
-					head->shared.vm_set.list.next,
-					struct vm_area_struct,
-					shared.vm_set.list);
-				list_del_init(&head->shared.vm_set.list);
-			} else
-				new_head = NULL;
+	if (vma->shared.vm_set.parent) {
+		if (prev) {
+			struct vm_area_struct *new = list_entry(prev,
+				struct vm_area_struct, shared.vm_set.list);
 
 			prio_tree_replace(root, &vma->shared.prio_tree_node,
-					&head->shared.prio_tree_node);
-			head->shared.vm_set.head = new_head;
-			if (new_head)
-				new_head->shared.vm_set.head = head;
-
-		} else {
-			node = vma->shared.vm_set.head;
-			if (!list_empty(&vma->shared.vm_set.list)) {
-				new_head = list_entry(
-					vma->shared.vm_set.list.next,
-					struct vm_area_struct,
-					shared.vm_set.list);
-				list_del_init(&vma->shared.vm_set.list);
-				node->shared.vm_set.head = new_head;
-				new_head->shared.vm_set.head = node;
-			} else
-				node->shared.vm_set.head = NULL;
-		}
+						&new->shared.prio_tree_node);
+		} else
+			prio_tree_remove(root,  &vma->shared.prio_tree_node);
+	} else {
+		struct list_head *next = vma->shared.vm_set.list.next;
+
+		next->prev = prev;
+		if (prev)
+			prev->next = next;
 	}
 }
 
@@ -617,40 +601,26 @@ struct vm_area_struct *vma_prio_tree_nex
 	struct vm_area_struct *next;
 
 	if (!vma) {
-		/*
-		 * First call is with NULL vma
-		 */
 		ptr = prio_tree_first(iter);
-		if (ptr) {
-			next = prio_tree_entry(ptr, struct vm_area_struct,
-						shared.prio_tree_node);
-			prefetch(next->shared.vm_set.head);
-			return next;
-		} else
-			return NULL;
+		goto check;
 	}
 
-	if (vma->shared.vm_set.parent) {
-		if (vma->shared.vm_set.head) {
-			next = vma->shared.vm_set.head;
-			prefetch(next->shared.vm_set.list.next);
-			return next;
-		}
-	} else {
-		next = list_entry(vma->shared.vm_set.list.next,
-				struct vm_area_struct, shared.vm_set.list);
-		if (!next->shared.vm_set.head) {
-			prefetch(next->shared.vm_set.list.next);
-			return next;
-		}
+	if (!vma->shared.vm_set.list.prev) {
+		ptr = prio_tree_next(iter);
+		goto check;
 	}
 
-	ptr = prio_tree_next(iter);
-	if (ptr) {
-		next = prio_tree_entry(ptr, struct vm_area_struct,
-					shared.prio_tree_node);
-		prefetch(next->shared.vm_set.head);
-		return next;
-	} else
+	next = list_entry(vma->shared.vm_set.list.prev,
+			struct vm_area_struct, shared.vm_set.list);
+	goto found;
+
+check:
+	if (!ptr)
 		return NULL;
+
+	next = prio_tree_entry(ptr, struct vm_area_struct,
+			shared.prio_tree_node);
+found:
+	prefetch(next->shared.vm_set.list.prev);
+	return next;
 }
