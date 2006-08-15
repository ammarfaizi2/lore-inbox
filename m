Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965224AbWHOTUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965224AbWHOTUj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 15:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965219AbWHOTUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 15:20:39 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:48569 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S965224AbWHOTUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 15:20:35 -0400
Date: Tue, 15 Aug 2006 12:20:06 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Andrew Morton <akpm@osdl.org>, gregkh@suse.de
Cc: Linus Torvalds <torvalds@osdl.org>, ocfs2-devel@oss.oracle.com,
       linux-kernel@vger.kernel.org
Subject: [git patches] ocfs2 updates
Message-ID: <20060815192006.GJ10876@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This set of patches includes a few dlm related fixes from Kurt, and a small,
trivial cleanup by Adrian.

Also included are three disk allocation patches by me - two fixes and one
incremental improvement in our allocation strategy. These have been around
since early June, so I think they've had enough testing that they can go
upstream.

Please pull from 'upstream-linus' branch of
git://git.kernel.org/pub/scm/linux/kernel/git/mfasheh/ocfs2.git

to receive the following updates:

 fs/ocfs2/dlm/dlmmaster.c |    1 
 fs/ocfs2/dlm/dlmunlock.c |   43 +++----
 fs/ocfs2/localalloc.c    |    8 +
 fs/ocfs2/ocfs2.h         |    2 
 fs/ocfs2/suballoc.c      |  261 +++++++++++++++++++++++++++++++++++++++++------
 fs/ocfs2/suballoc.h      |    2 
 fs/ocfs2/super.c         |    8 +
 7 files changed, 263 insertions(+), 62 deletions(-)

Adrian Bunk:
      fs/ocfs2/dlm/dlmmaster.c: unexport dlm_migrate_lockres

Kurt Hackel:
      ocfs2: Fix lvb corruption
      ocfs2: do not modify lksb->status in the unlock ast
      ocfs2: fix check for locally granted state during dlmunlock()

Mark Fasheh:
      ocfs2: limit cluster bitmap information saved at mount
      ocfs2: better group descriptor consistency checks
      ocfs2: allocation hints

