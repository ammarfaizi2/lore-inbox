Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266343AbUBLLS3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 06:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266337AbUBLLSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 06:18:08 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:19420 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S266343AbUBLLNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 06:13:36 -0500
Date: Thu, 12 Feb 2004 12:11:28 +0100
From: Jan Kara <jack@suse.cz>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH] Journalled quota (fwd)
Message-ID: <20040212111128.GA32552@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hello,

  Here comes journalled quota patch for 2.6.3-rc2. The patch implements
quota journalling for ext3. What the patch basically does is that all
quota writes are journalled in the same transaction as an update of
changed inode so quota information should always stay consistent with a
real usage (i.e. no quotacheck needed). The patch also handles a case of
orphan cleanup in ext3 by turning quotas on before cleanup is started
and quotas are turned off after the cleanup is finished.  This requires
some tricks because quota code needs to open a file in a not-yet mounted
filesystem but hopefully I managed to implement it in a clean way.
  To test journalled quota you need to apply attached patch (also
available at
ftp://atrey.karlin.mff.cuni.cz/pub/local/jack/quota/v2.6/quota-2.6.3-rc2-1-jquota.diff.gz)
to kernel tree. Compile the kernel and run it. To use journalled quota you need
to mount a filesystem with following options:
  usrjquota=<user quota file>
  grpjquota=<group quota file)
(quota files must be placed in filesystem's root directory)
  jqfmt=vfsv0
(quota format 'vfsold' should also work but it's not tested)

  You should not need any special quota-tools but if you won't use latest
version 3.11 you need to mount filesystem also with 'usrquota,grpquota' options
Also note that if you use older quotacheck(8) the use counts counted by
quotacheck may differ from the counts counted by kernel due to
quotacheck bugs.
  Thanks in advance for testing, bugreports, etc.. :)

									Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs

--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="quota-2.6.3-rc2-1-jquota.diff"

diff -ruX /home/jack/.kerndiffexclude linux-2.6.3-rc2/fs/dquot.c linux-2.6.3-rc2-1-jquota/fs/dquot.c
--- linux-2.6.3-rc2/fs/dquot.c	2004-02-10 22:21:30.000000000 +0100
+++ linux-2.6.3-rc2-1-jquota/fs/dquot.c	2004-02-11 00:37:50.000000000 +0100
@@ -261,6 +261,25 @@
 	up(&dquot->dq_lock);
 }
 
+#define mark_dquot_dirty(dquot) ((dquot)->dq_sb->dq_op->mark_dirty(dquot))
+
+int dquot_mark_dquot_dirty(struct dquot *dquot)
+{
+	spin_lock(&dq_data_lock);
+	set_bit(DQF_ANY_DQUOT_DIRTY_B, &(sb_dqopt((dquot)->dq_sb)->info[(dquot)->dq_type].dqi_flags));
+	set_bit(DQ_MOD_B, &(dquot)->dq_flags);
+	spin_unlock(&dq_data_lock);
+	return 0;
+}
+
+void mark_info_dirty(struct super_block *sb, int type)
+{
+	spin_lock(&dq_data_lock);
+	set_bit(DQF_INFO_DIRTY_B, &sb_dqopt(sb)->info[type].dqi_flags);
+	spin_unlock(&dq_data_lock);
+}
+
+
 static int read_dqblk(struct dquot *dquot)
 {
 	int ret;
@@ -274,14 +293,21 @@
 	return ret;
 }
 
-static int commit_dqblk(struct dquot *dquot)
+/*
+ *	Write dquot to disk
+ */
+int dquot_commit(struct dquot *dquot, int init)
 {
-	int ret;
+	int ret = 0;
 	struct quota_info *dqopt = sb_dqopt(dquot->dq_sb);
 
 	down(&dqopt->dqio_sem);
-	ret = dqopt->ops[dquot->dq_type]->commit_dqblk(dquot);
+	clear_bit(DQ_MOD_B, &dquot->dq_flags);
+	if (!init || !dquot->dq_off)	/* Isn't dquot already allocated? */
+		ret = dqopt->ops[dquot->dq_type]->commit_dqblk(dquot, init);
 	up(&dqopt->dqio_sem);
+	if (info_dirty(&dqopt->info[dquot->dq_type]))
+		dquot->dq_sb->dq_op->write_info(dquot->dq_sb, dquot->dq_type);
 	return ret;
 }
 
@@ -316,7 +342,7 @@
 	spin_unlock(&dq_list_lock);
 }
 
-static int vfs_quota_sync(struct super_block *sb, int type)
+int vfs_quota_sync(struct super_block *sb, int type)
 {
 	struct list_head *head;
 	struct dquot *dquot;
@@ -327,9 +353,11 @@
 restart:
 	/* At this point any dirty dquot will definitely be written so we can clear
 	   dirty flag from info */
+	spin_lock(&dq_data_lock);
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
 		if ((cnt == type || type == -1) && sb_has_quota_enabled(sb, cnt))
 			clear_bit(DQF_ANY_DQUOT_DIRTY_B, &dqopt->info[cnt].dqi_flags);
+	spin_unlock(&dq_data_lock);
 	spin_lock(&dq_list_lock);
 	list_for_each(head, &inuse_list) {
 		dquot = list_entry(head, struct dquot, dq_inuse);
@@ -344,18 +372,15 @@
 		atomic_inc(&dquot->dq_count);
 		dqstats.lookups++;
 		spin_unlock(&dq_list_lock);
-		sb->dq_op->write_dquot(dquot);
+		sb->dq_op->write_dquot(dquot, 0);
 		dqput(dquot);
 		goto restart;
 	}
 	spin_unlock(&dq_list_lock);
 
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
-		if ((cnt == type || type == -1) && sb_has_quota_enabled(sb, cnt) && info_dirty(&dqopt->info[cnt])) {
-			down(&dqopt->dqio_sem);
-			dqopt->ops[cnt]->write_file_info(sb, cnt);
-			up(&dqopt->dqio_sem);
-		}
+		if ((cnt == type || type == -1) && sb_has_quota_enabled(sb, cnt) && info_dirty(&dqopt->info[cnt]))
+			sb->dq_op->write_info(sb, cnt);
 	spin_lock(&dq_list_lock);
 	dqstats.syncs++;
 	spin_unlock(&dq_list_lock);
@@ -430,9 +455,10 @@
 		spin_unlock(&dq_list_lock);
 		return;
 	}
+	/* This should never happen when we are journalling quota */
 	if (dquot_dirty(dquot)) {
 		spin_unlock(&dq_list_lock);
-		dquot->dq_sb->dq_op->write_dquot(dquot);
+		dquot->dq_sb->dq_op->write_dquot(dquot, 0);
 		goto we_slept;
 	}
 	atomic_dec(&dquot->dq_count);
@@ -539,12 +565,10 @@
 		struct file *filp = list_entry(p, struct file, f_list);
 		struct inode *inode = filp->f_dentry->d_inode;
 		if (filp->f_mode & FMODE_WRITE && dqinit_needed(inode, type)) {
-			struct vfsmount *mnt = mntget(filp->f_vfsmnt);
 			struct dentry *dentry = dget(filp->f_dentry);
 			file_list_unlock();
 			sb->dq_op->initialize(inode, type);
 			dput(dentry);
-			mntput(mnt);
 			/* As we may have blocked we had better restart... */
 			goto restart;
 		}
@@ -612,13 +636,11 @@
 static inline void dquot_incr_inodes(struct dquot *dquot, unsigned long number)
 {
 	dquot->dq_dqb.dqb_curinodes += number;
-	mark_dquot_dirty(dquot);
 }
 
 static inline void dquot_incr_space(struct dquot *dquot, qsize_t number)
 {
 	dquot->dq_dqb.dqb_curspace += number;
-	mark_dquot_dirty(dquot);
 }
 
 static inline void dquot_decr_inodes(struct dquot *dquot, unsigned long number)
@@ -630,7 +652,6 @@
 	if (dquot->dq_dqb.dqb_curinodes < dquot->dq_dqb.dqb_isoftlimit)
 		dquot->dq_dqb.dqb_itime = (time_t) 0;
 	clear_bit(DQ_INODES_B, &dquot->dq_flags);
-	mark_dquot_dirty(dquot);
 }
 
 static inline void dquot_decr_space(struct dquot *dquot, qsize_t number)
@@ -642,7 +663,6 @@
 	if (toqb(dquot->dq_dqb.dqb_curspace) < dquot->dq_dqb.dqb_bsoftlimit)
 		dquot->dq_dqb.dqb_btime = (time_t) 0;
 	clear_bit(DQ_BLKS_B, &dquot->dq_flags);
-	mark_dquot_dirty(dquot);
 }
 
 static inline int need_print_warning(struct dquot *dquot)
@@ -799,17 +819,19 @@
  *
  * Note: this is a blocking operation.
  */
-void dquot_initialize(struct inode *inode, int type)
+int dquot_initialize(struct inode *inode, int type)
 {
 	unsigned int id = 0;
-	int cnt;
+	int cnt, ret = 0;
 
+	/* First test before acquiring semaphore - solves deadlocks when we
+         * re-enter the quota code and are already holding the semaphore */
+	if (IS_NOQUOTA(inode))
+		return 0;
 	down_write(&sb_dqopt(inode->i_sb)->dqptr_sem);
 	/* Having dqptr_sem we know NOQUOTA flags can't be altered... */
-	if (IS_NOQUOTA(inode)) {
-		up_write(&sb_dqopt(inode->i_sb)->dqptr_sem);
-		return;
-	}
+	if (IS_NOQUOTA(inode))
+		goto out_err;
 	/* Build list of quotas to initialize... */
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
 		if (type != -1 && cnt != type)
@@ -824,18 +846,23 @@
 					break;
 			}
 			inode->i_dquot[cnt] = dqget(inode->i_sb, id, cnt);
-			if (inode->i_dquot[cnt])
+			if (inode->i_dquot[cnt]) {
 				inode->i_flags |= S_QUOTA;
+				/* Write dquot to allocate space in file if it's not allocated yet */
+				inode->i_sb->dq_op->write_dquot(inode->i_dquot[cnt], 1);
+			}
 		}
 	}
+out_err:
 	up_write(&sb_dqopt(inode->i_sb)->dqptr_sem);
+	return ret;
 }
 
 /*
  *	Remove references to quota from inode
  *	This function needs dqptr_sem for writing
  */
-static void dquot_drop_iupdate(struct inode *inode, struct dquot **to_drop)
+static int dquot_drop_iupdate(struct inode *inode, struct dquot **to_drop)
 {
 	int cnt;
 
@@ -844,22 +871,24 @@
 		to_drop[cnt] = inode->i_dquot[cnt];
 		inode->i_dquot[cnt] = NODQUOT;
 	}
+	return 0;
 }
 
 /*
  * 	Release all quotas referenced by inode
  */
-void dquot_drop(struct inode *inode)
+int dquot_drop(struct inode *inode)
 {
 	struct dquot *to_drop[MAXQUOTAS];
-	int cnt;
+	int cnt, ret;
 
 	down_write(&sb_dqopt(inode->i_sb)->dqptr_sem);
-	dquot_drop_iupdate(inode, to_drop);
+	ret = dquot_drop_iupdate(inode, to_drop);
 	up_write(&sb_dqopt(inode->i_sb)->dqptr_sem);
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
 		if (to_drop[cnt] != NODQUOT)
 			dqput(to_drop[cnt]);
+	return ret;
 }
 
 /*
@@ -878,6 +907,15 @@
 }
 
 /*
+ * Following four functions update i_blocks+i_bytes fields and
+ * quota information (togethter with appropriate checks)
+ * NOTE: We absolutely rely on the fact that caller dirtifies
+ * the inode (usually macros in quotaops.h care about this) and
+ * holds a handle for the current transaction so that dquot write and
+ * inode write go into the same transaction.
+ */
+
+/*
  * This operation can block, but only after everything is updated
  */
 int dquot_alloc_space(struct inode *inode, qsize_t number, int warn)
@@ -885,13 +923,22 @@
 	int cnt, ret = NO_QUOTA;
 	char warntype[MAXQUOTAS];
 
+	/* First test before acquiring semaphore - solves deadlocks when we
+         * re-enter the quota code and are already holding the semaphore */
+	if (IS_NOQUOTA(inode)) {
+out_add:
+		inode_add_bytes(inode, number);
+		return QUOTA_OK;
+	}
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
 		warntype[cnt] = NOWARN;
 
 	down_read(&sb_dqopt(inode->i_sb)->dqptr_sem);
+	if (IS_NOQUOTA(inode)) {	/* Now we can do reliable test... */
+		up_read(&sb_dqopt(inode->i_sb)->dqptr_sem);
+		goto out_add;
+	}
 	spin_lock(&dq_data_lock);
-	if (IS_NOQUOTA(inode))
-		goto add_bytes;
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
 		if (inode->i_dquot[cnt] == NODQUOT)
 			continue;
@@ -903,11 +950,15 @@
 			continue;
 		dquot_incr_space(inode->i_dquot[cnt], number);
 	}
-add_bytes:
 	inode_add_bytes(inode, number);
 	ret = QUOTA_OK;
 warn_put_all:
 	spin_unlock(&dq_data_lock);
+	if (ret == QUOTA_OK)
+		/* Dirtify all the dquots - this can block when journalling */
+		for (cnt = 0; cnt < MAXQUOTAS; cnt++)
+			if (inode->i_dquot[cnt])
+				mark_dquot_dirty(inode->i_dquot[cnt]);
 	flush_warnings(inode->i_dquot, warntype);
 	up_read(&sb_dqopt(inode->i_sb)->dqptr_sem);
 	return ret;
@@ -921,6 +972,10 @@
 	int cnt, ret = NO_QUOTA;
 	char warntype[MAXQUOTAS];
 
+	/* First test before acquiring semaphore - solves deadlocks when we
+         * re-enter the quota code and are already holding the semaphore */
+	if (IS_NOQUOTA(inode))
+		return QUOTA_OK;
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
 		warntype[cnt] = NOWARN;
 	down_read(&sb_dqopt(inode->i_sb)->dqptr_sem);
@@ -944,6 +999,11 @@
 	ret = QUOTA_OK;
 warn_put_all:
 	spin_unlock(&dq_data_lock);
+	if (ret == QUOTA_OK)
+		/* Dirtify all the dquots - this can block when journalling */
+		for (cnt = 0; cnt < MAXQUOTAS; cnt++)
+			if (inode->i_dquot[cnt])
+				mark_dquot_dirty(inode->i_dquot[cnt]);
 	flush_warnings((struct dquot **)inode->i_dquot, warntype);
 	up_read(&sb_dqopt(inode->i_sb)->dqptr_sem);
 	return ret;
@@ -952,36 +1012,53 @@
 /*
  * This is a non-blocking operation.
  */
-void dquot_free_space(struct inode *inode, qsize_t number)
+int dquot_free_space(struct inode *inode, qsize_t number)
 {
 	unsigned int cnt;
 
+	/* First test before acquiring semaphore - solves deadlocks when we
+         * re-enter the quota code and are already holding the semaphore */
+	if (IS_NOQUOTA(inode)) {
+out_sub:
+		inode_sub_bytes(inode, number);
+		return QUOTA_OK;
+	}
 	down_read(&sb_dqopt(inode->i_sb)->dqptr_sem);
+	if (IS_NOQUOTA(inode)) {
+		up_read(&sb_dqopt(inode->i_sb)->dqptr_sem);
+		goto out_sub;
+	}
 	spin_lock(&dq_data_lock);
-	if (IS_NOQUOTA(inode))
-		goto sub_bytes;
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
 		if (inode->i_dquot[cnt] == NODQUOT)
 			continue;
 		dquot_decr_space(inode->i_dquot[cnt], number);
 	}
-sub_bytes:
 	inode_sub_bytes(inode, number);
 	spin_unlock(&dq_data_lock);
+	/* Dirtify all the dquots - this can block when journalling */
+	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
+		if (inode->i_dquot[cnt])
+			mark_dquot_dirty(inode->i_dquot[cnt]);
 	up_read(&sb_dqopt(inode->i_sb)->dqptr_sem);
+	return QUOTA_OK;
 }
 
 /*
  * This is a non-blocking operation.
  */
-void dquot_free_inode(const struct inode *inode, unsigned long number)
+int dquot_free_inode(const struct inode *inode, unsigned long number)
 {
 	unsigned int cnt;
 
+	/* First test before acquiring semaphore - solves deadlocks when we
+         * re-enter the quota code and are already holding the semaphore */
+	if (IS_NOQUOTA(inode))
+		return QUOTA_OK;
 	down_read(&sb_dqopt(inode->i_sb)->dqptr_sem);
 	if (IS_NOQUOTA(inode)) {
 		up_read(&sb_dqopt(inode->i_sb)->dqptr_sem);
-		return;
+		return QUOTA_OK;
 	}
 	spin_lock(&dq_data_lock);
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
@@ -990,7 +1067,12 @@
 		dquot_decr_inodes(inode->i_dquot[cnt], number);
 	}
 	spin_unlock(&dq_data_lock);
+	/* Dirtify all the dquots - this can block when journalling */
+	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
+		if (inode->i_dquot[cnt])
+			mark_dquot_dirty(inode->i_dquot[cnt]);
 	up_read(&sb_dqopt(inode->i_sb)->dqptr_sem);
+	return QUOTA_OK;
 }
 
 /*
@@ -1007,6 +1089,10 @@
 	    chgid = (iattr->ia_valid & ATTR_GID) && inode->i_gid != iattr->ia_gid;
 	char warntype[MAXQUOTAS];
 
+	/* First test before acquiring semaphore - solves deadlocks when we
+         * re-enter the quota code and are already holding the semaphore */
+	if (IS_NOQUOTA(inode))
+		return QUOTA_OK;
 	/* Clear the arrays */
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
 		transfer_to[cnt] = transfer_from[cnt] = NODQUOT;
@@ -1065,6 +1151,13 @@
 	ret = QUOTA_OK;
 warn_put_all:
 	spin_unlock(&dq_data_lock);
+	/* Dirtify all the dquots - this can block when journalling */
+	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
+		if (transfer_from[cnt])
+			mark_dquot_dirty(transfer_from[cnt]);
+		if (transfer_to[cnt])
+			mark_dquot_dirty(transfer_to[cnt]);
+	}
 	flush_warnings(transfer_to, warntype);
 	
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
@@ -1078,25 +1171,35 @@
 }
 
 /*
+ * Write info of quota file to disk
+ */
+int dquot_commit_info(struct super_block *sb, int type)
+{
+	int ret;
+	struct quota_info *dqopt = sb_dqopt(sb);
+
+	down(&dqopt->dqio_sem);
+	ret = dqopt->ops[type]->write_file_info(sb, type);
+	up(&dqopt->dqio_sem);
+	return ret;
+}
+
+/*
  * Definitions of diskquota operations.
  */
 struct dquot_operations dquot_operations = {
-	.initialize	= dquot_initialize,		/* mandatory */
-	.drop		= dquot_drop,			/* mandatory */
+	.initialize	= dquot_initialize,
+	.drop		= dquot_drop,
 	.alloc_space	= dquot_alloc_space,
 	.alloc_inode	= dquot_alloc_inode,
 	.free_space	= dquot_free_space,
 	.free_inode	= dquot_free_inode,
 	.transfer	= dquot_transfer,
-	.write_dquot	= commit_dqblk
+	.write_dquot	= dquot_commit,
+	.mark_dirty	= dquot_mark_dquot_dirty,
+	.write_info	= dquot_commit_info
 };
 
