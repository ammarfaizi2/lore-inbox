Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751177AbWINVpp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbWINVpp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 17:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbWINVpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 17:45:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39382 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751177AbWINVpo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 17:45:44 -0400
Date: Thu, 14 Sep 2006 22:45:34 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Mark McLoughlin <markmc@redhat.com>
Subject: [PATCH 11/25] dm snapshot: fix freeing pending exception
Message-ID: <20060914214534.GS3928@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Mark McLoughlin <markmc@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If a snapshot became invalid while there are outstanding pending_exceptions,
when pending_complete() processes each one it forgets to remove the
corresponding exception from its exception table before freeing it.

Fix this by moving the 'out:' label up one statement so that
remove_exception() is always called.  Then __invalidate_exception() no
longer needs to call it and its 'pe' argument become superfluous.

Signed-off-by: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.18-rc7/drivers/md/dm-snap.c
===================================================================
--- linux-2.6.18-rc7.orig/drivers/md/dm-snap.c	2006-09-14 20:20:11.000000000 +0100
+++ linux-2.6.18-rc7/drivers/md/dm-snap.c	2006-09-14 20:20:12.000000000 +0100
@@ -631,8 +631,7 @@ static void error_bios(struct bio *bio)
 	}
 }
 
-static void __invalidate_snapshot(struct dm_snapshot *s,
-				struct pending_exception *pe, int err)
+static void __invalidate_snapshot(struct dm_snapshot *s, int err)
 {
 	if (!s->valid)
 		return;
@@ -642,9 +641,6 @@ static void __invalidate_snapshot(struct
 	else if (err == -ENOMEM)
 		DMERR("Invalidating snapshot: Unable to allocate exception.");
 
-	if (pe)
-		remove_exception(&pe->e);
-
 	if (s->store.drop_snapshot)
 		s->store.drop_snapshot(&s->store);
 
@@ -701,7 +697,7 @@ static void pending_complete(struct pend
 	if (!success) {
 		/* Read/write error - snapshot is unusable */
 		down_write(&s->lock);
-		__invalidate_snapshot(s, pe, -EIO);
+		__invalidate_snapshot(s, -EIO);
 		error = 1;
 		goto out;
 	}
@@ -709,7 +705,7 @@ static void pending_complete(struct pend
 	e = alloc_exception();
 	if (!e) {
 		down_write(&s->lock);
-		__invalidate_snapshot(s, pe, -ENOMEM);
+		__invalidate_snapshot(s, -ENOMEM);
 		error = 1;
 		goto out;
 	}
@@ -727,9 +723,9 @@ static void pending_complete(struct pend
 	 * in-flight exception from the list.
 	 */
 	insert_exception(&s->complete, e);
-	remove_exception(&pe->e);
 
  out:
+	remove_exception(&pe->e);
 	snapshot_bios = bio_list_get(&pe->snapshot_bios);
 	origin_bios = put_pending_exception(pe);
 
@@ -909,7 +905,7 @@ static int snapshot_map(struct dm_target
 	if (bio_rw(bio) == WRITE) {
 		pe = __find_pending_exception(s, bio);
 		if (!pe) {
-			__invalidate_snapshot(s, pe, -ENOMEM);
+			__invalidate_snapshot(s, -ENOMEM);
 			r = -EIO;
 			goto out_unlock;
 		}
@@ -1035,7 +1031,7 @@ static int __origin_write(struct list_he
 
 		pe = __find_pending_exception(snap, bio);
 		if (!pe) {
-			__invalidate_snapshot(snap, pe, -ENOMEM);
+			__invalidate_snapshot(snap, -ENOMEM);
 			goto next_snapshot;
 		}
 
