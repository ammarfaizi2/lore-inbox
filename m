Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263895AbUGSPVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263895AbUGSPVw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 11:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264774AbUGSPVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 11:21:52 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:13993 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S263895AbUGSPVk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 11:21:40 -0400
Message-ID: <40FBE7EF.7AA669A7@tv-sign.ru>
Date: Mon, 19 Jul 2004 19:25:35 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] prio_tree shared.vm_set simplifications.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

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
Also, vma_prio_tree_remove() now works with them, beacause shuch a
vmas have vm_set.parent == 0 && vm_set.list.prev != 0.

I am very interested in your opinion.

Patch against 2.6.8-rc2, compiled, booted, seems to work.

Oleg.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

diff -urp 2.6.8-rc2/include/linux/mm.h prio_tree/include/linux/mm.h
--- 2.6.8-rc2/include/linux/mm.h	2004-07-13 17:52:47.000000000 +0400
+++ prio_tree/include/linux/mm.h	2004-07-19 17:07:41.000000000 +0400
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
@@ -600,10 +600,10 @@ extern void si_meminfo_node(struct sysin
 
 static inline void vma_prio_tree_init(struct vm_area_struct *vma)
 {
+	vma->shared.vm_set.parent = NULL;
+	vma->shared.vm_set.unused = NULL;
 	vma->shared.vm_set.list.next = NULL;
 	vma->shared.vm_set.list.prev = NULL;
-	vma->shared.vm_set.parent = NULL;
-	vma->shared.vm_set.head = NULL;
 }
 
 /* prio_tree.c */
diff -urp 2.6.8-rc2/include/linux/prio_tree.h prio_tree/include/linux/prio_tree.h
--- 2.6.8-rc2/include/linux/prio_tree.h	2004-05-24 14:16:15.000000000 +0400
+++ prio_tree/include/linux/prio_tree.h	2004-07-19 17:16:26.000000000 +0400
@@ -2,9 +2,9 @@
 #define _LINUX_PRIO_TREE_H
 
 struct prio_tree_node {
+	struct prio_tree_node	*parent;
 	struct prio_tree_node	*left;
 	struct prio_tree_node	*right;
-	struct prio_tree_node	*parent;
 };
 
 struct prio_tree_root {
diff -urp 2.6.8-rc2/mm/prio_tree.c prio_tree/mm/prio_tree.c
--- 2.6.8-rc2/mm/prio_tree.c	2004-05-30 13:25:55.000000000 +0400
+++ prio_tree/mm/prio_tree.c	2004-07-19 17:07:47.000000000 +0400
@@ -534,21 +534,29 @@ repeat:
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
@@ -568,46 +576,23 @@ void vma_prio_tree_insert(struct vm_area
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
 
@@ -624,40 +609,26 @@ struct vm_area_struct *vma_prio_tree_nex
 	struct vm_area_struct *next;
 
 	if (!vma) {
-		/*
-		 * First call is with NULL vma
-		 */
 		ptr = prio_tree_first(root, iter, begin, end);
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
+		ptr = prio_tree_next(root, iter, begin, end);
+		goto check;
 	}
 
-	ptr = prio_tree_next(root, iter, begin, end);
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
