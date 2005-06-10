Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbVFJVro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbVFJVro (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 17:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbVFJVro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 17:47:44 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:5052 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261162AbVFJVrW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 17:47:22 -0400
Subject: [GIT PATCH] cifs fix for out of memory case that can cause write
	at wrong offset
From: Steve French <smfltc@us.ibm.com>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-GNaQjk/V3PDRX1ZOBm0m"
Organization: IBM - Linux Technology Center
Message-Id: <1118439854.5448.67.camel@stevef95.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 10 Jun 2005 16:44:14 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GNaQjk/V3PDRX1ZOBm0m
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Linus,

Please pull from:
     
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/sfrench/cifs-2.6.git/HEAD

The files changed are:

 CHANGES  |    3 ++-
 cifsfs.h |    2 +-
 file.c   |    2 ++
 inode.c  |   34 +++++++++++++++++-----------------
 4 files changed, 22 insertions(+), 19 deletions(-)

commit 3079ca621e9e09f4593c20a9a2f24237c355f683
tree 0eb2e22cb0fa382cde357f9e6125043d1cdd3758
parent 0b68177ccd12866d9f19cafad212b861c9d02a8c
author Steve French <sfrench@hera.kernel.org> Thu, 09 Jun 2005 14:44:07
-0700
committer Steve French <sfrench@hera.kernel.org> Thu, 09 Jun 2005
14:44:07 -0700

    [CIFS] Fix cifs update of page cache. Write at correct offset when
    out of memory and add_to_page_cache fails.

    Thanks to Shaggy for pointing out the fix.

    Signed-off-by: Steve French (sfrench@us.ibm.com)
    Signed-off-by: Shaggy (shaggy@us.ibm.com)

commit d0d2f2df65ddea9a30ddd117f769bfff65d3fc56
tree 43d7f695330199f8b384da4b78c5652aa06aeff3
parent 467ca22d3371f132ee225a5591a1ed0cd518cb3d
author Steve French <sfrench@hera.kernel.org> Thu, 02 Jun 2005 15:12:36
-0700
committer Steve French <sfrench@hera.kernel.org> Thu, 02 Jun 2005
15:12:36 -0700

    [CIFS] Update cifs version number and fix whitespace
    (addressing 

    Signed-off-by: Steve French (sfrench@us.ibm.com)


Change is also attached.

--=-GNaQjk/V3PDRX1ZOBm0m
Content-Disposition: attachment; filename=cifs.diff
Content-Type: text/plain; name=cifs.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: fs/cifs/CHANGES
===================================================================
--- c4f9e1d25e876e5b8fb302292c21b22edd6cf1dd/fs/cifs/CHANGES  (mode:100644)
+++ uncommitted/fs/cifs/CHANGES  (mode:100644)
@@ -6,7 +6,8 @@
 recommended, unmount and rmmod cifs will kill them when they are
 no longer needed).  Fix readdir to ASCII servers (ie older servers
 which do not support Unicode) and also require asterik.
-
+Fix out of memory case in which data could be written one page
+off in the page cache.
 
 Version 1.33
 ------------
Index: fs/cifs/cifsfs.h
===================================================================
--- c4f9e1d25e876e5b8fb302292c21b22edd6cf1dd/fs/cifs/cifsfs.h  (mode:100644)
+++ uncommitted/fs/cifs/cifsfs.h  (mode:100644)
@@ -96,5 +96,5 @@
 extern ssize_t	cifs_listxattr(struct dentry *, char *, size_t);
 extern int cifs_ioctl (struct inode * inode, struct file * filep,
 		       unsigned int command, unsigned long arg);
-#define CIFS_VERSION   "1.34"
+#define CIFS_VERSION   "1.35"
 #endif				/* _CIFSFS_H */
Index: fs/cifs/file.c
===================================================================
--- c4f9e1d25e876e5b8fb302292c21b22edd6cf1dd/fs/cifs/file.c  (mode:100644)
+++ uncommitted/fs/cifs/file.c  (mode:100644)
@@ -1352,6 +1352,8 @@
 				      GFP_KERNEL)) {
 			page_cache_release(page);
 			cFYI(1, ("Add page cache failed"));
+			data += PAGE_CACHE_SIZE;
+			bytes_read -= PAGE_CACHE_SIZE;
 			continue;
 		}
 
