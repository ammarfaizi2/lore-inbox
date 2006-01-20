Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbWATVUE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbWATVUE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 16:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbWATVUD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 16:20:03 -0500
Received: from mx1.redhat.com ([66.187.233.31]:34274 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932195AbWATVUB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 16:20:01 -0500
Date: Fri, 20 Jan 2006 21:19:53 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] device-mapper snapshot: fix origin_write pending_exception submission
Message-ID: <20060120211953.GH4724@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Say you have several snapshots of the same origin and then you issue
a write to some place in the origin for the first time.

Before the device-mapper snapshot target lets the write go through to 
the underlying device, it needs to make a copy of the data that 
is about to be overwritten.  Each snapshot is independent, so it makes 
one copy for each snapshot.

__origin_write() loops through each snapshot and checks to see
whether a copy is needed for that snapshot.  (A copy is only needed
the first time that data changes.)  

If a copy is needed, the code allocates a 'pending_exception' structure 
holding the details.  It links these together for all the snapshots, then 
works its way through this list and submits the copying requests to
the kcopyd thread by calling start_copy().  When each request is
completed, the original pending_exception structure gets freed in
pending_complete().

If you're very unlucky, this structure can get freed *before* the 
submission process has finished walking the list.


This patch:
  1) Creates a new temporary list pe_queue to hold the pending exception 
structures;
  2) Does all the bookkeeping up-front, then walks through the new list
safely and calls start_copy() for each pending_exception that needed it;
  3) Avoids attempting to add pe->siblings to the list if it's already
connected.


[NB This does not fix all the races in this code.  More patches will follow.]

Signed-Off-By: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.14-rc2/drivers/md/dm-snap.c
===================================================================
--- linux-2.6.14-rc2.orig/drivers/md/dm-snap.c	2006-01-11 14:59:56.000000000 +0000
+++ linux-2.6.14-rc2/drivers/md/dm-snap.c	2006-01-11 18:31:00.000000000 +0000
@@ -49,6 +49,11 @@ struct pending_exception {
 	struct bio_list snapshot_bios;
 
 	/*
+	 * Short-term queue of pending exceptions prior to submission.
+	 */
+	struct list_head list;
+
+	/*
 	 * Other pending_exceptions that are processing this
 	 * chunk.  When this list is empty, we know we can
 	 * complete the origins.
@@ -937,8 +942,9 @@ static int __origin_write(struct list_he
 	int r = 1, first = 1;
 	struct dm_snapshot *snap;
 	struct exception *e;
-	struct pending_exception *pe, *last = NULL;
+	struct pending_exception *pe, *next_pe, *last = NULL;
 	chunk_t chunk;
+	LIST_HEAD(pe_queue);
 
 	/* Do all the snapshots on this origin */
 	list_for_each_entry (snap, snapshots, list) {
@@ -972,12 +978,19 @@ static int __origin_write(struct list_he
 				snap->valid = 0;
 
 			} else {
-				if (last)
+				if (first) {
+					bio_list_add(&pe->origin_bios, bio);
+					r = 0;
+					first = 0;
+				}
+				if (last && list_empty(&pe->siblings))
 					list_merge(&pe->siblings,
 						   &last->siblings);
-
+				if (!pe->started) {
+					pe->started = 1;
+					list_add_tail(&pe->list, &pe_queue);
+				}
 				last = pe;
-				r = 0;
 			}
 		}
 
@@ -987,24 +1000,8 @@ static int __origin_write(struct list_he
 	/*
 	 * Now that we have a complete pe list we can start the copying.
 	 */
-	if (last) {
-		pe = last;
-		do {
-			down_write(&pe->snap->lock);
-			if (first)
-				bio_list_add(&pe->origin_bios, bio);
-			if (!pe->started) {
-				pe->started = 1;
-				up_write(&pe->snap->lock);
-				start_copy(pe);
-			} else
-				up_write(&pe->snap->lock);
-			first = 0;
-			pe = list_entry(pe->siblings.next,
-					struct pending_exception, siblings);
-
-		} while (pe != last);
-	}
+	list_for_each_entry_safe(pe, next_pe, &pe_queue, list)
+		start_copy(pe);
 
 	return r;
 }