-/* Function used by filesystems for initializing the dquot_operations structure */
-void init_dquot_operations(struct dquot_operations *fsdqops)
-{
-	memcpy(fsdqops, &dquot_operations, sizeof(dquot_operations));
-}
-
 static inline void set_enable_flags(struct quota_info *dqopt, int type)
 {
 	switch (type) {
@@ -1127,7 +1230,7 @@
 /*
  * Turn quota off on a device. type == -1 ==> quotaoff for all types (umount)
  */
-int vfs_quota_off(struct super_block *sb, int type)
+static int __vfs_quota_off(struct super_block *sb, int type, int onmount)
 {
 	int cnt;
 	struct quota_info *dqopt = sb_dqopt(sb);
@@ -1152,17 +1255,14 @@
 		 * Now all dquots should be invalidated, all writes done so we should be only
 		 * users of the info. No locks needed.
 		 */
-		if (info_dirty(&dqopt->info[cnt])) {
-			down(&dqopt->dqio_sem);
-			dqopt->ops[cnt]->write_file_info(sb, cnt);
-			up(&dqopt->dqio_sem);
-		}
+		if (info_dirty(&dqopt->info[cnt]))
+			sb->dq_op->write_info(sb, cnt);
 		if (dqopt->ops[cnt]->free_file_info)
 			dqopt->ops[cnt]->free_file_info(sb, cnt);
 		put_quota_format(dqopt->info[cnt].dqi_format);
 
 		fput(dqopt->files[cnt]);
-		dqopt->files[cnt] = (struct file *)NULL;
+		dqopt->files[cnt] = NULL;
 		dqopt->info[cnt].dqi_flags = 0;
 		dqopt->info[cnt].dqi_igrace = 0;
 		dqopt->info[cnt].dqi_bgrace = 0;
@@ -1174,32 +1274,39 @@
 	return 0;
 }
 
-int vfs_quota_on(struct super_block *sb, int type, int format_id, char *path)
+int vfs_quota_off(struct super_block *sb, int type)
 {
-	struct file *f;
+	return __vfs_quota_off(sb, type, 0);
+}
+
+int vfs_quota_off_mount(struct super_block *sb, int type)
+{
+	return __vfs_quota_off(sb, type, 1);
+}
+
+/*
+ *	Turn quotas on on a device
+ */
+
+/* Helper function when we already have file open */
+static int vfs_quota_on_file(struct file *f, int type, int format_id)
+{
+	struct quota_format_type *fmt = find_quota_format(format_id);
 	struct inode *inode;
+	struct super_block *sb = f->f_dentry->d_sb;
 	struct quota_info *dqopt = sb_dqopt(sb);
-	struct quota_format_type *fmt = find_quota_format(format_id);
 	int error;
 	unsigned int oldflags;
 
 	if (!fmt)
 		return -ESRCH;
-	f = filp_open(path, O_RDWR, 0600);
-	if (IS_ERR(f)) {
-		error = PTR_ERR(f);
-		goto out_fmt;
-	}
 	error = -EIO;
 	if (!f->f_op || !f->f_op->read || !f->f_op->write)
-		goto out_f;
-	error = security_quota_on(f);
-	if (error)
-		goto out_f;
+		goto out_fmt;
 	inode = f->f_dentry->d_inode;
 	error = -EACCES;
 	if (!S_ISREG(inode->i_mode))
-		goto out_f;
+		goto out_fmt;
 
 	down(&dqopt->dqonoff_sem);
 	down_write(&dqopt->dqptr_sem);
@@ -1238,14 +1345,57 @@
 out_lock:
 	up_write(&dqopt->dqptr_sem);
 	up(&dqopt->dqonoff_sem);
-out_f:
-	filp_close(f, NULL);
 out_fmt:
 	put_quota_format(fmt);
 
 	return error; 
 }
 
+/* Actual function called from quotactl() */
+int vfs_quota_on(struct super_block *sb, int type, int format_id, char *path)
+{
+	struct file *f;
+	int error;
+
+	f = filp_open(path, O_RDWR, 0600);
+	if (IS_ERR(f))
+		return PTR_ERR(f);
+	error = security_quota_on(f);
+	if (error)
+		goto out_f;
+	error = vfs_quota_on_file(f, type, format_id);
+	if (!error)
+		return 0;
+out_f:
+	filp_close(f, NULL);
+	return error;
+}
+
+/*
+ * Function used by filesystems when filp_open() would fail (filesystem is being mounted now)
+ * We will use a private file structure. Caller is responsible that it's IO functions won't
+ * need vfsmnt structure or some dentry tricks...
+ */
+int vfs_quota_on_mount(int type, int format_id, struct dentry *dentry)
+{
+	struct file *f;
+	int error;
+
+	dget(dentry);	/* Get a reference for struct file */
+	f = dentry_open(dentry, NULL, O_RDWR);
+	if (IS_ERR(f)) {
+		error = PTR_ERR(f);
+		goto out_dentry;
+	}
+	error = vfs_quota_on_file(f, type, format_id);
+	if (!error)
+		return 0;
+	fput(f);
+out_dentry:
+	dput(dentry);
+	return error;
+}
+
 /* Generic routine for getting common part of quota structure */
 static void do_get_dqblk(struct dquot *dquot, struct if_dqblk *di)
 {
@@ -1329,8 +1479,8 @@
 		clear_bit(DQ_FAKE_B, &dquot->dq_flags);
 	else
 		set_bit(DQ_FAKE_B, &dquot->dq_flags);
-	mark_dquot_dirty(dquot);
 	spin_unlock(&dq_data_lock);
+	mark_dquot_dirty(dquot);
 }
 
 int vfs_set_dqblk(struct super_block *sb, int type, qid_t id, struct if_dqblk *di)
@@ -1387,9 +1537,11 @@
 		mi->dqi_igrace = ii->dqi_igrace;
 	if (ii->dqi_valid & IIF_FLAGS)
 		mi->dqi_flags = (mi->dqi_flags & ~DQF_MASK) | (ii->dqi_flags & DQF_MASK);
-	mark_info_dirty(mi);
 	spin_unlock(&dq_data_lock);
 	up_read(&sb_dqopt(sb)->dqptr_sem);
+	mark_info_dirty(sb, type);
+	/* Force write to disk */
+	sb->dq_op->write_info(sb, type);
 	return 0;
 }
 
@@ -1520,4 +1672,3 @@
 EXPORT_SYMBOL(dqstats);
 EXPORT_SYMBOL(dq_list_lock);
 EXPORT_SYMBOL(dq_data_lock);
-EXPORT_SYMBOL(init_dquot_operations);
diff -ruX /home/jack/.kerndiffexclude linux-2.6.3-rc2/fs/ext3/inode.c linux-2.6.3-rc2-1-jquota/fs/ext3/inode.c
--- linux-2.6.3-rc2/fs/ext3/inode.c	2004-02-10 22:21:30.000000000 +0100
+++ linux-2.6.3-rc2-1-jquota/fs/ext3/inode.c	2004-02-10 23:59:28.000000000 +0100
@@ -2772,9 +2772,25 @@
 
 	if ((ia_valid & ATTR_UID && attr->ia_uid != inode->i_uid) ||
 		(ia_valid & ATTR_GID && attr->ia_gid != inode->i_gid)) {
+		handle_t *handle;
+
+		handle = ext3_journal_start(inode, 2*EXT3_QUOTA_TRANS_BLOCKS+3);
+		if (IS_ERR(handle)) {
+			error = PTR_ERR(handle);
+			goto err_out;
+		}
 		error = DQUOT_TRANSFER(inode, attr) ? -EDQUOT : 0;
-		if (error)
+		if (error) {
+			ext3_journal_stop(handle);
 			return error;
+		}
+		/* Update corresponding info in inode so that everything is in one transaction */
+		if (attr->ia_valid & ATTR_UID)
+			inode->i_uid = attr->ia_uid;
+		if (attr->ia_valid & ATTR_GID)
+			inode->i_gid = attr->ia_gid;
+		error = ext3_mark_inode_dirty(handle, inode);
+		ext3_journal_stop(handle);
 	}
 
 	if (S_ISREG(inode->i_mode) &&
@@ -2853,7 +2869,9 @@
 		ret = 2 * (bpp + indirects) + 2;
 
 #ifdef CONFIG_QUOTA
-	ret += 2 * EXT3_SINGLEDATA_TRANS_BLOCKS;
+	/* We know that structure was already allocated during DQUOT_INIT so
+	 * we will be updating only the data blocks + inodes */
+	ret += 2*EXT3_QUOTA_TRANS_BLOCKS;
 #endif
 
 	return ret;
diff -ruX /home/jack/.kerndiffexclude linux-2.6.3-rc2/fs/ext3/namei.c linux-2.6.3-rc2-1-jquota/fs/ext3/namei.c
--- linux-2.6.3-rc2/fs/ext3/namei.c	2004-02-10 22:21:51.000000000 +0100
+++ linux-2.6.3-rc2-1-jquota/fs/ext3/namei.c	2004-02-11 16:24:28.000000000 +0100
@@ -1974,6 +1974,8 @@
 	struct ext3_dir_entry_2 * de;
 	handle_t *handle;
 
+	/* Initialize quotas before so that eventual writes goes in separate transaction */
+	DQUOT_INIT(dentry->d_inode);
 	handle = ext3_journal_start(dir, EXT3_DELETE_TRANS_BLOCKS);
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
@@ -1987,7 +1989,6 @@
 		handle->h_sync = 1;
 
 	inode = dentry->d_inode;
-	DQUOT_INIT(inode);
 
 	retval = -EIO;
 	if (le32_to_cpu(de->inode) != inode->i_ino)
@@ -2031,6 +2032,8 @@
 	struct ext3_dir_entry_2 * de;
 	handle_t *handle;
 
+	/* Initialize quotas before so that eventual writes goes in separate transaction */
+	DQUOT_INIT(dentry->d_inode);
 	handle = ext3_journal_start(dir, EXT3_DELETE_TRANS_BLOCKS);
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
@@ -2044,7 +2047,6 @@
 		goto end_unlink;
 
 	inode = dentry->d_inode;
-	DQUOT_INIT(inode);
 
 	retval = -EIO;
 	if (le32_to_cpu(de->inode) != inode->i_ino)
@@ -2172,6 +2174,9 @@
 
 	old_bh = new_bh = dir_bh = NULL;
 
+	/* Initialize quotas before so that eventual writes goes in separate transaction */
+	if (new_dentry->d_inode)
+		DQUOT_INIT(new_dentry->d_inode);
 	handle = ext3_journal_start(old_dir, 2 * EXT3_DATA_TRANS_BLOCKS +
 			 		EXT3_INDEX_EXTRA_TRANS_BLOCKS + 2);
 	if (IS_ERR(handle))
@@ -2198,8 +2203,6 @@
 		if (!new_inode) {
 			brelse (new_bh);
 			new_bh = NULL;
-		} else {
-			DQUOT_INIT(new_inode);
 		}
 	}
 	if (S_ISDIR(old_inode->i_mode)) {
diff -ruX /home/jack/.kerndiffexclude linux-2.6.3-rc2/fs/ext3/super.c linux-2.6.3-rc2-1-jquota/fs/ext3/super.c
--- linux-2.6.3-rc2/fs/ext3/super.c	2004-02-10 22:21:30.000000000 +0100
+++ linux-2.6.3-rc2-1-jquota/fs/ext3/super.c	2004-02-11 16:55:26.486131824 +0100
@@ -32,6 +32,9 @@
 #include <linux/buffer_head.h>
 #include <linux/vfs.h>
 #include <linux/random.h>
+#include <linux/mount.h>
+#include <linux/namei.h>
+#include <linux/quotaops.h>
 #include <asm/uaccess.h>
 #include "xattr.h"
 #include "acl.h"
@@ -504,7 +507,41 @@
 # define ext3_clear_inode NULL
 #endif
 
-static struct dquot_operations ext3_qops;
+#ifdef CONFIG_QUOTA
+
+#define QTYPE2NAME(t) ((t)==USRQUOTA?"user":"group")
+#define QTYPE2MOPT(on, t) ((t)==USRQUOTA?((on)##USRJQUOTA):((on)##GRPJQUOTA))
+
+static int ext3_write_dquot(struct dquot *dquot, int init);
+static int ext3_mark_dquot_dirty(struct dquot *dquot);
+static int ext3_write_info(struct super_block *sb, int type);
+static int ext3_quota_on(struct super_block *sb, int type, int format_id, char *path);
+static int ext3_quota_on_mount(struct super_block *sb, int type);
+static int ext3_quota_off_mount(struct super_block *sb, int type);
+
+static struct dquot_operations ext3_quota_operations = {
+	.initialize	= dquot_initialize,
+	.drop		= dquot_drop,
+	.alloc_space	= dquot_alloc_space,
+	.alloc_inode	= dquot_alloc_inode,
+	.free_space	= dquot_free_space,
+	.free_inode	= dquot_free_inode,
+	.transfer	= dquot_transfer,
+	.write_dquot	= ext3_write_dquot,
+	.mark_dirty	= ext3_mark_dquot_dirty,
+	.write_info	= ext3_write_info
+};
+
+static struct quotactl_ops ext3_qctl_operations = {
+	.quota_on	= ext3_quota_on,
+	.quota_off	= vfs_quota_off,
+	.quota_sync	= vfs_quota_sync,
+	.get_info	= vfs_get_dqinfo,
+	.set_info	= vfs_set_dqinfo,
+	.get_dqblk	= vfs_get_dqblk,
+	.set_dqblk	= vfs_set_dqblk
+};
+#endif
 
 static struct super_operations ext3_sops = {
 	.alloc_inode	= ext3_alloc_inode,
@@ -536,6 +573,8 @@
 	Opt_user_xattr, Opt_nouser_xattr, Opt_acl, Opt_noacl, Opt_noload,
 	Opt_commit, Opt_journal_update, Opt_journal_inum,
 	Opt_abort, Opt_data_journal, Opt_data_ordered, Opt_data_writeback,
+	Opt_usrjquota, Opt_grpjquota, Opt_offusrjquota, Opt_offgrpjquota,
+	Opt_jqfmt_vfsold, Opt_jqfmt_vfsv0,
 	Opt_ignore, Opt_err,
 };
 
@@ -571,6 +610,12 @@
 	{Opt_data_journal, "data=journal"},
 	{Opt_data_ordered, "data=ordered"},
 	{Opt_data_writeback, "data=writeback"},
+	{Opt_offusrjquota, "usrjquota="},
+	{Opt_usrjquota, "usrjquota=%s"},
+	{Opt_offgrpjquota, "grpjquota="},
+	{Opt_grpjquota, "grpjquota=%s"},
+	{Opt_jqfmt_vfsold, "jqfmt=vfsold"},
+	{Opt_jqfmt_vfsv0, "jqfmt=vfsv0"},
 	{Opt_ignore, "grpquota"},
 	{Opt_ignore, "noquota"},
 	{Opt_ignore, "quota"},
@@ -598,13 +643,17 @@
 	return sb_block;
 }
 
-static int parse_options (char * options, struct ext3_sb_info *sbi,
+static int parse_options (char * options, struct super_block *sb,
 			  unsigned long * inum, int is_remount)
 {
+	struct ext3_sb_info *sbi = EXT3_SB(sb);
 	char * p;
 	substring_t args[MAX_OPT_ARGS];
 	int data_opt = 0;
 	int option;
+#ifdef CONFIG_QUOTA
+	int qtype;
+#endif
 
 	if (!options)
 		return 1;
@@ -759,6 +808,64 @@
 				sbi->s_mount_opt |= data_opt;
 			}
 			break;
+#ifdef CONFIG_QUOTA
+		case Opt_usrjquota:
+			qtype = USRQUOTA;
+			goto set_qf_name;
+		case Opt_grpjquota:
+			qtype = GRPQUOTA;
+set_qf_name:
+			if (sb_any_quota_enabled(sb)) {
+				printk(KERN_ERR "EXT3-fs: Cannot change journalled quota options when quota turned on.\n");
+				return 0;
+			}
+			if (sbi->s_qf_names[qtype]) {
+				printk(KERN_ERR "EXT3-fs: %s quota file already specified.\n", QTYPE2NAME(qtype));
+				return 0;
+			}
+			sbi->s_qf_names[qtype] = match_strdup(&args[0]);
+			if (!sbi->s_qf_names[qtype]) {
+				printk(KERN_ERR "EXT3-fs: not enough memory for storing quotafile name.\n");
+				return 0;
+			}
+			if (strchr(sbi->s_qf_names[qtype], '/')) {
+				printk(KERN_ERR "EXT3-fs: quotafile must be on filesystem root.\n");
+				kfree(sbi->s_qf_names[qtype]);
+				sbi->s_qf_names[qtype] = NULL;
+				return 0;
+			}
+			break;
+		case Opt_offusrjquota:
+			qtype = USRQUOTA;
+			goto clear_qf_name;
+		case Opt_offgrpjquota:
+			qtype = GRPQUOTA;
+clear_qf_name:
+			if (sb_any_quota_enabled(sb)) {
+				printk(KERN_ERR "EXT3-fs: Cannot change journalled quota options when quota turned on.\n");
+				return 0;
+			}
+			if (sbi->s_qf_names[qtype]) {
+				kfree(sbi->s_qf_names[qtype]);
+				sbi->s_qf_names[qtype] = NULL;
+			}
+			break;
+		case Opt_jqfmt_vfsold:
+			sbi->s_jquota_fmt = QFMT_VFS_OLD;
+			break;
+		case Opt_jqfmt_vfsv0:
+			sbi->s_jquota_fmt = QFMT_VFS_V0;
+			break;
+#else
+		case Opt_usrjquota:
+		case Opt_grpjquota:
+		case Opt_offusrjquota:
+		case Opt_offgrpjquota:
+		case Opt_jqfmt_vfsold:
+		case Opt_jqfmt_vfsv0:
+			printk (KERN_ERR "EXT3-fs: journalled quota options not supported.\n");
+			break;
+#endif
 		case Opt_abort:
 			set_opt(sbi->s_mount_opt, ABORT);
 			break;
@@ -771,6 +878,12 @@
 			return 0;
 		}
 	}
