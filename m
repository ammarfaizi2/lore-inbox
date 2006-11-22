Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756537AbWKVTCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756537AbWKVTCF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 14:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756494AbWKVTCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 14:02:05 -0500
Received: from mx1.redhat.com ([66.187.233.31]:17057 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1756585AbWKVTCB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 14:02:01 -0500
Date: Wed, 22 Nov 2006 19:01:55 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, dm-devel@redhat.com,
       "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>,
       Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
Subject: [PATCH 05/11] dm: map and endio symbolic return codes
Message-ID: <20061122190155.GV6993@agk.surrey.redhat.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, dm-devel@redhat.com,
	Jun'ichi Nomura <j-nomura@ce.jp.nec.com>,
	Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>

This patch updates existing targets to use the new symbols for return values
from target map and end_io functions.

There is no effect on behaviour.

Test results:
Done build test without errors.

Signed-off-by: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>
Signed-off-by: Alasdair G Kergon <agk@redhat.com>
Cc: dm-devel@redhat.com

Index: linux-2.6.19-rc6/drivers/md/dm-crypt.c
===================================================================
--- linux-2.6.19-rc6.orig/drivers/md/dm-crypt.c	2006-11-22 17:26:46.000000000 +0000
+++ linux-2.6.19-rc6/drivers/md/dm-crypt.c	2006-11-22 17:26:58.000000000 +0000
@@ -908,7 +908,7 @@ static int crypt_map(struct dm_target *t
 	atomic_set(&io->pending, 0);
 	kcryptd_queue_io(io);
 
-	return 0;
+	return DM_MAPIO_SUBMITTED;
 }
 
 static int crypt_status(struct dm_target *ti, status_type_t type,
Index: linux-2.6.19-rc6/drivers/md/dm-linear.c
===================================================================
--- linux-2.6.19-rc6.orig/drivers/md/dm-linear.c	2006-11-22 17:26:46.000000000 +0000
+++ linux-2.6.19-rc6/drivers/md/dm-linear.c	2006-11-22 17:26:58.000000000 +0000
@@ -77,7 +77,7 @@ static int linear_map(struct dm_target *
 	bio->bi_bdev = lc->dev->bdev;
 	bio->bi_sector = lc->start + (bio->bi_sector - ti->begin);
 
-	return 1;
+	return DM_MAPIO_REMAPPED;
 }
 
 static int linear_status(struct dm_target *ti, status_type_t type,
Index: linux-2.6.19-rc6/drivers/md/dm-mpath.c
===================================================================
--- linux-2.6.19-rc6.orig/drivers/md/dm-mpath.c	2006-11-22 17:26:46.000000000 +0000
+++ linux-2.6.19-rc6/drivers/md/dm-mpath.c	2006-11-22 17:26:58.000000000 +0000
@@ -285,7 +285,7 @@ failed:
 static int map_io(struct multipath *m, struct bio *bio, struct mpath_io *mpio,
 		  unsigned was_queued)
 {
-	int r = 1;
+	int r = DM_MAPIO_REMAPPED;
 	unsigned long flags;
 	struct pgpath *pgpath;
 
@@ -310,7 +310,7 @@ static int map_io(struct multipath *m, s
 		    !m->queue_io)
 			queue_work(kmultipathd, &m->process_queued_ios);
 		pgpath = NULL;
-		r = 0;
+		r = DM_MAPIO_SUBMITTED;
 	} else if (!pgpath)
 		r = -EIO;		/* Failed */
 	else
@@ -372,7 +372,7 @@ static void dispatch_queued_ios(struct m
 		r = map_io(m, bio, mpio, 1);
 		if (r < 0)
 			bio_endio(bio, bio->bi_size, r);
-		else if (r == 1)
+		else if (r == DM_MAPIO_REMAPPED)
 			generic_make_request(bio);
 
 		bio = next;
@@ -1040,7 +1040,7 @@ static int do_end_io(struct multipath *m
 		queue_work(kmultipathd, &m->process_queued_ios);
 	spin_unlock_irqrestore(&m->lock, flags);
 
-	return 1;	/* io not complete */
+	return DM_ENDIO_INCOMPLETE;	/* io not complete */
 }
 
 static int multipath_end_io(struct dm_target *ti, struct bio *bio,
@@ -1058,7 +1058,7 @@ static int multipath_end_io(struct dm_ta
 		if (ps->type->end_io)
 			ps->type->end_io(ps, &pgpath->path);
 	}
-	if (r <= 0)
+	if (r != DM_ENDIO_INCOMPLETE)
 		mempool_free(mpio, m->mpio_pool);
 
 	return r;
Index: linux-2.6.19-rc6/drivers/md/dm-raid1.c
===================================================================
--- linux-2.6.19-rc6.orig/drivers/md/dm-raid1.c	2006-11-22 17:26:46.000000000 +0000
+++ linux-2.6.19-rc6/drivers/md/dm-raid1.c	2006-11-22 17:26:58.000000000 +0000
@@ -1137,7 +1137,7 @@ static int mirror_map(struct dm_target *
 
 	if (rw == WRITE) {
 		queue_bio(ms, bio, rw);
-		return 0;
+		return DM_MAPIO_SUBMITTED;
 	}
 
 	r = ms->rh.log->type->in_sync(ms->rh.log,
@@ -1146,7 +1146,7 @@ static int mirror_map(struct dm_target *
 		return r;
 
 	if (r == -EWOULDBLOCK)	/* FIXME: ugly */
-		r = 0;
+		r = DM_MAPIO_SUBMITTED;
 
 	/*
 	 * We don't want to fast track a recovery just for a read
@@ -1159,7 +1159,7 @@ static int mirror_map(struct dm_target *
 	if (!r) {
 		/* Pass this io over to the daemon */
 		queue_bio(ms, bio, rw);
-		return 0;
+		return DM_MAPIO_SUBMITTED;
 	}
 
 	m = choose_mirror(ms, bio->bi_sector);
@@ -1167,7 +1167,7 @@ static int mirror_map(struct dm_target *
 		return -EIO;
 
 	map_bio(ms, m, bio);
-	return 1;
+	return DM_MAPIO_REMAPPED;
 }
 
 static int mirror_end_io(struct dm_target *ti, struct bio *bio,
Index: linux-2.6.19-rc6/drivers/md/dm-snap.c
===================================================================
--- linux-2.6.19-rc6.orig/drivers/md/dm-snap.c	2006-11-22 17:26:46.000000000 +0000
+++ linux-2.6.19-rc6/drivers/md/dm-snap.c	2006-11-22 17:26:58.000000000 +0000
@@ -867,7 +867,7 @@ static int snapshot_map(struct dm_target
 {
 	struct exception *e;
 	struct dm_snapshot *s = (struct dm_snapshot *) ti->private;
-	int r = 1;
+	int r = DM_MAPIO_REMAPPED;
 	chunk_t chunk;
 	struct pending_exception *pe = NULL;
 
@@ -913,7 +913,7 @@ static int snapshot_map(struct dm_target
 		remap_exception(s, &pe->e, bio);
 		bio_list_add(&pe->snapshot_bios, bio);
 
-		r = 0;
+		r = DM_MAPIO_SUBMITTED;
 
 		if (!pe->started) {
 			/* this is protected by snap->lock */
@@ -991,7 +991,7 @@ static int snapshot_status(struct dm_tar
  *---------------------------------------------------------------*/
 static int __origin_write(struct list_head *snapshots, struct bio *bio)
 {
-	int r = 1, first = 0;
+	int r = DM_MAPIO_REMAPPED, first = 0;
 	struct dm_snapshot *snap;
 	struct exception *e;
 	struct pending_exception *pe, *next_pe, *primary_pe = NULL;
@@ -1049,7 +1049,7 @@ static int __origin_write(struct list_he
 
 			bio_list_add(&primary_pe->origin_bios, bio);
 
-			r = 0;
+			r = DM_MAPIO_SUBMITTED;
 		}
 
 		if (!pe->primary_pe) {
@@ -1098,7 +1098,7 @@ static int __origin_write(struct list_he
 static int do_origin(struct dm_dev *origin, struct bio *bio)
 {
 	struct origin *o;
-	int r = 1;
+	int r = DM_MAPIO_REMAPPED;
 
 	down_read(&_origins_lock);
 	o = __lookup_origin(origin->bdev);
@@ -1155,7 +1155,7 @@ static int origin_map(struct dm_target *
 		return -EOPNOTSUPP;
 
 	/* Only tell snapshots if this is a write */
-	return (bio_rw(bio) == WRITE) ? do_origin(dev, bio) : 1;
+	return (bio_rw(bio) == WRITE) ? do_origin(dev, bio) : DM_MAPIO_REMAPPED;
 }
 
 #define min_not_zero(l, r) (l == 0) ? r : ((r == 0) ? l : min(l, r))
Index: linux-2.6.19-rc6/drivers/md/dm-stripe.c
===================================================================
--- linux-2.6.19-rc6.orig/drivers/md/dm-stripe.c	2006-11-22 17:26:46.000000000 +0000
+++ linux-2.6.19-rc6/drivers/md/dm-stripe.c	2006-11-22 17:26:58.000000000 +0000
@@ -186,7 +186,7 @@ static int stripe_map(struct dm_target *
 	bio->bi_bdev = sc->stripe[stripe].dev->bdev;
 	bio->bi_sector = sc->stripe[stripe].physical_start +
 	    (chunk << sc->chunk_shift) + (offset & sc->chunk_mask);
-	return 1;
+	return DM_MAPIO_REMAPPED;
 }
 
 static int stripe_status(struct dm_target *ti,
Index: linux-2.6.19-rc6/drivers/md/dm-zero.c
===================================================================
--- linux-2.6.19-rc6.orig/drivers/md/dm-zero.c	2006-11-22 17:26:46.000000000 +0000
+++ linux-2.6.19-rc6/drivers/md/dm-zero.c	2006-11-22 17:26:58.000000000 +0000
@@ -46,7 +46,7 @@ static int zero_map(struct dm_target *ti
 	bio_endio(bio, bio->bi_size, 0);
 
 	/* accepted bio, don't make new request */
-	return 0;
+	return DM_MAPIO_SUBMITTED;
 }
 
 static struct target_type zero_target = {
