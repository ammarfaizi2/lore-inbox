Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264108AbUDVPT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264108AbUDVPT1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 11:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264101AbUDVPT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 11:19:27 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:1419 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264131AbUDVPSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 11:18:47 -0400
Date: Thu, 22 Apr 2004 17:18:20 +0200
From: Jan Kara <jack@ucw.cz>
To: akpm@osdl.org
Cc: sct@redhat.com, linux-kernel@vger.kernel.org, crosser@rol.ru
Subject: [PATCH] Per-sb dquot dirty lists
Message-ID: <20040422151820.GC7506@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="GRPZ8SYKNexpdSJ7"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hi,

  when there are lots of dirty dquots the vfs_quota_sync() is too slow
(it has O(N^2) behaviour). Attached patch implements list of dirty
dquots for each superblock and quota type. Using this lists sync is
trivially linear. Attached patch is against 2.6.5 with journalled quota
and previous patch for hash table size. Please apply.

							Thanks
								Honza


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="quota-2.6.5-5-dirtylist.diff"

diff -ruX /home/jack/.kerndiffexclude linux-2.6.5-4-hashsize/fs/dquot.c linux-2.6.5-5-dirtylist/fs/dquot.c
--- linux-2.6.5-4-hashsize/fs/dquot.c	2004-04-21 10:57:07.000000000 +0200
+++ linux-2.6.5-5-dirtylist/fs/dquot.c	2004-04-21 17:03:12.000000000 +0200
@@ -274,16 +274,25 @@
 
 #define mark_dquot_dirty(dquot) ((dquot)->dq_sb->dq_op->mark_dirty(dquot))
 
-/* No locks needed here as ANY_DQUOT_DIRTY is used just by sync and so the
- * worst what can happen is that dquot is not written by concurrent sync... */
 int dquot_mark_dquot_dirty(struct dquot *dquot)
 {
-	set_bit(DQ_MOD_B, &(dquot)->dq_flags);
-	set_bit(DQF_ANY_DQUOT_DIRTY_B, &(sb_dqopt((dquot)->dq_sb)->
-		info[(dquot)->dq_type].dqi_flags));
+	spin_lock(&dq_list_lock);
+	if (!test_and_set_bit(DQ_MOD_B, &dquot->dq_flags))
+		list_add(&dquot->dq_dirty, &sb_dqopt(dquot->dq_sb)->
+				info[dquot->dq_type].dqi_dirty_list);
+	spin_unlock(&dq_list_lock);
 	return 0;
 }
 