+#ifdef CONFIG_QUOTA
+	if (!sbi->s_jquota_fmt && (sbi->s_qf_names[0] || sbi->s_qf_names[1])) {
+		printk(KERN_ERR "EXT3-fs: journalled quota format not specified.\n");
+		return 0;
+	}
+#endif
 
 	return 1;
 }
@@ -929,7 +1042,7 @@
 				 struct ext3_super_block * es)
 {
 	unsigned int s_flags = sb->s_flags;
-	int nr_orphans = 0, nr_truncates = 0;
+	int nr_orphans = 0, nr_truncates = 0, i;
 	if (!es->s_last_orphan) {
 		jbd_debug(4, "no orphan inodes to clean up\n");
 		return;
@@ -949,6 +1062,16 @@
 		       sb->s_id);
 		sb->s_flags &= ~MS_RDONLY;
 	}
+#ifdef CONFIG_QUOTA
+	sb->s_flags |= MS_ACTIVE;	/* Needed for iput() to work correctly and not trash data */
+	/* Turn on quotas so that they are updated correctly */
+	for (i=0; i < MAXQUOTAS; i++)
+		if (EXT3_SB(sb)->s_qf_names[i]) {
+			int ret = ext3_quota_on_mount(sb, i);
+			if (ret < 0)
+				printk(KERN_ERR "EXT3-fs: Cannot turn on journalled quota: error %d\n", ret);
+		}
+#endif
 
 	while (es->s_last_orphan) {
 		struct inode *inode;
@@ -960,6 +1083,7 @@
 		}
 
 		list_add(&EXT3_I(inode)->i_orphan, &EXT3_SB(sb)->s_orphan);
