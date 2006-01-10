Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932621AbWAJUxb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932621AbWAJUxb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 15:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932613AbWAJUxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 15:53:31 -0500
Received: from mail.gmx.net ([213.165.64.21]:28564 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932621AbWAJUxa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 15:53:30 -0500
X-Authenticated: #704063
Subject: [RFC][Patch] Use rbtree in fs/aio.c
From: Eric Sesterhenn / snakebyte <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: bcrl@kvack.org
Content-Type: text/plain
Date: Tue, 10 Jan 2006 21:53:26 +0100
Message-Id: <1136926406.7480.14.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

while grepping trough the kernel sources, i noticed there are
quite a few FIXME and TODO comments and the number is increasing
each release by ~30. That is why i try to tackle a fixme in fs/aio.c.

/*	Lookup an ioctx id.  ioctx_list is lockless for reads.
 *	FIXME: this is O(n) and is only suitable for development.
 */

The attached patch replaces the linked list in aio.c with a
rbtree to speed up the lookups. Since it seems likely() that
the first entry in the list is the one we try to lookup I
dont know if this is the way to go:

  for (ioctx = mm->ioctx_list; ioctx; ioctx = ioctx->next)
	if (likely(ioctx->user_id == ctx_id && !ioctx->dead))  {

The patch compiles, boots, and survives an aio-stress
( ftp://ftp.suse.com/pub/people/mason/utils/aio-stress.c )
run with multiple threads. When i only run a read/write test
with no random access it is ~2-3 seconds faster than without
the patch, but that might also be an error in measurement.

Since i am pretty new to kernel stuff, feel free to flame and
please cc me on replies.


Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>


--- linux-2.6.15/include/linux/aio.h	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15-aio/include/linux/aio.h	2006-01-10 16:53:05.000000000 +0100
@@ -4,6 +4,7 @@
 #include <linux/list.h>
 #include <linux/workqueue.h>
 #include <linux/aio_abi.h>
+#include <linux/rbtree.h>
 
 #include <asm/atomic.h>
 
@@ -173,7 +174,7 @@ struct kioctx {
 
 	/* This needs improving */
 	unsigned long		user_id;
-	struct kioctx		*next;
+	struct rb_node		rb_node;
 
 	wait_queue_head_t	wait;
 
--- linux-2.6.15/fs/aio.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15-aio/fs/aio.c	2006-01-10 18:40:30.000000000 +0100
@@ -62,6 +62,11 @@ static LIST_HEAD(fput_head);
 static void aio_kick_handler(void *);
 static void aio_queue_work(struct kioctx *);
 
+struct kioctx *ioctx_rb_get_next(struct kioctx *ioctx);
+struct kioctx *ioctx_rb_find(unsigned long ctx_id);
+void ioctx_rb_insert(struct kioctx *ioctx);
+void ioctx_rb_erase(struct kioctx *ioctx);
+
 /* aio_setup
  *	Creates the slab caches used by the aio routines, panic on
  *	failure as this is done early during the boot sequence.
@@ -244,11 +249,8 @@ static struct kioctx *ioctx_alloc(unsign
 	if (ctx->max_reqs == 0)
 		goto out_cleanup;
 
-	/* now link into global list.  kludge.  FIXME */
-	write_lock(&mm->ioctx_list_lock);
-	ctx->next = mm->ioctx_list;
-	mm->ioctx_list = ctx;
-	write_unlock(&mm->ioctx_list_lock);
+	/* insert into the tree */
+	ioctx_rb_insert(ctx);
 
 	dprintk("aio: allocated ioctx %p[%ld]: mm=%p mask=0x%x\n",
 		ctx, ctx->user_id, current->mm, ctx->ring_info.nr);
@@ -336,11 +338,10 @@ ssize_t fastcall wait_on_sync_kiocb(stru
  */
 void fastcall exit_aio(struct mm_struct *mm)
 {
-	struct kioctx *ctx = mm->ioctx_list;
-	mm->ioctx_list = NULL;
+	struct kioctx *ctx = (struct kioctx *) mm->ioctx_rb.rb_node;
 	while (ctx) {
-		struct kioctx *next = ctx->next;
-		ctx->next = NULL;
+		struct kioctx *next = ioctx_rb_get_next(ctx);
+		ioctx_rb_erase(ctx);
 		aio_cancel_all(ctx);
 
 		wait_for_all_aios(ctx);
@@ -541,23 +542,92 @@ int fastcall aio_put_req(struct kiocb *r
 	return ret;
 }
 
-/*	Lookup an ioctx id.  ioctx_list is lockless for reads.
- *	FIXME: this is O(n) and is only suitable for development.
- */
-struct kioctx *lookup_ioctx(unsigned long ctx_id)
+struct kioctx *ioctx_rb_get_next(struct kioctx *ioctx)
 {
-	struct kioctx *ioctx;
-	struct mm_struct *mm;
+	struct mm_struct *mm = current->mm;
+	struct rb_node *tmp;
+	
+	read_lock(&mm->ioctx_list_lock);
+	tmp = rb_next(&ioctx->rb_node);
+	read_unlock(&mm->ioctx_list_lock);
+	return rb_entry(tmp, struct kioctx, rb_node);
+}
 
-	mm = current->mm;
+/*
+ *	dead -> search for !ioctx->dead
+ */
+struct kioctx *ioctx_rb_find(unsigned long ctx_id)
+{
+	struct mm_struct *mm = current->mm;
+	struct rb_node *n, *next;
+	struct kioctx *tmp;
+	
+	n = mm->ioctx_rb.rb_node;
+	if (!n)
+		return NULL;
+	
 	read_lock(&mm->ioctx_list_lock);
-	for (ioctx = mm->ioctx_list; ioctx; ioctx = ioctx->next)
-		if (likely(ioctx->user_id == ctx_id && !ioctx->dead)) {
-			get_ioctx(ioctx);
+	for (;;)
+	{
+		tmp = rb_entry(n, struct kioctx, rb_node);
+		if (ctx_id <= tmp->user_id)
+			next = n->rb_left;
+		else
+			next = n->rb_right;
+
+		if (!next)
 			break;
-		}
+		n = next;
+	}
+	if (ctx_id > tmp->user_id)
+	{
+		tmp = ioctx_rb_get_next(tmp);
+	}
 	read_unlock(&mm->ioctx_list_lock);
+	if (tmp->dead)
+		return NULL;
+
+	return tmp;
+}
+
+void ioctx_rb_insert(struct kioctx *ioctx)
+{
+	struct mm_struct *mm = current->mm;
+	struct rb_node *parent = NULL;
+	struct rb_node **p = &mm->ioctx_rb.rb_node;
+	struct kioctx *tmp;
+	
+	write_lock(&mm->ioctx_list_lock);
+	while(*p)
+	{
+		parent = *p;
+		tmp = rb_entry(parent, struct kioctx, rb_node);
+		if (ioctx->user_id < tmp->user_id)
+			p = &(*p)->rb_left;
+		else
+			p = &(*p)->rb_right;
+	}
+	rb_link_node(&ioctx->rb_node, parent, p);
+	rb_insert_color(&ioctx->rb_node, &mm->ioctx_rb);
+	write_unlock(&mm->ioctx_list_lock);
+}
+
+void ioctx_rb_erase(struct kioctx *ioctx)
+{
+        struct mm_struct *mm = current->mm;
+        write_lock(&mm->ioctx_list_lock);
+	rb_erase(&ioctx->rb_node, &mm->ioctx_rb);
+	write_unlock(&mm->ioctx_list_lock);
+}
 
+/*	Lookup an ioctx id.  ioctx_list is lockless for reads.
+ */
+struct kioctx *lookup_ioctx(unsigned long ctx_id)
+{
+	struct kioctx *ioctx;
+
+	ioctx = ioctx_rb_find(ctx_id);
+	get_ioctx(ioctx);
 	return ioctx;
 }
 
@@ -1216,21 +1286,13 @@ out:
  */
 static void io_destroy(struct kioctx *ioctx)
 {
-	struct mm_struct *mm = current->mm;
-	struct kioctx **tmp;
 	int was_dead;
 
-	/* delete the entry from the list is someone else hasn't already */
-	write_lock(&mm->ioctx_list_lock);
+	/* delete the entry from the list if someone else hasn't already */
 	was_dead = ioctx->dead;
 	ioctx->dead = 1;
-	for (tmp = &mm->ioctx_list; *tmp && *tmp != ioctx;
-	     tmp = &(*tmp)->next)
-		;
-	if (*tmp)
-		*tmp = ioctx->next;
-	write_unlock(&mm->ioctx_list_lock);
-
+	ioctx_rb_erase(ioctx);
+	
 	dprintk("aio_release(%p)\n", ioctx);
 	if (likely(!was_dead))
 		put_ioctx(ioctx);	/* twice for the list */

--- linux-2.6.15/kernel/fork.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15-aio/kernel/fork.c	2006-01-10 15:53:54.000000000 +0100
@@ -322,7 +322,7 @@ static struct mm_struct * mm_init(struct
 	set_mm_counter(mm, anon_rss, 0);
 	spin_lock_init(&mm->page_table_lock);
 	rwlock_init(&mm->ioctx_list_lock);
-	mm->ioctx_list = NULL;
+	mm->ioctx_rb = RB_ROOT;
 	mm->free_area_cache = TASK_UNMAPPED_BASE;
 	mm->cached_hole_size = ~0UL;
 
--- linux-2.6.15/include/linux/sched.h	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15-aio/include/linux/sched.h	2006-01-10 15:50:19.000000000 +0100
@@ -356,7 +356,7 @@ struct mm_struct {
 
 	/* aio bits */
 	rwlock_t		ioctx_list_lock;
-	struct kioctx		*ioctx_list;
+	struct rb_root		ioctx_rb;
 };
 
 struct sighand_struct {


