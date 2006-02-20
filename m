Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964870AbWBTKqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964870AbWBTKqn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 05:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964871AbWBTKqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 05:46:43 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:34512 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S964870AbWBTKqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 05:46:43 -0500
Date: Mon, 20 Feb 2006 11:46:41 +0100
From: Jan Kara <jack@suse.cz>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix oops in invalidate_dquots()
Message-ID: <20060220104641.GA23302@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hello,

  attached patch fixes oops (actually assertion failure) in
invalidate_dquots(). The problem was that we expected no one can hold a
reference of a dquot when we removed all references from inodes and
turned quotas off. Sadly we could miss some inodes when removing
references - inodes just being deleted are not in superblock's inodes
list. So I changed invalidate_dquots() to wait for the users of dquots
to drop their references (we are guaranteed to succeed as no new
references can be acquired). The patch is against 2.6.16-rc4.

								Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs

--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="quota-2.6.16-rc4-1-invalidate_dquots.diff"

When quota is being turned off we assumed that all the references to dquots
were already dropped. That need not be true as inodes being deleted are not on
superblock's inodes list and hence we need not reach it when removing quota
references from inodes. So invalidate_dquots() has to wait for all the users
of dquots (as quota is already marked as turned off, no new references can
be acquired and so this is bound to happen rather early). When we do this,
we can also remove the iprune_sem locking as it was protecting us against
exactly the same problem when freeing inodes icache memory.

Signed-off-by: Jan Kara <jack@suse.cz>

diff -rupX /home/jack/.kerndiffexclude linux-2.6.16-rc4/fs/dquot.c linux-2.6.16-rc4-1-invalidate_dquots/fs/dquot.c
--- linux-2.6.16-rc4/fs/dquot.c	2006-02-22 23:45:53.000000000 +0100
+++ linux-2.6.16-rc4-1-invalidate_dquots/fs/dquot.c	2006-02-23 17:34:34.000000000 +0100
@@ -118,8 +118,7 @@
  * spinlock to internal buffers before writing.
  *
  * Lock ordering (including related VFS locks) is the following:
- *   i_mutex > dqonoff_sem > iprune_sem > journal_lock > dqptr_sem >
- *   > dquot->dq_lock > dqio_sem
+ *   i_mutex > dqonoff_sem > journal_lock > dqptr_sem > dquot->dq_lock > dqio_sem
  * i_mutex on quota files is special (it's below dqio_sem)
  */
 
@@ -407,22 +406,44 @@ out_dqlock:
 
 /* Invalidate all dquots on the list. Note that this function is called after
  * quota is disabled and pointers from inodes removed so there cannot be new
- * quota users. Also because we hold dqonoff_sem there can be no quota users
- * for this sb+type at all. */
+ * quota users. There can still be some users of quotas due to inodes being
+ * just deleted or pruned by prune_icache() (those are not attached to any
+ * list). We have to wait for such users.
+ */
 static void invalidate_dquots(struct super_block *sb, int type)
 {
 	struct dquot *dquot, *tmp;
 
+restart:
 	spin_lock(&dq_list_lock);
 	list_for_each_entry_safe(dquot, tmp, &inuse_list, dq_inuse) {
 		if (dquot->dq_sb != sb)
 			continue;
 		if (dquot->dq_type != type)
 			continue;
-#ifdef __DQUOT_PARANOIA
-		if (atomic_read(&dquot->dq_count))
-			BUG();
-#endif
+		/* Wait for dquot users */
+		if (atomic_read(&dquot->dq_count)) {
+			DEFINE_WAIT(wait);
+
+			atomic_inc(&dquot->dq_count);
+			prepare_to_wait(&dquot->dq_wait_unused, &wait, TASK_UNINTERRUPTIBLE);
+			spin_unlock(&dq_list_lock);
+			/* Once dqput() wakes us up, we know it's time to free
+			 * the dquot.
+			 * IMPORTANT: we rely on the fact that there is always
+			 * at most one process waiting for dquot to free.
+			 * Otherwise dq_count would be > 1 and we would never
+			 * wake up.
+			 */
+			if (atomic_read(&dquot->dq_count) > 1)
+				schedule();
+			finish_wait(&dquot->dq_wait_unused, &wait);
+			dqput(dquot);
+			/* At this moment dquot() need not exist (it could be
+			 * reclaimed by prune_dqcache(). Hence we must
+			 * restart. */
+			goto restart;
+		}
 		/* Quota now has no users and it has been written on last dqput() */
 		remove_dquot_hash(dquot);
 		remove_free_dquot(dquot);
@@ -540,6 +561,10 @@ we_slept:
 	if (atomic_read(&dquot->dq_count) > 1) {
 		/* We have more than one user... nothing to do */
 		atomic_dec(&dquot->dq_count);
+		/* Releasing dquot during quotaoff phase? */
+		if (!sb_has_quota_enabled(dquot->dq_sb, dquot->dq_type) &&
+		    atomic_read(&dquot->dq_count) == 1)
+			wake_up(&dquot->dq_wait_unused);
 		spin_unlock(&dq_list_lock);
 		return;
 	}
@@ -581,6 +606,7 @@ static struct dquot *get_empty_dquot(str
 	INIT_LIST_HEAD(&dquot->dq_inuse);
 	INIT_HLIST_NODE(&dquot->dq_hash);
 	INIT_LIST_HEAD(&dquot->dq_dirty);
+	init_waitqueue_head(&dquot->dq_wait_unused);
 	dquot->dq_sb = sb;
 	dquot->dq_type = type;
 	atomic_set(&dquot->dq_count, 1);
@@ -732,13 +758,9 @@ static void drop_dquot_ref(struct super_
 {
 	LIST_HEAD(tofree_head);
 
-	/* We need to be guarded against prune_icache to reach all the
-	 * inodes - otherwise some can be on the local list of prune_icache */
-	down(&iprune_sem);
 	down_write(&sb_dqopt(sb)->dqptr_sem);
 	remove_dquot_ref(sb, type, &tofree_head);
 	up_write(&sb_dqopt(sb)->dqptr_sem);
-	up(&iprune_sem);
 	put_dquot_list(&tofree_head);
 }
 

--5vNYLRcllDrimb99--
