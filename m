Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315472AbSILNOz>; Thu, 12 Sep 2002 09:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315491AbSILNOz>; Thu, 12 Sep 2002 09:14:55 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:60154 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S315472AbSILNOl>; Thu, 12 Sep 2002 09:14:41 -0400
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [RESEND] Red Black Tree cleanups [2/2]
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 12 Sep 2002 14:19:29 +0100
Message-ID: <25160.1031836769@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the second of two rbtree patches which can be pulled from
	master.kernel.org:/home/dwmw2/BK/rbtree-2.5

This replaces the bogus 'rb_node_t' and 'rb_root_t' typedefs with 
'struct rb_node' and 'struct rb_root' respectively. It also removes a 
duplicate 'rb_next' function from net/sched/sch_htb.c.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.622   -> 1.623  
#	  include/linux/mm.h	1.77    -> 1.78   
#	           mm/mmap.c	1.45    -> 1.46   
#	        lib/rbtree.c	1.3     -> 1.4    
#	include/linux/sched.h	1.88    -> 1.89   
#	include/linux/rbtree.h	1.2     -> 1.3    
#	 net/sched/sch_htb.c	1.2     -> 1.3    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/09	dwmw2@infradead.org	1.623
# Remove bogus rb_root_t and rb_node_t typedefs in favour of 'struct rb_node' and 'struct rb_root'
# Remove duplicate implementation of rb_next() in net/sched/sch_htb.c while we're at it.
# --------------------------------------------
#
diff -Nru a/include/linux/mm.h b/include/linux/mm.h
--- a/include/linux/mm.h	Thu Sep 12 13:49:45 2002
+++ b/include/linux/mm.h	Thu Sep 12 13:49:45 2002
@@ -54,7 +54,7 @@
 	pgprot_t vm_page_prot;		/* Access permissions of this VMA. */
 	unsigned long vm_flags;		/* Flags, listed below. */
 
-	rb_node_t vm_rb;
+	struct rb_node vm_rb;
 
 	/*
 	 * For areas with an address space and backing store,
diff -Nru a/include/linux/rbtree.h b/include/linux/rbtree.h
--- a/include/linux/rbtree.h	Thu Sep 12 13:49:45 2002
+++ b/include/linux/rbtree.h	Thu Sep 12 13:49:45 2002
@@ -34,7 +34,7 @@
 static inline struct page * rb_search_page_cache(struct inode * inode,
 						 unsigned long offset)
 {
-	rb_node_t * n = inode->i_rb_page_cache.rb_node;
+	struct rb_node * n = inode->i_rb_page_cache.rb_node;
 	struct page * page;
 
 	while (n)
@@ -53,10 +53,10 @@
 
 static inline struct page * __rb_insert_page_cache(struct inode * inode,
 						   unsigned long offset,
-						   rb_node_t * node)
+						   struct rb_node * node)
 {
-	rb_node_t ** p = &inode->i_rb_page_cache.rb_node;
-	rb_node_t * parent = NULL;
+	struct rb_node ** p = &inode->i_rb_page_cache.rb_node;
+	struct rb_node * parent = NULL;
 	struct page * page;
 
 	while (*p)
@@ -79,7 +79,7 @@
 
 static inline struct page * rb_insert_page_cache(struct inode * inode,
 						 unsigned long offset,
-						 rb_node_t * node)
+						 struct rb_node * node)
 {
 	struct page * ret;
 	if ((ret = __rb_insert_page_cache(inode, offset, node)))
@@ -97,38 +97,38 @@
 #include <linux/kernel.h>
 #include <linux/stddef.h>
 
-typedef struct rb_node_s
+struct rb_node
 {
-	struct rb_node_s * rb_parent;
+	struct rb_node *rb_parent;
 	int rb_color;
 #define	RB_RED		0
 #define	RB_BLACK	1
-	struct rb_node_s * rb_right;
-	struct rb_node_s * rb_left;
-}
-rb_node_t;
+	struct rb_node *rb_right;
+	struct rb_node *rb_left;
+};
 
-typedef struct rb_root_s
+struct rb_root
 {
-	struct rb_node_s * rb_node;
-}
-rb_root_t;
+	struct rb_node *rb_node;
+};
 
-#define RB_ROOT	(rb_root_t) { NULL, }
+#define RB_ROOT	(struct rb_root) { NULL, }
 #define	rb_entry(ptr, type, member)					\
 	((type *)((char *)(ptr)-(unsigned long)(&((type *)0)->member)))
 
-extern void rb_insert_color(rb_node_t *, rb_root_t *);
-extern void rb_erase(rb_node_t *, rb_root_t *);
+extern void rb_insert_color(struct rb_node *, struct rb_root *);
+extern void rb_erase(struct rb_node *, struct rb_root *);
 
 /* Find logical next and previous nodes in a tree */
