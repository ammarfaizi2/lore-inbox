Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbUCQR5Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 12:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbUCQR5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 12:57:24 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:5073 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261735AbUCQR4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 12:56:44 -0500
Date: Wed, 17 Mar 2004 18:56:43 +0100
From: Jan Kara <jack@ucw.cz>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Quota locking
Message-ID: <20040317175643.GA25337@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hi Andrew!

  I've extracted the locking changes from journalled quota patch
relevant for vanilla kernel (basically fixes the lock ordering in some
cases). The patch also includes documentation of the quota locking. The
patch is not trivial so are you willing to accept it in the vanilla
kernel?
					Thanks for reply
							Honza

--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="quota-2.6.4-1-lockfix.diff"

diff -ruX /home/jack/.kerndiffexclude linux-2.6.4/fs/dquot.c linux-2.6.4-1-lockfix/fs/dquot.c
--- linux-2.6.4/fs/dquot.c	2004-03-04 09:26:37.000000000 +0100
+++ linux-2.6.4-1-lockfix/fs/dquot.c	2004-03-17 10:37:23.641710648 +0100
@@ -85,12 +85,31 @@
  * and quota formats and also dqstats structure containing statistics about the
  * lists. dq_data_lock protects data from dq_dqb and also mem_dqinfo structures
  * and also guards consistency of dquot->dq_dqb with inode->i_blocks, i_bytes.
- * Note that we don't have to do the locking of i_blocks and i_bytes when the
- * quota is disabled - i_sem should serialize the access. dq_data_lock should
- * be always grabbed before dq_list_lock.
+ * i_blocks and i_bytes updates itself are guarded by i_lock acquired directly
+ * in inode_add_bytes() and inode_sub_bytes().
+ *
+ * The spinlock ordering is hence: dq_data_lock > dq_list_lock > i_lock
  *
  * Note that some things (eg. sb pointer, type, id) doesn't change during
  * the life of the dquot structure and so needn't to be protected by a lock
+ *
+ * Any operation working on dquots via inode pointers must hold dqptr_sem.  If
+ * operation is just reading pointers from inode (or not using them at all) the
+ * read lock is enough. If pointers are altered function must hold write lock.
+ * If operation is holding reference to dquot in other way (e.g. quotactl ops)
+ * it must be guarded by dqonoff_sem.
+ * This locking assures that:
+ *   a) update/access to dquot pointers in inode is serialized
+ *   b) everyone is guarded against invalidate_dquots()
+ *
+ * Each dquot has its dq_lock semaphore. Locked dquots might not be referenced
+ * from inodes (dquot_alloc_space() and such don't check the dq_lock).
+ * Currently dquot is locked only when it is being read to memory on the first
+ * dqget(). Write operations on dquots don't hold dq_lock as they copy data
+ * under dq_data_lock spinlock to internal buffers before writing.
+ *
+ * Lock ordering (including journal_lock) is following:
+ *  dqonoff_sem > journal_lock > dqptr_sem > dquot->dq_lock > dqio_sem
  */
 spinlock_t dq_list_lock = SPIN_LOCK_UNLOCKED;
 spinlock_t dq_data_lock = SPIN_LOCK_UNLOCKED;
@@ -169,23 +188,6 @@
  * mechanism to locate a specific dquot.
  */
 
-/*
- * Note that any operation which operates on dquot data (ie. dq_dqb) must
- * hold dq_data_lock.
- *
- * Any operation working with dquots must hold dqptr_sem. If operation is
- * just reading pointers from inodes than read lock is enough. If pointers
- * are altered function must hold write lock.
- *
- * Locked dquots might not be referenced in inodes. Currently dquot it locked
- * only once in its existence - when it's being read to memory on first dqget()
- * and at that time it can't be referenced from inode. Write operations on
- * dquots don't hold dquot lock as they copy data to internal buffers before
- * writing anyway and copying as well as any data update should be atomic. Also
- * nobody can change used entries in dquot structure as this is done only when
- * quota is destroyed and invalidate_dquots() is called only when dq_count == 0.
- */
-
 static LIST_HEAD(inuse_list);
 static LIST_HEAD(free_dquots);
 static struct list_head dquot_hash[NR_DQHASH];
@@ -286,9 +288,9 @@
 }
 
 /* Invalidate all dquots on the list. Note that this function is called after
- * quota is disabled so no new quota might be created. Because we hold dqptr_sem
- * for writing and pointers were already removed from inodes we actually know that
- * no quota for this sb+type should be held. */
+ * quota is disabled so no new quota might be created. Because we hold
+ * dqonoff_sem and pointers were already removed from inodes we actually know
+ * that no quota for this sb+type should be held. */
 static void invalidate_dquots(struct super_block *sb, int type)
 {
 	struct dquot *dquot;
@@ -303,7 +305,6 @@
 		if (dquot->dq_type != type)
 			continue;
 #ifdef __DQUOT_PARANOIA	
-		/* There should be no users of quota - we hold dqptr_sem for writing */
 		if (atomic_read(&dquot->dq_count))
 			BUG();
 #endif
@@ -323,7 +324,7 @@
 	struct quota_info *dqopt = sb_dqopt(sb);
 	int cnt;
 
-	down_read(&dqopt->dqptr_sem);
+	down(&dqopt->dqonoff_sem);
 restart:
 	/* At this point any dirty dquot will definitely be written so we can clear
 	   dirty flag from info */
@@ -359,7 +360,7 @@
 	spin_lock(&dq_list_lock);
 	dqstats.syncs++;
 	spin_unlock(&dq_list_lock);
-	up_read(&dqopt->dqptr_sem);
+	up(&dqopt->dqonoff_sem);
 
 	return 0;
 }
