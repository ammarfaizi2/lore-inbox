Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261483AbVCNEJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261483AbVCNEJt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 23:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261526AbVCNEJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 23:09:49 -0500
Received: from mail.dif.dk ([193.138.115.101]:30182 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261483AbVCNEG3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 23:06:29 -0500
Date: Mon, 14 Mar 2005 05:07:45 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Steven French <sfrench@us.ibm.com>
Cc: Andreas Dilger <adilger@clusterfs.com>,
       =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Domen Puncer <domen@coderock.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-cifs-client@lists.samba.org, samba-technical@lists.samba.org
Subject: [PATCH][-mm][2/2] cifs: rework cifs_open, helper functions, kfree
 cleanups, whitespace changes
Message-ID: <Pine.LNX.4.62.0503140458110.2501@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Steven,

Here's the second of two patches with cleanups for fs/cifs/file.c

This patch attempts to shorten the very long cifs_open function by moving 
some of the code into helper functions and also reduce nesting so the 
function easier fits in 80 columns.
The patch also removes redundant checks of variables against NULL before 
calling kfree on them, since kfree handles NULL pointers just fine.
Finally it makes some whitespace changes so that all long lines are broken 
up and the entire file fits in 80 columns.

This patch is incremental to the previous one just sent.

Please note that I have no machines available at the moment that I can
actually test cifs against, so the only testing this patch has seen has
been me eyeballing the changes and checking that the patched file compiles
cleanly.
Please review this one carefully. I believe it should be equivalent to the 
original, but I'd very much like some other eyeballs to double-check me.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.11-mm3/fs/cifs/file.c.with_patch_1 linux-2.6.11-mm3/fs/cifs/file.c
--- linux-2.6.11-mm3/fs/cifs/file.c.with_patch_1	2005-03-13 18:21:19.000000000 +0100
+++ linux-2.6.11-mm3/fs/cifs/file.c	2005-03-14 04:40:16.000000000 +0100
@@ -35,6 +35,115 @@
 #include "cifs_debug.h"
 #include "cifs_fs_sb.h"
 
+static inline struct cifsFileInfo *cifs_init_private(
+	struct cifsFileInfo *private_data, struct inode *inode,
+	struct file *file, __u16 netfid)
+{
+	memset(private_data, 0, sizeof(struct cifsFileInfo));
+	private_data->netfid = netfid;
+	private_data->pid = current->tgid;	
+	init_MUTEX(&private_data->fh_sem);
+	private_data->pfile = file; /* needed for writepage */
+	private_data->pInode = inode;
+	private_data->invalidHandle = FALSE;
+	private_data->closePend = FALSE;
+
+	return private_data;
+}
+
+static inline int cifs_convert_flags(unsigned int flags)
+{
+	if ((flags & O_ACCMODE) == O_RDONLY)
+		return GENERIC_READ;
+	else if ((flags & O_ACCMODE) == O_WRONLY)
+		return GENERIC_WRITE;
+	else if ((flags & O_ACCMODE) == O_RDWR) {
+		/* GENERIC_ALL is too much permission to request */
+		/* can cause unnecessary access denied on create */
+		/* return GENERIC_ALL; */
+		return (GENERIC_READ | GENERIC_WRITE);
+	}
+	return 0x20197;
+}
+
+static inline int cifs_get_disposition(unsigned int flags)
+{
+	if ((flags & (O_CREAT | O_EXCL)) == (O_CREAT | O_EXCL))
+		return FILE_CREATE;
+	else if ((flags & (O_CREAT | O_TRUNC)) == (O_CREAT | O_TRUNC))
+		return FILE_OVERWRITE_IF;
+	else if ((flags & O_CREAT) == O_CREAT)
+		return FILE_OPEN_IF;
+	else
+		return FILE_OPEN;
+}
+
+/* all arguments to this function must be checked for validity in caller */
+static inline int cifs_open_inode_helper(struct inode *inode, struct file *file,
+	struct cifsInodeInfo *pCifsInode, struct cifsFileInfo *pCifsFile,
+	struct cifsTconInfo *pTcon, int *oplock, FILE_ALL_INFO *buf,
+	char *full_path, int xid)
+{
+	struct timespec temp;
+	int rc;
+
+	/* want handles we can use to read with first */
+	/* in the list so we do not have to walk the */
+	/* list to search for one in prepare_write */
+	if ((file->f_flags & O_ACCMODE) == O_WRONLY) {
+		list_add_tail(&pCifsFile->flist, 
+			&pCifsInode->openFileList);
+	} else {
+		list_add(&pCifsFile->flist,
+			 &pCifsInode->openFileList);
+	}
+	write_unlock(&GlobalSMBSeslock);
+	write_unlock(&file->f_owner.lock);
+	if (pCifsInode->clientCanCacheRead) {
+		/* we have the inode open somewhere else
+		   no need to discard cache data */
+		goto client_can_cache;
+	}
+
+	/* BB need same check in cifs_create too? */
+	/* if not oplocked, invalidate inode pages if mtime or
+	   file size changed */
+	temp = cifs_NTtimeToUnix(le64_to_cpu(buf->LastWriteTime));
+	if (timespec_equal(&file->f_dentry->d_inode->i_mtime, &temp) && 
+			   (file->f_dentry->d_inode->i_size == 
+			    (loff_t)le64_to_cpu(buf->EndOfFile))) {
+		cFYI(1, ("inode unchanged on server"));
+	} else {
+		if (file->f_dentry->d_inode->i_mapping) {
+		/* BB no need to lock inode until after invalidate */
+		/* since namei code should already have it locked? */
+			filemap_fdatawrite(file->f_dentry->d_inode->i_mapping);
+			filemap_fdatawait(file->f_dentry->d_inode->i_mapping);
+		}
+		cFYI(1, ("invalidating remote inode since open detected it "
+			 "changed"));
+		invalidate_remote_inode(file->f_dentry->d_inode);
+	}
+
+client_can_cache:
+	if (pTcon->ses->capabilities & CAP_UNIX)
+		rc = cifs_get_inode_info_unix(&file->f_dentry->d_inode,
+			full_path, inode->i_sb, xid);
+	else
+		rc = cifs_get_inode_info(&file->f_dentry->d_inode,
+			full_path, buf, inode->i_sb, xid);
+
+	if ((*oplock & 0xF) == OPLOCK_EXCLUSIVE) {
+		pCifsInode->clientCanCacheAll = TRUE;
+		pCifsInode->clientCanCacheRead = TRUE;
+		cFYI(1, ("Exclusive Oplock granted on inode %p",
+			 file->f_dentry->d_inode));
+	} else if ((*oplock & 0xF) == OPLOCK_READ)
+		pCifsInode->clientCanCacheRead = TRUE;
+
+	return rc;
+}
+
 int cifs_open(struct inode *inode, struct file *file)
 {
 	int rc = -EACCES;
@@ -45,7 +154,7 @@ int cifs_open(struct inode *inode, struc
 	struct cifsInodeInfo *pCifsInode;
 	struct list_head *tmp;
 	char *full_path = NULL;
-	int desiredAccess = 0x20197;
+	int desiredAccess;
 	int disposition;
 	__u16 netfid;
 	FILE_ALL_INFO *buf = NULL;
@@ -56,14 +165,19 @@ int cifs_open(struct inode *inode, struc
 	pTcon = cifs_sb->tcon;
 
 	if (file->f_flags & O_CREAT) {
-		/* search inode for this file and fill in file->private_data = */
+		/* search inode for this file and fill in 
+		   file->private_data = */
 		pCifsInode = CIFS_I(file->f_dentry->d_inode);
 		read_lock(&GlobalSMBSeslock);
 		list_for_each(tmp, &pCifsInode->openFileList) {            
 			pCifsFile = list_entry(tmp, struct cifsFileInfo, flist);           
-			if ((pCifsFile->pfile == NULL) && (pCifsFile->pid == current->tgid)) {
-			/* mode set in cifs_create */
-				pCifsFile->pfile = file; /* needed for writepage */
+			if ((pCifsFile->pfile == NULL) && 
+			    (pCifsFile->pid == current->tgid)) {
+				/* mode set in cifs_create */
+
+				/* needed for writepage */
+				pCifsFile->pfile = file;
+
 				file->private_data = pCifsFile;
 				break;
 			}
@@ -75,7 +189,8 @@ int cifs_open(struct inode *inode, struc
 			return rc;
 		} else {
 			if (file->f_flags & O_EXCL)
-				cERROR(1, ("could not find file instance for new file %p ", file));
+				cERROR(1, ("could not find file instance for "
+					   "new file %p ", file));
 		}
 	}
 
@@ -87,17 +202,9 @@ int cifs_open(struct inode *inode, struc
 		return -ENOMEM;
 	}
 
-	cFYI(1, (" inode = 0x%p file flags are 0x%x for %s", inode, file->f_flags, full_path));
-	if ((file->f_flags & O_ACCMODE) == O_RDONLY)
-		desiredAccess = GENERIC_READ;
-	else if ((file->f_flags & O_ACCMODE) == O_WRONLY)
-		desiredAccess = GENERIC_WRITE;
-	else if ((file->f_flags & O_ACCMODE) == O_RDWR) {
-		/* GENERIC_ALL is too much permission to request */
-		/* can cause unnecessary access denied on create */
-		/* desiredAccess = GENERIC_ALL; */
-		desiredAccess = GENERIC_READ | GENERIC_WRITE;
-	}
+	cFYI(1, (" inode = 0x%p file flags are 0x%x for %s", 
+		inode, file->f_flags, full_path));
+	desiredAccess = cifs_convert_flags(file->f_flags);
 
 /*********************************************************************
  *  open flag mapping table:
@@ -123,14 +230,7 @@ int cifs_open(struct inode *inode, struc
  *	 O_FASYNC, O_NOFOLLOW, O_NONBLOCK need further investigation
  *********************************************************************/
 
-	if ((file->f_flags & (O_CREAT | O_EXCL)) == (O_CREAT | O_EXCL))
-		disposition = FILE_CREATE;
-	else if ((file->f_flags & (O_CREAT | O_TRUNC)) == (O_CREAT | O_TRUNC))
-		disposition = FILE_OVERWRITE_IF;
-	else if ((file->f_flags & O_CREAT) == O_CREAT)
-		disposition = FILE_OPEN_IF;
-	else
-		disposition = FILE_OPEN;
+	disposition = cifs_get_disposition(file->f_flags);
 
 	if (oplockEnabled)
 		oplock = REQ_OPLOCK;
@@ -147,111 +247,64 @@ int cifs_open(struct inode *inode, struc
 	and the first handle has writebehind data, we might be 
 	able to simply do a filemap_fdatawrite/filemap_fdatawait first */
 	buf = kmalloc(sizeof(FILE_ALL_INFO), GFP_KERNEL);
-	if (buf == NULL) {
-		if (full_path)
-			kfree(full_path);
-		FreeXid(xid);
-		return -ENOMEM;
+	if (!buf) {
+		rc = -ENOMEM;
+		goto out;
 	}
+
+	file->private_data = kmalloc(sizeof(struct cifsFileInfo), GFP_KERNEL);
+	if (!file->private_data) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
 	rc = CIFSSMBOpen(xid, pTcon, full_path, disposition, desiredAccess,
-			CREATE_NOT_DIR, &netfid, &oplock, buf, cifs_sb->local_nls);
+			 CREATE_NOT_DIR, &netfid, &oplock, buf, 
+			 cifs_sb->local_nls);
 	if (rc) {
 		cFYI(1, ("cifs_open returned 0x%x ", rc));
-		cFYI(1, ("oplock: %d ", oplock));	
-	} else {
-		file->private_data =
-			kmalloc(sizeof(struct cifsFileInfo), GFP_KERNEL);
-		if (file->private_data) {
-			memset(file->private_data, 0, sizeof(struct cifsFileInfo));
-			pCifsFile = (struct cifsFileInfo *)file->private_data;
-			pCifsFile->netfid = netfid;
-			pCifsFile->pid = current->tgid;
-			init_MUTEX(&pCifsFile->fh_sem);
-			pCifsFile->pfile = file; /* needed for writepage */
-			pCifsFile->pInode = inode;
-			pCifsFile->invalidHandle = FALSE;
-			pCifsFile->closePend = FALSE;
-			write_lock(&file->f_owner.lock);
-			write_lock(&GlobalSMBSeslock);
-			list_add(&pCifsFile->tlist, &pTcon->openFileList);
-			pCifsInode = CIFS_I(file->f_dentry->d_inode);
-			if (pCifsInode) {
-				/* want handles we can use to read with first */
-				/* in the list so we do not have to walk the */
-				/* list to search for one in prepare_write */
-				if ((file->f_flags & O_ACCMODE) == O_WRONLY) {
-					list_add_tail(&pCifsFile->flist, &pCifsInode->openFileList);
-				} else {
-					list_add(&pCifsFile->flist, &pCifsInode->openFileList);
-				}
-				write_unlock(&GlobalSMBSeslock);
-				write_unlock(&file->f_owner.lock);
-				if (pCifsInode->clientCanCacheRead) {
-					/* we have the inode open somewhere else
-					   no need to discard cache data */
-				} else {
-					if (buf) {
-					/* BB need same check in cifs_create too? */
-
-					/* if not oplocked, invalidate inode pages if mtime 
-					   or file size changed */
-						struct timespec temp;
-						temp = cifs_NTtimeToUnix(le64_to_cpu(buf->LastWriteTime));
-						if (timespec_equal(&file->f_dentry->d_inode->i_mtime, &temp) && 
-							(file->f_dentry->d_inode->i_size == (loff_t)le64_to_cpu(buf->EndOfFile))) {
-							cFYI(1, ("inode unchanged on server"));
-						} else {
-							if (file->f_dentry->d_inode->i_mapping) {
-							/* BB no need to lock inode until after invalidate*/
-							/* since namei code should already have it locked?*/
-								filemap_fdatawrite(file->f_dentry->d_inode->i_mapping);
-								filemap_fdatawait(file->f_dentry->d_inode->i_mapping);
-							}
-							cFYI(1, ("invalidating remote inode since open detected it changed"));
-							invalidate_remote_inode(file->f_dentry->d_inode);
-						}
-					}
-				}
-				if (pTcon->ses->capabilities & CAP_UNIX)
-					rc = cifs_get_inode_info_unix(&file->f_dentry->d_inode,
-						full_path, inode->i_sb, xid);
-				else
-					rc = cifs_get_inode_info(&file->f_dentry->d_inode,
-						full_path, buf, inode->i_sb, xid);
+		cFYI(1, ("oplock: %d ", oplock));
+		goto out;
+	}
 
-				if ((oplock & 0xF) == OPLOCK_EXCLUSIVE) {
-					pCifsInode->clientCanCacheAll = TRUE;
-					pCifsInode->clientCanCacheRead = TRUE;
-					cFYI(1, ("Exclusive Oplock granted on inode %p", file->f_dentry->d_inode));
-				} else if ((oplock & 0xF) == OPLOCK_READ)
-					pCifsInode->clientCanCacheRead = TRUE;
-			} else {
-				write_unlock(&GlobalSMBSeslock);
-				write_unlock(&file->f_owner.lock);
-			}
-			if (oplock & CIFS_CREATE_ACTION) {           
-				/* time to set mode which we can not set earlier due
-				 to problems creating new read-only files */
-				if (cifs_sb->tcon->ses->capabilities & CAP_UNIX) {
-					CIFSSMBUnixSetPerms(xid, pTcon, full_path, inode->i_mode,
-						(__u64)-1, 
-						(__u64)-1,
-						0 /* dev */,
-						cifs_sb->local_nls);
-				} else {
-					/* BB implement via Windows security descriptors eg */
-					/* CIFSSMBWinSetPerms(xid, pTcon, full_path, mode, -1, -1, local_nls); */
-					/* in the meantime could set r/o dos attribute when perms are eg: */
-					/* mode & 0222 == 0 */
-				}
-			}
+	pCifsFile = cifs_init_private(file->private_data, inode, file, netfid);
+	write_lock(&file->f_owner.lock);
+	write_lock(&GlobalSMBSeslock);
+	list_add(&pCifsFile->tlist, &pTcon->openFileList);
+	pCifsInode = CIFS_I(file->f_dentry->d_inode);
+
+	if (pCifsInode) {
+		rc = cifs_open_inode_helper(inode, file, pCifsInode,
+				       pCifsFile, pTcon, 
+				       &oplock, buf, full_path, xid);
+	} else {
+		write_unlock(&GlobalSMBSeslock);
+		write_unlock(&file->f_owner.lock);
+	}
+	if (oplock & CIFS_CREATE_ACTION) {           
+		/* time to set mode which we can not set
+		   earlier due to problems creating new
+		   read-only files */
+		if (cifs_sb->tcon->ses->capabilities & 
+		    CAP_UNIX) {
+			CIFSSMBUnixSetPerms(xid, pTcon, 
+				full_path, inode->i_mode,
+				(__u64)-1, 
+				(__u64)-1,
+				0 /* dev */,
+				cifs_sb->local_nls);
+		} else {
+			/* BB implement via Windows security descriptors eg
+			   CIFSSMBWinSetPerms(xid, pTcon, full_path, mode,
+					      -1, -1, local_nls);
+			   in the meantime could set r/o dos attribute when 
+			   perms are eg: mode & 0222 == 0 */
 		}
 	}
 
-	if (buf)
-		kfree(buf);
-	if (full_path)
-		kfree(full_path);
+out:
+	kfree(buf);
+	kfree(full_path);
 	FreeXid(xid);
 	return rc;
 }
@@ -277,7 +330,7 @@ static int cifs_reopen_file(struct inode
 	struct cifsFileInfo *pCifsFile;
 	struct cifsInodeInfo *pCifsInode;
 	char *full_path = NULL;
-	int desiredAccess = 0x20197;
+	int desiredAccess;
 	int disposition = FILE_OPEN;
 	__u16 netfid;
 
@@ -315,24 +368,15 @@ and we can never tell if the caller alre
 		return -ENOMEM;
 	}
 
-	cFYI(1, (" inode = 0x%p file flags are 0x%x for %s", inode, file->f_flags,full_path));
-	if ((file->f_flags & O_ACCMODE) == O_RDONLY)
-		desiredAccess = GENERIC_READ;
-	else if ((file->f_flags & O_ACCMODE) == O_WRONLY)
-		desiredAccess = GENERIC_WRITE;
-	else if ((file->f_flags & O_ACCMODE) == O_RDWR) {
-		/* GENERIC_ALL is too much permission to request */
-		/* can cause unnecessary access denied on create */
-		/* desiredAccess = GENERIC_ALL; */
-		desiredAccess = GENERIC_READ | GENERIC_WRITE;
-	}
+	cFYI(1, (" inode = 0x%p file flags are 0x%x for %s",
+		 inode, file->f_flags,full_path));
+	desiredAccess = cifs_convert_flags(file->f_flags);
 
 	if (oplockEnabled)
 		oplock = REQ_OPLOCK;
 	else
 		oplock = FALSE;
 
-	
 	/* Can not refresh inode by passing in file_info buf to be returned
 	 by SMBOpen and then calling get_inode_info with returned buf 
 	 since file might have write behind data that needs to be flushed 
@@ -342,13 +386,13 @@ and we can never tell if the caller alre
 /*	buf = kmalloc(sizeof(FILE_ALL_INFO), GFP_KERNEL);
 	if (buf == 0) {
 		up(&pCifsFile->fh_sem);
-		if (full_path)
-			kfree(full_path);
+		kfree(full_path);
 		FreeXid(xid);
 		return -ENOMEM;
 	} */
 	rc = CIFSSMBOpen(xid, pTcon, full_path, disposition, desiredAccess,
-				CREATE_NOT_DIR, &netfid, &oplock, NULL, cifs_sb->local_nls);
+				CREATE_NOT_DIR, &netfid, &oplock, NULL, 
+				cifs_sb->local_nls);
 	if (rc) {
 		up(&pCifsFile->fh_sem);
 		cFYI(1, ("cifs_open returned 0x%x ", rc));
@@ -371,7 +415,8 @@ and we can never tell if the caller alre
 						full_path, inode->i_sb, xid);
 				else
 					rc = cifs_get_inode_info(&inode,
-						full_path, NULL, inode->i_sb, xid);
+						full_path, NULL, inode->i_sb,
+						xid);
 			} /* else we are writing out data to server already
 			and could deadlock if we tried to flush data, and 
 			since we do not know if we have data that would
@@ -381,7 +426,8 @@ and we can never tell if the caller alre
 			if ((oplock & 0xF) == OPLOCK_EXCLUSIVE) {
 				pCifsInode->clientCanCacheAll = TRUE;
 				pCifsInode->clientCanCacheRead = TRUE;
-				cFYI(1, ("Exclusive Oplock granted on inode %p", file->f_dentry->d_inode));
+				cFYI(1, ("Exclusive Oplock granted on inode %p",
+					 file->f_dentry->d_inode));
 			} else if ((oplock & 0xF) == OPLOCK_READ) {
 				pCifsInode->clientCanCacheRead = TRUE;
 				pCifsInode->clientCanCacheAll = FALSE;
@@ -393,8 +439,7 @@ and we can never tell if the caller alre
 		}
 	}
 
-	if (full_path)
-		kfree(full_path);
+	kfree(full_path);
 	FreeXid(xid);
 	return rc;
 }
@@ -427,8 +472,7 @@ int cifs_close(struct inode *inode, stru
 		list_del(&pSMBFile->flist);
 		list_del(&pSMBFile->tlist);
 		write_unlock(&file->f_owner.lock);
-		if (pSMBFile->search_resume_name)
-			kfree(pSMBFile->search_resume_name);
+		kfree(pSMBFile->search_resume_name);
 		kfree(file->private_data);
 		file->private_data = NULL;
 	} else
@@ -475,13 +519,13 @@ int cifs_closedir(struct inode *inode, s
 		}
 		ptmp = pCFileStruct->srch_inf.ntwrk_buf_start;
 		if (ptmp) {
-			cFYI(1, ("freeing smb buf in srch struct in closedir")); /* BB removeme BB */
+   /* BB removeme BB */	cFYI(1, ("freeing smb buf in srch struct in closedir"));
 			pCFileStruct->srch_inf.ntwrk_buf_start = NULL;
 			cifs_buf_release(ptmp);
 		}
 		ptmp = pCFileStruct->search_resume_name;
 		if (ptmp) {
-			cFYI(1, ("freeing resume name in closedir")); /* BB removeme BB */
+   /* BB removeme BB */	cFYI(1, ("freeing resume name in closedir"));
 			pCFileStruct->search_resume_name = NULL;
 			kfree(ptmp);
 		}
@@ -508,10 +552,10 @@ int cifs_lock(struct file *file, int cmd
 	rc = -EACCES;
 	xid = GetXid();
 
-	cFYI(1,
-	     ("Lock parm: 0x%x flockflags: 0x%x flocktype: 0x%x start: %lld end: %lld",
-	      cmd, pfLock->fl_flags, pfLock->fl_type, pfLock->fl_start,
-	      pfLock->fl_end));
+	cFYI(1, ("Lock parm: 0x%x flockflags: "
+		 "0x%x flocktype: 0x%x start: %lld end: %lld",
+	        cmd, pfLock->fl_flags, pfLock->fl_type, pfLock->fl_start,
+	        pfLock->fl_end));
 
 	if (pfLock->fl_flags & FL_POSIX)
 		cFYI(1, ("Posix "));
@@ -522,10 +566,12 @@ int cifs_lock(struct file *file, int cmd
 		wait_flag = TRUE;
 	}
 	if (pfLock->fl_flags & FL_ACCESS)
-		cFYI(1, ("Process suspended by mandatory locking - not implemented yet "));
+		cFYI(1, ("Process suspended by mandatory locking - "
+			 "not implemented yet "));
 	if (pfLock->fl_flags & FL_LEASE)
 		cFYI(1, ("Lease on file - not implemented yet"));
-	if (pfLock->fl_flags & (~(FL_POSIX | FL_FLOCK | FL_SLEEP | FL_ACCESS | FL_LEASE)))
+	if (pfLock->fl_flags & 
+	    (~(FL_POSIX | FL_FLOCK | FL_SLEEP | FL_ACCESS | FL_LEASE)))
 		cFYI(1, ("Unknown lock flags 0x%x", pfLock->fl_flags));
 
 	if (pfLock->fl_type == F_WRLCK) {
@@ -573,14 +619,15 @@ int cifs_lock(struct file *file, int cmd
 					 0 /* wait flag */ );
 			pfLock->fl_type = F_UNLCK;
 			if (rc != 0)
-				cERROR(1,
-					("Error unlocking previously locked range %d during test of lock ",
-					rc));
+				cERROR(1, ("Error unlocking previously locked "
+					   "range %d during test of lock ",
+					   rc));
 			rc = 0;
 
 		} else {
 			/* if rc == ERR_SHARING_VIOLATION ? */
-			rc = 0;	/* do not change lock type to unlock since range in use */
+			rc = 0;	/* do not change lock type to unlock
+				   since range in use */
 		}
 
 		FreeXid(xid);
@@ -674,7 +721,8 @@ ssize_t cifs_user_write(struct file *fil
 
 			rc = CIFSSMBWrite(xid, pTcon,
 				open_file->netfid,
-				min_t(const int, cifs_sb->wsize, write_size - total_written),
+				min_t(const int, cifs_sb->wsize,
+				      write_size - total_written),
 				*poffset, &bytes_written,
 				NULL, write_data + total_written, long_op);
 		}
@@ -687,7 +735,8 @@ ssize_t cifs_user_write(struct file *fil
 			}
 		} else
 			*poffset += bytes_written;
-		long_op = FALSE; /* subsequent writes fast - 15 seconds is plenty */
+		long_op = FALSE; /* subsequent writes fast -
+				    15 seconds is plenty */
 	}
 
 #ifdef CONFIG_CIFS_STATS
@@ -707,7 +756,8 @@ ssize_t cifs_user_write(struct file *fil
 				current_fs_time(inode->i_sb);
 			if (total_written > 0) {
 				if (*poffset > file->f_dentry->d_inode->i_size)
-					i_size_write(file->f_dentry->d_inode, *poffset);
+					i_size_write(file->f_dentry->d_inode,
+					*poffset);
 			}
 			mark_inode_dirty_sync(file->f_dentry->d_inode);
 		}
@@ -752,7 +802,7 @@ static ssize_t cifs_write(struct file *f
 	}
 
 	if (*poffset > file->f_dentry->d_inode->i_size)
-		long_op = 2;  /* writes past end of file can take a long time */
+		long_op = 2; /* writes past end of file can take a long time */
 	else
 		long_op = 1;
 
@@ -765,7 +815,8 @@ static ssize_t cifs_write(struct file *f
 				FreeXid(xid);
 			/* if we have gotten here we have written some data
 			   and blocked, and the file has been freed on us
-			   while we blocked so return what we managed to write */
+			   while we blocked so return what we managed to 
+			   write */
 				return total_written;
 			} 
 			if (open_file->closePend) {
@@ -783,7 +834,8 @@ static ssize_t cifs_write(struct file *f
 				}
 				/* we could deadlock if we called
 				   filemap_fdatawait from here so tell
-				   reopen_file not to flush data to server now */
+				   reopen_file not to flush data to 
+				   server now */
 				rc = cifs_reopen_file(file->f_dentry->d_inode,
 					file, FALSE);
 				if (rc != 0)
@@ -792,7 +844,8 @@ static ssize_t cifs_write(struct file *f
 
 			rc = CIFSSMBWrite(xid, pTcon,
 				 open_file->netfid,
-				 min_t(const int, cifs_sb->wsize, write_size - total_written),
+				 min_t(const int, cifs_sb->wsize, 
+				       write_size - total_written),
 				 *poffset, &bytes_written,
 				 write_data + total_written, NULL, long_op);
 		}
@@ -805,7 +858,8 @@ static ssize_t cifs_write(struct file *f
 			}
 		} else
 			*poffset += bytes_written;
-		long_op = FALSE; /* subsequent writes fast - 15 seconds is plenty */
+		long_op = FALSE; /* subsequent writes fast - 
+				    15 seconds is plenty */
 	}
 
 #ifdef CONFIG_CIFS_STATS
@@ -824,7 +878,8 @@ static ssize_t cifs_write(struct file *f
 			file->f_dentry->d_inode->i_mtime = CURRENT_TIME;
 			if (total_written > 0) {
 				if (*poffset > file->f_dentry->d_inode->i_size)
-					i_size_write(file->f_dentry->d_inode, *poffset);
+					i_size_write(file->f_dentry->d_inode, 
+						     *poffset);
 			}
 			mark_inode_dirty_sync(file->f_dentry->d_inode);
 		}
@@ -848,9 +903,7 @@ static int cifs_partialpagewrite(struct 
 	struct list_head *tmp;
 	struct list_head *tmp1;
 
-	if (!mapping)
-		return -EFAULT;
-	else if (!mapping->host)
+	if (!mapping || !mapping->host)
 		return -EFAULT;
 
 	inode = page->mapping->host;
@@ -875,7 +928,6 @@ static int cifs_partialpagewrite(struct 
 	/* check to make sure that we are not extending the file */
 	if (mapping->host->i_size - offset < (loff_t)to)
 		to = (unsigned)(mapping->host->i_size - offset); 
-		
 
 	cifsInode = CIFS_I(mapping->host);
 	read_lock(&GlobalSMBSeslock); 
@@ -890,10 +942,11 @@ static int cifs_partialpagewrite(struct 
 			(open_file->pfile->f_flags & O_WRONLY))) {
 			read_unlock(&GlobalSMBSeslock);
 			bytes_written = cifs_write(open_file->pfile, write_data,
-					to-from, &offset);
+						to-from, &offset);
 			read_lock(&GlobalSMBSeslock);
 		/* Does mm or vfs already set times? */
-			inode->i_atime = inode->i_mtime = current_fs_time(inode->i_sb);
+			inode->i_atime = 
+			inode->i_mtime = current_fs_time(inode->i_sb);
 			if ((bytes_written > 0) && (offset)) {
 				rc = 0;
 			} else if (bytes_written < 0) {
@@ -974,7 +1027,8 @@ static int cifs_commit_write(struct file
 	char *page_data;
 
 	xid = GetXid();
-	cFYI(1, ("commit write for page %p up to position %lld for %d", page, position, to));
+	cFYI(1, ("commit write for page %p up to position %lld for %d", 
+		 page, position, to));
 	if (position > inode->i_size) {
 		i_size_write(inode, position);
 		/* if (file->private_data == NULL) {
@@ -986,12 +1040,14 @@ static int cifs_commit_write(struct file
 			while (rc == -EAGAIN) {
 				if ((open_file->invalidHandle) && 
 				    (!open_file->closePend)) {
-					rc = cifs_reopen_file(file->f_dentry->d_inode,file);
+					rc = cifs_reopen_file(
+						file->f_dentry->d_inode, file);
 					if (rc != 0)
 						break;
 				}
 				if (!open_file->closePend) {
-					rc = CIFSSMBSetFileSize(xid, cifs_sb->tcon, 
+					rc = CIFSSMBSetFileSize(xid, 
+								cifs_sb->tcon, 
 						position, open_file->netfid,
 						open_file->pid,FALSE);
 				} else {
@@ -1067,7 +1123,7 @@ int cifs_fsync(struct file *file, struct
 		return 0; */
 
 /*	fill in rpages then 
-	result = cifs_pagein_inode(inode, index, rpages); *//* BB finish */
+	result = cifs_pagein_inode(inode, index, rpages); */ /* BB finish */
 
 /*	cFYI(1, ("rpages is %d for sync page of Index %ld ", rpages, index));
 
@@ -1086,14 +1142,14 @@ int cifs_flush(struct file *file)
 	struct inode * inode = file->f_dentry->d_inode;
 	int rc = 0;
 
-	/* Rather than do the steps manually: */
-	/* lock the inode for writing */
-	/* loop through pages looking for write behind data (dirty pages) */
-	/* coalesce into contiguous 16K (or smaller) chunks to write to server */
-	/* send to server (prefer in parallel) */
-	/* deal with writebehind errors */
-	/* unlock inode for writing */
-	/* filemapfdatawrite appears easier for the time being */
+	/* Rather than do the steps manually:
+	   lock the inode for writing
+	   loop through pages looking for write behind data (dirty pages)
+	   coalesce into contiguous 16K (or smaller) chunks to write to server
+	   send to server (prefer in parallel)
+	   deal with writebehind errors
+	   unlock inode for writing
+	   filemapfdatawrite appears easier for the time being */
 
 	rc = filemap_fdatawrite(inode->i_mapping);
 	if (rc == 0) /* reset wb rc if we were able to write out dirty pages */
@@ -1133,12 +1189,15 @@ ssize_t cifs_user_read(struct file *file
 		cFYI(1, ("attempting read on write only file instance"));
 	}
 	for (total_read = 0, current_offset = read_data; read_size > total_read;
-				total_read += bytes_read, current_offset += bytes_read) {
-		current_read_size = min_t(const int, read_size - total_read, cifs_sb->rsize);
+				total_read += bytes_read,
+				current_offset += bytes_read) {
+		current_read_size = min_t(const int, read_size - total_read, 
+					  cifs_sb->rsize);
 		rc = -EAGAIN;
 		smb_read_data = NULL;
 		while (rc == -EAGAIN) {
-			if ((open_file->invalidHandle) && (!open_file->closePend)) {
+			if ((open_file->invalidHandle) && 
+			    (!open_file->closePend)) {
 				rc = cifs_reopen_file(file->f_dentry->d_inode,
 					file, TRUE);
 				if (rc != 0)
@@ -1151,8 +1210,10 @@ ssize_t cifs_user_read(struct file *file
 				 &bytes_read, &smb_read_data);
 
 			pSMBr = (struct smb_com_read_rsp *)smb_read_data;
-			if (copy_to_user(current_offset,smb_read_data + 4 /* RFC1001 hdr*/
-				+ le16_to_cpu(pSMBr->DataOffset), bytes_read)) {
+			if (copy_to_user(current_offset, 
+					 smb_read_data + 4 /* RFC1001 hdr */
+					 + le16_to_cpu(pSMBr->DataOffset), 
+					 bytes_read)) {
 				rc = -EFAULT;
 				FreeXid(xid);
 				return rc;
@@ -1210,11 +1271,14 @@ static ssize_t cifs_read(struct file *fi
 		cFYI(1, ("attempting read on write only file instance"));
 
 	for (total_read = 0, current_offset = read_data; read_size > total_read;
-				total_read += bytes_read, current_offset += bytes_read) {
-		current_read_size = min_t(const int, read_size - total_read, cifs_sb->rsize);
+				total_read += bytes_read,
+				current_offset += bytes_read) {
+		current_read_size = min_t(const int, read_size - total_read,
+					  cifs_sb->rsize);
 		rc = -EAGAIN;
 		while (rc == -EAGAIN) {
-			if ((open_file->invalidHandle) && (!open_file->closePend)) {
+			if ((open_file->invalidHandle) && 
+			    (!open_file->closePend)) {
 				rc = cifs_reopen_file(file->f_dentry->d_inode,
 					file, TRUE);
 				if (rc != 0)
@@ -1300,7 +1364,8 @@ static void cifs_copy_cache_pages(struct
 		if (PAGE_CACHE_SIZE > bytes_read) {
 			memcpy(target, data, bytes_read);
 			/* zero the tail end of this partial page */
-			memset(target +bytes_read, 0, PAGE_CACHE_SIZE - bytes_read);
+			memset(target + bytes_read, 0, 
+			       PAGE_CACHE_SIZE - bytes_read);
 			bytes_read = 0;
 		} else {
 			memcpy(target, data, PAGE_CACHE_SIZE);
@@ -1358,7 +1423,8 @@ static int cifs_readpages(struct file *f
 
 		/* count adjacent pages that we will read into */
 		contig_pages = 0;
-		expected_index = list_entry(page_list->prev,struct page,lru)->index;
+		expected_index = 
+			list_entry(page_list->prev, struct page, lru)->index;
 		list_for_each_entry_reverse(tmp_page,page_list,lru) {
 			if (tmp_page->index == expected_index) {
 				contig_pages++;
@@ -1369,15 +1435,18 @@ static int cifs_readpages(struct file *f
 		if (contig_pages + i >  num_pages)
 			contig_pages = num_pages - i;
 
-		/* for reads over a certain size could initiate async read ahead */
+		/* for reads over a certain size could initiate async
+		   read ahead */
 
 		read_size = contig_pages * PAGE_CACHE_SIZE;
 		/* Read size needs to be in multiples of one page */
-		read_size = min_t(const unsigned int, read_size, cifs_sb->rsize & PAGE_CACHE_MASK);
+		read_size = min_t(const unsigned int, read_size,
+				  cifs_sb->rsize & PAGE_CACHE_MASK);
 
 		rc = -EAGAIN;
 		while (rc == -EAGAIN) {
-			if ((open_file->invalidHandle) && (!open_file->closePend)) {
+			if ((open_file->invalidHandle) && 
+			    (!open_file->closePend)) {
 				rc = cifs_reopen_file(file->f_dentry->d_inode,
 					file, TRUE);
 				if (rc != 0)
@@ -1400,7 +1469,8 @@ static int cifs_readpages(struct file *f
 			cFYI(1, ("Read error in readpages: %d", rc));
 			/* clean up remaing pages off list */
 			while (!list_empty(page_list) && (i < num_pages)) {
-				page = list_entry(page_list->prev, struct page, lru);
+				page = list_entry(page_list->prev, struct page,
+						  lru);
 				list_del(&page->lru);
 				page_cache_release(page);
 			}
@@ -1421,24 +1491,33 @@ static int cifs_readpages(struct file *f
 			if ((int)(bytes_read & PAGE_CACHE_MASK) != bytes_read) {
 				i++; /* account for partial page */
 
-				/* server copy of file can have smaller size than client */
-				/* BB do we need to verify this common case ? this case is ok - 
-				if we are at server EOF we will hit it on next read */
+				/* server copy of file can have smaller size 
+				   than client */
+				/* BB do we need to verify this common case ? 
+				   this case is ok - if we are at server EOF 
+				   we will hit it on next read */
 
 			/* while (!list_empty(page_list) && (i < num_pages)) {
-					page = list_entry(page_list->prev, struct page, list);
+					page = list_entry(page_list->prev, 
+							  struct page, list);
 					list_del(&page->list);
 					page_cache_release(page);
 				}
 				break; */
 			}
 		} else {
-			cFYI(1, ("No bytes read (%d) at offset %lld . Cleaning remaining pages from readahead list", bytes_read, offset)); 
-			/* BB turn off caching and do new lookup on file size at server? */
+			cFYI(1, ("No bytes read (%d) at offset %lld . "
+				 "Cleaning remaining pages from readahead list",
+				 bytes_read, offset));
+			/* BB turn off caching and do new lookup on 
+			   file size at server? */
 			while (!list_empty(page_list) && (i < num_pages)) {
-				page = list_entry(page_list->prev, struct page, lru);
+				page = list_entry(page_list->prev, struct page,
+						  lru);
 				list_del(&page->lru);
-				page_cache_release(page); /* BB removeme - replace with zero of page? */
+
+				/* BB removeme - replace with zero of page? */
+				page_cache_release(page);
 			}
 			break;
 		}
@@ -1507,7 +1586,8 @@ static int cifs_readpage(struct file *fi
 		return -EBADF;
 	}
 
-	cFYI(1, ("readpage %p at offset %d 0x%x\n", page, (int)offset, (int)offset));
+	cFYI(1, ("readpage %p at offset %d 0x%x\n", 
+		 page, (int)offset, (int)offset));
 
 	rc = cifs_readpage_worker(file, page, &offset);
 
@@ -1624,7 +1704,8 @@ void fill_in_inode(struct inode *tmp_ino
 	}
 
 	if (allocation_size < end_of_file)
-		cFYI(1, ("Possible sparse file: allocation size less than end of file "));
+		cFYI(1, ("Possible sparse file: "
+			 "allocation size less than end of file "));
 	cFYI(1,
 	     ("File Size %ld and blocks %ld and blocksize %ld",
 	      (unsigned long)tmp_inode->i_size, tmp_inode->i_blocks,
@@ -1757,7 +1838,8 @@ static int cifs_prepare_write(struct fil
 		}
 	}
 
-	/* BB should we pass any errors back? e.g. if we do not have read access to the file */
+	/* BB should we pass any errors back? 
+	   e.g. if we do not have read access to the file */
 	return 0;
 }
 