+		DQUOT_INIT(inode);
 		if (inode->i_nlink) {
 			printk(KERN_DEBUG
 				"%s: truncating inode %ld to %Ld bytes\n",
@@ -987,6 +1111,12 @@
 	if (nr_truncates)
 		printk(KERN_INFO "EXT3-fs: %s: %d truncate%s cleaned up\n",
 		       sb->s_id, PLURAL(nr_truncates));
+#ifdef CONFIG_QUOTA
+	/* Turn quotas off */
+	for (i = 0; i < MAXQUOTAS; i++)
+		if (sb_dqopt(sb)->files[i])
+			ext3_quota_off_mount(sb, i);
+#endif
 	sb->s_flags = s_flags; /* Restore MS_RDONLY status */
 }
 
@@ -1116,7 +1246,7 @@
 	sbi->s_resuid = le16_to_cpu(es->s_def_resuid);
 	sbi->s_resgid = le16_to_cpu(es->s_def_resgid);
 
-	if (!parse_options ((char *) data, sbi, &journal_inum, 0))
+	if (!parse_options ((char *) data, sb, &journal_inum, 0))
 		goto failed_mount;
 
 	sb->s_flags |= MS_ONE_SECOND;
@@ -1295,7 +1425,10 @@
 	 */
 	sb->s_op = &ext3_sops;
 	sb->s_export_op = &ext3_export_ops;
-	sb->dq_op = &ext3_qops;
+#ifdef CONFIG_QUOTA
+	sb->s_qcop = &ext3_qctl_operations;
+	sb->dq_op = &ext3_quota_operations;
+#endif
 	INIT_LIST_HEAD(&sbi->s_orphan); /* unlinked but open files */
 
 	sb->s_root = 0;
@@ -1404,6 +1537,11 @@
 		brelse(sbi->s_group_desc[i]);
 	kfree(sbi->s_group_desc);
 failed_mount:
+#ifdef CONFIG_QUOTA
+	for (i = 0; i < MAXQUOTAS; i++)
+		if (sbi->s_qf_names[i])
+			kfree(sbi->s_qf_names[i]);
+#endif
 	ext3_blkdev_remove(sbi);
 	brelse(bh);
 out_fail:
@@ -1830,7 +1968,7 @@
 	/*
 	 * Allow the "check" option to be passed as a remount option.
 	 */
-	if (!parse_options(data, sbi, &tmp, 1))
+	if (!parse_options(data, sb, &tmp, 1))
 		return -EINVAL;
 
 	if (sbi->s_mount_opt & EXT3_MOUNT_ABORT)
@@ -1950,45 +2088,113 @@
 
 #ifdef CONFIG_QUOTA
 
-/* Blocks: (2 data blocks) * (3 indirect + 1 descriptor + 1 bitmap) + superblock */
-#define EXT3_OLD_QFMT_BLOCKS 11
-/* Blocks: quota info + (4 pointer blocks + 1 entry block) * (3 indirect + 1 descriptor + 1 bitmap) + superblock */
-#define EXT3_V0_QFMT_BLOCKS 27
+static inline int writes_to_blocks(int writes)
+{
+	return writes*5+2;
+}
 
-static int (*old_write_dquot)(struct dquot *dquot);
+static inline struct inode *dquot_to_inode(struct dquot *dquot)
+{
+	return sb_dqopt(dquot->dq_sb)->files[dquot->dq_type]->f_dentry->d_inode;
+}
 
-static int ext3_write_dquot(struct dquot *dquot)
+static int ext3_write_dquot(struct dquot *dquot, int init)
 {
-	int nblocks;
-	int ret;
-	int err;
+	int ret, err;
 	handle_t *handle;
-	struct quota_info *dqops = sb_dqopt(dquot->dq_sb);
-	struct inode *qinode;
 
-	switch (dqops->info[dquot->dq_type].dqi_format->qf_fmt_id) {
-		case QFMT_VFS_OLD:
-			nblocks = EXT3_OLD_QFMT_BLOCKS;
-			break;
-		case QFMT_VFS_V0:
-			nblocks = EXT3_V0_QFMT_BLOCKS;
-			break;
-		default:
-			nblocks = EXT3_MAX_TRANS_DATA;
+	handle = ext3_journal_start(dquot_to_inode(dquot), init ? EXT3_QUOTA_INIT_BLOCKS : EXT3_QUOTA_TRANS_BLOCKS);
+	if (IS_ERR(handle)) {
+		ret = PTR_ERR(handle);
+		goto out;
 	}
-	qinode = dqops->files[dquot->dq_type]->f_dentry->d_inode;
-	handle = ext3_journal_start(qinode, nblocks);
+	ret = dquot_commit(dquot, init);
+	err = ext3_journal_stop(handle);
+	if (!ret)
+		ret = err;
+out:
+	return ret;
+}
+
+static int ext3_mark_dquot_dirty(struct dquot * dquot)
+{
+	/* Are we journalling quotas? */
+	if (EXT3_SB(dquot->dq_sb)->s_qf_names[0] || EXT3_SB(dquot->dq_sb)->s_qf_names[1])
+		return ext3_write_dquot(dquot, 0);
+	else
+		return dquot_mark_dquot_dirty(dquot);
+}
+
+static int ext3_write_info(struct super_block *sb, int type)
+{
+	int ret, err;
+	handle_t *handle;
+
+	handle = ext3_journal_start(sb->s_root->d_inode, writes_to_blocks(1));
 	if (IS_ERR(handle)) {
 		ret = PTR_ERR(handle);
 		goto out;
 	}
-	ret = old_write_dquot(dquot);
+	ret = dquot_commit_info(sb, type);
 	err = ext3_journal_stop(handle);
-	if (ret == 0)
+	if (!ret)
 		ret = err;
 out:
 	return ret;
 }
+
+/* Turn on quotas during mount time - we need to find the quota file and such... */
+static int ext3_quota_on_mount(struct super_block *sb, int type)
+{
+	int err;
+	struct dentry *dentry;
+	struct qstr name = { .name = EXT3_SB(sb)->s_qf_names[type],
+			     .hash = 0,
+			     .len = strlen(EXT3_SB(sb)->s_qf_names[type])};
+
+	dentry = lookup_hash(&name, sb->s_root);
+	if (IS_ERR(dentry))
+		return PTR_ERR(dentry);
+	err = vfs_quota_on_mount(type, EXT3_SB(sb)->s_jquota_fmt, dentry);
+	if (err)
+		dput(dentry);
+	/* We keep the dentry reference if everything went ok - we drop it on quota_off time */
+	return err;
+}
+
+/* Turn quotas off during mount time */
+static int ext3_quota_off_mount(struct super_block *sb, int type)
+{
+	int err;
+	struct dentry *dentry;
+
+	dentry = sb_dqopt(sb)->files[type]->f_dentry;
+	err = vfs_quota_off_mount(sb, type);
+	d_invalidate(dentry);	/* We invalidate dentry - it has at least wrong hash... */
+	dput(dentry);
+	return err;
+}
+
+static int ext3_quota_on(struct super_block *sb, int type, int format_id, char *path)
+{
+	int err;
+	struct nameidata nd;
+
+	if (!EXT3_SB(sb)->s_qf_names[0] && !EXT3_SB(sb)->s_qf_names[1])	/* Not journalling quota? */
+		return vfs_quota_on(sb, type, format_id, path);
+	err = path_lookup(path, LOOKUP_FOLLOW, &nd);
+	if (err)
+		return err;
+	if (nd.mnt->mnt_sb != sb)	/* Quotafile not on the same filesystem? */
+		return -EXDEV;
+	if (nd.dentry->d_parent->d_inode != sb->s_root->d_inode)	/* Quotafile not of fs root? */
+		printk(KERN_WARNING "EXT3-fs: Quota file not on filesystem root. Journalled quota will not work.\n");
+	if (!ext3_should_journal_data(nd.dentry->d_inode))
+		printk(KERN_WARNING "EXT3-fs: Quota file does not have data-journalling. Journalled quota will not work.\n");
+	path_release(&nd);
+	return vfs_quota_on(sb, type, format_id, path);
+}
+
 #endif
 
 static struct super_block *ext3_get_sb(struct file_system_type *fs_type,
@@ -2013,11 +2219,6 @@
 	err = init_inodecache();
 	if (err)
 		goto out1;
-#ifdef CONFIG_QUOTA
-	init_dquot_operations(&ext3_qops);
-	old_write_dquot = ext3_qops.write_dquot;
-	ext3_qops.write_dquot = ext3_write_dquot;
-#endif
         err = register_filesystem(&ext3_fs_type);
 	if (err)
 		goto out;
diff -ruX /home/jack/.kerndiffexclude linux-2.6.3-rc2/fs/quota_v1.c linux-2.6.3-rc2-1-jquota/fs/quota_v1.c
--- linux-2.6.3-rc2/fs/quota_v1.c	2003-11-26 21:44:57.000000000 +0100
+++ linux-2.6.3-rc2-1-jquota/fs/quota_v1.c	2004-02-10 22:24:20.000000000 +0100
@@ -60,13 +60,13 @@
 	v1_disk2mem_dqblk(&dquot->dq_dqb, &dqblk);
 	if (dquot->dq_dqb.dqb_bhardlimit == 0 && dquot->dq_dqb.dqb_bsoftlimit == 0 &&
 	    dquot->dq_dqb.dqb_ihardlimit == 0 && dquot->dq_dqb.dqb_isoftlimit == 0)
-		dquot->dq_flags |= DQ_FAKE;
+		set_bit(DQ_FAKE_B, &dquot->dq_flags);
 	dqstats.reads++;
 
 	return 0;
 }
 
-static int v1_commit_dqblk(struct dquot *dquot)
+static int v1_commit_dqblk(struct dquot *dquot, int init)
 {
 	short type = dquot->dq_type;
 	struct file *filp;
@@ -80,12 +80,7 @@
 	fs = get_fs();
 	set_fs(KERNEL_DS);
 
-	/*
-	 * Note: clear the DQ_MOD flag unconditionally,
-	 * so we don't loop forever on failure.
-	 */
 	v1_mem2disk_dqblk(&dqblk, &dquot->dq_dqb);
-	dquot->dq_flags &= ~DQ_MOD;
 	if (dquot->dq_id == 0) {
 		dqblk.dqb_btime = sb_dqopt(dquot->dq_sb)->info[type].dqi_bgrace;
 		dqblk.dqb_itime = sb_dqopt(dquot->dq_sb)->info[type].dqi_igrace;
diff -ruX /home/jack/.kerndiffexclude linux-2.6.3-rc2/fs/quota_v2.c linux-2.6.3-rc2-1-jquota/fs/quota_v2.c
--- linux-2.6.3-rc2/fs/quota_v2.c	2003-11-26 21:45:20.000000000 +0100
+++ linux-2.6.3-rc2-1-jquota/fs/quota_v2.c	2004-02-10 22:24:20.000000000 +0100
@@ -65,7 +65,7 @@
 	set_fs(fs);
 	if (size != sizeof(struct v2_disk_dqinfo)) {
 		printk(KERN_WARNING "Can't read info structure on device %s.\n",
-			f->f_vfsmnt->mnt_sb->s_id);
+			f->f_dentry->d_sb->s_id);
 		return -1;
 	}
 	info->dqi_bgrace = le32_to_cpu(dinfo.dqi_bgrace);
@@ -87,10 +87,12 @@
 	ssize_t size;
 	loff_t offset = V2_DQINFOOFF;
 
+	spin_lock(&dq_data_lock);
 	info->dqi_flags &= ~DQF_INFO_DIRTY;
 	dinfo.dqi_bgrace = cpu_to_le32(info->dqi_bgrace);
 	dinfo.dqi_igrace = cpu_to_le32(info->dqi_igrace);
 	dinfo.dqi_flags = cpu_to_le32(info->dqi_flags & DQF_MASK);
+	spin_unlock(&dq_data_lock);
 	dinfo.dqi_blocks = cpu_to_le32(info->u.v2_i.dqi_blocks);
 	dinfo.dqi_free_blk = cpu_to_le32(info->u.v2_i.dqi_free_blk);
 	dinfo.dqi_free_entry = cpu_to_le32(info->u.v2_i.dqi_free_entry);
@@ -100,7 +102,7 @@
 	set_fs(fs);
 	if (size != sizeof(struct v2_disk_dqinfo)) {
 		printk(KERN_WARNING "Can't write info structure on device %s.\n",
-			f->f_vfsmnt->mnt_sb->s_id);
+			f->f_dentry->d_sb->s_id);
 		return -1;
 	}
 	return 0;
@@ -173,9 +175,10 @@
 }
 
 /* Remove empty block from list and return it */
-static int get_free_dqblk(struct file *filp, struct mem_dqinfo *info)
+static int get_free_dqblk(struct file *filp, int type)
 {
 	dqbuf_t buf = getdqbuf();
+	struct mem_dqinfo *info = sb_dqinfo(filp->f_dentry->d_sb, type);
 	struct v2_disk_dqdbheader *dh = (struct v2_disk_dqdbheader *)buf;
 	int ret, blk;
 
@@ -193,7 +196,7 @@
 			goto out_buf;
 		blk = info->u.v2_i.dqi_blocks++;
 	}
-	mark_info_dirty(info);
+	mark_info_dirty(filp->f_dentry->d_sb, type);
 	ret = blk;
 out_buf:
 	freedqbuf(buf);
@@ -201,8 +204,9 @@
 }
 
 /* Insert empty block to the list */