@@ -402,7 +403,7 @@
 /*
  * Put reference to dquot
  * NOTE: If you change this function please check whether dqput_blocks() works right...
- * MUST be called with dqptr_sem held
+ * MUST be called with either dqptr_sem or dqonoff_sem held
  */
 static void dqput(struct dquot *dquot)
 {
@@ -467,7 +468,7 @@
 
 /*
  * Get reference to dquot
- * MUST be called with dqptr_sem held
+ * MUST be called with either dqptr_sem or dqonoff_sem held
  */
 static struct dquot *dqget(struct super_block *sb, unsigned int id, int type)
 {
@@ -528,7 +529,7 @@
 	return 0;
 }
 
-/* This routine is guarded by dqptr_sem semaphore */
+/* This routine is guarded by dqonoff_sem semaphore */
 static void add_dquot_ref(struct super_block *sb, int type)
 {
 	struct list_head *p;
@@ -594,7 +595,7 @@
 
 /* Free list of dquots - called from inode.c */
 /* dquots are removed from inodes, no new references can be got so we are the only ones holding reference */
-void put_dquot_list(struct list_head *tofree_head)
+static void put_dquot_list(struct list_head *tofree_head)
 {
 	struct list_head *act_head;
 	struct dquot *dquot;
@@ -609,6 +610,20 @@
 	}
 }
 
+/* Function in inode.c - remove pointers to dquots in icache */
+extern void remove_dquot_ref(struct super_block *, int, struct list_head *);
+
+/* Gather all references from inodes and drop them */
+static void drop_dquot_ref(struct super_block *sb, int type)
+{
+	LIST_HEAD(tofree_head);
+
+	down_write(&sb_dqopt(sb)->dqptr_sem);
+	remove_dquot_ref(sb, type, &tofree_head);
+	up_write(&sb_dqopt(sb)->dqptr_sem);
+	put_dquot_list(&tofree_head);
+}
+
 static inline void dquot_incr_inodes(struct dquot *dquot, unsigned long number)
 {
 	dquot->dq_dqb.dqb_curinodes += number;
@@ -804,6 +819,9 @@
 	unsigned int id = 0;
 	int cnt;
 
+	/* Solve deadlock when we recurse when holding dqptr_sem... */
+	if (IS_NOQUOTA(inode))
+		return;
 	down_write(&sb_dqopt(inode->i_sb)->dqptr_sem);
 	/* Having dqptr_sem we know NOQUOTA flags can't be altered... */
 	if (IS_NOQUOTA(inode)) {
@@ -832,49 +850,22 @@
 }
 
 /*
- *	Remove references to quota from inode
- *	This function needs dqptr_sem for writing
- */
-static void dquot_drop_iupdate(struct inode *inode, struct dquot **to_drop)
-{
-	int cnt;
-
-	inode->i_flags &= ~S_QUOTA;
-	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
-		to_drop[cnt] = inode->i_dquot[cnt];
-		inode->i_dquot[cnt] = NODQUOT;
-	}
-}
-
-/*
  * 	Release all quotas referenced by inode
+ *	Needs dqonoff_sem to guard dqput()
  */
 void dquot_drop(struct inode *inode)
 {
-	struct dquot *to_drop[MAXQUOTAS];
 	int cnt;
 
 	down_write(&sb_dqopt(inode->i_sb)->dqptr_sem);
-	dquot_drop_iupdate(inode, to_drop);
+	inode->i_flags &= ~S_QUOTA;
+	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
+		if (inode->i_dquot[cnt] != NODQUOT) {
+			dqput(inode->i_dquot[cnt]);
+			inode->i_dquot[cnt] = NODQUOT;
+		}
+	}
 	up_write(&sb_dqopt(inode->i_sb)->dqptr_sem);
-	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
-		if (to_drop[cnt] != NODQUOT)
-			dqput(to_drop[cnt]);
-}
-
-/*
- *	Release all quotas referenced by inode.
- *	This function assumes dqptr_sem for writing
- */
-void dquot_drop_nolock(struct inode *inode)
-{
-	struct dquot *to_drop[MAXQUOTAS];
-	int cnt;
-
-	dquot_drop_iupdate(inode, to_drop);
-	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
-		if (to_drop[cnt] != NODQUOT)
-			dqput(to_drop[cnt]);
 }
 
 /*
@@ -885,11 +876,17 @@
 	int cnt, ret = NO_QUOTA;
 	char warntype[MAXQUOTAS];
 
+	/* Solve deadlock when we recurse when holding dqptr_sem... */
+	if (IS_NOQUOTA(inode)) {
+		inode_add_bytes(inode, number);
+		return QUOTA_OK;
+	}
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
 		warntype[cnt] = NOWARN;
 
 	down_read(&sb_dqopt(inode->i_sb)->dqptr_sem);
 	spin_lock(&dq_data_lock);
