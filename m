Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751283AbWB0ENU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbWB0ENU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 23:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbWB0ENU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 23:13:20 -0500
Received: from cpe-70-112-167-32.austin.res.rr.com ([70.112.167.32]:57228 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751283AbWB0ENT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 23:13:19 -0500
To: akpm@osdl.org
Subject: [PATCH 3/3] v9fs: simplify fid mapping
Cc: linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
       ericvh@gmail.com
Message-Id: <20060227041332.AEDA65A8075@localhost.localdomain>
Date: Sun, 26 Feb 2006 22:13:32 -0600 (CST)
From: ericvh@gmail.com (Eric Van Hensbergen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH] v9fs: fix fid management
From: Eric Van Hensbergen <ericvh@gmail.com>
Date: 1140666276 -0600

v9fs has been plagued by an over-complicated approach trying to map Linux
dentry semantics to Plan 9 fid semantics.  Our previous approach called for
aggressive flushing of the dcache resulting in several problems (including
wierd cwd behavior when running /bin/pwd).

This patch dramatically simplifies our handling of this fid management.  Fids
will not be clunked as promptly, but the new approach is more functionally
correct.  We now clunk un-open fids only when their dentry ref_count reaches
0 (and d_delete is called).

Another simplification is we no longer seek to match fids to the process-id or
uid of the action initiator.  The uid-matching will need to be revisited when
we fix the security model.

Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>

---

 fs/9p/fid.c        |   94 +++-------------------------------------------------
 fs/9p/fid.h        |    1 -
 fs/9p/v9fs.c       |    1 +
 fs/9p/vfs_dentry.c |   45 ++++---------------------
 4 files changed, 15 insertions(+), 126 deletions(-)

255909b76466561a6626bcd49a7676ff5c5aab42
diff --git a/fs/9p/fid.c b/fs/9p/fid.c
--- a/fs/9p/fid.c
+++ b/fs/9p/fid.c
@@ -1,7 +1,7 @@
 /*
  * V9FS FID Management
  *
- *  Copyright (C) 2005 by Eric Van Hensbergen <ericvh@gmail.com>
+ *  Copyright (C) 2005, 2006 by Eric Van Hensbergen <ericvh@gmail.com>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -57,7 +57,6 @@ int v9fs_fid_insert(struct v9fs_fid *fid
 	}
 
 	fid->uid = current->uid;
-	fid->pid = current->pid;
 	list_add(&fid->list, fid_list);
 	return 0;
 }
@@ -88,7 +87,7 @@ struct v9fs_fid *v9fs_fid_create(struct 
 	new->rdir_fcall = NULL;
 	INIT_LIST_HEAD(&new->list);
 
-		return new;
+	return new;
 }
 
 /**
@@ -104,75 +103,13 @@ void v9fs_fid_destroy(struct v9fs_fid *f
 }
 
 /**
- * v9fs_fid_walk_up - walks from the process current directory
- * 	up to the specified dentry.
- */
-static struct v9fs_fid *v9fs_fid_walk_up(struct dentry *dentry)
-{
-	int fidnum, cfidnum, err;
-	struct v9fs_fid *cfid, *fid;
-	struct dentry *cde;
-	struct v9fs_session_info *v9ses;
-
-	v9ses = v9fs_inode2v9ses(current->fs->pwd->d_inode);
-	cfid = v9fs_fid_lookup(current->fs->pwd);
-	if (cfid == NULL) {
-		dprintk(DEBUG_ERROR, "process cwd doesn't have a fid\n");
-		return ERR_PTR(-ENOENT);
-	}
-
-	cfidnum = cfid->fid;
-	cde = current->fs->pwd;
-	/* TODO: take advantage of multiwalk */
-
-	fidnum = v9fs_get_idpool(&v9ses->fidpool);
-	if (fidnum < 0) {
-		dprintk(DEBUG_ERROR, "could not get a new fid num\n");
-		err = -ENOENT;
-		goto clunk_fid;
-	}
-
-	while (cde != dentry) {
-		if (cde == cde->d_parent) {
-			dprintk(DEBUG_ERROR, "can't find dentry\n");
-			err = -ENOENT;
-			goto clunk_fid;
-		}
-
-		err = v9fs_t_walk(v9ses, cfidnum, fidnum, "..", NULL);
-		if (err < 0) {
-			dprintk(DEBUG_ERROR, "problem walking to parent\n");
-			goto clunk_fid;
-		}
-
-		cfidnum = fidnum;
-		cde = cde->d_parent;
-	}
-
-	fid = v9fs_fid_create(v9ses, fidnum);
-	if (fid) {
-		err = v9fs_fid_insert(fid, dentry);
-		if (err < 0) {
-			kfree(fid);
-			goto clunk_fid;
-		}
-	}
-
-	return fid;
-
-clunk_fid:
-	v9fs_t_clunk(v9ses, fidnum);
-	return ERR_PTR(err);
-}
-
-/**
  * v9fs_fid_lookup - retrieve the right fid from a  particular dentry
  * @dentry: dentry to look for fid in
  * @type: intent of lookup (operation or traversal)
  *
- * search list of fids associated with a dentry for a fid with a matching
- * thread id or uid.  If that fails, look up the dentry's parents to see if you
- * can find a matching fid.
+ * find a fid in the dentry
+ *
+ * TODO: only match fids that have the same uid as current user
  *
  */
 
@@ -187,26 +124,7 @@ struct v9fs_fid *v9fs_fid_lookup(struct 
 		return_fid = list_entry(fid_list->next, struct v9fs_fid, list);
 
 	if (!return_fid) {
-		struct dentry *par = current->fs->pwd->d_parent;
-		int count = 1;
-		while (par != NULL) {
-			if (par == dentry)
-				break;
-			count++;
-			if (par == par->d_parent) {
-				dprintk(DEBUG_ERROR,
-					"got to root without finding dentry\n");
-				break;
-			}
-			par = par->d_parent;
-		}
-
-/* XXX - there may be some duplication we can get rid of */
-		if (par == dentry) {
-			return_fid = v9fs_fid_walk_up(dentry);
-			if (IS_ERR(return_fid))
-				return_fid = NULL;
-		}
+		dprintk(DEBUG_ERROR, "Couldn't find a fid in dentry\n");
 	}
 
 	return return_fid;
diff --git a/fs/9p/fid.h b/fs/9p/fid.h
--- a/fs/9p/fid.h
+++ b/fs/9p/fid.h
@@ -44,7 +44,6 @@ struct v9fs_fid {
 	struct v9fs_fcall *rdir_fcall;
 
 	/* management stuff */
-	pid_t pid;		/* thread associated with this fid */
 	uid_t uid;		/* user associated with this fid */
 
 	/* private data */
diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -397,6 +397,7 @@ v9fs_session_init(struct v9fs_session_in
 	}
 
 	if (v9ses->afid != ~0) {
+		dprintk(DEBUG_ERROR, "afid not equal to ~0\n");
 		if (v9fs_t_clunk(v9ses, v9ses->afid))
 			dprintk(DEBUG_ERROR, "clunk failed\n");
 	}
diff --git a/fs/9p/vfs_dentry.c b/fs/9p/vfs_dentry.c
--- a/fs/9p/vfs_dentry.c
+++ b/fs/9p/vfs_dentry.c
@@ -43,47 +43,18 @@
 #include "fid.h"
 
 /**
- * v9fs_dentry_validate - VFS dcache hook to validate cache
- * @dentry:  dentry that is being validated
- * @nd: path data
+ * v9fs_dentry_delete - called when dentry refcount equals 0
+ * @dentry:  dentry in question
  *
- * dcache really shouldn't be used for 9P2000 as at all due to
- * potential attached semantics to directory traversal (walk).
- *
- * FUTURE: look into how to use dcache to allow multi-stage
- * walks in Plan 9 & potential for better dcache operation which
- * would remain valid for Plan 9 semantics.  Older versions
- * had validation via stat for those interested.  However, since
- * stat has the same approximate overhead as walk there really
- * is no difference.  The only improvement would be from a
- * time-decay cache like NFS has and that undermines the
- * synchronous nature of 9P2000.
+ * By returning 1 here we should remove cacheing of unused 
+ * dentry components.
  *
  */
 
-static int v9fs_dentry_validate(struct dentry *dentry, struct nameidata *nd)
+int v9fs_dentry_delete(struct dentry *dentry)
 {
-	struct dentry *dc = current->fs->pwd;
-
-	dprintk(DEBUG_VFS, "dentry: %s (%p)\n", dentry->d_iname, dentry);
-	if (v9fs_fid_lookup(dentry)) {
-		dprintk(DEBUG_VFS, "VALID\n");
-		return 1;
-	}
-
-	while (dc != NULL) {
-		if (dc == dentry) {
-			dprintk(DEBUG_VFS, "VALID\n");
-			return 1;
-		}
-		if (dc == dc->d_parent)
-			break;
-
-		dc = dc->d_parent;
-	}
-
-	dprintk(DEBUG_VFS, "INVALID\n");
-	return 0;
+	dprintk(DEBUG_VFS, " dentry: %s (%p)\n", dentry->d_iname, dentry);
+	return 1;
 }
 
 /**
@@ -118,6 +89,6 @@ void v9fs_dentry_release(struct dentry *
 }
 
 struct dentry_operations v9fs_dentry_operations = {
-	.d_revalidate = v9fs_dentry_validate,
+	.d_delete = v9fs_dentry_delete,
 	.d_release = v9fs_dentry_release,
 };
