Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751245AbWCLWji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbWCLWji (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 17:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbWCLWjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 17:39:37 -0500
Received: from mx1.redhat.com ([66.187.233.31]:49575 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751245AbWCLWjh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 17:39:37 -0500
Date: Sun, 12 Mar 2006 22:39:25 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] dm snapshot: fix kcopyd destructor
Message-ID: <20060312223925.GC4724@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Before removing a snapshot, wait for the completion of any kcopyd jobs
using it.

Do this by maintaining a count (nr_jobs) of how many outstanding jobs
each kcopyd_client has.

The snapshot destructor first unregisters the snapshot so that no
new kcopyd jobs (created by writes to the origin) will reference 
that particular snapshot.   kcopyd_client_destroy() is now run next
to wait for the completion of any outstanding jobs before the snapshot
exception structures (that those jobs reference) are freed.

Signed-Off-By: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.16-rc5/drivers/md/kcopyd.c
===================================================================
--- linux-2.6.16-rc5.orig/drivers/md/kcopyd.c	2006-03-12 21:57:03.000000000 +0000
+++ linux-2.6.16-rc5/drivers/md/kcopyd.c	2006-03-12 21:57:56.000000000 +0000
@@ -44,6 +44,9 @@ struct kcopyd_client {
 	struct page_list *pages;
 	unsigned int nr_pages;
 	unsigned int nr_free_pages;
+
+	wait_queue_head_t destroyq;
+	atomic_t nr_jobs;
 };
 
 static struct page_list *alloc_pl(void)
@@ -293,10 +296,15 @@ static int run_complete_job(struct kcopy
 	int read_err = job->read_err;
 	unsigned int write_err = job->write_err;
 	kcopyd_notify_fn fn = job->fn;
+	struct kcopyd_client *kc = job->kc;
 
-	kcopyd_put_pages(job->kc, job->pages);
+	kcopyd_put_pages(kc, job->pages);
 	mempool_free(job, _job_pool);
 	fn(read_err, write_err, context);
+
+	if (atomic_dec_and_test(&kc->nr_jobs))
+		wake_up(&kc->destroyq);
+
 	return 0;
 }
 
@@ -431,6 +439,7 @@ static void do_work(void *ignored)
  */
 static void dispatch_job(struct kcopyd_job *job)
 {
+	atomic_inc(&job->kc->nr_jobs);
 	push(&_pages_jobs, job);
 	wake();
 }
@@ -670,6 +679,9 @@ int kcopyd_client_create(unsigned int nr
 		return r;
 	}
 
+	init_waitqueue_head(&kc->destroyq);
+	atomic_set(&kc->nr_jobs, 0);
+
 	client_add(kc);
 	*result = kc;
 	return 0;
@@ -677,6 +689,9 @@ int kcopyd_client_create(unsigned int nr
 
 void kcopyd_client_destroy(struct kcopyd_client *kc)
 {
+	/* Wait for completion of all jobs submitted by this client. */
+	wait_event(kc->destroyq, !atomic_read(&kc->nr_jobs));
+
 	dm_io_put(kc->nr_pages);
 	client_free_pages(kc);
 	client_del(kc);
Index: linux-2.6.16-rc5/drivers/md/dm-snap.c
===================================================================
--- linux-2.6.16-rc5.orig/drivers/md/dm-snap.c	2006-03-12 21:57:04.000000000 +0000
+++ linux-2.6.16-rc5/drivers/md/dm-snap.c	2006-03-12 21:57:56.000000000 +0000
@@ -542,8 +542,12 @@ static void snapshot_dtr(struct dm_targe
 {
 	struct dm_snapshot *s = (struct dm_snapshot *) ti->private;
 
+	/* Prevent further origin writes from using this snapshot. */
+	/* After this returns there can be no new kcopyd jobs. */
 	unregister_snapshot(s);
 
+	kcopyd_client_destroy(s->kcopyd_client);
+
 	exit_exception_table(&s->pending, pending_cache);
 	exit_exception_table(&s->complete, exception_cache);
 
@@ -552,7 +556,7 @@ static void snapshot_dtr(struct dm_targe
 
 	dm_put_device(ti, s->origin);
 	dm_put_device(ti, s->cow);
-	kcopyd_client_destroy(s->kcopyd_client);
+
 	kfree(s);
 }
 