+	/* Now recheck reliably when holding dqptr_sem */
 	if (IS_NOQUOTA(inode))
 		goto add_bytes;
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
@@ -921,9 +918,13 @@
 	int cnt, ret = NO_QUOTA;
 	char warntype[MAXQUOTAS];
 
+	/* Solve deadlock when we recurse when holding dqptr_sem... */
+	if (IS_NOQUOTA(inode))
+		return QUOTA_OK;
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
 		warntype[cnt] = NOWARN;
 	down_read(&sb_dqopt(inode->i_sb)->dqptr_sem);
+	/* Now recheck reliably when holding dqptr_sem */
 	if (IS_NOQUOTA(inode)) {
 		up_read(&sb_dqopt(inode->i_sb)->dqptr_sem);
 		return QUOTA_OK;
@@ -956,8 +957,14 @@
 {
 	unsigned int cnt;
 
+	/* Solve deadlock when we recurse when holding dqptr_sem... */
+	if (IS_NOQUOTA(inode)) {
+		inode_add_bytes(inode, number);
+		return;
+	}
 	down_read(&sb_dqopt(inode->i_sb)->dqptr_sem);
 	spin_lock(&dq_data_lock);
+	/* Now recheck reliably when holding dqptr_sem */
 	if (IS_NOQUOTA(inode))
 		goto sub_bytes;
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
@@ -978,7 +985,11 @@
 {
 	unsigned int cnt;
 
+	/* Solve deadlock when we recurse when holding dqptr_sem... */
+	if (IS_NOQUOTA(inode))
+		return;
 	down_read(&sb_dqopt(inode->i_sb)->dqptr_sem);
+	/* Now recheck reliably when holding dqptr_sem */
 	if (IS_NOQUOTA(inode)) {
 		up_read(&sb_dqopt(inode->i_sb)->dqptr_sem);
 		return;
@@ -1007,14 +1018,20 @@
 	    chgid = (iattr->ia_valid & ATTR_GID) && inode->i_gid != iattr->ia_gid;
 	char warntype[MAXQUOTAS];
 
+	/* Solve deadlock when we recurse when holding dqptr_sem... */
+	if (IS_NOQUOTA(inode))
+		return QUOTA_OK;
 	/* Clear the arrays */
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
 		transfer_to[cnt] = transfer_from[cnt] = NODQUOT;
 		warntype[cnt] = NOWARN;
 	}
+	down(&sb_dqopt(inode->i_sb)->dqonoff_sem);
 	down_write(&sb_dqopt(inode->i_sb)->dqptr_sem);
+	/* Now recheck reliably when holding dqptr_sem */
 	if (IS_NOQUOTA(inode)) {	/* File without quota accounting? */
 		up_write(&sb_dqopt(inode->i_sb)->dqptr_sem);
+		up(&sb_dqopt(inode->i_sb)->dqonoff_sem);
 		return QUOTA_OK;
 	}
 	/* First build the transfer_to list - here we can block on reading of dquots... */
@@ -1065,6 +1082,7 @@
 	ret = QUOTA_OK;
 warn_put_all:
 	spin_unlock(&dq_data_lock);
+	up_write(&sb_dqopt(inode->i_sb)->dqptr_sem);
 	flush_warnings(transfer_to, warntype);
 	
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
@@ -1073,7 +1091,7 @@
 		if (ret == NO_QUOTA && transfer_to[cnt] != NODQUOT)
 			dqput(transfer_to[cnt]);
 	}
-	up_write(&sb_dqopt(inode->i_sb)->dqptr_sem);
+	up(&sb_dqopt(inode->i_sb)->dqonoff_sem);
 	return ret;
 }
 
@@ -1121,9 +1139,6 @@
 	}
 }
 
