Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964880AbWAWVdX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964880AbWAWVdX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 16:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964954AbWAWVdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 16:33:23 -0500
Received: from mx1.redhat.com ([66.187.233.31]:61602 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964880AbWAWVdV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 16:33:21 -0500
Date: Mon, 23 Jan 2006 21:33:12 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/9] device-mapper snapshot: fix invalidation
Message-ID: <20060123213312.GM4280@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20060120213457.GJ4724@agk.surrey.redhat.com> <20060123204810.GA1739@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060123204810.GA1739@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2006 at 09:48:11PM +0100, Pavel Machek wrote:
> On Pá 20-01-06 21:34:57, Alasdair G Kergon wrote:
> > +	if ((err == -EIO))

> > +	else if ((err == -ENOMEM))
 
> I see you are trying to make it look distinct from assignment,

Nope - it's assignment that gets them doubled to silence the compiler.

It was the last patch and I decided to include it in this batch even though 
it isn't completely tidied up and reviewed yet.

Replacement with spurious parentheses removed below.

Alasdair
-- 
agk@redhat.com


Signed-Off-By: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.16-rc1/drivers/md/dm-snap.c
===================================================================
--- linux-2.6.16-rc1.orig/drivers/md/dm-snap.c	2006-01-23 21:22:27.000000000 +0000
+++ linux-2.6.16-rc1/drivers/md/dm-snap.c	2006-01-23 21:22:44.000000000 +0000
@@ -392,6 +392,8 @@ static void read_snapshot_metadata(struc
 		down_write(&s->lock);
 		s->valid = 0;
 		up_write(&s->lock);
+
+		dm_table_event(s->table);
 	}
 }
 
@@ -601,6 +603,11 @@ static void error_bios(struct bio *bio)
 	}
 }
 
+static inline void error_snapshot_bios(struct pending_exception *pe)
+{
+	error_bios(bio_list_get(&pe->snapshot_bios));
+}
+
 static struct bio *__flush_bios(struct pending_exception *pe)
 {
 	/*
@@ -616,56 +623,80 @@ static struct bio *__flush_bios(struct p
 	return NULL;
 }
 
+static void __invalidate_snapshot(struct dm_snapshot *s, struct pending_exception *pe, int err)
+{
+	if (!s->valid)
+		return;
+
+	if (err == -EIO)
+		DMERR("Invalidating snapshot: Error reading/writing.");
+	else if (err == -ENOMEM)
+		DMERR("Invalidating snapshot: Unable to allocate exception.");
+
+	if (pe)
+		remove_exception(&pe->e);
+
+	if (s->store.drop_snapshot)
+		s->store.drop_snapshot(&s->store);
+
+	s->valid = 0;
+
+	dm_table_event(s->table);
+}
+
 static void pending_complete(struct pending_exception *pe, int success)
 {
 	struct exception *e;
 	struct dm_snapshot *s = pe->snap;
 	struct bio *flush = NULL;
 
-	if (success) {
-		e = alloc_exception();
-		if (!e) {
-			DMWARN("Unable to allocate exception.");
-			down_write(&s->lock);
-			s->store.drop_snapshot(&s->store);
-			s->valid = 0;
-			flush = __flush_bios(pe);
-			up_write(&s->lock);
+	if (!success) {
+		/* Read/write error - snapshot is unusable */
+		down_write(&s->lock);
+		__invalidate_snapshot(s, pe, -EIO);
+		flush = __flush_bios(pe);
+		up_write(&s->lock);
 
-			error_bios(bio_list_get(&pe->snapshot_bios));
-			goto out;
-		}
-		*e = pe->e;
+		error_snapshot_bios(pe);
+		goto out;
+	}
 
-		/*
-		 * Add a proper exception, and remove the
-		 * in-flight exception from the list.
-		 */
+	e = alloc_exception();
+	if (!e) {
 		down_write(&s->lock);
-		insert_exception(&s->complete, e);
-		remove_exception(&pe->e);
+		__invalidate_snapshot(s, pe, -ENOMEM);
 		flush = __flush_bios(pe);
-
-		/* Submit any pending write bios */
 		up_write(&s->lock);
 
-		flush_bios(bio_list_get(&pe->snapshot_bios));
-	} else {
-		/* Read/write error - snapshot is unusable */
-		down_write(&s->lock);
-		if (s->valid)
-			DMERR("Error reading/writing snapshot");
-		s->store.drop_snapshot(&s->store);
-		s->valid = 0;
-		remove_exception(&pe->e);
+		error_snapshot_bios(pe);
+		goto out;
+	}
+	*e = pe->e;
+
+	/*
+	 * Add a proper exception, and remove the
+	 * in-flight exception from the list.
+	 */
+	down_write(&s->lock);
+	if (!s->valid) {
 		flush = __flush_bios(pe);
 		up_write(&s->lock);
 
-		error_bios(bio_list_get(&pe->snapshot_bios));
+		free_exception(e);
 
-		dm_table_event(s->table);
+		error_snapshot_bios(pe);
+		goto out;
 	}
 
