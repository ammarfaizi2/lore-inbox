Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262605AbUFNSN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262605AbUFNSN4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 14:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263709AbUFNSN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 14:13:56 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:18102 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262605AbUFNSNt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 14:13:49 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] DM 1/5: Create/destroy kcopyd on demand.
Date: Mon, 14 Jun 2004 13:16:41 +0000
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200406141309.31127.kevcorry@us.ibm.com>
In-Reply-To: <200406141309.31127.kevcorry@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406141316.41558.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Create/destroy kcopyd on demand.

This changes kcopyd to initialize its mempool and workqueue only when a
client specifically needs to use it.

Signed-off-by: Kevin Corry <kevcorry@us.ibm.com>

--- diff/drivers/md/dm.c	2004-06-14 11:55:59.695988952 +0000
+++ source/drivers/md/dm.c	2004-06-14 11:56:22.879464528 +0000
@@ -153,7 +153,6 @@
 	xx(dm_target)
 	xx(dm_linear)
 	xx(dm_stripe)
-	xx(kcopyd)
 	xx(dm_interface)
 #undef xx
 };
--- diff/drivers/md/dm.h	2004-06-14 11:55:59.696988800 +0000
+++ source/drivers/md/dm.h	2004-06-14 11:56:22.880464376 +0000
@@ -178,9 +178,6 @@
 int dm_stripe_init(void);
 void dm_stripe_exit(void);
 
-int kcopyd_init(void);
-void kcopyd_exit(void);
-
 void *dm_vcalloc(unsigned long nmemb, unsigned long elem_size);
 
 #endif
--- diff/drivers/md/kcopyd.c	2004-06-14 11:55:59.697988648 +0000
+++ source/drivers/md/kcopyd.c	2004-06-14 11:56:30.599290936 +0000
@@ -220,7 +220,7 @@
 static LIST_HEAD(_io_jobs);
 static LIST_HEAD(_pages_jobs);
 
-static int __init jobs_init(void)
+static int jobs_init(void)
 {
 	_job_cache = kmem_cache_create("kcopyd-jobs",
 				       sizeof(struct kcopyd_job),
@@ -247,6 +247,8 @@
 
 	mempool_destroy(_job_pool);
 	kmem_cache_destroy(_job_cache);
+	_job_pool = NULL;
+	_job_cache = NULL;
 }
 
 /*
@@ -589,14 +591,67 @@
 	up(&_client_lock);
 }
 
+static DECLARE_MUTEX(kcopyd_init_lock);
+static int kcopyd_clients = 0;
+
+static int kcopyd_init(void)
+{
+	int r;
+
+	down(&kcopyd_init_lock);
+
+	if (kcopyd_clients) {
+		/* Already initialized. */
+		kcopyd_clients++;
+		up(&kcopyd_init_lock);
+		return 0;
+	}
+
+	r = jobs_init();
+	if (r) {
+		up(&kcopyd_init_lock);
+		return r;
+	}
+
+	_kcopyd_wq = create_singlethread_workqueue("kcopyd");
+	if (!_kcopyd_wq) {
+		jobs_exit();
+		up(&kcopyd_init_lock);
+		return -ENOMEM;
+	}
+
+	kcopyd_clients++;
+	INIT_WORK(&_kcopyd_work, do_work, NULL);
+	up(&kcopyd_init_lock);
+	return 0;
+}
+
+static void kcopyd_exit(void)
+{
+	down(&kcopyd_init_lock);
+	kcopyd_clients--;
+	if (!kcopyd_clients) {
+		jobs_exit();
+		destroy_workqueue(_kcopyd_wq);
+		_kcopyd_wq = NULL;
+	}
+	up(&kcopyd_init_lock);
+}
+
 int kcopyd_client_create(unsigned int nr_pages, struct kcopyd_client **result)
 {
 	int r = 0;
 	struct kcopyd_client *kc;
 
+	r = kcopyd_init();
+	if (r)
+		return r;
+
 	kc = kmalloc(sizeof(*kc), GFP_KERNEL);
-	if (!kc)
+	if (!kc) {
+		kcopyd_exit();
 		return -ENOMEM;
+	}
 
 	kc->lock = SPIN_LOCK_UNLOCKED;
 	kc->pages = NULL;
@@ -604,6 +659,7 @@
 	r = client_alloc_pages(kc, nr_pages);
 	if (r) {
 		kfree(kc);
+		kcopyd_exit();
 		return r;
 	}
 
@@ -611,6 +667,7 @@
 	if (r) {
 		client_free_pages(kc);
 		kfree(kc);
+		kcopyd_exit();
 		return r;
 	}
 
@@ -619,6 +676,7 @@
 		dm_io_put(nr_pages);
 		client_free_pages(kc);
 		kfree(kc);
+		kcopyd_exit();
 		return r;
 	}
 
@@ -632,31 +690,7 @@
 	client_free_pages(kc);
 	client_del(kc);
 	kfree(kc);
-}
-
-
-int __init kcopyd_init(void)
-{
-	int r;
-
-	r = jobs_init();
-	if (r)
-		return r;
-
-	_kcopyd_wq = create_singlethread_workqueue("kcopyd");
-	if (!_kcopyd_wq) {
-		jobs_exit();
-		return -ENOMEM;
-	}
-
-	INIT_WORK(&_kcopyd_work, do_work, NULL);
-	return 0;
-}
-
-void kcopyd_exit(void)
-{
-	jobs_exit();
-	destroy_workqueue(_kcopyd_wq);
+	kcopyd_exit();
 }
 
 EXPORT_SYMBOL(kcopyd_client_create);
--- diff/drivers/md/kcopyd.h	2004-06-14 11:55:59.697988648 +0000
+++ source/drivers/md/kcopyd.h	2004-06-14 11:56:22.882464072 +0000
@@ -13,9 +13,6 @@
 
 #include "dm-io.h"
 
-int kcopyd_init(void);
-void kcopyd_exit(void);
-
 /* FIXME: make this configurable */
 #define KCOPYD_MAX_REGIONS 8
 