-/* Function in inode.c - remove pointers to dquots in icache */
-extern void remove_dquot_ref(struct super_block *, int);
-
 /*
  * Turn quota off on a device. type == -1 ==> quotaoff for all types (umount)
  */
@@ -1137,7 +1152,6 @@
 
 	/* We need to serialize quota_off() for device */
 	down(&dqopt->dqonoff_sem);
-	down_write(&dqopt->dqptr_sem);
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
 		if (type != -1 && cnt != type)
 			continue;
@@ -1146,7 +1160,7 @@
 		reset_enable_flags(dqopt, cnt);
 
 		/* Note: these are blocking operations */
-		remove_dquot_ref(sb, cnt);
+		drop_dquot_ref(sb, cnt);
 		invalidate_dquots(sb, cnt);
 		/*
 		 * Now all dquots should be invalidated, all writes done so we should be only
@@ -1168,7 +1182,6 @@
 		dqopt->info[cnt].dqi_bgrace = 0;
 		dqopt->ops[cnt] = NULL;
 	}
-	up_write(&dqopt->dqptr_sem);
 	up(&dqopt->dqonoff_sem);
 out:
 	return 0;
@@ -1180,7 +1193,8 @@
 	struct inode *inode;
 	struct quota_info *dqopt = sb_dqopt(sb);
 	struct quota_format_type *fmt = find_quota_format(format_id);
-	int error;
+	int error, cnt;
+	struct dquot *to_drop[MAXQUOTAS];
 	unsigned int oldflags;
 
 	if (!fmt)
@@ -1202,7 +1216,6 @@
 		goto out_f;
 
 	down(&dqopt->dqonoff_sem);
-	down_write(&dqopt->dqptr_sem);
 	if (sb_has_quota_enabled(sb, type)) {
 		error = -EBUSY;
 		goto out_lock;
@@ -1213,8 +1226,20 @@
 	if (!fmt->qf_ops->check_quota_file(sb, type))
 		goto out_file_init;
 	/* We don't want quota and atime on quota files (deadlocks possible) */