+	insert_exception(&s->complete, e);
+	remove_exception(&pe->e);
+	flush = __flush_bios(pe);
+
+	up_write(&s->lock);
+
+	/* Submit any pending write bios */
+	flush_bios(bio_list_get(&pe->snapshot_bios));
+
  out:
 	/*
 	 * Free the pe if it's not linked to an origin write or if
@@ -755,39 +786,45 @@ __find_pending_exception(struct dm_snaps
 	if (e) {
 		/* cast the exception to a pending exception */
 		pe = container_of(e, struct pending_exception, e);
+		goto out;
+	}
 
-	} else {
-		/*
-		 * Create a new pending exception, we don't want
-		 * to hold the lock while we do this.
-		 */
-		up_write(&s->lock);
-		pe = alloc_pending_exception();
-		down_write(&s->lock);
+	/*
+	 * Create a new pending exception, we don't want
+	 * to hold the lock while we do this.
+	 */
+	up_write(&s->lock);
+	pe = alloc_pending_exception();
+	down_write(&s->lock);
 
-		e = lookup_exception(&s->pending, chunk);
-		if (e) {
-			free_pending_exception(pe);
-			pe = container_of(e, struct pending_exception, e);
-		} else {
-			pe->e.old_chunk = chunk;
-			bio_list_init(&pe->origin_bios);
-			bio_list_init(&pe->snapshot_bios);
-			pe->primary_pe = NULL;
-			atomic_set(&pe->sibling_count, 1);
-			pe->snap = s;
-			pe->started = 0;
-
-			if (s->store.prepare_exception(&s->store, &pe->e)) {
-				free_pending_exception(pe);
-				s->valid = 0;
-				return NULL;
-			}
+	if (!s->valid) {
+		free_pending_exception(pe);
+		return NULL;
+	}
 
-			insert_exception(&s->pending, &pe->e);
-		}
+	e = lookup_exception(&s->pending, chunk);
+	if (e) {
+		free_pending_exception(pe);
+		pe = container_of(e, struct pending_exception, e);
+		goto out;
+	}
+
+	pe->e.old_chunk = chunk;
+	bio_list_init(&pe->origin_bios);
+	bio_list_init(&pe->snapshot_bios);
+	pe->primary_pe = NULL;
+	atomic_set(&pe->sibling_count, 1);
+	pe->snap = s;
+	pe->started = 0;
+
+	if (s->store.prepare_exception(&s->store, &pe->e)) {
+		free_pending_exception(pe);
+		return NULL;
 	}
 
+	insert_exception(&s->pending, &pe->e);
+
+ out:
 	return pe;
 }
 