-extern rb_node_t *rb_next(rb_node_t *);
-extern rb_node_t *rb_prev(rb_node_t *);
+extern struct rb_node *rb_next(struct rb_node *);
+extern struct rb_node *rb_prev(struct rb_node *);
 
 /* Fast replacement of a single node without remove/rebalance/add/rebalance */
-extern void rb_replace_node(rb_node_t *victim, rb_node_t *new, rb_root_t *root);
+extern void rb_replace_node(struct rb_node *victim, struct rb_node *new, 
+			    struct rb_root *root);
 
-static inline void rb_link_node(rb_node_t * node, rb_node_t * parent, rb_node_t ** rb_link)
+static inline void rb_link_node(struct rb_node * node, struct rb_node * parent,
+				struct rb_node ** rb_link)
 {
 	node->rb_parent = parent;
 	node->rb_color = RB_RED;
diff -Nru a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	Thu Sep 12 13:49:45 2002
+++ b/include/linux/sched.h	Thu Sep 12 13:49:45 2002
@@ -173,7 +173,7 @@
 struct kioctx;
 struct mm_struct {
 	struct vm_area_struct * mmap;		/* list of VMAs */
-	rb_root_t mm_rb;
+	struct rb_root mm_rb;
 	struct vm_area_struct * mmap_cache;	/* last find_vma result */
 	pgd_t * pgd;
 	atomic_t mm_users;			/* How many users with user space? */
diff -Nru a/lib/rbtree.c b/lib/rbtree.c
--- a/lib/rbtree.c	Thu Sep 12 13:49:45 2002
+++ b/lib/rbtree.c	Thu Sep 12 13:49:45 2002
@@ -23,9 +23,9 @@
 #include <linux/rbtree.h>
 #include <linux/module.h>
 
-static void __rb_rotate_left(rb_node_t * node, rb_root_t * root)
+static void __rb_rotate_left(struct rb_node *node, struct rb_root *root)
 {
-	rb_node_t * right = node->rb_right;
+	struct rb_node *right = node->rb_right;
 
 	if ((node->rb_right = right->rb_left))
 		right->rb_left->rb_parent = node;
@@ -43,9 +43,9 @@
 	node->rb_parent = right;
 }
 
-static void __rb_rotate_right(rb_node_t * node, rb_root_t * root)
+static void __rb_rotate_right(struct rb_node *node, struct rb_root *root)
 {
-	rb_node_t * left = node->rb_left;
+	struct rb_node *left = node->rb_left;
 
 	if ((node->rb_left = left->rb_right))
 		left->rb_right->rb_parent = node;
@@ -63,9 +63,9 @@
 	node->rb_parent = left;
 }
 
-void rb_insert_color(rb_node_t * node, rb_root_t * root)
+void rb_insert_color(struct rb_node *node, struct rb_root *root)
 {
-	rb_node_t * parent, * gparent;
+	struct rb_node *parent, *gparent;
 
 	while ((parent = node->rb_parent) && parent->rb_color == RB_RED)
 	{
@@ -74,7 +74,7 @@
 		if (parent == gparent->rb_left)
 		{
 			{
-				register rb_node_t * uncle = gparent->rb_right;
+				register struct rb_node *uncle = gparent->rb_right;
 				if (uncle && uncle->rb_color == RB_RED)
 				{
 					uncle->rb_color = RB_BLACK;
@@ -87,7 +87,7 @@
 
 			if (parent->rb_right == node)
 			{
-				register rb_node_t * tmp;
+				register struct rb_node *tmp;
 				__rb_rotate_left(parent, root);
 				tmp = parent;
 				parent = node;
@@ -99,7 +99,7 @@
 			__rb_rotate_right(gparent, root);
 		} else {
 			{
-				register rb_node_t * uncle = gparent->rb_left;
+				register struct rb_node *uncle = gparent->rb_left;
 				if (uncle && uncle->rb_color == RB_RED)
 				{
 					uncle->rb_color = RB_BLACK;
@@ -112,7 +112,7 @@
 
 			if (parent->rb_left == node)
 			{
-				register rb_node_t * tmp;
+				register struct rb_node *tmp;
 				__rb_rotate_right(parent, root);
 				tmp = parent;
 				parent = node;
@@ -129,10 +129,10 @@
 }
 EXPORT_SYMBOL(rb_insert_color);
 
-static void __rb_erase_color(rb_node_t * node, rb_node_t * parent,
-			     rb_root_t * root)
+static void __rb_erase_color(struct rb_node *node, struct rb_node *parent,
+			     struct rb_root *root)
 {
-	rb_node_t * other;
+	struct rb_node *other;
 
 	while ((!node || node->rb_color == RB_BLACK) && node != root->rb_node)
 	{
@@ -160,7 +160,7 @@
 				if (!other->rb_right ||
 				    other->rb_right->rb_color == RB_BLACK)
 				{
-					register rb_node_t * o_left;
+					register struct rb_node *o_left;
 					if ((o_left = other->rb_left))
 						o_left->rb_color = RB_BLACK;
 					other->rb_color = RB_RED;
@@ -200,7 +200,7 @@
 				if (!other->rb_left ||
 				    other->rb_left->rb_color == RB_BLACK)
 				{
-					register rb_node_t * o_right;
+					register struct rb_node *o_right;
 					if ((o_right = other->rb_right))
 						o_right->rb_color = RB_BLACK;
 					other->rb_color = RB_RED;
@@ -221,9 +221,9 @@
 		node->rb_color = RB_BLACK;
 }
 
-void rb_erase(rb_node_t * node, rb_root_t * root)
+void rb_erase(struct rb_node *node, struct rb_root *root)
 {
-	rb_node_t * child, * parent;
+	struct rb_node *child, *parent;
 	int color;
 
 	if (!node->rb_left)
@@ -232,7 +232,7 @@
 		child = node->rb_left;
 	else
 	{
-		rb_node_t * old = node, * left;
+		struct rb_node *old = node, *left;
 
 		node = node->rb_right;
 		while ((left = node->rb_left))
@@ -296,7 +296,7 @@
 }
 EXPORT_SYMBOL(rb_erase);
 
-rb_node_t *rb_next(rb_node_t *node)
+struct rb_node *rb_next(struct rb_node *node)
 {
 	/* If we have a right-hand child, go down and then left as far
 	   as we can. */
@@ -320,7 +320,7 @@
 }
 EXPORT_SYMBOL(rb_next);
 
-rb_node_t *rb_prev(rb_node_t *node)
+struct rb_node *rb_prev(struct rb_node *node)
 {
 	/* If we have a left-hand child, go down and then right as far
 	   as we can. */
@@ -340,9 +340,10 @@
 }
 EXPORT_SYMBOL(rb_prev);
 
-void rb_replace_node(rb_node_t *victim, rb_node_t *new, rb_root_t *root)
+void rb_replace_node(struct rb_node *victim, struct rb_node *new,
+		     struct rb_root *root)
 {
-	rb_node_t *parent = victim->rb_parent;
+	struct rb_node *parent = victim->rb_parent;
 
 	/* Set the surrounding nodes to point to the replacement */
 	if (parent) {
diff -Nru a/mm/mmap.c b/mm/mmap.c
--- a/mm/mmap.c	Thu Sep 12 13:49:45 2002
+++ b/mm/mmap.c	Thu Sep 12 13:49:45 2002
@@ -245,7 +245,7 @@
 }
 
 #ifdef DEBUG_MM_RB
-static int browse_rb(rb_node_t * rb_node) {
+static int browse_rb(struct rb_node * rb_node) {
 	int i = 0;
 	if (rb_node) {
 		i++;
@@ -277,10 +277,11 @@
 
 static struct vm_area_struct * find_vma_prepare(struct mm_struct * mm, unsigned long addr,
 						struct vm_area_struct ** pprev,
-						rb_node_t *** rb_link, rb_node_t ** rb_parent)
+						struct rb_node *** rb_link,
+						struct rb_node ** rb_parent)
 {
 	struct vm_area_struct * vma;
-	rb_node_t ** __rb_link, * __rb_parent, * rb_prev;
+	struct rb_node ** __rb_link, * __rb_parent, * rb_prev;
 
 	__rb_link = &mm->mm_rb.rb_node;
 	rb_prev = __rb_parent = NULL;
@@ -311,8 +312,8 @@
 	return vma;
 }
 
-static inline void __vma_link_list(struct mm_struct * mm, struct vm_area_struct * vma, struct vm_area_struct * prev,
-				   rb_node_t * rb_parent)
+static inline void __vma_link_list(struct mm_struct * mm, struct vm_area_struct * vma,
+				   struct vm_area_struct * prev, struct rb_node * rb_parent)
 {
 	if (prev) {
 		vma->vm_next = prev->vm_next;
@@ -327,7 +328,7 @@
 }
 
 static inline void __vma_link_rb(struct mm_struct * mm, struct vm_area_struct * vma,
-				 rb_node_t ** rb_link, rb_node_t * rb_parent)
+				 struct rb_node ** rb_link, struct rb_node * rb_parent)
 {
 	rb_link_node(&vma->vm_rb, rb_parent, rb_link);
 	rb_insert_color(&vma->vm_rb, &mm->mm_rb);
@@ -353,7 +354,7 @@
 }
 
 static void __vma_link(struct mm_struct * mm, struct vm_area_struct * vma,  struct vm_area_struct * prev,
-		       rb_node_t ** rb_link, rb_node_t * rb_parent)
+		       struct rb_node ** rb_link, struct rb_node * rb_parent)
 {
 	__vma_link_list(mm, vma, prev, rb_parent);
 	__vma_link_rb(mm, vma, rb_link, rb_parent);
@@ -361,7 +362,7 @@
 }
 
 static inline void vma_link(struct mm_struct * mm, struct vm_area_struct * vma, struct vm_area_struct * prev,
-			    rb_node_t ** rb_link, rb_node_t * rb_parent)
+			    struct rb_node ** rb_link, struct rb_node * rb_parent)
 {
 	spin_lock(&mm->page_table_lock);
 	lock_vma_mappings(vma);
@@ -374,7 +375,8 @@
 }
 
 static int vma_merge(struct mm_struct * mm, struct vm_area_struct * prev,
-		     rb_node_t * rb_parent, unsigned long addr, unsigned long end, unsigned long vm_flags)
+		     struct rb_node * rb_parent, unsigned long addr, 
+		     unsigned long end, unsigned long vm_flags)
 {
 	spinlock_t * lock = &mm->page_table_lock;
 	if (!prev) {
@@ -426,7 +428,7 @@
 	unsigned int vm_flags;
 	int correct_wcount = 0;
 	int error;
-	rb_node_t ** rb_link, * rb_parent;
+	struct rb_node ** rb_link, * rb_parent;
 	unsigned long charged = 0;
 
 	if (file && (!file->f_op || !file->f_op->mmap))
@@ -698,7 +700,7 @@
 		/* (Cache hit rate is typically around 35%.) */
 		vma = mm->mmap_cache;
 		if (!(vma && vma->vm_end > addr && vma->vm_start <= addr)) {
-			rb_node_t * rb_node;
+			struct rb_node * rb_node;
 
 			rb_node = mm->mm_rb.rb_node;
 			vma = NULL;
@@ -728,7 +730,7 @@
 				      struct vm_area_struct **pprev)
 {
 	struct vm_area_struct *vma = NULL, *prev = NULL;
-	rb_node_t * rb_node;
+	struct rb_node * rb_node;
 	if (!mm)
 		goto out;
 
@@ -1158,7 +1160,7 @@
 	struct mm_struct * mm = current->mm;
 	struct vm_area_struct * vma, * prev;
 	unsigned long flags;
-	rb_node_t ** rb_link, * rb_parent;
+	struct rb_node ** rb_link, * rb_parent;
 
 	len = PAGE_ALIGN(len);
 	if (!len)
@@ -1236,7 +1238,7 @@
 void build_mmap_rb(struct mm_struct * mm)
 {
 	struct vm_area_struct * vma;
-	rb_node_t ** rb_link, * rb_parent;
+	struct rb_node ** rb_link, * rb_parent;
 
 	mm->mm_rb = RB_ROOT;
 	rb_link = &mm->mm_rb.rb_node;
@@ -1319,7 +1321,7 @@
 void __insert_vm_struct(struct mm_struct * mm, struct vm_area_struct * vma)
 {
 	struct vm_area_struct * __vma, * prev;
-	rb_node_t ** rb_link, * rb_parent;
+	struct rb_node ** rb_link, * rb_parent;
 
 	__vma = find_vma_prepare(mm, vma->vm_start, &prev, &rb_link, &rb_parent);
 	if (__vma && __vma->vm_start < vma->vm_end)
@@ -1332,7 +1334,7 @@
 void insert_vm_struct(struct mm_struct * mm, struct vm_area_struct * vma)
 {
 	struct vm_area_struct * __vma, * prev;
-	rb_node_t ** rb_link, * rb_parent;
+	struct rb_node ** rb_link, * rb_parent;
 
 	__vma = find_vma_prepare(mm, vma->vm_start, &prev, &rb_link, &rb_parent);
 	if (__vma && __vma->vm_start < vma->vm_end)
diff -Nru a/net/sched/sch_htb.c b/net/sched/sch_htb.c
--- a/net/sched/sch_htb.c	Thu Sep 12 13:49:45 2002
+++ b/net/sched/sch_htb.c	Thu Sep 12 13:49:45 2002
@@ -162,12 +162,12 @@
 		    struct list_head drop_list;
 	    } leaf;
 	    struct htb_class_inner {
-		    rb_root_t feed[TC_HTB_NUMPRIO];	/* feed trees */
-		    rb_node_t *ptr[TC_HTB_NUMPRIO];	/* current class ptr */
+		    struct rb_root feed[TC_HTB_NUMPRIO]; /* feed trees */
+		    struct rb_node *ptr[TC_HTB_NUMPRIO]; /* current class ptr */
 	    } inner;
     } un;
-    rb_node_t node[TC_HTB_NUMPRIO];	/* node for self or feed tree */
-    rb_node_t pq_node;			/* node for event queue */
+    struct rb_node node[TC_HTB_NUMPRIO]; /* node for self or feed tree */
+    struct rb_node pq_node;		 /* node for event queue */
     unsigned long pq_key;	/* the same type as jiffies global */
     
     int prio_activity;		/* for which prios are we active */
@@ -207,12 +207,12 @@
     struct list_head drops[TC_HTB_NUMPRIO];	/* active leaves (for drops) */
     
     /* self list - roots of self generating tree */
-    rb_root_t row[TC_HTB_MAXDEPTH][TC_HTB_NUMPRIO];
+    struct rb_root row[TC_HTB_MAXDEPTH][TC_HTB_NUMPRIO];
     int row_mask[TC_HTB_MAXDEPTH];
-    rb_node_t *ptr[TC_HTB_MAXDEPTH][TC_HTB_NUMPRIO];
+    struct rb_node *ptr[TC_HTB_MAXDEPTH][TC_HTB_NUMPRIO];
 
     /* self wait list - roots of wait PQs per row */
-    rb_root_t wait_pq[TC_HTB_MAXDEPTH];
+    struct rb_root wait_pq[TC_HTB_MAXDEPTH];
 
     /* time of nearest event per level (row) */
     unsigned long near_ev_cache[TC_HTB_MAXDEPTH];
@@ -324,9 +324,9 @@
 }
 
 #ifdef HTB_DEBUG
-static void htb_next_rb_node(rb_node_t **n);
+static void htb_next_rb_node(struct rb_node **n);
 #define HTB_DUMTREE(root,memb) if(root) { \
-	rb_node_t *n = (root)->rb_node; \
+	struct rb_node *n = (root)->rb_node; \
 	while (n->rb_left) n = n->rb_left; \
 	while (n) { \
 		struct htb_class *cl = rb_entry(n, struct htb_class, memb); \
@@ -375,10 +375,10 @@
  * Routine adds class to the list (actually tree) sorted by classid.
  * Make sure that class is not already on such list for given prio.
  */
-static void htb_add_to_id_tree (HTB_ARGQ rb_root_t *root,
+static void htb_add_to_id_tree (HTB_ARGQ struct rb_root *root,
 		struct htb_class *cl,int prio)
 {
-	rb_node_t **p = &root->rb_node, *parent = NULL;
+	struct rb_node **p = &root->rb_node, *parent = NULL;
 	HTB_DBG(7,3,"htb_add_id_tree cl=%X prio=%d\n",cl->classid,prio);
 #ifdef HTB_DEBUG
 	if (cl->node[prio].rb_color != -1) { BUG_TRAP(0); return; }
@@ -411,7 +411,7 @@
 static void htb_add_to_wait_tree (struct htb_sched *q,
 		struct htb_class *cl,long delay,int debug_hint)
 {
-	rb_node_t **p = &q->wait_pq[cl->level].rb_node, *parent = NULL;
+	struct rb_node **p = &q->wait_pq[cl->level].rb_node, *parent = NULL;
 	HTB_DBG(7,3,"htb_add_wt cl=%X key=%lu\n",cl->classid,cl->pq_key);
 #ifdef HTB_DEBUG
 	if (cl->pq_node.rb_color != -1) { BUG_TRAP(0); return; }
@@ -447,20 +447,9 @@
  * When we are past last key we return NULL.
  * Average complexity is 2 steps per call.
  */
-static void htb_next_rb_node(rb_node_t **n)
+static void htb_next_rb_node(struct rb_node **n)
 {
-	rb_node_t *p;
-	if ((*n)->rb_right) {
-		*n = (*n)->rb_right;
-		while ((*n)->rb_left) 
-			*n = (*n)->rb_left;
-		return;
-	}
-	while ((p = (*n)->rb_parent) != NULL) {
-		if (p->rb_left == *n) break;
-		*n = p;
-	}
-	*n = p;
+	*n = rb_next(*n);
 }
 
 /**
@@ -869,7 +858,7 @@
 	for (i = 0; i < 500; i++) {
 		struct htb_class *cl;
 		long diff;
-		rb_node_t *p = q->wait_pq[level].rb_node;
+		struct rb_node *p = q->wait_pq[level].rb_node;
 		if (!p) return 0;
 		while (p->rb_left) p = p->rb_left;
 
@@ -906,12 +895,12 @@
  * Find leaf where current feed pointers points to.
  */
 static struct htb_class *
-htb_lookup_leaf(rb_root_t *tree,int prio,rb_node_t **pptr)
+htb_lookup_leaf(struct rb_root *tree,int prio,struct rb_node **pptr)
 {
 	int i;
 	struct {
-		rb_node_t *root;
-		rb_node_t **pptr;
+		struct rb_node *root;
+		struct rb_node **pptr;
 	} stk[TC_HTB_MAXDEPTH],*sp = stk;
 	
 	sp->root = tree->rb_node;



--
dwmw2


