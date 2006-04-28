Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751828AbWD1AVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751828AbWD1AVt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 20:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751827AbWD1AV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 20:21:26 -0400
Received: from ns.suse.de ([195.135.220.2]:47065 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751732AbWD1AVP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 20:21:15 -0400
Date: Thu, 27 Apr 2006 17:19:36 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Alasdair G Kergon <agk@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 12/24] dm snapshot: fix kcopyd destructor
Message-ID: <20060428001936.GM18750@kroah.com>
References: <20060428001226.204293000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="dm-snapshot-fix-kcopyd-destructor.patch"
In-Reply-To: <20060428001557.GA18750@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

From: Alasdair G Kergon <agk@redhat.com>

Before removing a snapshot, wait for the completion of any kcopyd jobs using
it.

Do this by maintaining a count (nr_jobs) of how many outstanding jobs each
kcopyd_client has.

The snapshot destructor first unregisters the snapshot so that no new kcopyd
jobs (created by writes to the origin) will reference that particular
snapshot.  kcopyd_client_destroy() is now run next to wait for the completion
of any outstanding jobs before the snapshot exception structures (that those
jobs reference) are freed.

Signed-off-by: Alasdair G Kergon <agk@redhat.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/md/dm-snap.c |    6 +++++-
 drivers/md/kcopyd.c  |   17 ++++++++++++++++-
 2 files changed, 21 insertions(+), 2 deletions(-)

--- linux-2.6.16.11.orig/drivers/md/dm-snap.c
+++ linux-2.6.16.11/drivers/md/dm-snap.c
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
 
--- linux-2.6.16.11.orig/drivers/md/kcopyd.c
+++ linux-2.6.16.11/drivers/md/kcopyd.c
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

--
