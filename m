Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751251AbWINVxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbWINVxP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 17:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWINVxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 17:53:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6875 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751245AbWINVxM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 17:53:12 -0400
Date: Thu, 14 Sep 2006 22:53:00 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Bryn Reeves <breeves@redhat.com>
Subject: [PATCH 25/25] dm table: add target flush
Message-ID: <20060914215300.GF3928@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Bryn Reeves <breeves@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bryn Reeves <breeves@redhat.com>

This patch adds support for a per-target dm_flush_fn method.
This is needed to allow dm-loop to invalidate page cache 
mappings in response to BLKFLSBUF ioctl commands.

Signed-off-by: Bryn Reeves <breeves@redhat.com>
Signed-off-by: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.18-rc7/drivers/md/dm-table.c
===================================================================
--- linux-2.6.18-rc7.orig/drivers/md/dm-table.c	2006-09-14 21:36:09.000000000 +0100
+++ linux-2.6.18-rc7/drivers/md/dm-table.c	2006-09-14 21:36:49.000000000 +0100
@@ -1001,6 +1001,11 @@ int dm_table_flush_all(struct dm_table *
 {
 	struct list_head *d, *devices = dm_table_get_devices(t);
 	int ret = 0;
+	unsigned i;
+
+	for (i = 0; i < t->num_targets; i++)
+		if (t->targets[i].type->flush)
+			t->targets[i].type->flush(&t->targets[i]);
 
 	for (d = devices->next; d != devices; d = d->next) {
 		struct dm_dev *dd = list_entry(d, struct dm_dev, list);
Index: linux-2.6.18-rc7/include/linux/device-mapper.h
===================================================================
--- linux-2.6.18-rc7.orig/include/linux/device-mapper.h	2006-09-14 21:36:09.000000000 +0100
+++ linux-2.6.18-rc7/include/linux/device-mapper.h	2006-09-14 21:36:49.000000000 +0100
@@ -55,6 +55,7 @@ typedef int (*dm_endio_fn) (struct dm_ta
 			    struct bio *bio, int error,
 			    union map_info *map_context);
 
+typedef void (*dm_flush_fn) (struct dm_target *ti);
 typedef void (*dm_presuspend_fn) (struct dm_target *ti);
 typedef void (*dm_postsuspend_fn) (struct dm_target *ti);
 typedef int (*dm_preresume_fn) (struct dm_target *ti);
@@ -96,6 +97,7 @@ struct target_type {
 	dm_dtr_fn dtr;
 	dm_map_fn map;
 	dm_endio_fn end_io;
+	dm_flush_fn flush;
 	dm_presuspend_fn presuspend;
 	dm_postsuspend_fn postsuspend;
 	dm_preresume_fn preresume;
Index: linux-2.6.18-rc7/include/linux/dm-ioctl.h
===================================================================
--- linux-2.6.18-rc7.orig/include/linux/dm-ioctl.h	2006-09-14 21:05:03.000000000 +0100
+++ linux-2.6.18-rc7/include/linux/dm-ioctl.h	2006-09-14 21:37:12.000000000 +0100
@@ -285,7 +285,7 @@ typedef char ioctl_struct[308];
 #define DM_DEV_SET_GEOMETRY	_IOWR(DM_IOCTL, DM_DEV_SET_GEOMETRY_CMD, struct dm_ioctl)
 
 #define DM_VERSION_MAJOR	4
-#define DM_VERSION_MINOR	9
+#define DM_VERSION_MINOR	10
 #define DM_VERSION_PATCHLEVEL	0
 #define DM_VERSION_EXTRA	"-ioctl (2006-09-14)"
 
