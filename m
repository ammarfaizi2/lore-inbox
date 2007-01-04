Return-Path: <linux-kernel-owner+w=401wt.eu-S965002AbXADSMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965002AbXADSMZ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 13:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964881AbXADSMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 13:12:25 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:55744 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965022AbXADSMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 13:12:21 -0500
Date: Thu, 4 Jan 2007 12:12:15 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH -mm 5/8] user ns: prepare copy_tree, copy_mnt, and their callers to handle errs
Message-ID: <20070104181215.GF11377@sergelap.austin.ibm.com>
References: <20070104180635.GA11377@sergelap.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070104180635.GA11377@sergelap.austin.ibm.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Serge E. Hallyn <serue@us.ibm.com>
Subject: [PATCH -mm 5/8] user ns: prepare copy_tree, copy_mnt, and their callers to handle errs

With shareduserns and non-shareduserns mounts, it will be possible
for clone_mnt to return -EPERM if a namespace tries to bind
mount a non-shareduserns vfsmnt from another user namespace.
But currently they only return NULL, which is interpreted as
-ENOMEM.  Update the callers to handle other errors.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
---
 fs/namespace.c |   20 ++++++++++++--------
 fs/pnode.c     |    5 +++--
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 5da87e2..a4039a3 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -708,8 +708,9 @@ struct vfsmount *copy_tree(struct vfsmou
 		return NULL;
 
 	res = q = clone_mnt(mnt, dentry, flag);
-	if (!q)
-		goto Enomem;
+	if (!q || IS_ERR(q)) {
+		return q;
+	}
 	q->mnt_mountpoint = mnt->mnt_mountpoint;
 
 	p = mnt;
@@ -730,8 +731,9 @@ struct vfsmount *copy_tree(struct vfsmou
 			nd.mnt = q;
 			nd.dentry = p->mnt_mountpoint;
 			q = clone_mnt(p, p->mnt_root, flag);
-			if (!q)
-				goto Enomem;
+			if (!q || IS_ERR(q)) {
+				goto Error;
+			}
 			spin_lock(&vfsmount_lock);
 			list_add_tail(&q->mnt_list, &res->mnt_list);
 			attach_mnt(q, &nd);
@@ -739,7 +741,7 @@ struct vfsmount *copy_tree(struct vfsmou
 		}
 	}
 	return res;
-Enomem:
+Error:
 	if (res) {
 		LIST_HEAD(umount_list);
 		spin_lock(&vfsmount_lock);
@@ -747,7 +749,7 @@ Enomem:
 		spin_unlock(&vfsmount_lock);
 		release_mounts(&umount_list);
 	}
-	return NULL;
+	return q;
 }
 
 /*
@@ -927,8 +929,10 @@ static int do_loopback(struct nameidata 
 	else
 		mnt = clone_mnt(old_nd.mnt, old_nd.dentry, 0);
 
-	if (!mnt)
+	if (!mnt || IS_ERR(mnt)) {
+		err = mnt ? PTR_ERR(mnt) : -ENOMEM;
 		goto out;
+	}
 
 	err = graft_tree(mnt, nd);
 	if (err) {
@@ -1465,7 +1469,7 @@ struct mnt_namespace *dup_mnt_ns(struct 
 	/* First pass: copy the tree topology */
 	new_ns->root = copy_tree(mnt_ns->root, mnt_ns->root->mnt_root,
 					CL_COPY_ALL | CL_EXPIRE);
-	if (!new_ns->root) {
+	if (!new_ns->root || IS_ERR(new_ns->root)) {
 		up_write(&namespace_sem);
 		kfree(new_ns);
 		return NULL;
diff --git a/fs/pnode.c b/fs/pnode.c
index 56aacea..1821c95 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -187,8 +187,9 @@ int propagate_mnt(struct vfsmount *dest_
 
 		source =  get_source(m, prev_dest_mnt, prev_src_mnt, &type);
 
-		if (!(child = copy_tree(source, source->mnt_root, type))) {
-			ret = -ENOMEM;
+		child = copy_tree(source, source->mnt_root, type);
+		if (!child || IS_ERR(child)) {
+			ret = child ? PTR_ERR(child) : -ENOMEM;
 			list_splice(tree_list, tmp_list.prev);
 			goto out;
 		}
-- 
1.4.1

