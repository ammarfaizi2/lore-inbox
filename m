Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262894AbUCJXHx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 18:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbUCJXF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 18:05:59 -0500
Received: from fw.osdl.org ([65.172.181.6]:44434 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262888AbUCJXDp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 18:03:45 -0500
Date: Wed, 10 Mar 2004 15:05:42 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Miquel van Smoorenburg" <miquels@cistron.nl>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] backing dev unplugging
Message-Id: <20040310150542.13d71a39.akpm@osdl.org>
In-Reply-To: <c2o212$4h0$1@news.cistron.nl>
References: <20040310124507.GU4949@suse.de>
	<20040310130046.2df24f0e.akpm@osdl.org>
	<20040310210207.GL15087@suse.de>
	<c2o212$4h0$1@news.cistron.nl>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(Please use reply-to-all)

"Miquel van Smoorenburg" <miquels@cistron.nl> wrote:
>
> In article <20040310210207.GL15087@suse.de>,
> Jens Axboe  <axboe@suse.de> wrote:
> >On Wed, Mar 10 2004, Andrew Morton wrote:
> >> Jens Axboe <axboe@suse.de> wrote:
> >> >
> >> > Here's a first cut at killing global plugging of block devices to reduce
> >> > the nasty contention blk_plug_lock caused.
> >> 
> >> Shouldn't we take read_lock(&md->map_lock) in dm_table_unplug_all()?
> >
> >Ugh yes, we certainly should.
> 
> With the latest patches from Joe it would be more like
> 
> 	map = dm_get_table(md);
> 	if (map) {
> 		dm_table_unplug_all(map);
> 		dm_table_put(map);
> 	}
> 
> No lock ranking issues, you just get a refcounted map (table, really).

Ah, OK.  Jens, you'll be needing this (on rc2-mm1):

dm.c: protect md->map with a rw spin lock rather than the md->lock
semaphore.  Also ensure that everyone accesses md->map through
dm_get_table(), rather than directly.


---

 25-akpm/drivers/md/dm-table.c |    3 +
 25-akpm/drivers/md/dm.c       |   88 +++++++++++++++++++++++++-----------------
 2 files changed, 57 insertions(+), 34 deletions(-)

diff -puN drivers/md/dm.c~dm-map-rwlock-ng drivers/md/dm.c
--- 25/drivers/md/dm.c~dm-map-rwlock-ng	Mon Mar  8 13:58:42 2004
+++ 25-akpm/drivers/md/dm.c	Mon Mar  8 13:58:42 2004
@@ -49,7 +49,7 @@ struct target_io {
 
 struct mapped_device {
 	struct rw_semaphore lock;
-	rwlock_t maplock;
+	rwlock_t map_lock;
 	atomic_t holders;
 
 	unsigned long flags;
@@ -238,6 +238,24 @@ static int queue_io(struct mapped_device
 	return 0;		/* deferred successfully */
 }
 
+/*
+ * Everyone (including functions in this file), should use this
+ * function to access the md->map field, and make sure they call
+ * dm_table_put() when finished.
+ */
+struct dm_table *dm_get_table(struct mapped_device *md)
+{
+	struct dm_table *t;
+
+	read_lock(&md->map_lock);
+	t = md->map;
+	if (t)
+		dm_table_get(t);
+	read_unlock(&md->map_lock);
+
+	return t;
+}
+
 /*-----------------------------------------------------------------
  * CRUD START:
  *   A more elegant soln is in the works that uses the queue
@@ -346,6 +364,7 @@ static void __map_bio(struct dm_target *
 
 struct clone_info {
 	struct mapped_device *md;
+	struct dm_table *map;
 	struct bio *bio;
 	struct dm_io *io;
 	sector_t sector;
@@ -399,7 +418,7 @@ static struct bio *clone_bio(struct bio 
 static void __clone_and_map(struct clone_info *ci)
 {
 	struct bio *clone, *bio = ci->bio;
-	struct dm_target *ti = dm_table_find_target(ci->md->map, ci->sector);
+	struct dm_target *ti = dm_table_find_target(ci->map, ci->sector);
 	sector_t len = 0, max = max_io_len(ci->md, ci->sector, ti);
 	struct target_io *tio;
 
@@ -460,7 +479,7 @@ static void __clone_and_map(struct clone
 
 		ci->sector += max;
 		ci->sector_count -= max;
-		ti = dm_table_find_target(ci->md->map, ci->sector);
+		ti = dm_table_find_target(ci->map, ci->sector);
 
 		len = to_sector(bv->bv_len) - max;
 		clone = split_bvec(bio, ci->sector, ci->idx,
@@ -485,6 +504,7 @@ static void __split_bio(struct mapped_de
 	struct clone_info ci;
 
 	ci.md = md;
+	ci.map = dm_get_table(md);
 	ci.bio = bio;
 	ci.io = alloc_io(md);
 	ci.io->error = 0;
@@ -501,6 +521,7 @@ static void __split_bio(struct mapped_de
 
 	/* drop the extra reference count */
 	dec_pending(ci.io, 0);
+	dm_table_put(ci.map);
 }
 /*-----------------------------------------------------------------
  * CRUD END
@@ -563,15 +584,16 @@ static int dm_request(request_queue_t *q
 static int dm_any_congested(void *congested_data, int bdi_bits)
 {
 	int r;
-	struct mapped_device *md = congested_data;
+	struct mapped_device *md = (struct mapped_device *) congested_data;
+	struct dm_table *map = dm_get_table(md);
 
-	read_lock(&md->maplock);
-	if (md->map == NULL || test_bit(DMF_BLOCK_IO, &md->flags))
+	if (!map || test_bit(DMF_BLOCK_IO, &md->flags))
+		/* FIXME: shouldn't suspended count a congested ? */
 		r = bdi_bits;
 	else
-		r = dm_table_any_congested(md->map, bdi_bits);
-	read_unlock(&md->maplock);
+		r = dm_table_any_congested(map, bdi_bits);
 
+	dm_table_put(map);
 	return r;
 }
 
@@ -646,7 +668,7 @@ static struct mapped_device *alloc_dev(u
 
 	memset(md, 0, sizeof(*md));
 	init_rwsem(&md->lock);
-	rwlock_init(&md->maplock);
+	rwlock_init(&md->map_lock);
 	atomic_set(&md->holders, 1);
 
 	md->queue = blk_alloc_queue(GFP_KERNEL);
@@ -746,12 +768,12 @@ static int __bind(struct mapped_device *
 	if (size == 0)
 		return 0;
 
-	write_lock(&md->maplock);
+	write_lock(&md->map_lock);
 	md->map = t;
-	write_unlock(&md->maplock);
-	dm_table_event_callback(md->map, event_callback, md);
+	write_unlock(&md->map_lock);
 
 	dm_table_get(t);
+	dm_table_event_callback(md->map, event_callback, md);
 	dm_table_set_restrictions(t, q);
 	return 0;
 }
@@ -764,9 +786,9 @@ static void __unbind(struct mapped_devic
 		return;
 
 	dm_table_event_callback(map, NULL, NULL);
-	write_lock(&md->maplock);
+	write_lock(&md->map_lock);
 	md->map = NULL;
-	write_unlock(&md->maplock);
+	write_unlock(&md->map_lock);
 	dm_table_put(map);
 }
 
@@ -803,12 +825,16 @@ void dm_get(struct mapped_device *md)
 
 void dm_put(struct mapped_device *md)
 {
+	struct dm_table *map = dm_get_table(md);
+
 	if (atomic_dec_and_test(&md->holders)) {
-		if (!test_bit(DMF_SUSPENDED, &md->flags) && md->map)
-			dm_table_suspend_targets(md->map);
+		if (!test_bit(DMF_SUSPENDED, &md->flags) && map)
+			dm_table_suspend_targets(map);
 		__unbind(md);
 		free_dev(md);
 	}
+
+	dm_table_put(map);
 }
 
 /*
@@ -859,6 +885,7 @@ int dm_swap_table(struct mapped_device *
  */
 int dm_suspend(struct mapped_device *md)
 {
+	struct dm_table *map;
 	DECLARE_WAITQUEUE(wait, current);
 
 	down_write(&md->lock);
@@ -894,8 +921,11 @@ int dm_suspend(struct mapped_device *md)
 	down_write(&md->lock);
 	remove_wait_queue(&md->wait, &wait);
 	set_bit(DMF_SUSPENDED, &md->flags);
-	if (md->map)
-		dm_table_suspend_targets(md->map);
+
+	map = dm_get_table(md);
+	if (map)
+		dm_table_suspend_targets(map);
+	dm_table_put(map);
 	up_write(&md->lock);
 
 	return 0;
@@ -904,22 +934,25 @@ int dm_suspend(struct mapped_device *md)
 int dm_resume(struct mapped_device *md)
 {
 	struct bio *def;
+	struct dm_table *map = dm_get_table(md);
 
 	down_write(&md->lock);
-	if (!md->map ||
+	if (!map ||
 	    !test_bit(DMF_SUSPENDED, &md->flags) ||
-	    !dm_table_get_size(md->map)) {
+	    !dm_table_get_size(map)) {
 		up_write(&md->lock);
+		dm_table_put(map);
 		return -EINVAL;
 	}
 
-	dm_table_resume_targets(md->map);
+	dm_table_resume_targets(map);
 	clear_bit(DMF_SUSPENDED, &md->flags);
 	clear_bit(DMF_BLOCK_IO, &md->flags);
 
 	def = bio_list_get(&md->deferred);
 	__flush_deferred_io(md, def);
 	up_write(&md->lock);
+	dm_table_put(map);
 
 	blk_run_queues();
 
@@ -971,19 +1004,6 @@ struct gendisk *dm_disk(struct mapped_de
 	return md->disk;
 }
 
-struct dm_table *dm_get_table(struct mapped_device *md)
-{
-	struct dm_table *t;
-
-	down_read(&md->lock);
-	t = md->map;
-	if (t)
-		dm_table_get(t);
-	up_read(&md->lock);
-
-	return t;
-}
-
 int dm_suspended(struct mapped_device *md)
 {
 	return test_bit(DMF_SUSPENDED, &md->flags);
diff -puN drivers/md/dm-table.c~dm-map-rwlock-ng drivers/md/dm-table.c
--- 25/drivers/md/dm-table.c~dm-map-rwlock-ng	Mon Mar  8 13:58:42 2004
+++ 25-akpm/drivers/md/dm-table.c	Mon Mar  8 13:58:42 2004
@@ -279,6 +279,9 @@ void dm_table_get(struct dm_table *t)
 
 void dm_table_put(struct dm_table *t)
 {
+	if (!t)
+		return;
+
 	if (atomic_dec_and_test(&t->holders))
 		table_destroy(t);
 }

_

