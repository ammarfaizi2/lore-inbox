Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262285AbVBKRZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262285AbVBKRZV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 12:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262295AbVBKRZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 12:25:20 -0500
Received: from mx1.redhat.com ([66.187.233.31]:61656 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262285AbVBKRTQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 12:19:16 -0500
Date: Fri, 11 Feb 2005 17:19:10 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] device-mapper: multipath hardware handler
Message-ID: <20050211171910.GZ10195@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Each multipath instance can use a Hardware Handler with
hooks for the particular hardware you're using.

This patch provides the hw_handler infrastructure.

So far 3 hooks are available:

  A status function invoked by device-mapper table and
  status requests.

  An initialisation function called when a Priority Group is 
  selected for use but before any I/O is sent to it.
  This function should return straight away, and I/O is queued
  until dm_pg_init_complete() is called indicating whether or not
  the initialisation was successful.
  The are three error flags, any or all of which may be set:
  MP_FAIL_PATH, MP_BYPASS_PG, MP_ERROR_IO.

  An error handler which gets the opportunity to decode any error
  that a bio generated.  Patches are pending to make scsi error 
  details available for dm_scsi_err_handler() to decode.

Signed-Off-By: Alasdair G Kergon <agk@redhat.com>
--- diff/drivers/md/Makefile	2005-02-09 14:42:03.000000000 +0000
+++ source/drivers/md/Makefile	2005-02-09 14:42:12.000000000 +0000
@@ -4,7 +4,7 @@
 
 dm-mod-objs	:= dm.o dm-table.o dm-target.o dm-linear.o dm-stripe.o \
 		   dm-ioctl.o dm-io.o kcopyd.o
-dm-multipath-objs := dm-path-selector.o dm-mpath.o
+dm-multipath-objs := dm-hw-handler.o dm-path-selector.o dm-mpath.o
 dm-snapshot-objs := dm-snap.o dm-exception-store.o
 dm-mirror-objs	:= dm-log.o dm-raid1.o
 raid6-objs	:= raid6main.o raid6algos.o raid6recov.o raid6tables.o \
--- diff/drivers/md/dm-mpath.c	2005-02-09 14:41:52.000000000 +0000
+++ source/drivers/md/dm-mpath.c	2005-02-09 14:42:12.000000000 +0000
@@ -7,6 +7,7 @@
 
 #include "dm.h"
 #include "dm-path-selector.h"
+#include "dm-hw-handler.h"
 #include "dm-bio-list.h"
 #include "dm-bio-record.h"
 
@@ -58,8 +59,10 @@
 
 	spinlock_t lock;
 
+	struct hw_handler hw_handler;
 	unsigned nr_priority_groups;
 	struct list_head priority_groups;
+	unsigned pg_init_required;	/* pg_init needs calling? */
 
 	unsigned nr_valid_paths;	/* Total number of usable paths */
 	struct pgpath *current_pgpath;
@@ -188,12 +191,18 @@
 static void free_multipath(struct multipath *m)
 {
 	struct priority_group *pg, *tmp;
+	struct hw_handler *hwh = &m->hw_handler;
 
 	list_for_each_entry_safe (pg, tmp, &m->priority_groups, list) {
 		list_del(&pg->list);
 		free_priority_group(pg, m->ti);
 	}
 
+	if (hwh->type) {
+		hwh->type->dtr(hwh);
+		dm_put_hw_handler(hwh->type);
+	}
+
 	mempool_destroy(m->mpio_pool);
 	kfree(m);
 }
@@ -205,8 +214,18 @@
 
 static void __switch_pg(struct multipath *m, struct pgpath *pgpath)
 {
+	struct hw_handler *hwh = &m->hw_handler;
+
 	m->current_pg = pgpath->pg;
-	m->queue_io = 0;
+
+	/* Must we initialise the PG first, and queue I/O till it's ready? */
+	if (hwh->type && hwh->type->pg_init) {
+		m->pg_init_required = 1;
+		m->queue_io = 1;
+	} else {
+		m->pg_init_required = 0;
+		m->queue_io = 0;
+	}
 }
 
 static int __choose_path_in_pg(struct multipath *m, struct priority_group *pg)
