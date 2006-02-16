Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750914AbWBPVXV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbWBPVXV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 16:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbWBPVXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 16:23:21 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:15278 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1750880AbWBPVXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 16:23:20 -0500
Date: Thu, 16 Feb 2006 13:22:54 -0800
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: [git patches] ocfs2 updates
Message-ID: <20060216212254.GJ20175@ca-server1.us.oracle.com>
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

 fs/ocfs2/dlm/dlmcommon.h   |    4 ++++
 fs/ocfs2/dlm/dlmconvert.c  |   12 +++++++++---
 fs/ocfs2/dlm/dlmlock.c     |   25 ++++++++++++++++++++++++-
 fs/ocfs2/dlm/dlmmaster.c   |    7 ++++++-
 fs/ocfs2/dlm/dlmrecovery.c |   42 ++++++++++++++++++++++++++++++++++++++++++
 fs/ocfs2/journal.c         |    7 +++----
 fs/ocfs2/journal.h         |    2 --
 7 files changed, 88 insertions(+), 11 deletions(-)

Kurt Hackel:
      ocfs2: recheck recovery state after getting lock
      ocfs2: fix release of ast never reserved
      ocfs2: add dlm_wait_for_node_death
      ocfs2: manually grant remote recovery lock
      ocfs2: detach from heartbeat events before freeing mle

Mark Fasheh:
      ocfs2: only checkpoint journal when asked to

diff --git a/fs/ocfs2/dlm/dlmcommon.h b/fs/ocfs2/dlm/dlmcommon.h
index 42eb53b..23ceaa7 100644
--- a/fs/ocfs2/dlm/dlmcommon.h
+++ b/fs/ocfs2/dlm/dlmcommon.h
@@ -208,6 +208,9 @@ static inline void __dlm_set_joining_nod
 #define DLM_LOCK_RES_IN_PROGRESS          0x00000010
 #define DLM_LOCK_RES_MIGRATING            0x00000020
 
+/* max milliseconds to wait to sync up a network failure with a node death */
+#define DLM_NODE_DEATH_WAIT_MAX (5 * 1000)
+
 #define DLM_PURGE_INTERVAL_MS   (8 * 1000)
 
 struct dlm_lock_resource
