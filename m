Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262505AbUCCQYo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 11:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262510AbUCCQYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 11:24:43 -0500
Received: from 10fwd.cistron-office.nl ([62.216.29.197]:13956 "EHLO
	smtp.cistron-office.nl") by vger.kernel.org with ESMTP
	id S262505AbUCCQYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 11:24:31 -0500
Date: Wed, 3 Mar 2004 17:24:24 +0100
From: Miquel van Smoorenburg <miquels@cistron.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: Miquel van Smoorenburg <miquels@cistron.nl>, linux-kernel@vger.kernel.org,
       thornber@redhat.com
Subject: Re: per-cpu blk_plug_list
Message-ID: <20040303162424.GC19960@traveler.cistron.net>
References: <cistron.B05667366EE6204181EABE9C1B1C0EB50211E5C8@scsmsx401.sc.intel.com> <cistron.20040302211309.500f43fb.akpm@osdl.org> <20040303094509.GA8779@cistron.nl> <20040303015448.749a87d2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20040303015448.749a87d2.akpm@osdl.org> (from akpm@osdl.org on Wed, Mar 03, 2004 at 10:54:48 +0100)
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004.03.03 10:54, Andrew Morton wrote:
> Sure.  This is all nice and simple stuff, except for the locking, which
> needs serious work.

Is this a step in the right direction ?

dm-rwlock.patch

This patch converts the semaphore locks in dm.c to rwlocks. The bio's are
assembled into a list under the lock, which is then submitted to
generic_make_request outside of the lock.

--- linux-2.6.4-rc1-mm2/drivers/md/dm.c.ORIG	2004-03-03 15:08:58.000000000 +0100
+++ linux-2.6.4-rc1-mm2/drivers/md/dm.c	2004-03-03 17:14:32.000000000 +0100
@@ -35,7 +35,7 @@
 #define DMF_SUSPENDED 1
 
 struct mapped_device {
-	struct rw_semaphore lock;
+	rwlock_t lock;
 	atomic_t holders;
 
 	unsigned long flags;
@@ -189,16 +189,16 @@
  */
 static int queue_io(struct mapped_device *md, struct bio *bio)
 {
-	down_write(&md->lock);
+	write_lock(&md->lock);
 
 	if (!test_bit(DMF_BLOCK_IO, &md->flags)) {
-		up_write(&md->lock);
+		write_unlock(&md->lock);
 		return 1;
 	}
 
 	bio_list_add(&md->deferred, bio);
 
-	up_write(&md->lock);
+	write_unlock(&md->lock);
 	return 0;		/* deferred successfully */
 }
 
@@ -263,7 +263,7 @@
 	return len;
 }
 
-static void __map_bio(struct dm_target *ti, struct bio *clone, struct dm_io *io)
+static int __map_bio(struct dm_target *ti, struct bio *clone, struct dm_io *io)
 {
 	int r;
 
@@ -282,13 +282,12 @@
 	 */
 	atomic_inc(&io->io_count);
 	r = ti->type->map(ti, clone);
-	if (r > 0)
-		/* the bio has been remapped so dispatch it */
-		generic_make_request(clone);
-
-	else if (r < 0)
+	
+	if (r < 0)
 		/* error the io and bail out */
 		dec_pending(io, -EIO);
+
+	return r;
 }
 
 struct clone_info {
@@ -343,7 +342,7 @@
 	return clone;
 }
 
-static void __clone_and_map(struct clone_info *ci)
+static void __clone_and_map(struct clone_info *ci, struct bio_list *bl)
 {
 	struct bio *clone, *bio = ci->bio;
 	struct dm_target *ti = dm_table_find_target(ci->md->map, ci->sector);
@@ -356,7 +355,8 @@
 		 */
 		clone = clone_bio(bio, ci->sector, ci->idx,
 				  bio->bi_vcnt - ci->idx, ci->sector_count);
-		__map_bio(ti, clone, ci->io);
+		if (__map_bio(ti, clone, ci->io) > 0)
+			bio_list_add(bl, clone);
 		ci->sector_count = 0;
 
 	} else if (to_sector(bio->bi_io_vec[ci->idx].bv_len) <= max) {
@@ -379,7 +379,8 @@
 		}
 
 		clone = clone_bio(bio, ci->sector, ci->idx, i - ci->idx, len);
-		__map_bio(ti, clone, ci->io);
+		if (__map_bio(ti, clone, ci->io) > 0)
+			bio_list_add(bl, clone);
 
 		ci->sector += len;
 		ci->sector_count -= len;
@@ -394,7 +395,8 @@
 
 		clone = split_bvec(bio, ci->sector, ci->idx,
 				   bv->bv_offset, max);
-		__map_bio(ti, clone, ci->io);
+		if (__map_bio(ti, clone, ci->io) > 0)
+			bio_list_add(bl, clone);
 
 		ci->sector += max;
 		ci->sector_count -= max;
@@ -403,7 +405,8 @@
 		len = to_sector(bv->bv_len) - max;
 		clone = split_bvec(bio, ci->sector, ci->idx,
 				   bv->bv_offset + to_bytes(max), len);
-		__map_bio(ti, clone, ci->io);
+		if (__map_bio(ti, clone, ci->io) > 0)
+			bio_list_add(bl, clone);
 
 		ci->sector += len;
 		ci->sector_count -= len;
@@ -414,7 +417,8 @@
 /*
  * Split the bio into several clones.
  */
-static void __split_bio(struct mapped_device *md, struct bio *bio)
+static void __split_bio(struct mapped_device *md, struct bio *bio,
+						struct bio_list *bl)
 {
 	struct clone_info ci;
 
@@ -431,7 +435,7 @@
 
 	atomic_inc(&md->pending);
 	while (ci.sector_count)
-		__clone_and_map(&ci);
+		__clone_and_map(&ci, bl);
 
 	/* drop the extra reference count */
 	dec_pending(ci.io, 0);
@@ -442,6 +446,21 @@
 
 
 /*
+ * Requeue the deferred bios by calling generic_make_request.
+ */
+static void flush_deferred_io(struct bio *c)
+{
+	struct bio *n;
+
+	while (c) {
+		n = c->bi_next;
+		c->bi_next = NULL;
+		generic_make_request(c);
+		c = n;
+	}
+}
+
+/*
  * The request function that just remaps the bio built up by
  * dm_merge_bvec.
  */
@@ -449,15 +468,18 @@
 {
 	int r;
 	struct mapped_device *md = q->queuedata;
+	struct bio_list list;
+
+	list.head = list.tail = NULL;
 
-	down_read(&md->lock);
+	read_lock(&md->lock);
 
 	/*
 	 * If we're suspended we have to queue
 	 * this io for later.
 	 */
 	while (test_bit(DMF_BLOCK_IO, &md->flags)) {
-		up_read(&md->lock);
+		read_unlock(&md->lock);
 
 		if (bio_rw(bio) == READA) {
 			bio_io_error(bio, bio->bi_size);
@@ -476,7 +498,7 @@
 		 * We're in a while loop, because someone could suspend
 		 * before we get to the following read lock.
 		 */
-		down_read(&md->lock);
+		read_lock(&md->lock);
 	}
 
 	if (!md->map) {
@@ -484,8 +506,15 @@
 		return 0;
 	}
 
-	__split_bio(md, bio);
-	up_read(&md->lock);
+	__split_bio(md, bio, &list);
+	read_unlock(&md->lock);
+
+	/*
+	 *	Submit the bio's outside of md->lock.
+	 */
+	bio = bio_list_get(&list);
+	flush_deferred_io(bio);
+
 	return 0;
 }
 
@@ -494,9 +523,9 @@
 	int r;
 	struct mapped_device *md = congested_data;
 
-	down_read(&md->lock);
+	read_lock(&md->lock);
 	r = dm_table_any_congested(md->map, bdi_bits);
-	up_read(&md->lock);
+	read_unlock(&md->lock);
 
 	return r;
 }
@@ -571,7 +600,7 @@
 		goto bad1;
 
 	memset(md, 0, sizeof(*md));
-	init_rwsem(&md->lock);
+	rwlock_init(&md->lock);
 	atomic_set(&md->holders, 1);
 
 	md->queue = blk_alloc_queue(GFP_KERNEL);
@@ -634,10 +663,10 @@
 {
 	struct mapped_device *md = (struct mapped_device *) context;
 
-	down_write(&md->lock);
+	write_lock(&md->lock);
 	md->event_nr++;
 	wake_up_interruptible(&md->eventq);
-	up_write(&md->lock);
+	write_unlock(&md->lock);
 }
 
 static void __set_size(struct gendisk *disk, sector_t size)
@@ -724,32 +753,17 @@
 }
 
 /*
- * Requeue the deferred bios by calling generic_make_request.
- */
-static void flush_deferred_io(struct bio *c)
-{
-	struct bio *n;
-
-	while (c) {
-		n = c->bi_next;
-		c->bi_next = NULL;
-		generic_make_request(c);
-		c = n;
-	}
-}
-
-/*
  * Swap in a new table (destroying old one).
  */
 int dm_swap_table(struct mapped_device *md, struct dm_table *table)
 {
 	int r;
 
-	down_write(&md->lock);
+	write_lock(&md->lock);
 
 	/* device must be suspended */
 	if (!test_bit(DMF_SUSPENDED, &md->flags)) {
-		up_write(&md->lock);
+		write_unlock(&md->lock);
 		return -EPERM;
 	}
 
@@ -758,7 +772,7 @@
 	if (r)
 		return r;
 
-	up_write(&md->lock);
+	write_unlock(&md->lock);
 	return 0;
 }
 
@@ -773,20 +787,20 @@
 {
 	DECLARE_WAITQUEUE(wait, current);
 
-	down_write(&md->lock);
+	write_lock(&md->lock);
 
 	/*
 	 * First we set the BLOCK_IO flag so no more ios will be
 	 * mapped.
 	 */
 	if (test_bit(DMF_BLOCK_IO, &md->flags)) {
-		up_write(&md->lock);
+		write_unlock(&md->lock);
 		return -EINVAL;
 	}
 
 	set_bit(DMF_BLOCK_IO, &md->flags);
 	add_wait_queue(&md->wait, &wait);
-	up_write(&md->lock);
+	write_unlock(&md->lock);
 
 	/*
 	 * Then we wait for the already mapped ios to
@@ -803,12 +817,12 @@
 	}
 	set_current_state(TASK_RUNNING);
 
-	down_write(&md->lock);
+	write_lock(&md->lock);
 	remove_wait_queue(&md->wait, &wait);
 	set_bit(DMF_SUSPENDED, &md->flags);
 	if (md->map)
 		dm_table_suspend_targets(md->map);
-	up_write(&md->lock);
+	write_unlock(&md->lock);
 
 	return 0;
 }
@@ -817,11 +831,11 @@
 {
 	struct bio *def;
 
-	down_write(&md->lock);
+	write_lock(&md->lock);
 	if (!md->map ||
 	    !test_bit(DMF_SUSPENDED, &md->flags) ||
 	    !dm_table_get_size(md->map)) {
-		up_write(&md->lock);
+		write_unlock(&md->lock);
 		return -EINVAL;
 	}
 
@@ -829,7 +843,7 @@
 	clear_bit(DMF_SUSPENDED, &md->flags);
 	clear_bit(DMF_BLOCK_IO, &md->flags);
 	def = bio_list_get(&md->deferred);
-	up_write(&md->lock);
+	write_unlock(&md->lock);
 
 	flush_deferred_io(def);
 	blk_run_queues();
@@ -844,9 +858,9 @@
 {
 	uint32_t r;
 
-	down_read(&md->lock);
+	read_lock(&md->lock);
 	r = md->event_nr;
-	up_read(&md->lock);
+	read_unlock(&md->lock);
 
 	return r;
 }
@@ -854,23 +868,23 @@
 int dm_add_wait_queue(struct mapped_device *md, wait_queue_t *wq,
 		      uint32_t event_nr)
 {
-	down_write(&md->lock);
+	write_lock(&md->lock);
 	if (event_nr != md->event_nr) {
-		up_write(&md->lock);
+		write_unlock(&md->lock);
 		return 1;
 	}
 
 	add_wait_queue(&md->eventq, wq);
-	up_write(&md->lock);
+	write_unlock(&md->lock);
 
 	return 0;
 }
 
 void dm_remove_wait_queue(struct mapped_device *md, wait_queue_t *wq)
 {
-	down_write(&md->lock);
+	write_lock(&md->lock);
 	remove_wait_queue(&md->eventq, wq);
-	up_write(&md->lock);
+	write_unlock(&md->lock);
 }
 
 /*
@@ -886,11 +900,11 @@
 {
 	struct dm_table *t;
 
-	down_read(&md->lock);
+	read_lock(&md->lock);
 	t = md->map;
 	if (t)
 		dm_table_get(t);
-	up_read(&md->lock);
+	read_unlock(&md->lock);
 
 	return t;
 }
