Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262280AbVBKRVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262280AbVBKRVq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 12:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262294AbVBKRVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 12:21:45 -0500
Received: from mx1.redhat.com ([66.187.233.31]:48855 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262280AbVBKRQs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 12:16:48 -0500
Date: Fri, 11 Feb 2005 17:16:44 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] device-mapper: multipath round-robin path selector.
Message-ID: <20050211171644.GY10195@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A very basic path selector: round-robin.

It uses in turn each path that has not been disabled.

By default, it instructs core multipath to use each path it supplies
for 1000 bios, but a different repeat_count can be set against
any path to provide primitive load-balancing across unequal paths.

Signed-Off-By: Alasdair G Kergon <agk@redhat.com>
--- diff/drivers/md/Makefile	2005-02-09 14:41:52.000000000 +0000
+++ source/drivers/md/Makefile	2005-02-09 14:42:03.000000000 +0000
@@ -31,7 +31,7 @@
 obj-$(CONFIG_BLK_DEV_MD)	+= md.o
 obj-$(CONFIG_BLK_DEV_DM)	+= dm-mod.o
 obj-$(CONFIG_DM_CRYPT)		+= dm-crypt.o
-obj-$(CONFIG_DM_MULTIPATH)	+= dm-multipath.o
+obj-$(CONFIG_DM_MULTIPATH)	+= dm-multipath.o dm-round-robin.o
 obj-$(CONFIG_DM_SNAPSHOT)	+= dm-snapshot.o
 obj-$(CONFIG_DM_MIRROR)		+= dm-mirror.o
 obj-$(CONFIG_DM_ZERO)		+= dm-zero.o
--- diff/drivers/md/dm-round-robin.c	1970-01-01 01:00:00.000000000 +0100
+++ source/drivers/md/dm-round-robin.c	2005-02-09 14:42:03.000000000 +0000
@@ -0,0 +1,214 @@
+/*
+ * Copyright (C) 2003 Sistina Software.
+ * Copyright (C) 2004-2005 Red Hat, Inc. All rights reserved.
+ *
+ * Module Author: Heinz Mauelshagen
+ *
+ * This file is released under the GPL.
+ *
+ * Round-robin path selector.
+ */
+
+#include "dm.h"
+#include "dm-path-selector.h"
+
+#include <linux/slab.h>
+
+/*-----------------------------------------------------------------
+ * Path-handling code, paths are held in lists
+ *---------------------------------------------------------------*/
+struct path_info {
+	struct list_head list;
+	struct path *path;
+	unsigned repeat_count;
+};
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
+/*-----------------------------------------------------------------
+ * Round-robin selector
+ *---------------------------------------------------------------*/
+
+#define RR_MIN_IO		1000
+
+struct selector {
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
+	}
+
+	return s;
+}
+
+static int rr_ctr(struct path_selector *ps, unsigned argc, char **argv)
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
+static void rr_dtr(struct path_selector *ps)
+{
+	struct selector *s = (struct selector *) ps->context;
+
+	free_paths(&s->valid_paths);
+	free_paths(&s->invalid_paths);
+	kfree(s);
+	ps->context = NULL;
+}
+
+static int rr_status(struct path_selector *ps, struct path *path,
+		     status_type_t type, char *result, unsigned int maxlen)
+{
+	struct path_info *pi;
+	int sz = 0;
+
+	if (!path)
+		DMEMIT("0 ");
+	else {
+		switch(type) {
+		case STATUSTYPE_INFO:
+			break;
+		case STATUSTYPE_TABLE:
+			pi = path->pscontext;
+			DMEMIT("%u ", pi->repeat_count);
+			break;
+		}
+	}
+
+	return sz;
+}
+
+/*
+ * Called during initialisation to register each path with an
+ * optional repeat_count.
+ */
+static int rr_add_path(struct path_selector *ps, struct path *path,
+		       int argc, char **argv, char **error)
+{
+	struct selector *s = (struct selector *) ps->context;
+	struct path_info *pi;
+	unsigned repeat_count = RR_MIN_IO;
+
+	if (argc > 1) {
+		*error = "round-robin ps: incorrect number of arguments";
+		return -EINVAL;
+	}
+
+	/* First path argument is number of I/Os before switching path */
+	if ((argc == 1) && (sscanf(argv[0], "%u", &repeat_count) != 1)) {
+		*error = "round-robin ps: invalid repeat count";
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
+	pi->repeat_count = repeat_count;
+
+	path->pscontext = pi;
+
+	list_add(&pi->list, &s->valid_paths);
+
+	return 0;
+}
+
+static void rr_fail_path(struct path_selector *ps, struct path *p)
+{
+	struct selector *s = (struct selector *) ps->context;
+	struct path_info *pi = p->pscontext;
+
+	list_move(&pi->list, &s->invalid_paths);
+}
+
+static int rr_reinstate_path(struct path_selector *ps, struct path *p)
+{
+	struct selector *s = (struct selector *) ps->context;
+	struct path_info *pi = p->pscontext;
+
+	list_move(&pi->list, &s->valid_paths);
+
+	return 0;
+}
+
+static struct path *rr_select_path(struct path_selector *ps,
+				   unsigned *repeat_count)
+{
+	struct selector *s = (struct selector *) ps->context;
+	struct path_info *pi = NULL;
+
+	if (!list_empty(&s->valid_paths)) {
+		pi = list_entry(s->valid_paths.next, struct path_info, list);
+		list_move_tail(&pi->list, &s->valid_paths);
+		*repeat_count = pi->repeat_count;
+	}
+
+	return pi ? pi->path : NULL;
+}
+
+static struct path_selector_type rr_ps = {
+	.name = "round-robin",
+	.module = THIS_MODULE,
+	.table_args = 1,
+	.info_args = 0,
+	.ctr = rr_ctr,
+	.dtr = rr_dtr,
+	.status = rr_status,
+	.add_path = rr_add_path,
+	.fail_path = rr_fail_path,
+	.reinstate_path = rr_reinstate_path,
+	.select_path = rr_select_path,
+};
+
+static int __init dm_rr_init(void)
+{
+	int r = dm_register_path_selector(&rr_ps);
+
+	if (r < 0)
+		DMERR("round-robin: register failed %d", r);
+
+	DMINFO("dm-round-robin version 1.0.0 loaded");
+
+	return r;
+}
+
+static void __exit dm_rr_exit(void)
+{
+	int r = dm_unregister_path_selector(&rr_ps);
+
+	if (r < 0)
+		DMERR("round-robin: unregister failed %d", r);
+}
+
+module_init(dm_rr_init);
+module_exit(dm_rr_exit);
+
+MODULE_DESCRIPTION(DM_NAME " round-robin multipath path selector");
+MODULE_AUTHOR("Sistina Software <dm-devel@redhat.com>");
+MODULE_LICENSE("GPL");
