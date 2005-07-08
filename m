Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262785AbVGHTlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262785AbVGHTlF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 15:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262811AbVGHTis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 15:38:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:25777 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262785AbVGHTg3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 15:36:29 -0400
Date: Fri, 8 Jul 2005 20:36:10 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Lars Marowsky-Bree <lmb@suse.de>,
       "goggin, edward" <egoggin@emc.com>
Subject: [PATCH] device-mapper multipath: Avoid possible suspension deadlock
Message-ID: <20050708193610.GF12355@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Lars Marowsky-Bree <lmb@suse.de>,
	"goggin, edward" <egoggin@emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid deadlock when suspending a multipath device after all its
paths have failed, stop queueing any I/O that is about to fail *before*
calling freeze_bdev instead of after.
 
Instead of setting a multipath 'suspended' flag which would have to be reset 
if an error occurs during the process, save the previous queueing state 
and leave userspace to restore if it wishes.

Signed-Off-By: Alasdair G Kergon <agk@redhat.com>

--- diff/drivers/md/dm-mpath.c	2005-07-08 19:21:18.000000000 +0100
+++ source/drivers/md/dm-mpath.c	2005-07-08 19:21:37.000000000 +0100
@@ -72,7 +72,7 @@
 
 	unsigned queue_io;		/* Must we queue all I/O? */
 	unsigned queue_if_no_path;	/* Queue I/O if last path fails? */
-	unsigned suspended;		/* Has dm core suspended our I/O? */
+	unsigned saved_queue_if_no_path;/* Saved state during suspension */
 
 	struct work_struct process_queued_ios;
 	struct bio_list queued_ios;
@@ -304,7 +304,7 @@
 		m->queue_size--;
 
 	if ((pgpath && m->queue_io) ||
-	    (!pgpath && m->queue_if_no_path && !m->suspended)) {
+	    (!pgpath && m->queue_if_no_path)) {
 		/* Queue for the daemon to resubmit */
 		bio_list_add(&m->queued_ios, bio);
 		m->queue_size++;
@@ -333,6 +333,7 @@
 
 	spin_lock_irqsave(&m->lock, flags);
 
+	m->saved_queue_if_no_path = m->queue_if_no_path;
 	m->queue_if_no_path = queue_if_no_path;
 	if (!m->queue_if_no_path)
 		queue_work(kmultipathd, &m->process_queued_ios);
@@ -391,7 +392,7 @@
 	pgpath = m->current_pgpath;
 
 	if ((pgpath && m->queue_io) ||
-	    (!pgpath && m->queue_if_no_path && !m->suspended))
+	    (!pgpath && m->queue_if_no_path))
 		must_queue = 1;
 
 	init_required = m->pg_init_required;
@@ -998,7 +999,7 @@
 
 	spin_lock(&m->lock);
 	if (!m->nr_valid_paths) {
-		if (!m->queue_if_no_path || m->suspended) {
+		if (!m->queue_if_no_path) {
 			spin_unlock(&m->lock);
 			return -EIO;
 		} else {
@@ -1059,27 +1060,27 @@
 
 /*
  * Suspend can't complete until all the I/O is processed so if
- * the last path failed we will now error any queued I/O.
+ * the last path fails we must error any remaining I/O.
+ * Note that if the freeze_bdev fails while suspending, the 
+ * queue_if_no_path state is lost - userspace should reset it.
  */
 static void multipath_presuspend(struct dm_target *ti)
 {
 	struct multipath *m = (struct multipath *) ti->private;
-	unsigned long flags;
 
-	spin_lock_irqsave(&m->lock, flags);
-	m->suspended = 1;
-	if (m->queue_if_no_path)
-		queue_work(kmultipathd, &m->process_queued_ios);
-	spin_unlock_irqrestore(&m->lock, flags);
+	queue_if_no_path(m, 0);
 }
 
+/*
+ * Restore the queue_if_no_path setting.
+ */
 static void multipath_resume(struct dm_target *ti)
 {
 	struct multipath *m = (struct multipath *) ti->private;
 	unsigned long flags;
 
 	spin_lock_irqsave(&m->lock, flags);
-	m->suspended = 0;
+	m->queue_if_no_path = m->saved_queue_if_no_path;
 	spin_unlock_irqrestore(&m->lock, flags);
 }
 
--- diff/drivers/md/dm.c	2005-07-08 19:01:41.000000000 +0100
+++ source/drivers/md/dm.c	2005-07-08 19:21:37.000000000 +0100
@@ -1055,14 +1055,17 @@
 	if (test_bit(DMF_BLOCK_IO, &md->flags))
 		goto out_read_unlock;
 
-	error = __lock_fs(md);
-	if (error)
-		goto out_read_unlock;
-
 	map = dm_get_table(md);
 	if (map)
+		/* This does not get reverted if there's an error later. */
 		dm_table_presuspend_targets(map);
 
+	error = __lock_fs(md);
+	if (error) {
+		dm_table_put(map);
+		goto out_read_unlock;
+	}
+
 	up_read(&md->lock);
 
 	/*
@@ -1121,7 +1124,6 @@
 	return 0;
 
 out_unfreeze:
-	/* FIXME Undo dm_table_presuspend_targets */
 	__unlock_fs(md);
 	clear_bit(DMF_BLOCK_IO, &md->flags);
 out_write_unlock:
