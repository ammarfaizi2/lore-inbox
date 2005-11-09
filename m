Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751408AbVKIVPr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbVKIVPr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 16:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbVKIVPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 16:15:46 -0500
Received: from tetsuo.zabbo.net ([207.173.201.20]:18562 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S1751408AbVKIVPe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 16:15:34 -0500
From: Zach Brown <zach.brown@oracle.com>
To: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Cc: Benjamin LaHaise <bcrl@kvack.org>, Andrew Morton <akpm@osdl.org>
Message-Id: <20051109211808.25027.75305.sendpatchset@volauvent.pdx.zabbo.net>
In-Reply-To: <20051109211758.25027.78199.sendpatchset@volauvent.pdx.zabbo.net>
References: <20051109211758.25027.78199.sendpatchset@volauvent.pdx.zabbo.net>
Subject: [PATCH 3/3] aio: make ctx ref debugging depend on DEBUG
Date: Wed,  9 Nov 2005 13:15:16 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

aio: make ctx ref debugging depend on DEBUG

Formalize ctx refcount debugging by putting it in legible inline functions and
making it conditional on DEBUG.  In doing so a bug is also fixed where the
decref debugging was testing the ref count after dropping its reference,
opening a race with another thread that might free.

  Signed-off-by: Zach Brown <zach.brown@oracle.com>
---

 fs/aio.c            |   65 +++++++++++++++++++++++++++++-----------------------
 include/linux/aio.h |    4 ---
 2 files changed, 37 insertions(+), 32 deletions(-)

Index: 2.6.14-mm1-aio-cleanups/fs/aio.c
===================================================================
--- 2.6.14-mm1-aio-cleanups.orig/fs/aio.c	2005-11-09 11:48:27.394115109 -0800
+++ 2.6.14-mm1-aio-cleanups/fs/aio.c	2005-11-09 11:52:30.663874807 -0800
@@ -37,8 +37,10 @@
 
 #if DEBUG > 1
 #define dprintk		printk
+#define AIO_DEBUG_BUG_ON BUG_ON
 #else
 #define dprintk(x...)	do { ; } while (0)
+#define AIO_DEBUG_BUG_ON(x...) do { ; } while (0)
 #endif
 
 /*------ sysctl variables----*/
@@ -171,6 +173,40 @@
 	return 0;
 }
 
+static inline void get_ioctx(struct kioctx *ctx)
+{
+	AIO_DEBUG_BUG_ON(atomic_read(&ctx->users) <= 0);
+	atomic_inc(&ctx->users);
+}
+
+static void __put_ioctx(struct kioctx *ctx)
+{
+	unsigned nr_events = ctx->max_reqs;
+
+	BUG_ON(ctx->reqs_active);
+
+	cancel_delayed_work(&ctx->wq);
+	flush_workqueue(aio_wq);
+	aio_free_ring(ctx);
+	mmdrop(ctx->mm);
+	ctx->mm = NULL;
+	pr_debug("__put_ioctx: freeing %p\n", ctx);
+	kmem_cache_free(kioctx_cachep, ctx);
+
+	if (nr_events) {
+		spin_lock(&aio_nr_lock);
+		BUG_ON(aio_nr - nr_events > aio_nr);
+		aio_nr -= nr_events;
+		spin_unlock(&aio_nr_lock);
+	}
+}
+
+static inline void put_ioctx(struct kioctx *ctx)
+{
+	AIO_DEBUG_BUG_ON(atomic_read(&ctx->users) == 0);
+	if (atomic_dec_and_test(&ctx->users))
+		__put_ioctx(ctx);
+}
 
 /* aio_ring_event: returns a pointer to the event at the given index from
  * kmap_atomic(, km).  Release the pointer with put_aio_ring_event();
@@ -255,7 +291,7 @@
 	return ctx;
 
 out_cleanup:
-	__put_ioctx(ctx);
+	put_ioctx(ctx);
 	return ERR_PTR(-EAGAIN);
 
 out_freectx:
@@ -360,33 +396,6 @@
 	}
 }
 
-/* __put_ioctx
- *	Called when the last user of an aio context has gone away,
- *	and the struct needs to be freed.
- */
-void fastcall __put_ioctx(struct kioctx *ctx)
-{
-	unsigned nr_events = ctx->max_reqs;
-
-	if (unlikely(ctx->reqs_active))
-		BUG();
-
-	cancel_delayed_work(&ctx->wq);
-	flush_workqueue(aio_wq);
-	aio_free_ring(ctx);
-	mmdrop(ctx->mm);
-	ctx->mm = NULL;
-	pr_debug("__put_ioctx: freeing %p\n", ctx);
-	kmem_cache_free(kioctx_cachep, ctx);
-
-	if (nr_events) {
-		spin_lock(&aio_nr_lock);
-		BUG_ON(aio_nr - nr_events > aio_nr);
-		aio_nr -= nr_events;
-		spin_unlock(&aio_nr_lock);
-	}
-}
-
 /* aio_get_req
  *	Allocate a slot for an aio request.  Increments the users count
  * of the kioctx so that the kioctx stays around until all requests are
Index: 2.6.14-mm1-aio-cleanups/include/linux/aio.h
===================================================================
--- 2.6.14-mm1-aio-cleanups.orig/include/linux/aio.h	2005-11-09 11:48:22.848483645 -0800
+++ 2.6.14-mm1-aio-cleanups/include/linux/aio.h	2005-11-09 11:48:31.907756204 -0800
@@ -198,7 +198,6 @@
 extern int FASTCALL(aio_put_req(struct kiocb *iocb));
 extern void FASTCALL(kick_iocb(struct kiocb *iocb));
 extern int FASTCALL(aio_complete(struct kiocb *iocb, long res, long res2));
-extern void FASTCALL(__put_ioctx(struct kioctx *ctx));
 struct mm_struct;
 extern void FASTCALL(exit_aio(struct mm_struct *mm));
 extern struct kioctx *lookup_ioctx(unsigned long ctx_id);
@@ -210,9 +209,6 @@
 int FASTCALL(io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 				  struct iocb *iocb));
 
-#define get_ioctx(kioctx)	do { if (unlikely(atomic_read(&(kioctx)->users) <= 0)) BUG(); atomic_inc(&(kioctx)->users); } while (0)
-#define put_ioctx(kioctx)	do { if (unlikely(atomic_dec_and_test(&(kioctx)->users))) __put_ioctx(kioctx); else if (unlikely(atomic_read(&(kioctx)->users) < 0)) BUG(); } while (0)
-
 #define in_aio() !is_sync_wait(current->io_wait)
 /* may be used for debugging */
 #define warn_if_async()							\