@@ -288,7 +307,7 @@
 		/* Queue for the daemon to resubmit */
 		bio_list_add(&m->queued_ios, bio);
 		m->queue_size++;
-		if (!m->queue_io)
+		if (m->pg_init_required || !m->queue_io)
 			schedule_work(&m->process_queued_ios);
 		pgpath = NULL;
 		r = 0;
@@ -358,8 +377,9 @@
 static void process_queued_ios(void *data)
 {
 	struct multipath *m = (struct multipath *) data;
+	struct hw_handler *hwh = &m->hw_handler;
 	struct pgpath *pgpath;
-	unsigned must_queue = 0;
+	unsigned init_required, must_queue = 0;
 	unsigned long flags;
 
 	spin_lock_irqsave(&m->lock, flags);
@@ -373,8 +393,15 @@
 	    (!pgpath && m->queue_if_no_path && !m->suspended))
 		must_queue = 1;
 
+	init_required = m->pg_init_required;
+	if (init_required)
+		m->pg_init_required = 0;
+
 	spin_unlock_irqrestore(&m->lock, flags);
 
+	if (init_required)
+		hwh->type->pg_init(hwh, pgpath->pg->bypassed, &pgpath->path);
+
 	if (!must_queue)
 		dispatch_queued_ios(m);
 }
@@ -393,6 +420,7 @@
 /*-----------------------------------------------------------------
  * Constructor/argument parsing:
  * <#multipath feature args> [<arg>]*
+ * <#hw_handler args> [hw_handler [<arg>]*]
  * <#priority groups> 
  * <initial priority group>
  *     [<selector> <#selector args> [<arg>]*
@@ -584,6 +612,43 @@
 	return NULL;
 }
 
+static int parse_hw_handler(struct arg_set *as, struct multipath *m,
+			    struct dm_target *ti)
+{
+	int r;
+	struct hw_handler_type *hwht;
+	unsigned hw_argc;
+
+	static struct param _params[] = {
+		{0, 1024, ESTR("invalid number of hardware handler args")},
+	};
+
+	r = read_param(_params, shift(as), &hw_argc, &ti->error);
+	if (r)
+		return -EINVAL;
+
+	if (!hw_argc)
+		return 0;
+
+	hwht = dm_get_hw_handler(shift(as));
+	if (!hwht) {
+		ti->error = ESTR("unknown hardware handler type");
+		return -EINVAL;
+	}
+
+	r = hwht->ctr(&m->hw_handler, hw_argc - 1, as->argv);
+	if (r) {
+		dm_put_hw_handler(hwht);
+		ti->error = ESTR("hardware handler constructor failed");
+		return r;
+	}
+
+	m->hw_handler.type = hwht;
+	consume(as, hw_argc - 1);
+
+	return 0;
+}
+
 static int parse_features(struct arg_set *as, struct multipath *m,
 			  struct dm_target *ti)
 {
@@ -637,6 +702,10 @@
 	if (r)
 		goto bad;
 
+	r = parse_hw_handler(&as, m, ti);
+	if (r)
+		goto bad;
+
 	r = read_param(_params, shift(&as), &m->nr_priority_groups, &ti->error);
 	if (r)
 		goto bad;
@@ -873,11 +942,43 @@
 }
 
 /*
+ * pg_init must call this when it has completed its initialisation
+ */
+void dm_pg_init_complete(struct path *path, unsigned err_flags)
+{
+	struct pgpath *pgpath = path_to_pgpath(path);
+	struct priority_group *pg = pgpath->pg;
+	struct multipath *m = pg->m;
+	unsigned long flags;
+
+	/* We insist on failing the path if the PG is already bypassed. */
+	if (err_flags && pg->bypassed)
+		err_flags |= MP_FAIL_PATH;
+
+	if (err_flags & MP_FAIL_PATH)
+		fail_path(pgpath);
+
+	if (err_flags & MP_BYPASS_PG)
+		bypass_pg(m, pg, 1);
+
+	spin_lock_irqsave(&m->lock, flags);
+	if (!err_flags)
+		m->queue_io = 0;
+	else {
+		m->current_pgpath = NULL;
+		m->current_pg = NULL;
+	}
+	schedule_work(&m->process_queued_ios);
+	spin_unlock_irqrestore(&m->lock, flags);
+}
+
+/*
  * end_io handling
  */
 static int do_end_io(struct multipath *m, struct bio *bio,
 		     int error, struct mpath_io *mpio)
 {
+	struct hw_handler *hwh = &m->hw_handler;
 	unsigned err_flags = MP_FAIL_PATH;	/* Default behavior */
 
 	if (!error)
@@ -895,6 +996,9 @@
 	}
 	spin_unlock(&m->lock);
 
