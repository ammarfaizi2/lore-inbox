Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751590AbWH3VGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590AbWH3VGz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 17:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751586AbWH3VGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 17:06:55 -0400
Received: from pat.uio.no ([129.240.10.4]:13780 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751554AbWH3VGy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 17:06:54 -0400
Subject: Re: [PATCH 19/19] BLOCK: Make it possible to disable the block
	layer [try #6]
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, axboe@kernel.dk,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060830124400.23ca9b38.akpm@osdl.org>
References: <20060829180552.32596.15290.stgit@warthog.cambridge.redhat.com>
	 <20060829180634.32596.4507.stgit@warthog.cambridge.redhat.com>
	 <20060830124400.23ca9b38.akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-ZLM9HMBE4eGvHtSP6ugH"
Date: Wed, 30 Aug 2006 17:06:39 -0400
Message-Id: <1156971999.5787.12.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.182, required 12,
	autolearn=disabled, AWL 1.82, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ZLM9HMBE4eGvHtSP6ugH
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2006-08-30 at 12:44 -0700, Andrew Morton wrote:
> I think I'll just slam all this in at the first opportunity.  Stuff will
> break, but it will be easy to fix.
> 
> If you try to upissue this patchset I shall be seeking an IP-routable hand
> grenade.
> 
> On Tue, 29 Aug 2006 19:06:34 +0100
> David Howells <dhowells@redhat.com> wrote:
> 
> > +static inline long blk_congestion_wait(int rw, long timeout)
> > +{
> > +	return timeout;
> > +}
> 
> This function is misnamed and is implemented in the wrong place.  It's not
> really a block thing at all.  If/when/soon NFS starts to implement it and
> call it, things will need to be renamed and reshuffled.

Already done in the NFS git tree. See attached patch.



--=-ZLM9HMBE4eGvHtSP6ugH
Content-Disposition: inline; filename=linux-2.6.18-052-add_fixes_for_the_congestion_wait_crap.dif
Content-Type: message/rfc822; name=linux-2.6.18-052-add_fixes_for_the_congestion_wait_crap.dif

From: Trond Myklebust <Trond.Myklebust@netapp.com>
Date: Mon, 28 Aug 2006 08:15:59 -0400
Subject: No Subject
Message-Id: <1156971983.5787.11.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 block/ll_rw_blk.c         |   12 ++++++++++++
 fs/nfs/write.c            |    1 +
 include/linux/blkdev.h    |    1 +
 include/linux/writeback.h |    1 +
 mm/page-writeback.c       |    9 +++++++++
 5 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/block/ll_rw_blk.c b/block/ll_rw_blk.c
index ddd9253..dcbd6ff 100644
--- a/block/ll_rw_blk.c
+++ b/block/ll_rw_blk.c
@@ -2734,6 +2734,18 @@ long blk_congestion_wait(int rw, long ti
 
 EXPORT_SYMBOL(blk_congestion_wait);
 
+/**
+ * blk_congestion_end - wake up sleepers on a congestion queue
+ * @rw: READ or WRITE
+ */
+void blk_congestion_end(int rw)
+{
+	wait_queue_head_t *wqh = &congestion_wqh[rw];
+
+	if (waitqueue_active(wqh))
+		wake_up(wqh);
+}
+
 /*
  * Has to be called with the request spinlock acquired
  */
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 7bc500b..1f7a6d4 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -403,6 +403,7 @@ int nfs_writepages(struct address_space 
 out:
 	clear_bit(BDI_write_congested, &bdi->state);
 	wake_up_all(&nfs_write_congestion);
+	writeback_congestion_end();
 	return err;
 }
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index aafe827..96c9040 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -746,6 +746,7 @@ extern void blk_queue_free_tags(request_
 extern int blk_queue_resize_tags(request_queue_t *, int);
 extern void blk_queue_invalidate_tags(request_queue_t *);
 extern long blk_congestion_wait(int rw, long timeout);
+extern void blk_congestion_end(int rw);
 
 extern void blk_rq_bio_prep(request_queue_t *, struct request *, struct bio *);
 extern int blkdev_issue_flush(struct block_device *, sector_t *);
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 9e38b56..0422036 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -85,6 +85,7 @@ int wakeup_pdflush(long nr_pages);
 void laptop_io_completion(void);
 void laptop_sync_completion(void);
 void throttle_vm_writeout(void);
+void writeback_congestion_end(void);
 
 /* These are exported to sysctl. */
 extern int dirty_background_ratio;
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index e630188..77a0bc4 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -803,6 +803,15 @@ int test_set_page_writeback(struct page 
 EXPORT_SYMBOL(test_set_page_writeback);
 
 /*
+ * Wakes up tasks that are being throttled due to writeback congestion
+ */
+void writeback_congestion_end(void)
+{
+	blk_congestion_end(WRITE);
+}
+EXPORT_SYMBOL(writeback_congestion_end);
+
+/*
  * Return true if any of the pages in the mapping are marged with the
  * passed tag.
  */

--=-ZLM9HMBE4eGvHtSP6ugH--

