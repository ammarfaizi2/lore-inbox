Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261579AbUKOMYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261579AbUKOMYa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 07:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbUKOMY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 07:24:29 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:2475 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261579AbUKOMUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 07:20:51 -0500
Date: Mon, 15 Nov 2004 13:20:50 +0100
From: Jan Kara <jack@suse.cz>
To: stanojr@blackhole.websupport.sk
Cc: linux-kernel@vger.kernel.org
Subject: Re: quota deadlock
Message-ID: <20041115122050.GA1442@atrey.karlin.mff.cuni.cz>
References: <20041112173118.GC17928@blackhole.websupport.sk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
In-Reply-To: <20041112173118.GC17928@blackhole.websupport.sk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hello,

> my english sucks, so i'll be brief.                        
> heavy write access to partition with quota enabled causes deadlock. if
> processes try to access the deadlocked partition they                    
> simply have no response and cannot be killed with SIGKILL. i've been
> testing with reiserfs and ext2 on 2.6.9 kernel.
  Could you try attached patch? Can you reproduce the deadlock with it
(if so, please send me the dump of the processes). The patch reworks
substantially the locking and should solve the problems you observe.
It is against current -linus tree but should probably apply well to
2.6.10-rc1. 

						Thanks for testing
								Honza

--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="quota-2.6.10-linus-pagelock.diff"

diff -ruX /home/jack/.kerndiffexclude linux-2.6-linus/fs/dquot.c linux-2.6-linus-pagelock/fs/dquot.c
--- linux-2.6-linus/fs/dquot.c	2004-11-12 19:45:03.000000000 +0100
+++ linux-2.6-linus-pagelock/fs/dquot.c	2004-11-15 01:41:14.000000000 +0100
@@ -75,7 +75,8 @@
 #include <linux/proc_fs.h>
 #include <linux/security.h>
 #include <linux/kmod.h>
-#include <linux/pagemap.h>
+#include <linux/namei.h>
+#include <linux/buffer_head.h>
 
 #include <asm/uaccess.h>
 
@@ -114,7 +115,7 @@
  * operations on dquots don't hold dq_lock as they copy data under dq_data_lock
  * spinlock to internal buffers before writing.
  *
- * Lock ordering (including related VFS locks) is following:
+ * Lock ordering (including related VFS locks) is the following:
  *   i_sem > dqonoff_sem > iprune_sem > journal_lock > dqptr_sem >
  *   > dquot->dq_lock > dqio_sem
  * i_sem on quota files is special (it's below dqio_sem)
@@ -183,8 +184,7 @@
  * on all three lists, depending on its current state.
  *
  * All dquots are placed to the end of inuse_list when first created, and this
- * list is used for the sync and invalidate operations, which must look
- * at every dquot.
+ * list is used for invalidate operation, which must look at every dquot.
  *
  * Unused dquots (dq_count == 0) are added to the free_dquots list when freed,
  * and this list is searched whenever we need an available dquot.  Dquots are
@@ -473,7 +473,6 @@
 	dqstats.syncs++;
 	spin_unlock(&dq_list_lock);
 	up(&dqopt->dqonoff_sem);
-
 	return 0;
 }
 
@@ -758,7 +757,7 @@
 		dquot->dq_dqb.dqb_curinodes -= number;
 	else
 		dquot->dq_dqb.dqb_curinodes = 0;
-	if (dquot->dq_dqb.dqb_curinodes < dquot->dq_dqb.dqb_isoftlimit)
+	if (dquot->dq_dqb.dqb_curinodes <= dquot->dq_dqb.dqb_isoftlimit)
 		dquot->dq_dqb.dqb_itime = (time_t) 0;
 	clear_bit(DQ_INODES_B, &dquot->dq_flags);
 }
@@ -769,7 +768,7 @@
 		dquot->dq_dqb.dqb_curspace -= number;
 	else
 		dquot->dq_dqb.dqb_curspace = 0;
-	if (toqb(dquot->dq_dqb.dqb_curspace) < dquot->dq_dqb.dqb_bsoftlimit)
+	if (toqb(dquot->dq_dqb.dqb_curspace) <= dquot->dq_dqb.dqb_bsoftlimit)
 		dquot->dq_dqb.dqb_btime = (time_t) 0;
 	clear_bit(DQ_BLKS_B, &dquot->dq_flags);
 }
@@ -1314,10 +1313,12 @@
 {
 	int cnt;
 	struct quota_info *dqopt = sb_dqopt(sb);
+	struct inode *toput[MAXQUOTAS];
 
 	/* We need to serialize quota_off() for device */
 	down(&dqopt->dqonoff_sem);
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
+		toput[cnt] = NULL;
 		if (type != -1 && cnt != type)
 			continue;
 		if (!sb_has_quota_enabled(sb, cnt))
@@ -1337,7 +1338,7 @@
 			dqopt->ops[cnt]->free_file_info(sb, cnt);
 		put_quota_format(dqopt->info[cnt].dqi_format);
 
-		fput(dqopt->files[cnt]);
+		toput[cnt] = dqopt->files[cnt];
 		dqopt->files[cnt] = NULL;
 		dqopt->info[cnt].dqi_flags = 0;
 		dqopt->info[cnt].dqi_igrace = 0;
@@ -1345,6 +1346,26 @@
 		dqopt->ops[cnt] = NULL;
 	}
 	up(&dqopt->dqonoff_sem);
+	/* Sync the superblock so that buffers with quota data are written to
+         * disk (and so userspace sees correct data afterwards) */
+	if (sb->s_op->sync_fs)
+		sb->s_op->sync_fs(sb, 1);
+	sync_blockdev(sb->s_bdev);
+	/* Now the quota files are just ordinary files and we can set the
+	 * inode flags back. Moreover we discard the pagecache so that
+	 * userspace sees the writes we did bypassing the pagecache. We
+	 * must also discard the blockdev buffers so that we see the
+	 * changes done by userspace on the next quotaon() */
+	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
+		if (toput[cnt]) {
+			down(&toput[cnt]->i_sem);
+			toput[cnt]->i_flags &= ~(S_IMMUTABLE | S_NOATIME | S_NOQUOTA);
+			truncate_inode_pages(&toput[cnt]->i_data, 0);
+			up(&toput[cnt]->i_sem);
+			mark_inode_dirty(toput[cnt]);
+			iput(toput[cnt]);
+		}
+	invalidate_bdev(sb->s_bdev, 0);
 	return 0;
 }
 
@@ -1352,68 +1373,56 @@
  *	Turn quotas on on a device
  */
 
-/* Helper function when we already have file open */
-static int vfs_quota_on_file(struct file *f, int type, int format_id)
+/* Helper function when we already have the inode */
+static int vfs_quota_on_inode(struct inode *inode, int type, int format_id)
 {
 	struct quota_format_type *fmt = find_quota_format(format_id);
-	struct inode *inode;
-	struct super_block *sb = f->f_dentry->d_sb;
+	struct super_block *sb = inode->i_sb;
 	struct quota_info *dqopt = sb_dqopt(sb);
-	struct dquot *to_drop[MAXQUOTAS];
-	int error, cnt;
-	unsigned int oldflags = -1;
+	int error;
+	int oldflags = -1;
 
 	if (!fmt)
 		return -ESRCH;
-	error = -EIO;
-	if (!f->f_op || !f->f_op->read || !f->f_op->write)
+	if (!S_ISREG(inode->i_mode)) {
+		error = -EACCES;
+		goto out_fmt;
+	}
+	if (IS_RDONLY(inode)) {
+		error = -EROFS;
 		goto out_fmt;
-	inode = f->f_dentry->d_inode;
-	error = -EACCES;
-	if (!S_ISREG(inode->i_mode))
+	}
+	if (!sb->s_op->quota_write || !sb->s_op->quota_read) {
+		error = -EINVAL;
 		goto out_fmt;
+	}
 
+	/* As we bypass the pagecache we must now flush the inode so that
+	 * we see all the changes from userspace... */
+	write_inode_now(inode, 1);
+	/* And now flush the block cache so that kernel sees the changes */
+	invalidate_bdev(sb->s_bdev, 0);
 	down(&inode->i_sem);
 	down(&dqopt->dqonoff_sem);
 	if (sb_has_quota_enabled(sb, type)) {
-		up(&inode->i_sem);
 		error = -EBUSY;
 		goto out_lock;
 	}
 	/* We don't want quota and atime on quota files (deadlocks possible)
-	 * We also need to set GFP mask differently because we cannot recurse
-	 * into filesystem when allocating page for quota inode */
+	 * Also nobody should write to the file - we use special IO operations
+	 * which ignore the immutable bit. */
 	down_write(&dqopt->dqptr_sem);
-	oldflags = inode->i_flags & (S_NOATIME | S_NOQUOTA);
-	inode->i_flags |= S_NOQUOTA | S_NOATIME;
+	oldflags = inode->i_flags & (S_NOATIME | S_IMMUTABLE | S_NOQUOTA);
+	inode->i_flags |= S_NOQUOTA | S_NOATIME | S_IMMUTABLE;
 	up_write(&dqopt->dqptr_sem);
-	up(&inode->i_sem);
 
-	dqopt->files[type] = f;
+	error = -EIO;
+	dqopt->files[type] = igrab(inode);
+	if (!dqopt->files[type])
+		goto out_lock;
 	error = -EINVAL;
 	if (!fmt->qf_ops->check_quota_file(sb, type))
 		goto out_file_init;
-	/*
-	 * We write to quota files deep within filesystem code.  We don't want
-	 * the VFS to reenter filesystem code when it tries to allocate a
-	 * pagecache page for the quota file write.  So clear __GFP_FS in
-	 * the quota file's allocation flags.
-	 */
-	mapping_set_gfp_mask(inode->i_mapping,
-		mapping_gfp_mask(inode->i_mapping) & ~__GFP_FS);
-
-	down_write(&dqopt->dqptr_sem);
-	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
-		to_drop[cnt] = inode->i_dquot[cnt];
-		inode->i_dquot[cnt] = NODQUOT;
-	}
-	up_write(&dqopt->dqptr_sem);
-	/* We must put dquots outside of dqptr_sem because we may need to
-	 * start transaction for dquot_release() */
-	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
-		if (to_drop[cnt])
-			dqput(to_drop[cnt]);
-	}
 
 	dqopt->ops[type] = fmt->qf_ops;
 	dqopt->info[type].dqi_format = fmt;
@@ -1424,6 +1433,7 @@
 		goto out_file_init;
 	}
 	up(&dqopt->dqio_sem);
+	up(&inode->i_sem);
 	set_enable_flags(dqopt, type);
 
 	add_dquot_ref(sb, type);
@@ -1433,19 +1443,18 @@
 
 out_file_init:
 	dqopt->files[type] = NULL;
+	iput(inode);
 out_lock:
 	up(&dqopt->dqonoff_sem);
 	if (oldflags != -1) {
-		down(&inode->i_sem);
 		down_write(&dqopt->dqptr_sem);
-		/* Reset the NOATIME flag back. I know it could change in the
-		 * mean time but playing with NOATIME flags on a quota file is
-		 * never a good idea */
-		inode->i_flags &= ~(S_NOATIME | S_NOQUOTA);
+		/* Set the flags back (in the case of accidental quotaon()
+		 * on a wrong file we don't want to mess up the flags) */
+		inode->i_flags &= ~(S_NOATIME | S_NOQUOTA | S_IMMUTABLE);
 		inode->i_flags |= oldflags;
 		up_write(&dqopt->dqptr_sem);
-		up(&inode->i_sem);
 	}
+	up(&inode->i_sem);
 out_fmt:
 	put_quota_format(fmt);
 
@@ -1455,47 +1464,37 @@
 /* Actual function called from quotactl() */
 int vfs_quota_on(struct super_block *sb, int type, int format_id, char *path)
 {
-	struct file *f;
+	struct nameidata nd;
 	int error;
 
-	f = filp_open(path, O_RDWR, 0600);
-	if (IS_ERR(f))
-		return PTR_ERR(f);
-	error = security_quota_on(f);
+	error = path_lookup(path, LOOKUP_FOLLOW, &nd);
+	if (error < 0)
+		return error;
+	error = security_quota_on(nd.dentry);
 	if (error)
-		goto out_f;
-	error = vfs_quota_on_file(f, type, format_id);
-	if (!error)
-		return 0;
-out_f:
-	filp_close(f, NULL);
+		goto out_path;
+	/* Quota file not on the same filesystem? */
+	if (nd.mnt->mnt_sb != sb)
+		error = -EXDEV;
+	else
+		error = vfs_quota_on_inode(nd.dentry->d_inode, type, format_id);
+out_path:
+	path_release(&nd);
 	return error;
 }
 
 /*
- * Function used by filesystems when filp_open() would fail (filesystem is
- * being mounted now). We will use a private file structure. Caller is
- * responsible that it's IO functions won't need vfsmnt structure or
- * some dentry tricks...
+ * This function is used when filesystem needs to initialize quotas
+ * during mount time.
  */
 int vfs_quota_on_mount(int type, int format_id, struct dentry *dentry)
 {
-	struct file *f;
 	int error;
 
-	dget(dentry);	/* Get a reference for struct file */
-	f = dentry_open(dentry, NULL, O_RDWR);
-	if (IS_ERR(f)) {
-		error = PTR_ERR(f);
-		goto out_dentry;
-	}
-	error = vfs_quota_on_file(f, type, format_id);
-	if (!error)
-		return 0;
-	fput(f);
-out_dentry:
-	dput(dentry);
-	return error;
+	error = security_quota_on(dentry);
+	if (error)
+		return error;
+	return vfs_quota_on_inode(dentry->d_inode, type, format_id);
 }
 
 /* Generic routine for getting common part of quota structure */
diff -ruX /home/jack/.kerndiffexclude linux-2.6-linus/fs/ext2/ext2.h linux-2.6-linus-pagelock/fs/ext2/ext2.h
--- linux-2.6-linus/fs/ext2/ext2.h	2004-11-12 19:45:05.000000000 +0100
+++ linux-2.6-linus-pagelock/fs/ext2/ext2.h	2004-11-14 20:20:54.000000000 +0100
@@ -119,6 +119,7 @@
 extern void ext2_delete_inode (struct inode *);
 extern int ext2_sync_inode (struct inode *);
 extern void ext2_discard_prealloc (struct inode *);
+extern int ext2_get_block(struct inode *, sector_t, struct buffer_head *, int);
 extern void ext2_truncate (struct inode *);
 extern int ext2_setattr (struct dentry *, struct iattr *);
 extern void ext2_set_inode_flags(struct inode *inode);
diff -ruX /home/jack/.kerndiffexclude linux-2.6-linus/fs/ext2/inode.c linux-2.6-linus-pagelock/fs/ext2/inode.c
--- linux-2.6-linus/fs/ext2/inode.c	2004-11-12 19:45:05.000000000 +0100
+++ linux-2.6-linus-pagelock/fs/ext2/inode.c	2004-11-14 20:20:55.000000000 +0100
@@ -524,7 +524,7 @@
  * reachable from inode.
  */
 
-static int ext2_get_block(struct inode *inode, sector_t iblock, struct buffer_head *bh_result, int create)
+int ext2_get_block(struct inode *inode, sector_t iblock, struct buffer_head *bh_result, int create)
 {
 	int err = -EIO;
 	int offsets[4];
diff -ruX /home/jack/.kerndiffexclude linux-2.6-linus/fs/ext2/super.c linux-2.6-linus-pagelock/fs/ext2/super.c
--- linux-2.6-linus/fs/ext2/super.c	2004-11-12 19:45:05.000000000 +0100
+++ linux-2.6-linus-pagelock/fs/ext2/super.c	2004-11-14 20:20:58.000000000 +0100
@@ -200,6 +200,11 @@
 }
 
 