-	dquot_drop_nolock(inode);
+	down_write(&dqopt->dqptr_sem);
 	inode->i_flags |= S_NOQUOTA | S_NOATIME;
+	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
+		to_drop[cnt] = inode->i_dquot[cnt];
+		inode->i_dquot[cnt] = NODQUOT;
+	}
+	inode->i_flags &= ~S_QUOTA;
+	up_write(&dqopt->dqptr_sem);
+	/* We must put dquots outside of dqptr_sem because we may need to
+	 * start transaction for write */
+	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
+		if (to_drop[cnt])
+			dqput(to_drop[cnt]);
+	}
 
 	dqopt->ops[type] = fmt->qf_ops;
 	dqopt->info[type].dqi_format = fmt;
@@ -1225,7 +1250,6 @@
 	}
 	up(&dqopt->dqio_sem);
 	set_enable_flags(dqopt, type);
-	up_write(&dqopt->dqptr_sem);
 
 	add_dquot_ref(sb, type);
 	up(&dqopt->dqonoff_sem);
@@ -1268,14 +1292,14 @@
 {
 	struct dquot *dquot;
 
-	down_read(&sb_dqopt(sb)->dqptr_sem);
+	down(&sb_dqopt(sb)->dqonoff_sem);
 	if (!(dquot = dqget(sb, id, type))) {
-		up_read(&sb_dqopt(sb)->dqptr_sem);
+		up(&sb_dqopt(sb)->dqonoff_sem);
 		return -ESRCH;
 	}
 	do_get_dqblk(dquot, di);
 	dqput(dquot);
-	up_read(&sb_dqopt(sb)->dqptr_sem);
+	up(&sb_dqopt(sb)->dqonoff_sem);
 	return 0;
 }
 
@@ -1337,14 +1361,14 @@
 {
 	struct dquot *dquot;
 
-	down_read(&sb_dqopt(sb)->dqptr_sem);
+	down(&sb_dqopt(sb)->dqonoff_sem);
 	if (!(dquot = dqget(sb, id, type))) {
-		up_read(&sb_dqopt(sb)->dqptr_sem);
+		up(&sb_dqopt(sb)->dqonoff_sem);
 		return -ESRCH;
 	}
 	do_set_dqblk(dquot, di);
 	dqput(dquot);
-	up_read(&sb_dqopt(sb)->dqptr_sem);
+	up(&sb_dqopt(sb)->dqonoff_sem);
 	return 0;
 }
 
@@ -1353,9 +1377,9 @@
 {
 	struct mem_dqinfo *mi;
   
-	down_read(&sb_dqopt(sb)->dqptr_sem);
+	down(&sb_dqopt(sb)->dqonoff_sem);
 	if (!sb_has_quota_enabled(sb, type)) {
-		up_read(&sb_dqopt(sb)->dqptr_sem);
+		up(&sb_dqopt(sb)->dqonoff_sem);
 		return -ESRCH;
 	}
 	mi = sb_dqopt(sb)->info + type;
@@ -1365,7 +1389,7 @@
 	ii->dqi_flags = mi->dqi_flags & DQF_MASK;
 	ii->dqi_valid = IIF_ALL;
 	spin_unlock(&dq_data_lock);
-	up_read(&sb_dqopt(sb)->dqptr_sem);
+	up(&sb_dqopt(sb)->dqonoff_sem);
 	return 0;
 }
 
@@ -1374,9 +1398,9 @@
 {
 	struct mem_dqinfo *mi;
 
-	down_read(&sb_dqopt(sb)->dqptr_sem);
+	down(&sb_dqopt(sb)->dqonoff_sem);
 	if (!sb_has_quota_enabled(sb, type)) {
-		up_read(&sb_dqopt(sb)->dqptr_sem);
+		up(&sb_dqopt(sb)->dqonoff_sem);
 		return -ESRCH;
 	}
 	mi = sb_dqopt(sb)->info + type;
@@ -1389,7 +1413,7 @@
 		mi->dqi_flags = (mi->dqi_flags & ~DQF_MASK) | (ii->dqi_flags & DQF_MASK);
 	mark_info_dirty(mi);
 	spin_unlock(&dq_data_lock);
-	up_read(&sb_dqopt(sb)->dqptr_sem);
+	up(&sb_dqopt(sb)->dqonoff_sem);
 	return 0;
 }
 
