Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751166AbWINVlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbWINVlK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 17:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbWINVlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 17:41:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7892 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751166AbWINVlI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 17:41:08 -0400
Date: Thu, 14 Sep 2006 22:41:03 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Mark McLoughlin <markmc@redhat.com>
Subject: [PATCH 07/25] dm snapshot: tidy snapshot_map
Message-ID: <20060914214103.GO3928@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Mark McLoughlin <markmc@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch rearranges the snapshot_map code so that the functional
changes in subsequent patches are clearer.
 
The only functional change is to replace the existing read lock with
a write lock which the next patch needs.

Signed-off-by: Alasdair G Kergon <agk@redhat.com>
 
Index: linux-2.6.18-rc7/drivers/md/dm-snap.c
===================================================================
--- linux-2.6.18-rc7.orig/drivers/md/dm-snap.c	2006-09-14 20:38:50.000000000 +0100
+++ linux-2.6.18-rc7/drivers/md/dm-snap.c	2006-09-14 20:39:55.000000000 +0100
@@ -851,7 +851,6 @@ static int snapshot_map(struct dm_target
 {
 	struct exception *e;
 	struct dm_snapshot *s = (struct dm_snapshot *) ti->private;
-	int copy_needed = 0;
 	int r = 1;
 	chunk_t chunk;
 	struct pending_exception *pe = NULL;
@@ -866,29 +865,28 @@ static int snapshot_map(struct dm_target
 	if (unlikely(bio_barrier(bio)))
 		return -EOPNOTSUPP;
 
+	/* FIXME: should only take write lock if we need
+	 * to copy an exception */
+	down_write(&s->lock);
+
+	if (!s->valid) {
+		r = -EIO;
+		goto out_unlock;
+	}
+
+	/* If the block is already remapped - use that, else remap it */
+	e = lookup_exception(&s->complete, chunk);
+	if (e) {
+		remap_exception(s, e, bio);
+		goto out_unlock;
+	}
+
 	/*
 	 * Write to snapshot - higher level takes care of RW/RO
 	 * flags so we should only get this if we are
 	 * writeable.
 	 */
 	if (bio_rw(bio) == WRITE) {
-
-		/* FIXME: should only take write lock if we need
-		 * to copy an exception */
-		down_write(&s->lock);
-
-		if (!s->valid) {
-			r = -EIO;
-			goto out_unlock;
-		}
-
-		/* If the block is already remapped - use that, else remap it */
-		e = lookup_exception(&s->complete, chunk);
-		if (e) {
-			remap_exception(s, e, bio);
-			goto out_unlock;
-		}
-
 		pe = __find_pending_exception(s, bio);
 		if (!pe) {
 			__invalidate_snapshot(s, pe, -ENOMEM);
@@ -899,45 +897,27 @@ static int snapshot_map(struct dm_target
 		remap_exception(s, &pe->e, bio);
 		bio_list_add(&pe->snapshot_bios, bio);
 
+		r = 0;
+
 		if (!pe->started) {
 			/* this is protected by snap->lock */
 			pe->started = 1;
-			copy_needed = 1;
-		}
-
-		r = 0;
-
- out_unlock:
-		up_write(&s->lock);
-
-		if (copy_needed)
+			up_write(&s->lock);
 			start_copy(pe);
-	} else {
+			goto out;
+		}
+	} else
 		/*
 		 * FIXME: this read path scares me because we
 		 * always use the origin when we have a pending
 		 * exception.  However I can't think of a
 		 * situation where this is wrong - ejt.
 		 */
+		bio->bi_bdev = s->origin->bdev;
 
-		/* Do reads */
-		down_read(&s->lock);
-
-		if (!s->valid) {
-			up_read(&s->lock);
-			return -EIO;
-		}
-
-		/* See if it it has been remapped */
-		e = lookup_exception(&s->complete, chunk);
-		if (e)
-			remap_exception(s, e, bio);
-		else
-			bio->bi_bdev = s->origin->bdev;
-
-		up_read(&s->lock);
-	}
-
+ out_unlock:
+	up_write(&s->lock);
+ out:
 	return r;
 }
 
