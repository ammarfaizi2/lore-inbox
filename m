Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262292AbVBKRUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262292AbVBKRUj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 12:20:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262290AbVBKRUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 12:20:39 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43222 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262278AbVBKRPN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 12:15:13 -0500
Date: Fri, 11 Feb 2005 17:15:06 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] device-mapper: multipath
Message-ID: <20050211171506.GX10195@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The core device-mapper multipath and path-selector code.

Paths are grouped into an ordered list of Priority Groups.
Each Priority Group has a Path Selector which chooses which
of the Priority Group's paths is to be used for each bio 
e.g. according to some load-balancing algorithm.
If a bio generates an error, the path that it used gets disabled
and an alternative path is tried.
If all the paths in a Priority Group fail, another Priority
Group is selected.

There are management commands fail_path and reinstate_path.
A path tester (currently implemented in userspace) is responsible 
for monitoring paths that have failed and reinstating them should
they come back.

Other management commands can be use to switch immediately to a 
specified Priority Group or to disable a particular Priority Group
so it will only be tried after there are no more left.

As a last resort there is an option to 'queue_if_no_path' 
which queues I/O if all paths have failed e.g. temporarily
during a firmware update or if the userspace daemon is slow 
reinstating paths.

The userspace multipath tools are available at:
  http://christophe.varoqui.free.fr/
macroflux.png is a diagram of the current architecture.

Signed-Off-By: Alasdair G Kergon <agk@redhat.com>
--- diff/drivers/md/Kconfig	2005-02-07 15:30:59.000000000 +0000
+++ source/drivers/md/Kconfig	2005-02-09 14:41:52.000000000 +0000
@@ -227,5 +227,11 @@
 	  A target that discards writes, and returns all zeroes for
 	  reads.  Useful in some recovery situations.
 
+config DM_MULTIPATH
+	tristate "Multipath target (EXPERIMENTAL)"
+	depends on BLK_DEV_DM && EXPERIMENTAL
+	---help---
+	  Allow volume managers to support multipath hardware.
+
 endmenu
 
--- diff/drivers/md/Makefile	2005-02-07 15:30:59.000000000 +0000
+++ source/drivers/md/Makefile	2005-02-09 14:41:52.000000000 +0000
@@ -4,6 +4,7 @@
 
 dm-mod-objs	:= dm.o dm-table.o dm-target.o dm-linear.o dm-stripe.o \
 		   dm-ioctl.o dm-io.o kcopyd.o
+dm-multipath-objs := dm-path-selector.o dm-mpath.o
 dm-snapshot-objs := dm-snap.o dm-exception-store.o
 dm-mirror-objs	:= dm-log.o dm-raid1.o
 raid6-objs	:= raid6main.o raid6algos.o raid6recov.o raid6tables.o \
@@ -30,6 +31,7 @@
 obj-$(CONFIG_BLK_DEV_MD)	+= md.o
 obj-$(CONFIG_BLK_DEV_DM)	+= dm-mod.o
 obj-$(CONFIG_DM_CRYPT)		+= dm-crypt.o
+obj-$(CONFIG_DM_MULTIPATH)	+= dm-multipath.o
 obj-$(CONFIG_DM_SNAPSHOT)	+= dm-snapshot.o
 obj-$(CONFIG_DM_MIRROR)		+= dm-mirror.o
 obj-$(CONFIG_DM_ZERO)		+= dm-zero.o
