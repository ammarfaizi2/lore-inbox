Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbUBTPm7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 10:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261303AbUBTPlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 10:41:20 -0500
Received: from mx1.redhat.com ([66.187.233.31]:34217 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261297AbUBTPez (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 10:34:55 -0500
Date: Fri, 20 Feb 2004 15:37:57 +0000
From: Joe Thornber <thornber@redhat.com>
To: Joe Thornber <thornber@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: [Patch 6/6] dm: multipath target
Message-ID: <20040220153757.GT27549@reti>
References: <20040220153145.GN27549@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040220153145.GN27549@reti>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Multipath target
--- diff/drivers/md/Kconfig	2004-02-18 15:25:08.000000000 +0000
+++ source/drivers/md/Kconfig	2004-02-18 15:49:35.000000000 +0000
@@ -180,5 +180,10 @@ config DM_CRYPT
 
 	  If unsure, say N.
 
-endmenu
+config DM_MULTIPATH
+       tristate "Multipath target (EXPERIMENTAL)"
+       depends on BLK_DEV_DM && EXPERIMENTAL
+       ---help---
+         Allow volume managers to support multipath hardware.
 
+endmenu
--- diff/drivers/md/Makefile	2004-02-18 15:15:13.000000000 +0000
+++ source/drivers/md/Makefile	2004-02-18 15:50:12.000000000 +0000
@@ -4,6 +4,7 @@
 
 dm-mod-objs	:= dm.o dm-table.o dm-target.o dm-linear.o dm-stripe.o \
 		   dm-ioctl.o
+dm-multipath-objs := dm-path-selector.o dm-mpath.o
 raid6-objs	:= raid6main.o raid6algos.o raid6recov.o raid6tables.o \
 		   raid6int1.o raid6int2.o raid6int4.o \
 		   raid6int8.o raid6int16.o raid6int32.o \
@@ -24,6 +25,7 @@ obj-$(CONFIG_MD_MULTIPATH)	+= multipath.
 obj-$(CONFIG_BLK_DEV_MD)	+= md.o
 obj-$(CONFIG_BLK_DEV_DM)	+= dm-mod.o
 obj-$(CONFIG_DM_CRYPT)		+= dm-crypt.o
+obj-$(CONFIG_DM_MULTIPATH)	+= dm-multipath.o
 
 quiet_cmd_unroll = UNROLL  $@
       cmd_unroll = $(PERL) $(srctree)/$(src)/unroll.pl $(UNROLL) \
--- diff/drivers/md/dm-mpath.c	1970-01-01 01:00:00.000000000 +0100
+++ source/drivers/md/dm-mpath.c	2004-02-18 15:51:06.000000000 +0000
@@ -0,0 +1,729 @@
+/*
+ * Copyright (C) 2003 Sistina Software Limited.
+ *
+ * This file is released under the GPL.
+ */
+
+#include "dm.h"
+#include "dm-path-selector.h"
+#include "dm-bio-list.h"
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
+/* FIXME: get rid of this */
+#define MPATH_FAIL_COUNT	1
+
+/*
+ * We don't want to call the path selector for every single io
+ * that comes through, so instead we only consider changing paths
+ * every MPATH_MIN_IO ios.  This number should be selected to be
+ * big enough that we can reduce the overhead of the path
+ * selector, but also small enough that we don't take the policy
+ * decision away from the path selector.
+ *
+ * So people should _not_ be tuning this number to try and get
+ * the most performance from some particular type of hardware.
+ * All the smarts should be going into the path selector.
+ */
+#define MPATH_MIN_IO		1000
+
+/* Path properties */
+struct path {
+	struct list_head list;
+
+	struct dm_dev *dev;
+	struct priority_group *pg;
+
+	spinlock_t failed_lock;
+	int has_failed;
+	unsigned fail_count;
+};
+
+struct priority_group {
+	struct list_head list;
+
+	unsigned priority;
+	struct multipath *m;
+	struct path_selector *ps;
+
+	unsigned nr_paths;
+	struct list_head paths;
+};
+
+/* Multipath context */
+struct multipath {
+	struct list_head list;
+	struct dm_target *ti;
+
+	unsigned nr_paths;
+	unsigned nr_priority_groups;
+	struct list_head priority_groups;
+
+	spinlock_t lock;
+	unsigned nr_valid_paths;
+
+	struct path *current_path;
+	unsigned current_count;
+
+	struct work_struct dispatch_failed;
+	struct bio_list failed_ios;
+
+	struct work_struct trigger_event;
+};
+
+static void dispatch_failed_ios(void *data);
+static void trigger_event(void *data);
+
+static struct path *alloc_path(void)
+{
+	struct path *path = kmalloc(sizeof(*path), GFP_KERNEL);
+
+	if (path) {
+		memset(path, 0, sizeof(*path));
+		path->failed_lock = SPIN_LOCK_UNLOCKED;
+		path->fail_count = MPATH_FAIL_COUNT;
+	}
+
+	return path;
+}
+
+static inline void free_path(struct path *p)
+{
+	kfree(p);
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
+	pg->ps = kmalloc(sizeof(*pg->ps), GFP_KERNEL);
+	if (!pg->ps) {
+		kfree(pg);
+		return NULL;
+	}
+	memset(pg->ps, 0, sizeof(*pg->ps));
+
+	INIT_LIST_HEAD(&pg->paths);
+
+	return pg;
+}
+
+static void free_paths(struct list_head *paths, struct dm_target *ti)
+{
+	struct path *path, *tmp;
+
+	list_for_each_entry_safe (path, tmp, paths, list) {
+		list_del(&path->list);
+		dm_put_device(ti, path->dev);
+		free_path(path);
+	}
+}
+
+static void free_priority_group(struct priority_group *pg,
+				struct dm_target *ti)
+{
+	struct path_selector *ps = pg->ps;
+
+	if (ps) {
+		if (ps->type) {
+			ps->type->dtr(ps);
+			dm_put_path_selector(ps->type);
+		}
+		kfree(ps);
+	}
+
+	free_paths(&pg->paths, ti);
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
+		INIT_WORK(&m->dispatch_failed, dispatch_failed_ios, m);
+		INIT_WORK(&m->trigger_event, trigger_event, m);
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
+	kfree(m);
+}
+
+/*-----------------------------------------------------------------
+ * The multipath daemon is responsible for resubmitting failed ios.
+ *---------------------------------------------------------------*/
+static struct workqueue_struct *_kmpathd_wq;
+
+static int __choose_path(struct multipath *m)
+{
+	struct priority_group *pg;
+	struct path *path = NULL;
+
+	if (m->nr_valid_paths) {
+		/* loop through the priority groups until we find a valid path. */
+		list_for_each_entry (pg, &m->priority_groups, list) {
+			path = pg->ps->type->select_path(pg->ps);
+			if (path)
+				break;
+		}
+	}
+
+	m->current_path = path;
+	m->current_count = MPATH_MIN_IO;
+
+	return 0;
+}
+
+static struct path *get_current_path(struct multipath *m)
+{
+	struct path *path;
+	unsigned long flags;
+
+	spin_lock_irqsave(&m->lock, flags);
+
+	/* Do we need to select a new path? */
+	if (!m->current_path || --m->current_count == 0)
+		__choose_path(m);
+
+	path = m->current_path;
+
+	spin_unlock_irqrestore(&m->lock, flags);
+
+	return path;
+}
+
+static int map_io(struct multipath *m, struct bio *bio)
+{
+	struct path *path;
+
+	path = get_current_path(m);
+	if (!path)
+		return -EIO;
+
+	bio->bi_bdev = path->dev->bdev;
+	return 0;
+}
+
+static void dispatch_failed_ios(void *data)
+{
+	struct multipath *m = (struct multipath *) data;
+
+	int r;
+	unsigned long flags;
+	struct bio *bio = NULL, *next;
+
+	spin_lock_irqsave(&m->lock, flags);
+	bio = bio_list_get(&m->failed_ios);
+	spin_unlock_irqrestore(&m->lock, flags);
+
+	while (bio) {
+		next = bio->bi_next;
+		bio->bi_next = NULL;
+
+		r = map_io(m, bio);
+		if (r)
+			/*
+			 * This wont loop forever because the
+			 * end_io function will fail the ios if
+			 * we've no valid paths left.
+			 */
+			bio_io_error(bio, bio->bi_size);
+		else
+			generic_make_request(bio);
+
+		bio = next;
+	}
+
+	/*
+	 * FIXME: this now gets called once for each mpath
+	 * target, rather than once per daemon cycle.
+	 */
+ 	blk_run_queues();
+}
+
+static void trigger_event(void *data)
+{
+	struct multipath *m = (struct multipath *) data;
+	dm_table_event(m->ti->table);
+}
+
+/*-----------------------------------------------------------------
+ * Constructor/argument parsing:
+ * <poll interval> <num priority groups> [<priority> <selector>
+ * <num selector args> <num paths> [<path> [<arg>]* ]+ ]+
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
+static struct path *parse_path(struct arg_set *as, struct path_selector *ps,
+			       struct dm_target *ti)
+{
+	int r;
+	struct path *p;
+
+	/* we need at least a path arg */
+	if (as->argc < 1) {
+		ti->error = ESTR("no device given");
+		return NULL;
+	}
+
+	p = alloc_path();
+	if (!p)
+		return NULL;
+
+	r = dm_get_device(ti, shift(as), ti->begin, ti->len,
+			  dm_table_get_mode(ti->table), &p->dev);
+	if (r) {
+		ti->error = ESTR("error getting device");
+		goto bad;
+	}
+
+	r = ps->type->add_path(ps, p, as->argc, as->argv, &ti->error);
+	if (r) {
+		dm_put_device(ti, p->dev);
+		goto bad;
+	}
+
+	return p;
+
+ bad:
+	free_path(p);
+	return NULL;
+}
+
+static struct priority_group *parse_priority_group(struct arg_set *as,
+						   struct multipath *m,
+						   struct dm_target *ti)
+{
+	static struct param _params[] = {
+		{0, 1024, ESTR("invalid priority")},
+		{1, 1024, ESTR("invalid number of paths")},
+		{0, 1024, ESTR("invalid number of selector args")}
+	};
+
+	int r;
+	unsigned i, nr_selector_args, nr_params;
+	struct priority_group *pg;
+	struct path_selector_type *pst;
+
+	if (as->argc < 3) {
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
+
+	r = read_param(_params, shift(as), &pg->priority, &ti->error);
+	if (r)
+		goto bad;
+
+	pst = dm_get_path_selector(shift(as));
+	if (!pst) {
+		ti->error = ESTR("unknown path selector type");
+		goto bad;
+	}
+
+	r = pst->ctr(pg->ps);
+	if (r) {
+		/* FIXME: need to put the pst ? fix after
+		 * factoring out the register */
+		goto bad;
+	}
+	pg->ps->type = pst;
+
+	/*
+	 * read the paths
+	 */
+	r = read_param(_params + 1, shift(as), &pg->nr_paths, &ti->error);
+	if (r)
+		goto bad;
+
+	r = read_param(_params + 2, shift(as), &nr_selector_args, &ti->error);
+	if (r)
+		goto bad;
+
+	nr_params = 1 + nr_selector_args;
+	for (i = 0; i < pg->nr_paths; i++) {
+		struct path *path;
+		struct arg_set path_args;
+
+		if (as->argc < nr_params)
+			goto bad;
+
+		path_args.argc = nr_params;
+		path_args.argv = as->argv;
+
+		path = parse_path(&path_args, pg->ps, ti);
+		if (!path)
+			goto bad;
+
+		path->pg = pg;
+		list_add_tail(&path->list, &pg->paths);
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
+static void __insert_priority_group(struct multipath *m,
+				    struct priority_group *pg)
+{
+	struct priority_group *tmp;
+
+	list_for_each_entry (tmp, &m->priority_groups, list)
+		if (tmp->priority > pg->priority)
+			break;
+
+	list_add_tail(&pg->list, &tmp->list);
+	pg->m = m;
+}
+
+static int multipath_ctr(struct dm_target *ti, unsigned int argc,
+			 char **argv)
+{
+	/* target parameters */
+	static struct param _params[] = {
+		{1, 1024, ESTR("invalid number of priority groups")},
+	};
+
+	int r;
+	struct multipath *m;
+	struct arg_set as;
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
+	r = read_param(_params, shift(&as), &m->nr_priority_groups, &ti->error);
+	if (r)
+		goto bad;
+
+	/* parse the priority groups */
+	while (as.argc) {
+		struct priority_group *pg;
+		pg = parse_priority_group(&as, m, ti);
+		if (pg) {
+			m->nr_paths += pg->nr_paths;
+			__insert_priority_group(m, pg);
+		}
+	}
+	m->nr_valid_paths = m->nr_paths;
+
+	ti->private = m;
+	m->ti = ti;
+
+	return 0;
+
+ bad:
+	free_multipath(m);
+	return -EINVAL;
+}
+
+static void multipath_dtr(struct dm_target *ti)
+{
+	struct multipath *m = (struct multipath *) ti->private;
+	free_multipath(m);
+}
+
+static int multipath_map(struct dm_target *ti, struct bio *bio,
+			 union map_info *map_context)
+{
+	int r;
+	struct multipath *m = (struct multipath *) ti->private;
+
+	bio->bi_rw |= (1 << BIO_RW_FAILFAST);
+	r = map_io(m, bio);
+	if (r)
+		return r;
+
+	return 1;
+}
+
+/*
+ * Only called on the error path.
+ */
+static struct path *find_path(struct multipath *m, struct block_device *bdev)
+{
+	struct path *p;
+	struct priority_group *pg;
+
+	list_for_each_entry (pg, &m->priority_groups, list)
+		list_for_each_entry (p, &pg->paths, list)
+			if (p->dev->bdev == bdev)
+				return p;
+
+	return NULL;
+}
+
+static void fail_path(struct path *path)
+{
+	unsigned long flags;
+	struct multipath *m;
+
+	spin_lock_irqsave(&path->failed_lock, flags);
+
+	/* FIXME: path->fail_count is brain dead */
+	if (!path->has_failed && !--path->fail_count) {
+		m = path->pg->m;
+
+		path->has_failed = 1;
+		path->pg->ps->type->fail_path(path->pg->ps, path);
+		queue_work(_kmpathd_wq, &m->trigger_event);
+
+		spin_lock(&m->lock);
+		m->nr_valid_paths--;
+
+		if (path == m->current_path)
+			m->current_path = NULL;
+
+		spin_unlock(&m->lock);
+	}
+
+	spin_unlock_irqrestore(&path->failed_lock, flags);
+}
+
+static int multipath_end_io(struct dm_target *ti, struct bio *bio,
+			    int error, union map_info *map_context)
+{
+	struct path *path;
+	struct multipath *m = (struct multipath *) ti->private;
+
+	if (error) {
+		spin_lock(&m->lock);
+		if (!m->nr_valid_paths) {
+			spin_unlock(&m->lock);
+			return -EIO;
+		}
+		spin_unlock(&m->lock);
+
+		path = find_path(m, bio->bi_bdev);
+		fail_path(path);
+
+		/* queue for the daemon to resubmit */
+		spin_lock(&m->lock);
+		bio_list_add(&m->failed_ios, bio);
+		spin_unlock(&m->lock);
+
+		queue_work(_kmpathd_wq, &m->dispatch_failed);
+		return 1;	/* io not complete */
+	}
+
+	return 0;
+}
+
+/*
+ * Info string has the following format:
+ * num_groups [num_paths num_selector_args [path_dev A|F fail_count [selector_args]* ]+ ]+
+ *
+ * Table string has the following format (identical to the constructor string):
+ * num_groups [priority selector-name num_paths num_selector_args [path_dev [selector_args]* ]+ ]+
+ */
+static int multipath_status(struct dm_target *ti, status_type_t type,
+			    char *result, unsigned int maxlen)
+{
+	int sz = 0;
+	unsigned long flags;
+	struct multipath *m = (struct multipath *) ti->private;
+	struct priority_group *pg;
+	struct path *p;
+	char buffer[32];
+
+	switch (type) {
+	case STATUSTYPE_INFO:
+		sz += snprintf(result + sz, maxlen - sz, "%u ", m->nr_priority_groups);
+
+		list_for_each_entry(pg, &m->priority_groups, list) {
+			sz += snprintf(result + sz, maxlen - sz, "%u %u ",
+                                       pg->nr_paths,
+				       pg->ps->type->info_args);
+
+			list_for_each_entry(p, &pg->paths, list) {
+				format_dev_t(buffer, p->dev->bdev->bd_dev);
+				spin_lock_irqsave(&p->failed_lock, flags);
+				sz += snprintf(result + sz, maxlen - sz,
+					       "%s %s %u ", buffer,
+					       p->has_failed ? "F" : "A",
+					       p->fail_count);
+				pg->ps->type->status(pg->ps, p, type,
+						     result + sz, maxlen - sz);
+				spin_unlock_irqrestore(&p->failed_lock, flags);
+
+				sz = strlen(result);
+				if (sz >= maxlen)
+					break;
+			}
+		}
+
+		break;
+
+	case STATUSTYPE_TABLE:
+		sz += snprintf(result + sz, maxlen - sz, "%u ", m->nr_priority_groups);
+
+		list_for_each_entry(pg, &m->priority_groups, list) {
+			sz += snprintf(result + sz, maxlen - sz, "%u %s %u %u ",
+				       pg->priority, pg->ps->type->name,
+				       pg->nr_paths, pg->ps->type->table_args);
+
+			list_for_each_entry(p, &pg->paths, list) {
+				format_dev_t(buffer, p->dev->bdev->bd_dev);
+				sz += snprintf(result + sz, maxlen - sz,
+					       "%s ", buffer);
+				pg->ps->type->status(pg->ps, p, type,
+						     result + sz, maxlen - sz);
+
+				sz = strlen(result);
+				if (sz >= maxlen)
+					break;
+			}
+		}
+
+		break;
+	}
+
+	return 0;
+}
+
+/*-----------------------------------------------------------------
+ * Module setup
+ *---------------------------------------------------------------*/
+static struct target_type multipath_target = {
+	.name = "multipath",
+	.version = {1, 0, 2},
+	.module = THIS_MODULE,
+	.ctr = multipath_ctr,
+	.dtr = multipath_dtr,
+	.map = multipath_map,
+	.end_io = multipath_end_io,
+	.status = multipath_status,
+};
+
+int __init dm_multipath_init(void)
+{
+	int r;
+
+	r = dm_register_target(&multipath_target);
+	if (r < 0) {
+		DMERR("%s: register failed %d", multipath_target.name, r);
+		return -EINVAL;
+	}
+
+	r = dm_register_path_selectors();
+	if (r && r != -EEXIST) {
+		dm_unregister_target(&multipath_target);
+		return r;
+	}
+
+	_kmpathd_wq = create_workqueue("dm-mpath");
+	if (!_kmpathd_wq) {
+		/* FIXME: remove this */
+		dm_unregister_path_selectors();
+		dm_unregister_target(&multipath_target);
+	} else
+		DMINFO("dm_multipath v0.2.0");
+
+	return r;
+}
+
+void __exit dm_multipath_exit(void)
+{
+	int r;
+
+	destroy_workqueue(_kmpathd_wq);
+	dm_unregister_path_selectors();
+	r = dm_unregister_target(&multipath_target);
+	if (r < 0)
+		DMERR("%s: target unregister failed %d",
+		      multipath_target.name, r);
+}
+
+module_init(dm_multipath_init);
+module_exit(dm_multipath_exit);
+
+MODULE_DESCRIPTION(DM_NAME " multipath target");
+MODULE_AUTHOR("Sistina software <dm@uk.sistina.com>");
+MODULE_LICENSE("GPL");
--- diff/drivers/md/dm-path-selector.c	1970-01-01 01:00:00.000000000 +0100
+++ source/drivers/md/dm-path-selector.c	2004-02-18 15:54:59.000000000 +0000
@@ -0,0 +1,298 @@
+/*
+ * Copyright (C) 2003 Sistina Software.
+ *
+ * Module Author: Heinz Mauelshagen
+ *
+ * This file is released under the GPL.
+ *
+ * Path selector housekeeping (register/unregister/...)
+ */
+
+#include "dm.h"
+#include "dm-path-selector.h"
+
+#include <linux/slab.h>
+
+struct ps_internal {
+	struct path_selector_type pt;
+
+	struct list_head list;
+	long use;
+};
+
+static LIST_HEAD(_path_selectors);
+static DECLARE_MUTEX(_lock);
+
+struct path_selector_type *__find_path_selector_type(const char *name)
+{
+	struct ps_internal *li;
+
+	list_for_each_entry (li, &_path_selectors, list) {
+		if (!strcmp(name, li->pt.name))
+			return &li->pt;
+	}
+
+	return NULL;
+}
+
+struct path_selector_type *dm_get_path_selector(const char *name)
+{
+	struct path_selector_type *lb;
+
+	if (!name)
+		return NULL;
+
+	down(&_lock);
+	lb = __find_path_selector_type(name);
+	if (lb) {
+		struct ps_internal *li = (struct ps_internal *) lb;
+		li->use++;
+	}
+	up(&_lock);
+
+	return lb;
+}
+
+void dm_put_path_selector(struct path_selector_type *l)
+{
+	struct ps_internal *li = (struct ps_internal *) l;
+
+	down(&_lock);
+	if (--li->use < 0)
+		BUG();
+	up(&_lock);
+
+	return;
+}
+
+static struct ps_internal *_alloc_path_selector(struct path_selector_type *pt)
+{
+	struct ps_internal *psi = kmalloc(sizeof(*psi), GFP_KERNEL);
+
+	if (psi) {
+		memset(psi, 0, sizeof(*psi));
+		memcpy(psi, pt, sizeof(*pt));
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
+	down(&_lock);
+	if (__find_path_selector_type(pst->name)) {
+		kfree(psi);
+		r = -EEXIST;
+	} else
+		list_add(&psi->list, &_path_selectors);
+
+	up(&_lock);
+
+	return r;
+}
+
+int dm_unregister_path_selector(struct path_selector_type *pst)
+{
+	struct ps_internal *psi;
+
+	down(&_lock);
+	psi = (struct ps_internal *) __find_path_selector_type(pst->name);
+	if (!psi) {
+		up(&_lock);
+		return -EINVAL;
+	}
+
+	if (psi->use) {
+		up(&_lock);
+		return -ETXTBSY;
+	}
+
+	list_del(&psi->list);
+	up(&_lock);
+
+	kfree(psi);
+
+	return 0;
+}
+
+/*-----------------------------------------------------------------
+ * Path handling code, paths are held in lists
+ *---------------------------------------------------------------*/
+struct path_info {
+	struct list_head list;
+	struct path *path;
+};
+
+static struct path_info *path_lookup(struct list_head *head, struct path *p)
+{
+	struct path_info *pi;
+
+	list_for_each_entry (pi, head, list)
+		if (pi->path == p)
+			return pi;
+
+	return NULL;
+}
+
+/*-----------------------------------------------------------------
+ * Round robin selector
+ *---------------------------------------------------------------*/
+struct selector {
+	spinlock_t lock;
+
+	struct list_head valid_paths;
+	struct list_head invalid_paths;
+};
+
+static struct selector *alloc_selector(void)
+{
+	struct selector *s = kmalloc(sizeof(*s), GFP_KERNEL);
+
+	if (s) {
+		INIT_LIST_HEAD(&s->valid_paths);
+		INIT_LIST_HEAD(&s->invalid_paths);
+		s->lock = SPIN_LOCK_UNLOCKED;
+	}
+
+	return s;
+}
+
+/* Path selector constructor */
+static int rr_ctr(struct path_selector *ps)
+{
+	struct selector *s;
+
+	s = alloc_selector();
+	if (!s)
+		return -ENOMEM;
+
+	ps->context = s;
+	return 0;
+}
+
+static void free_paths(struct list_head *paths)
+{
+	struct path_info *pi, *next;
+
+	list_for_each_entry_safe (pi, next, paths, list) {
+		list_del(&pi->list);
+		kfree(pi);
+	}
+}
+
+/* Path selector destructor */
+static void rr_dtr(struct path_selector *ps)
+{
+	struct selector *s = (struct selector *) ps->context;
+	free_paths(&s->valid_paths);
+	free_paths(&s->invalid_paths);
+	kfree(s);
+}
+
+/* Path add context */
+static int rr_add_path(struct path_selector *ps, struct path *path,
+		       int argc, char **argv, char **error)
+{
+	struct selector *s = (struct selector *) ps->context;
+	struct path_info *pi;
+
+	/* parse the path arguments */
+	if (argc != 0) {
+		*error = "round-robin ps: incorrect number of arguments";
+		return -EINVAL;
+	}
+
+	/* allocate the path */
+	pi = kmalloc(sizeof(*pi), GFP_KERNEL);
+	if (!pi) {
+		*error = "round-robin ps: Error allocating path context";
+		return -ENOMEM;
+	}
+
+	pi->path = path;
+
+	spin_lock(&s->lock);
+	list_add(&pi->list, &s->valid_paths);
+	spin_unlock(&s->lock);
+
+	return 0;
+}
+
+static void rr_fail_path(struct path_selector *ps, struct path *p)
+{
+	unsigned long flags;
+	struct selector *s = (struct selector *) ps->context;
+	struct path_info *pi;
+
+	/*
+	 * This function will be called infrequently so we don't
+	 * mind the expense of these searches.
+	 */
+	spin_lock_irqsave(&s->lock, flags);
+	pi = path_lookup(&s->valid_paths, p);
+	if (!pi)
+		pi = path_lookup(&s->invalid_paths, p);
+
+	if (!pi)
+		DMWARN("asked to change the state of an unknown path");
+
+	else
+		list_move(&pi->list, &s->invalid_paths);
+
+	spin_unlock_irqrestore(&s->lock, flags);
+}
+
+/* Path selector */
+static struct path *rr_select_path(struct path_selector *ps)
+{
+	unsigned long flags;
+	struct selector *s = (struct selector *) ps->context;
+	struct path_info *pi = NULL;
+
+	spin_lock_irqsave(&s->lock, flags);
+	if (!list_empty(&s->valid_paths)) {
+		pi = list_entry(s->valid_paths.next, struct path_info, list);
+		list_move_tail(&pi->list, &s->valid_paths);
+	}
+	spin_unlock_irqrestore(&s->lock, flags);
+
+	return pi ? pi->path : NULL;
+}
+
+/* Path status */
+static int rr_status(struct path_selector *ps, struct path *path,
+		     status_type_t type, char *result, unsigned int maxlen)
+{
+	return 0;
+}
+
+static struct path_selector_type rr_ps = {
+	.name = "round-robin",
+	.table_args = 0,
+	.info_args = 0,
+	.ctr = rr_ctr,
+	.dtr = rr_dtr,
+	.add_path = rr_add_path,
+	.fail_path = rr_fail_path,
+	.select_path = rr_select_path,
+	.status = rr_status,
+};
+
+/*
+ * (Un)register all path selectors (FIXME: remove this after tests)
+ */
+int dm_register_path_selectors(void)
+{
+	return dm_register_path_selector(&rr_ps);
+}
+
+void dm_unregister_path_selectors(void)
+{
+	dm_unregister_path_selector(&rr_ps);
+}
--- diff/drivers/md/dm-path-selector.h	1970-01-01 01:00:00.000000000 +0100
+++ source/drivers/md/dm-path-selector.h	2004-02-18 15:53:24.000000000 +0000
@@ -0,0 +1,103 @@
+/*
+ * Copyright (C) 2003 Sistina Software.
+ *
+ * Module Author: Heinz Mauelshagen
+ *
+ * This file is released under the GPL.
+ *
+ * Path-Selector interface/registration/unregistration definitions
+ *
+ */
+
+#ifndef	DM_PATH_SELECTOR_H
+#define	DM_PATH_SELECTOR_H
+
+#include <linux/device-mapper.h>
+
+struct path;
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
+typedef int (*ps_ctr_fn) (struct path_selector *ps);
+typedef void (*ps_dtr_fn) (struct path_selector *ps);
+
+/*
+ * Add an opaque path object, along with some selector specific
+ * path args (eg, path priority).
+ */
+typedef	int (*ps_add_path_fn) (struct path_selector *ps,
+			       struct path *path,
+			       int argc, char **argv, char **error);
+
+/*
+ * Chooses a path for this io, if no paths are available then
+ * NULL will be returned. The selector may set the map_info
+ * object if it wishes, this will be fed back into the endio fn.
+ *
+ * Must ensure that _any_ dynamically allocated selection context is
+ * reused or reallocated because an endio call (which needs to free it)
+ * might happen after a couple of select calls.
+ */
+typedef	struct path *(*ps_select_path_fn) (struct path_selector *ps);
+
+/*
+ * Notify the selector that a path has failed.
+ */
+typedef	void (*ps_fail_path_fn) (struct path_selector *ps,
+				 struct path *p);
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
+/* Information about a path selector type */
+struct path_selector_type {
+	char *name;
+	unsigned int table_args;
+	unsigned int info_args;
+	ps_ctr_fn ctr;
+	ps_dtr_fn dtr;
+
+	ps_add_path_fn add_path;
+	ps_fail_path_fn fail_path;
+	ps_select_path_fn select_path;
+	ps_status_fn status;
+};
+
+/*
+ * FIXME: Factor out registration code.
+ */
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
+/* FIXME: remove these */
+int dm_register_path_selectors(void);
+void dm_unregister_path_selectors(void);
+
+#endif