diff --git a/fs/ocfs2/dlm/dlmmaster.c b/fs/ocfs2/dlm/dlmmaster.c
index 1b8346d..9503240 100644
--- a/fs/ocfs2/dlm/dlmmaster.c
+++ b/fs/ocfs2/dlm/dlmmaster.c
@@ -2375,7 +2375,6 @@ leave:
 	mlog(0, "returning %d\n", ret);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(dlm_migrate_lockres);
 
 int dlm_lock_basts_flushed(struct dlm_ctxt *dlm, struct dlm_lock *lock)
 {
diff --git a/fs/ocfs2/dlm/dlmunlock.c b/fs/ocfs2/dlm/dlmunlock.c
index b0c3134..37be4b2 100644
--- a/fs/ocfs2/dlm/dlmunlock.c
+++ b/fs/ocfs2/dlm/dlmunlock.c
@@ -155,7 +155,7 @@ static enum dlm_status dlmunlock_common(
 	else
 		status = dlm_get_unlock_actions(dlm, res, lock, lksb, &actions);
 
-	if (status != DLM_NORMAL)
+	if (status != DLM_NORMAL && (status != DLM_CANCELGRANT || !master_node))
 		goto leave;
 
 	/* By now this has been masked out of cancel requests. */
@@ -183,8 +183,7 @@ static enum dlm_status dlmunlock_common(
 		spin_lock(&lock->spinlock);
 		/* if the master told us the lock was already granted,
 		 * let the ast handle all of these actions */
-		if (status == DLM_NORMAL &&
-		    lksb->status == DLM_CANCELGRANT) {
+		if (status == DLM_CANCELGRANT) {
 			actions &= ~(DLM_UNLOCK_REMOVE_LOCK|
 				     DLM_UNLOCK_REGRANT_LOCK|
 				     DLM_UNLOCK_CLEAR_CONVERT_TYPE);
@@ -349,14 +348,9 @@ static enum dlm_status dlm_send_remote_u
 					vec, veclen, owner, &status);
 	if (tmpret >= 0) {
 		// successfully sent and received
-		if (status == DLM_CANCELGRANT)
-			ret = DLM_NORMAL;
-		else if (status == DLM_FORWARD) {
+		if (status == DLM_FORWARD)
 			mlog(0, "master was in-progress.  retry\n");
-			ret = DLM_FORWARD;
-		} else
-			ret = status;
-		lksb->status = status;
+		ret = status;
 	} else {
 		mlog_errno(tmpret);
 		if (dlm_is_host_down(tmpret)) {
@@ -372,7 +366,6 @@ static enum dlm_status dlm_send_remote_u
 			/* something bad.  this will BUG in ocfs2 */
 			ret = dlm_err_to_dlm_status(tmpret);
 		}
-		lksb->status = ret;
 	}
 
 	return ret;
@@ -483,6 +476,10 @@ int dlm_unlock_lock_handler(struct o2net
 
 	/* lock was found on queue */
 	lksb = lock->lksb;
+	if (flags & (LKM_VALBLK|LKM_PUT_LVB) &&
+	    lock->ml.type != LKM_EXMODE)
+		flags &= ~(LKM_VALBLK|LKM_PUT_LVB);
+
 	/* unlockast only called on originating node */
 	if (flags & LKM_PUT_LVB) {
 		lksb->flags |= DLM_LKSB_PUT_LVB;
@@ -507,11 +504,8 @@ not_found:
 			       "cookie=%u:%llu\n",
 			       dlm_get_lock_cookie_node(unlock->cookie),
 			       dlm_get_lock_cookie_seq(unlock->cookie));
-	else {
-		/* send the lksb->status back to the other node */
-		status = lksb->status;
+	else
 		dlm_lock_put(lock);
-	}
 
 leave:
 	if (res)
@@ -533,26 +527,22 @@ static enum dlm_status dlm_get_cancel_ac
 
 	if (dlm_lock_on_list(&res->blocked, lock)) {
 		/* cancel this outright */
-		lksb->status = DLM_NORMAL;
 		status = DLM_NORMAL;
 		*actions = (DLM_UNLOCK_CALL_AST |
 			    DLM_UNLOCK_REMOVE_LOCK);
 	} else if (dlm_lock_on_list(&res->converting, lock)) {
 		/* cancel the request, put back on granted */
-		lksb->status = DLM_NORMAL;
 		status = DLM_NORMAL;
 		*actions = (DLM_UNLOCK_CALL_AST |
 			    DLM_UNLOCK_REMOVE_LOCK |
 			    DLM_UNLOCK_REGRANT_LOCK |
 			    DLM_UNLOCK_CLEAR_CONVERT_TYPE);
 	} else if (dlm_lock_on_list(&res->granted, lock)) {
-		/* too late, already granted.  DLM_CANCELGRANT */
-		lksb->status = DLM_CANCELGRANT;
-		status = DLM_NORMAL;
+		/* too late, already granted. */
+		status = DLM_CANCELGRANT;
 		*actions = DLM_UNLOCK_CALL_AST;
 	} else {
 		mlog(ML_ERROR, "lock to cancel is not on any list!\n");
-		lksb->status = DLM_IVLOCKID;
 		status = DLM_IVLOCKID;
 		*actions = 0;
 	}
@@ -569,13 +559,11 @@ static enum dlm_status dlm_get_unlock_ac
 
 	/* unlock request */
 	if (!dlm_lock_on_list(&res->granted, lock)) {
-		lksb->status = DLM_DENIED;
 		status = DLM_DENIED;
 		dlm_error(status);
 		*actions = 0;
 	} else {
 		/* unlock granted lock */
-		lksb->status = DLM_NORMAL;
 		status = DLM_NORMAL;
 		*actions = (DLM_UNLOCK_FREE_LOCK |
 			    DLM_UNLOCK_CALL_AST |
@@ -632,6 +620,8 @@ retry:
 
 	spin_lock(&res->spinlock);
 	is_master = (res->owner == dlm->node_num);
+	if (flags & LKM_VALBLK && lock->ml.type != LKM_EXMODE)
+		flags &= ~LKM_VALBLK;
 	spin_unlock(&res->spinlock);
 
 	if (is_master) {
@@ -665,7 +655,7 @@ retry:
 	}
 
 	if (call_ast) {
-		mlog(0, "calling unlockast(%p, %d)\n", data, lksb->status);
+		mlog(0, "calling unlockast(%p, %d)\n", data, status);
 		if (is_master) {
 			/* it is possible that there is one last bast 
 			 * pending.  make sure it is flushed, then
@@ -677,9 +667,12 @@ retry:
 			wait_event(dlm->ast_wq, 
 				   dlm_lock_basts_flushed(dlm, lock));
 		}
-		(*unlockast)(data, lksb->status);
+		(*unlockast)(data, status);
 	}
 
+	if (status == DLM_CANCELGRANT)
+		status = DLM_NORMAL;
+
 	if (status == DLM_NORMAL) {
 		mlog(0, "kicking the thread\n");
 		dlm_kick_thread(dlm, res);
diff --git a/fs/ocfs2/localalloc.c b/fs/ocfs2/localalloc.c
index 0d1973e..1f17a4d 100644
--- a/fs/ocfs2/localalloc.c
+++ b/fs/ocfs2/localalloc.c
@@ -840,6 +840,12 @@ static int ocfs2_local_alloc_new_window(
 
 	mlog(0, "Allocating %u clusters for a new window.\n",
 	     ocfs2_local_alloc_window_bits(osb));
+
+	/* Instruct the allocation code to try the most recently used
+	 * cluster group. We'll re-record the group used this pass
+	 * below. */
+	ac->ac_last_group = osb->la_last_gd;
+
 	/* we used the generic suballoc reserve function, but we set
 	 * everything up nicely, so there's no reason why we can't use
 	 * the more specific cluster api to claim bits. */
@@ -852,6 +858,8 @@ static int ocfs2_local_alloc_new_window(
 		goto bail;
 	}
 
+	osb->la_last_gd = ac->ac_last_group;
+
 	la->la_bm_off = cpu_to_le32(cluster_off);
 	alloc->id1.bitmap1.i_total = cpu_to_le32(cluster_count);
 	/* just in case... In the future when we find space ourselves,
diff --git a/fs/ocfs2/ocfs2.h b/fs/ocfs2/ocfs2.h
index cd4a6f2..0462a7f 100644
--- a/fs/ocfs2/ocfs2.h
+++ b/fs/ocfs2/ocfs2.h
@@ -197,7 +197,6 @@ struct ocfs2_super
 	struct ocfs2_node_map recovery_map;
 	struct ocfs2_node_map umount_map;
 
-	u32 num_clusters;
 	u64 root_blkno;
 	u64 system_dir_blkno;
 	u64 bitmap_blkno;
@@ -237,6 +236,7 @@ struct ocfs2_super
 
 	enum ocfs2_local_alloc_state local_alloc_state;
 	struct buffer_head *local_alloc_bh;
+	u64 la_last_gd;
 
 	/* Next two fields are for local node slot recovery during
 	 * mount. */
diff --git a/fs/ocfs2/suballoc.c b/fs/ocfs2/suballoc.c
index 1955230..9d91e66 100644
--- a/fs/ocfs2/suballoc.c
+++ b/fs/ocfs2/suballoc.c
@@ -70,12 +70,6 @@ static int ocfs2_block_group_search(stru
 				    struct buffer_head *group_bh,
 				    u32 bits_wanted, u32 min_bits,
 				    u16 *bit_off, u16 *bits_found);
-static int ocfs2_search_chain(struct ocfs2_alloc_context *ac,
-			      u32 bits_wanted,
-			      u32 min_bits,
-			      u16 *bit_off,
-			      unsigned int *num_bits,
-			      u64 *bg_blkno);
 static int ocfs2_claim_suballoc_bits(struct ocfs2_super *osb,
 				     struct ocfs2_alloc_context *ac,
 				     u32 bits_wanted,
@@ -85,11 +79,6 @@ static int ocfs2_claim_suballoc_bits(str
 				     u64 *bg_blkno);
 static int ocfs2_test_bg_bit_allocatable(struct buffer_head *bg_bh,
 					 int nr);
-static int ocfs2_block_group_find_clear_bits(struct ocfs2_super *osb,
-					     struct buffer_head *bg_bh,
-					     unsigned int bits_wanted,
-					     u16 *bit_off,
-					     u16 *bits_found);
 static inline int ocfs2_block_group_set_bits(struct ocfs2_journal_handle *handle,
 					     struct inode *alloc_inode,
 					     struct ocfs2_group_desc *bg,
@@ -143,6 +132,64 @@ static u32 ocfs2_bits_per_group(struct o
 	return (u32)le16_to_cpu(cl->cl_cpg) * (u32)le16_to_cpu(cl->cl_bpc);
 }
 
+/* somewhat more expensive than our other checks, so use sparingly. */
+static int ocfs2_check_group_descriptor(struct super_block *sb,
+					struct ocfs2_dinode *di,
+					struct ocfs2_group_desc *gd)
+{
+	unsigned int max_bits;
+
+	if (!OCFS2_IS_VALID_GROUP_DESC(gd)) {
+		OCFS2_RO_ON_INVALID_GROUP_DESC(sb, gd);
+		return -EIO;
+	}
+
+	if (di->i_blkno != gd->bg_parent_dinode) {
+		ocfs2_error(sb, "Group descriptor # %llu has bad parent "
+			    "pointer (%llu, expected %llu)",
+			    (unsigned long long)le64_to_cpu(gd->bg_blkno),
+			    (unsigned long long)le64_to_cpu(gd->bg_parent_dinode),
+			    (unsigned long long)le64_to_cpu(di->i_blkno));
+		return -EIO;
+	}
+
+	max_bits = le16_to_cpu(di->id2.i_chain.cl_cpg) * le16_to_cpu(di->id2.i_chain.cl_bpc);
+	if (le16_to_cpu(gd->bg_bits) > max_bits) {
+		ocfs2_error(sb, "Group descriptor # %llu has bit count of %u",
+			    (unsigned long long)le64_to_cpu(gd->bg_blkno),
+			    le16_to_cpu(gd->bg_bits));
+		return -EIO;
+	}
+
+	if (le16_to_cpu(gd->bg_chain) >=
+	    le16_to_cpu(di->id2.i_chain.cl_next_free_rec)) {
+		ocfs2_error(sb, "Group descriptor # %llu has bad chain %u",
+			    (unsigned long long)le64_to_cpu(gd->bg_blkno),
+			    le16_to_cpu(gd->bg_chain));
+		return -EIO;
+	}
+
+	if (le16_to_cpu(gd->bg_free_bits_count) > le16_to_cpu(gd->bg_bits)) {
+		ocfs2_error(sb, "Group descriptor # %llu has bit count %u but "
+			    "claims that %u are free",
+			    (unsigned long long)le64_to_cpu(gd->bg_blkno),
+			    le16_to_cpu(gd->bg_bits),
+			    le16_to_cpu(gd->bg_free_bits_count));
+		return -EIO;
+	}
+
+	if (le16_to_cpu(gd->bg_bits) > (8 * le16_to_cpu(gd->bg_size))) {
+		ocfs2_error(sb, "Group descriptor # %llu has bit count %u but "
+			    "max bitmap bits of %u",
+			    (unsigned long long)le64_to_cpu(gd->bg_blkno),
+			    le16_to_cpu(gd->bg_bits),
+			    8 * le16_to_cpu(gd->bg_size));
+		return -EIO;
+	}
+
+	return 0;
+}
+
 static int ocfs2_block_group_fill(struct ocfs2_journal_handle *handle,
 				  struct inode *alloc_inode,
 				  struct buffer_head *bg_bh,
@@ -663,6 +710,7 @@ static int ocfs2_test_bg_bit_allocatable
 static int ocfs2_block_group_find_clear_bits(struct ocfs2_super *osb,
 					     struct buffer_head *bg_bh,
 					     unsigned int bits_wanted,
+					     unsigned int total_bits,
 					     u16 *bit_off,
 					     u16 *bits_found)
 {
@@ -679,10 +727,8 @@ static int ocfs2_block_group_find_clear_
 	found = start = best_offset = best_size = 0;
 	bitmap = bg->bg_bitmap;
 
-	while((offset = ocfs2_find_next_zero_bit(bitmap,
-						 le16_to_cpu(bg->bg_bits),
-						 start)) != -1) {
-		if (offset == le16_to_cpu(bg->bg_bits))
+	while((offset = ocfs2_find_next_zero_bit(bitmap, total_bits, start)) != -1) {
+		if (offset == total_bits)
 			break;
 
 		if (!ocfs2_test_bg_bit_allocatable(bg_bh, offset)) {
@@ -911,14 +957,35 @@ static int ocfs2_cluster_group_search(st
 {
 	int search = -ENOSPC;
 	int ret;
-	struct ocfs2_group_desc *bg = (struct ocfs2_group_desc *) group_bh->b_data;
+	struct ocfs2_group_desc *gd = (struct ocfs2_group_desc *) group_bh->b_data;
 	u16 tmp_off, tmp_found;
+	unsigned int max_bits, gd_cluster_off;
 
 	BUG_ON(!ocfs2_is_cluster_bitmap(inode));
 
-	if (bg->bg_free_bits_count) {
+	if (gd->bg_free_bits_count) {
+		max_bits = le16_to_cpu(gd->bg_bits);
+
+		/* Tail groups in cluster bitmaps which aren't cpg
+		 * aligned are prone to partial extention by a failed
+		 * fs resize. If the file system resize never got to
+		 * update the dinode cluster count, then we don't want
+		 * to trust any clusters past it, regardless of what
+		 * the group descriptor says. */
+		gd_cluster_off = ocfs2_blocks_to_clusters(inode->i_sb,
+							  le64_to_cpu(gd->bg_blkno));
+		if ((gd_cluster_off + max_bits) >
+		    OCFS2_I(inode)->ip_clusters) {
+			max_bits = OCFS2_I(inode)->ip_clusters - gd_cluster_off;
+			mlog(0, "Desc %llu, bg_bits %u, clusters %u, use %u\n",
+			     (unsigned long long)le64_to_cpu(gd->bg_blkno),
+			     le16_to_cpu(gd->bg_bits),
+			     OCFS2_I(inode)->ip_clusters, max_bits);
+		}
+
 		ret = ocfs2_block_group_find_clear_bits(OCFS2_SB(inode->i_sb),
 							group_bh, bits_wanted,
+							max_bits,
 							&tmp_off, &tmp_found);
 		if (ret)
 			return ret;
@@ -951,17 +1018,109 @@ static int ocfs2_block_group_search(stru
 	if (bg->bg_free_bits_count)
 		ret = ocfs2_block_group_find_clear_bits(OCFS2_SB(inode->i_sb),
 							group_bh, bits_wanted,
+							le16_to_cpu(bg->bg_bits),
 							bit_off, bits_found);
 
 	return ret;
 }
 
+static int ocfs2_alloc_dinode_update_counts(struct inode *inode,
+				       struct ocfs2_journal_handle *handle,
+				       struct buffer_head *di_bh,
+				       u32 num_bits,
+				       u16 chain)
+{
+	int ret;
+	u32 tmp_used;
+	struct ocfs2_dinode *di = (struct ocfs2_dinode *) di_bh->b_data;
+	struct ocfs2_chain_list *cl = (struct ocfs2_chain_list *) &di->id2.i_chain;
+
+	ret = ocfs2_journal_access(handle, inode, di_bh,
+				   OCFS2_JOURNAL_ACCESS_WRITE);
+	if (ret < 0) {
+		mlog_errno(ret);
+		goto out;
+	}
+
+	tmp_used = le32_to_cpu(di->id1.bitmap1.i_used);
+	di->id1.bitmap1.i_used = cpu_to_le32(num_bits + tmp_used);
+	le32_add_cpu(&cl->cl_recs[chain].c_free, -num_bits);
+
+	ret = ocfs2_journal_dirty(handle, di_bh);
+	if (ret < 0)
+		mlog_errno(ret);
+
+out:
+	return ret;
+}
+
+static int ocfs2_search_one_group(struct ocfs2_alloc_context *ac,
+				  u32 bits_wanted,
+				  u32 min_bits,
+				  u16 *bit_off,
+				  unsigned int *num_bits,
+				  u64 gd_blkno,
+				  u16 *bits_left)
+{
+	int ret;
+	u16 found;
+	struct buffer_head *group_bh = NULL;
+	struct ocfs2_group_desc *gd;
+	struct inode *alloc_inode = ac->ac_inode;
+	struct ocfs2_journal_handle *handle = ac->ac_handle;
+
+	ret = ocfs2_read_block(OCFS2_SB(alloc_inode->i_sb), gd_blkno,
+			       &group_bh, OCFS2_BH_CACHED, alloc_inode);
+	if (ret < 0) {
+		mlog_errno(ret);
+		return ret;
+	}
+
+	gd = (struct ocfs2_group_desc *) group_bh->b_data;
+	if (!OCFS2_IS_VALID_GROUP_DESC(gd)) {
+		OCFS2_RO_ON_INVALID_GROUP_DESC(alloc_inode->i_sb, gd);
+		ret = -EIO;
+		goto out;
+	}
+
+	ret = ac->ac_group_search(alloc_inode, group_bh, bits_wanted, min_bits,
+				  bit_off, &found);
+	if (ret < 0) {
+		if (ret != -ENOSPC)
+			mlog_errno(ret);
+		goto out;
+	}
+
+	*num_bits = found;
+
+	ret = ocfs2_alloc_dinode_update_counts(alloc_inode, handle, ac->ac_bh,
+					       *num_bits,
+					       le16_to_cpu(gd->bg_chain));
+	if (ret < 0) {
+		mlog_errno(ret);
+		goto out;
+	}
+
+	ret = ocfs2_block_group_set_bits(handle, alloc_inode, gd, group_bh,
+					 *bit_off, *num_bits);
+	if (ret < 0)
+		mlog_errno(ret);
+
+	*bits_left = le16_to_cpu(gd->bg_free_bits_count);
+
+out:
+	brelse(group_bh);
+
+	return ret;
+}
+
 static int ocfs2_search_chain(struct ocfs2_alloc_context *ac,
 			      u32 bits_wanted,
 			      u32 min_bits,
 			      u16 *bit_off,
 			      unsigned int *num_bits,
-			      u64 *bg_blkno)
+			      u64 *bg_blkno,
+			      u16 *bits_left)
 {
 	int status;
 	u16 chain, tmp_bits;
@@ -988,9 +1147,9 @@ static int ocfs2_search_chain(struct ocf
 		goto bail;
 	}
 	bg = (struct ocfs2_group_desc *) group_bh->b_data;
-	if (!OCFS2_IS_VALID_GROUP_DESC(bg)) {
-		OCFS2_RO_ON_INVALID_GROUP_DESC(alloc_inode->i_sb, bg);
-		status = -EIO;
+	status = ocfs2_check_group_descriptor(alloc_inode->i_sb, fe, bg);
+	if (status) {
+		mlog_errno(status);
 		goto bail;
 	}
 
@@ -1018,9 +1177,9 @@ static int ocfs2_search_chain(struct ocf
 			goto bail;
 		}
 		bg = (struct ocfs2_group_desc *) group_bh->b_data;
-		if (!OCFS2_IS_VALID_GROUP_DESC(bg)) {
-			OCFS2_RO_ON_INVALID_GROUP_DESC(alloc_inode->i_sb, bg);
-			status = -EIO;
+		status = ocfs2_check_group_descriptor(alloc_inode->i_sb, fe, bg);
+		if (status) {
+			mlog_errno(status);
 			goto bail;
 		}
 	}
@@ -1099,6 +1258,7 @@ static int ocfs2_search_chain(struct ocf
 	     (unsigned long long)fe->i_blkno);
 
 	*bg_blkno = le64_to_cpu(bg->bg_blkno);
+	*bits_left = le16_to_cpu(bg->bg_free_bits_count);
 bail:
 	if (group_bh)
 		brelse(group_bh);
@@ -1120,6 +1280,8 @@ static int ocfs2_claim_suballoc_bits(str
 {
 	int status;
 	u16 victim, i;
+	u16 bits_left = 0;
+	u64 hint_blkno = ac->ac_last_group;
 	struct ocfs2_chain_list *cl;
 	struct ocfs2_dinode *fe;
 
@@ -1146,6 +1308,28 @@ static int ocfs2_claim_suballoc_bits(str
 		goto bail;
 	}
 
+	if (hint_blkno) {
+		/* Attempt to short-circuit the usual search mechanism
+		 * by jumping straight to the most recently used
+		 * allocation group. This helps us mantain some
+		 * contiguousness across allocations. */
+		status = ocfs2_search_one_group(ac, bits_wanted, min_bits,
+						bit_off, num_bits,
+						hint_blkno, &bits_left);
+		if (!status) {
+			/* Be careful to update *bg_blkno here as the
+			 * caller is expecting it to be filled in, and
+			 * ocfs2_search_one_group() won't do that for
+			 * us. */
+			*bg_blkno = hint_blkno;
+			goto set_hint;
+		}
+		if (status < 0 && status != -ENOSPC) {
+			mlog_errno(status);
+			goto bail;
+		}
+	}
+
 	cl = (struct ocfs2_chain_list *) &fe->id2.i_chain;
 
 	victim = ocfs2_find_victim_chain(cl);
@@ -1153,9 +1337,9 @@ static int ocfs2_claim_suballoc_bits(str
 	ac->ac_allow_chain_relink = 1;
 
 	status = ocfs2_search_chain(ac, bits_wanted, min_bits, bit_off,
-				    num_bits, bg_blkno);
+				    num_bits, bg_blkno, &bits_left);
 	if (!status)
-		goto bail;
+		goto set_hint;
 	if (status < 0 && status != -ENOSPC) {
 		mlog_errno(status);
 		goto bail;
@@ -1177,8 +1361,8 @@ static int ocfs2_claim_suballoc_bits(str
 
 		ac->ac_chain = i;
 		status = ocfs2_search_chain(ac, bits_wanted, min_bits,
-					    bit_off, num_bits,
-					    bg_blkno);
+					    bit_off, num_bits, bg_blkno,
+					    &bits_left);
 		if (!status)
 			break;
 		if (status < 0 && status != -ENOSPC) {
@@ -1186,8 +1370,19 @@ static int ocfs2_claim_suballoc_bits(str
 			goto bail;
 		}
 	}
-bail:
 
+set_hint:
+	if (status != -ENOSPC) {
+		/* If the next search of this group is not likely to
+		 * yield a suitable extent, then we reset the last
+		 * group hint so as to not waste a disk read */
+		if (bits_left < min_bits)
+			ac->ac_last_group = 0;
+		else
+			ac->ac_last_group = *bg_blkno;
+	}
+
+bail:
 	mlog_exit(status);
 	return status;
 }
@@ -1341,7 +1536,7 @@ int ocfs2_claim_clusters(struct ocfs2_su
 {
 	int status;
 	unsigned int bits_wanted = ac->ac_bits_wanted - ac->ac_bits_given;
-	u64 bg_blkno;
+	u64 bg_blkno = 0;
 	u16 bg_bit_off;
 
 	mlog_entry_void();
@@ -1494,9 +1689,9 @@ static int ocfs2_free_suballoc_bits(stru
 	}
 
 	group = (struct ocfs2_group_desc *) group_bh->b_data;
-	if (!OCFS2_IS_VALID_GROUP_DESC(group)) {
-		OCFS2_RO_ON_INVALID_GROUP_DESC(alloc_inode->i_sb, group);
-		status = -EIO;
+	status = ocfs2_check_group_descriptor(alloc_inode->i_sb, fe, group);
+	if (status) {
+		mlog_errno(status);
 		goto bail;
 	}
 	BUG_ON((count + start_bit) > le16_to_cpu(group->bg_bits));
diff --git a/fs/ocfs2/suballoc.h b/fs/ocfs2/suballoc.h
index a76c82a..c787838 100644
--- a/fs/ocfs2/suballoc.h
+++ b/fs/ocfs2/suballoc.h
@@ -49,6 +49,8 @@ #define OCFS2_AC_USE_META  4
 	u16    ac_chain;
 	int    ac_allow_chain_relink;
 	group_search_t *ac_group_search;
+
+	u64    ac_last_group;
 };
 
 void ocfs2_free_alloc_context(struct ocfs2_alloc_context *ac);
diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index 382706a..d17e33e 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -1442,8 +1442,13 @@ static int ocfs2_initialize_super(struct
 
 	osb->bitmap_blkno = OCFS2_I(inode)->ip_blkno;
 
+	/* We don't have a cluster lock on the bitmap here because
+	 * we're only interested in static information and the extra
+	 * complexity at mount time isn't worht it. Don't pass the
+	 * inode in to the read function though as we don't want it to
+	 * be put in the cache. */
 	status = ocfs2_read_block(osb, osb->bitmap_blkno, &bitmap_bh, 0,
-				  inode);
+				  NULL);
 	iput(inode);
 	if (status < 0) {
 		mlog_errno(status);
@@ -1452,7 +1457,6 @@ static int ocfs2_initialize_super(struct
 
 	di = (struct ocfs2_dinode *) bitmap_bh->b_data;
 	osb->bitmap_cpg = le16_to_cpu(di->id2.i_chain.cl_cpg);
-	osb->num_clusters = le32_to_cpu(di->id1.bitmap1.i_total);
 	brelse(bitmap_bh);
 	mlog(0, "cluster bitmap inode: %llu, clusters per group: %u\n",
 	     (unsigned long long)osb->bitmap_blkno, osb->bitmap_cpg);
