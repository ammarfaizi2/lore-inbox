Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992893AbWJUHTA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992893AbWJUHTA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 03:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992850AbWJUHO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 03:14:28 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:24199 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S2992853AbWJUHOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 03:14:07 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 21 of 23] cifs: change uses of f_{dentry, vfsmnt} to use f_path
Message-Id: <fb75174d82cb69fc57b7.1161411466@thor.fsl.cs.sunysb.edu>
In-Reply-To: <patchbomb.1161411445@thor.fsl.cs.sunysb.edu>
Date: Sat, 21 Oct 2006 02:17:46 -0400
From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org,
       viro@ftp.linux.org.uk, hch@infradead.org, sfrench@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

This patch changes all the uses of f_{dentry,vfsmnt} to f_path.{dentry,mnt}
in the cifs filesystem.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

---

4 files changed, 77 insertions(+), 77 deletions(-)
fs/cifs/cifsfs.c  |    4 -
fs/cifs/fcntl.c   |    4 -
fs/cifs/file.c    |  114 ++++++++++++++++++++++++++---------------------------
fs/cifs/readdir.c |   32 +++++++-------

diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -497,7 +497,7 @@ static ssize_t cifs_file_aio_write(struc
 static ssize_t cifs_file_aio_write(struct kiocb *iocb, const struct iovec *iov,
 				   unsigned long nr_segs, loff_t pos)
 {
-	struct inode *inode = iocb->ki_filp->f_dentry->d_inode;
+	struct inode *inode = iocb->ki_filp->f_path.dentry->d_inode;
 	ssize_t written;
 
 	written = generic_file_aio_write(iocb, iov, nr_segs, pos);
@@ -510,7 +510,7 @@ static loff_t cifs_llseek(struct file *f
 {
 	/* origin == SEEK_END => we must revalidate the cached file length */
 	if (origin == SEEK_END) {
-		int retval = cifs_revalidate(file->f_dentry);
+		int retval = cifs_revalidate(file->f_path.dentry);
 		if (retval < 0)
 			return (loff_t)retval;
 	}
diff --git a/fs/cifs/fcntl.c b/fs/cifs/fcntl.c
--- a/fs/cifs/fcntl.c
+++ b/fs/cifs/fcntl.c
@@ -83,10 +83,10 @@ int cifs_dir_notify(struct file * file, 
 		return 0;
 
 	xid = GetXid();
-	cifs_sb = CIFS_SB(file->f_dentry->d_sb);
+	cifs_sb = CIFS_SB(file->f_path.dentry->d_sb);
 	pTcon = cifs_sb->tcon;
 
-	full_path = build_path_from_dentry(file->f_dentry);
+	full_path = build_path_from_dentry(file->f_path.dentry);
 
 	if(full_path == NULL) {
 		rc = -ENOMEM;
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -122,34 +122,34 @@ static inline int cifs_open_inode_helper
 	/* if not oplocked, invalidate inode pages if mtime or file
 	   size changed */
 	temp = cifs_NTtimeToUnix(le64_to_cpu(buf->LastWriteTime));
-	if (timespec_equal(&file->f_dentry->d_inode->i_mtime, &temp) && 
-			   (file->f_dentry->d_inode->i_size == 
+	if (timespec_equal(&file->f_path.dentry->d_inode->i_mtime, &temp) && 
+			   (file->f_path.dentry->d_inode->i_size == 
 			    (loff_t)le64_to_cpu(buf->EndOfFile))) {
 		cFYI(1, ("inode unchanged on server"));
 	} else {
-		if (file->f_dentry->d_inode->i_mapping) {
+		if (file->f_path.dentry->d_inode->i_mapping) {
 		/* BB no need to lock inode until after invalidate
 		   since namei code should already have it locked? */
-			filemap_write_and_wait(file->f_dentry->d_inode->i_mapping);
+			filemap_write_and_wait(file->f_path.dentry->d_inode->i_mapping);
 		}
 		cFYI(1, ("invalidating remote inode since open detected it "
 			 "changed"));
-		invalidate_remote_inode(file->f_dentry->d_inode);
+		invalidate_remote_inode(file->f_path.dentry->d_inode);
 	}
 
 client_can_cache:
 	if (pTcon->ses->capabilities & CAP_UNIX)
-		rc = cifs_get_inode_info_unix(&file->f_dentry->d_inode,
+		rc = cifs_get_inode_info_unix(&file->f_path.dentry->d_inode,
 			full_path, inode->i_sb, xid);
 	else
-		rc = cifs_get_inode_info(&file->f_dentry->d_inode,
+		rc = cifs_get_inode_info(&file->f_path.dentry->d_inode,
 			full_path, buf, inode->i_sb, xid);
 
 	if ((*oplock & 0xF) == OPLOCK_EXCLUSIVE) {
 		pCifsInode->clientCanCacheAll = TRUE;
 		pCifsInode->clientCanCacheRead = TRUE;
 		cFYI(1, ("Exclusive Oplock granted on inode %p",
-			 file->f_dentry->d_inode));
+			 file->f_path.dentry->d_inode));
 	} else if ((*oplock & 0xF) == OPLOCK_READ)
 		pCifsInode->clientCanCacheRead = TRUE;
 
@@ -178,7 +178,7 @@ int cifs_open(struct inode *inode, struc
 
 	if (file->f_flags & O_CREAT) {
 		/* search inode for this file and fill in file->private_data */
-		pCifsInode = CIFS_I(file->f_dentry->d_inode);
+		pCifsInode = CIFS_I(file->f_path.dentry->d_inode);
 		read_lock(&GlobalSMBSeslock);
 		list_for_each(tmp, &pCifsInode->openFileList) {
 			pCifsFile = list_entry(tmp, struct cifsFileInfo,
@@ -206,7 +206,7 @@ int cifs_open(struct inode *inode, struc
 		}
 	}
 
-	full_path = build_path_from_dentry(file->f_dentry);
+	full_path = build_path_from_dentry(file->f_path.dentry);
 	if (full_path == NULL) {
 		FreeXid(xid);
 		return -ENOMEM;
@@ -291,7 +291,7 @@ int cifs_open(struct inode *inode, struc
 	write_lock(&GlobalSMBSeslock);
 	list_add(&pCifsFile->tlist, &pTcon->openFileList);
 
-	pCifsInode = CIFS_I(file->f_dentry->d_inode);
+	pCifsInode = CIFS_I(file->f_path.dentry->d_inode);
 	if (pCifsInode) {
 		rc = cifs_open_inode_helper(inode, file, pCifsInode,
 					    pCifsFile, pTcon,
@@ -366,7 +366,7 @@ static int cifs_reopen_file(struct inode
 		return 0;
 	}
 
-	if (file->f_dentry == NULL) {
+	if (file->f_path.dentry == NULL) {
 		up(&pCifsFile->fh_sem);
 		cFYI(1, ("failed file reopen, no valid name if dentry freed"));
 		FreeXid(xid);
@@ -378,7 +378,7 @@ static int cifs_reopen_file(struct inode
    those that already have the rename sem can end up causing writepage
    to get called and if the server was down that means we end up here,
    and we can never tell if the caller already has the rename_sem */
-	full_path = build_path_from_dentry(file->f_dentry);
+	full_path = build_path_from_dentry(file->f_path.dentry);
 	if (full_path == NULL) {
 		up(&pCifsFile->fh_sem);
 		FreeXid(xid);
@@ -444,7 +444,7 @@ static int cifs_reopen_file(struct inode
 				pCifsInode->clientCanCacheAll = TRUE;
 				pCifsInode->clientCanCacheRead = TRUE;
 				cFYI(1, ("Exclusive Oplock granted on inode %p",
-					 file->f_dentry->d_inode));
+					 file->f_path.dentry->d_inode));
 			} else if ((oplock & 0xF) == OPLOCK_READ) {
 				pCifsInode->clientCanCacheRead = TRUE;
 				pCifsInode->clientCanCacheAll = FALSE;
@@ -547,7 +547,7 @@ int cifs_closedir(struct inode *inode, s
 
 	if (pCFileStruct) {
 		struct cifsTconInfo *pTcon;
-		struct cifs_sb_info *cifs_sb = CIFS_SB(file->f_dentry->d_sb);
+		struct cifs_sb_info *cifs_sb = CIFS_SB(file->f_path.dentry->d_sb);
 
 		pTcon = cifs_sb->tcon;
 
@@ -660,7 +660,7 @@ int cifs_lock(struct file *file, int cmd
 	} else
 		cFYI(1, ("Unknown type of lock"));
 
-	cifs_sb = CIFS_SB(file->f_dentry->d_sb);
+	cifs_sb = CIFS_SB(file->f_path.dentry->d_sb);
 	pTcon = cifs_sb->tcon;
 
 	if (file->private_data == NULL) {
@@ -787,10 +787,10 @@ ssize_t cifs_user_write(struct file *fil
 	int xid, long_op;
 	struct cifsFileInfo *open_file;
 
-	if (file->f_dentry == NULL)
+	if (file->f_path.dentry == NULL)
 		return -EBADF;
 
-	cifs_sb = CIFS_SB(file->f_dentry->d_sb);
+	cifs_sb = CIFS_SB(file->f_path.dentry->d_sb);
 	if (cifs_sb == NULL)
 		return -EBADF;
 
@@ -798,7 +798,7 @@ ssize_t cifs_user_write(struct file *fil
 
 	/* cFYI(1,
 	   (" write %d bytes to offset %lld of %s", write_size,
-	   *poffset, file->f_dentry->d_name.name)); */
+	   *poffset, file->f_path.dentry->d_name.name)); */
 
 	if (file->private_data == NULL)
 		return -EBADF;
@@ -806,12 +806,12 @@ ssize_t cifs_user_write(struct file *fil
 		open_file = (struct cifsFileInfo *) file->private_data;
 	
 	xid = GetXid();
-	if (file->f_dentry->d_inode == NULL) {
+	if (file->f_path.dentry->d_inode == NULL) {
 		FreeXid(xid);
 		return -EBADF;
 	}
 
-	if (*poffset > file->f_dentry->d_inode->i_size)
+	if (*poffset > file->f_path.dentry->d_inode->i_size)
 		long_op = 2; /* writes past end of file can take a long time */
 	else
 		long_op = 1;
@@ -836,8 +836,8 @@ ssize_t cifs_user_write(struct file *fil
 					return -EBADF;
 			}
 			if (open_file->invalidHandle) {
-				if ((file->f_dentry == NULL) ||
-				    (file->f_dentry->d_inode == NULL)) {
+				if ((file->f_path.dentry == NULL) ||
+				    (file->f_path.dentry->d_inode == NULL)) {
 					FreeXid(xid);
 					return total_written;
 				}
@@ -845,7 +845,7 @@ ssize_t cifs_user_write(struct file *fil
 				   filemap_fdatawait from here so tell
 				   reopen_file not to flush data to server
 				   now */
-				rc = cifs_reopen_file(file->f_dentry->d_inode,
+				rc = cifs_reopen_file(file->f_path.dentry->d_inode,
 					file, FALSE);
 				if (rc != 0)
 					break;
@@ -874,17 +874,17 @@ ssize_t cifs_user_write(struct file *fil
 	cifs_stats_bytes_written(pTcon, total_written);
 
 	/* since the write may have blocked check these pointers again */
-	if (file->f_dentry) {
-		if (file->f_dentry->d_inode) {
-			struct inode *inode = file->f_dentry->d_inode;
+	if (file->f_path.dentry) {
+		if (file->f_path.dentry->d_inode) {
+			struct inode *inode = file->f_path.dentry->d_inode;
 			inode->i_ctime = inode->i_mtime =
 				current_fs_time(inode->i_sb);
 			if (total_written > 0) {
-				if (*poffset > file->f_dentry->d_inode->i_size)
-					i_size_write(file->f_dentry->d_inode,
+				if (*poffset > file->f_path.dentry->d_inode->i_size)
+					i_size_write(file->f_path.dentry->d_inode,
 					*poffset);
 			}
-			mark_inode_dirty_sync(file->f_dentry->d_inode);
+			mark_inode_dirty_sync(file->f_path.dentry->d_inode);
 		}
 	}
 	FreeXid(xid);
@@ -902,17 +902,17 @@ static ssize_t cifs_write(struct file *f
 	int xid, long_op;
 	struct cifsFileInfo *open_file;
 
-	if (file->f_dentry == NULL)
+	if (file->f_path.dentry == NULL)
 		return -EBADF;
 
-	cifs_sb = CIFS_SB(file->f_dentry->d_sb);
+	cifs_sb = CIFS_SB(file->f_path.dentry->d_sb);
 	if (cifs_sb == NULL)
 		return -EBADF;
 
 	pTcon = cifs_sb->tcon;
 
 	cFYI(1,("write %zd bytes to offset %lld of %s", write_size,
-	   *poffset, file->f_dentry->d_name.name));
+	   *poffset, file->f_path.dentry->d_name.name));
 
 	if (file->private_data == NULL)
 		return -EBADF;
@@ -920,12 +920,12 @@ static ssize_t cifs_write(struct file *f
 		open_file = (struct cifsFileInfo *)file->private_data;
 	
 	xid = GetXid();
-	if (file->f_dentry->d_inode == NULL) {
+	if (file->f_path.dentry->d_inode == NULL) {
 		FreeXid(xid);
 		return -EBADF;
 	}
 
-	if (*poffset > file->f_dentry->d_inode->i_size)
+	if (*poffset > file->f_path.dentry->d_inode->i_size)
 		long_op = 2; /* writes past end of file can take a long time */
 	else
 		long_op = 1;
@@ -951,8 +951,8 @@ static ssize_t cifs_write(struct file *f
 					return -EBADF;
 			}
 			if (open_file->invalidHandle) {
-				if ((file->f_dentry == NULL) ||
-				   (file->f_dentry->d_inode == NULL)) {
+				if ((file->f_path.dentry == NULL) ||
+				   (file->f_path.dentry->d_inode == NULL)) {
 					FreeXid(xid);
 					return total_written;
 				}
@@ -960,7 +960,7 @@ static ssize_t cifs_write(struct file *f
 				   filemap_fdatawait from here so tell
 				   reopen_file not to flush data to 
 				   server now */
-				rc = cifs_reopen_file(file->f_dentry->d_inode,
+				rc = cifs_reopen_file(file->f_path.dentry->d_inode,
 					file, FALSE);
 				if (rc != 0)
 					break;
@@ -1007,16 +1007,16 @@ static ssize_t cifs_write(struct file *f
 	cifs_stats_bytes_written(pTcon, total_written);
 
 	/* since the write may have blocked check these pointers again */
-	if (file->f_dentry) {
-		if (file->f_dentry->d_inode) {
-			file->f_dentry->d_inode->i_ctime = 
-			file->f_dentry->d_inode->i_mtime = CURRENT_TIME;
+	if (file->f_path.dentry) {
+		if (file->f_path.dentry->d_inode) {
+			file->f_path.dentry->d_inode->i_ctime = 
+			file->f_path.dentry->d_inode->i_mtime = CURRENT_TIME;
 			if (total_written > 0) {
-				if (*poffset > file->f_dentry->d_inode->i_size)
-					i_size_write(file->f_dentry->d_inode, 
+				if (*poffset > file->f_path.dentry->d_inode->i_size)
+					i_size_write(file->f_path.dentry->d_inode, 
 						     *poffset);
 			}
-			mark_inode_dirty_sync(file->f_dentry->d_inode);
+			mark_inode_dirty_sync(file->f_path.dentry->d_inode);
 		}
 	}
 	FreeXid(xid);
@@ -1380,7 +1380,7 @@ static int cifs_commit_write(struct file
 				if ((open_file->invalidHandle) && 
 				    (!open_file->closePend)) {
 					rc = cifs_reopen_file(
-						file->f_dentry->d_inode, file);
+						file->f_path.dentry->d_inode, file);
 					if (rc != 0)
 						break;
 				}
@@ -1430,7 +1430,7 @@ int cifs_fsync(struct file *file, struct
 {
 	int xid;
 	int rc = 0;
-	struct inode *inode = file->f_dentry->d_inode;
+	struct inode *inode = file->f_path.dentry->d_inode;
 
 	xid = GetXid();
 
@@ -1478,7 +1478,7 @@ int cifs_fsync(struct file *file, struct
  */
 int cifs_flush(struct file *file, fl_owner_t id)
 {
-	struct inode * inode = file->f_dentry->d_inode;
+	struct inode * inode = file->f_path.dentry->d_inode;
 	int rc = 0;
 
 	/* Rather than do the steps manually:
@@ -1515,7 +1515,7 @@ ssize_t cifs_user_read(struct file *file
 	struct smb_com_read_rsp *pSMBr;
 
 	xid = GetXid();
-	cifs_sb = CIFS_SB(file->f_dentry->d_sb);
+	cifs_sb = CIFS_SB(file->f_path.dentry->d_sb);
 	pTcon = cifs_sb->tcon;
 
 	if (file->private_data == NULL) {
@@ -1538,7 +1538,7 @@ ssize_t cifs_user_read(struct file *file
 			int buf_type = CIFS_NO_BUFFER;
 			if ((open_file->invalidHandle) && 
 			    (!open_file->closePend)) {
-				rc = cifs_reopen_file(file->f_dentry->d_inode,
+				rc = cifs_reopen_file(file->f_path.dentry->d_inode,
 					file, TRUE);
 				if (rc != 0)
 					break;
@@ -1597,7 +1597,7 @@ static ssize_t cifs_read(struct file *fi
 	int buf_type = CIFS_NO_BUFFER;
 
 	xid = GetXid();
-	cifs_sb = CIFS_SB(file->f_dentry->d_sb);
+	cifs_sb = CIFS_SB(file->f_path.dentry->d_sb);
 	pTcon = cifs_sb->tcon;
 
 	if (file->private_data == NULL) {
@@ -1625,7 +1625,7 @@ static ssize_t cifs_read(struct file *fi
 		while (rc == -EAGAIN) {
 			if ((open_file->invalidHandle) && 
 			    (!open_file->closePend)) {
-				rc = cifs_reopen_file(file->f_dentry->d_inode,
+				rc = cifs_reopen_file(file->f_path.dentry->d_inode,
 					file, TRUE);
 				if (rc != 0)
 					break;
@@ -1654,7 +1654,7 @@ static ssize_t cifs_read(struct file *fi
 
 int cifs_file_mmap(struct file *file, struct vm_area_struct *vma)
 {
-	struct dentry *dentry = file->f_dentry;
+	struct dentry *dentry = file->f_path.dentry;
 	int rc, xid;
 
 	xid = GetXid();
@@ -1740,7 +1740,7 @@ static int cifs_readpages(struct file *f
 		return -EBADF;
 	}
 	open_file = (struct cifsFileInfo *)file->private_data;
-	cifs_sb = CIFS_SB(file->f_dentry->d_sb);
+	cifs_sb = CIFS_SB(file->f_path.dentry->d_sb);
 	pTcon = cifs_sb->tcon;
 
 	pagevec_init(&lru_pvec, 0);
@@ -1782,7 +1782,7 @@ static int cifs_readpages(struct file *f
 		while (rc == -EAGAIN) {
 			if ((open_file->invalidHandle) && 
 			    (!open_file->closePend)) {
-				rc = cifs_reopen_file(file->f_dentry->d_inode,
+				rc = cifs_reopen_file(file->f_path.dentry->d_inode,
 					file, TRUE);
 				if (rc != 0)
 					break;
@@ -1897,8 +1897,8 @@ static int cifs_readpage_worker(struct f
 	else
 		cFYI(1, ("Bytes read %d",rc));
                                                                                                                            
-	file->f_dentry->d_inode->i_atime =
-		current_fs_time(file->f_dentry->d_inode->i_sb);
+	file->f_path.dentry->d_inode->i_atime =
+		current_fs_time(file->f_path.dentry->d_inode->i_sb);
                                                                                                                            
 	if (PAGE_CACHE_SIZE > rc)
 		memset(read_data + rc, 0, PAGE_CACHE_SIZE - rc);
diff --git a/fs/cifs/readdir.c b/fs/cifs/readdir.c
--- a/fs/cifs/readdir.c
+++ b/fs/cifs/readdir.c
@@ -68,30 +68,30 @@ static int construct_dentry(struct qstr 
 	int rc = 0;
 
 	cFYI(1, ("For %s", qstring->name));
-	cifs_sb = CIFS_SB(file->f_dentry->d_sb);
+	cifs_sb = CIFS_SB(file->f_path.dentry->d_sb);
 	pTcon = cifs_sb->tcon;
 
 	qstring->hash = full_name_hash(qstring->name, qstring->len);
-	tmp_dentry = d_lookup(file->f_dentry, qstring);
+	tmp_dentry = d_lookup(file->f_path.dentry, qstring);
 	if (tmp_dentry) {
 		cFYI(0, ("existing dentry with inode 0x%p", tmp_dentry->d_inode));
 		*ptmp_inode = tmp_dentry->d_inode;
 /* BB overwrite old name? i.e. tmp_dentry->d_name and tmp_dentry->d_name.len??*/
 		if(*ptmp_inode == NULL) {
-			*ptmp_inode = new_inode(file->f_dentry->d_sb);
+			*ptmp_inode = new_inode(file->f_path.dentry->d_sb);
 			if(*ptmp_inode == NULL)
 				return rc;
 			rc = 1;
 		}
 	} else {
-		tmp_dentry = d_alloc(file->f_dentry, qstring);
+		tmp_dentry = d_alloc(file->f_path.dentry, qstring);
 		if(tmp_dentry == NULL) {
 			cERROR(1,("Failed allocating dentry"));
 			*ptmp_inode = NULL;
 			return rc;
 		}
 
-		*ptmp_inode = new_inode(file->f_dentry->d_sb);
+		*ptmp_inode = new_inode(file->f_path.dentry->d_sb);
 		if (pTcon->nocase)
 			tmp_dentry->d_op = &cifs_ci_dentry_ops;
 		else
@@ -432,10 +432,10 @@ static int initiate_cifs_search(const in
 	cifsFile->invalidHandle = TRUE;
 	cifsFile->srch_inf.endOfSearch = FALSE;
 
-	if(file->f_dentry == NULL)
+	if(file->f_path.dentry == NULL)
 		return -ENOENT;
 
-	cifs_sb = CIFS_SB(file->f_dentry->d_sb);
+	cifs_sb = CIFS_SB(file->f_path.dentry->d_sb);
 	if(cifs_sb == NULL)
 		return -EINVAL;
 
@@ -443,7 +443,7 @@ static int initiate_cifs_search(const in
 	if(pTcon == NULL)
 		return -EINVAL;
 
-	full_path = build_path_from_dentry(file->f_dentry);
+	full_path = build_path_from_dentry(file->f_path.dentry);
 
 	if(full_path == NULL) {
 		return -ENOMEM;
@@ -609,10 +609,10 @@ static int is_dir_changed(struct file * 
 	struct inode * inode;
 	struct cifsInodeInfo *cifsInfo;
 
-	if(file->f_dentry == NULL)
+	if(file->f_path.dentry == NULL)
 		return 0;
 
-	inode = file->f_dentry->d_inode;
+	inode = file->f_path.dentry->d_inode;
 
 	if(inode == NULL)
 		return 0;
@@ -839,7 +839,7 @@ static int cifs_filldir(char *pfindEntry
 	if((scratch_buf == NULL) || (pfindEntry == NULL) || (pCifsF == NULL))
 		return -ENOENT;
 
-	if(file->f_dentry == NULL)
+	if(file->f_path.dentry == NULL)
 		return -ENOENT;
 
 	rc = cifs_entry_is_dot(pfindEntry,pCifsF);
@@ -847,7 +847,7 @@ static int cifs_filldir(char *pfindEntry
 	if(rc != 0) 
 		return 0;
 
-	cifs_sb = CIFS_SB(file->f_dentry->d_sb);
+	cifs_sb = CIFS_SB(file->f_path.dentry->d_sb);
 
 	qstring.name = scratch_buf;
 	rc = cifs_get_name_from_search_buf(&qstring,pfindEntry,
@@ -981,12 +981,12 @@ int cifs_readdir(struct file *file, void
 
 	xid = GetXid();
 
-	if(file->f_dentry == NULL) {
+	if(file->f_path.dentry == NULL) {
 		FreeXid(xid);
 		return -EIO;
 	}
 
-	cifs_sb = CIFS_SB(file->f_dentry->d_sb);
+	cifs_sb = CIFS_SB(file->f_path.dentry->d_sb);
 	pTcon = cifs_sb->tcon;
 	if(pTcon == NULL)
 		return -EINVAL;
@@ -994,7 +994,7 @@ int cifs_readdir(struct file *file, void
 	switch ((int) file->f_pos) {
 	case 0:
 		if (filldir(direntry, ".", 1, file->f_pos,
-		     file->f_dentry->d_inode->i_ino, DT_DIR) < 0) {
+		     file->f_path.dentry->d_inode->i_ino, DT_DIR) < 0) {
 			cERROR(1, ("Filldir for current dir failed"));
 			rc = -ENOMEM;
 			break;
@@ -1002,7 +1002,7 @@ int cifs_readdir(struct file *file, void
 		file->f_pos++;
 	case 1:
 		if (filldir(direntry, "..", 2, file->f_pos,
-		     file->f_dentry->d_parent->d_inode->i_ino, DT_DIR) < 0) {
+		     file->f_path.dentry->d_parent->d_inode->i_ino, DT_DIR) < 0) {
 			cERROR(1, ("Filldir for parent dir failed"));
 			rc = -ENOMEM;
 			break;


