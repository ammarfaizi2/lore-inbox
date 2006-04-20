Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbWDTTuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbWDTTuK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 15:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbWDTTuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 15:50:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5348 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751173AbWDTTuI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 15:50:08 -0400
Date: Thu, 20 Apr 2006 12:48:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alasdair G Kergon <agk@redhat.com>
Cc: linux-kernel@vger.kernel.org, Juergen Kreileder <jk@blackdown.de>
Subject: Re: BUG at drivers/md/kcopyd.c:146 (was: [PATCH 1/9] device-mapper
 snapshot: load metadata on creation)
Message-Id: <20060420124852.17dc7417.akpm@osdl.org>
In-Reply-To: <20060420170535.GA24524@agk.surrey.redhat.com>
References: <20060120211116.GB4724@agk.surrey.redhat.com>
	<87odz3f5m0.fsf@blackdown.de>
	<20060420170535.GA24524@agk.surrey.redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(restored Juergen's cc)

Alasdair G Kergon <agk@redhat.com> wrote:
>
> On Sat, Apr 15, 2006 at 01:19:51PM +0200, Juergen Kreileder wrote:
> > I'm using devmapper 1.02.03 and lvm2 2.02.02 with 2.6.16.2,
> > nevertheless my logical volumes locked up three time when removing
> > snapshots so far.  Twice I got BUG at drivers/md/kcopyd.c:146, the
> > third time logging stopped at the first lvremove.
>  
> > 2.6.15 and earlier kernels in combination with older tools worked fine
> > over the last year.
>  
> I found several bugs in the snapshot code when I reviewed it,
> including (thankfully hard-to-trigger) silent data corruption.
> 
> Patches went into 2.6.17-rc1.  [There's one unfinished patch
> outstanding for a theoretical race that I've only been able to
> reproduce under artificial conditions.]
> 
> > kernel BUG at drivers/md/kcopyd.c:146!
> 
> Probably needs this patch (12th March):
> 
>   dm snapshot: fix kcopyd destructor
> 

Thanks, I've appended a copy here.

Juergen, can you please test this?

Alasdair, what are your thoughts on backporting this to 2.6.16.x?


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
---

 drivers/md/dm-snap.c |    6 +++++-
 drivers/md/kcopyd.c  |   17 ++++++++++++++++-
 2 files changed, 21 insertions(+), 2 deletions(-)

diff -puN drivers/md/dm-snap.c~dm-snapshot-fix-kcopyd-destructor drivers/md/dm-snap.c
--- devel/drivers/md/dm-snap.c~dm-snapshot-fix-kcopyd-destructor	2006-03-27 01:10:28.000000000 -0800
+++ devel-akpm/drivers/md/dm-snap.c	2006-03-27 01:10:28.000000000 -0800
@@ -559,8 +559,12 @@ static void snapshot_dtr(struct dm_targe
 {
 	struct dm_snapshot *s = (struct dm_snapshot *) ti->private;
 
+	/* Prevent further origin writes from using this snapshot. */
+	/* After this returns there can be no new kcopyd jobs. */
 	unregister_snapshot(s);
 
+	kcopyd_client_destroy(s->kcopyd_client);
+
 	exit_exception_table(&s->pending, pending_cache);
 	exit_exception_table(&s->complete, exception_cache);
 
@@ -569,7 +573,7 @@ static void snapshot_dtr(struct dm_targe
 
 	dm_put_device(ti, s->origin);
 	dm_put_device(ti, s->cow);
-	kcopyd_client_destroy(s->kcopyd_client);
+
 	kfree(s);
 }
 
diff -puN drivers/md/kcopyd.c~dm-snapshot-fix-kcopyd-destructor drivers/md/kcopyd.c
--- devel/drivers/md/kcopyd.c~dm-snapshot-fix-kcopyd-destructor	2006-03-27 01:10:28.000000000 -0800
+++ devel-akpm/drivers/md/kcopyd.c	2006-03-27 01:10:28.000000000 -0800
@@ -44,6 +44,9 @@ struct kcopyd_client {
 	struct page_list *pages;
 	unsigned int nr_pages;
 	unsigned int nr_free_pages;
+
+	wait_queue_head_t destroyq;
+	atomic_t nr_jobs;
 };
 
 static struct page_list *alloc_pl(void)
@@ -292,10 +295,15 @@ static int run_complete_job(struct kcopy
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
 
@@ -430,6 +438,7 @@ static void do_work(void *ignored)
  */
 static void dispatch_job(struct kcopyd_job *job)
 {
+	atomic_inc(&job->kc->nr_jobs);
 	push(&_pages_jobs, job);
 	wake();
 }
@@ -669,6 +678,9 @@ int kcopyd_client_create(unsigned int nr
 		return r;
 	}
 
+	init_waitqueue_head(&kc->destroyq);
+	atomic_set(&kc->nr_jobs, 0);
+
 	client_add(kc);
 	*result = kc;
 	return 0;
@@ -676,6 +688,9 @@ int kcopyd_client_create(unsigned int nr
 
 void kcopyd_client_destroy(struct kcopyd_client *kc)
 {
+	/* Wait for completion of all jobs submitted by this client. */
+	wait_event(kc->destroyq, !atomic_read(&kc->nr_jobs));
+
 	dm_io_put(kc->nr_pages);
 	client_free_pages(kc);
 	client_del(kc);
_