@@ -804,13 +841,15 @@ static int snapshot_map(struct dm_target
 {
 	struct exception *e;
 	struct dm_snapshot *s = (struct dm_snapshot *) ti->private;
+	int copy_needed = 0;
 	int r = 1;
 	chunk_t chunk;
-	struct pending_exception *pe;
+	struct pending_exception *pe = NULL;
 
 	chunk = sector_to_chunk(s, bio->bi_sector);
 
 	/* Full snapshots are not usable */
+	/* To get here the table must be live so s->active is always set. */
 	if (!s->valid)
 		return -EIO;
 
@@ -828,36 +867,41 @@ static int snapshot_map(struct dm_target
 		 * to copy an exception */
 		down_write(&s->lock);
 
+		if (!s->valid) {
+			r = -EIO;
+			goto out_unlock;
+		}
+
 		/* If the block is already remapped - use that, else remap it */
 		e = lookup_exception(&s->complete, chunk);
 		if (e) {
 			remap_exception(s, e, bio);
-			up_write(&s->lock);
+			goto out_unlock;
+		}
+
+		pe = __find_pending_exception(s, bio);
+		if (!pe) {
+			__invalidate_snapshot(s, pe, -ENOMEM);
+			r = -EIO;
+			goto out_unlock;
+		}
 
-		} else {
-			pe = __find_pending_exception(s, bio);
+		remap_exception(s, &pe->e, bio);
+		bio_list_add(&pe->snapshot_bios, bio);
 
-			if (!pe) {
-				if (s->store.drop_snapshot)
-					s->store.drop_snapshot(&s->store);
-				s->valid = 0;
-				r = -EIO;
-				up_write(&s->lock);
-			} else {
-				remap_exception(s, &pe->e, bio);
-				bio_list_add(&pe->snapshot_bios, bio);
-
-				if (!pe->started) {
-					/* this is protected by snap->lock */
-					pe->started = 1;
-					up_write(&s->lock);
-					start_copy(pe);
-				} else
-					up_write(&s->lock);
-				r = 0;
-			}
+		if (!pe->started) {
+			/* this is protected by snap->lock */
+			pe->started = 1;
+			copy_needed = 1;
 		}
 
+		r = 0;
+
+ out_unlock:
+		up_write(&s->lock);
+
+		if (copy_needed)
+			start_copy(pe);
 	} else {
 		/*
 		 * FIXME: this read path scares me because we
@@ -869,6 +913,11 @@ static int snapshot_map(struct dm_target
 		/* Do reads */
 		down_read(&s->lock);
 
+		if (!s->valid) {
+			up_read(&s->lock);
+			return -EIO;
+		}
+
 		/* See if it it has been remapped */
 		e = lookup_exception(&s->complete, chunk);
 		if (e)
@@ -945,15 +994,15 @@ static int __origin_write(struct list_he
 	/* Do all the snapshots on this origin */
 	list_for_each_entry (snap, snapshots, list) {
 
+		down_write(&snap->lock);
+
 		/* Only deal with valid and active snapshots */
 		if (!snap->valid || !snap->active)
-			continue;
+			goto next_snapshot;
 
 		/* Nothing to do if writing beyond end of snapshot */
 		if (bio->bi_sector >= dm_table_get_size(snap->table))
-			continue;
-
-		down_write(&snap->lock);
+			goto next_snapshot;
 
 		/*
 		 * Remember, different snapshots can have
@@ -970,40 +1019,43 @@ static int __origin_write(struct list_he
 		 * won't destroy the primary_pe while we're inside this loop.
 		 */
 		e = lookup_exception(&snap->complete, chunk);
-		if (!e) {
-			pe = __find_pending_exception(snap, bio);
-			if (!pe) {
-				snap->store.drop_snapshot(&snap->store);
-				snap->valid = 0;
-
-			} else {
-				if (!primary_pe) {
-					/*
-					 * Either every pe here has same
-					 * primary_pe or none has one yet.
-					 */
-					if (pe->primary_pe)
-						primary_pe = pe->primary_pe;
-					else {
-						primary_pe = pe;
-						first = 1;
-					}
-
-					bio_list_add(&primary_pe->origin_bios,
-						     bio);
-					r = 0;
-				}
-				if (!pe->primary_pe) {
-					atomic_inc(&primary_pe->sibling_count);
-					pe->primary_pe = primary_pe;
-				}
-				if (!pe->started) {
-					pe->started = 1;
-					list_add_tail(&pe->list, &pe_queue);
-				}
+		if (e)
+			goto next_snapshot;
+
+		pe = __find_pending_exception(snap, bio);
+		if (!pe) {
+			__invalidate_snapshot(snap, pe, ENOMEM);
+			goto next_snapshot;
+		}
+
+		if (!primary_pe) {
+			/*
+			 * Either every pe here has same
+			 * primary_pe or none has one yet.
+			 */
+			if (pe->primary_pe)
+				primary_pe = pe->primary_pe;
+			else {
+				primary_pe = pe;
+				first = 1;
 			}
+
+			bio_list_add(&primary_pe->origin_bios, bio);
+
+			r = 0;
+		}
+
+		if (!pe->primary_pe) {
+			atomic_inc(&primary_pe->sibling_count);
+			pe->primary_pe = primary_pe;
+		}
+
+		if (!pe->started) {
+			pe->started = 1;
+			list_add_tail(&pe->list, &pe_queue);
 		}
 
+ next_snapshot:
 		up_write(&snap->lock);
 	}
 