--- diff/drivers/md/dm-mpath.c	1970-01-01 01:00:00.000000000 +0100
+++ source/drivers/md/dm-mpath.c	2005-02-09 14:41:52.000000000 +0000
@@ -0,0 +1,1186 @@
+/*
+ * Copyright (C) 2003 Sistina Software Limited.
+ * Copyright (C) 2004-2005 Red Hat, Inc. All rights reserved.
+ *
+ * This file is released under the GPL.
+ */
+
+#include "dm.h"
+#include "dm-path-selector.h"
+#include "dm-bio-list.h"
+#include "dm-bio-record.h"
+
+#include <linux/ctype.h>
+#include <linux/init.h>
+#include <linux/mempool.h>
+#include <linux/module.h>
+#include <linux/pagemap.h>
+#include <linux/slab.h>
+#include <linux/time.h>
+#include <linux/workqueue.h>
+#include <asm/atomic.h>
+
+#define MESG_STR(x) x, sizeof(x)
+
+/* Path properties */
+struct pgpath {
+	struct list_head list;
+
+	struct priority_group *pg;	/* Owning PG */
+	unsigned fail_count;		/* Cumulative failure count */
+
+	struct path path;
+};
+
+#define path_to_pgpath(__pgp) container_of((__pgp), struct pgpath, path)
+
+/*
+ * Paths are grouped into Priority Groups and numbered from 1 upwards.
+ * Each has a path selector which controls which path gets used.
+ */
+struct priority_group {
+	struct list_head list;
+
+	struct multipath *m;		/* Owning multipath instance */
+	struct path_selector ps;
+
+	unsigned pg_num;		/* Reference number */
+	unsigned bypassed;		/* Temporarily bypass this PG? */
+
+	unsigned nr_pgpaths;		/* Number of paths in PG */
+	struct list_head pgpaths;
+};
+
+/* Multipath context */
+struct multipath {
+	struct list_head list;
+	struct dm_target *ti;
+
+	spinlock_t lock;
+
+	unsigned nr_priority_groups;
+	struct list_head priority_groups;
+
+	unsigned nr_valid_paths;	/* Total number of usable paths */
+	struct pgpath *current_pgpath;
+	struct priority_group *current_pg;
+	struct priority_group *next_pg;	/* Switch to this PG if set */
+	unsigned repeat_count;		/* I/Os left before calling PS again */
+
+	unsigned queue_io;		/* Must we queue all I/O? */
+	unsigned queue_if_no_path;	/* Queue I/O if last path fails? */
+	unsigned suspended;		/* Has dm core suspended our I/O? */
+
+	struct work_struct process_queued_ios;
+	struct bio_list queued_ios;
+	unsigned queue_size;
+
+	struct work_struct trigger_event;
+
+	/*
+	 * We must use a mempool of mpath_io structs so that we
+	 * can resubmit bios on error.
+	 */
+	mempool_t *mpio_pool;
+};
+
+/*
+ * Context information attached to each bio we process.
+ */
+struct mpath_io {
+	struct pgpath *pgpath;
+	struct dm_bio_details details;
+};
+
+typedef int (*action_fn) (struct pgpath *pgpath);
+
+#define MIN_IOS 256	/* Mempool size */
+
+static kmem_cache_t *_mpio_cache;
+
+static void process_queued_ios(void *data);
+static void trigger_event(void *data);
+
+
+/*-----------------------------------------------
+ * Allocation routines
+ *-----------------------------------------------*/
+
+static struct pgpath *alloc_pgpath(void)
+{
+	struct pgpath *pgpath = kmalloc(sizeof(*pgpath), GFP_KERNEL);
+
+	if (pgpath) {
+		memset(pgpath, 0, sizeof(*pgpath));
+		pgpath->path.is_active = 1;
+	}
+
+	return pgpath;
+}
+
+static inline void free_pgpath(struct pgpath *pgpath)
+{
+	kfree(pgpath);
+}
+
+static struct priority_group *alloc_priority_group(void)
+{
+	struct priority_group *pg;
+
+	pg = kmalloc(sizeof(*pg), GFP_KERNEL);
+	if (!pg)
+		return NULL;
+
+	memset(pg, 0, sizeof(*pg));
+	INIT_LIST_HEAD(&pg->pgpaths);
+
+	return pg;
+}
+
+static void free_pgpaths(struct list_head *pgpaths, struct dm_target *ti)
+{
+	struct pgpath *pgpath, *tmp;
+
+	list_for_each_entry_safe (pgpath, tmp, pgpaths, list) {
+		list_del(&pgpath->list);
+		dm_put_device(ti, pgpath->path.dev);
+		free_pgpath(pgpath);
+	}
+}
+
+static void free_priority_group(struct priority_group *pg,
+				struct dm_target *ti)
+{
+	struct path_selector *ps = &pg->ps;
+
+	if (ps->type) {
+		ps->type->dtr(ps);
+		dm_put_path_selector(ps->type);
+	}
+
+	free_pgpaths(&pg->pgpaths, ti);
+	kfree(pg);
+}
+
+static struct multipath *alloc_multipath(void)
+{
+	struct multipath *m;
+
+	m = kmalloc(sizeof(*m), GFP_KERNEL);
+	if (m) {
+		memset(m, 0, sizeof(*m));
+		INIT_LIST_HEAD(&m->priority_groups);
+		m->lock = SPIN_LOCK_UNLOCKED;
+		m->queue_io = 1;
+		INIT_WORK(&m->process_queued_ios, process_queued_ios, m);
+		INIT_WORK(&m->trigger_event, trigger_event, m);
+		m->mpio_pool = mempool_create(MIN_IOS, mempool_alloc_slab,
+					      mempool_free_slab, _mpio_cache);
+		if (!m->mpio_pool) {
+			kfree(m);
+			return NULL;
+		}
+	}
+
+	return m;
+}
+
+static void free_multipath(struct multipath *m)
+{
+	struct priority_group *pg, *tmp;
+
+	list_for_each_entry_safe (pg, tmp, &m->priority_groups, list) {
+		list_del(&pg->list);
+		free_priority_group(pg, m->ti);
+	}
+
+	mempool_destroy(m->mpio_pool);
+	kfree(m);
+}
+
+
+/*-----------------------------------------------
+ * Path selection
+ *-----------------------------------------------*/
+
+static void __switch_pg(struct multipath *m, struct pgpath *pgpath)
+{
+	m->current_pg = pgpath->pg;
+	m->queue_io = 0;
+}
+
+static int __choose_path_in_pg(struct multipath *m, struct priority_group *pg)
+{
+	struct path *path;
+
+	path = pg->ps.type->select_path(&pg->ps, &m->repeat_count);
+	if (!path)
+		return -ENXIO;
+
+	m->current_pgpath = path_to_pgpath(path);
+
+	if (m->current_pg != pg)
+		__switch_pg(m, m->current_pgpath);
+
+	return 0;
+}
+
+static void __choose_pgpath(struct multipath *m)
+{
+	struct priority_group *pg;
+	unsigned bypassed = 1;
+
+	if (!m->nr_valid_paths)
+		goto failed;
+
+	/* Were we instructed to switch PG? */
+	if (m->next_pg) {
+		pg = m->next_pg;
+		m->next_pg = NULL;
+		if (!__choose_path_in_pg(m, pg))
+			return;
+	}
+
+	/* Don't change PG until it has no remaining paths */
+	if (m->current_pg && !__choose_path_in_pg(m, m->current_pg))
+		return;
+
+	/*
+	 * Loop through priority groups until we find a valid path.
+	 * First time we skip PGs marked 'bypassed'.
+	 * Second time we only try the ones we skipped.
+	 */
+	do {
+		list_for_each_entry (pg, &m->priority_groups, list) {
+			if (pg->bypassed == bypassed)
+				continue;
+			if (!__choose_path_in_pg(m, pg))
+				return;
+		}
+	} while (bypassed--);
+
+failed:
+	m->current_pgpath = NULL;
+	m->current_pg = NULL;
+}
+
+static int map_io(struct multipath *m, struct bio *bio, struct mpath_io *mpio,
+		  unsigned was_queued)
+{
+	int r = 1;
+	unsigned long flags;
+	struct pgpath *pgpath;
+
+	spin_lock_irqsave(&m->lock, flags);
+
+	/* Do we need to select a new pgpath? */
+	if (!m->current_pgpath ||
+	    (!m->queue_io && (m->repeat_count && --m->repeat_count == 0)))
+		__choose_pgpath(m);
+
+	pgpath = m->current_pgpath;
+
+	if (was_queued)
+		m->queue_size--;
+
+	if ((pgpath && m->queue_io) ||
+	    (!pgpath && m->queue_if_no_path && !m->suspended)) {
+		/* Queue for the daemon to resubmit */
+		bio_list_add(&m->queued_ios, bio);
+		m->queue_size++;
+		if (!m->queue_io)
+			schedule_work(&m->process_queued_ios);
+		pgpath = NULL;
+		r = 0;
+	} else if (!pgpath)
+		r = -EIO;		/* Failed */
+	else
+		bio->bi_bdev = pgpath->path.dev->bdev;
+
+	mpio->pgpath = pgpath;
+
+	spin_unlock_irqrestore(&m->lock, flags);
+
+	return r;
+}
+
+/*
+ * If we run out of usable paths, should we queue I/O or error it?
+ */
+static int queue_if_no_path(struct multipath *m, unsigned queue_if_no_path)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&m->lock, flags);
+
+	m->queue_if_no_path = queue_if_no_path;
+	if (!m->queue_if_no_path)
+		schedule_work(&m->process_queued_ios);
+
+	spin_unlock_irqrestore(&m->lock, flags);
+
+	return 0;
+}
+
+/*-----------------------------------------------------------------
+ * The multipath daemon is responsible for resubmitting queued ios.
+ *---------------------------------------------------------------*/
+
+static void dispatch_queued_ios(struct multipath *m)
+{
+	int r;
+	unsigned long flags;
+	struct bio *bio = NULL, *next;
+	struct mpath_io *mpio;
+	union map_info *info;
+
+	spin_lock_irqsave(&m->lock, flags);
+	bio = bio_list_get(&m->queued_ios);
+	spin_unlock_irqrestore(&m->lock, flags);
+
+	while (bio) {
+		next = bio->bi_next;
+		bio->bi_next = NULL;
+
+		info = dm_get_mapinfo(bio);
+		mpio = info->ptr;
+
+		r = map_io(m, bio, mpio, 1);
+		if (r < 0)
+			bio_endio(bio, bio->bi_size, r);
+		else if (r == 1)
+			generic_make_request(bio);
+
+		bio = next;
+	}
+}
+
+static void process_queued_ios(void *data)
+{
+	struct multipath *m = (struct multipath *) data;
+	struct pgpath *pgpath;
+	unsigned must_queue = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&m->lock, flags);
+
+	if (!m->current_pgpath)
+		__choose_pgpath(m);
+
+	pgpath = m->current_pgpath;
+
+	if ((pgpath && m->queue_io) ||
+	    (!pgpath && m->queue_if_no_path && !m->suspended))
+		must_queue = 1;
+
+	spin_unlock_irqrestore(&m->lock, flags);
+
+	if (!must_queue)
+		dispatch_queued_ios(m);
+}
+
+/*
+ * An event is triggered whenever a path is taken out of use.
+ * Includes path failure and PG bypass.
+ */
+static void trigger_event(void *data)
+{
+	struct multipath *m = (struct multipath *) data;
+
+	dm_table_event(m->ti->table);
+}
+
+/*-----------------------------------------------------------------
+ * Constructor/argument parsing:
+ * <#multipath feature args> [<arg>]*
+ * <#priority groups> 
+ * <initial priority group>
+ *     [<selector> <#selector args> [<arg>]*
+ *      <#paths> <#per-path selector args> 
+ *         [<path> [<arg>]* ]+ ]+
+ *---------------------------------------------------------------*/
+struct param {
+	unsigned min;
+	unsigned max;
+	char *error;
+};
+
+#define ESTR(s) ("dm-multipath: " s)
+
+static int read_param(struct param *param, char *str, unsigned *v, char **error)
+{
+	if (!str ||
+	    (sscanf(str, "%u", v) != 1) ||
+	    (*v < param->min) ||
+	    (*v > param->max)) {
+		*error = param->error;
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+struct arg_set {
+	unsigned argc;
+	char **argv;
+};
+
+static char *shift(struct arg_set *as)
+{
+	char *r;
+
+	if (as->argc) {
+		as->argc--;
+		r = *as->argv;
+		as->argv++;
+		return r;
+	}
+
+	return NULL;
+}
+
+static void consume(struct arg_set *as, unsigned n)
+{
+	BUG_ON (as->argc < n);
+	as->argc -= n;
+	as->argv += n;
+}
+
+static int parse_path_selector(struct arg_set *as, struct priority_group *pg,
+			       struct dm_target *ti)
+{
+	int r;
+	struct path_selector_type *pst;
+	unsigned ps_argc;
+
+	static struct param _params[] = {
+		{0, 1024, ESTR("invalid number of path selector args")},
+	};
+
+	pst = dm_get_path_selector(shift(as));
+	if (!pst) {
+		ti->error = ESTR("unknown path selector type");
+		return -EINVAL;
+	}
+
+	r = read_param(_params, shift(as), &ps_argc, &ti->error);
+	if (r)
+		return -EINVAL;
+
+	r = pst->ctr(&pg->ps, ps_argc, as->argv);
+	if (r) {
+		dm_put_path_selector(pst);
+		ti->error = ESTR("path selector constructor failed");
+		return r;
+	}
+
+	pg->ps.type = pst;
+	consume(as, ps_argc);
+
+	return 0;
+}
+
+static struct pgpath *parse_path(struct arg_set *as, struct path_selector *ps,
+			       struct dm_target *ti)
+{
+	int r;
+	struct pgpath *p;
+
+	/* we need at least a path arg */
+	if (as->argc < 1) {
+		ti->error = ESTR("no device given");
+		return NULL;
+	}
+
+	p = alloc_pgpath();
+	if (!p)
+		return NULL;
+
+	r = dm_get_device(ti, shift(as), ti->begin, ti->len,
+			  dm_table_get_mode(ti->table), &p->path.dev);
+	if (r) {
+		ti->error = ESTR("error getting device");
+		goto bad;
+	}
+
+	r = ps->type->add_path(ps, &p->path, as->argc, as->argv, &ti->error);
+	if (r) {
+		dm_put_device(ti, p->path.dev);
+		goto bad;
+	}
+
+	return p;
+
+ bad:
+	free_pgpath(p);
+	return NULL;
+}
+
+static struct priority_group *parse_priority_group(struct arg_set *as,
+						   struct multipath *m,
+						   struct dm_target *ti)
+{
+	static struct param _params[] = {
+		{1, 1024, ESTR("invalid number of paths")},
+		{0, 1024, ESTR("invalid number of selector args")}
+	};
+
+	int r;
+	unsigned i, nr_selector_args, nr_params;
+	struct priority_group *pg;
+
+	if (as->argc < 2) {
+		as->argc = 0;
+		ti->error = ESTR("not enough priority group aruments");
+		return NULL;
+	}
+
+	pg = alloc_priority_group();
+	if (!pg) {
+		ti->error = ESTR("couldn't allocate priority group");
+		return NULL;
+	}
+	pg->m = m;
+
+	r = parse_path_selector(as, pg, ti);
+	if (r)
+		goto bad;
+
+	/*
+	 * read the paths
+	 */
+	r = read_param(_params, shift(as), &pg->nr_pgpaths, &ti->error);
+	if (r)
+		goto bad;
+
+	r = read_param(_params + 1, shift(as), &nr_selector_args, &ti->error);
+	if (r)
+		goto bad;
+
+	nr_params = 1 + nr_selector_args;
+	for (i = 0; i < pg->nr_pgpaths; i++) {
+		struct pgpath *pgpath;
+		struct arg_set path_args;
+
+		if (as->argc < nr_params)
+			goto bad;
+
+		path_args.argc = nr_params;
+		path_args.argv = as->argv;
+
+		pgpath = parse_path(&path_args, &pg->ps, ti);
+		if (!pgpath)
+			goto bad;
+
+		pgpath->pg = pg;
+		list_add_tail(&pgpath->list, &pg->pgpaths);
+		consume(as, nr_params);
+	}
+
+	return pg;
+
+ bad:
+	free_priority_group(pg, ti);
+	return NULL;
+}
+
+static int parse_features(struct arg_set *as, struct multipath *m,
+			  struct dm_target *ti)
+{
+	int r;
+	unsigned argc;
+
+	static struct param _params[] = {
+		{0, 1, ESTR("invalid number of feature args")},
+	};
+
+	r = read_param(_params, shift(as), &argc, &ti->error);
+	if (r)
+		return -EINVAL;
+
+	if (!argc)
+		return 0;
+
+	if (!strnicmp(shift(as), MESG_STR("queue_if_no_path")))
+		return queue_if_no_path(m, 1);
+	else {
+		ti->error = "Unrecognised multipath feature request";
+		return -EINVAL;
+	}
+}
+
+static int multipath_ctr(struct dm_target *ti, unsigned int argc,
+			 char **argv)
+{
+	/* target parameters */
+	static struct param _params[] = {
+		{1, 1024, ESTR("invalid number of priority groups")},
+		{1, 1024, ESTR("invalid initial priority group number")},
+	};
+
+	int r;
+	struct multipath *m;
+	struct arg_set as;
+	unsigned pg_count = 0;
+	unsigned next_pg_num;
+
+	as.argc = argc;
+	as.argv = argv;
+
+	m = alloc_multipath();
+	if (!m) {
+		ti->error = ESTR("can't allocate multipath");
+		return -EINVAL;
+	}
+
+	r = parse_features(&as, m, ti);
+	if (r)
+		goto bad;
+
+	r = read_param(_params, shift(&as), &m->nr_priority_groups, &ti->error);
+	if (r)
+		goto bad;
+
+	r = read_param(_params + 1, shift(&as), &next_pg_num, &ti->error);
+	if (r)
+		goto bad;
+
+	/* parse the priority groups */
+	while (as.argc) {
+		struct priority_group *pg;
+
+		pg = parse_priority_group(&as, m, ti);
+		if (!pg) {
+			r = -EINVAL;
+			goto bad;
+		}
+
+		m->nr_valid_paths += pg->nr_pgpaths;
+		list_add_tail(&pg->list, &m->priority_groups);
+		pg_count++;
+		pg->pg_num = pg_count;
+		if (!--next_pg_num)
+			m->next_pg = pg;
+	}
+
+	if (pg_count != m->nr_priority_groups) {
+		ti->error = ESTR("priority group count mismatch");
+		r = -EINVAL;
+		goto bad;
+	}
+
+	ti->private = m;
+	m->ti = ti;
+
+	return 0;
+
+ bad:
+	free_multipath(m);
+	return r;
+}
+
+static void multipath_dtr(struct dm_target *ti)
+{
+	struct multipath *m = (struct multipath *) ti->private;
+	free_multipath(m);
+}
+
+/*
+ * Map bios, recording original fields for later in case we have to resubmit
+ */
+static int multipath_map(struct dm_target *ti, struct bio *bio,
+			 union map_info *map_context)
+{
+	int r;
+	struct mpath_io *mpio;
+	struct multipath *m = (struct multipath *) ti->private;
+
+	mpio = mempool_alloc(m->mpio_pool, GFP_NOIO);
+	dm_bio_record(&mpio->details, bio);
+
+	map_context->ptr = mpio;
+	bio->bi_rw |= (1 << BIO_RW_FAILFAST);
+	r = map_io(m, bio, mpio, 0);
+	if (r < 0)
+		mempool_free(mpio, m->mpio_pool);
+
+	return r;
+}
+
+/*
+ * Take a path out of use.
+ */
+static int fail_path(struct pgpath *pgpath)
+{
+	unsigned long flags;
+	struct multipath *m = pgpath->pg->m;
+
+	spin_lock_irqsave(&m->lock, flags);
+
+	if (!pgpath->path.is_active)
+		goto out;
+
+	DMWARN("dm-multipath: Failing path %s.", pgpath->path.dev->name);
+
+	pgpath->pg->ps.type->fail_path(&pgpath->pg->ps, &pgpath->path);
+	pgpath->path.is_active = 0;
+	pgpath->fail_count++;
+
+	m->nr_valid_paths--;
+
+	if (pgpath == m->current_pgpath)
+		m->current_pgpath = NULL;
+
+	schedule_work(&m->trigger_event);
+
+out:
+	spin_unlock_irqrestore(&m->lock, flags);
+
+	return 0;
+}
+
+/*
+ * Reinstate a previously-failed path
+ */
+static int reinstate_path(struct pgpath *pgpath)
+{
+	int r = 0;
+	unsigned long flags;
+	struct multipath *m = pgpath->pg->m;
+
+	spin_lock_irqsave(&m->lock, flags);
+
+	if (pgpath->path.is_active)
+		goto out;
+
+	if (!pgpath->pg->ps.type) {
+		DMWARN("Reinstate path not supported by path selector %s",
+		       pgpath->pg->ps.type->name);
+		r = -EINVAL;
+		goto out;
+	}
+
+	r = pgpath->pg->ps.type->reinstate_path(&pgpath->pg->ps, &pgpath->path);
+	if (r)
+		goto out;
+
+	pgpath->path.is_active = 1;
+
+	m->current_pgpath = NULL;
+	if (!m->nr_valid_paths++)
+		schedule_work(&m->process_queued_ios);
+
+	schedule_work(&m->trigger_event);
+
+out:
+	spin_unlock_irqrestore(&m->lock, flags);
+
+	return r;
+}
+
+/*
+ * Fail or reinstate all paths that match the provided struct dm_dev.
+ */
+static int action_dev(struct multipath *m, struct dm_dev *dev,
+		      action_fn action)
+{
+	int r = 0;
+	struct pgpath *pgpath;
+	struct priority_group *pg;
+
+	list_for_each_entry(pg, &m->priority_groups, list) {
+		list_for_each_entry(pgpath, &pg->pgpaths, list) {
+			if (pgpath->path.dev == dev)
+				r = action(pgpath);
+		}
+	}
+
+	return r;
+}
+
+/*
+ * Temporarily try to avoid having to use the specified PG
+ */
+static void bypass_pg(struct multipath *m, struct priority_group *pg,
+		      int bypassed)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&m->lock, flags);
+
+	pg->bypassed = bypassed;
+	m->current_pgpath = NULL;
+	m->current_pg = NULL;
+
+	spin_unlock_irqrestore(&m->lock, flags);
+
+	schedule_work(&m->trigger_event);
+}
+
+/*
+ * Switch to using the specified PG from the next I/O that gets mapped
+ */
+static int switch_pg_num(struct multipath *m, const char *pgstr)
+{
+	struct priority_group *pg;
+	unsigned pgnum;
+	unsigned long flags;
+
+	if (!pgstr || (sscanf(pgstr, "%u", &pgnum) != 1) || !pgnum ||
+	    (pgnum > m->nr_priority_groups)) {
+		DMWARN("invalid PG number supplied to switch_pg_num");
+		return -EINVAL;
+	}
+
+	spin_lock_irqsave(&m->lock, flags);
+	list_for_each_entry(pg, &m->priority_groups, list) {
+		pg->bypassed = 0;
+		if (--pgnum)
+			continue;
+
+		m->current_pgpath = NULL;
+		m->current_pg = NULL;
+		m->next_pg = pg;
+	}
+	spin_unlock_irqrestore(&m->lock, flags);
+
+	schedule_work(&m->trigger_event);
+	return 0;
+}
+
+/*
+ * Set/clear bypassed status of a PG.
+ * PGs are numbered upwards from 1 in the order they were declared.
+ */
+static int bypass_pg_num(struct multipath *m, const char *pgstr, int bypassed)
+{
+	struct priority_group *pg;
+	unsigned pgnum;
+
+	if (!pgstr || (sscanf(pgstr, "%u", &pgnum) != 1) || !pgnum ||
+	    (pgnum > m->nr_priority_groups)) {
+		DMWARN("invalid PG number supplied to bypass_pg");
+		return -EINVAL;
+	}
+
+	list_for_each_entry(pg, &m->priority_groups, list) {
+		if (!--pgnum)
+			break;
+	}
+
+	bypass_pg(m, pg, bypassed);
+	return 0;
+}
+
+/*
+ * end_io handling
+ */
+static int do_end_io(struct multipath *m, struct bio *bio,
+		     int error, struct mpath_io *mpio)
+{
+	unsigned err_flags = MP_FAIL_PATH;	/* Default behavior */
+
+	if (!error)
+		return 0;	/* I/O complete */
+
+	spin_lock(&m->lock);
+	if (!m->nr_valid_paths) {
+		if (!m->queue_if_no_path) {
+			spin_unlock(&m->lock);
+			return -EIO;
+		} else {
+			spin_unlock(&m->lock);
+			goto requeue;
+		}
+	}
+	spin_unlock(&m->lock);
+
+	if (mpio->pgpath) {
+		if (err_flags & MP_FAIL_PATH)
+			fail_path(mpio->pgpath);
+	
+		if (err_flags & MP_BYPASS_PG)
+			bypass_pg(m, mpio->pgpath->pg, 1);
+	}
+
+	if (err_flags & MP_ERROR_IO)
+		return -EIO;
+
+      requeue:
+	dm_bio_restore(&mpio->details, bio);
+
+	/* queue for the daemon to resubmit or fail */
+	spin_lock(&m->lock);
+	bio_list_add(&m->queued_ios, bio);
+	m->queue_size++;
+	if (!m->queue_io)
+		schedule_work(&m->process_queued_ios);
+	spin_unlock(&m->lock);
+
+	return 1;	/* io not complete */
+}
+
+static int multipath_end_io(struct dm_target *ti, struct bio *bio,
+			    int error, union map_info *map_context)
+{
+	struct multipath *m = (struct multipath *) ti->private;
+	struct mpath_io *mpio = (struct mpath_io *) map_context->ptr;
+	struct pgpath *pgpath = mpio->pgpath;
+	struct path_selector *ps;
+	int r;
+
+	r  = do_end_io(m, bio, error, mpio);
+	if (pgpath) {
+		ps = &pgpath->pg->ps;
+		if (ps->type->end_io)
+			ps->type->end_io(ps, &pgpath->path);
+	}
+	if (r <= 0)
+		mempool_free(mpio, m->mpio_pool);
+
+	return r;
+}
+
+/*
+ * Suspend can't complete until all the I/O is processed so if
+ * the last path failed we will now error any queued I/O.
+ */
+static void multipath_presuspend(struct dm_target *ti)
+{
+	struct multipath *m = (struct multipath *) ti->private;
+	unsigned long flags;
+
+	spin_lock_irqsave(&m->lock, flags);
+	m->suspended = 1;
+	if (m->queue_if_no_path)
+		schedule_work(&m->process_queued_ios);
+	spin_unlock_irqrestore(&m->lock, flags);
+}
+
+static void multipath_resume(struct dm_target *ti)
+{
+	struct multipath *m = (struct multipath *) ti->private;
+	unsigned long flags;
+
+	spin_lock_irqsave(&m->lock, flags);
+	m->suspended = 0;
+	spin_unlock_irqrestore(&m->lock, flags);
+}
+
+/*
+ * Info output has the following format:
+ * num_multipath_feature_args [multipath_feature_args]*
+ * num_groups init_group_number
+ *            [A|D|E num_ps_status_args [ps_status_args]*
+ *             num_paths num_selector_args 
+ *             [path_dev A|F fail_count [selector_args]* ]+ ]+
+ *
+ * Table output has the following format (identical to the constructor string):
+ * num_feature_args [features_args]*
+ * num_groups init_group_number
+ *     [priority selector-name num_ps_args [ps_args]*
+ *      num_paths num_selector_args [path_dev [selector_args]* ]+ ]+
+ */
+static int multipath_status(struct dm_target *ti, status_type_t type,
+			    char *result, unsigned int maxlen)
+{
+	int sz = 0;
+	unsigned long flags;
+	struct multipath *m = (struct multipath *) ti->private;
+	struct priority_group *pg;
+	struct pgpath *p;
+	unsigned pg_num;
+	char state;
+
+	spin_lock_irqsave(&m->lock, flags);
+
+	/* Features */
+	if (type == STATUSTYPE_INFO)
+		DMEMIT("1 %u ", m->queue_size);
+	else if (m->queue_if_no_path)
+		DMEMIT("1 queue_if_no_path ");
+	else
+		DMEMIT("0 ");
+
+	DMEMIT("%u ", m->nr_priority_groups);
+
+	if (m->next_pg)
+		pg_num = m->next_pg->pg_num;
+	else if (m->current_pg)	
+		pg_num = m->current_pg->pg_num;
+	else
+			pg_num = 1;
+
+	DMEMIT("%u ", pg_num);
+
+	switch (type) {
+	case STATUSTYPE_INFO:
+		list_for_each_entry(pg, &m->priority_groups, list) {
+			if (pg->bypassed)
+				state = 'D';	/* Disabled */
+			else if (pg == m->current_pg)
+				state = 'A';	/* Currently Active */
+			else
+				state = 'E';	/* Enabled */
+
+			DMEMIT("%c ", state);
+
+			if (pg->ps.type->status)
+				sz += pg->ps.type->status(&pg->ps, NULL, type,
+							  result + sz,
+							  maxlen - sz);
+			else
+				DMEMIT("0 ");
+
+			DMEMIT("%u %u ", pg->nr_pgpaths,
+			       pg->ps.type->info_args);
+
+			list_for_each_entry(p, &pg->pgpaths, list) {
+				DMEMIT("%s %s %u ", p->path.dev->name,
+				       p->path.is_active ? "A" : "F",
+				       p->fail_count);
+				if (pg->ps.type->status)
+					sz += pg->ps.type->status(&pg->ps,
+					      &p->path, type, result + sz,
+					      maxlen - sz);
+			}
+		}
+		break;
+
+	case STATUSTYPE_TABLE:
+		list_for_each_entry(pg, &m->priority_groups, list) {
+			DMEMIT("%s ", pg->ps.type->name);
+
+			if (pg->ps.type->status)
+				sz += pg->ps.type->status(&pg->ps, NULL, type,
+							  result + sz,
+							  maxlen - sz);
+			else
+				DMEMIT("0 ");
+
+			DMEMIT("%u %u ", pg->nr_pgpaths,
+			       pg->ps.type->table_args);
+
+			list_for_each_entry(p, &pg->pgpaths, list) {
+				DMEMIT("%s ", p->path.dev->name);
+				if (pg->ps.type->status)
+					sz += pg->ps.type->status(&pg->ps,
+					      &p->path, type, result + sz,
+					      maxlen - sz);
+			}
+		}
+		break;
+	}
+
+	spin_unlock_irqrestore(&m->lock, flags);
+
+	return 0;
+}
+
+static int multipath_message(struct dm_target *ti, unsigned argc, char **argv)
+{
+	int r;
+	struct dm_dev *dev;
+	struct multipath *m = (struct multipath *) ti->private;
+	action_fn action;
+
+	if (argc == 1) {
+		if (!strnicmp(argv[0], MESG_STR("queue_if_no_path")))
+			return queue_if_no_path(m, 1);
+		else if (!strnicmp(argv[0], MESG_STR("fail_if_no_path")))
+			return queue_if_no_path(m, 0);
+	}
+
+	if (argc != 2)
+		goto error;
+
+	if (!strnicmp(argv[0], MESG_STR("disable_group")))
+		return bypass_pg_num(m, argv[1], 1);
+	else if (!strnicmp(argv[0], MESG_STR("enable_group")))
+		return bypass_pg_num(m, argv[1], 0);
+	else if (!strnicmp(argv[0], MESG_STR("switch_group")))
+		return switch_pg_num(m, argv[1]);
+	else if (!strnicmp(argv[0], MESG_STR("reinstate_path")))
+		action = reinstate_path;
+	else if (!strnicmp(argv[0], MESG_STR("fail_path")))
+		action = fail_path;
+	else
+		goto error;
+
+	r = dm_get_device(ti, argv[1], ti->begin, ti->len,
+			  dm_table_get_mode(ti->table), &dev);
+	if (r) {
+		DMWARN("dm-multipath message: error getting device %s",
+		       argv[1]);
+		return -EINVAL;
+	}
+
+	r = action_dev(m, dev, action);
+
+	dm_put_device(ti, dev);
+
+	return r;
+
+error:
+	DMWARN("Unrecognised multipath message received.");
+	return -EINVAL;
+}
+
+/*-----------------------------------------------------------------
+ * Module setup
+ *---------------------------------------------------------------*/
+static struct target_type multipath_target = {
+	.name = "multipath",
+	.version = {1, 0, 4},
+	.module = THIS_MODULE,
+	.ctr = multipath_ctr,
+	.dtr = multipath_dtr,
+	.map = multipath_map,
+	.end_io = multipath_end_io,
+	.presuspend = multipath_presuspend,
+	.resume = multipath_resume,
+	.status = multipath_status,
+	.message = multipath_message,
+};
+
+static int __init dm_multipath_init(void)
+{
+	int r;
+
+	/* allocate a slab for the dm_ios */
+	_mpio_cache = kmem_cache_create("dm_mpath", sizeof(struct mpath_io),
+					0, 0, NULL, NULL);
+	if (!_mpio_cache)
+		return -ENOMEM;
+
+	r = dm_register_target(&multipath_target);
+	if (r < 0) {
+		DMERR("%s: register failed %d", multipath_target.name, r);
+		kmem_cache_destroy(_mpio_cache);
+		return -EINVAL;
+	}
+
+	DMINFO("dm-multipath version %u.%u.%u loaded",
+	       multipath_target.version[0], multipath_target.version[1],
+	       multipath_target.version[2]);
+
+	return r;
+}
+
+static void __exit dm_multipath_exit(void)
+{
+	int r;
+
+	r = dm_unregister_target(&multipath_target);
+	if (r < 0)
+		DMERR("%s: target unregister failed %d",
+		      multipath_target.name, r);
+	kmem_cache_destroy(_mpio_cache);
+}
+
+module_init(dm_multipath_init);
+module_exit(dm_multipath_exit);
+
+MODULE_DESCRIPTION(DM_NAME " multipath target");
+MODULE_AUTHOR("Sistina Software <dm-devel@redhat.com>");
+MODULE_LICENSE("GPL");
--- diff/drivers/md/dm-mpath.h	1970-01-01 01:00:00.000000000 +0100
+++ source/drivers/md/dm-mpath.h	2005-02-09 14:41:52.000000000 +0000
@@ -0,0 +1,21 @@
+/*
+ * Copyright (C) 2004 Red Hat, Inc. All rights reserved.
+ *
+ * This file is released under the GPL.
+ *
+ * Multipath.
+ */
+
+#ifndef	DM_MPATH_H
+#define	DM_MPATH_H
+
+#include <linux/device-mapper.h>
+
+struct path {
+	struct dm_dev *dev;	/* Read-only */
+	unsigned is_active;	/* Read-only */
+
+	void *pscontext;	/* For path-selector use */
+};
+
+#endif
--- diff/drivers/md/dm-path-selector.c	1970-01-01 01:00:00.000000000 +0100
+++ source/drivers/md/dm-path-selector.c	2005-02-09 14:41:52.000000000 +0000
@@ -0,0 +1,156 @@
+/*
+ * Copyright (C) 2003 Sistina Software.
+ * Copyright (C) 2004 Red Hat, Inc. All rights reserved.
+ *
+ * Module Author: Heinz Mauelshagen
+ *
+ * This file is released under the GPL.
+ *
+ * Path selector registration.
+ */
+
+#include "dm.h"
+#include "dm-path-selector.h"
+
+#include <linux/slab.h>
+
+struct ps_internal {
+	struct path_selector_type pst;
+
+	struct list_head list;
+	long use;
+};
+
+#define pst_to_psi(__pst) container_of((__pst), struct ps_internal, pst)
+
+static LIST_HEAD(_path_selectors);
+static DECLARE_RWSEM(_ps_lock);
+
+struct ps_internal *__find_path_selector_type(const char *name)
+{
+	struct ps_internal *psi;
+
+	list_for_each_entry (psi, &_path_selectors, list) {
+		if (!strcmp(name, psi->pst.name))
+			return psi;
+	}
+
+	return NULL;
+}
+
+static struct ps_internal *get_path_selector(const char *name)
+{
+	struct ps_internal *psi;
+
+	down_read(&_ps_lock);
+	psi = __find_path_selector_type(name);
+	if (psi) {
+		if ((psi->use == 0) && !try_module_get(psi->pst.module))
+			psi = NULL;
+		else
+			psi->use++;
+	}
+	up_read(&_ps_lock);
+
+	return psi;
+}
+
+struct path_selector_type *dm_get_path_selector(const char *name)
+{
+	struct ps_internal *psi;
+
+	if (!name)
+		return NULL;
+
+	psi = get_path_selector(name);
+	if (!psi) {
+		request_module("dm-%s", name);
+		psi = get_path_selector(name);
+	}
+
+	return psi ? &psi->pst : NULL;
+}
+
+void dm_put_path_selector(struct path_selector_type *pst)
+{
+	struct ps_internal *psi;
+
+	if (!pst)
+		return;
+
+	down_read(&_ps_lock);
+	psi = __find_path_selector_type(pst->name);
+	if (!psi)
+		goto out;
+
+	if (--psi->use == 0)
+		module_put(psi->pst.module);
+
+	if (psi->use < 0)
+		BUG();
+
+out:
+	up_read(&_ps_lock);
+}
+
+static struct ps_internal *_alloc_path_selector(struct path_selector_type *pst)
+{
+	struct ps_internal *psi = kmalloc(sizeof(*psi), GFP_KERNEL);
+
+	if (psi) {
+		memset(psi, 0, sizeof(*psi));
+		psi->pst = *pst;
+	}
+
+	return psi;
+}
+
+int dm_register_path_selector(struct path_selector_type *pst)
+{
+	int r = 0;
+	struct ps_internal *psi = _alloc_path_selector(pst);
+
+	if (!psi)
+		return -ENOMEM;
+
+	down_write(&_ps_lock);
+
+	if (__find_path_selector_type(pst->name)) {
+		kfree(psi);
+		r = -EEXIST;
+	} else
+		list_add(&psi->list, &_path_selectors);
+
+	up_write(&_ps_lock);
+
+	return r;
+}
+
+int dm_unregister_path_selector(struct path_selector_type *pst)
+{
+	struct ps_internal *psi;
+
+	down_write(&_ps_lock);
+
+	psi = __find_path_selector_type(pst->name);
+	if (!psi) {
+		up_write(&_ps_lock);
+		return -EINVAL;
+	}
+
+	if (psi->use) {
+		up_write(&_ps_lock);
+		return -ETXTBSY;
+	}
+
+	list_del(&psi->list);
+
+	up_write(&_ps_lock);
+
+	kfree(psi);
+
+	return 0;
+}
+
+EXPORT_SYMBOL(dm_register_path_selector);
+EXPORT_SYMBOL(dm_unregister_path_selector);
--- diff/drivers/md/dm-path-selector.h	1970-01-01 01:00:00.000000000 +0100
+++ source/drivers/md/dm-path-selector.h	2005-02-09 14:41:52.000000000 +0000
@@ -0,0 +1,106 @@
+/*
+ * Copyright (C) 2003 Sistina Software.
+ * Copyright (C) 2004 Red Hat, Inc. All rights reserved.
+ *
+ * Module Author: Heinz Mauelshagen
+ *
+ * This file is released under the GPL.
+ *
+ * Path-Selector registration.
+ */
+
+#ifndef	DM_PATH_SELECTOR_H
+#define	DM_PATH_SELECTOR_H
+
+#include <linux/device-mapper.h>
+
+#include "dm-mpath.h"
+
+/*
+ * We provide an abstraction for the code that chooses which path
+ * to send some io down.
+ */
+struct path_selector_type;
+struct path_selector {
+	struct path_selector_type *type;
+	void *context;
+};
+
+/*
+ * Constructs a path selector object, takes custom arguments
+ */
+typedef int (*ps_ctr_fn) (struct path_selector *ps, unsigned argc, char **argv);
+typedef void (*ps_dtr_fn) (struct path_selector *ps);
+
+/*
+ * Add an opaque path object, along with some selector specific
+ * path args (eg, path priority).
+ */
+typedef	int (*ps_add_path_fn) (struct path_selector *ps, struct path *path,
+			       int argc, char **argv, char **error);
+
+/*
+ * Chooses a path for this io, if no paths are available then
+ * NULL will be returned.
+ *
+ * repeat_count is the number of times to use the path before
+ * calling the function again.  0 means don't call it again unless 
+ * the path fails.
+ */
+typedef	struct path *(*ps_select_path_fn) (struct path_selector *ps,
+					   unsigned *repeat_count);
+
+/*
+ * Notify the selector that a path has failed.
+ */
+typedef	void (*ps_fail_path_fn) (struct path_selector *ps,
+				 struct path *p);
+
+/*
+ * Ask selector to reinstate a path.
+ */
+typedef	int (*ps_reinstate_path_fn) (struct path_selector *ps,
+				     struct path *p);
+
+/*
+ * Table content based on parameters added in ps_add_path_fn
+ * or path selector status
+ */
+typedef	int (*ps_status_fn) (struct path_selector *ps,
+			     struct path *path,
+			     status_type_t type,
+			     char *result, unsigned int maxlen);
+
+typedef int (*ps_end_io_fn) (struct path_selector *ps, struct path *path);
+
+/* Information about a path selector type */
+struct path_selector_type {
+	char *name;
+	struct module *module;
+
+	unsigned int table_args;
+	unsigned int info_args;
+	ps_ctr_fn ctr;
+	ps_dtr_fn dtr;
+
+	ps_add_path_fn add_path;
+	ps_fail_path_fn fail_path;
+	ps_reinstate_path_fn reinstate_path;
+	ps_select_path_fn select_path;
+	ps_status_fn status;
+	ps_end_io_fn end_io;
+};
+
+/* Register a path selector */
+int dm_register_path_selector(struct path_selector_type *type);
+
+/* Unregister a path selector */
+int dm_unregister_path_selector(struct path_selector_type *type);
+
+/* Returns a registered path selector type */
+struct path_selector_type *dm_get_path_selector(const char *name);
+
+/* Releases a path selector  */
+void dm_put_path_selector(struct path_selector_type *pst);
+
+#endif
