Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932440AbWACQr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbWACQr6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 11:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbWACQr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 11:47:57 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:63113 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932449AbWACQro (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 11:47:44 -0500
Date: Tue, 3 Jan 2006 17:47:13 +0100
From: Ingo Molnar <mingo@elte.hu>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Nicolas Pitre <nico@cam.org>,
       Jes Sorensen <jes@trained-monkey.org>, Al Viro <viro@ftp.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [patch 14/19] mutex subsystem, semaphore to mutex: VFS, ->i_sem, more
Message-ID: <20060103164713.GO25802@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


more i_sem -> i_mutex conversions that were needed for my .config.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 fs/cifs/inode.c               |    2 +-
 fs/ext2/acl.c                 |    8 ++++----
 fs/ext2/ext2.h                |    2 +-
 fs/ext2/xattr.c               |    2 +-
 fs/ext3/acl.c                 |    8 ++++----
 fs/ext3/xattr.c               |    2 +-
 fs/jfs/jfs_incore.h           |    4 ++--
 fs/libfs.c                    |    2 +-
 fs/nfs/dir.c                  |    6 +++---
 fs/nfsd/nfs4recover.c         |   20 ++++++++++----------
 fs/ntfs/attrib.c              |    4 ++--
 fs/ntfs/dir.c                 |    8 ++++----
 fs/ntfs/index.c               |    6 +++---
 fs/ntfs/inode.c               |    4 ++--
 fs/ntfs/namei.c               |    2 +-
 fs/quota.c                    |    2 +-
 fs/reiserfs/inode.c           |    4 ++--
 fs/reiserfs/tail_conversion.c |    2 +-
 fs/reiserfs/xattr.c           |   16 ++++++++--------
 fs/reiserfs/xattr_acl.c       |    6 +++---
 fs/sysfs/inode.c              |    2 +-
 fs/xfs/linux-2.6/xfs_iops.c   |    2 +-
 fs/xfs/linux-2.6/xfs_lrw.c    |    2 +-
 fs/xfs/xfs_dmapi.h            |   14 +++++++-------
 include/linux/ext3_fs_i.h     |    2 +-
 include/linux/fs.h            |    4 ++--
 include/linux/jffs2_fs_i.h    |    4 ++--
 include/linux/nfsd/nfsfh.h    |    2 +-
 include/linux/reiserfs_fs.h   |    2 +-
 ipc/mqueue.c                  |    8 ++++----
 kernel/cpuset.c               |   10 +++++-----
 mm/filemap.c                  |   14 +++++++-------
 mm/filemap_xip.c              |    4 ++--
 mm/msync.c                    |    2 +-
 mm/rmap.c                     |    8 ++++----
 mm/shmem.c                    |    2 +-
 mm/truncate.c                 |    2 +-
 security/inode.c              |    8 ++++----
 sound/core/oss/pcm_oss.c      |    4 ++--
 sound/core/seq/seq_memory.c   |    4 ----
 40 files changed, 103 insertions(+), 107 deletions(-)

Index: linux/fs/cifs/inode.c
===================================================================
--- linux.orig/fs/cifs/inode.c
+++ linux/fs/cifs/inode.c
@@ -1041,7 +1041,7 @@ int cifs_revalidate(struct dentry *diren
 
 	/* can not grab this sem since kernel filesys locking documentation
 	   indicates i_mutex may be taken by the kernel on lookup and rename
-	   which could deadlock if we grab the i_sem here as well */
+	   which could deadlock if we grab the i_mutex here as well */
 /*	mutex_lock(&direntry->d_inode->i_mutex);*/
 	/* need to write out dirty pages here  */
 	if (direntry->d_inode->i_mapping) {
Index: linux/fs/ext2/acl.c
===================================================================
--- linux.orig/fs/ext2/acl.c
+++ linux/fs/ext2/acl.c
@@ -211,7 +211,7 @@ ext2_get_acl(struct inode *inode, int ty
 }
 
 /*
- * inode->i_mutex: down
+ * inode->i_mutex: locked
  */
 static int
 ext2_set_acl(struct inode *inode, int type, struct posix_acl *acl)
@@ -301,8 +301,8 @@ ext2_permission(struct inode *inode, int
 /*
  * Initialize the ACLs of a new inode. Called from ext2_new_inode.
  *
- * dir->i_mutex: down
- * inode->i_mutex: up (access to inode is still exclusive)
+ * dir->i_mutex: locked
+ * inode->i_mutex: unlocked (access to inode is still exclusive)
  */
 int
 ext2_init_acl(struct inode *inode, struct inode *dir)
@@ -361,7 +361,7 @@ cleanup:
  * for directories) are added. There are no more bits available in the
  * file mode.
  *
- * inode->i_mutex: down
+ * inode->i_mutex: locked
  */
 int
 ext2_acl_chmod(struct inode *inode)
Index: linux/fs/ext2/ext2.h
===================================================================
--- linux.orig/fs/ext2/ext2.h
+++ linux/fs/ext2/ext2.h
@@ -53,7 +53,7 @@ struct ext2_inode_info {
 #ifdef CONFIG_EXT2_FS_XATTR
 	/*
 	 * Extended attributes can be read independently of the main file
-	 * data. Taking i_sem even when reading would cause contention
+	 * data. Taking i_mutex even when reading would cause contention
 	 * between readers of EAs and writers of regular file data, so
 	 * instead we synchronize on xattr_sem when reading or changing
 	 * EAs.
Index: linux/fs/ext2/xattr.c
===================================================================
--- linux.orig/fs/ext2/xattr.c
+++ linux/fs/ext2/xattr.c
@@ -325,7 +325,7 @@ cleanup:
 /*
  * Inode operation listxattr()
  *
- * dentry->d_inode->i_sem: don't care
+ * dentry->d_inode->i_mutex: don't care
  */
 ssize_t
 ext2_listxattr(struct dentry *dentry, char *buffer, size_t size)
Index: linux/fs/ext3/acl.c
===================================================================
--- linux.orig/fs/ext3/acl.c
+++ linux/fs/ext3/acl.c
@@ -216,7 +216,7 @@ ext3_get_acl(struct inode *inode, int ty
 /*
  * Set the access or default ACL of an inode.
  *
- * inode->i_mutex: down unless called from ext3_new_inode
+ * inode->i_mutex: locked unless called from ext3_new_inode
  */
 static int
 ext3_set_acl(handle_t *handle, struct inode *inode, int type,
@@ -306,8 +306,8 @@ ext3_permission(struct inode *inode, int
 /*
  * Initialize the ACLs of a new inode. Called from ext3_new_inode.
  *
- * dir->i_mutex: down
- * inode->i_mutex: up (access to inode is still exclusive)
+ * dir->i_mutex: locked
+ * inode->i_mutex: unlocked (access to inode is still exclusive)
  */
 int
 ext3_init_acl(handle_t *handle, struct inode *inode, struct inode *dir)
@@ -368,7 +368,7 @@ cleanup:
  * for directories) are added. There are no more bits available in the
  * file mode.
  *
- * inode->i_mutex: down
+ * inode->i_mutex: locked
  */
 int
 ext3_acl_chmod(struct inode *inode)
Index: linux/fs/ext3/xattr.c
===================================================================
--- linux.orig/fs/ext3/xattr.c
+++ linux/fs/ext3/xattr.c
@@ -140,7 +140,7 @@ ext3_xattr_handler(int name_index)
 /*
  * Inode operation listxattr()
  *
- * dentry->d_inode->i_sem: don't care
+ * dentry->d_inode->i_mutex: don't care
  */
 ssize_t
 ext3_listxattr(struct dentry *dentry, char *buffer, size_t size)
Index: linux/fs/jfs/jfs_incore.h
===================================================================
--- linux.orig/fs/jfs/jfs_incore.h
+++ linux/fs/jfs/jfs_incore.h
@@ -58,7 +58,7 @@ struct jfs_inode_info {
 	/*
 	 * rdwrlock serializes xtree between reads & writes and synchronizes
 	 * changes to special inodes.  It's use would be redundant on
-	 * directories since the i_sem taken in the VFS is sufficient.
+	 * directories since the i_mutex taken in the VFS is sufficient.
 	 */
 	struct rw_semaphore rdwrlock;
 	/*
@@ -68,7 +68,7 @@ struct jfs_inode_info {
 	 * inode is blocked in txBegin or TxBeginAnon
 	 */
 	struct semaphore commit_sem;
-	/* xattr_sem allows us to access the xattrs without taking i_sem */
+	/* xattr_sem allows us to access the xattrs without taking i_mutex */
 	struct rw_semaphore xattr_sem;
 	lid_t	xtlid;		/* lid of xtree lock on directory */
 #ifdef CONFIG_JFS_POSIX_ACL
Index: linux/fs/libfs.c
===================================================================
--- linux.orig/fs/libfs.c
+++ linux/fs/libfs.c
@@ -356,7 +356,7 @@ int simple_commit_write(struct file *fil
 
 	/*
 	 * No need to use i_size_read() here, the i_size
-	 * cannot change under us because we hold the i_sem.
+	 * cannot change under us because we hold the i_mutex.
 	 */
 	if (pos > inode->i_size)
 		i_size_write(inode, pos);
Index: linux/fs/nfs/dir.c
===================================================================
--- linux.orig/fs/nfs/dir.c
+++ linux/fs/nfs/dir.c
@@ -194,7 +194,7 @@ int nfs_readdir_filler(nfs_readdir_descr
 	spin_unlock(&inode->i_lock);
 	/* Ensure consistent page alignment of the data.
 	 * Note: assumes we have exclusive access to this mapping either
-	 *	 through inode->i_sem or some other mechanism.
+	 *	 through inode->i_mutex or some other mechanism.
 	 */
 	if (page->index == 0)
 		invalidate_inode_pages2_range(inode->i_mapping, PAGE_CACHE_SIZE, -1);
@@ -1001,7 +1001,7 @@ static int nfs_open_revalidate(struct de
 	openflags &= ~(O_CREAT|O_TRUNC);
 
 	/*
-	 * Note: we're not holding inode->i_sem and so may be racing with
+	 * Note: we're not holding inode->i_mutex and so may be racing with
 	 * operations that change the directory. We therefore save the
 	 * change attribute *before* we do the RPC call.
 	 */
@@ -1051,7 +1051,7 @@ static struct dentry *nfs_readdir_lookup
 		return dentry;
 	if (!desc->plus || !(entry->fattr->valid & NFS_ATTR_FATTR))
 		return NULL;
-	/* Note: caller is already holding the dir->i_sem! */
+	/* Note: caller is already holding the dir->i_mutex! */
 	dentry = d_alloc(parent, &name);
 	if (dentry == NULL)
 		return NULL;
Index: linux/fs/nfsd/nfs4recover.c
===================================================================
--- linux.orig/fs/nfsd/nfs4recover.c
+++ linux/fs/nfsd/nfs4recover.c
@@ -121,9 +121,9 @@ out:
 static void
 nfsd4_sync_rec_dir(void)
 {
-	down(&rec_dir.dentry->d_inode->i_sem);
+	mutex_lock(&rec_dir.dentry->d_inode->i_mutex);
 	nfsd_sync_dir(rec_dir.dentry);
-	up(&rec_dir.dentry->d_inode->i_sem);
+	mutex_unlock(&rec_dir.dentry->d_inode->i_mutex);
 }
 
 int
@@ -143,7 +143,7 @@ nfsd4_create_clid_dir(struct nfs4_client
 	nfs4_save_user(&uid, &gid);
 
 	/* lock the parent */
-	down(&rec_dir.dentry->d_inode->i_sem);
+	mutex_lock(&rec_dir.dentry->d_inode->i_mutex);
 
 	dentry = lookup_one_len(dname, rec_dir.dentry, HEXDIR_LEN-1);
 	if (IS_ERR(dentry)) {
@@ -159,7 +159,7 @@ nfsd4_create_clid_dir(struct nfs4_client
 out_put:
 	dput(dentry);
 out_unlock:
-	up(&rec_dir.dentry->d_inode->i_sem);
+	mutex_unlock(&rec_dir.dentry->d_inode->i_mutex);
 	if (status == 0) {
 		clp->cl_firststate = 1;
 		nfsd4_sync_rec_dir();
@@ -259,9 +259,9 @@ nfsd4_remove_clid_file(struct dentry *di
 		printk("nfsd4: non-file found in client recovery directory\n");
 		return -EINVAL;
 	}
-	down(&dir->d_inode->i_sem);
+	mutex_lock(&dir->d_inode->i_mutex);
 	status = vfs_unlink(dir->d_inode, dentry);
-	up(&dir->d_inode->i_sem);
+	mutex_unlock(&dir->d_inode->i_mutex);
 	return status;
 }
 
@@ -274,9 +274,9 @@ nfsd4_clear_clid_dir(struct dentry *dir,
 	 * any regular files anyway, just in case the directory was created by
 	 * a kernel from the future.... */
 	nfsd4_list_rec_dir(dentry, nfsd4_remove_clid_file);
-	down(&dir->d_inode->i_sem);
+	mutex_lock(&dir->d_inode->i_mutex);
 	status = vfs_rmdir(dir->d_inode, dentry);
-	up(&dir->d_inode->i_sem);
+	mutex_unlock(&dir->d_inode->i_mutex);
 	return status;
 }
 
@@ -288,9 +288,9 @@ nfsd4_unlink_clid_dir(char *name, int na
 
 	dprintk("NFSD: nfsd4_unlink_clid_dir. name %.*s\n", namlen, name);
 
-	down(&rec_dir.dentry->d_inode->i_sem);
+	mutex_lock(&rec_dir.dentry->d_inode->i_mutex);
 	dentry = lookup_one_len(name, rec_dir.dentry, namlen);
-	up(&rec_dir.dentry->d_inode->i_sem);
+	mutex_unlock(&rec_dir.dentry->d_inode->i_mutex);
 	if (IS_ERR(dentry)) {
 		status = PTR_ERR(dentry);
 		return status;
Index: linux/fs/ntfs/attrib.c
===================================================================
--- linux.orig/fs/ntfs/attrib.c
+++ linux/fs/ntfs/attrib.c
@@ -1532,7 +1532,7 @@ int ntfs_resident_attr_value_resize(MFT_
  * NOTE to self: No changes in the attribute list are required to move from
  *		 a resident to a non-resident attribute.
  *
- * Locking: - The caller must hold i_sem on the inode.
+ * Locking: - The caller must hold i_mutex on the inode.
  */
 int ntfs_attr_make_non_resident(ntfs_inode *ni, const u32 data_size)
 {
@@ -1728,7 +1728,7 @@ int ntfs_attr_make_non_resident(ntfs_ino
 	/*
 	 * This needs to be last since the address space operations ->readpage
 	 * and ->writepage can run concurrently with us as they are not
-	 * serialized on i_sem.  Note, we are not allowed to fail once we flip
+	 * serialized on i_mutex.  Note, we are not allowed to fail once we flip
 	 * this switch, which is another reason to do this last.
 	 */
 	NInoSetNonResident(ni);
Index: linux/fs/ntfs/dir.c
===================================================================
--- linux.orig/fs/ntfs/dir.c
+++ linux/fs/ntfs/dir.c
@@ -69,7 +69,7 @@ ntfschar I30[5] = { const_cpu_to_le16('$
  * work but we don't care for how quickly one can access them. This also fixes
  * the dcache aliasing issues.
  *
- * Locking:  - Caller must hold i_sem on the directory.
+ * Locking:  - Caller must hold i_mutex on the directory.
  *	     - Each page cache page in the index allocation mapping must be
  *	       locked whilst being accessed otherwise we may find a corrupt
  *	       page due to it being under ->writepage at the moment which
@@ -1085,11 +1085,11 @@ static inline int ntfs_filldir(ntfs_volu
  * While this will return the names in random order this doesn't matter for
  * ->readdir but OTOH results in a faster ->readdir.
  *
- * VFS calls ->readdir without BKL but with i_sem held. This protects the VFS
+ * VFS calls ->readdir without BKL but with i_mutex held. This protects the VFS
  * parts (e.g. ->f_pos and ->i_size, and it also protects against directory
  * modifications).
  *
- * Locking:  - Caller must hold i_sem on the directory.
+ * Locking:  - Caller must hold i_mutex on the directory.
  *	     - Each page cache page in the index allocation mapping must be
  *	       locked whilst being accessed otherwise we may find a corrupt
  *	       page due to it being under ->writepage at the moment which
@@ -1520,7 +1520,7 @@ static int ntfs_dir_open(struct inode *v
  * Note: In the past @filp could be NULL so we ignore it as we don't need it
  * anyway.
  *
- * Locking: Caller must hold i_sem on the inode.
+ * Locking: Caller must hold i_mutex on the inode.
  *
  * TODO: We should probably also write all attribute/index inodes associated
  * with this inode but since we have no simple way of getting to them we ignore
Index: linux/fs/ntfs/index.c
===================================================================
--- linux.orig/fs/ntfs/index.c
+++ linux/fs/ntfs/index.c
@@ -32,7 +32,7 @@
  * Allocate a new index context, initialize it with @idx_ni and return it.
  * Return NULL if allocation failed.
  *
- * Locking:  Caller must hold i_sem on the index inode.
+ * Locking:  Caller must hold i_mutex on the index inode.
  */
 ntfs_index_context *ntfs_index_ctx_get(ntfs_inode *idx_ni)
 {
@@ -50,7 +50,7 @@ ntfs_index_context *ntfs_index_ctx_get(n
  *
  * Release the index context @ictx, releasing all associated resources.
  *
- * Locking:  Caller must hold i_sem on the index inode.
+ * Locking:  Caller must hold i_mutex on the index inode.
  */
 void ntfs_index_ctx_put(ntfs_index_context *ictx)
 {
@@ -106,7 +106,7 @@ void ntfs_index_ctx_put(ntfs_index_conte
  * or ntfs_index_entry_write() before the call to ntfs_index_ctx_put() to
  * ensure that the changes are written to disk.
  *
- * Locking:  - Caller must hold i_sem on the index inode.
+ * Locking:  - Caller must hold i_mutex on the index inode.
  *	     - Each page cache page in the index allocation mapping must be
  *	       locked whilst being accessed otherwise we may find a corrupt
  *	       page due to it being under ->writepage at the moment which
Index: linux/fs/ntfs/inode.c
===================================================================
--- linux.orig/fs/ntfs/inode.c
+++ linux/fs/ntfs/inode.c
@@ -2311,7 +2311,7 @@ static const char *es = "  Leaving incon
  *
  * Returns 0 on success or -errno on error.
  *
- * Called with ->i_sem held.  In all but one case ->i_alloc_sem is held for
+ * Called with ->i_mutex held.  In all but one case ->i_alloc_sem is held for
  * writing.  The only case in the kernel where ->i_alloc_sem is not held is
  * mm/filemap.c::generic_file_buffered_write() where vmtruncate() is called
  * with the current i_size as the offset.  The analogous place in NTFS is in
@@ -2831,7 +2831,7 @@ void ntfs_truncate_vfs(struct inode *vi)
  * We also abort all changes of user, group, and mode as we do not implement
  * the NTFS ACLs yet.
  *
- * Called with ->i_sem held.  For the ATTR_SIZE (i.e. ->truncate) case, also
+ * Called with ->i_mutex held.  For the ATTR_SIZE (i.e. ->truncate) case, also
  * called with ->i_alloc_sem held for writing.
  *
  * Basically this is a copy of generic notify_change() and inode_setattr()
Index: linux/fs/ntfs/namei.c
===================================================================
--- linux.orig/fs/ntfs/namei.c
+++ linux/fs/ntfs/namei.c
@@ -374,7 +374,7 @@ struct inode_operations ntfs_dir_inode_o
  * The code is based on the ext3 ->get_parent() implementation found in
  * fs/ext3/namei.c::ext3_get_parent().
  *
- * Note: ntfs_get_parent() is called with @child_dent->d_inode->i_mutex down.
+ * Note: ntfs_get_parent() is called with @child_dent->d_inode->i_mutex locked.
  *
  * Return the dentry of the parent directory on success or the error code on
  * error (IS_ERR() is true).
Index: linux/fs/quota.c
===================================================================
--- linux.orig/fs/quota.c
+++ linux/fs/quota.c
@@ -168,7 +168,7 @@ static void quota_sync_sb(struct super_b
 	sync_blockdev(sb->s_bdev);
 
 	/* Now when everything is written we can discard the pagecache so
-	 * that userspace sees the changes. We need i_sem and so we could
+	 * that userspace sees the changes. We need i_mutex and so we could
 	 * not do it inside dqonoff_sem. Moreover we need to be carefull
 	 * about races with quotaoff() (that is the reason why we have own
 	 * reference to inode). */
Index: linux/fs/reiserfs/inode.c
===================================================================
--- linux.orig/fs/reiserfs/inode.c
+++ linux/fs/reiserfs/inode.c
@@ -586,7 +586,7 @@ static inline int _allocate_block(struct
 	BUG_ON(!th->t_trans_id);
 
 #ifdef REISERFS_PREALLOCATE
-	if (!(flags & GET_BLOCK_NO_ISEM)) {
+	if (!(flags & GET_BLOCK_NO_IMUTEX)) {
 		return reiserfs_new_unf_blocknrs2(th, inode, allocated_block_nr,
 						  path, block);
 	}
@@ -2318,7 +2318,7 @@ static int map_block_for_writepage(struc
 	/* this is where we fill in holes in the file. */
 	if (use_get_block) {
 		retval = reiserfs_get_block(inode, block, bh_result,
-					    GET_BLOCK_CREATE | GET_BLOCK_NO_ISEM
+					    GET_BLOCK_CREATE | GET_BLOCK_NO_IMUTEX
 					    | GET_BLOCK_NO_DANGLE);
 		if (!retval) {
 			if (!buffer_mapped(bh_result)
Index: linux/fs/reiserfs/tail_conversion.c
===================================================================
--- linux.orig/fs/reiserfs/tail_conversion.c
+++ linux/fs/reiserfs/tail_conversion.c
@@ -205,7 +205,7 @@ int indirect2direct(struct reiserfs_tran
 					 1) * p_s_sb->s_blocksize;
 	pos1 = pos;
 
-	// we are protected by i_sem. The tail can not disapper, not
+	// we are protected by i_mutex. The tail can not disapper, not
 	// append can be done either
 	// we are in truncate or packing tail in file_release
 
Index: linux/fs/reiserfs/xattr.c
===================================================================
--- linux.orig/fs/reiserfs/xattr.c
+++ linux/fs/reiserfs/xattr.c
@@ -219,7 +219,7 @@ static struct dentry *get_xa_file_dentry
 	} else if (flags & XATTR_REPLACE || flags & FL_READONLY) {
 		goto out;
 	} else {
-		/* inode->i_mutex is down, so nothing else can try to create
+		/* inode->i_mutex is locked, so nothing else can try to create
 		 * the same xattr */
 		err = xadir->d_inode->i_op->create(xadir->d_inode, xafile,
 						   0700 | S_IFREG, NULL);
@@ -480,7 +480,7 @@ static inline __u32 xattr_hash(const cha
 /* Generic extended attribute operations that can be used by xa plugins */
 
 /*
- * inode->i_mutex: down
+ * inode->i_mutex: locked
  */
 int
 reiserfs_xattr_set(struct inode *inode, const char *name, const void *buffer,
@@ -606,7 +606,7 @@ reiserfs_xattr_set(struct inode *inode, 
 }
 
 /*
- * inode->i_mutex: down
+ * inode->i_mutex: locked
  */
 int
 reiserfs_xattr_get(const struct inode *inode, const char *name, void *buffer,
@@ -793,7 +793,7 @@ reiserfs_delete_xattrs_filler(void *buf,
 
 }
 
-/* This is called w/ inode->i_mutex downed */
+/* This is called w/ inode->i_mutex locked */
 int reiserfs_delete_xattrs(struct inode *inode)
 {
 	struct file *fp;
@@ -946,7 +946,7 @@ int reiserfs_chown_xattrs(struct inode *
 
 /*
  * Inode operation getxattr()
- * Preliminary locking: we down dentry->d_inode->i_mutex
+ * Preliminary locking: we lock dentry->d_inode->i_mutex
  */
 ssize_t
 reiserfs_getxattr(struct dentry * dentry, const char *name, void *buffer,
@@ -970,7 +970,7 @@ reiserfs_getxattr(struct dentry * dentry
 /*
  * Inode operation setxattr()
  *
- * dentry->d_inode->i_mutex down
+ * dentry->d_inode->i_mutex locked
  */
 int
 reiserfs_setxattr(struct dentry *dentry, const char *name, const void *value,
@@ -1008,7 +1008,7 @@ reiserfs_setxattr(struct dentry *dentry,
 /*
  * Inode operation removexattr()
  *
- * dentry->d_inode->i_mutex down
+ * dentry->d_inode->i_mutex locked
  */
 int reiserfs_removexattr(struct dentry *dentry, const char *name)
 {
@@ -1091,7 +1091,7 @@ reiserfs_listxattr_filler(void *buf, con
 /*
  * Inode operation listxattr()
  *
- * Preliminary locking: we down dentry->d_inode->i_mutex
+ * Preliminary locking: we lock dentry->d_inode->i_mutex
  */
 ssize_t reiserfs_listxattr(struct dentry * dentry, char *buffer, size_t size)
 {
Index: linux/fs/reiserfs/xattr_acl.c
===================================================================
--- linux.orig/fs/reiserfs/xattr_acl.c
+++ linux/fs/reiserfs/xattr_acl.c
@@ -174,7 +174,7 @@ static void *posix_acl_to_disk(const str
 /*
  * Inode operation get_posix_acl().
  *
- * inode->i_sem: down
+ * inode->i_mutex: locked
  * BKL held [before 2.5.x]
  */
 struct posix_acl *reiserfs_get_acl(struct inode *inode, int type)
@@ -237,7 +237,7 @@ struct posix_acl *reiserfs_get_acl(struc
 /*
  * Inode operation set_posix_acl().
  *
- * inode->i_sem: down
+ * inode->i_mutex: locked
  * BKL held [before 2.5.x]
  */
 static int
@@ -312,7 +312,7 @@ reiserfs_set_acl(struct inode *inode, in
 	return error;
 }
 
-/* dir->i_sem: down,
+/* dir->i_mutex: locked,
  * inode is new and not released into the wild yet */
 int
 reiserfs_inherit_default_acl(struct inode *dir, struct dentry *dentry,
Index: linux/fs/sysfs/inode.c
===================================================================
--- linux.orig/fs/sysfs/inode.c
+++ linux/fs/sysfs/inode.c
@@ -201,7 +201,7 @@ const unsigned char * sysfs_get_name(str
 
 /*
  * Unhashes the dentry corresponding to given sysfs_dirent
- * Called with parent inode's i_sem held.
+ * Called with parent inode's i_mutex held.
  */
 void sysfs_drop_dentry(struct sysfs_dirent * sd, struct dentry * parent)
 {
Index: linux/fs/xfs/linux-2.6/xfs_iops.c
===================================================================
--- linux.orig/fs/xfs/linux-2.6/xfs_iops.c
+++ linux/fs/xfs/linux-2.6/xfs_iops.c
@@ -203,7 +203,7 @@ validate_fields(
 		ip->i_nlink = va.va_nlink;
 		ip->i_blocks = va.va_nblocks;
 
-		/* we're under i_sem so i_size can't change under us */
+		/* we're under i_mutex so i_size can't change under us */
 		if (i_size_read(ip) != va.va_size)
 			i_size_write(ip, va.va_size);
 	}
Index: linux/fs/xfs/linux-2.6/xfs_lrw.c
===================================================================
--- linux.orig/fs/xfs/linux-2.6/xfs_lrw.c
+++ linux/fs/xfs/linux-2.6/xfs_lrw.c
@@ -686,7 +686,7 @@ start:
 		int		dmflags = FILP_DELAY_FLAG(file);
 
 		if (need_isem)
-			dmflags |= DM_FLAGS_ISEM;
+			dmflags |= DM_FLAGS_IMUTEX;
 
 		xfs_iunlock(xip, XFS_ILOCK_EXCL);
 		error = XFS_SEND_DATA(xip->i_mount, DM_EVENT_WRITE, vp,
Index: linux/fs/xfs/xfs_dmapi.h
===================================================================
--- linux.orig/fs/xfs/xfs_dmapi.h
+++ linux/fs/xfs/xfs_dmapi.h
@@ -152,7 +152,7 @@ typedef enum {
 
 #define DM_FLAGS_NDELAY		0x001	/* return EAGAIN after dm_pending() */
 #define DM_FLAGS_UNWANTED	0x002	/* event not in fsys dm_eventset_t */
-#define DM_FLAGS_ISEM		0x004	/* thread holds i_sem */
+#define DM_FLAGS_IMUTEX		0x004	/* thread holds i_mutex */
 #define DM_FLAGS_IALLOCSEM_RD	0x010	/* thread holds i_alloc_sem rd */
 #define DM_FLAGS_IALLOCSEM_WR	0x020	/* thread holds i_alloc_sem wr */
 
@@ -161,21 +161,21 @@ typedef enum {
  */
 #if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,0)
 #define DM_SEM_FLAG_RD(ioflags) (((ioflags) & IO_ISDIRECT) ? \
-			      DM_FLAGS_ISEM : 0)
-#define DM_SEM_FLAG_WR	(DM_FLAGS_IALLOCSEM_WR | DM_FLAGS_ISEM)
+			      DM_FLAGS_IMUTEX : 0)
+#define DM_SEM_FLAG_WR	(DM_FLAGS_IALLOCSEM_WR | DM_FLAGS_IMUTEX)
 #endif
 
 #if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)) && \
     (LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,22))
 #define DM_SEM_FLAG_RD(ioflags) (((ioflags) & IO_ISDIRECT) ? \
-			      DM_FLAGS_IALLOCSEM_RD : DM_FLAGS_ISEM)
-#define DM_SEM_FLAG_WR	(DM_FLAGS_IALLOCSEM_WR | DM_FLAGS_ISEM)
+			      DM_FLAGS_IALLOCSEM_RD : DM_FLAGS_IMUTEX)
+#define DM_SEM_FLAG_WR	(DM_FLAGS_IALLOCSEM_WR | DM_FLAGS_IMUTEX)
 #endif
 
 #if LINUX_VERSION_CODE <= KERNEL_VERSION(2,4,21)
 #define DM_SEM_FLAG_RD(ioflags) (((ioflags) & IO_ISDIRECT) ? \
-			      0 : DM_FLAGS_ISEM)
-#define DM_SEM_FLAG_WR	(DM_FLAGS_ISEM)
+			      0 : DM_FLAGS_IMUTEX)
+#define DM_SEM_FLAG_WR	(DM_FLAGS_IMUTEX)
 #endif
 
 
Index: linux/include/linux/ext3_fs_i.h
===================================================================
--- linux.orig/include/linux/ext3_fs_i.h
+++ linux/include/linux/ext3_fs_i.h
@@ -87,7 +87,7 @@ struct ext3_inode_info {
 #ifdef CONFIG_EXT3_FS_XATTR
 	/*
 	 * Extended attributes can be read independently of the main file
-	 * data. Taking i_sem even when reading would cause contention
+	 * data. Taking i_mutex even when reading would cause contention
 	 * between readers of EAs and writers of regular file data, so
 	 * instead we synchronize on xattr_sem when reading or changing
 	 * EAs.
Index: linux/include/linux/fs.h
===================================================================
--- linux.orig/include/linux/fs.h
+++ linux/include/linux/fs.h
@@ -1160,7 +1160,7 @@ int sync_inode(struct inode *inode, stru
  *    directory.  The name should be stored in the @name (with the
  *    understanding that it is already pointing to a a %NAME_MAX+1 sized
  *    buffer.   get_name() should return %0 on success, a negative error code
- *    or error.  @get_name will be called without @parent->i_sem held.
+ *    or error.  @get_name will be called without @parent->i_mutex held.
  *
  * get_parent:
  *    @get_parent should find the parent directory for the given @child which
@@ -1182,7 +1182,7 @@ int sync_inode(struct inode *inode, stru
  *    nfsd_find_fh_dentry() in either the @obj or @parent parameters.
  *
  * Locking rules:
- *    get_parent is called with child->d_inode->i_sem down
+ *    get_parent is called with child->d_inode->i_mutex locked
  *    get_name is not (which is possibly inconsistent)
  */
 
Index: linux/include/linux/jffs2_fs_i.h
===================================================================
--- linux.orig/include/linux/jffs2_fs_i.h
+++ linux/include/linux/jffs2_fs_i.h
@@ -8,11 +8,11 @@
 #include <asm/semaphore.h>
 
 struct jffs2_inode_info {
-	/* We need an internal semaphore similar to inode->i_sem.
+	/* We need an internal semaphore similar to inode->i_mutex.
 	   Unfortunately, we can't used the existing one, because
 	   either the GC would deadlock, or we'd have to release it
 	   before letting GC proceed. Or we'd have to put ugliness
-	   into the GC code so it didn't attempt to obtain the i_sem
+	   into the GC code so it didn't attempt to obtain the i_mutex
 	   for the inode(s) which are already locked */
 	struct semaphore sem;
 
Index: linux/include/linux/nfsd/nfsfh.h
===================================================================
--- linux.orig/include/linux/nfsd/nfsfh.h
+++ linux/include/linux/nfsd/nfsfh.h
@@ -294,7 +294,7 @@ fill_post_wcc(struct svc_fh *fhp)
 /*
  * Lock a file handle/inode
  * NOTE: both fh_lock and fh_unlock are done "by hand" in
- * vfs.c:nfsd_rename as it needs to grab 2 i_sem's at once
+ * vfs.c:nfsd_rename as it needs to grab 2 i_mutex's at once
  * so, any changes here should be reflected there.
  */
 static inline void
Index: linux/include/linux/reiserfs_fs.h
===================================================================
--- linux.orig/include/linux/reiserfs_fs.h
+++ linux/include/linux/reiserfs_fs.h
@@ -1857,7 +1857,7 @@ void padd_item(char *item, int total_len
 #define GET_BLOCK_CREATE 1	/* add anything you need to find block */
 #define GET_BLOCK_NO_HOLE 2	/* return -ENOENT for file holes */
 #define GET_BLOCK_READ_DIRECT 4	/* read the tail if indirect item not found */
-#define GET_BLOCK_NO_ISEM     8	/* i_sem is not held, don't preallocate */
+#define GET_BLOCK_NO_IMUTEX   8	/* i_mutex is not held, don't preallocate */
 #define GET_BLOCK_NO_DANGLE   16	/* don't leave any transactions running */
 
 int restart_transaction(struct reiserfs_transaction_handle *th,
Index: linux/ipc/mqueue.c
===================================================================
--- linux.orig/ipc/mqueue.c
+++ linux/ipc/mqueue.c
@@ -660,7 +660,7 @@ asmlinkage long sys_mq_open(const char _
 	if (fd < 0)
 		goto out_putname;
 
-	down(&mqueue_mnt->mnt_root->d_inode->i_sem);
+	mutex_lock(&mqueue_mnt->mnt_root->d_inode->i_mutex);
 	dentry = lookup_one_len(name, mqueue_mnt->mnt_root, strlen(name));
 	if (IS_ERR(dentry)) {
 		error = PTR_ERR(dentry);
@@ -697,7 +697,7 @@ out_putfd:
 out_err:
 	fd = error;
 out_upsem:
-	up(&mqueue_mnt->mnt_root->d_inode->i_sem);
+	mutex_unlock(&mqueue_mnt->mnt_root->d_inode->i_mutex);
 out_putname:
 	putname(name);
 	return fd;
@@ -714,7 +714,7 @@ asmlinkage long sys_mq_unlink(const char
 	if (IS_ERR(name))
 		return PTR_ERR(name);
 
-	down(&mqueue_mnt->mnt_root->d_inode->i_sem);
+	mutex_lock(&mqueue_mnt->mnt_root->d_inode->i_mutex);
 	dentry = lookup_one_len(name, mqueue_mnt->mnt_root, strlen(name));
 	if (IS_ERR(dentry)) {
 		err = PTR_ERR(dentry);
@@ -735,7 +735,7 @@ out_err:
 	dput(dentry);
 
 out_unlock:
-	up(&mqueue_mnt->mnt_root->d_inode->i_sem);
+	mutex_unlock(&mqueue_mnt->mnt_root->d_inode->i_mutex);
 	putname(name);
 	if (inode)
 		iput(inode);
Index: linux/kernel/cpuset.c
===================================================================
--- linux.orig/kernel/cpuset.c
+++ linux/kernel/cpuset.c
@@ -1211,7 +1211,7 @@ static int cpuset_add_file(struct dentry
 	struct dentry *dentry;
 	int error;
 
-	down(&dir->d_inode->i_sem);
+	mutex_lock(&dir->d_inode->i_mutex);
 	dentry = cpuset_get_dentry(dir, cft->name);
 	if (!IS_ERR(dentry)) {
 		error = cpuset_create_file(dentry, 0644 | S_IFREG);
@@ -1220,7 +1220,7 @@ static int cpuset_add_file(struct dentry
 		dput(dentry);
 	} else
 		error = PTR_ERR(dentry);
-	up(&dir->d_inode->i_sem);
+	mutex_unlock(&dir->d_inode->i_mutex);
 	return error;
 }
 
@@ -1470,7 +1470,7 @@ static long cpuset_create(struct cpuset 
 
 	/*
 	 * Release manage_sem before cpuset_populate_dir() because it
-	 * will down() this new directory's i_sem and if we race with
+	 * will mutex_lock() this new directory's i_mutex and if we race with
 	 * another mkdir, we might deadlock.
 	 */
 	up(&manage_sem);
@@ -1489,7 +1489,7 @@ static int cpuset_mkdir(struct inode *di
 {
 	struct cpuset *c_parent = dentry->d_parent->d_fsdata;
 
-	/* the vfs holds inode->i_sem already */
+	/* the vfs holds inode->i_mutex already */
 	return cpuset_create(c_parent, dentry->d_name.name, mode | S_IFDIR);
 }
 
@@ -1500,7 +1500,7 @@ static int cpuset_rmdir(struct inode *un
 	struct cpuset *parent;
 	char *pathbuf = NULL;
 
-	/* the vfs holds both inode->i_sem already */
+	/* the vfs holds both inode->i_mutex already */
 
 	down(&manage_sem);
 	refresh_mems();
Index: linux/mm/filemap.c
===================================================================
--- linux.orig/mm/filemap.c
+++ linux/mm/filemap.c
@@ -61,7 +61,7 @@ generic_file_direct_IO(int rw, struct ki
  *      ->swap_lock		(exclusive_swap_page, others)
  *        ->mapping->tree_lock
  *
- *  ->i_sem
+ *  ->i_mutex
  *    ->i_mmap_lock		(truncate->unmap_mapping_range)
  *
  *  ->mmap_sem
@@ -73,9 +73,9 @@ generic_file_direct_IO(int rw, struct ki
  *    ->lock_page		(access_process_vm)
  *
  *  ->mmap_sem
- *    ->i_sem			(msync)
+ *    ->i_mutex			(msync)
  *
- *  ->i_sem
+ *  ->i_mutex
  *    ->i_alloc_sem             (various)
  *
  *  ->inode_lock
@@ -276,7 +276,7 @@ static int wait_on_page_writeback_range(
  * integrity" operation.  It waits upon in-flight writeout before starting and
  * waiting upon new writeout.  If there was an IO error, return it.
  *
- * We need to re-take i_sem during the generic_osync_inode list walk because
+ * We need to re-take i_mutex during the generic_osync_inode list walk because
  * it is otherwise livelockable.
  */
 int sync_page_range(struct inode *inode, struct address_space *mapping,
@@ -301,7 +301,7 @@ int sync_page_range(struct inode *inode,
 EXPORT_SYMBOL(sync_page_range);
 
 /*
- * Note: Holding i_sem across sync_page_range_nolock is not a good idea
+ * Note: Holding i_mutex across sync_page_range_nolock is not a good idea
  * as it forces O_SYNC writers to different parts of the same file
  * to be serialised right until io completion.
  */
@@ -1858,7 +1858,7 @@ generic_file_direct_write(struct kiocb *
 	/*
 	 * Sync the fs metadata but not the minor inode changes and
 	 * of course not the data as we did direct DMA for the IO.
-	 * i_sem is held, which protects generic_osync_inode() from
+	 * i_mutex is held, which protects generic_osync_inode() from
 	 * livelocking.
 	 */
 	if (written >= 0 && ((file->f_flags & O_SYNC) || IS_SYNC(inode))) {
@@ -2230,7 +2230,7 @@ ssize_t generic_file_writev(struct file 
 EXPORT_SYMBOL(generic_file_writev);
 
 /*
- * Called under i_sem for writes to S_ISREG files.   Returns -EIO if something
+ * Called under i_mutex for writes to S_ISREG files. Returns -EIO if something
  * went wrong during pagecache shootdown.
  */
 static ssize_t
Index: linux/mm/filemap_xip.c
===================================================================
--- linux.orig/mm/filemap_xip.c
+++ linux/mm/filemap_xip.c
@@ -358,7 +358,7 @@ xip_file_write(struct file *filp, const 
 	loff_t pos;
 	ssize_t ret;
 
-	down(&inode->i_sem);
+	mutex_lock(&inode->i_mutex);
 
 	if (!access_ok(VERIFY_READ, buf, len)) {
 		ret=-EFAULT;
@@ -390,7 +390,7 @@ xip_file_write(struct file *filp, const 
  out_backing:
 	current->backing_dev_info = NULL;
  out_up:
-	up(&inode->i_sem);
+	mutex_unlock(&inode->i_mutex);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(xip_file_write);
Index: linux/mm/msync.c
===================================================================
--- linux.orig/mm/msync.c
+++ linux/mm/msync.c
@@ -137,7 +137,7 @@ static int msync_interval(struct vm_area
 			ret = filemap_fdatawrite(mapping);
 			if (file->f_op && file->f_op->fsync) {
 				/*
-				 * We don't take i_sem here because mmap_sem
+				 * We don't take i_mutex here because mmap_sem
 				 * is already held.
 				 */
 				err = file->f_op->fsync(file,file->f_dentry,1);
Index: linux/mm/rmap.c
===================================================================
--- linux.orig/mm/rmap.c
+++ linux/mm/rmap.c
@@ -20,13 +20,13 @@
 /*
  * Lock ordering in mm:
  *
- * inode->i_sem	(while writing or truncating, not reading or faulting)
+ * inode->i_mutex (while writing or truncating, not reading or faulting)
  *   inode->i_alloc_sem
  *
  * When a page fault occurs in writing from user to file, down_read
- * of mmap_sem nests within i_sem; in sys_msync, i_sem nests within
- * down_read of mmap_sem; i_sem and down_write of mmap_sem are never
- * taken together; in truncation, i_sem is taken outermost.
+ * of mmap_sem nests within i_mutex; in sys_msync, i_mutex nests within
+ * down_read of mmap_sem; i_mutex and down_write of mmap_sem are never
+ * taken together; in truncation, i_mutex is taken outermost.
  *
  * mm->mmap_sem
  *   page->flags PG_locked (lock_page)
Index: linux/mm/shmem.c
===================================================================
--- linux.orig/mm/shmem.c
+++ linux/mm/shmem.c
@@ -1476,7 +1476,7 @@ static void do_shmem_file_read(struct fi
 
 		/*
 		 * We must evaluate after, since reads (unlike writes)
-		 * are called without i_sem protection against truncate
+		 * are called without i_mutex protection against truncate
 		 */
 		nr = PAGE_CACHE_SIZE;
 		i_size = i_size_read(inode);
Index: linux/mm/truncate.c
===================================================================
--- linux.orig/mm/truncate.c
+++ linux/mm/truncate.c
@@ -102,7 +102,7 @@ invalidate_complete_page(struct address_
  * mapping is large, it is probably the case that the final pages are the most
  * recently touched, and freeing happens in ascending file offset order.
  *
- * Called under (and serialised by) inode->i_sem.
+ * Called under (and serialised by) inode->i_mutex.
  */
 void truncate_inode_pages(struct address_space *mapping, loff_t lstart)
 {
Index: linux/security/inode.c
===================================================================
--- linux.orig/security/inode.c
+++ linux/security/inode.c
@@ -172,7 +172,7 @@ static int create_by_name(const char *na
 		return -EFAULT;
 	}
 
-	down(&parent->d_inode->i_sem);
+	mutex_lock(&parent->d_inode->i_mutex);
 	*dentry = lookup_one_len(name, parent, strlen(name));
 	if (!IS_ERR(dentry)) {
 		if ((mode & S_IFMT) == S_IFDIR)
@@ -181,7 +181,7 @@ static int create_by_name(const char *na
 			error = create(parent->d_inode, *dentry, mode);
 	} else
 		error = PTR_ERR(dentry);
-	up(&parent->d_inode->i_sem);
+	mutex_unlock(&parent->d_inode->i_mutex);
 
 	return error;
 }
@@ -302,7 +302,7 @@ void securityfs_remove(struct dentry *de
 	if (!parent || !parent->d_inode)
 		return;
 
-	down(&parent->d_inode->i_sem);
+	mutex_lock(&parent->d_inode->i_mutex);
 	if (positive(dentry)) {
 		if (dentry->d_inode) {
 			if (S_ISDIR(dentry->d_inode->i_mode))
@@ -312,7 +312,7 @@ void securityfs_remove(struct dentry *de
 			dput(dentry);
 		}
 	}
-	up(&parent->d_inode->i_sem);
+	mutex_unlock(&parent->d_inode->i_mutex);
 	simple_release_fs(&mount, &mount_count);
 }
 EXPORT_SYMBOL_GPL(securityfs_remove);
Index: linux/sound/core/oss/pcm_oss.c
===================================================================
--- linux.orig/sound/core/oss/pcm_oss.c
+++ linux/sound/core/oss/pcm_oss.c
@@ -2141,9 +2141,9 @@ static ssize_t snd_pcm_oss_write(struct 
 	substream = pcm_oss_file->streams[SNDRV_PCM_STREAM_PLAYBACK];
 	if (substream == NULL)
 		return -ENXIO;
-	up(&file->f_dentry->d_inode->i_sem);
+	mutex_unlock(&file->f_dentry->d_inode->i_mutex);
 	result = snd_pcm_oss_write1(substream, buf, count);
-	down(&file->f_dentry->d_inode->i_sem);
+	mutex_lock(&file->f_dentry->d_inode->i_mutex);
 #ifdef OSS_DEBUG
 	printk("pcm_oss: write %li bytes (wrote %li bytes)\n", (long)count, (long)result);
 #endif
Index: linux/sound/core/seq/seq_memory.c
===================================================================
--- linux.orig/sound/core/seq/seq_memory.c
+++ linux/sound/core/seq/seq_memory.c
@@ -32,10 +32,6 @@
 #include "seq_info.h"
 #include "seq_lock.h"
 
-/* semaphore in struct file record */
-#define semaphore_of(fp)	((fp)->f_dentry->d_inode->i_sem)
-
-
 static inline int snd_seq_pool_available(pool_t *pool)
 {
 	return pool->total_elements - atomic_read(&pool->counter);
