Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261417AbVBNMEt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbVBNMEt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 07:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261424AbVBNMEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 07:04:48 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:53991 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261417AbVBNMCa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 07:02:30 -0500
Date: Mon, 14 Feb 2005 13:02:31 +0100
From: Jan Kara <jack@suse.cz>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix UFS quota
Message-ID: <20050214120231.GE9612@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hello Andrew!

  Attached patch adds functions ufs_quota_read() and ufs_quota_write()
to the UFS code. So quotas for UFS should work again (they were broken by
the quota io redesign). I don't actually think the patch is too much
important as I'm not sure anybody uses quotas on UFS but we're in the
"stable" branch so just dropping a support did not seem right
to me...
								Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs

--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="quota-2.6.11-rc2-ufsquota.diff"

Implement quota reading and writing functions for UFS.

Signed-off-by: Jan Kara <jack@suse.cz>

diff -rupX /home/jack/.kerndiffexclude linux-2.6.11-rc2-3-time/fs/ufs/super.c linux-2.6.11-rc2-4-ufsquota/fs/ufs/super.c
--- linux-2.6.11-rc2-3-time/fs/ufs/super.c	2005-01-05 17:19:34.000000000 +0100
+++ linux-2.6.11-rc2-4-ufsquota/fs/ufs/super.c	2005-02-06 18:16:08.000000000 +0100
@@ -1196,6 +1196,11 @@ static void destroy_inodecache(void)
 		printk(KERN_INFO "ufs_inode_cache: not all structures were freed\n");
 }
 
+#ifdef CONFIG_QUOTA
+static ssize_t ufs_quota_read(struct super_block *, int, char *,size_t, loff_t);
+static ssize_t ufs_quota_write(struct super_block *, int, const char *, size_t, loff_t);
+#endif
+
 static struct super_operations ufs_super_ops = {
 	.alloc_inode	= ufs_alloc_inode,
 	.destroy_inode	= ufs_destroy_inode,
@@ -1206,8 +1211,102 @@ static struct super_operations ufs_super
 	.write_super	= ufs_write_super,
 	.statfs		= ufs_statfs,
 	.remount_fs	= ufs_remount,
+#ifdef CONFIG_QUOTA
+	.quota_read	= ufs_quota_read,
+	.quota_write	= ufs_quota_write,
+#endif
 };
 
+#ifdef CONFIG_QUOTA
+
+/* Read data from quotafile - avoid pagecache and such because we cannot afford
+ * acquiring the locks... As quota files are never truncated and quota code
+ * itself serializes the operations (and noone else should touch the files)
+ * we don't have to be afraid of races */
+static ssize_t ufs_quota_read(struct super_block *sb, int type, char *data,
+			       size_t len, loff_t off)
+{
+	struct inode *inode = sb_dqopt(sb)->files[type];
+	sector_t blk = off >> sb->s_blocksize_bits;
+	int err = 0;
+	int offset = off & (sb->s_blocksize - 1);
+	int tocopy;
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
+
+		bh = ufs_bread(inode, blk, 0, &err);
+		if (err)
+			return err;
+		if (!bh)	/* A hole? */
+			memset(data, 0, tocopy);
+		else {
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
+static ssize_t ufs_quota_write(struct super_block *sb, int type,
+				const char *data, size_t len, loff_t off)
+{
+	struct inode *inode = sb_dqopt(sb)->files[type];
+	sector_t blk = off >> sb->s_blocksize_bits;
+	int err = 0;
+	int offset = off & (sb->s_blocksize - 1);
+	int tocopy;
+	size_t towrite = len;
+	struct buffer_head *bh;
+
+	down(&inode->i_sem);
+	while (towrite > 0) {
+		tocopy = sb->s_blocksize - offset < towrite ?
+				sb->s_blocksize - offset : towrite;
+
+		bh = ufs_bread(inode, blk, 1, &err);
+		if (!bh)
+			goto out;
+		lock_buffer(bh);
+		memcpy(bh->b_data+offset, data, tocopy);
+		flush_dcache_page(bh->b_page);
+		set_buffer_uptodate(bh);
+		mark_buffer_dirty(bh);
+		unlock_buffer(bh);
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
+	inode->i_mtime = inode->i_ctime = CURRENT_TIME_SEC;
+	mark_inode_dirty(inode);
+	up(&inode->i_sem);
+	return len - towrite;
+}
+
+#endif
+
 static struct super_block *ufs_get_sb(struct file_system_type *fs_type,
 	int flags, const char *dev_name, void *data)
 {

--u3/rZRmxL6MmkK24--