+/* This function needs dq_list_lock */
+static inline int clear_dquot_dirty(struct dquot *dquot)
+{
+	if (!test_and_clear_bit(DQ_MOD_B, &dquot->dq_flags))
+		return 0;
+	list_del_init(&dquot->dq_dirty);
+	return 1;
+}
+
 void mark_info_dirty(struct super_block *sb, int type)
 {
 	set_bit(DQF_INFO_DIRTY_B, &sb_dqopt(sb)->info[type].dqi_flags);
@@ -328,11 +337,17 @@
 	struct quota_info *dqopt = sb_dqopt(dquot->dq_sb);
 
 	down(&dqopt->dqio_sem);
-	clear_bit(DQ_MOD_B, &dquot->dq_flags);
+	spin_lock(&dq_list_lock);
+	if (!clear_dquot_dirty(dquot)) {
+		spin_unlock(&dq_list_lock);
+		goto out_sem;
+	}
+	spin_unlock(&dq_list_lock);
 	/* Inactive dquot can be only if there was error during read/init
 	 * => we have better not writing it */
 	if (test_bit(DQ_ACTIVE_B, &dquot->dq_flags))
 		ret = dqopt->ops[dquot->dq_type]->commit_dqblk(dquot);
+out_sem:
 	up(&dqopt->dqio_sem);
 	if (info_dirty(&dqopt->info[dquot->dq_type]))
 		dquot->dq_sb->dq_op->write_info(dquot->dq_sb, dquot->dq_type);
@@ -392,42 +407,38 @@
 
 int vfs_quota_sync(struct super_block *sb, int type)
 {
-	struct list_head *head;
+	struct list_head *dirty;
 	struct dquot *dquot;
 	struct quota_info *dqopt = sb_dqopt(sb);
 	int cnt;
 
 	down(&dqopt->dqonoff_sem);
-restart:
-	/* At this point any dirty dquot will definitely be written so we can clear
-	   dirty flag from info */
-	spin_lock(&dq_data_lock);
-	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
-		if ((cnt == type || type == -1) && sb_has_quota_enabled(sb, cnt))
-			clear_bit(DQF_ANY_DQUOT_DIRTY_B, &dqopt->info[cnt].dqi_flags);
-	spin_unlock(&dq_data_lock);
-	spin_lock(&dq_list_lock);
-	list_for_each(head, &inuse_list) {
-		dquot = list_entry(head, struct dquot, dq_inuse);
-		if (sb && dquot->dq_sb != sb)
-			continue;
-                if (type != -1 && dquot->dq_type != type)
-			continue;
-		if (!dquot_dirty(dquot))
+	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
+		if (type != -1 && cnt != type)
 			continue;
-		/* Dirty and inactive can be only bad dquot... */
-		if (!test_bit(DQ_ACTIVE_B, &dquot->dq_flags))
+		if (!sb_has_quota_enabled(sb, cnt))
 			continue;
-		/* Now we have active dquot from which someone is holding reference so we
-		 * can safely just increase use count */
-		atomic_inc(&dquot->dq_count);
-		dqstats.lookups++;
+		spin_lock(&dq_list_lock);
+		dirty = &dqopt->info[cnt].dqi_dirty_list;
+		while (!list_empty(dirty)) {
+			dquot = list_entry(dirty->next, struct dquot, dq_dirty);
+			/* Dirty and inactive can be only bad dquot... */
+			if (!test_bit(DQ_ACTIVE_B, &dquot->dq_flags)) {
+				clear_dquot_dirty(dquot);
+				continue;
+			}
+			/* Now we have active dquot from which someone is
+ 			 * holding reference so we can safely just increase
+			 * use count */
+			atomic_inc(&dquot->dq_count);
+			dqstats.lookups++;
+			spin_unlock(&dq_list_lock);
+			sb->dq_op->write_dquot(dquot);
+			dqput(dquot);
+			spin_lock(&dq_list_lock);
+		}
 		spin_unlock(&dq_list_lock);
-		sb->dq_op->write_dquot(dquot);
-		dqput(dquot);
-		goto restart;
 	}
-	spin_unlock(&dq_list_lock);
 
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
 		if ((cnt == type || type == -1) && sb_has_quota_enabled(sb, cnt)
@@ -515,7 +526,7 @@
 		goto we_slept;
 	}
 	/* Clear flag in case dquot was inactive (something bad happened) */
-	clear_bit(DQ_MOD_B, &dquot->dq_flags);
+	clear_dquot_dirty(dquot);
 	if (test_bit(DQ_ACTIVE_B, &dquot->dq_flags)) {
 		spin_unlock(&dq_list_lock);
 		dquot_release(dquot);
@@ -544,6 +555,7 @@
 	INIT_LIST_HEAD(&dquot->dq_free);
 	INIT_LIST_HEAD(&dquot->dq_inuse);
 	INIT_HLIST_NODE(&dquot->dq_hash);
+	INIT_LIST_HEAD(&dquot->dq_dirty);
 	dquot->dq_sb = sb;
 	dquot->dq_type = type;
 	atomic_set(&dquot->dq_count, 1);
@@ -1373,6 +1385,7 @@
 
 	dqopt->ops[type] = fmt->qf_ops;
 	dqopt->info[type].dqi_format = fmt;
+	INIT_LIST_HEAD(&dqopt->info[type].dqi_dirty_list);
 	down(&dqopt->dqio_sem);
 	if ((error = dqopt->ops[type]->read_file_info(sb, type)) < 0) {
 		up(&dqopt->dqio_sem);
diff -ruX /home/jack/.kerndiffexclude linux-2.6.5-4-hashsize/fs/ext3/super.c linux-2.6.5-5-dirtylist/fs/ext3/super.c
--- linux-2.6.5-4-hashsize/fs/ext3/super.c	2004-04-21 10:45:30.000000000 +0200
+++ linux-2.6.5-5-dirtylist/fs/ext3/super.c	2004-04-21 17:25:03.000000000 +0200
@@ -2178,8 +2178,10 @@
 {
 	/* Are we journalling quotas? */
 	if (EXT3_SB(dquot->dq_sb)->s_qf_names[USRQUOTA] ||
-	    EXT3_SB(dquot->dq_sb)->s_qf_names[GRPQUOTA])
+	    EXT3_SB(dquot->dq_sb)->s_qf_names[GRPQUOTA]) {
+		dquot_mark_dquot_dirty(dquot);
 		return ext3_write_dquot(dquot);
+	}
 	else
 		return dquot_mark_dquot_dirty(dquot);
 }
diff -ruX /home/jack/.kerndiffexclude linux-2.6.5-4-hashsize/fs/quota.c linux-2.6.5-5-dirtylist/fs/quota.c
--- linux-2.6.5-4-hashsize/fs/quota.c	2003-11-26 21:45:45.000000000 +0100
+++ linux-2.6.5-5-dirtylist/fs/quota.c	2004-04-21 10:59:40.000000000 +0200
@@ -114,9 +114,10 @@
 	list_for_each(head, &super_blocks) {
 		struct super_block *sb = list_entry(head, struct super_block, s_list);
 
+		/* This test just improves performance so it needn't be reliable... */
 		for (cnt = 0, dirty = 0; cnt < MAXQUOTAS; cnt++)
 			if ((type == cnt || type == -1) && sb_has_quota_enabled(sb, cnt)
-			    && info_any_dquot_dirty(&sb_dqopt(sb)->info[cnt]))
+			    && info_any_dirty(&sb_dqopt(sb)->info[cnt]))
 				dirty = 1;
 		if (!dirty)
 			continue;
diff -ruX /home/jack/.kerndiffexclude linux-2.6.5-4-hashsize/include/linux/quota.h linux-2.6.5-5-dirtylist/include/linux/quota.h
--- linux-2.6.5-4-hashsize/include/linux/quota.h	2004-04-21 10:57:36.000000000 +0200
+++ linux-2.6.5-5-dirtylist/include/linux/quota.h	2004-04-21 10:59:40.000000000 +0200
@@ -163,6 +163,7 @@
 
 struct mem_dqinfo {
 	struct quota_format_type *dqi_format;
+	struct list_head dqi_dirty_list;	/* List of dirty dquots */
 	unsigned long dqi_flags;
 	unsigned int dqi_bgrace;
 	unsigned int dqi_igrace;
@@ -176,13 +177,11 @@
 
 #define DQF_MASK 0xffff		/* Mask for format specific flags */
 #define DQF_INFO_DIRTY_B 16
-#define DQF_ANY_DQUOT_DIRTY_B 17
 #define DQF_INFO_DIRTY (1 << DQF_INFO_DIRTY_B)	/* Is info dirty? */
-#define DQF_ANY_DQUOT_DIRTY (1 << DQF_ANY_DQUOT_DIRTY_B) /* Is any dquot dirty? */
 
 extern void mark_info_dirty(struct super_block *sb, int type);
 #define info_dirty(info) test_bit(DQF_INFO_DIRTY_B, &(info)->dqi_flags)
-#define info_any_dquot_dirty(info) test_bit(DQF_ANY_DQUOT_DIRTY_B, &(info)->dqi_flags)
+#define info_any_dquot_dirty(info) (!list_empty(&(info)->dqi_dirty_list))
 #define info_any_dirty(info) (info_dirty(info) || info_any_dquot_dirty(info))
 
 #define sb_dqopt(sb) (&(sb)->s_dquot)
@@ -213,6 +212,7 @@
 	struct hlist_node dq_hash;	/* Hash list in memory */
 	struct list_head dq_inuse;	/* List of all quotas */
 	struct list_head dq_free;	/* Free list element */
+	struct list_head dq_dirty;	/* List of dirty dquots */
 	struct semaphore dq_lock;	/* dquot IO lock */
 	atomic_t dq_count;		/* Use count */
 	wait_queue_head_t dq_wait_unused;	/* Wait queue for dquot to become unused */

--GRPZ8SYKNexpdSJ7--