-static int put_free_dqblk(struct file *filp, struct mem_dqinfo *info, dqbuf_t buf, uint blk)
+static int put_free_dqblk(struct file *filp, int type, dqbuf_t buf, uint blk)
 {
+	struct mem_dqinfo *info = sb_dqinfo(filp->f_dentry->d_sb, type);
 	struct v2_disk_dqdbheader *dh = (struct v2_disk_dqdbheader *)buf;
 	int err;
 
@@ -210,16 +214,17 @@
 	dh->dqdh_prev_free = cpu_to_le32(0);
 	dh->dqdh_entries = cpu_to_le16(0);
 	info->u.v2_i.dqi_free_blk = blk;
-	mark_info_dirty(info);
+	mark_info_dirty(filp->f_dentry->d_sb, type);
 	if ((err = write_blk(filp, blk, buf)) < 0)	/* Some strange block. We had better leave it... */
 		return err;
 	return 0;
 }
 
 /* Remove given block from the list of blocks with free entries */
-static int remove_free_dqentry(struct file *filp, struct mem_dqinfo *info, dqbuf_t buf, uint blk)
+static int remove_free_dqentry(struct file *filp, int type, dqbuf_t buf, uint blk)
 {
 	dqbuf_t tmpbuf = getdqbuf();
+	struct mem_dqinfo *info = sb_dqinfo(filp->f_dentry->d_sb, type);
 	struct v2_disk_dqdbheader *dh = (struct v2_disk_dqdbheader *)buf;
 	uint nextblk = le32_to_cpu(dh->dqdh_next_free), prevblk = le32_to_cpu(dh->dqdh_prev_free);
 	int err;
@@ -242,7 +247,7 @@
 	}
 	else {
 		info->u.v2_i.dqi_free_entry = nextblk;
-		mark_info_dirty(info);
+		mark_info_dirty(filp->f_dentry->d_sb, type);
 	}
 	freedqbuf(tmpbuf);
 	dh->dqdh_next_free = dh->dqdh_prev_free = cpu_to_le32(0);
@@ -255,9 +260,10 @@
 }
 
 /* Insert given block to the beginning of list with free entries */
-static int insert_free_dqentry(struct file *filp, struct mem_dqinfo *info, dqbuf_t buf, uint blk)
+static int insert_free_dqentry(struct file *filp, int type, dqbuf_t buf, uint blk)
 {
 	dqbuf_t tmpbuf = getdqbuf();
+	struct mem_dqinfo *info = sb_dqinfo(filp->f_dentry->d_sb, type);
 	struct v2_disk_dqdbheader *dh = (struct v2_disk_dqdbheader *)buf;
 	int err;
 
@@ -276,7 +282,7 @@
 	}
 	freedqbuf(tmpbuf);
 	info->u.v2_i.dqi_free_entry = blk;
-	mark_info_dirty(info);
+	mark_info_dirty(filp->f_dentry->d_sb, type);
 	return 0;
 out_buf:
 	freedqbuf(tmpbuf);
@@ -307,7 +313,7 @@
 			goto out_buf;
 	}
 	else {
-		blk = get_free_dqblk(filp, info);
+		blk = get_free_dqblk(filp, dquot->dq_type);
 		if ((int)blk < 0) {
 			*err = blk;
 			freedqbuf(buf);
@@ -315,10 +321,10 @@
 		}
 		memset(buf, 0, V2_DQBLKSIZE);
 		info->u.v2_i.dqi_free_entry = blk;	/* This is enough as block is already zeroed and entry list is empty... */
-		mark_info_dirty(info);
+		mark_info_dirty(dquot->dq_sb, dquot->dq_type);
 	}
 	if (le16_to_cpu(dh->dqdh_entries)+1 >= V2_DQSTRINBLK)	/* Block will be full? */