@@ -658,6 +661,7 @@ int dlm_launch_recovery_thread(struct dl
 void dlm_complete_recovery_thread(struct dlm_ctxt *dlm);
 void dlm_wait_for_recovery(struct dlm_ctxt *dlm);
 int dlm_is_node_dead(struct dlm_ctxt *dlm, u8 node);
+int dlm_wait_for_node_death(struct dlm_ctxt *dlm, u8 node, int timeout);
 
 void dlm_put(struct dlm_ctxt *dlm);
 struct dlm_ctxt *dlm_grab(struct dlm_ctxt *dlm);
diff --git a/fs/ocfs2/dlm/dlmconvert.c b/fs/ocfs2/dlm/dlmconvert.c
index 6001b22..f66e2d8 100644
--- a/fs/ocfs2/dlm/dlmconvert.c
+++ b/fs/ocfs2/dlm/dlmconvert.c
@@ -392,6 +392,11 @@ static enum dlm_status dlm_send_remote_c
 	} else {
 		mlog_errno(tmpret);
 		if (dlm_is_host_down(tmpret)) {
+			/* instead of logging the same network error over
+			 * and over, sleep here and wait for the heartbeat
+			 * to notice the node is dead.  times out after 5s. */
+			dlm_wait_for_node_death(dlm, res->owner, 
+						DLM_NODE_DEATH_WAIT_MAX);
 			ret = DLM_RECOVERING;
 			mlog(0, "node %u died so returning DLM_RECOVERING "
 			     "from convert message!\n", res->owner);
@@ -421,7 +426,7 @@ int dlm_convert_lock_handler(struct o2ne
 	struct dlm_lockstatus *lksb;
 	enum dlm_status status = DLM_NORMAL;
 	u32 flags;
-	int call_ast = 0, kick_thread = 0;
+	int call_ast = 0, kick_thread = 0, ast_reserved = 0;
 
 	if (!dlm_grab(dlm)) {
 		dlm_error(DLM_REJECTED);
@@ -490,6 +495,7 @@ int dlm_convert_lock_handler(struct o2ne
 	status = __dlm_lockres_state_to_status(res);
 	if (status == DLM_NORMAL) {
 		__dlm_lockres_reserve_ast(res);
+		ast_reserved = 1;
 		res->state |= DLM_LOCK_RES_IN_PROGRESS;
 		status = __dlmconvert_master(dlm, res, lock, flags,
 					     cnv->requested_type,
@@ -512,10 +518,10 @@ leave:
 	else
 		dlm_lock_put(lock);
 
-	/* either queue the ast or release it */
+	/* either queue the ast or release it, if reserved */
 	if (call_ast)
 		dlm_queue_ast(dlm, lock);
-	else
+	else if (ast_reserved)
 		dlm_lockres_release_ast(dlm, res);
 
 	if (kick_thread)
diff --git a/fs/ocfs2/dlm/dlmlock.c b/fs/ocfs2/dlm/dlmlock.c
index d1a0038..671d4ff 100644
--- a/fs/ocfs2/dlm/dlmlock.c
+++ b/fs/ocfs2/dlm/dlmlock.c
@@ -220,6 +220,17 @@ static enum dlm_status dlmlock_remote(st
 			dlm_error(status);
 		dlm_revert_pending_lock(res, lock);
 		dlm_lock_put(lock);
+	} else if (dlm_is_recovery_lock(res->lockname.name, 
+					res->lockname.len)) {
+		/* special case for the $RECOVERY lock.
+		 * there will never be an AST delivered to put
+		 * this lock on the proper secondary queue
+		 * (granted), so do it manually. */
+		mlog(0, "%s: $RECOVERY lock for this node (%u) is "
+		     "mastered by %u; got lock, manually granting (no ast)\n",
+		     dlm->name, dlm->node_num, res->owner);
+		list_del_init(&lock->list);
+		list_add_tail(&lock->list, &res->granted);
 	}
 	spin_unlock(&res->spinlock);
 
@@ -646,7 +657,19 @@ retry_lock:
 			mlog(0, "retrying lock with migration/"
 			     "recovery/in progress\n");
 			msleep(100);
-			dlm_wait_for_recovery(dlm);
+			/* no waiting for dlm_reco_thread */
+			if (recovery) {
+				if (status == DLM_RECOVERING) {
+					mlog(0, "%s: got RECOVERING "
+					     "for $REOCVERY lock, master "
+					     "was %u\n", dlm->name, 
+					     res->owner);
+					dlm_wait_for_node_death(dlm, res->owner, 
+							DLM_NODE_DEATH_WAIT_MAX);
+				}
+			} else {
+				dlm_wait_for_recovery(dlm);
+			}
 			goto retry_lock;
 		}
 
diff --git a/fs/ocfs2/dlm/dlmmaster.c b/fs/ocfs2/dlm/dlmmaster.c
index a3194fe..2e2e95e 100644
--- a/fs/ocfs2/dlm/dlmmaster.c
+++ b/fs/ocfs2/dlm/dlmmaster.c
@@ -2482,7 +2482,9 @@ top:
 				atomic_set(&mle->woken, 1);
 				spin_unlock(&mle->spinlock);
 				wake_up(&mle->wq);
-				/* final put will take care of list removal */
+				/* do not need events any longer, so detach 
+				 * from heartbeat */
+				__dlm_mle_detach_hb_events(dlm, mle);
 				__dlm_put_mle(mle);
 			}
 			continue;
@@ -2537,6 +2539,9 @@ top:
 			spin_unlock(&res->spinlock);
 			dlm_lockres_put(res);
 
+			/* about to get rid of mle, detach from heartbeat */
+			__dlm_mle_detach_hb_events(dlm, mle);
+
 			/* dump the mle */
 			spin_lock(&dlm->master_lock);
 			__dlm_put_mle(mle);
diff --git a/fs/ocfs2/dlm/dlmrecovery.c b/fs/ocfs2/dlm/dlmrecovery.c
index 186e9a7..ed76bda 100644
--- a/fs/ocfs2/dlm/dlmrecovery.c
+++ b/fs/ocfs2/dlm/dlmrecovery.c
@@ -278,6 +278,24 @@ int dlm_is_node_dead(struct dlm_ctxt *dl
 	return dead;
 }
 
+int dlm_wait_for_node_death(struct dlm_ctxt *dlm, u8 node, int timeout)
+{
+	if (timeout) {
+		mlog(ML_NOTICE, "%s: waiting %dms for notification of "
+		     "death of node %u\n", dlm->name, timeout, node);
+		wait_event_timeout(dlm->dlm_reco_thread_wq,
+			   dlm_is_node_dead(dlm, node),
+			   msecs_to_jiffies(timeout));
+	} else {
+		mlog(ML_NOTICE, "%s: waiting indefinitely for notification "
+		     "of death of node %u\n", dlm->name, node);
+		wait_event(dlm->dlm_reco_thread_wq,
+			   dlm_is_node_dead(dlm, node));
+	}
+	/* for now, return 0 */
+	return 0;
+}
+
 /* callers of the top-level api calls (dlmlock/dlmunlock) should
  * block on the dlm->reco.event when recovery is in progress.
  * the dlm recovery thread will set this state when it begins
@@ -2032,6 +2050,30 @@ again:	
 			     dlm->reco.new_master);
 			status = -EEXIST;
 		} else {
+			status = 0;
+
+			/* see if recovery was already finished elsewhere */
+			spin_lock(&dlm->spinlock);
+			if (dlm->reco.dead_node == O2NM_INVALID_NODE_NUM) {
+				status = -EINVAL;	
+				mlog(0, "%s: got reco EX lock, but "
+				     "node got recovered already\n", dlm->name);
+				if (dlm->reco.new_master != O2NM_INVALID_NODE_NUM) {
+					mlog(ML_ERROR, "%s: new master is %u "
+					     "but no dead node!\n", 
+					     dlm->name, dlm->reco.new_master);
+					BUG();
+				}
+			}
+			spin_unlock(&dlm->spinlock);
+		}
+
+		/* if this node has actually become the recovery master,
+		 * set the master and send the messages to begin recovery */
+		if (!status) {
+			mlog(0, "%s: dead=%u, this=%u, sending "
+			     "begin_reco now\n", dlm->name, 
+			     dlm->reco.dead_node, dlm->node_num);
 			status = dlm_send_begin_reco_message(dlm,
 				      dlm->reco.dead_node);
 			/* this always succeeds */
diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
index fa0bcac..d329c9d 100644
--- a/fs/ocfs2/journal.c
+++ b/fs/ocfs2/journal.c
@@ -1584,10 +1584,9 @@ static int ocfs2_commit_thread(void *arg
 	while (!(kthread_should_stop() &&
 		 atomic_read(&journal->j_num_trans) == 0)) {
 
-		wait_event_interruptible_timeout(osb->checkpoint_event,
-						 atomic_read(&journal->j_num_trans)
-						 || kthread_should_stop(),
-						 OCFS2_CHECKPOINT_INTERVAL);
+		wait_event_interruptible(osb->checkpoint_event,
+					 atomic_read(&journal->j_num_trans)
+					 || kthread_should_stop());
 
 		status = ocfs2_commit_cache(osb);
 		if (status < 0)
diff --git a/fs/ocfs2/journal.h b/fs/ocfs2/journal.h
index 7d0a816..2f3a6ac 100644
--- a/fs/ocfs2/journal.h
+++ b/fs/ocfs2/journal.h
@@ -29,8 +29,6 @@
 #include <linux/fs.h>
 #include <linux/jbd.h>
 
-#define OCFS2_CHECKPOINT_INTERVAL        (8 * HZ)
-
 enum ocfs2_journal_state {
 	OCFS2_JOURNAL_FREE = 0,
 	OCFS2_JOURNAL_LOADED,

