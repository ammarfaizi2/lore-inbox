Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262476AbVFVB2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262476AbVFVB2R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 21:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262503AbVFVB1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 21:27:44 -0400
Received: from ms-smtp-05.texas.rr.com ([24.93.47.44]:62933 "EHLO
	ms-smtp-05-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S262476AbVFVBZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 21:25:07 -0400
Message-Id: <200506220125.j5M1P1Rh022077@ms-smtp-05-eri0.texas.rr.com>
From: ericvh@gmail.com
Date: Tue, 21 Jun 2005 20:23:48 -0500
To: linux-kernel@vger.kernel.org
Subject: [-mm PATCH] v9fs: Clean-up vfs_inode and setattr functions
Cc: v9fs-developer@lists.sourceforge.net, akpm@osdl.org,
       linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup code in v9fs vfs_inode as suggested by Alexy Dobriyan.
Did some major revamping of the v9fs setattr code to remove unnecessary
allocations and clean up some dead-code.

Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>

---
commit 90d763e77646e85c987fc550d19ff931554aba60
tree 7920ec6da8d53ba6582f99f9430cfc6f56eae3f6
parent da6dde6453bdefc66ae7f162dc4d212af8e2b353
author Eric Van Hensbergen <ericvh@gmail.com> Tue, 21 Jun 2005 20:12:15 -0500
committer Eric Van Hensbergen <ericvh@gmail.com> Tue, 21 Jun 2005 20:12:15 -0500

 fs/9p/error.h     |    2 -
 fs/9p/vfs_inode.c |  130 ++++++++++++++++-------------------------------------
 2 files changed, 40 insertions(+), 92 deletions(-)

diff --git a/fs/9p/error.h b/fs/9p/error.h
--- a/fs/9p/error.h
+++ b/fs/9p/error.h
@@ -139,7 +139,7 @@ static struct errormap errmap[] = {
 	{"illegal mode", EINVAL},
 	{"illegal name", ENAMETOOLONG},
 	{"not a directory", ENOTDIR},
-	{"not a member of proposed group", EINVAL},
+	{"not a member of proposed group", EPERM},
 	{"not owner", EACCES},
 	{"only owner can change group in wstat", EACCES},
 	{"read only file system", EROFS},
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -1,7 +1,7 @@
 /*
  *  linux/fs/9p/vfs_inode.c
  *
- * This file contians vfs inode ops for the 9P2000 protocol.
+ * This file contains vfs inode ops for the 9P2000 protocol.
  *
  *  Copyright (C) 2004 by Eric Van Hensbergen <ericvh@gmail.com>
  *  Copyright (C) 2002 by Ron Minnich <rminnich@lanl.gov>
@@ -54,7 +54,7 @@ static struct inode_operations v9fs_syml
  *
  */
 
-static inline int unixmode2p9mode(struct v9fs_session_info *v9ses, int mode)
+static int unixmode2p9mode(struct v9fs_session_info *v9ses, int mode)
 {
 	int res;
 	res = mode & 0777;
@@ -92,7 +92,7 @@ static inline int unixmode2p9mode(struct
  *
  */
 
-static inline int p9mode2unixmode(struct v9fs_session_info *v9ses, int mode)
+static int p9mode2unixmode(struct v9fs_session_info *v9ses, int mode)
 {
 	int res;
 
@@ -132,7 +132,7 @@ static inline int p9mode2unixmode(struct
  *
  */
 
-static inline void
+static void
 v9fs_blank_mistat(struct v9fs_session_info *v9ses, struct v9fs_stat *mistat)
 {
 	mistat->type = ~0;
@@ -160,7 +160,7 @@ v9fs_blank_mistat(struct v9fs_session_in
 /**
  * v9fs_mistat2unix - convert mistat to unix stat
  * @mistat: Plan 9 metadata (mistat) structure
- * @stat: unix metadata (stat) structure to populate
+ * @buf: unix metadata (stat) structure to populate
  * @sb: superblock
  *
  */
@@ -177,22 +177,11 @@ v9fs_mistat2unix(struct v9fs_stat *mista
 	buf->st_mtime = mistat->mtime;
 	buf->st_ctime = mistat->mtime;
 
-	if (v9ses && v9ses->extended) {
-		/* TODO: string to uid mapping via user-space daemon */
-		buf->st_uid = mistat->n_uid;
-		buf->st_gid = mistat->n_gid;
-
-		sscanf(mistat->uid, "%x", (unsigned int *)&buf->st_uid);
-		sscanf(mistat->gid, "%x", (unsigned int *)&buf->st_gid);
-	} else {
-		buf->st_uid = v9ses->uid;
-		buf->st_gid = v9ses->gid;
-	}
-
 	buf->st_uid = (unsigned short)-1;
 	buf->st_gid = (unsigned short)-1;
 
 	if (v9ses && v9ses->extended) {
+		/* TODO: string to uid mapping via user-space daemon */
 		if (mistat->n_uid != -1)
 			sscanf(mistat->uid, "%x", (unsigned int *)&buf->st_uid);
 
@@ -291,7 +280,7 @@ struct inode *v9fs_get_inode(struct supe
  * @dir: directory inode file is being created in
  * @file_dentry: dentry file is being created in
  * @perm: permissions file is being created with
- * @open_mode: resulting open mode for file ???
+ * @open_mode: resulting open mode for file
  *
  */
 
@@ -435,9 +424,9 @@ v9fs_create(struct inode *dir,
 
 /**
  * v9fs_remove - helper function to remove files and directories
- * @inode: directory inode that is being deleted
- * @dentry:  dentry that is being deleted
- * @rmdir: where we are a file or a directory
+ * @dir: directory inode that is being deleted
+ * @file:  dentry that is being deleted
+ * @rmdir: removing a directory
  *
  */
 
@@ -528,7 +517,7 @@ v9fs_vfs_create(struct inode *inode, str
 
 /**
  * v9fs_vfs_mkdir - VFS mkdir hook to create a directory
- * @i:  inode that is being unlinked
+ * @inode:  inode that is being unlinked
  * @dentry: dentry that is being unlinked
  * @mode: mode for new directory
  *
@@ -655,7 +644,7 @@ static struct dentry *v9fs_vfs_lookup(st
 /**
  * v9fs_vfs_unlink - VFS unlink hook to delete an inode
  * @i:  inode that is being unlinked
- * @dentry: dentry that is being unlinked
+ * @d: dentry that is being unlinked
  *
  */
 
@@ -667,7 +656,7 @@ static int v9fs_vfs_unlink(struct inode 
 /**
  * v9fs_vfs_rmdir - VFS unlink hook to delete a directory
  * @i:  inode that is being unlinked
- * @dentry: dentry that is being unlinked
+ * @d: dentry that is being unlinked
  *
  */
 
@@ -705,6 +694,9 @@ v9fs_vfs_rename(struct inode *old_dir, s
 
 	dprintk(DEBUG_VFS, "\n");
 
+	if(!mistat) 
+		return -ENOMEM;
+
 	if ((!oldfid) || (!olddirfid) || (!newdirfid)) {
 		dprintk(DEBUG_ERROR, "problem with arguments\n");
 		return -EBADF;
@@ -802,20 +794,21 @@ static int v9fs_vfs_setattr(struct dentr
 {
 	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(dentry->d_inode);
 	struct v9fs_fid *fid = v9fs_fid_lookup(dentry, FID_OP);
-	struct v9fs_stat *mistat = kmalloc(v9ses->maxdata, GFP_KERNEL);
 	struct v9fs_fcall *fcall = NULL;
+	struct v9fs_stat *mistat = kmalloc(v9ses->maxdata, GFP_KERNEL);
 	int res = -EPERM;
 
 	dprintk(DEBUG_VFS, "\n");
+
+	if (!mistat)
+		return -ENOMEM;
+
 	if (!fid) {
 		dprintk(DEBUG_ERROR,
 			"Couldn't find fid associated with dentry\n");
 		return -EBADF;
 	}
 
-	if (!mistat)
-		return -ENOMEM;
-
 	v9fs_blank_mistat(v9ses, mistat);
 	if (iattr->ia_valid & ATTR_MODE)
 		mistat->mode = unixmode2p9mode(v9ses, iattr->ia_mode);
@@ -830,72 +823,19 @@ static int v9fs_vfs_setattr(struct dentr
 		mistat->length = iattr->ia_size;
 
 	if (v9ses->extended) {
-		char *uid = kmalloc(strlen(mistat->uid), GFP_KERNEL);
-		char *gid = kmalloc(strlen(mistat->gid), GFP_KERNEL);
-		char *muid = kmalloc(strlen(mistat->muid), GFP_KERNEL);
-		char *name = kmalloc(strlen(mistat->name), GFP_KERNEL);
-		char *extension = kmalloc(strlen(mistat->extension),
-					  GFP_KERNEL);
-
-		if ((!uid) || (!gid) || (!muid) || (!name) || (!extension)) {
-			kfree(uid);
-			kfree(gid);
-			kfree(muid);
-			kfree(name);
-			kfree(extension);
-
-			return -ENOMEM;
-		}
-
-		strcpy(uid, mistat->uid);
-		strcpy(gid, mistat->gid);
-		strcpy(muid, mistat->muid);
-		strcpy(name, mistat->name);
-		strcpy(extension, mistat->extension);
+		char *ptr = mistat->data+1;
 
 		if (iattr->ia_valid & ATTR_UID) {
-			if (strlen(uid) != 8) {
-				dprintk(DEBUG_ERROR, "uid strlen is %u not 8\n",
-					(unsigned int)strlen(uid));
-				sprintf(uid, "%08x", iattr->ia_uid);
-			} else {
-				kfree(uid);
-				uid = kmalloc(9, GFP_KERNEL);
-			}
-
-			sprintf(uid, "%08x", iattr->ia_uid);
+			mistat->uid = ptr;
+			ptr += 1+sprintf(ptr, "%08x", iattr->ia_uid);
 			mistat->n_uid = iattr->ia_uid;
 		}
 
 		if (iattr->ia_valid & ATTR_GID) {
-			if (strlen(gid) != 8)
-				dprintk(DEBUG_ERROR, "gid strlen is %u not 8\n",
-					(unsigned int)strlen(gid));
-			else {
-				kfree(gid);
-				gid = kmalloc(9, GFP_KERNEL);
-			}
-
-			sprintf(gid, "%08x", iattr->ia_gid);
+			mistat->gid = ptr;
+			ptr += 1+sprintf(ptr, "%08x", iattr->ia_gid);
 			mistat->n_gid = iattr->ia_gid;
 		}
-
-		mistat->uid = mistat->data;
-		strcpy(mistat->uid, uid);
-		mistat->gid = mistat->data + strlen(uid) + 1;
-		strcpy(mistat->gid, gid);
-		mistat->muid = mistat->gid + strlen(gid) + 1;
-		strcpy(mistat->muid, muid);
-		mistat->name = mistat->muid + strlen(muid) + 1;
-		strcpy(mistat->name, name);
-		mistat->extension = mistat->name + strlen(name) + 1;
-		strcpy(mistat->extension, extension);
-
-		kfree(uid);
-		kfree(gid);
-		kfree(muid);
-		kfree(name);
-		kfree(extension);
 	}
 
 	res = v9fs_t_wstat(v9ses, fid->fid, mistat, &fcall);
@@ -1023,6 +963,9 @@ v9fs_vfs_symlink(struct inode *dir, stru
 	dprintk(DEBUG_VFS, " %lu,%s,%s\n", dir->i_ino, dentry->d_name.name,
 		symname);
 
+	if(!mistat)
+		return -ENOMEM;
+
 	if ((!dentry) || (!sb) || (!v9ses)) {
 		dprintk(DEBUG_ERROR, "problem with arguments\n");
 		return -EBADF;
@@ -1073,7 +1016,7 @@ v9fs_vfs_symlink(struct inode *dir, stru
 /**
  * v9fs_readlink - read a symlink's location (internal version)
  * @dentry: dentry for symlink
- * @buf: buffer to load symlink location into
+ * @buffer: buffer to load symlink location into
  * @buflen: length of buffer
  *
  */
@@ -1212,7 +1155,7 @@ static void v9fs_vfs_put_link(struct den
  * v9fs_vfs_link - create a hardlink
  * @old_dentry: dentry for file to link to
  * @dir: inode destination for new link
- * @new_dentry: dentry for link
+ * @dentry: dentry for link
  *
  */
 
@@ -1236,6 +1179,9 @@ v9fs_vfs_link(struct dentry *old_dentry,
 	dprintk(DEBUG_VFS, " %lu,%s,%s\n", dir->i_ino, dentry->d_name.name,
 		old_dentry->d_name.name);
 
+	if (!mistat)
+		return -ENOMEM;
+
 	if ((!dentry) || (!sb) || (!v9ses) || (!oldfid)) {
 		dprintk(DEBUG_ERROR, "problem with arguments\n");
 		retval = -EBADF;
@@ -1317,6 +1263,9 @@ v9fs_vfs_mknod(struct inode *dir, struct
 	dprintk(DEBUG_VFS, " %lu,%s mode: %x MAJOR: %u MINOR: %u\n", dir->i_ino,
 		dentry->d_name.name, mode, MAJOR(rdev), MINOR(rdev));
 
+	if(!mistat)
+		return -ENOMEM;
+
 	if (!new_valid_dev(rdev)) {
 		retval = -EINVAL;
 		goto FreeMem;
@@ -1351,7 +1300,8 @@ v9fs_vfs_mknod(struct inode *dir, struct
 		sprintf(symname, "b %u %u", MAJOR(rdev), MINOR(rdev));
 	else if (S_ISCHR(mode))
 		sprintf(symname, "c %u %u", MAJOR(rdev), MINOR(rdev));
-	else if (S_ISFIFO(mode)) ;	/* DO NOTHING */
+	else if (S_ISFIFO(mode)) 
+		;	/* DO NOTHING */
 	else {
 		retval = -EINVAL;
 		goto FreeMem;
@@ -1368,8 +1318,6 @@ v9fs_vfs_mknod(struct inode *dir, struct
 				FCALL_ERROR(fcall));
 			goto FreeMem;
 		}
-
-		kfree(fcall);
 	}
 
 	/* need to update dcache so we show up */
