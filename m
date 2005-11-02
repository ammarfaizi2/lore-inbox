Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751457AbVKBAEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbVKBAEM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 19:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbVKBAEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 19:04:12 -0500
Received: from tetsuo.zabbo.net ([207.173.201.20]:5332 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S1751457AbVKBAEL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 19:04:11 -0500
From: Zach Brown <zach.brown@oracle.com>
To: linux-kernel@vger.kernel.org, linux-aio@kvack.org
Cc: Andrew Morton <akpm@osdl.org>, Benjamin LaHaise <bcrl@kvack.org>
Message-Id: <20051102000353.24002.51261.sendpatchset@tetsuo.zabbo.net>
Subject: [Patch] [AIO] remove aio_max_nr accounting race
Date: Tue,  1 Nov 2005 16:03:53 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[AIO] remove aio_max_nr accounting race

AIO was adding a new context's max requests to the global total before testing
if that resulting total was over the global limit.  This let innocent tasks get
their new limit tested along with a racing guilty task that was crossing the
limit.  This serializes the _nr accounting with a spinlock It also switches to
using unsigned long for the global totals.  Individual contexts are still
limited to an unsigned int's worth of requests by the syscall interface.

The problem and fix were verified with a simple program that spun creating and
destroying a context while holding on to another long lived context.  Before
the patch a task creating a tiny context could get a spurious EAGAIN if it
raced with a task creating a very large context that overran the limit.

  Signed-off-by: Zach Brown <zach.brown@oracle.com>
---

 fs/aio.c            |   31 +++++++++++++++++++++----------
 include/linux/aio.h |    5 +++--
 kernel/sysctl.c     |    4 ++--
 3 files changed, 26 insertions(+), 14 deletions(-)

Index: 2.6.14-git4-aio-max-nr/fs/aio.c
===================================================================
--- 2.6.14-git4-aio-max-nr.orig/fs/aio.c	2005-11-01 14:27:25.000000000 -0800
+++ 2.6.14-git4-aio-max-nr/fs/aio.c	2005-11-01 15:38:51.633061132 -0800
@@ -42,8 +42,9 @@
 #endif
 
 /*------ sysctl variables----*/
-atomic_t aio_nr = ATOMIC_INIT(0);	/* current system wide number of aio requests */
-unsigned aio_max_nr = 0x10000;	/* system wide maximum number of aio requests */
+static DEFINE_SPINLOCK(aio_nr_lock);
+unsigned long aio_nr;		/* current system wide number of aio requests */
+unsigned long aio_max_nr = 0x10000; /* system wide maximum number of aio requests */
 /*----end sysctl variables---*/
 
 static kmem_cache_t	*kiocb_cachep;
@@ -208,7 +209,7 @@
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (nr_events > aio_max_nr)
+	if ((unsigned long)nr_events > aio_max_nr)
 		return ERR_PTR(-EAGAIN);
 
 	ctx = kmem_cache_alloc(kioctx_cachep, GFP_KERNEL);
@@ -233,8 +234,14 @@
 		goto out_freectx;
 
 	/* limit the number of system wide aios */
-	atomic_add(ctx->max_reqs, &aio_nr);	/* undone by __put_ioctx */
-	if (unlikely(atomic_read(&aio_nr) > aio_max_nr))
+	spin_lock(&aio_nr_lock);
+	if (aio_nr + ctx->max_reqs > aio_max_nr ||
+	    aio_nr + ctx->max_reqs < aio_nr)
+		ctx->max_reqs = 0;
+	else
+		aio_nr += ctx->max_reqs;
+	spin_unlock(&aio_nr_lock);
+	if (ctx->max_reqs == 0)
 		goto out_cleanup;
 
 	/* now link into global list.  kludge.  FIXME */
@@ -248,8 +255,6 @@
 	return ctx;
 
 out_cleanup:
-	atomic_sub(ctx->max_reqs, &aio_nr);
-	ctx->max_reqs = 0;	/* prevent __put_ioctx from sub'ing aio_nr */
 	__put_ioctx(ctx);
 	return ERR_PTR(-EAGAIN);
 
@@ -374,7 +379,12 @@
 	pr_debug("__put_ioctx: freeing %p\n", ctx);
 	kmem_cache_free(kioctx_cachep, ctx);
 
-	atomic_sub(nr_events, &aio_nr);
+	if (nr_events) {
+		spin_lock(&aio_nr_lock);
+		BUG_ON(aio_nr - nr_events > aio_nr);
+		aio_nr -= nr_events;
+		spin_unlock(&aio_nr_lock);
+	}
 }
 
 /* aio_get_req
@@ -1258,8 +1268,9 @@
 		goto out;
 
 	ret = -EINVAL;
-	if (unlikely(ctx || (int)nr_events <= 0)) {
-		pr_debug("EINVAL: io_setup: ctx or nr_events > max\n");
+	if (unlikely(ctx || nr_events == 0)) {
+		pr_debug("EINVAL: io_setup: ctx %lu nr_events %u\n",
+		         ctx, nr_events);
 		goto out;
 	}
 
Index: 2.6.14-git4-aio-max-nr/include/linux/aio.h
===================================================================
--- 2.6.14-git4-aio-max-nr.orig/include/linux/aio.h	2005-11-01 14:27:27.000000000 -0800
+++ 2.6.14-git4-aio-max-nr/include/linux/aio.h	2005-11-01 15:12:19.918272654 -0800
@@ -183,6 +183,7 @@
 	struct list_head	active_reqs;	/* used for cancellation */
 	struct list_head	run_list;	/* used for kicked reqs */
 
+	/* sys_io_setup currently limits this to an unsigned int */
 	unsigned		max_reqs;
 
 	struct aio_ring_info	ring_info;
@@ -234,7 +235,7 @@
 }
 
 /* for sysctl: */
-extern atomic_t aio_nr;
-extern unsigned aio_max_nr;
+extern unsigned long aio_nr;
+extern unsigned long aio_max_nr;
 
 #endif /* __LINUX__AIO_H */
Index: 2.6.14-git4-aio-max-nr/kernel/sysctl.c
===================================================================
--- 2.6.14-git4-aio-max-nr.orig/kernel/sysctl.c	2005-11-01 14:27:27.000000000 -0800
+++ 2.6.14-git4-aio-max-nr/kernel/sysctl.c	2005-11-01 14:48:21.000000000 -0800
@@ -952,7 +952,7 @@
 		.data		= &aio_nr,
 		.maxlen		= sizeof(aio_nr),
 		.mode		= 0444,
-		.proc_handler	= &proc_dointvec,
+		.proc_handler	= &proc_doulongvec_minmax,
 	},
 	{
 		.ctl_name	= FS_AIO_MAX_NR,
@@ -960,7 +960,7 @@
 		.data		= &aio_max_nr,
 		.maxlen		= sizeof(aio_max_nr),
 		.mode		= 0644,
-		.proc_handler	= &proc_dointvec,
+		.proc_handler	= &proc_doulongvec_minmax,
 	},
 #ifdef CONFIG_INOTIFY
 	{

