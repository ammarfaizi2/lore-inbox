Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932347AbWDZCLp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbWDZCLp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 22:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbWDZCLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 22:11:25 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:12684 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S932345AbWDZCLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 22:11:23 -0400
Message-Id: <20060426021121.689604000@localhost.localdomain>
References: <20060426021059.235216000@localhost.localdomain>
Date: Wed, 26 Apr 2006 10:11:01 +0800
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Akinobu Mita <mita@miraclelinux.com>,
       Jens Axboe <axboe@suse.de>, Greg KH <greg@kroah.com>
Subject: [patch 2/3] use kref for io_context
Content-Disposition: inline; filename=use-kref.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use kref for reference counter of io_context.
This patch also removes BUG_ON() for freeing unreferenced io_context.
But kref can detect it if CONFIG_DEBUG_SLAB is enabled.

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
CC: Jens Axboe <axboe@suse.de>
CC: Greg KH <greg@kroah.com>

 block/cfq-iosched.c    |    2 +-
 block/ll_rw_blk.c      |   43 +++++++++++++++++++++----------------------
 include/linux/blkdev.h |    2 +-
 3 files changed, 23 insertions(+), 24 deletions(-)

Index: 2.6-git/block/ll_rw_blk.c
===================================================================
--- 2.6-git.orig/block/ll_rw_blk.c
+++ 2.6-git/block/ll_rw_blk.c
@@ -3536,29 +3536,29 @@ int __init blk_dev_init(void)
 /*
  * IO Context helper functions
  */
+static void release_io_context(struct kref *kref)
+{
+	struct io_context *ioc = container_of(kref, struct io_context, kref);
+	struct cfq_io_context *cic;
+
+	rcu_read_lock();
+	if (ioc->aic && ioc->aic->dtor)
+		ioc->aic->dtor(ioc->aic);
+	if (ioc->cic_root.rb_node != NULL) {
+		struct rb_node *n = rb_first(&ioc->cic_root);
+		cic = rb_entry(n, struct cfq_io_context, rb_node);
+		cic->dtor(ioc);
+	}
+	rcu_read_unlock();
+	kmem_cache_free(iocontext_cachep, ioc);
+}
+
 void put_io_context(struct io_context *ioc)
 {
 	if (ioc == NULL)
 		return;
 
-	BUG_ON(atomic_read(&ioc->refcount) == 0);
-
-	if (atomic_dec_and_test(&ioc->refcount)) {
-		struct cfq_io_context *cic;
-
-		rcu_read_lock();
-		if (ioc->aic && ioc->aic->dtor)
-			ioc->aic->dtor(ioc->aic);
-		if (ioc->cic_root.rb_node != NULL) {
-			struct rb_node *n = rb_first(&ioc->cic_root);
-
-			cic = rb_entry(n, struct cfq_io_context, rb_node);
-			cic->dtor(ioc);
-		}
-		rcu_read_unlock();
-
-		kmem_cache_free(iocontext_cachep, ioc);
-	}
+	kref_put(&ioc->kref, release_io_context);
 }
 EXPORT_SYMBOL(put_io_context);
 
@@ -3606,7 +3606,7 @@ struct io_context *current_io_context(gf
 
 	ret = kmem_cache_alloc(iocontext_cachep, gfp_flags);
 	if (ret) {
-		atomic_set(&ret->refcount, 1);
+		kref_init(&ret->kref);
 		ret->task = current;
 		ret->set_ioprio = NULL;
 		ret->last_waited = jiffies; /* doesn't matter... */
@@ -3631,7 +3631,7 @@ struct io_context *get_io_context(gfp_t 
 	struct io_context *ret;
 	ret = current_io_context(gfp_flags);
 	if (likely(ret))
-		atomic_inc(&ret->refcount);
+		kref_get(&ret->kref);
 	return ret;
 }
 EXPORT_SYMBOL(get_io_context);
@@ -3642,8 +3642,7 @@ void copy_io_context(struct io_context *
 	struct io_context *dst = *pdst;
 
 	if (src) {
-		BUG_ON(atomic_read(&src->refcount) == 0);
-		atomic_inc(&src->refcount);
+		kref_get(&src->kref);
 		put_io_context(dst);
 		*pdst = src;
 	}
Index: 2.6-git/include/linux/blkdev.h
===================================================================
--- 2.6-git.orig/include/linux/blkdev.h
+++ 2.6-git/include/linux/blkdev.h
@@ -88,7 +88,7 @@ struct cfq_io_context {
  * (apart from the atomic refcount), so require no locking.
  */
 struct io_context {
-	atomic_t refcount;
+	struct kref kref;
 	struct task_struct *task;
 
 	int (*set_ioprio)(struct io_context *, unsigned int);
Index: 2.6-git/block/cfq-iosched.c
===================================================================
--- 2.6-git.orig/block/cfq-iosched.c
+++ 2.6-git/block/cfq-iosched.c
@@ -1068,7 +1068,7 @@ __cfq_dispatch_requests(struct cfq_data 
 		dispatched++;
 
 		if (!cfqd->active_cic) {
-			atomic_inc(&crq->io_context->ioc->refcount);
+			kref_get(&crq->io_context->ioc->kref);
 			cfqd->active_cic = crq->io_context;
 		}
 

--
