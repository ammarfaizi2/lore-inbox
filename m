Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422717AbWATBho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422717AbWATBho (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 20:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422718AbWATBho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 20:37:44 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:47582 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1422717AbWATBhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 20:37:43 -0500
Date: Thu, 19 Jan 2006 17:37:21 -0800
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: [git patches] ocfs2 updates
Message-ID: <20060120013721.GC10537@ca-server1.us.oracle.com>
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

Please pull from 'upstream-linus' branch of
git://oss.oracle.com/home/sourcebo/git/ocfs2.git

to receive the following updates:

 Documentation/filesystems/ocfs2.txt |    1 
 fs/Kconfig                          |    2 
 fs/ocfs2/buffer_head_io.c           |   10 -
 fs/ocfs2/dlm/dlmcommon.h            |    1 
 fs/ocfs2/dlm/dlmdomain.c            |   18 ++
 fs/ocfs2/dlm/dlmmaster.c            |   24 +--
 fs/ocfs2/dlm/dlmrecovery.c          |  250 ++++++++++++++++++++++++++++++------
 fs/ocfs2/dlm/dlmunlock.c            |   13 +
 fs/ocfs2/dlm/userdlm.c              |    2 
 fs/ocfs2/extent_map.c               |    2 
 fs/ocfs2/inode.c                    |    6 
 fs/ocfs2/inode.h                    |    4 
 fs/ocfs2/journal.c                  |   14 +-
 fs/ocfs2/ocfs2.h                    |    3 
 fs/ocfs2/super.c                    |    8 -
 fs/ocfs2/uptodate.c                 |   12 -
 fs/ocfs2/uptodate.h                 |    2 
 17 files changed, 290 insertions(+), 82 deletions(-)

Adrian Bunk:
      OCFS2: __init / __exit problem
      fs/ocfs2/dlm/dlmrecovery.c must #include <linux/delay.h>

Arjan van de Ven:
      ocfs2: Semaphore to mutex conversion.

J. Bruce Fields:
      [OCFS2] Documentation Fix

Jeff Mahoney:
      ocfs2/dlm: fix compilation on ia64

Joel Becker:
      o Remove confusing Kconfig text for CONFIGFS_FS.

Kurt Hackel:
      ocfs2/dlm: fixes

Mark Fasheh:
      [OCFS2] Make ip_io_sem a mutex

diff --git a/Documentation/filesystems/ocfs2.txt b/Documentation/filesystems/ocfs2.txt
index f2595ca..4389c68 100644
--- a/Documentation/filesystems/ocfs2.txt
+++ b/Documentation/filesystems/ocfs2.txt
@@ -35,6 +35,7 @@ Features which OCFS2 does not support ye
 	  be cluster coherent.
 	- quotas
 	- cluster aware flock
+	- cluster aware lockf
 	- Directory change notification (F_NOTIFY)
 	- Distributed Caching (F_SETLEASE/F_GETLEASE/break_lease)
 	- POSIX ACLs
diff --git a/fs/Kconfig b/fs/Kconfig
index ef78e3a..a732bea 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -883,8 +883,6 @@ config CONFIGFS_FS
 	  Both sysfs and configfs can and should exist together on the
 	  same system. One is not a replacement for the other.
 
-	  If unsure, say N.
-
 endmenu
 
 menu "Miscellaneous filesystems"
diff --git a/fs/ocfs2/buffer_head_io.c b/fs/ocfs2/buffer_head_io.c
index d424041..bae3d75 100644
--- a/fs/ocfs2/buffer_head_io.c
+++ b/fs/ocfs2/buffer_head_io.c
@@ -58,7 +58,7 @@ int ocfs2_write_block(struct ocfs2_super
 		goto out;
 	}
 
-	down(&OCFS2_I(inode)->ip_io_sem);
+	mutex_lock(&OCFS2_I(inode)->ip_io_mutex);
 
 	lock_buffer(bh);
 	set_buffer_uptodate(bh);
@@ -82,7 +82,7 @@ int ocfs2_write_block(struct ocfs2_super
 		brelse(bh);
 	}
 
-	up(&OCFS2_I(inode)->ip_io_sem);
+	mutex_unlock(&OCFS2_I(inode)->ip_io_mutex);
 out:
 	mlog_exit(ret);
 	return ret;
@@ -125,13 +125,13 @@ int ocfs2_read_blocks(struct ocfs2_super
 		flags &= ~OCFS2_BH_CACHED;
 
 	if (inode)
-		down(&OCFS2_I(inode)->ip_io_sem);
+		mutex_lock(&OCFS2_I(inode)->ip_io_mutex);
 	for (i = 0 ; i < nr ; i++) {
 		if (bhs[i] == NULL) {
 			bhs[i] = sb_getblk(sb, block++);
 			if (bhs[i] == NULL) {
 				if (inode)
-					up(&OCFS2_I(inode)->ip_io_sem);
+					mutex_unlock(&OCFS2_I(inode)->ip_io_mutex);
 				status = -EIO;
 				mlog_errno(status);
 				goto bail;
@@ -220,7 +220,7 @@ int ocfs2_read_blocks(struct ocfs2_super
 			ocfs2_set_buffer_uptodate(inode, bh);
 	}
 	if (inode)
-		up(&OCFS2_I(inode)->ip_io_sem);
+		mutex_unlock(&OCFS2_I(inode)->ip_io_mutex);
 
 	mlog(ML_BH_IO, "block=(%"MLFu64"), nr=(%d), cached=%s\n", block, nr,
 	     (!(flags & OCFS2_BH_CACHED) || ignore_cache) ? "no" : "yes");
diff --git a/fs/ocfs2/dlm/dlmcommon.h b/fs/ocfs2/dlm/dlmcommon.h
index 3fecba0..42eb53b 100644
--- a/fs/ocfs2/dlm/dlmcommon.h
+++ b/fs/ocfs2/dlm/dlmcommon.h
@@ -657,6 +657,7 @@ void dlm_complete_thread(struct dlm_ctxt
 int dlm_launch_recovery_thread(struct dlm_ctxt *dlm);
 void dlm_complete_recovery_thread(struct dlm_ctxt *dlm);
 void dlm_wait_for_recovery(struct dlm_ctxt *dlm);
+int dlm_is_node_dead(struct dlm_ctxt *dlm, u8 node);
 
 void dlm_put(struct dlm_ctxt *dlm);
 struct dlm_ctxt *dlm_grab(struct dlm_ctxt *dlm);
diff --git a/fs/ocfs2/dlm/dlmdomain.c b/fs/ocfs2/dlm/dlmdomain.c
index da3c220..6ee3083 100644
--- a/fs/ocfs2/dlm/dlmdomain.c
+++ b/fs/ocfs2/dlm/dlmdomain.c
@@ -573,8 +573,11 @@ static int dlm_query_join_handler(struct
 	spin_lock(&dlm_domain_lock);
 	dlm = __dlm_lookup_domain_full(query->domain, query->name_len);
 	/* Once the dlm ctxt is marked as leaving then we don't want
-	 * to be put in someone's domain map. */
+	 * to be put in someone's domain map. 
+	 * Also, explicitly disallow joining at certain troublesome
+	 * times (ie. during recovery). */
 	if (dlm && dlm->dlm_state != DLM_CTXT_LEAVING) {
+		int bit = query->node_idx;
 		spin_lock(&dlm->spinlock);
 
 		if (dlm->dlm_state == DLM_CTXT_NEW &&
@@ -586,6 +589,19 @@ static int dlm_query_join_handler(struct
 		} else if (dlm->joining_node != DLM_LOCK_RES_OWNER_UNKNOWN) {
 			/* Disallow parallel joins. */
 			response = JOIN_DISALLOW;
+		} else if (dlm->reco.state & DLM_RECO_STATE_ACTIVE) {
+			mlog(ML_NOTICE, "node %u trying to join, but recovery "
+			     "is ongoing.\n", bit);
+			response = JOIN_DISALLOW;
+		} else if (test_bit(bit, dlm->recovery_map)) {
+			mlog(ML_NOTICE, "node %u trying to join, but it "
+			     "still needs recovery.\n", bit);
+			response = JOIN_DISALLOW;
+		} else if (test_bit(bit, dlm->domain_map)) {
+			mlog(ML_NOTICE, "node %u trying to join, but it "
+			     "is still in the domain! needs recovery?\n",
+			     bit);
+			response = JOIN_DISALLOW;
 		} else {
 			/* Alright we're fully a part of this domain
 			 * so we keep some state as to who's joining
diff --git a/fs/ocfs2/dlm/dlmmaster.c b/fs/ocfs2/dlm/dlmmaster.c
index 27e984f..a3194fe 100644
--- a/fs/ocfs2/dlm/dlmmaster.c
+++ b/fs/ocfs2/dlm/dlmmaster.c
@@ -1050,17 +1050,10 @@ static int dlm_restart_lock_mastery(stru
 	node = dlm_bitmap_diff_iter_next(&bdi, &sc);
 	while (node >= 0) {
 		if (sc == NODE_UP) {
-			/* a node came up.  easy.  might not even need
-			 * to talk to it if its node number is higher
-			 * or if we are already blocked. */
-			mlog(0, "node up! %d\n", node);
-			if (blocked)
-				goto next;
-
-			if (node > dlm->node_num) {
-				mlog(0, "node > this node. skipping.\n");
-				goto next;
-			}
+			/* a node came up.  clear any old vote from
+			 * the response map and set it in the vote map
+			 * then restart the mastery. */
+			mlog(ML_NOTICE, "node %d up while restarting\n", node);
 
 			/* redo the master request, but only for the new node */
 			mlog(0, "sending request to new node\n");
@@ -2005,6 +1998,15 @@ fail:
 				break;
 
 			mlog(0, "timed out during migration\n");
+			/* avoid hang during shutdown when migrating lockres 
+			 * to a node which also goes down */
+			if (dlm_is_node_dead(dlm, target)) {
+				mlog(0, "%s:%.*s: expected migration target %u "
+				     "is no longer up.  restarting.\n",
+				     dlm->name, res->lockname.len,
+				     res->lockname.name, target);
+				ret = -ERESTARTSYS;
+			}
 		}
 		if (ret == -ERESTARTSYS) {
 			/* migration failed, detach and clean up mle */
diff --git a/fs/ocfs2/dlm/dlmrecovery.c b/fs/ocfs2/dlm/dlmrecovery.c
index 0c8eb10..186e9a7 100644
--- a/fs/ocfs2/dlm/dlmrecovery.c
+++ b/fs/ocfs2/dlm/dlmrecovery.c
@@ -39,6 +39,7 @@
 #include <linux/inet.h>
 #include <linux/timer.h>
 #include <linux/kthread.h>
+#include <linux/delay.h>
 
 
 #include "cluster/heartbeat.h"
@@ -256,6 +257,27 @@ static int dlm_recovery_thread(void *dat
 	return 0;
 }
 
+/* returns true when the recovery master has contacted us */
+static int dlm_reco_master_ready(struct dlm_ctxt *dlm)
+{
+	int ready;
+	spin_lock(&dlm->spinlock);
+	ready = (dlm->reco.new_master != O2NM_INVALID_NODE_NUM);
+	spin_unlock(&dlm->spinlock);
+	return ready;
+}
+
+/* returns true if node is no longer in the domain
+ * could be dead or just not joined */
+int dlm_is_node_dead(struct dlm_ctxt *dlm, u8 node)
+{
+	int dead;
+	spin_lock(&dlm->spinlock);
+	dead = test_bit(node, dlm->domain_map);
+	spin_unlock(&dlm->spinlock);
+	return dead;
+}
+
 /* callers of the top-level api calls (dlmlock/dlmunlock) should
  * block on the dlm->reco.event when recovery is in progress.
  * the dlm recovery thread will set this state when it begins
@@ -297,6 +319,7 @@ static void dlm_end_recovery(struct dlm_
 static int dlm_do_recovery(struct dlm_ctxt *dlm)
 {
 	int status = 0;
+	int ret;
 
 	spin_lock(&dlm->spinlock);
 
@@ -343,10 +366,13 @@ static int dlm_do_recovery(struct dlm_ct
 		goto master_here;
 
 	if (dlm->reco.new_master == O2NM_INVALID_NODE_NUM) {
-		/* choose a new master */
-		if (!dlm_pick_recovery_master(dlm)) {
+		/* choose a new master, returns 0 if this node
+		 * is the master, -EEXIST if it's another node.
+		 * this does not return until a new master is chosen
+		 * or recovery completes entirely. */
+		ret = dlm_pick_recovery_master(dlm);
+		if (!ret) {
 			/* already notified everyone.  go. */
-			dlm->reco.new_master = dlm->node_num;
 			goto master_here;
 		}
 		mlog(0, "another node will master this recovery session.\n");
@@ -371,8 +397,13 @@ master_here:
 	if (status < 0) {
 		mlog(ML_ERROR, "error %d remastering locks for node %u, "
 		     "retrying.\n", status, dlm->reco.dead_node);
+		/* yield a bit to allow any final network messages
+		 * to get handled on remaining nodes */
+		msleep(100);
 	} else {
 		/* success!  see if any other nodes need recovery */
+		mlog(0, "DONE mastering recovery of %s:%u here(this=%u)!\n",
+		     dlm->name, dlm->reco.dead_node, dlm->node_num);
 		dlm_reset_recovery(dlm);
 	}
 	dlm_end_recovery(dlm);
@@ -477,7 +508,7 @@ static int dlm_remaster_locks(struct dlm
 					BUG();
 					break;
 				case DLM_RECO_NODE_DATA_DEAD:
-					mlog(0, "node %u died after "
+					mlog(ML_NOTICE, "node %u died after "
 					     "requesting recovery info for "
 					     "node %u\n", ndata->node_num,
 					     dead_node);
@@ -485,6 +516,19 @@ static int dlm_remaster_locks(struct dlm
 					// start all over
 					destroy = 1;
 					status = -EAGAIN;
+					/* instead of spinning like crazy here,
+					 * wait for the domain map to catch up
+					 * with the network state.  otherwise this
+					 * can be hit hundreds of times before
+					 * the node is really seen as dead. */
+					wait_event_timeout(dlm->dlm_reco_thread_wq,
+							   dlm_is_node_dead(dlm,
+								ndata->node_num),
+							   msecs_to_jiffies(1000));
+					mlog(0, "waited 1 sec for %u, "
+					     "dead? %s\n", ndata->node_num,
+					     dlm_is_node_dead(dlm, ndata->node_num) ?
+					     "yes" : "no");
 					goto leave;
 				case DLM_RECO_NODE_DATA_RECEIVING:
 				case DLM_RECO_NODE_DATA_REQUESTED:
@@ -678,11 +722,27 @@ static void dlm_request_all_locks_worker
 	dlm = item->dlm;
 	dead_node = item->u.ral.dead_node;
 	reco_master = item->u.ral.reco_master;
+	mres = (struct dlm_migratable_lockres *)data;
+
+	if (dead_node != dlm->reco.dead_node ||
+	    reco_master != dlm->reco.new_master) {
+		/* show extra debug info if the recovery state is messed */
+		mlog(ML_ERROR, "%s: bad reco state: reco(dead=%u, master=%u), "
+		     "request(dead=%u, master=%u)\n",
+		     dlm->name, dlm->reco.dead_node, dlm->reco.new_master,
+		     dead_node, reco_master);
+		mlog(ML_ERROR, "%s: name=%.*s master=%u locks=%u/%u flags=%u "
+		     "entry[0]={c=%"MLFu64",l=%u,f=%u,t=%d,ct=%d,hb=%d,n=%u}\n",
+		     dlm->name, mres->lockname_len, mres->lockname, mres->master,
+		     mres->num_locks, mres->total_locks, mres->flags,
+		     mres->ml[0].cookie, mres->ml[0].list, mres->ml[0].flags,
+		     mres->ml[0].type, mres->ml[0].convert_type,
+		     mres->ml[0].highest_blocked, mres->ml[0].node);
+		BUG();
+	}
 	BUG_ON(dead_node != dlm->reco.dead_node);
 	BUG_ON(reco_master != dlm->reco.new_master);
 
-	mres = (struct dlm_migratable_lockres *)data;
-
 	/* lock resources should have already been moved to the
  	 * dlm->reco.resources list.  now move items from that list
  	 * to a temp list if the dead owner matches.  note that the
@@ -757,15 +817,18 @@ int dlm_reco_data_done_handler(struct o2
 			continue;
 
 		switch (ndata->state) {
+			/* should have moved beyond INIT but not to FINALIZE yet */
 			case DLM_RECO_NODE_DATA_INIT:
 			case DLM_RECO_NODE_DATA_DEAD:
-			case DLM_RECO_NODE_DATA_DONE:
 			case DLM_RECO_NODE_DATA_FINALIZE_SENT:
 				mlog(ML_ERROR, "bad ndata state for node %u:"
 				     " state=%d\n", ndata->node_num,
 				     ndata->state);
 				BUG();
 				break;
+			/* these states are possible at this point, anywhere along
+			 * the line of recovery */
+			case DLM_RECO_NODE_DATA_DONE:
 			case DLM_RECO_NODE_DATA_RECEIVING:
 			case DLM_RECO_NODE_DATA_REQUESTED:
 			case DLM_RECO_NODE_DATA_REQUESTING:
@@ -799,13 +862,31 @@ static void dlm_move_reco_locks_to_list(
 {
 	struct dlm_lock_resource *res;
 	struct list_head *iter, *iter2;
+	struct dlm_lock *lock;
 
 	spin_lock(&dlm->spinlock);
 	list_for_each_safe(iter, iter2, &dlm->reco.resources) {
 		res = list_entry (iter, struct dlm_lock_resource, recovering);
+		/* always prune any $RECOVERY entries for dead nodes,
+		 * otherwise hangs can occur during later recovery */
 		if (dlm_is_recovery_lock(res->lockname.name,
-					 res->lockname.len))
+					 res->lockname.len)) {
+			spin_lock(&res->spinlock);
+			list_for_each_entry(lock, &res->granted, list) {
+				if (lock->ml.node == dead_node) {
+					mlog(0, "AHA! there was "
+					     "a $RECOVERY lock for dead "
+					     "node %u (%s)!\n", 
+					     dead_node, dlm->name);
+					list_del_init(&lock->list);
+					dlm_lock_put(lock);
+					break;
+				}
+			}
+			spin_unlock(&res->spinlock);
 			continue;
+		}
+
 		if (res->owner == dead_node) {
 			mlog(0, "found lockres owned by dead node while "
 				  "doing recovery for node %u. sending it.\n",
@@ -1179,7 +1260,7 @@ static void dlm_mig_lockres_worker(struc
 again:
 		ret = dlm_lockres_master_requery(dlm, res, &real_master);
 		if (ret < 0) {
-			mlog(0, "dlm_lockres_master_requery failure: %d\n",
+			mlog(0, "dlm_lockres_master_requery ret=%d\n",
 				  ret);
 			goto again;
 		}
@@ -1757,6 +1838,7 @@ static void dlm_do_local_recovery_cleanu
 	struct dlm_lock_resource *res;
 	int i;
 	struct list_head *bucket;
+	struct dlm_lock *lock;
 
 
 	/* purge any stale mles */
@@ -1780,10 +1862,25 @@ static void dlm_do_local_recovery_cleanu
 		bucket = &(dlm->resources[i]);
 		list_for_each(iter, bucket) {
 			res = list_entry (iter, struct dlm_lock_resource, list);
+ 			/* always prune any $RECOVERY entries for dead nodes,
+ 			 * otherwise hangs can occur during later recovery */
 			if (dlm_is_recovery_lock(res->lockname.name,
-						 res->lockname.len))
+						 res->lockname.len)) {
+				spin_lock(&res->spinlock);
+				list_for_each_entry(lock, &res->granted, list) {
+					if (lock->ml.node == dead_node) {
+						mlog(0, "AHA! there was "
+						     "a $RECOVERY lock for dead "
+						     "node %u (%s)!\n",
+						     dead_node, dlm->name);
+						list_del_init(&lock->list);
+						dlm_lock_put(lock);
+						break;
+					}
+				}
+				spin_unlock(&res->spinlock);
 				continue;
-			
+			}			
 			spin_lock(&res->spinlock);
 			/* zero the lvb if necessary */
 			dlm_revalidate_lvb(dlm, res, dead_node);
@@ -1869,12 +1966,9 @@ void dlm_hb_node_up_cb(struct o2nm_node 
 		return;
 
 	spin_lock(&dlm->spinlock);
-
 	set_bit(idx, dlm->live_nodes_map);
-
-	/* notify any mles attached to the heartbeat events */
-	dlm_hb_event_notify_attached(dlm, idx, 1);
-
+	/* do NOT notify mle attached to the heartbeat events.
+	 * new nodes are not interesting in mastery until joined. */
 	spin_unlock(&dlm->spinlock);
 
 	dlm_put(dlm);
@@ -1897,7 +1991,18 @@ static void dlm_reco_unlock_ast(void *as
 	mlog(0, "unlockast for recovery lock fired!\n");
 }
 
-
+/*
+ * dlm_pick_recovery_master will continually attempt to use
+ * dlmlock() on the special "$RECOVERY" lockres with the
+ * LKM_NOQUEUE flag to get an EX.  every thread that enters
+ * this function on each node racing to become the recovery
+ * master will not stop attempting this until either:
+ * a) this node gets the EX (and becomes the recovery master),
+ * or b) dlm->reco.new_master gets set to some nodenum 
+ * != O2NM_INVALID_NODE_NUM (another node will do the reco).
+ * so each time a recovery master is needed, the entire cluster
+ * will sync at this point.  if the new master dies, that will
+ * be detected in dlm_do_recovery */
 static int dlm_pick_recovery_master(struct dlm_ctxt *dlm)
 {
 	enum dlm_status ret;
@@ -1906,23 +2011,45 @@ static int dlm_pick_recovery_master(stru
 
 	mlog(0, "starting recovery of %s at %lu, dead=%u, this=%u\n",
 	     dlm->name, jiffies, dlm->reco.dead_node, dlm->node_num);
-retry:
+again:	
 	memset(&lksb, 0, sizeof(lksb));
 
 	ret = dlmlock(dlm, LKM_EXMODE, &lksb, LKM_NOQUEUE|LKM_RECOVERY,
 		      DLM_RECOVERY_LOCK_NAME, dlm_reco_ast, dlm, dlm_reco_bast);
 
+	mlog(0, "%s: dlmlock($RECOVERY) returned %d, lksb=%d\n",
+	     dlm->name, ret, lksb.status);
+
 	if (ret == DLM_NORMAL) {
 		mlog(0, "dlm=%s dlmlock says I got it (this=%u)\n",
 		     dlm->name, dlm->node_num);
-		/* I am master, send message to all nodes saying
-		 * that I am beginning a recovery session */
-		status = dlm_send_begin_reco_message(dlm,
-					      dlm->reco.dead_node);
+		
+		/* got the EX lock.  check to see if another node 
+		 * just became the reco master */
+		if (dlm_reco_master_ready(dlm)) {
+			mlog(0, "%s: got reco EX lock, but %u will "
+			     "do the recovery\n", dlm->name,
+			     dlm->reco.new_master);
+			status = -EEXIST;
+		} else {
+			status = dlm_send_begin_reco_message(dlm,
+				      dlm->reco.dead_node);
+			/* this always succeeds */
+			BUG_ON(status);
+
+			/* set the new_master to this node */
+			spin_lock(&dlm->spinlock);
+			dlm->reco.new_master = dlm->node_num;
+			spin_unlock(&dlm->spinlock);
+		}
 
 		/* recovery lock is a special case.  ast will not get fired,
 		 * so just go ahead and unlock it. */
 		ret = dlmunlock(dlm, &lksb, 0, dlm_reco_unlock_ast, dlm);
+		if (ret == DLM_DENIED) {
+			mlog(0, "got DLM_DENIED, trying LKM_CANCEL\n");
+			ret = dlmunlock(dlm, &lksb, LKM_CANCEL, dlm_reco_unlock_ast, dlm);
+		}
 		if (ret != DLM_NORMAL) {
 			/* this would really suck. this could only happen
 			 * if there was a network error during the unlock
@@ -1930,20 +2057,42 @@ retry:
 			 * is actually "done" and the lock structure is
 			 * even freed.  we can continue, but only
 			 * because this specific lock name is special. */
-			mlog(0, "dlmunlock returned %d\n", ret);
-		}
-
-		if (status < 0) {
-			mlog(0, "failed to send recovery message. "
-				   "must retry with new node map.\n");
-			goto retry;
+			mlog(ML_ERROR, "dlmunlock returned %d\n", ret);
 		}
 	} else if (ret == DLM_NOTQUEUED) {
 		mlog(0, "dlm=%s dlmlock says another node got it (this=%u)\n",
 		     dlm->name, dlm->node_num);
 		/* another node is master. wait on
-		 * reco.new_master != O2NM_INVALID_NODE_NUM */
+		 * reco.new_master != O2NM_INVALID_NODE_NUM 
+		 * for at most one second */
+		wait_event_timeout(dlm->dlm_reco_thread_wq,
+					 dlm_reco_master_ready(dlm),
+					 msecs_to_jiffies(1000));
+		if (!dlm_reco_master_ready(dlm)) {
+			mlog(0, "%s: reco master taking awhile\n",
+			     dlm->name);
+			goto again;
+		}
+		/* another node has informed this one that it is reco master */
+		mlog(0, "%s: reco master %u is ready to recover %u\n",
+		     dlm->name, dlm->reco.new_master, dlm->reco.dead_node);
 		status = -EEXIST;
+	} else {
+		struct dlm_lock_resource *res;
+
+		/* dlmlock returned something other than NOTQUEUED or NORMAL */
+		mlog(ML_ERROR, "%s: got %s from dlmlock($RECOVERY), "
+		     "lksb.status=%s\n", dlm->name, dlm_errname(ret),
+		     dlm_errname(lksb.status));
+		res = dlm_lookup_lockres(dlm, DLM_RECOVERY_LOCK_NAME,
+					 DLM_RECOVERY_LOCK_NAME_LEN);
+		if (res) {
+			dlm_print_one_lock_resource(res);
+			dlm_lockres_put(res);
+		} else {
+			mlog(ML_ERROR, "recovery lock not found\n");
+		}
+		BUG();
 	}
 
 	return status;
@@ -1982,7 +2131,7 @@ static int dlm_send_begin_reco_message(s
 			mlog(0, "not sending begin reco to self\n");
 			continue;
 		}
-
+retry:
 		ret = -EINVAL;
 		mlog(0, "attempting to send begin reco msg to %d\n",
 			  nodenum);
@@ -1991,8 +2140,17 @@ static int dlm_send_begin_reco_message(s
 		/* negative status is handled ok by caller here */
 		if (ret >= 0)
 			ret = status;
+		if (dlm_is_host_down(ret)) {
+			/* node is down.  not involved in recovery
+			 * so just keep going */
+			mlog(0, "%s: node %u was down when sending "
+			     "begin reco msg (%d)\n", dlm->name, nodenum, ret);
+			ret = 0;
+		}
 		if (ret < 0) {
 			struct dlm_lock_resource *res;
+			/* this is now a serious problem, possibly ENOMEM 
+			 * in the network stack.  must retry */
 			mlog_errno(ret);
 			mlog(ML_ERROR, "begin reco of dlm %s to node %u "
 			    " returned %d\n", dlm->name, nodenum, ret);
@@ -2004,7 +2162,10 @@ static int dlm_send_begin_reco_message(s
 			} else {
 				mlog(ML_ERROR, "recovery lock not found\n");
 			}
-			break;
+			/* sleep for a bit in hopes that we can avoid 
+			 * another ENOMEM */
+			msleep(100);
+			goto retry;
 		}
 	}
 
@@ -2027,19 +2188,34 @@ int dlm_begin_reco_handler(struct o2net_
 
 	spin_lock(&dlm->spinlock);
 	if (dlm->reco.new_master != O2NM_INVALID_NODE_NUM) {
-		mlog(0, "new_master already set to %u!\n",
-			  dlm->reco.new_master);
+		if (test_bit(dlm->reco.new_master, dlm->recovery_map)) {
+			mlog(0, "%s: new_master %u died, changing "
+			     "to %u\n", dlm->name, dlm->reco.new_master,
+			     br->node_idx);
+		} else {
+			mlog(0, "%s: new_master %u NOT DEAD, changing "
+			     "to %u\n", dlm->name, dlm->reco.new_master,
+			     br->node_idx);
+			/* may not have seen the new master as dead yet */
+		}
 	}
 	if (dlm->reco.dead_node != O2NM_INVALID_NODE_NUM) {
-		mlog(0, "dead_node already set to %u!\n",
-			  dlm->reco.dead_node);
+		mlog(ML_NOTICE, "%s: dead_node previously set to %u, "
+		     "node %u changing it to %u\n", dlm->name, 
+		     dlm->reco.dead_node, br->node_idx, br->dead_node);
 	}
 	dlm->reco.new_master = br->node_idx;
 	dlm->reco.dead_node = br->dead_node;
 	if (!test_bit(br->dead_node, dlm->recovery_map)) {
-		mlog(ML_ERROR, "recovery master %u sees %u as dead, but this "
+		mlog(0, "recovery master %u sees %u as dead, but this "
 		     "node has not yet.  marking %u as dead\n",
 		     br->node_idx, br->dead_node, br->dead_node);
+		if (!test_bit(br->dead_node, dlm->domain_map) ||
+		    !test_bit(br->dead_node, dlm->live_nodes_map))
+			mlog(0, "%u not in domain/live_nodes map "
+			     "so setting it in reco map manually\n",
+			     br->dead_node);
+		set_bit(br->dead_node, dlm->recovery_map);
 		__dlm_hb_node_down(dlm, br->dead_node);
 	}
 	spin_unlock(&dlm->spinlock);
diff --git a/fs/ocfs2/dlm/dlmunlock.c b/fs/ocfs2/dlm/dlmunlock.c
index cec2ce1..c95f08d 100644
--- a/fs/ocfs2/dlm/dlmunlock.c
+++ b/fs/ocfs2/dlm/dlmunlock.c
@@ -188,6 +188,19 @@ static enum dlm_status dlmunlock_common(
 			actions &= ~(DLM_UNLOCK_REMOVE_LOCK|
 				     DLM_UNLOCK_REGRANT_LOCK|
 				     DLM_UNLOCK_CLEAR_CONVERT_TYPE);
+		} else if (status == DLM_RECOVERING || 
+			   status == DLM_MIGRATING || 
+			   status == DLM_FORWARD) {
+			/* must clear the actions because this unlock
+			 * is about to be retried.  cannot free or do
+			 * any list manipulation. */
+			mlog(0, "%s:%.*s: clearing actions, %s\n",
+			     dlm->name, res->lockname.len,
+			     res->lockname.name,
+			     status==DLM_RECOVERING?"recovering":
+			     (status==DLM_MIGRATING?"migrating":
+			      "forward"));
+			actions = 0;
 		}
 		if (flags & LKM_CANCEL)
 			lock->cancel_pending = 0;
diff --git a/fs/ocfs2/dlm/userdlm.c b/fs/ocfs2/dlm/userdlm.c
index e1fdd28..c3764f4 100644
--- a/fs/ocfs2/dlm/userdlm.c
+++ b/fs/ocfs2/dlm/userdlm.c
@@ -27,7 +27,7 @@
  * Boston, MA 021110-1307, USA.
  */
 
-#include <asm/signal.h>
+#include <linux/signal.h>
 
 #include <linux/module.h>
 #include <linux/fs.h>
diff --git a/fs/ocfs2/extent_map.c b/fs/ocfs2/extent_map.c
index f2fb40c..eb2bd8a 100644
--- a/fs/ocfs2/extent_map.c
+++ b/fs/ocfs2/extent_map.c
@@ -988,7 +988,7 @@ int __init init_ocfs2_extent_maps(void)
 	return 0;
 }
 
-void __exit exit_ocfs2_extent_maps(void)
+void exit_ocfs2_extent_maps(void)
 {
 	kmem_cache_destroy(ocfs2_em_ent_cachep);
 }
diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index d4ecc06..8122489 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -903,10 +903,10 @@ void ocfs2_clear_inode(struct inode *ino
 			"Clear inode of %"MLFu64", inode is locked\n",
 			oi->ip_blkno);
 
-	mlog_bug_on_msg(down_trylock(&oi->ip_io_sem),
-			"Clear inode of %"MLFu64", io_sem is locked\n",
+	mlog_bug_on_msg(!mutex_trylock(&oi->ip_io_mutex),
+			"Clear inode of %"MLFu64", io_mutex is locked\n",
 			oi->ip_blkno);
-	up(&oi->ip_io_sem);
+	mutex_unlock(&oi->ip_io_mutex);
 
 	/*
 	 * down_trylock() returns 0, down_write_trylock() returns 1
diff --git a/fs/ocfs2/inode.h b/fs/ocfs2/inode.h
index 9b01774..84c5079 100644
--- a/fs/ocfs2/inode.h
+++ b/fs/ocfs2/inode.h
@@ -46,10 +46,10 @@ struct ocfs2_inode_info
 	struct list_head		ip_io_markers;
 	int				ip_orphaned_slot;
 
-	struct semaphore		ip_io_sem;
+	struct mutex			ip_io_mutex;
 
 	/* Used by the journalling code to attach an inode to a
-	 * handle.  These are protected by ip_io_sem in order to lock
+	 * handle.  These are protected by ip_io_mutex in order to lock
 	 * out other I/O to the inode until we either commit or
 	 * abort. */
 	struct list_head		ip_handle_list;
diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
index 303c8d9..ccabed9 100644
--- a/fs/ocfs2/journal.c
+++ b/fs/ocfs2/journal.c
@@ -401,7 +401,7 @@ int ocfs2_journal_access(struct ocfs2_jo
 	 * j_trans_barrier for us. */
 	ocfs2_set_inode_lock_trans(OCFS2_SB(inode->i_sb)->journal, inode);
 
-	down(&OCFS2_I(inode)->ip_io_sem);
+	mutex_lock(&OCFS2_I(inode)->ip_io_mutex);
 	switch (type) {
 	case OCFS2_JOURNAL_ACCESS_CREATE:
 	case OCFS2_JOURNAL_ACCESS_WRITE:
@@ -416,7 +416,7 @@ int ocfs2_journal_access(struct ocfs2_jo
 		status = -EINVAL;
 		mlog(ML_ERROR, "Uknown access type!\n");
 	}
-	up(&OCFS2_I(inode)->ip_io_sem);
+	mutex_unlock(&OCFS2_I(inode)->ip_io_mutex);
 
 	if (status < 0)
 		mlog(ML_ERROR, "Error %d getting %d access to buffer!\n",
@@ -1072,10 +1072,10 @@ restart:
 					NULL);
 
 bail:
-	down(&osb->recovery_lock);
+	mutex_lock(&osb->recovery_lock);
 	if (!status &&
 	    !ocfs2_node_map_is_empty(osb, &osb->recovery_map)) {
-		up(&osb->recovery_lock);
+		mutex_unlock(&osb->recovery_lock);
 		goto restart;
 	}
 
@@ -1083,7 +1083,7 @@ bail:
 	mb(); /* sync with ocfs2_recovery_thread_running */
 	wake_up(&osb->recovery_event);
 
-	up(&osb->recovery_lock);
+	mutex_unlock(&osb->recovery_lock);
 
 	mlog_exit(status);
 	/* no one is callint kthread_stop() for us so the kthread() api
@@ -1098,7 +1098,7 @@ void ocfs2_recovery_thread(struct ocfs2_
 	mlog_entry("(node_num=%d, osb->node_num = %d)\n",
 		   node_num, osb->node_num);
 
-	down(&osb->recovery_lock);
+	mutex_lock(&osb->recovery_lock);
 	if (osb->disable_recovery)
 		goto out;
 
@@ -1120,7 +1120,7 @@ void ocfs2_recovery_thread(struct ocfs2_
 	}
 
 out:
-	up(&osb->recovery_lock);
+	mutex_unlock(&osb->recovery_lock);
 	wake_up(&osb->recovery_event);
 
 	mlog_exit_void();
diff --git a/fs/ocfs2/ocfs2.h b/fs/ocfs2/ocfs2.h
index f468c60..8d8e477 100644
--- a/fs/ocfs2/ocfs2.h
+++ b/fs/ocfs2/ocfs2.h
@@ -33,6 +33,7 @@
 #include <linux/rbtree.h>
 #include <linux/workqueue.h>
 #include <linux/kref.h>
+#include <linux/mutex.h>
 
 #include "cluster/nodemanager.h"
 #include "cluster/heartbeat.h"
@@ -233,7 +234,7 @@ struct ocfs2_super
 	struct proc_dir_entry *proc_sub_dir; /* points to /proc/fs/ocfs2/<maj_min> */
 
 	atomic_t vol_state;
-	struct semaphore recovery_lock;
+	struct mutex recovery_lock;
 	struct task_struct *recovery_thread_task;
 	int disable_recovery;
 	wait_queue_head_t checkpoint_event;
diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index 364d64b..e7e17bd 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -932,7 +932,7 @@ static void ocfs2_inode_init_once(void *
 		oi->ip_dir_start_lookup = 0;
 
 		init_rwsem(&oi->ip_alloc_sem);
-		init_MUTEX(&(oi->ip_io_sem));
+		mutex_init(&oi->ip_io_mutex);
 
 		oi->ip_blkno = 0ULL;
 		oi->ip_clusters = 0;
@@ -1137,9 +1137,9 @@ static void ocfs2_dismount_volume(struct
 
 	/* disable any new recovery threads and wait for any currently
 	 * running ones to exit. Do this before setting the vol_state. */
-	down(&osb->recovery_lock);
+	mutex_lock(&osb->recovery_lock);
 	osb->disable_recovery = 1;
-	up(&osb->recovery_lock);
+	mutex_unlock(&osb->recovery_lock);
 	wait_event(osb->recovery_event, !ocfs2_recovery_thread_running(osb));
 
 	/* At this point, we know that no more recovery threads can be
@@ -1283,7 +1283,7 @@ static int ocfs2_initialize_super(struct
 	snprintf(osb->dev_str, sizeof(osb->dev_str), "%u,%u",
 		 MAJOR(osb->sb->s_dev), MINOR(osb->sb->s_dev));
 
-	init_MUTEX(&osb->recovery_lock);
+	mutex_init(&osb->recovery_lock);
 
 	osb->disable_recovery = 0;
 	osb->recovery_thread_task = NULL;
diff --git a/fs/ocfs2/uptodate.c b/fs/ocfs2/uptodate.c
index 3a0458f..300b5be 100644
--- a/fs/ocfs2/uptodate.c
+++ b/fs/ocfs2/uptodate.c
@@ -388,7 +388,7 @@ out_free:
 	}
 }
 
-/* Item insertion is guarded by ip_io_sem, so the insertion path takes
+/* Item insertion is guarded by ip_io_mutex, so the insertion path takes
  * advantage of this by not rechecking for a duplicate insert during
  * the slow case. Additionally, if the cache needs to be bumped up to
  * a tree, the code will not recheck after acquiring the lock --
@@ -418,7 +418,7 @@ void ocfs2_set_buffer_uptodate(struct in
 	     (unsigned long long) bh->b_blocknr);
 
 	/* No need to recheck under spinlock - insertion is guarded by
-	 * ip_io_sem */
+	 * ip_io_mutex */
 	spin_lock(&oi->ip_lock);
 	if (ocfs2_insert_can_use_array(oi, ci)) {
 		/* Fast case - it's an array and there's a free
@@ -440,7 +440,7 @@ void ocfs2_set_buffer_uptodate(struct in
 
 /* Called against a newly allocated buffer. Most likely nobody should
  * be able to read this sort of metadata while it's still being
- * allocated, but this is careful to take ip_io_sem anyway. */
+ * allocated, but this is careful to take ip_io_mutex anyway. */
 void ocfs2_set_new_buffer_uptodate(struct inode *inode,
 				   struct buffer_head *bh)
 {
@@ -451,9 +451,9 @@ void ocfs2_set_new_buffer_uptodate(struc
 
 	set_buffer_uptodate(bh);
 
-	down(&oi->ip_io_sem);
+	mutex_lock(&oi->ip_io_mutex);
 	ocfs2_set_buffer_uptodate(inode, bh);
-	up(&oi->ip_io_sem);
+	mutex_unlock(&oi->ip_io_mutex);
 }
 
 /* Requires ip_lock. */
@@ -537,7 +537,7 @@ int __init init_ocfs2_uptodate_cache(voi
 	return 0;
 }
 
-void __exit exit_ocfs2_uptodate_cache(void)
+void exit_ocfs2_uptodate_cache(void)
 {
 	if (ocfs2_uptodate_cachep)
 		kmem_cache_destroy(ocfs2_uptodate_cachep);
diff --git a/fs/ocfs2/uptodate.h b/fs/ocfs2/uptodate.h
index e5aacdf..01cd32d 100644
--- a/fs/ocfs2/uptodate.h
+++ b/fs/ocfs2/uptodate.h
@@ -27,7 +27,7 @@
 #define OCFS2_UPTODATE_H
 
 int __init init_ocfs2_uptodate_cache(void);
-void __exit exit_ocfs2_uptodate_cache(void);
+void exit_ocfs2_uptodate_cache(void);
 
 void ocfs2_metadata_cache_init(struct inode *inode);
 void ocfs2_metadata_cache_purge(struct inode *inode);

