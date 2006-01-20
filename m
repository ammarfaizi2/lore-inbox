Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932207AbWATVW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbWATVW1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 16:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbWATVW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 16:22:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43748 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932207AbWATVW0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 16:22:26 -0500
Date: Fri, 20 Jan 2006 21:22:10 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] device-mapper snapshot: replace sibling list
Message-ID: <20060120212210.GI4724@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The siblings "list" is used unsafely at the moment.

Firstly, only the element on the list being changed gets locked (via the 
snapshot lock), not the next and previous elements which have pointers
that are also being changed.

Secondly, if you have two or more snapshots and write to the same chunk
a second time before every snapshot has finished making its private
copy of the data, if you're unlucky, _origin_write() could attempt its 
list_merge() and dereference a 'last' pointer to a pending_exception 
structure that has just been freed.


Analysis reveals that the list is actually only there for reference
counting.  If 5 pending_exceptions are needed in origin_write, then the 5
are joined together into a 5-element list - without a separate list head
because there's nowhere suitable to store it.
As the pending_exceptions complete, they are removed from the list 
one-by-one and any contents of origin_bios get moved across to one of
the remaining pending_exceptions on the list.  Whichever one is last 
is detected because list_empty() is then true and the origin_bios get
submitted.


The fix proposed here uses an alternative reference counting mechanism
by choosing one of the pending_exceptions as primary and maintaining an 
atomic counter there.


Signed-Off-By: Alasdair G Kergon <agk@redhat.com>


