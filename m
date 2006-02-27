Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751252AbWB0EMD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbWB0EMD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 23:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbWB0EL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 23:11:58 -0500
Received: from cpe-70-112-167-32.austin.res.rr.com ([70.112.167.32]:54668 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751252AbWB0EL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 23:11:57 -0500
To: akpm@osdl.org
Subject: [PATCH 1/3] v9fs: fix atomic create open
Cc: linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
       ericvh@gmail.com
Message-Id: <20060227041208.13E735A8075@localhost.localdomain>
Date: Sun, 26 Feb 2006 22:12:08 -0600 (CST)
From: ericvh@gmail.com (Eric Van Hensbergen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH] v9fs: fix atomic create+open
From: Latchesar Ionkov <lucho@ionkov.net>
Date: 1140609929 -0500

In order to assure atomic create+open v9fs stores the open fid produced by
v9fs_vfs_create in the dentry, from where v9fs_file_open retrieves it and
associates it with the open file.

This patch modifies v9fs to use nameidata.intent.open values to do the
atomic create+open.

Signed-off-by: Latchesar Ionkov <lucho@ionkov.net>

Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>

---

 fs/9p/fid.c       |   73 ++------
 fs/9p/fid.h       |    5 -
 fs/9p/v9fs_vfs.h  |    1 
 fs/9p/vfs_file.c  |  106 ++++--------
 fs/9p/vfs_inode.c |  480 +++++++++++++++++++++++++++++++++++------------------
 fs/9p/vfs_super.c |   12 +
 6 files changed, 380 insertions(+), 297 deletions(-)

4265bae0dc569ede5e195773feeb882ef1cdac79
diff --git a/fs/9p/fid.c b/fs/9p/fid.c
--- a/fs/9p/fid.c
+++ b/fs/9p/fid.c
@@ -40,7 +40,7 @@
  *
  */
 
-static int v9fs_fid_insert(struct v9fs_fid *fid, struct dentry *dentry)
+int v9fs_fid_insert(struct v9fs_fid *fid, struct dentry *dentry)
 {
 	struct list_head *fid_list = (struct list_head *)dentry->d_fsdata;
 	dprintk(DEBUG_9P, "fid %d (%p) dentry %s (%p)\n", fid->fid, fid,
@@ -68,14 +68,11 @@ static int v9fs_fid_insert(struct v9fs_f
  *
  */
 
-struct v9fs_fid *v9fs_fid_create(struct dentry *dentry,
-	struct v9fs_session_info *v9ses, int fid, int create)
+struct v9fs_fid *v9fs_fid_create(struct v9fs_session_info *v9ses, int fid)
 {
 	struct v9fs_fid *new;
 
-	dprintk(DEBUG_9P, "fid create dentry %p, fid %d, create %d\n",
-		dentry, fid, create);
-
+	dprintk(DEBUG_9P, "fid create fid %d\n", fid);
 	new = kmalloc(sizeof(struct v9fs_fid), GFP_KERNEL);
 	if (new == NULL) {
 		dprintk(DEBUG_ERROR, "Out of Memory\n");
@@ -85,19 +82,13 @@ struct v9fs_fid *v9fs_fid_create(struct 
 	new->fid = fid;
 	new->v9ses = v9ses;
 	new->fidopen = 0;
-	new->fidcreate = create;
 	new->fidclunked = 0;
 	new->iounit = 0;
 	new->rdir_pos = 0;
 	new->rdir_fcall = NULL;
+	INIT_LIST_HEAD(&new->list);
 
-	if (v9fs_fid_insert(new, dentry) == 0)
 		return new;
-	else {
-		dprintk(DEBUG_ERROR, "Problems inserting to dentry\n");
-		kfree(new);
-		return NULL;
-	}
 }
 
 /**
@@ -119,7 +110,7 @@ void v9fs_fid_destroy(struct v9fs_fid *f
 static struct v9fs_fid *v9fs_fid_walk_up(struct dentry *dentry)
 {
 	int fidnum, cfidnum, err;
-	struct v9fs_fid *cfid;
+	struct v9fs_fid *cfid, *fid;
 	struct dentry *cde;
 	struct v9fs_session_info *v9ses;
 
@@ -158,7 +149,16 @@ static struct v9fs_fid *v9fs_fid_walk_up
 		cde = cde->d_parent;
 	}
 
-	return v9fs_fid_create(dentry, v9ses, fidnum, 0);
+	fid = v9fs_fid_create(v9ses, fidnum);
+	if (fid) {
+		err = v9fs_fid_insert(fid, dentry);
+		if (err < 0) {
+			kfree(fid);
+			goto clunk_fid;
+		}
+	}
+
+	return fid;
 
 clunk_fid:
 	v9fs_t_clunk(v9ses, fidnum);
@@ -179,29 +179,12 @@ clunk_fid:
 struct v9fs_fid *v9fs_fid_lookup(struct dentry *dentry)
 {
 	struct list_head *fid_list = (struct list_head *)dentry->d_fsdata;
-	struct v9fs_fid *current_fid = NULL;
-	struct v9fs_fid *temp = NULL;
 	struct v9fs_fid *return_fid = NULL;
 
 	dprintk(DEBUG_9P, " dentry: %s (%p)\n", dentry->d_iname, dentry);
 
-	if (fid_list) {
-		list_for_each_entry_safe(current_fid, temp, fid_list, list) {
-			if (!current_fid->fidcreate) {
-				return_fid = current_fid;
-				break;
-			}
-		}
-
-		if (!return_fid)
-			return_fid = current_fid;
-	}
-
-	/* we are at the root but didn't match */
-	if ((!return_fid) && (dentry->d_parent == dentry)) {
-		/* TODO: clone attach with new uid */
-		return_fid = current_fid;
-	}
+	if (fid_list)
+		return_fid = list_entry(fid_list->next, struct v9fs_fid, list);
 
 	if (!return_fid) {
 		struct dentry *par = current->fs->pwd->d_parent;
@@ -228,25 +211,3 @@ struct v9fs_fid *v9fs_fid_lookup(struct 
 
 	return return_fid;
 }
-
-struct v9fs_fid *v9fs_fid_get_created(struct dentry *dentry)
-{
-	struct list_head *fid_list;
-	struct v9fs_fid *fid, *ftmp, *ret;
-
-	dprintk(DEBUG_9P, " dentry: %s (%p)\n", dentry->d_iname, dentry);
-	fid_list = (struct list_head *)dentry->d_fsdata;
-	ret = NULL;
-	if (fid_list) {
-		list_for_each_entry_safe(fid, ftmp, fid_list, list) {
-			if (fid->fidcreate && fid->pid == current->pid) {
-				list_del(&fid->list);
-				ret = fid;
-				break;
-			}
-		}
-	}
-
-	dprintk(DEBUG_9P, "return %p\n", ret);
-	return ret;
-}
diff --git a/fs/9p/fid.h b/fs/9p/fid.h
--- a/fs/9p/fid.h
+++ b/fs/9p/fid.h
@@ -33,7 +33,6 @@ struct v9fs_fid {
 
 	u32 fid;
 	unsigned char fidopen;	  /* set when fid is opened */
-	unsigned char fidcreate;  /* set when fid was just created */
 	unsigned char fidclunked; /* set when fid has already been clunked */
 
 	struct v9fs_qid qid;
@@ -56,5 +55,5 @@ struct v9fs_fid {
 struct v9fs_fid *v9fs_fid_lookup(struct dentry *dentry);
 struct v9fs_fid *v9fs_fid_get_created(struct dentry *);
 void v9fs_fid_destroy(struct v9fs_fid *fid);
-struct v9fs_fid *v9fs_fid_create(struct dentry *,
-	struct v9fs_session_info *v9ses, int fid, int create);
+struct v9fs_fid *v9fs_fid_create(struct v9fs_session_info *, int fid);
+int v9fs_fid_insert(struct v9fs_fid *fid, struct dentry *dentry);
diff --git a/fs/9p/v9fs_vfs.h b/fs/9p/v9fs_vfs.h
--- a/fs/9p/v9fs_vfs.h
+++ b/fs/9p/v9fs_vfs.h
@@ -51,3 +51,4 @@ int v9fs_dir_release(struct inode *inode
 int v9fs_file_open(struct inode *inode, struct file *file);
 void v9fs_inode2stat(struct inode *inode, struct v9fs_stat *stat);
 void v9fs_dentry_release(struct dentry *);
+int v9fs_uflags2omode(int uflags);
diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -53,94 +53,70 @@
 int v9fs_file_open(struct inode *inode, struct file *file)
 {
 	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(inode);
-	struct v9fs_fid *v9fid, *fid;
+	struct v9fs_fid *vfid;
 	struct v9fs_fcall *fcall = NULL;
-	int open_mode = 0;
-	unsigned int iounit = 0;
-	int newfid = -1;
-	long result = -1;
+	int omode;
+	int fid = V9FS_NOFID;
+	int err;
 
 	dprintk(DEBUG_VFS, "inode: %p file: %p \n", inode, file);
 
-	v9fid = v9fs_fid_get_created(file->f_dentry);
-	if (!v9fid)
-		v9fid = v9fs_fid_lookup(file->f_dentry);
-
-	if (!v9fid) {
+	vfid = v9fs_fid_lookup(file->f_dentry);
+	if (!vfid) {
 		dprintk(DEBUG_ERROR, "Couldn't resolve fid from dentry\n");
 		return -EBADF;
 	}
 
-	if (!v9fid->fidcreate) {
-		fid = kmalloc(sizeof(struct v9fs_fid), GFP_KERNEL);
-		if (fid == NULL) {
-			dprintk(DEBUG_ERROR, "Out of Memory\n");
-			return -ENOMEM;
-		}
-
-		fid->fidopen = 0;
-		fid->fidcreate = 0;
-		fid->fidclunked = 0;
-		fid->iounit = 0;
-		fid->v9ses = v9ses;
-
-		newfid = v9fs_get_idpool(&v9ses->fidpool);
-		if (newfid < 0) {
+	fid = v9fs_get_idpool(&v9ses->fidpool);
+	if (fid < 0) {
 			eprintk(KERN_WARNING, "newfid fails!\n");
 			return -ENOSPC;
 		}
 
-		result =
-		    v9fs_t_walk(v9ses, v9fid->fid, newfid, NULL, NULL);
-
-		if (result < 0) {
-			v9fs_put_idpool(newfid, &v9ses->fidpool);
+	err = v9fs_t_walk(v9ses, vfid->fid, fid, NULL, NULL);
+	if (err < 0) {
 			dprintk(DEBUG_ERROR, "rewalk didn't work\n");
-			return -EBADF;
+		goto put_fid;
+	}
+
+	vfid = kmalloc(sizeof(struct v9fs_fid), GFP_KERNEL);
+	if (vfid == NULL) {
+		dprintk(DEBUG_ERROR, "out of memory\n");
+		goto clunk_fid;
 		}
 
-		fid->fid = newfid;
-		v9fid = fid;
 		/* TODO: do special things for O_EXCL, O_NOFOLLOW, O_SYNC */
 		/* translate open mode appropriately */
-		open_mode = file->f_flags & 0x3;
+	omode = v9fs_uflags2omode(file->f_flags);
+	err = v9fs_t_open(v9ses, fid, omode, &fcall);
+	if (err < 0) {
+		PRINT_FCALL_ERROR("open failed", fcall);
+		goto destroy_vfid;
+	}
 
-		if (file->f_flags & O_EXCL)
-			open_mode |= V9FS_OEXCL;
+	file->private_data = vfid;
+	vfid->fid = fid;
+	vfid->fidopen = 1;
+	vfid->fidclunked = 0;
+	vfid->iounit = fcall->params.ropen.iounit;
+	vfid->rdir_pos = 0;
+	vfid->rdir_fcall = NULL;
+	vfid->filp = file;
+	kfree(fcall);
 
-		if (v9ses->extended) {
-			if (file->f_flags & O_TRUNC)
-				open_mode |= V9FS_OTRUNC;
+	return 0;
 
-			if (file->f_flags & O_APPEND)
-				open_mode |= V9FS_OAPPEND;
-		}
+destroy_vfid:
+	v9fs_fid_destroy(vfid);
 
-		result = v9fs_t_open(v9ses, newfid, open_mode, &fcall);
-		if (result < 0) {
-			PRINT_FCALL_ERROR("open failed", fcall);
-			kfree(fcall);
-			return result;
-		}
+clunk_fid:
+	v9fs_t_clunk(v9ses, fid);
 
-		iounit = fcall->params.ropen.iounit;
+put_fid:
+	v9fs_put_idpool(fid, &v9ses->fidpool);
 		kfree(fcall);
-	} else {
-		/* create case */
-		newfid = v9fid->fid;
-		iounit = v9fid->iounit;
-		v9fid->fidcreate = 0;
-	}
-
-	file->private_data = v9fid;
-
-	v9fid->rdir_pos = 0;
-	v9fid->rdir_fcall = NULL;
-	v9fid->fidopen = 1;
-	v9fid->filp = file;
-	v9fid->iounit = iounit;
 
-	return 0;
+	return err;
 }
 
 /**
@@ -289,9 +265,7 @@ v9fs_file_write(struct file *filp, const
 		total += result;
 	} while (count);
 
-	if(inode->i_mapping->nrpages)
 		invalidate_inode_pages2(inode->i_mapping);
-
 	return total;
 }
 
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -125,6 +125,38 @@ static int p9mode2unixmode(struct v9fs_s
 	return res;
 }
 
+int v9fs_uflags2omode(int uflags)
+{
+	int ret;
+
+	ret = 0;
+	switch (uflags&3) {
+	default:
+	case O_RDONLY:
+		ret = V9FS_OREAD;
+		break;
+
+	case O_WRONLY:
+		ret = V9FS_OWRITE;
+		break;
+
+	case O_RDWR:
+		ret = V9FS_ORDWR;
+		break;
+	}
+
+	if (uflags & O_EXCL)
+		ret |= V9FS_OEXCL;
+
+	if (uflags & O_TRUNC)
+		ret |= V9FS_OTRUNC;
+
+	if (uflags & O_APPEND)
+		ret |= V9FS_OAPPEND;
+
+	return ret;
+}
+
 /**
  * v9fs_blank_wstat - helper function to setup a 9P stat structure
  * @v9ses: 9P session info (for determining extended mode)
@@ -163,7 +195,7 @@ v9fs_blank_wstat(struct v9fs_wstat *wsta
 
 struct inode *v9fs_get_inode(struct super_block *sb, int mode)
 {
-	struct inode *inode = NULL;
+	struct inode *inode;
 	struct v9fs_session_info *v9ses = sb->s_fs_info;
 
 	dprintk(DEBUG_VFS, "super block: %p mode: %o\n", sb, mode);
@@ -222,171 +254,135 @@ struct inode *v9fs_get_inode(struct supe
 	return inode;
 }
 
-/**
- * v9fs_create - helper function to create files and directories
- * @dir: directory inode file is being created in
- * @file_dentry: dentry file is being created in
- * @perm: permissions file is being created with
- * @open_mode: resulting open mode for file
- *
- */
-
 static int
-v9fs_create(struct inode *dir,
-	    struct dentry *file_dentry,
-	    unsigned int perm, unsigned int open_mode)
-{
-	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(dir);
-	struct super_block *sb = dir->i_sb;
-	struct v9fs_fid *dirfid =
-	    v9fs_fid_lookup(file_dentry->d_parent);
-	struct v9fs_fid *fid = NULL;
-	struct inode *file_inode = NULL;
-	struct v9fs_fcall *fcall = NULL;
-	struct v9fs_qid qid;
-	int dirfidnum = -1;
-	long newfid = -1;
-	int result = 0;
-	unsigned int iounit = 0;
-	int wfidno = -1;
+v9fs_create(struct v9fs_session_info *v9ses, u32 pfid, char *name, 
+	u32 perm, u8 mode, u32 *fidp, struct v9fs_qid *qid, u32 *iounit)
+{
+	u32 fid;
 	int err;
+	struct v9fs_fcall *fcall;
 
-	perm = unixmode2p9mode(v9ses, perm);
-
-	dprintk(DEBUG_VFS, "dir: %p dentry: %p perm: %o mode: %o\n", dir,
-		file_dentry, perm, open_mode);
-
-	if (!dirfid)
-		return -EBADF;
-
-	dirfidnum = dirfid->fid;
-	if (dirfidnum < 0) {
-		dprintk(DEBUG_ERROR, "No fid for the directory #%lu\n",
-			dir->i_ino);
-		return -EBADF;
-	}
-
-	if (file_dentry->d_inode) {
-		dprintk(DEBUG_ERROR,
-			"Odd. There is an inode for dir %lu, name :%s:\n",
-			dir->i_ino, file_dentry->d_name.name);
-		return -EEXIST;
-	}
-
-	newfid = v9fs_get_idpool(&v9ses->fidpool);
-	if (newfid < 0) {
+	fid = v9fs_get_idpool(&v9ses->fidpool);
+	if (fid < 0) {
 		eprintk(KERN_WARNING, "no free fids available\n");
-		return -ENOSPC;
+		err = -ENOSPC;
+		goto error;
 	}
 
-	result = v9fs_t_walk(v9ses, dirfidnum, newfid, NULL, &fcall);
-	if (result < 0) {
+	err = v9fs_t_walk(v9ses, pfid, fid, NULL, &fcall);
+	if (err < 0) {
 		PRINT_FCALL_ERROR("clone error", fcall);
-		v9fs_put_idpool(newfid, &v9ses->fidpool);
-		newfid = -1;
-		goto CleanUpFid;
+		goto error;
 	}
-
 	kfree(fcall);
-	fcall = NULL;
 
-	result = v9fs_t_create(v9ses, newfid, (char *)file_dentry->d_name.name,
-			       perm, open_mode, &fcall);
-	if (result < 0) {
+	err = v9fs_t_create(v9ses, fid, name, perm, mode, &fcall);
+	if (err < 0) {
 		PRINT_FCALL_ERROR("create fails", fcall);
-		goto CleanUpFid;
+		goto error;
 	}
 
-	iounit = fcall->params.rcreate.iounit;
-	qid = fcall->params.rcreate.qid;
+	if (iounit)
+		*iounit = fcall->params.rcreate.iounit;
+
+	if (qid)
+		*qid = fcall->params.rcreate.qid;
+
+	if (fidp)
+		*fidp = fid;
+
 	kfree(fcall);
-	fcall = NULL;
+	return 0;
 
-	if (!(perm&V9FS_DMDIR)) {
-		fid = v9fs_fid_create(file_dentry, v9ses, newfid, 1);
-		dprintk(DEBUG_VFS, "fid %p %d\n", fid, fid->fidcreate);
-		if (!fid) {
-			result = -ENOMEM;
-			goto CleanUpFid;
-		}
+error:
+	if (fid >= 0)
+		v9fs_put_idpool(fid, &v9ses->fidpool);
 
-		fid->qid = qid;
-		fid->iounit = iounit;
-	} else {
-		err = v9fs_t_clunk(v9ses, newfid);
-		newfid = -1;
-		if (err < 0)
-			dprintk(DEBUG_ERROR, "clunk for mkdir failed: %d\n", err);
-	}
+	kfree(fcall);
+	return err;
+}
+
+static struct v9fs_fid*
+v9fs_clone_walk(struct v9fs_session_info *v9ses, u32 fid, struct dentry *dentry)
+{
+	int err;
+	u32 nfid;
+	struct v9fs_fid *ret;
+	struct v9fs_fcall *fcall;
 
-	/* walk to the newly created file and put the fid in the dentry */
-	wfidno = v9fs_get_idpool(&v9ses->fidpool);
-	if (wfidno < 0) {
+	nfid = v9fs_get_idpool(&v9ses->fidpool);
+	if (nfid < 0) {
 		eprintk(KERN_WARNING, "no free fids available\n");
-		return -ENOSPC;
+		err = -ENOSPC;
+		goto error;
 	}
 
-	result = v9fs_t_walk(v9ses, dirfidnum, wfidno,
-		(char *) file_dentry->d_name.name, &fcall);
-	if (result < 0) {
-		PRINT_FCALL_ERROR("clone error", fcall);
-		v9fs_put_idpool(wfidno, &v9ses->fidpool);
-		wfidno = -1;
-		goto CleanUpFid;
+	err = v9fs_t_walk(v9ses, fid, nfid, (char *) dentry->d_name.name, 
+		&fcall);
+
+	if (err < 0) {
+		PRINT_FCALL_ERROR("walk error", fcall);
+		v9fs_put_idpool(nfid, &v9ses->fidpool);
+		goto error;
 	}
+
 	kfree(fcall);
 	fcall = NULL;
+	ret = v9fs_fid_create(v9ses, nfid);
+	if (!ret) {
+		err = -ENOMEM;
+		goto clunk_fid;
+	}
 
-	if (!v9fs_fid_create(file_dentry, v9ses, wfidno, 0)) {
-		v9fs_put_idpool(wfidno, &v9ses->fidpool);
-
-		goto CleanUpFid;
+	err = v9fs_fid_insert(ret, dentry);
+	if (err < 0) {
+		v9fs_fid_destroy(ret);
+		goto clunk_fid;
 	}
 
-	if ((perm & V9FS_DMSYMLINK) || (perm & V9FS_DMLINK) ||
-	    (perm & V9FS_DMNAMEDPIPE) || (perm & V9FS_DMSOCKET) ||
-	    (perm & V9FS_DMDEVICE))
-		return 0;
+	return ret;
 
-	result = v9fs_t_stat(v9ses, wfidno, &fcall);
-	if (result < 0) {
-		PRINT_FCALL_ERROR("stat error", fcall);
-		goto CleanUpFid;
-	}
+clunk_fid:
+	v9fs_t_clunk(v9ses, nfid);
 
+error:
+	kfree(fcall);
+	return ERR_PTR(err);
+}
 
-	file_inode = v9fs_get_inode(sb,
-		p9mode2unixmode(v9ses, fcall->params.rstat.stat.mode));
+struct inode *
+v9fs_inode_from_fid(struct v9fs_session_info *v9ses, u32 fid, 
+	struct super_block *sb)
+{
+	int err, umode;
+	struct inode *ret;
+	struct v9fs_fcall *fcall;
 
-	if ((!file_inode) || IS_ERR(file_inode)) {
-		dprintk(DEBUG_ERROR, "create inode failed\n");
-		result = -EBADF;
-		goto CleanUpFid;
+	ret = NULL;
+	err = v9fs_t_stat(v9ses, fid, &fcall);
+	if (err) {
+		PRINT_FCALL_ERROR("stat error", fcall);
+		goto error;
 	}
 
-	v9fs_stat2inode(&fcall->params.rstat.stat, file_inode, sb);
-	kfree(fcall);
-	fcall = NULL;
-	file_dentry->d_op = &v9fs_dentry_operations;
-	d_instantiate(file_dentry, file_inode);
+	umode = p9mode2unixmode(v9ses, fcall->params.rstat.stat.mode);
+	ret = v9fs_get_inode(sb, umode);
+	if (IS_ERR(ret)) {
+		err = PTR_ERR(ret);
+		ret = NULL;
+		goto error;
+	}
 
-	return 0;
+	v9fs_stat2inode(&fcall->params.rstat.stat, ret, sb);
+	kfree(fcall);
+	return ret;
 
-      CleanUpFid:
+error:
 	kfree(fcall);
-	fcall = NULL;
+	if (ret)
+		iput(ret);
 
-	if (newfid >= 0) {
- 		err = v9fs_t_clunk(v9ses, newfid);
- 		if (err < 0)
- 			dprintk(DEBUG_ERROR, "clunk failed: %d\n", err);
-	}
-	if (wfidno >= 0) {
- 		err = v9fs_t_clunk(v9ses, wfidno);
- 		if (err < 0)
- 			dprintk(DEBUG_ERROR, "clunk failed: %d\n", err);
-	}
-	return result;
+	return ERR_PTR(err);
 }
 
 /**
@@ -440,20 +436,97 @@ static int v9fs_remove(struct inode *dir
 	return result;
 }
 
+static int
+v9fs_open_created(struct inode *inode, struct file *file)
+{
+	return 0;
+}
+
 /**
  * v9fs_vfs_create - VFS hook to create files
  * @inode: directory inode that is being deleted
  * @dentry:  dentry that is being deleted
- * @perm: create permissions
+ * @mode: create permissions
  * @nd: path information
  *
  */
 
 static int
-v9fs_vfs_create(struct inode *inode, struct dentry *dentry, int perm,
+v9fs_vfs_create(struct inode *dir, struct dentry *dentry, int mode,
 		struct nameidata *nd)
 {
-	return v9fs_create(inode, dentry, perm, O_RDWR);
+	int err;
+	u32 fid, perm, iounit;
+	int flags;
+	struct v9fs_session_info *v9ses;
+	struct v9fs_fid *dfid, *vfid, *ffid;
+	struct inode *inode;
+	struct v9fs_qid qid;
+	struct file *filp;
+
+	inode = NULL;
+	vfid = NULL;
+	v9ses = v9fs_inode2v9ses(dir);
+	dfid = v9fs_fid_lookup(dentry->d_parent);
+	perm = unixmode2p9mode(v9ses, mode);
+
+	if (nd && nd->flags & LOOKUP_OPEN)
+		flags = nd->intent.open.flags - 1;
+	else
+		flags = O_RDWR;
+
+	err = v9fs_create(v9ses, dfid->fid, (char *) dentry->d_name.name,
+		perm, v9fs_uflags2omode(flags), &fid, &qid, &iounit);
+
+	if (err)
+		goto error;
+
+	vfid = v9fs_clone_walk(v9ses, dfid->fid, dentry);
+	if (IS_ERR(vfid)) {
+		err = PTR_ERR(vfid);
+		vfid = NULL;
+		goto error;
+	}
+
+	inode = v9fs_inode_from_fid(v9ses, vfid->fid, dir->i_sb);
+	if (IS_ERR(inode)) {
+		err = PTR_ERR(inode);
+		inode = NULL;
+		goto error;
+	}
+
+	dentry->d_op = &v9fs_dentry_operations;
+	d_instantiate(dentry, inode);
+
+	if (nd && nd->flags & LOOKUP_OPEN) {
+		ffid = v9fs_fid_create(v9ses, fid);
+		if (!ffid)
+			return -ENOMEM;
+
+		filp = lookup_instantiate_filp(nd, dentry, v9fs_open_created);
+		if (IS_ERR(filp)) {
+			v9fs_fid_destroy(ffid);
+			return PTR_ERR(filp);
+		}
+
+		ffid->rdir_pos = 0;
+		ffid->rdir_fcall = NULL;
+		ffid->fidopen = 1;
+		ffid->iounit = iounit;
+		ffid->filp = filp;
+		filp->private_data = ffid;
+	}
+
+	return 0;
+
+error:
+	if (vfid)
+		v9fs_fid_destroy(vfid);
+
+	if (inode)
+		iput(inode);
+
+	return err;
 }
 
 /**
@@ -464,9 +537,57 @@ v9fs_vfs_create(struct inode *inode, str
  *
  */
 
-static int v9fs_vfs_mkdir(struct inode *inode, struct dentry *dentry, int mode)
+static int v9fs_vfs_mkdir(struct inode *dir, struct dentry *dentry, int mode)
 {
-	return v9fs_create(inode, dentry, mode | S_IFDIR, O_RDONLY);
+	int err;
+	u32 fid, perm;
+	struct v9fs_session_info *v9ses;
+	struct v9fs_fid *dfid, *vfid;
+	struct inode *inode;
+
+	inode = NULL;
+	vfid = NULL;
+	v9ses = v9fs_inode2v9ses(dir);
+	dfid = v9fs_fid_lookup(dentry->d_parent);
+	perm = unixmode2p9mode(v9ses, mode | S_IFDIR);
+
+	err = v9fs_create(v9ses, dfid->fid, (char *) dentry->d_name.name,
+		perm, V9FS_OREAD, &fid, NULL, NULL);
+
+	if (err) {
+		dprintk(DEBUG_ERROR, "create error %d\n", err);
+		goto error;
+	}
+
+	err = v9fs_t_clunk(v9ses, fid);
+	if (err) {
+		dprintk(DEBUG_ERROR, "clunk error %d\n", err);
+		goto error;
+	}
+
+	vfid = v9fs_clone_walk(v9ses, dfid->fid, dentry);
+	if (IS_ERR(vfid)) {
+		err = PTR_ERR(vfid);
+		vfid = NULL;
+		goto error;
+	}
+
+	inode = v9fs_inode_from_fid(v9ses, vfid->fid, dir->i_sb);
+	if (IS_ERR(inode)) {
+		err = PTR_ERR(inode);
+		inode = NULL;
+		goto error;
+	}
+
+	dentry->d_op = &v9fs_dentry_operations;
+	d_instantiate(dentry, inode);
+	return 0;
+
+error:
+	if (vfid)
+		v9fs_fid_destroy(vfid);
+
+	return err;
 }
 
 /**
@@ -516,9 +637,8 @@ static struct dentry *v9fs_vfs_lookup(st
 		return ERR_PTR(-ENOSPC);
 	}
 
-	result =
-	    v9fs_t_walk(v9ses, dirfidnum, newfid, (char *)dentry->d_name.name,
-			NULL);
+	result = v9fs_t_walk(v9ses, dirfidnum, newfid, 
+		(char *)dentry->d_name.name, NULL);
 	if (result < 0) {
 		v9fs_put_idpool(newfid, &v9ses->fidpool);
 		if (result == -ENOENT) {
@@ -551,13 +671,17 @@ static struct dentry *v9fs_vfs_lookup(st
 
 	inode->i_ino = v9fs_qid2ino(&fcall->params.rstat.stat.qid);
 
-	fid = v9fs_fid_create(dentry, v9ses, newfid, 0);
+	fid = v9fs_fid_create(v9ses, newfid);
 	if (fid == NULL) {
 		dprintk(DEBUG_ERROR, "couldn't insert\n");
 		result = -ENOMEM;
 		goto FreeFcall;
 	}
 
+	result = v9fs_fid_insert(fid, dentry);
+	if (result < 0)
+		goto FreeFcall;
+
 	fid->qid = fcall->params.rstat.stat.qid;
 
 	dentry->d_op = &v9fs_dentry_operations;
@@ -886,8 +1010,8 @@ static int v9fs_readlink(struct dentry *
 	}
 
 	/* copy extension buffer into buffer */
-	if (fcall->params.rstat.stat.extension.len+1 < buflen)
-		buflen = fcall->params.rstat.stat.extension.len + 1;
+	if (fcall->params.rstat.stat.extension.len < buflen)
+		buflen = fcall->params.rstat.stat.extension.len;
 
 	memcpy(buffer, fcall->params.rstat.stat.extension.str, buflen - 1);
 	buffer[buflen-1] = 0;
@@ -951,7 +1075,7 @@ static void *v9fs_vfs_follow_link(struct
 	if (!link)
 		link = ERR_PTR(-ENOMEM);
 	else {
-		len = v9fs_readlink(dentry, link, PATH_MAX);
+		len = v9fs_readlink(dentry, link, strlen(link));
 
 		if (len < 0) {
 			__putname(link);
@@ -983,53 +1107,75 @@ static void v9fs_vfs_put_link(struct den
 static int v9fs_vfs_mkspecial(struct inode *dir, struct dentry *dentry,
 	int mode, const char *extension)
 {
-	int err, retval;
+	int err;
+	u32 fid, perm;
 	struct v9fs_session_info *v9ses;
+	struct v9fs_fid *dfid, *vfid;
+	struct inode *inode;
 	struct v9fs_fcall *fcall;
-	struct v9fs_fid *fid;
 	struct v9fs_wstat wstat;
 
-	v9ses = v9fs_inode2v9ses(dir);
-	retval = -EPERM;
 	fcall = NULL;
+	inode = NULL;
+	vfid = NULL;
+	v9ses = v9fs_inode2v9ses(dir);
+	dfid = v9fs_fid_lookup(dentry->d_parent);
+	perm = unixmode2p9mode(v9ses, mode);
 
 	if (!v9ses->extended) {
 		dprintk(DEBUG_ERROR, "not extended\n");
-		goto free_mem;
+		return -EPERM;
 	}
 
-	/* issue a create */
-	retval = v9fs_create(dir, dentry, mode, 0);
-	if (retval != 0)
-		goto free_mem;
+	err = v9fs_create(v9ses, dfid->fid, (char *) dentry->d_name.name,
+		perm, V9FS_OREAD, &fid, NULL, NULL);
 
-	fid = v9fs_fid_get_created(dentry);
-	if (!fid) {
-		dprintk(DEBUG_ERROR, "couldn't resolve fid from dentry\n");
-		goto free_mem;
+	if (err)
+		goto error;
+
+	err = v9fs_t_clunk(v9ses, fid);
+	if (err)
+		goto error;
+
+	vfid = v9fs_clone_walk(v9ses, dfid->fid, dentry);
+	if (IS_ERR(vfid)) {
+		err = PTR_ERR(vfid);
+		vfid = NULL;
+		goto error;
+	}
+
+	inode = v9fs_inode_from_fid(v9ses, vfid->fid, dir->i_sb);
+	if (IS_ERR(inode)) {
+		err = PTR_ERR(inode);
+		inode = NULL;
+		goto error;
 	}
 
 	/* issue a Twstat */
 	v9fs_blank_wstat(&wstat);
 	wstat.muid = v9ses->name;
 	wstat.extension = (char *) extension;
-	retval = v9fs_t_wstat(v9ses, fid->fid, &wstat, &fcall);
-	if (retval < 0) {
-		PRINT_FCALL_ERROR("wstat error", fcall);
-		goto free_mem;
-	}
-
-	err = v9fs_t_clunk(v9ses, fid->fid);
+	err = v9fs_t_wstat(v9ses, vfid->fid, &wstat, &fcall);
 	if (err < 0) {
-		dprintk(DEBUG_ERROR, "clunk failed: %d\n", err);
-		goto free_mem;
+		PRINT_FCALL_ERROR("wstat error", fcall);
+		goto error;
 	}
 
-	d_drop(dentry);		/* FID - will this also clunk? */
+	kfree(fcall);
+	dentry->d_op = &v9fs_dentry_operations;
+	d_instantiate(dentry, inode);
+	return 0;
 
-free_mem:
+error:
 	kfree(fcall);
-	return retval;
+	if (vfid)
+		v9fs_fid_destroy(vfid);
+
+	if (inode)
+		iput(inode);
+
+	return err;
+
 }
 
 /**
diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -146,7 +146,6 @@ static struct super_block *v9fs_get_sb(s
 	inode->i_gid = gid;
 
 	root = d_alloc_root(inode);
-
 	if (!root) {
 		retval = -ENOMEM;
 		goto put_back_sb;
@@ -157,24 +156,27 @@ static struct super_block *v9fs_get_sb(s
 	stat_result = v9fs_t_stat(v9ses, newfid, &fcall);
 	if (stat_result < 0) {
 		dprintk(DEBUG_ERROR, "stat error\n");
+		kfree(fcall);
 		v9fs_t_clunk(v9ses, newfid);
-		v9fs_put_idpool(newfid, &v9ses->fidpool);
 	} else {
 		/* Setup the Root Inode */
-		root_fid = v9fs_fid_create(root, v9ses, newfid, 0);
+		kfree(fcall);
+		root_fid = v9fs_fid_create(v9ses, newfid);
 		if (root_fid == NULL) {
 			retval = -ENOMEM;
 			goto put_back_sb;
 		}
 
+		retval = v9fs_fid_insert(root_fid, root);
+		if (retval < 0)
+			goto put_back_sb;
+
 		root_fid->qid = fcall->params.rstat.stat.qid;
 		root->d_inode->i_ino =
 		    v9fs_qid2ino(&fcall->params.rstat.stat.qid);
 		v9fs_stat2inode(&fcall->params.rstat.stat, root->d_inode, sb);
 	}
 
-	kfree(fcall);
-
 	if (stat_result < 0) {
 		retval = stat_result;
 		goto put_back_sb;