-		if ((*err = remove_free_dqentry(filp, info, buf, blk)) < 0) {
+		if ((*err = remove_free_dqentry(filp, dquot->dq_type, buf, blk)) < 0) {
 			printk(KERN_ERR "VFS: find_free_dqentry(): Can't remove block (%u) from entry free list.\n", blk);
 			goto out_buf;
 		}
@@ -349,7 +355,6 @@
 static int do_insert_tree(struct dquot *dquot, uint *treeblk, int depth)
 {
 	struct file *filp = sb_dqopt(dquot->dq_sb)->files[dquot->dq_type];
-	struct mem_dqinfo *info = sb_dqopt(dquot->dq_sb)->info + dquot->dq_type;
 	dqbuf_t buf;
 	int ret = 0, newson = 0, newact = 0;
 	u32 *ref;
@@ -358,7 +363,7 @@
 	if (!(buf = getdqbuf()))
 		return -ENOMEM;
 	if (!*treeblk) {
-		ret = get_free_dqblk(filp, info);
+		ret = get_free_dqblk(filp, dquot->dq_type);
 		if (ret < 0)
 			goto out_buf;
 		*treeblk = ret;
@@ -392,7 +397,7 @@
 		ret = write_blk(filp, *treeblk, buf);
 	}
 	else if (newact && ret < 0)
-		put_free_dqblk(filp, info, buf, *treeblk);
+		put_free_dqblk(filp, dquot->dq_type, buf, *treeblk);
 out_buf:
 	freedqbuf(buf);
 	return ret;
@@ -417,6 +422,7 @@
 	ssize_t ret;
 	struct v2_disk_dqblk ddquot;
 
+	/* dq_off is guarded by dqio_sem */
 	if (!dquot->dq_off)
 		if ((ret = dq_insert_tree(dquot)) < 0) {
 			printk(KERN_ERR "VFS: Error %Zd occurred while creating quota.\n", ret);
@@ -424,7 +430,9 @@
 		}
 	filp = sb_dqopt(dquot->dq_sb)->files[type];
 	offset = dquot->dq_off;
+	spin_lock(&dq_data_lock);
 	mem2diskdqb(&ddquot, &dquot->dq_dqb, dquot->dq_id);
+	spin_unlock(&dq_data_lock);
 	fs = get_fs();
 	set_fs(KERNEL_DS);
 	ret = filp->f_op->write(filp, (char *)&ddquot, sizeof(struct v2_disk_dqblk), &offset);
@@ -445,7 +453,6 @@
 static int free_dqentry(struct dquot *dquot, uint blk)
 {
 	struct file *filp = sb_dqopt(dquot->dq_sb)->files[dquot->dq_type];
-	struct mem_dqinfo *info = sb_dqopt(dquot->dq_sb)->info + dquot->dq_type;
 	struct v2_disk_dqdbheader *dh;
 	dqbuf_t buf = getdqbuf();
 	int ret = 0;
@@ -463,8 +470,8 @@
 	dh = (struct v2_disk_dqdbheader *)buf;
 	dh->dqdh_entries = cpu_to_le16(le16_to_cpu(dh->dqdh_entries)-1);
 	if (!le16_to_cpu(dh->dqdh_entries)) {	/* Block got free? */
-		if ((ret = remove_free_dqentry(filp, info, buf, blk)) < 0 ||
-		    (ret = put_free_dqblk(filp, info, buf, blk)) < 0) {
+		if ((ret = remove_free_dqentry(filp, dquot->dq_type, buf, blk)) < 0 ||
+		    (ret = put_free_dqblk(filp, dquot->dq_type, buf, blk)) < 0) {
 			printk(KERN_ERR "VFS: Can't move quota data block (%u) to free list.\n", blk);
 			goto out_buf;
 		}
@@ -473,7 +480,7 @@
 		memset(buf+(dquot->dq_off & ((1 << V2_DQBLKSIZE_BITS)-1)), 0, sizeof(struct v2_disk_dqblk));
 		if (le16_to_cpu(dh->dqdh_entries) == V2_DQSTRINBLK-1) {
 			/* Insert will write block itself */
-			if ((ret = insert_free_dqentry(filp, info, buf, blk)) < 0) {
+			if ((ret = insert_free_dqentry(filp, dquot->dq_type, buf, blk)) < 0) {
 				printk(KERN_ERR "VFS: Can't insert quota data block (%u) to free entry list.\n", blk);
 				goto out_buf;
 			}
@@ -494,7 +501,6 @@
 static int remove_tree(struct dquot *dquot, uint *blk, int depth)
 {
 	struct file *filp = sb_dqopt(dquot->dq_sb)->files[dquot->dq_type];
-	struct mem_dqinfo *info = sb_dqopt(dquot->dq_sb)->info + dquot->dq_type;
 	dqbuf_t buf = getdqbuf();
 	int ret = 0;
 	uint newblk;
@@ -518,7 +524,7 @@
 		ref[GETIDINDEX(dquot->dq_id, depth)] = cpu_to_le32(0);
 		for (i = 0; i < V2_DQBLKSIZE && !buf[i]; i++);	/* Block got empty? */
 		if (i == V2_DQBLKSIZE) {
-			put_free_dqblk(filp, info, buf, *blk);
+			put_free_dqblk(filp, dquot->dq_type, buf, *blk);
 			*blk = 0;
 		}
 		else
@@ -632,7 +638,7 @@
 		if (offset < 0)
 			printk(KERN_ERR "VFS: Can't read quota structure for id %u.\n", dquot->dq_id);
 		dquot->dq_off = 0;
-		dquot->dq_flags |= DQ_FAKE;
+		set_bit(DQ_FAKE_B, &dquot->dq_flags);
 		memset(&dquot->dq_dqb, 0, sizeof(struct mem_dqblk));
 		ret = offset;
 	}
@@ -650,6 +656,9 @@
 			ret = 0;
 		set_fs(fs);
 		disk2memdqb(&dquot->dq_dqb, &ddquot);
+		if (!dquot->dq_dqb.dqb_bhardlimit && !dquot->dq_dqb.dqb_bsoftlimit && !dquot->dq_dqb.dqb_ihardlimit &&
+		    !dquot->dq_dqb.dqb_isoftlimit)
+			set_bit(DQ_FAKE_B, &dquot->dq_flags);
 	}
 	dqstats.reads++;
 
@@ -657,11 +666,14 @@
 }
 
 /* Commit changes of dquot to disk - it might also mean deleting it when quota became fake one and user has no blocks... */
-static int v2_commit_dquot(struct dquot *dquot)
+static int v2_commit_dquot(struct dquot *dquot, int init)
 {
-	/* We clear the flag everytime so we don't loop when there was an IO error... */
-	dquot->dq_flags &= ~DQ_MOD;
-	if (dquot->dq_flags & DQ_FAKE && !(dquot->dq_dqb.dqb_curinodes | dquot->dq_dqb.dqb_curspace))
+	int test;
+
+	spin_lock(&dq_data_lock);
+	test = !init && test_bit(DQ_FAKE_B, &dquot->dq_flags) && !(dquot->dq_dqb.dqb_curinodes | dquot->dq_dqb.dqb_curspace);
+	spin_unlock(&dq_data_lock);
+	if (test)
 		return v2_delete_dquot(dquot);
 	else
 		return v2_write_dquot(dquot);
diff -ruX /home/jack/.kerndiffexclude linux-2.6.3-rc2/fs/stat.c linux-2.6.3-rc2-1-jquota/fs/stat.c
--- linux-2.6.3-rc2/fs/stat.c	2004-02-10 22:21:31.000000000 +0100
+++ linux-2.6.3-rc2-1-jquota/fs/stat.c	2004-02-10 22:24:20.000000000 +0100
@@ -397,6 +397,7 @@
 
 void inode_set_bytes(struct inode *inode, loff_t bytes)
 {
+	/* Caller is here resposible for sufficient locking (ie. inode->i_lock) */
 	inode->i_blocks = bytes >> 9;
 	inode->i_bytes = bytes & 511;
 }
diff -ruX /home/jack/.kerndiffexclude linux-2.6.3-rc2/include/linux/ext3_fs_sb.h linux-2.6.3-rc2-1-jquota/include/linux/ext3_fs_sb.h
--- linux-2.6.3-rc2/include/linux/ext3_fs_sb.h	2004-02-10 22:21:34.000000000 +0100
+++ linux-2.6.3-rc2-1-jquota/include/linux/ext3_fs_sb.h	2004-02-10 22:24:20.000000000 +0100
@@ -69,6 +69,10 @@
 	struct timer_list turn_ro_timer;	/* For turning read-only (crash simulation) */
 	wait_queue_head_t ro_wait_queue;	/* For people waiting for the fs to go read-only */
 #endif
+#ifdef CONFIG_QUOTA
+	char *s_qf_names[MAXQUOTAS];		/* Names of quota files with journalled quota */
+	int s_jquota_fmt;			/* Format of quota to use */
+#endif
 };
 
 #endif	/* _LINUX_EXT3_FS_SB */
diff -ruX /home/jack/.kerndiffexclude linux-2.6.3-rc2/include/linux/ext3_jbd.h linux-2.6.3-rc2-1-jquota/include/linux/ext3_jbd.h
--- linux-2.6.3-rc2/include/linux/ext3_jbd.h	2004-02-10 22:21:34.000000000 +0100
+++ linux-2.6.3-rc2-1-jquota/include/linux/ext3_jbd.h	2004-02-10 23:40:43.000000000 +0100
@@ -42,8 +42,9 @@
  * superblock only gets updated once, of course, so don't bother
  * counting that again for the quota updates. */
 
-#define EXT3_DATA_TRANS_BLOCKS		(3 * EXT3_SINGLEDATA_TRANS_BLOCKS + \
-					 EXT3_XATTR_TRANS_BLOCKS - 2)
+#define EXT3_DATA_TRANS_BLOCKS		(EXT3_SINGLEDATA_TRANS_BLOCKS + \
+					 EXT3_XATTR_TRANS_BLOCKS - 2 + \
+					 2*EXT3_QUOTA_TRANS_BLOCKS)
 
 extern int ext3_writepage_trans_blocks(struct inode *inode);
 
@@ -72,6 +73,15 @@
 
 #define EXT3_INDEX_EXTRA_TRANS_BLOCKS	8
 
+#ifdef CONFIG_QUOTA
+/* Amount of blocks needed for quota update - we know that the structure was
+ * allocated so we need to update only inode+data */
+#define EXT3_QUOTA_TRANS_BLOCKS 2
+#define EXT3_QUOTA_INIT_BLOCKS (DQUOT_MAX_WRITES*(EXT3_SINGLEDATA_TRANS_BLOCKS-2)+2)
+#else
+#define EXT3_QUOTA_TRANS_BLOCKS 0
+#endif
+
 int
 ext3_mark_iloc_dirty(handle_t *handle, 
 		     struct inode *inode,
diff -ruX /home/jack/.kerndiffexclude linux-2.6.3-rc2/include/linux/quota.h linux-2.6.3-rc2-1-jquota/include/linux/quota.h
--- linux-2.6.3-rc2/include/linux/quota.h	2004-02-10 22:21:15.000000000 +0100
+++ linux-2.6.3-rc2-1-jquota/include/linux/quota.h	2004-02-11 00:31:13.000000000 +0100
@@ -138,6 +138,9 @@
 #include <linux/dqblk_v1.h>
 #include <linux/dqblk_v2.h>
 
+/* Maximal numbers of writes for quota operations (over all formats) */
+#define DQUOT_MAX_WRITES	6	/* Number of writes needed when quota structure is written */
+
 /*
  * Data for one user/group kept in memory
  */
@@ -174,16 +177,13 @@
 #define DQF_INFO_DIRTY (1 << DQF_INFO_DIRTY_B)	/* Is info dirty? */
 #define DQF_ANY_DQUOT_DIRTY (1 << DQF_ANY_DQUOT_DIRTY_B) /* Is any dquot dirty? */
 
-extern inline void mark_info_dirty(struct mem_dqinfo *info)
-{
-	set_bit(DQF_INFO_DIRTY_B, &info->dqi_flags);
-}
-
+extern void mark_info_dirty(struct super_block *sb, int type);
 #define info_dirty(info) test_bit(DQF_INFO_DIRTY_B, &(info)->dqi_flags)
 #define info_any_dquot_dirty(info) test_bit(DQF_ANY_DQUOT_DIRTY_B, &(info)->dqi_flags)
 #define info_any_dirty(info) (info_dirty(info) || info_any_dquot_dirty(info))
 
 #define sb_dqopt(sb) (&(sb)->s_dquot)
+#define sb_dqinfo(sb, type) (sb_dqopt(sb)->info+(type))
 
 struct dqstats {
 	int lookups;
@@ -238,19 +238,21 @@
 	int (*write_file_info)(struct super_block *sb, int type);	/* Write main info about file */
 	int (*free_file_info)(struct super_block *sb, int type);	/* Called on quotaoff() */
 	int (*read_dqblk)(struct dquot *dquot);		/* Read structure for one user */
-	int (*commit_dqblk)(struct dquot *dquot);	/* Write (or delete) structure for one user */
+	int (*commit_dqblk)(struct dquot *dquot, int init);	/* Write (or delete) structure for one user */
 };
 
 /* Operations working with dquots */
 struct dquot_operations {
-	void (*initialize) (struct inode *, int);
-	void (*drop) (struct inode *);
+	int (*initialize) (struct inode *, int);
+	int (*drop) (struct inode *);
 	int (*alloc_space) (struct inode *, qsize_t, int);
 	int (*alloc_inode) (const struct inode *, unsigned long);
-	void (*free_space) (struct inode *, qsize_t);
-	void (*free_inode) (const struct inode *, unsigned long);
+	int (*free_space) (struct inode *, qsize_t);
+	int (*free_inode) (const struct inode *, unsigned long);
 	int (*transfer) (struct inode *, struct iattr *);
-	int (*write_dquot) (struct dquot *);
+	int (*write_dquot) (struct dquot *, int);
+	int (*mark_dirty) (struct dquot *);
+	int (*write_info) (struct super_block *, int);
 };
 
 /* Operations handling requests from userspace */
@@ -289,10 +291,7 @@
 };
 
 /* Inline would be better but we need to dereference super_block which is not defined yet */
-#define mark_dquot_dirty(dquot) do {\
-	set_bit(DQF_ANY_DQUOT_DIRTY_B, &(sb_dqopt((dquot)->dq_sb)->info[(dquot)->dq_type].dqi_flags));\
-	set_bit(DQ_MOD_B, &(dquot)->dq_flags);\
-} while (0)
+int mark_dquot_dirty(struct dquot *dquot);
 
 #define dquot_dirty(dquot) test_bit(DQ_MOD_B, &(dquot)->dq_flags)
 
@@ -304,7 +303,6 @@
 
 int register_quota_format(struct quota_format_type *fmt);
 void unregister_quota_format(struct quota_format_type *fmt);
-void init_dquot_operations(struct dquot_operations *fsdqops);
 
 struct quota_module_name {
 	int qm_fmt_id;
diff -ruX /home/jack/.kerndiffexclude linux-2.6.3-rc2/include/linux/quotaops.h linux-2.6.3-rc2-1-jquota/include/linux/quotaops.h
--- linux-2.6.3-rc2/include/linux/quotaops.h	2004-02-10 22:21:34.000000000 +0100
+++ linux-2.6.3-rc2-1-jquota/include/linux/quotaops.h	2004-02-11 00:47:44.000000000 +0100
@@ -22,16 +22,29 @@
  */
 extern void sync_dquots(struct super_block *sb, int type);
 
-extern void dquot_initialize(struct inode *inode, int type);
-extern void dquot_drop(struct inode *inode);
+extern int dquot_initialize(struct inode *inode, int type);
+extern int dquot_drop(struct inode *inode);
 
-extern int  dquot_alloc_space(struct inode *inode, qsize_t number, int prealloc);
-extern int  dquot_alloc_inode(const struct inode *inode, unsigned long number);
+extern int dquot_alloc_space(struct inode *inode, qsize_t number, int prealloc);
+extern int dquot_alloc_inode(const struct inode *inode, unsigned long number);
 
-extern void dquot_free_space(struct inode *inode, qsize_t number);
-extern void dquot_free_inode(const struct inode *inode, unsigned long number);
+extern int dquot_free_space(struct inode *inode, qsize_t number);
+extern int dquot_free_inode(const struct inode *inode, unsigned long number);
 
-extern int  dquot_transfer(struct inode *inode, struct iattr *iattr);
+extern int dquot_transfer(struct inode *inode, struct iattr *iattr);
+extern int dquot_commit(struct dquot *dquot, int init);
+extern int dquot_commit_info(struct super_block *sb, int type);
+extern int dquot_mark_dquot_dirty(struct dquot *dquot);
+
+extern int vfs_quota_on(struct super_block *sb, int type, int format_id, char *path);
+extern int vfs_quota_on_mount(int type, int format_id, struct dentry *dentry);
+extern int vfs_quota_off(struct super_block *sb, int type);
+extern int vfs_quota_off_mount(struct super_block *sb, int type);
+extern int vfs_quota_sync(struct super_block *sb, int type);
+extern int vfs_get_dqinfo(struct super_block *sb, int type, struct if_dqinfo *ii);
+extern int vfs_set_dqinfo(struct super_block *sb, int type, struct if_dqinfo *ii);
+extern int vfs_get_dqblk(struct super_block *sb, int type, qid_t id, struct if_dqblk *di);
+extern int vfs_set_dqblk(struct super_block *sb, int type, qid_t id, struct if_dqblk *di);
 
 /*
  * Operations supported for diskquotas.
@@ -64,11 +77,9 @@
 		if (inode->i_sb->dq_op->alloc_space(inode, nr, 1) == NO_QUOTA)
 			return 1;
 	}
-	else {
-		spin_lock(&dq_data_lock);
+	else
+		/* inode->i_lock will guard the update */
 		inode_add_bytes(inode, nr);
-		spin_unlock(&dq_data_lock);
-	}
 	return 0;
 }
 
@@ -87,11 +98,9 @@
 		if (inode->i_sb->dq_op->alloc_space(inode, nr, 0) == NO_QUOTA)
 			return 1;
 	}
-	else {
-		spin_lock(&dq_data_lock);
+	else
+		/* inode->i_lock will guard the update */
 		inode_add_bytes(inode, nr);
-		spin_unlock(&dq_data_lock);
-	}
 	return 0;
 }
 
@@ -117,11 +126,9 @@
 {
 	if (sb_any_quota_enabled(inode->i_sb))
 		inode->i_sb->dq_op->free_space(inode, nr);
-	else {
-		spin_lock(&dq_data_lock);
+	else
+		/* inode->i_lock will guard the update */
 		inode_sub_bytes(inode, nr);
-		spin_unlock(&dq_data_lock);
-	}
 }
 
 static __inline__ void DQUOT_FREE_SPACE(struct inode *inode, qsize_t nr)

--tThc/1wpZn/ma/RB--
