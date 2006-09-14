Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751233AbWINVs6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbWINVs6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 17:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbWINVs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 17:48:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:31192 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751233AbWINVs5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 17:48:57 -0400
Date: Thu, 14 Sep 2006 22:48:49 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Milan Broz <mbroz@redhat.com>
Subject: [PATCH 17/25] dm table: add target preresume
Message-ID: <20060914214849.GY3928@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Milan Broz <mbroz@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Milan Broz <mbroz@redhat.com>

This patch adds a target preresume hook.

It is called before the targets are resumed and if it returns
an error the resume gets cancelled.

The crypt target will use this to indicate that it is
unable to process I/O because no encryption key has been supplied.

Signed-off-by: Milan Broz <mbroz@redhat.com>
Signed-off-by: Alasdair G Kergon <agk@redhat.com>
Cc: Christophe Saout <christophe@saout.de>

Index: linux-2.6.18-rc7/include/linux/device-mapper.h
===================================================================
--- linux-2.6.18-rc7.orig/include/linux/device-mapper.h	2006-09-14 20:20:55.000000000 +0100
+++ linux-2.6.18-rc7/include/linux/device-mapper.h	2006-09-14 21:03:16.000000000 +0100
@@ -57,6 +57,7 @@ typedef int (*dm_endio_fn) (struct dm_ta
 
 typedef void (*dm_presuspend_fn) (struct dm_target *ti);
 typedef void (*dm_postsuspend_fn) (struct dm_target *ti);
+typedef int (*dm_preresume_fn) (struct dm_target *ti);
 typedef void (*dm_resume_fn) (struct dm_target *ti);
 
 typedef int (*dm_status_fn) (struct dm_target *ti, status_type_t status_type,
@@ -92,6 +93,7 @@ struct target_type {
 	dm_endio_fn end_io;
 	dm_presuspend_fn presuspend;
 	dm_postsuspend_fn postsuspend;
+	dm_preresume_fn preresume;
 	dm_resume_fn resume;
 	dm_status_fn status;
 	dm_message_fn message;
Index: linux-2.6.18-rc7/drivers/md/dm-table.c
===================================================================
--- linux-2.6.18-rc7.orig/drivers/md/dm-table.c	2006-09-14 20:20:55.000000000 +0100
+++ linux-2.6.18-rc7/drivers/md/dm-table.c	2006-09-14 21:03:16.000000000 +0100
@@ -939,9 +939,20 @@ void dm_table_postsuspend_targets(struct
 	return suspend_targets(t, 1);
 }
 
-void dm_table_resume_targets(struct dm_table *t)
+int dm_table_resume_targets(struct dm_table *t)
 {
-	int i;
+	int i, r = 0;
+
+	for (i = 0; i < t->num_targets; i++) {
+		struct dm_target *ti = t->targets + i;
+
+		if (!ti->type->preresume)
+			continue;
+
+		r = ti->type->preresume(ti);
+		if (r)
+			return r;
+	}
 
 	for (i = 0; i < t->num_targets; i++) {
 		struct dm_target *ti = t->targets + i;
@@ -949,6 +960,8 @@ void dm_table_resume_targets(struct dm_t
 		if (ti->type->resume)
 			ti->type->resume(ti);
 	}
+
+	return 0;
 }
 
 int dm_table_any_congested(struct dm_table *t, int bdi_bits)
Index: linux-2.6.18-rc7/drivers/md/dm.c
===================================================================
--- linux-2.6.18-rc7.orig/drivers/md/dm.c	2006-09-14 20:55:52.000000000 +0100
+++ linux-2.6.18-rc7/drivers/md/dm.c	2006-09-14 21:03:16.000000000 +0100
@@ -1360,7 +1360,9 @@ int dm_resume(struct mapped_device *md)
 	if (!map || !dm_table_get_size(map))
 		goto out;
 
-	dm_table_resume_targets(map);
+	r = dm_table_resume_targets(map);
+	if (r)
+		goto out;
 
 	down_write(&md->io_lock);
 	clear_bit(DMF_BLOCK_IO, &md->flags);
Index: linux-2.6.18-rc7/drivers/md/dm.h
===================================================================
--- linux-2.6.18-rc7.orig/drivers/md/dm.h	2006-09-14 21:00:46.000000000 +0100
+++ linux-2.6.18-rc7/drivers/md/dm.h	2006-09-14 21:03:16.000000000 +0100
@@ -57,7 +57,7 @@ void dm_table_set_restrictions(struct dm
 struct list_head *dm_table_get_devices(struct dm_table *t);
 void dm_table_presuspend_targets(struct dm_table *t);
 void dm_table_postsuspend_targets(struct dm_table *t);
-void dm_table_resume_targets(struct dm_table *t);
+int dm_table_resume_targets(struct dm_table *t);
 int dm_table_any_congested(struct dm_table *t, int bdi_bits);
 void dm_table_unplug_all(struct dm_table *t);
 int dm_table_flush_all(struct dm_table *t);
Index: linux-2.6.18-rc7/include/linux/dm-ioctl.h
===================================================================
--- linux-2.6.18-rc7.orig/include/linux/dm-ioctl.h	2006-09-14 18:07:58.000000000 +0100
+++ linux-2.6.18-rc7/include/linux/dm-ioctl.h	2006-09-14 21:05:03.000000000 +0100
@@ -285,9 +285,9 @@ typedef char ioctl_struct[308];
 #define DM_DEV_SET_GEOMETRY	_IOWR(DM_IOCTL, DM_DEV_SET_GEOMETRY_CMD, struct dm_ioctl)
 
 #define DM_VERSION_MAJOR	4
-#define DM_VERSION_MINOR	8
+#define DM_VERSION_MINOR	9
 #define DM_VERSION_PATCHLEVEL	0
-#define DM_VERSION_EXTRA	"-ioctl (2006-06-24)"
+#define DM_VERSION_EXTRA	"-ioctl (2006-09-14)"
 
 /* Status bits */
 #define DM_READONLY_FLAG	(1 << 0) /* In/Out */