Index: fs/cifs/inode.c
===================================================================
--- c4f9e1d25e876e5b8fb302292c21b22edd6cf1dd/fs/cifs/inode.c  (mode:100644)
+++ uncommitted/fs/cifs/inode.c  (mode:100644)
@@ -82,12 +82,12 @@
 		/* get new inode */
 		if (*pinode == NULL) {
 			*pinode = new_inode(sb);
-			if(*pinode == NULL) 
+			if (*pinode == NULL) 
 				return -ENOMEM;
 			/* Is an i_ino of zero legal? */
 			/* Are there sanity checks we can use to ensure that
 			   the server is really filling in that field? */
-			if(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_SERVER_INUM) {
+			if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_SERVER_INUM) {
 				(*pinode)->i_ino =
 					(unsigned long)findData.UniqueId;
 			} /* note ino incremented to unique num in new_inode */
@@ -134,7 +134,7 @@
 		inode->i_gid = le64_to_cpu(findData.Gid);
 		inode->i_nlink = le64_to_cpu(findData.Nlinks);
 
-		if(is_size_safe_to_change(cifsInfo)) {
+		if (is_size_safe_to_change(cifsInfo)) {
 		/* can not safely change the file size here if the
 		   client is writing to it due to potential races */
 
@@ -162,7 +162,7 @@
 		if (S_ISREG(inode->i_mode)) {
 			cFYI(1, (" File inode "));
 			inode->i_op = &cifs_file_inode_ops;
-			if(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_DIRECT_IO)
+			if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_DIRECT_IO)
 				inode->i_fop = &cifs_file_direct_ops;
 			else
 				inode->i_fop = &cifs_file_ops;
@@ -198,17 +198,17 @@
 	pTcon = cifs_sb->tcon;
 	cFYI(1,("Getting info on %s ", search_path));
 
-	if((pfindData == NULL) && (*pinode != NULL)) {
-		if(CIFS_I(*pinode)->clientCanCacheRead) {
+	if ((pfindData == NULL) && (*pinode != NULL)) {
+		if (CIFS_I(*pinode)->clientCanCacheRead) {
 			cFYI(1,("No need to revalidate cached inode sizes"));
 			return rc;
 		}
 	}
 
 	/* if file info not passed in then get it from server */
-	if(pfindData == NULL) {
+	if (pfindData == NULL) {
 		buf = kmalloc(sizeof(FILE_ALL_INFO), GFP_KERNEL);
-		if(buf == NULL)
+		if (buf == NULL)
 			return -ENOMEM;
 		pfindData = (FILE_ALL_INFO *)buf;
 		/* could do find first instead but this returns more info */
@@ -268,7 +268,7 @@
 			   IndexNumber field is not guaranteed unique? */
 
 #ifdef CONFIG_CIFS_EXPERIMENTAL		
-			if(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_SERVER_INUM){
+			if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_SERVER_INUM){
 				int rc1 = 0;
 				__u64 inode_num;
 
@@ -277,7 +277,7 @@
 					cifs_sb->local_nls,
 					cifs_sb->mnt_cifs_flags &
 						CIFS_MOUNT_MAP_SPECIAL_CHR);
-				if(rc1) {
+				if (rc1) {
 					cFYI(1,("GetSrvInodeNum rc %d", rc1));
 					/* BB EOPNOSUPP disable SERVER_INUM? */
 				} else /* do we need cast or hash to ino? */
@@ -355,7 +355,7 @@
 		if (S_ISREG(inode->i_mode)) {
 			cFYI(1, (" File inode "));
 			inode->i_op = &cifs_file_inode_ops;
-			if(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_DIRECT_IO)
+			if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_DIRECT_IO)
 				inode->i_fop = &cifs_file_direct_ops;
 			else
 				inode->i_fop = &cifs_file_ops;
@@ -422,7 +422,7 @@
 			cifs_sb->mnt_cifs_flags & CIFS_MOUNT_MAP_SPECIAL_CHR);
 
 	if (!rc) {
-		if(direntry->d_inode)
+		if (direntry->d_inode)
 			direntry->d_inode->i_nlink--;
 	} else if (rc == -ENOENT) {
 		d_drop(direntry);
@@ -441,7 +441,7 @@
 					      cifs_sb->mnt_cifs_flags & 
 						CIFS_MOUNT_MAP_SPECIAL_CHR);
 			CIFSSMBClose(xid, pTcon, netfid);
-			if(direntry->d_inode)
+			if (direntry->d_inode)
 				direntry->d_inode->i_nlink--;
 		}
 	} else if (rc == -EACCES) {
@@ -496,7 +496,7 @@
 					    cifs_sb->mnt_cifs_flags & 
 						CIFS_MOUNT_MAP_SPECIAL_CHR);
 			if (!rc) {
-				if(direntry->d_inode)
+				if (direntry->d_inode)
 					direntry->d_inode->i_nlink--;
 			} else if (rc == -ETXTBSY) {
 				int oplock = FALSE;
@@ -517,14 +517,14 @@
 						cifs_sb->mnt_cifs_flags &
 						    CIFS_MOUNT_MAP_SPECIAL_CHR);
 					CIFSSMBClose(xid, pTcon, netfid);
-					if(direntry->d_inode)
+					if (direntry->d_inode)
 			                        direntry->d_inode->i_nlink--;
 				}
 			/* BB if rc = -ETXTBUSY goto the rename logic BB */
 			}
 		}
 	}
-	if(direntry->d_inode) {
+	if (direntry->d_inode) {
 		cifsInode = CIFS_I(direntry->d_inode);
 		cifsInode->time = 0;	/* will force revalidate to get info
 					   when needed */
@@ -582,7 +582,7 @@
 		if (direntry->d_inode)
 			direntry->d_inode->i_nlink = 2;
 		if (cifs_sb->tcon->ses->capabilities & CAP_UNIX)
-			if(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_SET_UID) {
+			if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_SET_UID) {
 				CIFSSMBUnixSetPerms(xid, pTcon, full_path,
 						    mode,
 						    (__u64)current->euid,

--=-GNaQjk/V3PDRX1ZOBm0m--

