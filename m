Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264650AbSJORnG>; Tue, 15 Oct 2002 13:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264741AbSJORlh>; Tue, 15 Oct 2002 13:41:37 -0400
Received: from mail18.svr.pol.co.uk ([195.92.67.23]:27923 "EHLO
	mail18.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S263438AbSJORkZ>; Tue, 15 Oct 2002 13:40:25 -0400
Date: Tue, 15 Oct 2002 18:46:24 +0100
To: Linux Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>, Dave Jones <davej@suse.de>
Subject: [PATCH] Device-mapper submission 4/7
Message-ID: <20021015174624.GD27753@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Device-mapper]
The linear target maps a contigous range of logical sectors onto an
range of physical sectors.

--- a/drivers/md/Makefile	Tue Oct 15 18:24:36 2002
+++ b/drivers/md/Makefile	Tue Oct 15 18:24:36 2002
@@ -4,7 +4,7 @@
 
 export-objs	:= md.o xor.o dm-table.o dm-target.o
 lvm-mod-objs	:= lvm.o lvm-snap.o lvm-fs.o
-dm-mod-objs	:= dm.o dm-hash.o dm-table.o dm-target.o
+dm-mod-objs	:= dm.o dm-hash.o dm-table.o dm-target.o dm-linear.o
 
 # Note: link order is important.  All raid personalities
 # and xor.o must come before md.o, as they each initialise 
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/md/dm-linear.c	Tue Oct 15 18:24:36 2002
@@ -0,0 +1,126 @@
+/*
+ * Copyright (C) 2001 Sistina Software (UK) Limited.
+ *
+ * This file is released under the GPL.
+ */
+
+#include "dm.h"
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/blkdev.h>
+#include <linux/bio.h>
+
+/*
+ * Linear: maps a linear range of a device.
+ */
+struct linear_c {
+	long delta;		/* FIXME: we need a signed offset type */
+	long start;		/* For display only */
+	struct dm_dev *dev;
+};
+
+/*
+ * Construct a linear mapping: <dev_path> <offset>
+ */
+static int linear_ctr(struct dm_target *ti, int argc, char **argv)
+{
+	struct linear_c *lc;
+	unsigned long start;	/* FIXME: unsigned long long */
+	char *end;
+
+	if (argc != 2) {
+		ti->error = "dm-linear: Not enough arguments";
+		return -EINVAL;
+	}
+
+	lc = kmalloc(sizeof(*lc), GFP_KERNEL);
+	if (lc == NULL) {
+		ti->error = "dm-linear: Cannot allocate linear context";
+		return -ENOMEM;
+	}
+
+	start = simple_strtoul(argv[1], &end, 10);
+	if (*end) {
+		ti->error = "dm-linear: Invalid device sector";
+		goto bad;
+	}
+
+	if (dm_get_device(ti, argv[0], ti->begin, ti->len,
+			  ti->table->mode, &lc->dev)) {
+		ti->error = "dm-linear: Device lookup failed";
+		goto bad;
+	}
+
+	lc->delta = (sector_t) start - ti->begin;
+	lc->start = (sector_t) start;
+	ti->private = lc;
+	return 0;
+
+      bad:
+	kfree(lc);
+	return -EINVAL;
+}
+
+static void linear_dtr(struct dm_target *ti)
+{
+	struct linear_c *lc = (struct linear_c *) ti->private;
+
+	dm_put_device(ti, lc->dev);
+	kfree(lc);
+}
+
+static int linear_map(struct dm_target *ti, struct bio *bio)
+{
+	struct linear_c *lc = (struct linear_c *) ti->private;
+
+	bio->bi_bdev = lc->dev->bdev;
+	bio->bi_sector = bio->bi_sector + lc->delta;
+
+	return 1;
+}
+
+static int linear_status(struct dm_target *ti, status_type_t type,
+			 char *result, int maxlen)
+{
+	struct linear_c *lc = (struct linear_c *) ti->private;
+
+	switch (type) {
+	case STATUSTYPE_INFO:
+		result[0] = '\0';
+		break;
+
+	case STATUSTYPE_TABLE:
+		snprintf(result, maxlen, "%s %ld", kdevname(lc->dev->dev),
+			 lc->start);
+		break;
+	}
+	return 0;
+}
+
+static struct target_type linear_target = {
+	.name   = "linear",
+	.module = THIS_MODULE,
+	.ctr    = linear_ctr,
+	.dtr    = linear_dtr,
+	.map    = linear_map,
+	.status = linear_status,
+};
+
+int __init dm_linear_init(void)
+{
+	int r = dm_register_target(&linear_target);
+
+	if (r < 0)
+		DMERR("linear: register failed %d", r);
+
+	return r;
+}
+
+void dm_linear_exit(void)
+{
+	int r = dm_unregister_target(&linear_target);
+
+	if (r < 0)
+		DMERR("linear: unregister failed %d", r);
+}
--- a/drivers/md/dm.c	Tue Oct 15 18:24:36 2002
+++ b/drivers/md/dm.c	Tue Oct 15 18:24:36 2002
@@ -113,6 +113,7 @@
 	xx(local)
 	xx(dm_hash)
 	xx(dm_target)
+	xx(dm_linear)
 #undef xx
 };
 
