Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261573AbVBHQzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbVBHQzW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 11:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbVBHQzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 11:55:21 -0500
Received: from mx1.redhat.com ([66.187.233.31]:45230 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261573AbVBHQzF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 11:55:05 -0500
Date: Tue, 8 Feb 2005 16:54:57 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>, axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] device-mapper: Record & restore bio state.
Message-ID: <20050208165457.GT10195@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, axboe@suse.de,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simple functions to record and restore bio state so we can
resubmit a bio that returned an error.

DM multipath (following shortly) uses this.

This patch has it private to device-mapper: is it any use elsewhere?

Signed-Off-By: Alasdair G Kergon <agk@redhat.com>
--- diff/drivers/md/dm-bio-record.h	1970-01-01 01:00:00.000000000 +0100
+++ source/drivers/md/dm-bio-record.h	2005-02-08 16:40:42.000000000 +0000
@@ -0,0 +1,45 @@
+/*
+ * Copyright (C) 2004-2005 Red Hat, Inc. All rights reserved.
+ *
+ * This file is released under the GPL.
+ */
+
+#ifndef DM_BIO_RECORD_H
+#define DM_BIO_RECORD_H
+
+#include <linux/bio.h>
+
+/*
+ * There are lots of mutable fields in the bio struct that get
+ * changed by the lower levels of the block layer.  Some targets,
+ * such as multipath, may wish to resubmit a bio on error.  The
+ * functions in this file help the target record and restore the
+ * original bio state.
+ */
+struct dm_bio_details {
+	sector_t bi_sector;
+	struct block_device *bi_bdev;
+	unsigned int bi_size;
+	unsigned short bi_idx;
+	unsigned long bi_flags;
+};
+
+static inline void dm_bio_record(struct dm_bio_details *bd, struct bio *bio)
+{
+	bd->bi_sector = bio->bi_sector;
+	bd->bi_bdev = bio->bi_bdev;
+	bd->bi_size = bio->bi_size;
+	bd->bi_idx = bio->bi_idx;
+	bd->bi_flags = bio->bi_flags;
+}
+
+static inline void dm_bio_restore(struct dm_bio_details *bd, struct bio *bio)
+{
+	bio->bi_sector = bd->bi_sector;
+	bio->bi_bdev = bd->bi_bdev;
+	bio->bi_size = bd->bi_size;
+	bio->bi_idx = bd->bi_idx;
+	bio->bi_flags = bd->bi_flags;
+}
+
+#endif
