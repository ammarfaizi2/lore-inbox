Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030344AbWEYTGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030344AbWEYTGp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 15:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030353AbWEYTGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 15:06:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:21894 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030344AbWEYTGp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 15:06:45 -0400
Date: Thu, 25 May 2006 20:06:39 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/10] dm snapshot: unify chunk_size
Message-ID: <20060525190639.GS4521@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Persistent snapshots currently store a private copy of the chunk size.
Userspace also supplies the chunk size when loading a snapshot.
Ensure consistency by only storing the chunk_size in one place instead of two.

 
Currently the two sizes will differ if the chunk size supplied by userspace
does not match the chunk size an existing snapshot actually uses.  Amongst
other problems, this causes an incorrect 'percentage full' to be reported.
 
The patch ensures consistency by only storing the chunk_size in one place,
removing it from struct pstore.  Some initialisation is delayed until the
correct chunk_size is known.  If read_header() discovers that the wrong
chunk size was supplied, the 'area' buffer (which the header already got
read into) is reinitialised to the correct size.


Signed-Off-By: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.17-rc4/drivers/md/dm-snap.c
===================================================================
--- linux-2.6.17-rc4.orig/drivers/md/dm-snap.c	2006-05-23 18:16:32.000000000 +0100
+++ linux-2.6.17-rc4/drivers/md/dm-snap.c	2006-05-23 18:16:38.000000000 +0100
@@ -530,7 +530,7 @@ static int snapshot_ctr(struct dm_target
 	}
 
 	ti->private = s;
-	ti->split_io = chunk_size;
+	ti->split_io = s->chunk_size;
 
 	return 0;
 
