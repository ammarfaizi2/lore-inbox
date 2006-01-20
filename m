Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbWATVQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbWATVQu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 16:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbWATVQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 16:16:50 -0500
Received: from mx1.redhat.com ([66.187.233.31]:21983 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932203AbWATVQt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 16:16:49 -0500
Date: Fri, 20 Jan 2006 21:16:38 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, "Jun'ichi Nick Nomura" <jnomura@redhat.com>
Subject: [PATCH 5/9] device-mapper disk statistics: timing
Message-ID: <20060120211638.GF4724@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Jun'ichi Nick Nomura <jnomura@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Jun'ichi \"Nick\" Nomura" <jnomura@redhat.com>

Record I/O timing statistics

The start time is added to struct dm_io, an existing structure 
allocated privately internally within dm and attached to each 
incoming bio.

We export disk_round_stats() from block/ll_rw_blk.c instead of
creating a private clone.

Signed-Off-By: "Jun'ichi \"Nick\" Nomura" <jnomura@redhat.com>
Signed-Off-By: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.16-rc1/drivers/md/dm.c
===================================================================
--- linux-2.6.16-rc1.orig/drivers/md/dm.c	2006-01-20 20:17:48.000000000 +0000
+++ linux-2.6.16-rc1/drivers/md/dm.c	2006-01-20 20:18:15.000000000 +0000
@@ -31,6 +31,7 @@ struct dm_io {
 	int error;
 	struct bio *bio;
 	atomic_t io_count;
+	unsigned long start_time;
 };
 
 /*
@@ -244,6 +245,36 @@ static inline void free_tio(struct mappe
 	mempool_free(tio, md->tio_pool);
 }
 
+static void start_io_acct(struct dm_io *io)
+{
+	struct mapped_device *md = io->md;
+
+	io->start_time = jiffies;
+
+	preempt_disable();
+	disk_round_stats(dm_disk(md));
+	preempt_enable();
+	dm_disk(md)->in_flight = atomic_inc_return(&md->pending);
+}
+
+static int end_io_acct(struct dm_io *io)
+{
+	struct mapped_device *md = io->md;
+	struct bio *bio = io->bio;
+	unsigned long duration = jiffies - io->start_time;
+	int pending;
+	int rw = bio_data_dir(bio);
+
+	preempt_disable();
+	disk_round_stats(dm_disk(md));
+	preempt_enable();
+	dm_disk(md)->in_flight = pending = atomic_dec_return(&md->pending);
+
+	disk_stat_add(dm_disk(md), ticks[rw], duration);
+
+	return !pending;
+}
+
 /*
  * Add the bio to the list of deferred io.
  */
@@ -299,7 +330,7 @@ static void dec_pending(struct dm_io *io
 		io->error = error;
 
 	if (atomic_dec_and_test(&io->io_count)) {
-		if (atomic_dec_and_test(&io->md->pending))
+		if (end_io_acct(io))
 			/* nudge anyone waiting on suspend queue */
 			wake_up(&io->md->wait);
 
@@ -554,7 +585,7 @@ static void __split_bio(struct mapped_de
 	ci.sector_count = bio_sectors(bio);
 	ci.idx = bio->bi_idx;
 
-	atomic_inc(&md->pending);
+	start_io_acct(ci.io);
 	while (ci.sector_count)
 		__clone_and_map(&ci);
 
Index: linux-2.6.16-rc1/block/ll_rw_blk.c
===================================================================
--- linux-2.6.16-rc1.orig/block/ll_rw_blk.c	2006-01-20 18:41:11.000000000 +0000
+++ linux-2.6.16-rc1/block/ll_rw_blk.c	2006-01-20 20:18:07.000000000 +0000
@@ -2577,6 +2577,8 @@ void disk_round_stats(struct gendisk *di
 	disk->stamp = now;
 }
 
+EXPORT_SYMBOL_GPL(disk_round_stats);
+
 /*
  * queue lock must be held
  */