+#ifdef CONFIG_QUOTA
+static ssize_t ext2_quota_read(struct inode *inode, char *data, size_t len, loff_t off);
+static ssize_t ext2_quota_write(struct inode *inode, const char *data, size_t len, loff_t off);
+#endif
+
 static struct super_operations ext2_sops = {
 	.alloc_inode	= ext2_alloc_inode,
 	.destroy_inode	= ext2_destroy_inode,
@@ -211,6 +216,10 @@
 	.statfs		= ext2_statfs,
 	.remount_fs	= ext2_remount,
 	.clear_inode	= ext2_clear_inode,
+#ifdef CONFIG_QUOTA
+	.quota_read	= ext2_quota_read,
+	.quota_write	= ext2_quota_write,
+#endif
 };
 
 /* Yes, most of these are left as NULL!!
@@ -1001,6 +1010,102 @@
 	return get_sb_bdev(fs_type, flags, dev_name, data, ext2_fill_super);
 }
 
+#ifdef CONFIG_QUOTA
+
+/* Read data from quotafile - avoid pagecache and such because we cannot afford
+ * acquiring the locks... As quota files are never truncated and quota code
+ * itself serializes the operations (and noone else should touch the files)
+ * we don't have to be afraid of races */
+static ssize_t ext2_quota_read(struct inode *inode, char *data, size_t len,
+			       loff_t off)
+{
+	struct super_block *sb = inode->i_sb;
+	unsigned long blk = off >> EXT2_BLOCK_SIZE_BITS(sb);
+	int err = 0, offset = off & (sb->s_blocksize - 1), tocopy;
+	size_t toread;
+	struct buffer_head tmp_bh, *bh;
+	loff_t i_size = i_size_read(inode);
+
+	if (off > i_size)
+		return 0;
+	if (off+len > i_size)
+		len = i_size-off;
+	toread = len;
+	while (toread > 0) {
+		tocopy = sb->s_blocksize - offset < toread ?
+				sb->s_blocksize - offset : toread;
+
+		tmp_bh.b_state = 0;
+		err = ext2_get_block(inode, blk, &tmp_bh, 0);
+		if (err)
+			return err;
+		if (!buffer_mapped(&tmp_bh))	/* A hole? */
+			memset(data, 0, tocopy);
+		else {
+			bh = sb_bread(sb, tmp_bh.b_blocknr);
+			if (!bh)
+				return -EIO;
+			memcpy(data, bh->b_data+offset, tocopy);
+			brelse(bh);
+		}
+		offset = 0;
+		toread -= tocopy;
+		data += tocopy;
+		blk++;
+	}
+	return len;
+}
+
+/* Write to quotafile */
+static ssize_t ext2_quota_write(struct inode *inode, const char *data,
+				size_t len, loff_t off)
+{
+	struct super_block *sb = inode->i_sb;
+	unsigned long blk = off >> EXT2_BLOCK_SIZE_BITS(sb);
+	int err = 0, offset = off & (sb->s_blocksize - 1), tocopy;
+	size_t towrite = len;
+	struct buffer_head tmp_bh, *bh;
+
+	down(&inode->i_sem);
+	while (towrite > 0) {
+		tocopy = sb->s_blocksize - offset < towrite ?
+				sb->s_blocksize - offset : towrite;
+
+		tmp_bh.b_state = 0;
+		err = ext2_get_block(inode, blk, &tmp_bh, 1);
+		if (err)
+			goto out;
+		if (offset || tocopy != EXT2_BLOCK_SIZE(sb))
+			bh = sb_bread(sb, tmp_bh.b_blocknr);
+		else
+			bh = sb_getblk(sb, tmp_bh.b_blocknr);
+		if (!bh) {
+			err = -EIO;
+			goto out;
+		}
+		memcpy(bh->b_data+offset, data, tocopy);
+		set_buffer_uptodate(bh);
+		mark_buffer_dirty(bh);
+		brelse(bh);
+		offset = 0;
+		towrite -= tocopy;
+		data += tocopy;
+		blk++;
+	}
+out:
+	if (len == towrite)
+		return err;
+	if (inode->i_size < off+len-towrite)
+		i_size_write(inode, off+len-towrite);
+	inode->i_version++;
+	inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+	mark_inode_dirty(inode);
+	up(&inode->i_sem);
+	return len - towrite;
+}
+
+#endif
+
 static struct file_system_type ext2_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "ext2",
diff -ruX /home/jack/.kerndiffexclude linux-2.6-linus/fs/ext3/super.c linux-2.6-linus-pagelock/fs/ext3/super.c
--- linux-2.6-linus/fs/ext3/super.c	2004-11-12 19:45:06.000000000 +0100
+++ linux-2.6-linus-pagelock/fs/ext3/super.c	2004-11-14 20:21:01.000000000 +0100
@@ -521,7 +521,8 @@
 static int ext3_write_info(struct super_block *sb, int type);
 static int ext3_quota_on(struct super_block *sb, int type, int format_id, char *path);
 static int ext3_quota_on_mount(struct super_block *sb, int type);
-static int ext3_quota_off_mount(struct super_block *sb, int type);
+static ssize_t ext3_quota_read(struct inode *inode, char *data, size_t len, loff_t off);
+static ssize_t ext3_quota_write(struct inode *inode, const char *data, size_t len, loff_t off);
 
 static struct dquot_operations ext3_quota_operations = {
 	.initialize	= ext3_dquot_initialize,
@@ -564,6 +565,10 @@
 	.statfs		= ext3_statfs,
 	.remount_fs	= ext3_remount,
 	.clear_inode	= ext3_clear_inode,
+#ifdef CONFIG_QUOTA
+	.quota_read	= ext3_quota_read,
+	.quota_write	= ext3_quota_write,
+#endif
 };
 
 struct dentry *ext3_get_parent(struct dentry *child);
@@ -663,6 +668,7 @@
 	int option;
 #ifdef CONFIG_QUOTA
 	int qtype;
+	char *qname;
 #endif
 
 	if (!options)
@@ -841,19 +847,22 @@
 					"quota options when quota turned on.\n");
 				return 0;
 			}
-			if (sbi->s_qf_names[qtype]) {
+			qname = match_strdup(&args[0]);
+			if (!qname) {
 				printk(KERN_ERR
-					"EXT3-fs: %s quota file already "
-					"specified.\n", QTYPE2NAME(qtype));
+					"EXT3-fs: not enough memory for "
+					"storing quotafile name.\n");
 				return 0;
 			}
-			sbi->s_qf_names[qtype] = match_strdup(&args[0]);
-			if (!sbi->s_qf_names[qtype]) {
+			if (sbi->s_qf_names[qtype] &&
+			    strcmp(sbi->s_qf_names[qtype], qname)) {
 				printk(KERN_ERR
-					"EXT3-fs: not enough memory for "
-					"storing quotafile name.\n");
+					"EXT3-fs: %s quota file already "
+					"specified.\n", QTYPE2NAME(qtype));
+				kfree(qname);
 				return 0;
 			}