Index: linux-2.6.16-rc1/drivers/md/dm-snap.c
===================================================================
--- linux-2.6.16-rc1.orig/drivers/md/dm-snap.c
+++ linux-2.6.16-rc1/drivers/md/dm-snap.c
@@ -54,11 +54,21 @@ struct pending_exception {
 	struct list_head list;
 
 	/*
-	 * Other pending_exceptions that are processing this
-	 * chunk.  When this list is empty, we know we can
-	 * complete the origins.
+	 * The primary pending_exception is the one that holds
+	 * the sibling_count and the list of origin_bios for a
+	 * group of pending_exceptions.  It is always last to get freed.
+	 * These fields get set up when writing to the origin.
 	 */
-	struct list_head siblings;
+	struct pending_exception *primary_pe;
+
+	/*
+	 * Number of pending_exceptions processing this chunk.
+	 * When this drops to zero we must complete the origin bios.
+	 * If incrementing or decrementing this, hold pe->snap->lock for
+	 * the sibling concerned and not pe->primary_pe->snap->lock unless
+	 * they are the same.
+	 */
+	atomic_t sibling_count;
 
 	/* Pointer back to snapshot context */
 	struct dm_snapshot *snap;
@@ -593,20 +603,15 @@ static void error_bios(struct bio *bio)
 
 static struct bio *__flush_bios(struct pending_exception *pe)
 {
-	struct pending_exception *sibling;
-
-	if (list_empty(&pe->siblings))
-		return bio_list_get(&pe->origin_bios);
-
-	sibling = list_entry(pe->siblings.next,
-			     struct pending_exception, siblings);
-
-	list_del(&pe->siblings);
-
-	/* This is fine as long as kcopyd is single-threaded. If kcopyd
-	 * becomes multi-threaded, we'll need some locking here.
+	/*
+	 * If this pe is involved in a write to the origin and
+	 * it is the last sibling to complete then release
+	 * the bios for the original write to the origin.
 	 */
-	bio_list_merge(&sibling->origin_bios, &pe->origin_bios);
+
+	if (pe->primary_pe &&
+	    atomic_dec_and_test(&pe->primary_pe->sibling_count))
+		return bio_list_get(&pe->primary_pe->origin_bios);
 
 	return NULL;
 }
@@ -662,7 +667,18 @@ static void pending_complete(struct pend
 	}
 
  out:
-	free_pending_exception(pe);
+	/*
+	 * Free the pe if it's not linked to an origin write or if
+	 * it's not itself a primary pe.
+	 */
+	if (!pe->primary_pe || pe->primary_pe != pe)
+		free_pending_exception(pe);
+
+	/*
+	 * Free the primary pe if nothing references it.
+	 */
+	if (pe->primary_pe && !atomic_read(&pe->primary_pe->sibling_count))
+		free_pending_exception(pe->primary_pe);
 
 	if (flush)
 		flush_bios(flush);
@@ -757,7 +773,8 @@ __find_pending_exception(struct dm_snaps
 			pe->e.old_chunk = chunk;
 			bio_list_init(&pe->origin_bios);
 			bio_list_init(&pe->snapshot_bios);
-			INIT_LIST_HEAD(&pe->siblings);
+			pe->primary_pe = NULL;
+			atomic_set(&pe->sibling_count, 1);
 			pe->snap = s;
 			pe->started = 0;
 
@@ -916,26 +933,12 @@ static int snapshot_status(struct dm_tar
 /*-----------------------------------------------------------------
  * Origin methods
  *---------------------------------------------------------------*/
-static void list_merge(struct list_head *l1, struct list_head *l2)
-{
-	struct list_head *l1_n, *l2_p;
-
-	l1_n = l1->next;
-	l2_p = l2->prev;
-
-	l1->next = l2;
-	l2->prev = l1;
-
-	l2_p->next = l1_n;
-	l1_n->prev = l2_p;
-}
-
 static int __origin_write(struct list_head *snapshots, struct bio *bio)
 {
-	int r = 1, first = 1;
+	int r = 1, first = 0;
 	struct dm_snapshot *snap;
 	struct exception *e;
-	struct pending_exception *pe, *next_pe, *last = NULL;
+	struct pending_exception *pe, *next_pe, *primary_pe = NULL;
 	chunk_t chunk;
 	LIST_HEAD(pe_queue);
 
@@ -962,6 +965,9 @@ static int __origin_write(struct list_he
 		 * Check exception table to see if block
 		 * is already remapped in this snapshot
 		 * and trigger an exception if not.
+		 *
+		 * sibling_count is initialised to 1 so pending_complete()
+		 * won't destroy the primary_pe while we're inside this loop.
 		 */
 		e = lookup_exception(&snap->complete, chunk);
 		if (!e) {
@@ -971,31 +977,60 @@ static int __origin_write(struct list_he
 				snap->valid = 0;
 
 			} else {
-				if (first) {
-					bio_list_add(&pe->origin_bios, bio);
+				if (!primary_pe) {
+					/*
+					 * Either every pe here has same
+					 * primary_pe or none has one yet.
+					 */
+					if (pe->primary_pe)
+						primary_pe = pe->primary_pe;
+					else {
+						primary_pe = pe;
+						first = 1;
+					}
+
+					bio_list_add(&primary_pe->origin_bios,
+						     bio);
 					r = 0;
-					first = 0;
 				}
-				if (last && list_empty(&pe->siblings))
-					list_merge(&pe->siblings,
-						   &last->siblings);
+				if (!pe->primary_pe) {
+					atomic_inc(&primary_pe->sibling_count);
+					pe->primary_pe = primary_pe;
+				}
 				if (!pe->started) {
 					pe->started = 1;
 					list_add_tail(&pe->list, &pe_queue);
 				}
-				last = pe;
 			}
 		}
 
 		up_write(&snap->lock);
 	}
 
+	if (!primary_pe)
+		goto out;
+
+	/*
+	 * If this is the first time we're processing this chunk and
+	 * sibling_count is now 1 it means all the pending exceptions
+	 * got completed while we were in the loop above, so it falls to
+	 * us here to remove the primary_pe and submit any origin_bios.
+	 */
+
+	if (first && atomic_dec_and_test(&primary_pe->sibling_count)) {
+		flush_bios(bio_list_get(&primary_pe->origin_bios));
+		free_pending_exception(primary_pe);
+		/* If we got here, pe_queue is necessarily empty. */
+		goto out;
+	}
+
 	/*
 	 * Now that we have a complete pe list we can start the copying.
 	 */
 	list_for_each_entry_safe(pe, next_pe, &pe_queue, list)
 		start_copy(pe);
 
+ out:
 	return r;
 }
 
