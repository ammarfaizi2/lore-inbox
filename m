Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751395AbVKIVPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbVKIVPa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 16:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbVKIVPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 16:15:30 -0500
Received: from tetsuo.zabbo.net ([207.173.201.20]:17794 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S1751395AbVKIVP3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 16:15:29 -0500
From: Zach Brown <zach.brown@oracle.com>
To: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Cc: Benjamin LaHaise <bcrl@kvack.org>, Andrew Morton <akpm@osdl.org>
Message-Id: <20051109211803.25027.27341.sendpatchset@volauvent.pdx.zabbo.net>
In-Reply-To: <20051109211758.25027.78199.sendpatchset@volauvent.pdx.zabbo.net>
References: <20051109211758.25027.78199.sendpatchset@volauvent.pdx.zabbo.net>
Subject: [PATCH 2/3] aio: replace locking comments with assert_spin_locked()
Date: Wed,  9 Nov 2005 13:15:11 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

aio: replace locking comments with assert_spin_locked()

  Signed-off-by: Zach Brown <zach.brown@oracle.com>
---

 aio.c |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

Index: 2.6.14-mm1-aio-cleanups/fs/aio.c
===================================================================
--- 2.6.14-mm1-aio-cleanups.orig/fs/aio.c	2005-11-09 11:48:22.848483645 -0800
+++ 2.6.14-mm1-aio-cleanups/fs/aio.c	2005-11-09 11:48:27.394115109 -0800
@@ -457,6 +457,8 @@
 
 static inline void really_put_req(struct kioctx *ctx, struct kiocb *req)
 {
+	assert_spin_locked(&ctx->ctx_lock);
+
 	if (req->ki_dtor)
 		req->ki_dtor(req);
 	kmem_cache_free(kiocb_cachep, req);
@@ -498,6 +500,8 @@
 	dprintk(KERN_DEBUG "aio_put(%p): f_count=%d\n",
 		req, atomic_read(&req->ki_filp->f_count));
 
+	assert_spin_locked(&ctx->ctx_lock);
+
 	req->ki_users --;
 	if (unlikely(req->ki_users < 0))
 		BUG();
@@ -619,14 +623,13 @@
  * the kiocb (to tell the caller to activate the work
  * queue to process it), or 0, if it found that it was
  * already queued.
- *
- * Should be called with the spin lock iocb->ki_ctx->ctx_lock
- * held
  */
 static inline int __queue_kicked_iocb(struct kiocb *iocb)
 {
 	struct kioctx *ctx = iocb->ki_ctx;
 
+	assert_spin_locked(&ctx->ctx_lock);
+
 	if (list_empty(&iocb->ki_run_list)) {
 		list_add_tail(&iocb->ki_run_list,
 			&ctx->run_list);
@@ -771,13 +774,15 @@
  * 	Process all pending retries queued on the ioctx
  * 	run list.
  * Assumes it is operating within the aio issuer's mm
- * context. Expects to be called with ctx->ctx_lock held
+ * context.
  */
 static int __aio_run_iocbs(struct kioctx *ctx)
 {
 	struct kiocb *iocb;
 	LIST_HEAD(run_list);
 
+	assert_spin_locked(&ctx->ctx_lock);
+
 	list_splice_init(&ctx->run_list, &run_list);
 	while (!list_empty(&run_list)) {
 		iocb = list_entry(run_list.next, struct kiocb,
@@ -1604,12 +1609,14 @@
 
 /* lookup_kiocb
  *	Finds a given iocb for cancellation.
- *	MUST be called with ctx->ctx_lock held.
  */
 static struct kiocb *lookup_kiocb(struct kioctx *ctx, struct iocb __user *iocb,
 				  u32 key)
 {
 	struct list_head *pos;
+
+	assert_spin_locked(&ctx->ctx_lock);
+
 	/* TODO: use a hash or array, this sucks. */
 	list_for_each(pos, &ctx->active_reqs) {
 		struct kiocb *kiocb = list_kiocb(pos);
