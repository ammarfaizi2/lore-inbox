Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932199AbVIXRV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbVIXRV3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 13:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbVIXRV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 13:21:29 -0400
Received: from rwcrmhc12.comcast.net ([204.127.198.43]:8371 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932199AbVIXRV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 13:21:29 -0400
Date: Sat, 24 Sep 2005 13:21:13 -0400
From: Latchesar Ionkov <lucho@ionkov.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Subject: [PATCH] v9fs: fix races in fid allocation
Message-ID: <20050924172113.GA1133@ionkov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fid management cleanup. The patch attempts to fix the races in dentry's fid
management.

Dentries don't keep the opened fids anymore, they are moved to the file
structs. Ideally there should be no more than one fid with fidcreate equal
to zero in the dentry's list of fids.

v9fs_fid_create initializes the important fields (fid, fidcreated) before
v9fs_fid is added to the list. v9fs_fid_lookup returns only fids that are
not created by v9fs_create. v9fs_fid_get_created returns the fid created by
the same process by v9fs_create (if any) and removes it from dentry's list

Signed-off-by: Latchesar Ionkov <lucho@ionkov.net>

---
commit 7b8f9ec729fd048814132bb10b0f1b3162bce7c2
tree 9318e831242e8e9658c131435990527826ec743a
parent 87e807b6c461bbd449496a4c3ab78ab164a4ba97
author Latchesar Ionkov <lucho@ionkov.net> Sat, 24 Sep 2005 13:18:27 -0400
committer Latchesar Ionkov <lucho@ionkov.net> Sat, 24 Sep 2005 13:18:27 -0400

 fs/9p/fid.c        |  176 ++++++++++++++++++++++++++++------------------------
 fs/9p/fid.h        |    7 +-
 fs/9p/vfs_dentry.c |    2 -
 fs/9p/vfs_dir.c    |   11 +--
 fs/9p/vfs_file.c   |   88 ++++++++------------------
 fs/9p/vfs_inode.c  |   91 +++++++++++++++++----------
 fs/9p/vfs_super.c  |   21 ++----
 7 files changed, 200 insertions(+), 196 deletions(-)

diff --git a/fs/9p/fid.c b/fs/9p/fid.c
--- a/fs/9p/fid.c
+++ b/fs/9p/fid.c
@@ -71,21 +71,28 @@ static int v9fs_fid_insert(struct v9fs_f
  *
  */
 
-struct v9fs_fid *v9fs_fid_create(struct dentry *dentry)
+struct v9fs_fid *v9fs_fid_create(struct dentry *dentry, 
+	struct v9fs_session_info *v9ses, int fid, int create)
 {
 	struct v9fs_fid *new;
 
+	dprintk(DEBUG_9P, "fid create dentry %p, fid %d, create %d\n",
+		dentry, fid, create);
+
 	new = kmalloc(sizeof(struct v9fs_fid), GFP_KERNEL);
 	if (new == NULL) {
 		dprintk(DEBUG_ERROR, "Out of Memory\n");
 		return ERR_PTR(-ENOMEM);
 	}
 
-	new->fid = -1;
+	new->fid = fid;
+	new->v9ses = v9ses;
 	new->fidopen = 0;
-	new->fidcreate = 0;
+	new->fidcreate = create;
 	new->fidclunked = 0;
 	new->iounit = 0;
+	new->rdir_pos = 0;
+	new->rdir_fcall = NULL;
 
 	if (v9fs_fid_insert(new, dentry) == 0)
 		return new;
@@ -109,6 +116,59 @@ void v9fs_fid_destroy(struct v9fs_fid *f
 }
 
 /**
+ * v9fs_fid_walk_up - walks from the process current directory 
+ * 	up to the specified dentry.
+ */
+static struct v9fs_fid *v9fs_fid_walk_up(struct dentry *dentry)
+{
+	int fidnum, cfidnum, err;
+	struct v9fs_fid *cfid;
+	struct dentry *cde;
+	struct v9fs_session_info *v9ses;
+
+	v9ses = v9fs_inode2v9ses(current->fs->pwd->d_inode);
+	cfid = v9fs_fid_lookup(current->fs->pwd);
+	if (cfid == NULL) {
+		dprintk(DEBUG_ERROR, "process cwd doesn't have a fid\n");
+		return ERR_PTR(-ENOENT);
+	}
+
+	cfidnum = cfid->fid;
+	cde = current->fs->pwd;
+	/* TODO: take advantage of multiwalk */
+
+	fidnum = v9fs_get_idpool(&v9ses->fidpool);
+	if (fidnum < 0) {
+		dprintk(DEBUG_ERROR, "could not get a new fid num\n");
+		err = -ENOENT;
+		goto clunk_fid;
+	}
+
+	while (cde != dentry) {
+		if (cde == cde->d_parent) {
+			dprintk(DEBUG_ERROR, "can't find dentry\n");
+			err = -ENOENT;
+			goto clunk_fid;
+		}
+
+		err = v9fs_t_walk(v9ses, cfidnum, fidnum, "..", NULL);
+		if (err < 0) {
+			dprintk(DEBUG_ERROR, "problem walking to parent\n");
+			goto clunk_fid;
+		}
+
+		cfidnum = fidnum;
+		cde = cde->d_parent;
+	}
+
+	return v9fs_fid_create(dentry, v9ses, fidnum, 0);
+
+clunk_fid:
+	v9fs_t_clunk(v9ses, fidnum, NULL);
+	return ERR_PTR(err);
+}
+
+/**
  * v9fs_fid_lookup - retrieve the right fid from a  particular dentry
  * @dentry: dentry to look for fid in
  * @type: intent of lookup (operation or traversal)
@@ -119,49 +179,25 @@ void v9fs_fid_destroy(struct v9fs_fid *f
  *
  */
 
-struct v9fs_fid *v9fs_fid_lookup(struct dentry *dentry, int type)
+struct v9fs_fid *v9fs_fid_lookup(struct dentry *dentry)
 {
 	struct list_head *fid_list = (struct list_head *)dentry->d_fsdata;
 	struct v9fs_fid *current_fid = NULL;
 	struct v9fs_fid *temp = NULL;
 	struct v9fs_fid *return_fid = NULL;
-	int found_parent = 0;
-	int found_user = 0;
 
-	dprintk(DEBUG_9P, " dentry: %s (%p) type %d\n", dentry->d_iname, dentry,
-		type);
+	dprintk(DEBUG_9P, " dentry: %s (%p)\n", dentry->d_iname, dentry);
 
-	if (fid_list && !list_empty(fid_list)) {
+	if (fid_list) {
 		list_for_each_entry_safe(current_fid, temp, fid_list, list) {
-			if (current_fid->uid == current->uid) {
-				if (return_fid == NULL) {
-					if ((type == FID_OP)
-					    || (!current_fid->fidopen)) {
-						return_fid = current_fid;
-						found_user = 1;
-					}
-				}
-			}
-			if (current_fid->pid == current->real_parent->pid) {
-				if ((return_fid == NULL) || (found_parent)
-				    || (found_user)) {
-					if ((type == FID_OP)
-					    || (!current_fid->fidopen)) {
-						return_fid = current_fid;
-						found_parent = 1;
-						found_user = 0;
-					}
-				}
-			}
-			if (current_fid->pid == current->pid) {
-				if ((type == FID_OP) ||
-				    (!current_fid->fidopen)) {
-					return_fid = current_fid;
-					found_parent = 0;
-					found_user = 0;
-				}
+			if (!current_fid->fidcreate) {
+				return_fid = current_fid;
+				break;
 			}
 		}
+
+		if (!return_fid)
+			return_fid = current_fid;
 	}
 
 	/* we are at the root but didn't match */
@@ -187,55 +223,33 @@ struct v9fs_fid *v9fs_fid_lookup(struct 
 
 /* XXX - there may be some duplication we can get rid of */
 		if (par == dentry) {
-			/* we need to fid_lookup the starting point */
-			int fidnum = -1;
-			int oldfid = -1;
-			int result = -1;
-			struct v9fs_session_info *v9ses =
-			    v9fs_inode2v9ses(current->fs->pwd->d_inode);
-
-			current_fid =
-			    v9fs_fid_lookup(current->fs->pwd, FID_WALK);
-			if (current_fid == NULL) {
-				dprintk(DEBUG_ERROR,
-					"process cwd doesn't have a fid\n");
-				return return_fid;
-			}
-			oldfid = current_fid->fid;
-			par = current->fs->pwd;
-			/* TODO: take advantage of multiwalk */
+			return_fid = v9fs_fid_walk_up(dentry);
+			if (IS_ERR(return_fid))
+				return_fid = NULL;
+		}
+	}
 
-			fidnum = v9fs_get_idpool(&v9ses->fidpool);
-			if (fidnum < 0) {
-				dprintk(DEBUG_ERROR,
-					"could not get a new fid num\n");
-				return return_fid;
-			}
+	return return_fid;
+}
 
-			while (par != dentry) {
-				result =
-				    v9fs_t_walk(v9ses, oldfid, fidnum, "..",
-						NULL);
-				if (result < 0) {
-					dprintk(DEBUG_ERROR,
-						"problem walking to parent\n");
-
-					break;
-				}
-				oldfid = fidnum;
-				if (par == par->d_parent) {
-					dprintk(DEBUG_ERROR,
-						"can't find dentry\n");
-					break;
-				}
-				par = par->d_parent;
-			}
-			if (par == dentry) {
-				return_fid = v9fs_fid_create(dentry);
-				return_fid->fid = fidnum;
+struct v9fs_fid *v9fs_fid_get_created(struct dentry *dentry)
+{
+	struct list_head *fid_list;
+	struct v9fs_fid *fid, *ftmp, *ret;
+
+	dprintk(DEBUG_9P, " dentry: %s (%p)\n", dentry->d_iname, dentry);
+	fid_list = (struct list_head *)dentry->d_fsdata;
+	ret = NULL;
+	if (fid_list) {
+		list_for_each_entry_safe(fid, ftmp, fid_list, list) {
+			if (fid->fidcreate && fid->pid == current->pid) {
+				list_del(&fid->list);
+				ret = fid;
+				break;
 			}
 		}
 	}
 
-	return return_fid;
+	dprintk(DEBUG_9P, "return %p\n", ret);
+	return ret;
 }
diff --git a/fs/9p/fid.h b/fs/9p/fid.h
--- a/fs/9p/fid.h
+++ b/fs/9p/fid.h
@@ -25,6 +25,7 @@
 
 #define FID_OP   0
 #define FID_WALK 1
+#define FID_CREATE 2
 
 struct v9fs_fid {
 	struct list_head list;	 /* list of fids associated with a dentry */
@@ -52,6 +53,8 @@ struct v9fs_fid {
 	struct v9fs_session_info *v9ses;	/* session info for this FID */
 };
 
-struct v9fs_fid *v9fs_fid_lookup(struct dentry *dentry, int type);
+struct v9fs_fid *v9fs_fid_lookup(struct dentry *dentry);
+struct v9fs_fid *v9fs_fid_get_created(struct dentry *);
 void v9fs_fid_destroy(struct v9fs_fid *fid);
-struct v9fs_fid *v9fs_fid_create(struct dentry *);
+struct v9fs_fid *v9fs_fid_create(struct dentry *, 
+	struct v9fs_session_info *v9ses, int fid, int create);
diff --git a/fs/9p/vfs_dentry.c b/fs/9p/vfs_dentry.c
--- a/fs/9p/vfs_dentry.c
+++ b/fs/9p/vfs_dentry.c
@@ -67,7 +67,7 @@ static int v9fs_dentry_validate(struct d
 	struct dentry *dc = current->fs->pwd;
 
 	dprintk(DEBUG_VFS, "dentry: %s (%p)\n", dentry->d_iname, dentry);
-	if (v9fs_fid_lookup(dentry, FID_OP)) {
+	if (v9fs_fid_lookup(dentry)) {
 		dprintk(DEBUG_VFS, "VALID\n");
 		return 1;
 	}
diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -197,21 +197,18 @@ int v9fs_dir_release(struct inode *inode
 	filemap_fdatawait(inode->i_mapping);
 
 	if (fidnum >= 0) {
-		fid->fidopen--;
 		dprintk(DEBUG_VFS, "fidopen: %d v9f->fid: %d\n", fid->fidopen,
 			fid->fid);
 
-		if (fid->fidopen == 0) {
-			if (v9fs_t_clunk(v9ses, fidnum, NULL))
-				dprintk(DEBUG_ERROR, "clunk failed\n");
+		if (v9fs_t_clunk(v9ses, fidnum, NULL))
+			dprintk(DEBUG_ERROR, "clunk failed\n");
 
-			v9fs_put_idpool(fid->fid, &v9ses->fidpool);
-		}
+		v9fs_put_idpool(fid->fid, &v9ses->fidpool);
 
 		kfree(fid->rdir_fcall);
+		kfree(fid);
 
 		filp->private_data = NULL;
-		v9fs_fid_destroy(fid);
 	}
 
 	d_drop(filp->f_dentry);
diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -53,30 +53,36 @@
 int v9fs_file_open(struct inode *inode, struct file *file)
 {
 	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(inode);
-	struct v9fs_fid *v9fid = v9fs_fid_lookup(file->f_dentry, FID_WALK);
-	struct v9fs_fid *v9newfid = NULL;
+	struct v9fs_fid *v9fid, *fid;
 	struct v9fs_fcall *fcall = NULL;
 	int open_mode = 0;
 	unsigned int iounit = 0;
 	int newfid = -1;
 	long result = -1;
 
-	dprintk(DEBUG_VFS, "inode: %p file: %p v9fid= %p\n", inode, file,
-		v9fid);
+	dprintk(DEBUG_VFS, "inode: %p file: %p \n", inode, file);
+
+	v9fid = v9fs_fid_get_created(file->f_dentry);
+	if (!v9fid)
+		v9fid = v9fs_fid_lookup(file->f_dentry);
 
 	if (!v9fid) {
-		struct dentry *dentry = file->f_dentry;
 		dprintk(DEBUG_ERROR, "Couldn't resolve fid from dentry\n");
+		return -EBADF;
+	}
 
-		/* XXX - some duplication from lookup, generalize later */
-		/* basically vfs_lookup is too heavy weight */
-		v9fid = v9fs_fid_lookup(file->f_dentry, FID_OP);
-		if (!v9fid)
-			return -EBADF;
+	if (!v9fid->fidcreate) {
+		fid = kmalloc(sizeof(struct v9fs_fid), GFP_KERNEL);
+		if (fid == NULL) {
+			dprintk(DEBUG_ERROR, "Out of Memory\n");
+			return -ENOMEM;
+		}
 
-		v9fid = v9fs_fid_lookup(dentry->d_parent, FID_WALK);
-		if (!v9fid)
-			return -EBADF;
+		fid->fidopen = 0;
+		fid->fidcreate = 0;
+		fid->fidclunked = 0;
+		fid->iounit = 0;
+		fid->v9ses = v9ses;
 
 		newfid = v9fs_get_idpool(&v9ses->fidpool);
 		if (newfid < 0) {
@@ -85,58 +91,16 @@ int v9fs_file_open(struct inode *inode, 
 		}
 
 		result =
-		    v9fs_t_walk(v9ses, v9fid->fid, newfid,
-				(char *)file->f_dentry->d_name.name, NULL);
+		    v9fs_t_walk(v9ses, v9fid->fid, newfid, NULL, NULL);
+
 		if (result < 0) {
 			v9fs_put_idpool(newfid, &v9ses->fidpool);
 			dprintk(DEBUG_ERROR, "rewalk didn't work\n");
 			return -EBADF;
 		}
 
-		v9fid = v9fs_fid_create(dentry);
-		if (v9fid == NULL) {
-			dprintk(DEBUG_ERROR, "couldn't insert\n");
-			return -ENOMEM;
-		}
-		v9fid->fid = newfid;
-	}
-
-	if (v9fid->fidcreate) {
-		/* create case */
-		newfid = v9fid->fid;
-		iounit = v9fid->iounit;
-		v9fid->fidcreate = 0;
-	} else {
-		if (!S_ISDIR(inode->i_mode))
-			newfid = v9fid->fid;
-		else {
-			newfid = v9fs_get_idpool(&v9ses->fidpool);
-			if (newfid < 0) {
-				eprintk(KERN_WARNING, "allocation failed\n");
-				return -ENOSPC;
-			}
-			/* This would be a somewhat critical clone */
-			result =
-			    v9fs_t_walk(v9ses, v9fid->fid, newfid, NULL,
-					&fcall);
-			if (result < 0) {
-				dprintk(DEBUG_ERROR, "clone error: %s\n",
-					FCALL_ERROR(fcall));
-				kfree(fcall);
-				return result;
-			}
-
-			v9newfid = v9fs_fid_create(file->f_dentry);
-			v9newfid->fid = newfid;
-			v9newfid->qid = v9fid->qid;
-			v9newfid->iounit = v9fid->iounit;
-			v9newfid->fidopen = 0;
-			v9newfid->fidclunked = 0;
-			v9newfid->v9ses = v9ses;
-			v9fid = v9newfid;
-			kfree(fcall);
-		}
-
+		fid->fid = newfid;
+		v9fid = fid;
 		/* TODO: do special things for O_EXCL, O_NOFOLLOW, O_SYNC */
 		/* translate open mode appropriately */
 		open_mode = file->f_flags & 0x3;
@@ -163,9 +127,13 @@ int v9fs_file_open(struct inode *inode, 
 
 		iounit = fcall->params.ropen.iounit;
 		kfree(fcall);
+	} else {
+		/* create case */
+		newfid = v9fid->fid;
+		iounit = v9fid->iounit;
+		v9fid->fidcreate = 0;
 	}
 
-
 	file->private_data = v9fid;
 
 	v9fid->rdir_pos = 0;
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -307,7 +307,7 @@ v9fs_create(struct inode *dir,
 	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(dir);
 	struct super_block *sb = dir->i_sb;
 	struct v9fs_fid *dirfid =
-	    v9fs_fid_lookup(file_dentry->d_parent, FID_WALK);
+	    v9fs_fid_lookup(file_dentry->d_parent);
 	struct v9fs_fid *fid = NULL;
 	struct inode *file_inode = NULL;
 	struct v9fs_fcall *fcall = NULL;
@@ -317,6 +317,7 @@ v9fs_create(struct inode *dir,
 	long newfid = -1;
 	int result = 0;
 	unsigned int iounit = 0;
+	int wfidno = -1;
 
 	perm = unixmode2p9mode(v9ses, perm);
 
@@ -350,7 +351,7 @@ v9fs_create(struct inode *dir,
 	if (result < 0) {
 		dprintk(DEBUG_ERROR, "clone error: %s\n", FCALL_ERROR(fcall));
 		v9fs_put_idpool(newfid, &v9ses->fidpool);
-		newfid = 0;
+		newfid = -1;
 		goto CleanUpFid;
 	}
 
@@ -369,20 +370,39 @@ v9fs_create(struct inode *dir,
 	qid = fcall->params.rcreate.qid;
 	kfree(fcall);
 
-	fid = v9fs_fid_create(file_dentry);
+	fid = v9fs_fid_create(file_dentry, v9ses, newfid, 1);
+	dprintk(DEBUG_VFS, "fid %p %d\n", fid, fid->fidcreate);
 	if (!fid) {
 		result = -ENOMEM;
 		goto CleanUpFid;
 	}
 
-	fid->fid = newfid;
-	fid->fidopen = 0;
-	fid->fidcreate = 1;
 	fid->qid = qid;
 	fid->iounit = iounit;
-	fid->rdir_pos = 0;
-	fid->rdir_fcall = NULL;
-	fid->v9ses = v9ses;
+
+	/* walk to the newly created file and put the fid in the dentry */
+	wfidno = v9fs_get_idpool(&v9ses->fidpool);
+	if (newfid < 0) {
+		eprintk(KERN_WARNING, "no free fids available\n");
+		return -ENOSPC;
+	}
+
+	result = v9fs_t_walk(v9ses, dirfidnum, wfidno,
+		(char *) file_dentry->d_name.name, NULL);
+	if (result < 0) {
+		dprintk(DEBUG_ERROR, "clone error: %s\n", FCALL_ERROR(fcall));
+		v9fs_put_idpool(wfidno, &v9ses->fidpool);
+		wfidno = -1;
+		goto CleanUpFid;
+	}
+
+	if (!v9fs_fid_create(file_dentry, v9ses, wfidno, 0)) {
+		if (!v9fs_t_clunk(v9ses, newfid, &fcall)) {
+			v9fs_put_idpool(wfidno, &v9ses->fidpool);
+		}
+
+		goto CleanUpFid;
+	}
 
 	if ((perm & V9FS_DMSYMLINK) || (perm & V9FS_DMLINK) ||
 	    (perm & V9FS_DMNAMEDPIPE) || (perm & V9FS_DMSOCKET) ||
@@ -410,11 +430,11 @@ v9fs_create(struct inode *dir,
 	d_instantiate(file_dentry, file_inode);
 
 	if (perm & V9FS_DMDIR) {
-		if (v9fs_t_clunk(v9ses, newfid, &fcall))
+		if (!v9fs_t_clunk(v9ses, newfid, &fcall))
+			v9fs_put_idpool(newfid, &v9ses->fidpool);
+		else
 			dprintk(DEBUG_ERROR, "clunk for mkdir failed: %s\n",
 				FCALL_ERROR(fcall));
-
-		v9fs_put_idpool(newfid, &v9ses->fidpool);
 		kfree(fcall);
 		fid->fidopen = 0;
 		fid->fidcreate = 0;
@@ -426,12 +446,22 @@ v9fs_create(struct inode *dir,
       CleanUpFid:
 	kfree(fcall);
 
-	if (newfid) {
-		if (v9fs_t_clunk(v9ses, newfid, &fcall))
+	if (newfid >= 0) {
+		if (!v9fs_t_clunk(v9ses, newfid, &fcall))
+			v9fs_put_idpool(newfid, &v9ses->fidpool);
+		else
+			dprintk(DEBUG_ERROR, "clunk failed: %s\n",
+				FCALL_ERROR(fcall));
+
+		kfree(fcall);
+	}
+	if (wfidno >= 0) {
+		if (!v9fs_t_clunk(v9ses, wfidno, &fcall))
+			v9fs_put_idpool(wfidno, &v9ses->fidpool);
+		else
 			dprintk(DEBUG_ERROR, "clunk failed: %s\n",
 				FCALL_ERROR(fcall));
 
-		v9fs_put_idpool(newfid, &v9ses->fidpool);
 		kfree(fcall);
 	}
 	return result;
@@ -461,7 +491,7 @@ static int v9fs_remove(struct inode *dir
 	file_inode = file->d_inode;
 	sb = file_inode->i_sb;
 	v9ses = v9fs_inode2v9ses(file_inode);
-	v9fid = v9fs_fid_lookup(file, FID_OP);
+	v9fid = v9fs_fid_lookup(file);
 
 	if (!v9fid) {
 		dprintk(DEBUG_ERROR,
@@ -545,7 +575,7 @@ static struct dentry *v9fs_vfs_lookup(st
 
 	sb = dir->i_sb;
 	v9ses = v9fs_inode2v9ses(dir);
-	dirfid = v9fs_fid_lookup(dentry->d_parent, FID_WALK);
+	dirfid = v9fs_fid_lookup(dentry->d_parent);
 
 	if (!dirfid) {
 		dprintk(DEBUG_ERROR, "no dirfid\n");
@@ -573,7 +603,7 @@ static struct dentry *v9fs_vfs_lookup(st
 		v9fs_put_idpool(newfid, &v9ses->fidpool);
 		if (result == -ENOENT) {
 			d_add(dentry, NULL);
-			dprintk(DEBUG_ERROR,
+			dprintk(DEBUG_VFS,
 				"Return negative dentry %p count %d\n",
 				dentry, atomic_read(&dentry->d_count));
 			return NULL;
@@ -601,16 +631,13 @@ static struct dentry *v9fs_vfs_lookup(st
 
 	inode->i_ino = v9fs_qid2ino(&fcall->params.rstat.stat->qid);
 
-	fid = v9fs_fid_create(dentry);
+	fid = v9fs_fid_create(dentry, v9ses, newfid, 0);
 	if (fid == NULL) {
 		dprintk(DEBUG_ERROR, "couldn't insert\n");
 		result = -ENOMEM;
 		goto FreeFcall;
 	}
 
-	fid->fid = newfid;
-	fid->fidopen = 0;
-	fid->v9ses = v9ses;
 	fid->qid = fcall->params.rstat.stat->qid;
 
 	dentry->d_op = &v9fs_dentry_operations;
@@ -665,11 +692,11 @@ v9fs_vfs_rename(struct inode *old_dir, s
 {
 	struct inode *old_inode = old_dentry->d_inode;
 	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(old_inode);
-	struct v9fs_fid *oldfid = v9fs_fid_lookup(old_dentry, FID_WALK);
+	struct v9fs_fid *oldfid = v9fs_fid_lookup(old_dentry);
 	struct v9fs_fid *olddirfid =
-	    v9fs_fid_lookup(old_dentry->d_parent, FID_WALK);
+	    v9fs_fid_lookup(old_dentry->d_parent);
 	struct v9fs_fid *newdirfid =
-	    v9fs_fid_lookup(new_dentry->d_parent, FID_WALK);
+	    v9fs_fid_lookup(new_dentry->d_parent);
 	struct v9fs_stat *mistat = kmalloc(v9ses->maxdata, GFP_KERNEL);
 	struct v9fs_fcall *fcall = NULL;
 	int fid = -1;
@@ -744,7 +771,7 @@ v9fs_vfs_getattr(struct vfsmount *mnt, s
 {
 	struct v9fs_fcall *fcall = NULL;
 	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(dentry->d_inode);
-	struct v9fs_fid *fid = v9fs_fid_lookup(dentry, FID_OP);
+	struct v9fs_fid *fid = v9fs_fid_lookup(dentry);
 	int err = -EPERM;
 
 	dprintk(DEBUG_VFS, "dentry: %p\n", dentry);
@@ -778,7 +805,7 @@ v9fs_vfs_getattr(struct vfsmount *mnt, s
 static int v9fs_vfs_setattr(struct dentry *dentry, struct iattr *iattr)
 {
 	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(dentry->d_inode);
-	struct v9fs_fid *fid = v9fs_fid_lookup(dentry, FID_OP);
+	struct v9fs_fid *fid = v9fs_fid_lookup(dentry);
 	struct v9fs_fcall *fcall = NULL;
 	struct v9fs_stat *mistat = kmalloc(v9ses->maxdata, GFP_KERNEL);
 	int res = -EPERM;
@@ -960,7 +987,7 @@ v9fs_vfs_symlink(struct inode *dir, stru
 	if (retval != 0)
 		goto FreeFcall;
 
-	newfid = v9fs_fid_lookup(dentry, FID_OP);
+	newfid = v9fs_fid_lookup(dentry);
 
 	/* issue a twstat */
 	v9fs_blank_mistat(v9ses, mistat);
@@ -1004,7 +1031,7 @@ static int v9fs_readlink(struct dentry *
 
 	struct v9fs_fcall *fcall = NULL;
 	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(dentry->d_inode);
-	struct v9fs_fid *fid = v9fs_fid_lookup(dentry, FID_OP);
+	struct v9fs_fid *fid = v9fs_fid_lookup(dentry);
 
 	if (!fid) {
 		dprintk(DEBUG_ERROR, "could not resolve fid from dentry\n");
@@ -1148,7 +1175,7 @@ v9fs_vfs_link(struct dentry *old_dentry,
 	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(dir);
 	struct v9fs_fcall *fcall = NULL;
 	struct v9fs_stat *mistat = kmalloc(v9ses->maxdata, GFP_KERNEL);
-	struct v9fs_fid *oldfid = v9fs_fid_lookup(old_dentry, FID_OP);
+	struct v9fs_fid *oldfid = v9fs_fid_lookup(old_dentry);
 	struct v9fs_fid *newfid = NULL;
 	char *symname = __getname();
 
@@ -1168,7 +1195,7 @@ v9fs_vfs_link(struct dentry *old_dentry,
 	if (retval != 0)
 		goto FreeMem;
 
-	newfid = v9fs_fid_lookup(dentry, FID_OP);
+	newfid = v9fs_fid_lookup(dentry);
 	if (!newfid) {
 		dprintk(DEBUG_ERROR, "couldn't resolve fid from dentry\n");
 		goto FreeMem;
@@ -1246,7 +1273,7 @@ v9fs_vfs_mknod(struct inode *dir, struct
 	if (retval != 0)
 		goto FreeMem;
 
-	newfid = v9fs_fid_lookup(dentry, FID_OP);
+	newfid = v9fs_fid_lookup(dentry);
 	if (!newfid) {
 		dprintk(DEBUG_ERROR, "coudn't resove fid from dentry\n");
 		retval = -EINVAL;
diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -129,8 +129,7 @@ static struct super_block *v9fs_get_sb(s
 
 	if ((newfid = v9fs_session_init(v9ses, dev_name, data)) < 0) {
 		dprintk(DEBUG_ERROR, "problem initiating session\n");
-		kfree(v9ses);
-		return ERR_PTR(newfid);
+		return newfid;
 	}
 
 	sb = sget(fs_type, NULL, v9fs_set_super, v9ses);
@@ -155,23 +154,19 @@ static struct super_block *v9fs_get_sb(s
 
 	sb->s_root = root;
 
-	/* Setup the Root Inode */
-	root_fid = v9fs_fid_create(root);
-	if (root_fid == NULL) {
-		retval = -ENOMEM;
-		goto put_back_sb;
-	}
-
-	root_fid->fidopen = 0;
-	root_fid->v9ses = v9ses;
-
 	stat_result = v9fs_t_stat(v9ses, newfid, &fcall);
 	if (stat_result < 0) {
 		dprintk(DEBUG_ERROR, "stat error\n");
 		v9fs_t_clunk(v9ses, newfid, NULL);
 		v9fs_put_idpool(newfid, &v9ses->fidpool);
 	} else {
-		root_fid->fid = newfid;
+		/* Setup the Root Inode */
+		root_fid = v9fs_fid_create(root, v9ses, newfid, 0);
+		if (root_fid == NULL) {
+			retval = -ENOMEM;
+			goto put_back_sb;
+		}
+
 		root_fid->qid = fcall->params.rstat.stat->qid;
 		root->d_inode->i_ino =
 		    v9fs_qid2ino(&fcall->params.rstat.stat->qid);
