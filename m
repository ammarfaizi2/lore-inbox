Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262457AbVAUSNV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262457AbVAUSNV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 13:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262442AbVAUSLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 13:11:10 -0500
Received: from mx1.redhat.com ([66.187.233.31]:35748 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262441AbVAUSGj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 13:06:39 -0500
Date: Fri, 21 Jan 2005 18:06:34 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: device-mapper: Add presuspend hook
Message-ID: <20050121180634.GH10195@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add optional callback before each device gets suspended (called 'presuspend').
Rename existing callback used by dm-mirror from 'suspend' to 'postsuspend'.

dm-multipath will use the new callback.

(Any kernel module using device-mapper must be recompiled after this patch.)

Signed-Off-By: Alasdair G Kergon <agk@redhat.com>
--- diff/drivers/md/dm-raid1.c	2005-01-12 15:21:22.000000000 +0000
+++ source/drivers/md/dm-raid1.c	2005-01-12 18:57:08.000000000 +0000
@@ -1158,10 +1158,11 @@
 	return 0;
 }
 
-static void mirror_suspend(struct dm_target *ti)
+static void mirror_postsuspend(struct dm_target *ti)
 {
 	struct mirror_set *ms = (struct mirror_set *) ti->private;
 	struct dirty_log *log = ms->rh.log;
+
 	rh_stop_recovery(&ms->rh);
 	if (log->type->suspend && log->type->suspend(log))
 		/* FIXME: need better error handling */
@@ -1220,7 +1221,7 @@
 	.dtr	 = mirror_dtr,
 	.map	 = mirror_map,
 	.end_io	 = mirror_end_io,
-	.suspend = mirror_suspend,
+	.postsuspend = mirror_postsuspend,
 	.resume	 = mirror_resume,
 	.status	 = mirror_status,
 };
--- diff/drivers/md/dm-table.c	2005-01-12 15:21:22.000000000 +0000
+++ source/drivers/md/dm-table.c	2005-01-12 18:57:18.000000000 +0000
@@ -849,18 +849,32 @@
 	return t->mode;
 }
 
-void dm_table_suspend_targets(struct dm_table *t)
+static void suspend_targets(struct dm_table *t, unsigned postsuspend)
 {
-	int i;
+	int i = t->num_targets;
+	struct dm_target *ti = t->targets;
 
-	for (i = 0; i < t->num_targets; i++) {
-		struct dm_target *ti = t->targets + i;
+	while (i--) {
+		if (postsuspend) {
+			if (ti->type->postsuspend)
+				ti->type->postsuspend(ti);
+		} else if (ti->type->presuspend)
+			ti->type->presuspend(ti);
 
-		if (ti->type->suspend)
-			ti->type->suspend(ti);
+		ti++;
 	}
 }
 
+void dm_table_presuspend_targets(struct dm_table *t)
+{
+	return suspend_targets(t, 0);
+}
+
+void dm_table_postsuspend_targets(struct dm_table *t)
+{
+	return suspend_targets(t, 1);
+}
+
 void dm_table_resume_targets(struct dm_table *t)
 {
 	int i;
--- diff/drivers/md/dm.c	2005-01-12 15:21:22.000000000 +0000
+++ source/drivers/md/dm.c	2005-01-12 18:57:18.000000000 +0000
@@ -919,8 +919,10 @@
 	struct dm_table *map = dm_get_table(md);
 
 	if (atomic_dec_and_test(&md->holders)) {
-		if (!test_bit(DMF_SUSPENDED, &md->flags) && map)
-			dm_table_suspend_targets(map);
+		if (!test_bit(DMF_SUSPENDED, &md->flags) && map) {
+			dm_table_presuspend_targets(map);
+			dm_table_postsuspend_targets(map);
+		}
 		__unbind(md);
 		free_dev(md);
 	}
@@ -1032,7 +1034,11 @@
 		return -EINVAL;
 	}
 
+	map = dm_get_table(md);
+	if (map)
+		dm_table_presuspend_targets(map);
 	__lock_fs(md);
+
 	up_read(&md->lock);
 
 	/*
@@ -1055,7 +1061,6 @@
 	up_write(&md->lock);
 
 	/* unplug */
-	map = dm_get_table(md);
 	if (map) {
 		dm_table_unplug_all(map);
 		dm_table_put(map);
@@ -1090,7 +1095,7 @@
 
 	map = dm_get_table(md);
 	if (map)
-		dm_table_suspend_targets(map);
+		dm_table_postsuspend_targets(map);
 	dm_table_put(map);
 	up_write(&md->lock);
 
--- diff/drivers/md/dm.h	2005-01-12 18:54:31.000000000 +0000
+++ source/drivers/md/dm.h	2005-01-12 18:57:18.000000000 +0000
@@ -115,7 +115,8 @@
 unsigned int dm_table_get_num_targets(struct dm_table *t);
 struct list_head *dm_table_get_devices(struct dm_table *t);
 int dm_table_get_mode(struct dm_table *t);
-void dm_table_suspend_targets(struct dm_table *t);
+void dm_table_presuspend_targets(struct dm_table *t);
+void dm_table_postsuspend_targets(struct dm_table *t);
 void dm_table_resume_targets(struct dm_table *t);
 int dm_table_any_congested(struct dm_table *t, int bdi_bits);
 void dm_table_unplug_all(struct dm_table *t);
--- diff/include/linux/device-mapper.h	2005-01-12 15:23:05.000000000 +0000
+++ source/include/linux/device-mapper.h	2005-01-12 18:57:08.000000000 +0000
@@ -52,7 +52,8 @@
 			    struct bio *bio, int error,
 			    union map_info *map_context);
 
-typedef void (*dm_suspend_fn) (struct dm_target *ti);
+typedef void (*dm_presuspend_fn) (struct dm_target *ti);
+typedef void (*dm_postsuspend_fn) (struct dm_target *ti);
 typedef void (*dm_resume_fn) (struct dm_target *ti);
 
 typedef int (*dm_status_fn) (struct dm_target *ti, status_type_t status_type,
@@ -82,7 +83,8 @@
 	dm_dtr_fn dtr;
 	dm_map_fn map;
 	dm_endio_fn end_io;
-	dm_suspend_fn suspend;
+	dm_presuspend_fn presuspend;
+	dm_postsuspend_fn postsuspend;
 	dm_resume_fn resume;
 	dm_status_fn status;
 	dm_message_fn message;
