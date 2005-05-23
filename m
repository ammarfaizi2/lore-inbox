Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261862AbVEWH0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbVEWH0K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 03:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbVEWH0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 03:26:10 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:37816 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261858AbVEWHYo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 03:24:44 -0400
Subject: Re: [RFC][PATCH] rbind across namespaces
From: Ram <linuxram@us.ibm.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, viro@parcelfarce.linux.theplanet.co.uk,
       jamie@shareable.org
In-Reply-To: <E1Da5BO-00027F-00@dorka.pomaz.szeredi.hu>
References: <1116627099.4397.43.camel@localhost>
	 <E1DZNSN-0006cU-00@dorka.pomaz.szeredi.hu>
	 <1116660380.4397.66.camel@localhost>
	 <E1DZP37-0006hH-00@dorka.pomaz.szeredi.hu>
	 <1116665101.4397.71.camel@localhost>
	 <E1DZPzS-0006kw-00@dorka.pomaz.szeredi.hu>
	 <1116670073.4397.77.camel@localhost>
	 <E1DZTmi-0006up-00@dorka.pomaz.szeredi.hu>
	 <1116793554.4397.102.camel@localhost> <1116795059.4397.111.camel@localhost>
	 <E1Da5BO-00027F-00@dorka.pomaz.szeredi.hu>
Content-Type: multipart/mixed; boundary="=-7DSlEeLPNPbycMGCqLvf"
Organization: IBM 
Message-Id: <1116833048.4397.137.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 23 May 2005 00:24:08 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7DSlEeLPNPbycMGCqLvf
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2005-05-22 at 22:08, Miklos Szeredi wrote:
> > The patch failed rbinds in some cases. Fixed it. The enclosed patch
> > has a high chance of being bug free.
> 
> Except not setting mnt_namespace corretly, it does seem to be ok.

yes done. enclosed the patch.

But seems like this patch opens up questions like:

Should mounts/umounts/remounts/pivot_root in foreign namespaces 
be allowed? Probably check_mnt() can simply go, and the correct
semaphores have to be held in each of the functions.

RP

> 
> Miklos

--=-7DSlEeLPNPbycMGCqLvf
Content-Disposition: attachment; filename=rbind_across_namespace5.patch
Content-Type: text/x-patch; name=rbind_across_namespace5.patch
Content-Transfer-Encoding: 7bit

Summary:

Allows rbinds across any two namespaces.  NOTE: currenly bind from foriegn
namespace to current namespace is allowed. This patch now allows:

1. binds/rbinds from any namespace to any other namespace, under the assumption
   that if a process has access to a namespace, it ought to have permission to
   manipulate that namespace. 
2. bind/rbind to detached mounts are disallowed.
3. rbind from detached mount is treated as bind.

The patch incorporates ideas from Miklos and Jamie, and is dependent on
Miklos's "fix race in mark_mounts_for_expiry" patch to function correctly. Also
it depends on Miklos's "fix bind mount from foreign namespace" patch, because
without that patch umounts would fail.

--- /home/linux/views/linux-2.6.12-rc4/fs/namespace.c	2005-05-06 23:22:29.000000000 -0700
+++ linux-2.6.12-rc4/fs/namespace.c	2005-05-23 00:20:39.000000000 -0700
@@ -148,7 +148,7 @@ static struct vfsmount *next_mnt(struct 
 }
 
 static struct vfsmount *
