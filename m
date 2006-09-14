Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbWINVlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbWINVlz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 17:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbWINVlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 17:41:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36308 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751147AbWINVly (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 17:41:54 -0400
Date: Thu, 14 Sep 2006 22:41:47 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Mark McLoughlin <markmc@redhat.com>
Subject: [PATCH 08/25] dm snapshot: tidy pending_complete
Message-ID: <20060914214147.GP3928@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Mark McLoughlin <markmc@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch rearranges the pending_complete() code so that the
functional changes in subsequent patches are clearer.

By consolidating the error and the non-error paths, we
can move error_snapshot_bios() and __flush_bios() in line.

Signed-off-by: Alasdair G Kergon <agk@redhat.com>
Signed-off-by: Mark McLoughlin <markmc@redhat.com>

Index: linux-2.6.18-rc7/drivers/md/dm-snap.c
===================================================================
--- linux-2.6.18-rc7.orig/drivers/md/dm-snap.c	2006-09-14 20:39:55.000000000 +0100
+++ linux-2.6.18-rc7/drivers/md/dm-snap.c	2006-09-14 20:40:46.000000000 +0100
@@ -609,26 +609,6 @@ static void error_bios(struct bio *bio)
 	}
 }
 
-static inline void error_snapshot_bios(struct pending_exception *pe)
-{
-	error_bios(bio_list_get(&pe->snapshot_bios));
-}
-
-static struct bio *__flush_bios(struct pending_exception *pe)
-{
-	/*
-	 * If this pe is involved in a write to the origin and
-	 * it is the last sibling to complete then release
-	 * the bios for the original write to the origin.
-	 */
-
-	if (pe->primary_pe &&
-	    atomic_dec_and_test(&pe->primary_pe->sibling_count))
-		return bio_list_get(&pe->primary_pe->origin_bios);
-
-	return NULL;
-}
-
 static void __invalidate_snapshot(struct dm_snapshot *s,
 				struct pending_exception *pe, int err)
 {
@@ -656,16 +636,15 @@ static void pending_complete(struct pend
 	struct exception *e;
 	struct pending_exception *primary_pe;
 	struct dm_snapshot *s = pe->snap;
-	struct bio *flush = NULL;
+	struct bio *origin_bios = NULL;
+	struct bio *snapshot_bios = NULL;
+	int error = 0;
 
 	if (!success) {
 		/* Read/write error - snapshot is unusable */
 		down_write(&s->lock);
 		__invalidate_snapshot(s, pe, -EIO);
-		flush = __flush_bios(pe);
-		up_write(&s->lock);
-
-		error_snapshot_bios(pe);
+		error = 1;
 		goto out;
 	}
 
@@ -673,42 +652,40 @@ static void pending_complete(struct pend
 	if (!e) {
 		down_write(&s->lock);
 		__invalidate_snapshot(s, pe, -ENOMEM);
-		flush = __flush_bios(pe);
-		up_write(&s->lock);
-
-		error_snapshot_bios(pe);
+		error = 1;
 		goto out;
 	}
 	*e = pe->e;
 
-	/*
-	 * Add a proper exception, and remove the
-	 * in-flight exception from the list.
-	 */
 	down_write(&s->lock);
 	if (!s->valid) {
-		flush = __flush_bios(pe);
-		up_write(&s->lock);
-
 		free_exception(e);
-
-		error_snapshot_bios(pe);
+		error = 1;
 		goto out;
 	}
 
+	/*
+	 * Add a proper exception, and remove the
+	 * in-flight exception from the list.
+	 */
 	insert_exception(&s->complete, e);
 	remove_exception(&pe->e);
-	flush = __flush_bios(pe);
-
-	up_write(&s->lock);
-
-	/* Submit any pending write bios */
-	flush_bios(bio_list_get(&pe->snapshot_bios));
 
  out:
+	snapshot_bios = bio_list_get(&pe->snapshot_bios);
+
 	primary_pe = pe->primary_pe;
 
 	/*
+	 * If this pe is involved in a write to the origin and
+	 * it is the last sibling to complete then release
+	 * the bios for the original write to the origin.
+	 */
+	if (primary_pe &&
+	    atomic_dec_and_test(&primary_pe->sibling_count))
+		origin_bios = bio_list_get(&primary_pe->origin_bios);
+
+	/*
 	 * Free the pe if it's not linked to an origin write or if
 	 * it's not itself a primary pe.
 	 */
@@ -721,8 +698,15 @@ static void pending_complete(struct pend
 	if (primary_pe && !atomic_read(&primary_pe->sibling_count))
 		free_pending_exception(primary_pe);
 
-	if (flush)
-		flush_bios(flush);
+	up_write(&s->lock);
+
+	/* Submit any pending write bios */
+	if (error)
+		error_bios(snapshot_bios);
+	else
+		flush_bios(snapshot_bios);
+
+	flush_bios(origin_bios);
 }
 
 static void commit_callback(void *context, int success)
