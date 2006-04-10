Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbWDJXDS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbWDJXDS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 19:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbWDJXDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 19:03:18 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:57546 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S932167AbWDJXDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 19:03:18 -0400
Date: Mon, 10 Apr 2006 16:03:06 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: [git patches] ocfs2 fixes
Message-ID: <20060410230306.GC25194@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We're post rc1 so this is fixes only. The configfs ones are minor, but
small, trivial, and obvious - so I included those as well.

Please pull from 'upstream-linus' branch of
git://oss.oracle.com/home/sourcebo/git/ocfs2.git

to receive the following updates:

 fs/Kconfig                   |    2 -
 fs/configfs/dir.c            |    2 -
 fs/ocfs2/cluster/heartbeat.c |   40 ++++++++++++++++++-----
 fs/ocfs2/dlm/userdlm.c       |   74 ++++++++++++++++++++++++++++++++-----------
 fs/ocfs2/file.c              |   19 ++++++-----
 5 files changed, 101 insertions(+), 36 deletions(-)

Adrian Bunk:
      CONFIGFS_FS must depend on SYSFS

Eric Sesterhenn:
      Bogus NULL pointer check in fs/configfs/dir.c

Mark Fasheh:
      ocfs2: multi node truncate fix
      ocfs2: remove an overly aggressive BUG() in dlmfs
      ocfs2: catch an invalid ast case in dlmfs
      ocfs2: Handle the DLM_CANCELGRANT case in user_unlock_ast()
      ocfs2: test and set teardown flag early in user_dlm_destroy_lock()
      ocfs2: Better I/O error handling in heartbeat

diff --git a/fs/Kconfig b/fs/Kconfig
index e207be6..97f3174 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -861,7 +861,7 @@ config RAMFS
 
 config CONFIGFS_FS
 	tristate "Userspace-driven configuration filesystem (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
+	depends on SYSFS && EXPERIMENTAL
 	help
 	  configfs is a ram-based filesystem that provides the converse
 	  of sysfs's functionality. Where sysfs is a filesystem-based
diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 8ed9b06..5638c8f 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -504,7 +504,7 @@ static int populate_groups(struct config
 	int ret = 0;
 	int i;
 
-	if (group && group->default_groups) {
+	if (group->default_groups) {
 		/* FYI, we're faking mkdir here
 		 * I'm not sure we need this semaphore, as we're called
 		 * from our parent's mkdir.  That holds our parent's
diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index bff0f0d..21f38ac 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -153,6 +153,7 @@ struct o2hb_region {
 struct o2hb_bio_wait_ctxt {
 	atomic_t          wc_num_reqs;
 	struct completion wc_io_complete;
+	int               wc_error;
 };
 
 static void o2hb_write_timeout(void *arg)
@@ -186,6 +187,7 @@ static inline void o2hb_bio_wait_init(st
 {
 	atomic_set(&wc->wc_num_reqs, num_ios);
 	init_completion(&wc->wc_io_complete);
+	wc->wc_error = 0;
 }
 
 /* Used in error paths too */
@@ -218,8 +220,10 @@ static int o2hb_bio_end_io(struct bio *b
 {
 	struct o2hb_bio_wait_ctxt *wc = bio->bi_private;
 
-	if (error)
+	if (error) {
 		mlog(ML_ERROR, "IO Error %d\n", error);
+		wc->wc_error = error;
+	}
 
 	if (bio->bi_size)
 		return 1;
@@ -390,6 +394,8 @@ static int o2hb_read_slots(struct o2hb_r
 
 bail_and_wait:
 	o2hb_wait_on_io(reg, &wc);
+	if (wc.wc_error && !status)
+		status = wc.wc_error;
 
 	if (bios) {
 		for(i = 0; i < num_bios; i++)
@@ -790,20 +796,24 @@ static int o2hb_highest_node(unsigned lo
 	return highest;
 }
 
-static void o2hb_do_disk_heartbeat(struct o2hb_region *reg)
+static int o2hb_do_disk_heartbeat(struct o2hb_region *reg)
 {
 	int i, ret, highest_node, change = 0;
 	unsigned long configured_nodes[BITS_TO_LONGS(O2NM_MAX_NODES)];
 	struct bio *write_bio;
 	struct o2hb_bio_wait_ctxt write_wc;
 
-	if (o2nm_configured_node_map(configured_nodes, sizeof(configured_nodes)))
-		return;
+	ret = o2nm_configured_node_map(configured_nodes,
+				       sizeof(configured_nodes));
+	if (ret) {
+		mlog_errno(ret);
+		return ret;
+	}
 
 	highest_node = o2hb_highest_node(configured_nodes, O2NM_MAX_NODES);
 	if (highest_node >= O2NM_MAX_NODES) {
 		mlog(ML_NOTICE, "ocfs2_heartbeat: no configured nodes found!\n");
-		return;
+		return -EINVAL;
 	}
 
 	/* No sense in reading the slots of nodes that don't exist
@@ -813,7 +823,7 @@ static void o2hb_do_disk_heartbeat(struc
 	ret = o2hb_read_slots(reg, highest_node + 1);
 	if (ret < 0) {
 		mlog_errno(ret);
-		return;
+		return ret;
 	}
 
 	/* With an up to date view of the slots, we can check that no
@@ -831,7 +841,7 @@ static void o2hb_do_disk_heartbeat(struc
 	ret = o2hb_issue_node_write(reg, &write_bio, &write_wc);
 	if (ret < 0) {
 		mlog_errno(ret);
-		return;
+		return ret;
 	}
 
 	i = -1;
@@ -847,6 +857,15 @@ static void o2hb_do_disk_heartbeat(struc
 	 */
 	o2hb_wait_on_io(reg, &write_wc);
 	bio_put(write_bio);
+	if (write_wc.wc_error) {
+		/* Do not re-arm the write timeout on I/O error - we
+		 * can't be sure that the new block ever made it to
+		 * disk */
+		mlog(ML_ERROR, "Write error %d on device \"%s\"\n",
+		     write_wc.wc_error, reg->hr_dev_name);
+		return write_wc.wc_error;
+	}
+
 	o2hb_arm_write_timeout(reg);
 
 	/* let the person who launched us know when things are steady */
@@ -854,6 +873,8 @@ static void o2hb_do_disk_heartbeat(struc
 		if (atomic_dec_and_test(&reg->hr_steady_iterations))
 			wake_up(&o2hb_steady_queue);
 	}
+
+	return 0;
 }
 
 /* Subtract b from a, storing the result in a. a *must* have a larger
@@ -913,7 +934,10 @@ static int o2hb_thread(void *data)
 		 * likely to time itself out. */
 		do_gettimeofday(&before_hb);
 
-		o2hb_do_disk_heartbeat(reg);
+		i = 0;
+		do {
+			ret = o2hb_do_disk_heartbeat(reg);
+		} while (ret && ++i < 2);
 
 		do_gettimeofday(&after_hb);
 		elapsed_msec = o2hb_elapsed_msecs(&before_hb, &after_hb);
diff --git a/fs/ocfs2/dlm/userdlm.c b/fs/ocfs2/dlm/userdlm.c
index c3764f4..74ca4e5 100644
--- a/fs/ocfs2/dlm/userdlm.c
+++ b/fs/ocfs2/dlm/userdlm.c
@@ -139,6 +139,10 @@ static void user_ast(void *opaque)
 		return;
 	}
 
+	mlog_bug_on_msg(lockres->l_requested == LKM_IVMODE,
+			"Lockres %s, requested ivmode. flags 0x%x\n",
+			lockres->l_name, lockres->l_flags);
+
 	/* we're downconverting. */
 	if (lockres->l_requested < lockres->l_level) {
 		if (lockres->l_requested <=
@@ -229,23 +233,42 @@ static void user_unlock_ast(void *opaque
 
 	mlog(0, "UNLOCK AST called on lock %s\n", lockres->l_name);
 
-	if (status != DLM_NORMAL)
+	if (status != DLM_NORMAL && status != DLM_CANCELGRANT)
 		mlog(ML_ERROR, "Dlm returns status %d\n", status);
 
 	spin_lock(&lockres->l_lock);
-	if (lockres->l_flags & USER_LOCK_IN_TEARDOWN)
+	/* The teardown flag gets set early during the unlock process,
+	 * so test the cancel flag to make sure that this ast isn't
+	 * for a concurrent cancel. */
+	if (lockres->l_flags & USER_LOCK_IN_TEARDOWN
+	    && !(lockres->l_flags & USER_LOCK_IN_CANCEL)) {
 		lockres->l_level = LKM_IVMODE;
-	else {
+	} else if (status == DLM_CANCELGRANT) {
+		mlog(0, "Lock %s, cancel fails, flags 0x%x\n",
+		     lockres->l_name, lockres->l_flags);
+		/* We tried to cancel a convert request, but it was
+		 * already granted. Don't clear the busy flag - the
+		 * ast should've done this already. */
+		BUG_ON(!(lockres->l_flags & USER_LOCK_IN_CANCEL));
+		lockres->l_flags &= ~USER_LOCK_IN_CANCEL;
+		goto out_noclear;
+	} else {
+		BUG_ON(!(lockres->l_flags & USER_LOCK_IN_CANCEL));
+		/* Cancel succeeded, we want to re-queue */
+		mlog(0, "Lock %s, cancel succeeds, flags 0x%x\n",
+		     lockres->l_name, lockres->l_flags);
 		lockres->l_requested = LKM_IVMODE; /* cancel an
 						    * upconvert
 						    * request. */
 		lockres->l_flags &= ~USER_LOCK_IN_CANCEL;
 		/* we want the unblock thread to look at it again
 		 * now. */
-		__user_dlm_queue_lockres(lockres);
+		if (lockres->l_flags & USER_LOCK_BLOCKED)
+			__user_dlm_queue_lockres(lockres);
 	}
 
 	lockres->l_flags &= ~USER_LOCK_BUSY;
+out_noclear:
 	spin_unlock(&lockres->l_lock);
 
 	wake_up(&lockres->l_event);
@@ -268,13 +291,26 @@ static void user_dlm_unblock_lock(void *
 
 	spin_lock(&lockres->l_lock);
 
-	BUG_ON(!(lockres->l_flags & USER_LOCK_BLOCKED));
-	BUG_ON(!(lockres->l_flags & USER_LOCK_QUEUED));
+	mlog_bug_on_msg(!(lockres->l_flags & USER_LOCK_QUEUED),
+			"Lockres %s, flags 0x%x\n",
+			lockres->l_name, lockres->l_flags);
 
-	/* notice that we don't clear USER_LOCK_BLOCKED here. That's
-	 * for user_ast to do. */
+	/* notice that we don't clear USER_LOCK_BLOCKED here. If it's
+	 * set, we want user_ast clear it. */
 	lockres->l_flags &= ~USER_LOCK_QUEUED;
 
+	/* It's valid to get here and no longer be blocked - if we get
+	 * several basts in a row, we might be queued by the first
+	 * one, the unblock thread might run and clear the queued
+	 * flag, and finally we might get another bast which re-queues
+	 * us before our ast for the downconvert is called. */
+	if (!(lockres->l_flags & USER_LOCK_BLOCKED)) {
+		mlog(0, "Lockres %s, flags 0x%x: queued but not blocking\n",
+			lockres->l_name, lockres->l_flags);
+		spin_unlock(&lockres->l_lock);
+		goto drop_ref;
+	}
+
 	if (lockres->l_flags & USER_LOCK_IN_TEARDOWN) {
 		mlog(0, "lock is in teardown so we do nothing\n");
 		spin_unlock(&lockres->l_lock);
@@ -282,7 +318,9 @@ static void user_dlm_unblock_lock(void *
 	}
 
 	if (lockres->l_flags & USER_LOCK_BUSY) {
-		mlog(0, "BUSY flag detected...\n");
+		mlog(0, "Cancel lock %s, flags 0x%x\n",
+		     lockres->l_name, lockres->l_flags);
+
 		if (lockres->l_flags & USER_LOCK_IN_CANCEL) {
 			spin_unlock(&lockres->l_lock);
 			goto drop_ref;
@@ -296,14 +334,7 @@ static void user_dlm_unblock_lock(void *
 				   LKM_CANCEL,
 				   user_unlock_ast,
 				   lockres);
-		if (status == DLM_CANCELGRANT) {
-			/* If we got this, then the ast was fired
-			 * before we could cancel. We cleanup our
-			 * state, and restart the function. */
-			spin_lock(&lockres->l_lock);
-			lockres->l_flags &= ~USER_LOCK_IN_CANCEL;
-			spin_unlock(&lockres->l_lock);
-		} else if (status != DLM_NORMAL)
+		if (status != DLM_NORMAL)
 			user_log_dlm_error("dlmunlock", status, lockres);
 		goto drop_ref;
 	}
@@ -581,6 +612,14 @@ int user_dlm_destroy_lock(struct user_lo
 	mlog(0, "asked to destroy %s\n", lockres->l_name);
 
 	spin_lock(&lockres->l_lock);
+	if (lockres->l_flags & USER_LOCK_IN_TEARDOWN) {
+		mlog(0, "Lock is already torn down\n");
+		spin_unlock(&lockres->l_lock);
+		return 0;
+	}
+
+	lockres->l_flags |= USER_LOCK_IN_TEARDOWN;
+
 	while (lockres->l_flags & USER_LOCK_BUSY) {
 		spin_unlock(&lockres->l_lock);
 
@@ -606,7 +645,6 @@ int user_dlm_destroy_lock(struct user_lo
 
 	lockres->l_flags &= ~USER_LOCK_ATTACHED;
 	lockres->l_flags |= USER_LOCK_BUSY;
-	lockres->l_flags |= USER_LOCK_IN_TEARDOWN;
 	spin_unlock(&lockres->l_lock);
 
 	mlog(0, "unlocking lockres %s\n", lockres->l_name);
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index 34e903a..581eb45 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -260,6 +260,17 @@ static int ocfs2_truncate_file(struct in
 	if (new_i_size == le64_to_cpu(fe->i_size))
 		goto bail;
 
+	/* This forces other nodes to sync and drop their pages. Do
+	 * this even if we have a truncate without allocation change -
+	 * ocfs2 cluster sizes can be much greater than page size, so
+	 * we have to truncate them anyway.  */
+	status = ocfs2_data_lock(inode, 1);
+	if (status < 0) {
+		mlog_errno(status);
+		goto bail;
+	}
+	ocfs2_data_unlock(inode, 1);
+
 	if (le32_to_cpu(fe->i_clusters) ==
 	    ocfs2_clusters_for_bytes(osb->sb, new_i_size)) {
 		mlog(0, "fe->i_clusters = %u, so we do a simple truncate\n",
@@ -272,14 +283,6 @@ static int ocfs2_truncate_file(struct in
 		goto bail;
 	}
 
-	/* This forces other nodes to sync and drop their pages */
-	status = ocfs2_data_lock(inode, 1);
-	if (status < 0) {
-		mlog_errno(status);
-		goto bail;
-	}
-	ocfs2_data_unlock(inode, 1);
-
 	/* alright, we're going to need to do a full blown alloc size
 	 * change. Orphan the inode so that recovery can complete the
 	 * truncate if necessary. This does the task of marking
