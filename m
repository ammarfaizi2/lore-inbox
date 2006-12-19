Return-Path: <linux-kernel-owner+w=401wt.eu-S932936AbWLSWPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932936AbWLSWPJ (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 17:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933045AbWLSWPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 17:15:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:45291 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932936AbWLSWPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 17:15:05 -0500
Date: Tue, 19 Dec 2006 17:14:45 -0500 (EST)
Message-Id: <20061219.171445.03116514.k-ueda@ct.jp.nec.com>
To: jens.axboe@oracle.com, agk@redhat.com, mchristi@redhat.com,
       linux-kernel@vger.kernel.org, dm-devel@redhat.com
Cc: j-nomura@ce.jp.nec.com, k-ueda@ct.jp.nec.com
Subject: [RFC PATCH 8/8] rqbased-dm: change dm-multipath from bio-based to
 request-based
From: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
X-Mailer: Mew version 2.3 on Emacs 20.7 / Mule 4.1
 =?iso-2022-jp?B?KBskQjAqGyhCKQ==?=
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes multipath target from bio-based to request-based.
Multipath internal queue is deleted because md->queue is used.
md->queue is kept in dm_target for easy access from target drivers.

Target internal data (mpath_io) is allocated in prep_map function
and the destination path is determined there.


Signed-off-by: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>

diff -rupN 7-rqbase-dm-core/drivers/md/dm-hw-handler.h 8-rqbase-dm-mpath/drivers/md/dm-hw-handler.h
--- 7-rqbase-dm-core/drivers/md/dm-hw-handler.h	2006-12-11 14:32:53.000000000 -0500
+++ 8-rqbase-dm-mpath/drivers/md/dm-hw-handler.h	2006-12-15 10:46:53.000000000 -0500
@@ -34,6 +34,7 @@ struct hw_handler_type {
 	void (*pg_init) (struct hw_handler *hwh, unsigned bypassed,
 			 struct path *path);
 	unsigned (*error) (struct hw_handler *hwh, struct bio *bio);
+	unsigned (*error_rq) (struct hw_handler *hwh, struct request *rq);
 	int (*status) (struct hw_handler *hwh, status_type_t type,
 		       char *result, unsigned int maxlen);
 };
diff -rupN 7-rqbase-dm-core/drivers/md/dm-mpath.c 8-rqbase-dm-mpath/drivers/md/dm-mpath.c
--- 7-rqbase-dm-core/drivers/md/dm-mpath.c	2006-12-11 14:32:53.000000000 -0500
+++ 8-rqbase-dm-mpath/drivers/md/dm-mpath.c	2006-12-15 11:04:13.000000000 -0500
@@ -76,8 +76,6 @@ struct multipath {
 	unsigned queue_if_no_path;	/* Queue I/O if last path fails? */
 	unsigned saved_queue_if_no_path;/* Saved state during suspension */
 
-	struct work_struct process_queued_ios;
-	struct bio_list queued_ios;
 	unsigned queue_size;
 
 	struct work_struct trigger_event;
@@ -94,7 +92,7 @@ struct multipath {
  */
 struct mpath_io {
 	struct pgpath *pgpath;
-	struct dm_bio_details details;
+	unsigned int err_flags;
 };
 
 typedef int (*action_fn) (struct pgpath *pgpath);
@@ -104,7 +102,6 @@ typedef int (*action_fn) (struct pgpath 
 static kmem_cache_t *_mpio_cache;
 
 struct workqueue_struct *kmultipathd;
-static void process_queued_ios(void *data);
 static void trigger_event(void *data);
 
 
@@ -173,7 +170,6 @@ static struct multipath *alloc_multipath
 		INIT_LIST_HEAD(&m->priority_groups);
 		spin_lock_init(&m->lock);
 		m->queue_io = 1;
-		INIT_WORK(&m->process_queued_ios, process_queued_ios, m);
 		INIT_WORK(&m->trigger_event, trigger_event, m);
 		m->mpio_pool = mempool_create_slab_pool(MIN_IOS, _mpio_cache);
 		if (!m->mpio_pool) {
@@ -282,10 +278,9 @@ failed:
 	m->current_pg = NULL;
 }
 
-static int map_io(struct multipath *m, struct bio *bio, struct mpath_io *mpio,
-		  unsigned was_queued)
+static int prep_map_io(struct multipath *m, struct mpath_io *mpio)
 {
-	int r = 1;
+	int r = BLKPREP_OK;
 	unsigned long flags;
 	struct pgpath *pgpath;
 
@@ -298,25 +293,38 @@ static int map_io(struct multipath *m, s
 
 	pgpath = m->current_pgpath;
 
-	if (was_queued)
-		m->queue_size--;
-
 	if ((pgpath && m->queue_io) ||
 	    (!pgpath && m->queue_if_no_path)) {
-		/* Queue for the daemon to resubmit */
-		bio_list_add(&m->queued_ios, bio);
-		m->queue_size++;
-		if ((m->pg_init_required && !m->pg_init_in_progress) ||
-		    !m->queue_io)
-			queue_work(kmultipathd, &m->process_queued_ios);
-		pgpath = NULL;
-		r = 0;
-	} else if (!pgpath)
-		r = -EIO;		/* Failed */
-	else
-		bio->bi_bdev = pgpath->path.dev->bdev;
+		/*
+		 * Block layer requeue. Will run queue when we get a path,
+		 * timeout, or manual intervention.
+		 * No need m->ti->queue->queue_lock because of already held.
+		 */
+		blk_stop_queue(m->ti->queue);
 
-	mpio->pgpath = pgpath;
+/*
+ * FIXME
+ * hw-handler stuffs are not implemented yet.
+
+		if (m->pg_init_required && !m->pg_init_in_progress) {
+			m->pg_init_required = 0;
+			m->pg_init_in_progress = 1;
+			schedule_work(&mpath->init_pg);
+		}
+*/
+
+		/*
+		 * TODO from Mike Christie:
+		 * if we have no paths and we are waiting on
+		 * queue_if_no_path, set a timer so we do not have to wait
+		 * forever or for manual intervantion.
+		 */
+
+		r = BLKPREP_DEFER;
+	} else if (pgpath) {
+		mpio->pgpath = pgpath;
+	} else
+		r = BLKPREP_KILL;	/* Failed */
 
 	spin_unlock_irqrestore(&m->lock, flags);
 
@@ -338,10 +346,12 @@ static int queue_if_no_path(struct multi
 	else
 		m->saved_queue_if_no_path = queue_if_no_path;
 	m->queue_if_no_path = queue_if_no_path;
-	if (!m->queue_if_no_path && m->queue_size)
-		queue_work(kmultipathd, &m->process_queued_ios);
 
-	spin_unlock_irqrestore(&m->lock, flags);
+	if (!m->queue_if_no_path) {
+		spin_unlock_irqrestore(&m->lock, flags);
+		dm_start_queue(m->ti->queue);
+	} else
+		spin_unlock_irqrestore(&m->lock, flags);
 
 	return 0;
 }
@@ -350,73 +360,6 @@ static int queue_if_no_path(struct multi
  * The multipath daemon is responsible for resubmitting queued ios.
  *---------------------------------------------------------------*/
 
-static void dispatch_queued_ios(struct multipath *m)
-{
-	int r;
-	unsigned long flags;
-	struct bio *bio = NULL, *next;
-	struct mpath_io *mpio;
-	union map_info *info;
-
-	spin_lock_irqsave(&m->lock, flags);
-	bio = bio_list_get(&m->queued_ios);
-	spin_unlock_irqrestore(&m->lock, flags);
-
-	while (bio) {
-		next = bio->bi_next;
-		bio->bi_next = NULL;
-
-		info = dm_get_mapinfo(bio);
-		mpio = info->ptr;
-
-		r = map_io(m, bio, mpio, 1);
-		if (r < 0)
-			bio_endio(bio, bio->bi_size, r);
-		else if (r == 1)
-			generic_make_request(bio);
-
-		bio = next;
-	}
-}
-
-static void process_queued_ios(void *data)
-{
-	struct multipath *m = (struct multipath *) data;
-	struct hw_handler *hwh = &m->hw_handler;
-	struct pgpath *pgpath = NULL;
-	unsigned init_required = 0, must_queue = 1;
-	unsigned long flags;
-
-	spin_lock_irqsave(&m->lock, flags);
-
-	if (!m->queue_size)
-		goto out;
-
-	if (!m->current_pgpath)
-		__choose_pgpath(m);
-
-	pgpath = m->current_pgpath;
-
-	if ((pgpath && !m->queue_io) ||
-	    (!pgpath && !m->queue_if_no_path))
-		must_queue = 0;
-
-	if (m->pg_init_required && !m->pg_init_in_progress) {
-		m->pg_init_required = 0;
-		m->pg_init_in_progress = 1;
-		init_required = 1;
-	}
-
-out:
-	spin_unlock_irqrestore(&m->lock, flags);
-
-	if (init_required)
-		hwh->type->pg_init(hwh, pgpath->pg->bypassed, &pgpath->path);
-
-	if (!must_queue)
-		dispatch_queued_ios(m);
-}
-
 /*
  * An event is triggered whenever a path is taken out of use.
  * Includes path failure and PG bypass.
@@ -697,6 +640,7 @@ static int multipath_ctr(struct dm_targe
 	struct arg_set as;
 	unsigned pg_count = 0;
 	unsigned next_pg_num;
+	struct mapped_device *md;
 
 	as.argc = argc;
 	as.argv = argv;
@@ -747,6 +691,16 @@ static int multipath_ctr(struct dm_targe
 		goto bad;
 	}
 
+	md = dm_table_get_md(m->ti->table);
+	m->ti->queue = dm_get_queue(md);
+	if (!m->ti->queue) {
+		dm_put(md);
+		ti->error = "can't get queue";
+		r = -EINVAL;
+		goto bad;
+	}
+	dm_put(md);
+
 	return 0;
 
  bad:
@@ -759,32 +713,69 @@ static void multipath_dtr(struct dm_targ
 	struct multipath *m = (struct multipath *) ti->private;
 
 	flush_workqueue(kmultipathd);
+	dm_put_queue(ti->queue);
 	free_multipath(m);
 }
 
 /*
- * Map bios, recording original fields for later in case we have to resubmit
+ * Called with ti->queue->queue_lock held
  */
-static int multipath_map(struct dm_target *ti, struct bio *bio,
-			 union map_info *map_context)
+static int multipath_prep_map(struct dm_target *ti, struct request *rq,
+			      struct request_queue *q)
 {
 	int r;
 	struct mpath_io *mpio;
 	struct multipath *m = (struct multipath *) ti->private;
+	struct dm_map_info *mi;
 
-	if (bio_barrier(bio))
-		return -EOPNOTSUPP;
+	if (blk_barrier_rq(rq))
+//FIXME		return -EOPNOTSUPP;
+		return BLKPREP_KILL;
+
+	mpio = mempool_alloc(m->mpio_pool, GFP_ATOMIC);
+	if (!mpio)
+		return BLKPREP_DEFER;
+	memset(mpio, 0, sizeof(*mpio));
 
-	mpio = mempool_alloc(m->mpio_pool, GFP_NOIO);
-	dm_bio_record(&mpio->details, bio);
+	r = prep_map_io(m, mpio);
+	if (r != BLKPREP_OK) {
+		mempool_free(mpio, m->mpio_pool);
+		return r;
+	}
 
-	map_context->ptr = mpio;
-	bio->bi_rw |= (1 << BIO_RW_FAILFAST);
-	r = map_io(m, bio, mpio, 0);
-	if (r < 0)
+	/*
+	 * FIXME
+	 * memory has to be alloced preliminarily like mempool in md or so.
+	 */
+	mi = kzalloc(sizeof(*mi), GFP_ATOMIC);
+	if (!mi) {
 		mempool_free(mpio, m->mpio_pool);
+		return BLKPREP_DEFER;
+	}
 
-	return r;
+	BUG_ON(!mpio->pgpath);
+
+	mi->devs = mpio->pgpath->path.dev->bdev;
+	mi->map_context.ptr = mpio;
+	//mi->num_devs++;
+	rq->special = mi;
+
+	return BLKPREP_OK;
+}
+
+static int multipath_map_rq(struct dm_target *ti, struct request *clone,
+			    union map_info *map_context, struct dm_map_info *mi)
+{
+	struct mpath_io *mpio = (struct mpath_io *)mi->map_context.ptr;
+
+	if (!mpio)
+		BUG();
+
+	clone->cmd_flags |= REQ_FAILFAST;
+	clone->rq_disk = mi->devs->bd_disk;
+	map_context->ptr = mpio;
+
+	return 0;
 }
 
 /*
@@ -847,8 +838,11 @@ static int reinstate_path(struct pgpath 
 	pgpath->path.is_active = 1;
 
 	m->current_pgpath = NULL;
-	if (!m->nr_valid_paths++ && m->queue_size)
-		queue_work(kmultipathd, &m->process_queued_ios);
+	if (!m->nr_valid_paths++) {
+		spin_unlock_irqrestore(&m->lock, flags);
+		dm_start_queue(m->ti->queue);
+		spin_lock_irqsave(&m->lock, flags);
+	}
 
 	queue_work(kmultipathd, &m->trigger_event);
 
@@ -980,43 +974,44 @@ void dm_pg_init_complete(struct path *pa
 		m->queue_io = 0;
 
 	m->pg_init_in_progress = 0;
-	queue_work(kmultipathd, &m->process_queued_ios);
+/* FIXME
+	dm_start_queue(m->ti->queue);
+*/
 	spin_unlock_irqrestore(&m->lock, flags);
 }
 
+static void multipath_free_context(struct dm_target *ti, struct request *rq)
+{
+	struct multipath *m = (struct multipath *) ti->private;
+	struct dm_map_info *mi = (struct dm_map_info *) rq->special;
+	struct mpath_io *mpio = (struct mpath_io *) mi->map_context.ptr;
+
+	if (mpio)
+		mempool_free(mpio, m->mpio_pool);
+}
+
 /*
  * end_io handling
  */
-static int do_end_io(struct multipath *m, struct bio *bio,
-		     int error, struct mpath_io *mpio)
+static int do_end_io_first(struct multipath *m, struct request *clone,
+			   int uptodate, struct mpath_io *mpio)
 {
 	struct hw_handler *hwh = &m->hw_handler;
-	unsigned err_flags = MP_FAIL_PATH;	/* Default behavior */
+	unsigned err_flags = MP_FAIL_PATH;      /* Default behavior */
 	unsigned long flags;
 
-	if (!error)
-		return 0;	/* I/O complete */
-
-	if ((error == -EWOULDBLOCK) && bio_rw_ahead(bio))
-		return error;
-
-	if (error == -EOPNOTSUPP)
-		return error;
+	if (!clone->errors && !end_io_error(uptodate))
+		return 0;       /* I/O complete */
 
-	spin_lock_irqsave(&m->lock, flags);
-	if (!m->nr_valid_paths) {
-		if (!m->queue_if_no_path) {
-			spin_unlock_irqrestore(&m->lock, flags);
-			return -EIO;
-		} else {
-			spin_unlock_irqrestore(&m->lock, flags);
-			goto requeue;
-		}
-	}
-	spin_unlock_irqrestore(&m->lock, flags);
-
-	if (hwh->type && hwh->type->error)
-		err_flags = hwh->type->error(hwh, bio);
+	/*
+	 * TODO: check for different types of errors (transport, device etc)
+	 * This is where the block layer error values will come in handy.
+	 *
+	 * The hw handler just handles its device specific errors (for scsi
+	 * this would be when we have a CHECK_CONDITION for example
+	 */
+	if (hwh->type && hwh->type->error_rq)
+		err_flags = hwh->type->error_rq(hwh, clone);
 
 	if (mpio->pgpath) {
 		if (err_flags & MP_FAIL_PATH)
@@ -1029,22 +1024,30 @@ static int do_end_io(struct multipath *m
 	if (err_flags & MP_ERROR_IO)
 		return -EIO;
 
-      requeue:
-	dm_bio_restore(&mpio->details, bio);
-
-	/* queue for the daemon to resubmit or fail */
 	spin_lock_irqsave(&m->lock, flags);
-	bio_list_add(&m->queued_ios, bio);
-	m->queue_size++;
-	if (!m->queue_io)
-		queue_work(kmultipathd, &m->process_queued_ios);
+	if (!m->nr_valid_paths) {
+		if (!m->queue_if_no_path) {
+			spin_unlock_irqrestore(&m->lock, flags);
+			return -EIO;
+		}
+	}
 	spin_unlock_irqrestore(&m->lock, flags);
 
-	return 1;	/* io not complete */
+	/* we are going to requeue from end_that_request_last */
+	mpio->err_flags = err_flags;
+
+	/*
+	 * For scsi the initial call is with bytes=0 uptodate=1 then from
+	 * failfast we get bytes=complete_request uptodate=0. This is our
+	 * clone so we can do with it what we want.
+	 *
+	 * this will not work for old SG_IO ioctls but how cares dm didn't
+	 */
+	return clone->hard_nr_sectors > 0 ? 1 : 0;
 }
 
-static int multipath_end_io(struct dm_target *ti, struct bio *bio,
-			    int error, union map_info *map_context)
+static int multipath_end_io_first(struct dm_target *ti, struct request *clone,
+				  int uptodate, union map_info *map_context)
 {
 	struct multipath *m = (struct multipath *) ti->private;
 	struct mpath_io *mpio = (struct mpath_io *) map_context->ptr;
@@ -1052,18 +1055,34 @@ static int multipath_end_io(struct dm_ta
 	struct path_selector *ps;
 	int r;
 
-	r  = do_end_io(m, bio, error, mpio);
+	r  = do_end_io_first(m, clone, uptodate, mpio);
 	if (pgpath) {
 		ps = &pgpath->pg->ps;
 		if (ps->type->end_io)
 			ps->type->end_io(ps, &pgpath->path);
 	}
-	if (r <= 0)
-		mempool_free(mpio, m->mpio_pool);
 
 	return r;
 }
 
+static int multipath_end_io(struct dm_target *ti, struct request *clone,
+			    int error, union map_info *map_context)
+{
+	struct multipath *m = (struct multipath *) ti->private;
+	struct mpath_io *mpio = (struct mpath_io *) map_context->ptr;
+	int requeue = 0;
+
+	if (mpio->err_flags) {
+		/* we have parts that need a requeue */
+		DMINFO("requeue request %d\n", error);
+		requeue = 1;
+	}
+
+	mempool_free(mpio, m->mpio_pool);
+
+	return requeue;
+}
+
 /*
  * Suspend can't complete until all the I/O is processed so if
  * the last path fails we must error any remaining I/O.
@@ -1303,8 +1322,11 @@ static struct target_type multipath_targ
 	.module = THIS_MODULE,
 	.ctr = multipath_ctr,
 	.dtr = multipath_dtr,
-	.map = multipath_map,
-	.end_io = multipath_end_io,
+	.prep_map = multipath_prep_map,
+	.map_rq = multipath_map_rq,
+	.free_context = multipath_free_context,
+	.rq_end_io_first = multipath_end_io_first,
+	.rq_end_io = multipath_end_io,
 	.presuspend = multipath_presuspend,
 	.resume = multipath_resume,
 	.status = multipath_status,
diff -rupN 7-rqbase-dm-core/include/linux/device-mapper.h 8-rqbase-dm-mpath/include/linux/device-mapper.h
--- 7-rqbase-dm-core/include/linux/device-mapper.h	2006-12-15 10:45:34.000000000 -0500
+++ 8-rqbase-dm-mpath/include/linux/device-mapper.h	2006-12-15 10:46:53.000000000 -0500
@@ -165,6 +165,8 @@ struct dm_target {
 
 	/* Used to provide an error string from the ctr */
 	char *error;
+
+	struct request_queue *queue;
 };
 
 int dm_register_target(struct target_type *t);

