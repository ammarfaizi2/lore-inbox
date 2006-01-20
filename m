Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932198AbWATVLf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbWATVLf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 16:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbWATVLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 16:11:35 -0500
Received: from mx1.redhat.com ([66.187.233.31]:24027 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932198AbWATVLe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 16:11:34 -0500
Date: Fri, 20 Jan 2006 21:11:16 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] device-mapper snapshot: load metadata on creation
Message-ID: <20060120211116.GB4724@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move snapshot metadata loading to happen when the table is created 
instead of when the device is resumed.  Writes to the origin device
don't trigger exceptions until each snapshot table becomes active 
when resume() is called on each snapshot.

If you're using lvm2, for this patch to work properly you should update 
to lvm2 version 2.02.01 or later and device-mapper version 1.02.02 or later.

Signed-Off-By: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.16-rc1/drivers/md/dm-snap.c
===================================================================
--- linux-2.6.16-rc1.orig/drivers/md/dm-snap.c
+++ linux-2.6.16-rc1/drivers/md/dm-snap.c
@@ -373,16 +373,11 @@ static inline ulong round_up(ulong n, ul
 
 static void read_snapshot_metadata(struct dm_snapshot *s)
 {
-	if (s->have_metadata)
-		return;
-
 	if (s->store.read_metadata(&s->store)) {
 		down_write(&s->lock);
 		s->valid = 0;
 		up_write(&s->lock);
 	}
-
-	s->have_metadata = 1;
 }
 
 /*
@@ -471,7 +466,7 @@ static int snapshot_ctr(struct dm_target
 	s->chunk_shift = ffs(chunk_size) - 1;
 
 	s->valid = 1;
-	s->have_metadata = 0;
+	s->active = 0;
 	s->last_percent = 0;
 	init_rwsem(&s->lock);
 	s->table = ti->table;
@@ -506,7 +501,11 @@ static int snapshot_ctr(struct dm_target
 		goto bad5;
 	}
 
+	/* Metadata must only be loaded into one table at once */
+	read_snapshot_metadata(s);
+
 	/* Add snapshot to the list of snapshots for this origin */
+	/* Exceptions aren't triggered till snapshot_resume() is called */
 	if (register_snapshot(s)) {
 		r = -EINVAL;
 		ti->error = "Cannot register snapshot origin";
@@ -862,7 +861,9 @@ static void snapshot_resume(struct dm_ta
 {
 	struct dm_snapshot *s = (struct dm_snapshot *) ti->private;
 
-	read_snapshot_metadata(s);
+	down_write(&s->lock);
+	s->active = 1;
+	up_write(&s->lock);
 }
 
 static int snapshot_status(struct dm_target *ti, status_type_t type,
@@ -932,8 +933,8 @@ static int __origin_write(struct list_he
 	/* Do all the snapshots on this origin */
 	list_for_each_entry (snap, snapshots, list) {
 
-		/* Only deal with valid snapshots */
-		if (!snap->valid)
+		/* Only deal with valid and active snapshots */
+		if (!snap->valid || !snap->active)
 			continue;
 
 		/* Nothing to do if writing beyond end of snapshot */
@@ -1104,7 +1105,7 @@ static int origin_status(struct dm_targe
 
 static struct target_type origin_target = {
 	.name    = "snapshot-origin",
-	.version = {1, 0, 1},
+	.version = {1, 1, 0},
 	.module  = THIS_MODULE,
 	.ctr     = origin_ctr,
 	.dtr     = origin_dtr,
@@ -1115,7 +1116,7 @@ static struct target_type origin_target 
 
 static struct target_type snapshot_target = {
 	.name    = "snapshot",
-	.version = {1, 0, 1},
+	.version = {1, 1, 0},
 	.module  = THIS_MODULE,
 	.ctr     = snapshot_ctr,
 	.dtr     = snapshot_dtr,
Index: linux-2.6.16-rc1/drivers/md/dm-snap.h
===================================================================
--- linux-2.6.16-rc1.orig/drivers/md/dm-snap.h
+++ linux-2.6.16-rc1/drivers/md/dm-snap.h
@@ -99,7 +99,9 @@ struct dm_snapshot {
 
 	/* You can't use a snapshot if this is 0 (e.g. if full) */
 	int valid;
-	int have_metadata;
+
+	/* Origin writes don't trigger exceptions until this is set */
+	int active;
 
 	/* Used for display of table */
 	char type;