+	if (hwh->type && hwh->type->err)
+		err_flags = hwh->type->err(hwh, bio);
+
 	if (mpio->pgpath) {
 		if (err_flags & MP_FAIL_PATH)
 			fail_path(mpio->pgpath);
@@ -970,6 +1074,7 @@
 /*
  * Info output has the following format:
  * num_multipath_feature_args [multipath_feature_args]*
+ * num_handler_status_args [handler_status_args]*
  * num_groups init_group_number
  *            [A|D|E num_ps_status_args [ps_status_args]*
  *             num_paths num_selector_args 
@@ -977,6 +1082,7 @@
  *
  * Table output has the following format (identical to the constructor string):
  * num_feature_args [features_args]*
+ * num_handler_args hw_handler [hw_handler_args]*
  * num_groups init_group_number
  *     [priority selector-name num_ps_args [ps_args]*
  *      num_paths num_selector_args [path_dev [selector_args]* ]+ ]+
@@ -987,6 +1093,7 @@
 	int sz = 0;
 	unsigned long flags;
 	struct multipath *m = (struct multipath *) ti->private;
+	struct hw_handler *hwh = &m->hw_handler;
 	struct priority_group *pg;
 	struct pgpath *p;
 	unsigned pg_num;
@@ -1002,6 +1109,13 @@
 	else
 		DMEMIT("0 ");
 
+	if (hwh->type && hwh->type->status)
+		sz += hwh->type->status(hwh, type, result + sz, maxlen - sz);
+	else if (!hwh->type || type == STATUSTYPE_INFO)
+		DMEMIT("0 ");
+	else
+		DMEMIT("1 %s ", hwh->type->name);
+
 	DMEMIT("%u ", m->nr_priority_groups);
 
 	if (m->next_pg)
@@ -1178,6 +1292,8 @@
 	kmem_cache_destroy(_mpio_cache);
 }
 
+EXPORT_SYMBOL(dm_pg_init_complete);
+
 module_init(dm_multipath_init);
 module_exit(dm_multipath_exit);
 
--- diff/drivers/md/dm-mpath.h	2005-02-09 14:41:52.000000000 +0000
+++ source/drivers/md/dm-mpath.h	2005-02-09 14:42:12.000000000 +0000
@@ -16,6 +16,10 @@
 	unsigned is_active;	/* Read-only */
 
 	void *pscontext;	/* For path-selector use */
+	void *hwhcontext;	/* For hw-handler use */
 };
 
+/* Callback for hwh_pg_init_fn to use when complete */
+void dm_pg_init_complete(struct path *path, unsigned err_flags);
+ 
 #endif