+			sbi->s_qf_names[qtype] = qname;
 			if (strchr(sbi->s_qf_names[qtype], '/')) {
 				printk(KERN_ERR
 					"EXT3-fs: quotafile must be on "
@@ -1173,7 +1182,7 @@
 	/* Turn quotas off */
 	for (i = 0; i < MAXQUOTAS; i++) {
 		if (sb_dqopt(sb)->files[i])
-			ext3_quota_off_mount(sb, i);
+			vfs_quota_off(sb, i);
 	}
 #endif
 	sb->s_flags = s_flags; /* Restore MS_RDONLY status */
@@ -2190,7 +2199,7 @@
 
 static inline struct inode *dquot_to_inode(struct dquot *dquot)
 {
-	return sb_dqopt(dquot->dq_sb)->files[dquot->dq_type]->f_dentry->d_inode;
+	return sb_dqopt(dquot->dq_sb)->files[dquot->dq_type];
 }
 
 static int ext3_dquot_initialize(struct inode *inode, int type)
@@ -2229,8 +2238,10 @@
 {
 	int ret, err;
 	handle_t *handle;
+	struct inode *inode;
 
-	handle = ext3_journal_start(dquot_to_inode(dquot),
+	inode = dquot_to_inode(dquot);
+	handle = ext3_journal_start(inode,
 					EXT3_QUOTA_TRANS_BLOCKS);
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
@@ -2317,22 +2328,9 @@
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
 	err = vfs_quota_on_mount(type, EXT3_SB(sb)->s_jquota_fmt, dentry);
-	if (err)
-		dput(dentry);
-	/* We keep the dentry reference if everything went ok - we drop it
-	 * on quota_off time */
-	return err;
-}
-
-/* Turn quotas off during mount time */
-static int ext3_quota_off_mount(struct super_block *sb, int type)
-{
-	int err;
-	struct dentry *dentry;
-
-	dentry = sb_dqopt(sb)->files[type]->f_dentry;
-	err = vfs_quota_off_mount(sb, type);
-	/* We invalidate dentry - it has at least wrong hash... */
+	/* Now invalidate and put the dentry - quota got its own reference
+	 * to inode and dentry has at least wrong hash so we had better
+	 * throw it away */
 	d_invalidate(dentry);
 	dput(dentry);
 	return err;
@@ -2355,20 +2353,105 @@
 	if (err)
 		return err;
 	/* Quotafile not on the same filesystem? */
-	if (nd.mnt->mnt_sb != sb)
+	if (nd.mnt->mnt_sb != sb) {
+		path_release(&nd);
 		return -EXDEV;
+	}
 	/* Quotafile not of fs root? */
 	if (nd.dentry->d_parent->d_inode != sb->s_root->d_inode)
 		printk(KERN_WARNING
 			"EXT3-fs: Quota file not on filesystem root. "
 			"Journalled quota will not work.\n");
-	if (!ext3_should_journal_data(nd.dentry->d_inode))
-		printk(KERN_WARNING "EXT3-fs: Quota file does not have "
-			"data-journalling. Journalled quota will not work.\n");
 	path_release(&nd);
 	return vfs_quota_on(sb, type, format_id, path);
 }
 
+/* Read data from quotafile - avoid pagecache and such because we cannot afford
+ * acquiring the locks... As quota files are never truncated and quota code
+ * itself serializes the operations (and noone else should touch the files)
+ * we don't have to be afraid of races */
+static ssize_t ext3_quota_read(struct inode *inode, char *data, size_t len,
+			       loff_t off)
+{
+	struct super_block *sb = inode->i_sb;
+	unsigned long blk = off >> EXT3_BLOCK_SIZE_BITS(sb);
+	int err = 0, offset = off & (sb->s_blocksize - 1), tocopy;
+	size_t toread;
+	struct buffer_head *bh;
+	loff_t i_size = i_size_read(inode);
+
+	if (off > i_size)
+		return 0;
+	if (off+len > i_size)
+		len = i_size-off;
+	toread = len;
+	while (toread > 0) {
+		tocopy = sb->s_blocksize - offset < toread ?
+				sb->s_blocksize - offset : toread;
+		bh = ext3_bread(NULL, inode, blk, 0, &err);
+		if (err)
+			return err;
+		if (!bh)	/* A hole? */
+			memset(data, 0, tocopy);
+		else
+			memcpy(data, bh->b_data+offset, tocopy);
+		brelse(bh);
+		offset = 0;
+		toread -= tocopy;
+		data += tocopy;
+		blk++;
+	}
+	return len;
+}
+
+/* Write to quotafile (we know the transaction is already started and has
+ * enough credits) */
+static ssize_t ext3_quota_write(struct inode *inode, const char *data,
+				size_t len, loff_t off)
+{
+	struct super_block *sb = inode->i_sb;
+	unsigned long blk = off >> EXT3_BLOCK_SIZE_BITS(sb);
+	int err = 0, offset = off & (sb->s_blocksize - 1), tocopy;
+	size_t towrite = len;
+	struct buffer_head *bh;
+	handle_t *handle = journal_current_handle();
+
+	down(&inode->i_sem);
+	while (towrite > 0) {
+		tocopy = sb->s_blocksize - offset < towrite ?
+				sb->s_blocksize - offset : towrite;
+		bh = ext3_bread(handle, inode, blk, 1, &err);
+		if (!bh)
+			goto out;
+		err = ext3_journal_get_write_access(handle, bh);
+		if (err) {
+			brelse(bh);
+			goto out;
+		}
+		memcpy(bh->b_data+offset, data, tocopy);
+		err = ext3_journal_dirty_metadata(handle, bh);
+		brelse(bh);
+		if (err)
+			goto out;
+		offset = 0;
+		towrite -= tocopy;
+		data += tocopy;
+		blk++;
+	}
+out:
+	if (len == towrite)
+		return err;
+	if (inode->i_size < off+len-towrite) {
+		i_size_write(inode, off+len-towrite);
+		EXT3_I(inode)->i_disksize = inode->i_size;
+	}
+	inode->i_version++;
+	inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+	ext3_mark_inode_dirty(handle, inode);
+	up(&inode->i_sem);
+	return len - towrite;
+}
+
 #endif
 
 static struct super_block *ext3_get_sb(struct file_system_type *fs_type,
diff -ruX /home/jack/.kerndiffexclude linux-2.6-linus/fs/namespace.c linux-2.6-linus-pagelock/fs/namespace.c
--- linux-2.6-linus/fs/namespace.c	2004-11-12 19:45:04.000000000 +0100
+++ linux-2.6-linus-pagelock/fs/namespace.c	2004-11-14 20:21:04.000000000 +0100
@@ -423,6 +423,7 @@
 		down_write(&sb->s_umount);
 		if (!(sb->s_flags & MS_RDONLY)) {
 			lock_kernel();
+			DQUOT_OFF(sb);
 			retval = do_remount_sb(sb, MS_RDONLY, NULL, 0);
 			unlock_kernel();
 		}
diff -ruX /home/jack/.kerndiffexclude linux-2.6-linus/fs/quota.c linux-2.6-linus-pagelock/fs/quota.c
--- linux-2.6-linus/fs/quota.c	2004-11-12 19:45:04.000000000 +0100
+++ linux-2.6-linus-pagelock/fs/quota.c	2004-11-14 20:21:06.000000000 +0100
@@ -14,6 +14,7 @@
 #include <linux/smp_lock.h>
 #include <linux/security.h>
 #include <linux/syscalls.h>
+#include <linux/buffer_head.h>
 
 /* Check validity of quotactl */
 static int check_quotactl_valid(struct super_block *sb, int type, int cmd, qid_t id)
@@ -135,16 +136,54 @@
 	return NULL;
 }
 
+void quota_sync_sb(struct super_block *sb, int type)
+{
+	int cnt;
+	struct inode *discard[MAXQUOTAS];
+
+	sb->s_qcop->quota_sync(sb, type);
+	/* This is not very clever (and fast) but currently I don't know about
+	 * any other simple way of getting quota data to disk and we must get
+	 * them there for userspace to be visible... */
+	if (sb->s_op->sync_fs)
+		sb->s_op->sync_fs(sb, 1);
+	sync_blockdev(sb->s_bdev);
+
+	/* Now when everything is written we can discard the pagecache so
+	 * that userspace sees the changes. We need i_sem and so we could
+	 * not do it inside dqonoff_sem. Moreover we need to be carefull
+	 * about races with quotaoff() (that is the reason why we have own
+	 * reference to inode). */
+	down(&sb_dqopt(sb)->dqonoff_sem);
+	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
+		discard[cnt] = NULL;
+		if (type != -1 && cnt != type)
+			continue;
+		if (!sb_has_quota_enabled(sb, cnt))
+			continue;
+		discard[cnt] = igrab(sb_dqopt(sb)->files[cnt]);
+	}
+	up(&sb_dqopt(sb)->dqonoff_sem);
+	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
+		if (discard[cnt]) {
+			down(&discard[cnt]->i_sem);
+			truncate_inode_pages(&discard[cnt]->i_data, 0);
+			up(&discard[cnt]->i_sem);
+			iput(discard[cnt]);
+		}
+	}
+}
+
 void sync_dquots(struct super_block *sb, int type)
 {
 	if (sb) {
 		if (sb->s_qcop->quota_sync)
-			sb->s_qcop->quota_sync(sb, type);
+			quota_sync_sb(sb, type);
 	}
 	else {
-		while ((sb = get_super_to_sync(type)) != 0) {
+		while ((sb = get_super_to_sync(type)) != NULL) {
 			if (sb->s_qcop->quota_sync)
-				sb->s_qcop->quota_sync(sb, type);
+				quota_sync_sb(sb, type);
 			drop_super(sb);
 		}
 	}
diff -ruX /home/jack/.kerndiffexclude linux-2.6-linus/fs/quota_v1.c linux-2.6-linus-pagelock/fs/quota_v1.c
--- linux-2.6-linus/fs/quota_v1.c	2004-11-12 19:45:04.000000000 +0100
+++ linux-2.6-linus-pagelock/fs/quota_v1.c	2004-11-14 20:21:07.000000000 +0100
@@ -7,7 +7,6 @@
 #include <linux/init.h>
 #include <linux/module.h>
 
-#include <asm/uaccess.h>
 #include <asm/byteorder.h>
 
 MODULE_AUTHOR("Jan Kara");
@@ -41,23 +40,16 @@
 static int v1_read_dqblk(struct dquot *dquot)
 {
 	int type = dquot->dq_type;
-	struct file *filp;
-	mm_segment_t fs;
-	loff_t offset;
+	struct inode *inode;
 	struct v1_disk_dqblk dqblk;
 
-	filp = sb_dqopt(dquot->dq_sb)->files[type];
-	if (filp == (struct file *)NULL)
+	inode = sb_dqopt(dquot->dq_sb)->files[type];
+	if (!inode)
 		return -EINVAL;
 
-	/* Now we are sure filp is valid */
-	offset = v1_dqoff(dquot->dq_id);
 	/* Set structure to 0s in case read fails/is after end of file */
 	memset(&dqblk, 0, sizeof(struct v1_disk_dqblk));
-	fs = get_fs();
-	set_fs(KERNEL_DS);
-	filp->f_op->read(filp, (char *)&dqblk, sizeof(struct v1_disk_dqblk), &offset);
-	set_fs(fs);
+	inode->i_sb->s_op->quota_read(inode, (char *)&dqblk, sizeof(struct v1_disk_dqblk), v1_dqoff(dquot->dq_id));
 
 	v1_disk2mem_dqblk(&dquot->dq_dqb, &dqblk);
 	if (dquot->dq_dqb.dqb_bhardlimit == 0 && dquot->dq_dqb.dqb_bsoftlimit == 0 &&
@@ -71,16 +63,11 @@
 static int v1_commit_dqblk(struct dquot *dquot)
 {
 	short type = dquot->dq_type;
-	struct file *filp;
-	mm_segment_t fs;
-	loff_t offset;
+	struct inode *inode;
 	ssize_t ret;
 	struct v1_disk_dqblk dqblk;
 
-	filp = sb_dqopt(dquot->dq_sb)->files[type];
-	offset = v1_dqoff(dquot->dq_id);
-	fs = get_fs();
-	set_fs(KERNEL_DS);
+	inode = sb_dqopt(dquot->dq_sb)->files[type];
 
 	v1_mem2disk_dqblk(&dqblk, &dquot->dq_dqb);
 	if (dquot->dq_id == 0) {
@@ -88,9 +75,9 @@
 		dqblk.dqb_itime = sb_dqopt(dquot->dq_sb)->info[type].dqi_igrace;
 	}
 	ret = 0;
-	if (filp)
-		ret = filp->f_op->write(filp, (char *)&dqblk,
-					sizeof(struct v1_disk_dqblk), &offset);
+	if (inode)
+		ret = inode->i_sb->s_op->quota_write(inode, (char *)&dqblk,
+					sizeof(struct v1_disk_dqblk), v1_dqoff(dquot->dq_id));
 	if (ret != sizeof(struct v1_disk_dqblk)) {
 		printk(KERN_WARNING "VFS: dquota write failed on dev %s\n",
 			dquot->dq_sb->s_id);
@@ -101,7 +88,6 @@
 	ret = 0;
 
 out:
-	set_fs(fs);
 	dqstats.writes++;
 
 	return ret;
@@ -121,14 +107,11 @@
 
 static int v1_check_quota_file(struct super_block *sb, int type)
 {
-	struct file *f = sb_dqopt(sb)->files[type];
-	struct inode *inode = f->f_dentry->d_inode;
+	struct inode *inode = sb_dqopt(sb)->files[type];
 	ulong blocks;
 	size_t off; 
 	struct v2_disk_dqheader dqhead;
-	mm_segment_t fs;
 	ssize_t size;
-	loff_t offset = 0;
 	loff_t isize;
 	static const uint quota_magics[] = V2_INITQMAGICS;
 
@@ -140,10 +123,7 @@
 	if ((blocks % sizeof(struct v1_disk_dqblk) * BLOCK_SIZE + off) % sizeof(struct v1_disk_dqblk))
 		return 0;
 	/* Doublecheck whether we didn't get file with new format - with old quotactl() this could happen */
-	fs = get_fs();
-	set_fs(KERNEL_DS);
-	size = f->f_op->read(f, (char *)&dqhead, sizeof(struct v2_disk_dqheader), &offset);
-	set_fs(fs);
+	size = sb->s_op->quota_read(inode, (char *)&dqhead, sizeof(struct v2_disk_dqheader), 0);
 	if (size != sizeof(struct v2_disk_dqheader))
 		return 1;	/* Probably not new format */
 	if (le32_to_cpu(dqhead.dqh_magic) != quota_magics[type])
@@ -155,16 +135,11 @@
 static int v1_read_file_info(struct super_block *sb, int type)
 {
 	struct quota_info *dqopt = sb_dqopt(sb);
-	mm_segment_t fs;
-	loff_t offset;
-	struct file *filp = dqopt->files[type];
+	struct inode *inode = dqopt->files[type];
 	struct v1_disk_dqblk dqblk;
 	int ret;
 
-	offset = v1_dqoff(0);
-	fs = get_fs();
-	set_fs(KERNEL_DS);
-	if ((ret = filp->f_op->read(filp, (char *)&dqblk, sizeof(struct v1_disk_dqblk), &offset)) != sizeof(struct v1_disk_dqblk)) {
+	if ((ret = sb->s_op->quota_read(inode, (char *)&dqblk, sizeof(struct v1_disk_dqblk), v1_dqoff(0))) != sizeof(struct v1_disk_dqblk)) {
 		if (ret >= 0)
 			ret = -EIO;
 		goto out;
@@ -173,38 +148,30 @@
 	dqopt->info[type].dqi_igrace = dqblk.dqb_itime ? dqblk.dqb_itime : MAX_IQ_TIME;
 	dqopt->info[type].dqi_bgrace = dqblk.dqb_btime ? dqblk.dqb_btime : MAX_DQ_TIME;
 out:
-	set_fs(fs);
 	return ret;
 }
 
 static int v1_write_file_info(struct super_block *sb, int type)
 {
 	struct quota_info *dqopt = sb_dqopt(sb);
-	mm_segment_t fs;
-	struct file *filp = dqopt->files[type];
+	struct inode *inode = dqopt->files[type];
 	struct v1_disk_dqblk dqblk;
-	loff_t offset;
 	int ret;
 
 	dqopt->info[type].dqi_flags &= ~DQF_INFO_DIRTY;
-	offset = v1_dqoff(0);
-	fs = get_fs();
-	set_fs(KERNEL_DS);
-	if ((ret = filp->f_op->read(filp, (char *)&dqblk, sizeof(struct v1_disk_dqblk), &offset)) != sizeof(struct v1_disk_dqblk)) {
+	if ((ret = sb->s_op->quota_read(inode, (char *)&dqblk, sizeof(struct v1_disk_dqblk), v1_dqoff(0))) != sizeof(struct v1_disk_dqblk)) {
 		if (ret >= 0)
 			ret = -EIO;
 		goto out;
 	}
 	dqblk.dqb_itime = dqopt->info[type].dqi_igrace;
 	dqblk.dqb_btime = dqopt->info[type].dqi_bgrace;
-	offset = v1_dqoff(0);
-	ret = filp->f_op->write(filp, (char *)&dqblk, sizeof(struct v1_disk_dqblk), &offset);
+	ret = sb->s_op->quota_write(inode, (char *)&dqblk, sizeof(struct v1_disk_dqblk), v1_dqoff(0));
 	if (ret == sizeof(struct v1_disk_dqblk))
 		ret = 0;
 	else if (ret > 0)
 		ret = -EIO;
 out:
-	set_fs(fs);
 	return ret;
 }
 
diff -ruX /home/jack/.kerndiffexclude linux-2.6-linus/fs/quota_v2.c linux-2.6-linus-pagelock/fs/quota_v2.c
--- linux-2.6-linus/fs/quota_v2.c	2004-11-12 19:45:04.000000000 +0100
+++ linux-2.6-linus-pagelock/fs/quota_v2.c	2004-11-14 20:21:07.000000000 +0100
@@ -13,7 +13,6 @@
 #include <linux/slab.h>
 
 #include <asm/byteorder.h>
-#include <asm/uaccess.h>
 
 MODULE_AUTHOR("Jan Kara");
 MODULE_DESCRIPTION("Quota format v2 support");
@@ -30,19 +29,16 @@
 static int v2_check_quota_file(struct super_block *sb, int type)
 {
 	struct v2_disk_dqheader dqhead;
-	struct file *f = sb_dqopt(sb)->files[type];
-	mm_segment_t fs;
+	struct inode *inode = sb_dqopt(sb)->files[type];
 	ssize_t size;
-	loff_t offset = 0;
 	static const uint quota_magics[] = V2_INITQMAGICS;
 	static const uint quota_versions[] = V2_INITQVERSIONS;
  
-	fs = get_fs();
-	set_fs(KERNEL_DS);
-	size = f->f_op->read(f, (char *)&dqhead, sizeof(struct v2_disk_dqheader), &offset);
-	set_fs(fs);
-	if (size != sizeof(struct v2_disk_dqheader))
+	size = sb->s_op->quota_read(inode, (char *)&dqhead, sizeof(struct v2_disk_dqheader), 0);
+	if (size != sizeof(struct v2_disk_dqheader)) {
+		printk("failed read\n");
 		return 0;
+	}
 	if (le32_to_cpu(dqhead.dqh_magic) != quota_magics[type] ||
 	    le32_to_cpu(dqhead.dqh_version) != quota_versions[type])
 		return 0;
@@ -52,20 +48,15 @@
 /* Read information header from quota file */
 static int v2_read_file_info(struct super_block *sb, int type)
 {
-	mm_segment_t fs;
 	struct v2_disk_dqinfo dinfo;
 	struct mem_dqinfo *info = sb_dqopt(sb)->info+type;
-	struct file *f = sb_dqopt(sb)->files[type];
+	struct inode *inode = sb_dqopt(sb)->files[type];
 	ssize_t size;
-	loff_t offset = V2_DQINFOOFF;
 
-	fs = get_fs();
-	set_fs(KERNEL_DS);
-	size = f->f_op->read(f, (char *)&dinfo, sizeof(struct v2_disk_dqinfo), &offset);
-	set_fs(fs);
+	size = sb->s_op->quota_read(inode, (char *)&dinfo, sizeof(struct v2_disk_dqinfo), V2_DQINFOOFF);
 	if (size != sizeof(struct v2_disk_dqinfo)) {
 		printk(KERN_WARNING "Can't read info structure on device %s.\n",
-			f->f_dentry->d_sb->s_id);
+			inode->i_sb->s_id);
 		return -1;
 	}
 	info->dqi_bgrace = le32_to_cpu(dinfo.dqi_bgrace);
@@ -80,12 +71,10 @@
 /* Write information header to quota file */
 static int v2_write_file_info(struct super_block *sb, int type)
 {
-	mm_segment_t fs;
 	struct v2_disk_dqinfo dinfo;
 	struct mem_dqinfo *info = sb_dqopt(sb)->info+type;
-	struct file *f = sb_dqopt(sb)->files[type];
+	struct inode *inode = sb_dqopt(sb)->files[type];
 	ssize_t size;
-	loff_t offset = V2_DQINFOOFF;
 
 	spin_lock(&dq_data_lock);
 	info->dqi_flags &= ~DQF_INFO_DIRTY;
@@ -96,13 +85,10 @@
 	dinfo.dqi_blocks = cpu_to_le32(info->u.v2_i.dqi_blocks);
 	dinfo.dqi_free_blk = cpu_to_le32(info->u.v2_i.dqi_free_blk);
 	dinfo.dqi_free_entry = cpu_to_le32(info->u.v2_i.dqi_free_entry);
-	fs = get_fs();
-	set_fs(KERNEL_DS);
-	size = f->f_op->write(f, (char *)&dinfo, sizeof(struct v2_disk_dqinfo), &offset);
-	set_fs(fs);
+	size = sb->s_op->quota_write(inode, (char *)&dinfo, sizeof(struct v2_disk_dqinfo), V2_DQINFOOFF);
 	if (size != sizeof(struct v2_disk_dqinfo)) {
 		printk(KERN_WARNING "Can't write info structure on device %s.\n",
-			f->f_dentry->d_sb->s_id);
+			inode->i_sb->s_id);
 		return -1;
 	}
 	return 0;
@@ -146,39 +132,22 @@
 	kfree(buf);
 }
 
-static ssize_t read_blk(struct file *filp, uint blk, dqbuf_t buf)
+static ssize_t read_blk(struct inode *inode, uint blk, dqbuf_t buf)
 {
-	mm_segment_t fs;
-	ssize_t ret;
-	loff_t offset = blk<<V2_DQBLKSIZE_BITS;
-
 	memset(buf, 0, V2_DQBLKSIZE);
-	fs = get_fs();
-	set_fs(KERNEL_DS);
-	ret = filp->f_op->read(filp, (char *)buf, V2_DQBLKSIZE, &offset);
-	set_fs(fs);
-	return ret;
+	return inode->i_sb->s_op->quota_read(inode, (char *)buf, V2_DQBLKSIZE, blk << V2_DQBLKSIZE_BITS);
 }
 
-static ssize_t write_blk(struct file *filp, uint blk, dqbuf_t buf)
+static ssize_t write_blk(struct inode *inode, uint blk, dqbuf_t buf)
 {
-	mm_segment_t fs;
-	ssize_t ret;
-	loff_t offset = blk<<V2_DQBLKSIZE_BITS;
-
-	fs = get_fs();
-	set_fs(KERNEL_DS);
-	ret = filp->f_op->write(filp, (char *)buf, V2_DQBLKSIZE, &offset);
-	set_fs(fs);
-	return ret;
-
+	return inode->i_sb->s_op->quota_write(inode, (char *)buf, V2_DQBLKSIZE, blk << V2_DQBLKSIZE_BITS);
 }
 
 /* Remove empty block from list and return it */
-static int get_free_dqblk(struct file *filp, int type)
+static int get_free_dqblk(struct inode *inode, int type)
 {
 	dqbuf_t buf = getdqbuf();
-	struct mem_dqinfo *info = sb_dqinfo(filp->f_dentry->d_sb, type);
+	struct mem_dqinfo *info = sb_dqinfo(inode->i_sb, type);
 	struct v2_disk_dqdbheader *dh = (struct v2_disk_dqdbheader *)buf;
 	int ret, blk;
 
@@ -186,17 +155,17 @@
 		return -ENOMEM;
 	if (info->u.v2_i.dqi_free_blk) {
 		blk = info->u.v2_i.dqi_free_blk;
-		if ((ret = read_blk(filp, blk, buf)) < 0)
+		if ((ret = read_blk(inode, blk, buf)) < 0)
 			goto out_buf;
 		info->u.v2_i.dqi_free_blk = le32_to_cpu(dh->dqdh_next_free);
 	}
 	else {
 		memset(buf, 0, V2_DQBLKSIZE);
-		if ((ret = write_blk(filp, info->u.v2_i.dqi_blocks, buf)) < 0)	/* Assure block allocation... */
+		if ((ret = write_blk(inode, info->u.v2_i.dqi_blocks, buf)) < 0)	/* Assure block allocation... */
 			goto out_buf;
 		blk = info->u.v2_i.dqi_blocks++;
 	}
-	mark_info_dirty(filp->f_dentry->d_sb, type);
+	mark_info_dirty(inode->i_sb, type);
 	ret = blk;
 out_buf:
 	freedqbuf(buf);
@@ -204,9 +173,9 @@
 }
 
 /* Insert empty block to the list */
-static int put_free_dqblk(struct file *filp, int type, dqbuf_t buf, uint blk)
+static int put_free_dqblk(struct inode *inode, int type, dqbuf_t buf, uint blk)
 {
-	struct mem_dqinfo *info = sb_dqinfo(filp->f_dentry->d_sb, type);
+	struct mem_dqinfo *info = sb_dqinfo(inode->i_sb, type);
 	struct v2_disk_dqdbheader *dh = (struct v2_disk_dqdbheader *)buf;
 	int err;
 
@@ -214,17 +183,17 @@
 	dh->dqdh_prev_free = cpu_to_le32(0);
 	dh->dqdh_entries = cpu_to_le16(0);
 	info->u.v2_i.dqi_free_blk = blk;
-	mark_info_dirty(filp->f_dentry->d_sb, type);
-	if ((err = write_blk(filp, blk, buf)) < 0)	/* Some strange block. We had better leave it... */
+	mark_info_dirty(inode->i_sb, type);
+	if ((err = write_blk(inode, blk, buf)) < 0)	/* Some strange block. We had better leave it... */
 		return err;
 	return 0;
 }
 
 /* Remove given block from the list of blocks with free entries */
-static int remove_free_dqentry(struct file *filp, int type, dqbuf_t buf, uint blk)
+static int remove_free_dqentry(struct inode *inode, int type, dqbuf_t buf, uint blk)
 {
 	dqbuf_t tmpbuf = getdqbuf();
-	struct mem_dqinfo *info = sb_dqinfo(filp->f_dentry->d_sb, type);
+	struct mem_dqinfo *info = sb_dqinfo(inode->i_sb, type);
 	struct v2_disk_dqdbheader *dh = (struct v2_disk_dqdbheader *)buf;
 	uint nextblk = le32_to_cpu(dh->dqdh_next_free), prevblk = le32_to_cpu(dh->dqdh_prev_free);
 	int err;
@@ -232,26 +201,26 @@
 	if (!tmpbuf)
 		return -ENOMEM;
 	if (nextblk) {
-		if ((err = read_blk(filp, nextblk, tmpbuf)) < 0)
+		if ((err = read_blk(inode, nextblk, tmpbuf)) < 0)
 			goto out_buf;
 		((struct v2_disk_dqdbheader *)tmpbuf)->dqdh_prev_free = dh->dqdh_prev_free;
-		if ((err = write_blk(filp, nextblk, tmpbuf)) < 0)
+		if ((err = write_blk(inode, nextblk, tmpbuf)) < 0)
 			goto out_buf;
 	}
 	if (prevblk) {
-		if ((err = read_blk(filp, prevblk, tmpbuf)) < 0)
+		if ((err = read_blk(inode, prevblk, tmpbuf)) < 0)
 			goto out_buf;
 		((struct v2_disk_dqdbheader *)tmpbuf)->dqdh_next_free = dh->dqdh_next_free;
-		if ((err = write_blk(filp, prevblk, tmpbuf)) < 0)
+		if ((err = write_blk(inode, prevblk, tmpbuf)) < 0)
 			goto out_buf;
 	}
 	else {
 		info->u.v2_i.dqi_free_entry = nextblk;
-		mark_info_dirty(filp->f_dentry->d_sb, type);
+		mark_info_dirty(inode->i_sb, type);
 	}
 	freedqbuf(tmpbuf);
 	dh->dqdh_next_free = dh->dqdh_prev_free = cpu_to_le32(0);
-	if (write_blk(filp, blk, buf) < 0)	/* No matter whether write succeeds block is out of list */
+	if (write_blk(inode, blk, buf) < 0)	/* No matter whether write succeeds block is out of list */
 		printk(KERN_ERR "VFS: Can't write block (%u) with free entries.\n", blk);
 	return 0;
 out_buf:
@@ -260,10 +229,10 @@
 }
 
 /* Insert given block to the beginning of list with free entries */
-static int insert_free_dqentry(struct file *filp, int type, dqbuf_t buf, uint blk)
+static int insert_free_dqentry(struct inode *inode, int type, dqbuf_t buf, uint blk)
 {
 	dqbuf_t tmpbuf = getdqbuf();
-	struct mem_dqinfo *info = sb_dqinfo(filp->f_dentry->d_sb, type);
+	struct mem_dqinfo *info = sb_dqinfo(inode->i_sb, type);
 	struct v2_disk_dqdbheader *dh = (struct v2_disk_dqdbheader *)buf;
 	int err;
 
@@ -271,18 +240,18 @@
 		return -ENOMEM;
 	dh->dqdh_next_free = cpu_to_le32(info->u.v2_i.dqi_free_entry);
 	dh->dqdh_prev_free = cpu_to_le32(0);
-	if ((err = write_blk(filp, blk, buf)) < 0)
+	if ((err = write_blk(inode, blk, buf)) < 0)
 		goto out_buf;
 	if (info->u.v2_i.dqi_free_entry) {
-		if ((err = read_blk(filp, info->u.v2_i.dqi_free_entry, tmpbuf)) < 0)
+		if ((err = read_blk(inode, info->u.v2_i.dqi_free_entry, tmpbuf)) < 0)
 			goto out_buf;
 		((struct v2_disk_dqdbheader *)tmpbuf)->dqdh_prev_free = cpu_to_le32(blk);
-		if ((err = write_blk(filp, info->u.v2_i.dqi_free_entry, tmpbuf)) < 0)
+		if ((err = write_blk(inode, info->u.v2_i.dqi_free_entry, tmpbuf)) < 0)
 			goto out_buf;
 	}
 	freedqbuf(tmpbuf);
 	info->u.v2_i.dqi_free_entry = blk;
-	mark_info_dirty(filp->f_dentry->d_sb, type);
+	mark_info_dirty(inode->i_sb, type);
 	return 0;
 out_buf:
 	freedqbuf(tmpbuf);
@@ -292,7 +261,7 @@
 /* Find space for dquot */
 static uint find_free_dqentry(struct dquot *dquot, int *err)
 {
-	struct file *filp = sb_dqopt(dquot->dq_sb)->files[dquot->dq_type];
+	struct inode *inode = sb_dqopt(dquot->dq_sb)->files[dquot->dq_type];
 	struct mem_dqinfo *info = sb_dqopt(dquot->dq_sb)->info+dquot->dq_type;
 	uint blk, i;
 	struct v2_disk_dqdbheader *dh;
@@ -309,11 +278,11 @@
 	ddquot = GETENTRIES(buf);
 	if (info->u.v2_i.dqi_free_entry) {
 		blk = info->u.v2_i.dqi_free_entry;
-		if ((*err = read_blk(filp, blk, buf)) < 0)
+		if ((*err = read_blk(inode, blk, buf)) < 0)
 			goto out_buf;
 	}
 	else {
-		blk = get_free_dqblk(filp, dquot->dq_type);
+		blk = get_free_dqblk(inode, dquot->dq_type);
 		if ((int)blk < 0) {
 			*err = blk;
 			freedqbuf(buf);
@@ -324,7 +293,7 @@
 		mark_info_dirty(dquot->dq_sb, dquot->dq_type);
 	}
 	if (le16_to_cpu(dh->dqdh_entries)+1 >= V2_DQSTRINBLK)	/* Block will be full? */
-		if ((*err = remove_free_dqentry(filp, dquot->dq_type, buf, blk)) < 0) {
+		if ((*err = remove_free_dqentry(inode, dquot->dq_type, buf, blk)) < 0) {
 			printk(KERN_ERR "VFS: find_free_dqentry(): Can't remove block (%u) from entry free list.\n", blk);
 			goto out_buf;
 		}
@@ -339,7 +308,7 @@
 		goto out_buf;
 	}
 #endif
-	if ((*err = write_blk(filp, blk, buf)) < 0) {
+	if ((*err = write_blk(inode, blk, buf)) < 0) {
 		printk(KERN_ERR "VFS: find_free_dqentry(): Can't write quota data block %u.\n", blk);
 		goto out_buf;
 	}
@@ -354,7 +323,7 @@
 /* Insert reference to structure into the trie */
 static int do_insert_tree(struct dquot *dquot, uint *treeblk, int depth)
 {
-	struct file *filp = sb_dqopt(dquot->dq_sb)->files[dquot->dq_type];
+	struct inode *inode = sb_dqopt(dquot->dq_sb)->files[dquot->dq_type];
 	dqbuf_t buf;
 	int ret = 0, newson = 0, newact = 0;
 	__le32 *ref;
@@ -363,7 +332,7 @@
 	if (!(buf = getdqbuf()))
 		return -ENOMEM;
 	if (!*treeblk) {
-		ret = get_free_dqblk(filp, dquot->dq_type);
+		ret = get_free_dqblk(inode, dquot->dq_type);
 		if (ret < 0)
 			goto out_buf;
 		*treeblk = ret;
@@ -371,7 +340,7 @@
 		newact = 1;
 	}
 	else {
-		if ((ret = read_blk(filp, *treeblk, buf)) < 0) {
+		if ((ret = read_blk(inode, *treeblk, buf)) < 0) {
 			printk(KERN_ERR "VFS: Can't read tree quota block %u.\n", *treeblk);
 			goto out_buf;
 		}
@@ -394,10 +363,10 @@
 		ret = do_insert_tree(dquot, &newblk, depth+1);
 	if (newson && ret >= 0) {
 		ref[GETIDINDEX(dquot->dq_id, depth)] = cpu_to_le32(newblk);
-		ret = write_blk(filp, *treeblk, buf);
+		ret = write_blk(inode, *treeblk, buf);
 	}
 	else if (newact && ret < 0)
-		put_free_dqblk(filp, dquot->dq_type, buf, *treeblk);
+		put_free_dqblk(inode, dquot->dq_type, buf, *treeblk);
 out_buf:
 	freedqbuf(buf);
 	return ret;
@@ -416,20 +385,17 @@
 static int v2_write_dquot(struct dquot *dquot)
 {
 	int type = dquot->dq_type;
-	struct file *filp;
-	mm_segment_t fs;
-	loff_t offset;
+	struct inode *inode;
 	ssize_t ret;
 	struct v2_disk_dqblk ddquot, empty;
 
 	/* dq_off is guarded by dqio_sem */
 	if (!dquot->dq_off)
 		if ((ret = dq_insert_tree(dquot)) < 0) {
-			printk(KERN_ERR "VFS: Error %Zd occurred while creating quota.\n", ret);
+			printk(KERN_ERR "VFS: Error %d occurred while creating quota.\n", ret);
 			return ret;
 		}
-	filp = sb_dqopt(dquot->dq_sb)->files[type];
-	offset = dquot->dq_off;
+	inode = sb_dqopt(dquot->dq_sb)->files[type];
 	spin_lock(&dq_data_lock);
 	mem2diskdqb(&ddquot, &dquot->dq_dqb, dquot->dq_id);
 	/* Argh... We may need to write structure full of zeroes but that would be
@@ -439,10 +405,7 @@
 	if (!memcmp(&empty, &ddquot, sizeof(struct v2_disk_dqblk)))
 		ddquot.dqb_itime = cpu_to_le64(1);
 	spin_unlock(&dq_data_lock);
-	fs = get_fs();
-	set_fs(KERNEL_DS);
-	ret = filp->f_op->write(filp, (char *)&ddquot, sizeof(struct v2_disk_dqblk), &offset);
-	set_fs(fs);
+	ret = inode->i_sb->s_op->quota_write(inode, (char *)&ddquot, sizeof(struct v2_disk_dqblk), dquot->dq_off);
 	if (ret != sizeof(struct v2_disk_dqblk)) {
 		printk(KERN_WARNING "VFS: dquota write failed on dev %s\n", dquot->dq_sb->s_id);
 		if (ret >= 0)
@@ -458,7 +421,7 @@
 /* Free dquot entry in data block */
 static int free_dqentry(struct dquot *dquot, uint blk)
 {
-	struct file *filp = sb_dqopt(dquot->dq_sb)->files[dquot->dq_type];
+	struct inode *inode = sb_dqopt(dquot->dq_sb)->files[dquot->dq_type];
 	struct v2_disk_dqdbheader *dh;
 	dqbuf_t buf = getdqbuf();
 	int ret = 0;
@@ -469,15 +432,15 @@
 		printk(KERN_ERR "VFS: Quota structure has offset to other block (%u) than it should (%u).\n", blk, (uint)(dquot->dq_off >> V2_DQBLKSIZE_BITS));
 		goto out_buf;
 	}
-	if ((ret = read_blk(filp, blk, buf)) < 0) {
+	if ((ret = read_blk(inode, blk, buf)) < 0) {
 		printk(KERN_ERR "VFS: Can't read quota data block %u\n", blk);
 		goto out_buf;
 	}
 	dh = (struct v2_disk_dqdbheader *)buf;
 	dh->dqdh_entries = cpu_to_le16(le16_to_cpu(dh->dqdh_entries)-1);
 	if (!le16_to_cpu(dh->dqdh_entries)) {	/* Block got free? */
-		if ((ret = remove_free_dqentry(filp, dquot->dq_type, buf, blk)) < 0 ||
-		    (ret = put_free_dqblk(filp, dquot->dq_type, buf, blk)) < 0) {
+		if ((ret = remove_free_dqentry(inode, dquot->dq_type, buf, blk)) < 0 ||
+		    (ret = put_free_dqblk(inode, dquot->dq_type, buf, blk)) < 0) {
 			printk(KERN_ERR "VFS: Can't move quota data block (%u) to free list.\n", blk);
 			goto out_buf;
 		}
@@ -486,13 +449,13 @@
 		memset(buf+(dquot->dq_off & ((1 << V2_DQBLKSIZE_BITS)-1)), 0, sizeof(struct v2_disk_dqblk));
 		if (le16_to_cpu(dh->dqdh_entries) == V2_DQSTRINBLK-1) {
 			/* Insert will write block itself */
-			if ((ret = insert_free_dqentry(filp, dquot->dq_type, buf, blk)) < 0) {
+			if ((ret = insert_free_dqentry(inode, dquot->dq_type, buf, blk)) < 0) {
 				printk(KERN_ERR "VFS: Can't insert quota data block (%u) to free entry list.\n", blk);
 				goto out_buf;
 			}
 		}
 		else
-			if ((ret = write_blk(filp, blk, buf)) < 0) {
+			if ((ret = write_blk(inode, blk, buf)) < 0) {
 				printk(KERN_ERR "VFS: Can't write quota data block %u\n", blk);
 				goto out_buf;
 			}
@@ -506,7 +469,7 @@
 /* Remove reference to dquot from tree */
 static int remove_tree(struct dquot *dquot, uint *blk, int depth)
 {
-	struct file *filp = sb_dqopt(dquot->dq_sb)->files[dquot->dq_type];
+	struct inode *inode = sb_dqopt(dquot->dq_sb)->files[dquot->dq_type];
 	dqbuf_t buf = getdqbuf();
 	int ret = 0;
 	uint newblk;
@@ -514,7 +477,7 @@
 	
 	if (!buf)
 		return -ENOMEM;
-	if ((ret = read_blk(filp, *blk, buf)) < 0) {
+	if ((ret = read_blk(inode, *blk, buf)) < 0) {
 		printk(KERN_ERR "VFS: Can't read quota data block %u\n", *blk);
 		goto out_buf;
 	}
@@ -530,11 +493,11 @@
 		ref[GETIDINDEX(dquot->dq_id, depth)] = cpu_to_le32(0);
 		for (i = 0; i < V2_DQBLKSIZE && !buf[i]; i++);	/* Block got empty? */
 		if (i == V2_DQBLKSIZE) {
-			put_free_dqblk(filp, dquot->dq_type, buf, *blk);
+			put_free_dqblk(inode, dquot->dq_type, buf, *blk);
 			*blk = 0;
 		}
 		else
-			if ((ret = write_blk(filp, *blk, buf)) < 0)
+			if ((ret = write_blk(inode, *blk, buf)) < 0)
 				printk(KERN_ERR "VFS: Can't write quota tree block %u.\n", *blk);
 	}
 out_buf:
@@ -555,7 +518,7 @@
 /* Find entry in block */
 static loff_t find_block_dqentry(struct dquot *dquot, uint blk)
 {
-	struct file *filp = sb_dqopt(dquot->dq_sb)->files[dquot->dq_type];
+	struct inode *inode = sb_dqopt(dquot->dq_sb)->files[dquot->dq_type];
 	dqbuf_t buf = getdqbuf();
 	loff_t ret = 0;
 	int i;
@@ -563,7 +526,7 @@
 
 	if (!buf)
 		return -ENOMEM;
-	if ((ret = read_blk(filp, blk, buf)) < 0) {
+	if ((ret = read_blk(inode, blk, buf)) < 0) {
 		printk(KERN_ERR "VFS: Can't read quota tree block %u.\n", blk);
 		goto out_buf;
 	}
@@ -592,14 +555,14 @@
 /* Find entry for given id in the tree */
 static loff_t find_tree_dqentry(struct dquot *dquot, uint blk, int depth)
 {
-	struct file *filp = sb_dqopt(dquot->dq_sb)->files[dquot->dq_type];
+	struct inode *inode = sb_dqopt(dquot->dq_sb)->files[dquot->dq_type];
 	dqbuf_t buf = getdqbuf();
 	loff_t ret = 0;
 	__le32 *ref = (__le32 *)buf;
 
 	if (!buf)
 		return -ENOMEM;
-	if ((ret = read_blk(filp, blk, buf)) < 0) {
+	if ((ret = read_blk(inode, blk, buf)) < 0) {
 		printk(KERN_ERR "VFS: Can't read quota tree block %u.\n", blk);
 		goto out_buf;
 	}
@@ -625,16 +588,15 @@
 static int v2_read_dquot(struct dquot *dquot)
 {
 	int type = dquot->dq_type;
-	struct file *filp;
-	mm_segment_t fs;
+	struct inode *inode;
 	loff_t offset;
 	struct v2_disk_dqblk ddquot, empty;
 	int ret = 0;
 
-	filp = sb_dqopt(dquot->dq_sb)->files[type];
+	inode = sb_dqopt(dquot->dq_sb)->files[type];
 
 #ifdef __QUOTA_V2_PARANOIA
-	if (!filp || !dquot->dq_sb) {	/* Invalidated quota? */
+	if (!inode || !dquot->dq_sb) {	/* Invalidated quota? */
 		printk(KERN_ERR "VFS: Quota invalidated while reading!\n");
 		return -EIO;
 	}
@@ -650,9 +612,7 @@
 	}
 	else {
 		dquot->dq_off = offset;
-		fs = get_fs();
-		set_fs(KERNEL_DS);
-		if ((ret = filp->f_op->read(filp, (char *)&ddquot, sizeof(struct v2_disk_dqblk), &offset)) != sizeof(struct v2_disk_dqblk)) {
+		if ((ret = inode->i_sb->s_op->quota_read(inode, (char *)&ddquot, sizeof(struct v2_disk_dqblk), offset)) != sizeof(struct v2_disk_dqblk)) {
 			if (ret >= 0)
 				ret = -EIO;
 			printk(KERN_ERR "VFS: Error while reading quota structure for id %u.\n", dquot->dq_id);
@@ -666,7 +626,6 @@
 			if (!memcmp(&empty, &ddquot, sizeof(struct v2_disk_dqblk)))
 				ddquot.dqb_itime = 0;
 		}
-		set_fs(fs);
 		disk2memdqb(&dquot->dq_dqb, &ddquot);
 		if (!dquot->dq_dqb.dqb_bhardlimit &&
 			!dquot->dq_dqb.dqb_bsoftlimit &&
diff -ruX /home/jack/.kerndiffexclude linux-2.6-linus/fs/reiserfs/bitmap.c linux-2.6-linus-pagelock/fs/reiserfs/bitmap.c
--- linux-2.6-linus/fs/reiserfs/bitmap.c	2004-11-12 19:45:12.000000000 +0100
+++ linux-2.6-linus-pagelock/fs/reiserfs/bitmap.c	2004-11-14 20:21:08.000000000 +0100
@@ -229,6 +229,9 @@
     unsigned long hash;
     unsigned bm;
 
+    /* If there is only one bitmap, we have no choice... */
+    if (SB_BMAP_NR(s) == 1)
+	return 0;
     if (id <= 2) {
 	bm = 1;
     } else {
@@ -613,7 +616,7 @@
 	/* give a portion of the block group to metadata */
 	if (hint->inode)
 	    hash += sb->s_blocksize/2;
-	hint->search_start = hash;
+	hint->search_start = hash >= SB_BLOCK_COUNT(sb) ? SB_BLOCK_COUNT(sb)-1 : hash;
     }
 }
 
@@ -642,7 +645,7 @@
 	    bm = bmap_hash_id(hint->inode->i_sb, oid);
 	    hash = bm * (hint->inode->i_sb->s_blocksize << 3);
 	}
-	hint->search_start = hash;
+	hint->search_start = hash >= SB_BLOCK_COUNT(hint->inode->i_sb) ? SB_BLOCK_COUNT(hint->inode->i_sb)-1 : hash;
     }
 }
 
@@ -956,14 +959,14 @@
     if (!hint->formatted_node) {
         int quota_ret;
 #ifdef REISERQUOTA_DEBUG
-	reiserfs_debug (s, "reiserquota: allocating %d blocks id=%u", amount_needed, hint->inode->i_uid);
+	reiserfs_debug (s, REISERFS_DEBUG_CODE, "reiserquota: allocating %d blocks id=%u", amount_needed, hint->inode->i_uid);
 #endif
 	quota_ret = DQUOT_ALLOC_BLOCK_NODIRTY(hint->inode, amount_needed);
 	if (quota_ret)    /* Quota exceeded? */
 	    return QUOTA_EXCEEDED;
 	if (hint->preallocate && hint->prealloc_size ) {
 #ifdef REISERQUOTA_DEBUG
-	    reiserfs_debug (s, "reiserquota: allocating (prealloc) %d blocks id=%u", hint->prealloc_size, hint->inode->i_uid);
+	    reiserfs_debug (s, REISERFS_DEBUG_CODE, "reiserquota: allocating (prealloc) %d blocks id=%u", hint->prealloc_size, hint->inode->i_uid);
 #endif
 	    quota_ret = DQUOT_PREALLOC_BLOCK_NODIRTY(hint->inode, hint->prealloc_size);
 	    if (quota_ret)
@@ -1009,7 +1012,7 @@
 	    /* Free the blocks */
 	    if (!hint->formatted_node) {
 #ifdef REISERQUOTA_DEBUG
-		reiserfs_debug (s, "reiserquota: freeing (nospace) %d blocks id=%u", amount_needed + hint->prealloc_size - nr_allocated, hint->inode->i_uid);
+		reiserfs_debug (s, REISERFS_DEBUG_CODE, "reiserquota: freeing (nospace) %d blocks id=%u", amount_needed + hint->prealloc_size - nr_allocated, hint->inode->i_uid);
 #endif
 		DQUOT_FREE_BLOCK_NODIRTY(hint->inode, amount_needed + hint->prealloc_size - nr_allocated);     /* Free not allocated blocks */
 	    }
@@ -1029,7 +1032,7 @@
 	 nr_allocated + REISERFS_I(hint->inode)->i_prealloc_count) {
     /* Some of preallocation blocks were not allocated */
 #ifdef REISERQUOTA_DEBUG
-	reiserfs_debug (s, "reiserquota: freeing (failed prealloc) %d blocks id=%u", amount_needed + hint->prealloc_size - nr_allocated - INODE_INFO(hint->inode)->i_prealloc_count, hint->inode->i_uid);
+	reiserfs_debug (s, REISERFS_DEBUG_CODE, "reiserquota: freeing (failed prealloc) %d blocks id=%u", amount_needed + hint->prealloc_size - nr_allocated - REISERFS_I(hint->inode)->i_prealloc_count, hint->inode->i_uid);
 #endif
 	DQUOT_FREE_BLOCK_NODIRTY(hint->inode, amount_needed +
 	                         hint->prealloc_size - nr_allocated -
diff -ruX /home/jack/.kerndiffexclude linux-2.6-linus/fs/reiserfs/file.c linux-2.6-linus-pagelock/fs/reiserfs/file.c
--- linux-2.6-linus/fs/reiserfs/file.c	2004-11-12 19:45:12.000000000 +0100
+++ linux-2.6-linus-pagelock/fs/reiserfs/file.c	2004-11-14 20:21:09.000000000 +0100
@@ -54,7 +54,7 @@
     /* freeing preallocation only involves relogging blocks that
      * are already in the current transaction.  preallocation gets
      * freed at the end of each transaction, so it is impossible for
-     * us to log any additional blocks
+     * us to log any additional blocks (including quota blocks)
      */
     err = journal_begin(&th, inode->i_sb, 1);
     if (err) {
@@ -201,7 +201,7 @@
     /* If we came here, it means we absolutely need to open a transaction,
        since we need to allocate some blocks */
     reiserfs_write_lock(inode->i_sb); // Journaling stuff and we need that.
-    res = journal_begin(th, inode->i_sb, JOURNAL_PER_BALANCE_CNT * 3 + 1); // Wish I know if this number enough
+    res = journal_begin(th, inode->i_sb, JOURNAL_PER_BALANCE_CNT * 3 + 1 + 2 * REISERFS_QUOTA_TRANS_BLOCKS); // Wish I know if this number enough
     if (res)
         goto error_exit;
     reiserfs_update_inode_transaction(inode) ;
@@ -576,7 +576,7 @@
         int err;
         // update any changes we made to blk count
         reiserfs_update_sd(th, inode);
-        err = journal_end(th, inode->i_sb, JOURNAL_PER_BALANCE_CNT * 3 + 1);
+        err = journal_end(th, inode->i_sb, JOURNAL_PER_BALANCE_CNT * 3 + 1 + 2 * REISERFS_QUOTA_TRANS_BLOCKS);
         if (err)
             res = err;
     }
diff -ruX /home/jack/.kerndiffexclude linux-2.6-linus/fs/reiserfs/inode.c linux-2.6-linus-pagelock/fs/reiserfs/inode.c
--- linux-2.6-linus/fs/reiserfs/inode.c	2004-11-12 19:45:12.000000000 +0100
+++ linux-2.6-linus-pagelock/fs/reiserfs/inode.c	2004-11-15 02:08:32.000000000 +0100
@@ -20,27 +20,17 @@
 
 extern int reiserfs_default_io_size; /* default io size devuned in super.c */
 
-/* args for the create parameter of reiserfs_get_block */
-#define GET_BLOCK_NO_CREATE 0 /* don't create new blocks or convert tails */
-#define GET_BLOCK_CREATE 1    /* add anything you need to find block */
-#define GET_BLOCK_NO_HOLE 2   /* return -ENOENT for file holes */
-#define GET_BLOCK_READ_DIRECT 4  /* read the tail if indirect item not found */
-#define GET_BLOCK_NO_ISEM     8 /* i_sem is not held, don't preallocate */
-#define GET_BLOCK_NO_DANGLE   16 /* don't leave any transactions running */
-
-static int reiserfs_get_block (struct inode * inode, sector_t block,
-			       struct buffer_head * bh_result, int create);
 static int reiserfs_commit_write(struct file *f, struct page *page,
                                  unsigned from, unsigned to);
 
 void reiserfs_delete_inode (struct inode * inode)
 {
-    int jbegin_count = JOURNAL_PER_BALANCE_CNT * 2; 
+    /* We need blocks for transaction + (user+group) quota update (possibly delete) */
+    int jbegin_count = JOURNAL_PER_BALANCE_CNT * 2 + 2 * REISERFS_QUOTA_INIT_BLOCKS; 
     struct reiserfs_transaction_handle th ;
   
     reiserfs_write_lock(inode->i_sb);
 
-    DQUOT_FREE_INODE(inode);
     /* The = 0 happens when we abort creating a new inode for some reason like lack of space.. */
     if (!(inode->i_state & I_NEW) && INODE_PKEY(inode)->k_objectid != 0) { /* also handles bad_inode case */
 	down (&inode->i_sem); 
@@ -58,6 +48,11 @@
 	    goto out;
 	}
 
+	/* Do quota update inside a transaction for journaled quotas. We must do that
+	 * after delete_object so that quota updates go into the same transaction as
+	 * stat data deletion */
+	DQUOT_FREE_INODE(inode);
+
 	if (journal_end(&th, inode->i_sb, jbegin_count)) {
 	    up (&inode->i_sem);
 	    goto out;
@@ -592,8 +587,9 @@
         . 3 balancings in direct->indirect conversion
         . 1 block involved into reiserfs_update_sd()
        XXX in practically impossible worst case direct2indirect()
-       can incur (much) more that 3 balancings. */
-    int jbegin_count = JOURNAL_PER_BALANCE_CNT * 3 + 1;
+       can incur (much) more than 3 balancings.
+       quota update for user, group */
+    int jbegin_count = JOURNAL_PER_BALANCE_CNT * 3 + 1 + 2 * REISERFS_QUOTA_TRANS_BLOCKS;
     int version;
     int dangle = 1;
     loff_t new_offset = (((loff_t)block) << inode->i_sb->s_blocksize_bits) + 1 ;
@@ -1697,6 +1693,10 @@
 
     BUG_ON (!th->t_trans_id);
   
+    if (DQUOT_ALLOC_INODE(inode)) {
+	err = -EDQUOT;
+	goto out_end_trans;
+    }
     if (!dir || !dir->i_nlink) {
 	err = -EPERM;
 	goto out_bad_inode;
@@ -1864,9 +1864,12 @@
     /* Invalidate the object, nothing was inserted yet */
     INODE_PKEY(inode)->k_objectid = 0;
 
-    /* dquot_drop must be done outside a transaction */
-    journal_end(th, th->t_super, th->t_blocks_allocated) ;
+    /* Quota change must be inside a transaction for journaling */
     DQUOT_FREE_INODE(inode);
+
+out_end_trans:
+    journal_end(th, th->t_super, th->t_blocks_allocated) ;
+    /* Drop can be outside and it needs more credits so it's better to have it outside */
     DQUOT_DROP(inode);
     inode->i_flags |= S_NOQUOTA;
     make_bad_inode(inode);
@@ -2794,8 +2797,25 @@
 	    (ia_valid & ATTR_GID && attr->ia_gid != inode->i_gid)) {
                 error = reiserfs_chown_xattrs (inode, attr);
 
-                if (!error)
+                if (!error) {
+		    struct reiserfs_transaction_handle th;
+
+		    /* (user+group)*(old+new) structure - we count quota info and , inode write (sb, inode) */
+		    journal_begin(&th, inode->i_sb, 4*REISERFS_QUOTA_INIT_BLOCKS+2);
                     error = DQUOT_TRANSFER(inode, attr) ? -EDQUOT : 0;
+		    if (error) {
+			journal_end(&th, inode->i_sb, 4*REISERFS_QUOTA_INIT_BLOCKS+2);
+			goto out;
+		    }
+		    /* Update corresponding info in inode so that everything is in
+		     * one transaction */
+		    if (attr->ia_valid & ATTR_UID)
+			inode->i_uid = attr->ia_uid;
+		    if (attr->ia_valid & ATTR_GID)
+			inode->i_gid = attr->ia_gid;
+		    mark_inode_dirty(inode);
+		    journal_end(&th, inode->i_sb, 4*REISERFS_QUOTA_INIT_BLOCKS+2);
+		}
         }
         if (!error)
             error = inode_setattr(inode, attr) ;
diff -ruX /home/jack/.kerndiffexclude linux-2.6-linus/fs/reiserfs/journal.c linux-2.6-linus-pagelock/fs/reiserfs/journal.c
--- linux-2.6-linus/fs/reiserfs/journal.c	2004-11-12 19:45:12.000000000 +0100
+++ linux-2.6-linus-pagelock/fs/reiserfs/journal.c	2004-11-15 01:31:14.000000000 +0100
@@ -2647,6 +2647,7 @@
   int retval;
 
   reiserfs_check_lock_depth(p_s_sb, "journal_begin") ;
+  RFALSE( SB_JOURNAL_MAX_BATCH(p_s_sb) < nblocks+2, "transaction too big (%u < %u)", SB_JOURNAL_MAX_BATCH(p_s_sb), nblocks+2);
 
   PROC_INFO_INC( p_s_sb, journal.journal_being );
   /* set here for journal_join */
diff -ruX /home/jack/.kerndiffexclude linux-2.6-linus/fs/reiserfs/namei.c linux-2.6-linus-pagelock/fs/reiserfs/namei.c
--- linux-2.6-linus/fs/reiserfs/namei.c	2004-11-12 19:45:12.000000000 +0100
+++ linux-2.6-linus-pagelock/fs/reiserfs/namei.c	2004-11-14 20:21:11.000000000 +0100
@@ -545,7 +545,7 @@
 
 /* quota utility function, call if you've had to abort after calling
 ** new_inode_init, and have not called reiserfs_new_inode yet.
-** This should only be called on inodes that do not hav stat data
+** This should only be called on inodes that do not have stat data
 ** inserted into the tree yet.
 */
 static int drop_new_inode(struct inode *inode) {
@@ -557,10 +557,9 @@
 }
 
 /* utility function that does setup for reiserfs_new_inode.  
-** DQUOT_ALLOC_INODE cannot be called inside a transaction, so we had
-** to pull some bits of reiserfs_new_inode out into this func.
-** Yes, the actual quota calls are missing, they are part of the quota
-** patch.
+** DQUOT_INIT needs lots of credits so it's better to have it
+** outside of a transaction, so we had to pull some bits of
+** reiserfs_new_inode out into this func.
 */
 static int new_inode_init(struct inode *inode, struct inode *dir, int mode) {
 
@@ -578,10 +577,6 @@
         inode->i_gid = current->fsgid;
     }
     DQUOT_INIT(inode);
-    if (DQUOT_ALLOC_INODE(inode)) {
-        drop_new_inode(inode);
-	return -EDQUOT;
-    }
     return 0 ;
 }
 
@@ -590,16 +585,15 @@
 {
     int retval;
     struct inode * inode;
-    int jbegin_count = JOURNAL_PER_BALANCE_CNT * 2 ;
+    /* We need blocks for transaction + (user+group)*(quotas for new inode + update of quota for directory owner) */
+    int jbegin_count = JOURNAL_PER_BALANCE_CNT * 2 + 2 * (REISERFS_QUOTA_INIT_BLOCKS+REISERFS_QUOTA_TRANS_BLOCKS);
     struct reiserfs_transaction_handle th ;
     int locked;
 
     if (!(inode = new_inode(dir->i_sb))) {
 	return -ENOMEM ;
     }
-    retval = new_inode_init(inode, dir, mode);
-    if (retval)
-        return retval;
+    new_inode_init(inode, dir, mode);
 
     locked = reiserfs_cache_default_acl (dir);
 
@@ -658,7 +652,8 @@
     int retval;
     struct inode * inode;
     struct reiserfs_transaction_handle th ;
-    int jbegin_count = JOURNAL_PER_BALANCE_CNT * 3; 
+    /* We need blocks for transaction + (user+group)*(quotas for new inode + update of quota for directory owner) */
+    int jbegin_count = JOURNAL_PER_BALANCE_CNT * 3 + 2 * (REISERFS_QUOTA_INIT_BLOCKS+REISERFS_QUOTA_TRANS_BLOCKS); 
     int locked;
 
     if (!new_valid_dev(rdev))
@@ -667,9 +662,7 @@
     if (!(inode = new_inode(dir->i_sb))) {
 	return -ENOMEM ;
     }
-    retval = new_inode_init(inode, dir, mode);
-    if (retval)
-        return retval;
+    new_inode_init(inode, dir, mode);
 
     locked = reiserfs_cache_default_acl (dir);
 
@@ -733,7 +726,8 @@
     int retval;
     struct inode * inode;
     struct reiserfs_transaction_handle th ;
-    int jbegin_count = JOURNAL_PER_BALANCE_CNT * 3; 
+    /* We need blocks for transaction + (user+group)*(quotas for new inode + update of quota for directory owner) */
+    int jbegin_count = JOURNAL_PER_BALANCE_CNT * 3 + 2 * (REISERFS_QUOTA_INIT_BLOCKS+REISERFS_QUOTA_TRANS_BLOCKS); 
     int locked;
 
 #ifdef DISPLACE_NEW_PACKING_LOCALITIES
@@ -744,9 +738,7 @@
     if (!(inode = new_inode(dir->i_sb))) {
 	return -ENOMEM ;
     }
-    retval = new_inode_init(inode, dir, mode);
-    if (retval)
-        return retval;
+    new_inode_init(inode, dir, mode);
 
     locked = reiserfs_cache_default_acl (dir);
 
@@ -836,8 +828,9 @@
     struct reiserfs_dir_entry de;
 
 
-    /* we will be doing 2 balancings and update 2 stat data */
-    jbegin_count = JOURNAL_PER_BALANCE_CNT * 2 + 2;
+    /* we will be doing 2 balancings and update 2 stat data, we change quotas
+     * of the owner of the directory and of the owner of the parent directory */
+    jbegin_count = JOURNAL_PER_BALANCE_CNT * 2 + 2 + 2 * (REISERFS_QUOTA_INIT_BLOCKS+REISERFS_QUOTA_TRANS_BLOCKS);
 
     reiserfs_write_lock(dir->i_sb);
     retval = journal_begin(&th, dir->i_sb, jbegin_count) ;
@@ -920,8 +913,9 @@
     inode = dentry->d_inode;
 
     /* in this transaction we can be doing at max two balancings and update
-       two stat datas */
-    jbegin_count = JOURNAL_PER_BALANCE_CNT * 2 + 2;
+       two stat datas, we change quotas of the owner of the directory and of
+       the owner of the parent directory */
+    jbegin_count = JOURNAL_PER_BALANCE_CNT * 2 + 2 + 2 * (REISERFS_QUOTA_INIT_BLOCKS+REISERFS_QUOTA_TRANS_BLOCKS);
 
     reiserfs_write_lock(dir->i_sb);
     retval = journal_begin(&th, dir->i_sb, jbegin_count) ;
@@ -1005,15 +999,13 @@
     int item_len;
     struct reiserfs_transaction_handle th ;
     int mode = S_IFLNK | S_IRWXUGO;
-    int jbegin_count = JOURNAL_PER_BALANCE_CNT * 3; 
+    /* We need blocks for transaction + (user+group)*(quotas for new inode + update of quota for directory owner) */
+    int jbegin_count = JOURNAL_PER_BALANCE_CNT * 3 + 2 * (REISERFS_QUOTA_INIT_BLOCKS+REISERFS_QUOTA_TRANS_BLOCKS); 
 
     if (!(inode = new_inode(parent_dir->i_sb))) {
 	return -ENOMEM ;
     }
-    retval = new_inode_init(inode, parent_dir, mode);
-    if (retval) {
-        return retval;
-    }
+    new_inode_init(inode, parent_dir, mode);
 
     reiserfs_write_lock(parent_dir->i_sb);
     item_len = ROUND_UP (strlen (symname));
@@ -1083,7 +1075,8 @@
     int retval;
     struct inode *inode = old_dentry->d_inode;
     struct reiserfs_transaction_handle th ;
-    int jbegin_count = JOURNAL_PER_BALANCE_CNT * 3; 
+    /* We need blocks for transaction + update of quotas for the owners of the directory */
+    int jbegin_count = JOURNAL_PER_BALANCE_CNT * 3 + 2 * REISERFS_QUOTA_TRANS_BLOCKS; 
 
     reiserfs_write_lock(dir->i_sb);
     if (inode->i_nlink >= REISERFS_LINK_MAX) {
@@ -1201,8 +1194,9 @@
        (2) new directory and (3) maybe old object stat data (when it is
        directory) and (4) maybe stat data of object to which new entry
        pointed initially and (5) maybe block containing ".." of
-       renamed directory */
-    jbegin_count = JOURNAL_PER_BALANCE_CNT * 3 + 5;
+       renamed directory
+       quota updates: two parent directories */
+    jbegin_count = JOURNAL_PER_BALANCE_CNT * 3 + 5 + 4 * REISERFS_QUOTA_TRANS_BLOCKS;
 
     old_inode = old_dentry->d_inode;
     new_dentry_inode = new_dentry->d_inode;
diff -ruX /home/jack/.kerndiffexclude linux-2.6-linus/fs/reiserfs/stree.c linux-2.6-linus-pagelock/fs/reiserfs/stree.c
--- linux-2.6-linus/fs/reiserfs/stree.c	2004-11-12 19:45:13.000000000 +0100
+++ linux-2.6-linus-pagelock/fs/reiserfs/stree.c	2004-11-14 20:21:11.000000000 +0100
@@ -1388,7 +1388,7 @@
     do_balance(&s_del_balance, NULL, NULL, M_DELETE);
 
 #ifdef REISERQUOTA_DEBUG
-    reiserfs_debug (p_s_sb, "reiserquota delete_item(): freeing %u, id=%u type=%c", quota_cut_bytes, p_s_inode->i_uid, head2type(&s_ih));
+    reiserfs_debug (p_s_sb, REISERFS_DEBUG_CODE, "reiserquota delete_item(): freeing %u, id=%u type=%c", quota_cut_bytes, p_s_inode->i_uid, head2type(&s_ih));
 #endif
     DQUOT_FREE_SPACE_NODIRTY(p_s_inode, quota_cut_bytes);
 
@@ -1465,7 +1465,7 @@
 	    do_balance (&tb, NULL, NULL, M_DELETE);
 	    if (inode) {	/* Should we count quota for item? (we don't count quotas for save-links) */
 #ifdef REISERQUOTA_DEBUG
-		reiserfs_debug (th->t_super, "reiserquota delete_solid_item(): freeing %u id=%u type=%c", quota_cut_bytes, inode->i_uid, key2type(key));
+		reiserfs_debug (th->t_super, REISERFS_DEBUG_CODE, "reiserquota delete_solid_item(): freeing %u id=%u type=%c", quota_cut_bytes, inode->i_uid, key2type(key));
 #endif
 		DQUOT_FREE_SPACE_NODIRTY(inode, quota_cut_bytes);
 	    }
@@ -1786,7 +1786,7 @@
 	REISERFS_I(p_s_inode)->i_flags &= ~i_pack_on_close_mask ;
     }
 #ifdef REISERQUOTA_DEBUG
-    reiserfs_debug (p_s_inode->i_sb, "reiserquota cut_from_item(): freeing %u id=%u type=%c", quota_cut_bytes, p_s_inode->i_uid, '?');
+    reiserfs_debug (p_s_inode->i_sb, REISERFS_DEBUG_CODE, "reiserquota cut_from_item(): freeing %u id=%u type=%c", quota_cut_bytes, p_s_inode->i_uid, '?');
 #endif
     DQUOT_FREE_SPACE_NODIRTY(p_s_inode, quota_cut_bytes);
     return n_ret_value;
@@ -1999,7 +1999,7 @@
     fs_gen = get_generation(inode->i_sb) ;
 
 #ifdef REISERQUOTA_DEBUG
-    reiserfs_debug (inode->i_sb, "reiserquota paste_into_item(): allocating %u id=%u type=%c", n_pasted_size, inode->i_uid, key2type(&(p_s_key->on_disk_key)));
+    reiserfs_debug (inode->i_sb, REISERFS_DEBUG_CODE, "reiserquota paste_into_item(): allocating %u id=%u type=%c", n_pasted_size, inode->i_uid, key2type(&(p_s_key->on_disk_key)));
 #endif
 
     if (DQUOT_ALLOC_SPACE_NODIRTY(inode, n_pasted_size)) {
@@ -2048,7 +2048,7 @@
     /* this also releases the path */
     unfix_nodes(&s_paste_balance);
 #ifdef REISERQUOTA_DEBUG
-    reiserfs_debug (inode->i_sb, "reiserquota paste_into_item(): freeing %u id=%u type=%c", n_pasted_size, inode->i_uid, key2type(&(p_s_key->on_disk_key)));
+    reiserfs_debug (inode->i_sb, REISERFS_DEBUG_CODE, "reiserquota paste_into_item(): freeing %u id=%u type=%c", n_pasted_size, inode->i_uid, key2type(&(p_s_key->on_disk_key)));
 #endif
     DQUOT_FREE_SPACE_NODIRTY(inode, n_pasted_size);
     return retval ;
@@ -2081,7 +2081,7 @@
 	    quota_bytes = inode->i_sb->s_blocksize + UNFM_P_SIZE ;
 	}
 #ifdef REISERQUOTA_DEBUG
-	reiserfs_debug (inode->i_sb, "reiserquota insert_item(): allocating %u id=%u type=%c", quota_bytes, inode->i_uid, head2type(p_s_ih));
+	reiserfs_debug (inode->i_sb, REISERFS_DEBUG_CODE, "reiserquota insert_item(): allocating %u id=%u type=%c", quota_bytes, inode->i_uid, head2type(p_s_ih));
 #endif
 	/* We can't dirty inode here. It would be immediately written but
 	 * appropriate stat item isn't inserted yet... */
@@ -2127,7 +2127,7 @@
     /* also releases the path */
     unfix_nodes(&s_ins_balance);
 #ifdef REISERQUOTA_DEBUG
-    reiserfs_debug (th->t_super, "reiserquota insert_item(): freeing %u id=%u type=%c", quota_bytes, inode->i_uid, head2type(p_s_ih));
+    reiserfs_debug (th->t_super, REISERFS_DEBUG_CODE, "reiserquota insert_item(): freeing %u id=%u type=%c", quota_bytes, inode->i_uid, head2type(p_s_ih));
 #endif
     if (inode)
 	DQUOT_FREE_SPACE_NODIRTY(inode, quota_bytes) ;
diff -ruX /home/jack/.kerndiffexclude linux-2.6-linus/fs/reiserfs/super.c linux-2.6-linus-pagelock/fs/reiserfs/super.c
--- linux-2.6-linus/fs/reiserfs/super.c	2004-11-12 19:45:13.000000000 +0100
+++ linux-2.6-linus-pagelock/fs/reiserfs/super.c	2004-11-15 01:30:32.000000000 +0100
@@ -25,6 +25,9 @@
 #include <linux/buffer_head.h>
 #include <linux/vfs.h>
 #include <linux/namespace.h>
+#include <linux/mount.h>
+#include <linux/namei.h>
+#include <linux/quotaops.h>
 
 struct file_system_type reiserfs_fs_type;
 
@@ -62,7 +65,7 @@
 static int reiserfs_remount (struct super_block * s, int * flags, char * data);
 static int reiserfs_statfs (struct super_block * s, struct kstatfs * buf);
 
-static void reiserfs_sync_fs (struct super_block * s)
+static int reiserfs_sync_fs (struct super_block * s, int wait)
 {
     if (!(s->s_flags & MS_RDONLY)) {
         struct reiserfs_transaction_handle th;
@@ -76,11 +79,12 @@
     } else {
         s->s_dirt = 0;
     }
+    return 0;
 }
 
 static void reiserfs_write_super(struct super_block *s)
 {
-    reiserfs_sync_fs(s);
+    reiserfs_sync_fs(s, 1);
 }
 
 static void reiserfs_write_super_lockfs (struct super_block * s)
@@ -134,6 +138,9 @@
      return journal_end (&th, s, JOURNAL_PER_BALANCE_CNT);
 }
  
+#ifdef CONFIG_QUOTA
+static int reiserfs_quota_on_mount(struct super_block *, int);
+#endif
  
 /* look for uncompleted unlinks and truncates and complete them */
 static int finish_unfinished (struct super_block * s)
@@ -149,12 +156,28 @@
     int done;
     struct inode * inode;
     int truncate;
+#ifdef CONFIG_QUOTA
+    int i;
+#endif
  
  
     /* compose key to look for "save" links */
     max_cpu_key.version = KEY_FORMAT_3_5;
     max_cpu_key.on_disk_key = MAX_KEY;
     max_cpu_key.key_length = 3;
+
+#ifdef CONFIG_QUOTA
+    /* Needed for iput() to work correctly and not trash data */
+    s->s_flags |= MS_ACTIVE;
+    /* Turn on quotas so that they are updated correctly */
+    for (i = 0; i < MAXQUOTAS; i++) {
+	if (REISERFS_SB(s)->s_qf_names[i]) {
+	    int ret = reiserfs_quota_on_mount(s, i);
+	    if (ret < 0)
+		reiserfs_warning(s, "reiserfs: cannot turn on journalled quota: error %d", ret);
+	}
+    }
+#endif
  
     done = 0;
     REISERFS_SB(s)->s_is_unlinked_ok = 1;
@@ -211,6 +234,7 @@
             retval = remove_save_link_only (s, &save_link_key, 0);
             continue;
 	}
+	DQUOT_INIT(inode);
 
 	if (truncate && S_ISDIR (inode->i_mode) ) {
 	    /* We got a truncate request for a dir which is impossible.
@@ -246,6 +270,15 @@
     }
     REISERFS_SB(s)->s_is_unlinked_ok = 0;
      
+#ifdef CONFIG_QUOTA
+    /* Turn quotas off */
+    for (i = 0; i < MAXQUOTAS; i++) {
+            if (sb_dqopt(s)->files[i])
+                    vfs_quota_off_mount(s, i);
+    }
+    /* Restore the flag back */
+    s->s_flags &= ~MS_ACTIVE;
+#endif
     pathrelse (&path);
     if (done)
         reiserfs_info (s, "There were %d uncompleted unlinks/truncates. "
@@ -516,6 +549,11 @@
     REISERFS_I(inode)->i_acl_default = NULL;
 }
 
+#ifdef CONFIG_QUOTA
+static ssize_t reiserfs_quota_write(struct inode *, const char *, size_t, loff_t);
+static ssize_t reiserfs_quota_read(struct inode *, char *, size_t, loff_t);
+#endif
+
 struct super_operations reiserfs_sops = 
 {
   .alloc_inode = reiserfs_alloc_inode,
@@ -526,13 +564,57 @@
   .clear_inode  = reiserfs_clear_inode,
   .put_super = reiserfs_put_super,
   .write_super = reiserfs_write_super,
+  .sync_fs = reiserfs_sync_fs,
   .write_super_lockfs = reiserfs_write_super_lockfs,
   .unlockfs = reiserfs_unlockfs,
   .statfs = reiserfs_statfs,
   .remount_fs = reiserfs_remount,
+#ifdef CONFIG_QUOTA
+  .quota_read = reiserfs_quota_read,
+  .quota_write = reiserfs_quota_write,
+#endif
+};
+
+#ifdef CONFIG_QUOTA
+#define QTYPE2NAME(t) ((t)==USRQUOTA?"user":"group")
 
+static int reiserfs_dquot_initialize(struct inode *, int);
+static int reiserfs_dquot_drop(struct inode *);
+static int reiserfs_write_dquot(struct dquot *);
+static int reiserfs_acquire_dquot(struct dquot *);
+static int reiserfs_release_dquot(struct dquot *);
+static int reiserfs_mark_dquot_dirty(struct dquot *);
+static int reiserfs_write_info(struct super_block *, int);
+static int reiserfs_quota_on(struct super_block *, int, int, char *);
+
+static struct dquot_operations reiserfs_quota_operations =
+{
+  .initialize = reiserfs_dquot_initialize,
+  .drop = reiserfs_dquot_drop,
+  .alloc_space = dquot_alloc_space,
+  .alloc_inode = dquot_alloc_inode,
+  .free_space = dquot_free_space,
+  .free_inode = dquot_free_inode,
+  .transfer = dquot_transfer,
+  .write_dquot = reiserfs_write_dquot,
+  .acquire_dquot = reiserfs_acquire_dquot,
+  .release_dquot = reiserfs_release_dquot,
+  .mark_dirty = reiserfs_mark_dquot_dirty,
+  .write_info = reiserfs_write_info,
 };
 
+static struct quotactl_ops reiserfs_qctl_operations =
+{
+  .quota_on = reiserfs_quota_on,
+  .quota_off = vfs_quota_off,
+  .quota_sync = vfs_quota_sync,
+  .get_info = vfs_get_dqinfo,
+  .set_info = vfs_set_dqinfo,
+  .get_dqblk = vfs_get_dqblk,
+  .set_dqblk = vfs_set_dqblk,
+};
+#endif
+
 static struct export_operations reiserfs_export_ops = {
   .encode_fh = reiserfs_encode_fh,
   .decode_fh = reiserfs_decode_fh,
@@ -551,6 +633,8 @@
 		    applied BEFORE setmask */
 } arg_desc_t;
 
+/* Set this bit in arg_required to allow empty arguments */
+#define REISERFS_OPT_ALLOWEMPTY 31
 
 /* this struct is used in reiserfs_getopt() for describing the set of reiserfs
    mount options */
@@ -703,8 +787,8 @@
     /* move to the argument, or to next option if argument is not required */
     p ++;
     
-    if ( opt->arg_required && !strlen (p) ) {
-	/* this catches "option=," */
+    if ( opt->arg_required && !(opt->arg_required & (1<<REISERFS_OPT_ALLOWEMPTY)) && !strlen (p) ) {
+	/* this catches "option=," if not allowed */
 	reiserfs_warning (s, "empty argument for \"%s\"", opt->option_name);
 	return -1;
     }
@@ -712,7 +796,7 @@
     if (!opt->values) {
 	/* *=NULLopt_arg contains pointer to argument */
 	*opt_arg = p;
-	return opt->arg_required;
+	return opt->arg_required & ~(1<<REISERFS_OPT_ALLOWEMPTY);
     }
     
     /* values possible for this option are listed in opt->values */
@@ -776,6 +860,9 @@
 	{"usrquota",},
 	{"grpquota",},
 	{"errors", 	.arg_required = 'e', .values = error_actions},
+	{"usrjquota",	.arg_required = 'u'|(1<<REISERFS_OPT_ALLOWEMPTY), .values = NULL},
+	{"grpjquota",	.arg_required = 'g'|(1<<REISERFS_OPT_ALLOWEMPTY), .values = NULL},
+	{"jqfmt",	.arg_required = 'f', .values = NULL},
 	{NULL,}
     };
 	
@@ -837,8 +924,62 @@
 		*jdev_name = arg;
 	    }
 	}
+
+#ifdef CONFIG_QUOTA
+	if (c == 'u' || c == 'g') {
+	    int qtype = c == 'u' ? USRQUOTA : GRPQUOTA;
+
+	    if (sb_any_quota_enabled(s)) {
+		reiserfs_warning(s, "reiserfs_parse_options: cannot change journalled quota options when quota turned on.");
+		return 0;
+	    }
+	    if (*arg) {	/* Some filename specified? */
+	        if (REISERFS_SB(s)->s_qf_names[qtype] && strcmp(REISERFS_SB(s)->s_qf_names[qtype], arg)) {
+		    reiserfs_warning(s, "reiserfs_parse_options: %s quota file already specified.", QTYPE2NAME(qtype));
+		    return 0;
+		}
+		if (strchr(arg, '/')) {
+		    reiserfs_warning(s, "reiserfs_parse_options: quotafile must be on filesystem root.");
+		    return 0;
+		}
+	    	REISERFS_SB(s)->s_qf_names[qtype] = kmalloc(strlen(arg)+1, GFP_KERNEL);
+		if (!REISERFS_SB(s)->s_qf_names[qtype]) {
+		    reiserfs_warning(s, "reiserfs_parse_options: not enough memory for storing quotafile name.");
+		    return 0;
+		}
+		strcpy(REISERFS_SB(s)->s_qf_names[qtype], arg);
+	    }
+	    else {
+		if (REISERFS_SB(s)->s_qf_names[qtype]) {
+		    kfree(REISERFS_SB(s)->s_qf_names[qtype]);
+		    REISERFS_SB(s)->s_qf_names[qtype] = NULL;
+		}
+	    }
+	}
+	if (c == 'f') {
+	    if (!strcmp(arg, "vfsold"))
+		REISERFS_SB(s)->s_jquota_fmt = QFMT_VFS_OLD;
+	    else if (!strcmp(arg, "vfsv0"))
+		REISERFS_SB(s)->s_jquota_fmt = QFMT_VFS_V0;
+	    else {
+		reiserfs_warning(s, "reiserfs_parse_options: unknown quota format specified.");
+		return 0;
+	    }
+	}
+#else
+	if (c == 'u' || c == 'g' || c == 'f') {
+	    reiserfs_warning(s, "reiserfs_parse_options: journalled quota options not supported.");
+	    return 0;
+	}
+#endif
     }
     
+#ifdef CONFIG_QUOTA
+    if (!REISERFS_SB(s)->s_jquota_fmt && (REISERFS_SB(s)->s_qf_names[USRQUOTA] || REISERFS_SB(s)->s_qf_names[GRPQUOTA])) {
+	reiserfs_warning(s, "reiserfs_parse_options: journalled quota format not specified.");
+	return 0;
+    }
+#endif
     return 1;
 }
 
@@ -914,11 +1055,22 @@
   unsigned int commit_max_age = (unsigned int)-1;
   struct reiserfs_journal *journal = SB_JOURNAL(s);
   int err;
+#ifdef CONFIG_QUOTA
+  int i;
+#endif
 
   rs = SB_DISK_SUPER_BLOCK (s);
 
-  if (!reiserfs_parse_options(s, arg, &mount_options, &blocks, NULL, &commit_max_age))
+  if (!reiserfs_parse_options(s, arg, &mount_options, &blocks, NULL, &commit_max_age)) {
+#ifdef CONFIG_QUOTA
+    for (i = 0; i < MAXQUOTAS; i++)
+	if (REISERFS_SB(s)->s_qf_names[i]) {
+	    kfree(REISERFS_SB(s)->s_qf_names[i]);
+	    REISERFS_SB(s)->s_qf_names[i] = NULL;
+	}
+#endif
     return -EINVAL;
+  }
   
   handle_attrs(s);
 
@@ -1223,6 +1375,10 @@
 
     s->s_op = &reiserfs_sops;
     s->s_export_op = &reiserfs_export_ops;
+#ifdef CONFIG_QUOTA
+    s->s_qcop = &reiserfs_qctl_operations;
+    s->dq_op = &reiserfs_quota_operations;
+#endif
 
     /* new format is limited by the 32 bit wide i_blocks field, want to
     ** be one full block below that.
@@ -1654,7 +1810,12 @@
     }
     if (SB_BUFFER_WITH_SB (s))
 	brelse(SB_BUFFER_WITH_SB (s));
-
+#ifdef CONFIG_QUOTA
+    for (j = 0; j < MAXQUOTAS; j++) {
+	if (sbi->s_qf_names[j])
+	    kfree(sbi->s_qf_names[j]);
+    }
+#endif
     if (sbi != NULL) {
 	kfree(sbi);
     }
@@ -1678,6 +1839,246 @@
   return 0;
 }
 
+#ifdef CONFIG_QUOTA
+static int reiserfs_dquot_initialize(struct inode *inode, int type)
+{
+    struct reiserfs_transaction_handle th;
+    int ret;
+
+    /* We may create quota structure so we need to reserve enough blocks */
+    journal_begin(&th, inode->i_sb, 2*REISERFS_QUOTA_INIT_BLOCKS);
+    ret = dquot_initialize(inode, type);
+    journal_end(&th, inode->i_sb, 2*REISERFS_QUOTA_INIT_BLOCKS);
+    return ret;
+}
+
+static int reiserfs_dquot_drop(struct inode *inode)
+{
+    struct reiserfs_transaction_handle th;
+    int ret;
+
+    /* We may delete quota structure so we need to reserve enough blocks */
+    journal_begin(&th, inode->i_sb, 2*REISERFS_QUOTA_INIT_BLOCKS);
+    ret = dquot_drop(inode);
+    journal_end(&th, inode->i_sb, 2*REISERFS_QUOTA_INIT_BLOCKS);
+    return ret;
+}
+
+static int reiserfs_write_dquot(struct dquot *dquot)
+{
+    struct reiserfs_transaction_handle th;
+    int ret;
+
+    journal_begin(&th, dquot->dq_sb, REISERFS_QUOTA_TRANS_BLOCKS);
+    ret = dquot_commit(dquot);
+    journal_end(&th, dquot->dq_sb, REISERFS_QUOTA_TRANS_BLOCKS);
+    return ret;
+}
+
+static int reiserfs_acquire_dquot(struct dquot *dquot)
+{
+    struct reiserfs_transaction_handle th;
+    int ret;
+
+    journal_begin(&th, dquot->dq_sb, REISERFS_QUOTA_INIT_BLOCKS);
+    ret = dquot_acquire(dquot);
+    journal_end(&th, dquot->dq_sb, REISERFS_QUOTA_INIT_BLOCKS);
+    return ret;
+}
+
+static int reiserfs_release_dquot(struct dquot *dquot)
+{
+    struct reiserfs_transaction_handle th;
+    int ret;
+
+    journal_begin(&th, dquot->dq_sb, REISERFS_QUOTA_INIT_BLOCKS);
+    ret = dquot_release(dquot);
+    journal_end(&th, dquot->dq_sb, REISERFS_QUOTA_INIT_BLOCKS);
+    return ret;
+}
+
+static int reiserfs_mark_dquot_dirty(struct dquot *dquot)
+{
+    /* Are we journalling quotas? */
+    if (REISERFS_SB(dquot->dq_sb)->s_qf_names[USRQUOTA] ||
+        REISERFS_SB(dquot->dq_sb)->s_qf_names[GRPQUOTA]) {
+	dquot_mark_dquot_dirty(dquot);
+	return reiserfs_write_dquot(dquot);
+    }
+    else
+	return dquot_mark_dquot_dirty(dquot);
+}
+
+static int reiserfs_write_info(struct super_block *sb, int type)
+{
+    struct reiserfs_transaction_handle th;
+    int ret;
+
+    /* Data block + inode block */
+    journal_begin(&th, sb, 2);
+    ret = dquot_commit_info(sb, type);
+    journal_end(&th, sb, 2);
+    return ret;
+}
+
+/*
+ * Turn on quotas during mount time - we need to find
+ * the quota file and such...
+ */
+static int reiserfs_quota_on_mount(struct super_block *sb, int type)
+{
+    int err;
+    struct dentry *dentry;
+    struct qstr name = { .name = REISERFS_SB(sb)->s_qf_names[type],
+                         .hash = 0,
+                         .len = strlen(REISERFS_SB(sb)->s_qf_names[type])};
+
+    dentry = lookup_hash(&name, sb->s_root);
+    if (IS_ERR(dentry))
+            return PTR_ERR(dentry);
+    err = vfs_quota_on_mount(type, REISERFS_SB(sb)->s_jquota_fmt, dentry);
+    /* Now invalidate and put the dentry - quota got its own reference
+     * to inode and dentry has at least wrong hash so we had better
+     * throw it away */
+    d_invalidate(dentry);
+    dput(dentry);
+    return err;
+}
+
+/*
+ * Standard function to be called on quota_on
+ */
+static int reiserfs_quota_on(struct super_block *sb, int type, int format_id, char *path)
+{
+    int err;
+    struct nameidata nd;
+
+    err = path_lookup(path, LOOKUP_FOLLOW, &nd);
+    if (err)
+        return err;
+    /* Quotafile not on the same filesystem? */
+    if (nd.mnt->mnt_sb != sb) {
+	path_release(&nd);
+        return -EXDEV;
+    }
+    /* We must not pack tails for quota files on reiserfs for quota IO to work */
+    if (!REISERFS_I(nd.dentry->d_inode)->i_flags & i_nopack_mask) {
+	reiserfs_warning(sb, "reiserfs: Quota file must have tail packing disabled.");
+	path_release(&nd);
+	return -EINVAL;
+    }
+    /* Not journalling quota? No more tests needed... */
+    if (!REISERFS_SB(sb)->s_qf_names[USRQUOTA] &&
+        !REISERFS_SB(sb)->s_qf_names[GRPQUOTA]) {
+	path_release(&nd);
+        return vfs_quota_on(sb, type, format_id, path);
+    }
+    /* Quotafile not of fs root? */
+    if (nd.dentry->d_parent->d_inode != sb->s_root->d_inode)
+	reiserfs_warning(sb, "reiserfs: Quota file not on filesystem root. "
+                             "Journalled quota will not work.");
+    path_release(&nd);
+    return vfs_quota_on(sb, type, format_id, path);
+}
+
+/* Read data from quotafile - avoid pagecache and such because we cannot afford
+ * acquiring the locks... As quota files are never truncated and quota code
+ * itself serializes the operations (and noone else should touch the files)
+ * we don't have to be afraid of races */
+static ssize_t reiserfs_quota_read(struct inode *inode, char *data, size_t len, loff_t off)
+{
+    struct super_block *sb = inode->i_sb;
+    unsigned long blk = off >> sb->s_blocksize_bits;
+    int err = 0, offset = off & (sb->s_blocksize - 1), tocopy;
+    size_t toread;
+    struct buffer_head tmp_bh, *bh;
+    loff_t i_size = i_size_read(inode);
+
+    if (off > i_size)
+	return 0;
+    if (off+len > i_size)
+	len = i_size-off;
+    toread = len;
+    while (toread > 0) {
+	tocopy = sb->s_blocksize - offset < toread ? sb->s_blocksize - offset : toread;
+	tmp_bh.b_state = 0;
+	/* Quota files are without tails so we can safely use this function */
+	err = reiserfs_get_block(inode, blk, &tmp_bh, 0);
+	if (err)
+	    return err;
+	if (!buffer_mapped(&tmp_bh))    /* A hole? */
+	    memset(data, 0, tocopy);
+	else {
+	    bh = sb_bread(sb, tmp_bh.b_blocknr);
+	    if (!bh)
+		return -EIO;
+	    memcpy(data, bh->b_data+offset, tocopy);
+	    brelse(bh);
+	}
+	offset = 0;
+	toread -= tocopy;
+	data += tocopy;
+	blk++;
+    }
+    return len;
+}
+
+/* Write to quotafile (we know the transaction is already started and has
+ * enough credits) */
+static ssize_t reiserfs_quota_write(struct inode *inode, const char *data,
+                                    size_t len, loff_t off)
+{
+    struct super_block *sb = inode->i_sb;
+    unsigned long blk = off >> sb->s_blocksize_bits;
+    int err = 0, offset = off & (sb->s_blocksize - 1), tocopy;
+    size_t towrite = len;
+    struct buffer_head tmp_bh, *bh;
+    struct reiserfs_transaction_handle th;
+
+    down(&inode->i_sem);
+    while (towrite > 0) {
+	tocopy = sb->s_blocksize - offset < towrite ?
+	         sb->s_blocksize - offset : towrite;
+	tmp_bh.b_state = 0;
+	err = reiserfs_get_block(inode, blk, &tmp_bh, GET_BLOCK_CREATE);
+	if (err)
+	    goto out;
+	if (offset || tocopy != sb->s_blocksize)
+	    bh = sb_bread(sb, tmp_bh.b_blocknr);
+	else
+	    bh = sb_getblk(sb, tmp_bh.b_blocknr);
+	if (!bh) {
+	    err = -EIO;
+	    goto out;
+	}
+	memcpy(bh->b_data+offset, data, tocopy);
+	set_buffer_uptodate(bh);
+	reiserfs_prepare_for_journal(sb, bh, 1);
+	/* Sadly we have to start transaction because we are nested in
+	 * a transaction and the buffer could be removed from the transaction */
+	journal_begin(&th, sb, 1);
+	journal_mark_dirty(&th, sb, bh);
+	journal_end(&th, sb, 1);
+	brelse(bh);
+	offset = 0;
+	towrite -= tocopy;
+	data += tocopy;
+	blk++;
+    }
+out:
+    if (len == towrite)
+	return err;
+    if (inode->i_size < off+len-towrite)
+	i_size_write(inode, off+len-towrite);
+    inode->i_version++;
+    inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+    mark_inode_dirty(inode);
+    up(&inode->i_sem);
+    return len - towrite;
+}
+
+#endif
+
 static struct super_block*
 get_super_block (struct file_system_type *fs_type, int flags,
 		 const char *dev_name, void *data)
diff -ruX /home/jack/.kerndiffexclude linux-2.6-linus/include/linux/fs.h linux-2.6-linus-pagelock/include/linux/fs.h
--- linux-2.6-linus/include/linux/fs.h	2004-11-12 19:45:39.000000000 +0100
+++ linux-2.6-linus-pagelock/include/linux/fs.h	2004-11-14 20:21:13.000000000 +0100
@@ -992,6 +992,9 @@
 	void (*umount_begin) (struct super_block *);
 
 	int (*show_options)(struct seq_file *, struct vfsmount *);
+
+	ssize_t (*quota_read)(struct inode *, char *, size_t, loff_t);
+	ssize_t (*quota_write)(struct inode *, const char *, size_t, loff_t);
 };
 
 /* Inode state bits.  Protected by inode_lock. */
diff -ruX /home/jack/.kerndiffexclude linux-2.6-linus/include/linux/quota.h linux-2.6-linus-pagelock/include/linux/quota.h
--- linux-2.6-linus/include/linux/quota.h	2004-11-12 19:45:41.000000000 +0100
+++ linux-2.6-linus-pagelock/include/linux/quota.h	2004-11-14 20:21:15.000000000 +0100
@@ -285,7 +285,7 @@
 	struct semaphore dqio_sem;		/* lock device while I/O in progress */
 	struct semaphore dqonoff_sem;		/* Serialize quotaon & quotaoff */
 	struct rw_semaphore dqptr_sem;		/* serialize ops using quota_info struct, pointers from inode to dquots */
-	struct file *files[MAXQUOTAS];		/* fp's to quotafiles */
+	struct inode *files[MAXQUOTAS];		/* inodes of quotafiles */
 	struct mem_dqinfo info[MAXQUOTAS];	/* Information for each quota type */
 	struct quota_format_ops *ops[MAXQUOTAS];	/* Operations for each type */
 };
diff -ruX /home/jack/.kerndiffexclude linux-2.6-linus/include/linux/reiserfs_fs.h linux-2.6-linus-pagelock/include/linux/reiserfs_fs.h
--- linux-2.6-linus/include/linux/reiserfs_fs.h	2004-11-12 19:45:41.000000000 +0100
+++ linux-2.6-linus-pagelock/include/linux/reiserfs_fs.h	2004-11-15 01:47:09.000000000 +0100
@@ -1688,6 +1688,13 @@
 #define JOURNAL_MAX_COMMIT_AGE 30 
 #define JOURNAL_MAX_TRANS_AGE 30
 #define JOURNAL_PER_BALANCE_CNT (3 * (MAX_HEIGHT-2) + 9)
+#ifdef CONFIG_QUOTA
+#define REISERFS_QUOTA_TRANS_BLOCKS 2	/* We need to update data and inode (atime) */
+#define REISERFS_QUOTA_INIT_BLOCKS (DQUOT_MAX_WRITES*(JOURNAL_PER_BALANCE_CNT+2)+1)	/* 1 balancing, 1 bitmap, 1 data per write + stat data update */
+#else
+#define REISERFS_QUOTA_TRANS_BLOCKS 0
+#define REISERFS_QUOTA_INIT_BLOCKS 0
+#endif
 
 /* both of these can be as low as 1, or as high as you want.  The min is the
 ** number of 4k bitmap nodes preallocated on mount. New nodes are allocated
@@ -1930,12 +1937,21 @@
 void padd_item (char * item, int total_length, int length);
 
 /* inode.c */
+/* args for the create parameter of reiserfs_get_block */
+#define GET_BLOCK_NO_CREATE 0 /* don't create new blocks or convert tails */
+#define GET_BLOCK_CREATE 1    /* add anything you need to find block */
+#define GET_BLOCK_NO_HOLE 2   /* return -ENOENT for file holes */
+#define GET_BLOCK_READ_DIRECT 4  /* read the tail if indirect item not found */
+#define GET_BLOCK_NO_ISEM     8 /* i_sem is not held, don't preallocate */
+#define GET_BLOCK_NO_DANGLE   16 /* don't leave any transactions running */
+
 int restart_transaction(struct reiserfs_transaction_handle *th, struct inode *inode, struct path *path);
 void reiserfs_read_locked_inode(struct inode * inode, struct reiserfs_iget_args *args) ;
 int reiserfs_find_actor(struct inode * inode, void *p) ;
 int reiserfs_init_locked_inode(struct inode * inode, void *p) ;
 void reiserfs_delete_inode (struct inode * inode);
 int reiserfs_write_inode (struct inode * inode, int) ;
+int reiserfs_get_block (struct inode * inode, sector_t block, struct buffer_head * bh_result, int create);
 struct dentry *reiserfs_get_dentry(struct super_block *, void *) ;
 struct dentry *reiserfs_decode_fh(struct super_block *sb, __u32 *data,
                                      int len, int fhtype,
diff -ruX /home/jack/.kerndiffexclude linux-2.6-linus/include/linux/reiserfs_fs_sb.h linux-2.6-linus-pagelock/include/linux/reiserfs_fs_sb.h
--- linux-2.6-linus/include/linux/reiserfs_fs_sb.h	2004-11-12 19:45:41.000000000 +0100
+++ linux-2.6-linus-pagelock/include/linux/reiserfs_fs_sb.h	2004-11-14 20:21:17.000000000 +0100
@@ -410,6 +410,10 @@
     struct rw_semaphore xattr_dir_sem;
 
     int j_errno;
+#ifdef CONFIG_QUOTA
+    char *s_qf_names[MAXQUOTAS];
+    int s_jquota_fmt;
+#endif
 };
 
 /* Definitions of reiserfs on-disk properties: */
diff -ruX /home/jack/.kerndiffexclude linux-2.6-linus/include/linux/security.h linux-2.6-linus-pagelock/include/linux/security.h
--- linux-2.6-linus/include/linux/security.h	2004-11-12 19:45:41.000000000 +0100
+++ linux-2.6-linus-pagelock/include/linux/security.h	2004-11-14 20:21:17.000000000 +0100
@@ -1034,7 +1034,7 @@
 	int (*sysctl) (struct ctl_table * table, int op);
 	int (*capable) (struct task_struct * tsk, int cap);
 	int (*quotactl) (int cmds, int type, int id, struct super_block * sb);
-	int (*quota_on) (struct file * f);
+	int (*quota_on) (struct dentry * dentry);
 	int (*syslog) (int type);
 	int (*settime) (struct timespec *ts, struct timezone *tz);
 	int (*vm_enough_memory) (long pages);
@@ -1281,9 +1281,9 @@
 	return security_ops->quotactl (cmds, type, id, sb);
 }
 
-static inline int security_quota_on (struct file * file)
+static inline int security_quota_on (struct dentry * dentry)
 {
-	return security_ops->quota_on (file);
+	return security_ops->quota_on (dentry);
 }
 
 static inline int security_syslog(int type)
@@ -1959,7 +1959,7 @@
 	return 0;
 }
 
-static inline int security_quota_on (struct file * file)
+static inline int security_quota_on (struct dentry * dentry)
 {
 	return 0;
 }
Only in linux-2.6-linus-pagelock/: linux
diff -ruX /home/jack/.kerndiffexclude linux-2.6-linus/security/dummy.c linux-2.6-linus-pagelock/security/dummy.c
--- linux-2.6-linus/security/dummy.c	2004-11-12 19:45:57.000000000 +0100
+++ linux-2.6-linus-pagelock/security/dummy.c	2004-11-14 20:21:18.000000000 +0100
@@ -92,7 +92,7 @@
 	return 0;
 }
 
-static int dummy_quota_on (struct file *f)
+static int dummy_quota_on (struct dentry *dentry)
 {
 	return 0;
 }
diff -ruX /home/jack/.kerndiffexclude linux-2.6-linus/security/selinux/hooks.c linux-2.6-linus-pagelock/security/selinux/hooks.c
--- linux-2.6-linus/security/selinux/hooks.c	2004-11-12 19:45:57.000000000 +0100
+++ linux-2.6-linus-pagelock/security/selinux/hooks.c	2004-11-14 20:21:19.000000000 +0100
@@ -1491,9 +1491,9 @@
 	return rc;
 }
 
-static int selinux_quota_on(struct file *f)
+static int selinux_quota_on(struct dentry *dentry)
 {
-	return file_has_perm(current, f, FILE__QUOTAON);
+	return dentry_has_perm(current, NULL, dentry, FILE__QUOTAON);
 }
 
 static int selinux_syslog(int type)

--VbJkn9YxBvnuCH5J--
