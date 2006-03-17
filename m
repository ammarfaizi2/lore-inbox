Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932753AbWCQUld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932753AbWCQUld (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 15:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932756AbWCQUld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 15:41:33 -0500
Received: from hera.kernel.org ([140.211.167.34]:45022 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932753AbWCQUlc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 15:41:32 -0500
Date: Fri, 17 Mar 2006 20:41:17 GMT
From: Eric Van Hensbergen <ericvh@hera.kernel.org>
Message-Id: <200603172041.k2HKfHGW029348@hera.kernel.org>
To: akpm@osdl.org
Subject: [PATCH] v9fs: add extension field to Tcreate
Cc: linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
       ericvh@gmail.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Latchesar Ionkov <lucho@ionkov.net>

Implement a new way of creating special files. Instead of Tcreate+Twstat,
add one more field to Tcreate that contains special file description.

Signed-off-by: Latchesar Ionkov <lucho@ionkov.net>
Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>

---

 fs/9p/9p.c        |    8 +++++---
 fs/9p/9p.h        |    5 +++--
 fs/9p/conv.c      |    8 +++++++-
 fs/9p/conv.h      |    3 ++-
 fs/9p/vfs_file.c  |   32 +++++++++++++++-----------------
 fs/9p/vfs_inode.c |   47 +++++++++++++++++++----------------------------
 6 files changed, 51 insertions(+), 52 deletions(-)

3361438e95e7693aac31c9583bbcbb2b1fd0ad04
diff --git a/fs/9p/9p.c b/fs/9p/9p.c
index 040db05..7d97e9f 100644
--- a/fs/9p/9p.c
+++ b/fs/9p/9p.c
@@ -332,8 +332,8 @@ v9fs_t_remove(struct v9fs_session_info *
  */
 
 int
-v9fs_t_create(struct v9fs_session_info *v9ses, u32 fid, char *name,
-	      u32 perm, u8 mode, struct v9fs_fcall **rcp)
+v9fs_t_create(struct v9fs_session_info *v9ses, u32 fid, char *name, u32 perm, 
+	u8 mode, char *extension, struct v9fs_fcall **rcp)
 {
 	int ret;
 	struct v9fs_fcall *tc;
@@ -341,7 +341,9 @@ v9fs_t_create(struct v9fs_session_info *
 	dprintk(DEBUG_9P, "fid %d name '%s' perm %x mode %d\n",
 		fid, name, perm, mode);
 
-	tc = v9fs_create_tcreate(fid, name, perm, mode);
+	tc = v9fs_create_tcreate(fid, name, perm, mode, extension, 
+		v9ses->extended);
+
 	if (!IS_ERR(tc)) {
 		ret = v9fs_mux_rpc(v9ses->mux, tc, rcp);
 		kfree(tc);
diff --git a/fs/9p/9p.h b/fs/9p/9p.h
index f6eec33..5286b24 100644
--- a/fs/9p/9p.h
+++ b/fs/9p/9p.h
@@ -235,6 +235,7 @@ struct Tcreate {
 	struct v9fs_str name;
 	u32 perm;
 	u8 mode;
+	struct v9fs_str extension;
 };
 
 struct Rcreate {
@@ -365,8 +366,8 @@ int v9fs_t_open(struct v9fs_session_info
 int v9fs_t_remove(struct v9fs_session_info *v9ses, u32 fid,
 		  struct v9fs_fcall **rcall);
 
-int v9fs_t_create(struct v9fs_session_info *v9ses, u32 fid, char *name,
-		  u32 perm, u8 mode, struct v9fs_fcall **rcall);
+int v9fs_t_create(struct v9fs_session_info *v9ses, u32 fid, char *name, 
+	u32 perm, u8 mode, char *extension, struct v9fs_fcall **rcall);
 
 int v9fs_t_read(struct v9fs_session_info *v9ses, u32 fid,
 		u64 offset, u32 count, struct v9fs_fcall **rcall);
diff --git a/fs/9p/conv.c b/fs/9p/conv.c
index bf1f100..8ca3cc5 100644
--- a/fs/9p/conv.c
+++ b/fs/9p/conv.c
@@ -664,7 +664,8 @@ struct v9fs_fcall *v9fs_create_topen(u32
 	return fc;
 }
 
-struct v9fs_fcall *v9fs_create_tcreate(u32 fid, char *name, u32 perm, u8 mode)
+struct v9fs_fcall *v9fs_create_tcreate(u32 fid, char *name, u32 perm, u8 mode, 
+	char *extension, int extended)
 {
 	int size;
 	struct v9fs_fcall *fc;
@@ -672,6 +673,9 @@ struct v9fs_fcall *v9fs_create_tcreate(u
 	struct cbuf *bufp = &buffer;
 
 	size = 4 + 2 + strlen(name) + 4 + 1;	/* fid[4] name[s] perm[4] mode[1] */
+	if (extended && extension!=NULL)
+		size += 2 + strlen(extension);	/* extension[s] */
+
 	fc = v9fs_create_common(bufp, size, TCREATE);
 	if (IS_ERR(fc))
 		goto error;
@@ -680,6 +684,8 @@ struct v9fs_fcall *v9fs_create_tcreate(u
 	v9fs_put_str(bufp, name, &fc->params.tcreate.name);
 	v9fs_put_int32(bufp, perm, &fc->params.tcreate.perm);
 	v9fs_put_int8(bufp, mode, &fc->params.tcreate.mode);
+	if (extended)
+		v9fs_put_str(bufp, extension, &fc->params.tcreate.extension);
 
 	if (buf_check_overflow(bufp)) {
 		kfree(fc);
diff --git a/fs/9p/conv.h b/fs/9p/conv.h
index 26a736e..dfb3912 100644
--- a/fs/9p/conv.h
+++ b/fs/9p/conv.h
@@ -40,7 +40,8 @@ struct v9fs_fcall *v9fs_create_tflush(u1
 struct v9fs_fcall *v9fs_create_twalk(u32 fid, u32 newfid, u16 nwname,
 	char **wnames);
 struct v9fs_fcall *v9fs_create_topen(u32 fid, u8 mode);
-struct v9fs_fcall *v9fs_create_tcreate(u32 fid, char *name, u32 perm, u8 mode);
+struct v9fs_fcall *v9fs_create_tcreate(u32 fid, char *name, u32 perm, u8 mode,
+	char *extension, int extended);
 struct v9fs_fcall *v9fs_create_tread(u32 fid, u64 offset, u32 count);
 struct v9fs_fcall *v9fs_create_twrite(u32 fid, u64 offset, u32 count,
 	const char __user *data);
diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index de3a129..1144d59 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -69,29 +69,30 @@ int v9fs_file_open(struct inode *inode, 
 
 	fid = v9fs_get_idpool(&v9ses->fidpool);
 	if (fid < 0) {
-			eprintk(KERN_WARNING, "newfid fails!\n");
-			return -ENOSPC;
-		}
+		eprintk(KERN_WARNING, "newfid fails!\n");
+		return -ENOSPC;
+	}
 
 	err = v9fs_t_walk(v9ses, vfid->fid, fid, NULL, NULL);
 	if (err < 0) {
-			dprintk(DEBUG_ERROR, "rewalk didn't work\n");
+		dprintk(DEBUG_ERROR, "rewalk didn't work\n");
 		goto put_fid;
 	}
 
-	vfid = kmalloc(sizeof(struct v9fs_fid), GFP_KERNEL);
-	if (vfid == NULL) {
-		dprintk(DEBUG_ERROR, "out of memory\n");
-		goto clunk_fid;
-		}
-
-		/* TODO: do special things for O_EXCL, O_NOFOLLOW, O_SYNC */
-		/* translate open mode appropriately */
+	/* TODO: do special things for O_EXCL, O_NOFOLLOW, O_SYNC */
+	/* translate open mode appropriately */
 	omode = v9fs_uflags2omode(file->f_flags);
 	err = v9fs_t_open(v9ses, fid, omode, &fcall);
 	if (err < 0) {
 		PRINT_FCALL_ERROR("open failed", fcall);
-		goto destroy_vfid;
+		goto clunk_fid;
+	}
+
+	vfid = kmalloc(sizeof(struct v9fs_fid), GFP_KERNEL);
+	if (vfid == NULL) {
+		dprintk(DEBUG_ERROR, "out of memory\n");
+		err = -ENOMEM;
+		goto clunk_fid;
 	}
 
 	file->private_data = vfid;
@@ -106,15 +107,12 @@ int v9fs_file_open(struct inode *inode, 
 
 	return 0;
 
-destroy_vfid:
-	v9fs_fid_destroy(vfid);
-
 clunk_fid:
 	v9fs_t_clunk(v9ses, fid);
 
 put_fid:
 	v9fs_put_idpool(fid, &v9ses->fidpool);
-		kfree(fcall);
+	kfree(fcall);
 
 	return err;
 }
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index d3c4cd4..588d0d2 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -255,8 +255,8 @@ struct inode *v9fs_get_inode(struct supe
 }
 
 static int
-v9fs_create(struct v9fs_session_info *v9ses, u32 pfid, char *name,
-	u32 perm, u8 mode, u32 *fidp, struct v9fs_qid *qid, u32 *iounit)
+v9fs_create(struct v9fs_session_info *v9ses, u32 pfid, char *name, u32 perm, 
+	u8 mode, char *extension, u32 *fidp, struct v9fs_qid *qid, u32 *iounit)
 {
 	u32 fid;
 	int err;
@@ -271,14 +271,14 @@ v9fs_create(struct v9fs_session_info *v9
 	err = v9fs_t_walk(v9ses, pfid, fid, NULL, &fcall);
 	if (err < 0) {
 		PRINT_FCALL_ERROR("clone error", fcall);
-		goto error;
+		goto put_fid;
 	}
 	kfree(fcall);
 
-	err = v9fs_t_create(v9ses, fid, name, perm, mode, &fcall);
+	err = v9fs_t_create(v9ses, fid, name, perm, mode, extension, &fcall);
 	if (err < 0) {
 		PRINT_FCALL_ERROR("create fails", fcall);
-		goto error;
+		goto clunk_fid;
 	}
 
 	if (iounit)
@@ -293,7 +293,11 @@ v9fs_create(struct v9fs_session_info *v9
 	kfree(fcall);
 	return 0;
 
-error:
+clunk_fid:
+	v9fs_t_clunk(v9ses, fid);
+	fid = V9FS_NOFID;
+
+put_fid:
 	if (fid >= 0)
 		v9fs_put_idpool(fid, &v9ses->fidpool);
 
@@ -474,7 +478,7 @@ v9fs_vfs_create(struct inode *dir, struc
 		flags = O_RDWR;
 
 	err = v9fs_create(v9ses, dfid->fid, (char *) dentry->d_name.name,
-		perm, v9fs_uflags2omode(flags), &fid, &qid, &iounit);
+		perm, v9fs_uflags2omode(flags), NULL, &fid, &qid, &iounit);
 
 	if (err)
 		goto error;
@@ -550,7 +554,7 @@ static int v9fs_vfs_mkdir(struct inode *
 	perm = unixmode2p9mode(v9ses, mode | S_IFDIR);
 
 	err = v9fs_create(v9ses, dfid->fid, (char *) dentry->d_name.name,
-		perm, V9FS_OREAD, &fid, NULL, NULL);
+		perm, V9FS_OREAD, NULL, &fid, NULL, NULL);
 
 	if (err) {
 		dprintk(DEBUG_ERROR, "create error %d\n", err);
@@ -1008,11 +1012,13 @@ static int v9fs_readlink(struct dentry *
 
 	/* copy extension buffer into buffer */
 	if (fcall->params.rstat.stat.extension.len < buflen)
-		buflen = fcall->params.rstat.stat.extension.len;
+		buflen = fcall->params.rstat.stat.extension.len + 1;
 
-	memcpy(buffer, fcall->params.rstat.stat.extension.str, buflen - 1);
+	memmove(buffer, fcall->params.rstat.stat.extension.str, buflen - 1);
 	buffer[buflen-1] = 0;
 
+	dprintk(DEBUG_ERROR, "%s -> %.*s (%s)\n", dentry->d_name.name, fcall->params.rstat.stat.extension.len,
+		fcall->params.rstat.stat.extension.str, buffer);
 	retval = buflen;
 
       FreeFcall:
@@ -1072,7 +1078,7 @@ static void *v9fs_vfs_follow_link(struct
 	if (!link)
 		link = ERR_PTR(-ENOMEM);
 	else {
-		len = v9fs_readlink(dentry, link, strlen(link));
+		len = v9fs_readlink(dentry, link, PATH_MAX);
 
 		if (len < 0) {
 			__putname(link);
@@ -1109,10 +1115,7 @@ static int v9fs_vfs_mkspecial(struct ino
 	struct v9fs_session_info *v9ses;
 	struct v9fs_fid *dfid, *vfid;
 	struct inode *inode;
-	struct v9fs_fcall *fcall;
-	struct v9fs_wstat wstat;
 
-	fcall = NULL;
 	inode = NULL;
 	vfid = NULL;
 	v9ses = v9fs_inode2v9ses(dir);
@@ -1125,7 +1128,7 @@ static int v9fs_vfs_mkspecial(struct ino
 	}
 
 	err = v9fs_create(v9ses, dfid->fid, (char *) dentry->d_name.name,
-		perm, V9FS_OREAD, &fid, NULL, NULL);
+		perm, V9FS_OREAD, (char *) extension, &fid, NULL, NULL);
 
 	if (err)
 		goto error;
@@ -1148,23 +1151,11 @@ static int v9fs_vfs_mkspecial(struct ino
 		goto error;
 	}
 
-	/* issue a Twstat */
-	v9fs_blank_wstat(&wstat);
-	wstat.muid = v9ses->name;
-	wstat.extension = (char *) extension;
-	err = v9fs_t_wstat(v9ses, vfid->fid, &wstat, &fcall);
-	if (err < 0) {
-		PRINT_FCALL_ERROR("wstat error", fcall);
-		goto error;
-	}
-
-	kfree(fcall);
 	dentry->d_op = &v9fs_dentry_operations;
 	d_instantiate(dentry, inode);
 	return 0;
 
 error:
-	kfree(fcall);
 	if (vfid)
 		v9fs_fid_destroy(vfid);
 
@@ -1224,7 +1215,7 @@ v9fs_vfs_link(struct dentry *old_dentry,
 	}
 
 	name = __getname();
-	sprintf(name, "hardlink(%d)\n", oldfid->fid);
+	sprintf(name, "%d\n", oldfid->fid);
 	retval = v9fs_vfs_mkspecial(dir, dentry, V9FS_DMLINK, name);
 	__putname(name);
 
-- 
1.1.0