--- diff/drivers/md/dm-hw-handler.c	1970-01-01 01:00:00.000000000 +0100
+++ source/drivers/md/dm-hw-handler.c	2005-02-09 14:42:12.000000000 +0000
@@ -0,0 +1,216 @@
+/*
+ * Copyright (C) 2004 Red Hat, Inc. All rights reserved.
+ *
+ * This file is released under the GPL.
+ *
+ * Multipath hardware handler registration.
+ */
+
+#include "dm.h"
+#include "dm-hw-handler.h"
+
+#include <linux/slab.h>
+
+struct hwh_internal {
+	struct hw_handler_type hwht;
+
+	struct list_head list;
+	long use;
+};
+
+#define hwht_to_hwhi(__hwht) container_of((__hwht), struct hwh_internal, hwht)
+
+static LIST_HEAD(_hw_handlers);
+static DECLARE_RWSEM(_hwh_lock);
+
+struct hwh_internal *__find_hw_handler_type(const char *name)
+{
+	struct hwh_internal *hwhi;
+
+	list_for_each_entry(hwhi, &_hw_handlers, list) {
+		if (!strcmp(name, hwhi->hwht.name))
+			return hwhi;
+	}
+
+	return NULL;
+}
+
+static struct hwh_internal *get_hw_handler(const char *name)
+{
+	struct hwh_internal *hwhi;
+
+	down_read(&_hwh_lock);
+	hwhi = __find_hw_handler_type(name);
+	if (hwhi) {
+		if ((hwhi->use == 0) && !try_module_get(hwhi->hwht.module))
+			hwhi = NULL;
+		else
+			hwhi->use++;
+	}
+	up_read(&_hwh_lock);
+
+	return hwhi;
+}
+
+struct hw_handler_type *dm_get_hw_handler(const char *name)
+{
+	struct hwh_internal *hwhi;
+
+	if (!name)
+		return NULL;
+
+	hwhi = get_hw_handler(name);
+	if (!hwhi) {
+		request_module("dm-%s", name);
+		hwhi = get_hw_handler(name);
+	}
+
+	return hwhi ? &hwhi->hwht : NULL;
+}
+
+void dm_put_hw_handler(struct hw_handler_type *hwht)
+{
+	struct hwh_internal *hwhi;
+
+	if (!hwht)
+		return;
+
+	down_read(&_hwh_lock);
+	hwhi = __find_hw_handler_type(hwht->name);
+	if (!hwhi)
+		goto out;
+
+	if (--hwhi->use == 0)
+		module_put(hwhi->hwht.module);
+
+	if (hwhi->use < 0)
+		BUG();
+
+      out:
+	up_read(&_hwh_lock);
+}
+
+static struct hwh_internal *_alloc_hw_handler(struct hw_handler_type *hwht)
+{
+	struct hwh_internal *hwhi = kmalloc(sizeof(*hwhi), GFP_KERNEL);
+
+	if (hwhi) {
+		memset(hwhi, 0, sizeof(*hwhi));
+		hwhi->hwht = *hwht;
+	}
+
+	return hwhi;
+}
+
+int dm_register_hw_handler(struct hw_handler_type *hwht)
+{
+	int r = 0;
+	struct hwh_internal *hwhi = _alloc_hw_handler(hwht);
+
+	if (!hwhi)
+		return -ENOMEM;
+
+	down_write(&_hwh_lock);
+
+	if (__find_hw_handler_type(hwht->name)) {
+		kfree(hwhi);
+		r = -EEXIST;
+	} else
+		list_add(&hwhi->list, &_hw_handlers);
+
+	up_write(&_hwh_lock);
+
+	return r;
+}
+
+int dm_unregister_hw_handler(struct hw_handler_type *hwht)
+{
+	struct hwh_internal *hwhi;
+
+	down_write(&_hwh_lock);
+
+	hwhi = __find_hw_handler_type(hwht->name);
+	if (!hwhi) {
+		up_write(&_hwh_lock);
+		return -EINVAL;
+	}
+
+	if (hwhi->use) {
+		up_write(&_hwh_lock);
+		return -ETXTBSY;
+	}
+
+	list_del(&hwhi->list);
+
+	up_write(&_hwh_lock);
+
+	kfree(hwhi);
+
+	return 0;
+}
+
+unsigned dm_scsi_err_handler(struct hw_handler *hwh, struct bio *bio)
+{
+	int sense_key, asc, ascq;
+
+#if 0
+	if (bio->bi_error & BIO_SENSE) {
+		/* FIXME: This is just an initial guess. */
+		/* key / asc / ascq */
+		sense_key = (bio->bi_error >> 16) & 0xff;
+		asc = (bio->bi_error >> 8) & 0xff;
+		ascq = bio->bi_error & 0xff;
+
+		switch (sense_key) {
+			/* This block as a whole comes from the device.
+			 * So no point retrying on another path. */
+		case 0x03:	/* Medium error */
+		case 0x05:	/* Illegal request */
+		case 0x07:	/* Data protect */
+		case 0x08:	/* Blank check */
+		case 0x0a:	/* copy aborted */
+		case 0x0c:	/* obsolete - no clue ;-) */
+		case 0x0d:	/* volume overflow */
+		case 0x0e:	/* data miscompare */
+		case 0x0f:	/* reserved - no idea either. */
+			return MP_ERROR_IO;
+
+			/* For these errors it's unclear whether they
+			 * come from the device or the controller.
+			 * So just lets try a different path, and if
+			 * it eventually succeeds, user-space will clear
+			 * the paths again... */
+		case 0x02:	/* Not ready */
+		case 0x04:	/* Hardware error */
+		case 0x09:	/* vendor specific */
+		case 0x0b:	/* Aborted command */
+			return MP_FAIL_PATH;
+
+		case 0x06:	/* Unit attention - might want to decode */
+			if (asc == 0x04 && ascq == 0x01)
+				/* "Unit in the process of
+				 * becoming ready" */
+				return 0;
+			return MP_FAIL_PATH;
+
+			/* FIXME: For Unit Not Ready we may want
+			 * to have a generic pg activation
+			 * feature (START_UNIT). */
+
+			/* Should these two ever end up in the
+			 * error path? I don't think so. */
+		case 0x00:	/* No sense */
+		case 0x01:	/* Recovered error */
+			return 0;
+		}
+	}
+#endif
+
+	/* We got no idea how to decode the other kinds of errors ->
+	 * assume generic error condition. */
+	return MP_FAIL_PATH;
+}
+
+EXPORT_SYMBOL(dm_register_hw_handler);
+EXPORT_SYMBOL(dm_unregister_hw_handler);
+EXPORT_SYMBOL(dm_scsi_err_handler);
--- diff/drivers/md/dm-hw-handler.h	1970-01-01 01:00:00.000000000 +0100
+++ source/drivers/md/dm-hw-handler.h	2005-02-09 14:42:12.000000000 +0000
@@ -0,0 +1,68 @@
+/*
+ * Copyright (C) 2004 Red Hat, Inc. All rights reserved.
+ *
+ * This file is released under the GPL.
+ *
+ * Multipath hardware handler registration.
+ */
+
+#ifndef	DM_HW_HANDLER_H
+#define	DM_HW_HANDLER_H
+
+#include <linux/device-mapper.h>
+
+#include "dm-mpath.h"
+
+struct hw_handler_type;
+struct hw_handler {
+	struct hw_handler_type *type;
+	void *context;
+};
+
+/*
+ * Constructs a hardware handler object, takes custom arguments
+ */
+typedef int (*hwh_ctr_fn) (struct hw_handler *hwh, unsigned arc, char **argv);
+typedef void (*hwh_dtr_fn) (struct hw_handler *hwh);
+
+typedef void (*hwh_pg_init_fn) (struct hw_handler *hwh, unsigned bypassed,
+				struct path *path);
+typedef unsigned (*hwh_err_fn) (struct hw_handler *hwh, struct bio *bio);
+typedef	int (*hwh_status_fn) (struct hw_handler *hwh,
+			      status_type_t type,
+			      char *result, unsigned int maxlen);
+
+/* Information about a hardware handler type */
+struct hw_handler_type {
+	char *name;
+	struct module *module;
+
+	hwh_ctr_fn ctr;
+	hwh_dtr_fn dtr;
+
+	hwh_pg_init_fn pg_init;
+	hwh_err_fn err;
+	hwh_status_fn status;
+};
+
+/* Register a hardware handler */
+int dm_register_hw_handler(struct hw_handler_type *type);
+
+/* Unregister a hardware handler */
+int dm_unregister_hw_handler(struct hw_handler_type *type);
+
+/* Returns a registered hardware handler type */
+struct hw_handler_type *dm_get_hw_handler(const char *name);
+
+/* Releases a hardware handler  */
+void dm_put_hw_handler(struct hw_handler_type *hwht);
+
+/* Default hwh_err_fn */
+unsigned dm_scsi_err_handler(struct hw_handler *hwh, struct bio *bio);
+
+/* Error flags for hwh_err_fn and dm_pg_init_complete */
+#define MP_FAIL_PATH 1
+#define MP_BYPASS_PG 2
+#define MP_ERROR_IO  4	/* Don't retry this I/O */
+
+#endif
