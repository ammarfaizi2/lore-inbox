Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262058AbVCZOGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262058AbVCZOGS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 09:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262107AbVCZOFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 09:05:13 -0500
Received: from mail.dif.dk ([193.138.115.101]:19093 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262058AbVCZOCx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 09:02:53 -0500
Date: Sat, 26 Mar 2005 15:04:48 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Steve French <smfrench@austin.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][6/6] cifs: inode.c cleanup - nesting
Message-ID: <Pine.LNX.4.62.0503261503420.2488@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce nesting a bit. I guess this is a matter of personal preference, and 
in case you don't like this way, just ignore it. I made this one the last 
patch exactely so it would be easy to just drop.
The first hunk has a tiny forgotten whitespace fix.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>


--- linux-2.6.12-rc1-mm3/fs/cifs/inode.c.with_patch5	2005-03-26 14:19:26.000000000 +0100
+++ linux-2.6.12-rc1-mm3/fs/cifs/inode.c	2005-03-26 14:37:45.000000000 +0100
@@ -538,7 +538,7 @@ int cifs_mkdir(struct inode *inode, stru
 		if (direntry->d_inode)
 			direntry->d_inode->i_nlink = 2;
 		if (cifs_sb->tcon->ses->capabilities & CAP_UNIX)
-			if(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_SET_UID) {
+			if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_SET_UID) {
 				CIFSSMBUnixSetPerms(xid, pTcon, full_path,
 						    mode,
 						    (__u64)current->euid,
@@ -898,72 +898,68 @@ int cifs_setattr(struct dentry *direntry
 	filemap_fdatawrite(direntry->d_inode->i_mapping);
 	filemap_fdatawait(direntry->d_inode->i_mapping);
 
-	if (attrs->ia_valid & ATTR_SIZE) {
-		read_lock(&GlobalSMBSeslock);
-		/* To avoid spurious oplock breaks from server, in the case of
-		   inodes that we already have open, avoid doing path based
-		   setting of file size if we can do it by handle.
-		   This keeps our caching token (oplock) and avoids timeouts
-		   when the local oplock break takes longer to flush
-		   writebehind data than the SMB timeout for the SetPathInfo
-		   request would allow */
-		list_for_each(tmp, &cifsInode->openFileList) {
-			open_file = list_entry(tmp, struct cifsFileInfo,
-					       flist);
-			/* We check if file is open for writing first */
-			if ((open_file->pfile) &&
-			    ((open_file->pfile->f_flags & O_RDWR) ||
-			    (open_file->pfile->f_flags & O_WRONLY))) {
-				if (open_file->invalidHandle == FALSE) {
-					/* we found a valid, writeable network
-					   file handle to use to try to set the
-					   file size */
-					__u16 nfid = open_file->netfid;
-					__u32 npid = open_file->pid;
-					read_unlock(&GlobalSMBSeslock);
-					found = TRUE;
-					rc = CIFSSMBSetFileSize(xid, pTcon,
-						attrs->ia_size, nfid, npid,
-						FALSE);
-					cFYI(1, ("SetFileSize by handle "
-						 "(setattrs) rc = %d", rc));
-					/* Do not need reopen and retry on
-					   EAGAIN since we will retry by
-					   pathname below */
-
-					/* now that we found one valid file
-					   handle no sense continuing to loop
-					   trying others, so break here */
-					break;
-				}
-			}
-		}
-		if (found == FALSE)
-			read_unlock(&GlobalSMBSeslock);
+	if (!(attrs->ia_valid & ATTR_SIZE))
+		goto no_attr_size;
 
-		if (rc != 0) {
-			/* Set file size by pathname rather than by handle
-			   either because no valid, writeable file handle for
-			   it was found or because there was an error setting
-			   it by handle */
-			rc = CIFSSMBSetEOF(xid, pTcon, full_path,
-					   attrs->ia_size, FALSE,
-					   cifs_sb->local_nls);
-			cFYI(1, (" SetEOF by path (setattrs) rc = %d", rc));
+	read_lock(&GlobalSMBSeslock);
+	/* To avoid spurious oplock breaks from server, in the case of inodes
+	   that we already have open, avoid doing path based setting of file
+	   size if we can do it by handle.
+	   This keeps our caching token (oplock) and avoids timeouts when the
+	   local oplock break takes longer to flush writebehind data than the
+	   SMB timeout for the SetPathInfo request would allow */
+	list_for_each(tmp, &cifsInode->openFileList) {
+		open_file = list_entry(tmp, struct cifsFileInfo, flist);
+		/* We check if file is open for writing first */
+		if ((open_file->pfile) &&
+		    ((open_file->pfile->f_flags & O_RDWR) ||
+		    (open_file->pfile->f_flags & O_WRONLY))) {
+			if (open_file->invalidHandle == FALSE) {
+				/* we found a valid, writeable network
+				   file handle to use to try to set the
+				   file size */
+				__u16 nfid = open_file->netfid;
+				__u32 npid = open_file->pid;
+				read_unlock(&GlobalSMBSeslock);
+				found = TRUE;
+				rc = CIFSSMBSetFileSize(xid, pTcon,
+					attrs->ia_size, nfid, npid, FALSE);
+				cFYI(1, ("SetFileSize by handle "
+					 "(setattrs) rc = %d", rc));
+				/* Do not need reopen and retry on EAGAIN since
+				   we will retry by pathname below */
+
+				/* now that we found one valid file handle no
+				   sense continuing to loop trying others,
+				   so break here */
+				break;
+			}
 		}
+	}
+	if (found == FALSE)
+		read_unlock(&GlobalSMBSeslock);
 
-		/* Server is ok setting allocation size implicitly - no need
-		   to call:
-		CIFSSMBSetEOF(xid, pTcon, full_path, attrs->ia_size, TRUE,
-			 cifs_sb->local_nls);
-		   */
-
-		if (rc == 0) {
-			rc = vmtruncate(direntry->d_inode, attrs->ia_size);
-			cifs_truncate_page(direntry->d_inode->i_mapping,
-					   direntry->d_inode->i_size);
-		}
+	if (rc != 0) {
+		/* Set file size by pathname rather than by handle either
+		   because no valid, writeable file handle for it was found or
+		   because there was an error setting it by handle */
+		rc = CIFSSMBSetEOF(xid, pTcon, full_path, attrs->ia_size,
+				   FALSE, cifs_sb->local_nls);
+		cFYI(1, (" SetEOF by path (setattrs) rc = %d", rc));
+	}
+	/* Server is ok setting allocation size implicitly - no need
+	   to call:
+	CIFSSMBSetEOF(xid, pTcon, full_path, attrs->ia_size, TRUE,
+		      cifs_sb->local_nls);
+	   */
+
+	if (rc == 0) {
+		rc = vmtruncate(direntry->d_inode, attrs->ia_size);
+		cifs_truncate_page(direntry->d_inode->i_mapping,
+				   direntry->d_inode->i_size);
 	}
+
+no_attr_size:
 	if (attrs->ia_valid & ATTR_UID) {
 		cFYI(1, (" CIFS - UID changed to %d", attrs->ia_uid));
 		uid = attrs->ia_uid;
@@ -1026,45 +1022,46 @@ int cifs_setattr(struct dentry *direntry
 	} else
 		time_buf.ChangeTime = 0;
 
-	if (set_time || time_buf.Attributes) {
-		/* BB what if setting one attribute fails (such as size) but
-		   time setting works? */
-		time_buf.CreationTime = 0;	/* do not change */
-		/* In the future we should experiment - try setting timestamps
-		   via Handle (SetFileInfo) instead of by path */
-		if (!(pTcon->ses->flags & CIFS_SES_NT4))
-			rc = CIFSSMBSetTimes(xid, pTcon, full_path, &time_buf,
-					     cifs_sb->local_nls);
-		else
-			rc = -EOPNOTSUPP;
-
-		if (rc == -EOPNOTSUPP) {
-			int oplock = FALSE;
-			__u16 netfid;
-
-			cFYI(1, ("calling SetFileInfo since SetPathInfo for "
-				 "times not supported by this server"));
-			/* BB we could scan to see if we already have it open
-			   and pass in pid of opener to function */
-			rc = CIFSSMBOpen(xid, pTcon, full_path, FILE_OPEN,
-					 SYNCHRONIZE | FILE_WRITE_ATTRIBUTES,
-					 CREATE_NOT_DIR, &netfid, &oplock,
-					 NULL, cifs_sb->local_nls);
-			if (rc==0) {
-				rc = CIFSSMBSetFileTimes(xid, pTcon, &time_buf,
-							 netfid);
-				CIFSSMBClose(xid, pTcon, netfid);
-			} else {
-			/* BB For even older servers we could convert time_buf
-			   into old DOS style which uses two second
-			   granularity */
+	if (!(set_time || time_buf.Attributes))
+		goto out;
 
-			/* rc = CIFSSMBSetTimesLegacy(xid, pTcon, full_path,
-        	        		&time_buf, cifs_sb->local_nls); */
-			}
+	/* BB what if setting one attribute fails (such as size) but time
+	   setting works? */
+	time_buf.CreationTime = 0;	/* do not change */
+	/* In the future we should experiment - try setting timestamps via
+	   Handle (SetFileInfo) instead of by path */
+	if (!(pTcon->ses->flags & CIFS_SES_NT4))
+		rc = CIFSSMBSetTimes(xid, pTcon, full_path, &time_buf,
+				     cifs_sb->local_nls);
+	else
+		rc = -EOPNOTSUPP;
+
+	if (rc == -EOPNOTSUPP) {
+		int oplock = FALSE;
+		__u16 netfid;
+
+		cFYI(1, ("calling SetFileInfo since SetPathInfo for times not"
+			 " supported by this server"));
+		/* BB we could scan to see if we already have it open and pass
+		   in pid of opener to function */
+		rc = CIFSSMBOpen(xid, pTcon, full_path, FILE_OPEN,
+				 SYNCHRONIZE | FILE_WRITE_ATTRIBUTES,
+				 CREATE_NOT_DIR, &netfid, &oplock, NULL,
+				 cifs_sb->local_nls);
+		if (rc==0) {
+			rc = CIFSSMBSetFileTimes(xid, pTcon, &time_buf,
+						 netfid);
+			CIFSSMBClose(xid, pTcon, netfid);
+		} else {
+		/* BB For even older servers we could convert time_buf into old
+		   DOS style which uses two second granularity */
+
+		/* rc = CIFSSMBSetTimesLegacy(xid, pTcon, full_path, &time_buf,
+					      cifs_sb->local_nls); */
 		}
 	}
 
+out:
 	/* do not need local check to inode_check_ok since the server does
 	   that */
 	if (!rc)

