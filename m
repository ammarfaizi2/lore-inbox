Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263435AbUFBPuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263435AbUFBPuX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 11:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263324AbUFBPuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 11:50:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19098 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263435AbUFBPqL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 11:46:11 -0400
Date: Wed, 2 Jun 2004 16:46:05 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] 5/5: Device-mapper: dm-zero
Message-ID: <20040602154605.GR6302@agk.surrey.redhat.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	LKML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dm-zero

--- diff/drivers/md/Kconfig	2004-06-01 19:56:27.000000000 -0500
+++ source/drivers/md/Kconfig	2004-06-01 19:56:47.000000000 -0500
@@ -193,5 +193,12 @@
          Allow volume managers to mirror logical volumes, also
          needed for live data migration tools such as 'pvmove'.
 
+config DM_ZERO
+	tristate "Zero target (EXPERIMENTAL)"
+	depends on BLK_DEV_DM && EXPERIMENTAL
+	---help---
+	  A target that discards writes, and returns all zeroes for
+	  reads.  Useful in some recovery situations.
+
 endmenu
 
--- diff/drivers/md/Makefile	2004-06-01 19:56:27.000000000 -0500
+++ source/drivers/md/Makefile	2004-06-01 19:56:47.000000000 -0500
@@ -28,6 +28,7 @@
 obj-$(CONFIG_DM_CRYPT)		+= dm-crypt.o
 obj-$(CONFIG_DM_SNAPSHOT)	+= dm-snapshot.o
 obj-$(CONFIG_DM_MIRROR)		+= dm-mirror.o
+obj-$(CONFIG_DM_ZERO)		+= dm-zero.o
 
 quiet_cmd_unroll = UNROLL  $@
       cmd_unroll = $(PERL) $(srctree)/$(src)/unroll.pl $(UNROLL) \
--- diff/drivers/md/dm-zero.c	1969-12-31 18:00:00.000000000 -0600
+++ source/drivers/md/dm-zero.c	2004-06-01 19:56:47.000000000 -0500
@@ -0,0 +1,96 @@
+/*
+ * Copyright (C) 2003 Christophe Saout <christophe@saout.de>
+ *
+ * This file is released under the GPL.
+ */
+
+#include "dm.h"
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/bio.h>
+
+/*
+ * Construct a dummy mapping that only returns zeros
+ */
+static int zero_ctr(struct dm_target *ti, unsigned int argc, char **argv)
+{
+	if (argc != 0) {
+		ti->error = "dm-zero: No arguments required";
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/*
+ * Fills the bio pages with zeros
+ */
+static void zero_fill_bio(struct bio *bio)
+{
+	unsigned long flags;
+	struct bio_vec *bv;
+	int i;
+
+	bio_for_each_segment(bv, bio, i) {
+		char *data = bvec_kmap_irq(bv, &flags);
+		memset(data, 0, bv->bv_len);
+		bvec_kunmap_irq(bv, &flags);
+	}
+}
+
+/*
+ * Return zeros only on reads
+ */
+static int zero_map(struct dm_target *ti, struct bio *bio,
+		      union map_info *map_context)
+{
+	switch(bio_rw(bio)) {
+	case READ:
+		zero_fill_bio(bio);
+		break;
+	case READA:
+		/* readahead of null bytes only wastes buffer cache */
+		return -EIO;
+	case WRITE:
+		/* writes get silently dropped */
+		break;
+	}
+
+	bio_endio(bio, bio->bi_size, 0);
+
+	/* accepted bio, don't make new request */
+	return 0;
+}
+
+static struct target_type zero_target = {
+	.name   = "zero",
+	.module = THIS_MODULE,
+	.ctr    = zero_ctr,
+	.map    = zero_map,
+};
+
+int __init dm_zero_init(void)
+{
+	int r = dm_register_target(&zero_target);
+
+	if (r < 0)
+		DMERR("zero: register failed %d", r);
+
+	return r;
+}
+
+void __exit dm_zero_exit(void)
+{
+	int r = dm_unregister_target(&zero_target);
+
+	if (r < 0)
+		DMERR("zero: unregister failed %d", r);
+}
+
+module_init(dm_zero_init)
+module_exit(dm_zero_exit)
+
+MODULE_AUTHOR("Christophe Saout <christophe@saout.de>");
+MODULE_DESCRIPTION(DM_NAME " dummy target returning zeros");
+MODULE_LICENSE("GPL");

