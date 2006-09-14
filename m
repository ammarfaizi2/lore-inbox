Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbWINVnw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbWINVnw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 17:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbWINVnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 17:43:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:49621 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751173AbWINVnv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 17:43:51 -0400
Date: Thu, 14 Sep 2006 22:43:40 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Mark McLoughlin <markmc@redhat.com>
Subject: [PATCH 10/25] dm snapshot: tidy pe ref counting
Message-ID: <20060914214340.GR3928@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Mark McLoughlin <markmc@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rename sibling_count to ref_count and introduce get and put functions.

Signed-off-by: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.18-rc7/drivers/md/dm-snap.c
===================================================================
--- linux-2.6.18-rc7.orig/drivers/md/dm-snap.c	2006-09-14 20:44:39.000000000 +0100
+++ linux-2.6.18-rc7/drivers/md/dm-snap.c	2006-09-14 20:47:13.000000000 +0100
@@ -59,7 +59,7 @@ struct pending_exception {
 
 	/*
 	 * The primary pending_exception is the one that holds
-	 * the sibling_count and the list of origin_bios for a
+	 * the ref_count and the list of origin_bios for a
 	 * group of pending_exceptions.  It is always last to get freed.
 	 * These fields get set up when writing to the origin.
 	 */
@@ -72,7 +72,7 @@ struct pending_exception {
 	 * the sibling concerned and not pe->primary_pe->snap->lock unless
 	 * they are the same.
 	 */
-	atomic_t sibling_count;
+	atomic_t ref_count;
 
 	/* Pointer back to snapshot context */
 	struct dm_snapshot *snap;
@@ -653,10 +653,46 @@ static void __invalidate_snapshot(struct
 	dm_table_event(s->table);
 }
 
+static void get_pending_exception(struct pending_exception *pe)
+{
+	atomic_inc(&pe->ref_count);
+}
+
+static struct bio *put_pending_exception(struct pending_exception *pe)
+{
+	struct pending_exception *primary_pe;
+	struct bio *origin_bios = NULL;
+
+	primary_pe = pe->primary_pe;
+
+	/*
+	 * If this pe is involved in a write to the origin and
+	 * it is the last sibling to complete then release
+	 * the bios for the original write to the origin.
+	 */
+	if (primary_pe &&
+	    atomic_dec_and_test(&primary_pe->ref_count))
+		origin_bios = bio_list_get(&primary_pe->origin_bios);
+
+	/*
+	 * Free the pe if it's not linked to an origin write or if
+	 * it's not itself a primary pe.
+	 */
+	if (!primary_pe || primary_pe != pe)
+		free_pending_exception(pe);
+
+	/*
+	 * Free the primary pe if nothing references it.
+	 */
+	if (primary_pe && !atomic_read(&primary_pe->ref_count))
+		free_pending_exception(primary_pe);
+
+	return origin_bios;
+}
+
 static void pending_complete(struct pending_exception *pe, int success)
 {
 	struct exception *e;
-	struct pending_exception *primary_pe;
 	struct dm_snapshot *s = pe->snap;
 	struct bio *origin_bios = NULL;
 	struct bio *snapshot_bios = NULL;
@@ -695,30 +731,7 @@ static void pending_complete(struct pend
 
  out:
 	snapshot_bios = bio_list_get(&pe->snapshot_bios);
-
-	primary_pe = pe->primary_pe;
-
-	/*
-	 * If this pe is involved in a write to the origin and
-	 * it is the last sibling to complete then release
-	 * the bios for the original write to the origin.
-	 */
-	if (primary_pe &&
-	    atomic_dec_and_test(&primary_pe->sibling_count))
-		origin_bios = bio_list_get(&primary_pe->origin_bios);
-
-	/*
-	 * Free the pe if it's not linked to an origin write or if
-	 * it's not itself a primary pe.
-	 */
-	if (!primary_pe || primary_pe != pe)
-		free_pending_exception(pe);
-
-	/*
-	 * Free the primary pe if nothing references it.
-	 */
-	if (primary_pe && !atomic_read(&primary_pe->sibling_count))
-		free_pending_exception(primary_pe);
+	origin_bios = put_pending_exception(pe);
 
 	up_write(&s->lock);
 
@@ -829,7 +842,7 @@ __find_pending_exception(struct dm_snaps
 	bio_list_init(&pe->origin_bios);
 	bio_list_init(&pe->snapshot_bios);
 	pe->primary_pe = NULL;
-	atomic_set(&pe->sibling_count, 1);
+	atomic_set(&pe->ref_count, 0);
 	pe->snap = s;
 	pe->started = 0;
 
@@ -838,6 +851,7 @@ __find_pending_exception(struct dm_snaps
 		return NULL;
 	}
 
+	get_pending_exception(pe);
 	insert_exception(&s->pending, &pe->e);
 
  out:
@@ -1012,7 +1026,7 @@ static int __origin_write(struct list_he
 		 * is already remapped in this snapshot
 		 * and trigger an exception if not.
 		 *
-		 * sibling_count is initialised to 1 so pending_complete()
+		 * ref_count is initialised to 1 so pending_complete()
 		 * won't destroy the primary_pe while we're inside this loop.
 		 */
 		e = lookup_exception(&snap->complete, chunk);
@@ -1043,8 +1057,8 @@ static int __origin_write(struct list_he
 		}
 
 		if (!pe->primary_pe) {
-			atomic_inc(&primary_pe->sibling_count);
 			pe->primary_pe = primary_pe;
+			get_pending_exception(primary_pe);
 		}
 
 		if (!pe->started) {
@@ -1057,20 +1071,20 @@ static int __origin_write(struct list_he
 	}
 
 	if (!primary_pe)
-		goto out;
+		return r;
 
 	/*
 	 * If this is the first time we're processing this chunk and
-	 * sibling_count is now 1 it means all the pending exceptions
+	 * ref_count is now 1 it means all the pending exceptions
 	 * got completed while we were in the loop above, so it falls to
 	 * us here to remove the primary_pe and submit any origin_bios.
 	 */
 
-	if (first && atomic_dec_and_test(&primary_pe->sibling_count)) {
+	if (first && atomic_dec_and_test(&primary_pe->ref_count)) {
 		flush_bios(bio_list_get(&primary_pe->origin_bios));
 		free_pending_exception(primary_pe);
 		/* If we got here, pe_queue is necessarily empty. */
-		goto out;
+		return r;
 	}
 
 	/*
@@ -1079,7 +1093,6 @@ static int __origin_write(struct list_he
 	list_for_each_entry_safe(pe, next_pe, &pe_queue, list)
 		start_copy(pe);
 
- out:
 	return r;
 }
 