diff -ruX /home/jack/.kerndiffexclude linux-2.6.4/fs/ext3/super.c linux-2.6.4-1-lockfix/fs/ext3/super.c
--- linux-2.6.4/fs/ext3/super.c	2004-03-17 09:46:58.000000000 +0100
+++ linux-2.6.4-1-lockfix/fs/ext3/super.c	2004-03-17 10:37:23.681704568 +0100
@@ -1958,6 +1958,18 @@
 #define EXT3_V0_QFMT_BLOCKS 27
 
 static int (*old_write_dquot)(struct dquot *dquot);
+static void (*old_drop_dquot)(struct inode *inode);
+
+static int fmt_to_blocks(int fmt)
+{
+	switch (fmt) {
+		case QFMT_VFS_OLD:
+			return  EXT3_OLD_QFMT_BLOCKS;
+		case QFMT_VFS_V0:
+			return EXT3_V0_QFMT_BLOCKS;
+	}
+	return EXT3_MAX_TRANS_DATA;
+}
 
 static int ext3_write_dquot(struct dquot *dquot)
 {
@@ -1965,20 +1977,11 @@
 	int ret;
 	int err;
 	handle_t *handle;
-	struct quota_info *dqops = sb_dqopt(dquot->dq_sb);
+	struct quota_info *dqopt = sb_dqopt(dquot->dq_sb);
 	struct inode *qinode;
 
-	switch (dqops->info[dquot->dq_type].dqi_format->qf_fmt_id) {
-		case QFMT_VFS_OLD:
-			nblocks = EXT3_OLD_QFMT_BLOCKS;
-			break;
-		case QFMT_VFS_V0:
-			nblocks = EXT3_V0_QFMT_BLOCKS;
-			break;
-		default:
-			nblocks = EXT3_MAX_TRANS_DATA;
-	}
-	qinode = dqops->files[dquot->dq_type]->f_dentry->d_inode;
+	nblocks = fmt_to_blocks(dqopt->info[dquot->dq_type].dqi_format->qf_fmt_id);
+	qinode = dqopt->files[dquot->dq_type]->f_dentry->d_inode;
 	handle = ext3_journal_start(qinode, nblocks);
 	if (IS_ERR(handle)) {
 		ret = PTR_ERR(handle);
@@ -1991,6 +1994,28 @@
 out:
 	return ret;
 }
+
+static void ext3_drop_dquot(struct inode *inode)
+{
+	int nblocks, type;
+	struct quota_info *dqopt = sb_dqopt(inode->i_sb);
+	handle_t *handle;
+
+	for (type = 0; type < MAXQUOTAS; type++) {
+		if (sb_has_quota_enabled(inode->i_sb, type))
+			break;
+	}
+	if (type < MAXQUOTAS)
+		nblocks = fmt_to_blocks(dqopt->info[type].dqi_format->qf_fmt_id);
+	else
+		nblocks = 0;	/* No quota => no drop */ 
+	handle = ext3_journal_start(inode, 2*nblocks);
+	if (IS_ERR(handle))
+		return;
+	old_drop_dquot(inode);
+	ext3_journal_stop(handle);
+	return;
+}
 #endif
 
 static struct super_block *ext3_get_sb(struct file_system_type *fs_type,
@@ -2018,7 +2043,9 @@
 #ifdef CONFIG_QUOTA
 	init_dquot_operations(&ext3_qops);
 	old_write_dquot = ext3_qops.write_dquot;
+	old_drop_dquot = ext3_qops.drop;
 	ext3_qops.write_dquot = ext3_write_dquot;
+	ext3_qops.drop = ext3_drop_dquot;
 #endif
         err = register_filesystem(&ext3_fs_type);
 	if (err)
diff -ruX /home/jack/.kerndiffexclude linux-2.6.4/fs/inode.c linux-2.6.4-1-lockfix/fs/inode.c
--- linux-2.6.4/fs/inode.c	2004-03-17 09:46:59.000000000 +0100
+++ linux-2.6.4-1-lockfix/fs/inode.c	2004-03-17 10:37:23.692702896 +0100
@@ -1214,15 +1214,13 @@
  */
 #ifdef CONFIG_QUOTA
 
-/* Functions back in dquot.c */
-void put_dquot_list(struct list_head *);
+/* Function back in dquot.c */
 int remove_inode_dquot_ref(struct inode *, int, struct list_head *);
 
-void remove_dquot_ref(struct super_block *sb, int type)
+void remove_dquot_ref(struct super_block *sb, int type, struct list_head *tofree_head)
 {
 	struct inode *inode;
 	struct list_head *act_head;
-	LIST_HEAD(tofree_head);
 
 	if (!sb->dq_op)
 		return;	/* nothing to do */
@@ -1232,26 +1230,24 @@
 	list_for_each(act_head, &inode_in_use) {
 		inode = list_entry(act_head, struct inode, i_list);
 		if (inode->i_sb == sb && IS_QUOTAINIT(inode))
-			remove_inode_dquot_ref(inode, type, &tofree_head);
+			remove_inode_dquot_ref(inode, type, tofree_head);
 	}
 	list_for_each(act_head, &inode_unused) {
 		inode = list_entry(act_head, struct inode, i_list);
 		if (inode->i_sb == sb && IS_QUOTAINIT(inode))
-			remove_inode_dquot_ref(inode, type, &tofree_head);
+			remove_inode_dquot_ref(inode, type, tofree_head);
 	}
 	list_for_each(act_head, &sb->s_dirty) {
 		inode = list_entry(act_head, struct inode, i_list);
 		if (IS_QUOTAINIT(inode))
-			remove_inode_dquot_ref(inode, type, &tofree_head);
+			remove_inode_dquot_ref(inode, type, tofree_head);
 	}
 	list_for_each(act_head, &sb->s_io) {
 		inode = list_entry(act_head, struct inode, i_list);
 		if (IS_QUOTAINIT(inode))
-			remove_inode_dquot_ref(inode, type, &tofree_head);
+			remove_inode_dquot_ref(inode, type, tofree_head);
 	}
 	spin_unlock(&inode_lock);
-
-	put_dquot_list(&tofree_head);
 }
 
 #endif
diff -ruX /home/jack/.kerndiffexclude linux-2.6.4/include/linux/quotaops.h linux-2.6.4-1-lockfix/include/linux/quotaops.h
--- linux-2.6.4/include/linux/quotaops.h	2004-03-04 09:26:40.000000000 +0100
+++ linux-2.6.4-1-lockfix/include/linux/quotaops.h	2004-03-17 10:37:23.709700312 +0100
@@ -64,11 +64,8 @@
 		if (inode->i_sb->dq_op->alloc_space(inode, nr, 1) == NO_QUOTA)
 			return 1;
 	}
-	else {
-		spin_lock(&dq_data_lock);
+	else
 		inode_add_bytes(inode, nr);
-		spin_unlock(&dq_data_lock);
-	}
 	return 0;
 }
 
@@ -87,11 +84,8 @@
 		if (inode->i_sb->dq_op->alloc_space(inode, nr, 0) == NO_QUOTA)
 			return 1;
 	}
-	else {
-		spin_lock(&dq_data_lock);
+	else
 		inode_add_bytes(inode, nr);
-		spin_unlock(&dq_data_lock);
-	}
 	return 0;
 }
 
@@ -117,11 +111,8 @@
 {
 	if (sb_any_quota_enabled(inode->i_sb))
 		inode->i_sb->dq_op->free_space(inode, nr);
-	else {
-		spin_lock(&dq_data_lock);
+	else
 		inode_sub_bytes(inode, nr);
-		spin_unlock(&dq_data_lock);
-	}
 }
 
 static __inline__ void DQUOT_FREE_SPACE(struct inode *inode, qsize_t nr)

--opJtzjQTFsWo+cga--