-clone_mnt(struct vfsmount *old, struct dentry *root)
+clone_mnt(struct vfsmount *old, struct dentry *root, struct namespace *ns)
 {
 	struct super_block *sb = old->mnt_sb;
 	struct vfsmount *mnt = alloc_vfsmnt(old->mnt_devname);
@@ -160,7 +160,7 @@ clone_mnt(struct vfsmount *old, struct d
 		mnt->mnt_root = dget(root);
 		mnt->mnt_mountpoint = mnt->mnt_root;
 		mnt->mnt_parent = mnt;
-		mnt->mnt_namespace = old->mnt_namespace;
+		mnt->mnt_namespace = ns;
 
 		/* stick the duplicate mount on the same expiry list
 		 * as the original if that was on one */
@@ -533,13 +533,14 @@ lives_below_in_same_fs(struct dentry *d,
 	}
 }
 
-static struct vfsmount *copy_tree(struct vfsmount *mnt, struct dentry *dentry)
+static struct vfsmount *copy_tree(struct vfsmount *mnt, struct dentry *dentry,
+				  struct namespace *ns)
 {
 	struct vfsmount *res, *p, *q, *r, *s;
 	struct list_head *h;
 	struct nameidata nd;
 
-	res = q = clone_mnt(mnt, dentry);
+	res = q = clone_mnt(mnt, dentry, ns);
 	if (!q)
 		goto Enomem;
 	q->mnt_mountpoint = mnt->mnt_mountpoint;
@@ -558,7 +559,7 @@ static struct vfsmount *copy_tree(struct
 			p = s;
 			nd.mnt = q;
 			nd.dentry = p->mnt_mountpoint;
-			q = clone_mnt(p, p->mnt_root);
+			q = clone_mnt(p, p->mnt_root, ns);
 			if (!q)
 				goto Enomem;
 			spin_lock(&vfsmount_lock);
@@ -616,11 +617,14 @@ out_unlock:
 }
 
 /*
- * do loopback mount.
+ * do loopback mount.  The loopback mount can be done from any namespace to any
+ * other namespace including the current namespace, as long as the task acquired 
+ * rights to manipulate them.
  */
 static int do_loopback(struct nameidata *nd, char *old_name, int recurse)
 {
 	struct nameidata old_nd;
+	struct namespace *mntpt_ns, *old_ns;
 	struct vfsmount *mnt = NULL;
 	int err = mount_is_safe(nd);
 	if (err)
@@ -631,16 +635,58 @@ static int do_loopback(struct nameidata 
 	if (err)
 		return err;
 
-	down_write(&current->namespace->sem);
 	err = -EINVAL;
-	if (check_mnt(nd->mnt) && (!recurse || check_mnt(old_nd.mnt))) {
-		err = -ENOMEM;
-		if (recurse)
-			mnt = copy_tree(old_nd.mnt, old_nd.dentry);
-		else
-			mnt = clone_mnt(old_nd.mnt, old_nd.dentry);
+	spin_lock(&vfsmount_lock);
+
+	/* 
+	 * Disallow bind/rbind mounts to detached mounts and treat rbind from
+	 * detached mount as normal bind.
+	 */
+	mntpt_ns = nd->mnt->mnt_namespace;
+	old_ns = old_nd.mnt->mnt_namespace;
+	if (!mntpt_ns || !mntpt_ns->root) {
+		spin_unlock(&vfsmount_lock);
+		goto out;
 	}
 
+	if (!old_ns || !old_ns->root)
+		recurse = 0;
+
+	get_namespace(mntpt_ns);
+	if (recurse && old_ns != mntpt_ns)
+		get_namespace(old_ns);
+
+	spin_unlock(&vfsmount_lock);
+
+	/* 
+	 * make sure we don't race with some other thread manipulating the
+	 * namespaces.
+	 */
+	if (recurse && (old_ns < mntpt_ns))
+		down_write(&old_ns->sem);
+	down_write(&mntpt_ns->sem);
+	if (recurse && (old_ns > mntpt_ns))
+		down_write(&old_ns->sem);
+
+
+	/* 
+	 * well... mounts might have detached while we acquired
+	 * the semaphores. Revalidate that the destination mount 
+	 * is still attached. 
+	 */
+	if (!nd->mnt->mnt_namespace)
+		goto error_out;
+
+	/* 
+	 * and if the source mount is detached, than just do
+	 * a bind, instead of a rbind
+	 */
+	err = -ENOMEM;
+	if (recurse && old_nd.mnt->mnt_namespace)
+		mnt = copy_tree(old_nd.mnt, old_nd.dentry, mntpt_ns);
+	else
+		mnt = clone_mnt(old_nd.mnt, old_nd.dentry, mntpt_ns);
+
 	if (mnt) {
 		/* stop bind mounts from expiring */
 		spin_lock(&vfsmount_lock);
@@ -656,7 +702,15 @@ static int do_loopback(struct nameidata 
 			mntput(mnt);
 	}
 
-	up_write(&current->namespace->sem);
+error_out:
+	up_write(&mntpt_ns->sem);
+	if (recurse && (old_ns != mntpt_ns)) {
+		up_write(&old_ns->sem);
+		put_namespace(old_ns);
+	}
+	put_namespace(mntpt_ns);
+
+out:
 	path_release(&old_nd);
 	return err;
 }
@@ -1090,7 +1144,8 @@ int copy_namespace(int flags, struct tas
 
 	down_write(&tsk->namespace->sem);
 	/* First pass: copy the tree topology */
-	new_ns->root = copy_tree(namespace->root, namespace->root->mnt_root);
+	new_ns->root = copy_tree(namespace->root, namespace->root->mnt_root, 
+				new_ns);
 	if (!new_ns->root) {
 		up_write(&tsk->namespace->sem);
 		kfree(new_ns);
@@ -1108,7 +1163,6 @@ int copy_namespace(int flags, struct tas
 	p = namespace->root;
 	q = new_ns->root;
 	while (p) {
-		q->mnt_namespace = new_ns;
 		if (fs) {
 			if (p == fs->rootmnt) {
 				rootmnt = p;

--=-7DSlEeLPNPbycMGCqLvf--