@@ -1204,7 +1204,7 @@ static int origin_status(struct dm_targe
 
 static struct target_type origin_target = {
 	.name    = "snapshot-origin",
-	.version = {1, 1, 0},
+	.version = {1, 4, 0},
 	.module  = THIS_MODULE,
 	.ctr     = origin_ctr,
 	.dtr     = origin_dtr,
@@ -1215,7 +1215,7 @@ static struct target_type origin_target 
 
 static struct target_type snapshot_target = {
 	.name    = "snapshot",
-	.version = {1, 1, 0},
+	.version = {1, 4, 0},
 	.module  = THIS_MODULE,
 	.ctr     = snapshot_ctr,
 	.dtr     = snapshot_dtr,
Index: linux-2.6.17-rc4/drivers/md/dm-exception-store.c
===================================================================
--- linux-2.6.17-rc4.orig/drivers/md/dm-exception-store.c	2006-05-23 18:16:32.000000000 +0100
+++ linux-2.6.17-rc4/drivers/md/dm-exception-store.c	2006-05-23 18:16:38.000000000 +0100
@@ -91,7 +91,6 @@ struct pstore {
 	struct dm_snapshot *snap;	/* up pointer to my snapshot */
 	int version;
 	int valid;
-	uint32_t chunk_size;
 	uint32_t exceptions_per_area;
 
 	/*
@@ -133,7 +132,7 @@ static int alloc_area(struct pstore *ps)
 	int r = -ENOMEM;
 	size_t len;
 
-	len = ps->chunk_size << SECTOR_SHIFT;
+	len = ps->snap->chunk_size << SECTOR_SHIFT;
 
 	/*
 	 * Allocate the chunk_size block of memory that will hold
@@ -160,8 +159,8 @@ static int chunk_io(struct pstore *ps, u
 	unsigned long bits;
 
 	where.bdev = ps->snap->cow->bdev;
-	where.sector = ps->chunk_size * chunk;
-	where.count = ps->chunk_size;
+	where.sector = ps->snap->chunk_size * chunk;
+	where.count = ps->snap->chunk_size;
 
 	return dm_io_sync_vm(1, &where, rw, ps->area, &bits);
 }
@@ -188,7 +187,7 @@ static int area_io(struct pstore *ps, ui
 
 static int zero_area(struct pstore *ps, uint32_t area)
 {
-	memset(ps->area, 0, ps->chunk_size << SECTOR_SHIFT);
+	memset(ps->area, 0, ps->snap->chunk_size << SECTOR_SHIFT);
 	return area_io(ps, area, WRITE);
 }
 
@@ -196,6 +195,7 @@ static int read_header(struct pstore *ps
 {
 	int r;
 	struct disk_header *dh;
+	chunk_t chunk_size;
 
 	r = chunk_io(ps, 0, READ);
 	if (r)
@@ -210,8 +210,29 @@ static int read_header(struct pstore *ps
 		*new_snapshot = 0;
 		ps->valid = le32_to_cpu(dh->valid);
 		ps->version = le32_to_cpu(dh->version);
-		ps->chunk_size = le32_to_cpu(dh->chunk_size);
-
+		chunk_size = le32_to_cpu(dh->chunk_size);
+		if (ps->snap->chunk_size != chunk_size) {
+			DMWARN("chunk size %llu in device metadata overrides "
+			       "table chunk size of %llu.",
+			       (unsigned long long)chunk_size,
+			       (unsigned long long)ps->snap->chunk_size);
+
+			/* We had a bogus chunk_size. Fix stuff up. */
+			dm_io_put(sectors_to_pages(ps->snap->chunk_size));
+			free_area(ps);
+
+			ps->snap->chunk_size = chunk_size;
+			ps->snap->chunk_mask = chunk_size - 1;
+			ps->snap->chunk_shift = ffs(chunk_size) - 1;
+
+			r = alloc_area(ps);
+			if (r)
+				return r;
+
+			r = dm_io_get(sectors_to_pages(chunk_size));
+			if (r)
+				return r;
+		}
 	} else {
 		DMWARN("Invalid/corrupt snapshot");
 		r = -ENXIO;
@@ -224,13 +245,13 @@ static int write_header(struct pstore *p
 {
 	struct disk_header *dh;
 
-	memset(ps->area, 0, ps->chunk_size << SECTOR_SHIFT);
+	memset(ps->area, 0, ps->snap->chunk_size << SECTOR_SHIFT);
 
 	dh = (struct disk_header *) ps->area;
 	dh->magic = cpu_to_le32(SNAP_MAGIC);
 	dh->valid = cpu_to_le32(ps->valid);
 	dh->version = cpu_to_le32(ps->version);
-	dh->chunk_size = cpu_to_le32(ps->chunk_size);
+	dh->chunk_size = cpu_to_le32(ps->snap->chunk_size);
 
 	return chunk_io(ps, 0, WRITE);
 }
@@ -365,7 +386,7 @@ static void persistent_destroy(struct ex
 {
 	struct pstore *ps = get_info(store);
 
-	dm_io_put(sectors_to_pages(ps->chunk_size));
+	dm_io_put(sectors_to_pages(ps->snap->chunk_size));
 	vfree(ps->callbacks);
 	free_area(ps);
 	kfree(ps);
@@ -384,6 +405,16 @@ static int persistent_read_metadata(stru
 		return r;
 
 	/*
+	 * Now we know correct chunk_size, complete the initialisation.
+	 */
+	ps->exceptions_per_area = (ps->snap->chunk_size << SECTOR_SHIFT) /
+				  sizeof(struct disk_exception);
+	ps->callbacks = dm_vcalloc(ps->exceptions_per_area,
+			sizeof(*ps->callbacks));
+	if (!ps->callbacks)
+		return -ENOMEM;
+
+	/*
 	 * Do we need to setup a new snapshot ?
 	 */
 	if (new_snapshot) {
@@ -533,9 +564,6 @@ int dm_create_persistent(struct exceptio
 	ps->snap = store->snap;
 	ps->valid = 1;
 	ps->version = SNAPSHOT_DISK_VERSION;
-	ps->chunk_size = chunk_size;
-	ps->exceptions_per_area = (chunk_size << SECTOR_SHIFT) /
-	    sizeof(struct disk_exception);
 	ps->next_free = 2;	/* skipping the header and first area */
 	ps->current_committed = 0;
 
@@ -543,18 +571,9 @@ int dm_create_persistent(struct exceptio
 	if (r)
 		goto bad;
 
-	/*
-	 * Allocate space for all the callbacks.
-	 */
 	ps->callback_count = 0;
 	atomic_set(&ps->pending_count, 0);
-	ps->callbacks = dm_vcalloc(ps->exceptions_per_area,
-				   sizeof(*ps->callbacks));
-
-	if (!ps->callbacks) {
-		r = -ENOMEM;
-		goto bad;
-	}
+	ps->callbacks = NULL;
 
 	store->destroy = persistent_destroy;
 	store->read_metadata = persistent_read_metadata;
